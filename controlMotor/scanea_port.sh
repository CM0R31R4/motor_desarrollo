#!/bin/bash

INICIAL="8390"
CANTIDAD="10"

### NO TOCAR =)
FINAL=$(($INICIAL + $CANTIDAD - 1))

for i in $(seq $INICIAL $FINAL); do
       STATUS=`netstat -lt | grep $i | wc -l`
       if [ "$STATUS" -gt "0" ]
       then
               echo $i " esta Arriba"
       else
               echo $i " esta Abajo"
       fi

done
