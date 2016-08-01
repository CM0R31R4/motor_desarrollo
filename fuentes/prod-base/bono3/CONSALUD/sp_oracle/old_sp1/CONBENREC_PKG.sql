
SQL*Plus: Release 11.2.0.3.0 Production on Wed Mar 5 18:59:59 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONBENREC
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTRUTCOTIZANTE		VARCHAR2		IN
 IN_NEXTCORRBENEF		NUMBER			IN
 IN_VEXTRUTBENEFICIARIO 	VARCHAR2		IN
 OUT_VEXTCODRESBEN		VARCHAR2		OUT
 OUT_VEXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Conbenrec_Pkg
AS
    PROCEDURE Conbenrec
     (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nextCodFinanciador	 	IN 	   NUMBER
		   , In_vextRutCotizante		IN 	   VARCHAR2
   		   , In_nextCorrBenef	       		IN 	   NUMBER
		   , In_vextRutBeneficiario			IN 	   VARCHAR2
   		   , Out_vextCodResBen				OUT	   VARCHAR2
   		   , Out_vextMensajeError			OUT	   VARCHAR2);

END Conbenrec_Pkg;

13 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     Conbenrec_Pkg
AS

    PROCEDURE Conbenrec
     (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nextCodFinanciador	 	IN 	   NUMBER
		   , In_vextRutCotizante		IN 	   VARCHAR2
   		   , In_nextCorrBenef	       		IN 	   NUMBER
		   , In_vextRutBeneficiario			IN 	   VARCHAR2
   		   , Out_vextCodResBen				OUT	   VARCHAR2
   		   , Out_vextMensajeError			OUT	   VARCHAR2
    )
IS

v_vnomtrans		  	 VARCHAR2 ( 50 ) := UPPER('Conbenrec_Pkg');

v_vEntrada_Format			 VARCHAR2(2000);
v_vSalida_Format			 VARCHAR2(2000);
v_sep_ES	   				 VARCHAR2(1):=';';

Out_vReturnStatus			 VARCHAR2(1);
Out_vMessageCode 			 VARCHAR2(5);
Out_vMessageText			 VARCHAR2(243);
SRV_FetchStatus				 NUMBER(1) :='1';
SRV_Total_Rows				 NUMBER(8);
SRV_Row_Count				 NUMBER(8);
v_vCarIniMessageText		 VARCHAR2(1):='X'; -- Para diferenciar Out_vMessageText
											   -- de Out_vExtMensajeError

   w_fechor_llegada	     DATE;
   w_fechor_salida	     DATE;
   w_res		     NUMBER ( 1 )    := 0;
   w_con_bcc		     NUMBER ( 1 )    := 0;
   w_con_exc		     NUMBER ( 1 )    := 0;
   w_con_top		     NUMBER ( 1 )    := 0;
   w_con_cig		     NUMBER ( 1 )    := 0;

-- Codigo de la Isapre para Validar Contra Entrada
   v_ncod_isa_cons	     NUMBER	     := 71;
   no_afiliado		     EXCEPTION;
   no_vigente		     EXCEPTION;

--- Variables para almacenar parametros de entrada
   v_nextcodfinanciador      NUMBER ( 3 );
   v_vextrutcotizante	     VARCHAR2 ( 12 );
   v_nextsolorutcotiz	     NUMBER ( 10 );
   v_vextsolodvcotiz	     VARCHAR2 ( 1 );
   v_nextcorrbenef	     NUMBER ( 3 );
-- Variable para capturar el rut de entrada de beneficiario a actualizar
   v_vextrutbeneficiario     VARCHAR2 ( 12 );
-- Variables para separar el rut y digito verificador
   v_nextsolorutbenef	     NUMBER ( 10 );
   v_vextsolodvbenef	     VARCHAR2 ( 1 );

   v_nrutvalidacion	     NUMBER ( 10 ):=0;
--------------------------------------------------

   E_FIN		     EXCEPTION;
   NO_HOMOLOGADO			 EXCEPTION;
   v_vseparador 	     VARCHAR2 ( 1 )  := '|';
   v_nRut_Ya_Homologado		 NUMBER(1);

   v_nTotal_Homologa		 NUMBER(3);
--------------------------------------------------

--- Variables para almacenar datos consultados

--- Del cotizante
   v_npers_rut_real_c	     NUMBER ( 10 );
   v_nfolio_suscripcion_c    NUMBER ( 10 );
   v_norga_codigo_isapre_c   NUMBER ( 3 );
   v_nbenc_codigo_carga_c    NUMBER ( 3 );

--- Del Beneficiario
   v_npers_rut_real_b	     NUMBER ( 10 );
   v_nfolio_suscripcion_b    NUMBER ( 10 );
   v_norga_codigo_isapre_b   NUMBER ( 3 );
   v_nbenc_codigo_carga_b    NUMBER ( 3 );
   v_nexiste_homologacion    NUMBER ( 10 );

   v_nauxfolio_suscripcion	 NUMBER;
   v_nauxorga_codigo_isapre  NUMBER;
   v_naux_codigo_carga		 NUMBER;
   E_YA_HOMOLOGO			 EXCEPTION;
   HOMOLOGADO_OTRO_RUT		 EXCEPTION;
   E_NO_CARGA_CERO			 EXCEPTION;
   E_RUT_MAYOR_CERO			 EXCEPTION;

FUNCTION SETEA_ENTRADA
RETURN VARCHAR2
IS
v_vEntrada			   		 VARCHAR2(2000);
BEGIN
v_vEntrada	:=  SUBSTR(TO_CHAR(In_nextCodFinanciador)||v_sep_ES||
				In_vextRutCotizante||v_sep_ES||
	   		    TO_CHAR(In_nextCorrBenef)||v_sep_ES||
				In_vextRutBeneficiario||v_sep_ES,1,2000);
RETURN v_vEntrada;
END;


FUNCTION SETEA_SALIDA
RETURN VARCHAR2
IS
v_vSalida	   			 VARCHAR2(2000);

BEGIN
v_vSalida:=  SUBSTR(SRV_Message||v_sep_ES||
			 Out_vextCodResBen||v_sep_ES||
			 Out_vextMensajeError||v_sep_ES,1,2000);
RETURN v_vSalida;
END;

PROCEDURE LIMPIA
AS
BEGIN
NULL;
END;

BEGIN
   w_fechor_llegada  := TO_DATE ( TO_CHAR ( SYSDATE, 'rrrr/mm/dd hh24:mi:ss' ), 'rrrr/mm/dd hh24:mi:ss');

   v_nextcodfinanciador 	  := In_nextcodfinanciador;
   -- Si el codigo no corresponde a Consalud
   IF ( v_nextcodfinanciador != v_ncod_isa_cons )
   THEN
--    Out_vReturnStatus		 := '0';
   	  Out_vReturnStatus		 := '1';
      Out_vextCodResBen 	 := 'P';
      Out_vextMensajeError 	 := RPAD('Codigo isapre no corresponde',30);
   	  Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
--	  Out_vMessageCode   	 := '78001';
	  Out_vMessageCode   	 := '00000';
   	  SRV_Message 		     := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
      RAISE E_FIN;
   END IF;

   v_vextrutcotizante 		  := In_vextrutCotizante;
     v_nextsolorutcotiz 	  := TO_NUMBER ( SUBSTR ( In_vextrutCotizante, 1, 10 ));
     v_vextsolodvcotiz 		  := SUBSTR ( In_vextrutCotizante, -1, 1 );
   v_nextcorrbenef 			  := TO_NUMBER (In_nextCorrBenef);
   v_vextrutbeneficiario 	  := In_vextrutBeneficiario;
     v_nextsolorutbenef 	  := TO_NUMBER ( SUBSTR ( In_vextrutBeneficiario, 1, 10 ) );
     v_vextsolodvbenef 		  := SUBSTR ( In_vextrutBeneficiario, -1, 1 );

   --- Consulta si Rut de COTIZANTE existe
   BEGIN
      SELECT pers.rut_real
	  	   , coaf.folio_suscripcion
	   , coaf.orga_codigo_isapre
		   , benc.codigo_carga
	INTO v_npers_rut_real_c
		   , v_nfolio_suscripcion_c
	   , v_norga_codigo_isapre_c
		   , v_nbenc_codigo_carga_c
	FROM afi_personas pers
	   , afi_beneficiarios_contrato benc
	   , afi_contratos_afiliados coaf
       WHERE pers.rut_real = v_nextsolorutcotiz
	 AND benc.pers_correlativo = pers.correlativo
	 AND coaf.folio_suscripcion = benc.coaf_folio_suscripcion
	 AND coaf.orga_codigo_isapre = benc.coaf_orga_codigo_isapre
--	   AND benc.fecha_termino_beneficio IS NULL
		 AND benc.FECHA_INICIO_BENEFICIOS <= TRUNC(SYSDATE)
			AND NVL(benc.fecha_termino_beneficio,TRUNC(SYSDATE))>= TRUNC(SYSDATE);


		 IF v_nbenc_codigo_carga_c > 0 THEN
	  RAISE E_NO_CARGA_CERO;
		 END IF;

   EXCEPTION
      WHEN E_NO_CARGA_CERO THEN
--    	   Out_vReturnStatus	 := '0';
    	   Out_vReturnStatus	 := '1';
       	   Out_vextCodResBen 	 := 'P';
       	   Out_vextMensajeError  := RPAD('Rut Cons.Cotiz No es Carg 0',30);
    	   Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
--	  	   Out_vMessageCode   	 := '78009';
	  	   Out_vMessageCode   	 := '00000';
      	   SRV_Message 		     := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
	  RAISE E_FIN;
	  WHEN NO_DATA_FOUND
      THEN
--	  	 Out_vReturnStatus		 := '0';
	  	 Out_vReturnStatus		 := '1';
      	 Out_vextCodResBen 		 := 'P';
      	 Out_vextMensajeError 	 := RPAD('Rut Cons.Cotiz no Existe',30);
   	  	 Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
--	  	 Out_vMessageCode   	 := '78002';
	  	 Out_vMessageCode   	 := '00000';
      	 SRV_Message 		     := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
	 RAISE E_FIN;
   END;

   /* VALIDA QUE EL RUT DE LA PERSONA EN LA ISAPRE SEA NULO o 0*/
   BEGIN
      SELECT benc.codigo_carga, NVL(pers.rut_real,0)
	INTO v_nbenc_codigo_carga_b, v_nrutvalidacion
	FROM afi_personas 			    pers
	   , afi_beneficiarios_contrato benc
	   , afi_contratos_afiliados coaf
       WHERE benc.pers_correlativo   = pers.correlativo
	 AND coaf.folio_suscripcion  = benc.coaf_folio_suscripcion
	 AND coaf.orga_codigo_isapre = benc.coaf_orga_codigo_isapre
	 AND benc.codigo_carga 		 = v_nextcorrbenef
	 AND coaf.folio_suscripcion  = v_nfolio_suscripcion_c
	 AND coaf.orga_codigo_isapre = v_norga_codigo_isapre_c
	 --AND benc.fecha_termino_beneficio IS NULL
		 AND benc.FECHA_INICIO_BENEFICIOS <= TRUNC(SYSDATE)
		 AND NVL(benc.fecha_termino_beneficio,TRUNC(SYSDATE))>= TRUNC(SYSDATE)
			;
      IF v_nrutvalidacion > 0
      THEN
--	  	 Out_vReturnStatus		 := '0';
   	  	 Out_vReturnStatus		 := '1';
      	 Out_vextCodResBen 		 := 'P';
      	 Out_vextMensajeError 	 := RPAD('No Actualiza rut Isapre > 0',30);
   	  	 Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
--	  	 Out_vMessageCode   	 := '78003';
	  	 Out_vMessageCode   	 := '00000';
      	 SRV_Message 		     := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
	 RAISE E_RUT_MAYOR_CERO;
      END IF;

      EXCEPTION
	  WHEN E_RUT_MAYOR_CERO THEN
	    RAISE E_FIN;
      WHEN NO_DATA_FOUND
      THEN
--		 Out_vReturnStatus		 := '0';
    	 Out_vReturnStatus		 := '1';
      	 Out_vextCodResBen 		 := 'P';
      	 Out_vextMensajeError 	 := RPAD('Carga Correlativo no Existe',30);
   	  	 Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
--	  	 Out_vMessageCode   	 := '78006';
	  	 Out_vMessageCode   	 := '00000';
      	 SRV_Message 		     := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		 RAISE E_FIN;
   END;

-- Consulta si el Rut Ya esta Homologado
   BEGIN
   	 SELECT BENC_COAF_FOLIO_SUSCRIPCION,
     	    BENC_COAF_ORGA_CODIGO_ISAPRE,
    		BENC_CODIGO_CARGA
       INTO	v_nauxfolio_suscripcion
       	   , v_nauxorga_codigo_isapre
       	   , v_naux_codigo_carga
       FROM
    	    IMED_HOMOLOGO_BENEFICIARIOS HOBE
      WHERE  HOBE.RUT_BENEF = v_nextsolorutbenef;

	 v_nRut_Ya_Homologado := 1;
	 EXCEPTION WHEN OTHERS THEN
	 v_nRut_Ya_Homologado := 0;
  END;

--- Busco que el mismo beneficiario no este Homologado con Otro rut
  IF v_nRut_Ya_Homologado = 0 THEN
  BEGIN
	SELECT COUNT(*)
	  INTO v_nTotal_Homologa
	  FROM
		   IMED_HOMOLOGO_BENEFICIARIOS HOBE
	 WHERE HOBE.BENC_COAF_FOLIO_SUSCRIPCION  = v_nfolio_suscripcion_c
	   AND HOBE.BENC_COAF_ORGA_CODIGO_ISAPRE = v_norga_codigo_isapre_c
	   AND HOBE.BENC_CODIGO_CARGA			 = v_nextcorrbenef;
	IF v_nTotal_Homologa > 0 THEN
	    Out_vReturnStatus	:= '1';
   		Out_vextCodResBen   := 'P';
      	Out_vextMensajeError:= RPAD('Benef.Homologado con Otro Rut',30);
   	  	Out_vMessageText	   := v_vCarIniMessageText||Out_vextMensajeError;
	  	Out_vMessageCode    := '00000';
      	SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		RAISE HOMOLOGADO_OTRO_RUT;
	END IF;
	EXCEPTION WHEN HOMOLOGADO_OTRO_RUT THEN
	  RAISE E_FIN;
	WHEN OTHERS THEN
	  NULL;
  END;
  END IF;

  IF v_nRut_Ya_Homologado = 1 THEN

	  IF	 v_nauxfolio_suscripcion  =  v_nfolio_suscripcion_c
   	  AND	 v_nauxorga_codigo_isapre =  v_norga_codigo_isapre_c
   	  AND	 v_naux_codigo_carga	  =  v_nextcorrbenef
	  THEN
--			Out_vReturnStatus		 := '0';
			Out_vReturnStatus		 := '1';
      	    Out_vextCodResBen 		 := 'P';
      	 	Out_vextMensajeError 	 := RPAD('Rut ya Homologado',30);
   	  	 	Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
--	  	 	Out_vMessageCode   	 	 := '78005';
	  	 	Out_vMessageCode   	 	 := '00000';
      	 	SRV_Message 		     := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
	 	RAISE E_FIN;
      END IF;

	  IF	v_nauxfolio_suscripcion   != v_nfolio_suscripcion_c
   	  OR	v_nauxorga_codigo_isapre  != v_norga_codigo_isapre_c
   	  OR	v_naux_codigo_carga		  != v_nextcorrbenef
	  THEN
--			Out_vReturnStatus		 := '0';
			Out_vReturnStatus		 := '1';
      	    Out_vextCodResBen 		 := 'P';
      	 	Out_vextMensajeError 	 := RPAD('Rut Homologado otro grupo',30);
   	  	 	Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
--	  	 	Out_vMessageCode   	 	 := '78004';
	  	 	Out_vMessageCode   	 	 := '00000';
      	 	SRV_Message 		     := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
	     	RAISE E_FIN;
	  END IF;
  END IF;




-- INSERTA EL REGISTRO DE HOMOLOGACION
   BEGIN
      INSERT INTO imed_homologo_beneficiarios
		  ( benc_coaf_folio_suscripcion
		  , benc_coaf_orga_codigo_isapre
				  , benc_codigo_carga
		  , rut_benef
				  , dig_benef
		  , rut_cotiz
				  , dig_cotiz
		  )
	   VALUES ( v_nfolio_suscripcion_c
		  , v_norga_codigo_isapre_c
				  , v_nextcorrbenef
		  , v_nextsolorutbenef
				  , v_vextsolodvbenef
		  , v_nextsolorutcotiz
				  , v_vextsolodvcotiz
		  );

      COMMIT;
   EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
--		 Out_vReturnStatus		 := '0';
 		 Out_vReturnStatus		 := '1';
      	 Out_vextCodResBen 		 := 'P';
      	 Out_vextMensajeError 	 := RPAD('Beneficiario ya homologado (I)',30);
   	  	 Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
--	  	 Out_vMessageCode   	 := '78007';
	  	 Out_vMessageCode   	 := '00000';
      	 SRV_Message 		     := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
	 RAISE E_FIN;
      WHEN OTHERS
      THEN
--		 Out_vReturnStatus		 := '0';
 		 Out_vReturnStatus		 := '1';
      	 Out_vextCodResBen 		 := 'P';
      	 Out_vextMensajeError 	 := RPAD('Error al Insertar Homologacion',30);
   	  	 Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
--	  	 Out_vMessageCode   	 := '78008';
	  	 Out_vMessageCode   	 := '00000';
      	 SRV_Message 		     := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;

	 RAISE E_FIN;
   END;
-- Setea el codigo de actualizacion
   Out_vReturnStatus	 := '1';
   Out_vextCodResBen 	 := 'G';
   Out_vextMensajeError  := RPAD('Actualizacion Correcta',30);
   Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
-- Out_vMessageCode   	 := '38001';
   Out_vMessageCode   	 := '00000';
   SRV_Message 			 := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;

   v_vSalida_Format := SETEA_SALIDA;
   w_fechor_salida := TO_DATE ( TO_CHAR ( SYSDATE, 'rrrr/mm/dd hh24:mi:ss' ), 'rrrr/mm/dd hh24:mi:ss');
   w_res := Imed_Graba_Auditoria ( v_vnomtrans
			   , w_fechor_llegada
			   , NULL
			   , NULL
			   , NULL
			   , NULL
			   , v_nextsolorutbenef
			   , v_nextsolorutcotiz
			   , v_nfolio_suscripcion_c
			   , v_nbenc_codigo_carga_b
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
   WHEN E_FIN
   THEN
      SRV_Message := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
      v_vSalida_Format := SETEA_SALIDA;
      w_fechor_salida :=TO_DATE ( TO_CHAR ( SYSDATE, 'rrrr/mm/dd hh24:mi:ss' ), 'rrrr/mm/dd hh24:mi:ss');
      w_res :=Imed_Graba_Auditoria ( v_vnomtrans
			      , w_fechor_llegada
			      , NULL
			      , NULL
			      , NULL
			      , NULL
			      , v_nextsolorutbenef
			      , v_nextsolorutcotiz
			      , v_nfolio_suscripcion_c
			      , v_nbenc_codigo_carga_b
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
   WHEN OTHERS
   THEN
--   Out_vReturnStatus	 	 := '0';
     Out_vReturnStatus	 	 := '1';
   	 Out_vextCodResBen 	   	 := 'P';
   	 Out_vextMensajeError 	 := RPAD('ERROR PROC.:'||v_vNomTrans,30);
   	 Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
-- 	 Out_vMessageCode   	 := '78099';
   	 Out_vMessageCode   	 := '00000';

     SRV_Message := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
     v_vSalida_Format := SETEA_SALIDA;
     w_fechor_salida :=TO_DATE ( TO_CHAR ( SYSDATE, 'rrrr/mm/dd hh24:mi:ss' ), 'rrrr/mm/dd hh24:mi:ss');
     w_res := Imed_Graba_Auditoria ( v_vnomtrans
			      , w_fechor_llegada
			      , NULL
			      , NULL
			      , NULL
			      , NULL
			      , v_nextsolorutbenef
			      , v_nextsolorutcotiz
			      , v_nfolio_suscripcion_c
			      , v_nbenc_codigo_carga_b
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
END Conbenrec_Pkg;

488 rows selected.

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
