locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
167
(1 row affected)
text

Create Procedure CGCValorVari
      @extCodFinanciador        int                          /* Código del Financiador */
    , @extHomNumeroConvenio     char(15)                     /* Homólogo número del convenio */
    , @extHomLugarConvenio 	char(10)                     /* Homólogo lugar del Convenio */
    , @extSucVenta              char(10)                     /* Homólogo sucursal de venta Financiador */
    , @extRutConvenio           char(12)                     /* Rut del Prestador en convenio */
    , @extRutTratante           char(12)                     /* Rut Tratante */
    , @extEspecialidad          char(10)                     /* Especialidad tratante */
    , @extRutSolicitante        char(12)                     /* Rut Solicitante */
    , @extRutBeneficiario       char(12)                     /* Rut del Beneficiario */
    , @extTratamiento           char(1)                      /* Tratamiento Médico */
    , @extCodigoDia gnostico    char(10)                     /* Código de Diagnostico */
    , @extNivelConvenio         tinyint                      /* Nivel Convenido por el Prestador */
    , @extUrgencia              char(1)                      /* Indicador de Urgencia */
    , @extLista1                char(255)                    /* Lista A que concatena las prestaciones */
    , @extLista2                char(255)                    /* Lista A que concatena las prestaciones */
    , @extLista3                char(255)                    /* Lista A que concatena las prestaciones */
    , @extLista4                char(255)                    /* Lista A que concatena las prestaciones */
    , @extLista5                char(255)                    /* Lista A que concatena las prestaciones */
    , @extLista6                char(255)                    /* Lista A que concatena las prestaciones */
    , @extLista7                char(255)                    /* Lista contiene las Prestaciones */
    , @extNumPrestaciones       tinyint                      /* Número de Prestaciones */
    , @extCodError              char(1)         Output       /* Código Error (S/N) */
    , @extMensajeError		char(30)        Output       /* Mensaje de Error */
    , @extPlan                  char(15)        Output       /* Plan Financiador */
    , @extGlosa1                char(50)        Output       /* Mensaje Primera Linea */
    , @extGlosa2                char(50)        Output       /* Mensaje segunda linea */
    , @extGlosa3                char(50)        Output       /* Mensaje tercera Linea */
    , @extGlosa4                char(50)        Output       /* Mensaje Cuarta Linea */
    , @extGlosa5                char(50)        Output       /* Mensaje Quinta Linea */
/*  , @extValorPrestacion       numeric(12,0)   Column          Valor de la Prestación según el convenio*/
/*  , @extAporteFinanciador	numeric(12,0)   Column          Aporte Financiador*/
/*  , @extCopago                numeric(12,0)   Column          Copago Beneficiario*/
/*  , @extInternoIsa            char(15)        Column          Interno Isapre*/
/*  , @extTipoBonif1            tinyint         Column          Tipo Bonificacion 1*/
/*  , @extCopago1               numeric(12,0)   Column          Monto Bonificacion Adicional 1*/
/*  , @extTipoBonif2            tinyint         Column          Tipo Bonificacion 2*/
/*  , @extCopago2               numeric(12,0)   Column          Monto Bonificacion adicional 2*/
/*  , @extTipoBonif3            tinyint         Column          Tipo Bonificacion 3*/
/*  , @extCopago3               numeric(12,0)   Column          Monto Bonificacion Adicional 3*/
/*  , @extTipoBonif4            tinyint         Column          Tipo Bonificacion 4*/
/*  , @extCopago4               numeric(12,0)   Column          Monto Bonificacion Adicional 4*/
/*  , @extTipoBonif5            tinyint         Column          Tipo Bonificacion 5*/
/*  , @extCopago5               numeric(12,0)   Column          Monto Bonificacion Adicional 5*/
As
Begin 
    Select @extCodError = ' '
    Select @extMensajeError = ' '
    Select @extPlan = ' '
    Select @extGlosa1 = ' '
    Select @extGlosa2 = ' '
    Select @extGlosa3 = ' '
    Select @extGlosa4 = ' '
    Select @extGlosa5 = ' '


    Declare @SRV_ReturnStatus               int
      , @extValorPrestacion		 numeric(12,0)
      , @extAporteFinanciador           numeric(12,0)
      , @extCopago                      numeric(12,0)
      , @extInternoIsa                  char(15)
      , @extTipoBonif1          tinyint
      , @extCopago1    		numeric(12,0)
      , @extTipoBonif2                  tinyint
      , @extCopago2                     numeric(12,0)
      , @extTipoBonif3                  tinyint
      , @extCopago3                     numeric(12,0)
      , @extTipoBonif4                  tinyint
      , @extCopago4                     numeric(12,0)
      , @extTipoBonif5                  tinyint
      , @extCopago5                     numeric(12,0)
      , @fld_cotrut                     char(11)
      , @fld_benrut   			char(11)
      , @fld_bencorrel                  tinyint
      , @fld_anoanualidad               smallint
      , @fld_bennacfec                  datetime
      , @fld_funfolio                   int
      , @fld_funcorrel                smallint
      , @fld_funanufec                  tinyint
      , @fld_planvig                    varchar(6)
      , @fld_cntcateg                   smallint
      , @fld_prestamonto                money
      , @fld_prestanum                  smallint
 	, @fld_pscrut                     char(11)
      , @fld_valortotal                 money
      , @ddp_reemimed                   char(1)
      , @pec_rut                        char(11)
      , @ddp_correl                     tinyint
      , @pec_num con                     int
      , @xinspeccion                    tinyint
      , @fld_anestesia                  char(1)
      , @ddp_huella                     char(1)
      , @fld_prestaval                  money
      , @fld_prestacod               int
      , @fld_gpfns                      smallint
      , @fld_cant                       smallint
      , @fld_agruitemcod                smallint
      , @fld_prestacod2                 varchar(15)
      , @fld_subagruitemcod             char(1)
      , @fld_especcod                   smallint
      , @xi                             smallint
      , @xj                             smallint
      , @xfin                           tinyint
      , @xListaPrestac                  char(255)
      , @xcodate                        int
      , @xlista                         char(1)
      , @extMensajeCAT                  char(100)
      , @xfecha                         datetime
      , @xconcod                        int
      , @xconta_cons           		smallint
      , @xconta_hon                     smallint
      , @xconta_anes                    smallint
      , @Respuesta                      char(1)
      , @xvalor                         money
      , @xprestamonto                   money
      , @xcopago                        money
      , @xbonificado                    money
      , @xvalor_uf                      money
      , @xentero                        int
      , @xdv                            char(1)
      , @xRutTratante   		char(11)
      , @xvalor5                        money
      , @xprev                          char(1)
      , @mensaje                        char(255)
      , @xvalorminfo                    money
      , @fld_sintopeanual               char(1)
      , @hon_fijo                       char(1)
      , @hon_valcop                     int
      , @der_idn                        int
      , @ges_idn                        int
      , @fld_cfages                     money
      , @fld_ges     			char(1)
      , @xrel_idn                       int
      , @xrel_tatencion                 tinyint
      , @xrel_tipcon                    tinyint
      , @xrel_tventa                    tinyint
      , @xrel_tcliente                  int
      , @rel_instit                     char(11)
      , @rel_medico                     char(11)
      , @rel_dir                        tinyint
      , @rel_tatencion                  tinyint
      , @rel_tiphorario                 char(1)
      , @rel_tipcon                     tinyint
      , @rel_tventa                     tinyint
      , @xorigen_vta                    tinyint
      , @amb_costo_cero                 char(1)
      , @fld_rdsporc                    smallint
      , @xtipo_bonif   			tinyint
      , @xsuperatopepresta              tinyint
      , @xvalortopeprest                money
      , @fld_numerocorr                 tinyint
      , @xacumulavalor                  money
      , @xvalorunitario                 money
      , @bonificadouni                  money
      , @fld_inhabil                    char(1)
      , @xtienerds                      char(1)
      , @porcen                         tinyint
      , @der_deduti                     money
      , @xorigen                        tinyint
      , @fld_totcopagoges               money
      , @is_idn                         int
      , @der_coptip                     char(1)
      , @gest_foliows                   int
      , @gest_cod_prest                 varchar(20)
      , @gest_cantidad                  int
      , @gest_cantidad_usada            int
      , @gest_folio_trat                varchar(10)
      , @xcontador                      smallint

    Select @SRV_ReturnStatus = 0

/*-----------------
------------------------------------------------*/
/*------------------------ Begin User Code ------------------------*/
/*-----------------------------------------------------------------*/
/*--------------------------------------------------------------
--------------------------------------------------------
! Autor : Jorge Román 
! Fecha : 15-02-2001.
! Obj.  : Valida Prestaciones, Obtiene Valor Convenido, Calcula Bonificado y 
!         Topa las prestaciones respecto a consumos anteriores.
! Muy impor
tante:
!   - El cálculo de topes se hace ocupando una tabla temporal de Topes y Detalle;
!   obteniendo una bonificación real.
! 08/2010: Se ajusta llamada a servicio de convenios médicos por cambio en el criterio del bono cero
! 07-2011: JRM, se vinculan
 los convenios GES para dentales
! 20-03-2012: EMontiel, Se realiza modificación si tiene RDS y cobertura 0, no permitir continuar y despliega mensaje
! 25-04-2012: Validación por sexo de prestaciones preventivas
! 24-07-2012: Si tiene RDS emisión del bon
o solo en sucursal
! 14-12-2012: Solo si RDS es 0 debe ir a la sucursal a solicitar el bono
! 08-02-2013: JRM, se ajusta llamado a Suc_Calcula_Convenio_4
! 18-03-2013: JRM, ajusta valorización de vacuna anti influenza (2601701)
! 20-05-2013: JRM, ajusta o
bención de IS en base a lo que se indica en las prestaciones
!----------------------------------------------------------------------------------------------------------------------------*/

select @fld_cfages = 0, @ges_idn = 0, @der_idn = 0 
 
-- CODIGOS 
YA PROCESADOS
create table #codate2
(codigo     int         not null , codigo2    char(15)    not null
,convenido  numeric(12) not null , bonificado numeric(12) not null
,copago     numeric(12) not null , ges        char(01)    not null
,cfa_ges    numeric(12) not null , interno    char(15)    not null)
-- TOPES
create table #topes
(grupo      tinyint     not null , sgrupo     char(1)     not null
,monto      money       not null , cantidad   int         not null)

-- valor de la UF a hoy 
select @xfecha = getdate(), @xvalor_uf = 0. , @xinspeccion = 0

EXEC HosBusValUF  @xfecha, @xvalor_uf output, @xinspeccion output
if @xvalor_uf = 0.
begin
    select @extCodError = "N", @extMensajeError = "No existe UF del día"
    GoTo CGCValorVari_Exit
end

select @extRutConvenio = right(@extRutConvenio,11)                      -- Prestador en Convenio
select @ddp_correl   = isnull(convert(tinyint,@extHomLugarConvenio),0)  -- dirección del convenio 

if @extRutConvenio = "079611460-6"
begin
   select @pec_rut = "079611460-6"
   select @ddp_huella = "S"
   select @ddp_reemimed = "N"
end
else
begin
   Select @pec_rut = pec_rut
         ,@pec_numcon = pec_numcon
   From   BAMB_PEC
   Where  pec_rut = @extRutConvenio
   if @@rowcount = 0
   begin
       select @extCodError = "N", @extMensajeError = "No existe Rut en Convenio"
    GoTo CGCValorVari_Exit
   end

   select @xconcod  = isnull(convert(int,@extHomNumeroConvenio),0) -- código del convenio 
   if (@xconcod = 0) or (@xconcod != @pec_numcon)
   begin
      select @extCodError = "N", @extMensajeError = "No existe Número de Convenio"
    GoTo CGCValorVari_Exit
   end

   Select @ddp_huella   = ddp_huella
         ,@ddp_reemimed = ddp_reemimed 
   From   CM_DDP
   Where ddp_rut    = @extRutConvenio
   AND   ddp_correl = @ddp_correl
   if (@@rowcount = 0)
   begin
      select @extCodError = "N", @extMensajeError = "No existe Lugar Convenio"
    GoTo CGCValorVari_Exit
   end
end

if @ddp_huella = "N" -- prestador autorizado a la venta 
begin 
    select @extCodError = "N", @extMensajeError = "Prestador/ Dir. no Autorizada"
    GoTo CGCValorVari_Exit
end

select @xRutTratante = right(@extRutTratante,11) -- tratante 
if rtrim(@xRutTratante) = ""
   select @xRutTratante = "000000000-0"

select @fld_benrut    = right(@extRutBeneficiario,11) -- datos del contrato a partir del beneficiario 
Select @fld_cotrut    = fld_cotrut   , @fld_funfolio  = fld_funfolio
      ,@fld_funcorrel = fld_funcorrel, @fld_bencorrel = fld_bencorrel
      ,@fld_bennacfec = fld_bennacfec
From BEN
Where fld_benrut        = @fld_benrut
AND   fld_beninivigfec <= @xfecha
AND   fld_benfinvigfec >= @xfecha

if @@rowcount = 0
begin
    select @extCodError = "N", @extMensajeError = "No existe Rut Beneficiario"
    GoTo CGCValorVari_Exit
end

Select @fld_anoanualidad = fld_anoanualidad, @fld_funanufec = fld_funanufec   -- datos del contrato
      ,@fld_planvig      = fld_planvig      ,@fld_cntcateg  = fld_cntcateg
From CNT
Where fld_funfolio  = @fld_funfolio
AND   fld_funcorrel = @fld_funcorrel

if @@rowcou
nt = 0
begin
    select @extCodError = "N", @extMensajeError = "No existe Contrato Vigente"
    GoTo CGCValorVari_Exit
end

Select @extPlan = rtrim(@fld_planvig) + " - " + rtrim(GLS_DESACA)
From ISAPREDESACA
Where COD_DESACA = @fld_cntcateg

Insert into #
topes  -- topes actuales del beneficiario
select dtop_grupo, dtop_sgrupo, dtop_monto, dtop_cantidad
From   DTOPES
Where dtop_rut      = @fld_cotrut
AND   dtop_benef    = @fld_bencorrel
AND   dtop_anoanual = @fld_anoanualidad
AND   dtop_mesanual = @fld_fun
anufec

Select @xprestamonto = top_monto  -- total utilizado anual en UF por el beneficiario 
From TOPES
Where top_rut      = @fld_cotrut
AND   top_benef    = @fld_bencorrel
AND   top_anoanual = @fld_anoanualidad
AND   top_mesanual = @fld_funanufec

If @@
rowcount = 0
   Select @xprestamonto = 0.

if @extUrgencia = "S" -- tipo de atención
   select @rel_tatencion = 3    -- urgencia
else
   select @rel_tatencion = 1    -- ambulatorio

-- valida prestaciones dentales GES
select @ges_idn = 0
if @pec_rut = "07
9611460-6" and @extCodigoDiagnostico != ""
begin
   select @ges_idn = convert(int,@extCodigoDiagnostico) -- caso GES vigente
   if not exists (select 1 from GES_CASO where ges_idn = @ges_idn and ges_rutben = @fld_benrut and ges_despre = "079611460-6" and 

                 ps_idn = 66 and ges_estado in ("I", "T") and @xfecha between ges_vigini and ges_vigfin)
   begin
      select @extCodError = "N", @extMensajeError = "Beneficiario No tiene Caso GES"
    GoTo CGCValorVari_Exit
   end

   select @gest_foli
o_trat = @extCodigoDiagnostico    -- el tratamiento debe existir en tablas GEST_TRATAMIENTO_CABECERA

   Select @gest_foliows = isnull(max(gest_foliows),0)
   From GEST_TRATAMIENTO_CABECERA
   Where gest_folio_trat = @gest_folio_trat
   if @@rowcount = 0 
or @gest_foliows = 0
   begin
      select @extCodError = "N", @extMensajeError = "Trat.Ges Dental no encontrado"
    GoTo CGCValorVari_Exit
   end
end

select @xconta_anes = 0, @xconta_cons = 0, @xconta_hon = 0, @xj = 0, @xi = 0, @xfin = 0, @xlista = "A"
, @xListaPrestac = @extLista1 

-- prestación, adicional, cantidad, inhabil, cobrado 
select @fld_prestacod  = isnull(convert(int,substring(@xListaPrestac,(@xi*48+1),10)),0) 
select @fld_prestacod2 = substring(@xListaPrestac,(@xi*48+15),15)
select @fld_in
habil    = substring(@xListaPrestac,(@xi*48+31),1)
select @fld_cant       = isnull(convert(tinyint,substring(@xListaPrestac,(@xi*48+33),2)),0)
select @fld_valortotal = isnull(convert(int,substring(@xListaPrestac,(@xi*48+36),12)),0)

While (@fld_prestacod 
!= 0) AND (@xfin = 0)
Begin
   if @ges_idn != 0    -- Prestaciones GES
   begin
      select @Respuesta = "", @extMensajeCAT = "", @fld_agruitemcod = 0, @fld_subagruitemcod = ""
      Exec Suc_Valida_Rest_2 3, @fld_cotrut, @fld_bencorrel, @xfecha, @pec_ru
t, @fld_prestacod, @fld_prestacod2, @fld_cant
         , @fld_agruitemcod output, @fld_subagruitemcod output, @fld_especcod output, @fld_gpfns output, @Respuesta output, @extMensajeCAT output
      if @Respuesta = "N"
      begin
         select @extCodEr
ror = "N", @extMensajeError  = substring(@extMensajeCAT,1,30)
    GoTo CGCValorVari_Exit
      end

      if substring(@fld_prestacod2,1,11) = "-066-2-0001"   -- Se asigna IS en base a la canasta que viene en el adicional
         select @is_idn = 6601
  
    else
      begin
         if substring(@fld_prestacod2,1,11) = "-066-2-0002"
            select @is_idn = 6602
         else
         begin
            select @extCodError = "N", @extMensajeError  = "Canasta " + substring(@fld_prestacod2,1,11) + " no 
existe"
    GoTo CGCValorVari_Exit
         end
      end

      if not exists (select 1 from GES_ARANCEL where is_idn = @is_idn and fld_prestacod = @fld_prestacod)
      begin
         select @extCodError = "N", @extMensajeError = convert(varchar(7),@fld
_prestacod) + " no existe en " + convert(varchar(4),@is_idn)
    GoTo CGCValorVari_Exit
      end

      Select @der_idn = der_idn, @der_coptip = der_coptip    -- Derivación vigente, del caso ges vigente
      From GES_DERIVACION
      Where ges_idn      
 = @ges_idn
      and   is_idn        = @is_idn
      and   der_estado    = "E"
      and   @xfecha between der_fecini and der_fecfin
      and   der_insrut      = "079611460-6"
      if @@rowcount = 0
      begin
         select @extCodError = "N", @extM
ensajeError = "GES: No se obtuvo derivación " + convert(varchar(4),@is_idn)
    GoTo CGCValorVari_Exit
      end

      -- cantidad de prestaciones a usar (código + adicional) contra lo que queda disponible en la tabla GEST_TRATAMIENTO_DETALLE

      sele
ct @gest_cod_prest = convert(varchar(20),@fld_prestacod)
      select @fld_prestacod2 = substring(@fld_prestacod2,12,2)    -- pieza dental viene en columna 12, largo 2, relleno con ceros a la izquierda

      Select @gest_cantidad       = isnull(gest_cant
idad,0)
            ,@gest_cantidad_usada = isnull(gest_cantidad_usada,0)
      From GEST_TRATAMIENTO_DETALLE
      Where gest_foliows   = @gest_foliows
      And   gest_cod_prest = @gest_cod_prest
      And   gest_info_adic = @fld_prestacod2
      if @@rowcount = 0
      begin
         select @extCodError = "N", @extMensajeError = convert(varchar(7),@fld_prestacod) + " No existe en Det.Trat."
    GoTo CGCValorVari_Exit
      end

      if @fld_cant + @gest_cantidad_usada > @gest_cantidad
      begin
    
     select @extCodError = "N", @extMensajeError = convert(varchar(7),@fld_prestacod) + " Cantidad > Autorizado"
    GoTo CGCValorVari_Exit
      end

      select @fld_prestaval = 0. , @xinspeccion = 0, @extMensajeCAT = ""    -- Obtener Convenio
      exec AmbObtieneConvenioGes @der_idn, @xfecha, @pec_rut, @ddp_correl, @xRutTratante, @fld_prestacod ,@fld_prestacod2 ,@fld_cant, @fld_prestaval output, @xinspeccion output, @extMensajeCAT output
      if @xinspeccion = 1
      begin
         select @extCodError = "N", @extMensajeError = @extMensajeCAT
    GoTo CGCValorVari_Exit
      end

      select @xcopago = 0, @extInternoIsa = convert(varchar(15),@der_idn)
      if @der_coptip in ("I","P")  -- ojo cuando copago sea en Farmacia no le vamos a cobrar copago
      begin
         -- lo que llevo ocupado de ges hasta el momento
         select @der_deduti = isnull(sum(copago),0) from #codate2 where ges = "S" and interno = @extInternoIsa
         if @@rowcount = 0
            select @der_deduti = 0

         -- calculo copago ges
         select @fld_totcopagoges = 0, @xinspeccion = 0, @extMensajeCAT = ""
         exec amb_ges_calcopagoutili_2 0, @der_idn, @fld_prestaval, @der_deduti, @fld_prestacod, @fld_cant, "N"
                 , @xcopago out
put, @fld_totcopagoges output, @xinspeccion output, @extMensajeCAT output
         if @xinspeccion = 1
         begin
            select @extCodError = "N", @extMensajeError = @extMensajeCAT
    GoTo CGCValorVari_Exit
         end
      end

      select 
@fld_ges = "S" -- la prestacion es GES
      select @xvalor = @fld_prestaval - @xcopago

      GOTO ENLACE  -- donde se unen los procesos libre eleccion y GES
   End

LIBRE_ELEC:   -- acá cae cuando no es GES
   -- Centro psiquiatrico Colmena, tiene un ca
so GES Depresión Vigente y las prestaciones no son las que se venden por i-med --> fuera 
   If @pec_rut = "096852040-7" and @ddp_correl in (4) and
      @fld_prestacod not in (903001, 903002, 903003, 903008, 903009, 913001, 913002, 913008)
   Begin
     
 Select @ges_idn = ges_idn
      From GES_CASO
      Where ges_rutben = @fld_benrut
      and   ps_idn     = 34
      and   ges_estado = "T"
      and   @xfecha between ges_vigini and ges_vigfin
      if @@rowcount != 0
      begin
         --  Busca deri
vacion vigente para el Caso Ges problema de Salud 34
         If exists (select 1 from GES_DERIVACION where ges_idn = @ges_idn and is_idn = 3402 and
                            der_estado in ("E") and @xfecha between der_fecini and der_fecfin)
         be
gin
            select @extCodError = "N", @extMensajeError = "Caso GES S, bono LE en Colmena"
    GoTo CGCValorVari_Exit
         end
         If exists (select 1 from GES_DERIVACION where ges_idn = @ges_idn and is_idn = 3404 and
                        
    der_estado in ("E") and @xfecha between der_fecini and der_fecfin)
         begin
            select @extCodError = "N", @extMensajeError = "Caso GES G, bono LE en Colmena"
    GoTo CGCValorVari_Exit
         end
         If exists (select 1 from GES_
DERIVACION where ges_idn = @ges_idn and is_idn = 3405 and
                            der_estado in ("E") and @xfecha between der_fecini and der_fecfin)
         begin
            select @extCodError = "N", @extMensajeError = "Caso GES B1, bono LE en Colm
ena"
    GoTo CGCValorVari_Exit
         end
         If exists (select 1 from GES_DERIVACION where ges_idn = @ges_idn and is_idn = 3406 and
                            der_estado in ("E") and @xfecha between der_fecini and der_fecfin)
         begin
    
        select @extCodError = "N", @extMensajeError = "Caso GES B2, bono LE en Colmena"
    GoTo CGCValorVari_Exit
         end
         If exists (select 1 from GES_DERIVACION where ges_idn = @ges_idn and is_idn = 3407 and
                            der
_estado in ("E") and @xfecha between der_fecini and der_fecfin)
         begin
            select @extCodError = "N", @extMensajeError = "Caso GES M, bono LE en Colmena"
    GoTo CGCValorVari_Exit
         end
      end
   End

   select @xorigen = 2 -- i
-med
   select @extInternoIsa = "0" -- no tiene folio de derivación
   select @fld_ges = "N"

   If @fld_prestacod in (903001, 903002, 903003, 903008, 903009, 913001, 913002, 913008)  -- Caso Ges Vigente para PS = 34
   begin
      Select @ges_idn = ges_i
dn
      From GES_CASO
      Where ges_rutben = @fld_benrut
      and   ps_idn     = 34
      and   ges_estado = "T"
      and   @xfecha between ges_vigini and ges_vigfin
      If @@rowcount = 0
      Begin
         select @extCodError = "N", @extMensajeE
rror = "Caso Ges Auge No Vigente"
    GoTo CGCValorVari_Exit
      End

      Select @der_idn = der_idn  --  Busca derivacion vigente para el Caso Ges problema de Salud 34 
      From GES_DERIVACION
      Where ges_idn = @ges_idn
      and   is_idn in (34
02, 3404, 3405, 3406, 3407)
      and   der_estado = "E"
      and   @xfecha between der_fecini and der_fecfin
      If @@rowcount = 0
      Begin
         select @extCodError = "N", @extMensajeError = "Derivación Ges Auge No Vigente"
    GoTo CGCValorVar
i_Exit
      End
      select @xorigen = 3  -- GES
      select @extInternoIsa = convert(varchar(15),@der_idn)
      select @fld_ges = "S"
   End


   select @Respuesta = "", @extMensajeCAT = "", @fld_agruitemcod = 0, @fld_subagruitemcod = ""
   Exec Suc_
Valida_Rest_2 @xorigen, @fld_cotrut, @fld_bencorrel, @xfecha, @pec_rut, @fld_prestacod, @fld_prestacod2, @fld_cant
      , @fld_agruitemcod output, @fld_subagruitemcod output, @fld_especcod output, @fld_gpfns output, @Respuesta output, @extMensajeCAT outp
ut
   if @Respuesta = "N"
   begin
      select @extCodError = "N", @extMensajeError  = substring(@extMensajeCAT,1,30)
    GoTo CGCValorVari_Exit
   end

   if @fld_agruitemcod not in (2,3)  -- código duplicado en la tabla temporal, no incluye TP 2 y 3
  
 begin
      if exists (Select 1 From #codate2 Where codigo = @fld_prestacod and codigo2 = @fld_prestacod2)
      begin
         select @extCodError = "N", @extMensajeError = "Prestación Duplicada"
    GoTo CGCValorVari_Exit
      end
   end

   select @f
ld_anestesia = isnull(fld_anestesia,"N") from CDT where fld_prestacod = @fld_prestacod  -- verifico si el código es anestesia
   If @fld_anestesia = "S"
      select @xcodate = @fld_prestacod

   -- Si @fld_valortotal <> 0 y Prestador tiene la marca no va
 abuscar valor convenio y se mueve
   -- el valortotal a fld_prestaval para que entre a la bonif
   select @fld_prestaval = 0.
   If @ddp_reemimed != "S"
   begin
      if @fld_prestacod = 2601701  /* Vacuna anti influenza */
      begin
         if @fld_
cant > 1
         begin
            select @extCodError = "N", @extMensajeError = "Codate sólo permite cant 1"
            GoTo CGCValorVari_Exit
         end
         if @xfecha > "May 31 2013 11:59PM"
         begin
            select @extCodError = "N"
, @extMensajeError = "Codigo fuera de fecha"
            GoTo CGCValorVari_Exit
         end
         select @xcontador = count(*)
         from BON A, BON_CDT B
         where A.fld_benrut = @fld_benrut and A.fld_bonemifec between "Mar 19 2013" and "Jun 
01 2013"
         and   A.fld_bonestado in (1,2,5) and A.fld_bonfolio = B.fld_bonfolio and B.fld_prestacod = 2601701
         if @@rowcount = 0
            select @xcontador = 0

         if @xcontador != 0
         begin
            if DATEDIFF(mm,@fld_b
ennacfec, getdate())/12 > 37  -- dosis adulta: 1 vacuna máxima
            begin
               select @extCodError = "N", @extMensajeError = "Benef ya solicito Prestacion"
               GoTo CGCValorVari_Exit
            end
            else   -- dosis 
para menores:  máximo 2
            begin
               if @xcontador > 1
               begin
                  select @extCodError = "N", @extMensajeError = "Benef uso limite de 2 vacunas"
                  GoTo CGCValorVari_Exit
               end
   
         end
         end
         If @pec_rut = "099582020-K" and @ddp_correl = 5
         begin
            select @fld_prestaval = 4100, @hon_fijo = "S", @hon_valcop = 1990, @amb_costo_cero = "N"
         end
         else
         begin
            se
lect @extCodError = "N", @extMensajeError = "Codigo no valido en este PTD"
            GoTo CGCValorVari_Exit
         end
      end -- fin del if @fld_prestacod = 2601701, control vacuna anti influenza

      else
      begin
         select @xinspeccion
   = 0, @hon_fijo = "N", @hon_valcop = 0, @amb_costo_cero = "N"
         if @fld_inhabil = "S"
            select @rel_tiphorario = "I"
         else
            select @rel_tiphorario = "S"

         exec Sc_Calcula_Convenio_4 @pec_rut, @xRutTratante, @d
dp_correl,@rel_tatencion, @rel_tiphorario, 1, 9, 0
          ,@fld_benrut, @fld_gpfns, @fld_prestacod, @fld_prestacod2, @fld_cant, @xfecha
          ,@fld_prestaval  output, @xinspeccion   output, @extMensajeError  output, @hon_fijo   output
          ,@h
on_valcop     output, @xrel_idn      output,@xrel_tatencion    output, @xrel_tipcon output
          ,@xrel_tventa    output, @xrel_tcliente output, @amb_costo_cero output

         if @xinspeccion = 1 and @fld_anestesia = "N"
         begin
            s
elect @extCodError   = "N"
    GoTo CGCValorVari_Exit
         end
      end
   end
   else
   begin
      select @fld_prestaval = @fld_valortotal, @hon_fijo = "N", @hon_valcop = 0, @amb_costo_cero = "N"
   end

   select @xinspeccion = 0, @xtienerds = "N
", @porcen = 0 -- verifica Pre-existencias
   exec AmbObtCobRds @fld_cotrut, @fld_funfolio, @fld_funcorrel, @fld_bencorrel, @fld_prestacod, @xfecha,
                     @xinspeccion output, @xtienerds output, @porcen output

   if @xinspeccion != 0
   be
gin
      select @extCodError = "N", @extMensajeError = "Prob. RDS con código:" + convert(varchar(07),@fld_prestacod)
    GoTo CGCValorVari_Exit
   end
    
   -- Solo cuando RDS es con cobertura 0 debe ir a la isapre
   if @xtienerds = "S" and @porcen = 
0
   begin
      select @extCodError = "N", @extMensajeError = "Cob.Restringida, ver en Isapre"
    GoTo CGCValorVari_Exit
   end                    

   if @xtienerds = "S" and @porcen != 100 -- tiene preexistencias y su cobertura no es al 100% --> bonif
icación normal
      select @amb_costo_cero = "N"

   If @hon_fijo != "S"  and @amb_costo_cero != "S" -- NO es Copago Fijo ni bono cero --> Calculo bonificado
   Begin
      select @xvalor = 0. , @xinspeccion = 0, @xvalor5 = 0., @fld_rdsporc = 100
    -- 
ojo llamo al cálculo del bonificado con origen 9 (similar a derivación Ambul) para que considere la bonificación por preexistencias
      exec Suc_Calcula_Bonif_8    9, @fld_funfolio, @fld_funcorrel, @fld_planvig, @fld_cntcateg,
           @fld_agruitemco
d, @fld_subagruitemcod, @pec_rut, @ddp_correl, @xRutTratante, @fld_prestacod,
           @fld_prestaval, @fld_cant, @xfecha,  @fld_bencorrel, @fld_rdsporc, @xvalor output, @xinspeccion output,
           @xvalorminfo output ,  @fld_sintopeanual output, @x
tipo_bonif output
      if @xinspeccion = 1
      begin
         select @extCodError = "N", @extMensajeError = "Probl. al Bonificar : " + convert(varchar(07),@fld_prestacod)
    GoTo CGCValorVari_Exit
      end

      if @xvalor > @fld_prestaval -- bonifi
cado mayor al valor de la prestación ==> Error 
      begin
         select @extCodError   = "N", @extMensajeError  = "Problemas al Bonificar (2)"
    GoTo CGCValorVari_Exit
      end
   End
   Else
   Begin
      If @hon_fijo = "S" 
         select @xval
or = 0.
      If @amb_costo_cero = "S"
      begin
         select @xcopago = 0, @xvalor = @fld_prestaval
      end
   End

   If @fld_agruitemcod in (13,18,19) /* Evalua si el Codigo es Preventiva  por casos GES */
   Begin 
      select @xprev = ""
    
  Exec EmpEvaluaPreventiva_2 @fld_prestacod , @fld_cant , @xprev output
      If @xprev = "W"
      Begin
         select @extCodError   = "N", @extMensajeError  = "Prev.: Cantidad Debe ser Uno"
    GoTo CGCValorVari_Exit
      End
      If @xprev = "S"
 
     Begin
         Exec EmpEvaluaTopePreventivo_1 @fld_benrut, @fld_prestacod, @fld_cant, @xfecha,  @xprev output, @mensaje output
         If @xprev = "N"
         Begin
            If substring(@mensaje,1,1) = "1"
            Begin
               selec
t @extCodError   = "N", @extMensajeError  = "Prev: Código Fuera Tramo Edad"
    GoTo CGCValorVari_Exit
            End
            If substring(@mensaje,1,1) in ("2","4")
            Begin
               select @extCodError   = "N", @extMensajeError  = "P
rev: Código ya fue dado"
    GoTo CGCValorVari_Exit
            End
            If substring(@mensaje,1,1) = "3"
            Begin
               select @extCodError   = "N", @extMensajeError  = "Prev: Cantidad Debe ser Uno"
    GoTo CGCValorVari_Exit
   
         End
            If substring(@mensaje,1,1) = "5"
            Begin
               select @extCodError   = "N", @extMensajeError  = "Prev: Restriccion por Sexo"
    GoTo CGCValorVari_Exit
            End
            If substring(@mensaje,1,1) = "6
"
            Begin
               select @extCodError   = "N", @extMensajeError  = "Prev: Excedió cant. atenciones"
    GoTo CGCValorVari_Exit
            End
            If substring(@mensaje,1,1) = "7"
            Begin
               select @extCodErr
or   = "N", @extMensajeError  = "Prev: No corresponde preventiva"
    GoTo CGCValorVari_Exit
            End
         End
      End
   End

   if @xvalor > 0.  -- calcula tope anual; sólo si el bonificado > 0
   begin
      Select @fld_prestamonto = monto
, @fld_prestanum = cantidad  -- cuanto lleva ocupado de los Topes 
      From #topes
      where grupo  = @fld_agruitemcod
      and   sgrupo = @fld_subagruitemcod
      If @@rowcount = 0       -- no hay, asignamos CERO 
      begin
         select @fld_p
restamonto = 0., @fld_prestanum = 0
      end

      select @fld_prestamonto = round(@fld_prestamonto,2)
      Select @fld_numerocorr = 1, @xacumulavalor  = 0
      Select @xvalorunitario = round(@fld_prestaval / @fld_cant,0)
      Select @bonificadouni  
= round(@xvalor / @fld_cant,0)
      Select @xbonificado    = @xvalor

      While (@fld_numerocorr <= @fld_cant)
      Begin
         if @fld_numerocorr = @fld_cant  -- 25-05-2011: la última repeticion ajusta valores por el redondeo a cero, ej 10000/15 =
 666.67
         begin
            select @xvalorunitario = @xvalorunitario + @fld_prestaval - (@xvalorunitario * @fld_cant)
            select @bonificadouni  = @bonificadouni + @xbonificado - (@bonificadouni * @fld_cant)
         end
         Select @xv
alor = @bonificadouni, @xvalorminfo = 0, @xinspeccion = 0
         exec Suc_Calcula_TopAnu_Ord_2   @fld_cotrut, @fld_funfolio, @fld_funcorrel,@fld_bencorrel , @fld_planvig, @fld_cntcateg,
                  @fld_agruitemcod, @fld_subagruitemcod, @xvaloruni
tario, @fld_prestacod, 1, @xfecha, @fld_prestamonto,
                  @fld_prestanum, @xprestamonto, @fld_sintopeanual, @xsuperatopepresta , @xvalortopeprest,
                  @xvalor output, @xvalorminfo output, @xinspeccion output
         if @xinspec
cion != 0
         begin
            select @extCodError   = "N", @extMensajeError  = "Problema en Tope Anual " + convert(varchar(07),@fld_prestacod)
    GoTo CGCValorVari_Exit
         end
         Select @fld_prestamonto = @fld_prestamonto + round(@xval
or/@xvalor_uf,2)
         Select @xprestamonto    = @xprestamonto + round(@xvalor/@xvalor_uf,2)
         select @fld_prestanum   = @fld_prestanum + 1
         select @xacumulavalor   = @xacumulavalor + @xvalor
         select @fld_numerocorr  = @fld_numer
ocorr + 1
      End  -- fin de while

      select @xvalor = @xacumulavalor   --  tengo el nuevo bonificado 
   end
   Else -- calcula bonificado segun copago fijo
      select @xvalor = round((@fld_prestaval - @hon_valcop),0)

ENLACE:
   select @xcopago 
= round((@fld_prestaval - @xvalor),0)    -- como el bonificado puede variar después del tope anual, se recalcula copago
   -- Valida la Cobertura Financiera Adicional 
   If @der_idn != 0 and @ges_idn != 0
   Begin
      select @fld_cfages = 0
      EXEC 
GesCasoDedBon 2, 1, @der_idn, @xfecha, @xcopago, 0, @fld_cfages output
      If @fld_cfages != 0  -- tiene cobertura financiera adicional, se deben recalcular
      Begin
         select @xcopago = @xcopago - @fld_cfages
         select @xvalor = @fld_pre
staval - @xcopago
      End
   End
   Else
      select @fld_cfages = 0

   if @xvalor > @fld_prestaval
   Begin
      select @extCodError = "N", @extMensajeError = "Error: Bonif > Valor Convenio"
    GoTo CGCValorVari_Exit
   End
  
   insert into #codat
e2  -- guardo los códigos
   (codigo        , codigo2        , convenido     , bonificado, copago  ,  ges     ,  cfa_ges  ,  interno)
   values
   (@fld_prestacod, @fld_prestacod2, @fld_prestaval, @xvalor   , @xcopago, @fld_ges , @fld_cfages  , @extIntern
oIsa)

   If @der_idn = 0 and @ges_idn = 0    -- Actualizo los topes locales sólo si no es GES
   Begin
     update #topes
     Set     monto    = monto     + round(@xvalor/@xvalor_uf,2)
            ,cantidad = cantidad  + @fld_cant
     Where  grupo  = @
fld_agruitemcod
     AND    sgrupo = @fld_subagruitemcod
     if @@rowcount = 0
     begin
        insert into #topes
        (grupo           , sgrupo             , monto                      , cantidad)
        values
        (@fld_agruitemcod, @fld_sub
agruitemcod, round(@xvalor/@xvalor_uf,2), @fld_cant)
        if @@rowcount = 0
        begin
           select @extCodError   = "N", @extMensajeError  = "Problemas al insertar #topes"
    GoTo CGCValorVari_Exit
        end
     end

     -- actualizo el m
onto usado por el beneficiario en el PAN
     select @xprestamonto = @xprestamonto + round(@xvalor/@xvalor_uf,2)
   End

   if @fld_anestesia = "S"  -- anestesia
      select @xconta_anes = 1

   if @fld_agruitemcod = 1 -- consultas
      select @xconta_c
ons = @xconta_cons + 1

   if @fld_agruitemcod = 5 -- honorarios
      select @xconta_hon  = @xconta_hon  + 1

   select @xi = @xi + 1, @xj = @xj + 1 -- posición en la lista y q de prestaciones 
   
   if @xi = 5          -- 5 prestaciones por lista 
   b
egin
      if @xlista = "A"
      begin
         select @xlista = "B", @xListaPrestac   = @extLista2
      end
      else
      begin
         if @xlista = "B"
         begin
            select @xlista = "C", @xListaPrestac   = @extLista3
         end
   
      else
         begin
            if @xlista = "C"
            begin
               select @xlista = "D", @xListaPrestac   = @extLista4
            end
            else
            begin
               if @xlista = "D"
               begin
           
       select @xlista = "E", @xListaPrestac   = @extLista5
               end
               else
               begin
                  if @xlista = "E"
                  begin
                     select @xlista = "F", @xListaPrestac   = @extLista6
    
              end
                  else
                     select @xfin = 1
               end
            end
         end
      end
      select @xi  = 0
   end
 
   -- siguiente prestación, cantidad, etc.
   select @fld_prestacod  = isnull(convert(i
nt,substring(@xListaPrestac,(@xi*48+1),10)),0)
   select @fld_prestacod2 = substring(@xListaPrestac,(@xi*48+15),15)
   select @fld_inhabil    = substring(@xListaPrestac,(@xi*48+31),1)
   select @fld_cant       = isnull(convert(tinyint,substring(@xListaPre
stac,(@xi*48+33),2)),0)
   select @fld_valortotal = isnull(convert(int,substring(@xListaPrestac,(@xi*48+36),12)),0)

End -- While

if @xj != @extNumPrestaciones
begin
   select @extCodError     = "N", @extMensajeError = "No coincide total Prestaciones"
  
  GoTo CGCValorVari_Exit
end

-- por qué no se puede dar más de una consulta? por que Orden separa los bonos por Grupo - subgrupo fonasa, y eso haría que
-- en un bono hubieran dos consultas, lo que para nosotros es inadmisible y resulta ilógico para el p
restador por el tema de los rut asociados
if @xconta_cons > 1
begin
   select @extCodError = "N", @extMensajeError = "Demasiadas Consultas"
    GoTo CGCValorVari_Exit
end

if @xconta_anes = 1
begin
   if @xj != 2
   begin
      select @extCodError   = "N"
, @extMensajeError  = "Anestesia exije 2 Prestaciones"
    GoTo CGCValorVari_Exit
   end
   if @xconta_hon != 2
   begin
      select @extCodError   = "N", @extMensajeError  = "Anestesia exije 2 Prestaciones"
    GoTo CGCValorVari_Exit
   end

   -- anest
esia es 10% del convenido y bonificado del otro código
   Select @fld_prestaval = convenido, @xvalor = bonificado
   From #codate2
   Where codigo != @xcodate /* obtengo valores del codigo que no es anestesia */

   select @fld_prestaval = round(@fld_pres
taval/10.,0) /* valor convenido al 10% */
   select @xvalor        = round(@xvalor/10.,0) /* valor bonificado al 10% */
   select @xcopago       = @fld_prestaval - @xvalor
   if @xcopago < 0.
      select @xcopago = 0.

   Update #codate2       /* actuali
zo valores */
   Set convenido  = @fld_prestaval
      ,bonificado = @xvalor
      ,copago     = @xcopago
   Where codigo = @xcodate
end

-- se debe rebajar el copago calculado de GES
if @der_idn != 0
begin
   select @xcopago    = sum(isnull(copago,0))
  
       ,@fld_cfages = sum(isnull(cfa_ges,0))
   from #codate2
   where ges = "S"

   EXEC GesCasoDedBon 1, 1, @der_idn, @xfecha, @xcopago, @fld_cfages, 0
end

-- si después de todo este chorizo, aún llega por acá, indica que está OK 
select @extCodError =
 "S", @extGlosa1   = "", @extGlosa2   = "", @extGlosa3   = "", @extGlosa4   = "", @extGlosa5   = ""

--  Retorno de Valores
Select extValorPrestacion   = convenido
         ,extAporteFinanciador = bonificado
         ,extCopago            = copago
       
  ,extInternoIsa        = interno
         ,extTipoBonif1        = case
                when interno = "0" then 0
                else                    77
                end
         ,extCopago1           = cfa_ges
         ,extTipoBonif2        = 0
  
       ,extCopago2           = 0
         ,extTipoBonif3        = 0
         ,extCopago3           = 0
         ,extTipobonif4        = 0
         ,extCopago4           = 0
         ,extTipoBonif5        = 0
         ,extCopago5           = 0
From #codate
2
/*-----------------------------------------------------------------*/
/*------------------------- End User Code -------------------------*/
/*-----------------------------------------------------------------*/

CGCValorVari_Exit:
    If @SRV_ReturnStatu
s >= 60000
    Begin
        Return 0
    End
    Else Begin
        Return 1
    End
End
                                                                                                                                                                     
(167 rows affected)
(return status = 0)
1> 
