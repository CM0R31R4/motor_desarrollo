
SQL*Plus: Release 11.2.0.3.0 Production on Wed Mar 5 19:00:02 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> SQL> PROCEDURE CONVALIDACAT
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_NEXTCODFINANCIADOR		NUMBER			IN
 IN_VEXTRUTCONVENIO		VARCHAR2		IN
 IN_VEXTRUTTRATANTE		VARCHAR2		IN
 IN_VEXTRUTSOLICITANTE		VARCHAR2		IN
 IN_VEXTRUTBENEFICIARIO 	VARCHAR2		IN
 IN_VEXTRUTCOTIZANTE		VARCHAR2		IN
 IN_VEXTCODIGOHOMOLOGO		VARCHAR2		IN
 IN_VEXTITEM			VARCHAR2		IN
 IN_VEXTCODIGODIAGNOSTICO	VARCHAR2		IN
 IN_VEXTCODMODALIDAD		VARCHAR2		IN
 IN_VEXTCODTIPATENCION		VARCHAR2		IN
 IN_VEXTFECHANACIMIENTO 	VARCHAR2		IN
 IN_VEXTCODSEXO 		VARCHAR2		IN
 IN_VEXTFECHAINICIO		VARCHAR2		IN
 IN_VEXTFECHATERMINO		VARCHAR2		IN
 IN_NEXTFRECPRESTDIA		NUMBER			IN
 IN_VEXTLISTAPRESTACA		VARCHAR2		IN
 IN_VEXTLISTAPRESTACB		VARCHAR2		IN
 IN_VEXTLISTAPRESTACC		VARCHAR2		IN
 IN_VEXTLISTAPRESTACD		VARCHAR2		IN
 IN_VEXTLISTAPRESTACE		VARCHAR2		IN
 IN_VEXTLISTAPRESTACF		VARCHAR2		IN
 IN_VEXTINDVIDEO		VARCHAR2		IN
 IN_VEXTINDBILATERAL		VARCHAR2		IN
 IN_VEXTRECARGOFUERAHORA	VARCHAR2		IN
 IN_VEXTINDREEMBOLSO		VARCHAR2		IN
 IN_VEXTINDPROGRAMA		VARCHAR2		IN
 IN_VEXTCODAPLICACION		VARCHAR2		IN
 IN_VEXTCODREGION		VARCHAR2		IN
 IN_VEXTCODSUCUR		VARCHAR2		IN
 IN_VEXTTIPOPRESTADOR		VARCHAR2		IN
 IN_VEXTCODESPECIALIDADES	VARCHAR2		IN
 IN_VEXTCODPROFESIONES		VARCHAR2		IN
 IN_VEXTANOSANTIGUEDAD		VARCHAR2		IN
 OUT_VEXTRESPUESTACAT		VARCHAR2		OUT
 OUT_VEXTMENSAJECAT		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	Convalidacat_Pkg
AS
   PROCEDURE Convalidacat
   			 (
   			  SRV_Message 		  			IN OUT VARCHAR2    	--(1)
   		    , In_nExtCodFinanciador	  	IN 	   NUMBER	    --(2)
		    , In_vExtRutConvenio			IN 	   VARCHAR2		--(3)
		    , In_vExtRutTratante			IN 	   VARCHAR2		--(4)
		    , In_vExtRutSolicitante			IN 	   VARCHAR2		--(5)
			, In_vExtRutBeneficiario		IN 	   VARCHAR2		--(6)
			, In_vExtRutCotizante			IN 	   VARCHAR2		--(7)
			, In_vExtCodigoHomologo			IN 	   VARCHAR2		--(8)
			, In_vExtItem					IN 	   VARCHAR2		--(9)
			, In_vExtCodigoDiagnostico		IN 	   VARCHAR2		--(10)
			, In_vExtCodModalidad			IN 	   VARCHAR2		--(11)
			, In_vExtCodTipAtencion			IN 	   VARCHAR2		--(12)
			, In_vExtFechaNacimiento		IN 	   VARCHAR2		--(13)
			, In_vExtCodSexo				IN 	   VARCHAR2		--(14)
			, In_vExtFechaInicio			IN 	   VARCHAR2		--(15)
			, In_vExtFechaTermino			IN 	   VARCHAR2		--(16)
	    , In_nExtFrecPrestDia			IN 	   NUMBER		--(17)
	    , In_vExtListaPrestacA			IN 	   VARCHAR2		--(18)
	    , In_vExtListaPrestacB			IN 	   VARCHAR2		--(19)
	    , In_vExtListaPrestacC			IN 	   VARCHAR2		--(20)
	    , In_vExtListaPrestacD			IN 	   VARCHAR2		--(21)
	    , In_vExtListaPrestacE			IN 	   VARCHAR2		--(22)
	    , In_vExtListaPrestacF			IN 	   VARCHAR2		--(23)
	    , In_vExtIndVideo				IN 	   VARCHAR2		--(24)
	    , In_vExtIndBilateral			IN 	   VARCHAR2		--(25)
	    , In_vExtRecargoFueraHora		IN 	   VARCHAR2		--(26)
	    , In_vExtIndReembolso			IN 	   VARCHAR2		--(27)
	    , In_vExtIndPrograma			IN 	   VARCHAR2		--(28)
	    , In_vExtCodAplicacion			IN 	   VARCHAR2		--(29)
	    , In_vExtCodRegion				IN 	   VARCHAR2		--(30)
	    , In_vExtCodSucur				IN 	   VARCHAR2		--(31)
	    , In_vExtTipoPrestador			IN 	   VARCHAR2		--(32)
	    , In_vExtCodEspecialidades		IN 	   VARCHAR2		--(33)
	    , In_vExtCodProfesiones			IN 	   VARCHAR2		--(34)
	    , In_vExtAnosAntiguedad			IN 	   VARCHAR2		--(35)
	    , Out_vExtRespuestaCAT			OUT	   VARCHAR2		--(36)
	    , Out_vExtMensajeCAT			OUT    VARCHAR2		--(37)
  			 );
END Convalidacat_Pkg;

43 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     Convalidacat_Pkg
AS

PROCEDURE Convalidacat
   			 (
   			  SRV_Message 		  			IN OUT VARCHAR2    	--(1)
   		    , In_nExtCodFinanciador	  	IN 	   NUMBER	    --(2)
		    , In_vExtRutConvenio			IN 	   VARCHAR2		--(3)
		    , In_vExtRutTratante			IN 	   VARCHAR2		--(4)
		    , In_vExtRutSolicitante			IN 	   VARCHAR2		--(5)
			, In_vExtRutBeneficiario		IN 	   VARCHAR2		--(6)
			, In_vExtRutCotizante			IN 	   VARCHAR2		--(7)
			, In_vExtCodigoHomologo			IN 	   VARCHAR2		--(8)
			, In_vExtItem					IN 	   VARCHAR2		--(9)
			, In_vExtCodigoDiagnostico		IN 	   VARCHAR2		--(10)
			, In_vExtCodModalidad			IN 	   VARCHAR2		--(11)
			, In_vExtCodTipAtencion			IN 	   VARCHAR2		--(12)
			, In_vExtFechaNacimiento		IN 	   VARCHAR2		--(13)
			, In_vExtCodSexo				IN 	   VARCHAR2		--(14)
			, In_vExtFechaInicio			IN 	   VARCHAR2		--(15)
			, In_vExtFechaTermino			IN 	   VARCHAR2		--(16)
	    , In_nExtFrecPrestDia			IN 	   NUMBER		--(17)
	    , In_vExtListaPrestacA			IN 	   VARCHAR2		--(18)
	    , In_vExtListaPrestacB			IN 	   VARCHAR2		--(19)
	    , In_vExtListaPrestacC			IN 	   VARCHAR2		--(20)
	    , In_vExtListaPrestacD			IN 	   VARCHAR2		--(21)
	    , In_vExtListaPrestacE			IN 	   VARCHAR2		--(22)
	    , In_vExtListaPrestacF			IN 	   VARCHAR2		--(23)
	    , In_vExtIndVideo				IN 	   VARCHAR2		--(24)
	    , In_vExtIndBilateral			IN 	   VARCHAR2		--(25)
	    , In_vExtRecargoFueraHora		IN 	   VARCHAR2		--(26)
	    , In_vExtIndReembolso			IN 	   VARCHAR2		--(27)
	    , In_vExtIndPrograma			IN 	   VARCHAR2		--(28)
	    , In_vExtCodAplicacion			IN 	   VARCHAR2		--(29)
	    , In_vExtCodRegion				IN 	   VARCHAR2		--(30)
	    , In_vExtCodSucur				IN 	   VARCHAR2		--(31)
	    , In_vExtTipoPrestador			IN 	   VARCHAR2		--(32)
	    , In_vExtCodEspecialidades		IN 	   VARCHAR2		--(33)
	    , In_vExtCodProfesiones			IN 	   VARCHAR2		--(34)
	    , In_vExtAnosAntiguedad			IN 	   VARCHAR2		--(35)
	    , Out_vExtRespuestaCAT			OUT	   VARCHAR2		--(36)
	    , Out_vExtMensajeCAT			OUT    VARCHAR2		--(37)
   			 )
IS
v_vNomTrans				   		   		    VARCHAR2(50):= UPPER('CONVALIDACAT_PKG');

v_vEntrada_Format				 			VARCHAR2(2000);
v_vSalida_Format							VARCHAR2(2000);
v_sep_ES	   								VARCHAR2(1):=';';
Out_vReturnStatus							VARCHAR2(1);
Out_vMessageCode 						  	VARCHAR2(5);
Out_vMessageText							VARCHAR2(243);
SRV_FetchStatus								NUMBER(1) := '0'; -- No tiene variables tipo Column Output
SRV_Total_Rows								NUMBER(8);
SRV_Row_Count								NUMBER(8);
v_vCarIniMessageText						VARCHAR2(1):='X'; -- Para diferenciar Out_vMessageText
														  	  -- de Out_vExtMensajeError
-- Codigo de la Isapre para Validar contra entrada
v_nCod_Isa_Cons  		   	 	   	   	    NUMBER  :=71;

isapre_no_corresponde	   				    EXCEPTION;
------------------------------------------------------------------------------------


w_sep  		  	  		   VARCHAR2 (1):='|';	 -- separador utilizado para entrada y salida

w_nExtCodFinanciador	   NUMBER(3);			 -- codigo de la isapre
w_nExtRutConvenio		   NUMBER(10);			 -- rut del convenio
w_nExtRutTratante		   NUMBER(10);			 -- rut del tratante
w_nExtRutSolicitante	   NUMBER(10);			 -- rut del solicitante
w_nExtRutBeneficiario	   NUMBER(10);			 -- rut del beneficiario
w_nExtRutCotizante		   NUMBER(10);			 --	rut del cotizante
w_nExtCodigoHomologo	   NUMBER(10);			 -- codigo prestacion isapre
w_nExtItem				   NUMBER(2);			 -- item de la prestacion
w_vExtCodigoDiagnostico	   VARCHAR2(10);		 -- codigo de diagnostico
w_nExtCodModalidad		   NUMBER(2);			 -- codigo modalidad 01=libre elccion 02=???
w_nExtCodTipAtencion	   NUMBER(2);			 -- codigo del tipo atencion 01, 02,
w_dExtFechaNacimiento	   DATE;				 -- fecha de nacimiento
w_vExtCodSexo			   VARCHAR2(1);			 -- codigo del sexo  F, M,
w_dExtFechaInicio		   DATE;				 -- fecha inicio tratamiento
w_dExtFechaTermino		   DATE;				 -- fecha termino tratamiento
w_nExtFrecPrestDia		   NUMBER(6);			 -- cantidad de la prestacion que se desea vender
w_vExtListaPrestacA		   VARCHAR2(255);		 -- lista A que contiene 7 lineas del bono
w_vExtListaPrestacB		   VARCHAR2(255);		 -- lista A que contiene 7 lineas del bono
w_vExtListaPrestacC		   VARCHAR2(255);		 -- lista A que contiene 7 lineas del bono
w_vExtListaPrestacD		   VARCHAR2(255);		 -- lista A que contiene 7 lineas del bono
w_vExtListaPrestacE		   VARCHAR2(255);		 -- lista A que contiene 7 lineas del bono
w_vExtListaPrestacF		   VARCHAR2(255);		 -- lista A que contiene 7 lineas del bono
w_nExtIndVideo			   NUMBER(1);			 -- indicador de videolaparoscopia
w_nExtIndBilateral		   NUMBER(1);			 -- indicador de Bilateralidad
w_vExtRecargoFueraHora	   VARCHAR2(1);			 -- recargo fuera de horario  N, S
w_vExtIndReembolso		   VARCHAR2(1);			 -- indicador de reembolso  N, S
w_vExtIndPrograma		   VARCHAR2(1);			 -- indica si prestacion se origino desde programa  N, S
w_nExtCodAplicacion		   NUMBER(2);			 -- codigo aplicacion  01=vta.directa 02=pago prestador 03=facturacion 04=vta.innovadora
w_vExtCodRegion			   VARCHAR2(3);			 -- codigo de la region
w_vExtCodSucur			   VARCHAR2(10);		 -- codigo de la sucursal
w_nExtTipoPrestador		   NUMBER(1);			 -- tipo de prestador  1=institucion 2=persona natural
w_vExtCodEspecialidades	   VARCHAR2(255);		 -- lista de especialidades del prestador
w_vExtCodProfesiones	   VARCHAR2(255);		 -- lista de profesiones del prestador
w_nExtAnosAntiguedad	   NUMBER(2);			 -- a?os de antiguedad del titulo profesional del prestador

sal			   NUMBER(1):=0;
glosa			   VARCHAR(30);

FUNCTION SETEA_ENTRADA
RETURN VARCHAR2
IS
v_vEntrada			   VARCHAR2(2000);
BEGIN
v_vEntrada	:=  SUBSTR(TO_CHAR(In_nExtCodFinanciador)||v_sep_ES||
		    	In_vExtRutConvenio||v_sep_ES||
			In_vExtRutTratante||v_sep_ES||
		     	In_vExtRutSolicitante||v_sep_ES||
			 	In_vExtRutBeneficiario||v_sep_ES||
			 	In_vExtRutCotizante||v_sep_ES||
			 	In_vExtCodigoHomologo||v_sep_ES||
			 	In_vExtItem||v_sep_ES||
				In_vExtCodigoDiagnostico||v_sep_ES||
			    In_vExtCodModalidad||v_sep_ES||
				In_vExtCodTipAtencion||v_sep_ES||
				In_vExtFechaNacimiento||v_sep_ES||
				In_vExtCodSexo||v_sep_ES||
			    In_vExtFechaInicio||v_sep_ES||
			  	In_vExtFechaTermino||v_sep_ES||
	      	TO_CHAR(In_nExtFrecPrestDia)||v_sep_ES||
	      	In_vExtListaPrestacA||v_sep_ES||
	      	In_vExtListaPrestacB||v_sep_ES||
	      	In_vExtListaPrestacC||v_sep_ES||
	      	In_vExtListaPrestacD||v_sep_ES||
	    	In_vExtListaPrestacE||v_sep_ES||
	    	In_vExtListaPrestacF||v_sep_ES||
	    	In_vExtIndVideo||v_sep_ES||
	    	In_vExtIndBilateral||v_sep_ES||
	    	In_vExtRecargoFueraHora||v_sep_ES||
	    	In_vExtIndReembolso||v_sep_ES||
	    	In_vExtIndPrograma||v_sep_ES||
	    	In_vExtCodAplicacion||v_sep_ES||
	    	In_vExtCodRegion||v_sep_ES||
	    	In_vExtCodSucur||v_sep_ES||
	    	In_vExtTipoPrestador||v_sep_ES||
	    	In_vExtCodEspecialidades||v_sep_ES||
	    	In_vExtCodProfesiones||v_sep_ES||
	    	In_vExtAnosAntiguedad||v_sep_ES,1,2000);
RETURN v_vEntrada;
END;


FUNCTION SETEA_SALIDA
RETURN VARCHAR2
IS
v_vSalida	   VARCHAR2(2000);

BEGIN

v_vSalida:=  SUBSTR(SRV_Message||v_sep_ES||
			 Out_vExtRespuestaCAT||v_sep_ES||
			 Out_vExtMensajeCAT||v_sep_ES,1,2000);

RETURN v_vSalida;
END;

PROCEDURE LIMPIA
AS
BEGIN
  Out_vExtRespuestaCAT := ' ';
  Out_vExtMensajeCAT   := ' ';
END;

BEGIN
   w_nExtCodFinanciador    := In_nExtCodFinanciador;

-- Si el codigo no corresponde a Consalud
   IF ( w_nExtCodFinanciador != v_ncod_isa_cons )
   THEN
     RAISE isapre_no_corresponde;
   END IF;

	w_nExtRutConvenio	   := TO_NUMBER(SUBSTR(In_vExtRutConvenio,1,10));
	w_nExtRutTratante	   := TO_NUMBER(SUBSTR(In_vExtRutTratante,1,10));
	w_nExtRutSolicitante   := TO_NUMBER(SUBSTR(In_vExtRutSolicitante,1,10));
	w_nExtRutBeneficiario  := TO_NUMBER(SUBSTR(In_vExtRutBeneficiario,1,10));
	w_nExtRutCotizante	   := TO_NUMBER(SUBSTR(In_vExtRutCotizante,1,10));
	w_nExtCodigoHomologo   := TO_NUMBER(In_vExtCodigoHomologo);
	w_nExtItem			   := TO_NUMBER(In_vExtItem);
	w_vExtCodigoDiagnostico:=	    In_vExtCodigoDiagnostico;
	w_nExtCodModalidad     := TO_NUMBER(In_vExtCodModalidad);
	w_nExtCodTipAtencion   := TO_NUMBER(In_vExtCodTipAtencion);
	w_dExtFechaNacimiento  :=   TO_DATE(SUBSTR(In_vExtFechaNacimiento,1,14),'rrrrmmddh24miss');
	w_vExtCodSexo		   :=		In_vExtCodSexo;
	w_dExtFechaInicio	   :=	TO_DATE(SUBSTR(In_vExtFechaInicio,1,14),'rrrrmmddh24miss');
	w_dExtFechaTermino	   :=	TO_DATE(SUBSTR(In_vExtFechaTermino,1,14),'rrrrmmddh24miss');
	w_nExtFrecPrestDia     := 		    In_nExtFrecPrestDia;
	w_vExtListaPrestacA	   :=		In_vExtListaPrestacA;
	w_vExtListaPrestacB	   :=		In_vExtListaPrestacB;
	w_vExtListaPrestacC	   :=		In_vExtListaPrestacC;
	w_vExtListaPrestacD	   :=		In_vExtListaPrestacD;
	w_vExtListaPrestacE	   :=		In_vExtListaPrestacE;
	w_vExtListaPrestacF	   :=		In_vExtListaPrestacF;
	w_nExtIndVideo	       := TO_NUMBER(In_vExtIndVideo);
	w_nExtIndBilateral	   := TO_NUMBER(In_vExtIndBilateral);
	w_vExtRecargoFueraHora :=	    In_vExtRecargoFueraHora;
	w_vExtIndReembolso	   :=		In_vExtIndReembolso;
	w_vExtIndPrograma	   :=		In_vExtIndPrograma;
	w_nExtCodAplicacion    := TO_NUMBER(In_vExtCodAplicacion);
	w_vExtCodRegion		   :=		In_vExtCodRegion;
	w_vExtCodSucur		   :=		In_vExtCodSucur;
	w_nExtTipoPrestador    := TO_NUMBER(In_vExtTipoPrestador);
	w_vExtCodEspecialidades:=	    In_vExtCodEspecialidades;
	w_vExtCodProfesiones   :=	    In_vExtCodProfesiones;
	w_nExtAnosAntiguedad   := TO_NUMBER(In_vExtAnosAntiguedad);

    Out_vExtRespuestaCAT   := Llena_Blancos('N',1);
	Out_vExtMensajeCAT	   := Llena_Blancos('Prestacion Validada OK',100);
	Out_vReturnStatus	   := '1';
	Out_vMessageText	   := v_vCarIniMessageText||Out_vExtMensajeCAT;
--	Out_vMessageCode 	   := '38001';
	Out_vMessageCode 	   := '0000';
	SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
EXCEPTION
  WHEN isapre_no_corresponde THEN
	LIMPIA;
--	Out_vReturnStatus	   := '0';
	Out_vReturnStatus	   := '1';
    Out_vMessageText	   := v_vCarIniMessageText||'Codigo isapre no corresponde';
--	Out_vMessageCode 	   := '78001';
   	Out_vMessageCode 	   := '00000';
    SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
    RETURN;
  WHEN OTHERS THEN
	LIMPIA;
--	Out_vReturnStatus	   := '0';
	Out_vReturnStatus	   := '1';
    Out_vMessageText	   := RPAD('ERROR PROC.:'||v_vNomTrans,30);
--	Out_vMessageCode 	   := '78050';
	Out_vMessageCode 	   := '00000';
    SRV_Message 		   := Out_vReturnStatus||Out_vMessageCode||SRV_FetchStatus||Out_vMessageText;
    RETURN;
END;
END Convalidacat_Pkg;

239 rows selected.

SQL> Disconnected from Oracle Database 10g Enterprise Edition Release 10.2.0.5.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
