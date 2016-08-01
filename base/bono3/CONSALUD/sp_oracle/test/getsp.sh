#/home/isys/instantclient_11_2/sqlplus IMEDCON/imedcon@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=172.20.2.204)(PORT=1522))(CONNECT_DATA=(SID=TATESA)))"

DIR='/home/isys/base/bono3/CONSALUD/sp_oracle/test'
SQLPLUS='/home/isys/instantclient_11_2/sqlplus'
HOST='172.20.2.204'
PORT='1521'
USR='IMEDCON'
PWD='zaqwsx23'
SID='TISCTOS'

#/home/isys/instantclient_11_2/sqlplus IMEDCON/imedcon@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=172.20.2.204)(PORT=1522))(CONNECT_DATA=(SID=TATESA)))"

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
#exit;

###################################################################################################################################r#
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONANULABONOU_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONANULABONOU_PKG
SELECT text from all_source where name ='CONANULABONOU_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONANULABONOU_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONBENCERTIF_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONBENCERTIF_PKG
SELECT text from all_source where name ='CONBENCERTIF_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONBENCERTIF_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONBENREC_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONBENREC_PKG
SELECT text from all_source where name ='CONBENREC_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONBENREC_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONMENSAJEBEN_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONMENSAJEBEN_PKG
SELECT text from all_source where name ='CONMENSAJEBEN_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONMENSAJEBEN_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONDATOSPREST_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONDATOSPREST_PKG
SELECT text from all_source where name ='CONDATOSPREST_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONDATOSPREST_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONENROLA_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONENROLA_PKG
SELECT text from all_source where name ='CONENROLA_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONENROLA_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

#select text from all_source where name = 'CONENVBONIS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONENVBONIS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONENVBONIS_PKG
SELECT text from all_source where name ='CONENVBONIS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONENVBONIS_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONINFENROLA_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONINFENROLA_PKG
SELECT text from all_source where name ='CONINFENROLA_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONINFENROLA_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

#select text from all_source where name = 'CONLEERUTCOTIZ_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONLEERUTCOTIZ_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONLEERUTCOTIZ_PKG
SELECT text from all_source where name ='CONLEERUTCOTIZ_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONLEERUTCOTIZ_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

#select text from all_source where name = 'CONPRESTPAQUETE_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONPRESTPAQUETE_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONPRESTPAQUETE_PKG
SELECT text from all_source where name ='CONPRESTPAQUETE_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONPRESTPAQUETE_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

#select text from all_source where name = 'CONSOLICFOLIOS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONSOLICFOLIOS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONSOLICFOLIOS_PKG
SELECT text from all_source where name ='CONSOLICFOLIOS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONSOLICFOLIOS_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

#select text from all_source where name = 'CONVALIDACAT_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONVALIDACAT_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONVALIDACAT_PKG
SELECT text from all_source where name ='CONVALIDACAT_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONVALIDACAT_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

#select text from all_source where name = 'CONVALORIZI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONVALORIZI_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONVALORIZI_PKG
SELECT text from all_source where name ='CONVALORIZI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONVALORIZI_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

#select text from all_source where name = 'CONVALORVARI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONVALORVARI_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONVALORVARI_PKG
SELECT text from all_source where name ='CONVALORVARI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONVALORVARI_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

#select text from all_source where name = 'CONVALTRANS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CONVALTRANS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
#DESC CONVALTRANS_PKG
SELECT text from all_source where name ='CONVALTRANS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
SELECT text from all_source where name ='CONVALTRANS_PKG' and type in('PACKAGE BODY') and OWNER='BONELEC' order by line asc;
EOT

