locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
17
(1 row affected)
text
create procedure dbo.INGAnulaBonoU 
( 
 @extCodFinanciador     smallint, 
 @extFolioBono          numeric(10), 
 @extIndTratam          char(1), 
 @extFecTratam          datetime, 
 @extCodError           char(1)  output, 
 @extMensajeError       char(30) output 
) 
/* 
 
  -- ** ------------------------------------------------------------------------------ 
  Modificado por : Marcelo Herrera 
  Modificado el  : Marzo 2007 
  Referencia     : FR - 19057 
                   Se incluye movimiento de exceden
te 
  -- ** ------------------------------------------------------------------------------ 
   Modificado    : Mauricio Cosgrove 
   Objetivo      : FR-2357 
 
  -- ** ---------------------------------------------------------------------------- 
   procedimiento : INGAnulaBonoU 
   Autor         : Cristian Rivas Rivera. 
  -- ** ------------------------------------------------------------------------------ 
 
 
   Parametros I 
       @extCodFinanciador     : Código del Financiador 
 
   Parametros O 
   
    @extCodError           : Código de Error ('S','N') 
       S = estador exitoso de la transaccion 
                                N = fallo o error en transaccion 
       @extMensajeError       : Mensaje de Error. 
 
   ------------------------ 
   |Servicios para C-Salud | 
   ------------------------ 
 
   Descripción 
 
   Envia Bonos Uno por uno al financiador para su registro. 
 
   Prueba 
    declare  @extCodError     char(1), 
             @extMensajeError char(30) 
 
    exec migracion..INGAnulaBonoU 78, 34, 'N', '04/20/2001', @extCodError output, @extMensajeError output 
  -- ** --------------------------------------------------------------------------- 
 
*/ 
As 
 declare @Marca     marca, 
         @Folio     int, 
         @ErrorCode int, 
         @Hoy       fecha, 
         @RutCot    rut, 
         @DigCot    dv 
 
begin 
 Select @Hoy = getdate() 
 
 Select @Folio = convert(int,@extFolioBono) 
 Select @extCodError = 'S' 
 Select @extMensajeError = "Error al actualizar topes" --TRX DENEGADA (EI:400347) 
 
 --// El Folio debe Estar (UT)ilizado o (SO)licitado en la Tabla de Control de Folios 
 
 if not exists(Select 1 
               From   prestacion..Log_Control_Folios 
               where  LcfFolEnt_id = @Folio 
                 and  LcfTipDoc_id = 'BO' 
                 and  LcfEstUso_re = 'UT') 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = "Error: control de folios." --TRX DENEGADA (EI:400345) 
   return 1 
  end 
 
 if exists (Select 1 
            From   prestacion..Bono 
            Where  BonFolDoc_id = @Folio 
              and  BonEstDoc_re = 'P') 
  begin 
 
   Select @RutCot = BonRutCot_ta, 
          @DigCot = BonDigCot_cr, 
       
   @Marca  = BonMarBon_id 
   From   prestacion..Bono 
   where  BonFolDoc_id = @Folio 
 
   exec @ErrorCode = finanza..GrabaDevolucion @Marca, @Folio, @Hoy,'130600', 'CSALUD00', @RutCot, @DigCot, 'B', 'D' 
 
   if @ErrorCode != 0 
    begin 
     Select 
@extCodError = 'N' 
     Select @extMensajeError = "Error: al anular la TRX" --TRX DENEGADA (EI:400346) 
     return 1 
    end 
 
   exec @ErrorCode = prestacion..Movi_CueCorBenxFolio @Marca, @Folio, 'BO', '-', 'N', 'P' 
 
   if @ErrorCode != 0 
    begi
n 
     Select @extCodError = 'N' 
     Select @extMensajeError = "Error: cta. corr. Benef." 
     return 1 
    end 
 
   -- anulacion de movimiento de excedente 
   exec @ErrorCode = prestacion..INGMovExcedente 
                        @Marca 
         
              ,@RutCot 
                       ,0               -- se desconoce monto de excedente a anular, si lo hay 
                       ,'AN'            -- anulacion de excedente 
                       ,@Folio 
 
   if @ErrorCode != 0 
   begin 
 
      Select @extCodError = 'N' 
       Select @extMensajeError = "Error al anular Bono en Isapre" 
       return 1 
   end 
 
   Select @extCodError = 'S' 
   Select @extMensajeError = "" 
 
  end 
 else 
  begin 
   Select @extCodError = 'N' 
   Select 
@extMensajeError = "Intenta anular  bono no pagado." --TRX DENEGADA (EI:400348) 
   return 1 
  end 
 
 return 1 
 
end 
 
                                                                                                                                    
(17 rows affected)
(return status = 0)
1> 
