DATE=`/bin/date +'%F  %T'`
#DATE=`/bin/date +'%T'`
FECHA=`/bin/date +'%Y%m%d'`

echo '################   '$DATE'   ################'
echo '### Reload APIS MSQL ###'
/home/motor/BNO_MASVIDA/./sube_api borralog
/home/motor/BNO_MASVIDA/./sube_api reload
/home/motor/CME_MASVIDA/./sube_api borralog
/home/motor/CME_MASVIDA/./sube_api reload
echo '----------------------------------------------'
#sleep 3;
#/home/motor/ApiMSQL_CCHC/./sube borralog
#/home/motor/ApiMSQL_CCHC/./sube reload
#echo '------------------------------'
#sleep 3;
#/home/motor/ApiMSQL_FERROSALUD/./sube borralog
#/home/motor/ApiMSQL_FERROSALUD/./sube reload
#echo '------------------------------'
#sleep 3;
#/home/motor/ApiMSQL_VIDACAMARA/./sube borralog
#/home/motor/ApiMSQL_VIDACAMARA/./sube reload
#echo '------------------------------'
#sleep 3;
echo '### Reload APIS MSQL OK..###'

#echo '### Reload Apis ORACLE ###'
##mv /home/motor/ApiORACLE_BANMEDICA/LOG_banmedica.txt /home/motor/ApiORACLE_BANMEDICA/LOG_banmedica.txt_$FECHA
#/home/motor/ApiORACLE_BANMEDICA/./sube reload
#echo '------------------------------'
#sleep 3;
##mv /home/motor/ApiORACLE_CONSALUD/LOG_consalud.txt /home/motor/ApiORACLE_CONSALUD/LOG_consalud.txt_$FECHA
#/home/motor/ApiORACLE_CONSALUD/./sube reload
#echo '------------------------------'
#sleep 3;
##/home/motor/ApiORACLE_FUNDACION/./sube borralog
#/home/motor/ApiORACLE_FUNDACION/./sube reload
#echo '------------------------------'
#sleep 3;
##/home/motor/ApiORACLE_FUSAT/./sube borralog
#/home/motor/ApiORACLE_FUSAT/./sube reload
#echo '------------------------------'
##sleep 3;
##/home/motor/ApiORACLE_CHUQUICAMATA/./sube borralog
##/home/motor/ApiORACLE_CHUQUICAMATA/./sube reload
##echo '------------------------------'
##sleep 3;
##/home/motor/ApiORACLE_RIOBLANCO/./sube borralog
##/home/motor/ApiORACLE_RIOBLANCO/./sube reload
##echo '------------------------------'
##sleep 3;
##/home/motor/ApiORACLE_SANLORENZO/./sube borralog
##/home/motor/ApiORACLE_SANLORENZO/./sube reload
##echo '------------------------------'
##sleep 3;
##/home/motor/ApiORACLE_VIDATRES/./sube borralog
##/home/motor/ApiORACLE_VIDATRES/./sube reload
##echo '------------------------------'
#sleep 3;
##home/motor/ApiORACLE_CRUZDELNORTE/./sube borralog
#/home/motor/ApiORACLE_CRUZDELNORTE/./sube reload
#echo '------------------------------'
#sleep 3;
#echo '### Reload Apis ORACLE OK..###'

#echo '### Reload Apis SYBASE ###'
#/home/motor/ApiSYBASE_COLMENA/./sube borralog
#/home/motor/ApiSYBASE_COLMENA/./sube reload
#echo '------------------------------'
#sleep 3;
#/home/motor/ApiSYBASE_CRUZBLANCA/./sube borralog
#/home/motor/ApiSYBASE_CRUZBLANCA/./sube reload
#echo '------------------------------'
#sleep 3;
#echo '### Reload Apis SYBASE OK..###'





