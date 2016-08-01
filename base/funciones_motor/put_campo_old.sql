CREATE OR REPLACE FUNCTION public.put_campo(character varying, character varying, character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1    alias for $1;
        campo2  alias for $2;
        data3   alias for $3;
        campo1 varchar;
        data1 varchar;
        campo_aux  varchar;
        campo_in        varchar;
        i       integer;
        len_total       integer;
        data2   varchar;
begin
        if (campo2=null) then
                return xml1;
        end if;
        campo1:=campo2;
        data1:=coalesce(data3,'');
        campo_in:=upper(campo1);
        i:=1;
        data2:=split_part(xml1,'###',i);
        len_total:=length(xml1);

        while (length(data2)>0) loop
                campo_aux:=split_part(data2,'[',1);
                --Si es el campo buscado devuelve la data
                if (campo_in=campo_aux) then
                        return substring(xml1,1,strpos(xml1,data2)-1)||campo_in||'['||length(data1)||']='||data1||substring(xml1,strpos(xml1,data2)+length
(data2),len_total);
                end if;
                --PAsamos al siguiente campo
                i:=i+1;
                data2:=split_part(xml1,'###',i);
        end loop;

        --Lo agrego al final
        return campo_in||'['||length(data1)||']='||data1||'###'||xml1;
end;
$function$

