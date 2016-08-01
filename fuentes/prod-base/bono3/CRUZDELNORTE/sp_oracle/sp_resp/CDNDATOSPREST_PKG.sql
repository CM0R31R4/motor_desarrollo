
SQL*Plus: Release 10.2.0.3.0 - Production on Tue Aug 5 11:49:11 2014

Copyright (c) 1982, 2006, Oracle.  All Rights Reserved.


Connected to:
Oracle8i Release 8.1.7.4.0 - Production
JServer Release 8.1.7.4.0 - Production

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

SQL> Disconnected from Oracle8i Release 8.1.7.4.0 - Production
JServer Release 8.1.7.4.0 - Production
