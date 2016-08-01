delete from isys_querys_tx where llave='7001';

-- Entrada al flujo
insert into isys_querys_tx values ('7001',10,1,1,'SELECT traductor_in_actoventacoladec_7001(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

-- Llamada a servicio en tabla de servicios.
insert into isys_querys_tx values ('7001',20,1,2,'BonoDec',7001,100,201,1,1,30,30); 

-- Salida del Flujo
insert into isys_querys_tx values ('7001',30,1,1,'SELECT traductor_out_actoventacoladec_7001(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

-- Llamada a API-1 de COLA para ELIMINAR en caso de exito.
insert into isys_querys_tx values ('7001',40,1,1,'SELECT acto_venta_delete_cola_tx(1,''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

-- Llamada a API-2 de COLA para ELIMINAR en caso de exito.
insert into isys_querys_tx values ('7001',50,3,1,'SELECT acto_venta_delete_cola_tx(2,''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);


--Parsea el WS para identificar la transacciones entrante.
CREATE OR REPLACE FUNCTION traductor_in_actoventacoladec_7001(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;

	rqst_xml1	varchar;
        url1            varchar;
        host1           varchar;
	header1         varchar;

	usuarioDec	varchar;
	claveDec	varchar;
	inputDec	varchar;

	data1		varchar;
begin
	xml2:=xml1;

	xml2:=logapp(xml2,' ');
	xml2:=logapp(xml2,'-- Inicio proceso XML Cola Dec --');
	xml2:=logapp(xml2,' ');
	
	-- Datos para conectar a DEC.	
	usuarioDec:='Autentia';
	claveDec:='@ut3nti4.';
	-- Solo el xml del acto de venta en base64
	inputDec:=get_campo('EXTXMLACTOVENTA',xml2);
	xml2:=logapp(xml2,'Arma XML request para enviar a DEC...');

	-- Se arma el XML Request que va a DEC.
	rqst_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:wsBonoDec"><soapenv:Header/><soapenv:Body><urn:Subida soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><wsUser xsi:type="xsd:string">'||usuarioDec||'</wsUser><wsPass xsi:type="xsd:string">'||claveDec||'</wsPass><XML xsi:type="xsd:string">'||inputDec||'</XML></urn:Subida></soapenv:Body></soapenv:Envelope>';

	url1:='http://10.100.32.179/lacuna/WebService/BonoDec/wsBonoDec.php';
	host1:='10.100.32.179';

	data1:=	'POST '||url1||' HTTP/1.1'||chr(10)||
              	'Accept-Encoding: gzip,deflate'||chr(10)||
              	'Content-Type: text/xml;charset=UTF-8'||chr(10)||
              	'SOAPAction: "urn:wsBonoDec#Subida"'||chr(10)||
                'Content-Length: '||length(rqst_xml1)||chr(10)||
		'Host: '||host1||chr(10)||
		'Connection: Keep-Alive'||chr(10)||
		'User-Agent: Apache-HttpClient/4.1.1(java 1.5)'||chr(10)||chr(10)||rqst_xml1;
		
        --Envio la data
        xml2:=put_campo(xml2,'INPUT',data1);
	xml2:=put_campo(xml2,'DATADEC',data1);

	xml2:=logapp(xml2,'Se envian datos a host : ['||host1||']');

	-- Establece secuencia.
        xml2:=put_campo(xml2,'__SECUENCIAOK__','20');

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;

-- Parsea el WS para identificar la transacciones saliente.
CREATE OR REPLACE FUNCTION traductor_out_actoventacoladec_7001(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;

	id1     	bigint;
	rqst_xml1       varchar;
	data_dec	varchar;
BEGIN
	xml2:=xml1;

	-- Obtiene el codigo motor de API-1.
        id1:=get_campo('COD_MOTOR_API_1',xml2)::bigint;

	data_dec:=get_campo('DATADEC',xml2);

	-- Obtiene respuesta del servicio.
	rqst_xml1:=get_campo('RSP_XML',xml2);
	xml2:=logapp(xml2,'Obteniendo respuesta de servicio... ');
	xml2:=logapp(xml2,'Respuesta de servicio es = ['||rqst_xml1||']');

	IF (rqst_xml1 LIKE '%EXITO%') THEN
		-- Debe quitar el registro de la cola.
		-- Establece secuencia a funcion de borrado.
		xml2:=logapp(xml2,' --> Transaccion exitosa !!!...');
	        xml2:=put_campo(xml2,'__SECUENCIAOK__','40');
	ELSIF (rqst_xml1 LIKE '%ERROR1%') THEN
                -- Error en los datos de usuario y password.
                xml2:=logapp(xml2,' --> ERROR-1 : Los datos de acceso son incorrectos. ID : ['||id1||']');

                -- Realiza update sobre la TRX entrante.
                UPDATE tx_ActoVentaXml SET reintentos=reintentos + 1, estado='ERROR1', mensaje='Datos de acceso incorrectos.', xml_input=data_dec WHERE id=id1;
	ELSIF (rqst_xml1 LIKE '%ERROR2%') THEN
                -- El XML no esta.
                xml2:=logapp(xml2,' --> ERROR-2 : Es necesario ingresar XML. ID : ['||id1||']');

                -- Realiza update sobre la TRX entrante.
                UPDATE tx_ActoVentaXml SET reintentos=reintentos + 1, estado='ERROR2', mensaje='Es necesario ingresar XML.', xml_input=data_dec WHERE id=id1;
        ELSIF (rqst_xml1 LIKE '%ERROR3%') THEN
                -- Error en la estructura del XML enviado.
                xml2:=logapp(xml2,' --> ERROR-3 : No es posible subir el documento. ID : ['||id1||']');

                -- Realiza update sobre la TRX entrante.
                UPDATE tx_ActoVentaXml SET reintentos=reintentos + 1, estado='ERROR3', mensaje='Imposible subir documento.', xml_input=data_dec WHERE id=id1;
	ELSE
		-- Error no definido.
		xml2:=logapp(xml2,' --> Error no definido !!!... ID : ['||id1||']');

		-- Realiza update sobre la TRX entrante.
                UPDATE tx_ActoVentaXml SET reintentos=reintentos + 1, estado='ERROR', mensaje='Error no definido...', xml_input=data_dec WHERE id=id1;
	END IF;

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;

