
SQL*Plus: Release 11.2.0.3.0 Production on Tue Mar 10 12:46:27 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONINFENROLA
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTRUTBENEFICIARIO 	VARCHAR2		IN
 IN_VEXTRUTACOMPANANTE		VARCHAR2		IN
 IN_VEXTINDENROLA		NUMBER			IN
 OUT_VEXTCODERROR		VARCHAR2		OUT
 OUT_VEXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Coninfenrola_Pkg
AS

   PROCEDURE Coninfenrola
   			(
   			 SRV_Message 		  			IN OUT VARCHAR2    	--(1)
   		  , In_nExtCodFinanciador		IN 	   NUMBER	    --(2)
		  ,	In_vExtRutBeneficiario			IN     VARCHAR2	   	--(3)
		  ,	In_vExtRutAcompanante			IN     VARCHAR2	   	--(4)
		  ,	In_vExtIndEnrola				IN     NUMBER	  	--(5)
		  ,	Out_vExtCodError				OUT    VARCHAR	  	--(6)
		  ,	Out_vExtMensajeError			OUT    VARCHAR	   	--(7)

			);
END Coninfenrola_Pkg;


16 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
