--Toma data del tipo <tag>data</tag>
CREATE OR REPLACE FUNCTION get_tag_json(varchar,varchar)
returns varchar as
$$
declare
        tag1    alias for $1;
        input1  alias for $2;
        tag2    varchar;
	cont1	integer;
BEGIN
	-- Ejemplo :
	-- select split_part(split_part('extCodError:0,extMensajeError:Exitoso','extCodError:',2),',',1);

	RETURN split_part(split_part(input1,tag1,2),',',1);
END
$$
LANGUAGE plpgsql;
