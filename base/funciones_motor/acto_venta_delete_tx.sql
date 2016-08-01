CREATE OR REPLACE FUNCTION acto_venta_delete_tx(integer, varchar)
RETURNS varchar AS $$
DECLARE
	
	num_api		alias for $1;
	xml1            alias for $2;
        xml2            varchar;

	id1		bigint;
BEGIN
	xml2 		:=xml1;
	xml2            :=logapp(xml2,'Entrando en DELETE API-1');	

	-- Extrae codigo motor.
	id1      :=get_campo('COD_MOTOR_API_1',xml2)::bigint;
	
	-- Elimina.
	DELETE FROM tx_ActoVentaXml WHERE id = id1::bigint;
	
	xml2:=logapp(xml2,'Borra Acto de Venta API-1.');

	-- Estable secuencia.
        xml2:=put_campo(xml2,'__SECUENCIAOK__','60');

	RETURN xml2;
END;
$$ LANGUAGE 'plpgsql';
 
