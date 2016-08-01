CREATE OR REPLACE FUNCTION public.parser_xml(character varying,varchar)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1   alias for $1;
	parametro_busqueda1	alias for $2;
	xml2	varchar;
	input1	varchar;
	campo1	varchar;
	campo2	varchar;
	data1	varchar;
	cont1	integer;

begin
	xml2:=xml1;
	/*Ejemplo*/
	--parser_xml(xml2,'<ns1:'||tipo_tx1||'>');

	--Eliminamos los comentarios
	input1:=split_part(replace(get_campo('INPUT',xml2),'<!','COMENTARIO'),parametro_busqueda1,2);
	--raise notice 'JCC1_ParserXml input1=% - largo=%',input1,length(input1);
	
	--Si viene data
	while (length(input1)>0) loop
		--Nombre del proximo campo..<CopTran_ColInp>
		campo1:=split_part(split_part(input1,'<',2),'>',1);
		--raise notice 'JCC1_PaserXml campo1=% ',campo1;
		data1:='';
	
		--Si existe el cerrado..</CopTran_ColInp>
		if (strpos(input1,'</'||campo1||'>')>0) then
			--Saca la data
			data1:=split_part(split_part(input1,'<'||campo1||'>',2),'</'||campo1||'>',1);
			--raise notice 'JCC1_PaserXml data1=% ',data1;
			
			--Pasamos al siguiente campo
			input1:=split_part(input1,'</'||campo1||'>',2);
		
			--Pone en la bolsa, el TAG xml y su valor parseado 	
			xml2:=put_campo(xml2,campo1,data1);
			--raise notice 'JCC1_PaserXml put_campo campo1=% =data1=% ',campo1,data1;
		else
			--Pasamos al siguiente campo
			input1:=split_part(input1,'<'||campo1||'>',2);
		end if;
		--raise notice 'campo1=% data=%',campo1,data1;
	end loop;
	--Borro el INPUT
	--xml2:=put_campo(xml2,'INPUT','CLEAN');
	return xml2;
end;
$function$


