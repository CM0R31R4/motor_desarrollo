#172.31.16.59:10000
#CSALUD00
#CSALUD00

#tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 < comandos.sql
DIR='/home/motor/base/bono3/CRUZBLANCA/sp_sybase'

cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > sp_configure.txt
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

cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > modelo_db.txt
sp_help
go
EOT

#exit 1;
#go
#EOT
#cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGAnulaBonoU.sql
#sp_helptext INGAnulaBonoU
#go
#EOT
#cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGBenRec.sql
#sp_helptext INGBenRec
#go
#EOT
#cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGSolicFolios.sql
#sp_helptext INGSolicFolios
#go
#EOT
#cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGEnrola.sql
#sp_helptext INGEnrola
#go
#EOT
#cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGValorVari.sql
#sp_helptext INGValorVari
#go
#EOT
#cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGEnvBonIs.sql
#sp_helptext INGEnvBonIs
#go
#EOT
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGValTrans.sql
sp_helptext INGValTrans
go
EOT
#cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGPrestPaquete.sql
#sp_helptext INGPrestPaquete
#go
#EOT
#cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGLeeRutCotiz.sql
#sp_helptext INGLeeRutCotiz
#go
#EOT
exit 1;
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGBenCertif_out.sql
sp_helptext INGBenCertif_out
go
EOT
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGCopTran.sql
sp_helptext INGCopTran
go
EOT
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGCopTranLL.sql
sp_helptext INGCopTranLL
go
EOT
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGCopTranRESP.sql
sp_helptext INGCopTranRESP
go
EOT
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGCtrl_TratSol.sql
sp_helptext INGCtrl_TratSol
go
EOT
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGEnvBono.sql
sp_helptext INGEnvBono
go
EOT
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGGesCana.sql
sp_helptext INGGesCana
go
EOT
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGMovExcedente.sql
sp_helptext INGMovExcedente
go
EOT
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGRegBonoIMED_Fallido.sql
sp_helptext INGRegBonoIMED_Fallido
go
EOT
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGSelConMar.sql
sp_helptext INGSelConMar
go
EOT
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGSwitch_FechaEmision.sql
sp_helptext INGSwitch_FechaEmision
go
EOT
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGValorVari_NewCon.sql
sp_helptext INGValorVari_NewCon
go
EOT
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGValPre.sql
sp_helptext INGValPre
go
EOT
cat <<EOT | tsql -H 172.31.16.59 -p 10000 -U CSALUD00 -P CSALUD00 > INGVerPlanExcl.sql
sp_helptext INGVerPlanExcl
go
EOT

