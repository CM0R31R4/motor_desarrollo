#tsql -H 10.40.100.2 -p 1433 -U IMED -P ferroimed.2006 < comandos.sql
DIR='/home/motor/base/bono3/FERROSALUD/sp_sql'
HOST='10.40.100.2'
PORT='1433'
USR='IMED'
PWD='ferroimed.2006'

cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > sp_configure.txt
--controla la ejecucion de los procedimientos almacenados desde servidores remotos o locales en los que se estan ejecutando instancias de SQL Server
sp_configure "remote access"
go

--especifica el numero maximo de conexiones de usuario simultaneas que se permiten en una instancia de SQL Server
sp_configure "user connections"
go
EOT
exit 1;

cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > modelo_db.txt
select db_name()
go
sp_help 
go
EOT

cat <<EOT | tsql -H $HOST -p $PORT -U -$USR -P $PWD > sp_configure.txt
--Especifica el tamañámo de los paquetes en bytes
sp_configure "max network packet size"
go

--Especifica cuáas sesiones de usuarios pueden estar abiertas al mismo tiempo
sp_configure "max number network listeners"
go

--Especifica el nú de conecciones remotas
sp_configure "number of remote connections"
go

--Especifica el nú mámo de ingresos de usuarios remotos
sp_configure "number of remote logins"
go

--Especifica cuáos sitios remotos puede accesar el servidor al mismo tiempo
sp_configure "number of remote sites"
go

--Especifica cuáos sitios remotos puede accesar el servidor al mismo tiempo
sp_configure "user connections"
go
EOT


cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/FERAnulaBonoU.sql
sp_helptext FERAnulaBonoU
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/FERBenCertif.sql
sp_helptext FERBenCertif
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/FERBenRec.sql
sp_helptext FERBenRec
go
EOT
#cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/FERDatosPrest.sql
#sp_helptext FERDatosPrest
#go
#EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/FEREnrola.sql
sp_helptext FEREnrola
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/FEREnvBonIs.sql
sp_helptext FEREnvBonIs
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/FERLeeRutCotiz.sql
sp_helptext FERLeeRutCotiz
go
EOT
#cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/FERPrestPaquete.sql
#sp_helptext FERPrestPaquete
#go
#EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/FERSolicFolios.sql
sp_helptext FERSolicFolios
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/FERValTrans.sql
sp_helptext FERValTrans
go
EOT
#cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/FERValidaCat.sql
#sp_helptext FERValidaCat
#go
#EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/FERValorVari.sql
sp_helptext FERValorVari
go
EOT

