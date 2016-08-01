#!/bin/bash

#cd /home/motor/ProcesaColasCias

MAIL="epf_int@acepta.com,fernando.arancibia@acepta.com,pedro.cortes@acepta.com"
#MAIL="fernando.arancibia@acepta.com,pedro.cortes@acepta.com"
TOTAL=0;
PROMEDIO_TOTAL=0;
MALOS=0;
HORA=`/bin/date +%H%M`
DIA=`/bin/date +%Y%m%d`
#echo $FECHA_ACTUAL
#echo $HORA >> /tmp/hora.txt
for tablas in $(/usr/bin/psql dmotor -At -F';' -c "select distinct nemo from cias_seguros")
do
        I=`/usr/bin/psql -At -F';' -c "select count(*),estado,case when reintentos>2 then 'MALA' else 'OK' end from confirma_$tablas group by 2,3" dmotor`
	DATA=($I)
	H=0;
	STR=${DATA[$H]}
	TOT=$(echo $STR | cut -f 1 -d';')
	ESTADO=$(echo $STR | cut -f 2 -d';')
	REINTENTO=$(echo $STR | cut -f 3 -d';')
	TOTAL=`expr $TOT + $TOTAL`
	TOTAL_TABLA=0
	#echo $ESTADO,$TOT
	echo -e "Total=$TOT ESTADO=$ESTADO REINTENTO=$REINTENTO $tablas"
done

echo "Total Pendientes de Confirmacion $TOTAL"
exit 1

	while  [ ${#TOT} -gt 0 ]
	do
		#echo $TX,$TOT,$PROMEDIO
		if [ $TX -eq 30 ]; then
        		TOTAL_BOLETAS=`expr $TOT + $TOTAL_BOLETAS`
		else
        		TOTAL=`expr $TOT + $TOTAL`
		fi;
		TOTAL_TABLA=`expr $TOTAL_TABLA + $TOT`
		H=`expr $H + 1`
		PROMEDIO_TOTAL=`echo "$PROMEDIO * $TOT + $PROMEDIO_TOTAL" | bc -l`
		#echo $PROMEDIO_TOTAL
		STR=${DATA[$H]}
		TOT=$(echo $STR | cut -f 1 -d';')
		TX=$(echo $STR | cut -f 2 -d';')
		PROMEDIO=$(echo $STR | cut -f 3 -d';')
	done
        J=`/usr/bin/psql -At -F';' -c "select count(*) from $tablas where reintentos>=50" dmotor`
        MALOS=`expr $J + $MALOS`
        echo "Tabla $tablas Total=$TOTAL_TABLA Malos=$J"
done
exit 1

