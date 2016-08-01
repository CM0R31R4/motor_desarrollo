CREATE OR REPLACE FUNCTION public.get_campo(character varying, character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1    alias for $2;
        campo_buscado1  alias for $1;
        salida  varchar;
        campo   varchar;
        i       integer;
        data1   varchar;
	xml2	varchar;
begin
        i:=1;
	
	xml2:='###'||xml1;
	campo:='###'||campo_buscado1||'[';
	data1:=split_part(xml2,campo,2);
	--raise notice 'JCC_paso1=%',data1;
	--raise notice 'JCC_paso2=%',strpos(data1,']=');
	--raise notice 'JCC_CAMPO=% DATA=%',campo_buscado1,split_part(substring(data1,strpos(data1,']=')+2,length(data1)),'###',1);
	return split_part(substring(data1,strpos(data1,']=')+2,length(data1)),'###',1);
		
        data1:=split_part(xml1,'###',i);
	--raise notice  'JCC_data1=%',data1;
        while (length(data1)>0) loop
                campo:=split_part(data1,'[',1);
		--raise notice  'JCC_campo=%',campo;
                --Si es el campo buscado devuelve la data
                if (campo_buscado1=campo) then
			--raise notice 'JCC_data=%',split_part(split_part(data1,'[',2),']=',2);
                        return split_part(split_part(data1,'[',2),']=',2);
                end if;
                --PAsamos al siguiente campo
                i:=i+1;
                data1:=split_part(xml1,'###',i);
        end loop;
        return '';
end;
$function$
