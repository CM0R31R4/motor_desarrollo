
SQL*Plus: Release 11.2.0.3.0 Production on Wed Mar 5 19:00:01 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
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
PACKAGE 	Conprestpaquete_Pkg
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

23 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     Conprestpaquete_Pkg
AS
   PROCEDURE Conprestpaquete
   			 (
			  SRV_Message 		  			     IN OUT VARCHAR2 				--(1)
		    , In_nExtCodFinanciador				 IN		NUMBER 	 				--(2)
			, In_vExtHomNumeroConvenio			 IN  	VARCHAR2				--(3)
			, In_vExtHomLugarConvenio			 IN  	VARCHAR2				--(4)
			, In_vExtCodPaquete					 IN  	VARCHAR2				--(5)
			, Out_vExtCodError					 OUT	VARCHAR2				--(6)
			, Out_vExtMensajeError				 OUT	VARCHAR2				--(7)
			, Col_vExtCodHomologo				 OUT 	CurvExtCodHomologo_arr	--(8)
			, Col_vExtItemHomologo				 OUT	CurvExtItemHomologo_arr	--(9)
			, Col_vExtCantidad					 OUT 	CurvExtCantidad_arr		--(10)
			 )
IS
v_vNomTrans				   		   		    VARCHAR2(50):= UPPER('CONPRESTPAQUETE_PKG');
v_dExtFechaActual	   					DATE;
--w_fechor_llegada	     					DATE;
vd_Fecha_Salida 	  					DATE;
v_dFechor_Llegada							DATE;
v_nextrutbeneficiario	   					NUMBER ( 10 ):= NULL;
v_nRespuesta			 			NUMBER ( 1 ) := 0;
v_nFolio_Suscripcion	   			  		NUMBER:= NULL;
v_ncodigo_carga 	   					NUMBER;
--v_vEntrada_Format				 			VARCHAR2(2000);
--v_vSalida_Format							VARCHAR2(2000);
v_vEntrada_Format				 			VARCHAR2(2000);
v_vSalida_Format							VARCHAR2(2000);
v_sep_ES	   								VARCHAR2(1):=';';
Out_vReturnStatus							VARCHAR2(1);
Out_vMessageCode 						  	VARCHAR2(5);
Out_vMessageText							VARCHAR2(243);
SRV_FetchStatus								NUMBER(1) := '0'; -- No tiene variables tipo Column Output
SRV_Total_Rows								NUMBER(8);
SRV_Row_Count								NUMBER(8);
v_vCarIniMessageText						VARCHAR2(1):='X'; -- Para diferenciar Out_vMessageText
														  	  -- de Out_vExtMensajeError
-- Codigo de la Isapre para Validar contra entrada
v_nCod_Isa_Cons  		   	 	   	   	    NUMBER  :=71;
isapre_no_corresponde	   				    EXCEPTION;
paquete_corresponde							EXCEPTION;
v_nExtCodFinanciador	   		NUMBER(3);
v_vExtHomNumeroConvenio			VARCHAR2(15);
v_vExtHomLugarConvenio			VARCHAR2(10);
v_vExtCodPaquete				VARCHAR2(15);
v_nExtCodPaquete				NUMBER(15);
v_vExtCodError					VARCHAR2(1);
v_vExtMensajeError				VARCHAR2(30);
v_vExtCodHomologo				VARCHAR2(12);
v_vExtItemHomologo				VARCHAR2(12);
v_vExtCantidad					VARCHAR2(12);
v_vSeparador					VARCHAR2(1):='|';
cCursor vCursor;
PRESTACION			     		NUMBER(10);
DESCRIPCION_PRESTACION	 		VARCHAR2(60);
COMPONENTE				 		NUMBER;
DESCRIPCION_COMPONENTE	 		VARCHAR2(100);
CANTIDAD			     		NUMBER(10);
PRECIO				  	 		NUMBER(12);
DNP_CORRELATIVO			 		NUMBER(10);
NUMERO_INTERVENCION	 			NUMBER(4);
vn_Contador 					NUMBER(3):=0;
FUNCTION SETEA_ENTRADA
RETURN VARCHAR2
IS
v_vEntrada			   VARCHAR2(2000);
BEGIN
v_vEntrada	:=  SUBSTR(SUBSTR(SRV_Message,1,256)||v_sep_ES||
				TO_CHAR(NVL(In_nExtCodFinanciador,0))||v_sep_ES||
				In_vExtHomNumeroConvenio||v_sep_ES||
	   		    In_vExtHomLugarConvenio||v_sep_ES||
				In_vExtCodPaquete||v_sep_ES,1,2000);
RETURN v_vEntrada;
END;
FUNCTION SETEA_SALIDA
RETURN VARCHAR2
IS
v_vSalida	   VARCHAR2(2000);
BEGIN
v_vSalida:=  SUBSTR(SUBSTR(SRV_Message,1,256)||v_sep_ES||
			Out_vExtCodError||v_sep_ES||
			Out_vExtMensajeError||v_sep_ES,1,2000);
			FOR i IN 1 ..Col_vExtCodHomologo.COUNT LOOP
			v_vSalida := RTRIM(SUBSTR(v_vSalida ||Col_vExtCodHomologo(i)||v_sep_ES,1,2000));
			END LOOP;
			FOR i IN 1 ..Col_vExtItemHomologo.COUNT LOOP
			v_vSalida := RTRIM(SUBSTR(v_vSalida ||Col_vExtItemHomologo(i)||v_sep_ES,1,2000));
			END LOOP;
			FOR i IN 1 ..Col_vExtCantidad.COUNT LOOP
			v_vSalida := RTRIM(SUBSTR(v_vSalida ||Col_vExtCantidad(i)||v_sep_ES,1,2000));
			END LOOP;
RETURN v_vSalida;
END;
PROCEDURE LIMPIA
AS
BEGIN
  SRV_FetchStatus := '0';
  Col_vExtCodHomologo.DELETE;
  Col_vExtItemHomologo.DELETE;
  Col_vExtCantidad.DELETE;
--   Col_vExtCodHomologo(1) := ' ';
--   Col_vExtItemHomologo(1) := ' ';
--   Col_vExtCantidad(1) := ' ';
END;
BEGIN
	v_nExtCodFinanciador	   := In_nExtCodFinanciador;
	--v_nExtCodFinanciador	   := 71;
	v_dExtFechaActual:= TO_DATE(TO_CHAR(SYSDATE,'rrrr/mm/dd hh24:mi:ss'),'rrrr/mm/dd hh24:mi:ss');
	v_vEntrada_Format := SETEA_ENTRADA;
	-- Si el codigo no corresponde a Consalud
	IF ( v_nExtcodfinanciador != v_ncod_isa_cons )
	THEN
	  RAISE isapre_no_corresponde;
	END IF;
	v_vExtHomNumeroConvenio	:= In_vExtHomNumeroConvenio;
	v_vExtHomLugarConvenio	:= In_vExtHomLugarConvenio;
	v_vExtCodPaquete		:= In_vExtCodPaquete;
    BEGIN
		IF INSTR(v_vExtCodPaquete,'P')>0 THEN
		   		v_nExtCodPaquete		:= TO_NUMBER(SUBSTR(v_vExtCodPaquete,3));
		ELSE
		   		v_nExtCodPaquete		:= TO_NUMBER(v_vExtCodPaquete);
		END IF;
		NULL;
    EXCEPTION
    WHEN OTHERS THEN
   		RAISE paquete_corresponde;
    END;
	--Conmed.Pck_Cm_Beneficios_imed.p_entregaDetallePaquete_Imed(1,'22/01/2008',cCursor);
	Pck_Cm_Beneficios_imed.p_entregaDetallePaquete_Imed(v_nExtCodPaquete,TO_CHAR(SYSDATE,'dd/mm/rrrr'),cCursor);
	LOOP
		FETCH cCursor INTO PRESTACION,DESCRIPCION_PRESTACION,COMPONENTE,DESCRIPCION_COMPONENTE,CANTIDAD,PRECIO,DNP_CORRELATIVO,
		NUMERO_INTERVENCION;
		EXIT WHEN cCursor%NOTFOUND;
		vn_Contador :=vn_Contador + 1;
	    Col_vExtCodHomologo(vn_Contador)	:= LPAD(PRESTACION,7,'0');
	Col_vExtItemHomologo(vn_Contador)  :=  COMPONENTE;
	Col_vExtCantidad(vn_Contador) := CANTIDAD;
	END LOOP;
	CLOSE cCursor;
	DBMS_OUTPUT.PUT_LINE ( 'vn_Contador= ' || vn_Contador );
	--Out_vExtCodError		:= 'N';
	IF vn_Contador=0 THEN
		Out_vExtMensajeError	:= 'No se encuentran Prestaciones';
	ELSE
		Out_vExtMensajeError	:= 'Resultado Exitoso';
	END IF;
	Out_vExtCodError		:= 'S';
	--Col_vExtCodHomologo(1) 	:= ' ';
	--Col_vExtItemHomologo(1)	:= ' ';
	--Col_vExtCantidad(1)	 	:= ' ';
	--Out_vReturnStatus	    := '0';
	Out_vReturnStatus	    := '1';
	Out_vMessageText	    := v_vCarIniMessageText||Out_vExtMensajeError;
	--Out_vMessageCode 	    := '58001';
	Out_vMessageCode 	    := '00000';
	SRV_Message 		    := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
	vd_Fecha_Salida:= TO_DATE( TO_CHAR ( SYSDATE, 'RRRR/MM/DD HH24:MI:SS' ), 'RRRR/MM/DD HH24:MI:SS');
	v_vSalida_Format  := SETEA_SALIDA;
	v_nRespuesta := Imed_Graba_Auditoria( v_vNomTrans
										, v_dExtFechaActual
										, NULL
										, NULL
										, NULL
										, NULL
										, v_nExtCodPaquete
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, v_vEntrada_Format
										, v_vSalida_Format
										, v_dFechor_Llegada
										, vd_Fecha_Salida
										, ( vd_Fecha_Salida - v_dFechor_Llegada ) * 86400
										, 0
										, 0
										, 0
										, 0
										, 0
										, 0
										, 0
										);
RETURN;
EXCEPTION
     WHEN isapre_no_corresponde THEN
	 	  LIMPIA;
		  Out_vExtCodError     := 'N';
		  Out_vExtMensajeError := RPAD('Codigo isapre no corresponde',30);
	  	  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		  vd_Fecha_Salida:= TO_DATE( TO_CHAR ( SYSDATE, 'RRRR/MM/DD HH24:MI:SS' ), 'RRRR/MM/DD HH24:MI:SS');
		  SRV_Message:= Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		  v_vSalida_Format:= SETEA_SALIDA;
		  v_nRespuesta := Imed_Graba_Auditoria( v_vNomTrans
										, v_dExtFechaActual
										, NULL
										, NULL
										, NULL
										, NULL
										, v_nExtCodPaquete
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, v_vEntrada_Format
										, v_vSalida_Format
										, v_dFechor_Llegada
										, vd_Fecha_Salida
										, ( vd_Fecha_Salida - v_dFechor_Llegada ) * 86400
										, 0
										, 0
										, 0
										, 0
										, 0
										, 0
										, 0
										);
		  RETURN;
     WHEN paquete_corresponde THEN
	 	  LIMPIA;
		  Out_vExtCodError     := 'N';
		  Out_vExtMensajeError := RPAD('Cod. Paquete no valido',30);
	  	  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		  vd_Fecha_Salida:= TO_DATE( TO_CHAR ( SYSDATE, 'RRRR/MM/DD HH24:MI:SS' ), 'RRRR/MM/DD HH24:MI:SS');
		  SRV_Message:= Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		  v_vSalida_Format:= SETEA_SALIDA;
		  v_nRespuesta := Imed_Graba_Auditoria( v_vNomTrans
										, v_dExtFechaActual
										, NULL
										, NULL
										, NULL
										, NULL
										, v_nExtCodPaquete
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, v_vEntrada_Format
										, v_vSalida_Format
										, v_dFechor_Llegada
										, vd_Fecha_Salida
										, ( vd_Fecha_Salida - v_dFechor_Llegada ) * 86400
										, 0
										, 0
										, 0
										, 0
										, 0
										, 0
										, 0
										);
		  RETURN;
     WHEN OTHERS THEN
	 	  LIMPIA;
		  Out_vExtCodError     := 'N';
		  Out_vExtMensajeError := RPAD('Error al obtener Prest. Paq.',30);
	  	  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		  vd_Fecha_Salida:= TO_DATE( TO_CHAR ( SYSDATE, 'RRRR/MM/DD HH24:MI:SS' ), 'RRRR/MM/DD HH24:MI:SS');
		  SRV_Message:= Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		  v_vSalida_Format:= SETEA_SALIDA;
		  v_nRespuesta := Imed_Graba_Auditoria( v_vNomTrans
										, v_dExtFechaActual
										, NULL
										, NULL
										, NULL
										, NULL
										, v_nExtCodPaquete
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, NULL
										, v_vEntrada_Format
										, v_vSalida_Format
										, v_dFechor_Llegada
										, vd_Fecha_Salida
										, ( vd_Fecha_Salida - v_dFechor_Llegada ) * 86400
										, 0
										, 0
										, 0
										, 0
										, 0
										, 0
										, 0
										);
		  RETURN;
END;
END Conprestpaquete_Pkg;

312 rows selected.

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
