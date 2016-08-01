CREATE OR REPLACE FUNCTION public.limpia_caracteres_web(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
	data1	alias for $1;
	salida	varchar;
begin
	salida:=data1;
	salida:=replace(salida,chr(38),''); 	-- Ampersand (&)
	salida:=replace(salida,chr(34),'');	-- Comillas (")	
	salida:=replace(salida,'&amp;','');
	salida:=replace(salida,'&quot;','');
	salida:=replace(salida,'&lt;','');
	salida:=replace(salida,'&gt;','');
	salida:=replace(salida,'<','');
	salida:=replace(salida,'>','');		
	salida:=replace(salida,'[','');
	salida:=replace(salida,']','');

	return salida;
end;
$function$
