CREATE OR REPLACE FUNCTION b3_update_tx(varchar)
returns varchar as $$
declare
        xml1            alias for $1;
        xml2            varchar;
        cod_motor1      bigint;
        fecha_in_tx1    timestamp;
        fecha_out_tx1   timestamp;
        fecha_in_fin1   timestamp;
        fecha_out_fin1  timestamp;
        respuesta1      varchar;
        tx_tabla1       varchar;
        i               integer;

BEGIN
        xml2            := xml1;
        cod_motor1      := get_campo('CODIGO_MOTOR',xml2)::bigint;
        fecha_in_tx1    := get_campo('FECHA_IN_TX',xml2);   --guarda en el registra
        fecha_out_tx1   := get_campo('FECHA_OUT_TX',xml2)::timestamp;

        -- Obtiene el nombre de la tabla para hacer el update.
        tx_tabla1:= get_campo('TX_TABLA',xml2)::varchar;

        if (length(get_campo('RESPUESTA_HEX',xml2))>0) then
                respuesta1:=get_campo('RESPUESTA_HEX',xml2);
        else
                respuesta1:=get_campo('RESPUESTA',xml2);
        end if;

        --Si viene el tag
        if get_campo('EXTCODERROR',xml2)='N' then
                xml2  :=put_campo(xml2,'CODIGO_RESP','2');
                xml2  :=put_campo(xml2,'MENSAJE_RESP','Rechazado Por Financiador');
        end if;

        EXECUTE 'UPDATE '||tx_tabla1||' SET fecha_out_tx='||quote_literal(fecha_out_tx1)||',estado='||quote_literal(get_campo('ESTADO_TX',xml2))||',codigo_resp='||quote_literal(get_campo('CODIGO_RESP',xml2))||',mensaje_resp='||quote_literal(substring(get_campo('MENSAJE_RESP',xml2),1,50))||',mensaje_fin='||quote_literal(substring(get_campo('EXTMENSAJEERROR',xml2),1,50))||',xml_output='||quote_literal(respuesta1)||',sp_return='||quote_literal(get_campo('SQLOUTPUT',xml2))||'WHERE codigo_motor='||cod_motor1;

        GET DIAGNOSTICS i = ROW_COUNT;
        if i<>1 then
                xml2:=logapp(xml2,'ERROR en Update ='||tx_tabla1||' - codmotor='||cod_motor1);
                xml2:=put_campo(xml2,'MENSAJE_RESP','Error en Update CodMotor: '||cod_motor1);
                return xml2;
        end if;

        return xml2;
end;
$$ language 'plpgsql';
