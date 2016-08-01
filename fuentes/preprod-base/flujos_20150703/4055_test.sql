delete from isys_querys_tx where llave='4055';

insert into isys_querys_tx values ('4055',10,1,1,'select proc_test_4055(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_test_4055(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	respuesta1	varchar;
begin
	xml2:=xml1;
	xml2:=logapp(xml2,'Servicio 4055');
	respuesta1:='<content="text/html; charset=UTF-8" />Prestación no está en convenio';
	--respuesta1:='<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />O<C>HIGGINS Nº 1330';
	xml2:=put_campo(xml2,'RESPUESTA','Status: 200 OK'||chr(10)||'Content-type: text/html'||chr(10)||'Content-length: '||(length(respuesta1))::varchar||chr(10)||chr(10)||respuesta1);
	return xml2;	
end;
$$
LANGUAGE plpgsql;

