locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
200
(1 row affected)
text

   
create procedure dbo.INGEnvBonIs 
( 
 @extCodFinanciador     smallint, 
 @extHomNumeroConvenio  char(15), 
 @extHomLugarConvenio   char(10), 
 @extSucVenta           char(10), 
 @extRutConvenio        char(12), 
 @extRutAsociado        char(12), 
 @extNomPrestador       char(40), 
 @extRutTratante        char(12), 
 @extEspecialidad			char(10), -- FR-16877
 @extRutBeneficiario    char(12), 
 @extRutCotizante       char(12), 
 @extRutAcompanante     char(12), 
 @extRutEmisor          char(12), 
 @extRutCajero          char(12), 
 @extCodigoDiagnostico  char(10), 
 @extDescuentoxPlanilla char(1), 
 @extMontoExcedente     numeric(10), 
 @extFechaEmision       datetime, 
 @extNivelConvenio      tinyint, 
 @extFolioFinanciador   numeric(10), 
 @extMontoValorTotal    numeric(10), 
 @extMontoAporteTotal   numeric(10), 
 @extMontoCopagoTotal   numeric(10), 
 @extNumOperacion       numeric(10), 
 @extCorrPrestacion     numeric(10), 
 @extTipoSolicitud      tinyint, 
 @extFechaInicio        datetime, 
 @extUrgencia           char(1), 
 @extPlan               char(15), 
 @extLista1 				char(255), 
 @extLista2             char(255), 
 @extLista3             char(255), 
 @extCodError           char(1)  output, 
 @extMensajeError       char(30) output 
) 
/* 
--- 
*** ----------------------------------------------------------------------------- 
Modificado el :   Diciembre de 2006 
Modificado por:   Marcelo Herrera 
Referencia    :   FR - 16035, se corrige registro de Rut 0 para medico tratante, 
                  
error en uso en variables. 
--- *** ----------------------------------------------------------------------------- 
Modificado el :   Enero de 2007 
Modificado por:   Marcelo Herrera 
Referencia    :   FR - 17023, se verifica existencia de Medico en tabla 
Prestador, si 
                  no existe se registrara Bono con Rut de Prestador (ello por cuanto 
                  venta fue validada por proceso en SP INGCopTran 
--- *** ----------------------------------------------------------------------------- 

Modificado el :   Marzo de 2007 
Modificado por:   Marcelo Herrera 
Referencia    :   FR - 19057, 
                  Se incluye se movimiento de Excedente 
--- *** ----------------------------------------------------------------------------- 
Modificado e
l :   Diciembre de 2007
Modificado por:   yanislav Esteban Pletikosic Roajs
Referencia    :   FR - 16877, se implementa @extLista3
--- *** ----------------------------------------------------------------------------- 
Modificado el :   Febrero de 2008
Mod
ificado por:   Felipe A. Quiroz 
Referencia    :   FR - 28369, 
                  Actualización de servicios IMED (corrección largo variables)
--- *** ----------------------------------------------------------------------------- 
Modificado el :   Marzo d
e 2010
Modificado por:   Marcelo Herrera 
Referencia    :   FR - 1592, Proyecto Beneficios, Subproyecto Convenios
                  Manejo del Rut Facturador del convenio y cambios de referencia de tablas
                  segun nuevo modelo de convenios.
 
--- *** ----------------------------------------------------------------------------- 
Modificado el :   Diciembre de 2011
Modificado por:   Marcelo Herrera 
Referencia    :   FR - 3978, modificaciones para manejo de bonos GES: manejo de la canasta,
   
               determinacion de folio de evento, imputacion de gasto GES. 
--- *** ----------------------------------------------------------------------------- 
Modificado el :   Diciembre de 2012
Modificado por:   Marcelo Herrera 
Referencia    :   FR -
 7110, se elimina recuperacion de valor a Rendir, ya no se informara. 
--- *** ----------------------------------------------------------------------------- 

   procedimiento : INGEnvBono 
   Autor         : Cristian Rivas Rivera. 
 
   Parametros I 
   @extCodFinanciador  : Código del Financiador 
 
   Parametros O 
       @extCodError           : Código de Error ('S','N') 
                                S = estador exitoso de la transaccion 
                                N = fallo o error en transaccion 
       @extMensajeError    : Mensaje de Error. 
 
   ------------------------ 
   |Servicios para C-Salud | 
   ------------------------ 
 
   Descripción 
   Envia Bonos Uno por uno al financiador para su registro. 
 
   ejemplo de llamada: -- 2 prestaciones GES
 declare 
  @extCodError           char(1), 
  @extMensajeError  char(30) 
 
 exec prestacion..INGEnvBonIs 078,'45940-0','75600','130600','0096942400-2','0000000000-0','Integramedica', '0000000000-0','','0004684532-3', '0003588817-9','00000000000-0','0000000000-0', '0011316248-1', '','N',0000000000,'20110930',0,986290576, 000009020,0000004270,0000004750,0000000001,0000000001,1,'20110930','','ICS010606B', '0302034000|0 |*G*-021-2-0003 |N|01|006940|0004270|0002670|104GES MB006940|0|0000000|0|0000000|0|0000000|0|0000000|0|0000000|0309022000|0 |*G*-021-2-0003 |N|01|002080|0000000|0002080|104GES MB000000|0|0000000|0|0000000|0|0000000|0|0000000|0|0000000|', '', '', @extCodError ou tput, @extMensajeError output 

*/ 
As 
BEGIN

declare @Marca         marca, 
         @ErrorCode      int, 
         @NroContrato    contrato, 
         @cor_car        regla, 
         @BonFolDoc_id   int, 
         @BonFolAnt_cr   char(12), 
         @BonRutCot_ta   rut, 
         @BonDigCot_ta   dv, 
         @BonDirCon_ta   int, 
         @BonCodPae_ta   int, 
         @BonEspMed_ta   char(3), 
         @BonNumCol_ta   int, 
         @BonVerCon_ta   char(5), 
         @BonRutMed_ta   rut, 
         @BonDigMed_cr   dv, 
         @BonRutPre_ta   rut, 
         @BonDigPre_cr   dv, 
         @BonTotPre_$$   int, 
         @BonTotBon_$$   int, 
         @BonSucBon_ta   sucursal, 
         @BonDepCaj_ta   depto, 
         @BonCodCaj_ta   char(2), 
         @BonHosCaj_ta   host, 
         @BonLogAdm_ta   login, 
         @BonHosAdm_ta   host, 
         @BonLogAut_ta   login, 
         @BonRutRet_nn   rut, 
         @BonDigRet_cr   dv, 
         @BonEstDoc_re   regla, 
         @BonRecCop_re   regla, 
       	@BonComCon_nn   int, 
         @BonRenPag_nn   int, 
         @BonTipBon_re   regla, 
         @BonOriAte_re   regla, 
         @BonCcoOpe_ta   char(10), 
         @BonCcoVta_ta   char(10), 
         @BonCcoCom_ta   char(10), 
         @BonRutMca_ta   rut, 
         @BonDigMca_cr   dv, 
         @BonTotRen_$$   int, 
         @BonFecDev_fc   fecha, 
         @BonSucDev_ta   sucursal, 
         @BonLogDev_ta   login, 
         @BonFecRen_fc   fecha, 
         @BonComDev_nn   int, 
         @BonFecMan_fc fecha, 
         @BonCodNom_ta   smallint, 
         @extListaAUX    char(255), 
         @varTemp        char(160), ---- FR-28369
         @ct_pipe        int, 
         @tot_Pre        int, 
         @tot_Bon        int, 
         @tot_Cop        int,
 
         @MinCorr        tinyint, 
         @MaxCorr        tinyint, 
         --// DETALLE DE BONOS 
         @DboFolDoc_id    int, 
         @DboMarBon_id    marca, 
         @DboCorBon_id    tinyint, 
         @DboGruCob_id    char(4), 
         @DboCodPre_ta    prestacion, 
         @DboCodIte_ta    tinyint, 
         @DboModCob_ta    char(4), 
         @DboCanAte_nn    tinyint, 
         @DboTipAte_re    regla, 
         @DboMonPre_$$    int, 
         @DboMonBon_$$    int, 
         @DboPorBon_nn numeric(5, 2), 
         @DboTipCal_re    regla, 
         @DboPorRec_nn    tinyint, 
         @DboValRen_$$    int, 
         @DboMtoOcr_$$  int, 
         @BorraCabeDeta   bit, 
         @Prestacion      prestacion, 
         @Item            tinyint, 
         @Tipo            char(2), 
         @Recargo         char(1), 
         @Cantidad        tinyint, 
         @Val_Pre         int, 
         @RutTra          rut, 
         @RutSol   rut, 
         @Val_Bon         int, 
         @Val_Cop      int, 
         @GrupoCob        char(4), 
         @ModalidadCon    char(4), 
         @TipoCalculo     regla, 
         @Homologo        char(20), 
         @InternoIsapre char(15), 
         @RutBen          rut, 
         @Hoy             fecha, 
  	@Val_Rendicion   int, 
         @RutCon          int, 
         @RutMed_ta       int, 
         @DigMed_cr       dv, 
         @CodSucursal     sucursal, 
         @HoyEllos        fecha, 
         @HoyHora         fecha, 
         @CodCataPrest   prestacion, 
         @AccionPresta    regla, 
         @Sw_Fecha        bit, 
         @HoyMasUno       fecha, 
         @Ok              flag, 
         @Folio           int -- monto excedente FR 13565 ,
	@MtoExcedente   int ,
	@PrestadorFacturador int ,
	@PrestadorEmisor     int ,
	@DigFacturador char(1)
 
 Declare -- para imputar gasto GES
    @EsGES          int
   ,@vliFolEve      int
   ,@vliCorMov      int
   ,@vliNumPro      tinyint
   ,@vlcCodEta      char(2)
   ,@vlcPerUso      char(2)
   ,@vlcCodCar      char(20)
   ,@vliCorRen      tinyint
   ,@vlcTipMov      char(2)
   ,@vlcTipDoc      char(2)
   ,@vliFolBon      int
   ,@vlcMarBon      marca
   ,@vldFecDoc      fecha
   ,@vliMtoGas      int
   ,@vliMtoBon      int
   ,@vliMtoCop      int
   ,@vliMtoNoc      int
   ,@vlnCopUf       numeric(8,2)
   ,@vlnMtoDed      numeric(8,2)
   ,@vlnMtoSeg      numeric(8,2)
   ,@vldFecCal      fecha
   ,@vlnValUF       numeric(8,2)
   ,@vlcLogIng      char(10)
   ,@vldFecIng      fecha
   ,@vlcSucIng      sucursal
   ,@vliFolPar      int
   ,@vliCorDoc      tinyint
   ,@vliCorAgr      tinyint
   ,@vliCorPre      tinyint
   ,@vlcGloObs      descripcion
   ,@vliFolRee      int
   ,@vlcMarRee      marca
   ,@vliMtoTot 	    int
   ,@vldFecHas      fecha
   ,@vliQxGES       int 
   ,@CadenaGES      char(20), @CadenaAux char(20), @CanastaHom char(20)
   ,@MinBonFon      int
 
Declare @DboMinFon_nn int, @DboCodHom_cr char(20)
Declare @vliEsDentalCapitado int

 begin tran 
  update ContadorFolio 
     set    CfoNumFol_nn = CfoNumFol_nn - 1 
     where  CfoCodMar_id = 'IN' 
     And    CfoTipDoc_fl = 'LEEB' 
 
     select @Folio = CfoNumFol_nn 
     from   ContadorFolio 
     where  CfoCodMar_id = 'IN' 
     and    CfoTipDoc_fl = 'LEEB' 
 
   commit tran 
 
  begin tran uno 
 
  insert prestacion..Log_EntradasEnvBono 
         (Log_NroTrx, LogFechaHoraTRX, LogCodFinanciador, LogHomNumeroConvenio, LogHomLugarConvenio, 
          LogSucVenta, LogRutConvenio, LogRutAsociado, LogNomPrestador, LogRutTratante, 
          LogRutBeneficiario, LogRutCotizante, LogRutAcompanante, LogRutEmisor, LogRutCajero, 
          LogCodigoDiagnostico, LogDescuentoxPlanilla, LogMontoExcedente, LogFechaEmision, 
          LogNivelConvenio, LogFolio Financiador, LogMontoValorTotal, LogMontoAporteTotal, 
          LogMontoCopagoTotal, LogNumOperacion, LogCorrPrestacion, LogTipoSolicitud, 
          LogFechaInicio, LogUrgencia, LogPlan, LogLista1, LogLista2) 
 values  (@Folio, getdate(), @extCodFinanciador, @extHomNumeroConvenio, @extHomLugarConvenio, 
          @extSucVenta, @extRutConvenio, @extRutAsociado, @extNomPrestador, @extRutTratante, 
          @extRutBeneficiario, @extRutCotizante, @extRutAcompanante, @extRutEmisor, @extRutCajero, 
         @extCodigoDiagnostico, @extDescuentoxPlanilla, @extMontoExcedente, @extFechaEmision, 
          @extNivelConvenio, @extFolioFinanciador, @extMontoValorTotal, @extMontoAporteTotal, 
          @extMontoCopagoTotal, @extNumOperacion, @extCorrPrestacion, @extTipoSolicitud, 
          @extFechaInicio, @extUrgencia, @extPlan, @extLista1, @extLista2) 
 
  if @@error != 0 
   begin 
    rollback tran uno 
    Select @extCodError = 'N' 
    Select @extMensajeError = 'TRX DENEGADA (EI:400365)' 
    --//Select @ext MensajeError = 'TRX DENEGADA (EI:400365)' 
    return 1 
   end 
 
  commit tran uno 
 
 --//// 
 
 Select @Hoy       = convert(smalldatetime,convert(char(10),getdate(),101)) 
 Select @HoyEllos  = convert(smalldatetime,convert(char(10),@extFechaEmision,101)) 
 Select @HoyHora   = getdate() 
 Select @HoyMasUno = dateadd(dd,1,@HoyEllos) 
 Set @EsGES = 0
 Set @vliEsDentalCapitado = 0
 
 --// Control de Fecha de Emision del Bono 
 --// 1 : Habilite Control 
 --// 0 : No realize Control 
 Select @Sw_Fecha = 1 

 exec @ErrorCode = prestacion..INGSwitch_FechaEmision @Sw_Fecha output 
 if @@error != 0 Select @Sw_Fecha = 1 
 
 if @Sw_Fecha = 1 
  begin 
   if @Hoy <> @HoyEllos 
    begin 
     Select @extCodError = 'N' 
     Select @extMensajeError = 'TRX DENEGADA 
(EO:400374)' 
     return 1 --// Intenta grabar un bono con fecha de emision distinta al día de hoy. 
    end 
  end 
 
 Select @CodSucursal = convert(char(6),ltrim(rtrim(@extSucVenta))) 
 
 Select @BonSucBon_ta = @CodSucursal 
 
 create table #Cadenas 
 
( 
  Indice    numeric(10,0) Identity, 
  Cadena char(160)      not null,  ---- FR-28369
  Procesado int               null 
 ) 
 
 --// Interprete de Lista basado en posición de pipes y no por largo fijo. 
 Select @extListaAUX = @extLista1 
 while char_l
ength(ltrim(rtrim(@extListaAUX))) > 30 
  begin 
   Select @varTemp = '' 
   Select @ct_pipe = 1 
   while @ct_pipe <= 19 
    begin 
     Select @varTemp = ltrim(rtrim(@varTemp)) + substring(@extListaAUX,1,charindex('|',@extListaAUX)) 
     Select @extLi
staAUX = substring(@extListaAUX,charindex('|',@extListaAUX)+1,char_length(@extListaAUX)) 
     Select @ct_pipe = @ct_pipe + 1 
    end 
   insert #Cadenas Select @varTemp, NULL 
  end 
 
 Select @extListaAUX = @extLista2 
 while char_length(ltrim(rtrim(@e
xtListaAUX))) > 30 
  begin 
   Select @varTemp = '' 
   Select @ct_pipe = 1 
   while @ct_pipe <= 19 
    begin 
     Select @varTemp = ltrim(rtrim(@varTemp)) + substring(@extListaAUX,1,charindex('|',@extListaAUX)) 
     Select @extListaAUX = substring(@
extListaAUX,charindex('|',@extListaAUX)+1,char_length(@extListaAUX)) 
     Select @ct_pipe = @ct_pipe + 1 
    end 
   insert #Cadenas Select @varTemp, NULL 
  end 

 Select @extListaAUX = @extLista3
 while char_length(ltrim(rtrim(@extListaAUX))) > 30 
  
begin 
   Select @varTemp = '' 
   Select @ct_pipe = 1 
   while @ct_pipe <= 19 
    begin 
     Select @varTemp = ltrim(rtrim(@varTemp)) + substring(@extListaAUX,1,charindex('|',@extListaAUX)) 
     Select @extListaAUX = substring(@extListaAUX,charindex(
'|',@extListaAUX)+1,char_length(@extListaAUX)) 
     Select @ct_pipe = @ct_pipe + 1 
    end 
   insert #Cadenas Select @varTemp, NULL 
  end 
 
 --// Al finalizar la interpretación se tendra un tabla con cada línea de prestaciones diferenciada. 
 --// en
 el siguiente paso, el string será descompuesto en sus partes integrantes, y dejado en la tabla 
 --// #DetallePrestaciones 
 
 create table #DetallePrestaciones 
 ( 
  Correlativo  numeric(9,0) identity, 
  Prestacion   prestacion, 
  Item         tinyin
t, 
  Tipo         char(2), 
  Homologo     char(15) NULL, 
  Recargo      char(1), 
  Cantidad  tinyint, 
  Val_Pre      int, 
  Val_Bon      int, 
  Val_Cop      int, 
  Val_Rend     int      null, 
  GrupoCob     char(4)  null, 
  ModalidadCon char(4) 
 null, 
  TipoCalculo  regla    null,
  MinBonFon    int      null
 ) 
 
 create table #ListaCanastasGES
 (
  NumPro  int,
  CodEta  char(2),
  CodCar  char(20),
  CorRen  int     null,
  PerUso  char(2) null
 )
 
 while exists(select 1 from #Cadenas wher
e Procesado is null) 
  begin 
 
   set rowcount 1 
 
   Select @varTemp = Cadena 
   from   #Cadenas where  Procesado is null 
   order by Indice 
 
   Select @Prestacion    = substring(substring(@varTemp,1,charindex('|',@varTemp)-1),1,7) 
   Select @Ite
m          = convert(tinyint,substring(substring(@varTemp,1,charindex('|',@varTemp)-1),8,3)) 
   Select @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp)) 
 
   Select @Tipo          = substring(@varTemp,1,charindex('|',@
varTemp)-1) 
   Select @varTemp   = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp)) 
 
   Select @Homologo      = ltrim(rtrim(substring(@varTemp,1,charindex('|',@varTemp)-1))) 
   Select @varTemp    = substring(@varTemp,charindex('|',@
varTemp)+1,char_length(@varTemp)) 
   if char_length(ltrim(rtrim(@Homologo))) <= 1 Select @Homologo = NULL 
 
   Select @Recargo       = substring(@varTemp,1,charindex('|',@varTemp)-1) 
   Select @varTemp       = substring(@varTemp,charindex('|',@varTemp)
+1,char_length(@varTemp)) 
 
   Select @Cantidad      = convert(tinyint,substring(@varTemp,1,charindex('|',@varTemp)-1)) 
   Select @varTemp    = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp)) 
 
   Select @Val_Pre       = convert(int
,substring(@varTemp,1,charindex('|',@varTemp)-1)) 
   Select @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp)) 
 
   Select @Val_Bon       = convert(int,substring(@varTemp,1,charindex('|',@varTemp)-1)) 
   Select @varTem
p       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp)) 
 
   Select @Val_Cop       = convert(int,substring(@varTemp,1,charindex('|',@varTemp)-1)) 
   Select @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@
varTemp)) 
 
   Select @InternoIsapre = NULL 
   Select @GrupoCob      = NULL 
   Select @ModalidadCon  = NULL 
   Select @TipoCalculo   = NULL 
   Select @Val_Rendicion = NULL 
 
   --//if char_length(ltrim(rtrim(substring(@varTemp,1,charindex('|',@varTe
mp)-1)))) = 1 
   --//if char_length(ltrim(rtrim(substring(@varTemp,1,15)))) = 1 
   --// begin 
 
   Select @InternoIsapre = substring(@varTemp,1,15) --charindex('|',@varTemp)-1) 
     Select @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,
char_length(@varTemp)) 
 
     Select @GrupoCob      = substring(@InternoIsapre,1,3) 
     Select @ModalidadCon  = substring(@InternoIsapre,4,4) 
     Select @TipoCalculo   = substring(@InternoIsapre,8,2) 

     -- FR 7110 obsoleto.... ultimos 6 digitos q
uedan libres para futuro uso
     if @GrupoCob = '492'
     begin
       Set @Val_Rendicion = 0
       Set @vliEsDentalCapitado = 1
     end
     else
       Set @Val_Rendicion = @Val_Pre
 
   --//end 
 
   if @InternoIsapre is NULL 
    begin 
     Selec
t @extCodError = 'N' 
     Select @extMensajeError = 'TRX DENEGADA (EI:400320)' 
    --//Select @extMensajeError = 'TRX DENEGADA (EI:400320)' 
     return 1 --//No Se Centro de Costo Operativo 
    end 
 
   update #Cadenas set Procesado = 1 where Procesa
do is null 
 
   set rowcount 0 
   
   --identificar la canasta o lista de canastas (se puede optimizar una vez se confirme valor recibir).
   if (@GrupoCob = '104' and @vliNumPro is Null)
   begin
      set @EsGES = 1
      
         set @CadenaGES = su
bString(@Homologo, 5, char_length(@Homologo))
         set @CadenaAux = subString(@CadenaGES, 1, charindex('-',ltrim(rtrim(@CadenaGES)))-1)
         --Patologia         
         set @CanastaHom = Ltrim(Rtrim(convert(char(15), convert(int, @CadenaAux))))

         
         set @CadenaGES = subString(@CadenaGES, charindex('-',@CadenaGES)+1, char_length(@CadenaGES))
         --Etapa
         set @CanastaHom = RTRim(RTrim(@CanastaHom)) + CASE left(@CadenaGES, 1)
                                             w
hen '1' then 'D'
                                             when '2' then 'T'
                                             when '3' then 'S'
                                         else 'x' --nos e encontrara
                                         en
d
         set @CadenaGES = subString(@CadenaGES, charindex('-',@CadenaGES)+1, char_length(@CadenaGES))
         --secuencia canasta
         set @CanastaHom = LTrim(RTrim(@CanastaHom)) + Ltrim(Rtrim(convert(char(15),convert(int,@CadenaGES)) ))

      
  
    if exists (select 1 from prestacion..GES_GrupoProblema where GprCodCar_id = @CanastaHom)
      begin
         Select @vlcCodCar = GprCodCar_id
               ,@vliNumPro = GprNumPro_id
               ,@vlcCodEta = GprCodEta_id
         from prestacion
..GES_GrupoProblema
         where GprCodCar_id = @CanastaHom
         
         select @vliCorRen = AgrCorRen_id
               ,@vlcPerUso = AgrPerUso_id
         from prestacion..GES_ArancelGrupo
         where AgrNumPro_id = @vliNumPro
           and 
AgrCodEta_id = @vlcCodEta
           and AgrCodCar_id = @vlcCodCar
           and AgrVigDes_fc >= @HoyEllos
           and isNull(AgrVigHas_fc, @HoyMasUno) <= @HoyEllos
           
         if @@rowcount = 0
            select top 1
                   @vl
iCorRen = AgrCorRen_id
                  ,@vlcPerUso = AgrPerUso_id
            from prestacion..GES_ArancelGrupo
            where AgrNumPro_id = @vliNumPro
              and AgrCodEta_id = @vlcCodEta
              and AgrCodCar_id = @vlcCodCar
         
   order by AgrCorRen_id desc
            
         if (@vliNumPro is Not Null and  @vlcCodEta is not Null and @vlcCodCar is Not Null and @vliCorRen is not null and  @vlcPerUso is not null)
             Insert into #ListaCanastasGES (NumPro, CodEta, CodCa
r, CorRen, PerUso)
             Select @vliNumPro, @vlcCodEta, @vlcCodCar, @vliCorRen, @vlcPerUso
      end
      else
      if exists (select 1 from prestacion..GES_GrupoProblema where GprCodIme_cr = @CanastaHom)
      begin
         insert into #ListaCa
nastasGES (NumPro, CodEta, CodCar, CorRen, PerUso)
         Select GprNumPro_id, GprCodEta_id, GprCodCar_id, AgrCorRen_id, AgrPerUso_id
         from prestacion..GES_GrupoProblema, prestacion..GES_ArancelGrupo
         where GprCodIme_cr = @CanastaHom
   
        and AgrNumPro_id = GprNumPro_id
           and AgrCodEta_id = GprCodEta_id
           and AgrCodCar_id = GprCodCar_id
           and AgrVigDes_fc >= @HoyEllos
           and isNull(AgrVigHas_fc, @HoyMasUno) <= @HoyEllos
         
         if @@row
count = 0
         begin
            insert into #ListaCanastasGES (NumPro, CodEta, CodCar, CorRen, PerUso)
            Select GprNumPro_id, GprCodEta_id, GprCodCar_id, max(AgrCorRen_id), null
            from prestacion..GES_GrupoProblema, prestacion..GE
S_ArancelGrupo
            where GprCodIme_cr = @CanastaHom
              and AgrNumPro_id = GprNumPro_id
              and AgrCodEta_id = GprCodEta_id
              and AgrCodCar_id = GprCodCar_id
            group by GprNumPro_id, GprCodEta_id, GprCodCa
r_id
            
            update #ListaCanastasGES  
            set PerUso = AgrPerUso_id
            from prestacion..GES_ArancelGrupo
            where AgrNumPro_id = NumPro
              and AgrCodEta_id = CodEta
              and AgrCodCar_id = C
odCar
              and AgrCorRen_id = CorRen
         end    
         Set @vliNumPro = 0
      end
      else
          set @vliNumPro = 0
   end
   
   exec BON_GetMinimoFonasa @Prestacion, @Item, @HoyEllos, @MinBonFon out
   
   insert #DetallePrestac
iones 
         (Prestacion, Item, Tipo, Homologo, Recargo, Cantidad, Val_Pre, Val_Bon, 
          Val_Cop, GrupoCob, ModalidadCon, TipoCalculo, MinBonFon, Val_Rend) 
   values (@Prestacion, @Item, @Tipo, @Homologo, @Recargo, @Cantidad, @Val_Pre, @Val_Bon
, 
           @Val_Cop, @GrupoCob, @ModalidadCon, @TipoCalculo, @MinBonFon, @Val_Rendicion) 
 
 end 
 
 Select @tot_Pre = sum(Val_Pre) From #DetallePrestaciones 
 Select @tot_Bon = sum(Val_Bon) From #DetallePrestaciones 
 Select @tot_Cop = sum(Val_Cop) Fr
om #DetallePrestaciones 
 
 --// Obtención de los datos de contrato del beneficiario. 
 Select @RutBen = convert(int,substring(ltrim(rtrim(@extRutBeneficiario)),1,charindex('-',ltrim(rtrim(@extRutBeneficiario)))-1)) 
 
 exec   @ErrorCode = prestacion..ING
SelConMar @RutBen, @HoyEllos, @HoyMasUno, 
                                              @Marca output, 
                                              @NroContrato output, 
                                              @Ok output 
 if @Ok = 'N' or @ErrorC
ode != 0 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'TRX DENEGADA (EI:400382)' 
   Select @Marca = 'XX' 
   return 1 
  end 
 
 Select @cor_car     = BenCorCar_id 
 from   contrato..Beneficiario 
 where  BenRutBen_nn = @RutBen 
 
  and  BenNumCto_id = @NroContrato 
   and  BenMarCon_id = @Marca 
   and  BenIniVig_fc <= @HoyEllos 
   and  BenTerVig_fc >= @HoyEllos 
 
 --// Los Bonos del Día serán grabados con Hora. 
 if @Hoy = @HoyEllos Select @HoyEllos = @HoyHora 
 
 Select @BonFo
lDoc_id = convert(int,@extFolioFinanciador) 
 Select @BonFolAnt_cr = convert(char(12),@extFolioFinanciador) 
 
 Select @BonRutCot_ta = convert(int,substring(ltrim(rtrim(@extRutCotizante)),1, 
                        charindex('-',ltrim(rtrim(@extRutCotiza
nte)))-1)) 
 
 Select @BonDigCot_ta = substring(ltrim(rtrim(@extRutCotizante)), 
          charindex('-',ltrim(rtrim(@extRutCotizante)))+1,1) 
 
 Select @BonCcoVta_ta = '1', 
        @BonCcoCom_ta = '1' 
 
 --// Obtencion de los Datos particulares del con
trato 
 --// Versión del Contrato 
 --// Numero de Colectivo 
 --// Centro de Costo de Ventas 
 --// Centro de Costo Comunal 
 
 Select @BonVerCon_ta = ConVerVig_ta, 
        @BonNumCol_ta = ConNumCol_nn, 
        @BonCcoVta_ta = ConCenCos_ta, 
        @B
onCcoCom_ta = ConCcoLoc_ta 
 from   contrato..Contrato 
 Where  ConRutCot_id = @BonRutCot_ta 
   and  ConMarCon_id = @Marca 
   and  ConNumCto_id = @NroContrato 
 
 Select @BonCcoOpe_ta = '1' 
 exec @ErrorCode = parametro..Sel_CenCostoxSucursal @BonSucBon
_ta, @BonCcoOpe_ta output 
 
 if @ErrorCode != 0 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'TRX DENEGADA (EI:400321)' 
   --//Select @extMensajeError = 'TRX DENEGADA (EI:400321)' 
   return 1 --//No Se Centro de Costo Operativo 

  end 
 
 --// Direccion de atención del convenio del bono. 
 Select @BonDirCon_ta = convert(int,@extHomLugarConvenio) 
 
 --// Nomina Generica del Convenio. 
 if exists(select 1 from convenio..LugarAtencion where LatCorLat_nn = @BonDirCon_ta)
 Begin
   
 Select @BonCodNom_ta = CprCodNom_ta
          ,@PrestadorEmisor = CprRutPre_ta
    from convenio..LugarAtencion, convenio..ConvenioPrestador
    where LatCorLat_nn = @BonDirCon_ta
      and CprFolCon_nn = LatFolCon_nn
      and CprVigDes_fc <= @HoyEllos

      and isNull(CprVigHas_fc, @HoyMasUno) >= @HoyEllos
    if @BonCodNom_ta is Null
       Select top 1 @BonCodNom_ta = CprCodNom_ta
                   ,@PrestadorEmisor = CprRutPre_ta
       from convenio..LugarAtencion, convenio..ConvenioPrestador
    
   where LatCorLat_nn = @BonDirCon_ta
         and CprFolCon_nn = LatFolCon_nn
       order by CprIdrCpr_id desc
 end
 else
    Select @BonCodNom_ta = ConCodNom_ta
          ,@PrestadorEmisor = ConRutPre_ta
    from   convenio..DireccionAtencion 
        
  ,convenio..Convenio 
    where  DatCorDir_id = @BonDirCon_ta 
      and  ConFolCon_id = DatFolCon_ta 
      and  ConCorRen_id = DatCorRen_ta 
 
 
 -- // PAQUETES ESTAN FUERA DE ESTA MODALIDAD POR DEFINICION. 
 Select @BonCodPae_ta = NULL 
 
 -- // SON D
ISTINTAS PRESTACIONES EVENTUALMENTE DE 'N' ESPECIALIDADES 
 -- // POR ELLO ES DIFICIL DISCRIMINAR UNA UNICA ESPECIALIDAD. SE SUMIRÁ NULL 
 Select @BonEspMed_ta = NULL 
 
 --//VALIDACION DE EXISTENCIA DEL MEDICO TRATANTE O SOLICITANTE. 
 --// 
 --//REGLA D
E NEGOCIO: * Si no hay solicitante o tratante no importa. el bono soporta nulos. 
 --//                  * Tratante y Solicitante son mutuamente excluyentes. 
 --//                  * De Venir un tratante éste debe estar asociado al prestador en convenio 

 --//     de no ser asi, es causal de rechazo del servicio. 
 --//                  * De venir un Solicitante. éste debe estar en la base de prestadores. sino lo ingreso 
 --//                    con datos basicos. Si no pudo ser ingresado. rechazo el se
rvicio. 
 
 Select @BonRutMed_ta = NULL 
 Select @BonDigMed_cr = NULL 
 
 Select @RutCon = convert(int,substring(ltrim(rtrim(@extRutConvenio)),1,charindex('-',ltrim(rtrim(@extRutConvenio)))-1)) 
 
 if not ((@extRutTratante = '0000000000-0')or(@extRutTrata
nte is NULL)or(@extRutTratante = '')) 
  Select @RutTra = convert(int,substring(ltrim(rtrim(@extRutTratante)),1,charindex('-',ltrim(rtrim(@extRutTratante)))-1)) 
 else 
  Select @RutTra = NULL 
 
 if not ((@extRutAsociado = '0000000000-0')or(@extRutAsocia
do is NULL)or(@extRutAsociado = '')) 
  Select @RutSol = convert(int,substring(ltrim(rtrim(@extRutAsociado)),1,charindex('-',ltrim(rtrim(@extRutAsociado)))-1)) 
 else 
  Select @RutSol = NULL 
 
 if @RutTra is NULL and @RutSol is NULL 
  begin --//No vien
e ninguno 
   Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRutConvenio)),1, 
         charindex('-',ltrim(rtrim(@extRutConvenio)))-1)) 
 
   Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutConvenio)), 
                          charind
ex('-',ltrim(rtrim(@extRutConvenio)))+1,1) 
  end 
 else 
  begin 
    if @RutTra is NULL and @RutSol is NOT NULL 
     begin --// Viene Solo el tratante 
       Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRutAsociado)),1, 
              
                charindex('-',ltrim(rtrim(@extRutAsociado)))-1)) 
 
       Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutAsociado)), 
                              charindex('-',ltrim(rtrim(@extRutAsociado)))+1,1) 
     end   --// Viene Solo el trat
ante 
    else 
     begin 
      if @RutTra is Not NULL and @RutSol is NULL 
       begin --// Viene Solo el Solicitante 
         Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRutTratante)),1, 
                                charindex('-
',ltrim(rtrim(@extRutTratante)))-1)) 
 
         Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutTratante)), 
            charindex('-',ltrim(rtrim(@extRutTratante)))+1,1) 
       end   --// Viene Solo el Solicitante 
      else 
       begin 
       
 if @RutTra is Not NULL and @RutSol is not NULL 
         begin --// Vienen AMBOS 
           --//Tomo la primera prestacion que pille en funcion de esa se graba el tratante/solicitante 
           set rowcount 1 
           Select @CodCataPrest = Prestac
ion From   #DetallePrestaciones 
           set rowcount 0 
 
           exec @ErrorCode = prestacion..INGCtrl_TratSol @Marca, @CodCataPrest, @AccionPresta output 
 
           if @ErrorCode != 0 
            begin 
             Select @extCodError = 'N' 

             Select @extMensajeError = 'TRX DENEGADA (EI:400377)' 
             return 1 
            end 
 
           if @AccionPresta not in ('PR','AM') 
           begin 
              if @AccionPresta = 'TR' 
              begin --// Tratante es Exi
gible 
                 Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRutTratante)),1,charindex('-',ltrim(rtrim(@extRutTratante)))-1)) 
                 Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutTratante)), 
                      
                  charindex('-',ltrim(rtrim(@extRutTratante)))+1,1) 
              end   --// Tratante es Exigible 
              if @AccionPresta = 'SO' 
              begin --// Solicitante es Exigible 
                 Select @BonRutMed_ta = convert(in
t,substring(ltrim(rtrim(@extRutAsociado)),1, 
                                        charindex('-',ltrim(rtrim(@extRutAsociado)))-1)) 
                 Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutAsociado)), 
                                     
   charindex('-',ltrim(rtrim(@extRutAsociado)))+1,1) 

                 if not exists(Select 1 from convenio..Prestador where PreRutPre_id = @BonRutMed_ta) 
                    exec @ErrorCode = convenio..InsertPrestador @BonRutMed_ta,@BonDigMed_cr,'MEDIC
O ING x CSALUD00', null, 
                                                                 null, 'ME', NULL, NULL, 'NA', 'NA',NULL,NULL,NULL,NULL,NULL,NULL, 
                                                                 @Hoy, @CodSucursal, 'CSALUD00', 
'PI' 
              end   --// Solicitante es Exigible 
           end 
          else 
            begin 
    --// A la rutina le da lo mismo cual de los dos, por REGLA DE NEGOCIO el TRATANTE. 
             Select @BonRutMed_ta = convert(int,substring(lt
rim(rtrim(@extRutTratante)),1,charindex('-',ltrim(rtrim(@extRutTratante)))-1)) 
 
             Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutTratante)), 
                                    charindex('-',ltrim(rtrim(@extRutTratante)))+1,1) 
        
    end 
         end   --// Viene Solo el Solicitante 
       end 
     end 
  end 
 
 Select @BonRutPre_ta = convert(int,substring(ltrim(rtrim(@extRutConvenio)),1, 
                        charindex('-',ltrim(rtrim(@extRutConvenio)))-1)) 
 
 Select @Bon
DigPre_cr = substring(ltrim(rtrim(@extRutConvenio)), 
    charindex('-',ltrim(rtrim(@extRutConvenio)))+1,1) 
 
 -- FR17023 
 -- si rut de medico validado en INGCopTran no existe en tabla Prestador, se usara id de Prestador 
 -- ello manejar restriccion de
 llave foranea de Bono a Prestador para Medico 
 if Not Exists( Select PreRutPre_id from convenio..Prestador where PreRutPre_id = @BonRutMed_ta) 
      Select @BonRutMed_ta = @BonRutPre_ta, @BonDigMed_cr = @BonDigPre_cr 

 select @PrestadorFacturador = @B
onRutPre_ta, @DigFacturador = @BonDigPre_cr 
 if @PrestadorEmisor <> @BonRutPre_ta
 begin
    set @BonRutPre_ta = @PrestadorEmisor
    select @BonDigPre_cr = PreDigPre_cr from convenio..Prestador where PreRutPre_id = @PrestadorEmisor
 end
 
 Select @BonTo
tPre_$$ = convert(int,@extMontoValorTotal) 
 
 Select @BonTotBon_$$ = convert(int,@extMontoAporteTotal) 
 
 Set @MtoExcedente = isNull(convert(int, @extMontoExcedente), 0)
 
 if (@MtoExcedente > (@BonTotPre_$$ - @BonTotBon_$$))   --Excedente > Copago
 beg
in
   Select @extCodError = 'N' 
   Select @extMensajeError = 'TRX DENEGADA (EO:400330)'    
   return 1 
 end
  --// REGLA DE NEGOCIO IMED 
 --// ---------------- 
 --// Monto por Rendir es equivalente a Valor Prestacion, salvo  que prestaciones
 --// se
an del tipo Dental Capitado (grupo cobertura 492)
 
 --// Total Prestacion por defecto. 
 if @vliEsDentalCapitado = 0
    Select @BonTotRen_$$ = @BonTotPre_$$ 
 else
    Set @BonTotRen_$$ = 0
    
  if @BonTotPre_$$ <> @tot_Pre 
  begin 
   Select @extCod
Error = 'N' 
   Select @extMensajeError = 'TRX DENEGADA (EO:400322)' 
--//   Select @extMensajeError = 'TRX DENEGADA (EO:400322)' 
   return 1 
  end 
 
 if @BonTotBon_$$ <> @tot_Bon 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'TR
X DENEGADA (EO:400323)' 
  --// Select @extMensajeError = 'TRX DENEGADA (EO:400323)' 
  return 1 
  end 
 
 -- // Los Atributos de Caja serán dejados nulos. por que no ha caja por parte de 
 -- // compañía. 
 Select  @BonDepCaj_ta = NULL, @BonCodCaj_ta = 
NULL, @BonHosCaj_ta = NULL 
 
 --// Los Atributos de Login deberén ser GENERICOS. 
 Select  @BonLogAdm_ta = 'CSALUD00', @BonHosAdm_ta = 'C-SALUD01' 
 
 --// Dado que no existiran instancias de autorizacion el login para ello 
 --// permanecerá NULO. 
 Sel
ect  @BonLogAut_ta = NULL 
 
 --// Datos de quien retira el BONO. 
 Select @BonRutRet_nn = convert(int,substring(ltrim(rtrim(@extRutBeneficiario)),1, 
                        charindex('-',ltrim(rtrim(@extRutBeneficiario)))-1)) 
 Select @BonDigRet_cr = su
bstring(ltrim(rtrim(@extRutBeneficiario)), 
           charindex('-',ltrim(rtrim(@extRutBeneficiario)))+1,1) 
 
 --// Estos Bonos Se GRABAN PAGADOS por ésta acción fue realizada donde el prestador. 
 Select @BonEstDoc_re = 'P' 
 
 --// El copago queda don
de el prestador por lo tanto NO recaudamos copago. 
 Select @BonRecCop_re = 'S' 
 
 --// El comprobante contable no se aplica en este momento. Idem Rendicion de Pago 
 Select @BonComCon_nn = NULL, 
      @BonRenPag_nn = NULL 
 
 --// El Origen de Atención
 es siempre ambulatorio. 
 --// El tipo de Bono Debe ser definido por ahora se usará 'T' Telefonico 
 Select  @BonTipBon_re = 'E', 
         @BonOriAte_re = 'AM' 
 
 --// NO HAY MEDICO DE CABECERA 
 Select @BonRutMca_ta = NULL, 
        @BonDigMca_cr = NU
LL 
 

 
 
 --// Los Siguientes atributos deberan ser insertados NULOS 
 Select @BonFecDev_fc = NULL, 
        @BonSucDev_ta = NULL, 
        @BonLogDev_ta = NULL, 
        @BonFecRen_fc = NULL, 
        @BonComDev_nn = NULL, 
        @BonFecMan_fc = NULL
 
 
 --// El Folio No debe Estar (UT)ilizado o (NU)lo en la Tabla de Control de Folios 
 if  (Select LcfEstUso_re From   prestacion..Log_Control_Folios 
      where  LcfFolEnt_id = @BonFolDoc_id 
        and  LcfTipDoc_id = 'BO')  <> 'SO' 
  begin 
   Sel
ect @extCodError = 'N' 
   Select @extMensajeError = 'TRX DENEGADA (EO:400324)' 
--//   Select @extMensajeError = 'TRX DENEGADA (EO:400324)' 
   return 1 
  end 
 
 begin tran 
 
 insert into prestacion..Bono (BonMarBon_id,  BonFolDoc_id,  BonFolAnt_cr,  
BonFecEmi_fc, 
                               BonRutCot_ta,  BonDigCot_cr,  BonNumCto_ta,  BonCorCar_ta, 
                               BonCodPla_ta,  BonVerCon_ta,  BonDirCon_ta,  BonCodNom_ta, 
                               BonCodPae_ta,  BonEspMed_ta
,  BonNumCol_ta,  BonRutMed_ta, 
                               BonDigMed_cr,  BonRutPre_ta,  BonDigPre_cr,  BonTotPre_$$, 
                               BonTotBon_$$,  BonSucBon_ta,  BonDepCaj_ta,  BonCodCaj_ta, 
                               BonHosCaj
_ta,  BonLogAdm_ta,  BonHosAdm_ta,  BonLogAut_ta, 
                               BonRutRet_nn,  BonDigRet_cr,  BonEstDoc_re,  BonRecCop_fl, 
                               BonComCon_nn,  BonRenPag_nn,  BonTipBon_re,  BonOriAte_re, 
                      
         BonCcoOpe_ta,  BonCcoVta_ta,  BonCcoCom_ta,  BonRutMca_ta, 
                               BonDigMca_cr,  BonTotRen_$$,  BonFecDev_fc,  BonSucDev_ta, 
                               BonLogDev_ta,  BonFecRen_fc,  BonComDev_nn,  BonFecMan_fc,
     
                          BonRutFac_ta,  BonDigFac_cr,  BonTotOri_$$,  BonFecAte_fc) 
             values           (@Marca,        @BonFolDoc_id, @BonFolAnt_cr, @HoyEllos, 
                               @BonRutCot_ta, @BonDigCot_ta, @NroContrato,  @cor_
car, 
                               @extPlan,      @BonVerCon_ta, @BonDirCon_ta, @BonCodNom_ta, 
                               @BonCodPae_ta, @BonEspMed_ta, @BonNumCol_ta, @BonRutMed_ta, 
                               @BonDigMed_cr, @BonRutPre_ta, @Bon
DigPre_cr, @BonTotPre_$$, 
                               @BonTotBon_$$, @BonSucBon_ta, @BonDepCaj_ta, @BonCodCaj_ta, 
                               @BonHosCaj_ta, @BonLogAdm_ta, @BonHosAdm_ta, @BonLogAut_ta, 
                               @BonRutRet_nn
, @BonDigRet_cr, @BonEstDoc_re, @BonRecCop_re, 
                               @BonComCon_nn, @BonRenPag_nn, @BonTipBon_re, @BonOriAte_re, 
                               @BonCcoOpe_ta, @BonCcoVta_ta, @BonCcoCom_ta, @BonRutMca_ta, 
                       
        @BonDigMca_cr, @BonTotRen_$$, @BonFecDev_fc, @BonSucDev_ta, 
                               @BonLogDev_ta, @BonFecRen_fc, @BonComDev_nn, @BonFecMan_fc,
                               @PrestadorFacturador, @DigFacturador, @BonTotPre_$$, @HoyEllos) 

 
 if @@error != 0 
  begin 
   rollback tran 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'TRX DENEGADA (EI:400325)' 
   --//Select @extMensajeError = 'TRX DENEGADA (EI:400325)' 
   return 1 
  end 
 
 commit tran 
 
 Select @BorraCabeDet
a = 0 
 
 Select @MinCorr = min(Correlativo) From #DetallePrestaciones 
 
 Select @MaxCorr = max(Correlativo) From #DetallePrestaciones 
 
 While @MinCorr <= @MaxCorr 
  begin 
 
   Select @DboFolDoc_id = @BonFolDoc_id, 
          @DboMarBon_id = @Marca, 

          @DboCorBon_id = Correlativo, 
          @DboGruCob_id = convert(char(3),convert(smallint,GrupoCob)), 
          @DboCodPre_ta = Prestacion, 
          @DboCodIte_ta = Item, 
          @DboModCob_ta = ModalidadCon, 
          @DboCanAte_nn = Can
tidad, 
          @DboTipAte_re = 'AM', 
          @DboMonPre_$$ = Val_Pre, 
          @DboMonBon_$$ = Val_Bon, 
          @DboPorBon_nn = convert(numeric(5,2),((Val_Bon / Val_Pre) * 100.0)), 
          @DboTipCal_re = TipoCalculo, 
          @DboPorRec_n
n = 0, 
          @DboValRen_$$ = Val_Rend, 
          @DboMtoOcr_$$ = 0,
          @DboMinFon_nn = MinBonFon,
          @DboCodHom_cr = Homologo
   From   #DetallePrestaciones 
   where  Correlativo = @MinCorr 
 
   begin tran 
 
   insert into prestacio
n..DetaBono (DboFolDoc_id, DboMarBon_id, DboCorBon_id, DboGruCob_id, DboCodPre_ta, 
                                    DboCodIte_ta, DboModCob_ta, DboCanAte_nn, DboTipAte_re, DboMonPre_$$, 
                                    DboMonBon_$$, DboPorBon_nn, 
DboTipCal_re, DboPorRec_nn, DboValRen_$$, 
                                    DboMtoOcr_$$, DboMinFon_nn, DboCodHom_cr, DboMonOri_$$, DboBonOri_$$ ) 
   values      (@DboFolDoc_id, @DboMarBon_id, @DboCorBon_id, @DboGruCob_id, @DboCodPre_ta, 
            
    @DboCodIte_ta, @DboModCob_ta, @DboCanAte_nn, @DboTipAte_re, @DboMonPre_$$, 
                @DboMonBon_$$, @DboPorBon_nn, @DboTipCal_re, @DboPorRec_nn, @DboValRen_$$, 
                @DboMtoOcr_$$, @DboMinFon_nn, @DboCodHom_cr, @DboMonPre_$$, @DboMon
Bon_$$) 
 
   Select @ErrorCode = @@error 
 
   if @ErrorCode != 0 
    begin 
     rollback tran 
     Select @BorraCabeDeta = 1 
     Select @MinCorr = @MaxCorr + 1 
    end 
 
   if @ErrorCode = 0 commit tran 
 
   Select @MinCorr = @MinCorr + 1 
  end
 
 
 if @BorraCabeDeta = 1 
  begin 
   delete prestacion..DetaBono 
   where DboFolDoc_id = @BonFolDoc_id 
     and  DboMarBon_id = @Marca 
 
   delete prestacion..Bono 
   where  BonMarBon_id = @Marca 
    and  BonFolDoc_id = @BonFolDoc_id 
 
   Select 
@extCodError = 'N' 
   Select @extMensajeError = 'TRX DENEGADA (EI:400326)' 
 
   --//   Select @extMensajeError = 'TRX DENEGADA (EI:400326)' 
   return 1 --//No Se Centro de Costo Operativo 
  end 
 
 exec @ErrorCode = prestacion..Movi_CueCorBenxFolio @M
arca, @BonFolDoc_id, 'BO', '+', 'N', NULL 
 
 if @ErrorCode != 0 
  begin 
   delete prestacion..DetaBono 
   where  DboFolDoc_id = @BonFolDoc_id 
     and  DboMarBon_id = @Marca 
 
   delete prestacion..Bono 
   where  BonMarBon_id = @Marca 
     and  Bo
nFolDoc_id = @BonFolDoc_id 
 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'TRX DENEGADA (EI:400327)' 
   return 1 --//No Se Centro de Costo Operativo 
  end 
  
 --// Actualizacion de CtaCte Excedentes  FR 13565 
 if @MtoExcedente > 0 
 beg
in 
      exec @ErrorCode = prestacion..INGMovExcedente 
                        @Marca 
                       ,@BonRutCot_ta 
                       ,@MtoExcedente 
                       ,'US'            -- uso de excedente 
                       ,@Bo
nFolDoc_id 
 
      if @ErrorCode = 0
      begin
           insert  prestacion..UsoDocPag 
                  (UdpTipDoc_id, UdpFolDoc_id,  UdpMarUdp_id,  UdpForPag_re, 
                   UdpMonUti_$$, UdpSerDoc_cr,  UdpDocPag_nn,  UdpNumCon_nn, 
       
            UdpRutEmp_ta, UdpDigEmp_cr,  UdpSucEmp_ta,  UdpMonMax_$$) 
           values ('BO', @BonFolDoc_id, @Marca, 'CE', 
                   @MtoExcedente, null, 1, 0, 
                   null, null, null, @MtoExcedente) 
                    
        
    set @ErrorCode = @@error
      end
      if @ErrorCode != 0 
      begin 
           delete prestacion..DetaBono 
           where 
                  DboFolDoc_id = @BonFolDoc_id 
              and DboMarBon_id = @Marca 
 
           delete prestacion
..Bono 
           where 
                 BonMarBon_id = @Marca 
             and BonFolDoc_id = @BonFolDoc_id 
 
           Select @extCodError = 'N' 
           Select @extMensajeError = 'Error al crear Bono en Isapre' 
           return 1 
       end 

 end 

  -- en caso de ges se validan canastas y se determina folio de caso
  if @EsGES = 1
  begin
     select @vliQxGES = count(*) from #ListaCanastasGES
     
     if @vliQxGES = 0
        set @ErrorCode = 1  --no hay canastas
     else
     begin
   
     if @vliQxGES > 1
        begin
           Select distinct CodCar as Canasta into #CanastasInvalidas
           from #ListaCanastasGES a, #DetallePrestaciones b
           where not exists (select 1 from prestacion..GES_PrestacionGrupo
               
              where PgrNumPro_id = a.NumPro
                               and PgrCodEta_id = a.CodEta
                               and PgrCodCar_id = a.CodCar
                               and PgrCorRen_id = a.CorRen
                               and
 PgrCodPre_id = b.Prestacion)
           if @@rowcount > 0
           begin
              delete from #ListaCanastasGES
              from #ListaCanastasGES, #CanastasInvalidas
              where CodCar = Canasta
              
              if (select c
ount(*) from #ListaCanastasGES) = 0
                 set @ErrorCode = 1
           end
        end               
        if @ErrorCode = 0
        begin
           Select Top 1 @vliFolEve = GevFolEve_id, @vliCorRen = GevCorRen_id, @vliNumPro = NumPro, @v
lcCodEta = CodEta, @vlcPerUso = PerUso, 
                        @vlcCodCar = CodCar
           from prestacion..Evento_CAEC 
               ,prestacion..GES_GrupoEvento
               ,#ListaCanastasGES
           where EcaMarCon_ta = @Marca 
           
  and EcaRutCon_ta = @BonRutCot_ta
             and EcaNumCto_ta = @NroContrato
             and EcaIteBen_ta = @cor_car
             and EcaTipCob_re = 'GE'      -- GES 
             and EcaNumEve_id  > 50000
             and isNull(EcaFecAlt_fc, @HoyMas
Uno) >= @HoyEllos
             and GevFolEve_id = EcaNumEve_id 
             and GevFecIni_fc <= @Hoy
             and isNull(GevFecTer_fc, @HoyMasUno) >= @HoyEllos
             and GevCodCar_id = CodCar
             and GevNumPro_id = NumPro
            
 and GevCodEta_id = CodEta
           Order by GevFecIni_fc desc, GevCorRen_id desc
           
           if @@rowcount = 0
              set @ErrorCode = 1
         end
                            
     end
     if @ErrorCode != 0
     begin 
        de
lete prestacion..DetaBono 
        where 
             DboFolDoc_id = @BonFolDoc_id 
         and DboMarBon_id = @Marca 

        if @MtoExcedente > 0
           Delete prestacion..UsoDocPag
           where UdpTipDoc_id = 'BO'
             and UdpFolDoc_
id = @BonFolDoc_id
             and UdpMarUdp_id = @Marca
           
        delete prestacion..Bono 
        where 
             BonMarBon_id = @Marca 
         and BonFolDoc_id = @BonFolDoc_id 
 
        Select @extCodError = 'N' 
        Select @extMe
nsajeError = 'Error con Bono GES en Isapre' 
        return 1 
      end 
     
  end
  
  if @EsGES = 1
  begin
     exec @ErrorCode = prestacion..SelUfUltDiaMesAnt @HoyEllos, @vlnValUF output 
      if @ErrorCode != 0 
      begin 
           delete pre
stacion..DetaBono 
           where 
                  DboFolDoc_id = @BonFolDoc_id 
              and DboMarBon_id = @Marca 

          if @MtoExcedente > 0
             Delete prestacion..UsoDocPag
             where UdpTipDoc_id = 'BO'
               a
nd UdpFolDoc_id = @BonFolDoc_id
               and UdpMarUdp_id = @Marca

           delete prestacion..Bono 
           where 
                 BonMarBon_id = @Marca 
             and BonFolDoc_id = @BonFolDoc_id 
 
           Select @extCodError = 'N' 

           Select @extMensajeError = 'Error valor UF' 
           return 1 
       end 
     if @ErrorCode = 0
     begin
        Set @vliCorMov = 0
        Set @vlcTipMov = 'LN' 
        Set @vlcTipDoc = 'BO'
        Set @vliFolBon = @DboFolDoc_id
      
  Set @vlcMarBon = @Marca
        Set @vldFecDoc = @HoyEllos
        Set @vliMtoGas = @BonTotPre_$$ 
        Set @vliMtoBon = @BonTotBon_$$
        Set @vliMtoCop = @BonTotPre_$$ - @BonTotBon_$$
        Set @vliMtoNoc = 0
        Set @vlnCopUf  = Round((@
BonTotPre_$$ - @BonTotBon_$$)/ @vlnValUF , 2)
        Set @vlnMtoDed = Round((@BonTotPre_$$ - @BonTotBon_$$)/ @vlnValUF , 2)
        Set @vlnMtoSeg = 0
        Set @vldFecCal = @HoyEllos
        Set @vlcLogIng = @BonLogAdm_ta
        Set @vldFecIng = @Hoy

        Set @vlcSucIng = @BonSucBon_ta
        Set @vliFolPar = Null 
        Set @vliCorDoc = Null 
        Set @vliCorAgr = Null 
        Set @vliCorPre = Null 
        Set @vlcGloObs = Null 
        Set @vliFolRee = Null 
        Set @vlcMarRee = Null

        Set @vliMtoTot = @BonTotPre_$$
        Set @vldFecHas = @Hoy

        exec @ErrorCode = prestacion..GES_InsEventoCtaCte 
                           @vliFolEve, @vliCorMov, @vliNumPro, @vlcCodEta, @vlcPerUso, @vlcCodCar, @vliCorRen, @vlcTipMov, @v
lcTipDoc, @vliFolBon, 
                           @vlcMarBon, @vldFecDoc, @vliMtoGas, @vliMtoBon, @vliMtoCop, @vliMtoNoc, @vlnCopUf,  @vlnMtoDed, @vlnMtoSeg, @vldFecCal, 
                           @vlnValUF,  @vlcLogIng, @vldFecIng, @vlcSucIng, @vliFolPa
r, @vliCorDoc, @vliCorAgr, @vliCorPre, @vlcGloObs, @vliFolRee, 
                           @vlcMarRee, @vliMtoTot, @vldFecHas

      end
      if @ErrorCode != 0 
      begin 
           delete prestacion..DetaBono 
           where DboFolDoc_id = @BonFol
Doc_id 
             and DboMarBon_id = @Marca 
 
           if @MtoExcedente > 0
              Delete prestacion..UsoDocPag
              where UdpTipDoc_id = 'BO'
               and UdpFolDoc_id = @BonFolDoc_id
               and UdpMarUdp_id = @Marca


           delete prestacion..Bono 
           where BonMarBon_id = @Marca 
             and BonFolDoc_id = @BonFolDoc_id 
 
           Select @extCodError = 'N' 
           Select @extMensajeError = 'Error con gasto GES en Isapre' 
           return 1 
 
      end 
  end
 
 
 --// ACtualizacion de log Control de Folios. 
 begin tran 
 
 Update prestacion..Log_Control_Folios 
    set LcfFecUso_fc = getdate(), 
        LcfEstUso_re = 'UT', 
        LcfCodDia_cr = @extCodigoDiagnostico, 
        LcfRutEmi_nn
 = convert(int,substring(ltrim(rtrim(@extRutEmisor)),1, 
                       charindex('-',ltrim(rtrim(@extRutEmisor)))-1)), 
        LcfDigEmi_cr = substring(ltrim(rtrim(@extRutEmisor)), 
                       charindex('-',ltrim(rtrim(@extRutEmisor)
))+1,1), 
        LcfRutCaj_nn = convert(int,substring(ltrim(rtrim(@extRutCajero)),1, 
     charindex('-',ltrim(rtrim(@extRutCajero)))-1)), 
        LcfDigCaj_cr = substring(ltrim(rtrim(@extRutCajero)), 
                       charindex('-',ltrim(rtrim(@e
xtRutCajero)))+1,1) 
 where  LcfFolEnt_id = @BonFolDoc_id 
   and  LcfTipDoc_id = 'BO' 
 
 Select @ErrorCode = @@error 
 
 if @ErrorCode != 0 
  begin 
 
   delete prestacion..DetaBono 
   where  DboFolDoc_id = @BonFolDoc_id 
     and  DboMarBon_id = @Mar
ca 
   
   if @MtoExcedente > 0
      Delete prestacion..UsoDocPag
      where UdpTipDoc_id = 'BO'
        and UdpFolDoc_id = @BonFolDoc_id
        and UdpMarUdp_id = @Marca
   
   delete prestacion..Bono 
   where  BonMarBon_id = @Marca 
     and  BonFol
Doc_id = @BonFolDoc_id 
   
   Select @extCodError = 'N' 
   Select @extMensajeError = 'TRX DENEGADA (EI:400328)' 
--//   Select @extMensajeError = 'TRX DENEGADA (EI:400328)' 
 
   return 1 --//No Se Centro de Costo Operativo 
  end 
 
 if @ErrorCode = 0 
commit tran 
 
 Select @extCodError = 'S' 
 Select @extMensajeError = '' 
 
 return 1 
 
end 
 
                                                                                                                                                               
(200 rows affected)
(return status = 0)
1> 
