CREATE OR REPLACE FUNCTION bono3.traductor_in_infenrola_banmedica(varchar)
returns varchar as
$$
declare
	extCodFinanciador int;
	extRutBeneficiario varchar;
	extRutAcompanante varchar;
	extIndEnrola int;

       	xml1    aldatosprestias for $1;
        xml2    varchar;
begin
     	xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
	extCodFinanciador := get_campo('EXTCODFINANCIADOR',xml2);
	extRutBeneficiario := get_campo('EXTRUTBENEFICIARIO', xml2);
	extRutAcompanante := get_campo('EXTRUTACOMPANANTE', xml2);
	extIndEnrola := get_campo('EXTINDENROLA', xml2);
        xml2:=put_campo(xml2,'SQLINPUT','select infenrola('||extCodFinanciador||','||extRutBeneficiario||','||extRutAcompanante||','||extIndEnrola||')');

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_infenrola_banmedica(varchar)
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
