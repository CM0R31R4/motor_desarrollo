CREATE OR REPLACE FUNCTION json_to_xml(jsonstr character varying, num_bloque int)
RETURNS character varying AS
$BODY$
DECLARE	jsonstr 	ALIAS FOR $1;
	num_bloque 	ALIAS FOR $2;
	posInicio 	integer;
	posUltimo 	integer;
	seccion 	varchar;
BEGIN	
	posInicio := 0;
	posUltimo := 0;

	FOR i IN 1..num_bloque LOOP
		posInicio := position('{' in jsonstr);
		posUltimo := position('}' in jsonstr);
		seccion := substring(jsonstr from posInicio for posUltimo);
		jsonstr := overlay(jsonstr placing '' from posInicio for posUltimo);
		
		IF i = num_bloque THEN
			EXIT;
		END IF;
	END LOOP;

   
    RETURN  seccion;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION json_to_xml(character varying, num_bloque int)
  OWNER TO motor;
