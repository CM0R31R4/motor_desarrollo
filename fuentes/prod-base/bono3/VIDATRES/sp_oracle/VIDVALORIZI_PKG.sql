
SQL*Plus: Release 11.2.0.3.0 Production on Thu Aug 8 18:07:08 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package Vidvalorizi_Pkg IS

Type extValorPrestacion_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type extAporteFinanciador_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type extCopago_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type extInternoIsa_arr IS TABLE OF VARCHAR2(15) INDEX BY BINARY_INTEGER;
Type extTipoBonif1_arr IS TABLE OF NUMBER(1) INDEX BY BINARY_INTEGER;
Type extCopago1_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type extTipoBonif2_arr IS TABLE OF NUMBER(1) INDEX BY BINARY_INTEGER;
Type extCopago2_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type extTipoBonif3_arr IS TABLE OF NUMBER(1) INDEX BY BINARY_INTEGER;
Type extCopago3_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type extTipoBonif4_arr IS TABLE OF NUMBER(1) INDEX BY BINARY_INTEGER;
Type extCopago4_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type extTipoBonif5_arr IS TABLE OF NUMBER(1) INDEX BY BINARY_INTEGER;
Type extCopago5_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
--
Type prestacion_arr IS TABLE OF VARCHAR2(40) INDEX BY BINARY_INTEGER;

-- Ini Coptran
Procedure vidvalorizi
(   SRV_Message 	    IN Out VARCHAR2,
	extCodFinanciador  			IN NUMBER,
	extHomNumeroConvenio 		IN VARCHAR2,
	extHomLugarConvenio 		IN VARCHAR2,
	extSucVenta   				IN VARCHAR2,
	extRutConvenio 				IN VARCHAR2,
	extRutTratante 				IN VARCHAR2,
	extEspecialidad 			IN VARCHAR2,
	extRutSolicitante 			IN VARCHAR2,
	extRutBeneficiario 			IN VARCHAR2,
	extTratamiento 				IN VARCHAR2,	-- N / S
	extCodigoDiagnostico		IN VARCHAR2,
	extNivelConvenio			IN NUMBER,		-- 1,2,3
	extUrgencia					IN VARCHAR2,	-- N / S
	extLista1					IN VARCHAR2,   -- '0000101001|A(2)|B(15)|C|D(2)|'
											   -- AA: H=Honorario; P=Pabellon; A=Anestesia
											   -- B : Decodificar factores ?
											   -- C : Recargo Hora = S o N
											   -- D : Cantidad
	extLista2					IN VARCHAR2,
	extLista3					IN VARCHAR2,
	extLista4					IN VARCHAR2,
	extLista5					IN VARCHAR2,
	extLista6					IN VARCHAR2,
	extNumPrestaciones			IN NUMBER,
	extCodError					Out VARCHAR2,	   -- N->error o S->no hay error
	extMensajeError				Out VARCHAR2,
	extPlan						Out VARCHAR2,
	extGlosa1					Out VARCHAR2,
	extGlosa2					Out VARCHAR2,
	extGlosa3					Out VARCHAR2,
	extGlosa4					Out VARCHAR2,
	extGlosa5					Out VARCHAR2,
 	Col_extValorPrestacion 	    Out extValorPrestacion_arr
  	,Col_extAporteFinanciador 	Out extAporteFinanciador_arr
  	,Col_extCopago 				Out extCopago_arr
  	,Col_extInternoIsa 			Out extInternoIsa_arr
  	,Col_extTipoBonif1 			Out extTipoBonif1_arr
  	,Col_extCopago1 			Out extCopago1_arr
  	,Col_extTipoBonif2 			Out extTipoBonif2_arr
  	,Col_extCopago2 			Out extCopago2_arr
  	,Col_extTipoBonif3 			Out extTipoBonif3_arr
  	,Col_extCopago3 			Out extCopago3_arr
  	,Col_extTipoBonif4 			Out extTipoBonif4_arr
  	,Col_extCopago4 			Out extCopago4_arr
  	,Col_extTipoBonif5 			Out extTipoBonif5_arr
  	,Col_extCopago5 			Out extCopago5_arr
);
-- Fin Coptran

End Vidvalorizi_Pkg;

72 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
