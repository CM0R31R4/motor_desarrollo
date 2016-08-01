CREATE or replace FUNCTION get_xml2(varchar,varchar) RETURNS varchar AS $$
DECLARE
    campo1      alias for $1;
    data1       alias for $2;
    resp1       varchar;
BEGIN
        resp1 := split_part(split_part(data1,'<'||campo1||'>',2),'</'||campo1||'>',1);
	--Buscamos si viene no codificado
	if (resp1='') then
		--&lt;extCodSeguro&gt
        	resp1 := split_part(split_part(data1,'&lt;'||campo1||'&gt;',2),'&lt;/'||campo1||'&gt;',1);
	end if;
return  resp1;
END;
$$ LANGUAGE plpgsql;

