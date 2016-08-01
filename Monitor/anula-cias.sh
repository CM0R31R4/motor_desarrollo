#! /bin/bash
cd /home/motor/Monitor

#Desarrollo
IP="http://10.100.32.179/PRUEBA"                               #Direccion del monitor.php
IPWS="http://10.100.32.177"                                   #Direccion Servicios Bono
IPWSMONITOR="http://172.16.9.233"                             #Direccion Ws que guarda el monitoreo
#LOG="LOG`date "+%Y%m%d"`.csv"
#LOGSQL="CURL_ERROR`date "+%Y%m%d"`.sql"
#IP_PERCONA="172.16.9.170"
#PORT_PERCONA="3306"
#USR_PERCONA="bono3imed"
#PWD_PERCONA="6Wv6GLJXAAZT"
#DB_PERCONA="bono3"


#Produccion
#IP="http://robot.bonoelectronico.cl"
#IPWS="http://10.100.32.52"			##Cambiar al HA. Cuando Motor este balanceado
#IPWSMONITOR="http://www.autentia.cl"
LOG="PLOG`date "+%Y%m%d"`.csv"
LOGSQL="PCURL_ERROR`date "+%Y%m%d"`.sql"
IP_PERCONA="127.0.0.1"
PORT_PERCONA="3306"
USR_PERCONA="bono3imed"
PWD_PERCONA="6Wv6GLJXAAZT"
DB_PERCONA="bono3"

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
#2 = Subtipo
#3 = Fecha
#4 = Tiempo Test1 
#5 = Tiempo Test2
#6 = Tiempo Test3
#7 = Tiempo Test4
#8 = Tiempo Test5
#9 = Rc Test1
#10 = Rc Test2
#11 = Rc Test3
#12 = Rc Test4
#13 = Rc Test5
#14 = Glosa Test1
#15 = Glosa Test2
#16 = Glosa Test3
#17 = Glosa Test4
#18 = Glosa Test5

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
P12=$(echo $1 | cut -f 12 -d'&')
P13=$(echo $1 | cut -f 13 -d'&')
P14=$(echo $1 | cut -f 14 -d'&')
P15=$(echo $1 | cut -f 15 -d'&')
P16=$(echo $1 | cut -f 16 -d'&')
P17=$(echo $1 | cut -f 17 -d'&')
P18=$(echo $1 | cut -f 18 -d'&')

URL_2="$IPWSMONITOR/cgi-bin/autentia-monitor.cgi"
INTENTOS_2=3
TIMEOUT_2=2
DELAY_2=1
#REQ_2="<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:wsmonitor\"><soapenv:Header/><soapenv:Body><urn:Insert soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><ReqIns xsi:type=\"urn:Estad\"><TipoEstad>$P1</TipoEstad><CodEntidad>$P2</CodEntidad><Fecha>$P3</Fecha><TmAutentia>$P4</TmAutentia><TmBencertif>$P5</TmBencertif><TmValoriz>$P6</TmValoriz><TmPHP>$P7</TmPHP><RcAutentia>$P8</RcAutentia><RcBencertif>$P9</RcBencertif><RcValoriz>$P10</RcValoriz><RcPHP>$P11</RcPHP></ReqIns></urn:Insert></soapenv:Body></soapenv:Envelope>"

REQ_2="<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:urn=\"urn:wsmonitor\"><soapenv:Header/><soapenv:Body><urn:Insert2 soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><ReqIns2 xsi:type=\"urn:Estad2\"><TipoEstad>$P1</TipoEstad><SubTipo xsi:type=\"xsd:string\">$P2</SubTipo><Fecha xsi:type=\"xsd:string\">$P3</Fecha><TmTest1 xsi:type=\"xsd:string\">$P4</TmTest1><TmTest2 xsi:type=\"xsd:string\">$P5</TmTest2><TmTest3 xsi:type=\"xsd:string\">$P6</TmTest3><TmTest4 xsi:type=\"xsd:string\">$P7</TmTest4><TmTest5 xsi:type=\"xsd:string\">$P8</TmTest5><RcTest1>$P9</RcTest1><RcTest2>$P10</RcTest2><RcTest3>$P11</RcTest3><RcTest4>$P12</RcTest4><RcTest5>$P13</RcTest5><GsTest1 xsi:type=\"xsd:string\">$P14</GsTest1><GsTest2 xsi:type=\"xsd:string\">$P15</GsTest2><GsTest3 xsi:type=\"xsd:string\">$P16</GsTest3><GsTest4 xsi:type=\"xsd:string\">$P17</GsTest4><GsTest5 xsi:type=\"xsd:string\">$P18</GsTest5></ReqIns2> </urn:Insert2> </soapenv:Body></soapenv:Envelope>"

echo $REQ_2
echo $URL_2
# Curl
RSP_2=$(curl --retry 2 --connect-timeout $TIMEOUT_2 --write-out "<http_code>%{http_code}</http_code>" -silent -i -X POST -H "Accept-Encoding: deflate" -H "Content-Type: text/xml; charset=UTF-8" -H 'SOAPAction: ""' --data "$REQ_2" --location $URL_2 2>&1)
echo "RSP_2---- >$RSP_2"

#Respuesta
HTTP_CODE_2=$(get_tag "http_code" "${RSP_2}")
echo "HTTP_CODE WS_MONITOR ---- : $HTTP_CODE_2"

if [[ $HTTP_CODE_2 -ne 200 ]] || [[ $RSP_2 -ne  *">0</Err>"* ]]; 
then
	#LOG
	echo "curl --connect-timeout $TIMEOUT_2 --write-out \"<http_code>%{http_code}</http_code>\" -silent -i -X POST -H \"Accept-Encoding: deflate\" -H \"Content-Type: text/xml; charset=UTF-8\" -H 'SOAPAction: \"\"' --data '$REQ_2' --location $URL_2">>$LOGSQL
fi
}

#------------------------------------------
HORA_MONITOR=`date +%Y-%m-%d:%H:%M`

echo "------ Monitor Cias Seguros  ----------------"
#BASE="dmotor"
#FINANCIADOR=`/usr/bin/psql -At -F';' -c "select to_char(financiador,'00') from define_secuencia_ws where tipo_tx = 'bencertif'" $BASE`
FINANCIADOR="12 14 01"

INTENTOS=1
TIMEOUT=15
DELAY=10
FECHA_YYYYMMDD=`date "+%Y%m%d"`

DATA=($FINANCIADOR)
I=0;
STR=${DATA[$I]}
ID=$(echo $STR | cut -f 1 -d' ')

echo "CIA.SEGUROS "$FINANCIADOR
echo "PUERTOS "$PUERTOS
echo "TIMEOUT "$TIMEOUT
echo "DELAY "$DELAY
echo "INTENTOS "$INTENTOS

while  [ ${#ID} -gt 0 ]
do

	#--- Configurar PUERTO -----------
	STR=${DATA2[$I]}

        echo "---- Monitor Cia Seguros  -------------"
        XML="\<MsgInput\>\<extCodFinanciador\>78\</extCodFinanciador\>\<extCodSeguro\>$ID\</extCodSeguro\>\<extCodLugar\>13001\</extCodLugar\>\<extNumOperacion\>42039\</extNumOperacion\>\<extRutBeneficiario\>0011223574-4\</extRutBeneficiario\>\<extRutPrestador\>0096986050-3\</extRutPrestador\>\<extLisPrest1\>\</extLisPrest1\>\<extLisPrest2\>\</extLisPrest2\>\<extLisPrest3\>\</extLisPrest3\>\<extLisPrest4\>\</extLisPrest4\>\<extLisPrest5\>\</extLisPrest5\>\<extLisPrest6\>\</extLisPrest6\>\</MsgInput\>"

        WS="$IPWS/Certificacion/cia_seg_imed/\?wsdl"
	URL="$IP/monitor_cias_seg_imed.php"
	echo "WS "$WS
        echo "XML "$XML
	echo "CIA.SEGUROS "$ID

	X=1

	while [ $X -le $INTENTOS ]
	do

		RSP=$(curl --retry $INTENTOS --retry-delay $DELAY --connect-timeout $TIMEOUT --write-out "\n<http_code>%{http_code}</http_code><time_total>%{time_total}</time_total>" --silent -k -i -f  $URL\?\timeout\=5\&url_ws\=$WS\&xml\=$XML)

	        #RSP=$(curl --retry $INTENTOS --retry-delay $DELAY --connect-timeout $TIMEOUT --write-out "\n<http_code>%{http_code}</http_code><time_total>%{time_total}</time_total>" --silent -k -i -f $URL\?timeout\=$TIMEOUT\&url_ws\=$WS\&xml\=$XML)

        	echo "RSP---- : $RSP"
		HTTP_CODE=$(get_tag "http_code" "${RSP}")
		HEADER_WS=$(get_tag "Header_WS" "${RSP}")
		echo "HEADER_WS---- : $HEADER_WS"
	        ESTADO=$(get_tag "Estado" "${RSP}")
	        echo "ESTADO---- : $ESTADO"
	        MENSAJE=$(get_tag "Mensaje" "${RSP}")
	        echo "MENSAJE---- : $MENSAJE"
	        RSP_WS_BEN=$(get_tag "RSP_WS" "${RSP}")
	        echo "RSP_WS_BEN----- : $RSP_WS_BEN"
		TIME_TOTAL_BENCERTIF=$(get_tag "Intervalo" "${RSP}")
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
        echo "$HORA_MONITOR;"`date "+%Y%m%d;%T"`";Cias_Seguros;$ID;$STATUS_SERVICIO_BEN;$HTTP_CODE;$TIME_TOTAL_BENCERTIF;$ESTADO;$MENSAJE;$RSP_WS_BEN">>$LOG

        #ws_monitor "2&$ID&$HORA_MONITOR&$TIME_TOTAL_BENCERTIF&$TIME_TOTAL_VALORVARI& & & &$STATUS_SERVICIO_BEN&$STATUS_SERVICIO_VAL& & & &$RSP_WS_BEN&$RSP_WS & & & &"
        let I+=1
        STR=${DATA[$I]}
        ID=$(echo $STR | cut -f 1 -d' ')
	echo "----"

done

#Reprocesar envió fallido a WSMonitoreo
if [ -f $LOGSQL ];
   then
   echo "REPROCESAR $LOGSQL"
   sh $LOGSQL
fi
