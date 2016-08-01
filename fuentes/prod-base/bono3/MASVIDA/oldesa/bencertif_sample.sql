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
DECLARE @extRutAcompanantes char (120);
DECLARE @extNombreAcompanante char (40);
DECLARE @extNombreAcompanantes char (400);

CREATE TABLE #Result(
extRutAcompanante char (12),
extNombreAcompanante char (40));

set @extCodFinanciador = 88;
set @extRutBeneficiario = '1-9';
set @extFechaActual = GETDATE();

INSERT INTO #Result EXEC  dbo.MASBenCertif @extCodFinanciador, @extRutBeneficiario, @extFechaActual,
 @extApellidoPat OUTPUT,@extApellidoMat OUTPUT,@extNombres OUTPUT,
 @extSexo OUTPUT,@extFechaNacimi OUTPUT,@extCodEstBen OUTPUT,@extDescEstado OUTPUT,@extRutCotizante OUTPUT,
 @extNomCotizante OUTPUT,@extDirPaciente OUTPUT,@extGlosaComuna OUTPUT,@extGlosaCiudad OUTPUT,
 @extPrevision OUTPUT,@extGlosa OUTPUT,@extPlan OUTPUT,@extDescuentoxPlanilla OUTPUT,@extMontoExcedente OUTPUT;

select *, @extApellidoPat as extApellidoPat, @extApellidoMat as extApellidoMat ,@extNombres as extNombres ,
@extSexo as extSexo ,@extFechaNacimi as extFechaNacimi ,@extCodEstBen as extCodEstBen ,
@extDescEstado as extDescEstado,@extRutCotizante as extRutCotizante,
@extNomCotizante as extNomCotizante,@extDirPaciente as extDirPaciente ,
@extGlosaComuna as extGlosaComuna ,@extGlosaCiudad as extGlosaCiudad ,
@extPrevision as extPrevision ,@extGlosa as extGlosa,@extPlan as extPlan,
@extDescuentoxPlanilla as extDescuentoxPlanilla ,@extMontoExcedente as extMontoExcedente
 from #Result;

set @extRutAcompanantes = '';
set @extNombreAcompanante = '';

DECLARE CResult Cursor for
select extRutAcompanante, extNombreAcompanante from #Result;
OPEN CResult;

FETCH NEXT FROM CResult
INTO @extRutAcompanante, @extNombreAcompanante;

WHILE @@FETCH_STATUS = 0
BEGIN
   set @extRutAcompanantes = @extRutAcompanantes + ',' + @extRutAcompanante;
   set @extNombreAcompanantes = concat(@extNombreAcompanantes + ',' + @extNombreAcompanante;

   FETCH NEXT FROM CResult
   INTO @extRutAcompanante, @extNombreAcompanante;
END

CLOSE CResult;
DEALLOCATE CResult;

select @extRutAcompanantes, @extNombreAcompanantes;

Drop Table #Result;


