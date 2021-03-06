CREATE OR REPLACE FUNCTION bono3.traductor_in_solicfolios_banmedica(varchar)
returns varchar as
$$
declare
	extCodFinanciador int;
	extNumFolios int;
       	xml1    alias for $1;
        xml2    varchar;
begin
     	xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
        extCodFinanciador:=get_campo('EXTCODFINANCIADOR',xml2);
	extNumFolios := get_campo('EXTNUMFOLIOS',xml2);
        xml2:=put_campo(xml2,'SQLINPUT','select solicfolios('||extCodFinanciador||','||extNumFolios||')');

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_solicfolios_banmedica(varchar)
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
