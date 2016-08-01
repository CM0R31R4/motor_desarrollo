locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
11
(1 row affected)
text
Create Procedure CGCBenRec
      @extCodFinanciador              smallint
    , @extRutCotizante                char(12)
    , @extCorrBenef                   smallint
    , @extRutBeneficiario             char(12)
    , @extCodResBen                   char(1)         Output
    , @extMensajeError                char(30)        Output
As
Begin
    Select @extCodResBen = ' '
    Select @extMensajeError = ' '
    Declare @SRV_ReturnStatus               int
      , @fld_cotrut                     char(11)
  , @fld_funfolio                   int
      , @fld_funcorrel                  smallint
      , @fld_benrut                     char(11)
      , @fld_bencorrel                  tinyint
      , @fld_funfoliodig                char(1)
          , @DAGTranLevel                   tinyint
    If @@TranCount = 0
    Begin
        Select @DAGTranLevel = 1
        Begin Transaction
    End Else
        Select @DAGTranLevel = 0
    Select @SRV_ReturnStatus = 0
select @SRV_ReturnStatus = 60001
select @extCodResBen    = "G"
select @extMensajeError = space(30)
select @fld_cotrut      = right(@extRutCotizante,11)
select @fld_bencorrel   = @extCorrBenef
select @fld_benrut      = right(@extRutBeneficiario,11)
Select  @fld_funfolio     = fld_funfolio
        ,@fld_funcorrel   = fld_funcorrel
        ,@fld_funfoliodig = fld_funfoliodig
From CNT
Where fld_cotrut     = @fld_cotrut  AND
      fld_inivigfec <= getdate()    AND
      fld_finvigfec >= getdate()
if @@rowcount = 0
begin
    select @extCodResBen     = "P"
    select @extMensajeError = "Titular No Vigente o No Existe"
    GoTo CGCBenRec_Exit
end
Update BEN
Set fld_benrut = @fld_benrut
Where fld_funfolio  = @fld_funfolio  AND
      fld_funcorrel = @fld_funcorrel AND
      fld_bencorrel = @fld_bencorrel
if @@rowcount = 0
begin
    select @extCodResBen    = "P"
    select @extMensajeError = "No se pudo actualizar Rut (1)"
    GoTo CGCBenRec_Exit
end
insert into VI_RUT (extRutCotizante ,extCorrBenef ,extRutBeneficiario ,fld_funfolio ,fld_funfoliodig ,fld_funcorrel ,fld_digfec ,fld_swmovi) 
	Values (@extRutCotizante ,@extCorrBenef ,@extRutBeneficiario ,@fld_funfolio ,@fld_funfoliodig ,@fld_funcorrel ,getdate() ," ")
if @@rowcount = 0
begin
    select @extCodResBen    = "P"
    select @extMensajeError = "No se pudo actualizar Rut (2)"
    GoTo CGCBenRec_Exit
end
select @SRV_ReturnStatus = 0
CGCBenRec_Exit:
    If @SRV_ReturnStatus >= 60000
    Begin
        If @DAGTranLevel = 1
            Rollback Transaction
        Return 0
    End
    Else Begin
        If @DAGTranLevel = 1
            Commit Transaction
        Return 1
    End
End
                                                                                                                                                                                        
(11 rows affected)
(return status = 0)
1> 
