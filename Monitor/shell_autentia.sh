#! /bin/bash
cd /home/motor/Monitor

#Desarrollo
IP="http://10.100.32.179/PRUEBA"                               #Direccion del monitor.php
IPWS="http://10.100.32.177"                                   #Direccion Servicios Bono
#IPWSMONITOR="http://172.16.9.233"                             #Direccion Ws que guarda el monitoreo
LOG="LOG`date "+%Y%m%d"`.csv"
LOGSQL="CURL_ERROR`date "+%Y%m%d"`.sql"

#Produccion
#IP="http://robot.bonoelectronico.cl"
#IPWS="http://10.100.32.52"
IPWSMONITOR="http://www.autentia.cl"
#LOG="PLOG`date "+%Y%m%d"`.csv"
#LOGSQL="PCURL_ERROR`date "+%Y%m%d"`.sql"


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

#-----------------------------------------
#Funcion ws_monitor
ws_monitor() {
#Valores Entrada
#1 = TipoEntado
#2 = Entidad
#3 = Fecha
#4 = Tiempo Autentia
#5 = Tiempo Certificacion
#6 = Tiempo Valoriza
#7 = Tiempo PHP
#8 = RcAutentia
#9 = RcBencertif
#10 = RcValoriza
#11 = RcPHP

P1=$(echo $1 | cut -f 1 -d'&')
P2=$(echo $1 | cut -f 2 -d'&')
P3=$(echo $1 | cut -f 3 -d'&')
P4=$(echo $1 | cut -f 4 -d'&')
P5=$(echo $1 | cut -f 5 -d'&')
P6=$(echo $1 | cut -f 6 -d'&')
P7=$(echo $1 | cut -f 7 -d'&')
P8=$(echo $1 | cut -f 8 -d'&')
P9=$(echo $1 | cut -f 9 -d'&')
P10=$(echo $1 | cut -f 10 -d'&')
P11=$(echo $1 | cut -f 11 -d'&')

URL_2="$IPWSMONITOR/cgi-bin/autentia-monitor.cgi"
INTENTOS_2=3
TIMEOUT_2=2
DELAY_2=1
REQ_2="<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:wsmonitor\"><soapenv:Header/><soapenv:Body><urn:Insert soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><ReqIns xsi:type=\"urn:Estad\"><TipoEstad>$P1</TipoEstad><CodEntidad>$P2</CodEntidad><Fecha>$P3</Fecha><TmAutentia>$P4</TmAutentia><TmBencertif>$P5</TmBencertif><TmValoriz>$P6</TmValoriz><TmPHP>$P7</TmPHP><RcAutentia>$P8</RcAutentia><RcBencertif>$P9</RcBencertif><RcValoriz>$P10</RcValoriz><RcPHP>$P11</RcPHP></ReqIns></urn:Insert></soapenv:Body></soapenv:Envelope>"

echo $REQ_2
echo $URL_2
# Curl
RSP_2=$(curl --retry 2 --connect-timeout $TIMEOUT_2 --write-out "<http_code>%{http_code}</http_code>" -silent -i -X POST -H "Accept-Encoding: deflate" -H "Content-Type: text/xml; charset=UTF-8" -H 'SOAPAction: ""' --data "$REQ_2" --location $URL_2 2>&1)
#echo $RSP_2

#Respuesta
HTTP_CODE_2=$(get_tag "http_code" "${RSP_2}")
echo "HTTP_CODE WS_MONITOR ---- : $HTTP_CODE_2"

if [ $HTTP_CODE_2 -ne 200 ]; 
then
	#LOG
	echo "curl --connect-timeout $TIMEOUT_2 --write-out \"<http_code>%{http_code}</http_code>\" -silent -i -X POST -H \"Accept-Encoding: deflate\" -H \"Content-Type: text/xml; charset=UTF-8\" -H 'SOAPAction: \"\"' --data '$REQ_2' --location $URL_2">>$LOGSQL
fi
}

#------------------------------------------
echo "------ Monitor Autentia  ----------------"/
# Paramentros
HORA_MONITOR=`date +%Y-%m-%d:%H:%M`
URL="http://www.autentia.cl/cgi-bin/autentia-persona.cgi"
INTENTOS=3
TIMEOUT=15
DELAY=5

# Curl
echo $URL

REQ="<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:wspersona\">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:wspersona soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\">
         <Req xsi:type=\"urn:CPersonaReq\">
            <wsUsuario xsi:type=\"xsd:string\">Autentia</wsUsuario>
            <wsClave xsi:type=\"xsd:string\">@ut3nti4.</wsClave>
            <Pais>CHILE</Pais>
            <Rut xsi:type=\"xsd:string\">0011223574-4</Rut>
            <!--Optional:-->
            <Institucion xsi:type=\"xsd:string\">?</Institucion>
         </Req>
      </urn:wspersona>
   </soapenv:Body>
</soapenv:Envelope>"

RSP=$(curl --retry $INTENTOS --connect-timeout $TIMEOUT --write-out "<http_code>%{http_code}</http_code><time_total>%{time_total}</time_total>" -silent -i -X POST -H "Accept-Encoding: deflate" -H "Content-Type: text/xml; charset=UTF-8" -H 'SOAPAction: ""' --data "$REQ" --location $URL 2>&1)

echo "RSP---- : $RSP"
HTTP_CODE=$(get_tag "http_code" "${RSP}")
echo "HTTP_CODE---->$HTTP_CODE"
TIME_TOTAL_AUTENTIA=$(get_tag "time_total" "${RSP}")
echo "TIME_TOTAL_AUTENTIA ---->$TIME_TOTAL_AUTENTIA"

# Analizar Respuesta Servicio
if [[ $HTTP_CODE == 200 ]] ;
then
	STATUS_SERVICIO_AUT="0"
        X=$INTENTOS
else
        STATUS_SERVICIO_AUT="1"
fi
echo "STATUS_SERVICIO AUTENTIA "$STATUS_SERVICIO_AUT

#LOG
echo "$HORA_MONITOR;"`date "+%Y%m%d;%T"`";autentia-persona;0;$STATUS_SERVICIO_AUT;$HTTP_CODE;$TIME_TOTAL_AUTENTIA;$TAG_ERR;$GLOSA">>$LOG
 
#Enviar a WS Monitor
ws_monitor "4&$ID&$HORA_MONITOR&$TIME_TOTAL_AUTENTIA&$TIME_TOTAL_BENCERTIF&$TIME_TOTAL_VALORVARI&0&$STATUS_SERVICIO_AUT&$STATUS_SERVICIO_BEN&$STATUS_SERVICIO_VAL"

#Reprocesar envió fallido a WSMonitoreo
if [ -f $LOGSQL ];
   then
   echo "REPROCESAR $LOGSQL"
   sh $LOGSQL
fi
