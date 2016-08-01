
SQL*Plus: Release 11.2.0.3.0 Production on Wed Mar 5 18:59:58 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONANULABONOU
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_NEXTFOLIOBONO		NUMBER			IN
 IN_VEXTINDTRATAM		VARCHAR2		IN
 IN_VEXTFECTRATAM		VARCHAR2		IN
 OUT_VEXTCODERROR		VARCHAR2		OUT
 OUT_VEXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Conanulabonou_Pkg
AS
   PROCEDURE Conanulabonou
   			 (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nExtCodFinanciador	 	IN 	   NUMBER
		   , In_nExtFolioBono				IN	   NUMBER
		   , In_vExtIndTratam				IN	   VARCHAR2
		   , In_vExtFecTratam				IN	   VARCHAR2
		   , Out_vExtCodError				OUT	   VARCHAR2
		   , Out_vExtMensajeError			OUT	   VARCHAR2

			 );
END Conanulabonou_Pkg;

14 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     Conanulabonou_Pkg AS


PROCEDURE Conanulabonou    ( SRV_Message 		  			IN OUT VARCHAR2
							, In_nExtCodFinanciador       	IN 	   NUMBER
							, In_nExtFolioBono				IN	   NUMBER
							, In_vExtIndTratam				IN	   VARCHAR2
							, In_vExtFecTratam				IN	   VARCHAR2
							, Out_vExtCodError				OUT	   VARCHAR2
							, Out_vExtMensajeError			OUT	   VARCHAR2
							) IS
/*
   Esta funcion anula bonos electronicos generados, producto de autorizaciones
   (920) que se cursaron, pero que dentro del mismo dia de emision fueron
   devueltos por el beneficiario
*/
v_vNomTrans				  	VARCHAR2(50):= UPPER('Conanulabonou_Pkg');

-- 20030212 CAGF Nuevas variables
v_vEntrada_Format			VARCHAR2(2000);
v_vSalida_Format			VARCHAR2(2000);
v_sep_ES	   				VARCHAR2(1):=';';
Out_vReturnStatus			VARCHAR2(1);
Out_vMessageCode 			VARCHAR2(5);
Out_vMessageText			VARCHAR2(243);
SRV_FetchStatus				NUMBER(1) := '0'; -- No tiene variables tipo Column Output
SRV_Total_Rows				NUMBER(8);
SRV_Row_Count				NUMBER(8);
v_vCarIniMessageText		VARCHAR2(1):='X'; -- Para diferenciar Out_vMessageText
														  	  -- de Out_vExtMensajeError

-- Codigo de la Isapre, para validar contra entrada
v_ncod_isa_cons 	   	NUMBER:= 71;
isapre_no_corresponde		EXCEPTION;
no_familia_homologada		EXCEPTION;

/* Variables Auxiliares utilizadas por la Funcion */
sal			  	NUMBER	   (1);
w_res			  	NUMBER	   (1);
secuencia		 	NUMBER	  (16):=0;

w9120_codisa		  	NUMBER	   (4):=0;
--w9120_prtnum		    NUMBER    (18):=0;
w9120_isanum		  	NUMBER	  (18):=0;
--w9120_isaaut		    NUMBER     (8):=0;
--w9120_pfcsuc		    NUMBER     (8):=0;
--w9120_ctzcorr 	    NUMBER     (4):=0;
w9120_prtcor		  	NUMBER	   (4):=0;
--w9120_prtvis		    NUMBER    (12):=0;
--w9120_prtvbn		    NUMBER    (12):=0;
--w9120_prtvcp		    NUMBER    (12):=0;

w_famter    				NUMBER	  (10):=0;
w_codter    				VARCHAR2  (16):=NULL;
w_folafi    				NUMBER	  (10):=0;
w_codcar    				NUMBER	   (4):=0;
w_bonisa    				NUMBER	  (10):=0;
w_autisa    				NUMBER	   (8):=0;
w_montot	   			NUMBER	  (10):=0;
w_pretot		 	NUMBER	   (4):=0;
w_monisa		  	NUMBER	  (10):=0;
w_moncop		  	NUMBER	  (10):=0;
w_isaate		  	VARCHAR2(2000):=NULL;
w_ateisa				  	VARCHAR2(2000):=NULL;
w_mtobcc		  	NUMBER	  (10):=0;
w_mtoexc		  	NUMBER	  (10):=0;

w_candoc		 	NUMBER	   (6):=0;
w_canlin		  	NUMBER	   (6):=0;
w_canest		  	NUMBER	   (6):=0;
w_fecemi		  	VARCHAR2   (10):=NULL;
w_estado		  	VARCHAR2   (3):=NULL;

W_FECHOR_LLEGADA			DATE:=NULL;
W_FECHOR_SALIDA				DATE:=NULL;
W_CON_BCC					VARCHAR2 (1):=NULL;
W_CON_EXC					VARCHAR2 (1):=NULL;
W_CON_TOP					VARCHAR2 (1):=NULL;
W_CON_CIG					VARCHAR2 (1):=NULL;
W_BCCEXCTOP					VARCHAR2 (1):=NULL;

-- variables de excedente
v_renuncia 	 			 	VARCHAR2(1);
n_monto_excedente 			NUMBER(10):=0;
v_excedente 				VARCHAR2(50);
n_numero 					NUMBER(1);

-- variables de los topes
v_salida_tope 			 	VARCHAR2(10);
v_mensaje_tope 				VARCHAR2(100);

no_auditoria 				EXCEPTION;
no_beneficiario 			EXCEPTION;
no_reg_documen 				EXCEPTION;
no_bono_isapre 				EXCEPTION;
no_bono_distinto 			EXCEPTION;
no_anular_bono 				EXCEPTION;
no_anula_cigna 				EXCEPTION;
no_reversa_bcc 				EXCEPTION;
no_reversa_excedente 		EXCEPTION;
--acs
si_existe_migracion			EXCEPTION;

/* APLICACION SEGURO CIGNA */
v_aseg_correlativo 	 	   NUMBER(10):=0;
w_unor_correlativo_emitido NUMBER(4):=0;
n_codigo_error 			   NUMBER(10):=0;
n_mensaje_error 		   VARCHAR2(80):=' ';
n_grabo 				   VARCHAR2(01):=' ';


-- Imed
v_nExtCodFinanaciador	   NUMBER(3);
v_nExtFolioBono			   NUMBER(10);
v_vExtIndTratam			   VARCHAR2(1);
v_dExtFecTratam			   DATE;
v_vExtCodError			   VARCHAR2(1);
v_vExtMensajeError		   VARCHAR2(30);
v_vSeparador			   VARCHAR2(1):='|';

v_nExtRutCotizante		   NUMBER;
v_nFolio_Suscripcion	   NUMBER;
v_vCodigoCarga			   NUMBER;
w_bandera				   NUMBER:=NULL;

no_anulacion_ges		   EXCEPTION;		   	   	  --EACE 28-06-2005  GES
vn_MONTO_GES			   NUMBER(12,2):=0; 		  --EACE 28-06-2005  GES
vv_ErrorCode			   VARCHAR2(200):= NULL;   --EACE 28-06-2005  GES

---20030226 CAGF Variable para Homologar Sucursal Venta
v_nSucVenta				   NUMBER(10);
vn_EXISTE				   NUMBER(10):=0;
vv_ESTADO				   VARCHAR2(10):='';
vv_ANULA_CENTRAL		   VARCHAR2(10):='N';
vn_DOFI_CODIGO			   NUMBER(10):=0;

--ACS 2006/06/05 variable para validar existencia de bono en tabla migracion
vn_EXISTE_MIGRA   			   NUMBER(10):=0;
e_error_anulacion_nuevo		   EXCEPTION;
vn_UNOR_CORRELATIVO			   NUMBER:=0;
vv_FECHA_CAJA				   VARCHAR2(10):='';
vv_USUARIO_CAJA				   VARCHAR2(30):='';
vv_RETORNA_RESULTADO_ANULA	   VARCHAR2(20):='';
vn_PRODUCCION				   NUMBER:=0;
vn_LOCAL					   NUMBER:=0;


FUNCTION VALOR(p_vIN IN    VARCHAR2) RETURN NUMBER IS
BEGIN
	IF p_vIN = 'S' THEN
	   RETURN 1;
	END IF;
	RETURN 0;
END VALOR;

FUNCTION SETEA_ENTRADA RETURN VARCHAR2 IS
v_vEntrada			   VARCHAR2(2000);
BEGIN
	v_vEntrada	:=  --RPAD(SRV_Message||v_sep_ES||
					SUBSTR(TO_CHAR(In_nExtCodFinanciador)||v_sep_ES||
					TO_CHAR(In_nExtFolioBono)||v_sep_ES||
					In_vExtIndTratam||v_sep_ES||
					In_vExtFecTratam||v_sep_ES,1,2000);
	RETURN v_vEntrada;
END SETEA_ENTRADA;

FUNCTION SETEA_SALIDA RETURN VARCHAR2 IS
v_vSalida	   VARCHAR2(2000);

BEGIN
	v_vSalida   :=	SUBSTR(SRV_Message||v_sep_ES||
					Out_vExtCodError||v_sep_ES||
					Out_vExtMensajeError||v_sep_ES,1,2000);
	RETURN v_vSalida;
END	SETEA_SALIDA;

BEGIN	 -- PROGRAMA PRINCIPAL
	W_FECHOR_LLEGADA:=SYSDATE;
	w_bandera:=110;
	DBMS_OUTPUT.PUT_LINE ('01');
	v_vEntrada_Format := SETEA_ENTRADA;

	-- Rescata Variables Imed
	v_nExtCodFinanaciador := In_nExtCodFinanciador;

	IF ( v_nExtCodFinanaciador != v_ncod_isa_cons ) THEN
		RAISE isapre_no_corresponde;
	END IF;

	v_nExtFolioBono		:= In_nExtFolioBono;
	v_vExtIndTratam		:= In_vExtIndTratam;
	v_dExtFecTratam		:= TO_DATE(SUBSTR(In_vExtFecTratam,1,14),'RRRRMMDDHH24MISS');
	DBMS_OUTPUT.PUT_LINE ('02');
	w_bandera:=120;
	w9120_codisa := v_nExtCodFinanaciador;
	w9120_isanum := v_nExtFolioBono;
	w_bandera:=130;


	IF w9120_isanum >=5000000000 OR w9120_isanum >=700000000  THEN -- VALIDA SI EJECUTAR NUEVO PROCESO DE ANULACION O ANTIGUO

		SELECT COUNT(*)
		INTO   vn_PRODUCCION
		FROM   BENEFICIOS.BEN_DOCUMENTOS_LIQUIDACIONES--BNF-000988 @PRODUCCION
		WHERE  CORRELATIVO = w9120_isanum;

		IF vn_PRODUCCION=0 THEN

		   SELECT COUNT(*)
		   INTO   vn_LOCAL
		   FROM   BENEFICIOS.BEN_DOCUMENTOS_LIQUIDACIONES
		   WHERE  CORRELATIVO = w9120_isanum;

		END IF;

		IF vn_PRODUCCION = 0 AND vn_LOCAL <> 0 THEN
		   vv_ANULA_CENTRAL:='N';
		ELSE
		   vv_ANULA_CENTRAL:='S';
		END IF;

	-- es nuevo
	    DBMS_OUTPUT.PUT_LINE ( 'PROCESO NUEVO' );
		BEGIN
			SELECT DISTINCT(NVL(UNOR_CORRELATIVO_SUC_VENTA,0)),TO_CHAR(RUT_BENEF)||'_IMED',NVL(MONTO_EXCEDENTE,0),folio_suscrip
			INTO   vn_UNOR_CORRELATIVO,vv_USUARIO_CAJA,w_mtoexc, w_folafi
			FROM   IMED_AUDITORIA
			WHERE  NOMBRE_TRANSACCION LIKE '%CONENVBONIS_PKG%'
			AND    NRO_BONO_ISAPRE =w9120_isanum;
		EXCEPTION
		WHEN OTHERS THEN
			 vn_UNOR_CORRELATIVO:=NULL;
			 vv_USUARIO_CAJA:='';
		END;

		vv_FECHA_CAJA:=TO_CHAR(SYSDATE,'DD/MM/RRRR');

	DBMS_OUTPUT.PUT_LINE ( 'w_mtoexc = ' || w_mtoexc );
		DBMS_OUTPUT.PUT_LINE ( 'vn_UNOR_CORRELATIVO= ' || vn_UNOR_CORRELATIVO );
		DBMS_OUTPUT.PUT_LINE ( 'vv_FECHA_CAJA= ' || vv_FECHA_CAJA );
		DBMS_OUTPUT.PUT_LINE ( 'vn_USUARIO_CAJA= ' || vv_USUARIO_CAJA );
		DBMS_OUTPUT.PUT_LINE ( 'w9120_isanum= ' || w9120_isanum );

		BEGIN
		DBMS_OUTPUT.PUT_LINE ( 'entre al proceso ' );

		IF vv_ANULA_CENTRAL = 'N' THEN
		vv_RETORNA_RESULTADO_ANULA:=BENEFICIOS.Pck_Ben_Devoluciones_Imed.Devuelve_Documentos_Arr(vn_UNOR_CORRELATIVO,
																	 							 vv_FECHA_CAJA,
																	 							 vv_USUARIO_CAJA,
																	 							 w9120_isanum);
		ELSE
		vv_RETORNA_RESULTADO_ANULA:=BENEFICIOS.Pck_Ben_Devoluciones_Imed.Devuelve_Documentos_Arr--BNF-000988 @PRODUCCION
													    (vn_UNOR_CORRELATIVO,
													    vv_FECHA_CAJA,
													    vv_USUARIO_CAJA,
													    w9120_isanum);
    END IF;
		DBMS_OUTPUT.PUT_LINE ( 'sali al proceso: '||vv_RETORNA_RESULTADO_ANULA );
		IF TRIM(vv_RETORNA_RESULTADO_ANULA)<>'OK' THEN
		   RAISE e_error_anulacion_nuevo;
		ELSE
		   COMMIT;
		END IF;

		EXCEPTION
		WHEN OTHERS THEN
			 DBMS_OUTPUT.PUT_LINE ( 'error:'||SUBSTR(SQLERRM,1,200) );
			 RAISE e_error_anulacion_nuevo;
		END;
	DBMS_OUTPUT.PUT_LINE ( '1 - w_mtoexc= ' || w_mtoexc );
	IF  w_mtoexc > 0 THEN
				BEGIN
					W_CON_EXC:='S';
					Pr_Actualiza_Ctaind('DEVOLUCION',   -- p_operacion IN VARCHAR2,
										1,		-- p_dofi_codigo IN NUMBER,
										w_folafi,	-- p_folio IN NUMBER,
										71,		-- p_isapre IN NUMBER,
										w9120_isanum,	    -- p_bono IN NUMBER,
										TO_CHAR(SYSDATE,'dd/mm/yyyy'),	      -- p_fecha IN VARCHAR2,
										w_mtoexc,	-- p_monto IN NUMBER,
										n_numero,	-- p_numero OUT NUMBER,
										v_excedente	-- p_glosa OUT VARCHAR2
										);
					DBMS_OUTPUT.PUT_LINE ( 'n_numero= ' || n_numero );
					DBMS_OUTPUT.PUT_LINE ( 'v_excedente= ' || v_excedente );
				EXCEPTION
					WHEN OTHERS THEN
						ROLLBACK;
						RAISE no_reversa_excedente;
				END;
			END IF;

	ELSE
		DBMS_OUTPUT.PUT_LINE ( 'PROCESO ANTIGUO' );

		-- ACS 2006/06/05  BUSCA BONO EN TABLA MIGRACION
		--

	vn_EXISTE_MIGRA:=0;
--BNF-000988
--			 SELECT COUNT(*)
--			 INTO vn_EXISTE_MIGRA
--			 FROM TMP_BONOS_DUP_POR_MIGRACION
--			 WHERE CORRELATIVO = In_nExtFolioBono
--			 AND TIPO = 'DOBE_IMED';

			 IF vn_EXISTE_MIGRA <> 0 THEN
			 	RAISE si_existe_migracion;
			 END IF;
		---

			BEGIN

				SELECT ESTADO
				INTO   vv_ESTADO
				FROM   EMBE_ESTADO_DOCUMENTOS ESDO
				WHERE  DOBE_CORRELATIVO =w9120_isanum
				AND    ESDO.FECHA = (SELECT MAX(ESDO2.FECHA)
					   		      	 FROM	EMBE_ESTADO_DOCUMENTOS ESDO2
									 WHERE	ESDO2.DOBE_CORRELATIVO = ESDO.DOBE_CORRELATIVO);

				DBMS_OUTPUT.PUT_LINE ( 'vv_ESTADO= ' || vv_ESTADO );
				IF vv_ESTADO = 'EMI' THEN
				   BEGIN
						SELECT	DOBE.BENC_COAF_FOLIO_AFILIADO FOLIO_SUSCRIP,
								DOBE.BENC_CODIGO_CARGA_AFILIADO CODIGO_CARGA,
								DOBE.CORRELATIVO NRO_BONO_ISAPRE,
								DOBE.MONTO_TOTAL MONTO_TOTAL_BONO,
								DOBE.PRESTACIONES_TOTALES PREST_TOTALES_BONO,
								DOBE.MONTO_ISAPRE MONTO_ISAPRE_BONO,
								DOBE.MONTO_COPAGO MONTO_COPAGO_BONO,
								DOBE.MONTO_BCC MONTO_BCC,
								DOBE.MONTO_EXCEDENTE MONTO_EXCEDENTE,
								DOBE.UNOR_CORRELATIVO_EMITIDO UNOR_CORRELATIVO_SUC_VENTA,
								PERS.RUT_REAL rut_cotiz,
								TO_CHAR(DOBE.FECHA_EMISION,'YYYYMMDD'),
								MONTO_GES,
								DOFI_CODIGO
						INTO	w_folafi,
								w_codcar,
								w_bonisa,
								w_montot,
								w_pretot,
								w_monisa,
								w_moncop,
								w_mtobcc,
								w_mtoexc,
								v_nSucVenta,
								v_nExtRutCotizante,
								w_fecemi,
								vn_MONTO_GES,
								vn_DOFI_CODIGO
						FROM 	EMBE_DOCUMENTOS_DE_BENEFICIO DOBE,
								AFI_BENEFICIARIOS_CONTRATO BENC,
								AFI_PERSONAS PERS
						WHERE 	DOBE.CORRELATIVO = w9120_isanum
						AND  	DOBE.ESTADO = 'EMI'
						AND  	DOBE.BENC_COAF_ORGA_ISAPRE_AFILIADO = BENC.COAF_ORGA_CODIGO_ISAPRE
						AND 	DOBE.BENC_CODIGO_CARGA_AFILIADO = BENC.CODIGO_CARGA
						AND 	DOBE.BENC_COAF_FOLIO_AFILIADO = BENC.COAF_FOLIO_SUSCRIPCION
						AND  	BENC.PERS_CORRELATIVO = PERS.CORRELATIVO;
					EXCEPTION
					WHEN NO_DATA_FOUND THEN
						RAISE no_auditoria;
					END;


					vv_ANULA_CENTRAL:='S';

					-- Bono Isapre que se pide Anular no registrado en auditoria
					IF vn_DOFI_CODIGO <> 920 THEN
						RAISE no_bono_isapre;
					END IF;


					IF  w_fecemi <> TO_CHAR(SYSDATE,'YYYYMMDD') THEN
						w_estado:= 'DEV';
					ELSE
						w_estado:= 'ANU';
					END IF;
					DBMS_OUTPUT.PUT_LINE ( 'w_estado= ' || w_estado );

					UPDATE EMBE_DOCUMENTOS_DE_BENEFICIO
					SET    ESTADO=w_estado,
						   AUDI_USUARIO_MODIFICACION = 'IMED: ANULACION',
						   AUDI_FECHA_MODIFICACION = SYSDATE
					WHERE  CORRELATIVO=w9120_isanum;

					UPDATE EMBE_LINEAS_DE_BENEFICIO
					SET    ESTADO = w_estado,
						   AUBO_USUA_USERNAME = 'IMED: ANULACION',
						   AUBO_FECHA = SYSDATE
					WHERE  DOBE_CORRELATIVO = w9120_isanum;

					SELECT ESDO_SEQ.NEXTVAL
					INTO   Secuencia
					FROM   dual;

					INSERT INTO EMBE_ESTADO_DOCUMENTOS (CORRELATIVO,
														DOBE_CORRELATIVO,
														USUA_USERNAME,
														ESTADO,
														FECHA)
												VALUES (Secuencia,
														w9120_isanum,
														'IMED: ANULACION',
														w_estado,
														SYSDATE);
				ELSE
					RAISE no_anular_bono;
				END IF;

			EXCEPTION
				--NO ESTA CENTRAL % ENTONCES ANULO LOCAL%
				WHEN NO_DATA_FOUND THEN
					DBMS_OUTPUT.PUT_LINE ('03');
					BEGIN
						SELECT COUNT(*)
						INTO   w9120_prtcor
						FROM   IMED_LIBE
						WHERE  dobe_correlativo = w9120_isanum;
					END;

					BEGIN
						SELECT	FOLIO_SUSCRIP,
								CODIGO_CARGA,
								NRO_BONO_ISAPRE,
								MONTO_TOTAL_BONO,
								PREST_TOTALES_BONO,
								MONTO_ISAPRE_BONO,
								MONTO_COPAGO_BONO,
								MONTO_BCC,
								MONTO_EXCEDENTE,
								UNOR_CORRELATIVO_SUC_VENTA,
								rut_cotiz
						INTO	w_folafi,
								w_codcar,
								w_bonisa,
								w_montot,
								w_pretot,
								w_monisa,
								w_moncop,
								w_mtobcc,
								w_mtoexc,
								v_nSucVenta,
								v_nExtRutCotizante
						FROM 	IMED_AUDITORIA
						WHERE 	NRO_BONO_ISAPRE = w9120_isanum
						AND 	UPPER(NOMBRE_TRANSACCION) = 'CONENVBONIS_PKG'
						AND 	datos_salida LIKE '%exitoso al bonificar%';
						dbms_output.put_line('ACCESO AUDITORIA');
					EXCEPTION
					    WHEN TOO_MANY_ROWS THEN --27-10-2005 soluciona problema de 2 auditorias de emision de un bono
							BEGIN
								SELECT	DOBE.BENC_COAF_FOLIO_AFILIADO FOLIO_SUSCRIP,
										DOBE.BENC_CODIGO_CARGA_AFILIADO CODIGO_CARGA,
										DOBE.CORRELATIVO NRO_BONO_ISAPRE,
										DOBE.MONTO_TOTAL MONTO_TOTAL_BONO,
										DOBE.PRESTACIONES_TOTALES PREST_TOTALES_BONO,
										DOBE.MONTO_ISAPRE MONTO_ISAPRE_BONO,
										DOBE.MONTO_COPAGO MONTO_COPAGO_BONO,
										DOBE.MONTO_BCC MONTO_BCC,
										DOBE.MONTO_EXCEDENTE MONTO_EXCEDENTE,
										DOBE.UNOR_CORRELATIVO_EMITIDO UNOR_CORRELATIVO_SUC_VENTA,
										PERS.RUT_REAL rut_cotiz
								INTO	w_folafi,
										w_codcar,
										w_bonisa,
										w_montot,
										w_pretot,
										w_monisa,
										w_moncop,
										w_mtobcc,
										w_mtoexc,
										v_nSucVenta,
										v_nExtRutCotizante
								FROM 	IMED_DOBE DOBE,
										AFI_BENEFICIARIOS_CONTRATO BENC,
										AFI_PERSONAS PERS
								WHERE 	DOBE.CORRELATIVO = w9120_isanum
								AND  	DOBE.ESTADO = 'EMI'
								AND  	DOBE.BENC_COAF_ORGA_ISAPRE_AFILIADO = BENC.COAF_ORGA_CODIGO_ISAPRE
								AND 	DOBE.BENC_CODIGO_CARGA_AFILIADO = BENC.CODIGO_CARGA
								AND 	DOBE.BENC_COAF_FOLIO_AFILIADO = BENC.COAF_FOLIO_SUSCRIPCION
								AND  	BENC.PERS_CORRELATIVO = PERS.CORRELATIVO;
							EXCEPTION
								WHEN NO_DATA_FOUND THEN
									RAISE no_auditoria;
							END;
						WHEN NO_DATA_FOUND THEN
							BEGIN
								SELECT	DOBE.BENC_COAF_FOLIO_AFILIADO FOLIO_SUSCRIP,
										DOBE.BENC_CODIGO_CARGA_AFILIADO CODIGO_CARGA,
										DOBE.CORRELATIVO NRO_BONO_ISAPRE,
										DOBE.MONTO_TOTAL MONTO_TOTAL_BONO,
										DOBE.PRESTACIONES_TOTALES PREST_TOTALES_BONO,
										DOBE.MONTO_ISAPRE MONTO_ISAPRE_BONO,
										DOBE.MONTO_COPAGO MONTO_COPAGO_BONO,
										DOBE.MONTO_BCC MONTO_BCC,
										DOBE.MONTO_EXCEDENTE MONTO_EXCEDENTE,
										DOBE.UNOR_CORRELATIVO_EMITIDO UNOR_CORRELATIVO_SUC_VENTA,
										PERS.RUT_REAL rut_cotiz
								INTO	w_folafi,
										w_codcar,
										w_bonisa,
										w_montot,
										w_pretot,
										w_monisa,
										w_moncop,
										w_mtobcc,
										w_mtoexc,
										v_nSucVenta,
										v_nExtRutCotizante
								FROM 	IMED_DOBE DOBE,
										AFI_BENEFICIARIOS_CONTRATO BENC,
										AFI_PERSONAS PERS
								WHERE 	DOBE.CORRELATIVO = w9120_isanum
								AND  	DOBE.ESTADO = 'EMI'
								AND  	DOBE.BENC_COAF_ORGA_ISAPRE_AFILIADO = BENC.COAF_ORGA_CODIGO_ISAPRE
								AND 	DOBE.BENC_CODIGO_CARGA_AFILIADO = BENC.CODIGO_CARGA
								AND 	DOBE.BENC_COAF_FOLIO_AFILIADO = BENC.COAF_FOLIO_SUSCRIPCION
								AND  	BENC.PERS_CORRELATIVO = PERS.CORRELATIVO;
							EXCEPTION
								WHEN NO_DATA_FOUND THEN
									RAISE no_auditoria;
							END;
					END;
			END;

			DBMS_OUTPUT.PUT_LINE ('04');
			w_bandera:=140;
			--NO ESTA CENTRAL % ENTONCES ANULO LOCAL%

			dbms_output.put_line('terminal	  : '||w_codter);
			dbms_output.put_line('folio	  : '||w_folafi);
			dbms_output.put_line('carga	  : '||w_codcar);
			dbms_output.put_line('bono isapre : '||w_bonisa);
			dbms_output.put_line('autorizacion: '||w_autisa);
			dbms_output.put_line('mto.total   : '||w_montot);
			dbms_output.put_line('prest.total : '||w_pretot);
			dbms_output.put_line('mto.isapre  : '||w_monisa);
			dbms_output.put_line('mto.copago  : '||w_moncop);


			BEGIN
				SELECT	ben.ASEG_CORRELATIVO,
						ben.BENC_COAF_FOLIO_SUSCRIPCION,
						ben.BENC_CODIGO_CARGA
				INTO 	v_aseg_correlativo,
						v_nFolio_Suscripcion,
						v_vCodigoCarga
				FROM 	AFI_BENEFICIARIOS_CONTRATO BEN
				WHERE 	ben.coaf_folio_suscripcion = w_folafi
				AND 	ben.coaf_orga_codigo_isapre = 71
				AND 	ben.codigo_carga = w_codcar;
			EXCEPTION
				WHEN OTHERS THEN
					RAISE no_beneficiario;
			END;



			DBMS_OUTPUT.PUT_LINE ('05');

			IF vv_ANULA_CENTRAL = 'N' THEN
				SELECT COUNT(*),
					   MIN(TO_CHAR(DOCU.FECHA_EMISION,'YYYYMMDD'))
				INTO   w_candoc,
					   w_fecemi
				FROM   IMED_DOBE DOCU
				WHERE  DOCU.CORRELATIVO = w9120_isanum;

				SELECT MONTO_GES
				INTO   vn_MONTO_GES
				FROM   IMED_DOBE DOCU
				WHERE  DOCU.CORRELATIVO = w9120_isanum;

				dbms_output.put_line('ACCESO DOBE ==> '||w_candoc);

				SELECT COUNT(*)
				INTO   w_canlin
				FROM   IMED_LIBE LINE
				WHERE  LINE.DOBE_CORRELATIVO = w9120_isanum;

				SELECT COUNT(*)
				INTO   w_canest
				FROM   IMED_ESDO ESTA
				WHERE  ESTA.DOBE_CORRELATIVO = w9120_isanum;

				IF  w_candoc = 0 OR w_canlin = 0 OR w_canest = 0 THEN
					RAISE no_reg_documen;
				END IF;

				-- Bono Isapre que se pide Anular no registrado en auditoria
				IF  w_bonisa IS NULL OR w_bonisa = 0 THEN
					RAISE no_bono_isapre;
				END IF;

				IF  w_bonisa <> w9120_isanum THEN
					RAISE no_bono_distinto;
				END IF;
			END IF;


			/* Como se pide anular un bono (90920), se regraba Documento, sus Lineas y se
			crea un Estado.Esto con ANU si doc. emitido mismo dia,y con DEV si emision
			otro dia. Ademas se reversa el Bcc, si es que lo tuvo */

			IF  w_fecemi <> TO_CHAR(SYSDATE,'YYYYMMDD') THEN
				w_estado:= 'DEV';
			ELSE
				w_estado:= 'ANU';
			END IF;

			BEGIN
				--EACE 28-06-2005  GES
				DBMS_OUTPUT.PUT_LINE ( 'vn_MONTO_GES 1 = ' || vn_MONTO_GES );
				IF vn_MONTO_GES > 0 THEN

					DBMS_OUTPUT.PUT_LINE ( 'vn_MONTO_GES 2 = ' || vn_MONTO_GES );

					GESARA.PCK_GESARA_100_BONIFICACIONES.p_Graba_Devoluciones(w9120_isanum);

					DBMS_OUTPUT.PUT_LINE ( 'vn_MONTO_GES 3 = ' || vn_MONTO_GES );

					IF vv_ErrorCode IS NOT NULL THEN
					   RAISE no_anulacion_ges;
					END IF;

				END IF;

				--EACE 28-06-2005  GES

				IF vv_ANULA_CENTRAL = 'N' THEN
					UPDATE IMED_DOBE
					SET    ESTADO = w_estado,
						   AUDI_USUARIO_MODIFICACION = 'IMED: ANULACION',
						   AUDI_FECHA_MODIFICACION = SYSDATE
					WHERE  CORRELATIVO = w9120_isanum;

					dbms_output.put_line('ACTUALIZO DOCUMENTO');

					UPDATE IMED_LIBE
					SET    ESTADO = w_estado,
						   AUBO_USUA_USERNAME = 'IMED: ANULACION',
						   AUBO_FECHA = SYSDATE
					WHERE  DOBE_CORRELATIVO = w9120_isanum;

					dbms_output.put_line('ACTUALIZO LINEAS');

					SELECT IMED_ESDO_SEQ.NEXTVAL
					INTO   secuencia
					FROM   dual;

					Secuencia:= Secuencia + 9200000000000000;

					INSERT INTO IMED_ESDO  (CORRELATIVO,
											DOBE_CORRELATIVO,
											USUA_USERNAME,
											ESTADO,
											FECHA)
									VALUES (Secuencia,
											w9120_isanum,
											'IMED: ANULACION',
											w_estado,
											SYSDATE);
					dbms_output.put_line('INSERTO ESTADO ANU O DEV');
				ELSE
					NULL;

				END IF;

			EXCEPTION
				WHEN OTHERS THEN
					ROLLBACK;
					RAISE no_anular_bono;
			END;

			IF NVL(v_nSucVenta,0) != 0  THEN
				w_unor_correlativo_emitido := v_nSucVenta;
			ELSE
				w_unor_correlativo_emitido := 23;
			END IF;

			--- 06-09-2005 Patirico Alarcon
			IF w_estado = 'ANU' THEN
				IF Pck_Imed_Adm_Proc.F_IMED_BLOQUEA_SECCION('VERIFICA_DEUDA_COMPAG') = 'S' THEN
				  	IF 	(Pck_Imed_Externos.F_IMED_Posee_Deuda_ult_peri(v_nExtRutCotizante , 'N','N'))= 'S' THEN
						SELECT NVL(SUM(DECODE(BLOQUEADO,'S',2,1)),0) --COUNT(*)
						INTO   vn_EXISTE
						FROM   COMPAG_IMED
						WHERE  FOLIO_SUSCRIPCION = v_nFolio_Suscripcion
						--AND  BLOQUEADO = 'S'
						AND    ESTADO = 1 ;

						IF vn_EXISTE > 0 THEN
						   UPDATE COMPAG_IMED
						   SET	  ESTADO = 2
						   WHERE  FOLIO_SUSCRIPCION = v_nFolio_Suscripcion
						   AND	  ESTADO = 1 ;
						END IF;
					END IF;
				END IF;
			END IF;
			--- 06-09-2005 Patricio Alarcon

			/* Si no entro a valorizar */
			IF  w_mtobcc > 0 THEN
				--20030317 CAGF DEF. MBORBAR
				--		BLOQUE COMENTADO POR LOTUS DE K.GALARSE DEL 17/03/2003	MJBV
				-- 		/* 26/03/2002 SEGURO CIGNA CAMUFLADO A ATESA COMO BCC */
				-- 		IF  v_aseg_correlativo = 1 THEN
				--
				-- 			BEGIN
				-- 		 	  W_CON_CIG:='S';
				--
				--
				-- 			  DBMS_OUTPUT.PUT_LINE ( '*** LLAMARA A RUTINA ESCONDIDA ANULACION');
				-- 			  PCK_ST_BONIF_CIGNA_ESCONDIDA.P_ST_ANULA_DEVUELVE (w_bonisa,
				-- 									  			    		    w_estado,
				-- 																w_unor_correlativo_emitido,
				-- 																n_codigo_error,
				-- 																n_mensaje_error,
				-- 																n_grabo);
				--
				-- 		 	  DBMS_OUTPUT.PUT_LINE ( '*** LLAMO A RUTINA ESCONDIDA ANULACION');
				--
				-- 			EXCEPTION
				-- 				 WHEN OTHERS THEN
				-- 				 	  DBMS_OUTPUT.PUT_LINE ('FALLO ANULACION ESCONDIDA: '||SQLERRM);
				-- 					  RAISE no_anula_cigna;
				-- 			END;
				--
				--
				-- 		ELSE
				--		BLOQUE COMENTADO POR LOTUS DE K.GALARSE DEL 17/03/2003	MJBV
				--20030317 CAGF DEF. MBORBAR

				-- Reversa el Bcc que se habia grabado cuando se autorizo el Bono
				/* 26/03/2002 SEGURO CIGNA CAMUFLADO A ATESA COMO BCC */

				BEGIN
					W_CON_BCC:='S';
					RET_MONTO_BCC  (1,			    -- p_dobe_type IN NUMBER,
									w_bonisa,		   	    -- p_folio IN NUMBER bono,
									TO_CHAR(SYSDATE,'ddmmyyyy'),  -- p_fecha IN VARCHAR2,
									'A',			    -- p_tipo_atencion IN VARCHAR2, A,H,D
									w_folafi,			-- p_folio_suscripcion IN NUMBER,
									w_codcar,			    -- p_codigo_carga IN NUMBER,
									'O',			    -- p_tipo_emision IN VARCHAR2 O oam,reembolso
									2,			    -- p_centro_costo IN NUMBER ,2
									0,		   	  	    -- p_pres_rut IN NUMBER,
									0,				-- p_sucursal IN NUMBER,
									0,				-- p_oficina IN NUMBER,
									w9120_prtcor,		    -- p_numero_linea IN NUMBER,
									71,	   			    -- p_codigo_isapre IN NUMBER,
									1,		  		    -- p_numero_atenciones IN NUMBER,
									0,  	 			-- p_valor_prestacion IN NUMBER,
									0,					-- p_valor_bonificado_servicio IN NUMBER,
									0,			    -- p_valor_bonificado_isapre IN NUMBER,
									0,					-- p_flag IN NUMBER, 0 reversa, 1 consulta y graba
									w_mtobcc  		    -- p_monto_bcsc OUT NUMBER
									);
					dbms_output.put_line('REVERSO BCC CON MONTO: '||w_mtobcc);
				EXCEPTION
					WHEN OTHERS THEN
						ROLLBACK;
						RAISE no_reversa_bcc;
				END;

				--20030317 CAGF DEBIDO A QUE SE COMENTA BLOQUE ANTERIOR CIGNA
				--		END IF;
				--20030317 CAGF

			END IF;


			/*  reversa topes */
			W_CON_TOP:='S';

			/*TOPES 20030128 CAGF para pruebas locales*/
--			Pck_Cuentas_De_Topes.Reversa_Movimiento( w_bonisa		 -- P_Dobe_Correlativo IN NUMBER,
	    PCK_CUENTAS_DE_TOPES_ATESA.Reversa_Movimiento( w_bonisa		 -- P_Dobe_Correlativo IN NUMBER,
													, TO_CHAR(SYSDATE,'dd/mm/yyyy')		 -- P_Fecha IN VARCHAR2,
													, v_salida_tope 		 	 	 -- P_Salida OUT VARCHAR2,
													, v_mensaje_tope		 	 	 -- P_Mensaje OUT VARCHAR2
													);

			-- Reversa el monto de excedente si es que ocupo para copagar
		    DBMS_OUTPUT.PUT_LINE ( 'w_mtoexc = ' || w_mtoexc );

			IF  w_mtoexc > 0 THEN
				BEGIN
					W_CON_EXC:='S';
					Pr_Actualiza_Ctaind('DEVOLUCION',   -- p_operacion IN VARCHAR2,
										1,		-- p_dofi_codigo IN NUMBER,
										w_folafi,	-- p_folio IN NUMBER,
										71,		-- p_isapre IN NUMBER,
										w_bonisa,	-- p_bono IN NUMBER,
										TO_CHAR(SYSDATE,'dd/mm/yyyy'),	      -- p_fecha IN VARCHAR2,
										w_mtoexc,	-- p_monto IN NUMBER,
										n_numero,	-- p_numero OUT NUMBER,
										v_excedente	-- p_glosa OUT VARCHAR2
										);
				EXCEPTION
					WHEN OTHERS THEN
						ROLLBACK;
						RAISE no_reversa_excedente;
				END;
			END IF;

			-- Responde OK a la peticion 90920 de reversar el Bono Isapre que se genero
			dbms_output.put_line('familia: '||w_famter);
			dbms_output.put_line('terminal: '||w_codter);
			dbms_output.put_line('folio: '||w_folafi);
			dbms_output.put_line('carga: '||w_codcar);
			dbms_output.put_line('fecha: '||TO_CHAR(SYSDATE,'YYYY-MM-DD:HH24:MI:SS'));
			dbms_output.put_line('cod.tran: '||'IMED: ANULACION');
			--  dbms_output.put_line('bono atesa: '||w9120_prtnum);
			dbms_output.put_line('bono isapre: '||w_bonisa);
			dbms_output.put_line('autoriza: '||w_autisa);
			dbms_output.put_line('mto.total: '||w_montot);
			dbms_output.put_line('prest.tot: '||w_pretot);
			dbms_output.put_line('mto.isapre: '||w_monisa);
			dbms_output.put_line('mto.copago: '||w_moncop);
			dbms_output.put_line('observacion: '||NULL);


			IF     W_CON_BCC IS NULL AND W_CON_EXC IS NULL AND W_CON_TOP IS NULL AND W_CON_CIG IS NULL THEN
				   W_BCCEXCTOP:= '0';
			ELSIF  W_CON_BCC = 'S' AND W_CON_EXC IS NULL AND W_CON_TOP IS NULL AND W_CON_CIG IS NULL THEN
				   W_BCCEXCTOP:= '1';
			ELSIF  W_CON_BCC IS NULL AND W_CON_EXC = 'S' AND W_CON_TOP IS NULL AND W_CON_CIG IS NULL THEN
				   W_BCCEXCTOP:= '2';
			ELSIF  W_CON_BCC IS NULL AND W_CON_EXC IS NULL AND W_CON_TOP = 'S' AND W_CON_CIG IS NULL THEN
				   W_BCCEXCTOP:= '3';
			ELSIF  W_CON_BCC = 'S' AND W_CON_EXC = 'S' AND W_CON_TOP IS NULL AND W_CON_CIG IS NULL THEN
				   W_BCCEXCTOP:= '4';
			ELSIF  W_CON_BCC IS NULL AND W_CON_EXC = 'S' AND W_CON_TOP = 'S' AND W_CON_CIG IS NULL THEN
				   W_BCCEXCTOP:= '5';
			ELSIF  W_CON_BCC = 'S' AND W_CON_EXC IS NULL AND W_CON_TOP = 'S' AND W_CON_CIG IS NULL THEN
				   W_BCCEXCTOP:= '6';
			ELSIF  W_CON_BCC = 'S' AND W_CON_EXC = 'S' AND W_CON_TOP = 'S' AND W_CON_CIG IS NULL THEN
				   W_BCCEXCTOP:= '7';
			ELSIF  W_CON_BCC IS NULL AND W_CON_EXC IS NULL AND W_CON_TOP IS NULL AND W_CON_CIG = 'S' THEN
				   W_BCCEXCTOP:= '8';
			ELSIF  W_CON_BCC IS NULL AND W_CON_EXC = 'S' AND W_CON_TOP IS NULL AND W_CON_CIG = 'S' THEN
				   W_BCCEXCTOP:= '9';
			ELSIF  W_CON_BCC IS NULL AND W_CON_EXC = 'S' AND W_CON_TOP = 'S' AND W_CON_CIG = 'S' THEN
				   W_BCCEXCTOP:= 'A';
			ELSIF  W_CON_BCC IS NULL AND W_CON_EXC IS NULL AND W_CON_TOP = 'S' AND W_CON_CIG = 'S' THEN
				   W_BCCEXCTOP:= 'B';
			ELSIF  W_CON_BCC = 'S' AND W_CON_EXC IS NULL AND W_CON_TOP IS NULL AND W_CON_CIG = 'S' THEN
				   W_BCCEXCTOP:= 'C';
			ELSIF  W_CON_BCC = 'S' AND W_CON_EXC = 'S' AND W_CON_TOP = 'S' AND W_CON_CIG = 'S' THEN
				   W_BCCEXCTOP:= 'D';
			ELSIF  W_CON_BCC = 'S' AND W_CON_EXC IS NULL AND W_CON_TOP = 'S' AND W_CON_CIG = 'S' THEN
				   W_BCCEXCTOP:= 'F';
			ELSIF  W_CON_BCC = 'S' AND W_CON_EXC = 'S' AND W_CON_TOP IS NULL AND W_CON_CIG = 'S' THEN
				   W_BCCEXCTOP:= 'G';
			ELSE   W_BCCEXCTOP:= 'E';
			END IF;

	END IF; -- IF QUE VALIDA SI UTILIZAMOS NUEVO ANULADOR O ANTIGUO

	sal:=0;
	Out_vExtCodError     := 'S';
	Out_vExtMensajeError := RPAD('Anulacion Bono OK: '||w9120_isanum,30);
	Out_vReturnStatus	   := '1';
	Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
	Out_vMessageCode 	   := '00000';
	SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;

	v_vSalida_Format     := SETEA_SALIDA;
	W_FECHOR_SALIDA:=SYSDATE;
	dbms_output.put_line('Antes Auditoria: '||w_res);
	w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,W_FECHOR_salida,  (W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
	dbms_output.put_line('Despues Auditoria'||w_res);
	IF  w_res = 0 THEN
		sal:=0;
		COMMIT;
		dbms_output.put_line('termino ok');
	ELSE
		dbms_output.put_line('Auditoria retorno Error: '||w_res);
		ROLLBACK;
	END IF;

	RETURN;

EXCEPTION
	WHEN e_error_anulacion_nuevo THEN
		Out_vExtCodError     := 'N';
		Out_vExtMensajeError := RPAD('Error en Proc. de Anulacion',30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		Out_vMessageCode 	   := '00000';
		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		v_vSalida_Format     := SETEA_SALIDA;
		W_FECHOR_salida:=SYSDATE;
		w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
		RETURN;
	WHEN isapre_no_corresponde THEN
		Out_vExtCodError     := 'N';
		Out_vExtMensajeError := RPAD('Codigo isapre no corresponde',30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		Out_vMessageCode 	   := '00000';
		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		v_vSalida_Format     := SETEA_SALIDA;
		W_FECHOR_salida:=SYSDATE;
		w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
		RETURN;

	WHEN no_auditoria THEN
		Out_vExtCodError     := 'N';
		Out_vExtMensajeError := RPAD('No existe Bono Imed en Auditoria',30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		Out_vMessageCode 	   := '00000';
		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		v_vSalida_Format     := SETEA_SALIDA;
		W_FECHOR_salida:=SYSDATE;
		w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
		RETURN;
	WHEN no_reg_documen THEN
		Out_vExtCodError     := 'N';
		Out_vExtMensajeError := RPAD('Error de Registro del Documento',30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		Out_vMessageCode 	   := '00000';
		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		v_vSalida_Format     := SETEA_SALIDA;
		W_FECHOR_salida:=SYSDATE;
		w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
		RETURN;
	WHEN no_bono_isapre THEN
		Out_vExtCodError     := 'N';
		Out_vExtMensajeError := RPAD('Auditoria SIN Bono Isapre',30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		Out_vMessageCode 	   := '00000';
		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		v_vSalida_Format     := SETEA_SALIDA;
		W_FECHOR_salida:=SYSDATE;
		w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
		RETURN;
	WHEN no_bono_distinto THEN
		Out_vExtCodError     := 'N';
		Out_vExtMensajeError := RPAD('Bono Isapre que Anula <> en Auditoria',30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		Out_vMessageCode 	   := '00000';
		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		v_vSalida_Format     := SETEA_SALIDA;
		W_FECHOR_salida:=SYSDATE;
		w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
		RETURN;
	WHEN no_anular_bono THEN
		Out_vExtCodError     := 'N';
		Out_vExtMensajeError := RPAD('Problemas al Anular... Reintente',30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		Out_vMessageCode 	   := '00000';
		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		v_vSalida_Format     := SETEA_SALIDA;
		W_FECHOR_salida:=SYSDATE;
		w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
		RETURN;
	WHEN no_reversa_bcc THEN
		Out_vExtCodError     := 'N';
		Out_vExtMensajeError := RPAD('No reverso Bcc (90920)',30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		Out_vMessageCode 	   := '00000';
		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		v_vSalida_Format     := SETEA_SALIDA;
		W_FECHOR_salida:=SYSDATE;
		w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
		RETURN;
	WHEN no_anula_cigna THEN
		Out_vExtCodError     := 'N';
		Out_vExtMensajeError := RPAD('No Anulo seguro Cigna (90920)',30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		Out_vMessageCode 	   := '00000';
		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		v_vSalida_Format     := SETEA_SALIDA;

TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		W_FECHOR_salida:=SYSDATE;
		w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
		RETURN;
	WHEN no_reversa_excedente THEN
		Out_vExtCodError     := 'N';
		Out_vExtMensajeError := RPAD('Error: No Reverso Excedente',30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		Out_vMessageCode 	   := '00000';
		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		v_vSalida_Format     := SETEA_SALIDA;
		W_FECHOR_salida:=SYSDATE;
		w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
		RETURN;
	WHEN no_beneficiario THEN
		Out_vExtCodError     := 'N';
		Out_vExtMensajeError := RPAD('Error: No Acceso Beneficiario',30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		Out_vMessageCode 	   := '00000';
		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		v_vSalida_Format     := SETEA_SALIDA;
		W_FECHOR_salida:=SYSDATE;
		w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
		RETURN;
	WHEN no_familia_homologada THEN
		Out_vExtCodError     := 'N';
		Out_vExtMensajeError := RPAD('Error: Sucursal no Homologada',30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		Out_vMessageCode 	   := '00000';
		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		v_vSalida_Format     := SETEA_SALIDA;
		W_FECHOR_salida:=SYSDATE;
		w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
		RETURN;
	-- ACS 2006/06/05 raise de salida en caso de existir bono en tabla migracion
   WHEN si_existe_migracion THEN
		Out_vExtCodError     := 'N';
		Out_vExtMensajeError := RPAD('COMUNICARSE CON ISAPRE - BONO MIGRACION'||TO_CHAR(w_bandera),30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		Out_vMessageCode 	   := '00000';
		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		v_vSalida_Format     := SETEA_SALIDA;
		W_FECHOR_salida:=SYSDATE;
		w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
		RETURN;
	WHEN OTHERS THEN
		Out_vExtCodError     := 'N';
		Out_vExtMensajeError := RPAD('ERROR PROC.:'||TO_CHAR(w_bandera),30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeError;
		Out_vMessageCode 	   := '00000';
		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		v_vSalida_Format     := SETEA_SALIDA;
		W_FECHOR_salida:=SYSDATE;
		w_res:=Imed_Graba_Auditoria(v_vNomTrans,W_FECHOR_LLEGADA,NULL,NULL,NULL,NULL,NULL,v_nExtRutCotizante,v_nFolio_Suscripcion,v_vCodigoCarga,v_nExtFolioBono,w_montot,NULL,w_monisa,w_moncop,v_vEntrada_Format,v_vSalida_Format,W_FECHOR_LLEGADA,
		W_FECHOR_salida,(W_FECHOR_salida-W_FECHOR_LLEGADA)*86400,VALOR(W_CON_BCC),w_mtobcc,VALOR(W_CON_EXC),w_mtoexc,VALOR(W_CON_TOP),VALOR(W_CON_CIG),NULL);
		RETURN;


END Conanulabonou;

END Conanulabonou_Pkg;

1066 rows selected.

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
