CREATE OR REPLACE FUNCTION b3_registra_tx(varchar)
returns varchar as $$
declare
        xml1                    alias for $1;
        xml2                    varchar;

        id_fin1                 integer;
        rut_ben1                varchar;        --Temporal por ahora
        fecha_in_tx1            timestamp;
        fecha_out_tx1           timestamp;
        fecha_in_fin1           timestamp;
        fecha_out_fin1          timestamp;
        xml_std1                varchar;
        folio1                  varchar;
        tipo_tx1                varchar;
        fecha_emision1          integer;
        monto_aporte_total1     integer;

begin
        xml2 := xml1;
        --fecha_in_tx1:='';
        --fecha_out_tx1:='';
        --fecha_in_fin1:='';
        --fecha_out_fin1:='';
        xml_std1        := get_campo('__XML_STD__',xml2);
        id_fin1         := get_campo('ID_FIN',xml2)::integer;
        rut_ben1        := get_campo('RUT_BASE',xml2);
        fecha_in_tx1    := get_campo('FECHA_IN_TX',xml2)::timestamp;
        tipo_tx1        := get_campo('TX_WS',xml2);

        --fecha_out_tx1         := get_campo('FECHA_OUT_TX',xml2)::timestamp;  --guarda en el update
        --fecha_in_fin1         := get_campo('FECHA_IN_FIN',xml2)::timestamp;  --guarda en el update
        --fecha_out_fin1        := get_campo('FECHA_OUT_FIN',xml2)::timestamp; --guarda en el update
        --raise notice 'JCC_fecha_in_tx1=% - fecha_out_tx1=% - fecha_in_fin1=% - fecha_out_fin1=% ',fecha_in_tx1,fecha_out_tx1,fecha_in_fin1,fecha_out_fin1;

        -- Seteo el Rut, para guardar con formato xxxxxxxx-x
        --rut_ben1      =lpad(rut_ben1,10,'0')||'-'||motor_modulo11(rut_ben1);

        --Guarda campo fecha_emision solo cuando es 'envbonis' o 'envbono'. 17-06-2015.
        --if (tipo_tx1='envbonis_real' or tipo_tx1='envbono') then
        if ( (tipo_tx1 like 'envbonis%') or (tipo_tx1 like 'envbono%') ) then
                fecha_emision1          := to_char(coalesce(nullif(get_campo('EXTFECHAEMISION',xml2),''),'0')::timestamp,'YYYYMMDD');
                monto_aporte_total1     := coalesce(nullif(get_campo('EXTMONTOAPORTETOTAL',xml2),''),'0')::integer;
        else
                fecha_emision1          := 0;
                monto_aporte_total1     := 0;
        end if;
        --Fin modificacion 17-06-2015.

        --Guardo folio tx=valtrans
        if (length(get_campo('EXFOLIOFINANCIADOR',xml2))>0) then
                folio1:=get_campo('EXFOLIOFINANCIADOR',xml2);
        --Guardo folio tx=envbonis
        elsif (length(get_campo('EXTFOLIOFINANCIADOR',xml2))>0) then
                folio1:=get_campo('EXTFOLIOFINANCIADOR',xml2);
        --Guardo folio tx=anulabonou
        elsif (length(get_campo('EXTFOLIOBONO',xml2))>0) then
                folio1:=get_campo('EXTFOLIOBONO',xml2);
        else
                folio1:='';
        end if;

        

        INSERT INTO tx_bono3( tipo_tx,
                              rut_benef,
                              codigo_motor,
                              fecha_in_tx,
        --                      fecha_out_tx,
                              cod_fin,
                              financiador,
                              --fecha_in_fin,
                              --fecha_out_fin,
                              estado,
                              codigo_resp,
                              mensaje_resp,
                              mensaje_fin,
                              xml_input,
                              sp_exec,
                              host,
                              folio,
                              procesador_xml,
                              conexiones_activas,
                              fecha_emision,
                              monto_aporte_total
                  )values(
                              tipo_tx1,
        --                      --get_campo('TX_WS',xml2),
                              rut_ben1,
                              get_campo('CODIGO_MOTOR',xml2)::bigint,
                              fecha_in_tx1,
        --                      --coalesce(nullif(fecha_out_tx1,''),'0000'),
                              id_fin1,
                              get_campo('FINANCIADOR',xml2),
        --                      --coalesce(nullif(fecha_in_fin1,''),'0000'),
        --                      --coalesce(nullif(fecha_out_fin1,''),'0000'),
                              get_campo('ESTADO_TX',xml2),
                              get_campo('CODIGO_RESP',xml2),
                              get_campo('MENSAJE_RESP',xml2),
                              get_campo('ERRORMSG',xml2),
                              xml_std1,
                              get_campo('SQLINPUT',xml2),
                              get_campo('__HOST__',xml2),
                              folio1,
                              get_campo('__PROCESOXML__',xml2),
                              get_campo('__PROC_ACTIVOS__',xml2),
                              fecha_emision1,
                              monto_aporte_total1
                         );
        return xml2;
end;

$$ LANGUAGE 'plpgsql';

