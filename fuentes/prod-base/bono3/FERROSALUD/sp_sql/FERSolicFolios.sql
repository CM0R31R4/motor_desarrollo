locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
1> 2> Text
create proc FERSolicFolios (@extCodFinanciador int,

			   @extNumFolios             tinyint,

               @extCodError           char(1)    OUTPUT,

               @extMensajeError       char(30)   output

              -- @extFoliosDevueltos    Numeric(10) Output

			   )

/*-------------------------------------------------------------------------------

- Nombre SP        : FERSolicFolios

- Desarrollado por : Paulina Zuniga

- Fecha Creacion   : 03 / 01 / 2006

- Objetivo         : Servicio que solicita uno mas folios de bonos al financiador

--------------------------------------------------------------------------------*/

as

BEGIN tran 

     Declare @CodError char(1)

     Declare @MsgError char(30)

     DECLARE @cont     INTEGER 

     DECLARE @numFolio NUMERIC(10,0)

     DECLARE @extFoliosDevueltos Numeric(10,0)

     -------------------------------

     SELECT @cont = 1

     select @CodError = 'S'

     select @MsgError = ''

     SELECT @numFolio = 0



     CREATE TABLE #tmpFolios(Numero_folio Numeric (10,0))

     

     Select @numFolio = isnull(cod_fin.Numero_folio,0)

     From cod_fin 

      Where cod_fin.CodFin = @extCodFinanciador 

     

     WHILE @cont <= @extNumFolios

        BEGIN 

	        Select @numFolio = @numFolio + 1

	        INSERT INTO #tmpFolios (Numero_folio)  Select @numFolio 

		

		    IF @@Error <> 0

    			BEGIN

              			Rollback Tran

              			SELECT @CodError 'N'

              			SELECT @MsgError 'Error en la solicitud de folios'

    				SELECT @cont = @extNumFolios

            		END

        

            --Select @CodError  as 'extCodError',

	        --       @MsgError  as 'extMensajeError',

            --       @numFolio  as 'extFoliosDevueltos'

                    

    		SELECT @cont = @cont + 1 

        END 



     UPDATE cod_fin SET cod_fin.Numero_folio = @numFolio WHERE cod_fin.CodFin = @extCodFinanciador

     

     IF @@Error <> 0

	BEGIN

             Rollback Tran

             print 'error al actualizar folios en ta tabla cod_fin'

	     return

        END

     

     select @extCodError = @CodError

     Select @extMensajeError = @MsgError

     

     Select isnull(#tmpFolios.Numero_folio,0) AS 'extFoliosDevueltos'

     From #tmpFolios



COMMIT tran



return

(69 rows affected)
(return status = 0)
1> 