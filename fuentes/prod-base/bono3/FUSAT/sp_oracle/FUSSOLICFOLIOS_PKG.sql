
SQL*Plus: Release 11.2.0.3.0 Production on Tue Aug 4 11:31:16 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.5.0 - 64bit Production

SQL> SQL> PROCEDURE CHUSOLICFOLIOS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTNUMFOLIOS		NUMBER			IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 OUT_EXTFOLIOSDEVUELTOS 	TABLE OF NUMBER(10)	OUT
PROCEDURE FUSSOLICFOLIOS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTNUMFOLIOS		NUMBER			IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 OUT_EXTFOLIOSDEVUELTOS 	TABLE OF NUMBER(10)	OUT
PROCEDURE RBLSOLICFOLIOS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTNUMFOLIOS		NUMBER			IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 OUT_EXTFOLIOSDEVUELTOS 	TABLE OF NUMBER(10)	OUT
PROCEDURE SNLSOLICFOLIOS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTNUMFOLIOS		NUMBER			IN
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
 OUT_EXTFOLIOSDEVUELTOS 	TABLE OF NUMBER(10)	OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	FUSSolicFolios_Pkg As
  TYPE Out_extFoliosDevueltos_arr IS TABLE OF  Number(10)
    INDEX BY BINARY_INTEGER; 	

Procedure FUSSolicFolios
    ( SRV_Message		     In Out	Varchar2,
	  In_extCodFinanciador 	  		 In	    Number
    , In_extNumFolios				 In	    Number
    , Out_extCodError				 Out	    Varchar2
    , Out_extMensajeError			 Out	    Varchar2
	, Out_extFoliosDevueltos		 Out	    Out_extFoliosDevueltos_arr
    );

Procedure snlSolicFolios
    ( SRV_Message		     In Out	Varchar2,
      In_extCodFinanciador		  In	     Number
    , In_extNumFolios		      In	 Number
    , Out_extCodError		      Out	 Varchar2
    , Out_extMensajeError	      Out	 Varchar2
    , Out_extFoliosDevueltos	     Out	Out_extFoliosDevueltos_arr
    );
Procedure rblSolicFolios
    ( SRV_Message		     In Out	Varchar2,
      In_extCodFinanciador		  In	     Number
    , In_extNumFolios		      In	 Number
    , Out_extCodError		      Out	 Varchar2
    , Out_extMensajeError	      Out	 Varchar2
    , Out_extFoliosDevueltos	     Out	Out_extFoliosDevueltos_arr
    );

Procedure chuSolicFolios
    ( SRV_Message		     In Out	Varchar2,
      In_extCodFinanciador		  In	     Number
    , In_extNumFolios		      In	 Number
    , Out_extCodError		      Out	 Varchar2
    , Out_extMensajeError	      Out	 Varchar2
    , Out_extFoliosDevueltos	     Out	Out_extFoliosDevueltos_arr
    );

	End FUSSolicFolios_Pkg;

40 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     FUSSolicFolios_Pkg As    /*  Beneficiarios asociados al Titular, Fundacion  */
PROCEDURE FUSSolicFolios
    ( SRV_Message		     In Out	Varchar2,
	  In_extCodFinanciador 	  		 In	    Number
    , In_extNumFolios				 In	    Number
    , Out_extCodError				 Out	    Varchar2
    , Out_extMensajeError			 Out	    Varchar2
	, Out_extFoliosDevueltos		 Out	    Out_extFoliosDevueltos_arr
    ) as

indice Number;
BEGIN
   SRV_Message := '1000000';
    Out_extCodError := ' ';
    Out_extMensajeError := ' ';



-- Valido codigo financiador
if In_extCodFinanciador not in (65,68,63,62) then
	    Out_extCodError:='N';
	    Out_extMensajeError:='Codigo Financiador Erroneo';
	    Return;
end if;

if In_extNumFolios>0 then
	indice:=1;
		while indice <= In_extNumFolios	loop
			begin
			select admbene.ben_ord_ate_seq.nextval
			into Out_extFoliosDevueltos(indice)
			from dual;
				insert into imed_folios(FOLIO,ESTADO,FECHA_ENVIO,FECHA_RESPUESTA)
				values (Out_extFoliosDevueltos(indice),'I',sysdate,null);

			indice:=indice+1;
			exception
			when others then
			Rollback;
		    Out_extCodError:='N';
		    Out_extMensajeError:='Problemas en seleccion de Folio';
			Return;
			end;
		end loop;
	    Out_extCodError:='S';
	    Out_extMensajeError:=' ';
	    commit;
else
	   Out_extCodError:='N';
	   Out_extMensajeError:='Cantidad de folios debe ser mayor a cero';
end if;
return;
END FUSSolicFolios;

PROCEDURE SNLSolicFolios
    ( SRV_Message		     In Out	Varchar2,
	  In_extCodFinanciador 	  		 In	    Number
    , In_extNumFolios				 In	    Number
    , Out_extCodError				 Out	    Varchar2
    , Out_extMensajeError			 Out	    Varchar2
	, Out_extFoliosDevueltos		 Out	    Out_extFoliosDevueltos_arr
    ) as

    BEGIN
	FUSSolicFolios	    ( SRV_Message,
			      In_extCodFinanciador
			    , In_extNumFolios
			    , Out_extCodError
			    , Out_extMensajeError
			    , Out_extFoliosDevueltos);
    END SNLSolicFolios;

PROCEDURE RBLSolicFolios
    ( SRV_Message		     In Out	Varchar2,
      In_extCodFinanciador		  In	     Number
    , In_extNumFolios		      In	 Number
    , Out_extCodError		      Out	 Varchar2
    , Out_extMensajeError	      Out	 Varchar2
    , Out_extFoliosDevueltos	     Out	Out_extFoliosDevueltos_arr
    ) as

    BEGIN
	FUSSolicFolios	    ( SRV_Message,
			      In_extCodFinanciador
			    , In_extNumFolios
			    , Out_extCodError
			    , Out_extMensajeError
			    , Out_extFoliosDevueltos);
    END RBLSolicFolios;

PROCEDURE CHUSolicFolios
    ( SRV_Message		     In Out	Varchar2,
      In_extCodFinanciador		  In	     Number
    , In_extNumFolios		      In	 Number
    , Out_extCodError		      Out	 Varchar2
    , Out_extMensajeError	      Out	 Varchar2
    , Out_extFoliosDevueltos	     Out	Out_extFoliosDevueltos_arr
    ) as

    BEGIN
	FUSSolicFolios	    ( SRV_Message,
			      In_extCodFinanciador
			    , In_extNumFolios
			    , Out_extCodError
			    , Out_extMensajeError
			    , Out_extFoliosDevueltos);
    END CHUSolicFolios;
END FUSSolicFolios_PKG;

108 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.5.0 - 64bit Production
