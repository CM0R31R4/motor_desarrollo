
SQL*Plus: Release 11.2.0.3.0 Production on Mon Jun 1 18:05:36 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONMENSAJEBEN
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTRUTBENEFICIARIO 	VARCHAR2		IN
 OUT_NEXTTIPOACCION		NUMBER			OUT
 OUT_VEXTMSGERROR1		VARCHAR2		OUT
 OUT_VEXTMSGERROR2		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE Conmensajeben_Pkg AS

	PROCEDURE Conmensajeben (    SRV_Message 		  			IN OUT VARCHAR2
					   		   , In_nExtCodFinanciador	  	IN 	   NUMBER
							   , In_vExtRutBeneficiario			IN 	   VARCHAR2
							   , Out_nExtTipoAccion				OUT	   NUMBER
							   , Out_vExtMsgError1				OUT	   VARCHAR2
							   , Out_vExtMsgError2				OUT	   VARCHAR2
							    );
END Conmensajeben_Pkg;



12 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
