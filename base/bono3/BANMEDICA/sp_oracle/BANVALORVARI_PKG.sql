
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 5 18:34:32 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> PROCEDURE BANVALORVARI
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
 COL_EXTVALORPRESTACION 	TABLE OF NUMBER(12)	OUT
 COL_EXTAPORTEFINANCIADOR	TABLE OF NUMBER(12)	OUT
 COL_EXTCOPAGO			TABLE OF NUMBER(12)	OUT
 COL_EXTINTERNOISA		TABLE OF VARCHAR2(15)	OUT
 COL_EXTTIPOBONIF1		TABLE OF NUMBER(2)	OUT
 COL_EXTCOPAGO1 		TABLE OF NUMBER(12)	OUT
 COL_EXTTIPOBONIF2		TABLE OF NUMBER(2)	OUT
 COL_EXTCOPAGO2 		TABLE OF NUMBER(12)	OUT
 COL_EXTTIPOBONIF3		TABLE OF NUMBER(2)	OUT
 COL_EXTCOPAGO3 		TABLE OF NUMBER(12)	OUT
 COL_EXTTIPOBONIF4		TABLE OF NUMBER(2)	OUT
 COL_EXTCOPAGO4 		TABLE OF NUMBER(12)	OUT
 COL_EXTTIPOBONIF5		TABLE OF NUMBER(2)	OUT
 COL_EXTCOPAGO5 		TABLE OF NUMBER(12)	OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	   Banvalorvari_Pkg IS

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
Procedure BanValorVari(
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
-- Fin

End Banvalorvari_Pkg;

74 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
