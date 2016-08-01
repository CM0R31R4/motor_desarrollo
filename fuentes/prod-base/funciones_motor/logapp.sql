CREATE OR REPLACE FUNCTION public.logapp(character varying, character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        data1  alias for $1;
        mensaje1        alias for $2;
        xml2    varchar;
        log1    varchar;
	aux1	varchar;
	largo1	integer;
begin
        xml2:=data1;
        log1:=get_campo('_LOG_',xml2);
	aux1:=get_campo('__IDPROC__',xml2);
	largo1:=length(aux1);
	if (largo1=1) then
		largo1:=2;
	end if;
        if (log1='') then
                xml2:=put_campo(xml2,'_LOG_',coalesce(mensaje1,'<NULL>'));
        else
                xml2:=put_campo(xml2,'_LOG_',log1||chr(10)||to_char(clock_timestamp(),'HH24MISSMS')||'*<'||lpad(aux1,largo1,'0')||'> '||coalesce(mensaje1,'<NULL>'));
        end if;
        return xml2;
end;
$function$
