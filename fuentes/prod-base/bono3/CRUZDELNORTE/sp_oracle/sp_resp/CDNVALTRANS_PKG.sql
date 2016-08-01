
SQL*Plus: Release 10.2.0.3.0 - Production on Tue Aug 5 11:49:18 2014

Copyright (c) 1982, 2006, Oracle.  All Rights Reserved.


Connected to:
Oracle8i Release 8.1.7.4.0 - Production
JServer Release 8.1.7.4.0 - Production

SQL> SQL> PROCEDURE CDNVALTRANS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 EXTCODFINANCIADOR		NUMBER			IN
 EXFOLIOFINANCIADOR		NUMBER			IN
 EXTACCION			VARCHAR2		IN
 EXTPREGUNTA			VARCHAR2		IN
 EXTRESPUESTA			VARCHAR2		OUT
 EXTCODERROR			VARCHAR2		OUT
 EXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
package 	   CDNVALTRANS_PKG is

  PROCEDURE CDNVALTRANS(srv_message	   in out varchar2,
		     extCodFinanciador	in Number,
		     exFolioFinanciador in Number,
		     extAccion		in varchar2,
		     extPregunta	in varchar2,
		     extRespuesta	out varchar2,
		     extCodError	out varchar2,
		     extMensajeError	out varchar2);

end CDNVALTRANS_PKG;


13 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle8i Release 8.1.7.4.0 - Production
JServer Release 8.1.7.4.0 - Production
