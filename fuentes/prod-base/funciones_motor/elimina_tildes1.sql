CREATE OR REPLACE FUNCTION elimina_tildes(data text)
  RETURNS text AS
$BODY$
import plpy
salida1=''
for c in data:
   if ord(c) >31 and ord(c) < 128:
	salida1=salida1+c
return salida1
$BODY$
  LANGUAGE plpython2u VOLATILE
  COST 100;
