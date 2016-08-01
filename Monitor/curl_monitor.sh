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
URL="http://172.16.9.233/cgi-bin/autentia-monitor.cgi"
INTENTOS=3
TIMEOUT=2
DELAY=1
REQ="<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:wsmonitor\">
<soapenv:Header/>
<soapenv:Body>
<urn:Insert soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">
<ReqIns xsi:type=\"urn:Estad\">
<TipoEstad>0</TipoEstad>
<CodEntidad>99</CodEntidad>
<Fecha>201501261015</Fecha>
<TmAutentia>0</TmAutentia>
<TmBencertif>0</TmBencertif>
<TmValoriz>0</TmValoriz>
<TmPHP>0</TmPHP></ReqIns>
</urn:Insert></soapenv:Body>
</soapenv:Envelope>"

echo $REQ
echo $URL
# Curl
#RSP=$(curl --retry $INTENTOS --retry-delay $DELAY --connect-timeout $TIMEOUT --write-out "<http_code>%{http_code}</http_code>" -silent -k -i -f -X POST -H "Accept-Encoding: deflate" -H "Content-Type: text/xml; charset=UTF-8" -H 'SOAPAction: ""' -H "Host: 172.16.9.233" --data "$REQ" --location $URL)
RSP=$(curl --connect-timeout $TIMEOUT --write-out "<http_code>%{http_code}</http_code>" -silent -i -X POST -H "Accept-Encoding: deflate" -H "Content-Type: text/xml; charset=UTF-8" -H 'SOAPAction: ""' -H "Host: 172.16.9.233" --data "$REQ" --location $URL 2>&1)
echo $RSP

#Respuesta
HTTP_CODE=$(get_tag "http_code" "${RSP}")
echo "HTTP_CODE---- : $HTTP_CODE"

# Analizar Respuesta Servicio
#if [[ $HTTP_CODE == 200 ]] && [[ $TAG_ERR == 0 ]];
#then
#	STATUS_SERVICIO="OK"
#else
#        STATUS_SERVICIO="NOOK"
#fi
#echo "STATUS_SERVICIO "$STATUS_SERVICIO

