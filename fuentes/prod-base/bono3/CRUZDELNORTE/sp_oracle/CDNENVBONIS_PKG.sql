
SQL*Plus: Release 11.2.0.3.0 Production on Wed Jun 17 15:55:57 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - 64bit Production
With the Partitioning, OLAP and Data Mining options

SQL> SQL> FUNCTION BONIFICACION RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 CODARA 			NUMBER			IN
 CODPLAN			NUMBER			IN
 CATEGORIA			NUMBER			IN
 VALPRES			NUMBER			IN
FUNCTION BUSCAGRUPO RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 CODARA 			NUMBER			IN
 CODPLAN			NUMBER			IN
 CATE				NUMBER			IN
PROCEDURE CDNENVBONIS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 EXTCODFINANCIADOR		NUMBER			IN
 EXTHOMNUMEROCONVENIO		VARCHAR2		IN
 EXTHOMLUGARCONVENIO		VARCHAR2		IN
 EXTSUCVENTA			VARCHAR2		IN
 EXTRUTCONVENIO 		VARCHAR2		IN
 EXTRUTASOCIADO 		VARCHAR2		IN
 EXTNOMPRESTADOR		VARCHAR2		IN
 EXTRUTTRATANTE 		VARCHAR2		IN
 EXTESPECIALIDAD		VARCHAR2		IN
 EXTRUTBENEFICIARIO		VARCHAR2		IN
 EXTRUTCOTIZANTE		VARCHAR2		IN
 EXTRUTACOMPANANTE		VARCHAR2		IN
 EXTRUTEMISOR			VARCHAR2		IN
 EXTRUTCAJERO			VARCHAR2		IN
 EXTCODIGODIAGNOSTICO		VARCHAR2		IN
 EXTDESCUENTOXPLANILLA		VARCHAR2		IN
 EXTMONTOEXCEDENTE		NUMBER			IN
 EXTFECHAEMISION		VARCHAR2		IN
 EXTNIVELCONVENIO		NUMBER			IN
 EXTFOLIOFINANCIADOR		NUMBER			IN
 EXTMONTOVALORTOTAL		NUMBER			IN
 EXTMONTOAPORTETOTAL		NUMBER			IN
 EXTMONTOCOPAGOTOTAL		NUMBER			IN
 EXTNUMOPERACION		NUMBER			IN
 EXTCORRPRESTACION		NUMBER			IN
 EXTTIPOSOLICITUD		NUMBER			IN
 EXTFECHAINICIO 		VARCHAR2		IN
 EXTURGENCIA			VARCHAR2		IN
 EXTPLAN			VARCHAR2		IN
 EXTLISTA1			VARCHAR2		IN
 EXTLISTA2			VARCHAR2		IN
 EXTLISTA3			VARCHAR2		IN
 EXTCODERROR			VARCHAR2		OUT
 EXTMENSAJEERROR		VARCHAR2		OUT
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
FUNCTION OBTENERPLAN RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 EXTPLAN			VARCHAR2		IN
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
FUNCTION VERIFICADESCUENTO RETURNS VARCHAR2
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 RUTBENEF			NUMBER			IN
FUNCTION VERIFICARUT RETURNS BOOLEAN
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 RUTENTRADA			VARCHAR2		IN

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
package CDNENVBONIS_PKG is

  -- Author  : RISOTO
  -- Created : 11/07/2013 19:30:48
  -- Purpose :

  PROCEDURE CDNENVBONIS(srv_message	      in out varchar2,
			extCodFinanciador     in number,
			extHomNumeroConvenio  in varchar2,
			extHomLugarConvenio   in varchar2,
			extSucVenta	      in varchar2,
			extRutConvenio	      in varchar2,
			extRutAsociado	      in varchar2,
			extNomPrestador       in varchar2,
			extRutTratante	      in varchar2,
			extEspecialidad       in varchar2,
			extRutBeneficiario    in varchar2,
			extRutCotizante       in varchar2,
			extRutAcompanante     in varchar2,
			extRutEmisor	      in varchar2,
			extRutCajero	      in varchar2,
			extCodigoDiagnostico  in varchar2,
			extDescuentoxPlanilla in varchar2,
			extMontoExcedente     in number,
			extFechaEmision       in varchar2,
			extNivelConvenio      in number,
			extFolioFinanciador   in number,
			extMontoValorTotal    in number,
			extMontoAporteTotal   in number,
			extMontoCopagoTotal   in number,
			extNumOperacion       in number,
			extCorrPrestacion     in number,
			extTipoSolicitud      in number,
			extFechaInicio	      in varchar2,
			extUrgencia	      in varchar2,
			extPlan 	      in varchar2,
			extLista1	      in varchar2,
			extLista2	      in varchar2,
			ExtLista3	      in varchar2,
			extCodError	      out varchar2,
			extMensajeError       out varchar2);

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



  FUNCTION buscaGrupo(codAra number, codPlan number, cate number)
    RETURN number;
  FUNCTION verCodArancel(codAran number) RETURN number;
  FUNCTION verCodVari(fechaActual number) RETURN number;
  FUNCTION verCorrPres(correlativo number) RETURN boolean;
  FUNCTION verificaDescuento(rutBenef number) RETURN varchar2;
  FUNCTION obtenerPlan(extPlan varchar2) RETURN number;

end CDNENVBONIS_PKG;


71 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - 64bit Production
With the Partitioning, OLAP and Data Mining options
