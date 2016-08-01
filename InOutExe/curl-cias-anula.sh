#!/bin/bash

#Saca avisos de folios duplicados por rut
cd /home/motor/InOutExe
MAIL="jaime.cossio@acepta.com"
DATE=`/bin/date +'%F %T'`
BASE="dmotor"
FECHA=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP,'YYYYMMDD')" $BASE`;
#echo "FECHA =="$FECHA

#REG=`/usr/bin/psql -At -F';' -c "SELECT base from base_datos where base>1 and base<100 and proyecto='BNO' and base in (71,99,80) order by base asc" $BASE`
#REG=`/usr/bin/psql -At -F';' -c "SELECT base from base_datos where base>1 and base<100 and proyecto='BNO' and base in (71) order by base asc" $BASE`
#REG=`/usr/bin/psql -At -F';' -c "select financiador from define_secuencia_ws where tipo_tx = 'bencertif'" $BASE`
REG=`/usr/bin/psql -At -F';' -c "select * from anula_cias order by cod_seg asc'" $BASE`
#echo "REGISTOS==="$REG

DATA=($REG)
I=0;
STR=${DATA[$I]}
NEMO=$(echo $STR | cut -f 1 -d';')
COD_SEG=$(echo $STR | cut -f 2 -d';')
RUT_BEN=$(echo $STR | cut -f 3 -d';')
FOL_CIA=$(echo $STR | cut -f 4 -d';')
FOL_BNO=$(echo $STR | cut -f 5 -d';')
ID=$(echo $STR | cut -f 1 -d';')

#while  [ $ID -gt 0 ]
while  [ ${#ID} -gt 0 ]
do
	#echo "Echo Conexion Financiador - BaseDatos="$ID
	#REQ="POST http://10.100.32.177:4000/WSIMedBono/services/BENCERTIFPort HTTP/1.1

	REQ="POST http://10.100.32.177/AnulacionBono3/cia_seg_$NEMO HTTP/1.1
		Accept-Encoding: gzip,deflate
		Content-Type: text/xml;charset=UTF-8
		SOAPAction: \"http://tempuri.org/wmImed_SrvAnulacion\"
		Content-Length: 505
		Host: 10.100.32.177
		Connection: Keep-Alive
		User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

		<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\">
   		<soapenv:Header/>
   		 <soapenv:Body>
      		  <tem:wmImed_SrvAnulacion>
          	    <tem:XML_INPUT>
         		<extCodSeguro>$COD_SEG</extCodSeguro>
         		<extRutBeneficiario>$RUT_BEN</extRutBeneficiario>
         		<extFolioAuto>$FOL_CIA</extFolioAuto>
         		<extFolioBono>$FOL_BNO</extFolioBono>
         	    </tem:XML_INPUT>
      		  </tem:wmImed_SrvAnulacion>
   		 </soapenv:Body>
		</soapenv:Envelope>"

	echo "REQ= "$REQ 

	#Para convertir de ASC to HEX. Quitando "ENTER"
	INPUT=$(echo "$REQ" | xxd -p | tr -d '\n' );
	#echo "INPUT= "$INPUT
	/home/motor/InOutExe/EnviaTxPxml LOG=1 TX=4000 IP_TX=127.0.0.1 PORT_TX=4000 INPUT=$INPUT REQUEST_URI='/WSIMedBono/services/BENCERTIFPort' DOCUMENT_URI='/WSIMedBono/services/BENCERTIFPort'

	sleep 0.1
	I=`expr $I + 1`
	STR=${DATA[$I]}
	ID=$(echo $STR | cut -f 1 -d';')
done
