CREATE OR REPLACE FUNCTION xml_to_json(jsonstr character varying, num_bloque int, text_ini character varying, text_fin character varying)
RETURNS character varying AS
$BODY$
DECLARE	jsonstr 	ALIAS FOR $1;
	num_bloque 	ALIAS FOR $2;
	text_ini	ALIAS FOR $3;
	text_fin	ALIAS FOR $4;
	posInicio 	integer;
	posUltimo 	integer;
	seccion 	varchar;
BEGIN	
	posInicio := 0;
	posUltimo := 0;

	FOR i IN 1..num_bloque LOOP
		posInicio := position(text_ini in jsonstr);
		posUltimo := position(text_fin in jsonstr);
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
ALTER FUNCTION xml_to_json(character varying, num_bloque int, text_ini character varying, text_fin character varying)
  OWNER TO motor;
