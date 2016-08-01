locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
1> 2> Text
CREATE proc [dbo].[FEREnvBonis] (@extCodFinanciador int,

		         @extHomNumeroConvenio char(15),

		         @extHomLugarConvenio char(10),

                 @extSucVenta char(10),

				 @extRutConvenio char(12),

                 @extRutAsociado char(12),

				 @extNomPrestador char(40),

                 @extRutTratante char(12),

			     @extespecialidad char(10),   

                 @extRutBeneficiario char(12),

			     @extRutCotizante char(12),

		         @extRutAcompanante char(12),

			     @extRutEmisor char(12),

		         @extRutCajero char(12),

		         @extCodigoDiagnostico char(10),

		         @extDescuentoxPlanilla char(1),

			     @extMontoExcedente char(10),               /* Excedentes ocupado */

                         @extFechaEmision datetime,

                         @extNivelConvenio tinyint,

                         @extFolioFinanciador numeric(15,3),

                         @extMontoValorTotal numeric(15,3),

                         @extMontoAporteTotal numeric(15,3),

                         @extMontoCopagoTotal numeric(15,3),

                         @extNumOperacion numeric(15,3),

                         @extCorrPrestacion numeric(15,3),

                         @extTipoSolicitud tinyint,

                         @extFechaInicio datetime,

                         @exturgencia char(1),

                         @extplan char(15),

                         @extlista1 char(255),

                         @extlista2 char(255),

                         @extlista3 char(255),

			    @extCodError char(1) Output,

			    @extMensajeError  char(30) Output

			)

/*----------------------------------------------------------------------------

 Nombre SP       : FEREnvBonis

 Desarrollado por: Paulina Zuniga

 Fecha Creacion  : 03 / 01 / 2006

 Objetivo        : certificar la existencia del beneficiario

------------------------------------------------------------------------------*/

as

Declare @CodError char(1)

Declare @MensajeError char(30)



select @CodError='S'

select @MensajeError = ' '



begin tran



	Insert into hist_bonos values(@extCodFinanciador,

				      @extHomNumeroConvenio,

				      @extHomLugarConvenio,

                      @extSucVenta,

				      @extRutConvenio,

                      @extRutAsociado,

				      @extNomPrestador,

                      @extRutTratante,

				      @extespecialidad,   

                      @extRutBeneficiario,

				      @extRutCotizante,

				      @extRutAcompanante,

				      @extRutEmisor,

				      @extRutCajero,

				      @extCodigoDiagnostico,

				      @extDescuentoxPlanilla,

			          @extMontoExcedente,

                      @extFechaEmision,

                      @extNivelConvenio,

                      @extFolioFinanciador,

                                      @extMontoValorTotal,

                                      @extMontoAporteTotal,

                                      @extMontoCopagoTotal,

                                      @extNumOperacion,

                                      @extCorrPrestacion,

                                      @extTipoSolicitud,

                                      @extFechaInicio,

                                      @exturgencia,

                                      @extplan,

                                      @extlista1,

                                      @extlista2,

                                      @extlista3

				    )



	IF (@@error != 0)

        	Begin

            		select @extCodError = 'N'

			Select @extMensajeError = 'Error al insertar los registros'

            		rollback tran

                	return

        	End 



	Select @extCodError = @CodError , @extMensajeError = @MensajeError 

    commit tran

return

(95 rows affected)
(return status = 0)
1> 