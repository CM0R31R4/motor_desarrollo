delete from isys_querys_tx where llave='3002';

insert into isys_querys_tx values ('3002',10,1,1,'select proc_wsdl_3002(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_wsdl_3002(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
	stWsdl		respuestas_soap%ROWTYPE;
        xml2    	varchar;
	tipo_tx1	varchar;
	input1		varchar;
	file_wsdl1	varchar;
	file_xsd1	varchar;
	host1		varchar;
	port1		varchar;
	pos1		integer;
begin
	xml2:=xml1;
	file_wsdl1:=' ';
	file_xsd1:=' ';
	
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	--input1	:=lower(get_campo('INPUT',xml2));
	input1	:= lower(get_campo('REQUEST_URI',xml2));
	--GET /WSIMedBono/services/BENCERTIFPort?wsdl HTTP/1.1
	--schemaLocation="http://10.100.32.177:8080/WSIMedBono/services/BENCERTIFPort?xsd=bencertif_schema1.xsd"
	--Sacamos host y puerto para contestar wsdl con el location correspondiente a la entrada
	--host1:=split_part(split_part(input1,'host: ',2),chr(10),1);
	host1:=get_campo('HTTP_HOST',xml2);
        xml2:=logapp(xml2,'Host ='||host1);	
	--pos1:=strpos(input1,'Host: ');
	--port1:=split_part(substring(input1,pos1,length(input1)),':',2);

	--Buscamos el archivo wsdl que se guarda en show data_directory
	select * into stWsdl from respuestas_soap where strpos(input1,tipo_tx)>0;
	if not found then
		xml2:=put_campo(xml2,'STATUS_HTTP','400 Wsdl no encontrado');
		xml2:=logapp(xml2,'400 Wsdl no encontrado');
		xml2:=responde_http_get_3002(xml2);
		return xml2;
	end if;

	--Dependiendo de si es el xsd o wsdl contestamos lo que corresponde
	if strpos(input1,'wsdl')>0 then
		--Leo el archivo WSDL
		SELECT pg_read_file('wsdl/'||stWsdl.file_wsdl) into file_wsdl1;
		if length(file_wsdl1)>0 then 
			--Reemplazo LOCATION por host1:(10.100.32.177:8071) | (10.100.32.177:8099)
			file_wsdl1:=replace(file_wsdl1,chr(36)||chr(36)||'LOCATION'||chr(36)||chr(36),host1);
			xml2:= put_campo(xml2,'RESPUESTA',file_wsdl1);
			xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
			xml2:=logapp(xml2,'Responde WSDL');
		else 
			xml2:=put_campo(xml2,'STATUS_HTTP','400 Wsdl no encontrado en directorio');
		end if;
	elsif strpos(input1,'xsd')>0 then
		--Leo el archivo XSD
		SELECT pg_read_file('wsdl/'||stWsdl.file_xsd) into file_xsd1;
		if length(file_xsd1)>0 then 
			xml2:=put_campo(xml2,'RESPUESTA',file_xsd1);
			xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
			xml2:=logapp(xml2,'Responde XSD');
		else 
			xml2:=put_campo(xml2,'STATUS_HTTP','400 Schema no encontrado en directorio');
		end if;
	else
			xml2:=put_campo(xml2,'STATUS_HTTP','400 Url no especificada');
	end if;
	--Respuesta
	xml2:=responde_http_get_3002(xml2);
	return xml2;	
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION responde_http_get_3002(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        respuesta1      varchar;
begiN
        xml2:=xml1;
        respuesta1:=get_campo('RESPUESTA',xml2);
        --respuesta1:=reemplaza_caracteres_web(respuesta1);
        xml2:=put_campo(xml2,'RESPUESTA_HEX',encode(('Status: '||get_campo('STATUS_HTTP',xml2)||chr(10)||'Content-Type: text/xml'||chr(10)||'Content-Length: '||length(respuesta1)::varchar||chr(10)||'Date: '||to_char(now() AT TIME ZONE 'GMT','Dy, DD Mon YYYY HH24:MI:SS GMT')||chr(10)||chr(10)||respuesta1)::bytea,'hex'));
        xml2:=put_campo(xml2,'RESPUESTA','');
        return xml2;
end;
$$
LANGUAGE plpgsql;

