delete from isys_querys_tx where llave='4003';

insert into isys_querys_tx values ('4003',10,1,1,'select proc_proxy_4003(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_proxy_4003(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	input1	varchar;
	respuesta1	varchar;
begin
	xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	input1	:=decode(get_campo('INPUT',xml2),'hex');
	xml2:=logapp(xml2,'Proxy');
	xml2:=logapp(xml2,replace(xml2,'###',chr(10)));
	respuesta1:='Aca hay que hacer proxy';

	xml2:=put_campo(xml2,'RESPUESTA','Status: 200 OK'||chr(10)||'Content-type: text/html'||chr(10)||'Content-length: '||(length(respuesta1))::varchar||chr(10)||chr(10)||respuesta1);
	return xml2;	
end;
$$
LANGUAGE plpgsql;

