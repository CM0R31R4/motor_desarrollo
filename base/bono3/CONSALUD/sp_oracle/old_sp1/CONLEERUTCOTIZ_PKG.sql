
SQL*Plus: Release 11.2.0.3.0 Production on Wed Mar 5 19:00:01 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONLEERUTCOTIZ
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTRUTCOTIZANTE		VARCHAR2		IN
 OUT_VEXTNOMCOTIZANTE		VARCHAR2		OUT
 OUT_VEXTCODERROR		VARCHAR2		OUT
 OUT_VEXTMENSAJEERROR		VARCHAR2		OUT
 COL_NEXTCORRBENEF		TABLE OF NUMBER(3)	OUT
 COL_VEXTRUTBENEFICIARIO	TABLE OF VARCHAR2(12)	OUT
 COL_VEXTAPELLIDOPAT		TABLE OF VARCHAR2(30)	OUT
 COL_VEXTAPELLIDOMAT		TABLE OF VARCHAR2(30)	OUT
 COL_VEXTNOMBRES		TABLE OF VARCHAR2(40)	OUT
 COL_VEXTCODESTBEN		TABLE OF VARCHAR2(1)	OUT
 COL_VEXTDESCESTADO		TABLE OF VARCHAR2(15)	OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Conleerutcotiz_Pkg
AS
  TYPE CurnExtCorrBenef_arr IS TABLE OF NUMBER(3)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtRutBeneficiario_arr IS TABLE OF VARCHAR2(12)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtApellidoPat_arr	  IS TABLE OF VARCHAR2(30)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtApellidoMat_arr	  IS TABLE OF VARCHAR2(30)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtNombres_arr  		  IS TABLE OF VARCHAR2(40)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtCodEstBen_arr  	  IS TABLE OF VARCHAR2(1)
    INDEX BY BINARY_INTEGER;

  TYPE CurvExtDescEstado_arr	  IS TABLE OF VARCHAR2(15)
    INDEX BY BINARY_INTEGER;


   PROCEDURE Conleerutcotiz
   (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nextCodFinanciador	 	IN 	   NUMBER
		   , In_vextRutCotizante			IN 	   VARCHAR2
		   , Out_vextNomCotizante	   	OUT    VARCHAR2
		   , Out_vextCodError		 	OUT	   VARCHAR2
	   , Out_vextMensajeError			OUT	   VARCHAR2
	   , Col_nExtCorrBenef				OUT    CurnExtCorrBenef_arr
	   , Col_vExtRutBeneficiario		OUT    CurvExtRutBeneficiario_arr
	   , Col_vExtApellidoPat			OUT    CurvExtApellidoPat_arr
	   , Col_vExtApellidoMat			OUT    CurvExtApellidoMat_arr
	   , Col_vExtNombres				OUT    CurvExtNombres_arr
		   , Col_vExtCodEstBen				OUT    CurvExtCodEstBen_arr
   		   , Col_vExtDescEstado				OUT    CurvExtDescEstado_arr
   );
END Conleerutcotiz_Pkg;

41 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     Conleerutcotiz_Pkg
AS

   PROCEDURE Conleerutcotiz
   (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nextCodFinanciador	 	IN 	   NUMBER
		   , In_vextRutCotizante			IN 	   VARCHAR2
		   , Out_vextNomCotizante	   	OUT    VARCHAR2
		   , Out_vextCodError		 	OUT	   VARCHAR2
	   , Out_vextMensajeError			OUT	   VARCHAR2
	   , Col_nExtCorrBenef				OUT    CurnExtCorrBenef_arr
	   , Col_vExtRutBeneficiario		OUT    CurvExtRutBeneficiario_arr
	   , Col_vExtApellidoPat			OUT    CurvExtApellidoPat_arr
	   , Col_vExtApellidoMat			OUT    CurvExtApellidoMat_arr
	   , Col_vExtNombres				OUT    CurvExtNombres_arr
		   , Col_vExtCodEstBen				OUT    CurvExtCodEstBen_arr
   		   , Col_vExtDescEstado				OUT    CurvExtDescEstado_arr
   )
IS

v_vnomtrans		   	 VARCHAR2 ( 50 )   := UPPER('Conleerutcotiz_Pkg');
v_vEntrada_Format			 VARCHAR2(2000);
v_vSalida_Format			 VARCHAR2(2000);

v_sep_ES	   				 VARCHAR2(1):=';';
Out_vReturnStatus			 VARCHAR2(1);
Out_vMessageCode 			 VARCHAR2(5);
Out_vMessageText			 VARCHAR2(243);

SRV_FetchStatus				 NUMBER(1);
SRV_Total_Rows				 NUMBER(8);
SRV_Row_Count				 NUMBER(8);
v_vCarIniMessageText		 VARCHAR2(1):='X'; -- Para diferenciar Out_vMessageText
											   -- de Out_vExtMensajeError

-- Codigo de la Isapre para validar contra entrada
v_ncod_isa_cons 	     NUMBER:= 71;

-- Variables para almacenar parametros de entrada
v_nextcodfinanciador	     NUMBER ( 3 );
v_nextrutcotizante	     NUMBER ( 10 );
v_vextrutcotizante	     VARCHAR2 ( 12 );
v_vextrutcotizante_c	     VARCHAR2 ( 12 );
v_vextdvcotizante_c	     VARCHAR2 ( 1 );
v_vRutBenefHomologado		 VARCHAR2 ( 12 );
v_nTotal_Benef_Cursor		 NUMBER;

E_FIN			     EXCEPTION;
E_MAX_BENEF_CONTRATO		 EXCEPTION;
E_ENCONTRO_VIGENTE	     EXCEPTION;
E_NO_VIGENTE				 EXCEPTION;
E_NO_COTIZANTE				 EXCEPTION;
E_RUT_COTIZANTE_SIN_FOLIO	 EXCEPTION;
E_NO_BENEF_CONTRATO			 EXCEPTION;
v_nnumero_benef 	     NUMBER ( 3 );
v_nfolio_suscripcion	     NUMBER ( 10 );
v_nIsapre					 NUMBER ( 3 );
v_ncodigo_carga 	     NUMBER ( 10 );
v_dfecha_termino_beneficio   DATE;
v_nnumero_filas_cotiz	     NUMBER;
v_ndescomponerut	     NUMBER;

v_nnocotizante		     NUMBER	       := 0;
v_nnovigente		     NUMBER	       := 0;

   CURSOR c_cotiz_contrato ( p_rut_cotizante IN NUMBER )
   IS
      SELECT
	     benc.coaf_folio_suscripcion
		   , benc.coaf_orga_codigo_isapre
	   , SUBSTR(pers.nombre|| ' '|| pers.apellido_paterno|| ' '|| pers.apellido_materno,1,40)
	   , benc.codigo_carga
		   , benc.fecha_termino_beneficio
	FROM afi_beneficiarios_contrato benc --@embe_oper benc
	   , afi_personas pers --@embe_oper pers
       WHERE pers.correlativo = benc.pers_correlativo
--	  AND benc.fecha_termino_beneficio IS NULL --20030211 CAGF DEF. MBORBAR si no esta vigente informa error
		 AND benc.codigo_carga = 0
	 AND pers.rut_real = p_rut_cotizante;


   CURSOR c_benef_contrato ( p_folio_suscripcion IN NUMBER
      		  			   , p_isapre			 IN NUMBER)
   IS
      SELECT
	       SUBSTR(pers.nombre|| ' '|| pers.apellido_paterno|| ' '|| pers.apellido_materno,1,40) NombCompBenef
	     , benc.codigo_carga   						   	 	 					   ctzcorr
	     , LPAD(NVL(pers.rut_real,0) || '-' || NVL(pers.digrut,'0'),12,'0')		   bnfrut
	     , pers.apellido_paterno   	   	  										   bnfapp
			 , pers.apellido_materno 												   bnfapm
	     , pers.nombre 															   bnfnnm
			 , benc.fecha_termino_beneficio											   bnvig
	  FROM afi_beneficiarios_contrato benc --@embe_oper benc
	     , afi_personas pers --@embe_oper pers
	 WHERE pers.correlativo = benc.pers_correlativo
       --  AND benc.fecha_termino_beneficio IS NULL --20030211 CAGF DEF. MBORBAR si no esta vigente informa estado X Benef No Vig.
	   	   AND benc.VIGENCIA = 'S'
	   AND benc.coaf_folio_suscripcion  = p_folio_suscripcion
		   AND benc.coaf_orga_codigo_isapre = p_isapre
      ORDER BY benc.codigo_carga ASC;


FUNCTION SETEA_ENTRADA
RETURN VARCHAR2
IS
v_vEntrada			   VARCHAR2(2000);
BEGIN
v_vEntrada	:= SUBSTR(SUBSTR(SRV_Message,1,256)||v_sep_ES||
			   TO_CHAR(In_nextCodFinanciador)||v_sep_ES||
			   In_vextRutCotizante||v_sep_ES,1,2000);
RETURN v_vEntrada;
END;

FUNCTION SETEA_SALIDA
RETURN VARCHAR2
IS
v_vSalida	   VARCHAR2(2000);
BEGIN
v_vSalida	:= RTRIM(RPAD(SRV_Message||v_sep_ES,2000));
FOR i IN 1 ..COL_NEXTCORRBENEF.COUNT LOOP
  v_vSalida := RTRIM(RPAD(v_vSalida || TO_CHAR(COL_NEXTCORRBENEF(i))||v_sep_ES,2000));
END LOOP;
FOR i IN 1 ..COL_VEXTRUTBENEFICIARIO.COUNT LOOP
  v_vSalida := RTRIM(RPAD(v_vSalida || COL_VEXTRUTBENEFICIARIO(i)||v_sep_ES,2000));
END LOOP;

FOR i IN 1 ..COL_VEXTAPELLIDOPAT.COUNT LOOP
v_vSalida := RTRIM(RPAD(v_vSalida ||COL_VEXTAPELLIDOPAT(i)||v_sep_ES,2000));
END LOOP;

FOR i IN 1 ..COL_VEXTAPELLIDOMAT.COUNT LOOP
v_vSalida := RTRIM(RPAD(v_vSalida ||COL_VEXTAPELLIDOMAT(i)||v_sep_ES,2000));
END LOOP;

FOR i IN 1 ..COL_VEXTNOMBRES.COUNT LOOP
v_vSalida := RTRIM(RPAD(v_vSalida ||COL_VEXTNOMBRES(i)||v_sep_ES,2000));
END LOOP;

FOR i IN 1 ..COL_VEXTCODESTBEN.COUNT LOOP
v_vSalida := RTRIM(RPAD(v_vSalida ||COL_VEXTCODESTBEN(i)||v_sep_ES,2000));
END LOOP;

FOR i IN 1 ..COL_VEXTDESCESTADO.COUNT LOOP
v_vSalida := RTRIM(RPAD(v_vSalida ||COL_VEXTDESCESTADO(i)||v_sep_ES,2000));
END LOOP;

RETURN v_vSalida;

END;

PROCEDURE LIMPIA
AS
BEGIN
  SRV_FetchStatus	   				  := '0';
  OUT_VEXTNOMCOTIZANTE		      := ' ';
  COL_NEXTCORRBENEF.DELETE;
  COL_VEXTRUTBENEFICIARIO.DELETE;
  COL_VEXTAPELLIDOPAT.DELETE;
  COL_VEXTAPELLIDOMAT.DELETE;
  COL_VEXTNOMBRES.DELETE;
  COL_VEXTCODESTBEN.DELETE;
  COL_VEXTDESCESTADO.DELETE;

  COL_NEXTCORRBENEF(1)		      := 0;
  COL_VEXTRUTBENEFICIARIO(1) 		  := '0000000000-0';
  COL_VEXTAPELLIDOPAT(1)			  := ' ';
  COL_VEXTAPELLIDOMAT(1)			  := ' ';
  COL_VEXTNOMBRES(1)				  := ' ';
  COL_VEXTCODESTBEN(1)				  := ' ';
  COL_VEXTDESCESTADO(1)				  := ' ';

END;
BEGIN
   v_nextcodfinanciador := TO_NUMBER (In_nextCodFinanciador);

-- Si el codigo no corresponde a Consalud
   IF ( v_nextcodfinanciador != v_ncod_isa_cons )
   THEN
--	  Out_vReturnStatus		 := '0';
   	  Out_vReturnStatus		 := '1';
--    Out_vextCodError 		 := 'S';
      Out_vextCodError 		 := 'N';
      Out_vextMensajeError 	 := 'Codigo isapre no corresponde';
   	  Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
--	  Out_vMessageCode   	 := '78001';
	  Out_vMessageCode   	 := '00000';
      RAISE e_fin;
   END IF;

   v_nextrutcotizante	:= TO_NUMBER ( SUBSTR ( In_vextRutCotizante, 1, 10 ));
   dbms_output.put_line('RUT COTIZANTE: '||v_nextrutcotizante);

   Out_vReturnStatus  := '1';
   SRV_Total_Rows	  := TO_NUMBER(RTRIM(SRV_Message));
   SRV_Row_Count	  :=  0;
   SRV_FetchStatus	  := '0';

   BEGIN

--Variable pare comprobar si entra a query de cotizante*/

      v_nnumero_filas_cotiz := 0;

      v_nnocotizante 	 	:= 0;
      v_nnovigente 	 	  	:= 0;

      IF c_cotiz_contrato%ISOPEN
      THEN
	 CLOSE c_cotiz_contrato;
      END IF;

      OPEN c_cotiz_contrato ( v_nextrutcotizante );

      LOOP
	 FETCH c_cotiz_contrato INTO
		  v_nfolio_suscripcion
		, v_nIsapre
	, Out_vextNomCotizante
	, v_ncodigo_carga
	, v_dfecha_termino_beneficio;
	 EXIT WHEN c_cotiz_contrato%NOTFOUND;
	 v_nnumero_filas_cotiz := v_nnumero_filas_cotiz + 1;

	IF v_ncodigo_carga = 0 AND v_dfecha_termino_beneficio IS NULL
	 THEN
/* Si encuentra al menos 1 contrato vigente para rut
   cotizante carga 0, sale del loop y continua */
	    RAISE e_encontro_vigente;
	 END IF;

	 IF v_ncodigo_carga = 0 AND v_dfecha_termino_beneficio IS NOT NULL
	 THEN
	    v_nnovigente := 1;
	 END IF;

      END LOOP;

--CONSULTA POR FLAGS
--El rut de entrada no tiene un folio

      IF ( v_nnumero_filas_cotiz = 0 )
      THEN
	 RAISE E_RUT_COTIZANTE_SIN_FOLIO;
      END IF;

-- El rut de entrada no tiene ningun contrato vigente*/
      IF v_nnovigente = 1
      THEN
	 RAISE E_NO_VIGENTE;
      END IF;

   EXCEPTION
      WHEN E_ENCONTRO_VIGENTE
	THEN
	NULL;
	 WHEN E_RUT_COTIZANTE_SIN_FOLIO
	    THEN
---		 Out_vReturnStatus		 := '0';
		 Out_vReturnStatus		 := '1';
--		 Out_vextCodError   	 := 'S';
		 Out_vextCodError   	 := 'N';
	 Out_vextMensajeError 	 := 'Cotizante no registrado';
      	 Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
---	  	 Out_vMessageCode   	 := '78002';
	  	 Out_vMessageCode   	 := '00000';
		 RAISE E_FIN;
   	  WHEN 	E_NO_COTIZANTE
	    THEN
---		 Out_vReturnStatus		 := '0';
		 Out_vReturnStatus		 := '1';
--		 Out_vextCodError   	 := 'S';
		 Out_vextCodError   	 := 'N';
	 Out_vextMensajeError	 := 'Beneficiario no cotizante';
      	 Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
---	  	 Out_vMessageCode   	 := '78003';
	  	 Out_vMessageCode   	 := '00000';
	     RAISE E_FIN;
      WHEN E_NO_VIGENTE
	    THEN
---		 Out_vReturnStatus		 := '0';
		 Out_vReturnStatus		 := '1';
--		 Out_vextCodError   	 := 'S';
		 Out_vextCodError   	 := 'N';
	 Out_vextMensajeError 	 := 'Cotizante no vigente';
      	 Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
---	  	 Out_vMessageCode   	 := '78004';
	  	 Out_vMessageCode   	 := '00000';
	     RAISE E_FIN;
   END;


   BEGIN

--Se abre cursor con los Beneficiarios de el contrato.
      FOR r_benef_contrato IN c_benef_contrato ( v_nfolio_suscripcion
	  	  				   	  				   , v_nIsapre )
	  LOOP
	  v_nTotal_Benef_Cursor := c_benef_contrato%ROWCOUNT;
	 SRV_Row_Count := SRV_Row_Count  + 1;

		 IF SRV_Row_Count > SRV_Total_Rows THEN
		 	RAISE E_MAX_BENEF_CONTRATO;
		 END IF;

	 IF r_benef_contrato.bnVig IS NOT NULL THEN
 		 	Col_vExtCodEstBen(SRV_Row_Count)      			   := 'X';
   		 	Col_vExtDescEstado(SRV_Row_Count)     			   := 'Benef No Vig.';
		 ELSE
 		 	Col_vExtCodEstBen(SRV_Row_Count)      			   := 'C';
   		 	Col_vExtDescEstado(SRV_Row_Count)     			   := 'Certificado';
		 END IF;

	 --- Aca setear datos y estado de cada beneficiario que resulte de la consulta
	     Col_nExtCorrBenef(SRV_Row_Count)	   			   := TO_CHAR(r_benef_contrato.ctzcorr);

		 --- 20030225 CAGF Si Rut 0 Entonces Busca HOMOLOGACION
 		 IF r_benef_contrato.bnfrut = '0000000000-0' THEN
		    v_vRutBenefHomologado := NULL;
		    BEGIN
			   SELECT LPAD(TO_CHAR(HOBE.RUT_BENEF),'10','0')||'-'||HOBE.DIG_BENEF
			   INTO	  v_vRutBenefHomologado
			   FROM   IMED_HOMOLOGO_BENEFICIARIOS HOBE
			   WHERE  HOBE.BENC_COAF_FOLIO_SUSCRIPCION  = v_nfolio_suscripcion
			   AND	  HOBE.BENC_COAF_ORGA_CODIGO_ISAPRE = v_nIsapre
			   AND 	  HOBE.BENC_CODIGO_CARGA 			= r_benef_contrato.ctzcorr;


			   Col_vExtRutBeneficiario(SRV_Row_Count) := v_vRutBenefHomologado;
		    EXCEPTION WHEN OTHERS THEN
			  Col_vExtRutBeneficiario(SRV_Row_Count) :=  '0000000000-0';
			END;
		 ELSE
	 Col_vExtRutBeneficiario(SRV_Row_Count)			   := r_benef_contrato.bnfrut;
		 END IF;

	 Col_vExtApellidoPat(SRV_Row_Count)				   := r_benef_contrato.bnfapp;
	 Col_vExtApellidoMat(SRV_Row_Count)				   := r_benef_contrato.bnfapm;
	 Col_vExtNombres(SRV_Row_Count)				       := r_benef_contrato.bnfnnm;


  		 SRV_FetchStatus  := '1';
      END LOOP;

   -- No encontro Beneficiarios para el rut de consulta
   	  IF v_nnumero_benef = 0 THEN
	    RAISE E_NO_BENEF_CONTRATO;
      END IF;


	  EXCEPTION
	    WHEN E_MAX_BENEF_CONTRATO THEN
--		Out_vReturnStatus	 := '0';
		Out_vReturnStatus	 := '1';
--		Out_vextCodError   	 := 'S';
		Out_vextCodError   	 := 'N';
	Out_vextMensajeError := 'Num Benef > al requerido';
   	    Out_vMessageText	 := v_vCarIniMessageText||Out_vextMensajeError;
--	    Out_vMessageCode   	 := '78005';
	    Out_vMessageCode   	 := '00000';
	  RAISE E_FIN;

	    WHEN E_NO_BENEF_CONTRATO THEN
--		Out_vReturnStatus		 := '0';
		Out_vReturnStatus		 := '1';
--		Out_vextCodError   	 := 'S';
		Out_vextCodError   	 := 'N';
	Out_vextMensajeError 	 := 'No Encontro Beneficiarios';
	Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
--	    Out_vMessageCode   	 	 := '78006';
	    Out_vMessageCode   	 	 := '00000';
	RAISE E_FIN;
   END;


-- Setea los codigos de error/informacion
   Out_vReturnStatus	 := '1';
   Out_vextCodError	 := 'S';
   Out_vextMensajeError  := 'Servicio Correcto';
   Out_vMessageText	  	 := v_vCarIniMessageText||Out_vextMensajeError;
   Out_vMessageCode   	 := '00000';
   SRV_Message 			 := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
   RETURN;
EXCEPTION
   WHEN E_FIN
   THEN
   	  LIMPIA;
      SRV_Message := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
	  RETURN;
WHEN OTHERS
   THEN
   	  LIMPIA;
      --Arma Respuesta Erronea
	  Out_vReturnStatus		  	  		   		  := '1';
   	  Out_vextCodError							  := 'N';
	  Out_vextMensajeError 						  := RPAD('ERROR PROC.:'||v_vNomTrans,30);
      Out_vMessageText							  := v_vCarIniMessageText||Out_vextMensajeError;
   	  Out_vMessageCode 						  	  := '00000';
      SRV_Message := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
	  RETURN;
END;
END Conleerutcotiz_Pkg;

402 rows selected.

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
