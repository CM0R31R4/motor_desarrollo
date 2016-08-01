
#!/bin/bash
#
# Shell que entrega un total (Cant y Montos) de Bonos Emitidos y confirmados en el Motor.
# Aplica para Financiadores y CompañiasSeguros
# Los totales deberan ser comparados con data obtenida desde el IQ. Por ahora el merge es manual. 

cd /home/motor/InOutExe/

#Base de Datos.
BASE="dmotor"

#Host.
HOST=`hostname`

#Directorio de Reporte.
DIRECTORIO="/home/motor/InOutExe/reportes_IQ"

#Fecha para formar el nombre del archivo.
DATE_FILE=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP -INTERVAL '0 days','YYYY-MM-DD');" $BASE`;

#Fechas de Inicio y Termino.
DATE_INI=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP -INTERVAL '1 days','YYYYMMDD');" $BASE`;
DATE=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP -INTERVAL '0 days','YYYYMMDD');" $BASE`;

#Fechas de Inicio y Termino cabecera de correo.
DATE_INI_CAB=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP -INTERVAL '1 days','YYYY-MM-DD');" $BASE`;
DATE_CAB=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP -INTERVAL '0 days','YYYY-MM-DD');" $BASE`;

#Arma nombre para archivo de respaldo y log.
FILE=$DIRECTORIO"/total_bonos_emitidos_"$DATE_FILE".html"

#Mail destinatario del reporte.
#MAIL="claudio.moreira@acepta.com"

#Verifica si ya existe archivo de reporte.
if [ -e "$FILE" ]; then
        rm -f $FILE
fi

#Consulta por total de Bonos sin Cias.
REG_TotBonosSinCias=`/usr/bin/psql -At -F';' -c "SELECT REPLACE(to_char(COUNT(cod_fin),'FM999,999,999,990D'),',','.') AS bonos_sin_cia,
							REPLACE(to_char(SUM(COALESCE(monto_aporte_total, 0)),'FM999,999,999,990D'),',','.') AS total_bonos_sin_cias
						 FROM   tx_bono3
						 WHERE  tipo_tx IN ('envbonis_real', 'envbono_real')
						 AND    codigo_resp = '1'
						 AND    fecha_emision BETWEEN '$DATE_INI' AND '$DATE'
						 AND    xml_input <> 'CLEAN';" $BASE`;

DATA_BonosSinCias=($REG_TotBonosSinCias)
J=0;
STR_BSC=${DATA_BonosSinCias[$J]}
BONOS_SIN_CIAS=$(echo $STR_BSC | cut -f 1 -d';')
TOTAL_BONOS_SIN_CIAS=$(echo $STR_BSC | cut -f 2 -d';')

#Consulta por total de Bono2 con Cias.
REG_TotBono2ConCias=`/usr/bin/psql -At -F';' -c "SELECT	REPLACE(to_char(COUNT(codigo_cia),'FM999,999,999,990D'),',','.') AS bono2_con_cia,
							REPLACE(to_char(SUM(COALESCE(monto_bonif, 0)),'FM999,999,999,990D'),',','.') AS total_bono2_con_cia
						 FROM   tx_cias
						 WHERE  tx IN ('Confirmacion')
						 AND    extcoderror = 'S'
						 AND    msginput <> ''
						 AND    fecha_emision BETWEEN '$DATE_INI' AND '$DATE';" $BASE`;

DATA_Bono2ConCias=($REG_TotBono2ConCias)
K=0;
STR_B2CC=${DATA_Bono2ConCias[$K]}
BONO2_CON_CIAS=$(echo $STR_B2CC | cut -f 1 -d';')
TOTAL_BONO2_CON_CIAS=$(echo $STR_B2CC | cut -f 2 -d';')

#Consulta por total de Bono3 con Cias.
REG_TotBono3ConCias=`/usr/bin/psql -At -F';' -c "SELECT REPLACE(to_char(COUNT(codigo_cia),'FM999,999,999,990D'),',','.') AS bono3_con_cia,
						 	REPLACE(to_char(SUM(COALESCE(monto_bonif, 0)),'FM999,999,999,990D'),',','.') AS total_bono3_con_cia
						 FROM   tx_cias
						 WHERE  tx IN ('ConfirmacionBono3')
						 AND    extcoderror = 'S'
						 AND    msginput <> ''
						 AND    fecha_emision BETWEEN '$DATE_INI' AND '$DATE';" $BASE`;

DATA_Bono3ConCias=($REG_TotBono3ConCias)
L=0;
STR_B3CC=${DATA_Bono3ConCias[$L]}
BONO3_CON_CIAS=$(echo $STR_B3CC | cut -f 1 -d';')
TOTAL_BONO3_CON_CIAS=$(echo $STR_B3CC | cut -f 2 -d';')

#Consulta por registros para generar reporte.
REG=`/usr/bin/psql -At -F';' -c "SELECT codigo, upper(entidad), bonos, total
                                 FROM   (       SELECT  cod_fin                 AS codigo,
                                                        financiador             AS entidad,
                                                        REPLACE(to_char(COUNT(cod_fin),'FM999,999,999,990D'),',','.') AS bonos,
                                                        --REPLACE(to_char(SUM(COALESCE(CAST(split_part(split_part(xml_input,'</extMontoAporteTotal>',1),'<extMontoAporteTotal>',2) AS INTEGER), 0)),'FM999,999,999,990D'),',','.') AS total
 	                                               	REPLACE(to_char(SUM(COALESCE(monto_aporte_total, 0)),'FM999,999,999,990D'),',','.') AS total
						FROM    tx_bono3
                                                WHERE   tipo_tx IN ('envbonis_real', 'envbono_real')
                                                AND     codigo_resp = '1'
                                                AND     fecha_emision BETWEEN '$DATE_INI' AND '$DATE'
                                                AND     xml_input <> 'CLEAN'
                                                GROUP BY cod_fin, financiador
                                        UNION
                                                SELECT  codigo_cia::INTEGER     AS codigo,
                                                        nemo                    AS entidad,
                                                        REPLACE(to_char(COUNT(codigo_cia),'FM999,999,999,990D'),',','.') AS bonos,
                                                        --REPLACE(to_char(SUM(COALESCE(CAST(split_part(split_part(msginput,'</ExtMtoBonif>',1),'<ExtMtoBonif>',2) AS INTEGER), 0)),'FM999,999,999,990D'),',','.') AS total
                                                	REPLACE(to_char(SUM(COALESCE(monto_bonif, 0)),'FM999,999,999,990D'),',','.') AS total
						FROM    tx_cias
                                                WHERE   tx IN ('Confirmacion', 'ConfirmacionBono3')
                                                AND     extcoderror = 'S'
                                                AND     msginput <> ''
                                                AND     fecha_emision BETWEEN '$DATE_INI' AND '$DATE'
                                                GROUP BY codigo_cia, nemo ) AS bonos_emitidos
                                 ORDER BY  codigo ASC;" $BASE`;

DATA=($REG)
I=0;
STR=${DATA[$I]}
CODIGO=$(echo $STR | cut -f 1 -d';')
ENTIDAD=$(echo $STR | cut -f 2 -d';')
BONOS=$(echo $STR | cut -f 3 -d';')
TOTAL=$(echo $STR | cut -f 4 -d';')

#Hora de Inicio.
HORA_INI=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP,'YYYY-MM-DD HH24:MI:SS')" $BASE`;

echo "<html>" >> $FILE
echo "<body>" >> $FILE
echo "<table>" >> $FILE
echo "<tr>" >> $FILE
echo "<td>Hora de Inicio del Reporte : <b>$HORA_INI</b></td>" >> $FILE
echo "</tr>" >> $FILE
echo "<tr>" >> $FILE
echo "<td>Desde el <b>$DATE_INI_CAB</b> hasta el <b>$DATE_CAB</b></td>" &>> $FILE
echo "</tr>" >> $FILE
echo "</table>" >> $FILE
echo "<br>" >> $FILE
echo "<table width='450px'>" >> $FILE
echo "<tr>" >> $FILE

if [[ $BONOS_SIN_CIAS -eq 0 ]]; then
	echo "<td> </td>" >> $FILE
else
	echo "<td>Total de Bonos sin Cias. :</td><td width='13%' align='right'><b>$BONOS_SIN_CIAS</b></td><td width='15%' align='right'>Monto : </td><td width='25%' align='right'><b>$ $TOTAL_BONOS_SIN_CIAS</b></td>" >> $FILE
fi

echo "</tr>" >> $FILE
echo "<tr>" >> $FILE

if [[ $BONO2_CON_CIAS -eq 0 ]]; then
	echo "<td> </td>" >> $FILE
else
	echo "<td>Total de Bono 2.0 con Cias. :</td><td width='13%' align='right'><b>$BONO2_CON_CIAS</b></td><td width='15%' align='right'>Monto : </td><td width='25%' align='right'><b>$ $TOTAL_BONO2_CON_CIAS</b></td>" >> $FILE
fi

echo "</tr>" >> $FILE
echo "<tr>" >> $FILE

if [[ $BONO3_CON_CIAS -eq 0 ]]; then
	echo "<td> </td>" >> $FILE
else
	echo "<td>Total de Bono 3.0 con Cias. :</td><td width='13%' align='right'><b>$BONO3_CON_CIAS</b></td><td width='15%' align='right'>Monto : </td><td width='25%' align='right'><b>$ $TOTAL_BONO3_CON_CIAS</b></td>" >> $FILE	
fi

echo "</tr>" >> $FILE
echo "</table>" >> $FILE
echo "<br>" >> $FILE
echo "<table width='450px'>" >> $FILE
echo "<th>Codigo</th>" >> $FILE
echo "<th>Entidad</th>" >> $FILE
echo "<th>Bonos</th>" >> $FILE
echo "<th>Total</th>" >> $FILE

#Busca registros para generar reporte.
while [ ${#CODIGO} -gt 0 ]
do
        echo "<tr>" >> $FILE
                echo "<td width='20%' align='left'>$CODIGO</td>" >> $FILE
                echo "<td width='30%' align='left'>$ENTIDAD</td>" >> $FILE
                echo "<td width='15%' align='right'>$BONOS</td>" >> $FILE
                echo "<td width='35%' align='right'>$ $TOTAL</td>" >> $FILE
        echo "</tr>" >>  $FILE

        I=`expr $I + 1`
        STR=${DATA[$I]}
        CODIGO=$(echo $STR | cut -f 1 -d';')
        ENTIDAD=$(echo $STR | cut -f 2 -d';')
        BONOS=$(echo $STR | cut -f 3 -d';')
        TOTAL=$(echo $STR | cut -f 4 -d';')
done &>> $FILE

echo "</table>" >> $FILE
echo "</body>" >> $FILE
echo "</html>" >> $FILE

/usr/bin/mutt -e 'set content_type="text/html"' $MAIL -s "[$HOST] Total Bonos Emitidos $DATE_INI" < $FILE

exit 1;

