
SQL*Plus: Release 11.2.0.3.0 Production on Wed May 27 17:04:03 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.5.0 - 64bit Production

SQL> SQL> PROCEDURE FNDPRESTPAQUETE
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTHOMNUMEROCONVENIO	VARCHAR2		IN
 IN_EXTHOMLUGARCONVENIO 	VARCHAR2		IN
 IN_EXTCODPAQUETE		VARCHAR2		IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 OUT_EXTCODHOMOLOGO		TABLE OF VARCHAR2(12)	OUT
 OUT_EXTITEMHOMOLOGO		TABLE OF VARCHAR2(2)	OUT
 OUT_EXTCANTIDAD		TABLE OF NUMBER(2)	OUT

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 10g Release 10.2.0.5.0 - 64bit Production
