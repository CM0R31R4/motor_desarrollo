
SQL*Plus: Release 11.2.0.3.0 Production on Tue Mar 10 12:46:27 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONLEERUTCOTIZ
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTRUTCOTIZANTE		VARCHAR2		IN
 OUT_VEXTNOMCOTIZANTE		VARCHAR2		OUT
 OUT_VEXTCODERROR		VARCHAR2		OUT
 OUT_VEXTMENSAJEERROR		VARCHAR2		OUT
 COL_NEXTCORRBENEF		TABLE OF NUMBER(3)	OUT
 COL_VEXTRUTBENEFICIARIO	TABLE OF VARCHAR2(12)	OUT
 COL_VEXTAPELLIDOPAT		TABLE OF VARCHAR2(30)	OUT
 COL_VEXTAPELLIDOMAT		TABLE OF VARCHAR2(30)	OUT
 COL_VEXTNOMBRES		TABLE OF VARCHAR2(40)	OUT
 COL_VEXTCODESTBEN		TABLE OF VARCHAR2(1)	OUT
 COL_VEXTDESCESTADO		TABLE OF VARCHAR2(15)	OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Conleerutcotiz_Pkg
AS
  TYPE CurnExtCorrBenef_arr IS TABLE OF NUMBER(3)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtRutBeneficiario_arr IS TABLE OF VARCHAR2(12)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtApellidoPat_arr	  IS TABLE OF VARCHAR2(30)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtApellidoMat_arr	  IS TABLE OF VARCHAR2(30)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtNombres_arr  		  IS TABLE OF VARCHAR2(40)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtCodEstBen_arr  	  IS TABLE OF VARCHAR2(1)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtDescEstado_arr	  IS TABLE OF VARCHAR2(15)
    INDEX BY BINARY_INTEGER;


   PROCEDURE Conleerutcotiz
   (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nextCodFinanciador	 	IN 	   NUMBER
		   , In_vextRutCotizante			IN 	   VARCHAR2
		   , Out_vextNomCotizante	   	OUT    VARCHAR2
		   , Out_vextCodError		 	OUT	   VARCHAR2
	   , Out_vextMensajeError			OUT	   VARCHAR2
	   , Col_nExtCorrBenef				OUT    CurnExtCorrBenef_arr
	   , Col_vExtRutBeneficiario		OUT    CurvExtRutBeneficiario_arr
	   , Col_vExtApellidoPat			OUT    CurvExtApellidoPat_arr
	   , Col_vExtApellidoMat			OUT    CurvExtApellidoMat_arr
	   , Col_vExtNombres				OUT    CurvExtNombres_arr
		   , Col_vExtCodEstBen				OUT    CurvExtCodEstBen_arr
   		   , Col_vExtDescEstado				OUT    CurvExtDescEstado_arr
   );
END Conleerutcotiz_Pkg;


42 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
