CREATE OR REPLACE FUNCTION responde_http_scgi(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        respuesta1      varchar;
begiN
        xml2:=xml1;

	--Si viene RESPUESTA_HEX
        respuesta1:=get_campo('RESPUESTA_HEX',xml2);
	
	if (length(respuesta1)>0) then
		xml2:=put_campo(xml2,'RESPUESTA_HEX',encode(('Status: '||get_campo('STATUS_HTTP',xml2)||chr(10)||'Content-Type: text/xml;charset= UTF-8'||chr(10)||'Content-Length: '||(length(respuesta1)/2)::varchar||chr(10)||'Date: '||to_char(now() AT TIME ZONE 'GMT','Dy, DD Mon YYYY HH24:MI:SS GMT')||chr(10)||'Connection: close'||chr(10)||chr(10))::bytea,'hex')||respuesta1);
		xml2:=put_campo(xml2,'RESPUESTA','');

	else
	        respuesta1:=get_campo('RESPUESTA',xml2);
		xml2:=put_campo(xml2,'RESPUESTA_HEX',encode(('Status: '||get_campo('STATUS_HTTP',xml2)||chr(10)||'Content-Type: text/xml;charset= UTF-8'||chr(10)||'Content-Length: '||length(respuesta1)::varchar||chr(10)||'Date: '||to_char(now() AT TIME ZONE 'GMT','Dy, DD Mon YYYY HH24:MI:SS GMT')||chr(10)||'Connection: close'||chr(10)||chr(10)||respuesta1)::bytea,'hex'));
		xml2:=put_campo(xml2,'RESPUESTA','');
	end if;

	return xml2;
end;
$$
LANGUAGE plpgsql;
