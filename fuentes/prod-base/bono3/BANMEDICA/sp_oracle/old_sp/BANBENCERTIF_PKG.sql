
SQL*Plus: Release 11.2.0.3.0 Production on Fri Jun 14 12:23:21 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> PROCEDURE BANBENCERTIF
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 ICODFINANCIADOR		NUMBER			IN
 IRUTBENEFICIARIO		VARCHAR2		IN
 OEXFECHAACTUAL 		DATE			IN
 OAPELLIDOPAT			VARCHAR2		OUT
 OAPELLIDOMAT			VARCHAR2		OUT
 ONOMBRES			VARCHAR2		OUT
 OSEXO				VARCHAR2		OUT
 OFECHANACIMI			DATE			OUT
 OCODESTBEN			VARCHAR2		OUT
 ODESCESTADO			VARCHAR2		OUT
 ORUTCOTIZANTE			VARCHAR2		OUT
 ONOMCOTIZANTE			VARCHAR2		OUT
 ODIRPACIENTE			VARCHAR2		OUT
 OGLOSACOMUNA			VARCHAR2		OUT
 OGLOSACIUDAD			VARCHAR2		OUT
 OPREVISION			VARCHAR2		OUT
 OGLOSA 			VARCHAR2		OUT
 OPLAN				VARCHAR2		OUT
 ODESCUENTOXPLANILLA		VARCHAR2		OUT
 OMONTOEXCEDENTE		NUMBER			OUT
 CRUTACOMPANANTE		TABLE OF VARCHAR2(12)	OUT
 CNOMACOMPANANTE		TABLE OF VARCHAR2(40)	OUT

SQL> SP2-0042: unknown command "go" - rest of line ignored.
SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production