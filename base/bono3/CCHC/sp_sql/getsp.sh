#tsql -H 10.150.73.18 -p 1596 -U imed -P servicio < comandos.sql
DIR='/home/isys/base/bono3/CCHC/sp_sql'
HOST='10.150.73.18'
PORT='1596'
USR='imed'
PWD='servicio'
#SMDEnvBonIs_OLD dbo     stored procedure
#SMDEnvBonIsAYE  dbo     stored procedure

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
