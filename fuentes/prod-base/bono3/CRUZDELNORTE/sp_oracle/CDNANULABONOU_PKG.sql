
SQL*Plus: Release 11.2.0.3.0 Production on Wed Jun 17 15:55:53 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - 64bit Production
With the Partitioning, OLAP and Data Mining options

SQL> SQL> PROCEDURE CDNANULABONOU
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 EXTCODFINANCIADOR		NUMBER			IN
 EXTFOLIOBONO			NUMBER			IN
 EXTINDTRATAM			VARCHAR2		IN
 EXTFECTRATAM			VARCHAR2		IN
 EXTCODERROR			VARCHAR2		OUT
 EXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
package 	   CDNANULABONOU_PKG is

  -- Author  : RISOTO
  -- Created : 11/07/2013 19:38:20
  -- Purpose :

  PROCEDURE CDNANULABONOU(srv_message	    in out varchar2,
			  extCodFinanciador in number,
			  extFolioBono	    in number,
			  extIndTratam	    in varchar2,
			  extFecTratam	    in varchar2,
			  extCodError	    out varchar2,
			  extMensajeError   out varchar2);

end CDNANULABONOU_PKG;

15 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - 64bit Production
With the Partitioning, OLAP and Data Mining options
