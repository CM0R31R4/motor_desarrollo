
SQL*Plus: Release 11.2.0.3.0 Production on Wed Sep 25 11:58:28 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONPRESTPAQUETE
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTHOMNUMEROCONVENIO	VARCHAR2		IN
 IN_VEXTHOMLUGARCONVENIO	VARCHAR2		IN
 IN_VEXTCODPAQUETE		VARCHAR2		IN
 OUT_VEXTCODERROR		VARCHAR2		OUT
 OUT_VEXTMENSAJEERROR		VARCHAR2		OUT
 COL_VEXTCODHOMOLOGO		TABLE OF VARCHAR2(12)	OUT
 COL_VEXTITEMHOMOLOGO		TABLE OF VARCHAR2(12)	OUT
 COL_VEXTCANTIDAD		TABLE OF NUMBER(5)	OUT

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
