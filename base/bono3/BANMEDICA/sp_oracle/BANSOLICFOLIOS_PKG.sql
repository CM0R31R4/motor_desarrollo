
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 5 18:34:32 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> PROCEDURE BANSOLICFOLIOS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTNUMFOLIOS		NUMBER			IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 COL_EXTFOLIOSDEVUELTOS 	TABLE OF NUMBER(10)	OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE Bansolicfolios_Pkg IS
--TYPE cr_SolicFolios IS REF CURSOR;
TYPE extFoliosDevueltos_arr IS TABLE OF NUMBER(10,0) INDEX BY BINARY_INTEGER;


--BANSolicFolios
PROCEDURE BANSolicFolios
(  SRV_Message		   IN OUT VARCHAR2,
   In_extCodFinanciador    IN  NUMBER,
   In_extNumFolios	   IN  NUMBER,
   Out_extCodError	   OUT VARCHAR2,
   Out_extMensajeError	   OUT VARCHAR2,
   Col_extFoliosDevueltos  OUT extFoliosDevueltos_arr
);
--Fin BANSolicFolios

END Bansolicfolios_Pkg;

17 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
