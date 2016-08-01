
SQL*Plus: Release 11.2.0.3.0 Production on Wed Mar 5 19:00:05 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
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

15 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     Convaltrans_Pkg AS

PROCEDURE Convaltrans (SRV_Message	   IN OUT VARCHAR2  --(1)
   			      ,In_nExtCodFinanciador   IN NUMBER	 --(2)
					  ,In_nExtFolioFinanciador IN NUMBER	 --(3)
					  ,In_vExtAccion		   IN VARCHAR	 --(4)
					  ,In_vExtPregunta		   IN VARCHAR	 --(5)
					  ,Out_vExtRespuesta	  OUT VARCHAR	 --(6)
					  ,Out_vExtCodError		  OUT VARCHAR	 --(7)
					  ,Out_vExtMensajeError	  OUT VARCHAR	 --(8)
					  )
IS

v_vNomTrans				   	   VARCHAR2(50):= UPPER('Convaltrans_LIB_Pkg');
-- 20030213 CAGF Nuevas variables
v_vEntrada_Format			   VARCHAR2(2000);
v_vSalida_Format			   VARCHAR2(2000);
v_sep_ES	   				   VARCHAR2(1):=';';
Out_vReturnStatus			   VARCHAR2(1);
Out_vMessageCode 			   VARCHAR2(5);
Out_vMessageText			   VARCHAR2(243);
SRV_FetchStatus				   NUMBER(1) := '0'; -- No tiene variables tipo Column Output
SRV_Total_Rows				   NUMBER(8);
SRV_Row_Count				   NUMBER(8);
v_vCarIniMessageText		   VARCHAR2(1):='X'; -- Para diferenciar Out_vMessageText
												 -- de Out_vExtMensajeError
-- Codigo de la Isapre para Validar Entrada
v_nCod_Isa_Cons  		   	   NUMBER  :=71;


isapre_no_corresponde	   	   EXCEPTION;
estado_bono_pagado			   EXCEPTION;
-----------------------------------------------------

v_nExtCodFinanciador  		   NUMBER(3);
v_nExtFolioFinanciador		   NUMBER(10);
v_vExtAccion				   VARCHAR2(1);
v_vExtPregunta				   VARCHAR2(1);
v_vExtRespuesta				   VARCHAR2(1);
v_vExtCodError				   VARCHAR2(1);
v_vExtMensajeError			   VARCHAR2(30);

v_vSeparador				   VARCHAR2(1):='|';
v_vAUX						   VARCHAR2(3):=NULL;
W_FECHOR_LLEGADA			   DATE;
W_FECHOR_SALIDA				   DATE;
w_res						   NUMBER;

v_nRutCotizante			   	   NUMBER;
v_nRutBenef					   NUMBER;
v_nFolio_Suscripcion		   NUMBER;
v_vCodigoCarga				   NUMBER;
w_montot					   NUMBER;
w_monisa					   NUMBER;
w_moncop					   NUMBER;
w_prestot					   NUMBER;
vv_NUEVO_BENEFICIOS			   VARCHAR2(1):='N';


FUNCTION VALOR(p_vIN IN VARCHAR2) RETURN NUMBER IS
BEGIN
IF p_vIN = 'S' THEN
   RETURN 1;
END IF;
RETURN 0;
END;


FUNCTION SETEA_ENTRADA RETURN VARCHAR2 IS
v_vEntrada VARCHAR2(2000);
BEGIN
  v_vEntrada:= SUBSTR(SRV_Message||v_sep_ES||TO_CHAR(In_nExtCodFinanciador)||v_sep_ES||TO_CHAR(In_nExtFolioFinanciador)||v_sep_ES||In_vExtAccion||v_sep_ES||In_vextPregunta||v_sep_ES,1,2000);
  RETURN v_vEntrada;
END;


FUNCTION SETEA_SALIDA RETURN VARCHAR2 IS
v_vSalida VARCHAR2(2000);
BEGIN
  v_vSalida:= SUBSTR(SRV_Message||v_sep_ES||Out_vExtRespuesta||v_sep_ES||Out_vExtCodError||v_sep_ES||Out_vExtMensajeError||v_sep_ES,1,2000);
  RETURN v_vSalida;
END;


PROCEDURE LIMPIA
AS
BEGIN
  Out_vExtRespuesta:= ' ';
END;

-- PROGRAMA PRINCIPAL
BEGIN
  W_FECHOR_LLEGADA:= SYSDATE;
  --v_vEntrada_Format:= SETEA_ENTRADA;
  v_vEntrada_Format:= SUBSTR(SRV_Message||v_sep_ES||TO_CHAR(In_nExtCodFinanciador)||v_sep_ES||TO_CHAR(In_nExtFolioFinanciador)||v_sep_ES||In_vExtAccion||v_sep_ES||In_vextPregunta||v_sep_ES,1,2000);

  -- Lee Entrada
  v_nExtCodFinanciador	:= In_nExtCodFinanciador;
  v_nExtFolioFinanciador:= In_nExtFolioFinanciador;
  v_vExtAccion			:= In_vExtAccion;
  v_vExtPregunta		:= In_vExtPregunta;

  -- Si el codigo no corresponde a Consalud
  IF  v_nExtcodfinanciador != v_ncod_isa_cons THEN
      RAISE isapre_no_corresponde;
  END IF;

  IF v_nExtFolioFinanciador >= 5000000000 OR v_nExtFolioFinanciador >=700000000 THEN
  	 vv_NUEVO_BENEFICIOS:='S';	 	
  ELSE						
  	 vv_NUEVO_BENEFICIOS:='N'; 						
  END IF;


  BEGIN
  	
	IF vv_NUEVO_BENEFICIOS ='S' THEN
	   SELECT NULL MONTO_COPAGO,
		   NULL MONTO_ISAPRE,
		   NULL MONTO_TOTAL,
		   NULL PRESTACIONES_TOTALES,
		   DOBE.BENC_CODIGO_CARGA CODIGO_CARGA_BENEFICIARIO,
		   DOBE.BENC_COAF_FOLIO_SUSCRIPCION FOLIO_AFILIADO,
		   PERS.RUT_REAL RUT_AFILIADO
	  INTO w_moncop,
	  	   w_monisa,
		   w_montot,
		   w_prestot,
		   v_vCodigoCarga,
		   v_nFolio_Suscripcion,
		   v_nRutCotizante
	  FROM BENEFICIOS.BEN_DOCUMENTOS_LIQUIDACIONES dobe,
		   afi_beneficiarios_contrato benc,
		   AFI_PERSONAS PERS
	 WHERE dobe.CORRELATIVO = v_nExtFolioFinanciador
	   AND dobe.BENC_COAF_FOLIO_SUSCRIPCION = BENC.COAF_FOLIO_suscripcion
	   AND dobe.BENC_COAF_ORGA_CODIGO_ISAPRE = BENC.COAF_ORGA_codigo_ISAPRE
	   AND dobe.BENC_CODIGO_CARGA = BENC.CODIGO_CARGA
	   AND BENC.PERS_CORRELATIVO = PERS.CORRELATIVO;
	
	ELSE
	
	SELECT DOBE.MONTO_COPAGO,
		   DOBE.MONTO_ISAPRE,
		   DOBE.MONTO_TOTAL,
		   DOBE.PRESTACIONES_TOTALES,
		   DOBE.BENC_CODIGO_CARGA_BENEFICIARIO CODIGO_CARGA_BENEFICIARIO,
		   DOBE.BENC_COAF_FOLIO_AFILIADO FOLIO_AFILIADO,
		   PERS.RUT_REAL RUT_AFILIADO
	  INTO w_moncop,
	  	   w_monisa,
		   w_montot,
		   w_prestot,
		   v_vCodigoCarga,
		   v_nFolio_Suscripcion,
		   v_nRutCotizante
	  FROM IMED_dobe dobe,
		   afi_beneficiarios_contrato benc,
		   AFI_PERSONAS PERS
	 WHERE dobe.CORRELATIVO = v_nExtFolioFinanciador
	   AND dobe.BENC_COAF_FOLIO_AFILIADO = BENC.COAF_FOLIO_suscripcion
	   AND dobe.BENC_COAF_ORGA_ISAPRE_AFILIADO = BENC.COAF_ORGA_codigo_ISAPRE
	   AND dobe.BENC_CODIGO_CARGA_AFILIADO = BENC.CODIGO_CARGA
	   AND BENC.PERS_CORRELATIVO = PERS.CORRELATIVO;
	
	END IF;

	EXCEPTION
	     WHEN OTHERS THEN
		      w_moncop 		 	  := NULL;
			  w_monisa 			  := NULL;
			  w_montot	 		  := NULL;
			  w_prestot			  := NULL;
			  v_vCodigoCarga  	  := NULL;
			  v_nFolio_Suscripcion:= NULL;
			  v_nRutCotizante 	  := NULL;

	END;
	

DBMS_OUTPUT.PUT_LINE ( '(02)v_vEntrada_Format= ' || v_vEntrada_Format );
	IF  v_nFolio_Suscripcion IS NOT NULL THEN
		BEGIN
		  SELECT PERS.RUT_REAL
			INTO v_nRutBenef
			FROM AFI_PERSONAS PERS,
				 AFI_BENEFICIARIOS_CONTRATO BENC
		   WHERE BENC.COAF_FOLIO_SUSCRIPCION = v_nFolio_Suscripcion
			 AND BENC.COAF_ORGA_CODIGO_ISAPRE = 71
			 AND BENC.CODIGO_CARGA	= v_vCodigoCarga
			 AND PERS.CORRELATIVO = BENC.PERS_CORRELATIVO;

		EXCEPTION
		     WHEN NO_DATA_FOUND THEN
			      BEGIN
				SELECT HOBE.RUT_BENEF
				      INTO v_nRutBenef
				      FROM IMED_HOMOLOGO_BENEFICIARIOS HOBE
				     WHERE HOBE.BENC_COAF_FOLIO_SUSCRIPCION = v_nFolio_Suscripcion
				       AND HOBE.BENC_COAF_ORGA_CODIGO_ISAPRE = 71
				       AND HOBE.BENC_CODIGO_CARGA = v_vCodigoCarga;

			      EXCEPTION
				   WHEN OTHERS THEN
					v_nRutBenef := NULL;
			      END;
		END;

    END IF;


	IF  v_vExtPregunta = 'V' THEN
		DBMS_OUTPUT.PUT_LINE ( 'LA PREGUNTA FUE *V*' );
		IF vv_NUEVO_BENEFICIOS ='S' THEN
		   BEGIN
			
	      /*
			  SELECT ESLI_TYPE ESTADO
			  INTO v_vAUX
			  FROM	 BENEFICIOS.BEN_ESTADOS_DOC_LIQUIDACIONES
			  WHERE  DOLI_CORRELATIVO=v_nExtFolioFinanciador;
	      */

	      SELECT ESLI_TYPE ESTADO
	      INTO v_vAUX
	      FROM   BENEFICIOS.BEN_ESTADOS_DOC_LIQUIDACIONES
	      WHERE  DOLI_CORRELATIVO=v_nExtFolioFinanciador
	      AND    CORRELATIVO = (SELECT MAX(CORRELATIVO)
				    FROM   BENEFICIOS.BEN_ESTADOS_DOC_LIQUIDACIONES D2
				    WHERE   D2.DOLI_CORRELATIVO=v_nExtFolioFinanciador);
	      v_vExtRespuesta:= 'E';
			EXCEPTION
			     WHEN NO_DATA_FOUND THEN

		    BEGIN
		      SELECT ESLI_TYPE ESTADO
		      INTO   v_vAUX
		      FROM   BENEFICIOS.BEN_ESTADOS_DOC_LIQUIDACIONES
		      WHERE  DOLI_CORRELATIVO=v_nExtFolioFinanciador
		      AND    CORRELATIVO = (SELECT MAX(CORRELATIVO)
					    FROM   BENEFICIOS.BEN_ESTADOS_DOC_LIQUIDACIONES D2
					    WHERE   D2.DOLI_CORRELATIVO=v_nExtFolioFinanciador);
		      v_vExtRespuesta:= 'E';
		     EXCEPTION
				    WHEN NO_DATA_FOUND THEN
			    v_vExtRespuesta:= 'N';
		     END;
			END;
		ELSE
			BEGIN
			  SELECT DOBE.ESTADO
			  INTO v_vAUX
			  FROM IMED_DOBE DOBE
			  WHERE DOBE.correlativo =v_nExtFolioFinanciador;
			  v_vExtRespuesta:= 'E';
			EXCEPTION
			     WHEN NO_DATA_FOUND THEN
				      v_vExtRespuesta:= 'N';
			END;
		END IF;

	ELSIF  v_vExtPregunta = 'A' THEN
		   DBMS_OUTPUT.PUT_LINE ( 'LA PREGUNTA FUE *A*' );
		
		   IF vv_NUEVO_BENEFICIOS ='S' THEN
			   BEGIN
					 /*
		     SELECT ESLI_TYPE ESTADO
			  		 INTO v_vAUX
			  		 FROM	BENEFICIOS.BEN_ESTADOS_DOC_LIQUIDACIONES
			  		 WHERE	DOLI_CORRELATIVO=v_nExtFolioFinanciador;
		     */
		     BEGIN
			 SELECT ESLI_TYPE ESTADO
			 INTO	v_vAUX
			 FROM	BENEFICIOS.BEN_ESTADOS_DOC_LIQUIDACIONES
			 WHERE	DOLI_CORRELATIVO=v_nExtFolioFinanciador
			 AND	CORRELATIVO = (SELECT MAX(CORRELATIVO)
					       FROM   BENEFICIOS.BEN_ESTADOS_DOC_LIQUIDACIONES D2
					       WHERE   D2.DOLI_CORRELATIVO=v_nExtFolioFinanciador);
		     EXCEPTION
				    WHEN NO_DATA_FOUND THEN
			    SELECT ESLI_TYPE ESTADO
			    INTO   v_vAUX
			    FROM   BENEFICIOS.BEN_ESTADOS_DOC_LIQUIDACIONES
			    WHERE  DOLI_CORRELATIVO=v_nExtFolioFinanciador
			    AND    CORRELATIVO = (SELECT MAX(CORRELATIVO)
						  FROM	 BENEFICIOS.BEN_ESTADOS_DOC_LIQUIDACIONES D2
						  WHERE   D2.DOLI_CORRELATIVO=v_nExtFolioFinanciador);
		     END;
		
					 IF  v_vAUX = 'ANU' OR v_vAUX = 'DEV' THEN
					 	 v_vExtRespuesta:= 'A';
		
					 ELSIF	v_vAUX = 'EMI' THEN
					 		v_vExtRespuesta:= 'E';
		
						ELSE
							DBMS_OUTPUT.PUT_LINE ( 'EL ESTADO ES *PAG*' );
							v_vExtRespuesta:= 'X';
							RAISE estado_bono_pagado;
		
					 END IF;
		
				   EXCEPTION
					WHEN NO_DATA_FOUND THEN
						 v_vExtRespuesta:= 'N';
			   END;
		   ELSE
			   BEGIN
				 SELECT DOBE.ESTADO
				   INTO v_vAUX
				   FROM IMED_DOBE DOBE
				  WHERE DOBE.correlativo =v_nExtFolioFinanciador;
	
				 IF  v_vAUX = 'ANU' OR v_vAUX = 'DEV' THEN
				 	 v_vExtRespuesta:= 'A';
	
				 ELSIF	v_vAUX = 'EMI' THEN
				 		v_vExtRespuesta:= 'E';
	
					ELSE
						DBMS_OUTPUT.PUT_LINE ( 'EL ESTADO ES *PAG*' );
						v_vExtRespuesta:= 'X';
						RAISE estado_bono_pagado;
	
				 END IF;
	
			   EXCEPTION
				WHEN NO_DATA_FOUND THEN
					 v_vExtRespuesta:= 'N';
			   END;
			END IF;

	END IF;

DBMS_OUTPUT.PUT_LINE ( '(03)v_vEntrada_Format= ' || v_vEntrada_Format );
    Out_vExtRespuesta	   := v_vExtRespuesta;
	Out_vExtCodError       := 'S';
	Out_vExtMensajeError   := 'Servicio Correcto';
	Out_vReturnStatus	   := '1';
	Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
---	Out_vMessageCode 	   := '38001';
	Out_vMessageCode 	   := '00000';
	SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;


    DBMS_OUTPUT.PUT_LINE ( '(04)v_vEntrada_Format= ' || v_vEntrada_Format );

	v_vSalida_Format:= SETEA_SALIDA;
	W_FECHOR_SALIDA:= SYSDATE;

	w_res:= Imed_Graba_Auditoria
		   (v_vNomTrans,
		    W_FECHOR_LLEGADA,
		    NULL,
		    NULL,
		    NULL,
		    NULL,
		    v_nRutBenef,
		    v_nRutCotizante,
		    v_nFolio_Suscripcion,
		    v_vCodigoCarga,
		    v_nExtFolioFinanciador,
		    w_montot,
		    w_prestot,
		    w_monisa,
		    w_moncop,
		    v_vEntrada_Format,
		    v_vSalida_Format,
		    W_FECHOR_LLEGADA,
		    W_FECHOR_salida,
		    (W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,
		    NULL,
		    NULL,
		    NULL,
		    NULL,
		    NULL,
		    NULL,
		    NULL);


DBMS_OUTPUT.PUT_LINE ( 'Out_vExtRespuesta= ' || Out_vExtRespuesta );
DBMS_OUTPUT.PUT_LINE ( 'Out_vExtCodError= ' || Out_vExtCodError );
DBMS_OUTPUT.PUT_LINE ( 'Out_vExtMensajeError= ' || Out_vExtMensajeError );


    RETURN;  /* sal; CAGF 20030129 */


EXCEPTION
	  WHEN isapre_no_corresponde THEN
			LIMPIA;
		---	Out_vExtCodError       := 'S';
			Out_vExtCodError       := 'N';
			Out_vExtMensajeError   := 'Codigo isapre no corresponde';
		---	Out_vReturnStatus	   := '0';
			Out_vReturnStatus	   := '1';
		    Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		---	Out_vMessageCode 	   := '78001';
		   	Out_vMessageCode 	   := '00000';
		    SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		    v_vSalida_Format	   := SETEA_SALIDA;
			W_FECHOR_SALIDA:=SYSDATE;
			w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,v_nRutBenef,v_nRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioFinanciador,w_montot,w_prestot,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA
,
						    W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
		    RETURN;
	  WHEN estado_bono_pagado THEN
	  	    DBMS_OUTPUT.PUT_LINE ( 'SE FUE POR EXCEPCION *estado_bono_pagado*' );
			LIMPIA;
		---	Out_vExtCodError       := 'S';
			Out_vExtCodError       := 'N';
			Out_vExtMensajeError   := 'Bono con estado Pagado';
		---	Out_vReturnStatus	   := '0';
			Out_vReturnStatus	   := '1';
		    Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		---	Out_vMessageCode 	   := '78001';
		   	Out_vMessageCode 	   := '00000';
		    SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		    v_vSalida_Format	   := SETEA_SALIDA;
			W_FECHOR_SALIDA:=SYSDATE;
			w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,v_nRutBenef,v_nRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioFinanciador,w_montot,w_prestot,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA
,
						    W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
		    RETURN;
	  WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE ( 'SE FUE POR EXCEPCION *general*' );
			LIMPIA;
		---	Out_vExtCodError       := 'S';
			Out_vExtCodError       := 'N';
			Out_vExtMensajeError   := 'ERROR GENERAL EN PACKAGE';
		---	Out_vReturnStatus	   := '0';
			Out_vReturnStatus	   := '1';
		    Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		---	Out_vMessageCode 	   := '78099';
		   	Out_vMessageCode 	   := '00000';
		    SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		    v_vSalida_Format	   := SETEA_SALIDA;
			W_FECHOR_SALIDA:=SYSDATE;
			w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,v_nRutBenef,v_nRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioFinanciador,w_montot,w_prestot,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA
,
						    W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
		    RETURN;
END;

END Convaltrans_Pkg;

447 rows selected.

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
