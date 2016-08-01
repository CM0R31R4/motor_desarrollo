locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
30
(1 row affected)
text
Create Procedure CGCAnulaBonoU
      @extCodFinanciador              int
    , @extFolioBono                   numeric(10,0)
    , @extIndTratam                   char(1)
    , @extFecTratam                   datetime
    , @extCodError                    char(1)         Output
    , @extMensajeError                char(30)        Output
As
Begin
    Select @extCodError = ' '
    Select @extMensajeError = ' '
    Declare @SRV_ReturnStatus               int
      , @fld_bonfolio                   int
     , @fld_bonestado                  tinyint
      , @Estado                         tinyint
      , @xi                             smallint
      , @fld_numerocorr                 tinyint
      , @fld_prestatipocod              tinyint
      , @fld_prestacod                  int
      , @fld_cant                       smallint
      , @fld_prestaval                  money
      , @fld_bonificval                 money
      , @sol_fecint                     datetime
      , @fld_cotrut                     char(11)
      , @fld_funfolio                   int
      , @fld_funcorrel                  smallint
      , @fld_bencorrel                  tinyint
      , @fld_medrut                     char(11)
      , @return_status                  smallint
      , @fld_benrut                     char(11)
      , @fld_bonreim                    tinyint
      , @fld_folioderivages             int
      , @fld_totcopagoges               money
      , @fld_bonemifec                  datetime
      , @fld_totcfages   		money
      , @fld_succod                     smallint
      , @fld_tipcob                     tinyint
      , @gest_foliows                   int
      , @fld_prestacod2                 varchar(15)
      , @DAGTranLevel                 	tinyint
    If @@TranCount = 0
    Begin
        Select @DAGTranLevel = 1
        Begin Transaction
    End Else
        Select @DAGTranLevel = 0
    Select @SRV_ReturnStatus = 0
select @SRV_ReturnStatus = 60001
select @extCodError  = "N"
select @fld_bonfolio = isnull(convert(int,@extFolioBono),0)
Select  @fld_bonestado = fld_bonestado
     ,  @fld_prestatipocod  = fld_prestatipocod
     ,  @sol_fecint         = fld_bonemifec
     ,  @fld_cotrut         = fld_cotrut
     ,  @fld_funfolio       = fld_funfolio
     ,  @fld_funcorrel      = fld_funcorrel
     ,  @fld_bencorrel      = fld_bencorrel
     ,  @fld_medrut         = fld_medrut
     ,  @fld_bonreim        = fld_bonreim
     ,  @fld_succod         = fld_succod
     ,  @fld_folioderivages = isnull(fld_folioderivages,0)
     ,  @fld_totcopagoges   = isnull(fld_totcopagoges,0)
     ,  @fld_totcfages      = isnull(fld_totcfages,0)
     ,  @fld_bonemifec      = fld_bonemifec
From BON
where fld_bonfolio = @fld_bonfolio
if @@rowcount = 0
begin
   select @extMensajeError = "No existe bono Colmena (BON)"
    GoTo CGCAnulaBonoU_Exit
end
if @fld_succod != 16
begin
   select @extMensajeError = "Bono no i-med, anular en Colmena"
    GoTo CGCAnulaBonoU_Exit
end
Select @fld_benrut = fld_benrut
From BEN
Where fld_cotrut    = @fld_cotrut     and
      fld_funfolio  = @fld_funfolio   and
      fld_funcorrel = @fld_funcorrel  and
      fld_bencorrel = @fld_bencorrel
if @@rowcount = 0
begin
   select @extMensajeError = "No existe Benef Colmena"
    GoTo CGCAnulaBonoU_Exit
end
If @fld_bonestado = 3
begin
   select @extMensajeError = "Folio Colmena ya está Anulado"
    GoTo CGCAnulaBonoU_Exit
end
If @fld_bonestado = 4
begin
   select @extMensajeError = "Folio Colmena ya fue Devuelto"
    GoTo CGCAnulaBonoU_Exit
end
If @fld_bonestado = 5
begin
   select @extMensajeError = "Folio ya cobrado por Prestador"
    GoTo CGCAnulaBonoU_Exit
end
Select @Estado = Estado
From VI_BONOS
where fld_bonfolio = @fld_bonfolio
if @@rowcount = 0
begin
   select @extMensajeError = "Bono I-med No existe VI_BONOS"
    GoTo CGCAnulaBonoU_Exit
end
If @Estado = 3
begin
   select @extMensajeError = "Folio Orden ya está Anulado"
    GoTo CGCAnulaBonoU_Exit
end
If @Estado = 4
begin
   select @extMensajeError = "Folio Orden ya fue Devuelto"
    GoTo CGCAnulaBonoU_Exit
end
If @Estado = 5
begin
   select @extMensajeError = "Folio Orden ya fue Cobrado"
    GoTo CGCAnulaBonoU_Exit
end
Update BON
Set  fld_bonestado   = 3
    ,fld_cajdevcod   = "Orden"
    ,fld_sucdevcod   = 16
    ,fld_bondevfec   = getdate()
    ,fld_bontraspaso = 0
Where fld_bonfolio   = @fld_bonfolio
if @@rowcount = 0
begin
   select @extMensajeError = "No se pudo Devolver Bono"
    GoTo CGCAnulaBonoU_Exit
end
Update VI_BONOS
Set  Estado = 3
Where fld_bonfolio  = @fld_bonfolio
if @@rowcount = 0
begin
   select @extMensajeError = "No se pudo Devolver Bono Orden"
    GoTo CGCAnulaBonoU_Exit
end
select @fld_numerocorr = 1
While (@fld_numerocorr <= 6) AND ( (Exists ( select 1 from BON_CDT where @fld_bonfolio = fld_bonfolio and   @fld_numerocorr = fld_boncorrel )))
Begin
   Select @fld_prestacod   = fld_prestacod
         ,@fld_cant        = fld_cant
         ,@fld_prestaval   = fld_prestaval
         ,@fld_bonificval  = fld_bonificval
         ,@fld_tipcob      = isnull(fld_tipcob,0)
         ,@fld_prestacod2  = fld_prestacod2
   From BON_CDT
   Where @fld_bonfolio = fld_bonfolio
   and   @fld_numerocorr = fld_boncorrel
   If @@rowcount = 0
   begin
      select @extMensajeError = "Problema en Linea de Bono"
    GoTo CGCAnulaBonoU_Exit
   end
   If @fld_prestatipocod in (13,18,19) and @fld_folioderivages = 0
   begin
      EXEC @return_status = EmpActualizaDetalleFicha @fld_bonfolio,3, @sol_fecint, @fld_benrut, @fld_medrut, "", @fld_prestacod, @fld_cant, @fld_prestaval, @fld_bonificval
      if @return_status = 0
      begin
         select @extMensajeError = "Error en la Rebaja de topes"
    GoTo CGCAnulaBonoU_Exit
      end
   end
   if @fld_folioderivages != 0 and @fld_tipcob = 1      
   begin
      Select @gest_foliows = isnull(gest_foliows,0)
      From GES_DERIVACION, GEST_TRATAMIENTO_CABECERA
      Where der_idn         = @fld_folioderivages
      And   gest_folio_trat = convert(varchar(10),ges_idn)
      if @@rowcount != 0
      begin
         select @fld_prestacod2 = substring(@fld_prestacod2,12,2)
         update GEST_TRATAMIENTO_DETALLE
         Set gest_cantidad_usada = gest_cantidad_usada - @fld_cant
         where gest_foliows   = @gest_foliows
         and   gest_cod_prest = convert(varchar(20),@fld_prestacod)
         and   gest_info_adic = @fld_prestacod2
         if @@rowcount = 0
         begin
            select @extMensajeError = convert(varchar(7),@fld_prestacod) + " imposible rebajar cant"
   	    GoTo CGCAnulaBonoU_Exit
         end
      end
   end
   Select @fld_numerocorr  = @fld_numerocorr + 1
End
if @fld_folioderivages = 0
begin
   select @xi = 0             
      EXEC   @xi = brps_borratopedpl 1, @fld_bonfolio
   If @xi = 0
   begin
      select @extMensajeError = "Problemas al Rebajar Topes"
    GoTo CGCAnulaBonoU_Exit
   end
end
else                             
   begin
   EXEC GesCasoDedBon 1, 1, @fld_folioderivages, @fld_bonemifec, @fld_totcopagoges, @fld_totcfages, 0
end
select @extCodError     = "S"
select @SRV_ReturnStatus = 0
CGCAnulaBonoU_Exit:
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
(30 rows affected)
(return status = 0)
1> 
