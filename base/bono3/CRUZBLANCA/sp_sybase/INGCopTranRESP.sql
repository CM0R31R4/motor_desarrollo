locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
317
(1 row affected)
text
create procedure dbo.INGCopTranRESP
(
 @extCodFinanciador     smallint,
 @extHomNumeroConvenio  char(15),
 @extHomLugarConvenio   char(10),
 @extSucVenta           char(10),
 @extRutConvenio        char(12),
 @extRutTratante        char(12),
 @extRutSolic
itante     char(12),
 @extRutBeneficiario    char(12),
 @extTratamiento        char(1),
 @extCodigoDiagnostico  char(10),
 @extNivelConvenio      tinyint,
 @extUrgencia           char(1),
 @extLista1             char(255),
 @extLista2             char(255
),
 @extLista3             char(255),
 @extLista4             char(255),
 @extLista5             char(255),
 @extLista6             char(255),
 @extNumPrestaciones    tinyint,
 @extCodError           char(1)    output,
 @extMensajeError       char(30)   o
utput,
 @extPlan               char(15)   output
)
/*
   procedimiento : INGCopTran
   Autor         : Cristian Rivas Rivera.

   Parametros I
       @extCodFinanciador     : Código del Financiador
       @extHomNumeroConvenio  : Homólogo numero de conven
io (11c para Codigo+'-'+ 3c para corr renov)
       @extHomLugarConvenio   : Homólogo Lugar de convenio (Corr. Dirección)
       @extSucVenta           : Homólogo Sucursal de Venta (código Sucursal)
       @extRutConvenio      : Rut Convenio, R.u.t. del p
restador en convenio
       @extRutTratante        : Rut Tratante, R.u.t. del médico tratante o solicitante de examenes.
       @extRutSolicitante     : Rut Solicitante, R.u.t. de quien solicita el beneficio.
       @extRutBeneficiario      : RUT del Bene
ficiario
       @extTratamiento        : Tratamiento médico ('S','N')
       @extCodigoDiagnostico  : Código de Diagnostico, según CIE 10
       @extNivelConvenio      : nivel convenido con el prestador 1,2,3
       @extLista1             : lista de prest
aciones
                                10c para la Prestacion (7c Cod.Prestacion 3c para Item)
                                1c pipe (|)
                                1c para el tipo de item (H:Honorario, P:Pabellon)
                                1
c pipe (|)
                                15c Codigo Adicional,
                                1c pipe (|)
                                1c pipe el recargo hora (S:Si, N:No)
                                1c pipe (|)
                                2
c para la cantidad
                                1c pipe (|)
       @extLista2             : Idem Lista1,
       @extLista3             : Idem Lista1,
       @extLista4             : Idem Lista1,
       @extLista5             : Idem Lista1,
       @extL
ista6             : Idem Lista1,

       @extNumPrestaciones    : Número de Prestaciones enviadas en este acto de
                                ventas.

   Parametros O
       @extCodError        : Código de Error ('S','N')
                             
   S = estador exitoso de la transaccion
                                N = fallo o error en transaccion
       @extMensajeError       : Mensaje de Error.
       @extPlan               : Plan con el cual se Bonificará.

   ------------------------
   |Se
rvicios para C-Salud |
   ------------------------

 Descripción

   Este Servicio que envía datos de todas las líneas de prestaciones
   al financiador; el que calcula cual es el valor de cada prestacion
   y cuanto le corresponde al beneficiario

   Pru
eba

   declare
    @extCodError    char(1),
    @extMensajeError  char(30),
    @extPlan          char(20)

   exec prestacion..INGCopTran 78, '34845-0', '61754','130001',
                          '96770100-9','10206760-6','0005308213-0','0005308213-0',

                          'S','XXXXXXXXXX',3,'S',
                         '0202004000|H|202965-1|N|01|1602017000|H|315006-1|N|03|',
                         '','','','','',3,
                         @extCodError output, @extMensajeError output, @extPla
n output

   declare
    @extCodError      char(1),
    @extMensajeError  char(30),
    @extPlan        char(20)

   exec prestacion..INGCopTran 78, '40002-000', '70002','130001',
                               '0096840380-K','0000000000-0','0005308213-0'
,'0005308213-0',
                               'S','XXXXXXXXXX',3,'S',
                               '1707001000|H|               |N|01|1707002000|H|               |N|01|1707001000|H|               |N|01|',
                               '','','','','',
3,
                               @extCodError output, @extMensajeError output, @extPlan output

*/
As

/*declare @t int

select @t=campo
from migracion..trancount2

insert migracion..trancount
select @@trancount
*/
declare @Ini char(26),@Fin char(26),@In
i2 char(26)
select @Ini=convert(char(26),getdate(),109)


declare
         @Hoy                   fecha,
         @ErrorExec             int,

         @extApellidoPat        char(30),
         @extApellidoMat        char(30),
         @extNombres        
    char(40),
         @extSexo               char(1) ,
         @extFechaNacimi        fecha,
         @extCodEstBen          char(1) ,
         @extDescEstado         char(15),
         @extRutCotizante       char(12),
         @extNomCotizante       ch
ar(40),
         @extDirPaciente        char(40),
         @extGloseComuna        char(30),
         @extGloseCiudad        char(30),
         @extPrevision          char(1),
         @extGlosa              char(40),
         @extDescuentoxPlanilla char(1
) ,
         @extMontoExcedente     int,
         @extRutAcompananate    char(12),
         @extNombreAcompanante  char(40),

         @ValorUF               numeric(10,2),
         @CodSucursal           sucursal,

         @Marca                 marca,

         @RutCon                rut,
         @RutTra                rut,
         @RutSol                rut,
         @RutBen                rut,
         @FolCon                int,
         @CorRen                tinyint,
         @CorDir             
   int,

         @FolConAlter           int,
         @CorRenAlter           tinyint,
         @TotConAlter           int,

         @NroContrato           contrato,
         @RutCte                rut,
         @cor_car               char(2),
         @
tipo_carga            char(1),

         @Cuenta_Lista          tinyint,
         @Total_Listas          tinyint,

         @extListaAUX           char(255),
         @extListaX             char(255),
         @MinValor              numeric(10,5),
       
  @MaxValor              numeric(10,5),

         @CodPrestacion         prestacion,
         @varCadena             char(35),
         @TipoItem              char(2),
         @HomologoPrestador     char(20),
         @AfectoRecargo         char(1),
    
     @ValorDesde            numeric(14,4),
         @ValorHasta            numeric(14,4),
         @Item                  tinyint,
         @CodEsp                char(3),
         @CantAte               tinyint,
         @ValorNomina           smallint,

         @Modalidad             char(2),
         @ErrorCode             int,

         @RecalculoRegimen      char(1),
         @Indice                numeric(5,0),
         @Homologo              char(20),
         @AccionPresta          regla,
        
 @CostoCero             char(2),
         @ItemReal              tinyint,
         @OrigenAtencion        char(1),
         @CodReg                tinyint,
         @Urgencia              char(1),
         @Recargo               char(1),
         @Combina
toria          char(50),
         @Combinatoria2         char(50),
         @Combinatoria3         char(50),
         @CodPrest              prestacion,
         @CodItem               tinyint,
         @CodHomo               char(20),
         @ModVal   
             regla,
         @TipReg                tinyint,
         @CopagoFijo            int,
         @ValAra                numeric(10,2),
         @TotalFilas            int,
         @NominaPaquete         smallint,
         @out_CodNom           
 smallint,
         @out_CodPrest          prestacion,
         @out_CodItem           tinyint,
         @out_CodReg            tinyint,
         @out_CodHomo           char(20),
         @out_Desde             numeric(14,4),
         @out_Hasta          
   numeric(14,4),
         @out_Modalidad         regla,
         @out_CoPagoFijo        integer,
         @out_ErrorCode         int,
         @out_Metodo            char(2),

         @PorceRecargo          numeric(5,2),
         @Colectivo             
int,
         @GruCob                char(4),
         @CodLoc                localidad,
         @CobCodPla_id          codpla,
         @CobModCob_id          Char(4),
         @CobGruCob_id          Char(4),
         @CobCodNom_ta          Smallint,
  
       @CobPorBon_nn          Numeric(5,2),
         @CobMonTop_nn          Numeric(11,2),
         @CobModTop_re          modal,
         @CobMonTopCon_nn       Numeric(11,2),
         @CobModTopCon_re       char(4),
         @CobRanCob_nn          Numer
ic(11,2),
         @CobMonCop_nn          Numeric(11,2),
         @CobModCop_re          char(4),
         @CobNivPpo_nn          Tinyint,
         @PlaModRef_re          regla,
         @PlaCobInt_nn          Numeric(11,2),
         @PlaTopBac_nn        
  Numeric(11,2),
         @PlaBasAcm_nn          Numeric(11,2),
         @PlaBonGan_fl          Char(1),
         @PlaPorFac_nn          Tinyint,
         @GtaMaxBga_nn          numeric(5,2),
         @BenEspAplicados       char(250),
         @guindas   
            Char(250),
         @boni_pend             numeric(11,2),
         @por_boni              numeric(5,2),
         @mto_boni              numeric(11,2),
         @copago                numeric(11,2),
         @mto_presta            numeric(11,2)
,
         @operacion             char(2),
         @mensaje               char(120),
         @tiene_tope            flag,
         @fec_ini_veg           fecha,
         @DigCon                dv,
         @DigBen                dv,
         @RutCot    
            rut,
         @DigCot                dv ,
         @Corr_logControl       int,

         @DescSocAlemana        int,
         @ValRendir             int,
         @EsSocioAlemana        char(1),
         @mto_boniReal          int,
         @c
opagoReal            int,
         @mto_prestaReal        int,
         @DescEnPesos           int , --//numeric(5,2),
         @Hoy_log               fecha,

         @ValorPrestacion       int,
         @AporteFinanciador     int,

         @extPlanAlte
rnativo    char(15),
         @CodCataPrest          prestacion,
         @cod_error             int,

         @TotalPrest            int,

         @RenExe_fl             flag,
         @REDCodPla_id          codpla,
         @REDModCob_id          Char
(4),
         @REDGruCob_id          Char(4),
         @REDCodNom_ta          Smallint,
         @REDPorBon_nn          Numeric(5,2),
         @REDMonTop_nn          Numeric(10,2),
         @REDModTop_re          modal,
         @REDMonTopCon_nn       Num
eric(10,2),
         @REDModTopCon_re       modal,
         @REDRanCob_nn          Smallint,
         @REDMonCop_nn          Numeric(10,2),
         @REDModCop_re          modal,
         @REDNivPpo_nn          Tinyint,
         @REDModRef_re          reg
la,
         @REDCobInt_nn          Numeric(11,2),
         @REDTopBac_nn          Smallint,
         @REDBasAcm_nn          Smallint,
         @REDBonGan_fl          Char(1),
         @REDPorFac_nn          Tinyint,
         @REDMaxBga_nn          Smalli
nt

begin

  select @Ini2=convert(char(26),getdate(),109)

  begin tran uno

   insert Log_EntradasCopTran
          (ext_FechaHoraTRX, extCodFinanciador, extHomNumeroConvenio,
           extHomLugarConvenio, extSucVenta, extRutConvenio, extRutTratante,
 
          extRutSolicitante, extRutBeneficiario, extTratamiento, extCodigoDiagnostico,
           extNivelConvenio, extUrgencia, extLista1, extLista2, extLista3,
           extLista4, extLista5,  extLista6, extNumPrestaciones)
   values  (getdate(), @extC
odFinanciador, @extHomNumeroConvenio,
            @extHomLugarConvenio, @extSucVenta, @extRutConvenio, @extRutTratante,
            @extRutSolicitante, @extRutBeneficiario, @extTratamiento, @extCodigoDiagnostico,
            @extNivelConvenio, @extUrgenci
a, @extLista1, @extLista2, @extLista3,
            @extLista4, @extLista5,  @extLista6, @extNumPrestaciones)

  if @@error != 0
   begin
    rollback tran uno
    Select @extCodError = "N"
    Select @extMensajeError = "TRX DENEGADA (EI:400365)"
    --ret
urn 1
   end

  commit tran uno

  select @Fin=convert(char(26),getdate(),109)
  insert Tiempos values("P5z",@Ini2,@Fin)

  select @Ini2=convert(char(26),getdate(),109)

 create table #PrestacionValorizada
 (
  Indice                numeric(10,0) identity
,
  CodPrestacion         prestacion    not null,
  Item                  tinyint       not null,
  TipoItem              char(2)           null,
  AfectoRecargo         char(1)           null,
  CantAte               tinyint       not null,
  ModalCobert
ura        char(4)           null,
  TipoCalculo           regla             null,
  GrupoCobertura        char(4)           null,
  Especialidad          char(3)           null,
  ValorDesde            numeric(14,4)     null,
  ValorHasta            nume
ric(14,4)     null,
  Nomina                smallint          null,
  Modalidad             char(2)           null,
  TipReg                tinyint           null,
  Homologo              char(20)          null,
  CostoCero             char(2)           n
ull,
  CopagoFijo            int               null,
  ValorPrestacion       numeric(12,0)     null,
  AporteFinanciador     numeric(12,0)     null,
  Copago                numeric(12,0)     null,
  ValorRendicion        int               null,
  Error   
              int               null,
  Iterar                int       default null null
 )

   select @Fin=convert(char(26),getdate(),109)
  insert Tiempos values("P50",@Ini2,@Fin)

 --// Obtención de la Fecha del Dia. FECHA DEL SERVIDOR SYBASE.
 Select
 @Hoy          = convert(smalldatetime,convert(char(10),getdate(),101))

 --// VALOR DE LA U.F. de la fecha de atención.

  select @Ini2=convert(char(26),getdate(),109)
  exec @ErrorExec = convenio..Fecha_UFIPC @Hoy, @ValorUF output
  select @Fin=convert(
char(26),getdate(),109)
  insert Tiempos values("P51",@Ini2,@Fin)

 if @ErrorExec != 0
  begin
   Select @extCodError = 'N'
   Select @extMensajeError = 'TRX DENEGADA (EI:400366)'

   select @Fin=convert(char(26),getdate(),109)

   insert Tiempos values("
P5",@Ini,@Fin)


   return 1
  end

 --// Validadcion de la Certificación del Beneficiario. Importante Rescatar el
 --// Plan vigente del contrato.

 select @Ini2=convert(char(26),getdate(),109)
 exec @ErrorExec = prestacion..INGBenCertif_out @extCodFinan
ciador, @extRutBeneficiario, @Hoy,
                                                @extApellidoPat        output, @extApellidoMat        output,
                                                @extNombres            output, @extSexo      output,
         
                                       @extFechaNacimi        output, @extCodEstBen          output,
                                                @extDescEstado         output, @extRutCotizante       output,
                                            
    @extNomCotizante       output, @extDirPaciente        output,
                                                @extGloseComuna        output, @extGloseCiudad        output,
                                                @extPrevision          output, 
@extGlosa    output,
                                                @extPlan               output, @extDescuentoxPlanilla output,
                                                @extMontoExcedente     output, @extRutAcompananate output,
                 
                               @extNombreAcompanante  output

 select @Fin=convert(char(26),getdate(),109)
 insert Tiempos values("P52",@Ini2,@Fin)
 if @ErrorExec != 0
  begin
   Select @extCodError = 'N'
   Select @extMensajeError = 'TRX DENEGADA (EI:400
367)'

   select @Fin=convert(char(26),getdate(),109)

   insert Tiempos values("P5",@Ini,@Fin)

   return 1
  end

 if @extCodEstBen != 'C'
  begin
   Select @extCodError = 'N'
   Select @extMensajeError = 'TRX DENEGADA (EI:400368)'

   select @Fin=conve
rt(char(26),getdate(),109)
   insert Tiempos values("P5",@Ini,@Fin)

   return 1
  end

 --// Conversión del codigo sucursal ORDEN a formate CD-ING
 Select @CodSucursal = convert(char(6),ltrim(rtrim(@extSucVenta)))

 --// Determinación de la Marca en func
ion del Prestador.
 if @extCodFinanciador = 74 Select @Marca = 'AS'
 if @extCodFinanciador = 78 Select @Marca = 'CB'

 --//conversión del Rut del Prestador
 Select @RutCon = convert(int,substring(ltrim(rtrim(@extRutConvenio)),1,charindex('-',ltrim(rtrim(@
extRutConvenio)))-1))
 --//conversión del RUT del Beneficiario
 Select @RutBen = convert(int,substring(ltrim(rtrim(@extRutBeneficiario)),1,charindex('-',ltrim(rtrim(@extRutBeneficiario)))-1))
 --// folio del convenio y correlativo de renovacion
 Select @F
olCon = convert(int,substring(ltrim(rtrim(@extHomNumeroConvenio)),1,charindex('-',ltrim(rtrim(@extHomNumeroConvenio)))-1))
 Select @CorRen = convert(tinyint,substring(@extHomNumeroConvenio,char_length(@extHomNumeroConvenio),1))
 --// Correlativo de direcc
ion.
 Select @CorDir = convert(int,ltrim(rtrim(@extHomLugarConvenio)))

 --// Determinación de los convenios preferenciales (Exclusivos) asociados al Plan vigente.
 Select  @FolConAlter = 0,
         @CorRenAlter = 0,
         @TotConAlter = 0
 select @In
i2=convert(char(26),getdate(),109)
 exec INGVerPlanExcl @RutCon, @Marca, @extPlan,
                       @FolConAlter output,
                       @CorRenAlter output,
                       @TotConAlter output

 select @Fin=convert(char(26),getdate(),
109)
 insert Tiempos values("P53",@Ini2,@Fin)

 if @TotConAlter = 1
  begin
   --// El convenio JUMBO. Se aplica para todos los integramedica.
   --// Esto significa que un beneficiario del colectivo Jumbo, debe
   --// identificarse como tal, ante la per
sona que venda bonos a traves
   --// del sistema IMED.

   --// Se ha informado Integramedica centro, como convenio del colectivo.
   --// ademas existe como convenio exclusivo, para el prestador y para un
   --// plan.

   --// REGLA DE NEGOCIO
   --// 
Si el convenio Exclusivo es igual al convenio entrante.
   --// ME QUEDO CON LOS DATOS DEL CONVENIO ENTRANTE.

   --// TRATAMIENTO CONV.EXCLUSIVOS C/+ de 1 DIRECCION
   --// En el caso que el Prestador posea mas de una direccion de atencion
   --// en uno
 de sus convenios exclusivos. Se debera consultar en una tabla
   --// la direccion a utilizar a una tabla cuyos argumentos de entrada son
   --// el convenio exclusivo determinado y la direccion de atencion que
   --// originalmente entro a esta rutina.


   --// convenio Entrante es además el convenio exclusivo
   if((@FolCon = @FolConAlter) and (@CorRen = @CorRenAlter))
    begin
     --// igualo los convenios.
     Select @FolConAlter = @FolCon,
            @CorRenAlter = @CorRen
    end

   --// debo 
determinar una nueva direccion de atencion.
   if not ((@FolCon = @FolConAlter) and (@CorRen = @CorRenAlter))
    begin
     --// Esta Direccion Debiera ser siempre unica en su convenio.
     --// De haber mas de una se declara inclompetenicia.

     --//
 TRATAMIENTO CONV.EXCLUSIVOS C/+ de 1 DIRECCION
     --// ----------------------------------------------
     --// ESTO ES UN PARCHE. Debe montarse una tabla de equivalencias, para lograr
     --// lo expuesto mas arriba bajo este mismo titulo.
     --//

     --// INICIO PARCHE TRATAMIENTO CONV.EXCLUSIVOS C/+ de 1 DIRECCION
     Select @CorDir = convert(int,ltrim(rtrim(@extHomLugarConvenio)))

     if ((@extHomNumeroConvenio = '00000039755-000')and(@extHomLugarConvenio = '0071893'))
      begin
        if
 @FolConAlter = 43191 and @CorRenAlter = 0
          Select @FolCon = 43191, @CorRen = 0, @CorDir = 72004
        else
         begin
          Select @extCodError = 'N'
          Select @extMensajeError = 'TRX DENEGADA (EO:400379'
          --return 1
  
       end
      end
     else
      begin
       if ((@extHomNumeroConvenio = '00000039755-000')and(@extHomLugarConvenio = '0071894'))
        begin
         if @FolConAlter = 43191 and @CorRenAlter = 0
          Select @FolCon = 43191, @CorRen = 0, @Cor
Dir = 72005
          else
           begin
            Select @extCodError = 'N'
            Select @extMensajeError = 'TRX DENEGADA (EO:400379)'
            --return 1
           end
        end
       else
       if ((@extHomNumeroConvenio = '000000343
82-000')and(@extHomLugarConvenio = '0061203'))
        begin
         if @FolConAlter = 37639 and @CorRenAlter = 0
          Select @FolCon = 37639, @CorRen = 0, @CorDir = 65243
          else
           begin
            Select @extCodError = 'N'
       
     Select @extMensajeError = 'TRX DENEGADA (EO:400379)'
            --return 1
           end
        end
       --// FIN PARCHE TRATAMIENTO CONV.EXCLUSIVOS C/+ de 1 DIRECCION
       else
        begin
         Select @FolCon = @FolConAlter,
           
     @CorRen = @CorRenAlter

         Select @CorDir = DatCorDir_id
         From   convenio..DireccionAtencion
         where  DatFolCon_ta = @FolCon
           and  DatCorRen_ta = @CorRen

         if @@rowcount != 1
          begin
           Select @e
xtCodError = 'N'
           Select @extMensajeError = 'TRX DENEGADA (EO:400376)'
           --return 1
          end
        end
      end
    end
  end

 if @TotConAlter > 1
  begin
   Select @extCodError = 'N'
   Select @extMensajeError = 'TRX DENEGADA 
(EO:400375)'
   --return 1
  end

 /* COMENTADO POR OPTIMIZACION. OBJ: disminuir uso de tablas temporales
 create table #Beneficiarios
 (
  BenRutBen_nn    rut,
  BenMarCon_id    marca,
  BenIniVig_fc    fecha,
  BenTerVig_fc fecha,
  BenApePat_ds   apell
ido,
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
 Sele
ct  BenRutBen_nn, BenMarCon_id, BenIniVig_fc, BenTerVig_fc,
         BenApePat_ds, BenApeMat_ds, BenNom_ds,    BenSex_fl,
         BenFecNac_fc, BenNumCto_id, BenRutCot_id, BenCorCar_id,
         BenTip_fl
 from    contrato..Beneficiario
 where   BenRutBe
n_nn = @RutBen
 */

 Select @NroContrato = BenNumCto_id,
        @cor_car     = BenCorCar_id,
        @tipo_carga  = BenTip_fl,
        @RutCte      = BenRutCot_id
 --// COMENTADO POR OPTIMIZACION. OBJ: disminuir uso de tablas temporales
 --// from   #Ben
eficiarios
 from   contrato..Beneficiario
 where  BenRutBen_nn = @RutBen
   and  BenMarCon_id = @Marca
   and  BenIniVig_fc <= @Hoy
   and  BenTerVig_fc >= @Hoy

 --// COMENTADO POR OPTIMIZACION. OBJ: disminuir uso de tablas temporales
 --//drop table #Be
neficiarios
 if @@rowcount > 1
  begin
   Select @extCodError = 'N'
   Select @extMensajeError = 'TRANSACCION INCOMPLETA/ASISTIR A ISAPRE'
   select @Fin=convert(char(26),getdate(),109)

   insert Tiempos values("P5",@Ini,@Fin)

   return 1
  end

 --// D
ecodificación de las listas de prestaciones.
 --//Descomposicion de las listas pasadas por parametro.
 create table #Parametro_Listas ( id numeric(2,0) identity, Lista   char(255) )

 if char_length(rtrim(ltrim(@extLista1))) > 0 insert #Parametro_Listas v
alues (@extLista1)
 if char_length(rtrim(ltrim(@extLista2))) > 0 insert #Parametro_Listas values (@extLista2)
 if char_length(rtrim(ltrim(@extLista3))) > 0 insert #Parametro_Listas values (@extLista3)
 if char_length(rtrim(ltrim(@extLista4))) > 0 insert #
Parametro_Listas values (@extLista4)
 if char_length(rtrim(ltrim(@extLista5))) > 0 insert #Parametro_Listas values (@extLista5)
 if char_length(rtrim(ltrim(@extLista6))) > 0 insert #Parametro_Listas values (@extLista6)

 Select @Total_Listas = 0

 Select 
@Total_Listas = count(*) from #Parametro_Listas

 if @Total_Listas <= 0
  begin
   Select @extCodError = 'N'
   Select @extMensajeError = 'TRX DENEGADA (EO:400368)'
   select @Fin=convert(char(26),getdate(),109)

   insert Tiempos values("P5",@Ini,@Fin)


   return 1
  end

 --//Las listas traen prestaciones de la forma : Prest1|Prest2|Prest3|....|Prestn|
 --//En esta tabla quedan los strings que corresponden a una unica prestacion.
 create table #Cadenas
 (
  Cadena    char(46) not null,
  Procesado int  
        null
 )

 Select @Cuenta_Lista = 1

 while @Cuenta_Lista <= @Total_Listas
  begin

   Select @extListaAUX = Lista
   from   #Parametro_Listas
   where  id = @Cuenta_Lista

   Select @MinValor = 1

   while charindex('|',ltrim(rtrim(@extListaAUX)))
 > 0
    begin
     Select @extListaX = ltrim(rtrim(@extListaX)) +
                         ltrim(rtrim(substring(@extListaAUX,1,charindex('|',ltrim(rtrim(@extListaAUX))))))

     Select @extListaAUX = ltrim(rtrim(substring(@extListaAUX,charindex('|',ltri
m(rtrim(@extListaAUX)))+1,
                    char_length(@extListaAUX))))
     if @MinValor = 5
      begin
       insert #Cadenas values (@extListaX, NULL)
       Select @extListaX = ''
       Select @MinValor = 0
      end
     Select @MinValor = @Min
Valor + 1
    end

   Select @Cuenta_Lista = @Cuenta_Lista + 1
  end

 if (Select count(*) from #Cadenas) = 0
  begin
   --raiserror 900001 "No Se envio lista de prestaciones"
   Select @extCodError = 'N'
   Select @extMensajeError = 'TRX DENEGADA (EO:400
368)'
   select @Fin=convert(char(26),getdate(),109)

   insert Tiempos values("P5",@Ini,@Fin)

   return 1
  end

 --// No la voy a usar mas asi que la elimino.
 drop table #Parametro_Listas

 --//Las listas traen prestaciones de la forma : Prest1|Prest2
|Prest3|....|Prestn|
 --//seran decompuesta y dejadas en la tabla #PrestacionValorizada.
 while exists(Select 1 from #Cadenas where Procesado is null)
  begin

   Select @CodPrestacion = NULL, @Item          = NULL, @TipoItem      = NULL,
          @Afect
oRecargo = NULL, @CantAte       = NULL, @HomologoPrestador = NULL

   set rowcount 1

   Select @varCadena = ''
   Select @varCadena = Cadena from #Cadenas where Procesado is null

   Select @CodPrestacion = substring(@varCadena,1,charindex('|',ltrim(rtri
m(@varCadena)))-1)
   Select @varCadena = substring(@varCadena,charindex('|',ltrim(rtrim(@varCadena)))+1,char_length(@varCadena))

   Select @Item          = convert(tinyint,substring(@CodPrestacion,8,3))
   Select @CodPrestacion = substring(@CodPrestacio
n,1,7)

   if char_length(substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1)) = 0
    Select @TipoItem      = NULL
   else
    Select @TipoItem     = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1)
   Select @varCadena = s
ubstring(@varCadena,charindex('|',ltrim(rtrim(@varCadena)))+1,char_length(@varCadena))

   Select @HomologoPrestador = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1)
   Select @varCadena = substring(@varCadena,charindex('|',ltrim(rtrim(
@varCadena)))+1,char_length(@varCadena))

   if char_length(ltrim(rtrim(@HomologoPrestador))) <= 1 Select @HomologoPrestador = NULL

   Select @AfectoRecargo = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1)
   Select @varCadena = substr
ing(@varCadena,charindex('|',ltrim(rtrim(@varCadena)))+1,char_length(@varCadena))

   if @AfectoRecargo is null Select @AfectoRecargo = 'N'

   Select @CantAte       = convert(int,substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1))
   Selec
t @varCadena = substring(@varCadena,charindex('|',ltrim(rtrim(@varCadena)))+1,char_length(@varCadena))

   set rowcount 0

   create table #Especialidades
   (
    EsvCodEsp_id char(3)
   )

   Select @ValorDesde = NULL, @ValorHasta = NULL, @ValorNomina =
 NULL,
          @CodEsp     = NULL,
          @Modalidad = NULL,  @ErrorCode = 0

   --// Los equipos medicos no se convienen por ello, para obtener la especialidad se recurre
   --// a la prestacion principal. En cualquir otro caso se respeta el item.


   if @Item > 100 and @Item < 1000
    begin
     insert #Especialidades
     Select EsvCodEsp_id
     from   convenio..EspeServicioDirec
            ,convenio..GrupoConvenio
            ,convenio..PrestacionConvenio
     where EsvCorDir_id = @CorDir
    
   and  GcvCorDir_ta = EsvCorDir_id
       and  GcvCodEsp_ta = EsvCodEsp_id
       and  GcvCorGrc_id = PcvCorGrc_id
       and  PcvCodPre_ta = @CodPrestacion
       and  PcvCodIte_ta = 0

      if @@rowcount != 1
       begin
        Select @ValorDesde = 
0, @ValorHasta = 0, @ValorNomina = 0, @Modalidad = '',
              @ErrorCode = 101001 --// Más de una Especialidad para esta prestacion - convenio
       end

      select @CodEsp = EsvCodEsp_id from #Especialidades

    end
   else
    begin
     inse
rt #Especialidades
     Select EsvCodEsp_id
     from   convenio..EspeServicioDirec
            ,convenio..GrupoConvenio
            ,convenio..PrestacionConvenio
     where EsvCorDir_id = @CorDir
       and  GcvCorDir_ta = EsvCorDir_id
       and  GcvCod
Esp_ta = EsvCodEsp_id
       and  GcvCorGrc_id = PcvCorGrc_id
       and  PcvCodPre_ta = @CodPrestacion
       and  PcvCodIte_ta = @Item

     if @@rowcount != 1
      begin
       Select @ValorDesde = 0, @ValorHasta = 0, @ValorNomina = 0, @Modalidad = ''
,
              @ErrorCode = 101001 --// Más de una Especialidad para esta prestacion - convenio
      end

      select @CodEsp = EsvCodEsp_id from #Especialidades
    end

   if @CodEsp is null Select @CodEsp = 'XXX'
/*
    begin
     Select @extCodErro
r = 'N'
     Select @extMensajeError = 'TRX DENEGADA (EO:400373)'
     return 1
    end
*/
   insert #PrestacionValorizada
   values (@CodPrestacion, @Item, @TipoItem, @AfectoRecargo,
           @CantAte, NULL, NULL, NULL, @CodEsp,
           @ValorDesde,

           @ValorHasta,
           @ValorNomina, @Modalidad, NULL,@HomologoPrestador,
  NULL,NULL,NULL, NULL,NULL,NULL,@ErrorCode, NULL)

   drop table #Especialidades

   set rowcount 1

   update #Cadenas
      set Procesado = 1
   where  Procesado is 
null

   set rowcount 0

  end --// fin del ciclo While para decodificar las prestaciones.

  --// En este punto tengo todas las prestaciones requeridas.
  --// para valorizarlas debemos recorrer la tabla #PrestacionValorizada
  --// actualizando los dato
s faltantes a medida que se van obteniendo.

  Select @RecalculoRegimen = 'N'

  Select @MinValor = min(Indice) from #PrestacionValorizada
  Select @MaxValor = max(Indice) from #PrestacionValorizada
  Select @Indice   = @MinValor

  While @MinValor <= @Ma
xValor
   begin
    Select @CodPrestacion = CodPrestacion,
           @Item          = Item,
           @TipoItem      = TipoItem,
           @AfectoRecargo = AfectoRecargo,
           @Homologo      = Homologo,
           @CantAte       = CantAte,
      
     @CodEsp        = Especialidad
    from   #PrestacionValorizada
    where  Indice = @Indice

    --//VALIDACION DE EXISTENCIA DEL MEDICO TRATANTE O SOLICITANTE.
    --//
    --//REGLA DE NEGOCIO: * Si no hay solicitante o tratante no importa. el bono 
soporta nulos.
    --//                  * Tratante y Solicitante son mutuamente excluyentes.
    --//                  * De Venir un tratante éste debe estar asociado al prestador en convenio
    --//     de no ser asi, es causal de rechazo del servicio.

    --//                  * De venir un Solicitante. éste debe estar en la base de prestadores. sino lo ingreso
    --//                    con datos basicos. Si no pudo ser ingresado. rechazo el servicio.
 select @Ini2=convert(char(26),getdate(),109)

 
   exec @ErrorExec = prestacion..INGCtrl_TratSol @Marca, @CodPrestacion, @AccionPresta output

   select @Fin=convert(char(26),getdate(),109)
   insert Tiempos values("P54",@Ini2,@Fin)
    if @ErrorExec != 0
     begin
      Select @extCodError = 'N'
    
  Select @extMensajeError = 'TRX DENEGADA (EI:400377)'

      select @Fin=convert(char(26),getdate(),109)
      insert Tiempos values("P5",@Ini,@Fin)

      return 1
     end

    if @AccionPresta not in ('PR','AM')
     begin
      if @AccionPresta = 'TR
'
       begin --// Tratante es Exigible
        if not ((@extRutTratante = '0000000000-0')or(@extRutTratante is NULL)or(@extRutTratante = ''))
         begin
          Select @RutTra = convert(int,substring(ltrim(rtrim(@extRutTratante)),1,charindex('-',l
trim(rtrim(@extRutTratante)))-1))

          if not exists (Select 1 from convenio..PrestRelaEspeDirec
                         where  RedRutPre_id = @RutCon
                           and  RedRutPrr_id = @RutTra
                           and  RedCodRel_
id = 1
                           and  RedCorDir_id = @CorDir)
           begin
            Select @extCodError = 'N'
            Select @extMensajeError = 'TRX DENEGADA (EO:400371)'
            select @Fin=convert(char(26),getdate(),109)

            ins
ert Tiempos values("P5",@Ini,@Fin)

            return 1
           end
         end
        else
         Select @RutTra = @RutCon
       end --// Tratante es Exigible
      if @AccionPresta = 'SO'
       begin  --// Solicitante es Exigible
         if n
ot ((@extRutSolicitante = '0000000000-0')or(@extRutSolicitante is NULL)or(@extRutSolicitante = ''))
          begin
           Select @RutSol = convert(int,substring(ltrim(rtrim(@extRutSolicitante)),1,charindex('-',ltrim(rtrim(@extRutSolicitante)))-1))
  
         Select @RutTra = @RutSol
          end
         else
          begin
           if @RutTra is null
            Select @RutTra = @RutCon
          end
       end --// Solicitante es Exigible
     end
    else
     begin
      Select @RutTra = NULL

      if not ((@extRutTratante = '0000000000-0')or(@extRutTratante is NULL)or(@extRutTratante = ''))
       Select @RutTra = convert(int,substring(ltrim(rtrim(@extRutTratante)),1,charindex('-',ltrim(rtrim(@extRutTratante)))-1))

      Select @RutSol = NU
LL
      if not ((@extRutSolicitante = '0000000000-0')or(@extRutSolicitante is NULL)or(@extRutSolicitante = ''))
       Select @RutSol = convert(int,substring(ltrim(rtrim(@extRutSolicitante)),1,charindex('-',ltrim(rtrim(@extRutSolicitante)))-1))

      if
 @RutTra is null Select @RutTra = @RutSol
      if @RutSol is null Select @RutTra = @RutCon
     end

    --// SI EL HOMOLOGO RECIBIDO ES IGUAL AL CODIGO PRESTACION,
    --// se esta indicando que existe un arancel unico para esa prestacion, y por ello
  
  --// el homologo recibido no debe ser utilizado en la busqueda del arancel.

    if rtrim(ltrim(@CodPrestacion)) + convert(char(3),replicate('0',3 -
                                     char_length(ltrim(rtrim(convert(char(3),@Item)))))+
               
                      ltrim(rtrim(convert(char(3),@Item)))) = rtrim(ltrim(@Homologo))
     begin
      Select @Homologo = NULL
     end

    Select @ItemReal = @Item
    Select @Item     = 0

    --// Esquema Rigido de Tipos de Regimen para prestaciones.

    --// -----------------------------------------------------
    --//
    --// De definen como base los siguientes tipos de regimen.
    --// Regimen  1 : Regimen basico, siempre debe existir en el Arancel.
    --// Regimen 51 : Regimen que diferencia u
n Arancel para Horario Inhabil
    --// Regimen 52 : Regimen que diferencia un Arancel para Urgencias.
    --//
    --// De esta manera se compone el siguiente algoritmo:
    --//
    --// Inhabil        Urgencia
    --// N              N          => Reg 
=  1
    --// S              N          => Reg = 51
    --// N              S          => Reg = 52
    --// S              S          => Reg = 52 multiplicado por % de Recargo H.Inhabil. Sino
    --//                              existe Reg = 52 entonces 
Reg = 1 multiplicado por % de
    --//                              Recargo H.Inhabil, del convenio de la prestacion.
    --//
    --// De agregarse otro tipo de regimen convenios debera informarnoslo y
    --// se debera analizar el impacto sobre esta ru
tina.
    Select @CodReg = 1
    if @RecalculoRegimen = 'N'
     begin
      if @AfectoRecargo = 'N' and @extUrgencia = 'N' Select @CodReg =  1
      if @AfectoRecargo = 'S' and @extUrgencia = 'N' Select @CodReg = 51
      if @AfectoRecargo = 'N' and @ext
Urgencia = 'S' Select @CodReg = 52
      if @AfectoRecargo = 'S' and @extUrgencia = 'S' Select @CodReg = 52
     end

    if @CodEsp is not null and @CodEsp <> 'XXX'
     begin --// INICIO
       if @ItemReal > 0 and @ItemReal < 99 --//Este Item Debiera S
er un Pabellón.
        begin
         -- // Obtención de la Nómina genérica del convenio. REGLA DE NEGOCIO.
         Select @ValorNomina = ConCodNom_ta
         From   convenio..Convenio
         where  ConFolCon_id = @FolCon
            and ConCorRen_id
 = @CorRen

           --//PASO PROD exec prestacion..Sel_VPPabellones_out

           select @Ini2=convert(char(26),getdate(),109)

           exec @ErrorExec = convenio..Sel_VPPabellones_out @RutCon, @FolCon, @CorRen,
                                   
                          @CorDir, @CodEsp, @CodPrestacion,
                                                             @ItemReal, @ValorNomina, @Hoy,
                                                             @Homologo, @CodReg,
                      
                                       @ValorNomina output,
                                                             @CodPrest    output,
                                                             @CodItem     output,
                               
                              @CodReg      output,
                                                             @CodHomo     output,
                                                             @ValorDesde  output,
                                        
                     @ValorHasta  output,
                                                             @Modalidad   output,
                                                             @CopagoFijo  output,
                                                 
            @ErrorCode   output,
                                                             @CostoCero   output


   select @Fin=convert(char(26),getdate(),109)
   insert Tiempos values("P55",@Ini2,@Fin)
          if @ErrorCode != 0
            begin
  
           update #PrestacionValorizada
                set ValorDesde = 0,
                    ValorHasta = 0,
                    Nomina     = @ValorNomina,
                    Modalidad  = ''
             where  Indice = @Indice

             update #P
restacionValorizada
              set Error      = @ErrorCode
             where  Indice = @Indice
               and  Error  = 0
            end
           else
            begin      -- // No se detecto Error.
             update #PrestacionValorizada
 
               set CodPrestacion = @CodPrest,
                    Item          = @CodItem,
                    ValorDesde    = @ValorDesde,
                    ValorHasta    = @ValorHasta,
                    Nomina        = @ValorNomina,
               
     Modalidad     = @Modalidad,
                    TipReg        = @CodReg,
                    Homologo      = @CodHomo,
                    CopagoFijo    = @CopagoFijo,
                    CostoCero     = @CostoCero
             where  Indice = @Indic
e
            end

        end --// FIN DE VALORIZACION DE PABELLON

       --//Este Item Debiera Ser una Prestacion Principal o Un HMQ
       if not (@ItemReal > 0 and @ItemReal < 99)
        begin
         --// Certificacion del Convenio...

 select @In
i2=convert(char(26),getdate(),109)

         exec @ErrorExec = convenio..Sel_VPCertificaConvenio @RutCon, @FolCon, @CorRen,
                                                             @CorDir, @CodEsp,
                                                    
         @CodPrestacion, @Item,
                                                             @Hoy,
                                                             @ValorDesde output,
                                                             @ValorHasta ou
tput,
                                                             @ValorNomina output,
                                                             @Modalidad output,
                                                             @CostoCero output

   sele
ct @Fin=convert(char(26),getdate(),109)
   insert Tiempos values("P56",@Ini2,@Fin)
      if @ErrorExec != 0
          begin
           update #PrestacionValorizada
              set ValorDesde = 0,
                  ValorHasta = 0,
                  Nomin
a    = @ValorNomina,
                  Modalidad  = ''
           where  Indice = @Indice

           update #PrestacionValorizada
              set Error  = @ErrorExec
           where  Indice = @Indice
             and  Error  = 0

          end

      
   if @Modalidad in ('PE','UF')
          begin
           update #PrestacionValorizada
              set ValorDesde = case @Modalidad
                                 when 'PE' then @ValorDesde
                                 when 'UF' then floor(round(
@ValorDesde * @ValorUF,0))
                               end,
                         ValorHasta = case @Modalidad
                                 when 'PE' then @ValorHasta
                                 when 'UF' then floor(round(@ValorHasta * @Val
orUF,0))
                               end,
                  Nomina     = @ValorNomina,
                  Modalidad  = @Modalidad
           where  Indice = @Indice

           if @ErrorExec != 0
            begin
           update #PrestacionValorizada

                set Error  = @ErrorExec
             where  Indice = @Indice
               and  Error  = 0
            end

          end --// @Modalidad in ('PE','UF')

         if @Modalidad = 'VA'
          begin
            create table #Arancel
   
         (
             AraCodNom_ta    smallint       not null,
             AraCodPre_ta    prestacion     not null,
             AraCodIte_ta    tinyint        not null,
             AraCodReg_ta    tinyint        not null,
             AraCodExt_cr   
 char(20)       not null,
             AraCopFij_nn    int           null,
             AraModVal_ta    regla          not null,
             AraValAra_nn    numeric(10,2)  not null
            )

            if @Homologo is null
             begin
      
        insert  #Arancel
              Select  AraCodNom_ta, AraCodPre_ta, AraCodIte_ta, AraCodReg_ta, AraCodExt_cr, AraCopFij_nn,
                      AraModVal_ta, AraValAra_nn
              From    prestacion..Arancel
              where  AraCodPre_ta
 =  @CodPrestacion
                and  AraCodIte_ta =  @Item
                and  AraCodReg_ta =  @CodReg
                and  AraCodNom_ta =  @ValorNomina
             --and  AraCodExt_cr =  @Homologo
                and  AraFecIna_fc <= @Hoy
          
    and  AraFecTea_fc >= @Hoy
              union
              Select  AraCodNom_ta, AraCodPre_ta, AraCodIte_ta, AraCodReg_ta, AraCodExt_cr, AraCopFij_nn,
                      AraModVal_ta, AraValAra_nn
              From   prestacion..Arancel
         
     where  AraCodPre_ta =  @CodPrestacion
                and  AraCodIte_ta =  @Item
                and  AraCodReg_ta =  @CodReg
                and  AraCodNom_ta =  @ValorNomina
                --and  AraCodExt_cr =  @Homologo
                and  AraF
ecIna_fc <= @Hoy
                and  AraFecTea_fc is Null

              Select @TotalFilas = @@rowcount

             end
            else
             begin
              insert  #Arancel
              Select  AraCodNom_ta, AraCodPre_ta, AraCodIte_ta, 
AraCodReg_ta, AraCodExt_cr, AraCopFij_nn,
                      AraModVal_ta, AraValAra_nn
              From    prestacion..Arancel
              where  AraCodPre_ta =  @CodPrestacion
                and  AraCodIte_ta =  @Item
                and  AraCod
Reg_ta =  @CodReg
                and  AraCodNom_ta =  @ValorNomina
                and  AraCodExt_cr =  @Homologo
                and  AraFecIna_fc <= @Hoy
                and  AraFecTea_fc >= @Hoy
              union
              Select  AraCodNom_ta, 
AraCodPre_ta, AraCodIte_ta, AraCodReg_ta, AraCodExt_cr, AraCopFij_nn,
                    AraModVal_ta, AraValAra_nn
              From   prestacion..Arancel
              where  AraCodPre_ta =  @CodPrestacion
                and  AraCodIte_ta =  @Item
  
              and  AraCodReg_ta =  @CodReg
                and  AraCodNom_ta =  @ValorNomina
                and  AraCodExt_cr =  @Homologo
                and  AraFecIna_fc <= @Hoy
                and  AraFecTea_fc is Null

               Select @TotalFi
las = @@rowcount

             end

            if @TotalFilas != 1
             begin
               if @TotalFilas = 0
                update #PrestacionValorizada
                   set Error      = 101002 --// Más de un Arancel para la prestacion...
 
               where  Indice = @Indice
               else
                update #PrestacionValorizada
                   set Error      = 101003 --// Arancel No Encontrado...
                where  Indice = @Indice
             end
            else
    
      begin --// Arancel UNICO para la prestacion...
              select @TipReg  = AraCodReg_ta,
                     @Homologo = AraCodExt_cr,
                     @ModVal   = AraModVal_ta,
                     @ValAra   = AraValAra_nn
              Fr
om   #Arancel

              /*
              Select "convenio..Sel_VPValorizar",
                    @RutCon, @FolCon, @CorRen,   @CorDir, @CodEsp, @CodPrestacion, @Item,   @Homologo, @TipReg,
                    @ValorNomina,   @ValAra, @ModVal, @RutTra
, @Hoy
              */

 select @Ini2=convert(char(26),getdate(),109)
              exec @ErrorExec = convenio..Sel_VPValorizar @RutCon, @FolCon, @CorRen,   @CorDir,
                                                          @CodEsp,
                     
                                     @CodPrestacion, @Item,   @Homologo, @TipReg,
                                                          @ValorNomina,   @ValAra, @ModVal, @RutTra, @Hoy,
                                                          @ValorDe
sde  output,
                                                          @ValorHasta  output,
                                                          @ValorNomina output,
                                                          @Modalidad   output,
     
                                                     @CostoCero   output,
                                                          @CopagoFijo  output


   select @Fin=convert(char(26),getdate(),109)
   insert Tiempos values("P57",@Ini2,@Fin)

          
    if @ErrorExec != 0
               begin --// Error de Valorizacion
                update #PrestacionValorizada
                   set Error  = @ErrorCode
                where  Indice = @Indice
                  and  Error  = 0
               end
   
           else
               begin --// Valorizacion EXITOSA

               --// La PRestacion se encuentra bien convenida a nivel de
               --// prestacion global. Ahora se debe determinar el precio
               --// de la misma como HMQ, si
 corresponde.

                 if (@ItemReal > 100 and @ItemReal < 1000) --// Es HMQ.
                  begin
 select @Ini2=convert(char(26),getdate(),109)

                   exec @ErrorExec = convenio..Sel_VPEquipoMed_out @RutCon, @FolCon, @CorRen, @Co
rDir,
                                                                   @CodEsp, @CodPrestacion, @Homologo,
                                                                   @TipReg, @ValorNomina, @ValorDesde,
                                           
                        @ValorHasta, @Modalidad, @Hoy, @ItemReal,
                                                                   @out_CodNom     output,
                                                                   @out_CodPrest   output,
       
                                                            @out_CodItem    output,
                                                                   @out_CodReg     output,
                                                                   @out_CodHomo 
   output,
                                                                   @out_Desde      output,
                                                                   @out_Hasta      output,
                                                              
     @out_Modalidad  output,
                                                                   @out_CoPagoFijo output,
                                                                   @out_ErrorCode  output,
                                            
                       @out_Metodo     output

   select @Fin=convert(char(26),getdate(),109)
   insert Tiempos values("P58",@Ini2,@Fin)
                   if @ErrorExec != 0
                    begin
                     Select @ValorDesde  = 0,
        
                    @ValorHasta  = 0,
                            @ValorNomina = 0,
                            @Modalidad   = '',
                            @CopagoFijo  = 0

                     update #PrestacionValorizada
                        set 
ValorDesde = @ValorDesde,
                            ValorHasta = @ValorHasta,
                            Nomina     = @ValorNomina,
                            Modalidad  = @Modalidad,
                            CostoCero  = @CostoCero,
              
              CopagoFijo = @CopagoFijo,
                            TipReg     = @TipReg,
                            Homologo   = @Homologo,
                            Error      = @ErrorExec
                     where  Indice = @Indice

               
     end
                   else
                    begin --// Era un HMQ y Fue valorizado
                     Select @ValorDesde  = @out_Desde,
                            @ValorHasta  = @out_Hasta,
                            @ValorNomina = @out_CodNo
m,
                            @Modalidad   = @out_Modalidad,
                            @CopagoFijo  = @out_CoPagoFijo
                    end

                  end

                 update #PrestacionValorizada
                    set ValorDesde = @Va
lorDesde,
                        ValorHasta = @ValorHasta,
                        Nomina     = @ValorNomina,
                        Modalidad  = @Modalidad,
                        CostoCero  = @CostoCero,
                        CopagoFijo = @CopagoFi
jo,
                        TipReg     = @TipReg,
                        Homologo   = @Homologo
                 where  Indice = @Indice

               end   --// FIN Valorizacion EXITOSA
            end  --// FIN Arancel UNICO para la prestacion...

  
         drop table #Arancel
          end --// if @Modalidad = 'VA'

        end --// FIN  Prestacion Principal o Un HMQ

     end --// FIN @CodEsp is null or @CodEsp = 'XXX'
    else
     begin
        update #PrestacionValorizada
          set Error  =
 400373
        where  Indice = @Indice
          and  Error  = 0

       Select @extCodError = "N"
       Select @extMensajeError = "TRX DENEGADA (EI:400373)"
       select @Fin=convert(char(26),getdate(),109)
       insert Tiempos values("P5",@Ini,@Fin)


       return 1
     end

    if (((Select Error From #PrestacionValorizada where Indice = @Indice) != 0)and
        (@RecalculoRegimen = 'N'))
     begin
      Select @RecalculoRegimen = 'S'

      update #PrestacionValorizada  --// Arancel No Encontra
do...
         set Error  = 0
      where  Indice = @Indice
     end
    else
     begin
       Select @RecalculoRegimen = 'N'
       Select @MinValor = @MinValor + 1
       Select @Indice = @MinValor
     end

   end  --// Iterador de valorizacion presta
ciones while @MinValor <= @MaxValor

  --// Esto indica que existe un Arancel de urgencia con recargo por % de
  --// recargo en el convenio.
  if @AfectoRecargo = 'S'
   begin
     --// En Esta Iteración se Buscará El Valor De Recargo Para cada prestacio
n.
     select @MinValor = min(Indice) from #PrestacionValorizada
     select @MaxValor = max(Indice) from #PrestacionValorizada
     While @MinValor <= @MaxValor
      begin
       Select @Indice = @MinValor

       Select @CodPrestacion = CodPrestacion,

              @Item          = Item,
              @TipoItem      = TipoItem,
              @CodEsp        = Especialidad,
              @AfectoRecargo = AfectoRecargo,
              @ValorDesde    = ValorDesde,
              @ValorHasta    = ValorHasta,

              @ValorNomina   = Nomina,
              @Modalidad     = Modalidad,
              @TipReg        = TipReg,
              @Homologo      = Homologo,
              @CostoCero     = CostoCero,
              @CopagoFijo    = CopagoFijo
       fr
om   #PrestacionValorizada
       where  Indice = @MinValor

       Select @PorceRecargo = 0

       Select @PorceRecargo = case PcvPorRec_nn
                               when NULL then 0
                               else PcvPorRec_nn
                
              end
       From   convenio..PrestacionConvenio PC,
              convenio..GrupoConvenio GC
       Where  PcvFolCon_ta = @FolCon
         and  PcvCorRen_ta = @CorRen
         and  PcvCodPre_ta = @CodPrestacion
         and  PcvCodIte_ta = @I
tem
         and  PcvCorGrc_id = GcvCorGrc_id
         and  GcvCorGrc_id = PcvCorGrc_id
         and  GcvCorDir_ta = @CorDir
         and  GcvCodEsp_ta = @CodEsp

       if @PorceRecargo > 0
        begin
         update  #PrestacionValorizada
           
 Set  ValorDesde = @ValorDesde * (1 + round((@PorceRecargo / 100),2)),
                 ValorHasta = @ValorHasta * (1 + round((@PorceRecargo / 100),2))
         from #PrestacionValorizada
         where  Indice = @MinValor
           and  AfectoRecargo = 
'S'
        end

       Select @MinValor = @MinValor + 1
      end
   end --// if @AfectoRecargo = 'S'

 --// Obtención de la Lista de PLANES ALTERNATIVOS Posibles.
  create table #PlanesAlternativos
  (
   PlaCodPla_id codpla,
   Iterar       int null,
 
 )

  Select @Colectivo = ConNumCol_nn
  from   contrato..Contrato
  where  ConNumCto_id = @NroContrato
    and  ConMarCon_id = @Marca

  insert #PlanesAlternativos
  Select distinct PlaCodPla_id, NULL
  from   contrato..TramoColectivo T,
         contrat
o..PlanTramoCol Pt1,
         contrato..PlanTramoCol Pt2,
         contrato..Plan1 P
  where  T.TcoNumCol_id   = @Colectivo
    and  Pt1.PtrNumCol_id = @Colectivo
    and  Pt1.PtrCorTra_id = T.TcoICorTra_id
    and  Pt1.PtrCodPla_id = @extPlan
    and  Pt
2.PtrCorTra_id = T.TcoICorTra_id
    and  Pt2.PtrNumCol_id = @Colectivo
    and  Pt2.PtrCodPla_id = PlaCodPla_id
    and  Pt2.PtrTipPla_re = "OP"

 select @MinValor = min(Indice) from #PrestacionValorizada
 select @MaxValor = max(Indice) from #PrestacionV
alorizada

 While @MinValor <= @MaxValor
  begin
  Select @Indice = @MinValor

   select @CodPrestacion = CodPrestacion,
          @Item          = Item,
          @TipoItem = TipoItem,
          @AfectoRecargo = AfectoRecargo,
          @CantAte       = 
CantAte,
          @ValorDesde    = ValorDesde,
          @ValorHasta    = ValorHasta,
          @ValorNomina   = Nomina,
          @Modalidad     = Modalidad,
          @TipReg        = TipReg,
          @Homologo      = Homologo,
          @CostoCero   
  = CostoCero,
          @CopagoFijo    = CopagoFijo
   from   #PrestacionValorizada
   where  Indice = @MinValor
     and  Error  = 0

   select @GruCob = GcoCodGco_id
   from   prestacion..SubPrestGrupCob
          ,prestacion..CatGruCob
          ,cont
rato..Cobertura
   where  SpgCodPre_id = @CodPrestacion
     and  SpgCodIte_id = @Item
     and  GcoCodGco_id = SpgCodGco_id
     and  CobCodPla_id = @extPlan
     and  CobGruCob_id = GcoCodGco_id
     and  GcoTipAte_re = 'AM'

   update #PrestacionValori
zada
      set GrupoCobertura   = @GruCob
   where  Indice = @Indice

   Select @CodLoc = DatCodLoc_ta
   from   convenio..DireccionAtencion
   where  DatCorDir_id = @CorDir

   if (Select count(*) From #PlanesAlternativos) = 0 --// NO EXISTEN PLANES ALTE
RNATIVOS.
    begin

     select @GruCob = GcoCodGco_id
     from   prestacion..SubPrestGrupCob
            ,prestacion..CatGruCob
            ,contrato..Cobertura
     where  SpgCodPre_id = @CodPrestacion
       and  SpgCodIte_id = @Item
       and  GcoC
odGco_id = SpgCodGco_id
       and  CobCodPla_id = @extPlan
       and  CobGruCob_id = GcoCodGco_id
       and  GcoTipAte_re = 'AM'

     update #PrestacionValorizada
        set GrupoCobertura   = @GruCob
     where  Indice = @Indice

 select @Ini2=conve
rt(char(26),getdate(),109)
     exec @ErrorExec = contrato..SerPyT_CoberturaConGuindasDef @extPlan, @GruCob,
                                                               @RutCon,
                                                               @FolCon,  @
CorRen,
                                                               @CodLoc,
                                                               @NroContrato, @Marca,
                                                               'BO', @GruCob,
            
                                                   @CobCodPla_id    Output,
                                                               @CobModCob_id    Output,
                                                               @CobGruCob_id    Output,
   
                                                            @CobCodNom_ta    Output,
                                                               @CobPorBon_nn    Output,
                                                               @CobMonTop_nn    Ou
tput,
                                                               @CobModTop_re    Output,
                                                               @CobMonTopCon_nn Output,
                                                               @CobModTop
Con_re Output,
                                                               @CobRanCob_nn    Output,
                                                               @CobMonCop_nn    Output,
                                                               @
CobModCop_re    Output,
                                                               @CobNivPpo_nn    Output,
                                                               @PlaModRef_re    Output,
                                                       
        @PlaCobInt_nn    Output,
                                                               @PlaTopBac_nn    Output,
                                                               @PlaBasAcm_nn    Output,
                                              
                 @PlaBonGan_fl    Output,
                                                               @PlaPorFac_nn    Output,
                                                               @GtaMaxBga_nn    Output,
                                     
                          @BenEspAplicados Output

   select @Fin=convert(char(26),getdate(),109)
   insert Tiempos values("P59",@Ini2,@Fin)
    end
   else
    begin --// Dado que hay un Plan Alternativo, Se Buscará el primero que
          --// Devuelva
 distinto a 'LE'.
     Select @CobModCob_id = 'LE'
     While ((@CobModCob_id = 'LE')and (exists (Select 1 From #PlanesAlternativos where Iterar is null)))
      begin
       While exists (Select 1 From #PlanesAlternativos where Iterar is null)
        be
gin
         Select @extPlanAlternativo = PlaCodPla_id
         From   #PlanesAlternativos
         where  Iterar is null

         set rowcount 1

         update #PlanesAlternativos
            set Iterar = 1
         where PlaCodPla_id = @extPlanAltern
ativo
           and Iterar       is null

         set rowcount 0

         select @GruCob = GcoCodGco_id
         from   prestacion..SubPrestGrupCob
                ,prestacion..CatGruCob
                ,contrato..Cobertura
         where  SpgCodPre_id
 = @CodPrestacion
           and  SpgCodIte_id = @Item
           and  GcoCodGco_id = SpgCodGco_id
           and  CobCodPla_id = @extPlanAlternativo
           and  CobGruCob_id = GcoCodGco_id
           and  GcoTipAte_re = 'AM'

         update #Prestac
ionValorizada
            set GrupoCobertura   = @GruCob
         where  Indice = @Indice

         Select @RenExe_fl = ConRenExe_fl
         From   contrato..Contrato
         Where  ConNumCto_id = @NroContrato
           and  ConMarCon_id = @Marca

 sel
ect @Ini2=convert(char(26),getdate(),109)
         exec @ErrorExec = contrato..SerPyT_CoberturaRedDef @extPlanAlternativo, @GruCob, @RutCon,
                                                            @FolCon,  @CorRen,
                                   
                         @CodLoc, @Marca, 'BO', @RenExe_fl,
                                                            @REDCodPla_id    output, @REDModCob_id    output,
                                                            @REDGruCob_id    output, 
@REDCodNom_ta    output,
                                                            @REDPorBon_nn    output, @REDMonTop_nn    output,
                                                            @REDModTop_re    output, @REDMonTopCon_nn output,
          
                                                  @REDModTopCon_re output, @REDRanCob_nn    output,
                                                            @REDMonCop_nn    output, @REDModCop_re    output,
                                             
               @REDNivPpo_nn    output, @REDModRef_re    output,
                                                            @REDCobInt_nn    output, @REDTopBac_nn    output,
                                                            @REDBasAcm_nn    out
put, @REDBonGan_fl    output,
                                                            @REDPorFac_nn    output, @REDMaxBga_nn    output

   select @Fin=convert(char(26),getdate(),109)
   insert Tiempos values("P5a",@Ini2,@Fin)
         if @ErrorExec = 
0
          begin

 select @Ini2=convert(char(26),getdate(),109)
           exec @ErrorExec = contrato..SerPyT_CoberturaConGuindasDef @extPlanAlternativo,
                                                                     @GruCob,
                      
                                               @RutCon,
                                                                     @FolCon,  @CorRen,
                                                                     @CodLoc,
                                 
                                    @NroContrato, @Marca,
                                                                     'BO', @GruCob,
                                                                     @CobCodPla_id    Output, @CobModCob_id    Ou
tput,
                                                                     @CobGruCob_id    Output, @CobCodNom_ta    Output,
                                                                     @CobPorBon_nn    Output, @CobMonTop_nn    Output,
           
                                                          @CobModTop_re    Output, @CobMonTopCon_nn Output,
                                                                     @CobModTopCon_re Output, @CobRanCob_nn    Output,
                            
                                         @CobMonCop_nn    Output, @CobModCop_re    Output,
                                                                     @CobNivPpo_nn    Output, @PlaModRef_re    Output,
                                             
                        @PlaCobInt_nn    Output, @PlaTopBac_nn    Output,
                                                                     @PlaBasAcm_nn    Output, @PlaBonGan_fl    Output,
                                                              
       @PlaPorFac_nn    Output, @GtaMaxBga_nn    Output,
                                                                     @BenEspAplicados Output

   select @Fin=convert(char(26),getdate(),109)
   insert Tiempos values("P5b",@Ini2,@Fin)
          end


         update #PlanesAlternativos
            set Iterar = 1
         where  PlaCodPla_id = @extPlanAlternativo
           and Iterar       is null

         if @CobModCob_id <> 'LE'
          begin
           set rowcount 0
           update #PlanesAl
ternativos set Iterar = 1
          end

        end
      end

     if @CobModCob_id = 'LE'
      begin

       select @GruCob = GcoCodGco_id
       from   prestacion..SubPrestGrupCob
              ,prestacion..CatGruCob
              ,contrato..Cobertur
a
       where  SpgCodPre_id = @CodPrestacion
         and  SpgCodIte_id = @Item
         and  GcoCodGco_id = SpgCodGco_id
         and  CobCodPla_id = @extPlan
         and  CobGruCob_id = GcoCodGco_id
         and  GcoTipAte_re = 'AM'

       update #Pr
estacionValorizada
          set GrupoCobertura   = @GruCob
       where  Indice = @Indice

 select @Ini2=convert(char(26),getdate(),109)
       exec @ErrorExec = contrato..SerPyT_CoberturaConGuindasDef @extPlan, @GruCob,
                                 
                                @RutCon,
                                                                 @FolCon,  @CorRen,
                                                                 @CodLoc,
                                                        
         @NroContrato, @Marca,
                                                                 'BO', @GruCob,
                                                                 @CobCodPla_id    Output,
                                                      
           @CobModCob_id    Output,
                                                                 @CobGruCob_id    Output,
                                                                 @CobCodNom_ta    Output,
                                       
                          @CobPorBon_nn    Output,
                                                                 @CobMonTop_nn    Output,
                                                                 @CobModTop_re    Output,
                        
                                         @CobMonTopCon_nn Output,
                                                                 @CobModTopCon_re Output,
                                                                 @CobRanCob_nn    Output,
         
                                                        @CobMonCop_nn    Output,
                                                                 @CobModCop_re    Output,
                                                                 @CobNivPpo_nn    Ou
tput,
                                                                 @PlaModRef_re    Output,
                                                                 @PlaCobInt_nn    Output,
                                                                 @Pla
TopBac_nn    Output,
                                                                 @PlaBasAcm_nn    Output,
                                                                 @PlaBonGan_fl    Output,
                                                      
           @PlaPorFac_nn    Output,
                                                                 @GtaMaxBga_nn    Output,
                                                                 @BenEspAplicados Output

   select @Fin=convert(char(26),getdate
(),109)
   insert Tiempos values("P5c",@Ini2,@Fin)
      end
    end   --// FIN PLANES ALTERNATIVOS...

   if @ErrorExec = 0
    begin --// Obtención de Linea de Cobertura Exitosa

     Select @fec_ini_veg = ConIniPla_pe
     from   contrato..Contrato
   
  where  ConMarCon_id = @Marca
       and  ConNumCto_id = @NroContrato
       and  ConRutCot_id = @RutCte

     Select @boni_pend = 0

     Select @boni_pend = isnull(sum(AporteFinanciador),0)
     from   #PrestacionValorizada
     where  GrupoCobertura i
s not null
       and  GrupoCobertura = @GruCob
       and  Error = 0

     Select @ErrorExec = 0, @cod_error = 0

 select @Ini2=convert(char(26),getdate(),109)
     exec @ErrorExec = prestacion..CalculaBonifDef
                                           
     @CobModCob_id,   @CobGruCob_id,
                                                @CobCodNom_ta,   @CobPorBon_nn,
                                                @CobMonTop_nn, @CobModTop_re,
                                                @CobMonTopCo
n_nn,@CobModTopCon_re,
                                                @CobMonCop_nn,   @CobModCop_re,
                                                @PlaModRef_re,   @PlaCobInt_nn,
                                                @PlaTopBac_nn,   @PlaBas
Acm_nn,
                                                @PlaBonGan_fl,   @GtaMaxBga_nn,
                                                @BenEspAplicados,
                                                @CodPrestacion,  @Item, 1, --@TipReg,
               
                                 @ValorDesde,     @ValorHasta,
                                                @Modalidad, @CostoCero,
                                                @CopagoFijo,     @Hoy,
                                                @
Marca,
                                                @NroContrato,    @RutCte,   @cor_car,
                                                @boni_pend,      'N',       @tipo_carga,
                                                @fec_ini_veg,    @CantAte
,  @extPlan, 100,
                                                @por_boni       output,
                                                @mto_boni       output,
                                                @copago         output,
                     
                           @mto_presta     output,
                                                @operacion      output,
                                                @mensaje        output,
                                                @tiene_tope 
  output,
                                                @cod_error    output,
                                                @guindas  output

   select @Fin=convert(char(26),getdate(),109)
   insert Tiempos values("P5d",@Ini2,@Fin)
      if (@ErrorExe
c = 0) and ((@cod_error = 0)or(@cod_error is null))
       begin --// Bonificación Exitosa

       --//Determinación si el Beneficiario es Socio de la Clinica Alemana.
       --//Para Aplicar convenio con la institucion.
       Select @EsSocioAlemana = 'N
' --// NO ES SOCIO
       Select @ValRendir = 0

       if @Marca  = 'CB'
        Begin

       select @Ini2=convert(char(26),getdate(),109)
      exec @DescSocAlemana = prestacion..EsSocioAlemana @RutCon, @RutBen, @CobModCob_id
      select @Fin=convert(
char(26),getdate(),109)
      insert Tiempos values("P5e",@Ini2,@Fin)
         if @DescSocAlemana <> 0 Select @EsSocioAlemana = 'S' --// ES SOCIO.
        end

       if @EsSocioAlemana = 'S'
        begin
         Select @mto_boniReal   = @mto_boni
     
    Select @copagoReal     = @copago
         Select @mto_prestaReal = @mto_presta

         Select @DescEnPesos    = round(((@mto_prestaReal * @DescSocAlemana)/100),0)

         Select @mto_presta     = @mto_prestaReal - @DescEnPesos
         Select @Val
Rendir      = @mto_presta

         if @DescEnPesos > @copagoReal
          begin
           Select @mto_boni  = @mto_boniReal - (@DescEnPesos - @copagoReal)
           Select @copago    = @mto_presta - @mto_boni
           Select @operacion = 'BD'
      
    end
         else
          begin
           Select @mto_boni  = @mto_boniReal
           Select @copago    = @copagoReal - @DescEnPesos
           Select @operacion = 'BD'
          end
        end


       update #PrestacionValorizada
          set 
ModalCobertura    = @CobModCob_id,
              TipoCalculo       = @operacion,
              ValorPrestacion   = @mto_presta,
              AporteFinanciador = @mto_boni,
              Copago            = @copago,
              ValorRendicion    = @ValR
endir
       where  Indice = @Indice

      end   --// FIN Bonificación Exitosa
     else
      begin --// Bonificación Fallida
       if @cod_error != 0
        begin
         update #PrestacionValorizada
            set Error      = @cod_error
         
where  Indice = @Indice
        end
      end
    end --// FIN Obtención de Linea de Cobertura Exitosa
   else
    begin --// Error en la Linea de Cobertura
      update #PrestacionValorizada
         set Error  = @ErrorExec
      where  Indice = @Indice

    end

   update #PlanesAlternativos
      set Iterar = NULL

   Select @MinValor = @MinValor + 1

  end

 if exists (Select 1
            From   #PrestacionValorizada
            where  GrupoCobertura in ('24', '300', '301', '302', '303'))
  begin
   -
-// Control de Frecuencia en las consultas....
   --//
   --// Denegar la valorización para cualquier carga que en las ultimas cuatro
   --// semanas tenga mas de 4 bonos de consulta, emitidos en la surcursales
   --// I-MED. Esto ultimo, para cualquier e
fecto es la sucursal 130600

 select @Ini2=convert(char(26),getdate(),109)
   exec @ErrorExec = prestacion..Sel_FrecPrestaciones @RutCte, @NroContrato,
                                                      @Marca,  @cor_car,
                              
                        4,       2,
                                                      @TotalPrest output

   select @Fin=convert(char(26),getdate(),109)
   insert Tiempos values("P5f",@Ini2,@Fin)
   if @ErrorExec != 0
    begin
     Select @extCodErro
r = 'N'
     Select @extMensajeError = 'TRANSACCION INCOMPLETA/ASISTIR A ISAPRE'
     select @Fin=convert(char(26),getdate(),109)
     insert Tiempos values("P5",@Ini,@Fin)

     return 1
    end

   if @TotalPrest >= 4
    begin
     Select @extCodError 
= 'N'
     --//Select @extMensajeError = 'EXCESO CONSULTA,ASISTIR ISAPRE'
     Select @extMensajeError = 'EXCEDE CONSUL IMED IR A ISAPRE'
        select @Fin=convert(char(26),getdate(),109)

   insert Tiempos values("P5",@Ini,@Fin)

     return 1
    end

  end

 Select @extCodError = 'S'
 Select @extMensajeError = ''

 if exists(Select 1 from #PrestacionValorizada where Error > 0)
  begin
   Select @extCodError = 'N'

   set rowcount 1

   Select @extMensajeError = "PREST. NO OTORGAB. (Nº "+
             
                ltrim(rtrim(convert(char(10),Indice)))+")"
   from   #PrestacionValorizada
   where  Error <> 0

   set rowcount 0
  end

 --// Generacion de los registros de log de control.
 --// Esta obtencion de codigo queda obsoleta en el esquema de a
tributo identity.

 Select @DigCon = substring(ltrim(rtrim(@extRutConvenio)),charindex('-',ltrim(rtrim(@extRutConvenio)))+1,1)

 Select @DigBen = substring(ltrim(rtrim(@extRutBeneficiario)),
                  charindex('-',ltrim(rtrim(@extRutBeneficiario)
))+1,1)

 Select @RutCot = convert(int,substring(ltrim(rtrim(@extRutCotizante)),1,
                  charindex('-',ltrim(rtrim(@extRutCotizante)))-1))

 Select @DigCot = substring(ltrim(rtrim(@extRutCotizante)),
                  charindex('-',ltrim(rtrim
(@extRutCotizante)))+1,1)

 Select @Hoy_log = getdate()

/*
 begin tran

  insert  Log_Valorizaciones
          (LvaMarFin_ta, LvaCorCon_ta, LvaDirCon_ta,
           LvaRutPre_ta, LvaDigPre_cr, LvaRutBen_ta, LvaDigBen_cr,
           LvaRutCon_ta, LvaDigCo
n_cr, LvaNumCon_ta, LvaFecVal_fc)
  values (@Marca,          @extHomNumeroConvenio, @CorDir,
          @RutCon,          @DigCon,      @RutBen, @DigBen,
          @RutCot, @DigCot, @NroContrato, @Hoy_log)

 if @@error != 0
  begin
   rollback tran
   --ra
iserror 900000 "Un Error del financiador impide continuar con su solicitud"
   Select @extCodError = 'N'
   Select @extMensajeError = 'TRX DENEGADA (EO:400369)'
   return 1
  end

  Select @Corr_logControl = LvaIdeVal_id
  From   Log_Valorizaciones
  wher
e  LvaMarFin_ta = @Marca
    and  LvaCorCon_ta = @extHomNumeroConvenio
    and  LvaDirCon_ta = @CorDir
    and  LvaRutPre_ta = @RutCon
    and  LvaDigPre_cr = @DigCon
    and  LvaRutBen_ta = @RutBen
    and  LvaDigBen_cr = @DigBen
    and  LvaRutCon_ta = 
@RutCot
    and  LvaDigCon_cr = @DigCot
    and  LvaNumCon_ta = @NroContrato
    and  LvaFecVal_fc = @Hoy_log

 --// En Esta Iteración se Buscará El Valor De Recargo Para cada prestacion.
 select @MinValor = min(Indice) from #PrestacionValorizada
 select 
@MaxValor = max(Indice) from #PrestacionValorizada
 While @MinValor <= @MaxValor
  begin
   Select @Indice = @MinValor

   select @CodPrestacion     = CodPrestacion,
          @Item              = Item,
          @ValorPrestacion   = ValorPrestacion,
    
      @AporteFinanciador = AporteFinanciador,
          @ErrorExec    = Error
   from   #PrestacionValorizada
   where  Indice = @MinValor

    insert Log_Valorizaciones_Detalle
           (LvdIdeVal_id, LvdCorVal_id, LvdCodPre_ta,
            LvdCodIte_t
a, LvdMonPre_$$, LvdMonBon_$$,
            LvdResVal_re)
    values (@Corr_logControl, @MinValor, @CodPrestacion, @Item,
            case @ValorPrestacion
             when NULL then 0
             else @ValorPrestacion
            end,
            case @
AporteFinanciador
             when NULL then 0
             else @AporteFinanciador
            end,
            case @ErrorExec
             when     0 then 'OK'
             when  7000 then 'UF'
             when 80003 then 'NC'
             when 80004
 then 'NC'
             when 80000 then 'NA'
             when 80002 then 'NA'
             when 80005 then 'NC'
             when 80010 then 'IN'
             when 82000 then 'NA'
             when 86000 then 'IN'
             when 88000 then 'NA'
      
       when 88001 then 'IN'
             when 80001 then 'NA'
             when 30001 then 'IN'
             when  8000 then 'UF'
             when  8001 then 'UF'
             when  8002 then 'SA'
             when 8002 then 'IN'
             else 'IN'
 
           end)

   if @@error != 0
    begin
     rollback tran
     Select @MinValor = @MaxValor + 1
     --raiserror 900000 "Un Error del financiador impide continuar con su solicitud"

     Select @extCodError = 'N'
     Select @extMensajeError = 'TRX
 DENEGADA (EO:4003470)'
     select @Fin=convert(char(26),getdate(),109)
     insert Tiempos values("P5",@Ini,@Fin)

     return 1
    end
   Select @MinValor = @MinValor + 1
  end

 commit tran
*/

 Select  extValorPrestacion   = convert(numeric(12,0),Va
lorPrestacion),
         extAporteFinanciador = convert(numeric(12,0),AporteFinanciador),
         extCopago            = convert(numeric(12,0),ValorPrestacion - AporteFinanciador),
         extInternoIsa        = convert(char(15),
                       
         replicate('0',3 - char_length(ltrim(rtrim(GrupoCobertura))))+
                                ltrim(rtrim(GrupoCobertura))+

                                ltrim(rtrim(ModalCobertura))+
                                replicate(' ',4 - char_leng
th(ltrim(rtrim(ModalCobertura))))+

                                ltrim(rtrim(TipoCalculo))+
                                replicate(' ',2 - char_length(ltrim(rtrim(TipoCalculo))))+

                                replicate('0',6 - char_length(ltrim(
rtrim(convert(char(6),ValorRendicion)))))+
                                ltrim(rtrim(convert(char(6),ValorRendicion)))
                                )
 From    #PrestacionValorizada
 order by Indice


 --// Validacion de Prestaciones Duplicadas
 creat
e table #duplicados
 (
  CodPrestacion         prestacion    not null,
  Item                  tinyint       not null,
  total                 int               null
 )

 insert #duplicados
 Select CodPrestacion, Item, t = count(*)
 from   #PrestacionValo
rizada
 group by CodPrestacion, Item
 having count(*) > 1

 if @@rowcount > 0
  begin
   Select @extCodError = "N"
   Select @extMensajeError = "PRESTACIONES DUPLICADAS"
   select @Fin=convert(char(26),getdate(),109)

   insert Tiempos values("P5",@Ini,@F
in)

   return 1
  end

 drop table #duplicados
 --// Obtención de Línea de Cobertura y Bonificación.

 if (Select count(*) from #PrestacionValorizada) =
    (Select count(*) from #PrestacionValorizada where Error = 0)
  begin
   Select @extCodError = 'S'

   Select @extMensajeError = ''

   select @Fin=convert(char(26),getdate(),109)

   insert Tiempos values("P5",@Ini,@Fin)

   return 1
  end
 else
  begin
   Select @extCodError = 'N'

   set rowcount 1
   Select @extMensajeError = "PREST. NO OTORGAB. (N
º "+
                             ltrim(rtrim(convert(char(10),Indice)))+")"
   from   #PrestacionValorizada
   where  Error <> 0

   set rowcount 0

   select @Fin=convert(char(26),getdate(),109)

   insert Tiempos values("P5",@Ini,@Fin)

   return 1

  
end

end

 
                                                                                                                                                                                                                                                   
(317 rows affected)
(return status = 0)
1> 