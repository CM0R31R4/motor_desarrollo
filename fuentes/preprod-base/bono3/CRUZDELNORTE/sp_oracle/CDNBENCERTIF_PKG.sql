
SQL*Plus: Release 10.2.0.3.0 - Production on Tue Aug 5 11:49:09 2014

Copyright (c) 1982, 2006, Oracle.  All Rights Reserved.


Connected to:
Oracle8i Release 8.1.7.4.0 - Production
JServer Release 8.1.7.4.0 - Production

SQL> SQL> PROCEDURE CDNBENCERTIF
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 EXTCODFINANCIADOR		NUMBER			IN
 EXTRUTBENEFICIARIO		VARCHAR2		IN
 EXTFECHAACTUAL 		VARCHAR2		IN
 EXTAPELLIDOPAT 		VARCHAR2		OUT
 EXTAPELLIDOMAT 		VARCHAR2		OUT
 EXTNOMBRES			VARCHAR2		OUT
 EXTSEXO			VARCHAR2		OUT
 EXTFECHANACIMI 		VARCHAR2		OUT
 EXTCODESTBEN			VARCHAR2		OUT
 EXTDESCESTADO			VARCHAR2		OUT
 EXTRUTCOTIZANTE		VARCHAR2		OUT
 EXTNOMCOTIZANTE		VARCHAR2		OUT
 EXTDIRPACIENTE 		VARCHAR2		OUT
 EXTGLOSACOMUNA 		VARCHAR2		OUT
 EXTGLOSACIUDAD 		VARCHAR2		OUT
 EXTPREVISION			VARCHAR2		OUT
 EXTGLOSA			VARCHAR2		OUT
 EXTPLAN			VARCHAR2		OUT
 EXTDESCUENTOXPLANILLA		VARCHAR2		OUT
 EXTMONTOEXCEDENTE		NUMBER			OUT
 EXTRUTACOMPANANTE		TABLE OF VARCHAR2(12)	OUT
 EXTNOMBREACOMPANANTE		TABLE OF VARCHAR2(40)	OUT
FUNCTION DESCUENTOPLANILLA RETURNS BOOLEAN
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 RUTCARGA			NUMBER			IN
FUNCTION NUMRUTTOSTR RETURNS VARCHAR2
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 RUTENTRADA			NUMBER			IN
 DIGITO 			VARCHAR2		IN
FUNCTION STRRUTTONUMBER RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 VARRUT 			VARCHAR2		IN
FUNCTION VERIFICARUT RETURNS BOOLEAN
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 RUTENTRADA			VARCHAR2		IN

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
package CDNBENCERTIF_PKG is

  -- Author  : RISOTO
  -- Created : 11/07/2013 19:09:06
  -- Purpose :

  TYPE type_rut_acom IS TABLE OF VARCHAR2(12) index by binary_integer;
  TYPE type_nombre_acom IS TABLE OF VARCHAR2(40) index by binary_integer;

  PROCEDURE CDNBENCERTIF(srv_message	       in out varchar2,
			 extCodFinanciador     in number,
			 extRutBeneficiario    in varchar2,
			 extFechaActual        in varchar2,
			 extApellidoPat        out varchar2,
			 extApellidoMat        out varchar2,
			 extNombres	       out varchar2,
			 extSexo	       out varchar2,
			 extFechaNacimi        out varchar2,
			 extCodEstBen	       out varchar2,
			 extDescEstado	       out varchar2,
			 extRutCotizante       out varchar2,
			 extNomCotizante       out varchar2,
			 extDirPaciente        out varchar2,
			 extGlosaComuna        out varchar2,
			 extGlosaCiudad        out varchar2,
			 extPrevision	       out varchar2,
			 extGlosa	       out varchar2,
			 extPlan	       out varchar2,
			 extDescuentoxPlanilla out varchar2,
			 extMontoExcedente     out number,
			 extRutAcompanante     out type_rut_acom,
			 extNombreAcompanante  out type_nombre_acom);

  FUNCTION verificaRut(rutEntrada varchar2) RETURN boolean;
  FUNCTION strRutToNumber(varRut varchar2) RETURN number;
  FUNCTION numRutToStr(rutEntrada number, digito varchar2) RETURN varchar2;
  FUNCTION descuentoPlanilla(rutCarga number) RETURN boolean;

end CDNBENCERTIF_PKG;


40 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle8i Release 8.1.7.4.0 - Production
JServer Release 8.1.7.4.0 - Production
