
SQL*Plus: Release 11.2.0.3.0 Production on Thu Aug 8 18:07:08 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	   Vidvaltrans_Pkg IS

PROCEDURE VIDvaltrans
(  SRV_Message		   IN OUT VARCHAR2,
   In_extCodFinanciador    IN  NUMBER,
   in_extfoliofinanciador  IN  NUMBER,
   in_extaccion 	   IN  VARCHAR2,
   in_extpregunta	   IN  VARCHAR2,
   out_extrespuesta	   OUT VARCHAR2,
   out_extcoderror	   OUT VARCHAR2,
   out_extmensajeerror	   OUT VARCHAR2
);

END Vidvaltrans_Pkg;

14 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
