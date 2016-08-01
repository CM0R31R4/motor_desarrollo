delete from isys_querys_tx where llave='4007';

insert into isys_querys_tx values ('4007',10,1,1,'select proc_monitor_cias_4007(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_monitor_cias_4007(varchar)
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
	clase1	varchar;
	tasa_rechazo1	numeric;
	tasa_aprobados1	numeric;
	tasa_timeout1	numeric;
begin
	xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	input1	:=decode(get_campo('INPUT',xml2),'hex');
	xml2:=logapp(xml2,'Monitor Cias');
	dia1:=to_char(now(),'YYYYMMDD')::integer;

	ok1:=0;
	rechazo1:=0;
	error1:=0;
	respuesta1:='<html> <head>
<style type="text/css">
.datagrid table { border-collapse: collapse; text-align: left; width: 100%; } .datagrid {font: normal 12px/150% Arial, Helvetica, sans-serif; background: #fff; overflow: hidden; border: 1px solid #36752D; -webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; }.datagrid table td, .datagrid table th { padding: 3px 10px; }.datagrid table thead th {background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #36752D), color-stop(1, #275420) );background:-moz-linear-gradient( center top, #36752D 5%, #275420 100% );filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#36752D, endColorstr=#275420);background-color:#36752D; color:#FFFFFF; font-size: 15px; font-weight: bold; border-left: 1px solid #36752D; } .datagrid table thead th:first-child { border: none; }.datagrid table tbody td { color: #275420; border-left: 1px solid #C6FFC2;font-size: 12px;font-weight: normal; }.datagrid table tbody .alt td { background: #DFFFDE; color: #275420; }.datagrid table tbody td:first-child { border-left: none; }.datagrid table tbody tr:last-child td { border-bottom: none; }.datagrid table tfoot td div { border-top: 1px solid #36752D;background: #DFFFDE;} .datagrid table tfoot td { padding: 0; font-size: 12px } .datagrid table tfoot td div{ padding: 2px; }.datagrid table tfoot td ul { margin: 0; padding:0; list-style: none; text-align: right; }.datagrid table tfoot  li { display: inline; }.datagrid table tfoot li a { text-decoration: none; display: inline-block;  padding: 2px 8px; margin: 1px;color: #FFFFFF;border: 1px solid #36752D;-webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #36752D), color-stop(1, #275420) );background:-moz-linear-gradient( center top, #36752D 5%, #275420 100% );filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#36752D, endColorstr=#275420);background-color:#36752D; }.datagrid table tfoot ul.active, .datagrid table tfoot ul a:hover { text-decoration: none;border-color: #275420; color: #FFFFFF; background: none; background-color:#36752D;}div.dhtmlx_window_active, div.dhx_modal_cover_dv { position: fixed !important; }

.verde {background: limegreen;}
.rojo {background-color:#FF5E5E; }
.amarillo {background: yellow;}
</style>
</head>';
	respuesta1:=respuesta1||'<META HTTP-EQUIV="refresh" CONTENT="300"><H1>Monitor Cias '||to_char(now(),'YYYY/MM/DD HH24:MI')||'</H1>';
	respuesta1:=respuesta1||'<div class="datagrid"><table border="1"><tr>';
	--Titulos	
	respuesta1:=respuesta1||'<thead><tr><th align="center">Cia</th><th align="center">Nombre</th><th align="center">total_ok_5_min</th><th align="center">total_rechazo_5_min</th><th align="center">total_timeout_5_min</th><th align="center">Total en Cola</th></tr></thead>';
	clase1:='';
	for campo in select a.codigo_cia,coalesce(total_ok_5_min,0)+coalesce(total_rechazo_5_min,0)+coalesce(total_timeout_5_min,0)+coalesce(total_en_cola,0) as orden,coalesce(total_ok_5_min,0) as total_ok_5_min,coalesce(total_rechazo_5_min,0) as total_rechazo_5_min,coalesce(total_timeout_5_min,0) as total_timeout_5_min,coalesce(total_en_cola,0) as total_en_cola,b.nombre from 
		(select codigo_cia,sum(total_ok_5_min) as total_ok_5_min,sum(total_rechazo_5_min) as total_rechazo_5_min,sum(total_timeout_5_min) as total_timeout_5_min ,sum(total_en_cola) as total_en_cola from control_cias where coalesce(total_ok_5_min,0)+coalesce(total_rechazo_5_min,0)+coalesce(total_timeout_5_min,0)+coalesce(total_en_cola,0)>0 and strpos(codigo_cia,'CIA_')>0 group by 1) a left join 
		(select distinct nombre,codigo from cias_seguros) b on a.codigo_cia in ('CIA_'||b.codigo) order by orden desc loop
		if ((campo.total_ok_5_min+campo.total_rechazo_5_min+campo.total_timeout_5_min)=0) then
			tasa_aprobados1:=-1;
			tasa_rechazo1:=-1;
			tasa_timeout1:=-1;
		else
			--Verificamos el colo de la linea 
			tasa_aprobados1:=campo.total_ok_5_min::numeric/(campo.total_ok_5_min+campo.total_rechazo_5_min+campo.total_timeout_5_min)::numeric;
			tasa_rechazo1:=campo.total_rechazo_5_min::numeric/(campo.total_ok_5_min+campo.total_rechazo_5_min+campo.total_timeout_5_min)::numeric;
			tasa_timeout1:=campo.total_timeout_5_min::numeric/(campo.total_ok_5_min+campo.total_rechazo_5_min+campo.total_timeout_5_min)::numeric;
		end if;
		
		if (campo.total_en_cola>50) then
			clase1:='class="rojo"';
		elsif (campo.total_en_cola>10) then 
			clase1:='class="amarillo"';
		elsif (tasa_aprobados1>=0.8) then	
			clase1:='';
		elsif (tasa_aprobados1>=0.6) then
			clase1:='class="amarillo"';
		elsif (tasa_aprobados1=-1) then
			clase1:='';
		else
			clase1:='class="rojo"';
		end if;

		xml2:=logapp(xml2,'campo='||campo||' Clase ='||clase1||'tasa_aprobados1='||coalesce(tasa_aprobados1,0)::varchar);
	
		respuesta1:=respuesta1||'<tr '||clase1||' valign="top">';
		respuesta1:=respuesta1||'<td align="center">'||coalesce(campo.codigo_cia,'')||'</td>';
		respuesta1:=respuesta1||'<td nowrap align="center">'||coalesce(campo.nombre,'')||'</td>';
		respuesta1:=respuesta1||'<td align="center">'||coalesce(campo.total_ok_5_min::varchar,'0')||'</td>';
		respuesta1:=respuesta1||'<td align="center">'||coalesce(campo.total_rechazo_5_min::varchar,'0')||'</td>';
		respuesta1:=respuesta1||'<td align="center">'||coalesce(campo.total_timeout_5_min::varchar,'0')||'</td>';
		respuesta1:=respuesta1||'<td align="center">'||coalesce(campo.total_en_cola::varchar,'0')||'</td>';
		respuesta1:=respuesta1||'</tr>';
		
	end loop;
	respuesta1:=respuesta1||'</table></div></html>';

	xml2:=put_campo(xml2,'RESPUESTA','Status: 200 OK'||chr(10)||'Content-type: text/html'||chr(10)||'Content-length: '||(length(respuesta1))::varchar||chr(10)||chr(10)||respuesta1);
	return xml2;	
end;
$$
LANGUAGE plpgsql;

