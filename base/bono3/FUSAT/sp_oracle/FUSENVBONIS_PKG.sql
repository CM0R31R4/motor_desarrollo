
SQL*Plus: Release 11.2.0.3.0 Production on Mon Aug 3 16:47:46 2015

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
ERROR:
ORA-12152: TNS:unable to send break message



135 rows selected.


SQL> Disconnected from Oracle Database 10g Release 10.2.0.5.0 - 64bit Production
