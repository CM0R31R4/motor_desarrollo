
SQL*Plus: Release 11.2.0.3.0 Production on Wed Mar 5 19:00:01 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
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

15 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     Consolicfolios_Pkg
AS

PROCEDURE Consolicfolios
   			 (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nExtCodFinanciador	  	IN 	   NUMBER
		   , In_nExtNumFolios				IN 	   NUMBER
		   , Out_vExtCodError				OUT	   VARCHAR2
		   , Out_vExtMensajeError			OUT	   VARCHAR2
		   , Col_nExtFoliosDevueltos		OUT	   CurnExtFoliosDevueltos_arr
			 )

IS
v_vNomTrans				   	VARCHAR2(50):= UPPER('Consolicfolios_Pkg');

v_vEntrada_Format			VARCHAR2(2000);
v_vSalida_Format			VARCHAR2(2000);
v_sep_ES	   				VARCHAR2(1):=';';
Out_vReturnStatus			VARCHAR2(1);
Out_vMessageCode 			VARCHAR2(5);
Out_vMessageText			VARCHAR2(243);
SRV_FetchStatus				NUMBER(1) := '0';
SRV_Total_Rows				NUMBER(8);
SRV_Row_Count				NUMBER(8);
v_vCarIniMessageText		VARCHAR2(1):='X'; -- Para diferenciar Out_vMessageText
											  -- de Out_vExtMensajeError
-- Codigo de la Isapre para validar contra entrada
v_nCod_Isa_Cons  		   	NUMBER	:=71;

isapre_no_corresponde	   	EXCEPTION;
max_filas_salida			EXCEPTION;
-----------------------------------------------------

v_vSeparador			    VARCHAR2(1):='|';
v_nExtCodFinanciador  	    NUMBER(3);
v_nExtNumFolios 		    NUMBER(3);

v_vExtCodError			    VARCHAR2(1);
v_vMensajeError			    VARCHAR2(30);
v_vFoliosDevueltos		    VARCHAR2(2000);

v_nNumDoc				    NUMBER(10);

FUNCTION SETEA_ENTRADA
RETURN VARCHAR2
IS
v_vEntrada			   VARCHAR2(2000);
BEGIN
v_vEntrada	:=  SUBSTR(SUBSTR(SRV_Message,1,256)||v_sep_ES||
				TO_CHAR(In_nExtCodFinanciador)||v_sep_ES||
			    In_nExtNumFolios||v_sep_ES,1,2000);
RETURN v_vEntrada;
END;


FUNCTION SETEA_SALIDA
RETURN VARCHAR2
IS
v_vSalida	   VARCHAR2(2000);

BEGIN

v_vSalida:=  SUBSTR(SRV_Message||v_sep_ES||
			 Out_vExtCodError||v_sep_ES||
			 Out_vExtMensajeError||v_sep_ES,1,2000);

FOR i IN 1 ..Col_nExtFoliosDevueltos.COUNT LOOP
v_vSalida := v_vSalida ||Col_nExtFoliosDevueltos(i)||v_sep_ES;
END LOOP;

RETURN v_vSalida;
END;

PROCEDURE LIMPIA
AS
BEGIN
  SRV_FetchStatus := '0';
  Col_nExtFoliosDevueltos.DELETE;
  Col_nExtFoliosDevueltos(1):= 0;
END;

BEGIN
  v_vFoliosDevueltos :=NULL;
  v_nExtCodFinanciador	:= In_nExtCodFinanciador;

  IF ( v_nExtcodfinanciador != v_ncod_isa_cons )
  THEN
    RAISE isapre_no_corresponde;
  END IF;

  v_nExtNumFolios := In_nExtNumFolios;
  SRV_Total_Rows  := TO_NUMBER(RTRIM(SRV_Message));

  FOR i IN 1..v_nExtNumFolios LOOP
   IF i > SRV_Total_Rows THEN
   	  RAISE max_filas_salida;
   END IF;

   SRV_FetchStatus := '1';

   SELECT imed_doli_seq.NEXTVAL INTO v_nNumDoc FROM dual;
   Col_nExtFoliosDevueltos(i) := v_nNumDoc;

  END LOOP;

  IF   Col_nExtFoliosDevueltos.COUNT = 0 THEN
    Col_nExtFoliosDevueltos(1):=0;
  END IF;

  Out_vExtCodError     := 'S';
  Out_vExtMensajeError := 'Servicio Correcto';
  Out_vReturnStatus	   := '1';
  Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
  Out_vMessageCode 	   := '00000';--'38001';
  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
  RETURN;
EXCEPTION

WHEN isapre_no_corresponde THEN
		  LIMPIA;
		  Out_vExtCodError     := 'N';
		  Out_vExtMensajeError := RPAD('Codigo isapre no corresponde',30);
--	  	  Out_vReturnStatus	   := '0';
	  	  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
--	  	  Out_vMessageCode 	   := '78001';
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
  		  RETURN;

WHEN max_filas_salida THEN
		  LIMPIA;
		  Out_vExtCodError     := 'N';
		  Out_vExtMensajeError := RPAD('Supera numero maximo de registros a devolver',30);
--	  	  Out_vReturnStatus	   := '0';
	  	  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
--	  	  Out_vMessageCode 	   := '78002';
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
  		  RETURN;
WHEN OTHERS THEN
		  LIMPIA;
		  Out_vExtCodError     := 'N';
		  Out_vExtMensajeError := RPAD('ERROR PROC.:'||v_vNomTrans,30);
--	  	  Out_vReturnStatus	   := '0';
		  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
--	  	  Out_vMessageCode 	   := '78050';
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
RETURN;

END;
END Consolicfolios_Pkg;

156 rows selected.

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
