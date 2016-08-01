#!/bin/bash
#Reporta rechazos de Cias a Operaciones y Mail de Cias

cd /home/motor/InOutExe/CiasConciliador
mv *.txt Enviados/

BASE="motor"

#MAIL_CC="mmoya@i-med.cl,eelias@i-med.cl,vnegrete@i-med.cl,operaciones@acepta.com,jcossio@i-med.cl,farancibia@i-med.cl"
MAIL_CC="jcc@acepta.com"

FECHA_IN=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP -INTERVAL '1 days','YYYYMMDD')" $BASE`;
FECHA_FIN=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP,'YYYYMMDD')" $BASE`;

REG=`/usr/bin/psql -At -F';' -c "SELECT codigo,replace(nombre,' ','_') as nombre ,mail_cia from mail_cias ORDER BY codigo ASC" $BASE`

DATA=($REG)
I=0;
STR=${DATA[$I]}
COD_CIA=$(echo $STR | cut -f 1 -d';')
NEMO=$(echo $STR | cut -f 2 -d';')
MAIL_CIA=$(echo $STR | cut -f 3 -d';')

while  [ ${#COD_CIA} -gt 0 ]
do
        #Para Test. Habilitar
        #MAIL_CIA="jcossio@i-med.cl"
        #MAIL_CC="jcc@i-med.cl"

        #Si tenemos data, genera archivo.
        COUNT=`/usr/bin/psql -At -F';' -c "SELECT count(*) FROM tx_cias WHERE dia>='$FECHA_IN' AND dia<'$FECHA_FIN' AND estado in ('CIA_RECHAZO','CIA_ERROR') AND tx in ('Confirmacion','ConfirmacionBono3','Anulacion','AnulacionBono3') AND codigo_cia='$COD_CIA' " $BASE`

        if [[ $COUNT -gt 0 ]];
        then
                #Primero Genera el archivo
                FILE="/home/motor/InOutExe/CiasConciliador/"$FECHA_IN"_"$NEMO"_Conf_NOK.txt"

                #Cabecera
                #/usr/bin/psql -At -F';' -c "SELECT 'CodCiaSeguro;Tx;FolioBono;NumOperacion;Dia;EstadoTx;CodErrorCia;MensajeCia'" >$FILE

                #Query Reporte
                /usr/bin/psql -At -F';' -c "SELECT codigo_cia,tx,extfoliobono,num_operacion,dia,estado,split_part(split_part(msgoutput,'</extCodError>',1),'<extCodError>',2) as extCodError_Cia, split_part(split_part(msgoutput,'</extMensajeError>',1),'<extMensajeError>',2) as extMensajeError_Cia FROM tx_cias WHERE dia>='$FECHA_IN' AND dia<'$FECHA_FIN' AND estado in ('CIA_RECHAZO','CIA_ERROR') AND tx in ('Confirmacion','ConfirmacionBono3','Anulacion','AnulacionBono3') AND codigo_cia='$COD_CIA' GROUP BY codigo_cia,tx,extfoliobono,num_operacion,dia,estado,msgoutput ORDER BY extfoliobono ASC" >$FILE
                DIF=`cat $FILE | wc -l`

                #Envia el Mail
	       	#/usr/bin/mail -n -r  "Imed.Nocturno@i-med.cl" -a $FILE  -s "Cia_Produccion $NEMO Diferencias=$DIF - Dia=$FECHA_IN" -c $MAIL_CC $MAIL_CIA < /dev/null
		/usr/bin/mutt $MAIL_CIA  -s "Cia_Dev $NEMO: Diferencias=$DIF - Dia=$FECHA_IN" -a $FILE -c $MAIL_CC < /dev/null

                echo ...Envia Correo a Cia $NEMO
        fi

        I=`expr $I + 1`
        STR=${DATA[$I]}
        COD_CIA=$(echo $STR | cut -f 1 -d';')
        NEMO=$(echo $STR | cut -f 2 -d';')
        MAIL_CIA=$(echo $STR | cut -f 3 -d';')
done
exit 1;

