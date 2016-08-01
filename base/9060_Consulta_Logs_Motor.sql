delete from isys_querys_tx where llave='9060';

-- Entrada al flujo.
insert into isys_querys_tx values ('9060',10,1,1,'SELECT traductor_in_consulta_logs_motor_9060(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

-- Salida del flujo.
insert into isys_querys_tx values ('9060',20,1,1,'SELECT traductor_out_consulta_logs_motor_9060(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION traductor_in_consulta_logs_motor_9060(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	stData          respuestas_soap%ROWTYPE;
	stDefSec        define_secuencia_ws%ROWTYPE;
	tipo_tx1	varchar;
	
BEGIN
	xml2:=xml1;

        xml2:=logapp(xml2,' ');
        xml2:=logapp(xml2,'-- Inicio proceso Consulta Logs --');
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
	-- Recibe un XML como parametro. Ejemplo: tag_busqueda='<ws:loganulabonou> o tag_busqueda='<ws:logbencertif>'
        xml2:=busca_tx_data_xml(xml2);
	xml2:=parser_xml(xml2,get_campo('TAG_BUSQUEDA',xml2));

        -- Obtiene el tipo de transaccion.
        tipo_tx1:=get_campo('TX_WS',xml2);
	xml2:=logapp(xml2,'-- La transaccion entrante es: '||tipo_tx1);

	-- Lee datos de la respuesta.
        SELECT * INTO stData FROM respuestas_soap WHERE tipo_tx=tipo_tx1;
        IF NOT FOUND THEN
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla TX');
                xml2:=logapp(xml2,'No existe respuesta_soap, 500 Falla TX='||tipo_tx1::varchar);
                -- En caso de error, igual responde con un XML.
                xml2:=put_campo(xml2,'RESPUESTA','<?xml version="1.0" encoding="UTF-8"?><CR><SOAP-ENV:Envelope<CR> xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"<CR> xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"<CR> xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"<CR> xmlns:xsd="http://www.w3.org/2001/XMLSchema"<CR> xmlns:ns1="http://ws.imed.bono3.motor.com/"><CR><SOAP-ENV:Body><CR><ns1:genericResponse><CR><return><CR><extCodError></extCodError><CR><extMensajeError></extMensajeError><CR></return><CR></ns1:genericResponse><CR></SOAP-ENV:Body><CR></SOAP-ENV:Envelope>');
        	xml2:=put_campo(xml2,'EXTCODERROR','01');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','Chuuuucha, no existe respuesta_soap, Falla TX='||tipo_tx1::varchar);
	        -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);
 
                RETURN xml2;
        END IF;

	-- Obtiene formatos de respuestas genericas.
        xml2:=put_campo(xml2,'XML_ERROR',stData.xml_error);
        xml2:=put_campo(xml2,'XML_OK',stData.respuesta);	
      
	-- Busca funcion de INPUT y OUTPUT en tabla definse_secuencia_ws. 
	xml2:=put_campo(xml2,'TX_API',tipo_tx1);	

        SELECT * INTO stDefSec FROM define_secuencia_ws WHERE tipo_tx=get_campo('TX_API',xml2) AND financiador = '3';
        IF NOT FOUND THEN
		xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla TX');
		xml2:=logapp(xml2,'TX_API no definida en tabla define_secuencia_ws, 500 Falla TX='||tipo_tx1::varchar);
		-- En caso de error, igual responde con un XML.
		xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);
		xml2:=put_campo(xml2,'EXTCODERROR','02');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','Oh, TX_API no definida en tabla define_secuencia_ws.');
		-- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);

                RETURN xml2;
        END IF;

        -- Ejecuta funcion segun TX_API.      
        IF length(stDefSec.funcion_input) > 0 THEN
                EXECUTE 'SELECT ' || stDefSec.funcion_input || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
                xml2:=put_campo(xml2,'__SECUENCIAOK__',stDefSec.secuencia::varchar);
        END IF;

	IF length(get_campo('INPUT',xml2)) = 0 THEN
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla TX');
                xml2:=logapp(xml2,'INPUT sin datos, 500 Falla TX='||tipo_tx1::varchar);
                -- En caso de error, igual responde con un XML.
                xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);
		xml2:=put_campo(xml2,'EXTCODERROR','03');
        	xml2:=put_campo(xml2,'EXTMENSAJEERROR','¿Estas bien?, el INPUT viene sin datos');
                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);

                RETURN xml2;
        END IF;

	-- Establece secuencia.
        xml2:=put_campo(xml2,'__SECUENCIAOK__','20');

	RETURN xml2;	
END;
$$
LANGUAGE plpgsql;

-- Parsea el WS para identificar la respuesta de la transaccion.
CREATE OR REPLACE FUNCTION traductor_out_consulta_logs_motor_9060(varchar)
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

	-- Busca funcion de salida.
	--IF length(get_campo('FUNCION_OUTPUT',xml2)) > 0 THEN
        --        EXECUTE 'SELECT ' || get_campo('FUNCION_OUTPUT',xml2) || '(' || chr(39) || xml2 || chr(39) || ')' INTO xml2;
        --END IF;

	IF get_campo('EXTCODERROR',xml2) = '00' THEN
		xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=logapp(xml2,'-- Operacion OK');
                -- En caso de error, igual responde con un XML.
                --xml2:=put_campo(xml2,'RESPUESTA','<?xml version="1.0" encoding="UTF-8"?><CR><SOAP-ENV:Envelope<CR> xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"<CR> xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/"<CR> xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"<CR> xmlns:xsd="http://www.w3.org/2001/XMLSchema"<CR> xmlns:ns1="http://ws.imed.bono3.motor.com/"><CR><SOAP-ENV:Body><CR><ns1:genericResponse><CR><return><CR><extCodError></extCodError><CR><extMensajeError></extMensajeError><CR></return><CR></ns1:genericResponse><CR></SOAP-ENV:Body><CR></SOAP-ENV:Envelope>');
                -- Procesa la respuesta con los datos en el XML.
		xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);
	ELSIF get_campo('EXTCODERROR',xml2) = '04' THEN --Error 04 - Demasiados registros. Especifique su consulta.
		-- Genera respuesta SOAP OK.
		xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla TX');
		xml2:=logapp(xml2,'-- Error 04 - Demasiados registros. Especifique su consulta.');
        	xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
        	-- Procesa la respuesta con los datos en el XML.
        	xml2:=respuesta_xml(xml2);
      		xml2:=responde_http_scgi(xml2);
	ELSIF get_campo('EXTCODERROR',xml2) = '05' THEN --Error 05 - No hay registro para mostrar.
                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla TX');
		xml2:=logapp(xml2,'-- Error 05 - No hay registro para mostrar.');
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);
	ELSIF get_campo('EXTCODERROR',xml2) = '06' THEN --Error 06 - La tabla NO existe.
                -- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla TX');
		xml2:=logapp(xml2,'-- Error 06 - La tabla NO existe.');
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);
	ELSE
		xml2:=put_campo(xml2,'EXTCODERROR','-');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','Error no especificado');
		-- Genera respuesta SOAP OK.
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla TX');
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                -- Procesa la respuesta con los datos en el XML.
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);
	END IF;

	xml2:=logapp(xml2,' ');
        xml2:=logapp(xml2,'-- Fin proceso Consulta Logs --');
        xml2:=logapp(xml2,' ');

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;

