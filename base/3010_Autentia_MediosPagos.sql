delete from isys_querys_tx where llave='9050';

-- Entrada al flujo.
insert into isys_querys_tx values ('9050',10,1,1,'SELECT traductor_in_mediospagos_9050(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

-- Salida del flujo.
--insert into isys_querys_tx values ('9050',30,1,1,'SELECT traductor_out_mediospagos_3010(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

-- MULTICAJA (Consumidor WS).
--insert into isys_querys_tx values ('9050',100,1,2,'Multicaja_Ws',9050,100,201,1,1,30,30);   --Llama un servicio de tabla servicios

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
	
begin
	xml2:=xml1;

        xml2:=logapp(xml2,' ');
        xml2:=logapp(xml2,'-- Inicio proceso Multi Caja --');
        xml2:=logapp(xml2,' ');

        -- Pregunta si viene el WSDL.
        if (get_campo('REQUEST_METHOD',xml2)='GET' and (strpos(get_campo('REQUEST_URI',xml2),'wsdl')>0 or strpos(get_campo('REQUEST_URI',xml2),'xsd')>0)) then
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
		
		xml2:=logapp(xml2,'PREGUNTA SI VIENE WSDL');
                return proc_wsdl_3002(xml2);
        end if;

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
	
	-- Parsea los datos del XML entrante. Recibe un XML como parametro tag_busqueda='<ws:multicaja>'
        xml2:=busca_tx_data_xml(xml2);
        xml2:=parser_xml(xml2,get_campo('TAG_BUSQUEDA',xml2));

        -- Obtiene el tipo de transaccion.
        tipo_tx1:=get_campo('TX_WS',xml2);

	xml2:=logapp(xml2, 'TIPO TRANSACCION = '||tipo_tx1);

	-- Lee datos de la respuesta.
        SELECT * INTO stData FROM respuestas_soap WHERE tipo_tx=tipo_tx1;
        IF NOT FOUND THEN
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Tx1');
                xml2:=logapp(xml2,'No existe respuesta_soap, 500 Falla Tx='||tipo_tx1::varchar);
                -- En caso de error, igual responde con un XML.
                xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);
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
       
	IF (tipo_tx1 = 'verder') THEN
                xml2:=put_campo(xml2,'TX_API','TRX_VERIDERECHO');
                xml2:=put_campo(xml2,'VERSION','2.0');
        ELSIF (tipo_tx1 = 'fast') THEN
                xml2:=put_campo(xml2,'TX_API','TRX_VERIDERFAST');
        ELSIF (tipo_tx1 = 'venta') THEN
                xml2:=put_campo(xml2,'TX_API','TRX_VENTA');
        ELSIF (tipo_tx1 = 'anula') THEN
                xml2:=put_campo(xml2,'TX_API','TRX_ANULA');
        ELSIF (tipo_tx1 = 'reimpresion') THEN
                xml2:=put_campo(xml2,'TX_API','TRX_REIMPRESION');
        ELSE
                xml2:=put_campo(xml2,'TX_API','TRX_CNST-CNV');
        END IF;

	-- Busca funcion de INPUT y OUTPUT en tabla definse_secuencia_ws.
        SELECT * INTO stDefSec FROM define_secuencia_ws WHERE tipo_tx=get_campo('TX_API',xml2) AND financiador = '2';
        IF NOT FOUND THEN
                xml2:=put_campo(xml2,'CODIGO_RESP','2');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Error: TX_API no definida en tabla define_secuencia_ws.');
        END IF;
        
	xml2:=put_campo(xml2,'FUNCION_OUTPUT',stDefSec.funcion_output);

	-- Ejecuta funcion segun TX_API.      
        if length(stDefSec.funcion_input)>0 then
                EXECUTE 'SELECT ' || stDefSec.funcion_input || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
                xml2:=put_campo(xml2,'__SECUENCIAOK__',stDefSec.secuencia::varchar);
		xml2:=logapp(xml2,'DENTRO DE IF DE SECUENCIA...');
        end if;

	if length(get_campo('RQT_XML',xml2))=0 then
                xml2:=put_campo(xml2,'__SECUENCIAOK__','30');
        end if;

	xml2:=logapp(xml2,'SECUENCIA ='||get_campo(xml2,'__SECUENCIAOK__'));

	rqt_xml1 := get_campo('RQT_XML',xml2);

	url1 	:= 'https://200.111.44.187:8181/imed/ImedWebService';
	host1	:= '200.111.44.187:8181';

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
	xml2:=multicaja_insert_3010(xml2);

	RETURN xml2;	
END;
$$
LANGUAGE plpgsql;


--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION traductor_out_mediospagos_3010(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
	xml2   		varchar;
	stData		respuestas_soap%ROWTYPE;        
	tipo_tx1	varchar;
	respuesta1	varchar;
begin
	xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2	:=put_campo(xml2,'RQT_XML','CLEAR');
	xml2	:=put_campo(xml2,'FECHA_OUT_TX',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));
	
	tipo_tx1:=get_campo('TX_API',xml2);

	if length(get_campo('FUNCION_OUTPUT',xml2))>0 then
                EXECUTE 'SELECT ' || get_campo('FUNCION_OUTPUT',xml2) || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
        end if;

	--Responde hacia Autentia -> Length + CodMotor + XML
	if length (get_campo('RESPUESTA',xml2))>0 then
		-- respuesta1:=get_campo('CODIGO_MOTOR',xml2)||'&'||get_campo('RESPUESTA',xml2);
		respuesta1:=get_campo('RESPUESTA',xml2);
			
		xml2:=put_campo(xml2,'RESPUESTA',lpad(length(respuesta1)::varchar,4,'0') || respuesta1); 
		-- xml2:=put_campo(xml2,'RESPUESTA',respuesta1); 
	end if;

	xml2:=mediospagos_update_tx(xml2);

	return xml2;
end;
$$
LANGUAGE plpgsql;

