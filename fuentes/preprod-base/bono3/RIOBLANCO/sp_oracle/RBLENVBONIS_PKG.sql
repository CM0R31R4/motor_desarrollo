
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 26 18:07:41 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.4.0 - Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package RBLEnvBonIs_Pkg As
PROCEDURE RBLEnvBonIs	/*Envia Bonos, Fundacion */
    ( SRV_Message		     In Out	Varchar2
	, In_extCodFinanciador 	  		 In	   Number
    , In_extHomNumeroConvenio 		 In	   Varchar2
	, In_extHomLugarConvenio 		 In	   Varchar2
	, In_extSucVenta 				 In	   Varchar2
    , In_extRutConvenio 			 In	   Varchar2
	, In_extRutAsociado 			 In	   Varchar2
    , In_extNomPrestador			 In	   Varchar2
	, In_extRutTratante 			 In	   Varchar2
	, In_extEspecialidad 			 In	   Varchar2
    , In_extRutBeneficiario 		 In	   Varchar2
	, In_extRutCotizante 			 In	   Varchar2
	, In_extRutAcompanante 			 In	   Varchar2
	, In_extRutEmisor 				 In	   Varchar2
	, In_extRutCajero 				 In	   Varchar2
	, In_extCodigoDiagnostico 		 In	   Varchar2
    , In_extDescuentoxPlanilla 		 In	   Varchar2
	, In_extMontoExcedente			 In	   Number
	, In_extFechaEmision 			 In	   Varchar2
	, In_extNivelConvenio 			 In	   Number
	, In_extFolioFinanciador 		 In	   Number
	, In_extMontoValorTotal 		 In	   Number
    , In_extMontoAporteTotal 		 In	   Number
	, In_extMontoCopagoTotal 		 In	   Number
	, In_extNumOperacion 			 In	   Number
	, In_extCorrPrestacion 			 In	   Number
	, In_extTipoSolicitud 			 In	   Number
	, In_extFechaInicio 			 In	   Varchar2
	, In_extUrgencia 				 In	   Varchar2
	, In_extPlan 				     In        Varchar2
	, In_extLista1 				 	 In	   Varchar2
	, In_extLista2 				 	 In	   Varchar2
	, In_extLista3 				 	 In	   Varchar2
	, Out_extCodError				 Out	    Varchar2
    , Out_extMensajeError			 Out	    Varchar2
    );
end RBLEnvBonis_Pkg;

39 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     RBLEnvBonIs_Pkg As
  Procedure RBLEnvBonIs(SRV_Message		 In Out Varchar2,
			In_extCodFinanciador	 In Number,
			In_extHomNumeroConvenio  In Varchar2,
			In_extHomLugarConvenio	 In Varchar2,
			In_extSucVenta		 In Varchar2,
			In_extRutConvenio	 In Varchar2,
			In_extRutAsociado	 In Varchar2,
			In_extNomPrestador	 In Varchar2,
			In_extRutTratante	 In Varchar2,
			In_extEspecialidad	 In Varchar2,
			In_extRutBeneficiario	 In Varchar2,
			In_extRutCotizante	 In Varchar2,
			In_extRutAcompanante	 In Varchar2,
			In_extRutEmisor 	 In Varchar2,
			In_extRutCajero 	 In Varchar2,
			In_extCodigoDiagnostico  In Varchar2,
			In_extDescuentoxPlanilla In Varchar2,
			In_extMontoExcedente	 In Number,
			In_extFechaEmision	 In Varchar2,
			In_extNivelConvenio	 In Number,
			In_extFolioFinanciador	 In Number,
			In_extMontoValorTotal	 In Number,
			In_extMontoAporteTotal	 In Number,
			In_extMontoCopagoTotal	 In Number,
			In_extNumOperacion	 In Number,
			In_extCorrPrestacion	 In Number,
			In_extTipoSolicitud	 In Number,
			In_extFechaInicio	 In Varchar2,
			In_extUrgencia		 In Varchar2,
			In_extPlan		 In Varchar2,
			In_extLista1		 In Varchar2,
			In_extLista2		 In Varchar2,
			In_extLista3		 In Varchar2,
			Out_extCodError 	 Out Varchar2,
			Out_extMensajeError	 Out Varchar2) As

    vnum    Number;
    vEstado varchar2(1);

    v_idafil NUMBER;
    v_corr   NUMBER;

    v_RutBen number;
    v_DVBen  varchar2(1);

    vCodError_01 VARCHAR2(1000);
    vError_01	 VARCHAR2(1000);

    vCodError_02 VARCHAR2(1000);
    vError_02	 VARCHAR2(1000);

    vRutPrestador Number;
    vDVPrestador  Varchar2(1);

    miARREGLO admbene.BEN_PCK_TIPO_DATOS.ArregloRep12;

    v_codplan varchar2(255);

    v_Error varchar2(1000);

    v_fec_ini_acu date;
    v_fec_ter_acu date;

    v_valor_prest_uf number;
    v_bonif_maxima   number;

    vCodIsapreL1_1 NUMBER;
    vCantidadL1_1  NUMBER;
    vTotalL1_1	   NUMBER;
    vBonifL1_1	   NUMBER;
    vCopagoL1_1    NUMBER;
    vCreditoL1_1   NUMBER;
    vExcedenteL1_1 NUMBER;
    vAyuAsistL1_1  NUMBER;
    vSegComplL1_1  NUMBER;
    vRecargoL1_1   varchar2(3);
    vCodInteL1_1   varchar2(10);
    vCodIsapreL1_2 NUMBER;
    vCantidadL1_2  NUMBER;
    vTotalL1_2	   NUMBER;
    vBonifL1_2	   NUMBER;
    vCopagoL1_2    NUMBER;
    vCreditoL1_2   NUMBER;
    vExcedenteL1_2 NUMBER;
    vAyuAsistL1_2  NUMBER;
    vSegComplL1_2  NUMBER;
    vRecargoL1_2   varchar2(3);
    vCodInteL1_2   varchar2(10);
    vCodErrorL1    varchar2(100);
    vErrorL1	   varchar2(100);

    vCodIsapreL2_1 NUMBER;
    vCantidadL2_1  NUMBER;
    vTotalL2_1	   NUMBER;
    vBonifL2_1	   NUMBER;
    vCopagoL2_1    NUMBER;
    vCreditoL2_1   NUMBER;
    vExcedenteL2_1 NUMBER;
    vAyuAsistL2_1  NUMBER;
    vSegComplL2_1  NUMBER;
    vRecargoL2_1   varchar2(3);
    vCodInteL2_1   varchar2(10);
    vCodIsapreL2_2 NUMBER;
    vCantidadL2_2  NUMBER;
    vTotalL2_2	   NUMBER;
    vBonifL2_2	   NUMBER;
    vCopagoL2_2    NUMBER;
    vCreditoL2_2   NUMBER;
    vExcedenteL2_2 NUMBER;
    vAyuAsistL2_2  NUMBER;
    vSegComplL2_2  NUMBER;
    vRecargoL2_2   varchar2(3);
    vCodInteL2_2   varchar2(10);
    vCodErrorL2    varchar2(100);
    vErrorL2	   varchar2(100);

    vCodIsapreL3_1 NUMBER;
    vCantidadL3_1  NUMBER;
    vTotalL3_1	   NUMBER;
    vBonifL3_1	   NUMBER;
    vCopagoL3_1    NUMBER;
    vCreditoL3_1   NUMBER;
    vExcedenteL3_1 NUMBER;
    vAyuAsistL3_1  NUMBER;
    vSegComplL3_1  NUMBER;
    vRecargoL3_1   varchar2(3);
    vCodInteL3_1   varchar2(10);
    vCodIsapreL3_2 NUMBER;
    vCantidadL3_2  NUMBER;
    vTotalL3_2	   NUMBER;
    vBonifL3_2	   NUMBER;
    vCopagoL3_2    NUMBER;
    vCreditoL3_2   NUMBER;
    vExcedenteL3_2 NUMBER;
    vAyuAsistL3_2  NUMBER;
    vSegComplL3_2  NUMBER;
    vRecargoL3_2   varchar2(3);
    vCodInteL3_2   varchar2(10);
    vCodErrorL3    varchar2(100);
    vErrorL3	   varchar2(100);

    v_total	     number;
    v_cantidad	     number;
    v_totalbonif     number;
    v_totalcopago    number;
    v_totalcredito   number;
    v_totalexcedente number;
    v_totalayuda     number;
    v_totalseguroc   number;

    v_fecact	date;
    v_titcta	number;
    v_codmov	varchar2(255);
    v_secctades number;
    v_valormov	number;
    res 	boolean;
    v_saldo	number;
    --In_extLista1 varchar2(255);

  BEGIN

    --In_extLista1  :='0000101001|0 |0101001	    | |01|0009000|0007188|0001812|		 |0|0000000|0|0000000|0|0000000|0|0000000|0|0000000|0000101001|0 |0101001	 | |01|0009000|0007188|0001812| 	      |0|0000000|0|0000000|0|0000000|0|0000000|0|0000000|';

    dbms_output.put_line('partieron0');
    SRV_Message := '1000000';

    Out_extCodError	:= ' ';
    Out_extMensajeError := ' ';

    v_total	     := 0;
    v_cantidad	     := 0;
    v_totalbonif     := 0;
    v_totalcopago    := 0;
    v_totalcredito   := 0;
    v_totalexcedente := 0;
    v_totalayuda     := 0;
    v_totalseguroc   := 0;

    -- Inserto en tabla de control trama que llega

    Begin
      Insert into ADMIMED.IMED_ENVBONIS
	(EXTCODFINANCIADOR, --	   NUMBER	     NULL,
	 EXTHOMNUMEROCONVENIO, --  VARCHAR2(15)      NULL,
	 EXTHOMLUGARCONVENIO, --   VARCHAR2(10)      NULL,
	 EXTSUCVENTA, --	   VARCHAR2(10)      NULL,
	 EXTRUTCONVENIO, --	   VARCHAR2(12)      NULL,
	 EXTRUTASOCIADO, --	   VARCHAR2(12)      NULL,
	 EXTNOMPRESTADOR, --	   VARCHAR2(40)      NULL,
	 EXTRUTTRATANTE, --	   VARCHAR2(10)      NULL,
	 EXTESPECIALIDAD, --	   VARCHAR2(10)      NULL,
	 EXTRUTBENEFICIARIO, --    VARCHAR2(12)      NULL,
	 EXTRUTCOTIZANTE, --	   VARCHAR2(12)      NULL,
	 EXTRUTACOMPANANTE, --	   VARCHAR2(12)      NULL,
	 EXTRUTEMISOR, --	   VARCHAR2(12)      NULL,
	 EXTRUTCAJERO, --	   VARCHAR2(12)      NULL,
	 EXTCODIGODIAGNOSTICO, --  VARCHAR2(10)      NULL,
	 EXTDESCUENTXOPLANILLA, -- VARCHAR2(1)	     NULL,
	 EXTMONTOEXCEDENTE, --	   NUMBER	     NULL,
	 EXTFECHAEMISION, --	   VARCHAR2(10)      NULL,
	 EXTNIVELCONVENIO, --	   NUMBER	     NULL,
	 EXTFOLIOFINANCIADOR, --   NUMBER	     NULL,
	 EXTMONTOVALORTOTAL, --    NUMBER	     NULL,
	 EXTMONTOAPORTETOTAL, --   NUMBER	     NULL,
	 EXTMONTOCOPAGOTOTAL, --   NUMBER	     NULL,
	 EXTNUMOPERACION, --	   NUMBER	     NULL,
	 EXTCORRPRESTACION, --	   NUMBER	     NULL,
	 EXTTIPOSOLICITUD, --	   NUMBER	     NULL,
	 EXTFECHAINICIO, --	   VARCHAR2(10)      NULL,
	 EXTURGENCIA, --	   VARCHAR2(1)	     NULL,
	 EXTPLAN, --		   VARCHAR2(15)      NULL,
	 EXTLISTA1, --		   VARCHAR2(255)     NULL,
	 EXTLISTA2, --		   VARCHAR2(255)     NULL,
	 EXTLISTA3, --		   VARCHAR2(255)     NULL
	 FECHA_RECEP)
      VALUES
	(In_extCodFinanciador, --	   In	     Number
	 In_extHomNumeroConvenio, --	 In	   Varchar2
	 In_extHomLugarConvenio, --	In	  Varchar2
	 In_extSucVenta, --	    In	      Varchar2
	 In_extRutConvenio, --	     In        Varchar2
	 In_extRutAsociado, --	      In	Varchar2
	 In_extNomPrestador, --      In        Varchar2
	 In_extRutTratante, --	      In	Varchar2
	 In_extEspecialidad, --       In	Varchar2
	 In_extRutBeneficiario, --     In	 Varchar2
	 In_extRutCotizante, --       In	Varchar2
	 In_extRutAcompanante, --	In	  Varchar2
	 In_extRutEmisor, --	      In	Varchar2
	 In_extRutCajero, --	      In	Varchar2
	 In_extCodigoDiagnostico, --	  In	    Varchar2
	 In_extDescuentoxPlanilla, --	   In	     Varchar2
	 In_extMontoExcedente, --	In	  Number
	 In_extFechaEmision, --to_date(In_extFechaEmision,'yyyymmdd'),--	In	  date
	 In_extNivelConvenio, --      In	Number
	 In_extFolioFinanciador, --	In	  Number
	 In_extMontoValorTotal, --	In	  Number
	 In_extMontoAporteTotal, --	 In	   Number
	 In_extMontoCopagoTotal, --	In	  Number
	 In_extNumOperacion, --       In	Number
	 In_extCorrPrestacion, --	In	  Number
	 In_extTipoSolicitud, --	In	  Number
	 In_extFechaInicio, --to_date(In_extFechaInicio,'yyyymmdd'),--	      In	date
	 In_extUrgencia, --	    In	      Varchar2
	 In_extPlan, -- 	    In	      Varchar2
	 In_extLista1, --	    In	      Varchar2
	 In_extLista2, --	    In	      Varchar2
	 In_extLista3, --	    In	      Varchar2
	 SYSDATE);
      commit;
    Exception
      WHEN OTHERS THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Trama con error formato';
	Return;
    End;

    dbms_output.put_line('partieron');

    -- Valido codigo financiador
    if In_extCodFinanciador <> 68 then
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'Codigo Financiador Erroneo';
      Return;
    end if;

    -- Valido folio financiador
    Select count(*)
      into vnum
      From Ben_Beneficio
     Where Num = In_extFolioFinanciador;

    if nvl(vnum, 0) <> 0 then
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'Folio no valido';
      Return;
    end if;

    --4--

    -- Valido folio en folios entregados a IMED
    Begin
      Select i.estado
	into vEstado
	From admimed.imed_folios i
       Where i.folio = In_extFolioFinanciador;
    Exception
      When NO_DATA_FOUND Then
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Folio IMED invalido';
	Return;
    End;

    --5--

    if vEstado = 'U' then
      -- folio entregado , pero no utilizado aun
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'Folio IMED ya utilizado';
      Return;
    end if;
    dbms_output.put_line('ini vali prestador');
    -- valido prestador
    -- valido domicilio prestador

    ADMIMED.ValidoPrestador(In_extHomNumeroConvenio,
			    In_extHomLugarConvenio,
			    In_extSucVenta,
			    In_extRutConvenio,
			    In_extFechaEmision,
			    --to_date(In_extFechaEmision,'yyyymmdd'),--iFecha IN date,
			    vRutPrestador, --oRutPrestador OUT number,
			    vDVPrestador, --oDVPrestador OUT varchar2,
			    vCodError_01,
			    vError_01);
    --OCHO--

    if vCodError_01 = 'S' then
      Out_extCodError	  := 'N';
      Out_extMensajeError := vError_01;
      Return;
    end if;

    -- valido beneficiario
    ADMIMED.ValidoBeneficiario(In_extRutBeneficiario,
			       In_extFechaEmision,
			       --to_date(In_extFechaEmision,'YYYYMMDD'),
			       v_idafil,
			       v_corr,
			       v_RutBen,
			       v_DVBen,
			       v_CodPlan,
			       vCodError_02,
			       vError_02);

    --NUEVE--

    if vCodError_02 = 'S' then
      Out_extCodError	  := 'N';
      Out_extMensajeError := vError_02;
      Return;
    end if;

    admbene.BEN_CREA_ARREGLO_TOPES12F(miArreglo,
				      v_codplan,
				      v_idafil,
				      v_corr,
				      In_extFechaEmision,
				      --   TO_DATE(In_extFechaEmision,'YYYYMMDD'),
				      v_fec_ini_acu,
				      v_fec_ter_acu,
				      v_error);
    IF NOT v_error IS NULL THEN
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'ERROR EN CREAC.TOPES';
      Return;
    END IF;

    --CARGA TOPES UTILIZADOS CON INFORMACION DE TOPES POR BENEFICIARIO
    BEN_CARGA_ARREGLO_TOPES_UTI12(miArreglo,
				  v_idafil,
				  v_corr,
				  In_extFechaEmision,
				  --		    TO_DATE(In_extFechaEmision,'YYYYMMDD'),
				  v_codplan,
				  v_error);

    IF NOT V_ERROR IS NULL THEN
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'ERROR EN REC. DE TOPES';
      Return;
    END IF;

    dbms_output.put_line('ini insert ben_beneficio');
    -- aca creo documento
    INSERT INTO ADMBENE.BEN_BENEFICIO
      (NUM, --		   NUMBER	 NOT NULL,
       FEC_EMIS, --	   DATE 	 NOT NULL,
       VALOR, --	   NUMBER	     NULL,
       VAL_BON, --	   NUMBER	     NULL,
       EMITIDO_POR, --	   VARCHAR2(30)      NULL,
       IMPRESO_POR, --	   VARCHAR2(30)      NULL,
       ANULADO_POR, --	   VARCHAR2(30)      NULL,
       MOTIVO_ANUL, --	   NUMBER(5)	     NULL,
       TRASP_POR, --	   VARCHAR2(50)      NULL,
       FEC_ANULACION, --   DATE 	     NULL,
       MENS_PREST, --	   VARCHAR2(300)     NULL,
       OBS_CONT, --	   VARCHAR2(300)     NULL,
       TIPO, -- 	   VARCHAR2(4)	     NULL,
       tipo_orden,
       EXCEDENTE, --	   NUMBER(15)	     NULL,
       MOROSIDAD, --	   VARCHAR2(1)	     NULL,
       BE_TO_COD, --	   VARCHAR2(4)	 NOT NULL,
       BEEO_COD, --	   VARCHAR2(240) NOT NULL,
       BB_ID_AFIL, --	   NUMBER(10)	 NOT NULL,
       BB_CORR, --	   NUMBER(5)	 NOT NULL,
       BTC_COD_PAGO, --    VARCHAR2(4)	 NOT NULL,
       BEOA_NUM, --	   NUMBER	     NULL,
       CREDITO, --	   NUMBER(15)	     NULL,
       RUT_PREST, --	   NUMBER(12)	     NULL,
       CVDO_ID_DOMI, --   NUMBER(8)	    NULL,
       DV_PREST, --	   VARCHAR2(1)	     NULL,
       CONVENIO, --	   VARCHAR2(1)	     NULL,
       RUT_SOLIC, --	   NUMBER(10)	     NULL,
       DV_SOLIC, --	   VARCHAR2(1)	     NULL,
       NOM_SOLIC, --	   VARCHAR2(250)     NULL,
       VALOR_AUX, --	   NUMBER(15)	     NULL,
       FEC_PAGO, --	   DATE 	     NULL,
       NOM_CHEQUE, --	   VARCHAR2(50)      NULL,
       RUT_CHEQUE, --	   NUMBER(10)	     NULL,
       APE_PAT_CHEQUE, --  VARCHAR2(50)      NULL,
       APE_MAT_CHEQUE, --  VARCHAR2(50)      NULL,
       DIR_CHEQUE, --	   VARCHAR2(250)     NULL,
       MANUAL, --	   VARCHAR2(1)	     NULL,
       CREADO_POR, --	   VARCHAR2(30)      NULL,
       ACT_POR, --	   VARCHAR2(30)      NULL,
       FEC_CREACION, --    DATE 	     NULL,
       FEC_ULT_ACT, --	   DATE 	     NULL,
       PROH_CARGA, --	   VARCHAR2(1)	     NULL,
       CVCA_ID, --	   NUMBER(4)	     NULL,
       TIPO_PAGO, --	   VARCHAR2(3)	     NULL,
       CVSP_CVPS_RUT, --   NUMBER(10)	     NULL,
       CVSP_CVST_RUT, --   NUMBER(10)	     NULL,
       PPFB_ID_FB, --	   NUMBER	     NULL,
       MONTO_CRED_NBON, -- NUMBER(15)	     NULL,
       CRCO_TIPO, --	   VARCHAR2(15)      NULL,
       CRCO_COD,
       TCOBER) --	 VARCHAR2(15)	   NULL
    VALUES
      (In_extFolioFinanciador, -- SECUENCIA PARA CREAR BENEFICIOS
       In_extFechaEmision,
       --    to_date(In_extFechaEmision,'YYYYMMDD'), -- FECHA DE EMISION CORRESPONDE A FECHA CREACION. EN EL DETALLE ESTA LA FECHA DE LA COMPRA
       0, -- VALOR PRESTACION. POR EL MOMENTO 0, CUANDO SE CARGUEN LOS DATOS SE ACTUALIZA
       0, -- VALOR BONIFICACION. POR EL MOMENTO 0, CUANDO SE CARGUEN LOS DATOS SE ACTUALIZA,
       In_extRutEmisor, -- USUARIO EMISION
       In_extRutCajero, -- USUARIO IMPRESION
       NULL, -- USAURIO ANULACION
       NULL, -- MOTIVO ANULACION
       NULL, -- TRASPASADO POR
       NULL, -- fecha anulacion
       NULL, -- MENSAJE PARA PRESTADOR
       NULL, --MENSAJE PARA CONTRALORIA
       'OATE',
       'IMED', -- TIPO "FARC" FARMACIA COMPUTACIONAL
       NULL, -- EXCEDENTE
       NULL, -- MOROSIDAD ---> HAY QUE SACAR ESTE DATO
       'A', -- CODIGO TIPO DE LA ORDEN "A" AMBULATORIA
       'INGR', -- ESTADO DE LA ORDEN
       v_idafil, --IDENTIFICADOR DEL AFILIADO
       v_corr, -- correlativo del beneficiario
       'CP1', -- CODIGO DE PAGO. SE DEBE ACTUALIZAR MAS ADELANTE
       NULL, -- beoa_num  NO SE UTILIZA AL PARECER
       0, -- CREDITO. SE ACTUALIZA DESPUES
       In_extHomNumeroConvenio, -- rut del prestador
       In_extHomLugarConvenio, -- ID DEL DOMICILIO. SI SE CAMBIA EL FORMATO MAS ADELANTE SE PUEDE POBLAR ESTE DATO
       NULL, -- DV del rut prestador
       NULL, -- convenio
       NULL, -- rut solicitante
       NULL, -- dv solicitante
       NULL, -- nombre solicitante
       NULL, -- valor aux
       NULL, -- fecha pago
       NULL, -- nombre cheque
       NULL, -- rut cheque
       NULL, -- ape pat cheque
       NULL, -- ape mat cheque
       NULL, -- dir cheque
       NULL, -- MANUAL
       user, -- creado por
       user, -- actualizado por
       sysdate, -- fecha creac
       sysdate, -- fecha act
       NULL, -- proh carga ---> actualizar
       NULL, -- arancel
       NULL, -- identificador tipo pago
       In_extHomNumeroConvenio, -- rut del prestador
       NULL, -- rut del medico
       NULL, -- identificador pago a prestadores
       NULL, -- datos para creditos por prestaciones no bonificadas
       NULL, --
       NULL,
       'RB');

    -- revisamos primera lista
    ADMIMED.ValidoLista2(In_extHomNumeroConvenio, --iRutConvenio IN NUMBER,
			 In_extHomLugarConvenio, --iDomicilio IN NUMBER,
			 v_idafil, --iIdAfil  IN NUMBER,
			 v_corr, --iCorr IN NUMBER,
			 In_extFechaEmision,
			 --TO_DATE(In_extFechaEmision,'YYYYMMDD'),	 --iFecha IN DATE,
			 In_extLista1, --iLista IN varchar2,
			 vCodIsapreL1_1, -- OUT NUMBER,
			 vCantidadL1_1, -- OUT NUMBER,
			 vTotalL1_1, -- OUT NUMBER,
			 vBonifL1_1, -- OUT NUMBER,
			 vCopagoL1_1, -- OUT NUMBER,
			 vCreditoL1_1, -- OUT NUMBER,
			 vExcedenteL1_1, -- OUT NUMBER,
			 vAyuAsistL1_1, -- OUT NUMBER,
			 vSegComplL1_1, -- OUT NUMBER,
			 vRecargoL1_1, -- OUT varchar2,
			 vCodInteL1_1, -- OUT varchar2,
			 vCodIsapreL1_2, -- OUT NUMBER,
			 vCantidadL1_2, -- OUT NUMBER,
			 vTotalL1_2, -- OUT NUMBER,
			 vBonifL1_2, -- OUT NUMBER,
			 vCopagoL1_2, -- OUT NUMBER,
			 vCreditoL1_2, -- OUT NUMBER,
			 vExcedenteL1_2, -- OUT NUMBER,
			 vAyuAsistL1_2, -- OUT NUMBER,
			 vSegComplL1_2, -- OUT NUMBER,
			 vRecargoL1_2, -- OUT varchar2,
			 vCodInteL1_2, -- OUT varchar2,
			 vCodErrorL1, -- OUT varchar2,
			 vErrorL1); -- OUT VARCHAR2) is

    IF NOT vErrorL1 IS NULL THEN
      Out_extCodError	  := 'N';
      Out_extMensajeError := substr(vErrorL1, 1, 30); --'ERROR EN LISTA 1';
      rollback;
      Return;
    END IF;

    dbms_output.put_line('CodisapreL1_1:' || vCodIsapreL1_1);
    dbms_output.put_line('CreditoL1_1:' || vCreditoL1_1);

    IF vCodIsapreL1_1 <> 0 then
      dbms_output.put_line('OK CodisapreL1_1:' || vCodIsapreL1_1);
      dbms_output.put_line('plan:' || v_codplan);
      dbms_output.put_line('fecha:' || In_extFechaEmision);

      BEN_TRANSFORMA_PESOS_ENUF(v_codplan,
				In_extFechaEmision,
				--		to_date(In_extFechaEmision,'YYYYMMDD'),
				vBonifL1_1,
				v_valor_prest_uf,
				v_error);

      IF NOT v_error IS NULL THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Error Bonif. L1 detalle 1(1)';
	rollback;
	Return;
      END IF;

      v_bonif_maxima := 99999999;

      BEN_BONIF_TIPAGRUP_PLAN_IDPR12(miArreglo,
				     v_codplan,
				     vCodIsapreL1_1,
				     'A',
				     v_valor_prest_uf, -- valor prestacion
				     v_fec_ini_acu,
				     v_fec_ter_acu,
				     'RB',
				     v_idafil,
				     v_corr,
				     v_bonif_maxima,
				     v_error);

      IF NOT v_error IS NULL THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Error Bonif. L1 detalle 1(2)';
	rollback;
	Return;
      END IF;

      BEN_ACTUALIZA_TOPES_ARREGLO12(miarreglo,
				    v_idafil,
				    v_corr,
				    vCantidadL1_1,
				    v_valor_prest_uf);

      insert into ADMBENE.BEN_D_BENEFICIO
	(ID_DET, --NUMBER(10)	 NOT NULL,
	 BEOA_NUM, --NUMBER	   NOT NULL,
	 BONIF, --NUMBER(15)	NOT NULL,
	 NUM, --NUMBER(15)    NOT NULL,
	 VALOR, --NUMBER(15,2)	NOT NULL,
	 VALOR_TOTAL, --NUMBER(15)	  NULL,
	 HORARIO, --VARCHAR2(3)   NOT NULL,
	 AYU_ASIST, --NUMBER(15)	NULL,
	 SEGURO_COMPL, --NUMBER(15)	   NULL,
	 BEBPM_ID_BOL, --NUMBER 	   NULL,
	 PMAE_ID_PREST, --NUMBER	NOT NULL,
	 BEIN_COD --VARCHAR2(4)       NULL,
	 )
      values
	(ADMBENE.BEN_D_ORS_AT_SEQ.NEXTVAL,
	 In_extFolioFinanciador,
	 vBonifL1_1,
	 vCantidadL1_1,
	 vTotalL1_1 / vCantidadL1_1,
	 vTotalL1_1,
	 vRecargoL1_1,
	 vAyuAsistL1_1,
	 0,
	 null,
	 vCodIsapreL1_1,
	 vCodInteL1_1);

      v_total	       := v_total + vTotalL1_1;
      v_cantidad       := v_cantidad + vCantidadL1_1;
      v_totalbonif     := v_totalbonif + vBonifL1_1;
      v_totalcopago    := v_totalcopago + vCopagoL1_1;
      v_totalcredito   := v_totalcredito + vCreditoL1_1;
      v_totalexcedente := v_totalexcedente + vExcedenteL1_1;
      v_totalayuda     := v_totalayuda + vAyuAsistL1_1;
      v_totalseguroc   := v_totalseguroc + vSegComplL1_1;

    end if;

    -- Lista 1 , Segundo Elemento

    IF vCodIsapreL1_2 <> 0 then

      BEN_TRANSFORMA_PESOS_ENUF(v_codplan,
				In_extFechaEmision,
				--to_date(In_extFechaEmision,'YYYYMMDD'),
				vBonifL1_2,
				v_valor_prest_uf,
				v_error);

      IF NOT v_error IS NULL THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Error Bonif. L1 detalle 2(1)';
	rollback;
	Return;
      END IF;

      v_bonif_maxima := 99999999;

      BEN_BONIF_TIPAGRUP_PLAN_IDPR12(miArreglo,
				     v_codplan,
				     vCodIsapreL1_2,
				     'A',
				     v_valor_prest_uf, -- valor prestacion
				     v_fec_ini_acu,
				     v_fec_ter_acu,
				     'RB',
				     v_idafil,
				     v_corr,
				     v_bonif_maxima,
				     v_error);

      IF NOT v_error IS NULL THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Error Bonif. L1 detalle 2(2)';
	rollback;
	Return;
      END IF;

      BEN_ACTUALIZA_TOPES_ARREGLO12(miarreglo,
				    v_idafil,
				    v_corr,
				    vCantidadL1_2,
				    v_valor_prest_uf);

      insert into ADMBENE.BEN_D_BENEFICIO
	(ID_DET, --NUMBER(10)	 NOT NULL,
	 BEOA_NUM, --NUMBER	   NOT NULL,
	 BONIF, --NUMBER(15)	NOT NULL,
	 NUM, --NUMBER(15)    NOT NULL,
	 VALOR, --NUMBER(15,2)	NOT NULL,
	 VALOR_TOTAL, --NUMBER(15)	  NULL,
	 HORARIO, --VARCHAR2(3)   NOT NULL,
	 AYU_ASIST, --NUMBER(15)	NULL,
	 SEGURO_COMPL, --NUMBER(15)	   NULL,
	 BEBPM_ID_BOL, --NUMBER 	   NULL,
	 PMAE_ID_PREST, --NUMBER	NOT NULL,
	 BEIN_COD --VARCHAR2(4)       NULL,
	 )
      values
	(ADMBENE.BEN_D_ORS_AT_SEQ.NEXTVAL,
	 In_extFolioFinanciador,
	 vBonifL1_2,
	 vCantidadL1_2,
	 vTotalL1_2 / vCantidadL1_2,
	 vTotalL1_2,
	 vRecargoL1_2,
	 vAyuAsistL1_2,
	 0,
	 null,
	 vCodIsapreL1_2,
	 vCodInteL1_2);

      v_total	       := v_total + vTotalL1_2;
      v_cantidad       := v_cantidad + vCantidadL1_2;
      v_totalbonif     := v_totalbonif + vBonifL1_2;
      v_totalcopago    := v_totalcopago + vCopagoL1_2;
      v_totalcredito   := v_totalcredito + vCreditoL1_2;
      v_totalexcedente := v_totalexcedente + vExcedenteL1_2;
      v_totalayuda     := v_totalayuda + vAyuAsistL1_2;
      v_totalseguroc   := v_totalseguroc + vSegComplL1_2;

    end if;

    /*******************************************************************************************/
    /* INICIAMOS RECORRIDO POR LISTA 2							       */
    /*******************************************************************************************/

    -- revisamos segunda lista
    ADMIMED.ValidoLista2(In_extHomNumeroConvenio, --iRutConvenio IN NUMBER,
			 In_extHomLugarConvenio, --iDomicilio IN NUMBER,
			 v_idafil, --iIdAfil  IN NUMBER,
			 v_corr, --iCorr IN NUMBER,
			 In_extFechaEmision,
			 --to_date(In_extFechaEmision,'YYYYMMDD'),	 --iFecha IN DATE,
			 In_extLista2, --iLista IN varchar2,
			 vCodIsapreL2_1, -- OUT NUMBER,
			 vCantidadL2_1, -- OUT NUMBER,
			 vTotalL2_1, -- OUT NUMBER,
			 vBonifL2_1, -- OUT NUMBER,
			 vCopagoL2_1, -- OUT NUMBER,
			 vCreditoL2_1, -- OUT NUMBER,
			 vExcedenteL2_1, -- OUT NUMBER,
			 vAyuAsistL2_1, -- OUT NUMBER,
			 vSegComplL2_1, -- OUT NUMBER,
			 vRecargoL2_1, -- OUT varchar2,
			 vCodInteL2_1, -- OUT varchar2,
			 vCodIsapreL2_2, -- OUT NUMBER,
			 vCantidadL2_2, -- OUT NUMBER,
			 vTotalL2_2, -- OUT NUMBER,
			 vBonifL2_2, -- OUT NUMBER,
			 vCopagoL2_2, -- OUT NUMBER,
			 vCreditoL2_2, -- OUT NUMBER,
			 vExcedenteL2_2, -- OUT NUMBER,
			 vAyuAsistL2_2, -- OUT NUMBER,
			 vSegComplL2_2, -- OUT NUMBER,
			 vRecargoL2_2, -- OUT varchar2,
			 vCodInteL2_2, -- OUT varchar2,
			 vCodErrorL2, -- OUT varchar2,
			 vErrorL2); -- OUT VARCHAR2) is

    IF NOT vErrorL2 IS NULL THEN
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'ERROR EN LISTA 2';
      rollback;
      Return;
    END IF;

    IF vCodIsapreL2_1 <> 0 then

      BEN_TRANSFORMA_PESOS_ENUF(v_codplan,
				In_extFechaEmision,
				--to_date(In_extFechaEmision,'YYYYMMDD'),
				vBonifL2_1,
				v_valor_prest_uf,
				v_error);

      IF NOT v_error IS NULL THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Error Bonif. L2 detalle 1(1)';
	rollback;
	Return;
      END IF;

      v_bonif_maxima := 99999999;

      BEN_BONIF_TIPAGRUP_PLAN_IDPR12(miArreglo,
				     v_codplan,
				     vCodIsapreL2_1,
				     'A',
				     v_valor_prest_uf, -- valor prestacion
				     v_fec_ini_acu,
				     v_fec_ter_acu,
				     'RB',
				     v_idafil,
				     v_corr,
				     v_bonif_maxima,
				     v_error);

      IF NOT v_error IS NULL THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Error Bonif. L2 detalle 1(2)';
	rollback;
	Return;
      END IF;

      BEN_ACTUALIZA_TOPES_ARREGLO12(miarreglo,
				    v_idafil,
				    v_corr,
				    vCantidadL2_1,
				    v_valor_prest_uf);

      insert into ADMBENE.BEN_D_BENEFICIO
	(ID_DET, --NUMBER(10)	 NOT NULL,
	 BEOA_NUM, --NUMBER	   NOT NULL,
	 BONIF, --NUMBER(15)	NOT NULL,
	 NUM, --NUMBER(15)    NOT NULL,
	 VALOR, --NUMBER(15,2)	NOT NULL,
	 VALOR_TOTAL, --NUMBER(15)	  NULL,
	 HORARIO, --VARCHAR2(3)   NOT NULL,
	 AYU_ASIST, --NUMBER(15)	NULL,
	 SEGURO_COMPL, --NUMBER(15)	   NULL,
	 BEBPM_ID_BOL, --NUMBER 	   NULL,
	 PMAE_ID_PREST, --NUMBER	NOT NULL,
	 BEIN_COD --VARCHAR2(4)       NULL,
	 )
      values
	(ADMBENE.BEN_D_ORS_AT_SEQ.NEXTVAL,
	 In_extFolioFinanciador,
	 vBonifL2_1,
	 vCantidadL2_1,
	 vTotalL2_1 / vCantidadL2_1,
	 vTotalL2_1,
	 vRecargoL2_1,
	 vAyuAsistL2_1,
	 0,
	 null,
	 vCodIsapreL2_1,
	 vCodInteL2_1);

      v_total	       := v_total + vTotalL2_1;
      v_cantidad       := v_cantidad + vCantidadL2_1;
      v_totalbonif     := v_totalbonif + vBonifL2_1;
      v_totalcopago    := v_totalcopago + vCopagoL2_1;
      v_totalcredito   := v_totalcredito + vCreditoL2_1;
      v_totalexcedente := v_totalexcedente + vExcedenteL2_1;
      v_totalayuda     := v_totalayuda + vAyuAsistL2_1;
      v_totalseguroc   := v_totalseguroc + vSegComplL2_1;

    end if;

    -- Lista 2 , Segundo Elemento

    IF vCodIsapreL2_2 <> 0 then

      BEN_TRANSFORMA_PESOS_ENUF(v_codplan,
				In_extFechaEmision,
				--to_date(In_extFechaEmision,'YYYYMMDD'),
				vBonifL2_2,
				v_valor_prest_uf,
				v_error);

      IF NOT v_error IS NULL THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Error Bonif. L2 detalle 2(1)';
	rollback;
	Return;
      END IF;

      v_bonif_maxima := 99999999;

      BEN_BONIF_TIPAGRUP_PLAN_IDPR12(miArreglo,
				     v_codplan,
				     vCodIsapreL2_2,
				     'A',
				     v_valor_prest_uf, -- valor prestacion
				     v_fec_ini_acu,
				     v_fec_ter_acu,
				     'RB',
				     v_idafil,
				     v_corr,
				     v_bonif_maxima,
				     v_error);

      IF NOT v_error IS NULL THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Error Bonif. L2 detalle 2(2)';
	rollback;
	Return;
      END IF;

      BEN_ACTUALIZA_TOPES_ARREGLO12(miarreglo,
				    v_idafil,
				    v_corr,
				    vCantidadL2_2,
				    v_valor_prest_uf);

      insert into ADMBENE.BEN_D_BENEFICIO
	(ID_DET, --NUMBER(10)	 NOT NULL,
	 BEOA_NUM, --NUMBER	   NOT NULL,
	 BONIF, --NUMBER(15)	NOT NULL,
	 NUM, --NUMBER(15)    NOT NULL,
	 VALOR, --NUMBER(15,2)	NOT NULL,
	 VALOR_TOTAL, --NUMBER(15)	  NULL,
	 HORARIO, --VARCHAR2(3)   NOT NULL,
	 AYU_ASIST, --NUMBER(15)	NULL,
	 SEGURO_COMPL, --NUMBER(15)	   NULL,
	 BEBPM_ID_BOL, --NUMBER 	   NULL,
	 PMAE_ID_PREST, --NUMBER	NOT NULL,
	 BEIN_COD --VARCHAR2(4)       NULL,
	 )
      values
	(ADMBENE.BEN_D_ORS_AT_SEQ.NEXTVAL,
	 In_extFolioFinanciador,
	 vBonifL2_2,
	 vCantidadL2_2,
	 vTotalL2_2 / vCantidadL2_2,
	 vTotalL2_2,
	 vRecargoL2_2,
	 vAyuAsistL2_2,
	 0,
	 null,
	 vCodIsapreL2_2,
	 vCodInteL2_2);

      v_total	       := v_total + vTotalL2_2;
      v_cantidad       := v_cantidad + vCantidadL2_2;
      v_totalbonif     := v_totalbonif + vBonifL2_2;
      v_totalcopago    := v_totalcopago + vCopagoL2_2;
      v_totalcredito   := v_totalcredito + vCreditoL2_2;
      v_totalexcedente := v_totalexcedente + vExcedenteL2_2;
      v_totalayuda     := v_totalayuda + vAyuAsistL2_2;
      v_totalseguroc   := v_totalseguroc + vSegComplL2_2;

    end if;

    /*******************************************************************************************/
    /* INICIAMOS RECORRIDO POR LISTA 3							       */
    /*******************************************************************************************/

    -- revisamos segunda lista
    ADMIMED.ValidoLista2(In_extHomNumeroConvenio, --iRutConvenio IN NUMBER,
			 In_extHomLugarConvenio, --iDomicilio IN NUMBER,
			 v_idafil, --iIdAfil  IN NUMBER,
			 v_corr, --iCorr IN NUMBER,
			 In_extFechaEmision,
			 --TO_DATE(In_extFechaEmision,'YYYYMMDD'),	 --iFecha IN DATE,
			 In_extLista3, --iLista IN varchar2,
			 vCodIsapreL3_1, -- OUT NUMBER,
			 vCantidadL3_1, -- OUT NUMBER,
			 vTotalL3_1, -- OUT NUMBER,
			 vBonifL3_1, -- OUT NUMBER,
			 vCopagoL3_1, -- OUT NUMBER,
			 vCreditoL3_1, -- OUT NUMBER,
			 vExcedenteL3_1, -- OUT NUMBER,
			 vAyuAsistL3_1, -- OUT NUMBER,
			 vSegComplL3_1, -- OUT NUMBER,
			 vRecargoL3_1, -- OUT varchar2,
			 vCodInteL3_1, -- OUT varchar2,
			 vCodIsapreL3_2, -- OUT NUMBER,
			 vCantidadL3_2, -- OUT NUMBER,
			 vTotalL3_2, -- OUT NUMBER,
			 vBonifL3_2, -- OUT NUMBER,
			 vCopagoL3_2, -- OUT NUMBER,
			 vCreditoL3_2, -- OUT NUMBER,
			 vExcedenteL3_2, -- OUT NUMBER,
			 vAyuAsistL3_2, -- OUT NUMBER,
			 vSegComplL3_2, -- OUT NUMBER,
			 vRecargoL3_2, -- OUT varchar2,
			 vCodInteL3_2, -- OUT varchar2,
			 vCodErrorL3, -- OUT varchar2,
			 vErrorL3); -- OUT VARCHAR2) is

    IF NOT vErrorL3 IS NULL THEN
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'ERROR EN LISTA 3';
      rollback;
      Return;
    END IF;

    IF vCodIsapreL3_1 <> 0 then

      BEN_TRANSFORMA_PESOS_ENUF(v_codplan,
				In_extFechaEmision,
				--to_date(In_extFechaEmision,'YYYYMMDD'),
				vBonifL3_1,
				v_valor_prest_uf,
				v_error);

      IF NOT v_error IS NULL THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Error Bonif. L3 detalle 1(1)';
	rollback;
	Return;
      END IF;

      v_bonif_maxima := 99999999;

      BEN_BONIF_TIPAGRUP_PLAN_IDPR12(miArreglo,
				     v_codplan,
				     vCodIsapreL3_1,
				     'A',
				     v_valor_prest_uf, -- valor prestacion
				     v_fec_ini_acu,
				     v_fec_ter_acu,
				     'RB',
				     v_idafil,
				     v_corr,
				     v_bonif_maxima,
				     v_error);

      IF NOT v_error IS NULL THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Error Bonif. L3 detalle 1(2)';
	rollback;
	Return;
      END IF;

      BEN_ACTUALIZA_TOPES_ARREGLO12(miarreglo,
				    v_idafil,
				    v_corr,
				    vCantidadL3_1,

TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				    v_valor_prest_uf);

      insert into ADMBENE.BEN_D_BENEFICIO
	(ID_DET, --NUMBER(10)	 NOT NULL,
	 BEOA_NUM, --NUMBER	   NOT NULL,
	 BONIF, --NUMBER(15)	NOT NULL,
	 NUM, --NUMBER(15)    NOT NULL,
	 VALOR, --NUMBER(15,2)	NOT NULL,
	 VALOR_TOTAL, --NUMBER(15)	  NULL,
	 HORARIO, --VARCHAR2(3)   NOT NULL,
	 AYU_ASIST, --NUMBER(15)	NULL,
	 SEGURO_COMPL, --NUMBER(15)	   NULL,
	 BEBPM_ID_BOL, --NUMBER 	   NULL,
	 PMAE_ID_PREST, --NUMBER	NOT NULL,
	 BEIN_COD --VARCHAR2(4)       NULL,
	 )
      values
	(ADMBENE.BEN_D_ORS_AT_SEQ.NEXTVAL,
	 In_extFolioFinanciador,
	 vBonifL3_1,
	 vCantidadL3_1,
	 vTotalL3_1 / vCantidadL3_1,
	 vTotalL3_1,
	 vRecargoL3_1,
	 vAyuAsistL3_1,
	 0,
	 null,
	 vCodIsapreL3_1,
	 vCodInteL3_1);

      v_total	       := v_total + vTotalL3_1;
      v_cantidad       := v_cantidad + vCantidadL3_1;
      v_totalbonif     := v_totalbonif + vBonifL3_1;
      v_totalcopago    := v_totalcopago + vCopagoL3_1;
      v_totalcredito   := v_totalcredito + vCreditoL3_1;
      v_totalexcedente := v_totalexcedente + vExcedenteL3_1;
      v_totalayuda     := v_totalayuda + vAyuAsistL3_1;
      v_totalseguroc   := v_totalseguroc + vSegComplL3_1;

    end if;

    -- Lista 3 , Segundo Elemento

    IF vCodIsapreL3_2 <> 0 then

      BEN_TRANSFORMA_PESOS_ENUF(v_codplan,
				In_extFechaEmision,
				--		to_date(In_extFechaEmision,'YYYYMMDD'),
				vBonifL3_2,
				v_valor_prest_uf,
				v_error);

      IF NOT v_error IS NULL THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Error Bonif. L3 detalle 2(1)';
	rollback;
	Return;
      END IF;

      v_bonif_maxima := 99999999;

      BEN_BONIF_TIPAGRUP_PLAN_IDPR12(miArreglo,
				     v_codplan,
				     vCodIsapreL3_2,
				     'A',
				     v_valor_prest_uf, -- valor prestacion
				     v_fec_ini_acu,
				     v_fec_ter_acu,
				     'RB',
				     v_idafil,
				     v_corr,
				     v_bonif_maxima,
				     v_error);

      IF NOT v_error IS NULL THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Error Bonif. L3 detalle 2(2)';
	rollback;
	Return;
      END IF;

      BEN_ACTUALIZA_TOPES_ARREGLO12(miarreglo,
				    v_idafil,
				    v_corr,
				    vCantidadL3_2,
				    v_valor_prest_uf);

      insert into ADMBENE.BEN_D_BENEFICIO
	(ID_DET, --NUMBER(10)	 NOT NULL,
	 BEOA_NUM, --NUMBER	   NOT NULL,
	 BONIF, --NUMBER(15)	NOT NULL,
	 NUM, --NUMBER(15)    NOT NULL,
	 VALOR, --NUMBER(15,2)	NOT NULL,
	 VALOR_TOTAL, --NUMBER(15)	  NULL,
	 HORARIO, --VARCHAR2(3)   NOT NULL,
	 AYU_ASIST, --NUMBER(15)	NULL,
	 SEGURO_COMPL, --NUMBER(15)	   NULL,
	 BEBPM_ID_BOL, --NUMBER 	   NULL,
	 PMAE_ID_PREST, --NUMBER	NOT NULL,
	 BEIN_COD --VARCHAR2(4)       NULL,
	 )
      values
	(ADMBENE.BEN_D_ORS_AT_SEQ.NEXTVAL,
	 In_extFolioFinanciador,
	 vBonifL3_2,
	 vCantidadL3_2,
	 vTotalL3_2 / vCantidadL3_2,
	 vTotalL3_2,
	 vRecargoL3_2,
	 vAyuAsistL3_2,
	 0,
	 null,
	 vCodIsapreL3_2,
	 vCodInteL3_2);

      v_total	       := v_total + vTotalL3_2;
      v_cantidad       := v_cantidad + vCantidadL3_2;
      v_totalbonif     := v_totalbonif + vBonifL3_2;
      v_totalcopago    := v_totalcopago + vCopagoL3_2;
      v_totalcredito   := v_totalcredito + vCreditoL3_2;
      v_totalexcedente := v_totalexcedente + vExcedenteL3_2;
      v_totalayuda     := v_totalayuda + vAyuAsistL3_2;
      v_totalseguroc   := v_totalseguroc + vSegComplL3_2;

    end if;

    -- Actualizo topes

    ADMBENE.BEN_ACTUALIZA_TOPES_FINAL12(miarreglo,
					v_idafil,
					v_corr,
					v_fec_ini_acu,
					null,
					v_error);

    IF NOT v_error IS NULL THEN
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'Error Actualizando Topes';
      rollback;
      Return;
    END IF;

    -- Actualizacion final de BEB_BENEFICIO
    if v_totalcredito > 0 then

      Update admbene.ben_beneficio
	 set EXCEDENTE	     = v_totalexcedente,
	     VAL_AYUASIST    = v_totalayuda,
	     VAL_TOTAL	     = v_total,
	     VAL_BON	     = v_totalbonif, --v_totalboniffarmacia , caob 07/01/2005
	     VAL_COPAGO      = v_totalcopago,
	     VALOR	     = v_total,
	     CREDITO	     = v_totalcredito,
	     MONTO_CRED_NBON = 0,
	     CVDO_ID_DOMI    = In_extHomLugarConvenio,
	     --TIPO_CREDITO = v_tipocredito,
	     BTC_COD_PAGO = 'CP1'
       WHERE num = In_extFolioFinanciador;
    else
      Update admbene.ben_beneficio
	 set EXCEDENTE	     = v_totalexcedente,
	     VAL_AYUASIST    = v_totalayuda,
	     VAL_TOTAL	     = v_total,
	     VAL_BON	     = v_totalbonif, --v_totalboniffarmacia , caob 07/01/2005
	     VAL_COPAGO      = v_totalcopago,
	     VALOR	     = v_total,
	     CREDITO	     = v_totalcredito,
	     MONTO_CRED_NBON = 0,
	     CVDO_ID_DOMI    = In_extHomLugarConvenio,
	     --TIPO_CREDITO = v_tipocredito,
	     BTC_COD_PAGO = 'CP2'
       WHERE num = In_extFolioFinanciador;
    end if;

    /**********************************************************************************/
    /* MOVIMIENTO A LA CUENTA DE EXCEDENTES					      */
    /**********************************************************************************/
    if v_totalexcedente > 0 then

      ADMBENE.BEN_F_USO_EXCEDENTES(v_totalexcedente, --p_monto	   IN NUMBER,
				   v_idafil, --p_id_afi    IN NUMBER,
				   In_extFolioFinanciador, --p_num_orden in number,
				   v_ERROR --p_error	 in out varchar2
				   );

      IF NOT v_ERROR IS NULL THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Error Cargo Excedentes';
	dbms_output.put_line('Error Excedentes:' || v_ERROR);
	rollback;
	Return;
      END IF;

    end if;

    /**********************************************************************************/
    /* MOVIMIENTO A LA CUENTA DE CREDITO AUTOMATICO  - se elimina para IRB	      */
    /**********************************************************************************/
    /*if v_totalcredito > 0 then

      BEGIN
	SELECT CRCC_ID
	  INTO v_codmov
	  FROM ADMCRED.CRE_CTA_CTBE
	 WHERE CRCC_CRTM_COD = 'CEIM'
	   AND CRCC_ESTADO = 'VI';
      EXCEPTION
	WHEN NO_DATA_FOUND THEN
	  Out_extCodError     := 'N';
	  Out_extMensajeError := 'Error Cargo Credito(1)';
	  Return;
	WHEN OTHERS THEN
	  Out_extCodError     := 'N';
	  Out_extMensajeError := 'Error Cargo Credito(2)';
	  Return;
      END;

      res := ADMBENE.BEN_F_EXISTE_CTA_CRED_COB(v_idafil,
					       v_saldo,
					       v_titcta,
					       v_error);

      SELECT CRCA_FEC_ACT
	INTO v_fecact
	FROM ADMCRED.CRE_CTA_CAUT
       WHERE CRCA_AFIL_ID_AFI = v_titcta
	 AND CRCA_ESTADO IN ('VIGE', 'MORO', 'BLOQ')
	 AND CRCA_FEC_ACT in
	     (SELECT MAX(CRCA_FEC_ACT)
		FROM ADMCRED.CRE_CTA_CAUT
	       WHERE CRCA_AFIL_ID_AFI = v_titcta);

      ADMIMED.IMED_INS_MOV(v_codmov, -- ID Movimiento
			   v_titcta, -- ID Afiliado
			   v_fecact, -- Fecha Activacion Cuenta Credito/Fecha Inicio Cuenta Prohibicion/Cuenta Empleador en Convenio copago
			   v_corr, -- Correlativo Carga Cuenta Prohibicion
			   v_secctades, -- Secuencia Cuenta Desahucio/Prohibicion
			   null, -- ID empleador Cuenta Empleador en Convenio copago
			   v_totalcredito, -- Monto
			   In_extFolioFinanciador, -- Numero documento
			   'BENEFICIOS', -- Sistema Origen
			   '', -- Empleador
			   null, -- Folio regularizacion
			   null, -- Secuencia Mov. para Cta Empleador en Convenio copago
			   null, -- parametro uso futuro
			   v_ERROR); -- retorna codigo y mensaje de error

      IF NOT v_ERROR IS NULL THEN
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Error Cargo Credito(3)';
	dbms_output.put_line('Error Cargo:' || v_ERROR);
	rollback;
	Return;
      END IF;

    End If;*/

    -- Actualizo folio como ya utilizado
    Update admimed.imed_folios
       Set estado = 'U', fecha_respuesta = sysdate
     Where folio = In_extFolioFinanciador;

    commit;

    Out_extCodError	:= 'S';
    Out_extMensajeError := ' ';

  Exception
    WHEN OTHERS THEN
      Out_extCodError	  := 'N';
      Out_extMensajeError := '1:' || substr(sqlerrm, 1, 27); --'Error en Procedimiento Inf.';
      rollback;
      Return;

  End RBLEnvBonIs;
End RBLEnvBonIs_Pkg;

1272 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.4.0 - Production
