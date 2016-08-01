CREATE OR REPLACE FUNCTION traductor_in_cerencprot_masvida(varchar)
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
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Llamo a la funcion input de parseo de datos.
	xml2:=proc_parser_input_cerencprot(xml2);
	if get_campo('ERR',xml2)='S' then
                xml2:=put_campo(xml2,'ESTADO_TX','FALLA_CONTENCION');
                xml2:=put_campo(xml2,'CODIGO_RESP','2');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Trx_No_Contenida');
                return xml2;
        end if;

	--Preparo la llamada al SP
	declare_params:='DECLARE @ProCodError char(1)
		DECLARE @ProMensajeError char(60) ';
	
	--Por ahora en duro
	--||get_campo('PROCODFINANCIADOR',xml2)||
	exec_sp:= 'EXECUTE dbo.cerencprot ['||get_campo('PRORUTPRESTADOR',xml2)||'],
			'||88||',
			['||get_campo('PRONUMCTA',xml2)||'],
			'||get_campo('PRONUMCOBRO',xml2)||',
			'||get_campo('PROTIPENVIO',xml2)||',
			['||get_campo('PROHOMNROCONVENIO',xml2)||'],
			['||get_campo('PROHOMLUGARCONVENIO',xml2)||'],
			'||get_campo('PROCORRELATIVO',xml2)||',
			['||get_campo('PROCODINTERVENPTD',xml2)||'],
			['||get_campo('PRODESCPRESTA',xml2)||'],
			['||get_campo('PRONOMBREMEDICO',xml2)||'],
			['||get_campo('PRORUTPACIENTE',xml2)||'],
			['||get_campo('PROAPELLIDOPAT',xml2)||'],
			['||get_campo('PROAPELLIDOMAT',xml2)||'],
			['||get_campo('PRONOMBRES',xml2)||'],
			['||get_campo('PROSEXO',xml2)||'],
			'||get_campo('PROEDAD',xml2)||',
			['||get_campo('PROURGENCIA',xml2)||'],
			['||get_campo('PROANESTESIA',xml2)||'],
			['||get_campo('PROPABELLON',xml2)||'],
			['||get_campo('PROFECINGPABELLON',xml2)||'],
			['||get_campo('PROHORAINGPABELLON',xml2)||'],
			['||get_campo('PROFECTERPABELLON',xml2)||'],
			['||get_campo('PROHORATERPABELLON',xml2)||'],
			['||get_campo('PRORIESGO',xml2)||'],
			['||get_campo('PROPIEZA',xml2)||'],
			['||get_campo('PROOBSERVACION',xml2)||'], @ProCodError OUTPUT, @ProMensajeError OUTPUT ';

	out_params:='SELECT @ProCodError as ProCodError, @ProMensajeError as ProMensajeError ';

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

CREATE OR REPLACE FUNCTION traductor_out_cerencprot_masvida(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	i		integer ='1';
	cod_error1      varchar;
        msj_error1      varchar;

        estado1         varchar;
        cod_resp1       varchar;
        msj_resp1       varchar;

begin
        --Esta funcion se ejecuta, cuando fintx_ctamed esta en ejecucion
        xml2:=xml1;

        xml2:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));
        estado1:='COMMIT';
        cod_resp1:='1';
        msj_resp1:='Trx_Commit';

        --Parseo respuesta
        cod_error1      :=trim(get_campo('PROCODERROR_'||i::varchar,xml2));
        msj_error1      :=trim(get_campo('PROMENSAJEERROR_'||i::varchar,xml2));
        raise notice 'JCC_CERENCPRO_RECEIVE ProCodError=% - ProMensajeError=%',cod_error1,msj_error1;

	--Para guardar el response del SP en t_ctamed, campo sp_return
	xml2:=put_campo(xml2,'SQLOUTPUT','{'||cod_error1||', '||msj_error1||'}');

        --Si viene "S", es un error. Debe hacer un Rollback
        --<STATUS>OK</STATUS><CtaCodError>S</CtaCodError><CtaMensajeError>Registro cargado anteriormente...
        if cod_error1<>'N' then
                --Rollback
                cod_resp1:='2';
                msj_resp1:='Trx_Rollback';
                estado1:='ROLLBACK';
		--En caso de Rollback, Siempre debe crear este tag
                xml2:=put_campo(xml2,'SP_ROLLBACK','SI');
        end if;

        /*xml2:=put_campo(xml2,'ERR',cod_error1);
        xml2:=put_campo(xml2,'GLOSA',msj_error1);*/

        xml2:=put_campo(xml2,'COD_RSP_CME',cod_resp1);
        xml2:=put_campo(xml2,'MSJ_RSP_CME',msj_resp1);
        xml2:=put_campo(xml2,'EST_CME',estado1);
        xml2:=put_campo(xml2,'MSJ_FIN_CME',msj_error1);

        return xml2;
end;
$$
LANGUAGE plpgsql;
