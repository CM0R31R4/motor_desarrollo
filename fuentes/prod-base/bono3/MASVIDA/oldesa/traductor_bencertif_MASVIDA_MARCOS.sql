CREATE OR REPLACE FUNCTION bono3.traductor_in_bencertif_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        declare_params varchar;
        out_params  varchar;
        ext_cod_financiador varchar;
        ext_rut_beneficiario varchar;
        ext_fecha_actual varchar;

begin
  xml2:=xml1;
        declare_params:= 'DECLARE @extApellidoPat VARCHAR(50)
DECLARE @extApellidoMat VARCHAR(50)
DECLARE @extNombres VARCHAR(50)
DECLARE @extSexo VARCHAR(50)
DECLARE @extFechaNacimi VARCHAR(50)
DECLARE @extCodEstBen VARCHAR(50)
DECLARE @extDescEstado VARCHAR(50)
DECLARE @extRutCotizante VARCHAR(50)
DECLARE @extNomCotizante VARCHAR(50)
DECLARE @extDirPaciente VARCHAR(50)
DECLARE @extGlosaComuna VARCHAR(50)
DECLARE @extGlosaCiudad VARCHAR(50)
DECLARE @extPrevision VARCHAR(50)
DECLARE @extGlosa VARCHAR(50)
DECLARE @extPlan VARCHAR(50)
DECLARE @extDescuentoxPlanilla VARCHAR(50)
DECLARE @extMontoExcedente FLOAT

';
        out_params:='@extApellidoPat OUTPUT,@extApellidoMat OUTPUT,@extNombres OUTPUT,@extSexo OUTPUT,@extFechaNacimi OUTPUT,@extCodEstBen OUTPUT,@extDescEstado OUTPUT,@extRutCotizante OUTPUT,@extNomCotizante OUTPUT,@extDirPaciente OUTPUT,@extGlosaComuna OUTPUT,@extGlosaCiudad OUTPUT,@extPrevision OUTPUT,@extGlosa OUTPUT,@extPlan OUTPUT,@extDescuentoxPlanilla OUTPUT,@extMontoExcedente OUTPUT select  @extApellidoPat as extApellidoPat, @extApellidoMat as extApellidoMat ,@extNombres as extNombres ,@extSexo as extSexo ,@extFechaNacimi as extFechaNacimi ,@extCodEstBen as extCodEstBen ,@extDescEstado as extDescEstado,@extRutCotizante as extRutCotizante,@extNomCotizante as extNomCotizante,@extDirPaciente as extDirPaciente ,@extGlosaComuna as extGlosaComuna ,@extGlosaCiudad as extGlosaCiudad ,@extPrevision as extPrevision ,@extGlosa as extGlosa,@extPlan as extPlan,@extDescuentoxPlanilla as extDescuentoxPlanilla ,@extMontoExcedente as extMontoExcedente';
        xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
        ext_cod_financiador:=get_campo('EXTCODFINANCIADOR',xml2);
        ext_rut_beneficiario:=get_campo('EXTRUTBENEFICIARIO',xml2);
        ext_fecha_actual:=get_campo('EXTFECHAACTUAL',xml2);
        --xml2:=put_campo(xml2,'SQLINPUT',declare_params||' EXEC dbo.MASBenCertif_res '||ext_cod_financiador||', ['||ext_rut_beneficiario||'], ['||ext_fecha_actual||'], '||out_params);
        xml2:=put_campo(xml2,'SQLINPUT','select top 1 * from dbo.sysusers');

        return xml2;


end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bono3.traductor_out_bencertif_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
begin
        xml2:=xml1;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
        xml2:=put_campo(xml2,'EXTAPELLIDOPAT',get_campo('NAME',xml2));
        --xml2:=put_campo(xml2,'EXTAPELLIDOPAT',get_campo('EXTAPELLIDOPAT',xml2));

        return xml2;
end;
$$
LANGUAGE plpgsql;
