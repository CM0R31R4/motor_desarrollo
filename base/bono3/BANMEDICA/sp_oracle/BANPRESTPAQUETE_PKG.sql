
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 5 18:34:31 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production

SQL> SQL> PROCEDURE BANPRESTPAQUETE
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 EXTCODFINANCIADOR		NUMBER			IN
 EXTHOMNUMEROCONVENIO		VARCHAR2		IN
 EXTHOMLUGARCONVENIO		VARCHAR2		IN
 EXTCODPAQUETE			VARCHAR2		IN
 EXTCODERROR			VARCHAR2		OUT
 EXTMENSAJEERROR		VARCHAR2		OUT
 EXTCODHOMOLOGO 		TABLE OF VARCHAR2(10)	OUT
 EXTITEMHOMOLOGO		TABLE OF VARCHAR2(2)	OUT
 EXTCANTIDAD			TABLE OF NUMBER(5)	OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE Banprestpaquete_Pkg IS
/****************************************************************************************************
   NOMBRE:	 BANPRESTPAQUETE_PKG
   PROPOSITO:	 Obtiene el detalle de las prestaciones que componen un paquete de prestaciones

   REVISIONES:
   Ver	      Fecha	   Autor	    Description
   ---------  ----------  ---------------  ------------------------------------
   1.0	      27/10/2003    dam 	   1. Creacion del package
***************************************************************************************************/
TYPE extCodHomologo_arr IS TABLE OF VARCHAR2(10) INDEX BY BINARY_INTEGER;
TYPE extItemHomologo_arr IS TABLE OF VARCHAR2(02) INDEX BY BINARY_INTEGER;
TYPE extCantidad_arr IS TABLE OF NUMBER(5) INDEX BY BINARY_INTEGER;

PROCEDURE BANPRESTPAQUETE (
	  srv_message		IN OUT VARCHAR2,
	  extCodFinanciador	IN  NUMBER,
		  extHomNumeroConvenio 	IN  VARCHAR2,
		  extHomLugarConvenio 	IN  VARCHAR2,
		  extCodPaquete 	IN  VARCHAR2,
		  extCodError			OUT VARCHAR2,	   -- N->error o S->no hay error
		  extMensajeError		OUT VARCHAR2,
		  extCodHomologo	OUT extCodHomologo_arr,
		  extItemHomologo	OUT extItemHomologo_arr,
		  extCantidad		OUT extCantidad_arr
);

END Banprestpaquete_Pkg;

28 rows selected.

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
