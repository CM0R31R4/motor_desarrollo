#!/bin/bash

cd /home/motor/InOutExe
BASE="dmotor"
FECHA=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP,'YYYYMMDD')" $BASE`;
NRO_INT=1
TOPE_INT=3

#echo "FECHA =="$FECHA

REG=`/usr/bin/psql -At -F';' -c "select financiador from define_secuencia_ws where financiador = 1 and tipo_tx = 'bencertif'" $BASE`
#REG=`/usr/bin/psql -At -F';' -c "select financiador from define_secuencia_ws where tipo_tx = 'bencertif'" $BASE`
NRO_SEC=`/usr/bin/psql -At -F';' -c "select nextval('s_monitor_sla')" $BASE`
#echo "REGISTOS==="$REG

DATA=($REG)
I=0;
STR=${DATA[$I]}
ID=$(echo $STR | cut -f 1 -d';')


while  [ ${#ID} -gt 0 ]
do
	PORT_LSTR=800$ID
	echo "-----------------"
	echo "** KeepAlive FIN=$FIN - TIPO=$TIPO_DB - PORT_LSTR=$PORT_LSTR"
	echo "NRO_SEC=$NRO_SEC"
	
	REQ="<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.imed.embswitch.chileoffshore.com/\">
		   <soapenv:Header/>
		   <soapenv:Body>
		      <ws:bencertif>
		         <extCodFinanciador>$ID</extCodFinanciador>
		         <extRutBeneficiario>0000000001-9</extRutBeneficiario>
		         <extFechaActual>$FECHA</extFechaActual>
		      </ws:bencertif>
		   </soapenv:Body>
		</soapenv:Envelope>"

	echo "REQ= "$REQ

	#Grabar Monitor

	curl -k -i -X POST -s -H "Accept-Encoding: deflate" -H "Content-Type: text/xml; charset=UTF-8" -H 'SOAPAction: ""' -H "Host: 10.100.32.177:$PORT_LSTR" --data "$REQ" --location "http://10.100.32.177:$PORT_LSTR/WSIMedBono/services/BENCERTIFPort"


	echo "---"
	echo "****RSP= "$RSP
	
	#Para convertir de ASC to HEX. Quitando "ENTER"
	#INPUT=$(echo "$REQ" | xxd -p | tr -d '\n' );
	#PORT_LSTR=81$ID
	#echo "INPUT= "$INPUT
	#/home/motor/InOutExe/EnviaTxPxml LOG=1 TX=3003 IP_TX=127.0.0.1 PORT_TX=$PORT_LSTR INPUT=$INPUT REQUEST_URI='/WSIMedBono/services/BENCERTIFPort' DOCUMENT_URI='/WSIMedBono/services/BENCERTIFPort'

	MSJ_OK="0"

	sleep 0.1
	I=`expr $I + 1`
	NRO_INT=`expr $NRO_INT + 1`
	STR=${DATA[$I]}
	ID=$(echo $STR | cut -f 1 -d';')
	FIN=$(echo $STR | cut -f 2 -d';')
        TIPO_DB=$(echo $STR | cut -f 3 -d';')
	echo "----FIN------------"


done
