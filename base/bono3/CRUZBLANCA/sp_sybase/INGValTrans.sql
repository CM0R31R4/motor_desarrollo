locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
23
(1 row affected)
text
create procedure dbo.INGValTrans
(
 @extCodFinanciador     smallint,
 @extFolioFinanciador   numeric(10),
 @extAccion             char(1),
 @extPregunta           char(1),
 @extRespuesta          char(1)  output,
 @extCodError           char(1)  output,
 
@extMensajeError       char(30) output
)
/*
   procedimiento : INGValTrans
   Autor         : Cristian Rivas Rivera.
   Descripcion   : Valida la existencia de un bono segun algoritmo de ORDEN.
                   La verdad yo no me hago responsable.

   -
-----------------------
   |Servicios para C-Salud |
   ------------------------

   Prueba
    declare  @extRespuesta    char(1),
             @extCodError     char(1),
             @extMensajeError char(30)

    exec prestacion..INGValTrans 78, 15721115
, 'C', 'V',
                                @extRespuesta    output,
                                @extCodError     output,
                                @extMensajeError output

*/
As
declare @Marca     marca,
         @Folio     int,
         @Error
Code int,
         @Hoy       fecha,
         @RutCot    rut,
         @DigCot    dv,
         @Folios     int

begin
 Select @Hoy = getdate()

 Select @Folio = convert(int,@extFolioFinanciador)
 Select @extCodError = 'S'
 Select @extMensajeError = ""


 
begin tran  --// Se genera este Begin, en la tabla Log_EntradasValTrans
            --// se elmina la propiedad de identity del campo extNroTrX . Mercedes.

     update ContadorFolio
     set    CfoNumFol_nn = CfoNumFol_nn - 1
     where  CfoCodMar_id = '
IN'
     And    CfoTipDoc_fl = 'LEVT'

     select @Folios = CfoNumFol_nn
     from   ContadorFolio
     where  CfoCodMar_id = 'IN'
     and    CfoTipDoc_fl = 'LEVT'

   commit tran

 if @extAccion = 'C'
  begin --// ACION ES CONFIRNMACION
   if @extPregu
nta = "V"
    begin --// LA PREGUNTA ES ¿EXISTE EL BONO?
     if exists (Select 1 From prestacion..Bono
                Where  BonFolDoc_id = @Folio)
      Select @extRespuesta = "E"
     else
      Select @extRespuesta = "N"

     Select @extCodError = "
S"
     Select @extMensajeError = " "

     begin tran uno

      insert prestacion..Log_EntradasValTrans
            (extNroTrX, extFechaHoraTRX, extCodFinanciador,
             extFolioFinanciador, extAccion, extPregunta,
             extRespuesta, extC
odError, extMensajeError)
      values (@Folios, getdate(), @extCodFinanciador,
              @extFolioFinanciador, @extAccion, @extPregunta,
              @extRespuesta, @extCodError, @extMensajeError)

      if @@error != 0
       begin
        rollback
 tran uno
        Select @extCodError = "N"
        Select @extMensajeError = "FALLO GENER. LOG"
        return 1
       end

     commit tran uno
     return 1
    end   --// FIN LA PREGUNTA ES ¿EXISTE EL BONO?

   if @extPregunta = "A"
    begin --// LA
 PREGUNTA ES ¿EL BONO ESTA NULO O DEVUELTO?
     if exists (Select 1 From prestacion..Bono
                Where  BonFolDoc_id = @Folio)
      begin --// EL BONO EXISTE....GUAUU!!!
       --// Y como ya sabemos que existe, entonces veamos si esta nulo o d
evuelto.
       if exists (Select 1
                  From   prestacion..Bono
                  Where  BonFolDoc_id = @Folio
                    and  BonEstDoc_re in ('D','N'))
        Select @extRespuesta = "A"
       else
        Select @extRespuesta = 
"E"

       Select @extCodError = "S"
       Select @extMensajeError = ""

       begin tran uno

        insert prestacion..Log_EntradasValTrans
              (extNroTrX, extFechaHoraTRX, extCodFinanciador,
               extFolioFinanciador, extAccion, 
extPregunta,
               extRespuesta, extCodError, extMensajeError)
        values (@Folios, getdate(), @extCodFinanciador,
                @extFolioFinanciador, @extAccion, @extPregunta,
                @extRespuesta, @extCodError, @extMensajeError)


        if @@error != 0
         begin
          rollback tran uno
          Select @extCodError = "N"
          Select @extMensajeError = "FALLO GENER. LOG"
          return 1
         end

       commit tran uno

       return 1
      end   --// FIN EL
 BONO EXISTE
     else
      begin --// EL BONO NO EXISTE
       Select @extRespuesta = "N"
       Select @extCodError = "S"
       Select @extMensajeError = ""

       begin tran uno

        insert prestacion..Log_EntradasValTrans
              (extNroT
rX, extFechaHoraTRX, extCodFinanciador,
               extFolioFinanciador, extAccion, extPregunta,
               extRespuesta, extCodError, extMensajeError)
        values (@Folios, getdate(), @extCodFinanciador,
                @extFolioFinanciador, @e
xtAccion, @extPregunta,
                @extRespuesta, @extCodError, @extMensajeError)

        if @@error != 0
         begin
          rollback tran uno
          Select @extCodError = "N"
          Select @extMensajeError = "FALLO GENER. LOG"
         
 return 1
         end

       commit tran uno

       return 1

      end   --// FIN EL BONO NO EXISTE

    end   --// FIN LA PREGUNTA ES ¿EL BONO ESTA NULO O DEVUELTO?

  end   --// FIN ACION ES CONFIRNMACION
 else
  begin
   Select @extCodError = "N"
 
  Select @extMensajeError = "Accion Desconocida"
  end

 begin tran uno

  insert prestacion..Log_EntradasValTrans
        (extNroTrX, extFechaHoraTRX, extCodFinanciador,
         extFolioFinanciador, extAccion, extPregunta,
         extRespuesta, extCodE
rror, extMensajeError)
  values (@Folios, getdate(), @extCodFinanciador,
          @extFolioFinanciador, @extAccion, @extPregunta,
          @extRespuesta, @extCodError, @extMensajeError)

  if @@error != 0
   begin
    rollback tran uno
    Select @extCo
dError = "N"
    Select @extMensajeError = "FALLO GENER. LOG"
    return 1
   end

 commit tran uno
 return 1
end

 
                                                                                                                                          
(23 rows affected)
(return status = 0)
1> 