locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
24
(1 row affected)
text

   
create procedure dbo.INGMovExcedente 
   @Marca               marca, 
   @RutCotizante        rut, 
   @Monto               int, 
   @TipoMovimiento      regla, --(US)o (AN)ulacion 
   @FolioDocumento      int,
   @TipoDocumento       char(2) = null 
--segun clasificacion de area de ingresos para manejo de la cuenta corriente de excedentes
 
 
as 
/* 
 
-- *** ---------------------------------------------------------------------------------- 
Creado por   : Marcelo Herrera 
Creado el    : Febrero de 2
007 
Referencia   : FR 19057 
               Copago de venta electronica con cargo a cuenta de Excedentes 
-- *** ---------------------------------------------------------------------------------- 
Iteracion    : 2 
FR           : 19057 
               Se
 modifican valores por defecto para el Login y Host Origen IMED. 
 
-- ** ----------------------------------------------------------------------------------- 
Modificado por   : Marcelo Herrera 
Modificado el    : Febrero de 2013
Referencia       : FR 757
3, Se cambia el tipo de documento informado de BO a IM para
                   diferenciar movimientos de caja de la venta en linea de prestadores.
-- *** ---------------------------------------------------------------------------------- 
Modificado por  
 : Marcelo Herrera 
Modificado el    : Agosto de 2013
Referencia       : FR 8897, Se incorpora parametro nuevo para hacer dinamico la invocacion
                   del servicio y se informe el tipo de documento segun clasificacion de
                   cu
enta corriente de excedente.
                   Requerido para utilizar servicio en la venta en Farmacias (creacion de 
                   bono Online).
-- *** ---------------------------------------------------------------------------------- 
LAS ORDENES
 DE ATENCION (BONOS) PAGADAS CON EXCEDENTES 
PARA USO O DEVOLUCION DEBERAN HACER EL ABONO O CARGO RESPECTIVO EN LAS CUENTAS. 
 
 
Ejemplo de llamada: 
exec prestacion..INGMovExcedente 'CB', 11911830, 22222, 'US', 1234 
exec prestacion..INGMovExcedente 'CB
', 11911830, 22222, 'AN', 1234 

exec prestacion..INGMovExcedente 'CB', 11911830, 22222, 'US', 1234, 'IM'
exec prestacion..INGMovExcedente 'CB', 11911830, 22222, 'AN', 1234, 'IM'

exec prestacion..INGMovExcedente 'CB', 11911830, 22222, 'US', 1234, 'GE' --
valor para venta en farmacia
exec prestacion..INGMovExcedente 'CB', 11911830, 22222, 'AN', 1234, 'GE'
  
-- *** ---------------------------------------------------------------------------------- 
 
*/ 
 
begin 
 
/* 
     **************************** 
 
 
            IMPORTANTE 
 
   NO dejar activos en produccion sentencias PRINT 
   Causara error en Tuxedo de IMED 
     **************************** 
 
*/ 
 
 
 
declare	@Proceso        periodo, 
        @Remuneracion   fecha, 
        @fecha          fech
a, 
        @Correlativo    int, 
        @NroRegistro    int, 
        @DvCotizante    dv, 
        @Contrato       contrato, 
        @error          int 
 
       ,@Host                host 
       ,@Login               login 
       ,@vlcTipoDocumento
    char(2)
 
 
 
   --// Los Atributos de Login deberén ser GENERICOS. 
   set @Host  = 'C-SALUD01' 
   Set @Login = 'CSALUD00' 
 
   select @fecha = getdate() 
   exec @error = ingreso..Sel_PeriodosReca 'IN', @Proceso output, null 
   if @error<>0 
   b
egin 
        --print 'Error..no recupero el periodo proceso' 
        return -7000 
   end 
 
   select @Remuneracion = convert(smalldatetime,substring(@Proceso,5,2)+'/01/'+substring(@Proceso,1,4)) 
 
   select @DvCotizante = ConDvCot_cr 
   from contrat
o..Contrato 
   where ConRutCot_id	= @RutCotizante 
 
   if @DvCotizante = null 
      select @DvCotizante = '1' 
 
   --valor por defecto identifica como origen del documento trx de venta de bonos a traves de Imed.
   set @vlcTipoDocumento = isNull(@Tipo
Documento, 'IM')
   
   if @TipoMovimiento = 'AN'   -- anulacion de bono 
   begin 
      -- verificacion de preexistencia de movimiento 
      if not exists(Select MexNumDoc_nn from ingreso..MovExcedente 
                    where MexNumDoc_nn = @FolioDo
cumento 
                      and MexRutCot_id = @RutCotizante 
                      and MexTipMov_re = 'P' 
                      and MexTipDoc_re = @vlcTipoDocumento) 
      begin 
         -- recuperacion del monto a anular 
         Select @Monto = 
MexMonCar_$$ from ingreso..MovExcedente 
                    where MexNumDoc_nn = @FolioDocumento 
                      and MexRutCot_id = @RutCotizante 
                      and MexTipMov_re = 'F' 
                      and MexTipDoc_re = @vlcTipoDocum
ento 
 
         if @Monto = 0 
            return 
         -- anulacion del movimiento 
         exec @error = ingreso..InsertMovExcedente @Marca, @RutCotizante, @DvCotizante, null, 
	               @Correlativo output, 'P', @fecha, @Monto, 0, @fecha, @
Remuneracion, @Proceso, 0, 
		       @fecha, @Host, @Login, null, @vlcTipoDocumento, @FolioDocumento 
 
         if @error<>0 
         begin 
             --print 'Error..al insertar Anulacion MovExcedente' 
             return -7002 
         end 
     
 end 
   end 
   else   -- @TipoMovimiento <> 'AN'   -- US -> uso de bono 
   begin 
      if not exists(Select MexNumDoc_nn from ingreso..MovExcedente 
                    where MexNumDoc_nn = @FolioDocumento 
                      and MexRutCot_id = @Ru
tCotizante 
                      and MexTipMov_re = 'F' 
                      and MexTipDoc_re = @vlcTipoDocumento) 
      begin 
         exec @error = ingreso..InsertMovExcedente @Marca, @RutCotizante, @DvCotizante, null, 
	               @Correlativo
 output, 'F', @fecha, 0, @Monto, @fecha, @Remuneracion, @Proceso, 0, 
                       @fecha, @Host, @Login, null, @vlcTipoDocumento, @FolioDocumento 
 
         if @error<>0 
         begin 
             --print 'Error..al insertar Uso MovExcedent
e' 
             return -7003 
         end 
      end 
   end 
 
End 
Return 
                                                                                                                                                                                
(24 rows affected)
(return status = 0)
1> 