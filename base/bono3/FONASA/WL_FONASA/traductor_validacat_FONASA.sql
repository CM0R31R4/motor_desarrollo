CREATE OR REPLACE FUNCTION traductorWL_in_validacat_fonasa(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
        data1   	varchar;
        rqt_xml1	varchar;

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
	
BEGIN
        xml2	:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));
	
	cod_fin1        :=get_campo('EXTCODFINANCIADOR',xml2); 
        rut_conv1       :=get_campo('EXTRUTCONVENIO',xml2);
        rut_tratat1     :=get_campo('EXTRUTTRATANTE',xml2);
        rut_solic1      :=get_campo('EXTRUTSOLICITANTE',xml2);
        rut_benef1      :=get_campo('EXTRUTBENEFICIARIO',xml2);
        rut_cotiz1      :=get_campo('EXTRUTCOTIZANTE',xml2);
        cod_homologo1   :=coalesce(nullif(get_campo('EXTCODIGOHOMOLOGO',xml2),''),'0');
        item1           :=coalesce(nullif(get_campo('EXTITEM',xml2),''),'0');
        cod_diag1       :=coalesce(nullif(get_campo('EXTCODIGODIAGNOSTICO',xml2),''),'0');
        cod_moda1       :=coalesce(nullif(get_campo('EXTCODMODALIDAD',xml2),''),'0');
        cod_tipaten1    :=coalesce(nullif(get_campo('EXTCODTIPATENCION',xml2),''),'0');
	fecha_nac1      :=to_char(get_campo('EXTFECHANACIMIENTO',xml2)::date, 'YYYYMMDD'); --AAAAMMDD
        --fecha_nac1      :=get_campo('EXTFECHANACIMIENTO',xml2); --AAAA/MM/DD
	cod_sexo1       :=coalesce(nullif(get_campo('EXTCODSEXO',xml2),''),'0');
        fecha_inicio1   :=to_char(get_campo('EXTFECHAINICIO',xml2)::date, 'YYYYMMDD'); --AAAAMMDD
        --fecha_inicio1   :=get_campo('EXTFECHAINICIO',xml2); --AAAA/MM/DD
	fecha_termino1  :=to_char(get_campo('EXTFECHATERMINO',xml2)::date, 'YYYYMMDD'); --AAAAMMDD
	--fecha_termino1  :=get_campo('EXTFECHATERMINO',xml2); --AAAA/MM/DD
	frec_prestdia1  :=coalesce(nullif(get_campo('EXTFRECPRESTDIA',xml2),''),'0');
        lista1          :=coalesce(nullif(get_campo('EXTLISTAPRESTACA',xml2),''),'0');
        lista2          :=coalesce(nullif(get_campo('EXTLISTAPRESTACB',xml2),''),'0');
        lista3          :=coalesce(nullif(get_campo('EXTLISTAPRESTACC',xml2),''),'0');
        lista4          :=coalesce(nullif(get_campo('EXTLISTAPRESTACD',xml2),''),'0');
        lista5          :=coalesce(nullif(get_campo('EXTLISTAPRESTACE',xml2),''),'0');
        lista6          :=coalesce(nullif(get_campo('EXTLISTAPRESTACF',xml2),''),'0');
	ind_video1      :=coalesce(nullif(get_campo('EXTINDVIDEO',xml2),''),'0');
        ind_bilateral1  :=coalesce(nullif(get_campo('EXTINDBILATERAL',xml2),''),'0');
        recargo1        :=coalesce(nullif(get_campo('EXTRECARGOFUERAHORA',xml2),''),'0');
        ind_reembolso1  :=coalesce(nullif(get_campo('EXTINDREEMBOLSO',xml2),''),'0');
        ind_programa1   :=coalesce(nullif(get_campo('EXTINDPROGRAMA',xml2),''),'0');
        cod_app1        :=coalesce(nullif(get_campo('EXTCODAPLICACION',xml2),''),'0');
        cod_reg1        :=coalesce(nullif(get_campo('EXTCODREGION',xml2),''),'0');
        cod_suc1        :=coalesce(nullif(get_campo('EXTCODSUCUR',xml2),''),'0');
        tipo_prest1     :=coalesce(nullif(get_campo('EXTTIPOPRESTADOR',xml2),''),'0');
        cod_espec1      :=coalesce(nullif(get_campo('EXTCODESPECIALIDADES',xml2),''),'0');
        cod_prof1       :=coalesce(nullif(get_campo('EXTCODPROFESIONES',xml2),''),'0');
        antiguedad1     :=coalesce(nullif(get_campo('EXTANOSANTIGUEDAD',xml2),''),'0');

	-- Valida formato de RUT.
        rut_conv1      	:=motor_formato_rut(rut_conv1);
        rut_tratat1     :=motor_formato_rut(rut_tratat1);
        rut_solic1      :=motor_formato_rut(rut_solic1);
        rut_benef1      :=motor_formato_rut(rut_benef1);
        rut_cotiz1      :=motor_formato_rut(rut_cotiz1);

        -- Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador.
        IF (rut_conv1='')       OR (rut_tratat1='')     OR
           (rut_solic1='')      OR (rut_benef1='')      OR
           (rut_cotiz1='')      THEN        
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                
		RETURN xml2;
        END IF;

        -- Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

	-- Arma el XML request que va a FONASA.
        rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/"><soapenv:Header/><soapenv:Body><tem:wmImed_SrvCERValidaCat><tem:JSON_INPUT>{"extCodFinanciador":"'||cod_fin1||'","extRutConvenio":"'||rut_conv1||'","extRutTratante":"'||rut_tratat1||'","extRutSolicitante":"'||rut_solic1||'","extRutBeneficiario":"'||rut_benef1||'","extRutCotizante":"'||rut_cotiz1||'","extCodigoHomologo":"'||cod_homologo1||'","extItem":"'||item1||'","extCodigoDiagnostico":"'||cod_diag1||'","extCodModalidad":"'||cod_moda1||'","extCodTipAtencion":"'||cod_tipaten1||'","extFechaNacimiento":"'||fecha_nac1||'","extCodSexo":"'||cod_sexo1||'","extFechaInicio":"'||fecha_inicio1||'","extFechaTermino":"'||fecha_termino1||'","extFrecPrestDia":"'||frec_prestdia1||'","extListaPrestacA":"'||lista1||'","extListaPrestacB":"'||lista2||'","extListaPrestacC":"'||lista3||'","extListaPrestacD":"'||lista4||'","extListaPrestacE":"'||lista5||'","extListaPrestacF":"'||lista6||'","extIndVideo":"'||ind_video1||'","extIndBilateral":"'||ind_bilateral1||'","extRecargoFueraHora":"'||recargo1||'","extIndReembolso":"'||ind_reembolso1||'","extIndPrograma":"'||ind_programa1||'","extCodAplicacion":"'||cod_app1||'","extCodRegion":"'||cod_reg1||'","extCodSucur":"'||cod_suc1||'","extTipoPrestador":"'||tipo_prest1||'","extCodEspecialidades":"'||cod_espec1||'","extCodProfesiones":"'||cod_prof1||'","extAnosAntiguedad":"'||antiguedad1||'"}</tem:JSON_INPUT></tem:wmImed_SrvCERValidaCat></soapenv:Body></soapenv:Envelope>';

	data1:='POST http://10.152.126.17:7001/ebonows/services/wsCERValidaCatSoap HTTP/1.1'||chr(10)||
                'Accept-Encoding: gzip,deflate'||chr(10)||
                'Content-Type: text/xml;charset=UTF-8'||chr(10)||
                'SOAPAction: "http://tempuri.org/wmImed_SrvCERValidaCat"'||chr(10)||
                'User-Agent: Apache-HttpClient/4.1.1 (java 1.5)'||chr(10)||
                'Host: 10.152.126.17:7001'||chr(10)||
                'Content-Length: '||length(rqt_xml1)||chr(10)||chr(10)||rqt_xml1;	

        -- Envia la data.
        xml2:=put_campo(xml2,'SQLINPUT',data1);
	
        RETURN xml2;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductorWL_out_validacat_fonasa(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	rsp_xml1	varchar;
	cod_resp1       varchar;
        mensaje_resp1   varchar;

	wmImed_SrvCERValidaCatResult	varchar;
BEGIN
        xml2	:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

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
		wmImed_SrvCERValidaCatResult:=trim(get_tag_xml('<wmImed_SrvCERValidaCatResult>',rsp_xml1));

                xml2:=logapp(xml2,'TAG ='||wmImed_SrvCERValidaCatResult);

		cod_resp1       :=encode(replace(json_field(wmImed_SrvCERValidaCatResult,'extRespuestaCAT'),'"','')::bytea,'HEX');
                mensaje_resp1   :=encode(replace(json_field(wmImed_SrvCERValidaCatResult,'extMensajeCAT'),'"','')::bytea,'HEX');
        ELSE
                cod_resp1:='S';  
                mensaje_resp1:=trim(get_tag_xml_hex('faultstring',rsp_xml1));
		xml2:=put_campo(xml2,'API_CODRESPUESTA','2');
                xml2:=put_campo(xml2,'API_ERROR','500');
                xml2:=put_campo(xml2,'API_DESCRIPCION_ERROR','FONASA responde error');
                xml2:=logapp(xml2,'FONASA no responde 200 OK');
                
		RETURN xml2;
        END IF;

	xml2:=logapp(xml2,'FONASA: RSP_VALIDACAT -> extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1);

	--Para que conteste con Campos en HEX
        xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');
	
	xml2:=put_campo(xml2,'ERRORCOD','30');
        xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);

	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        IF cod_resp1='S' THEN
                xml2:=put_campo(xml2,'ERRORMSG','');
        END IF;

	xml2:=put_campo(xml2,'EXTRESPUESTACAT',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJECAT',mensaje_resp1);

	--Solo para que guarde el mensaje de error
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

        RETURN xml2;
END;
$$
LANGUAGE plpgsql;
