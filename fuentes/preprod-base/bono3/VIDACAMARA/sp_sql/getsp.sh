#tsql -H 10.150.73.18 -p 1596 -U imedvc -P serviciovc < comandos.sql

#run proceso=API_VIDACAMARA_BNO portdb=8244 log=1 hilos=2 prefijo_log=API basedatos=Sermed ip_conexion_bd=10.150.73.171:1433 usuario_bd=imed clave_bd=servicio

DIR='/home/motor/base/bono3/VIDACAMARA/sp_sql'
HOST='10.150.73.171'
PORT='1433'
USR='imed'
PWD='servicio'

#SMDAnulaBonoU   dbo     stored procedure
#SMDBenCertif    dbo     stored procedure
#SMDBenRec       dbo     stored procedure
#SMDEnrola       dbo     stored procedure
#SMDEnvBonIs     dbo     stored procedure
#SMDLeeRutCotiz  dbo     stored procedure
#SMDSolicFolios  dbo     stored procedure
#SMDValorVari    dbo     stored procedure
#SMDValTrans     dbo     stored procedure

#Todos Los Objetos de la Base del Financiador
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/modelo_db.txt
sp_help 
go
EOT
#exit 1;
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
