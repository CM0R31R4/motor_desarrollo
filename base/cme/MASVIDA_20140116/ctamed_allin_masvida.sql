CREATE OR REPLACE FUNCTION traductor_in_ctamed_masvida(varchar)
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
	xml2:=proc_parser_input_cerenvcta(xml2);

	--Preparo la llamada al SP
	declare_params:='DECLARE @CtaCodError char(1)
		DECLARE @CtaMensajeError char(60) ';
	
	--Por ahora en duro
	--||get_campo('CTACODFINANCIADOR',xml2)||
	exec_sp:= 'EXECUTE dbo.CERENVCTA '||88||',
			['||get_campo('CTANUMCTA',xml2)||'],
			'||get_campo('CTANUMCOBRO',xml2)||',
			'||get_campo('CTATIPENVIO',xml2)||',
			['||get_campo('CTAHOMNROCONVENIO',xml2)||'],
			['||get_campo('CTAHOMLUGARCONVENIO',xml2)||'],
			'||get_campo('CTATIPCTA',xml2)||',
			['||get_campo('CTAFECEMISION',xml2)||'],
			['||get_campo('CTAFECINGRESO',xml2)||'],
			['||get_campo('CTAHORAINGRESO',xml2)||'],
			['||get_campo('CTAFECCORTE',xml2)||'],
			['||get_campo('CTAFECALTA',xml2)||'],
			['||get_campo('CTAHORAALTA',xml2)||'],
			['||get_campo('CTAFECFUR',xml2)||'],
			['||get_campo('CTARUTCOTIZANTE',xml2)||'],
			['||get_campo('CTANOMBRECOTIZANTE',xml2)||'],
			['||get_campo('CTARUTBENEFICIARIO',xml2)||'],
			['||get_campo('CTAAPELLIDOPAT',xml2)||'],
			['||get_campo('CTAAPELLIDOMAT',xml2)||'],
			['||get_campo('CTANOMBRES',xml2)||'],
			['||get_campo('CTACODDIAGPRI',xml2)||'],
			['||get_campo('CTAGLODIAGPRIN',xml2)||'],
			['||get_campo('CTACODDIAGSEC',xml2)||'],
			['||get_campo('CTAGLODIAGSEC',xml2)||'],
			['||get_campo('CTARUTCONVENIO',xml2)||'],
			['||get_campo('CTARUTTRATANTE',xml2)||'],
			['||get_campo('CTANOMBRETRATANTE',xml2)||'],
			'||get_campo('CTATIPCOBRO',xml2)||',
			'||get_campo('CTATIPSALA',xml2)||',
			['||get_campo('CTACARTARESGUARDO',xml2)||'],
			['||get_campo('CTALEYURGENCIA',xml2)||'],
			['||get_campo('CTAINDCAEC',xml2)||'],
			['||get_campo('CTAINDAUGE',xml2)||'],
			'||get_campo('CTANROCIRUGIAS',xml2)||',
			'||get_campo('CTANROEQUIPMED',xml2)||',
			['||get_campo('CTAINDENVIO',xml2)||'],
			'||get_campo('CTAMTOTOTAL',xml2)||',
			'||get_campo('CTANUMDETEQUIPO',xml2)||',
			'||get_campo('CTAMTODETEQUIPO',xml2)||',
			'||get_campo('CTANUMDETHOTELERIA',xml2)||',
			'||get_campo('CTAMTODETHOTELERIA',xml2)||',
			'||get_campo('CTANUMDETINSUMO',xml2)||',
			'||get_campo('CTAMTODETINSUMOS',xml2)||',
			'||get_campo('CTANUMDETPAQUETES',xml2)||',
			'||get_campo('CTAMTODETPAQUETES',xml2)||', @CtaCodError OUTPUT, @CtaMensajeError OUTPUT ';

	out_params:='SELECT @CtaCodError as CtaCodError_CERENVCTA, @CtaMensajeError as CtaMensajeError_CERENVCTA ';

	--Llamo a la funcion input de parseo de datos.
        xml2:=proc_parser_input_cerequmed(xml2);

        --Preparo la llamada al SP
        declare_params:='DECLARE @ProCodError char(1)
                DECLARE @ProMensajeError char(60) ';

        --Por ahora en duro
        --||get_campo('PROCODFINANCIADOR',xml2)||
        exec_sp:= 'EXECUTE dbo.CEREQUMED '||get_campo('PROTIPODET',xml2)||',
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


	
	--Va a la API
        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_ctamed_masvida(varchar)
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
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Parseo respuesta
	cod_resp1	:=trim(get_campo('CTACODERROR_'||i::varchar,xml2));
	msj_resp1	:=trim(get_campo('CTAMENSAJEERROR_'||i::varchar,xml2));
	raise notice 'JCC_ALL_IN_Receive CtaCodError=% - CtaMensajeError=%',cod_resp1,msj_resp1;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'CTACODERROR',cod_resp1);
        xml2:=put_campo(xml2,'CTAMENSAJEERROR',msj_resp1);

        return xml2;
end;
$$
LANGUAGE plpgsql;

