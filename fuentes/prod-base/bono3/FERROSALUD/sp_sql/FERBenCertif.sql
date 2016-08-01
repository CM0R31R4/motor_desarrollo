locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
1> 2> Text
CREATE proc [dbo].[FERBenCertif] (@extCodFinanciador  smallint                     /* Codigo del Financiador (Certificacion) */

			, @extRutBeneficiario             char(12)                     /* Rut del beneficiario (Certificacion) */

			, @extFechaActual                 datetime                     /* Fecha Actual (Certificacion) */

			, @extApellidoPat                 char(30)        Output       /* Apellido Paterno */

			, @extApellidoMat                 char(30)        Output       /* Apellido Materno */

			, @extNombres                     char(40)        Output       /* Nombres */

			, @extSexo                        char(1)         Output       /* Sexo del Beneficiario */

			, @extFechaNacimi                 char(8)         Output       /* Fecha nacimiento */

			, @extCodEstBen                   char(1)         Output       /* Codigo estado del beneficiario */

			, @extDescEstado                  char(15)        Output       /* Descripcion estado beneficiario */

			, @extRutCotizante                char(12)        Output       /* Rut Afiliado */

			, @extNomCotizante                char(40)        Output       /* Nombre Afiliado o Cotizante */

			, @extDirPaciente                 char(40)        Output       /* Direccion Beneficiario o Paciente */

			, @extGlosaComuna                 char(30)        Output       /* Glosa Comuna */

			, @extGlosaCiudad                 char(30)        Output       /* Glosa Ciudad */

			, @extPrevision                   char(1)         Output       /* Prevision del Beneficiario */

			, @extGlosa                       char(40)        Output       /* Glosa estado beneficiario */

			, @extPlan                        char(20)        Output       /* Plan Financiador o Grupo ingreso del Beneficiario (Certificacion) */

			, @extDescuentoxPlanilla          char(1)         Output       /* Permite Descuento por planilla S/N (Certificacion) */

			, @extMontoExcedente              numeric(10,0)   Output       /* Saldo de Excedentes disponible (Certificacion) */

)

/*----------------------------------------------------------------------------

 Nombre SP       : FERBenCertif

 Desarrollado por: Paulina Zuniga

 Fecha Creacion  : 03 / 01 / 2006

 Objetivo        : certificar la existencia del beneficiario

------------------------------------------------------------------------------*/

as

   Declare @extRutAcompanante              char(12)

         , @extNombreAcompanante           char(40)

         , @JextRutAcompanante              char(12)

         , @JextNombreAcompanante           char(40)

			, @JextApellidoPat                 char(30)

			, @JextApellidoMat                 char(30)

			, @JextNombres                     char(40)

			, @JextSexo                        char(1) 

			, @JextFechaNacimi                 char(8) 

			, @JextCodEstBen                   char(1) 

			, @JextDescEstado                  char(15)

			, @JextRutCotizante                char(12)

			, @JextNomCotizante                char(40)

			, @JextDirPaciente                 char(40)

			, @JextGlosaComuna                 char(30)

			, @JextGlosaCiudad                 char(30)

			, @JextPrevision                   char(1) 

			, @JextGlosa                       char(40)

			, @JextPlan                        char(20)

			, @JextDescuentoxPlanilla          char(1) 

			, @JextMontoExcedente              numeric(10,0)

			, @cont				   numeric(10,0)



Begin Tran

    select @cont = 0

    If convert(char(8),@extFechaActual,112) = convert(char(8),getdate(),112)

	Begin 

            Select @JextApellidoPat = ' '

            Select @JextApellidoMat = ' '

            Select @JextNombres = ' '

            Select @JextSexo = ' '

            Select @JextFechaNacimi = '00000000'

            Select @JextCodEstBen = 'X'

            Select @JextDescEstado = 'xxxxxxx'

            Select @JextRutCotizante = '0000000000-0'

            Select @JextNomCotizante = ' '

            Select @JextDirPaciente = ' '

            Select @JextGlosaComuna = ' '

            Select @JextGlosaCiudad = ' '

            Select @JextPrevision = ' '

            Select @JextGlosa = ' '

            Select @JextPlan = ' '

            Select @JextDescuentoxPlanilla = ' '

            Select @JextMontoExcedente = 0   

            Select @JextRutAcompanante = ''

            Select @JextNombreAcompanante = ''

 

		Select @JextApellidoPat = RTrim(b.PAT),

		       @JextApellidoMat = RTrim(b.MAT),

		       @JextNombres = RTrim(b.NOM),

		       @JextSexo = case

                     when b.SEXO in (1,0) then 'M' 

                       else 'F'

                     end,

                     @JextFechaNacimi = convert(char(8), b.FEC_NAC,112),

    		     @JextCodEstBen = case 

	    		  when a.ESTADO = 0 then 'C'

	    		  when a.ESTADO = 1 then 'C'

	    		  when a.ESTADO = 5 then 'C'

				else 'X'

		          end,

		     @JextDescEstado = case

				  when a.ESTADO in (5,1,0) then 'Certificado'

					else 'XXXXXXX'

				end,

			   @JextRutCotizante= replace(str(a.RUT_AFIL,10),' ','0')+'-'+a.dig_afil, 

			   @JextNomCotizante = RTrim(a.NOMBRE) + ' ' + RTrim(a.A_PAT) + ' ' + RTrim(a.A_MAT) ,

			   @JextDirPaciente =a.DIR_CAR,

			   @JextGlosaComuna=a.GLS_COM,

			   @JextGlosaCiudad=a.GLS_CIU, 

			   @JextPrevision ='', 

			   @JextGlosa='', 

			   @JextPlan=a.PLAN_AFIL,

			   @JextDescuentoxPlanilla = case 

				   when a.ESTADO in (1,0) then 'S'

					   else 'N'

			           end,

			   @JextMontoExcedente=0,

			   @JextRutAcompanante = replace(str(a.RUT_AFIL,10),' ','0')+'-'+a.dig_afil, 

			   @JextNombreAcompanante = RTrim(a.NOMBRE) + ' ' + RTrim(a.A_PAT) + ' ' + RTrim(a.A_MAT) 

		From  T_Bafimov a,T_Bcargas b, Cod_Fin c

		Where a.RUT_AFIL = b.RUT_AFIL

                and replace(str(b.RUT_CAR,10),' ','0') = substring(@extRutBeneficiario,1,10)

	        and c.CodFin = @extCodFinanciador

            

	        --- and b.RUT_CAR = @extRutBerneficiario

            --	convert(char(8), b.FEC_NAC,112) as 'extFechaNacimi',

	--	print @extRutBeneficiario

            select @cont = @@ROWCOUNT

	End



--				  when a.ESTADO in (1,0) then 'Certificado'

--					else 'XXXXXXX'

        

	--IF @@Error <> 0

        --	BEGIN

         -- 		Rollback Tran

         -- 		Print 'Error al generar la consulta'

         -- 		Return

       -- 	END

       --print @cont



       If @cont <= 0 or  @JextDescEstado= 'XXXXXXX'

           Begin



            Select @JextApellidoPat = ' '

            Select @JextApellidoMat = ' '

            Select @JextNombres = ' '

            Select @JextSexo = ' '

            Select @JextFechaNacimi = '00000000'

            Select @JextCodEstBen = 'X'

            Select @JextDescEstado = 'xxxxxxx'

            Select @JextRutCotizante = '0000000000-0'

            Select @JextNomCotizante = ' '

            Select @JextDirPaciente = ' '

            Select @JextGlosaComuna = ' '

            Select @JextGlosaCiudad = ' '

            Select @JextPrevision = ' '

            Select @JextGlosa = ' '

            Select @JextPlan = ' '

            Select @JextDescuentoxPlanilla = ' '

            Select @JextMontoExcedente = 0   

            Select @JextRutAcompanante = ''

            Select @JextNombreAcompanante = ''

	   End

	      



       Select @extApellidoPat  = @JextApellidopat,

              @extApellidoMat  = @Jextapellidomat,

	      @extNombres      = @Jextnombres,

	      @extSexo         = @Jextsexo,

	      @extFechaNacimi  = @JextFechaNacimi,

	      @extCodEstBen    = @JextCodEstBen,

	      @extDescEstado   = @JextDescEstado,

	      @extRutCotizante = @JextRutCotizante,

	      @extNomCotizante = @JextNomCotizante,

	      @extDirPaciente  = @JextDirPaciente,

	      @extGlosaComuna  = @JextGlosaComuna,

	      @extGlosaCiudad  = @JextGlosaCiudad,

	      @extPrevision    = @Jextprevision,

	      @extGlosa        = @Jextglosa,

	      @extPlan         = @Jextplan,

	  @extDescuentoxPlanilla = @JextDescuentoxPlanilla,

	      @extMontoExcedente     = @JextMontoExcedente



	      -- @extRutAcompanante     = @JextRutAcompanante,

	      -- @extNombreAcompanante  = @JextNombreAcompanante



		Select  replace(str(b.RUT_car,10),' ','0')+'-'+b.dig_car  as 'extRutAcompanante', 

			RTrim(b.NOM) + ' ' + RTrim(b.PAT) + ' ' + RTrim(b.MAT) as 'extNombreAcompanante'

		From  T_Bcargas b, Cod_Fin c

		Where substring(@JextRutCotizante,1,10) = replace(str(b.RUT_AFIL,10),' ','0')

                and round((convert(numeric(8),getdate()-b.fec_nac)/365),0)>6

		and replace(str(b.RUT_CAR,10),' ','0') <> substring(@extRutBeneficiario,1,10)

	        and c.CodFin = @extCodFinanciador

                

   Commit Tran	



return
(187 rows affected)
(return status = 0)
1> 