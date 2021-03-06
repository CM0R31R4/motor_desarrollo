CREATE OR REPLACE FUNCTION traductor_in_cerenvcta_masvida(varchar)
returns varchar as $$
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

	--Llamo a la funcion input de parseo de datos.Si viene con error no sigue 
	xml2:=proc_parser_cerenvcta(xml2);
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
	exec_sp:= 'EXECUTE dbo.cerenvcta '||88||',
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

CREATE OR REPLACE FUNCTION traductor_out_cerenvcta_masvida(varchar)
returns varchar as $$
declare
        xml1		alias for $1;
        xml2		varchar;
	i		integer ='1';
	cod_error1	varchar;
	msj_error1	varchar;

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
	cod_error1	:=trim(get_campo('CTACODERROR_'||i::varchar,xml2));
	msj_error1	:=trim(get_campo('CTAMENSAJEERROR_'||i::varchar,xml2));
	raise notice 'JCC_CERENVCTA_RECEIVE CtaCodError=% - CtaMensajeError=%',cod_error1,msj_error1;

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

