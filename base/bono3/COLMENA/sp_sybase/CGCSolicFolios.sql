locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
8
(1 row affected)
text
Create Procedure CGCSolicFolios
      @extCodFinanciador              smallint
    , @extNumFolios                   tinyint
    , @extCodError                    char(1)         Output
    , @extMensajeError                char(30)        Output
As
Begin

    Select @extCodError = ' '
    Select @extMensajeError = ' '
    Declare @SRV_ReturnStatus               int
      , @exFoliosDevueltos              numeric(10,0)
      , @fld_bonfolio                   int
      , @xorigen                        tinyint
      , @xinspeccion                    tinyint
      , @xi                             smallint
      , @xcontador                      smallint
    Select @SRV_ReturnStatus = 0
create table #folios (folbon numeric(10,0) not null)
if @extNumFolios < 1
begin
   select @extCodError     = "N"
   select @extMensajeError = "Folios pedidos deben ser > 0"
    GoTo CGCSolicFolios_Exit
end
select @xi = 0
While (@xi < @extNumFolios)
Begin
   select @xorigen      = 1
   select @xinspeccion  = 0
   select @fld_bonfolio = 0
   Exec GrlBonCorrel @xorigen, @fld_bonfolio output, @xinspeccion output
   if @xinspeccion = 1
   begin
      select @extCodError     = "N"
      select @extMensajeError = "Error al dar Folio de Bono (1)"
    GoTo CGCSolicFolios_Exit

   end
   select @xcontador = count(*)
   from #folios
   where folbon = @fld_bonfolio
   if @xcontador != 0
   begin
      select @extCodError     = "N"
      select @extMensajeError = "Error al dar Folio de Bono (2)"
    GoTo CGCSolicFolios_Exit
   end

   insert into #folios (folbon) Values (@fld_bonfolio)
   select @xi = @xi + 1
End
select exFoliosDevueltos = folbon
from #folios
CGCSolicFolios_Exit:
    If @SRV_ReturnStatus >= 60000
    Begin
        Return 0
    End
    Else Begin
        Return 1
   
 End
End
                                                                                                                                                                                                                                                      
(8 rows affected)
(return status = 0)
1> 
