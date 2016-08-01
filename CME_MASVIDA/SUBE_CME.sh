#./SUBE_CME.sh stop MASVIDA
# $1 = comando		start | stop | reload
# #2 = financiador	FONASA | MASVIDA | BANMEDICA | CONSALUD	

DIR=`pwd`
#echo `pwd`
#cd $DIR

#echo '>> Reload API ## PORT:8788 <<'
#$DIR/sube_api $1 $2
#echo '>> Reload API 8788 OK..<<'
#echo '                                       '

#echo '>> Reload API ## PORT:8789 <<'
#$DIR/sube_api_2 $1 $2_2
#echo '>> Reload API 8789 OK..<<'
#echo '                                       '

echo '>> Reload PXML ## PORT:8688 <<'
$DIR/sube_pxml $1 $2
echo '>> Reload PXML 8688 OK..<<'
echo '                                       '

#echo '>> Reload LSTR ## PORT:8588 <<'
#DIR/sube_lstr $1 $2
#"echo '>> Reload LSTR 8588 OK..<<'
#echo '                                       '

