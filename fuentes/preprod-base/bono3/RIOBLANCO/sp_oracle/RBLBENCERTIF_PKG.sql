
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 26 18:07:40 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.4.0 - Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package RBLBenCertif_Pkg As
------------------------------------------------------------
  TYPE extRutAcompanante_arr IS TABLE OF Varchar2(12)
    INDEX BY BINARY_INTEGER;
  TYPE extNombreAcompanante_arr IS TABLE OF Varchar2(40)
    INDEX BY BINARY_INTEGER;

Procedure RBLBenCertif
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador	     In 	Number
    , In_extRutBeneficiario	     In 	Varchar2
    , In_extFechaActual 	     In 	Varchar2
    , Out_extApellidoPat	     Out	Varchar2
    , Out_extApellidoMat	     Out	Varchar2
    , Out_extNombres		     Out	Varchar2
    , Out_extSexo		     Out	Varchar2
    , Out_extFechaNacimi	     Out	Varchar2
    , Out_extCodEstBen		     Out	Varchar2
    , Out_extDescEstado 	     Out	Varchar2
    , Out_extRutCotizante	     Out	Varchar2
    , Out_extNomCotizante	     Out	Varchar2
    , Out_extDirPaciente	     Out	Varchar2
    , Out_extGlosaComuna	     Out	Varchar2
    , Out_extGlosaCiudad	     Out	Varchar2
    , Out_extPrevision		     Out	Varchar2
    , Out_extGlosa		     Out	Varchar2
    , Out_extPlan		     Out	Varchar2
    , Out_extDescuentoxPlanilla      Out	Varchar2
    , Out_extMontoExcedente	     Out	Number
    , Col_extRutAcompanante	     Out	extRutAcompanante_arr
    , Col_extNombreAcompanante	     Out	extNombreAcompanante_arr
    );
	
	
	End RBLBenCertif_Pkg;

35 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package Body	     RBLBenCertif_Pkg As

  Procedure RBLBenCertif(SRV_Message		   In Out Varchar2,
			 In_extCodFinanciador	   In Number,
			 In_extRutBeneficiario	   In Varchar2,
			 In_extFechaActual	   In Varchar2,
			 Out_extApellidoPat	   Out Varchar2,
			 Out_extApellidoMat	   Out Varchar2,
			 Out_extNombres 	   Out Varchar2,
			 Out_extSexo		   Out Varchar2,
			 Out_extFechaNacimi	   Out Varchar2,
			 Out_extCodEstBen	   Out Varchar2,
			 Out_extDescEstado	   Out Varchar2,
			 Out_extRutCotizante	   Out Varchar2,
			 Out_extNomCotizante	   Out Varchar2,
			 Out_extDirPaciente	   Out Varchar2,
			 Out_extGlosaComuna	   Out Varchar2,
			 Out_extGlosaCiudad	   Out Varchar2,
			 Out_extPrevision	   Out Varchar2,
			 Out_extGlosa		   Out Varchar2,
			 Out_extPlan		   Out Varchar2,
			 Out_extDescuentoxPlanilla Out Varchar2,
			 Out_extMontoExcedente	   Out Number,
			 Col_extRutAcompanante	   Out extRutAcompanante_arr,
			 Col_extNombreAcompanante  Out extNombreAcompanante_arr) As

    SRV_FetchStatus Number(1);

    SRV_TotalRows Number(8);
    SRV_RowCount  Number(8);

    CORR2	NUMBER;
    ID_AFI2	NUMBER;
    COD_COM_AUX NUMBER;
    ESTADO_AUX	VARCHAR2(2);
    NOM_AUX	VARCHAR2(20);
    PAT_AUX	VARCHAR2(15);
    MAT_AUX	VARCHAR2(15);
    ID_AUX	NUMBER;
    FLAG_AUX	VARCHAR2(300);
    RUT_AUX	VARCHAR2(10);
    dv_afi_aux	VARCHAR2(1);
    indice	NUMBER := 1;

    oRutBen number;
    oDVBen  varchar2(1);

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
    nom_aco_aux varchar2(100);
    CURSOR ACOMPANA(ID_AFI_C VARCHAR2) IS

      SELECT RUT_ACO, DV_ACO, NOM_ACO, AP_PAT_ACO, AP_MAT_ACO
	FROM ACOMPANANTE
       WHERE ID_AFI = ID_AFI_C
	 AND ESTADO like '%B'
	 and admafil.f_calcula_edad_diferida(fec_nac, sysdate) >= 18;

  BEGIN

    --Valores por defecto
    SRV_TotalRows   := TO_Number(rTrim(SRV_Message));
    SRV_RowCount    := 0;
    SRV_FetchStatus := 0;
    SRV_Message     := '1000000';

    Out_extApellidoPat	      := ' ';
    Out_extApellidoMat	      := ' ';
    Out_extNombres	      := ' ';
    Out_extSexo 	      := ' ';
    Out_extFechaNacimi	      := '1900/01/01';
    Out_extCodEstBen	      := ' ';
    Out_extDescEstado	      := ' ';
    Out_extRutCotizante       := ' ';
    Out_extNomCotizante       := ' ';
    Out_extDirPaciente	      := ' ';
    Out_extGlosaComuna	      := ' ';
    Out_extGlosaCiudad	      := ' ';
    Out_extPrevision	      := ' ';
    Out_extGlosa	      := ' ';
    Out_extPlan 	      := ' ';
    Out_extDescuentoxPlanilla := ' ';
    Out_extMontoExcedente     := 0;

    -- Valido codigo financiador
    if In_extCodFinanciador <> 68 then
      Out_extCodEstBen	:= 'X';
      Out_extDescEstado := 'Error Parametro';
      Out_extGlosa	:= 'Codigo Financiador Erroneo';
      Return;
    end if;

    ADMIMED.SeparaRut(In_extRutBeneficiario, oRutBen, oDVBen, vError);

    if vError is not null then
      Out_extCodEstBen	:= 'X';
      Out_extDescEstado := 'Error RUT';
      Out_extGlosa	:= 'Error en Rut Beneficiario';
      return;
    end if;

    --vFechaActual :=In_extFechaActual;
    vFechaActual := sysdate;

    ADMIMED.ValidoBeneficiario2(In_extRutBeneficiario,
				vFechaActual,
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
      Out_extCodEstBen	:= 'X';
      Out_extDescEstado := 'Error RUT';
      Out_extGlosa	:= vError;
      return;
    end if;

    if vEstado = 'D' then
      Out_extCodEstBen	:= 'X';
      Out_extDescEstado := 'Benef NO Vig.';
      Out_extGlosa	:= 'Beneficiario NO Vigente en Isapre';
      return;
    elsif vEstado = 'NE' then
      Out_extCodEstBen	:= 'X';
      Out_extDescEstado := 'RUT No existe';
      Out_extGlosa	:= 'RUT no es beneficiario de Isapre';
      return;
    elsif vEstado = 'A' then
      Out_extCodEstBen	:= 'C';
      Out_extDescEstado := 'Certificado';
      Out_extGlosa	:= 'Beneficiario Certificado';
    end if;

    ADMBENE.ben_recupera_plan_vigente(vIdAfi,
				      Out_extPlan,
				      vFechaActual,
				      FLAG_AUX); --Recupera codigo del Plan

    Out_extPrevision := ADMAFIL.AF_AFI_TIP_TRAB(vIdAfi,
						vFechaActual,
						ID_AUX,
						FLAG_AUX); --Recupera tipo de Trabajador

    if NOT admbene.ben_f_posee_excedente(vIdAfi,
					 Out_extMontoExcedente,
					 FLAG_AUX) then
      Out_extMontoExcedente := 0;
    end if;

    --Out_extMontoExcedente:=admcotiz.f_exce_afi(vIdAfi,vFechaActual,FLAG_AUX);--Recupera el excedente

    IF vCorr > 0 then
      --Cargas
      SELECT C.NOM_CAR,
	     C.AP_PAT_CAR,
	     C.AP_MAT_CAR,
	     C.FEC_NAC_CAR,
	     C.SEXO_CAR,
	     C.EST_CAR,
	     A.COD_COM,
	     A.CIUDAD,
	     A.DIRECC_AFI,
	     trim(to_char(A.RUT_AFI, '0000000000') || '-' || A.DV_AFI),
	     --trim(to_char(A.RUT_AFI)||'-'||to_char(A.DV_AFI)),
	     A.NOM_AFI,
	     A.AP_PAT_AFI,
	     A.AP_MAT_AFI
	INTO Out_extNombres,
	     Out_extApellidoPat,
	     Out_extApellidoMat,
	     Out_extFechaNacimi,
	     Out_extSexo,
	     ESTADO_AUX,
	     COD_COM_AUX,
	     Out_extGlosaCiudad,
	     Out_extDirPaciente,
	     Out_extRutCotizante,
	     NOM_AUX,
	     PAT_AUX,
	     MAT_AUX
	FROM ADMAFIL.AF_CARGAS C, ADMAFIL.AF_AFILIADOS A
       WHERE C.ID_AFI = vIdAfi
	 AND C.CORR = vCorr
	 AND A.ID_AFI = C.ID_AFI;

      Out_extNomCotizante := RTRIM(NOM_AUX) || ' ' || RTRIM(PAT_AUX) || ' ' ||
			     RTRIM(MAT_AUX);

      --if admafil.f_calcula_edad_diferida(Out_extFechaNacimi,In_extFechaActual)<18 then
      if admafil.f_calcula_edad_diferida(Out_extFechaNacimi, sysdate) < 18 then

	for r_acompana in ACOMPANA(vIdAfi) LOOP
	  Col_extRutAcompanante(indice) := trim(to_char(r_acompana.RUT_ACO,
							'0000000000') || '-' ||
						r_acompana.DV_ACO);

	  nom_aco_aux:=    r_acompana.NOM_ACO || ' ' ||
					      r_acompana.AP_PAT_ACO || ' ' ||
					      r_acompana.AP_MAT_ACO;

	  Col_extNombreAcompanante(indice) :=substr(nom_aco_aux,1,40);
	  indice := indice + 1;
	end loop;
      end if;

    ELSE
      SELECT --Afiliados
       A.NOM_AFI,
       A.AP_PAT_AFI,
       A.AP_MAT_AFI,
       A.FEC_NAC,
       --	 TO_char(A.FEC_NAC,'YYYYMMDD'),
       A.SEXO,
       A.COD_COM,
       A.CIUDAD,
       A.DIRECC_AFI,
       A.EST_AFI
	INTO Out_extNombres,
	     Out_extApellidoPat,
	     Out_extApellidoMat,
	     Out_extFechaNacimi,
	     Out_extSexo,
	     COD_COM_AUX,
	     Out_extGlosaCiudad,
	     Out_extDirPaciente,
	     ESTADO_AUX
	FROM ADMAFIL.AF_AFILIADOS A
      --WHERE A.ID_AFI=id_afi2; REL
       WHERE A.ID_AFI = vIdAfi;
      Out_extRutCotizante := In_extRutBeneficiario;
      Out_extNomCotizante := RTRIM(Out_extNombres) || ' ' ||
			     RTRIM(Out_extApellidoPat) || ' ' ||
			     RTRIM(Out_extApellidoMat);

    END IF;

    Out_extDescuentoxPlanilla := 'N'; --Descuento por planilla es NO (fijo).

    --Recupera Descripcion y Glosa del Estado del Beneficiario(Certificado, desahuciado, activo sin beneficios,etc)
    BEGIN
      SELECT DESCR, GLOSA
	INTO Out_extDescEstado, Out_extGlosa
	FROM ESTADOS_IMED
       WHERE CODIGO = Out_extCodEstBen;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
	Out_extDescEstado := ' ';
	Out_extGlosa	  := ' ';

    END;

    --Recupera la descripcion de la Comuna.
    BEGIN
      SELECT DES_COM
	INTO Out_extGlosaComuna
	FROM ADMGLOB.GL_COMUNAS
       WHERE COD_COM = COD_COM_AUX;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
	Out_extGlosaComuna := 'Sin Comuna';
    END;
    dbms_output.put_line('rut cotizante :' || Out_extRutCotizante);
    dbms_output.put_line('largo rut cotizante :' ||
			 length(Out_extRutCotizante));
  End RBLBenCertif;

End RBLBenCertif_Pkg;

283 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.4.0 - Production
