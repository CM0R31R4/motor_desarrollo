#/home/isys/instantclient_11_2/sqlplus imed/rxb532@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=164.77.11.9)(PORT=1521))(CONNECT_DATA=(SID=DSUCU)))" < comandos.sql

DIR='/home/isys/base/bono3/VIDATRES/sp_oracle/'
SQLPLUS='/home/isys/instantclient_11_2/sqlplus'
HOST='164.77.11.9'
PORT='1521'
USR='imed'
PWD='rxb532'
SID='DSUCU'

#/home/isys/instantclient_11_2/sqlplus imed/rxb532@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=164.77.11.9)(PORT=1521))(CONNECT_DATA=(SID=DSUCU)))"
#/home/isys/instantclient_11_2/sqlplus $USR/$PWD"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))"
#SELECT OBJECT_NAME,OBJECT_TYPE,OWNER FROM ALL_OBJECTS ORDER BY OBJECT_TYPE asc;

#cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/modelo_db.txt
#SET PAGESIZE 999 LINESIZE 999;
#SELECT OBJECT_NAME,OBJECT_TYPE,OWNER FROM ALL_OBJECTS ORDER BY OBJECT_NAME asc;
#EOT
#cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/all_all_table.txt
#SET PAGESIZE 999 LINESIZE 999;
#select * from ALL_ALL_TABLES order by TABLE_NAME asc;
#EOT
#cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/procedure.txt
#SET PAGESIZE 999 LINESIZE 999;
#select OBJECT_NAME,PROCEDURE_NAME,OBJECT_TYPE,OWNER from ALL_PROCEDURES order by PROCEDURE_NAME;
#EOT

#####################################################################################################################################
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDANULABONOU_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc VIDANULABONOU_PKG
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDBENCERTIF_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc VIDBENCERTIF_PKG
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDBENREC_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc VIDBENREC_PKG
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDDATOSPREST_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc VIDDATOSPREST_PKG
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDENROLA_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc VIDENROLA_PKG
EOT

#select text from all_source where name = 'VIDENVBONIS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDENVBONIS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc VIDENVBONIS_PKG
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDINFENROLA_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
desc VIDINFENROLA_PKG
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDLEERUTCOTIZ_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
select text from all_source where name = 'VIDLEERUTCOTIZ_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDPRESTPAQUETE_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
select text from all_source where name = 'VIDPRESTPAQUETE_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDSOLICFOLIOS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
select text from all_source where name = 'VIDSOLICFOLIOS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDVALIDACAT_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
select text from all_source where name = 'VIDVALIDACAT_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDVALORVARI_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
select text from all_source where name = 'VIDVALORVARI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT
cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDVALORIZI_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
select text from all_source where name = 'VIDVALORIZI_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDVALTRANS_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
select text from all_source where name = 'VIDVALTRANS_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT

cat <<EOT | $SQLPLUS $USR/$PWD@"(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$HOST)(PORT=$PORT))(CONNECT_DATA=(SID=$SID)))" > $DIR/VIDMENSAJEBEN_PKG.sql
SET PAGESIZE 999 LINESIZE 999;
select text from all_source where name = 'VIDMENSAJEBEN_PKG' and type in('PACKAGE','SYNONYM') order by line asc;
EOT
