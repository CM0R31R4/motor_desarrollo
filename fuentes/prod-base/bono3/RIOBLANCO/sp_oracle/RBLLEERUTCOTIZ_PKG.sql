
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 26 18:07:41 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.4.0 - Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package RBLLeeRutCotiz_Pkg As
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
		Procedure RBLLeeRutCotiz  /*  Beneficiarios asociados al Titular, Fundacion  */
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

	end RBLLeeRutCotiz_pkg;

32 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package Body	     RBLLeeRutCotiz_Pkg As
  /*  Beneficiarios asociados al Titular, Fundacion  */

  PROCEDURE RBLLeeRutCotiz /*  Beneficiarios asociados al Titular, Fundacion  */
  (SRV_Message		  In Out Varchar2,
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
    SRV_Message 	:= '1000000';
    Out_extCodError	:= 'S';
    Out_extMensajeError := ' ';

    --RUT_AUX:=substr((replace(In_extRutCotizante,'-','')),1,length((replace(In_extRutCotizante,'-',''))) - 1);

    -- Valido codigo financiador
    IF In_extCodFinanciador <> 68 then
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'Codigo Financiador Erroneo';
      Return;
    END IF;

    --ID_AFI2:=ADMAFIL.F_ID_AFI_VIGENTE(RUT_AUX,SYSDATE);

    ADMIMED.SeparaRut(In_extRutCotizante, vRutCot, vDVCot, vError);
    if vError is not null then
      Out_extCodError	  := 'N';
      Out_extMensajeError := SUBSTR(vError, 1, 30);
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
	Out_extMensajeError := SUBSTR(sqlerrm, 1, 30);
    END;
    --END IF;

  END RBLLeeRutCotiz;
END RBLLeeRutCotiz_pkg;



151 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.4.0 - Production
