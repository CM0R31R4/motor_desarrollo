#!/bin/bash
# Este shell parte tantos procesos como registros tenga el archivo total_tablas_pid.txt
# Cada Proceso lee de la tabla indicada en total_tablas_pid.txt y gatilla el flujo que este dentro de
# la data en la tabla indicada.

# Ejemplo: se guarda en data TX[]=7001### 
# Esto se almacena en hexadecimal para evitar la codificacion

        /bin/ps -ef|/bin/grep -v grep|/bin/grep "actoVentaXmlCola " | /bin/grep Procesa_ColasDec2 >/dev/null 2>&1
        case "$?" in
           0)
           # Si ya esta corriendo, entonces hace nada.
                echo "actoVentaXml Cola Procesador 2 `date  +'%H:%M:%S'` Script ColasDec corriendo..."
           ;;
          1)
		#SP_BORRA_REG_COLA que se llama si el flujo ejecutado contesta 200 OK en el tag RESPUESTA (Borra el registro de la tabla).
		#SP_REINTENTOS_REG si falla el flujo se aumentan los reintentos del registro.
		#sp_consume_cola Query que obtiene los datos que ejecutara este proceso.
		echo "Inicia actoVentaXmlCola Procesador 2."
		cd /home/motor/PxmlDecCola/
		#TODO Este shell solo procesa estados "SOLO_PERCONA"

		/home/motor/PxmlDecCola/Procesa_ColasDec2 portdb=9000 conexionbd=INTERNA usuario_bd="confirma" clave_bd="" log=1 ip_conexion_bd=127.0.0.1 basedatos=dmotor port_postgres=5432 tabla="actoVentaXmlCola" id="1" prefijo_log="XmlColaDec_P2" SP_REINTENTOS_REG="-" SP_BORRA_REG_COLA="-" sp_consume_cola="SELECT id, xml as data FROM tx_actoventaxml WHERE id_cola in (3,4) and reintentos < 3 ORDER BY id limit 10" >/dev/null &
		
		#/home/motor/PxmlDecCola/Procesa_ColasDec portdb=9000 conexionbd=INTERNA usuario_bd="confirma" clave_bd="" log=1 ip_conexion_bd=127.0.0.1 basedatos=dmotor port_postgres=5432 tabla="actoVentaXmlCola" id="1" prefijo_log="XmlColaDec" SP_REINTENTOS_REG="-" SP_BORRA_REG_COLA="-" sp_consume_cola="SELECT id, xml as data FROM tx_actoventaxmlcola ORDER BY id limit 10" >/dev/null &
           ;;
        esac
exit 1

