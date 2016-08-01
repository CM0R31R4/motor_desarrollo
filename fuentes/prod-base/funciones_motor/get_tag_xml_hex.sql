--Recascata data del tipo <tag>data</tag>
--drop function get_data_xml(varchar,varchar);

CREATE OR REPLACE FUNCTION get_tag_xml_hex(varchar,varchar)
returns varchar as
$$
declare
        tag1    alias for $1;
        input1  alias for $2;
	tag1_hex	varchar;
	tag2_hex	varchar;
begin
	--Arma el cerrado
        tag2_hex:=encode(('</'||tag1||'>')::bytea,'hex');
	tag1_hex:=encode(('<'||tag1||'>')::bytea,'hex');
        return split_part(split_part(input1,tag2_hex,1),tag1_hex,2);
end
$$
LANGUAGE plpgsql;
