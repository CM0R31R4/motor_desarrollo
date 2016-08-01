
SQL*Plus: Release 11.2.0.3.0 Production on Tue Mar 10 12:46:26 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONDATOSPREST
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTRUTCONVENIO		VARCHAR2		IN
 IN_VEXTCODIGOSUCUR		VARCHAR2		IN
 OUT_VEXTESTCONVENIO		VARCHAR2		OUT
 OUT_NEXTNIVEL			NUMBER			OUT
 OUT_VEXTTIPOPRESTADOR		VARCHAR2		OUT
 OUT_VEXTCODESPECIALIDADES	VARCHAR2		OUT
 OUT_VEXTCODPROFESIONES 	VARCHAR2		OUT
 OUT_VEXTANOSANTIGUEDAD 	VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Condatosprest_Pkg
AS
   PROCEDURE Condatosprest
   			 (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nExtCodFinanciador	 	IN 	   NUMBER
		   , In_vExtRutConvenio				IN 	   VARCHAR
		   , In_vExtCodigoSucur				IN 	   VARCHAR
		   , Out_vExtEstConvenio			OUT    VARCHAR
		   , Out_nExtNivel					OUT    NUMBER
		   , Out_vExtTipoPrestador			OUT    VARCHAR
		   , Out_vextCodEspecialidades 		OUT    VARCHAR
		   , Out_vExtCodProfesiones			OUT    VARCHAR
		   , Out_vExtAnosAntiguedad			OUT    VARCHAR
			 );
END Condatosprest_Pkg;


17 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
