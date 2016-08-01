#!/bin/sh
#La data entrante viene en hex
DATA=`echo $1 |  xxd  -r -p`

/usr/bin/tsql -H 150.10.10.31 -p 1433 -U CMELEC -P IMED01 -ohf <<END_SCRIPT
use AGENCIA_PRUEBA
go
$DATA
go
END_SCRIPT

