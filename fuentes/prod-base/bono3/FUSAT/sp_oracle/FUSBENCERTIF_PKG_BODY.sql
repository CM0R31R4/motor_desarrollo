
SQL*Plus: Release 11.2.0.3.0 Production on Tue Aug 4 11:30:20 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.5.0 - 64bit Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     FUSBenCertif_Pkg As

Procedure FUSBenCertif
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
    ) As

    SRV_FetchStatus Number(1);

    SRV_TotalRows   Number(8);
    SRV_RowCount    Number(8);

CORR2	    NUMBER;
ID_AFI2     NUMBER;
COD_COM_AUX NUMBER;
ESTADO_AUX  VARCHAR2(2);
NOM_AUX     VARCHAR2(20);
PAT_AUX     VARCHAR2(15);
MAT_AUX     VARCHAR2(15);
ID_AUX	    NUMBER;
FLAG_AUX    VARCHAR2(300);
RUT_AUX     VARCHAR2(10);
dv_afi_aux  VARCHAR2(1);
indice	    NUMBER:=1;

oRutBen		number;
oDVBen		varchar2(1);

vFechaActual		date;
vEstado				varchar2(10);
vIdAfi				number;
vCorr				number;
vRutCot				number;
vDVCot				varchar2(1);
vRutBen				number;
vDVBen				varchar2(1);
vCodPlan			varchar2(10);
vCodError			varchar2(10);
vError				varchar2(100);

      -------------------------------------------------------------------------
      --Variables para Setear la Salida
      -------------------------------------------------------------------------
      vv_SEPARADOR	      VARCHAR2(1):=';';
      vv_PARAMETROS_SALIDA    VARCHAR2(4000);

      -------------------------------------------------------------------------
      --Variables Auxiliares
      -------------------------------------------------------------------------
      v_nIMED_AUDI_SEQ	      NUMBER(10);
      v_vPARAMETROS_ENTRADA   VARCHAR2(4000);
      v_vPRE		      VARCHAR2(10);

      E_salir		      EXCEPTION;
      v_sep_ES		      VARCHAR2(1):=';';

CURSOR ACOMPANA(ID_AFI_C VARCHAR2) IS

SELECT	 RUT_ACO,DV_ACO,NOM_ACO,AP_PAT_ACO,AP_MAT_ACO
FROM ACOMPANANTE WHERE ID_AFI=ID_AFI_C	AND ESTADO like'%B'
and f_calcula_edad_diferida(fec_nac,sysdate)>=18;


FUNCTION F_SETEA_SALIDA
RETURN VARCHAR2
IS
v_vSalida	VARCHAR2(2000);
BEGIN
v_vSalida:= SUBSTR(SRV_Message||v_sep_ES||
	    Out_extApellidoPat||v_sep_ES||
	    Out_extApellidoMat||v_sep_ES||
	    Out_extNombres||v_sep_ES||
	    Out_extSexo||v_sep_ES||
	    Out_extFechaNacimi||v_sep_ES||
	    Out_extCodEstBen||v_sep_ES||
	    Out_extDescEstado||v_sep_ES||
	    Out_extRutCotizante||v_sep_ES||
	    Out_extNomCotizante||v_sep_ES||
	    Out_extDirPaciente||v_sep_ES||
	    Out_extGlosaComuna||v_sep_ES||
	    Out_extGlosaCiudad||v_sep_ES||
	    Out_extPrevision||v_sep_ES||
	    Out_extGlosa||v_sep_ES||
	    Out_extPlan||v_sep_ES||
	    Out_extDescuentoxPlanilla||v_sep_ES||
	    Out_extMontoExcedente||v_sep_ES,1,2000);
FOR i IN 1 ..Col_ExtRutAcompanante.COUNT LOOP
v_vSalida := v_vSalida ||Col_ExtRutAcompanante(i)||v_sep_ES;
END LOOP;
FOR i IN 1 ..Col_ExtNombreAcompanante.COUNT LOOP
v_vSalida := v_vSalida || Col_ExtNombreAcompanante(i)||v_sep_ES;
END LOOP;
RETURN v_vSalida;
END;

BEGIN

/*Valores por defecto*/
    SRV_TotalRows := TO_Number(rTrim(SRV_Message));
    SRV_RowCount := 0;
    SRV_FetchStatus := 0;
    SRV_Message := '1000000';

    Out_extApellidoPat := ' ';
    Out_extApellidoMat := ' ';
    Out_extNombres := ' ';
    Out_extSexo := ' ';
    Out_extFechaNacimi := '1900/01/01';
    Out_extCodEstBen := ' ';
    Out_extDescEstado := ' ';
    Out_extRutCotizante := ' ';
    Out_extNomCotizante := ' ';
    Out_extDirPaciente := ' ';
    Out_extGlosaComuna := ' ';
    Out_extGlosaCiudad := ' ';
    Out_extPrevision := ' ';
    Out_extGlosa := ' ';
    Out_extPlan := ' ';
    Out_extDescuentoxPlanilla := ' ';
    Out_extMontoExcedente := 0;


    ----------------------------------------------------------------------
    -- Graba Auditoria de Transaccion
    ----------------------------------------------------------------------
    ----DBMS_OUTPUT.PUT_LINE ( ' Antes de Armar varioable de Entrada' );
    v_vPARAMETROS_ENTRADA := Null;
    v_vPARAMETROS_ENTRADA := SRV_Message||';'||
			    In_extCodFinanciador||';'||
			    In_extRutBeneficiario||';'||
			    In_extFechaActual||';';

    If in_extcodfinanciador = 65 Then
      v_vPRE := 'CHU';
    elsIf in_extcodfinanciador = 63 Then
      v_vPRE := 'FUS';
    elsIf in_extcodfinanciador = 62 Then
      v_vPRE := 'SNL';
    elsIf in_extcodfinanciador = 68 Then
      v_vPRE := 'RBL';
    End if;

    ----DBMS_OUTPUT.PUT_LINE ( ' Antes de Grabar la Auditoria' );
    Begin
	Select ADMIMED.IMED_AUDI_SEQ.NextVAl
	Into v_nIMED_AUDI_SEQ
	From Dual;

	Insert Into ADMIMED.IMED_AUDITORIA
	(CORRELATIVO, ID_ISAPRE, NOMBRE_TRANSACCION, FECHA_TRANSACCION, NUMERO_CONVENIO, LUGAR_CONVENIO, SUC_VENTA, RUT_TRATANTE, RUT_BENEF, RUT_COTIZ, ID_AFI, CODIGO_CARGA, NRO_BONO_ISAPRE, MONTO_TOTAL_BONO, PREST_TOTALES_BONO, MONTO_ISAPRE_BONO, MONTO_COPAGO_BONO, DATOS_ENTRADA, DATOS_SALIDA, FEC_HOR_LLEGADA, FEC_HOR_SALIDA, SEGUNDOS_RESP)
	Values
	(v_nIMED_AUDI_SEQ,in_extcodfinanciador,v_vPRE||'BENCERTIF_PKG',sysdate,null,null,null,Null,Null,null,null,null,null,null,null,null,null,v_vPARAMETROS_ENTRADA,null,Sysdate,Null,Null)
	;
    Exception
    When Others Then
      Null;
    End;
    COMMIT;

/* Valido codigo financiador*/
if In_extCodFinanciador not in (62,63,65,68) then
    Out_extCodEstBen:='X';
	Out_extDescEstado:='Error Parametro';
	Out_extGlosa:='Codigo Financiador Erroneo';
    RAISE E_salir;
end if;

ADMIMED.SeparaRut(In_extRutBeneficiario, oRutBen,oDVBen,vError);

if vError is not null then
 Out_extCodEstBen := 'X';
 Out_extDescEstado:='Error RUT';
 Out_extGlosa:='Error en Rut Beneficiario';
 RAISE E_salir;
end if;


vFechaActual :=In_extFechaActual;
/*vFechaActual :=sysdate;*/


ADMIMED.ValidoBeneficiario2(
 		In_extRutBeneficiario,
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
 Out_extCodEstBen := 'X';
 Out_extDescEstado:='Error RUT';
 Out_extGlosa:=vError;
 RAISE E_salir;
end if;

if vEstado='D' then
 Out_extCodEstBen := 'X';
 Out_extDescEstado:='Benef NO Vig.';
 Out_extGlosa:='Beneficiario NO Vigente en Isapre';
 RAISE E_salir;
elsif vEstado='NE' then

 Out_extCodEstBen := 'R';
 Out_extDescEstado:='Rechazado';
 Out_extGlosa:='Rechazado, no es beneficiario de Isapre';
/* Out_extCodEstBen := 'X';  ASR 23-08-06   */
/*Out_extDescEstado:='RUT No existe';ASR 23-08-06*/
/*Out_extGlosa:='RUT no es beneficiario de Isapre';  ASR 23-08-06   */
 RAISE E_salir;
elsif vEstado='A' then
 Out_extCodEstBen := 'C';
 Out_extDescEstado:='Certificado';
 Out_extGlosa:='Beneficiario Certificado';
end if;

ADMBENE.ben_recupera_plan_vigente(vIdAfi,Out_extPlan,vFechaActual,FLAG_AUX);/*Recupera codigo del Plan*/

Out_extPrevision:=ADMAFIL.AF_AFI_TIP_TRAB(vIdAfi,vFechaActual,ID_AUX,FLAG_AUX); /*Recupera tipo de Trabajador*/

if NOT admbene.ben_f_posee_excedente(vIdAfi,Out_extMontoExcedente,FLAG_AUX)  then
Out_extMontoExcedente:=0;
end if;

/*Out_extMontoExcedente:=admcotiz.f_exce_afi(vIdAfi,vFechaActual,FLAG_AUX);--Recupera el excedente*/



    IF vCorr >0 then /*Cargas*/
	SELECT
	C.NOM_CAR,
	C.AP_PAT_CAR,
	C.AP_MAT_CAR,
	C.FEC_NAC_CAR,
	C.SEXO_CAR,
	C.EST_CAR,
	A.COD_COM,
	A.CIUDAD,
	substr(A.DIRECC_AFI,1,40),
       trim(to_char(A.RUT_AFI,'0000000000')||'-'||A.DV_AFI),
		/*trim(to_char(A.RUT_AFI)||'-'||to_char(A.DV_AFI)),*/
	substr(A.NOM_AFI,1,20),
	substr(A.AP_PAT_AFI,1,15),
	substr(A.AP_MAT_AFI,1,15)
	INTO  Out_extNombres,Out_extApellidoPat,Out_extApellidoMat,Out_extFechaNacimi,Out_extSexo,ESTADO_AUX,
	      COD_COM_AUX,Out_extGlosaCiudad,Out_extDirPaciente,Out_extRutCotizante,NOM_AUX,PAT_AUX,MAT_AUX
	FROM  ADMAFIL.AF_CARGAS C, ADMAFIL.AF_AFILIADOS A
	WHERE C.ID_AFI=vIdAfi AND C.CORR = vCorr AND A.ID_AFI= C.ID_AFI;
		
	Out_extNomCotizante:=substr(TRIM(NOM_AUX)||' '||TRIM(PAT_AUX)||' '||TRIM(MAT_AUX),1,40);
		
		if admafil.f_calcula_edad_diferida(Out_extFechaNacimi,In_extFechaActual)<18 then
		/*if f_calcula_edad_diferida(Out_extFechaNacimi,sysdate)<18 then*/


		   for r_acompana in ACOMPANA(vIdAfi) LOOP
		    Col_extRutAcompanante(indice):=trim(to_char(r_acompana.RUT_ACO,'0000000000')||'-'||r_acompana.DV_ACO);
		    Col_extNombreAcompanante(indice):=substr(r_acompana.NOM_ACO,1,14)||' '||substr(r_acompana.AP_PAT_ACO,1,12)||' '||substr(r_acompana.AP_MAT_ACO,1,12);
			/*dbms_output.put_line('rut aco    :' || Col_extRutAcompanante(indice));
		dbms_output.put_line('nombre aco :' || Col_extNombreAcompanante(indice));*/
		indice:=indice+1;
		   end loop;
	    end if;


    ELSE
       SELECT /*Afiliados*/
	A.NOM_AFI,
	A.AP_PAT_AFI,
	A.AP_MAT_AFI,
	A.FEC_NAC,
	A.SEXO,
	A.COD_COM,
	A.CIUDAD,
	substr(A.DIRECC_AFI,1,40),
	A.EST_AFI
	INTO Out_extNombres,Out_extApellidoPat,Out_extApellidoMat,Out_extFechaNacimi,Out_extSexo,
	     COD_COM_AUX,Out_extGlosaCiudad,Out_extDirPaciente,ESTADO_AUX
	FROM ADMAFIL.AF_AFILIADOS A
	/*WHERE A.ID_AFI=id_afi2; REL*/
		WHERE A.ID_AFI=vIdAfi;
	Out_extRutCotizante:=In_extRutBeneficiario;
	Out_extNomCotizante:=substr((RTRIM(Out_extNombres)||' '||RTRIM(Out_extApellidoPat)||' '||RTRIM(Out_extApellidoMat)),1,40);

    END IF;


    Out_extDescuentoxPlanilla:='N';/*Descuento por planilla es NO (fijo).*/

    /*Recupera Descripcion y Glosa del Estado del Beneficiario(Certificado, desahuciado, activo sin beneficios,etc)*/
	BEGIN
    SELECT DESCR,GLOSA
    INTO Out_extDescEstado,Out_extGlosa
    FROM ESTADOS_IMED
    WHERE CODIGO=Out_extCodEstBen;
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	Out_extDescEstado:=' ';
	Out_extGlosa:=' ';

	END;

    /*Recupera la descripcion de la Comuna.*/
	BEGIN
    SELECT DES_COM
    INTO Out_extGlosaComuna
    FROM ADMGLOB.GL_COMUNAS
    WHERE COD_COM=COD_COM_AUX;
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	Out_extGlosaComuna:='Sin Comuna';
	END;

    Out_extDescuentoxPlanilla :=admimed.f_descuento_planilla(In_extCodFinanciador, vCodPlan, vFechaActual);


    vv_PARAMETROS_SALIDA:= f_SETEA_SALIDA;

      UPDATE ADMIMED.IMED_AUDITORIA
      Set RUT_COTIZ = Null,
	  RUT_BENEF = oRutBen,
	  ID_AFI = vIdAfi,
	  CODIGO_CARGA = vCorr,
	  NRO_BONO_ISAPRE = null,
	  MONTO_TOTAL_BONO = null,
	  --PREST_TOTALES_BONO = in_extnumprestaciones,
	  MONTO_ISAPRE_BONO = null,
	  MONTO_COPAGO_BONO = null,
	  DATOS_SALIDA = vv_PARAMETROS_SALIDA,
	  FEC_HOR_SALIDA = SYSDATE,
	  SEGUNDOS_RESP = trunc((SYSDATE-FEC_HOR_LLEGADA)*24*60*60),
	  LUGAR_CONVENIO_MOD = NULL
      Where CORRELATIVO = v_nIMED_AUDI_SEQ
      ;
      COMMIT;

EXCEPTION
WHEN E_SALIR	  THEN

	 vv_PARAMETROS_SALIDA:= F_SETEA_SALIDA;
	 UPDATE ADMIMED.IMED_AUDITORIA
	 Set
	  RUT_COTIZ = Null,
	  RUT_BENEF = oRutBen,
	  ID_AFI = vIdAfi,
	  CODIGO_CARGA = vCorr,
	  NRO_BONO_ISAPRE = null,
	  MONTO_TOTAL_BONO = null,
	  --PREST_TOTALES_BONO = in_extnumprestaciones,
	  MONTO_ISAPRE_BONO = null,
	  MONTO_COPAGO_BONO = null,
	  DATOS_SALIDA = vv_PARAMETROS_SALIDA,
	  FEC_HOR_SALIDA = SYSDATE,
	  SEGUNDOS_RESP = trunc((SYSDATE-FEC_HOR_LLEGADA)*24*60*60),
	  LUGAR_CONVENIO_MOD = NULL
	 Where CORRELATIVO = v_nIMED_AUDI_SEQ
	 ;
	 COMMIT;

WHEN OTHERS	 THEN
	 vv_PARAMETROS_SALIDA:= F_SETEA_SALIDA;
	 UPDATE ADMIMED.IMED_AUDITORIA
	 Set
	  RUT_COTIZ = Null,
	  RUT_BENEF = oRutBen,
	  ID_AFI = vIdAfi,
	  CODIGO_CARGA = vCorr,
	  NRO_BONO_ISAPRE = null,
	  MONTO_TOTAL_BONO = null,
	  --PREST_TOTALES_BONO = in_extnumprestaciones,
	  MONTO_ISAPRE_BONO = null,
	  MONTO_COPAGO_BONO = null,
	  DATOS_SALIDA = vv_PARAMETROS_SALIDA,
	  FEC_HOR_SALIDA = SYSDATE,
	  SEGUNDOS_RESP = trunc((SYSDATE-FEC_HOR_LLEGADA)*24*60*60),
	  LUGAR_CONVENIO_MOD = NULL
	 Where CORRELATIVO = v_nIMED_AUDI_SEQ
	 ;
	 COMMIT;

/*  dbms_output.put_line('rut cotizante :' || Out_extRutCotizante);
	dbms_output.put_line('largo rut cotizante :' || length(Out_extRutCotizante));*/
End FUSBenCertif;
Procedure SNLBenCertif
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
    ) As


BEGIN

FUSBenCertif
    ( SRV_Message
    , In_extCodFinanciador
    , In_extRutBeneficiario
    , In_extFechaActual
    , Out_extApellidoPat
    , Out_extApellidoMat
    , Out_extNombres
    , Out_extSexo
    , Out_extFechaNacimi
    , Out_extCodEstBen
    , Out_extDescEstado
    , Out_extRutCotizante
    , Out_extNomCotizante
    , Out_extDirPaciente
    , Out_extGlosaComuna
    , Out_extGlosaCiudad
    , Out_extPrevision
    , Out_extGlosa
    , Out_extPlan
    , Out_extDescuentoxPlanilla
    , Out_extMontoExcedente
    , Col_extRutAcompanante
    , Col_extNombreAcompanante
    );

End SNLBenCertif;


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
    ) As


BEGIN

FUSBenCertif
    ( SRV_Message
    , In_extCodFinanciador
    , In_extRutBeneficiario
    , In_extFechaActual
    , Out_extApellidoPat
    , Out_extApellidoMat
    , Out_extNombres
    , Out_extSexo
    , Out_extFechaNacimi
    , Out_extCodEstBen
    , Out_extDescEstado
    , Out_extRutCotizante
    , Out_extNomCotizante
    , Out_extDirPaciente
    , Out_extGlosaComuna
    , Out_extGlosaCiudad
    , Out_extPrevision
    , Out_extGlosa
    , Out_extPlan
    , Out_extDescuentoxPlanilla
    , Out_extMontoExcedente
    , Col_extRutAcompanante
    , Col_extNombreAcompanante
    );

End RBLBenCertif;


Procedure CHUBenCertif
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
    ) As


BEGIN

FUSBenCertif
    ( SRV_Message
    , In_extCodFinanciador
    , In_extRutBeneficiario
    , In_extFechaActual
    , Out_extApellidoPat
    , Out_extApellidoMat
    , Out_extNombres
    , Out_extSexo
    , Out_extFechaNacimi
    , Out_extCodEstBen
    , Out_extDescEstado
    , Out_extRutCotizante
    , Out_extNomCotizante
    , Out_extDirPaciente
    , Out_extGlosaComuna
    , Out_extGlosaCiudad
    , Out_extPrevision
    , Out_extGlosa
    , Out_extPlan
    , Out_extDescuentoxPlanilla
    , Out_extMontoExcedente
    , Col_extRutAcompanante
    , Col_extNombreAcompanante
    );

End CHUBenCertif;
End FUSBenCertif_Pkg;

583 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.5.0 - 64bit Production
