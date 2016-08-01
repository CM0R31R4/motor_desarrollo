CREATE OR REPLACE FUNCTION control.sp_suma_campo(character varying, character varying, character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1            alias for $1;
        campo1          alias for $2;
        campo_suma1     alias for $3;
        xml2            varchar;
        valor_n         varchar;
        valor_sumar     varchar;
begin

RAISE NOTICE 'JCC_ ESTAMOS EN LA SUMA ...............';

        xml2:=xml1;
        valor_n:=get_campo(campo1,xml2);
        valor_sumar:=get_campo(campo_suma1,xml2);
        --Si no es numerico el campo a sumar...
        if mc_isnumber(valor_sumar)=0 then
                RAISE NOTICE 'JCC_ EL CAMPO NO ES NUMERICO ...............';
                return xml2;
        end if;

        --Si no es numerico el valor original
        if mc_isnumber(valor_n)=0 then
                --El valor sale el a sumar
                xml2:=put_campo(xml2,campo1,valor_sumar);
                RAISE NOTICE 'JCC_ EL CAMPO NO ES NUMERICO EL VALOR ORIGINAL ...............';
                return xml2;
        end if;
        --Los 2 son numericos, los sumo
        xml2:=put_campo(xml2,campo1,(valor_n::bigint+valor_sumar::bigint)::varchar);
        RAISE NOTICE 'JCC_ ESTOY SUMANDO ...............';

        return xml2;
end
$function$

