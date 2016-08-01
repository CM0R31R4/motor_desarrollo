#!/bin/bash

for tablas in $(/usr/bin/psql dmotor -At -F';' -c "select distinct nemo from cias_seguros")
do
	echo "Baja Reintentos $tablas"
        /usr/bin/psql -At -F';' -c "update confirma_$tablas set reintentos=4 where reintentos>=5 " dmotor
	#Limpia las tablas
	/usr/bin/psql -At -F';' -c "vacuum full confirma_$tablas"
	/usr/bin/psql -At -F';' -c "analyze confirma_$tablas"
done

