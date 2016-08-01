
SQL*Plus: Release 11.2.0.3.0 Production on Wed Jun 17 15:56:03 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - 64bit Production
With the Partitioning, OLAP and Data Mining options

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

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - 64bit Production
With the Partitioning, OLAP and Data Mining options
