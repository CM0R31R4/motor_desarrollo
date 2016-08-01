CREATE OR REPLACE FUNCTION bono3.traductor_in_validacat_masvida(varchar)
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
	rut_conv1	:=split_part(ltrim(get_campo('EXTRUTCONVENIO',xml2),'0'),'-',1);
	rut_tratat1	:=split_part(ltrim(get_campo('EXTRUTTRATANTE',xml2),'0'),'-',1);
	rut_solic1	:=split_part(ltrim(get_campo('EXTRUTSOLICITANTE',xml2),'0'),'-',1);
	rut_benef1	:=split_part(ltrim(get_campo('EXTRUTBENEFICIARIO',xml2),'0'),'-',1);
	rut_cotiz1	:=split_part(ltrim(get_campo('EXTRUTCOTIZANTE',xml2),'0'),'-',1);
	cod_homologo1	:=coalesce(nullif(get_campo('EXTCODIGOHOMOLOGO',xml2),''),'0');
	item1		:=coalesce(nullif(get_campo('EXTITEM',xml2),''),'0');
	cod_diag1	:=coalesce(nullif(get_campo('EXTCODIGODIAGNOSTICO',xml2),''),'0');
	cod_moda1	:=coalesce(nullif(get_campo('EXTCODMODALIDAD',xml2),''),'0');
	cod_tipaten1	:=coalesce(nullif(get_campo('EXTCODTIPATENCION',xml2),''),'0');
	fecha_nac1	:=replace(coalesce(nullif(get_campo('EXTFECHANACIMIENTO',xml2),''),'0'),'-','');--Formato YYYYMMDD
	cod_sexo1	:=coalesce(nullif(get_campo('EXTCODSEXO',xml2),''),'0');
	fecha_inicio1	:=replace(coalesce(nullif(get_campo('EXTFECHAINICIO',xml2),''),'0'),'-','');	--Formato YYYYMMDD
	fecha_termino1	:=replace(coalesce(nullif(get_campo('EXTFECHATERMINO',xml2),''),'0'),'-','');	--Formato YYYYMMDD
	frec_prestdia1	:=coalesce(nullif(get_campo('EXTFRECPRESTDIA',xml2),''),'0');
	lista1		:=coalesce(nullif(get_campo('EXTLISTAPRESTACA',xml2),''),'0');
	lista2		:=coalesce(nullif(get_campo('EXTLISTAPRESTACB',xml2),''),'0');
	lista3		:=coalesce(nullif(get_campo('EXTLISTAPRESTACC',xml2),''),'0');
	lista4		:=coalesce(nullif(get_campo('EXTLISTAPRESTACD',xml2),''),'0');
	lista5		:=coalesce(nullif(get_campo('EXTLISTAPRESTACE',xml2),''),'0');
	lista6		:=coalesce(nullif(get_campo('EXTLISTAPRESTACF',xml2),''),'0');
	ind_video1	:=coalesce(nullif(get_campo('EXTINDVIDEO',xml2),''),'0');
	ind_bilateral1	:=coalesce(nullif(get_campo('EXTINDBILATERAL',xml2),''),'0');
	recargo1	:=coalesce(nullif(get_campo('EXTRECARGOFUERAHORA',xml2),''),'0');
	ind_reembolso1	:=coalesce(nullif(get_campo('EXTINDREEMBOLSO',xml2),''),'0');
	ind_programa1	:=coalesce(nullif(get_campo('EXTINDPROGRAMA',xml2),''),'0');
	cod_app1	:=coalesce(nullif(get_campo('EXTCODAPLICACION',xml2),''),'0');
	cod_reg1	:=coalesce(nullif(get_campo('EXTCODREGION',xml2),''),'0');
	cod_suc1	:=coalesce(nullif(get_campo('EXTCODSUCUR',xml2),''),'0');
	tipo_prest1	:=coalesce(nullif(get_campo('EXTTIPOPRESTADOR',xml2),''),'0');
	cod_espec1	:=coalesce(nullif(get_campo('EXTCODESPECIALIDADES',xml2),''),'0');
	cod_prof1	:=coalesce(nullif(get_campo('EXTCODPROFESIONES',xml2),''),'0');
	antiguedad1	:=coalesce(nullif(get_campo('EXTANOSANTIGUEDAD',xml2),''),'0');
	
	--Formateo el Rut
	rut_conv1     	:=lpad(rut_conv1,10,'0')||'-'||motor_modulo11(rut_conv1);
	rut_tratat1   	:=lpad(rut_tratat1,10,'0')||'-'||motor_modulo11(rut_tratat1);
	rut_solic1    	:=lpad(rut_solic1,10,'0')||'-'||motor_modulo11(rut_solic1);
	rut_benef1      :=lpad(rut_benef1,10,'0')||'-'||motor_modulo11(rut_benef1);
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);
	rut_cotiz1	:=lpad(rut_cotiz1,10,'0')||'-'||motor_modulo11(rut_cotiz1);
       	
	--Enviamos el dato en 0, de lo contrario se cae
        /*cod_homologo1	:=coalesce(nullif(cod_homologo1,''),'0');
	item1		:=coalesce(nullif(item1,''),'0');
        cod_diag1	:=coalesce(nullif(cod_diag1,''),'0');
        cod_moda1	:=coalesce(nullif(cod_moda1,''),'0');
	cod_espec1	:=coalesce(nullif(cod_espec1,''),'0');*/

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
        
	exec_sp:='EXECUTE dbo.MASValidaCAt '||cod_fin1||',['||rut_conv1||'],['||rut_tratat1||'],['||rut_solic1||'],['||rut_benef1||'],['||rut_cotiz1||'],['||cod_homologo1||'],['||item1||'],['||cod_diag1||'],['||cod_moda1||'],['||cod_tipaten1||'],['||fecha_nac1||'],['||cod_sexo1||'],['||fecha_inicio1||'],['||fecha_termino1||'],'||frec_prestdia1||',"'||lista1||'","'||lista2||'","'||lista3||'","'||lista4||'","'||lista5||'","'||lista6||'",['||ind_video1||'],['||ind_bilateral1||'],['||recargo1||'],['||ind_reembolso1||'],['||ind_programa1||'],['||cod_app1||'],['||cod_reg1||'],['||cod_suc1||'],['||tipo_prest1||'],['||cod_espec1||'],['||cod_prof1||'],['||antiguedad1||'], @extRespuestaCAT OUTPUT, @extMensajeCAT OUTPUT; ';

	/*Ejemplo*/
	-- execute dbo.MASValidaCAt 67,[76016305-8],[0004784367-7],[0004784367-7],[0004784367-7],[0004784367-7],[999],[JC],[888888],[01],[01],[1980-06-03],[M],[2013-05-22],[2013-05-30],,[],[],[],[],[],[],[0],[0],[N],[N],[N],[01],[RM],[222222],[1],[],[],[], @extRespuestaCAT OUTPUT, @extMensajeCAT OUTPUT select @extRespuestaCAT as extRespuestaCAT, @extMensajeCAT as extMensajeCAT

	out_params:='SELECT @extRespuestaCAT as extRespuestaCAT, @extMensajeCAT as extMensajeCAT; '; 

        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_sp||out_params);
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_validacat_masvida(varchar)
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
	raise notice 'JCC_VALIDACAT_Receive cod_resp1=% - mensaje_resp1=% ',cod_resp1,mensaje_resp1;
	
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
        return xml2;
end;
$$
LANGUAGE plpgsql;
