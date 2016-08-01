#!/usr/bin/python

import socket
import os, re
import simplejson as json
import sys
import SocketServer
import time
import threading
from cStringIO import StringIO


if os.environ.get('LD_LIBRARY_PATH', '').find('/home/motor/instantclient_11_2') < 0:
    print "ADVERTENCIA: ejecute: export LD_LIBRARY_PATH=/home/motor/instantclient_11_2"
    sys.exit(1)

# --------------------------------------------------------------------------------------

import cx_Oracle

class OracleInterface:
    def __init__(self, dsn):
	# IMEDCON/imedcon@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=172.20.2.204)(PORT=1522))(CONNECT_DATA=(SID=TATESA)))
	self.user, self.password, self.server = re.findall("([^/]+)/([^@]+)@(.*)", dsn)[0]
   	try: 
		self.cn = cx_Oracle.connect(self.user, self.password, self.server)
		self.cr = self.cn.cursor()
	except cx_Oracle.DatabaseError, exc:
    		log("cx_Oracle= Sin Conexion Oracle");

    def oraout(self, out_desc):
	type_name = out_desc[3:]
	array_size = 0
	if type_name[-1] == ']':
	    type_name, array_size = type_name[:-1].split('[')
	    array_size = int(array_size)
	type_obj = getattr(cx_Oracle, type_name)
	if array_size:
	    return self.cr.arrayvar(type_obj, array_size)
	else:
	    return self.cr.var(type_obj)

    def timeout_ora(self):
 	log("Timeout en Consulta ",TIMEOUT)
	#Cierra el Cursor
	#self.cr.close()
 	#log("Cursor Cerrado")
	#Cancela la Consulta
	self.cn.cancel()
 	log("Consulta Cancelada")

    def close_ora(self):
 	log("Inicio Close ORA")
	self.cn.close()
 	log("Oracle Cerrado")
	

    def sp_execcall(self, sp_req):
	    # '["CONENROLA_PKG.CONENROLA", ["$o$STRING", 88, "27", "19", "$o$STRING", "$o$STRING"]]'
	    sp_name, sp_args = tuple(json.loads(sp_req))
	    sp_outs = []
	    idx = 0
	    #Declaro el TIMEOUT. Viene como parametro del ./sube
	    t = threading.Timer(int(TIMEOUT),self.timeout_ora)
            log("Parte el TimeOut:", TIMEOUT)
	    t.start()
	    for i in sp_args:
		if type(i) == str and i[:3] == '$o$':
		    sp_outs.append(idx)
		idx += 1
	    sp_args = [ (self.oraout(i) if type(i) == str and i[:3] == '$o$' else i) for i in sp_args ]
	    #log("calling: ", sp_name)
            #log("args: ", repr(sp_args))
	    
	    #Llamada al SP. Parseo de la respuesta 
	    log("Exec Callproc: ",sp_name);
	    sp_result = self.cr.callproc(sp_name, sp_args)
	    final_result = []
	    for n in sp_outs:
		final_result.append(sp_result[n])
	    t.cancel()
	    log("Paso 1")
	    
	    #Carga result con orden alfabetico
	    return json.dumps({'result': final_result, 'API_CODRESPUESTA' : "1", 'API_TIPO' : "ORACLE", 'xx_final_xx' :"**fin**"  }, sort_keys=True)


class ReusingTCPServer(SocketServer.TCPServer):
    def server_bind(self):
        self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.socket.bind(self.server_address)

def log(*args):
    print args

class DBRequestHandler(SocketServer.StreamRequestHandler):
    def handle(self):
	global ORACLE
	req = StringIO()
	cr = False
	while 1:
	    line = self.rfile.readline()
	    if line == '\n': break
	    if line == '\r\n':
	        cr = True
	        break
	    req.write(line)
	req = req.getvalue()
	log("REQ ", repr(req))
	if REINTENTOS == "1":
		reintentos=2
	else:
		reintentos=3
	for i in range(1,reintentos):
		#Llama al Oracle
		log("Intento Numero",i)
		resp = ORACLE.sp_execcall(req)
		#Si fallo el Oracle, intento reconectar, sino exit
		if resp == "REINTENTE" or "ora-msg" in resp:
			try:
				log("Intento ReConexion ORA")
				try:
					ORACLE.cn.close()
				except:
					log("No se logro cerrar la ORACLE.cn.close")
					pass
				log("Connect")
		       	        ORACLE.cn = cx_Oracle.connect(ORACLE.user, ORACLE.password, ORACLE.server)
				#log("Cursor")
				ORACLE.cr = ORACLE.cn.cursor()
				log("Re-Conectado OK")
			except:
				#Termino la ejecucion
				log("Falla Reconexion, Contesto Error")
				#Solo cambio la respuesta si la respuesta de sp viene con REINTENTE
				if resp == "REINTENTE":
	   				resp=json.dumps({ 'ora-err': "0", 'ora-msg': "Falla Oracle", 'API_ERROR' : "2", 'API_CODRESPUESTA' : "2", 'API_TIPO' : "ORACLE", 'API_DESCRIPCION_ERROR' : "Conexion Oracle No Establecida", 'xx_final_xx' :"**fin**" } , sort_keys=True)
					
				break
		else:
			#Si la respuesta en correcta sigo ejecucion
			break
	resp = resp.rstrip("\n") + "\n\n"
	if cr:
    		resp = resp.replace('\n', '\r\n')
	log("RESP ", repr(resp))
	#Respondo Socket
	self.wfile.write(resp)
	self.wfile.flush()

if __name__ == "__main__2":
    args = tuple(sys.argv[1:])
    #Recibe 4 argumentos/parametros 	
    if len(args) != 7:
	print>>sys.stderr, """Uso: %(cmd)s <server_host> <server_port> <target_oracle_dsn> <nombre_log> <Num_Reintentos> <timeout> <modulo>

    ej: %(cmd)s localhost 8071 'IMEDCON/imedcon@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=172.20.2.204)(PORT=1522))(CONNECT_DATA=(SID=TATESA)))'

""" % {'cmd': sys.argv[0]}
	sys.exit(1)
    HOST, PORT, DSN, LOG , REINTENTOS, TIMEOUT , MODULO = args
    
    #Reutiliza la Conexion.
    server = ReusingTCPServer((HOST, int(PORT)), DBRequestHandler)
    #Nueva Conexion
    ORACLE = OracleInterface(DSN)
	
    # Activate the server; this will keep running until you
    # interrupt the program with Ctrl-C
    
    log("Starting server loop...")
    log("Listening at %s:%s" % (HOST, PORT))
    log("Database:", DSN)
    log("Modulo=%s -- TimeOut=%s -- Reintentos=%s" % (MODULO, TIMEOUT, REINTENTOS))
    
    #log("Reintentos:",REINTENTOS)
    #log("Timeout:",TIMEOUT)
    #log("Modulo:",MODULO)
    
    try:
	server.serve_forever()
    except KeyboardInterrupt, e:
	log("Stopped.")

if __name__ == "__main__":
    TIMEOUT=100
    PORT=1
    o = OracleInterface('usr_imed/076imed@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=192.1.1.11)(PORT=1521))(CONNECT_DATA=(SID=prod)))')
    print o.sp_execcall('''
	["ADMIMED.FNDVALORVARI_PKG.FNDVALORVARI", [ "$o$STRING", 76, "99598070", "73578", "0" , "0099598070-3", "0000000000-0", "", "0000000000-0", "0004915541-7", "N", "", "0", "N", "0000301045|  |0301045        |N|01|000000000000|0000302023|  |0302023        |N|01|000000000000|0000307011|  |0307011        |N|01|000000000000|0000302075|  |0302075        |N|01|000000000000|", "", "", "", "", "","", "4", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$STRING", "$o$NUMBER[40]", "$o$NUMBER[40]", "$o$NUMBER[40]", "$o$STRING[40]", "$o$NUMBER[40]", "$o$NUMBER[40]", "$o$NUMBER[40]", "$o$NUMBER[40]", "$o$NUMBER[40]", "$o$NUMBER[40]", "$o$NUMBER[40]", "$o$NUMBER[40]", "$o$NUMBER[40]", "$o$NUMBER[40]" ]]
''')
