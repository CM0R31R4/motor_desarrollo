
SQL*Plus: Release 11.2.0.3.0 Production on Tue Jun 25 17:32:46 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.4.0 - Production

SQL> SQL> PROCEDURE FUSVALTRANS
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
PROCEDURE RBLVALTRANS
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
PROCEDURE SNLVALTRANS
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

SQL> Disconnected from Oracle Database 10g Release 10.2.0.4.0 - Production