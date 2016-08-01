CREATE or replace FUNCTION get_xml(varchar,varchar) RETURNS varchar AS $$
DECLARE
    campo1      alias for $1;
    data1       alias for $2;
    resp1       varchar;
BEGIN
        resp1 := split_part(split_part(data1,'<'||campo1||'>',2),'</'||campo1||'>',1);
return  resp1;
END;
$$ LANGUAGE plpgsql;

