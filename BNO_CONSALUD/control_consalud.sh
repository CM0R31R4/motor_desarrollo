DIA=$(date +%Y%m%d)
#cd /home/motor/BNO_CONSALUD/
echo $DIA

FILE="/home/motor/BNO_CONSALUD/"$DIA"_PYT.LOG"
BUSQUEDA=1000

#Verificamos si tiene el error de desconexion de Oracle

TOTAL_ERROR_06508=$(tail -n $BUSQUEDA $FILE  |grep '517:5006-ORA-06508' |wc -l)
TOTAL_ERROR_44=$(tail -n $BUSQUEDA $FILE  |grep 'ERROR PROC: 44' |wc -l)
TOTAL_PARTIDA=$(tail -n $BUSQUEDA $FILE |grep 'Starting server loop' |wc -l)

echo "Errores Encontrados ERROR_06508=$TOTAL_ERROR_06508 / ERROR_44=$TOTAL_ERROR_44"  
#BODY="Error ERROR_06508=$TOTAL_ERROR_06508 / ERROR_44=$TOTAL_ERROR_44"

#Si ya se reinicio no hacemos nada
if [[ $TOTAL_PARTIDA -gt 0 ]]; then
        echo "Recien Reiniciado"
        exit 1;
fi

#Si tiene errores lo reiniciamos
if [[ $TOTAL_ERROR_06508 -gt 0 ]] && [[ $TOTAL_ERROR_44 -gt 0 ]]; then
#if [[ $TOTAL_ERROR06508 -gt 0 ]]; then
        echo "Reiniciamos CONSALUD API"
        /home/motor/BNO_CONSALUD/sube_api reload CONSALUD 
	/usr/bin/mutt jcossio@i-med.cl,maite.garcia@acepta.com,claudio.moreira@acepta.com -s "Dev1: Consalud Presenta Error en su BaseDatos " < /dev/null
else
        echo "No hay errores de desconexion"
fi
