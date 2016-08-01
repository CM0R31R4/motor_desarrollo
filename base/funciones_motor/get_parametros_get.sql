--Dada una URI determina el nombre de la tabla donde debe estar 
CREATE OR REPLACE FUNCTION public.get_parametros_get(character varying)
 RETURNS varchar
 LANGUAGE plpgsql
AS $function$
DECLARE
    	xml1	alias for $1;
	xml2	varchar;
	part1	integer;
	param1	varchar;
	data1	varchar;
BEGIN
 	xml2:=xml1;
    	part1 :=1;
	data1:=get_campo('QUERY_STRING',xml2);
--    	xml2 := logapp(xml2,'get_parametros_get='||data1);
    	param1 := split_part(data1,'&',part1);
	--raise notice 'param1=(%)',param1;
--    	xml2 := logapp(xml2,'get_parametros_get='||param1);
	while param1 <> '' 
	loop
        	xml2 := put_campo(xml2,split_part(param1,'=',1),split_part(param1,'=',2));
--		xml2 := logapp(xml2,'get_parametros_get='||split_part(param1,'=',2));
        	part1 := part1 + 1;
        	param1 := split_part(data1,'&',part1);
    	end loop;
    return xml2;
END;
$function$

