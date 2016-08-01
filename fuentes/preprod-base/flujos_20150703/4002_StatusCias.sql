delete from isys_querys_tx where llave='4002';

insert into isys_querys_tx values ('4002',10,1,1,'select proc_status_cias_4002(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_status_cias_4002(varchar)
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
	xml2:=logapp(xml2,'Status Cias');
	dia1:=to_char(now(),'YYYYMMDD')::integer;

	ok1:=0;
	rechazo1:=0;
	error1:=0;
	respuesta1:='<H1>Tiempos Cias '||to_char(now(),'YYYY/MM/DD')||'</H1>';
	respuesta1:=respuesta1||'XXX_TOTALES_XXX';
	respuesta1:=respuesta1||'<table border="1"><tr>';
	--Titulos	
	respuesta1:=respuesta1||'<tr><th align="center">Cia</th><th align="center">Codigos</th><th align="center">Tx</th><th align="center">Total Tx</th><th align="center">Estado</th><th align="center">Tiempo Promedio</th></tr>';
	for campo in select a.nemo,a.codigos,b.tx,b.total,b.estado,b.promedio from (select nemo,string_agg(distinct codigo::varchar,',') as codigos from cias_seguros  group by 1) a left join (select count(*) as total,tx,estado,nemo,avg(tiempo_fin_cia-tiempo_ini_cia) as promedio from tx_cias where dia=dia1 and estado in ('OK','CIA_RECHAZO','CIA_ERROR','CIA_OK') group by 2,3,4) b on a.nemo=b.nemo order by 1,3 loop
		respuesta1:=respuesta1||'<tr valign="top">';
		respuesta1:=respuesta1||'<td align="center">'||campo.nemo||'</td>';
		respuesta1:=respuesta1||'<td align="center">'||campo.codigos||'</td>';
		respuesta1:=respuesta1||'<td align="center">'||coalesce(campo.tx::varchar,'')||'</td>';
		respuesta1:=respuesta1||'<td align="right">'||coalesce(campo.total::varchar,'0')||'</td>';
		respuesta1:=respuesta1||'<td align="center">'||coalesce(campo.estado::varchar,'-')||'</td>';
		respuesta1:=respuesta1||'<td align="right">'||coalesce(campo.promedio::varchar,'-')||'</td>';
		respuesta1:=respuesta1||'</tr>';
		
		--Porcentaje de Problemas
		if (campo.estado='OK') then ok1:=ok1+coalesce(campo.total,0);
		elsif (campo.estado='CIA_RECHAZO') then rechazo1:=rechazo1+coalesce(campo.total,0);
		elsif (campo.estado='CIA_ERROR') then error1:=error1++coalesce(campo.total,0);
		end if;
		
	end loop;
	respuesta1:=respuesta1||'</table>';

	totales1:='Total Tx '||(ok1+rechazo1+error1)::varchar||'<br>';
	totales1:=totales1||'Total Rechazos '||(rechazo1)::varchar||'<br>';
	totales1:=totales1||'Total Sin Respuesta '||(error1)::varchar||'<br>';
	totales1:=totales1||'Porcentaje Exito '||round((ok1::numeric/(ok1+rechazo1+error1)::numeric)*100,2)::varchar||'%<br>';
	respuesta1:=replace(respuesta1,'XXX_TOTALES_XXX',totales1);

	xml2:=put_campo(xml2,'RESPUESTA','Status: 200 OK'||chr(10)||'Content-type: text/html'||chr(10)||'Content-length: '||(length(respuesta1))::varchar||chr(10)||chr(10)||respuesta1);
	return xml2;	
end;
$$
LANGUAGE plpgsql;

