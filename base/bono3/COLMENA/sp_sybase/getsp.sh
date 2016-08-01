#tsql -H 4.0.11.1 -p 10000 -U orden -P externo < comandos.sql
DIR='/home/isys/base/bono3/COLMENA/sp_sybase'
#################################################################################################
#	Parameter Name        Default Memory Used Config Value Run Value Unit 		Type 	#
#	--------------        ------- ----------- ------------ --------- ---- 		---- 	#
#	allow remote access         1          0          1         1    switch 	dyn	#
#	print recovery info         0          0          0         0    switch 	dyn	#
#	recovery interval in m      5          0          5         5    minutes 	dyn	#
#################################################################################################

cat <<EOT | tsql -H 4.0.11.1 -p 10000 -U orden -P externo > sp_configure.txt
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

#cat <<EOT | tsql -H 4.0.11.22 -p 12700 -U orden -P orden"$"1$ > modelo_db.txt
#sp_help 
#go
#EOT

#cat <<EOT | tsql -H 4.0.11.22 -p 12700 -U orden -P orden"$"1$ > $DIR/CGCBenCertif.sql
#sp_helptext CGCBenCertif
#go
#EOT
#cat <<EOT | tsql -H 4.0.11.22 -p 12700 -U orden -P orden"$"1$ > $DIR/CGCAnulaBonoU.sql
#sp_helptext CGCAnulaBonoU
#go
#EOT
#cat <<EOT | tsql -H 4.0.11.22 -p 12700 -U orden -P orden"$"1$ > $DIR/CGCBenRec.sql
#sp_helptext CGCBenRec
#go
#EOT
#cat <<EOT | tsql -H 4.0.11.22 -p 12700 -U orden -P orden"$"1$ > $DIR/CGCDatosPrest.sql
#sp_helptext CGCDatosPrest
#go
#EOT
#cat <<EOT | tsql -H 4.0.11.22 -p 12700 -U orden -P orden"$"1$ > $DIR/CGCEnrola.sql
#sp_helptext CGCEnrola
#go
#EOT
#cat <<EOT | tsql -H 4.0.11.22 -p 12700 -U orden -P orden"$"1$ > $DIR/CGCEnvBonIs.sql
#sp_helptext CGCEnvBonIs
#go
#EOT
#cat <<EOT | tsql -H 4.0.11.22 -p 12700 -U orden -P orden"$"1$ > $DIR/CGCLeeRutCotiz.sql
#sp_helptext CGCLeeRutCotiz
#go
#EOT
#cat <<EOT | tsql -H 4.0.11.22 -p 12700 -U orden -P orden"$"1$ > $DIR/CGCPrestPaquete.sql
#sp_helptext CGCPrestPaquete
#go
#EOT
#cat <<EOT | tsql -H 4.0.11.22 -p 12700 -U orden -P orden"$"1$ > $DIR/CGCSolicFolios.sql
#sp_helptext CGCSolicFolios
#go
#EOT
#cat <<EOT | tsql -H 4.0.11.22 -p 12700 -U orden -P orden"$"1$ > $DIR/CGCValTrans.sql
#sp_helptext CGCValTrans
#go
#EOT
#cat <<EOT | tsql -H 4.0.11.22 -p 12700 -U orden -P orden"$"1$ > $DIR/CGCValidaCat.sql
#sp_helptext CGCValidaCat
#go
#EOT
#cat <<EOT | tsql -H 4.0.11.22 -p 12700 -U orden -P orden"$"1$ > $DIR/CGCValorVari.sql
#sp_helptext CGCValorVari
#go
#EOT

