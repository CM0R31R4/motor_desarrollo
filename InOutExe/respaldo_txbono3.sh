#!/bin/bash
cd /home/motor/InOutExe/

DATE=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP,'YYYYMMDD')" $BASE`;

DATE_INI=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP - INTERVAL '7 days','YYYYMMDD')" $BASE`;
DATE_FIN=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP - INTERVAL '6 days','YYYYMMDD')" $BASE`;

DIRECTORIO="/home/motor/InOutExe/Respaldo"
FILE=$DIRECTORIO"tx_bono3_respaldo_"$DATE".dump"
LOG=$DIRECTORIO"log.txt"
MAIL="jaime.cossio@acepta.com"
BASE="motor"
TABLE="tx_bono3"

#Verificamos si existe enviamos error
if [ -e "$FILE" ]; then
        echo "Existe Archivo"
        /usr/bin/mail -n -s "Error no se puede generar archivo respaldo $FILE (Revisar Manual)" $MAIL < /dev/null
        exit 1;
fi

#Cambiamos el nombre de la tabla respaldo_dte por respaldo_dte_FECHA (se genera automaticamente cuando se trata de borrar)
date > $LOG

#Vaciado de tabla respaldo 
/usr/bin/psql motor -c "TRUNCATE respaldo_tx_bono3" &>> $LOG
/usr/bin/psql motor -c "DROP index respaldo_tx_bono3_01" &>> $LOG
/usr/bin/psql motor -c "DROP index respaldo_tx_bono3_02" &>> $LOG
/usr/bin/psql motor -c "DROP index respaldo_tx_bono3_03" &>> $LOG

#Respalda el dia  
/usr/bin/psql motor -c "SELECT * INTO respaldo_tx_bono3 FROM tx_bono3 WHERE fecha_tx_in>=$DATE_INI and fecha_tx_in<$DATE_FIN and rut_benef<>'0000000001-9';" &>> $LOG

#Sacamos a disco
/usr/bin/psql motor -c "\COPY (SELECT * FROM respaldo_tx_bono3 WHERE fecha_tx_in>=$DATE_INI and fecha_tx_in<$DATE_FIN and rut_benef<>'0000000001-9') TO '$FILE'" &>> $LOG

#Cuenta registros origen
CUENTA_ORI=`/usr/bin/psql -At -F';' -c "SELECT COUNT(*) FROM tx_bono3 WHERE fecha_in_tx>='$DATE_INI' AND fecha_in_tx<'$DATE_FIN'" $BASE`;

#Carga el respaldo en Amazon-RDS
/usr/bin/psql -h motoramazon.cjmbprft2nd8.us-east-1.rds.amazonaws.com -p 5432 -U motor -d motorimed -c "\COPY tx_bono3 FROM '$FILE'" &>> $LOG
#/usr/bin/psql motor -c "\COPY tx_bono3 FROM '$FILE'" &>> $LOG

#Cuenta registros cargados destino
CUENTA_DEST=`/usr/bin/psql -h motoramazon.cjmbprft2nd8.us-east-1.rds.amazonaws.com -p 5432 -U motor -d -At -F';' -c motorimed "SELECT COUNT(*) FROM tx_bono3 WHERE fecha_in_tx>='$DATE_INI' AND fecha_in_tx<'$DATE_FIN'"`;

#Comparo Origen v/s Destino 
if [[ $CUENTA_ORIG -ne $CUENTA_DEST ]];  
then
	/usr/bin/mail -n -s "Proceso Respaldo NOK $FILE" $MAIL < $LOG
	exit 1;
fi

#Si el respaldo OK.
#Borro Indice
/usr/bin/psql motor -c "DROP index tx_bono3_dte_01" &>> $LOG
/usr/bin/psql motor -c "DROP index respaldo_dte_02" &>> $LOG
/usr/bin/psql motor -c "DROP index respaldo_dte_03" &>> $LOG


DELETE FROM tx_bono3 WHERE fecha_in_tx>='$DATE_INI' AND fecha_in_tx<'$DATE_FIN'

VACUUM FULL VERBOSE tx_cias
REINDEX table tx_cias


/usr/bin/mail -n -s "Proceso Respaldo OK $FILE" $MAIL < $LOG
exit 1;
-------------------------------------------------------------------------------
#Borro Indice
/usr/bin/psql motor -c "DROP index respaldo_dte_01" &>> $LOG
/usr/bin/psql motor -c "DROP index respaldo_dte_02" &>> $LOG
/usr/bin/psql motor -c "DROP index respaldo_dte_03" &>> $LOG
#Cambio Nombre
/usr/bin/psql motor -c "ALTER table respaldo_dte rename to respaldo_dte_$DATE_INI" &>> $LOG
#Sacamos a disco
/usr/bin/psql motor -c "COPY respaldo_dte_$DATE_INI to '$FILE'" &>> $LOG
#Movemos la tabla al otro tablespace con mas disco
/usr/bin/psql motor -c "ALTER table respaldo_dte_$DATE_INI set tablespace particion_estadisticas" &>> $LOG
gzip $FILE >> $LOG
#Se envia al bucket s3://respaldo_dte (tmux, es para que redirija el stdout)
/usr/bin/s3cmd put $FILE.gz s3://respaldo_dte 2>&1 >> $LOG
date >> $LOG
#psql motor -c "drop table repaldo_dte_$DATE_INI"
/usr/bin/mail -n -s "Proceso Respaldo OK $FILE" $MAIL < $LOG

exit 1;
