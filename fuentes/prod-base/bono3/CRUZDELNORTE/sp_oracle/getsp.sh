#export LD_LIBRARY_PATH=/home/motor/instantclient_10_2
#SQLPLUS='/home/motor/instantclient_10_2/sqlplus'

#/home/isys/instantclient_10_2/sqlplus isa_imed/isa_imed@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=160.70.51.25)(PORT=1521))(CONNECT_DATA=(SID=SQM)))"
DIR='/home/motor/base/bono3/CRUZDELNORTE/sp_oracle/'
SQLPLUS='/home/motor/instantclient_11_2/sqlplus'
HOST='160.70.51.25'
PORT='1521'
USR='isa_imed'
PWD='isa_imed'
#SID='SQM'
SN='SQM'

#/home/motor/instantclient_10_2/sqlplus isa_imed/isa_imed@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=160.70.51.25)(PORT=1521))(CONNECT_DATA=(SID=SQM)))" < comandos.sql

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
#exit;

###################################################################################################################################r#
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNANULABONOU_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CDNANULABONOU_PKG
SELECT text from all_source where name ='CDNANULABONOU_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CDNANULABONOU_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNBENCERTIF_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CDNBENCERTIF_PKG
SELECT text from all_source where name ='CDNBENCERTIF_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CDNBENCERTIF_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNDATOSPREST_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CDNDATOSPREST_PKG
SELECT text from all_source where name ='CDNDATOSPREST_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CDNDATOSPREST_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT


#select text from all_source where name = 'CDNENVBONIS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNENVBONIS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CDNENVBONIS_PKG
SELECT text from all_source where name ='CDNENVBONIS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CDNENVBONIS_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

#select text from all_source where name = 'CDNLEERUTCOTIZ_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNLEERUTCOTIZ_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CDNLEERUTCOTIZ_PKG
SELECT text from all_source where name ='CDNLEERUTCOTIZ_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CDNLEERUTCOTIZ_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

#select text from all_source where name = 'CDNSOLICFOLIOS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNSOLICFOLIOS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CDNSOLICFOLIOS_PKG
SELECT text from all_source where name ='CDNSOLICFOLIOS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CDNSOLICFOLIOS_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

#select text from all_source where name = 'CDNVALIDACAT_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNVALIDACAT_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CDNVALIDACAT_PKG
SELECT text from all_source where name ='CDNVALIDACAT_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CDNVALIDACAT_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT


#select text from all_source where name = 'CDNVALORVARI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNVALORVARI_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CDNVALORVARI_PKG
SELECT text from all_source where name ='CDNVALORVARI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CDNVALORVARI_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

#select text from all_source where name = 'CDNVALTRANS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNVALTRANS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CDNVALTRANS_PKG
SELECT text from all_source where name ='CDNVALTRANS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CDNVALTRANS_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

#cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNBENREC_PKG.sql
#SET PAGESIZE 999 LINESIZE 999;
#DESC CDNBENREC_PKG
#SELECT text from all_source where name ='CDNBENREC_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
#SELECT text from all_source where name ='CDNBENREC_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
#EOT

#cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNMENSAJEBEN_PKG.sql
#SET PAGESIZE 999 LINESIZE 999;
#DESC CDNMENSAJEBEN_PKG
#SELECT text from all_source where name ='CDNMENSAJEBEN_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
#SELECT text from all_source where name ='CDNMENSAJEBEN_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
#EOT

#cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNENROLA_PKG.sql
#SET PAGESIZE 999 LINESIZE 999;
#DESC CDNENROLA_PKG
#SELECT text from all_source where name ='CDNENROLA_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
#SELECT text from all_source where name ='CDNENROLA_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
#EOT

#cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNINFENROLA_PKG.sql
#SET PAGESIZE 999 LINESIZE 999;
#DESC CDNINFENROLA_PKG
#SELECT text from all_source where name ='CDNINFENROLA_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
#SELECT text from all_source where name ='CDNINFENROLA_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
#EOT

#select text from all_source where name = 'CDNPRESTPAQUETE_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
#at <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNPRESTPAQUETE_PKG.sql
#SET PAGESIZE 999 LINESIZE 999;
#DESC CDNPRESTPAQUETE_PKG
#SELECT text from all_source where name ='CDNPRESTPAQUETE_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
#SELECT text from all_source where name ='CDNPRESTPAQUETE_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
#EOT

#select text from all_source where name = 'CDNVALORIZI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
#cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SERVICE_NAME=$SN)))" > $DIR/CDNVALORIZI_PKG.sql
#SET PAGESIZE 999 LINESIZE 999;
#DESC CDNVALORIZI_PKG
#SELECT text from all_source where name ='CDNVALORIZI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
#SELECT text from all_source where name ='CDNVALORIZI_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
#EOT


