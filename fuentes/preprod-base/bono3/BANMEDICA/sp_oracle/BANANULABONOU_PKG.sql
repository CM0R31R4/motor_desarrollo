
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 5 18:34:27 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> PROCEDURE BANANULABONOU
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTFOLIOBONO		NUMBER			IN
 IN_EXTINDTRATAM		VARCHAR2		IN
 IN_EXTFECTRATAM		DATE			IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE Bananulabonou_Pkg IS

PROCEDURE BANAnulaBonoU
(  SRV_Message		   IN OUT VARCHAR2,
   In_extCodFinanciador    IN  NUMBER,
   in_extfoliobono	   IN  NUMBER,
   in_extIndTratam	   IN  VARCHAR2,
   in_extFecTratam	   IN  DATE,
   out_extcoderror	   OUT VARCHAR2,
   out_extmensajeerror	   OUT VARCHAR2
);

END Bananulabonou_Pkg;

13 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
