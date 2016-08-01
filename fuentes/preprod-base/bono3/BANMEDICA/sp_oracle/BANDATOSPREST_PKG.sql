
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 5 18:34:29 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> PROCEDURE BANDATOSPREST
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		OUT
 EXTCODFINANCIADOR		NUMBER			IN
 EXTRUTCONVENIO 		VARCHAR2		IN
 EXTCODIGOSUCUR 		VARCHAR2		IN
 EXTESTCONVENIO 		VARCHAR2		OUT
 EXTNIVEL			NUMBER			OUT
 EXTTIPOPRESTADOR		VARCHAR2		OUT
 EXTCODESPECIALIDADES		VARCHAR2		OUT
 EXTCODPROFESIONES		VARCHAR2		OUT
 EXTANOSANTIGUEDAD		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE Bandatosprest_Pkg IS
/**********************************************************************************************
 DAM, 26/03/2004.
**********************************************************************************************/
PROCEDURE BanDatosPrest(
  SRV_Message		    OUT VARCHAR2,
  extCodFinanciador  		IN NUMBER,
  extRutConvenio 			IN VARCHAR2,
  extCodigoSucur 			IN VARCHAR2,
  extEstConvenio			OUT VARCHAR2,
  extNivel					OUT NUMBER,
  extTipoPrestador 			OUT VARCHAR2,
  extCodEspecialidades		OUT VARCHAR2,
  extCodProfesiones		    OUT VARCHAR2,
  extAnosAntiguedad 		OUT VARCHAR2
);
-- Fin BanDatosPrest

END Bandatosprest_Pkg;

19 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
