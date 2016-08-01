
SQL*Plus: Release 11.2.0.3.0 Production on Wed Mar 5 19:00:01 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
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

15 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     Coninfenrola_Pkg
AS
   PROCEDURE Coninfenrola
   			(
   			 SRV_Message 		  			IN OUT VARCHAR2,    --(1)
   		     In_nExtCodFinanciador	 	IN 	   NUMBER,	    --(2)
		  	 In_vExtRutBeneficiario			IN     VARCHAR2,	--(3)
		  	 In_vExtRutAcompanante			IN     VARCHAR2,	--(4)
		  	 In_vExtIndEnrola				IN     NUMBER,	   	--(5)
		  	 Out_vExtCodError				OUT    VARCHAR,	  	--(6)
		  	 Out_vExtMensajeError			OUT    VARCHAR	   	--(7)
		    )

IS
v_vnomtrans		    VARCHAR2 (50) := UPPER('CONINFENROLA_PKG');

w_fechor_llegada	    DATE;
w_fechor_salida 	    DATE;
w_res			   NUMBER ( 1 )      := 0;
w_con_bcc		   NUMBER ( 1 )      := 0;
w_con_exc		   NUMBER ( 1 )      := 0;
w_con_top		   NUMBER ( 1 )      := 0;
w_con_cig		   NUMBER ( 1 )      := 0;

v_vEntrada_Format			VARCHAR2(2000);
v_vSalida_Format			VARCHAR2(2000);
v_sep_ES	   				VARCHAR2(1):=';';
Out_vReturnStatus			VARCHAR2(1);
Out_vMessageCode 			VARCHAR2(5);
Out_vMessageText			VARCHAR2(243);
SRV_FetchStatus				NUMBER(1)  := '0'; -- No tiene variables tipo Column Output
SRV_Total_Rows				NUMBER(8);
SRV_Row_Count				NUMBER(8);
v_vCarIniMessageText		VARCHAR2(1):='X'; -- Para diferenciar Out_vMessageText de Out_vExtMensajeError

-- Codigo de la Isapre para validar entrada
v_ncod_isa_cons 	   NUMBER      := 71;

w_sep  		  	  		   VARCHAR2(1) :='|';	 -- separador utilizado para p_vEntrada y salida
w_nExtCodFinanciador	   NUMBER(3);			 -- codigo de la isapre
w_nExtRutBeneficiario	   NUMBER(10);			 -- rut del beneficiario
w_nExtRutAcompanante	   NUMBER(10);			 --	rut del acompa?ante
w_nExtIndEnrola			   NUMBER(2);			 -- indicador de persona enrolada
					   						 	 -- 1= beneficiario  2= acompa?ante

sal			   NUMBER(1)   :=0;
no_pudo_obtener_secuencia  EXCEPTION;
no_inserto_enrolamiento    EXCEPTION;
isapre_no_corresponde 	   EXCEPTION;
E_FIN					   EXCEPTION;

glosa			   VARCHAR(30);
w_secuen		   NUMBER(10);

Out_N					   VARCHAR2(200); --CTC Parametros OUT no usados
v_vResp 	     	   NUMBER;
v_nfolio_suscripcion	   NUMBER;
v_nrut_coti				   NUMBER;
v_nrut_enrolado			   NUMBER;
v_ncodigo_carga 	   NUMBER;
v_ncoderror		   NUMBER;
v_vgloerror		   VARCHAR2(200); --CETC
w_aux					   VARCHAR2(256);



FUNCTION SETEA_ENTRADA RETURN VARCHAR2 IS
  v_vEntrada VARCHAR2(2000);
BEGIN
  w_aux:=REPLACE(SRV_Message,CHR(0),null);
  if  w_aux is null then
 	  w_aux:= '*';
  end if;
  v_vEntrada:= SUBSTR(SUBSTR(RTRIM(w_aux),1,256)||v_sep_ES||TO_CHAR(In_nextCodFinanciador)||v_sep_ES||In_vExtRutBeneficiario||v_sep_ES||In_vExtRutAcompanante||v_sep_ES||In_vExtIndEnrola||v_sep_ES,1,2000);
  RETURN v_vEntrada;
END;



FUNCTION SETEA_SALIDA RETURN VARCHAR2 IS
  v_vSalida VARCHAR2(2000);
BEGIN
  v_vSalida:= SUBSTR(SRV_Message||v_sep_ES||Out_vExtCodError||v_sep_ES||Out_vExtMensajeError||v_sep_ES,1,2000);
  RETURN v_vSalida;
END;




BEGIN

   w_fechor_llegada :=TO_DATE ( TO_CHAR ( SYSDATE, 'RRRR/MM/DD HH24:MI:SS' ), 'RRRR/MM/DD HH24:MI:SS');
   v_vEntrada_Format := SETEA_ENTRADA;

	/*Rescata variables de ingreso */
   w_nExtCodFinanciador  := In_nExtCodFinanciador;

   IF ( w_nExtCodFinanciador != v_ncod_isa_cons )
   THEN
   	  Out_vExtCodError     := 'N';
	  Out_vExtMensajeError := 'Codigo isapre no corresponde';
  	  Out_vReturnStatus	   := '1';
      Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
  	  Out_vMessageCode 	   := '00000';

      RAISE E_FIN;
   END IF;

	w_nExtRutBeneficiario := TO_NUMBER(SUBSTR(In_vExtRutBeneficiario,1,10));
	w_nExtRutAcompanante  := TO_NUMBER(SUBSTR(In_vExtRutAcompanante,1,10));
	w_nExtIndEnrola		  := TO_NUMBER(In_vExtIndEnrola);

    /* genera secuencia de enrolamientos */
    w_secuen:=0;
	BEGIN
		SELECT IMED_ENROLA_SEQ.NEXTVAL
		  INTO W_SECUEN
		  FROM dual;
	EXCEPTION
	 WHEN OTHERS THEN
	      DBMS_OUTPUT.PUT_LINE('FALLO OBTENCION DE LA SECUENCIA');
			  Out_vExtCodError     := 'N';
			  Out_vExtMensajeError := 'Fallo secuencia enrolamiento';
		  	  Out_vReturnStatus	   := '1';
	      	  Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
	   	  	  Out_vMessageCode 	   := '00000';

			  RAISE e_fin;
	END;

    DBMS_OUTPUT.PUT_LINE('OBTENCION DE LA SECUENCIA : '||W_SECUEN);

	BEGIN
		INSERT INTO IMED_ENROLAMIENTO
		      (CORRELATIVO,
			   FECHA_ENROLAMIENTO,
			   CODIGO_ISAPRE,
			   RUT_BENEFICIARIO,
			   RUT_ACOMPANANTE,
			   TIPO_ENROLADO,
			   MARCA_ACTUALIZACION
			  )
		VALUES
			  (W_SECUEN,
			   SYSDATE,
			   w_nExtCodFinanciador,
			   w_nExtRutBeneficiario,
			   w_nExtRutAcompanante,
			   w_nExtIndEnrola,
			   NULL
			  );

		COMMIT;

	EXCEPTION
	 WHEN OTHERS THEN
	      DBMS_OUTPUT.PUT_LINE('FALLO INSERT ENROLAMIENTO');
			  Out_vExtCodError     := 'N';
			  Out_vExtMensajeError := 'Enrolamiento NO registrado';
		  	  Out_vReturnStatus	   := '1';
	      	  Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
	   	  	  Out_vMessageCode 	   := '00000';

			  RAISE e_fin;
	END;
    DBMS_OUTPUT.PUT_LINE('INSERT ENROLAMIENTO : '||w_nExtRutBeneficiario||' - '||In_vExtRutBeneficiario);


	-- New Rut Cotizante 'CTC'
	DBMS_OUTPUT.PUT_LINE ('___________________________________________________');

    BEGIN

	   IF In_vExtIndEnrola = 1 THEN
	   	  v_nrut_enrolado:=w_nExtRutBeneficiario;
	   ELSE
		  v_nrut_enrolado:=w_nExtRutAcompanante;
	   END IF;

       v_vResp := Imed_Beneficiario_Cotizante(v_nrut_enrolado,
											v_nfolio_suscripcion,
											v_nrut_coti,
											Out_n,
											v_ncodigo_carga,
											v_ncoderror,
											v_vgloerror);

 	EXCEPTION
	WHEN OTHERS THEN
		    Out_vExtCodError	   := 'N';
			Out_vExtMensajeError   := 'FALLO FUNCION RUT ENROLADO';
		    Out_vReturnStatus	   := '1';
		    Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		    Out_vMessageCode 	   := '00000';

		    RAISE e_fin;
    END;


   IF  v_vResp = 1 THEN
		    Out_vExtCodError	   := 'N';
			Out_vExtMensajeError   := v_vgloerror;
		    Out_vReturnStatus	   := '1';
		    Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		    Out_vMessageCode 	   := '00000';

			RAISE e_fin;
   END IF;

 DBMS_OUTPUT.PUT_LINE ('Codigo Carga :'||v_ncodigo_carga);

	BEGIN

		UPDATE AFI_BENEFICIARIOS_CONTRATO BENE
		   SET BENE.FECHA_ENROLA     = SYSDATE,
		       BENE.TIPO_ENROLA      = 0,
			   BENE.SECUENCIA_ENROLA = W_SECUEN
		 WHERE BENE.COAF_FOLIO_SUSCRIPCION = v_nfolio_suscripcion
		   AND BENE.COAF_ORGA_CODIGO_ISAPRE = w_nExtCodFinanciador
		   AND BENE.CODIGO_CARGA = v_ncodigo_carga;

		IF  SQL%ROWCOUNT = 0 THEN
		    Out_vExtCodError	   := 'N';
			Out_vExtMensajeError   := 'NO Actualizo Beneficiario';
		    Out_vReturnStatus	   := '1';
		    Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		    Out_vMessageCode 	   := '00000';

			RAISE e_fin;
		END IF;

		DBMS_OUTPUT.PUT_LINE ('UPDATE AFI_BENEFICIARIOS_CONTRATO OK');

	    UPDATE IMED_ENROLAMIENTO ENRO2
	   SET MARCA_ACTUALIZACION = 1
	 WHERE CORRELATIVO = W_SECUEN;
	COMMIT;

		IF  SQL%ROWCOUNT = 0 THEN
		    Out_vExtCodError	   := 'N';
			Out_vExtMensajeError   := 'NO Actualizo Enrolamiento';
		    Out_vReturnStatus	   := '1';
		    Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		    Out_vMessageCode 	   := '00000';

			RAISE e_fin;
		END IF;


		DBMS_OUTPUT.PUT_LINE ('UPDATE IMED_ENROLAMIENTO OK :'||W_SECUEN||' - '||SQL%ROWCOUNT);

   END;

	 DBMS_OUTPUT.PUT_LINE ('___________________________________________________');
--------------------------------------------------------------------------CTC


    Out_vExtCodError	   := 'S';
	Out_vExtMensajeError   := 'Registro de enrolamiento OK';
    Out_vReturnStatus	   := '1';
    Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
    Out_vMessageCode 	   := '00000';
 	SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;


   w_fechor_salida := TO_DATE ( TO_CHAR ( SYSDATE, 'rrrr/mm/dd hh24:mi:ss' ), 'rrrr/mm/dd hh24:mi:ss');

   v_vSalida_Format  := SETEA_SALIDA;

    w_res := Imed_Graba_Auditoria ( v_vnomtrans
			   , SYSDATE
			   , NULL
			   , NULL
			   , NULL
			   , TO_NUMBER ( SUBSTR ( In_vExtRutAcompanante, 1, 10 ))
			   , TO_NUMBER (SUBSTR ( In_vExtRutBeneficiario, 1, 10 ))
			   , v_nrut_coti
			   , v_nfolio_suscripcion
			   , v_ncodigo_carga
			   , NULL
			   , NULL
			   , NULL
			   , NULL
			   , NULL
			   , v_vEntrada_Format
			   , v_vSalida_Format
			   , w_fechor_llegada
			   , w_fechor_salida
			   , ( w_fechor_salida - w_fechor_llegada ) * 86400
			   , w_con_bcc
			   , 0
			   , w_con_exc
			   , 0
			   , w_con_top
			   , w_con_cig
			   , 0
			   );
   RETURN;

EXCEPTION
   WHEN E_FIN	THEN

      w_fechor_salida:= TO_DATE( TO_CHAR ( SYSDATE, 'rrrr/mm/dd hh24:mi:ss' ), 'rrrr/mm/dd hh24:mi:ss');

	  SRV_Message:= Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;

	  v_vSalida_Format:= SETEA_SALIDA;

	  w_res := Imed_Graba_Auditoria ( v_vnomtrans
			      , SYSDATE
			      , NULL
			      , NULL
			      , NULL
			      , TO_NUMBER ( SUBSTR ( In_vExtRutAcompanante, 1, 10 ))
			      , TO_NUMBER (SUBSTR ( In_vExtRutBeneficiario, 1, 10 ))
			      , v_nrut_coti
							  , v_nfolio_suscripcion
			      , v_ncodigo_carga
			      , NULL
			      , NULL
			      , NULL
			      , NULL
			      , NULL
			      , v_vEntrada_Format
			   	  , v_vSalida_Format
			      , w_fechor_llegada
			      , w_fechor_salida
			      , ( w_fechor_salida - w_fechor_llegada ) * 86400
			      , w_con_bcc
			      , 0
			      , w_con_exc
			      , 0
			      , w_con_top
			      , w_con_cig
			      , 0
			      );
   RETURN;
   WHEN OTHERS THEN

		    Out_vExtCodError	   := 'N';
			Out_vExtMensajeError   := RPAD('ERROR PROC.:'||v_vNomTrans,30);
		    Out_vReturnStatus	   := '1';
		    Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		    Out_vMessageCode 	   := '00000';

      w_fechor_salida := TO_DATE ( TO_CHAR ( SYSDATE, 'rrrr/mm/dd hh24:mi:ss' ), 'rrrr/mm/dd hh24:mi:ss');

      SRV_Message := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;

	  v_vSalida_Format  := SETEA_SALIDA;

	  w_res := Imed_Graba_Auditoria ( v_vnomtrans
			      , SYSDATE
			      , NULL
			      , NULL
			      , NULL
			      , TO_NUMBER ( SUBSTR ( In_vExtRutAcompanante, 1, 10 ))
			      , TO_NUMBER (SUBSTR ( In_vExtRutBeneficiario, 1, 10 ))
			      , v_nrut_coti
			      , v_nfolio_suscripcion
			      , v_ncodigo_carga
			      , NULL
			      , NULL
			      , NULL
			      , NULL
			      , NULL
			      , v_vEntrada_Format
			   	  , v_vSalida_Format
			      , w_fechor_llegada
			      , w_fechor_salida
			      , ( w_fechor_salida - w_fechor_llegada ) * 86400
			      , w_con_bcc
			      , 0
			      , w_con_exc
			      , 0
			      , w_con_top
			      , w_con_cig
			      , 0
			      );
	  RETURN;
END;

END Coninfenrola_Pkg;

383 rows selected.

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
