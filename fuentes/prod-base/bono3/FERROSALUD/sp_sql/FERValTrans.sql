locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
1> 2> Text
Create Proc FERValTrans (@extCodFinanciador    Int,

			 @extFolioFinanciador  Numeric(10),

			 @extAccion            Char(1),

			 @extPregunta          Char(1),

			 @extRespuesta         char(1)    Output,

			 @extCodError          char(1)    Output,

			 @extMensajeError      Char(30)   Output

			 )

/*-------------------------------------------------------------------------------

- Nombre SP        : FERValTrans

- Desarrollado por : Paulina Zuniga

- Fecha Creacion   : 03 / 01 / 2006

- Objetivo         : Servicio que completa el ciclo y anula o devuelve bonos

--------------------------------------------------------------------------------*/

as

Declare @JextRespuesta    Char(1)

--Declare @JextCodError     Char(1)

--Declare @extMsgError Char(30)

Declare @cont            Int



--print @extFolioFinanciador



Select @cont = 0

  Begin Tran

	IF @extAccion = 'C'

		Begin

			Select @cont = count(hist_bonos.FolioFinanciador)

			From Cod_Fin,hist_bonos

			Where Cod_Fin.CodFin = @extCodFinanciador

			And hist_bonos.FolioFinanciador = @extFolioFinanciador



			IF @extPregunta = 'A'

				If @cont > 0

				     Select @JextRespuesta = 'E'

				Else

				     Select @JextRespuesta = 'N'

			IF @extPregunta = 'V'

				If @cont > 0

				     Select @JextRespuesta = 'E'

				Else

				     Select @JextRespuesta = 'N'

		end



        Select @Cont = count(*)

	From hist_bonos

	Where hist_bonos.FolioFinanciador = @extFolioFinanciador

	--and hist_bonos.FechaInicio = @fechaTratamiento



	IF @@Error <> 0

        	BEGIN

        	     --Rollback Tran

          	     SELECT @extCodError = 'S'

          	     SELECT @extMensajeError = 'Error en la solicitud de folios'

          	     Return

        	END



	If @Cont > 0

	    Select @extRespuesta=@JextRespuesta,@extCodError = 'N', @extMensajeError = 'Registro Encontrado'

	Else

       	    SELECT @extRespuesta=@JextRespuesta,@extCodError = 'S',@extMensajeError = ' '



  	 --   SELECT @extCodError as 'extCodError',@extMsgError as 'extMensajeError'



   Commit Tran

Return

(65 rows affected)
(return status = 0)
1> 