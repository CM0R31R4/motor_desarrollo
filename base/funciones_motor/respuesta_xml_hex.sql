CREATE OR REPLACE FUNCTION public.respuesta_xml_hex(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1   		alias for $1;
	xml2		varchar;
	input1		varchar;
	campo1		varchar;
	data1		varchar;
	respuesta1	varchar;
	out1		varchar;
	param_busqueda1	varchar;
	previa1		varchar;
begin
	xml2:=xml1;

	param_busqueda1:='<return>';
	
	--Reemplaza los <CR> que tienen los xml en t_bono3.respuestas_soap
	respuesta1:=replace(get_campo('RESPUESTA',xml2),'<CR>',chr(10));

	--Saco el header del xml y concatena el <return>
	out1:=encode((split_part(respuesta1,param_busqueda1,1)||param_busqueda1)::bytea,'hex');	-- De <return> corta a la Iz

	--Contiene la data del xml
	input1:=split_part(respuesta1,param_busqueda1,2);			-- De <return> corta a la De

	--Si hay data 
	while (length(input1)>0) loop
		--Saca el nombre del tag. Ej: <nombre>
		campo1:=split_part(split_part(input1,'<',2),'>',1);
		data1:='';

		--Si existe el cerrado..Ej: </nombre>
		if (strpos(input1,'</'||campo1||'>')>0) then
			--Sacamos la parte previa, que tiene la data final y la ponemos
			previa1:=split_part(input1,'<'||campo1||'>',1);
		
			--Concatenamos la respuesta	
			out1:=out1||encode((previa1||'<'||campo1||'>')::bytea,'hex');
			--Si viene un <C> se cambia por el '
			out1:=out1||replace(get_campo(upper(campo1),xml2),'<C>',chr(39));
			out1:=out1||encode(('</'||campo1||'>')::bytea,'hex');
			--Avanzamos el input1.
			input1:=split_part(input1,'</'||campo1||'>',2);

		else
			--Saca parte previa
			previa1:=split_part(input1,'<'||campo1||'>',1);
			
			--Para campos vacios, formato <nombre></nombre>
			out1:=out1||encode(previa1::bytea,'hex')||encode(('<'||campo1||'>')::bytea,'hex');
			--out1:=out1||previa1||'<'||campo1||'>'||'</'||campo1||'>';
		
			--Pasamos al siguiente campo
			--input1:=split_part(input1,'</'||campo1||'>',2);
			input1:=split_part(input1,'<'||campo1||'>',2);
			--raise notice 'JCC_2 campo1=% previa1=%',campo1,previa1;
		end if;
	end loop;
	xml2:=put_campo(xml2,'RESPUESTA','');
	xml2:=put_campo(xml2,'RESPUESTA_HEX',out1);
	xml2:=put_campo(xml2,'__XML_STD__','CLEAN');
	return xml2;
end;
$function$

