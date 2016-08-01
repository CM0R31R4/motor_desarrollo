#!/bin/bash
#
# watchdog
#
# Run as a cron job to keep an eye on what_to_monitor which should always
# be running. Restart what_to_monitor and send notification as needed.
#
# This needs to be run as root or a user that can start system services.
#
# Revisions: 0.1 (20100506), 0.2 (20100507)
#/home/motor/controlMotor/watchdog.sh 
#API_MASVIDA_BNO 
#"/home/motor/BNO_MASVIDA/"
#"./sube_api reload MASVIDA" 
#jaime.cossio@acepta.com

#$1 = Nombre que identifica MODULO (LSTR_MASVIDA_BNO)
#$2 = Directorio donde esta el ejecutable
#$2 = Ruta donde esta el Sube (/home/motor/MASVIDA_BNO/sube_lstr reload MASVIDA)
#$3 = Nombre del ID (MASVIDA)
#$4 = Mail
#echo $1
#echo $2
#echo $3
#echo $4

#Evita Senales
#trap 'echo "Senal EXIT Bloqueada"' EXIT

cd $2
#pwd
MODULO="$1"
START="$3"
MAIL="$4"
CC="$4"
GREP="/bin/grep"
PS="/bin/ps"
NOP="/bin/true"
DATE="/bin/date"
#CMD="/usr/bin/mutt"
CMD="/usr/bin/mail"
RM="/bin/rm"

$PS -ef | $GREP -v grep | $GREP -v watchdog | $GREP $MODULO >/dev/null 2>&1
case "$?" in
   0)
   # It is running in this case so we do nothing.
   $NOP
   ;;
   1)
   #date
   echo "`$DATE`: $MODULO is NOT RUNNING. Starting $MODULO and sending notices."
   RUTA=`pwd`
   echo "RUTA=$RUTA/START=$START"
   $RUTA/$START 2>&1
   FILE=/tmp/watchdog_$MODULO.txt
   echo "$MODULO was not running and was started on `$DATE`" > $FILE
   $CMD -s "10.100.32.177 -> Proceso $MODULO Abajo" $MAIL < $FILE
   #$MAIL -s "Proceso $MODULO Abajo" -a $FILE -c $CC $MAIL 
   #$MAIL -n -s "Proceso $MODULO Abajo" -c $NOTIFYCC $NOTIFY < $FILE
   $RM -f $FILE
   ;;
esac




