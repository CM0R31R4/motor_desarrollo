#!/bin/bash

DATA=($REG)
I=0;
STR=${DATA[$I]}
ID=$(echo $STR | cut -f 1 -d';')


PORT_LSTR=80$ID
REQ="<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:imed=\"http://www.multicaja.cl/imed/\">
   <soapenv:Header/>
   <soapenv:Body>
      <imed:transaction>
         <item><name>TIPO_TX</name><value>IMED_VERDER</value></item>
         <item><name>PC_KEY</name><value>PC-KEY</value></item>
         <item><name>COD_LUGAR</name><value>13001</value></item>
         <item><name>RUT_TITULAR</name><value>12168885-9</value></item>
         <item><name>MONTO</name><value>1000</value></item>
         <item><name>VERSION</name><value>2.0</value></item>
      </imed:transaction>
   </soapenv:Body>
</soapenv:Envelope>"


echo "REQ= "$REQ

echo "CURL = "
curl -k -i -X POST -H "Accept-Encoding: deflate" -H "Content-Type: text/xml; charset=UTF-8" -H 'SOAPAction: ""' -H "Host: 200.111.44.187:10005" --data "$REQ" --location "https://200.111.44.187:10005/imed/ImedWebService" -u ImedWebRole:ImedWebRole


