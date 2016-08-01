#!/bin/bash

#Saca avisos de folios duplicados por rut
cd /home/motor/InOutExe
MAIL="jaime.cossio@acepta.com"
DATE=`/bin/date +'%F %T'`
BASE="dmotor"
FECHA=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP,'YYYYMMDD')" $BASE`;
#echo "FECHA =="$FECHA

#94=CruzdelNorte
#TOTAL=`/usr/bin/psql -At -F';' -c "SELECT count(*) from base_datos where base>1 and base<100 and proyecto='BNO' and base not in (94)" $BASE`
#echo $DATE "TOTAL_REGISTROS:"$TOTAL

#71=Consalud
#99=Banmedica
#80=VidaTres
#REG=`/usr/bin/psql -At -F';' -c "SELECT base from base_datos where base>1 and base<100 and proyecto='BNO' and base in (71,99,80) order by base asc" $BASE`
#REG=`/usr/bin/psql -At -F';' -c "SELECT base from base_datos where base>1 and base<100 and proyecto='BNO' and base in (71) order by base asc" $BASE`
#REG=`/usr/bin/psql -At -F';' -c "SELECT base from base_datos where base>1 and base<100 and proyecto='BNO' order by base asc" $BASE`
REG=`/usr/bin/psql -At -F';' -c "select financiador from define_secuencia_ws where tipo_tx = 'bencertif'" $BASE`
#echo "REGISTOS==="$REG


DATA=($REG)
I=0;
STR=${DATA[$I]}
ID=$(echo $STR | cut -f 1 -d';')


#while  [ $ID -gt 0 ]
while  [ ${#ID} -gt 0 ]
do
	#echo "Echo Conexion Financiador - BaseDatos="$ID
	REQ="POST http://10.100.32.177:8071/WSIMedBono/services/BENCERTIFPort HTTP/1.1
		Accept-Encoding: gzip,deflate
		Content-Type: text/xml;charset=UTF-8
		SOAPAction: \"\"
		User-Agent: Jakarta Commons-HttpClient/3.1
		Host: 10.100.32.177:8071
		Content-Length: 411


		<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ws=\"http://ws.imed.embswitch.chileoffshore.com/\">
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

	#Para convertir de ASC to HEX. Quitando "ENTER"
	INPUT=$(echo "$REQ" | xxd -p | tr -d '\n' );
	#echo "INPUT= "$INPUT
	/home/motor/InOutExe/EnviaTxPxml LOG=1 TX=3003 IP_TX=127.0.0.1 PORT_TX=8171 INPUT=$INPUT REQUEST_URI='/WSIMedBono/services/BENCERTIFPort' DOCUMENT_URI='/WSIMedBono/services/BENCERTIFPort'

	sleep 0.1
	I=`expr $I + 1`
	STR=${DATA[$I]}
	ID=$(echo $STR | cut -f 1 -d';')
done
