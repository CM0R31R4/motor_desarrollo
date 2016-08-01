#tsql -H 10.150.73.18 -p 1596 -U imed -P servicio < comandos.sql
DIR='/home/isys/base/bono3/CCHC/sp_sql'
HOST='10.150.73.171'
PORT='1433'
USR='imed'
PWD='servicio'

cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > sp_configure.txt
--controla la ejecucion de los procedimientos almacenados desde servidores remotos o locales en los que se estan ejecutando instancias de   SQL Server 
sp_configure "remote access"
go

--especifica el numero maximo de conexiones de usuario simultaneas que se permiten en una instancia de SQL Server
sp_configure "user connections"
go
EOT
exit 1;

#Todos Los Objetos de la Base del Financiador
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/modelo_db.txt
sp_help 
go
EOT

cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/SMDAnulaBonoU.sql
sp_help SMDAnulaBonoU
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/SMDBenCertif.sql
sp_help SMDBenCertif
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/SMDBenRec.sql
sp_help SMDBenRec
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/SMDEnrola.sql
sp_help SMDEnrola
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/SMDEnvBonIs.sql
sp_help SMDEnvBonIs
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/SMDLeeRutCotiz.sql
sp_help SMDLeeRutCotiz
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/SMDSolicFolios.sql
sp_help SMDSolicFolios
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/SMDValorVari.sql
sp_help SMDValorVari
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/SMDValTrans.sql
sp_help SMDValTrans
go
EOT
