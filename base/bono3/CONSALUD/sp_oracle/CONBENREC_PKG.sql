
SQL*Plus: Release 11.2.0.3.0 Production on Mon Jun 1 18:05:36 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONBENREC
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTRUTCOTIZANTE		VARCHAR2		IN
 IN_NEXTCORRBENEF		NUMBER			IN
 IN_VEXTRUTBENEFICIARIO 	VARCHAR2		IN
 OUT_VEXTCODRESBEN		VARCHAR2		OUT
 OUT_VEXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Conbenrec_Pkg
AS
    PROCEDURE Conbenrec
     (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nextCodFinanciador	 	IN 	   NUMBER
		   , In_vextRutCotizante		IN 	   VARCHAR2
   		   , In_nextCorrBenef	       		IN 	   NUMBER
		   , In_vextRutBeneficiario			IN 	   VARCHAR2
   		   , Out_vextCodResBen				OUT	   VARCHAR2
   		   , Out_vextMensajeError			OUT	   VARCHAR2);

END Conbenrec_Pkg;



15 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
