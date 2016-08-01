--Recascata data del tipo <tag>data</tag>
--drop function get_data_xml(varchar,varchar);

CREATE OR REPLACE FUNCTION get_tag_xml(varchar,varchar)
returns varchar as
$$
declare
        tag1    alias for $1;
        input1  alias for $2;
        tag2    varchar;
	cont1	integer;
begin
	--get_tag_xml('<ns0:vcodigorespuestaOut>',input1)
	cont1:=0;

	--Arma el cerrado
        tag2:='</'||substring(tag1,2,200);

        return split_part(split_part(input1,tag2,1),tag1,2);
	
end
$$
LANGUAGE plpgsql;
