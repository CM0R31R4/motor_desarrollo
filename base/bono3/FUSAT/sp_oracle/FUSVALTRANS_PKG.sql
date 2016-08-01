
SQL*Plus: Release 11.2.0.3.0 Production on Mon Aug 3 16:47:48 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Release 10.2.0.5.0 - 64bit Production

SQL> SQL> PROCEDURE CHUVALTRANS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTFOLIOFINANCIADOR 	NUMBER			IN
 IN_EXTACCION			VARCHAR2		IN
 IN_EXTPREGUNTA 		VARCHAR2		IN
 OUT_EXTRESPUESTA		VARCHAR2		OUT
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
PROCEDURE FUSVALTRANS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTFOLIOFINANCIADOR 	NUMBER			IN
 IN_EXTACCION			VARCHAR2		IN
 IN_EXTPREGUNTA 		VARCHAR2		IN
 OUT_EXTRESPUESTA		VARCHAR2		OUT
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
PROCEDURE RBLVALTRANS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTFOLIOFINANCIADOR 	NUMBER			IN
 IN_EXTACCION			VARCHAR2		IN
 IN_EXTPREGUNTA 		VARCHAR2		IN
 OUT_EXTRESPUESTA		VARCHAR2		OUT
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT
PROCEDURE SNLVALTRANS
 Argument Name			Type			In/Out Default?
 ------------------------------ ----------------------- ------ --------
 SRV_MESSAGE			VARCHAR2		IN/OUT
 IN_EXTCODFINANCIADOR		NUMBER			IN
 IN_EXTFOLIOFINANCIADOR 	NUMBER			IN
 IN_EXTACCION			VARCHAR2		IN
 IN_EXTPREGUNTA 		VARCHAR2		IN
 OUT_EXTRESPUESTA		VARCHAR2		OUT
 OUT_EXTCODERROR		VARCHAR2		OUT
 OUT_EXTMENSAJEERROR		VARCHAR2		OUT

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE 	FUSValTrans_Pkg As
PROCEDURE FUSValTrans	  /*2.4 Valida,Anula o Devuelve Transaccion*/
    ( SRV_Message		     In Out	Varchar2
	, In_extCodFinanciador 	  		 In	    Number
    , In_extFolioFinanciador		 In	    Number
    , In_extAccion					 In	    Varchar2 -- C=Confirmacion
	, In_extPregunta				 In	    Varchar2 -- V=?Existe el Bono?    A=?El bono esta anulado o devuelto?.
	, Out_extRespuesta				 Out	    Varchar2 -- E=Existe bono,no anulado ni devuelto N=No exite el bono  A=Bono anulado o devuelto
    , Out_extCodError				 Out	    Varchar2 -- N o S
	, Out_extMensajeError			 Out	    Varchar2
    );

PROCEDURE SNLValTrans	  /*2.4 Valida,Anula o Devuelve Transaccion*/
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extFolioFinanciador	     In 	Number
    , In_extAccion		       In	  Varchar2 -- C=Confirmacion
    , In_extPregunta		     In 	Varchar2 -- V=?Existe el Bono?	  A=?El bono esta anulado o devuelto?.
    , Out_extRespuesta		       Out	  Varchar2 -- E=Existe bono,no anulado ni devuelto N=No exite el bono  A=Bono anulado o devuelto
    , Out_extCodError		      Out	 Varchar2 -- N o S
    , Out_extMensajeError	      Out	 Varchar2
    );
PROCEDURE RBLValTrans	  /*2.4 Valida,Anula o Devuelve Transaccion*/
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extFolioFinanciador	     In 	Number
    , In_extAccion		       In	  Varchar2 -- C=Confirmacion
    , In_extPregunta		     In 	Varchar2 -- V=?Existe el Bono?	  A=?El bono esta anulado o devuelto?.
    , Out_extRespuesta		       Out	  Varchar2 -- E=Existe bono,no anulado ni devuelto N=No exite el bono  A=Bono anulado o devuelto
    , Out_extCodError		      Out	 Varchar2 -- N o S
    , Out_extMensajeError	      Out	 Varchar2
    );

PROCEDURE CHUValTrans	  /*2.4 Valida,Anula o Devuelve Transaccion*/
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extFolioFinanciador	     In 	Number
    , In_extAccion		       In	  Varchar2 -- C=Confirmacion
    , In_extPregunta		     In 	Varchar2 -- V=?Existe el Bono?	  A=?El bono esta anulado o devuelto?.
    , Out_extRespuesta		       Out	  Varchar2 -- E=Existe bono,no anulado ni devuelto N=No exite el bono  A=Bono anulado o devuelto
    , Out_extCodError		      Out	 Varchar2 -- N o S
    , Out_extMensajeError	      Out	 Varchar2
    );

	end FUSValTrans_pkg;

45 rows selected.

SQL> 
TEXT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PACKAGE BODY	     FUSValTrans_Pkg As
PROCEDURE FUSValTrans	  /*2.4 Valida,Anula o Devuelve Transaccion*/
    ( SRV_Message		     In Out	Varchar2
	, In_extCodFinanciador 	  		 In	    Number
    , In_extFolioFinanciador		 In	    Number
    , In_extAccion					 In	    Varchar2 -- C=Confirmacion
	, In_extPregunta				 In	    Varchar2 -- V=?Existe el Bono?    A=?El bono esta anulado o devuelto?.
	, Out_extRespuesta				 Out	    Varchar2 -- E=Existe bono,no anulado ni devuelto N=No exite el bono  A=Bono anulado o devuelto
    , Out_extCodError				 Out	    Varchar2 -- N o S
	, Out_extMensajeError			 Out	    Varchar2
    )as
	num_aux number;
	estado_aux  varchar2(50);
	BEGIN
	SRV_Message := '1000000';
    Out_extCodError := 'S';
    Out_extMensajeError := ' ';

		-- Valido codigo financiador
		if In_extCodFinanciador not in (62,63,65,68) then
		    Out_extCodError:='N';
		    Out_extMensajeError:='Codigo Financiador Erroneo';
		    Return;
		end if;
		-- Valido el tipo de accion
		if upper(In_extAccion)<>'C' then
			Out_extCodError:='N';
			Out_extMensajeError:='Tipo de Accion, debe ser C';
			return;
		end if;

		--Valido el tipo de pregunta
		if upper(In_extPregunta) not in ('V','A') then
		Out_extCodError:='N';
		Out_extMensajeError:='Tipo de preg.debe ser V o A';
		return;
		end if;

		begin

			select num,beeo_cod
			into   num_aux,estado_aux
			from   ben_beneficio
			where  num=In_extFolioFinanciador;

			if  upper(In_extPregunta)='V' then
				Out_extRespuesta	:='E';

			elsif  upper(In_extPregunta)='A' then
				if estado_aux='ANUL' then
				Out_extRespuesta	:='A';
				else
				Out_extRespuesta	:='E';
				end if;

			end if;
			Out_extCodError 	:='S';
			Out_extMensajeError :=' ';
			return;

		exception
		when no_data_found then
			Out_extRespuesta:='N';
			Out_extCodError:='S';
			Out_extMensajeError:=' ';
		end;

	END FUSValTrans;

PROCEDURE SNLValTrans	  /*2.4 Valida,Anula o Devuelve Transaccion*/
    ( SRV_Message		     In Out	Varchar2
	, In_extCodFinanciador 	  		 In	    Number
    , In_extFolioFinanciador		 In	    Number
    , In_extAccion					 In	    Varchar2 -- C=Confirmacion
	, In_extPregunta				 In	    Varchar2 -- V=?Existe el Bono?    A=?El bono esta anulado o devuelto?.
	, Out_extRespuesta				 Out	    Varchar2 -- E=Existe bono,no anulado ni devuelto N=No exite el bono  A=Bono anulado o devuelto
    , Out_extCodError				 Out	    Varchar2 -- N o S
	, Out_extMensajeError			 Out	    Varchar2
    )as
    BEGIN
	FUSValTrans ( SRV_Message
		    , In_extCodFinanciador
		    , In_extFolioFinanciador
		    , In_extAccion
		    , In_extPregunta
		    , Out_extRespuesta
		    , Out_extCodError
		    , Out_extMensajeError);

	END SNLValTrans;

PROCEDURE RBLValTrans	  /*2.4 Valida,Anula o Devuelve Transaccion*/
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extFolioFinanciador	     In 	Number
    , In_extAccion		       In	  Varchar2 -- C=Confirmacion
    , In_extPregunta		     In 	Varchar2 -- V=?Existe el Bono?	  A=?El bono esta anulado o devuelto?.
    , Out_extRespuesta		       Out	  Varchar2 -- E=Existe bono,no anulado ni devuelto N=No exite el bono  A=Bono anulado o devuelto
    , Out_extCodError		      Out	 Varchar2 -- N o S
    , Out_extMensajeError	      Out	 Varchar2
    )as
    BEGIN
	FUSValTrans ( SRV_Message
		    , In_extCodFinanciador
		    , In_extFolioFinanciador
		    , In_extAccion
		    , In_extPregunta
		    , Out_extRespuesta
		    , Out_extCodError
		    , Out_extMensajeError);

    END RBLValTrans;

PROCEDURE CHUValTrans	  /*2.4 Valida,Anula o Devuelve Transaccion*/
    ( SRV_Message		     In Out	Varchar2
    , In_extCodFinanciador		  In	     Number
    , In_extFolioFinanciador	     In 	Number
    , In_extAccion		       In	  Varchar2 -- C=Confirmacion
    , In_extPregunta		     In 	Varchar2 -- V=?Existe el Bono?	  A=?El bono esta anulado o devuelto?.
    , Out_extRespuesta		       Out	  Varchar2 -- E=Existe bono,no anulado ni devuelto N=No exite el bono  A=Bono anulado o devuelto
    , Out_extCodError		      Out	 Varchar2 -- N o S
    , Out_extMensajeError	      Out	 Varchar2
    )as
    BEGIN
	FUSValTrans ( SRV_Message
		    , In_extCodFinanciador
		    , In_extFolioFinanciador
		    , In_extAccion
		    , In_extPregunta
		    , Out_extRespuesta
		    , Out_extCodError
		    , Out_extMensajeError);

    END CHUValTrans;

	end FUSValTrans_pkg;

136 rows selected.

SQL> Disconnected from Oracle Database 10g Release 10.2.0.5.0 - 64bit Production
