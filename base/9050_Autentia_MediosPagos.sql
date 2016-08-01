delete from isys_querys_tx where llave='9050';

-- Entrada al flujo.
insert into isys_querys_tx values ('9050',10,1,1,'SELECT traductor_in_mediospagos_9050(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

-- MULTICAJA (Consumidor WS).
insert into isys_querys_tx values ('9050',20,1,2,'MultiCaja_WS',9051,100,201,1,1,30,30);   --Llama un servicio de tabla servicios

-- Salida del flujo.
insert into isys_querys_tx values ('9050',30,1,1,'SELECT traductor_out_mediospagos_9050(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION traductor_in_mediospagos_9050(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	stData          respuestas_soap%ROWTYPE;

	stDefSec        define_secuencia_ws%ROWTYPE;
	cod_motor1	varchar;

	input1		varchar;	
	pc_key1		varchar;
	rut_clie1	varchar;
	nom_oper1	varchar;
	rut_oper1	varchar;
	xml_in1		varchar;
	nro_audit1	varchar;

	tipo_tx1	varchar;
	cod_lugar1	varchar;
	cod_resp1	varchar;
	msj_resp1	varchar;
	rqt_xml1	varchar;	
	header1		varchar;
	url1		varchar;
	host1		varchar;
	largo1		varchar;
	
BEGIN
	xml2:=xml1;

        xml2:=logapp(xml2,' ');
        xml2:=logapp(xml2,'-- Inicio proceso Multi Caja --');
        xml2:=logapp(xml2,' ');

        -- Pregunta si viene el WSDL.
        IF (get_campo('REQUEST_METHOD',xml2)='GET' and (strpos(get_campo('REQUEST_URI',xml2),'wsdl')>0 or strpos(get_campo('REQUEST_URI',xml2),'xsd')>0)) then
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
		
                RETURN proc_wsdl_3002(xml2);
        END IF;

        -- Validacion de documento XML.
        xml2:=valida_documento_xml(xml2);	

	-- Establece secuencia.
        xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

	-- Se guarda el INPUT original.
        xml2:=put_campo(xml2,'INPUT_ORI',get_campo('INPUT',xml2));

	-- Decodificacion del INPUT.
        xml2:=put_campo(xml2,'INPUT',decode(get_campo('INPUT',xml2),'HEX')::varchar);

	-- Limpieza del INPUT.
        xml2:=put_campo(xml2,'INPUT',replace(replace(get_campo('INPUT',xml2),'\012',''),'\011',''));
	
	-- Parsea los datos del XML entrante. 
	-- Recibe un XML como parametro. Ejemplo: tag_busqueda='<ws:verder> o tag_busqueda='<ws:venta>'
        xml2:=busca_tx_data_xml(xml2);
	xml2:=parser_xml(xml2,get_campo('TAG_BUSQUEDA',xml2));

        -- Obtiene el tipo de transaccion.
        tipo_tx1:=get_campo('TX_WS',xml2);

	-- Lee datos de la respuesta.
        SELECT * INTO stData FROM respuestas_soap WHERE tipo_tx=tipo_tx1;
        IF NOT FOUND THEN
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla TX');
                xml2:=logapp(xml2,'No existe respuesta_soap, 500 Falla TX='||tipo_tx1::varchar);
                -- En caso de error, igual responde con un XML.
                xml2:=put_campo(xml2,'RESPUESTA','<?xml version="1.0" encoding="UTF-8"?><CR><SOAP-ENV:Envelope<CR> xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"<CR> xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"<CR> xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"<CR> xmlns:xsd="http://www.w3.org/2001/XMLSchema"<CR> xmlns:ns1="http://ws.imed.bono3.motor.com/"><CR><SOAP-ENV:Body><CR><ns1:genericResponse><CR><return><CR><extCodError></extCodError><CR><extMensajeError></extMensajeError><CR></return><CR></ns1:genericResponse><CR></SOAP-ENV:Body><CR></SOAP-ENV:Envelope>');
        	xml2:=put_campo(xml2,'EXTCODERROR','1');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','No existe respuesta_soap, Falla TX='||tipo_tx1::varchar);
	        -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);
 
                RETURN xml2;
        END IF;

	-- Obtiene formatos de respuestas genericas.
        xml2:=put_campo(xml2,'XML_ERROR',stData.xml_error);
        xml2:=put_campo(xml2,'XML_OK',stData.respuesta);	

	xml2:=put_campo(xml2,'FECHA_IN_TX',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));

	-- Parsea el INPUT.
	cod_motor1:=genera_codmotor();
        xml2:=put_campo(xml2,'CODIGO_MOTOR',cod_motor1);        
	xml2:=put_campo(xml2,'PC_KEY',get_campo('PC_KEY',xml2));
	xml2:=put_campo(xml2,'COD_LUGAR',get_campo('COD_LUGAR',xml2));  

	--xml2:=put_campo(xml2,'COD_LUGAR','13001');
        --xml2:=put_campo(xml2,'PC_KEY','{7173C2A9-65BC-0B49-AE39-4236F387EACF}');

        xml2:=put_campo(xml2,'NRO_AUDITORIA',get_campo('NRO_AUDITORIA',xml2));
	xml2:=put_campo(xml2,'RUT_CLIENTE',get_campo('RUT_CLIENTE',xml2));
	xml2:=put_campo(xml2,'RUT_OPERADOR',get_campo('RUT_CAJERO',xml2));
       
	xml2:=put_campo(xml2,'TX_API',tipo_tx1);	
	-- Busca funcion de INPUT y OUTPUT en tabla definse_secuencia_ws.
        SELECT * INTO stDefSec FROM define_secuencia_ws WHERE tipo_tx=get_campo('TX_API',xml2) AND financiador = '2';
        IF NOT FOUND THEN
		xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla TX');
		xml2:=logapp(xml2,'TX_API no definida en tabla define_secuencia_ws, 500 Falla TX='||tipo_tx1::varchar);
		-- En caso de error, igual responde con un XML.
		xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);
		xml2:=put_campo(xml2,'EXTCODERROR','1');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','TX_API no definida en tabla define_secuencia_ws.');
		-- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);

                RETURN xml2;
        END IF;

        xml2:=put_campo(xml2,'FUNCION_OUTPUT',stDefSec.funcion_output);

        -- Ejecuta funcion segun TX_API.      
        IF length(stDefSec.funcion_input) > 0 THEN
                EXECUTE 'SELECT ' || stDefSec.funcion_input || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
                xml2:=put_campo(xml2,'__SECUENCIAOK__',stDefSec.secuencia::varchar);
        END IF;

	-- Obtiene XML con data entrante.
	rqt_xml1 := get_campo('RQT_XML',xml2);

	IF length(get_campo('RQT_XML',xml2)) = 0 THEN
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla TX');
                xml2:=logapp(xml2,'Campo RQT_XML sin datos, 500 Falla TX='||tipo_tx1::varchar);
                -- En caso de error, igual responde con un XML.
                xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);
		xml2:=put_campo(xml2,'EXTCODERROR','1');
        	xml2:=put_campo(xml2,'EXTMENSAJEERROR','Campo RQT_XML sin datos');
                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);

                RETURN xml2;
        END IF;

	url1 	:='https://200.111.44.187:8080/imed/ImedWebService';
	host1	:='200.111.44.187:8080';

	header1	:='POST '||url1||' HTTP/1.1'||chr(10)||
		'Accept-Encoding: gzip,deflate'||chr(10)||
		'Content-Type: text/xml;charset=UTF-8'||chr(10)||
		'SOAPAction: ""'||chr(10)||
		'Content-Length: '||length(rqt_xml1)||chr(10)||
		'Host: '||host1||chr(10)||
		'Connection: Keep-Alive'||chr(10)||
		'User-Agent: Apache-HttpClient/4.1.1 (java 1.5)'||chr(10)||
		'Authorization: Basic '|| encode('ImedWebRole:ImedWebRole','base64')||chr(10)||
		chr(10);

	xml2:=put_campo(xml2,'INPUT',header1||rqt_xml1);

	-- Llamada a funcion para insertar registro.	
	xml2:=mediospagos_registra_tx(xml2);

	-- Establece secuencia.
        xml2:=put_campo(xml2,'__SECUENCIAOK__','20');

	RETURN xml2;	
END;
$$
LANGUAGE plpgsql;


-- Parsea el WS para identificar la respuesta de la transaccion.
CREATE OR REPLACE FUNCTION traductor_out_mediospagos_9050(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
	xml2   		varchar;
	stData		respuestas_soap%ROWTYPE;        
	tipo_tx1	varchar;
	respuesta1	varchar;
BEGIN
	xml2	:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2	:=put_campo(xml2,'RQT_XML','CLEAR');
	xml2	:=put_campo(xml2,'FECHA_OUT_TX',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));

	-- Busca funcion de salida.
	IF length(get_campo('FUNCION_OUTPUT',xml2)) > 0 THEN
                EXECUTE 'SELECT ' || get_campo('FUNCION_OUTPUT',xml2) || '(' || chr(39) || xml2 || chr(39) || ')' INTO xml2;
        END IF;

	IF get_campo('RSP_CODIGO_RESPUESTA',xml2) = '2' THEN
		xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla TX');
                xml2:=logapp(xml2,'No hay respuesta de MultiCaja');
                -- En caso de error, igual responde con un XML.
                xml2:=put_campo(xml2,'RESPUESTA','<?xml version="1.0" encoding="UTF-8"?><CR><SOAP-ENV:Envelope<CR> xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"<CR> xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"<CR> xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"<CR> xmlns:xsd="http://www.w3.org/2001/XMLSchema"<CR> xmlns:ns1="http://ws.imed.bono3.motor.com/"><CR><SOAP-ENV:Body><CR><ns1:genericResponse><CR><return><CR><extCodError></extCodError><CR><extMensajeError></extMensajeError><CR></return><CR></ns1:genericResponse><CR></SOAP-ENV:Body><CR></SOAP-ENV:Envelope>');
                xml2:=put_campo(xml2,'EXTCODERROR','2');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','No hay respuesta de MultiCaja');
                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);
	ELSE
		-- Genera respuesta SOAP OK.
		xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
        	xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));
        	-- Procesa la respuesta con los datos en el XML.
        	xml2:=respuesta_xml(xml2);
      		xml2:=responde_http_scgi(xml2);
	END IF;

	-- Realiza update de estado del registro.	
	xml2:=mediospagos_update_tx(xml2);

	xml2:=logapp(xml2,' ');
        xml2:=logapp(xml2,'-- Fin proceso Multi Caja --');
        xml2:=logapp(xml2,' ');

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;

