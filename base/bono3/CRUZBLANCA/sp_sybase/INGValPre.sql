locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
504
(1 row affected)
text

Create Procedure dbo.INGValPre
( 
 @extCodFinanciador     smallint, 
 @extHomNumeroConvenio  char(15), 
 @extHomLugarConvenio   char(10), 
 @extSucVenta           char(10), 
 @extRutConvenio        char(12), 
 @extRutTratante        char(12), 
 @extEspec
ialidad       char(10),
 @extRutSolicitante     char(12), 
 @extRutBeneficiario    char(12), 
 @extTratamiento        char(1), 
 @extCodigoDiagnostico  char(10), 
 @extNivelConvenio      tinyint, 
 @extUrgencia           char(1), 
 @extCanastaCabecera    
char(15),
 @extLista1             char(255), 
 @extLista2             char(255), 
 @extLista3             char(255), 
 @extLista4             char(255), 
 @extLista5             char(255), 
 @extLista6             char(255), 
 @extLista7             char(
255),
 @extLista8             char(255), 
 @extLista9             char(255), 
 @extLista10            char(255), 
 @extLista11            char(255), 
 @extLista12            char(255), 
 @extLista13            char(255),
 @extVarImed            char(255),

 @extNumPrestaciones    tinyint, 
 @extCodError           char(1)    output, 
 @extMensajeError       char(30)   output, 
 @extPlan              char(15)    output
) 
/* 
  -- ** ---------------------------------------------------------------------------
---------- 
   Creado por  : Marcelo Herrera 
   Creado el   : Mayo de 2011
   Referencia  : FR-3622. En base a servicio INGValorVari se crea nuevo servicio INGValPre.
                 Permitira manejar solicitudes de valorizacion/bonificacion para presta
ciones
                 bajo atencion GES.


   Modificado por : Heidi Monterrichard
   Fecha          : Noviembre 2014
   Objetiv        : Debido a que se esta permitido mnodificar la fecha de termino de vigencia de una canasta (Circular 231),Ya no se co
nsiderara para evaluar vigencias el campo GevEstAut_id 
                    La vigencia se controlara evaluando la fecha de termino que no tan solo sea null sino que tambien sea mayor o igual al dia actual.


  -- ** --------------------------------------
----------------------------------------------- 

   Parametros I 
       @extCodFinanciador     : Codigo del Financiador 
       @extHomNumeroConvenio  : Homologo numero de convenio (11c para Codigo+'-'+ 3c para corr renov) 
       @extHomLugarConvenio  
 : Homologo Lugar de convenio (Corr. Direccion) 
       @extSucVenta           : Homologo Sucursal de Venta (codigo Sucursal) 
       @extRutConvenio        : Rut Convenio, R.u.t. del prestador en convenio 
       @extRutTratante        : Rut Tratante, R.
u.t. del medico tratante o solicitante de examenes. 
       @extRutSolicitante     : Rut Solicitante, R.u.t. de quien solicita el beneficio. 
       @extRutBeneficiario    : RUT del Beneficiario 
       @extTratamiento        : Tratamiento m�dico ('S','N'
) 
       @extCodigoDiagnostico  : Codigo de Diagnostico, seg�n CIE 10 
       @extNivelConvenio      : nivel convenido con el prestador 1,2,3 
       @extUrgencia           : servicio de urgencia: 'N', 'S'
       @extCanastaCabecera    : codigo de canast
a, cuando se informa GES
       @extLista1             : lista de prestaciones 
                                10c para la Prestacion (7c Cod.Prestacion 3c para Item) 
                                1c pipe (|) 
                                2c para e
l tipo de item (H:Honorario, P:Pabellon) 
                                1c pipe (|) 
                                15c Codigo Adicional, 
                                1c pipe (|) 
                                1c para el recargo hora (S:Si, N:No)
 
                                1c pipe (|) 
                                2c para la cantidad 
                                1c pipe (|) 
                                12c para el valor Total
                                1c pipe (|)
          
                      15c para Codigo Prestador
                                1c pipe (|)
                                2c para item Prestador
                                1c pipe (|)
                                15c para Interno IMED
          
                      1 pipe (|)
       @extLista2 
       hasta @extLista13      : Idem Lista1, 
       @extVarImed            : valores internos de IMED
       @extNumPrestaciones    : Numero de Prestaciones enviadas en este acto de 
                   
             ventas. 
 
   Parametros O 
       @extCodError        : Codigo de Error ('S','N') 
                             S = estador exitoso de la transaccion 
                             N = fallo o error en transaccion 
       @extMensajeError    
: Mensaje de Error. 
       @extPlan            : Plan con el cual se Bonificar�. 
 
   ------------------------ 
   |Servicios para C-Salud | 
   ------------------------ 
 
 Descripcion 
 
   Este Servicio que envia datos de todas las l�neas de prestaci
ones 
   al financiador; el que calcula cual es el valor de cada prestacion 
   y cuanto le corresponde al beneficiario 
 
 ejemplo de llamada (1 prestacion normal):
declare 
 @extCodError    char(1), 
 @extMensajeError  char(30), 
 @extPlan         char(
20)

  exec prestacion..INGValPre
       78, '52119-0', '83825','130600', '76016305-8','0076016305-8', '', '0012259049-6','0013486200-9', 
      'N','XXXXXXXXXX',0,'N','', '0405001000|  |0405001000     |N|01|000000000000|               |  |               
|',
      '','','','','','','','','','','','','',1, 
      @extCodError out, @extMensajeError out, @extPlan out 

ejemplo de llamada (3 prestaciones normales):
declare 
 @extCodError    char(1), 
 @extMensajeError  char(30), 
 @extPlan         char(20)

 
 exec prestacion..INGValPre
       78, '37963-0', '65657','130600', '60910000-1','60910000-1', '', '0008925715-8','0010710346-5', 
      'N','XXXXXXXXXX',0,'N','', 
      '0101840000|  |0101100        |N|01|000000000000|               |  |               |
0306011000|  |0306011        |S|01|000000000000|               |  |               |',
      '0309022000|  |0309022        |S|01|000000000000|               |  |               |',
      '','','','','','','','','','','','',3, 
      @extCodError out, @extMe
nsajeError out, @extPlan out 
      
ejemplo de llamada (3 prestaciones GES):
declare 
 @extCodError    char(1), 
 @extMensajeError  char(30), 
 @extPlan         char(20)

  exec prestacion..INGValPre
       78, '45940-0', '75600','130600', '96942400-2','
0096942400-2', '', '0000000000-0','004684532-3', 
      'N','XXXXXXXXXX',0,'N','', 
      '0309022000|  |0309022        |N|01|000000000000|               |  |21T003-00      |0302047000|  |0302047        |N|01|000000000000|               |  |21T003-00     
 |',
      '0302034000|  |0302034        |N|01|000000000000|               |  |21T003-00      |',
      '','','','','','','','','','','','',3, 
      @extCodError out, @extMensajeError out, @extPlan out 
      
ejemplo de llamada (3 prestaciones GES y 2 p
restaciones Normales):
declare 
 @extCodError    char(1), 
 @extMensajeError  char(30), 
 @extPlan         char(20)

  exec prestacion..INGValPre
       78, '45940-0', '75600','130600', '96942400-2','0096942400-2', '', '0000000000-0','004684532-3', 
     
 'N','XXXXXXXXXX',0,'N','21T003-00', 
      '0309022000|  |0309022        |N|01|000000000000|               |  |21T003-00      |0302047000|  |0302047        |N|01|000000000000|               |  |21T003-00      |',
      '0302034000|  |0302034        |N|01
|000000000000|               |  |21T003-00      |',
      '0101840000|  |0101100        |N|01|000000000000|               |  |               |0306011000|  |0306011        |S|01|000000000000|               |  |               |',
      '','','','','','','',
'','','','',5, 
      @extCodError out, @extMensajeError out, @extPlan out 
 -- ** ----------------------------------------------------------------------------------------- 
*/ 
As 
declare 
         @Folio           int ,
         @FecHorTrx       fecha,

         @db_name         char(30), 
         @Hoy             fecha,
         @HoyMasUno       fecha,
         @ErrorExec             int,          
         @ErrorCode             int, 
         @ValorUF               numeric(10,2), 
         @Marca   
              marca, 
         @NroContrato           contrato, 
         @Ok                    flag, 
         
         --para para parametros de entrada
         @CodSucursal           sucursal, 
         @RutCon                rut, 
         @RutTra 
               rut, 
         @RutSol                rut, 
         @RutBen                rut, 
         @FolCon                int, 
         @CorRen                tinyint, 
         @CorDir                int, 
         @RutCte                rut, 
  
       @cor_car               char(2), 
         @tipo_carga            char(1), 

         @vliRutConReal         rut, --rut del convenio efectivo, cuando se trata de un facturador
         @vlcCodCanasta         char(20),  --canasta GES
         
/* no 
validado el uso */


         @certifApellidoPat        char(30), 
         @certifApellidoMat        char(30), 
         @certifNombres            char(40), 
         @certifSexo               char(1) , 
         @certifFechaNacimi        fecha, 
       
  @certifCodEstBen          char(1) , 
         @certifDescEstado         char(15), 
         @certifRutCotizante       char(12), 
         @certifNomCotizante       char(40), 
         @certifDirPaciente        char(40), 
         @certifGloseComuna     
   char(30), 
         @certifGloseCiudad        char(30), 
         @certifPrevision          char(1), 
         @certifGlosa              char(40), 
         @certifDescuentoxPlanilla char(1) , 
         @certifMontoExcedente     int, 
         @certifR
utAcompananate    char(12), 
         @certifNombreAcompanante  char(40), 
 

 
         @FolConAlter           int, 
         @CorRenAlter           tinyint, 
         @TotConAlter           int, 
 
         @Cuenta_Lista          tinyint, 
         @Tot
al_Listas          tinyint, 
 
         @extListaAUX           char(255), 
         @extListaX             char(255), 
         @MinValor              numeric(10,5), 
         @MaxValor              numeric(10,5), 
 
         @CodPrestacion         presta
cion, 
         @varCadena             char(83), 
         @TipoItem              char(2), 
         @HomologoPrestador     char(20), 
         @AfectoRecargo         char(1), 
         @ValorDesde            numeric(14,4), 
         @ValorHasta          
  numeric(14,4), 
         @Item                  tinyint, 
         @CodEsp                char(3), 
         @CantAte               tinyint, 
         @ValorNomina           smallint, 
         @Modalidad             char(2), 

 
         @RecalculoRegi
men      char(1), 
         @Indice                numeric(5,0), 
         @Homologo              char(20), 
         @AccionPresta          regla, 
         @CostoCero             char(2), 
         @ItemReal              tinyint, 
         @OrigenAtenci
on        char(1), 
         @CodReg                tinyint, 
         @Urgencia              char(1), 
         @Recargo               char(1), 
         @Combinatoria          char(50), 
         @Combinatoria2         char(50), 
         @Combinatoria3
         char(50), 
         @CodPrest              prestacion, 
         @CodItem               tinyint, 
         @CodHomo               char(20), 
         @ModVal                regla, 
         @TipReg                tinyint, 
         @CopagoFijo   
         int, 
         @ValAra                numeric(10,2), 
         @TotalFilas            int, 
         @NominaPaquete         smallint, 
         @out_CodNom            smallint, 
         @out_CodPrest          prestacion, 
         @out_CodItem  
         tinyint, 
         @out_CodReg            tinyint, 
         @out_CodHomo           char(20), 
         @out_Desde             numeric(14,4), 
         @out_Hasta             numeric(14,4), 
         @out_Modalidad         regla, 
         @out_C
oPagoFijo        integer, 
         @out_ErrorCode         int, 
         @out_Metodo            char(2), 
 
         @PorceRecargo          numeric(7,4), 
         @Colectivo             int, 
         @GruCob                char(4), 
         @CodLoc   
             localidad, 
         @CobCodPla_id          codpla, 
         @CobModCob_id          Char(4), 
         @CobGruCob_id          Char(4), 
         @CobCodNom_ta          Smallint, 
         @CobPorBon_nn          Numeric(5,2), 
         @CobMo
nTop_nn          Numeric(11,2), 
         @CobModTop_re          modal, 
         @CobMonTopCon_nn       Numeric(11,2), 
         @CobModTopCon_re       char(4), 
         @CobRanCob_nn          Numeric(11,2), 
         @CobMonCop_nn          Numeric(11,2
), 
         @CobModCop_re          char(4), 
         @CobNivPpo_nn          Tinyint, 
         @PlaModRef_re          regla, 
         @PlaCobInt_nn          Numeric(11,2), 
         @PlaTopBac_nn          Numeric(11,2), 
         @PlaBasAcm_nn         
 Numeric(11,2), 
         @PlaBonGan_fl          Char(1), 
         @PlaPorFac_nn          Tinyint, 
         @GtaMaxBga_nn          numeric(5,2), 
         @BenEspAplicados       char(250), 
         @boni_pend             numeric(11,2), 
         @por_b
oni              numeric(5,2), 
         @mto_boni              numeric(11,2), 
         @copago                numeric(11,2), 
         @mto_presta            numeric(11,2), 
         @operacion             char(2), 
         @mensaje               char(
120), 
         @tiene_tope            flag, 
         @fec_ini_veg           fecha, 
         @DigCon                dv, 
         @DigBen                dv, 
         @RutCot                rut, 
         @DigCot                dv , 
         @Corr_logC
ontrol       int, 
 
         @DescSocAlemana        int, 
         @EsSocioAlemana        char(1), 
         @mto_boniReal          int, 
         @copagoReal            int, 
         @mto_prestaReal        int, 
         @DescEnPesos           int , --
//numeric(5,2), 
         @ValorPrestacion       int, 
         @AporteFinanciador     int, 
 
         @PlanAlternativo    char(15), 
         @CodCataPrest          prestacion, 
         @cod_error             int, 
 
         @TotalPrest            int
, 
 
         @RenExe_fl             flag, 
         @REDCodPla_id          codpla, 
         @REDModCob_id          Char(4), 
         @REDGruCob_id          Char(4), 
         @REDCodNom_ta          Smallint, 
         @REDPorBon_nn          Numeric(5,2
), 
         @REDMonTop_nn          Numeric(10,2), 
         @REDModTop_re          modal, 
         @REDMonTopCon_nn       Numeric(10,2), 
         @REDModTopCon_re       modal, 
         @REDRanCob_nn          Smallint, 
         @REDMonCop_nn          
Numeric(10,2), 
         @REDModCop_re          modal, 
         @REDNivPpo_nn          Tinyint, 
         @REDModRef_re          regla, 
         @REDCobInt_nn          Numeric(11,2), 
         @REDTopBac_nn          Smallint, 
         @REDBasAcm_nn    
      Smallint, 
         @REDBonGan_fl          Char(1), 
         @REDPorFac_nn          Tinyint, 
         @REDMaxBga_nn          Smallint, 
 
         @BuscaPorcentaje       bit, --// 0: NO Busque, 1: SI Busque 
         @Porc_RecPqte          numeric
(7,4), 
         @Cod_Paquete           int, 
         @Cod_PaqueteHijo       int, 
         @Cod_HomoPaquete       char(15), 
         @DigMed_cr             dv, 


         @Cod_PresPaquete       prestacion, 
         @Cod_ItemPaquete       tinyint, 
  
       @Can_PretPaquete       tinyint, 

         @TotalPrestPqte        int, 
         @TotalPrestPqteMatch   int, 
 
         @CobPerTop_fl    flag, 
         @CobAmpGui_fl    flag , 
         @CobPorTop_nn    numeric(5,2), 
         @CobFacEqi_nn    nu
meric(5,2), 
         @Cambia_Linea    flag, 
         @guindas         Char(250), 
         @CobPerOUT_fl    flag, 
         @CobAmpOUT_fl    flag, 
         @CobPorOUT_nn    numeric(5,2), 
         @CobFacOUT_nn    numeric(5,2), 
         @ValAraCal_nn 
   numeric(11,2), 
         @ModAraCal_cr    char(2), 
         @MntoTopeCto     char(20), 
         @MntoTopeEve     char(20), 
         @MntoTopeInt     char(20), 
         @EdadCARGA       int, 
         @SexoCARGA       flag, 
         @CuentaPlanes  
  int, 
         @PreVigMin       int, 
         @PreVigMax       int, 
         @IniVig          fecha, 
         @PreModVig       regla, 
         @ModVig          regla, 
         @TmpoVig         int, 
         @TerVig          fecha, 
         @VigMi
n          int, 
         @VigMax          int, 
         @ResVig          flag, 
         @FecNac          fecha, 
         @EdadMin         int, 
         @EdadMax         int, 
         @ModEda          regla, 
         @ResEdad         flag, 

       
  @MntRefPre       int ,      -- FR 33137, monto referencia prestacion 
         @vlcModCob       char(2),   -- FR 2393 modalidad de cobertura
         @vliAplRes       int,        --resultado de verificar si existe/aplica restriccion (1/0 corresponden a 
Si/No)
         @vliValPre       int,        --si se debe validar por prestacion (1/0 corresponde a Si/No)
         @vlcForCob       char(2)    --cobertura forzada

 --estado de flag para registrar resultado del servicio
 declare @vliFlagResultado int, @V
alAtr char(255)
 
 --para controlar la bonificacion
 declare @AplicaPlanAlternativo int, @PlanBonificacion char(10)
 
 --para manejo de la lista de prestaciones
 declare @vliTotalPrestador int, @vlcPrestacionPrestador char(15), @vlcItemPrestador char(2), 
@vlcInternoImed char(15), @ErrorGlosa char(50),
         @vliCadena int, @vlcClasiPresta char(2)
 
 --para verificacion de Copago fijo
 declare @vlcAplCop       char(1),    --flag(S/N) si aplica regla de copago fijo
         @vliMtoBon_GCP   int,        -
-nuevo monto de bonificacion (regla de copago fijo)
         @vliMtoCop_GCP   int         --nuevo monto de copago (regla de copago fijo)
 --para verificacion de vigencia
 declare @vliStaPre int, @vliStaCon int, @vliStaLat int , @vliStaIme int
 -- para det
erminacion de modalidad de valorizacion
 declare @vlcTipMod  char(2), @vliFolMva  int, @vliFolMvaAux int, @vlcValSel char(20), 
         @vliFolMvaDental int,     --modalidad Dental, se debe forzar
         @vliForMvaLE  int,        --modalidad libre elec
cion forzada
         @vliFolMvaGes int         --modalidad valorizacion GES
 --fr 1726 manejo de colectivos
 declare @vlcPlanColectivo codpla
 --para uso de GES
 declare @vliCorRenCanasta int, @vliNumPro int, @vlcCodEta char(2), @vlcPerUso char(2),
     
    @vliFolEveGes int, @vlnDedGesAplicado numeric(8,2), @vlnGastoDedGesUF numeric(8,2),
         @vlnGesAplIsapre numeric(8,2), @vlnGesValorUF numeric(10,2), @vldGesFecCob fecha, @vliCopCanasta int, 
         @vlnGesDedCta numeric(8,2), @vlnGesDedCaso num
eric(8,2), @vlnGesCtaCto numeric(8,2), @vlnGesDedCto numeric(8,2)
         
 
begin 
   Select @db_name = db_name() 
   
   begin tran 
   
   update prestacion..ContadorFolio 
   set CfoNumFol_nn = CfoNumFol_nn - 1 
   where CfoCodMar_id = 'IN' 
     And
 CfoTipDoc_fl = 'LECT' 
   
   Select @Folio = CfoNumFol_nn 
   From   prestacion..ContadorFolio 
   where  CfoCodMar_id = 'IN' 
     and  CfoTipDoc_fl = 'LECT' 
   
   Set @FecHorTrx = getdate()
   commit tran 
   
   begin tran uno 
   
   insert Log_En
tCabValPre
          (ext_CabNroTrx, ext_FechaHoraTrx, extCodFinanciador, extHomNumeroConvenio, extHomLugarConvenio,
           extSucVenta, extRutConvenio, extRutTratante, extEspecialidad, extRutSolicitante, extRutBeneficiario,
           extTratamiento,
 extCodigoDiagnostico, extNivelConvenio, extUrgencia, extCanastaCabecera, extVarIMED,
           extNumPrestaciones) 
   values  (@Folio, @FecHorTrx, @extCodFinanciador, @extHomNumeroConvenio, @extHomLugarConvenio, 
            @extSucVenta, @extRutConven
io, @extRutTratante, @extEspecialidad, @extRutSolicitante, @extRutBeneficiario, 
            @extTratamiento, @extCodigoDiagnostico, @extNivelConvenio, @extUrgencia, @extCanastaCabecera, @extVarImed,
            @extNumPrestaciones) 
   
   if @@error != 
0 
   begin 
      rollback tran uno 
      Select @extCodError = 'N', @extMensajeError = 'Error al registrar Cab de Log'
      return 1 
   end 
   
   if char_length(rtrim(ltrim(@extLista1))) > 0 
   begin 
      insert prestacion..Log_EntDetValPre (ext
_DetNroTrx, ext_FechaHoraTrx, ext_CorTrxLista, ext_Lista) values (@Folio, @FecHorTrx, 1, @extLista1) 
      if @@error != 0 
      begin 
         rollback tran uno 
         Select @extCodError = 'N', @extMensajeError = 'Error al registrar Det de Log'
  
       return 1 
      end
   end
   if char_length(rtrim(ltrim(@extLista2))) > 0
   begin
      insert prestacion..Log_EntDetValPre (ext_DetNroTrx, ext_FechaHoraTrx, ext_CorTrxLista, ext_Lista) values (@Folio, @FecHorTrx, 2, @extLista2) 
      if @@error
 != 0 
      begin 
         rollback tran uno 
         Select @extCodError = 'N', @extMensajeError = 'Error al registrar Det de Log'
         return 1 
      end
   end
   if char_length(rtrim(ltrim(@extLista3))) > 0 
   begin
      insert prestacion..L
og_EntDetValPre (ext_DetNroTrx, ext_FechaHoraTrx, ext_CorTrxLista, ext_Lista) values (@Folio, @FecHorTrx, 3, @extLista3) 
      if @@error != 0 
      begin 
         rollback tran uno 
         Select @extCodError = 'N', @extMensajeError = 'Error al regi
strar Det de Log'
         return 1 
      end
   end
   if char_length(rtrim(ltrim(@extLista4))) > 0 
   begin
      insert prestacion..Log_EntDetValPre (ext_DetNroTrx, ext_FechaHoraTrx, ext_CorTrxLista, ext_Lista) values (@Folio, @FecHorTrx, 4, @extList
a4) 
      if @@error != 0 
      begin 
         rollback tran uno 
         Select @extCodError = 'N', @extMensajeError = 'Error al registrar Det de Log'
         return 1 
      end
   end
   if char_length(rtrim(ltrim(@extLista5))) > 0 
   begin
     
 insert prestacion..Log_EntDetValPre (ext_DetNroTrx, ext_FechaHoraTrx, ext_CorTrxLista, ext_Lista) values (@Folio, @FecHorTrx, 5, @extLista5) 
      if @@error != 0 
      begin 
         rollback tran uno 
         Select @extCodError = 'N', @extMensajeE
rror = 'Error al registrar Det de Log'
         return 1 
      end
   end
   if char_length(rtrim(ltrim(@extLista6))) > 0 
   begin
      insert prestacion..Log_EntDetValPre (ext_DetNroTrx, ext_FechaHoraTrx, ext_CorTrxLista, ext_Lista) values (@Folio, @F
ecHorTrx, 6, @extLista6) 
      if @@error != 0 
      begin 
         rollback tran uno 
         Select @extCodError = 'N', @extMensajeError = 'Error al registrar Det de Log'
         return 1 
      end
   end
   if char_length(rtrim(ltrim(@extLista7))
) > 0 
   begin
      insert prestacion..Log_EntDetValPre (ext_DetNroTrx, ext_FechaHoraTrx, ext_CorTrxLista, ext_Lista) values (@Folio, @FecHorTrx, 7, @extLista7) 
      if @@error != 0 
      begin 
         rollback tran uno 
         Select @extCodErro
r = 'N', @extMensajeError = 'Error al registrar Det de Log'
         return 1 
      end
   end
   if char_length(rtrim(ltrim(@extLista8))) > 0 
   begin
      insert prestacion..Log_EntDetValPre (ext_DetNroTrx, ext_FechaHoraTrx, ext_CorTrxLista, ext_List
a) values (@Folio, @FecHorTrx, 8, @extLista8) 
      if @@error != 0 
      begin 
         rollback tran uno 
         Select @extCodError = 'N', @extMensajeError = 'Error al registrar Det de Log'
         return 1 
      end
   end
   if char_length(rtr
im(ltrim(@extLista9))) > 0 
   begin
      insert prestacion..Log_EntDetValPre (ext_DetNroTrx, ext_FechaHoraTrx, ext_CorTrxLista, ext_Lista) values (@Folio, @FecHorTrx, 9, @extLista9) 
      if @@error != 0 
      begin 
         rollback tran uno 
      
   Select @extCodError = 'N', @extMensajeError = 'Error al registrar Det de Log'
         return 1 
      end
   end
   if char_length(rtrim(ltrim(@extLista10))) > 0 
   begin
      insert prestacion..Log_EntDetValPre (ext_DetNroTrx, ext_FechaHoraTrx, ext
_CorTrxLista, ext_Lista) values (@Folio, @FecHorTrx, 10, @extLista10) 
      if @@error != 0 
      begin 
         rollback tran uno 
         Select @extCodError = 'N', @extMensajeError = 'Error al registrar Det de Log'
         return 1 
      end
   e
nd
   if char_length(rtrim(ltrim(@extLista11))) > 0 
   begin
      insert prestacion..Log_EntDetValPre (ext_DetNroTrx, ext_FechaHoraTrx, ext_CorTrxLista, ext_Lista) values (@Folio, @FecHorTrx, 11, @extLista11) 
      if @@error != 0 
      begin 
       
  rollback tran uno 
         Select @extCodError = 'N', @extMensajeError = 'Error al registrar Det de Log'
         return 1 
      end
   end
   if char_length(rtrim(ltrim(@extLista12))) > 0 
   begin
      insert prestacion..Log_EntDetValPre (ext_DetNr
oTrx, ext_FechaHoraTrx, ext_CorTrxLista, ext_Lista) values (@Folio, @FecHorTrx, 12, @extLista12) 
      if @@error != 0 
      begin 
         rollback tran uno 
         Select @extCodError = 'N', @extMensajeError = 'Error al registrar Det de Log'
      
   return 1 
      end
   end
   if char_length(rtrim(ltrim(@extLista13))) > 0 
   begin
      insert prestacion..Log_EntDetValPre (ext_DetNroTrx, ext_FechaHoraTrx, ext_CorTrxLista, ext_Lista) values (@Folio, @FecHorTrx, 13, @extLista13) 
      if @@error
 != 0 
      begin 
         rollback tran uno 
         Select @extCodError = 'N', @extMensajeError = 'Error al registrar Det de Log'
         return 1 
      end
   end
   commit tran uno 
   
   --consulta de regla para grabar log con resultado dado a 
IMED
   exec prestacion..RME_Sel_RegAdm 'RM',7,2, @ValAtr output
   if isNull(@ValAtr, 'NO') = 'SI'
      set @vliFlagResultado = 1
   else 
      set @vliFlagResultado = 0
      
   --// Obtencion de la Fecha del Dia. FECHA DEL SERVIDOR SYBASE. 
   Selec
t @Hoy          = convert(smalldatetime,convert(char(10),getdate(),101)) 
   --// Obtencion de fecha siguiente
   Select @HoyMasUno    = dateadd(dd,1,@Hoy) 

   --// Conversion del codigo sucursal ORDEN a formate CD-ING 
   Select @CodSucursal = convert(c
har(6),ltrim(rtrim(@extSucVenta))) 
   --//conversion del Rut del Prestador 
   Select @RutCon = convert(int,substring(ltrim(rtrim(@extRutConvenio)),1,charindex('-',ltrim(rtrim(@extRutConvenio)))-1)) 
   --//conversion del RUT del Beneficiario 
   Select 
@RutBen = convert(int,substring(ltrim(rtrim(@extRutBeneficiario)),1,charindex('-',ltrim(rtrim(@extRutBeneficiario)))-1)) 
   --// folio del convenio y correlativo de renovacion 
   Select @FolCon = convert(int,substring(ltrim(rtrim(@extHomNumeroConvenio))
,1,charindex('-',ltrim(rtrim(@extHomNumeroConvenio)))-1)) 
   Select @CorRen = convert(tinyint,substring(@extHomNumeroConvenio,char_length(@extHomNumeroConvenio),1)) 
   --// Correlativo de direccion. 
   Select @CorDir = convert(int,ltrim(rtrim(@extHomLu
garConvenio))) 
   --Select @vlcCodCanasta = LTrim(RTrim(@extCanastaCabecera))
   
   Select top 1 @vliRutConReal = CprRutPre_ta from convenio..ConvenioPrestador 
   where CprFolCon_nn = @FolCon
   order by CprIdrCpr_id desc

   --// VALOR DE LA U.F. de l
a fecha de atencion. 
   exec @ErrorExec = convenio..Fecha_UFIPC @Hoy, @ValorUF output 
   if @ErrorExec != 0 
   begin 
      Select @extCodError = 'N', @extMensajeError = 'No se encontro valor de la UF' --TRX DENEGADA (EI:400366)' 
      exec prestacion
..InsCabValPre @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResultado
      return 1 
   end 
 
   
   exec @ErrorExec = prestacion..INGSelConMar 
                       @RutBen, @Hoy, @HoyMasUno, @Marca
 output, @NroContrato output, @Ok output                        
                       
   if @Ok = 'N' or @ErrorExec != 0 
   begin 
      Select @extCodError = 'N', @extMensajeError = 'Fallo re-validacion del benef'--TRX DENEGADA (EI:400367)' 
      Ex
ec prestacion..InsCabValPre @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResultado
      return 1 
   end 
 
   --// Determinacion de la Marca en funcion del Prestador. 
   if @Marca = 'AS' Select @extCo
dFinanciador = 74 
   if @Marca = 'CB' Select @extCodFinanciador = 78 
   if @Marca = 'NM' Select @extCodFinanciador = 70
 
   --// Validadcion de la Certificacion del Beneficiario. Importante Rescatar el 
   --// Plan vigente del contrato. 
   exec @Erro
rExec = INGBenCertif_out @extCodFinanciador, @extRutBeneficiario, @Hoy, 
                                    @certifApellidoPat        output, @certifApellidoMat        output, 
                                    @certifNombres            output, @certif
Sexo      output, 
                                    @certifFechaNacimi        output, @certifCodEstBen          output, 
                                    @certifDescEstado         output, @certifRutCotizante       output, 
                          
          @certifNomCotizante       output, @certifDirPaciente        output, 
                                    @certifGloseComuna        output, @certifGloseCiudad        output, 
                                    @certifPrevision          output, @
certifGlosa    output, 
                                    @extPlan              output, @certifDescuentoxPlanilla output, 
                                    @certifMontoExcedente     output, @certifRutAcompananate output, 
                            
        @certifNombreAcompanante  output 
   
   if @ErrorExec != 0 
   begin 
      Select @extCodError = 'N', @extMensajeError = 'Fallo re-validacion del benef' --TRX DENEGADA (EI:400367) 
      Exec prestacion..InsCabValPre @Folio, @FecHorTrx, @extPlan
, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResultado
      return 1 
   end 
 
   if @certifCodEstBen <> 'C' 
   begin 
      Select @extCodError = 'N', @extMensajeError = 'Error al certificar al benef.' --TRX DENEGADA (EI:400368
)' 
      exec prestacion..InsCabValPre @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResultado
      return 1 
   end 
   
   Select @cor_car     = BenCorCar_id, 
          @tipo_carga  = BenTip_fl, 
   
       @RutCte      = BenRutCot_id 
   from   contrato..Beneficiario 
   where  BenRutBen_nn = @RutBen 
     and  BenNumCto_id = @NroContrato 
     and  BenMarCon_id = @Marca 
     and  BenIniVig_fc <= @Hoy 
     and  BenTerVig_fc >= @Hoy 
   
   if @@row
count > 1 
   begin 
      Select @extCodError = 'N', @extMensajeError = 'Benef. en mas de un Cto.' 
      Exec prestacion..InsCabValPre @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResultado
      retur
n 1 
   end 
   
   Select @EdadCARGA   = datediff(yy, BenFecNac_fc, @Hoy), 
          @SexoCARGA   = BenSex_fl, 
          @FecNac      = BenFecNac_fc, 
          @IniVig      = BenIniVig_fc 
   from   contrato..Beneficiario 
   where  BenRutCot_id = @Ru
tCte 
     and  BenNumCto_id = @NroContrato 
     and  BenCorCar_id = @cor_car 
     and  BenMarCon_id = @Marca 
   
   if @@error != 0 
   begin 
      Select @extCodError = 'N', @extMensajeError = 'Extraer datos del Benf.' 
      Exec prestacion..InsCab
ValPre @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResultado
      return 1 
   end 
   
   --// Obtencion de la Lista de PLANES ALTERNATIVOS Posibles. 
   --// y los convenios exclusivos asociados a �l
 
   create table #PlanesAlternativos 
   ( 
    PlaCodPla_id codpla, 
    Iterar       int null, 
   ) 
   
   Select @Colectivo = ConNumCol_nn 
   from   contrato..Contrato 
   where  ConNumCto_id = @NroContrato 
     and  ConMarCon_id = @Marca 
   
   
if @Colectivo is not null
   begin
        insert into #PlanesAlternativos
        select  PlaCodPla_id, null
        from   contrato..TramoColectivo T, 
               contrato..PlanTramoCol Pt1, 
               contrato..PlanTramoCol Pt2, 
             
  contrato..Plan1 P 
        where  T.TcoNumCol_id   = @Colectivo 
          and  Pt1.PtrNumCol_id = @Colectivo 
          and  Pt1.PtrCorTra_id = T.TcoICorTra_id 
          and  Pt1.PtrCodPla_id = @extPlan
          and  Pt2.PtrCorTra_id = T.TcoICorTra_i
d 
          and  Pt2.PtrNumCol_id = @Colectivo 
          and  Pt2.PtrCodPla_id = PlaCodPla_id 
          and  Pt2.PtrTipPla_re = 'OP' 
          and  Pt2.PtrBloBen_re = 'SI' 
          
        select @vlcPlanColectivo = PlaCodPla_id
        from #Plane
sAlternativos a
            ,convenio..ModalidadValorizacion m
            ,convenio..LugarAtencionValorizacion l
            ,convenio..ModValorizacionPlan p
        where m.MvaFolCon_nn = @FolCon
          and m.MvaVigDes_fc <= @Hoy
          and isNull
(m.MvaVigHas_fc, @HoyMasUno) >= @Hoy
          and m.MvaCodMod_ta = 6     --  modalidades preferentes
          and l.LavFolMva_nn = m.MvaFolMva_nn
          and l.LavCorLat_nn = @CorDir
          and l.LavVigDes_fc <= @Hoy
          and isNull(l.LavVigHa
s_fc, @HoyMasUno) >= @Hoy 
          and p.MvpFolMva_nn = m.MvaFolMva_nn
          and p.MvpCodPla_ta = a.PlaCodPla_id
          and p.MvpVigDes_fc <= @Hoy
          and isNull(p.MvpVigHas_fc, @HoyMasUno) >= @Hoy
          
        set @extPlan= isNull(@v
lcPlanColectivo, @extPlan)
   end
   
   exec convenio..CON_CertificaVigenciaConvenio 
      @RutCon, @FolCon, @CorDir, @Hoy,
      @vliStaPre out, @vliStaCon out, @vliStaLat out , @vliStaIme out
   
   if (@vliStaPre = 0 or @vliStaCon = 0 or @vliStaLat =
 0 or @vliStaIme = 0)
   begin 
      Select @extCodError = 'N' 
      if @vliStaPre = 0
         Select @extMensajeError = 'Prestador no vigente' --TRX DENEGADA (EI:400809) 
      else
         if @vliStaCon = 0
            Select @extMensajeError = 'Con
v. no vigente o suspendido' --TRX DENEGADA (EI:400809) 
         else 
             if @vliStaLat = 0
                Select @extMensajeError = 'Direccion no vigente' --TRX DENEGADA (EI:400809) 
             else
                Select @extMensajeError = 
'Venta no vigente/suspendida' --TRX DENEGADA (EI:400809) 
                
      Exec prestacion..InsCabValPre @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResultado
      return 1 
   end 
   -- ** ----
---------------------------------------------------- 
   -- FR-7787 - Control de Vta. IMED para CMF 
   -- Codigo de Modalidad (20) para NO restringir la Vta. IMED 
   -- en CMF a ciertos Convenios Medicos. 
   if (@extPlan<> '')and 
      (exists (Select
 1 from   contrato..Plan1 
               where  PlaCodPla_id = @extPlan
                 and  PlaFamPla_ta = 'INMECA' )) and 
      (not exists (select 1 from convenio..ModalConvenioPrestador
                   where McpFolCon_nn = @FolCon 
             
        and McpCodMod_ta = 20
                     and McpVigDes_fc <= @Hoy
                     and isnull(McpVigHas_fc,@HoyMasUno) >= @Hoy)) 
   begin 
      Select @extCodError = 'N', @extMensajeError = 'Vta. Elect. restrin. por Conv.' 
      Exec pres
tacion..InsCabValPre @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResultado
      return 1 
   end 
   -- ** -------------------------------------------------------- 
      
   
   /* obtener folio de mo
dalidad normal: preferente o libre eleccion  */
   set @vlcTipMod = 'PR'
   exec convenio..CON_GetModalValorizacion @FolCon, @CorDir, @Hoy, @extPlan, @vlcTipMod output , @vliFolMva output
   
   --MegaSalud verificacion de modalidad de valorizacion dental

   if @FolCon = 45940
   begin
     Select Top 1 @vlcValSel = BadCodBen_id
     From contrato..BenAdici, contrato..Beneficiario
     Where BenRutBen_nn = @RutBen
       and BenTerVig_fc >= getdate()
       and BenRutCot_id = BadRutCot_id
       and BenNu
mCto_id = BadNumCto_id
       and BenMarCon_id = BadMarCon_id
       and BadCorCar_id = '00'
       and isNull(BadTerAdi_fc, @HoyMasUno) >= @Hoy
       and BadCodBen_id in ('MI60','M70A', 'M70B')
     
     if @vlcValSel is null     
        Select @vlcVa
lSel = BadCodBen_id
        From contrato..BenAdici, contrato..Beneficiario
        Where BenRutBen_nn = @RutBen
          and BenTerVig_fc >= getdate()
          and BenRutCot_id = BadRutCot_id
          and BenNumCto_id = BadNumCto_id
          and BenM
arCon_id = BadMarCon_id
          and BadCorCar_id = '00'
          and isNull(BadTerAdi_fc, @HoyMasUno) >= @Hoy
          and BadCodBen_id in ('MG60')
     
     if @vlcValSel is not null   
        exec convenio..CON_GetModalValorExcepcion @FolCon, @Cor
Dir, @Hoy, null, @vlcValSel, @vliFolMvaDental output 
   end
   --Integramedica verificacion de modalidad de valorizacion dental
   if @FolCon = 49945
   begin
     Select Top 1 @vlcValSel = BadCodBen_id
     From contrato..BenAdici, contrato..Beneficiari
o
     Where BenRutBen_nn = @RutBen
       and BenTerVig_fc >= getdate()
       and BenRutCot_id = BadRutCot_id
       and BenNumCto_id = BadNumCto_id
       and BenMarCon_id = BadMarCon_id
       and BadCorCar_id = '00'
       and isNull(BadTerAdi_fc, @H
oyMasUno) >= @Hoy
       and BadCodBen_id in ('ID70')
     
     if @vlcValSel is not null   
        exec convenio..CON_GetModalValorExcepcion @FolCon, @CorDir, @Hoy, null, @vlcValSel, @vliFolMvaDental output 
   end
   
   --// Decodificacion de las lis
tas de prestaciones. 
   --//Descomposicion de las listas pasadas por parametro. 
   create table #Parametro_Listas ( id numeric(2,0) identity, Lista   char(255) ) 
 
   if char_length(rtrim(ltrim(@extLista1))) > 0 insert #Parametro_Listas values (@extLis
ta1) 
   if char_length(rtrim(ltrim(@extLista2))) > 0 insert #Parametro_Listas values (@extLista2) 
   if char_length(rtrim(ltrim(@extLista3))) > 0 insert #Parametro_Listas values (@extLista3) 
   if char_length(rtrim(ltrim(@extLista4))) > 0 insert #Param
etro_Listas values (@extLista4) 
   if char_length(rtrim(ltrim(@extLista5))) > 0 insert #Parametro_Listas values (@extLista5) 
   if char_length(rtrim(ltrim(@extLista6))) > 0 insert #Parametro_Listas values (@extLista6) 
   if char_length(rtrim(ltrim(@ext
Lista7))) > 0 insert #Parametro_Listas values (@extLista7) 
   if char_length(rtrim(ltrim(@extLista8))) > 0 insert #Parametro_Listas values (@extLista8) 
   if char_length(rtrim(ltrim(@extLista9))) > 0 insert #Parametro_Listas values (@extLista9) 
   if c
har_length(rtrim(ltrim(@extLista10))) > 0 insert #Parametro_Listas values (@extLista10) 
   if char_length(rtrim(ltrim(@extLista11))) > 0 insert #Parametro_Listas values (@extLista11) 
   if char_length(rtrim(ltrim(@extLista12))) > 0 insert #Parametro_Lis
tas values (@extLista12) 
   if char_length(rtrim(ltrim(@extLista13))) > 0 insert #Parametro_Listas values (@extLista13) 
   
   Select @Total_Listas = 0 
 
   Select @Total_Listas = count(*) from #Parametro_Listas 
   
   if @Total_Listas <= 0 
   begin 

      Select @extCodError = 'N', @extMensajeError = 'No hay prestaciones a valorizar' --TRX DENEGADA (EO:400368) 
      Exec prestacion..InsCabValPre @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResulta
do
      return 1 
   end 
   
   --//Las listas traen prestaciones de la forma : Prest1|Prest2|Prest3|....|Prestn| 
   --//En esta tabla quedan los strings que corresponden a una unica prestacion. 
   create table #Cadenas 
   ( 
     Id        tinyint i
dentity ,
     Cadena    char(83) not null, --- FR-28369
     Procesado int          null 
   ) 
   
   Select @Cuenta_Lista = 1 
   
   while @Cuenta_Lista <= @Total_Listas 
   begin 
      Select @extListaAUX = Lista 
      from   #Parametro_Listas 
   
   where  id = @Cuenta_Lista 
      
      Select @MinValor = 1 
      
      while charindex('|',ltrim(rtrim(@extListaAUX))) > 0 
      begin 
         Select @extListaX = rtrim(@extListaX) + substring(@extListaAUX,1,charindex('|',@extListaAUX)) 
       
  Select @extListaAUX = substring(@extListaAUX,charindex('|',@extListaAUX)+1, char_length(@extListaAUX)) 
         --- 9 separadores por cada cadena que informa una prestacion
         if @MinValor = 9
         begin 
            insert #Cadenas values (@
extListaX, NULL) 
            Select @extListaX = '' 
            Select @MinValor = 0 
         end 
         Select @MinValor = @MinValor + 1 
      end 
      
      Select @Cuenta_Lista = @Cuenta_Lista + 1 
   end 
   
   if (Select count(*) from #Cad
enas) = 0 
   begin 
      Select @extCodError = 'N', @extMensajeError = 'No hay prestaciones a valorizar' --TRX DENEGADA (EO:400368) 
      Exec prestacion..InsCabValPre @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @Cor
Dir, @vliFlagResultado
      return 1 
   end 
   
   --// No la voy a usar mas asi que la elimino. 
   drop table #Parametro_Listas 
   
   create table #PrestacionValorizada 
   ( 
     Indice                numeric(10,0) identity, 
     --recibido
    
 CodPrestacion         prestacion    not null, 
     Item                  tinyint       not null, 
     TipoItem              char(2)           null, 
     AfectoRecargo         char(1)           null, 
     CantAte               tinyint       not null, 

     Homologo              char(20)          null, 
     TotalPrestacion       numeric(12,0)     null,
     PrestacionPrestador   char(15)          null,
     ItemPrestador         char(2)           null,
     InternoImed           char(15)          null
,  --reservado para informar codigo de canasta GES
          
     --calculado
     ModalCobertura        char(4)           null, 
     TipoCalculo           regla             null, 
     GrupoCobertura        char(4)           null, 
     Especialidad   
       char(3)           null, 
     ValorDesde            numeric(14,4)     null, 
     ValorHasta            numeric(14,4)     null, 
     Nomina                smallint          null, 
     Modalidad             char(2)           null, 
     TipReg    
            tinyint           null, 

     CostoCero             char(2)           null, 
     CopagoFijo            int               null, 
     ValorPrestacion       numeric(12,0)     null, 
     AporteFinanciador     numeric(12,0)     null, 
     Copa
go                numeric(12,0)     null, 
     ValorRendicion        int               null, 
     ClasiPresta           char(1)           null,
     CanastaGES            char(15)          null,
     FolioEventoGES        int               null,
     Ga
stoDedGesUF         numeric(8,2)      null,
     --salida
     Resultado             int               null, 
     Glosa1                char(50)          null,
     Glosa2                char(50)          null,
     Glosa3                char(50)        
  null,
     Glosa4                char(50)          null,
     Glosa5                char(50)          null,
     Error                 int               null,
     Iterar                int       default null null 
   ) 
   create table #PrestacionPaque
te 
   ( 
     Indice                numeric(10,0), 
     --recibido
     CodPrestacion         prestacion    not null, 
     Item                  tinyint       not null, 
     TipoItem              char(2)           null, 
     AfectoRecargo         cha
r(1)           null, 
     CantAte               tinyint       not null, 
     Homologo              char(20)          null, 
     TotalPrestacion       numeric(12,0)     null,
     PrestacionPrestador   char(15)          null,
     ItemPrestador         
char(2)           null,
     InternoImed           char(15)          null,
          
     --calculado
     ModalCobertura        char(4)           null, 
     TipoCalculo           regla             null, 
     GrupoCobertura        char(4)           nul
l, 
     Especialidad          char(3)           null, 
     ValorDesde            numeric(14,4)     null, 
     ValorHasta            numeric(14,4)     null, 
     Nomina                smallint          null, 
     Modalidad             char(2)         
  null, 
     TipReg                tinyint           null, 

     CostoCero             char(2)           null, 
     CopagoFijo            int               null, 
     ValorPrestacion       numeric(12,0)     null, 
     AporteFinanciador     numeric(12
,0)     null, 
     Copago                numeric(12,0)     null, 
     ValorRendicion        int               null, 
     ClasiPresta           char(1)           null,
     CanastaGES            char(15)          null,
     FolioEventoGES        int    
           null,
     GastoDedGesUF         numeric(8,2)      null,
     --salida
     Resultado             int               null, 
     Glosa1                char(50)          null,
     Glosa2                char(50)          null,
     Glosa3        
        char(50)          null,
     Glosa4                char(50)          null,
     Glosa5                char(50)          null,
     Error                 int               null,
     Iterar                int       default null null 
   ) 


   
  
 --//Las listas traen prestaciones de la forma : Prest1|Prest2|Prest3|....|Prestn| 
   --//seran decompuesta y dejadas en la tabla #PrestacionValorizada. 
   while exists(Select 1 from #Cadenas where Procesado is null) 
   begin 
   
      Select @CodPres
tacion = NULL, @Item    = NULL, @TipoItem      = NULL, 
             @AfectoRecargo = NULL, @CantAte = NULL, @HomologoPrestador = NULL,
             @vlcClasiPresta = NULL
      
      Select @varCadena = '' 
      Select top 1 @varCadena = Cadena, @vliCa
dena = Id from #Cadenas where Procesado is null order by Id
      
      Select @CodPrestacion = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1) 
      Select @Item          = convert(tinyint,substring(@CodPrestacion,8,3)) 
      Select 
@CodPrestacion = substring(@CodPrestacion,1,7) 
      Select @varCadena = substring(@varCadena,charindex('|',rtrim(@varCadena))+1,char_length(@varCadena)) 
      
      if char_length(substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1)) = 0 

         Select @TipoItem      = NULL 
      else 
         Select @TipoItem     = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1) 
      Select @varCadena = substring(@varCadena,charindex('|',@varCadena)+1,char_length(@varCadena)) 
   
   
      Select @HomologoPrestador = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1) 
      Select @varCadena = substring(@varCadena,charindex('|',@varCadena)+1,char_length(@varCadena)) 
      
      if char_length(ltrim(rtrim(@Homologo
Prestador))) <= 1 Select @HomologoPrestador = NULL 
      
      Select @AfectoRecargo = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1) 
      Select @varCadena = substring(@varCadena,charindex('|',@varCadena)+1,char_length(@varCadena))
 
      
      if @AfectoRecargo is null Select @AfectoRecargo = 'N' 
      
      Select @CantAte       = convert(int,substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1)) 
      Select @varCadena = substring(@varCadena,charindex('|',@varCad
ena)+1,char_length(@varCadena)) 
      
      Select @vliTotalPrestador = convert(int,substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1)) 
      Select @varCadena = substring(@varCadena,charindex('|',@varCadena)+1,char_length(@varCadena)) 

         
      Select @vlcPrestacionPrestador = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1) 
      Select @varCadena = substring(@varCadena,charindex('|',@varCadena)+1,char_length(@varCadena)) 
      
      Select @vlcItemPrestador 
= substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1) 
      Select @varCadena = substring(@varCadena,charindex('|',@varCadena)+1,char_length(@varCadena)) 
      
      Select @vlcInternoImed = substring(@varCadena,1,charindex('|',ltrim(rtri
m(@varCadena)))-1) 
      Select @varCadena = substring(@varCadena,charindex('|',@varCadena)+1,char_length(@varCadena)) 
            
      Select @ValorDesde = NULL, @ValorHasta = NULL, @ValorNomina = NULL, 
             @CodEsp     = NULL, 
            
 @Modalidad = NULL,  @ErrorCode = 0 , @ErrorGlosa = '',
             @vlcCodCanasta = NULL, @vliFolEveGes = NULL
      
      Select Top 1 @CodEsp = PesEspSer_id 
      from prestacion..PrestacionEspecialidad 
      where PesCodPre_id = @CodPrestacion
   
     and PesEstVig_re = 'VI'
      
      if @CodEsp is Null 
         Select @CodEsp = '   '

      /* recuperar folio de caso GES*/
      Set @vlcInternoImed = LTrim(RTrim(@vlcInternoImed))
      if @vlcInternoImed is not null
      begin
         Selec
t @vliFolEveGes  = EcaNumEve_id
               ,@vlcCodCanasta = GevCodCar_id
	     from prestacion..Evento_CAEC 
	         ,prestacion..ControlEstadoProceso 
             ,prestacion..GES_GrupoEvento
             ,prestacion..GES_GrupoProblema
         w
here EcaMarCon_ta = @Marca 
           and EcaRutCon_ta = @RutCte
           and EcaNumCto_ta = @NroContrato
           and EcaIteBen_ta = @cor_car --@IteBen 
           and EcaTipCob_re = 'GE'      -- GES 
           and EcaNumEve_id  > 50000
           
and isNull(EcaFecAlt_fc, @HoyMasUno) >= @Hoy
           and isNull(EcaEstAlt_re, '') <> 'AD'
           and CepIdePro_id = 'BC' 
           and CepIdeDoc_id = EcaNumEve_id 
           and CepEstAct_re = 'PE'
           and CepCodEst_id = 'AU'
           a
nd GevFolEve_id = EcaNumEve_id 
--           and GevEstAut_id = 'VI'
           and GevFecIni_fc <= @Hoy
           and isNull(GevFecTer_fc, @HoyMasUno) >= @Hoy
           and GevCodCar_id = GprCodCar_id           
           and GprCodIme_cr = @vlcIntern
oImed
           
         if @vliFolEveGes is Null
         begin
            Set @vlcCodCanasta = null
            Set @vlcClasiPresta = 'N' --normal
         end
         else
         begin
            /* obtener correlativo de renovacion de canasta  
*/
            Select @vliCorRenCanasta = AgrCorRen_id
            from prestacion..GES_ArancelGrupo
            where AgrCodCar_id = @vlcCodCanasta
              and AgrVigDes_fc <= @Hoy
              and isNull(AgrVigHas_fc, @HoyMasUno) >= @Hoy 
       
     
            if @vliCorRenCanasta is null
               Select @vliCorRenCanasta = max(AgrCorRen_id)
               from prestacion..GES_ArancelGrupo
               where AgrCodCar_id = @vlcCodCanasta
            
            Select @vliNumPro = Agr
NumPro_id
                  ,@vlcCodEta = AgrCodEta_id
                  ,@vlcPerUso = AgrPerUso_id
            from prestacion..GES_ArancelGrupo
            where AgrCodCar_id = @vlcCodCanasta
              and AgrCorRen_id = @vliCorRenCanasta
          
  
            if exists(select 1 from prestacion..GES_PrestacionGrupo
                      where PgrNumPro_id = @vliNumPro
                        and PgrCodEta_id = @vlcCodEta
                        and PgrCodCar_id = @vlcCodCanasta
                  
      and PgrPerUso_id = @vlcPerUso
                        and PgrCodPre_id = @CodPrestacion
                        and PgrCorRen_id = @vliCorRenCanasta)
                set @vlcClasiPresta = 'G'  --GES
            else
                set @vlcClasiPres
ta = 'N' --normal
         end
      end
      else
          set @vlcClasiPresta = 'N'  --normal
          
      insert #PrestacionValorizada (CodPrestacion, Item, TipoItem, AfectoRecargo,
                                    CantAte, Homologo, TotalPres
tacion, 
                                    PrestacionPrestador, ItemPrestador, InternoImed,
                                    ModalCobertura, TipoCalculo, GrupoCobertura, Especialidad,
                                    ValorDesde, ValorHasta, Nomina
, Modalidad, TipReg,
                                    CostoCero, CopagoFijo, ValorPrestacion, AporteFinanciador, Copago, ValorRendicion,
                                    ClasiPresta, CanastaGES, FolioEventoGES, GastoDedGesUF, Resultado,
            
                        Glosa1, Glosa2, Glosa3, Glosa4, Glosa5,
                                    Error, Iterar)
      values (@CodPrestacion, @Item, @TipoItem, @AfectoRecargo, 
              @CantAte, @HomologoPrestador, @vliTotalPrestador,
           
   @vlcPrestacionPrestador, @vlcItemPrestador, @vlcInternoImed,
              NULL, NULL, case when @vlcClasiPresta = 'G' then '104' else NULL end, @CodEsp, 
              @ValorDesde, @ValorHasta, @ValorNomina, @Modalidad, NULL,
              NULL, NULL,
 NULL, NULL, NULL, NULL,
              @vlcClasiPresta, @vlcCodCanasta, @vliFolEveGes, NULL, NULL, 
              NULL,NULL,NULL,NULL, NULL,
              @ErrorCode, NULL) 
      
      /*recuperar valor de indice para registro recien creado*/
      set 
@Indice = @@identity
      
      update #Cadenas 
      set Procesado = 1 
      where  Id = @vliCadena
      
      Select  @PreVigMin    = CapVigMin_nn, 
              @PreVigMax    = CapVigMax_nn, 
              @PreModVig    = CapUniVig_re, 
        
      @EdadMin      = CapEdaMin_nn, 
              @EdadMax      = CapEdaMax_nn, 
              @ModEda       = CapModEda_re 
      from    prestacion..CatalogoPrestacion 
      where   CapCodPre_id = @CodPrestacion 
      
      --/// Control de Otorgami
ento de Prestaciones por Sexo, Edad, IMED. 
      if not exists (Select 1 
                     from   prestacion..CatalogoPrestacion 
                     where  CapCodPre_id = @CodPrestacion 
                       and  CapResSex_re in ('T',@SexoCARGA))
 
      begin 
         /*
         Select @extCodError = 'N' 
         if @SexoCARGA = 'M' 
            Select @extMensajeError = 'Cod. no otorg. sexo masculino' --(EO:400811)'//No Otorgable Masculino 
         else 
            Select @extMensajeError =
 'Cod. no otorg. sexo femenino' --(EO:400812) //No Otorgable Femenino 
         return 1 
         */
         if @SexoCARGA = 'M'
            select @ErrorCode = 400811, @ErrorGlosa = 'Cod. no otorg. sexo masculino'
         else 
            select @Err
orCode = 400812, @ErrorGlosa = 'Cod. no otorg. sexo femenino'
      end 
      if @ErrorCode = 0
      begin
         Select @EdadCARGA = case @ModEda 
                                  when 'YY' then convert(int, datediff(mm,@FecNac,@Hoy) / 12) 
        
                          when 'QQ' then datediff(qq,@FecNac,@Hoy) 
                                  when 'MM' then datediff(mm,@FecNac,@Hoy) 
                                  when 'WK' then datediff(wk,@FecNac,@Hoy) 
                                  w
hen 'DD' then datediff(dd,@FecNac,@Hoy) 
                             end 
         
         Select @ResEdad = 'S' 
         
         Select @ResEdad = 'N' 
         where  @EdadMin <= @EdadCARGA 
            and @EdadMax >= @EdadCARGA 
         
      
   if (@ResEdad = 'S') 
         begin 
            Select @ErrorCode = 400813, @ErrorGlosa = 'Cod. no otorg. Benef esta edad'
            /*
            Select @extCodError = 'N' 
            Select @extMensajeError = 'Cod. no otorg. Benef esta edad' --(
EO:400813)' --//No Otorgable Edad 
            return 1 
            */
         end 
      end
      if @ErrorCode = 0
      begin
         if exists (Select 1 from   prestacion..CatalogoPrestacion 
                    where  CapCodPre_id = @CodPrestacio
n 
                       and CapVtaIme_re = 'NO') 
         begin 
            Select @ErrorCode = 400814, @ErrorGlosa = 'Cod. no otorg. Benef por I-med'
            /*
            Select @extCodError = 'N' 
            Select @extMensajeError = 'Cod. no
 otorg. Benef por I-med' --(EO:400814)' --//No Otorgable IMED 
            return 1
             */ 
         end 
      end
      --///  Vigencia Minima de Otorgamiento 
      if @ErrorCode = 0
      begin
         Select @TmpoVig = case @PreModVig 
    
                            when 'YY' then convert(int, datediff(mm,@IniVig,@Hoy) / 12) 
                                when 'QQ' then datediff(qq,@IniVig, @Hoy) 
                                when 'MM' then datediff(mm,@IniVig, @Hoy) 
                
                when 'WK' then datediff(wk,@IniVig, @Hoy) 
                                when 'DD' then datediff(dd,@IniVig, @Hoy) 
                           end 
         
         Select @ResVig = 'S' 
         Select @ResVig = 'N' 
         where  @
PreVigMin <= @TmpoVig 
           and  @PreVigMax >= @TmpoVig 
   
         if (@ResVig = 'S') 
         begin
            Select @ErrorCode = 400815, @ErrorGlosa = 'No otorg por rango de vigencia.'
            /*
            Select @extCodError = 'N' 
  
          Select @extMensajeError = 'No otorg por rango de vigencia.'--TRX DENEGADA (EO:400815)' --//No Otorgable Vigencia Valida 
            return 1 
            */
         end 
      end
      if @ErrorCode <> 0
         Update #PrestacionValorizada

         set Resultado = 1   --rechazada 
            ,Error = @ErrorCode
            ,Glosa1 = @ErrorGlosa
         where Indice = @Indice
   end --// fin del ciclo While para decodificar las prestaciones. 
   
   if exists(select 1 from #PrestacionValor
izada where isNull(Resultado, 0) = 0 and ClasiPresta = 'G')
   begin
      set @vlcTipMod = 'GE'
      exec convenio..CON_GetModalValorizacion @FolCon, @CorDir, @Hoy, @extPlan, @vlcTipMod output , @vliFolMvaGes output
      
      if isNull(@vlcTipMod, 'L
E') <> 'GE'
         update #PrestacionValorizada
         set ClasiPresta = 'N'
            ,CanastaGES  = Null
            ,FolioEventoGES = Null
         where ClasiPresta = 'G'
   end

/*****************************************************************
****************************************************************/
/*********************************************************************************************************************************/
/********************************************************
*************************************************************************/
/*
   if (@vlcCodCanasta is not null and exists(select 1 from prestacion..GES_GrupoProblema where GprCodCar_id = @vlcCodCanasta))
   begin
      set @vlcTipMod = 'GE'
      exec co
nvenio..CON_GetModalValorizacion @FolCon, @CorDir, @Hoy, @extPlan, @vlcTipMod output , @vliFolMvaGes output
      
      if isNull(@vlcTipMod, 'LE') <> 'GE'
      begin
         set @vliFolMvaGes = null
         set @vlcCodCanasta = null
      end

      
if @vlcCodCanasta is not null
      begin
         Select @vliFolEveGes = EcaNumEve_id 
	     from prestacion..Evento_CAEC 
	         ,prestacion..ControlEstadoProceso 
             ,prestacion..GES_GrupoEvento
         where EcaMarCon_ta = @Marca 
      
     and EcaRutCon_ta = @RutCte
           and EcaNumCto_ta = @NroContrato
           and EcaIteBen_ta = @cor_car --@IteBen 
           and EcaTipCob_re = 'GE'      -- GES 
           and EcaNumEve_id  > 50000
           and isNull(EcaFecAlt_fc, @HoyMasUn
o) >= @Hoy
           and EcaEstAlt_re is Null
           and CepIdePro_id = 'BC' 
           and CepIdeDoc_id = EcaNumEve_id 
           and CepEstAct_re = 'PE'
           and CepCodEst_id = 'AU'
           and GevFolEve_id = EcaNumEve_id 
           and
 GevCodCar_id = @vlcCodCanasta
         
         if @vliFolEveGes is Null
         begin
            Set @vlcCodCanasta = null
            set @vliFolMvaGes = null
         end
      end
   end
   else
      set @vlcCodCanasta = null

   
   if @vlcCodCa
nasta is not null
   begin
      Select @vliCorRenCanasta = AgrCorRen_id
      from prestacion..GES_ArancelGrupo
      where AgrCodCar_id = @vlcCodCanasta
        and AgrVigDes_fc <= @Hoy
        and isNull(AgrVigHas_fc, @HoyMasUno) >= @Hoy 
     if @vliC
orRenCanasta is null
        Select @vliCorRenCanasta = max(AgrCorRen_id)
        from prestacion..GES_ArancelGrupo
        where AgrCodCar_id = @vlcCodCanasta
     
     Select @vliNumPro = AgrNumPro_id
           ,@vlcCodEta = AgrCodEta_id
           ,@
vlcPerUso = AgrPerUso_id
     from prestacion..GES_ArancelGrupo
     where AgrCodCar_id = @vlcCodCanasta
       and AgrCorRen_id = @vliCorRenCanasta
   end  
   */
/******************************************************************************************
***************************************/
/*********************************************************************************************************************************/
/*********************************************************************************
************************************************/



   --// Control de Prestaciones Kin�sicas (06...) e Inmunoterapia (1707036). 
   --// Se requiere el siguiente Control: 
   --// No se pueden dar en un Acto de Venta mas de 3 prestaciones distintas del 

   --// grupo 06 (FNS) acompa�adas de solo una prestacion de evaluacion (0601001) 
   --// y la cantidad para cada una de ellas debe ser '1' 
   --// En el caso de la inmunoterapia la cantidad debe ser '1'. 

   -- Control general de Prest. KINE en canti
dad = 1 
   update #PrestacionValorizada
   set Resultado = 1
      ,Error = 400803
      ,Glosa1 = 'Prest. kines en cant. mayor a 1'
   from #PrestacionValorizada
        ,prestacion..CatalogoPrestacion 
   where Error = 0
     and CapCodPre_id = CodPres
tacion 
     and CapCodGru_ta = 6 
     and CapCodSug_ta = 1 
     and CapEstVig_re = 'VI' 
     
   Select distinct CodPrestacion, Item, CantAte, cont = count(*) 
          into #ControlKinesEInmunoT 
   From   #PrestacionValorizada 
         ,prestacion
..CatalogoPrestacion 
   where  CapCodGru_ta = 6 
     and  CapCodSug_ta = 1 
     and  CapEstVig_re = 'VI' 
     and  CapCodPre_id = CodPrestacion 
   group by CodPrestacion, Item, CantAte 

   /* 
   --//Control de Multiples Filas con la Misma Prestacio
n. 
   if exists (Select 1 From #ControlKinesEInmunoT where CodPrestacion = '0601029') 
   begin 
      if (select sum(cont) from   #ControlKinesEInmunoT ) >= 3 
      begin 
       Select @extCodError = 'N' 
       Select @extMensajeError = 'Cod. no eval
. junto a 0601029' --TRX DENEGADA (EO:400808)' 
       return 1 
      end 
   end 
   else 
   begin 
      if (select sum(cont) from   #ControlKinesEInmunoT ) >= 5 
      begin 
       Select @extCodError = 'N' 
       Select @extMensajeError = 'Imposib
le + 4 Prestacion KINE' --TRX DENEGADA (EO:400804) 
       return 1 
      end 
   end 
   */ 
   -- ** ------------------------------------------------------- 
   if exists (select 1 from   #ControlKinesEInmunoT where  cont > 1) 
   begin
      update #P
restacionValorizada
      set Resultado = 1
         ,Error = 400806
         ,Glosa1 = 'Prest m�s de 1 vez en la venta'
      from #PrestacionValorizada a, #ControlKinesEInmunoT b
      where a.Error = 0
        and a.CodPrestacion = b.CodPrestacion
    
    and a.Item = b.Item
        and a.CantAte = b.CantAte
        and b.cont > 1
      /* 
      Select @extCodError = 'N' 
      Select @extMensajeError = 'Prest m�s de 1 vez en la venta' --TRX DENEGADA (EO:400806) 
      return 1 
      */
   end 

   -
- ** --------------------------------------------------------------- 
   -- FR-9155 
   -- La prestacion 0601029 solo se puede emitir con la prestacion 0601001, o por si sola. 
   if (exists (Select 1 From #ControlKinesEInmunoT where CodPrestacion = '0601
029'))    	-- validar si existe la prestacion 
   begin 
      if (exists (select 1 from #ControlKinesEInmunoT having count(*)=2))                      -- Validar mas de una prestacion 
         if (not exists (Select 1 From #ControlKinesEInmunoT where Co
dPrestacion = '0601001')) -- validar si la proxima prestacion debe ser la 0601001 
         begin
            Update #PrestacionValorizada
            set Resultado = 1
               ,Error  = 400807
               ,Glosa1 = 'prest. NO evaluativa.'
     
       from #PrestacionValorizada a, #ControlKinesEInmunoT b
            where a.Error = 0
              and a.CodPrestacion = b.CodPrestacion
              and a.Item = b.Item
              and a.CantAte = b.CantAte
            /*
            Select @ext
CodError = 'N' 
            Select @extMensajeError = 'prest. NO evaluativa.' 
            return 1 
            */
         end 
      if (exists (select 1 from #ControlKinesEInmunoT  having count(*)>2 ))                   -- Validar mas de una prestacio
n 
      begin
         Update #PrestacionValorizada
         set Resultado = 1
            ,Error  = 400807
            ,Glosa1 = 'prest. NO evaluativa.'
         from #PrestacionValorizada a, #ControlKinesEInmunoT b
         where a.Error = 0
          
 and a.CodPrestacion = b.CodPrestacion
           and a.Item = b.Item
           and a.CantAte = b.CantAte 
         /*
         Select @extCodError = 'N' 
         Select @extMensajeError = 'prest. NO evaluativa.' 
         return 1 
         */
      en
d 
   end 
   -- ** ---------------------------------------------------------------- 
   -- Las prestaciones <0601017,0601030> solo se pueden emitir con la prestacion 0601001 con las siguientes convinatorias 
   -- 0601030 		-- por si sola 
   -- 0601017 
		-- por si sola 
   -- 0601017 		con 0601001 
   -- 0601030 		con 0601001 
   -- 0601017,0601030 	con 0601001 
   -- 0601030,0601017     -- por si sola 
   if  (exists (Select 1 From #ControlKinesEInmunoT where CodPrestacion = '0601017')) and 
       (ex
ists (Select 1 From #ControlKinesEInmunoT  where CodPrestacion = '0601030'))   -- validar si existe la prestacion 
   begin 
      if (exists (select 1 from #ControlKinesEInmunoT  having count(*)= 3 ))              -- Validar mas de una prestacion 
      
   if not (exists (Select 1 From #ControlKinesEInmunoT  where CodPrestacion = '0601001'))  -- validar si la proxima prestacion debe ser la 0601001 
         begin 
            Update #PrestacionValorizada
            set Resultado = 1
               ,Erro
r  = 400807
               ,Glosa1 = 'prest. NO evaluativa.'
            from #PrestacionValorizada a, #ControlKinesEInmunoT b
            where a.Error = 0
              and a.CodPrestacion = b.CodPrestacion
              and a.Item = b.Item
            
  and a.CantAte = b.CantAte 
            /*
            Select @extCodError = 'N' 
            Select @extMensajeError = 'prest. NO evaluativa.' 
            return 1 
            */
         end 
   end 
   --  ** ----------------------------------------
------------------------------- 
   delete #ControlKinesEInmunoT where  CodPrestacion = '0601001' 
   -- ** FR-9155 ---------------------------------------- 
   /* 
   if exists (Select 1 From #ControlKinesEInmunoT where CodPrestacion = '0601029') 
   beg
in 
     if (Select sum(count(distinct CodPrestacion)) from   #ControlKinesEInmunoT) >= 2 
     begin 
        Select @extCodError = 'N' 
        Select @extMensajeError = 'Prest. No evaluativa  asoc. 0601029.' --TRX DENEGADA (EO:400808) 
        return 1
 
     end 
   end 
   else 
   begin 
     if (Select sum(count(distinct CodPrestacion)) from   #ControlKinesEInmunoT) >= 4 
     begin 
        Select @extCodError = 'N' 
        Select @extMensajeError = 'Imposible + 4 Prestacion KINE' --TRX DENEGADA (
EO:400804) 
        return 1 
     end 
   end 
   */ 
   --  ** ----------------------------------------------------------------------- 
   Update #PrestacionValorizada
   set Resultado = 1
      ,Error = 400805
      ,Glosa1 = '1707036 en cant. mayor a 
1'
   where CodPrestacion = '1707036'
     and CantAte <> 1
   
   /*
   if exists (Select 1 From   #PrestacionValorizada 
              where  CodPrestacion = '1707036' 
                and  CantAte <> 1) 
   begin    
      Select @extCodError = 'N' 
  
    Select @extMensajeError = '1707036 en cant. mayor a 1' --TRX DENEGADA (EI:400805) 
      return 1 
      
   end 
   */
   --// FIN Control de Prestaciones Kin�sicas (06...) e Inmunoterapia (1707036). 
 
   -- ** --------------------------------------
-------------------------- 
   -- FR-9155 
   -- Control sobre prestaciones de Examenes de Laboratorio. 
   Select distinct CodPrestacion, Item, CantAte, cont = count(*) 
          into #ControlExamenesLab 
   From #PrestacionValorizada 
       ,prestacio
n..CatalogoPrestacion 
   where CapCodGru_ta = 3 
     and CapEstVig_re = 'VI' 
     and CapCodPre_id = CodPrestacion 
   group by CodPrestacion, Item, CantAte 
  
   -- Excluir la vta. de prestaciones que estan creadas para dar complitud de codigos de pr
estaciones 
   -- Ejemplo :  Si se esta vendiendo el codigo 0302075, no podemos generar una venta admas de las 
   -- siguientes prestaciones junto con el codigo antes mencionado. 
   -- 0302005,0302012,0302015,0302030,0302040,0302042,0302047,0302057,0302
060,0302059,0302076,0302067. 
 
   if (exists (Select 1 From #ControlExamenesLab where CodPrestacion = '0302075'))     -- validar si existe la prestacion - Perfil Bioquimico 
      if (exists (select 1 from #ControlExamenesLab having count(*) > 1 ))      
       -- Validar mas de una prestacion 
         if (exists (Select 1 From #ControlExamenesLab 
              where CodPrestacion in ('0302005','0302012','0302015','0302030','0302040','0302042','0302047', 
                                      '0302057',
'0302060','0302063','0302067') 
            ))							-- validar si las proxima prestaciones NO pueden ser.... 
         begin 
             update #PrestacionValorizada
             set Resultado = 1
                ,Error = 400806
                ,Glosa1
 = 'Prestacion ya incluida en 0302075.'
             where  CodPrestacion in ('0302005','0302012','0302015','0302030','0302040','0302042','0302047', 
                                      '0302057','0302060','0302063','0302067') 
             /*
         
    Select @extCodError = 'N' 
             Select @extMensajeError = 'Prestacion ya incluida en 0302075.' 
             return 1 
             */
         end 
   if (exists (Select 1 From #ControlExamenesLab where CodPrestacion = '0302076'))      -- val
idar si existe la prestacion - Perfil hepatico 
      if (exists (select 1 from #ControlExamenesLab having count(*) > 1 ))              -- Validar mas de una prestacion 
         if (exists (Select 1 From #ControlExamenesLab 
              where CodPresta
cion in ('0301059','0302013','0302040','0302045','0302063') 
            ))                                 -- validar si las proxima prestaciones NO pueden ser.... 
         begin 
             update #PrestacionValorizada
             set Resultado = 1

                ,Error = 400806
                ,Glosa1 = 'Prestacion ya incluida en 0302076.'
             where  CodPrestacion in ('0301059','0302013','0302040','0302045','0302063') 
              /*
              Select @extCodError = 'N' 
            
  Select @extMensajeError = 'Prestacion ya incluida en 0302076' 
              return 1 
              */
         end 
   if (exists (Select 1 From #ControlExamenesLab  where CodPrestacion = '0309022'))     -- validar si existe la prestacion - Orina Comp
leta 
      if (exists (select 1 from #ControlExamenesLab  having count(*) > 1 ))            -- Validar mas de una prestacion 
         if (exists (Select 1 From #ControlExamenesLab 
              where CodPrestacion in ('0309024','0309023') 
            
))							-- validar si las proxima prestaciones NO pueden ser.... 
         begin 
             update #PrestacionValorizada
             set Resultado = 1
                ,Error = 400806
                ,Glosa1 = 'Prestacion ya incluida en 0309022' 
    
         where  CodPrestacion in ('0309024','0309023')
             /*
             Select @extCodError = 'N' 
             Select @extMensajeError = 'Prestacion ya incluida en 0309022' 
             return 1 
             */
         end 
   if (exists (
Select 1 From #ControlExamenesLab  where CodPrestacion = '0306011'))      -- validar si existe la prestacion - Oricultivo 
      if (exists (select 1 from #ControlExamenesLab  having count(*) > 1 ))              -- Validar mas de una prestacion 
         
if (exists (Select 1 From #ControlExamenesLab 
              where CodPrestacion in ('0307015','0306026') 
            ))							-- validar si las proxima prestaciones NO pueden ser.... 
         begin 
             update #PrestacionValorizada
           
  set Resultado = 1
                ,Error = 400806
                ,Glosa1 = 'Prestacion(es) ya incluida(s) en el codigo 0306011, Urocultivo.'
             where  CodPrestacion in ('0307015','0306026')
              /*
              Select @extCodError =
 'N' 
              Select @extMensajeError = 'Prestacion(es) ya incluida(s) en el codigo 0306011, Urocultivo.' 
              return 1 
              */
         end 
   if (exists (Select 1 From #ControlExamenesLab  where CodPrestacion = '0308044'))    
   -- validar si existe la prestacion - Oricultivo 
      if (exists (select 1 from #ControlExamenesLab  having count(*) > 1 ))               -- Validar mas de una prestacion 
         if (exists (Select 1 From #ControlExamenesLab 
              where Cod
Prestacion in ('0306004','0306005','0306008','0306017','0306026') 
            ))							-- validar si las proxima prestaciones NO pueden ser.... 
         begin 
             update #PrestacionValorizada
             set Resultado = 1
                ,Err
or = 400806
                ,Glosa1 = 'Prestacion ya incluida en 0308044'
             where  CodPrestacion in ('0306004','0306005','0306008','0306017','0306026')
             /*
             Select @extCodError = 'N' 
             Select @extMensajeError
 = 'Prestacion ya incluida en 0308044' 
             return 1 
             */
         end 
   if (exists (Select 1 From #ControlExamenesLab  where CodPrestacion = '0301045')) -- validar si existe la prestacion - Hemograma 
      if (exists (select 1 fro
m #ControlExamenesLab  having count(*) > 1 ))         -- Validar mas de una prestacion 
         if (exists (Select 1 From #ControlExamenesLab 
              where CodPrestacion in ('0301086','0301036','0301038','0301065','0301064','0301069') 
           
 ))							-- validar si las proxima prestaciones NO pueden ser.... 
         begin 
             update #PrestacionValorizada
             set Resultado = 1
                ,Error = 400806
                ,Glosa1 = 'Prestacion ya incluida en 0301045'
    
         where  CodPrestacion in ('0301086','0301036','0301038','0301065','0301064','0301069')
             /*
             Select @extCodError = 'N' 
             Select @extMensajeError = 'Prestacion ya incluida en 0301045' 
             return 1 
     
        */
         end 
   if (exists (Select 1 From #ControlExamenesLab where CodPrestacion = '0302034'))   -- validar si existe la prestacion - Oricultivo 
      if (exists (select 1 from #ControlExamenesLab having count(*) > 1 ))           -- Validar 
mas de una prestacion 
         if (exists (Select 1 From #ControlExamenesLab 
              where CodPrestacion in ('0302067','0302068','0302064') 
            ))							-- validar si las proxima prestaciones NO pueden ser.... 
         begin 
           
  update #PrestacionValorizada
             set Resultado = 1
                ,Error = 400806
                ,Glosa1 = 'Prestacion ya incluida en 0302034'
             where  CodPrestacion in ('0302067','0302068','0302064')
              /*
             
 Select @extCodError = 'N' 
              Select @extMensajeError = 'Prestacion ya incluida en 0302034' 
              return 1 
              */
         end 
   -- ** ---------------------------------------------------------------- 
   --// Para que el 
procedimiento siga el mismo flujo probado y hasta la fecha OK. 
   --// se separaran las prestaciones normales de las de tipo paquete. Estas ultimas 
   --// se trataran en un ciclo aparte. y cercano al final de este codigo. 
   if exists(select 1 from #P
restacionValorizada where  substring(Homologo,1,1) = 'P' and char_length(LTrim(RTrim(Homologo))) = 15 )
   begin
      insert #PrestacionPaquete 
      Select Indice, CodPrestacion, Item, TipoItem, AfectoRecargo, CantAte, Homologo, TotalPrestacion,
      
       PrestacionPrestador, ItemPrestador, InternoImed, ModalCobertura, TipoCalculo, GrupoCobertura,
             Especialidad, ValorDesde, ValorHasta, Nomina, Modalidad, TipReg, CostoCero, CopagoFijo, ValorPrestacion,
             AporteFinanciador, Copa
go, ValorRendicion, ClasiPresta, CanastaGES, FolioEventoGES, GastoDedGesUF, Resultado, Glosa1, Glosa2, Glosa3, Glosa4, Glosa5,
             Error, Iterar
      from   #PrestacionValorizada 
      where  substring(Homologo,1,1) = 'P' and char_length(LTrim(
RTrim(Homologo))) = 15 
 
      delete #PrestacionValorizada 
      where  substring(Homologo,1,1) = 'P' and char_length(LTrim(RTrim(Homologo))) = 15 
   end
 --// NOTAR QUE: #PrestacionValorizada mantiene las prestaciones normales. 
 --//            #Pre
stacionPaquete    mantiene las prestaciones incluidas en 
 --//            un paquete de prestaciones. 
 
 --// En este punto tengo todas las prestaciones requeridas. 
 --// para valorizarlas debemos recorrer la tabla #PrestacionValorizada 
 --// actualiz
ando los datos faltantes a medida que se van obteniendo. 
 
 Select @RecalculoRegimen = 'N' 
 
 Select @MinValor = min(Indice) from #PrestacionValorizada 
 Select @MaxValor = max(Indice) from #PrestacionValorizada 
 Select @Indice   = @MinValor 
 
 Set @v
lcClasiPresta = null
 
 While @MinValor <= @MaxValor 
 begin 
     Set @vlcModCob = 'XX' --indica que escoja la mejor cobertura
     
     if exists (select 1 from #PrestacionValorizada 
                where  Indice   = @Indice and isNull(Error,0) = 0 ) 

     begin 
        Select @CodPrestacion   = CodPrestacion, 
               @Item            = Item, 
               @TipoItem        = TipoItem, 
               @AfectoRecargo   = AfectoRecargo, 
               @Homologo        = ltrim(rtrim(Homologo))
, 
               @CantAte         = CantAte, 
               @CodEsp          = Especialidad,
               @vlcClasiPresta  = ClasiPresta,
               @vlcCodCanasta   = CanastaGES
        from   #PrestacionValorizada 
        where  Indice = @Indic
e 
 
        --//VALIDACION DE EXISTENCIA DEL MEDICO TRATANTE O SOLICITANTE. 
        --// 
        --//REGLA DE NEGOCIO: * Si no hay solicitante o tratante no importa. el bono soporta nulos. 
        --//                  * Tratante y Solicitante son mut
uamente excluyentes. 
        --//                  * De Venir un tratante �ste debe estar asociado al prestador en convenio 
        --//     de no ser asi, es causal de rechazo del servicio. 
        --//                  * De venir un Solicitante. �ste
 debe estar en la base de prestadores. sino lo ingreso 
        --//                    con datos basicos. Si no pudo ser ingresado. rechazo el servicio. 
        exec @ErrorExec = prestacion..INGCtrl_TratSol @Marca, @CodPrestacion, @AccionPresta output 

 
        if @ErrorExec != 0 
        begin 
           Select @extCodError = 'N', @extMensajeError = 'Fallo ingreso trat./solicit.' --TRX DENEGADA (EI:400377) 
           Exec prestacion..InsCabValPre @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensa
jeError, @RutCot, @RutCon, @CorDir, @vliFlagResultado
           return 1 
        end 
        
        if @AccionPresta not in ('PR','AM') 
        begin 
           if @AccionPresta = 'TR' 
           begin --// Tratante es Exigible 
              if n
ot ((@extRutTratante = '0000000000-0')or(@extRutTratante is NULL)or(@extRutTratante = '')) 
              begin 
                 Select @RutTra = convert(int,substring(ltrim(rtrim(@extRutTratante)),1,charindex('-',ltrim(rtrim(@extRutTratante)))-1)) 
    
             
                 if not exists (Select 1 from convenio..Staff 
                                where  StaCorLat_nn = @CorDir 
                                  and  StaRutSta_ta = @RutTra )
                  begin 
                     Selec
t @extCodError = 'N', @extMensajeError = 'Trat. no relacionado con Prest.' --TRX DENEGADA (EO:400371) 
                     Exec prestacion..InsCabValPre @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResu
ltado
                     return 1 
                  end 
              end 
              else 
                  Select @RutTra = @RutCon 
           end --// Tratante es Exigible 
           
           if @AccionPresta = 'SO' 
           begin  --//
 Solicitante es Exigible 
              if not ((@extRutSolicitante = '0000000000-0')or(@extRutSolicitante is NULL)or(@extRutSolicitante = '')) 
              begin 
                 Select @RutSol = convert(int,substring(ltrim(rtrim(@extRutSolicitante)),
1,charindex('-',ltrim(rtrim(@extRutSolicitante)))-1)) 
                 Select @DigMed_cr = substring(ltrim(rtrim(@extRutSolicitante)),charindex('-',ltrim(rtrim(@extRutSolicitante)))+1,1) 
                 
                 Select @RutTra = @RutSol 
     
            
                 --// Control de TRatante distinto al Prestador en convenio 
                 --// Solicitado Por Contralor de la Isapre. 
                 if @RutTra = @RutCon 
                 begin 
                    Select @extCodError 
= 'N', @extMensajeError = 'Trat./Solic. no existe.' --TRX DENEGADA (EI:400380) 
                    Exec prestacion..InsCabValPre @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResultado
                  
  return 1 
                 end --// 
                 
                 if not exists(Select 1 from convenio..Prestador where PreRutPre_id = @RutTra) 
                 begin 
                     exec @ErrorCode = convenio..InsertPrestador @RutSol,@DigM
ed_cr,'MEDICO ING x CSALUD00', null, 
                                                                 null, 'ME', NULL, NULL, 'NA', 
                                                                 'NA',NULL,NULL,NULL,NULL,NULL,NULL, 
                   
                                              @Hoy, @CodSucursal, 'CSALUD00', 'PI' 
                     if @ErrorCode !=  0 
                     begin 
                        Select @extCodError = 'N', @extMensajeError = 'Fallo ingreso de Prestador' --
TRX DENEGADA (EO:400372) 
                        Exec prestacion..InsCabValPre @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResultado
                        return 1 
                     end 
        
         end 
              end 
              else 
              begin 
                 if @RutTra is null 
                    Select @RutTra = @RutCon 
              end 
           end --// Solicitante es Exigible 
        end --// if @AccionPresta 
not in ('PR','AM') 
        else 
        begin 
           Select @RutTra = NULL 
           if not ((@extRutTratante = '0000000000-0')or(@extRutTratante is NULL)or(@extRutTratante = '')) 
              Select @RutTra = convert(int,substring(ltrim(rtrim(
@extRutTratante)),1,charindex('-',ltrim(rtrim(@extRutTratante)))-1)) 
           
           Select @RutSol = NULL 
           if not ((@extRutSolicitante = '0000000000-0')or(@extRutSolicitante is NULL)or(@extRutSolicitante = '')) 
              Select @R
utSol = convert(int,substring(ltrim(rtrim(@extRutSolicitante)),1,charindex('-',ltrim(rtrim(@extRutSolicitante)))-1)) 
           
           if @RutTra is null Select @RutTra = @RutSol 
           if @RutSol is null Select @RutTra = @RutCon 
           if
 not exists(Select 1 from convenio..Prestador where PreRutPre_id = @RutTra) 
           begin 
              Select @extCodError = 'N', @extMensajeError = 'Trat. / Solic. No Registrado' --TRX DENEGADA (EO:400380) 
              Exec prestacion..InsCabValP
re @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResultado
              return 1 
           end 
        end 
        --FR 2393
        if (@RutTra <> @RutCon and @vlcClasiPresta <> 'G')
        Begin
 
           exec convenio..CON_CheckStaffRestModValoriza @CorDir, @RutTra, @vliFolMva, @Hoy, @vliAplRes out, @vliValPre out, @vlcForCob out, @vliForMvaLE out
            if @vliAplRes = 1
            begin
               if @vlcForCob is not null
         
      begin
                  set @vlcModCob = 'LE'
                  set @vliFolMva = @vliForMvaLE
               end
               else
               begin
                  update #PrestacionValorizada 
                  set Error  = 400373 
        
          where  Indice = @Indice 
                    and  Error  = 0 
                  
                  Select @extCodError = 'N', @extMensajeError = 'Convenio Restringida a Doc.' -- 'TRX DENEGADA (EI:400373)' 
                  Exec prestacion..InsC
abValPre @Folio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResultado
                  return 1 
               end
            end
        End
        --fin FR 2393
        
        --// SI EL HOMOLOGO RECIB
IDO ES IGUAL AL CODIGO PRESTACION, 
        --// se esta indicando que existe un arancel unico para esa prestacion, y por ello 
        --// el homologo recibido no debe ser utilizado en la busqueda del arancel. 
        if rtrim(ltrim(@CodPrestacion)) + 
convert(char(3),replicate('0',3 - 
                                         char_length(ltrim(rtrim(convert(char(3),@Item)))))+ 
                                         ltrim(rtrim(convert(char(3),@Item)))) = rtrim(ltrim(@Homologo)) 
        begin 
     
      Select @Homologo = NULL 
        end 
        if @vlcClasiPresta = 'G'
           Set @Homologo = @vlcCodCanasta
           
        Select @ItemReal = @Item 
        Select @Item     = 0 
 
        --// Esquema Rigido de Tipos de Regimen para prest
aciones. 
        --// ----------------------------------------------------- 
        --// 
        --// De definen como base los siguientes tipos de regimen. 
        --// Regimen  1 : Regimen basico, siempre debe existir en el Arancel. 
        --// Reg
imen 51 : Regimen que diferencia un Arancel para Horario Inhabil 
        --// Regimen 52 : Regimen que diferencia un Arancel para Urgencias. 
        --// 
        --// De esta manera se compone el siguiente algoritmo: 
        --// 
        --// Inhabil
        Urgencia 
        --// N              N          => Reg =  1 
        --// S              N          => Reg = 51 
        --// N              S          => Reg = 52 
        --// S              S          => Reg = 52 multiplicado por % de Recargo 
H.Inhabil. Sino 
        --//                              existe Reg = 52 entonces Reg = 1 multiplicado por % de 
        --//                              Recargo H.Inhabil, del convenio de la prestacion. 
        --// 
        --// De agregarse otro ti
po de regimen convenios debera informarnoslo y 
        --// se debera analizar el impacto sobre esta rutina. 
        Select @CodReg = 1 
        if @RecalculoRegimen = 'N' 
        begin 
           if @AfectoRecargo = 'N' and @extUrgencia = 'N' Select 
@CodReg =  1 
           if @AfectoRecargo = 'S' and @extUrgencia = 'N' Select @CodReg = 51 
           if @AfectoRecargo = 'N' and @extUrgencia = 'S' Select @CodReg = 52 
           if @AfectoRecargo = 'S' and @extUrgencia = 'S' Select @CodReg = 52 
    
    end 
        --inicio FR 2353
        if (@RutTra <> @RutCon and LTrim(RTrim(@CodEsp)) is not null and @vlcClasiPresta <> 'G')
        begin
           set @ErrorExec = 0
           exec @ErrorExec = convenio..CON_CheckExcepcionMedicoEspec @CorDir, @R
utTra, @CodPrestacion, @CodEsp, @Hoy
           if @ErrorExec <> 0
              set @CodEsp = 'XXX'
        end
        --fin FR2353
        
        if @CodEsp <> 'XXX'                  --FR 2353     (1=1 or (@CodEsp is not null and @CodEsp <> 'XXX' ))

        begin --// INICIO 
           set @vliFolMvaAux = @vliFolMva
           if @vlcClasiPresta = 'G'
              set @vliFolMvaAux = @vliFolMvaGes
              
           if (@vliFolMvaDental is not null and @vlcClasiPresta <> 'G')
           begi
n
              if exists(select 1 from prestacion..SubPrestGrupCob, prestacion..CatGruCob 
                        where  SpgCodPre_id = @CodPrestacion and  SpgCodIte_id = @ItemReal
                           and GcoCodGco_id = SpgCodGco_id   and  GcoTip
Ate_re = 'AM'
                           and GcoCodGco_id = '492')
                 set @vliFolMvaAux = @vliFolMvaDental
           end  
           
           exec @ErrorExec = convenio..CON_GetValorVariPrestacion
                                  @RutC
on, @FolCon, @vliFolMvaAux, @CorDir, @CodEsp, @CodPrestacion, @ItemReal, @Hoy, @Homologo, @CodReg, 
                                                                 @ValorNomina output, 
                                                                 @Co
dPrest    output, 
                                                                 @CodItem     output, 
                                                                 @CodReg      output, 
                                                              
   @CodHomo     output, 
                                                                 @ValorDesde  output, 
                                                                 @ValorHasta  output, 
                                                        
         @Modalidad   output, 
                                                                 @CopagoFijo  output, 
                                                                 @CostoCero   output,
                                                   
              @PorceRecargo output,
                                                                 @ErrorCode   output,
                                                                 @RutTra
           
           if @ErrorCode != 0 
           begin 

               update #PrestacionValorizada 
               set ValorDesde = 0, 
                   ValorHasta = 0, 
                   Nomina     = @ValorNomina, 
                   Modalidad  = '' 
               where  Indice = @Indice 
              
 
               update #PrestacionValorizada 
               set Error      = @ErrorCode
                  ,Resultado  = 1
                  ,Glosa1     = case @ErrorCode
                                   when 1     then 'Prestacion No valorizada'
     
                              when 80000 then 'Prestacion No Habilitada'
                                   when 80003 then 'Prestacion No Convenida'
                                   when 80004 then 'Multiple Valorizacion'
                              
     when 88001 then 'Mod-Conv No Habilitada'
                                   when 101002 then 'multiple valorizacion'
                                   when 101003 then 'ninguna valorizacion'
                                else  'No se pudo valoriza
r prestacion'
                                end 
               where  Indice = @Indice 
                 and  Error  = 0 
           end 
           else 
           begin      -- // No se detecto Error. 
                   --// Esto indica que existe 
un Arancel de urgencia con recargo por % de recargo en el convenio. 
              if @AfectoRecargo = 'S'
                 set @PorceRecargo = isNull(@PorceRecargo,0)
              else
                 set @PorceRecargo = 0
                 
           
   update #PrestacionValorizada 
              set CodPrestacion = @CodPrest, 
                  Item          = @CodItem, 
                  ValorDesde    = round(@ValorDesde * case when AfectoRecargo = 'S' then (1 + round((@PorceRecargo / 100),2)) else 
1 end, 0), 
                  ValorHasta    = round(@ValorHasta * case when AfectoRecargo = 'S' then (1 + round((@PorceRecargo / 100),2)) else 1 end, 0), 
                  Nomina        = @ValorNomina, 
                  Modalidad     = @Modalidad, 
    
              TipReg        = @CodReg, 
                  Homologo      = @CodHomo, 
                  CopagoFijo    = @CopagoFijo, 
                  CostoCero     = @CostoCero,
                  ModalCobertura = @vlcModCob
              where  Indice = 
@Indice 
           end 
        end --// FIN @CodEsp is null or @CodEsp = 'XXX' 
        else 
        begin 
            update #PrestacionValorizada 
            set Resultado = 1
               ,Error  = 400373 
               ,Glosa1 = 'Prest. Restri
ngida al Tratante.'
            where  Indice = @Indice 
              and  Error  = 0 
        end 
        
        if (((Select Error From #PrestacionValorizada where Indice = @Indice) not in (0,400373))and 
            (@RecalculoRegimen = 'N')) 
    
    begin 
           --se vuelve a intentar con nuevo codigo de regimen
           Select @RecalculoRegimen = 'S' 
           update #PrestacionValorizada 
             set Error  = 0
                ,Resultado = 0 
                ,Glosa1 = Null
       
    where  Indice = @Indice 
        end 
        else 
        begin 
           Select @RecalculoRegimen = 'N' 
           Select @MinValor = @MinValor + 1 
           Select @Indice = @MinValor 
           
        end 
     end 
     else
     begin 

         --// El indice correlativo de la tabla #PrestacionValorizada tiene un salto. 
         --// probablemente, en la posicion ausente habia una prestacion, de tipo 
         --// item paquete (PQ). SE OMITE CICLO DE VALORIZACION. 
         Select @Mi
nValor = @MinValor + 1 
         Select @Indice   = @MinValor 
     end 
  end  --// Iterador de valorizacion prestaciones while @MinValor <= @MaxValor 
 
  --// Obtencion de los Valores de una prestacion #PAQUETE. 
  create table #Composicion_Paquete 
  
( 
     Indice                int           not null, 
     --recibido
     CodPrestacion         prestacion    not null, 
     Item                  tinyint       not null, 
     TipoItem              char(2)           null, 
     AfectoRecargo         c
har(1)           null, 
     CantAte               tinyint       not null, 
     Homologo              char(20)          null, 
     HomologoIMED          char(20)          null, 
     TotalPrestacion       numeric(12,0)     null,
     PrestacionPrestador
   char(15)          null,
     ItemPrestador         char(2)           null,
     InternoImed           char(15)          null,
          
     --calculado
     ModalCobertura        char(4)           null, 
     TipoCalculo           regla             n
ull, 
     GrupoCobertura        char(4)           null, 
     Especialidad          char(3)           null, 
     ValorDesde            numeric(14,4)     null, 
     ValorHasta            numeric(14,4)     null, 
     Nomina                smallint      
    null, 
     Modalidad             char(2)           null, 
     TipReg                tinyint           null, 

     CostoCero             char(2)           null, 
     CopagoFijo            int               null, 
     ValorPrestacion       numeric(
12,0)     null, 
     AporteFinanciador     numeric(12,0)     null, 
     Copago                numeric(12,0)     null, 
     ValorRendicion        int               null, 
     ClasiPresta           char(1)           null,
     CanastaGES            char
(15)          null,
     FolioEventoGES        int               null,
     GastoDedGesUF         numeric(8,2)      null,
     --salida
     Resultado             int               null, 
     Glosa1                char(50)          null,
     Glosa2     
           char(50)          null,
     Glosa3                char(50)          null,
     Glosa4                char(50)          null,
     Glosa5                char(50)          null,
     Error                 int               null,
     Iterar     
           int       default null null 
  ) 
  
  create table #Valida_Igualaos 
  ( 
  Indice                int           not null, 
  CodPrestacion         prestacion    not null, 
  Item                  tinyint       not null, 
  CantAte             
  tinyint       not null, 
  Homologo              char(20)          null 
  ) 
 
 while exists (select 1 from #PrestacionPaquete 
               where substring(Homologo,1,1) = 'P' and Iterar is null) 
 begin 
   set @vliFolMvaAux = 0
   Select top 1
   
       @MinValor = Indice, 
          @Cod_HomoPaquete = convert(char(20),Homologo), 
          @Cod_PresPaquete = CodPrestacion, 
          @Cod_ItemPaquete = Item, 
          @Can_PretPaquete = CantAte,
          @vlcClasiPresta  = ClasiPresta,
        
  @vlcCodCanasta   = CanastaGES,
          @vliFolEveGes    = FolioEventoGES
   From   #PrestacionPaquete 
   where  substring(Homologo,1,1) = 'P' 
     and  Iterar is null 
 
   Insert #Valida_Igualaos 
   Select @MinValor, @Cod_PresPaquete, @Cod_ItemPaq
uete, @Can_PretPaquete, @Cod_HomoPaquete 
 
   --//Select @MinValor, @Cod_HomoPaquete, convert(int,substring(@Cod_HomoPaquete,2,char_length(@Cod_HomoPaquete))) 
 
   Select @Cod_PaqueteHijo = NULL 
 
   --// Refierase al titulo : 'Esquema Rigido de Tipos 
de Regimen para prestaciones.' 
   Select @CodReg = 1 
   if @AfectoRecargo = 'S' and @extUrgencia = 'S' Select @CodReg = 52, @BuscaPorcentaje = 1 
   if @AfectoRecargo = 'S' and @extUrgencia = 'N' Select @CodReg = 51, @BuscaPorcentaje = 1 
   if @AfectoR
ecargo = 'N' and @extUrgencia = 'S' Select @CodReg = 52, @BuscaPorcentaje = 0 
   if @AfectoRecargo = 'N' and @extUrgencia = 'N' Select @CodReg =  1, @BuscaPorcentaje = 0 
   if @vlcClasiPresta = 'G'
      set @vliFolMvaAux = @vliFolMvaGes
   else 
      
set @vliFolMvaAux = @vliFolMva
      
   Select @Cod_Paquete     = PqaPaqPad_id, 
          @Cod_PaqueteHijo = PqaPaqHij_id,
          @NominaPaquete   = PcoCodNom_ta,
          @Porc_RecPqte    = PcoPorRec_nn
   from   convenio..PaqueteConvenido,
       
   prestacion..PaqueteExterno, 
          prestacion..PaqueteAsociado 
   where  PcoCorLat_nn = @CorDir
     and  PcoFolMva_nn = @vliFolMvaAux
     and  PcoCodPaq_ta =  convert(int,substring(@Cod_HomoPaquete,2,char_length(@Cod_HomoPaquete))) 
     and  Pc
oVigDes_fc <= @Hoy
     and  isnull(PcoVigHas_fc, @HoyMasUno) >= @Hoy
     and  PqeCodNom_id = PcoCodNom_ta
     and  PqeCodPaq_id = PcoCodPaq_ta
     and  PqeCodNom_id = PqaCodNom_id 
     and  PqeCodPaq_id = PqaPaqPad_id 
     and  PqaCodReg_id = @CodRe
g 
   
   set @TotalFilas = @@rowcount
   if @TotalFilas > 1 
   begin 
      Update #PrestacionPaquete
      set Resultado = 1
         ,Error  = 400378
         ,Glosa1 = 'Existe mas de 1 paq. para Dir.Conv.'
       where Indice = @MinValor 
       /*
 
      Select @extCodError = 'N' 
       Select @extMensajeError = 'Existe mas de 1 paq. para Dir.Conv.' --TRX DENEGADA (EI:400378) 
       return 1 
       */
   end
 
   if @Cod_PaqueteHijo is NULL 
   begin 
      Select @CodReg = 1 
 
      Select @Cod
_Paquete     = PqaPaqPad_id, 
             @Cod_PaqueteHijo = PqaPaqHij_id,
             @NominaPaquete   = PcoCodNom_ta,
             @Porc_RecPqte    = PcoPorRec_nn
      from   convenio..PaqueteConvenido,
             prestacion..PaqueteExterno, 
     
        prestacion..PaqueteAsociado 
      where  PcoCorLat_nn = @CorDir
        and  PcoFolMva_nn = @vliFolMvaAux
        and  PcoCodPaq_ta =  convert(int,substring(@Cod_HomoPaquete,2,char_length(@Cod_HomoPaquete))) 
        and  PcoVigDes_fc <= @Hoy
   
     and  isnull(PcoVigHas_fc, @HoyMasUno) >= @Hoy
        and  PqeCodNom_id = PcoCodNom_ta
        and  PqeCodPaq_id = PcoCodPaq_ta
        and  PqeCodNom_id = PqaCodNom_id 
        and  PqeCodPaq_id = PqaPaqPad_id 
        and  PqaCodReg_id = @CodReg 


      set @TotalFilas = @@rowcount
      if @TotalFilas > 1 
      begin
         Update #PrestacionPaquete
         set Resultado = 1
            ,Error  = 400378
            ,Glosa1 = 'Existe mas de 1 paq. para Dir.Conv.'
         where Indice = @MinVal
or 
         /*
         Select @extCodError = 'N' 
         Select @extMensajeError = 'Existe mas de 1 paq. para Dir.Conv.' --TRX DENEGADA (EI:400378) 
         return 1 
         */
      end
      if @TotalFilas = 0 
      begin 
         Update #Prest
acionPaquete
         set Resultado = 1
            ,Error  = 400378
            ,Glosa1 = 'Pqte en m�s de 1 espec/no conv.'
         where Indice = @MinValor 
         /*
          Select @extCodError = 'N' 
          Select @extMensajeError = 'Pqte en m
�s de 1 espec/no conv.' --TRX DENEGADA (EI:400378) 
          return 1 
          */
      end 
   end 
 
   if @BuscaPorcentaje = 0
      select @Porc_RecPqte = 0 
 
   if @Cod_PaqueteHijo is not NULL 
   begin 
     insert #Composicion_Paquete (Indice, 
  CodPrestacion,   Item,   TipoItem,    AfectoRecargo,    CantAte, 
                                  Homologo,   HomologoIMED,  TotalPrestacion, PrestacionPrestador, ItemPrestador, InternoImed, 
                                  ModalCobertura, TipoCalcu
lo, GrupoCobertura, Especialidad, 
                                  ValorDesde, 
                                  ValorHasta, 
                                  Nomina, Modalidad, TipReg, 
                                  CostoCero, CopagoFijo, ValorPr
estacion, AporteFinanciador, Copago, ValorRendicion,
                                  ClasiPresta, CanastaGES, FolioEventoGES, GastoDedGesUF,
                                  Resultado, Glosa1, Glosa2, Glosa3, Glosa4, Glosa5, Error, Iterar)
     Select 
@MinValor, CpeCodPre_id, CpeCodIte_id, '  ', 'N', CpeCanCpe_nn, 
            CpeCodExt_cr, @Cod_HomoPaquete, null, null, null, null, 
            null, null, null, null, 
            case @BuscaPorcentaje 
             when 1 then case 
                  
        when @Porc_RecPqte > 0 then round((CpeValDes_nn * (1 + round((@Porc_RecPqte / 100),2)))/CpeCanCpe_nn,0) 
                          else round(CpeValDes_nn/CpeCanCpe_nn,0) 
                         end 
             when 0 then round(CpeValDes_nn/C
peCanCpe_nn,0) 
            end, 
            case @BuscaPorcentaje 
             when 1 then case 
                          when @Porc_RecPqte > 0 then round((CpeValHas_nn * (1 + round((@Porc_RecPqte / 100),2)))/CpeCanCpe_nn,0) 
                        
  else round(CpeValHas_nn/CpeCanCpe_nn,0) 
                         end 
             when 0 then round(CpeValHas_nn/CpeCanCpe_nn,0) 
            end, 
            @NominaPaquete, CpeModVal_ta, 1, 
            'NO', null, null, null, null, null, 
        
    @vlcClasiPresta, @vlcCodCanasta, @vliFolEveGes, Null,
            1, null, null, null, null, null, 0, null 
     from   prestacion..ComposicionPaqueteExt 
     where  CpeCodNom_id = @NominaPaquete 
       and  CpeCodPaq_id = @Cod_PaqueteHijo 
       a
nd  CpeCodPre_id = @Cod_PresPaquete 
       and  CpeCodIte_id = @Cod_ItemPaquete 
       and  CpeCanCpe_nn = @Can_PretPaquete 
       and  CpeFecIni_fc <= @Hoy 
       and  (CpeFecTer_id >= @HoyMasUno or CpeFecTer_id is null) 
 
     if @@rowcount = 0 
  
   begin 
         Update #PrestacionPaquete
         set Resultado = 1
            ,Error  = 400383
            ,Glosa1 = 'Paquete no disponible en la Base'
         where Indice = @MinValor 
         /*
         Select @extCodError = 'N' 
         Selec
t @extMensajeError = 'Paquete no disponible en la Base' --TRX DENEGADA (EO:400383) 
         return 1 
         */
     end 
   end 
   else 
   begin 
         Update #PrestacionPaquete
         set Resultado = 1
            ,Error  = 400369
            
,Glosa1 = 'No se encontro un pqte. hijo'
         where Indice = @MinValor 
         /*
         Select @extCodError = 'N' 
         Select @extMensajeError = 'No se encontro un pqte. hijo' --TRX DENEGADA (EO:400369) 
         return 1 
         */
   end
 
   
   update #PrestacionPaquete 
      set Iterar = 1 
   where  substring(Homologo,1,1) = 'P' 
     and  Iterar is null 
     and  Homologo = @Cod_HomoPaquete 
     and  Indice = @MinValor 
 
 end 
 
 update #Composicion_Paquete 
    set ValorDesde = 
ValorDesde * @ValorUF, 
        ValorHasta = ValorHasta * @ValorUF 
 where  Modalidad = 'UF' 
 
 Select @TotalPrestPqte = count(*) from #Valida_Igualaos 
 
 Select @TotalPrestPqteMatch = count(*) 
 from   #Valida_Igualaos I, 
        #Composicion_Paquete 
C 
 where  I.Indice = C.Indice 
   and  I.CodPrestacion = C.CodPrestacion 
   and  I.Item = C.Item 
   and  I.CantAte = C.CantAte 
   and  I.Homologo = C.HomologoIMED 
 
 if @TotalPrestPqte != @TotalPrestPqteMatch 
 begin 
     update #Composicion_Paquete

     set Resultado = 1
        ,Error = 400383
        ,Glosa1 = 'Validacion en Composicion del paquete.'
     /*
     Select @extCodError = 'N' 
     Select @extMensajeError = 'Validacion en Composicion del paquete.' --TRX DENEGADA (EO:400383) 
     ret
urn 1 
      */
 end 
 
 Insert into #Composicion_Paquete
 Select Indice, CodPrestacion, Item, TipoItem, AfectoRecargo, CantAte, Homologo, Null, TotalPrestacion,
        PrestacionPrestador, ItemPrestador, InternoImed, ModalCobertura, TipoCalculo, GrupoCo
bertura,
        Especialidad, ValorDesde, ValorHasta, Nomina, Modalidad, TipReg, CostoCero, CopagoFijo, ValorPrestacion,
        AporteFinanciador, Copago, ValorRendicion, ClasiPresta, CanastaGES, FolioEventoGES, GastoDedGesUF, Resultado, 
        Glosa1
, Glosa2, Glosa3, Glosa4, Glosa5, Error, Iterar
 from   #PrestacionPaquete p
 where  not exists(select 1 from #Composicion_Paquete where Indice = p.Indice)
 
 insert #Composicion_Paquete 
 Select Indice, CodPrestacion, Item, TipoItem, AfectoRecargo, CantA
te, Homologo, Null, TotalPrestacion,
        PrestacionPrestador, ItemPrestador, InternoImed, ModalCobertura, TipoCalculo, GrupoCobertura,
        Especialidad, ValorDesde, ValorHasta, Nomina, Modalidad, TipReg, CostoCero, CopagoFijo, ValorPrestacion,
   
     AporteFinanciador, Copago, ValorRendicion, ClasiPresta, CanastaGES, FolioEventoGES, GastoDedGesUF, Resultado, 
        Glosa1, Glosa2, Glosa3, Glosa4, Glosa5, Error, Iterar
 from   #PrestacionValorizada 
 
 delete #PrestacionValorizada 
 
 insert #Pr
estacionValorizada 
 Select CodPrestacion, Item, TipoItem, AfectoRecargo, CantAte, Homologo, TotalPrestacion,
        PrestacionPrestador, ItemPrestador, InternoImed, ModalCobertura, TipoCalculo, GrupoCobertura,
        Especialidad, ValorDesde, ValorHast
a, Nomina, Modalidad, TipReg, CostoCero, CopagoFijo, ValorPrestacion,
        AporteFinanciador, Copago, ValorRendicion, ClasiPresta, CanastaGES, FolioEventoGES, GastoDedGesUF, Resultado, 
        Glosa1, Glosa2, Glosa3, Glosa4, Glosa5, Error, Iterar
 fro
m   #Composicion_Paquete 
 order by Indice 
  
 select @MinValor = min(Indice) from #PrestacionValorizada 
 select @MaxValor = max(Indice) from #PrestacionValorizada 
  
 Select @RenExe_fl = ConRenExe_fl , @fec_ini_veg = ConIniPla_pe 
 From contrato..Cont
rato 
 Where ConNumCto_id = @NroContrato 
   and ConMarCon_id = @Marca 
   and  ConRutCot_id = @RutCte 
       
 set @vlnGastoDedGesUF = 0
 
 While @MinValor <= @MaxValor 
 begin 
    Select @Indice = @MinValor 
    set @ErrorExec = 0
    set @cod_error =
 0
    set @GruCob = Null
    set @CobModCob_id = Null
    set @PlanAlternativo = Null
    set @PlanBonificacion = Null
    set @CodPrestacion = Null
    set @vlcCodCanasta = null
    set @vliFolEveGes = null
    
    select @CodPrestacion  = CodPrestacio
n, 
           @Item           = Item, 
           @TipoItem       = TipoItem, 
           @AfectoRecargo  = AfectoRecargo, 
           @CantAte        = CantAte, 
           @ValorDesde     = ValorDesde, 
           @ValorHasta     = ValorHasta, 
       
    @ValorNomina    = Nomina, 
           @Modalidad      = Modalidad, 
           @TipReg         = TipReg, 
           @Homologo       = Homologo, 
           @CostoCero      = CostoCero, 
           @CopagoFijo     = CopagoFijo,
           @vlcClasiPre
sta = ClasiPresta,
           @vlcCodCanasta  = CanastaGES, 
           @vliFolEveGes   = FolioEventoGES,
           @vlcModCob      = ModalCobertura
    from   #PrestacionValorizada 
    where  Indice = @MinValor 
      and  Error  = 0 
    
    Set @Mnt
RefPre = convert(int, @ValorDesde)
    set @mto_boni = 0
    set @copago = 0
    
    Select @CodLoc = LatCodLoc_ta 
    from convenio..LugarAtencion 
    where LatCorLat_nn = @CorDir 
      and LatVigDes_fc <= @Hoy
      and isNull(LatVigHas_fc, @HoyMasU
no) >= @Hoy
     
    if @CodPrestacion is not null
    begin
    -- prestacion a tratar con GES 
    if @vlcClasiPresta = 'G'
    Begin
       set @GruCob = '104'
       
       select  @vlnGastoDedGesUF = sum(isNull(GastoDedGesUF,0))
       from #Presta
cionValorizada
       where CanastaGES = @vlcCodCanasta
      
       -- calcular copago  
       exec @ErrorExec = prestacion..GES_CalculoCopago @vliFolEveGes,  @MntRefPre, @vlnGastoDedGesUF, @vlcCodCanasta, @Hoy, @CodSucursal,
                          
                            'CSALUD00', @mto_boni out, @copago out, @vlnDedGesAplicado out, 
                                                      @vlnGesAplIsapre out, @vlnGesValorUF out, @vldGesFecCob out,  @cod_error out,
                              
                        @vliCopCanasta out,   @vlnGesDedCta out,  @vlnGesDedCaso out, @vlnGesCtaCto out, 
                                                      @vlnGesDedCto out
       
       
       -- registrar resultado 
       set @operacion =  'MB'

       set @CobModCob_id = 'GES'
       
       update #PrestacionValorizada 
       set GrupoCobertura    = @GruCob,
           ModalCobertura    = @CobModCob_id, 
           TipoCalculo       = @operacion, 
           ValorPrestacion   = @MntRefPre, 
  
         AporteFinanciador = isNull(@mto_boni,0), 
           Copago            = isNull(@copago, @MntRefPre), 
           ValorRendicion    = @MntRefPre,
           GastoDedGesUF     = isNull(@vlnDedGesAplicado,0)
       where  Indice = @Indice 
    end

    else -- prestacion a tratar de forma normal  
    begin
       if ((Select count(*) From #PlanesAlternativos) > 0 and @vlcModCob <> 'LE')
       begin --// Dado que hay un Plan Alternativo, Se Buscara el primero que Devuelva distinto a 'LE'. 
        
  Select @CobModCob_id = 'LE' 
     
          While ((@CobModCob_id = 'LE')and (exists (Select 1 From #PlanesAlternativos where Iterar is null))) 
          begin 
             While exists (Select 1 From #PlanesAlternativos where Iterar is null) 
      
       begin 
                Select top 1 @PlanAlternativo = PlaCodPla_id 
                From   #PlanesAlternativos 
                where  Iterar is null 
                
                select @GruCob = GcoCodGco_id 
                from  prestacion
..SubPrestGrupCob 
                     ,prestacion..CatGruCob 
                     ,contrato..Cobertura 
                where SpgCodPre_id = @CodPrestacion 
                  and SpgCodIte_id = @Item 
                  and GcoCodGco_id = SpgCodGco_id 

                  and CobCodPla_id = @PlanAlternativo 
                  and CobGruCob_id = GcoCodGco_id 
                  and GcoTipAte_re = 'AM' 
                
                update #PrestacionValorizada 
                set GrupoCobertura   = @Gru
Cob 
                where  Indice = @Indice 
                
                exec @ErrorExec = contrato..N_PL_SerPyT_CoberturaRed  @PlanAlternativo, @GruCob, @RutCon, @FolCon,  @CorRen, 
                                                                  
    @CodLoc, @Marca, 'BO', @RenExe_fl, @NroContrato, Null, @CorDir,
                                                                      @REDCodPla_id    out, @REDModCob_id    out, @REDGruCob_id    out, 
                                                  
                    @REDCodNom_ta    out, @REDPorBon_nn    out, @REDMonTop_nn    out, 
                                                                      @REDModTop_re    out, @REDMonTopCon_nn out, @REDModTopCon_re out, 
                               
                                       @REDRanCob_nn    out, @REDMonCop_nn    out, @REDModCop_re    out, 
                                                                      @REDNivPpo_nn    out, @REDModRef_re    out, @REDCobInt_nn    out, 
            
                                                          @REDTopBac_nn    out, @REDBasAcm_nn    out, @REDBonGan_fl    out, 
                                                                      @REDPorFac_nn    out, @REDMaxBga_nn    out, @CobPerTop_fl   
 out, 
                                                                      @CobAmpGui_fl    out, @CobPorTop_nn    out, @CobFacEqi_nn    out 

                
                if @ErrorExec = 0 
                begin 
                   if @CobModCob_id 
<> 'LE' 
                   begin
                      update #PlanesAlternativos set Iterar = 1  
                      
                      set @AplicaPlanAlternativo = 1
                   end
                end 
                update #PlanesAlter
nativos 
                set Iterar = 1 
                where PlaCodPla_id = @PlanAlternativo 
                  and Iterar is null 
                
             end --While exists (Select 1 From #PlanesAlternativos where Iterar is null) 
          end 
--While ((@CobModCob_id = 'LE')and (exists (Select 1 From #PlanesAlternativos where Iterar is null)))
       end --// FIN PLANES ALTERNATIVOS... 
       
       if isNull(@CobModCob_id, 'LE') = 'LE'
       begin 
          select @GruCob = GcoCodGco_id 
 
         from   prestacion..SubPrestGrupCob 
                ,prestacion..CatGruCob 
                ,contrato..Cobertura 
          where  SpgCodPre_id = @CodPrestacion 
            and  SpgCodIte_id = @Item 
            and  GcoCodGco_id = SpgCodGco_id 

            and  CobCodPla_id = @extPlan
            and  CobGruCob_id = GcoCodGco_id 
            and  GcoTipAte_re = 'AM' 
          
          update #PrestacionValorizada 
          set GrupoCobertura   = @GruCob 
          where  Indice = @Indice 
 
      end
       
       if @AplicaPlanAlternativo = 1
          set @PlanBonificacion = @PlanAlternativo
       else
          set @PlanBonificacion = @extPlan
       exec @ErrorExec = contrato..SerPyT_CoberturaConGuindasFIN @PlanBonificacion,     @GruCo
b, @RutCon, 
                                                                 @FolCon,      @CorRen, @CodLoc, 
                                                                 @NroContrato, @Marca, 
                                                        
         'BO', @vlcModCob,          --FR 2393 @vlcModCob reemplaza a valor 'XX',
                                                                 @CobCodPla_id    Output, @CobModCob_id    Output, 
                                                          
       @CobGruCob_id    Output, @CobCodNom_ta    Output, 
                                                                 @CobPorBon_nn    Output, @CobMonTop_nn    Output, 
                                                                 @CobModTop_re   
 Output, @CobMonTopCon_nn Output, 
                                                                 @CobModTopCon_re Output, @CobRanCob_nn    Output, 
                                                                 @CobMonCop_nn    Output, @CobModCop_re 
   Output, 
                                                                 @CobNivPpo_nn    Output, @PlaModRef_re    Output, 
                                                                 @PlaCobInt_nn    Output, @PlaTopBac_nn    Output, 
           
                                                      @PlaBasAcm_nn    Output, @PlaBonGan_fl    Output, 
                                                                 @PlaPorFac_nn    Output, @GtaMaxBga_nn    Output, 
                                  
                               @BenEspAplicados Output, @CobPerTop_fl    Output, 
                                                                 @CobAmpGui_fl    Output, @CobPorTop_nn    Output, 
                                                         
        @CobFacEqi_nn    Output ,
                                                                 -- FR 33137
                                                                 @CodPrestacion,          @Hoy,
                                                
                 @MntRefPre, null, @CorDir
       
       if @ErrorExec = 0 
       begin --// Obtencion de Linea de Cobertura Exitosa 
          Select @boni_pend = 0 
          
          Select @boni_pend = isnull(sum(AporteFinanciador),0) 
          f
rom   #PrestacionValorizada 
          where  GrupoCobertura is not null 
           and  GrupoCobertura = @GruCob 
           and  Error = 0 
          
          Select @ErrorExec = 0, @cod_error = 0 
          
          Select @ValorDesde = convert(nu
meric(11,2),@ValorDesde) 
          Select @ValorHasta = convert(numeric(11,2),@ValorHasta) 
          
          exec @ErrorExec = prestacion..Calculo_Bonificacion @RutCte,          @NroContrato, 
                                                        @
Marca,           @cor_car, 
                                                        @Hoy,             @extPlan, 
                                                        @CodPrestacion,   @Item, 
                                                        @Can
tAte,         @ValorDesde, 
                                                        @ValorHasta,      @Modalidad, 
                                                        @CostoCero,       @CopagoFijo, 
                                                    
    100,             'N', 
                                                        @boni_pend,       @CobModCob_id, 
                                                        @CobGruCob_id,    @CobCodNom_ta, 
                                                
        @CobPorBon_nn,    @CobMonTop_nn, 
                                                        @CobModTop_re,    @CobMonCop_nn, 
                                                        @CobModCop_re,    @PlaModRef_re, 
                                 
                       @PlaBonGan_fl,    @GtaMaxBga_nn, 
                                                        @BenEspAplicados, @CobPerTop_fl, 
                                                        @CobAmpGui_fl,    @CobPorTop_nn, 
                  
                                      @CobFacEqi_nn, 
                                                        @por_boni       output, 
                                                        @mto_boni       output, 
                                       
                 @copago         output, 
                                                        @mto_presta     output, 
                                                        @operacion      output, 
                                                   
     @mensaje        output, 
                                                        @Cambia_Linea   output, 
                                                        @guindas        output, 
                                                        @CobPer
OUT_fl   output, 
                                                        @CobAmpOUT_fl   output, 
                                                        @CobPorOUT_nn   output, 
                                                        @CobFacOUT_nn   out
put, 
                                                        @ValAraCal_nn   output, 
                                                        @ModAraCal_cr   output, 
                                                        @MntoTopeCto    output, 
      
                                                  @MntoTopeEve    output, 
                                                        @MntoTopeInt    output,
                                                        @CorDir
 
          if (@ErrorExec = 0) and 
((@cod_error = 0)or(@cod_error is null)) 
          begin --// Bonificacion Exitosa 
             if @CorDir in (82649, 64245, 68414, 64263, 50578)
             begin
                exec prestacion..BHO_GetCopagoFijo_Ambulatorio @extPlan, @CobGruCob_id, 
@CodPrestacion, @Hoy, @vliRutConReal, @FolCon, @CorDir,
                                                         @mto_presta, @mto_boni, @copago, @CantAte, @vlcAplCop out, @vliMtoBon_GCP out, @vliMtoCop_GCP out
                
                if (@vlcApl
Cop = 'S' and @vliMtoBon_GCP is not null and @vliMtoCop_GCP is not null)
                begin
                   set @operacion =  'CF'
                   set @mto_boni  =  @vliMtoBon_GCP
                   set @copago    =  @vliMtoCop_GCP
              
  end
             end
             update #PrestacionValorizada 
             set ModalCobertura    = @CobModCob_id, 
                 TipoCalculo       = @operacion, 
                 ValorPrestacion   = @mto_presta, 
                 AporteFinanciador 
= @mto_boni, 
                 Copago            = @copago, 
                 ValorRendicion    = @mto_presta
             where  Indice = @Indice 
          end   --// FIN Bonificacion Exitosa 
          else 
          begin --// Bonificacion Fallida 
 
         if @cod_error != 0  or @ErrorExec != 0
          begin  
             update #PrestacionValorizada  
             set Error      =  case when @cod_error  > @ErrorExec then @cod_error else @ErrorExec end
                ,Resultado  =  1
          
   where  Indice = @Indice  
          end  
          end 
       end --// FIN Obtencion de Linea de Cobertura Exitosa 
       else 
       begin --// Error en la Linea de Cobertura 
          update #PrestacionValorizada 
          set Error  = @ErrorEx
ec
             ,Resultado = 1 
          where  Indice = @Indice 
       end 
    end -- prestacion no es GES 
    end --prestacion tiene valor
   
    update #PlanesAlternativos 
    set Iterar = NULL 
 
    Select @MinValor = @MinValor + 1 
 end 
 
 
 
--// Control In necesario en las pruebas de CAPACITACION, pero SI 
 --// en PRODUCCION. 
 if rtrim(ltrim(@db_name)) = 'prestacion' 
  begin 
   if exists (Select 1 
              From   #PrestacionValorizada 
              where  GrupoCobertura in ('24', 
'300', '301', '302', '303')) 
    begin 
     --// Control de Frecuencia en las consultas.... 
     --// 
     --// Denegar la valorizacion para cualquier carga que en las ultimas cuatro 
     --// semanas tenga mas de 6 bonos de consulta, emitidos en la 
surcursales 
     --// I-MED. Esto ultimo, para cualquier efecto es la sucursal 130600 
 
     exec @ErrorExec = prestacion..Sel_FrecPrestaciones @RutCte, @NroContrato, 
                                                        @Marca,  @cor_car, 
         
                                               4,       2, 
                                                        @TotalPrest output 
     if @ErrorExec != 0 
      begin 
       Select @extCodError = 'N' 
       Select @extMensajeError = 'Consulta Frec
. Prest.' 
       return 1 
      end 
 
        -- controlar el total de prestaciones en sesion + la historia -- FR-7787 
        Select @TotalPrest = @TotalPrest + count(*) 
          From #PrestacionValorizada 
         where GrupoCobertura in ('24', '
300', '301', '302', '303') 
 
 
     if @TotalPrest > 6  -- Modificado por FR-9155 
      begin 
       Select @extCodError = 'N' 
       --//Select @extMensajeError = 'EXCESO CONSULTA,ASISTIR ISAPRE' 
       Select @extMensajeError = 'EXCEDE CONSUL IMED 
IR A ISAPRE' 
       return 1 
      end 
    end 
  end --// FIN if rtrim(ltrim(@db_name)) = 'prestacion' 
 
 Select @extCodError = 'S' 
 Select @extMensajeError = '' 

   -- Control de grupos de cobertura
   Update #PrestacionValorizada
   set Resultado
 = 1
      ,Error = 400899   --no clasificado
      ,Glosa1 = 'PREST. SIN GRUPO COBERTURA'
   where Error = 0
     and isNull(GrupoCobertura,space(4)) = space(4)
   
   Update #PrestacionValorizada
   set Resultado = 1
      ,Error = 400899
      ,Glosa1 
= 'PREST. SIN GRUPO COBERTURA TC'
   where Error = 0
     and isNull(TipoCalculo, space(2)) = space(2)
     
   
 --// Generacion de los registros de log de control. 

   --respuesta
   Select @DigCon = substring(ltrim(rtrim(@extRutConvenio)),charindex('-
',ltrim(rtrim(@extRutConvenio)))+1,1) 
   
   Select @DigBen = substring(ltrim(rtrim(@extRutBeneficiario)), 
                    charindex('-',ltrim(rtrim(@extRutBeneficiario)))+1,1) 
   
   Select @RutCot = convert(int,substring(ltrim(rtrim(@certifRutCot
izante)),1, 
                    charindex('-',ltrim(rtrim(@certifRutCotizante)))-1)) 
   
   Select @DigCot = substring(ltrim(rtrim(@certifRutCotizante)), 
                    charindex('-',ltrim(rtrim(@certifRutCotizante)))+1,1) 
   
   
   Select  extR
esultado         = isNull(Resultado, 0),
           extValorPrestacion   = convert(numeric(12,0),isNull(ValorPrestacion,0)), 
           extAporteFinanciador = convert(numeric(12,0),isNull(AporteFinanciador,0)), 
           extCopago            = convert(
numeric(12,0),isNull(ValorPrestacion - AporteFinanciador,0)), 
           extCodPreFin         = '',
           extCodItemFin        = '',
           extInternoIsa        = case Resultado
                                      when 1 then ''
              
                        else
                                                  convert(char(15), 
                                                  replicate('0',3 - char_length(ltrim(rtrim(GrupoCobertura))))+ 
                                            
      ltrim(rtrim(GrupoCobertura))+ 
                                                  
                                                  ltrim(rtrim(ModalCobertura))+ 
                                                  replicate(' ',4 - char_length(ltrim(
rtrim(ModalCobertura))))+ 
                                                  
                                                  ltrim(rtrim(TipoCalculo))+ 
                                                  replicate(' ',2 - char_length(ltrim(rtrim(TipoCal
culo))))+ 
                                                  
                                                  replicate('0',6 - char_length(ltrim(rtrim(convert(char(6),ValorRendicion)))))+ 
                                                            ltr
im(rtrim(convert(char(6),ValorRendicion))) )
                                  end,
           extTipoBonif1        = 0,
           extCopago1           = 0, 
           extTipoBonif2        = 0,
           extCopago2           = 0,
           extTipoBoni
f3        = 0,
           extCopago3           = 0,
           extTipoBonif4        = 0,
           extCopago4           = 0,
           extTipoBonif5        = 0,
           extCopago5           = 0,
           extClasiPresta       = ' ' + isNull(ClasiPre
sta, 'N'),
           extCodAgrupa         = isNull(CanastaGES,''),
           extGlosa1            = isNull(Glosa1,''),
           extGlosa2            = isNull(Glosa2,''),
           extGlosa3            = isNull(Glosa3,''),
           extGlosa4        
    = isNull(Glosa4,''),
           extGlosa5            = isNull(Glosa5,''),
           extVarFinan          = space(255)
   From    #PrestacionValorizada 
   order by Indice 
 
   if @vliFlagResultado = 1
   begin
      Exec prestacion..InsCabValPre @Fo
lio, @FecHorTrx, @extPlan, @extCodError, @extMensajeError, @RutCot, @RutCon, @CorDir, @vliFlagResultado
      Select @MinValor = min(Indice)-1 from #PrestacionValorizada
      Insert into prestacion..Log_SalDetValPre (isa_DetNroTrx, isa_CorTrxPre, isa_Res
ultado, isa_Prestacion, isa_Item, 
                                                isa_ValorPrestacion, isa_AporteFinanciador, isa_Copago,
                                                isa_CodPreFin, isa_CodItemFin, 
                                    
            isa_InternoIsa, 
                                                isa_ClasiPresta, isa_CodAgrupa, isa_Error, isa_Glosa1, isa_VarFinan)
      Select  @Folio, Indice - @MinValor, isNull(Resultado, 0), CodPrestacion, Item, 
              isNull(Va
lorPrestacion,0), isNull(AporteFinanciador,0), isNull(ValorPrestacion - AporteFinanciador,0), 
              null, null, 
              isNull(convert(char(15), replicate('0',3 - char_length(ltrim(rtrim(GrupoCobertura))))+ 
                      ltrim(rtr
im(GrupoCobertura))+ 
                      ltrim(rtrim(ModalCobertura))+ 
                      replicate(' ',4 - char_length(ltrim(rtrim(ModalCobertura))))+ 
                      ltrim(rtrim(TipoCalculo))+ 
                      replicate(' ',2 - char_
length(ltrim(rtrim(TipoCalculo))))+ 
                      replicate('0',6 - char_length(ltrim(rtrim(convert(char(6),ValorRendicion)))))+ 
                      ltrim(rtrim(convert(char(6),ValorRendicion))) 
                      ),''),
              isNu
ll(ClasiPresta, 'N'), CanastaGES, Error, Glosa1, null
      From #PrestacionValorizada
      Order by Indice
   end

end                                                                                                                                       
(504 rows affected)
(return status = 0)
1> 