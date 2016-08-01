
SQL*Plus: Release 11.2.0.3.0 Production on Wed Mar 5 19:00:00 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONDATOSPREST
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTRUTCONVENIO		VARCHAR2		IN
 IN_VEXTCODIGOSUCUR		VARCHAR2		IN
 OUT_VEXTESTCONVENIO		VARCHAR2		OUT
 OUT_NEXTNIVEL			NUMBER			OUT
 OUT_VEXTTIPOPRESTADOR		VARCHAR2		OUT
 OUT_VEXTCODESPECIALIDADES	VARCHAR2		OUT
 OUT_VEXTCODPROFESIONES 	VARCHAR2		OUT
 OUT_VEXTANOSANTIGUEDAD 	VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Condatosprest_Pkg
AS
   PROCEDURE Condatosprest
   			 (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nExtCodFinanciador	 	IN 	   NUMBER
		   , In_vExtRutConvenio				IN 	   VARCHAR
		   , In_vExtCodigoSucur				IN 	   VARCHAR
		   , Out_vExtEstConvenio			OUT    VARCHAR
		   , Out_nExtNivel					OUT    NUMBER
		   , Out_vExtTipoPrestador			OUT    VARCHAR
		   , Out_vextCodEspecialidades 		OUT    VARCHAR
		   , Out_vExtCodProfesiones			OUT    VARCHAR
		   , Out_vExtAnosAntiguedad			OUT    VARCHAR
			 );
END Condatosprest_Pkg;

16 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     Condatosprest_Pkg
AS

PROCEDURE Condatosprest
   			 (
   			 SRV_Message 		  			IN OUT VARCHAR2
   		   , In_nExtCodFinanciador	  	IN 	   NUMBER
		   , In_vExtRutConvenio				IN 	   VARCHAR
		   , In_vExtCodigoSucur				IN 	   VARCHAR
		   , Out_vExtEstConvenio			OUT    VARCHAR
		   , Out_nExtNivel					OUT    NUMBER
		   , Out_vExtTipoPrestador			OUT    VARCHAR
		   , Out_vextCodEspecialidades 		OUT    VARCHAR
		   , Out_vExtCodProfesiones			OUT    VARCHAR
		   , Out_vExtAnosAntiguedad			OUT    VARCHAR
			 )
IS

v_vNomTrans				   		   		    VARCHAR2(50):= UPPER('CONDATOSPREST_PKG');

v_vEntrada_Format				 			VARCHAR2(2000);
v_vSalida_Format							VARCHAR2(2000);
v_sep_ES	   								VARCHAR2(1):=';';
Out_vReturnStatus							VARCHAR2(1);
Out_vMessageCode 						  	VARCHAR2(5);
Out_vMessageText							VARCHAR2(243);
SRV_FetchStatus								NUMBER(1) := '0';
SRV_Total_Rows								NUMBER(8);
SRV_Row_Count								NUMBER(8);
v_vCarIniMessageText						VARCHAR2(1):='X'; -- Para diferenciar Out_vMessageText
														  	  -- de Out_vExtMensajeError
v_vBloqueado								VARCHAR2(1);

-- Codigo de la Isapre para validar contra entrada
v_nCod_Isa_Cons  		   	 	   	   	    NUMBER  :=71;

isapre_no_corresponde	   				    EXCEPTION;
no_terminal_homologado	   					EXCEPTION;
prestador_no_existe		   					EXCEPTION;
prestador_bloqueado		   					EXCEPTION;
prestador_error		   	   					EXCEPTION;
convenio_no_existe							EXCEPTION;
convenio_error	  							EXCEPTION;

--- Variables para almacenar parametros de entrada
v_nExtCodFinanciador	   	 			    NUMBER(3);
v_nExtRutConvenio		   				    NUMBER(10);
v_vExtCodigoSucur		   				    VARCHAR2(10);

--- Variables para almacenar parametros de salida
v_vExtEstConvenio  		   	 			    VARCHAR2(10);
v_nExtNivel				   					NUMBER;
v_vExtTipoPrestador	   	   					VARCHAR2(10);
v_vExtLstCodEspe		   					VARCHAR2(255);
v_vExtLstCodProf	   	   					VARCHAR2(255);
v_vExtAnosAntiguedad	   					VARCHAR2(2);
v_vEspeCod			   	   					VARCHAR2(3);
v_vProfCod			   	   					VARCHAR2(20);

v_vCabecera				   					VARCHAR2(2000);
v_vDetalle				   					VARCHAR2(2000);
v_vSeparador			   					VARCHAR2(1):= '|';

v_nNumCodEspe			   					NUMBER:=0;
v_nNumCodProf			   					NUMBER:=0;
v_vSalidaError			   					VARCHAR2(2000);
v_vSucFamiliaAtesa		   					VARCHAR2(10);
E_FIN					   					EXCEPTION;


/*  20030125 CAGF */
/* DATOS DE PRUEBA o Vacios, BUSCAR FUENTE CORRECTA DE DATOS*/
CURSOR c_especialidades_prest (p_rut_prestador IN NUMBER) IS
	   SELECT ' '
	   FROM dual;

/*  20030125 CAGF */
/* DATOS DE PRUEBA o Vacios, BUSCAR FUENTE CORRECTA DE DATOS*/
CURSOR c_profesiones_prest (p_rut_prestador IN NUMBER) IS
	   SELECT ' '
	   FROM dual;

FUNCTION SETEA_ENTRADA
RETURN VARCHAR2
IS
v_vEntrada			   	   					VARCHAR2(2000);
BEGIN
v_vEntrada	:=  SUBSTR(TO_CHAR(In_nExtCodFinanciador)||v_sep_ES||
		   		In_vExtRutConvenio||v_sep_ES||
		   		In_vExtCodigoSucur||v_sep_ES,1,2000);
RETURN v_vEntrada;
END;

FUNCTION SETEA_SALIDA
RETURN VARCHAR2
IS
v_vSalida	   		 					 	VARCHAR2(2000);

BEGIN
v_vSalida:= SUBSTR(SRV_Message||v_sep_ES||
		    Out_vExtEstConvenio||v_sep_ES||
		    TO_CHAR(Out_nExtNivel)||v_sep_ES||
		    Out_vExtTipoPrestador||v_sep_ES||
		    Out_vextCodEspecialidades||v_sep_ES||
		    Out_vExtCodProfesiones||v_sep_ES||
		    Out_vExtAnosAntiguedad||v_sep_ES,1,2000);
RETURN v_vSalida;
END;

PROCEDURE LIMPIA
IS
BEGIN
Out_vExtEstConvenio	  := ' ';
Out_nExtNivel			  := 0;
Out_vExtTipoPrestador	  := ' ';
Out_vextCodEspecialidades := ' ';
Out_vExtCodProfesiones	  := ' ';
Out_vExtAnosAntiguedad	  := ' ';
END;
BEGIN
  v_nExtCodFinanciador	:= In_nExtCodFinanciador;

  IF ( v_nExtCodFinanciador != v_ncod_isa_cons )
  THEN
      RAISE isapre_no_corresponde;
  END IF;

  v_nExtRutConvenio	    := TO_NUMBER(SUBSTR(In_vExtRutConvenio,1,10));
  v_vExtCodigoSucur	    := In_vExtCodigoSucur;
  v_vSucFamiliaAtesa 	:= v_vExtCodigoSucur;


  BEGIN
  	BEGIN
	  SELECT PROF.BLOQUEADO
	    INTO v_vBloqueado
		FROM CON_PRESTADORES PROF
	   WHERE PROF.RUT = v_nExtRutConvenio;
	EXCEPTION
		 WHEN NO_DATA_FOUND THEN
		  RAISE prestador_no_existe;
		 WHEN OTHERS THEN
		  RAISE prestador_error;
	END;

    IF	v_vBloqueado != 'N' THEN
  	    RAISE prestador_bloqueado;
    END IF;

    SELECT
	  		 COFI.VIGENCIA,
			 0,
			 DECODE(PREST.PREST_TYPE,'PROF','1','INSA','2')
	   INTO
	   		 v_vExtEstConvenio,
			 v_nExtNivel,
			 v_vExtTipoPrestador
	    FROM CON_PRESTADORES PREST,
	  	   	 CON_CONVENIOS_FINALES COFI,
	  	   	 CON_ASOCIACIONES_PREST_CONVENI ASPCO
	   WHERE PREST.rut = v_nExtRutConvenio
	     AND ASPCO.PREST_CODIGO_INTERNO = PREST.CODIGO_INTERNO
	   	 AND ASPCO.VIGENCIA = 'S'
		 AND COFI.CORRELATIVO = ASPCO.COFI_CORRELATIVO
	   	 AND COFI.TERMINAL_ATESA = v_vSucFamiliaAtesa;
		 EXCEPTION
  		 WHEN NO_DATA_FOUND THEN
  		 RAISE convenio_no_existe;
  		 WHEN OTHERS THEN
  		 RAISE convenio_error;
  		 END;
BEGIN

/* ABRE CURSOR DE ESPECIALIDADES */

  IF c_especialidades_prest%isopen THEN
    CLOSE c_especialidades_prest;
  END IF;
  OPEN c_especialidades_prest(v_nExtRutConvenio);
  LOOP
  FETCH c_especialidades_prest INTO v_vEspeCod;
  EXIT WHEN c_especialidades_prest%NOTFOUND;
    v_nNumCodEspe := v_nNumCodEspe + 1;
    v_vExtLstCodEspe := v_vExtLstCodEspe||Llena_Blancos(v_vEspeCod,3)||v_vSeparador;
  END LOOP;
END;
 BEGIN

/* ABRE CURSOR DE PROFESIONES */

  IF c_profesiones_prest%isopen THEN
    CLOSE c_profesiones_prest;
  END IF;
  OPEN c_profesiones_prest(v_nExtRutConvenio);
  LOOP
  FETCH c_profesiones_prest INTO v_vProfCod;
  EXIT WHEN c_profesiones_prest%NOTFOUND;
    v_nNumCodprof := v_nNumCodprof + 1;
    v_vExtLstCodProf := v_vExtLstCodProf||v_vProfCod||v_vSeparador;
  END LOOP;
 END;

-- Setea Variables de Salida
  Out_vExtEstConvenio	     := Llena_Blancos(v_vExtEstConvenio,10);
  Out_nExtNivel			     := Llena_Espacios(v_nExtNivel,1);
  Out_vExtTipoPrestador	   	 := Llena_Blancos(v_vExtTipoPrestador,1);
  Out_vextCodEspecialidades  := NVL(v_vExtLstCodEspe,' ');
  Out_vExtCodProfesiones	 := NVL(v_vExtLstCodProf,' ');
  Out_vExtAnosAntiguedad	 := Llena_Blancos('01',2);--- ?


  Out_vReturnStatus	   := '1';
  Out_vMessageText	   := v_vCarIniMessageText||RPAD('Servicio Correcto',30);
  Out_vMessageCode 	   := '00000';
  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;

  RETURN;
  EXCEPTION

  WHEN isapre_no_corresponde THEN
	  LIMPIA;
--	  	  Out_vReturnStatus	   := '0';
	  	  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||RPAD('Codigo isapre no corresponde',30);
--	  	  Out_vMessageCode 	   := '78001';
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
  		  RETURN;
  WHEN prestador_no_existe THEN
	  LIMPIA;
--	  	  Out_vReturnStatus	   := '0';
	  	  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||RPAD('Prestador no registrado en Convenios Consalud',30);
--	  	  Out_vMessageCode 	   := '78002';
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
  		  RETURN;
  WHEN prestador_error THEN
	  LIMPIA;
--	  	  Out_vReturnStatus	   := '0';
	  	  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||RPAD('Prestador con error en Acceso',30);
--	  	  Out_vMessageCode 	   := '78003';
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
  		  RETURN;
  WHEN prestador_bloqueado  THEN
	  LIMPIA;
--	  	  Out_vReturnStatus	   := '0';
	  	  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||RPAD('Prestador no operativo para Isapre',30);
--	  	  Out_vMessageCode 	   := '78004';
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
  		  RETURN;
  WHEN no_terminal_homologado THEN
	  LIMPIA;
--	  	  Out_vReturnStatus	   := '0';
	  	  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||RPAD('Terminal Atesa no Homologado',30);
--	  	  Out_vMessageCode 	   := '78005';
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
  		  RETURN;
  WHEN convenio_no_existe THEN
	  LIMPIA;
--	  	  Out_vReturnStatus	   := '0';
	  	  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||RPAD('Convenio no existe o no Vigente',30);
--	  	  Out_vMessageCode 	   := '78006';
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
  		  RETURN;
  WHEN convenio_error THEN
	  LIMPIA;
--	  	  Out_vReturnStatus	   := '0';
	  	  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||RPAD('Convenio con error en Acceso',30);
--	  	  Out_vMessageCode 	   := '78007';
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
  		  RETURN;

  WHEN OTHERS THEN
	  LIMPIA;
--	  	  Out_vReturnStatus	   := '0';
	  	  Out_vReturnStatus	   := '1';
      	  Out_vMessageText	   := v_vCarIniMessageText||RPAD('ERROR PROC.:'||v_vNomTrans,30);
--	  	  Out_vMessageCode 	   := '78099';
   	  	  Out_vMessageCode 	   := '00000';
      	  SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
  		  RETURN;

END;
END Condatosprest_Pkg;

295 rows selected.

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
