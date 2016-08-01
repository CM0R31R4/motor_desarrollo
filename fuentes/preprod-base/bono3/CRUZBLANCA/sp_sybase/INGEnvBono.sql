locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
134
(1 row affected)
text
create procedure dbo.INGEnvBono 
( 
 @extCodFinanciador     smallint, 
 @extHomNumeroConvenio  char(15), 
 @extHomLugarConvenio   char(10), 
 @extSucVenta           char(10), 
 @extRutConvenio        char(12), 
 @extRutAsociado        char(12), 
 @extNomP
restador       char(40), 
 @extRutTratante        char(12), 
 @extRutBeneficiario    char(12), 
 @extRutCotizante       char(12), 
 @extRutAcompanante     char(12), 
 @extRutEmisor          char(12), 
 @extRutCajero          char(12), 
 @extCodigoDiagnost
ico  char(10), 
 @extDescuentoxPlanilla char(1), 
 @extMontoExcedente     numeric(10), 
 @extFechaEmision       datetime, 
 @extNivelConvenio      tinyint, 
 @extFolioFinanciador   numeric(10), 
 @extMontoValorTotal    numeric(10), 
 @extMontoAporteTotal 
  numeric(10), 
 @extMontoCopagoTotal   numeric(10), 
 @extNumOperacion       numeric(10), 
 @extCorrPrestacion     numeric(10), 
 @extTipoSolicitud      tinyint, 
 @extFechaInicio        datetime, 
 @extUrgencia           char(1), 
 @extPlan             
  char(15), 
 @extLista1 char(255), 
 @extLista2             char(255), 
 @extCodError           char(1)  output, 
 @extMensajeError       char(30) output 
) 
/* 
--- *** ----------------------------------------------------------------------------- 
Modif
icado el :   Marzo de 2007 
Modificado por:   Marcelo Herrera 
Referencia    :   FR - 19057, 
                  Se incluye se movimiento de Excedente 
--- *** ----------------------------------------------------------------------------- 
Modificado el :  
 Enero de 2007 
Modificado por:   Marcelo Herrera 
Referencia    :   FR - 17023, se verifica existencia de Medico en tabla Prestador, si 
                  no existe se registrara Bono con Rut de Prestador (ello por cuanto 
                  venta fue val
idada por proceso en SP INGCopTran 
 
--- *** ----------------------------------------------------------------------------- 
 
Modificado el :   Diciembre de 2006 
Modificado por:   Marcelo Herrera 
Referencia    :   FR - 16035, se corrige registro de Rut
 0 para medico tratante, 
                  error en uso en variables. 
 
--- *** ----------------------------------------------------------------------------- 
   procedimiento : INGEnvBono 
   Autor         : Cristian Rivas Rivera. 
 
   Parametros I 
 
      @extCodFinanciador  : Código del Financiador 
 
   Parametros O 
       @extCodError           : Código de Error ('S','N') 
                                S = estador exitoso de la transaccion 
                                N = fallo o error en t
ransaccion 
       @extMensajeError    : Mensaje de Error. 
 
   ------------------------ 
   |Servicios para C-Salud | 
   ------------------------ 
 
   Descripción 
   Envia Bonos Uno por uno al financiador para su registro. 
 
   Prueba 
 
 declare 
 
 @extCodError           char(1), 
  @extMensajeError  char(30) 
 
 exec prestacion..INGEnvBono 078,'40002-000','70002','120600','0096840380-K','0000000000-0','Arauco Salud', 
                            '0000000000-0','0005308213-0','0005308213-0','001960
0352-5','0000000000-0', 
     '0011316248-1', '','N',0000000000,'20061201',0,0011004914, 
     000010599,0000008479,0000002120,0000000001,0000000001,1,'19000101','','DFN3A08000', 
     '1707002000|0 |      |N|01|0010599|0008479|0002120|0280LEPB0000000|','
', 
     @extCodError output, @extMensajeError output 
 
 
*/ 
As 
declare @Marca         marca, 
         @ErrorCode      int, 
         @NroContrato    contrato, 
         @cor_car        regla, 
         @BonFolDoc_id   int, 
         @BonFolAnt_cr   c
har(12), 
         @BonRutCot_ta   rut, 
         @BonDigCot_ta   dv, 
         @BonDirCon_ta   int, 
         @BonCodPae_ta   int, 
         @BonEspMed_ta   char(3), 
         @BonNumCol_ta   int, 
         @BonVerCon_ta   char(5), 
         @BonRutMed_t
a   rut, 
         @BonDigMed_cr   dv, 
         @BonRutPre_ta   rut, 
         @BonDigPre_cr   dv, 
         @BonTotPre_$$   int, 
         @BonTotBon_$$   int, 
         @BonSucBon_ta   sucursal, 
         @BonDepCaj_ta   depto, 
         @BonCodCaj_ta 
  char(2), 
         @BonHosCaj_ta   host, 
         @BonLogAdm_ta   login, 
         @BonHosAdm_ta   host, 
         @BonLogAut_ta   login, 
         @BonRutRet_nn   rut, 
         @BonDigRet_cr   dv, 
         @BonEstDoc_re   regla, 
         @BonRecCop
_re   regla, 
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
  
       @BonFecMan_fc   fecha, 
         @BonCodNom_ta   smallint, 
         @extListaAUX    char(255), 
         @varTemp        char(75), 
         @ct_pipe        int, 
         @tot_Pre        int, 
         @tot_Bon        int, 
         @tot_Cop     
   int, 
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
         @DboPor
Bon_nn    numeric(5, 2), 
         @DboTipCal_re    regla, 
         @DboPorRec_nn    tinyint, 
         @DboValRen_$$    int, 
         @DboMtoOcr_$$  int, 
         @BorraCabeDeta   bit, 
         @Prestacion      prestacion, 
         @Item            
tinyint, 
         @Tipo            char(2), 
         @Recargo         char(1), 
         @Cantidad        tinyint, 
         @Val_Pre         int, 
         @RutTra          rut, 
         @RutSol   rut, 
         @Val_Bon         int, 
         @Val_Co
p         int, 
         @GrupoCob        char(4), 
         @ModalidadCon    char(4), 
         @TipoCalculo     regla, 
         @Homologo        char(20), 
         @InternoIsapre char(15), 
         @RutBen          rut, 
         @Hoy             fec
ha, 
         @Val_Rendicion   int, 
         @RutCon          int, 
         @RutMed_ta       int, 
         @DigMed_cr       dv, 
         @CodSucursal     sucursal, 
         @HoyEllos        fecha, 
         @HoyHora         fecha, 
         @CodCataP
rest    prestacion, 
         @AccionPresta    regla, 
         @Sw_Fecha        bit, 
         @HoyMasUno       fecha, 
         @Ok              flag, 
         @Folio           int 
         -- monto excedente FR 13565 
         ,@MtoExcedente   int 
 

begin 
 
 begin tran 
 
     update ContadorFolio 
     set    CfoNumFol_nn = CfoNumFol_nn - 1 
     where  CfoCodMar_id = 'IN' 
     And    CfoTipDoc_fl = 'LEEB' 
 
     select @Folio = CfoNumFol_nn 
     from   ContadorFolio 
     where  CfoCodMar_id =
 'IN' 
     and    CfoTipDoc_fl = 'LEEB' 
 
   commit tran 
 
  begin tran uno 
 
  insert prestacion..Log_EntradasEnvBono 
         (Log_NroTrx, LogFechaHoraTRX, LogCodFinanciador, LogHomNumeroConvenio, LogHomLugarConvenio, 
 LogSucVenta, LogRutConvenio,
 LogRutAsociado, LogNomPrestador, LogRutTratante, 
          LogRutBeneficiario, LogRutCotizante, LogRutAcompanante, LogRutEmisor, LogRutCajero, 
          LogCodigoDiagnostico, LogDescuentoxPlanilla, LogMontoExcedente, LogFechaEmision, 
          LogNive
lConvenio, LogFolioFinanciador, LogMontoValorTotal, LogMontoAporteTotal, 
          LogMontoCopagoTotal, LogNumOperacion, LogCorrPrestacion, LogTipoSolicitud, 
          LogFechaInicio, LogUrgencia, LogPlan, LogLista1, LogLista2) 
 values  (@Folio, getdat
e(), @extCodFinanciador, @extHomNumeroConvenio, @extHomLugarConvenio, 
          @extSucVenta, @extRutConvenio, @extRutAsociado, @extNomPrestador, @extRutTratante, 
          @extRutBeneficiario, @extRutCotizante, @extRutAcompanante, @extRutEmisor, @extRu
tCajero, 
          @extCodigoDiagnostico, @extDescuentoxPlanilla, @extMontoExcedente, @extFechaEmision, 
          @extNivelConvenio, @extFolioFinanciador, @extMontoValorTotal, @extMontoAporteTotal, 
          @extMontoCopagoTotal, @extNumOperacion, @ext
CorrPrestacion, @extTipoSolicitud, 
          @extFechaInicio, @extUrgencia, @extPlan, @extLista1, @extLista2) 
 
  if @@error != 0 
   begin 
    rollback tran uno 
    Select @extCodError = "N" 
    Select @extMensajeError = "TRX DENEGADA (EI:400365)" 

    --//Select @extMensajeError = "TRX DENEGADA (EI:400365)" 
    return 1 
   end 
 
  commit tran uno 
 
 --//// 
 
 Select @Hoy       = convert(smalldatetime,convert(char(10),getdate(),101)) 
 Select @HoyEllos  = convert(smalldatetime,convert(char(10),
@extFechaEmision,101)) 
 Select @HoyHora   = getdate() 
 Select @HoyMasUno = dateadd(dd,1,@HoyEllos) 
 
 --// Control de Fecha de Emision del Bono 
 --// 1 : Habilite Control 
 --// 0 : No realize Control 
 Select @Sw_Fecha = 1 
 exec @ErrorCode = prestac
ion..INGSwitch_FechaEmision @Sw_Fecha output 
 if @@error != 0 Select @Sw_Fecha = 1 
 
 if @Sw_Fecha = 1 
  begin 
   if @Hoy <> @HoyEllos 
    begin 
     Select @extCodError = "N" 
     Select @extMensajeError = "TRX DENEGADA (EO:400374)" 
     return 1
 --// Intenta grabar un bono con fecha de emision distinta al día de hoy. 
    end 
  end 
 
 Select @CodSucursal = convert(char(6),ltrim(rtrim(@extSucVenta))) 
 
 Select @BonSucBon_ta = @CodSucursal 
 
 create table #Cadenas 
 ( 
  Indice    numeric(10,0
) Identity, 
  Cadena char(75)      not null, 
  Procesado int               null 
 ) 
 
 --// Interprete de Lista basado en posición de pipes y no por largo fijo. 
 Select @extListaAUX = @extLista1 
 while char_length(ltrim(rtrim(@extListaAUX))) > 30 
  
begin 
   Select @varTemp = '' 
   Select @ct_pipe = 1 
   while @ct_pipe <= 9 
    begin 
     Select @varTemp = ltrim(rtrim(@varTemp)) + substring(@extListaAUX,1,charindex('|',@extListaAUX)) 
     Select @extListaAUX = substring(@extListaAUX,charindex('
|',@extListaAUX)+1,char_length(@extListaAUX)) 
     Select @ct_pipe = @ct_pipe + 1 
    end 
   insert #Cadenas Select @varTemp, NULL 
  end 
 
 Select @extListaAUX = @extLista2 
 while char_length(ltrim(rtrim(@extListaAUX))) > 30 
  begin 
   Select @var
Temp = '' 
   Select @ct_pipe = 1 
   while @ct_pipe <= 9 
    begin 
     Select @varTemp = ltrim(rtrim(@varTemp)) + substring(@extListaAUX,1,charindex('|',@extListaAUX)) 
     Select @extListaAUX = substring(@extListaAUX,charindex('|',@extListaAUX)+1,ch
ar_length(@extListaAUX)) 
     Select @ct_pipe = @ct_pipe + 1 
    end 
   insert #Cadenas Select @varTemp, NULL 
  end 
 
 --// Al finalizar la interpretación se tendra un tabla con cada línea de prestaciones diferenciada. 
 --// en el siguiente paso, el
 string será descompuesto en sus partes integrantes, y dejado en la tabla 
 --// #DetallePrestaciones 
 
 create table #DetallePrestaciones 
 ( 
  Correlativo  numeric(9,0) identity, 
  Prestacion   prestacion, 
  Item         tinyint, 
  Tipo         cha
r(2), 
  Homologo     char(15) NULL, 
  Recargo      char(1), 
  Cantidad  tinyint, 
  Val_Pre      int, 
  Val_Bon      int, 
  Val_Cop      int, 
  Val_Rend     int      null, 
  GrupoCob     char(4)  null, 
  ModalidadCon char(4)  null, 
  TipoCalculo 
 regla    null 
 ) 
 
 while exists(select 1 from #Cadenas where Procesado is null) 
  begin 
 
   set rowcount 1 
 
   Select @varTemp = Cadena 
   from   #Cadenas where  Procesado is null 
   order by Indice 
 
   Select @Prestacion    = substring(subst
ring(@varTemp,1,charindex('|',@varTemp)-1),1,7) 
   Select @Item          = convert(tinyint,substring(substring(@varTemp,1,charindex('|',@varTemp)-1),8,3)) 
   Select @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp)) 
 

   Select @Tipo          = substring(@varTemp,1,charindex('|',@varTemp)-1) 
   Select @varTemp   = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp)) 
 
   Select @Homologo      = ltrim(rtrim(substring(@varTemp,1,charindex('|',@varTemp)-1
))) 
   Select @varTemp    = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp)) 
   if char_length(ltrim(rtrim(@Homologo))) <= 1 Select @Homologo = NULL 
 
   Select @Recargo       = substring(@varTemp,1,charindex('|',@varTemp)-1) 
   Sel
ect @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp)) 
 
   Select @Cantidad      = convert(tinyint,substring(@varTemp,1,charindex('|',@varTemp)-1)) 
   Select @varTemp    = substring(@varTemp,charindex('|',@varTemp)+1,c
har_length(@varTemp)) 
 
   Select @Val_Pre       = convert(int,substring(@varTemp,1,charindex('|',@varTemp)-1)) 
   Select @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp)) 
 
   Select @Val_Bon       = convert(int,subs
tring(@varTemp,1,charindex('|',@varTemp)-1)) 
   Select @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp)) 
 
   Select @Val_Cop       = convert(int,substring(@varTemp,1,charindex('|',@varTemp)-1)) 
   Select @varTemp    
   = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp)) 
 
   Select @InternoIsapre = NULL 
   Select @GrupoCob      = NULL 
   Select @ModalidadCon  = NULL 
   Select @TipoCalculo   = NULL 
   Select @Val_Rendicion = NULL 
 
   --//if ch
ar_length(ltrim(rtrim(substring(@varTemp,1,charindex('|',@varTemp)-1)))) = 1 
   --//if char_length(ltrim(rtrim(substring(@varTemp,1,15)))) = 1 
   --// begin 
 
   Select @InternoIsapre = substring(@varTemp,1,15) --charindex('|',@varTemp)-1) 
     Select
 @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp)) 
 
     Select @GrupoCob      = substring(@InternoIsapre,1,3) 
     Select @ModalidadCon  = substring(@InternoIsapre,4,4) 
     Select @TipoCalculo   = substring(@Intern
oIsapre,8,2) 
     Select @Val_Rendicion = convert(int,substring(@InternoIsapre,10,6)) 
 
   --//end 
 
   if @InternoIsapre is NULL 
    begin 
     Select @extCodError = 'N' 
     Select @extMensajeError = "TRX DENEGADA (EI:400320)" 
    --//Select @ext
MensajeError = "TRX DENEGADA (EI:400320)" 
     return 1 --//No Se Centro de Costo Operativo 
    end 
 
   update #Cadenas set Procesado = 1 where Procesado is null 
 
   set rowcount 0 
 
   insert #DetallePrestaciones 
         (Prestacion, Item, Tipo,
 Homologo, Recargo, Cantidad, Val_Pre, Val_Bon, 
          Val_Cop, GrupoCob, ModalidadCon, TipoCalculo) 
   values (@Prestacion, @Item, @Tipo, @Homologo, @Recargo, @Cantidad, @Val_Pre, @Val_Bon, 
      @Val_Cop, @GrupoCob, @ModalidadCon, @TipoCalculo) 
 

 end 
 
 Select @tot_Pre = sum(Val_Pre) From #DetallePrestaciones 
 Select @tot_Bon = sum(Val_Bon) From #DetallePrestaciones 
 Select @tot_Cop = sum(Val_Cop) From #DetallePrestaciones 
 
 --// Obtención de los datos de contrato del beneficiario. 
 Select
 @RutBen = convert(int,substring(ltrim(rtrim(@extRutBeneficiario)),1,charindex('-',ltrim(rtrim(@extRutBeneficiario)))-1)) 
 
 exec   @ErrorCode = prestacion..INGSelConMar @RutBen, @HoyEllos, @HoyMasUno, 
                                              @Marc
a output, 
                                              @NroContrato output, 
                                              @Ok output 
 if @Ok = 'N' or @ErrorCode != 0 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = "TRX DENEGADA (E
I:400382)" 
   Select @Marca = 'XX' 
   return 1 
  end 
 
 Select @cor_car     = BenCorCar_id 
 from   contrato..Beneficiario 
 where  BenRutBen_nn = @RutBen 
   and  BenNumCto_id = @NroContrato 
   and  BenMarCon_id = @Marca 
   and  BenIniVig_fc <= @Ho
yEllos 
   and  BenTerVig_fc >= @HoyEllos 
 
 --// Los Bonos del Día serán grabados con Hora. 
 if @Hoy = @HoyEllos Select @HoyEllos = @HoyHora 
 
 Select @BonFolDoc_id = convert(int,@extFolioFinanciador) 
 Select @BonFolAnt_cr = convert(char(12),@extFoli
oFinanciador) 
 
 Select @BonRutCot_ta = convert(int,substring(ltrim(rtrim(@extRutCotizante)),1, 
                        charindex('-',ltrim(rtrim(@extRutCotizante)))-1)) 
 
 Select @BonDigCot_ta = substring(ltrim(rtrim(@extRutCotizante)), 
          cha
rindex('-',ltrim(rtrim(@extRutCotizante)))+1,1) 
 
 Select @BonCcoVta_ta = '1', 
        @BonCcoCom_ta = '1' 
 
 --// Obtencion de los Datos particulares del contrato 
 --// Versión del Contrato 
 --// Numero de Colectivo 
 --// Centro de Costo de Ventas 

 --// Centro de Costo Comunal 
 
 Select @BonVerCon_ta = ConVerVig_ta, 
        @BonNumCol_ta = ConNumCol_nn, 
        @BonCcoVta_ta = ConCenCos_ta, 
        @BonCcoCom_ta = ConCcoLoc_ta 
 from   contrato..Contrato 
 Where  ConRutCot_id = @BonRutCot_ta 

   and  ConMarCon_id = @Marca 
   and  ConNumCto_id = @NroContrato 
 
 Select @BonCcoOpe_ta = '1' 
 exec @ErrorCode = parametro..Sel_CenCostoxSucursal @BonSucBon_ta, @BonCcoOpe_ta output 
 
 if @ErrorCode != 0 
  begin 
   Select @extCodError = 'N' 
   Se
lect @extMensajeError = "TRX DENEGADA (EI:400321)" 
   --//Select @extMensajeError = "TRX DENEGADA (EI:400321)" 
   return 1 --//No Se Centro de Costo Operativo 
  end 
 
 --// Direccion de atención del convenio del bono. 
 Select @BonDirCon_ta = convert(
int,@extHomLugarConvenio) 
 
 --// Nomina Generica del Convenio. 
Select @BonCodNom_ta = ConCodNom_ta 
from   convenio..DireccionAtencion 
       ,convenio..Convenio 
where  DatCorDir_id = @BonDirCon_ta 
  and  ConFolCon_id = DatFolCon_ta 
  and  ConCorRe
n_id = DatCorRen_ta 
 
 
 -- // PAQUETES ESTAN FUERA DE ESTA MODALIDAD POR DEFINICION. 
 Select @BonCodPae_ta = NULL 
 
 -- // SON DISTINTAS PRESTACIONES EVENTUALMENTE DE "N" ESPECIALIDADES 
 -- // POR ELLO ES DIFICIL DISCRIMINAR UNA UNICA ESPECIALIDAD. S
E SUMIRÁ NULL 
 Select @BonEspMed_ta = NULL 
 
 --//VALIDACION DE EXISTENCIA DEL MEDICO TRATANTE O SOLICITANTE. 
 --// 
 --//REGLA DE NEGOCIO: * Si no hay solicitante o tratante no importa. el bono soporta nulos. 
 --//                  * Tratante y Solic
itante son mutuamente excluyentes. 
 --//                  * De Venir un tratante éste debe estar asociado al prestador en convenio 
 --//     de no ser asi, es causal de rechazo del servicio. 
 --//                  * De venir un Solicitante. éste debe e
star en la base de prestadores. sino lo ingreso 
 --//                    con datos basicos. Si no pudo ser ingresado. rechazo el servicio. 
 
 Select @BonRutMed_ta = NULL 
 Select @BonDigMed_cr = NULL 
 
 Select @RutCon = convert(int,substring(ltrim(rtri
m(@extRutConvenio)),1,charindex('-',ltrim(rtrim(@extRutConvenio)))-1)) 
 
 if not ((@extRutTratante = '0000000000-0')or(@extRutTratante is NULL)or(@extRutTratante = '')) 
  Select @RutTra = convert(int,substring(ltrim(rtrim(@extRutTratante)),1,charindex('
-',ltrim(rtrim(@extRutTratante)))-1)) 
 else 
  Select @RutTra = NULL 
 
 if not ((@extRutAsociado = '0000000000-0')or(@extRutAsociado is NULL)or(@extRutAsociado = '')) 
  Select @RutSol = convert(int,substring(ltrim(rtrim(@extRutAsociado)),1,charindex('-
',ltrim(rtrim(@extRutAsociado)))-1)) 
 else 
  Select @RutSol = NULL 
 
 if @RutTra is NULL and @RutSol is NULL 
  begin --//No viene ninguno 
   Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRutConvenio)),1, 
         charindex('-',ltrim(r
trim(@extRutConvenio)))-1)) 
 
   Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutConvenio)), 
                          charindex('-',ltrim(rtrim(@extRutConvenio)))+1,1) 
  end 
 else 
  begin 
    if @RutTra is NULL and @RutSol is NOT NULL 
     beg
in --// Viene Solo el tratante 
       Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRutAsociado)),1, 
                              charindex('-',ltrim(rtrim(@extRutAsociado)))-1)) 
 
       Select @BonDigMed_cr = substring(ltrim(rtrim(@ex
tRutAsociado)), 
                              charindex('-',ltrim(rtrim(@extRutAsociado)))+1,1) 
     end   --// Viene Solo el tratante 
    else 
     begin 
      if @RutTra is Not NULL and @RutSol is NULL 
       begin --// Viene Solo el Solicitante 

         Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRutTratante)),1, 
                                charindex('-',ltrim(rtrim(@extRutTratante)))-1)) 
 
         Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutTratante)), 
         
   charindex('-',ltrim(rtrim(@extRutTratante)))+1,1) 
       end   --// Viene Solo el Solicitante 
      else 
       begin 
        if @RutTra is Not NULL and @RutSol is not NULL 
         begin --// Vienen AMBOS 
           --//Tomo la primera prestacio
n que pille en funcion de esa se graba el tratante/solicitante 
           set rowcount 1 
           Select @CodCataPrest = Prestacion From   #DetallePrestaciones 
           set rowcount 0 
 
           exec @ErrorCode = prestacion..INGCtrl_TratSol @Mar
ca, @CodCataPrest, @AccionPresta output 
 
           if @ErrorCode != 0 
            begin 
             Select @extCodError = 'N' 
             Select @extMensajeError = 'TRX DENEGADA (EI:400377)' 
             return 1 
            end 
 
           if
 @AccionPresta not in ('PR','AM') 
            begin 
             if @AccionPresta = 'TR' 
              begin --// Tratante es Exigible 
               Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRutTratante)),1,charindex('-',ltrim(rtri
m(@extRutTratante)))-1)) 
 
               Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutTratante)), 
                                      charindex('-',ltrim(rtrim(@extRutTratante)))+1,1) 
              end   --// Tratante es Exigible 
           
  if @AccionPresta = 'SO' 
              begin --// Solicitante es Exigible 
               Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRutAsociado)),1, 
                                      charindex('-',ltrim(rtrim(@extRutAsociado)))-1
)) 
 
               Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutAsociado)), 
                                      charindex('-',ltrim(rtrim(@extRutAsociado)))+1,1) 
              end   --// Solicitante es Exigible 
           end 
          else
 
            begin 
    --// A la rutina le da lo mismo cual de los dos, por REGLA DE NEGOCIO el TRATANTE. 
             Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRutTratante)),1,charindex('-',ltrim(rtrim(@extRutTratante)))-1)) 
 
    
         Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutTratante)), 
                                    charindex('-',ltrim(rtrim(@extRutTratante)))+1,1) 
            end 
         end   --// Viene Solo el Solicitante 
       end 
     end 
  end 
 

 Select @BonRutPre_ta = convert(int,substring(ltrim(rtrim(@extRutConvenio)),1, 
                        charindex('-',ltrim(rtrim(@extRutConvenio)))-1)) 
 
 Select @BonDigPre_cr = substring(ltrim(rtrim(@extRutConvenio)), 
    charindex('-',ltrim(rtrim(@e
xtRutConvenio)))+1,1) 
 
 -- FR17023 
 -- si rut de medico validado en INGCopTran no existe en tabla Prestador, se usara id de Prestador 
 -- ello manejar restriccion de llave foranea de Bono a Prestador para Medico 
 if Not Exists( Select PreRutPre_id fr
om convenio..Prestador where PreRutPre_id = @BonRutMed_ta) 
      Select @BonRutMed_ta = @BonRutPre_ta, @BonDigMed_cr = @BonDigPre_cr 
 
 
 Select @BonTotPre_$$ = convert(int,@extMontoValorTotal) 
 
 Select @BonTotBon_$$ = convert(int,@extMontoAporteTotal
) 
 
 if @BonTotPre_$$ <> @tot_Pre 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = "TRX DENEGADA (EO:400322)" 
--//   Select @extMensajeError = "TRX DENEGADA (EO:400322)" 
   return 1 
  end 
 
 if @BonTotBon_$$ <> @tot_Bon 
  begin 

   Select @extCodError = 'N' 
   Select @extMensajeError = "TRX DENEGADA (EO:400323)" 
  --// Select @extMensajeError = "TRX DENEGADA (EO:400323)" 
  return 1 
  end 
 
 -- // Los Atributos de Caja serán dejados nulos. por que no ha caja por parte de 
 --
 // compañía. 
 Select  @BonDepCaj_ta = NULL, @BonCodCaj_ta = NULL, @BonHosCaj_ta = NULL 
 
 --// Los Atributos de Login deberén ser GENERICOS. 
 Select  @BonLogAdm_ta = 'CSALUD00', @BonHosAdm_ta = 'C-SALUD01' 
 
 --// Dado que no existiran instancias de 
autorizacion el login para ello 
 --// permanecerá NULO. 
 Select  @BonLogAut_ta = NULL 
 
 --// Datos de quien retira el BONO. 
 Select @BonRutRet_nn = convert(int,substring(ltrim(rtrim(@extRutBeneficiario)),1, 
                        charindex('-',ltri
m(rtrim(@extRutBeneficiario)))-1)) 
 Select @BonDigRet_cr = substring(ltrim(rtrim(@extRutBeneficiario)), 
           charindex('-',ltrim(rtrim(@extRutBeneficiario)))+1,1) 
 
 --// Estos Bonos Se GRABAN PAGADOS por ésta acción fue realizada donde el presta
dor. 
 Select @BonEstDoc_re = 'P' 
 
 --// El copago queda donde el prestador por lo tanto NO recaudamos copago. 
 Select @BonRecCop_re = 'S' 
 
 --// El comprobante contable no se aplica en este momento. Idem Rendicion de Pago 
 Select @BonComCon_nn = NU
LL, 
      @BonRenPag_nn = NULL 
 
 --// El Origen de Atención es siempre ambulatorio. 
 --// El tipo de Bono Debe ser definido por ahora se usará 'T' Telefonico 
 Select  @BonTipBon_re = 'E', 
         @BonOriAte_re = 'AM' 
 
 --// NO HAY MEDICO DE CABEC
ERA 
 Select @BonRutMca_ta = NULL, 
        @BonDigMca_cr = NULL 
 
 --// REGLA DE NEGOCIO IMED 
 --// ---------------- 
 --// Monto por Rendir es equivalente a Valor Prestacion, salvo  que en el 
 --// parametro de entrada Interno isapre, venga un valor 
> 0, lo que indica 
 --// que existe alguna otra regla, que ha modificado el monto a rendir, y este 
 --// ultimo valor es el que deberá prevalecer. 
 
 --// Total Prestacion por defecto. 
 Select @BonTotRen_$$ = @BonTotPre_$$ 
 
 --// Se cambio el valor 
rendicion. Ejem: Socios Alemana. 
 Select @Val_Rendicion = 0 
 Select @Val_Rendicion = sum(isnull(Val_Rend,0)) 
 From   #DetallePrestaciones 
 
 if @Val_Rendicion > 0 Select @BonTotRen_$$ = @Val_Rendicion 
 
 --// Los Siguientes atributos deberan ser inse
rtados NULOS 
 Select @BonFecDev_fc = NULL, 
        @BonSucDev_ta = NULL, 
        @BonLogDev_ta = NULL, 
        @BonFecRen_fc = NULL, 
    @BonComDev_nn = NULL, 
        @BonFecMan_fc = NULL 
 
 --// El Folio No debe Estar (UT)ilizado o (NU)lo en la Ta
bla de Control de Folios 
 if  (Select LcfEstUso_re From   prestacion..Log_Control_Folios 
      where  LcfFolEnt_id = @BonFolDoc_id 
        and  LcfTipDoc_id = 'BO')  <> 'SO' 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = "TRX DENE
GADA (EO:400324)" 
--//   Select @extMensajeError = "TRX DENEGADA (EO:400324)" 
   return 1 
  end 
 
 begin tran 
 
 insert into prestacion..Bono (BonMarBon_id,  BonFolDoc_id,  BonFolAnt_cr,  BonFecEmi_fc, 
                               BonRutCot_ta,  B
onDigCot_cr,  BonNumCto_ta,  BonCorCar_ta, 
                               BonCodPla_ta,  BonVerCon_ta,  BonDirCon_ta,  BonCodNom_ta, 
                               BonCodPae_ta,  BonEspMed_ta,  BonNumCol_ta,  BonRutMed_ta, 
                             
  BonDigMed_cr,  BonRutPre_ta,  BonDigPre_cr,  BonTotPre_$$, 
                               BonTotBon_$$,  BonSucBon_ta,  BonDepCaj_ta,  BonCodCaj_ta, 
                               BonHosCaj_ta,  BonLogAdm_ta,  BonHosAdm_ta,  BonLogAut_ta, 
           
                    BonRutRet_nn,  BonDigRet_cr,  BonEstDoc_re,  BonRecCop_fl, 
                               BonComCon_nn,  BonRenPag_nn,  BonTipBon_re,  BonOriAte_re, 
                               BonCcoOpe_ta,  BonCcoVta_ta,  BonCcoCom_ta,  BonRutMc
a_ta, 
                               BonDigMca_cr,  BonTotRen_$$,  BonFecDev_fc,  BonSucDev_ta, 
                               BonLogDev_ta,  BonFecRen_fc,  BonComDev_nn,  BonFecMan_fc) 
             values           (@Marca,        @BonFolDoc_id, @BonF
olAnt_cr, @HoyEllos, 
                               @BonRutCot_ta, @BonDigCot_ta, @NroContrato,  @cor_car, 
                               @extPlan,      @BonVerCon_ta, @BonDirCon_ta, @BonCodNom_ta, 
                               @BonCodPae_ta, @BonEspM
ed_ta, @BonNumCol_ta, @BonRutMed_ta, 
                               @BonDigMed_cr, @BonRutPre_ta, @BonDigPre_cr, @BonTotPre_$$, 
             @BonTotBon_$$, @BonSucBon_ta, @BonDepCaj_ta, @BonCodCaj_ta, 
                               @BonHosCaj_ta, @BonL
ogAdm_ta, @BonHosAdm_ta, @BonLogAut_ta, 
                               @BonRutRet_nn, @BonDigRet_cr, @BonEstDoc_re, @BonRecCop_re, 
                               @BonComCon_nn, @BonRenPag_nn, @BonTipBon_re, @BonOriAte_re, 
                              
 @BonCcoOpe_ta, @BonCcoVta_ta, @BonCcoCom_ta, @BonRutMca_ta, 
                               @BonDigMca_cr, @BonTotRen_$$, @BonFecDev_fc, @BonSucDev_ta, 
                               @BonLogDev_ta, @BonFecRen_fc, @BonComDev_nn, @BonFecMan_fc) 
 
 if @@e
rror != 0 
  begin 
   rollback tran 
   Select @extCodError = 'N' 
   Select @extMensajeError = "TRX DENEGADA (EI:400325)" 
   --//Select @extMensajeError = "TRX DENEGADA (EI:400325)" 
   return 1 
  end 
 
 commit tran 
 
 Select @BorraCabeDeta = 0 
 
 
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
          @DboCanAte_nn = Cantidad, 
  
        @DboTipAte_re = 'AM', 
          @DboMonPre_$$ = Val_Pre, 
          @DboMonBon_$$ = Val_Bon, 
          @DboPorBon_nn = convert(numeric(5,2),((Val_Bon / Val_Pre) * 100.0)), 
          @DboTipCal_re = TipoCalculo, 
          @DboPorRec_nn = 0, 
  
        @DboValRen_$$ = Val_Bon, 
          @DboMtoOcr_$$ = 0 
   From   #DetallePrestaciones 
   where  Correlativo = @MinCorr 
 
   begin tran 
 
   insert into prestacion..DetaBono (DboFolDoc_id, DboMarBon_id, DboCorBon_id, DboGruCob_id, DboCodPre_ta, 

                                    DboCodIte_ta, DboModCob_ta, DboCanAte_nn, DboTipAte_re, DboMonPre_$$, 
                                    DboMonBon_$$, DboPorBon_nn, DboTipCal_re, DboPorRec_nn, DboValRen_$$, 
                                    DboM
toOcr_$$) 
   values      (@DboFolDoc_id, @DboMarBon_id, @DboCorBon_id, @DboGruCob_id, @DboCodPre_ta, 
                @DboCodIte_ta, @DboModCob_ta, @DboCanAte_nn, @DboTipAte_re, @DboMonPre_$$, 
                @DboMonBon_$$, @DboPorBon_nn, @DboTipCal_re,
 @DboPorRec_nn, @DboValRen_$$, 
                @DboMtoOcr_$$) 
 
   Select @ErrorCode = @@error 
 
   if @ErrorCode != 0 
    begin 
     rollback tran 
     Select @BorraCabeDeta = 1 
     Select @MinCorr = @MaxCorr + 1 
    end 
 
   if @ErrorCode = 0 
commit tran 
 
   Select @MinCorr = @MinCorr + 1 
  end 
 
 if @BorraCabeDeta = 1 
  begin 
   delete prestacion..DetaBono 
   where DboFolDoc_id = @BonFolDoc_id 
     and  DboMarBon_id = @Marca 
 
   delete prestacion..Bono 
   where  BonMarBon_id = @Mar
ca 
    and  BonFolDoc_id = @BonFolDoc_id 
 
   Select @extCodError = "N" 
   Select @extMensajeError = "TRX DENEGADA (EI:400326)" 
 
   --//   Select @extMensajeError = "TRX DENEGADA (EI:400326)" 
   return 1 --//No Se Centro de Costo Operativo 
  end 
 

 exec @ErrorCode = prestacion..Movi_CueCorBenxFolio @Marca, @BonFolDoc_id, 'BO', '+', 'N', NULL 
 
 if @ErrorCode != 0 
  begin 
   delete prestacion..DetaBono 
   where  DboFolDoc_id = @BonFolDoc_id 
     and  DboMarBon_id = @Marca 
 
   delete prestaci
on..Bono 
   where  BonMarBon_id = @Marca 
     and  BonFolDoc_id = @BonFolDoc_id 
 
   Select @extCodError = "N" 
   Select @extMensajeError = "TRX DENEGADA (EI:400327)" 
   return 1 --//No Se Centro de Costo Operativo 
  end 
 
 --// Actualizacion de Ct
aCte Excedentes  FR 13565 
 Set @MtoExcedente = convert(int, @extMontoExcedente) 
 if @MtoExcedente > 0 
 begin 
      exec @ErrorCode = prestacion..INGMovExcedente 
                        @Marca 
                       ,@BonRutCot_ta 
                  
     ,@MtoExcedente 
                       ,'US'            -- uso de excedente 
                       ,@BonFolDoc_id 
 
      if @ErrorCode != 0 
      begin 
           delete prestacion..DetaBono 
           where 
                  DboFolDoc_id = @B
onFolDoc_id 
              and DboMarBon_id = @Marca 
 
           delete prestacion..Bono 
           where 
                 BonMarBon_id = @Marca 
             and BonFolDoc_id = @BonFolDoc_id 
 
           Select @extCodError = "N" 
           Select 
@extMensajeError = "Error al crear Bono en Isapre" 
           return 1 
       end 
 end 
 
 --// ACtualizacion de log Control de Folios. 
 begin tran 
 
 Update prestacion..Log_Control_Folios 
    set LcfFecUso_fc = getdate(), 
        LcfEstUso_re = 'U
T', 
        LcfCodDia_cr = @extCodigoDiagnostico, 
        LcfRutEmi_nn = convert(int,substring(ltrim(rtrim(@extRutEmisor)),1, 
                       charindex('-',ltrim(rtrim(@extRutEmisor)))-1)), 
        LcfDigEmi_cr = substring(ltrim(rtrim(@extRutEm
isor)), 
                       charindex('-',ltrim(rtrim(@extRutEmisor)))+1,1), 
        LcfRutCaj_nn = convert(int,substring(ltrim(rtrim(@extRutCajero)),1, 
     charindex('-',ltrim(rtrim(@extRutCajero)))-1)), 
        LcfDigCaj_cr = substring(ltrim(rtr
im(@extRutCajero)), 
                       charindex('-',ltrim(rtrim(@extRutCajero)))+1,1) 
 where  LcfFolEnt_id = @BonFolDoc_id 
   and  LcfTipDoc_id = 'BO' 
 
 Select @ErrorCode = @@error 
 
 if @ErrorCode != 0 
  begin 
 
   delete prestacion..DetaBon
o 
   where  DboFolDoc_id = @BonFolDoc_id 
     and  DboMarBon_id = @Marca 
 
   delete prestacion..Bono 
   where  BonMarBon_id = @Marca 
     and  BonFolDoc_id = @BonFolDoc_id 
 
   Select @extCodError = "N" 
   Select @extMensajeError = "TRX DENEGADA (
EI:400328)" 
--//   Select @extMensajeError = "TRX DENEGADA (EI:400328)" 
 
   return 1 --//No Se Centro de Costo Operativo 
  end 
 
 if @ErrorCode = 0 commit tran 
 
 Select @extCodError = "S" 
 Select @extMensajeError = "" 
 
 return 1 
 
end 
 
 
    
(134 rows affected)
(return status = 0)
1> 