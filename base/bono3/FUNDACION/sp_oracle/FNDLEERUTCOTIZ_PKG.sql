
SQL*Plus: Release 11.2.0.3.0 Production on Wed May 27 17:04:02 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.5.0 - 64bit Production

SQL> SQL> PROCEDURE FNDLEERUTCOTIZ
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		VARCHAR2		IN
 IN_EXTRUTCOTIZANTE		VARCHAR2		IN
 OUT_EXTNOMCOTIZANTE		VARCHAR2		OUT
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 OUT_EXTCORRBENEF		TABLE OF NUMBER(3)	OUT
 OUT_EXTRUTBENEFICIARIO 	TABLE OF VARCHAR2(12)	OUT
 OUT_EXTAPELLIDOPAT		TABLE OF VARCHAR2(30)	OUT
 OUT_EXTAPELLIDOMAT		TABLE OF VARCHAR2(30)	OUT
 OUT_EXTNOMBRES 		TABLE OF VARCHAR2(40)	OUT
 OUT_EXTCODESTBEN		TABLE OF VARCHAR2(1)	OUT
 OUT_EXTDESCESTADO		TABLE OF VARCHAR2(15)	OUT

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 10g Release 10.2.0.5.0 - 64bit Production
