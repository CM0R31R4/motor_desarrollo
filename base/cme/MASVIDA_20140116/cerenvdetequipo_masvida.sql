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
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Llamo a la funcion input de parseo de datos.
	xml2:=proc_parser_input_cerenvdetequipo(xml2);

	--Preparo la llamada al SP
	declare_params:='DECLARE @CtaCodError char(1)
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

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);

	--Si no hay falla. Contesta el Resquest con OK1.
        xml2:=put_campo(xml2,'ERR','N');
        xml2:=put_campo(xml2,'GLOSA','CME Contenida');
        xml2:=put_campo(xml2,'ESTADO_TX','CONTENIDA');
        xml2:=put_campo(xml2,'CODIGO_RESP','1');
        xml2:=put_campo(xml2,'MENSAJE_RESP','Trasaccion Contenida');

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_cerenvdetequipo_masvida(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	stCme	tx_ctamed%ROWTYPE;
	i		integer ='1';
	cod_resp1	varchar;
	msj_resp1	varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Este parseo se ejecuta, cuando fintx_ctamed esta en ejecucion

	--Parseo respuesta
	cod_resp1	:=trim(get_campo('CTACODERROR_'||i::varchar,xml2));
	msj_resp1	:=trim(get_campo('CTAMENSAJEERROR_'||i::varchar,xml2));
	raise notice 'JCC_cerenvdetequipo_Receive CtaCodError=% - CtaMensajeError=%',cod_resp1,msj_resp1;

        /*xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'CTACODERROR',cod_resp1);
        xml2:=put_campo(xml2,'CTAMENSAJEERROR',msj_resp1);*/
	
	xml2:=put_campo(xml2,'ERR',cod_resp1);
        xml2:=put_campo(xml2,'GLOSA',msj_resp1);
	

        return xml2;
end;
$$
LANGUAGE plpgsql;

