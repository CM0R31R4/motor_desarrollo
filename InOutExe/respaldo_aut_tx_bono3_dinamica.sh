#!/bin/bash
cd /home/motor/InOutExe/

# Base de Datos.
BASE="dmotor"

# Directorio de Respaldo.
DIRECTORIO="/home/motor/InOutExe/Respaldo"

# Mail destinatario del reporte.
MAIL="claudio.moreira@acepta.com"

# Fechas de Inicio y Termino para respaldar.
DATE_FIN=$(date +"%Y%m%d" -d "-7 day")
DATE_INI=$(date +"%Y%m%d" -d "-14 day")

# Fecha usada en los archivos que se van a generar.
DATE_FILE=$(date +"%Y-%m-%d")

# Obtiene IP del servidor para generar codigo de Motor.
IPSERVER=`ifconfig eth0 | awk '/inet addr:/ {print $2}'|sed 's/addr://'`
CODMOTOR=`/usr/bin/psql -At -F';' -c "select id from ip_motores where ip_motor='$IPSERVER';" $BASE`

# Mide el largo de CODMOTOR y si es menor a 2 digitos le agrega un cero.
LARGO=$(echo ${#CODMOTOR})
if [ $LARGO -lt 2 ]; then
	CODMOTOR="0"$CODMOTOR
fi

# Proceso de Respaldo de Tablas dinamicas.
while [ "$DATE_INI" != "$DATE_FIN" ]; do 
	
	# Armado de nombre de la tabla.
	TABLA_TX="tx_bono3_$DATE_INI$CODMOTOR"
	#echo $TABLA_TX
	
	# Arma nombre para archivo de respaldo y log.
        FILE=$DIRECTORIO"/"$TABLA_TX"_"$DATE_FILE".dump"
	DUMP=$TABLA_TX"_"$DATE_FILE".dump"
        LOG=$DIRECTORIO"/log_"$TABLA_TX"_"$DATE_FILE".txt"

	# Verifica la existencia de la tabla.
	VERIFICA_TABLA_TX=`/usr/bin/psql -At -F';' -c "SELECT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = '$TABLA_TX');" $BASE`;

	if [ "$VERIFICA_TABLA_TX" == "t" ]  
	then
		echo "======================================================================"
                echo "======================================================================" >>$LOG
		
		# Hora de Inicio.
                HORA_INI=$(date +"%c")
                echo ">> Hora de Inicio de respaldo de tabla [$TABLA_TX] : $HORA_INI"
                echo ">> Hora de Inicio de respaldo de tabla [$TABLA_TX] : $HORA_INI" &>>$LOG

		# Cuenta los registros de la tabla.
                CUENTA_ORI=`/usr/bin/psql -At -F';' -c "SELECT COUNT(*) FROM $TABLA_TX;" $BASE`;

		# Verifica si hay registros para respaldar.
		if [[ $CUENTA_ORI -eq 0 ]]; then
			echo "No hay registros para generar respaldo (Revisar tabla $TABLA_TX)."
                	echo "No hay registros para generar respaldo (Revisar tabla $TABLA_TX)." >> $LOG
       		else
			echo "Se encontraron ($CUENTA_ORI) registros en tabla [$TABLA_TX]"
                        echo "Se encontraron ($CUENTA_ORI) registros en tabla [$TABLA_TX]" >> $LOG

			#Copiar a archivo file.dump desde tabla de origen.
                        /usr/bin/psql $BASE -c "\COPY (SELECT * FROM $TABLA_TX) TO '$FILE'" &>> $LOG

			echo "Generando archivo $FILE ..."
                        echo "Generando archivo $FILE ..." >> $LOG

			#Verifica consistencia lineas del archivo contra registros de tabla de origen.
                        REGS_ORI=`wc -l $FILE| awk {'print $1'}`
                        echo "Contando lineas del archivo ($DUMP) : ($REGS_ORI) contra registros en tabla de origen ($CUENTA_ORI)..."
                        echo "Contando lineas del archivo ($DUMP) : ($REGS_ORI) contra registros en tabla de origen ($CUENTA_ORI)..." >> $LOG

			if [[ $REGS_ORI -ne $CUENTA_ORI ]];
                        then
                                echo "Error, hay diferencia en cant. de registros entre [$TABLA_TX] : ($CUENTA_ORI) y registros en archivo : ($REGS_ORI)."
                                echo "Error, hay diferencia en cant. de registros entre [$TABLA_TX] : ($CUENTA_ORI) y registros en archivo : ($REGS_ORI)." >> $LOG
                             
				# Se elimina archivo.
				echo "Se elimina archivo : ($DUMP)"
				echo "Se elimina archivo : ($DUMP)" >> $LOG
                                rm -f $FILE
			else				
				# Verifica existencia de la tabla en servidor de Amazon.				
				echo "Verificando existencia de [$TABLA_TX] en Amazon..."
				echo "Verificando existencia de [$TABLA_TX] en Amazon..." >> $LOG
				VERIFICA_TABLA_TX_AMAZON=`/usr/bin/psql -h motoramazon.cjmbprft2nd8.us-east-1.rds.amazonaws.com -p 5432 -U motor -d motorimed -At -c "SELECT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = '$TABLA_TX');"`; &>> $LOG
				
				# Crea la tabla en Amazon en caso de que no exista.
				if [ "$VERIFICA_TABLA_TX_AMAZON" == "f" ]
        			then
					echo "Tabla no existe."
					echo "Tabla no existe." >> $LOG
					echo "Creando tabla [$TABLA_TX] en Amazon..."
					echo "Creando tabla [$TABLA_TX] en Amazon...." >> $LOG
					/usr/bin/psql -h motoramazon.cjmbprft2nd8.us-east-1.rds.amazonaws.com -p 5432 -U motor -d motorimed -At -c "CREATE TABLE $TABLA_TX (cod_fin integer, financiador varchar(50), tipo_tx varchar(20), codigo_motor bigint, rut_benef varchar(12), fecha_in_tx timestamp, fecha_out_tx timestamp, fecha_in_fin timestamp, fecha_out_fin timestamp, estado varchar(20), codigo_resp varchar(1), mensaje_resp varchar(50), mensaje_fin varchar(50), xml_input varchar, xml_output varchar, sp_exec varchar, sp_return varchar, host varchar(100), folio varchar, procesador_xml varchar, conexiones_activas varchar, fecha_emision integer, monto_aporte_total integer, dia integer);"
				fi
					
				# Carga el respaldo en Amazon-RDS
                                echo "Cargando respaldo en Amazon-RDS..."
                                echo "Cargando respaldo en Amazon-RDS..." >> $LOG
                                /usr/bin/psql -h motoramazon.cjmbprft2nd8.us-east-1.rds.amazonaws.com -p 5432 -U motor -d motorimed -c "\COPY $TABLA_TX FROM '$FILE'" &>> $LOG

				# Cuenta registros cargados en tabla de destino en Amazon.
                                CUENTA_DEST_AMAZON=`/usr/bin/psql -h motoramazon.cjmbprft2nd8.us-east-1.rds.amazonaws.com -p 5432 -U motor -d motorimed -At -c "SELECT COUNT(*) FROM $TABLA_TX"`; &>> $LOG
				echo "Total registros cargados en tabla de destino [$TABLA_TX] en Amazon : ($CUENTA_DEST_AMAZON)."
                                echo "Total registros cargados en tabla de destino [$TABLA_TX] en Amazon : ($CUENTA_DEST_AMAZON)." >> $LOG

				# Compara cantidad de registros entre tabla de origen y tabla de destino en Amazon.
                                if [[ $CUENTA_DEST_AMAZON -ne $CUENTA_ORI ]];
                                then
					echo "Error, diferencia en cant. de registros de [$TABLA_TX] : ($CUENTA_ORI) y Amazon ($CUENTA_DEST_AMAZON)."
                                        echo "Error, diferencia en cant. de registros de [$TABLA_TX] : ($CUENTA_ORI) y Amazon ($CUENTA_DEST_AMAZON)." >> $LOG
					
					echo "Se borra archivo ($DUMP) y se elimina tabla [$TABLA_TX] en Amazon."
                                        echo "Se borra archivo ($DUMP) y se elimina tabla [$TABLA_TX] en Amazon." >> $LOG
							
					# Se elimina archivo.           
                                        rm -f $FILE
					# Se elimina tabla en Amazon.
                      			/usr/bin/psql -h motoramazon.cjmbprft2nd8.us-east-1.rds.amazonaws.com -p 5432 -U motor -d motorimed -At -c "DROP TABLE $TABLA_TX;"
					
				else
					echo "Se borra la tabla local : [$TABLA_TX]."
                                        echo "Se borra la tabla local : [$TABLA_TX]." >> $LOG
					/usr/bin/psql $BASE -c "DROP TABLE $TABLA_TX;" &>> $LOG

					echo "Proceso Respaldo OK. Se genera archivo : ($DUMP)."

                                        echo "Cantidad de registros en tabla de origen [$TABLA_TX] : ($CUENTA_ORI)." >> $LOG
                                        echo "Cantidad de registros en tabla de Amazon [$TABLA_TX] : ($CUENTA_DEST_AMAZON)." >> $LOG
                                        echo "Cantidad de registros en archivo ($DUMP) : ($REGS_ORI)." >> $LOG

                                        echo "Proceso Respaldo OK. Se genera archivo : ($DUMP)." >> $LOG

					#Hora de Termino.
                                        HORA_FIN=$(date +"%c")
					echo ">> Hora de termino del respaldo : $HORA_FIN"
                                        echo ">> Hora de termino del respaldo : $HORA_FIN" >>$LOG

					#Si el proceso de respaldo fue exitoso, entonces envia un correo con los datos.
                                        /usr/bin/mutt -s "Proceso Respaldo OK. Se ha generado un archivo de nombre: $DUMP" $MAIL < $LOG
				fi
			fi
		fi
	else
		echo "======================================================================"
                echo "======================================================================" >>$LOG

		echo "Tabla $TABLA_TX no existe."
		echo "Tabla $TABLA_TX no existe." >> $LOG	
	fi
		
	DATE_INI=$(date +%Y%m%d -d "$DATE_INI + 1 day")
done

exit 1;  
