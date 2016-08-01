
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 5 18:34:30 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> PROCEDURE BANINFENROLA
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 IN_EXTRUTACOMPANANTE		VARCHAR2		IN
 IN_EXTINDENROLA		NUMBER			IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE Baninfenrola_Pkg IS

--BANEnrola
PROCEDURE BANInfenrola
(  SRV_Message		   IN OUT VARCHAR2,
   In_extCodFinanciador    IN  NUMBER,
   In_extRutBeneficiario   IN  VARCHAR2,
   In_extRutacompanante    IN  VARCHAR2,
   In_extIndEnrola	   IN  NUMBER ,
   Out_extCoderror	   OUT VARCHAR2,
   Out_extMensajeError	   OUT VARCHAR2
);
--Fin BANSolicFolios

END Baninfenrola_Pkg;

15 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
