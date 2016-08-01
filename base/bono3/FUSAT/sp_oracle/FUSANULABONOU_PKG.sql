
SQL*Plus: Release 11.2.0.3.0 Production on Mon Aug 3 16:47:46 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.5.0 - 64bit Production

SQL> SQL> PROCEDURE CHUANULABONOU
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTFOLIOBONO		NUMBER			IN
 IN_EXTINDTRATAM		VARCHAR2		IN
 IN_EXTFECTRATAM		VARCHAR2		IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
PROCEDURE FUSANULABONOU
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTFOLIOBONO		NUMBER			IN
 IN_EXTINDTRATAM		VARCHAR2		IN
 IN_EXTFECTRATAM		VARCHAR2		IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
PROCEDURE RBLANULABONOU
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTFOLIOBONO		NUMBER			IN
 IN_EXTINDTRATAM		VARCHAR2		IN
 IN_EXTFECTRATAM		VARCHAR2		IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
PROCEDURE SNLANULABONOU
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTFOLIOBONO		NUMBER			IN
 IN_EXTINDTRATAM		VARCHAR2		IN
 IN_EXTFECTRATAM		VARCHAR2		IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	FUSAnulaBonoU_Pkg As
PROCEDURE FUSAnulaBonoU	/*2.7 Anula Transaccion */
    ( SRV_Message		     In Out	Varchar2
	, In_extCodFinanciador 	  		 In	    Number
    , In_extFolioBono				 In	    Number
    , In_extIndTratam				 In	    Varchar2
	, In_extFecTratam    			 In	    Varchar2
    , Out_extCodError				 Out	    Varchar2   --'N ','S'.
	, Out_extMensajeError			 Out	    Varchar2

    );

PROCEDURE SNLAnulaBonoU    /*2.7 Anula Transaccion */
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extFolioBono		      In	 Number
    , In_extIndTratam		      In	 Varchar2
    , In_extFecTratam		      In	 Varchar2
    , Out_extCodError		      Out	 Varchar2   --'N ','S'.
    , Out_extMensajeError	      Out	 Varchar2
    );
PROCEDURE RBLAnulaBonoU    /*2.7 Anula Transaccion */
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extFolioBono		      In	 Number
    , In_extIndTratam		      In	 Varchar2
    , In_extFecTratam		      In	 Varchar2
    , Out_extCodError		      Out	 Varchar2   --'N ','S'.
    , Out_extMensajeError	      Out	 Varchar2
    );
PROCEDURE CHUAnulaBonoU    /*2.7 Anula Transaccion */
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extFolioBono		      In	 Number
    , In_extIndTratam		      In	 Varchar2
    , In_extFecTratam		      In	 Varchar2
    , Out_extCodError		      Out	 Varchar2   --'N ','S'.
    , Out_extMensajeError	      Out	 Varchar2
    );

END    FUSAnulaBonoU_pkg;

41 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     FUSAnulaBonoU_Pkg As
PROCEDURE FUSAnulaBonoU	/*2.7 Anula Transaccion */
    ( SRV_Message		     In Out	Varchar2
	, In_extCodFinanciador 	  		 In	    Number
    , In_extFolioBono				 In	    Number
    , In_extIndTratam				 In	    Varchar2
	, In_extFecTratam    			 In	    Varchar2
    , Out_extCodError				 Out	    Varchar2   --'N ','S'.
	, Out_extMensajeError			 Out	    Varchar2

    )As
	num_aux	   Number;
	estado_aux Varchar2(50);
	mensaje	   Varchar2(300);
	impreso_aux varchar2(30);

    -------------------------------------------------------------------------
    --Variables para Setear la Salida
    -------------------------------------------------------------------------
    vv_SEPARADOR	    VARCHAR2(1):=';';
    vv_PARAMETROS_SALIDA    VARCHAR2(4000);

    -------------------------------------------------------------------------
    --Variables Auxiliares
    -------------------------------------------------------------------------
    v_nIMED_AUDI_SEQ	    NUMBER(10);
    v_vPARAMETROS_ENTRADA   VARCHAR2(4000);
    v_vPRE		    VARCHAR2(10);

    E_salir		    EXCEPTION;
    v_sep_ES		    VARCHAR2(1):=';';

	BEGIN
	SRV_Message := '1000000';
    Out_extCodError := 'S';
    Out_extMensajeError := ' ';

    ----------------------------------------------------------------------
    -- Graba Auditoria de Transaccion
    ----------------------------------------------------------------------
    ----DBMS_OUTPUT.PUT_LINE ( ' Antes de Armar varioable de Entrada' );
    v_vPARAMETROS_ENTRADA := Null;
    v_vPARAMETROS_ENTRADA := SRV_Message||';'||
			    In_extCodFinanciador||';'||
			    In_extFolioBono||';'||
			    In_extIndTratam||';'||
			    In_extFecTratam||';';

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
	(v_nIMED_AUDI_SEQ,in_extcodfinanciador,v_vPRE||'ANULABONOU_PKG',sysdate,null,null,null,Null,Null,null,null,null,In_extFolioBono,null,null,null,null,v_vPARAMETROS_ENTRADA,null,Sysdate,Null,Null)
	;
    Exception
    When Others Then
      Null;
    End;
    COMMIT;


		-- Valido codigo financiador
	if In_extCodFinanciador not in (62,63,65,68) then
	    Out_extCodError:='N';
	    Out_extMensajeError:='Codigo Financiador Erroneo';
	    RAISE E_salir;
	end if;

	begin
		select num,beeo_cod,impreso_por
		into   num_aux,estado_aux,impreso_aux
		from   ben_beneficio
		where  num=In_extFolioBono;
		
		if estado_aux='ANUL' then

	    Out_extCodError:='N';
	    Out_extMensajeError:='Bono ya esta anulado';
		
	elsif estado_aux='PAGA' then

	    Out_extCodError:='N';
	    Out_extMensajeError:='Bono esta pagado, no se puede anular';
		
	else
		
	    ADMBENE.BEN_ANULAR_ORDEN_ATENCION(In_extFolioBono,impreso_aux, 4,mensaje);
	    if mensaje is not null then
		Out_extCodError:='N';
		Out_extMensajeError:=substr(mensaje,1,30);
	    end if;

		end if;
	--	return;

	vv_PARAMETROS_SALIDA:= Out_extCodError||';'||
			    Out_extMensajeError||';';

	UPDATE ADMIMED.IMED_AUDITORIA
	Set RUT_COTIZ = Null,
	  --RUT_BENEF = oRutBen,
	  --ID_AFI = vIdAfi,
	  --CODIGO_CARGA = vCorr,
	  --NRO_BONO_ISAPRE = null,
	  --MONTO_TOTAL_BONO = null,
	  --PREST_TOTALES_BONO = in_extnumprestaciones,
	  --MONTO_ISAPRE_BONO = null,
	  --MONTO_COPAGO_BONO = null,
	  DATOS_SALIDA = vv_PARAMETROS_SALIDA,
	  FEC_HOR_SALIDA = SYSDATE,
	  SEGUNDOS_RESP = trunc((SYSDATE-FEC_HOR_LLEGADA)*24*60*60),
	  LUGAR_CONVENIO_MOD = NULL
	Where CORRELATIVO = v_nIMED_AUDI_SEQ
	;
	COMMIT;

	exception
	when no_data_found then

		Out_extCodError:='N';
		Out_extMensajeError:='Folio no existe';
	vv_PARAMETROS_SALIDA:= Out_extCodError||';'||
			    Out_extMensajeError||';';

	UPDATE ADMIMED.IMED_AUDITORIA
	Set RUT_COTIZ = Null,
	  --RUT_BENEF = oRutBen,
	  --ID_AFI = vIdAfi,
	  --CODIGO_CARGA = vCorr,
	  --NRO_BONO_ISAPRE = null,
	  --MONTO_TOTAL_BONO = null,
	  --PREST_TOTALES_BONO = in_extnumprestaciones,
	  --MONTO_ISAPRE_BONO = null,
	  --MONTO_COPAGO_BONO = null,
	  DATOS_SALIDA = vv_PARAMETROS_SALIDA,
	  FEC_HOR_SALIDA = SYSDATE,
	  SEGUNDOS_RESP = trunc((SYSDATE-FEC_HOR_LLEGADA)*24*60*60),
	  LUGAR_CONVENIO_MOD = NULL
	Where CORRELATIVO = v_nIMED_AUDI_SEQ
	;
	COMMIT;

		
	end;
    EXCEPTION
    WHEN E_salir THEN

	vv_PARAMETROS_SALIDA:= Out_extCodError||';'||
			    Out_extMensajeError||';';

	UPDATE ADMIMED.IMED_AUDITORIA
	Set RUT_COTIZ = Null,
	  --RUT_BENEF = oRutBen,
	  --ID_AFI = vIdAfi,
	  --CODIGO_CARGA = vCorr,
	  --NRO_BONO_ISAPRE = null,
	  --MONTO_TOTAL_BONO = null,
	  --PREST_TOTALES_BONO = in_extnumprestaciones,
	  --MONTO_ISAPRE_BONO = null,
	  --MONTO_COPAGO_BONO = null,
	  DATOS_SALIDA = vv_PARAMETROS_SALIDA,
	  FEC_HOR_SALIDA = SYSDATE,
	  SEGUNDOS_RESP = trunc((SYSDATE-FEC_HOR_LLEGADA)*24*60*60),
	  LUGAR_CONVENIO_MOD = NULL
	Where CORRELATIVO = v_nIMED_AUDI_SEQ
	;
	COMMIT;

	END FUSAnulaBonoU;
PROCEDURE SNLAnulaBonoU	/*2.7 Anula Transaccion */
    ( SRV_Message		     In Out	Varchar2
	, In_extCodFinanciador 	  		 In	    Number
    , In_extFolioBono				 In	    Number
    , In_extIndTratam				 In	    Varchar2
	, In_extFecTratam    			 In	    Varchar2
    , Out_extCodError				 Out	    Varchar2   --'N ','S'.
	, Out_extMensajeError			 Out	    Varchar2

    )As

    Begin
	FUSAnulaBonoU	( SRV_Message
			, In_extCodFinanciador
			, In_extFolioBono
			, In_extIndTratam
			, In_extFecTratam
			, Out_extCodError
			, Out_extMensajeError);
	END SNLAnulaBonoU;

PROCEDURE RBLAnulaBonoU    /*2.7 Anula Transaccion */
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extFolioBono		      In	 Number
    , In_extIndTratam		      In	 Varchar2
    , In_extFecTratam		      In	 Varchar2
    , Out_extCodError		      Out	 Varchar2   --'N ','S'.
    , Out_extMensajeError	      Out	 Varchar2

    )As

    Begin
	FUSAnulaBonoU	( SRV_Message
			, In_extCodFinanciador
			, In_extFolioBono
			, In_extIndTratam
			, In_extFecTratam
			, Out_extCodError
			, Out_extMensajeError);
    END RBLAnulaBonoU;

PROCEDURE CHUAnulaBonoU    /*2.7 Anula Transaccion */
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extFolioBono		      In	 Number
    , In_extIndTratam		      In	 Varchar2
    , In_extFecTratam		      In	 Varchar2
    , Out_extCodError		      Out	 Varchar2   --'N ','S'.
    , Out_extMensajeError	      Out	 Varchar2

    )As

    Begin
	FUSAnulaBonoU	( SRV_Message
			, In_extCodFinanciador
			, In_extFolioBono
			, In_extIndTratam
			, In_extFecTratam
			, Out_extCodError
			, Out_extMensajeError);
    END CHUAnulaBonoU;
	end  FUSAnulaBonoU_Pkg;

247 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.5.0 - 64bit Production
