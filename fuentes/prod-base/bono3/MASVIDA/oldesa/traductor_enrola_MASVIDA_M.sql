CREATE OR REPLACE FUNCTION bono3.traductor_in_enrola_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        declare_params varchar;
        out_params  varchar;
        ext_cod_financiador varchar;
        ext_rut_beneficiario varchar;
        ext_rut_enrola varchar;

begin

	xml2:=xml1;
        declare_params:='DECLARE @extValido VARCHAR(2)
			 DECLARE @extNombreComp VARCHAR(50)';
	out_params :=' ,@extValido OUTPUT,@extNombreComp OUTPUT; select @extValido as extValido, @extNombreComp as extNombreComp;';

	ext_cod_financiador:=get_campo('EXTCODFINANCIADOR',xml2);
        ext_rut_enrola:=get_campo('EXTRUTENROLAR',xml2);
	ext_rut_beneficiario:=get_campo('EXTRUTBENEFICIARIO',xml2);

	xml2:=put_campo(xml2,'SQLINPUT',declare_params||' EXEC dbo.MASEnrola '||ext_cod_financiador||',['||ext_rut_enrola||'],['||ext_rut_beneficiario||'] '||out_params);

	return xml2;

end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_enrola_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
begin

	xml2:=xml1;
        return xml2;

end;
$$
LANGUAGE plpgsql;

