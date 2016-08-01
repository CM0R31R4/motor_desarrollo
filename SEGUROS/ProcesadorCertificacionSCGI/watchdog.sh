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

#cd $2
#pwd
MODULO="Procesa_Cert_SCGI"
START="sube_pxml start"
MAIL="farancibia@i-med.cl,jcossio@i-med.cl"
CC="farancibia@i-med.cl,jcossio@i-med.cl"
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
   RUTA="/home/motor/SEGUROS/ProcesadorCertificacionSCGI"
   echo "$RUTA/$START"
   $RUTA/$START 2>&1
   FILE=/tmp/watchdog_$MODULO.txt
   echo "$MODULO was not running and was started on `$DATE`" > $FILE
   $CMD -s "Proceso $MODULO Abajo" $MAIL < $FILE
   #$MAIL -s "Proceso $MODULO Abajo" -a $FILE -c $CC $MAIL 
   #$MAIL -n -s "Proceso $MODULO Abajo" -c $NOTIFYCC $NOTIFY < $FILE
   $RM -f $FILE
   ;;
esac




