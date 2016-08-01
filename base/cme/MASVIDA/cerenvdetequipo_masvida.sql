CREATE OR REPLACE FUNCTION traductor_in_cerenvdetequipo_masvida(varchar)
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
	--xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',clock_timestamp()::varchar);

	--Llamo a la funcion input de parseo de datos.
	xml2:=proc_parser_input_cerenvdetequipo(xml2);
	if get_campo('ERR',xml2)='S' then
                xml2:=put_campo(xml2,'ESTADO_TX','FALLA_CME');
		xml2:=put_campo(xml2,'MENSAJE_RESP','Error parser_input_'||get_campo('TX_WS',xml2));
                return xml2;
        end if;	

	--Preparo la llamada al SP
	declare_params:='DECLARE @CtaFecAtencion char(8);
		DECLARE @CtaCodError char(1)
		DECLARE @CtaMensajeError char(60) ';
	
	--get_campo('CTACODFINANCIADOR',xml2)
	exec_sp:= 'EXECUTE dbo.cerenvdetequipo '||get_campo('CTACORRREGISTRO',xml2)||',
			'||88||',
			['||get_campo('CTARUTCONVENIO',xml2)||'],
			['||get_campo('CTANUMCTA',xml2)||'],
			'||get_campo('CTANUMCOBRO',xml2)||',
			'||get_campo('CTATIPENVIO',xml2)||',
			['||get_campo('CTACODINTERVENPTD',xml2)||'],
			['||get_campo('CTADESCINTERVENPTD',xml2)||'],
			['||get_campo('CTACODINTERVENHOM',xml2)||'],
			['||get_campo('CTACODPRESTPTD',xml2)||'],
			['||get_campo('CTAITEMPRESTPTD',xml2)||'],
			['||get_campo('CTADESCPRESTPTD',xml2)||'],
			['||get_campo('CTACODPRESTHOM',xml2)||'],
			['||get_campo('CTAITEMPRESTHOM',xml2)||'],
			'||get_campo('CTANROINTENVEN',xml2)||',
			'||get_campo('CTATIPOVIA',xml2)||',
			'||get_campo('CTATIPOTECNICA',xml2)||',
			'||get_campo('CTATIPOVAL',xml2)||',
			['||get_campo('CTAFECATENCION',xml2)||'],
			['||get_campo('CTAHORAATENCION',xml2)||'],
			['||get_campo('CTAURGENCIA',xml2)||'],
			['||get_campo('CTARECARGOHORA',xml2)||'],
			['||get_campo('CTAORIGENATEN',xml2)||'],
			['||get_campo('CTARUTPROFESIONAL',xml2)||'],
			['||get_campo('CTANOMBREPROFESIONAL',xml2)||'],
			'||get_campo('CTATIPOPROFESIONAL',xml2)||',
			['||get_campo('CTACODESPECIALIDAD',xml2)||'],
			['||get_campo('CTADESCESPECIALIDAD',xml2)||'],
			['||get_campo('CTAPTDSTAFF',xml2)||'],
			'||get_campo('CTATIPOMOV',xml2)||',
			'||get_campo('CTAMTOTOTAL',xml2)||',
			'||get_campo('CTAMTOAFECTO',xml2)||',
			'||get_campo('CTAMTOEXENTO',xml2)||',
			'||get_campo('CTAMTOIVA',xml2)||',
			'||get_campo('CTAMTORECARGOHORARIO',xml2)||',
			['||get_campo('CTARUTFACTURADOR',xml2)||'],
			['||get_campo('CTANOMBREFACTURADOR',xml2)||'],
			['||get_campo('CTAINDBONIFICABLE',xml2)||'], @CtaCodError OUTPUT, @CtaMensajeError OUTPUT ';

	out_params:='SELECT @CtaCodError as CtaCodError, @CtaMensajeError as CtaMensajeError ';

	--Esta data se guarda en t_ctamed campo sp_request
        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);

        return xml2;
end;
$$
LANGUAGE plpgsql;

/*CREATE OR REPLACE FUNCTION traductor_out_cerenvdetequipo_masvida(varchar)
returns varchar as
$$
declare
        xml1	alias for $1;
        xml2	varchar;
	i	integer ='1';
	cod_error1	varchar;
	msj_error1	varchar;

	estado1		varchar;
	cod_resp1	varchar;
	msj_resp1	varchar;
begin
	--Este parseo se ejecuta, cuando fintx_ctamed esta en ejecucion
        xml2:=xml1;
        
        xml2:=put_campo(xml2,'FECHA_OUT_FIN',clock_timestamp()::varchar);
	estado1:='COMMIT';
        cod_resp1:='1';
        msj_resp1:='Trx_Commit';

	--Parseo respuesta
	cod_error1	:=trim(get_campo('CTACODERROR_'||i::varchar,xml2));
	msj_error1	:=trim(get_campo('CTAMENSAJEERROR_'||i::varchar,xml2));

	--cod_error1      :=trim(get_campo('CTACODERROR',xml2));
        --msj_error1      :=trim(get_campo('CTAMENSAJEERROR',xml2));
	raise notice 'JCC_CERENVDETEQUIPO_RECEIVE CtaCodError=% - CtaMensajeError=%',cod_error1,msj_error1;

	--Si viene "S", es un error. Debe hacer un Rollback
	--<CtaCodError>S</CtaCodError><CtaMensajeError>Cuenta no existe para este detalle...
        --if cod_error1='N' then
        if cod_error1<>'N' then
		--Rollback
		cod_resp1:='2';
                msj_resp1:='Trx_Rollback';
                estado1:='ROLLBACK';
                xml2:=put_campo(xml2,'SP_ROLLBACK','SI');
        end if;

	--xml2:=put_campo(xml2,'ERR',cod_error1);
        --xml2:=put_campo(xml2,'GLOSA',msj_error1);
	
        xml2:=put_campo(xml2,'COD_RSP_CME',cod_resp1);
        xml2:=put_campo(xml2,'MSJ_RSP_CME',msj_resp1);
        xml2:=put_campo(xml2,'EST_CME',estado1);
	xml2:=put_campo(xml2,'MSJ_FIN_CME',msj_error1);
	

        return xml2;
end;
$$
LANGUAGE plpgsql;*/

