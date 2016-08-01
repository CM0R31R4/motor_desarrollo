CREATE OR REPLACE FUNCTION traductorWL_in_bencertif_fonasa(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
 	data1		varchar;
	rqt_xml1 	varchar;

	cod_fin1 	varchar;
        rut_ben1	varchar;
        fecha_actual1 	varchar;
	
BEGIN
        xml2	:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        :=trim(get_campo('EXTCODFINANCIADOR',xml2));
        rut_ben1        :=get_campo('EXTRUTBENEFICIARIO',xml2);
        --fecha_actual1   :=to_char(get_campo('EXTFECHAACTUAL',xml2)::date, 'YYYY/MM/DD'); --AAAA/MM/DD
	fecha_actual1   :=get_campo('EXTFECHAACTUAL',xml2); --AAAA/MM/DD

	-- Valida formato de RUT.
        rut_ben1	:=motor_formato_rut(rut_ben1);
        --Cuando retorno de funcion sea '' retorna error al flujo y no llama a la API del financiador.
        IF (rut_ben1='')  THEN
                xml2	:=put_campo(xml2,'ERROR_RUT','SI');
                
		RETURN xml2;
        END IF;

        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_ben1);

	-- Arma el XML Request que va a FONASA.
	rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/"><soapenv:Header/><soapenv:Body><tem:wmImed_SrvCERBenCertif><tem:JSON_INPUT>{"extCodFinanciador":"'||cod_fin1||'","extRutBeneficiario":"'||rut_ben1||'","extFechaActual":"'||fecha_actual1||'"}</tem:JSON_INPUT></tem:wmImed_SrvCERBenCertif></soapenv:Body></soapenv:Envelope>';

        data1:='POST http://10.152.126.17:7001/ebonows/services/wsCERBenCertifSoap HTTP/1.1'||chr(10)||
                'Accept-Encoding: gzip,deflate'||chr(10)||
                'Content-Type: text/xml;charset=UTF-8'||chr(10)||
                'SOAPAction: "http://tempuri.org/wmImed_SrvCERBenCertif"'||chr(10)||
                'User-Agent: Apache-HttpClient/4.1.1 (java 1.5)'||chr(10)||
                'Host: 10.152.126.17:7001'||chr(10)||
                'Content-Length: '||length(rqt_xml1)||chr(10)||chr(10)||rqt_xml1;
	
	-- Envia la data.
	xml2:=put_campo(xml2,'SQLINPUT',data1);
	
	RETURN xml2;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductorWL_out_bencertif_fonasa(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
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

	wmImed_SrvCERBenCertifResult	varchar;
begin
        xml2	:=xml1;
	xml2  	:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2  	:=put_campo(xml2,'CODIGO_RESP','1');
        xml2  	:=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
        xml2  	:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));
	
	IF strpos(get_campo('SQLOUTPUT',xml2),'323030204f4b')>0 THEN
		-- Decodifica SQLOUTPUT.
                xml2:=put_campo(xml2,'SQLOUTPUT',decode(get_campo('SQLOUTPUT',xml2),'HEX')::varchar);

		xml2:=logapp(xml2,'SQLOUTPUT DECODIFICADO = '||get_campo('SQLOUTPUT',xml2));

                -- Limpia el SQLOUTPUT
		xml2:=put_campo(xml2,'SQLOUTPUT',replace(get_campo('SQLOUTPUT',xml2),'&quot;','"'));

		-- Parsea la respuesta.
		rsp_xml1:=get_campo('SQLOUTPUT',xml2);

		-- Analiza respuesta de FONASA.
		IF length(rsp_xml1)=0 THEN
			xml2:=put_campo(xml2,'ESTADO_WS','-1');
			xml2:=logapp(xml2,'FONASA no responde');
		
			RETURN xml2;
		END IF;

		--Extrae todo lo que esta en el tag.
                wmImed_SrvCERBenCertifResult:=trim(get_tag_xml('<wmImed_SrvCERBenCertifResult>',rsp_xml1));

		xml2:=logapp(xml2,'TAG ='||wmImed_SrvCERBenCertifResult);

		cod_resp1    	:=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extCodError'),'"','')::bytea,'HEX');
		mensaje_resp1   :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extMensajeError'),'"','')::bytea,'HEX');
		apell_pat1      :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extApellidoPat'),'"','')::bytea,'HEX');
		apell_mat1      :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extApellidoMat'),'"','')::bytea,'HEX');
		nombre1       	:=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extNombres'),'"','')::bytea,'HEX');
		sexo1      	:=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extSexo'),'"','')::bytea,'HEX');
		fecha_nac1      :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extFechaNacimi'),'"','')::bytea,'HEX');
		cod_est_ben1    :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extCodEstBen'),'"','')::bytea,'HEX');
		desc_estado1    :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extDescEstado'),'"','')::bytea,'HEX');
		rut_cotiza1     :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extRutCotizante'),'"','')::bytea,'HEX');
		nom_cotiza1     :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extNomCotizante'),'"','')::bytea,'HEX');
		direccion1      :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extDirPaciente'),'"','')::bytea,'HEX');
		glosa_comuna1   :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extGlosaComuna'),'"','')::bytea,'HEX');
		glosa_ciudad1   :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extGlosaCiudad'),'"','')::bytea,'HEX');
		prevision1      :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extPrevision'),'"','')::bytea,'HEX');
		glosa1       	:=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extGlosa'),'"','')::bytea,'HEX');
		plan1       	:=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extPlan'),'"','')::bytea,'HEX');
		dscto_planilla1 :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extDescuentoxPlanilla'),'"','')::bytea,'HEX');
		monto_exec1     :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extMontoExcedente'),'"','')::bytea,'HEX');
		rut_acompa1     :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extRutAcompanante'),'"','')::bytea,'HEX');
		nom_acompa1     :=encode(replace(json_field(wmImed_SrvCERBenCertifResult,'extNombreAcompanante'),'"','')::bytea,'HEX');	
	ELSE
                cod_resp1:='S';
                mensaje_resp1:=trim(get_tag_xml_hex('faultstring',rsp_xml1));
		xml2:=put_campo(xml2,'API_CODRESPUESTA','2');
		xml2:=put_campo(xml2,'API_ERROR','500');
		xml2:=put_campo(xml2,'API_DESCRIPCION_ERROR','FONASA responde error');
		xml2:=logapp(xml2,'FONASA no responde 200 OK');
		
		RETURN xml2;
        END IF;

	xml2:=logapp(xml2,'FONASA: RSP_BENCERTIF -> extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1||' -extApellPat1='||apell_pat1||' -extApellMat1='||apell_mat1||' -extNombre1='||nombre1||' -extSexo1='||sexo1||' -extFechaNac1='||fecha_nac1||' -extCodEstBen1='||cod_est_ben1||' -extDescEstado1='||desc_estado1||' -extRutCotiza1='||rut_cotiza1||' -extNomCotiza1='||nom_cotiza1||' -extDireccion1='||direccion1||' -extGlosaComuna1='||glosa_comuna1||' -extGlosaCiudad1='||glosa_ciudad1||' -extPrevision1='||prevision1||' -extGlosa1='||glosa1||' -extPlan1='||plan1||' -extDsctoPlanilla1='||dscto_planilla1||' -extMontoExec1='||monto_exec1||' -extRutAcompa1='||rut_acompa1||' -extNomAcompa1='||nom_acompa1);

	--Para que conteste con campos en HEX
	xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');

	--Si no es un beneficiario certificado
	--if (cod_est_ben1='4e') or (cod_est_ben1='') or (cod_est_ben1='58') then
	IF (cod_est_ben1='N') OR (cod_est_ben1='') OR (cod_est_ben1='X') THEN
                fecha_nac1:='';
		xml2:=put_campo(xml2,'CODIGO_RESP','2');
		xml2:=put_campo(xml2,'MENSAJE_RESP','Rechazado');
        	xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);
        ELSE 	
                --Resp OK fecha_nac viene asi 1975/01/19
		-- '/' = '2f
                fecha_nac1:=replace(fecha_nac1,'2f','');
                --fecha_nac1:=replace(fecha_nac1,'/','');
        	xml2:=put_campo(xml2,'ERRORMSG','');
        END IF;

	xml2:=put_campo(xml2,'ERRORCOD','30');
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

	-- Guarda mensaje en base de datos.
	xml2:=put_campo(xml2,'EXTMENSAJEERROR',glosa1);

        RETURN xml2;
END;
$$
LANGUAGE plpgsql;
