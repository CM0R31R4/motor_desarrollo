SEG1=`date +%s`
MILS1=`date +%N`
HORA1=`echo "scale=8; ((($SEG1*1000000000+$MILS1)))" | bc`
echo "$SEG1 $MILS1"
echo $HORA1 

for i in {0..200}
do
    	
	SEG2=`date +%s`
	MILS2=`date +%N`
	HORA2=`echo "scale=8; ((($SEG2*1000000000+$MILS2)))" | bc`
	echo "$SEG2 : $MILS2"   
	echo $HORA2		
	DIF_TIME=`echo "scale=8; (($HORA2-$HORA1)/1000000000)" | bc`
	#DIF_TIME=`echo "scale=8; ((($SEG1*1000+$MILS1) - ($SEG2*1000+$MILS2))) / 1000000000" | bc`
	#DIF_TIME=($HORA_FIN - $HORA_IN)
	echo "DIF_TIME $DIF_TIME"
done
