locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
1> 2> Text
create proc FERAnulaBonoU (@extCodFinanciador   int,

                           @extFolioBono int,

			   @extindTratam char(1),

			   @extFecTratam smalldatetime,

			   @extCodError		Char(1)		Output,

			   @extMensajeError	Char(30)	Output

			   )

/*-------------------------------------------------------------------------------

- Nombre SP        : FERAnulaBonoU

- Desarrollado por : Paulina Zuniga

- Fecha Creacion   : 03 / 01 / 2006

- Objetivo         : Servicio que informa Folio de Bono a Anular o Devolver por

	             parte del financiador

--------------------------------------------------------------------------------*/

as  

Declare @CodError char(1)

Declare @MsgError char(30)

Declare @CodErrorS char(1)

Declare @MsgErrorS char(30)

Declare @Cont int

  Begin Tran

	select @CodError = 'N'

	select @MsgError = 'Solicitud OK'

	select @CodErrorS = 'S'

	select @MsgErrorS = 'No Existe Folio Solicitado'

	Select @Cont = 0



    Select @Cont = count(*)

	From hist_bonos 

	Where hist_bonos.FolioFinanciador = @extFolioBono

	and hist_bonos.FechaEmision = @extFecTratam

    and hist_bonos.CodFinanciador = @extCodFinanciador



	IF @@Error <> 0

        	BEGIN

          		Rollback Tran

          		SELECT @extCodError = 'S'

          		SELECT @extMensajeError = 'Error en la Anulación de folios'

          		Return

        	END



--		Select @CodError as extCodError,@MsgError as extMensajeError

--		Select @CodErrors as extCodError,@MsgErrors as extMensajeError



	if @CONT > 0

		Select @extCodError = @CodError, @extMensajeError = @MsgError

	else

		Select @extCodError = @CodErrors, @extMensajeError = @MsgErrors



   commit tran	

return

(51 rows affected)
(return status = 0)
1> 