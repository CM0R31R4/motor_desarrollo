locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
9
(1 row affected)
text
Create Procedure CGCValTrans
      @extCodFinanciador         smallint
    , @extFolioFinanciador       numeric(10,0)
    , @extAccion                 char(1)
    , @extPregunta               char(1)
    , @extRespuesta              char(1)         Output
    , @extCodError               char(1)         Output
    , @extMensajeError           char(30)        Output
As
Begin
    Select @extRespuesta = ' '
    Select @extCodError = ' '
    Select @extMensajeError = ' '
   
 Declare @SRV_ReturnStatus               int
      , @xcontador                      smallint
      , @fld_bonfolio                   int
      , @fld_bonestado                  tinyint
    Select @SRV_ReturnStatus = 0
select @fld_bonfolio    = isnull(convert(int,@extFolioFinanciador),0)
select @extCodError     = "S"
select @extMensajeError = " "
select @xcontador       = 0
Select @fld_bonestado = isnull(fld_bonestado,0)
From BON
where fld_bonfolio = @fld_bonfolio
select @xcontador = @@rowcount
if @extPregunta = "V"
begin
   if @xcontador = 0
      select @extRespuesta    = "N"
   else
      select @extRespuesta    = "E"
end
else
begin
   if @extPregunta = "A"
   begin
      if @xcontador = 0
      begin
         select @extRespuesta  = "N"
         select @extCodError   = "N", @extMensajeError = "No existe Bono"
      end
      else
      begin
         if @fld_bonestado in (3,4)
            select @extRespuesta  = "A"
         else
         begin
            if @fld_bonestado = 2
               select @extRespuesta  = "E"
            else
            begin
               select @extRespuesta    = ""
               select @extCodError     = "S"
               select @extMensajeError = "Estado de bono Desconocido"
            end
         end
      end
  
 end
   else
   begin
      select @extRespuesta    = ""
      select @extCodError     = "S"
      select @extMensajeError = "extPregunta no es A ni V"
   end
end
CGCValTrans_Exit:
    If @SRV_ReturnStatus >= 60000
    Begin
        Return 0
    End
    Else Begin
        Return 1
    End
End
                                                                                                                                                                                                                        
(9 rows affected)
(return status = 0)
1> 
