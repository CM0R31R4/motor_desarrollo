
SQL*Plus: Release 10.2.0.3.0 - Production on Tue Aug 5 11:49:17 2014

Copyright (c) 1982, 2006, Oracle.  All Rights Reserved.


Connected to:
Oracle8i Release 8.1.7.4.0 - Production
JServer Release 8.1.7.4.0 - Production

SQL> SQL> FUNCTION BONIFICACION RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 CODARA 			NUMBER			IN
 CODPLAN			NUMBER			IN
 CATEGORIA			NUMBER			IN
 VALPRES			NUMBER			IN
FUNCTION BONIFICACION_2 RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 CODARA 			NUMBER			IN
 CODPLAN			NUMBER			IN
 CATEGORIA			NUMBER			IN
 VALPRES			NUMBER			IN
 RUT_PREST			VARCHAR2		IN
FUNCTION BONIFICACION_3 RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 CODARA 			NUMBER			IN
 CODPLAN			NUMBER			IN
 CATEGORIA			NUMBER			IN
 VALPRES			NUMBER			IN
 RUT_PREST			VARCHAR2		IN
 RUT_BENEFICIARIO		NUMBER			IN
FUNCTION BUSCAGRUPO RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 CODARA 			NUMBER			IN
 CODPLAN			NUMBER			IN
 CATE				NUMBER			IN
PROCEDURE CDNVALORVARI
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 EXTCODFINANCIADOR		NUMBER			IN
 EXTHOMNUMEROCONVENIO		VARCHAR2		IN
 EXTHOMLUGARCONVENIO		VARCHAR2		IN
 EXTSUCVENTA			VARCHAR2		IN
 EXTRUTCONVENIO 		VARCHAR2		IN
 EXTRUTTRATANTE 		VARCHAR2		IN
 EXTESPECIALIDAD		VARCHAR2		IN
 EXTRUTSOLICITANTE		VARCHAR2		IN
 EXTRUTBENEFICIARIO		VARCHAR2		IN
 EXTTRATAMIENTO 		VARCHAR2		IN
 EXTCODIGODIAGNOSTICO		VARCHAR2		IN
 EXTNIVELCONVENIO		NUMBER			IN
 EXTURGENCIA			VARCHAR2		IN
 EXTLISTA1			VARCHAR2		IN
 EXTLISTA2			VARCHAR2		IN
 EXTLISTA3			VARCHAR2		IN
 EXTLISTA4			VARCHAR2		IN
 EXTLISTA5			VARCHAR2		IN
 EXTLISTA6			VARCHAR2		IN
 EXTLISTA7			VARCHAR2		IN
 EXTNUMPRESTACIONES		NUMBER			IN
 EXTCODERROR			VARCHAR2		OUT
 EXTMENSAJEERROR		VARCHAR2		OUT
 EXTPLAN			VARCHAR2		OUT
 EXTGLOSA1			VARCHAR2		OUT
 EXTGLOSA2			VARCHAR2		OUT
 EXTGLOSA3			VARCHAR2		OUT
 EXTGLOSA4			VARCHAR2		OUT
 EXTGLOSA5			VARCHAR2		OUT
 EXTVALORPRESTACION		TABLE OF NUMBER(12)	OUT
 EXTAPORTEFINANCIADOR		TABLE OF NUMBER(12)	OUT
 EXTCOPAGO			TABLE OF NUMBER(12)	OUT
 EXTINTERNOISA			TABLE OF VARCHAR2(15)	OUT
 EXTTIPOBONIF1			TABLE OF NUMBER(12)	OUT
 EXTCOPAGO1			TABLE OF NUMBER(12)	OUT
 EXTTIPOBONIF2			TABLE OF NUMBER(12)	OUT
 EXTCOPAGO2			TABLE OF NUMBER(12)	OUT
 EXTTIPOBONIF3			TABLE OF NUMBER(12)	OUT
 EXTCOPAGO3			TABLE OF NUMBER(12)	OUT
 EXTTIPOBONIF4			TABLE OF NUMBER(12)	OUT
 EXTCOPAGO4			TABLE OF NUMBER(12)	OUT
 EXTTIPOBONIF5			TABLE OF NUMBER(12)	OUT
 EXTCOPAGO5			TABLE OF NUMBER(12)	OUT
FUNCTION DESCUENTOPLANILLA RETURNS BOOLEAN
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 RUTCARGA			NUMBER			IN
FUNCTION LISTAENVBONIS RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 LISTA				VARCHAR2		IN
FUNCTION LISTAVALORVARI RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 LISTA				VARCHAR2		IN
FUNCTION NUMRUTTOSTR RETURNS VARCHAR2
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 RUTENTRADA			NUMBER			IN
 DIGITO 			VARCHAR2		IN
FUNCTION RUT_TONUMBER RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 P_RUT				VARCHAR2		IN
FUNCTION STRRUTTONUMBER RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 VARRUT 			VARCHAR2		IN
FUNCTION VALIDARUT RETURNS BOOLEAN
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 RUTENTRADA			VARCHAR2		IN
FUNCTION VALORISAPRE RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 CODARA 			NUMBER			IN
 TIPO				NUMBER			IN
 TOPE				NUMBER			IN
FUNCTION VALORPRESTACION RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 PRUTPRES			NUMBER			IN
 PCODARA			NUMBER			IN
 PURGENCIA			VARCHAR2		IN
 PFUERAHORA			VARCHAR2		IN
FUNCTION VERCODARANCEL RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 CODARAN			NUMBER			IN
FUNCTION VERCODVARI RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 FECHAACTUAL			NUMBER			IN
FUNCTION VERCORRPRES RETURNS BOOLEAN
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 CORRELATIVO			NUMBER			IN
FUNCTION VERIFICARUT RETURNS BOOLEAN
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 RUTENTRADA			VARCHAR2		IN

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
package CDNVALORVARI_PKG is

  -- Author  : RISOTO
  -- Created : 11/07/2013 19:20:57
  -- Purpose :

  TYPE ColChar IS TABLE OF VARCHAR2(15) INDEX BY BINARY_INTEGER;
  TYPE ColNumber IS TABLE OF NUMERIC(12) INDEX BY BINARY_INTEGER;
  TYPE OutCursor IS REF CURSOR;

  PROCEDURE CDNVALORVARI(srv_message	      in out varchar2,
			 extCodFinanciador    in number,
			 extHomNumeroConvenio in varchar2,
			 extHomLugarConvenio  in varchar2,
			 extSucVenta	      in varchar2,
			 extRutConvenio       in varchar2,
			 extRutTratante       in varchar2,
			 extEspecialidad      in varchar2,
			 extRutSolicitante    in varchar2,
			 extRutBeneficiario   in varchar2,
			 extTratamiento       in varchar2,
			 extCodigoDiagnostico in varchar2,
			 extNivelConvenio     in number,
			 extUrgencia	      in varchar2,
			 extLista1	      in varchar2,
			 extLista2	      in varchar2,
			 extLista3	      in varchar2,
			 extLista4	      in varchar2,
			 extLista5	      in varchar2,
			 extLista6	      in varchar2,
			 extLista7	      in varchar2,
			 extNumPrestaciones   in number,
			 extCodError	      out varchar2,
			 extMensajeError      out varchar2,
			 extPlan	      out varchar2,
			 ExtGlosa1	      out varchar2,
			 ExtGlosa2	      out varchar2,
			 ExtGlosa3	      out varchar2,
			 ExtGlosa4	      out varchar2,
			 ExtGlosa5	      out varchar2,
			 extValorPrestacion   out ColNumber,
			 extAporteFinanciador out ColNumber,
			 extCopago	      out ColNumber,
			 extInternoIsa	      out ColChar,
			 ExtTipoBonif1	      out ColNumber,
			 ExtCopago1	      out ColNumber,
			 ExtTipoBonif2	      out ColNumber,
			 ExtCopago2	      out ColNumber,
			 ExtTipoBonif3	      out ColNumber,
			 ExtCopago3	      out ColNumber,
			 ExtTipoBonif4	      out ColNumber,
			 ExtCopago4	      out ColNumber,
			 ExtTipoBonif5	      out ColNumber,
			 ExtCopago5	      out ColNumber);

  FUNCTION ListaValorVari(lista varchar2) RETURN number;
  FUNCTION ListaEnvBonis(lista varchar2) RETURN number;
  FUNCTION strRutToNumber(varRut varchar2) RETURN number;
  FUNCTION numRutToStr(rutEntrada number, digito varchar2) RETURN varchar2;
  FUNCTION verificaRut(rutEntrada varchar2) RETURN boolean;
  FUNCTION validaRut(rutEntrada varchar2) RETURN boolean;
  FUNCTION descuentoPlanilla(rutCarga number) RETURN boolean;
  FUNCTION valorPrestacion(pRutPres   number,
			   pCodAra    number,
			   pUrgencia  varchar2,
			   pFueraHora varchar2) RETURN number;
  FUNCTION valorIsapre(codAra number, tipo number, tope number) RETURN number;
  FUNCTION Bonificacion(codAra	  number,
			codPlan   number,
			categoria number,
			valPres   number) RETURN number;

 FUNCTION Bonificacion_2(codAra    number,
			codPlan   number,
			categoria number,
			valPres   number,
			rut_prest varchar2) RETURN number;

  FUNCTION Bonificacion_3(codAra    number,
			codPlan   number,
			categoria number,
			valPres   number,
			rut_prest varchar2,
			rut_beneficiario number) RETURN number;

  FUNCTION buscaGrupo(codAra number, codPlan number, cate number)
    RETURN number;
  FUNCTION verCodArancel(codAran number) RETURN number;
  FUNCTION verCodVari(fechaActual number) RETURN number;
  FUNCTION verCorrPres(correlativo number) RETURN boolean;
FUNCTION RUT_TONUMBER(p_Rut in varchar2) RETURN number ;
end CDNVALORVARI_PKG;


93 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle8i Release 8.1.7.4.0 - Production
JServer Release 8.1.7.4.0 - Production
