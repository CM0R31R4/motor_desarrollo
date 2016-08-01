
SQL*Plus: Release 11.2.0.3.0 Production on Thu Aug 8 19:36:50 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.4.0 - Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package RBLValorVari_Pkg As
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

End RBLValorVari_Pkg;

78 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.4.0 - Production
