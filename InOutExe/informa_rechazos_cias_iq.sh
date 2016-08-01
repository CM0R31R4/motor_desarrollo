#!/bin/bash

#Genera un archivo Rechazos Cias IQ
#Saca avisos de folios duplicados por rut
cd /home/motor/InOutExe
MAIL="jcossio@i-med.com"
#DATE=`/bin/date +'%F %T'`
BASE="dmotor"
FECHA_FIN=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP,'YYYYMMDD')" $BASE`;

FECHA_IN="20141001"
FECHA_FIN="20141024"

#if [ "$#" -eq 1 ];  
#then
#    FECHA_IN="$1 00:00:00"
#    FECHA_FIN="$1 23:59:59"
#    echo "Descarga Diaria del Dia $1"
#fi
#if [ "$#" -eq 2 ];
#then
#    FECHA_IN=$1
#    FECHA_FIN=$2
#    if [ "$(date -d $FECHA_IN +"%y%m%d")" -ge "$(date -d $FECHA_FIN +"%y%m%d")" ];
#    then
#        echo "Fecha Inicio Mayor que Fecha de Termino"
#        exit 1;
#    fi
#    echo "Descarga entre $FECHA_IN y $FECHA_FIN"
#fi
#if [ "$#" -ge 3 -o "$#" -eq 0 ];
#then    
#    echo "Parametros Incorrectos"
#    exit 1;
#fi

COUNT=`/usr/bin/psql -At -F'|#)' -c "SELECT count(*) from tmp_cias where fecha_ingreso>='$FECHA_IN' and fecha_ingreso<'$FECHA_FIN' and tx='Certificacion' and estado<>'CIA_OK'"`
if [[ $COUNT -eq 0 ]];
then
        echo "No hay registros para generar archivo"
        exit 1;
fi

#Primero Genera el archivo
#FILE="${1//-}_CfnRechazosCia.txt"
FILE="/home/motor/InOutExe/reportes_IQ/$FECHA_FIN"_CfnRechazosCia.txt
echo "Generando Archivo $FILE"

#echo "SELECT codigo_motor,cod_lugar as CodLugar,codigo_cia as CodSeguro,rut_prestador as RutConvenio,'' as RutCajero,fecha_ingreso,200 as CodTipoRechazo,1 as CodTipoPersona, rut_beneficiario as RutPersona,case when extcoderror='X' then 22 else 21 end as CodMotivoRechazo,num_operacion as NumOperacionSC from tx_cias where fecha_ingreso>='$FECHA_IN' and fecha_ingreso<'$FECHA_FIN' and tx='Certificacion' ORDER BY fecha_ingreso ASC"

/usr/bin/psql -At -F'|#)' -c "SELECT codigo_motor,cod_lugar as CodLugar,codigo_cia as CodSeguro,rut_prestador as RutConvenio,'' as RutCajero,fecha_ingreso,200 as CodTipoRechazo,1 as CodTipoPersona,rut_beneficiario as RutPersona,case when extcoderror='X' then 22 else 21 end as CodMotivoRechazo,num_operacion as NumOperacionSC from tmp_cias where fecha_ingreso>='$FECHA_IN' and fecha_ingreso<'$FECHA_FIN' and tx='Certificacion' and estado<>'CIA_OK' ORDER BY fecha_ingreso ASC" >$FILE

#Verifica Consistencia Lineas del archivo tienen que ser igual al Total de registros
REG=`wc $FILE| awk {'print $1'}`

if [[ $REG -ne $COUNT ]];
then
        echo "Registro Diferentes $COUNT $REG"
        /usr/bin/mail -s "ERROR:Archivo Rechazos Cias IQ Registros distintos FILE=$REG BASE=$CONT"
        exit 1;
fi

exit 1;
:' 


FALTA: Especificar carpeta en donde se guarda el archivo en $FILE > reporte_iq
       Especificar carpeta de destino  > Carga_Diaria/txtCfnRechazosCia

echo "CARGA ARCHIVO"
echo "put $FILE">sube.sftp

IP: 10.100.33.159  puerto: 14225
usuario:rechazoscia 
password=rechazoscia

sftp -b sube.sftp -P 14225 rechazoscia@10.100.33.159:/Carga_Diaria/txCfnRechazosCia

'
exit 1;

