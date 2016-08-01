#!/bin/bash

#cd /home/motor/ProcesaColasMotor

MAIL="fernando.arancibia@acepta.com,jaime.cossio@acepta.com"
TOTAL=0;
PROMEDIO_TOTAL=0;
MALOS=0;
HORA=`/bin/date +%H%M`
DIA=`/bin/date +%Y%m%d`
#echo $FECHA_ACTUAL
#echo $HORA >> /tmp/hora.txt
for tablas in $(/usr/bin/psql dmotor -At -F';' -c "select descripcion from colas_finaciadores")
do
        I=`/usr/bin/psql dmotor -At -F';' -c "select count(*),estado,case when reintentos>2 then 'MALA' else 'OK' end from confirma_bono_$tablas group by 2,3"`
	DATA=($I)
	H=0;
	STR=${DATA[$H]}
	TOT=$(echo $STR | cut -f 1 -d';')
	ESTADO=$(echo $STR | cut -f 2 -d';')
	REINTENTO=$(echo $STR | cut -f 3 -d';')
	TOTAL=`expr $TOT + $TOTAL`
	TOTAL_TABLA=0
	#echo $ESTADO,$TOT
	echo -e "Financiador $tablas \tTotal=$TOT \tESTADO=$ESTADO \tREINTENTO=$REINTENTO"
done

echo "Total Pendientes de Confirmacion $TOTAL"

