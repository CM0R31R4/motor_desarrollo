CREATE OR REPLACE FUNCTION traductorWL_in_enrola_fonasa(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	data1	varchar;
	rqt_xml1	varchar;

	cod_fin1 	varchar;
        rut_enrola1	varchar;
        rut_benef1	varchar;

begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));
	
	cod_fin1        :=get_campo('EXTCODFINANCIADOR',xml2);
        rut_enrola1     :=get_campo('EXTRUTENROLAR',xml2);
        rut_benef1      :=get_campo('EXTRUTBENEFICIARIO',xml2);

	-- Valida formato de RUT.
        rut_enrola1:=motor_formato_rut(rut_enrola1);
        rut_benef1:=motor_formato_rut(rut_benef1);

        -- Cuando retorno de funcion sea '' retorna error al flujo y no llama a la API del financiador.
        if (rut_enrola1='') or (rut_benef1='')  then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;

        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

        --Arma el XML Request que va a FONASA.
        rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/"><soapenv:Header/><soapenv:Body><tem:wmImed_SrvCEREnrola><tem:JSON_INPUT>{"extCodFinanciador":"'||cod_fin1||'","extRutEnrolar":"'||rut_enrola1||'","extRutBeneficiario":"'||rut_benef1||'"}</tem:JSON_INPUT></tem:wmImed_SrvCEREnrola></soapenv:Body></soapenv:Envelope>';

	data1:='POST http://10.152.126.17:7001/ebonows/services/wsCEREnrolaSoap HTTP/1.1'||chr(10)||
               'Accept-Encoding: gzip,deflate'||chr(10)||
               'Content-Type: text/xml;charset=UTF-8'||chr(10)||
               'SOAPAction: "http://tempuri.org/wmImed_SrvCEREnrola"'||chr(10)||
               'User-Agent: Apache-HttpClient/4.1.1 (java 1.5)'||chr(10)||
               'Host: 10.152.126.17:7001'||chr(10)||
               'Content-Length: '||length(rqt_xml1)||chr(10)||chr(10)||rqt_xml1;	

        -- Envia la data.
        xml2:=put_campo(xml2,'SQLINPUT',data1);

	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductorWL_out_enrola_fonasa(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	rsp_xml1        varchar;

	cod_resp1	varchar;
	mensaje_resp1	varchar;
	valido1		varchar;
	nombre1		varchar;

	wmImed_SrvCEREnrolaResult	varchar;	
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

		-- Analiza respuesta de FONASA.
                IF length(rsp_xml1)=0 THEN
                        xml2:=put_campo(xml2,'ESTADO_WS','-1');
                        xml2:=logapp(xml2,'FONASA no responde');

                        RETURN xml2;
                END IF;

		--Extrae todo lo que esta en el tag.
                wmImed_SrvCEREnrolaResult:=trim(get_tag_xml('<wmImed_SrvCEREnrolaResult>',rsp_xml1));

                xml2:=logapp(xml2,'TAG ='||wmImed_SrvCEREnrolaResult);

		cod_resp1       :=encode(replace(json_field(wmImed_SrvCEREnrolaResult,'extCodError'),'"','')::bytea,'HEX');
                mensaje_resp1   :=encode(replace(json_field(wmImed_SrvCEREnrolaResult,'extMensajeError'),'"','')::bytea,'HEX');

		valido1   	:=encode(replace(json_field(wmImed_SrvCEREnrolaResult,'extValido'),'"','')::bytea,'HEX');
		nombre1   	:=encode(replace(json_field(wmImed_SrvCEREnrolaResult,'extNombreComp'),'"','')::bytea,'HEX');
        ELSE
                cod_resp1:='S';
                mensaje_resp1:=trim(get_tag_xml_hex('faultstring',rsp_xml1));
		xml2:=put_campo(xml2,'API_CODRESPUESTA','2');
                xml2:=put_campo(xml2,'API_ERROR','500');
                xml2:=put_campo(xml2,'API_DESCRIPCION_ERROR','FONASA responde error');
                xml2:=logapp(xml2,'FONASA no responde 200 OK');
                return xml2;
        end if;

	xml2:=logapp(xml2,'FONASA: RSP_ENROLA -> extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1||' -extValido1='||valido1||' -extNombre1='||nombre1);
		
	--Para que conteste con Campos en HEX
        xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');
	
        xml2:=put_campo(xml2,'ERRORCOD','30');
        xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);
	
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;

	xml2:=put_campo(xml2,'EXTVALIDO',valido1);
        xml2:=put_campo(xml2,'EXTNOMBRECOMP',nombre1);

        return xml2;
end;
$$
LANGUAGE plpgsql;