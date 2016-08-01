--Inserta el requermiento que se obtiene desde el wsdl de la cia
CREATE OR REPLACE FUNCTION sp_actualiza_req_cia(varchar,varchar,varchar,varchar)
returns varchar as
$$
declare
        data1    alias for $1;
	nemo1	alias for $2;
	codigo1	alias for $3;
	tx1	alias for $4;

	stReq	requerimientos_cia%ROWTYPE;
	data_aux	varchar;
begin
	--Cambio XML_INPUT>< por XML_INPUT>&-&DATA&-&< para reemplazarlo despues
	data_aux:=replace(data1,'XML_INPUT><','XML_INPUT>&-&DATA&-&<');

	select * into stReq from requerimientos_cia where nemo=nemo1 and tx=tx1;
	if not found then
		insert into requerimientos_cia (fecha,nemo,tx,codigo,data) values (now(),nemo1,tx1,codigo1,data_aux);
		return 'Grabado OK';
	end if;

	--La data es la misma	
	if (stReq.data=data_aux) then
		return 'La data es igual';
	end if;

	--Actualizo
	update requerimientos_cia set data=data_aux where nemo=nemo1 and tx=tx1;
	return 'Actualizado OK';
end
$$
LANGUAGE plpgsql;
