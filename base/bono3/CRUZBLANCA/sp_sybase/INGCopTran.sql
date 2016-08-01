locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
438
(1 row affected)
text
create procedure dbo.INGCopTran 
( 
 @extCodFinanciador     smallint, 
 @extHomNumeroConvenio  char(15), 
 @extHomLugarConvenio   char(10), 
 @extSucVenta           char(10), 
 @extRutConvenio        char(12), 
 @extRutTratante        char(12), 
 @extRutS
olicitante     char(12), 
 @extRutBeneficiario    char(12), 
 @extTratamiento        char(1), 
 @extCodigoDiagnostico  char(10), 
 @extNivelConvenio      tinyint, 
 @extUrgencia           char(1), 
 @extLista1             char(255), 
 @extLista2          
   char(255), 
 @extLista3             char(255), 
 @extLista4             char(255), 
 @extLista5             char(255), 
 @extLista6             char(255), 
 @extNumPrestaciones    tinyint, 
 @extCodError           char(1)    output, 
 @extMensajeError 
      char(30)   output, 
 @extPlan               char(15)   output 
) 
/* -- ** ------------------------------------------------------------------------------------- 
   procedimiento : INGCopTran 
   Autor         : Cristian Rivas Rivera. 
  -- ** -----
--------------------------------------------------------------------------------- 
   Modificado    : Mauricio Cosgrove 
   Objetivo      : FR-2357 
  -- ** ------------------------------------------------------------------------------------- 
   Modifica
do    : Mauricio Cosgrove 
   Objetivo      : FR-9155 
  -- ** ------------------------------------------------------------------------------------- 
   Modificado    : Mauricio Cosgrove 
   Objetivo      : FR-7787 
  -- ** -------------------------------
------------------------------------------------------ 
   Modificado    : Mauricio Cosgrove 
   Objetivo      : FR-13964 , corregir llamada a rutina : SerPyT_CoberturaRedFI 
                   Faltaba incluir Nro. Cto. para manejar Dentales Capitados. 
 
 -- ** ------------------------------------------------------------------------------------- 
   Modificado    : Marcelo Herrera 
   Modificado el : Octubre de 2006 
   Objetivo      : FR-13564, Corregir anomalia para prestacion paquetizadas, donde se obt
iene 
                   error: 'Paquete no disponible en la Base' que no corresponde 
  -- ** ------------------------------------------------------------------------------------- 
   Modificado    : Marcelo Herrera 
   Modificado el : Octubre de 2006 
 
  Objetivo      : FR-15167, Modificar tal de diferenciar prestaciones paquetizadas de 
                   prestaciones individuales, donde en ambos casos se informa el primer 
                   caracter del homologo con 'P'. 
  -- ** --------------------
----------------------------------------------------------------- 
 
 
   Parametros I 
       @extCodFinanciador     : Cædigo del Financiador 
       @extHomNumeroConvenio  : Homælogo numero de convenio (11c para Codigo+'-'+ 3c para corr renov) 
       @
extHomLugarConvenio   : Homælogo Lugar de convenio (Corr. Direcciæn) 
       @extSucVenta           : Homælogo Sucursal de Venta (cædigo Sucursal) 
       @extRutConvenio      : Rut Convenio, R.u.t. del prestador en convenio 
       @extRutTratante       
 : Rut Tratante, R.u.t. del m⁄dico tratante o solicitante de examenes. 
       @extRutSolicitante     : Rut Solicitante, R.u.t. de quien solicita el beneficio. 
       @extRutBeneficiario      : RUT del Beneficiario 
       @extTratamiento        : Tratam
iento m⁄dico ('S','N') 
       @extCodigoDiagnostico  : Cædigo de Diagnostico, seg∑n CIE 10 
       @extNivelConvenio      : nivel convenido con el prestador 1,2,3 
       @extLista1             : lista de prestaciones 
                                10c
 para la Prestacion (7c Cod.Prestacion 3c para Item) 
                                1c pipe (|) 
                                1c para el tipo de item (H:Honorario, P:Pabellon) 
                                1c pipe (|) 
                            
    15c Codigo Adicional, 
                                1c pipe (|) 
                                1c pipe el recargo hora (S:Si, N:No) 
                                1c pipe (|) 
                                2c para la cantidad 
               
                 1c pipe (|) 
       @extLista2             : Idem Lista1, 
       @extLista3             : Idem Lista1, 
       @extLista4             : Idem Lista1, 
       @extLista5             : Idem Lista1, 
       @extLista6             : Idem List
a1, 
 
       @extNumPrestaciones    : N∑mero de Prestaciones enviadas en este acto de 
                                ventas. 
 
   Parametros O 
       @extCodError        : Cædigo de Error ('S','N') 
     Corregir por                   S = estador exi
toso de la transaccion 
                                N = fallo o error en transaccion 
       @extMensajeError       : Mensaje de Error. 
       @extPlan               : Plan con el cual se Bonificarﬂ. 
 
   ------------------------ 
   |Servicios para
 C-Salud | 
   ------------------------ 
 
 Descripciæn 
 
   Este Servicio que env›a datos de todas las l›neas de prestaciones 
   al financiador; el que calcula cual es el valor de cada prestacion 
   y cuanto le corresponde al beneficiario 
 
   Prueba
 
 
   declare 
    @extCodError    char(1), 
    @extMensajeError  char(30), 
    @extPlan          char(20) 
 
   exec prestacion..INGCopTran 78, '34845-0', '61754','130001', 
                          '96770100-9','10206760-6','0005308213-0','000530821
3-0', 
                          'S','XXXXXXXXXX',3,'S', 
                         '0202004000|H|202965-1|N|01|1602017000|H|315006-1|N|03|', 
                         '','','','','',3, 
                         @extCodError output, @extMensajeError output
, @extPlan output 
 
   declare 
    @extCodError      char(1), 
    @extMensajeError  char(30), 
    @extPlan        char(20) 
 
   exec prestacion..INGCopTran 78, '40002-000', '70002','130001', 
                               '0096840380-K','0000000000-
0','0005308213-0','0005308213-0', 
                               'S','XXXXXXXXXX',3,'S', 
                               '1707001000|H|               |N|01|1707002000|H|               |N|01|1707001000|H|               |N|01|', 
                          
     '','','','','',3, 
                               @extCodError output, @extMensajeError output, @extPlan output 
 -- ** ----------------------------------------------------------------------------------------- 
*/ 
As 
declare 
         @Hoy         
          fecha, 
         @ErrorExec             int, 
         @extApellidoPat        char(30), 
         @extApellidoMat        char(30), 
         @extNombres            char(40), 
         @extSexo               char(1) , 
         @extFechaNacimi   
     fecha, 
         @extCodEstBen          char(1) , 
         @extDescEstado         char(15), 
         @extRutCotizante       char(12), 
         @extNomCotizante       char(40), 
         @extDirPaciente        char(40), 
         @extGloseComuna   
     char(30), 
         @extGloseCiudad        char(30), 
         @extPrevision          char(1), 
         @extGlosa              char(40), 
         @extDescuentoxPlanilla char(1) , 
         @extMontoExcedente     int, 
         @extRutAcompananate  
  char(12), 
         @extNombreAcompanante  char(40), 
 
         @ValorUF               numeric(10,2), 
         @CodSucursal           sucursal, 
 
         @Marca                 marca, 
         @RutCon                rut, 
         @RutTra          
      rut, 
         @RutSol                rut, 
         @RutBen                rut, 
         @FolCon                int, 
         @CorRen                tinyint, 
         @CorDir                int, 
 
         @FolConAlter           int, 
         
@CorRenAlter           tinyint, 
         @TotConAlter           int, 
 
         @NroContrato           contrato, 
         @RutCte                rut, 
         @cor_car               char(2), 
         @tipo_carga            char(1), 
 
         @Cuent
a_Lista          tinyint, 
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
         @ValorDesde            numeri
c(14,4), 
         @ValorHasta            numeric(14,4), 
         @Item                  tinyint, 
         @CodEsp                char(3), 
         @CantAte               tinyint, 
         @ValorNomina           smallint, 
         @Modalidad         
    char(2), 
         @ErrorCode             int, 
 
         @RecalculoRegimen      char(1), 
         @Indice                numeric(5,0), 
         @Homologo              char(20), 
         @AccionPresta          regla, 
         @CostoCero          
   char(2), 
         @ItemReal              tinyint, 
         @OrigenAtencion        char(1), 
         @CodReg                tinyint, 
         @Urgencia              char(1), 
         @Recargo               char(1), 
         @Combinatoria          
char(50), 
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
         @out_CodNom            sm
allint, 
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
 
         @PorceRecargo          numeric(7,4), 
         @Colectivo   
          int, 
         @GruCob                char(4), 
         @CodLoc                localidad, 
         @CobCodPla_id          codpla, 
         @CobModCob_id          Char(4), 
         @CobGruCob_id          Char(4), 
         @CobCodNom_ta      
    Smallint, 
         @CobPorBon_nn          Numeric(5,2), 
         @CobMonTop_nn          Numeric(11,2), 
         @CobModTop_re          modal, 
         @CobMonTopCon_nn       Numeric(11,2), 
         @CobModTopCon_re       char(4), 
         @CobRa
nCob_nn          Numeric(11,2), 
         @CobMonCop_nn          Numeric(11,2), 
         @CobModCop_re          char(4), 
         @CobNivPpo_nn          Tinyint, 
         @PlaModRef_re          regla, 
         @PlaCobInt_nn          Numeric(11,2), 
  
       @PlaTopBac_nn          Numeric(11,2), 
         @PlaBasAcm_nn          Numeric(11,2), 
         @PlaBonGan_fl          Char(1), 
         @PlaPorFac_nn          Tinyint, 
         @GtaMaxBga_nn          numeric(5,2), 
         @BenEspAplicados     
  char(250), 
         @boni_pend             numeric(11,2), 
         @por_boni              numeric(5,2), 
         @mto_boni              numeric(11,2), 
         @copago                numeric(11,2), 
         @mto_presta            numeric(11,2), 
  
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
 
        @copagoReal            int, 
         @mto_prestaReal        int, 
         @DescEnPesos           int , --//numeric(5,2), 
         @ValorPrestacion       int, 
         @AporteFinanciador     int, 
 
         @extPlanAlternativo    char(15), 
  
       @CodCataPrest          prestacion, 
         @cod_error             int, 
 
         @TotalPrest            int, 
 
         @RenExe_fl             flag, 
         @REDCodPla_id          codpla, 
         @REDModCob_id          Char(4), 
         @
REDGruCob_id          Char(4), 
         @REDCodNom_ta          Smallint, 
         @REDPorBon_nn          Numeric(5,2), 
         @REDMonTop_nn          Numeric(10,2), 
         @REDModTop_re          modal, 
         @REDMonTopCon_nn       Numeric(10,2)
, 
         @REDModTopCon_re       modal, 
         @REDRanCob_nn          Smallint, 
         @REDMonCop_nn          Numeric(10,2), 
         @REDModCop_re          modal, 
         @REDNivPpo_nn          Tinyint, 
         @REDModRef_re          regla, 

         @REDCobInt_nn          Numeric(11,2), 
         @REDTopBac_nn          Smallint, 
         @REDBasAcm_nn          Smallint, 
         @REDBonGan_fl          Char(1), 
         @REDPorFac_nn          Tinyint, 
         @REDMaxBga_nn          Smal
lint, 
 
         @BuscaPorcentaje       bit, --// 0: NO Busque, 1: SI Busque 
         @Porc_RecPqte          numeric(7,4), 
         @Cod_Paquete           int, 
         @Cod_PaqueteHijo       int, 
         @Cod_HomoPaquete       char(15), 
         @
DigMed_cr             dv, 
         @HoyMasUno             fecha, 
         @Ok                    flag, 
         @Cod_PresPaquete       prestacion, 
         @Cod_ItemPaquete       tinyint, 
         @Can_PretPaquete       tinyint, 
         @db_name   
            char(30), 
         @TotalPrestPqte        int, 
         @TotalPrestPqteMatch   int, 
 
         @CobPerTop_fl    flag, 
         @CobAmpGui_fl    flag , 
         @CobPorTop_nn    numeric(5,2), 
         @CobFacEqi_nn    numeric(5,2), 
     
    @Cambia_Linea    flag, 
         @guindas         Char(250), 
         @CobPerOUT_fl    flag, 
         @CobAmpOUT_fl    flag, 
         @CobPorOUT_nn    numeric(5,2), 
         @CobFacOUT_nn    numeric(5,2), 
         @ValAraCal_nn    numeric(11,2), 

         @ModAraCal_cr    char(2), 
         @MntoTopeCto     char(20), 
         @MntoTopeEve     char(20), 
         @MntoTopeInt     char(20), 
         @EdadCARGA       int, 
         @SexoCARGA       flag, 
         @CuentaPlanes    int, 
         @
PreVigMin       int, 
         @PreVigMax       int, 
         @IniVig          fecha, 
         @PreModVig       regla, 
         @ModVig          regla, 
         @TmpoVig         int, 
         @TerVig          fecha, 
         @VigMin          int, 
 
        @VigMax          int, 
         @ResVig          flag, 
         @FecNac          fecha, 
         @EdadMin         int, 
         @EdadMax         int, 
         @ModEda          regla, 
         @ResEdad         flag, 
         @Folio           
  int 
 
 
begin 
  Select @db_name = db_name() 
 
  begin tran 
 
  update prestacion..ContadorFolio 
     set CfoNumFol_nn = CfoNumFol_nn - 1 
  where  CfoCodMar_id = 'IN' 
    And  CfoTipDoc_fl = 'LECT' 
 
  Select @Folio = CfoNumFol_nn 
  From   prest
acion..ContadorFolio 
  where  CfoCodMar_id = 'IN' 
    and  CfoTipDoc_fl = 'LECT' 
 
  commit tran 
 
  begin tran uno 
 
   insert Log_EntradasCopTran 
          (ext_NroTrX, ext_FechaHoraTRX, extCodFinanciador, extHomNumeroConvenio, 
           extHomL
ugarConvenio, extSucVenta, extRutConvenio, extRutTratante, 
           extRutSolicitante, extRutBeneficiario, extTratamiento, extCodigoDiagnostico, 
           extNivelConvenio, extUrgencia, extLista1, extLista2, extLista3, 
           extLista4, extLista
5,  extLista6, extNumPrestaciones) 
   values  (@Folio, getdate(), @extCodFinanciador, @extHomNumeroConvenio, 
            @extHomLugarConvenio, @extSucVenta, @extRutConvenio, @extRutTratante, 
            @extRutSolicitante, @extRutBeneficiario, @extTrat
amiento, @extCodigoDiagnostico, 
            @extNivelConvenio, @extUrgencia, @extLista1, @extLista2, @extLista3, 
            @extLista4, @extLista5,  @extLista6, @extNumPrestaciones) 
 
   if @@error != 0 
    begin 
     rollback tran uno 
     Select 
@extCodError = "N" 
     Select @extMensajeError = "Error en grabacion de Log" --TRX DENEGADA (EI:400365) 
     return 1 
    end 
 
  commit tran uno 
 
 create table #PrestacionValorizada 
 ( 
  Indice                numeric(10,0) identity, 
  CodPresta
cion         prestacion    not null, 
  Item                  tinyint       not null, 
  TipoItem              char(2)           null, 
  AfectoRecargo         char(1)           null, 
  CantAte               tinyint       not null, 
  ModalCobertura     
   char(4)           null, 
  TipoCalculo           regla             null, 
  GrupoCobertura        char(4)           null, 
  Especialidad          char(3)           null, 
  ValorDesde            numeric(14,4)     null, 
  ValorHasta            numeric
(14,4)     null, 
  Nomina                smallint          null, 
  Modalidad             char(2)           null, 
  TipReg                tinyint           null, 
  Homologo              char(20)          null, 
  CostoCero             char(2)          
 null, 
  CopagoFijo            int               null, 
  ValorPrestacion       numeric(12,0)     null, 
  AporteFinanciador     numeric(12,0)     null, 
  Copago                numeric(12,0)     null, 
  ValorRendicion        int               null, 
  
Error                 int               null, 
  Iterar                int       default null null 
 ) 
 
 --// Obtenciæn de la Fecha del Dia. FECHA DEL SERVIDOR SYBASE. 
 Select @Hoy          = convert(smalldatetime,convert(char(10),getdate(),101)) 
 --/
/ Obtenciæn del d›a de Ma±ana 
 Select @HoyMasUno    = dateadd(dd,1,@Hoy) 
 
 --// VALOR DE LA U.F. de la fecha de atenciæn. 
  exec @ErrorExec = convenio..Fecha_UFIPC @Hoy, @ValorUF output 
 if @ErrorExec != 0 
  begin 
   Select @extCodError = 'N' 
   S
elect @extMensajeError = 'No se encontræ valor de la UF' --TRX DENEGADA (EI:400366)' 
   return 1 
  end 
 
 --// Conversiæn del codigo sucursal ORDEN a formate CD-ING 
 Select @CodSucursal = convert(char(6),ltrim(rtrim(@extSucVenta))) 
 
 --//conversiæn 
del Rut del Prestador 
 Select @RutCon = convert(int,substring(ltrim(rtrim(@extRutConvenio)),1,charindex('-',ltrim(rtrim(@extRutConvenio)))-1)) 
 --//conversiæn del RUT del Beneficiario 
 Select @RutBen = convert(int,substring(ltrim(rtrim(@extRutBeneficia
rio)),1,charindex('-',ltrim(rtrim(@extRutBeneficiario)))-1)) 
 --// folio del convenio y correlativo de renovacion 
 Select @FolCon = convert(int,substring(ltrim(rtrim(@extHomNumeroConvenio)),1,charindex('-',ltrim(rtrim(@extHomNumeroConvenio)))-1)) 
 Sele
ct @CorRen = convert(tinyint,substring(@extHomNumeroConvenio,char_length(@extHomNumeroConvenio),1)) 
 --// Correlativo de direccion. 
 Select @CorDir = convert(int,ltrim(rtrim(@extHomLugarConvenio))) 
 
 exec   @ErrorCode = prestacion..INGSelConMar @RutBe
n, @Hoy, @HoyMasUno, 
                                              @Marca output, 
                                              @NroContrato output, 
                                              @Ok output 
 if @Ok = 'N' or @ErrorCode != 0 
  begin 
  
 Select @extCodError = 'N' 
   Select @extMensajeError = 'Fallæ re-validacion del benef'--TRX DENEGADA (EI:400367)' 
   return 1 
  end 
 
 --// Determinaciæn de la Marca en funcion del Prestador. 
 if @Marca = 'AS' Select @extCodFinanciador = 74 
 if @Ma
rca = 'CB' Select @extCodFinanciador = 78 
 
  --// Validadcion de la Certificaciæn del Beneficiario. Importante Rescatar el 
 --// Plan vigente del contrato. 
 exec @ErrorExec = INGBenCertif_out @extCodFinanciador, @extRutBeneficiario, @Hoy, 
           
                         @extApellidoPat        output, @extApellidoMat        output, 
                                    @extNombres            output, @extSexo      output, 
                                    @extFechaNacimi        output, @extCodEst
Ben          output, 
                                    @extDescEstado         output, @extRutCotizante       output, 
                                    @extNomCotizante       output, @extDirPaciente        output, 
                                   
 @extGloseComuna        output, @extGloseCiudad        output, 
                                    @extPrevision          output, @extGlosa    output, 
                                    @extPlan               output, @extDescuentoxPlanilla output, 
   
                                 @extMontoExcedente     output, @extRutAcompananate output, 
                                    @extNombreAcompanante  output 
 
 if @ErrorExec != 0 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'Fal
læ re-validacion del benef' --TRX DENEGADA (EI:400367) 
   return 1 
  end 
 
 if @extCodEstBen <> 'C' 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'Error al certificar al benef.' --TRX DENEGADA (EI:400368)' 
   return 1 
  end 
 

 Select @cor_car     = BenCorCar_id, 
        @tipo_carga  = BenTip_fl, 
        @RutCte      = BenRutCot_id 
 from   contrato..Beneficiario 
 where  BenRutBen_nn = @RutBen 
   and  BenNumCto_id = @NroContrato 
   and  BenMarCon_id = @Marca 
   and  BenIn
iVig_fc <= @Hoy 
   and  BenTerVig_fc >= @Hoy 
 
 if @@rowcount > 1 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'Benef. en mas de un Cto.' 
   return 1 
  end 
 
 Select @EdadCARGA   = datediff(yy, BenFecNac_fc, @Hoy), 
        @S
exoCARGA   = BenSex_fl, 
        @FecNac      = BenFecNac_fc, 
        @IniVig      = BenIniVig_fc 
 from   contrato..Beneficiario 
 where  BenRutCot_id = @RutCte 
   and  BenNumCto_id = @NroContrato 
   and  BenCorCar_id = @cor_car 
   and  BenMarCon_id 
= @Marca 
 
 if @@error != 0 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'Etraer datos del Benf.' 
   return 1 
  end 
 
 --// Obtenciæn de la Lista de PLANES ALTERNATIVOS Posibles. 
 --// y los convenios exclusivos asociados a ⁄l
 
 --// Obtenciæn de la Lista de PLANES ALTERNATIVOS Posibles. 
 --// y los convenios exclusivos asociados a ⁄l 
 create table #PlanesAlternativos 
 ( 
  PlaCodPla_id codpla, 
  Iterar       int null, 
 ) 
 
 Select @Colectivo = ConNumCol_nn 
 from   cont
rato..Contrato 
 where  ConNumCto_id = @NroContrato 
   and  ConMarCon_id = @Marca 
 
 insert #PlanesAlternativos 
 Select distinct PlaCodPla_id, NULL 
 from   contrato..TramoColectivo T, 
        contrato..PlanTramoCol Pt1, 
        contrato..PlanTramoCo
l Pt2, 
        contrato..Plan1 P 
 where  T.TcoNumCol_id   = @Colectivo 
   and  Pt1.PtrNumCol_id = @Colectivo 
   and  Pt1.PtrCorTra_id = T.TcoICorTra_id 
   and  Pt1.PtrCodPla_id = @extPlan 
   and  Pt2.PtrCorTra_id = T.TcoICorTra_id 
   and  Pt2.PtrNu
mCol_id = @Colectivo 
   and  Pt2.PtrCodPla_id = PlaCodPla_id 
   and  Pt2.PtrTipPla_re = "OP" 
   and  Pt2.PtrBloBen_re = 'SI' 
 
 Create index NNICodPla on #PlanesAlternativos(PlaCodPla_id) 
 
 Select distinct PexFolCon_id, PexCorRen_id, T = count(*) 
 
       into #CambioPlan 
 from   convenio..Convenio C, 
        convenio..PlanExcl Pe, 
        #PlanesAlternativos  Pa 
 where  ConRutPre_ta = @RutCon 
   and  PexFolCon_id = ConFolCon_id 
   and  PexCorRen_id = ConCorRen_id 
   and  PlaCodPla_id = PexCo
dPla_id 
 group by PexFolCon_id, PexCorRen_id 
 
 Create index NNIFolConCorRen on #CambioPlan(PexFolCon_id, PexCorRen_id) 
 
 select @CuentaPlanes = count(distinct Pa.PlaCodPla_id) 
 from 
        #CambioPlan cp, 
        convenio..PlanExcl Pe, 
        #
PlanesAlternativos Pa 
 where 
        Pe.PexFolCon_id = cp.PexFolCon_id 
   and  Pe.PexCorRen_id = cp.PexCorRen_id 
   and  cp.PexFolCon_id = Pe.PexFolCon_id 
   and  cp.PexCorRen_id = Pe.PexCorRen_id 
   and  Pa.PlaCodPla_id = Pe.PexCodPla_id 
   and  P
e.PexCodPla_id = Pa.PlaCodPla_id 
 
 if @CuentaPlanes > 0 
  begin 
   if @CuentaPlanes = 1 
    begin 
     select distinct @extPlan = PexCodPla_id 
     from 
            #CambioPlan cp, 
            convenio..PlanExcl Pe, 
            #PlanesAlternativ
os Pa 
     where  Pe.PexFolCon_id = cp.PexFolCon_id 
       and  Pe.PexCorRen_id = cp.PexCorRen_id 
       and  cp.PexFolCon_id = Pe.PexFolCon_id 
       and  cp.PexCorRen_id = Pe.PexCorRen_id 
       and  Pa.PlaCodPla_id = Pe.PexCodPla_id 
       and  P
e.PexCodPla_id = Pa.PlaCodPla_id 
    end 
   else 
    begin 
       select distinct PexCodPla_id 
       into #tmpExtPlan 
       from 
              #CambioPlan cp, 
              convenio..PlanExcl Pe, 
              #PlanesAlternativos Pa, 
         
     contrato..PrestPpalPlan Pp 
       where 
              Pe.PexFolCon_id = cp.PexFolCon_id 
         and  Pe.PexCorRen_id = cp.PexCorRen_id 
         and  cp.PexFolCon_id = Pe.PexFolCon_id 
         and  cp.PexCorRen_id = Pe.PexCorRen_id 
         and
  Pa.PlaCodPla_id = Pe.PexCodPla_id 
         and  Pe.PexCodPla_id = Pa.PlaCodPla_id 
         and  Pp.PppCodPla_id = Pa.PlaCodPla_id 
         and  Pa.PlaCodPla_id = Pp.PppCodPla_id 
         and  Pp.PppRutPre_id = @RutCon 
 
     if @@rowcount = 1 
    
  begin 
         select @extPlan = PexCodPla_id from #tmpExtPlan 
      end 
     else 
      begin 
       Select @extCodError = 'N' 
       Select @extMensajeError = 'Existe mas de 1 plan alternativo' --TRX DENEGADA (EO:400801) 
       return 1 
      
end 
    end 
  end 
 
 Select @FolCon = EciFolCne_ta, 
        @CorRen = EciCorRee_ta, 
        @CorDir = EciCorDie_ta 
 from   convenio..EquivConvIMED 
 where  EciRutPre_id = @RutCon 
   and  EciFolCnv_id = @FolCon 
   and  EciCorRen_id = @CorRen 
   an
d  EciCorDir_id = @CorDir 
   and  EciCodPla_id = @extPlan 
 
 if not exists (Select 1 
                From   convenio..Convenio 
                where  ConFolCon_id = @FolCon 
                  and  ConCorRen_id = @CorRen 
                  and  ConEstC
on_cr in ('AC','IN') 
                  and  ConFecInc_fc <= @Hoy 
                  and  ((ConFecTec_fc >= @Hoy) or (ConFecTec_fc is Null))) 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'Conv. no vigente o suspendido' --TRX DENEGA
DA (EI:400809) 
   return 1 
  end 
 
 
-- ** -------------------------------------------------------- 
-- FR-7787 - Control de Vta. IMED para CMF 
-- Codigo de Modalidad (20) para NO restringir la Vta. IMED 
-- en CMF a ciertos Convenios Medicos. 
 
 
 i
f (@extPlan <> '')and 
    (exists (Select 1 from   contrato..Plan1 
              where  PlaCodPla_id = @extPlan 
                and  PlaFamPla_ta = 'INMECA' )) and 
    (not exists (select 1 from convenio..ModalidadConvenio 
                 where ModF
olCon_id = @FolCon 
                   and ModCorRen_id = @CorRen 
                   and ModCodMod_id = 20)) 
    begin 
       Select @extCodError = 'N' 
       Select @extMensajeError = 'Vta. Elect. restrin. por Conv.' 
       return 1 
    end 
 
-- *
* -------------------------------------------------------- 
 
 
 
 --// Decodificaciæn de las listas de prestaciones. 
 --//Descomposicion de las listas pasadas por parametro. 
 create table #Parametro_Listas ( id numeric(2,0) identity, Lista   char(255) 
) 
 
 if char_length(rtrim(ltrim(@extLista1))) > 0 insert #Parametro_Listas values (@extLista1) 
 if char_length(rtrim(ltrim(@extLista2))) > 0 insert #Parametro_Listas values (@extLista2) 
 if char_length(rtrim(ltrim(@extLista3))) > 0 insert #Parametro_Li
stas values (@extLista3) 
 if char_length(rtrim(ltrim(@extLista4))) > 0 insert #Parametro_Listas values (@extLista4) 
 if char_length(rtrim(ltrim(@extLista5))) > 0 insert #Parametro_Listas values (@extLista5) 
 if char_length(rtrim(ltrim(@extLista6))) > 0
 insert #Parametro_Listas values (@extLista6) 
 
 Select @Total_Listas = 0 
 
 Select @Total_Listas = count(*) from #Parametro_Listas 
 
 if @Total_Listas <= 0 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'No hay prestaciones a val
orizar' --TRX DENEGADA (EO:400368) 
   return 1 
  end 
 
 --//Las listas traen prestaciones de la forma : Prest1|Prest2|Prest3|....|Prestn| 
 --//En esta tabla quedan los strings que corresponden a una unica prestacion. 
 create table #Cadenas 
 ( 
  Cad
ena    char(46) not null, 
  Procesado int          null 
 ) 
 
 Select @Cuenta_Lista = 1 
 
 while @Cuenta_Lista <= @Total_Listas 
  begin 
 
   Select @extListaAUX = Lista 
   from   #Parametro_Listas 
   where  id = @Cuenta_Lista 
 
   Select @MinValor
 = 1 
 
   while charindex('|',ltrim(rtrim(@extListaAUX))) > 0 
    begin 
     Select @extListaX = rtrim(@extListaX) + 
                         substring(@extListaAUX,1,charindex('|',@extListaAUX)) 
     Select @extListaAUX = substring(@extListaAUX,char
index('|',@extListaAUX)+1, 
                           char_length(@extListaAUX)) 
     if @MinValor = 5 
      begin 
       insert #Cadenas values (@extListaX, NULL) 
       Select @extListaX = '' 
       Select @MinValor = 0 
      end 
     Select @Mi
nValor = @MinValor + 1 
    end 
 
   Select @Cuenta_Lista = @Cuenta_Lista + 1 
  end 
 
 if (Select count(*) from #Cadenas) = 0 
  begin 
   --raiserror 900001 "No Se envio lista de prestaciones" 
   Select @extCodError = 'N' 
   Select @extMensajeError 
= 'No hay prestaciones a valorizar' --TRX DENEGADA (EO:400368) 
   return 1 
  end 
 
 --// No la voy a usar mas asi que la elimino. 
 drop table #Parametro_Listas 
 
 create table #PrestacionPaquete 
 ( 
  Indice                int           not null, 
 
 CodPrestacion         prestacion    not null, 
  Item                  tinyint       not null, 
  TipoItem              char(2)           null, 
  AfectoRecargo         char(1)           null, 
  CantAte               tinyint       not null, 
  ModalCobe
rtura        char(4)           null, 
  TipoCalculo           regla             null, 
  GrupoCobertura        char(4)           null, 
  Especialidad          char(3)           null, 
  ValorDesde            numeric(14,4)     null, 
  ValorHasta         
   numeric(14,4)     null, 
  Nomina                smallint          null, 
  Modalidad             char(2)           null, 
  TipReg                tinyint           null, 
  Homologo              char(20)          null, 
  CostoCero             char(2)
           null, 
  CopagoFijo int                          null, 
  ValorPrestacion       numeric(12,0)     null, 
  AporteFinanciador     numeric(12,0)     null, 
  Copago                numeric(12,0)     null, 
  ValorRendicion        int              
 null, 
  Error                 int               null, 
  Iterar                int       default null null 
 ) 
 
 --//Las listas traen prestaciones de la forma : Prest1|Prest2|Prest3|....|Prestn| 
 --//seran decompuesta y dejadas en la tabla #Prestacio
nValorizada. 
 while exists(Select 1 from #Cadenas where Procesado is null) 
  begin 
 
   Select @CodPrestacion = NULL, @Item          = NULL, @TipoItem      = NULL, 
          @AfectoRecargo = NULL, @CantAte       = NULL, @HomologoPrestador = NULL 
 
  
 set rowcount 1 
 
   Select @varCadena = '' 
   Select @varCadena = Cadena from #Cadenas where Procesado is null 
 
   Select @CodPrestacion = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1) 
   Select @Item          = convert(tinyint,s
ubstring(@CodPrestacion,8,3)) 
   Select @CodPrestacion = substring(@CodPrestacion,1,7) 
   Select @varCadena = substring(@varCadena,charindex('|',rtrim(@varCadena))+1,char_length(@varCadena)) 
 
   if char_length(substring(@varCadena,1,charindex('|',ltri
m(rtrim(@varCadena)))-1)) = 0 
    Select @TipoItem      = NULL 
   else 
    Select @TipoItem     = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1) 
   Select @varCadena = substring(@varCadena,charindex('|',@varCadena)+1,char_length(@va
rCadena)) 
 
   Select @HomologoPrestador = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1) 
   Select @varCadena = substring(@varCadena,charindex('|',@varCadena)+1,char_length(@varCadena)) 
 
   if char_length(ltrim(rtrim(@HomologoPrest
ador))) <= 1 Select @HomologoPrestador = NULL 
 
   Select @AfectoRecargo = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1) 
   Select @varCadena = substring(@varCadena,charindex('|',ltrim(rtrim(@varCadena)))+1,char_length(@varCadena)) 

 
   if @AfectoRecargo is null Select @AfectoRecargo = 'N' 
 
   Select @CantAte       = convert(int,substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1)) 
   Select @varCadena = substring(@varCadena,charindex('|',ltrim(rtrim(@varCadena)))+1,
char_length(@varCadena)) 
 
   set rowcount 0 
 
   create table #Especialidades 
   ( 
    EsvCodEsp_id char(3) 
   ) 
 
   Select @ValorDesde = NULL, @ValorHasta = NULL, @ValorNomina = NULL, 
          @CodEsp     = NULL, 
          @Modalidad = NULL,  
@ErrorCode = 0 
 
   --// Los equipos medicos no se convienen por ello, para obtener la especialidad se recurre 
   --// a la prestacion principal. En cualquir otro caso se respeta el item. 
 
   if @Item > 100 and @Item < 1000 
    begin 
     insert #Es
pecialidades 
     Select EsvCodEsp_id 
     from   convenio..EspeServicioDirec 
            ,convenio..GrupoConvenio 
            ,convenio..PrestacionConvenio 
     where EsvCorDir_id = @CorDir 
       and  GcvCorDir_ta = EsvCorDir_id 
       and  GcvCo
dEsp_ta = EsvCodEsp_id 
       and  GcvCorGrc_id = PcvCorGrc_id 
       and  PcvCodPre_ta = @CodPrestacion 
       and  PcvCodIte_ta = 0 
 
      if @@rowcount != 1 
       begin 
        Select @ValorDesde = 0, @ValorHasta = 0, @ValorNomina = 0, @Modalid
ad = '', 
              @ErrorCode = 101001 --// Mﬂs de una Especialidad para esta prestacion - convenio 
       end 
 
      select @CodEsp = EsvCodEsp_id from #Especialidades 
 
    end 
   else 
    begin 
     insert #Especialidades 
     Select EsvCo
dEsp_id 
     from   convenio..EspeServicioDirec 
            ,convenio..GrupoConvenio 
            ,convenio..PrestacionConvenio 
     where EsvCorDir_id = @CorDir 
       and  GcvCorDir_ta = EsvCorDir_id 
       and  GcvCodEsp_ta = EsvCodEsp_id 
       
and  GcvCorGrc_id = PcvCorGrc_id 
       and  PcvCodPre_ta = @CodPrestacion 
       and  PcvCodIte_ta = @Item 
 
     if @@rowcount != 1 
      begin 
       Select @ValorDesde = 0, @ValorHasta = 0, @ValorNomina = 0, @Modalidad = '', 
              @Error
Code = 101001 --// Mﬂs de una Especialidad para esta prestacion - convenio 
      end 
 
      select @CodEsp = EsvCodEsp_id from #Especialidades 
    end 
 
   if @CodEsp is null Select @CodEsp = 'XXX' 
 
   insert #PrestacionValorizada 
   values (@CodP
restacion, @Item, @TipoItem, @AfectoRecargo, 
           @CantAte, NULL, NULL, NULL, @CodEsp, 
           @ValorDesde, 
           @ValorHasta, 
           @ValorNomina, @Modalidad, NULL,@HomologoPrestador, 
           NULL,NULL,NULL, NULL,NULL,NULL,@Erro
rCode, NULL) 
 
   drop table #Especialidades 
 
   set rowcount 1 
 
   update #Cadenas 
      set Procesado = 1 
   where  Procesado is null 
 
   set rowcount 0 
 
   Select  @PreVigMin    = CapVigMin_nn, 
           @PreVigMax    = CapVigMax_nn, 
    
       @PreModVig    = CapUniVig_re, 
           @EdadMin      = CapEdaMin_nn, 
           @EdadMax      = CapEdaMax_nn, 
           @ModEda       = CapModEda_re 
   from    prestacion..CatalogoPrestacion 
   where   CapCodPre_id = @CodPrestacion 
 
  --/
// Control de Otorgamiento de Prestaciones por Sexo, Edad, IMED. 
   if not exists (Select 1 
                  from   prestacion..CatalogoPrestacion 
                  where  CapCodPre_id = @CodPrestacion 
                    and  CapResSex_re in ('T',@S
exoCARGA)) 
    begin 
     Select @extCodError = 'N' 
     if @SexoCARGA = 'M' 
      Select @extMensajeError = 'Cæd. no otorg. sexo masculino' --(EO:400811)'//No Otorgable Masculino 
     else 
      Select @extMensajeError = 'Cæd. no otorg. sexo femeni
no' --(EO:400812) //No Otorgable Femenino 
     return 1 
    end 
 
   Select @EdadCARGA = case @ModEda 
                        when 'YY' then convert(int, datediff(mm,@FecNac,@Hoy) / 12) 
                        when 'QQ' then datediff(qq,@FecNac,@Hoy)
 
                        when 'MM' then datediff(mm,@FecNac,@Hoy) 
                        when 'WK' then datediff(wk,@FecNac,@Hoy) 
                        when 'DD' then datediff(dd,@FecNac,@Hoy) 
                       end 
 
   Select @ResEdad = 'S' 

 
   Select @ResEdad = 'N' 
   where  @EdadMin <= @EdadCARGA 
     and  @EdadMax >= @EdadCARGA 
 
   if (@ResEdad = 'S') 
    begin 
     Select @extCodError = 'N' 
     Select @extMensajeError = 'Cæd. no otorg. Benef esta edad' --(EO:400813)' --//No Oto
rgable Edad 
     return 1 
    end 
 
   if exists (Select 1 
              from   prestacion..CatalogoPrestacion 
              where  CapCodPre_id = @CodPrestacion 
                and  CapVtaIme_re = 'NO') 
    begin 
     Select @extCodError = 'N' 
 
    Select @extMensajeError = 'Cæd. no otorg. Benef por I-med' --(EO:400814)' --//No Otorgable IMED 
     return 1 
    end 
 
--//   Select Hoy = @Hoy, FNac= @FecNac, diff = convert(int, datediff(mm,@FecNac,@Hoy) / 12) 
 
   --///  Vigencia Minima de Oto
rgamiento 
   Select @TmpoVig = case @PreModVig 
                      when 'YY' then convert(int, datediff(mm,@IniVig,@Hoy) / 12) 
                      when 'QQ' then datediff(qq,@IniVig, @Hoy) 
                      when 'MM' then datediff(mm,@IniVig, 
@Hoy) 
                      when 'WK' then datediff(wk,@IniVig, @Hoy) 
                      when 'DD' then datediff(dd,@IniVig, @Hoy) 
                     end 
 
--//   Select Min_ = @PreVigMin, Tmp = @TmpoVig, Max_ = @PreVigMax, @PreModVig 
 
   Selec
t @ResVig = 'S' 
   Select @ResVig = 'N' 
   where  @PreVigMin <= @TmpoVig 
     and  @PreVigMax >= @TmpoVig 
 
   if (@ResVig = 'S') 
    begin 
     Select @extCodError = 'N' 
     Select @extMensajeError = 'No otorg por rango de vigencia.'--TRX DENEGAD
A (EO:400815)' --//No Otorgable Vigencia Valida 
     return 1 
    end 
 
  end --// fin del ciclo While para decodificar las prestaciones. 
 
 --// Control de Prestaciones Kin⁄sicas (06...) e Inmunoterapia (1707036). 
 --// Se requiere el siguiente Cont
rol: 
 --// No se pueden dar en un Acto de Venta mas de 3 prestaciones distintas del 
 --// grupo 06 (FNS) acompa±adas de sælo una prestaciæn de evaluaciæn (0601001) 
 --// y la cantidad para cada una de ellas debe ser "1" 
 --// En el caso de la inmunote
rapia la cantidad debe ser "1". 
 
 Select distinct CodPrestacion, Item, CantAte, cont = count(*) 
        into #ControlKinesEInmunoT 
 From   #PrestacionValorizada 
        ,prestacion..CatalogoPrestacion 
 where  CapCodGru_ta = 6 
   and  CapCodSug_ta =
 1 
   and  CapEstVig_re = 'VI' 
   and  CapCodPre_id = CodPrestacion 
 group by CodPrestacion, Item, CantAte 
 
 
 -- Control general de Prest. KINE en cantidad = 1 
 if exists (Select 1 From #ControlKinesEInmunoT 
            where CantAte <> 1) 
  begi
n 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'Prest. kines en cant. mayor a 1' -- TRX DENEGADA (EO:400803) 
   --// Select "retornar", @extCodError, @extMensajeError 
   return 1 
  end 
 
 
  -- ** FR-9155 -------------------------------
------------ 
  /* 
 --//Control de Multiples Filas con la Misma Prestacion. 
 if exists (Select 1 From #ControlKinesEInmunoT 
            where CodPrestacion = '0601029') 
  begin 
   if (select sum(cont) 
       from   #ControlKinesEInmunoT ) >= 3 
    
begin 
     Select @extCodError = 'N' 
     Select @extMensajeError = 'Cæd. no eval. junto a 0601029' --TRX DENEGADA (EO:400808)' 
     --// Select "retornar", @extCodError, @extMensajeError 
     return 1 
    end 
  end 
 else 
  begin 
   if (select su
m(cont) 
       from   #ControlKinesEInmunoT ) >= 5 
    begin 
     Select @extCodError = 'N' 
     Select @extMensajeError = 'Imposible + 4 Prestacion KINE' --TRX DENEGADA (EO:400804) 
     --// Select "retornar", @extCodError, @extMensajeError 
     re
turn 1 
    end 
  end 
  */ 
  -- ** ------------------------------------------------------- 
 
 if exists (select 1 
            from   #ControlKinesEInmunoT 
            where  cont > 1) 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeErro
r = 'Prest mﬂs de 1 vez en la venta' --TRX DENEGADA (EO:400806) 
   --// Select "retornar", @extCodError, @extMensajeError 
   return 1 
  end 
 
 
 
 
 -- ** --------------------------------------------------------------- 
 -- FR-9155 
 -- La prestacion 
0601029 solo se puede emitir con la prestacion 0601001, o por si sola. 
 
 if (exists (Select 1 From #ControlKinesEInmunoT 
            where CodPrestacion = '0601029'))    	-- validar si existe la prestacion 
  begin 
 
 
    if (exists (select 1 from #C
ontrolKinesEInmunoT 
            having count(*)=2)) 				-- Validar mas de una prestacion 
       if (not exists (Select 1 From #ControlKinesEInmunoT 
            where CodPrestacion = '0601001'))		-- validar si la proxima prestacion debe ser la 0601001 

          begin 
            Select @extCodError = 'N' 
            Select @extMensajeError = 'prest. NO evaluativa.' 
            --// Select "retornar", @extCodError, @extMensajeError 
            return 1 
          end 
 
    if (exists (select 1 from
 #ControlKinesEInmunoT 
            having count(*)>2 )) 			                    -- Validar mas de una prestacion 
     begin 
            Select @extCodError = 'N' 
            Select @extMensajeError = 'prest. NO evaluativa.' 
            --// Select "re
tornar", @extCodError, @extMensajeError 
            return 1 
     end 
 
 
  end 
 
 
 -- ** ---------------------------------------------------------------- 
 -- FR-9155 
 -- Las prestaciones <0601017,0601030> solo se pueden emitir con la prestacion 06
01001 con las siguientes convinatorias 
 -- 0601030 		-- por si sola 
 -- 0601017 		-- por si sola 
 -- 0601017 		con 0601001 
 -- 0601030 		con 0601001 
 -- 0601017,0601030 	con 0601001 
 -- 0601030,0601017     -- por si sola 
 
 
 
if  (exists (Select 1
 From #ControlKinesEInmunoT 
            where CodPrestacion = '0601017'))and 
      (exists (Select 1 From #ControlKinesEInmunoT 
            where CodPrestacion = '0601030'))							-- validar si existe la prestacion 
   begin 
 
    if (exists (select 1
 from #ControlKinesEInmunoT 
            having count(*)= 3 )) 			                               -- Validar mas de una prestacion 
       if not (exists (Select 1 From #ControlKinesEInmunoT 
            where CodPrestacion = '0601001'))	 -- validar si la 
proxima prestacion debe ser la 0601001 
          begin 
            Select @extCodError = 'N' 
            Select @extMensajeError = 'prest. NO evaluativa.' 
            --// Select "retornar", @extCodError, @extMensajeError 
            return 1 
      
    end 
   end 
 
 
--  ** ----------------------------------------------------------------------- 
 
 delete #ControlKinesEInmunoT where  CodPrestacion = '0601001' 
 
 
   -- ** FR-9155 ---------------------------------------- 
   /* 
 
  if exists (Sel
ect 1 From #ControlKinesEInmunoT 
            where CodPrestacion = '0601029') 
  begin 
   if (Select sum(count(distinct CodPrestacion)) 
       from   #ControlKinesEInmunoT) >= 2 
    begin 
     Select @extCodError = 'N' 
     Select @extMensajeError =
 'Prest. No evaluativa  asoc. 0601029.' --TRX DENEGADA (EO:400808) 
     --// Select "retornar", @extCodError, @extMensajeError 
     return 1 
    end 
  end 
 else 
  begin 
   if (Select sum(count(distinct CodPrestacion)) 
       from   #ControlKinesEI
nmunoT) >= 4 
    begin 
     Select @extCodError = 'N' 
     Select @extMensajeError = 'Imposible + 4 Prestacion KINE' --TRX DENEGADA (EO:400804) 
     --//"retornar", @extCodError, @extMensajeError 
     return 1 
    end 
  end 
   -- ** --------------
---------------------------------- 
   */ 
 
 
 if exists (Select 1 
            From   #PrestacionValorizada 
            where  CodPrestacion = '1707036' 
              and  CantAte <> 1) 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeErro
r = '1707036 en cant. mayor a 1' --TRX DENEGADA (EI:400805) 
   --//Select "retornar", @extCodError, @extMensajeError 
   return 1 
  end 
 
 --// FIN Control de Prestaciones Kin⁄sicas (06...) e Inmunoterapia (1707036). 
 
 
 
 
 -- ** -------------------
--------------------------------------------- 
 -- FR-9155 
 -- Control sobre prestaciones de Examenes de Laboratorio. 
 
 Select distinct CodPrestacion, Item, CantAte, cont = count(*) 
        into #ControlExamenesLab 
 From   #PrestacionValorizada 
    
    ,prestacion..CatalogoPrestacion 
 where  CapCodGru_ta = 3 
   and  CapEstVig_re = 'VI' 
   and  CapCodPre_id = CodPrestacion 
 group by CodPrestacion, Item, CantAte 
 
 
 
 -- Excluir la vta. de prestaciones que estan creadas para dar complitud de cod
igos de prestaciones 
 -- Ejemplo :  Si se esta vendiendo el codigo 0302075, no podemos generar una venta admas de las 
 -- siguientes prestaciones junto con el codigo antes mencionado. 
 -- 0302005,0302012,0302015,0302030,0302040,0302042,0302047,0302057,
0302060,0302059,0302076,0302067. 
 
 if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion = '0302075'))    		-- validar si existe la prestacion - Perfil Bioquimico 
    if (exists (select 1 from #ControlExamenesLab 
            h
aving count(*) > 1 )) 					-- Validar mas de una prestacion 
       if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion in ('0302005','0302012','0302015','0302030','0302040','0302042','0302047', 
                                
    '0302057','0302060','0302063','0302067') 
          ))							-- validar si las proxima prestaciones NO pueden ser.... 
          begin 
            Select @extCodError = 'N' 
            Select @extMensajeError = 'Prestaciæn ya incluida en 0302075.' 

            --// Select "retornar", @extCodError, @extMensajeError 
            return 1 
          end 
 
 
 if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion = '0302076'))    		-- validar si existe la prestacion - Perfil hep
atico 
    if (exists (select 1 from #ControlExamenesLab 
            having count(*) > 1 )) 			-- Validar mas de una prestacion 
       if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion in ('0301059','0302013','0302040','0302
045','0302063') 
          ))							-- validar si las proxima prestaciones NO pueden ser.... 
          begin 
            Select @extCodError = 'N' 
            Select @extMensajeError = 'Prestaciæn ya incluida en 0302076' 
            --// Select "retor
nar", @extCodError, @extMensajeError 
            return 1 
          end 
 
 if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion = '0309022'))    		-- validar si existe la prestacion - Orina Completa 
    if (exists (select 1 f
rom #ControlExamenesLab 
            having count(*) > 1 )) 			-- Validar mas de una prestacion 
       if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion in ('0309024','0309023') 
          ))							-- validar si las proxima p
restaciones NO pueden ser.... 
          begin 
            Select @extCodError = 'N' 
            Select @extMensajeError = 'Prestaciæn ya incluida en 0309022' 
            --// Select "retornar", @extCodError, @extMensajeError 
            return 1 
   
       end 
 
 
if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion = '0306011'))    		-- validar si existe la prestacion - Oricultivo 
    if (exists (select 1 from #ControlExamenesLab 
            having count(*) > 1 )) 			-- 
Validar mas de una prestacion 
       if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion in ('0307015','0306026') 
          ))							-- validar si las proxima prestaciones NO pueden ser.... 
          begin 
            Select
 @extCodError = 'N' 
            Select @extMensajeError = 'Prestaciæn(es) ya incluida(s) en el cædigo 0306011, Urocultivo.' 
            --// Select "retornar", @extCodError, @extMensajeError 
            return 1 
          end 
 
 
if (exists (Select 1
 From #ControlExamenesLab 
            where CodPrestacion = '0308044'))    		-- validar si existe la prestacion - Oricultivo 
    if (exists (select 1 from #ControlExamenesLab 
            having count(*) > 1 )) 			-- Validar mas de una prestacion 
     
  if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion in ('0306004','0306005','0306008','0306017','0306026') 
          ))							-- validar si las proxima prestaciones NO pueden ser.... 
          begin 
            Select @extC
odError = 'N' 
            Select @extMensajeError = 'Prestaciæn ya incluida en 0308044' 
            --// Select "retornar", @extCodError, @extMensajeError 
            return 1 
          end 
 
 
if (exists (Select 1 From #ControlExamenesLab 
         
   where CodPrestacion = '0301045'))    		-- validar si existe la prestacion - Hemograma 
    if (exists (select 1 from #ControlExamenesLab 
            having count(*) > 1 )) 			-- Validar mas de una prestacion 
       if (exists (Select 1 From #ControlE
xamenesLab 
            where CodPrestacion in ('0301086','0301036','0301038','0301065','0301064','0301069') 
          ))							-- validar si las proxima prestaciones NO pueden ser.... 
          begin 
            Select @extCodError = 'N' 
            
Select @extMensajeError = 'Prestaciæn ya incluida en 0301045' 
            --// Select "retornar", @extCodError, @extMensajeError 
            return 1 
          end 
 
if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion = '030
2034'))    		-- validar si existe la prestacion - Oricultivo 
    if (exists (select 1 from #ControlExamenesLab 
            having count(*) > 1 )) 			-- Validar mas de una prestacion 
       if (exists (Select 1 From #ControlExamenesLab 
            wher
e CodPrestacion in ('0302067','0302068','0302064') 
          ))							-- validar si las proxima prestaciones NO pueden ser.... 
          begin 
            Select @extCodError = 'N' 
            Select @extMensajeError = 'Prestaciæn ya incluida en 03020
34' 
            --// Select "retornar", @extCodError, @extMensajeError 
            return 1 
          end 
 
 -- ** ---------------------------------------------------------------- 
 
 
 
 
 
 
 --// Para que el procedimiento siga el mismo flujo probad
o y hasta la fecha OK. 
 --// se separaran las prestaciones normales de las de tipo paquete. Estas ultimas 
 --// se trataran en un ciclo aparte. y cercano al final de este codigo. 
 
 insert #PrestacionPaquete 
 Select Indice, CodPrestacion, Item, TipoIt
em, AfectoRecargo, CantAte, 
        ModalCobertura,  TipoCalculo,  GrupoCobertura,  Especialidad, 
        ValorDesde, ValorHasta, Nomina, Modalidad, TipReg, 
        Homologo, CostoCero, CopagoFijo, ValorPrestacion, AporteFinanciador, Copago, 
        V
alorRendicion, Error, Iterar 
 from   #PrestacionValorizada 
 where  substring(Homologo,1,1) = 'P' and char_length(LTrim(RTrim(Homologo))) = 15 
 
 delete #PrestacionValorizada 
 where  substring(Homologo,1,1) = 'P' and char_length(LTrim(RTrim(Homologo)))
 = 15 
 
 --// NOTAR QUE: #PrestacionValorizada mantiene las prestaciones normales. 
 --//            #PrestacionPaquete    mantiene las prestaciones incluidas en 
 --//            un paquete de prestaciones. 
 
  --// En este punto tengo todas las presta
ciones requeridas. 
  --// para valorizarlas debemos recorrer la tabla #PrestacionValorizada 
  --// actualizando los datos faltantes a medida que se van obteniendo. 
 
  Select @RecalculoRegimen = 'N' 
 
  Select @MinValor = min(Indice) from #PrestacionV
alorizada 
  Select @MaxValor = max(Indice) from #PrestacionValorizada 
  Select @Indice   = @MinValor 
 
  While @MinValor <= @MaxValor 
   begin 
     if exists (select 1 from #PrestacionValorizada 
                where  Indice   = @Indice) 
      begi
n 
        Select @CodPrestacion = CodPrestacion, 
               @Item          = Item, 
               @TipoItem      = TipoItem, 
               @AfectoRecargo = AfectoRecargo, 
               @Homologo      = ltrim(rtrim(Homologo)), 
               @C
antAte       = CantAte, 
               @CodEsp        = Especialidad 
        from   #PrestacionValorizada 
        where  Indice = @Indice 
 
        --//VALIDACION DE EXISTENCIA DEL MEDICO TRATANTE O SOLICITANTE. 
        --// 
        --//REGLA DE NEG
OCIO: * Si no hay solicitante o tratante no importa. el bono soporta nulos. 
        --//                  * Tratante y Solicitante son mutuamente excluyentes. 
        --//                  * De Venir un tratante ⁄ste debe estar asociado al prestador en 
convenio 
        --//     de no ser asi, es causal de rechazo del servicio. 
        --//                  * De venir un Solicitante. ⁄ste debe estar en la base de prestadores. sino lo ingreso 
        --//                    con datos basicos. Si no pud
o ser ingresado. rechazo el servicio. 
        exec @ErrorExec = prestacion..INGCtrl_TratSol @Marca, @CodPrestacion, @AccionPresta output 
 
        if @ErrorExec != 0 
         begin 
          Select @extCodError = 'N' 
          Select @extMensajeError
 = 'Fallæ ingreso trat./solicit.' --TRX DENEGADA (EI:400377) 
          return 1 
         end 
 
        if @AccionPresta not in ('PR','AM') 
         begin 
          if @AccionPresta = 'TR' 
           begin --// Tratante es Exigible 
            if no
t ((@extRutTratante = '0000000000-0')or(@extRutTratante is NULL)or(@extRutTratante = '')) 
             begin 
              Select @RutTra = convert(int,substring(ltrim(rtrim(@extRutTratante)),1,charindex('-',ltrim(rtrim(@extRutTratante)))-1)) 
 
       
       if not exists (Select 1 from convenio..PrestRelaEspeDirec 
                             where  RedRutPre_id = @RutCon 
                               and  RedRutPrr_id = @RutTra 
                               and  RedCodRel_id = 1 
               
                and  RedCorDir_id = @CorDir) 
               begin 
                Select @extCodError = 'N' 
                Select @extMensajeError = 'Trat. no relacionado con Prest.' --TRX DENEGADA (EO:400371) 
                return 1 
              
 end 
             end 
            else 
             Select @RutTra = @RutCon 
           end --// Tratante es Exigible 
 
          if @AccionPresta = 'SO' 
           begin  --// Solicitante es Exigible 
             if not ((@extRutSolicitante = '000
0000000-0')or(@extRutSolicitante is NULL)or(@extRutSolicitante = '')) 
              begin 
               Select @RutSol = convert(int,substring(ltrim(rtrim(@extRutSolicitante)),1,charindex('-',ltrim(rtrim(@extRutSolicitante)))-1)) 
               Select
 @DigMed_cr = substring(ltrim(rtrim(@extRutSolicitante)),charindex('-',ltrim(rtrim(@extRutSolicitante)))+1,1) 
 
               Select @RutTra = @RutSol 
 
               --// Control de TRatante distinto al Prestador en convenio 
               --// Soli
citado Por Contralor de la Isapre. 
               if @RutTra = @RutCon 
                begin 
                 Select @extCodError = 'N' 
                 Select @extMensajeError = 'Trat./Solic. no existe.' --TRX DENEGADA (EI:400380) 
                 r
eturn 1 
                end --// 
 
               if not exists(Select 1 from convenio..Prestador where PreRutPre_id = @RutTra) 
                begin 
 
                 if rtrim(ltrim(@db_name)) = 'migracion' 
                   exec @ErrorCode = migr
acion..InsertPrestador @RutSol,@DigMed_cr,'MEDICO ING x CSALUD00', null, 
                                                                null, 'ME', NULL, NULL, 'NA', 
                                                                'NA',NULL,NULL,NULL,NU
LL,NULL,NULL, 
                                                                @Hoy, @CodSucursal, 'CSALUD00', 'PI' 
                 else 
                   exec @ErrorCode = convenio..InsertPrestador @RutSol,@DigMed_cr,'MEDICO ING x CSALUD00', null, 
 
                                                               null, 'ME', NULL, NULL, 'NA', 
                                                                'NA',NULL,NULL,NULL,NULL,NULL,NULL, 
                                                            
    @Hoy, @CodSucursal, 'CSALUD00', 'PI' 
                 if @ErrorCode !=  0 
                  begin 
                   Select @extCodError = 'N' 
                   Select @extMensajeError = 'Fallo ingreso de Prestador' --TRX DENEGADA (EO:400372) 
  
                 return 1 
                  end 
                end 
              end 
             else 
              begin 
               if @RutTra is null 
                Select @RutTra = @RutCon 
              end 
           end --// Solicitan
te es Exigible 
         end 
        else 
         begin 
          Select @RutTra = NULL 
          if not ((@extRutTratante = '0000000000-0')or(@extRutTratante is NULL)or(@extRutTratante = '')) 
           Select @RutTra = convert(int,substring(ltrim(
rtrim(@extRutTratante)),1,charindex('-',ltrim(rtrim(@extRutTratante)))-1)) 
 
          Select @RutSol = NULL 
          if not ((@extRutSolicitante = '0000000000-0')or(@extRutSolicitante is NULL)or(@extRutSolicitante = '')) 
           Select @RutSol = c
onvert(int,substring(ltrim(rtrim(@extRutSolicitante)),1,charindex('-',ltrim(rtrim(@extRutSolicitante)))-1)) 
 
          if @RutTra is null Select @RutTra = @RutSol 
          if @RutSol is null Select @RutTra = @RutCon 
          if not exists(Select 1 f
rom convenio..Prestador where PreRutPre_id = @RutTra) 
           begin 
            Select @extCodError = 'N' 
            Select @extMensajeError = 'Trat. / Solic. No Registrado' --TRX DENEGADA (EO:400380) 
            return 1 
           end 
        
 end 
 
        --// SI EL HOMOLOGO RECIBIDO ES IGUAL AL CODIGO PRESTACION, 
        --// se esta indicando que existe un arancel unico para esa prestacion, y por ello 
        --// el homologo recibido no debe ser utilizado en la busqueda del arancel. 
 
       if rtrim(ltrim(@CodPrestacion)) + convert(char(3),replicate('0',3 - 
                                         char_length(ltrim(rtrim(convert(char(3),@Item)))))+ 
                                         ltrim(rtrim(convert(char(3),@Item)))) = rtri
m(ltrim(@Homologo)) 
         begin 
          Select @Homologo = NULL 
         end 
 
        Select @ItemReal = @Item 
        Select @Item     = 0 
 
        --// Esquema Rigido de Tipos de Regimen para prestaciones. 
        --// --------------------
--------------------------------- 
        --// 
        --// De definen como base los siguientes tipos de regimen. 
        --// Regimen  1 : Regimen basico, siempre debe existir en el Arancel. 
        --// Regimen 51 : Regimen que diferencia un Arancel
 para Horario Inhabil 
        --// Regimen 52 : Regimen que diferencia un Arancel para Urgencias. 
        --// 
        --// De esta manera se compone el siguiente algoritmo: 
        --// 
        --// Inhabil        Urgencia 
        --// N           
   N          => Reg =  1 
        --// S              N          => Reg = 51 
        --// N              S          => Reg = 52 
        --// S              S          => Reg = 52 multiplicado por % de Recargo H.Inhabil. Sino 
        --//              
                existe Reg = 52 entonces Reg = 1 multiplicado por % de 
        --//                              Recargo H.Inhabil, del convenio de la prestacion. 
        --// 
        --// De agregarse otro tipo de regimen convenios debera informarnosl
o y 
        --// se debera analizar el impacto sobre esta rutina. 
        Select @CodReg = 1 
        if @RecalculoRegimen = 'N' 
         begin 
          if @AfectoRecargo = 'N' and @extUrgencia = 'N' Select @CodReg =  1 
          if @AfectoRecargo =
 'S' and @extUrgencia = 'N' Select @CodReg = 51 
          if @AfectoRecargo = 'N' and @extUrgencia = 'S' Select @CodReg = 52 
          if @AfectoRecargo = 'S' and @extUrgencia = 'S' Select @CodReg = 52 
         end 
 
        if @CodEsp is not null and
 @CodEsp <> 'XXX' 
         begin --// INICIO 
           if @ItemReal > 0 and @ItemReal < 99 --//Este Item Debiera Ser un Pabellæn. 
            begin 
             -- // Obtenciæn de la Næmina gen⁄rica del convenio. REGLA DE NEGOCIO. 
             Selec
t @ValorNomina = ConCodNom_ta 
             From   convenio..Convenio 
             where  ConFolCon_id = @FolCon 
                and ConCorRen_id = @CorRen 
 
               --//PASO PROD exec prestacion..Sel_VPPabellones_out 
               exec @Error
Exec = convenio..Sel_VPPabellones_out @RutCon, @FolCon, @CorRen, 
                                                                 @CorDir, @CodEsp, @CodPrestacion, 
                                                                 @ItemReal, @ValorNomina,
 @Hoy, 
                                                                 @Homologo, @CodReg, 
                                                                 @ValorNomina output, 
                                                                 @CodPrest
    output, 
                                                                 @CodItem     output, 
                                                                 @CodReg      output, 
                                                                 @Co
dHomo     output, 
                                                                 @ValorDesde  output, 
                                                                 @ValorHasta  output, 
                                                              
   @Modalidad   output, 
                                                                 @CopagoFijo  output, 
                                                                 @ErrorCode   output, 
                                                        
         @CostoCero   output 
 
               if @ErrorCode != 0 
                begin 
                 update #PrestacionValorizada 
                    set ValorDesde = 0, 
                        ValorHasta = 0, 
                        Nomina     =
 @ValorNomina, 
                        Modalidad  = '' 
                 where  Indice = @Indice 
 
                 update #PrestacionValorizada 
                  set Error      = @ErrorCode 
                 where  Indice = @Indice 
                  
 and  Error  = 0 
                end 
               else 
                begin      -- // No se detecto Error. 
                 update #PrestacionValorizada 
                    set CodPrestacion = @CodPrest, 
                        Item          = @
CodItem, 
                        ValorDesde    = @ValorDesde, 
                        ValorHasta    = @ValorHasta, 
                        Nomina        = @ValorNomina, 
                        Modalidad     = @Modalidad, 
                        TipRe
g        = @CodReg, 
                        Homologo      = @CodHomo, 
                        CopagoFijo    = @CopagoFijo, 
                        CostoCero     = @CostoCero 
                 where  Indice = @Indice 
                end 
 
            
end --// FIN DE VALORIZACION DE PABELLON 
 
           --//Este Item Debiera Ser una Prestacion Principal o Un HMQ 
           if not (@ItemReal > 0 and @ItemReal < 99) 
            begin 
             --// Certificacion del Convenio... 
 
             ex
ec @ErrorExec = convenio..Sel_VPCertificaConvenio @RutCon, @FolCon, @CorRen, 
                                                                 @CorDir, @CodEsp, 
                                                                 @CodPrestacion, @Item, 
    
                                                             @Hoy, 
                                                                 @ValorDesde output, 
                                                                 @ValorHasta output, 
               
                                                  @ValorNomina output, 
                                                                 @Modalidad output, 
                                                                 @CostoCero output 
 
            
 if @ErrorExec != 0 
              begin 
               update #PrestacionValorizada 
                  set ValorDesde = 0, 
                      ValorHasta = 0, 
                      Nomina    = @ValorNomina, 
                      Modalidad  = '' 
  
             where  Indice = @Indice 
 
               update #PrestacionValorizada 
                  set Error  = @ErrorExec 
               where  Indice = @Indice 
                 and  Error  = 0 
 
              end 
 
             if @Modalidad in 
('PE','UF') 
              begin 
               update #PrestacionValorizada 
                  set ValorDesde = case @Modalidad 
                                     when 'PE' then @ValorDesde 
                                     when 'UF' then floor(r
ound(@ValorDesde * @ValorUF,0)) 
                                   end, 
                             ValorHasta = case @Modalidad 
                                     when 'PE' then @ValorHasta 
                                     when 'UF' then floor
(round(@ValorHasta * @ValorUF,0)) 
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
 
              end --// @Modalidad in ('PE','UF
') 
 
             if @Modalidad = 'VA' 
              begin 
                create table #Arancel 
                ( 
                 AraCodNom_ta    smallint       not null, 
                 AraCodPre_ta    prestacion     not null, 
                 
AraCodIte_ta    tinyint        not null, 
                 AraCodReg_ta    tinyint        not null, 
                 AraCodExt_cr    char(20)       not null, 
                 AraCopFij_nn    int           null, 
                 AraModVal_ta    regla   
       not null, 
                 AraValAra_nn    numeric(10,2)  not null 
                ) 
 
                if @Homologo is null 
                 begin 
                  insert  #Arancel 
                  Select  AraCodNom_ta, AraCodPre_ta, AraCod
Ite_ta, AraCodReg_ta, AraCodExt_cr, AraCopFij_nn, 
                          AraModVal_ta, AraValAra_nn 
                  From    prestacion..Arancel 
                  where  AraCodPre_ta =  @CodPrestacion 
                    and  AraCodIte_ta =  @Item
 
                    and  AraCodReg_ta =  @CodReg 
                    and  AraCodNom_ta =  @ValorNomina 
                 --//and  AraCodExt_cr =  @Homologo 
                    and  AraFecIna_fc <= @Hoy 
                  and  AraFecTea_fc >= @Hoy 
   
               union 
                  Select  AraCodNom_ta, AraCodPre_ta, AraCodIte_ta, AraCodReg_ta, AraCodExt_cr, AraCopFij_nn, 
                          AraModVal_ta, AraValAra_nn 
                  From   prestacion..Arancel 
                  wher
e  AraCodPre_ta =  @CodPrestacion 
                    and  AraCodIte_ta =  @Item 
                    and  AraCodReg_ta =  @CodReg 
                    and  AraCodNom_ta =  @ValorNomina 
                    --//and  AraCodExt_cr =  @Homologo 
           
         and  AraFecIna_fc <= @Hoy 
                    and  AraFecTea_fc is Null 
 
                  Select @TotalFilas = @@rowcount 
 
                 end 
                else 
                 begin 
 
                  insert  #Arancel 
           
       Select  AraCodNom_ta, AraCodPre_ta, AraCodIte_ta, AraCodReg_ta, AraCodExt_cr, AraCopFij_nn, 
                          AraModVal_ta, AraValAra_nn 
                  From    prestacion..Arancel 
                  where  AraCodPre_ta =  @CodPrestacio
n 
                    and  AraCodIte_ta =  @Item 
                    and  AraCodReg_ta =  @CodReg 
                    and  AraCodNom_ta =  @ValorNomina 
                    and  AraCodExt_cr =  rtrim(ltrim(@Homologo)) 
                    and  AraFecIn
a_fc <= @Hoy 
                    and  AraFecTea_fc >= @Hoy 
                  union 
                  Select  AraCodNom_ta, AraCodPre_ta, AraCodIte_ta, AraCodReg_ta, AraCodExt_cr, AraCopFij_nn, 
                        AraModVal_ta, AraValAra_nn 
      
            From   prestacion..Arancel 
                  where  AraCodPre_ta =  @CodPrestacion 
                    and  AraCodIte_ta =  @Item 
                    and  AraCodReg_ta =  @CodReg 
                    and  AraCodNom_ta =  @ValorNomina 
     
               and  AraCodExt_cr =  rtrim(ltrim(@Homologo)) 
                    and  AraFecIna_fc <= @Hoy 
                    and  AraFecTea_fc is Null 
 
                   Select @TotalFilas = @@rowcount 
 
                 end 
 
                if @
TotalFilas != 1 
                 begin 
                   if @TotalFilas = 0 
                    update #PrestacionValorizada 
                       set Error      = 101002 --// Mﬂs de un Arancel para la prestacion... 
                    where  Indic
e = @Indice 
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
                         @ValAra   = A
raValAra_nn 
                  From   #Arancel 
 
                  /* 
                  Select "convenio..Sel_VPValorizar", 
                        @RutCon, @FolCon, @CorRen,   @CorDir, @CodEsp, @CodPrestacion, @Item,   @Homologo, @TipReg, 
           
             @ValorNomina,   @ValAra, @ModVal, @RutTra, @Hoy 
                  */ 
 
                  exec @ErrorExec = convenio..Sel_VPValorizar @RutCon, @FolCon, @CorRen,   @CorDir, 
                                                              @CodEs
p, 
                                                              @CodPrestacion, @Item,   @Homologo, @TipReg, 
                                                              @ValorNomina,   @ValAra, @ModVal, @RutTra, @Hoy, 
                               
                               @ValorDesde  output, 
                                                              @ValorHasta  output, 
                                                              @ValorNomina output, 
                                  
                            @Modalidad   output, 
                                                              @CostoCero   output, 
                                                              @CopagoFijo  output 
                  if @ErrorExec != 0 

                   begin --// Error de Valorizacion 
                    update #PrestacionValorizada 
                       set Error  = @ErrorCode 
                    where  Indice = @Indice 
                      and  Error  = 0 
                   e
nd 
                  else 
                   begin --// Valorizacion EXITOSA 
 
                   --// La PRestacion se encuentra bien convenida a nivel de 
                   --// prestacion global. Ahora se debe determinar el precio 
                
   --// de la misma como HMQ, si corresponde. 
                     if (@ItemReal > 100 and @ItemReal < 1000) --// Es HMQ. 
                      begin 
 
                       exec @ErrorExec = convenio..Sel_VPEquipoMed_out @RutCon, @FolCon, @CorRen, @C
orDir, 
                                                                       @CodEsp, @CodPrestacion, @Homologo, 
                                                                       @TipReg, @ValorNomina, @ValorDesde, 
                               
                                        @ValorHasta, @Modalidad, @Hoy, @ItemReal, 
                                                                       @out_CodNom     output, 
                                                                       @out_
CodPrest   output, 
                                                                       @out_CodItem    output, 
                                                                       @out_CodReg     output, 
                                           
                            @out_CodHomo    output, 
                                                                       @out_Desde      output, 
                                                                       @out_Hasta      output, 
          
                                                             @out_Modalidad  output, 
                                                                       @out_CoPagoFijo output, 
                                                                       @o
ut_ErrorCode  output, 
                                                                       @out_Metodo     output 
 
                       if @ErrorExec != 0 
                        begin 
                         Select @ValorDesde  = 0, 
          
                      @ValorHasta  = 0, 
                                @ValorNomina = 0, 
                                @Modalidad   = '', 
                                @CopagoFijo  = 0 
 
                         update #PrestacionValorizada 
    
                        set ValorDesde = @ValorDesde, 
                                ValorHasta = @ValorHasta, 
                                Nomina     = @ValorNomina, 
                                Modalidad  = @Modalidad, 
                       
         CostoCero  = @CostoCero, 
                                CopagoFijo = @CopagoFijo, 
                                TipReg     = @TipReg, 
                                Homologo   = @Homologo, 
                                Error      = @Err
orExec 
                         where  Indice = @Indice 
                        end 
                       else 
                        begin --// Era un HMQ y Fue valorizado 
                         Select @ValorDesde  = @out_Desde, 
               
                 @ValorHasta  = @out_Hasta, 
                                @ValorNomina = @out_CodNom, 
                                @Modalidad   = @out_Modalidad, 
                                @CopagoFijo  = @out_CoPagoFijo 
                     
   end 
 
                      end 
 
                     update #PrestacionValorizada 
                        set ValorDesde = @ValorDesde, 
                            ValorHasta = @ValorHasta, 
                            Nomina     = @ValorNomina, 

                            Modalidad  = @Modalidad, 
                            CostoCero  = @CostoCero, 
                            CopagoFijo = @CopagoFijo, 
                            TipReg     = @TipReg, 
                            Homologo   =
 @Homologo 
                     where  Indice = @Indice 
                   end   --// FIN Valorizacion EXITOSA 
                end  --// FIN Arancel UNICO para la prestacion... 
 
               drop table #Arancel 
              end --// if @Modalidad
 = 'VA' 
 
            end --// FIN  Prestacion Principal o Un HMQ 
 
         end --// FIN @CodEsp is null or @CodEsp = 'XXX' 
        else 
         begin 
            update #PrestacionValorizada 
              set Error  = 400373 
            where  I
ndice = @Indice 
              and  Error  = 0 
 
           Select @extCodError = "N" 
           Select @extMensajeError = 'Una prestaciæn no convenida' -- "TRX DENEGADA (EI:400373)" 
           return 1 
         end 
 
        if (((Select Error From 
#PrestacionValorizada where Indice = @Indice) != 0)and 
            (@RecalculoRegimen = 'N')) 
         begin 
          Select @RecalculoRegimen = 'S' 
 
          update #PrestacionValorizada  --// Arancel No Encontrado... 
             set Error  = 0 

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
       Select @MinValor 
= @MinValor + 1 
       Select @Indice   = @MinValor 
      end 
   end  --// Iterador de valorizacion prestaciones while @MinValor <= @MaxValor 
 
 
  --// Esto indica que existe un Arancel de urgencia con recargo por % de 
  --// recargo en el convenio.
 
  if @AfectoRecargo = 'S' 
   begin 
     --// En Esta Iteraciæn se Buscarﬂ El Valor De Recargo Para cada prestacion. 
     select @MinValor = min(Indice) from #PrestacionValorizada 
     select @MaxValor = max(Indice) from #PrestacionValorizada 
     W
hile @MinValor <= @MaxValor 
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
       from   #PrestacionValorizada 
       where  Indice = @MinValor 
 
       Select @PorceRecargo = 0 
 
       Select @Porc
eRecargo = case PcvPorRec_nn 
                               when NULL then 0 
                               else PcvPorRec_nn 
                              end 
       From   convenio..PrestacionConvenio PC, 
              convenio..GrupoConvenio GC 
 
      Where  PcvFolCon_ta = @FolCon 
         and  PcvCorRen_ta = @CorRen 
         and  PcvCodPre_ta = @CodPrestacion 
         and  PcvCodIte_ta = @Item 
         and  PcvCorGrc_id = GcvCorGrc_id 
         and  GcvCorGrc_id = PcvCorGrc_id 
         and 
 GcvCorDir_ta = @CorDir 
         and  GcvCodEsp_ta = @CodEsp 
 
       if @PorceRecargo > 0 
        begin 
         update  #PrestacionValorizada 
            Set  ValorDesde = @ValorDesde * (1 + round((@PorceRecargo / 100),2)), 
                 ValorH
asta = @ValorHasta * (1 + round((@PorceRecargo / 100),2)) 
         from #PrestacionValorizada 
         where  Indice = @MinValor 
           and  AfectoRecargo = 'S' 
        end 
 
       Select @MinValor = @MinValor + 1 
      end 
   end --// if @Afe
ctoRecargo = 'S' 
 
 
 --// Obtencion de los Valores de una prestacion #PAQUETE. 
 create table #Composicion_Paquete 
 ( 
  Indice                int           not null, 
  CodPrestacion         prestacion    not null, 
  Item                  tinyint    
   not null, 
  TipoItem              char(2)           null, 
  AfectoRecargo         char(1)           null, 
  CantAte               tinyint       not null, 
  ModalCobertura        char(4)           null, 
  TipoCalculo           regla             nul
l, 
  GrupoCobertura        char(4)           null, 
  Especialidad          char(3)           null, 
  ValorDesde            numeric(14,4)     null, 
  ValorHasta            numeric(14,4)     null, 
  Nomina                smallint          null, 
  Moda
lidad             char(2)           null, 
  TipReg                tinyint           null, 
  Homologo              char(20)          null, 
  HomologoIMED          char(20)          null, 
  CostoCero             char(2)           null, 
  CopagoFijo int
                          null, 
  ValorPrestacion       numeric(12,0)     null, 
  AporteFinanciador     numeric(12,0)     null, 
  Copago                numeric(12,0)     null, 
  ValorRendicion        int               null, 
  Error                 in
t               null, 
  Iterar                int       default null null 
 ) 
 
 create table #Valida_Igualaos 
 ( 
  Indice                int           not null, 
  CodPrestacion         prestacion    not null, 
  Item                  tinyint       n
ot null, 
  CantAte               tinyint       not null, 
  Homologo              char(20)          null 
 ) 
 
 Select @NominaPaquete = ConCodNom_ta 
 from   convenio..Convenio 
 where  ConFolCon_id = @FolCon 
   and  ConCorRen_id = @CorRen 
 
/* 
 sele
ct CodPrestacion, Item, CantAte, Homologo, ct = count(*) 
 From   #PrestacionPaquete 
 group by CodPrestacion, Item, CantAte, Homologo 
*/ 
 while exists (select 1 from #PrestacionPaquete 
               where substring(Homologo,1,1) = 'P' and Iterar is n
ull) 
  begin 
   set rowcount 1 
 
   Select @MinValor = Indice, 
          @Cod_HomoPaquete = convert(char(20),Homologo), 
          @Cod_PresPaquete = CodPrestacion, 
          @Cod_ItemPaquete = Item, 
          @Can_PretPaquete = CantAte 
   From   #
PrestacionPaquete 
   where  substring(Homologo,1,1) = 'P' 
     and  Iterar is null 
 
   set rowcount 0 
 
   Insert #Valida_Igualaos 
   Select @MinValor, @Cod_PresPaquete, @Cod_ItemPaquete, @Can_PretPaquete, @Cod_HomoPaquete 
 
   --//Select @MinValor
, @Cod_HomoPaquete, convert(int,substring(@Cod_HomoPaquete,2,char_length(@Cod_HomoPaquete))) 
 
   Select @Cod_PaqueteHijo = NULL 
 
   --// Refierase al titulo : "Esquema Rigido de Tipos de Regimen para prestaciones." 
   Select @CodReg = 1 
   if @Afect
oRecargo = 'S' and @extUrgencia = 'S' Select @CodReg = 52, @BuscaPorcentaje = 1 
   if @AfectoRecargo = 'S' and @extUrgencia = 'N' Select @CodReg = 51, @BuscaPorcentaje = 1 
   if @AfectoRecargo = 'N' and @extUrgencia = 'S' Select @CodReg = 52, @BuscaPorc
entaje = 0 
   if @AfectoRecargo = 'N' and @extUrgencia = 'N' Select @CodReg =  1, @BuscaPorcentaje = 0 
 
   Select @Cod_Paquete     = PqaPaqPad_id, 
          @Cod_PaqueteHijo = PqaPaqHij_id 
   from   prestacion..PaqueteExterno, 
          prestacion..
PaqueteAsociado 
   where  PqeCodNom_id = @NominaPaquete 
     and  PqeCodPaq_id = convert(int,substring(@Cod_HomoPaquete,2,char_length(@Cod_HomoPaquete))) 
     and  PqeCodNom_id = PqaCodNom_id 
     and  PqeCodPaq_id = PqaPaqPad_id 
     and  PqaCodReg_
id = @CodReg 
 
   if @Cod_PaqueteHijo is NULL 
    begin 
     Select @CodReg = 1 
 
     Select @Cod_Paquete     = PqaPaqPad_id, 
            @Cod_PaqueteHijo = PqaPaqHij_id 
     from   prestacion..PaqueteExterno, 
            prestacion..PaqueteAsocia
do 
     where  PqeCodNom_id = @NominaPaquete 
       and  PqeCodPaq_id = convert(int,substring(@Cod_HomoPaquete,2,char_length(@Cod_HomoPaquete))) 
       and  PqeCodNom_id = PqaCodNom_id 
       and  PqeCodPaq_id = PqaPaqPad_id 
       and  PqaCodReg_id 
= @CodReg 
 
     if @@rowcount = 0 
      begin 
       Select @extCodError = 'N' 
       Select @extMensajeError = 'Pqte en mﬂs de 1 espec/no conv.' --TRX DENEGADA (EI:400378) 
       return 1 
      end 
 
    end 
 
   select @Porc_RecPqte = 0 
   if 
@BuscaPorcentaje = 1 
    begin 
 
     Select @Porc_RecPqte = CpqPorRec_nn, 
            @TotalFilas   = count(*) 
     from   convenio..PaquConv 
     where  CpqCorDir_id = @CorDir 
       and  CpqCodNom_id = @NominaPaquete 
       and  CpqCodPae_id = @
Cod_Paquete 
     group  by CpqPorRec_nn 
 
     if @TotalFilas <> 1 
      begin 
       Select @extCodError = 'N' 
       Select @extMensajeError = 'Existe mas de 1 paq. para Dir.Conv.' --TRX DENEGADA (EI:400378) 
       return 1 
      end 
 
    end 

 
   if @Cod_PaqueteHijo is not NULL 
    begin 
     insert #Composicion_Paquete 
     Select @MinValor, CpeCodPre_id, CpeCodIte_id, '  ', 'N', CpeCanCpe_nn, 
            NULL, NULL, NULL, NULL, 
            case @BuscaPorcentaje 
             when 1 the
n case 
                          when @Porc_RecPqte > 0 then round((CpeValDes_nn * (1 + round((@Porc_RecPqte / 100),2)))/CpeCanCpe_nn,0) 
                          else round(CpeValDes_nn/CpeCanCpe_nn,0) 
                         end 
             when 0
 then round(CpeValDes_nn/CpeCanCpe_nn,0) 
            end, 
            case @BuscaPorcentaje 
             when 1 then case 
                          when @Porc_RecPqte > 0 then round((CpeValHas_nn * (1 + round((@Porc_RecPqte / 100),2)))/CpeCanCpe_nn,0)
 
                          else round(CpeValHas_nn/CpeCanCpe_nn,0) 
                         end 
             when 0 then round(CpeValHas_nn/CpeCanCpe_nn,0) 
            end, 
            @NominaPaquete, CpeModVal_ta, 1, 
            CpeCodExt_cr, 
    
        @Cod_HomoPaquete, 
            'NO',null,null,null, null,null,0,null 
     from   prestacion..ComposicionPaqueteExt 
     where  CpeCodNom_id = @NominaPaquete 
       and  CpeCodPaq_id = @Cod_PaqueteHijo 
       and  CpeCodPre_id = @Cod_PresPaquet
e 
       and  CpeCodIte_id = @Cod_ItemPaquete 
       and  CpeCanCpe_nn = @Can_PretPaquete 
       and  CpeFecIni_fc <= @Hoy 
       and  (CpeFecTer_id >= @HoyMasUno or CpeFecTer_id is null) 
 
     if @@rowcount = 0 
      begin 
       Select @extCodEr
ror = 'N' 
       Select @extMensajeError = 'Paquete no disponible en la Base' --TRX DENEGADA (EO:400383) 
       return 1 
      end 
 
    end 
   else 
    begin 
     Select @extCodError = 'N' 
     Select @extMensajeError = 'No se encontræ un pqte. h
ijo' --TRX DENEGADA (EO:400369) 
     return 1 
    end 
 
   update #PrestacionPaquete 
      set Iterar = 1 
   where  substring(Homologo,1,1) = 'P' 
     and  Iterar is null 
     and  Homologo = @Cod_HomoPaquete 
     and  Indice = @MinValor 
 
  end 

 
 update #Composicion_Paquete 
    set ValorDesde = ValorDesde * @ValorUF, 
        ValorHasta = ValorHasta * @ValorUF 
 where  Modalidad = 'UF' 
 
 Select @TotalPrestPqte = count(*) from #Valida_Igualaos 
 
 Select @TotalPrestPqteMatch = count(*) 
 fro
m   #Valida_Igualaos I, 
        #Composicion_Paquete C 
 where  I.Indice = C.Indice 
   and  I.CodPrestacion = C.CodPrestacion 
   and  I.Item = C.Item 
   and  I.CantAte = C.CantAte 
   and  I.Homologo = C.HomologoIMED 
 
 if @TotalPrestPqte != @TotalPr
estPqteMatch 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'Validacion en Composicion del paquete.' --TRX DENEGADA (EO:400383) 
   return 1 
  end 
 
 insert #Composicion_Paquete 
 Select Indice, CodPrestacion, Item, TipoItem, Afect
oRecargo, CantAte, 
        ModalCobertura, TipoCalculo, GrupoCobertura, Especialidad, 
        ValorDesde, ValorHasta, Nomina, Modalidad, TipReg, Homologo, NULL, 
        CostoCero, CopagoFijo, ValorPrestacion, AporteFinanciador, 
        Copago, ValorRe
ndicion, Error, Iterar 
 from   #PrestacionValorizada 
 
 delete #PrestacionValorizada 
 
 insert #PrestacionValorizada 
 Select CodPrestacion,  Item,            TipoItem,          AfectoRecargo, 
        CantAte,        ModalCobertura,  TipoCalculo,     
  GrupoCobertura, 
        Especialidad,   ValorDesde,      ValorHasta,        Nomina, 
        Modalidad,      TipReg,          Homologo,          CostoCero, 
        CopagoFijo,     ValorPrestacion, AporteFinanciador, Copago, 
        ValorRendicion, Er
ror,           Iterar 
 from   #Composicion_Paquete 
 order by Indice 
 
 update #PrestacionValorizada 
      set Especialidad = EsvCodEsp_id 
 from   convenio..EspeServicioDirec 
       ,convenio..GrupoConvenio 
       ,convenio..PrestacionConvenio 
 whe
re EsvCorDir_id =  @CorDir 
   and  GcvCorDir_ta = EsvCorDir_id 
   and  GcvCodEsp_ta = EsvCodEsp_id 
   and  GcvCorGrc_id = PcvCorGrc_id 
   and  PcvCodPre_ta = CodPrestacion 
   and  PcvCodIte_ta = case when Item > 100 and Item < 1000 then 0 else Item e
nd 
 
 select @MinValor = min(Indice) from #PrestacionValorizada 
 select @MaxValor = max(Indice) from #PrestacionValorizada 
 
 While @MinValor <= @MaxValor 
  begin 
  Select @Indice = @MinValor 
 
   select @CodPrestacion = CodPrestacion, 
          @I
tem          = Item, 
          @TipoItem = TipoItem, 
          @AfectoRecargo = AfectoRecargo, 
          @CantAte       = CantAte, 
          @ValorDesde    = ValorDesde, 
          @ValorHasta    = ValorHasta, 
          @ValorNomina   = Nomina, 
    
      @Modalidad     = Modalidad, 
          @TipReg        = TipReg, 
          @Homologo      = Homologo, 
          @CostoCero     = CostoCero, 
          @CopagoFijo    = CopagoFijo 
   from   #PrestacionValorizada 
   where  Indice = @MinValor 
     
and  Error  = 0 
 
   select @GruCob = GcoCodGco_id 
   from   prestacion..SubPrestGrupCob 
          ,prestacion..CatGruCob 
          ,contrato..Cobertura 
   where  SpgCodPre_id = @CodPrestacion 
     and  SpgCodIte_id = @Item 
     and  GcoCodGco_id =
 SpgCodGco_id 
     and  CobCodPla_id = @extPlan 
     and  CobGruCob_id = GcoCodGco_id 
     and  GcoTipAte_re = 'AM' 
 
 
   update #PrestacionValorizada 
      set GrupoCobertura   = @GruCob 
   where  Indice = @Indice 
 
 
   Select @CodLoc = DatCodLo
c_ta 
   from   convenio..DireccionAtencion 
   where  DatCorDir_id = @CorDir 
 
   if (Select count(*) From #PlanesAlternativos) = 0 --// NO EXISTEN PLANES ALTERNATIVOS. 
    begin 
 
     select @GruCob = GcoCodGco_id 
     from   prestacion..SubPrestGr
upCob 
            ,prestacion..CatGruCob 
            ,contrato..Cobertura 
     where  SpgCodPre_id = @CodPrestacion 
       and  SpgCodIte_id = @Item 
       and  GcoCodGco_id = SpgCodGco_id 
       and  CobCodPla_id = @extPlan 
       and  CobGruCob_i
d = GcoCodGco_id 
       and  GcoTipAte_re = 'AM' 
 
     update #PrestacionValorizada 
        set GrupoCobertura   = @GruCob 
     where  Indice = @Indice 
 
     exec @ErrorExec = contrato..SerPyT_CoberturaConGuindasFIN @extPlan, @GruCob, 
            
                                                   @RutCon, 
                                                               @FolCon,  @CorRen, 
                                                               @CodLoc, 
                                      
                         @NroContrato, @Marca, 
                                                               'BO', 'XX', 
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
                                                               @CobNivPpo_nn    Out
put, 
                                                               @PlaModRef_re    Output, 
                                                               @PlaCobInt_nn    Output, 
                                                               @PlaTopB
ac_nn    Output, 
                                                               @PlaBasAcm_nn    Output, 
                                                               @PlaBonGan_fl    Output, 
                                                           
    @PlaPorFac_nn    Output, 
                                                               @GtaMaxBga_nn    Output, 
                                                               @BenEspAplicados Output, 
                                               
                @CobPerTop_fl    Output, 
                                                               @CobAmpGui_fl    Output, 
                                                               @CobPorTop_nn    Output, 
                                   
                            @CobFacEqi_nn    Output 
    end 
   else 
    begin --// Dado que hay un Plan Alternativo, Se Buscarﬂ el primero que 
          --// Devuelva distinto a 'LE'. 
     Select @CobModCob_id = 'LE' 
     While ((@CobModCob_id = 'LE
')and (exists (Select 1 From #PlanesAlternativos 
      where Iterar is null))) 
      begin 
       While exists (Select 1 From #PlanesAlternativos where Iterar is null) 
        begin 
         Select @extPlanAlternativo = PlaCodPla_id 
         From   
#PlanesAlternativos 
         where  Iterar is null 
 
         set rowcount 1 
 
         update #PlanesAlternativos 
            set Iterar = 1 
         where PlaCodPla_id = @extPlanAlternativo 
           and Iterar       is null 
 
         set rowco
unt 0 
 
         select @GruCob = GcoCodGco_id 
         from   prestacion..SubPrestGrupCob 
                ,prestacion..CatGruCob 
                ,contrato..Cobertura 
         where  SpgCodPre_id = @CodPrestacion 
           and  SpgCodIte_id = @Item
 
           and  GcoCodGco_id = SpgCodGco_id 
           and  CobCodPla_id = @extPlanAlternativo 
           and  CobGruCob_id = GcoCodGco_id 
           and  GcoTipAte_re = 'AM' 
 
         update #PrestacionValorizada 
            set GrupoCobertura   
= @GruCob 
         where  Indice = @Indice 
 
         Select @RenExe_fl = ConRenExe_fl 
         From   contrato..Contrato 
         Where  ConNumCto_id = @NroContrato 
           and  ConMarCon_id = @Marca 
 
         exec @ErrorExec = contrato..SerPyT
_CoberturaRedFIN @extPlanAlternativo, @GruCob, @RutCon, 
                                                            @FolCon,  @CorRen, 
                                                            @CodLoc, @Marca, 'BO', @RenExe_fl, @NroContrato, 
        
                                                    @REDCodPla_id    output, @REDModCob_id    output, 
                                                            @REDGruCob_id    output, @REDCodNom_ta    output, 
                                         
                   @REDPorBon_nn    output, @REDMonTop_nn    output, 
                                                            @REDModTop_re    output, @REDMonTopCon_nn output, 
                                                            @REDModTopCon_
re output, @REDRanCob_nn    output, 
                                                            @REDMonCop_nn    output, @REDModCop_re    output, 
                                                            @REDNivPpo_nn    output, @REDModRef_re    outpu
t, 
                                                            @REDCobInt_nn    output, @REDTopBac_nn    output, 
                                                            @REDBasAcm_nn    output, @REDBonGan_fl    output, 
                             
                               @REDPorFac_nn    output, @REDMaxBga_nn    output, 
                                                            @CobPerTop_fl    output, @CobAmpGui_fl    output, 
                                                            @C
obPorTop_nn    output, @CobFacEqi_nn    output 
 
         if @ErrorExec = 0 
          begin 
           exec @ErrorExec = contrato..SerPyT_CoberturaConGuindasFIN @extPlanAlternativo, 
                                                                     
@GruCob, 
                                                                     @RutCon, 
                                                                     @FolCon,  @CorRen, 
                                                                     @CodLoc,
 
                                                                     @NroContrato, @Marca, 
                                                                     'BO', 'XX', 
                                                                     @CobCodPla
_id    Output, @CobModCob_id    Output, 
                                                                     @CobGruCob_id    Output, @CobCodNom_ta    Output, 
                                                                     @CobPorBon_nn    Output, 
@CobMonTop_nn    Output, 
                                                                     @CobModTop_re    Output, @CobMonTopCon_nn Output, 
                                                                     @CobModTopCon_re Output, @CobRanCob_nn  
  Output, 
                                                                     @CobMonCop_nn    Output, @CobModCop_re    Output, 
                                                                     @CobNivPpo_nn    Output, @PlaModRef_re    Output, 
    
                                                                 @PlaCobInt_nn    Output, @PlaTopBac_nn    Output, 
                                                                     @PlaBasAcm_nn    Output, @PlaBonGan_fl    Output, 
                   
                                                  @PlaPorFac_nn    Output, @GtaMaxBga_nn    Output, 
                                                                     @BenEspAplicados Output, @CobPerTop_fl    Output, 
                                  
                                   @CobAmpGui_fl    Output, @CobPorTop_nn    Output, 
                                                                     @CobFacEqi_nn    Output 
 
          end 
 
         update #PlanesAlternativos 
            set Ite
rar = 1 
         where  PlaCodPla_id = @extPlanAlternativo 
           and Iterar       is null 
 
         if @CobModCob_id <> 'LE' 
          begin 
           set rowcount 0 
           update #PlanesAlternativos set Iterar = 1 
          end 
 
     
   end 
      end 
 
     if @CobModCob_id = 'LE' 
      begin 
 
       select @GruCob = GcoCodGco_id 
       from   prestacion..SubPrestGrupCob 
              ,prestacion..CatGruCob 
              ,contrato..Cobertura 
       where  SpgCodPre_id = @CodP
restacion 
         and  SpgCodIte_id = @Item 
         and  GcoCodGco_id = SpgCodGco_id 
         and  CobCodPla_id = @extPlan 
         and  CobGruCob_id = GcoCodGco_id 
         and  GcoTipAte_re = 'AM' 
 
       update #PrestacionValorizada 
         
 set GrupoCobertura   = @GruCob 
       where  Indice = @Indice 
 
       exec @ErrorExec = contrato..SerPyT_CoberturaConGuindasFIN @extPlan,     @GruCob, @RutCon, 
                                                                 @FolCon,      @CorRen, @C
odLoc, 
                                                                 @NroContrato, @Marca, 
                                                                 'BO',        'XX', 
                                                                 @CobCodPl
a_id    Output, @CobModCob_id    Output, 
                                                                 @CobGruCob_id    Output, @CobCodNom_ta    Output, 
                                                                 @CobPorBon_nn    Output, @CobMon
Top_nn    Output, 
                                                                 @CobModTop_re    Output, @CobMonTopCon_nn Output, 
                                                                 @CobModTopCon_re Output, @CobRanCob_nn    Output, 
    
                                                             @CobMonCop_nn    Output, @CobModCop_re    Output, 
                                                                 @CobNivPpo_nn    Output, @PlaModRef_re    Output, 
                           
                                      @PlaCobInt_nn    Output, @PlaTopBac_nn    Output, 
                                                                 @PlaBasAcm_nn    Output, @PlaBonGan_fl    Output, 
                                                  
               @PlaPorFac_nn    Output, @GtaMaxBga_nn    Output, 
                                                                 @BenEspAplicados Output, @CobPerTop_fl    Output, 
                                                                 @CobAmpG
ui_fl    Output, @CobPorTop_nn    Output, 
                                                                 @CobFacEqi_nn    Output 
 
      end 
    end   --// FIN PLANES ALTERNATIVOS... 
 
   if @ErrorExec = 0 
    begin --// Obtenciæn de Linea de Cober
tura Exitosa 
 
     Select @fec_ini_veg = ConIniPla_pe 
     from   contrato..Contrato 
     where  ConMarCon_id = @Marca 
       and  ConNumCto_id = @NroContrato 
       and  ConRutCot_id = @RutCte 
 
     Select @boni_pend = 0 
 
     Select @boni_pend
 = isnull(sum(AporteFinanciador),0) 
     from   #PrestacionValorizada 
     where  GrupoCobertura is not null 
       and  GrupoCobertura = @GruCob 
       and  Error = 0 
 
     Select @ErrorExec = 0, @cod_error = 0 
 
    Select @ValorDesde = convert(n
umeric(11,2),@ValorDesde) 
    Select @ValorHasta = convert(numeric(11,2),@ValorHasta) 
 
     exec @ErrorExec = prestacion..Calculo_Bonificacion @RutCte,          @NroContrato, 
                                                        @Marca,           @c
or_car, 
                                                        @Hoy,             @extPlan, 
                                                        @CodPrestacion,   @Item, 
                                                        @CantAte,         @Valo
rDesde, 
                                                        @ValorHasta,      @Modalidad, 
                                                        @CostoCero,       @CopagoFijo, 
                                                        100,           
  'N', 
                                                        @boni_pend,       @CobModCob_id, 
                                                        @CobGruCob_id,    @CobCodNom_ta, 
                                                        @CobPorBon_
nn,    @CobMonTop_nn, 
                                                        @CobModTop_re,    @CobMonCop_nn, 
                                                        @CobModCop_re,    @PlaModRef_re, 
                                                    
    @PlaBonGan_fl,    @GtaMaxBga_nn, 
                                                        @BenEspAplicados, @CobPerTop_fl, 
                                                        @CobAmpGui_fl,    @CobPorTop_nn, 
                                     
                   @CobFacEqi_nn, 
                                                        @por_boni       output, 
                                                        @mto_boni       output, 
                                                        @c
opago         output, 
                                                        @mto_presta     output, 
                                                        @operacion      output, 
                                                        @mensaje      
  output, 
                                                        @Cambia_Linea   output, 
                                                        @guindas        output, 
                                                        @CobPerOUT_fl   output, 
 
                                                       @CobAmpOUT_fl   output, 
                                                        @CobPorOUT_nn   output, 
                                                        @CobFacOUT_nn   output, 
             
                                           @ValAraCal_nn   output, 
                                                        @ModAraCal_cr   output, 
                                                        @MntoTopeCto    output, 
                         
                               @MntoTopeEve    output, 
                                                        @MntoTopeInt    output 
 
      if (@ErrorExec = 0) and ((@cod_error = 0)or(@cod_error is null)) 
       begin --// Bonificaciæn Exitosa 
 
   
    --//Determinaciæn si el Beneficiario es Socio de la Clinica Alemana. 
       --//Para Aplicar convenio con la institucion. 
       Select @EsSocioAlemana = 'N' --// NO ES SOCIO 
       Select @ValRendir = 0 
 
       if @Marca  = 'CB' 
        Begin 

         exec @DescSocAlemana = prestacion..EsSocioAlemana @RutCon, @RutBen, @CobModCob_id 
         if @DescSocAlemana <> 0 Select @EsSocioAlemana = 'S' --// ES SOCIO. 
        end 
 
       if @EsSocioAlemana = 'S' 
        begin 
         Select @mto_b
oniReal   = @mto_boni 
         Select @copagoReal     = @copago 
         Select @mto_prestaReal = @mto_presta 
 
         Select @DescEnPesos    = round(((@mto_prestaReal * @DescSocAlemana)/100),0) 
 
         Select @mto_presta     = @mto_prestaReal - 
@DescEnPesos 
         Select @ValRendir      = @mto_presta 
 
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
          set ModalCobertura    = @CobModCob_id, 
              TipoCalculo       = @operacion, 
              ValorPrestacion   = @mto_presta, 
              AporteFinanciador = @mto_boni, 
              Copago      
      = @copago, 
              ValorRendicion    = @ValRendir 
       where  Indice = @Indice 
 
      end   --// FIN Bonificaciæn Exitosa 
     else 
      begin --// Bonificaciæn Fallida 
       if @cod_error != 0 
        begin 
         update #Prest
acionValorizada 
            set Error      = @cod_error 
         where  Indice = @Indice 
        end 
      end 
    end --// FIN Obtenciæn de Linea de Cobertura Exitosa 
   else 
    begin --// Error en la Linea de Cobertura 
      update #PrestacionV
alorizada 
         set Error  = @ErrorExec 
      where  Indice = @Indice 
    end 
 
   update #PlanesAlternativos 
      set Iterar = NULL 
 
   Select @MinValor = @MinValor + 1 
 
  end 
 
 --// Control In necesario en las pruebas de CAPACITACION, per
o SI 
 --// en PRODUCCION. 
 if rtrim(ltrim(@db_name)) = 'prestacion' 
  begin 
   if exists (Select 1 
              From   #PrestacionValorizada 
              where  GrupoCobertura in ('24', '300', '301', '302', '303')) 
    begin 
     --// Control de
 Frecuencia en las consultas.... 
     --// 
     --// Denegar la valorizaciæn para cualquier carga que en las ultimas cuatro 
     --// semanas tenga mas de 6 bonos de consulta, emitidos en la surcursales 
     --// I-MED. Esto ultimo, para cualquier efe
cto es la sucursal 130600 
 
     exec @ErrorExec = prestacion..Sel_FrecPrestaciones @RutCte, @NroContrato, 
                                                        @Marca,  @cor_car, 
                                                        4,       2, 
 
                                                       @TotalPrest output 
     if @ErrorExec != 0 
      begin 
       Select @extCodError = 'N' 
       Select @extMensajeError = 'Consulta Frec. Prest.' 
       return 1 
      end 
 
        -- controlar
 el total de prestaciones en sesion + la historia -- FR-7787 
        Select @TotalPrest = @TotalPrest + count(*) 
          From #PrestacionValorizada 
         where GrupoCobertura in ('24', '300', '301', '302', '303') 
 
 
     if @TotalPrest > 6  -- M
odificado por FR-9155 
      begin 
       Select @extCodError = 'N' 
       --//Select @extMensajeError = 'EXCESO CONSULTA,ASISTIR ISAPRE' 
       Select @extMensajeError = 'EXCEDE CONSUL IMED IR A ISAPRE' 
       return 1 
      end 
    end 
  end --//
 FIN if rtrim(ltrim(@db_name)) = 'prestacion' 
 
 Select @extCodError = 'S' 
 Select @extMensajeError = '' 
 
 if exists(Select 1 from #PrestacionValorizada where Error > 0) 
  begin 
   Select @extCodError = 'N' 
 
   set rowcount 1 
 
   Select @extMens
ajeError = u&"PREST. NO OTORGAB. (N\2551 "+ 
                             ltrim(rtrim(convert(char(10),Indice)))+")" 
   from   #PrestacionValorizada 
   where  Error <> 0 
 
   set rowcount 0 
  end 
 
 --// Generacion de los registros de log de control.
 
 --// Esta obtencion de codigo queda obsoleta en el esquema de atributo identity. 
 
 Select @DigCon = substring(ltrim(rtrim(@extRutConvenio)),charindex('-',ltrim(rtrim(@extRutConvenio)))+1,1) 
 
 Select @DigBen = substring(ltrim(rtrim(@extRutBeneficiar
io)), 
                  charindex('-',ltrim(rtrim(@extRutBeneficiario)))+1,1) 
 
 Select @RutCot = convert(int,substring(ltrim(rtrim(@extRutCotizante)),1, 
                  charindex('-',ltrim(rtrim(@extRutCotizante)))-1)) 
 
 Select @DigCot = substring
(ltrim(rtrim(@extRutCotizante)), 
                  charindex('-',ltrim(rtrim(@extRutCotizante)))+1,1) 
 
 
 Select  extValorPrestacion   = convert(numeric(12,0),ValorPrestacion), 
         extAporteFinanciador = convert(numeric(12,0),AporteFinanciador), 

         extCopago            = convert(numeric(12,0),ValorPrestacion - AporteFinanciador), 
         extInternoIsa        = convert(char(15), 
                                replicate('0',3 - char_length(ltrim(rtrim(GrupoCobertura))))+ 
               
                 ltrim(rtrim(GrupoCobertura))+ 
 
                                ltrim(rtrim(ModalCobertura))+ 
                                replicate(' ',4 - char_length(ltrim(rtrim(ModalCobertura))))+ 
 
                                ltrim(rtrim(T
ipoCalculo))+ 
                                replicate(' ',2 - char_length(ltrim(rtrim(TipoCalculo))))+ 
 
                                replicate('0',6 - char_length(ltrim(rtrim(convert(char(6),ValorRendicion)))))+ 
                                lt
rim(rtrim(convert(char(6),ValorRendicion))) 
                                ) 
 From    #PrestacionValorizada 
 order by Indice 
 
/* 
 IF if rtrim(ltrim(@db_name)) = 'prestacion' 
  begin 
   --// Validacion de Prestaciones Duplicadas 
   create table #
duplicados 
   ( 
    CodPrestacion         prestacion    not null, 
    Item                  tinyint       not null, 
    total                 int               null 
    ) 
 
   insert #duplicados 
   Select CodPrestacion, Item, t = count(*) 
   from 
  #PrestacionValorizada 
   group by CodPrestacion, Item 
   having count(*) > 1 
 
   if @@rowcount > 0 
    begin 
     Select @extCodError = "N" 
     Select @extMensajeError = "Prestaciæn duplicada" 
     return 1 
    end 
 
   drop table #duplicados
 
  end 
*/ 
 
-- select * from #PrestacionValorizada 
 
 if (Select count(*) from #PrestacionValorizada) = 
    (Select count(*) from #PrestacionValorizada where Error = 0) 
  begin 
   Select @extCodError = 'S' 
   Select @extMensajeError = '' 
   retur
n 1 
  end 
 else 
  begin 
   Select @extCodError = 'N' 
 
   set rowcount 1 
   Select @extMensajeError = u&"PREST. NO OTORGAB. (N\2551 "+ 
                             ltrim(rtrim(convert(char(10),Indice)))+")" 
   from   #PrestacionValorizada 
   wher
e  Error <> 0 
 
   set rowcount 0 
   return 1 
  end 
end 
 
                                                                                                                                                                                                
(438 rows affected)
(return status = 0)
1> 