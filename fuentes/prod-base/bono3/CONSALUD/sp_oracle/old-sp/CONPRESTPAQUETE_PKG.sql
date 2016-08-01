
SQL*Plus: Release 11.2.0.3.0 Production on Thu Apr 10 13:08:57 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONPRESTPAQUETE
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTHOMNUMEROCONVENIO	VARCHAR2		IN
 IN_VEXTHOMLUGARCONVENIO	VARCHAR2		IN
 IN_VEXTCODPAQUETE		VARCHAR2		IN
 OUT_VEXTCODERROR		VARCHAR2		OUT
 OUT_VEXTMENSAJEERROR		VARCHAR2		OUT
 COL_VEXTCODHOMOLOGO		TABLE OF VARCHAR2(12)	OUT
 COL_VEXTITEMHOMOLOGO		TABLE OF VARCHAR2(12)	OUT
 COL_VEXTCANTIDAD		TABLE OF NUMBER(5)	OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE Conprestpaquete_Pkg
AS
  TYPE vCursor IS REF CURSOR;
  TYPE CurvExtCodHomologo_arr IS TABLE OF VARCHAR2(12)
    INDEX BY BINARY_INTEGER;
  TYPE CurvExtItemHomologo_arr IS TABLE OF VARCHAR2(12)
    INDEX BY BINARY_INTEGER;
  TYPE CurvExtCantidad_arr IS TABLE OF NUMBER(5)
    INDEX BY BINARY_INTEGER;
   PROCEDURE Conprestpaquete
   			 (
			  SRV_Message 		  			     IN OUT VARCHAR2
		    , In_nExtCodFinanciador				 IN		NUMBER
			, In_vExtHomNumeroConvenio			 IN  	VARCHAR2
			, In_vExtHomLugarConvenio			 IN  	VARCHAR2
			, In_vExtCodPaquete					 IN  	VARCHAR2
			, Out_vExtCodError					 OUT	VARCHAR2
			, Out_vExtMensajeError				 OUT	VARCHAR2
			, Col_vExtCodHomologo				 OUT 	CurvExtCodHomologo_arr
			, Col_vExtItemHomologo				 OUT	CurvExtItemHomologo_arr
			, Col_vExtCantidad					 OUT 	CurvExtCantidad_arr
			 );
END Conprestpaquete_Pkg;



25 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
