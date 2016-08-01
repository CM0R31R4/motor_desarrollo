CREATE OR REPLACE FUNCTION bono3.traductor_in_leerutcotiz_banmedica(varchar)
returns varchar as
$$
declare
	extCodFinanciador int;
	extRutCotizante varchar;
       	xml1    alias for $1;
        xml2    varchar;
begin
     	xml2:=xml1;
	xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
        extCodFinanciador:=get_campo('EXTCODFINANCIADOR',xml2);
	extRutCotizante:= get_campo('EXTRUTCAMPO', xml2);
        xml2:=put_campo(xml2,'SQLINPUT','select leerutcotiz('||extCodFinanciador||','||extRutCotizante||')');

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_leerutcotiz_banmedica(varchar)
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
