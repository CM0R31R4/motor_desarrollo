
SQL*Plus: Release 11.2.0.3.0 Production on Tue Mar 10 12:46:28 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
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


44 rows selected.

SQL> 
no rows selected

SQL> Disconnected from Oracle Database 11g Enterprise Edition Release 11.2.0.4.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options
