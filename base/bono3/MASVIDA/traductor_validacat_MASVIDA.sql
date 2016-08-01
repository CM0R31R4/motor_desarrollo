CREATE OR REPLACE FUNCTION traductor_in_validacat_masvida(varchar)
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

	cod_fin1        varchar;
	rut_conv1       varchar;
	rut_tratat1     varchar;
	rut_solic1	varchar;
	rut_benef1	varchar;
	rut_cotiz1      varchar;
	cod_homologo1   varchar;
	item1           varchar;
	cod_diag1	varchar;
	cod_moda1       varchar;
	cod_tipaten1    varchar;
	fecha_nac1      varchar;
	cod_sexo1       varchar;
	fecha_inicio1   varchar;
	fecha_termino1  varchar;
	frec_prestdia1  varchar;
	lista1		varchar;
	lista2          varchar;
	lista3		varchar;
	lista4		varchar;
	lista5		varchar;
	lista6		varchar;
	ind_video1      varchar;
	ind_bilateral1  varchar;
	recargo1	varchar;
	ind_reembolso1  varchar;
	ind_programa1   varchar;
	cod_app1	varchar;
	cod_reg1        varchar;
	cod_suc1        varchar;
	tipo_prest1     varchar;
	cod_espec1	varchar;
	cod_prof1	varchar;
	antiguedad1     varchar;
	
begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1	:=get_campo('EXTCODFINANCIADOR',xml2);	/*SP MASVIDA NO TIENE DEFINIDO ESTE PARAMETRO*/
	rut_conv1	:=get_campo('EXTRUTCONVENIO',xml2);
	rut_tratat1	:=get_campo('EXTRUTTRATANTE',xml2);
	rut_solic1	:=get_campo('EXTRUTSOLICITANTE',xml2);
	rut_benef1	:=get_campo('EXTRUTBENEFICIARIO',xml2);
	rut_cotiz1	:=get_campo('EXTRUTCOTIZANTE',xml2);
	cod_homologo1	:=get_campo('EXTCODIGOHOMOLOGO',xml2);
	item1		:=get_campo('EXTITEM',xml2);
	cod_diag1	:=get_campo('EXTCODIGODIAGNOSTICO',xml2);
	cod_moda1	:=get_campo('EXTCODMODALIDAD',xml2);
	cod_tipaten1	:=get_campo('EXTCODTIPATENCION',xml2);
	fecha_nac1	:=replace(get_campo('EXTFECHANACIMIENTO',xml2),'-','');--Formato YYYYMMDD
	cod_sexo1	:=get_campo('EXTCODSEXO',xml2);
	fecha_inicio1	:=replace(get_campo('EXTFECHAINICIO',xml2),'-','');	--Formato YYYYMMDD
	fecha_termino1	:=replace(get_campo('EXTFECHATERMINO',xml2),'-','');	--Formato YYYYMMDD
	frec_prestdia1	:=get_campo('EXTFRECPRESTDIA',xml2);
	lista1		:=get_campo('EXTLISTAPRESTACA',xml2);
	lista2		:=get_campo('EXTLISTAPRESTACB',xml2);
	lista3		:=get_campo('EXTLISTAPRESTACC',xml2);
	lista4		:=get_campo('EXTLISTAPRESTACD',xml2);
	lista5		:=get_campo('EXTLISTAPRESTACE',xml2);
	lista6		:=get_campo('EXTLISTAPRESTACF',xml2);
	ind_video1	:=get_campo('EXTINDVIDEO',xml2);
	ind_bilateral1	:=get_campo('EXTINDBILATERAL',xml2);
	recargo1	:=get_campo('EXTRECARGOFUERAHORA',xml2);
	ind_reembolso1	:=get_campo('EXTINDREEMBOLSO',xml2);
	ind_programa1	:=get_campo('EXTINDPROGRAMA',xml2);
	cod_app1	:=get_campo('EXTCODAPLICACION',xml2);
	cod_reg1	:=get_campo('EXTCODREGION',xml2);
	cod_suc1	:=get_campo('EXTCODSUCUR',xml2);
	tipo_prest1	:=get_campo('EXTTIPOPRESTADOR',xml2);
	cod_espec1	:=get_campo('EXTCODESPECIALIDADES',xml2);
	cod_prof1	:=get_campo('EXTCODPROFESIONES',xml2);
	antiguedad1	:=get_campo('EXTANOSANTIGUEDAD',xml2);
	
	 --Valida formato del Rut
	rut_conv1     	:=motor_formato_rut(rut_conv1);
	rut_tratat1   	:=motor_formato_rut(rut_tratat1);
	rut_solic1    	:=motor_formato_rut(rut_solic1);
	rut_benef1      :=motor_formato_rut(rut_benef1);
	rut_cotiz1	:=motor_formato_rut(rut_cotiz1);

	--Si no corresponde al formato, retorna error al flujo. No llama a la Api.
        if (rut_conv1='')	or (rut_tratat1='')	or 
	   (rut_solic1='')     	or (rut_benef1='')     	or
	   (rut_cotiz1='')	then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;
        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

	declare_params:=' DECLARE @extCodFinanciador     numeric (5);
		DECLARE @extRutConvenio        char(12);
		DECLARE @extRutTratante        char(12);
		DECLARE @extRutSolicitante     char(12);
		DECLARE @extRutBeneficiario    char(12);
		DECLARE @extRutCotizante       char(12);
		DECLARE @extCodigoHomologo     char(12);
		DECLARE @extItem               char(2);
		DECLARE @extCodigoDiagnostico  char(10);
		DECLARE @extCodModalidad       char(2);
		DECLARE @extCodTipAtencion     char(2);
		DECLARE @extFechaNacimiento    datetime;
		DECLARE @extCodSexo            char(1);
		DECLARE @extFechaInicio        datetime;
		DECLARE @extFechaTermino       datetime;
		DECLARE @extFrecPrestDia       numeric(5);
		DECLARE @extListaPrestacA      char(255);
		DECLARE @extListaPrestacB      char(255);
		DECLARE @extListaPrestacC      char(255);
		DECLARE @extListaPrestacD      char(255);
		DECLARE @extListaPrestacE      char(255);
		DECLARE @extListaPrestacF      char(255);
		DECLARE @extIndVideo           char(1);
		DECLARE @extIndBilateral       char(1);
		DECLARE @extRecargoFueraHora   char(1);
		DECLARE @extIndReembolso       char(1);
		DECLARE @extIndPrograma        char(1);
		DECLARE @extCodAplicacion      char(2);
		DECLARE @extCodRegion          char(3);
		DECLARE @extCodSucur           char(10);
		DECLARE @extTipoPrestador      char(1);
		DECLARE @extCodEspecialidades  char(255);
		DECLARE @extCodProfesiones     char(255);
		DECLARE @extAnosAntiguedad     char(2);
		DECLARE @extRespuestaCAT       char(1);
		DECLARE @extMensajeCAT         char(100); ';
        
	exec_sp:='EXECUTE dbo.MASValidaCAt '||cod_fin1||',"'||rut_conv1||'","'||rut_tratat1||'","'||rut_solic1||'","'||rut_benef1||'","'||rut_cotiz1||'","'||cod_homologo1||'","'||item1||'","'||cod_diag1||'","'||cod_moda1||'","'||cod_tipaten1||'","'||fecha_nac1||'","'||cod_sexo1||'","'||fecha_inicio1||'","'||fecha_termino1||'",'||frec_prestdia1||',"'||lista1||'","'||lista2||'","'||lista3||'","'||lista4||'","'||lista5||'","'||lista6||'","'||ind_video1||'","'||ind_bilateral1||'","'||recargo1||'","'||ind_reembolso1||'","'||ind_programa1||'","'||cod_app1||'","'||cod_reg1||'","'||cod_suc1||'","'||tipo_prest1||'","'||cod_espec1||'","'||cod_prof1||'","'||antiguedad1||'", @extRespuestaCAT OUTPUT, @extMensajeCAT OUTPUT; ';

	/*Ejemplo*/
	-- execute dbo.MASValidaCAt 67,[76016305-8],[0004784367-7],[0004784367-7],[0004784367-7],[0004784367-7],[999],[JC],[888888],[01],[01],[1980-06-03],[M],[2013-05-22],[2013-05-30],,[],[],[],[],[],[],[0],[0],[N],[N],[N],[01],[RM],[222222],[1],[],[],[], @extRespuestaCAT OUTPUT, @extMensajeCAT OUTPUT select @extRespuestaCAT as extRespuestaCAT, @extMensajeCAT as extMensajeCAT

	out_params:='SELECT @extRespuestaCAT as extRespuestaCAT, @extMensajeCAT as extMensajeCAT; '; 

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_validacat_masvida(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	i		integer ='1';
	cod_resp1       varchar;
        mensaje_resp1   varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));
	
	--Parseo la Respuesta
	cod_resp1	:=trim(get_campo('EXTRESPUESTACAT_'||i::varchar,xml2));
	mensaje_resp1	:=trim(get_campo('EXTMENSAJECAT_'||i::varchar,xml2));

	xml2:=logapp(xml2,'MASVIDA: RSP_VALIDACAT -> extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1);

	--raise notice 'JCC_VALIDACAT_Receive cod_resp1=% - mensaje_resp1=% ',cod_resp1,mensaje_resp1;
	
	xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'EXTRESPUESTACAT',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJECAT',mensaje_resp1);

	--Solo para que guarde el mensaje de error
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

	xml2:=put_campo(xml2,'SQLOUTPUT','{'||get_campo('ERRORMSG',xml2)||', '||get_campo('EXTRESPUESTACAT',xml2)||', '||
                                        get_campo('EXTMENSAJECAT',xml2)||'}');
	
        return xml2;
end;
$$
LANGUAGE plpgsql;
