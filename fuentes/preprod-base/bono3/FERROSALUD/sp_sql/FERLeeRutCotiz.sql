locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
1> 2> Text
CREATE proc [dbo].[FERLeeRutCotiz] (@extCodFinanciador  Numeric(3,0)

			    ,@extRutCotizante       char(12)

                ,@extNomCotizante       char(40)   output

                ,@extCodError        char(1)       output

                ,@extMensajeError    char(30)      output

                --,@ExtCorrBenef       Numeric(3,0)  output

               -- ,@extRutBeneficiario char(12)      output

               -- ,@extApellidoPat     char(30)      output

               -- ,@extApellidoMat     char(30)      output

               -- ,@extNombres         char(40)      output

               -- ,@extCodEstBen       char(1)       output

               -- ,@extDescEstado      char(15)      output

			   )

/*-------------------------------------------------------------------------------

- Nombre SP        : FERLeeRutCotiz

- Desarrollado por : Paulina Zuniga

- Fecha Creacion   : 03 / 01 / 2006

- Objetivo         : Servicio que consulta los beneficiarios asociados a un rut

		     titular

--------------------------------------------------------------------------------*/

as

Declare @CodError char(1)

Declare @MsgError char(30)

Declare @cont int



  Begin Tran

    Truncate Table TabCotiz

	Select @cont = 0

	select @MsgError = 'Solicitud OK'

	SElect @CodError = 'N'

    

    DECLARE @ExtCorrBenef       Numeric(3,0)

    DECLARE @extRutBeneficiario char(12)

    DECLARE @extApellidoPat     char(30)

    DECLARE @extApellidoMat     char(30)

    DECLARE @extNombres         char(40)

    DECLARE @extCodEstBen       char(1) 

    DECLARE @extDescEstado      char(15) 

    

    Select @extNomCotizante =''

    Select @extCodError=''

    Select @extMensajeError = ' '

    Select @ExtCorrBenef  = 0

    Select @extRutBeneficiario = ''

    Select @extApellidoPat  = ' '

    Select @extApellidoMat = ' '

    Select @extNombres  =' '

    Select @extCodEstBen =''

    Select @extDescEstado = ''

        

	If @extRutCotizante <> ''

		Begin



                  -- replace(str(T_Bcargas.RUT_CAR,10),' ','0')+'-'+T_Bcargas.dig_car,

            Insert into TabCotiz (extNomCotizante,extCodError,extMensajeError, ExtCorrBenef, extRutBeneficiario,

                 extApellidoPat, extApellidoMat,extNombres, extCodEstBen, extDescEstado)

                 Select RTrim(T_Bafimov.NOMBRE) + ' ' + RTrim(T_Bafimov.A_PAT) + ' ' + RTrim(T_Bafimov.A_MAT),

                   @CodError,

                   @MsgError,

                   T_Bcargas.NLC,

                   'extRutBene' = CASE

			WHEN T_Bcargas.RUT_CAR>0 THEN  str(T_Bcargas.RUT_CAR,10)+'-'+T_Bcargas.dig_car

	                       ELSE ''

			END,

		   T_Bcargas.PAT,

                   T_Bcargas.MAT,

                   T_Bcargas.NOM,

			       'extCodEstBen' = CASE 

	    				when T_Bafimov.ESTADO = 0 then 'C'

	    				when T_Bafimov.ESTADO = 1 then 'C'

	    				when T_Bafimov.ESTADO = 5 then 'C'

						else 'X'

					end,

			       'extDescEstado' = CASE 

    				    WHEN T_Bafimov.ESTADO <> 1 THEN 'XXXXXXXXX' 

	    			        ELSE 'Certificado'

		    	        END 

			From T_Bafimov, T_Bcargas, Cod_Fin

			Where T_Bafimov.RUT_AFIL = T_Bcargas.RUT_AFIL

                and replace(str(T_Bafimov.RUT_AFIL,10),' ','0') = substring(@extRutCotizante,1,10)	

	   	        and Cod_Fin.CodFin = @extCodFinanciador





            If @@ROWCOUNT <= 0 or  @extDescEstado= 'XXXXXXXXX' 

                  Begin

                        Rollback Tran

               	Select @CodError = 'N'

		Select @MsgError = 'No existen cargas asociadas' 

                        return

	     End

        

        	Select @extNomCotizante = TabCotiz.extNomCotizante,

                   @extCodError = TabCotiz.extCodError,

                   @extMensajeError = TabCotiz.extMensajeError

                   from TabCotiz where ExtCorrBenef=0

                    

            Select ExtCorrBenef,

                   extRutBeneficiario,

                   extApellidoPat,

  extApellidoMat,

                   extNombres,

                   extCodEstBen,

                   extDescEstado

              FROM TabCotiz

		end		

	Else

		Begin

            Rollback Tran

            Select @CodError = 'S'

		    Select @MsgError = 'Faltan datos para efectuar la consulta' 

		    Select @CodError as extCodError,@MsgError as extMensajeError        	

            return

		End



	IF @@Error <> 0

        	BEGIN

            Rollback Tran

             Select @CodError = 'S'

		     Select @MsgError = 'Error en la consulta' 

		     Select @CodError as extCodError,@MsgError as extMensajeError        	

          	 Return

        	END



  commit tran

return
(125 rows affected)
(return status = 0)
1> 