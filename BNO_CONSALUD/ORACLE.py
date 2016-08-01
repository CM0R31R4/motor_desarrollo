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

def restart_program():
    """Restarts the current program.
    Note: this function does not return. Any cleanup action (like
    saving data) must be done before calling this function."""
    python = sys.executable
    os.execl(python, python, * sys.argv)


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
	
	#Comentado porque no opera con CONSALUD
	#self.cn.cancel()
 	#log("Consulta Cancelada")
 	log("Restart Program")
	restart_program()

    def close_ora(self):
 	log("Inicio Close ORA")
	self.cn.close()
 	log("Oracle Cerrado")
	

    def sp_execcall(self, sp_req):
	try:
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

	except cx_Oracle.DatabaseError, exc:
	    #Cancelo Timeout
	    t.cancel()
	    error, = exc.args
	    #Retorna una tupla que contiene un diccionario
	    log("Error Oracle",error.message,error.code)
	    return json.dumps({ 'ora-err': error.code, 'ora-msg': error.message, 'API_ERROR' : error.code, 'API_CODRESPUESTA' : "2", 'API_TIPO' : "ORACLE", 'API_DESCRIPCION_ERROR' : error.message, 'xx_final_xx' :"**fin**" } , sort_keys=True)
	#Si hay otro error
	except:
	    #Cancelo Timeout
	    t.cancel()
            return "REINTENTE"

class ReusingTCPServer(SocketServer.TCPServer):
    def server_bind(self):
        self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.socket.bind(self.server_address)

def log(*args):
    msg = StringIO()
    msg.write(time.strftime("%Y-%m-%d %H:%M:%S (")+PORT+")")
    for arg in args:
	msg.write(" ")
	if type(arg) is str:
	    msg.write(arg)
	else:
	    msg.write(repr(arg))
    msg.write("\n")
    #sys.stdout.write(msg.getvalue())
    #sys.stdout.flush()
    #Escribimos archivo de log
    f=open(time.strftime("%Y%m%d")+"_PYT.LOG","a+")
    #f=open(LOG+"_"+time.strftime("%Y%m%d")+".LOG","a+")
    #f=open("PY_"+time.strftime("%Y%m%d")+".LOG","a+")
    f.write(msg.getvalue());
    f.close();

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

if __name__ == "__main__":
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

if __name__ == "__main__2":
    o = OracleInterface('IMEDCON/imedcon@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=172.20.2.204)(PORT=1522))(CONNECT_DATA=(SID=TATESA)))')
    print o.sp_execcall('''
    ["IMEDSOF.CONBENCERTIF_PKG.CONBENCERTIF", [
	"$o$STRING",
	71,
	"0015587397-3",
	"2013-05-02",
	"$o$STRING",
	"$o$STRING",
	"$o$STRING",
	"$o$STRING",
	"$o$STRING",
	"$o$STRING",
	"$o$STRING",
	"$o$STRING",
	"$o$STRING",
	"$o$STRING",
	"$o$STRING",
	"$o$STRING",
	"$o$STRING",
	"$o$STRING",
	"$o$STRING",
	"$o$STRING",
	"$o$NUMBER",
	"$o$STRING[10]",
	"$o$STRING[10]"
    ]]
''')
