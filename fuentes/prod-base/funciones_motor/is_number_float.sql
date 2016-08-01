CREATE OR REPLACE FUNCTION public.is_number_float(character varying)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
        data1  alias for $1;
begin
	if strpos(data1,'.')>0 then
		return is_number(split_part(data1,'.',1)) and is_number(split_part(data1,'.',2));
	else
		return is_number(data1);
	end if;
end;
$function$
