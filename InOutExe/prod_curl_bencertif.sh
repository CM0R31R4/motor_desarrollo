#!/bin/bash

#Saca avisos de folios duplicados por rut
cd /home/motor/InOutExe
MAIL="jaime.cossio@acepta.com"
DATE=`/bin/date +'%F %T'`
BASE="dmotor"
FECHA=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP,'YYYYMMDD')" $BASE`;
#echo "FECHA =="$FECHA

#94=CruzdelNorte
#TOTAL=`/usr/bin/psql -At -F';' -c "SELECT count(*) from base_datos where base>1 and base<100 and proyecto='BNO' and base not in (81)" $BASE`
#echo $DATE "TOTAL_REGISTROS:"$TOTAL

#71=Consalud
#99=Banmedica
#80=VidaTres
#REG=`/usr/bin/psql -At -F';' -c "SELECT base from base_datos where base>1 and base<100 and proyecto='BNO' and base in (71,99,80) order by base asc" $BASE`
REG=`/usr/bin/psql -At -F';' -c "SELECT base,descripcion,tipo_db from base_datos where base>1 and base<100 and proyecto='BNO' and base in (67) order by base asc" $BASE`
#echo "REGISTOS==="$REG

DATA=($REG)
I=0;
STR=${DATA[$I]}
ID=$(echo $STR | cut -f 1 -d';')
FIN=$(echo $STR | cut -f 2 -d';')
TIPO_DB=$(echo $STR | cut -f 3 -d';')

#while  [ $ID -gt 0 ]
while  [ ${#ID} -gt 0 ]
do
        PORT_LSTR=80$ID
        echo "** KeepAlive FIN=$FIN - TIPO=$TIPO_DB - PORT_LSTR=$PORT_LSTR"
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

        curl -k -i -X POST -H "Accept-Encoding: deflate" -H "Content-Type: text/xml; charset=UTF-8" -H 'SOAPAction: ""' -H "Host: 10.100.32.52:$PORT_LSTR" --data "$REQ" --location "http://10.100.32.52:$PORT_LSTR/WSIMedBono/services/BENCERTIFPort"
        echo "KeepAlive REQ= "$REQ

        #Para convertir de ASC to HEX. Quitando "ENTER"
        #INPUT=$(echo "$REQ" | xxd -p | tr -d '\n' );
        #echo "INPUT= "$INPUT
        #/home/motor/InOutExe/EnviaTxPxml LOG=1 TX=3003 IP_TX=127.0.0.1 PORT_TX=8171 INPUT=$INPUT

        sleep 0.1
        I=`expr $I + 1`
        STR=${DATA[$I]}
        ID=$(echo $STR | cut -f 1 -d';')
        FIN=$(echo $STR | cut -f 2 -d';')
        TIPO_DB=$(echo $STR | cut -f 3 -d';')
done

