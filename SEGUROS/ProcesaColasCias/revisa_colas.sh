#!/bin/bash
#Este shell parte tantos procesos como registros tenga el archivo total_tablas_pid.txt
#Cada Proceso lee de la tabla indicada en total_tablas_pid.txt y gatilla el flujo que este dentro de
#la data en la tabla indicada.
#Ejemplo se guarda en data TX[]=12700### esto se almacena en hexadecimal para evitar la codificacion
I=1

for tablas in $(/usr/bin/psql dmotor -At -F';' -c "select distinct nemo from cias_seguros")
do
	#echo $I "- TABLA=$tablas"
	#/usr/bin/psql dmotor -At -F';' -c "update confirma_$tablas set reintentos=4,xml_in=put_campo(xml_in,'SQLINPUT','') where reintentos=5"
	#cho $tablas
        /bin/ps -ef|/bin/grep -v grep|/bin/grep "$tablas " | /bin/grep Procesa_ColasCias >/dev/null 2>&1
        case "$?" in
           0)
           # It is running in this case so we do nothing.
                echo "$tablas `date  +'%H:%M:%S'` script corriendo"
           ;;
          1)
		#sp_borra_reg_cola Sp que se llama si el flujo ejecutado contesta 200 OK en el tag RESPUESTA (Borra el registro de la tabla)
		#sp_reintentos_reg si falla el flujo se aumentan los reintentos del registro
		#sp_consume_cola Query que obtiene los datos que ejecutara este proceso
		echo "Inicia $tablas"
		cd /home/motor/SEGUROS/ProcesaColasCias/
		#Limpio el LOG si quedo grabado
                /home/motor/SEGUROS/ProcesaColasCias/Procesa_ColasCias portdb=9000 conexionbd=INTERNA usuario_bd="confirma" clave_bd="" log=1 ip_conexion_bd=127.0.0.1 basedatos=dmotor port_postgres=5432 tabla=$tablas id=$I prefijo_log=$tablas SP_REINTENTOS_REG="-" SP_BORRA_REG_COLA="-" sp_consume_cola="select id,put_campo(put_campo(xml_in,'FECHA_INGRESO_COLA',fecha::varchar),'_LOG_','') as data from confirma_$tablas where reintentos<5 order by id limit 10" >/dev/null &

		#/home/motor/SEGUROS/ProcesaColasCias/Procesa_ColasCias portdb=9000 conexionbd=INTERNA usuario_bd="confirma" clave_bd="" log=0 ip_conexion_bd=127.0.0.1 basedatos=dmotor port_postgres=5432 tabla=$tablas id=$I prefijo_log=$tablas SP_REINTENTOS_REG="-" SP_BORRA_REG_COLA="-" sp_consume_cola="select id,xml_in as data from confirma_$tablas where reintentos<5 order by id limit 10" >/dev/null &

           ;;
        esac
	I=`expr $I + 1`
done
exit 1

