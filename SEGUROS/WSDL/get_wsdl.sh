#!/bin/bash
PATH1="/home/motor/SEGUROS/WSDL"

for tablas in $(psql -At -f";" -c "select distinct nemo,url,tx from cias_seguros where tx='Anulacion'")
do
	#echo $tablas
	NEMO=$(echo $tablas | cut -f 1 -d '|')
	URL=$(echo $tablas | cut -f 2 -d '|')
	TX=$(echo $tablas | cut -f 3 -d '|')
	FILE_H=$TX"_"$NEMO".h"
	URL_WSDL=$URL"?wsdl"
	DIR1=$PATH1"/"$NEMO"_"$TX
	echo $NEMO,$URL,$TX
	rm -rf $DIR1
	mkdir $DIR1
	cd $DIR1
	#Obtiene Archivos wsdl
	#echo $FILE_H,$URL_WSDL
	wsdl2h -c -s -o $FILE_H $URL_WSDL
	#Si existe el FILE_H
	if [ -f $FILE_H ]; then
		echo "Existe File"
		soapcpp2 -L -a $FILE_H
		
		#Buscamos si existe el req y lo guardamos en la base para uso posterior
		FILE_REQ=$(ls *req.xml)
		echo "File="$FILE_REQ
		#Si existe el archivo
		if [ ${#FILE_REQ} -gt 0 ]; then
			DATA=$(cat $FILE_REQ)
			echo "ACtualiza REQ en BD"
			psql motor -c "select sp_actualiza_req_cia('$DATA','$NEMO','1','$TX')"
		else
			echo "no existe file_req"
		fi;
		
	else
		echo "no existe"
	fi
done
exit 1;

#wsdl2h -c -s -o WsConfirmacion.h http://10.150.73.12/I-med/wsConfirmacion.asmx?wsdl
#soapcpp2 WsConfirmacion.h
