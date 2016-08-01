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
        pos     integer;
begin
        if (data3 is null) then
                return put_campo_c(xml1,upper(campo2),'');
        elsif (campo2 is null) then
                return xml1;
        else
                return put_campo_c(xml1,upper(campo2),data3);
        end if;



        campo1:=campo2;
        data1:=coalesce(data3,'');
        campo_in:=upper(campo1);
        campo_aux:=campo_in||'[';
        len_total:=length(xml1);

        if (campo2=null) then
                return xml1;
        end if;
        --Si viene en la 1 posicion
        if substring(xml1,1,length(campo_in)+1)=campo_aux then
                --Esta en la primera posicion
                data2:=split_part(xml1,'###',2);
                pos:=strpos(xml1,'###');
                return campo_aux||length(data1)||']='||data1||substring(xml1,pos,len_total);
        end if;
        --Si viene en el medio
        campo_aux:='###'||campo_in||'[';
        pos:= strpos(xml1,campo_aux);
        if pos>0 then

                data2:=split_part(substring(xml1,pos,len_total),'###',2);
                --raise notice 'pos=%',pos;
                --raise notice 'data2=%',data2;
                --raise notice 'substring(xml1,pos+length(data2)+3,len_total)=%',substring(xml1,pos+length(data2)+3,le n_total);
                --raise notice 'campo_in=%',campo_in;
                --raise notice 'data1=%',data1;
                --raise notice 'substring(xml1,1,pos-1)=%',substring(xml1,1,pos-1);
                return substring(xml1,1,pos-1)||'###'||campo_in||'['||length(data1)||']='||data1||substring(xml1,pos+length(data2)+3,len_total);
        end if;

        --Si no esta en xml1 lo agrego al principio
        return campo_in||'['||length(data1)||']='||data1||'###'||xml1;
end;
$function$

