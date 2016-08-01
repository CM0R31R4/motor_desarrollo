locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
87
(1 row affected)
text
Create Procedure CGCEnvBonIs
      @extCodFinanciador              int
    , @extHomNumeroConvenio           char(15)
    , @extHomLugarConvenio            char(10)
    , @extSucVenta                    char(10)
    , @extRutConvenio                 char(12)
    , @extRutAsociado                 char(12)
    , @extNomPrestador                char(40)
    , @extRutTratante                 char(12)
    , @extEspecialidad                char(10)
    , @extRutBeneficiario             char(12)
    , @extRutCotizante                char(12)
    , @extRutAcompanante              char(12)
    , @extRutEmisor                   char(12)
    , @extRutCajero                   char(12)
    , @extCodigoDiagnostico           char(10)
    , @extDescuentoxPlanilla          char(1)
    , @extMontoExcedente              numeric(10,0)
    , @extFechaEmision                datetime
    , @extNivelConvenio               tinyint
    , @extFolioFinanciador            numeric(10,0)
    , @extMontoValorTotal             numeric(10,0)
    , @extMontoAporteTotal            numeric(10,0)
    , @extMontoCopagoTotal            numeric(10,0)
    , @extNumOperacion                numeric(10,0)
    , @extCorrPrestacion              numeric(10,0)
    , @extTipoSolicitud               tinyint
    , @extFechaInicio                 datetime
    , @extUrgencia                    char(1)
    , @extPlan                        char(15)
    , @extLista1                      char(255)
    , @extLista2                      char(255)
    , @extLista3 		      char(255)
    , @extCodError                    char(1)         Output
    , @extMensajeError                char(30)        Output
As
Begin
    Select @extCodError = ' '
    Select @extMensajeError = ' '
    Declare @SRV_ReturnStatus           int
      , @fld_bonfolio                   int
      , @fld_bencorrel                  tinyint
      , @fld_cotrut                     char(11)
      , @fld_funfolio                   int
      , @fld_prestatipocod              tinyint
  	, @fld_gpfns                      smallint
      , @fld_prestasubtipo              char(1)
      , @fld_bonemifec                  datetime
      , @fld_bonpagfec                  datetime
      , @fld_prestatipo                 tinyint
      , @fld_succod                     smallint
      , @fld_emicod                     varchar(8)
      , @ddp_correl                     tinyint
      , @pec_numcon                     int
      , @fld_bonestado                  tinyint
      , @pec_rut             char(11)
      , @fld_bonmacomp                  char(1)
      , @fld_cajemicod                  varchar(8)
      , @fld_especcod                   smallint
      , @fld_funcorrel                  smallint
      , @fld_cntcateg                 smallint
      , @fld_medtratante                char(11)
      , @fld_sucdig                     smallint
      , @fld_exced_sn                   char(1)
      , @fld_totprestaval               money
      , @fld_totbonific                 money
      , @ddp_huella                     char(1)
      , @fld_totprestacop               money
      , @fld_copisa                     char(1)
      , @fld_sucpagcod                  smallint
      , @mult_insrut                    char(11)
      , @mult_inscon 			int
      , @mult_insdir                    tinyint
      , @mult_medrut                    char(11)
      , @mult_medcon                    int
      , @mult_meddir                    tinyint
      , @fld_boncorrel                  tinyint
      , @fld_prestacod                  int
      , @fld_cant                       smallint
      , @fld_prestaval                  money
      , @fld_bonificval                 money
      , @fld_prestacop                  money
      , @fld_prestacod2                 varchar(15)
      , @xprev                          char(1)
      , @xorigen                        tinyint
      , @fld_benrut                     char(11)
      , @fld_region                     tinyint
      , @fld_pscrut          char(11)
      , @xi                             smallint
      , @xj                             smallint
      , @xk                             smallint
      , @xcodate                        int
      , @extMensajeCAT                  char(100)
      , @xconcod                        int
      , @xvalor_uf                      money
      , @xentero                        int
      , @xdv                            char(1)
      , @xconta_cons                    smallint
      , @xconta_exa                     smallint
      , @xconta_ima                     smallint
      , @xconta_proc                    smallint
      , @Respuesta                      char(1)
      , @xvalor                         money
      , @xlista                 
        char(1)
      , @xListaPrestac                  char(255)
      , @xfin                           tinyint
      , @xfld_concorrel                 tinyint
      , @xformato                       tinyint
      , @xinspeccion                    tinyi
nt
      , @der_idn                        int
      , @fld_tipcob                     tinyint
      , @fld_copagoges                  money
      , @fld_totcopagoges               money
      , @ges_idn                        int
      , @fld_folioderiva
ges             int
      , @fld_cfages                     money
      , @eah_valcop                     money
      , @fld_totcfages                  money
      , @gest_cod_prest                 varchar(20)
      , @gest_cantidad                  int
 
     , @gest_cantidad_usada            int
      , @gest_foliows                   int
      , @gest_folio_trat                varchar(10)
          , @DAGTranLevel                   tinyint
    If @@TranCount = 0
    Begin
        Select @DAGTranLevel = 
1
        Begin Transaction
    End Else
        Select @DAGTranLevel = 0
    Select @SRV_ReturnStatus = 0
select @SRV_ReturnStatus = 60001
select @xvalor_uf   = 0.
select @xinspeccion = 0
EXEC HosBusValUF  @extFechaEmision, @xvalor_uf output, @xinspeccio
n output
if @xvalor_uf = 0.
begin
    select @extCodError = "N", @extMensajeError = "No existe UF del día"
    GoTo CGCEnvBonIs_Exit
end
select @fld_pscrut = right(@extRutConvenio,11), @fld_medtratante = right(@extRutTratante,11)
select @extRutConvenio = 
right(@extRutConvenio,11)                       select @ddp_correl   = isnull(convert(tinyint,@extHomLugarConvenio),0)
if @extRutConvenio = "079611460-6"  --and @ddp_correl = 1
begin
   select @pec_rut = "079611460-6"
   select @ddp_huella = "S"
   select
 @pec_numcon = 0
end
else
begin
   Select @pec_rut = pec_rut
         ,@pec_numcon = pec_numcon
   From   BAMB_PEC
   Where  pec_rut = @extRutConvenio
   if @@rowcount = 0
   begin
       select @extCodError = "N", @extMensajeError = "No existe Rut en Con
venio"
    GoTo CGCEnvBonIs_Exit
   end
   select @xconcod  = isnull(convert(int,@extHomNumeroConvenio),0)     if (@xconcod = 0) or (@xconcod != @pec_numcon)
   begin
      select @extCodError = "N", @extMensajeError = "No existe Número de Convenio"
    G
oTo CGCEnvBonIs_Exit
   end
   Select @ddp_huella   = ddp_huella
   From   CM_DDP
   Where ddp_rut    = @extRutConvenio
   AND   ddp_correl = @ddp_correl
   if (@@rowcount = 0) or (@ddp_correl = 0)
   begin
      select @extCodError = "N", @extMensajeErro
r = "No existe Lugar Convenio"
    GoTo CGCEnvBonIs_Exit
   end
end
if @ddp_huella = "N"
begin
    select @extCodError = "N", @extMensajeError  = "Prestador / Dir no Autorizado"
    GoTo CGCEnvBonIs_Exit
end
select @fld_benrut = right(@extRutBeneficiario,
11)
select @fld_cotrut = right(@extRutCotizante,11)
Select  @fld_funfolio = fld_funfolio, @fld_funcorrel = fld_funcorrel, @fld_bencorrel = fld_bencorrel
From BEN
Where fld_benrut        = @fld_benrut      AND fld_beninivigfec <= @extFechaEmision AND
     
 fld_benfinvigfec >= @extFechaEmision AND fld_cotrut        = @fld_cotrut
if @@rowcount = 0
begin
    select @extCodError = "N", @extMensajeError = "No existe Rut Beneficiario"
    GoTo CGCEnvBonIs_Exit
end
Select @fld_cntcateg = fld_cntcateg
From CNT
Whe
re fld_funfolio  = @fld_funfolio  AND fld_funcorrel = @fld_funcorrel
if @@rowcount = 0
begin
    select @extCodError = "N", @extMensajeError = "No existe Contrato Vigente"
    GoTo CGCEnvBonIs_Exit
end
select @fld_bonfolio = isnull(convert(integer,@extFol
ioFinanciador),0)
if @fld_bonfolio = 0
begin
    select @extCodError = "N", @extMensajeError = "Folio del Bono en Cero"
    GoTo CGCEnvBonIs_Exit
end
select @fld_succod = 16, @fld_sucdig = 16, @fld_sucpagcod = 16
select @fld_emicod = right(@extRutEmisor,8
)
if (@fld_emicod = NULL) or (@fld_emicod = space(8)) or (@fld_emicod = "")
begin
    select @extCodError = "N", @extMensajeError = "Código del Emisor Inválido"
    GoTo CGCEnvBonIs_Exit
end
select @fld_cajemicod = right(@extRutCajero,8)
if (@fld_cajemico
d = NULL) or (@fld_cajemicod = space(8)) or (@fld_cajemicod = "")
begin
    select @extCodError = "N", @extMensajeError = "Código del Cajero Inválido"
    GoTo CGCEnvBonIs_Exit
end
if @extMontoExcedente > 0
begin
    select @extCodError = "N", @extMensaje
Error = "No se pueden usar Excedentes"
    GoTo CGCEnvBonIs_Exit
end
select @fld_bonemifec = CONVERT(DATETIME, (convert(varchar(12),@extFechaEmision,111) + " " +  convert(varchar(12),getdate(),108))   )
select @fld_bonpagfec = @extFechaEmision
select @fld
_bonestado = 2, @fld_bonmacomp = "C", @fld_exced_sn = "N", @fld_copisa = "N"
select @xconta_cons = 0, @xconta_exa  = 0, @xconta_ima  = 0, @xconta_proc = 0
select @xi = 0, @xk = 0, @xfin = 0, @xlista      = "1"
select @xListaPrestac = @extLista1
select @fl
d_totprestaval = 0., @fld_totbonific = 0., @fld_totprestacop = 0., @fld_totcopagoges = 0.
select @fld_folioderivages = 0, @fld_totcfages = 0.
select @fld_prestacod  = isnull(convert(int    ,substring(@xListaPrestac,(@xi*125+1),10)),0)
select @fld_prestaco
d2 = substring(@xListaPrestac,(@xi*125+15),15)
select @fld_cant       = isnull(convert(tinyint,substring(@xListaPrestac,(@xi*125+33), 2)),0)
select @fld_prestaval  = isnull(convert(money  ,substring(@xListaPrestac,(@xi*125+36), 7)),0)
select @fld_bonificv
al = isnull(convert(money  ,substring(@xListaPrestac,(@xi*125+44), 7)),0)
select @fld_prestacop  = isnull(convert(money  ,substring(@xListaPrestac,(@xi*125+52), 7)),0)
select @der_idn        = isnull(convert(int    ,substring(@xListaPrestac,(@xi*125+60),1
5)),0)
select @fld_cfages     = isnull(convert(money  ,substring(@xListaPrestac,(@xi*125+78), 7)),0)
While (@fld_prestacod != 0) AND (@xfin = 0)
Begin
   if @der_idn = 0
   begin
      select @fld_tipcob    = 0
      select @xorigen       = 2             
 select @fld_copagoges = 0
      select @fld_cfages    = 0
   end
   else
   begin
      select @fld_tipcob         = 1
      select @xorigen            = 3          select @fld_copagoges      = @fld_prestacop
      select @fld_folioderivages = @der_idn
 
     select @fld_totcopagoges   = @fld_totcopagoges + @fld_copagoges
      select @fld_totcfages      = @fld_totcfages + @fld_cfages
   end
   select @Respuesta = "", @extMensajeCAT = "", @fld_prestatipocod = 0, @fld_prestasubtipo = "", @fld_especcod = 0,
 @fld_gpfns = 0
   Exec Suc_Obt_Arancel @xorigen, @extFechaEmision, @fld_prestacod, 
             @fld_prestatipocod output, @fld_prestasubtipo output, @fld_especcod output,
             @fld_gpfns output, @Respuesta output, @extMensajeCAT output
   if @R
espuesta = "N"
   begin
      select @extCodError = "N", @extMensajeError = substring(@extMensajeCAT,1,30)
    GoTo CGCEnvBonIs_Exit
   end
   if @fld_prestatipocod = 1 or @fld_prestatipocod = 17
      select @xconta_cons = @xconta_cons + 1
   if @fld_pre
statipocod = 2
      select @xconta_exa  = @xconta_exa  + 1
   if @fld_prestatipocod = 3
      select @xconta_ima  = @xconta_ima  + 1
   if @fld_prestatipocod = 4
      select @xconta_proc = @xconta_proc + 1
   --if @fld_prestatipocod not in (2,3) and @xo
rigen != 3
   --begin
   --   If exists (Select 1 from BON_CDT where fld_bonfolio = @fld_bonfolio AND fld_prestacod = @fld_prestacod)
   --   begin
   --      select @extCodError   = "N", @extMensajeError  = "Detalle " + convert(varchar(10),@fld_bonfolio)
 + " CDT: " + convert(varchar(7),@fld_prestacod)
   -- GoTo CGCEnvBonIs_Exit
   --   end
   --end
   select @xk = @xk + 1
   if exists (select 1 From BON_CDT Where fld_bonfolio = @fld_bonfolio AND fld_boncorrel = @xk)
   begin
      select @extCodError   
= "N", @extMensajeError  = "Detalle " + convert(varchar(10),@fld_bonfolio) + " " + convert(varchar(2),@xk) + " Duplicado"
    GoTo CGCEnvBonIs_Exit
   end
   If @fld_prestatipocod in (13,18,19) and @fld_tipcob = 0         Begin
      Select @xprev = ""
  
    Exec EmpEvaluaPreventiva_2 @fld_prestacod , @fld_cant , @xprev output
      If @xprev = "S"
      Begin
         Exec EmpActualizaDetalleFicha @fld_bonfolio,2 ,@fld_bonemifec, @fld_benrut,@pec_rut,"", @fld_prestacod
                                   
  , @fld_cant, @fld_prestaval, @fld_bonificval
      End
   End
   insert into BON_CDT
      (fld_bonfolio  , fld_boncorrel  , fld_prestacod
      ,fld_cant      , fld_prestaval  , fld_bonificval  , fld_prestacop  , fld_prestacod2
      ,fld_tipcob    , f
ld_copagoges  , fld_cfages)
   values
      (@fld_bonfolio , @xk            , @fld_prestacod
      ,@fld_cant     , @fld_prestaval , @fld_bonificval , @fld_prestacop , @fld_prestacod2
      ,@fld_tipcob   , @fld_copagoges , @fld_cfages)
   select @fld_tot
prestaval = @fld_totprestaval + @fld_prestaval
   select @fld_totbonific   = @fld_totbonific   + @fld_bonificval
   select @fld_totprestacop = @fld_totprestacop + @fld_prestacop
   if @fld_tipcob = 1       begin
      select @eah_valcop = 0           EXEC
 GesCasoDedBon 0, 1, @der_idn, @fld_bonemifec, @fld_copagoges, 0, @eah_valcop output
      if @pec_rut = "079611460-6" --and @ddp_correl = 1
      begin
         Select @ges_idn = isnull(ges_idn,0)             From GES_DERIVACION
         Where der_idn = 
@der_idn
         If @@rowcount = 0 or @ges_idn = 0
         begin
            select @extCodError = "N", @extMensajeError = "Trat.Dental Sin Caso GES"
    GoTo CGCEnvBonIs_Exit
         end
                  select @gest_folio_trat = convert(varchar(10),
@ges_idn)
         Select @gest_foliows = isnull(gest_foliows,0)
         From GEST_TRATAMIENTO_CABECERA
         Where gest_folio_trat = @gest_folio_trat
         If @@rowcount = 0 or @gest_foliows = 0
         begin
            select @extCodError = "N"
, @extMensajeError = "Trat.Ges Dental no encontrado"
    GoTo CGCEnvBonIs_Exit
         end
                   select @gest_cod_prest = convert(varchar(20),@fld_prestacod)
         select @fld_prestacod2 = substring(@fld_prestacod2,12,2)
         Select @
gest_cantidad       = isnull(gest_cantidad,0)
               ,@gest_cantidad_usada = isnull(gest_cantidad_usada,0)
         From GEST_TRATAMIENTO_DETALLE
         Where gest_foliows   = @gest_foliows
         And   gest_cod_prest = @gest_cod_prest
       
  And   gest_info_adic = @fld_prestacod2
         if @@rowcount = 0
         begin
            select @extCodError = "N", @extMensajeError = convert(varchar(7),@fld_prestacod) + " No existe en Det.Trat."
    GoTo CGCEnvBonIs_Exit
         end
         if 
@fld_cant + @gest_cantidad_usada > @gest_cantidad
         begin
            select @extCodError = "N", @extMensajeError = convert(varchar(7),@fld_prestacod) + " Cantidad > Autorizado"
    GoTo CGCEnvBonIs_Exit
         end
         Update GEST_TRATAMIENT
O_DETALLE
         Set gest_cantidad_usada = @fld_cant + @gest_cantidad_usada
         Where gest_foliows   = @gest_foliows
         And   gest_cod_prest = @gest_cod_prest
         And   gest_info_adic = @fld_prestacod2
      end
   end
   else           
          begin
      select @xformato = 0, @xj = 0, @xvalor = round(@fld_bonificval/@xvalor_uf,2)
      exec @xj = GrlTopAct @xformato, @fld_funfolio, @fld_funcorrel, @fld_cotrut, @fld_bencorrel,
                @fld_prestatipocod, @fld_prestasubtipo, @x
valor, @fld_cant
      if @xj = 0
      begin
         select @extCodError = "N", @extMensajeError = "Problemas al acumular topes"
    GoTo CGCEnvBonIs_Exit
      end
   end
   select @xi = @xi + 1
   if @xi = 2
   begin
      if @xlista = "1"
      begin

         select @xlista = "2", @xListaPrestac = @extLista2
      end
      else
      begin
         if @xlista = "2"
      Begin
         select @xlista = "3", @xListaPrestac = @extLista3
      End
      Else
          select @xfin = 1
      end
      s
elect @xi  = 0
   end
   select @fld_prestacod  = isnull(convert(int    ,substring(@xListaPrestac,(@xi*125+ 1),10)),0)
   select @fld_prestacod2 = substring(@xListaPrestac,(@xi*125+15),15)
   select @fld_cant       = isnull(convert(tinyint,substring(@xLis
taPrestac,(@xi*125+33), 2)),0)
   select @fld_prestaval  = isnull(convert(money  ,substring(@xListaPrestac,(@xi*125+36), 7)),0)
   select @fld_bonificval = isnull(convert(money  ,substring(@xListaPrestac,(@xi*125+44), 7)),0)
   select @fld_prestacop  = is
null(convert(money  ,substring(@xListaPrestac,(@xi*125+52), 7)),0)
   select @der_idn        = isnull(convert(int    ,substring(@xListaPrestac,(@xi*125+60),15)),0)
   select @fld_cfages     = isnull(convert(money  ,substring(@xListaPrestac,(@xi*125+78), 7
)),0)
End
if @fld_totprestaval != @extMontoValorTotal
begin
   select @extCodError = "N", @extMensajeError = "Total Cobrado <> suma detalles"
    GoTo CGCEnvBonIs_Exit
end
if @fld_totbonific != @extMontoAporteTotal
begin
   select @extCodError = "N", @ext
MensajeError = "Total Bonif. <> suma detalles"
    GoTo CGCEnvBonIs_Exit
end
if @fld_totprestacop != @extMontoCopagoTotal
begin
   select @extCodError = "N", @extMensajeError = "Total Copago <> suma detalles"
    GoTo CGCEnvBonIs_Exit
end
if (@xconta_cons
 != 0)
   select @fld_medtratante = right(@extRutTratante,11)
if (@xconta_exa != 0) or (@xconta_ima != 0) or (@xconta_proc != 0)
   select @fld_medtratante = right(@extRutAsociado,11)
if exists (select 1 from VI_BONOS where extFolioFinanciador = @extFolio
Financiador)
begin
    select @extCodError = "N", @extMensajeError = "Bono Orden Duplicado en VI_BON"
    GoTo CGCEnvBonIs_Exit
end
insert into VI_BONOS
( fld_bonfolio
, extFolioFinanciador , extCodFinanciador   , extHomNumeroConvenio, extHomLugarConvenio

, extSucVenta         , extRutConvenio      , extRutAsociado      , extNomPrestador
, extRutTratante      , extRutBeneficiario  , extRutCotizante     , extRutAcompanante
, extRutEmisor        , extRutCajero        , extCodigoDiagnostico, extDescuentoxPla
nilla
, extMontoExcedente   , extFechaEmision     , extNivelConvenio    , extMontoValorTotal
, extMontoAporteTotal , extMontoCopagoTotal , extNumOperacion     , extCorrPrestacion
, extTipoSolicitud    , extFechaInicio      , extLista1           , Estado
)

Values
(@fld_bonfolio
,@extFolioFinanciador ,@extCodFinanciador   ,@extHomNumeroConvenio ,@extHomLugarConvenio
,@extSucVenta         ,"0"+ @extRutConvenio ,@extRutAsociado       ,@extNomPrestador
,@extRutTratante      ,@extRutBeneficiario  ,@extRutCotiza
nte      ,@extRutAcompanante
,@extRutEmisor        ,@extRutCajero        ,@extCodigoDiagnostico ,@extDescuentoxPlanilla
,@extMontoExcedente   ,@extFechaEmision     ,@extNivelConvenio     ,@extMontoValorTotal
,@extMontoAporteTotal ,@extMontoCopagoTotal ,@e
xtNumOperacion      ,@extCorrPrestacion
,@extTipoSolicitud    ,@extFechaInicio      ,@extLista1            ,2
)
if @@rowcount = 0
begin
   select @extCodError = "N", @extMensajeError = "No se pudo grabar bono Orden "
    GoTo CGCEnvBonIs_Exit
end
select @
fld_prestatipo = 2
if @fld_prestatipocod in (13, 18, 19)
    select @fld_prestatipo = 1
if exists (select 1 from BON where fld_bonfolio = @fld_bonfolio)
begin
    select @extCodError = "N", @extMensajeError = "Bono Colmena Duplicado"
    GoTo CGCEnvBonIs_
Exit
end
Select @mult_insrut = mult_insrut
      ,@mult_inscon = mult_inscon
      ,@mult_insdir = mult_insdir
From VI_MULTIP
Where mult_medrut = @pec_rut    AND
      mult_medcon = @pec_numcon AND
      mult_meddir = @ddp_correl
If @@rowcount != 0
begin

   Select @mult_medrut = @pec_rut
   Select @pec_rut         = @mult_insrut
   Select @pec_numcon      = @mult_inscon
   Select @ddp_correl      = @mult_insdir
   Select @fld_medtratante = @mult_medrut
end
insert into BON
( fld_bonfolio      , fld_bencorr
el      , fld_cotrut       , fld_funfolio
, fld_prestatipocod , fld_prestasubtipo  , fld_bonemifec    , fld_bonpagfec
, fld_prestatipo    , fld_succod         , fld_emicod       , fld_concorrel
, fld_concod        , fld_bonestado      , fld_medrut       ,
 fld_bonmacomp
, fld_cajemicod     , fld_especcod       , fld_funcorrel    , fld_cntcateg
, fld_medtratante   , fld_sucdig         , fld_exced_sn     , fld_totprestaval
, fld_totbonific    , fld_totprestacop   , fld_copisa       , fld_sucpagcod
, fld_totb
onpla     , fld_folioderivages , fld_totcopagoges , fld_totcfages
)
Values
(@fld_bonfolio      ,@fld_bencorrel      ,@fld_cotrut       ,@fld_funfolio
,@fld_prestatipocod ,@fld_prestasubtipo  ,@fld_bonemifec    ,@fld_bonpagfec
,@fld_prestatipo    ,@fld_suc
cod         ,@fld_emicod       ,@ddp_correl
,@pec_numcon        ,@fld_bonestado      ,@pec_rut          ,@fld_bonmacomp
,@fld_cajemicod     ,@fld_especcod       ,@fld_funcorrel    ,@fld_cntcateg
,@fld_medtratante   ,@fld_sucdig         ,@fld_exced_sn     
,@fld_totprestaval
,@fld_totbonific    ,@fld_totprestacop   ,@fld_copisa       ,@fld_sucpagcod
,@fld_totbonific    ,@fld_folioderivages ,@fld_totcopagoges ,@fld_totcfages
)
if @@rowcount = 0
begin
   select @extCodError = "N", @extMensajeError = "No se pu
do grabar bono Colmena"
    GoTo CGCEnvBonIs_Exit
end
select @extCodError = "S"
select @SRV_ReturnStatus = 0
CGCEnvBonIs_Exit:
    If @SRV_ReturnStatus >= 60000
    Begin
        If @DAGTranLevel = 1
            Rollback Transaction
        Return 0
    E
nd
    Else Begin
        If @DAGTranLevel = 1
            Commit Transaction
        Return 1
    End
End
                                                                                                                                                    
(87 rows affected)
(return status = 0)
1> 
