CREATE OR REPLACE FUNCTION traductor_in_cerenvtipant_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        declare_params  varchar;
        exec_sp         varchar;
        out_params      varchar;

begin
        xml2:=xml1;
        xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        --Llamo a la funcion input de parseo de datos.
        xml2:=proc_parser_input_cerenvtipant(xml2);
	if get_campo('ERR',xml2)='S' then
                xml2:=put_campo(xml2,'ESTADO_TX','FALLA_CONTENCION');
                xml2:=put_campo(xml2,'CODIGO_RESP','2');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Trx_No_Contenida');
                return xml2;
        end if;

        --Preparo la llamada al SP
        declare_params:='DECLARE @CtaCodError char(1)
                DECLARE @CtaMensajeError char(60) ';

        --Por ahora en duro
        --||get_campo('CTACODFINANCIADOR',xml2)||
        exec_sp:= 'EXECUTE dbo.CERENVTIPANT '||get_campo('CTACORRREGISTRO',xml2)||',
                        '||88||',
                        ['||get_campo('CTARUTCONVENIO',xml2)||'],
                        ['||get_campo('CTANUMCTA',xml2)||'],
                        '||get_campo('CTANUMCOBRO',xml2)||',
                        '||get_campo('CTATIPENVIO',xml2)||',
                        ['||get_campo('CTAANTELEC',xml2)||'],
                        ['||get_campo('CTAANTMANUAL',xml2)||'],
                        '||get_campo('CTATIPENV',xml2)||',
                        ['||get_campo('CTADETANT',xml2)||'],
                        '||get_campo('CTACANTDOC',xml2)||', @CtaCodError OUTPUT, @CtaMensajeError OUTPUT ';

        out_params:='SELECT @CtaCodError as CtaCodError, @CtaMensajeError as CtaMensajeError ';

	--Esta data se guarda en t_ctamed campo sp_request
        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);

        --Si no hay falla. Contesta el Resquest con OK1.
        xml2:=put_campo(xml2,'ERR','N');
        xml2:=put_campo(xml2,'GLOSA','CME Contenida');
        xml2:=put_campo(xml2,'ESTADO_TX','CONTENIDA');
        xml2:=put_campo(xml2,'CODIGO_RESP','1');
        xml2:=put_campo(xml2,'MENSAJE_RESP','Trx_Contenida');

        return xml2;
end;
$$
LANGUAGE plpgsql;

/*CREATE OR REPLACE FUNCTION traductor_out_cerenvtipant_masvida(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        i               integer ='1';
        cod_resp1       varchar;
        msj_resp1       varchar;
begin
        xml2:=xml1;
        xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        --Parseo respuesta
        cod_resp1       :=trim(get_campo('CTACODERROR_'||i::varchar,xml2));
        msj_resp1       :=trim(get_campo('CTAMENSAJEERROR_'||i::varchar,xml2));
        raise notice 'JCC_cerenvtipant_Receive CtaCodError=% - CtaMensajeError=%',cod_resp1,msj_resp1;

        *xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
        --Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
        xml2:=put_campo(xml2,'CTACODERROR',cod_resp1);
        xml2:=put_campo(xml2,'CTAMENSAJEERROR',msj_resp1);*

	xml2:=put_campo(xml2,'ERR',cod_resp1);
        xml2:=put_campo(xml2,'GLOSA',msj_resp1);

        return xml2;
end;

$$
LANGUAGE plpgsql;*/

