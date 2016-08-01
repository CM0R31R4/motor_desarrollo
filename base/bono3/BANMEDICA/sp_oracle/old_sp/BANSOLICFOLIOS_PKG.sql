
SQL*Plus: Release 11.2.0.3.0 Production on Tue Jun 18 18:23:50 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	   Bansolicfolios_Pkg IS
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
