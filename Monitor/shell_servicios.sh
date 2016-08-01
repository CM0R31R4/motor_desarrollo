#!/bin/bash

#Funcion paseo tag
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

#Opciones Servicios
if [ $(expr match "bencertif-valorizi-valorvari" ".*${1}") -eq 0 ];
then
	echo "Servicio $1 No HABILIADO"
	exit
fi
#Apuntar al HA Superior 
URL="http://10.100.32.179/PRUEBA/monitor_$1.php"
BASE="dmotor"
FINANCIADOR=`/usr/bin/psql -At -F';' -c "select to_char(financiador,'00') from define_secuencia_ws where tipo_tx = '$1'" $BASE`
#FINANCIADOR="02 11 44 62 63 65 67 68 71 76 78 80 81 88 94 99 01"

#Verificar WS Monitor en PHP (Intentos=3 Timeout=1)
echo "Conectando con ..... $URL"
SHOULD_EXIT=$(wget -O /dev/null -t 3 -S  --timeout=1 $URL 2>&1)
if [ $(expr match "$SHOULD_EXIT" ".*200 OK") -eq  0 ];  then
	ERROR=$(echo ${SHOULD_EXIT:$(expr match "$SHOULD_EXIT" ".*ERROR"):100})
	#LOG
	echo `date "+%Y%m%d;%T"`";php_monitor_$1;0;NOOK;;$ERROR">>LOG`date "+%Y%m%d"`.csv
	echo "Error en Conexion a URL Monitor "$URL
	exit
fi
echo "Conexion a URL Monitor "$URL
#LOG
echo `date "+%Y%m%d;%T"`";php_monitor_$1;0;OK;200;Conexion OK a  $URL">>LOG`date "+%Y%m%d"`.csv

INTENTOS=1
TIMEOUT=15
DELAY=10
FECHA_YYYYMMDD=`date "+%Y%m%d"`

DATA=($FINANCIADOR)
I=0;
STR=${DATA[$I]}
ID=$(echo $STR | cut -f 1 -d' ')

echo "FINANCIADOR "$FINANCIADOR
echo "TIMEOUT "$TIMEOUT
echo "DELAY "$DELAY
echo "INTENTOS "$INTENTOS

while  [ ${#ID} -gt 0 ]
do
        PORT=80$ID

	#Bencertif
	if [ $1 == "bencertif" ];
	then	
	        XML="<table><extCodFinanciador>$ID</extCodFinanciador><extRutBeneficiario>0000000001-9</extRutBeneficiario><extFechaActual>$FECHA_YYYYMMDD</extFechaActual></table>"
		WS="http://10.100.32.177:$PORT/WSIMedBono/services/BENCERTIFPort/\?wsdl"
	fi

	#Valorizi
	if [ $1 == "valorizi" ];
        then
		XML="<table><extCodFinanciador>$ID</extCodFinanciador><extNivelConvenio></extNivelConvenio><extNumPrestaciones></extNumPrestaciones></table>"
		WS="http://10.100.32.177:$PORT/WSIMedBono/services/VALORIZIPort/\?wsdl"
	fi

	#valorvari
	if [ $1 == "valorvari" ];
        then
                XML="<table><extCodFinanciador>$ID</extCodFinanciador><extNivelConvenio></extNivelConvenio><extNumPrestaciones></extNumPrestaciones></table>"
                WS="http://10.100.32.177:$PORT/WSIMedBono/services/VALORVARIPort/\?wsdl"
        fi

        echo "WS "$WS
        echo "PORT "$PORT
        echo "XML "$XML

	RSP=$(curl --retry $INTENTOS --retry-delay $DELAY --connect-timeout $TIMEOUT --write-out "\n<http_code>%{http_code}</http_code>" --silent -k -i -f $URL\?timeout\=$TIMEOUT\&url_ws\=$WS\&xml\=$XML)

	#echo "RSP---- : $RSP"
        HTTP_CODE=$(get_tag "http_code" "${RSP}")
        echo "HTTP_CODE---- : $HTTP_CODE"
	ESTADO=$(get_tag "Estado" "${RSP}")
	echo "ESTADO---- : $ESTADO"
	MENSAJE=$(get_tag "Mensaje" "${RSP}")
        echo "MENSAJE---- : $MENSAJE"
	RSP_WS=$(get_tag "RSP_WS" "${RSP}")
	echo "RSP_WS----- : $RSP_WS"

	# Analizar Respuesta Servicio
	if [[ $HTTP_CODE == 200 ]] && [[ $ESTADO == 0 ]];
	then
	        STATUS_SERVICIO="OK"
	else	
        	STATUS_SERVICIO="NOOK"
	fi
	echo "STATUS_SERVICIO "$STATUS_SERVICIO
	#LOG
	echo `date "+%Y%m%d;%T"`";$1;$ID;$STATUS_SERVICIO;$HTTP_CODE;$ESTADO;$MENSAJE;$RSP_WS">>LOG`date "+%Y%m%d"`.csv
	# Valores de RSP_WS
	# 400 Servicio No Habilitado
	# 500 Rut Invalido

        let I+=1
       	STR=${DATA[$I]}
        ID=$(echo $STR | cut -f 1 -d' ')
	sleep 0.1
	
	echo "----"
done


#Reprocesar Envio a Monitor
sh $LOGSQL

