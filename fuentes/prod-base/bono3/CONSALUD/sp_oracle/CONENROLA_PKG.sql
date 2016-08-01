
SQL*Plus: Release 11.2.0.3.0 Production on Tue Mar 10 12:46:26 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONENROLA
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTRUTENROLAR		VARCHAR2		IN
 IN_VEXTRUTBENEFICIARIO 	VARCHAR2		IN
 OUT_VEXTVALIDO 		VARCHAR2		OUT
 OUT_VEXTNOMBRECOMP		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Conenrola_Pkg
AS
PROCEDURE Conenrola
   		  (
   			 SRV_Message 		  			IN OUT VARCHAR2    	--(1)
   		  , In_nExtCodFinanciador		IN 	   NUMBER	    --(2)
		  ,	In_vExtRutEnrolar				IN     VARCHAR2     --(3)
		  ,	In_vExtRutBeneficiario			IN     VARCHAR	   	--(4)
		  ,	Out_vExtValido					OUT    VARCHAR	  	--(5)
		  ,	Out_vExtNombreComp				OUT    VARCHAR	   	--(6)
		  );
END Conenrola_Pkg;



14 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
