

for files in $(ls *.LOG) 
do
	echo $files
	tr '\n' '%' < $files  > $files.tr
	sed -i 's/> Codigo Cia=44%/> Codigo Cia=44/g' $files.tr
	sed -i 's/<SALTO>/\\n/g' $files.tr
	grep 'Codigo Cia=44' $files.tr > $files.ok
	exit 1;
done
exit 1;
