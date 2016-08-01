#! /bin/bash

#Desarrollo
#IPWSMONITOR="http://172.16.9.233"
#LOG="/home/motor/Monitor/LOGDEC`date "+%Y%m%d"`.csv"
#LOGSQL="/home/motor/Monitor/CURLDEC_ERROR`date "+%Y%m%d"`.sql"

#Produccion
IPWSMONITOR="http://www.autentia.cl"
LOG="/home/motor/Monitor/PLOGDEC`date "+%Y%m%d"`.csv"
LOGSQL="/home/motor/Monitor/PCURLDEC_ERROR`date "+%Y%m%d"`.sql"

#---------------------------------------
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


#--- Monitor DEC
echo "--- Monitor DEC"

# Paramentros
HORA_MONITOR=`date +%Y-%m-%d:%H:%M`
URL="http://www.autentia.cl/cgi-bin/autentia-docs2.cgi"
INTENTOS=3
TIMEOUT=15
DELAY=5
REQ="<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:wsdocs\">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:wsAddDoc soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">
         <Req xsi:type=\"urn:CAddDocsReq\">
            <wsUsuario/>
            <wsClave/>
            <NombreArchivo/>
            <Institucion/>
         </Req>
      </urn:wsAddDoc>
   </soapenv:Body>
</soapenv:Envelope>"
echo "URL Monitor -------->$URL"

# Curl
RSP=$(curl --retry $INTENTOS --retry-delay $DELAY --connect-timeout $TIMEOUT --write-out "<http_code>%{http_code}</http_code><time_total>%{time_total}</time_total>" -silent -k -i -f -X POST -H "Accept-Encoding: deflate" -H "Content-Type: text/xml; charset=UTF-8" -H 'SOAPAction: ""' -H "Host: www.autentia.cl" --data "$REQ" --location $URL 2>&1)

echo $RSP

HTTP_CODE=$(get_tag "http_code" "${RSP}")
echo "HTTP_CODE---->$HTTP_CODE"
TIME=$(get_tag "time_total" "${RSP}")
echo "TIME---->$TIME"

# Analizar Respuesta Servicio
if [[ $HTTP_CODE == 200 ]];
then
        STATUS_SERVICIO_AUT="0"
else
        STATUS_SERVICIO_AUT="1"
fi


#-- Enviar a monitor
P1="2"
P2="www"
P3=$HORA_MONITOR
P4=$TIME
P5=""
P6=""
P7=""
P8=$STATUS_SERVICIO_AUT
P9=""
P10=""
P11=""

URL_2="$IPWSMONITOR/cgi-bin/autentia-monitor.cgi"
INTENTOS_2=3
TIMEOUT_2=2
DELAY_2=1
REQ_2="<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:wsmonitor\"><soapenv:Header/><soapenv:Body><urn:Insert soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><ReqIns xsi:type=\"urn:Estad\"><TipoEstad>$P1</TipoEstad><CodEntidad>$P2</CodEntidad><Fecha>$P3</Fecha><TmAutentia>$P4</TmAutentia><TmBencertif>$P5</TmBencertif><TmValoriz>$P6</TmValoriz><TmPHP>$P7</TmPHP><RcAutentia>$P8</RcAutentia><RcBencertif>$P9</RcBencertif><RcValoriz>$P10</RcValoriz><RcPHP>$P11</RcPHP></ReqIns></urn:Insert></soapenv:Body></soapenv:Envelope>"

echo "URL ----->$URL_2"
echo "REQ ----->$REQ_2"

# Curl
RSP_2=$(curl --retry 2 --connect-timeout $TIMEOUT_2 --write-out "<http_code>%{http_code}</http_code>" -silent -i -X POST -H "Accept-Encoding: deflate" -H "Content-Type: text/xml; charset=UTF-8" -H 'SOAPAction: ""' --data "$REQ_2" --location $URL_2 2>&1)

echo "RSP --- >$RSP_2"

#Respuesta
HTTP_CODE_2=$(get_tag "http_code" "${RSP_2}")
echo "HTTP_CODE WS_MONITOR ---- : $HTTP_CODE_2"

if [ $HTTP_CODE_2 -ne 200 ];
then
        #LOG
        echo "curl --connect-timeout $TIMEOUT_2 --write-out \"<http_code>%{http_code}</http_code>\" -silent -i -X POST -H \"Accept-Encoding: deflate\" -H \"Content-Type: text/xml; charset=UTF-8\" -H 'SOAPAction: \"\"' --data '$REQ_2' --location $URL_2">>$LOGSQL
fi

#Reprocesar Envio a Monitor
sh $LOGSQL

