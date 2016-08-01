--Dada una URI determina el nombre de la tabla donde debe estar
CREATE OR REPLACE FUNCTION public.get_parametros(character varying)
 RETURNS varchar
 LANGUAGE plpgsql
AS $function$
DECLARE
    xml1        alias for $1;
        xml2    varchar;
BEGIN

        xml2:=xml1;


        if (get_campo('REQUEST_METHOD',xml2)='GET') then
                xml2:=get_parametros_get(xml2);
        else
                xml2:=get_parametros_post(xml2);
         end if;

        return xml2;

END;
$function$

