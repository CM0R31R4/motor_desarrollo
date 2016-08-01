CREATE OR REPLACE FUNCTION public.graba_tx_cia(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1            alias for $1;
        xml2            varchar;
        input1          varchar;
        fecha1          varchar;
        stTx            tx_cias%ROWTYPE;
        codigo1         bigint;
        tx1             varchar;
        fecha_emision1  integer;
        monto_bonif1    integer;
begin
        xml2:=xml1;
        --input1:=decode(get_campo('INPUT_CIA',xml2),'HEX');
        input1:=decode(get_campo('INPUT',xml2),'HEX');
        --Guarda solo data con < >
        input1:=replace(replace(input1,'&lt;','<'),'&gt;','>');

        tx1:=get_campo('TX_CIA',xml2);

        --Guarda campo 'fecha_emision' solo cuando es 'Confirmacion' o 'ConfirmacionBono3'. 18-06-2015.
        if (tx1='Confirmacion' or tx1='ConfirmacionBono3') then
                fecha_emision1  := coalesce(nullif(get_campo('EXTFECHAEMISION',xml2),''),'0');
                monto_bonif1    := coalesce(nullif(get_campo('EXTMTOBONIF',xml2),''),'0')::integer;
        else
                fecha_emision1  := 0;
                monto_bonif1    := 0;
        end if;
        --Fin modificacion 18-06-2015.

        if (tx1 in ('Certificacion','Conciliacion')) then
                codigo1:=nextval('correlativo_motor');
                xml2:=logapp(xml2,'Inserta Registro '||codigo1::varchar);
                insert into tx_cias (fecha_ingreso,tiempo_ini_cia,tiempo_fin_cia,codigo_cia,codigo_motor,extFolioAuto,extCodError,extMensajeError,MsgOutput,reintentos,tx,nemo,ip_cliente,estado,num_operacion,cod_lugar,rut_prestador,rut_beneficiario,msginput,fecha_emision,monto_bonif) values (clock_timestamp(),get_campo('TIEMPO_INI_CIA',xml2)::timestamp,get_campo('TIEMPO_FIN_CIA',xml2)::timestamp,get_campo('CODIGO_CIA',xml2),codigo1,get_campo('extFolioAuto',xml2),get_campo('extCodError',xml2),get_campo('extMensajeError',xml2),get_campo('MsgOutput',xml2),0,get_campo('TX_CIA',xml2),get_campo('NEMO_CIA',xml2),get_campo('__IP_PORT_CLIENTE__',xml2),get_campo('ESTADO_CIA',xml2),get_campo('NUM_OPERACION',xml2),get_campo('COD_LUGAR',xml2),get_campo('RUT_PRESTADOR',xml2),get_campo('extrutbeneficiario',xml2),input1,fecha_emision1,monto_bonif1);

        elsif (tx1 in ('Confirmacion','Anulacion','ConfirmacionBono3','AnulacionBono3')) then
                codigo1:=get_campo('CODIGO_MOTOR',xml2)::bigint;
                --Si existe solo reemplazo
                select * into stTx from tx_cias where codigo_motor=codigo1;
                if not found then
                        xml2:=logapp(xml2,'Inserta Registro '||codigo1::varchar);
                        insert into tx_cias (fecha_ingreso,tiempo_ini_cia,tiempo_fin_cia,tiempo_ini_sybase,tiempo_fin_sybase,codigo_cia,codigo_motor,extFolioAuto,extCodError,extMensajeError,MsgOutput,reintentos,tx,nemo,ip_cliente,estado,num_operacion,extFolioBono,rut_beneficiario,msginput,fecha_emision,monto_bonif) values (clock_timestamp(),get_campo('TIEMPO_INI_CIA',xml2)::timestamp,get_campo('TIEMPO_FIN_CIA',xml2)::timestamp,get_campo('TIEMPO_INI_SYBASE',xml2)::timestamp,now(),get_campo('CODIGO_CIA',xml2),get_campo('CODIGO_MOTOR',xml2)::bigint,get_campo('extFolioAuto',xml2),get_campo('extCodError',xml2),get_campo('extMensajeError',xml2),get_campo('MsgOutput',xml2),0,get_campo('TX_CIA',xml2),get_campo('NEMO_CIA',xml2),get_campo('__IP_PORT_CLIENTE__',xml2),get_campo('ESTADO_CIA',xml2),get_campo('NUM_OPERACION',xml2),get_campo('extFolioBono',xml2),get_campo('extrutbeneficiario',xml2),input1,fecha_emision1,monto_bonif1);
                else
                        xml2:=logapp(xml2,'Actualiza Registro '||codigo1::varchar);
                        update tx_cias set fecha_ult_modificacion=now(),
                                reintentos=reintentos+1,
                                tiempo_ini_cia=get_campo('TIEMPO_INI_CIA',xml2)::timestamp,
                                tiempo_fin_cia=get_campo('TIEMPO_FIN_CIA',xml2)::timestamp,
                                tiempo_ini_sybase=get_campo('TIEMPO_INI_SYBASE',xml2)::timestamp,
                                tiempo_fin_sybase=get_campo('TIEMPO_FIN_SYBASE',xml2)::timestamp,
                                extFolioAuto=get_campo('extFolioAuto',xml2),
                                extCodError=get_campo('extCodError',xml2),
                                extMensajeError=get_campo('extMensajeError',xml2),
                                MsgOutput=get_campo('MsgOutput',xml2),
                                estado=get_campo('ESTADO_CIA',xml2),
                                msginput=input1,
                                fecha_emision=fecha_emision1,
                                monto_bonif=monto_bonif1
                        where codigo_motor=codigo1;
                end if;
        else
                xml2:=logapp(xml2,'Tx no reconocida para Grabar '||tx1);
        end if;
        return xml2;
end;
$function$

