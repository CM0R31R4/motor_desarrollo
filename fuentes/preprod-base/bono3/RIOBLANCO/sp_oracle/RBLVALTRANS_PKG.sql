
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 26 18:07:42 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.4.0 - Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package RBLValTrans_Pkg As
PROCEDURE RBLValTrans	  /*2.4 Valida,Anula o Devuelve Transaccion*/
    ( SRV_Message		     In Out	Varchar2
	, In_extCodFinanciador 	  		 In	    Number
    , In_extFolioFinanciador		 In	    Number
    , In_extAccion					 In	    Varchar2 -- C=Confirmacion
	, In_extPregunta				 In	    Varchar2 -- V=?Existe el Bono?    A=?El bono esta anulado o devuelto?.
	, Out_extRespuesta				 Out	    Varchar2 -- E=Existe bono,no anulado ni devuelto N=No exite el bono  A=Bono anulado o devuelto
    , Out_extCodError				 Out	    Varchar2 -- N o S
	, Out_extMensajeError			 Out	    Varchar2
    );
	end RBLValTrans_pkg;

12 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package Body	     RBLValTrans_Pkg As
  PROCEDURE RBLValTrans /*2.4 Valida,Anula o Devuelve Transaccion*/
  (SRV_Message		  In Out Varchar2,
   In_extCodFinanciador   In Number,
   In_extFolioFinanciador In Number,
   In_extAccion 	  In Varchar2, -- C=Confirmacion
   In_extPregunta	  In Varchar2, -- V=?Existe el Bono?	A=?El bono esta anulado o devuelto?.
   Out_extRespuesta	  Out Varchar2, -- E=Existe bono,no anulado ni devuelto N=No exite el bono  A=Bono anulado o devuelto
   Out_extCodError	  Out Varchar2, -- N o S
   Out_extMensajeError	  Out Varchar2) as

    num_aux    number;
    estado_aux varchar2(50);

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
    -- Valido el tipo de accion
    if upper(In_extAccion) <> 'C' then
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'Tipo de Accion, debe ser C';
      return;
    end if;

    --Valido el tipo de pregunta
    if upper(In_extPregunta) not in ('V', 'A') then
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'Tipo de preg.debe ser V o A';
      return;
    end if;

    begin

      select num, beeo_cod
	into num_aux, estado_aux
	from ben_beneficio
       where num = In_extFolioFinanciador;

      if upper(In_extPregunta) = 'V' then
	Out_extRespuesta := 'E';

      elsif upper(In_extPregunta) = 'A' then
	if estado_aux = 'ANUL' then
	  Out_extRespuesta := 'A';
	else
	  Out_extRespuesta := 'E';
	end if;

      end if;
      Out_extCodError	  := 'S';
      Out_extMensajeError := ' ';
      return;

    exception
      when no_data_found then
	Out_extRespuesta    := 'N';
	Out_extCodError     := 'S';
	Out_extMensajeError := ' ';
    end;

  END RBLValTrans;
end RBLValTrans_pkg;



72 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.4.0 - Production
