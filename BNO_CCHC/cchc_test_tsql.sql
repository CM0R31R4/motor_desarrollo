sp_help dbo.MASAnulaBonoU
#######################################################################################################################################
<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://ws.imed.embswitch.chileoffshore.com/"><SOAP-ENV:Body><ns1:bencertif><extCodFinanciador>88</extCodFinanciador><extRutBeneficiario>0007817560-5</extRutBeneficiario><extFechaActual>2014-06-03</extFechaActual></ns1:bencertif></SOAP-ENV:Body></SOAP-ENV:Envelope>

145658597 <05> <STATUS>FALLA_FIN_REINTENTOS</STATUS><DESCRIPCION>ERROR:  secuencia de byt
es no vÃ¡lida para codificaciÃ³n Ã«UTF8Ã»: 0xd1 0x45
</DESCRIPCION>
145658597 <05> ERROR:  secuencia de bytes no vÃ¡lida para codificaciÃ³n Ã«UTF8Ã»: 0xd450x

145658597 <00> CierraSocket
145658597 <05> Error en la base :
145658597 <05> ERROR:  secuencia de bytes no vÃ¡lida para codificaciÃ³n Ã«UTF8Ã»: 0xd450x


tsql -H 10.150.73.171 -p 1433 -U imed -P servicio
select db_name()


DECLARE @extCodFinanciador numeric (5);
DECLARE @extRutBeneficiario char (12);
DECLARE @extFechaActual datetime;
DECLARE @extApellidoPat char (30);
DECLARE @extApellidoMat char (30);
DECLARE @extNombres char (40);
DECLARE @extSexo char (1);
DECLARE @extFechaNacimi char (8);
DECLARE @extCodEstBen char (1);
--DECLARE @extDescEstado char (15);
DECLARE @extDescEstado char (30);
DECLARE @extRutCotizante char (12);
DECLARE @extNomCotizante char (40);
DECLARE @extDirPaciente char (40);
DECLARE @extGlosaComuna char (30);
DECLARE @extGlosaCiudad char (30);
DECLARE @extPrevision char (1);
DECLARE @extGlosa char (40);
DECLARE @extPlan char (15);
DECLARE @extDescuentoxPlanilla char (1);
DECLARE @extMontoExcedente numeric (10);

DECLARE @extRutAcompanante char (12);
DECLARE @extNombreAcompanante char (40); 

EXEC dbo.MASBenCertif 88,"0007817560-5" ,"20140603", @extApellidoPat OUTPUT,@extApellidoMat OUTPUT,@extNombres OUTPUT, @extSexo OUTPUT,@extFechaNacimi OUTPUT,@extCodEstBen OUTPUT,@extDescEstado OUTPUT,@extRutCotizante OUTPUT, @extNomCotizante OUTPUT,@extDirPaciente OUTPUT,@extGlosaComuna OUTPUT,@extGlosaCiudad OUTPUT, @extPrevision OUTPUT,@extGlosa OUTPUT,@extPlan OUTPUT,@extDescuentoxPlanilla OUTPUT,@extMontoExcedente OUTPUT; 

SELECT @extApellidoPat as extApellidoPat, @extApellidoMat as extApellidoMat ,@extNombres as extNombres , @extSexo as extSexo ,@extFechaNacimi as extFechaNacimi ,@extCodEstBen as extCodEstBen , @extDescEstado as extDescEstado,@extRutCotizante as extRutCotizante, @extNomCotizante as extNomCotizante,@extDirPaciente as extDirPaciente , @extGlosaComuna as extGlosaComuna ,@extGlosaCiudad as extGlosaCiudad , @extPrevision as extPrevision ,@extGlosa as extGlosa,@extPlan as extPlan, @extDescuentoxPlanilla as extDescuentoxPlanilla ,@extMontoExcedente as extMontoExcedente, @extRutAcompanante as extRutAcompanante, @extNombreAcompanante as extNombreAcompanante;
GO

extRutAcompanante       extNombreAcompanante
0006974376-5    GUIÑZ FERRER, JAIME ULISES
0015737328-5    GUIÑZ FERNANDEZ, MARISOL ANDREA
(2 rows affected)
(return status = 0)
extApellidoPat  extApellidoMat  extNombres      extSexo extFechaNacimi  extCodEstBen    extDescEstado   extRutCotizante extNomCotizante extDirPaciente  extGlosaComuna  extGlosaCiudad  extPrevision    extGlosa  extPlan  extDescuentoxPlanilla   extMontoExcedente       extRutAcompanante       extNombreAcompanante
FERNANDEZ                       PEÑ                            PATRICIA SUSANA                                 F       19580119        C       Certificado                     0006974376-5    JAIME ULISES GUIÑZ FERRER                 LOS JARDINES 614-B                              ÑÑA                           ÑÑA                           D                                                       LAVE100         N 0NULL    NULL

