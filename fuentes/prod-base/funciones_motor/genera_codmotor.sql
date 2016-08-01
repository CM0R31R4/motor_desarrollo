drop function genera_codmotor();
CREATE OR REPLACE FUNCTION genera_codmotor()
RETURNS bigint AS $$

declare
	stIpMotores	ip_motores%ROWTYPE;	
	ip_motor1	varchar;
	id_motor1	integer;
	cod_motor1	bigint;
	

BEGIN
	-- Obtiene IP de la maquina.
	-- Llamada a funcion 'getipserver' pasando el parametro 'eth0'.
	ip_motor1:=getipserver('eth0');

	-- Busca ID del Motor, segun la IP de la maquina.
	select * into stIpMotores from ip_motores where ip_motor=ip_motor1;
	if not found then
		return 0; 
	end if;
	
	--Saco el id que sera usado para concatenarlo al correlativo_motor
	id_motor1:=stIpMotores.id;
	
	-- Devuelve el Codigo de Motor segun el ID.
	cod_motor1:=((nextval('correlativo_motor') * 100)::bigint + id_motor1);

	-- Retorna Codigo.
	return cod_motor1;

END;

$$
LANGUAGE 'plpgsql';

