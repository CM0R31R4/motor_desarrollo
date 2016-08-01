#/home/isys/instantclient_11_2/sqlplus imed/rxb532@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=164.77.11.9)(PORT=1521))(CONNECT_DATA=(SID=DSUCU)))" < comandos.sql

DIR='/home/isys/base/bono3/BANMEDICA/sp_oracle/'
SQLPLUS='/home/isys/instantclient_11_2/sqlplus'
HOST='164.77.11.82'
PORT='1521'
USR='imed'
PWD='nel5628'
SID='QSUCU'

#/home/isys/instantclient_11_2/sqlplus imed/rxb532@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=164.77.11.9)(PORT=1521))(CONNECT_DATA=(SID=DSUCU)))"
#/home/isys/instantclient_11_2/sqlplus $USR/$PWD"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))"
#SELECT OBJECT_NAME,OBJECT_TYPE,OWNER FROM ALL_OBJECTS ORDER BY OBJECT_TYPE asc;

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/modelo_db2.txt
SET PAGESIZE 999 LINESIZE 999;
SELECT OBJECT_NAME,OBJECT_TYPE,OWNER FROM ALL_OBJECTS ORDER BY OBJECT_NAME asc;
EOT
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/all_all_table2.txt
SET PAGESIZE 999 LINESIZE 999;
select * from ALL_ALL_TABLES order by TABLE_NAME asc;
EOT
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/procedure2.txt
SET PAGESIZE 999 LINESIZE 999;
select OBJECT_NAME,PROCEDURE_NAME,OBJECT_TYPE,OWNER from ALL_PROCEDURES order by PROCEDURE_NAME;
EOT
########################################################################################################################################################
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/BANANULABONOU_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc BANANULABONOU_PKG
select text from all_source where name = 'BANANULABONOU_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/BANBENCERTIF_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc BANBENCERTIF_PKG
select text from all_source where name = 'BANBENCERTIF_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/BANBENREC_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc BANBENREC_PKG
select text from all_source where name = 'BANBENREC_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/BANDATOSPREST_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc BANDATOSPREST_PKG
select text from all_source where name = 'BANDATOSPREST_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/BANENROLA_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc BANENROLA_PKG
select text from all_source where name = 'BANENROLA_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/BANENVBONIS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc BANENVBONIS_PKG
select text from all_source where name = 'BANENVBONIS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/BANINFENROLA_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc BANINFENROLA_PKG
select text from all_source where name = 'BANINFENROLA_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/BANLEERUTCOTIZ_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc BANLEERUTCOTIZ_PKG
select text from all_source where name = 'BANLEERUTCOTIZ_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/BANPRESTPAQUETE_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc BANPRESTPAQUETE_PKG
select text from all_source where name = 'BANPRESTPAQUETE_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/BANSOLICFOLIOS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc BANSOLICFOLIOS_PKG
select text from all_source where name = 'BANSOLICFOLIOS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/BANVALIDACAT_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc BANVALIDACAT_PKG
select text from all_source where name = 'BANVALIDACAT_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/BANVALORVARI_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc BANVALORVARI_PKG
select text from all_source where name = 'BANVALORVARI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/BANVALORIZI_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc BANVALORIZI_PKG
select text from all_source where name = 'BANVALORIZI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/BANVALTRANS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc BANVALTRANS_PKG
select text from all_source where name = 'BANVALTRANS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT
#####################################################################################################################################################
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/CALL_BANVALORIZI.sql
SET PAGESIZE 999 LINESIZE 999;
desc CALL_BANVALORIZI
select text from all_source where name = 'CALL_BANVALORIZI' and type in('PROCEDURE') order by line asc;
EOT

