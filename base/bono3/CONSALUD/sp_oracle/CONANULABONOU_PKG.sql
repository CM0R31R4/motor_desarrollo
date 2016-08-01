
SQL*Plus: Release 11.2.0.3.0 Production on Mon Jun 1 18:05:35 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONANULABONOU
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_NEXTFOLIOBONO		NUMBER			IN
 IN_VEXTINDTRATAM		VARCHAR2		IN
 IN_VEXTFECTRATAM		VARCHAR2		IN
 OUT_VEXTCODERROR		VARCHAR2		OUT
 OUT_VEXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Conanulabonou_Pkg
AS
   PROCEDURE Conanulabonou
   			 (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nExtCodFinanciador	 	IN 	   NUMBER
		   , In_nExtFolioBono				IN	   NUMBER
		   , In_vExtIndTratam				IN	   VARCHAR2
		   , In_vExtFecTratam				IN	   VARCHAR2
		   , Out_vExtCodError				OUT	   VARCHAR2
		   , Out_vExtMensajeError			OUT	   VARCHAR2

			 );
END Conanulabonou_Pkg;



16 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
