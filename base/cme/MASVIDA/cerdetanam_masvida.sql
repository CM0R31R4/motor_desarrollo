CREATE OR REPLACE FUNCTION traductor_in_cerdetanam_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	declare_params	varchar;
        exec_sp		varchar;
        out_params  	varchar;

begin
        xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',clock_timestamp()::varchar);

	--Llamo a la funcion input de parseo de datos.
	xml2:=proc_parser_input_cerdetanam(xml2);
	if get_campo('ERR',xml2)='S' then
                xml2:=put_campo(xml2,'ESTADO_TX','FALLA_CME');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Error parser_input_'||get_campo('TX_WS',xml2));
                return xml2;
        end if;

	--Preparo la llamada al SP
        declare_params:='DECLARE @AnamCodError char(1)
                DECLARE @AnamMensajeError char(60) ';

	--Por ahora en duro
        --||get_campo('ANAMCODFINANCIADOR',xml2)||
        exec_sp:= 'EXECUTE dbo.cerdetanam '||get_campo('ANAMTIPODET',xml2)||',
                        ['||get_campo('ANAMRUTPRESTADOR',xml2)||'],
                        '||88||',
                        ['||get_campo('ANAMNUMCTA',xml2)||'],
                        '||get_campo('ANAMNUMCOBRO',xml2)||',
                        '||get_campo('ANAMTIPENVIO',xml2)||',
                        ['||get_campo('ANAMHOMNROCONVENIO',xml2)||'],
                        ['||get_campo('ANAMHOMLUGARCONVENIO',xml2)||'],
                        '||get_campo('ANAMNUMCOR',xml2)||',
                        ['||get_campo('ANAMDESCRIPCION',xml2)||'], @AnamCodError OUTPUT, @AnamMensajeError OUTPUT ';

        out_params:='SELECT @AnamCodError as AnamCodError, @AnamMensajeError as AnamMensajeError ';

	--Esta data se guarda en t_ctamed campo sp_request
        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);

        return xml2;

end;
$$
LANGUAGE plpgsql;

/*
CREATE OR REPLACE FUNCTION traductor_out_cerdetanam_masvida(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        i               integer ='1';
        cod_error1      varchar;
        msj_error1      varchar;

        estado1         varchar;
        cod_resp1       varchar;
        msj_resp1       varchar;

begin
        --Esta funcion se ejecuta, cuando fintx_ctamed esta en ejecucion
        xml2:=xml1;

        xml2:=put_campo(xml2,'FECHA_OUT_FIN',clock_timestamp()::varchar);
        estado1:='COMMIT';
        cod_resp1:='1';
        msj_resp1:='Trx_Commit';

        --Parseo respuesta
        cod_error1      :=trim(get_campo('ANAMCODERROR_'||i::varchar,xml2));
        msj_error1      :=trim(get_campo('ANAMMENSAJEERROR_'||i::varchar,xml2));
        raise notice 'JCC_CERENVCTA_RECEIVE CtaCodError=% - CtaMensajeError=%',cod_error1,msj_error1;

        --Si viene "S", es un error. Debe hacer un Rollback
        --<STATUS>OK</STATUS><CtaCodError>S</CtaCodError><CtaMensajeError>Registro cargado anteriormente...
        if cod_error1<>'N' then
                --Rollback
                cod_resp1:='2';
                msj_resp1:='Trx_Rollback';
                estado1:='ROLLBACK';
        end if;

        --xml2:=put_campo(xml2,'ERR',cod_error1);
        xml2:=put_campo(xml2,'GLOSA',msj_error1);

        xml2:=put_campo(xml2,'COD_RSP_CME',cod_resp1);
        xml2:=put_campo(xml2,'MSJ_RSP_CME',msj_resp1);
        xml2:=put_campo(xml2,'EST_CME',estado1);
        xml2:=put_campo(xml2,'MSJ_FIN_CME',msj_error1);       
 
        return xml2;
end;
$$
LANGUAGE plpgsql;*/
