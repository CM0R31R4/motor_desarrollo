CREATE OR REPLACE FUNCTION traductorWL_in_solicfolios_fonasa(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
        data1   	varchar;
        rqt_xml1	varchar;

	cod_fin1 	varchar;
	num_folios1	varchar;

BEGIN
        xml2	:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1	:=get_campo('EXTCODFINANCIADOR',xml2);
        num_folios1	:=coalesce(nullif(get_campo('EXTNUMFOLIOS',xml2),''),'0');

	-- Arma el XML Request que va a FONASA.
        rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/"><soapenv:Header/><soapenv:Body><tem:wmImed_SrvCERSolicFolios><tem:JSON_INPUT>{"extCodFinanciador":"'||cod_fin1||'","extNumFolios":"'||num_folios1||'"}</tem:JSON_INPUT></tem:wmImed_SrvCERSolicFolios></soapenv:Body></soapenv:Envelope>';

        --data1:='POST http://10.100.32.214:7001/ebonows/services/wsCERSolicFoliosSoap HTTP/1.1'||chr(10)||
        data1:='POST http://10.152.126.17:7001/ebonows/services/wsCERSolicFoliosSoap HTTP/1.1'||chr(10)||  
	        'Accept-Encoding: gzip,deflate'||chr(10)||
                'Content-Type: text/xml;charset=UTF-8'||chr(10)||
                'SOAPAction: "http://tempuri.org/wmImed_SrvCERSolicFolios"'||chr(10)||
                'User-Agent: Apache-HttpClient/4.1.1 (java 1.5)'||chr(10)||
                --'Host: 10.100.32.214:7001'||chr(10)||
		'Host: 10.152.126.17:7001'||chr(10)||
                'Content-Length: '||length(rqt_xml1)||chr(10)||chr(10)||rqt_xml1;

        -- Envia la data.
        xml2:=put_campo(xml2,'SQLINPUT',data1);

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductorWL_out_solicfolios_fonasa(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	rsp_xml1	varchar;
	cod_resp1	varchar;
	mensaje_resp1	varchar;
	folios_resp1	varchar='';

	wmImed_SrvCERSolicFoliosResult	varchar;
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
                IF length(rsp_xml1)=0 THEN
                        xml2:=put_campo(xml2,'ESTADO_WS','-1');
                        xml2:=logapp(xml2,'FONASA no responde.');

                        RETURN xml2;
                END IF;

		--Extrae todo lo que esta en el tag.
                wmImed_SrvCERSolicFoliosResult:=trim(get_tag_xml('<wmImed_SrvCERSolicFoliosResult>',rsp_xml1));

		cod_resp1       :=encode(replace(json_field(wmImed_SrvCERSolicFoliosResult,'extCodError'),'"','')::bytea,'HEX');
                mensaje_resp1   :=encode(replace(json_field(wmImed_SrvCERSolicFoliosResult,'extMensajeError'),'"','')::bytea,'HEX');

		folios_resp1	:=encode(replace(replace(replace(replace(replace(replace(json_field(wmImed_SrvCERSolicFoliosResult,'lista'),'"extFoliosDevueltos": ',''),'{"',''),'"}',''),'[',''),']',''),' ','')::bytea,'HEX');
	ELSE
                cod_resp1:='S';
                mensaje_resp1:=trim(get_tag_xml_hex('faultstring',rsp_xml1));
		xml2:=put_campo(xml2,'API_CODRESPUESTA','2');
                xml2:=put_campo(xml2,'API_ERROR','500');
                xml2:=put_campo(xml2,'API_DESCRIPCION_ERROR','FONASA responde error');
                xml2:=logapp(xml2,'FONASA no responde 200 OK');
        
	        RETURN xml2;
        END IF;
	
	xml2:=logapp(xml2,'FONASA: RSP_SOLICFOLIOS -> extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1||' -extFoliosResp1='||folios_resp1);
	
	-- Para que conteste con campos en HEX
        xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');
       
	xml2:=put_campo(xml2,'ERRORCOD','30');
        xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);
	
	-- Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        IF cod_resp1='S' THEN
                xml2:=put_campo(xml2,'ERRORMSG','');
        END IF;

	-- Devuelve los campos al flujo 3003.
	xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);
	--Limpio el dato
	--'[' = '5b' // ']' = '5d' 
        xml2:=put_campo(xml2,'EXFOLIOSDEVUELTOS','5b'||folios_resp1||'5d');

       RETURN xml2;
END;
$$
LANGUAGE plpgsql;

