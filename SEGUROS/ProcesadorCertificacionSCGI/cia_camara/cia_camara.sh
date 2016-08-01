#!/bin/bash

#bash -x scrip
#bash -x cia_camara_VidaCamara_Motor

#Saca avisos de folios duplicados por rut
#cd /home/isys/InOutExe
#MAIL="jaime.cossio@acepta.com"
DATE=`/bin/date +'%F %T'`

BASE="motor"
rm -rf VidaCamara_Motor.csv
VARS="(?<=<extCodFinanciador>)[^<]+|(?<=<extCodSeguro>)[^<]+|(?<=<extCodLugar>)[^<]+|(?<=<extNumOperacion>)[^<]+|(?<=<extRutBeneficiario>)[^<]+|(?<=<extRutPrestador>)[^<]+|(?<=<extLisPrest1>)[^<]+|(?<=<extLisPrest2>)[^<]+|(?<=<extLisPrest3>)[^<]+|(?<=<extLisPrest4>)[^<]+|(?<=<extLisPrest5>)[^<]+|(?<=<extLisPrest6>)[^<]+"

TOTAL=`/usr/bin/psql -At -F';' -c "select tx,count(*) from tx_cias where codigo_cia in ('44') and tiempo_ini_cia>='2014-06-28 00:01:00' and tiempo_fin_cia<'2014-07-07 11:59:17' and extcoderror='S' group by tx" $BASE`
echo "TOTAL_REGISTROS:"$TOTAL

REG=`/usr/bin/psql -At -F';' -c "SELECT tx,num_operacion,dia,to_char(tiempo_ini_cia,'YYYYMMDD-HH24:MI:SS'),replace(replace(replace(msgoutput,chr(10),''),chr(13),''),chr(32),''),extfolioauto from tx_cias where codigo_cia in ('44') and tiempo_ini_cia>='2014-06-28 00:01:00' and tiempo_fin_cia<'2014-07-07 11:59:17' and extcoderror='S' and tx<>'Conciliacion' order by tiempo_ini_cia asc" $BASE`
#echo "REGISTOS==="$REG >> test.txt
#exit 1;

DATA=($REG)
I=0;
STR=${DATA[$I]}
NUM_OPER=$(echo $STR | cut -f 1 -d';')
#DIA=$(echo $STR | cut -f 2 -d';')
#FECHA_INI=$(echo $STR | cut -f 2 -d';')

## si archivo no existe escribo encabezado...
if [ ! -f VidaCamara_Motor.csv ]; then
echo "tx;tiempo_ini_cia;extcodfinanciador;extcodseguro;extcodlugar;extnumoperacion;extrutbeneficiario;extrutprestador;extlisprest1;extlisprest2;extlisprest3;extlisprest4;extlisprest5;extlisprest6;cia_resp;folioauto" >> VidaCamara_Motor.csv
fi

IFS=''
while  [ ${#NUM_OPER} -gt 0 ]
do
        #I=`expr $I + 1`
        STR=${DATA[$I]}
	echo $STR
        TX=$(echo $STR | cut -f 1 -d';')
        NUM_OPER=$(echo $STR | cut -f 2 -d';')
        DIA=$(echo $STR | cut -f 3 -d';')
        FECHA_INI=$(echo $STR | cut -f 4 -d';')
        CIA_RESP=$(echo $STR | cut -f 5 -d';')
        FOLIO_AUTO=$(echo $STR | cut -f 6 -d';')
	#echo TX=$TX - NUM_OPER=$NUM_OPER - DIA=$DIA - FECHA_INI=$FECHA_INI - CIA_RESP=$CIA_RESP - FOLIO_AUTO=$FOLIO_AUTO

	TEXTO=$(zgrep $NUM_OPER $DIA* | grep "<extNumOperacion>")

	#Parseo texto separo por ;
	RES=$(echo $TEXTO | grep -oPm1 "$VARS" | tr '\n' ';')
	echo $RES 
	
	RES=$TX";"$FECHA_INI";"$RES";"$CIA_RESP";"$FOLIO_AUTO
	#escribo a archivo
	echo $RES >> VidaCamara_Motor.csv
        I=`expr $I + 1`
done

##while por cada registro de bd...
#zgrep por fecha y valor...

#obtengo texto
#TEXTO="2014062811_CG2_APP.LOG.gz:<MsgInput><extCodFinanciador>1</extCodFinanciador><extCodSeguro>44</extCodSeguro><extCodLugar>13052</extCodLugar><extNumOperacion>37901301</extNumOperacion><extRutBeneficiario>0015786282-0</extRutBeneficiario><extRutPrestador>0076696200-9</extRutPrestador><extLisPrest1>0404006   |00|01|0000015620|0000010740|0404010   |00|01|0000020480|0000014080|</extLisPrest1><extLisPrest2> </extLisPrest2><extLisPrest3></extLisPrest3><extLisPrest4> </extLisPrest4><extLisPrest5> </extLisPrest5><extLisPrest6> </extLisPrest6></MsgInput> ]]></ns1:XML_INPUT>"



