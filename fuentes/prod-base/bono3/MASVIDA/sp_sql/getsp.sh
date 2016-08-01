#tsql -H 150.10.10.31 -p 1433 -U IMED -P 20050331 < comandos.sql
DIR='/home/motor/base/bono3/MASVIDA/sp_sql'
HOST='150.10.10.31'
PORT='1433'
USR='IMED'
PWD='20050331'

cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > sp_configure.txt
--controla la ejecucion de los procedimientos almacenados desde servidores remotos o locales en los que se estan ejecutando instancias de SQL Server
sp_configure "remote access"
go

--especifica el numero maximo de conexiones de usuario simultaneas que se permiten en una instancia de SQL Server
sp_configure "user connections"
go
EOT
#exit 1;

#Todos Los Objetos de la Base del Financiador
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/modelo_db.txt
sp_help 
go
EOT

cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/MASBenCertif.sql
sp_help MASBenCertif
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/MASAnulaBonoU.sql
sp_help MASAnulaBonoU
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/MASEnrola.sql
sp_help MASEnrola
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/MASenvBonIs.sql
sp_help MASenvBonIs
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/MASenvBono.sql
sp_help MASenvBono
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/MASLeeRutCotiz.sql
sp_help MASLeeRutCotiz
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/MASSolicFolios.sql
sp_help MASSolicFolios
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/MASValidaCAt.sql
sp_help MASValidaCAt
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/MASValorizI.sql
sp_help MASValorizI
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/MASvaltrans.sql
sp_help MASvaltrans
go
EOT

#############
#cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/CGCBenRec.sql
#sp_help CGCBenRec
#go
#EOT
#cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/CGCDatosPrest.sql
#sp_help CGCDatosPrest
#go
#EOT
#cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/CGCPrestPaquete.sql
#sp_help CGCPrestPaquete
#go
#EOT
#cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/CGCValorVari.sql
#sp_help CGCValorVari
#go
#EOT

