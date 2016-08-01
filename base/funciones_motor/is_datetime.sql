CREATE OR REPLACE FUNCTION public.is_datetime(fecha character varying, formato character varying)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
        d_fecha timestamp without time zone;
        v_fecha varchar;
BEGIN
        d_fecha := to_timestamp(fecha,formato);
        v_fecha := to_char(d_fecha,formato);

        if v_fecha = fecha then
                return 1;
        else
                return 0;
        end if;
EXCEPTION
        when others then
                return 0;
END
$function$
