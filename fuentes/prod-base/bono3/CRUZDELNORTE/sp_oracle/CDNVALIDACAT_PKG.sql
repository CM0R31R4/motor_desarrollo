
SQL*Plus: Release 11.2.0.3.0 Production on Wed Jun 17 15:56:00 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - 64bit Production
With the Partitioning, OLAP and Data Mining options

SQL> SQL> PROCEDURE CDNVALIDACAT
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 EXTCODFINANCIADOR		NUMBER			IN
 EXTRUTCONVENIO 		VARCHAR2		IN
 EXTRUTTRATANTE 		VARCHAR2		IN
 EXTRUTSOLICITANTE		VARCHAR2		IN
 EXTRUTBENEFICIARIO		VARCHAR2		IN
 EXTRUTCOTIZANTE		VARCHAR2		IN
 EXTCODIGOHOMOLOGO		VARCHAR2		IN
 EXTITEM			VARCHAR2		IN
 EXTCODIGODIAGNOSTICO		VARCHAR2		IN
 EXTCODMODALIDAD		VARCHAR2		IN
 EXTCODTIPATENCION		VARCHAR2		IN
 EXTFECHANACIMIENTO		VARCHAR2		IN
 EXTCODSEXO			VARCHAR2		IN
 EXTFECHATERMINO		VARCHAR2		IN
 EXTFECHAINICIO 		VARCHAR2		IN
 EXTFRECPRESTDIA		NUMBER			IN
 EXTLISTAPRESTACA		VARCHAR2		IN
 EXTLISTAPRESTACB		VARCHAR2		IN
 EXTLISTAPRESTACC		VARCHAR2		IN
 EXTLISTAPRESTACD		VARCHAR2		IN
 EXTLISTAPRESTACE		VARCHAR2		IN
 EXTLISTAPRESTACF		VARCHAR2		IN
 EXTINDVIDEO			VARCHAR2		IN
 EXTINDBILATERAL		VARCHAR2		IN
 EXTRECARGOFUERAHORA		VARCHAR2		IN
 EXTINDREEMBOLSO		VARCHAR2		IN
 EXTINDPROGRAMA 		VARCHAR2		IN
 EXTCODAPLICACION		VARCHAR2		IN
 EXTCODREGION			VARCHAR2		IN
 EXTCODSUCUR			VARCHAR2		IN
 EXTTIPOPRESTADOR		VARCHAR2		IN
 EXTCODESPECIALIDADES		VARCHAR2		IN
 EXTCODPROFESIONES		VARCHAR2		IN
 EXTANOSANTIGUEDAD		VARCHAR2		IN
 EXTRESPUESTACAT		VARCHAR2		OUT
 EXTMENSAJECAT			VARCHAR2		OUT
FUNCTION GENERA_DV_RUT RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 P_COD				NUMBER			IN
FUNCTION RUT_TONUMBER RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 P_RUT				VARCHAR2		IN
FUNCTION STR_TO_NUMBER RETURNS BOOLEAN
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 P_VALOR			VARCHAR2		IN
FUNCTION VALIDACAT_VALIDALISTA RETURNS CHAR
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 P_LISTAX			VARCHAR2		IN
 P_IDLISTA			VARCHAR2		IN
 P_RUTPRESTADOR 		VARCHAR2		IN
FUNCTION VALIDA_FECHA RETURNS BOOLEAN
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 P_FECHA			DATE			IN
FUNCTION VERIFICA_RUT RETURNS BOOLEAN
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 P_RUT				CHAR			IN

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
package CDNVALIDACAT_PKG is

  -- Author  : RISOTO
  -- Created : 11/07/2013 19:14:15
  -- Purpose :

  -- Author  : RISOTO
  -- Created : 07-05-2013 17:43:03
  -- Purpose :
  TYPE OutCursor IS REF CURSOR;
  type lista is table of varchar(15) index by binary_integer;

  PROCEDURE CDNVALIDACAT(srv_message	      in out varchar2,
			 extCodFinanciador    in number,
			 extRutConvenio       in varchar2,
			 extRutTratante       in varchar2,
			 extRutSolicitante    in varchar2,
			 extRutBeneficiario   in varchar2,
			 extRutCotizante      in varchar2,
			 extCodigoHomologo    in varchar2,
			 extItem	      in varchar2,
			 extCodigoDiagnostico in varchar2,
			 extCodModalidad      in varchar2,
			 extCodTipAtencion    in varchar2,
			 extFechaNacimiento   in varchar2,
			 extCodSexo	      in varchar2,
			 extFechaTermino      in varchar2,
			 extFechaInicio       in varchar2,
			 extFrecPrestDia      in number,
			 extListaPrestacA     in varchar2,
			 extListaPrestacB     in varchar2,
			 extListaPrestacC     in varchar2,
			 extListaPrestacD     in varchar2,
			 ExtListaPrestacE     in varchar2,
			 extListaPrestacF     in varchar2,
			 extIndVideo	      in varchar2,
			 extIndBilateral      in varchar2,
			 extRecargoFueraHora  in varchar2,
			 extIndReembolso      in varchar2,
			 extIndPrograma       in varchar2,
			 extCodAplicacion     in varchar2,
			 extCodRegion	      in varchar2,
			 extCodSucur	      in varchar2,
			 extTipoPrestador     in varchar2,
			 extCodEspecialidades in varchar2,
			 extCodProfesiones    in varchar2,
			 extAnosAntiguedad    in varchar2,
			 extRespuestaCAT      out varchar2,
			 extMensajeCAT	      out varchar2);

  FUNCTION VERIFICA_RUT(p_Rut in char) RETURN BOOLEAN;

  FUNCTION RUT_TONUMBER(p_Rut in varchar2) RETURN number;

  FUNCTION VALIDA_FECHA(p_fecha in date) return boolean;

  FUNCTION VALIDACAT_VALIDALISTA(p_listaX	in varchar,
				 p_idLista	in varchar,
				 p_rutPrestador in varchar) RETURN char;

  FUNCTION GENERA_DV_RUT(p_cod in number) RETURN NUMBER;

  FUNCTION STR_TO_NUMBER(p_valor in varchar) RETURN BOOLEAN;




end CDNVALIDACAT_PKG;


69 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - 64bit Production
With the Partitioning, OLAP and Data Mining options
