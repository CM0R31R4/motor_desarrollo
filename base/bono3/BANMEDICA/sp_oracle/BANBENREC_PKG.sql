
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 5 18:34:28 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> PROCEDURE BANBENREC
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 ICODFINANCIADOR		NUMBER			IN
 IRUT_COTIZANTE 		VARCHAR2		IN
 EXTCORRBENEF			VARCHAR2		IN
 EXTRUTBENEFICIARIO		VARCHAR2		IN
 EXTCODRESBEN			VARCHAR2		OUT
 OMENSAJEERROR			VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package Banbenrec_Pkg IS

Procedure BanBenRec  (
	  srv_message  IN Out VARCHAR2,
	  iCodFinanciador     NUMBER,
		  iRut_Cotizante      VARCHAR2,
		  extCorrBenef	      VARCHAR2,
		  extRutBeneficiario  VARCHAR2,
		  extCodResBen	  Out VARCHAR2,
	  oMensajeError   Out VARCHAR2
 );

End Banbenrec_Pkg;

13 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
