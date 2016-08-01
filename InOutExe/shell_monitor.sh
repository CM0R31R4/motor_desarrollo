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

echo "------ Monitor Autentia  ----------------"
# Paramentros
HORA_MONITOR=`date +%Y%m%d%H%M`
URL="http://www.autentia.cl/cgi-bin/autentia-audit.cgi"
INTENTOS=3
TIMEOUT=15
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
RSP=$(curl --retry $INTENTOS --retry-delay $DELAY --connect-timeout $TIMEOUT --write-out "<http_code>%{http_code}</http_code><time_total>%{time_total}</time_total>" -silent -k -i -f -X POST -H "Accept-Encoding: deflate" -H "Content-Type: text/xml; charset=UTF-8" -H 'SOAPAction: ""' -H "Host: www.autentia.cl" --data "$REQ" --location $URL)

echo $RSP
HTTP_CODE=$(get_tag "http_code" "${RSP}")
echo "HTTP_CODE---- : $HTTP_CODE"
TAG_ERR=$(get_tag "Err" "${RSP}")
echo "TAG_ERR---- : $TAG_ERR"
GLOSA=$(get_tag "Glosa" "${RSP}")
echo "GLOSA---- : $GLOSA"
TIME_TOTAL_AUTENTIA=$(get_tag "time_total" "${RSP}")
echo "TIME_TOTAL_AUTENTIA---- : $TIME_TOTAL_AUTENTIA"

# Analizar Respuesta Servicio
if [[ $HTTP_CODE == 200 ]] && [[ $TAG_ERR == 0 ]];
then
	STATUS_SERVICIO="OK"
else
        STATUS_SERVICIO="NOOK"
fi
echo "STATUS_SERVICIO "$STATUS_SERVICIO

#LOG
echo "$HORA_MONITOR;"`date "+%Y%m%d;%T"`";Autentia-wsaudit;0;$STATUS_SERVICIO;$HTTP_CODE;$TIME_TOTAL_AUTENTIA;$TAG_ERR;$GLOSA;">>LOG`date "+%Y%m%d"`.csv

 
echo "------ Monitor PHP  ----------------"
#Apuntar al HA Superior
URL="http://10.100.32.179/PRUEBA/monitor_bencertif.php"

#Verificar WS Monitor en PHP (Intentos=3 Timeout=1)
echo "Conectando con ..... $URL"
SHOULD_EXIT=$(wget -O /dev/null -t 3 -S  --timeout=5 $URL 2>&1)
if [ $(expr match "$SHOULD_EXIT" ".*200 OK") -eq  0 ];  then
        ERROR=$(echo ${SHOULD_EXIT:$(expr match "$SHOULD_EXIT" ".*ERROR"):100})
        #LOG
        echo "$HORA_MONITOR;"`date "+%Y%m%d;%T"`";php_monitor_bencertif;0;NOOK;;$ERROR">>LOG`date "+%Y%m%d"`.csv
        echo "Error en Conexion a URL Monitor "$URL
        exit
fi
echo "Conexion a URL Monitor "$URL
#LOG
echo "$HORA_MONITOR;"`date "+%Y%m%d;%T"`";php_monitor_bencertif;0;OK;200;Conexion OK a  $URL">>LOG`date "+%Y%m%d"`.csv

echo "------ Monitor Servicios  ----------------"
#BASE="dmotor"
#FINANCIADOR=`/usr/bin/psql -At -F';' -c "select to_char(financiador,'00') from define_secuencia_ws where tipo_tx = 'bencertif'" $BASE`
PUERTOS="01 11 44 63 63 63 67 63 71 76 78 99 81 88 94 99"
FINANCIADOR="01 11 44 62 63 65 67 68 71 76 78 80 81 88 94 99"

INTENTOS=1
TIMEOUT=15
DELAY=10
FECHA_YYYYMMDD=`date "+%Y%m%d"`

DATA=($FINANCIADOR)
DATA2=($PUERTOS)
I=0;
STR=${DATA[$I]}
ID=$(echo $STR | cut -f 1 -d' ')

echo "FINANCIADOR "$FINANCIADOR
echo "PUERTOS" $PUERTOS
echo "TIMEOUT "$TIMEOUT
echo "DELAY "$DELAY
echo "INTENTOS "$INTENTOS

while  [ ${#ID} -gt 0 ]
do

	#--- COnfigurar PUERTO -----------
	STR=${DATA2[$I]}
	PORT=$(echo $STR | cut -f 1 -d' ')
	PORT=80$PORT
	echo "PORT "$PORT
        echo "---- Monitor Bencertif ----- "
        XML="<table><extCodFinanciador>$ID</extCodFinanciador><extRutBeneficiario>0000000001-9</extRutBeneficiario><extFechaActual>$FECHA_YYYYMMDD</extFechaActual></table>"
        WS="http://10.100.32.177:$PORT/WSIMedBono/services/BENCERTIFPort/\?wsdl"
	URL="http://10.100.32.179/PRUEBA/monitor_bencertif.php"
	echo "WS "$WS
        echo "XML "$XML

        RSP=$(curl --retry $INTENTOS --retry-delay $DELAY --connect-timeout $TIMEOUT --write-out "\n<http_code>%{http_code}</http_code><time_total>%{time_total}</time_total>" --silent -k -i -f $URL\?timeout\=$TIMEOUT\&url_ws\=$WS\&xml\=$XML)

        echo "RSP---- : $RSP"
	HTTP_CODE=$(get_tag "http_code" "${RSP}")
	HEADER_WS=$(get_tag "Header_WS" "${RSP}")
	echo "HEADER_WS---- : $HEADER_WS"
        ESTADO=$(get_tag "Estado" "${RSP}")
        echo "ESTADO---- : $ESTADO"
        MENSAJE=$(get_tag "Mensaje" "${RSP}")
        echo "MENSAJE---- : $MENSAJE"
        RSP_WS=$(get_tag "RSP_WS" "${RSP}")
        echo "RSP_WS----- : $RSP_WS"
	TIME_TOTAL_BENCERTIF=$(get_tag "time_total" "${RSP}")
	echo "TIME_TOTAL_BENCERTIF---- : $TIME_TOTAL_BENCERTIF"

        # Analizar Respuesta Servicio
        if [[ $HTTP_CODE == 200 ]] && [[ $ESTADO == 0 ]];
        then
                STATUS_SERVICIO="OK"
        else
                STATUS_SERVICIO="NOOK"
        fi
        echo "STATUS_SERVICIO "$STATUS_SERVICIO
        #LOG
        echo "$HORA_MONITOR;"`date "+%Y%m%d;%T"`";bencertif;$ID;$STATUS_SERVICIO;$HTTP_CODE;$TIME_TOTAL_BENCERTIF;$ESTADO;$MENSAJE;$RSP_WS">>LOG`date "+%Y%m%d"`.csv

	echo "---- Monitor Valorvari ----- "
	#valorvari
        if [  $ID == "01"  ];
	then
		XML="<table><extCodFinanciador>$ID</extCodFinanciador><extNivelConvenio></extNivelConvenio><extNumPrestaciones></extNumPrestaciones></table>"
        	WS="http://10.100.32.177:$PORT/WSIMedBono/services/COPTRANPort/\?wsdl"
		URL="http://10.100.32.179/PRUEBA/monitor_coptran.php"

	else
		if [  $ID == "88"  ];
		then
			XML="<table><extCodFinanciador>$ID</extCodFinanciador><extNivelConvenio></extNivelConvenio><extNumPrestaciones></extNumPrestaciones></table>"
                        WS="http://10.100.32.177:$PORT/WSIMedBono/services/VALORIZIPort/\?wsdl"
			URL="http://10.100.32.179/PRUEBA/monitor_valorizi.php"
		else
			XML="<table><extCodFinanciador>$ID</extCodFinanciador><extNivelConvenio></extNivelConvenio><extNumPrestaciones></extNumPrestaciones></table>"
			WS="http://10.100.32.177:$PORT/WSIMedBono/services/VALORVARIPort/\?wsdl"
			URL="http://10.100.32.179/PRUEBA/monitor_valorvari.php"
		fi
	fi

	echo "WS "$WS
        echo "XML "$XML
	
	RSP=$(curl --retry $INTENTOS --retry-delay $DELAY --connect-timeout $TIMEOUT --write-out "\n<http_code>%{http_code}</http_code><time_total>%{time_total}</time_total>" --silent -k -i -f $URL\?timeout\=$TIMEOUT\&url_ws\=$WS\&xml\=$XML)

        #echo "RSP---- : $RSP"
	HTTP_CODE=$(get_tag "http_code" "${RSP}")
	HEADER_WS=$(get_tag "Header_WS" "${RSP}")
        echo "HEADER_WS---- : $HEADER_WS"
        ESTADO=$(get_tag "Estado" "${RSP}")
        echo "ESTADO---- : $ESTADO"
        MENSAJE=$(get_tag "Mensaje" "${RSP}")
        echo "MENSAJE---- : $MENSAJE"
        RSP_WS=$(get_tag "RSP_WS" "${RSP}")
        echo "RSP_WS----- : $RSP_WS"
        TIME_TOTAL_VALORVARI=$(get_tag "time_total" "${RSP}")
        echo "TIME_TOTAL_VALORVARI---- : $TIME_TOTAL_VALORVARI"

	# Analizar Respuesta Servicio
        if [[ $HTTP_CODE == 200 ]] && [[ $ESTADO == 0 ]];
        then
                STATUS_SERVICIO="OK"
        else
                STATUS_SERVICIO="NOOK"
        fi
        echo "STATUS_SERVICIO "$STATUS_SERVICIO
        #LOG
        echo "$HORA_MONITOR;"`date "+%Y%m%d;%T"`";valorvari;$ID;$STATUS_SERVICIO;$HTTP_CODE;$TIME_TOTAL_VALORVARI;$ESTADO;$MENSAJE;$RSP_WS">>LOG`date "+%Y%m%d"`.csv

        let I+=1
        STR=${DATA[$I]}
        ID=$(echo $STR | cut -f 1 -d' ')
	echo "----"
done


