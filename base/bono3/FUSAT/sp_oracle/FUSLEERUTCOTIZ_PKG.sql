
SQL*Plus: Release 11.2.0.3.0 Production on Mon Aug 3 16:47:47 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.5.0 - 64bit Production

SQL> SQL> PROCEDURE CHULEERUTCOTIZ
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		VARCHAR2		IN
 IN_EXTRUTCOTIZANTE		VARCHAR2		IN
 OUT_EXTNOMCOTIZANTE		VARCHAR2		OUT
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 OUT_EXTCORRBENEF		TABLE OF NUMBER(3)	OUT
 OUT_EXTRUTBENEFICIARIO 	TABLE OF VARCHAR2(12)	OUT
 OUT_EXTAPELLIDOPAT		TABLE OF VARCHAR2(30)	OUT
 OUT_EXTAPELLIDOMAT		TABLE OF VARCHAR2(30)	OUT
 OUT_EXTNOMBRES 		TABLE OF VARCHAR2(40)	OUT
 OUT_EXTCODESTBEN		TABLE OF VARCHAR2(1)	OUT
 OUT_EXTDESCESTADO		TABLE OF VARCHAR2(15)	OUT
PROCEDURE FUSLEERUTCOTIZ
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		VARCHAR2		IN
 IN_EXTRUTCOTIZANTE		VARCHAR2		IN
 OUT_EXTNOMCOTIZANTE		VARCHAR2		OUT
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 OUT_EXTCORRBENEF		TABLE OF NUMBER(3)	OUT
 OUT_EXTRUTBENEFICIARIO 	TABLE OF VARCHAR2(12)	OUT
 OUT_EXTAPELLIDOPAT		TABLE OF VARCHAR2(30)	OUT
 OUT_EXTAPELLIDOMAT		TABLE OF VARCHAR2(30)	OUT
 OUT_EXTNOMBRES 		TABLE OF VARCHAR2(40)	OUT
 OUT_EXTCODESTBEN		TABLE OF VARCHAR2(1)	OUT
 OUT_EXTDESCESTADO		TABLE OF VARCHAR2(15)	OUT
PROCEDURE RBLLEERUTCOTIZ
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		VARCHAR2		IN
 IN_EXTRUTCOTIZANTE		VARCHAR2		IN
 OUT_EXTNOMCOTIZANTE		VARCHAR2		OUT
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 OUT_EXTCORRBENEF		TABLE OF NUMBER(3)	OUT
 OUT_EXTRUTBENEFICIARIO 	TABLE OF VARCHAR2(12)	OUT
 OUT_EXTAPELLIDOPAT		TABLE OF VARCHAR2(30)	OUT
 OUT_EXTAPELLIDOMAT		TABLE OF VARCHAR2(30)	OUT
 OUT_EXTNOMBRES 		TABLE OF VARCHAR2(40)	OUT
 OUT_EXTCODESTBEN		TABLE OF VARCHAR2(1)	OUT
 OUT_EXTDESCESTADO		TABLE OF VARCHAR2(15)	OUT
PROCEDURE SNLLEERUTCOTIZ
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		VARCHAR2		IN
 IN_EXTRUTCOTIZANTE		VARCHAR2		IN
 OUT_EXTNOMCOTIZANTE		VARCHAR2		OUT
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 OUT_EXTCORRBENEF		TABLE OF NUMBER(3)	OUT
 OUT_EXTRUTBENEFICIARIO 	TABLE OF VARCHAR2(12)	OUT
 OUT_EXTAPELLIDOPAT		TABLE OF VARCHAR2(30)	OUT
 OUT_EXTAPELLIDOMAT		TABLE OF VARCHAR2(30)	OUT
 OUT_EXTNOMBRES 		TABLE OF VARCHAR2(40)	OUT
 OUT_EXTCODESTBEN		TABLE OF VARCHAR2(1)	OUT
 OUT_EXTDESCESTADO		TABLE OF VARCHAR2(15)	OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	FUSLeeRutCotiz_Pkg As
  TYPE Out_extCorrBenef_arr IS TABLE OF Number(3)
    INDEX BY BINARY_INTEGER;
  TYPE Out_extRutBeneficiario_arr IS TABLE OF Varchar2(12)
    INDEX BY BINARY_INTEGER;
  TYPE Out_extApellidoPat_arr IS TABLE OF Varchar2(30)
    INDEX BY BINARY_INTEGER;
  TYPE Out_extApellidoMat_arr IS TABLE OF Varchar2(30)
    INDEX BY BINARY_INTEGER;
  TYPE Out_extNombres_arr IS TABLE OF Varchar2(40)
    INDEX BY BINARY_INTEGER;
  TYPE Out_extCodEstBen_arr IS TABLE OF Varchar2(1)
    INDEX BY BINARY_INTEGER;
  TYPE Out_extDescEstado_arr IS TABLE OF Varchar2(15)
    INDEX BY BINARY_INTEGER;
		Procedure FUSLeeRutCotiz  /*  Beneficiarios asociados al Titular, Fundacion  */
     ( SRV_Message		      In Out	 Varchar2,
	  In_extCodFinanciador 	  		 In	    Varchar2			    /*	Codigo de Isapre Fundacion 076 */
    , In_extRutCotizante			 In	    Varchar2			    /*	Rut del beneficiario (Certificacion)  */
    , Out_extNomCotizante			 Out	    Varchar2			    /*	Nombre Completo */
    , Out_extCodError				 Out	    Varchar2			    /*	S o N  */
    , Out_extMensajeError			 Out	    Varchar2			    /*	Descripcion del Error */
    , Out_extCorrBenef				 Out	    Out_extCorrBenef_arr       /*  Correlativo */
    , Out_extRutBeneficiario		 Out	    Out_extRutBeneficiario_arr /*  Rut Carga */
    , Out_extApellidoPat			 Out	    Out_extApellidoPat_arr     /*  Ap Pat Carga */
    , Out_extApellidoMat	     Out	Out_extApellidoMat_arr	   /*  Ap Mat Carga */
    , Out_extNombres				 Out	    Out_extNombres_arr		/*  Nombres Carga */
    , Out_extCodEstBen		     Out	Out_extCodEstBen_arr	   /*  Codigo de estado Carga */
    , Out_extDescEstado 	     Out	Out_extDescEstado_arr	   /*  Descripcion estado Carga  */
    ) ;

	Procedure SNLLeeRutCotiz  /*  Beneficiarios asociados al Titular, Fundacion  */
     ( SRV_Message		      In Out	 Varchar2,
      In_extCodFinanciador		  In	     Varchar2			     /*  Codigo de Isapre Fundacion 076 */
    , In_extRutCotizante	     In 	Varchar2			/*  Rut del beneficiario (Certificacion)  */
    , Out_extNomCotizante	      Out	 Varchar2			 /*  Nombre Completo */
    , Out_extCodError		      Out	 Varchar2			 /*  S o N  */
    , Out_extMensajeError	      Out	 Varchar2			 /*  Descripcion del Error */
    , Out_extCorrBenef		       Out	  Out_extCorrBenef_arr	     /*  Correlativo */
    , Out_extRutBeneficiario	     Out	Out_extRutBeneficiario_arr /*  Rut Carga */
    , Out_extApellidoPat	     Out	Out_extApellidoPat_arr	   /*  Ap Pat Carga */
    , Out_extApellidoMat	     Out	Out_extApellidoMat_arr	   /*  Ap Mat Carga */
    , Out_extNombres		     Out	Out_extNombres_arr	      /*  Nombres Carga */
    , Out_extCodEstBen		     Out	Out_extCodEstBen_arr	   /*  Codigo de estado Carga */
    , Out_extDescEstado 	     Out	Out_extDescEstado_arr	   /*  Descripcion estado Carga  */
    ) ;

	Procedure RBLLeeRutCotiz  /*  Beneficiarios asociados al Titular, Fundacion  */
     ( SRV_Message		      In Out	 Varchar2,
      In_extCodFinanciador		  In	     Varchar2			     /*  Codigo de Isapre Fundacion 076 */
    , In_extRutCotizante	     In 	Varchar2			/*  Rut del beneficiario (Certificacion)  */
    , Out_extNomCotizante	      Out	 Varchar2			 /*  Nombre Completo */
    , Out_extCodError		      Out	 Varchar2			 /*  S o N  */
    , Out_extMensajeError	      Out	 Varchar2			 /*  Descripcion del Error */
    , Out_extCorrBenef		       Out	  Out_extCorrBenef_arr	     /*  Correlativo */
    , Out_extRutBeneficiario	     Out	Out_extRutBeneficiario_arr /*  Rut Carga */
    , Out_extApellidoPat	     Out	Out_extApellidoPat_arr	   /*  Ap Pat Carga */
    , Out_extApellidoMat	     Out	Out_extApellidoMat_arr	   /*  Ap Mat Carga */
    , Out_extNombres		     Out	Out_extNombres_arr	      /*  Nombres Carga */
    , Out_extCodEstBen		     Out	Out_extCodEstBen_arr	   /*  Codigo de estado Carga */
    , Out_extDescEstado 	     Out	Out_extDescEstado_arr	   /*  Descripcion estado Carga  */
    ) ;

	Procedure CHULeeRutCotiz  /*  Beneficiarios asociados al Titular, Fundacion  */
     ( SRV_Message		      In Out	 Varchar2,
      In_extCodFinanciador		  In	     Varchar2			     /*  Codigo de Isapre Fundacion 076 */
    , In_extRutCotizante	     In 	Varchar2			/*  Rut del beneficiario (Certificacion)  */
    , Out_extNomCotizante	      Out	 Varchar2			 /*  Nombre Completo */
    , Out_extCodError		      Out	 Varchar2			 /*  S o N  */
    , Out_extMensajeError	      Out	 Varchar2			 /*  Descripcion del Error */
    , Out_extCorrBenef		       Out	  Out_extCorrBenef_arr	     /*  Correlativo */
    , Out_extRutBeneficiario	     Out	Out_extRutBeneficiario_arr /*  Rut Carga */
    , Out_extApellidoPat	     Out	Out_extApellidoPat_arr	   /*  Ap Pat Carga */
    , Out_extApellidoMat	     Out	Out_extApellidoMat_arr	   /*  Ap Mat Carga */
    , Out_extNombres		     Out	Out_extNombres_arr	      /*  Nombres Carga */
    , Out_extCodEstBen		     Out	Out_extCodEstBen_arr	   /*  Codigo de estado Carga */
    , Out_extDescEstado 	     Out	Out_extDescEstado_arr	   /*  Descripcion estado Carga  */
    ) ;

	end FUSLeeRutCotiz_pkg;

80 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     FUSLeeRutCotiz_Pkg As    /*  Beneficiarios asociados al Titular, Fundacion  */

PROCEDURE FUSLeeRutCotiz /*  Beneficiarios asociados al Titular, Fundacion  */
  (SRV_Message		  In Out     Varchar2,
   In_extCodFinanciador   In Varchar2 /*  Codigo de Isapre Fundacion 076 */,
   In_extRutCotizante	  In Varchar2 /*  Rut del beneficiario (Certificacion)	*/,
   Out_extNomCotizante	  Out Varchar2 /*  Nombre Completo */,
   Out_extCodError	  Out Varchar2 /*  S o N  */,
   Out_extMensajeError	  Out Varchar2 /*  Descripcion del Error */,
   Out_extCorrBenef	  Out Out_extCorrBenef_arr /*  Correlativo */,
   Out_extRutBeneficiario Out Out_extRutBeneficiario_arr /*  Rut Carga */,
   Out_extApellidoPat	  Out Out_extApellidoPat_arr /*  Ap Pat Carga */,
   Out_extApellidoMat	  Out Out_extApellidoMat_arr /*  Ap Mat Carga */,
   Out_extNombres	  Out Out_extNombres_arr /*  Nombres Carga */,
   Out_extCodEstBen	  Out Out_extCodEstBen_arr /*  Codigo de estado Carga */,
   Out_extDescEstado	  Out Out_extDescEstado_arr /*	Descripcion estado Carga  */) As

    RUT_AUX    VARCHAR2(10);
    CORR2      NUMBER(3);
    ID_AFI2    NUMBER(10);
    INDICE     NUMBER := 1;
    NOM_AUX    VARCHAR2(20);
    AP_PAT_AUX VARCHAR2(15);
    AP_MAT_AUX VARCHAR2(15);

    vFechaActual date;
    vEstado	 varchar2(10);
    vIdAfi	 number;
    vCorr	 number;
    vRutCot	 number;
    vDVCot	 varchar2(1);
    vRutBen	 number;
    vDVBen	 varchar2(1);
    vCodPlan	 varchar2(10);
    vCodError	 varchar2(10);
    vError	 varchar2(100);

    --Buscar el ID_AFI
    CURSOR C_CARGAS(ID_AFI_C VARCHAR2) IS
      SELECT ID_AFI,
	     CORR,
	     RUT_CAR,
	     DV_CAR,
	     AP_PAT_CAR,
	     AP_MAT_CAR,
	     NOM_CAR,
	     DECODE(ADMIMED.vig_carga(id_afi, corr, sysdate), 'V', 'C', 'X') estado,
	     DECODE(ADMIMED.vig_carga(id_afi, corr, sysdate),
		    'V',
		    'Certificado',
		    'No Vigente') DESC_ESTADO
	FROM admafil.af_CARGAS
       WHERE ID_AFI = ID_AFI_C;

  BEGIN
  SRV_Message := '1000000';
    Out_extCodError := 'S';
    Out_extMensajeError := ' ';

    --RUT_AUX:=substr((replace(In_extRutCotizante,'-','')),1,length((replace(In_extRutCotizante,'-',''))) - 1);

    -- Valido codigo financiador
    IF In_extCodFinanciador not In (62,63,65,68) then
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'Codigo Financiador Erroneo';
      Return;
    END IF;

    --ID_AFI2:=ADMAFIL.F_ID_AFI_VIGENTE(RUT_AUX,SYSDATE);

    ADMIMED.SeparaRut(In_extRutCotizante, vRutCot, vDVCot, vError);
    if vError is not null then
      Out_extCodError	  := 'N';
      Out_extMensajeError := SUBSTR(vError,1,30);
      Return;
    end if;

    ADMIMED.ValidoBeneficiario2(In_extRutCotizante,
				trunc(sysdate),
				vEstado,
				vIdAfi,
				vCorr,
				vRutCot,
				vDVCot,
				vRutBen,
				vDVBen,
				vCodPlan,
				vCodError,
				vError);

    if vError is not null then
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'Error RUT';
      return;
    end if;

    if vEstado = 'D' then
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'Cot. NO Vigente';
      return;
    elsif vEstado = 'NE' then
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'RUT no pertenece a cotizante';
      return;
    end if;

    --	ID_AFI2:=ADMAFIL.F_ID_AFI_VIGENTE(vRutCot,SYSDATE);

    --IF NVL(ID_AFI2, 0) = 0 THEN
    -- Out_extCodError:='S';
    -- Out_extMensajeError:='Afiliado NO EXISTE';
    --ELSIF ID_AFI2<0 THEN
    -- Out_extCodError:='S';
    -- Out_extMensajeError:='ERROR EN AFILIADO,SQLCODE: '||ID_AFI2;

    --ELSE
    BEGIN
      SELECT NOM_AFI || ' ' || AP_PAT_AFI || ' ' || AP_MAT_AFI
	INTO Out_extNomCotizante
	FROM ADMAFIL.AF_AFILIADOS
       WHERE ID_AFI = vIdAfi;

      for r_CARGAS in C_CARGAS(vIdAfi) LOOP
	Out_extCorrBenef(indice) := r_CARGAS.CORR;
	Out_extRutBeneficiario(indice) := r_CARGAS.RUT_CAR || '-' ||
					  r_CARGAS.DV_CAR;
	Out_extApellidoPat(indice) := r_CARGAS.AP_PAT_CAR;
	Out_extApellidoMat(indice) := r_CARGAS.AP_MAT_CAR;
	Out_extNombres(indice) := r_CARGAS.NOM_CAR;
	Out_extCodEstBen(indice) := r_CARGAS.ESTADO;
	Out_extDescEstado(indice) := r_CARGAS.DESC_ESTADO;
	indice := indice + 1;
      end loop;
      Out_extCodError	  := 'S';
      Out_extMensajeError := ' ';

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Afiliado NO EXISTE';
      WHEN OTHERS THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := SUBSTR(sqlerrm,1,30);
    END;
    --END IF;

  END FUSLeeRutCotiz;

  PROCEDURE SNLLeeRutCotiz /*  Beneficiarios asociados al Titular, Fundacion  */
  (SRV_Message		  In Out     Varchar2,
   In_extCodFinanciador   In Varchar2 /*  Codigo de Isapre Fundacion 076 */,
   In_extRutCotizante	  In Varchar2 /*  Rut del beneficiario (Certificacion)	*/,
   Out_extNomCotizante	  Out Varchar2 /*  Nombre Completo */,
   Out_extCodError	  Out Varchar2 /*  S o N  */,
   Out_extMensajeError	  Out Varchar2 /*  Descripcion del Error */,
   Out_extCorrBenef	  Out Out_extCorrBenef_arr /*  Correlativo */,
   Out_extRutBeneficiario Out Out_extRutBeneficiario_arr /*  Rut Carga */,
   Out_extApellidoPat	  Out Out_extApellidoPat_arr /*  Ap Pat Carga */,
   Out_extApellidoMat	  Out Out_extApellidoMat_arr /*  Ap Mat Carga */,
   Out_extNombres	  Out Out_extNombres_arr /*  Nombres Carga */,
   Out_extCodEstBen	  Out Out_extCodEstBen_arr /*  Codigo de estado Carga */,
   Out_extDescEstado	  Out Out_extDescEstado_arr /*	Descripcion estado Carga  */) As

  BEGIN
	FUSLeeRutCotiz	  (SRV_Message,
			   In_extCodFinanciador,
			   In_extRutCotizante,
			   Out_extNomCotizante,
			   Out_extCodError,
			   Out_extMensajeError,
			   Out_extCorrBenef,
			   Out_extRutBeneficiario,
			   Out_extApellidoPat,
			   Out_extApellidoMat,
			   Out_extNombres,
			   Out_extCodEstBen,
			   Out_extDescEstado);
  END SNLLeeRutCotiz;

  PROCEDURE RBLLeeRutCotiz /*  Beneficiarios asociados al Titular, Fundacion  */
  (SRV_Message		  In Out     Varchar2,
   In_extCodFinanciador   In Varchar2 /*  Codigo de Isapre Fundacion 076 */,
   In_extRutCotizante	  In Varchar2 /*  Rut del beneficiario (Certificacion)	*/,
   Out_extNomCotizante	  Out Varchar2 /*  Nombre Completo */,
   Out_extCodError	  Out Varchar2 /*  S o N  */,
   Out_extMensajeError	  Out Varchar2 /*  Descripcion del Error */,
   Out_extCorrBenef	  Out Out_extCorrBenef_arr /*  Correlativo */,
   Out_extRutBeneficiario Out Out_extRutBeneficiario_arr /*  Rut Carga */,
   Out_extApellidoPat	  Out Out_extApellidoPat_arr /*  Ap Pat Carga */,
   Out_extApellidoMat	  Out Out_extApellidoMat_arr /*  Ap Mat Carga */,
   Out_extNombres	  Out Out_extNombres_arr /*  Nombres Carga */,
   Out_extCodEstBen	  Out Out_extCodEstBen_arr /*  Codigo de estado Carga */,
   Out_extDescEstado	  Out Out_extDescEstado_arr /*	Descripcion estado Carga  */) As

  BEGIN
	FUSLeeRutCotiz	  (SRV_Message,
			   In_extCodFinanciador,
			   In_extRutCotizante,
			   Out_extNomCotizante,
			   Out_extCodError,
			   Out_extMensajeError,
			   Out_extCorrBenef,
			   Out_extRutBeneficiario,
			   Out_extApellidoPat,
			   Out_extApellidoMat,
			   Out_extNombres,
			   Out_extCodEstBen,
			   Out_extDescEstado);
  END RBLLeeRutCotiz;


  PROCEDURE CHULeeRutCotiz /*  Beneficiarios asociados al Titular, Fundacion  */
  (SRV_Message		  In Out     Varchar2,
   In_extCodFinanciador   In Varchar2 /*  Codigo de Isapre Fundacion 076 */,
   In_extRutCotizante	  In Varchar2 /*  Rut del beneficiario (Certificacion)	*/,
   Out_extNomCotizante	  Out Varchar2 /*  Nombre Completo */,
   Out_extCodError	  Out Varchar2 /*  S o N  */,
   Out_extMensajeError	  Out Varchar2 /*  Descripcion del Error */,
   Out_extCorrBenef	  Out Out_extCorrBenef_arr /*  Correlativo */,
   Out_extRutBeneficiario Out Out_extRutBeneficiario_arr /*  Rut Carga */,
   Out_extApellidoPat	  Out Out_extApellidoPat_arr /*  Ap Pat Carga */,
   Out_extApellidoMat	  Out Out_extApellidoMat_arr /*  Ap Mat Carga */,
   Out_extNombres	  Out Out_extNombres_arr /*  Nombres Carga */,
   Out_extCodEstBen	  Out Out_extCodEstBen_arr /*  Codigo de estado Carga */,
   Out_extDescEstado	  Out Out_extDescEstado_arr /*	Descripcion estado Carga  */) As

  BEGIN
	FUSLeeRutCotiz	  (SRV_Message,
			   In_extCodFinanciador,
			   In_extRutCotizante,
			   Out_extNomCotizante,
			   Out_extCodError,
			   Out_extMensajeError,
			   Out_extCorrBenef,
			   Out_extRutBeneficiario,
			   Out_extApellidoPat,
			   Out_extApellidoMat,
			   Out_extNombres,
			   Out_extCodEstBen,
			   Out_extDescEstado);
  END CHULeeRutCotiz;

  END FUSLeeRutCotiz_pkg;

243 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.5.0 - 64bit Production
