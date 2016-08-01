CREATE OR REPLACE FUNCTION bono3.traductor_in_bencertif_masvida(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        declare_params varchar;
        out_params  varchar;
        exec_cmd  varchar;
        exec_end  varchar;
        ext_cod_financiador varchar;
        ext_rut_beneficiario varchar;
        ext_fecha_actual varchar;

begin
  xml2:=xml1;

        xml2:=put_campo(xml2,'__SECUENCIAOK__','0'); 
        ext_cod_financiador:=get_campo('EXTCODFINANCIADOR',xml2); 
        ext_rut_beneficiario:=get_campo('EXTRUTBENEFICIARIO',xml2); 
        ext_fecha_actual:=get_campo('EXTFECHAACTUAL',xml2); 

  declare_params:= '
	DECLARE @extCodFinanciador numeric (5); 
	DECLARE @extRutBeneficiario char (12); 
	DECLARE @extFechaActual datetime ; 
	DECLARE @extApellidoPat char (30); 
	DECLARE @extApellidoMat char (30); 
	DECLARE @extNombres char (40); 
	DECLARE @extSexo char (1); 
	DECLARE @extFechaNacimi char (8); 
	DECLARE @extCodEstBen char (1); 
	DECLARE @extDescEstado char (15); 
	DECLARE @extRutCotizante char (12); 
	DECLARE @extNomCotizante char (40); 
	DECLARE @extDirPaciente char (40); 
	DECLARE @extGlosaComuna char (30); 
	DECLARE @extGlosaCiudad char (30); 
	DECLARE @extPrevision char (1); 
	DECLARE @extGlosa char (40); 
	DECLARE @extPlan char (15); 
	DECLARE @extDescuentoxPlanilla char (1); 
	DECLARE @extMontoExcedente numeric (9); 
 
	DECLARE @extRutAcompanante char (12); 
	DECLARE @extNombreAcompanante char (40); 
        DECLARE @rutAcom VARCHAR(8000);
        DECLARE @nomAcom VARCHAR(8000);

 
	CREATE TABLE #Result( 
		extRutAcompanante char (12), 
		extNombreAcompanante char (40))';

	
  exec_cmd:= ' INSERT INTO #Result EXEC  dbo.MASBenCertif '||ext_cod_financiador||',['||ext_rut_beneficiario||'] ,['||ext_fecha_actual||'], @extApellidoPat OUTPUT,@extApellidoMat OUTPUT,@extNombres OUTPUT, @extSexo OUTPUT,@extFechaNacimi OUTPUT,@extCodEstBen OUTPUT,@extDescEstado OUTPUT,@extRutCotizante OUTPUT, @extNomCotizante OUTPUT,@extDirPaciente OUTPUT,@extGlosaComuna OUTPUT,@extGlosaCiudad OUTPUT, @extPrevision OUTPUT,@extGlosa OUTPUT,@extPlan OUTPUT,@extDescuentoxPlanilla OUTPUT,@extMontoExcedente OUTPUT; 
		
		select @rutAcom = COALESCE(@rutAcom + ",","") + res.extRutAcompanante, @nomAcom = COALESCE(@nomAcom + ",","")+ res.extNombreAcompanante from #Result res;';

  out_params:='select  @extApellidoPat as extApellidoPat, @extApellidoMat as extApellidoMat ,@extNombres as extNombres , @extSexo as extSexo ,@extFechaNacimi as extFechaNacimi ,@extCodEstBen as extCodEstBen , @extDescEstado as extDescEstado,@extRutCotizante as extRutCotizante, @extNomCotizante as extNomCotizante,@extDirPaciente as extDirPaciente , @extGlosaComuna as extGlosaComuna ,@extGlosaCiudad as extGlosaCiudad , @extPrevision as extPrevision ,@extGlosa as extGlosa,@extPlan as extPlan, @extDescuentoxPlanilla as extDescuentoxPlanilla ,@extMontoExcedente as extMontoExcedente, @rutAcom as extRutAcompanante, @nomAcom as extNombreAcompanante; ';

  exec_end:='Drop Table #Result; ';

        
        xml2:=put_campo(xml2,'SQLINPUT',declare_params||exec_cmd||out_params||exec_end);
        --xml2:=put_campo(xml2,'SQLINPUT','select top 1 * from dbo.sysusers');

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
        ape     varchar;
begin
        xml2:=xml1;

        xml2:=put_campo(xml2,'ERRORCOD','0');
        xml2:=put_campo(xml2,'ERRORMSG',get_campo('STATUS',xml2));
       -- ape:=rtrim(get_campo('EXTAPELLIDOPAT',xml2),' ');
        xml2:=put_campo(xml2,'EXTAPELLIDOPAT',rtrim(get_campo('EXTAPELLIDOPAT',xml2),' '));
        xml2:=put_campo(xml2,'EXTAPELLIDOMAT',rtrim(get_campo('EXTAPELLIDOMAT',xml2),' '));
        xml2:=put_campo(xml2,'EXTNOMBRES',rtrim(get_campo('EXTNOMBRES',xml2),' '));
        xml2:=put_campo(xml2,'EXTSEXO',rtrim(get_campo('EXTSEXO',xml2),' '));
        xml2:=put_campo(xml2,'EXTFECHANACIMI',rtrim(get_campo('EXTFECHANACIMI',xml2),' '));
        xml2:=put_campo(xml2,'EXTCODESTBEN',rtrim(get_campo('EXTCODESTBEN',xml2),' '));
        xml2:=put_campo(xml2,'EXTDESCESTADO',rtrim(get_campo('EXTDESCESTADO',xml2),' '));
        xml2:=put_campo(xml2,'EXTRUTCOTIZANTE',rtrim(get_campo('EXTRUTCOTIZANTE',xml2),' '));
        xml2:=put_campo(xml2,'EXTNOMCOTIZANTE',rtrim(get_campo('EXTNOMCOTIZANTE',xml2),' '));
        xml2:=put_campo(xml2,'EXTDIRPACIENTE',rtrim(get_campo('EXTDIRPACIENTE',xml2),' '));
        xml2:=put_campo(xml2,'EXTPREVISION',rtrim(get_campo('EXTPREVISION',xml2),' '));
        xml2:=put_campo(xml2,'EXTGLOSA',rtrim(get_campo('EXTGLOSA',xml2),' '));
        xml2:=put_campo(xml2,'EXTGLOSACOMUNA',rtrim(get_campo('EXTGLOSACOMUNA',xml2),' '));
        xml2:=put_campo(xml2,'EXTGLOSACIUDAD',rtrim(get_campo('EXTGLOSACIUDAD',xml2),' '));
        xml2:=put_campo(xml2,'EXTPLAN',rtrim(get_campo('EXTPLAN',xml2),' '));
        xml2:=put_campo(xml2,'EXTDESCUENTOXPLANILLA',rtrim(get_campo('EXTDESCUENTOXPLANILLA',xml2),' '));
        xml2:=put_campo(xml2,'EXTRUTACOMPANANTE',rtrim(get_campo('EXTRUTACOMPANANTE',xml2),' '));
        xml2:=put_campo(xml2,'EXTNOMBREACOMPANANTE',rtrim(get_campo('EXTNOMBREACOMPANANTE',xml2),' '));     

   --xml2:=put_campo(xml2,'EXTAPELLIDOPAT',get_campo('EXTAPELLIDOPAT',xml2));

        return xml2;
end;
$$
LANGUAGE plpgsql;
