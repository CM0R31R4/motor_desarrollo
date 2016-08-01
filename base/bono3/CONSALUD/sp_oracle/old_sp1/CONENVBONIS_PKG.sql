
SQL*Plus: Release 11.2.0.3.0 Production on Wed Mar 5 19:00:00 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
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

42 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     Conenvbonis_Pkg
AS
/******************************************************************************
   NAME:       Conenvbonis_Pkg
   PURPOSE:    Package que contiene los cursores y procedimientos usados para la
	       generacion de documentos de liquidacion desde repositorio de prestaciones enviadas por
	       IMED.

   REVISIONS:
   Ver	      Date	  Author	    Description
   ---------  ----------  ---------------   ------------------------------------
   1.0	      22/05/2006  BENEFICIOS	    1.- CREACION
   --
   2.0	      01/07/2012  Bernardo Castillo (BNF-000924) Modif Proceso Generacion Bonos IMED,
					    busca respaldo cuando no existe repositorio para generar el bono.
   --
   Here is the complete list of available Auto Replace Keywords:
      Object Name:     Conenvbonis_Pkg or Conenvbonis_Pkg
      Username: 	(set in TOAD Options, Procedure Editor)
******************************************************************************/
--****************************************************************************/
--
PROCEDURE CONEnvBonIs  (  SRV_Message 		  			     IN OUT VARCHAR2 --(1)
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
)

IS
--- NOMBRE DE LA TRANSACCION
vv_NOMBRE_TRANSACCION							VARCHAR2(50):= UPPER('Conenvbonis_Pkg');
vv_PARAMETROS_ENTRADA							VARCHAR2(2000);
vv_PARAMETROS_SALIDA							VARCHAR2(2000);
vv_SEPARADOR_PTO_COMA	   						VARCHAR2(1):=';';
vv_OUTPUT_STATUS_SERVICIO						VARCHAR2(1);
vv_OUTPUT_CODIGO_MENSAJE 						VARCHAR2(5);
vv_OUTPUT_MENSAJE								VARCHAR2(243);
vn_SRV_FETCH_STATUS								VARCHAR2(1) := '0';
vn_SRV_TOTAL_ROWS								NUMBER(8);
vn_SRV_ROW_COUNT								NUMBER(8);
vv_INICIO_TEXTO_MENSAJE							VARCHAR2(1):='X'; -- Para diferenciar vv_OUTPUT_MENSAJE de Out_vExtMensajeError
vv_MensajeError									VARCHAR2(500);
-- Codigo de la Isapre para validar Entrada
vn_CODIGO_ISAPRE_CONSALUD  		   	 	   	   	NUMBER	:=71;

/* Variables Auxiliares utilizadas por la Funcion */
TYPE linea_bono IS RECORD
    (dobe_correlativo	  NUMBER(10),
     num_linea		  NUMBER(4),
     estado		  VARCHAR2(3),
     monto_copago	  NUMBER(10,2),
     monto_isapre	  NUMBER(10,2),
     monto_otros	  NUMBER(10,2),
     monto_total	  NUMBER(10,2),
     numero_prestaciones  NUMBER(4),
     prisa_codigo	  NUMBER(7),
     prest_codigo_interno NUMBER(10),
     esp_codigo 	  VARCHAR2(5),
     monto_bcc		  NUMBER(10,2),
	 monto_ges			  NUMBER(12,2), --EACE 28-06-2005 GES
	 copago_ges			  NUMBER(12,2), --EACE 28-06-2005 GES
	 codigo_grupo		  VARCHAR2(10), --EACE 28-06-2005 GES
	 monto_dscto_mega	  NUMBER(10,2), --PGP 29/12/2005
	 benef_comp_aplicado  VARCHAR(8)  --PGP 29/12/2005
	 ,Monto_Descto_Especial 	   NUMBER(12,2) -- 08/06/2006 -- ACS 08/06/2006
	 ,Monto_Precio_Rebajado 	   NUMBER(12,2) -- 08/06/2006 -- ACS 08/06/2006
	 ,Monto_Bonif_Precio_Rebajado	 NUMBER(12,2) -- 08/06/2006 -- ACS 08/06/2006
	 ,interno_isapre					 VARCHAR(15) -- PGP 06/07/2006
	 ,Monto_credito					 NUMBER(12,2) -- PGP 11/05/2009
     );



TYPE tab_lineas IS TABLE OF
     CONEnvBonIs.linea_bono
     INDEX BY BINARY_INTEGER;


e_TOPES	   	  				 		EXCEPTION;
e_CARGO_BCC  		   	  	 		EXCEPTION;
e_FORMATO_LISTAS		  			EXCEPTION;
e_EXISTE_LISTA		   	  			EXCEPTION;
e_ISAPRE_NO_CORRESPONDE   			EXCEPTION;
E_MONTO_EXCEDENTE		  			EXCEPTION;
E_BONO_EXISTE						EXCEPTION;
vn_SAL			     		NUMBER(1);
vn_RESULTADO_INSERT_AUDITORIA	    NUMBER(1);
vn_CODIGO_MENSAJE_EXCEDENTE			NUMBER(1);
vv_GLOSA_EXCEDENTE 			  		VARCHAR2(50);
vn_TIPO_DOCUMENTO	   			NUMBER(1):= 1;
vv_TIPO_EMISION 	   			VARCHAR2(1);
vn_CENTRO_COSTO 	   			NUMBER(1):=0;
vv_BENEFICIOS_COMP		 	VARCHAR2(1);	 -- si tiene beneficios complementarios
vn_CENTRO_ATENCION	   			NUMBER(10):=0;
vn_UNOR_CORRELATIVO_CEN_ATEN	    NUMBER(10):=0;
vn_CODIGO_SUCURSAL_ISAPRE	    NUMBER(10);
vn_CODIGO_OFICINA_ISAPRE	    NUMBER(10);
vn_PLAN_CORRELATIVO	   			NUMBER(10);
vv_TIPO_PLAN		   			VARCHAR2(4);
vn_DOBE_CORRELATIVO		    NUMBER(10):=0;   -- numero del documento asignado por la isapre numbono
vn_MONTO_DSCTO_MEGA		  			NUMBER(10,2);-- PGP 29/12/2005 BC15
vn_MONTO_TOTAL_DSCTO_MEGA 			NUMBER(10,2):=0;-- PGP 29/12/2005 BC15
vv_BENEF_COMP_APLICADO	  			VARCHAR(8):=NULL;-- PGP 29/12/2005 BC15
vv_LINEA_A_GUARDAR	     		VARCHAR2(2000);
vn_TIPO_ATENCION	   			NUMBER(1):=2;
vv_TIPO_ATENCION	   			VARCHAR2(1);
vn_COPAGO_TOTAL 	     		NUMBER(14):=0;
vn_COPAGO_BCC		   			NUMBER(14):=0;
vn_MONTO_BCC		  			NUMBER(14):=0;
vv_SALIDA_FINAL 	   			VARCHAR2(2000);
vn_CODIGO_PRESTADOR		    NUMBER(10):=0;   -- codigo_interno del prestador
vn_CODIGO_MED_SOLICITANTE	    NUMBER(10):=0;   -- codigo_interno del medico solicitante
vn_CONTADOR		     		NUMBER(10);
vd_FECHA_SISTEMA	   			DATE;
vn_DOFI_CODIGO			  			NUMBER:=920; -- PGP 20/01/2006
vn_DOM_CORRELATIVO 		  			NUMBER(10);	  -- variable de tipo de unidad de medida del tope
vv_FECHA							VARCHAR2(8);
t_LINEAS		  			tab_lineas;
vn_SECUENCIA		     		NUMBER(16):=0;
vn_COAF_FOLIO_SUSCRIPCION			NUMBER(10):=0;	 -- folio del beneficiario

/* Variables de la Cabeza del bono que Atesa envia a la Isapre */

vv_INTERNO_ISAPRE  		  	  	   VARCHAR2(15):='';
vn_CODIGO_ISAPRE	      	   NUMBER(4):=0;	   -- codigo de la isapre
vn_RUT_PRESTADOR	      	   NUMBER(9):=0;	   -- rut del prestador que presta la atencion
vn_RUT_PRESTADOR_FACTURADOR	   NUMBER(9):=0;	   -- rut del prestador que factura la atencion
vv_CODIGO_ESPECILIDAD_HOMOLOG	   VARCHAR2(5);	   -- especialidad homologada
vn_LUGAR_DE_PRESTACION		   NUMBER(10):=0;	   -- lugar de la prestacion
vn_RUT_PRESTADOR_SOLICITANTE	   NUMBER(10):=0;	   -- rut del prestador que solicita la atencion
vn_RUT_COTIZANTE	      	   NUMBER(9):=0;	   -- rut del cotizante
vn_CODIGO_CARGA 	    	   NUMBER(4):=0;	   -- carga
vn_RUT_BENEFICIARIO		   NUMBER(9):=0;	   -- rut del beneficiario
vn_CODIGO_TERMINAL	       	   VARCHAR2(16);    -- Codigo del terminal
vn_CANT_LINEAS		    	   NUMBER(4):=0;	   -- numero de lineas
vn_MONTO_COPAGO_EXCEDENTE	   NUMBER(12):=0;   -- copago excedente
vn_COPAGO_BENEFICIO_COMP	   NUMBER(12):=0;   -- copago cta corriente beneficio complementario
vn_UNOR_CORRELATIVO_ISAPRE	   NUMBER(18):=0;   -- numero de isapre (unor correlativo)

/* Variables del Detalle del bono que Atesa envia a la Isapre */
vn_NRO_LINEA_BONO	       	  NUMBER(4):=0;    -- numero de linea
vn_CODIGO_PRESTACION_HOMOLOG	  NUMBER(8):=0;    -- codigo de la prestacion homologada
vn_NUMERO_PRESTACIONES		  NUMBER(4):=0;    -- numero de prestaciones
vn_TARIFA_POR_LINEA		  NUMBER(12):=0;   -- tarifa por linea
vn_VALOR_TOTAL_BONIFICACION	  NUMBER(12):=0;   -- monto bonificado por la isapre
vn_VALOR_TOTAL_COPAGO		  NUMBER(12):=0;   -- copago total
vn_MONTO_BONIF_ISAPRE	  		  NUMBER(12,2):=0;   -- monto bonificado por la isapre

/* variables de la cabeza del bono que la isapre envia a Atesa */
vn_MONTO_TOTAL		      	  NUMBER(12):=0;
vn_VALOR_BONIF		    	  NUMBER(12):=0;
vn_PRESTACIONES 	     	  NUMBER(12):=0;
vn_MONTO_COPAGO 	     	  NUMBER(12):=0;
vn_MONTO_BCC_AUDI	      	  NUMBER(12):=0;
vn_MONTO_COPAGO_BONIF		  NUMBER(12):=0;
vn_VALOR_COPAGO_EXCEDENTE	  NUMBER(12):=0;
vn_MONTO	      			  NUMBER(12):=0;
vn_NUMERO_LINEAS				  NUMBER(4):=0;
vd_FECHA_LLEGADA		  		  DATE:=NULL;
vd_FECHA_SALIDA			  		  DATE:=NULL;
vn_USO_BCC				  		  VARCHAR2 (1):=NULL;
vn_CON_EXCEDENTE				  VARCHAR2 (1):=NULL;
vn_USO_TOPE				  		  VARCHAR2 (1):=NULL;
vn_USO_CIGNA				  	  VARCHAR2 (1):=NULL;
vn_USO_BCC_EXC_TOPE				  VARCHAR2 (1):=NULL;
vn_BANDERA 						  NUMBER:=NULL;
-- variables para los topes

vv_FECHA_TOPE 	  	  	   		  VARCHAR2(10);
vv_TICOB_CODIGO 			  	  VARCHAR2(10);
vn_SALDO_CUENTA 			  	  NUMBER(14,2);
vn_ITEM_CODIGO 			  		  NUMBER(10);
vn_SALIDA_TOPE 			  		  VARCHAR2(10);
vv_MENSAJE_TOPE 			  	  VARCHAR2(100);

--  variable para detectar si es dental
--n_es_dental number(1):=0;  -- 0 no es dental; 1 es dental
vv_DOBE_TYPE   			  	 	  VARCHAR2(10);

/* APLICACION SEGURO CIGNA */
vv_ASEG_CORRELATIVO 	 	  	  NUMBER(10);
vn_COD_ISAPRE 					  NUMBER(4):=0;
vv_RELACION 				  	  VARCHAR(1):=' ';
vn_MONTO_SEGURO_TERCERO 	  	  NUMBER:=0;
vn_MONTO_COPAGO_REAL 	  		  NUMBER(12):=0;
e_CARGO_CIGNA 			  		  EXCEPTION;
e_EXCEDENTES			  		  EXCEPTION;

-- Variables IMED
v_nExtCodFinanciador	  		  NUMBER(3);
v_vExtHomNumeroConvenio			  VARCHAR2(15);
v_vExtHomLugarConvenio			  VARCHAR2(10);
v_vExtSucVenta					  VARCHAR2(10);
v_vExtRutConvenio				  VARCHAR2(12);
v_vExtRutAsociado				  VARCHAR2(12);
v_vExtNomPrestador				  VARCHAR2(40);
v_vExtRutTratante				  VARCHAR2(12);
v_vExtEspecialidad				  VARCHAR2(10);
v_vExtRutBeneficiario			  VARCHAR2(12);
v_vExtRutCotizante				  VARCHAR2(12);
v_vExtRutAcompanante			  VARCHAR2(12);
v_vExtRutEmisor					  VARCHAR2(12);
v_vExtRutCajero					  VARCHAR2(12);
v_vExtCodigoDiagnostico			  VARCHAR2(10);
v_vExtDescuentoXPlanilla		  VARCHAR2(1);
v_nExtMontoExcedente			  NUMBER(10);
v_dExtFechaEmision				  DATE;
v_nExtNivelConvenio				  NUMBER(1);
v_nExtFolioFinanciador			  NUMBER(10);
v_nExtMontoValorTotal			  NUMBER(10);
v_nExtMontoAporteTotal			  NUMBER(10);
v_nExtMontoCopagoTotal			  NUMBER(10);
v_nExtNumOperacion				  NUMBER(10);
v_nExtCorrPrestacion			  NUMBER(10);
v_nExtTipoSolicitud				  NUMBER(1);
v_dExtFechaInicio				  DATE;
v_vExtUrgencia					  VARCHAR2(1);
v_vExtPlan						  VARCHAR2(15);
v_vExtLista1					  VARCHAR2(255);
v_vExtLista2					  VARCHAR2(255);
v_vExtLista3					  VARCHAR2(255);
v_vExtCodError					  VARCHAR2(1);
v_vExtMensajeError				  VARCHAR2(30);
v_vExtLista						  VARCHAR2(2000);
v_vSeparador					  VARCHAR2(1):='|';
v_nFolio_Suscripcion			  NUMBER;
v_nMonto_Bcc 					  NUMBER:=0;
v_nMonto_Cigna 					  NUMBER:= 0;
v_nTipoBonificacion		  NUMBER(1);
v_nMontoBonificacion			  NUMBER:=0;
Out_N							  VARCHAR2(200); --CTC Parametros OUT no usados
v_vResp 	     		  NUMBER;
v_ncoderror		 	      NUMBER;
v_vgloerror			  VARCHAR2(200); --CETC
err_v_vResp 			    	  EXCEPTION;--ctc
err_Imed_Bene_Coti		    	  EXCEPTION;--ctc
vn_CODIGO_INTERNO_TRATANTE		  NUMBER(10):=0; --EACE 28-06-2005 GES
vv_CODIGO_SUB_GRUPO				  VARCHAR2(200); --EACE 28-06-2005 GES
vv_CODIGO_GRUPO					  VARCHAR2(200); --EACE 28-06-2005 GES
vv_DOBE_CODIGO_GRUPO			  VARCHAR2(200):=NULL; --EACE 29-05-2005 GES
vn_COD_GARANTIA 				  NUMBER(10):=0; --EACE 28-06-2005 GES
vn_GRUPO_SEQ 					  NUMBER(10):=0; --EACE 28-06-2005 GES
vn_SUB_GRUPO_SEQ 				  NUMBER(10):=0; --EACE 28-06-2005 GES
vn_Total_Prestaciones_GES		  NUMBER(10):=0; --EACE 28-06-2005 GES
vv_PRISA_ES_GES					  VARCHAR2(1); 	 --EACE 28-06-2005 GES
vv_PRISA_ES_GES_RES				  VARCHAR2(1); 	 --EACE 28-06-2005 GES
vv_ErrorCode					  VARCHAR2(256); --EACE 28-06-2005 GES
no_emision_ges				  	  EXCEPTION;
vn_MONTO_GES					  NUMBER(12,2):=0; --EACE 28-06-2005 GES
vn_COPAGO_GES					  NUMBER(12,2):=0; --EACE 28-06-2005 GES
vn_MONTO_GES_TOTAL				  NUMBER(12,2):=0; --EACE 28-06-2005 GES
vn_COPAGO_GES_TOTAL				  NUMBER(12,2):=0; --EACE 28-06-2005 GES
vv_SIN_GRANTIA	  				  VARCHAR2(1000):=''; --EACE 02-08-2005 GES
vv_SIN_GRUPO	  			 	  VARCHAR2(1000):=''; --EACE 02-08-2005 GES
vv_POSEE_BENEFICIO_BC15			  VARCHAR2(5);
vv_POSEE_BENEFICIO_BC24			  VARCHAR2(5);
vv_POSEE_BENEFICIO_BC33			  VARCHAR2(5);
vv_POSEE_BENEFICIO_BC99			  VARCHAR2(5);
vn_LIBE_MONTO_COBERT_ADIC_GES	  NUMBER(10):=NULL; --se agrega 30-05-2006
vv_CopagoGratis					  VARCHAR2(1):=NULL; --se agrega 30-05-2006

--ALVARO CALDERON 08/06/2006
vn_Monto_Precio_Rebajado	    	NUMBER(12,2)	:=0;
vn_Monto_Descto_Especial	    	NUMBER(12,2)	:=0;
vn_Monto_Bonif_Precio_Rebajado			NUMBER(12,2)	:=0;
vn_Precio_N1							NUMBER(12,2)	:=0;
vn_Precio_N2							NUMBER(12,2)	:=0;
vn_Precio_N3							NUMBER(12,2)	:=0;

vn_Total_Precio_Rebajado	    	NUMBER(12,2)	:=0;
vn_Total_Descto_Especial	    	NUMBER(12,2)	:=0;
vn_Total_Bonif_Precio_Rebajado			NUMBER(12,2)	:=0;
vn_Existe								NUMBER(10):=0; --se agrega 13-06-2006 - BCC
vn_Total_credito			NUMBER(10):=0;
--FIN AlVARO CALDERON

vn_PRESTACION_BONIFICADA       			NUMBER(8):=NULL; --SE AGREGA POR TOPES Y RK EACE 02/08/2006
vn_CODIGO_INTERNO_FACTURADOR			NUMBER(10):=0; --EACE 04-12-2006 CATOLICA
vn_CANTIDAD_PREST_DERIVABLES			NUMBER(10):=0; --EACE 04-12-2006 CATOLICA
vv_DERIVABLE							VARCHAR2(1):='';--EACE 04-12-2006 CATOLICA


vn_USAR_TARIFADOR_VIEJO			VARCHAR2(1):='S'; -- PGP 31/07/2007 CONVENIOS NUEVOS
vn_CORRELATIVO_CONVENIO			NUMBER:=0;		  -- PGP 31/07/2007 CONVENIOS NUEVOS
vn_CORR_LA_CONV_NUEVO			NUMBER:=0;		  -- PGP 31/07/2007 CONVENIOS NUEVOS CORRELATIVO LUGAR ATENCION EN CONVENIOS NUEVOS
vn_COD_ERROR_LA					NUMBER:=0;		  -- PGP 31/07/2007 CONVENIOS NUEVOS CODIGO ERROR EN BUSQUEDA DE LUGAR DE ATENCION
vv_DESCRIPCION_ERROR_LA			VARCHAR2(100):='';-- PGP 31/07/2007 CONVENIOS NUEVOS DESCRIPCION ERROR EN BUSQUEDA DE LUGAR DE ATENCION
vn_DESC_ERROR_UNOR_HOMOLOGADO	VARCHAR2(100):='';-- PGP 31/07/2007 CONVENIOS NUEVOS CODIGO ERROR EN BUSQUEDA DE LUGAR DE ATENCION
vv_EXISTE_LUAT					VARCHAR2(10):=''; -- PGP 03/01/2008 CONVENIOS NUEVOS CODIGO ERROR EN BUSQUEDA DE LUGAR DE ATENCION
vv_AUX_ASTERISCO				VARCHAR2(1):='';


vn_CORR_CONVENIO				NUMBER:=0;
vn_EXCLUYE_CONV					NUMBER:=0;


-- NUEVO SISTEMA DE BENEFICIOS

vn_DOLI_CORRELATIVO			    NUMBER:=0;
vn_LUAT_CORRELATIVO				NUMBER:=0;
vn_DOCO_CORRELATIVO				NUMBER:=0;
vn_CUME_CORRELATIVO				NUMBER:=0;
vn_NUMERO_PAM					NUMBER:=0;
vv_USUARIO_CREACION				VARCHAR2(50):='';
vn_UNOR_CORRELATIVO_CREACION	NUMBER:=0;
vn_PREST_CODIGO_INTERNO			 NUMBER:=0;
vn_PREST_CODIGO_INTERNO_TRAT 	 NUMBER:=0;
vn_DERIV_CODIGO_INTERNO			 NUMBER:=0;
vn_BONIF_HOSPITALARIA			 NUMBER:=0;
vn_BONIF_AMBULATORIA			 NUMBER:=0;
vn_BONIF_DENTAL					 NUMBER:=0;
vn_BONIF_MEDICAMENTOS			 NUMBER:=0;
vn_PLAN_CORRELATIVO_SIETE		 NUMBER:=0;
vn_RUT							 NUMBER:=0;
vv_DIGRUT						 VARCHAR2(1):='';
vn_TIPO_CENTRO_COSTO			 NUMBER:=0;
vn_RUT_COBRADOR_REEMBOLSO		 NUMBER:=0;
vv_DIGRUT_COBRADOR_REEMBOLSO	 VARCHAR2(1):='';
vn_NUMERO_DOCUMENTO				 NUMBER:=0;
vv_TIPO_DOCUMENTO				 VARCHAR2(20):='';
vv_FECHA_PRESTACION				 VARCHAR2(10):='';
vn_NRO_TRANSACCION				 NUMBER:=0;
vv_TIPO_PRESTACION				 VARCHAR2(20):='';
vv_IMPRESION_POR_TOPE			 VARCHAR2(1):='N';
vv_TIPO_MANUAL					 VARCHAR2(50):='';
vn_MOTIVO_MANUAL				 NUMBER:=0;
vn_DERIV_RUT					 NUMBER:=0;
vv_DERIV_DIGRUT					 VARCHAR2(1):='';
vv_TIPO_REEMBOLSO				 VARCHAR2(50):='';
vv_URGENCIA_VITAL				 VARCHAR2(10):='';
vv_USUARIO_AUT_MANUAL			 VARCHAR2(10):='';
vd_FECHA_AUT_MANUAL				 DATE:=NULL;
vv_AUT_MANUAL					 VARCHAR2(10):='';
vn_ERROR						 NUMBER:=0;
vv_DESC_ERROR					 VARCHAR2(100):='';

-- LINEAS

vn_NUMERO_LINEA					 NUMBER:=0;
vn_LN_PRISA_CODIGO				 NUMBER:=0;
vn_LN_SECO_CORRELATIVO			 NUMBER:=0;
vn_LN_DNP_CORRELATIVO			 NUMBER:=0;
vn_LN_COMPONENTE				 NUMBER:=0;
vn_LN_PRCO_CORRELATIVO			 NUMBER:=0;
vn_LN_PREST_CODIGO_INT_DET		 NUMBER:=0;
vn_LN_PREST_CODIGO_INT_TRAT		 NUMBER:=0;
vv_LN_VALOR_CONVENIDO			 VARCHAR2(20):='';
vv_LN_VALOR_FORZADO				 VARCHAR2(20):='';
vv_VALOR_COBRADO				 VARCHAR2(20):='';
vn_LN_CANTIDAD					 NUMBER:=0;
vn_LN_VALOR_COPAGO				 NUMBER:=0;
vv_LN_VALOR_PAGAR_PREST			 VARCHAR2(20):='';
vv_LN_VALOR_APLICADO			 VARCHAR2(20):='';
vv_LN_IMPRESION_POR_TOPE		 VARCHAR2(20):='';
vv_LN_COPAGO_GRATIS_GES			 VARCHAR2(20):='';
vn_LN_MONTO_COB_AD_GES	 	 	 NUMBER:=0;
vn_LN_MONTO_COB_AD_GES_CAEC  	 NUMBER:=0;
vn_LN_TOPE_CORRELATIVO			 NUMBER:=0;
vv_LN_VALOR_CONVoCOBRADO		 VARCHAR2(20):='';
vv_LN_ORDEN_DERIVACION 			 VARCHAR2(20):='';
vn_LN_TOPE_CORRELATIVO_BC		 NUMBER:=0;
vn_LN_ERROR						 NUMBER:=0;
vv_LN_DESC_ERROR				 VARCHAR2(200):='';
vn_ESLI_CORRELATIVO				 NUMBER:=0;
vn_UPDATE_ESDO_ERROR			 NUMBER:=0;
vv_UPDATE_ESDO_ERROR			 NUMBER:=0;

cur_BONO						 vCURSOR;
cur_LN_BONO						 vCURSOR;
vn_REB_CORRELATIVO				 NUMBER:=0;
vn_REB_LN_CORRELATIVO			 NUMBER:=0;
vn_CODIGO_ERROR_BUSQ_BONO		 NUMBER:=0;
vv_DESC_ERROR_BUSQ_NONO			 VARCHAR2(200):='';
vn_AUDI_CORRELATIVO				 NUMBER:=0;
vv_REB_CORRELATIVO				 VARCHAR2(30):='';
vn_LINEA_AUDI					 NUMBER:=0;
vv_LINEA_AUDI					 VARCHAR2(50):='';
vn_ERROR_TOPE					 NUMBER:=0;
vv_ERROR_TOPE					 VARCHAR2(200):='';
vn_ERROR_CARGA_REP				 NUMBER:=0;
vv_DESC_ERROR_CARGA_REP			 VARCHAR2(200):='';
vn_ERROR_DECO					 NUMBER:=0;
vv_ERROR_DECO					 VARCHAR2(200):='';
vn_ERROR_RECO					 NUMBER:=0;
vv_ERROR_RECO					 VARCHAR2(200):='';
vn_ERROR_ELI_REP				 NUMBER:=0;
vv_ERROR_ELI_REP				 VARCHAR2(500):='';
e_ELIMINA_REP					 EXCEPTION;
e_LINEA_BONO					 EXCEPTION;
e_INSERTA_BONO					 EXCEPTION;
vn_EXISTE_REP_LN				 NUMBER:=0;
vn_EXISTE_REP					 NUMBER:=0;

pon_ERROR_TOPE_PLAN				 NUMBER:=0;
pov_ERROR_TOPE_PLAN				 VARCHAR2(200):='';
e_TOPES_GRAL					 EXCEPTION;


vn_LN_GRUP_GARA_CODIGO			 NUMBER:=0;
vn_LN_GRUP_SECUENCIA			 NUMBER:=0;
vv_LN_CODIGO_GRUPO				 VARCHAR2(10):='';

vn_GaraCodigo				 	 NUMBER:=0;
vn_GrupSecuencia				 NUMBER:=0;
vv_ES_GES						 VARCHAR2(1):='';
vd_Fecha_Valorizacion			 DATE:=SYSDATE; --eace 02-02-2009
vv_MENSAJE_GES					 VARCHAR2(500):='';

vn_LN_NRO_ORDEN_DERIVACION	 NUMBER:=0;
vv_LN_SERV_DERIVACION_FULL_OFI	 VARCHAR2(1):='';
vv_LN_ATENCION VARCHAR2(100):='NORMAL';

vv_RESULTADO_INSERT_AUDITORIA	VARCHAR2(100):='';
vv_AUTO_MANUAL_SORDEN		VARCHAR2(1):=NULL;

v_vCARTILLA_GES_FF VARCHAR2(100);

v_nPLBC_CORRELATIVO		NUMBER(10);
v_nERROR			NUMBER(10);
v_vDESC_ERROR			VARCHAR2(200);

v_vTIBE_CODIGO_RECO		VARCHAR2(10);
v_nPLAN_CORRELATIVO_RECO	NUMBER(10);
v_nPLBC_CORRELATIVO_RECO	NUMBER(10);
--
vn_PLAN_CORRELATIVO_REB 	NUMBER(10):=NULL;
--
vn_EXISTE_REP_RESP		NUMBER(10):=NULL;
vn_EXISTE_REP_RESP_LN		NUMBER(10):=NULL;
--
-- TOPES BENEFICIOS NUEVOS ACTUALIZACION
CURSOR C_LIQU (pin_DOLI_CORRELATIVO IN NUMBER) IS
       SELECT LIQU.TOPE_CORRELATIVO, LIQU.TOPE_CORRELATIVO_BC
		FROM BENEFICIOS.BEN_LINEAS_LIQUIDACIONES LIQU
		WHERE
			  (NVL(LIQU.TOPE_CORRELATIVO,0)	  > 0 OR NVL(LIQU.TOPE_CORRELATIVO_BC,0) > 0) AND
			  DOLI_CORRELATIVO 				  = pin_DOLI_CORRELATIVO;


FUNCTION VALOR(p_vIN IN VARCHAR2) RETURN NUMBER IS
BEGIN
	IF p_vIN = 'S' THEN
	   RETURN 1;
	END IF;
	RETURN 0;
END VALOR;

FUNCTION SETEA_ENTRADA RETURN VARCHAR2 IS

vv_ENTRADA			   VARCHAR2(2000);

BEGIN
	vv_ENTRADA:=  SUBSTR(
				  In_nExtCodFinanciador||vv_SEPARADOR_PTO_COMA||
			      In_vExtHomNumeroConvenio||vv_SEPARADOR_PTO_COMA||
			      In_vExtHomLugarConvenio||vv_SEPARADOR_PTO_COMA||
				  In_vExtSucVenta||vv_SEPARADOR_PTO_COMA||
				  In_vExtRutConvenio||vv_SEPARADOR_PTO_COMA||
				  In_vExtRutAsociado||vv_SEPARADOR_PTO_COMA||
				  In_vExtNomPrestador||vv_SEPARADOR_PTO_COMA||
				  In_vExtRutTratante||vv_SEPARADOR_PTO_COMA||
				  In_vExtEspecialidad||vv_SEPARADOR_PTO_COMA||
				  In_vExtRutBeneficiario||vv_SEPARADOR_PTO_COMA||
				  In_vExtRutCotizante||vv_SEPARADOR_PTO_COMA||
				  In_vExtRutAcompanante||vv_SEPARADOR_PTO_COMA||
				  In_vExtRutEmisor||vv_SEPARADOR_PTO_COMA||
				  In_vExtRutCajero||vv_SEPARADOR_PTO_COMA||
				  In_vExtCodigoDiagnostico||vv_SEPARADOR_PTO_COMA||
				  In_vExtDescuentoxPlanilla||vv_SEPARADOR_PTO_COMA||
				  In_nExtMontoExcedente||vv_SEPARADOR_PTO_COMA||
				  In_vExtFechaEmision||vv_SEPARADOR_PTO_COMA||
				  In_nExtNivelConvenio||vv_SEPARADOR_PTO_COMA||
				  In_nExtFolioFinanciador||vv_SEPARADOR_PTO_COMA||
				  In_nExtMontoValorTotal||vv_SEPARADOR_PTO_COMA||
				  In_nExtMontoAporteTotal||vv_SEPARADOR_PTO_COMA||
				  In_nExtMontoCopagoTotal||vv_SEPARADOR_PTO_COMA||
				  In_nExtNumOperacion||vv_SEPARADOR_PTO_COMA||
				  In_nExtCorrPrestacion||vv_SEPARADOR_PTO_COMA||
				  In_nExtTipoSolicitud||vv_SEPARADOR_PTO_COMA||
				  In_vExtFechaInicio||vv_SEPARADOR_PTO_COMA||
				  In_vExtUrgencia||vv_SEPARADOR_PTO_COMA||
				  In_vExtPlan||vv_SEPARADOR_PTO_COMA||
				  In_vExtLista1||vv_SEPARADOR_PTO_COMA||
				  In_vExtLista2||vv_SEPARADOR_PTO_COMA||
				  In_vExtLista3||vv_SEPARADOR_PTO_COMA,1,2000);
	RETURN vv_ENTRADA;
END SETEA_ENTRADA;


FUNCTION SETEA_vn_SALIDA RETURN VARCHAR2 IS

vv_SALIDA	   VARCHAR2(2000);

BEGIN
	vv_SALIDA:=   SRV_Message||vv_SEPARADOR_PTO_COMA||
				  Out_vExtCodError||vv_SEPARADOR_PTO_COMA||
				  Out_vExtMensajeError||vv_SEPARADOR_PTO_COMA||vv_MensajeError||vv_SEPARADOR_PTO_COMA;

	RETURN vv_SALIDA;
END SETEA_vn_SALIDA;


BEGIN	 -- PROGRAMA PRINCIPAL
	vn_BANDERA:=9999;
	vn_BANDERA:=10000;
	vd_FECHA_LLEGADA:=SYSDATE;
	vv_PARAMETROS_ENTRADA := SETEA_ENTRADA;
	DBMS_OUTPUT.PUT_LINE ('01');
	DBMS_OUTPUT.PUT_LINE ( 'In_nExtCodFinanciador= ' || In_nExtCodFinanciador );
	v_nExtCodFinanciador := In_nExtCodFinanciador;

	DBMS_OUTPUT.PUT_LINE ('02');
	vn_BANDERA:=0.05;
	-- Si el codigo no corresponde a Convn_SALud
	DBMS_OUTPUT.PUT_LINE ( 'v_nExtCodFinanciador= ' || v_nExtCodFinanciador );
	DBMS_OUTPUT.PUT_LINE ( 'vn_CODIGO_ISAPRE_CONSALUD= ' || vn_CODIGO_ISAPRE_CONSALUD );

	IF ( v_nExtCodFinanciador != vn_CODIGO_ISAPRE_CONSALUD ) THEN
		RAISE e_ISAPRE_NO_CORRESPONDE;
	END IF;
	vn_BANDERA:=100;
	v_vExtHomNumeroConvenio := RTRIM(In_vExtHomNumeroConvenio);
	vn_BANDERA:=101;
	v_vExtHomLugarConvenio	:= In_vExtHomLugarConvenio;
	vn_BANDERA:=102;
	v_vExtSucVenta := In_vExtSucVenta;
	vn_BANDERA:=103;
	v_vExtRutConvenio := In_vExtRutConvenio;
	vn_BANDERA:=104;
	v_vExtRutAsociado := In_vExtRutAsociado;
	vn_BANDERA:=105;
	v_vExtNomPrestador := In_vExtNomPrestador;
	vn_BANDERA:=106;
	v_vExtRutTratante := In_vExtRutTratante;
	vn_BANDERA:=107;
	v_vExtEspecialidad := In_vExtEspecialidad ;
	vn_BANDERA:=108;
	v_vExtRutBeneficiario := In_vExtRutBeneficiario;
	vn_BANDERA:=109;
	v_vExtRutCotizante := In_vExtRutCotizante;
	vn_BANDERA:=110;
	v_vExtRutAcompanante := In_vExtRutAcompanante ;
	vn_BANDERA:=111;
	v_vExtRutEmisor := In_vExtRutEmisor;
	vn_BANDERA:=112;
	v_vExtRutCajero := In_vExtRutCajero;
	vn_BANDERA:=113;
	v_vExtCodigoDiagnostico := In_vExtCodigoDiagnostico;
	vn_BANDERA:=114;
	v_vExtDescuentoXPlanilla := In_vExtDescuentoXPlanilla;
	vn_BANDERA:=115;
	v_nExtMontoExcedente := In_nExtMontoExcedente;
	vn_BANDERA:=116;
	v_dExtFechaEmision := TO_DATE ( SUBSTR(In_vExtFechaEmision,1,14), 'RRRRMMDDHH24MISS' );
	vn_BANDERA:=117;
	v_nExtNivelConvenio := In_nExtNivelConvenio;
	vn_BANDERA:=118;
	v_nExtFolioFinanciador := In_nExtFolioFinanciador;
	vn_BANDERA:=119;
	v_nExtMontoValorTotal := In_nExtMontoValorTotal;
	vn_BANDERA:=120;
	v_nExtMontoAporteTotal := In_nExtMontoAporteTotal;
	vn_BANDERA:=121;
	v_nExtMontoCopagoTotal := In_nExtMontoCopagoTotal;
	vn_BANDERA:=122;
	v_nExtNumOperacion := In_nExtNumOperacion;
	vn_BANDERA:=123;
	v_nExtCorrPrestacion := In_nExtCorrPrestacion;
	vn_BANDERA:=124;
	v_nExtTipoSolicitud := In_nExtTipoSolicitud;
	vn_BANDERA:=125;
	v_dExtFechaInicio := TO_DATE ( SUBSTR(In_vExtFechaInicio,1,14), 'RRRRMMDDHH24MISS' );
	vn_BANDERA:=126;
	v_vExtUrgencia := In_vExtUrgencia;
	vn_BANDERA:=127;
	v_vExtPlan := RPAD(In_vExtPlan,15,' ');
	vn_BANDERA:=128;
	v_vExtLista1 := In_vExtLista1;
	vn_BANDERA:=129;
	v_vExtLista2 := In_vExtLista2;
	vn_BANDERA:=130;
	v_vExtLista3 := In_vExtLista3;
	vn_BANDERA:=140;
	vn_BANDERA:=141;
	--IMED
	--  w9110_numtra  :=
	--  w9110_numsec  :=
	--  w9110_fecha   :=
	vn_CODIGO_ISAPRE  := v_nExtCodFinanciador;
	vn_BANDERA:=142;
	--  w9110_prtnum  :=
	vn_RUT_PRESTADOR  := TO_NUMBER(NVL(SUBSTR(v_vExtRutTratante,1,10),0));
	vn_BANDERA:=143;
	vn_RUT_PRESTADOR_FACTURADOR  := TO_NUMBER(NVL(SUBSTR(v_vExtRutConvenio,1,10),0));
	vn_BANDERA:=144;
	--  w9110_espcod  :=
	vv_CODIGO_ESPECILIDAD_HOMOLOG  := SUBSTR(RTRIM(v_vExtEspecialidad),1,5);
	vn_BANDERA:=145;
	--jorge mu?oz 21/02/2003
	-- MJBV 2/6/2003  vn_LUGAR_DE_PRESTACION  := v_vExtHomLugarConvenio;--Confirmar equivalencia
	vn_BANDERA:=146;
	vn_RUT_PRESTADOR_SOLICITANTE := TO_NUMBER(NVL(SUBSTR(v_vExtRutAsociado,1,10),0));
	vn_BANDERA:=147;
	vn_RUT_COTIZANTE  := TO_NUMBER(NVL(SUBSTR(v_vExtRutCotizante,1,10),0));
	vn_BANDERA:=148;
	--  vn_CODIGO_CARGA :=
	vn_RUT_BENEFICIARIO  := TO_NUMBER(NVL(SUBSTR(v_vExtRutBeneficiario,1,10),0)); -- alterar potenciales consultas para accesar tabla de homologos
	vn_BANDERA:=149;
	-- New Rut Cotizante 'CTC'

	vn_CORRELATIVO_CONVENIO:=TO_NUMBER(v_vExtHomNumeroConvenio);
	vv_EXISTE_LUAT:=Pck_Cm_Imed_Nuevo3.f_prestadorExisteLUAT(vn_RUT_PRESTADOR_FACTURADOR,v_vExtHomLugarConvenio);

	IF vv_EXISTE_LUAT = 'N' THEN

		-- VALIDA SI USAR TARIFICADOR NUEVOS CONVENIOS O ANTIGO PGP 31/07/2007
		Pck_Cm_Imed_Nuevo3.P_LUGAR_ATENCIONES_VERSION2 ( vn_RUT_PRESTADOR_FACTURADOR,
													     vn_CORRELATIVO_CONVENIO,
														 vn_CORR_LA_CONV_NUEVO,
													     -- vn_CORR_CONVENIO,
										 		 	     --vn_EXCLUYE_CONV,
														  vn_COD_ERROR_LA,
														  vv_DESCRIPCION_ERROR_LA );

	   DBMS_OUTPUT.PUT_LINE ( 'vn_CORR_LA_CONV_NUEVO= ' || vn_CORR_LA_CONV_NUEVO );
	--   vn_CORR_CONVENIO:=	1;
	   DBMS_OUTPUT.PUT_LINE ( 'vn_CORR_CONVENIO= ' || vn_CORR_CONVENIO );
	   vv_AUX_ASTERISCO := '';

	ELSE
			DBMS_OUTPUT.PUT_LINE ( ' PROCESO NUEVO ' );
			vn_CORR_LA_CONV_NUEVO:= TO_NUMBER(v_vExtHomLugarConvenio);
	--		vn_CORR_CONVENIO:=	vn_CORRELATIVO_CONVENIO;
			vv_AUX_ASTERISCO := '*';
	END IF;

	IF NVL(vn_CORR_LA_CONV_NUEVO,0) = 0 THEN
	   vn_USAR_TARIFADOR_VIEJO:='S';
	ELSE
	   vn_USAR_TARIFADOR_VIEJO:='N';
	   vv_NOMBRE_TRANSACCION:=vv_NOMBRE_TRANSACCION||'*'||vv_AUX_ASTERISCO;
	END IF;
	DBMS_OUTPUT.PUT_LINE ( 'vn_USAR_TARIFADOR_VIEJO= ' || vn_USAR_TARIFADOR_VIEJO );
	-- VALIDA SI USAR TARIFICADOR NUEVOS CONVENIOS O ANTIGO PGP 31/07/2007
	-- VALIDAR ERRORES DEL P_LUGAR_ATENCION



	/* loop para calculo de bonificacion por linea de detalle del bono*/
	--********************************************************************************************
	--********************************************************************************************
	--Concatenar Listas 1, 2 y 3
	-- Una linea 19 pipe
	v_vExtLista:= NULL;
	vn_BANDERA:=8.1;

	BEGIN

		IF LTRIM(RTRIM(Saca_String(v_vExtLista1,v_vSeparador,1))) IS NOT NULL THEN
			vn_CANT_LINEAS:=1;
			FOR j IN 1 .. 19 LOOP
				v_vExtLista := v_vExtLista||Saca_String(v_vExtLista1,v_vSeparador,j)||v_vSeparador;
			END LOOP;

			vn_BANDERA:=8.2;

			IF LTRIM(RTRIM(Saca_String(v_vExtLista1,v_vSeparador,20))) IS NOT NULL THEN
				vn_CANT_LINEAS:=2;

				FOR j IN 20 ..38 LOOP
					v_vExtLista := v_vExtLista||Saca_String(v_vExtLista1,v_vSeparador,j)||v_vSeparador;
				END LOOP;

			END IF;
		END IF;

		vn_BANDERA:=8.3;

		IF LTRIM(RTRIM(Saca_String(v_vExtLista2,v_vSeparador,1))) IS NOT NULL THEN

		vn_CANT_LINEAS:=3;
			FOR j IN 1 .. 19 LOOP
				v_vExtLista := v_vExtLista||Saca_String(v_vExtLista2,v_vSeparador,j)||v_vSeparador;
			END LOOP;

		vn_BANDERA:=8.4;

			IF LTRIM(RTRIM(Saca_String(v_vExtLista2,v_vSeparador,20))) IS NOT NULL THEN
				vn_CANT_LINEAS:=4;

				FOR j IN 20 ..38 LOOP
					v_vExtLista := v_vExtLista||Saca_String(v_vExtLista2,v_vSeparador,j)||v_vSeparador;
				END LOOP;

			END IF;
		END IF;

		vn_BANDERA:=8.5;
		IF LTRIM(RTRIM(Saca_String(v_vExtLista3,v_vSeparador,1))) IS NOT NULL THEN
			vn_CANT_LINEAS:=5;

			FOR j IN 1 .. 19 LOOP
				v_vExtLista := v_vExtLista||Saca_String(v_vExtLista3,v_vSeparador,j)||v_vSeparador;
			END LOOP;

			vn_BANDERA:=8.6;

			IF LTRIM(RTRIM(Saca_String(v_vExtLista3,v_vSeparador,20))) IS NOT NULL THEN
				vn_CANT_LINEAS:=6;

				FOR j IN 20 ..38 LOOP
					v_vExtLista := v_vExtLista||Saca_String(v_vExtLista3,v_vSeparador,j)||v_vSeparador;
				END LOOP;
			END IF;
		END IF;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE e_FORMATO_LISTAS;
	END;

	IF v_vExtLista IS NULL THEN
		RAISE e_EXISTE_LISTA;
	END IF;



	FOR z IN 1..vn_CANT_LINEAS LOOP
		vn_CODIGO_PRESTACION_HOMOLOG:= TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-18)); -- codigo prestacion
		SELECT COUNT(*)
		INTO   vn_CANTIDAD_PREST_DERIVABLES
		FROM   PLN_PRESTACIONES_ISAPRE preis
		WHERE  preis.codigo = vn_CODIGO_PRESTACION_HOMOLOG
		AND    preis.derivable = 'S';

		IF  vn_CANTIDAD_PREST_DERIVABLES <> 0 THEN
			vv_DERIVABLE:= 'S';
			EXIT;
		END IF;
	END LOOP;


	--04-12-2006 TEMA CATOLICA
	IF vv_DERIVABLE = 'S' THEN
	   vn_RUT_PRESTADOR:= vn_RUT_PRESTADOR_FACTURADOR;
	END IF;

	BEGIN
		IF vn_USAR_TARIFADOR_VIEJO = 'S' THEN
			SELECT CODIGO_INTERNO
			INTO   vn_CODIGO_INTERNO_FACTURADOR
			FROM   CON_PRESTADORES
			WHERE  RUT = vn_RUT_PRESTADOR_FACTURADOR;
		ELSE
			vn_CODIGO_INTERNO_FACTURADOR := Pck_Cm_Imed_Nuevo3.F_Sacaprestcodigointerno(vn_RUT_PRESTADOR_FACTURADOR);
		END IF;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			vn_BANDERA:=53;
			vn_SAL:=1;
			--		  	Out_vExtCodError 		 := 'S';
			Out_vExtCodError 		 := 'N';
			Out_vExtMensajeError 	 := 'Problemas en Prestador Convenio, no existe o s/convenio';
			vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
			--	  	  	vv_OUTPUT_CODIGO_MENSAJE   	 	 := '78004';
			vv_OUTPUT_CODIGO_MENSAJE   	 	 := '00000';
			--		  	vv_OUTPUT_STATUS_SERVICIO		 := '0';
			vv_OUTPUT_STATUS_SERVICIO		 := '1';
			SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
			vv_PARAMETROS_SALIDA  := SETEA_vn_SALIDA;
			vd_FECHA_SALIDA:=SYSDATE;
			vn_BANDERA:=54;
			vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,
						    v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
										TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),
										v_nFolio_Suscripcion,vn_CODIGO_CARGA,v_nExtFolioFinanciador,v_nExtMontoValorTotal,NULL,
										v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,
										vd_FECHA_LLEGADA,vd_FECHA_SALIDA,(vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),
										vn_MONTO_BCC,VALOR(vn_CON_EXCEDENTE),v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),
										vn_MONTO_SEGURO_TERCERO);
			vn_BANDERA:=55;
			RETURN;
	END;


	DBMS_OUTPUT.PUT_LINE ('___________________________________________________');
	BEGIN
		v_vResp := Imed_Beneficiario_Cotizante (vn_RUT_BENEFICIARIO,
												v_nFolio_Suscripcion,
												vn_RUT_COTIZANTE,
												Out_n,
												vn_CODIGO_CARGA,
												v_ncoderror,
												v_vgloerror);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE err_Imed_Bene_Coti;
	END;

	IF  v_vResp = 1 THEN
		RAISE err_v_vResp;
	END IF;




	DBMS_OUTPUT.PUT_LINE ('CTC Rut Cotizante :');
	DBMS_OUTPUT.PUT_LINE ('___________________________________________________');
	--------------------------------------------------------------------------CTC
	vn_BANDERA:=150;
	--  w9110_ctzplan :=
	--  w9110_prtaut  :=
	--  w9110_pggcop  :=
	--  w9110_pggfin  :=

	vn_CODIGO_TERMINAL := v_vExtHomLugarConvenio;

	vn_BANDERA:=151;

	--  w9110_prtts   := SYSDATE;
	--  vn_CANT_LINEAS  :=NULL; -- CANTIDAD DE LINEAS, CALCULADO MAS ABAJO
	vn_MONTO_COPAGO_EXCEDENTE := v_nExtMontoExcedente;
	vn_BANDERA:=152;

	--  vn_COPAGO_BENEFICIO_COMP := NULL;--copago cta corriente beneficio complementario , calculado mas abajo
	--  w9110_prtdcpsc:= NULL;--copago seguro catastrofico
	BEGIN
		--  vn_UNOR_CORRELATIVO_ISAPRE	:= NULL;-- numero de isapre (unor correlativo)

		IF  NVL(TO_NUMBER(v_vExtSucVenta),0) = 0 THEN
			vn_UNOR_CORRELATIVO_ISAPRE:= 700; --23;ctc
		ELSE
			vn_UNOR_CORRELATIVO_ISAPRE:= TO_NUMBER(v_vExtSucVenta);
		END IF;

	END;

	vn_BANDERA:=153;


	vn_BANDERA:=1;

	vn_CENTRO_ATENCION:= vn_UNOR_CORRELATIVO_ISAPRE;

	BEGIN
		IF vn_USAR_TARIFADOR_VIEJO = 'S' THEN

			SELECT cofi.unor_correlativo
			INTO   vn_UNOR_CORRELATIVO_CEN_ATEN
			FROM   con_convenios_finales cofi
			WHERE  cofi.correlativo = v_vExtHomNumeroConvenio
			;
		ELSE
			DBMS_OUTPUT.PUT_LINE ( 'vn_CORR_LA_CONV_NUEVO= ' || vn_CORR_LA_CONV_NUEVO );
			vn_UNOR_CORRELATIVO_CEN_ATEN:= Pck_Cm_Imed_Nuevo3.f_Unor_Homologado( vn_CORR_LA_CONV_NUEVO,vn_DESC_ERROR_UNOR_HOMOLOGADO);

			IF vn_UNOR_CORRELATIVO_CEN_ATEN = 0 THEN

			    vn_UNOR_CORRELATIVO_CEN_ATEN:= NULL;
			    /*Out_vExtCodError 		 := 'N';
				Out_vExtMensajeError 	 := vn_DESC_ERROR_UNOR_HOMOLOGADO;
				vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
				--	  	  				vv_OUTPUT_CODIGO_MENSAJE   	 	 := '78003';
				vv_OUTPUT_CODIGO_MENSAJE   	 	 := '00000';
				--		  				vv_OUTPUT_STATUS_SERVICIO		 := '0';
				vv_OUTPUT_STATUS_SERVICIO		 := '1';
				SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
				vv_PARAMETROS_SALIDA  := SETEA_vn_SALIDA;
				vd_FECHA_SALIDA:=SYSDATE;
				vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),
				TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,v_nExtFolioFinanciador,v_nExtMontoValorTotal,NULL,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,
				vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,vd_FECHA_LLEGADA,vd_FECHA_SALIDA,(vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC,VALOR(vn_CON_EXCEDENTE),v_nExtMontoExcedente,
				VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),vn_MONTO_SEGURO_TERCERO);
				RETURN;*/


			END IF;
		END IF;
	EXCEPTION
		WHEN OTHERS THEN
			vn_UNOR_CORRELATIVO_CEN_ATEN:= NULL;
	END;

	vn_BANDERA:=2;

	dbms_output.put_line('	antes de accesar beneficiario: '||vn_RUT_BENEFICIARIO||'  '||vn_RUT_COTIZANTE||'  '||vn_CODIGO_CARGA);
	-- saco correlativo del plan
	BEGIN
		SELECT ben2.coaf_folio_suscripcion,
			   ben2.coaf_orga_codigo_isapre,
			   ben2.bencomcol,
			   coaf.plan_correlativo,
			   PLAN.plan_type,
			   PLAN.dom_correlativo,
			   DECODE(ben2.aseg_correlativo,NULL,0,ben2.aseg_correlativo),
			   DECODE(ben2.relacion,NULL,'T',ben2.relacion)
		  INTO vn_COAF_FOLIO_SUSCRIPCION,
		  	   vn_COD_ISAPRE,
		  	   vv_BENEFICIOS_COMP,
			   vn_PLAN_CORRELATIVO,
			   vv_TIPO_PLAN,
			   vn_DOM_CORRELATIVO,
			   vv_ASEG_CORRELATIVO,
			   vv_RELACION
		  FROM afi_personas  per1,
		  	   afi_personas  per2,
		  	   afi_beneficiarios_contrato  ben1,
			   afi_beneficiarios_contrato  ben2,
			   afi_contratos_afiliados  coaf,
			   PLN_PLANES  PLAN
		 WHERE per1.rut = vn_RUT_COTIZANTE
		   AND ben1.pers_correlativo = per1.correlativo
		   AND ben2.coaf_folio_suscripcion = ben1.coaf_folio_suscripcion
		   AND per2.correlativo = ben2.pers_correlativo
		   AND ben2.codigo_carga = vn_CODIGO_CARGA
		   AND coaf.folio_suscripcion = ben2.coaf_folio_suscripcion
		   AND coaf.orga_codigo_isapre = ben2.coaf_orga_codigo_isapre
		   AND PLAN.correlativo = coaf.plan_correlativo;

		vn_BANDERA:=3;


	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			BEGIN
				SELECT	ben2.coaf_folio_suscripcion,
						ben2.coaf_orga_codigo_isapre,
						ben2.bencomcol,
						coaf.plan_correlativo,
						PLAN.plan_type,
						DECODE(ben2.aseg_correlativo,NULL,0,ben2.aseg_correlativo),
						DECODE(ben2.relacion,NULL,'T',ben2.relacion)
				INTO 	vn_COAF_FOLIO_SUSCRIPCION,
						vn_COD_ISAPRE,
						vv_BENEFICIOS_COMP,
						vn_PLAN_CORRELATIVO,
						vv_TIPO_PLAN,
						vv_ASEG_CORRELATIVO,
						vv_RELACION
				FROM 	afi_personas  per1,
						afi_personas  per2,
						afi_beneficiarios_contrato  ben1,
						afi_beneficiarios_contrato  ben2,
						afi_contratos_afiliados  coaf,
						PLN_PLANES  PLAN
				WHERE 	per1.rut = vn_RUT_COTIZANTE
				AND 	ben1.pers_correlativo = per1.correlativo
				AND 	ben2.coaf_folio_suscripcion = ben1.coaf_folio_suscripcion
				AND 	per2.correlativo = ben2.pers_correlativo
				AND 	ben2.codigo_carga = vn_CODIGO_CARGA
				AND 	coaf.folio_suscripcion = ben2.coaf_folio_suscripcion
				AND 	coaf.orga_codigo_isapre = ben2.coaf_orga_codigo_isapre
				AND 	PLAN.correlativo = coaf.plan_correlativo;

				vn_BANDERA:=4;
			EXCEPTION
				WHEN OTHERS THEN
					--		  				Out_vExtCodError 		 := 'S';
					Out_vExtCodError 		 := 'N';
					Out_vExtMensajeError 	 := 'Problemas al buscar el folio del afiliado';
					vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
					--	  	  				vv_OUTPUT_CODIGO_MENSAJE   	 	 := '78003';
					vv_OUTPUT_CODIGO_MENSAJE   	 	 := '00000';
					--		  				vv_OUTPUT_STATUS_SERVICIO		 := '0';
					vv_OUTPUT_STATUS_SERVICIO		 := '1';
					SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;

TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					vv_PARAMETROS_SALIDA  := SETEA_vn_SALIDA;
					vd_FECHA_SALIDA:=SYSDATE;
					vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),
					TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,v_nExtFolioFinanciador,v_nExtMontoValorTotal,NULL,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,
					vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,vd_FECHA_LLEGADA,vd_FECHA_SALIDA,(vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC,VALOR(vn_CON_EXCEDENTE),v_nExtMontoExcedente,
					VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),vn_MONTO_SEGURO_TERCERO);
					RETURN;
			END;
	END;

	vn_BANDERA:=5;

	-- Consulta prestador
	BEGIN
		vn_BANDERA:=51;

		IF vn_USAR_TARIFADOR_VIEJO = 'S' THEN
			SELECT DISTINCT prest.codigo_interno
			INTO   vn_CODIGO_PRESTADOR
			FROM   CON_PRESTADORES PREST
			WHERE  RUT = vn_RUT_PRESTADOR;
		ELSE
			vn_CODIGO_PRESTADOR := Pck_Cm_Imed_Nuevo3.F_Sacaprestcodigointerno(vn_RUT_PRESTADOR);
		END IF;
		vn_BANDERA:=52;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			vn_BANDERA:=53;
			vn_SAL:=1;
			--		  	Out_vExtCodError 		 := 'S';
			Out_vExtCodError 		 := 'N';
			Out_vExtMensajeError 	 := 'Problemas en Prestador, no existe o s/convenio';
			vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
			--	  	  	vv_OUTPUT_CODIGO_MENSAJE   	 	 := '78004';
			vv_OUTPUT_CODIGO_MENSAJE   	 	 := '00000';
			--		  	vv_OUTPUT_STATUS_SERVICIO		 := '0';
			vv_OUTPUT_STATUS_SERVICIO		 := '1';
			SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
			vv_PARAMETROS_SALIDA  := SETEA_vn_SALIDA;
			vd_FECHA_SALIDA:=SYSDATE;
			vn_BANDERA:=54;
			vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,
						    v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
										TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),
										v_nFolio_Suscripcion,vn_CODIGO_CARGA,v_nExtFolioFinanciador,v_nExtMontoValorTotal,NULL,
										v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,
										vd_FECHA_LLEGADA,vd_FECHA_SALIDA,(vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),
										vn_MONTO_BCC,VALOR(vn_CON_EXCEDENTE),v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),
										vn_MONTO_SEGURO_TERCERO);
			vn_BANDERA:=55;
			RETURN;

	END;

	vn_BANDERA:=6;

	-- VALIDACION DEL RUT DEL SOLICITANTE
	-- saca el codigo interno del medico solicitante

	BEGIN

		IF vn_USAR_TARIFADOR_VIEJO = 'S' THEN
			SELECT DISTINCT prest.codigo_interno
			INTO   vn_CODIGO_MED_SOLICITANTE
			FROM   CON_PRESTADORES PREST
			WHERE  rut = vn_RUT_PRESTADOR_SOLICITANTE;
		ELSE
			vn_CODIGO_MED_SOLICITANTE := Pck_Cm_Imed_Nuevo3.F_Sacaprestcodigointerno(vn_RUT_PRESTADOR_SOLICITANTE);
		END IF;

	EXCEPTION
		WHEN OTHERS THEN
			vn_CODIGO_MED_SOLICITANTE:= 0;
	END;

	vn_BANDERA:=7;


	vn_DOBE_CORRELATIVO := v_nExtFolioFinanciador;
		vn_BANDERA:=8;

	vn_BANDERA:=8.7;
	v_nMonto_Bcc :=0;
	v_nMonto_Cigna := 0;
	-- Extrae monto bcc o cigna

	--EACE 28-06-2005 --GES
	vv_CODIGO_SUB_GRUPO := PCK_GESARA_100_BONIFICACIONES.F_BENEF_POSEE_GES ( v_nExtCodFinanciador, vn_COAF_FOLIO_SUSCRIPCION, vn_CODIGO_CARGA, vn_CODIGO_PRESTADOR );

	IF vv_CODIGO_SUB_GRUPO <> 'N' THEN
		vn_COD_GARANTIA  := SUBSTR(vv_CODIGO_SUB_GRUPO,1,INSTR(vv_CODIGO_SUB_GRUPO,',')-1) ;
		vn_GRUPO_SEQ 	 := SUBSTR(SUBSTR(vv_CODIGO_SUB_GRUPO,INSTR(vv_CODIGO_SUB_GRUPO,',')+1),1,INSTR(SUBSTR(vv_CODIGO_SUB_GRUPO,INSTR(vv_CODIGO_SUB_GRUPO,',')+1),',')-1);
		--vn_SUB_GRUPO_SEQ := SUBSTR(SUBSTR(SUBSTR(vv_CODIGO_SUB_GRUPO,INSTR(vv_CODIGO_SUB_GRUPO,',')+1),INSTR(vv_CODIGO_SUB_GRUPO,',')+1),1,INSTR(SUBSTR(vv_CODIGO_SUB_GRUPO,INSTR(vv_CODIGO_SUB_GRUPO,',')+1),',')-1);

		vv_SIN_GRANTIA	  := SUBSTR(vv_CODIGO_SUB_GRUPO, INSTR(vv_CODIGO_SUB_GRUPO,',')+1);
		vv_SIN_GRUPO	  := SUBSTR(vv_SIN_GRANTIA, INSTR(vv_SIN_GRANTIA,',')+1);
		vn_SUB_GRUPO_SEQ  := SUBSTR(vv_SIN_GRUPO,1,INSTR(vv_SIN_GRUPO,';')-1);
		vv_CODIGO_GRUPO	 := PCK_GESARA_100_BONIFICACIONES.F_RET_COD_GRUPO_SUBGRUPO ( vv_CODIGO_SUB_GRUPO );
	END IF;
	--EACE 28-06-2005 --GES

	-- PGP 29/12/2005 BC15


	--vn_CODIGO_ISAPRE		NUMBER(4):=0;	   -- codigo de la isapre
	--vn_RUT_PRESTADOR		NUMBER(9):=0;	   -- rut del prestador que presta la atencion
	--vn_RUT_PRESTADOR_FACTURADOR		   NUMBER(9):=0;	   -- rut del prestador que factura la atencion
	DBMS_OUTPUT.PUT_LINE ( 'vn_COAF_FOLIO_SUSCRIPCION= ' || vn_COAF_FOLIO_SUSCRIPCION );
	DBMS_OUTPUT.PUT_LINE ( 'vn_CODIGO_ISAPRE= ' || vn_CODIGO_ISAPRE );
	DBMS_OUTPUT.PUT_LINE ( 'vn_RUT_PRESTADOR_FACTURADOR= ' || vn_RUT_PRESTADOR_FACTURADOR );
	vv_POSEE_BENEFICIO_BC15:=Pck_Imed_Benef_Comp.F_IMED_POSEE_BENEF_BC(vn_COAF_FOLIO_SUSCRIPCION, vn_CODIGO_ISAPRE,vn_RUT_PRESTADOR_FACTURADOR,vd_Fecha_Valorizacion);
	vv_POSEE_BENEFICIO_BC24:=Pck_Imed_Benef_Comp.F_IMED_POSEE_BENEF_BC(vn_COAF_FOLIO_SUSCRIPCION, vn_CODIGO_ISAPRE,vn_RUT_PRESTADOR_FACTURADOR,vd_Fecha_Valorizacion);
	vv_POSEE_BENEFICIO_BC33:=Pck_Imed_Benef_Comp.F_IMED_POSEE_BENEF_BC(vn_COAF_FOLIO_SUSCRIPCION, vn_CODIGO_ISAPRE,vn_RUT_PRESTADOR_FACTURADOR,vd_Fecha_Valorizacion);
/* INICIO BNF-000955 BC 99 Rut 88.888.889-6*/
	vv_POSEE_BENEFICIO_BC99:=Pck_Imed_Benef_Comp.F_IMED_POSEE_BENEF_BC(vn_COAF_FOLIO_SUSCRIPCION, vn_CODIGO_ISAPRE,vn_RUT_PRESTADOR_FACTURADOR,vd_Fecha_Valorizacion);
/* FIN BNF-000955 BC 99 Rut 88.888.889-6*/

	-- PGP 29/12/2005 BC15

	FOR z IN 1..vn_CANT_LINEAS LOOP

		-- Posicion 3

		v_vCARTILLA_GES_FF := Saca_String(v_vExtLista,v_vSeparador,(z*19)-16);--pos 3
		-- Posicion 10 y 11

		v_nTipoBonificacion := Saca_String(v_vExtLista,v_vSeparador,(z*19)-9);--pos 10
		v_nMontoBonificacion := NVL(TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-8)),0);--pos 11


		IF  v_nTipoBonificacion= 1 THEN
			v_nMonto_Bcc := v_nMonto_Bcc +	v_nMontoBonificacion ;
		ELSIF v_nTipoBonificacion = 2 THEN
			v_nMonto_Cigna := v_nMonto_Cigna + v_nMontoBonificacion;
		ELSIF v_nTipoBonificacion = 3 THEN
			vn_Total_Descto_Especial:= vn_Total_Descto_Especial + v_nMontoBonificacion;
	ELSIF v_nTipoBonificacion = 5 THEN
	    vn_Total_credito:= vn_Total_credito + v_nMontoBonificacion;
	END IF;

		-- Posicion 12 y 13
		v_nTipoBonificacion := Saca_String(v_vExtLista,v_vSeparador,(z*19)-7);--pos 12
		v_nMontoBonificacion := NVL(TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-6)),0);--pos 13

		IF  v_nTipoBonificacion= 1 THEN
			v_nMonto_Bcc := v_nMonto_Bcc +	v_nMontoBonificacion ;
		ELSIF v_nTipoBonificacion = 2 THEN
			v_nMonto_Cigna := v_nMonto_Cigna + v_nMontoBonificacion;
		ELSIF v_nTipoBonificacion = 3 THEN
			vn_Total_Descto_Especial:= vn_Total_Descto_Especial + v_nMontoBonificacion;
	ELSIF v_nTipoBonificacion = 5 THEN
	    vn_Total_credito:= vn_Total_credito + v_nMontoBonificacion;
	END IF;

		-- Posicion 14 y 15

		-- ALVARO CALDERON 08/06/2006
		DBMS_OUTPUT.PUT_LINE ( '--- Validacion Especial UNO---- ' );
		DBMS_OUTPUT.PUT_LINE ( ' ------------------------------- ' );
-- 		v_nTipoBonificacion := Saca_String(v_vExtLista,v_vSeparador,(z*19)-5);--pos 14
-- 		v_nMontoBonificacion := NVL(TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-4)),0);--pos 15
--
-- 		IF  v_nTipoBonificacion= 1 THEN
-- 			v_nMonto_Bcc := v_nMonto_Bcc +	v_nMontoBonificacion ;
-- 		ELSIF v_nTipoBonificacion = 2 THEN
-- 			v_nMonto_Cigna := v_nMonto_Cigna + v_nMontoBonificacion;
-- 		END IF;

		v_nTipoBonificacion := Saca_String(v_vExtLista,v_vSeparador,(z*19)-5);--pos 14

		v_nMontoBonificacion := NVL(TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-4)),0); --pos 15

		DBMS_OUTPUT.PUT_LINE ( 'v_nTipoBonificacion= ' || v_nTipoBonificacion );
		DBMS_OUTPUT.PUT_LINE ( 'v_nMontoBonificacion= ' || v_nMontoBonificacion );

		IF  v_nTipoBonificacion= 1 THEN
			v_nMonto_Bcc := v_nMonto_Bcc +	v_nMontoBonificacion ;
		ELSIF v_nTipoBonificacion = 2 THEN
			v_nMonto_Cigna := v_nMonto_Cigna + v_nMontoBonificacion;
		ELSIF v_nTipoBonificacion = 3 THEN
			vn_Total_Descto_Especial:= vn_Total_Descto_Especial + v_nMontoBonificacion;
	ELSIF v_nTipoBonificacion = 5 THEN
	    vn_Total_credito:= vn_Total_credito + v_nMontoBonificacion;
	END IF;

		DBMS_OUTPUT.PUT_LINE ( 'vn_Total_Descto_Especial UNO= ' || vn_Total_Descto_Especial );
		-- FIN ALVARO CALDERON

		-- Posicion 16 y 17
		v_nTipoBonificacion := Saca_String(v_vExtLista,v_vSeparador,(z*19)-3);--pos 16
		v_nMontoBonificacion := NVL(TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-2)),0);--pos 17

		IF  v_nTipoBonificacion= 1 THEN
			v_nMonto_Bcc := v_nMonto_Bcc +	v_nMontoBonificacion ;
		ELSIF v_nTipoBonificacion = 2 THEN
			v_nMonto_Cigna := v_nMonto_Cigna + v_nMontoBonificacion;
		ELSIF v_nTipoBonificacion = 3 THEN
			vn_Total_Descto_Especial:= vn_Total_Descto_Especial + v_nMontoBonificacion;
	ELSIF v_nTipoBonificacion = 5 THEN
	    vn_Total_credito:= vn_Total_credito + v_nMontoBonificacion;
	END IF;

		-- Posicion 18 y 19
		v_nTipoBonificacion := Saca_String(v_vExtLista,v_vSeparador,(z*19)-1);--pos 18
		v_nMontoBonificacion := NVL(TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-0)),0);--pos 19

		IF  v_nTipoBonificacion= 1 THEN
			v_nMonto_Bcc := v_nMonto_Bcc +	v_nMontoBonificacion ;
		ELSIF v_nTipoBonificacion = 2 THEN
			v_nMonto_Cigna := v_nMonto_Cigna + v_nMontoBonificacion;
		ELSIF v_nTipoBonificacion = 3 THEN
			vn_Total_Descto_Especial:= vn_Total_Descto_Especial + v_nMontoBonificacion;
	ELSIF v_nTipoBonificacion = 5 THEN
	    vn_Total_credito:= vn_Total_credito + v_nMontoBonificacion;
	END IF;
	END LOOP;

	IF v_nMonto_Bcc > 0 THEN
		vn_COPAGO_BENEFICIO_COMP := v_nMonto_Bcc;
	ELSE
		vn_COPAGO_BENEFICIO_COMP := v_nMonto_Cigna;
	END IF;

	--13-06-2006 REVERSA BCC ALVARO CALDERON S
	IF vv_BENEFICIOS_COMP='S' AND vn_MONTO_BCC > 0 THEN

		SELECT COUNT(*)
		INTO   vn_Existe
		FROM   EMBE_DOCUMENTOS_DE_BENEFICIO
		WHERE  CORRELATIVO =  vn_DOBE_CORRELATIVO;

		IF vn_Existe = 0 THEN
			P_Graba_Monto_BCC(vn_TIPO_DOCUMENTO,		--p_dobe_type IN NUMBER ,
								vn_DOBE_CORRELATIVO,		   	    --p_folio IN NUMBER  bono,
								vv_fecha,	   		--p_fecha IN VARCHAR2 ,
								vv_TIPO_ATENCION,	--p_tipo_atencion IN VARCHAR2 , A,H,D
								vn_COAF_FOLIO_SUSCRIPCION,			    --p_folio_suscripcion IN NUMBER ,
								vn_CODIGO_CARGA,		--p_codigo_carga IN NUMBER ,
								vv_TIPO_EMISION,		--p_tipo_emision IN VARCHAR2 O oam,reembolso
								vn_CENTRO_COSTO,		--preventivo o curativo
								vn_RUT_PRESTADOR,		--p_pres_rut IN NUMBER ,
								vn_CODIGO_SUCURSAL_ISAPRE,			--p_sucursal IN NUMBER ,
								vn_CODIGO_OFICINA_ISAPRE,   		--p_oficina IN NUMBER ,
								vn_NUMERO_LINEAS,   	    --p_numero_linea IN NUMBER ,
								vn_CODIGO_PRESTACION_HOMOLOG,	   	--p_codigo_isapre IN NUMBER ,
								vn_NUMERO_PRESTACIONES,		--p_numero_atenciones IN NUMBER ,
								vn_TARIFA_POR_LINEA,  	 	--p_valor_prestacion IN NUMBER ,
								0,					--p_valor_bonificado_servicio IN NUMBER ,
								vn_VALOR_TOTAL_BONIFICACION - v_nMontoBonificacion,	    --p_valor_bonificado_isapre IN NUMBER ,
								0,					--p_flag IN NUMBER , 0 reversa, 1 consulta y grabar
								vn_MONTO_BCC);		--p_monto_bcsc OUT NUMBER
		ELSE
			---RAISE_APPLICATION_ERROR(-20001,' BONO YA EXISTE');
			DBMS_OUTPUT.PUT_LINE ( 'BONO YA EXISTE= ');
			RAISE E_BONO_EXISTE;
		END IF;
	END IF;
	--13-06-2006 REVERSA BCC ALVARO CALDERON

	vn_Total_Descto_Especial:= 0;

	FOR z IN 1..vn_CANT_LINEAS LOOP


		-- POR CORRELATIVO DE LA AUDITORIA PGP 04/07/2006
		vv_INTERNO_ISAPRE:=Saca_String(v_vExtLista,v_vSeparador,(z*19)-10); -- POSICION 9
		--DBMS_OUTPUT.PUT_LINE ( 'vv_INTERNO_ISAPRE= ' || vv_INTERNO_ISAPRE );
		--DBMS_OUTPUT.PUT_LINE ( 'len v_vExtLista= ' || length(v_vExtLista) );
		--DBMS_OUTPUT.PUT_LINE ( 'v_vExtLista= ' || substr(v_vExtLista,1,200) );
		--DBMS_OUTPUT.PUT_LINE ( 'v_vExtLista= ' || substr(v_vExtLista,201,200));
		--DBMS_OUTPUT.PUT_LINE ( 'v_vExtLista= ' || substr(v_vExtLista,401));
		--DBMS_OUTPUT.PUT_LINE ( 'v_vExtLista= ' ||v_vExtLista);
		-- FIN PGP 04/04/2006

		vn_NRO_LINEA_BONO := vn_NRO_LINEA_BONO +1; --nro linea del bono
		--vn_NRO_LINEA_BONO:= TO_NUMBER(Saca_String(vv_LINEA_A_GUARDAR,v_vSeparador,(z*11)-10));
		--    w9210_prtcod:= TO_NUMBER(Saca_String(vv_LINEA_A_GUARDAR,v_vSeparador,(z*19)-18));
		vn_CODIGO_PRESTACION_HOMOLOG:= TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-18)); -- codigo prestacion
		vn_NUMERO_PRESTACIONES:= TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-14)); -- cantidad de prestaciones
		--    w9210_ordnum:= TO_NUMBER(Saca_String(vv_LINEA_A_GUARDAR,v_vSeparador,(z*11)-6));
		vn_TARIFA_POR_LINEA:= TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-13));  -- valor
		vn_VALOR_TOTAL_BONIFICACION:= TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-12));  -- monto bonif.isapre

		vv_BENEF_COMP_APLICADO:=NULL;

		v_nTipoBonificacion := Saca_String(v_vExtLista,v_vSeparador,(z*19)-9);--pos 10

		IF v_nTipoBonificacion = 1 THEN
		    -- MJBV 25-03-2003
			v_nMontoBonificacion := NVL(TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-8)),0);-- MONTO BCC LINEA
			-- MJBV 25-03-2003
		END IF;

		--ALVARO CALDERON 08/06/2006
		--vn_Monto_Descto_Especial := NVL(TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-4)),0);--pos 15 old

	IF v_nTipoBonificacion = 5 THEN
		    vn_Total_credito := NVL(TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-8)),0);-- credito LINEA
		END IF;


		IF v_nTipoBonificacion = 3 THEN
		   vn_Monto_Descto_Especial := NVL(TO_NUMBER(Saca_String(v_vExtLista,v_vSeparador,(z*19)-8)),0);
		END IF;

		DBMS_OUTPUT.PUT_LINE ( 'vn_Monto_Descto_Especial= ' || vn_Monto_Descto_Especial );

		vn_Monto_Precio_Rebajado :=0;
		vn_Monto_Bonif_Precio_Rebajado:=0;
		DBMS_OUTPUT.PUT_LINE ( 'FUERA DEL IF ' );
		IF  vn_Monto_Descto_Especial > 0 THEN
			DBMS_OUTPUT.PUT_LINE ( 'ENTRE A vn_Monto_Descto_Especial > 0 ' );
			Pck_Benef_Consulta.P_RETORNA_ARANCEL_FONASA(vn_CODIGO_PRESTACION_HOMOLOG,
									   vn_Precio_N1,
									   vn_Precio_N2,
									   vn_Precio_N3);
			DBMS_OUTPUT.PUT_LINE ( 'VOLVI DEL PROCEDIMIENTO P_RETORNA_ARANCEL_FONASA' );
			DBMS_OUTPUT.PUT_LINE ( 'vn_CODIGO_PRESTACION_HOMOLOG= ' || vn_CODIGO_PRESTACION_HOMOLOG );
			DBMS_OUTPUT.PUT_LINE ( 'vn_Precio_N1= ' || vn_Precio_N1 );
			DBMS_OUTPUT.PUT_LINE ( 'vn_Precio_N2= ' || vn_Precio_N2 );
			DBMS_OUTPUT.PUT_LINE ( 'vn_Precio_N3= ' || vn_Precio_N3 );


	     vn_Monto_Precio_Rebajado := vn_Precio_N2;

			 DBMS_OUTPUT.PUT_LINE ( 'vn_Monto_Precio_Rebajado= ' || vn_Monto_Precio_Rebajado );

	     vn_Monto_Bonif_Precio_Rebajado := vn_Monto_Precio_Rebajado - (vn_TARIFA_POR_LINEA - vn_VALOR_TOTAL_BONIFICACION ) + v_nMontoBonificacion;
	     -- Precio_N2- (copago) + BCC ;

			 DBMS_OUTPUT.PUT_LINE ( 'vn_Monto_Bonif_Precio_Rebajado= ' || vn_Monto_Bonif_Precio_Rebajado );

	     vn_Total_Precio_Rebajado := vn_Total_Precio_Rebajado + vn_Monto_Precio_Rebajado;
	     vn_Total_Bonif_Precio_Rebajado := vn_Total_Bonif_Precio_Rebajado + vn_Monto_Bonif_Precio_Rebajado;
	    --alvaro calderon 16/06/2006
			vn_Total_Descto_Especial := vn_Total_Descto_Especial + vn_Monto_Descto_Especial;

			 DBMS_OUTPUT.PUT_LINE ( 'vn_Total_Precio_Rebajado= ' || vn_Total_Precio_Rebajado );
			 DBMS_OUTPUT.PUT_LINE ( 'vn_Total_Bonif_Precio_Rebajado= ' || vn_Total_Bonif_Precio_Rebajado );
			 DBMS_OUTPUT.PUT_LINE ( 'vn_Total_Descto_Especial= ' || vn_Total_Descto_Especial );
		END IF;
		--FIN ALVARO CALDERON

		--  basado en supuesto restrictivo en 910 de un Bono PREV o CURAT. sin mezcla
		IF  vn_CODIGO_PRESTACION_HOMOLOG > 7000000 AND vn_CODIGO_PRESTACION_HOMOLOG < 8000000 THEN
			vn_CENTRO_COSTO:=1;
		ELSE
			vn_CENTRO_COSTO:=2;
		END IF;

		IF  vn_CODIGO_PRESTACION_HOMOLOG > 5000000 AND vn_CODIGO_PRESTACION_HOMOLOG < 5200000 THEN
			vn_TIPO_ATENCION:= 3;
		END IF;
		vn_BANDERA:=9;



		--EACE 28-06-2005 GES
		IF vv_CODIGO_SUB_GRUPO <> 'N' THEN
		   vv_PRISA_ES_GES := PCK_GESARA_100_BONIFICACIONES.F_PRESTACION_GES ( vn_CODIGO_PRESTACION_HOMOLOG, vn_COD_GARANTIA, vn_GRUPO_SEQ, vn_SUB_GRUPO_SEQ,vd_FECHA_LLEGADA );
		ELSE
		   vv_PRISA_ES_GES := 'N';
		END IF;


		-- GES PGP 07/01/2009
		DBMS_OUTPUT.PUT_LINE ( 'vn_CODIGO_PRESTACION_HOMOLOG= ' || vn_CODIGO_PRESTACION_HOMOLOG );
		DBMS_OUTPUT.PUT_LINE ( 'vn_CODIGO_PRESTADOR= ' || vn_CODIGO_PRESTADOR );
		DBMS_OUTPUT.PUT_LINE ( 'vn_CODIGO_INTERNO_FACTURADOR= ' || vn_CODIGO_INTERNO_FACTURADOR );

	/*
	IF vn_CODIGO_INTERNO_FACTURADOR = 146510 AND vn_CODIGO_PRESTACION_HOMOLOG IN(903002,903006) THEN

		DBMS_OUTPUT.PUT_LINE ( 'ES GES!' );

		GESARA.Pck_GEAR_Servicios_IMED.p_ConsultaGES (vn_COAF_FOLIO_SUSCRIPCION
											  		 ,vn_CODIGO_CARGA
											  		 ,vn_RUT_BENEFICIARIO
											  		 ,vn_CODIGO_PRESTACION_HOMOLOG
											  		 ,vn_CODIGO_INTERNO_FACTURADOR
											  		 ,TO_CHAR(SYSDATE,'DD/MM/RRRR')
											  		 ,vn_GaraCodigo
											  		 ,vn_GrupSecuencia
											  		 ,vv_ES_GES,
													 vv_MENSAJE_GES);

		DBMS_OUTPUT.PUT_LINE ( 'vn_GaraCodigo= ' || vn_GaraCodigo );
		DBMS_OUTPUT.PUT_LINE ( 'vn_GrupSecuencia= ' || vn_GrupSecuencia );
		DBMS_OUTPUT.PUT_LINE ( 'vv_ES_GES= ' || vv_ES_GES );

		ELSE
			vv_ES_GES:='N';
			vn_GaraCodigo := NULL;
			vn_GrupSecuencia := NULL;
		END IF;
	*/
		-- GES PGP 07/01/2009



		IF vv_PRISA_ES_GES = 'S' THEN
			vn_BANDERA:=1022;

			vn_MONTO_GES   := vn_VALOR_TOTAL_BONIFICACION;
			vn_COPAGO_GES  := vn_TARIFA_POR_LINEA - vn_MONTO_GES;

			/* Inserta lineas en tabla virtual*/
			t_LINEAS(z).dobe_correlativo		:= vn_DOBE_CORRELATIVO;
			t_LINEAS(z).num_linea			    := z;
			t_LINEAS(z).estado					:= 'EMI';
			t_LINEAS(z).monto_copago			:= 0;
			t_LINEAS(z).monto_isapre			:= 0;
			t_LINEAS(z).monto_otros				:= 0;
			t_LINEAS(z).monto_total				:= vn_TARIFA_POR_LINEA;
			t_LINEAS(z).numero_prestaciones		:= vn_NUMERO_PRESTACIONES;
			t_LINEAS(z).prisa_codigo			:= vn_CODIGO_PRESTACION_HOMOLOG;
			t_LINEAS(z).prest_codigo_interno	:= vn_CODIGO_PRESTADOR;
			t_LINEAS(z).esp_codigo				:= vv_CODIGO_ESPECILIDAD_HOMOLOG;
			t_LINEAS(z).monto_bcc				:= 0;
			t_LINEAS(z).monto_ges				:= vn_MONTO_GES; --EACE 28-06-2005 GES
			t_LINEAS(z).copago_ges				:= vn_COPAGO_GES; --EACE 28-06-2005 GES
			t_LINEAS(z).codigo_grupo			:= vv_CODIGO_GRUPO; --EACE 28-06-2005 GES

			--ALVARO CALDERON 08/06/2006
			t_LINEAS(z).Monto_Descto_Especial 	   	:= vn_Monto_Descto_Especial; -- ACS 08/06/2006
			t_LINEAS(z).Monto_Precio_Rebajado 	   	:= vn_Monto_Precio_Rebajado; -- ACS 08/06/2006
			t_LINEAS(z).Monto_Bonif_Precio_Rebajado  := vn_Monto_Bonif_Precio_Rebajado; -- ACS 08/06/2006
			--FIN ALVARO CALDERON
			t_LINEAS(z).interno_isapre  			 := vv_INTERNO_ISAPRE; -- PGP 06/07/2006

			vv_DOBE_CODIGO_GRUPO	:= vv_CODIGO_GRUPO; --EACE 29-05-2006

			vn_MONTO_TOTAL := NVL(vn_MONTO_TOTAL,0)  + vn_TARIFA_POR_LINEA;
			vn_MONTO_GES_TOTAL 	:= NVL(vn_MONTO_GES_TOTAL,0)  + vn_MONTO_GES;
			vn_COPAGO_GES_TOTAL := NVL(vn_COPAGO_GES_TOTAL,0) + vn_COPAGO_GES;

			vn_BANDERA:=1122;

		-- RESCATA BONIFICACION BC15  PGP 29/12/2005 BC15
		ELSIF vv_POSEE_BENEFICIO_BC15='BC15' AND vn_TIPO_ATENCION=3 THEN

			vn_DOFI_CODIGO:=990;

			vn_MONTO_DSCTO_MEGA := vn_VALOR_TOTAL_BONIFICACION;
			vn_COPAGO_TOTAL:= vn_TARIFA_POR_LINEA - vn_MONTO_DSCTO_MEGA;
			vn_COPAGO_TOTAL:= vn_TARIFA_POR_LINEA;
			vv_BENEF_COMP_APLICADO:='BC15';

			t_LINEAS(z).dobe_correlativo		:= vn_DOBE_CORRELATIVO;
			t_LINEAS(z).num_linea			    := z;
			t_LINEAS(z).estado					:= 'EMI';
			t_LINEAS(z).monto_copago			:= vn_COPAGO_TOTAL;
			t_LINEAS(z).monto_isapre			:= 0;
			t_LINEAS(z).monto_otros				:= 0;
			t_LINEAS(z).monto_total				:= vn_TARIFA_POR_LINEA;
			t_LINEAS(z).numero_prestaciones		:= vn_NUMERO_PRESTACIONES;
			t_LINEAS(z).prisa_codigo			:= vn_CODIGO_PRESTACION_HOMOLOG;
			t_LINEAS(z).prest_codigo_interno	:= vn_CODIGO_PRESTADOR;
			t_LINEAS(z).esp_codigo				:= vv_CODIGO_ESPECILIDAD_HOMOLOG;
			t_LINEAS(z).monto_bcc				:= 0;
			t_LINEAS(z).monto_ges				:= 0; --PGP 29/12/2005 BC15
			t_LINEAS(z).copago_ges				:= 0; --PGP 29/12/2005 BC15
			t_LINEAS(z).codigo_grupo			:= NULL;-- PGP 29/12/2005 BC15
			t_LINEAS(z).monto_dscto_mega		:= vn_MONTO_DSCTO_MEGA;-- PGP 29/12/2005 BC15
			t_LINEAS(z).benef_comp_aplicado		:= vv_BENEF_COMP_APLICADO;-- PGP 29/12/2005 BC15

			--ALVARO CALDERON 08/06/2006
			t_LINEAS(z).Monto_Descto_Especial 	   	:= vn_Monto_Descto_Especial; -- ACS 08/06/2006
			t_LINEAS(z).Monto_Precio_Rebajado 	   	:= vn_Monto_Precio_Rebajado; -- ACS 08/06/2006
			t_LINEAS(z).Monto_Bonif_Precio_Rebajado  := vn_Monto_Bonif_Precio_Rebajado; -- ACS 08/06/2006
			--FIN ALVARO CALDERON
			t_LINEAS(z).interno_isapre  			 := vv_INTERNO_ISAPRE; -- PGP 06/07/2006


			vn_MONTO_TOTAL_DSCTO_MEGA := NVL(vn_MONTO_TOTAL_DSCTO_MEGA,0) + vn_MONTO_DSCTO_MEGA;
			vn_MONTO_TOTAL 			  := NVL(vn_MONTO_TOTAL,0)  + vn_TARIFA_POR_LINEA;
			vn_MONTO_COPAGO 			  := NVL(vn_MONTO_COPAGO,0)  + vn_COPAGO_TOTAL;
			vn_MONTO_GES_TOTAL 		  := NVL(vn_MONTO_GES_TOTAL,0)	+ vn_MONTO_GES;
			vn_COPAGO_GES_TOTAL 	  := NVL(vn_COPAGO_GES_TOTAL,0) + vn_COPAGO_GES;

		-- RESCATA BONIFICACION BC24  PGP 27/06/2006 BC24

		ELSIF vv_POSEE_BENEFICIO_BC24='BC24' AND vn_TIPO_ATENCION=3 THEN
			vn_DOFI_CODIGO:=990;
			vn_MONTO_DSCTO_MEGA := vn_VALOR_TOTAL_BONIFICACION;
			vn_COPAGO_TOTAL:= vn_TARIFA_POR_LINEA - vn_MONTO_DSCTO_MEGA;
			vn_COPAGO_TOTAL:= vn_TARIFA_POR_LINEA;
			vv_BENEF_COMP_APLICADO:='BC24';

			t_LINEAS(z).dobe_correlativo		:= vn_DOBE_CORRELATIVO;
			t_LINEAS(z).num_linea			    := z;
			t_LINEAS(z).estado					:= 'EMI';
			t_LINEAS(z).monto_copago			:= vn_COPAGO_TOTAL;
			t_LINEAS(z).monto_isapre			:= 0;
			t_LINEAS(z).monto_otros				:= 0;
			t_LINEAS(z).monto_total				:= vn_TARIFA_POR_LINEA;
			t_LINEAS(z).numero_prestaciones		:= vn_NUMERO_PRESTACIONES;
			t_LINEAS(z).prisa_codigo			:= vn_CODIGO_PRESTACION_HOMOLOG;
			t_LINEAS(z).prest_codigo_interno	:= vn_CODIGO_PRESTADOR;
			t_LINEAS(z).esp_codigo				:= vv_CODIGO_ESPECILIDAD_HOMOLOG;
			t_LINEAS(z).monto_bcc				:= 0;
			t_LINEAS(z).monto_ges				:= 0;
			t_LINEAS(z).copago_ges				:= 0;
			t_LINEAS(z).codigo_grupo			:= NULL;
			t_LINEAS(z).monto_dscto_mega		:= vn_MONTO_DSCTO_MEGA;--
			t_LINEAS(z).benef_comp_aplicado		:= vv_BENEF_COMP_APLICADO;--

			--ALVARO CALDERON 08/06/2006
			t_LINEAS(z).Monto_Descto_Especial 	   	:= vn_Monto_Descto_Especial; -- ACS 08/06/2006
			t_LINEAS(z).Monto_Precio_Rebajado 	   	:= vn_Monto_Precio_Rebajado; -- ACS 08/06/2006
			t_LINEAS(z).Monto_Bonif_Precio_Rebajado  := vn_Monto_Bonif_Precio_Rebajado; -- ACS 08/06/2006
			--FIN ALVARO CALDERON
			t_LINEAS(z).interno_isapre  			 := vv_INTERNO_ISAPRE; -- PGP 06/07/2006
	    t_LINEAS(z).Monto_credito  			     := vn_Total_credito;  -- PGP 11/05/2009


			vn_MONTO_TOTAL_DSCTO_MEGA := NVL(vn_MONTO_TOTAL_DSCTO_MEGA,0) + vn_MONTO_DSCTO_MEGA;
			vn_MONTO_TOTAL 			  := NVL(vn_MONTO_TOTAL,0)  + vn_TARIFA_POR_LINEA;
			vn_MONTO_COPAGO 			  := NVL(vn_MONTO_COPAGO,0)  + vn_COPAGO_TOTAL;
			vn_MONTO_GES_TOTAL 		  := NVL(vn_MONTO_GES_TOTAL,0)	+ vn_MONTO_GES;
			vn_COPAGO_GES_TOTAL 	  := NVL(vn_COPAGO_GES_TOTAL,0) + vn_COPAGO_GES;

			vn_BANDERA:=1122;

		ELSE
			--EACE 28-06-2005 GES

			IF  vv_BENEFICIOS_COMP='S' AND vn_COPAGO_BENEFICIO_COMP > 0 THEN

				DBMS_OUTPUT.PUT_LINE ( '*** LLAMARA A RUTINA BCC ***');
				BEGIN
					SELECT codigo_sucursal_isapre,codigo_oficina_isapre
					INTO   vn_CODIGO_SUCURSAL_ISAPRE,vn_CODIGO_OFICINA_ISAPRE
					FROM   GLO_UNIDADES_ORGANIZACIONALES
					WHERE  correlativo = vn_CENTRO_ATENCION;

					IF  vn_TIPO_ATENCION = 1 THEN
						vv_TIPO_ATENCION:='H';
					ELSIF  vn_TIPO_ATENCION = 2 THEN
						vv_TIPO_ATENCION:='A';
					ELSIF  vn_TIPO_ATENCION = 3 THEN
						vv_TIPO_ATENCION:='A'; -- JLLC / ACF 28/06/2002
					END IF;

					IF  vn_TIPO_DOCUMENTO = 1 THEN
						vv_TIPO_EMISION:='O';
					ELSE
						vv_TIPO_EMISION:='R';
					END IF;

					SELECT TO_CHAR(SYSDATE,'ddmmyyyy')
					INTO   vv_FECHA
					FROM   dual;

					vn_NUMERO_LINEAS:=vn_NRO_LINEA_BONO;

					vn_USO_BCC:='S';
				EXCEPTION
					WHEN e_CARGO_BCC THEN
						RAISE e_CARGO_BCC;
					WHEN OTHERS THEN
						dbms_output.put_line(' Error en este punto');
						DBMS_OUTPUT.PUT_LINE ('ERROR: '||SUBSTR(SQLERRM,1,50));
						vn_MONTO_BCC:= vn_COPAGO_BENEFICIO_COMP;
						RAISE e_CARGO_BCC;
				END;
			END IF;

			vn_BANDERA:=10;
			vn_COPAGO_TOTAL:= vn_TARIFA_POR_LINEA - vn_VALOR_TOTAL_BONIFICACION;
			--	vn_COPAGO_BCC:= vn_TARIFA_POR_LINEA - vn_VALOR_TOTAL_BONIFICACION - NVL(vn_MONTO_BCC,0);

			/* Inserta lineas en tabla virtual*/
			t_LINEAS(z).dobe_correlativo		:= vn_DOBE_CORRELATIVO;
			t_LINEAS(z).num_linea			    := z;
			t_LINEAS(z).estado					:= 'EMI';
			t_LINEAS(z).monto_copago			:= vn_COPAGO_TOTAL;
			t_LINEAS(z).monto_isapre			:= vn_VALOR_TOTAL_BONIFICACION;
			t_LINEAS(z).monto_otros				:= 0;
			t_LINEAS(z).monto_total				:= vn_TARIFA_POR_LINEA;
			t_LINEAS(z).numero_prestaciones		:= vn_NUMERO_PRESTACIONES;
			t_LINEAS(z).prisa_codigo			:= vn_CODIGO_PRESTACION_HOMOLOG;
			t_LINEAS(z).prest_codigo_interno	:= vn_CODIGO_PRESTADOR;
			t_LINEAS(z).esp_codigo				:= vv_CODIGO_ESPECILIDAD_HOMOLOG;
			t_LINEAS(z).monto_bcc				:= vn_MONTO_BCC;
			t_LINEAS(z).monto_ges				:= 0; --EACE 28-06-2005 GES
			t_LINEAS(z).copago_ges				:= 0; --EACE 28-06-2005 GES
			t_LINEAS(z).codigo_grupo			:= NULL; --EACE 28-06-2005 GES

			--ALVARO CALDERON 08/06/2006
			t_LINEAS(z).Monto_Descto_Especial 	   	:= vn_Monto_Descto_Especial; -- ACS 08/06/2006
			t_LINEAS(z).Monto_Precio_Rebajado 	   	:= vn_Monto_Precio_Rebajado; -- ACS 08/06/2006
			t_LINEAS(z).Monto_Bonif_Precio_Rebajado  := vn_Monto_Bonif_Precio_Rebajado; -- ACS 08/06/2006
			--FIN ALVARO CALDERON
			t_LINEAS(z).interno_isapre  			 := vv_INTERNO_ISAPRE; -- PGP 06/07/2006
	    t_LINEAS(z).Monto_credito  			     := vn_Total_credito;  -- PGP 11/05/2009


			DBMS_OUTPUT.PUT_LINE ( '*** BCC POR LINEA (vn_MONTO_BCC): '||vn_MONTO_BCC);
			vn_MONTO_TOTAL := NVL(vn_MONTO_TOTAL,0)  + vn_TARIFA_POR_LINEA;
			vn_PRESTACIONES := NVL(vn_PRESTACIONES,0)  + vn_NUMERO_PRESTACIONES;
			vn_VALOR_BONIF := NVL(vn_VALOR_BONIF,0)  + vn_VALOR_TOTAL_BONIFICACION;
			vn_MONTO_COPAGO := NVL(vn_MONTO_COPAGO,0)  + vn_COPAGO_TOTAL;
			vn_MONTO_BCC_AUDI:= NVL(vn_MONTO_BCC_AUDI,0) + vn_MONTO_BCC;
			vn_BANDERA:=11;
		END IF;
	END LOOP;

	DBMS_OUTPUT.PUT_LINE ( 'vn_MONTO_BCC_AUDI (DESPUES DEL LOOP) ' || vn_MONTO_BCC_AUDI );
	DBMS_OUTPUT.PUT_LINE ( 'vn_COPAGO_BENEFICIO_COMP (DESPUES DEL LOOP) ' || vn_COPAGO_BENEFICIO_COMP );

	-- 20030320 CAGF DEF. MBORBAR
	--		BLOQUE COMENTADO POR LOTUS DE K.GALARSE DEL 17/03/2003	MJBV
	--   /* 26/03/2002 SEGURO CIGNA CAMUFLADO A ATESA COMO BCC */
	--   IF  vv_ASEG_CORRELATIVO = 1 AND vn_TIPO_ATENCION <> 3 THEN
	--	 vn_MONTO_BCC_AUDI:= vn_COPAGO_BENEFICIO_COMP;
	-- 	  vn_COPAGO_BENEFICIO_COMP:= 0;
	--   END IF;
	--		BLOQUE COMENTADO POR LOTUS DE K.GALARSE DEL 17/03/2003	MJBV
	-- 20030320 CAGF


	/*  MJBV  1/6/2000, por politicas de la empresa */
	--  Graba el monto ocupado de Excedentes
	DBMS_OUTPUT.PUT_LINE('VALOR AL ENTRAR A EXCEDENTE ES '||vn_MONTO_COPAGO_EXCEDENTE);
	DBMS_OUTPUT.PUT_LINE('vn_CODIGO_MENSAJE_EXCEDENTE '||vn_CODIGO_MENSAJE_EXCEDENTE);
	DBMS_OUTPUT.PUT_LINE('vv_GLOSA_EXCEDENTE '||vv_GLOSA_EXCEDENTE);

	vn_BANDERA:=12;

	IF  vn_MONTO_COPAGO_EXCEDENTE <> 0 THEN
		BEGIN
			vn_CON_EXCEDENTE:='S';
			Pr_Actualiza_Ctaind('GIRO',1,vn_COAF_FOLIO_SUSCRIPCION,vn_CODIGO_ISAPRE,vn_DOBE_CORRELATIVO,TO_CHAR(SYSDATE,'DD/MM/YYYY'),vn_MONTO_COPAGO_EXCEDENTE,vn_CODIGO_MENSAJE_EXCEDENTE,vv_GLOSA_EXCEDENTE);
			IF NVL(vn_CODIGO_MENSAJE_EXCEDENTE,1) <> 1 THEN
			   	vv_MensajeError:= TO_CHAR(vn_CODIGO_MENSAJE_EXCEDENTE)||vv_GLOSA_EXCEDENTE;
				RAISE e_EXCEDENTES;
			END IF;
		EXCEPTION
			WHEN OTHERS THEN
				vv_MensajeError:=SUBSTR(SQLERRM,1,200);
				RAISE e_EXCEDENTES;
		END;
	END IF;
	vn_BANDERA:=13;
	-- --mjbv -- esta linea debe sacarse cuando se descomente el BCC
	--   vn_MONTO_BCC_AUDI:= vn_COPAGO_BENEFICIO_COMP;
	-- --mjbv --

	vn_MONTO_COPAGO_BONIF:= vn_MONTO_TOTAL - vn_VALOR_BONIF - vn_MONTO_BCC_AUDI - vn_MONTO_COPAGO_EXCEDENTE;
	vn_VALOR_COPAGO_EXCEDENTE:= vn_MONTO_COPAGO_EXCEDENTE;
	vn_MONTO := vn_MONTO_TOTAL - vn_MONTO_COPAGO_BONIF;

	vn_BANDERA:=14;
	vv_SALIDA_FINAL:='N'||'';
	vn_CONTADOR:= t_LINEAS.COUNT;
	vn_BANDERA:=15;


	IF  vn_TIPO_ATENCION = 3 THEN
		vv_DOBE_TYPE :='DENT';
		vn_CENTRO_COSTO:=4;
	ELSE
		vv_DOBE_TYPE :='BOOAM';
		vn_TIPO_ATENCION:=2;
	END IF;

	IF  vv_BENEFICIOS_COMP='N' THEN
		vn_COPAGO_BENEFICIO_COMP:=0;
	END IF;

	--EACE 01/07/2005 DESCUENTO POR PLANILLA

	IF  v_vExtDescuentoXPlanilla = 'S' THEN
	  DBMS_OUTPUT.PUT_LINE ( 'vn_MONTO_TOTAL= ' || vn_MONTO_TOTAL );
	  DBMS_OUTPUT.PUT_LINE ( 'vn_VALOR_BONIF= ' || vn_VALOR_BONIF );
	  DBMS_OUTPUT.PUT_LINE ( 'vn_COPAGO_BENEFICIO_COMP= ' || vn_COPAGO_BENEFICIO_COMP );
	  DBMS_OUTPUT.PUT_LINE ( 'vn_MONTO_COPAGO_EXCEDENTE= ' || vn_MONTO_COPAGO_EXCEDENTE );
	  DBMS_OUTPUT.PUT_LINE ( 'vn_MONTO_GES= ' || vn_MONTO_GES );
	  DBMS_OUTPUT.PUT_LINE ( 'vn_DOBE_CORRELATIVO= ' || vn_DOBE_CORRELATIVO );
	  INSERT INTO EMBE_DOCUMENTOS_CREDITO
	  		 	 (DOBE_CORRELATIVO,
				  DERIVADO,
				  MONTO_COPAGO_FINAL,
				  MONTO_EFECTIVO,
				  MONTO_CREDITO,
				  NRO_CUOTA)
		   VALUES
		   		 (vn_DOBE_CORRELATIVO,
				  'IMED',
				  vn_MONTO_TOTAL - (vn_VALOR_BONIF - vn_COPAGO_BENEFICIO_COMP) - vn_COPAGO_BENEFICIO_COMP - vn_MONTO_COPAGO_EXCEDENTE - vn_MONTO_GES_TOTAL -vn_MONTO_TOTAL_DSCTO_MEGA,
				  vn_MONTO_TOTAL - (vn_VALOR_BONIF - vn_COPAGO_BENEFICIO_COMP) - vn_COPAGO_BENEFICIO_COMP - vn_MONTO_COPAGO_EXCEDENTE - vn_MONTO_GES_TOTAL -vn_MONTO_TOTAL_DSCTO_MEGA,
				  vn_MONTO_TOTAL - (vn_VALOR_BONIF - vn_COPAGO_BENEFICIO_COMP) - vn_COPAGO_BENEFICIO_COMP - vn_MONTO_COPAGO_EXCEDENTE - vn_MONTO_GES_TOTAL -vn_MONTO_TOTAL_DSCTO_MEGA,
				  1);
	END IF;

	--EACE 01/07/2005 DESCUENTO POR PLANILLA

	vn_BANDERA:=151;
	DBMS_OUTPUT.PUT_LINE ( 'vn_DOBE_CORRELATIVO= ' || vn_DOBE_CORRELATIVO );
	/* Proceso de grabacion de Documentos, Lineas y Estados de documentos */
	/*INSERT INTO IMED_DOBE  (correlativo,
							dobe_type,
							dofi_codigo,
							estado,
							fecha_emision,
							monto_copago,
							monto_copago_final,
							monto_excedente,
							monto_isapre,
							monto_total,
							monto_otros,
							prestaciones_totales,
							benc_coaf_orga_isapre_afiliado,
							benc_codigo_carga_afiliado,
							benc_coaf_folio_afiliado,
							benc_coaf_orga_isapre_benef,
							benc_codigo_carga_beneficiario,
							benc_coaf_folio_beneficiario,
							ceco_codigo,
							ceco_unor_correlativo,
							ceco_empr_rut,
							unor_correlativo_emitido,
							unor_correlativo_recibido,
							unor_correlativo_atendido,
							prest_codigo_interno_derivado,
							prest_codigo_interno_atendido,
							mocc_cuco_correlativo,
							mocc_numero_linea,
							prme_folio,
							roin_tiri_codigo,
							roin_inst_rut,
							depb_correlativo,
							rut_cobrador,
							recepcion_interna,
							trbe_correlativo,
							trbe_correlativo_devuelto,
							tipo_centro_costo,
							tipo_atencion,
							bete_rut_afiliado,
							bete_cod_carga_afiliado,
							bete_rut_afiliado_benef,
							bete_cod_carga_beneficiario,
							audi_usuario_creacion,
							audi_fecha_creacion,
							audi_usuario_modificacion,
							audi_fecha_modificacion,
							trbe_unor_correlativo,
							trbe_unor_devuelto,
							monto_bcc,
							impresion_por_tope,
							domi_codigo,
							domi_domi_type,
							monto_premio,
							diag_codigo,
							inpr_prme_folio,
							inpr_num_intervencion,
							atencion_cab_titular,
							cobrable,
							orde_correlativo,
							orde_unor_correlativo,
							plan_correlativo,
							prest_codigo_atendido_por,
							MONTO_GES, --EACE 28-06-2005  GES
							COPAGO_GES, --EACE 28-06-2005  GES
							CODIGO_GRUPO, --EACE 28-06-2005  GES
							MONTO_DSCTO_MEGA,--PGP 29/12/2005 BC15
							BENEF_COMP_APLICADO --PGP 29/12/2005 BC15
							,Monto_Descto_Especial	-- ACS 08/06/2006
							,Monto_Precio_Rebajado	   --ACS 08/06/2006
							,Monto_Bonif_Precio_Rebajado  --ACS 08/06/2006
							)
					VALUES (vn_DOBE_CORRELATIVO,
							vv_DOBE_TYPE ,--'BOOAM',
							vn_DOFI_CODIGO,-- PGP 20/01/2006
							--920,
							'EMI',
							SYSDATE,
							-- MJBV 25-03-2003 		  vn_MONTO_COPAGO,
							vn_MONTO_TOTAL - (vn_VALOR_BONIF - vn_COPAGO_BENEFICIO_COMP) ,	 --29-05-2006 --vn_MONTO_COPAGO + vn_COPAGO_BENEFICIO_COMP,
							-- MJBV 25-03-2003 		  vn_MONTO_COPAGO_BONIF,
							-- EACE 28-06-2005 GES vn_MONTO_TOTAL - (vn_VALOR_BONIF - vn_COPAGO_BENEFICIO_COMP) - vn_COPAGO_BENEFICIO_COMP - vn_MONTO_COPAGO_EXCEDENTE,
							vn_MONTO_TOTAL - (vn_VALOR_BONIF - vn_COPAGO_BENEFICIO_COMP) - vn_COPAGO_BENEFICIO_COMP - vn_MONTO_COPAGO_EXCEDENTE - vn_MONTO_GES_TOTAL -vn_MONTO_TOTAL_DSCTO_MEGA,
							vn_MONTO_COPAGO_EXCEDENTE,
							-- MJBV 25-03-2003 		  vn_VALOR_BONIF,
							vn_VALOR_BONIF - vn_COPAGO_BENEFICIO_COMP,
							vn_MONTO_TOTAL,
							0,
							vn_CANT_LINEAS,
							vn_CODIGO_ISAPRE,
							0,
							vn_COAF_FOLIO_SUSCRIPCION,
							vn_CODIGO_ISAPRE,
							vn_CODIGO_CARGA,
							vn_COAF_FOLIO_SUSCRIPCION,
							NULL,
							NULL,
							0,
							vn_CENTRO_ATENCION,
							NULL,
							vn_UNOR_CORRELATIVO_CEN_ATEN,
							DECODE(vn_CODIGO_MED_SOLICITANTE,0,NULL,vn_CODIGO_MED_SOLICITANTE),
							vn_CODIGO_INTERNO_FACTURADOR, --04-12-2006  vn_CODIGO_PRESTADOR,
							0,
							0,
							NULL,
							NULL,
							0,
							NULL,
							0,
							NULL,
							0,
							0,
							vn_CENTRO_COSTO,
							vn_TIPO_ATENCION,
							NULL,
							NULL,
							NULL,
							NULL,
							v_vExtHomNumeroConvenio||'/'||v_vExtRutCajero,
							SYSDATE,
							v_vExtHomNumeroConvenio||'/'||v_vExtRutCajero,
							SYSDATE,
							vn_CENTRO_ATENCION,
							NULL,
							vn_COPAGO_BENEFICIO_COMP,
							'N',
							NULL,
							NULL,
							0,
							NULL,
							NULL,
							NULL,
							NULL,
							NULL,
							0,
							NULL,
							vn_PLAN_CORRELATIVO,
							vn_CODIGO_PRESTADOR, --EACE 04-12-2006 CATOLICA
							vn_MONTO_GES_TOTAL,--EACE 28-06-2005  GES
							vn_COPAGO_GES_TOTAL,--EACE 28-06-2005  GES
							vv_DOBE_CODIGO_GRUPO, --EACE 29-05-2006  GES
							vn_MONTO_TOTAL_DSCTO_MEGA,--PGP 29/12/2005 BC15
							vv_BENEF_COMP_APLICADO--PGP 29/12/2005 BC15
							,vn_Total_Descto_Especial  --ACS 08/06/2006
							,vn_Total_Precio_Rebajado	--ACS 08/06/2006
							,vn_Total_Bonif_Precio_Rebajado --ACS 08/06/2006
							);--PGP 29/12/2005 BC15
						*/






					vn_UNOR_CORRELATIVO_CREACION:=vn_CENTRO_ATENCION;
					DBMS_OUTPUT.PUT_LINE ( 'vn_UNOR_CORRELATIVO_CREACION= ' || vn_UNOR_CORRELATIVO_CREACION );
					--vn_PLAN_CORRELATIVO_SIETE:=??;
					vv_INTERNO_ISAPRE:=Saca_String(v_vExtLista,v_vSeparador,(1*19)-10);
					DBMS_OUTPUT.PUT_LINE ( 'vv_INTERNO_ISAPRE= ' || vv_INTERNO_ISAPRE );
					vn_AUDI_CORRELATIVO:=TO_NUMBER(SUBSTR(TRIM(vv_INTERNO_ISAPRE),1,LENGTH(TRIM(vv_INTERNO_ISAPRE))-3));
					DBMS_OUTPUT.PUT_LINE ( 'vn_AUDI_CORRELATIVO= ' || vn_AUDI_CORRELATIVO );
					vv_LINEA_AUDI:=SUBSTR(TRIM(vv_INTERNO_ISAPRE),LENGTH(TRIM(vv_INTERNO_ISAPRE))-1,LENGTH(TRIM(vv_INTERNO_ISAPRE)));
					DBMS_OUTPUT.PUT_LINE ( 'vv_LINEA_AUDI= ' || vv_LINEA_AUDI );
					vn_LINEA_AUDI:=TO_NUMBER(vv_LINEA_AUDI);
					DBMS_OUTPUT.PUT_LINE ( 'vn_LINEA_AUDI= ' || vn_LINEA_AUDI );


					vn_BANDERA:=1511;

					SELECT NVL(MAX(DETALLE.REB_CORRELATIVO),0)
					INTO   vn_REB_CORRELATIVO
					FROM   IMED_AUDITORIA AUDI,
						   IMED_DETALLE_AUDITORIA DETALLE
					WHERE  AUDI.CORRELATIVO=DETALLE.AUDI_CORRELATIVO
					AND	   AUDI.CORRELATIVO=vn_AUDI_CORRELATIVO
					AND	   DETALLE.NUM_LINEA = vn_LINEA_AUDI;


					vn_BANDERA:=1512;
					DBMS_OUTPUT.PUT_LINE ( 'vn_AUDI_CORRELATIVO= ' || vn_AUDI_CORRELATIVO );
					DBMS_OUTPUT.PUT_LINE ( 'vn_REB_CORRELATIVO= ' || vn_REB_CORRELATIVO );

					SELECT COUNT(*)
					INTO   vn_EXISTE_REP
					FROM   BENEFICIOS.BEN_REPOSITORIO_EMISION_BONOS
					WHERE  CORRELATIVO =vn_REB_CORRELATIVO;

		    vn_EXISTE_REP_RESP:=0;
					SELECT COUNT(*)
					INTO   vn_EXISTE_REP_RESP
					FROM   IMED_REPOSITORIO_EMISION_BONOS
					WHERE  CORRELATIVO =vn_REB_CORRELATIVO;

					DBMS_OUTPUT.PUT_LINE ( 'ENTRANDO A IF DE VALIDACION DE REB_CORRELATIVO ' );
					IF 	NVL(vn_EXISTE_REP,0) <> 0 OR NVL(vn_EXISTE_REP_RESP,0) <> 0 THEN -- EXISTE UN REB_CORRELATIVO ASOCIADO AL BONO
						vn_BANDERA:=1513;
						DBMS_OUTPUT.PUT_LINE ( 'ENTRANDO A BUSQUEDA DE INFO REB_CORRELATIVO ' );
						Pck_Ben_Docu_Liqui_Imed.P_RESCATA_INFO_REPOSITORIO(vn_REB_CORRELATIVO,
			  							 								   'BONO',
			  							 								   vn_CODIGO_ERROR_BUSQ_BONO,
										 								   vv_DESC_ERROR_BUSQ_NONO,
										 								   cur_BONO);

						DBMS_OUTPUT.PUT_LINE ('SE RECOLECTAN DATOS DEL CURSOR');
						BEGIN
							  LOOP
							  FETCH cur_BONO INTO
							  vn_CUME_CORRELATIVO,
							  vn_PREST_CODIGO_INTERNO,
							  vn_PREST_CODIGO_INTERNO_TRAT,
							  vn_DERIV_CODIGO_INTERNO,
							  vn_LUAT_CORRELATIVO,
							  vn_DOCO_CORRELATIVO,
							  vn_BONIF_HOSPITALARIA,
							  vn_BONIF_AMBULATORIA,
							  vn_BONIF_DENTAL,
							  vn_BONIF_MEDICAMENTOS,
							  vn_TIPO_CENTRO_COSTO,
							  vv_FECHA_PRESTACION,
							  vv_TIPO_PRESTACION,
							  vn_DERIV_RUT,
							  vv_DERIV_DIGRUT,
							  vv_IMPRESION_POR_TOPE;
							  DBMS_OUTPUT.PUT_LINE ( 'vn_CUME_CORRELATIVO= ' || vn_CUME_CORRELATIVO );
							  DBMS_OUTPUT.PUT_LINE ( 'vn_PREST_CODIGO_INTERNO= ' || vn_PREST_CODIGO_INTERNO );
							  DBMS_OUTPUT.PUT_LINE ( 'vn_PREST_CODIGO_INTERNO_TRAT= ' || vn_PREST_CODIGO_INTERNO_TRAT );
							  DBMS_OUTPUT.PUT_LINE ( 'vn_TIPO_CENTRO_COSTO= ' || vn_TIPO_CENTRO_COSTO );

			    --****************************************************************
			    --ASIGNA PLAN CORRELATIVO DESDE REPOSITORIO
			    --****************************************************************
			    BEGIN
				vn_PLAN_CORRELATIVO_REB:=NULL;
				--
				SELECT AUX.PLAN_CORRELATIVO INTO vn_PLAN_CORRELATIVO_REB
				FROM
				    (SELECT REB.PLAN_CORRELATIVO
				    FROM   BENEFICIOS.BEN_REPOSITORIO_EMISION_BONOS REB
				    WHERE
				    REB.CORRELATIVO = vn_REB_CORRELATIVO
				    UNION
				    SELECT REB.PLAN_CORRELATIVO --INTO vn_PLAN_CORRELATIVO_REB
				    FROM   IMED_REPOSITORIO_EMISION_BONOS REB
				    WHERE
				    REB.CORRELATIVO = vn_REB_CORRELATIVO
				    AND NOT EXISTS (SELECT DISTINCT 1  FROM BENEFICIOS.BEN_REPOSITORIO_EMISION_BONOS R2 WHERE R2.CORRELATIVO =REB.CORRELATIVO)
				    ) AUX
				WHERE ROWNUM=1 ;

				IF NVL(vn_PLAN_CORRELATIVO_REB,0) > 0 THEN
				    vn_PLAN_CORRELATIVO:=vn_PLAN_CORRELATIVO_REB;
				END IF;
			    EXCEPTION
				WHEN OTHERS THEN
				    NULL;
			    END;
			    --****************************************************************
			    --****************************************************************


							  EXIT WHEN cur_BONO%NOTFOUND;
							  EXIT;
							  END LOOP;
						EXCEPTION
						WHEN OTHERS THEN
							 DBMS_OUTPUT.PUT_LINE (SQLERRM);
						END;

						IF NVL(vn_DERIV_RUT,0) = 0 THEN
						   vn_DERIV_RUT:=vn_RUT_PRESTADOR_SOLICITANTE;
						   vv_DERIV_DIGRUT:=Digito_Rut(TO_CHAR(vn_DERIV_RUT));
						END IF;
						vn_DERIV_CODIGO_INTERNO:=vn_CODIGO_MED_SOLICITANTE;


					vn_BANDERA:=1514;

					ELSE -- NO EXISTE REB_CORRELATIVO ASOCIADO AL BONO RESCATAR VALORES DE LOS PARAMETROS DE ENTRADA DEL SERVICIO
						-- RESCATANDO DATOS DEL CONTRATO
						BEGIN
							SELECT NVL(PORCENT_BONI_HOSP,0), NVL(PORCENT_BONI_AMBU,0), NVL(PORCENT_BONI_DENT,0), NVL(PORCENT_BONI_MEDI,0)
							INTO   vn_BONIF_HOSPITALARIA,vn_BONIF_AMBULATORIA,vn_BONIF_DENTAL,vn_BONIF_MEDICAMENTOS
							FROM   AFI_CONTRATOS_AFILIADOS
							WHERE  FOLIO_SUSCRIPCION = vn_COAF_FOLIO_SUSCRIPCION;
						EXCEPTION
						WHEN OTHERS THEN
							vn_BONIF_HOSPITALARIA:=0;
							vn_BONIF_AMBULATORIA:=0;
							vn_BONIF_DENTAL:=0;
							vn_BONIF_MEDICAMENTOS:=0;
						END;

						vn_CUME_CORRELATIVO :=NULL;
						vn_PREST_CODIGO_INTERNO:=vn_CODIGO_INTERNO_FACTURADOR;
						vn_PREST_CODIGO_INTERNO_TRAT:=vn_CODIGO_PRESTADOR;

TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
						vn_DERIV_CODIGO_INTERNO:=vn_CODIGO_MED_SOLICITANTE;
						vn_LUAT_CORRELATIVO:=vn_CORR_LA_CONV_NUEVO;
						vn_DOCO_CORRELATIVO:=NULL;
						--vv_FECHA_PRESTACION:=TO_CHAR(SYSDATE,'DD/MM/RRRR');
						vv_TIPO_PRESTACION:='IMED';
						vn_DERIV_RUT:=vn_RUT_PRESTADOR_SOLICITANTE;
						vv_DERIV_DIGRUT:=Digito_Rut(TO_CHAR(vn_DERIV_RUT));
						vv_IMPRESION_POR_TOPE:='N';
						vn_TIPO_CENTRO_COSTO:=vn_CENTRO_COSTO;
						DBMS_OUTPUT.PUT_LINE ( 'vn_CENTRO_COSTO= ' || vn_CENTRO_COSTO );
					END IF;
					vv_FECHA_PRESTACION:=TO_CHAR(SYSDATE,'DD/MM/RRRR');

					IF NVL(vn_DERIV_CODIGO_INTERNO,0) = 0 THEN
					   vn_DERIV_CODIGO_INTERNO:=NULL;
					END IF;

					vn_BANDERA:=1515;
					DBMS_OUTPUT.PUT_LINE ( 'vn_TIPO_CENTRO_COSTO= ' || vn_TIPO_CENTRO_COSTO );
					DBMS_OUTPUT.PUT_LINE ( 'vn_DOBE_CORRELATIVO= ' || vn_DOBE_CORRELATIVO );
					DBMS_OUTPUT.PUT_LINE ( 'vn_DOLI_CORRELATIVO= ' || vn_DOLI_CORRELATIVO );
					DBMS_OUTPUT.PUT_LINE ( 'vn_DERIV_RUT= ' || vn_DERIV_RUT );
					DBMS_OUTPUT.PUT_LINE ( 'vv_DERIV_DIGRUT= ' || vv_DERIV_DIGRUT );
					DBMS_OUTPUT.PUT_LINE ( 'vn_DOFI_CODIGO= ' || vn_DOFI_CODIGO );
					DBMS_OUTPUT.PUT_LINE ( 'vv_POSEE_BENEFICIO_BC24= ' || vv_POSEE_BENEFICIO_BC24 );
					DBMS_OUTPUT.PUT_LINE ( 'vn_TIPO_ATENCION= ' || vn_TIPO_ATENCION );
					--ELSIF vv_POSEE_BENEFICIO_BC24='BC24' AND vn_TIPO_ATENCION=3 THEN
					--vn_DOFI_CODIGO:=990;
					--EACE 02-02-2009
					IF vv_POSEE_BENEFICIO_BC24 = 'S' AND  vn_TIPO_ATENCION = 3 THEN
					   vn_DOFI_CODIGO:=990;
					ELSIF vv_POSEE_BENEFICIO_BC15 = 'S' AND  vn_TIPO_ATENCION = 3 THEN
					   vn_DOFI_CODIGO:=990;
					ELSIF vv_POSEE_BENEFICIO_BC33 = 'S' AND  vn_TIPO_ATENCION = 3 THEN
					   vn_DOFI_CODIGO:=990;
/* INICIO BNF-000955 BC 99 Rut 88.888.889-6*/
					ELSIF vv_POSEE_BENEFICIO_BC99 = 'S' AND  vn_TIPO_ATENCION = 3 THEN
					   vn_DOFI_CODIGO:=990;
/* FIN BNF-000955 BC 99 Rut 88.888.889-6*/
					ELSE
				       vn_DOFI_CODIGO:=920;
					END IF;
					vv_USUARIO_CREACION:=v_vExtHomNumeroConvenio||'/'||v_vExtRutCajero;

					vn_DOLI_CORRELATIVO:=vn_DOBE_CORRELATIVO;

					Pck_Ben_Docu_Liqui_Imed.P_MANT_BEN_DCTO_LIQUIDACIONES(
											vn_DOLI_CORRELATIVO,
											'BONO',--DOLI_TYPE,
											'EMI',-- ESTADO,
											vn_CUME_CORRELATIVO,--CUME_CORRELATIVO,
											vn_CODIGO_CARGA,--DOLI.CODIGO_CARGA,
											vn_COAF_FOLIO_SUSCRIPCION,--DOLI.FOLIO_SUSCRIPCION,
											vn_CODIGO_ISAPRE,--v_nORGA_CODIGO_ISAPRE,
											vn_PLAN_CORRELATIVO,--DOLI.PLAN_CORRELATIVO,
											NULL,--DOLI.NUMERO_PAM,
											TO_CHAR(SYSDATE,'DD/MM/RRRR HH24:MI:SS'), --FECHA_CREACION,
											TRIM(vv_USUARIO_CREACION),--DOLI.USUARIO_CREACION,
											vn_UNOR_CORRELATIVO_CREACION,--v_nUNOR_CORRELATIVO_CREACION,
											vn_PREST_CODIGO_INTERNO,--DOLI.PREST_CODIGO_INTERNO,
											vn_PREST_CODIGO_INTERNO_TRAT,--DOLI.PREST_CODIGO_INTERNO_TRATANTE,
											vn_DERIV_CODIGO_INTERNO,--PREST_CODIGO_INT_DERIV,
											TO_CHAR(SYSDATE,'DD/MM/RRRR HH24:MI:SS'),--FECHA_HORA_EMISION,
											vn_UNOR_CORRELATIVO_CREACION,
											vn_LUAT_CORRELATIVO,
											vn_DOCO_CORRELATIVO,
											NULL,--CAEN_CODIGO,
											vn_TIPO_ATENCION,
											vn_BONIF_HOSPITALARIA,
											vn_BONIF_AMBULATORIA,
											vn_BONIF_DENTAL,
											vn_BONIF_MEDICAMENTOS,
											vn_PLAN_CORRELATIVO_SIETE,
											vn_RUT_BENEFICIARIO,
											Digito_Rut(TO_CHAR(vn_RUT_BENEFICIARIO)),
--											vv_DIGRUT,
											TRIM(vv_FECHA_PRESTACION),--DOLI.FECHA_PRESTACION,--FEC_OTORGA_PRESTAC,
											vn_TIPO_CENTRO_COSTO,--TIPO_CENTRO_COSTO (1=Prev,2=Curativa,3=Maternal,4=Dental)
											vn_RUT_COBRADOR_REEMBOLSO,
											TRIM(vv_DIGRUT_COBRADOR_REEMBOLSO),
											vn_NUMERO_DOCUMENTO,
											TRIM(vv_TIPO_DOCUMENTO),
											TRIM(vv_FECHA_PRESTACION),--FECHA_DE_DOCUMENTO,
											vn_NRO_TRANSACCION,
											TRIM(vv_TIPO_PRESTACION),
											NULL,--pi_vUSUARIO_MODIFICACION,
											TRIM(vv_IMPRESION_POR_TOPE),
											TRIM(vv_TIPO_MANUAL),
											vn_MOTIVO_MANUAL,
											vn_DERIV_RUT,
											TRIM(vv_DERIV_DIGRUT),
											TRIM(vv_TIPO_REEMBOLSO),
											vn_DOFI_CODIGO,
											TRIM(vv_URGENCIA_VITAL),
											TRIM(vv_USUARIO_AUT_MANUAL),
											vd_FECHA_AUT_MANUAL,
											TRIM(vv_AUT_MANUAL),
											'I',--TIPO_ACCION,
											vn_ERROR,
											vv_DESC_ERROR);
										--	COMMIT;
											DBMS_OUTPUT.PUT_LINE ( 'vn_ERROR= ' || vn_ERROR );
											DBMS_OUTPUT.PUT_LINE ( 'vv_DESC_ERROR= ' || vv_DESC_ERROR );

											IF 	vn_ERROR > 0 THEN
												RAISE e_INSERTA_BONO;
											END IF;


	vn_BANDERA:=16;

	FOR z IN 1..vn_CANT_LINEAS LOOP

		BEGIN
			SELECT iaux.prestacion_CONVERTIDA
			INTO   vn_PRESTACION_BONIFICADA
			FROM   IMED_AUXILIAR iaux
			WHERE  iaux.rut		   			    = vn_COAF_FOLIO_SUSCRIPCION
			AND    iaux.carga				    = vn_CODIGO_CARGA
			AND    iaux.hom_num_convenio 		= TO_NUMBER(v_vExtHomNumeroConvenio)
			AND    iaux.prestacion			    = t_LINEAS(z).prisa_codigo
			AND    IAUX.NUMERO_LINEA 			= t_LINEAS(z).num_linea;
		EXCEPTION
			WHEN OTHERS THEN
				 vn_PRESTACION_BONIFICADA		:= 	t_LINEAS(z).prisa_codigo;
		END;


		/*INSERT INTO IMED_LIBE  (dobe_correlativo,
								num_linea ,
								estado,
								monto_copago ,
								monto_isapre,
								monto_otros,
								monto_total,
								numero_prestaciones ,
								prisa_codigo,
								prest_codigo_interno,
								numero_boleta,
								fecha_boleta,
								prest_codigo_interno_derivado,
								tipo_documento,
								aubo_usua_username,
								aubo_fecha,
								depb_correlativo,
								esp_codigo,
								monto_bcc,
								impresion_por_tope,
								cant_prest_paquete,
								num_linea_intervencion,
								inpr_prme_folio,
								inpr_num_intervencion,
								MONTO_GES, --EACE 28-06-2005  GES
								COPAGO_GES, --EACE 28-06-2005  GES
								CODIGO_GRUPO,--EACE 28-06-2005	GES
								MONTO_DSCTO_MEGA,--PGP 29/12/2005 BC15
								BENEF_COMP_APLICADO
								,Monto_Descto_Especial	-- ACS 08/06/2006
								,Monto_Precio_Rebajado	   --ACS 08/06/2006
								,Monto_Bonif_Precio_Rebajado  --ACS 08/06/2006
								) --PGP 29/12/2005 BC15
	 				VALUES (t_LINEAS(z).dobe_correlativo,
								t_LINEAS(z).num_linea,
								t_LINEAS(z).estado,
								-- MJBV  25-03-2003		   t_LINEAS(z).monto_copago,
								t_lineas(z).monto_total - (t_lineas(z).monto_isapre - t_lineas(z).monto_bcc) , -- 29-05-2006  t_LINEAS(z).monto_copago + t_LINEAS(z).monto_bcc,
								-- MJBV  25-03-2003				t_LINEAS(z).monto_isapre,
								t_LINEAS(z).monto_isapre - t_LINEAS(z).monto_bcc,
								t_LINEAS(z).monto_otros,
								t_LINEAS(z).monto_total,
								t_LINEAS(z).numero_prestaciones,
								vn_PRESTACION_BONIFICADA,  -- EACE 02/08/2006 t_LINEAS(z).prisa_codigo,
								t_LINEAS(z).prest_codigo_interno,
								0,
								NULL,
								DECODE(vn_CODIGO_MED_SOLICITANTE,0,NULL,vn_CODIGO_MED_SOLICITANTE),
								NULL,
								v_vExtHomNumeroConvenio||'/'||v_vExtRutCajero,
								SYSDATE,
								NULL,
								SUBSTR(t_LINEAS(z).esp_codigo,1,3),
								t_LINEAS(z).monto_bcc,
								NULL,
								0,
								0,
								NULL,
								NULL,
								t_LINEAS(z).monto_ges, 		--EACE 28-06-2005  GES
								t_LINEAS(z).copago_ges,		--EACE 28-06-2005  GES
								t_LINEAS(z).codigo_grupo,   --EACE 28-06-2005  GES
								t_LINEAS(z).monto_dscto_mega,--PGP 29/12/2005 BC15
								t_LINEAS(z).benef_comp_aplicado --PGP 29/12/2005 BC15
								,t_LINEAS(z).Monto_Descto_Especial  --ACS 08/06/2006
								,t_LINEAS(z).Monto_Precio_Rebajado	--ACS 08/06/2006
								,t_LINEAS(z).Monto_Bonif_Precio_Rebajado --ACS 08/06/2006
								);*/

					vn_NUMERO_LINEA:=t_LINEAS(z).num_linea;

					vv_INTERNO_ISAPRE:=Saca_String(v_vExtLista,v_vSeparador,(z*19)-10);
					--vn_AUDI_CORRELATIVO:=TO_NUMBER(SUBSTR(TRIM(vv_INTERNO_ISAPRE),1,LENGTH(TRIM(vv_INTERNO_ISAPRE))-3));
					vv_LINEA_AUDI:=SUBSTR(TRIM(vv_INTERNO_ISAPRE),LENGTH(TRIM(vv_INTERNO_ISAPRE))-1,LENGTH(TRIM(vv_INTERNO_ISAPRE)));
					vn_LINEA_AUDI:=TO_NUMBER(vv_LINEA_AUDI);
					vn_BANDERA:=1517;
					DBMS_OUTPUT.PUT_LINE ( 'vv_INTERNO_ISAPRE= ' || vv_INTERNO_ISAPRE );
					DBMS_OUTPUT.PUT_LINE ( 'vn_AUDI_CORRELATIVO= ' || vn_AUDI_CORRELATIVO );
					DBMS_OUTPUT.PUT_LINE ( 'vn_LINEA_AUDI= ' || vn_LINEA_AUDI );

					--if vn_LINEA_AUDI = 0 then
--					   raise E_BONO_EXISTE;

					--end if;

					BEGIN
						SELECT NVL(DETALLE.REB_CORRELATIVO,0),NVL(SECO_CORRELATIVO,0), NVL(DNP_CORRELATIVO,0),NVL(NUMERO_PRESTACIONES,0),NVL(MONTO_COPAGO,0), audi.FECHOR_LLEGADA,audi.TIENE_ORDEN_DERIVACION, audi.NUMERO_ORDEN_DERIVACION, audi.SERV_ORDEN_DERIV_FULL,DETALLE.GARA_CODIGO,DETALLE.GRUP_SECUENCIA --eace 02-02-2009
						INTO   vn_REB_LN_CORRELATIVO,vn_LN_SECO_CORRELATIVO,vn_LN_DNP_CORRELATIVO,vn_LN_CANTIDAD,vn_LN_VALOR_COPAGO, vd_Fecha_valorizacion,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_LN_SERV_DERIVACION_FULL_OFI,vn_LN_GRUP_GARA_CODIGO,vn_LN_GRUP_SECUENCIA
						FROM   IMED_AUDITORIA AUDI,
						   	   IMED_DETALLE_AUDITORIA DETALLE
						WHERE  AUDI.CORRELATIVO=DETALLE.AUDI_CORRELATIVO
						AND	   AUDI.CORRELATIVO=vn_AUDI_CORRELATIVO
						AND	   DETALLE.NUM_LINEA = vn_LINEA_AUDI;

						-- UPDATE BENEFICIOS.BEN_REPOSITORIO_EMISION_BONOS
						-- SET	  REGISTRAR_TOPE ='N'
						-- WHERE  CORRELATIVO = 	vn_REB_LN_CORRELATIVO;

						SELECT COUNT(*)
						INTO   vn_EXISTE_REP_LN
						FROM   BENEFICIOS.BEN_REPOSITORIO_EMISION_BONOS
						WHERE  CORRELATIVO =vn_REB_LN_CORRELATIVO;


			vn_EXISTE_REP_RESP_LN:=0;
			SELECT COUNT(*)
			INTO   vn_EXISTE_REP_RESP_LN
			FROM   IMED_REPOSITORIO_EMISION_BONOS
			WHERE  CORRELATIVO =vn_REB_LN_CORRELATIVO;

			vn_EXISTE_REP_LN:=NVL(vn_EXISTE_REP_LN,0) + NVL(vn_EXISTE_REP_RESP_LN,0);

					EXCEPTION
					WHEN OTHERS THEN
						 vn_REB_LN_CORRELATIVO:=0;
						 vn_LN_SECO_CORRELATIVO:=0;
						 vn_LN_DNP_CORRELATIVO:=0;
						 vn_LN_CANTIDAD:=0;
						 vn_LN_VALOR_COPAGO:=0;
						 vn_EXISTE_REP_LN:=0;
			 vn_EXISTE_REP_RESP_LN:=0;
					END;


						IF 	NVL(vn_EXISTE_REP_LN,0) <> 0 OR NVL(vn_EXISTE_REP_RESP_LN,0) <> 0 THEN -- EXISTE UN REB_CORRELATIVO ASOCIADO A LA LINEA
						   	vn_BANDERA:=1518;

			    vn_GaraCodigo   := NVL(TO_NUMBER(F_RESCATA_DATOS_REPOSITORIO(vn_REB_LN_CORRELATIVO, 'CARTILLA GES')),0);
			    vn_GrupSecuencia:= NVL(TO_NUMBER(F_RESCATA_DATOS_REPOSITORIO(vn_REB_LN_CORRELATIVO, 'GRUPO GES')),0);

			    IF vn_GaraCodigo <>0 THEN
				vv_ES_GES:='S';
			    ELSE
				vv_ES_GES:='N';
				vn_GaraCodigo := NULL;
				vn_GrupSecuencia := NULL;
			    END IF;




							Pck_Ben_Docu_Liqui_Imed.P_RESCATA_INFO_REPOSITORIO(vn_REB_LN_CORRELATIVO,
				  							 								   'LINEA',
				  							 								   vn_CODIGO_ERROR_BUSQ_BONO,
											 								   vv_DESC_ERROR_BUSQ_NONO,
											 								   cur_LN_BONO);


							BEGIN
								  LOOP
								  FETCH cur_LN_BONO INTO
									  vn_LN_PRISA_CODIGO,
									  vn_LN_SECO_CORRELATIVO,
									  vn_LN_DNP_CORRELATIVO,
									  vn_LN_COMPONENTE,
									  vn_LN_PRCO_CORRELATIVO,
									  vn_LN_PREST_CODIGO_INT_DET,
									  vn_LN_PREST_CODIGO_INT_TRAT,
									  vv_LN_VALOR_CONVoCOBRADO,-- FUERA UNO SOLO
									  vv_LN_VALOR_FORZADO,
									  vn_LN_CANTIDAD,
									  vn_LN_VALOR_COPAGO,
									  vv_LN_VALOR_PAGAR_PREST,
									  vv_LN_VALOR_APLICADO,
									  vv_LN_IMPRESION_POR_TOPE,
									  vv_LN_COPAGO_GRATIS_GES,
									  vn_LN_MONTO_COB_AD_GES,
									  vn_LN_MONTO_COB_AD_GES_CAEC,
									  vn_LN_TOPE_CORRELATIVO,
									  vn_LN_TOPE_CORRELATIVO_BC,
				      vv_LN_ORDEN_DERIVACION,
				      vn_LN_NRO_ORDEN_DERIVACION,
				      vv_LN_SERV_DERIVACION_FULL_OFI,
				      vv_LN_ATENCION;

									  DBMS_OUTPUT.PUT_LINE ( 'vn_LN_VALOR_COPAGO= ' || vn_LN_VALOR_COPAGO );
								  EXIT WHEN cur_LN_BONO%NOTFOUND;
								  EXIT;
								  END LOOP;
							EXCEPTION
							WHEN OTHERS THEN
								 DBMS_OUTPUT.PUT_LINE ('ERROR DATOS LINEA');
								 DBMS_OUTPUT.PUT_LINE (SQLERRM);
							END;
						ELSE  -- NO EXISTE REB_CORRELATIVO ASOCIADO AL BONO RESCATAR VALORES DE LOS PARAMETROS DE ENTRADA DEL SERVICIO


							  DBMS_OUTPUT.PUT_LINE ( 'linea sin repositorio' );

							  DBMS_OUTPUT.PUT_LINE ( 't_lineas(z).monto_total= ' || t_lineas(z).monto_total );
							  DBMS_OUTPUT.PUT_LINE ( 't_lineas(z).monto_isapre= ' || t_lineas(z).monto_isapre );
							  DBMS_OUTPUT.PUT_LINE ( 't_lineas(z).monto_bcc= ' || t_lineas(z).monto_bcc );


							  vn_LN_CANTIDAD		:=  t_LINEAS(z).numero_prestaciones;
							  vn_LN_PRISA_CODIGO	    :=t_LINEAS(z).prisa_codigo;--vn_PRESTACION_BONIFICADA;
							  vn_LN_COMPONENTE	    :=0;
							  vn_LN_PRCO_CORRELATIVO    :=NULL;
							  vn_LN_PREST_CODIGO_INT_DET:=vn_CODIGO_MED_SOLICITANTE;
							  vn_LN_PREST_CODIGO_INT_TRAT:=vn_CODIGO_PRESTADOR;
							  vv_LN_VALOR_CONVoCOBRADO   :=TO_CHAR(t_LINEAS(z).monto_total);
							  vv_LN_VALOR_FORZADO	     :='';
							  vv_LN_VALOR_PAGAR_PREST    :=vv_LN_VALOR_CONVoCOBRADO;
							  vv_LN_VALOR_APLICADO	     :=vv_LN_VALOR_CONVoCOBRADO;
							  vv_LN_VALOR_CONVENIDO      :=vv_LN_VALOR_CONVoCOBRADO;
							  vv_LN_IMPRESION_POR_TOPE   :='N';
							  vv_LN_COPAGO_GRATIS_GES    :=TO_CHAR(t_LINEAS(z).copago_ges);
							  vn_LN_MONTO_COB_AD_GES     :=0;
							  vn_LN_MONTO_COB_AD_GES_CAEC:=0;
							  vn_LN_TOPE_CORRELATIVO     :=0;
							  vn_LN_TOPE_CORRELATIVO_BC  :=0;
							  vn_LN_VALOR_COPAGO	     :=(t_lineas(z).monto_total - (t_lineas(z).monto_isapre - t_lineas(z).monto_bcc)) - t_lineas(z).monto_bcc;--t_lineas(z).monto_total - (t_lineas(z).monto_isapre - t_lineas(z).monto_bcc);
			      vv_LN_ORDEN_DERIVACION	 := NULL;
			      vn_LN_NRO_ORDEN_DERIVACION := NULL;
			      vv_LN_SERV_DERIVACION_FULL_OFI :=NULL;
			   --	vv_LN_ATENCION := 'NORMAL';

			      DBMS_OUTPUT.PUT_LINE ( 'v_vCARTILLA_GES_FF = ' || v_vCARTILLA_GES_FF );

--			     *G*-034-2-0006 to_number(substr(v_vCARTILLA_GES_FF,5,3))||

			      If substr(v_vCARTILLA_GES_FF,1,3)='*G*' then
				  begin
				      SELECT GRUP.GARA_CODIGO, GRUP.SECUENCIA
				      INTO vn_GaraCodigo,vn_GrupSecuencia
				      FROM GESARA.GEAR_GRUPOS GRUP
				      WHERE GRUP.CODIGO = to_number(substr(v_vCARTILLA_GES_FF,5,3))||decode(to_number(substr(v_vCARTILLA_GES_FF,9,1)),1,'D',2,'T',3,'S')||to_number(substr(v_vCARTILLA_GES_FF,11,4))
				      ;
				  exception
				  when Others then
				      vn_GaraCodigo    :=Null;
				      vn_GrupSecuencia :=Null;
				  end;
			      else
				  vn_GaraCodigo    :=Null;
				  vn_GrupSecuencia :=Null;
			      End if;
--				vn_GaraCodigo	 :=vn_LN_GRUP_GARA_CODIGO;
--				vn_GrupSecuencia := vn_LN_GRUP_SECUENCIA;

			      IF vn_GaraCodigo <>0 THEN

				vv_ES_GES:='S';

			      ELSE

				vv_ES_GES:='N';
				vn_GaraCodigo := NULL;
				vn_GrupSecuencia := NULL;

			      END IF;




							  DBMS_OUTPUT.PUT_LINE ( 'vn_LN_VALOR_COPAGO= ' || vn_LN_VALOR_COPAGO );
						END IF;


							IF vn_LN_DNP_CORRELATIVO <> 0 THEN
				 			   vv_LN_VALOR_CONVENIDO:=vv_LN_VALOR_CONVoCOBRADO;
				 			ELSE
				 			   vv_VALOR_COBRADO:=vv_LN_VALOR_CONVoCOBRADO;
						    END IF;

								vn_BANDERA:=1519;
								DBMS_OUTPUT.PUT_LINE ( 'TO_NUMBER(vv_LN_VALOR_COPAGO)= ' || vn_LN_VALOR_COPAGO) ;
								Pck_Ben_Docu_Liqui_Imed.P_MANT_BEN_LINEA_LIQUIDACIONES(
																				  vn_DOLI_CORRELATIVO,
																				  vn_NUMERO_LINEA,
																				  vn_LN_PRISA_CODIGO,
																				  vn_LN_SECO_CORRELATIVO,
																				  vn_LN_DNP_CORRELATIVO,
																				  vn_LN_COMPONENTE,
																				  vn_LN_PRCO_CORRELATIVO,
																				  vn_LN_PREST_CODIGO_INT_DET,
																				  vn_LN_PREST_CODIGO_INT_TRAT,
																				  vv_LN_VALOR_CONVENIDO,
																				  vv_LN_VALOR_FORZADO,
																				  vv_VALOR_COBRADO,
																				  vn_LN_CANTIDAD,
																				  vn_LN_VALOR_COPAGO,
																				  vv_LN_VALOR_PAGAR_PREST,
																				  vv_LN_VALOR_APLICADO,
																				  vv_LN_IMPRESION_POR_TOPE,
																				  vv_LN_ATENCION,--'NORMAL',
																				  vv_LN_COPAGO_GRATIS_GES,
																				  vn_LN_MONTO_COB_AD_GES,
																				  vn_LN_MONTO_COB_AD_GES_CAEC,
																				  vn_LN_TOPE_CORRELATIVO,
																				  vv_LN_ORDEN_DERIVACION,
																				  vn_LN_TOPE_CORRELATIVO_BC,
																				  'I',
										  vn_LN_ERROR,
																				  vv_LN_DESC_ERROR,
										  vn_LN_NRO_ORDEN_DERIVACION,
										  vv_LN_SERV_DERIVACION_FULL_OFI);

		vn_BANDERA:=17;
		IF 	vn_LN_ERROR > 0 THEN
			RAISE e_LINEA_BONO;
	END IF;

		DBMS_OUTPUT.PUT_LINE ( 'NVL(vn_EXISTE_REP_LN,0)= ' || NVL(vn_EXISTE_REP_LN,0) );

		IF 	NVL(vn_EXISTE_REP_LN,0) <> 0 OR NVL(vn_EXISTE_REP_RESP_LN,0) <> 0 THEN
			DBMS_OUTPUT.PUT_LINE ( 'P_CARGA_RESP_COBERTURA_LIQU ' );
			Pck_Ben_Docu_Liqui_Imed.P_CARGA_RESP_COBERTURA_LIQU(vn_REB_LN_CORRELATIVO,
					  							  					   vn_DOLI_CORRELATIVO,
												  					   vn_NUMERO_LINEA,
												  					   vn_ERROR_CARGA_REP,
														       vv_DESC_ERROR_CARGA_REP);

	    IF vn_ERROR_CARGA_REP > 0 THEN
		RAISE e_LINEA_BONO;
	    END IF;
		ELSE
			DBMS_OUTPUT.PUT_LINE ( 'vv_ES_GES= ' || vv_ES_GES );
			IF vv_ES_GES = 'S' THEN

			   DBMS_OUTPUT.PUT_LINE ( 'P_INSERT_DECO ' );
			   Pck_Ben_Docu_Liqui_Imed.P_INSERT_DECO(vn_DOLI_CORRELATIVO,
												  				 vn_NUMERO_LINEA,
											   	  				 1,
											   	  				 t_lineas(z).monto_total - t_lineas(z).monto_GES,
												  				 0,--REG.MONTO_COBERTURA_FORZADA,
												  				 t_lineas(z).monto_total - t_lineas(z).monto_GES,
											   	  				 'GES',
											   	  				 vn_ERROR_DECO,
											   	  				 vv_ERROR_DECO);

			   DBMS_OUTPUT.PUT_LINE ( 'P_INSERT_RECO ' );

			   Pck_Ben_Docu_Liqui_Imed.P_INSERT_RECO('GES',--RCCR.TIBE_CODIGO,
											  					 vn_DOLI_CORRELATIVO,--pi_nLIQU_DOLI_CORRELATIVO,
											  					 vn_NUMERO_LINEA,--pi_nLIQU_NUMERO_LINEA,
																 1,--REG.NUMERO,
																 vv_LN_VALOR_CONVoCOBRADO,--RCCR.MONTO_PRESTACION_CALCULO,
																 t_lineas(z).monto_total - (t_lineas(z).monto_total - t_lineas(z).monto_GES),--RCCR.MONTO_BONIFICADO,
																 t_lineas(z).monto_total - t_lineas(z).monto_GES, --RCCR.MONTO_COPAGO,
																 NULL,--RCCR.ITEM,
								 vn_GaraCodigo,--RCCR.GRUP_GARA_CODIGO,
																 vn_GrupSecuencia,--RCCR.GRUP_SECUENCIA,
																 vn_PLAN_CORRELATIVO,--RCCR.PLAN_CORRELATIVO,
																 NULL,--RCCR.PLBC_CORRELATIVO,
																 NULL,--RCCR.VALOR_ARANCEL,
																 NULL,--RCCR.ES_PREFERENTE,
																 NULL,--RCCR.PORCENTAJE_COBERTURA,
																 NULL,--RCCR.VALOR_TOPE,
																 NULL,--RCCR.UNIDAD_MEDIDA_TOPE,
																 NULL,--RCCR.TIPO_TOPE,
																 NULL,--RCCR.VALOR_TOPE_ANUAL,
																 NULL,--RCCR.UNIDAD_MEDIDA_TOPE_ANUAL,
																 NULL,--RCCR.TIPO_COPAGO,
																 NULL,--RCCR.VALOR_COPAGO,
																 NULL,--RCCR.UNIDAD_MEDIDA_COPAGO,
																 NULL,--RCCR.VALOR_TOPE_COPAGO,
																 NULL,--RCCR.UNIDAD_MEDIDA_TOPE_COPAGO,
																 NULL,--RCCR.BONIFICABLE,
																 NULL,--RCCR.BLOQUEADA,
																 NULL,--RCCR.CON_COBERTURA,
																 NULL,--RCCR.PREST_CODIGO_INTERNO_COB,
																 NULL,--RCCR.MONTO_MINIMO_APLICADO,
																 NULL,--RCCR.TIPO_MONTO_MINIMO_APLICADO,
																 NULL,--RCCR.OBSERVACIONES,
																 NULL,--RCCR.CODP_CORRELATIVO,
														   		 vn_ERROR_RECO,
														   		 vv_ERROR_RECO);
			ELSE

			DBMS_OUTPUT.PUT_LINE ( 't_lineas(z).monto_isapre= ' || t_lineas(z).monto_isapre );

			IF t_lineas(z).monto_isapre <> 0 THEN

		--********************************************************************************************************************
		--BNF-000806 :Proceso que verifica si el beneficiario y la prestacion corresponde a Full Capita y cambia el tipo de
		--	      cobertura PLAN a Cobertura PLANBC
		--********************************************************************************************************************
		BEGIN
		    v_nPLBC_CORRELATIVO:=NULL;
		    P_VALIDA_CAPITA(vn_COAF_FOLIO_SUSCRIPCION,
				    vn_LN_PRISA_CODIGO,
				    vv_FECHA_PRESTACION,
				    vn_LUAT_CORRELATIVO,
				    1,			    --Tipo Capita (1 = Full Capita / 2 = Capita Cabecera)
				    'A',		    --H:=Hosp./A=Ambu./D=Dental
				    v_nPLBC_CORRELATIVO,
				    v_nERROR,
				    v_vDESC_ERROR
				    ,vn_CODIGO_CARGA,vn_PREST_CODIGO_INTERNO
						    );
		EXCEPTION
		    WHEN OTHERS THEN
			 v_nPLBC_CORRELATIVO:=NULL;
		END;

		IF v_nPLBC_CORRELATIVO IS NULL THEN
		    BEGIN
			v_nPLBC_CORRELATIVO:=NULL;
			P_VALIDA_CAPITA(vn_COAF_FOLIO_SUSCRIPCION,
					vn_LN_PRISA_CODIGO,
					vv_FECHA_PRESTACION,
					vn_LUAT_CORRELATIVO,
					2,			--Tipo Capita (1 = Full Capita / 2 = Capita Cabecera)
					'A',			--H:=Hosp./A=Ambu./D=Dental
					v_nPLBC_CORRELATIVO,
					v_nERROR,
					v_vDESC_ERROR
					,vn_CODIGO_CARGA--,vn_PREST_CODIGO_INTERNO
					);
		    EXCEPTION
			WHEN OTHERS THEN
			     v_nPLBC_CORRELATIVO:=NULL;
		    END;
		END IF;

--		  IF v_nPLBC_CORRELATIVO IS NULL THEN
--		      BEGIN
--			  v_nPLBC_CORRELATIVO:=NULL;
--			  P_VALIDA_CAPITA(vn_COAF_FOLIO_SUSCRIPCION,
--					  vn_LN_PRISA_CODIGO,
--					  vv_FECHA_PRESTACION,
--					  vn_LUAT_CORRELATIVO,
--					  3,			  --Tipo Capita (1 = Full Capita / 2 = Capita Cabecera / 3 = Arauco)
--					  'A',			  --H:=Hosp./A=Ambu./D=Dental
--					  v_nPLBC_CORRELATIVO,
--					  v_nERROR,
--					  v_vDESC_ERROR
--					  ,vn_CODIGO_CARGA,vn_PREST_CODIGO_INTERNO
--					);
--		      EXCEPTION
--			  WHEN OTHERS THEN
--			       v_nPLBC_CORRELATIVO:=NULL;
--		      END;
--		  END IF;



		IF NVL(v_nPLBC_CORRELATIVO,0) > 0 THEN
		    v_vTIBE_CODIGO_RECO:='PLANBC';
		    v_nPLAN_CORRELATIVO_RECO:=NULL;
		    v_nPLBC_CORRELATIVO_RECO:=v_nPLBC_CORRELATIVO;
		ELSE
		    v_vTIBE_CODIGO_RECO:='PLACOMP';
		    v_nPLAN_CORRELATIVO_RECO:=vn_PLAN_CORRELATIVO;
		    v_nPLBC_CORRELATIVO_RECO:=NULL;
		END IF;
		--********************************************************************************************************************
		--********************************************************************************************************************

			    Pck_Ben_Docu_Liqui_Imed.P_INSERT_DECO(vn_DOLI_CORRELATIVO,
												  				 vn_NUMERO_LINEA,
											   	  				 1,
											   	  				 t_lineas(z).monto_isapre  - NVL(t_LINEAS(z).Monto_credito,0) - t_lineas(z).monto_bcc,
												  				 0,--REG.MONTO_COBERTURA_FORZADA,
												  				 t_lineas(z).monto_isapre - NVL(t_LINEAS(z).Monto_credito,0) - t_lineas(z).monto_bcc,
											   	  				 v_vTIBE_CODIGO_RECO,
											   	  				 vn_ERROR_DECO,
											   	  				 vv_ERROR_DECO);

				Pck_Ben_Docu_Liqui_Imed.P_INSERT_RECO(v_vTIBE_CODIGO_RECO,--RCCR.TIBE_CODIGO,
											  					 vn_DOLI_CORRELATIVO,--pi_nLIQU_DOLI_CORRELATIVO,
											  					 vn_NUMERO_LINEA,--pi_nLIQU_NUMERO_LINEA,
																 1,--REG.NUMERO,
																 vv_LN_VALOR_CONVoCOBRADO,--RCCR.MONTO_PRESTACION_CALCULO,
																 t_lineas(z).monto_isapre - t_lineas(z).monto_bcc - t_LINEAS(z).Monto_credito,--RCCR.MONTO_BONIFICADO,
																 t_lineas(z).monto_total - (t_lineas(z).monto_isapre - t_lineas(z).monto_bcc - t_LINEAS(z).Monto_credito), --RCCR.MONTO_COPAGO,
																 NULL,--RCCR.ITEM,
																 NULL,--RCCR.GRUP_GARA_CODIGO,
																 NULL,--RCCR.GRUP_SECUENCIA,
																 v_nPLAN_CORRELATIVO_RECO,--RCCR.PLAN_CORRELATIVO,
																 v_nPLBC_CORRELATIVO_RECO,--RCCR.PLBC_CORRELATIVO,
																 NULL,--RCCR.VALOR_ARANCEL,
																 NULL,--RCCR.ES_PREFERENTE,
																 NULL,--RCCR.PORCENTAJE_COBERTURA,
																 NULL,--RCCR.VALOR_TOPE,
																 NULL,--RCCR.UNIDAD_MEDIDA_TOPE,
																 NULL,--RCCR.TIPO_TOPE,
																 NULL,--RCCR.VALOR_TOPE_ANUAL,
																 NULL,--RCCR.UNIDAD_MEDIDA_TOPE_ANUAL,
																 NULL,--RCCR.TIPO_COPAGO,
																 NULL,--RCCR.VALOR_COPAGO,
																 NULL,--RCCR.UNIDAD_MEDIDA_COPAGO,
																 NULL,--RCCR.VALOR_TOPE_COPAGO,
																 NULL,--RCCR.UNIDAD_MEDIDA_TOPE_COPAGO,
																 NULL,--RCCR.BONIFICABLE,
																 NULL,--RCCR.BLOQUEADA,
																 NULL,--RCCR.CON_COBERTURA,
																 NULL,--RCCR.PREST_CODIGO_INTERNO_COB,
																 NULL,--RCCR.MONTO_MINIMO_APLICADO,
																 NULL,--RCCR.TIPO_MONTO_MINIMO_APLICADO,
																 NULL,--RCCR.OBSERVACIONES,
																 NULL,--RCCR.CODP_CORRELATIVO,
														   		 vn_ERROR_RECO,
														   		 vv_ERROR_RECO);
			END IF;
			IF t_lineas(z).monto_bcc <> 0 THEN
			   Pck_Ben_Docu_Liqui_Imed.P_INSERT_DECO(vn_DOLI_CORRELATIVO,
												  vn_NUMERO_LINEA,
											   	  2,
											   	  t_lineas(z).monto_bcc,
												  0,--REG.MONTO_COBERTURA_FORZADA,
												  t_lineas(z).monto_bcc,
											   	  'PLANBC',
											   	  vn_ERROR_DECO,
											   	  vv_ERROR_DECO);

			  Pck_Ben_Docu_Liqui_Imed.P_INSERT_RECO('PLANBC',--RCCR.TIBE_CODIGO,
											  					 vn_DOLI_CORRELATIVO,--pi_nLIQU_DOLI_CORRELATIVO,
											  					 vn_NUMERO_LINEA,--pi_nLIQU_NUMERO_LINEA,
																 2,--REG.NUMERO,
																 t_lineas(z).monto_total - (t_lineas(z).monto_isapre - t_lineas(z).monto_bcc - t_LINEAS(z).Monto_credito) ,--vv_LN_VALOR_CONVoCOBRADO,--RCCR.MONTO_PRESTACION_CALCULO,
																 t_lineas(z).monto_bcc,--t_lineas(z).monto_isapre,--RCCR.MONTO_BONIFICADO,
																 (t_lineas(z).monto_total - (t_lineas(z).monto_isapre - t_lineas(z).monto_bcc - t_LINEAS(z).Monto_credito)) - t_lineas(z).monto_bcc, --RCCR.MONTO_COPAGO,
																 NULL,--RCCR.ITEM,
																 NULL,--RCCR.GRUP_GARA_CODIGO,
																 NULL,--RCCR.GRUP_SECUENCIA,
																 vn_PLAN_CORRELATIVO,--RCCR.PLAN_CORRELATIVO,
																 NULL,--RCCR.PLBC_CORRELATIVO,
																 NULL,--RCCR.VALOR_ARANCEL,
																 NULL,--RCCR.ES_PREFERENTE,
																 NULL,--RCCR.PORCENTAJE_COBERTURA,
																 NULL,--RCCR.VALOR_TOPE,
																 NULL,--RCCR.UNIDAD_MEDIDA_TOPE,
																 NULL,--RCCR.TIPO_TOPE,
																 NULL,--RCCR.VALOR_TOPE_ANUAL,
																 NULL,--RCCR.UNIDAD_MEDIDA_TOPE_ANUAL,
																 NULL,--RCCR.TIPO_COPAGO,
																 NULL,--RCCR.VALOR_COPAGO,
																 NULL,--RCCR.UNIDAD_MEDIDA_COPAGO,
																 NULL,--RCCR.VALOR_TOPE_COPAGO,
																 NULL,--RCCR.UNIDAD_MEDIDA_TOPE_COPAGO,
																 NULL,--RCCR.BONIFICABLE,
																 NULL,--RCCR.BLOQUEADA,
																 NULL,--RCCR.CON_COBERTURA,
																 NULL,--RCCR.PREST_CODIGO_INTERNO_COB,
																 NULL,--RCCR.MONTO_MINIMO_APLICADO,
																 NULL,--RCCR.TIPO_MONTO_MINIMO_APLICADO,
																 NULL,--RCCR.OBSERVACIONES,
																 NULL,--RCCR.CODP_CORRELATIVO,
																 vn_ERROR_RECO,
														   		 vv_ERROR_RECO);

			END IF;

	    IF t_LINEAS(z).Monto_credito <> 0 THEN
			   Pck_Ben_Docu_Liqui_Imed.P_INSERT_DECO(vn_DOLI_CORRELATIVO,
												  vn_NUMERO_LINEA,
											   	  3,
											   	  t_LINEAS(z).Monto_credito,
												  0,--REG.MONTO_COBERTURA_FORZADA,
												  t_LINEAS(z).Monto_credito,
											   	  'CREDITO',
											   	  vn_ERROR_DECO,
											   	  vv_ERROR_DECO);

			  Pck_Ben_Docu_Liqui_Imed.P_INSERT_RECO('CREDITO',--RCCR.TIBE_CODIGO,
											  					 vn_DOLI_CORRELATIVO,--pi_nLIQU_DOLI_CORRELATIVO,
											  					 vn_NUMERO_LINEA,--pi_nLIQU_NUMERO_LINEA,
																 3,--REG.NUMERO,
																 t_lineas(z).monto_total - (t_lineas(z).monto_isapre - t_lineas(z).monto_bcc - t_LINEAS(z).Monto_credito) ,--vv_LN_VALOR_CONVoCOBRADO,--RCCR.MONTO_PRESTACION_CALCULO,
																 t_LINEAS(z).Monto_credito,--t_lineas(z).monto_isapre,--RCCR.MONTO_BONIFICADO,
																 (t_lineas(z).monto_total - (t_lineas(z).monto_isapre - t_lineas(z).monto_bcc - t_LINEAS(z).Monto_credito)) - t_lineas(z).monto_bcc - t_LINEAS(z).Monto_credito, --RCCR.MONTO_COPAGO,
																 NULL,--RCCR.ITEM,
																 NULL,--RCCR.GRUP_GARA_CODIGO,
																 NULL,--RCCR.GRUP_SECUENCIA,
																 vn_PLAN_CORRELATIVO,--RCCR.PLAN_CORRELATIVO,
																 NULL,--RCCR.PLBC_CORRELATIVO,
																 NULL,--RCCR.VALOR_ARANCEL,
																 NULL,--RCCR.ES_PREFERENTE,
																 NULL,--RCCR.PORCENTAJE_COBERTURA,
																 NULL,--RCCR.VALOR_TOPE,
																 NULL,--RCCR.UNIDAD_MEDIDA_TOPE,
																 NULL,--RCCR.TIPO_TOPE,
																 NULL,--RCCR.VALOR_TOPE_ANUAL,
																 NULL,--RCCR.UNIDAD_MEDIDA_TOPE_ANUAL,
																 NULL,--RCCR.TIPO_COPAGO,
																 NULL,--RCCR.VALOR_COPAGO,
																 NULL,--RCCR.UNIDAD_MEDIDA_COPAGO,
																 NULL,--RCCR.VALOR_TOPE_COPAGO,
																 NULL,--RCCR.UNIDAD_MEDIDA_TOPE_COPAGO,
																 NULL,--RCCR.BONIFICABLE,
																 NULL,--RCCR.BLOQUEADA,
																 NULL,--RCCR.CON_COBERTURA,
																 NULL,--RCCR.PREST_CODIGO_INTERNO_COB,
																 NULL,--RCCR.MONTO_MINIMO_APLICADO,
																 NULL,--RCCR.TIPO_MONTO_MINIMO_APLICADO,
																 NULL,--RCCR.OBSERVACIONES,
																 NULL,--RCCR.CODP_CORRELATIVO,
																 vn_ERROR_RECO,
														   		 vv_ERROR_RECO);

			END IF;

		  END IF;
		END IF;


		vn_BANDERA:=181;

		DBMS_OUTPUT.PUT_LINE ( 'vv_ES_GES= ' || vv_ES_GES );
		DBMS_OUTPUT.PUT_LINE ( 'vn_GaraCodigo= ' || vn_GaraCodigo );

		IF NVL(vn_GaraCodigo,0) <> 0 THEN
		    BEGIN
				SELECT NVL(CODIGO,0)
				INTO   vv_CODIGO_GRUPO
				FROM   GEAR_GRUPOS
				WHERE  GARA_CODIGO = vn_GaraCodigo
				AND	   SECUENCIA = vn_GrupSecuencia;
			EXCEPTION
			WHEN OTHERS THEN
				 RAISE no_emision_ges;
			END;
			DBMS_OUTPUT.PUT_LINE ( 'vn_DOLI_CORRELATIVO= ' || vn_DOLI_CORRELATIVO );
			DBMS_OUTPUT.PUT_LINE ( 'vn_NUMERO_LINEA= ' || vn_NUMERO_LINEA );
			DBMS_OUTPUT.PUT_LINE ( 'vn_LN_VALOR_COPAGO= ' || vn_LN_VALOR_COPAGO );
			DBMS_OUTPUT.PUT_LINE ( 'vv_LN_VALOR_CONVoCOBRADO= ' || vv_LN_VALOR_CONVoCOBRADO );
			DBMS_OUTPUT.PUT_LINE ( 'vn_LN_PRISA_CODIGO= ' || vn_LN_PRISA_CODIGO );
			DBMS_OUTPUT.PUT_LINE ( 'vv_CODIGO_GRUPO= ' || vv_CODIGO_GRUPO );
			DBMS_OUTPUT.PUT_LINE ( 'vn_COAF_FOLIO_SUSCRIPCION= ' || vn_COAF_FOLIO_SUSCRIPCION );
			DBMS_OUTPUT.PUT_LINE ( 'vn_CODIGO_ISAPRE= ' || vn_CODIGO_ISAPRE );
			DBMS_OUTPUT.PUT_LINE ( 'vn_CODIGO_CARGA= ' || vn_CODIGO_CARGA );
-- 			DBMS_OUTPUT.PUT_LINE ( 'vv_LN_VALOR_CONVoCOBRADO -vn_LN_VALOR_COPAGO= ' || vv_LN_VALOR_CONVoCOBRADO -vn_LN_VALOR_COPAGO );
-- 			DBMS_OUTPUT.PUT_LINE ( 'vn_LN_VALOR_COPAGO= ' || vn_LN_VALOR_COPAGO );
-- 			DBMS_OUTPUT.PUT_LINE ( 'vn_LIBE_MONTO_COBERT_ADIC_GES= ' || vn_LIBE_MONTO_COBERT_ADIC_GES );
-- 			DBMS_OUTPUT.PUT_LINE ( 'vv_CopagoGratis= ' || vv_CopagoGratis );
			Pck_Gesara_100_Bonificaciones.P_Graba_Emisiones3   ( vn_DOLI_CORRELATIVO, --Se agrega _imed el 30-05-2006
																	    vn_NUMERO_LINEA,
																		vn_LN_VALOR_COPAGO,--t_LINEAS(z).copago_ges,
																		vv_LN_VALOR_CONVoCOBRADO,--t_LINEAS(z).monto_total,
																		vn_LN_PRISA_CODIGO,--vn_PRESTACION_BONIFICADA, ---EACE 02/08/2006 t_LINEAS(z).prisa_codigo,
																		vv_CODIGO_GRUPO,--t_LINEAS(z).codigo_GRUPO,
																		vn_COAF_FOLIO_SUSCRIPCION,
																		vn_CODIGO_ISAPRE,
																		vn_CODIGO_CARGA,
																		vv_LN_VALOR_CONVoCOBRADO -vn_LN_VALOR_COPAGO,--t_lineas(z).monto_isapre , --se agrega 30-05-2006
																	vn_LN_VALOR_COPAGO, --t_lineas(z).monto_total - t_lineas(z).monto_isapre  ,  --se agrega 30-05-2006
																		NULL, -- p_nLIBE_PRME_FOLIO
																		'S', --ES GES
																	vn_LIBE_MONTO_COBERT_ADIC_GES,	--se agrega 30-05-2006
																	vv_CopagoGratis,  --se agrega 30-05-2006
																		0, -- GES CAEC
												  						vv_ErrorCode);


			DBMS_OUTPUT.PUT_LINE ( 'vv_ErrorCode= ' || vv_ErrorCode );

			IF vv_ErrorCode IS NOT NULL THEN
			   DBMS_OUTPUT.PUT_LINE ( 'ENTRE ERROR GES ' );
			   RAISE no_emision_ges;
			END IF;
		END IF;


		--EACE 28-06-2005  GES
		vn_BANDERA:=181;
		DBMS_OUTPUT.PUT_LINE ( 't_LINEAS(z).codigo_GRUPO 1= ' || t_LINEAS(z).codigo_GRUPO );

	    PCK_BEN_REPOSITORIO.P_ELIMINA_REGISTRO_REPOSITORIO(
										vn_REB_LN_CORRELATIVO,
										vn_ERROR_ELI_REP,
										vv_ERROR_ELI_REP,
									 	'N');

	IF vn_ERROR_ELI_REP	> 0 THEN
	   RAISE e_ELIMINA_REP;
	END IF;

	END LOOP;

	vn_BANDERA:=20;

	/*SELECT IMED_ESDO_SEQ.NEXTVAL
	INTO   vn_SECUENCIA
	FROM   dual;

	vn_SECUENCIA:= vn_SECUENCIA + 9200000000000000;*/

	DBMS_OUTPUT.PUT_LINE ( 'vn_BANDERA= ' || vn_BANDERA );


			 /*INSERT INTO IMED_ESDO  (correlativo,
						dobe_correlativo,
						usua_username,
						estado,
						fecha)
				VALUES (vn_SECUENCIA,
						vn_DOBE_CORRELATIVO,
						RPAD(v_vExtHomNumeroConvenio||'/'||v_vExtRutCajero,30),
						'EMI',
						SYSDATE);*/


----------------------------------------------------------------------------------------------------------
-- TOPES DE COBERTURA
----------------------------------------------------------------------------------------------------------


	 FOR DET IN c_LIQU(vn_DOLI_CORRELATIVO) LOOP
	 	 --TOPES
		 IF NVL(DET.TOPE_CORRELATIVO,0) > 0 THEN
			 PLANES.Pck_Pln_Cuentas_Tope.P_ACTUALIZA_ESTADO_TOPE(DET.TOPE_CORRELATIVO,'EMI',vn_ERROR_TOPE ,vv_ERROR_TOPE);
			 --
			 IF NVL(vn_ERROR_TOPE,0) > 0 THEN
			    --RAISE e_TOPES;
				NULL;
			 END IF;
		 END IF;
		 --
		 --TOPES BC
		 IF NVL(DET.TOPE_CORRELATIVO_BC,0) > 0 THEN
			 planbc.Pck_Plbc_Cuentas_Tope.P_ACTUALIZA_ESTADO_TOPE(DET.TOPE_CORRELATIVO_BC,'EMI',vn_ERROR_TOPE ,vv_ERROR_TOPE);
			 --
			 IF NVL(vn_ERROR_TOPE,0) > 0 THEN
			    --RAISE e_TOPES;
				NULL;
			 END IF;
		 END IF;
		 --
	 END LOOP;

	 vn_CODIGO_MENSAJE_EXCEDENTE := 0;
	 vv_GLOSA_EXCEDENTE			 :='';

	 DBMS_OUTPUT.PUT_LINE ( 'vn_MONTO_COPAGO_EXCEDENTE= ' || vn_MONTO_COPAGO_EXCEDENTE );
	 DBMS_OUTPUT.PUT_LINE ( 'vn_CON_EXCEDENTE= ' || vn_CON_EXCEDENTE );

	 IF vn_MONTO_COPAGO_EXCEDENTE <> 0 AND vn_CON_EXCEDENTE ='S' THEN

		Prorratea_Excedentes (vn_DOLI_CORRELATIVO,
 						      vn_MONTO_COPAGO_EXCEDENTE,
 						      vn_CODIGO_MENSAJE_EXCEDENTE,
 						      vv_GLOSA_EXCEDENTE
						      );
	    IF vn_CODIGO_MENSAJE_EXCEDENTE <> 0 THEN
		   vv_MensajeError:= TO_CHAR(vn_CODIGO_MENSAJE_EXCEDENTE)||vv_GLOSA_EXCEDENTE;
		   RAISE e_EXCEDENTES;
		END IF;
	 END IF;

	 DBMS_OUTPUT.PUT_LINE ( 'vn_CODIGO_MENSAJE_EXCEDENTE= ' || vn_CODIGO_MENSAJE_EXCEDENTE );
	 DBMS_OUTPUT.PUT_LINE ( 'vv_GLOSA_EXCEDENTE= ' || vv_GLOSA_EXCEDENTE );


	--***************************************************************
	--***************************************************************
	--Actualiza tope general del plan por beneficiario BCH 23/06/2008
	BENEFICIOS.Pck_Ben_Servicios.P_ACT_TOPE_GRAL_PLAN_DOLI(vn_DOLI_CORRELATIVO,   --pi_nDOLI_CORRELATIVO
											  		       'EMI',		      --pi_vESTADO--EMI/DEV/ANU
													pon_ERROR_TOPE_PLAN,  --po_nERROR
													pov_ERROR_TOPE_PLAN   --po_vDESC_ERROR
													    );
	--***************************************************************
	--***************************************************************


	IF  pon_ERROR_TOPE_PLAN > 0 THEN
		RAISE e_TOPES_GRAL;
	END IF;

	IF     vn_USO_BCC IS NULL AND vn_CON_EXCEDENTE IS NULL AND vn_USO_TOPE IS NULL AND vn_USO_CIGNA IS NULL THEN
		vn_USO_BCC_EXC_TOPE:= '0';
	ELSIF  vn_USO_BCC = 'S' AND vn_CON_EXCEDENTE IS NULL AND vn_USO_TOPE IS NULL AND vn_USO_CIGNA IS NULL THEN
		vn_USO_BCC_EXC_TOPE:= '1';
	ELSIF  vn_USO_BCC IS NULL AND vn_CON_EXCEDENTE = 'S' AND vn_USO_TOPE IS NULL AND vn_USO_CIGNA IS NULL THEN
		vn_USO_BCC_EXC_TOPE:= '2';
	ELSIF  vn_USO_BCC IS NULL AND vn_CON_EXCEDENTE IS NULL AND vn_USO_TOPE = 'S' AND vn_USO_CIGNA IS NULL THEN
		vn_USO_BCC_EXC_TOPE:= '3';
	ELSIF  vn_USO_BCC = 'S' AND vn_CON_EXCEDENTE = 'S' AND vn_USO_TOPE IS NULL AND vn_USO_CIGNA IS NULL THEN
		vn_USO_BCC_EXC_TOPE:= '4';
	ELSIF  vn_USO_BCC IS NULL AND vn_CON_EXCEDENTE = 'S' AND vn_USO_TOPE = 'S' AND vn_USO_CIGNA IS NULL THEN
		vn_USO_BCC_EXC_TOPE:= '5';
	ELSIF  vn_USO_BCC = 'S' AND vn_CON_EXCEDENTE IS NULL AND vn_USO_TOPE = 'S' AND vn_USO_CIGNA IS NULL THEN
		vn_USO_BCC_EXC_TOPE:= '6';
	ELSIF  vn_USO_BCC = 'S' AND vn_CON_EXCEDENTE = 'S' AND vn_USO_TOPE = 'S' AND vn_USO_CIGNA IS NULL THEN
		vn_USO_BCC_EXC_TOPE:= '7';
	ELSIF  vn_USO_BCC IS NULL AND vn_CON_EXCEDENTE IS NULL AND vn_USO_TOPE IS NULL AND vn_USO_CIGNA = 'S' THEN
		vn_USO_BCC_EXC_TOPE:= '8';
	ELSIF  vn_USO_BCC IS NULL AND vn_CON_EXCEDENTE = 'S' AND vn_USO_TOPE IS NULL AND vn_USO_CIGNA = 'S' THEN
		vn_USO_BCC_EXC_TOPE:= '9';
	ELSIF  vn_USO_BCC IS NULL AND vn_CON_EXCEDENTE = 'S' AND vn_USO_TOPE = 'S' AND vn_USO_CIGNA = 'S' THEN
		vn_USO_BCC_EXC_TOPE:= 'A';
	ELSIF  vn_USO_BCC IS NULL AND vn_CON_EXCEDENTE IS NULL AND vn_USO_TOPE = 'S' AND vn_USO_CIGNA = 'S' THEN
		vn_USO_BCC_EXC_TOPE:= 'B';
	ELSIF  vn_USO_BCC = 'S' AND vn_CON_EXCEDENTE IS NULL AND vn_USO_TOPE IS NULL AND vn_USO_CIGNA = 'S' THEN
		vn_USO_BCC_EXC_TOPE:= 'C';
	ELSIF  vn_USO_BCC = 'S' AND vn_CON_EXCEDENTE = 'S' AND vn_USO_TOPE = 'S' AND vn_USO_CIGNA = 'S' THEN
		vn_USO_BCC_EXC_TOPE:= 'D';
	ELSIF  vn_USO_BCC = 'S' AND vn_CON_EXCEDENTE IS NULL AND vn_USO_TOPE = 'S' AND vn_USO_CIGNA = 'S' THEN
		vn_USO_BCC_EXC_TOPE:= 'F';
	ELSIF  vn_USO_BCC = 'S' AND vn_CON_EXCEDENTE = 'S' AND vn_USO_TOPE IS NULL AND vn_USO_CIGNA = 'S' THEN
		vn_USO_BCC_EXC_TOPE:= 'G';
	ELSE
		vn_USO_BCC_EXC_TOPE:= 'E';
	END IF;

	vn_BANDERA:=21;

	Out_vExtMensajeError	 := RPAD('Resultado exitoso al bonificar',30);
	Out_vExtCodError 	 	 := 'S';
	vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
	vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';--'38001';
	vv_OUTPUT_STATUS_SERVICIO		 := '1';
	SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;

	vv_PARAMETROS_SALIDA  := SETEA_vn_SALIDA;

	vd_FECHA_SALIDA:=SYSDATE;

	--- 06-09-2005	PATIRICIO ALARCON
	IF Pck_Imed_Adm_Proc.F_IMED_BLOQUEA_SECCION('VERIFICA_DEUDA_COMPAG') = 'S' THEN
		IF 	(Pck_Imed_Externos.F_IMED_Posee_Deuda_ult_peri(vn_RUT_COTIZANTE , 'S','N'))= 'S' THEN
			NULL;
		END IF;
	END IF;
	--- 06-09-2005	PATIRICIO ALARCON

    SELECT DECODE(vv_LN_ORDEN_DERIVACION,'SINORDEN','N','AUTO','A','MANUAL','M',NULL)
    INTO   vv_AUTO_MANUAL_SORDEN
    FROM   DUAL;

	vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,
							  vd_FECHA_LLEGADA,
							  v_vExtHomNumeroConvenio,
							  v_vExtHomLugarConvenio,
							  v_vExtSucVenta,
							  TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
							  TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),
							  TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),
							  v_nFolio_Suscripcion,
							  vn_CODIGO_CARGA,
							  v_nExtFolioFinanciador,
							  v_nExtMontoValorTotal,
							  vn_NRO_LINEA_BONO,
							  v_nExtMontoAporteTotal,
							  v_nExtMontoCopagoTotal,
							  vv_PARAMETROS_ENTRADA,
							  vv_PARAMETROS_SALIDA,
							  vd_FECHA_LLEGADA,
							  vd_FECHA_SALIDA,
							  (vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,
							  VALOR(vn_USO_BCC),
							  vn_MONTO_BCC_AUDI,
							  VALOR(vn_CON_EXCEDENTE),
							  v_nExtMontoExcedente,
							  VALOR(vn_USO_TOPE),
							  VALOR(vn_USO_CIGNA),
							  vn_MONTO_SEGURO_TERCERO,
							  vv_AUTO_MANUAL_SORDEN,--TRIM(vv_LN_ORDEN_DERIVACION),
							  vn_LN_NRO_ORDEN_DERIVACION,
							  vv_LN_SERV_DERIVACION_FULL_OFI
							  );


	DBMS_OUTPUT.PUT_LINE ( 'vn_BANDERA= ' || vn_BANDERA );

     COMMIT;
	--RAISE e_LINEA_BONO;



	vn_BANDERA:=22;
	RETURN;

EXCEPTION
	WHEN e_LINEA_BONO THEN
		 Out_vExtMensajeError	 := RPAD(vn_RESULTADO_INSERT_AUDITORIA,30);--'ERROR INSERT.LN BONO.',30);

TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA||';'||vv_DESC_ERROR_CARGA_REP;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,
									  v_nExtFolioFinanciador,v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,
									  vd_FECHA_LLEGADA,vd_FECHA_SALIDA,(vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI,VALOR(vn_CON_EXCEDENTE),
									  v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;
	WHEN e_INSERTA_BONO THEN
		 Out_vExtMensajeError	 := RPAD('ERR.I.B.'||vn_ERROR||'.'||vv_DESC_ERROR,30);
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,
									  v_nExtFolioFinanciador,v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,
									  vd_FECHA_LLEGADA,vd_FECHA_SALIDA,(vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI,VALOR(vn_CON_EXCEDENTE),
									  v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;

    WHEN e_ELIMINA_REP THEN
		  Out_vExtMensajeError	 := RPAD('ERROR LIMP.REPOS.',30);
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,
									  v_nExtFolioFinanciador,v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,
									  vd_FECHA_LLEGADA,vd_FECHA_SALIDA,(vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI,VALOR(vn_CON_EXCEDENTE),
									  v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;

	WHEN e_TOPES THEN
	   	  Out_vExtMensajeError	 := RPAD('ERROR AL ACTUALIZAR TOPE',30);
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,
									  v_nExtFolioFinanciador,v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,
									  vd_FECHA_LLEGADA,vd_FECHA_SALIDA,(vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI,VALOR(vn_CON_EXCEDENTE),
									  v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;


	WHEN e_TOPES_GRAL THEN
	   	  Out_vExtMensajeError	 := RPAD('T.G:'||TO_CHAR(pon_ERROR_TOPE_PLAN)||pov_ERROR_TOPE_PLAN,30);
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,
									  v_nExtFolioFinanciador,v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,
									  vd_FECHA_LLEGADA,vd_FECHA_SALIDA,(vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI,VALOR(vn_CON_EXCEDENTE),
									  v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;


	WHEN E_BONO_EXISTE THEN
       	  Out_vExtMensajeError	 := RPAD('NRO. BONO YA EXISTE:'||vv_LINEA_AUDI,30);
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,
									  v_nExtFolioFinanciador,v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,
									  vd_FECHA_LLEGADA,vd_FECHA_SALIDA,(vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI,VALOR(vn_CON_EXCEDENTE),
									  v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;
	 WHEN E_MONTO_EXCEDENTE THEN
       	  Out_vExtMensajeError	 := RPAD('MONTO EXC. O BCC NO VALIDOS',30);
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,
									  v_nExtFolioFinanciador,v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,
									  vd_FECHA_LLEGADA,vd_FECHA_SALIDA,(vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI,VALOR(vn_CON_EXCEDENTE),
									  v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;
	 WHEN e_FORMATO_LISTAS THEN
       	  Out_vExtMensajeError	 := RPAD('ERROR:EN FORMATO DE LISTAS',30);
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,v_nExtFolioFinanciador,
									  v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,vd_FECHA_LLEGADA,vd_FECHA_SALIDA,
									  (vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI,VALOR(vn_CON_EXCEDENTE),v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),
									  vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;
	 WHEN e_EXISTE_LISTA THEN
       	  Out_vExtMensajeError	 := RPAD('ERROR:NO EXISTEN LISTAS INPUT',30);
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,v_nExtFolioFinanciador,
									  v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,vd_FECHA_LLEGADA,vd_FECHA_SALIDA,
									  (vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI,VALOR(vn_CON_EXCEDENTE),v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),
									  vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;
	 WHEN e_CARGO_BCC THEN
	 	  DBMS_OUTPUT.PUT_LINE ('ERROR 01: '||SQLERRM);
       	  Out_vExtMensajeError	 := RPAD('ERROR: NO REALIZO CARGO BCC',30);
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
--	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '78001';
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
--		  vv_OUTPUT_STATUS_SERVICIO		 := '0';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,v_nExtFolioFinanciador,
									  v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,vd_FECHA_LLEGADA,vd_FECHA_SALIDA,
									  (vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI,VALOR(vn_CON_EXCEDENTE),v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),
									  vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;
	 WHEN e_CARGO_CIGNA THEN
	 	  DBMS_OUTPUT.PUT_LINE ('ERROR 02: '||SQLERRM);
       	  Out_vExtMensajeError	 := RPAD('ERROR: NO REALIZO CARGO SEGURO CIGNA',30);
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
--	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '78002';
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
--		  vv_OUTPUT_STATUS_SERVICIO		 := '0';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,v_nExtFolioFinanciador,
									  v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,vd_FECHA_LLEGADA,vd_FECHA_SALIDA,
									  (vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI,VALOR(vn_CON_EXCEDENTE),v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),
									  vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;
	 WHEN e_ISAPRE_NO_CORRESPONDE THEN
	 	  DBMS_OUTPUT.PUT_LINE ('ERROR 00: '||SQLERRM);
       	  Out_vExtMensajeError	 := RPAD('Codigo isapre no corresponde',30);
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
--	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '78003';
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
--		  vv_OUTPUT_STATUS_SERVICIO		 := '0';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,v_nExtFolioFinanciador,
									  v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,vd_FECHA_LLEGADA,vd_FECHA_SALIDA,
									  (vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI,VALOR(vn_CON_EXCEDENTE),v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),
									  vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;
	 WHEN e_EXCEDENTES THEN
	 	  DBMS_OUTPUT.PUT_LINE ('ERROR 03: '||SQLERRM);
       	  Out_vExtMensajeError	 := RPAD('ERROR EXCED: '||SUBSTR(SQLERRM,1,17),30);
       	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
--	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '78003';
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
--		  vv_OUTPUT_STATUS_SERVICIO		 := '0';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,v_nExtFolioFinanciador,
									  v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,vd_FECHA_LLEGADA,vd_FECHA_SALIDA,
									  (vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI,VALOR(vn_CON_EXCEDENTE),v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),
									  vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;

	 WHEN err_v_vResp THEN
--RAISE_APPLICATION_ERROR(-20001,'');CTC

	 	  DBMS_OUTPUT.PUT_LINE ('ERROR 11: '||SQLERRM);
	  vn_SAL:=1;
       	  Out_vExtMensajeError	 := RPAD(v_vgloerror,30);
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,v_nExtFolioFinanciador,
									  v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,vd_FECHA_LLEGADA,vd_FECHA_SALIDA,
									  (vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI/*vn_MONTO_BCC*/,VALOR(vn_CON_EXCEDENTE),v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),
									  vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;  -- vn_SAL; CTC 200308011


	 WHEN err_Imed_Bene_Coti THEN
--RAISE_APPLICATION_ERROR(-20001,'');CTC
	 	  DBMS_OUTPUT.PUT_LINE ('ERROR 12: '||SQLERRM);
	  vn_SAL:=1;
       	  Out_vExtMensajeError	 := RPAD('AL VERIFICAR BENEFICIARIO',30);
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,v_nExtFolioFinanciador,
									  v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,vd_FECHA_LLEGADA,vd_FECHA_SALIDA,
									  (vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI/*vn_MONTO_BCC*/,VALOR(vn_CON_EXCEDENTE),v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),
									  vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);

  		  RETURN;  -- vn_SAL; CTC 2003080117
	 WHEN no_emision_ges THEN
--RAISE_APPLICATION_ERROR(-20001,'');CTC
	 	  DBMS_OUTPUT.PUT_LINE ('ERROR 13: '||SQLERRM);
	  vn_SAL:=1;
       	  Out_vExtMensajeError	 := RPAD('AL EMITIR PRESTACION GES',20)||vv_ErrorCode;
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
		  vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,v_nExtFolioFinanciador,
									  v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,vd_FECHA_LLEGADA,vd_FECHA_SALIDA,
									  (vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI/*vn_MONTO_BCC*/,VALOR(vn_CON_EXCEDENTE),v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),
									  vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);

  		  RETURN;  -- vn_SAL; CTC 2003080117
     WHEN OTHERS THEN
	 	  DBMS_OUTPUT.PUT_LINE ('ERROR 13: '||SQLERRM);
       	  Out_vExtMensajeError	 := RPAD('ERROR PROC.:'||TO_CHAR(vn_BANDERA),30);
DBMS_OUTPUT.PUT_LINE ( 'Out_vExtMensajeError= ' || Out_vExtMensajeError );
      	  Out_vExtCodError 	 	 := 'N';
   	  	  vv_OUTPUT_MENSAJE	  	 := vv_INICIO_TEXTO_MENSAJE||Out_vExtMensajeError;
--	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '78099';
 	  	  vv_OUTPUT_CODIGO_MENSAJE   	 := '00000';
--		  vv_OUTPUT_STATUS_SERVICIO		 := '0';
		  vv_OUTPUT_STATUS_SERVICIO		 := '1';
    	  SRV_Message 			 := vv_OUTPUT_STATUS_SERVICIO||vv_OUTPUT_CODIGO_MENSAJE||vn_SRV_FETCH_STATUS||vv_OUTPUT_MENSAJE;
	  vv_PARAMETROS_SALIDA	:= SETEA_vn_SALIDA;
	      vd_FECHA_SALIDA:=SYSDATE;
		  vn_RESULTADO_INSERT_AUDITORIA:=Imed_Graba_Auditoria(vv_NOMBRE_TRANSACCION,vd_FECHA_LLEGADA,v_vExtHomNumeroConvenio,v_vExtHomLugarConvenio,v_vExtSucVenta,TO_NUMBER(SUBSTR(v_vExtRutTratante,1,10)),
					      TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),TO_NUMBER(SUBSTR(v_vExtRutCotizante,1,10)),v_nFolio_Suscripcion,vn_CODIGO_CARGA,v_nExtFolioFinanciador,
									  v_nExtMontoValorTotal,vn_NRO_LINEA_BONO,v_nExtMontoAporteTotal,v_nExtMontoCopagoTotal,vv_PARAMETROS_ENTRADA,vv_PARAMETROS_SALIDA,vd_FECHA_LLEGADA,vd_FECHA_SALIDA,
									  (vd_FECHA_SALIDA-vd_FECHA_LLEGADA)*86400,VALOR(vn_USO_BCC),vn_MONTO_BCC_AUDI,VALOR(vn_CON_EXCEDENTE),v_nExtMontoExcedente,VALOR(vn_USO_TOPE),VALOR(vn_USO_CIGNA),
									  vn_MONTO_SEGURO_TERCERO,vv_LN_ORDEN_DERIVACION,vn_LN_NRO_ORDEN_DERIVACION,vv_AUTO_MANUAL_SORDEN);
  		  RETURN;
END CONEnvBonIs;

END Conenvbonis_Pkg;

3281 rows selected.

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
