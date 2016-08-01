CREATE OR REPLACE FUNCTION bono3.traductor_in_validacat_consalud(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

	extCodFinanciador	varchar;
	rut_conv1		varchar;
	rut_tratante1		varchar;
	rut_solic1	varchar;
	rut_benef1	varchar;
	rut_cotiza1		varchar;
	extCodigoHomologo	varchar;
	extItem			varchar;
	extCodigoDiagnostico	varchar;
	extCodModalidad		varchar;
	extCodTipAtencion	varchar;
	extFechaNacimiento	varchar;
	extCodSexo		varchar;
	extFechaInicio		varchar;
	extFechaTermino		varchar;
	extFrecPrestDia		varchar;
	extListaPrestacA	varchar;
	extListaPrestacB	varchar;
	extListaPrestacC	varchar;
	extListaPrestacD	varchar;
	ExtListaPrestacE	varchar;
	extListaPrestacF	varchar;
	extIndVideo		varchar;
	extIndBilateral		varchar;
	extRecargoFueraHora	varchar;
	extIndReembolso		varchar;
	extIndPrograma		varchar;
	extCodAplicacion	varchar;
	extCodRegion		varchar;
	extCodSucur		varchar;
	extTipoPrestador	varchar;
	extCodEspecialidades	varchar;
	extCodProfesiones	varchar;
	extAnosAntiguedad	varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	extCodFinanciador	:= trim(get_campo('EXTCODFINANCIADOR',xml2));
	rut_conv1		:= split_part(ltrim(get_campo('EXTRUTCONVENIO',xml2),'0'),'-',1);
	rut_tratante1		:= split_part(ltrim(get_campo('EXTRUTTRATANTE',xml2),'0'),'-',1);
	rut_solic1	:= split_part(ltrim(get_campo('EXTRUTSOLICITANTE',xml2),'0'),'-',1);
	rut_benef1	:= split_part(ltrim(get_campo('EXTRUTBENEFICIARIO',xml2),'0'),'-',1);
	rut_cotiza1		:= split_part(ltrim(get_campo('EXTRUTCOTIZANTE',xml2),'0'),'-',1);
	extCodigoHomologo	:= coalesce(nullif(get_campo('EXTCODIGOHOMOLOGO',xml2),''),'0');
	extItem			:= coalesce(nullif(get_campo('EXTITEM',xml2),''),'0');
	extCodigoDiagnostico	:= coalesce(nullif(get_campo('EXTCODIGODIAGNOSTICO',xml2),''),'0');
	extCodModalidad		:= coalesce(nullif(get_campo('EXTCODMODALIDAD',xml2),''),'0');
	extCodTipAtencion	:= coalesce(nullif(get_campo('EXTCODTIPATENCION',xml2),''),'0');
	extFechaNacimiento	:= to_char(get_campo('EXTFECHANACIMIENTO',xml2)::date, 'DD-MON-YYYY');
	extCodSexo		:= coalesce(nullif(get_campo('EXTCODSEXO',xml2),''),'0');
	extFechaInicio		:= to_char(get_campo('EXTFECHAINICIO',xml2)::date, 'DD-MON-YYYY');
	extFechaTermino		:= to_char(get_campo('EXTFECHATERMINO',xml2)::date, 'DD-MON-YYYY');
	extFrecPrestDia		:= coalesce(nullif(get_campo('EXTFRECPRESTDIA',xml2),''),'0');
	extListaPrestacA	:= coalesce(nullif(get_campo('EXTLISTAPRESTACA',xml2),''),'0');
	extListaPrestacB	:= coalesce(nullif(get_campo('EXTLISTAPRESTACB',xml2),''),'0');
	extListaPrestacC	:= coalesce(nullif(get_campo('EXTLISTAPRESTACC',xml2),''),'0');
	extListaPrestacD	:= coalesce(nullif(get_campo('EXTLISTAPRESTACD',xml2),''),'0');
	ExtListaPrestacE	:= coalesce(nullif(get_campo('EXTLISTAPRESTACE',xml2),''),'0');
	extListaPrestacF	:= coalesce(nullif(get_campo('EXTLISTAPRESTACF',xml2),''),'0');
	extIndVideo		:= coalesce(nullif(get_campo('EXTINDVIDEO',xml2),''),'0');
	extIndBilateral		:= coalesce(nullif(get_campo('EXTINDBILATERAL',xml2),''),'0');
	extRecargoFueraHora	:= coalesce(nullif(get_campo('EXTRECARGOFUERAHORA',xml2),''),'0');
	extIndReembolso		:= coalesce(nullif(get_campo('EXTINDREEMBOLSO',xml2),''),'0');
	extIndPrograma		:= coalesce(nullif(get_campo('EXTINDPROGRAMA',xml2),''),'0');
	extCodAplicacion	:= coalesce(nullif(get_campo('EXTCODAPLICACION',xml2),''),'0');
	extCodRegion		:= coalesce(nullif(get_campo('EXTCODREGION',xml2),''),'0');
	extCodSucur		:= coalesce(nullif(get_campo('EXTCODSUCUR',xml2),''),'0');
	extTipoPrestador	:= coalesce(nullif(get_campo('EXTTIPOPRESTADOR',xml2),''),'0');
	extCodEspecialidades	:= coalesce(nullif(get_campo('EXTCODESPECIALIDADES',xml2),''),'0');
	extCodProfesiones	:= coalesce(nullif(get_campo('EXTCODPROFESIONES',xml2),''),'0');
	extAnosAntiguedad	:= coalesce(nullif(get_campo('EXTANOSANTIGUEDAD',xml2),''),'0');

	--Fomato Rut
	
        if length(rut_conv1)>'0' then rut_conv1 	:=lpad(rut_conv1,10,'0')||'-'||motor_modulo11(rut_conv1);end if;
        if length(rut_tratante1)>'0' then rut_tratante1 :=lpad(rut_tratante1,10,'0')||'-'||motor_modulo11(rut_tratante1);end if;
        if length(rut_solic1)>'0' then rut_solic1     	:=lpad(rut_solic1,10,'0')||'-'||motor_modulo11(rut_solic1);end if;
        if length(rut_benef1)>'0' then rut_benef1       :=lpad(rut_benef1,10,'0')||'-'||motor_modulo11(rut_benef1);end if;
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);
        if length(rut_cotiza1)>'0' then rut_cotiza1     :=lpad(rut_cotiza1,10,'0')||'-'||motor_modulo11(rut_cotiza1);end if;

        xml2:=put_campo(xml2,'INPUT','["IMEDSOF.CONVALIDACAT_PKG.CONVALIDACAT", [ "$o$STRING", '||extCodFinanciador||', '||chr(34)||rut_conv1||chr(34)||', '||chr(34)||rut_tratante1||chr(34)||', '||chr(34)||rut_solic1||chr(34)||', '||chr(34)||rut_benef1||chr(34)||', '||chr(34)||rut_cotiza1||chr(34)||', '||chr(34)||extCodigoHomologo||chr(34)||', '||chr(34)||extItem||chr(34)||', '||chr(34)||extCodigoDiagnostico||chr(34)||', '||chr(34)||extCodModalidad||chr(34)||', '||chr(34)||extCodTipAtencion||chr(34)||', '||chr(34)||extFechaNacimiento||chr(34)||', '||chr(34)||extCodSexo||chr(34)||', '||chr(34)||extFechaInicio||chr(34)||', '||chr(34)||extFechaTermino||chr(34)||', '||extFrecPrestDia||', '||chr(34)||extListaPrestacA||chr(34)||', '||chr(34)||extListaPrestacB||chr(34)||', '||chr(34)||extListaPrestacC||chr(34)||', '||chr(34)||extListaPrestacD||chr(34)||', '||chr(34)||ExtListaPrestacE||chr(34)||', '||chr(34)||extListaPrestacF||chr(34)||', '||chr(34)||extIndVideo||chr(34)||', '||chr(34)||extIndBilateral||chr(34)||', '||chr(34)||extRecargoFueraHora||chr(34)||', '||chr(34)||extIndReembolso||chr(34)||', '||chr(34)||extIndPrograma||chr(34)||', '||chr(34)||extCodAplicacion||chr(34)||', '||chr(34)||extCodRegion||chr(34)||', '||chr(34)||extCodSucur||chr(34)||', '||chr(34)||extTipoPrestador||chr(34)||', '||chr(34)||extCodEspecialidades||chr(34)||', '||chr(34)||extCodProfesiones||chr(34)||', '||chr(34)||extAnosAntiguedad||chr(34)||', "$o$STRING", "$o$STRING" ]]'||chr(10)||chr(10));

	return xml2;
end;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION bono3.traductor_out_validacat_consalud(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        aux1    varchar;
        resp1   varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

        resp1:=replace(get_campo('RESPUESTA',xml2),chr(10),'');
        --Si no esta el tag result es porque hay error
        aux1:=json_field(resp1,'result');
        if aux1 is null then
                --Vemos si hay error del ORACLE
                aux1:=json_field(resp1,'ora-msg');
		if aux1 is null then
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG',replace(aux1,'\\n',''));
                --Otro Error
                else
                        xml2:=put_campo(xml2,'ERRORCOD','99');
                        xml2:=put_campo(xml2,'ERRORMSG','Error Generico');
                end if;
                return xml2;
        end if;

        --Parseo la respuesta
        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',	trim(replace(json_field(aux1,'0'),'"','')));
        xml2:=put_campo(xml2,'EXTRESPUESTACAT',	trim(replace(json_field(aux1,'1'),'"','')));
        xml2:=put_campo(xml2,'EXTMENSAJECAT',	trim(replace(json_field(aux1,'2'),'"','')));

	--Solo para que guarde el mensaje de error
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',trim(replace(json_field(aux1,'2'),'"','')));
	return xml2;
end;
$$
LANGUAGE plpgsql;


