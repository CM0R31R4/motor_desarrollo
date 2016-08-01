
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 26 18:07:40 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.4.0 - Production

SQL> SP2-0268: linesize option not a valid number
SQL> 
TEXT
--------------------------------------------------------------------------------
Package RBLEnrola_Pkg As
  ------------------------------------------------------------

  Procedure RBLEnrola /*2.5 Enrola */
  (SRV_Message		 In Out Varchar2,
   In_extCodFinanciador  In Number,
   In_extRutEnrolar	 In Varchar2,
   In_extRutBeneficiario In Varchar2,
   Out_extValido	 Out Varchar2,
   Out_extNombreComp	 Out Varchar2);

End RBLEnrola_Pkg;

12 rows selected.

SQL> 
TEXT
--------------------------------------------------------------------------------
Package Body	     RBLEnrola_Pkg As
  Procedure RBLEnrola /*2.5 Enrola */
  (SRV_Message		 In Out Varchar2,
   In_extCodFinanciador  In Number,
   In_extRutEnrolar	 In Varchar2,
   In_extRutBeneficiario In Varchar2,
   Out_extValido	 Out Varchar2,
   Out_extNombreComp	 Out Varchar2) As
    rut_aux	  number;
    RUT_benef_AUX number;
    id_afi_aux	  number;
    id_afi_aux2   number;
    oRutBen	  number;
    oDVBen	  varchar2(1);
    vError	  number;
    vError2	  number;

  BEGIN
    SRV_Message := '1000000';
    --Out_extCodError := 'S';
    --Out_extMensajeError := ' ';

    ADMIMED.SeparaRut(In_extRutEnrolar, RUT_AUX, oDVBen, vError);
    ADMIMED.SeparaRut(In_extRutBeneficiario,
		      RUT_benef_AUX,
		      oDVBen,
		      vError2);

    if vError is not null or vError2 is not null then
      Out_extValido	:= 'N';
      Out_extNombreComp := null;
      return;
    end if;

    --RUT_AUX:=substr((replace(In_extRutEnrolar,'-','')),1,length((replace(In_ex
tRutEnrolar,'-',''))) - 1);

    --RUT_benef_AUX:=substr((replace(In_extRutBeneficiario,'-','')),1,length((re
place(In_extRutBeneficiario,'-',''))) - 1);


    if In_extRutEnrolar = In_extRutBeneficiario then
      begin
	select nom_aco || ' ' || ap_pat_aco || ' ' || ap_mat_aco
	  into Out_extNombreComp
	  from acompanante
	 where rut_aco = RUT_AUX
	   and estado like '%B';
	Out_extValido := 'S';
      exception
	when no_data_found then
	  Out_extValido     := 'N';
	  Out_extNombreComp := null;
      end;
      return;
    else
      --Verifico acompa?ante valido
      begin
	select id_afi, nom_aco || ' ' || ap_pat_aco || ' ' || ap_mat_aco
	  into id_afi_aux, Out_extNombreComp
	  from acompanante
	 where RUT_ACO = RUT_AUX
	   and estado like '%B'
	   and admafil.f_calcula_edad_diferida(fec_nac, sysdate) >= 18;
      exception
	when no_data_found then
	  Out_extValido     := 'N';
	  Out_extNombreComp := null;
      end;
      -- Verifico si el Beneficiario es valido
      begin
	select id_afi
	  into id_afi_aux2
	  from acompanante
	 where RUT_ACO = RUT_benef_AUX
	   and estado like '%B'; -- and f_calcula_edad_diferida(fec_nac,sysdate)
>=18;

      exception
	when no_data_found then
	  Out_extValido     := 'N';
	  Out_extNombreComp := null;
      end;

      if id_afi_aux = id_afi_aux2 then
	Out_extValido := 'S';
      else
	Out_extValido	  := 'N';
	Out_extNombreComp := null;
      end if;

      return;
    end if;

  END RBLEnrola;
end RBLEnrola_Pkg;



92 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.4.0 - Production
