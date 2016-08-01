CREATE OR REPLACE FUNCTION multicaja_update_3010 (varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        cod_motor1      integer;
	fecha_in1	timestamp;
	fecha_out1	timestamp;
	fecha_out_tx1	timestamp;

	tx_tabla1       varchar;
        i               integer;

BEGIN

        xml2:=xml1;
        cod_motor1 := get_campo('CODIGO_MOTOR',xml2);
	fecha_in1  := nullif(get_campo('FECHA_IN_FIN',xml2),'');
	fecha_out1 := nullif(get_campo('FECHA_OUT_FIN',xml2),'');
	fecha_out_tx1 := nullif(get_campo('FECHA_OUT_FIN',xml2),'');

	-- Obtiene el nombre de la tabla para hacer el update.
        tx_tabla1:= get_campo('TX_TABLA',xml2)::varchar;

	EXECUTE 'UPDATE '||tx_tabla1||' SET estado = '||quote_literal(get_campo('ESTADO_TX',xml2))||', msje_resp = '||quote_literal(get_campo('RSP_MENSAJE_RESPUESTA',xml2))||', voucher = '||quote_literal(get_campo('RSP_VOUCHER_HORIZONTAL',xml2))||', cod_resp_isw = '||quote_literal(get_campo('RSP_CODIGO_RESPUESTA',xml2))||', codigo_isw = '||quote_literal(get_campo('RSP_CODIGO_ISWITCH',xml2))||', msj_resp_isw = '||quote_literal(get_campo('RSP_MENSAJE_RESPUESTA',xml2))||', fecha_in_isw = '||quote_literal(fecha_in1)||', fecha_out_isw = '||quote_literal(fecha_out1)||', fecha_out_tx = '||quote_literal(fecha_out_tx1)||' WHERE cod_motor = '||cod_motor1||';'; 

	GET DIAGNOSTICS i = ROW_COUNT;
        IF i<>1 THEN
                xml2:=logapp(xml2,'ERROR en Update ='||tx_tabla1||' - codmotor='||cod_motor1);
                xml2:=put_campo(xml2,'MENSAJE_RESP','Error en Update - CodMotor: '||cod_motor1);
                RETURN xml2;
        END IF;

        RETURN xml2;

END;
$$
LANGUAGE plpgsql;
