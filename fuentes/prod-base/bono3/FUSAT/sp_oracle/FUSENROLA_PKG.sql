
SQL*Plus: Release 11.2.0.3.0 Production on Tue Aug 4 11:31:14 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.5.0 - 64bit Production

SQL> SQL> PROCEDURE CHUENROLA
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTRUTENROLAR		VARCHAR2		IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 OUT_EXTVALIDO			VARCHAR2		OUT
 OUT_EXTNOMBRECOMP		VARCHAR2		OUT
PROCEDURE FUSENROLA
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTRUTENROLAR		VARCHAR2		IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 OUT_EXTVALIDO			VARCHAR2		OUT
 OUT_EXTNOMBRECOMP		VARCHAR2		OUT
PROCEDURE RBLENROLA
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTRUTENROLAR		VARCHAR2		IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 OUT_EXTVALIDO			VARCHAR2		OUT
 OUT_EXTNOMBRECOMP		VARCHAR2		OUT
PROCEDURE SNLENROLA
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTRUTENROLAR		VARCHAR2		IN
 IN_EXTRUTBENEFICIARIO		VARCHAR2		IN
 OUT_EXTVALIDO			VARCHAR2		OUT
 OUT_EXTNOMBRECOMP		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	FUSEnrola_Pkg As
------------------------------------------------------------


Procedure  FUSEnrola	/*2.5 Enrola */
    ( SRV_Message		     In Out	Varchar2
	, In_extCodFinanciador 	  		 In	    Number
    , In_extRutEnrolar				 In	    Varchar2
    , In_extRutBeneficiario			 In	    Varchar2
    , Out_extValido					 Out	    Varchar2
	, Out_extNombreComp				 Out	    Varchar2
    );

Procedure  SNLEnrola	/*2.5 Enrola */
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extRutEnrolar		       In	  Varchar2
    , In_extRutBeneficiario		In	   Varchar2
    , Out_extValido			Out	   Varchar2
    , Out_extNombreComp 		Out	   Varchar2
    );
    	
Procedure  RBLEnrola	/*2.5 Enrola */
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extRutEnrolar		       In	  Varchar2
    , In_extRutBeneficiario		In	   Varchar2
    , Out_extValido			Out	   Varchar2
    , Out_extNombreComp 		Out	   Varchar2
    );
Procedure  CHUEnrola	/*2.5 Enrola */
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extRutEnrolar		       In	  Varchar2
    , In_extRutBeneficiario		In	   Varchar2
    , Out_extValido			Out	   Varchar2
    , Out_extNombreComp 		Out	   Varchar2
    );

	End FUSEnrola_Pkg;

40 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     FUSEnrola_Pkg As
Procedure FUSEnrola	/*2.5 Enrola */
    ( SRV_Message		     In Out	Varchar2
	, In_extCodFinanciador 	  		 In	    Number
    , In_extRutEnrolar				 In	    Varchar2
    , In_extRutBeneficiario			 In	    Varchar2
    , Out_extValido					 Out	    Varchar2
	, Out_extNombreComp				 Out	    Varchar2
    )As
	rut_aux 		number;
	RUT_benef_AUX	number;
	id_afi_aux 		number;
	id_afi_aux2		number;
	oRutBen			number;
	oDVBen			varchar2(1);
	vError			number;
	vError2			number;


	BEGIN
	SRV_Message := '1000000';
    --Out_extCodError := 'S';
    --Out_extMensajeError := ' ';

	ADMIMED.SeparaRut(In_extRutEnrolar, RUT_AUX,oDVBen,vError);
	ADMIMED.SeparaRut(In_extRutBeneficiario, RUT_benef_AUX,oDVBen,vError2);

	if vError is not null or vError2 is not null then
 	   Out_extValido:='N';
   	   Out_extNombreComp:=null;
	 return;
	end if;


	 --RUT_AUX:=substr((replace(In_extRutEnrolar,'-','')),1,length((replace(In_extRutEnrolar,'-',''))) - 1);
	 --RUT_benef_AUX:=substr((replace(In_extRutBeneficiario,'-','')),1,length((replace(In_extRutBeneficiario,'-',''))) - 1);


	 if In_extRutEnrolar=In_extRutBeneficiario	then
		 begin
			 select nom_aco||' '||ap_pat_aco||' '||ap_mat_aco
			 into Out_extNombreComp
			 from acompanante where rut_aco=RUT_AUX and estado like '%B';
			 Out_extValido:='S';
	     Out_extNombreComp:=substr(Out_extNombreComp,1,40);
		 exception
			 when no_data_found then
			 Out_extValido:='N';
			 Out_extNombreComp:=null;
			 when too_many_rows then
			  Out_extValido:='N';
			 Out_extNombreComp:=null;
		 end;
		 return;
	 else
	 --Verifico acompa?ante valido
	 	 begin
			 select id_afi,nom_aco||' '||ap_pat_aco||' '||ap_mat_aco
			 into id_afi_aux,Out_extNombreComp
			 from acompanante
			 where RUT_ACO=RUT_AUX and estado like '%B' and f_calcula_edad_diferida(fec_nac,sysdate)>=18;
	     Out_extNombreComp:=substr(Out_extNombreComp,1,40);
		 exception
			 when no_data_found then
			 Out_extValido:='N';
			 Out_extNombreComp:=null;
			  when too_many_rows then
			  Out_extValido:='N';
			 Out_extNombreComp:=null;
		 end;
	  -- Verifico si el Beneficiario es valido
		 begin
			 select id_afi
			 into id_afi_aux2
			 from acompanante
			 where RUT_ACO= RUT_benef_AUX and estado like '%B';-- and f_calcula_edad_diferida(fec_nac,sysdate)>=18;
		 exception
			 when no_data_found then
			 Out_extValido:='N';
			 Out_extNombreComp:=null;
			  when too_many_rows then
			  Out_extValido:='N';
			 Out_extNombreComp:=null;
		 end;

		 if id_afi_aux=id_afi_aux2 then
		 	 Out_extValido:='S';
		 else
			 Out_extValido:='N';
			 Out_extNombreComp:=null;
		 end if;

		return;
	 end if;


	END FUSEnrola;


Procedure SNLEnrola    /*2.5 Enrola */
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extRutEnrolar		       In	  Varchar2
    , In_extRutBeneficiario		In	   Varchar2
    , Out_extValido			Out	   Varchar2
    , Out_extNombreComp 		Out	   Varchar2
    )As

    BEGIN
	    FUSEnrola	( SRV_Message
			, In_extCodFinanciador
			, In_extRutEnrolar
			, In_extRutBeneficiario
			, Out_extValido
			, Out_extNombreComp
			);
    END SNLEnrola;

Procedure RBLEnrola    /*2.5 Enrola */
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extRutEnrolar		       In	  Varchar2
    , In_extRutBeneficiario		In	   Varchar2
    , Out_extValido			Out	   Varchar2
    , Out_extNombreComp 		Out	   Varchar2
    )As

    BEGIN
	    FUSEnrola	( SRV_Message
			, In_extCodFinanciador
			, In_extRutEnrolar
			, In_extRutBeneficiario
			, Out_extValido
			, Out_extNombreComp
			);
    END RBLEnrola;
Procedure CHUEnrola    /*2.5 Enrola */
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extRutEnrolar		       In	  Varchar2
    , In_extRutBeneficiario		In	   Varchar2
    , Out_extValido			Out	   Varchar2
    , Out_extNombreComp 		Out	   Varchar2
    )As

    BEGIN
	    FUSEnrola	( SRV_Message
			, In_extCodFinanciador
			, In_extRutEnrolar
			, In_extRutBeneficiario
			, Out_extValido
			, Out_extNombreComp
			);
    END CHUEnrola;

	end  FUSEnrola_Pkg;

156 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.5.0 - 64bit Production
