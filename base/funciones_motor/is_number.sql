CREATE OR REPLACE FUNCTION public.is_number(character varying)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
declare
        data1  alias for $1;
begin
	return data1  ~ '^[0-9]+$';
end;
$function$
