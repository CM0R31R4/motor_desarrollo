
SQL*Plus: Release 11.2.0.3.0 Production on Wed Jun 19 16:37:56 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	   Banvaltrans_Pkg IS

Procedure BANvaltrans
(  SRV_Message		   IN Out VARCHAR2,
   In_extCodFinanciador    IN  NUMBER,
   in_extfoliofinanciador  IN  NUMBER,
   in_extaccion 	   IN  VARCHAR2,
   in_extpregunta	   IN  VARCHAR2,
   out_extrespuesta	   Out VARCHAR2,
   out_extcoderror	   Out VARCHAR2,
   out_extmensajeerror	   Out VARCHAR2
);

End Banvaltrans_Pkg;

14 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
