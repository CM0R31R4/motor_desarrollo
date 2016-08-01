
SQL*Plus: Release 11.2.0.3.0 Production on Tue Mar 10 12:46:26 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONENVBONIS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTHOMNUMEROCONVENIO	VARCHAR2		IN
 IN_VEXTHOMLUGARCONVENIO	VARCHAR2		IN
 IN_VEXTSUCVENTA		VARCHAR2		IN
 IN_VEXTRUTCONVENIO		VARCHAR2		IN
 IN_VEXTRUTASOCIADO		VARCHAR2		IN
 IN_VEXTNOMPRESTADOR		VARCHAR2		IN
 IN_VEXTRUTTRATANTE		VARCHAR2		IN
 IN_VEXTESPECIALIDAD		VARCHAR2		IN
 IN_VEXTRUTBENEFICIARIO 	VARCHAR2		IN
 IN_VEXTRUTCOTIZANTE		VARCHAR2		IN
 IN_VEXTRUTACOMPANANTE		VARCHAR2		IN
 IN_VEXTRUTEMISOR		VARCHAR2		IN
 IN_VEXTRUTCAJERO		VARCHAR2		IN
 IN_VEXTCODIGODIAGNOSTICO	VARCHAR2		IN
 IN_VEXTDESCUENTOXPLANILLA	VARCHAR2		IN
 IN_NEXTMONTOEXCEDENTE		NUMBER			IN
 IN_VEXTFECHAEMISION		VARCHAR2		IN
 IN_NEXTNIVELCONVENIO		NUMBER			IN
 IN_NEXTFOLIOFINANCIADOR	NUMBER			IN
 IN_NEXTMONTOVALORTOTAL 	NUMBER			IN
 IN_NEXTMONTOAPORTETOTAL	NUMBER			IN
 IN_NEXTMONTOCOPAGOTOTAL	NUMBER			IN
 IN_NEXTNUMOPERACION		NUMBER			IN
 IN_NEXTCORRPRESTACION		NUMBER			IN
 IN_NEXTTIPOSOLICITUD		NUMBER			IN
 IN_VEXTFECHAINICIO		VARCHAR2		IN
 IN_VEXTURGENCIA		VARCHAR2		IN
 IN_VEXTPLAN			VARCHAR2		IN
 IN_VEXTLISTA1			VARCHAR2		IN
 IN_VEXTLISTA2			VARCHAR2		IN
 IN_VEXTLISTA3			VARCHAR2		IN
 OUT_VEXTCODERROR		VARCHAR2		OUT
 OUT_VEXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Conenvbonis_Pkg
AS
  TYPE vCursor IS REF  CURSOR;

  PROCEDURE CONEnvBonIs  (    SRV_Message 		  			     IN OUT VARCHAR2 --(1)
						    , In_nExtCodFinanciador				 IN		NUMBER 	 --(2)	--Codigo del Financiador	I
						    , In_vExtHomNumeroConvenio			 IN		VARCHAR2 --(3)	--Homologo numero de convenio	I
						    , In_vExtHomLugarConvenio			 IN		VARCHAR2 --(4)	--Homologo lugar  de convenio	I
							, In_vExtSucVenta					 IN		VARCHAR2 --(5)	--Homologo Sucurvn_SAL Venta Financiador	I
							, In_vExtRutConvenio				 IN		VARCHAR2 --(6)	--Rut Convenio	I
							, In_vExtRutAsociado				 IN		VARCHAR2 --(7)	--Rut Solicitante	I
							, In_vExtNomPrestador				 IN		VARCHAR2 --(8) 	--Nombre completo del Prestador	I
							, In_vExtRutTratante				 IN		VARCHAR2 --(9)	--Rut Medico Tratante	I
							, In_vExtEspecialidad				 IN		VARCHAR2 --(10)	--Rut Medico Tratante	I
							, In_vExtRutBeneficiario			 IN		VARCHAR2 --(11)	--Rut Beneficiario	I
							, In_vExtRutCotizante				 IN		VARCHAR2 --(12)	--Rut Afiliado.	I
							, In_vExtRutAcompanante				 IN		VARCHAR2 --(13)	--Rut Acompa?ante.	I
							, In_vExtRutEmisor					 IN		VARCHAR2 --(14)	--Rut Emisor.	I
							, In_vExtRutCajero					 IN		VARCHAR2 --(15)	--Rut Cajero.	I
							, In_vExtCodigoDiagnostico			 IN		VARCHAR2 --(16)	--Codigo de diagnostico	I
							, In_vExtDescuentoxPlanilla			 IN		VARCHAR2 --(17)	--Descuento por planilla.	I	'N', 'S'
							, In_nExtMontoExcedente				 IN		NUMBER 	 --(18)	--Monto ocupado en excedentes	I
							, In_vExtFechaEmision				 IN		VARCHAR2 --(19)	--Fecha Emision	I
							, In_nExtNivelConvenio				 IN		NUMBER	 --(20)	--Nivel convenido por prestador	I	1,2,3
							, In_nExtFolioFinanciador			 IN		NUMBER	 --(21)	--Folio Bono Financiador	I
							, In_nExtMontoValorTotal			 IN		NUMBER	 --(22)	--Valor total del bono	I
							, In_nExtMontoAporteTotal			 IN		NUMBER	 --(23)	--Aporte o Bonificacion total del bono	I
							, In_nExtMontoCopagoTotal			 IN		NUMBER	 --(24) 	--Copago total del bono	I
							, In_nExtNumOperacion				 IN		NUMBER	 --(25)	--Numero de Operacion	I
							, In_nExtCorrPrestacion				 IN		NUMBER	 --(26)	--Correlativo Interno	I
							, In_nExtTipoSolicitud				 IN		NUMBER	 --(27)	--Tipo de Solicitud (Programa =2)	I
							, In_vExtFechaInicio				 IN		VARCHAR2 --(28)	--Fecha de Inicio del Tratamiento (Certificacion)	I
							, In_vExtUrgencia					 IN		VARCHAR2 --(29)	--Indicador de Urgencia	I	'N', 'S'
							, In_vExtPlan						 IN		VARCHAR2 --(30)	--PLAN de vn_SALud	I
							, In_vExtLista1						 IN		VARCHAR2 --(31)	--Lista1	I	10 homologo
							, In_vExtLista2						 IN		VARCHAR2 --(32)	--Lista 2	I
							, In_vExtLista3						 IN		VARCHAR2 --(33)	--Lista 2	I
							, Out_vExtCodError					 OUT	VARCHAR2 --(34)	--Codigo Error	O	'N', 'S'
							, Out_vExtMensajeError				 OUT	VARCHAR2 --(35)	--Mensaje de error	O
							  );

END Conenvbonis_Pkg;



44 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
