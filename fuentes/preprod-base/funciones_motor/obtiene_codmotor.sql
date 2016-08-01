CREATE OR REPLACE FUNCTION obtiene_codmotor()
RETURNS varchar AS $$

declare
        ip_maquina      varchar;
        id_motor        integer;
        cod_motor       bigint;

BEGIN
	-- Obtiene IP de la maquina.
	-- Llamada a funcion 'getipserver' pasando el parametro 'eth0'.
        ip_maquina:=getipserver('eth0');
        --raise notice 'CM_=%',ip_maquina;
	
	-- Busca ID de Motor segun la IP de la maquina.
        SELECT id INTO id_motor FROM host_motor WHERE host = ip_maquina;
	--raise notice 'CM_=%',id_motor;

	-- Devuelve el Codigo de Motor SIN el ID.
        SELECT (((nextval('correlativo_motor') * 100)::bigint + id_motor) / 100) INTO cod_motor;
	--raise notice 'CM_=%',cod_motor;

	-- Retorna Codigo.
        RETURN cod_motor;

END;

$$
LANGUAGE 'plpgsql';

