
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 5 18:34:29 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> PROCEDURE BANENROLA
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTRUTENLORAR		VARCHAR2		IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 OUT_EXTVALIDO			VARCHAR2		OUT
 OUT_EXTNOMBRECOMP		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE Banenrola_Pkg IS

--BANEnrola
PROCEDURE BANEnrola
(  SRV_Message		   IN OUT VARCHAR2,
   In_extCodFinanciador    IN  NUMBER,
   In_extRutEnlorar	   IN  VARCHAR2,
   In_extRutBeneficiario   IN  VARCHAR2,
   Out_extValido	   OUT VARCHAR2,
   Out_extNombreComp	   OUT VARCHAR2
);
--Fin BANSolicFolios

END Banenrola_Pkg;

14 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
