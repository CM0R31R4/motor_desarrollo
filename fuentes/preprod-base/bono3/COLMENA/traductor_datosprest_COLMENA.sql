CREATE OR REPLACE FUNCTION traductor_in_datosprest_colmena(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	declare_params	varchar;
        out_params  	varchar;
        insert1  	varchar;
        exec_sp		varchar;
        exec_end  	varchar;
	select1		varchar;
	cod_fin1 	varchar;
	rut_conv1	varchar;
	cod_sucur1	varchar;
/*
     @extCodFinanciador              smallint
    , @extRutConvenio                 char(12)
    , @extCodigoSucur                 char(10)
    , @extEstConvenio                 char(10)        Output
    , @extNivel                       tinyint         Output
    , @extTipoPrestador               char(1)         Output
    , @extCodEspecialidades           char(255)       Output
    , @extCodProfesiones              char(255)       Output
    , @extAnosAntiguedad              char(2)         Output
*/	
begin
        xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        :=trim(get_campo('EXTCODFINANCIADOR',xml2));
        rut_conv1       :=get_campo('EXTRUTCONVENIO',xml2);
        cod_sucur1      :=get_campo('EXTCODIGOSUCUR',xml2);

	--Valida formato del Rut
        /*rut_conv1:=motor_formato_rut(rut_conv1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_conv1='')  then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;*/
        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_conv1);

	declare_params:='DECLARE @extCodFinanciador numeric (5)
	        DECLARE @extRutConvenio char(12)
	        DECLARE @extCodigoSucur char(10)
        	DECLARE @extEstConvenio char(10)
		DECLARE @extNivel numeric(1)
		DECLARE @extTipoPrestador char(1)
		DECLARE @extCodEspecialidades char(255)
		DECLARE @extCodProfesiones char(255)
		DECLARE @extAnosAntiguedad char(2) ';

	--CREATE TABLE #Result(extRutAcompanante char (12),extNombreAcompanante char (40)) ';
	exec_sp:= 'EXECUTE CGCDatosPrest '||cod_fin1||',"'||rut_conv1||'","'||cod_sucur1||'", @extEstConvenio OUTPUT, @extNivel OUTPUT, @extTipoPrestador OUTPUT, @extCodEspecialidades OUTPUT, @extCodProfesiones OUTPUT, @extAnosAntiguedad OUTPUT ';

	out_params:='SELECT @extEstConvenio as extEstConvenio, @extNivel as extNivel,@extTipoPrestador as extTipoPrestador,@extCodEspecialidades as extCodEspecialidades, @extCodProfesiones as extCodProfesiones, @extAnosAntiguedad as extAnosAntiguedad ';

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_datosprest_colmena(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	i		integer ='1';
	est_conv1	varchar;
	nivel1		varchar;
	tipo_prest1	varchar;
	cod_espec1	varchar;
	cod_prof1	varchar;
	antiguedad1	varchar;
	cod_resp1	varchar;	
	
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	est_conv1	:=trim(get_campo('EXTESTCONVENIO_'||i::varchar,xml2));
	nivel1		:=trim(get_campo('EXTNIVEL_'||i::varchar,xml2));
	tipo_prest1	:=trim(get_campo('EXTTIPOPRESTADOR_'||i::varchar,xml2));
	cod_espec1	:=trim(get_campo('EXTCODESPECIALIDADES_'||i::varchar,xml2));
	cod_prof1	:=trim(get_campo('EXTCODPROFESIONES_'||i::varchar,xml2));
	antiguedad1	:=trim(get_campo('EXTANOSANTIGUEDAD_'||i::varchar,xml2));
	
	xml2:=logapp(xml2,'COLMENA: RSP_DATOSPREST -> extEstConvenio='||est_conv1||' -extNivel='||nivel1||' -extTipoPrestador='||tipo_prest1||' -extCodEspecialidades='||cod_espec1||' -extCodProfesiones='||cod_prof1||' -extAnosAntiguedad='||antiguedad1);

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
        --Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;

	xml2:=put_campo(xml2,'EXTESTCONVENIO',est_conv1);
        xml2:=put_campo(xml2,'EXTNIVEL',nivel1);
        xml2:=put_campo(xml2,'EXTTIPOPRESTADOR',tipo_prest1);
        xml2:=put_campo(xml2,'EXTCODESPECIALIDADES',cod_espec1);
        xml2:=put_campo(xml2,'EXTCODPROFESIONES',cod_prof1);
        xml2:=put_campo(xml2,'EXTANOSANTIGUEDAD',antiguedad1);

	xml2:=put_campo(xml2,'SQLOUTPUT','{'||get_campo('ERRORMSG',xml2)||', '||get_campo('EXTESTCONVENIO',xml2)||', '||
                                        get_campo('EXTNIVEL',xml2)||', '||get_campo('EXTTIPOPRESTADOR',xml2)||', '||
                                        get_campo('EXTCODESPECIALIDADES',xml2)||', '||get_campo('EXTCODPROFESIONES',xml2)||', '||
                                        get_campo('EXTANOSANTIGUEDAD',xml2)||'}');

        return xml2;
end;
$$
LANGUAGE plpgsql;

