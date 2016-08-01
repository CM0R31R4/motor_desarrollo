--Toma data del tipo <tag>data</tag>
CREATE OR REPLACE FUNCTION get_tag_json2(varchar,varchar,varchar)
returns varchar as
$$
declare
        tag1    alias for $1;
	tag2    alias for $2;
        input1  alias for $3;
BEGIN
	-- Ejemplo :
	-- select split_part('extCodError:0,extMensajeError:Exit','extMensajeError:',2);

	--wmImed_SrvCERSolicFoliosResult

	RETURN split_part(split_part(input1,tag1,2),tag2,1);
END
$$
LANGUAGE plpgsql;
