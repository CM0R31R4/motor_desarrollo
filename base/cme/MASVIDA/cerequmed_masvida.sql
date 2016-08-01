CREATE OR REPLACE FUNCTION traductor_in_cerequmed_masvida(varchar)
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
	xml2:=proc_parser_input_cerequmed(xml2);
	if get_campo('ERR',xml2)='S' then
                xml2:=put_campo(xml2,'ESTADO_TX','FALLA_CME');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Error parser_input_'||get_campo('TX_WS',xml2));
                return xml2;
        end if;

	--Preparo la llamada al SP
	declare_params:='DECLARE @ProCodError char(1)
		DECLARE @ProMensajeError char(60) ';
	
	--Por ahora en duro
	--||get_campo('PROCODFINANCIADOR',xml2)||
	exec_sp:= 'EXECUTE dbo.cerequmed '||get_campo('PROTIPODET',xml2)||',
			['||get_campo('PRORUTPRESTADOR',xml2)||'],
			'||88||',
			['||get_campo('PRONUMCTA',xml2)||'],
			'||get_campo('PRONUMCOBRO',xml2)||',
			'||get_campo('PROTIPENVIO',xml2)||',
			['||get_campo('PROHOMNROCONVENIO',xml2)||'],
			['||get_campo('PROHOMLUGARCONVENIO',xml2)||'],
			'||get_campo('PROCORRELATIVO',xml2)||',
			'||get_campo('PROTIPOPROFESIONAL',xml2)||',
			['||get_campo('PRORUTPROFESIONAL',xml2)||'],
			['||get_campo('PRONOMBREPROFESIONAL',xml2)||'],
			['||get_campo('PROCODINTERVENPTD',xml2)||'],
			'||get_campo('PRONROINTENVEN',xml2)||', @ProCodError OUTPUT, @ProMensajeError OUTPUT ';

	out_params:='SELECT @ProCodError as ProCodError, @ProMensajeError as ProMensajeError ';

	--Esta data se guarda en t_ctamed campo sp_request
        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);

        return xml2;
end;
$$
LANGUAGE plpgsql;

/*CREATE OR REPLACE FUNCTION traductor_out_cerequmed_masvida(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	i		integer ='1';
	cod_resp1	varchar;
	msj_resp1	varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',clock_timestamp()::varchar);

	--Parseo respuesta
	cod_resp1	:=trim(get_campo('PROCODERROR_'||i::varchar,xml2));
	msj_resp1	:=trim(get_campo('PROMENSAJEERROR_'||i::varchar,xml2));
	raise notice 'JCC_cerequmed_RECEIVE ProCodError=% - ProMensajeError=%',cod_resp1,msj_resp1;

        *xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'PROCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'PROMENSAJEERROR',msj_resp1);*
	
	xml2:=put_campo(xml2,'ERR',cod_resp1);
        xml2:=put_campo(xml2,'GLOSA',msj_resp1);

        return xml2;
end;
$$
LANGUAGE plpgsql;*/

