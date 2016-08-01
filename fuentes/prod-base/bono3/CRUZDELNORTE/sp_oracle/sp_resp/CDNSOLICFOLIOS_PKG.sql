
SQL*Plus: Release 10.2.0.3.0 - Production on Tue Aug 5 11:49:15 2014

Copyright (c) 1982, 2006, Oracle.  All Rights Reserved.


Connected to:
Oracle8i Release 8.1.7.4.0 - Production
JServer Release 8.1.7.4.0 - Production

SQL> SQL> PROCEDURE CDNSOLICFOLIOS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 EXTCODFINANCIADOR		NUMBER			IN
 EXTNUMFOLIOS			NUMBER			IN
 EXTCODERROR			VARCHAR2		OUT
 EXTMENSAJEERROR		VARCHAR2		OUT
 EXFOLIOSDEVUELTOS		TABLE OF NUMBER 	OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
package 	   CDNSOLICFOLIOS_PKG is

  -- Author  : RISOTO
  -- Created : 11/07/2013 19:29:06
  -- Purpose :

  TYPE ColNum IS TABLE OF Number INDEX BY BINARY_INTEGER;
  TYPE OutCursor IS REF CURSOR;

  PROCEDURE CDNSOLICFOLIOS(srv_message	     in out varchar2,
			   extCodFinanciador in Number,
			   extNumFolios      in Number,
			   extCodError	     out varchar2,
			   extMensajeError   out varchar2,
			   exFoliosDevueltos out ColNum);

/****************** Procedimiento original ******************************************************
  PROCEDURE SOLICFOLIOS(extCodFinanciador in integer,
			extNumFolios	  in integer,
			extCodError	  out char,
			extMensajeError   out char,
			exFoliosDevueltos out OutCursor);
  ************************************************************************************************/

end CDNSOLICFOLIOS_PKG;


26 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle8i Release 8.1.7.4.0 - Production
JServer Release 8.1.7.4.0 - Production
