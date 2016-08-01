CREATE OR REPLACE FUNCTION traductorWL_in_datosprest_fonasa(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	data1		varchar;
	rqt_xml1	varchar;

	cod_fin1 	varchar;
	rut_conv1	varchar;
	cod_sucur1	varchar;

begin
        xml2	:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        :=trim(get_campo('EXTCODFINANCIADOR',xml2));
        rut_conv1       :=get_campo('EXTRUTCONVENIO',xml2);
        cod_sucur1      :=coalesce(nullif(get_campo('EXTCODIGOSUCUR',xml2),''),'0');

	-- Valida formato del RUT
        rut_conv1:=motor_formato_rut(rut_conv1);

        -- Cuando retorno de funcion sea '', retorna error al flujo y no llama a la API del financiador.
        if (rut_conv1='')  then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;

        -- Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_conv1);

	-- Arma el XML request que va a FONASA.
        --rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/"><soapenv:Header/><soapenv:Body><tem:wmImed_SrvCERDatosPrest><tem:JSON_INPUT>{"extCodFinanciador":"'||cod_fin1||'","extRutConvenio":"'||rut_conv1||'","extCodigoSucur":"'||cod_sucur1||'"}</tem:JSON_INPUT></tem:wmImed_SrvCERDatosPrest></soapenv:Body></soapenv:Envelope>';

	rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/"><soapenv:Header/><soapenv:Body><tem:wmImed_SrvCERDatosPrest><tem:JSON_INPUT>{"extCodFinanciador":"'||cod_fin1||'","extCodigoSucur":"'||cod_sucur1||'","extRutConvenio":"'||rut_conv1||'"}</tem:JSON_INPUT></tem:wmImed_SrvCERDatosPrest></soapenv:Body></soapenv:Envelope>';

	data1:='POST http://10.152.126.17:7001/ebonows/services/wsCERDatosPrestSoap HTTP/1.1'||chr(10)||
               'Accept-Encoding: gzip,deflate'||chr(10)||
               'Content-Type: text/xml;charset=UTF-8'||chr(10)||
               'SOAPAction: "http://tempuri.org/wmImed_SrvCERDatosPrest"'||chr(10)||
               'User-Agent: Apache-HttpClient/4.1.1 (java 1.5)'||chr(10)||
               'Host: 10.152.126.17:7001'||chr(10)||
               'Content-Length: '||length(rqt_xml1)||chr(10)||chr(10)||rqt_xml1;
        
	-- Envia la data.
        xml2:=put_campo(xml2,'SQLINPUT',data1);

        RETURN xml2;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductorWL_out_datosprest_fonasa(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	rsp_xml1        varchar;
	
	est_conv1	varchar;
	nivel1		varchar;
	tipo_prest1	varchar;
	cod_espec1	varchar;
	cod_prof1	varchar;
	antiguedad1	varchar;
	cod_resp1       varchar;
        mensaje_resp1   varchar;	

	wmImed_SrvCERDatosPrestResult varchar;
begin
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

        	-- Analiza la respuesta de FONASA.
        	if length(rsp_xml1)=0 then
                	xml2:=put_campo(xml2,'ESTADO_WS','-1');
			xml2:=logapp(xml2,'FONASA no responde.');
                
			return xml2;
        	end if;		
	
		--Extrae todo lo que esta en el tag.
                wmImed_SrvCERDatosPrestResult:=trim(get_tag_xml('<wmImed_SrvCERDatosPrestResult>',rsp_xml1));

		cod_resp1       :=encode(replace(json_field(wmImed_SrvCERDatosPrestResult,'extCodError'),'"','')::bytea,'HEX');
                mensaje_resp1   :=encode(replace(json_field(wmImed_SrvCERDatosPrestResult,'extMensajeError'),'"','')::bytea,'HEX');

		est_conv1       :=encode(replace(json_field(wmImed_SrvCERDatosPrestResult,'extEstConvenio'),'"','')::bytea,'HEX');
		nivel1       	:=encode(replace(json_field(wmImed_SrvCERDatosPrestResult,'extNivel'),'"','')::bytea,'HEX');
		tipo_prest1     :=encode(replace(json_field(wmImed_SrvCERDatosPrestResult,'extTipoPrestador'),'"','')::bytea,'HEX');
		cod_espec1      :=encode(replace(json_field(wmImed_SrvCERDatosPrestResult,'extCodEspecialidades'),'"','')::bytea,'HEX');
		cod_prof1       :=encode(replace(json_field(wmImed_SrvCERDatosPrestResult,'extCodProfesiones'),'"','')::bytea,'HEX');
		antiguedad1     :=encode(replace(json_field(wmImed_SrvCERDatosPrestResult,'extAnosAntiguedad'),'"','')::bytea,'HEX');
        else
                cod_resp1:='S';
		mensaje_resp1:=trim(get_tag_xml_hex('faultstring',rsp_xml1));
		xml2:=put_campo(xml2,'API_CODRESPUESTA','2');
                xml2:=put_campo(xml2,'API_ERROR','500');
                xml2:=put_campo(xml2,'API_DESCRIPCION_ERROR','FONASA responde error');
                xml2:=logapp(xml2,'FONASA no responde 200 OK');
                return xml2;
        end if;

	xml2:=logapp(xml2,'FONASA: RSP_DATOSPREST -> extEstConvenio1='||est_conv1||' -extNivel1='||nivel1||' -extTipoPrest1='||tipo_prest1||' -extCodEspec1='||cod_espec1||' -extCodProf1='||cod_prof1||' -extAntiguedad1='||antiguedad1||' -extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1);

	--Para que conteste con campos en HEX
        xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');

        xml2:=put_campo(xml2,'ERRORCOD','30');
        xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);
	xml2:=put_campo(xml2,'EXTESTCONVENIO',est_conv1);
        xml2:=put_campo(xml2,'EXTNIVEL',nivel1);
        xml2:=put_campo(xml2,'EXTTIPOPRESTADOR',tipo_prest1);
        xml2:=put_campo(xml2,'EXTCODESPECIALIDADES',cod_espec1);
        xml2:=put_campo(xml2,'EXTCODPROFESIONES',cod_prof1);
        xml2:=put_campo(xml2,'EXTANOSANTIGUEDAD',antiguedad1);

        return xml2;
end;
$$
LANGUAGE plpgsql;

