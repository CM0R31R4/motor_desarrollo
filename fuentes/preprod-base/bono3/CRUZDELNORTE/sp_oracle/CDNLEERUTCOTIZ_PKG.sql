
SQL*Plus: Release 10.2.0.3.0 - Production on Tue Aug 5 11:49:14 2014

Copyright (c) 1982, 2006, Oracle.  All Rights Reserved.


Connected to:
Oracle8i Release 8.1.7.4.0 - Production
JServer Release 8.1.7.4.0 - Production

SQL> SQL> PROCEDURE CDNLEERUTCOTIZ
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 EXTCODFINANCIADOR		NUMBER			IN
 EXTRUTCOTIZANTE		VARCHAR2		IN
 EXTNOMCOTIZANTE		VARCHAR2		OUT
 EXTCODERROR			VARCHAR2		OUT
 EXTMENSAJEERROR		VARCHAR2		OUT
 EXTCORRBENEF			TABLE OF NUMBER(3)	OUT
 EXTRUTBENEFICIARIO		TABLE OF VARCHAR2(12)	OUT
 EXTAPELLIDOPAT 		TABLE OF VARCHAR2(30)	OUT
 EXTAPELLIDOMAT 		TABLE OF VARCHAR2(30)	OUT
 EXTNOMBRES			TABLE OF VARCHAR2(40)	OUT
 EXTCODESTBEN			TABLE OF VARCHAR2(1)	OUT
 EXTDESCESTADO			TABLE OF VARCHAR2(15)	OUT
FUNCTION STRRUTTONUMBER RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 VARRUT 			VARCHAR2		IN
FUNCTION VERIFICARUT RETURNS BOOLEAN
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 RUTENTRADA			VARCHAR2		IN

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
package CDNLEERUTCOTIZ_PKG is

  -- Author  : RISOTO
  -- Created : 11/07/2013 19:41:48
  -- Purpose :

   TYPE ColChar1 IS TABLE OF VARCHAR2(1) INDEX BY BINARY_INTEGER;
  TYPE ColChar12 IS TABLE OF VARCHAR2(12) INDEX BY BINARY_INTEGER;
  TYPE ColChar15 IS TABLE OF VARCHAR2(15) INDEX BY BINARY_INTEGER;
  TYPE ColChar30 IS TABLE OF VARCHAR2(30) INDEX BY BINARY_INTEGER;
  TYPE ColChar40 IS TABLE OF VARCHAR2(40) INDEX BY BINARY_INTEGER;
  TYPE ColNumber IS TABLE OF NUMERIC(3) INDEX BY BINARY_INTEGER;

  PROCEDURE CDNLEERUTCOTIZ(srv_message	      in out varchar2,
			   extCodFinanciador  in number,
			   extRutCotizante    in varchar2,
			   extNomCotizante    out varchar2,
			   extCodError	      out varchar2,
			   extMensajeError    out varchar2,
			   ExtCorrBenef       out ColNumber,
			   extRutBeneficiario out ColChar12,
			   extApellidoPat     out ColChar30,
			   extApellidoMat     out ColChar30,
			   extNombres	      out ColChar40,
			   extCodEstBen       out ColChar1,
			   extDescEstado      out ColChar15);

  FUNCTION verificaRut(rutEntrada varchar2) RETURN boolean;
  FUNCTION strRutToNumber(varRut varchar2) RETURN number;

end CDNLEERUTCOTIZ_PKG;


32 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle8i Release 8.1.7.4.0 - Production
JServer Release 8.1.7.4.0 - Production
