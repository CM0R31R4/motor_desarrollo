CREATE OR REPLACE FUNCTION traductor_in_bencertif_fonasa(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	data1	varchar;
	rqt_xml1 varchar;

	cod_fin1 	varchar;
        rut_ben1	varchar;
        fecha_actual1 	varchar;
	
begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        :=trim(get_campo('EXTCODFINANCIADOR',xml2));
        rut_ben1        :=get_campo('EXTRUTBENEFICIARIO',xml2);
        fecha_actual1   :=to_char(get_campo('EXTFECHAACTUAL',xml2)::date, 'YYYY/MM/DD'); --AAAA/MM/DD

	--Valida formato del Rut
        /*rut_ben1:=motor_formato_rut(rut_ben1);
        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_ben1='')  then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;*/

        --Envia y almacena lo que viene.
	--rut_ben1:=split_part(rut_ben1,'-',1);
        xml2    :=put_campo(xml2,'RUT_BASE',rut_ben1);

	--Armo el Xml Request que va a Fonasa
	rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wsc="http://WSCerFonasaNM/"><soapenv:Header/><soapenv:Body><wsc:BenCertif><wsc:extCodFinanciador>'||cod_fin1||'</wsc:extCodFinanciador><wsc:extRutBeneficiario>'||rut_ben1||'</wsc:extRutBeneficiario><wsc:extFechaActual>'||fecha_actual1||'</wsc:extFechaActual></wsc:BenCertif></soapenv:Body></soapenv:Envelope>';

	data1:='POST /WSCerFonasa/WSCerFonasa.asmx HTTP/1.1'||chr(10)||
		'Accept-Encoding: gzip,deflate'||chr(10)||
		'Content-Type: text/xml;charset=UTF-8'||chr(10)||
		'SOAPAction: "http://WSCerFonasaNM/BenCertif"'||chr(10)||
		'User-Agent: Jakarta Commons-HttpClient/3.1'||chr(10)||
		'Host: 10.100.32.129'||chr(10)||
		'Content-Length: '||length(rqt_xml1)||chr(10)||chr(10)||rqt_xml1;
	
	--Envio la data
	xml2:=put_campo(xml2,'SQLINPUT',data1);
	--xml2:=put_campo(xml2,'INPUT',data1);

	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_bencertif_fonasa(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	rsp_xml1        varchar;
	
	cod_resp1      	varchar;
	mensaje_resp1  	varchar;
	apell_pat1	varchar;
	apell_mat1	varchar;
	nombre1		varchar;
	sexo1		varchar;
	fecha_nac1	varchar;
	cod_est_ben1	varchar;
	desc_estado1	varchar;
	rut_cotiza1	varchar;
	nom_cotiza1	varchar;
	direccion1	varchar;
	glosa_comuna1	varchar;
	glosa_ciudad1	varchar;
	prevision1	varchar;
	glosa1		varchar;
	plan1		varchar;
	dscto_planilla1	varchar;
	monto_exec1	varchar;
	rut_acompa1	varchar;
	nom_acompa1	varchar;
	ano1		varchar;
	ano_now1	varchar;
begin
        xml2:=xml1;
	xml2  	:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2  	:=put_campo(xml2,'CODIGO_RESP','1');
        xml2  	:=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2  	:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));
	
	--Paseo la respuesta
	rsp_xml1:=get_campo('SQLOUTPUT',xml2);
	
	--Si no hay respuesta Fonasa.
	if length(rsp_xml1)=0 then
		xml2:=put_campo(xml2,'ESTADO_WS','-1');
		xml2:=logapp(xml2,'Fonasa no Responde');
		return xml2;
	end if;

	--Si tengo data y hay error HTTP 200 OK=323030204f4b
        if strpos(rsp_xml1,'323030204f4b')>0 then
		xml2:=logapp(xml2,'Llega un 200 OK');
		cod_resp1	:=trim(get_tag_xml_hex('extCodError',rsp_xml1));
		mensaje_resp1	:=trim(get_tag_xml_hex('extMensajeError',rsp_xml1));
		apell_pat1	:=trim(get_tag_xml_hex('extApellidoPat',rsp_xml1));
		apell_mat1	:=trim(get_tag_xml_hex('extApellidoMat',rsp_xml1));
		nombre1		:=trim(get_tag_xml_hex('extNombres',rsp_xml1));
		sexo1		:=trim(get_tag_xml_hex('extSexo',rsp_xml1));
		fecha_nac1	:=trim(get_tag_xml_hex('extFechaNacimi',rsp_xml1));
		cod_est_ben1	:=trim(get_tag_xml_hex('extCodEstBen',rsp_xml1));
		desc_estado1	:=trim(get_tag_xml_hex('extDescEstado',rsp_xml1));
		rut_cotiza1	:=trim(get_tag_xml_hex('extRutCotizante',rsp_xml1));
		nom_cotiza1	:=trim(get_tag_xml_hex('extNomCotizante',rsp_xml1));
		direccion1	:=trim(get_tag_xml_hex('extDirPaciente',rsp_xml1));
		glosa_comuna1	:=trim(get_tag_xml_hex('extGlosaComuna',rsp_xml1));
		glosa_ciudad1	:=trim(get_tag_xml_hex('extGlosaCiudad',rsp_xml1));
		prevision1	:=trim(get_tag_xml_hex('extPrevision',rsp_xml1));
		glosa1		:=trim(get_tag_xml_hex('extGlosa',rsp_xml1));
		plan1		:=trim(get_tag_xml_hex('extPlan',rsp_xml1));
		dscto_planilla1	:=trim(get_tag_xml_hex('extDescuentoxPlanilla',rsp_xml1));	--Al WS de Sonda le falta este campo
		monto_exec1	:=trim(get_tag_xml_hex('extMontoExcedente',rsp_xml1));
		rut_acompa1	:=trim(get_tag_xml_hex('extRutCotizante',rsp_xml1));
		nom_acompa1	:=trim(get_tag_xml_hex('extNomCotizante',rsp_xml1));
        else
                cod_resp1:='S';
                --mensaje_resp1:='Error Call Fonasa_WS';
                mensaje_resp1:=trim(get_tag_xml_hex('faultstring',rsp_xml1));
		xml2:=put_campo(xml2,'API_CODRESPUESTA','2');
		xml2:=put_campo(xml2,'API_ERROR','500');
		xml2:=put_campo(xml2,'API_DESCRIPCION_ERROR','Fonasa responde error');
		xml2:=logapp(xml2,'Fonasa no responde 200 OK');
		return xml2;
        end if;

	xml2:=logapp(xml2,'FONASA: RSP_BENCERTIF -> extApellidoPat='||apell_pat1||' -extApellidoMat='||apell_mat1||' -extNombres='||nombre1||' -extSexo='||sexo1||' -extFechaNacimi='||fecha_nac1||' -extCodEstBen='||cod_est_ben1||' -rut_acompa1='||rut_acompa1||' -nom_acompa1='||nom_acompa1);

	--Para que conteste con Campos en HEX
	xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');

	--Si No es un beneficiario certificado
	--xml2:=logapp(xml2,'cod_est_ben1='||cod_est_ben1||'- mensaje_resp1='||mensaje_resp1);
	--if (cod_est_ben1='N') or (cod_est_ben1='') or (cod_est_ben1='X') then
	if (cod_est_ben1='4e') or (cod_est_ben1='') or (cod_est_ben1='58') then
                fecha_nac1:='';
		xml2:=put_campo(xml2,'CODIGO_RESP','2');
		xml2:=put_campo(xml2,'MENSAJE_RESP','Rechazado');
        	xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);
        else 	
                --Resp OK fecha_nac viene asi 1975/01/19
		-- '/' = '2f
                fecha_nac1:=replace(fecha_nac1,'2f','');
        	xml2:=put_campo(xml2,'ERRORMSG','');
        end if;

	xml2:=put_campo(xml2,'ERRORCOD','30');
        --xml2:=put_campo(xml2,'ERRORMSG',replace(json_field(aux1,'0'),'"',''));
	xml2:=put_campo(xml2,'EXTAPELLIDOPAT',apell_pat1);
        xml2:=put_campo(xml2,'EXTAPELLIDOMAT',apell_mat1);
        xml2:=put_campo(xml2,'EXTNOMBRES',nombre1);
        xml2:=put_campo(xml2,'EXTSEXO',sexo1);
        xml2:=put_campo(xml2,'EXTFECHANACIMI',fecha_nac1);
        xml2:=put_campo(xml2,'EXTCODESTBEN',cod_est_ben1);
        xml2:=put_campo(xml2,'EXTDESCESTADO',desc_estado1);
        xml2:=put_campo(xml2,'EXTRUTCOTIZANTE',rut_cotiza1);
        xml2:=put_campo(xml2,'EXTNOMCOTIZANTE',nom_cotiza1);
        xml2:=put_campo(xml2,'EXTDIRPACIENTE',direccion1);
        xml2:=put_campo(xml2,'EXTGLOSACOMUNA',glosa_comuna1);
        xml2:=put_campo(xml2,'EXTGLOSACIUDAD',glosa_ciudad1);
        xml2:=put_campo(xml2,'EXTPREVISION',prevision1);
        xml2:=put_campo(xml2,'EXTGLOSA',glosa1);
        xml2:=put_campo(xml2,'EXTPLAN',plan1);
        xml2:=put_campo(xml2,'EXTDESCUENTOXPLANILLA',replace(dscto_planilla1,'.0',''));
        xml2:=put_campo(xml2,'EXTMONTOEXCEDENTE',replace(monto_exec1,'.0',''));
        xml2:=put_campo(xml2,'EXTRUTACOMPANANTE',rut_acompa1);
        xml2:=put_campo(xml2,'EXTNOMBREACOMPANANTE',nom_acompa1);

	--Guarda me mensaje en base
	xml2:=put_campo(xml2,'EXTMENSAJEERROR',glosa1);

        return xml2;
end;
$$
LANGUAGE plpgsql;
