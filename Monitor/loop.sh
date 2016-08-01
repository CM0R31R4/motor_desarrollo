HORA_IN=`date +%H:%M:%S.%N`
HORA_IN1=`date +%H:%M:%s.%N`
echo "HORA_IN=$HORA_IN - HORA_IN1=$HORA_IN1"

exit 1;
for i in {0..30}
do
    	
	#NEXT_DATE=$(date +%m-%d-%Y -d "$DATE + $i day")
	HORA_FIN=`date +%H+%M+%S+%N`  	
	#echo "HORA_FIN $HORA_FIN"
   
	DIF_TIME=`echo "scale=8; ($HORA_FIN - $HORA_IN) / 1000000000" | bc`
	#DIF_TIME=($HORA_FIN - $HORA_IN)
	echo "DIF_TIME $DIF_TIME"
done
