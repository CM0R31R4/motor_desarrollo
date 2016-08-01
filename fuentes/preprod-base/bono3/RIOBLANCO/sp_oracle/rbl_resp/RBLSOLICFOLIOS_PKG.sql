
SQL*Plus: Release 11.2.0.3.0 Production on Thu Aug 8 19:36:49 2013

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

SQL> Disconnected from Oracle Database 10g Release 10.2.0.4.0 - Production
