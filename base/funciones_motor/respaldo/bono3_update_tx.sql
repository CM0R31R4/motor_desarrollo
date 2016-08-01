CREATE OR REPLACE FUNCTION b3_update_tx(varchar)
returns varchar as $$
declare
        xml1                    alias for $1;
        xml2                    varchar;
        cod_bono3               bigint;

        --id_fin1               integer;
        fecha_in_tx1            timestamp;
        fecha_out_tx1           timestamp;
        fecha_in_fin1           timestamp;
        fecha_out_fin1          timestamp;
        respuesta1              varchar;

begin
        xml2 := xml1;
        cod_bono3       := get_campo('CODIGO_MOTOR',xml2)::bigint;

        --id_fin1       := get_campo('ID_FIN',xml2);
        fecha_in_tx1    := get_campo('FECHA_IN_TX',xml2);   --guarda en el registra
        fecha_out_tx1   := get_campo('FECHA_OUT_TX',xml2)::timestamp;
        --fecha_in_fin1 := get_campo('FECHA_IN_FIN',xml2)::timestamp;
        --fecha_out_fin1        := get_campo('FECHA_OUT_FIN',xml2)::timestamp;

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

        UPDATE tx_bono3 SET
                                fecha_out_tx    = fecha_out_tx1,
                                --fecha_in_fin  = fecha_in_fin1,
                                --fecha_out_fin = fecha_out_fin1,
                                estado          = get_campo('ESTADO_TX',xml2),
                                codigo_resp     = get_campo('CODIGO_RESP',xml2),
                                mensaje_resp    = substring(get_campo('MENSAJE_RESP',xml2),1,50),
                                mensaje_fin     = substring(get_campo('EXTMENSAJEERROR',xml2),1,50),
                                xml_output      = respuesta1,
                                sp_return       = get_campo('SQLOUTPUT',xml2)
                        WHERE
                                codigo_motor = cod_bono3;
        if not found then
                raise notice 'JCC_Error en Update Bono3 %', cod_bono3;
                xml2 := put_campo(xml2,'MENSAJE_RESP','Error en Update tx_bono3 :' ||cod_bono3);
                return xml2;
        end if;

        return xml2;
end;
$$ language 'plpgsql';

