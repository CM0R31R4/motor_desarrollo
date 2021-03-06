
SQL*Plus: Release 11.2.0.3.0 Production on Thu Aug 8 18:07:07 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package Vidvalorvari_Pkg IS

Type extValorPrestacion_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type extAporteFinanciador_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type extCopago_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type extInternoIsa_arr IS TABLE OF VARCHAR2(15) INDEX BY BINARY_INTEGER;
Type extTipoBonif1_arr IS TABLE OF NUMBER(2) INDEX BY BINARY_INTEGER;
Type extCopago1_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type extTipoBonif2_arr IS TABLE OF NUMBER(2) INDEX BY BINARY_INTEGER;
Type extCopago2_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type extTipoBonif3_arr IS TABLE OF NUMBER(2) INDEX BY BINARY_INTEGER;
Type extCopago3_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type extTipoBonif4_arr IS TABLE OF NUMBER(2) INDEX BY BINARY_INTEGER;
Type extCopago4_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type extTipoBonif5_arr IS TABLE OF NUMBER(2) INDEX BY BINARY_INTEGER;
Type extCopago5_arr IS TABLE OF NUMBER(12) INDEX BY BINARY_INTEGER;
Type prestacion_arr IS TABLE OF VARCHAR2(40) INDEX BY BINARY_INTEGER;

-- Ini Coptran
Procedure VidValorVari(
SRV_Message	     IN Out VARCHAR2,
extCodFinanciador  	 NUMBER,
extHomNumeroConvenio VARCHAR2,
extHomLugarConvenio  VARCHAR2,
extSucVenta   		 VARCHAR2,
extRutConvenio 		 VARCHAR2,
extRutTratante 		 VARCHAR2,
extEspecialidad 	 VARCHAR2,
extRutSolicitante 	 VARCHAR2,
extRutBeneficiario 	 VARCHAR2,
extTratamiento 		 VARCHAR2, -- N / S
extCodigoDiagnostico VARCHAR2,
extNivelConvenio	 NUMBER,   -- 1,2,3
extUrgencia			 VARCHAR2, -- N / S
extLista1			 VARCHAR2, -- "A(10)0000101001|B(2)|C(15)|D(1)|E(2)|F(12)|"
				   			   -- A : 10 para Codigo Prestacion
					   		   -- B :  2 para Item H:Honorario, P:Pabellon, A:Anestesia
							   -- C : 15 para Codigo Prestacion Adicional, Factores
							   -- D :  1 para Recargo Hora = S o N
							   -- E :  2 para Cantidad
							   -- F : 12 para Valor Total
extLista2			 VARCHAR2,
extLista3			 VARCHAR2,
extLista4			 VARCHAR2,
extLista5			 VARCHAR2,
extLista6			 VARCHAR2,
extLista7			 VARCHAR2,
extNumPrestaciones	 NUMBER,
extCodError		 Out VARCHAR2,	-- N->error o S->no hay error
extMensajeError	 Out VARCHAR2,
extPlan			 Out VARCHAR2,
extGlosa1		 Out VARCHAR2,	-- glosa de 50 caracteres
extGlosa2		 Out VARCHAR2,
extGlosa3		 Out VARCHAR2,
extGlosa4		 Out VARCHAR2,
extGlosa5		 Out VARCHAR2,
Col_extValorPrestacion 	   Out extValorPrestacion_arr
,Col_extAporteFinanciador  Out extAporteFinanciador_arr
,Col_extCopago	     Out extCopago_arr
,Col_extInternoIsa   Out extInternoIsa_arr
,Col_extTipoBonif1	 Out extTipoBonif1_arr
,Col_extCopago1 	 Out extCopago1_arr
,Col_extTipoBonif2 	 Out extTipoBonif2_arr
,Col_extCopago2      Out extCopago2_arr
,Col_extTipoBonif3   Out extTipoBonif3_arr
,Col_extCopago3 	 Out extCopago3_arr
,Col_extTipoBonif4 	 Out extTipoBonif4_arr
,Col_extCopago4 	 Out extCopago4_arr
,Col_extTipoBonif5 	 Out extTipoBonif5_arr
,Col_extCopago5 	 Out extCopago5_arr
);
-- Fin Coptran

End Vidvalorvari_Pkg;

74 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
