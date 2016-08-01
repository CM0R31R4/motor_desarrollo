CREATE OR REPLACE FUNCTION control.sp_get_number(character varying, character varying, bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
declare
        xml1            alias for $1;
        campo1          alias for $2;
        defecto1        alias for $3;
        xml2   varchar;
        valor_n varchar;
begin
        xml2:=xml1;
        valor_n:=get_campo(campo1,xml2);
        --Si no es numerico
        if mc_isnumber(valor_n)=0 then
                return defecto1;
        else
                return valor_n::bigint;
        end if;
end
$function$

