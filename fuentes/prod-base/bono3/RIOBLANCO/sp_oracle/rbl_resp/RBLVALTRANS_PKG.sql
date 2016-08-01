
SQL*Plus: Release 11.2.0.3.0 Production on Thu Aug 8 19:36:50 2013

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

SQL> Disconnected from Oracle Database 10g Release 10.2.0.4.0 - Production
