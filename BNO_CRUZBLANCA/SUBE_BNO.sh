#./SUBE_BN3.sh stop BANMEDICA
# $1 = comando		start | stop | reload
# #2 = financiador	FONASA | MASVIDA | BANMEDICA | CONSALUD	

DIR=`pwd`
#cd $DIR
echo '>> Reload API ## PORT:8299 <<'
$DIR/sube_api $1 $2
echo '>> Reload API 8299 OK..<<'
echo '                                       '

echo '>> Reload PXML ## PORT:8199 <<'
$DIR/sube_pxml $1 $2
echo '>> Reload PXML 8199 OK..<<'
echo '                                       '

#echo '>> Reload LSTR ## PORT:8099 <<'
#$DIR/sube_lstr $1 $2
#echo '>> Reload LSTR 8099 OK..<<'
#echo '                                       '

