#!/bin/bash

# Base de Datos.
BASE="dmotor"

S3CMD="/usr/bin/s3cmd"
S3CONFIG="/home/motor/.s3cfg"
S3OPT="-c $S3CONFIG --disable-multipart -r -p"

# Directorio donde busca datos.
MAINPATH="/home/motor/"

# Obtiene listado de directorios a respaldar.
LOGDIRS=( "ApiMysqlRME" "ApiPercona" "ApiPerconaLiq" "ApiPG" "ApiSyBase" "BNO_BANMEDICA" "BNO_CCHC" "BNO_COLMENA" "BNO_CONSALUD" "BNO_CRUZBLANCA" "BNO_CRUZDELNORTE" "BNO_FERROSALUD" "BNO_FONASA" "BNO_FUNDACION" "BNO_FUSAT" "BNO_MASVIDA" "BNO_VIDACAMARA" "CME_MASVIDA" "CONFIRMA_BONOS" "Listener" "logs-s3" "Pxml" "PxmlDec" "PxmlLiquidador" "PxmlMonitor" "SEGUROS/ProcesaColasCias" "SEGUROS/ProcesadorCertificacionSCGI" "SEGUROS/ProcesadorSCGI")

echo "--> Inicio Respaldo."

function generate_codmotor {
	# Obtiene hostname para construir el nombre del bucket.
	ID_CODMOTOR=`hostname`
        echo "ID Motor : $ID_CODMOTOR"
}

function get_date {
        DATENOW=$(date +"%Y%m%d")
        DATEOLD=$(echo "$DATENOW - 1"|bc)
}

function compress_log {
        for FOLDER in "${LOGDIRS[@]}"
        do
		# Buscar archivos terminados en .LOG
                FILES=("$MAINPATH$FOLDER/*.LOG")
                
		echo "Comprimiento en : $FILES"

		if [ ${#FILES[@]} -gt 0 ]
                then
			# Entrando en directorio...
                       	cd "$MAINPATH$FOLDER"
                     	
			for i in $(ls *.LOG |egrep -v "$DATENOW|$DATEOLD")
                       	do
                               	echo "Comprimiendo gzip $i"
                               	gzip $i
                       	done
		fi
        done
}

function check_bucket {
	# Consulta por la existencia del bucket antes de respaldar.
	if s3cmd ls "s3://DESA_MOTOR_$ID_CODMOTOR" /dev/null 2>&1 | grep 'NoSuchBucket'
	then
		echo "Crea bucket : s3://DESA_MOTOR_$ID_CODMOTOR"

		# Crea bucket.
		s3cmd mb s3://DESA_MOTOR_$ID_CODMOTOR

		PATH_MOTOR="s3://DESA_MOTOR_$ID_CODMOTOR/"
	else
		PATH_MOTOR="s3://DESA_MOTOR_$ID_CODMOTOR/"
	fi
}

function upload_log {
	# Comienza a subir archivos comprimidos a Amazon.
        for FOLDER in "${LOGDIRS[@]}"
        do
                echo "Entrando a : $MAINPATH$FOLDER"
                
		FILES=("$MAINPATH$FOLDER/*.gz")
                if [ ${#FILES[@]} -gt 0 ]
                then
                        cd "$MAINPATH$FOLDER"
                        #echo "$S3CMD $S3OPT *.gz"
			
			# Busca los seis primeros caracteres de los nombres de archivos,
                        # los corta, ordena y guarda para armar los nombres de las subcarpetas.
                        for SUBCARPETA in $(ls *.gz | cut -c -6 | sort -u | uniq)
                        do
				echo "Subcarpeta : $SUBCARPETA"
				
				for i in $(ls *.gz |egrep -v "$DATENOW|$DATEOLD")
                        	do
					# Busca coincidencias entre el nombre de la subcapeta 
					# y el archivo que se va a subir.
					if [ "$i" != "${i%$SUBCARPETA*}" ]
                                        then
						echo "Subiendo : $S3CMD put $S3OPT $i $PATH_MOTOR$FOLDER/$SUBCARPETA/"
						PATH_S3CMD="$PATH_MOTOR$FOLDER/$SUBCARPETA/"
                        
						if $S3CMD put $S3OPT $i $PATH_S3CMD
                                		then
							# Elimina localmente el archivo respaldado en Amazon.
                                        		rm -f $i
                                        		echo "Subido : $i"
                                		else
                                        		echo "Error al subir : $i"
                                		fi
					fi
				done
                        done
                fi
        done
}

generate_codmotor
get_date
compress_log
check_bucket
upload_log

echo "--> Respaldo Terminado."
