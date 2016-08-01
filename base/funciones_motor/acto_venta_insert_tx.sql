CREATE OR REPLACE FUNCTION acto_venta_insert_tx(integer, varchar)
RETURNS varchar AS $$
DECLARE
	
	num_api		alias for $1;
	xml1            alias for $2;
        xml2            varchar;

	id1		bigint;	
	numacto_venta1  bigint;
	xml_in1         varchar;

BEGIN
	xml2 		:=xml1;
	xml2		:=logapp(xml2,'Entrando en INSERT API-1');

	-- Llamada a funcion que genera codigo de motor.
	id1		:=genera_codmotor();
	
	-- Extrae tags del XML para insertar en tabla.
	numacto_venta1  :=get_campo('EXTNUMACTOVENTA',xml2)::bigint;
	xml_in1         :=put_campo(xml2,'INPUT',get_campo('EXTXMLACTOVENTA',xml2));

	BEGIN
		INSERT INTO tx_ActoVentaXml(
						id,
						acto_venta,
						cod_fin, 
						xml,
						fecha_in, 
						id_cola,
						api,
						reintentos,
						estado) 
					VALUES(						
						id1,
						numacto_venta1, 
						get_campo('EXTCODFINANCIADOR',xml2)::integer,
						xml_in1,
						clock_timestamp(),
						nextval('sec_grabaBonoDec'),
						'API_1',
						0,
						'OK');
				
		xml2:=put_campo(xml2,'RESULTADO_INSERT_API_'||num_api,'OK_API_'||num_api);
		xml2:=put_campo(xml2,'COD_MOTOR_API_'||num_api, id1::varchar);
		xml2:=logapp(xml2,'Insert OK API-1 :' ||id1);

		-- Marca secuencia 30 para ir al Insert del API-2.
		xml2:=put_campo(xml2,'__SECUENCIAOK__','30');

	EXCEPTION WHEN OTHERS THEN
		xml2:=put_campo(xml2,'RESULTADO_INSERT_API_'||num_api,'ERROR_API_'||num_api);
		xml2:=put_campo(xml2,'COD_MOTOR_API_'||num_api, id1::varchar);
		xml2:=logapp(xml2,'Insert ERROR API-1 :' ||id1);
	
		-- Marca secuencia 40 para ir a funcion de revision de TRX del flujo 7000.
		xml2:=put_campo(xml2,'__SECUENCIAOK__','40');	
	END;
	
	RETURN xml2;
END;
$$ LANGUAGE 'plpgsql';
