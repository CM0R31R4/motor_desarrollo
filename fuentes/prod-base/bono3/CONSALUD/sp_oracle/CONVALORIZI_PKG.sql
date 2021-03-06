
SQL*Plus: Release 11.2.0.3.0 Production on Tue Mar 10 12:46:28 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONVALORIZI
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTHOMNUMEROCONVENIO	VARCHAR2		IN
 IN_VEXTHOMLUGARCONVENIO	VARCHAR2		IN
 IN_VEXTSUCVENTA		VARCHAR2		IN
 IN_VEXTRUTCONVENIO		VARCHAR2		IN
 IN_VEXTRUTTRATANTE		VARCHAR2		IN
 IN_VEXTESPECIALIDAD		VARCHAR2		IN
 IN_VEXTRUTSOLICITANTE		VARCHAR2		IN
 IN_VEXTRUTBENEFICIARIO 	VARCHAR2		IN
 IN_VEXTTRATAMIENTO		VARCHAR2		IN
 IN_VEXTCODIGODIAGNOSTICO	VARCHAR2		IN
 IN_NEXTNIVELCONVENIO		NUMBER			IN
 IN_VEXTURGENCIA		VARCHAR2		IN
 IN_VEXTLISTA1			VARCHAR2		IN
 IN_VEXTLISTA2			VARCHAR2		IN
 IN_VEXTLISTA3			VARCHAR2		IN
 IN_VEXTLISTA4			VARCHAR2		IN
 IN_VEXTLISTA5			VARCHAR2		IN
 IN_VEXTLISTA6			VARCHAR2		IN
 IN_NEXTNUMPRESTACIONES 	NUMBER			IN
 OUT_VEXTCODERROR		VARCHAR2		OUT
 OUT_VEXTMENSAJEERROR		VARCHAR2		OUT
 OUT_VEXTPLAN			VARCHAR2		OUT
 OUT_VEXTGLOSA1 		VARCHAR2		OUT
 OUT_VEXTGLOSA2 		VARCHAR2		OUT
 OUT_VEXTGLOSA3 		VARCHAR2		OUT
 OUT_VEXTGLOSA4 		VARCHAR2		OUT
 OUT_VEXTGLOSA5 		VARCHAR2		OUT
 COL_NEXTVALORPRESTACION	TABLE OF NUMBER(12)	OUT
 COL_NEXTAPORTEFINANCIADOR	TABLE OF NUMBER(12)	OUT
 COL_NEXTCOPAGO 		TABLE OF NUMBER(12)	OUT
 COL_VEXTINTERNOLSA		TABLE OF VARCHAR2(15)	OUT
 COL_NEXTTIPOBONIF1		TABLE OF NUMBER(1)	OUT
 COL_NEXTCOPAGO1		TABLE OF NUMBER(12)	OUT
 COL_NEXTTIPOBONIF2		TABLE OF NUMBER(1)	OUT
 COL_NEXTCOPAGO2		TABLE OF NUMBER(12)	OUT
 COL_NEXTTIPOBONIF3		TABLE OF NUMBER(1)	OUT
 COL_NEXTCOPAGO3		TABLE OF NUMBER(12)	OUT
 COL_NEXTTIPOBONIF4		TABLE OF NUMBER(1)	OUT
 COL_NEXTCOPAGO4		TABLE OF NUMBER(12)	OUT
 COL_NEXTTIPOBONIF5		TABLE OF NUMBER(1)	OUT
 COL_NEXTCOPAGO5		TABLE OF NUMBER(12)	OUT
FUNCTION EMBE_REDONDEO RETURNS NUMBER
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 N_VALOR_I			NUMBER			IN

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Convalorizi_Pkg
AS
  vn_NUMERO_ERROR NUMBER;--ctc

  --EACE 28-06-2005 GES
  TYPE CurnExtCodigo_Prestacion_arr IS TABLE OF    NUMBER(12)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtES_GES_arr IS TABLE OF	VARCHAR2(1)
    INDEX BY BINARY_INTEGER;
  --EACE 28-06-2005 GES


  TYPE CurnExtValorPrestacion_arr IS TABLE OF	 NUMBER(12)
    INDEX BY BINARY_INTEGER;

  TYPE CurnExtAporteFinanciador_arr IS TABLE OF  NUMBER(12)
    INDEX BY BINARY_INTEGER;

  TYPE CurnExtCopago_arr IS TABLE OF   		 	 NUMBER(12)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtInternolsa_arr IS TABLE OF  		 VARCHAR2(15)
    INDEX BY BINARY_INTEGER;

  TYPE CurnExtTipoBonif1_arr IS TABLE OF  		 NUMBER(1)
    INDEX BY BINARY_INTEGER;

  TYPE CurnExtCopago1_arr IS TABLE OF  			 NUMBER(12)
    INDEX BY BINARY_INTEGER;

  TYPE CurnExtTipoBonif2_arr IS TABLE OF  		 NUMBER(1)
    INDEX BY BINARY_INTEGER;

  TYPE CurnExtCopago2_arr IS TABLE OF  			 NUMBER(12)
    INDEX BY BINARY_INTEGER;

  TYPE CurnExtTipoBonif3_arr IS TABLE OF  		 NUMBER(1)
    INDEX BY BINARY_INTEGER;

  TYPE CurnExtCopago3_arr IS TABLE OF  			 NUMBER(12)
    INDEX BY BINARY_INTEGER;

  TYPE CurnExtTipoBonif4_arr IS TABLE OF  		 NUMBER(1)
    INDEX BY BINARY_INTEGER;

  TYPE CurnExtCopago4_arr IS TABLE OF  			 NUMBER(12)
    INDEX BY BINARY_INTEGER;

  TYPE CurnExtTipoBonif5_arr IS TABLE OF  		 NUMBER(1)
    INDEX BY BINARY_INTEGER;

  TYPE CurnExtCopago5_arr IS TABLE OF  			 NUMBER(12)
    INDEX BY BINARY_INTEGER;

   PROCEDURE CONValorizI
   			 (
   			   SRV_Message 		  			 	  IN OUT VARCHAR2 --(1)
			 , In_nExtCodFinanciador	  		  IN 	 NUMBER	  --(2)
   			 , In_vExtHomNumeroConvenio			  IN 	 VARCHAR2 --(3)
			 , In_vExtHomLugarConvenio			  IN 	 VARCHAR2 --(4)
			 , In_vExtSucVenta 					  IN 	 VARCHAR2 --(5)
			 , In_vExtRutConvenio 				  IN 	 VARCHAR2 --(6)
			 , In_vExtRutTratante 				  IN 	 VARCHAR2 --(7)
			 , In_vExtEspecialidad 				  IN 	 VARCHAR2 --(8)
			 , In_vExtRutSolicitante  			  IN 	 VARCHAR2 --(9)
			 , In_vExtRutbeneficiario 			  IN 	 VARCHAR2 --(10)
			 , In_vExtTratamiento				  IN 	 VARCHAR2 --(11)
			 , In_vExtCodigoDiagnostico			  IN 	 VARCHAR2 --(12)
			 , In_nExtNivelConvenio				  IN 	 NUMBER	  --(13)
			 , In_vExtUrgencia					  IN 	 VARCHAR2 --(14)
			 , In_vExtLista1					  IN 	 VARCHAR2 --(15)
			 , In_vExtLista2					  IN 	 VARCHAR2 --(16)
			 , In_vExtLista3					  IN 	 VARCHAR2 --(17)
			 , In_vExtLista4					  IN 	 VARCHAR2 --(18)
			 , In_vExtLista5					  IN 	 VARCHAR2 --(19)
			 , In_vExtLista6					  IN 	 VARCHAR2 --(20)
			 , In_nExtNumPrestaciones			  IN 	 NUMBER   --(21)
	     , Out_vExtCodError					  OUT 	 VARCHAR2 --(22)
	     , Out_vExtMensajeError				  OUT 	 VARCHAR2 --(23)
	     , Out_vExtPlan						  OUT 	 VARCHAR2 --(24)
	     , Out_vExtGlosa1					  OUT 	 VARCHAR2 --(25)
	     , Out_vExtGlosa2					  OUT 	 VARCHAR2 --(26)
	     , Out_vExtGlosa3					  OUT 	 VARCHAR2 --(27)
	     , Out_vExtGlosa4					  OUT 	 VARCHAR2 --(28)
	     , Out_vExtGlosa5					  OUT 	 VARCHAR2 --(29)
	     , Col_nExtValorPrestacion			  OUT 	 CurnExtValorPrestacion_arr   --(30)
	     , Col_nExtAporteFinanciador		  OUT 	 CurnExtAporteFinanciador_arr	  --(31)
	     , Col_nExtCopago					  OUT 	 CurnExtCopago_arr	  --(32)
	     , Col_vExtInternolsa				  OUT 	 CurvExtInternolsa_arr --(33)
	     , Col_nExtTipoBonif1				  OUT 	 CurnExtTipoBonif1_arr	 --(34)
	     , Col_nExtCopago1					  OUT 	 CurnExtCopago1_arr   --(35)
	     , Col_nExtTipoBonif2				  OUT 	 CurnExtTipoBonif2_arr	 --(36)
	     , Col_nExtCopago2					  OUT 	 CurnExtCopago2_arr	  --(37)
	     , Col_nExtTipoBonif3				  OUT 	 CurnExtTipoBonif3_arr	 --(38)
	     , Col_nExtCopago3					  OUT 	 CurnExtCopago3_arr   --(39)
	     , Col_nExtTipoBonif4				  OUT 	 CurnExtTipoBonif4_arr	 --(40)
	     , Col_nExtCopago4					  OUT 	 CurnExtCopago4_arr   --(41)
	     , Col_nExtTipoBonif5				  OUT 	 CurnExtTipoBonif5_arr	 --(42)
	     , Col_nExtCopago5					  OUT 	 CurnExtCopago5_arr   --(43)
	     );

			 FUNCTION embe_redondeo(n_valor_i IN NUMBER) RETURN NUMBER;
--
--

END Convalorizi_Pkg;



109 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
