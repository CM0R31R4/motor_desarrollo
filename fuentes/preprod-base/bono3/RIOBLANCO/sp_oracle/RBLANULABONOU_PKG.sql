
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 26 18:07:40 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.4.0 - Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package RBLAnulaBonoU_Pkg As
------------------------------------------------------------


PROCEDURE RBLAnulaBonoU	/*2.7 Anula Transaccion */
    ( SRV_Message		     In Out	Varchar2
	, In_extCodFinanciador 	  		 In	    Number
    , In_extFolioBono				 In	    Number
    , In_extIndTratam				 In	    Varchar2
	, In_extFecTratam    			 In	    date
    , Out_extCodError				 Out	    Varchar2   --'N ','S'.
	, Out_extMensajeError			 Out	    Varchar2

    );END RBLAnulaBonoU_pkg;

14 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package Body	     RBLAnulaBonoU_Pkg As
  PROCEDURE RBLAnulaBonoU /*2.7 Anula Transaccion */
  (SRV_Message		In Out Varchar2,
   In_extCodFinanciador In Number,
   In_extFolioBono	In Number,
   In_extIndTratam	In Varchar2,
   In_extFecTratam	In date,
   Out_extCodError	Out Varchar2 --'N ','S'.
  ,
   Out_extMensajeError	Out Varchar2

   ) As
    num_aux    Number;
    estado_aux Varchar2(50);
    mensaje    Varchar2(300);
  BEGIN
    SRV_Message 	:= '1000000';
    Out_extCodError	:= 'S';
    Out_extMensajeError := ' ';

    -- Valido codigo financiador
    if In_extCodFinanciador <> 68 then
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'Codigo Financiador Erroneo';
      Return;
    end if;
    begin
      select num, beeo_cod
	into num_aux, estado_aux
	from ben_beneficio
       where num = In_extFolioBono;

      if estado_aux = 'ANUL' then
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Bono ya esta anulado';
      elsif estado_aux = 'PAGA' then
	Out_extCodError     := 'N';
	Out_extMensajeError := 'Bono esta pagado, no se puede anular';
      else
	ADMBENE.BEN_ANULAR_ORDEN_ATENCION(In_extFolioBono, 'IMED', mensaje);
	if mensaje is not null then
	  Out_extCodError     := 'N';
	  Out_extMensajeError := substr(mensaje, 1, 30);
	end if;

      end if;
      return;

    exception
      when no_data_found then

	Out_extCodError     := 'N';
	Out_extMensajeError := 'Folio no existe';

	return;
    end;

  END RBLAnulaBonoU;
end RBLAnulaBonoU_Pkg;



61 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.4.0 - Production
