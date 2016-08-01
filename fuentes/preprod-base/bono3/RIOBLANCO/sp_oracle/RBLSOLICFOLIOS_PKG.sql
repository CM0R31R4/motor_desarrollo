
SQL*Plus: Release 11.2.0.3.0 Production on Wed Feb 26 18:07:41 2014

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.4.0 - Production

SQL> SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package RBLSolicFolios_Pkg As
------------------------------------------------------------
--Para FNDSolicFolios.
  TYPE Out_extFoliosDevueltos_arr IS TABLE OF  Number(10)
    INDEX BY BINARY_INTEGER; 	

Procedure RBLSolicFolios
    ( SRV_Message		     In Out	Varchar2,
	  In_extCodFinanciador 	  		 In	    Number
    , In_extNumFolios				 In	    Number
    , Out_extCodError				 Out	    Varchar2
    , Out_extMensajeError			 Out	    Varchar2
	, Out_extFoliosDevueltos		 Out	    Out_extFoliosDevueltos_arr
    );


	End RBLSolicFolios_Pkg;

17 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Package Body	     RBLSolicFolios_Pkg As
  /*  Beneficiarios asociados al Titular, Fundacion  */
  PROCEDURE RBLSolicFolios(SRV_Message		  In Out Varchar2,
			   In_extCodFinanciador   In Number,
			   In_extNumFolios	  In Number,
			   Out_extCodError	  Out Varchar2,
			   Out_extMensajeError	  Out Varchar2,
			   Out_extFoliosDevueltos Out Out_extFoliosDevueltos_arr) as

    indice Number;
  BEGIN
    SRV_Message 	:= '1000000';
    Out_extCodError	:= ' ';
    Out_extMensajeError := ' ';

    -- Valido codigo financiador
    if In_extCodFinanciador <> 68 then
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'Codigo Financiador Erroneo';
      Return;
    end if;

    if In_extNumFolios > 0 then
      indice := 1;
      while indice <= In_extNumFolios loop
	begin
	  select admbene.ben_ord_ate_seq.nextval
	    into Out_extFoliosDevueltos(indice)
	    from dual;
	  insert into imed_folios
	    (FOLIO, ESTADO, FECHA_ENVIO, FECHA_RESPUESTA)
	  values
	    (Out_extFoliosDevueltos(indice), 'I', sysdate, null);

	  indice := indice + 1;
	exception
	  when others then
	    Rollback;
	    Out_extCodError	:= 'N';
	    Out_extMensajeError := 'Probl. en seleccion de Folio';
	    Return;
	end;
      end loop;
      Out_extCodError	  := 'S';
      Out_extMensajeError := ' ';
      commit;
    else
      Out_extCodError	  := 'N';
      Out_extMensajeError := 'Cant. de folios debe ser >0';
    end if;
    return;
  END RBLSolicFolios;
END RBLSolicFolios_PKG;

53 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.4.0 - Production
