locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
1> 2> Text
Create Proc FEREnrola (@extCodFinanciador    Numeric(3,0),

		       @extRutEnrolar           Char(12),

		       @extRutBeneficiario      Char(12),

	               @extValido               char(1)    output,

        	       @extNombreComp           char(40)   output

			 )

/*-------------------------------------------------------------------------------

 - Nombre SP        : FEREnrola

 - Desarrollado por : Paulina Zuniga

 - Fecha Creacion   : 03 / 01 / 2006

 - Objetivo         : Servicio que cosulta al financiador si corresponde enrolar 

		      a la persona como beneficiario valido o como acompañante 

  		      de un beneficiario valido

--------------------------------------------------------------------------------*/

as

Declare @JextValido     Char(1)

declare @JextNombreComp Char(40)

declare @contador      int

select @contador = 0

select @extRutBeneficiario = ltrim(rtrim(@extRutBeneficiario))

select @extRutBeneficiario = ltrim(rtrim(@extRutBeneficiario))



select @JextValido = ''

select @JextNombreComp = ' No existe '



	if (@extRutEnrolar = @extRutBeneficiario)

	     Begin

           -- @contador = count(T_Bcargas.RUT_CAR),

        	Select @JextNombreComp = Rtrim(T_Bcargas.PAT) + ' ' + Rtrim(T_Bcargas.MAT) + ' ' + Rtrim(T_Bcargas.NOM)

    		From T_Bcargas,Cod_Fin

    		Where Cod_Fin.CodFin = @extCodFinanciador		

            AND replace(str(T_Bcargas.RUT_CAR,10),' ','0') = substring(@extRutBeneficiario,1,10)

            --And replace(str(T_Bcargas.RUT_AFIL,10),' ','0') = substring(@extRutBeneficiario,1,10)

    		-- GROUP BY T_Bcargas.PAT,T_Bcargas.MAT ,T_Bcargas.NOM

    		---- And T_Bcargas.RUT_CAR = @extRutBeneficiario

    		If @@ROWCOUNT > 0

                   select @JextValido = 'S'

    		else 

                   select @JextValido = 'N'

       end

	else

	     Begin

            --   @contador = count(T_Bcargas.RUT_CAR),

    		Select @JextNombreComp = Rtrim(T_Bcargas.PAT) + ' ' + Rtrim(T_Bcargas.MAT) + ' ' + Rtrim(T_Bcargas.NOM)

    		From Cod_Fin,T_Bcargas

    		Where Cod_Fin.CodFin = @extCodFinanciador		

            And replace(str(T_Bcargas.RUT_AFIL,10),' ','0') = substring(@extRutBeneficiario,1,10)

            And replace(str(T_Bcargas.RUT_CAR,10),' ','0') = substring(@extRutEnrolar,1,10)

    		-- GROUP BY T_Bcargas.PAT,T_Bcargas.MAT ,T_Bcargas.NOM

    		--- And T_Bcargas.RUT_CAR = @extRutEnrolar

    

    		If @@ROWCOUNT > 0

                   select @JextValido = 'S'

    		else 

                   select @JextValido = 'N'

        end



      Select @extValido = @JextValido

      Select @extNombreComp = @JextNombreComp



Return

(61 rows affected)
(return status = 0)
1> 