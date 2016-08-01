
SQL*Plus: Release 11.2.0.3.0 Production on Thu Aug 8 19:33:22 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.4.0 - Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	CHULeeRutCotiz_Pkg As
  TYPE Out_extCorrBenef_arr IS TABLE OF Number(3)
    INDEX BY BINARY_INTEGER;
  TYPE Out_extRutBeneficiario_arr IS TABLE OF Varchar2(12)
    INDEX BY BINARY_INTEGER;
  TYPE Out_extApellidoPat_arr IS TABLE OF Varchar2(30)
    INDEX BY BINARY_INTEGER;
  TYPE Out_extApellidoMat_arr IS TABLE OF Varchar2(30)
    INDEX BY BINARY_INTEGER;
  TYPE Out_extNombres_arr IS TABLE OF Varchar2(40)
    INDEX BY BINARY_INTEGER;
  TYPE Out_extCodEstBen_arr IS TABLE OF Varchar2(1)
    INDEX BY BINARY_INTEGER;
  TYPE Out_extDescEstado_arr IS TABLE OF Varchar2(15)
    INDEX BY BINARY_INTEGER;
		Procedure CHULeeRutCotiz  /*  Beneficiarios asociados al Titular, Fundacion  */
     ( SRV_Message		      In Out	 Varchar2,
	  In_extCodFinanciador 	  		 In	    Varchar2			    /*	Codigo de Isapre Fundacion 076 */
    , In_extRutCotizante			 In	    Varchar2			    /*	Rut del beneficiario (Certificacion)  */
    , Out_extNomCotizante			 Out	    Varchar2			    /*	Nombre Completo */
    , Out_extCodError				 Out	    Varchar2			    /*	S o N  */
    , Out_extMensajeError			 Out	    Varchar2			    /*	Descripcion del Error */
    , Out_extCorrBenef				 Out	    Out_extCorrBenef_arr       /*  Correlativo */
    , Out_extRutBeneficiario		 Out	    Out_extRutBeneficiario_arr /*  Rut Carga */
    , Out_extApellidoPat			 Out	    Out_extApellidoPat_arr     /*  Ap Pat Carga */
    , Out_extApellidoMat	     Out	Out_extApellidoMat_arr	   /*  Ap Mat Carga */
    , Out_extNombres				 Out	    Out_extNombres_arr		/*  Nombres Carga */
    , Out_extCodEstBen		     Out	Out_extCodEstBen_arr	   /*  Codigo de estado Carga */
    , Out_extDescEstado 	     Out	Out_extDescEstado_arr	   /*  Descripcion estado Carga  */
    ) ;

	end CHULeeRutCotiz_pkg;

32 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.4.0 - Production
