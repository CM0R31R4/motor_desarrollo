#!/bin/bash

#Saca avisos de folios duplicados por rut
cd /home/isys/InOutExe
MAIL="jaime.cossio@acepta.com"
DATE=`/bin/date +'%F %T'`
BASE="dec"

TOTAL=`/usr/bin/psql -At -F';' -c "select count(*) from base_datos where base>1 and base<100 and proyecto='BNO' and base not in (94)" $BASE`
echo $DATE "TOTAL_REGISTROS:"$TOTAL

REG=`/usr/bin/psql -At -F';' -c "SELECT base from base_datos where base>1 and base<100 and proyecto='BNO' and base in (99,80) order by base asc" $BASE`
echo "REGISTOS==="$REG

DATA=($REG)
I=0;
STR=${DATA[$I]}
ID=$(echo $STR | cut -f 1 -d';')

#while  [ $ID -gt 0 ]
while  [ ${#ID} -gt 0 ]
do
	echo "Echo Conexion Financiador - BaseDatos="$ID
	/home/isys/InOutExe/EnviaTxPxml TX=8081 ip_tx=127.0.0.1 port_tx=8010 input='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://ws.imed.embswitch.chileoffshore.com/"><soapenv:Header/><soapenv:Body><ws:solicfolios><extCodFinanciador>'$ID'</extCodFinanciador><extNumFolios>0</extNumFolios></ws:solicfolios></soapenv:Body></soapenv:Envelope>' 
	sleep 0.1
	I=`expr $I + 1`
	STR=${DATA[$I]}
	ID=$(echo $STR | cut -f 1 -d';')
done
