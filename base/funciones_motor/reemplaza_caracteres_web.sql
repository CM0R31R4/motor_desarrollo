CREATE OR REPLACE FUNCTION public.reemplaza_caracteres_web(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
	data1	alias for $1;
	salida	varchar;
begin
	salida:=data1;
	salida:=replace(salida,chr(38),'&amp;');	--Ampersand 	(&)
	salida:=replace(salida,chr(34),'&quot;');	--Comillas	(")
	--salida:=replace(salida,chr(60),'&lt;');
	--salida:=replace(salida,chr(62),'&gt;');	
	salida:=replace(salida,chr(60),'<');
	salida:=replace(salida,chr(62),'>');		
	
	salida:=replace(salida,chr(91),'[');
	salida:=replace(salida,chr(93),']');
	return salida;
end;
$function$
