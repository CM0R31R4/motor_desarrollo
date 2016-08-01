
SQL*Plus: Release 11.2.0.3.0 Production on Wed Jun 17 15:55:56 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - 64bit Production
With the Partitioning, OLAP and Data Mining options

SQL> SQL> PROCEDURE CDNDATOSPREST
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 EXTCODFINANCIADOR		NUMBER			IN
 EXTRUTCONVENIO 		VARCHAR2		IN
 EXTCODIGOSUCUR 		VARCHAR2		IN
 EXTESTCONVENIO 		VARCHAR2		OUT
 EXTNIVEL			NUMBER			OUT
 EXTTIPOPRESTADOR		VARCHAR2		OUT
 EXTCODESPECIALIDADES		VARCHAR2		OUT
 EXTCODPROFESIONES		VARCHAR2		OUT
 EXTANOSANTIGUEDAD		VARCHAR2		OUT
FUNCTION RUT_TONUMBER RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 P_RUT				VARCHAR2		IN

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
package 	   CDNDATOSPREST_PKG is

  -- Author  : RISOTO
  -- Created : 11/07/2013 19:12:31
  -- Purpose :

  PROCEDURE CDNDATOSPREST(srv_message	       in out varchar2,
			  extCodFinanciador    in Number,
			  extRutConvenio       in varchar2,
			  extCodigoSucur       in varchar2,
			  extEstConvenio       out varchar2,
			  extNivel	       out Number, --tinyint
			  extTipoPrestador     out varchar2,
			  extCodEspecialidades out varchar2,
			  extCodProfesiones    out varchar2,
			  extAnosAntiguedad    out varchar2);

  FUNCTION RUT_TONUMBER(p_Rut in varchar2) RETURN number;

end CDNDATOSPREST_PKG;


21 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - 64bit Production
With the Partitioning, OLAP and Data Mining options
