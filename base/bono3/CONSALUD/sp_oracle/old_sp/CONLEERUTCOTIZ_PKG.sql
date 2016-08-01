
SQL*Plus: Release 11.2.0.3.0 Production on Wed Sep 25 11:58:28 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONLEERUTCOTIZ
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTRUTCOTIZANTE		VARCHAR2		IN
 OUT_VEXTNOMCOTIZANTE		VARCHAR2		OUT
 OUT_VEXTCODERROR		VARCHAR2		OUT
 OUT_VEXTMENSAJEERROR		VARCHAR2		OUT
 COL_NEXTCORRBENEF		TABLE OF NUMBER(3)	OUT
 COL_VEXTRUTBENEFICIARIO	TABLE OF VARCHAR2(12)	OUT
 COL_VEXTAPELLIDOPAT		TABLE OF VARCHAR2(30)	OUT
 COL_VEXTAPELLIDOMAT		TABLE OF VARCHAR2(30)	OUT
 COL_VEXTNOMBRES		TABLE OF VARCHAR2(40)	OUT
 COL_VEXTCODESTBEN		TABLE OF VARCHAR2(1)	OUT
 COL_VEXTDESCESTADO		TABLE OF VARCHAR2(15)	OUT

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
