
SQL*Plus: Release 11.2.0.3.0 Production on Wed Mar 5 18:59:59 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONBENCERTIF
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_NEXTRUTBENEFICIARIO 	VARCHAR2		IN
 IN_VEXTFECHAACTUAL		VARCHAR2		IN
 OUT_VEXTAPELLIDOPAT		VARCHAR2		OUT
 OUT_VEXTAPELLIDOMAT		VARCHAR2		OUT
 OUT_VEXTNOMBRES		VARCHAR2		OUT
 OUT_VEXTSEXO			VARCHAR2		OUT
 OUT_DEXTFECHANACIMI		VARCHAR2		OUT
 OUT_VEXTCODESTBEN		VARCHAR2		OUT
 OUT_VEXTDESCESTADO		VARCHAR2		OUT
 OUT_VEXTRUTCOTIZANTE		VARCHAR2		OUT
 OUT_VEXTNOMCOTIZANTE		VARCHAR2		OUT
 OUT_VEXTDIRPACIENTE		VARCHAR2		OUT
 OUT_VEXTGLOSACOMUNA		VARCHAR2		OUT
 OUT_VEXTGLOSACIUDAD		VARCHAR2		OUT
 OUT_VEXTPREVISION		VARCHAR2		OUT
 OUT_VEXTGLOSA			VARCHAR2		OUT
 OUT_VEXTPLAN			VARCHAR2		OUT
 OUT_VEXTDESCUENTOXPLANILLA	VARCHAR2		OUT
 OUT_NEXTMONTOEXCEDENTE 	NUMBER			OUT
 COL_VEXTRUTACOMPANANTE 	TABLE OF VARCHAR2(12)	OUT
 COL_VEXTNOMBREACOMPANANTE	TABLE OF VARCHAR2(40)	OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Conbencertif_Pkg
AS
  TYPE CurvExtRutAcompanante_arr IS TABLE OF VARCHAR2(12)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtNombreAcompanante_arr IS TABLE OF VARCHAR2(40)
    INDEX BY BINARY_INTEGER;

    TYPE cCURSOR  IS REF CURSOR;

   PROCEDURE Conbencertif
     (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nextCodFinanciador	 	IN 	   NUMBER
		   , In_nextRutBeneficiario	 	IN 	   VARCHAR2
   		   , In_vextFechaActual 	 	IN 	   VARCHAR2
   		   , Out_vextApellidoPat	  	OUT	   VARCHAR2
   		   , Out_vextApellidoMat	  	OUT    VARCHAR2
   		   , Out_vextNombres		  	OUT    VARCHAR2
   		   , Out_vextSexo		  	OUT	   VARCHAR2
   		   , Out_dextFechaNacimi	  	OUT	   VARCHAR2
		   , Out_vextCodEstBen		  	OUT	   VARCHAR2
	   , Out_vextDescEstado 	  	OUT	   VARCHAR2
	   , Out_vextRutCotizante	  	OUT    VARCHAR2
	   , Out_vextNomCotizante	   	OUT    VARCHAR2
	   , Out_vextDirPaciente	    OUT    VARCHAR2
	   , Out_vextGlosaComuna	    OUT    VARCHAR2
	   , Out_vextGlosaCiudad	    OUT    VARCHAR2
	   , Out_vextPrevision		  	OUT    VARCHAR2
	   , Out_vextGlosa		  	OUT    VARCHAR2
	   , Out_vextPlan		  	OUT    VARCHAR2
	   , Out_vextDescuentoxPlanilla   	OUT    VARCHAR2
	   , Out_nextMontoExcedente	  	OUT    NUMBER
	   , Col_vExtRutAcompanante	  	OUT    CurvExtRutAcompanante_arr
	   , Col_vExtNombreAcompanante	  	OUT    CurvExtNombreAcompanante_arr
   );

END Conbencertif_Pkg;

38 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     Conbencertif_Pkg
AS
   PROCEDURE Conbencertif
   (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nextCodFinanciador	 	IN 	   NUMBER
		   , In_nextRutBeneficiario	 	IN 	   VARCHAR2
   		   , In_vextFechaActual 	 	IN 	   VARCHAR2
   		   , Out_vextApellidoPat	  	OUT	   VARCHAR2
   		   , Out_vextApellidoMat	  	OUT    VARCHAR2
   		   , Out_vextNombres		  	OUT    VARCHAR2
   		   , Out_vextSexo		  	OUT	   VARCHAR2
   		   , Out_dextFechaNacimi	  	OUT	   VARCHAR2
		   , Out_vextCodEstBen		  	OUT	   VARCHAR2
	   , Out_vextDescEstado 	  	OUT	   VARCHAR2
	   , Out_vextRutCotizante	  	OUT    VARCHAR2
	   , Out_vextNomCotizante	   	OUT    VARCHAR2
	   , Out_vextDirPaciente	    OUT    VARCHAR2
	   , Out_vextGlosaComuna	    OUT    VARCHAR2
	   , Out_vextGlosaCiudad	    OUT    VARCHAR2
	   , Out_vextPrevision		  	OUT    VARCHAR2
	   , Out_vextGlosa		  	OUT    VARCHAR2
	   , Out_vextPlan		  	OUT    VARCHAR2
	   , Out_vextDescuentoxPlanilla   	OUT    VARCHAR2
	   , Out_nextMontoExcedente	  	OUT    NUMBER
	   , Col_vExtRutAcompanante	  	OUT    CurvExtRutAcompanante_arr
	   , Col_vExtNombreAcompanante	  	OUT    CurvExtNombreAcompanante_arr
    )
IS
v_vnomtrans		   					VARCHAR2 ( 50 )   := UPPER('Conbencertif_Pkg');
v_vEntrada_Format							VARCHAR2(2000);
v_vSalida_Format							VARCHAR2(2000);
v_sep_ES	   								VARCHAR2(1):=';';
Out_vReturnStatus							VARCHAR2(1);
Out_vMessageCode 						  	VARCHAR2(5);
Out_vMessageText							VARCHAR2(243);
SRV_FetchStatus								NUMBER(1);
SRV_Total_Rows								NUMBER(8);
SRV_Row_Count								NUMBER(8);
v_nEdad							   			NUMBER;
v_vCarIniMessageText						VARCHAR2(1):='X'; -- Para diferenciar Out_vMessageText
v_vResp 				    NUMBER(1);--CTC Respuesta funcion Imed_Beneficiario_Cotizante 0=OK/1=Error
														  	  -- de Out_vExtMensajeError
--Cursor para consultar Acompanantes Validos de un Beneficiario
--Jorge Mu?oz 24/04/2003 se cambia por grupo familiar
--    CURSOR c_acompanantes_validos (
--	 p_nfolio_suscripcion	IN   NUMBER
--     , p_ncodigo_isapre	IN   NUMBER
--     , p_ncodigo_carga	IN   NUMBER
--    )
--    IS
--	 SELECT acva.rut || '-' || acva.digrut
--	      , acva.nombres|| ' '|| acva.apellido_paterno|| ' '|| acva.apellido_materno
--	   FROM imed_acompanantes_validos acva
--	  WHERE acva.benc_coaf_folio_suscripcion   = p_nfolio_suscripcion
--	    AND acva.benc_coaf_orga_codigo_isapre  = p_ncodigo_isapre
--	    AND acva.benc_codigo_carga 			= p_ncodigo_carga;
   CURSOR c_grupo_familiar (
      p_nfolio_suscripcion   IN   NUMBER
    , p_ncodigo_isapre	     IN   NUMBER
    , p_ncodigo_carga	     IN   NUMBER
   )
   IS
      SELECT --DECODE(pers.rut || '-' || pers.digrut,'-',F_Retorna_Hom_Benef(benc.coaf_folio_suscripcion,benc.coaf_orga_codigo_isapre,benc.codigo_carga),pers.rut || '-' || pers.digrut)
	  		 DECODE(F_Retorna_Rut(pers.correlativo),'0000000000-0',F_Retorna_Rut_Hom_Benef(benc.coaf_folio_suscripcion,benc.coaf_orga_codigo_isapre,benc.codigo_carga),F_Retorna_Rut(pers.correlativo))
	   , SUBSTR(pers.nombre|| ' '|| pers.apellido_paterno|| ' '|| pers.apellido_materno,1,40)
	FROM afi_contratos_afiliados coaf,
	 	 afi_beneficiarios_contrato benc,
			 afi_personas pers
       WHERE benc.coaf_folio_suscripcion   = coaf.folio_suscripcion
	 AND benc.coaf_orga_codigo_isapre  = coaf.orga_codigo_isapre
		 --AND coaf.fecha_desahucio IS NULL
	 AND	NVL(coaf.fecha_desahucio,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
       	 AND benc.coaf_folio_suscripcion   = p_nfolio_suscripcion
	 AND benc.coaf_orga_codigo_isapre  = p_ncodigo_isapre
	 AND benc.codigo_carga 			   <> p_ncodigo_carga
		 --AND benc.fecha_termino_beneficio IS NULL
		  AND benc.FECHA_INICIO_BENEFICIOS <= TRUNC(SYSDATE)
	 AND	NVL(BENC.FECHA_TERMINO_BENEFICIO,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
		 AND benc.PERS_CORRELATIVO = pers.correlativo
		 AND F_Imed_Calcula_Edad(pers.FECHA_NACIMIENTO) >= 18
		 ;
   CURSOR c_grupo_familiar_conyuge (
      p_nfolio_suscripcion   IN   NUMBER
    , p_ncodigo_isapre	     IN   NUMBER
    , p_ncodigo_carga	     IN   NUMBER
   )
   IS
      SELECT --DECODE(pers.rut || '-' || pers.digrut,'-',F_Retorna_Hom_Benef(benc.coaf_folio_suscripcion,benc.coaf_orga_codigo_isapre,benc.codigo_carga),pers.rut || '-' || pers.digrut)
	  		 DECODE(F_Retorna_Rut(pers.correlativo),'0000000000-0',F_Retorna_Rut_Hom_Benef(benc.coaf_folio_suscripcion,benc.coaf_orga_codigo_isapre,benc.codigo_carga),F_Retorna_Rut(pers.correlativo))
	   , SUBSTR(pers.nombre|| ' '|| pers.apellido_paterno|| ' '|| pers.apellido_materno,1,40)
	FROM afi_contratos_afiliados coaf,
	 	 afi_beneficiarios_contrato benc,
			 afi_personas pers
       WHERE benc.coaf_folio_suscripcion   = coaf.folio_suscripcion
	 AND benc.coaf_orga_codigo_isapre  = coaf.orga_codigo_isapre
		 --AND coaf.fecha_desahucio IS NULL
	 AND	NVL(coaf.fecha_desahucio,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
       	 AND benc.coaf_folio_suscripcion   = p_nfolio_suscripcion
	 AND benc.coaf_orga_codigo_isapre  = p_ncodigo_isapre
--	 AND benc.codigo_carga 			   <> p_ncodigo_carga
		 --AND benc.fecha_termino_beneficio IS NULL
	 AND benc.FECHA_INICIO_BENEFICIOS <= TRUNC(SYSDATE)
	 AND	NVL(BENC.FECHA_TERMINO_BENEFICIO,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
		 AND benc.PERS_CORRELATIVO = pers.correlativo
		 AND F_Imed_Calcula_Edad(pers.FECHA_NACIMIENTO) >= 18
		 ;
v_nIndAcva				   NUMBER;
w_fechor_llegada	   DATE;
w_fechor_salida 	   DATE;
-- Codigo de la Isapre para validar contra entrada
v_ncod_isa_cons 	   NUMBER	     := 71;
w_res			   NUMBER ( 1 )      := 0;
w_con_bcc		   NUMBER ( 1 )      := 0;
w_con_exc		   NUMBER ( 1 )      := 0;
w_con_top		   NUMBER ( 1 )      := 0;
w_con_cig		   NUMBER ( 1 )      := 0;
---- Para recibir Variables entrada
v_nextcodfinanciador	   NUMBER ( 3 );
v_nextrutbeneficiario	   NUMBER ( 10 );
v_dextfechaactual	   DATE;
v_nfolio_suscripcion	   NUMBER;
v_nrut_cotizante		   NUMBER(10);	--ctc
v_ncodigo_isapre	   NUMBER ( 3 );
v_ncodigo_carga 	   NUMBER;
v_ncoderror				   NUMBER(06);
v_vgloerror				   VARCHAR2(100);--ctc
-- Variables de Paso
Aux_CurvExtRutAcompanante  VARCHAR2(12);
Aux_CurvExtNombreAcompanante VARCHAR2(40);
E_FIN			   EXCEPTION;
E_MAX_ACOM_VALIDOS		   EXCEPTION;
-- Para consultar renucia excedentes
v_vrenuncia_excedente	   VARCHAR2 ( 1 );
v_nnumero		   NUMBER ( 10 );
-- Variable de Salida de Monto excedente
v_nexcedente		   NUMBER ( 10 ) := 0;
-- Para consultar codigo isapre
v_nposee_exc		   NUMBER:= 0;
v_bEstaEnRango			   BOOLEAN;
v_vAUX					   VARCHAR2(1);
v_bMatrimonial			   BOOLEAN;
v_nfolio_suscripcion_conyuge	   NUMBER;
W_FECDESAHU						   DATE;
no_vigente						   EXCEPTION;
-- Variables para obtencion de Bloqueo por Deudas de Incumplimiento En Compag Oper
-- Creado el 06-02-2004 por Jorge Mu?oz
-- Verifica Deuda de ultimo mes (COMPAG)
v_DEUDA	  					VARCHAR(1);
v_nRut						NUMBER;
-- Fin Verifica Deuda de ultimo mes (COMPAG)
vn_ISAP_CODIGO		  	    NUMBER:=71;
vn_PLAN_CORRELATIVO	    NUMBER:=0;
vn_PLAN_CORRELATIVO_SIETE   NUMBER:=0;
vn_PORCENTAJE_BONIF_HOSP    NUMBER:=0;
vn_PORCENTAJE_BONIF_AMBU    NUMBER:=0;
vn_PORCENTAJE_BONIF_DENT    NUMBER:=0;
vn_PORCENTAJE_BONIF_MED     NUMBER:=0;
po_cPlan		    cCURSOR;
v_vPOSEE_VIGENTE_BC_72	    VARCHAR2(1);

FUNCTION SETEA_ENTRADA
RETURN VARCHAR2
IS
v_vEntrada			   VARCHAR2(2000);
BEGIN
v_vEntrada	:=  SUBSTR(RTRIM(SUBSTR(RTRIM(SRV_Message),1,256)||v_sep_ES||
				TO_CHAR(In_nextCodFinanciador)||v_sep_ES||
				In_nextRutBeneficiario||v_sep_ES||
				In_vextFechaActual||v_sep_ES),1,2000);
RETURN v_vEntrada;
END;
FUNCTION SETEA_SALIDA
RETURN VARCHAR2
IS
v_vSalida	   VARCHAR2(2000);
BEGIN
v_vSalida:= SUBSTR(SRV_Message||v_sep_ES||
			Out_vextApellidoPat||v_sep_ES||
			Out_vextApellidoMat||v_sep_ES||
			Out_vextNombres||v_sep_ES||
			Out_vextSexo||v_sep_ES||
			Out_dextFechaNacimi||v_sep_ES||
			Out_vextCodEstBen||v_sep_ES||
			Out_vextDescEstado||v_sep_ES||
			Out_vextRutCotizante||v_sep_ES||
			Out_vextNomCotizante||v_sep_ES||
			Out_vextDirPaciente||v_sep_ES||
			Out_vextGlosaComuna||v_sep_ES||
			Out_vextGlosaCiudad||v_sep_ES||
			Out_vextPrevision||v_sep_ES||
			Out_vextGlosa||v_sep_ES||
			Out_vextPlan||v_sep_ES||
			Out_vextDescuentoxPlanilla||v_sep_ES||
			Out_nextMontoExcedente||v_sep_ES,1,2000);
FOR i IN 1 ..Col_vExtRutAcompanante.COUNT LOOP
v_vSalida := v_vSalida ||Col_vExtRutAcompanante(i)||v_sep_ES;
END LOOP;
FOR i IN 1 ..Col_vExtNombreAcompanante.COUNT LOOP
v_vSalida := v_vSalida || Col_vExtNombreAcompanante(i)||v_sep_ES;
END LOOP;
RETURN v_vSalida;
END;
PROCEDURE LIMPIA
AS
BEGIN
  SRV_FetchStatus	   	  			  := '0';
  OUT_VEXTAPELLIDOPAT		      := ' ';
  OUT_VEXTAPELLIDOMAT		      := ' ';
  OUT_VEXTNOMBRES		      := ' ';
  OUT_VEXTSEXO			      := ' ';
  OUT_DEXTFECHANACIMI		      := ' ';
  OUT_VEXTCODESTBEN		      := 'X';
  OUT_VEXTDESCESTADO		      := 'NO CERTIFICADO';
  OUT_VEXTRUTCOTIZANTE		      := '0000000000-0';
  OUT_VEXTNOMCOTIZANTE		      := ' ';
  OUT_VEXTDIRPACIENTE		      := ' ';
  OUT_VEXTGLOSACOMUNA		      := ' ';
  OUT_VEXTGLOSACIUDAD		      := ' ';
  OUT_VEXTPREVISION		      := ' ';
  OUT_VEXTPLAN			      := ' ';
  OUT_VEXTDESCUENTOXPLANILLA	      := ' ';
  OUT_NEXTMONTOEXCEDENTE	      := 0;
  COL_VEXTRUTACOMPANANTE.DELETE;
  COL_VEXTNOMBREACOMPANANTE.DELETE;
  COL_VEXTRUTACOMPANANTE(1)   	   	  := '0000000000-0';
  COL_VEXTNOMBREACOMPANANTE(1)		  := ' ';
END;
BEGIN
DBMS_OUTPUT.PUT_LINE ( 'INICIO' );
   w_fechor_llegada :=TO_DATE ( TO_CHAR ( SYSDATE, 'RRRR/MM/DD HH24:MI:SS' ), 'RRRR/MM/DD HH24:MI:SS');
   v_vEntrada_Format := SETEA_ENTRADA;
   v_nextcodfinanciador := In_nextcodfinanciador;
-- Si el codigo no corresponde a Consalud
   IF ( v_nextcodfinanciador != v_ncod_isa_cons )
   THEN
--jm  Out_vReturnStatus		 := '0';
   	  Out_vReturnStatus		 := '1';
      Out_vextglosa 		 := 'CODIGO ISAPRE NO CORRESPONDE';
      Out_vextcodestben 	 := 'X';
      Out_vextdescestado 	 := 'NO CERTIFICADO';
   	  Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextglosa;
--jm  Out_vMessageCode	 	 := '78001';
	  Out_vMessageCode   	 := '00000';
      RAISE e_fin;
   END IF;
DBMS_OUTPUT.PUT_LINE ( '02' );
   v_nextrutbeneficiario:= TO_NUMBER ( SUBSTR ( In_nextrutbeneficiario, 1, 10 ));
-- MJBV  19-05-2003    v_dextfechaactual	:= TO_DATE ( SUBSTR(In_vextFechaActual,1,14), 'RRRRMMDDHH24MISS' );
   v_dextfechaactual	:= SYSDATE;
   Out_vReturnStatus  := '1';
   SRV_Total_Rows	  := TO_NUMBER(RTRIM(SRV_Message));
   SRV_Row_Count	  := 0;
   SRV_FetchStatus	  := 0;
   Out_vextDescuentoxPlanilla := 'N'; --20030121 Def. Mborbar
DBMS_OUTPUT.PUT_LINE ( '03' );
-- --@ MJBV
--     IF  v_nextrutbeneficiario = 10437637 THEN
--  	   Out_vReturnStatus  := '1';
--  	   Out_vextcodestben  := 'X';
--  	   Out_vextdescestado := 'NO CERTIFICADO'; -- estado por definir no existe BENEFICIARIO
--  	   Out_vextglosa 	  := 'NO USE RUT EN PRUEBAS';
--  	   Out_vMessageText	  := v_vCarIniMessageText||Out_vextglosa;
--  	   Out_vMessageCode   := '00000';
--  	   RAISE e_fin;
--     END IF;
-- --@ MJBV
   -- New Beneficiario_Cotizante CTC'
   BEGIN
   	 DBMS_OUTPUT.PUT_LINE ( 'v_nextrutbeneficiario= ' || v_nextrutbeneficiario );
     v_vResp := Imed_Beneficiario_Cotizante(v_nextrutbeneficiario,
											v_nfolio_suscripcion,
											v_nrut_cotizante,
											v_ncodigo_isapre,
											v_ncodigo_carga,
											v_ncoderror,
											v_vgloerror);
	DBMS_OUTPUT.PUT_LINE ( 'v_ncoderror= ' || v_ncoderror );
	DBMS_OUTPUT.PUT_LINE ( 'v_vgloerror= ' || v_vgloerror );
   EXCEPTION
	WHEN OTHERS THEN
		     Out_vReturnStatus := '1';
       	 	 Out_vextglosa 	   := 'VERIFICACION BENEFICIARIO';
		 	 Out_vextcodestben := 'X';
       	 	 Out_vextdescestado:= 'NO CERTIFICADO';
   	   	 	 Out_vMessageText  := v_vCarIniMessageText||Out_vextglosa;
		 	 Out_vMessageCode  := '00000';
			 DBMS_OUTPUT.PUT_LINE ( 'Out_vextdescestado= ' || Out_vextdescestado );
     	 	 RAISE e_fin;
   END;
DBMS_OUTPUT.PUT_LINE ( 'v_vResp= ' || v_vResp );
   IF  v_vResp = 1 THEN
	   Out_vReturnStatus := '1';
       Out_vextglosa 	   := v_vgloerror;
	   Out_vextcodestben := 'X';
       Out_vextdescestado:= 'NO CERTIFICADO';
   	   Out_vMessageText  := v_vCarIniMessageText||Out_vextglosa;
	   Out_vMessageCode  := '00000';
       RAISE e_fin;
   END IF;
   --EACE 01/07/2005  DESCUENTO POR PLANILLAS
   BEGIN
		SELECT ISAP_CODIGO
		INTO   vn_ISAP_CODIGO
		FROM   AFI_CONTRATOS_AFILIADOS
		WHERE  FOLIO_SUSCRIPCION = v_nfolio_suscripcion
		AND    ORGA_CODIGO_ISAPRE = v_ncodigo_carga;
   EXCEPTION
   WHEN OTHERS THEN
   		vn_ISAP_CODIGO:=71;
   END;
   IF vn_ISAP_CODIGO IN (85,96) THEN
	   Out_vextDescuentoxPlanilla:= Imed_Tiene_Dscto_Planilla(v_nfolio_suscripcion,v_ncodigo_carga);
   END IF;
   --EACE 01/07/2005  DESCUENTO POR PLANILLAS
   -- busca datos 1 del beneficiario
   BEGIN
      SELECT pers.apellido_paterno,
 			 pers.apellido_materno,
			 pers.nombre,
			 pers.sexo,
			 RPAD(TO_CHAR(pers.fecha_nacimiento,'YYYYMMDDHH24MISS'),21,'0')
	INTO Out_vextApellidoPat,
			 Out_vextApellidoMat,
			 Out_vextNombres,
			 Out_vextSexo,
			 Out_dextFechaNacimi
	FROM afi_beneficiarios_contrato benc,
			 afi_personas pers
       WHERE benc.coaf_folio_suscripcion = v_nfolio_suscripcion
	     AND benc.coaf_orga_codigo_isapre = v_ncodigo_isapre
		 AND benc.codigo_carga = v_ncodigo_carga
		 AND pers.correlativo = benc.pers_correlativo;
		 DBMS_OUTPUT.PUT_LINE ( 'Out_vextApellidoPat= ' || Out_vextApellidoPat );
   EXCEPTION
	WHEN OTHERS THEN
		     Out_vReturnStatus := '1';
       	 	 Out_vextglosa 	   := 'ERROR: NOMBRE BENEFICIARIO';
		 	 Out_vextcodestben := 'X';
       	 	 Out_vextdescestado:= 'NO CERTIFICADO';
   	   	 	 Out_vMessageText  := v_vCarIniMessageText||Out_vextglosa;
		 	 Out_vMessageCode  := '00000';
			 DBMS_OUTPUT.PUT_LINE ( 'error Out_vextApellidoPat= ' || Out_vextApellidoPat );
     	 	 RAISE e_fin;
   END;
   DBMS_OUTPUT.PUT_LINE ( 'CTC' );
   -- CTC
--  mjbv 11/7/2003 se agrega validacion por unificacion de mensajeria A.Montero
	BEGIN
	  SELECT FECHA_DESAHUCIO
	INTO W_FECDESAHU
	FROM AFI_CONTRATOS_AFILIADOS	CON,
	     afi_beneficiarios_contrato ben,
	     afi_personas		per
       WHERE con.folio_suscripcion = v_nfolio_suscripcion
	 AND con.orga_codigo_isapre = v_ncodigo_isapre
	 AND con.folio_suscripcion = ben.coaf_folio_suscripcion
	 AND con.orga_codigo_isapre = ben.coaf_orga_codigo_isapre
	 AND ben.codigo_carga = v_ncodigo_carga
	 AND ben.fecha_inicio_beneficios <= TRUNC(SYSDATE) AND (ben.fecha_termino_beneficio >= TRUNC(SYSDATE) OR ben.fecha_termino_beneficio IS NULL)
	 AND ben.pers_correlativo = per.correlativo;
		 DBMS_OUTPUT.PUT_LINE ( 'W_FECDESAHU= ' || W_FECDESAHU );
	EXCEPTION
	 WHEN OTHERS THEN
			  Out_vReturnStatus  := '1';
	      Out_vextcodestben  := 'X';
	      Out_vextdescestado := 'NO CERTIFICADO'; -- estado por definir no existe BENEFICIARIO
   		  Out_vextglosa 	  := 'BENEFICIARIO NO VIGENTE';
   			  Out_vMessageText	  := v_vCarIniMessageText||Out_vextglosa;
			  Out_vMessageCode   := '00000';
			  DBMS_OUTPUT.PUT_LINE ( 'BENEFICIARIO NO VIGENTE'|| 'BENEFICIARIO NO VIGENTE' );
	      RAISE e_fin;
	END;
--  mjbv 11/7/2003
DBMS_OUTPUT.PUT_LINE ( '05.1' );
   BEGIN
   	  -- Datos del Cotizante e ubicacion de beneficiario
	  DBMS_OUTPUT.PUT_LINE ( '**1** '||v_nfolio_suscripcion||' '||v_ncodigo_isapre);
      SELECT Llena_Espacios(pers.rut_real,10)||'-'||pers.digrut	rut_cot,
	  		 SUBSTR(pers.apellido_paterno||' '||pers.apellido_materno||' '||pers.nombre,1,40) nombre,
			 RPAD(ubic.calle||' '||ubic.numero||DECODE(ubic.bloque,NULL,'',' BLOCK '||ubic.bloque)||DECODE(ubic.depto,NULL,'',' DEPTO. '||ubic.depto),40) direccion,
			 comu.descripcion	comuna,
			 ciud.descripcion	ciudad,
			 coaf.renuncia_excedente,
			 PLAN.codigo_comercial
	INTO Out_vextrutcotizante,
			 Out_vextnomcotizante,
			 Out_vextdirpaciente,
			 Out_vextglosacomuna,
			 Out_vextglosaciudad,
			 v_vrenuncia_excedente,
			 Out_vextplan
	FROM afi_beneficiarios_contrato benc,
			 afi_contratos_afiliados coaf,
			 afi_personas pers,
			 pln_planes PLAN,
			 glo_ubicaciones ubic,
			 glo_zonas comu,
			 glo_zonas ciud
       WHERE benc.coaf_folio_suscripcion = v_nfolio_suscripcion --7192530
	 AND benc.coaf_orga_codigo_isapre = v_ncodigo_isapre --71
	 AND benc.codigo_carga = 0
		 --AND benc.fecha_termino_beneficio IS NULL
	 AND benc.FECHA_INICIO_BENEFICIOS <= TRUNC(SYSDATE)
	 AND	NVL(BENC.FECHA_TERMINO_BENEFICIO,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
		 AND coaf.folio_suscripcion = benc.coaf_folio_suscripcion
	 AND coaf.orga_codigo_isapre = benc.coaf_orga_codigo_isapre
	 AND pers.correlativo = benc.pers_correlativo
		 AND PLAN.correlativo = coaf.plan_correlativo
		 AND ubic.benc_coaf_folio_suscripcion(+) = benc.coaf_folio_suscripcion
		 AND ubic.benc_coaf_orga_codigo_isapre(+) = benc.coaf_orga_codigo_isapre
		 AND ubic.benc_codigo_carga(+) = benc.codigo_carga
	 AND ubic.usdi_correlativo(+) = 1
	 AND comu.correlativo(+) = ubic.zona_correlativo_comu
	 AND ciud.correlativo(+) = comu.zona_correlativo_ciudad;
      Out_vextcodestben := 'C';
      Out_vextdescestado := 'Certificado';
DBMS_OUTPUT.PUT_LINE ( 'Out_vextrutcotizante ' ||Out_vextrutcotizante);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
		   BEGIN
			  DBMS_OUTPUT.PUT_LINE ( '**2** '||v_nfolio_suscripcion||' '||v_ncodigo_isapre);
		      SELECT Llena_Espacios(pers.rut_real,10)||'-'||pers.digrut	rut_cot,
			  		 SUBSTR(pers.apellido_paterno||' '||pers.apellido_materno||' '||pers.nombre,1,40) nombre,
					 RPAD(ubic.calle||' '||ubic.numero||DECODE(ubic.bloque,NULL,'',' BLOCK '||ubic.bloque)||DECODE(ubic.depto,NULL,'',' DEPTO. '||ubic.depto),40) direccion,
					 comu.descripcion	comuna,
					 ciud.descripcion	ciudad,
					 coaf.renuncia_excedente,
					 PLAN.codigo_comercial
			INTO Out_vextrutcotizante,
					 Out_vextnomcotizante,
					 Out_vextdirpaciente,
					 Out_vextglosacomuna,
					 Out_vextglosaciudad,
					 v_vrenuncia_excedente,
					 Out_vextplan
			FROM afi_beneficiarios_contrato benc,
					 afi_contratos_afiliados coaf,
					 afi_personas pers,
					 pln_planes PLAN,
					 glo_ubicaciones ubic,
					 glo_zonas comu,
					 glo_zonas ciud
		       WHERE benc.coaf_folio_suscripcion = v_nfolio_suscripcion --7192530
			 AND benc.coaf_orga_codigo_isapre = v_ncodigo_isapre --71
			 AND benc.codigo_carga = 0
				 --AND benc.fecha_termino_beneficio IS NULL
		 AND benc.FECHA_INICIO_BENEFICIOS <= TRUNC(SYSDATE)
		 AND	NVL(BENC.FECHA_TERMINO_BENEFICIO,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
				 AND coaf.folio_suscripcion = benc.coaf_folio_suscripcion
			 AND coaf.orga_codigo_isapre = benc.coaf_orga_codigo_isapre
			 AND pers.correlativo = benc.pers_correlativo
				 AND PLAN.correlativo = coaf.plan_correlativo
				 AND ubic.benc_coaf_folio_suscripcion(+) = benc.coaf_folio_suscripcion
				 AND ubic.benc_coaf_orga_codigo_isapre(+) = benc.coaf_orga_codigo_isapre
				 AND ubic.benc_codigo_carga(+) = benc.codigo_carga
			 AND comu.correlativo(+) = ubic.zona_correlativo_comu
			 AND ciud.correlativo(+) = comu.zona_correlativo_ciudad
				 AND ROWNUM = 1;
		      Out_vextcodestben := 'C';
		      Out_vextdescestado := 'Certificado';
DBMS_OUTPUT.PUT_LINE ( 'Out_vextrutcotizante 2' ||Out_vextrutcotizante);
		   EXCEPTION
			WHEN NO_DATA_FOUND THEN
			 	     Out_vReturnStatus	  := '1';
				 Out_vextcodestben 	  := 'X';
				 Out_vextdescestado   := 'NO CERTIFICADO'; -- estado por definir no existe afiliado
				 Out_vextglosa 		  := 'COTIZANTE NO ENCONTRADO';
			   		 Out_vMessageText	  := v_vCarIniMessageText||Out_vextglosa;
			--jm	 Out_vMessageCode     := '78003';
					 Out_vMessageCode     := '00000';
					 DBMS_OUTPUT.PUT_LINE ( 'Out_vextglosa1= ' || Out_vextglosa );
				 RAISE e_fin;
			WHEN OTHERS THEN
				     Out_vReturnStatus	  := '1';
				 Out_vextcodestben 	  := 'X';
				 Out_vextdescestado   := 'NO CERTIFICADO'; -- estado por definir otro error
			--	 Out_vextglosa 		  := RPAD(SQLERRM,1,30);
				 Out_vextglosa 		  := '1-ERROR COTIZANTE';
			   		 Out_vMessageText	  := v_vCarIniMessageText||Out_vextglosa;
			--		 Out_vMessageCode     := '78005';
					 Out_vMessageCode     := '00000';
					 DBMS_OUTPUT.PUT_LINE ( 'Out_vextglosa2= ' || Out_vextglosa );
				 RAISE e_fin;
		   END;
      WHEN TOO_MANY_ROWS THEN
	       Out_vReturnStatus    := '1';
	   Out_vextcodestben 	  := 'X';
	   Out_vextdescestado	:= 'NO CERTIFICADO'; -- estado por definir existe mas de un afiliado
	   Out_vextglosa 		  := '2-ERROR COTIZANTE';
   		   Out_vMessageText	  := v_vCarIniMessageText||Out_vextglosa;
--		   Out_vMessageCode	:= '78004';
		   Out_vMessageCode	:= '00000';
		   DBMS_OUTPUT.PUT_LINE ( 'Out_vextglosa3= ' || Out_vextglosa );
	   RAISE e_fin;
      WHEN OTHERS THEN
			Out_vReturnStatus    := '1';
			Out_vextcodestben 	  := 'X';
			Out_vextdescestado   := 'NO CERTIFICADO'; -- estado por definir otro error
			-- Out_vextglosa 		  := RPAD(SQLERRM,1,30);
			Out_vextglosa 		  := '3-ERROR COTIZANTE';
			Out_vMessageText	  := v_vCarIniMessageText||Out_vextglosa;
			-- Out_vMessageCode	:= '78005';
			Out_vMessageCode     := '00000';
			DBMS_OUTPUT.PUT_LINE ( 'Out_vextglosa= ' || Out_vextglosa );
			RAISE e_fin;
   END;
    PCK_BEN_SERVICIOS_IMED.P_C_DATOS_CONTRATO_FECHA(po_cPlan,
						      v_nfolio_suscripcion,
						      v_ncodigo_isapre,
						      TO_CHAR(SYSDATE,'dd/mm/rrrr'));
	BEGIN
	LOOP
	FETCH po_cPlan INTO vn_PLAN_CORRELATIVO,
						    vn_PLAN_CORRELATIVO_SIETE,
						    vn_PORCENTAJE_BONIF_HOSP,
						    vn_PORCENTAJE_BONIF_AMBU,
						    vn_PORCENTAJE_BONIF_DENT,
						    vn_PORCENTAJE_BONIF_MED;
	    EXIT WHEN po_cPlan%NOTFOUND;
	    END LOOP;
	END;
   SELECT CODIGO_COMERCIAL
   INTO   OUT_VEXTPLAN
   FROM   PLN_PLANES
   WHERE  CORRELATIVO = VN_PLAN_CORRELATIVO;


    --********************************************************************************************************************
    --Retorna Atributo Familia del Plan BNF-000940
    --********************************************************************************************************************
     out_vextplan:=substr(pck_pro_mant_general.f_datos_tipo_atrib (vn_plan_correlativo,'FAMIPLAN',3,sysdate),1,200);
    --********************************************************************************************************************
    --********************************************************************************************************************


   --********************************************************************************************************************
   --BNF-000735 llamada a servicio de planes para obtener valor  de variable Out_vextprevision
   --********************************************************************************************************************

   -- 01/06/2011
   -- BNF-000720 : Informar para casos que posee BC72 una D, solo el prestador Clinica Davila esta al tanto de esta modificacion.
--   Begin
--	  v_vPOSEE_VIGENTE_BC_72:=AFIL.Pck_Afil_Vf_Servicios.F_VIGENCIA_BC(
--						  v_nfolio_suscripcion,
--						  v_ncodigo_isapre,
--						  to_char(Sysdate,'mm/rrrr'),
--						  72 );

--   Exception
--   When Others Then
--	  v_vPOSEE_VIGENTE_BC_72:='N';
--   end;


--   If v_vPOSEE_VIGENTE_BC_72 = 'S' then

--	   Out_vextprevision:='D';

--   Else
--	   Out_vextprevision:= 'A';

--   End if;

   BEGIN
      Out_vextprevision := 'A';
      PCK_PRO_BENEFICIOS_GEN.P_C_VERIFICABCYPRESTADOR (v_nfolio_suscripcion,		-- PIN_NFOLIOSUSCRIPCION
							       v_ncodigo_isapre,		-- PIN_NCODIGOCARGA
							       to_char(Sysdate,'dd/mm/rrrr'),	   -- PIN_VFECHACONSULTA
							       '72',				-- PIN_VCODIGOBC
							       96530470,			-- PIN_RUT_PRESTADOR
							       Out_vextprevision);		-- POU_VDATOSALIDA

      IF Out_vextprevision IS NULL THEN
	 Out_vextprevision := 'A';
      END IF;
   EXCEPTION
	WHEN OTHERS THEN
	Out_vextprevision := 'A';
   END;
   --********************************************************************************************************************
   --********************************************************************************************************************

--	 BEGIN
--	   SELECT MAX(DISTINCT copa.tipo_trabajador) --- CAGF 20030317 SOLO PARA PRUEBAS, SE DEBE DEFINIR UN UNICO TIPO
--	     INTO Out_vextprevision
--	     FROM afi_cotizaciones_pactadas copa
--	    WHERE copa.coaf_folio_suscripcion = v_nfolio_suscripcion
--	      AND copa.coaf_orga_codigo_isapre = v_ncodigo_isapre
--	      AND copa.fecha_ultima_cotizac IS NULL;
--	 EXCEPTION
--	      WHEN OTHERS THEN
--		   Out_vextprevision:= 'X';
--	 END;
DBMS_OUTPUT.PUT_LINE ( 'Out_vextprevision= ' || Out_vextprevision );
   -- Consulta Excedentes
   v_vrenuncia_excedente:='N';
   DBMS_OUTPUT.PUT_LINE ( 'v_vrenuncia_excedente= ' || v_vrenuncia_excedente );
   BEGIN
     IF  v_vrenuncia_excedente = 'N' THEN
	 Pr_Actualiza_Ctaind ('CONSULTA',1,v_nfolio_suscripcion,v_ncodigo_isapre,0,TO_CHAR(SYSDATE,'dd/mm/yyyy'),0,v_nnumero,v_nexcedente);
	 Out_nextmontoexcedente := NVL ( TO_NUMBER ( v_nexcedente ), 0 );
		 DBMS_OUTPUT.PUT_LINE ( 'Out_nextmontoexcedente= ' || Out_nextmontoexcedente );
	 w_con_exc:=1;
     ELSE
	 w_con_exc := 0;
	 Out_nextmontoexcedente := 0;
     END IF;
   EXCEPTION
	WHEN OTHERS THEN
	     Out_nextmontoexcedente := 0; --  si no tiene cuenta excedente devuelve 0
	     DBMS_OUTPUT.PUT_LINE (    '*** EXCEDENTES ***  FALLO ACCESO A OPER: '|| SQLERRM);
   END;
-- Consulta Acompa?antes NUEVO 20030210
-- Consulta grupo familiar solo si el beneficiario consultado es menor que 6 a?os y mayor que 80 a?os
   BEGIN
   --Edad del beneficiarios
	   BEGIN
	      SELECT DISTINCT F_Imed_Calcula_Edad(pers.FECHA_NACIMIENTO)
		    INTO v_nEdad
		FROM afi_beneficiarios_contrato benc,
				 afi_personas pers
	       WHERE benc.coaf_folio_suscripcion   = v_nfolio_suscripcion
		 AND benc.coaf_orga_codigo_isapre  = v_ncodigo_isapre
		 AND benc.codigo_carga 			   = v_ncodigo_carga
			 --AND benc.fecha_termino_beneficio IS NULL
	     AND benc.FECHA_INICIO_BENEFICIOS <= TRUNC(SYSDATE)
	     AND    NVL(BENC.FECHA_TERMINO_BENEFICIO,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
			 AND benc.PERS_CORRELATIVO = pers.correlativo
			 AND
			 (F_Imed_Calcula_Edad(pers.FECHA_NACIMIENTO) < 6 OR F_Imed_Calcula_Edad(pers.FECHA_NACIMIENTO) > 80)
			 ;
			 v_bEstaEnRango:=TRUE;
	   EXCEPTION
	   WHEN NO_DATA_FOUND THEN
			 v_bEstaEnRango:=FALSE;
	   END;
   IF v_bEstaEnRango THEN
	  IF c_grupo_familiar%ISOPEN
      THEN
	 CLOSE c_grupo_familiar;
      ELSE
	  OPEN c_grupo_familiar ( v_nfolio_suscripcion
				     , v_ncodigo_isapre
				     , v_ncodigo_carga --- 0 ?
				     ); --v_nCodigo_Carga); ' --20030125 CAGF Se debe cargar tabla de acompa?antes
												  --Se busca solo por Carga 0 o Correlativo Beneficiario
	  END IF;
	  LOOP
	 FETCH c_grupo_familiar
		 INTO Aux_CurvExtRutAcompanante
	 	, Aux_CurvExtNombreAcompanante;
		 EXIT WHEN c_grupo_familiar%NOTFOUND;
		 SRV_Row_Count := SRV_Row_Count + 1;
--  mjbv 11/7/2003 se quita validacion por unificacion de mensajeria, pedido por A.Montero
-- 		 IF SRV_Row_Count > SRV_Total_Rows THEN
--		 	RAISE E_MAX_ACOM_VALIDOS;
--		 END IF;
--  mjbv 11/7/2003
   		 SRV_FetchStatus  := '1';
		 Col_vExtRutAcompanante    (SRV_Row_Count)    := Aux_CurvExtRutAcompanante;
   		 Col_vExtNombreAcompanante (SRV_Row_Count)    := Aux_CurvExtNombreAcompanante;
	  END LOOP;
	  CLOSE c_grupo_familiar;
	  IF v_nEdad > 80 THEN
			  SRV_Row_Count := SRV_Row_Count + 1;
		      SELECT --DECODE(pers.rut || '-' || pers.digrut,'-',F_Retorna_Hom_Benef(benc.coaf_folio_suscripcion,benc.coaf_orga_codigo_isapre,benc.codigo_carga),pers.rut || '-' || pers.digrut)
			  		 DECODE(F_Retorna_Rut(pers.correlativo),'0000000000-0',F_Retorna_Rut_Hom_Benef(benc.coaf_folio_suscripcion,benc.coaf_orga_codigo_isapre,benc.codigo_carga),F_Retorna_Rut(pers.correlativo))
			   , SUBSTR(pers.nombre|| ' '|| pers.apellido_paterno|| ' '|| pers.apellido_materno,1,40)
				INTO
				 Col_vExtRutAcompanante    (SRV_Row_Count)    ,
		   		 Col_vExtNombreAcompanante (SRV_Row_Count)
			FROM afi_contratos_afiliados coaf,
			 	 afi_beneficiarios_contrato benc,
					 afi_personas pers
		       WHERE benc.coaf_folio_suscripcion   = coaf.folio_suscripcion
			 AND benc.coaf_orga_codigo_isapre  = coaf.orga_codigo_isapre
				 --AND coaf.fecha_desahucio IS NULL
		 AND	NVL(coaf.fecha_desahucio,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
		       	 AND benc.coaf_folio_suscripcion   = v_nfolio_suscripcion
			 AND benc.coaf_orga_codigo_isapre  = v_ncodigo_isapre
			 AND benc.codigo_carga 			   = v_ncodigo_carga
				 --AND benc.fecha_termino_beneficio IS NULL
		 AND benc.FECHA_INICIO_BENEFICIOS <= TRUNC(SYSDATE)
		 AND	NVL(BENC.FECHA_TERMINO_BENEFICIO,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
				 AND benc.PERS_CORRELATIVO = pers.correlativo
				 ;
	  END IF;
	  -- ver si el contrato del benefciario es Matrimonial
	  BEGIN
	  	   SELECT coaf.COAF_FOLIO_SUSCRIPCION
		   INTO v_nfolio_suscripcion_conyuge
		   FROM afi_contratos_afiliados coaf
		   WHERE coaf.FOLIO_SUSCRIPCION = v_nfolio_suscripcion
		   AND	 coaf.ORGA_CODIGO_ISAPRE = 71
		   --AND   coaf.FECHA_DESAHUCIO IS NULL
	   AND	  NVL(coaf.FECHA_DESAHUCIO,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
	   AND	 coaf.tipo_plan = 'M'
		   ;
	  	   v_bMatrimonial:=TRUE;
	  EXCEPTION
	  WHEN NO_DATA_FOUND THEN
	  	   v_bMatrimonial:=FALSE;
	  END;
	  IF v_bMatrimonial THEN
	  --Traer el grupo del conyuge
-----------------------------------------------
		  IF c_grupo_familiar_conyuge%ISOPEN
	      THEN
		 CLOSE c_grupo_familiar_conyuge;
	      ELSE
		  OPEN c_grupo_familiar_conyuge ( v_nfolio_suscripcion_conyuge
					     , v_ncodigo_isapre
					     , v_ncodigo_carga --- 0 :1
					     ); --v_nCodigo_Carga); ' --20030125 CAGF Se debe cargar tabla de acompa?antes
													  --Se busca solo por Carga 0 o Correlativo Beneficiario
		  END IF;
		  LOOP
		 FETCH c_grupo_familiar_conyuge
			 INTO Aux_CurvExtRutAcompanante
		 	, Aux_CurvExtNombreAcompanante;
			 EXIT WHEN c_grupo_familiar_conyuge%NOTFOUND;
			 SRV_Row_Count := SRV_Row_Count + 1;
--  mjbv 11/7/2003 se quita validacion por unificacion de mensajeria, pedido por A.Montero
--	 		 IF SRV_Row_Count > SRV_Total_Rows THEN
--			 	RAISE E_MAX_ACOM_VALIDOS;
--			 END IF;
--  mjbv 11/7/2003
	   		 SRV_FetchStatus  := '1';
			 Col_vExtRutAcompanante    (SRV_Row_Count)    := Aux_CurvExtRutAcompanante;
	   		 Col_vExtNombreAcompanante (SRV_Row_Count)    := Aux_CurvExtNombreAcompanante;
		  END LOOP;
		  CLOSE c_grupo_familiar_conyuge;
-----------------------------------------------
	  END IF;
	  IF  SRV_ROW_COUNT = 0 THEN
	  	  col_vextrutacompanante(1)   := '0000000000-0';
		  col_vextnombreacompanante(1):= '					  ';
	  END IF;
   ELSE
	  	  col_vextrutacompanante(1)   := '0000000000-0';
		  col_vextnombreacompanante(1):= '					  ';
   END IF;
   EXCEPTION WHEN E_MAX_ACOM_VALIDOS THEN
     Out_vReturnStatus	  := '1';
     Out_vextglosa	  := 'Num. Acomp > al requerido';
	 Out_vMessageText	  := v_vCarIniMessageText||Out_vextglosa;
--jm Out_vMessageCode	  := '78009';
	 Out_vMessageCode     := '00000';
   	 RAISE E_FIN;
   END;
    --02-09-2005 Se comenta validacion de deuda por que se hara en nuevo srvicio Conbencertif_Pkg EACE
    /*
	-- Verifica Deuda de ultimo mes (COMPAG)
    IF Pck_Imed_Adm_Proc.F_IMED_BLOQUEA_SECCION('VERIFICA_DEUDA_COMPAG') = 'S' THEN
	BEGIN
   	   v_nRut := TO_NUMBER(SUBSTR(Out_vextrutcotizante,1,INSTR(Out_vextrutcotizante,'-')-1));
	   --
	   v_DEUDA := Pck_Imed_Externos.F_IMED_Posee_Deuda_ult_peri(v_nRut, 'N');
	   --SELECT Pck_Imed_Externos.F_IMED_Posee_Deuda_ult_peri(v_nRut, 'N')
	   --INTO v_DEUDA
	   --FROM dual;
	   IF v_DEUDA='S' THEN
		   Out_vReturnStatus  := '1';
		   Out_vextcodestben  := 'X';
		   Out_vextdescestado := 'NO CERTIFICADO';
		   --Out_vextglosa 	  := 'No emite Imed. Compre Consalud';
		   Out_vextglosa 	  := Pck_Imed_Adm_Proc.F_IMED_RETORNA_MENSAJE('BLOQUEO_IMED_DEUDA_COMPAG');
		   Out_vMessageText	  := v_vCarIniMessageText||Out_vextglosa;
		   DBMS_OUTPUT.PUT_LINE ( 'Out_vextglosa255= ' || Out_vextglosa );
		   Out_vMessageCode   := '00000';
		   RAISE e_fin;
	   END IF;
    END;
	END IF;
   -- Verifica Deuda de ultimo mes (COMPAG)
   */
   --02-09-2005 Se comenta validacion de deuda por que se hara en nuevo srvicio Conbencertif_Pkg EACE
-- Setea salida correcta
   Out_vReturnStatus  						  := '1';
   Out_vextglosa   	  						  := 'Servicio Correcto';
   Out_vMessageText							  := v_vCarIniMessageText||Out_vextglosa;
   Out_vMessageCode 						  := '00000';
   w_fechor_salida := TO_DATE ( TO_CHAR ( SYSDATE, 'rrrr/mm/dd hh24:mi:ss' ), 'rrrr/mm/dd hh24:mi:ss');
   SRV_Message := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
   v_vSalida_Format  := SETEA_SALIDA;
    w_res :=
     Imed_Graba_Auditoria ( v_vnomtrans
			   , v_dextfechaactual
			   , NULL
			   , NULL
			   , NULL
			   , NULL
			   , v_nextrutbeneficiario
			   , TO_NUMBER ( SUBSTR ( Out_vextrutcotizante, 1, 10 ) )
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
			   , NVL(Out_nextmontoexcedente,0)
			   , w_con_top
			   , w_con_cig
			   , 0
			   );
   RETURN;
EXCEPTION
   WHEN E_FIN
   THEN
--Arma Respuesta Erronea
	  LIMPIA;
	  /* Graba Auditoria*/
      w_fechor_salida:= TO_DATE( TO_CHAR ( SYSDATE, 'rrrr/mm/dd hh24:mi:ss' ), 'rrrr/mm/dd hh24:mi:ss');
      SRV_Message:= Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
   	  v_vSalida_Format:= SETEA_SALIDA;
      w_res := Imed_Graba_Auditoria ( v_vnomtrans
			      , v_dextfechaactual
			      , NULL
			      , NULL
			      , NULL
			      , NULL
			      , v_nextrutbeneficiario
			      , TO_NUMBER ( SUBSTR ( Out_vextrutcotizante, 1, 10 ))
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
			      , NVL(Out_nextmontoexcedente,0)
			      , w_con_top
			      , w_con_cig
			      , 0
			      );
   RETURN;
   WHEN OTHERS
   THEN
   	  LIMPIA;
--Arma Respuesta Erronea
	  Out_vReturnStatus		  	  		   		  := '1';
   	  Out_vextglosa   	  						  := RPAD('ERROR GENERAL: AVISE'||v_vNomTrans,30);
      Out_vMessageText							  := v_vCarIniMessageText||Out_vextglosa;
--jm  Out_vMessageCode 						  	  := '78050';
   	  Out_vMessageCode 						  	  := '00000';
      w_fechor_salida :=
      TO_DATE ( TO_CHAR ( SYSDATE, 'rrrr/mm/dd hh24:mi:ss' ), 'rrrr/mm/dd hh24:mi:ss');
      SRV_Message := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
   	  v_vSalida_Format  := SETEA_SALIDA;
      w_res := Imed_Graba_Auditoria ( v_vnomtrans
			      , v_dextfechaactual
			      , NULL
			      , NULL
			      , NULL
			      , NULL
			      , v_nextrutbeneficiario
			      , TO_NUMBER ( SUBSTR ( Out_vextrutcotizante, 1, 10 ))
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
			      , NVL(Out_nextmontoexcedente,0)
			      , w_con_top
			      , w_con_cig
			      , 0
			      );
	  RETURN;
END;
END Conbencertif_Pkg;

898 rows selected.

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
