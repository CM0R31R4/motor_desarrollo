CREATE OR REPLACE FUNCTION public.get_campo(character varying, character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1    alias for $2;
        campo_buscado1  alias for $1;
        campo1  varchar;
        xml2    varchar;
        i       integer;
        aux     varchar;
begin
	--Se llama funcion en C
	return get_campo_c(upper(campo_buscado1),xml1);

        xml2:='###'||xml1;
        campo1:=upper(campo_buscado1);
        aux:='###'||campo1||'[';
        i:=strpos(xml2,aux);
        if (i=0) then
                return '';
        else
                return split_part(split_part(substring(xml2,i+length(aux),length(xml2)+10),'###',1),']=',2);
        end if;
end;
$function$

