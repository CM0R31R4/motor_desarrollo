#!/bin/bash
#export LD_LIBRARY_PATH=/home/motor/instantclient_11_2
## Control de Procesos Watchdog
#trap 'echo "Senal EXIT Bloqueada"' EXIT

#########################################
# Batch watchdog.sh, tiene 4 parametros #
# 1 = Modulo				#
# 2 = Path				#
# 3 = Comando				#	
# 4 = Mail				#
#########################################

DIR='/home/motor/controlMotor'
rm $DIR/wlog.txt
rm $DIR/wlog_BAN.txt
rm $DIR/wlog_CON.txt
rm $DIR/wlog_FUN.txt
rm $DIR/wlog_FUS.txt
#DIR_HOME='/home/motor'

#// API PERCONA
$DIR/watchdog.sh Api_Percona "/home/motor/ApiPercona/" "sube_api start" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#// API SYBASE
$DIR/watchdog.sh Sybase_Imed "/home/motor/ApiSyBase/" "sube_api start" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#// API MYSQL
$DIR/watchdog.sh BaseMysql "/home/motor/ApiMysqlRME/" "sube start" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#// API_MOTOR_PG 
$DIR/watchdog.sh Api_PG "/home/motor/ApiPG/" "sube_api start MOTOR" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#CME_MASVIDA 
#$DIR/watchdog.sh API_MASVIDA_CME "/home/motor/CME_MASVIDA/" "sube_api start CME_MASVIDA" jcossio@i-med.cl,cmoreira@i-med.cl		>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh API_MASVIDA_CME "/home/motor/CME_MASVIDA/" "sube_api start CME_MASVIDA_1" jcossio@i-med.cl,cmoreira@i-med.cl		>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh MASVIDA_PXML_CME "/home/motor/CME_MASVIDA/" "sube_pxml start CME_MASVIDA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh MASVIDA_LSTR_CME "/home/motor/CME_MASVIDA/" "sube_lstr start MASVIDA_CME" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#BNO_BANMEDICA
cd /home/motor/BNO_BANMEDICA
./sube_api start BANMEDICA >> /home/motor/controlMotor/wlog_BAN.txt 
#$DIR/watchdog.sh BANMEDICA.py "/home/motor/BNO_BANMEDICA/" "sube_api start BANMEDICA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
$DIR/watchdog.sh BANMEDICA_PXML_BNO "/home/motor/BNO_BANMEDICA/" "sube_pxml start BANMEDICA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh BANMEDICA_LSTR_BNO "/home/motor/BNO_BANMEDICA/" "sube_lstr start BANMEDICA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#exit 1;

#BNO_CCHC
$DIR/watchdog.sh API_CCHC_BNO "/home/motor/BNO_CCHC/" "sube_api start CCHC" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
$DIR/watchdog.sh CCHC_PXML_BNO "/home/motor/BNO_CCHC/" "sube_pxml start CCHC" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh CCHC_LSTR_BNO "/home/motor/BNO_CCHC/" "sube_lstr start CCHC" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#BNO_CHUQUICAMATA
#$DIR/watchdog.sh API_CHUQUICAMATA_BNO "/home/motor/BNO_CHUQUICAMATA/" "sube_api start CHUQUICAMATA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh CHUQUICAMATA_PXML_BNO "/home/motor/BNO_CHUQUICAMATA/" "sube_pxml start CHUQUICAMATA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh CHUQUICAMATA_LSTR_BNO "/home/motor/BNO_CHUQUICAMATA/" "sube_lstr start CHUQUICAMATA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#BNO_COLMENA/
$DIR/watchdog.sh API_COLMENA_BNO "/home/motor/BNO_COLMENA/" "sube_api start COLMENA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
$DIR/watchdog.sh COLMENA_PXML_BNO "/home/motor/BNO_COLMENA/" "sube_pxml start COLMENA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh COLMENA_LSTR_BNO "/home/motor/BNO_COLMENA/" "sube_lstr start COLMENA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#BNO_CONSALUD/
cd /home/motor/BNO_CONSALUD
./sube_api start CONSALUD >> /home/motor/controlMotor/wlog_CON.txt
#$DIR/watchdog.sh API_CONSALUD_BNO "/home/motor/BNO_CONSALUD/" "sube_api start CONSALUD" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
$DIR/watchdog.sh CONSALUD_PXML_BNO "/home/motor/BNO_CONSALUD/" "sube_pxml start CONSALUD" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh CONSALUD_LSTR_BNO "/home/motor/BNO_CONSALUD/" "sube_lstr start CONSALUD" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#BNO_CRUZBLANCA/
$DIR/watchdog.sh API_CRUZBLANCA_BNO "/home/motor/BNO_CRUZBLANCA/" "sube_api start CRUZBLANCA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
$DIR/watchdog.sh CRUZBLANCA_PXML_BNO "/home/motor/BNO_CRUZBLANCA/" "sube_pxml start CRUZBLANCA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh CRUZBLANCA_LSTR_BNO "/home/motor/BNO_CRUZBLANCA/" "sube_lstr start CRUZBLANCA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#BNO_CRUZDELNORTE/
#cd /home/motor/BNO_CRUZDELNORTE
./sube_api start CRUZDELNORTE >> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh API_CRUZDELNORTE_BNO "/home/motor/BNO_CRUZDELNORTE/" "sube_api start CRUZDELNORTE" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
$DIR/watchdog.sh CRUZDELNORTE_PXML_BNO "/home/motor/BNO_CRUZDELNORTE/" "sube_pxml start CRUZDELNORTE" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh CRUZDELNORTE_LSTR_BNO "/home/motor/BNO_CRUZDELNORTE/" "sube_lstr start CRUZDELNORTE" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#BNO_FERROSALUD/
$DIR/watchdog.sh API_FERROSALUD_BNO "/home/motor/BNO_FERROSALUD/" "sube_api start FERROSALUD" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
$DIR/watchdog.sh FERROSALUD_PXML_BNO "/home/motor/BNO_FERROSALUD/" "sube_pxml start FERROSALUD" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh FERROSALUD_LSTR_BNO "/home/motor/BNO_FERROSALUD/" "sube_lstr start FERROSALUD" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#BNO_FONASA/
#$DIR/watchdog.sh API_FONASA_BNO "/home/motor/BNO_FONASA/" "sube_api start FONASA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
$DIR/watchdog.sh FONASA_PXML_BNO "/home/motor/BNO_FONASA/" "sube_pxml start FONASA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh FONASA_LSTR_BNO "/home/motor/BNO_FONASA/" "sube_lstr start FONASA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#BNO_FUNDACION/
cd /home/motor/BNO_FUNDACION
./sube_api start FUNDACION >> /home/motor/controlMotor/wlog_FUN.txt
#$DIR/watchdog.sh API_FUNDACION_BNO "/home/motor/BNO_FUNDACION/" "sube_api start FUNDACION" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
$DIR/watchdog.sh FUNDACION_PXML_BNO "/home/motor/BNO_FUNDACION/" "sube_pxml start FUNDACION" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh FUNDACION_LSTR_BNO "/home/motor/BNO_FUNDACION/" "sube_lstr start FUNDACION" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#BNO_FUSAT/
cd /home/motor/BNO_FUSAT
./sube_api start FUSAT >> /home/motor/controlMotor/wlog_FUS.txt
#$DIR/watchdog.sh API_FUSAT_BNO "/home/motor/BNO_FUSAT/" "sube_api start FUSAT" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
$DIR/watchdog.sh FUSAT_PXML_BNO "/home/motor/BNO_FUSAT/" "sube_pxml start FUSAT" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh FUSAT_LSTR_BNO "/home/motor/BNO_FUSAT/" "sube_lstr start FUSAT" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#BNO_MASVIDA/
$DIR/watchdog.sh API_MASVIDA_BNO "/home/motor/BNO_MASVIDA/" "sube_api start MASVIDA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
$DIR/watchdog.sh MASVIDA_PXML_BNO "/home/motor/BNO_MASVIDA/" "sube_pxml start MASVIDA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh MASVIDA_LSTR_BNO "/home/motor/BNO_MASVIDA/" "sube_lstr start MASVIDA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#BNO_RIOBLANCO/
#$DIR/watchdog.sh API_RIOBLANCO_BNO "/home/motor/BNO_RIOBLANCO/" "sube_api start RIOBLANCO" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh RIOBLANCO_PXML_BNO "/home/motor/BNO_RIOBLANCO/" "sube_pxml start RIOBLANCO" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh RIOBLANCO_LSTR_BNO "/home/motor/BNO_RIOBLANCO/" "sube_lstr start RIOBLANCO" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#BNO_SANLORENZO/
#$DIR/watchdog.sh API_SANLORENZO_BNO "/home/motor/BNO_SANLORENZO/" "sube_api start SANLORENZO" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh SANLORENZO_PXML_BNO "/home/motor/BNO_SANLORENZO/" "sube_pxml start SANLORENZO" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh SANLORENZO_LSTR_BNO "/home/motor/BNO_SANLORENZO/" "sube_lstr start SANLORENZO" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#BNO_VIDACAMARA/
$DIR/watchdog.sh API_VIDACAMARA_BNO "/home/motor/BNO_VIDACAMARA/" "sube_api start VIDACAMARA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
$DIR/watchdog.sh VIDACAMARA_PXML_BNO "/home/motor/BNO_VIDACAMARA/" "sube_pxml start VIDACAMARA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh VIDACAMARA_LSTR_BNO "/home/motor/BNO_VIDACAMARA/" "sube_lstr start VIDACAMARA" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#BNO_VIDATRES/
#$DIR/watchdog.sh API_VIDATRES_BNO "/home/motor/BNO_VIDATRES/" "sube_api start VIDATRES" jcossio@i-med.cl,cmoreira@i-med.cl		>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh VIDATRES_PXML_BNO "/home/motor/BNO_VIDATRES/" "sube_pxml start VIDATRES" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt
#$DIR/watchdog.sh VIDATRES_LSTR_BNO "/home/motor/BNO_VIDATRES/" "sube_lstr start VIDATRES" jcossio@i-med.cl,cmoreira@i-med.cl	>> /home/motor/controlMotor/wlog.txt

#KeepAlive
#/home/motor/InOutExe/status_bd_fin.sh		>> /home/motor/controlMotor/control_solicfolios_BNO.txt

#Apis Msql
#/home/motor/ApiMSQL_CCHC/watchdog.sh 		>> /home/motor/controlMotor/watchdog_apis_bono3.txt
#/home/motor/ApiMSQL_FERROSALUD/watchdog.sh 	>> /home/motor/controlMotor/watchdog_apis_bono3.txt
#/home/motor/ApiMSQL_VIDACAMARA/watchdog.sh 	>> /home/motor/controlMotor/watchdog_apis_bono3.txt

#Apis Oracle
#/home/motor/ApiORACLE_BANMEDICA/watchdog.sh 	>> /home/motor/controlMotor/watchdog_apis_bono3.txt	#No Requiere
#/home/motor/ApiORACLE_VIDATRES/watchdog.sh 	>> /home/motor/controlMotor/watchdog_apis_bono3.txt
#/home/motor/ApiORACLE_CONSALUD/watchdog.sh 	>> /home/motor/controlMotor/watchdog_apis_bono3.txt
#/home/motor/ApiORACLE_FUNDACION/watchdog.sh 	>> /home/motor/controlMotor/watchdog_apis_bono3.txt
#/home/motor/ApiORACLE_FUSAT/watchdog.sh 		>> /home/motor/controlMotor/watchdog_apis_bono3.txt
#/home/motor/ApiORACLE_CHUQUICAMATA/watchdog.sh 	>> /home/motor/controlMotor/watchdog_apis_bono3.txt
#/home/motor/ApiORACLE_RIOBLANCO/watchdog.sh 	>> /home/motor/controlMotor/watchdog_apis_bono3.txt
#/home/motor/ApiORACLE_SANLORENZO/watchdog.sh 	>> /home/motor/controlMotor/watchdog_apis_bono3.txt
#/home/motor/ApiORACLE_CRUZDELNORTE/watchdog.sh 	>> /home/motor/controlMotor/watchdog_apis_bono3.txt

#Apis Sybase
#/home/motor/ApiSYBASE_COLMENA/watchdog.sh 	>> /home/motor/controlMotor/watchdog_apis_bono3.txt
#/home/motor/ApiSYBASE_CRUZBLANCA/watchdog.sh 	>> /home/motor/controlMotor/watchdog_apis_bono3.txt

