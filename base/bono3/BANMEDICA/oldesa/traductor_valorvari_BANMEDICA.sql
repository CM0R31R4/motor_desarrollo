CREATE OR REPLACE FUNCTION bono3.traductor_in_valorvari_banmedica(varchar)
returns varchar as
$$
declare
       	xml1    aldatosprestias for $1;
        xml2    varchar;
begin
     	xml2:=xml1;

        xml2:=put_campo(xml2,'SQLINPUT','select top 1 * from dbo.sysusers');

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_valorvari_banmedica(varchar)
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
