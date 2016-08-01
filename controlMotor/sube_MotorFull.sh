#!/bin/bash

DIR_BASE="/home/motor"

#echo $1
#Ejemplo Ejecucion
#./sube_MotorFull.sh stop
#./sube_MotorFull.sh start

#if [[!$1 -gt 0 ]]; then
if [ -z "${1}" ]; then
        echo "Falta Comando start|stop|reload"
        exit 1;
fi

###################################################
################   APIS  ##########################
###################################################
echo '*** Aplica '$1' ApiPercona ***'
DIR=$DIR_BASE"/ApiPercona"
cd $DIR
./sube_api $1
echo '*** Aplica '$1' ApiPercona FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

echo '*** Aplica '$1' ApiSyBase ***'
DIR=$DIR_BASE"/ApiSyBase"
cd $DIR
./sube_api $1
echo '*** Aplica '$1' ApiSyBase FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

###################################################
################   CIAS  ##########################
###################################################
echo '*** Aplica '$1' PxmlCertificacion CIAS ***'
DIR=$DIR_BASE"/SEGUROS/ProcesadorCertificacionSCGI"
cd $DIR
./sube_pxml $1
echo '*** Aplica '$1' PxmlCertificacion FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

echo '*** Aplica '$1' PxmlConfirmacion CIAS ***'
DIR=$DIR_BASE"/SEGUROS/ProcesadorSCGI"
cd $DIR
./sube_pxml $1
echo '*** Aplica '$1' PxmlConfirmacion FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

###################################################
###############   BONO3  ##########################
###################################################
echo '*** Aplica '$1'  BNO_FONASA FULL ***'
DIR=$DIR_BASE"/BNO_FONASA"
cd $DIR
./SUBE_BNO.sh $1 FONASA
echo '*** Aplica '$1'  BNO_FONASA FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

echo '*** Aplica '$1'  BNO_CCHC FULL ***'
DIR=$DIR_BASE"/BNO_CCHC"
cd $DIR
$DIR/SUBE_BNO.sh $1 CCHC
echo '*** Aplica '$1'  BNO_CCHC FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

echo '*** Aplica '$1'  BNO_VIDACAMARA FULL ***'
DIR=$DIR_BASE"/BNO_VIDACAMARA"
cd $DIR
$DIR/SUBE_BNO.sh $1 VIDACAMARA
echo '*** Aplica '$1'  BNO_VIDACAMARA FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

echo '*** Aplica '$1'  BNO_FUSAT FULL ***'
DIR=$DIR_BASE"/BNO_FUSAT"
cd $DIR
$DIR/SUBE_BNO.sh $1 FUSAT
echo '*** Aplica '$1'  BNO_FUSAT FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

echo '*** Aplica '$1'  BNO_COLMENA FULL ***'
DIR=$DIR_BASE"/BNO_COLMENA"
cd $DIR
$DIR/SUBE_BNO.sh $1 COLMENA
echo '*** Aplica '$1'  BNO_COLMENA FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

echo '*** Aplica '$1'  BNO_CONSALUD FULL ***'
DIR=$DIR_BASE"/BNO_CONSALUD"
cd $DIR
$DIR/SUBE_BNO.sh $1 CONSALUD
echo '*** Aplica '$1'  BNO_CONSALUD FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

echo '*** Aplica '$1'  BNO_FUNDACION FULL ***'
DIR=$DIR_BASE"/BNO_FUNDACION"
cd $DIR
$DIR/SUBE_BNO.sh $1 FUNDACION
echo '*** Aplica '$1'  BNO_FUNDACION FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

echo '*** Aplica '$1'  BNO_CRUZBLANCA FULL ***'
DIR=$DIR_BASE"/BNO_CRUZBLANCA"
cd $DIR
$DIR/SUBE_BNO.sh $1 CRUZBLANCA
echo '*** Aplica '$1'  BNO_CRUZBLANCA FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

echo '*** Aplica '$1'  BNO_FERROSALUD FULL ***'
DIR=$DIR_BASE"/BNO_FERROSALUD"
cd $DIR
$DIR/SUBE_BNO.sh $1 FERROSALUD
echo '*** Aplica '$1'  BNO_FERROSALUD FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

echo '*** Aplica '$1'  BNO_MASVIDA FULL ***'
DIR=$DIR_BASE"/BNO_MASVIDA"
cd $DIR
$DIR/SUBE_BNO.sh $1 MASVIDA
echo '*** Aplica '$1'  BNO_MASVIDA FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

echo '*** Aplica '$1'  CME_MASVIDA FULL ***'
DIR=$DIR_BASE"/CME_MASVIDA"
cd $DIR
$DIR/SUBE_CME.sh $1 CME_MASVIDA
echo '*** Aplica '$1'  CME_MASVIDA FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

echo '*** Aplica '$1'  BNO_CRUZDELNORTE FULL ***'
DIR=$DIR_BASE"/BNO_CRUZDELNORTE"
cd $DIR
$DIR/SUBE_BNO.sh $1 CRUZDELNORTE
echo '*** Aplica '$1'  BNO_CRUZDELNORTE FULL OK..***'
echo '-----------------------------------------'
echo '                                         '
sleep 3;

echo '*** Aplica '$1'  BNO_BANMEDICA FULL ***'
DIR=$DIR_BASE"/BNO_BANMEDICA"
cd $DIR
$DIR/SUBE_BNO.sh $1 BANMEDICA
echo '*** Aplica '$1'  BNO_BANMEDICA FULL OK..***'
echo '-----------------------------------------'
echo '                                         '

#echo '*** Aplica '$1' PxmlReceta ***'
#DIR=$DIR_BASE"/PxmlReceta"
#cd $DIR
#./sube_pxml $1
#echo '*** Aplica '$1' PxmlReceta FULL OK..***'
#echo '-----------------------------------------'
#echo '                                         '

#echo '*** Aplica '$1' ApiMysqlRME ***'
#DIR=$DIR_BASE"/ApiMysqlRME"
#cd $DIR
#./sube $1
#echo '*** Aplica '$1' ApiMysqlRME FULL OK..***'
#echo '-----------------------------------------'
#echo '                                         '

#echo '*** Aplica '$1'  Listener 8081 ***'
#/home/motor/Listener/./sube $1
#echo '*** Aplica '$1'  Listener 8081 OK..***'
#echo '------------------------------'
#sleep 3;

#echo '*** Aplica '$1'  WsAutentia 8061 ***'
#/home/motor/WS_AUTENTIA/./sube $1
#echo '*** Aplica '$1'  WsAutentia 8061 OK..***'
#echo '------------------------------'
#sleep 3;
