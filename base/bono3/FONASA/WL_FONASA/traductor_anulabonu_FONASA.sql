CREATE OR REPLACE FUNCTION traductorWL_in_anulabonou_fonasa(varchar)
returns varchar as
$$
declare
	xml1    	alias for $1;
	xml2    	varchar;
	data1   	varchar;
	rqt_xml1 	varchar;

	cod_fin1 	varchar;
	folio_bono1	varchar;
	id_tratam1	varchar;
	fecha_tratam1	varchar;
begin
	xml2	:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
	xml2    :=put_campo(xml2,'CODIGO_RESP','2');
	xml2    :=put_campo(xml2,'MENSAJE_RESP','');
	xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        :=trim(get_campo('EXTCODFINANCIADOR',xml2));
	folio_bono1     :=coalesce(nullif(get_campo('EXTFOLIOBONO',xml2),''),'0');
	id_tratam1      :=coalesce(nullif(get_campo('EXTINDTRATAM',xml2),''),'0');
	fecha_tratam1   :=to_char(get_campo('EXTFECTRATAM',xml2)::date, 'YYYYMMDD');
	--fecha_tratam1   :=get_campo('EXTFECTRATAM',xml2);

	-- Se arma el XML Request que va a FONASA
	rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/"><soapenv:Header/><soapenv:Body><tem:wmImed_SrvCERAnulaBonoU><tem:JSON_INPUT>{"extCodFinanciador":"'||cod_fin1||'","extFolioBono":"'||folio_bono1||'","extIndTratam":"'||id_tratam1||'","extFecTratam":"'||fecha_tratam1||'"}</tem:JSON_INPUT></tem:wmImed_SrvCERAnulaBonoU></soapenv:Body></soapenv:Envelope>';

	data1:='POST http://10.152.126.17:7001/ebonows/services/wsCERAnulaBonoUSoap HTTP/1.1'||chr(10)||
		'Accept-Encoding: gzip,deflate'||chr(10)||
		'Content-Type: text/xml;charset=UTF-8'||chr(10)||
		'SOAPAction: "http://tempuri.org/wmImed_SrvCERAnulaBonoU"'||chr(10)||
		'User-Agent: Apache-HttpClient/4.1.1 (java 1.5)'||chr(10)||
		'Host: 10.152.126.17:7001'||chr(10)||
		'Content-Length: '||length(rqt_xml1)||chr(10)||chr(10)||rqt_xml1;

	-- Envio la data.
	xml2:=put_campo(xml2,'SQLINPUT',data1);

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductorWL_out_anulabonou_fonasa(varchar)
returns varchar as
$$
declare
	xml1		alias for $1;
	xml2		varchar;
	rsp_xml1        varchar;

	cod_resp1	varchar;
	mensaje_resp1	varchar;

	wmImed_SrvCERAnulaBonoUResult	varchar;
begin
	xml2	:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
	xml2    :=put_campo(xml2,'CODIGO_RESP','1');
	xml2    :=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
	xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	IF strpos(get_campo('SQLOUTPUT',xml2),'323030204f4b')>0 THEN
		xml2:=logapp(xml2,'SQLOUTPUT CODIFICADO = '||get_campo('SQLOUTPUT',xml2));

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
		wmImed_SrvCERAnulaBonoUResult:=trim(get_tag_xml('<wmImed_SrvCERAnulaBonoUResult>',rsp_xml1));

		cod_resp1       :=encode(replace(json_field(wmImed_SrvCERAnulaBonoUResult,'extCodError'),'"','')::bytea,'HEX');
		mensaje_resp1   :=encode(replace(json_field(wmImed_SrvCERAnulaBonoUResult,'extMensajeError'),'"','')::bytea,'HEX');
	ELSE
		cod_resp1	:='S';
		mensaje_resp1	:=trim(get_tag_xml_hex('faultstring',rsp_xml1));
		xml2		:=put_campo(xml2,'API_CODRESPUESTA','2');
		xml2		:=put_campo(xml2,'API_ERROR','500');
		xml2		:=put_campo(xml2,'API_DESCRIPCION_ERROR','FONASA responde error');
		xml2		:=logapp(xml2,'FONASA no responde 200 OK');

		RETURN xml2;
	END IF;

	xml2:=logapp(xml2,'FONASA: RSP_ANULABONOU -> extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1);

	--Para que conteste con campos en HEX
	xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');

	xml2:=put_campo(xml2,'ERRORCOD','30');
	xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);

	-- Si viene "S", no pone mensaje. App Bono3 entiende que es un error
	IF cod_resp1='S' THEN
		xml2:=put_campo(xml2,'ERRORMSG','');
	END IF;

	-- Devuelve los campos al flujo.
	xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
	xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;
