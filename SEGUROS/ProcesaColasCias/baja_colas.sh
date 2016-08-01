#!/bin/bash

#Este shell parte tantos procesos como registros tenga el archivo total_tablas_pid.txt
#Cada Proceso lee de la tabla indicada en total_tablas_pid.txt y gatilla el flujo que este dentro de
#la data en la tabla indicada.
#Ejemplo se guarda en data TX[]=12700### esto se almacena en hexadecimal para evitar la codificacion

for PID1 in $(/bin/ps x|/bin/grep -v grep|/bin/grep "confirma_" | awk {' print $1;'}  2>&1)
do
	echo "PID=$PID1"
	if [ $PID1 -gt 0 ]
	then
           	# It is running in this case so we do nothing.
                echo "Bajando $PID1"
		/bin/kill -9 $PID1
	fi
done
#Desconecta hilos pegados de los procesos que sacan de las colas
/usr/bin/psql dmotor -At -F';' -c "select pg_terminate_backend(pid) from pg_stat_activity where state='idle' and usename='confirma' "
exit 1

