locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
locale is "en_US.UTF-8"
locale charset is "UTF-8"
using default charset "UTF-8"
1> 2> Text
create proc FERBenRec (@extCodFinanciador  Numeric(3,0),
		       @extRutCotizante       char(12),
		       @extCorrBenef       Numeric(3,0),
		       @extRutBeneficiario char(12),
               @extCodResBen       char(1)    Output,
               @extM
ensajeError    char(30)   Output
			   )
/*-------------------------------------------------------------------------------
- Nombre SP        : FERBenRec
- Desarrollado por : Paulina Zuniga
- Fecha Creacion   : 03 / 01 / 2006
- Objetivo         : Servicio
 que actualiza el rut de un beneficiario siempre y cuando 
		     este se encuentre sin informacion
--------------------------------------------------------------------------------*/
as
--Declare @extCodResBen    char(1)
--Declare @extMensajeError char(30
)
Declare @resulRutBen     numeric(9,0)

select @resulRutBen = 0
  Begin Tran

    Select @resulRutBen = T_Bcargas.RUT_CAR 
	From Cod_Fin, T_Bcargas
	Where Cod_Fin.CodFin = @extCodFinanciador
    and replace(str(T_Bcargas.RUT_AFIL,10),' ','0') = substring
(@extRutCotizante,1,10)	
    and T_Bcargas.NLC = @extCorrBenef
	-- and T_Bcargas.RUT_AFIL = @extRutCotizante   
      
	if @resulRutBen = 0
		begin
		     update T_Bcargas
              set RUT_CAR = convert(numeric(9,0),substring(@extRutBeneficiario,1,10
)),
                  DIG_CAR = substring(@extRutBeneficiario,12,1)
                     where replace(str(RUT_AFIL,10),' ','0') = substring(@extRutCotizante,1,10)
                         And NLC = @extCorrBenef
                     --where RUT_AFIL = co
nvert(numeric(9,0),@extRutCotizante)
		     select @extCodResBen = 'G'
             select @extMensajeError = 'Exito en la actualizacion'
		end 
	else
      begin
		     select @extCodResBen = 'P'
             select @extMensajeError = 'No actualizable'
 
     end

	IF @@Error <> 0
        	BEGIN
          		Rollback Tran
          		SELECT @extCodResBen= 'P'
          		SELECT @extMensajeError = 'Error en la actualizacion'
          		Return
        	END

	-- Select @extCodResBen as extCodResBen ,@extCodR
esBen as extCodResBen

   commit tran	
return

(9 rows affected)
(return status = 0)
1> 