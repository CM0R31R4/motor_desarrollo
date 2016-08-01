CREATE OR REPLACE FUNCTION bono3.traductor_in_prestpaquete_banmedica(varchar)
returns varchar as
$$
declare
       	extCodFinanciador int;
	extHomNumeroConvenio varchar;
	extHomLugarConvenio varchar;
	extCodPaquete varchar;
	xml1    alias for $1;
        xml2    varchar;
begin
     	xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
	extCodFinanciador:=get_campo('EXTCODFINANCIADOR',xml2);
	extHomNumeroConvenio := get_campo('EXTHOMNUMEROCONVENIO', xml2);
	extHomLugarConvenio := get_campo('EXTHOMLUGARCONVENIO', xml2);
	extCodPaquete := get_campo('EXTCODIGOPAQUETE', xml2);
        xml2:=put_campo(xml2,'SQLINPUT','select prestpaquete('||extCodFinanciador||','||extHomNumeroConvenio||','||extHomLugarConvenio||','||extCodPaquete||')');

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_in_prestpaquete_banmedica(varchar)
returns varchar as
$$
declare
       	xml1    alias for $1;
        xml2    varchar;
begin
     	xml2:=xml1;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('NAME',xml2));

        return xml2;
end;
$$
LANGUAGE plpgsql;
