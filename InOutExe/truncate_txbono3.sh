#!/bin/bash

#Saca a disco el archivo de respaldo_dte y lo deja limpio
DATE=`psql -At -c "select to_char(now(),'YYYYMMDDHH24MISS')" motor`
DIRECTORIO="/opt/acepta/motor/Respaldo/"
FILE=$DIRECTORIO"dte_respaldo_"$DATE".dump"
LOG=$DIRECTORIO"log.txt"
MAIL="fernando.arancibia@acepta.com,sistemas@acepta.com"

#Verificamos si existe enviamos error
if [ -e "$FILE" ]; then
        echo "Existe Archivo"
        /usr/bin/mail -n -s "Error no se puede generar archivo respaldo $FILE (Revisar Manual)" $MAIL < /dev/null
        exit 1;
fi

#Cambiamos el nombre de la tabla respaldo_dte por respaldo_dte_FECHA (se genera automaticamente cuando se trata de bor
rar)
date > $LOG
#Borro Indice
/usr/bin/psql motor -c "drop index respaldo_dte_01" &>> $LOG
/usr/bin/psql motor -c "drop index respaldo_dte_02" &>> $LOG
/usr/bin/psql motor -c "drop index respaldo_dte_03" &>> $LOG
#Cambio Nombre
/usr/bin/psql motor -c "alter table respaldo_dte rename to respaldo_dte_$DATE" &>> $LOG
#Sacamos a disco
/usr/bin/psql motor -c "copy respaldo_dte_$DATE to '$FILE'" &>> $LOG
#Movemos la tabla al otro tablespace con mas disco
/usr/bin/psql motor -c "alter table respaldo_dte_$DATE set tablespace particion_estadisticas" &>> $LOG
gzip $FILE >> $LOG
#Se envia al bucket s3://respaldo_dte (tmux, es para que redirija el stdout)
/usr/bin/s3cmd put $FILE.gz s3://respaldo_dte 2>&1 >> $LOG
date >> $LOG
#psql motor -c "drop table repaldo_dte_$DATE"
/usr/bin/mail -n -s "Proceso Respaldo OK $FILE" $MAIL < $LOG

exit 1;

INSERT INTO transacciones_derecho_resp SELECT * from transacciones_derecho
SELECT * from transacciones_derecho_resp
copy transacciones_derecho TO '/home/iswitch/tx_derecho.sql'
TRUNCATE table transacciones_derecho_resp
TRUNCATE table transacciones_derecho
VACUUM FULL transacciones_derecho verbose
VACUUM FULL verbose transacciones_derecho
REINDEX table transacciones_derecho
copy transacciones_derecho from '/home/iswitch/tx_derecho.sql'




