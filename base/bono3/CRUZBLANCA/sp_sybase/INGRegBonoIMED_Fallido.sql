locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
122
(1 row affected)
text
create procedure dbo.INGRegBonoIMED_Fallido
(
 @extCodFinanciador     smallint,
 @extHomNumeroConvenio  char(15),
 @extHomLugarConvenio   char(10),
 @extSucVenta           char(10),
 @extRutConvenio        char(12),
 @extRutAsociado        char(12),
 @ext
NomPrestador       char(40),
 @extRutTratante        char(12),
 @extRutBeneficiario    char(12),
 @extRutCotizante       char(12),
 @extRutAcompanante     char(12),
 @extRutEmisor          char(12),
 @extRutCajero          char(12),
 @extCodigoDiagnostico
  char(10),
 @extDescuentoxPlanilla char(1),
 @extMontoExcedente     numeric(10),
 @extFechaEmision       datetime,
 @extNivelConvenio      tinyint,
 @extFolioFinanciador   numeric(10),
 @extMontoValorTotal    numeric(10),
 @extMontoAporteTotal   numeric(
10),
 @extMontoCopagoTotal   numeric(10),
 @extNumOperacion       numeric(10),
 @extCorrPrestacion     numeric(10),
 @extTipoSolicitud      tinyint,
 @extFechaInicio        datetime,
 @extUrgencia           char(1),
 @extPlan               char(15),
 @ext
Lista1 char(255),
 @extLista2             char(255),
 @extCodError           char(1)  output,
 @extMensajeError       char(30) output
)
/*
   procedimiento : INGEnvBono
   Autor         : Cristian Rivas Rivera.

   Parametros I
       @extCodFinanciador :
 Código del Financiador

   Parametros O
       @extCodError           : Código de Error ('S','N')
                                S = estador exitoso de la transaccion
                                N = fallo o error en transaccion
       @extMensajeErr
or    : Mensaje de Error.

   ------------------------
   |Servicios para C-Salud |
   ------------------------

   Descripción

   Envia Bonos Uno por uno al financiador para su registro.

   Prueba

 declare
  @extCodError           char(1),
  @extMensa
jeError       char(30)

 exec prestacion..INGEnvBono 078,'40002-000','70002','120600','0096840380-K','0000000000-0','Arauco Salud',
                            '0000000000-0','0005308213-0','0005308213-0','0019600352-5','0000000000-0',
     '0011316248-1'
,
                            '','N',0000000000,'20010514',0,0011004914,
                            000010599,0000008479,0000002120,
                            0000000001,0000000001,1,'19000101','','DFN3A08000',
                   '1707002000|0 | |N|01|
0010599|0008479|0002120|0280LEPB0000000|',
                            '',
                            @extCodError output,
                            @extMensajeError output


*/
As
declare @Ini char(26),@Fin char(26)
select @Ini=convert(char(26),getdat
e(),109)

declare @Marca         marca,
         @ErrorCode      int,
         @NroContrato    contrato,
         @cor_car        regla,
         @BonFolDoc_id   int,
         @BonFolAnt_cr   char(12),
         @BonRutCot_ta   rut,
         @BonDigCot_ta 
  dv,
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
 @BonTipBon_re 
  regla,
         @BonOriAte_re   regla,
         @BonCcoOpe_ta   char(10),
         @BonCcoVta_ta   char(10),
         @BonCcoCom_ta   char(10),
         @BonRutMca_ta   rut,
         @BonDigMca_cr   dv,
         @BonTotRen_$$   int,
    @BonFecDev_fc   
fecha,
         @BonSucDev_ta   sucursal,
         @BonLogDev_ta   login,
         @BonFecRen_fc   fecha,
         @BonComDev_nn   int,
         @BonFecMan_fc   fecha,
         @BonCodNom_ta   smallint,
         @extListaAUX    char(255),
         @varTem
p        char(75),
         @ct_pipe        int,
     @tot_Pre        int,
         @tot_Bon        int,
         @tot_Cop        int,
         @MinCorr        tinyint,
         @MaxCorr        tinyint,
         --// DETALLE DE BONOS
        @DboFolDoc_id
    int,
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
         @DboPorBon_nn    numeric(5, 2),
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
         @RutTra         
 rut,
         @RutSol   rut,
         @Val_Bon         int,
         @Val_Cop         int,
         @GrupoCob        char(4),
         @ModalidadCon    char(4),
         @TipoCalculo     regla,
         @Homologo        char(20),
         @InternoIsapre 
char(15),
         @RutBen          rut,
         @Hoy             fecha,
         @Val_Rendicion   int,
         @RutCon          int,
         @RutMed_ta       int,
         @DigMed_cr       dv,
         @CodSucursal     sucursal,
         @HoyEllos    
    fecha,
         @HoyHora         fecha,
         @CodCataPrest    prestacion,
         @AccionPresta    regla,
         @Sw_Fecha        bit
begin
/*
  begin tran uno

  insert prestacion..Log_EntradasEnvBono
         (LogFechaHoraTRX, LogCodFinanciad
or, LogHomNumeroConvenio, LogHomLugarConvenio,
 LogSucVenta, LogRutConvenio, LogRutAsociado, LogNomPrestador, LogRutTratante,
          LogRutBeneficiario, LogRutCotizante, LogRutAcompanante, LogRutEmisor, LogRutCajero,
 LogCodigoDiagnostico, LogDescuento
xPlanilla, LogMontoExcedente, LogFechaEmision,
          LogNivelConvenio, LogFolioFinanciador, LogMontoValorTotal, LogMontoAporteTotal,
          LogMontoCopagoTotal, LogNumOperacion, LogCorrPrestacion, LogTipoSolicitud,
          LogFechaInicio, LogUrge
ncia, LogPlan, LogLista1, LogLista2)
 values  (getdate(), @extCodFinanciador, @extHomNumeroConvenio, @extHomLugarConvenio,
          @extSucVenta, @extRutConvenio, @extRutAsociado, @extNomPrestador, @extRutTratante,
      @extRutBeneficiario, @extRutCotiz
ante, @extRutAcompanante, @extRutEmisor, @extRutCajero,
          @extCodigoDiagnostico, @extDescuentoxPlanilla, @extMontoExcedente, @extFechaEmision,
          @extNivelConvenio, @extFolioFinanciador, @extMontoValorTotal, @extMontoAporteTotal,
          
@extMontoCopagoTotal, @extNumOperacion, @extCorrPrestacion, @extTipoSolicitud,
          @extFechaInicio, @extUrgencia, @extPlan, @extLista1, @extLista2)

  if @@error != 0
   begin
    rollback tran uno
    Select @extCodError = "N"
    Select @extMensaj
eError = "TRX DENEGADA (EI:400365)"
    --//Select @extMensajeError = "TRX DENEGADA (EI:400365)"
    return 1
   end

  commit tran uno
*/

 Select @Hoy = convert(smalldatetime,convert(char(10),getdate(),101))
 Select @HoyEllos = convert(smalldatetime,con
vert(char(10),@extFechaEmision,101))
 Select @HoyHora  = getdate()

 Select @Sw_Fecha = 0

 if @Sw_Fecha = 1
  begin
   if @Hoy <> @HoyEllos
    begin
     Select @extCodError = "N"
     Select @extMensajeError = "TRX DENEGADA (EO:400374)"
     return 1 -
-// Intenta grabar un bono con fecha de emision distinta al día de hoy.
    end
  end

 Select @CodSucursal = convert(char(6),ltrim(rtrim(@extSucVenta)))

 Select @BonSucBon_ta = @CodSucursal

 create table #Cadenas
 (
  Indice    numeric(10,0) Identity,

  Cadena char(75)      not null,
  Procesado int               null
 )

 --// Interprete de Lista basado en posición de pipes y no por largo fijo.
 Select @extListaAUX = @extLista1
 while char_length(ltrim(rtrim(@extListaAUX))) > 30
  begin
   Select @var
Temp = ''
   Select @ct_pipe = 1
   while @ct_pipe <= 9
    begin
   Select @varTemp = ltrim(rtrim(@varTemp)) + substring(@extListaAUX,1,charindex('|',@extListaAUX))
     Select @extListaAUX = substring(@extListaAUX,charindex('|',@extListaAUX)+1,char_leng
th(@extListaAUX))
     Select @ct_pipe = @ct_pipe + 1
    end
   insert #Cadenas Select @varTemp, NULL
  end

 Select @extListaAUX = @extLista2
 while char_length(ltrim(rtrim(@extListaAUX))) > 30
  begin
   Select @varTemp = ''
   Select @ct_pipe = 1
   w
hile @ct_pipe <= 9
    begin
     Select @varTemp = ltrim(rtrim(@varTemp)) + substring(@extListaAUX,1,charindex('|',@extListaAUX))
     Select @extListaAUX = substring(@extListaAUX,charindex('|',@extListaAUX)+1,char_length(@extListaAUX))
     Select @ct_p
ipe = @ct_pipe + 1
    end
   insert #Cadenas Select @varTemp, NULL
  end

 --// Al finalizar la interpretación se tendra un tabla con cada línea de prestaciones diferenciada.
 --// en el siguiente paso, el string será descompuesto en sus partes integrant
es, y dejado en la tabla
 --// #DetallePrestaciones

 create table #DetallePrestaciones
 (
  Correlativo  numeric(9,0) identity,
  Prestacion   prestacion,
  Item         tinyint,
  Tipo         char(2),
  Homologo   char(15) NULL,
  Recargo      char(1),

  Cantidad     tinyint,
  Val_Pre      int,
  Val_Bon      int,
  Val_Cop      int,
  Val_Rend     int      null,
  GrupoCob     char(4)  null,
  ModalidadCon char(4)  null,
  TipoCalculo  regla    null
 )

 while exists(select 1 from #Cadenas where Proc
esado is null)
  begin

   set rowcount 1

   Select @varTemp = Cadena
   from   #Cadenas where  Procesado is null
 order by Indice

   Select @Prestacion    = substring(substring(@varTemp,1,charindex('|',@varTemp)-1),1,7)
   Select @Item          = conve
rt(tinyint,substring(substring(@varTemp,1,charindex('|',@varTemp)-1),8,3))
   Select @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp))

   Select @Tipo          = substring(@varTemp,1,charindex('|',@varTemp)-1)
   Select
 @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp))

   Select @Homologo      = ltrim(rtrim(substring(@varTemp,1,charindex('|',@varTemp)-1)))
   Select @varTemp    = substring(@varTemp,charindex('|',@varTemp)+1,char_lengt
h(@varTemp))
   if char_length(ltrim(rtrim(@Homologo))) <= 1 Select @Homologo = NULL

   Select @Recargo       = substring(@varTemp,1,charindex('|',@varTemp)-1)
   Select @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp))


   Select @Cantidad      = convert(tinyint,substring(@varTemp,1,charindex('|',@varTemp)-1))
   Select @varTemp    = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp))

   Select @Val_Pre       = convert(int,substring(@varTemp,1,charinde
x('|',@varTemp)-1))
   Select @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp))

   Select @Val_Bon       = convert(int,substring(@varTemp,1,charindex('|',@varTemp)-1))
   Select @varTemp       = substring(@varTemp,chari
ndex('|',@varTemp)+1,char_length(@varTemp))

   Select @Val_Cop       = convert(int,substring(@varTemp,1,charindex('|',@varTemp)-1))
   Select @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp))

   Select @InternoIsapre =
 NULL
   Select @GrupoCob      = NULL
   Select @ModalidadCon  = NULL
   Select @TipoCalculo   = NULL
   Select @Val_Rendicion = NULL

   --if char_length(ltrim(rtrim(substring(@varTemp,1,charindex('|',@varTemp)-1)))) = 1
   --if char_length(ltrim(rtrim(s
ubstring(@varTemp,1,15)))) = 1
   -- begin

     Select @InternoIsapre = substring(@varTemp,1,15) --charindex('|',@varTemp)-1)
     Select @varTemp       = substring(@varTemp,charindex('|',@varTemp)+1,char_length(@varTemp))

     Select @GrupoCob      = s
ubstring(@InternoIsapre,1,3)
     Select @ModalidadCon  = substring(@InternoIsapre,4,4)
     Select @TipoCalculo   = substring(@InternoIsapre,8,2)
     Select @Val_Rendicion = convert(int,substring(@InternoIsapre,10,6))

   --end

   if @InternoIsapre is 
NULL
    begin
     Select @extCodError = 'N'
     Select @extMensajeError = "TRX DENEGADA (EI:400320)"
    --//Select @extMensajeError = "TRX DENEGADA (EI:400320)"
     return 1 --//No Se Centro de Costo Operativo
    end

   update #Cadenas set Procesad
o = 1 where Procesado is null

   set rowcount 0

   insert #DetallePrestaciones
         (Prestacion, Item, Tipo, Homologo, Recargo, Cantidad, Val_Pre, Val_Bon,
          Val_Cop, GrupoCob, ModalidadCon, TipoCalculo)
   values (@Prestacion, @Item, @Tipo,
 @Homologo, @Recargo, @Cantidad, @Val_Pre, @Val_Bon,
      @Val_Cop, @GrupoCob, @ModalidadCon, @TipoCalculo)

 end

 Select @tot_Pre = sum(Val_Pre) From #DetallePrestaciones
 Select @tot_Bon = sum(Val_Bon) From #DetallePrestaciones
 Select @tot_Cop = sum(
Val_Cop) From #DetallePrestaciones

 if @extCodFinanciador = 74 Select @Marca = 'AS'
 if @extCodFinanciador = 78 Select @Marca = 'CB'

 --// Obtención de los datos de contrato del beneficiario.

 Select @RutBen = convert(int,substring(ltrim(rtrim(@extRutB
eneficiario)),1,
                              charindex('-',ltrim(rtrim(@extRutBeneficiario)))-1))

 create table #Beneficiarios
 (
  BenRutBen_nn    rut,
  BenMarCon_id    marca,
  BenIniVig_fc    fecha,
  BenTerVig_fc    fecha,
  BenApePat_ds    apelli
do,
  BenApeMat_ds    apellido,
  BenNom_ds       nombre,
  BenSex_fl       flag,
  BenFecNac_fc    fecha,
  BenNumCto_id    contrato,
  BenRutCot_id    rut,
  BenCorCar_id    char(2) null,
  BenTip_fl       char(1) null
 )

 insert  #Beneficiarios
 Selec
t  BenRutBen_nn, BenMarCon_id, BenIniVig_fc, BenTerVig_fc,
         BenApePat_ds, BenApeMat_ds, BenNom_ds,    BenSex_fl,
         BenFecNac_fc, BenNumCto_id, BenRutCot_id, BenCorCar_id,
         BenTip_fl
 from contrato..Beneficiario
 where BenRutBen_nn =
 @RutBen

 Select @NroContrato = BenNumCto_id,
        @cor_car     = BenCorCar_id
 from   #Beneficiarios
 where  BenRutBen_nn = @RutBen
   and  BenMarCon_id = @Marca
   and  BenIniVig_fc <= @HoyEllos
   and  BenTerVig_fc >= @HoyEllos

 drop table #Benefi
ciarios

 --// Los Bonos del Día serán grabados con Hora.
 if @Hoy = @HoyEllos Select @HoyEllos = @HoyHora

 Select @BonFolDoc_id = convert(int,@extFolioFinanciador)
 Select @BonFolAnt_cr = convert(char(12),@extFolioFinanciador)

 Select @BonRutCot_ta = c
onvert(int,substring(ltrim(rtrim(@extRutCotizante)),1,
               charindex('-',ltrim(rtrim(@extRutCotizante)))-1))

 Select @BonDigCot_ta = substring(ltrim(rtrim(@extRutCotizante)),
          charindex('-',ltrim(rtrim(@extRutCotizante)))+1,1)

 Selec
t @BonCcoVta_ta = '1',
        @BonCcoCom_ta = '1'

 --// Obtencion de los Datos particulares del contrato
 --// Versión del Contrato
 --// Numero de Colectivo
 --// Centro de Costo de Ventas
 --// Centro de Costo Comunal

 Select @BonVerCon_ta = ConVerVi
g_ta,
        @BonNumCol_ta = ConNumCol_nn,
        @BonCcoVta_ta = ConCenCos_ta,
        @BonCcoCom_ta = ConCcoLoc_ta
 from   contrato..Contrato
 Where  ConRutCot_id = @BonRutCot_ta
   and  ConMarCon_id = @Marca
   and  ConNumCto_id = @NroContrato

 Sele
ct @BonCcoOpe_ta = '1'
 exec @ErrorCode = parametro..Sel_CenCostoxSucursal @BonSucBon_ta, @BonCcoOpe_ta output

 if @ErrorCode != 0
  begin
   Select @extCodError = 'N'
   Select @extMensajeError = "TRX DENEGADA (EI:400321)"
   --//Select @extMensajeError
 = "TRX DENEGADA (EI:400321)"
   return 1 --//No Se Centro de Costo Operativo
  end

 --// Direccion de atención del convenio del bono.
 Select @BonDirCon_ta = convert(int,@extHomLugarConvenio)

 --// Nomina Generica del Convenio.
Select @BonCodNom_ta = C
onCodNom_ta
from   convenio..DireccionAtencion
       ,convenio..Convenio
where  DatCorDir_id = @BonDirCon_ta
  and  ConFolCon_id = DatFolCon_ta
  and  ConCorRen_id = DatCorRen_ta


 -- // PAQUETES ESTAN FUERA DE ESTA MODALIDAD POR DEFINICION.
 Select @Bo
nCodPae_ta = NULL

 -- // SON DISTINTAS PRESTACIONES EVENTUALMENTE DE "N" ESPECIALIDADES
 -- // POR ELLO ES DIFICIL DISCRIMINAR UNA UNICA ESPECIALIDAD. SE SUMIRÁ NULL
 Select @BonEspMed_ta = NULL

 --//VALIDACION DE EXISTENCIA DEL MEDICO TRATANTE O SOLICI
TANTE.
 --//
 --//REGLA DE NEGOCIO: * Si no hay solicitante o tratante no importa. el bono soporta nulos.
 --//                  * Tratante y Solicitante son mutuamente excluyentes.
 --//                  * De Venir un tratante éste debe estar asociado al
 prestador en convenio
 --//     de no ser asi, es causal de rechazo del servicio.
 --//                  * De venir un Solicitante. éste debe estar en la base de prestadores. sino lo ingreso
 --//                    con datos basicos. Si no pudo ser ingr
esado. rechazo el servicio.

 Select @BonRutMed_ta = NULL
 Select @BonDigMed_cr = NULL

 Select @RutCon = convert(int,substring(ltrim(rtrim(@extRutConvenio)),1,charindex('-',ltrim(rtrim(@extRutConvenio)))-1))

 if not ((@extRutTratante = '0000000000-0')or
(@extRutTratante is NULL)or(@extRutTratante = ''))
  Select @RutTra = convert(int,substring(ltrim(rtrim(@extRutTratante)),1,charindex('-',ltrim(rtrim(@extRutTratante)))-1))
 else
  Select @RutTra = NULL

 if not ((@extRutAsociado = '0000000000-0')or(@extR
utAsociado is NULL)or(@extRutAsociado = ''))
  Select @RutSol = convert(int,substring(ltrim(rtrim(@extRutAsociado)),1,charindex('-',ltrim(rtrim(@extRutAsociado)))-1))
 else
  Select @RutSol = NULL

 if @RutTra is NULL and @RutSol is NULL
  begin --//No vi
ene ninguno
   Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRutConvenio)),1,
                          charindex('-',ltrim(rtrim(@extRutConvenio)))-1))

   Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutConvenio)),
                   
       charindex('-',ltrim(rtrim(@extRutConvenio)))+1,1)
  end
 else
  begin
    if @RutTra is NULL and @RutSol is NOT NULL
     begin --// Viene Solo el tratante
       Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRutTratante)),1,
       
                       charindex('-',ltrim(rtrim(@extRutTratante)))-1))

       Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutTratante)),
                              charindex('-',ltrim(rtrim(@extRutTratante)))+1,1)
     end   --// Viene Solo el t
ratante
    else
     begin
      if @RutTra is Not NULL and @RutSol is NULL
       begin --// Viene Solo el Solicitante
         Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRutAsociado)),1,
                                charindex('-',l
trim(rtrim(@extRutAsociado)))-1))

         Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutAsociado)),
              charindex('-',ltrim(rtrim(@extRutAsociado)))+1,1)
       end   --// Viene Solo el Solicitante
      else
       begin
        if @Rut
Tra is Not NULL and @RutSol is not NULL
         begin --// Vienen AMBOS
           --//Tomo la primera prestacion que pille en funcion de esa se graba el tratante/solicitante
           set rowcount 1
           Select @CodCataPrest = Prestacion From   #
DetallePrestaciones
           set rowcount 0

   exec @ErrorCode = prestacion..INGCtrl_TratSol @Marca, @CodCataPrest, @AccionPresta output

           if @ErrorCode != 0
            begin
             Select @extCodError = 'N'
             Select @extMen
sajeError = 'TRX DENEGADA (EI:400377)'
     return 1
            end

           if @AccionPresta not in ('PR','AM')
            begin
             if @AccionPresta = 'TR'
              begin --// Tratante es Exigible
               Select @BonRutMed_ta =
 convert(int,substring(ltrim(rtrim(@extRutTratante)),1,charindex('-',ltrim(rtrim(@extRutTratante)))-1))

               Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutTratante)),
                                      charindex('-',ltrim(rtrim(@extRut
Tratante)))+1,1)
              end   --// Tratante es Exigible
             if @AccionPresta = 'SO'
              begin --// Solicitante es Exigible
               Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRutAsociado)),1,
             
                         charindex('-',ltrim(rtrim(@extRutAsociado)))-1))

               Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutAsociado)),
                                      charindex('-',ltrim(rtrim(@extRutAsociado)))+1,1)
             
 end   --// Solicitante es Exigible
         end
          else
            begin
             --// A la rutina le da lo mismo cual de los dos, por REGLA DE NEGOCIO el TRATANTE.
             Select @BonRutMed_ta = convert(int,substring(ltrim(rtrim(@extRut
Tratante)),1,charindex('-',ltrim(rtrim(@extRutTratante)))-1))

             Select @BonDigMed_cr = substring(ltrim(rtrim(@extRutTratante)),
                                    charindex('-',ltrim(rtrim(@extRutTratante)))+1,1)
            end
         end 
  --// Viene Solo el Solicitante
    end
     end
  end

 Select @BonRutPre_ta = convert(int,substring(ltrim(rtrim(@extRutConvenio)),1,
                        charindex('-',ltrim(rtrim(@extRutConvenio)))-1))

 Select @BonDigPre_cr = substring(ltrim(rtrim
(@extRutConvenio)),
           charindex('-',ltrim(rtrim(@extRutConvenio)))+1,1)

 Select @BonTotPre_$$ = convert(int,@extMontoValorTotal)

 Select @BonTotBon_$$ = convert(int,@extMontoAporteTotal)

 if @BonTotPre_$$ <> @tot_Pre
  begin
   Select @extCodE
rror = 'N'
   Select @extMensajeError = "TRX DENEGADA (EO:400322)"
--//   Select @extMensajeError = "TRX DENEGADA (EO:400322)"
   return 1
  end

 if @BonTotBon_$$ <> @tot_Bon
  begin
   Select @extCodError = 'N'
   Select @extMensajeError = "TRX DENEGADA
 (EO:400323)"
  --// Select @extMensajeError = "TRX DENEGADA (EO:400323)"
   return 1
  end

 -- // Los Atributos de Caja serán dejados nulos. por que no ha caja por parte de
 -- // compañía.
 Select  @BonDepCaj_ta = NULL, @BonCodCaj_ta = NULL, @BonHosCaj
_ta = NULL

 --// Los Atributos de Login deberén ser GENERICOS.
 Select  @BonLogAdm_ta = 'CSALUD00', @BonHosAdm_ta = 'C-SALUD01'

 --// Dado que no existiran instancias de autorizacion el login para ello
 --// permanecerá NULO.
 Select  @BonLogAut_ta = NU
LL

 --// Datos de quien retira el BONO.
 Select @BonRutRet_nn = convert(int,substring(ltrim(rtrim(@extRutBeneficiario)),1,
                        charindex('-',ltrim(rtrim(@extRutBeneficiario)))-1))
 Select @BonDigRet_cr = substring(ltrim(rtrim(@extRutB
eneficiario)),
                   charindex('-',ltrim(rtrim(@extRutBeneficiario)))+1,1)

 --// Estos Bonos Se GRABAN PAGADOS por ésta acción fue realizada donde el prestador.
 Select @BonEstDoc_re = 'P'

 --// El copago queda donde el prestador por lo tan
to NO recaudamos copago.
 Select @BonRecCop_re = 'S'

 --// El comprobante contable no se aplica en este momento. Idem Rendicion de Pago
 Select @BonComCon_nn = NULL,
      @BonRenPag_nn = NULL

 --// El Origen de Atención es siempre ambulatorio.
 --// El
 tipo de Bono Debe ser definido por ahora se usará 'T' Telefonico
 Select  @BonTipBon_re = 'E',
         @BonOriAte_re = 'AM'

 --// NO HAY MEDICO DE CABECERA
 Select @BonRutMca_ta = NULL,
        @BonDigMca_cr = NULL

 --// REGLA DE NEGOCIO IMED
 --// --
--------------
 --// Monto por Rendir es equivalente a Valor Prestacion, salvo  que en el
 --// parametro de entrada Interno isapre, venga un valor > 0, lo que indica
 --// que existe alguna otra regla, que ha modificado el monto a rendir, y este
 --// ul
timo valor es el que deberá prevalecer.

 Select @BonTotRen_$$ = @BonTotPre_$$
 if @Val_Rendicion > 0 Select @BonTotRen_$$ = @Val_Rendicion

 --// Los Siguientes atributos deberan ser insertados NULOS
 Select @BonFecDev_fc = NULL,
        @BonSucDev_ta = 
NULL,
        @BonLogDev_ta = NULL,
        @BonFecRen_fc = NULL,
        @BonComDev_nn = NULL,
        @BonFecMan_fc = NULL

 --// El Folio No debe Estar (UT)ilizado o (NU)lo en la Tabla de Control de Folios
 if  (Select LcfEstUso_re From   prestacion..L
og_Control_Folios
      where  LcfFolEnt_id = @BonFolDoc_id
        and  LcfMarFol_id = @Marca
        and  LcfTipDoc_id = 'BO')  <> 'SO'
  begin
   Select @extCodError = 'N'
   Select @extMensajeError = "TRX DENEGADA (EO:400324)"
--//   Select @extMensaj
eError = "TRX DENEGADA (EO:400324)"
   return 1
  end

 begin tran

 insert into prestacion..Bono (BonMarBon_id,  BonFolDoc_id,  BonFolAnt_cr,  BonFecEmi_fc,
                               BonRutCot_ta,  BonDigCot_cr,  BonNumCto_ta,  BonCorCar_ta,
       
  BonCodPla_ta,  BonVerCon_ta,  BonDirCon_ta,  BonCodNom_ta,
                               BonCodPae_ta,  BonEspMed_ta,  BonNumCol_ta,  BonRutMed_ta,
   BonDigMed_cr,  BonRutPre_ta,  BonDigPre_cr,  BonTotPre_$$,
                               BonTotBon_$
$,  BonSucBon_ta,  BonDepCaj_ta,  BonCodCaj_ta,
                               BonHosCaj_ta,  BonLogAdm_ta,  BonHosAdm_ta,  BonLogAut_ta,
                  BonRutRet_nn,  BonDigRet_cr,  BonEstDoc_re,  BonRecCop_fl,
                               BonComCon
_nn,  BonRenPag_nn,  BonTipBon_re,  BonOriAte_re,
                               BonCcoOpe_ta,  BonCcoVta_ta,  BonCcoCom_ta,  BonRutMca_ta,
                               BonDigMca_cr,  BonTotRen_$$,  BonFecDev_fc,  BonSucDev_ta,
             BonLogDev_ta
,  BonFecRen_fc,  BonComDev_nn,  BonFecMan_fc)
             values           (@Marca,        @BonFolDoc_id, @BonFolAnt_cr, @HoyEllos,
                               @BonRutCot_ta, @BonDigCot_ta, @NroContrato,  @cor_car,
                    @extPlan,      
@BonVerCon_ta, @BonDirCon_ta, @BonCodNom_ta,
                               @BonCodPae_ta, @BonEspMed_ta, @BonNumCol_ta, @BonRutMed_ta,
                               @BonDigMed_cr, @BonRutPre_ta, @BonDigPre_cr, @BonTotPre_$$,
                            
   @BonTotBon_$$, @BonSucBon_ta, @BonDepCaj_ta, @BonCodCaj_ta,
                               @BonHosCaj_ta, @BonLogAdm_ta, @BonHosAdm_ta, @BonLogAut_ta,
                               @BonRutRet_nn, @BonDigRet_cr, @BonEstDoc_re, @BonRecCop_re,
          
                     @BonComCon_nn, @BonRenPag_nn, @BonTipBon_re, @BonOriAte_re,
  @BonCcoOpe_ta, @BonCcoVta_ta, @BonCcoCom_ta, @BonRutMca_ta,
                               @BonDigMca_cr, @BonTotRen_$$, @BonFecDev_fc, @BonSucDev_ta,
                     
          @BonLogDev_ta, @BonFecRen_fc, @BonComDev_nn, @BonFecMan_fc)

 if @@error != 0
  begin
   rollback tran
   Select @extCodError = 'N'
   Select @extMensajeError = "TRX DENEGADA (EI:400325)"
   --//Select @extMensajeError = "TRX DENEGADA (EI:400325
)"
   return 1
  end

 commit tran

 Select @BorraCabeDeta = 0

 Select @MinCorr = min(Correlativo) From #DetallePrestaciones

 Select @MaxCorr = max(Correlativo) From #DetallePrestaciones

 While @MinCorr <= @MaxCorr
  begin

   Select @DboFolDoc_id = @B
onFolDoc_id,
          @DboMarBon_id = @Marca,
          @DboCorBon_id = Correlativo,
          @DboGruCob_id = convert(char(3),convert(smallint,GrupoCob)),
          @DboCodPre_ta = Prestacion,
          @DboCodIte_ta = Item,
          @DboModCob_ta = Mo
dalidadCon,
          @DboCanAte_nn = Cantidad,
          @DboTipAte_re = 'AM',
          @DboMonPre_$$ = Val_Pre,
          @DboMonBon_$$ = Val_Bon,
          @DboPorBon_nn = convert(numeric(5,2),((Val_Bon / Val_Pre) * 100.0)),
          @DboTipCal_re = 
TipoCalculo,
          @DboPorRec_nn = 0,
          @DboValRen_$$ = Val_Bon,
         @DboMtoOcr_$$ = 0
   From   #DetallePrestaciones
   where  Correlativo = @MinCorr

   begin tran

   insert into prestacion..DetaBono (DboFolDoc_id, DboMarBon_id, DboCor
Bon_id, DboGruCob_id, DboCodPre_ta,
                                    DboCodIte_ta, DboModCob_ta, DboCanAte_nn, DboTipAte_re, DboMonPre_$$,
                                    DboMonBon_$$, DboPorBon_nn, DboTipCal_re, DboPorRec_nn, DboValRen_$$,
       
                             DboMtoOcr_$$)
   values      (@DboFolDoc_id, @DboMarBon_id, @DboCorBon_id, @DboGruCob_id, @DboCodPre_ta,
                @DboCodIte_ta, @DboModCob_ta, @DboCanAte_nn, @DboTipAte_re, @DboMonPre_$$,
                @DboMonBon_$$,
 @DboPorBon_nn, @DboTipCal_re, @DboPorRec_nn, @DboValRen_$$,
                @DboMtoOcr_$$)

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
   where  BonMarBon_id 
= @Marca
     and  BonFolDoc_id = @BonFolDoc_id

   Select @extCodError = "N"
 Select @extMensajeError = "TRX DENEGADA (EI:400326)"
--//   Select @extMensajeError = "TRX DENEGADA (EI:400326)"
 select @Fin=convert(char(26),getdate(),109)
 insert Tiempos va
lues("P9",@Ini,@Fin)

   return 1 --//No Se Centro de Costo Operativo
  end

 exec @ErrorCode = finanza..ActualizaTope @BonFolDoc_id, 'I', @Marca, 'B'

 if @ErrorCode != 0
  begin
   delete prestacion..DetaBono
   where DboFolDoc_id = @BonFolDoc_id
     a
nd  DboMarBon_id = @Marca

   delete prestacion..Bono
   where  BonMarBon_id = @Marca
     and  BonFolDoc_id = @BonFolDoc_id

   Select @extCodError = "N"
   Select @extMensajeError = "TRX DENEGADA (EI:400327)"
--//   Select @extMensajeError = "TRX DENEGA
DA (EI:400327)"
   select @Fin=convert(char(26),getdate(),109)
 insert Tiempos values("P9",@Ini,@Fin)

   return 1 --//No Se Centro de Costo Operativo
  end

 --// ACtualizacion de log Control de Folios.
 begin tran

 Update prestacion..Log_Control_Folios

    set LcfFecUso_fc = getdate(),
        LcfEstUso_re = 'UT',
        LcfCodDia_cr = @extCodigoDiagnostico,
        LcfRutEmi_nn = convert(int,substring(ltrim(rtrim(@extRutEmisor)),1,
                       charindex('-',ltrim(rtrim(@extRutEmisor)))-1))
,
        LcfDigEmi_cr = substring(ltrim(rtrim(@extRutEmisor)),
                       charindex('-',ltrim(rtrim(@extRutEmisor)))+1,1),
        LcfRutCaj_nn = convert(int,substring(ltrim(rtrim(@extRutCajero)),1,
                charindex('-',ltrim(rtrim(@
extRutCajero)))-1)),
        LcfDigCaj_cr = substring(ltrim(rtrim(@extRutCajero)),
                       charindex('-',ltrim(rtrim(@extRutCajero)))+1,1)
 where  LcfFolEnt_id = @BonFolDoc_id
   and  LcfMarFol_id = @Marca
   and  LcfTipDoc_id = 'BO'

 Sele
ct @ErrorCode = @@error

 if @ErrorCode != 0
  begin

   delete prestacion..DetaBono
   where  DboFolDoc_id = @BonFolDoc_id
     and  DboMarBon_id = @Marca

   delete prestacion..Bono
   where  BonMarBon_id = @Marca
     and  BonFolDoc_id = @BonFolDoc_id


   Select @extCodError = "N"
   Select @extMensajeError = "TRX DENEGADA (EI:400328)"
--//   Select @extMensajeError = "TRX DENEGADA (EI:400328)"
   select @Fin=convert(char(26),getdate(),109)
   insert Tiempos values("P9",@Ini,@Fin)

   return 1 --//No S
e Centro de Costo Operativo
  end

 if @ErrorCode = 0 commit tran

 Select @extCodError = "S"
 Select @extMensajeError = ""

 select @Fin=convert(char(26),getdate(),109)
 insert Tiempos values("P9",@Ini,@Fin)

 return 1

end 
                             
(122 rows affected)
(return status = 0)
1> 