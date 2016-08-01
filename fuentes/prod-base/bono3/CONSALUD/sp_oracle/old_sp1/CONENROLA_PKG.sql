
SQL*Plus: Release 11.2.0.3.0 Production on Wed Mar 5 19:00:00 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONENROLA
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTRUTENROLAR		VARCHAR2		IN
 IN_VEXTRUTBENEFICIARIO 	VARCHAR2		IN
 OUT_VEXTVALIDO 		VARCHAR2		OUT
 OUT_VEXTNOMBRECOMP		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Conenrola_Pkg
AS
PROCEDURE Conenrola
   		  (
   			 SRV_Message 		  			IN OUT VARCHAR2    	--(1)
   		  , In_nExtCodFinanciador		IN 	   NUMBER	    --(2)
		  ,	In_vExtRutEnrolar				IN     VARCHAR2     --(3)
		  ,	In_vExtRutBeneficiario			IN     VARCHAR	   	--(4)
		  ,	Out_vExtValido					OUT    VARCHAR	  	--(5)
		  ,	Out_vExtNombreComp				OUT    VARCHAR	   	--(6)
		  );
END Conenrola_Pkg;

12 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     Conenrola_Pkg
AS

PROCEDURE Conenrola (SRV_Message 		 IN OUT VARCHAR2,
		  			 In_nExtCodFinanciador	IN 	NUMBER,
					 In_vExtRutEnrolar		IN  VARCHAR2,
					 In_vExtRutBeneficiario	IN  VARCHAR,
					 Out_vExtValido			OUT VARCHAR,
					 Out_vExtNombreComp		OUT VARCHAR)
IS

v_vNomTrans									VARCHAR2(50):= UPPER('Conenrola_Pkg');
v_vEntrada_Format			  				VARCHAR2(2000);
v_vSalida_Format							VARCHAR2(2000);
v_sep_ES	   								VARCHAR2(1):=';';
Out_vReturnStatus							VARCHAR2(1);
Out_vMessageCode 						  	VARCHAR2(5);
Out_vMessageText							VARCHAR2(243);
SRV_FetchStatus								NUMBER(1) := '0';
SRV_Total_Rows								NUMBER(8);
SRV_Row_Count								NUMBER(8);
v_vCarIniMessageText						VARCHAR2(1):='X'; -- Para diferenciar Out_vMessageText
														  	  -- de Out_vExtMensajeError
-- Codigo de la Isapre para validar contra entrada
v_ncod_isa_cons 	   	 		 		NUMBER:= 71;
isapre_no_corresponde						EXCEPTION;
--
v_nExtCodFinanciador 		   				NUMBER(4);
v_vExtRutEnrolar			   				VARCHAR2(12);
v_vExtRutBeneficiario		   				VARCHAR2(12);
v_vExtValido				   				VARCHAR2(1);
v_vExtNombreComp			   				VARCHAR2(40);

v_vSeparador				   				VARCHAR2(1):='|';

W_FECHOR_LLEGADA			   				DATE;
W_FECHOR_SALIDA			   	   				DATE;

v_nRutCotizante				   				NUMBER;
v_nFolioSuscripcion			   				NUMBER;
v_nCodigoIsapre								NUMBER;
v_nCodigoCarga				   				NUMBER;
w_res						   				NUMBER;
E_FIN						   				EXCEPTION;


FUNCTION SETEA_ENTRADA
RETURN VARCHAR2
IS
v_vEntrada			   VARCHAR2(2000);
BEGIN
v_vEntrada:= SUBSTR(SUBSTR(LTRIM(RTRIM(SRV_Message)),1,256)||v_sep_ES||TO_CHAR(In_nextCodFinanciador)||v_sep_ES||In_vExtRutEnrolar||v_sep_ES||In_vExtRutBeneficiario||v_sep_ES,1,2000);
RETURN v_vEntrada;
END;


FUNCTION SETEA_SALIDA
RETURN VARCHAR2
IS
v_vSalida	   VARCHAR2(2000);
BEGIN
v_vSalida:= SUBSTR(SRV_Message||v_sep_ES||Out_vExtValido||v_sep_ES||Out_vExtNombreComp||v_sep_ES,1,2000);
RETURN v_vSalida;
END;


PROCEDURE LIMPIA
AS
BEGIN
  Out_vExtValido      := 'N';
  Out_vExtNombreComp  := ' ';
END;





BEGIN
DBMS_OUTPUT.PUT_LINE ('01');
DBMS_OUTPUT.PUT_LINE ( 'SRV_Message= ' || SRV_Message );
DBMS_OUTPUT.PUT_LINE ( 'In_nExtCodFinanciador= ' || In_nExtCodFinanciador );
DBMS_OUTPUT.PUT_LINE ( 'In_vExtRutEnrolar= ' || In_vExtRutEnrolar );
DBMS_OUTPUT.PUT_LINE ( 'In_vExtRutBeneficiario= ' || In_vExtRutBeneficiario );
DBMS_OUTPUT.PUT_LINE ( 'Out_vExtValido= ' || Out_vExtValido );
DBMS_OUTPUT.PUT_LINE ( 'Out_vExtNombreComp= ' || Out_vExtNombreComp );

    W_FECHOR_LLEGADA  	  :=SYSDATE;
	v_vEntrada_Format  	  := SETEA_ENTRADA;
	v_nExtCodFinanciador  := 71; --In_nExtCodFinanciador;

   -- Si el codigo no corresponde a Consalud
   IF ( v_nextcodfinanciador != v_ncod_isa_cons )
   THEN
      RAISE isapre_no_corresponde;
   END IF;

	v_vExtRutEnrolar	  := In_vExtRutEnrolar;
	v_vExtRutBeneficiario := In_vExtRutBeneficiario;

    -- Se obtiene los datos del beneficiario y datos para auditoria
DBMS_OUTPUT.PUT_LINE ('03');
   	BEGIN -- modelo corporativo
DBMS_OUTPUT.PUT_LINE ('03.1 '||In_vExtRutBeneficiario);
		  SELECT SUBSTR(PERS.APELLIDO_PATERNO||' '||PERS.APELLIDO_MATERNO||' '||PERS.NOMBRE,1,40)
		  	   , 'S'
			   , BENC.COAF_FOLIO_SUSCRIPCION
			   , BENC.COAF_ORGA_CODIGO_ISAPRE
		 	   , BENC.CODIGO_CARGA
		  INTO	 v_vExtNombreComp
		  	   , v_vExtValido
		       , v_nFolioSuscripcion
			   , v_nCodigoIsapre
		 	   , v_nCodigoCarga
		  FROM	 AFI_BENEFICIARIOS_CONTRATO BENC,
		  	     AFI_PERSONAS PERS
		  WHERE  PERS.CORRELATIVO = BENC.PERS_CORRELATIVO
		  	AND  PERS.RUT_REAL = TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10))
		  	--AND  BENC.FECHA_TERMINO_BENEFICIO IS NULL
	    AND benc.FECHA_INICIO_BENEFICIOS <= TRUNC(SYSDATE)
	    AND    NVL(BENC.FECHA_TERMINO_BENEFICIO,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
			AND  benc.BENC_TYPE IN ('AFIL','CARG')
			;
DBMS_OUTPUT.PUT_LINE ('03.2');
	EXCEPTION
		 WHEN TOO_MANY_ROWS THEN
		 BEGIN
		 	  SELECT SUBSTR(PERS.APELLIDO_PATERNO||' '||PERS.APELLIDO_MATERNO||' '||PERS.NOMBRE,1,40)
			  	   , 'S'
				   , BENC.COAF_FOLIO_SUSCRIPCION
				   , BENC.COAF_ORGA_CODIGO_ISAPRE
			 	   , BENC.CODIGO_CARGA
			  INTO	 v_vExtNombreComp
			  	   , v_vExtValido
			       , v_nFolioSuscripcion
				   , v_nCodigoIsapre
			 	   , v_nCodigoCarga
			  FROM	 AFI_BENEFICIARIOS_CONTRATO BENC,
			  	     AFI_PERSONAS PERS
			  WHERE  PERS.CORRELATIVO = BENC.PERS_CORRELATIVO
			  	AND  PERS.RUT= TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10))
			  	--AND  BENC.FECHA_TERMINO_BENEFICIO IS NULL
		AND benc.FECHA_INICIO_BENEFICIOS <= TRUNC(SYSDATE)
		AND    NVL(BENC.FECHA_TERMINO_BENEFICIO,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
				AND  benc.BENC_TYPE IN ('AFIL','CARG')
				;
		 EXCEPTION
 			WHEN NO_DATA_FOUND THEN
	    		 v_vExtNombreComp  := ' ';
	    		 v_vExtValido 	  := 'N';
			 Out_vReturnStatus := '1';
	      	     Out_vMessageText  := v_vCarIniMessageText||'Beneficiario no Encontrado';
		  	     Out_vMessageCode  := '00000';
	  		     RAISE E_FIN;
		    WHEN OTHERS THEN
	       		 v_vExtNombreComp  := ' ';
	    		 v_vExtValido 	  := 'N';
		  	     Out_vReturnStatus := '1';
	      	     Out_vMessageText  := v_vCarIniMessageText||'1-Beneficiario no Encontrado';
		  	     Out_vMessageCode  := '00000';
			     RAISE E_FIN;
		 END;
	     WHEN NO_DATA_FOUND THEN
				BEGIN -- Busca si esta homologado
					  SELECT SUBSTR(PERS.APELLIDO_PATERNO||' '||PERS.APELLIDO_MATERNO||' '||PERS.NOMBRE,1,40)
					  	   , 'S'
					   	   , BENC.COAF_FOLIO_SUSCRIPCION
			   			   , BENC.COAF_ORGA_CODIGO_ISAPRE
				 	   	   , BENC.CODIGO_CARGA
				      INTO   v_vExtNombreComp
				  	   	   , v_vExtValido
					   , v_nFolioSuscripcion
		   			       , v_nCodigoIsapre
				 	       , v_nCodigoCarga
					  FROM	 AFI_PERSONAS PERS,
					   		 AFI_BENEFICIARIOS_CONTRATO  BENC,
							 IMED_HOMOLOGO_BENEFICIARIOS HOBE
					  WHERE  BENC.PERS_CORRELATIVO 		  = PERS.CORRELATIVO
					    AND  HOBE.RUT_BENEF			      = TO_NUMBER(SUBSTR(In_vExtRutBeneficiario,1,10))
					    AND  BENC.COAF_FOLIO_SUSCRIPCION  = HOBE.BENC_COAF_FOLIO_SUSCRIPCION
					    AND  BENC.COAF_ORGA_CODIGO_ISAPRE = HOBE.BENC_COAF_ORGA_CODIGO_ISAPRE
					    AND  BENC.CODIGO_CARGA	      = HOBE.BENC_CODIGO_CARGA
					    --AND  BENC.FECHA_TERMINO_BENEFICIO IS NULL
			AND benc.FECHA_INICIO_BENEFICIOS <= TRUNC(SYSDATE)
			AND    NVL(BENC.FECHA_TERMINO_BENEFICIO,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
						AND  benc.BENC_TYPE IN ('AFIL','CARG')
						;
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
			    		 v_vExtNombreComp  := ' ';
			    		 v_vExtValido 	  := 'N';
					 Out_vReturnStatus := '1';
			      	     Out_vMessageText  := v_vCarIniMessageText||'Beneficiario no Encontrado';
				  	     Out_vMessageCode  := '00000';
			  		     RAISE E_FIN;
				    WHEN OTHERS THEN
			       		 v_vExtNombreComp  := ' ';
			    		 v_vExtValido 	  := 'N';
				  	     Out_vReturnStatus := '1';
			      	     Out_vMessageText  := v_vCarIniMessageText||'1-Beneficiario no Encontrado';
				  	     Out_vMessageCode  := '00000';
					     RAISE E_FIN;
			    END;

		 WHEN OTHERS THEN
		 	  dbms_output.put_line('ERROR: ==>  '||SUBSTR(SQLERRM,1,100) );
    		  v_vExtNombreComp  := ' ';
    		  v_vExtValido 	  := 'N';
		  Out_vReturnStatus := '1';
      	      Out_vMessageText	:= v_vCarIniMessageText||'Error al accesar Beneficiario';
	  	      Out_vMessageCode	:= '00000';
  		      DBMS_OUTPUT.PUT_LINE ('03.3  '||Out_vMessageText);
			  RAISE E_FIN;

	END;


    DBMS_OUTPUT.PUT_LINE ('04');
    IF	TO_NUMBER(SUBSTR(v_vExtRutEnrolar,1,10)) = TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)) THEN
	    DBMS_OUTPUT.PUT_LINE ('04.1');
		NULL;
	ELSE -- es consulta por acompa?ante
		  BEGIN
		 DBMS_OUTPUT.PUT_LINE ('04.2');
			 SELECT SUBSTR(ACVA.APELLIDO_PATERNO||' '||ACVA.APELLIDO_MATERNO||' '||ACVA.NOMBRES,1,40),
			 		'S'
		   INTO v_vExtNombreComp,
			   		v_vExtValido
	    	   FROM IMED_ACOMPANANTES_VALIDOS ACVA
	    	  WHERE ACVA.RUT = 	TO_NUMBER(SUBSTR(v_vExtRutEnrolar,1,10))
			    AND ACVA.BENC_COAF_FOLIO_SUSCRIPCION =  v_nFolioSuscripcion
				AND ACVA.BENC_COAF_ORGA_CODIGO_ISAPRE = v_nCodigoIsapre
	---			20030314 CAGF Busca por carga 0 Acompa?antes Validos se cargaran por cotizante,
	---			una vez que se carguen por beneficiario cambiar las lineas
	---			AND ACVA.BENC_CODIGO_CARGA =  v_nCodigo_Carga
				AND ACVA.BENC_CODIGO_CARGA =  0;
			 DBMS_OUTPUT.PUT_LINE ('04.3');
	      EXCEPTION
	    	WHEN NO_DATA_FOUND THEN
	    		 DBMS_OUTPUT.PUT_LINE ('04.4');
				 v_vExtNombreComp :=' ';
	    		 v_vExtValido 	  :='N';
	      END;
    END IF;

	Out_vExtValido		   := v_vExtValido;
	Out_vExtNombreComp	   := v_vExtNombreComp;
    Out_vReturnStatus	   := '1';
DBMS_OUTPUT.PUT_LINE ('05');

	IF  v_vExtValido = 'S' THEN
		DBMS_OUTPUT.PUT_LINE ('06');
    	Out_vMessageText	   := v_vCarIniMessageText||'Servicio Correcto';
	ELSE
    	DBMS_OUTPUT.PUT_LINE ('07');
		Out_vMessageText	   := v_vCarIniMessageText||'No Valido';
	END IF;

	DBMS_OUTPUT.PUT_LINE ('08');
    Out_vMessageCode 	   := '00000';
 	DBMS_OUTPUT.PUT_LINE ('09');
	SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
    DBMS_OUTPUT.PUT_LINE ('10');
	v_vSalida_Format     := SETEA_SALIDA;
	DBMS_OUTPUT.PUT_LINE ('11');
	W_FECHOR_salida	     := SYSDATE;
	DBMS_OUTPUT.PUT_LINE ('12');
	w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10)),
				    v_nRutCotizante,v_nFolioSuscripcion,v_nCodigoCarga,NULL,NULL,NULL,NULL,NULL,v_vEntrada_Format,
								v_vSalida_Format,W_FECHOR_LLEGADA,W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,NULL,
								NULL,NULL,NULL,NULL,NULL,NULL);
	RETURN;

EXCEPTION
     WHEN isapre_no_corresponde THEN
  	      LIMPIA;
---	  	  Out_vReturnStatus	   := '0';
		  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||'Codigo isapre no corresponde';
---  	  Out_vMessageCode 	   := '78001';
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
    	  v_vSalida_Format     := SETEA_SALIDA;
		  W_FECHOR_salida	     := SYSDATE;
		  w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10))
		  ,v_nRutCotizante,v_nFolioSuscripcion,v_nCodigoCarga,NULL,NULL,NULL,NULL,NULL,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		  W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
		  RETURN;
     WHEN E_FIN THEN
	 	  LIMPIA;
	   dbms_output.put_line('ERROR ==>  '||SQLERRM );
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
    	  v_vSalida_Format     := SETEA_SALIDA;
		  W_FECHOR_salida	   := SYSDATE;
		  w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10))
		  ,v_nRutCotizante,v_nFolioSuscripcion,v_nCodigoCarga,NULL,NULL,NULL,NULL,NULL,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		  W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
		  RETURN;
     WHEN OTHERS THEN
	 	  LIMPIA;
	  dbms_output.put_line('ERROR: '||SQLERRM );
---	  	  Out_vReturnStatus	   := '0';
      	  Out_vMessageText	   := v_vCarIniMessageText||RPAD('ERROR PROC.:'||v_vNomTrans,30);
---	  	  Out_vMessageCode 	   := '78099';
	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
    	  v_vSalida_Format     := SETEA_SALIDA;
		  W_FECHOR_salida	   := SYSDATE;
		  w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,TO_NUMBER(SUBSTR(v_vExtRutBeneficiario,1,10))
		  ,v_nRutCotizante,v_nFolioSuscripcion,v_nCodigoCarga,NULL,NULL,NULL,NULL,NULL,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		  W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
		  RETURN;
END;

END Conenrola_Pkg;

314 rows selected.

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
