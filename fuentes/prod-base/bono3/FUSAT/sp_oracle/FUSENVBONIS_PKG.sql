
SQL*Plus: Release 11.2.0.3.0 Production on Tue Aug 4 11:31:14 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.5.0 - 64bit Production

SQL> SQL> PROCEDURE CHUENVBONIS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTHOMNUMEROCONVENIO	VARCHAR2		IN
 IN_EXTHOMLUGARCONVENIO 	VARCHAR2		IN
 IN_EXTSUCVENTA 		VARCHAR2		IN
 IN_EXTRUTCONVENIO		VARCHAR2		IN
 IN_EXTRUTASOCIADO		VARCHAR2		IN
 IN_EXTNOMPRESTADOR		VARCHAR2		IN
 IN_EXTRUTTRATANTE		VARCHAR2		IN
 IN_EXTESPECIALIDAD		VARCHAR2		IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 IN_EXTRUTCOTIZANTE		VARCHAR2		IN
 IN_EXTRUTACOMPANANTE		VARCHAR2		IN
 IN_EXTRUTEMISOR		VARCHAR2		IN
 IN_EXTRUTCAJERO		VARCHAR2		IN
 IN_EXTCODIGODIAGNOSTICO	VARCHAR2		IN
 IN_EXTDESCUENTOXPLANILLA	VARCHAR2		IN
 IN_EXTMONTOEXCEDENTE		NUMBER			IN
 IN_EXTFECHAEMISION		VARCHAR2		IN
 IN_EXTNIVELCONVENIO		NUMBER			IN
 IN_EXTFOLIOFINANCIADOR 	NUMBER			IN
 IN_EXTMONTOVALORTOTAL		NUMBER			IN
 IN_EXTMONTOAPORTETOTAL 	NUMBER			IN
 IN_EXTMONTOCOPAGOTOTAL 	NUMBER			IN
 IN_EXTNUMOPERACION		NUMBER			IN
 IN_EXTCORRPRESTACION		NUMBER			IN
 IN_EXTTIPOSOLICITUD		NUMBER			IN
 IN_EXTFECHAINICIO		VARCHAR2		IN
 IN_EXTURGENCIA 		VARCHAR2		IN
 IN_EXTPLAN			VARCHAR2		IN
 IN_EXTLISTA1			VARCHAR2		IN
 IN_EXTLISTA2			VARCHAR2		IN
 IN_EXTLISTA3			VARCHAR2		IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
PROCEDURE FUSENVBONIS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTHOMNUMEROCONVENIO	VARCHAR2		IN
 IN_EXTHOMLUGARCONVENIO 	VARCHAR2		IN
 IN_EXTSUCVENTA 		VARCHAR2		IN
 IN_EXTRUTCONVENIO		VARCHAR2		IN
 IN_EXTRUTASOCIADO		VARCHAR2		IN
 IN_EXTNOMPRESTADOR		VARCHAR2		IN
 IN_EXTRUTTRATANTE		VARCHAR2		IN
 IN_EXTESPECIALIDAD		VARCHAR2		IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 IN_EXTRUTCOTIZANTE		VARCHAR2		IN
 IN_EXTRUTACOMPANANTE		VARCHAR2		IN
 IN_EXTRUTEMISOR		VARCHAR2		IN
 IN_EXTRUTCAJERO		VARCHAR2		IN
 IN_EXTCODIGODIAGNOSTICO	VARCHAR2		IN
 IN_EXTDESCUENTOXPLANILLA	VARCHAR2		IN
 IN_EXTMONTOEXCEDENTE		NUMBER			IN
 IN_EXTFECHAEMISION		VARCHAR2		IN
 IN_EXTNIVELCONVENIO		NUMBER			IN
 IN_EXTFOLIOFINANCIADOR 	NUMBER			IN
 IN_EXTMONTOVALORTOTAL		NUMBER			IN
 IN_EXTMONTOAPORTETOTAL 	NUMBER			IN
 IN_EXTMONTOCOPAGOTOTAL 	NUMBER			IN
 IN_EXTNUMOPERACION		NUMBER			IN
 IN_EXTCORRPRESTACION		NUMBER			IN
 IN_EXTTIPOSOLICITUD		NUMBER			IN
 IN_EXTFECHAINICIO		VARCHAR2		IN
 IN_EXTURGENCIA 		VARCHAR2		IN
 IN_EXTPLAN			VARCHAR2		IN
 IN_EXTLISTA1			VARCHAR2		IN
 IN_EXTLISTA2			VARCHAR2		IN
 IN_EXTLISTA3			VARCHAR2		IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
PROCEDURE RBLENVBONIS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTHOMNUMEROCONVENIO	VARCHAR2		IN
 IN_EXTHOMLUGARCONVENIO 	VARCHAR2		IN
 IN_EXTSUCVENTA 		VARCHAR2		IN
 IN_EXTRUTCONVENIO		VARCHAR2		IN
 IN_EXTRUTASOCIADO		VARCHAR2		IN
 IN_EXTNOMPRESTADOR		VARCHAR2		IN
 IN_EXTRUTTRATANTE		VARCHAR2		IN
 IN_EXTESPECIALIDAD		VARCHAR2		IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 IN_EXTRUTCOTIZANTE		VARCHAR2		IN
 IN_EXTRUTACOMPANANTE		VARCHAR2		IN
 IN_EXTRUTEMISOR		VARCHAR2		IN
 IN_EXTRUTCAJERO		VARCHAR2		IN
 IN_EXTCODIGODIAGNOSTICO	VARCHAR2		IN
 IN_EXTDESCUENTOXPLANILLA	VARCHAR2		IN
 IN_EXTMONTOEXCEDENTE		NUMBER			IN
 IN_EXTFECHAEMISION		VARCHAR2		IN
 IN_EXTNIVELCONVENIO		NUMBER			IN
 IN_EXTFOLIOFINANCIADOR 	NUMBER			IN
 IN_EXTMONTOVALORTOTAL		NUMBER			IN
 IN_EXTMONTOAPORTETOTAL 	NUMBER			IN
 IN_EXTMONTOCOPAGOTOTAL 	NUMBER			IN
 IN_EXTNUMOPERACION		NUMBER			IN
 IN_EXTCORRPRESTACION		NUMBER			IN
 IN_EXTTIPOSOLICITUD		NUMBER			IN
 IN_EXTFECHAINICIO		VARCHAR2		IN
 IN_EXTURGENCIA 		VARCHAR2		IN
 IN_EXTPLAN			VARCHAR2		IN
 IN_EXTLISTA1			VARCHAR2		IN
 IN_EXTLISTA2			VARCHAR2		IN
 IN_EXTLISTA3			VARCHAR2		IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
PROCEDURE SNLENVBONIS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTHOMNUMEROCONVENIO	VARCHAR2		IN
 IN_EXTHOMLUGARCONVENIO 	VARCHAR2		IN
 IN_EXTSUCVENTA 		VARCHAR2		IN
 IN_EXTRUTCONVENIO		VARCHAR2		IN
 IN_EXTRUTASOCIADO		VARCHAR2		IN
 IN_EXTNOMPRESTADOR		VARCHAR2		IN
 IN_EXTRUTTRATANTE		VARCHAR2		IN
 IN_EXTESPECIALIDAD		VARCHAR2		IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 IN_EXTRUTCOTIZANTE		VARCHAR2		IN
 IN_EXTRUTACOMPANANTE		VARCHAR2		IN
 IN_EXTRUTEMISOR		VARCHAR2		IN
 IN_EXTRUTCAJERO		VARCHAR2		IN
 IN_EXTCODIGODIAGNOSTICO	VARCHAR2		IN
 IN_EXTDESCUENTOXPLANILLA	VARCHAR2		IN
 IN_EXTMONTOEXCEDENTE		NUMBER			IN
 IN_EXTFECHAEMISION		VARCHAR2		IN
 IN_EXTNIVELCONVENIO		NUMBER			IN
 IN_EXTFOLIOFINANCIADOR 	NUMBER			IN
 IN_EXTMONTOVALORTOTAL		NUMBER			IN
 IN_EXTMONTOAPORTETOTAL 	NUMBER			IN
 IN_EXTMONTOCOPAGOTOTAL 	NUMBER			IN
 IN_EXTNUMOPERACION		NUMBER			IN
 IN_EXTCORRPRESTACION		NUMBER			IN
 IN_EXTTIPOSOLICITUD		NUMBER			IN
 IN_EXTFECHAINICIO		VARCHAR2		IN
 IN_EXTURGENCIA 		VARCHAR2		IN
 IN_EXTPLAN			VARCHAR2		IN
 IN_EXTLISTA1			VARCHAR2		IN
 IN_EXTLISTA2			VARCHAR2		IN
 IN_EXTLISTA3			VARCHAR2		IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	FUSEnvBonIs_Pkg As
PROCEDURE FUSEnvBonIs	/*Envia Bonos, Fundacion */
    ( SRV_Message		     In Out	Varchar2
	, In_extCodFinanciador 	  		 In	   Number
    , In_extHomNumeroConvenio 		 In	   Varchar2
	, In_extHomLugarConvenio 		 In	   Varchar2
	, In_extSucVenta 				 In	   Varchar2
    , In_extRutConvenio 			 In	   Varchar2
	, In_extRutAsociado 			 In	   Varchar2
    , In_extNomPrestador			 In	   Varchar2
	, In_extRutTratante 			 In	   Varchar2
	, In_extEspecialidad 			 In	   Varchar2
    , In_extRutBeneficiario 		 In	   Varchar2
	, In_extRutCotizante 			 In	   Varchar2
	, In_extRutAcompanante 			 In	   Varchar2
	, In_extRutEmisor 				 In	   Varchar2
	, In_extRutCajero 				 In	   Varchar2
	, In_extCodigoDiagnostico 		 In	   Varchar2
    , In_extDescuentoxPlanilla 		 In	   Varchar2
	, In_extMontoExcedente			 In	   Number
	, In_extFechaEmision 			 In	   Varchar2
	, In_extNivelConvenio 			 In	   Number
	, In_extFolioFinanciador 		 In	   Number
	, In_extMontoValorTotal 		 In	   Number
    , In_extMontoAporteTotal 		 In	   Number
	, In_extMontoCopagoTotal 		 In	   Number
	, In_extNumOperacion 			 In	   Number
	, In_extCorrPrestacion 			 In	   Number
	, In_extTipoSolicitud 			 In	   Number
	, In_extFechaInicio 			 In	   Varchar2
	, In_extUrgencia 				 In	   Varchar2
	, In_extPlan 				     In        Varchar2
	, In_extLista1 				 	 In	   Varchar2
	, In_extLista2 				 	 In	   Varchar2
	, In_extLista3 				 	 In	   Varchar2
	, Out_extCodError				 Out	    Varchar2
    , Out_extMensajeError			 Out	    Varchar2
    );

PROCEDURE SNLEnvBonIs	 /*Envia Bonos, Fundacion */
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	    Number
    , In_extHomNumeroConvenio	       In	 Varchar2
    , In_extHomLugarConvenio	      In	Varchar2
    , In_extSucVenta		      In	Varchar2
    , In_extRutConvenio 	     In        Varchar2
    , In_extRutAsociado 	     In        Varchar2
    , In_extNomPrestador	     In        Varchar2
    , In_extRutTratante 	     In        Varchar2
    , In_extEspecialidad	      In	Varchar2
    , In_extRutBeneficiario	     In        Varchar2
    , In_extRutCotizante	      In	Varchar2
    , In_extRutAcompanante		In	  Varchar2
    , In_extRutEmisor		       In	 Varchar2
    , In_extRutCajero		       In	 Varchar2
    , In_extCodigoDiagnostico	       In	 Varchar2
    , In_extDescuentoxPlanilla		In	  Varchar2
    , In_extMontoExcedente	       In	 Number
    , In_extFechaEmision	      In	Varchar2
    , In_extNivelConvenio	       In	 Number
    , In_extFolioFinanciador	      In	Number
    , In_extMontoValorTotal	     In        Number
    , In_extMontoAporteTotal	      In	Number
    , In_extMontoCopagoTotal	      In	Number
    , In_extNumOperacion	      In	Number
    , In_extCorrPrestacion		In	  Number
    , In_extTipoSolicitud	       In	 Number
    , In_extFechaInicio 	     In        Varchar2
    , In_extUrgencia		      In	Varchar2
    , In_extPlan		      In	Varchar2
    , In_extLista1			 In	   Varchar2
    , In_extLista2			 In	   Varchar2
    , In_extLista3			 In	   Varchar2
    , Out_extCodError		      Out	 Varchar2
    , Out_extMensajeError	      Out	 Varchar2
    );

PROCEDURE RBLEnvBonIs	 /*Envia Bonos, Fundacion */
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	    Number
    , In_extHomNumeroConvenio	       In	 Varchar2
    , In_extHomLugarConvenio	      In	Varchar2
    , In_extSucVenta		      In	Varchar2
    , In_extRutConvenio 	     In        Varchar2
    , In_extRutAsociado 	     In        Varchar2
    , In_extNomPrestador	     In        Varchar2
    , In_extRutTratante 	     In        Varchar2
    , In_extEspecialidad	      In	Varchar2
    , In_extRutBeneficiario	     In        Varchar2
    , In_extRutCotizante	      In	Varchar2
    , In_extRutAcompanante		In	  Varchar2
    , In_extRutEmisor		       In	 Varchar2
    , In_extRutCajero		       In	 Varchar2
    , In_extCodigoDiagnostico	       In	 Varchar2
    , In_extDescuentoxPlanilla		In	  Varchar2
    , In_extMontoExcedente	       In	 Number
    , In_extFechaEmision	      In	Varchar2
    , In_extNivelConvenio	       In	 Number
    , In_extFolioFinanciador	      In	Number
    , In_extMontoValorTotal	     In        Number
    , In_extMontoAporteTotal	      In	Number
    , In_extMontoCopagoTotal	      In	Number
    , In_extNumOperacion	      In	Number
    , In_extCorrPrestacion		In	  Number
    , In_extTipoSolicitud	       In	 Number
    , In_extFechaInicio 	     In        Varchar2
    , In_extUrgencia		      In	Varchar2
    , In_extPlan		      In	Varchar2
    , In_extLista1			 In	   Varchar2
    , In_extLista2			 In	   Varchar2
    , In_extLista3			 In	   Varchar2
    , Out_extCodError		      Out	 Varchar2
    , Out_extMensajeError	      Out	 Varchar2
    );
PROCEDURE CHUEnvBonIs	 /*Envia Bonos, Fundacion */
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	    Number
    , In_extHomNumeroConvenio	       In	 Varchar2
    , In_extHomLugarConvenio	      In	Varchar2
    , In_extSucVenta		      In	Varchar2
    , In_extRutConvenio 	     In        Varchar2
    , In_extRutAsociado 	     In        Varchar2
    , In_extNomPrestador	     In        Varchar2
    , In_extRutTratante 	     In        Varchar2
    , In_extEspecialidad	      In	Varchar2
    , In_extRutBeneficiario	     In        Varchar2
    , In_extRutCotizante	      In	Varchar2
    , In_extRutAcompanante		In	  Varchar2
    , In_extRutEmisor		       In	 Varchar2
    , In_extRutCajero		       In	 Varchar2
    , In_extCodigoDiagnostico	       In	 Varchar2
    , In_extDescuentoxPlanilla		In	  Varchar2
    , In_extMontoExcedente	       In	 Number
    , In_extFechaEmision	      In	Varchar2
    , In_extNivelConvenio	       In	 Number
    , In_extFolioFinanciador	      In	Number
    , In_extMontoValorTotal	     In        Number
    , In_extMontoAporteTotal	      In	Number
    , In_extMontoCopagoTotal	      In	Number
    , In_extNumOperacion	      In	Number
    , In_extCorrPrestacion		In	  Number
    , In_extTipoSolicitud	       In	 Number
    , In_extFechaInicio 	     In        Varchar2
    , In_extUrgencia		      In	Varchar2
    , In_extPlan		      In	Varchar2
    , In_extLista1			 In	   Varchar2
    , In_extLista2			 In	   Varchar2
    , In_extLista3			 In	   Varchar2
    , Out_extCodError		      Out	 Varchar2
    , Out_extMensajeError	      Out	 Varchar2
    );

end FUSEnvBonis_Pkg;

153 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     FUSEnvBonIs_Pkg
AS
   PROCEDURE fusenvbonis (srv_message IN OUT varchar2,
			  in_extcodfinanciador IN number,
			  in_exthomnumeroconvenio IN varchar2,
			  in_exthomlugarconvenio IN varchar2,
			  in_extsucventa IN varchar2,
			  in_extrutconvenio IN varchar2,
			  in_extrutasociado IN varchar2,
			  in_extnomprestador IN varchar2,
			  in_extruttratante IN varchar2,
			  in_extespecialidad IN varchar2,
			  in_extrutbeneficiario IN varchar2,
			  in_extrutcotizante IN varchar2,
			  in_extrutacompanante IN varchar2,
			  in_extrutemisor IN varchar2,
			  in_extrutcajero IN varchar2,
			  in_extcodigodiagnostico IN varchar2,
			  in_extdescuentoxplanilla IN varchar2,
			  in_extmontoexcedente IN number,
			  in_extfechaemision IN varchar2,
			  in_extnivelconvenio IN number,
			  in_extfoliofinanciador IN number,
			  in_extmontovalortotal IN number,
			  in_extmontoaportetotal IN number,
			  in_extmontocopagototal IN number,
			  in_extnumoperacion IN number,
			  in_extcorrprestacion IN number,
			  in_exttiposolicitud IN number,
			  in_extfechainicio IN varchar2,
			  in_exturgencia IN varchar2,
			  in_extplan IN varchar2,
			  in_extlista1 IN varchar2,
			  in_extlista2 IN varchar2,
			  in_extlista3 IN varchar2,
			  out_extcoderror OUT varchar2,
			  Out_extMensajeError OUT varchar2
   )
   AS
      vnum		  NUMBER;
      vestado		  VARCHAR2 (1);
      v_idafil		  NUMBER;
      v_corr		  NUMBER;
      v_rutben		  NUMBER;
      v_dvben		  VARCHAR2 (1);
      vcoderror_01	  VARCHAR2 (1000);
      verror_01 	  VARCHAR2 (1000);
      vcoderror_02	  VARCHAR2 (1000);
      verror_02 	  VARCHAR2 (1000);
      vrutprestador	  NUMBER;
      vdvprestador	  VARCHAR2 (1);
      miarreglo 	  admbene.ben_pck_tipo_datos.arreglorep12;
      miARREGLOS	  admbene.BEN_PCK_TIPO_DATOS.ArregloRep12;
      fecha_emision_aux   VARCHAR2 (100);
      v_codplan 	  VARCHAR2 (255);
      v_codplanSeg	  VARCHAR2 (255);
      v_error		  VARCHAR2 (1000);
      v_fec_ini_acu	  DATE;
      v_fec_ter_acu	  DATE;
      v_valor_prest_uf	  NUMBER;
      v_valor_segur_uf	  NUMBER;
      v_bonif_maxima	  NUMBER;
      vcodisaprel1_1	  NUMBER;
      vcantidadl1_1	  NUMBER;
      vtotall1_1	  NUMBER;
      vbonifl1_1	  NUMBER;
      vcopagol1_1	  NUMBER;
      vbonif_bccl1_1	  NUMBER;
      vcreditol1_1	  NUMBER;
      vexcedentel1_1	  NUMBER;
      vayuasistl1_1	  NUMBER;
      vsegcompll1_1	  NUMBER;
      vrecargol1_1	  VARCHAR2 (3);
      vcodintel1_1	  VARCHAR2 (10);
      vinternoisa1_1	  VARCHAR2 (15);
      vcodisaprel1_2	  NUMBER;
      vcantidadl1_2	  NUMBER;
      vtotall1_2	  NUMBER;
      vbonifl1_2	  NUMBER;
      vcopagol1_2	  NUMBER;
      vbonif_bccl1_2	  NUMBER;
      vcreditol1_2	  NUMBER;
      vexcedentel1_2	  NUMBER;
      vayuasistl1_2	  NUMBER;
      vsegcompll1_2	  NUMBER;
      vrecargol1_2	  VARCHAR2 (3);
      vcodintel1_2	  VARCHAR2 (10);
      vinternoisa1_2	  VARCHAR2 (15);
      vcoderrorl1	  VARCHAR2 (100);
      verrorl1		  VARCHAR2 (100);
      vcodisaprel2_1	  NUMBER;
      vcantidadl2_1	  NUMBER;
      vtotall2_1	  NUMBER;
      vbonifl2_1	  NUMBER;
      vcopagol2_1	  NUMBER;
      vbonif_bccl2_1	  NUMBER;
      vcreditol2_1	  NUMBER;
      vexcedentel2_1	  NUMBER;
      vayuasistl2_1	  NUMBER;
      vsegcompll2_1	  NUMBER;
      vrecargol2_1	  VARCHAR2 (3);
      vcodintel2_1	  VARCHAR2 (10);
      vinternoisa2_1	  VARCHAR2 (15);
      vcodisaprel2_2	  NUMBER;
      vcantidadl2_2	  NUMBER;
      vtotall2_2	  NUMBER;
      vbonifl2_2	  NUMBER;
      vcopagol2_2	  NUMBER;
      vbonif_bccl2_2	  NUMBER;
      vcreditol2_2	  NUMBER;
      vexcedentel2_2	  NUMBER;
      vayuasistl2_2	  NUMBER;
      vsegcompll2_2	  NUMBER;
      vrecargol2_2	  VARCHAR2 (3);
      vcodintel2_2	  VARCHAR2 (10);
      vinternoisa2_2	  VARCHAR2 (15);
      vcoderrorl2	  VARCHAR2 (100);
      verrorl2		  VARCHAR2 (100);
      vcodisaprel3_1	  NUMBER;
      vcantidadl3_1	  NUMBER;
      vtotall3_1	  NUMBER;
      vbonifl3_1	  NUMBER;
      vcopagol3_1	  NUMBER;
      vbonif_bccl3_1	  NUMBER;
      vcreditol3_1	  NUMBER;
      vexcedentel3_1	  NUMBER;
      vayuasistl3_1	  NUMBER;
      vsegcompll3_1	  NUMBER;
      vrecargol3_1	  VARCHAR2 (3);
      vcodintel3_1	  VARCHAR2 (10);
      vinternoisa3_1	  VARCHAR2 (15);
      vcodisaprel3_2	  NUMBER;
      vcantidadl3_2	  NUMBER;
      vtotall3_2	  NUMBER;
      vbonifl3_2	  NUMBER;
      vcopagol3_2	  NUMBER;
      vbonif_bccl3_2	  NUMBER;
      vcreditol3_2	  NUMBER;
      vexcedentel3_2	  NUMBER;
      vayuasistl3_2	  NUMBER;
      vsegcompll3_2	  NUMBER;
      vrecargol3_2	  VARCHAR2 (3);
      vcodintel3_2	  VARCHAR2 (10);
      vinternoisa3_2	  VARCHAR2 (15);
      vcoderrorl3	  VARCHAR2 (100);
      verrorl3		  VARCHAR2 (100);
      v_total		  NUMBER;
      v_cantidad	  NUMBER;
      v_totalbonif	  NUMBER;
      v_totalbonif_bcc	  NUMBER;
      v_totalcopago	  NUMBER;
      v_totalcredito	  NUMBER;
      v_totalexcedente	  NUMBER;
      v_totalayuda	  NUMBER;
      v_totalseguroc	  NUMBER;
      v_fecact		  DATE;
      v_titcta		  NUMBER;
      v_codmov		  VARCHAR2 (255);
      v_secctades	  NUMBER;
      v_valormov	  NUMBER;
      res		  BOOLEAN;
      v_saldo		  NUMBER;
      v_codpago 	  VARCHAR2 (10);
      --In_extLista1 varchar2(255);
      vrutstaff 	  NUMBER;
      vdvstaff		  VARCHAR2 (1);
      p_valor_bonif	  NUMBER;			--BONIFICACION INICIAL
      v_top_prest	  NUMBER;				--TOPE INICIAL
      vid_isapre	  NUMBER;
      tipo_cobertura	  varchar2(10);
      tipo_coberturaS	  varchar2(10);
      tipo_pago_venta	  varchar2(3):=null;
      verror		  varchar2(1500);
      p_tope_anual	  number;
      p_tope_anualS	  number;

      v_dFECHA_EMISION	   DATE;
      v_dFECHA_EMISION_AUX DATE;

      vTipCob1_1	  VARCHAR2(10);
      vTipCobS1_1	  VARCHAR2(10);
      vTipCob1_2	  VARCHAR2(10);
      vTipCobS1_2	  VARCHAR2(10);
      vTipCob2_1	  VARCHAR2(10);
      vTipCobS2_1	  VARCHAR2(10);
      vTipCob2_2	  VARCHAR2(10);
      vTipCobS2_2	  VARCHAR2(10);
      vTipCob3_1	  VARCHAR2(10);
      vTipCobS3_1	  VARCHAR2(10);
      vTipCob3_2	  VARCHAR2(10);
      vTipCobS3_2	  VARCHAR2(10);
      -------------------------------------------------------------------------
      --Variables para Setear la Salida
      -------------------------------------------------------------------------
      vv_SEPARADOR	      VARCHAR2(1):=';';
      vv_PARAMETROS_SALIDA    VARCHAR2(4000);

      -------------------------------------------------------------------------
      --Variables Auxiliares
      -------------------------------------------------------------------------
      v_nIMED_AUDI_SEQ	      NUMBER(10);
      v_vPARAMETROS_ENTRADA   VARCHAR2(4000);
      v_vPRE		      VARCHAR2(10);

      E_salir		      EXCEPTION;
      v_exthomlugarconvenio   VARCHAR2(10);

      v_nBEN_D_ORS_AT_SEQ     NUMBER(10);
      v_nID_DETCOB	      NUMBER(10);
      v_vTIBE_CODIGO	      VARCHAR2(10);

      v_nDEAU_ID	      NUMBER(10);
      v_vTRAE_ID	      VARCHAR2(1);
      v_nMTO_BON_BCC	      NUMBER(15,2);
      v_nMTO_BON_SEG	      NUMBER(15,2);
      v_nMTO_CREDITO	      NUMBER(15,2);

   BEGIN

      DBMS_OUTPUT.PUT_LINE ( 'v_nPASO 1 ' );

      --In_extLista1  :='0000101001|0 |0101001	      | |01|0009000|0007188|0001812|		   |0|0000000|0|0000000|0|0000000|0|0000000|0|0000000|0000101001|0 |0101001	   | |01|0009000|0007188|0001812|		|0|0000000|0|0000000|0|0000000|0|0000000|0|0000000|';
      DBMS_OUTPUT.put_line ('partieron0');
      srv_message	    := '1000000';
      out_extcoderror	    := ' ';
      out_extmensajeerror   := ' ';
      fecha_emision_aux     := in_extfechaemision;
      v_total		    := 0;
      v_cantidad	    := 0;
      v_totalbonif	    := 0;
      v_totalbonif_bcc	    := 0;
      v_totalcopago	    := 0;
      v_totalcredito	    := 0;
      v_totalexcedente	    := 0;
      v_totalayuda	    := 0;
      v_totalseguroc	    := 0;

      -- Inserto en tabla de control trama que llega
      BEGIN
	 INSERT INTO admimed.imed_envbonis
	(
	    extcodfinanciador,			--     NUMBER		 NULL,
	    exthomnumeroconvenio,
	    --	VARCHAR2(15)	  NULL,
	    exthomlugarconvenio,		  --   VARCHAR2(10)	 NULL,
	    extsucventa,
	    --		 VARCHAR2(10)	   NULL,
	    extrutconvenio,		     --        VARCHAR2(12)	 NULL,
	    extrutasociado,
	    --	      VARCHAR2(12)	NULL,
	    extnomprestador,		      --       VARCHAR2(40)	 NULL,
	    extruttratante,
	    --	      VARCHAR2(10)	NULL,
	    extespecialidad,		      --       VARCHAR2(10)	 NULL,
	    extrutbeneficiario,
	    --	  VARCHAR2(12)	    NULL,
	    extrutcotizante,		      --       VARCHAR2(12)	 NULL,
	    extrutacompanante,
	    --	   VARCHAR2(12)      NULL,
	    extrutemisor,		   --	       VARCHAR2(12)	 NULL,
	    extrutcajero,
	    --		VARCHAR2(12)	  NULL,
	    extcodigodiagnostico,		   --  VARCHAR2(10)	 NULL,
	    extdescuentxoplanilla,
	    -- VARCHAR2(1)	 NULL,
	    extmontoexcedente,			--     NUMBER		 NULL,
	    extfechaemision,
	    --	     VARCHAR2(10)      NULL,
	    extnivelconvenio,		       --      NUMBER		 NULL,
	    extfoliofinanciador,
	    --	 NUMBER 	   NULL,
	    extmontovalortotal, 		 --    NUMBER		 NULL,
	    extmontoaportetotal,
	    --	 NUMBER 	   NULL,
	    extmontocopagototal,		  --   NUMBER		 NULL,
	    extnumoperacion,
	    --	     NUMBER	       NULL,
	    extcorrprestacion,			--     NUMBER		 NULL,
	    exttiposolicitud,
	    --	    NUMBER	      NULL,
	    extfechainicio,		     --        VARCHAR2(10)	 NULL,
	    exturgencia,
	    --		 VARCHAR2(1)	   NULL,
	    extplan,
	    --		     VARCHAR2(15)      NULL,
	    extlista1,			--	       VARCHAR2(255)	 NULL,
	    extlista2,
	    --		   VARCHAR2(255)     NULL,
	    extlista3,
	    --		   VARCHAR2(255)     NULL
	    fecha_recep
	)
	 VALUES (
		   in_extcodfinanciador,	  --	      In	Number
		   in_exthomnumeroconvenio,
		   --	    In	      Varchar2
		   in_exthomlugarconvenio,	    --	    In	      Varchar2
		   in_extsucventa,
		   --		   In	     Varchar2
		   in_extrutconvenio,		--	    In	      Varchar2
		   in_extrutasociado,
		   --		In	  Varchar2
		   in_extnomprestador,		 --	    In	      Varchar2
		   in_extruttratante,
		   --		In	  Varchar2
		   in_extespecialidad,		--	    In	      Varchar2
		   in_extrutbeneficiario,
		   --	   In	     Varchar2
		   in_extrutcotizante,		--	    In	      Varchar2
		   in_extrutacompanante,
		   --		In	  Varchar2
		   in_extrutemisor,	     -- 	    In	      Varchar2
		   in_extrutcajero,
		   --		  In	    Varchar2
		   in_extcodigodiagnostico,	  --	    In	      Varchar2
		   in_extdescuentoxplanilla,
		   --	   In	     Varchar2
		   in_extmontoexcedente,	    --	      In	Number
		   in_extfechaemision,
		   --to_date(In_extFechaEmision,'yyyymmdd'),--		 In	   date
		   in_extnivelconvenio, 	   --	      In	Number
		   in_extfoliofinanciador,
		   --	   In	     Number
		   in_extmontovalortotal,	     --       In	Number
		   in_extmontoaportetotal,
		   --	     In        Number
		   in_extmontocopagototal,	      --      In	Number
		   in_extnumoperacion,
		   --	       In	 Number
		   in_extcorrprestacion,	 --	      In	Number
		   in_exttiposolicitud,
		   --	      In	Number
		   in_extfechainicio,
		   --to_date(In_extFechaInicio,'yyyymmdd'),--	       In	 date
		   in_exturgencia,
		   --		   In	     Varchar2
		   in_extplan,
		   --		     In        Varchar2
		   in_extlista1,	  --		    In	      Varchar2
		   in_extlista2,
		   --		     In        Varchar2
		   in_extlista3,
		   --		     In        Varchar2
		   SYSDATE
		);

	 COMMIT;
      EXCEPTION
	 WHEN OTHERS
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Trama con error formato';
	    verror:= sqlerrm;
	    --insert into OPER.ERRORES (errores,fecha_proceso) values (out_extmensajeerror||' '||verror,sysdate);

	    RAISE E_SALIR;
      END;


      ----------------------------------------------------------------------
      -- Graba Auditoria de Transaccion
      ----------------------------------------------------------------------
      v_vPARAMETROS_ENTRADA := Null;
      v_vPARAMETROS_ENTRADA := srv_message||';'||in_extcodfinanciador||';'||in_exthomnumeroconvenio||';'||in_exthomlugarconvenio||';'||in_extsucventa||';'||
	    in_extrutconvenio||';'||in_extrutasociado||';'||in_extnomprestador||';'||in_extruttratante||';'||in_extespecialidad||';'||in_extrutbeneficiario||';'||in_extrutcotizante||';'||
	    in_extrutacompanante||';'||in_extrutemisor||';'||in_extrutcajero||';'||in_extcodigodiagnostico||';'||in_extdescuentoxplanilla||';'||in_extmontoexcedente||';'||in_extfechaemision||';'||
	    in_extnivelconvenio||';'||in_extfoliofinanciador||';'||in_extmontovalortotal||';'||in_extmontoaportetotal||';'||in_extmontocopagototal||';'||in_extnumoperacion||';'||in_extcorrprestacion||';'||
	    in_exttiposolicitud||';'||in_extfechainicio||';'||in_exturgencia||';'||in_extplan||';'||in_extlista1||';'||in_extlista2||';'||in_extlista3||';';

      If in_extcodfinanciador = 65 Then
	v_vPRE := 'CHU';
      elsIf in_extcodfinanciador = 63 Then
	v_vPRE := 'FUS';
      elsIf in_extcodfinanciador = 62 Then
	v_vPRE := 'SNL';
      elsIf in_extcodfinanciador = 68 Then
	v_vPRE := 'RBL';
      End if;

      Begin
	  Select ADMIMED.IMED_AUDI_SEQ.NextVAl
	  Into v_nIMED_AUDI_SEQ
	  From Dual;

	  Insert Into ADMIMED.IMED_AUDITORIA
	  (CORRELATIVO, ID_ISAPRE, NOMBRE_TRANSACCION, FECHA_TRANSACCION, NUMERO_CONVENIO, LUGAR_CONVENIO, SUC_VENTA, RUT_TRATANTE, RUT_BENEF, RUT_COTIZ, ID_AFI, CODIGO_CARGA, NRO_BONO_ISAPRE, MONTO_TOTAL_BONO, PREST_TOTALES_BONO, MONTO_ISAPRE_BONO, MONTO_COPAGO_BONO, DATOS_ENTRADA, DATOS_SALIDA, FEC_HOR_LLEGADA, FEC_HOR_SALIDA, SEGUNDOS_RESP)
	  Values
	  (v_nIMED_AUDI_SEQ,in_extcodfinanciador,v_vPRE||'ENVBONIS_PKG',sysdate,in_exthomnumeroconvenio,in_exthomlugarconvenio,in_extsucventa,substr(in_extruttratante,1,Instr(in_extruttratante,'-')-1),substr(in_extrutbeneficiario,1,Instr(in_extrutbeneficiario,'-')-1),null,null,null,null,null,null,null,null,v_vPARAMETROS_ENTRADA,null,Sysdate,Null,Null)
	  ;
      Exception
      When Others Then
	Null;
      End;
      COMMIT;

      if in_extcodfinanciador = 65 Then
	   -- Si no Existe el Id para Chuqui lo busco en Homologos
	   v_exthomlugarconvenio:= admimed.F_DOMI_HOMO_65(in_exthomlugarconvenio, substr(in_extrutconvenio,1,Instr(in_extrutconvenio,'-')-1) );
      else
	   v_exthomlugarconvenio:= in_exthomlugarconvenio;

      end if;


      Begin
	  v_dFECHA_EMISION := TO_DATE ( SUBSTR(in_extfechaemision,1,19), 'RRRR/MM/DD HH24:MI:SS' );
	  v_dFECHA_EMISION := trunc(v_dFECHA_EMISION);
      exception
      When Others Then
	 out_extcoderror       := 'N';
	 out_extmensajeerror   := 'Formato fecha emision no valido';
	 RAISE E_SALIR;
      End;
      v_dFECHA_EMISION_AUX := v_dFECHA_EMISION;

      DBMS_OUTPUT.put_line ('partieron');

      -- Valido codigo financiador
      IF in_extcodfinanciador not in(65,63,62,68)
      THEN
	 out_extcoderror       := 'N';
	 out_extmensajeerror   := 'Codigo Financiador Erroneo';
	 RAISE E_SALIR;
      END IF;

      if in_extdescuentoxplanilla = 'S' then
	tipo_pago_venta := 'DPP';
      elsif in_extdescuentoxplanilla = 'N' then
	tipo_pago_venta := 'EFT';
      end if;


      -- Valido folio financiador
      SELECT COUNT ( * )
      INTO vnum
      FROM ADMBENE.ben_beneficio
      WHERE num = in_extfoliofinanciador;

      IF NVL (vnum, 0) <> 0
      THEN
	 out_extcoderror       := 'N';
	 out_extmensajeerror   := 'Folio no valido';
	 RAISE E_SALIR;
      END IF;

      --4--

      -- Valido folio en folios entregados a IMED
      BEGIN
	 SELECT i.estado
	 INTO vestado
	 FROM admimed.imed_folios i
	 WHERE i.folio = in_extfoliofinanciador;
      EXCEPTION
	 WHEN NO_DATA_FOUND
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Folio IMED invalido';
	    RAISE E_SALIR;
      END;

      --5--
      IF vestado = 'U'
      THEN			    -- folio entregado , pero no utilizado aun
	 out_extcoderror       := 'N';
	 out_extmensajeerror   := 'Folio IMED ya utilizado';
	 RAISE E_SALIR;
      END IF;

      DBMS_OUTPUT.put_line ('ini vali prestador');
      -- valido prestador
      -- valido domicilio prestador
      admimed.validoprestador (in_exthomnumeroconvenio,
			       v_exthomlugarconvenio,--in_exthomlugarconvenio,
			       in_extsucventa,
			       in_extrutconvenio,
			       v_dFECHA_EMISION,--in_extfechaemision,
			       --to_date(In_extFechaEmision,'yyyymmdd'),--iFecha IN date,
			       vrutprestador,	   --oRutPrestador OUT number,
			       vdvprestador,	  --oDVPrestador OUT varchar2,
			       vcoderror_01,
			       verror_01
      );

      --OCHO--
      IF vcoderror_01 = 'S'
      THEN
	 out_extcoderror       := 'N';
	 out_extmensajeerror   := verror_01;
	 RAISE E_SALIR;
      END IF;

      DBMS_OUTPUT.put_line ('ini vali tratante');

      DBMS_OUTPUT.PUT_LINE ( '----------------------------------------------------------');
      DBMS_OUTPUT.PUT_LINE ( 'in_extruttratante = ' || in_extruttratante );
      DBMS_OUTPUT.PUT_LINE ( 'vrutprestador = ' || vrutprestador );

      IF TRIM (in_extruttratante) <> '0000000000-0'
      THEN
	 admimed.validostaff (in_extruttratante,
			      vrutprestador,
			      vrutstaff,
			      vdvstaff,
			      vcoderror_01,
			      verror_01
	 );

	 /*IF vcoderror_01 = 'S' AND 1=2
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := verror_01;
	    RAISE E_SALIR;
	 END IF;
	 */
      END IF;

      DBMS_OUTPUT.put_line ('ini vali benef');
      -- valido beneficiario
      admimed.validobeneficiario (in_extrutbeneficiario,
				  v_dFECHA_EMISION,--in_extfechaemision,
				  --to_date(In_extFechaEmision,'YYYYMMDD'),
				  v_idafil,
				  v_corr,
				  v_rutben,
				  v_dvben,
				  v_codplan,
				  vcoderror_02,
				  verror_02,
				  vid_isapre
      );

      --NUEVE--
      IF vcoderror_02 = 'S'
      THEN
	 out_extcoderror       := 'N';
	 out_extmensajeerror   := verror_02;
	 RAISE E_SALIR;
      END IF;


      --------------------------------------------------------------------------
      --PLAN
      --------------------------------------------------------------------------
      admbene.ben_crea_arreglo_topes12f (miarreglo,
					 v_codplan,
					 v_idafil,
					 v_corr,
					 v_dFECHA_EMISION,--in_extfechaemision,
					 --  TO_DATE(In_extFechaEmision,'YYYYMMDD'),
					 v_fec_ini_acu,
					 v_fec_ter_acu,
					 v_error
      );

      IF NOT v_error IS NULL
      THEN
	 out_extcoderror       := 'N';
	 out_extmensajeerror   := 'ERROR EN CREAC.TOPES';
	 RAISE E_SALIR;
      END IF;

      Begin
	select PLSE.COD_PLAN_SEG
	Into v_codplanSeg
	from ADMPLAN.PL_PLAN_SEGURO PLSE
	where PLSE.COD_PLAN_ISA = v_codplan
	and   v_dFECHA_EMISION between PLSE.FEC_INI_VIG and nvl(PLSE.FEC_TER_VIG,trunc(sysdate))
	;
      exception
      when Others then
	v_codplanSeg:= v_codplan;
      end;
      --------------------------------------------------------------------------
      --SEGURO
      --------------------------------------------------------------------------
      ADMBENE.BEN_CREA_ARREGLO_TOPES12F (miArregloS,
					 v_codplanSeg,
					 v_idafil,
					 v_corr,
					 v_dFECHA_EMISION,--In_extFechaEmision,
				    --	   TO_DATE(In_extFechaEmision,'YYYYMMDD'),
					 v_fec_ini_acu,
					 v_fec_ter_acu,
					 v_error);
      IF NOT v_error IS NULL THEN
	    Out_extCodError:='N';
	    Out_extMensajeError:='ERROR EN CREA TOPES SEG';
	    RAISE E_SALIR;
	    --Return;
      END IF;


      --------------------------------------------------------------------------
      --PLAN
      --------------------------------------------------------------------------
      --CARGA TOPES UTILIZADOS CON INFORMACION DE TOPES POR BENEFICIARIO
      ADMBENE.ben_carga_arreglo_topes_uti12 (miarreglo,
				     v_idafil,
				     v_corr,
				     v_dFECHA_EMISION,--in_extfechaemision,
				     -- 		    TO_DATE(In_extFechaEmision,'YYYYMMDD'),
				     v_codplan,
				     v_error
      );

      IF NOT v_error IS NULL
      THEN
	 out_extcoderror       := 'N';
	 out_extmensajeerror   := 'ERROR EN REC. DE TOPES';
	 RAISE E_SALIR;
      END IF;

      --------------------------------------------------------------------------
      --SEGURO
      --------------------------------------------------------------------------
      --CARGA TOPES UTILIZADOS CON INFORMACION DE TOPES POR BENEFICIARIO SEGURO
      ADMBENE.BEN_CARGA_ARREGLO_TOPES_UT_SEG(miArregloS,
				      v_idafil,
				      v_corr,
				      v_dFECHA_EMISION,--In_extFechaEmision,
	--				TO_DATE(In_extFechaEmision,'YYYYMMDD'),
				      v_codplanSeg,
				      v_error);

      IF NOT V_ERROR IS NULL THEN
	 Out_extCodError:='N';
	 Out_extMensajeError:='ERROR EN REC.TOPES';
	 RAISE E_SALIR;
      END IF;

      DBMS_OUTPUT.put_line ('ini insert ben_beneficio');

      -- aca creo documento
      INSERT INTO admbene.ben_beneficio
     (
	 num,				--	       NUMBER	     NOT NULL,
	 fec_emis,			     --        DATE	     NOT NULL,
	 valor, 			  --	       NUMBER		 NULL,
	 val_bon,
	 --	    NUMBER	      NULL,
	 emitido_por,				--     VARCHAR2(30)	 NULL,
	 impreso_por,				--     VARCHAR2(30)	 NULL,
	 anulado_por,
	 --	VARCHAR2(30)	  NULL,
	 motivo_anul,
	 --	NUMBER(5)	  NULL,
	 trasp_por,			      --       VARCHAR2(50)	 NULL,
	 fec_anulacion, 			  --   DATE		 NULL,
	 mens_prest,
	 --	 VARCHAR2(300)	   NULL,
	 obs_cont,
	 --	   VARCHAR2(300)     NULL,
	 tipo,
	 --	       VARCHAR2(4)	 NULL,
	 tipo_orden,
	 excedente,			      --       NUMBER(15)	 NULL,
	 morosidad,
	 --	  VARCHAR2(1)	    NULL,
	 be_to_cod,
	 --	  VARCHAR2(4)	NOT NULL,
	 beeo_cod,
	 --	   VARCHAR2(240) NOT NULL,
	 bb_id_afil,			       --      NUMBER(10)    NOT NULL,
	 bb_corr,			    --	       NUMBER(5)     NOT NULL,
	 btc_cod_pago,
	 --    VARCHAR2(4)   NOT NULL,
	 beoa_num,
	 --	   NUMBER	     NULL,
	 credito,
	 --	    NUMBER(15)	      NULL,
	 rut_prest,			      --       NUMBER(12)	 NULL,
	 cvdo_id_domi,				  --   NUMBER(8)	 NULL,
	 dv_prest,
	 --	   VARCHAR2(1)	     NULL,
	 convenio,			     --        VARCHAR2(1)	 NULL,
	 rut_solic,			      --       NUMBER(10)	 NULL,
	 dv_solic,
	 --	   VARCHAR2(1)	     NULL,
	 nom_solic,
	 --	  VARCHAR2(250)     NULL,
	 valor_aux,
	 --	  NUMBER(15)	    NULL,
	 fec_pago,			     --        DATE		 NULL,
	 nom_cheque,			       --      VARCHAR2(50)	 NULL,
	 rut_cheque,
	 --	 NUMBER(10)	   NULL,
	 ape_pat_cheque,
	 --  VARCHAR2(50)      NULL,
	 ape_mat_cheque,			   --  VARCHAR2(50)	 NULL,
	 dir_cheque,			       --      VARCHAR2(250)	 NULL,
	 manual,
	 --	     VARCHAR2(1)       NULL,
	 creado_por,
	 --	 VARCHAR2(30)	   NULL,
	 act_por,
	 --	    VARCHAR2(30)      NULL,
	 fec_creacion,				 --    DATE		 NULL,
	 fec_ult_act,				--     DATE		 NULL,
	 proh_carga,
	 --	 VARCHAR2(1)	   NULL,
	 cvca_id,
	 --	    NUMBER(4)	      NULL,
	 tipo_pago,
	 --	  VARCHAR2(3)	    NULL,
	 cvsp_cvps_rut, 			  --   NUMBER(10)	 NULL,
	 cvsp_cvst_rut, 			  --   NUMBER(10)	 NULL,
	 ppfb_id_fb,
	 --	 NUMBER 	   NULL,
	 monto_cred_nbon,
	 -- NUMBER(15)	      NULL,
	 crco_tipo,			      --       VARCHAR2(15)	 NULL,
	 crco_cod,
	 id_isapre,
	 OCM
     )					      --	VARCHAR2(15)	  NULL
      VALUES (
		in_extfoliofinanciador,     -- SECUENCIA PARA CREAR BENEFICIOS
		v_dFECHA_EMISION,--in_extfechaemision,
		--    to_date(In_extFechaEmision,'YYYYMMDD'), -- FECHA DE EMISION CORRESPONDE A FECHA CREACION. EN EL DETALLE ESTA LA FECHA DE LA COMPRA
		0,
		-- VALOR PRESTACION. POR EL MOMENTO 0, CUANDO SE CARGUEN LOS DATOS SE ACTUALIZA
		0,
		-- VALOR BONIFICACION. POR EL MOMENTO 0, CUANDO SE CARGUEN LOS DATOS SE ACTUALIZA,
		in_extrutemisor,			    -- USUARIO EMISION
		in_extrutcajero,			  -- USAURIO IMPRESION
		NULL,					  -- USUARIO ANULACION
		NULL,
		-- MOTIVO ANULACION
		NULL,					     -- TRASPASADO POR
		NULL,					    -- fecha anulacion
		NULL,				     -- MENSAJE PARA PRESTADOR
		NULL,				    --MENSAJE PARA CONTRALORIA
		'OATE',
		'IMED', 		 -- TIPO "FARC" FARMACIA COMPUTACIONAL
		NULL,						  -- EXCEDENTE
		NULL,		     -- MOROSIDAD ---> HAY QUE SACAR ESTE DATO
		'A',
		-- CODIGO TIPO DE LA ORDEN "A" AMBULATORIA
		'IMPR', 				 -- ESTADO DE LA ORDEN
		v_idafil,			  --IDENTIFICADOR DEL AFILIADO
		v_corr, 		       -- correlativo del beneficiario
		'CP1',
		-- CODIGO DE PAGO. SE DEBE ACTUALIZAR MAS ADELANTE
		NULL,
		-- beoa_num  NO SE UTILIZA AL PARECER
		0,
		-- CREDITO. SE ACTUALIZA DESPUES
		in_exthomnumeroconvenio,		  -- rut del prestador
		v_exthomlugarconvenio,--in_exthomlugarconvenio,
		-- ID DEL DOMICILIO. SI SE CAMBIA EL FORMATO MAS ADELANTE SE PUEDE POBLAR ESTE DATO
		NULL,
		-- DV del rut prestador
		NULL,						   -- convenio
		NULL,					    -- rut solicitante
		NULL,					     -- dv solicitante
		NULL,					 -- nombre solicitante
		NULL,						  -- valor aux
		NULL,						 -- fecha pago
		NULL,					      -- nombre cheque
		NULL,						 -- rut cheque
		NULL,					     -- ape pat cheque
		NULL,					     -- ape mat cheque
		NULL,						 -- dir cheque
		NULL,						     -- MANUAL
		USER,						 -- creado por
		USER,					    -- actualizado por
		SYSDATE,					-- fecha creac
		SYSDATE,					  -- fecha act
		NULL,				 -- proh carga ---> actualizar
		NULL,						    -- arancel
		tipo_pago_venta,			       -- identificador tipo pago
		in_exthomnumeroconvenio,		  -- rut del prestador
		NULL,					     -- rut del medico
		NULL,
		-- identificador pago a prestadores
		NULL,
		-- datos para creditos por prestaciones no bonificadas
		NULL,							    --
		NULL,
		vid_isapre,
		0
	     );

      v_totalexcedente	    := NVL (in_extmontoexcedente, 0);

      --------------------------------------------------------------------------
      -- Revisamos primera lista
      --------------------------------------------------------------------------

      admimed.validolista2 (in_exthomnumeroconvenio, --iRutConvenio IN NUMBER,
			    v_exthomlugarconvenio,--in_exthomlugarconvenio,    --iDomicilio IN NUMBER,
			    v_idafil,			--iIdAfil   IN NUMBER,
			    v_corr,			    --iCorr IN NUMBER,
			    v_dFECHA_EMISION,--in_extfechaemision,
			    --TO_DATE(In_extFechaEmision,'YYYYMMDD'),	       --iFecha IN DATE,
			    in_extlista1,		 --iLista IN varchar2,
			    vcodisaprel1_1,			-- OUT NUMBER,
			    vcantidadl1_1,			-- OUT NUMBER,
			    vtotall1_1, 			-- OUT NUMBER,
			    vbonifl1_1, 			-- OUT NUMBER,
			    vcopagol1_1,			-- OUT NUMBER,
			    vbonif_bccl1_1,
			    vcreditol1_1,			-- OUT NUMBER,
			    vexcedentel1_1,			-- OUT NUMBER,
			    vayuasistl1_1,			-- OUT NUMBER,
			    vsegcompll1_1,			-- OUT NUMBER,
			    vrecargol1_1,		      -- OUT varchar2,
			    vcodintel1_1,
			    vinternoisa1_1,		       -- OUT varchar2,
			    vcodisaprel1_2,			-- OUT NUMBER,
			    vcantidadl1_2,			-- OUT NUMBER,
			    vtotall1_2, 			-- OUT NUMBER,
			    vbonifl1_2, 			-- OUT NUMBER,
			    vcopagol1_2,			-- OUT NUMBER,
			    vbonif_bccl1_2,
			    vcreditol1_2,			-- OUT NUMBER,
			    vexcedentel1_2,			-- OUT NUMBER,
			    vayuasistl1_2,			-- OUT NUMBER,
			    vsegcompll1_2,			-- OUT NUMBER,
			    vrecargol1_2,		      -- OUT varchar2,
			    vcodintel1_2,		      -- OUT varchar2,
			    vinternoisa1_2,
			    vcoderrorl1,		      -- OUT varchar2,
			    verrorl1,
			    vid_isapre
      );						   -- OUT VARCHAR2) is

      DBMS_OUTPUT.PUT_LINE ( 'v_nPASO 1.02 ' );

      IF NOT verrorl1 IS NULL
      THEN
	 out_extcoderror       := 'N';
	 out_extmensajeerror   := SUBSTR (verrorl1, 1, 30);
	 --'ERROR EN LISTA 1';
	 ROLLBACK;
	 RAISE E_SALIR;
      END IF;


      IF vcodisaprel1_1 <> 0
      THEN

	 --Revisar si el Interno Isapre trae el valor del Detalle de Auditoria.
	 Begin
	    v_nDEAU_ID := to_number(vinternoisa1_1);
	    v_vTRAE_ID :='S';
	 Exception
	 When Others Then
	    v_vTRAE_ID :='N';
	 End;

	 DBMS_OUTPUT.PUT_LINE ( 'v_vTRAE_ID = ' || v_vTRAE_ID );
	 DBMS_OUTPUT.PUT_LINE ( 'v_nDEAU_ID = ' || v_nDEAU_ID );
	 DBMS_OUTPUT.PUT_LINE ( 'vtotall1_1 = ' || vtotall1_1 );
	 DBMS_OUTPUT.PUT_LINE ( 'vbonifl1_1 = ' || vbonifl1_1 );

	 DBMS_OUTPUT.PUT_LINE ( 'vbonif_bccl1_1 = ' || vbonif_bccl1_1 );
	 DBMS_OUTPUT.PUT_LINE ( 'vcreditol1_1 = ' || vcreditol1_1 );

	 If v_vTRAE_ID ='S' then
	     Begin
		Select DEAU.INTERNO_ISAPRE,DEAU.TIP_COB_PLAN, DEAU.TIP_COB_SEG, DEAU.MTO_BON_BCC, DEAU.MTO_BON_SEG, DEAU.MTO_CREDITO
		Into vinternoisa1_1,vTipCob1_1, vTipCobS1_1,v_nMTO_BON_BCC, v_nMTO_BON_SEG, v_nMTO_CREDITO
		from ADMIMED.IMED_DET_AUDITORIA DEAU
		where DEAU.ID = v_nDEAU_ID
		;
	     End;

	 else
	     IF in_extcodfinanciador in (65,68) and vinternoisa1_1 like '%*%' THEN
		 --Ejemplo CG*CG*0*
		 vTipCob1_1:=Substr(vinternoisa1_1,1,Instr(vinternoisa1_1,'*')-1);
		 vTipCobS1_1:=Substr(vinternoisa1_1,Instr(vinternoisa1_1,'*')+1,Instr(vinternoisa1_1,'*',2)-1);
	     ELSE
		 vTipCob1_1:=vinternoisa1_1;
		 vTipCobS1_1:=Null;
	     END IF;
	 End If;

	 ADMBENE.ben_transforma_pesos_enuf (v_codplan,
				    v_dFECHA_EMISION,--in_extfechaemision,
				    --			 to_date(In_extFechaEmision,'YYYYMMDD'),
				    vbonifl1_1,
				    v_valor_prest_uf,
				    v_error
	 );

	 IF NOT v_error IS NULL
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Error Bonif. L1 detalle 1(1)';
	    ROLLBACK;
	    RAISE E_SALIR;
	 END IF;

	 ADMBENE.BEN_TRANSFORMA_PESOS_ENUF( v_codplan,
				     v_dFECHA_EMISION,--In_extFechaEmision,
	--			      to_date(In_extFechaEmision,'YYYYMMDD'),
				    vbonif_bccl1_1,--vSegComplL1_1,
				    v_valor_segur_uf ,
				    v_error  );

	 IF NOT v_error IS NULL THEN
	    Out_extCodError:='N';
	    Out_extMensajeError:='Error Bonif. L1 detalle 1(S)';
	    rollback;
	    RAISE E_SALIR;
	 END IF;

	 IF ADMBENE.ben_f_verifica_cob_inicial12 (miarreglo,
					  v_codplan,
					  vcodisaprel1_1,
					  'A',
					  v_fec_ini_acu,
					  v_fec_ter_acu,
					  p_valor_bonif,
					  --BONIFICACION INICIAL
					  v_top_prest,		--TOPE INICIAL
					  v_dFECHA_EMISION_AUX,--fecha_emision_aux,
					  v_idafil,
					  v_corr,
					  v_error
	    )
	 THEN
	    IF NOT v_error IS NULL
	    THEN
	       out_extcoderror	     := 'N';
	       out_extmensajeerror   := SUBSTR (v_error, 1, 30);
	       ROLLBACK;
	       RAISE E_SALIR;
	    END IF;
	 END IF;

	 IF vTipCobS1_1 = 'CG' THEN
	     IF admbene.BEN_F_VERIFICA_COB_INICIAL12(
						miArregloS,
						v_codplanSeg,
						vCodIsapreL1_1,
						'A',
						v_fec_ini_acu ,
						v_fec_ter_acu,
						p_valor_bonif,	  --BONIFICACION INICIAL
						v_top_prest  ,	  --TOPE INICIAL
						v_dFECHA_EMISION_AUX,--In_extFechaEmision,
						v_idafil,
						v_corr,
						--> no Existe este parametro en la funcion de Calama --> In_extHomLugarConvenio, -- ID DEL DOMICILIO.
						V_error ) THEN
		IF NOT v_error	IS NULL THEN
		    Out_extCodError:='N';
		    Out_extMensajeError:= substr(v_error,1,30);
		    rollback;
		    RAISE E_SALIR;
		END IF;
	    END IF;
	 END IF;

	 v_bonif_maxima     := 99999999;

	 ADMBENE.ben_bonif_tipagrup_plan_idpr12 (miarreglo,
					 v_codplan,
					 vcodisaprel1_1,
					 'A',
					 v_valor_prest_uf, -- valor prestacion
					 v_fec_ini_acu,
					 v_fec_ter_acu,
					 'CG',
					 v_idafil,
					 v_corr,
					 4,
					 v_bonif_maxima,
					 p_tope_anual,
					 v_error
	 );

	 IF NOT v_error IS NULL
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Error Bonif. L1 detalle 1(2)';
	    ROLLBACK;
	    RAISE E_SALIR;
	 END IF;

	 ADMBENE.BEN_BONIF_TIPAGRUP_PLAN_IDPR12(miArregloS,
				    v_codplanSeg,
				    vCodIsapreL1_1,
				     'A',
				    v_valor_segur_uf, -- valor prestacion
				    v_fec_ini_acu ,
				    v_fec_ter_acu ,
				    vTipCobS1_1,
				    v_idafil,
				    v_corr,
				    4,
				    v_bonif_maxima    ,

TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				    p_tope_anualS,
				    v_error    ) ;

	 IF NOT v_error IS NULL THEN
	     Out_extCodError:='N';
	     Out_extMensajeError:='Error Bonif. L1 detalle 1(2)';
	     rollback;
	     RAISE E_SALIR;
	 END IF;

	 ADMBENE.ben_actualiza_topes_arreglo12 (miarreglo,
					v_idafil,
					v_corr,
					vcantidadl1_1,
					v_valor_prest_uf
	 );

	 ADMBENE.BEN_ACTUALIZA_TOPES_ARREGLO12(miarregloS,
					v_idafil,
					v_corr,
					vCantidadL1_1,
					v_valor_segur_uf);

	DBMS_OUTPUT.PUT_LINE ( 'vbonif_bccl1_1 = ' || vbonif_bccl1_1 );
	DBMS_OUTPUT.PUT_LINE ( 'vcreditol1_1 = ' || vcreditol1_1 );

	 IF vcreditol1_1 > 0 and in_extcodfinanciador = 65 THEN
	    null;
	    --vbonif_bccl1_1 := vbonif_bccl1_1-vcreditol1_1;
	 ELSE
	    vcreditol1_1:=0;
	 END IF;

	 BEGIN

	     SELECT ADMBENE.BEN_D_ORS_AT_SEQ.NEXTVAL
	     INTO v_nBEN_D_ORS_AT_SEQ
	     FROM DUAL;

	     INSERT INTO admbene.ben_d_beneficio
	     (
		id_det, 				 --NUMBER(10)	 NOT NULL,
		beoa_num,				 --NUMBER	 NOT NULL,
		bonif,					 --NUMBER(15)	 NOT NULL,
		num,					 --NUMBER(15)	 NOT NULL,
		valor,					 --NUMBER(15,2)  NOT NULL,
		valor_total,				 --NUMBER(15)	     NULL,
		horario,				 --VARCHAR2(3)	 NOT NULL,
		ayu_asist,				 --NUMBER(15)	     NULL,
		seguro_compl,				 --NUMBER(15)	     NULL,
		bebpm_id_bol,
		--NUMBER	    NULL,
		pmae_id_prest,
		--NUMBER	NOT NULL,
		bein_cod,				  --VARCHAR2(4)       NULL,
		VAL_BCC,
		VAL_COPAGO_FINAL,
		TCOBER_COD,
		TCOBER_COD_SEG
	     )
	     VALUES
	     (
		v_nBEN_D_ORS_AT_SEQ,
		in_extfoliofinanciador,
		vbonifl1_1 - vbonif_bccl1_1- vcreditol1_1,
		vcantidadl1_1,
		vtotall1_1 / vcantidadl1_1,
		vtotall1_1,
		vrecargol1_1,
		vayuasistl1_1,
		0,
		NULL,
		vcodisaprel1_1,
		vcodintel1_1,
		vbonif_bccl1_1,
		vcopagol1_1+vcreditol1_1,
		vTipCob1_1,
		vTipCobS1_1
	     );
	 END;

	 IF NVL(vbonif_bccl1_1,0) > 0 THEN

	     IF v_nMTO_BON_SEG > 0 THEN
		 v_vTIBE_CODIGO := 'SEGU';
		 BEGIN
		    ADMBENE.PCK_DET_COB_BENEFICIOS.P_INSERT_DET_COB_BEN (
			      v_nID_DETCOB,				--pio_nID_DETCOB	IN OUT NUMBER,
			      v_nBEN_D_ORS_AT_SEQ,			--pi_nDBENE_ID_DET	IN NUMBER,
			      v_vTIBE_CODIGO,				--pi_vTIBE_CODIGO	IN VARCHAR2,
			      in_extfoliofinanciador,			--pi_nNUMERO_BONO	IN NUMBER,
			      v_nMTO_BON_SEG,				--pi_nMONTO_BONIFICADO	IN NUMBER,
			      vTipCobS1_1,				--pi_vTCOBER_COD	IN VARCHAR2,
			      v_error					--po_vDESC_ERROR	OUT VARCHAR2
		    );

		 exception
		 When others then
		    v_error:= 'Error al Insertar Det. Segu.';
		 END;
	     END IF;

	     IF NOT v_error IS NULL THEN
		out_extcoderror       := 'N';
		out_extmensajeerror   := v_error;
		ROLLBACK;
		RAISE E_SALIR;
	     END IF;

	     IF v_nMTO_BON_BCC > 0 THEN
		 v_vTIBE_CODIGO := 'BCC';
		 BEGIN
		    ADMBENE.PCK_DET_COB_BENEFICIOS.P_INSERT_DET_COB_BEN (
			      v_nID_DETCOB,				--pio_nID_DETCOB	IN OUT NUMBER,
			      v_nBEN_D_ORS_AT_SEQ,			--pi_nDBENE_ID_DET	IN NUMBER,
			      v_vTIBE_CODIGO,				--pi_vTIBE_CODIGO	IN VARCHAR2,
			      in_extfoliofinanciador,			--pi_nNUMERO_BONO	IN NUMBER,
			      v_nMTO_BON_BCC,				--pi_nMONTO_BONIFICADO	IN NUMBER,
			      vTipCobS1_1,				--pi_vTCOBER_COD	IN VARCHAR2,
			      v_error					--po_vDESC_ERROR	OUT VARCHAR2
		    );

		 exception
		 When others then
		    v_error:= 'Error al Insertar Det. Bcc.';
		 END;
	     END IF;


	     IF NOT v_error IS NULL THEN
		out_extcoderror       := 'N';
		out_extmensajeerror   := v_error;
		ROLLBACK;
		RAISE E_SALIR;
	     END IF;

	 END IF;



	 v_total	    := v_total + vtotall1_1;
	 v_cantidad	    := v_cantidad + vcantidadl1_1;
	 v_totalbonif	    := v_totalbonif + vbonifl1_1;
	 v_totalbonif_bcc   := v_totalbonif_bcc + vbonif_bccl1_1;
	 v_totalcopago	    := v_totalcopago + vcopagol1_1;
	 v_totalcredito     := v_totalcredito + vcreditol1_1;
	 v_totalexcedente   := v_totalexcedente + vexcedentel1_1;
	 v_totalayuda	    := v_totalayuda + vayuasistl1_1;
	 v_totalseguroc     := v_totalseguroc + vsegcompll1_1;


	 if tipo_cobertura is null then
	    tipo_cobertura     := vTipCob1_1;
	 end if;

	 if tipo_coberturaS is null then
	    tipo_coberturaS    := vTipCobS1_1;
	 end if;

      END IF;

      --------------------------------------------------------------------------
      -- Lista 1 , Segundo Elemento
      --------------------------------------------------------------------------
      IF vcodisaprel1_2 <> 0
      THEN

	 --Revisar si el Interno Isapre trae el valor del Detalle de Auditoria.
	 Begin
	    v_nDEAU_ID := to_number(vinternoisa1_2);
	    v_vTRAE_ID :='S';
	 Exception
	 When Others Then
	    v_vTRAE_ID :='N';
	 End;

	 If v_vTRAE_ID ='S' then
	     Begin
		Select DEAU.INTERNO_ISAPRE,DEAU.TIP_COB_PLAN, DEAU.TIP_COB_SEG, DEAU.MTO_BON_BCC, DEAU.MTO_BON_SEG, DEAU.MTO_CREDITO
		Into vinternoisa1_2,vTipCob1_2, vTipCobS1_2,v_nMTO_BON_BCC, v_nMTO_BON_SEG, v_nMTO_CREDITO
		from ADMIMED.IMED_DET_AUDITORIA DEAU
		where DEAU.ID = v_nDEAU_ID
		;
	     End;

	 else
	     IF in_extcodfinanciador in (65,68) and vinternoisa1_2 like '%*%' THEN
		 --Ejemplo CG*CG*0*
		 vTipCob1_2:=Substr(vinternoisa1_2,1,Instr(vinternoisa1_2,'*')-1);
		 vTipCobS1_2:=Substr(vinternoisa1_2,Instr(vinternoisa1_2,'*')+1,Instr(vinternoisa1_2,'*',2)-1);
	     ELSE
		 vTipCob1_2:=vinternoisa1_2;
		 vTipCobS1_2:=Null;
	     END IF;
	 End If;

	 ADMBENE.ben_transforma_pesos_enuf (v_codplan,
				    v_dFECHA_EMISION,--in_extfechaemision,
				    --			 to_date(In_extFechaEmision,'YYYYMMDD'),
				    vbonifl1_2,
				    v_valor_prest_uf,
				    v_error
	 );

	 IF NOT v_error IS NULL
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Error Bonif. L1 detalle 1(1)';
	    ROLLBACK;
	    RAISE E_SALIR;
	 END IF;

	 ADMBENE.BEN_TRANSFORMA_PESOS_ENUF( v_codplan,
				     v_dFECHA_EMISION,--In_extFechaEmision,
	--			      to_date(In_extFechaEmision,'YYYYMMDD'),
				    vbonif_bccl1_2,--vSegComplL1_2,
				    v_valor_segur_uf ,
				    v_error  );

	 IF NOT v_error IS NULL THEN
	    Out_extCodError:='N';
	    Out_extMensajeError:='Error Bonif. L1 detalle 1(S)';
	    rollback;
	    RAISE E_SALIR;
	 END IF;

	 v_bonif_maxima     := 99999999;

	 ADMBENE.ben_bonif_tipagrup_plan_idpr12 (miarreglo,
					 v_codplan,
					 vcodisaprel1_2,
					 'A',
					 v_valor_prest_uf, -- valor prestacion
					 v_fec_ini_acu,
					 v_fec_ter_acu,
					 'CG',
					 v_idafil,
					 v_corr,
					 4,
					 v_bonif_maxima,
					 p_tope_anual,
					 v_error
	 );

	 IF NOT v_error IS NULL
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Error Bonif. L1 detalle 1(2)';
	    ROLLBACK;
	    RAISE E_SALIR;
	 END IF;

	 ADMBENE.BEN_BONIF_TIPAGRUP_PLAN_IDPR12(miArregloS,
				    v_codplanSeg,
				    vCodIsapreL1_2,
				     'A',
				    v_valor_segur_uf, -- valor prestacion
				    v_fec_ini_acu ,
				    v_fec_ter_acu ,
				    vTipCobS1_2,
				    v_idafil,
				    v_corr,
				    4,
				    v_bonif_maxima    ,
				    p_tope_anualS,
				    v_error    ) ;

	 IF NOT v_error IS NULL THEN
	     Out_extCodError:='N';
	     Out_extMensajeError:='Error Bonif. L1 detalle 1(2)';
	     rollback;
	     RAISE E_SALIR;
	 END IF;

	 ADMBENE.ben_actualiza_topes_arreglo12 (miarreglo,
					v_idafil,
					v_corr,
					vcantidadl1_2,
					v_valor_prest_uf
	 );

	 ADMBENE.BEN_ACTUALIZA_TOPES_ARREGLO12(miarregloS,
					v_idafil,
					v_corr,
					vCantidadL1_2,
					v_valor_segur_uf);


	 IF vcreditol1_2 > 0 and in_extcodfinanciador = 65 THEN
	    null;
	    --vbonif_bccl1_2 := vbonif_bccl1_2-vcreditol1_2;
	 ELSE
	    vcreditol1_2:=0;
	 END IF;

	 BEGIN

	     SELECT ADMBENE.BEN_D_ORS_AT_SEQ.NEXTVAL
	     INTO v_nBEN_D_ORS_AT_SEQ
	     FROM DUAL;

	     INSERT INTO admbene.ben_d_beneficio
	     (
		id_det, 				 --NUMBER(10)	 NOT NULL,
		beoa_num,				 --NUMBER	 NOT NULL,
		bonif,					 --NUMBER(15)	 NOT NULL,
		num,					 --NUMBER(15)	 NOT NULL,
		valor,					 --NUMBER(15,2)  NOT NULL,
		valor_total,				 --NUMBER(15)	     NULL,
		horario,				 --VARCHAR2(3)	 NOT NULL,
		ayu_asist,				 --NUMBER(15)	     NULL,
		seguro_compl,				 --NUMBER(15)	     NULL,
		bebpm_id_bol,
		--NUMBER	    NULL,
		pmae_id_prest,
		--NUMBER	NOT NULL,
		bein_cod,				  --VARCHAR2(4)       NULL,
		VAL_BCC,
		VAL_COPAGO_FINAL,
		TCOBER_COD,
		TCOBER_COD_SEG
	     )
	     VALUES
	     (
		v_nBEN_D_ORS_AT_SEQ,
		   in_extfoliofinanciador,
		   vbonifl1_2 - vbonif_bccl1_2-vcreditol1_2,
		   vcantidadl1_2,
		   vtotall1_2 / vcantidadl1_2,
		   vtotall1_2,
		   vrecargol1_2,
		   vayuasistl1_2,
		   0,
		   NULL,
		   vcodisaprel1_2,
		   vcodintel1_2,
		   vbonif_bccl1_2,
		   vcopagol1_2+vcreditol1_2,
		   vTipCob1_2,
		   vTipCobS1_2
		);

	 END;

	 IF NVL(vbonif_bccl1_2,0) > 0 THEN

	     IF v_nMTO_BON_SEG > 0 THEN
		 v_vTIBE_CODIGO := 'SEGU';
		 BEGIN
		    ADMBENE.PCK_DET_COB_BENEFICIOS.P_INSERT_DET_COB_BEN (
			      v_nID_DETCOB,				--pio_nID_DETCOB	IN OUT NUMBER,
			      v_nBEN_D_ORS_AT_SEQ,			--pi_nDBENE_ID_DET	IN NUMBER,
			      v_vTIBE_CODIGO,				--pi_vTIBE_CODIGO	IN VARCHAR2,
			      in_extfoliofinanciador,			--pi_nNUMERO_BONO	IN NUMBER,
			      v_nMTO_BON_SEG,				--pi_nMONTO_BONIFICADO	IN NUMBER,
			      vTipCobS1_2,				--pi_vTCOBER_COD	IN VARCHAR2,
			      v_error					--po_vDESC_ERROR	OUT VARCHAR2
		    );

		 exception
		 When others then
		    v_error:= 'Error al Insertar Det. Segu.';
		 END;
	     END IF;

	     IF NOT v_error IS NULL THEN
		out_extcoderror       := 'N';
		out_extmensajeerror   := v_error;
		ROLLBACK;
		RAISE E_SALIR;
	     END IF;

	     IF v_nMTO_BON_BCC > 0 THEN
		 v_vTIBE_CODIGO := 'BCC';
		 BEGIN
		    ADMBENE.PCK_DET_COB_BENEFICIOS.P_INSERT_DET_COB_BEN (
			      v_nID_DETCOB,				--pio_nID_DETCOB	IN OUT NUMBER,
			      v_nBEN_D_ORS_AT_SEQ,			--pi_nDBENE_ID_DET	IN NUMBER,
			      v_vTIBE_CODIGO,				--pi_vTIBE_CODIGO	IN VARCHAR2,
			      in_extfoliofinanciador,			--pi_nNUMERO_BONO	IN NUMBER,
			      v_nMTO_BON_BCC,				--pi_nMONTO_BONIFICADO	IN NUMBER,
			      vTipCobS1_2,				--pi_vTCOBER_COD	IN VARCHAR2,
			      v_error					--po_vDESC_ERROR	OUT VARCHAR2
		    );

		 exception
		 When others then
		    v_error:= 'Error al Insertar Det. Bcc.';
		 END;
	     END IF;


	     IF NOT v_error IS NULL THEN
		out_extcoderror       := 'N';
		out_extmensajeerror   := v_error;
		ROLLBACK;
		RAISE E_SALIR;
	     END IF;

	 END IF;

	 v_total	    := v_total + vtotall1_2;
	 v_cantidad	    := v_cantidad + vcantidadl1_2;
	 v_totalbonif	    := v_totalbonif + vbonifl1_2;
	 v_totalbonif_bcc   := v_totalbonif_bcc + vbonif_bccl1_2;
	 v_totalcopago	    := v_totalcopago + vcopagol1_2;
	 v_totalcredito     := v_totalcredito + vcreditol1_2;
	 v_totalexcedente   := v_totalexcedente + vexcedentel1_2;
	 v_totalayuda	    := v_totalayuda + vayuasistl1_2;
	 v_totalseguroc     := v_totalseguroc + vsegcompll1_2;

	 if tipo_cobertura is null then
	    tipo_cobertura     := vTipCob1_2;
	 end if;

	 if tipo_coberturaS is null then
	    tipo_coberturaS    := vTipCobS1_2;
	 end if;

      END IF;

      --------------------------------------------------------------------------
      -- Revisamos segunda lista
      --------------------------------------------------------------------------
      admimed.validolista2 (in_exthomnumeroconvenio, --iRutConvenio IN NUMBER,
			    v_exthomlugarconvenio,--in_exthomlugarconvenio,    --iDomicilio IN NUMBER,
			    v_idafil,			--iIdAfil   IN NUMBER,
			    v_corr,			    --iCorr IN NUMBER,
			    v_dFECHA_EMISION,--in_extfechaemision,
			    --to_date(In_extFechaEmision,'YYYYMMDD'),	       --iFecha IN DATE,
			    in_extlista2,		 --iLista IN varchar2,
			    vcodisaprel2_1,			-- OUT NUMBER,
			    vcantidadl2_1,			-- OUT NUMBER,
			    vtotall2_1, 			-- OUT NUMBER,
			    vbonifl2_1, 			-- OUT NUMBER,
			    vcopagol2_1,			-- OUT NUMBER,
			    vbonif_bccl2_1,
			    vcreditol2_1,			-- OUT NUMBER,
			    vexcedentel2_1,			-- OUT NUMBER,
			    vayuasistl2_1,			-- OUT NUMBER,
			    vsegcompll2_1,			-- OUT NUMBER,
			    vrecargol2_1,		      -- OUT varchar2,
			    vcodintel2_1,
			    vinternoisa2_1,			-- OUT varchar2,
			    vcodisaprel2_2,			-- OUT NUMBER,
			    vcantidadl2_2,			-- OUT NUMBER,
			    vtotall2_2, 			-- OUT NUMBER,
			    vbonifl2_2, 			-- OUT NUMBER,
			    vcopagol2_2,			-- OUT NUMBER,
			    vbonif_bccl2_2,
			    vcreditol2_2,			-- OUT NUMBER,
			    vexcedentel2_2,			-- OUT NUMBER,
			    vayuasistl2_2,			-- OUT NUMBER,
			    vsegcompll2_2,			-- OUT NUMBER,
			    vrecargol2_2,		      -- OUT varchar2,
			    vcodintel2_2,		      -- OUT varchar2,
			    vinternoisa2_2,
			    vcoderrorl2,		      -- OUT varchar2,
			    verrorl2,
			    vid_isapre
      );						   -- OUT VARCHAR2) is

      IF NOT verrorl2 IS NULL
      THEN
	 out_extcoderror       := 'N';
	 out_extmensajeerror   := 'ERROR EN LISTA 2';
	 ROLLBACK;
	 RAISE E_SALIR;
      END IF;

      IF vcodisaprel2_1 <> 0
      THEN
	 --Revisar si el Interno Isapre trae el valor del Detalle de Auditoria.
	 Begin
	    v_nDEAU_ID := to_number(vinternoisa2_1);
	    v_vTRAE_ID :='S';
	 Exception
	 When Others Then
	    v_vTRAE_ID :='N';
	 End;

	 If v_vTRAE_ID ='S' then
	     Begin
		Select DEAU.INTERNO_ISAPRE,DEAU.TIP_COB_PLAN, DEAU.TIP_COB_SEG, DEAU.MTO_BON_BCC, DEAU.MTO_BON_SEG, DEAU.MTO_CREDITO
		Into vinternoisa2_1,vTipCob2_1, vTipCobS2_1,v_nMTO_BON_BCC, v_nMTO_BON_SEG, v_nMTO_CREDITO
		from ADMIMED.IMED_DET_AUDITORIA DEAU
		where DEAU.ID = v_nDEAU_ID
		;
	     End;

	 else
	     IF in_extcodfinanciador in (65,68) and vinternoisa2_1 like '%*%' THEN
		 --Ejemplo CG*CG*0*
		 vTipCob2_1:=Substr(vinternoisa2_1,1,Instr(vinternoisa2_1,'*')-1);
		 vTipCobS2_1:=Substr(vinternoisa2_1,Instr(vinternoisa2_1,'*')+1,Instr(vinternoisa2_1,'*',2)-1);
	     ELSE
		 vTipCob2_1:=vinternoisa2_1;
		 vTipCobS2_1:=Null;
	     END IF;
	 End If;

	 ADMBENE.ben_transforma_pesos_enuf (v_codplan,
				    v_dFECHA_EMISION,--in_extfechaemision,
				    --			 to_date(In_extFechaEmision,'YYYYMMDD'),
				    vbonifl2_1,
				    v_valor_prest_uf,
				    v_error
	 );

	 IF NOT v_error IS NULL
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Error Bonif. L1 detalle 1(1)';
	    ROLLBACK;
	    RAISE E_SALIR;
	 END IF;

	 ADMBENE.BEN_TRANSFORMA_PESOS_ENUF( v_codplan,
				     v_dFECHA_EMISION,--In_extFechaEmision,
	--			      to_date(In_extFechaEmision,'YYYYMMDD'),
				    vbonif_bccl2_1,--vSegComplL2_1,
				    v_valor_segur_uf ,
				    v_error  );

	 IF NOT v_error IS NULL THEN
	    Out_extCodError:='N';
	    Out_extMensajeError:='Error Bonif. L1 detalle 1(S)';
	    rollback;
	    RAISE E_SALIR;
	 END IF;

	 v_bonif_maxima     := 99999999;

	 ADMBENE.ben_bonif_tipagrup_plan_idpr12 (miarreglo,
					 v_codplan,
					 vcodisaprel2_1,
					 'A',
					 v_valor_prest_uf, -- valor prestacion
					 v_fec_ini_acu,
					 v_fec_ter_acu,
					 'CG',
					 v_idafil,
					 v_corr,
					 4,
					 v_bonif_maxima,
					 p_tope_anual,
					 v_error
	 );

	 IF NOT v_error IS NULL
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Error Bonif. L1 detalle 1(2)';
	    ROLLBACK;
	    RAISE E_SALIR;
	 END IF;

	 ADMBENE.BEN_BONIF_TIPAGRUP_PLAN_IDPR12(miArregloS,
				    v_codplanSeg,
				    vCodIsapreL2_1,
				     'A',
				    v_valor_segur_uf, -- valor prestacion
				    v_fec_ini_acu ,
				    v_fec_ter_acu ,
				    vTipCobS2_1,
				    v_idafil,
				    v_corr,
				    4,
				    v_bonif_maxima    ,
				    p_tope_anualS,
				    v_error    ) ;

	 IF NOT v_error IS NULL THEN
	     Out_extCodError:='N';
	     Out_extMensajeError:='Error Bonif. L1 detalle 1(2)';
	     rollback;
	     RAISE E_SALIR;
	 END IF;

	 ADMBENE.ben_actualiza_topes_arreglo12 (miarreglo,
					v_idafil,
					v_corr,
					vcantidadl2_1,
					v_valor_prest_uf
	 );

	 ADMBENE.BEN_ACTUALIZA_TOPES_ARREGLO12(miarregloS,
					v_idafil,
					v_corr,
					vCantidadL2_1,
					v_valor_segur_uf);

	 IF vcreditol2_1 > 0 and in_extcodfinanciador = 65 THEN
	    null;
	    --vbonif_bccl2_1 := vbonif_bccl2_1-vcreditol2_1;
	 ELSE
	    vcreditol2_1:=0;
	 END IF;

	 BEGIN

	     SELECT ADMBENE.BEN_D_ORS_AT_SEQ.NEXTVAL
	     INTO v_nBEN_D_ORS_AT_SEQ
	     FROM DUAL;

	     INSERT INTO admbene.ben_d_beneficio
	     (
		id_det, 				 --NUMBER(10)	 NOT NULL,
		beoa_num,				 --NUMBER	 NOT NULL,
		bonif,					 --NUMBER(15)	 NOT NULL,
		num,					 --NUMBER(15)	 NOT NULL,
		valor,					 --NUMBER(15,2)  NOT NULL,
		valor_total,				 --NUMBER(15)	     NULL,
		horario,				 --VARCHAR2(3)	 NOT NULL,
		ayu_asist,				 --NUMBER(15)	     NULL,
		seguro_compl,				 --NUMBER(15)	     NULL,
		bebpm_id_bol,
		--NUMBER	    NULL,
		pmae_id_prest,
		--NUMBER	NOT NULL,
		bein_cod,				  --VARCHAR2(4)       NULL,
		VAL_BCC,
		VAL_COPAGO_FINAL,
		TCOBER_COD,
		TCOBER_COD_SEG
	     )
	     VALUES
	     (
		v_nBEN_D_ORS_AT_SEQ,
		   in_extfoliofinanciador,
		   vbonifl2_1 - vbonif_bccl2_1-vcreditol2_1,
		   vcantidadl2_1,
		   vtotall2_1 / vcantidadl2_1,
		   vtotall2_1,
		   vrecargol2_1,
		   vayuasistl2_1,
		   0,
		   NULL,
		   vcodisaprel2_1,
		   vcodintel2_1,
		   vbonif_bccl2_1,
		   vcopagol2_1+vcreditol2_1,
		   vTipCob2_1,
		   vTipCobS2_1
		);

	 END;

	 IF NVL(vbonif_bccl2_1,0) > 0 THEN

	     IF v_nMTO_BON_SEG > 0 THEN
		 v_vTIBE_CODIGO := 'SEGU';
		 BEGIN
		    ADMBENE.PCK_DET_COB_BENEFICIOS.P_INSERT_DET_COB_BEN (
			      v_nID_DETCOB,				--pio_nID_DETCOB	IN OUT NUMBER,
			      v_nBEN_D_ORS_AT_SEQ,			--pi_nDBENE_ID_DET	IN NUMBER,
			      v_vTIBE_CODIGO,				--pi_vTIBE_CODIGO	IN VARCHAR2,
			      in_extfoliofinanciador,			--pi_nNUMERO_BONO	IN NUMBER,
			      v_nMTO_BON_SEG,				--pi_nMONTO_BONIFICADO	IN NUMBER,
			      vTipCobS2_1,				--pi_vTCOBER_COD	IN VARCHAR2,
			      v_error					--po_vDESC_ERROR	OUT VARCHAR2
		    );

		 exception
		 When others then
		    v_error:= 'Error al Insertar Det. Segu.';
		 END;
	     END IF;

	     IF NOT v_error IS NULL THEN
		out_extcoderror       := 'N';
		out_extmensajeerror   := v_error;
		ROLLBACK;
		RAISE E_SALIR;
	     END IF;

	     IF v_nMTO_BON_BCC > 0 THEN
		 v_vTIBE_CODIGO := 'BCC';
		 BEGIN
		    ADMBENE.PCK_DET_COB_BENEFICIOS.P_INSERT_DET_COB_BEN (
			      v_nID_DETCOB,				--pio_nID_DETCOB	IN OUT NUMBER,
			      v_nBEN_D_ORS_AT_SEQ,			--pi_nDBENE_ID_DET	IN NUMBER,
			      v_vTIBE_CODIGO,				--pi_vTIBE_CODIGO	IN VARCHAR2,
			      in_extfoliofinanciador,			--pi_nNUMERO_BONO	IN NUMBER,
			      v_nMTO_BON_BCC,				--pi_nMONTO_BONIFICADO	IN NUMBER,
			      vTipCobS2_1,				--pi_vTCOBER_COD	IN VARCHAR2,
			      v_error					--po_vDESC_ERROR	OUT VARCHAR2
		    );

		 exception
		 When others then
		    v_error:= 'Error al Insertar Det. Bcc.';
		 END;
	     END IF;


	     IF NOT v_error IS NULL THEN
		out_extcoderror       := 'N';
		out_extmensajeerror   := v_error;
		ROLLBACK;
		RAISE E_SALIR;
	     END IF;

	 END IF;


	 v_total	    := v_total + vtotall2_1;
	 v_cantidad	    := v_cantidad + vcantidadl2_1;
	 v_totalbonif	    := v_totalbonif + vbonifl2_1;
	 v_totalbonif_bcc   := v_totalbonif_bcc + vbonif_bccl2_1;
	 v_totalcopago	    := v_totalcopago + vcopagol2_1;
	 v_totalcredito     := v_totalcredito + vcreditol2_1;
	 v_totalexcedente   := v_totalexcedente + vexcedentel2_1;
	 v_totalayuda	    := v_totalayuda + vayuasistl2_1;
	 v_totalseguroc     := v_totalseguroc + vsegcompll2_1;

	 IF tipo_cobertura is null then
	     tipo_cobertura	:= vTipCob2_1;
	 end if;
	 if tipo_coberturaS is null then
	     tipo_coberturaS	:= vTipCobS2_1;
	 end if;

      END IF;

      --------------------------------------------------------------------------
      -- Lista 2 , Segundo Elemento
      --------------------------------------------------------------------------
      IF vcodisaprel2_2 <> 0
      THEN

	 --Revisar si el Interno Isapre trae el valor del Detalle de Auditoria.
	 Begin
	    v_nDEAU_ID := to_number(vinternoisa2_2);
	    v_vTRAE_ID :='S';
	 Exception
	 When Others Then
	    v_vTRAE_ID :='N';
	 End;

	 If v_vTRAE_ID ='S' then
	     Begin
		Select DEAU.INTERNO_ISAPRE,DEAU.TIP_COB_PLAN, DEAU.TIP_COB_SEG, DEAU.MTO_BON_BCC, DEAU.MTO_BON_SEG, DEAU.MTO_CREDITO
		Into vinternoisa2_2,vTipCob2_2, vTipCobS2_2,v_nMTO_BON_BCC, v_nMTO_BON_SEG, v_nMTO_CREDITO
		from ADMIMED.IMED_DET_AUDITORIA DEAU
		where DEAU.ID = v_nDEAU_ID
		;
	     End;

	 else
	     IF in_extcodfinanciador in (65,68) and vinternoisa2_2 like '%*%' THEN
		 --Ejemplo CG*CG*0*
		 vTipCob2_2:=Substr(vinternoisa2_2,1,Instr(vinternoisa2_2,'*')-1);
		 vTipCobS2_2:=Substr(vinternoisa2_2,Instr(vinternoisa2_2,'*')+1,Instr(vinternoisa2_2,'*',2)-1);
	     ELSE
		 vTipCob2_2:=vinternoisa2_2;
		 vTipCobS2_2:=Null;
	     END IF;
	 End If;

	 ADMBENE.ben_transforma_pesos_enuf (v_codplan,
				    v_dFECHA_EMISION,--in_extfechaemision,
				    --			 to_date(In_extFechaEmision,'YYYYMMDD'),
				    vbonifl2_2,
				    v_valor_prest_uf,
				    v_error
	 );

	 IF NOT v_error IS NULL
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Error Bonif. L1 detalle 1(1)';
	    ROLLBACK;
	    RAISE E_SALIR;
	 END IF;

	 ADMBENE.BEN_TRANSFORMA_PESOS_ENUF( v_codplan,
				     v_dFECHA_EMISION,--In_extFechaEmision,
	--			      to_date(In_extFechaEmision,'YYYYMMDD'),
				    vbonif_bccl2_2,--vSegComplL2_2,
				    v_valor_segur_uf ,
				    v_error  );

	 IF NOT v_error IS NULL THEN
	    Out_extCodError:='N';
	    Out_extMensajeError:='Error Bonif. L1 detalle 1(S)';
	    rollback;
	    RAISE E_SALIR;
	 END IF;

	 v_bonif_maxima     := 99999999;

	 ADMBENE.ben_bonif_tipagrup_plan_idpr12 (miarreglo,
					 v_codplan,
					 vcodisaprel2_2,
					 'A',
					 v_valor_prest_uf, -- valor prestacion
					 v_fec_ini_acu,
					 v_fec_ter_acu,
					 'CG',
					 v_idafil,
					 v_corr,
					 4,
					 v_bonif_maxima,
					 p_tope_anual,
					 v_error
	 );

	 IF NOT v_error IS NULL
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Error Bonif. L1 detalle 1(2)';
	    ROLLBACK;
	    RAISE E_SALIR;
	 END IF;

	 ADMBENE.BEN_BONIF_TIPAGRUP_PLAN_IDPR12(miArregloS,
				    v_codplanSeg,
				    vCodIsapreL2_2,
				     'A',
				    v_valor_segur_uf, -- valor prestacion
				    v_fec_ini_acu ,
				    v_fec_ter_acu ,
				    vTipCobS2_2,
				    v_idafil,
				    v_corr,
				    4,
				    v_bonif_maxima    ,
				    p_tope_anualS,
				    v_error    ) ;

	 IF NOT v_error IS NULL THEN
	     Out_extCodError:='N';
	     Out_extMensajeError:='Error Bonif. L1 detalle 1(2)';
	     rollback;
	     RAISE E_SALIR;
	 END IF;

	 ADMBENE.ben_actualiza_topes_arreglo12 (miarreglo,
					v_idafil,
					v_corr,
					vcantidadl2_2,
					v_valor_prest_uf
	 );

	 ADMBENE.BEN_ACTUALIZA_TOPES_ARREGLO12(miarregloS,
					v_idafil,
					v_corr,
					vCantidadL2_2,
					v_valor_segur_uf);

	 IF vcreditol2_2 > 0 and in_extcodfinanciador = 65 THEN
	    null;
	    --vbonif_bccl2_2 := vbonif_bccl2_2-vcreditol2_2;
	 ELSE
	    vcreditol2_2:=0;
	 END IF;

	 BEGIN

	     SELECT ADMBENE.BEN_D_ORS_AT_SEQ.NEXTVAL
	     INTO v_nBEN_D_ORS_AT_SEQ
	     FROM DUAL;

	     INSERT INTO admbene.ben_d_beneficio
	     (
		id_det, 				 --NUMBER(10)	 NOT NULL,
		beoa_num,				 --NUMBER	 NOT NULL,
		bonif,					 --NUMBER(15)	 NOT NULL,
		num,					 --NUMBER(15)	 NOT NULL,
		valor,					 --NUMBER(15,2)  NOT NULL,
		valor_total,				 --NUMBER(15)	     NULL,
		horario,				 --VARCHAR2(3)	 NOT NULL,
		ayu_asist,				 --NUMBER(15)	     NULL,
		seguro_compl,				 --NUMBER(15)	     NULL,
		bebpm_id_bol,
		--NUMBER	    NULL,
		pmae_id_prest,
		--NUMBER	NOT NULL,
		bein_cod,				  --VARCHAR2(4)       NULL,
		VAL_BCC,
		VAL_COPAGO_FINAL,
		TCOBER_COD,
		TCOBER_COD_SEG
	     )
	     VALUES
	     (
		v_nBEN_D_ORS_AT_SEQ,
		   in_extfoliofinanciador,
		   vbonifl2_2 - vbonif_bccl2_2-vcreditol2_2,
		   vcantidadl2_2,
		   vtotall2_2 / vcantidadl2_2,
		   vtotall2_2,
		   vrecargol2_2,
		   vayuasistl2_2,
		   0,
		   NULL,
		   vcodisaprel2_2,
		   vcodintel2_2,
		   vbonif_bccl2_2,
		   vcopagol2_2+vcreditol2_2,
		   vTipCob2_2,
		   vTipCobS2_2
		);

	 END;
	 IF NVL(vbonif_bccl2_2,0) > 0 THEN

	     IF v_nMTO_BON_SEG > 0 THEN
		 v_vTIBE_CODIGO := 'SEGU';
		 BEGIN
		    ADMBENE.PCK_DET_COB_BENEFICIOS.P_INSERT_DET_COB_BEN (
			      v_nID_DETCOB,				--pio_nID_DETCOB	IN OUT NUMBER,
			      v_nBEN_D_ORS_AT_SEQ,			--pi_nDBENE_ID_DET	IN NUMBER,
			      v_vTIBE_CODIGO,				--pi_vTIBE_CODIGO	IN VARCHAR2,
			      in_extfoliofinanciador,			--pi_nNUMERO_BONO	IN NUMBER,
			      v_nMTO_BON_SEG,				--pi_nMONTO_BONIFICADO	IN NUMBER,
			      vTipCobS2_2,				--pi_vTCOBER_COD	IN VARCHAR2,
			      v_error					--po_vDESC_ERROR	OUT VARCHAR2
		    );

		 exception
		 When others then
		    v_error:= 'Error al Insertar Det. Segu.';
		 END;
	     END IF;

	     IF NOT v_error IS NULL THEN
		out_extcoderror       := 'N';
		out_extmensajeerror   := v_error;
		ROLLBACK;
		RAISE E_SALIR;
	     END IF;

	     IF v_nMTO_BON_BCC > 0 THEN
		 v_vTIBE_CODIGO := 'BCC';
		 BEGIN
		    ADMBENE.PCK_DET_COB_BENEFICIOS.P_INSERT_DET_COB_BEN (
			      v_nID_DETCOB,				--pio_nID_DETCOB	IN OUT NUMBER,
			      v_nBEN_D_ORS_AT_SEQ,			--pi_nDBENE_ID_DET	IN NUMBER,
			      v_vTIBE_CODIGO,				--pi_vTIBE_CODIGO	IN VARCHAR2,
			      in_extfoliofinanciador,			--pi_nNUMERO_BONO	IN NUMBER,
			      v_nMTO_BON_BCC,				--pi_nMONTO_BONIFICADO	IN NUMBER,
			      vTipCobS2_2,				--pi_vTCOBER_COD	IN VARCHAR2,
			      v_error					--po_vDESC_ERROR	OUT VARCHAR2
		    );

		 exception
		 When others then
		    v_error:= 'Error al Insertar Det. Bcc.';
		 END;
	     END IF;


	     IF NOT v_error IS NULL THEN
		out_extcoderror       := 'N';
		out_extmensajeerror   := v_error;
		ROLLBACK;
		RAISE E_SALIR;
	     END IF;

	 END IF;

	 v_total	    := v_total + vtotall2_2;
	 v_cantidad	    := v_cantidad + vcantidadl2_2;
	 v_totalbonif	    := v_totalbonif + vbonifl2_2;
	 v_totalbonif_bcc   := v_totalbonif_bcc + vbonif_bccl2_2;
	 v_totalcopago	    := v_totalcopago + vcopagol2_2;
	 v_totalcredito     := v_totalcredito + vcreditol2_2;
	 v_totalexcedente   := v_totalexcedente + vexcedentel2_2;
	 v_totalayuda	    := v_totalayuda + vayuasistl2_2;
	 v_totalseguroc     := v_totalseguroc + vsegcompll2_2;

	 if tipo_cobertura is null then
	     tipo_cobertura	:= vTipCob2_2;
	 end if;
	 if tipo_coberturaS is null then
	     tipo_coberturaS	:= vTipCobS2_2;
	 end if;

      END IF;

      --------------------------------------------------------------------------
      -- Revisamos tercera lista
      --------------------------------------------------------------------------

      admimed.validolista2 (in_exthomnumeroconvenio, --iRutConvenio IN NUMBER,
			    v_exthomlugarconvenio,--in_exthomlugarconvenio,    --iDomicilio IN NUMBER,
			    v_idafil,			--iIdAfil   IN NUMBER,
			    v_corr,			    --iCorr IN NUMBER,
			    v_dFECHA_EMISION,--in_extfechaemision,
			    --TO_DATE(In_extFechaEmision,'YYYYMMDD'),	       --iFecha IN DATE,
			    in_extlista3,		 --iLista IN varchar2,
			    vcodisaprel3_1,			-- OUT NUMBER,
			    vcantidadl3_1,			-- OUT NUMBER,
			    vtotall3_1, 			-- OUT NUMBER,

TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			    vbonifl3_1, 			-- OUT NUMBER,
			    vcopagol3_1,			-- OUT NUMBER,
			    vbonif_bccl3_1,
			    vcreditol3_1,			-- OUT NUMBER,
			    vexcedentel3_1,			-- OUT NUMBER,
			    vayuasistl3_1,			-- OUT NUMBER,
			    vsegcompll3_1,			-- OUT NUMBER,
			    vrecargol3_1,		      -- OUT varchar2,
			    vcodintel3_1,		      -- OUT varchar2,
			    vinternoisa3_1,
			    vcodisaprel3_2,			-- OUT NUMBER,
			    vcantidadl3_2,			-- OUT NUMBER,
			    vtotall3_2, 			-- OUT NUMBER,
			    vbonifl3_2, 			-- OUT NUMBER,
			    vcopagol3_2,			-- OUT NUMBER,
			    vbonif_bccl3_2,
			    vcreditol3_2,			-- OUT NUMBER,
			    vexcedentel3_2,			-- OUT NUMBER,
			    vayuasistl3_2,			-- OUT NUMBER,
			    vsegcompll3_2,			-- OUT NUMBER,
			    vrecargol3_2,		      -- OUT varchar2,
			    vcodintel3_2,		      -- OUT varchar2,
			    vinternoisa3_2,
			    vcoderrorl3,		      -- OUT varchar2,
			    verrorl3,
			    vid_isapre
      );						   -- OUT VARCHAR2) is
      DBMS_OUTPUT.PUT_LINE ( 'v_nPASO 1.2 ' );

      IF NOT verrorl3 IS NULL
      THEN
	 out_extcoderror       := 'N';
	 out_extmensajeerror   := 'ERROR EN LISTA 3';
	 ROLLBACK;
	 RAISE E_SALIR;
      END IF;

      IF vcodisaprel3_1 <> 0
      THEN

	 --Revisar si el Interno Isapre trae el valor del Detalle de Auditoria.
	 Begin
	    v_nDEAU_ID := to_number(vinternoisa3_1);
	    v_vTRAE_ID :='S';
	 Exception
	 When Others Then
	    v_vTRAE_ID :='N';
	 End;

	 If v_vTRAE_ID ='S' then
	     Begin
		Select DEAU.INTERNO_ISAPRE,DEAU.TIP_COB_PLAN, DEAU.TIP_COB_SEG, DEAU.MTO_BON_BCC, DEAU.MTO_BON_SEG, DEAU.MTO_CREDITO
		Into vinternoisa3_1,vTipCob3_1, vTipCobS3_1,v_nMTO_BON_BCC, v_nMTO_BON_SEG, v_nMTO_CREDITO
		from ADMIMED.IMED_DET_AUDITORIA DEAU
		where DEAU.ID = v_nDEAU_ID
		;
	     End;

	 else
	     IF in_extcodfinanciador in (65,68) and vinternoisa3_1 like '%*%' THEN
		 --Ejemplo CG*CG*0*
		 vTipCob3_1:=Substr(vinternoisa3_1,1,Instr(vinternoisa3_1,'*')-1);
		 vTipCobS3_1:=Substr(vinternoisa3_1,Instr(vinternoisa3_1,'*')+1,Instr(vinternoisa3_1,'*',2)-1);
	     ELSE
		 vTipCob3_1:=vinternoisa3_1;
		 vTipCobS3_1:=Null;
	     END IF;
	 End If;

	 ADMBENE.ben_transforma_pesos_enuf (v_codplan,
				    v_dFECHA_EMISION,--in_extfechaemision,
				    --			 to_date(In_extFechaEmision,'YYYYMMDD'),
				    vbonifl3_1,
				    v_valor_prest_uf,
				    v_error
	 );

	 IF NOT v_error IS NULL
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Error Bonif. L1 detalle 1(1)';
	    ROLLBACK;
	    RAISE E_SALIR;
	 END IF;

	 ADMBENE.BEN_TRANSFORMA_PESOS_ENUF( v_codplan,
				     v_dFECHA_EMISION,--In_extFechaEmision,
	--			      to_date(In_extFechaEmision,'YYYYMMDD'),
				    vbonif_bccl3_1,--vSegComplL3_1,
				    v_valor_segur_uf ,
				    v_error  );

	 IF NOT v_error IS NULL THEN
	    Out_extCodError:='N';
	    Out_extMensajeError:='Error Bonif. L1 detalle 1(S)';
	    rollback;
	    RAISE E_SALIR;
	 END IF;

	 v_bonif_maxima     := 99999999;

	 ADMBENE.ben_bonif_tipagrup_plan_idpr12 (miarreglo,
					 v_codplan,
					 vcodisaprel3_1,
					 'A',
					 v_valor_prest_uf, -- valor prestacion
					 v_fec_ini_acu,
					 v_fec_ter_acu,
					 'CG',
					 v_idafil,
					 v_corr,
					 4,
					 v_bonif_maxima,
					 p_tope_anual,
					 v_error
	 );

	 IF NOT v_error IS NULL
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Error Bonif. L1 detalle 1(2)';
	    ROLLBACK;
	    RAISE E_SALIR;
	 END IF;

	 ADMBENE.BEN_BONIF_TIPAGRUP_PLAN_IDPR12(miArregloS,
				    v_codplanSeg,
				    vCodIsapreL3_1,
				     'A',
				    v_valor_segur_uf, -- valor prestacion
				    v_fec_ini_acu ,
				    v_fec_ter_acu ,
				    vTipCobS3_1,
				    v_idafil,
				    v_corr,
				    4,
				    v_bonif_maxima    ,
				    p_tope_anualS,
				    v_error    ) ;

	 IF NOT v_error IS NULL THEN
	     Out_extCodError:='N';
	     Out_extMensajeError:='Error Bonif. L1 detalle 1(2)';
	     rollback;
	     RAISE E_SALIR;
	 END IF;

	 ADMBENE.ben_actualiza_topes_arreglo12 (miarreglo,
					v_idafil,
					v_corr,
					vcantidadl3_1,
					v_valor_prest_uf
	 );

	 ADMBENE.BEN_ACTUALIZA_TOPES_ARREGLO12(miarregloS,
					v_idafil,
					v_corr,
					vCantidadL3_1,
					v_valor_segur_uf);

	 IF vcreditol3_1 > 0 and in_extcodfinanciador = 65 THEN
	    null;
	    --vbonif_bccl3_1 := vbonif_bccl3_1-vcreditol3_1;
	 ELSE
	    vcreditol3_1:=0;
	 END IF;

	 BEGIN

	     SELECT ADMBENE.BEN_D_ORS_AT_SEQ.NEXTVAL
	     INTO v_nBEN_D_ORS_AT_SEQ
	     FROM DUAL;

	     INSERT INTO admbene.ben_d_beneficio
	     (
		id_det, 				 --NUMBER(10)	 NOT NULL,
		beoa_num,				 --NUMBER	 NOT NULL,
		bonif,					 --NUMBER(15)	 NOT NULL,
		num,					 --NUMBER(15)	 NOT NULL,
		valor,					 --NUMBER(15,2)  NOT NULL,
		valor_total,				 --NUMBER(15)	     NULL,
		horario,				 --VARCHAR2(3)	 NOT NULL,
		ayu_asist,				 --NUMBER(15)	     NULL,
		seguro_compl,				 --NUMBER(15)	     NULL,
		bebpm_id_bol,
		--NUMBER	    NULL,
		pmae_id_prest,
		--NUMBER	NOT NULL,
		bein_cod,				  --VARCHAR2(4)       NULL,
		VAL_BCC,
		VAL_COPAGO_FINAL,
		TCOBER_COD,
		TCOBER_COD_SEG
	     )
	     VALUES
	     (
		v_nBEN_D_ORS_AT_SEQ,
		   in_extfoliofinanciador,
		   vbonifl3_1 - vbonif_bccl3_1-vcreditol3_1,
		   vcantidadl3_1,
		   vtotall3_1 / vcantidadl3_1,
		   vtotall3_1,
		   vrecargol3_1,
		   vayuasistl3_1,
		   0,
		   NULL,
		   vcodisaprel3_1,
		   vcodintel3_1,
		   vbonif_bccl3_1,
		   vcopagol3_1+vcreditol3_1,
		   vTipCob3_1,
		   vTipCobS3_1
		);

	 END;

	 IF NVL(vbonif_bccl3_1,0) > 0 THEN

	     IF v_nMTO_BON_SEG > 0 THEN
		 v_vTIBE_CODIGO := 'SEGU';
		 BEGIN
		    ADMBENE.PCK_DET_COB_BENEFICIOS.P_INSERT_DET_COB_BEN (
			      v_nID_DETCOB,				--pio_nID_DETCOB	IN OUT NUMBER,
			      v_nBEN_D_ORS_AT_SEQ,			--pi_nDBENE_ID_DET	IN NUMBER,
			      v_vTIBE_CODIGO,				--pi_vTIBE_CODIGO	IN VARCHAR2,
			      in_extfoliofinanciador,			--pi_nNUMERO_BONO	IN NUMBER,
			      v_nMTO_BON_SEG,				--pi_nMONTO_BONIFICADO	IN NUMBER,
			      vTipCobS3_1,				--pi_vTCOBER_COD	IN VARCHAR2,
			      v_error					--po_vDESC_ERROR	OUT VARCHAR2
		    );

		 exception
		 When others then
		    v_error:= 'Error al Insertar Det. Segu.';
		 END;
	     END IF;

	     IF NOT v_error IS NULL THEN
		out_extcoderror       := 'N';
		out_extmensajeerror   := v_error;
		ROLLBACK;
		RAISE E_SALIR;
	     END IF;

	     IF v_nMTO_BON_BCC > 0 THEN
		 v_vTIBE_CODIGO := 'BCC';
		 BEGIN
		    ADMBENE.PCK_DET_COB_BENEFICIOS.P_INSERT_DET_COB_BEN (
			      v_nID_DETCOB,				--pio_nID_DETCOB	IN OUT NUMBER,
			      v_nBEN_D_ORS_AT_SEQ,			--pi_nDBENE_ID_DET	IN NUMBER,
			      v_vTIBE_CODIGO,				--pi_vTIBE_CODIGO	IN VARCHAR2,
			      in_extfoliofinanciador,			--pi_nNUMERO_BONO	IN NUMBER,
			      v_nMTO_BON_BCC,				--pi_nMONTO_BONIFICADO	IN NUMBER,
			      vTipCobS3_1,				--pi_vTCOBER_COD	IN VARCHAR2,
			      v_error					--po_vDESC_ERROR	OUT VARCHAR2
		    );

		 exception
		 When others then
		    v_error:= 'Error al Insertar Det. Bcc.';
		 END;
	     END IF;


	     IF NOT v_error IS NULL THEN
		out_extcoderror       := 'N';
		out_extmensajeerror   := v_error;
		ROLLBACK;
		RAISE E_SALIR;
	     END IF;

	 END IF;

	 v_total	    := v_total + vtotall3_1;
	 v_cantidad	    := v_cantidad + vcantidadl3_1;
	 v_totalbonif	    := v_totalbonif + vbonifl3_1;
	 v_totalbonif_bcc   := v_totalbonif_bcc + vbonif_bccl3_1;
	 v_totalcopago	    := v_totalcopago + vcopagol3_1;
	 v_totalcredito     := v_totalcredito + vcreditol3_1;
	 v_totalexcedente   := v_totalexcedente + vexcedentel3_1;
	 v_totalayuda	    := v_totalayuda + vayuasistl3_1;
	 v_totalseguroc     := v_totalseguroc + vsegcompll3_1;

	 if tipo_cobertura is null then
	     tipo_cobertura	:= vTipCob3_1;
	 end if;
	 if tipo_coberturaS is null then
	     tipo_coberturaS	:= vTipCobS3_1;
	 end if;

      END IF;

      --------------------------------------------------------------------------
      -- Lista 3 , Segundo Elemento
      --------------------------------------------------------------------------
      IF vcodisaprel3_2 <> 0
      THEN
	 --Revisar si el Interno Isapre trae el valor del Detalle de Auditoria.
	 Begin
	    v_nDEAU_ID := to_number(vinternoisa3_2);
	    v_vTRAE_ID :='S';
	 Exception
	 When Others Then
	    v_vTRAE_ID :='N';
	 End;

	 If v_vTRAE_ID ='S' then
	     Begin
		Select DEAU.INTERNO_ISAPRE,DEAU.TIP_COB_PLAN, DEAU.TIP_COB_SEG, DEAU.MTO_BON_BCC, DEAU.MTO_BON_SEG, DEAU.MTO_CREDITO
		Into vinternoisa3_2,vTipCob3_2, vTipCobS3_2,v_nMTO_BON_BCC, v_nMTO_BON_SEG, v_nMTO_CREDITO
		from ADMIMED.IMED_DET_AUDITORIA DEAU
		where DEAU.ID = v_nDEAU_ID
		;
	     End;

	 else
	     IF in_extcodfinanciador in (65,68) and vinternoisa3_2 like '%*%' THEN
		 --Ejemplo CG*CG*0*
		 vTipCob3_2:=Substr(vinternoisa3_2,1,Instr(vinternoisa3_2,'*')-1);
		 vTipCobS3_2:=Substr(vinternoisa3_2,Instr(vinternoisa3_2,'*')+1,Instr(vinternoisa3_2,'*',2)-1);
	     ELSE
		 vTipCob3_2:=vinternoisa3_2;
		 vTipCobS3_2:=Null;
	     END IF;
	 End If;

	 ADMBENE.ben_transforma_pesos_enuf (v_codplan,
				    v_dFECHA_EMISION,--in_extfechaemision,
				    --			 to_date(In_extFechaEmision,'YYYYMMDD'),
				    vbonifl3_2,
				    v_valor_prest_uf,
				    v_error
	 );

	 IF NOT v_error IS NULL
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Error Bonif. L1 detalle 1(1)';
	    ROLLBACK;
	    RAISE E_SALIR;
	 END IF;

	 ADMBENE.BEN_TRANSFORMA_PESOS_ENUF( v_codplan,
				     v_dFECHA_EMISION,--In_extFechaEmision,
	--			      to_date(In_extFechaEmision,'YYYYMMDD'),
				    vbonif_bccl3_2,--vSegComplL3_2,
				    v_valor_segur_uf ,
				    v_error  );

	 IF NOT v_error IS NULL THEN
	    Out_extCodError:='N';
	    Out_extMensajeError:='Error Bonif. L1 detalle 1(S)';
	    rollback;
	    RAISE E_SALIR;
	 END IF;

	 v_bonif_maxima     := 99999999;

	 ADMBENE.ben_bonif_tipagrup_plan_idpr12 (miarreglo,
					 v_codplan,
					 vcodisaprel3_2,
					 'A',
					 v_valor_prest_uf, -- valor prestacion
					 v_fec_ini_acu,
					 v_fec_ter_acu,
					 'CG',
					 v_idafil,
					 v_corr,
					 4,
					 v_bonif_maxima,
					 p_tope_anual,
					 v_error
	 );

	 IF NOT v_error IS NULL
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Error Bonif. L1 detalle 1(2)';
	    ROLLBACK;
	    RAISE E_SALIR;
	 END IF;

	 ADMBENE.BEN_BONIF_TIPAGRUP_PLAN_IDPR12(miArregloS,
				    v_codplanSeg,
				    vCodIsapreL3_2,
				     'A',
				    v_valor_segur_uf, -- valor prestacion
				    v_fec_ini_acu ,
				    v_fec_ter_acu ,
				    vTipCobS3_2,
				    v_idafil,
				    v_corr,
				    4,
				    v_bonif_maxima    ,
				    p_tope_anualS,
				    v_error    ) ;

	 IF NOT v_error IS NULL THEN
	     Out_extCodError:='N';
	     Out_extMensajeError:='Error Bonif. L1 detalle 1(2)';
	     rollback;
	     RAISE E_SALIR;
	 END IF;

	 ADMBENE.ben_actualiza_topes_arreglo12 (miarreglo,
					v_idafil,
					v_corr,
					vcantidadl3_2,
					v_valor_prest_uf
	 );

	 ADMBENE.BEN_ACTUALIZA_TOPES_ARREGLO12(miarregloS,
					v_idafil,
					v_corr,
					vCantidadL3_2,
					v_valor_segur_uf);

	 IF vcreditol3_2 > 0 and in_extcodfinanciador = 65 THEN
	    null;
	    --vbonif_bccl3_2 := vbonif_bccl3_2-vcreditol3_2;
	 ELSE
	    vcreditol3_2:=0;
	 END IF;

	 BEGIN

	     SELECT ADMBENE.BEN_D_ORS_AT_SEQ.NEXTVAL
	     INTO v_nBEN_D_ORS_AT_SEQ
	     FROM DUAL;

	     INSERT INTO admbene.ben_d_beneficio
	     (
		id_det, 				 --NUMBER(10)	 NOT NULL,
		beoa_num,				 --NUMBER	 NOT NULL,
		bonif,					 --NUMBER(15)	 NOT NULL,
		num,					 --NUMBER(15)	 NOT NULL,
		valor,					 --NUMBER(15,2)  NOT NULL,
		valor_total,				 --NUMBER(15)	     NULL,
		horario,				 --VARCHAR2(3)	 NOT NULL,
		ayu_asist,				 --NUMBER(15)	     NULL,
		seguro_compl,				 --NUMBER(15)	     NULL,
		bebpm_id_bol,
		--NUMBER	    NULL,
		pmae_id_prest,
		--NUMBER	NOT NULL,
		bein_cod,				  --VARCHAR2(4)       NULL,
		VAL_BCC,
		VAL_COPAGO_FINAL,
		TCOBER_COD,
		TCOBER_COD_SEG
	     )
	     VALUES
	     (
		v_nBEN_D_ORS_AT_SEQ,
		   in_extfoliofinanciador,
		   vbonifl3_2 - vbonif_bccl3_2-vcreditol3_2,
		   vcantidadl3_2,
		   vtotall3_2 / vcantidadl3_2,
		   vtotall3_2,
		   vrecargol3_2,
		   vayuasistl3_2,
		   0,
		   NULL,
		   vcodisaprel3_2,
		   vcodintel3_2,
		   vbonif_bccl3_2,
		   vcopagol3_2+vcreditol3_2,
		   vTipCob3_2,
		   vTipCobS3_2
		);

	 END;

	 IF NVL(vbonif_bccl3_2,0) > 0 THEN

	     IF v_nMTO_BON_SEG > 0 THEN
		 v_vTIBE_CODIGO := 'SEGU';
		 BEGIN
		    ADMBENE.PCK_DET_COB_BENEFICIOS.P_INSERT_DET_COB_BEN (
			      v_nID_DETCOB,				--pio_nID_DETCOB	IN OUT NUMBER,
			      v_nBEN_D_ORS_AT_SEQ,			--pi_nDBENE_ID_DET	IN NUMBER,
			      v_vTIBE_CODIGO,				--pi_vTIBE_CODIGO	IN VARCHAR2,
			      in_extfoliofinanciador,			--pi_nNUMERO_BONO	IN NUMBER,
			      v_nMTO_BON_SEG,				--pi_nMONTO_BONIFICADO	IN NUMBER,
			      vTipCobS3_2,				--pi_vTCOBER_COD	IN VARCHAR2,
			      v_error					--po_vDESC_ERROR	OUT VARCHAR2
		    );

		 exception
		 When others then
		    v_error:= 'Error al Insertar Det. Segu.';
		 END;
	     END IF;

	     IF NOT v_error IS NULL THEN
		out_extcoderror       := 'N';
		out_extmensajeerror   := v_error;
		ROLLBACK;
		RAISE E_SALIR;
	     END IF;

	     IF v_nMTO_BON_BCC > 0 THEN
		 v_vTIBE_CODIGO := 'BCC';
		 BEGIN
		    ADMBENE.PCK_DET_COB_BENEFICIOS.P_INSERT_DET_COB_BEN (
			      v_nID_DETCOB,				--pio_nID_DETCOB	IN OUT NUMBER,
			      v_nBEN_D_ORS_AT_SEQ,			--pi_nDBENE_ID_DET	IN NUMBER,
			      v_vTIBE_CODIGO,				--pi_vTIBE_CODIGO	IN VARCHAR2,
			      in_extfoliofinanciador,			--pi_nNUMERO_BONO	IN NUMBER,
			      v_nMTO_BON_BCC,				--pi_nMONTO_BONIFICADO	IN NUMBER,
			      vTipCobS3_2,				--pi_vTCOBER_COD	IN VARCHAR2,
			      v_error					--po_vDESC_ERROR	OUT VARCHAR2
		    );

		 exception
		 When others then
		    v_error:= 'Error al Insertar Det. Bcc.';
		 END;
	     END IF;


	     IF NOT v_error IS NULL THEN
		out_extcoderror       := 'N';
		out_extmensajeerror   := v_error;
		ROLLBACK;
		RAISE E_SALIR;
	     END IF;

	 END IF;

	 v_total	    := v_total + vtotall3_2;
	 v_cantidad	    := v_cantidad + vcantidadl3_2;
	 v_totalbonif	    := v_totalbonif + vbonifl3_2;
	 v_totalbonif_bcc   := v_totalbonif_bcc + vbonif_bccl3_2;
	 v_totalcopago	    := v_totalcopago + vcopagol3_2;
	 v_totalcredito     := v_totalcredito + vcreditol3_2;
	 v_totalexcedente   := v_totalexcedente + vexcedentel3_2;
	 v_totalayuda	    := v_totalayuda + vayuasistl3_2;
	 v_totalseguroc     := v_totalseguroc + vsegcompll3_2;

	 if tipo_cobertura is null then
	     tipo_cobertura	:= vTipCob3_2;
	 end if;
	 if tipo_coberturaS is null then
	     tipo_coberturaS	:= vTipCobS3_2;
	 end if;

      END IF;

      -- Actualizo topes Plan
      ADMBENE.BEN_ACTUALIZA_TOPES_FINAL12 (miarreglo,
					   v_idafil,
					   v_corr,
					   v_fec_ini_acu,
					   NULL,
					   v_error
      );

      -- Actualizo topes Seguro
      ADMBENE.BEN_ACTUALIZA_TOPES_FINAL_SEGU(miarregloS,
					     v_idafil,
					     v_corr,
					     v_fec_ini_acu,
					     NULL,
					     v_error
      );

      IF NOT v_error IS NULL
      THEN
	 out_extcoderror       := 'N';
	 out_extmensajeerror   := 'Error Actualizando Topes';
	 ROLLBACK;
	 RAISE E_SALIR;
      END IF;

      /* esto porque no hemos descontado en el valorlista2 el excedente pues no es parametro*/
      v_totalcopago	    := v_totalcopago - v_totalexcedente;

      IF v_totalcredito > 0 THEN
	 IF (v_totalcopago - v_totalexcedente) > 0
	 THEN
	    v_codpago	:= 'CP5';
	 ELSE
	    v_codpago	:= 'CP1';
	 END IF;
      ELSE
	 v_codpago   := 'CP2';
      END IF;

      -------------------------------------------------------------------------
      -------------------------------------------------------------------------
      v_codpago   := 'CP2';


      IF v_totalcredito > 0 and in_extcodfinanciador = 65 THEN

	  --v_totalbonif_bcc := v_totalbonif_bcc-v_totalcredito;
	  Tipo_pago_venta := 'DPP';

	  -- Actualizacion final de BEN_BENEFICIO
	  UPDATE admbene.ben_beneficio
	  SET excedente 	= v_totalexcedente,
	      val_ayuasist	= v_totalayuda,
	      val_total 	= v_total,
	      val_bon		= v_totalbonif - v_totalbonif_bcc - v_totalcredito , --v_totalboniffarmacia , caob 07/01/2005
	      /*
	      Modificado el 22/07/2014 en Proyecto XXX a Solictud de Gonzalo Caro.
	      * Copago = Total - Bonif Plan
	      * Copago Final = Total- Bonif PLan - Bonif BCC - excedente
	      * Valor = Copago
	      -- Asignaciones Anteriores
	      val_copago	= v_totalcopago + v_totalbonif_bcc + v_totalcredito,
	      valor		= v_total,
	      VAL_COPAGO_FINAL	= v_totalcopago + v_totalcredito,
	      -- Asignaciones Nuevas */
	      VAL_COPAGO	= v_total - (v_totalbonif - v_totalbonif_bcc - v_totalcredito),
	      VALOR		= v_total - (v_totalbonif - v_totalbonif_bcc - v_totalcredito),
	      VAL_COPAGO_FINAL	= v_total - (v_totalbonif - v_totalbonif_bcc - v_totalcredito)-v_totalexcedente-v_totalbonif_bcc,
	      /*
	      Fin Modificacion
	      */
	      credito		= 0,--v_totalcredito,
	      monto_cred_nbon	= 0,
	      cvdo_id_domi	= v_exthomlugarconvenio,--in_exthomlugarconvenio,
	      cvsp_cvst_rut	= vrutstaff,
	      --TIPO_CREDITO = v_tipocredito,
	      btc_cod_pago	= v_codpago,
	      VAL_BCC		= v_totalbonif_bcc,
	      TCOBER		= tipo_cobertura,
	      TCOBER_SEG	= tipo_coberturaS,
	      TIPO_PAGO 	= Tipo_pago_venta
	  WHERE num = in_extfoliofinanciador;
	  v_totalcredito   := 0;
      ELSE

	  IF in_extcodfinanciador <> 65 THEN
	    v_totalcredito   := 0;
	  END IF;

	  -- Actualizacion final de BEN_BENEFICIO
	  UPDATE admbene.ben_beneficio
	  SET excedente 	= v_totalexcedente,
	      val_ayuasist	= v_totalayuda,
	      val_total 	= v_total,
	      val_bon		= v_totalbonif - v_totalbonif_bcc  , --v_totalboniffarmacia , caob 07/01/2005
	      /*
	      Modificado el 22/07/2014 en Proyecto XXX a Solictud de Gonzalo Caro.
	      * Copago = Total - Bonif Plan
	      * Copago Final = Total- Bonif PLan - Bonif BCC - excedente
	      * Valor = Copago
	      -- Asignaciones Anteriores
	      val_copago	= v_totalcopago + v_totalbonif_bcc,
	      valor		= v_total,
	      VAL_COPAGO_FINAL	= v_totalcopago,
	      -- Asignaciones Nuevas */
	      VAL_COPAGO	= v_total - (v_totalbonif - v_totalbonif_bcc ),
	      VALOR		= v_total - (v_totalbonif - v_totalbonif_bcc ),
	      VAL_COPAGO_FINAL	= v_total - (v_totalbonif - v_totalbonif_bcc )-v_totalexcedente-v_totalbonif_bcc,
	      /*
	      Fin Modificacion
	      */
	      credito		= v_totalcredito,
	      monto_cred_nbon	= 0,
	      cvdo_id_domi	= v_exthomlugarconvenio,--in_exthomlugarconvenio,
	      cvsp_cvst_rut	= vrutstaff,
	      --TIPO_CREDITO = v_tipocredito,
	      btc_cod_pago	= v_codpago,
	      VAL_BCC		= v_totalbonif_bcc,
	      TCOBER		= tipo_cobertura,
	      TCOBER_SEG	= tipo_coberturaS,
	      TIPO_PAGO 	= Tipo_pago_venta
	  WHERE num = in_extfoliofinanciador;
      END IF;


      /**********************************************************************************/
      /* MOVIMIENTO A LA CUENTA DE EXCEDENTES						*/
      /**********************************************************************************/
      IF v_totalexcedente > 0
      THEN
	 admbene.ben_f_uso_excedentes (v_totalexcedente, --p_monto     IN NUMBER,
				       v_idafil,      --p_id_afi    IN NUMBER,
				       in_extfoliofinanciador, --p_num_orden in number,
				       v_error	 --p_error     in out varchar2
	 );

	 IF NOT v_error IS NULL
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Error Cargo Excedentes';
	    DBMS_OUTPUT.put_line ('Error Excedentes:' || v_error);
	    ROLLBACK;
	    RAISE E_SALIR;
	 END IF;
      END IF;

      /**********************************************************************************/
      /* MOVIMIENTO A LA CUENTA DE CREDITO AUTOMATICO					*/
      /**********************************************************************************/
      IF v_totalcredito > 0
      THEN
	 BEGIN
	    SELECT crcc_id
	    INTO v_codmov
	    FROM admcred.cre_cta_ctbe
	    WHERE crcc_crtm_cod = 'CEIM' AND crcc_estado = 'VI';
	 EXCEPTION
	    WHEN NO_DATA_FOUND
	    THEN
	       out_extcoderror	     := 'N';
	       out_extmensajeerror   := 'Error Cargo Credito(1)';
	       RAISE E_SALIR;
	    WHEN OTHERS
	    THEN
	       out_extcoderror	     := 'N';
	       out_extmensajeerror   := 'Error Cargo Credito(2)';
	       RAISE E_SALIR;
	 END;
      DBMS_OUTPUT.PUT_LINE ( 'v_nPASO 1.9 ' );

	 res   :=
	    admbene.ben_f_existe_cta_cred_cob (v_idafil,
					       v_saldo,
					       v_titcta,
					       v_error
	    );

      DBMS_OUTPUT.PUT_LINE ( 'v_nPASO 2 ' );

	 SELECT crca_fec_act
	 INTO v_fecact
	 FROM admcred.cre_cta_caut
	 WHERE	   crca_afil_id_afi = v_titcta
	       AND crca_estado IN ('VIGE', 'MORO', 'BLOQ')
	       AND crca_fec_act IN (SELECT MAX (crca_fec_act)
				    FROM admcred.cre_cta_caut
				    WHERE crca_afil_id_afi = v_titcta);

      DBMS_OUTPUT.PUT_LINE ( 'v_nPASO 3 ' );
	 admimed.imed_ins_mov (v_codmov,		      -- ID Movimiento
			       v_titcta,			-- ID Afiliado
			       v_fecact,
			       -- Fecha Activacion Cuenta Credito/Fecha Inicio Cuenta Prohibicion/Cuenta Empleador en Convenio copago
			       v_corr, -- Correlativo Carga Cuenta Prohibicion
			       v_secctades, -- Secuencia Cuenta Desahucio/Prohibicion
			       NULL, -- ID empleador Cuenta Empleador en Convenio copago
			       v_totalcredito,			      -- Monto
			       in_extfoliofinanciador,	   -- Numero documento
			       'BENEFICIOS',		     -- Sistema Origen
			       '',				  -- Empleador
			       NULL,		       -- Folio regularizacion
			       NULL, -- Secuencia Mov. para Cta Empleador en Convenio copago
			       NULL,		       -- parametro uso futuro
			       v_error
	 );				  -- retorna codigo y mensaje de error

	 IF NOT v_error IS NULL
	 THEN
	    out_extcoderror	  := 'N';
	    out_extmensajeerror   := 'Error Cargo Credito(3)';
	    DBMS_OUTPUT.put_line ('Error Cargo:' || v_error);
	    ROLLBACK;
	    RAISE E_SALIR;
	 END IF;
      END IF;

      -- Actualizo folio como ya utilizado
      UPDATE admimed.imed_folios
      SET estado = 'U', fecha_respuesta = SYSDATE
      WHERE folio = in_extfoliofinanciador;

      out_extcoderror	    := 'S';
      out_extmensajeerror   := ' ';


      vv_PARAMETROS_SALIDA:= out_extcoderror||';'||Out_extMensajeError||';';
      UPDATE ADMIMED.IMED_AUDITORIA
      Set LUGAR_CONVENIO_MOD = v_exthomlugarconvenio,
	  RUT_COTIZ = Null,
	  ID_AFI = v_idafil,
	  CODIGO_CARGA = v_corr,
	  NRO_BONO_ISAPRE = in_extfoliofinanciador,
	  MONTO_TOTAL_BONO = in_extmontovalortotal,
	  --PREST_TOTALES_BONO = in_extnumprestaciones,
	  MONTO_ISAPRE_BONO = in_extmontoaportetotal,
	  MONTO_COPAGO_BONO = in_extmontocopagototal,
	  DATOS_SALIDA = vv_PARAMETROS_SALIDA,
	  FEC_HOR_SALIDA = SYSDATE,
	  SEGUNDOS_RESP = trunc((SYSDATE-FEC_HOR_LLEGADA)*24*60*60)
      Where CORRELATIVO = v_nIMED_AUDI_SEQ
      ;
      COMMIT;
   EXCEPTION
      WHEN E_SALIR	THEN

	 vv_PARAMETROS_SALIDA:= out_extcoderror||';'||Out_extMensajeError||';';
	 UPDATE ADMIMED.IMED_AUDITORIA
	 Set LUGAR_CONVENIO_MOD = v_exthomlugarconvenio,
	    RUT_COTIZ = Null,
	  ID_AFI = v_idafil,
	  CODIGO_CARGA = v_corr,
	  NRO_BONO_ISAPRE = in_extfoliofinanciador,
	  MONTO_TOTAL_BONO = in_extmontovalortotal,
	  --PREST_TOTALES_BONO = in_extnumprestaciones,
	  MONTO_ISAPRE_BONO = in_extmontoaportetotal,
	  MONTO_COPAGO_BONO = in_extmontocopagototal,
	  DATOS_SALIDA = vv_PARAMETROS_SALIDA,
	  FEC_HOR_SALIDA = SYSDATE,
	  SEGUNDOS_RESP = trunc((SYSDATE-FEC_HOR_LLEGADA)*24*60*60)
	 Where CORRELATIVO = v_nIMED_AUDI_SEQ
	 ;
	 COMMIT;

      WHEN OTHERS      THEN
	 out_extcoderror       := 'N';
	 out_extmensajeerror   := '5:' || SUBSTR (SQLERRM, 1, 27);
	 --'Error en Procedimiento Inf.';
	 ROLLBACK;

	 vv_PARAMETROS_SALIDA:= out_extcoderror||';'||Out_extMensajeError||';';
	 UPDATE ADMIMED.IMED_AUDITORIA
	 Set LUGAR_CONVENIO_MOD = v_exthomlugarconvenio,
	    RUT_COTIZ = Null,
	  ID_AFI = v_idafil,
	  CODIGO_CARGA = v_corr,
	  NRO_BONO_ISAPRE = in_extfoliofinanciador,
	  MONTO_TOTAL_BONO = in_extmontovalortotal,
	  --PREST_TOTALES_BONO = in_extnumprestaciones,
	  MONTO_ISAPRE_BONO = in_extmontoaportetotal,
	  MONTO_COPAGO_BONO = in_extmontocopagototal,
	  DATOS_SALIDA = vv_PARAMETROS_SALIDA,
	  FEC_HOR_SALIDA = SYSDATE,
	  SEGUNDOS_RESP = trunc((SYSDATE-FEC_HOR_LLEGADA)*24*60*60)
	 Where CORRELATIVO = v_nIMED_AUDI_SEQ
	 ;
	 COMMIT;

   END fusenvbonis;



   PROCEDURE SNLenvbonis (srv_message IN OUT varchar2,
			  in_extcodfinanciador IN number,
			  in_exthomnumeroconvenio IN varchar2,
			  in_exthomlugarconvenio IN varchar2,
			  in_extsucventa IN varchar2,
			  in_extrutconvenio IN varchar2,
			  in_extrutasociado IN varchar2,
			  in_extnomprestador IN varchar2,
			  in_extruttratante IN varchar2,
			  in_extespecialidad IN varchar2,
			  in_extrutbeneficiario IN varchar2,
			  in_extrutcotizante IN varchar2,
			  in_extrutacompanante IN varchar2,
			  in_extrutemisor IN varchar2,
			  in_extrutcajero IN varchar2,
			  in_extcodigodiagnostico IN varchar2,
			  in_extdescuentoxplanilla IN varchar2,
			  in_extmontoexcedente IN number,
			  in_extfechaemision IN varchar2,
			  in_extnivelconvenio IN number,
			  in_extfoliofinanciador IN number,
			  in_extmontovalortotal IN number,
			  in_extmontoaportetotal IN number,
			  in_extmontocopagototal IN number,
			  in_extnumoperacion IN number,
			  in_extcorrprestacion IN number,
			  in_exttiposolicitud IN number,
			  in_extfechainicio IN varchar2,
			  in_exturgencia IN varchar2,
			  in_extplan IN varchar2,
			  in_extlista1 IN varchar2,
			  in_extlista2 IN varchar2,
			  in_extlista3 IN varchar2,
			  out_extcoderror OUT varchar2,
			  out_extmensajeerror OUT varchar2
   )
   AS

    BEGIN
	     FUSenvbonis (srv_message,
			  in_extcodfinanciador,
			  in_exthomnumeroconvenio,
			  in_exthomlugarconvenio,
			  in_extsucventa,
			  in_extrutconvenio,
			  in_extrutasociado,
			  in_extnomprestador,
			  in_extruttratante,
			  in_extespecialidad,
			  in_extrutbeneficiario,
			  in_extrutcotizante,
			  in_extrutacompanante,
			  in_extrutemisor,
			  in_extrutcajero,
			  in_extcodigodiagnostico,
			  in_extdescuentoxplanilla,
			  in_extmontoexcedente,
			  in_extfechaemision,
			  in_extnivelconvenio,
			  in_extfoliofinanciador,
			  in_extmontovalortotal,
			  in_extmontoaportetotal,
			  in_extmontocopagototal,
			  in_extnumoperacion,
			  in_extcorrprestacion,
			  in_exttiposolicitud,
			  in_extfechainicio,
			  in_exturgencia,
			  in_extplan,
			  in_extlista1,
			  in_extlista2,
			  in_extlista3,
			  out_extcoderror,
			  out_extmensajeerror);
    END SNLenvbonis;
   PROCEDURE RBLenvbonis (srv_message IN OUT varchar2,
			  in_extcodfinanciador IN number,
			  in_exthomnumeroconvenio IN varchar2,
			  in_exthomlugarconvenio IN varchar2,
			  in_extsucventa IN varchar2,
			  in_extrutconvenio IN varchar2,
			  in_extrutasociado IN varchar2,
			  in_extnomprestador IN varchar2,
			  in_extruttratante IN varchar2,
			  in_extespecialidad IN varchar2,
			  in_extrutbeneficiario IN varchar2,
			  in_extrutcotizante IN varchar2,
			  in_extrutacompanante IN varchar2,
			  in_extrutemisor IN varchar2,
			  in_extrutcajero IN varchar2,
			  in_extcodigodiagnostico IN varchar2,
			  in_extdescuentoxplanilla IN varchar2,
			  in_extmontoexcedente IN number,
			  in_extfechaemision IN varchar2,
			  in_extnivelconvenio IN number,
			  in_extfoliofinanciador IN number,
			  in_extmontovalortotal IN number,
			  in_extmontoaportetotal IN number,
			  in_extmontocopagototal IN number,
			  in_extnumoperacion IN number,
			  in_extcorrprestacion IN number,
			  in_exttiposolicitud IN number,
			  in_extfechainicio IN varchar2,
			  in_exturgencia IN varchar2,
			  in_extplan IN varchar2,
			  in_extlista1 IN varchar2,
			  in_extlista2 IN varchar2,
			  in_extlista3 IN varchar2,
			  out_extcoderror OUT varchar2,
			  out_extmensajeerror OUT varchar2
   )
   AS

    BEGIN
	     FUSenvbonis (srv_message,
			  in_extcodfinanciador,
			  in_exthomnumeroconvenio,
			  in_exthomlugarconvenio,
			  in_extsucventa,
			  in_extrutconvenio,
			  in_extrutasociado,
			  in_extnomprestador,
			  in_extruttratante,
			  in_extespecialidad,
			  in_extrutbeneficiario,
			  in_extrutcotizante,
			  in_extrutacompanante,
			  in_extrutemisor,
			  in_extrutcajero,
			  in_extcodigodiagnostico,
			  in_extdescuentoxplanilla,
			  in_extmontoexcedente,
			  in_extfechaemision,
			  in_extnivelconvenio,
			  in_extfoliofinanciador,
			  in_extmontovalortotal,
			  in_extmontoaportetotal,
			  in_extmontocopagototal,
			  in_extnumoperacion,
			  in_extcorrprestacion,
			  in_exttiposolicitud,
			  in_extfechainicio,
			  in_exturgencia,
			  in_extplan,
			  in_extlista1,
			  in_extlista2,
			  in_extlista3,
			  out_extcoderror,
			  out_extmensajeerror);
    END RBLenvbonis;


PROCEDURE CHUenvbonis (srv_message IN OUT varchar2,
			  in_extcodfinanciador IN number,
			  in_exthomnumeroconvenio IN varchar2,

TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			  in_exthomlugarconvenio IN varchar2,
			  in_extsucventa IN varchar2,
			  in_extrutconvenio IN varchar2,
			  in_extrutasociado IN varchar2,
			  in_extnomprestador IN varchar2,
			  in_extruttratante IN varchar2,
			  in_extespecialidad IN varchar2,
			  in_extrutbeneficiario IN varchar2,
			  in_extrutcotizante IN varchar2,
			  in_extrutacompanante IN varchar2,
			  in_extrutemisor IN varchar2,
			  in_extrutcajero IN varchar2,
			  in_extcodigodiagnostico IN varchar2,
			  in_extdescuentoxplanilla IN varchar2,
			  in_extmontoexcedente IN number,
			  in_extfechaemision IN varchar2,
			  in_extnivelconvenio IN number,
			  in_extfoliofinanciador IN number,
			  in_extmontovalortotal IN number,
			  in_extmontoaportetotal IN number,
			  in_extmontocopagototal IN number,
			  in_extnumoperacion IN number,
			  in_extcorrprestacion IN number,
			  in_exttiposolicitud IN number,
			  in_extfechainicio IN varchar2,
			  in_exturgencia IN varchar2,
			  in_extplan IN varchar2,
			  in_extlista1 IN varchar2,
			  in_extlista2 IN varchar2,
			  in_extlista3 IN varchar2,
			  out_extcoderror OUT varchar2,
			  out_extmensajeerror OUT varchar2
   )
   AS

    BEGIN
	     FUSenvbonis (srv_message,
			  in_extcodfinanciador,
			  in_exthomnumeroconvenio,
			  in_exthomlugarconvenio,
			  in_extsucventa,
			  in_extrutconvenio,
			  in_extrutasociado,
			  in_extnomprestador,
			  in_extruttratante,
			  in_extespecialidad,
			  in_extrutbeneficiario,
			  in_extrutcotizante,
			  in_extrutacompanante,
			  in_extrutemisor,
			  in_extrutcajero,
			  in_extcodigodiagnostico,
			  in_extdescuentoxplanilla,
			  in_extmontoexcedente,
			  in_extfechaemision,
			  in_extnivelconvenio,
			  in_extfoliofinanciador,
			  in_extmontovalortotal,
			  in_extmontoaportetotal,
			  in_extmontocopagototal,
			  in_extnumoperacion,
			  in_extcorrprestacion,
			  in_exttiposolicitud,
			  in_extfechainicio,
			  in_exturgencia,
			  in_extplan,
			  in_extlista1,
			  in_extlista2,
			  in_extlista3,
			  out_extcoderror,
			  out_extmensajeerror);
    END CHUenvbonis;

END FUSEnvBonIs_Pkg;

3062 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.5.0 - 64bit Production
