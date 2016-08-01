
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 5 18:34:33 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> PROCEDURE BANVALTRANS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTFOLIOFINANCIADOR 	NUMBER			IN
 IN_EXTACCION			VARCHAR2		IN
 IN_EXTPREGUNTA 		VARCHAR2		IN
 OUT_EXTRESPUESTA		VARCHAR2		OUT
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE Banvaltrans_Pkg IS

PROCEDURE BANvaltrans
(  SRV_Message		   IN OUT VARCHAR2,
   In_extCodFinanciador    IN  NUMBER,
   in_extfoliofinanciador  IN  NUMBER,
   in_extaccion 	   IN  VARCHAR2,
   in_extpregunta	   IN  VARCHAR2,
   out_extrespuesta	   OUT VARCHAR2,
   out_extcoderror	   OUT VARCHAR2,
   out_extmensajeerror	   OUT VARCHAR2
);

END Banvaltrans_Pkg;

14 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
