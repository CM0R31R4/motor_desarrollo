#!/bin/bash

for tablas in $(/usr/bin/psql dmotor -At -F';' -c "select distinct descripcion from colas_finaciadores")
do
	echo "Baja Reintentos $tablas"
        /usr/bin/psql -At -F';' -c "update confirma_bono_$tablas set reintentos=4 where reintentos>=5 " dmotor
	#Limpia las tablas
	/usr/bin/psql -At -F';' -c "vacuum full confirma_bono_$tablas"
	/usr/bin/psql -At -F';' -c "analyze confirma_bono_$tablas"
done

