
SQL*Plus: Release 11.2.0.3.0 Production on Tue Jun 18 17:39:19 2013

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> 
TEXT
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	   Banleerutcotiz_Pkg IS
TYPE extCorrBenef_arr 		IS TABLE OF NUMBER(3) 	 INDEX BY BINARY_INTEGER;
TYPE extRutBeneficiario_arr	IS TABLE OF VARCHAR2(12) INDEX BY BINARY_INTEGER;
TYPE extApellidoPat_arr 	IS TABLE OF VARCHAR2(30) INDEX BY BINARY_INTEGER;
TYPE extApellidoMat_arr 	IS TABLE OF VARCHAR2(30) INDEX BY BINARY_INTEGER;
TYPE extNombres_arr   		IS TABLE OF VARCHAR2(40) INDEX BY BINARY_INTEGER;
TYPE extCodEstBen_arr 		IS TABLE OF VARCHAR2(1)  INDEX BY BINARY_INTEGER;
TYPE extDescEstado_arr 		IS TABLE OF VARCHAR2(15) INDEX BY BINARY_INTEGER;

PROCEDURE BanLeeRutCotiz  (
	  srv_message  IN OUT VARCHAR2,
	  iCodFinanciador     NUMBER,
	  iRut_Cotizante      VARCHAR2,
	  oNomCotizante   OUT VARCHAR2,
	  oCodError	  OUT VARCHAR2,
	  oMensajeError   OUT VARCHAR2,
	  extCorrBenef	     	OUT extCorrBenef_arr,
	  extRutBeneficiario 	OUT extRutBeneficiario_arr,
	  extApellidoPat  	OUT extApellidoPat_arr,
	  extApellidoMat  	OUT extApellidoMat_arr,
	  extNombres	  	OUT extNombres_arr,
	  extCodEstBen	  	OUT extCodEstBen_arr,
	  extDescEstado 	OUT extDescEstado_arr
 );

END Banleerutcotiz_Pkg;

26 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
