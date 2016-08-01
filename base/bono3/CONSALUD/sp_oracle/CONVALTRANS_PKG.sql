
SQL*Plus: Release 11.2.0.3.0 Production on Mon Jun 1 18:05:39 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONVALTRANS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_NEXTFOLIOFINANCIADOR	NUMBER			IN
 IN_VEXTACCION			VARCHAR2		IN
 IN_VEXTPREGUNTA		VARCHAR2		IN
 OUT_VEXTRESPUESTA		VARCHAR2		OUT
 OUT_VEXTCODERROR		VARCHAR2		OUT
 OUT_VEXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Convaltrans_Pkg
AS
  PROCEDURE Convaltrans
   			 (
   			  SRV_Message 		  			IN OUT VARCHAR2  --(1)
   		    , In_nExtCodFinanciador	   	IN 	   NUMBER	 --(2)
			, In_nExtFolioFinanciador		IN 	   NUMBER	 --(3)
			, In_vExtAccion					IN 	   VARCHAR	 --(4)
			, In_vExtPregunta				IN 	   VARCHAR	 --(5)
			, Out_vExtRespuesta				OUT    VARCHAR	 --(6)
			, Out_vExtCodError				OUT    VARCHAR	 --(7)
			, Out_vExtMensajeError			OUT    VARCHAR	 --(8)

			 );
  END Convaltrans_Pkg;


16 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
