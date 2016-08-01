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
        fecha_tabla1            integer;
        tx_tabla1               varchar;
        stIpMotores             ip_motores%ROWTYPE;
        iface1                  varchar;

BEGIN
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

        --Seteo el Rut, para guardar con formato xxxxxxxx-x
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

        -- Inicio modificacion 2015-06-25. - Se agrega nuevo formato de creacion de tabla tx_bono3.
        -- Genera tabla transaccional dinamica.
        iface1:=getipserver('eth0');
        SELECT * INTO stIpMotores FROM ip_motores WHERE ip_motor=iface1;

        if not found then
                xml2:=put_campo(xml2,'MENSAJE_RESP','Error en Insercion');
                return xml2;
        end if;

        -- Asigna valor del dia.
        fecha_tabla1:=to_char(now(),'YYYYMMDD');

        -- El numero al final corresponde al ID de la maquina.
        fecha_tabla1:=(fecha_tabla1 * 100) + stIpMotores.id;

        -- Se compone el nombre final de la tabla.
        tx_tabla1:=('tx_bono3_'||fecha_tabla1);

        -- Se agrega nombre de tabla a XML2.
        xml2:=put_campo(xml2,'TX_TABLA',tx_tabla1);

        -- Comienzo insercion de datos en tabla.
        BEGIN
                EXECUTE 'INSERT INTO '||tx_tabla1||'(tipo_tx, rut_benef, codigo_motor, fecha_in_tx, cod_fin, financiador, estado, codigo_resp,mensaje_resp, mensaje_fin, xml_input, sp_exec, host, folio, procesador_xml, conexiones_activas, fecha_emision, monto_aporte_total, request_bono, response_bono) VALUES ('||quote_literal(tipo_tx1)||', '||quote_literal(rut_ben1)||', '||get_campo('CODIGO_MOTOR',xml2)::bigint||', '||quote_literal(fecha_in_tx1)||', '||id_fin1||', '||quote_literal(get_campo('FINANCIADOR',xml2))||', '||quote_literal(get_campo('ESTADO_TX',xml2))||', '||quote_literal(get_campo('CODIGO_RESP',xml2))||', '||quote_literal(substring(get_campo('MENSAJE_RESP',xml2),1,50))||', '||quote_literal(substring(get_campo('ERRORMSG',xml2),1,50))||', '||quote_literal(xml_std1)||', '||quote_literal(get_campo('SQLINPUT',xml2))||', '||quote_literal(get_campo('__HOST__',xml2))||', '||quote_literal(folio1)||', '||quote_literal(get_campo('__PROCESOXML__',xml2))||', '||quote_literal(get_campo('__PROC_ACTIVOS__',xml2))||', '||fecha_emision1||', '||monto_aporte_total1||','||quote_literal(get_campo('REQUEST_BONO',xml2))||','||quote_literal(get_campo('RESPONSE_BONO',xml2))||')';

                RETURN xml2;

        -- Si la tabla no existe, entonces la crea.
        EXCEPTION WHEN OTHERS THEN
                EXECUTE 'CREATE TABLE '||tx_tabla1||'(cod_fin integer, financiador varchar(50), tipo_tx varchar(20), codigo_motor bigint, rut_benef varchar(12), fecha_in_tx timestamp, fecha_out_tx timestamp, fecha_in_fin timestamp, fecha_out_fin timestamp, estado varchar(20), codigo_resp varchar(1), mensaje_resp varchar(50), mensaje_fin varchar(50), xml_input varchar, xml_output varchar, sp_exec varchar, sp_return varchar, host varchar(100), folio varchar, procesador_xml varchar, conexiones_activas varchar, fecha_emision integer, monto_aporte_total integer, dia integer DEFAULT(to_char(now(), ''YYYYMMDD''::text))::integer, request_bono varchar, response_bono varchar);';

                -- Se crean los indices de la tabla.
                EXECUTE 'CREATE INDEX '||tx_tabla1||'_01 on '||tx_tabla1||' (codigo_motor);';
                EXECUTE 'CREATE INDEX '||tx_tabla1||'_02 on '||tx_tabla1||' (fecha_in_tx);';
                EXECUTE 'CREATE INDEX '||tx_tabla1||'_03 on '||tx_tabla1||' (folio);';

                -- Se inserta el registro.
                EXECUTE 'INSERT INTO '||tx_tabla1||'(tipo_tx, rut_benef, codigo_motor, fecha_in_tx, cod_fin, financiador, estado, codigo_resp,mensaje_resp, mensaje_fin, xml_input, sp_exec, host, folio, procesador_xml, conexiones_activas, fecha_emision, monto_aporte_total, request_bono, response_bono) VALUES ('||quote_literal(tipo_tx1)||', '||quote_literal(rut_ben1)||', '||get_campo('CODIGO_MOTOR',xml2)::bigint||', '||quote_literal(fecha_in_tx1)||', '||id_fin1||', '||quote_literal(get_campo('FINANCIADOR',xml2))||', '||quote_literal(get_campo('ESTADO_TX',xml2))||', '||quote_literal(get_campo('CODIGO_RESP',xml2))||', '||quote_literal(substring(get_campo('MENSAJE_RESP',xml2),1,50))||', '||quote_literal(substring(get_campo('ERRORMSG',xml2),1,50))||', '||quote_literal(xml_std1)||', '||quote_literal(get_campo('SQLINPUT',xml2))||', '||quote_literal(get_campo('__HOST__',xml2))||', '||quote_literal(folio1)||', '||quote_literal(get_campo('__PROCESOXML__',xml2))||', '||quote_literal(get_campo('__PROC_ACTIVOS__',xml2))||', '||fecha_emision1||', '||monto_aporte_total1||','||quote_literal(get_campo('REQUEST_BONO',xml2))||','||quote_literal(get_campo('RESPONSE_BONO',xml2))||');';

                RETURN xml2;
        END;
        -- Fin modificacion - 2015-06-25.

END;

$$ LANGUAGE 'plpgsql';

