
SQL*Plus: Release 11.2.0.3.0 Production on Tue Aug 4 11:31:16 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.5.0 - 64bit Production

SQL> SQL> PROCEDURE CHUVALORVARI
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTHOMNUMEROCONVENIO	VARCHAR2		IN
 IN_EXTHOMLUGARCONVENIO 	VARCHAR2		IN
 IN_EXTSUCVENTA 		VARCHAR2		IN
 IN_EXTRUTCONVENIO		VARCHAR2		IN
 IN_EXTRUTTRATANTE		VARCHAR2		IN
 IN_EXTESPECIALIDAD		VARCHAR2		IN
 IN_EXTRUTSOLICITANTE		VARCHAR2		IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 IN_EXTTRATAMIENTO		VARCHAR2		IN
 IN_EXTCODIGODIAGNOSTICO	VARCHAR2		IN
 IN_EXTNIVELCONVENIO		NUMBER			IN
 IN_EXTURGENCIA 		VARCHAR2		IN
 IN_EXTLISTA1			VARCHAR2		IN
 IN_EXTLISTA2			VARCHAR2		IN
 IN_EXTLISTA3			VARCHAR2		IN
 IN_EXTLISTA4			VARCHAR2		IN
 IN_EXTLISTA5			VARCHAR2		IN
 IN_EXTLISTA6			VARCHAR2		IN
 IN_EXTLISTA7			VARCHAR2		IN
 IN_EXTNUMPRESTACIONES		NUMBER			IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 OUT_EXTPLAN			VARCHAR2		OUT
 OUT_EXTGLOSA1			VARCHAR2		OUT
 OUT_EXTGLOSA2			VARCHAR2		OUT
 OUT_EXTGLOSA3			VARCHAR2		OUT
 OUT_EXTGLOSA4			VARCHAR2		OUT
 OUT_EXTGLOSA5			VARCHAR2		OUT
 OUT_EXTVALORPRESTACION 	TABLE OF NUMBER(12)	OUT
 OUT_EXTAPORTEFINANCIADOR	TABLE OF NUMBER(12)	OUT
 OUT_EXTCOPAGO			TABLE OF NUMBER(12)	OUT
 OUT_EXTINTERNOISA		TABLE OF VARCHAR2(15)	OUT
 OUT_EXTTIPOBONIF1		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO1 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF2		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO2 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF3		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO3 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF4		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO4 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF5		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO5 		TABLE OF NUMBER(12)	OUT
PROCEDURE FUSVALORVARI
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTHOMNUMEROCONVENIO	VARCHAR2		IN
 IN_EXTHOMLUGARCONVENIO 	VARCHAR2		IN
 IN_EXTSUCVENTA 		VARCHAR2		IN
 IN_EXTRUTCONVENIO		VARCHAR2		IN
 IN_EXTRUTTRATANTE		VARCHAR2		IN
 IN_EXTESPECIALIDAD		VARCHAR2		IN
 IN_EXTRUTSOLICITANTE		VARCHAR2		IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 IN_EXTTRATAMIENTO		VARCHAR2		IN
 IN_EXTCODIGODIAGNOSTICO	VARCHAR2		IN
 IN_EXTNIVELCONVENIO		NUMBER			IN
 IN_EXTURGENCIA 		VARCHAR2		IN
 IN_EXTLISTA1			VARCHAR2		IN
 IN_EXTLISTA2			VARCHAR2		IN
 IN_EXTLISTA3			VARCHAR2		IN
 IN_EXTLISTA4			VARCHAR2		IN
 IN_EXTLISTA5			VARCHAR2		IN
 IN_EXTLISTA6			VARCHAR2		IN
 IN_EXTLISTA7			VARCHAR2		IN
 IN_EXTNUMPRESTACIONES		NUMBER			IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 OUT_EXTPLAN			VARCHAR2		OUT
 OUT_EXTGLOSA1			VARCHAR2		OUT
 OUT_EXTGLOSA2			VARCHAR2		OUT
 OUT_EXTGLOSA3			VARCHAR2		OUT
 OUT_EXTGLOSA4			VARCHAR2		OUT
 OUT_EXTGLOSA5			VARCHAR2		OUT
 OUT_EXTVALORPRESTACION 	TABLE OF NUMBER(12)	OUT
 OUT_EXTAPORTEFINANCIADOR	TABLE OF NUMBER(12)	OUT
 OUT_EXTCOPAGO			TABLE OF NUMBER(12)	OUT
 OUT_EXTINTERNOISA		TABLE OF VARCHAR2(15)	OUT
 OUT_EXTTIPOBONIF1		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO1 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF2		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO2 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF3		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO3 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF4		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO4 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF5		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO5 		TABLE OF NUMBER(12)	OUT
PROCEDURE RBLVALORVARI
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTHOMNUMEROCONVENIO	VARCHAR2		IN
 IN_EXTHOMLUGARCONVENIO 	VARCHAR2		IN
 IN_EXTSUCVENTA 		VARCHAR2		IN
 IN_EXTRUTCONVENIO		VARCHAR2		IN
 IN_EXTRUTTRATANTE		VARCHAR2		IN
 IN_EXTESPECIALIDAD		VARCHAR2		IN
 IN_EXTRUTSOLICITANTE		VARCHAR2		IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 IN_EXTTRATAMIENTO		VARCHAR2		IN
 IN_EXTCODIGODIAGNOSTICO	VARCHAR2		IN
 IN_EXTNIVELCONVENIO		NUMBER			IN
 IN_EXTURGENCIA 		VARCHAR2		IN
 IN_EXTLISTA1			VARCHAR2		IN
 IN_EXTLISTA2			VARCHAR2		IN
 IN_EXTLISTA3			VARCHAR2		IN
 IN_EXTLISTA4			VARCHAR2		IN
 IN_EXTLISTA5			VARCHAR2		IN
 IN_EXTLISTA6			VARCHAR2		IN
 IN_EXTLISTA7			VARCHAR2		IN
 IN_EXTNUMPRESTACIONES		NUMBER			IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 OUT_EXTPLAN			VARCHAR2		OUT
 OUT_EXTGLOSA1			VARCHAR2		OUT
 OUT_EXTGLOSA2			VARCHAR2		OUT
 OUT_EXTGLOSA3			VARCHAR2		OUT
 OUT_EXTGLOSA4			VARCHAR2		OUT
 OUT_EXTGLOSA5			VARCHAR2		OUT
 OUT_EXTVALORPRESTACION 	TABLE OF NUMBER(12)	OUT
 OUT_EXTAPORTEFINANCIADOR	TABLE OF NUMBER(12)	OUT
 OUT_EXTCOPAGO			TABLE OF NUMBER(12)	OUT
 OUT_EXTINTERNOISA		TABLE OF VARCHAR2(15)	OUT
 OUT_EXTTIPOBONIF1		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO1 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF2		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO2 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF3		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO3 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF4		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO4 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF5		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO5 		TABLE OF NUMBER(12)	OUT
PROCEDURE SNLVALORVARI
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTHOMNUMEROCONVENIO	VARCHAR2		IN
 IN_EXTHOMLUGARCONVENIO 	VARCHAR2		IN
 IN_EXTSUCVENTA 		VARCHAR2		IN
 IN_EXTRUTCONVENIO		VARCHAR2		IN
 IN_EXTRUTTRATANTE		VARCHAR2		IN
 IN_EXTESPECIALIDAD		VARCHAR2		IN
 IN_EXTRUTSOLICITANTE		VARCHAR2		IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 IN_EXTTRATAMIENTO		VARCHAR2		IN
 IN_EXTCODIGODIAGNOSTICO	VARCHAR2		IN
 IN_EXTNIVELCONVENIO		NUMBER			IN
 IN_EXTURGENCIA 		VARCHAR2		IN
 IN_EXTLISTA1			VARCHAR2		IN
 IN_EXTLISTA2			VARCHAR2		IN
 IN_EXTLISTA3			VARCHAR2		IN
 IN_EXTLISTA4			VARCHAR2		IN
 IN_EXTLISTA5			VARCHAR2		IN
 IN_EXTLISTA6			VARCHAR2		IN
 IN_EXTLISTA7			VARCHAR2		IN
 IN_EXTNUMPRESTACIONES		NUMBER			IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 OUT_EXTPLAN			VARCHAR2		OUT
 OUT_EXTGLOSA1			VARCHAR2		OUT
 OUT_EXTGLOSA2			VARCHAR2		OUT
 OUT_EXTGLOSA3			VARCHAR2		OUT
 OUT_EXTGLOSA4			VARCHAR2		OUT
 OUT_EXTGLOSA5			VARCHAR2		OUT
 OUT_EXTVALORPRESTACION 	TABLE OF NUMBER(12)	OUT
 OUT_EXTAPORTEFINANCIADOR	TABLE OF NUMBER(12)	OUT
 OUT_EXTCOPAGO			TABLE OF NUMBER(12)	OUT
 OUT_EXTINTERNOISA		TABLE OF VARCHAR2(15)	OUT
 OUT_EXTTIPOBONIF1		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO1 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF2		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO2 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF3		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO3 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF4		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO4 		TABLE OF NUMBER(12)	OUT
 OUT_EXTTIPOBONIF5		TABLE OF NUMBER(1)	OUT
 OUT_EXTCOPAGO5 		TABLE OF NUMBER(12)	OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	FUSValorVari_Pkg As
  TYPE extValorPrestacion_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;
  TYPE extAporteFinanciador_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;
  TYPE extCopago_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;
  TYPE extInternoIsa_arr IS TABLE OF Varchar2(15)
    INDEX BY BINARY_INTEGER;
  TYPE extTipoBonif1_arr IS TABLE OF Number(1)
    INDEX BY BINARY_INTEGER;
  TYPE extCopago1_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;
  TYPE extTipoBonif2_arr IS TABLE OF Number(1)
    INDEX BY BINARY_INTEGER;
  TYPE extCopago2_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;
  TYPE extTipoBonif3_arr IS TABLE OF Number(1)
    INDEX BY BINARY_INTEGER;
  TYPE extCopago3_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;
  TYPE extTipoBonif4_arr IS TABLE OF Number(1)
    INDEX BY BINARY_INTEGER;
  TYPE extCopago4_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;
  TYPE extTipoBonif5_arr IS TABLE OF Number(1)
    INDEX BY BINARY_INTEGER;
  TYPE extCopago5_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;

Procedure FUSValorVari
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador	     In 	Number
    , In_extHomNumeroConvenio	     In 	Varchar2
    , In_extHomLugarConvenio	     In 	Varchar2
    , In_extSucVenta		     In 	Varchar2
    , In_extRutConvenio 	     In 	Varchar2
    , In_extRutTratante 	     In 	Varchar2
    , In_extEspecialidad	     In 	Varchar2
    , In_extRutSolicitante	     In 	Varchar2
    , In_extRutBeneficiario	     In 	Varchar2
    , In_extTratamiento 	     In 	Varchar2
    , In_extCodigoDiagnostico	     In 	Varchar2
    , In_extNivelConvenio	     In 	Number
    , In_extUrgencia		     In 	Varchar2
    , In_extLista1		     In 	Varchar2
    , In_extLista2		     In 	Varchar2
    , In_extLista3		     In 	Varchar2
    , In_extLista4		     In 	Varchar2
    , In_extLista5		     In 	Varchar2
    , In_extLista6		     In 	Varchar2
    , In_extLista7		     In 	Varchar2
    , In_extNumPrestaciones	     In 	Number
    , Out_extCodError		     Out	Varchar2
    , Out_extMensajeError	     Out	Varchar2
    , Out_extPlan		     Out	Varchar2
    , Out_extGlosa1		     Out	Varchar2
    , Out_extGlosa2		     Out	Varchar2
    , Out_extGlosa3		     Out	Varchar2
    , Out_extGlosa4		     Out	Varchar2
    , Out_extGlosa5		     Out	Varchar2,
     Out_extValorPrestacion   Out extValorPrestacion_arr,
   Out_extAporteFinanciador Out extAporteFinanciador_arr,
   Out_extCopago	    Out extCopago_arr,
   Out_extInternoIsa	    Out extInternoIsa_arr,
   Out_extTipoBonif1	    Out exttipoBonif1_arr,
   Out_extCopago1	    Out extCopago1_arr,
   Out_extTipoBonif2	    Out exttipoBonif2_arr,
   Out_extCopago2	    Out extCopago2_arr,
   Out_extTipoBonif3	    Out exttipoBonif3_arr,
   Out_extCopago3	    Out extCopago3_arr,
   Out_extTipoBonif4	    Out exttipoBonif4_arr,
   Out_extCopago4	    Out extCopago4_arr,
   Out_extTipoBonif5	    Out exttipoBonif5_arr,
   Out_extCopago5	    Out extCopago5_arr
    );


Procedure SNLValorVari
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador	     In 	Number
    , In_extHomNumeroConvenio	     In 	Varchar2
    , In_extHomLugarConvenio	     In 	Varchar2
    , In_extSucVenta		     In 	Varchar2
    , In_extRutConvenio 	     In 	Varchar2
    , In_extRutTratante 	     In 	Varchar2
    , In_extEspecialidad	     In 	Varchar2
    , In_extRutSolicitante	     In 	Varchar2
    , In_extRutBeneficiario	     In 	Varchar2
    , In_extTratamiento 	     In 	Varchar2
    , In_extCodigoDiagnostico	     In 	Varchar2
    , In_extNivelConvenio	     In 	Number
    , In_extUrgencia		     In 	Varchar2
    , In_extLista1		     In 	Varchar2
    , In_extLista2		     In 	Varchar2
    , In_extLista3		     In 	Varchar2
    , In_extLista4		     In 	Varchar2
    , In_extLista5		     In 	Varchar2
    , In_extLista6		     In 	Varchar2
    , In_extLista7		     In 	Varchar2
    , In_extNumPrestaciones	     In 	Number
    , Out_extCodError		     Out	Varchar2
    , Out_extMensajeError	     Out	Varchar2
    , Out_extPlan		     Out	Varchar2
    , Out_extGlosa1		     Out	Varchar2
    , Out_extGlosa2		     Out	Varchar2
    , Out_extGlosa3		     Out	Varchar2
    , Out_extGlosa4		     Out	Varchar2
    , Out_extGlosa5		     Out	Varchar2,
     Out_extValorPrestacion   Out extValorPrestacion_arr,
   Out_extAporteFinanciador Out extAporteFinanciador_arr,
   Out_extCopago	    Out extCopago_arr,
   Out_extInternoIsa	    Out extInternoIsa_arr,
   Out_extTipoBonif1	    Out exttipoBonif1_arr,
   Out_extCopago1	    Out extCopago1_arr,
   Out_extTipoBonif2	    Out exttipoBonif2_arr,
   Out_extCopago2	    Out extCopago2_arr,
   Out_extTipoBonif3	    Out exttipoBonif3_arr,
   Out_extCopago3	    Out extCopago3_arr,
   Out_extTipoBonif4	    Out exttipoBonif4_arr,
   Out_extCopago4	    Out extCopago4_arr,
   Out_extTipoBonif5	    Out exttipoBonif5_arr,
   Out_extCopago5	    Out extCopago5_arr
    );
Procedure RBLValorVari
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador	     In 	Number
    , In_extHomNumeroConvenio	     In 	Varchar2
    , In_extHomLugarConvenio	     In 	Varchar2
    , In_extSucVenta		     In 	Varchar2
    , In_extRutConvenio 	     In 	Varchar2
    , In_extRutTratante 	     In 	Varchar2
    , In_extEspecialidad	     In 	Varchar2
    , In_extRutSolicitante	     In 	Varchar2
    , In_extRutBeneficiario	     In 	Varchar2
    , In_extTratamiento 	     In 	Varchar2
    , In_extCodigoDiagnostico	     In 	Varchar2
    , In_extNivelConvenio	     In 	Number
    , In_extUrgencia		     In 	Varchar2
    , In_extLista1		     In 	Varchar2
    , In_extLista2		     In 	Varchar2
    , In_extLista3		     In 	Varchar2
    , In_extLista4		     In 	Varchar2
    , In_extLista5		     In 	Varchar2
    , In_extLista6		     In 	Varchar2
    , In_extLista7		     In 	Varchar2
    , In_extNumPrestaciones	     In 	Number
    , Out_extCodError		     Out	Varchar2
    , Out_extMensajeError	     Out	Varchar2
    , Out_extPlan		     Out	Varchar2
    , Out_extGlosa1		     Out	Varchar2
    , Out_extGlosa2		     Out	Varchar2
    , Out_extGlosa3		     Out	Varchar2
    , Out_extGlosa4		     Out	Varchar2
    , Out_extGlosa5		     Out	Varchar2,
     Out_extValorPrestacion   Out extValorPrestacion_arr,
   Out_extAporteFinanciador Out extAporteFinanciador_arr,
   Out_extCopago	    Out extCopago_arr,
   Out_extInternoIsa	    Out extInternoIsa_arr,
   Out_extTipoBonif1	    Out exttipoBonif1_arr,
   Out_extCopago1	    Out extCopago1_arr,
   Out_extTipoBonif2	    Out exttipoBonif2_arr,
   Out_extCopago2	    Out extCopago2_arr,
   Out_extTipoBonif3	    Out exttipoBonif3_arr,
   Out_extCopago3	    Out extCopago3_arr,
   Out_extTipoBonif4	    Out exttipoBonif4_arr,
   Out_extCopago4	    Out extCopago4_arr,
   Out_extTipoBonif5	    Out exttipoBonif5_arr,
   Out_extCopago5	    Out extCopago5_arr
    );

Procedure CHUValorVari
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador	     In 	Number
    , In_extHomNumeroConvenio	     In 	Varchar2
    , In_extHomLugarConvenio	     In 	Varchar2
    , In_extSucVenta		     In 	Varchar2
    , In_extRutConvenio 	     In 	Varchar2
    , In_extRutTratante 	     In 	Varchar2
    , In_extEspecialidad	     In 	Varchar2
    , In_extRutSolicitante	     In 	Varchar2
    , In_extRutBeneficiario	     In 	Varchar2
    , In_extTratamiento 	     In 	Varchar2
    , In_extCodigoDiagnostico	     In 	Varchar2
    , In_extNivelConvenio	     In 	Number
    , In_extUrgencia		     In 	Varchar2
    , In_extLista1		     In 	Varchar2
    , In_extLista2		     In 	Varchar2
    , In_extLista3		     In 	Varchar2
    , In_extLista4		     In 	Varchar2
    , In_extLista5		     In 	Varchar2
    , In_extLista6		     In 	Varchar2
    , In_extLista7		     In 	Varchar2
    , In_extNumPrestaciones	     In 	Number
    , Out_extCodError		     Out	Varchar2
    , Out_extMensajeError	     Out	Varchar2
    , Out_extPlan		     Out	Varchar2
    , Out_extGlosa1		     Out	Varchar2
    , Out_extGlosa2		     Out	Varchar2
    , Out_extGlosa3		     Out	Varchar2
    , Out_extGlosa4		     Out	Varchar2
    , Out_extGlosa5		     Out	Varchar2,
     Out_extValorPrestacion   Out extValorPrestacion_arr,
   Out_extAporteFinanciador Out extAporteFinanciador_arr,
   Out_extCopago	    Out extCopago_arr,
   Out_extInternoIsa	    Out extInternoIsa_arr,
   Out_extTipoBonif1	    Out exttipoBonif1_arr,
   Out_extCopago1	    Out extCopago1_arr,
   Out_extTipoBonif2	    Out exttipoBonif2_arr,
   Out_extCopago2	    Out extCopago2_arr,
   Out_extTipoBonif3	    Out exttipoBonif3_arr,
   Out_extCopago3	    Out extCopago3_arr,
   Out_extTipoBonif4	    Out exttipoBonif4_arr,
   Out_extCopago4	    Out extCopago4_arr,
   Out_extTipoBonif5	    Out exttipoBonif5_arr,
   Out_extCopago5	    Out extCopago5_arr
    );

End FUSValorVari_Pkg;

219 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     FUSValorVari_Pkg
AS
   PROCEDURE fusvalorvari (
      srv_message		 IN OUT VARCHAR2,
      in_extcodfinanciador	 IN	NUMBER,
      in_exthomnumeroconvenio	 IN	VARCHAR2,
      in_exthomlugarconvenio	 IN	VARCHAR2,
      in_extsucventa		 IN	VARCHAR2,
      in_extrutconvenio 	 IN	VARCHAR2,
      in_extruttratante 	 IN	VARCHAR2,
      in_extespecialidad	 IN	VARCHAR2,
      in_extrutsolicitante	 IN	VARCHAR2,
      in_extrutbeneficiario	 IN	VARCHAR2,
      in_exttratamiento 	 IN	VARCHAR2,
      in_extcodigodiagnostico	 IN	VARCHAR2,
      in_extnivelconvenio	 IN	NUMBER,
      in_exturgencia		 IN	VARCHAR2,
      in_extlista1		 IN	VARCHAR2,
      in_extlista2		 IN	VARCHAR2,
      in_extlista3		 IN	VARCHAR2,
      in_extlista4		 IN	VARCHAR2,
      in_extlista5		 IN	VARCHAR2,
      in_extlista6		 IN	VARCHAR2,
      in_extlista7		 IN	VARCHAR2,
      in_extnumprestaciones	 IN	NUMBER,
      out_extcoderror		    OUT VARCHAR2,
      out_extmensajeerror	    OUT VARCHAR2,
      out_extplan		    OUT VARCHAR2,
      out_extglosa1		    OUT VARCHAR2,
      out_extglosa2		    OUT VARCHAR2,
      out_extglosa3		    OUT VARCHAR2,
      out_extglosa4		    OUT VARCHAR2,
      out_extglosa5		    OUT VARCHAR2,
      out_extvalorprestacion	    OUT extvalorprestacion_arr,
      out_extaportefinanciador	    OUT extaportefinanciador_arr,
      out_extcopago		    OUT extcopago_arr,
      out_extinternoisa 	    OUT extinternoisa_arr,
      out_exttipobonif1 	    OUT exttipobonif1_arr,
      out_extcopago1		    OUT extcopago1_arr,
      out_exttipobonif2 	    OUT exttipobonif2_arr,
      out_extcopago2		    OUT extcopago2_arr,
      out_exttipobonif3 	    OUT exttipobonif3_arr,
      out_extcopago3		    OUT extcopago3_arr,
      out_exttipobonif4 	    OUT exttipobonif4_arr,
      out_extcopago4		    OUT extcopago4_arr,
      out_exttipobonif5 	    OUT exttipobonif5_arr,
      out_extcopago5		    OUT extcopago5_arr
   )
   AS
      v_idafil		      NUMBER;
      v_corr		      NUMBER;
      vcoderror_01	      VARCHAR2 (1000);
      verror_01 	      VARCHAR2 (1000);
      vcoderror_02	      VARCHAR2 (1000);
      verror_02 	      VARCHAR2 (1000);
      vcoderror_03_l1	      VARCHAR2 (1000);
      verror_03_l1	      VARCHAR2 (1000);
      vcoderror_03_l2	      VARCHAR2 (1000);
      verror_03_l2	      VARCHAR2 (1000);
      vcoderror_03_l3	      VARCHAR2 (1000);
      verror_03_l3	      VARCHAR2 (1000);
      vcoderror_03_l4	      VARCHAR2 (1000);
      verror_03_l4	      VARCHAR2 (1000);
      vcoderror_03_l5	      VARCHAR2 (1000);
      verror_03_l5	      VARCHAR2 (1000);
      vcoderror_03_l6	      VARCHAR2 (1000);
      verror_03_l6	      VARCHAR2 (1000);
      vcoderror_03_l7	      VARCHAR2 (1000);
      verror_03_l7	      VARCHAR2 (1000);
      vcodhomologo_l1	      VARCHAR2 (10);
      vcodhomologo_l2	      VARCHAR2 (10);
      vcodhomologo_l3	      VARCHAR2 (10);
      vcodhomologo_l4	      VARCHAR2 (10);
      vcodhomologo_l5	      VARCHAR2 (10);
      vcodhomologo_l6	      VARCHAR2 (10);
      vcodhomologo_l7	      VARCHAR2 (10);
      vitem_l1		      VARCHAR2 (2);
      vitem_l2		      VARCHAR2 (2);
      vitem_l3		      VARCHAR2 (2);
      vitem_l4		      VARCHAR2 (2);
      vitem_l5		      VARCHAR2 (2);
      vitem_l6		      VARCHAR2 (2);
      vitem_l7		      VARCHAR2 (2);
      vcodadicional_l1	      VARCHAR2 (15);
      vcodadicional_l2	      VARCHAR2 (15);
      vcodadicional_l3	      VARCHAR2 (15);
      vcodadicional_l4	      VARCHAR2 (15);
      vcodadicional_l5	      VARCHAR2 (15);
      vcodadicional_l6	      VARCHAR2 (15);
      vcodadicional_l7	      VARCHAR2 (15);
      vrecargo_l1	      VARCHAR2 (3);
      vrecargo_l2	      VARCHAR2 (3);
      vrecargo_l3	      VARCHAR2 (3);
      vrecargo_l4	      VARCHAR2 (3);
      vrecargo_l5	      VARCHAR2 (3);
      vrecargo_l6	      VARCHAR2 (3);
      vrecargo_l7	      VARCHAR2 (3);
      vcantidad_l1	      VARCHAR2 (2) := 0;
      vcantidad_l2	      VARCHAR2 (2) := 0;
      vcantidad_l3	      VARCHAR2 (2) := 0;
      vcantidad_l4	      VARCHAR2 (2) := 0;
      vcantidad_l5	      VARCHAR2 (2) := 0;
      vcantidad_l6	      VARCHAR2 (2) := 0;
      vcantidad_l7	      VARCHAR2 (2) := 0;
      vvalortotal_l1	      VARCHAR2 (12) := 0;
      vvalortotal_l2	      VARCHAR2 (12) := 0;
      vvalortotal_l3	      VARCHAR2 (12) := 0;
      vvalortotal_l4	      VARCHAR2 (12) := 0;
      vvalortotal_l5	      VARCHAR2 (12) := 0;
      vvalortotal_l6	      VARCHAR2 (12) := 0;
      vvalortotal_l7	      VARCHAR2 (12) := 0;
      vvalorconvenio_l1       NUMBER := 0;
      vvalorconvenio_l2       NUMBER := 0;
      vvalorconvenio_l3       NUMBER := 0;
      vvalorconvenio_l4       NUMBER := 0;
      vvalorconvenio_l5       NUMBER := 0;
      vvalorconvenio_l6       NUMBER := 0;
      vvalorconvenio_l7       NUMBER := 0;
      vcodintegrante_l1       VARCHAR2 (10);
      vcodintegrante_l2       VARCHAR2 (10);
      vcodintegrante_l3       VARCHAR2 (10);
      vcodintegrante_l4       VARCHAR2 (10);
      vcodintegrante_l5       VARCHAR2 (10);
      vcodintegrante_l6       VARCHAR2 (10);
      vcodintegrante_l7       VARCHAR2 (10);
      vcodisapre_l1	      NUMBER;
      vcodisapre_l2	      NUMBER;
      vcodisapre_l3	      NUMBER;
      vcodisapre_l4	      NUMBER;
      vcodisapre_l5	      NUMBER;
      vcodisapre_l6	      NUMBER;
      vcodisapre_l7	      NUMBER;
      vvalorbonif_l1	      NUMBER := 0;
      vvalorbonif_l2	      NUMBER := 0;
      vvalorbonif_l3	      NUMBER := 0;
      vvalorbonif_l4	      NUMBER := 0;
      vvalorbonif_l5	      NUMBER := 0;
      vvalorbonif_l6	      NUMBER := 0;
      vvalorbonif_l7	      NUMBER := 0;
      vvalorcopago_l1	      NUMBER := 0;
      vvalorcopago_l2	      NUMBER := 0;
      vvalorcopago_l3	      NUMBER := 0;
      vvalorcopago_l4	      NUMBER := 0;
      vvalorcopago_l5	      NUMBER := 0;
      vvalorcopago_l6	      NUMBER := 0;
      vvalorcopago_l7	      NUMBER := 0;
      vvaloraran_l1	      NUMBER := 0;
      vvaloraran_l2	      NUMBER := 0;
      vvaloraran_l3	      NUMBER := 0;
      vvaloraran_l4	      NUMBER := 0;
      vvaloraran_l5	      NUMBER := 0;
      vvaloraran_l6	      NUMBER := 0;
      vvaloraran_l7	      NUMBER := 0;
      vlinea_l1 	      VARCHAR2 (500);
      vlinea_l2 	      VARCHAR2 (500);
      vlinea_l3 	      VARCHAR2 (500);
      vlinea_l4 	      VARCHAR2 (500);
      vlinea_l5 	      VARCHAR2 (500);
      vlinea_l6 	      VARCHAR2 (500);
      vlinea_l7 	      VARCHAR2 (500);

      v_arreglo_intgte	      ben_pck_tipo_datos.arreglorep_intgte;
      v_arreglo 	      ben_pck_tipo_datos.arreglorep12;

      v_arreglo_intgteS       ben_pck_tipo_datos.arreglorep_intgte;
      v_arregloS	      ben_pck_tipo_datos.arreglorep12;

      v_fechaemision	      DATE;
      v_idprestador	      NUMBER;
      v_iddireccion	      NUMBER;
      v_tipopresta	      VARCHAR2 (2);
      v_idpropio	      NUMBER;
      v_indice		      NUMBER;
      -- variables asociadas a credito
      v_credito 	      NUMBER;
      v_titularcredito	      NUMBER;
      v_existecredito	      BOOLEAN;
      vcoderror_04	      VARCHAR2 (1000);
      v_disponible	      NUMBER;
      i 		      NUMBER;
      j 		      NUMBER;
      vposfin		      NUMBER;
      vrutprestador	      NUMBER;
      vdvprestador	      VARCHAR2 (1);
      vrutben		      NUMBER;
      vdvben		      VARCHAR2 (1);
      vcodplan		      VARCHAR2 (10);
      vrutstaff 	      NUMBER;
      vdvstaff		      VARCHAR2 (1);
      v_staff_ob	      VARCHAR2 (1);
      srv_fetchstatus	      NUMBER (1);
      srv_totalrows	      NUMBER (8);
      srv_rowcount	      NUMBER (8);
      v_existeayuda	      NUMBER;
      v_ayudaasistencial      NUMBER;
      v_sec		      NUMBER;
      v_tipoayuda	      VARCHAR2 (10);
      vcaract		      NUMBER (1);
      verrordiahora	      VARCHAR2 (30);
      cuentaprev	      NUMBER (3);
      /*********valores ben_bonificador12_n isapres**********/
      vid_isapre	      NUMBER := 0;
      vid_enc_conv	      NUMBER := 0;
      vnro_docto	      NUMBER := 2;
      vtipo_doc 	      VARCHAR2 (100) := 'B';
      vcopago_final	      NUMBER := 0;
      vcod_prest	      VARCHAR2 (15);
      vocm		      NUMBER := 0;
      vestado_tope	      VARCHAR2 (100) := 'EMI';
      vperiodicidad	      NUMBER (1) := 1;
      cobertura_prestacion    VARCHAR2 (3);
      p_exthomlugarconvenio   VARCHAR2 (10);
      determina_cobertura     VARCHAR2 (10);

      -------------------------------------------------------------------------
      --Variables para rutina Seguro de Chuqui
      -------------------------------------------------------------------------
      vCodError_03	    VARCHAR2(1000);
      vError_03 	    VARCHAR2(1000);

      vError_04 	    VARCHAR2(1000);

      vCodError_05	    VARCHAR2(1000);
      vError_05 	    VARCHAR2(1000);

      vEsPlanSeguro	    boolean;
      vPaso		    number;

      vTipCob		    varchar2(10);
      vTipCobS		    varchar2(10);
      vTipCobP		    varchar2(10);
      vTipCobSP 	    varchar2(10);
      vEsCM		    boolean:=FAlse;

      vIntIsaPaso	    varchar2(15);
      --VexisteROL_E	      NUMBER;

      vValorBonifS_L1	    NUMBER := 0;
      vValorBonifS_L2	    NUMBER := 0;
      vValorBonifS_L3	    NUMBER := 0;
      vValorBonifS_L4	    NUMBER := 0;
      vValorBonifS_L5	    NUMBER := 0;
      vValorBonifS_L6	    NUMBER := 0;
      vValorBonifS_L7	    NUMBER := 0;

      vValorCopagoS_L1	    NUMBER := 0;
      vValorCopagoS_L2	    NUMBER := 0;
      vValorCopagoS_L3	    NUMBER := 0;
      vValorCopagoS_L4	    NUMBER := 0;
      vValorCopagoS_L5	    NUMBER := 0;
      vValorCopagoS_L6	    NUMBER := 0;
      vValorCopagoS_L7	    NUMBER := 0;


      -------------------------------------------------------------------------
      --Variables para Setear la Salida
      -------------------------------------------------------------------------
      vv_SEPARADOR	      VARCHAR2(1):=';';
      vv_PARAMETROS_SALIDA    VARCHAR2(4000);

      -------------------------------------------------------------------------
      --Variables Auxiliares
      -------------------------------------------------------------------------
      v_vAUX		      VARCHAR2(100);
      v_nIMED_AUDI_SEQ	      NUMBER(10);
      v_vPARAMETROS_ENTRADA   VARCHAR2(4000);
      v_vPRE		      VARCHAR2(10);

      v_nMAX_LISTAS	      NUMBER(3) := 7;
      v_nMAX_LINEAS_LISTAS    NUMBER(3) := 5;

      v_vLISTA_EN_USO	      VARCHAR2(2000);

      E_salir		      EXCEPTION;
      v_nMONTO_TOTAL_BONO     NUMBER(15,2):=0;
      v_nMONTO_ISAPRE_BONO    NUMBER(15,2):=0;
      v_nMONTO_COPAGO_BONO    NUMBER(15,2):=0;

      v_nMTO_CREDITO_LINEA    NUMBER(15,2):=0;
      v_nMTO_BON_SEG_LINEA    NUMBER(15,2):=0;
      v_nMTO_BON_BCC_LINEA    NUMBER(15,2):=0;
      v_nMTO_BONIF_B12	      NUMBER(15,2):=0;
      v_nIMED_DEAU_SEQ	      NUMBER(10);

      v_nREGION_RESIDE_PREST  NUMBER(10);
      v_nREGION_RESIDE_BENEF  NUMBER(10);


FUNCTION F_SETEA_SALIDA RETURN VARCHAR2 IS
vv_SALIDA	     LONG;
vv_SALIDA_Aux	    VARCHAR2(4000);
BEGIN
    vv_SALIDA := (SRV_Message||vv_SEPARADOR||Out_ExtCodError||vv_SEPARADOR||Out_ExtMensajeError||vv_SEPARADOR||Out_ExtPlan||vv_SEPARADOR||Out_ExtGlosa1||vv_SEPARADOR||Out_ExtGlosa2||vv_SEPARADOR||Out_ExtGlosa3||vv_SEPARADOR||Out_ExtGlosa4||vv_SEPARADOR||Out_ExtGlosa5||vv_SEPARADOR);

    FOR i IN 1 ..Out_ExtValorPrestacion.COUNT LOOP
	vv_SALIDA := (vv_SALIDA ||Out_ExtValorPrestacion(i)||vv_SEPARADOR);
    END LOOP;

    FOR i IN 1 ..Out_ExtAporteFinanciador.COUNT LOOP
	vv_SALIDA := (vv_SALIDA ||Out_ExtAporteFinanciador(i)||vv_SEPARADOR);
    END LOOP;

    FOR i IN 1 ..Out_ExtCopago.COUNT LOOP
	vv_SALIDA := (vv_SALIDA ||Out_ExtCopago(i)||vv_SEPARADOR);
    END LOOP;

    FOR i IN 1 ..Out_ExtInternoisa.COUNT LOOP
	vv_SALIDA := (vv_SALIDA ||Out_ExtInternoisa(i)||vv_SEPARADOR);
    END LOOP;

    FOR i IN 1 ..Out_ExtTipoBonif1.COUNT LOOP
	vv_SALIDA := (vv_SALIDA ||Out_ExtTipoBonif1(i)||vv_SEPARADOR);
    END LOOP;

    FOR i IN 1 ..Out_ExtCopago1.COUNT LOOP
	vv_SALIDA := (vv_SALIDA ||Out_ExtCopago1(i)||vv_SEPARADOR);
    END LOOP;

    FOR i IN 1 ..Out_ExtTipoBonif2.COUNT LOOP
	vv_SALIDA := (vv_SALIDA ||Out_ExtTipoBonif2(i)||vv_SEPARADOR);
    END LOOP;

    FOR i IN 1 ..Out_ExtCopago2.COUNT LOOP
	vv_SALIDA := (vv_SALIDA ||Out_ExtCopago2(i)||vv_SEPARADOR);
    END LOOP;

    FOR i IN 1 ..Out_ExtTipoBonif3.COUNT LOOP
	vv_SALIDA := (vv_SALIDA ||Out_ExtTipoBonif3(i)||vv_SEPARADOR);
    END LOOP;

    FOR i IN 1 ..Out_ExtCopago3.COUNT LOOP
	vv_SALIDA := (vv_SALIDA ||Out_ExtCopago3(i)||vv_SEPARADOR);
    END LOOP;

    FOR i IN 1 ..Out_ExtTipoBonif4.COUNT LOOP
	vv_SALIDA := (vv_SALIDA ||Out_ExtTipoBonif4(i)||vv_SEPARADOR);
    END LOOP;

    FOR i IN 1 ..Out_ExtCopago4.COUNT LOOP
	vv_SALIDA := (vv_SALIDA ||Out_ExtCopago4(i)||vv_SEPARADOR);
    END LOOP;

    FOR i IN 1 ..Out_ExtTipoBonif5.COUNT LOOP
	vv_SALIDA := (vv_SALIDA ||Out_ExtTipoBonif5(i)||vv_SEPARADOR);
    END LOOP;

    FOR i IN 1 ..Out_ExtCopago5.COUNT LOOP
	vv_SALIDA := (vv_SALIDA ||Out_ExtCopago5(i)||vv_SEPARADOR);
    END LOOP;

    vv_SALIDA_Aux:= RTRIM(RPAD(vv_SALIDA ,4000));
    RETURN vv_SALIDA_Aux;
END F_SETEA_SALIDA;

FUNCTION F_OBTIENE_LISTA(p_indice IN NUMBER)
RETURN VARCHAR2
IS
v_vLISTA		VARCHAR2(2000);
BEGIN
  IF	p_indice = 1 THEN
    v_vLISTA := in_extlista1;
  ELSIF p_indice = 2 THEN
    v_vLISTA := in_extlista2;
  ELSIF p_indice = 3 THEN
    v_vLISTA := in_extlista3;
  ELSIF p_indice = 4 THEN
    v_vLISTA := in_extlista4;
  ELSIF p_indice = 5 THEN
    v_vLISTA := in_extlista5;
  ELSIF p_indice = 6 THEN
    v_vLISTA := in_extlista6;
  ELSIF p_indice = 7 THEN
    v_vLISTA := in_extlista7;
  END IF;
RETURN v_vLISTA;
END;


   BEGIN
      INSERT INTO imed_valorvari (srv_message,	  --	    VARCHAR2(10 BYTE),
				  extcodfinanciador,		   --  NUMBER,
				  exthomnumeroconvenio,  -- VARCHAR2(15 BYTE),
				  exthomlugarconvenio,	--  VARCHAR2(10 BYTE),
				  extsucventa,	       --   VARCHAR2(10 BYTE),
				  extrutconvenio,      --   VARCHAR2(12 BYTE),
				  extruttratante,     --    VARCHAR2(12 BYTE),
				  extespecialidad,	--  VARCHAR2(10 BYTE),
				  extrutsolicitante,	 -- VARCHAR2(12 BYTE),
				  extrutbeneficiario,	 -- VARCHAR2(12 BYTE),
				  exttratamiento,	  -- VARCHAR2(1 BYTE),
				  extcodigodiagnostico,  -- VARCHAR2(10 BYTE),
				  extnivelconvenio,		    -- NUMBER,
				  exturgencia,		  -- VARCHAR2(1 BYTE),
				  extlista1,		-- VARCHAR2(255 BYTE),
				  extlista2,	       -- -VARCHAR2(255 BYTE),
				  extlista3,		-- VARCHAR2(255 BYTE),
				  extlista4,		-- VARCHAR2(255 BYTE),
				  extlista5,	       --  VARCHAR2(255 BYTE),
				  extlista6,	       --  VARCHAR2(255 BYTE),
				  extlista7,		-- VARCHAR2(255 BYTE),
				  extnumprestaciones,		   --  NUMBER,
				  fecha_recep)
	VALUES	 (srv_message			  --	   In Out     Varchar2				   ,
		  ,in_extcodfinanciador 	    --	      In	 Number 				     ,
		  ,in_exthomnumeroconvenio	    --	    In	       Varchar2 					,
		  ,in_exthomlugarconvenio	      --    In	       Varchar2 				       ,
		  ,in_extsucventa			--  In	       Varchar2 			       ,
		  ,in_extrutconvenio	      --	    In	       Varchar2 				  ,
		  ,in_extruttratante		--	    In	       Varchar2 				  ,
		  ,in_extespecialidad		  --	    In	       Varchar2 				   ,
		  ,in_extrutsolicitante 	    --	    In	       Varchar2 				     ,
		  ,in_extrutbeneficiario	      --    In	       Varchar2 				      ,
		  ,in_exttratamiento	     -- 	    In	       Varchar2 				  ,
		  ,in_extcodigodiagnostico	  --	    In	       Varchar2 					,
		  ,in_extnivelconvenio		     --       In	 Number 				    ,
		  ,in_exturgencia		    ---     In	       Varchar2 			       ,
		  ,in_extlista1 		       ---  In	       Varchar2 			     ,
		  ,in_extlista2 		      --    In	       Varchar2 			     ,
		  ,in_extlista3 			--  In	       Varchar2 			     ,
		  ,in_extlista4 			  --In	       Varchar2 			     ,
		  ,in_extlista5 		--	    In	       Varchar2 			     ,
		  ,in_extlista6 		  --	    In	       Varchar2 			     ,
		  ,in_extlista7 		    --	    In	       Varchar2 			     ,
		  ,in_extnumprestaciones	     --    In	      Number);
		  ,SYSDATE);
      COMMIT;

      --VALORES POR DEFECTO
      srv_totalrows := TO_NUMBER (RTRIM (srv_message));
      srv_rowcount := 0;
      srv_fetchstatus := 0;
      srv_message := '1000000';
      out_extcoderror := ' ';
      out_extmensajeerror := ' ';
      out_extplan := ' ';
      out_extglosa1 := ' ';
      out_extglosa2 := ' ';
      out_extglosa3 := ' ';
      out_extglosa4 := ' ';
      out_extglosa5 := ' ';
      determina_cobertura := NULL;


      ----------------------------------------------------------------------
      -- Graba Auditoria de Transaccion
      ----------------------------------------------------------------------
      v_vPARAMETROS_ENTRADA := Null;
      v_vPARAMETROS_ENTRADA := SRV_MESSAGE||';'||In_EXTCODFINANCIADOR||';'||In_EXTHOMNUMEROCONVENIO||';'||in_exthomlugarconvenio||';'||In_EXTSUCVENTA||';'||
       In_EXTRUTCONVENIO||';'||In_EXTRUTTRATANTE||';'||In_EXTESPECIALIDAD||';'||In_EXTRUTSOLICITANTE||';'||In_EXTRUTBENEFICIARIO||';'||In_EXTTRATAMIENTO||';'||
       In_EXTCODIGODIAGNOSTICO||';'|| In_EXTNIVELCONVENIO||';'||In_EXTURGENCIA||';'||In_EXTLISTA1||';'||In_EXTLISTA2||';'||In_EXTLISTA3||';'||In_EXTLISTA4||';'||
       In_EXTLISTA5||';'||In_EXTLISTA6||';'||In_EXTLISTA7||';'||In_EXTNUMPRESTACIONES||';';

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
	  (v_nIMED_AUDI_SEQ,in_extcodfinanciador,v_vPRE||'VALORVARI_PKG',sysdate,in_exthomnumeroconvenio,in_exthomlugarconvenio,in_extsucventa,substr(in_extruttratante,1,Instr(in_extruttratante,'-')-1),substr(in_extrutbeneficiario,1,Instr(in_extrutbeneficiario,'-')-1),null,null,null,null,null,null,null,null,v_vPARAMETROS_ENTRADA,null,Sysdate,Null,Null)
	  ;
      Exception
      When Others Then
	Null;
      End;
      COMMIT;

      -- Valido codigo financiador
      IF in_extcodfinanciador NOT IN (65, 63, 62, 68)
      THEN
	 out_extcoderror := 'N';
	 out_extmensajeerror := 'Codigo Financiador Erroneo';
	 RAISE E_SALIR;
      END IF;

      -- Para Chuqui lo busco en Homologos
      if in_extcodfinanciador = 65 Then
	   p_exthomlugarconvenio:= admimed.F_DOMI_HOMO_65(in_exthomlugarconvenio, substr(in_extrutconvenio,1,Instr(in_extrutconvenio,'-')-1) );
      Else
	    p_exthomlugarconvenio := in_exthomlugarconvenio;
      END IF;

      IF TO_NUMBER (in_exthomlugarconvenio) = 124
      THEN
	 p_exthomlugarconvenio := '2311';
      END IF;

      IF TO_NUMBER (in_exthomlugarconvenio) = 70019
      THEN
	 p_exthomlugarconvenio := '8239';
      END IF;

      -- valido prestador
      -- valido domicilio prestador
      admimed.validoprestador (in_exthomnumeroconvenio,
			       p_exthomlugarconvenio,
			       in_extsucventa,
			       in_extrutconvenio,
			       TRUNC (SYSDATE),
			       vrutprestador,
			       vdvprestador,
			       vcoderror_01,
			       verror_01);

      IF vcoderror_01 = 'S'
      THEN
	 out_extcoderror := 'N';
	 out_extmensajeerror := verror_01;
	 RAISE E_SALIR;
      END IF;

      -- valido beneficiario
      admimed.validobeneficiario (in_extrutbeneficiario,
				  TRUNC (SYSDATE),
				  v_idafil,
				  v_corr,
				  vrutben,
				  vdvben,
				  vcodplan,
				  vcoderror_02,
				  verror_02,
				  vid_isapre);

      IF vcoderror_02 = 'S'
      THEN
	 out_extcoderror := 'N';
	 out_extmensajeerror := verror_02;
	 RAISE E_SALIR;
      END IF;

      --      IF vid_isapre = 90
      --      THEN
      --	 out_extglosa1 := 'Atencion';
      --	 out_extglosa2 := 'Cobrar Bono a CODELCO CHILE DIVISION EL TENIENTE';
      --      END IF;

      /**************************************************************************************/
      /*										    */
      /* Req Cristian Gonzalez 06/05/2014						    */
      /*										    */
      /* Por favor agregar los planes FUSA% a la regla de IMED para determinar el	    */
      /* tipo de cobertura CR (Cobertura Residencia).Los planes FUSA 05- FUSA 07 y	    */
      /* FUSA 08 NO deben estar incluidos en la regla, todos los demas planes FUSA	    */
      /* SI deben estar incluidos en la regla.						    */
      /**************************************************************************************/

      /**************************************************************************************/
      /*										    */
      /* Req Jose Luis Leiton 06/10/2014						    */
      /*										    */
      /*  Considerar el plan ROLA80 para la asignacion de tipo cobertura CR		    */
      /*										    */
      /**************************************************************************************/

      /**************************************************************************************/
      /*										    */
      /* Req Cristian Gonzalez 18/02/2015						     */
      /*										    */
      /*  Considerar el plan ROLA81 para la asignacion de tipo cobertura CR		    */
      /*										    */
      /**************************************************************************************/

      /**************************************************************************************/
      /*										    */
      /* Req Jose Luis Leitom 23/06/2015   (Correo de Marcia Rodriguez ,		    */
      /*				    JLLC estaba en Rancagua ese dia)		    */
      /*										    */
      /*     PROYECTO 675 - COBERTURA RESIDENCIA EN IMED				    */
      /*	 Imed solo en mega 5ta region es asi:					    */
      /*										    */
      /*	 Solo para Isapre 63							    */
      /*	 Esto solo para los planes indicados con residencia			    */
      /*	 Revisar la residencia del beneficiario (region)			    */
      /*	 Revisar Region del prestador						    */
      /*	 Si son iguales aplica residencia					    */
      /*	 Sino Normal								    */
      /*										    */
      /*										    */
      /*    Codigo Anterior
      IF     in_extcodfinanciador = 63 AND TO_NUMBER (p_exthomlugarconvenio) = 1718 AND TO_NUMBER (in_exthomnumeroconvenio) = 96942400 THEN
	 IF vcodplan = 'ROLA80' OR vcodplan = 'ROLA81' OR vcodplan LIKE 'ROLB%' OR vcodplan LIKE 'PBT%' OR vcodplan LIKE 'DET%' or vcodplan LIKE 'FUSA%'  THEN
	    if vcodplan = 'FUSA05' or vcodplan = 'FUSA052427' or vcodplan = 'FUSA07' or vcodplan = 'FUSA072427' or vcodplan = 'FUSA08' or vcodplan = 'FUSA082427' THEN
		determina_cobertura := NULL;
	    else
		determina_cobertura := 'CR';
	    end if;
	 ELSE
	    determina_cobertura := NULL;
	 END IF;
      ELSE
	 determina_cobertura := NULL;
      END IF;
      */
      /**************************************************************************************/

      IF  in_extcodfinanciador = 63 AND TO_NUMBER (in_exthomnumeroconvenio) = 96942400 THEN
	  --Region del Lugar del Prestador
	  Begin
	   SELECT COMU.GLRP_REG_COD_REG
	   INTO v_nREGION_RESIDE_PREST
	   FROM ADMCONMED.V_CONV_DIRECCIONES_ATENCIONES DIAT,
		ADMGLOB.GL_COMUNAS comu
	   WHERE DIAT.ID = TO_NUMBER (p_exthomlugarconvenio)
	   AND	 DIAT.COD_COMUNA = COMU.COD_COM
	   ;
	  Exception
	  When Others Then
	    v_nREGION_RESIDE_PREST := 9999;
	  End;
	  --Region del Beneficiario
	  Begin
	    v_nREGION_RESIDE_BENEF:= ADMPLAN.PCK_COBERTURAS.F_REGION_BENEF(v_idafil, v_corr, TRUNC (SYSDATE));
	  Exception
	  When Others Then
	    v_nREGION_RESIDE_BENEF := 8888;
	  End;
	  If v_nREGION_RESIDE_PREST = 5 Then
	     IF vcodplan = 'ROLA80' OR vcodplan = 'ROLA81' OR vcodplan LIKE 'ROLB%' OR vcodplan LIKE 'PBT%' OR vcodplan LIKE 'DET%' or vcodplan LIKE 'FUSA%'  THEN
		if vcodplan = 'FUSA05' or vcodplan = 'FUSA052427' or vcodplan = 'FUSA07' or vcodplan = 'FUSA072427' or vcodplan = 'FUSA08' or vcodplan = 'FUSA082427' THEN
		    determina_cobertura := NULL;
		else
		    -- Comparar Residencia de Beneficiario y Prestador
		    If v_nREGION_RESIDE_BENEF = v_nREGION_RESIDE_PREST Then
			determina_cobertura := 'CR';
		    Else
			determina_cobertura := NULL;
		    End If;
		end if;
	     ELSE
		determina_cobertura := NULL;
	     END IF;
	  Else
	     determina_cobertura := NULL;
	  End if;
      ELSE
	 determina_cobertura := NULL;
      END IF;

      IF in_extcodfinanciador in (65,68) then
	    -- Determino si el plan tiene seguro complementario asociado
	    Select count(*)
	    into vPaso
	    From ADMPLAN.PL_PLAN_SEGURO
	    Where cod_plan_isa = vCodPlan;

	    if vPaso = 0 then
	     vEsPlanSeguro:= FALSE;
	    else
	     vEsPlanSeguro:= TRUE;
	    end if;

      END IF;

      IF in_extcodfinanciador = 65 then
	    -- Determino el tipo de cobertura isapre
	    ADMIMED.ValidoTipoCobertura(
					v_idafil,
					p_exthomlugarconvenio,--In_extHomLugarConvenio,
					vCodPlan,
					vTipCob,
					vCodError_03,
					vError_03
					);

	    if vCodError_03 = 'S' then
	      Out_extCodError	  := 'N';
	      Out_extMensajeError := vError_03;
	      RAISE E_SALIR;
	    end if;

	    if vTipCob = 'CG' then
	     vTipCobP := null;
	    else
	     vTipCobP := vTipCob;
	    end if;
	    ---------------------------------------------------------------------
	    -- Valor de Tipo de Cobertura del proceso de Chuqi (Variable vTipCobP ) debe ser
	    -- pasado a la variable "determina_cobertura"
	    ---------------------------------------------------------------------
	    determina_cobertura := vTipCobP;

	    -- Determino el tipo de cobertura seguro
	    ADMIMED.ValidoTipoCoberturaS_CHU(
					v_idafil,
					p_exthomlugarconvenio,--In_extHomLugarConvenio,
					vCodPlan,
					vTipCobS,
					vCodError_04,
					vError_04
					);

	    if vCodError_04 = 'S' then
	      Out_extCodError	  := 'N';
	      Out_extMensajeError := vError_04;
	      RAISE E_SALIR;
	    end if;

	    if vTipCobS = 'CG' then
	     vTipCobSP := null;
	    else
	     vTipCobSP := vTipCobS;
	    end if;

	    -- Valido si es Plan "CM" para separar impresion
	    ADMIMED.ValidoEsPlanCM(
				vCodPlan,
				vEsCM,
				vCodError_05,
				vError_05);

	    if vCodError_05 = 'S' then
	      Out_extCodError	  := 'N';
	      Out_extMensajeError := vError_05;
	      RAISE E_SALIR;
	    end if;


	    vIntIsaPaso := vTipCob || '*' || vTipCobS || '*';
      END IF;

      IF in_extcodfinanciador = 68 then
	vTipCobS :='CG';
	vTipCobSP:='CG';
      END IF;

      -- valido staff cuando viene
      IF TRIM (in_extruttratante) <> '0000000000-0'	THEN


	 Admimed.validostaff (in_extruttratante,
			      vrutprestador,
			      vrutstaff,
			      vdvstaff,
			      vcoderror_01,
			      verror_01);

	 /*IF vcoderror_01 = 'S' THEN
	    out_extcoderror := 'N';
	    out_extmensajeerror := SUBSTR (verror_01, 1, 30);
	    RAISE E_SALIR;
	 END IF;
	 */

      ELSE

	 IF in_extcodfinanciador <> 65 then

	     BEGIN
		SELECT	 cvdo_staff_oblg
		  INTO	 v_staff_ob
		  FROM	 con_domicis
		 WHERE	 cvdo_id_domi = p_exthomlugarconvenio;
	     EXCEPTION
		WHEN NO_DATA_FOUND
		THEN
		   NULL;
	     END;

	     IF UPPER (v_staff_ob) = 'S'
	     THEN
		out_extcoderror := 'N';
		out_extmensajeerror := 'Debe seleccionar Med. Tratante';
		RAISE E_SALIR;
	     END IF;

	 END IF;

      END IF;

      -- valido listas
      vcoderror_03_l1 := 'N';
      vcoderror_03_l2 := 'N';
      vcoderror_03_l3 := 'N';
      vcoderror_03_l4 := 'N';
      vcoderror_03_l5 := 'N';
      vcoderror_03_l6 := 'N';
      vcoderror_03_l7 := 'N';
      v_fechaemision := TRUNC (SYSDATE);
      v_idprestador := 1;
      v_iddireccion := p_exthomlugarconvenio;
      v_tipopresta := 'A';
      v_idpropio := NULL;

      IF in_extnumprestaciones > 49
      THEN
	 out_extcoderror := 'N';
	 out_extmensajeerror := 'N Detalles > 49';
	 RAISE E_SALIR;
      END IF;

      IF in_extnumprestaciones < 1
      THEN
	 out_extcoderror := 'N';
	 out_extmensajeerror := 'N Detalles < 1';
	 RAISE E_SALIR;
      END IF;

      IF in_extcodfinanciador = 65 then

	 v_existecredito := ADMBENE.BEN_F_EXISTE_CTA_CRED(v_idafil,
							 v_credito,
							 v_titularcredito,
							 vCodError_04);

	if v_corr > 0 then
	    if ADMCRED.PROHIBICION_CARGA(v_idafil, v_corr, trunc(sysdate)) then
		    v_credito:= 0;
		    v_existecredito := FALSE;
	    end if;
	end if;
      ELSE

	  v_existecredito := FALSE;
	  v_credito := 0;

      END IF;

      IF vcoderror_04 IS NOT NULL THEN
	 out_extcoderror := 'N';
	 out_extmensajeerror := vcoderror_04;
	 RAISE E_SALIR;
      END IF;

      IF v_existecredito THEN
	 v_disponible := v_credito;
      ELSE
	 v_disponible := 0;
      END IF;

      ------------------------------------------------------------------------------------------------------
      -- Se comienza a trabajar con las listas
      ------------------------------------------------------------------------------------------------------
      IF in_extnumprestaciones > 0 THEN
	v_nMAX_LISTAS := ceil(in_extnumprestaciones/v_nMAX_LINEAS_LISTAS);--v_nMAX_LINEAS_LISTAS constante definida al principio con valor 5.
	j := 0;
	FOR vn_LISTA_INDEX IN 1 ..v_nMAX_LISTAS LOOP
	 -- vv_LINEA_A_GUARDAR corresponde a la lista , puede ser de 1 a 7.
	 v_vLISTA_EN_USO := F_OBTIENE_LISTA(vn_LISTA_INDEX);
	 -------------------------------------------------------------------------------------------------------
	 --vposfin Corresponde al indice que representa a la maxima cantidad de prestaciones dentro de la lista.
	 -------------------------------------------------------------------------------------------------------
	 vposfin := LEAST ((vn_LISTA_INDEX*v_nMAX_LINEAS_LISTAS), in_extnumprestaciones)-((vn_LISTA_INDEX*v_nMAX_LINEAS_LISTAS)-5);
	 FOR i IN 1 .. vposfin LOOP
	 --j es el Indice de posicion dentro de todas las 7 listas
	 --i es el indice de posicion dentro de la lista.
	 j := j + 1;
	    admimed.validolista (i,
				 in_exthomnumeroconvenio,
				 p_exthomlugarconvenio,
				 in_exturgencia,
				 v_vLISTA_EN_USO,--in_extlista1,
				 vcoderror_03_l1,
				 verror_03_l1,
				 vcodhomologo_l1,
				 vitem_l1,
				 vcodadicional_l1,
				 vrecargo_l1,
				 vcantidad_l1,
				 vvalortotal_l1,
				 vvalorconvenio_l1,
				 vcodintegrante_l1,
				 vcodisapre_l1,
				 vid_isapre,
				 vcodplan,
				 vid_enc_conv);

	    IF vcoderror_03_l1 = 'S'
	    THEN
	       out_extcoderror := 'N';
	       out_extmensajeerror := verror_03_l1;
	       RAISE E_SALIR;
	    END IF;

	    IF vrecargo_l1 = 'S'
	    THEN
	       validodiahora (verrordiahora);

	       IF verrordiahora IS NULL
	       THEN
		  vrecargo_l1 := 'INH';
	       ELSE
		  out_extcoderror := 'N';
		  out_extmensajeerror := verrordiahora;
		  RAISE E_SALIR;
	       END IF;
	    ELSE
	       vrecargo_l1 := NULL;
	    END IF;

	    IF in_extcodfinanciador = 65 then
		IF In_extUrgencia='S' then
		   vCaract:=6;
		ELSE
		    vCaract:=4;
		END IF;
	    ELSE
		IF in_exturgencia = 'S'
		THEN
		   vcaract := 6;
		ELSE
		   SELECT   COUNT ( * )
		     INTO   cuentaprev
		     FROM   con_list_isap
		    WHERE   cod LIKE '85%' AND id_prest = vcodisapre_l1;

		   IF cuentaprev > 0
		   THEN
		      vcaract := 7;
		      v_tipopresta := 'PR';
		   ELSE
		      vcaract := 4;
		   END IF;
		END IF;
	    END IF;

	    v_nMTO_CREDITO_LINEA     := 0;
	    v_nMTO_BON_SEG_LINEA     := 0;
	    v_nMTO_BON_BCC_LINEA     := 0;

	    ADMBENE.BEN_BONIFICADOR12_N (v_arreglo_intgte,
					 v_arreglo,
					 vcodintegrante_l1,
					 v_idafil,
					 v_corr,
					 v_fechaemision,
					 in_exthomnumeroconvenio,
					 --v_idprestador,
					 v_iddireccion,
					 vcodisapre_l1,
					 vcantidad_l1,
					 v_tipopresta,
					 vrecargo_l1,
					 determina_cobertura,
					 vcaract,
					 vvalorconvenio_l1,  --vValorTotal_L1,
					 vvalorbonif_l1,
					 vvalorcopago_l1,
					 vvaloraran_l1,
					 v_idpropio,
					 vlinea_l1,
					 vid_enc_conv,
					 vid_isapre,
					 vcodplan,
					 vnro_docto,
					 vtipo_doc,
					 vcopago_final,
					 vcodhomologo_l1,
					 vocm,
					 vestado_tope,
					 vperiodicidad,
					 cobertura_prestacion);

	    v_nMTO_BONIF_B12 := vvalorbonif_l1;

	    IF vlinea_l1 IS NOT NULL
	    THEN
	       out_extcoderror := 'N';
	       out_extmensajeerror := SUBSTR (vlinea_l1, 1, 30);
	       RAISE E_SALIR;
	    END IF;

	    IF in_extcodfinanciador in (65,68) THEN

		vIntIsaPaso			    := cobertura_prestacion || '*' || vTipCobS || '*';
		Out_extTipoBonif1(j)		    := 0;
		Out_extCopago1(j)		    := 0;
		Out_extAporteFinanciador(j)	    := vValorBonif_L1;
		Out_extInternoIsa(j)		    := vIntIsaPaso || '0*';
		vValorBonifS_L1 		    := 0;


		if vEsPlanSeguro and vValorCopago_L1 > 0 then

				vValorBonifS_L1 := 0;
--				  -- Tipo de Cobertura de Acuerdo a Nueva Definicion
--				  vTipCobSP := ADMPLAN.PCK_COBERTURAS_SEG.F_OBT_TIPO_COBERT_SR(
--					 (p_nID_PRESTACION in Number,



				ADMBENE.Ben_Bonificador12_segu
					(
					v_Arreglo_intgteS,
					v_ArregloS,
					vCodIntegrante_L1,

TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					v_idafil,
					v_corr,
					v_fechaemision,
					in_exthomnumeroconvenio,--v_idprestador,
					v_iddireccion,
					vCodIsapre_L1,
					vCantidad_L1,
					v_tipopresta,
					vRecargo_L1,
					vTipCobSP,
					vCaract,
					vcopago_final,--vValorCopago_L1, --vValorTotal_L1,
					vValorBonifS_L1,
					vValorCopagoS_L1,
					vValorAran_L1,
					v_idpropio,
					vValorConvenio_L1,
					vLinea_L1);


		    DBMS_OUTPUT.PUT_LINE ( 'vValorBonifS_L1 = ' || vValorBonifS_L1 );


		    IF vEsCM THEN

			 Out_extTipoBonif1(j)		  := 1;
			 Out_extCopago1(j)		  := vValorBonifS_L1;

			 Out_extAporteFinanciador(j)	  := vValorBonif_L1;--Todo
			 Out_extCopago(j)		  := 0;
			 v_nMTO_BON_SEG_LINEA		  := Out_extCopago1(j);

			 Out_extTipoBonif2(j)		  := 4;
			 Out_extCopago2(j)		  := vValorConvenio_L1*vCantidad_L1 - vValorBonif_L1-vValorBonifS_L1;

			 v_nMTO_CREDITO_LINEA		  := Out_extCopago2(j);

		    ELSE

			 Out_extTipoBonif1(j)		  := 1;
			 Out_extCopago1(j)		  := vValorBonifS_L1;
			 Out_extAporteFinanciador(j)	  := vValorBonif_L1+vValorBonifS_L1;
			 Out_extCopago(j)		  := vValorConvenio_L1*vCantidad_L1 - vValorBonif_L1-vValorBonifS_L1;
			 v_nMTO_BON_SEG_LINEA		  := Out_extCopago1(j);
			 v_nMTO_CREDITO_LINEA		  := 0;

			 Out_extTipoBonif2(j)		  := 0;
			 Out_extCopago2(j)		  := 0;

		    END IF;

		Else -- no es seguro
		    if vEsCM then
			Out_extTipoBonif1(j)		 := 0;
			Out_extCopago1(j)		 := 0;
			Out_extCopago(j)		 := vValorConvenio_L1*vCantidad_L1 - vValorBonif_L1;

			Out_extTipoBonif2(j)		 := 4;
			Out_extCopago2(j)		 := vValorConvenio_L1*vCantidad_L1 - vValorBonif_L1;
			v_nMTO_CREDITO_LINEA		 := Out_extCopago2(j);

		    else
			Out_extTipoBonif1(j)		 := 0;
			Out_extCopago1(j)		 := 0;
			Out_extCopago(j)		 := vValorConvenio_L1*vCantidad_L1 - vValorBonif_L1;

			Out_extTipoBonif2(j)		 := 0;
			Out_extCopago2(j)		 := 0;

		    end if;
		End If;

		if vLinea_L1 is not null then
		      Out_extCodError	  := 'N';
		      Out_extMensajeError := substr(vLinea_L1,1,30);
		      RAISE E_SALIR;
		  end if;
		if Out_extAporteFinanciador(j) < 0 then
		      Out_extCodError	  := 'N';
		      Out_extMensajeError := 'Error en el seguro';
		      RAISE E_SALIR;
		end if;

	     Out_extValorPrestacion(j)	       := vValorConvenio_L1*vCantidad_L1;

	     Out_extTipoBonif3(j)	      := 0;
	     Out_extCopago3(j)		       := 0;
	     Out_extTipoBonif4(j)	      := 0;
	     Out_extCopago4(j)		       := 0;
	     Out_extTipoBonif5(j)	      := 0;
	     Out_extCopago5(j)		       := 0;

	    ELSE

		IF v_existecredito THEN
		   if in_extcodfinanciador not in (65) then

		       out_exttipobonif1 (j)	:= 0;
		       out_extcopago1 (j)	:= 0;

		       IF v_disponible > 1
		       THEN
			  out_extcopago1 (j) :=
			     LEAST (
				v_disponible,
				(vvalorconvenio_l1 * vcantidad_l1 - vvalorbonif_l1)
			     );

			  IF out_extcopago1 (j) > 0
			  THEN
			     out_exttipobonif1 (j) := 9;
			  ELSE
			     out_exttipobonif1 (j) := 0;
			  END IF;

			  v_disponible := v_disponible - out_extcopago1 (j);
		       ELSE
			  out_exttipobonif1 (j) := 0;
			  out_extcopago1 (j) := 0;
		       END IF;
		   END IF;

		   out_extvalorprestacion (j)	:= vvalorconvenio_l1 * vcantidad_l1;
		   out_extaportefinanciador (j) := vvalorbonif_l1;
		   out_extcopago (j)		:= vvalorconvenio_l1 * vcantidad_l1 - vvalorbonif_l1;
		   out_extinternoisa (j)	:= ' ';
		   out_exttipobonif2 (j)	:= 0;
		   out_extcopago2 (j)		:= 0;
		   out_exttipobonif3 (j)	:= 0;
		   out_extcopago3 (j)		:= 0;
		   out_exttipobonif4 (j)	:= 0;
		   out_extcopago4 (j)		:= 0;
		   out_exttipobonif5 (j)	:= 0;
		   out_extcopago5 (j)		:= 0;

		ELSE					   /* no existe credito */
		   out_extvalorprestacion (j) := vvalorconvenio_l1 * vcantidad_l1;
		   out_extaportefinanciador (j) :=vvalorbonif_l1+ ( (vvalorconvenio_l1 * vcantidad_l1 - vvalorbonif_l1)- vcopago_final);
		   out_extcopago (j) := vcopago_final;

		   if in_extcodfinanciador not in (65) then

		       out_exttipobonif1 (j)	:= 1;
		       out_extcopago1 (j)	:=(vvalorconvenio_l1 * vcantidad_l1 - vvalorbonif_l1)- vcopago_final;
		       v_nMTO_BON_BCC_LINEA	:= Out_extCopago1(j);

		   end if;
		   out_extinternoisa (j)	:= cobertura_prestacion;
		   out_exttipobonif2 (j)	:= 0;
		   out_extcopago2 (j)		:= 0;
		   out_exttipobonif3 (j)	:= 0;
		   out_extcopago3 (j)		:= 0;
		   out_exttipobonif4 (j)	:= 0;
		   out_extcopago4 (j)		:= 0;
		   out_exttipobonif5 (j)	:= 0;
		   out_extcopago5 (j)		:= 0;
		END IF;
	    end if ; --FIN IF ISAPRE 65

--	      DBMS_OUTPUT.PUT_LINE ( 'out_extvalorprestacion (j) = ' || out_extvalorprestacion (j) );
--	      DBMS_OUTPUT.PUT_LINE ( 'out_extaportefinanciador (j) = ' || out_extaportefinanciador (j) );
--	      DBMS_OUTPUT.PUT_LINE ( 'out_extcopago (j) = ' || out_extcopago (j) );

	    out_extaportefinanciador (j) := out_extvalorprestacion (j)-out_extcopago (j);

	    v_nMONTO_TOTAL_BONO :=v_nMONTO_TOTAL_BONO+out_extvalorprestacion (j);
	    v_nMONTO_ISAPRE_BONO := v_nMONTO_ISAPRE_BONO+out_extaportefinanciador (j);
	    v_nMONTO_COPAGO_BONO := v_nMONTO_COPAGO_BONO+out_extcopago (j);


	    --GRABAR EL ID del DETALLE DE LA AUDITORIA con:.
	    BEGIN

		Select ADMIMED.IMED_DEAU_SEQ.NextVAl
		Into v_nIMED_DEAU_SEQ
		From Dual;

		Insert Into AdmImed.Imed_Det_Auditoria
		(ID,AUDI_CORRELATIVO,INTERNO_ISAPRE,TIP_COB_SEG,TIP_COB_PLAN,MTO_PRESTACION,MTO_BON_PLAN,MTO_BON_BCC,MTO_BON_SEG,MTO_CREDITO)
		Values
		(v_nIMED_DEAU_SEQ,
		 v_nIMED_AUDI_SEQ,
		 out_extinternoisa (j),
		 vTipCobS,
		 COBERTURA_PRESTACION,
		 out_extvalorprestacion (j),
		 v_nMTO_BONIF_B12 ,
		 v_nMTO_BON_BCC_LINEA,
		 v_nMTO_BON_SEG_LINEA,
		 v_nMTO_CREDITO_LINEA
		 )
		 ;

		out_extinternoisa (j) := v_nIMED_DEAU_SEQ;

	    End;
	    COMMIT;
	    /************************************************************************************************/
	    /*	NOTA: Para saber si el EnvBonis lo debe leer como id detalle o				    */
	    /*	como lo hace actualmente se debe preguntar si existe det para el valor del interno isapre   */
	    /************************************************************************************************/


	 END LOOP;


	END LOOP;
      END IF;

      vv_PARAMETROS_SALIDA:= F_SETEA_SALIDA;
      UPDATE ADMIMED.IMED_AUDITORIA
      Set RUT_COTIZ = Null,
	  ID_AFI = v_idafil,
	  CODIGO_CARGA = v_corr,
	  NRO_BONO_ISAPRE = Null,
	  MONTO_TOTAL_BONO = v_nMONTO_TOTAL_BONO,
	  PREST_TOTALES_BONO = in_extnumprestaciones,
	  MONTO_ISAPRE_BONO = v_nMONTO_ISAPRE_BONO,
	  MONTO_COPAGO_BONO = v_nMONTO_COPAGO_BONO,
	  DATOS_SALIDA = vv_PARAMETROS_SALIDA,
	  FEC_HOR_SALIDA = SYSDATE,
	  SEGUNDOS_RESP = trunc((SYSDATE-FEC_HOR_LLEGADA)*24*60*60),
	  LUGAR_CONVENIO_MOD = p_exthomlugarconvenio
      Where CORRELATIVO = v_nIMED_AUDI_SEQ
      ;
      Commit;
   Exception
   When E_salir Then
      vv_PARAMETROS_SALIDA:= F_SETEA_SALIDA;
      UPDATE ADMIMED.IMED_AUDITORIA
      Set RUT_COTIZ = Null,
	  ID_AFI = v_idafil,
	  CODIGO_CARGA = v_corr,
	  NRO_BONO_ISAPRE = Null,
	  MONTO_TOTAL_BONO = v_nMONTO_TOTAL_BONO,
	  PREST_TOTALES_BONO = in_extnumprestaciones,
	  MONTO_ISAPRE_BONO = v_nMONTO_ISAPRE_BONO,
	  MONTO_COPAGO_BONO = v_nMONTO_COPAGO_BONO,
	  DATOS_SALIDA = vv_PARAMETROS_SALIDA,
	  FEC_HOR_SALIDA = SYSDATE,
	  SEGUNDOS_RESP = trunc((SYSDATE-FEC_HOR_LLEGADA)*24*60*60),
	  LUGAR_CONVENIO_MOD = p_exthomlugarconvenio
      Where CORRELATIVO = v_nIMED_AUDI_SEQ
      ;
      Commit;
   WHEN Others Then
      vv_PARAMETROS_SALIDA:= F_SETEA_SALIDA;
      UPDATE ADMIMED.IMED_AUDITORIA
      Set RUT_COTIZ = Null,
	  ID_AFI = v_idafil,
	  CODIGO_CARGA = v_corr,
	  NRO_BONO_ISAPRE = Null,
	  MONTO_TOTAL_BONO = v_nMONTO_TOTAL_BONO,
	  PREST_TOTALES_BONO = in_extnumprestaciones,
	  MONTO_ISAPRE_BONO = v_nMONTO_ISAPRE_BONO,
	  MONTO_COPAGO_BONO = v_nMONTO_COPAGO_BONO,
	  DATOS_SALIDA = vv_PARAMETROS_SALIDA,
	  FEC_HOR_SALIDA = SYSDATE,
	  SEGUNDOS_RESP = trunc((SYSDATE-FEC_HOR_LLEGADA)*24*60*60),
	  LUGAR_CONVENIO_MOD = p_exthomlugarconvenio
      Where CORRELATIVO = v_nIMED_AUDI_SEQ
      ;
      Commit;
   END fusvalorvari;

   PROCEDURE SNLvalorvari (
      srv_message		 IN OUT VARCHAR2,
      in_extcodfinanciador	 IN	NUMBER,
      in_exthomnumeroconvenio	 IN	VARCHAR2,
      in_exthomlugarconvenio	 IN	VARCHAR2,
      in_extsucventa		 IN	VARCHAR2,
      in_extrutconvenio 	 IN	VARCHAR2,
      in_extruttratante 	 IN	VARCHAR2,
      in_extespecialidad	 IN	VARCHAR2,
      in_extrutsolicitante	 IN	VARCHAR2,
      in_extrutbeneficiario	 IN	VARCHAR2,
      in_exttratamiento 	 IN	VARCHAR2,
      in_extcodigodiagnostico	 IN	VARCHAR2,
      in_extnivelconvenio	 IN	NUMBER,
      in_exturgencia		 IN	VARCHAR2,
      in_extlista1		 IN	VARCHAR2,
      in_extlista2		 IN	VARCHAR2,
      in_extlista3		 IN	VARCHAR2,
      in_extlista4		 IN	VARCHAR2,
      in_extlista5		 IN	VARCHAR2,
      in_extlista6		 IN	VARCHAR2,
      in_extlista7		 IN	VARCHAR2,
      in_extnumprestaciones	 IN	NUMBER,
      out_extcoderror		    OUT VARCHAR2,
      out_extmensajeerror	    OUT VARCHAR2,
      out_extplan		    OUT VARCHAR2,
      out_extglosa1		    OUT VARCHAR2,
      out_extglosa2		    OUT VARCHAR2,
      out_extglosa3		    OUT VARCHAR2,
      out_extglosa4		    OUT VARCHAR2,
      out_extglosa5		    OUT VARCHAR2,
      out_extvalorprestacion	    OUT extvalorprestacion_arr,
      out_extaportefinanciador	    OUT extaportefinanciador_arr,
      out_extcopago		    OUT extcopago_arr,
      out_extinternoisa 	    OUT extinternoisa_arr,
      out_exttipobonif1 	    OUT exttipobonif1_arr,
      out_extcopago1		    OUT extcopago1_arr,
      out_exttipobonif2 	    OUT exttipobonif2_arr,
      out_extcopago2		    OUT extcopago2_arr,
      out_exttipobonif3 	    OUT exttipobonif3_arr,
      out_extcopago3		    OUT extcopago3_arr,
      out_exttipobonif4 	    OUT exttipobonif4_arr,
      out_extcopago4		    OUT extcopago4_arr,
      out_exttipobonif5 	    OUT exttipobonif5_arr,
      out_extcopago5		    OUT extcopago5_arr
   )
   AS
   BEGIN
      FUSvalorvari (srv_message,
		    in_extcodfinanciador,
		    in_exthomnumeroconvenio,
		    in_exthomlugarconvenio,
		    in_extsucventa,
		    in_extrutconvenio,
		    in_extruttratante,
		    in_extespecialidad,
		    in_extrutsolicitante,
		    in_extrutbeneficiario,
		    in_exttratamiento,
		    in_extcodigodiagnostico,
		    in_extnivelconvenio,
		    in_exturgencia,
		    in_extlista1,
		    in_extlista2,
		    in_extlista3,
		    in_extlista4,
		    in_extlista5,
		    in_extlista6,
		    in_extlista7,
		    in_extnumprestaciones,
		    out_extcoderror,
		    out_extmensajeerror,
		    out_extplan,
		    out_extglosa1,
		    out_extglosa2,
		    out_extglosa3,
		    out_extglosa4,
		    out_extglosa5,
		    out_extvalorprestacion,
		    out_extaportefinanciador,
		    out_extcopago,
		    out_extinternoisa,
		    out_exttipobonif1,
		    out_extcopago1,
		    out_exttipobonif2,
		    out_extcopago2,
		    out_exttipobonif3,
		    out_extcopago3,
		    out_exttipobonif4,
		    out_extcopago4,
		    out_exttipobonif5,
		    out_extcopago5);
   END SNLvalorvari;

   PROCEDURE RBLvalorvari (
      srv_message		 IN OUT VARCHAR2,
      in_extcodfinanciador	 IN	NUMBER,
      in_exthomnumeroconvenio	 IN	VARCHAR2,
      in_exthomlugarconvenio	 IN	VARCHAR2,
      in_extsucventa		 IN	VARCHAR2,
      in_extrutconvenio 	 IN	VARCHAR2,
      in_extruttratante 	 IN	VARCHAR2,
      in_extespecialidad	 IN	VARCHAR2,
      in_extrutsolicitante	 IN	VARCHAR2,
      in_extrutbeneficiario	 IN	VARCHAR2,
      in_exttratamiento 	 IN	VARCHAR2,
      in_extcodigodiagnostico	 IN	VARCHAR2,
      in_extnivelconvenio	 IN	NUMBER,
      in_exturgencia		 IN	VARCHAR2,
      in_extlista1		 IN	VARCHAR2,
      in_extlista2		 IN	VARCHAR2,
      in_extlista3		 IN	VARCHAR2,
      in_extlista4		 IN	VARCHAR2,
      in_extlista5		 IN	VARCHAR2,
      in_extlista6		 IN	VARCHAR2,
      in_extlista7		 IN	VARCHAR2,
      in_extnumprestaciones	 IN	NUMBER,
      out_extcoderror		    OUT VARCHAR2,
      out_extmensajeerror	    OUT VARCHAR2,
      out_extplan		    OUT VARCHAR2,
      out_extglosa1		    OUT VARCHAR2,
      out_extglosa2		    OUT VARCHAR2,
      out_extglosa3		    OUT VARCHAR2,
      out_extglosa4		    OUT VARCHAR2,
      out_extglosa5		    OUT VARCHAR2,
      out_extvalorprestacion	    OUT extvalorprestacion_arr,
      out_extaportefinanciador	    OUT extaportefinanciador_arr,
      out_extcopago		    OUT extcopago_arr,
      out_extinternoisa 	    OUT extinternoisa_arr,
      out_exttipobonif1 	    OUT exttipobonif1_arr,
      out_extcopago1		    OUT extcopago1_arr,
      out_exttipobonif2 	    OUT exttipobonif2_arr,
      out_extcopago2		    OUT extcopago2_arr,
      out_exttipobonif3 	    OUT exttipobonif3_arr,
      out_extcopago3		    OUT extcopago3_arr,
      out_exttipobonif4 	    OUT exttipobonif4_arr,
      out_extcopago4		    OUT extcopago4_arr,
      out_exttipobonif5 	    OUT exttipobonif5_arr,
      out_extcopago5		    OUT extcopago5_arr
   )
   AS
   BEGIN
      FUSvalorvari (srv_message,
		    in_extcodfinanciador,
		    in_exthomnumeroconvenio,
		    in_exthomlugarconvenio,
		    in_extsucventa,
		    in_extrutconvenio,
		    in_extruttratante,
		    in_extespecialidad,
		    in_extrutsolicitante,
		    in_extrutbeneficiario,
		    in_exttratamiento,
		    in_extcodigodiagnostico,
		    in_extnivelconvenio,
		    in_exturgencia,
		    in_extlista1,
		    in_extlista2,
		    in_extlista3,
		    in_extlista4,
		    in_extlista5,
		    in_extlista6,
		    in_extlista7,
		    in_extnumprestaciones,
		    out_extcoderror,
		    out_extmensajeerror,
		    out_extplan,
		    out_extglosa1,
		    out_extglosa2,
		    out_extglosa3,
		    out_extglosa4,
		    out_extglosa5,
		    out_extvalorprestacion,
		    out_extaportefinanciador,
		    out_extcopago,
		    out_extinternoisa,
		    out_exttipobonif1,
		    out_extcopago1,
		    out_exttipobonif2,
		    out_extcopago2,
		    out_exttipobonif3,
		    out_extcopago3,
		    out_exttipobonif4,
		    out_extcopago4,
		    out_exttipobonif5,
		    out_extcopago5);
   END RBLvalorvari;
   PROCEDURE CHUvalorvari (
      srv_message		 IN OUT VARCHAR2,
      in_extcodfinanciador	 IN	NUMBER,
      in_exthomnumeroconvenio	 IN	VARCHAR2,
      in_exthomlugarconvenio	 IN	VARCHAR2,
      in_extsucventa		 IN	VARCHAR2,
      in_extrutconvenio 	 IN	VARCHAR2,
      in_extruttratante 	 IN	VARCHAR2,
      in_extespecialidad	 IN	VARCHAR2,
      in_extrutsolicitante	 IN	VARCHAR2,
      in_extrutbeneficiario	 IN	VARCHAR2,
      in_exttratamiento 	 IN	VARCHAR2,
      in_extcodigodiagnostico	 IN	VARCHAR2,
      in_extnivelconvenio	 IN	NUMBER,
      in_exturgencia		 IN	VARCHAR2,
      in_extlista1		 IN	VARCHAR2,
      in_extlista2		 IN	VARCHAR2,
      in_extlista3		 IN	VARCHAR2,
      in_extlista4		 IN	VARCHAR2,
      in_extlista5		 IN	VARCHAR2,
      in_extlista6		 IN	VARCHAR2,
      in_extlista7		 IN	VARCHAR2,
      in_extnumprestaciones	 IN	NUMBER,
      out_extcoderror		    OUT VARCHAR2,
      out_extmensajeerror	    OUT VARCHAR2,
      out_extplan		    OUT VARCHAR2,
      out_extglosa1		    OUT VARCHAR2,
      out_extglosa2		    OUT VARCHAR2,
      out_extglosa3		    OUT VARCHAR2,
      out_extglosa4		    OUT VARCHAR2,
      out_extglosa5		    OUT VARCHAR2,
      out_extvalorprestacion	    OUT extvalorprestacion_arr,
      out_extaportefinanciador	    OUT extaportefinanciador_arr,
      out_extcopago		    OUT extcopago_arr,
      out_extinternoisa 	    OUT extinternoisa_arr,
      out_exttipobonif1 	    OUT exttipobonif1_arr,
      out_extcopago1		    OUT extcopago1_arr,
      out_exttipobonif2 	    OUT exttipobonif2_arr,
      out_extcopago2		    OUT extcopago2_arr,
      out_exttipobonif3 	    OUT exttipobonif3_arr,
      out_extcopago3		    OUT extcopago3_arr,
      out_exttipobonif4 	    OUT exttipobonif4_arr,
      out_extcopago4		    OUT extcopago4_arr,
      out_exttipobonif5 	    OUT exttipobonif5_arr,
      out_extcopago5		    OUT extcopago5_arr
   )
   AS
   BEGIN
      FUSvalorvari (srv_message,
		    in_extcodfinanciador,
		    in_exthomnumeroconvenio,
		    in_exthomlugarconvenio,
		    in_extsucventa,
		    in_extrutconvenio,
		    in_extruttratante,
		    in_extespecialidad,
		    in_extrutsolicitante,
		    in_extrutbeneficiario,
		    in_exttratamiento,
		    in_extcodigodiagnostico,
		    in_extnivelconvenio,
		    in_exturgencia,
		    in_extlista1,
		    in_extlista2,
		    in_extlista3,
		    in_extlista4,
		    in_extlista5,
		    in_extlista6,
		    in_extlista7,
		    in_extnumprestaciones,
		    out_extcoderror,
		    out_extmensajeerror,
		    out_extplan,
		    out_extglosa1,
		    out_extglosa2,
		    out_extglosa3,
		    out_extglosa4,
		    out_extglosa5,
		    out_extvalorprestacion,
		    out_extaportefinanciador,
		    out_extcopago,
		    out_extinternoisa,
		    out_exttipobonif1,
		    out_extcopago1,
		    out_exttipobonif2,
		    out_extcopago2,
		    out_exttipobonif3,
		    out_extcopago3,
		    out_exttipobonif4,
		    out_extcopago4,
		    out_exttipobonif5,
		    out_extcopago5);
   END CHUvalorvari;


END FUSValorVari_Pkg;

1544 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.5.0 - 64bit Production
