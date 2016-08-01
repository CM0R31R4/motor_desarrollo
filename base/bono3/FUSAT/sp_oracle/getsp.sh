#!/bin/bash

#Base de Datos.
BASE="dmotor"

REG=`/usr/bin/psql -At -F';' -c "SELECT fin_ip_conexion_bd, fin_base_datos, fin_usuario_bd, fin_clave_bd, fin_port_ora_conn FROM parametros_procesos WHERE nom_fin = 'FUSAT';" $BASE`;

DATOS=($REG)
I=0;
STR_DATOS=${DATOS[$I]}
HOST=$(echo $STR_DATOS | cut -f 1 -d';')
SN=$(echo $STR_DATOS | cut -f 2 -d';')
USR=$(echo $STR_DATOS | cut -f 3 -d';')
PWD=$(echo $STR_DATOS | cut -f 4 -d';')
PORT=$(echo $STR_DATOS | cut -f 5 -d';')

DIR='/home/motor/base/bono3/FUSAT/sp_oracle/'
SQLPLUS='/home/motor/instantclient_11_2/sqlplus'
#HOST='192.168.220.20'
#HOST='192.168.220.19'
#PORT='1521'
#USR='ADMIMED'
#USR1='ADMIMED'
#USR1='ADMIMED_CONV'
#PWD='ADMIMED'
#SID='IFUSAT'

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/modelo_db.txt
SET PAGESIZE 999 LINESIZE 999;
SELECT OBJECT_NAME,OBJECT_TYPE,OWNER FROM ALL_OBJECTS ORDER BY OBJECT_NAME asc;
EOT
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/all_all_table.txt
SET PAGESIZE 999 LINESIZE 999;
select * from ALL_ALL_TABLES order by TABLE_NAME asc;
EOT
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/procedure.txt
SET PAGESIZE 999 LINESIZE 999;
select OBJECT_NAME,PROCEDURE_NAME,OBJECT_TYPE,OWNER from ALL_PROCEDURES order by PROCEDURE_NAME;
EOT

###################################################################################################################################r#
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSANULABONOU_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSANULABONOU_PKG
SELECT text from all_source where name ='FUSANULABONOU_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSANULABONOU_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSBENCERTIF_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSBENCERTIF_PKG
SELECT text from all_source where name ='FUSBENCERTIF_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSBENCERTIF_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSBENREC_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSBENREC_PKG
SELECT text from all_source where name ='FUSBENREC_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSBENREC_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSMENSAJEBEN_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSMENSAJEBEN_PKG
SELECT text from all_source where name ='FUSMENSAJEBEN_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSMENSAJEBEN_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSDATOSPREST_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSDATOSPREST_PKG
SELECT text from all_source where name ='FUSDATOSPREST_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSDATOSPREST_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSENROLA_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSENROLA_PKG
SELECT text from all_source where name ='FUSENROLA_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSENROLA_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSENVBONIS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSENVBONIS_PKG
SELECT text from all_source where name ='FUSENVBONIS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSENVBONIS_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSINFENROLA_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSINFENROLA_PKG
SELECT text from all_source where name ='FUSINFENROLA_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSINFENROLA_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSLEERUTCOTIZ_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSLEERUTCOTIZ_PKG
SELECT text from all_source where name ='FUSLEERUTCOTIZ_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSLEERUTCOTIZ_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSPRESTPAQUETE_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSPRESTPAQUETE_PKG
SELECT text from all_source where name ='FUSPRESTPAQUETE_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSPRESTPAQUETE_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSSOLICFOLIOS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSSOLICFOLIOS_PKG
SELECT text from all_source where name ='FUSSOLICFOLIOS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSSOLICFOLIOS_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSVALIDACAT_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSVALIDACAT_PKG
SELECT text from all_source where name ='FUSVALIDACAT_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSVALIDACAT_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSVALORIZI_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSVALORIZI_PKG
SELECT text from all_source where name ='FUSVALORIZI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSVALORIZI_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSVALORVARI_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSVALORVARI_PKG
SELECT text from all_source where name ='FUSVALORVARI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSVALORVARI_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/FUSVALTRANS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FUSVALTRANS_PKG
SELECT text from all_source where name ='FUSVALTRANS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='FUSVALTRANS_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT


