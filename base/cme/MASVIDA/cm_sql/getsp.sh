#tsql -H 150.10.11.42 -p 1433 -D ISAPRE -U CMELEC -P IMED01 < comandos.sql
DIR='/home/isys/base/cme/MASVIDA/cm_sql'
HOST='150.10.11.42'
PORT='1433'
DB='ISAPRE'
USR='CMELEC'
PWD='IMED01'

#Todos Los Objetos de la Base del Financiador
#cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/modelo_cm.txt
#sp_help 
#go
#EOT

cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERANTHAB.sql
sp_help CERANTHAB
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERANTMOR.sql
sp_help CERANTMOR
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERANTQUI.sql
sp_help CERANTQUI
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERDETANAM.sql
sp_help CERDETANAM
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERDETEVO.sql
sp_help CERDETEVO
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERDETPROT.sql
sp_help CERDETPROT
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERDIAEGR.sql
sp_help CERDIAEGR
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERDIAGPOSOP.sql
sp_help CERDIAGPOSOP
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERDIAGPREOP.sql
sp_help CERDIAGPREOP
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CEREMIBONOPAM.sql
sp_help CEREMIBONOPAM
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERENCANAM.sql
sp_help CERENCANAM
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERENCEPI.sql
sp_help CERENCEPI
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERENCPROT.sql
sp_help CERENCPROT
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERENVCTA.sql
sp_help CERENVCTA
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERENVDETEQUIPO.sql
sp_help CERENVDETEQUIPO
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERENVDETHOTELE.sql
sp_help CERENVDETHOTELE
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERENVDETINSUMO.sql
sp_help CERENVDETINSUMO
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERENVINFPAC.sql
sp_help CERENVINFPAC
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERENVPAQUETE.sql
sp_help CERENVPAQUETE
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERENVTIPANT.sql
sp_help CERENVTIPANT
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CEREPIIND.sql
sp_help CEREPIIND
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CEREQUMED.sql
sp_help CEREQUMED
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CEREXAFIS.sql
sp_help CEREXAFIS
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CEREXISTECUENTA.sql
sp_help CEREXISTECUENTA
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERGRPFAM.sql
sp_help CERGRPFAM
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CEROBTBONEQUIPO.sql
sp_help CEROBTBONEQUIPO
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CEROBTBONHOTELE.sql
sp_help CEROBTBONHOTELE
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CEROBTBONINSUMO.sql
sp_help CEROBTBONINSUMO
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CEROBTBONOSPAM.sql
sp_help CEROBTBONOSPAM
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CEROBTFECPAG.sql
sp_help CEROBTFECPAG
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CEROBTPAQUETE.sql
sp_help CEROBTPAQUETE
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CEROBTSALDOSPAG.sql
sp_help CEROBTSALDOSPAG
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CEROTRCIR.sql
sp_help CEROTRCIR
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERRELHMQPROT.sql
sp_help CERRELHMQPROT
go
EOT
cat <<EOT | tsql -H $HOST -p $PORT -D $DB -U $USR -P $PWD > $DIR/CERTRAPRO.sql
sp_help CERTRAPRO
go
EOT
