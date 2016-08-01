
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 26 18:07:41 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.4.0 - Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package RBLValorVari_Pkg As
  TYPE extValorPrestacion_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;
  TYPE extAporteFinanciador_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;
  TYPE extCopago_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;
  TYPE extInternoIsa_arr IS TABLE OF Varchar2(15)
    INDEX BY BINARY_INTEGER;
  TYPE extTipoBonif1_arr IS TABLE OF Number(1)
    INDEX BY BINARY_INTEGER;
  TYPE extCopago1_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;
  TYPE extTipoBonif2_arr IS TABLE OF Number(1)
    INDEX BY BINARY_INTEGER;
  TYPE extCopago2_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;
  TYPE extTipoBonif3_arr IS TABLE OF Number(1)
    INDEX BY BINARY_INTEGER;
  TYPE extCopago3_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;
  TYPE extTipoBonif4_arr IS TABLE OF Number(1)
    INDEX BY BINARY_INTEGER;
  TYPE extCopago4_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;
  TYPE extTipoBonif5_arr IS TABLE OF Number(1)
    INDEX BY BINARY_INTEGER;
  TYPE extCopago5_arr IS TABLE OF Number(12,0)
    INDEX BY BINARY_INTEGER;

Procedure RBLValorVari
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador	     In 	Number
    , In_extHomNumeroConvenio	     In 	Varchar2
    , In_extHomLugarConvenio	     In 	Varchar2
    , In_extSucVenta		     In 	Varchar2
    , In_extRutConvenio 	     In 	Varchar2
    , In_extRutTratante 	     In 	Varchar2
    , In_extEspecialidad	     In 	Varchar2
    , In_extRutSolicitante	     In 	Varchar2
    , In_extRutBeneficiario	     In 	Varchar2
    , In_extTratamiento 	     In 	Varchar2
    , In_extCodigoDiagnostico	     In 	Varchar2
    , In_extNivelConvenio	     In 	Number
    , In_extUrgencia		     In 	Varchar2
    , In_extLista1		     In 	Varchar2
    , In_extLista2		     In 	Varchar2
    , In_extLista3		     In 	Varchar2
    , In_extLista4		     In 	Varchar2
    , In_extLista5		     In 	Varchar2
    , In_extLista6		     In 	Varchar2
    , In_extLista7		     In 	Varchar2
    , In_extNumPrestaciones	     In 	Number
    , Out_extCodError		     Out	Varchar2
    , Out_extMensajeError	     Out	Varchar2
    , Out_extPlan		     Out	Varchar2
    , Out_extGlosa1		     Out	Varchar2
    , Out_extGlosa2		     Out	Varchar2
    , Out_extGlosa3		     Out	Varchar2
    , Out_extGlosa4		     Out	Varchar2
    , Out_extGlosa5		     Out	Varchar2,
     Out_extValorPrestacion   Out extValorPrestacion_arr,
   Out_extAporteFinanciador Out extAporteFinanciador_arr,
   Out_extCopago	    Out extCopago_arr,
   Out_extInternoIsa	    Out extInternoIsa_arr,
   Out_extTipoBonif1	    Out exttipoBonif1_arr,
   Out_extCopago1	    Out extCopago1_arr,
   Out_extTipoBonif2	    Out exttipoBonif2_arr,
   Out_extCopago2	    Out extCopago2_arr,
   Out_extTipoBonif3	    Out exttipoBonif3_arr,
   Out_extCopago3	    Out extCopago3_arr,
   Out_extTipoBonif4	    Out exttipoBonif4_arr,
   Out_extCopago4	    Out extCopago4_arr,
   Out_extTipoBonif5	    Out exttipoBonif5_arr,
   Out_extCopago5	    Out extCopago5_arr
    );

End RBLValorVari_Pkg;

78 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     RBLValorVari_Pkg As

  Procedure RBLValorVari(SRV_Message		  In Out Varchar2,
			 In_extCodFinanciador	  In Number,
			 In_extHomNumeroConvenio  In Varchar2,
			 In_extHomLugarConvenio   In Varchar2,
			 In_extSucVenta 	  In Varchar2,
			 In_extRutConvenio	  In Varchar2,
			 In_extRutTratante	  In Varchar2,
			 In_extEspecialidad	  In Varchar2,
			 In_extRutSolicitante	  In Varchar2,
			 In_extRutBeneficiario	  In Varchar2,
			 In_extTratamiento	  In Varchar2,
			 In_extCodigoDiagnostico  In Varchar2,
			 In_extNivelConvenio	  In Number,
			 In_extUrgencia 	  In Varchar2,
			 In_extLista1		  In Varchar2,
			 In_extLista2		  In Varchar2,
			 In_extLista3		  In Varchar2,
			 In_extLista4		  In Varchar2,
			 In_extLista5		  In Varchar2,
			 In_extLista6		  In Varchar2,
			 In_extLista7		  In Varchar2,
			 In_extNumPrestaciones	  In Number,
			 Out_extCodError	  Out Varchar2,
			 Out_extMensajeError	  Out Varchar2,
			 Out_extPlan		  Out Varchar2,
			 Out_extGlosa1		  Out Varchar2,
			 Out_extGlosa2		  Out Varchar2,
			 Out_extGlosa3		  Out Varchar2,
			 Out_extGlosa4		  Out Varchar2,
			 Out_extGlosa5		  Out Varchar2,
			 Out_extValorPrestacion   Out extValorPrestacion_arr,
			 Out_extAporteFinanciador Out extAporteFinanciador_arr,
			 Out_extCopago		  Out extCopago_arr,
			 Out_extInternoIsa	  Out extInternoIsa_arr,
			 Out_extTipoBonif1	  Out exttipoBonif1_arr,
			 Out_extCopago1 	  Out extCopago1_arr,
			 Out_extTipoBonif2	  Out exttipoBonif2_arr,
			 Out_extCopago2 	  Out extCopago2_arr,
			 Out_extTipoBonif3	  Out exttipoBonif3_arr,
			 Out_extCopago3 	  Out extCopago3_arr,
			 Out_extTipoBonif4	  Out exttipoBonif4_arr,
			 Out_extCopago4 	  Out extCopago4_arr,
			 Out_extTipoBonif5	  Out exttipoBonif5_arr,
			 Out_extCopago5 	  Out extCopago5_arr) As

    v_idafil NUMBER;
    v_corr   NUMBER;

    vCodError_01 VARCHAR2(1000);
    vError_01	 VARCHAR2(1000);

    vCodError_02 VARCHAR2(1000);
    vError_02	 VARCHAR2(1000);

    vCodError_03_L1 VARCHAR2(1000);
    vError_03_L1    VARCHAR2(1000);
    vCodError_03_L2 VARCHAR2(1000);
    vError_03_L2    VARCHAR2(1000);
    vCodError_03_L3 VARCHAR2(1000);
    vError_03_L3    VARCHAR2(1000);
    vCodError_03_L4 VARCHAR2(1000);
    vError_03_L4    VARCHAR2(1000);
    vCodError_03_L5 VARCHAR2(1000);
    vError_03_L5    VARCHAR2(1000);
    vCodError_03_L6 VARCHAR2(1000);
    vError_03_L6    VARCHAR2(1000);
    vCodError_03_L7 VARCHAR2(1000);
    vError_03_L7    VARCHAR2(1000);

    vCodHomologo_L1 VARCHAR2(10);
    vCodHomologo_L2 VARCHAR2(10);
    vCodHomologo_L3 VARCHAR2(10);
    vCodHomologo_L4 VARCHAR2(10);
    vCodHomologo_L5 VARCHAR2(10);
    vCodHomologo_L6 VARCHAR2(10);
    vCodHomologo_L7 VARCHAR2(10);

    vItem_L1 VARCHAR2(2);
    vItem_L2 VARCHAR2(2);
    vItem_L3 VARCHAR2(2);
    vItem_L4 VARCHAR2(2);
    vItem_L5 VARCHAR2(2);
    vItem_L6 VARCHAR2(2);
    vItem_L7 VARCHAR2(2);

    vCodAdicional_L1 VARCHAR2(15);
    vCodAdicional_L2 VARCHAR2(15);
    vCodAdicional_L3 VARCHAR2(15);
    vCodAdicional_L4 VARCHAR2(15);
    vCodAdicional_L5 VARCHAR2(15);
    vCodAdicional_L6 VARCHAR2(15);
    vCodAdicional_L7 VARCHAR2(15);

    vRecargo_L1 VARCHAR2(1);
    vRecargo_L2 VARCHAR2(1);
    vRecargo_L3 VARCHAR2(1);
    vRecargo_L4 VARCHAR2(1);
    vRecargo_L5 VARCHAR2(1);
    vRecargo_L6 VARCHAR2(1);
    vRecargo_L7 VARCHAR2(1);

    vCantidad_L1 VARCHAR2(2) := 0;
    vCantidad_L2 VARCHAR2(2) := 0;
    vCantidad_L3 VARCHAR2(2) := 0;
    vCantidad_L4 VARCHAR2(2) := 0;
    vCantidad_L5 VARCHAR2(2) := 0;
    vCantidad_L6 VARCHAR2(2) := 0;
    vCantidad_L7 VARCHAR2(2) := 0;

    vValorTotal_L1 VARCHAR2(12) := 0;
    vValorTotal_L2 VARCHAR2(12) := 0;
    vValorTotal_L3 VARCHAR2(12) := 0;
    vValorTotal_L4 VARCHAR2(12) := 0;
    vValorTotal_L5 VARCHAR2(12) := 0;
    vValorTotal_L6 VARCHAR2(12) := 0;
    vValorTotal_L7 VARCHAR2(12) := 0;

    vValorConvenio_L1 NUMBER := 0;
    vValorConvenio_L2 NUMBER := 0;
    vValorConvenio_L3 NUMBER := 0;
    vValorConvenio_L4 NUMBER := 0;
    vValorConvenio_L5 NUMBER := 0;
    vValorConvenio_L6 NUMBER := 0;
    vValorConvenio_L7 NUMBER := 0;

    vCodIntegrante_L1 VARCHAR2(10);
    vCodIntegrante_L2 VARCHAR2(10);
    vCodIntegrante_L3 VARCHAR2(10);
    vCodIntegrante_L4 VARCHAR2(10);
    vCodIntegrante_L5 VARCHAR2(10);
    vCodIntegrante_L6 VARCHAR2(10);
    vCodIntegrante_L7 VARCHAR2(10);

    vCodIsapre_L1 NUMBER;
    vCodIsapre_L2 NUMBER;
    vCodIsapre_L3 NUMBER;
    vCodIsapre_L4 NUMBER;
    vCodIsapre_L5 NUMBER;
    vCodIsapre_L6 NUMBER;
    vCodIsapre_L7 NUMBER;

    vValorBonif_L1 NUMBER := 0;
    vValorBonif_L2 NUMBER := 0;
    vValorBonif_L3 NUMBER := 0;
    vValorBonif_L4 NUMBER := 0;
    vValorBonif_L5 NUMBER := 0;
    vValorBonif_L6 NUMBER := 0;
    vValorBonif_L7 NUMBER := 0;

    vValorCopago_L1 NUMBER := 0;
    vValorCopago_L2 NUMBER := 0;
    vValorCopago_L3 NUMBER := 0;
    vValorCopago_L4 NUMBER := 0;
    vValorCopago_L5 NUMBER := 0;
    vValorCopago_L6 NUMBER := 0;
    vValorCopago_L7 NUMBER := 0;

    vValorAran_L1 NUMBER := 0;
    vValorAran_L2 NUMBER := 0;
    vValorAran_L3 NUMBER := 0;
    vValorAran_L4 NUMBER := 0;
    vValorAran_L5 NUMBER := 0;
    vValorAran_L6 NUMBER := 0;
    vValorAran_L7 NUMBER := 0;

    vLinea_L1 VARCHAR2(500);
    vLinea_L2 VARCHAR2(500);
    vLinea_L3 VARCHAR2(500);
    vLinea_L4 VARCHAR2(500);
    vLinea_L5 VARCHAR2(500);
    vLinea_L6 VARCHAR2(500);
    vLinea_L7 VARCHAR2(500);

    v_Arreglo_intgte admbene.BEN_PCK_TIPO_DATOS.ArregloRep_intgte;
    v_Arreglo	     admbene.BEN_PCK_TIPO_DATOS.ArregloRep12;

    v_fechaemision DATE;
    v_idprestador  NUMBER;
    v_iddireccion  NUMBER;
    v_tipopresta   VARCHAR2(2);
    v_idpropio	   NUMBER;
    v_indice	   NUMBER;

    -- variables asociadas a credito
    v_credito	     NUMBER;
    v_titularcredito NUMBER;
    v_existecredito  BOOLEAN;
    vCodError_04     VARCHAR2(1000);
    v_disponible     NUMBER;

    i	    NUMBER;
    j	    NUMBER;
    vPosFin NUMBER;

    vRutPrestador number;
    vDVPrestador  varchar2(1);

    vRutBen  number;
    vDVBen   varchar2(1);
    vCodPlan varchar2(10);

    VRutStaff  number;
    VDVStaff   varchar2(1);
    v_staff_ob varchar2(1);

    SRV_FetchStatus Number(1);
    SRV_TotalRows   Number(8);
    SRV_RowCount    Number(8);

  BEGIN

    INSERT INTO IMED_VALORVARI
      (SRV_MESSAGE, --	      VARCHAR2(10 BYTE),
       EXTCODFINANCIADOR, --  NUMBER,
       EXTHOMNUMEROCONVENIO, -- VARCHAR2(15 BYTE),
       EXTHOMLUGARCONVENIO, --	VARCHAR2(10 BYTE),
       EXTSUCVENTA, --	 VARCHAR2(10 BYTE),
       EXTRUTCONVENIO, --   VARCHAR2(12 BYTE),
       EXTRUTTRATANTE, --    VARCHAR2(12 BYTE),
       EXTESPECIALIDAD, --  VARCHAR2(10 BYTE),
       EXTRUTSOLICITANTE, -- VARCHAR2(12 BYTE),
       EXTRUTBENEFICIARIO, -- VARCHAR2(12 BYTE),
       EXTTRATAMIENTO, -- VARCHAR2(1 BYTE),
       EXTCODIGODIAGNOSTICO, -- VARCHAR2(10 BYTE),
       EXTNIVELCONVENIO, -- NUMBER,
       EXTURGENCIA, -- VARCHAR2(1 BYTE),
       EXTLISTA1, -- VARCHAR2(255 BYTE),
       EXTLISTA2, -- -VARCHAR2(255 BYTE),
       EXTLISTA3, -- VARCHAR2(255 BYTE),
       EXTLISTA4, -- VARCHAR2(255 BYTE),
       EXTLISTA5, --  VARCHAR2(255 BYTE),
       EXTLISTA6, --  VARCHAR2(255 BYTE),
       EXTLISTA7, -- VARCHAR2(255 BYTE),
       EXTNUMPRESTACIONES, --  NUMBER,
       FECHA_RECEP)
    VALUES
      (SRV_Message --	    In Out     Varchar2
      ,
       In_extCodFinanciador --	      In	 Number
      ,
       In_extHomNumeroConvenio --      In	  Varchar2
      ,
       In_extHomLugarConvenio --    In	       Varchar2
      ,
       In_extSucVenta --  In	     Varchar2
      ,
       In_extRutConvenio --	       In	  Varchar2
      ,
       In_extRutTratante --	     In 	Varchar2
      ,
       In_extEspecialidad --	    In	       Varchar2
      ,
       In_extRutSolicitante --	    In	       Varchar2
      ,
       In_extRutBeneficiario --    In	      Varchar2
      ,
       In_extTratamiento --		In	   Varchar2
      ,
       In_extCodigoDiagnostico --	 In	    Varchar2
      ,
       In_extNivelConvenio --	    In	       Number
      ,
       In_extUrgencia ---     In	 Varchar2
      ,
       In_extLista1 ---  In	    Varchar2
      ,
       In_extLista2 --	  In	     Varchar2
      ,
       In_extLista3 --	In	   Varchar2
      ,
       In_extLista4 --In	 Varchar2
      ,
       In_extLista5 --		In	   Varchar2
      ,
       In_extLista6 --	      In	 Varchar2
      ,
       In_extLista7 --	    In	       Varchar2
      ,
       In_extNumPrestaciones, --    In	       Number);
       SYSDATE);
    COMMIT;

    --VALORES POR DEFECTO
    SRV_TotalRows   := TO_Number(rTrim(SRV_Message));
    SRV_RowCount    := 0;
    SRV_FetchStatus := 0;
    SRV_Message     := '1000000';

    Out_extCodError	:= ' ';
    Out_extMensajeError := ' ';
    Out_extPlan 	:= ' ';
    Out_extGlosa1	:= ' ';
    Out_extGlosa2	:= ' ';
    Out_extGlosa3	:= ' ';
    Out_extGlosa4	:= ' ';
    Out_extGlosa5	:= ' ';

    -- Valido codigo financiador
    if In_extCodFinanciador <> 68 then
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'Codigo Financiador Erroneo';
      Return;
    end if;

    -- valido prestador
    -- valido domicilio prestador
    ADMIMED.ValidoPrestador(In_extHomNumeroConvenio,
			    In_extHomLugarConvenio,
			    In_extSucVenta,
			    In_extRutConvenio,
			    trunc(sysdate),
			    vRutPrestador,
			    vDVPrestador,
			    vCodError_01,
			    vError_01);

    if vCodError_01 = 'S' then
      Out_extCodError	  := 'N';
      Out_extMensajeError := vError_01;
      Return;
    end if;

    -- valido beneficiario
    ADMIMED.ValidoBeneficiario(In_extRutBeneficiario,
			       trunc(sysdate),
			       v_idafil,
			       v_corr,
			       vRutBen,
			       vDVBen,
			       vCodPlan,
			       vCodError_02,
			       vError_02);

    if vCodError_02 = 'S' then
      Out_extCodError	  := 'N';
      Out_extMensajeError := vError_02;
      Return;
    end if;

    -- Recupero Codigo del Plan

    Out_extPlan := admafil.f_cod_plan_vigente(v_idafil, sysdate);

    -- valido staff cuando viene
    if trim(In_extRutTratante) <> '0000000000-0' then
      ADMIMED.ValidoStaff(In_extRutTratante,
			  vRutPrestador,
			  VRutStaff,
			  VDVStaff,
			  vCodError_01,
			  vError_01);

      if vCodError_01 = 'S' then
	Out_extCodError     := 'N';
	Out_extMensajeError := substr(vError_01, 1, 30);
	Return;
      end if;

    else
      begin
	select CVDO_STAFF_OBLG
	  into v_staff_ob
	  from con_domicis
	 where cvdo_id_domi = In_extHomLugarConvenio;
      exception
	when no_data_found then
	  null;
      end;

      if upper(v_staff_ob) = 'S' then
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Debe seleccionar Med. Tratante';
	Return;
      end if;

    end if;

    -- valido listas
    vCodError_03_L1 := 'N';
    vCodError_03_L2 := 'N';
    vCodError_03_L3 := 'N';
    vCodError_03_L4 := 'N';
    vCodError_03_L5 := 'N';
    vCodError_03_L6 := 'N';
    vCodError_03_L7 := 'N';

    v_fechaemision := TRUNC(SYSDATE);
    v_idprestador  := 1;
    v_iddireccion  := 1;
    v_tipopresta   := 'A';
    v_idpropio	   := null;

    if In_extNumPrestaciones > 49 then
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'N Detalles > 49';
      Return;
    end if;

    if In_extNumPrestaciones < 1 then
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'N Detalles < 1';
      Return;
    end if;

    v_existecredito := ADMBENE.BEN_F_EXISTE_CTA_CRED_IMED(v_idafil,
							  v_credito,
							  v_titularcredito,
							  vCodError_04);
    dbms_output.put_line('Credito:' || v_credito);

    if vCodError_04 is not null then
      Out_extCodError	  := 'N';
      Out_extMensajeError := vCodError_04;
      Return;
    end if;

    if v_existecredito then
      v_disponible := v_credito;
    else
      v_disponible := 0;
      dbms_output.put_line('CreditoF:' || v_disponible);
    end if;

    dbms_output.put_line('AQUI01');

    if In_extNumPrestaciones > 0 then

      --vPosFin := least(7,In_extNumPrestaciones);
      vPosFin := least(5, In_extNumPrestaciones);

      j := 1;

      for i IN 1 .. vPosFin Loop

	ADMIMED.ValidoLista(i,
			    In_extHomNumeroConvenio,
			    In_extHomLugarConvenio,
			    In_extLista1,
			    vCodError_03_L1,
			    vError_03_L1,
			    vCodHomologo_L1,
			    vItem_L1,
			    vCodAdicional_L1,
			    vRecargo_L1,
			    vCantidad_L1,
			    vValorTotal_L1,
			    vValorConvenio_L1,
			    vCodIntegrante_L1,
			    vCodIsapre_L1);

	if vCodError_03_L1 = 'S' then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := vError_03_L1;
	  Return;
	end if;

	ADMBENE.Ben_Bonificador12(v_Arreglo_intgte,
				  v_Arreglo,
				  vCodIntegrante_L1,
				  v_idafil,
				  v_corr,
				  v_fechaemision,
				  v_idprestador,
				  v_iddireccion,
				  vCodIsapre_L1,
				  vCantidad_L1,
				  v_tipopresta,
				  null,
				  'RB',
				  4,
				  vValorConvenio_L1, --vValorTotal_L1,
				  vValorBonif_L1,
				  vValorCopago_L1,
				  vValorAran_L1,
				  v_idpropio,
				  vLinea_L1);

	dbms_output.put_line('AQUI02*' || vValorBonif_L1);
	if vLinea_L1 is not null then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := substr(vLinea_L1, 1, 30);
	  Return;
	end if;

	if v_existecredito then

	  Out_extTipoBonif1(j) := 0;
	  Out_extCopago1(j) := 0;
	  dbms_output.put_line('CreditoDispo1:' || v_disponible);

	  if v_disponible > 1 then
	    Out_extCopago1(j) := least(v_disponible,
				       (vValorConvenio_L1 * vCantidad_L1 -
				       vValorBonif_L1));

	    if Out_extCopago1(j) > 0 then
	      Out_extTipoBonif1(j) := 9;
	    else
	      Out_extTipoBonif1(j) := 0;
	    end if;

	    v_disponible := v_disponible - Out_extCopago1(j);

	  else
	    Out_extTipoBonif1(j) := 0;
	    Out_extCopago1(j) := 0;

	  end if;

	  Out_extValorPrestacion(j) := vValorConvenio_L1 * vCantidad_L1;
	  Out_extAporteFinanciador(j) := vValorBonif_L1;
	  Out_extCopago(j) := vValorConvenio_L1 * vCantidad_L1 -
			      vValorBonif_L1;
	  Out_extInternoIsa(j) := ' ';
	  Out_extTipoBonif2(j) := 0;
	  Out_extCopago2(j) := 0;
	  Out_extTipoBonif3(j) := 0;
	  Out_extCopago3(j) := 0;
	  Out_extTipoBonif4(j) := 0;
	  Out_extCopago4(j) := 0;
	  Out_extTipoBonif5(j) := 0;
	  Out_extCopago5(j) := 0;

	else
	  /* no existe credito */

	  Out_extValorPrestacion(j) := vValorConvenio_L1 * vCantidad_L1;
	  Out_extAporteFinanciador(j) := vValorBonif_L1;
	  Out_extCopago(j) := vValorConvenio_L1 * vCantidad_L1 -
			      vValorBonif_L1;
	  Out_extTipoBonif1(j) := 0;
	  Out_extCopago1(j) := 0;
	  Out_extInternoIsa(j) := ' ';
	  Out_extTipoBonif2(j) := 0;
	  Out_extCopago2(j) := 0;
	  Out_extTipoBonif3(j) := 0;
	  Out_extCopago3(j) := 0;
	  Out_extTipoBonif4(j) := 0;
	  Out_extCopago4(j) := 0;
	  Out_extTipoBonif5(j) := 0;
	  Out_extCopago5(j) := 0;

	end if;

	dbms_output.put_line('AQUI03');

	j := j + 1;

      End Loop;

    end if;

    -- TRABAJAMOS CON LISTA 2

    --if In_extNumPrestaciones > 7 then

    --vPosFin := least(14,In_extNumPrestaciones);
    --j:= 8;
    if In_extNumPrestaciones > 5 then
      vPosFin := least(10, In_extNumPrestaciones) - 5;
      j       := 6;

      for i IN 1 .. vPosFin Loop

	ADMIMED.ValidoLista(i,
			    In_extHomNumeroConvenio,
			    In_extHomLugarConvenio,
			    In_extLista2,
			    vCodError_03_L1,
			    vError_03_L1,
			    vCodHomologo_L1,
			    vItem_L1,
			    vCodAdicional_L1,
			    vRecargo_L1,
			    vCantidad_L1,
			    vValorTotal_L1,
			    vValorConvenio_L1,
			    vCodIntegrante_L1,
			    vCodIsapre_L1);

	if vCodError_03_L1 = 'S' then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := vError_03_L1;
	  Return;
	end if;

	ADMBENE.Ben_Bonificador12(v_Arreglo_intgte,
				  v_Arreglo,
				  vCodIntegrante_L1,
				  v_idafil,
				  v_corr,
				  v_fechaemision,
				  v_idprestador,
				  v_iddireccion,
				  vCodIsapre_L1,
				  vCantidad_L1,
				  v_tipopresta,
				  null,
				  'RB',
				  4,
				  vValorConvenio_L1, --vValorTotal_L1,
				  vValorBonif_L1,
				  vValorCopago_L1,
				  vValorAran_L1,
				  v_idpropio,
				  vLinea_L1);

	if vLinea_L1 is not null then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := vLinea_L1;
	  Return;
	end if;

	if v_existecredito then

	  Out_extTipoBonif1(j) := 0;
	  Out_extCopago1(j) := 0;
	  dbms_output.put_line('CreditoDispo1:' || v_disponible);

	  if v_disponible > 1 then
	    Out_extCopago1(j) := least(v_disponible,
				       (vValorConvenio_L1 * vCantidad_L1 -
				       vValorBonif_L1));

	    if Out_extCopago1(j) > 0 then
	      Out_extTipoBonif1(j) := 9;
	    else
	      Out_extTipoBonif1(j) := 0;
	    end if;

	    v_disponible := v_disponible - Out_extCopago1(j);

	  else
	    Out_extTipoBonif1(j) := 0;
	    Out_extCopago1(j) := 0;

	  end if;

	  Out_extValorPrestacion(j) := vValorConvenio_L1 * vCantidad_L1;
	  Out_extAporteFinanciador(j) := vValorBonif_L1;
	  Out_extCopago(j) := vValorConvenio_L1 * vCantidad_L1 -
			      vValorBonif_L1;
	  Out_extInternoIsa(j) := ' ';
	  Out_extTipoBonif2(j) := 0;
	  Out_extCopago2(j) := 0;
	  Out_extTipoBonif3(j) := 0;
	  Out_extCopago3(j) := 0;
	  Out_extTipoBonif4(j) := 0;
	  Out_extCopago4(j) := 0;
	  Out_extTipoBonif5(j) := 0;
	  Out_extCopago5(j) := 0;

	else
	  /* no existe credito */

	  Out_extValorPrestacion(j) := vValorConvenio_L1 * vCantidad_L1;
	  Out_extAporteFinanciador(j) := vValorBonif_L1;
	  Out_extCopago(j) := vValorConvenio_L1 * vCantidad_L1 -
			      vValorBonif_L1;
	  Out_extTipoBonif1(j) := 0;
	  Out_extCopago1(j) := 0;
	  Out_extInternoIsa(j) := ' ';
	  Out_extTipoBonif2(j) := 0;
	  Out_extCopago2(j) := 0;
	  Out_extTipoBonif3(j) := 0;
	  Out_extCopago3(j) := 0;
	  Out_extTipoBonif4(j) := 0;
	  Out_extCopago4(j) := 0;
	  Out_extTipoBonif5(j) := 0;
	  Out_extCopago5(j) := 0;

	end if;

	j := j + 1;

      End Loop;

    end if;

    -- TRABAJAMOS CON LISTA 3

    --if In_extNumPrestaciones > 14 then
    --vPosFin := least(21,In_extNumPrestaciones);
    --j:= 15;
    if In_extNumPrestaciones > 10 then
      vPosFin := least(15, In_extNumPrestaciones) - 10;
      j       := 11;

      for i IN 1 .. vPosFin Loop

	ADMIMED.ValidoLista(i,
			    In_extHomNumeroConvenio,
			    In_extHomLugarConvenio,
			    In_extLista3,
			    vCodError_03_L1,
			    vError_03_L1,
			    vCodHomologo_L1,
			    vItem_L1,
			    vCodAdicional_L1,
			    vRecargo_L1,
			    vCantidad_L1,
			    vValorTotal_L1,
			    vValorConvenio_L1,
			    vCodIntegrante_L1,
			    vCodIsapre_L1);

	if vCodError_03_L1 = 'S' then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := vError_03_L1;
	  Return;
	end if;

	ADMBENE.Ben_Bonificador12(v_Arreglo_intgte,
				  v_Arreglo,
				  vCodIntegrante_L1,
				  v_idafil,
				  v_corr,
				  v_fechaemision,
				  v_idprestador,
				  v_iddireccion,
				  vCodIsapre_L1,
				  vCantidad_L1,
				  v_tipopresta,
				  null,
				  'RB',
				  4,
				  vValorConvenio_L1, --vValorTotal_L1,
				  vValorBonif_L1,
				  vValorCopago_L1,
				  vValorAran_L1,
				  v_idpropio,
				  vLinea_L1);

	if vLinea_L1 is not null then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := vLinea_L1;
	  Return;
	end if;

	if v_existecredito then

	  Out_extTipoBonif1(j) := 0;
	  Out_extCopago1(j) := 0;
	  dbms_output.put_line('CreditoDispo1:' || v_disponible);

	  if v_disponible > 1 then
	    Out_extCopago1(j) := least(v_disponible,
				       (vValorConvenio_L1 * vCantidad_L1 -
				       vValorBonif_L1));

	    if Out_extCopago1(j) > 0 then
	      Out_extTipoBonif1(j) := 9;
	    else
	      Out_extTipoBonif1(j) := 0;
	    end if;

	    v_disponible := v_disponible - Out_extCopago1(j);

	  else
	    Out_extTipoBonif1(j) := 0;
	    Out_extCopago1(j) := 0;

	  end if;

	  Out_extValorPrestacion(j) := vValorConvenio_L1 * vCantidad_L1;
	  Out_extAporteFinanciador(j) := vValorBonif_L1;
	  Out_extCopago(j) := vValorConvenio_L1 * vCantidad_L1 -
			      vValorBonif_L1;
	  Out_extInternoIsa(j) := ' ';
	  Out_extTipoBonif2(j) := 0;
	  Out_extCopago2(j) := 0;
	  Out_extTipoBonif3(j) := 0;
	  Out_extCopago3(j) := 0;
	  Out_extTipoBonif4(j) := 0;
	  Out_extCopago4(j) := 0;
	  Out_extTipoBonif5(j) := 0;
	  Out_extCopago5(j) := 0;

	else
	  /* no existe credito */

	  Out_extValorPrestacion(j) := vValorConvenio_L1 * vCantidad_L1;
	  Out_extAporteFinanciador(j) := vValorBonif_L1;
	  Out_extCopago(j) := vValorConvenio_L1 * vCantidad_L1 -
			      vValorBonif_L1;
	  Out_extTipoBonif1(j) := 0;
	  Out_extCopago1(j) := 0;
	  Out_extInternoIsa(j) := ' ';
	  Out_extTipoBonif2(j) := 0;
	  Out_extCopago2(j) := 0;
	  Out_extTipoBonif3(j) := 0;
	  Out_extCopago3(j) := 0;
	  Out_extTipoBonif4(j) := 0;
	  Out_extCopago4(j) := 0;
	  Out_extTipoBonif5(j) := 0;
	  Out_extCopago5(j) := 0;

	end if;

	j := j + 1;

      End Loop;

    end if;

    -- TRABAJAMOS CON LISTA 4

    --if In_extNumPrestaciones > 21 then
    --vPosFin := least(28,In_extNumPrestaciones);
    --j:= 22;
    if In_extNumPrestaciones > 15 then
      vPosFin := least(20, In_extNumPrestaciones) - 15;
      j       := 16;

      for i IN 1 .. vPosFin Loop

	ADMIMED.ValidoLista(i,
			    In_extHomNumeroConvenio,
			    In_extHomLugarConvenio,
			    In_extLista4,
			    vCodError_03_L1,
			    vError_03_L1,
			    vCodHomologo_L1,
			    vItem_L1,
			    vCodAdicional_L1,
			    vRecargo_L1,
			    vCantidad_L1,
			    vValorTotal_L1,
			    vValorConvenio_L1,
			    vCodIntegrante_L1,
			    vCodIsapre_L1);

	if vCodError_03_L1 = 'S' then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := vError_03_L1;
	  Return;
	end if;

	ADMBENE.Ben_Bonificador12(v_Arreglo_intgte,
				  v_Arreglo,
				  vCodIntegrante_L1,
				  v_idafil,
				  v_corr,
				  v_fechaemision,
				  v_idprestador,
				  v_iddireccion,
				  vCodIsapre_L1,
				  vCantidad_L1,
				  v_tipopresta,
				  null,
				  'RB',
				  4,
				  vValorConvenio_L1, --vValorTotal_L1,
				  vValorBonif_L1,
				  vValorCopago_L1,
				  vValorAran_L1,
				  v_idpropio,
				  vLinea_L1);

	if vLinea_L1 is not null then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := vLinea_L1;
	  Return;
	end if;

	if v_existecredito then

	  Out_extTipoBonif1(j) := 0;
	  Out_extCopago1(j) := 0;
	  dbms_output.put_line('CreditoDispo1:' || v_disponible);

	  if v_disponible > 1 then
	    Out_extCopago1(j) := least(v_disponible,
				       (vValorConvenio_L1 * vCantidad_L1 -
				       vValorBonif_L1));

	    if Out_extCopago1(j) > 0 then
	      Out_extTipoBonif1(j) := 9;
	    else
	      Out_extTipoBonif1(j) := 0;
	    end if;

	    v_disponible := v_disponible - Out_extCopago1(j);

	  else
	    Out_extTipoBonif1(j) := 0;
	    Out_extCopago1(j) := 0;

	  end if;

	  Out_extValorPrestacion(j) := vValorConvenio_L1 * vCantidad_L1;
	  Out_extAporteFinanciador(j) := vValorBonif_L1;
	  Out_extCopago(j) := vValorConvenio_L1 * vCantidad_L1 -
			      vValorBonif_L1;
	  Out_extInternoIsa(j) := ' ';
	  Out_extTipoBonif2(j) := 0;
	  Out_extCopago2(j) := 0;
	  Out_extTipoBonif3(j) := 0;
	  Out_extCopago3(j) := 0;
	  Out_extTipoBonif4(j) := 0;
	  Out_extCopago4(j) := 0;
	  Out_extTipoBonif5(j) := 0;
	  Out_extCopago5(j) := 0;

	else
	  /* no existe credito */

	  Out_extValorPrestacion(j) := vValorConvenio_L1 * vCantidad_L1;
	  Out_extAporteFinanciador(j) := vValorBonif_L1;
	  Out_extCopago(j) := vValorConvenio_L1 * vCantidad_L1 -
			      vValorBonif_L1;
	  Out_extTipoBonif1(j) := 0;
	  Out_extCopago1(j) := 0;
	  Out_extInternoIsa(j) := ' ';
	  Out_extTipoBonif2(j) := 0;
	  Out_extCopago2(j) := 0;
	  Out_extTipoBonif3(j) := 0;
	  Out_extCopago3(j) := 0;
	  Out_extTipoBonif4(j) := 0;
	  Out_extCopago4(j) := 0;
	  Out_extTipoBonif5(j) := 0;
	  Out_extCopago5(j) := 0;

	end if;

	j := j + 1;

      End Loop;

    end if;

    -- TRABAJAMOS CON LISTA 5

    --if In_extNumPrestaciones > 28 then
    --vPosFin := least(35,In_extNumPrestaciones);
    --j:= 29;
    if In_extNumPrestaciones > 20 then
      vPosFin := least(25, In_extNumPrestaciones) - 20;
      j       := 21;

      for i IN 1 .. vPosFin Loop

	ADMIMED.ValidoLista(i,
			    In_extHomNumeroConvenio,
			    In_extHomLugarConvenio,
			    In_extLista5,
			    vCodError_03_L1,
			    vError_03_L1,
			    vCodHomologo_L1,
			    vItem_L1,
			    vCodAdicional_L1,
			    vRecargo_L1,
			    vCantidad_L1,
			    vValorTotal_L1,
			    vValorConvenio_L1,
			    vCodIntegrante_L1,
			    vCodIsapre_L1);

	if vCodError_03_L1 = 'S' then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := vError_03_L1;
	  Return;
	end if;

	ADMBENE.Ben_Bonificador12(v_Arreglo_intgte,
				  v_Arreglo,
				  vCodIntegrante_L1,
				  v_idafil,
				  v_corr,
				  v_fechaemision,
				  v_idprestador,
				  v_iddireccion,
				  vCodIsapre_L1,
				  vCantidad_L1,
				  v_tipopresta,
				  null,
				  'RB',
				  4,
				  vValorConvenio_L1, --vValorTotal_L1,
				  vValorBonif_L1,
				  vValorCopago_L1,
				  vValorAran_L1,
				  v_idpropio,
				  vLinea_L1);

	if vLinea_L1 is not null then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := '*B*' || SUBSTR(vLinea_L1, 1, 27);
	  Return;
	end if;

	if v_existecredito then

	  Out_extTipoBonif1(j) := 0;

TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	  Out_extCopago1(j) := 0;
	  dbms_output.put_line('CreditoDispo1:' || v_disponible);

	  if v_disponible > 1 then
	    Out_extCopago1(j) := least(v_disponible,
				       (vValorConvenio_L1 * vCantidad_L1 -
				       vValorBonif_L1));

	    if Out_extCopago1(j) > 0 then
	      Out_extTipoBonif1(j) := 9;
	    else
	      Out_extTipoBonif1(j) := 0;
	    end if;

	    v_disponible := v_disponible - Out_extCopago1(j);

	  else
	    Out_extTipoBonif1(j) := 0;
	    Out_extCopago1(j) := 0;

	  end if;

	  Out_extValorPrestacion(j) := vValorConvenio_L1 * vCantidad_L1;
	  Out_extAporteFinanciador(j) := vValorBonif_L1;
	  Out_extCopago(j) := vValorConvenio_L1 * vCantidad_L1 -
			      vValorBonif_L1;
	  Out_extInternoIsa(j) := ' ';
	  Out_extTipoBonif2(j) := 0;
	  Out_extCopago2(j) := 0;
	  Out_extTipoBonif3(j) := 0;
	  Out_extCopago3(j) := 0;
	  Out_extTipoBonif4(j) := 0;
	  Out_extCopago4(j) := 0;
	  Out_extTipoBonif5(j) := 0;
	  Out_extCopago5(j) := 0;

	else
	  /* no existe credito */

	  Out_extValorPrestacion(j) := vValorConvenio_L1 * vCantidad_L1;
	  Out_extAporteFinanciador(j) := vValorBonif_L1;
	  Out_extCopago(j) := vValorConvenio_L1 * vCantidad_L1 -
			      vValorBonif_L1;
	  Out_extTipoBonif1(j) := 0;
	  Out_extCopago1(j) := 0;
	  Out_extInternoIsa(j) := ' ';
	  Out_extTipoBonif2(j) := 0;
	  Out_extCopago2(j) := 0;
	  Out_extTipoBonif3(j) := 0;
	  Out_extCopago3(j) := 0;
	  Out_extTipoBonif4(j) := 0;
	  Out_extCopago4(j) := 0;
	  Out_extTipoBonif5(j) := 0;
	  Out_extCopago5(j) := 0;

	end if;

	j := j + 1;

      End Loop;

    end if;

    -- TRABAJAMOS CON LISTA 6

    --if In_extNumPrestaciones > 35 then
    --vPosFin := least(42,In_extNumPrestaciones);
    --j:= 36;
    if In_extNumPrestaciones > 25 then
      vPosFin := least(30, In_extNumPrestaciones) - 25;
      j       := 26;

      for i IN 1 .. vPosFin Loop

	ADMIMED.ValidoLista(i,
			    In_extHomNumeroConvenio,
			    In_extHomLugarConvenio,
			    In_extLista6,
			    vCodError_03_L1,
			    vError_03_L1,
			    vCodHomologo_L1,
			    vItem_L1,
			    vCodAdicional_L1,
			    vRecargo_L1,
			    vCantidad_L1,
			    vValorTotal_L1,
			    vValorConvenio_L1,
			    vCodIntegrante_L1,
			    vCodIsapre_L1);

	if vCodError_03_L1 = 'S' then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := vError_03_L1;
	  Return;
	end if;

	ADMBENE.Ben_Bonificador12(v_Arreglo_intgte,
				  v_Arreglo,
				  vCodIntegrante_L1,
				  v_idafil,
				  v_corr,
				  v_fechaemision,
				  v_idprestador,
				  v_iddireccion,
				  vCodIsapre_L1,
				  vCantidad_L1,
				  v_tipopresta,
				  null,
				  'RB',
				  4,
				  vValorConvenio_L1, --vValorTotal_L1,
				  vValorBonif_L1,
				  vValorCopago_L1,
				  vValorAran_L1,
				  v_idpropio,
				  vLinea_L1);

	if vLinea_L1 is not null then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := '*B*' || substr(vLinea_L1, 1, 27);
	  Return;
	end if;

	if v_existecredito then

	  Out_extTipoBonif1(j) := 0;
	  Out_extCopago1(j) := 0;
	  dbms_output.put_line('CreditoDispo1:' || v_disponible);

	  if v_disponible > 1 then
	    Out_extCopago1(j) := least(v_disponible,
				       (vValorConvenio_L1 * vCantidad_L1 -
				       vValorBonif_L1));

	    if Out_extCopago1(j) > 0 then
	      Out_extTipoBonif1(j) := 9;
	    else
	      Out_extTipoBonif1(j) := 0;
	    end if;

	    v_disponible := v_disponible - Out_extCopago1(j);

	  else
	    Out_extTipoBonif1(j) := 0;
	    Out_extCopago1(j) := 0;

	  end if;

	  Out_extValorPrestacion(j) := vValorConvenio_L1 * vCantidad_L1;
	  Out_extAporteFinanciador(j) := vValorBonif_L1;
	  Out_extCopago(j) := vValorConvenio_L1 * vCantidad_L1 -
			      vValorBonif_L1;
	  Out_extInternoIsa(j) := ' ';
	  Out_extTipoBonif2(j) := 0;
	  Out_extCopago2(j) := 0;
	  Out_extTipoBonif3(j) := 0;
	  Out_extCopago3(j) := 0;
	  Out_extTipoBonif4(j) := 0;
	  Out_extCopago4(j) := 0;
	  Out_extTipoBonif5(j) := 0;
	  Out_extCopago5(j) := 0;

	else
	  /* no existe credito */

	  Out_extValorPrestacion(j) := vValorConvenio_L1 * vCantidad_L1;
	  Out_extAporteFinanciador(j) := vValorBonif_L1;
	  Out_extCopago(j) := vValorConvenio_L1 * vCantidad_L1 -
			      vValorBonif_L1;
	  Out_extTipoBonif1(j) := 0;
	  Out_extCopago1(j) := 0;
	  Out_extInternoIsa(j) := ' ';
	  Out_extTipoBonif2(j) := 0;
	  Out_extCopago2(j) := 0;
	  Out_extTipoBonif3(j) := 0;
	  Out_extCopago3(j) := 0;
	  Out_extTipoBonif4(j) := 0;
	  Out_extCopago4(j) := 0;
	  Out_extTipoBonif5(j) := 0;
	  Out_extCopago5(j) := 0;

	end if;

	j := j + 1;

      End Loop;

    end if;

    -- TRABAJAMOS CON LISTA 7

    --if In_extNumPrestaciones > 42 then
    --vPosFin := least(49,In_extNumPrestaciones);
    --j:= 43;
    if In_extNumPrestaciones > 30 then
      vPosFin := least(35, In_extNumPrestaciones) - 30;
      j       := 31;

      for i IN 1 .. vPosFin Loop

	ADMIMED.ValidoLista(i,
			    In_extHomNumeroConvenio,
			    In_extHomLugarConvenio,
			    In_extLista7,
			    vCodError_03_L1,
			    vError_03_L1,
			    vCodHomologo_L1,
			    vItem_L1,
			    vCodAdicional_L1,
			    vRecargo_L1,
			    vCantidad_L1,
			    vValorTotal_L1,
			    vValorConvenio_L1,
			    vCodIntegrante_L1,
			    vCodIsapre_L1);

	if vCodError_03_L1 = 'S' then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := vError_03_L1;
	  Return;
	end if;

	ADMBENE.Ben_Bonificador12(v_Arreglo_intgte,
				  v_Arreglo,
				  vCodIntegrante_L1,
				  v_idafil,
				  v_corr,
				  v_fechaemision,
				  v_idprestador,
				  v_iddireccion,
				  vCodIsapre_L1,
				  vCantidad_L1,
				  v_tipopresta,
				  null,
				  'RB',
				  4,
				  vValorConvenio_L1, --vValorTotal_L1,
				  vValorBonif_L1,
				  vValorCopago_L1,
				  vValorAran_L1,
				  v_idpropio,
				  vLinea_L1);

	if vLinea_L1 is not null then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := '*B*' || substr(vLinea_L1, 1, 27);
	  Return;
	end if;

	if v_existecredito then

	  Out_extTipoBonif1(j) := 0;
	  Out_extCopago1(j) := 0;
	  dbms_output.put_line('CreditoDispo1:' || v_disponible);

	  if v_disponible > 1 then
	    Out_extCopago1(j) := least(v_disponible,
				       (vValorConvenio_L1 * vCantidad_L1 -
				       vValorBonif_L1));

	    if Out_extCopago1(j) > 0 then
	      Out_extTipoBonif1(j) := 9;
	    else
	      Out_extTipoBonif1(j) := 0;
	    end if;

	    v_disponible := v_disponible - Out_extCopago1(j);

	  else
	    Out_extTipoBonif1(j) := 0;
	    Out_extCopago1(j) := 0;

	  end if;

	  Out_extValorPrestacion(j) := vValorConvenio_L1 * vCantidad_L1;
	  Out_extAporteFinanciador(j) := vValorBonif_L1;
	  Out_extCopago(j) := (vValorConvenio_L1 * vCantidad_L1 -
			      vValorBonif_L1);
	  Out_extInternoIsa(j) := ' ';
	  Out_extTipoBonif2(j) := 0;
	  Out_extCopago2(j) := 0;
	  Out_extTipoBonif3(j) := 0;
	  Out_extCopago3(j) := 0;
	  Out_extTipoBonif4(j) := 0;
	  Out_extCopago4(j) := 0;
	  Out_extTipoBonif5(j) := 0;
	  Out_extCopago5(j) := 0;

	else
	  /* no existe credito */

	  Out_extValorPrestacion(j) := vValorConvenio_L1 * vCantidad_L1;
	  Out_extAporteFinanciador(j) := vValorBonif_L1;
	  Out_extCopago(j) := vValorConvenio_L1 * vCantidad_L1 -
			      vValorBonif_L1;
	  Out_extTipoBonif1(j) := 0;
	  Out_extCopago1(j) := 0;
	  Out_extInternoIsa(j) := ' ';
	  Out_extTipoBonif2(j) := 0;
	  Out_extCopago2(j) := 0;
	  Out_extTipoBonif3(j) := 0;
	  Out_extCopago3(j) := 0;
	  Out_extTipoBonif4(j) := 0;
	  Out_extCopago4(j) := 0;
	  Out_extTipoBonif5(j) := 0;
	  Out_extCopago5(j) := 0;

	end if;

	j := j + 1;

      End Loop;

    end if;

    dbms_output.put_line('fin');

  END RBLValorVari;
End RBLValorVari_Pkg;

1315 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.4.0 - Production
