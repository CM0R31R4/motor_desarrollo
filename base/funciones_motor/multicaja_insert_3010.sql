CREATE OR REPLACE FUNCTION multicaja_insert_3010 (varchar)
returns varchar as
$$
declare
	xml1  		alias for $1;
	xml2 		varchar;
	cod_motor1 	integer;
	fecha_tabla1    integer;
        tx_tabla1       varchar;
        stIpMotores     ip_motores%ROWTYPE;
        iface1          varchar;
	tipo_venta1	integer;
Begin

	xml2:=xml1;

	-- Extrae codigo de Motor.
	cod_motor1	:=get_campo('CODIGO_MOTOR',xml2);

	 -- Genera tabla transaccional dinamica.
        iface1:=getipserver('eth0');
        SELECT * INTO stIpMotores FROM ip_motores WHERE ip_motor=iface1;
        IF NOT FOUND THEN
                xml2:=put_campo(xml2,'MENSAJE_RESP','Error en Insercion');
                RETURN xml2;
        END IF;

	-- Asigna valor del dia.
        fecha_tabla1:=to_char(now(),'YYYYMMDD');

        -- El numero al final corresponde al ID de la maquina.
        fecha_tabla1:=(fecha_tabla1 * 100) + stIpMotores.id;

        -- Se compone el nombre final de la tabla.
        tx_tabla1:=('tx_mediospagos_'||fecha_tabla1);

        -- Se agrega nombre de tabla a XML2.
        xml2:=put_campo(xml2,'TX_TABLA',tx_tabla1);

	--tipo_venta1:=get_campo('TIPO_VENTA',xml2)::integer;
	tipo_venta1:=0;

	-- Comienza la insercion de datos en la tabla.
	BEGIN
		EXECUTE 'INSERT INTO '||tx_tabla1||' (tipo_tx, estado, fecha_in_tx, cod_motor, rut_titular, rut_benef, pc_key, xml_input, cod_lugar, nro_autentia, num_solicitud, rut_cajero, rut_prest, monto, cuotas, emisor, pin, track1, track2, fecha_oper, tipo_venta) VALUES ('||quote_literal(get_campo('TX_API',xml2))||', '||quote_literal(get_campo('ESTADO_TX',xml2))||', '||quote_literal(get_campo('FECHA_IN_TX',xml2)::timestamp)||', '||cod_motor1||', '||quote_literal(get_campo('RUT_TITULAR',xml2))||', '||quote_literal(get_campo('RUT_BENEFICIARIO',xml2))||', '||quote_literal(get_campo('PC_KEY',xml2))||', '||quote_literal(get_campo('INPUT',xml2))||', '||quote_literal(get_campo('COD_LUGAR',xml2))||', '||quote_literal(get_campo('NRO_AUDITORIA',xml2))||', '||quote_literal(get_campo('CODIGO_CLIENTE',xml2))||', '||quote_literal(get_campo('RUT_OPERADOR',xml2))||', '||quote_literal(get_campo('RUT_PRESTADOR',xml2))||', '||quote_literal(get_campo('MONTO',xml2))||', '||quote_literal(get_campo('CUOTAS',xml2))||', '||quote_literal(get_campo('EMISOR',xml2))||', '||quote_literal(get_campo('PIN',xml2))||', '||quote_literal(get_campo('TRACK1',xml2))||', '||quote_literal(get_campo('TRACK2',xml2))||', '||quote_literal(get_campo('FECHA_OPERACION',xml2))||', '||tipo_venta1||');';
		
		RETURN xml2;

	EXCEPTION WHEN OTHERS THEN
		EXECUTE 'CREATE TABLE '||tx_tabla1||' (tipo_tx varchar(30), cod_motor integer, cod_motor_anu integer, fecha_in_tx timestamp, fecha_out_tx timestamp, estado varchar(20), cod_resp varchar(1), msje_resp text, nro_autentia varchar(50), num_solicitud varchar(50), pc_key varchar(50), cod_lugar varchar, rut_titular varchar(12), rut_prest varchar(12), rut_benef varchar(12), rut_cajero varchar(12), monto varchar(20), monto_anulado varchar(20), cuotas varchar(20), huella varchar(2), tipo_venta integer, fecha_oper varchar(14), tipo_producto varchar(10), fecha_pc varchar(14), track1 varchar(100), track2 varchar(100), emisor varchar(3), pin varchar(50), version varchar(5), fecha_anula varchar(14), fecha_in_isw timestamp, fecha_out_isw timestamp, cod_resp_isw varchar(2), msj_resp_isw text, codigo_isw varchar, total_emis integer, lista_emis text, voucher text, xml_input varchar);';
		
		-- Se crean los indices de la tabla.
		EXECUTE 'CREATE INDEX '||tx_tabla1||'_01 on '||tx_tabla1||' (cod_motor);';
		EXECUTE 'CREATE INDEX '||tx_tabla1||'_02 on '||tx_tabla1||' (fecha_in_tx);';
		EXECUTE 'CREATE INDEX '||tx_tabla1||'_03 on '||tx_tabla1||' (pc_key, cod_lugar);';

		-- Se inserta registro.
		EXECUTE 'INSERT INTO '||tx_tabla1||' (tipo_tx, estado, fecha_in_tx, cod_motor, rut_titular, rut_benef, pc_key, xml_input, cod_lugar, nro_autentia, num_solicitud, rut_cajero, rut_prest, monto, cuotas, emisor, pin, track1, track2, fecha_oper, tipo_venta) VALUES ('||quote_literal(get_campo('TX_API',xml2))||', '||quote_literal(get_campo('ESTADO_TX',xml2))||', '||quote_literal(get_campo('FECHA_IN_TX',xml2)::timestamp)||', '||cod_motor1||', '||quote_literal(get_campo('RUT_TITULAR',xml2))||', '||quote_literal(get_campo('RUT_BENEFICIARIO',xml2))||', '||quote_literal(get_campo('PC_KEY',xml2))||', '||quote_literal(get_campo('INPUT',xml2))||', '||quote_literal(get_campo('COD_LUGAR',xml2))||', '||quote_literal(get_campo('NRO_AUDITORIA',xml2))||', '||quote_literal(get_campo('CODIGO_CLIENTE',xml2))||', '||quote_literal(get_campo('RUT_OPERADOR',xml2))||', '||quote_literal(get_campo('RUT_PRESTADOR',xml2))||', '||quote_literal(get_campo('MONTO',xml2))||', '||quote_literal(get_campo('CUOTAS',xml2))||', '||quote_literal(get_campo('EMISOR',xml2))||', '||quote_literal(get_campo('PIN',xml2))||', '||quote_literal(get_campo('TRACK1',xml2))||', '||quote_literal(get_campo('TRACK2',xml2))||', '||quote_literal(get_campo('FECHA_OPERACION',xml2))||', '||tipo_venta1||');';

		RETURN xml2;
	END;
END;
$$
LANGUAGE plpgsql;

