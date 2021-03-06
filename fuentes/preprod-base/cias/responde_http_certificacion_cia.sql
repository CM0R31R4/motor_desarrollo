--Respuesta de la certificacion de las cia de seguros
CREATE OR REPLACE FUNCTION responde_http_certificacion_cia(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        respuesta1      varchar;
begiN
        xml2:=xml1;
	
	respuesta1:=replace(get_campo('XML_RESPUESTA',xml2),'&-&DATA&-&',chr(10)||'<MsgOutput>'||chr(10)||'<extCodEstBen>'||get_campo('extCodEstBen',xml2)||'</extCodEstBen><columns>'||get_campo('columns',xml2)||'</columns>'||chr(10)||'<extCodError>'||get_campo('extCodError',xml2)||'</extCodError>'||chr(10)||'<extMensajeError>'||get_campo('extMensajeError',xml2)||'</extMensajeError>'||chr(10)||'</MsgOutput>');
        xml2:=put_campo(xml2,'RESPUESTA','Status: 200 OK'||chr(10)||'Content-type: text/html'||chr(10)||'Content-length: '||(length(respuesta1))::varchar||chr(10)||chr(10)||respuesta1);
	return xml2;
end;
$$
LANGUAGE plpgsql;
