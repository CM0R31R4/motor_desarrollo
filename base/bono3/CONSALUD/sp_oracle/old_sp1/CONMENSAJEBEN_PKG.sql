
SQL*Plus: Release 11.2.0.3.0 Production on Wed Mar 5 18:59:59 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONMENSAJEBEN
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTRUTBENEFICIARIO 	VARCHAR2		IN
 OUT_NEXTTIPOACCION		NUMBER			OUT
 OUT_VEXTMSGERROR1		VARCHAR2		OUT
 OUT_VEXTMSGERROR2		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Conmensajeben_Pkg AS

	PROCEDURE Conmensajeben (    SRV_Message 		  			IN OUT VARCHAR2
					   		   , In_nExtCodFinanciador	  	IN 	   NUMBER
							   , In_vExtRutBeneficiario			IN 	   VARCHAR2
							   , Out_nExtTipoAccion				OUT	   NUMBER
							   , Out_vExtMsgError1				OUT	   VARCHAR2
							   , Out_vExtMsgError2				OUT	   VARCHAR2
							    );
END Conmensajeben_Pkg;

10 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     Conmensajeben_Pkg	AS

PROCEDURE Conmensajeben (    SRV_Message 		  			     IN OUT VARCHAR2
					   		   , In_nExtCodFinanciador	  	IN 	   		 NUMBER
							   , In_vExtRutBeneficiario			   IN 	   	   VARCHAR2
							   , Out_nExtTipoAccion				   OUT	   NUMBER
							   , Out_vExtMsgError1				    OUT	     VARCHAR2
							   , Out_vExtMsgError2				    OUT	     VARCHAR2)IS

v_vNomTrans				   	 			VARCHAR2(50):= UPPER('CONMensajeBen_PKG');
v_vEntrada_Format						VARCHAR2(2000);
v_vSalida_Format					 	VARCHAR2(2000);
v_sep_ES	   							VARCHAR2(1):=';';
Out_vReturnStatus						VARCHAR2(1);
Out_vMessageCode 						VARCHAR2(5);
Out_vMessageText					  	VARCHAR2(255);
SRV_FetchStatus						    NUMBER(1) := '0';
SRV_Total_Rows							NUMBER(8);
SRV_Row_Count							NUMBER(8);
v_vCarIniMessageText					VARCHAR2(1):='X'; -- Para diferenciar Out_vMessageText
											  -- de vv_ExtMensajeError
-- Codigo de la Isapre para validar contra entrada
v_nCod_Isa_Cons  		   			    NUMBER  :=71;
ISAPRE_NO_CORRESPONDE	   				EXCEPTION;
MAX_FILAS_SALIDA					  	EXCEPTION;
E_Fin									EXCEPTION;
-----------------------------------------------------
v_vSeparador			   				VARCHAR2(1):='|';
v_nExtCodFinanciador  	   				NUMBER(3);

v_vExtCodError			    			VARCHAR2(1);
v_vMensajeError			    			VARCHAR2(30);

v_nNumDoc				   				NUMBER(10);

---- Para recibir Variables entrada
v_nExtRutBeneficiario	   		   	  	NUMBER ( 10 );
v_dExtFechaActual	   			   	DATE;
vd_Fecha_Salida			   			    DATE;
v_dFechor_Llegada		   			 	DATE:=SYSDATE;
v_nFolio_Suscripcion	   			  	NUMBER;
v_nRut_Cotizante		   			    NUMBER(10);  --ctc
v_nCodigo_Isapre	   			   	NUMBER ( 3 );
v_nCodigo_Carga 	   			   	NUMBER;
v_nCodError				   			  	NUMBER(06);
v_vGloError				   				VARCHAR2(100);--ctc
v_vResp					   				VARCHAR2(255);
v_EXISTE_DEUDA			   		   		VARCHAR2(1);
v_nRespuesta			   		 		NUMBER;
vn_EXISTE				  				NUMBER;

vv_ExtCodError			  				VARCHAR2(255):='';
vv_ExtMensajeError		   			  	VARCHAR2(255):='';
vv_NOM_COBRADOR			   	  			VARCHAR2(50);-- 14-09-2005 PATRICIO ALARCON
vv_FONO_COBRADOR		     			VARCHAR2(20);-- 14-09-2005 PATRICIO ALARCON
vn_Lugar 						 		NUMBER:=0;


FUNCTION SETEA_ENTRADA	RETURN VARCHAR2	IS
	v_vEntrada			   VARCHAR2(2000);
	BEGIN
		v_vEntrada	:=  SUBSTR(';'||
						--SUBSTR(SRV_Message,1,256)||v_sep_ES||
						TO_CHAR(In_nExtCodFinanciador)||v_sep_ES||
						In_vExtRutBeneficiario||v_sep_ES,1,2000);
		RETURN v_vEntrada;
END SETEA_ENTRADA;

FUNCTION SETEA_SALIDA RETURN VARCHAR2 IS
v_vSalida	   VARCHAR2(2000);

BEGIN
	v_vSalida:=  SUBSTR(SRV_Message||v_sep_ES||
				 Out_nExtTipoAccion||v_sep_ES||
				 Out_vExtMsgError1||v_sep_ES||
				 Out_vExtMsgError2||v_sep_ES||
				 vv_ExtCodError||v_sep_ES||
				 vv_ExtMensajeError||v_sep_ES,1,2000);

	RETURN v_vSalida;
END SETEA_SALIDA;

BEGIN
	vn_Lugar:=1;
	v_nExtCodFinanciador  := In_nExtCodFinanciador;
	Out_vExtMsgError1	  := '	';
	Out_vExtMsgError2	  := '	';
	Out_nExtTipoAccion	  := 0;
	v_vEntrada_Format 	  := SETEA_ENTRADA;
	v_dExtFechaActual	  := TO_DATE(TO_CHAR(SYSDATE,'RRRR/MM/DD HH24:MI:SS'),'RRRR/MM/DD HH24:MI:SS');

	IF ( v_nExtcodfinanciador != v_nCod_Isa_Cons )	THEN
		RAISE ISAPRE_NO_CORRESPONDE;
	END IF;
    vn_Lugar:=2;
	SRV_Total_Rows	:= 0;
	v_nExtRutBeneficiario:= TO_NUMBER (SUBSTR (In_vExtRutBeneficiario, 1, 10 ));

	BEGIN
		 vn_Lugar:=3;
		v_vResp := Imed_Beneficiario_Cotizante (v_nExtRutBeneficiario,
												v_nFolio_Suscripcion,
												v_nRut_Cotizante,
												v_nCodigo_Isapre,
												v_nCodigo_Carga,
												v_nCodError,
												v_vGloError);
		 vn_Lugar:=4;
	EXCEPTION
		WHEN OTHERS THEN
			vn_Lugar:=5;
	 		vv_ExtCodError	   := 'N';
			vv_ExtMensajeError := RPAD('NO CERTIFICADO',30);
			--Out_vReturnStatus	   := '0';
			Out_vReturnStatus	   := '1';
			Out_vMessageText	   := v_vCarIniMessageText||vv_ExtMensajeError;
			--Out_vMessageCode 	   := '78001';
			Out_vMessageCode 	   := '00000';
			RAISE E_Fin;
	END;

	IF  v_vResp = 1 THEN

	 	vn_Lugar:=6;
		vv_ExtCodError	   := 'N';
		vv_ExtMensajeError := RPAD('NO CERTIFICADO',30);
		--Out_vReturnStatus	   := '0';
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||vv_ExtMensajeError;
		--Out_vMessageCode 	   := '78001';
		Out_vMessageCode 	   := '00000';
		RAISE e_fin;
	END IF;

	-- POR MENSAJE PARA SELECCIONAR CORRECTAMENTE CONVENIO DENTAL BC24 O BC15 PGP 11/01/2008
	IF Pck_Imed_Benef_Comp.F_IMED_POSEE_BENEF_BC(v_nFolio_Suscripcion,v_nExtCodFinanciador,66666666) = 'BC24' THEN
		SRV_FetchStatus   	 	:= '1';
		vv_ExtCodError	   		:= 'N';
		vv_ExtMensajeError 		:= 'Beneficiario con Beneficio Dental Plus 70 (BC24) , si la prestacion es dental seleccione convenio Dental Plus 70, rut 66666666 (Si ya ha seleccionado este Convenio, favor omitir este mensaje)';
		Out_vExtMsgError1		:=  vv_ExtMensajeError;
		Out_vReturnStatus	   	:= '1';
		Out_vMessageText	   	:= v_vCarIniMessageText||vv_ExtMensajeError;
		Out_vMessageCode 	   	:= '00000';--'38001';
		SRV_Message 		   	:= Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		Out_nExtTipoAccion	    := 1;
		RAISE e_fin;
	ELSIF Pck_Imed_Benef_Comp.F_IMED_POSEE_BENEF_BC(v_nFolio_Suscripcion,v_nExtCodFinanciador,99999999) = 'BC15' THEN
		SRV_FetchStatus   	 	:= '1';
		vv_ExtCodError	   		:= 'N';
		vv_ExtMensajeError 		:= 'Beneficiario con Beneficio Dental OK (BC15), si la prestacion es dental seleccione convenio Dental OK, rut 99999999 (Si ya ha seleccionado este Convenio, favor omitir este mensaje)';
		Out_vExtMsgError1		:=  vv_ExtMensajeError;
		Out_vReturnStatus	   	:= '1';
		Out_vMessageText	   	:= v_vCarIniMessageText||vv_ExtMensajeError;
		Out_vMessageCode 	   	:= '00000';--'38001';
		SRV_Message 		   	:= Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		Out_nExtTipoAccion	    := 1;
		RAISE e_fin;
	END IF;
	-- POR MENSAJE PARA SELECCIONAR CORRECTAMENTE CONVENIO DENTAL BC24 O BC15 PGP 11/01/2008

	-- Verifica Deuda de ultimo mes (COMPAG)
	IF Pck_Imed_Adm_Proc.F_IMED_BLOQUEA_SECCION('VERIFICA_DEUDA_COMPAG') = 'S' THEN
 		vn_Lugar:=7;
		BEGIN
			v_EXISTE_DEUDA := Pck_Imed_Externos.F_IMED_Posee_Deuda_ult_peri(v_nRut_Cotizante, 'N','N'); -- 06-09-2005 AGREGA PARAMETRO PATRICIO ALARCON
			vn_Lugar:=v_nRut_Cotizante;
			IF v_EXISTE_DEUDA='S' THEN
				vn_Lugar:=8;

				SELECT NVL(SUM(DECODE(BLOQUEADO,'S',2,1)),0) --COUNT(*)
				INTO   vn_EXISTE
				FROM   COMPAG_IMED
				WHERE  FOLIO_SUSCRIPCION = v_nFolio_Suscripcion
				--AND	 BLOQUEADO = 'S'
				AND    ESTADO = 1 ;

				IF vn_EXISTE > 0 THEN

					IF  vn_EXISTE = 2 THEN
						IF Pck_Imed_Adm_Proc.F_IMED_BLOQUEA_SECCION('MOSTRAR_MENSAJE_ABORTIVO') = 'S' THEN
						   Out_nExtTipoAccion	  := 2;
						ELSE
						   Out_nExtTipoAccion	  := 0;
						END IF;
					ELSE
						v_EXISTE_DEUDA := Pck_Imed_Externos.F_IMED_Posee_Deuda_ult_peri(v_nRut_Cotizante, 'S','S'); -- 06-09-2005 AGREGA PARAMETRO PATRICIO ALARCON

						IF Pck_Imed_Adm_Proc.F_IMED_BLOQUEA_SECCION('MOSTRAR_MENSAJE_ABORTIVO') = 'S' THEN
						   Out_nExtTipoAccion	  := 2;
						ELSE
						   Out_nExtTipoAccion	  := 0;
						END IF;
					END IF;
				ELSE
					IF Pck_Imed_Adm_Proc.F_IMED_BLOQUEA_SECCION('MOSTRAR_MENSAJE_WARNING') = 'S' THEN
					   Out_nExtTipoAccion	  := 1;
					ELSE
						Out_nExtTipoAccion	  := 0;
					END IF;
				END IF;

				vn_Lugar:=9;
			 	vv_FONO_COBRADOR := Pck_Compag_Imed.F_retorna_cobrador(v_nFolio_Suscripcion,'TELEFONO');
				vv_NOM_COBRADOR  :=	Pck_Compag_Imed.F_retorna_cobrador(v_nFolio_Suscripcion,'NOMBRE');
				vn_Lugar:=10;
				Out_vExtMsgError1	:= RPAD(Pck_Imed_Adm_Proc.F_IMED_RETORNA_MENSAJE('MENSAJE DE COBRANZA'),200);
				Out_vExtMsgError1	:= REPLACE(REPLACE(Out_vExtMsgError1, '<NOMBRE_EJECUTIVO_DE_COBRANZA>', vv_NOM_COBRADOR),'<TELEFONO_EJECUTIVO>', vv_FONO_COBRADOR);
				vn_Lugar:=11;
				Out_vExtMsgError1	:= RPAD(RTRIM(Out_vExtMsgError1),250);
				vn_Lugar:=12;
--				Out_vExtMsgError1	  := RPAD(Pck_Imed_Adm_Proc.F_IMED_RETORNA_MENSAJE('MENSAJE DE COBRANZA'),60);
				Out_vExtMsgError2	  := ' ';
				vv_ExtCodError	      := 'N';
				vv_ExtMensajeError    := RPAD('CON DEUDA',30);
				Out_vReturnStatus	  := '1';
				vn_Lugar:=13;
				Out_vMessageCode 	  := '00000';
				Out_vMessageText	  := v_vCarIniMessageText||Out_vExtMsgError1;
				vn_Lugar:=14;
				RAISE E_FIN;
			END IF;
		END;

	END IF;

	vn_Lugar:=9;

	-- Verifica Deuda de ultimo mes (COMPAG)
	SRV_FetchStatus   	 	:= '1';
	vv_ExtCodError	   		:= 'S';
	vv_ExtMensajeError 		:= 'Servicio Correcto';
	Out_vReturnStatus	   	:= '1';
	Out_vMessageText	   	:= v_vCarIniMessageText||vv_ExtMensajeError;
	Out_vMessageCode 	   	:= '00000';--'38001';
	SRV_Message 		   	:= Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;

	RAISE E_FIN;

EXCEPTION
	WHEN E_Fin THEN
		vd_Fecha_Salida:= TO_DATE( TO_CHAR ( SYSDATE, 'RRRR/MM/DD HH24:MI:SS' ), 'rRRR/MM/DD HH24:MI:SS');

		SRV_Message:= Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;

		v_vSalida_Format:= SETEA_SALIDA;
		v_nRespuesta := Imed_Graba_Auditoria( v_vNomTrans
											, v_dExtFechaActual
											, NULL
											, NULL
											, NULL
											, NULL
											, v_nExtRutBeneficiario
											, v_nRut_Cotizante
											, v_nFolio_Suscripcion
											, v_nCodigo_Carga
											, NULL
											, NULL
											, NULL
											, NULL
											, NULL
											, v_vEntrada_Format
											, v_vSalida_Format
											, v_dFechor_Llegada
											, vd_Fecha_Salida
											, ( vd_Fecha_Salida - v_dFechor_Llegada ) * 86400
											, 0
											, 0
											, 0
											, 0
											, 0
											, 0
											, 0
											);
		RETURN;
	WHEN ISAPRE_NO_CORRESPONDE THEN
		vv_ExtCodError	   := 'N';
		vv_ExtMensajeError := RPAD('Codigo isapre no corresponde',30);
		--	  	  Out_vReturnStatus	   := '0';
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||vv_ExtMensajeError;
		--	  	  Out_vMessageCode 	   := '78001';
		Out_vMessageCode 	   := '00000';

		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;

		vd_Fecha_Salida:= TO_DATE( TO_CHAR ( SYSDATE, 'RRRR/MM/DD HH24:MI:SS' ), 'RRRR/MM/DD HH24:MI:SS');

		SRV_Message:= Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;

		v_vSalida_Format:= SETEA_SALIDA;

		v_nRespuesta := Imed_Graba_Auditoria( v_vNomTrans
											, v_dExtFechaActual
											, NULL
											, NULL
											, NULL
											, NULL
											, v_nExtRutBeneficiario
											, v_nRut_Cotizante
											, v_nFolio_Suscripcion
											, v_nCodigo_Carga
											, NULL
											, NULL
											, NULL
											, NULL
											, NULL
											, v_vEntrada_Format
											, v_vSalida_Format
											, v_dFechor_Llegada
											, vd_Fecha_Salida
											, ( vd_Fecha_Salida - v_dFechor_Llegada ) * 86400
											, 0
											, 0
											, 0
											, 0
											, 0
											, 0
											, 0
											);
  		  RETURN;
	WHEN MAX_FILAS_SALIDA THEN
		vv_ExtCodError	   := 'N';
		vv_ExtMensajeError := RPAD('Supera numero maximo de registros a devolver',30);
		--Out_vReturnStatus	   := '0';
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||vv_ExtMensajeError;
		--Out_vMessageCode 	   := '78002';
		Out_vMessageCode 	   := '00000';

		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;

		vd_Fecha_Salida:= TO_DATE( TO_CHAR ( SYSDATE, 'RRRR/MM/DD HH24:MI:SS' ), 'RRRR/MM/DD HH24:MI:SS');

	 	SRV_Message:= Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;

	 	v_vSalida_Format:= SETEA_SALIDA;

	 	v_nRespuesta := Imed_Graba_Auditoria( v_vNomTrans
	 										, v_dExtFechaActual
	 										, NULL
	 										, NULL
	 										, NULL
	 										, NULL
	 										, v_nExtRutBeneficiario
	 										, v_nRut_Cotizante
	 										, v_nFolio_Suscripcion
	 										, v_nCodigo_Carga
	 										, NULL
	 										, NULL
	 										, NULL
	 										, NULL
	 										, NULL
	 										, v_vEntrada_Format
	 										, v_vSalida_Format
	 										, v_dFechor_Llegada
	 										, vd_Fecha_Salida
	 										, ( vd_Fecha_Salida - v_dFechor_Llegada ) * 86400
	 										, 0
	 										, 0
	 										, 0
	 										, 0
	 										, 0
	 										, 0
	 										, 0
	 										);

  		  RETURN;
	WHEN OTHERS THEN
		vv_ExtCodError	   := 'N';
		vv_ExtMensajeError := RPAD('ERROR PROC.:('||vn_Lugar||')',30);
		Out_vReturnStatus	   := '1';
		Out_vMessageText	   := v_vCarIniMessageText||vv_ExtMensajeError;
		Out_vMessageCode 	   := '00000';

		SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
		vd_Fecha_Salida:= TO_DATE( TO_CHAR ( SYSDATE, 'RRRR/MM/DD HH24:MI:SS' ), 'RRRR/MM/DD HH24:MI:SS');
		SRV_Message:= Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;

		v_vSalida_Format:= SETEA_SALIDA;
	 	v_nRespuesta := Imed_Graba_Auditoria( v_vNomTrans
	 										, v_dExtFechaActual
	 										, NULL
	 										, NULL
	 										, NULL
	 										, NULL
	 										, v_nExtRutBeneficiario
	 										, v_nRut_Cotizante
	 										, v_nFolio_Suscripcion
	 										, v_nCodigo_Carga
	 										, NULL
	 										, NULL
	 										, NULL
	 										, NULL
	 										, NULL
	 										, v_vEntrada_Format
	 										, v_vSalida_Format
	 										, v_dFechor_Llegada
	 										, vd_Fecha_Salida
	 										, ( vd_Fecha_Salida - v_dFechor_Llegada ) * 86400
	 										, 0
	 										, 0
	 										, 0
	 										, 0
	 										, 0
	 										, 0
	 										, 0
	 										);

	RETURN;
END Conmensajeben;

END Conmensajeben_Pkg;

412 rows selected.

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
