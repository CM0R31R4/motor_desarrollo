locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
18
(1 row affected)
text
Create Procedure CGCEnrola
      @extCodFinanciador              int
    , @extRutEnrolar                  char(12)
    , @extRutBeneficiario             char(12)
    , @extValido                      char(1)         Output
    , @extNombreComp           char(40)        Output
As
Begin
    Select @extValido = ' '
    Select @extNombreComp = ' '
    Declare @SRV_ReturnStatus               int
      , @fld_benrut                     char(11)
      , @fld_funfolio                   int
      , @fld_funcorrel                  smallint
      , @fld_asocrut                    char(11)
      , @xfecha                         datetime
      , @xcodate                        int
      , @fld_cotrut                     char(11)
      , @fld_conrut           char(11)
      , @xfld_conespcod                 smallint
      , @dir_rut                        char(11)
      , @not_rutpoder                   char(11)
    Select @SRV_ReturnStatus = 0
select @extValido       = "N"
select @extNombreComp   = ""
select @xfecha       = getdate()
select @fld_benrut   = right(@extRutBeneficiario,11)
if @extRutEnrolar = @extRutBeneficiario
begin
   Select  @extNombreComp = rtrim(fld_benapepa) + " " + rtrim(fld_benapema) + " " +  rtrim(fld_bennombre)
   From BEN
  Where fld_benrut        = @fld_benrut  AND
         fld_beninivigfec <= @xfecha      AND
         fld_benfinvigfec >= @xfecha
   if @@rowcount != 0
   begin
      select @extValido     = "S"
   end
end
else
begin
   Select  @fld_funfolio  = fld_funfolio 
          ,@fld_funcorrel = fld_funcorrel
   From BEN
   Where fld_benrut        = @fld_benrut  AND
         fld_beninivigfec <= @xfecha      AND
         fld_benfinvigfec >= @xfecha
   if @@rowcount = 0
    GoTo CGCEnrola_Exit
   select @fld_cotrut = right(@extRutEnrolar,11)
   Select  @extNombreComp = rtrim(fld_benapepa) + " " + rtrim(fld_benapema) + " " +  rtrim(fld_bennombre)
   From BEN
   Where fld_funfolio      = @fld_funfolio   AND
         fld_funcorrel     = @fld_funcorrel  AND
         fld_benrut        = @fld_cotrut     AND
         fld_beninivigfec <= @xfecha         AND
         fld_benfinvigfec >= @xfecha         AND
         datediff(yy,fld_bennacfec,@xfecha) > 17
   if @@rowcount != 0
   begin
      select @extValido     = "S"
    GoTo CGCEnrola_Exit
   end
   Select  @xfld_conespcod  = fld_conespcod
          ,@fld_asocrut     = fld_asocrut
          ,@fld_conrut      = fld_conrut
          ,@dir_rut         = fld_cotrut
   From CNT
   Where fld_funfolio  = @fld_funfolio AND fld_funcorrel = @fld_funcorrel
   if @@rowcount = 0
    GoTo CGCEnrola_Exit
   if @xfld_conespcod in (4, 24, 34, 124, 234, 1234)
   begin
      if @fld_asocrut = @fld_cotrut
      begin
         Select  @extNombreComp = rtrim(fld_benapepa) + " " + rtrim(
fld_benapema) + " " +  rtrim(fld_bennombre)
         From BEN
         Where fld_cotrut    = @fld_asocrut AND
               fld_bencorrel = 0            AND
               fld_beninivigfec <= @xfecha  AND
               fld_benfinvigfec >= @xfecha
      
   If @@rowcount != 0
         begin
            select @extValido     = "S"
    GoTo CGCEnrola_Exit
         end
      end
      if @fld_conrut = @fld_cotrut
      begin
         Select @extNombreComp = rtrim(fld_benapepa) + " " + rtrim(fld_benapema) + " " +  rtrim(fld_bennombre)
         From BEN
         Where fld_cotrut = @fld_conrut     AND
               fld_bencorrel     = 0        AND
               fld_beninivigfec <= @xfecha  AND
               fld_benfinvigfec >= @xfecha
         If @@rowcount != 0
         begin
            select @extValido     = "S"
    GoTo CGCEnrola_Exit
         end
      end
   end
   select @extNombreComp = A.not_nompoder
   from NOTARIA A, NOTARIA_DETALLE B
   where A.not_ruttitu  = @dir_rut    and 
	 A.not_rutpo der = @fld_cotrut and
         A.not_estado   = 1           and  ((A.not_fecpoder <= @xfecha  AND A.not_fecter   >= @xfecha) OR (not_fecter = "Jan 01 1900")) AND
         B.not_ruttitu  = @dir_rut    and
         B.not_rutpoder = @fld_cotrut and
         B.not_benef    = @fld_benrut and
         B.not_imedbene = "S"         and
         B.not_estado   = 1
   If @@rowcount != 0
   begin
      select @extValido     = "S"
    GoTo CGCEnrola_Exit
   end
End
CGCEnrola_Exit:
    If @SRV_ReturnStatus >= 60000
    Begin
        Return 0
    End
    Else Begin
        Return 1
    End
End                                                                                                                                                                        
(18 rows affected)
(return status = 0)
1> 
