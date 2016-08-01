
SQL*Plus: Release 11.2.0.3.0 Production on Thu Aug 8 18:07:07 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	   Vidsolicfolios_Pkg IS

TYPE extFoliosDevueltos_arr IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;

--VIDSolicFolios
PROCEDURE VIDSolicFolios
(  SRV_Message		   IN OUT VARCHAR2,
   In_extCodFinanciador    IN  NUMBER,
   In_extNumFolios	   IN  NUMBER,
   Out_extCodError	   OUT VARCHAR2,
   Out_extMensajeError	   OUT VARCHAR2,
   Col_extFoliosDevueltos  OUT extFoliosDevueltos_arr
);
--Fin BANSolicFolios

END Vidsolicfolios_Pkg;

16 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
