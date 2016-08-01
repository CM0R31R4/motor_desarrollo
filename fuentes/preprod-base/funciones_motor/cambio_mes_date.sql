CREATE OR REPLACE FUNCTION cambia_mes(varchar)
RETURNS VARCHAR AS $$
DECLARE
    var_fecha alias FOR $1;
    mes1        varchar;
    mes2        varchar;
BEGIN
    --12-AUG-13
    mes1:=substring(var_fecha,4,3);
    mes2:=case mes1 when 'ENE' then 'JAN' when 'ABR' then 'APR' when 'AGO' then 'AUG' when 'DIC' then 'DEC' else mes1 end;

    var_fecha:=substring(var_fecha,1,2)||'-'||mes2||'-'||substring(var_fecha,8,2);
    RETURN var_fecha;
END;
$$ LANGUAGE 'plpgsql';
