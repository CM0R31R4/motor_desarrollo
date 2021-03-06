#/home/motor/instantclient_11_2/sqlplus IMEDFND/imedcon@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=172.20.2.204)(PORT=1522))(CONNECT_DATA=(SID=TATESA)))"

DIR='/home/motor/base/bono3/FUNDACION/sp_oracle/'
SQLPLUS='/home/motor/instantclient_11_2/sqlplus'
HOST='192.1.1.11'
PORT='1521'
USR=' usr_imed'
PWD='076imed'
SID='prod'

#/home/motor/instantclient_11_2/sqlplus IMEDCON/imedcon@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=172.20.2.204)(PORT=1522))(CONNECT_DATA=(SID=TATESA)))"
#/home/motor/instantclient_11_2/sqlplus $USR/$PWD"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))"
#SELECT OBJECT_NAME,OBJECT_TYPE,OWNER FROM ALL_OBJECTS ORDER BY OBJECT_TYPE asc;

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/modelo_db.txt
SET PAGESIZE 999 LINESIZE 999;
SELECT OBJECT_NAME,OBJECT_TYPE,OWNER FROM ALL_OBJECTS ORDER BY OBJECT_NAME asc;
EOT
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/all_all_table.txt
SET PAGESIZE 999 LINESIZE 999;
select * from ALL_ALL_TABLES order by TABLE_NAME asc;
EOT
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/procedure.txt
SET PAGESIZE 999 LINESIZE 999;
select OBJECT_NAME,PROCEDURE_NAME,OBJECT_TYPE,OWNER from ALL_PROCEDURES order by PROCEDURE_NAME;
EOT

#####################################################################################################################################
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/FNDANULABONOU_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FNDANULABONOU_PKG
SELECT text from all_source where name ='FNDANULABONOU_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/FNDBENCERTIF_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FNDBENCERTIF_PKG
SELECT text from all_source where name ='FNDBENCERTIF_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/FNDBENREC_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FNDBENREC_PKG
SELECT text from all_source where name ='FNDBENREC_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/FNDCERMENSAJEBEN_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FNDCERMENSAJEBEN_PKG
SELECT text from all_source where name ='FNDCERMENSAJEBEN_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/FNDENROLA_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FNDENROLA_PKG
SELECT text from all_source where name ='FNDENROLA_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

#select text from all_source where name = 'FNDENVBONIS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/FNDENVBONIS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FNDENVBONIS_PKG
SELECT text from all_source where name ='FNDENVBONIS_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/FNDINFENROLA_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FNDINFENROLA_PKG
SELECT text from all_source where name ='FNDINFENROLA_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

#select text from all_source where name = 'FNDLEERUTCOTIZ_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/FNDLEERUTCOTIZ_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FNDLEERUTCOTIZ_PKG
SELECT text from all_source where name ='FNDLEERUTCOTIZ_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

#select text from all_source where name = 'FNDPRESTPAQUETE_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/FNDPRESTPAQUETE_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FNDPRESTPAQUETE_PKG
SELECT text from all_source where name ='FNDPRESTPAQUETE_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

#select text from all_source where name = 'FNDSOLICFOLIOS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/FNDSOLICFOLIOS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FNDSOLICFOLIOS_PKG
SELECT text from all_source where name ='FNDSOLICFOLIOS_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

#select text from all_source where name = 'FNDVALIDACAT_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/FNDVALIDACAT_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FNDVALIDACAT_PKG
SELECT text from all_source where name ='FNDVALIDACAT_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

#select text from all_source where name = 'FNDVALORIZI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/FNDVALORIZI_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FNDVALORIZI_PKG
SELECT text from all_source where name ='FNDVALORIZI_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

#select text from all_source where name = 'FNDVALORVARI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/FNDVALORVARI_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FNDVALORVARI_PKG
SELECT text from all_source where name ='FNDVALORVARI_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

#select text from all_source where name = 'FNDVALTRANS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/FNDVALTRANS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
DESC FNDVALTRANS_PKG
SELECT text from all_source where name ='FNDVALTRANS_PKG' and type in('PACKAGE BODY') and OWNER='ADMIMED' order by line asc;
EOT

