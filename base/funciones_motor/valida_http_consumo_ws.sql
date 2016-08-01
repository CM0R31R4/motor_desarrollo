--Valida si hay error HTTP, cuando motor consume un WS.

CREATE OR REPLACE FUNCTION valida_http_consumo_ws(varchar)

returns varchar as
$$
declare
        data1    alias for $1;

	body1	varchar;
	header1	varchar;
	
begin
	header1:=split_part(data1,'chr(10)||chr(10)',1);
	body1:=split_part(data1,'chr(10)||chr(10)',2);

	if strpos(header1,'200 OK')>0 then
		
	
	end if;


end
$$
LANGUAGE plpgsql;
