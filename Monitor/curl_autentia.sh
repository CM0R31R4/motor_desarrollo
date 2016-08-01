#!./bin/bash

#Funcion parseo tag
get_tag(){
b1="<$1>"
b2="</$1>"
a=$2
i=$(echo $(expr match "$a" ".*${b1}"))
f=$(echo $(expr match "$a" ".*${b2}"))
if [ $i -eq 0 ] || [ $f -eq 0 ]; 
then
	echo ""
else
	echo ${a:$i:$f-$i-${#b2}}
fi
}

echo "-------------COMIENZO-----------------"
# Paramentros
URL="http://www.autentia.cl/cgi-bin/autentia-audit.cgi"
INTENTOS=3
TIMEOUT=2
DELAY=5
REQ="<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:wsaudit\">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:wsaudit soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">
         <WSAuditReadReq xsi:type=\"urn:CAuditReadReq\">
            <wsUsuario>Autentia</wsUsuario>
            <wsClave>@ut3nti4.</wsClave>
            <NroAudit xsi:type=\"xsd:string\">INFO-P7A8-XVQF-K9NR</NroAudit>
            <bWsq>0</bWsq>
            <bBmp>0</bBmp>
         </WSAuditReadReq>
      </urn:wsaudit>
   </soapenv:Body>
</soapenv:Envelope>"

# Curl
RSP=$(curl --retry $INTENTOS --retry-delay $DELAY --connect-timeout $TIMEOUT --write-out "<http_code>%{http_code}</http_code>" -silent -k -i -f -X POST -H "Accept-Encoding: deflate" -H "Content-Type: text/xml; charset=UTF-8" -H 'SOAPAction: ""' -H "Host: www.autentia.cl" --data "$REQ" --location $URL)

echo $RSP
HTTP_CODE=$(get_tag "http_code" "${RSP}")
echo "HTTP_CODE---- : $HTTP_CODE"
TAG_ERR=$(get_tag "Err" "${RSP}")
echo "TAG_ERR---- : $TAG_ERR"
GLOSA=$(get_tag "Glosa" "${RSP}")
echo "GLOSA---- : $GLOSA"
# Analizar Respuesta Servicio
if [[ $HTTP_CODE == 200 ]] && [[ $TAG_ERR == 0 ]];
then
	STATUS_SERVICIO="OK"
else
        STATUS_SERVICIO="NOOK"
fi
echo "STATUS_SERVICIO "$STATUS_SERVICIO

## Enviar a Base de Monitoreo
## Servicio
## Intentos
## Log con Fecha, hora, servicio, status, Tag_Err, STATUS_SERVICIO HTTP_CODE, mensaje_error
#LOG
echo `date "+%Y%m%d;%T"`";Autentia-wsaudit;0;$STATUS_SERVICIO;$HTTP_CODE;$TAG_ERR;$GLOSA;">>LOG`date "+%Y%m%d"`.csv

 
