delete from isys_querys_tx where llave='4006';

insert into isys_querys_tx values ('4006',10,1,1,'select proc_datos_cias_4006(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_datos_cias_4006(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	input1	varchar;
	dia1	integer;
	respuesta1	varchar;
	campo	RECORD;
	ok1	integer;
	rechazo1	integer;
	error1	integer;
	totales1	varchar;
begin
	xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	input1	:=decode(get_campo('INPUT',xml2),'hex');
	xml2:=logapp(xml2,'Datos Cias');

	respuesta1:='<H1>Configuracion de Cias de Seguros</H1>';
	respuesta1:=respuesta1||'<table border="1"><tr>';
	--Titulos	
	respuesta1:=respuesta1||'<tr><th align="center">Cia</th><th align="center">Nombre</th><th align="center">nemo</th><th align="center">Tx</th><th align="center">URL</th><th align="center">Funcion Input</th><th align="center">Funcion Output</th></tr>';
	for campo in select codigo,nombre,nemo,tx,url,funcion_respuesta,funcion_input from cias_seguros order by 3 loop
		respuesta1:=respuesta1||'<tr valign="top">';
		respuesta1:=respuesta1||'<td align="center">'||campo.codigo||'</td>';
		respuesta1:=respuesta1||'<td align="center">'||campo.nombre||'</td>';
		respuesta1:=respuesta1||'<td align="center">'||campo.nemo||'</td>';
		respuesta1:=respuesta1||'<td align="right">'||campo.tx||'</td>';
		respuesta1:=respuesta1||'<td align="center">'||campo.url||'</td>';
		respuesta1:=respuesta1||'<td align="right">'||campo.funcion_input||'</td>';
		respuesta1:=respuesta1||'<td align="right">'||campo.funcion_respuesta||'</td>';
		respuesta1:=respuesta1||'</tr>';
	end loop;
	respuesta1:=respuesta1||'</table>';

	xml2:=put_campo(xml2,'RESPUESTA','Status: 200 OK'||chr(10)||'Content-type: text/html'||chr(10)||'Content-length: '||(length(respuesta1))::varchar||chr(10)||chr(10)||respuesta1);
	return xml2;	
end;
$$
LANGUAGE plpgsql;

