
SQL*Plus: Release 11.2.0.3.0 Production on Tue Mar 10 12:46:25 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONBENCERTIF
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_NEXTRUTBENEFICIARIO 	VARCHAR2		IN
 IN_VEXTFECHAACTUAL		VARCHAR2		IN
 OUT_VEXTAPELLIDOPAT		VARCHAR2		OUT
 OUT_VEXTAPELLIDOMAT		VARCHAR2		OUT
 OUT_VEXTNOMBRES		VARCHAR2		OUT
 OUT_VEXTSEXO			VARCHAR2		OUT
 OUT_DEXTFECHANACIMI		VARCHAR2		OUT
 OUT_VEXTCODESTBEN		VARCHAR2		OUT
 OUT_VEXTDESCESTADO		VARCHAR2		OUT
 OUT_VEXTRUTCOTIZANTE		VARCHAR2		OUT
 OUT_VEXTNOMCOTIZANTE		VARCHAR2		OUT
 OUT_VEXTDIRPACIENTE		VARCHAR2		OUT
 OUT_VEXTGLOSACOMUNA		VARCHAR2		OUT
 OUT_VEXTGLOSACIUDAD		VARCHAR2		OUT
 OUT_VEXTPREVISION		VARCHAR2		OUT
 OUT_VEXTGLOSA			VARCHAR2		OUT
 OUT_VEXTPLAN			VARCHAR2		OUT
 OUT_VEXTDESCUENTOXPLANILLA	VARCHAR2		OUT
 OUT_NEXTMONTOEXCEDENTE 	NUMBER			OUT
 COL_VEXTRUTACOMPANANTE 	TABLE OF VARCHAR2(12)	OUT
 COL_VEXTNOMBREACOMPANANTE	TABLE OF VARCHAR2(40)	OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Conbencertif_Pkg
AS
  TYPE CurvExtRutAcompanante_arr IS TABLE OF VARCHAR2(12)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtNombreAcompanante_arr IS TABLE OF VARCHAR2(40)
    INDEX BY BINARY_INTEGER;

    TYPE cCURSOR  IS REF CURSOR;

   PROCEDURE Conbencertif
     (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nextCodFinanciador	 	IN 	   NUMBER
		   , In_nextRutBeneficiario	 	IN 	   VARCHAR2
   		   , In_vextFechaActual 	 	IN 	   VARCHAR2
   		   , Out_vextApellidoPat	  	OUT	   VARCHAR2
   		   , Out_vextApellidoMat	  	OUT    VARCHAR2
   		   , Out_vextNombres		  	OUT    VARCHAR2
   		   , Out_vextSexo		  	OUT	   VARCHAR2
   		   , Out_dextFechaNacimi	  	OUT	   VARCHAR2
		   , Out_vextCodEstBen		  	OUT	   VARCHAR2
	   , Out_vextDescEstado 	  	OUT	   VARCHAR2
	   , Out_vextRutCotizante	  	OUT    VARCHAR2
	   , Out_vextNomCotizante	   	OUT    VARCHAR2
	   , Out_vextDirPaciente	    OUT    VARCHAR2
	   , Out_vextGlosaComuna	    OUT    VARCHAR2
	   , Out_vextGlosaCiudad	    OUT    VARCHAR2
	   , Out_vextPrevision		  	OUT    VARCHAR2
	   , Out_vextGlosa		  	OUT    VARCHAR2
	   , Out_vextPlan		  	OUT    VARCHAR2
	   , Out_vextDescuentoxPlanilla   	OUT    VARCHAR2
	   , Out_nextMontoExcedente	  	OUT    NUMBER
	   , Col_vExtRutAcompanante	  	OUT    CurvExtRutAcompanante_arr
	   , Col_vExtNombreAcompanante	  	OUT    CurvExtNombreAcompanante_arr
   );

END Conbencertif_Pkg;



40 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
