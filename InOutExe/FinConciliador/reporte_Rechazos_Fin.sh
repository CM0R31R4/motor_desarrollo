#!/bin/bash
#Reporta rechazos de Financiadores a Operaciones.

cd /home/motor/InOutExe/CiasConciliador/
mv *.txt Enviados/

BASE="dmotor"

MAIL_CC="jaime.cossio@acepta.com"
#MAIL_CC="claudio.moreira@acepta.com"

FECHA_IN=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP -INTERVAL '1 days','YYYYMMDD')" $BASE`;
FECHA_FIN=`/usr/bin/psql -At -F';' -c "SELECT to_char(CURRENT_TIMESTAMP,'YYYYMMDD')" $BASE`;

REG=`/usr/bin/psql -At -F';' -c "SELECT DISTINCT id_fin, nom_fin FROM parametros_procesos WHERE id_fin <> 100 ORDER BY id_fin ASC" $BASE`

DATA=($REG)
I=0;
STR=${DATA[$I]}
COD_FIN=$(echo $STR | cut -f 1 -d';')
FINANCIADOR=$(echo $STR | cut -f 2 -d';')
#MAIL_DEST=$(echo $STR | cut -f 3 -d';')

#while  [ ${#COD_FIN} -gt 0 ]
#do
        #Para Test, habilitar:
        MAIL_DEST="claudio.moreira@acepta.com"

        COUNT=`/usr/bin/psql -At -F';' -c "SELECT COUNT(*) FROM tx_bono3 b WHERE b.fecha_in_tx >= '$FECHA_IN' AND b.fecha_in_tx < '$FECHA_FIN' AND b.estado IN ('FALLA_API','FALLA_CONEXION_API') 
AND b.tipo_tx IN ('anulabonou','bencertif','coptran','datosprest','envbonis','envbonis_real','envbono','envbono_real','leerutcotiz','solicfolios','validacat','valorizi','valorvari','valtrans') 
AND b.cod_fin IN ('1','11','44','62','63','65','67','68','71','76','78','80','81','88','94','99')" $BASE`

        if [[ $COUNT -gt 0 ]];
        then
                #Primero Genera el archivo
                FILE="/home/motor/InOutExe/CiasConciliador/"$FECHA_IN"_Rechazos_Financiadores.txt"

                #Cabecera
                /usr/bin/psql -At -F';' -c "SELECT 'CANTIDAD;TIPO;CODIGO;FINANCIADOR'" >$FILE

                #Query Reporte
                /usr/bin/psql -At -F';' -c "SELECT COUNT(*) AS CANTIDAD, b.tipo_tx AS TIPO, b.cod_fin AS CODIGO, b.financiador FROM tx_bono3 b WHERE b.fecha_in_tx >= '$FECHA_IN' 
AND b.fecha_in_tx < '$FECHA_FIN' AND b.estado IN ('FALLA_API','FALLA_CONEXION_API') AND b.tipo_tx IN ('anulabonou','bencertif','coptran','datosprest','envbonis','envbonis_real','envbono','envbono_real',
'leerutcotiz','solicfolios','validacat','valorizi','valorvari','valtrans') AND b.cod_fin IN ('1','11','44','62','63','65','67','68','71','76','78','80','81','88','94','99') GROUP BY b.cod_fin, b.financiador, b.tipo_tx ORDER BY b.cod_fin, b.tipo_tx" >>$FILE

                DIF=`cat $FILE | wc -l`

                #Envia el Mail
                /usr/bin/mutt $MAIL_DEST  -s "Financiadores: Errores = $COUNT - Dia=$FECHA_FIN" -a $FILE -c $MAIL_CC < /dev/null

                echo ...Envia Correo a Operador.
        fi

        I=`expr $I + 1`
        STR=${DATA[$I]}
        COD_FIN=$(echo $STR | cut -f 1 -d';')
        FINANCIADOR=$(echo $STR | cut -f 2 -d';')
        MAIL_FIN=$(echo $STR | cut -f 3 -d';')
#done
exit 1;
 
