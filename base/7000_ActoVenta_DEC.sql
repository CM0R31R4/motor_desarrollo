delete from isys_querys_tx where llave='7000';

-- Entrada al flujo
insert into isys_querys_tx values ('7000',10,1,1,'SELECT traductor_in_actoventadec_7000(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

-- Llamada a API-1
insert into isys_querys_tx values ('7000',20,1,1,'SELECT acto_venta_insert_tx(1,''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,30,40);

-- Llamada a API-2
insert into isys_querys_tx values ('7000',30,3,1,'SELECT acto_venta_insert_tx(2,''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,40,40);

-- Revisa estado de transacciones.
insert into isys_querys_tx values ('7000',40,1,1,'SELECT revisa_estado_trx_7000(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,60,60);

-- Borra TRX.
insert into isys_querys_tx values ('7000',50,1,1,'SELECT borra_trx_7000(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,60,60);

-- Salida del Flujo
insert into isys_querys_tx values ('7000',60,1,1,'SELECT traductor_out_actoventadec_7000(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

-- Llamada a API-1 para ELIMINAR en caso de error.
insert into isys_querys_tx values ('7000',70,1,1,'SELECT acto_venta_delete_tx(1,''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

-- Llamada a API-2 para ELIMINAR en caso de error.
insert into isys_querys_tx values ('7000',80,3,1,'SELECT acto_venta_delete_tx(2,''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

-- Envia a flujo 7001.
insert into isys_querys_tx values ('7000',90,1,1,'SELECT acto_venta_cola_tx(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);


--Parsea el WS para identificar la transacciones entrante.
CREATE OR REPLACE FUNCTION traductor_in_actoventadec_7000(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
	stData          respuestas_soap%ROWTYPE;
        tipo_tx1        varchar;
	
begin
	xml2:=xml1;

	xml2:=logapp(xml2,' ');
	xml2:=logapp(xml2,'-- Inicio proceso Graba XML Dec --');
	xml2:=logapp(xml2,' ');

	-- Pregunta si viene el WSDL.
        if (get_campo('REQUEST_METHOD',xml2)='GET' and (strpos(get_campo('REQUEST_URI',xml2),'wsdl')>0 or strpos(get_campo('REQUEST_URI',xml2),'xsd')>0)) then
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
                
		return proc_wsdl_3002(xml2);
        end if;
	
	-- Validacion de documento XML.
        xml2:=valida_documento_xml(xml2);
	
	-- Establece secuencia.
        xml2:=put_campo(xml2,'__SECUENCIAOK__','20');
        
	-- Se guarda el INPUT original.
        --xml2:=put_campo(xml2,'INPUT_ORI',get_campo('INPUT',xml2));

	-- Decodificacion del INPUT.
        xml2:=put_campo(xml2,'INPUT',decode(get_campo('INPUT',xml2),'HEX')::varchar);

	-- Muestra en log el contenido del campo INPUT.
	--xml2:=logapp(xml2,'INPUT : '||get_campo('INPUT',xml2));
	--xml2:=logapp(xml2,'INPUT : '||decode(get_campo('INPUT',xml2),'HEX')::varchar);
	
	-- Limpieza del INPUT.
        xml2:=put_campo(xml2,'INPUT',replace(replace(get_campo('INPUT',xml2),'\012',''),'\011',''));

        -- Parsea los datos del XML entrante. Recibe un XML como parametro tag_busqueda='<ws:grabaxmldec>'
	xml2:=busca_tx_data_xml(xml2);
        xml2:=parser_xml(xml2,get_campo('TAG_BUSQUEDA',xml2));
	
	-- Obtiene el tipo de transaccion.
	tipo_tx1:=get_campo('TX_WS',xml2);

	--Lee Datos de la respuesta
        SELECT * INTO stData FROM respuestas_soap WHERE tipo_tx=tipo_tx1;
        IF NOT FOUND THEN
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Tx1');
                xml2:=logapp(xml2,'No existe respuesta_soap, 500 Falla Tx='||tipo_tx1::varchar);
                --En caso de error, igual respondo con un XML
                xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);
                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);
               
		RETURN xml2;
        END IF;

	-- Obtiene formatos de respuestas genericas.
        xml2:=put_campo(xml2,'XML_ERROR',stData.xml_error);
        xml2:=put_campo(xml2,'XML_OK',stData.respuesta);

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;

-- Revisa el estado de las transacciones.
CREATE OR REPLACE FUNCTION revisa_estado_trx_7000(varchar)
returns varchar AS
$$
DECLARE
	xml1            alias for $1;
        xml2            varchar;

	result_api1     varchar;
        result_api2     varchar;
        cod_motor_api1  varchar;
        cod_motor_api2  varchar;
BEGIN
	xml2:=xml1;
	
	-- Validacion respuesta de APIs.
        result_api1:=get_campo('RESULTADO_INSERT_API_1',xml2);
        cod_motor_api1:=get_campo('COD_MOTOR_API_1',xml2);
        result_api2:=get_campo('RESULTADO_INSERT_API_2',xml2);
        cod_motor_api2:=get_campo('COD_MOTOR_API_2',xml2);

	xml2:=logapp(xml2,'Entrando a funcion para revisar estado de TRX.');

        IF ((result_api1 LIKE 'OK%') AND (result_api2 LIKE 'OK%')) THEN
                xml2:=logapp(xml2,'INSERT API 1: TERMINADO_OK - '||cod_motor_api1);
                xml2:=logapp(xml2,'INSERT API 2: TERMINADO_OK - '||cod_motor_api2);

		-- Marca salida de mensaje exitoso.
                xml2:=put_campo(xml2,'extCodError','0');
                xml2:=put_campo(xml2,'extMensajeError','OK');		
        ELSE
                -- Valida API-1.
                IF (result_api1 LIKE 'OK%') THEN
                        xml2:=logapp(xml2,'INSERT API 1: TERMINADO_OK - '||cod_motor_api1);
                ELSE
                        xml2:=logapp(xml2,'INSERT API 1: ERROR INSERT - '||cod_motor_api1);
                END IF;

                -- Valida API-2.
                IF (result_api2 LIKE 'OK%') THEN
                        xml2:=logapp(xml2,'INSERT API 2: TERMINADO_OK - '||cod_motor_api2);
                ELSE
                        xml2:=logapp(xml2,'INSERT API 2: ERROR INSERT - '||cod_motor_api2);
                END IF;

		-- Marca salida de mensaje erroneo.
                xml2:=put_campo(xml2,'extCodError','1');
                xml2:=put_campo(xml2,'extMensajeError','ERROR');
        END IF;

	-- Establece secuencia a funcion de borrado.
	xml2:=put_campo(xml2,'__SECUENCIAOK__','50');

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;

-- Revisa si se debe eliminar alguna TRX.
CREATE OR REPLACE FUNCTION borra_trx_7000(varchar)
returns varchar AS
$$
DECLARE
	xml1            alias for $1;
        xml2            varchar;

	result_api1     varchar;
        result_api2     varchar;
BEGIN
	xml2:=xml1;

	result_api1:=get_campo('RESULTADO_INSERT_API_1',xml2);
        result_api2:=get_campo('RESULTADO_INSERT_API_2',xml2);

	xml2:=logapp(xml2,'Resultado API-1 :'||result_api1);
	xml2:=logapp(xml2,'Resultado API-2 :'||result_api2);
	
	IF ((result_api1 LIKE 'ERROR%') AND (result_api2 LIKE 'ERROR%')) THEN
		xml2:=put_campo(xml2,'__SECUENCIAOK__','60');
	ELSIF (result_api1 LIKE 'ERROR%') THEN
		xml2:=put_campo(xml2,'__SECUENCIAOK__','80');
	ELSIF (result_api2 LIKE 'ERROR%') THEN
		xml2:=put_campo(xml2,'__SECUENCIAOK__','70');
	ELSIF (result_api1 = '') THEN
                xml2:=put_campo(xml2,'__SECUENCIAOK__','80');
	ELSIF (result_api2 = '') THEN
                xml2:=put_campo(xml2,'__SECUENCIAOK__','70');
	ELSE
		xml2:=put_campo(xml2,'__SECUENCIAOK__','60');
	END IF;

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;

-- Parsea el WS para identificar la transaccion saliente.
CREATE OR REPLACE FUNCTION traductor_out_actoventadec_7000(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
BEGIN
	xml2:=xml1;
	
	IF (get_campo('extCodError',xml2) = '1') THEN
		-- Genera Respuesta SOAP ERROR.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));

                -- Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','500 falla TRX');
                xml2:=responde_http_scgi(xml2);
	ELSE
		-- Genera Respuesta SOAP OK.
        	xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));

        	-- Proceso la respuesta con los datos en el XML
        	xml2:=respuesta_xml(xml2);
        	xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
        	xml2:=responde_http_scgi(xml2);

		-- Envia a flujo 7001.
		xml2:=logapp(xml2,'Enviando a flujo 7001...');
                xml2:=put_campo(xml2,'__SECUENCIAOK__','90');
	END IF;
	
	RETURN xml2;
end;
$$
LANGUAGE plpgsql;

-- Envia a flujo 7001.
CREATE OR REPLACE FUNCTION acto_venta_cola_tx(varchar)
returns varchar as
$$
declare
	xml1   	alias for $1;
        xml2    varchar;

	id1     bigint;

BEGIN
	xml2	:=xml1;

	-- Obtiene el codigo motor de API-1.
	id1  	:=get_campo('COD_MOTOR_API_1',xml2)::bigint;
	
	-- Cambia a flujo 7001.
	xml2    :=logapp(xml2,' ');
	xml2	:=logapp(xml2,'Realiza UPDATE para cambio a flujo 7001 : '||id1||' ');
       
	xml2	:=put_campo(xml2,'TX','7001');
		
	-- Realiza update sobre la TRX entrante.
	UPDATE tx_ActoVentaXml SET xml = xml2 WHERE id = id1;

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;
