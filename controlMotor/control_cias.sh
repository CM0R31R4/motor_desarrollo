#!/bin/bash

DIA=$(date +%Y%m%d)

#Borra la tabla de control
/usr/bin/psql dmotor -At -F';' -c "truncate table control_cias"
FECHA_INI=$(/usr/bin/psql dmotor -At -F';' -c "select date_trunc('minute',now()-interval '5 minutes')")

#Inserta todas las cias
/usr/bin/psql dmotor -At -F';' -c "insert into control_cias (codigo_cia,tx,fecha_ini,fecha_fin,total_ok_5_min,total_timeout_5_min,total_rechazo_5_min,total_en_cola) select distinct 'CIA_'||codigo,tx,'$FECHA_INI'::timestamp,now(),0,0,0,0 from cias_seguros" 
#Inserta todos los Financiadores
/usr/bin/psql dmotor -At -F';' -c "insert into control_cias (codigo_cia,tx,fecha_ini,fecha_fin,total_ok_5_min,total_timeout_5_min,total_rechazo_5_min,total_en_cola) select distinct 'FIN_'||financiador::varchar,'Todas','$FECHA_INI'::timestamp,now(),0,0,0,0 from colas_finaciadores" 


#Obtiene el total de las colas de cada cia
for tablas in $(/usr/bin/psql dmotor -At -F';' -c "select distinct nemo from cias_seguros")
do
	#Actualiza el total de 
	/usr/bin/psql -At -F';' -c "update control_cias set total_en_cola=a.total_en_cola from (select count(*) as total_en_cola,codigo_cia,tx from confirma_$tablas group by 2,3) a where a.codigo_cia=split_part(control_cias.codigo_cia,'_',2) and a.tx=control_cias.tx" dmotor
	echo $tablas
done

#Actualizo los datos de los ultimos 5 minutos
for campo in $(/usr/bin/psql dmotor -At -F';' -c "select count(*) as total,tx,'CIA_'||codigo_cia::varchar,estado from tx_cias where dia=$DIA and fecha_ingreso>='$FECHA_INI'::timestamp group by 2,3,4")
do
	#echo $campo
	TOTAL=$(echo $campo | cut -f 1 -d';')
	TX=$(echo $campo | cut -f 2 -d';')
	CODIGO_CIA=$(echo $campo | cut -f 3 -d';')
	ESTADO=$(echo $campo | cut -f 4 -d';')
	#echo $TOTAL,$TX,$CODIGO_CIA,$ESTADO
	
	if [ "$ESTADO" = "CIA_OK" ]; then
		/usr/bin/psql -At -F';' -c "update control_cias set total_ok_5_min=$TOTAL where codigo_cia='$CODIGO_CIA' and tx='$TX' " dmotor
	elif [ "$ESTADO" = "OK" ]; then
		/usr/bin/psql -At -F';' -c "update control_cias set total_ok_5_min=$TOTAL where codigo_cia='$CODIGO_CIA' and tx='$TX' " dmotor
	elif [ "$ESTADO" = "CIA_ERROR" ]; then
		/usr/bin/psql -At -F';' -c "update control_cias set total_timeout_5_min=$TOTAL where codigo_cia='$CODIGO_CIA' and tx='$TX' " dmotor
	elif [ "$ESTADO" = "CIA_RECHAZO" ]; then
		/usr/bin/psql -At -F';' -c "update control_cias set total_rechazo_5_min=$TOTAL where codigo_cia='$CODIGO_CIA' and tx='$TX' " dmotor
	fi
done

#Para los financiadores por ahora el dia entero
FECHA_INI=$(/usr/bin/psql dmotor -At -F';' -c "select date_trunc('day',now())")
#Actualizo los datos de los Financiadores
for campo in $(/usr/bin/psql dmotor -At -F';' -c "select count(*) as total,'FIN_'||cod_fin::varchar,estado from tx_bono3 where fecha_in_tx>='$FECHA_INI'::timestamp group by 2,3")
do
	#echo $campo
	TOTAL=$(echo $campo | cut -f 1 -d';')
	CODIGO_FIN=$(echo $campo | cut -f 2 -d';')
	ESTADO=$(echo $campo | cut -f 3 -d';')
	echo $TOTAL,$TX,$CODIGO_FIN,$ESTADO
	if [ "$ESTADO" = "TERMINADO_OK" ]; then
		/usr/bin/psql -At -F';' -c "update control_cias set total_ok_5_min=coalesce(total_ok_5_min,0)+$TOTAL where codigo_cia='$CODIGO_FIN' " dmotor
	elif [ "$ESTADO" = "EN_PROCESO" ]; then
		/usr/bin/psql -At -F';' -c "update control_cias set total_ok_5_min=coalesce(total_ok_5_min,0)+$TOTAL where codigo_cia='$CODIGO_FIN'" dmotor
	elif [ "$ESTADO" = "FALLA_API" ]; then
		/usr/bin/psql -At -F';' -c "update control_cias set total_timeout_5_min=coalesce(total_timeout_5_min,0)+$TOTAL where codigo_cia='$CODIGO_FIN' " dmotor
	fi
done

#Obtiene el total de las colas de los financiadores
for tablas in $(/usr/bin/psql dmotor -At -F';' -c "select distinct descripcion from colas_finaciadores")
do
	#Actualiza el total de 
	echo $tablas
	/usr/bin/psql -At -F';' -c "update control_cias set total_en_cola=a.total_en_cola from (select count(*) as total_en_cola,financiador from confirma_bono_$tablas group by 2) a where a.financiador::varchar=split_part(control_cias.codigo_cia,'_',2) " dmotor
	echo $tablas
done
