locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
9
(1 row affected)
text
Create Procedure CGCLeeRutCotiz
      @extCodFinanciador              smallint
    , @extRutCotizante                char(12)
    , @extNomCotizante                char(40)        Output
    , @extCodError                    char(1)         Output
    , @extMensajeError                char(30)        Output
As
Begin
    Select @extNomCotizante = ' '
    Select @extCodError = ' '
    Select @extMensajeError = ' '
    Declare @SRV_ReturnStatus               int
      , @extCorrBenef                   smallint
      , @extRutBeneficiario             char(12)
      , @extApellidoPat                 char(30)
      , @extApellidoMat                 char(30)
      , @extNombres                     char(40)
      , @extCodEstBen                   char(1)
      , @extDescEstado                  char(15)
      , @fld_cotrut                     char(11)
      , @fld_funfolio                   int
      , @fld_funcorrel                  smallint
      , @fld_benrut                     char(11)

Select @SRV_ReturnStatus = 0
select @extCodError     = ""
select @extMensajeError = space(30)
select @fld_cotrut      = right(@extRutCotizante,11)

Select  @fld_funfolio     = fld_funfolio
        ,@fld_funcorrel   = fld_funcorrel
        ,@extNomCotizante = rtrim(fld_cotapepa) + " " + rtrim(fld_cotapema) + " " + rtrim(fld_cotnombre)
	From CNT
	Where fld_cotrut     = @fld_cotrut  AND
      		fld_inivigfec <= getdate()    AND
      		fld_finvigfec >= getdate()

if @@rowcount = 0
begin
    select @extCodError     = "N"
    select @extMensajeError = "Titular No Vigente o No Existe"
    GoTo CGCLeeRutCotiz_Exit
end
select   extCorrBenef       = fld_bencorrel
        ,extRutBeneficiario = "0" + fld_benrut
        ,extApellidoPat     = fld_benapepa
        ,extApellidoMat     = fld_benapema
        ,extNombres         = fld_bennombre
        ,extCodEstBen       = "C"
        ,extDescEstado      = "Certificado    "
From BEN
Where fld_funfolio     = @fld_funfolio  AND
      fld_funcorrel    = @fld_funcorrel
if @@rowcount = 0
begin
    select @extCodError     = "N"
    select @extMensajeError = "No existen datos del Contrato"
    GoTo CGCLeeRutCotiz_Exit
end
CGCLeeRutCotiz_Exit:
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
