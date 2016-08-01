CREATE OR REPLACE FUNCTION update_tx_dec(varchar)
returns varchar as $$
declare
        xml1            alias for $1;
        xml2            varchar;
        codigo_motor    bigint;

        fecha_tx1        timestamp;       
        estado          varchar;
        codigo_resp     varchar;
        xml_output       varchar;

begin
        xml2 := xml1;

        codigo_motor    := get_campo('CODIGO_MOTOR',xml2)::bigint;
        fecha_tx1       := get_campo('FECHA_IN_TX',xml2)::timestamp;
        estado          := get_campo('ESTADO_TX',xml2);
        codigo_resp     := get_campo('CODIGO_RESP',xml2);

        if (length(get_campo('RESPUESTA_HEX',xml2))>0) then
                xml_output:=get_campo('RESPUESTA_HEX',xml2);
        else
                xml_output:=get_campo('RESPUESTA',xml2);
        end if;

        --Si viene el tag
        if get_campo('EXTCODERROR',xml2)='N' then
                xml2  :=put_campo(xml2,'CODIGO_RESP','2');
                xml2  :=put_campo(xml2,'MENSAJE_RESP','Rechazado Por Financiador');
        end if;

        UPDATE tx_dec   SET
                                fecha_tx        = fecha_tx1,
                                estado          = estado,
                                codigo_resp     = codigo_resp,
                                mensaje_resp    = substring(get_campo('MENSAJE_RESP',xml2),1,50),
                                xml_output      = xml_output
                        WHERE
                                codigo_motor    = codigo_motor;
        if not found then
                raise notice 'JCC_Error en Update TX_DEC %', codigo_motor;
                xml2 := put_campo(xml2,'MENSAJE_RESP','Error en Update TX_DEC: '||codigo_motor);
                return xml2;
        end if;

        return xml2;
end;
$$ language 'plpgsql';
