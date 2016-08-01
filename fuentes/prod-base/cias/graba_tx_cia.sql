CREATE OR REPLACE FUNCTION public.graba_tx_cia(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1            alias for $1;
        xml2            varchar;
        input1          varchar;
        fecha1          varchar;
        codigo1         bigint;
        tx1             varchar;
        fecha_emision1  integer;
        monto_bonif1    integer;

        fecha_tabla1    integer;
        tx_tabla1       varchar;
        stIpMotores     ip_motores%ROWTYPE;
        iface1          varchar;
        i               integer;
        reintentos1     integer;
        
        -- Variable agregada el 2015-08-05 para almacenar el codigo de financiador [CM].
        cod_fin1        integer;
begin
        xml2:=xml1;
        input1:=decode(get_campo('INPUT',xml2),'HEX');

        --Guarda solo data con < >
        input1:=replace(replace(input1,'&lt;','<'),'&gt;','>');

        tx1:=get_campo('TX_CIA',xml2);
        
	--Extrae nombre de tabla desde XML2.
        tx_tabla1:=get_campo('TX_TABLA',xml2);

        --Guarda campo 'fecha_emision' solo cuando es 'Confirmacion' o 'ConfirmacionBono3'. 18-06-2015.
        if (tx1='Confirmacion' or tx1='ConfirmacionBono3' or tx1='ConfirmacionBonoExt') then
                fecha_emision1  := coalesce(nullif(get_campo('EXTFECHAEMISION',xml2),''),'0');
                monto_bonif1    := coalesce(nullif(get_campo('EXTMTOBONIF',xml2),''),'0')::integer;
        else
                fecha_emision1  := 0;
                monto_bonif1    := 0;
        end if;

        -- Agregado el 2015-08-05 para almacenar el codigo de financiador [CM].
        cod_fin1:=coalesce(nullif(get_campo('COD_FIN',xml2),''),'0')::integer;

        --Si no viene la tabla, sera un Insert.
        if length(tx_tabla1)=0 then
                -- Inicio modificacion 2015-06-26. - Se agrega nuevo formato de creacion de tabla tx_cias.
                -- Genera tabla transaccional dinamica.
                iface1:=getipserver('eth0');
                SELECT * INTO stIpMotores FROM ip_motores WHERE ip_motor=iface1;

                if not found then
                        xml2:=put_campo(xml2,'MENSAJE_RESP','Error en Insercion');
                        return xml2;
                end if;

                -- Asigna valor del dia.
                fecha_tabla1:=to_char(now(),'YYYYMMDD');

                -- Se le agrega codigo del motor. Por mientras se realiza en duro.
                -- El numero al final corresponde al ID de la maquina.
                fecha_tabla1:=(fecha_tabla1 * 100) + stIpMotores.id;

                -- Se compone el nombre final de la tabla.
                tx_tabla1:=('tx_cias_'||fecha_tabla1);

                -- Se agrega campo con el nombre de la tabla al XML2.
                xml2:=put_campo(xml2,'TX_TABLA',tx_tabla1);
        end if;

        IF (tx1 in ('Certificacion','Conciliacion')) THEN

                codigo1:=genera_codmotor();

                xml2:=logapp(xml2,'Inserta Registro '||codigo1::varchar);

                BEGIN
                        EXECUTE 'INSERT INTO '||tx_tabla1||' (fecha_ingreso, tiempo_ini_cia, tiempo_fin_cia, codigo_cia, codigo_motor, extFolioAuto, extCodError, extMensajeError, MsgOutput, reintentos, tx,nemo, ip_cliente, estado, num_operacion, cod_lugar, rut_prestador, rut_beneficiario, msginput, fecha_emision, monto_bonif, cod_fin) VALUES ('||quote_literal(clock_timestamp())||','||quote_literal(get_campo('TIEMPO_INI_CIA',xml2)::timestamp)||','||quote_literal(get_campo('TIEMPO_FIN_CIA',xml2)::timestamp)||','||quote_literal(get_campo('CODIGO_CIA',xml2))||','||codigo1||','||quote_literal(get_campo('extFolioAuto',xml2))||','||quote_literal(get_campo('extCodError',xml2))||','||quote_literal(get_campo('extMensajeError',xml2))||','||quote_literal(get_campo('MsgOutput',xml2))||', 0,'||quote_literal(get_campo('TX_CIA',xml2))||','||quote_literal(get_campo('NEMO_CIA',xml2))||','||quote_literal(get_campo('__IP_PORT_CLIENTE__',xml2))||','||quote_literal(get_campo('ESTADO_CIA',xml2))||','||quote_literal(get_campo('NUM_OPERACION',xml2))||','||quote_literal(get_campo('COD_LUGAR',xml2))||','||quote_literal(get_campo('RUT_PRESTADOR',xml2))||','||quote_literal(get_campo('extrutbeneficiario',xml2))||','||quote_literal(input1)||','||fecha_emision1||','||monto_bonif1||','||cod_fin1||')';

                        -- Se agrega campo con el nombre de la tabla al XML2.
                        xml2:=put_campo(xml2,'TX_TABLA',tx_tabla1);

                -- Si la tabla no existe, entonces la crea.
                EXCEPTION WHEN OTHERS THEN
                        EXECUTE 'create TABLE '||tx_tabla1||'(fecha_ingreso timestamp(6), dia integer DEFAULT(to_char(now(), ''YYYYMMDD''::text))::integer, tiempo_ini_cia timestamp(6), tiempo_fin_cia timestamp(6), tiempo_ini_sybase timestamp(6), tiempo_fin_sybase timestamp(6), codigo_cia varchar, codigo_motor bigint, extfolioauto varchar, extcoderror varchar, extmensajeerror varchar, msgoutput varchar, estado varchar, reintentos integer, tx varchar, nemo varchar, ip_cliente varchar, fecha_ult_modificacion timestamp(6), num_operacion varchar, extfoliobono varchar, cod_lugar varchar, rut_prestador varchar, rut_beneficiario varchar, msginput varchar, fecha_emision integer, monto_bonif integer, cod_fin integer);';

                        -- Se crean los indices de la tabla.
                        EXECUTE 'CREATE INDEX '||tx_tabla1||'_01 ON '||tx_tabla1||' (fecha_ingreso);';
                        EXECUTE 'CREATE INDEX '||tx_tabla1||'_02 ON '||tx_tabla1||' (dia);';
                        EXECUTE 'CREATE INDEX '||tx_tabla1||'_03 ON '||tx_tabla1||' (codigo_motor);';
                        EXECUTE 'CREATE INDEX '||tx_tabla1||'_04 ON '||tx_tabla1||' (extfoliobono);';
                        EXECUTE 'CREATE INDEX '||tx_tabla1||'_05 ON '||tx_tabla1||' (extfolioauto);';
                        EXECUTE 'CREATE INDEX '||tx_tabla1||'_06 ON '||tx_tabla1||' (num_operacion);';

                        -- Se inserta el registro.
                        EXECUTE 'INSERT INTO '||tx_tabla1||' (fecha_ingreso, tiempo_ini_cia, tiempo_fin_cia, codigo_cia, codigo_motor, extFolioAuto, extCodError, extMensajeError, MsgOutput, reintentos, tx,nemo, ip_cliente, estado, num_operacion, cod_lugar, rut_prestador, rut_beneficiario, msginput, fecha_emision, monto_bonif, cod_fin) VALUES ('||quote_literal(clock_timestamp())||','||quote_literal(get_campo('TIEMPO_INI_CIA',xml2)::timestamp)||','||quote_literal(get_campo('TIEMPO_FIN_CIA',xml2)::timestamp)||','||quote_literal(get_campo('CODIGO_CIA',xml2))||','||codigo1||','||quote_literal(get_campo('extFolioAuto',xml2))||','||quote_literal(get_campo('extCodError',xml2))||','||quote_literal(get_campo('extMensajeError',xml2))||','||quote_literal(get_campo('MsgOutput',xml2))||', 0,'||quote_literal(get_campo('TX_CIA',xml2))||','||quote_literal(get_campo('NEMO_CIA',xml2))||','||quote_literal(get_campo('__IP_PORT_CLIENTE__',xml2))||','||quote_literal(get_campo('ESTADO_CIA',xml2))||','||quote_literal(get_campo('NUM_OPERACION',xml2))||','||quote_literal(get_campo('COD_LUGAR',xml2))||','||quote_literal(get_campo('RUT_PRESTADOR',xml2))||','||quote_literal(get_campo('extrutbeneficiario',xml2))||','||quote_literal(input1)||','||fecha_emision1||','||monto_bonif1||','||cod_fin1||')';

                        -- Se agrega campo con el nombre de la tabla al XML2.
                        xml2:=put_campo(xml2,'TX_TABLA',tx_tabla1);
                END;

        ELSIF (tx1 in ('Confirmacion','Anulacion','ConfirmacionBono3','AnulacionBono3','ConfirmacionBonoExt','AnulacionBonoExt')) THEN
                codigo1:=get_campo('CODIGO_MOTOR',xml2)::bigint;
                --Si existe solo reemplazo

                BEGIN
                        EXECUTE 'SELECT * FROM '||tx_tabla1||' WHERE codigo_motor='||codigo1||';';

                        GET DIAGNOSTICS i = ROW_COUNT;
                        if i=0 then
                                xml2:=logapp(xml2,'Inserta Registro '||codigo1::varchar);

                                EXECUTE 'INSERT into '||tx_tabla1||' (fecha_ingreso, tiempo_ini_cia, tiempo_fin_cia, tiempo_ini_sybase, tiempo_fin_sybase, codigo_cia, codigo_motor, extFolioAuto, extCodError, extMensajeError, MsgOutput, reintentos, tx, nemo, ip_cliente, estado, num_operacion, extFolioBono, rut_beneficiario, msginput, fecha_emision, monto_bonif, cod_fin) VALUES ('||quote_literal(clock_timestamp())||','||quote_literal(get_campo('TIEMPO_INI_CIA',xml2)::timestamp)||','||quote_literal(get_campo('TIEMPO_FIN_CIA',xml2)::timestamp)||','||quote_literal(get_campo('TIEMPO_INI_SYBASE',xml2)::timestamp)||','||quote_literal(now())||','||quote_literal(get_campo('CODIGO_CIA',xml2))||','||quote_literal(get_campo('CODIGO_MOTOR',xml2)::bigint)||','||quote_literal(get_campo('extFolioAuto',xml2))||','||quote_literal(get_campo('extCodError',xml2))||','||quote_literal(get_campo('extMensajeError',xml2))||','||quote_literal(get_campo('MsgOutput',xml2))||',0,'||quote_literal(get_campo('TX_CIA',xml2))||','||quote_literal(get_campo('NEMO_CIA',xml2))||','||quote_literal(get_campo('__IP_PORT_CLIENTE__',xml2))||','||quote_literal(get_campo('ESTADO_CIA',xml2))||','||quote_literal(get_campo('NUM_OPERACION',xml2))||','||quote_literal(get_campo('extFolioBono',xml2))||','||quote_literal(get_campo('extrutbeneficiario',xml2))||','||quote_literal(input1)||','||fecha_emision1||','||monto_bonif1||','||cod_fin1||')';

                                -- Se agrega campo con el nombre de la tabla al XML2.
                                xml2:=put_campo(xml2,'TX_TABLA',tx_tabla1);
                        else
                                xml2:=logapp(xml2,'Actualiza Registro '||codigo1::varchar);

                                EXECUTE 'UPDATE '||tx_tabla1||' set fecha_ult_modificacion = '||quote_literal(now())||',
                                                reintentos = reintentos+1,
                                                tiempo_ini_cia = '||quote_literal(get_campo('TIEMPO_INI_CIA',xml2)::timestamp)||',
                                                tiempo_fin_cia = '||quote_literal(get_campo('TIEMPO_FIN_CIA',xml2)::timestamp)||',
                                                tiempo_ini_sybase = '||quote_literal(get_campo('TIEMPO_INI_SYBASE',xml2)::timestamp)||',
                                                tiempo_fin_sybase = '||quote_literal(get_campo('TIEMPO_FIN_SYBASE',xml2)::timestamp)||',
                                                extFolioAuto = '||quote_literal(get_campo('extFolioAuto',xml2))||',
                                                extCodError = '||quote_literal(get_campo('extCodError',xml2))||',
                                                extMensajeError = '||quote_literal(get_campo('extMensajeError',xml2))||',
                                                MsgOutput = '||quote_literal(get_campo('MsgOutput',xml2))||',
                                                estado = '||quote_literal(get_campo('ESTADO_CIA',xml2))||',
                                                msginput = '||quote_literal(input1)||',
                                                fecha_emision = '||fecha_emision1||',
                                                monto_bonif = '||monto_bonif1||',
                                                cod_fin = '||cod_fin1||'
                                        WHERE codigo_motor = '||codigo1||';';

                                GET DIAGNOSTICS i = ROW_COUNT;
                                IF i<>1 THEN
                                        xml2:=logapp(xml2,'ERROR en Update ='||tx_tabla1||' - codmotor='||codigo1);
                                        xml2:=put_campo(xml2,'MENSAJE_RESP','Error en Update CodMotor: '||codigo1);
                                        RETURN xml2;
                                END IF;
                        end if;

                -- Si la tabla no existe, entonces la crea.
                EXCEPTION WHEN OTHERS THEN
                                EXECUTE 'CREATE table '||tx_tabla1||'(fecha_ingreso timestamp(6), dia integer DEFAULT(to_char(now(), ''YYYYMMDD''::text))::integer, tiempo_ini_cia timestamp(6), tiempo_fin_cia timestamp(6), tiempo_ini_sybase timestamp(6), tiempo_fin_sybase timestamp(6), codigo_cia varchar, codigo_motor bigint, extfolioauto varchar, extcoderror varchar, extmensajeerror varchar, msgoutput varchar, estado varchar, reintentos integer, tx varchar, nemo varchar, ip_cliente varchar, fecha_ult_modificacion timestamp(6), num_operacion varchar, extfoliobono varchar, cod_lugar varchar, rut_prestador varchar, rut_beneficiario varchar, msginput varchar, fecha_emision integer, monto_bonif integer, cod_fin integer);';

                                -- Se crean los indices de la tabla.
                                EXECUTE 'CREATE INDEX '||tx_tabla1||'_01 ON '||tx_tabla1||' (fecha_ingreso);';
                                EXECUTE 'CREATE INDEX '||tx_tabla1||'_02 ON '||tx_tabla1||' (dia);';
                                EXECUTE 'CREATE INDEX '||tx_tabla1||'_03 ON '||tx_tabla1||' (codigo_motor);';
                                EXECUTE 'CREATE INDEX '||tx_tabla1||'_04 ON '||tx_tabla1||' (extfoliobono);';
                                EXECUTE 'CREATE INDEX '||tx_tabla1||'_05 ON '||tx_tabla1||' (extfolioauto);';
                                EXECUTE 'CREATE INDEX '||tx_tabla1||'_06 ON '||tx_tabla1||' (num_operacion);';

                        -- Se reintenta con la tabla ya creada.
                        EXECUTE 'SELECT * FROM '||tx_tabla1||' WHERE codigo_motor='||codigo1||';';

                        GET DIAGNOSTICS i = ROW_COUNT;
                        if i=0 then
                                xml2:=logapp(xml2,'Inserta Registro '||codigo1::varchar);

                                EXECUTE 'insert INTO '||tx_tabla1||' (fecha_ingreso, tiempo_ini_cia, tiempo_fin_cia, tiempo_ini_sybase, tiempo_fin_sybase, codigo_cia, codigo_motor, extFolioAuto, extCodError, extMensajeError, MsgOutput, reintentos, tx, nemo, ip_cliente, estado, num_operacion, extFolioBono, rut_beneficiario, msginput, fecha_emision, monto_bonif, cod_fin) VALUES ('||quote_literal(clock_timestamp())||','||quote_literal(get_campo('TIEMPO_INI_CIA',xml2)::timestamp)||','||quote_literal(get_campo('TIEMPO_FIN_CIA',xml2)::timestamp)||','||quote_literal(get_campo('TIEMPO_INI_SYBASE',xml2)::timestamp)||',' ||quote_literal(now())||','||quote_literal(get_campo('CODIGO_CIA',xml2))||','||quote_literal(get_campo('CODIGO_MOTOR',xml2)::bigint)||','||quote_literal(get_campo('extFolioAuto',xml2))||','||quote_literal(get_campo('extCodError',xml2))||','||quote_literal(get_campo('extMensajeError',xml2))||','||quote_literal(get_campo('MsgOutput',xml2))||',0,'||quote_literal(get_campo('TX_CIA',xml2))||','||quote_literal(get_campo('NEMO_CIA',xml2))||','||quote_literal(get_campo('__IP_PORT_CLIENTE__',xml2))||','||quote_literal(get_campo('ESTADO_CIA',xml2))||','||quote_literal(get_campo('NUM_OPERACION',xml2))||','||quote_literal(get_campo('extFolioBono',xml2))||','||quote_literal(get_campo('extrutbeneficiario',xml2))||','||quote_literal(input1)||','||fecha_emision1||','||monto_bonif1||','||cod_fin1||')';

                                -- Se agrega campo con el nombre de la tabla al XML2.
                                xml2:=put_campo(xml2,'TX_TABLA',tx_tabla1);
                        else
                                xml2:=logapp(xml2,'Actualiza Registro '||codigo1::varchar);

                                EXECUTE 'UPDATE '||tx_tabla1||' set fecha_ult_modificacion = '||quote_literal(now())||',
                                                reintentos = reintentos+1,
                                                tiempo_ini_cia = '||quote_literal(get_campo('TIEMPO_INI_CIA',xml2)::timestamp)||',
                                                tiempo_fin_cia = '||quote_literal(get_campo('TIEMPO_FIN_CIA',xml2)::timestamp)||',
                                                tiempo_ini_sybase = '||quote_literal(get_campo('TIEMPO_INI_SYBASE',xml2)::timestamp)||',
                                                tiempo_fin_sybase = '||quote_literal(get_campo('TIEMPO_FIN_SYBASE',xml2)::timestamp)||',
                                                extFolioAuto = '||quote_literal(get_campo('extFolioAuto',xml2))||',
                                                extCodError = '||quote_literal(get_campo('extCodError',xml2))||',
                                                extMensajeError = '||quote_literal(get_campo('extMensajeError',xml2))||',
                                                MsgOutput = '||quote_literal(get_campo('MsgOutput',xml2))||',
                                                estado = '||quote_literal(get_campo('ESTADO_CIA',xml2))||',
                                                msginput = '||quote_literal(input1)||',
                                                fecha_emision = '||fecha_emision1||',
                                                monto_bonif = '||monto_bonif1||',
                                                cod_fin = '||cod_fin1||'
                                        WHERE codigo_motor = '||codigo1||';';

                                GET DIAGNOSTICS i = ROW_COUNT;
                                IF i<>1 THEN
                                        xml2:=logapp(xml2,'ERROR en Update ='||tx_tabla1||' - codmotor='||codigo1);
                                        xml2:=put_campo(xml2,'MENSAJE_RESP','Error en Update CodMotor: '||codigo1);
                                        RETURN xml2;
                                END IF;
                        end if;
                END;
        ELSE
                xml2:=logapp(xml2,'Tx no reconocida para Grabar '||tx1);
        END IF;

        RETURN xml2;
end;
$function$

