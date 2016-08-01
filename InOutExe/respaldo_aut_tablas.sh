#!/bin/bash
cd /home/motor/InOutExe/

#Base de Datos.
BASE="dmotor"

##############################################################################

#/usr/bin/psql $BASE -c "drop table tablas_respaldo;
#create table tablas_respaldo(
#        tab_origen      varchar(50),    -- Nombre de la tabla a respaldar.
#        tab_destino     varchar(50),    -- Nombre de tabla de destino del respaldo.
#        estado_resp     integer         -- 0 = Inactivo | 1 = Activo
#);

#create index tablas_respaldo_01 on tablas_respaldo (tab_origen);"

#/usr/bin/psql $BASE -c "insert into tablas_respaldo values('tx_bono3', 'historico_tx_bono3', 0);"
#/usr/bin/psql $BASE -c "insert into tablas_respaldo values('tx_cias', 'historico_tx_cias', 0);"
#/usr/bin/psql $BASE -c "insert into tablas_respaldo values('respaldo_envbonis', 'historico_envbonis', 0);"
#/usr/bin/psql $BASE -c "insert into tablas_respaldo values('respaldo_cia', 'historico_cia', 0);"


##############################################################################

#Directorio de Respaldo.
DIRECTORIO="/home/motor/InOutExe/Respaldo"

#Fecha para formar el nombre del archivo.
DATE_FILE=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP -INTERVAL '0 days','YYYY-MM-DD');" $BASE`;

#Fechas de Inicio y Termino para respaldar.
DATE=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP -INTERVAL '0 days','YYYY-MM-DD');" $BASE`;
DATE_INI=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP -INTERVAL '7 days','YYYY-MM-DD');" $BASE`;

#Mail destinatario del reporte.
MAIL="claudio.moreira@acepta.com"
#MAIL="jaime.cossio@acepta.com"

#Consulta por registros a respaldar desde tabla_respaldos.
REG=`/usr/bin/psql -At -F';' -c "SELECT tab_origen, tab_destino, estado_resp::varchar FROM tablas_respaldo WHERE estado_resp = 1;" $BASE`;

DATA=($REG)
I=0;
STR=${DATA[$I]}
TAB_ORIGEN=$(echo $STR | cut -f 1 -d';')
TAB_DESTINO=$(echo $STR | cut -f 2 -d';')
RESPALDA=$(echo $STR | cut -f 3 -d';')

#Busca registros con estado en 1 para respaldar. Si el estado es 0, entonces no hace nada.
while [ ${#RESPALDA} -gt 0 ]
do
	#Arma nombre para archivo de respaldo y log.
	FILE=$DIRECTORIO"/"$TAB_DESTINO"_"$DATE_FILE".dump"
	LOG=$DIRECTORIO"/log_"$TAB_DESTINO"_"$DATE_FILE".txt"	

	#Construye condicion where segun la tabla de origen.
	#Esto se debe revisar cada vez que se agrega una tabla para respaldar.
	case $TAB_ORIGEN in
		"tx_bono3") 
			WHERE="WHERE fecha_in_tx >= '$DATE_INI' AND fecha_in_tx <= '$DATE' AND rut_benef <> '0000000001-9'"
                ;;
                "tx_cias") 
			WHERE="WHERE tiempo_ini_cia >= '$DATE_INI' AND tiempo_ini_cia <= '$DATE'"
                ;;
                "respaldo_cia") 
			WHERE="WHERE fecha >= '$DATE_INI' AND fecha <= '$DATE'"
                ;;
                "respaldo_envbonis") 
			WHERE="WHERE fecha >= '$DATE_INI' AND fecha <= '$DATE'"
                ;;
		#"tx_bono3_test") 
		#	WHERE="WHERE fecha_in_tx >= '$DATE_INI' AND fecha_in_tx <= '$DATE' AND rut_benef <> '0000000001-9'"
		#;;
		#"tx_cias_test") 
		#	WHERE="WHERE tiempo_ini_cia >= '$DATE_INI' AND tiempo_ini_cia <= '$DATE'"
		#;;
		#"respaldo_cia_test") 
		#	WHERE="WHERE fecha >= '$DATE_INI' AND fecha <= '$DATE'"
		#;;
		#"respaldo_envbonis_test") 
		#	WHERE="WHERE fecha >= '$DATE_INI' AND fecha <= '$DATE'"
		#;;
		*)
			echo "======================================================================"
			echo "Error en la estructura de la consulta. Revisar." 
			echo "======================================================================" >>$LOG
			echo "Error en la estructura de la consulta. Revisar." >> $LOG
			/usr/bin/mutt -s "Error en la estructura de la consulta. Revisar." $MAIL < $LOG
		  	exit 1
		;;
	esac

	echo "======================================================================"	
	echo "======================================================================" >>$LOG

	#Verifica si hay registros para respaldar.
	echo "Verifica si hay registros para respaldar en $TAB_ORIGEN."
	echo "Verifica si hay registros para respaldar en $TAB_ORIGEN." >> $LOG
	CUENTA_ORI=`/usr/bin/psql -At -F';' -c "SELECT COUNT(*) FROM $TAB_ORIGEN $WHERE;" $BASE`; &>> $LOG

	if [[ $CUENTA_ORI -eq 0 ]]; then
        	echo "No hay registros para generar respaldo (Revisar tabla $TAB_ORIGEN)."
	        echo "No hay registros para generar respaldo (Revisar tabla $TAB_ORIGEN)." >> $LOG
        	/usr/bin/mutt -s "No hay registros para generar respaldo (Revisar tabla $TAB_ORIGEN)." $MAIL < $LOG	        	
	else
		#Verifica si ya existe archivo de respaldo en directorio de respaldo.
		#if [ -e "$FILE" ]; then
		#       echo "Error, el archivo $FILE ya existe en carpeta de respaldo (Revisar carpeta)."
		#       echo "Error, el archivo $FILE ya existe en carpeta de respaldo (Revisar carpeta)." >> $LOG
		#       /usr/bin/mutt -s "Error, archivo ya existente en carpeta de respaldos." $MAIL < $LOG
		#       exit 1;
		#fi

		#Hora de Inicio.
		HORA_INI=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')" $BASE`;
		echo ">> Hora de Inicio de respaldo de tabla $TAB_ORIGEN : $HORA_INI" &>>$LOG

		#Rango de fechas del respaldo.
		echo "Respaldo desde el $DATE_INI hasta el $DATE" &>>$LOG

		#Truncate a tabla de destino.
		echo "Truncate a tabla $TAB_DESTINO."
		echo "Truncate a tabla $TAB_DESTINO." >> $LOG
		/usr/bin/psql $BASE -c "TRUNCATE table $TAB_DESTINO" &>> $LOG

		#Vacuum full a tabla de destino.
		echo "Vacuum full a tabla $TAB_DESTINO."
		echo "Vacuum full a tabla $TAB_DESTINO." >> $LOG
		/usr/bin/psql $BASE -c "VACUUM FULL $TAB_DESTINO" &>> $LOG
	
		#Reindex en tabla de destino.
		echo "Reindex en tabla $TAB_DESTINO."
		echo "Reindex en tabla $TAB_DESTINO." >> $LOG
		/usr/bin/psql $BASE -c "REINDEX table $TAB_DESTINO" &>> $LOG

		#Copiar desde tabla de origen a tabla de destino.
		echo "Copiar desde tabla $TAB_ORIGEN a tabla $TAB_DESTINO."
		echo "Copiar desde tabla $TAB_ORIGEN a tabla $TAB_DESTINO." >> $LOG
		/usr/bin/psql $BASE -c "INSERT INTO $TAB_DESTINO SELECT * FROM $TAB_ORIGEN $WHERE;" &>> $LOG

		#Cuenta registros en tabla de destino.
		CUENTA_DEST=`/usr/bin/psql -At -F';' -c "SELECT COUNT(*) FROM $TAB_DESTINO $WHERE;" $BASE`; &>> $LOG
		echo "Cuenta registros en tabla de destino ($TAB_DESTINO) = $CUENTA_DEST."
		echo "Cuenta registros en tabla de destino ($TAB_DESTINO) = $CUENTA_DEST." >> $LOG

		#Compara tabla de origen v/s tabla de destino.
		echo "Compara tabla $TAB_ORIGEN ($CUENTA_ORI) v/s tabla $TAB_DESTINO ($CUENTA_DEST)."
		echo "Compara tabla $TAB_ORIGEN ($CUENTA_ORI) v/s tabla $TAB_DESTINO ($CUENTA_DEST)." >> $LOG
		if [[ $CUENTA_ORI -ne $CUENTA_DEST ]];
		then
	        	echo "Error, hay diferencia en cant. de registros entre $TAB_ORIGEN ($CUENTA_ORI) y $TAB_DESTINO ($CUENTA_DEST)."
		        echo "Error, hay diferencia en cant. de registros entre $TAB_ORIGEN ($CUENTA_ORI) y $TAB_DESTINO ($CUENTA_DEST)." >> $LOG

			echo "Se eliminan registros copiados a tabla $TAB_DESTINO."
			echo "Se eliminan registros copiados a tabla $TAB_DESTINO." >> $LOG
			/usr/bin/psql $BASE -c "DELETE FROM $TAB_DESTINO $WHERE;"
			/usr/bin/mutt -s "Error, diferencia en cant. de registros entre $TAB_ORIGEN y $TAB_DESTINO." $MAIL < $LOG
		else
			#Copiar a archivo file.dump desde tabla de origen.
			/usr/bin/psql $BASE -c "\COPY (SELECT * FROM $TAB_ORIGEN $WHERE) TO '$FILE'" &>> $LOG

			echo "Generando archivo $FILE ..."
			echo "Generando archivo $FILE ..." >> $LOG

			#Verifica consistencia lineas del archivo contra registros de tabla de origen.
			REGS_ORI=`wc -l $FILE| awk {'print $1'}`
			echo "Cuenta lineas del archivo ($REGS_ORI) contra registros en tabla de origen ($CUENTA_ORI)."
			echo "Cuenta lineas del archivo ($REGS_ORI) contra registros en tabla de origen ($CUENTA_ORI)." >> $LOG

			if [[ $REGS_ORI -ne $CUENTA_ORI ]];
			then
        			echo "Error, hay diferencia en cant. de registros entre $TAB_ORIGEN ($CUENTA_ORI) y registros en archivo ($REGS_ORI)."
		        	echo "Error, hay diferencia en cant. de registros entre $TAB_ORIGEN ($CUENTA_ORI) y registros en archivo ($REGS_ORI)." >> $LOG

				echo "Se eliminan registros copiados a tabla $TAB_DESTINO y archivo generado."
				echo "Se eliminan registros copiados a tabla $TAB_DESTINO y archivo generado." >> $LOG
				
				/usr/bin/psql $BASE -c "DELETE FROM $TAB_DESTINO $WHERE;"
				rm -f $FILE
				
				/usr/bin/mutt -s "Error, diferencia en cant. de registros entre $TAB_ORIGEN y archivo." $MAIL < $LOG
			else
				#Carga el respaldo en Amazon-RDS
				echo "Carga el respaldo en Amazon-RDS."
				echo "Carga el respaldo en Amazon-RDS." >> $LOG
				/usr/bin/psql -h motoramazon.cjmbprft2nd8.us-east-1.rds.amazonaws.com -p 5432 -U motor -d motorimed -c "\COPY $TAB_ORIGEN FROM '$FILE'" &>> $LOG

				#Cuenta registros cargados en tabla de destino en Amazon.
				echo "Cuenta registros cargados en tabla de destino ($TAB_ORIGEN) en Amazon."
				echo "Cuenta registros cargados en tabla de destino ($TAB_ORIGEN) en Amazon." >> $LOG
				CUENTA_DEST_AMAZON=`/usr/bin/psql -h motoramazon.cjmbprft2nd8.us-east-1.rds.amazonaws.com -p 5432 -U motor -d motorimed -At -c "SELECT COUNT(*) FROM $TAB_ORIGEN $WHERE"`; &>> $LOG


				#Compara cantidad de registros entre tabla de origen y tabla de destino en Amazon.
				echo "Compara cantidad de registros entre tabla de origen y tabla de destino en Amazon."
				echo "Compara cantidad de registros entre tabla de origen y tabla de destino en Amazon." >> $LOG
				if [[ $CUENTA_DEST_AMAZON -ne $CUENTA_ORI ]];
				then
        				echo "Error, diferencia en cant. de registros entre $TAB_ORIGEN ($CUENTA_ORI) y Amazon ($CUENTA_DEST_AMAZON)."
		        		echo "Error, diferencia en cant. de registros entre $TAB_ORIGEN ($CUENTA_ORI) y Amazon ($CUENTA_DEST_AMAZON)." >> $LOG
				
					echo "Se eliminan registros de $TAB_DESTINO, se borra archivo y se eliminan registros en Amazon ($TAB_ORIGEN)."
					echo "Se eliminan registros de $TAB_DESTINO, se borra archivo y se eliminan registros en Amazon ($TAB_ORIGEN)." >> $LOG
					
					/usr/bin/psql $BASE -c "DELETE FROM $TAB_DESTINO $WHERE;"
	        			rm -f $FILE
					/usr/bin/psql -h motoramazon.cjmbprft2nd8.us-east-1.rds.amazonaws.com -p 5432 -U motor -d motorimed -At -c "DELETE FROM $TAB_ORIGEN $WHERE"
					
					/usr/bin/mutt -s "Error, diferencia en cant. de registros entre $TAB_ORIGEN y Amazon." $MAIL < $LOG
				else
					#Borra los registros respaldados de la tabla de origen.
					echo "Borra los registros respaldados de la tabla $TAB_ORIGEN."
					echo "Borra los registros respaldados de la tabla $TAB_ORIGEN." >> $LOG
					/usr/bin/psql $BASE -c "DELETE FROM $TAB_ORIGEN $WHERE" &>> $LOG

					#Vacuum full a tabla de origen.
					echo "Vacuum full a tabla $TAB_ORIGEN."
					echo "Vacuum full a tabla $TAB_ORIGEN." >> $LOG
					/usr/bin/psql $BASE -c "VACUUM FULL VERBOSE $TAB_ORIGEN" &>> $LOG
	
					#Reindex en tabla de origen.
					echo "Reindex en tabla $TAB_ORIGEN."
					echo "Reindex en tabla $TAB_ORIGEN." >> $LOG					
					/usr/bin/psql $BASE -c "REINDEX table $TAB_ORIGEN" &>> $LOG

					echo "Proceso Respaldo OK. Se ha generado un archivo de nombre: $FILE."
	
					echo "Cantidad de registros en tabla de origen ($TAB_ORIGEN): $CUENTA_ORI." >> $LOG
					echo "Cantidad de registros en tabla de destino ($TAB_DESTINO): $CUENTA_DEST." >> $LOG
					echo "Cantidad de registros en tabla de Amazon ($TAB_ORIGEN): $CUENTA_DEST_AMAZON." >> $LOG
					echo "Cantidad de registros en archivo: $REGS_ORI." >> $LOG

					echo "Proceso Respaldo OK. Se ha generado un archivo de nombre: $FILE." >> $LOG

					#Hora de Termino.
					HORA_FIN=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')" $BASE`;
					echo ">> Hora de termino del respaldo : $HORA_FIN" >>$LOG

					#Si el proceso de respaldo fue exitoso, entonces envia un correo con los datos.
					/usr/bin/mutt -s "Proceso Respaldo OK. Se ha generado un archivo de nombre: $FILE" $MAIL < $LOG
				fi
			fi
		fi	
	fi

	I=`expr $I + 1`
	STR=${DATA[$I]}
	TAB_ORIGEN=$(echo $STR | cut -f 1 -d';')
	TAB_DESTINO=$(echo $STR | cut -f 2 -d';')
	RESPALDA=$(echo $STR | cut -f 3 -d';')	

done

exit 1;
