#! /bin/bash

#Desarrollo
#IP="http://10.100.32.179/PRUEBA"
#IPWS="http://10.100.32.177"
#IPWSMONITOR="http://172.16.9.233"
#LOG="/home/motor/Monitor/LOG`date "+%Y%m%d"`.csv"
#LOGSQL="/home/motor/Monitor/CURL_ERROR`date "+%Y%m%d"`.sql"

#Produccion
IP="http://robot.bonoelectronico.cl"
IPWS="http://10.100.32.52"
IPWSMONITOR="http://www.autentia.cl"
LOG="/root/Monitor/PLOG`date "+%Y%m%d"`.csv"
LOGSQL="/root/Monitor/PCURL_ERROR`date "+%Y%m%d"`.sql"


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
            <NroAudit xsi:type=\"xsd:string\">INFO-..A8-XVQF-K9NR</NroAudit>
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
	STATUS_SERVICIO_AUT="0"
else
        STATUS_SERVICIO_AUT="1"
	ws_monitor "1&0&$HORA_MONITOR&$TIME_TOTAL_AUTENTIA"
	#LOG
	echo "$HORA_MONITOR;"`date "+%Y%m%d;%T"`";autentia-audit;0;$STATUS_SERVICIO;$HTTP_CODE;$TIME_TOTAL_AUTENTIA;$TAG_ERR;$GLOSA">>$LOG

fi
echo "STATUS_SERVICIO AUTENTIA "$STATUS_SERVICIO_AUT

#LOG
echo "$HORA_MONITOR;"`date "+%Y%m%d;%T"`";autentia-audit;0;$STATUS_SERVICIO_AUT;$HTTP_CODE;$TIME_TOTAL_AUTENTIA;$TAG_ERR;$GLOSA">>$LOG

 
echo "------ Monitor PHP  ----------------"
URL="$IP/monitor_bencertif.php"

#Verificar WS Monitor en PHP (Intentos=3 Timeout=1)
echo "Conectando con ..... $URL"
SHOULD_EXIT=$(wget -O /dev/null -t 3 -S  --timeout=5 $URL 2>&1)
if [ $(expr match "$SHOULD_EXIT" ".*200 OK") -eq  0 ];  then
        ERROR=$(echo ${SHOULD_EXIT:$(expr match "$SHOULD_EXIT" ".*ERROR"):100})
        #LOG
        echo "$HORA_MONITOR;"`date "+%Y%m%d;%T"`";php_monitor_bencertif;0;NOOK;;$ERROR">>$LOG
        echo "Error en Conexion a URL Monitor "$URL
fi
echo "Conexion a URL Monitor "$URL
#LOG
#echo "$HORA_MONITOR;"`date "+%Y%m%d;%T"`";php_monitor_bencertif;0;OK;200;0;Conexion OK a  $URL">>$LOG

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

	#--- Configurar PUERTO -----------
	STR=${DATA2[$I]}
	PORT=$(echo $STR | cut -f 1 -d' ')
	PORT=80$PORT
	echo "PORT "$PORT

        echo "---- Monitor Bencertif ----- "
        XML="<table><extCodFinanciador>$ID</extCodFinanciador><extRutBeneficiario>0000000001-9</extRutBeneficiario><extFechaActual>$FECHA_YYYYMMDD</extFechaActual></table>"
        WS="$IPWS:$PORT/WSIMedBono/services/BENCERTIFPort/\?wsdl"
	URL="$IP/monitor_bencertif.php"
	echo "WS "$WS
        echo "XML "$XML


	X=1

	while [ $X -le $INTENTOS ]
	do

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
		ERROR=$(get_tag "errorCod" "${RSP}")
		echo "ERROR----: $ERROR"

	        # Analizar Respuesta Servicio
	        if [[ $HTTP_CODE == 200 ]] && [[ $ERROR == 0 ]];
	        then
	                STATUS_SERVICIO_BEN="0"
			X=$INTENTOS
	        else
	                STATUS_SERVICIO_BEN="1"
	        fi
		echo "STATUS_SERVICIO BENCERTIF"$STATUS_SERVICIO_BEN
		let X+=1
	done
        #LOG
        echo "$HORA_MONITOR;"`date "+%Y%m%d;%T"`";bencertif;$ID;$STATUS_SERVICIO_BEN;$HTTP_CODE;$TIME_TOTAL_BENCERTIF;$ESTADO;$MENSAJE;$RSP_WS">>$LOG

	echo "---- Monitor Valorvari ----- "
	#valorvari
	XML="<table><extCodFinanciador>$ID</extCodFinanciador><extHomNumeroConvenio>1</extHomNumeroConvenio><extHomLugarConvenio>13001</extHomLugarConvenio><extSucVenta>2</extSucVenta><extRutConvenio>0096986050-3</extRutConvenio><extRutTratante>0009252525-2</extRutTratante><extEspecialidad></extEspecialidad><extRutSolicitante>0000000001-9</extRutSolicitante><extRutBeneficiario>0000000001-9</extRutBeneficiario><extTratamiento></extTratamiento><extCodigoDiagnostico>3</extCodigoDiagnostico><extNivelConvenio>1</extNivelConvenio><extUrgencia>2</extUrgencia><extLista1>1</extLista1><extNumPrestaciones>1</extNumPrestaciones></table>"
        if [  $ID == "01"  ];
	then
		WS="$IPWS:$PORT/WSIMedBono/services/COPTRANPort/\?wsdl"
		URL="$IP/monitor_coptran.php"

	else
		if [  $ID == "88"  ];
		then
                        
			WS="$IPWS:$PORT/WSIMedBono/services/VALORIZIPort/\?wsdl"
			URL="$IP/monitor_valorizi.php"
		else
			WS="$IPWS:$PORT/WSIMedBono/services/VALORVARIPort/\?wsdl"
			URL="$IP/monitor_valorvari.php"
		fi
	fi

	echo "WS "$WS
        echo "XML "$XML


	X=1

        while [ $X -le $INTENTOS ]
        do
	
		RSP=$(curl --retry $INTENTOS --retry-delay $DELAY --connect-timeout $TIMEOUT --write-out "\n<http_code>%{http_code}</http_code><time_total>%{time_total}</time_total>" --silent -k -i -f $URL\?timeout\=$TIMEOUT\&url_ws\=$WS\&xml\=$XML)

	        echo "RSP---- : $RSP"
		HTTP_CODE=$(get_tag "http_code" "${RSP}")
		echo "HTTP_CODE---->$HTTP_CODE"
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
		ERROR=$(get_tag "errorCod" "${RSP}")
	        echo "ERROR----: $ERROR"

		# Analizar Respuesta Servicio
					if [[ $HTTP_CODE == 200 ]] && [[ $ERROR == 0 ]];
	        then
	                STATUS_SERVICIO_VAL="0"
			X=$INTENTOS
	        else
	                STATUS_SERVICIO_VAL="1"
	        fi
	        echo "STATUS_SERVICIO VALORIZA "$STATUS_SERVICIO_VAL
		let X+=1
	done 
	#LOG
        echo "$HORA_MONITOR;"`date "+%Y%m%d;%T"`";valorvari;$ID;$STATUS_SERVICIO_VAL;$HTTP_CODE;$TIME_TOTAL_VALORVARI;$ESTADO;$MENSAJE;$RSP_WS">>$LOG

	#Enviar a WS Monitor
	ws_monitor "1&$ID&$HORA_MONITOR&$TIME_TOTAL_AUTENTIA&$TIME_TOTAL_BENCERTIF&$TIME_TOTAL_VALORVARI&0&$STATUS_SERVICIO_AUT&$STATUS_SERVICIO_BEN&$STATUS_SERVICIO_VAL"

        let I+=1
        STR=${DATA[$I]}
        ID=$(echo $STR | cut -f 1 -d' ')
	echo "----"
done

#Reprocesar Envio a Monitor
sh $LOGSQL