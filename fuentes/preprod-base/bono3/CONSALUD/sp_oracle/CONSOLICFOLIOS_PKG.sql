
SQL*Plus: Release 11.2.0.3.0 Production on Tue Mar 10 12:46:27 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONSOLICFOLIOS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_NEXTNUMFOLIOS		NUMBER			IN
 OUT_VEXTCODERROR		VARCHAR2		OUT
 OUT_VEXTMENSAJEERROR		VARCHAR2		OUT
 COL_NEXTFOLIOSDEVUELTOS	TABLE OF NUMBER(10)	OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Consolicfolios_Pkg
AS
  TYPE CurnExtFoliosDevueltos_arr IS TABLE OF NUMBER(10)
    INDEX BY BINARY_INTEGER;

   PROCEDURE Consolicfolios
   			 (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nExtCodFinanciador	  	IN 	   NUMBER
		   , In_nExtNumFolios				IN 	   NUMBER
		   , Out_vExtCodError				OUT	   VARCHAR2
		   , Out_vExtMensajeError			OUT	   VARCHAR2
		   , Col_nExtFoliosDevueltos		OUT	   CurnExtFoliosDevueltos_arr
			 );
END Consolicfolios_Pkg;


16 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
