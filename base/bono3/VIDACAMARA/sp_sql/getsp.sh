#tsql -H 10.150.73.18 -p 1596 -U imedvc -P serviciovc < comandos.sql
DIR='/home/isys/base/bono3/VIDACAMARA/sp_sql'
HOST='10.150.73.18'
PORT='1596'
USR='imedvc'
PWD='serviciovc'

#NMDAnulaBonoU   dbo     stored procedure
#NMDBenCertif    dbo     stored procedure
#NMDBenRec       dbo     stored procedure
#NMDEnrola       dbo     stored procedure
#NMDEnvBonIs     dbo     stored procedure
#NMDLeeRutCotiz  dbo     stored procedure
#NMDSolicFolios  dbo     stored procedure
#NMDValorVari    dbo     stored procedure
#NMDValTrans     dbo     stored procedure

#Todos Los Objetos de la Base del Financiador
#cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/modelo_db.txt
#sp_help 
#go
#EOT

cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/NMDAnulaBonoU.sql
sp_help NMDAnulaBonoU
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/NMDBenCertif.sql
sp_help NMDBenCertif
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/NMDBenRec.sql
sp_help NMDBenRec
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/NMDEnrola.sql
sp_help NMDEnrola
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/NMDEnvBonIs.sql
sp_help NMDEnvBonIs
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/NMDLeeRutCotiz.sql
sp_help NMDLeeRutCotiz
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/NMDSolicFolios.sql
sp_help NMDSolicFolios
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/NMDValorVari.sql
sp_help NMDValorVari
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -U $USR -P $PWD > $DIR/NMDValTrans.sql
sp_help NMDValTrans
go
EOT
