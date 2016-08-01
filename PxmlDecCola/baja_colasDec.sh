#!/bin/bash

# Este shell parte tantos procesos como registros tenga el archivo total_tablas_pid.txt
# Cada Proceso lee de la tabla indicada en total_tablas_pid.txt y gatilla el flujo que este dentro de
# la data en la tabla indicada.
# Ejemplo se guarda en data TX[]=7001### esto se almacena en hexadecimal para evitar la codificacion.

for PID1 in $(/bin/ps x|/bin/grep -v grep|/bin/grep "actoVentaXmlCola" | awk {' print $1;'}  2>&1)
do
	echo "PID Cola Dec = $PID1"
	if [ $PID1 -gt 0 ] 
	then
        	echo "Bajando Cola Dec : $PID1"
		/bin/kill -9 $PID1
	else
		echo "No hay nada en cola..."
	fi
done
#Desconecta hilos pegados de los procesos que sacan de las colas
/usr/bin/psql dmotor -At -F';' -c "select pg_terminate_backend(pid) from pg_stat_activity where state='idle' and usename='confirma' "
exit 1

