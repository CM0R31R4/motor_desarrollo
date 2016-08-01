
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 5 18:34:28 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> PROCEDURE BANBENCERTIF
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 ICODFINANCIADOR		NUMBER			IN
 IRUTBENEFICIARIO		VARCHAR2		IN
 OEXFECHAACTUAL 		DATE			IN
 OAPELLIDOPAT			VARCHAR2		OUT
 OAPELLIDOMAT			VARCHAR2		OUT
 ONOMBRES			VARCHAR2		OUT
 OSEXO				VARCHAR2		OUT
 OFECHANACIMI			DATE			OUT
 OCODESTBEN			VARCHAR2		OUT
 ODESCESTADO			VARCHAR2		OUT
 ORUTCOTIZANTE			VARCHAR2		OUT
 ONOMCOTIZANTE			VARCHAR2		OUT
 ODIRPACIENTE			VARCHAR2		OUT
 OGLOSACOMUNA			VARCHAR2		OUT
 OGLOSACIUDAD			VARCHAR2		OUT
 OPREVISION			VARCHAR2		OUT
 OGLOSA 			VARCHAR2		OUT
 OPLAN				VARCHAR2		OUT
 ODESCUENTOXPLANILLA		VARCHAR2		OUT
 OMONTOEXCEDENTE		NUMBER			OUT
 CRUTACOMPANANTE		TABLE OF VARCHAR2(12)	OUT
 CNOMACOMPANANTE		TABLE OF VARCHAR2(40)	OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	   "BANBENCERTIF_PKG" IS

Type crutacompanante_arr IS TABLE OF VARCHAR2(12) INDEX BY BINARY_INTEGER;
Type cnomacompanante_arr IS TABLE OF VARCHAR2(40) INDEX BY BINARY_INTEGER;
Procedure banbencertif	(
	  srv_message IN Out VARCHAR2,
	  iCodFinanciador  NUMBER,
	  iRutBeneficiario VARCHAR2,
	  oEXFechaActual   IN DATE,   --yyymmdd
	  oApellidoPat	   Out VARCHAR2,
	  oApellidoMat	   Out VARCHAR2,
	  oNombres	   Out VARCHAR2,
	  oSexo 	   Out VARCHAR2,
	  oFechaNacimi	   Out DATE,
	  oCodEstBen	   Out VARCHAR2,
	  oDescEstado	   Out VARCHAR2,
	  oRutCotizante    Out VARCHAR2,
	  oNomCotizante    Out VARCHAR2,
	  oDirPaciente	   Out VARCHAR2,
	  oGlosaComuna	   Out VARCHAR2,
	  oGlosaCiudad	   Out VARCHAR2,
	  oPrevision	   Out VARCHAR2,
	  oGlosa	   Out VARCHAR2,
	  oPlan 	   Out VARCHAR2,
	  oDescuentoxPlanilla Out VARCHAR2,
	  oMontoExcedente 	  Out NUMBER
	  ,crutacompanante 	  Out crutacompanante_arr
	  ,cnomacompanante 	  Out cnomacompanante_arr
		   );
End Banbencertif_Pkg;

30 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
