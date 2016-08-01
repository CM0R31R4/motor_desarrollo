locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
515
(1 row affected)
text

create procedure dbo.INGValorVari 
( 
 @extCodFinanciador     smallint, 
 @extHomNumeroConvenio  char(15), 
 @extHomLugarConvenio   char(10), 
 @extSucVenta           char(10), 
 @extRutConvenio        char(12), 
 @extRutTratante        char(12), 

 @extEspecialidad	char(10), -- FR-16877
 @extRutSolicitante     char(12), 
 @extRutBeneficiario    char(12), 
 @extTratamiento        char(1), 
 @extCodigoDiagnostico  char(10), 
 @extNivelConvenio      tinyint, 
 @extUrgencia           char(1), 
 @extLista1             char(255), 
 @extLista2             char(255), 
 @extLista3             char(255), 
 @extLista4             char(255), 
 @extLista5             char(255), 
 @extLista6             char(255), 
 @extLista7             char(255), -- FR 16877
 @extNumPrestaciones    tinyint, 
 @extCodError           char(1)    output, 
 @extMensajeError       char(30)   output, 
 @extPlan               char(15)   output,
 @extGlosa1		char(50)	  output,
 @extGlosa2		char(50)	  output, 
 @extGlosa3		char(50)	  output,
 @extGlosa4		char(50)	  output,
 @extGlosa5		char(50)	  output
) 
/* 
  -- ** ------------------------------------------------------------------------------------- 
   Creado por  : Marcelo Herrera 
   Creado el   : Marzo de 2010
 
  Referencia  : FR-1592. Proyecto Beneficios, SubProyecto Convenios
                 Nuevo modelo de convenios, se redireccionan los SP de valorizacion.
                 Se cambian reglas para identificar preferentes y determinar precio de prestacion.
  -- ** ------------------------------------------------------------------------------------- 
   Modificado por  : Marcelo Herrera 
   Modificado el   : Marzo de 2010
   Referencia  : FR-1726. Proyecto Beneficios, SubProyecto Convenios
                 Cambiar manejo de Colectivos, se debe seleccionar plan alternativo cuando este
                 registrado como preferente (y que se pueda activar opcion preferente).
                 Si no aplica preferente valorizar con plan del contrato.
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Mayo de 2010
  Autor        : MHV
  Empresa      : CruzBlanca
  Referencia   : FR 1871, incluir producto M70 A y B en la busqueda de productos adicionales
      		 en el caso de convenio Megasalud.
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Mayo de 2010
  Autor        : MHV
  Empresa      : CruzBlanca
  Referencia   : FR 1926, se incluye
 verificacion de vigencia para atributo BadTerAdi_fc cuando
                 el valor no es null.
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Julio de 2010
  Autor        : MHV
  Referencia   : FR 2353, Manejo de excepcion de especialidades para staff tratante
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Agosto de 2010
  Autor        : MHV
  Referencia   : FR 2393, Manejo de restriciones de modalidad de valorizacion para staff tratante.
                 Si tiene restriccion sin habilitar Libre Eleccion debe haber rechazo.
                 Si tiene restriccion y habilita Libre Eleccion (opcion forzada) debe forzarse 
	         la bonificacion por esta modalidad.                 
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Noviembre de 2010
  Autor        : MHV
  Referencia   : FR 3018. Verificacion de regla de copago fijo segun estructura despues de 
                 bonificar. Si copago es menor que el calculado por el plan de beneficios
                 se aplica valor de regla.
  -- ** --------------------------------------------------------------- ---------------------- 
  Fecha        : Enero de 2011
  Autor        : MHV
  Referencia   : FR 3205. En caso de ser convenio de Integramedica se determina modalidad de
                 valorizacion dental si beneficiario tiene contratado producto adicion al ID70
                 para posible uso si prestacion pertenece a la cobertura dental (492)
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Marzo de 2011
  Autor        : MHV
  Referencia   : FR 3558. Se incorpora verificacion de precio alternativo de medico. Al invocar
                 servicio de valorizacion de prestacion se informa rut de medico tratante.
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Marzo de 2011
  Autor        : MHV
  Referencia   : FR 3671. Para invocar servicio de copago fijo se modifica concepto verificado,
                 se reemplaza Lugar de Atencion por Convenio.
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Mayo de 2011
  Autor        : MHV
  Referencia   : FR 3907. Al verificar lista de planes alternativos para bonificacion se actualiza
                 servicio invocado para verificacioin de redes preferentes.
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Julio de 2011
  Autor        : MHV
  Referencia   : FR 4242. Se incorpora convenio en lista de control para copago fijo ambulatorio.
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Octubre de 2011
  Autor        : MHV
  Referencia   : FR 3978. Manejo de prestaciones GES.
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Diciembre de 2011
  Autor        : MHV
  Referencia   : FR 5036. Para modalidad dental se encapsula verificacion con nuevo servicio
                 convenio..ObtenerModValorizacionDental.
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Enero de 2012
  Autor        : MHV
  Referencia   : FR 5359. Control para Medicina Familiar sin cobertura, seteo de mensaje.
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Marzo de 2012
  Autor        : MHV
  Referencia   : FR 5484. Reemplazo de los servicios de cobertura y calculo de bonificacion, 
  		 adem�s incorporar servicio para verificar excepcion de copago fijo de convenio.
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Marzo de 2012
  Autor        : MHV
  Referencia   : FR 5710. Verificar para cada plan si opera con cobertura variable y en tal caso
                 solicitar cobertura con todos los datos requeridos.
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Junio de 2012
  Autor        : MHV
  Referencia   : FR 6189. Forzar error cuando para un plan referido a medicina familiar la cobertura
                 otorgada indique bonificacion 0.
  -- ** --------------------------------------------------------------- ---------------------- 
  Fecha        : Julio de 2012
  Autor        : MHV
  Referencia   : FR 6370. Forzar error cuando cobertura es 0 en medicina familiar debe excluir los 
                 siguientes grupos de cobertura 610 (Dental), 492 (Dental), 58 (Preventiva), 
                 600 (Preventiva), 106 (CAEC), 107 (CAEC) y 104 (GES).
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Julio de 2012
  Autor        : MHV
  Referencia   : FR 6396. Registrar Log cuando se detecte error o causal de rechazo para la solicitud.
  -- ** ------------------------------------------------------------------------------------- 
  Fecha        : Julio de 2012
  Autor        : MHV
  Referencia   : FR 7110. Marcar dentales (78) o si es MaxSalud (79) en campo extTipoBonoficacion1. 
                 Se informa en campo extTipoBonoficacion2 si es GES (77), es decir, cambio de posicion.
                 El orden de precedencia para informar es Dental y luego MaxSalud (78, 79 respectivamente),
                 si no corresponde a ninguna alternativa se sigue informando 0 (cero).
                 Se incorpora Rut de Clinica Santa Lucia para el control de MaxSalud.
                 Se deja de concatenar el monto a rendir por la limitacion de espacio a 6 caracteres en 
                 el campo extInternoIsa (para crear el bono posteriormente). 
  -- ** ------------------------------------------------------------------------------------- 
Referencia : FR-7841. Se incluye rut de SONORAD a la lista de prestadores que operan
             en modalidad de capita para medicina familiar.
             Si no estaba presenten ademas se incluye Rut de Clinica Santa Lucia por
             la misma condicion.
Fecha      : Marzo de 2013
Autor      : MHV
--**--------------------------------------------------------------------------------

   Parametros I 
       @extCodFinanciador     : Codigo del Financiador 
       @extHomNumeroConvenio  : Homologo numero de convenio (11c para Codigo+'-'+ 3c para corr renov) 
       @extHomLugarConvenio   : Homologo Lugar de convenio (Corr. Direccion) 
       @extSucVenta           : Homologo Sucursal de Venta (codigo Sucursal) 
       @extRutConvenio        : Rut Convenio, R.u.t. del prestador en convenio 
       @extRutTratante        : Rut Tratante, R.u.t. del m�dico tratante o solicitante de examenes. 
       @extRutSolicitante     : Rut Solicitante, R.u.t. de quien solicita el beneficio. 
       @extRutBeneficiario    : RUT del Beneficiario 

       @extTratamiento        : Tratamiento m�dico ('S','N') 
       @extCodigoDiagnostico  : Codigo de Diagnostico, seg�n CIE 10 
       @extNivelConvenio      : nivel convenido con el prestador 1,2,3 
       @extLista1             : lista de prestaciones 
                                10c para la Prestacion (7c Cod.Prestacion 3c para Item) 
                                1c pipe (|) 
                                1c para el tipo de item (H:Honorario, P:Pabellon) 
                                1cpipe (|) 
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
       @extLista6             : Idem Lista1, 
       @extNumPrestaciones    : N�mero de Prestaciones enviadas en este acto de ventas. 
 
   Parametros O 
       @extCodError           : Codigo de Error ('S','N') Corregir por 
				S = estador exitoso de la transaccion 
                                N = fallo o error en transaccion 
       @extMensajeError       : Mensaje de Error. 
       @extPlan               : Plan con el cual se Bonificar�. 
 
   ------------------------ 
   |Servicios para C-Salud | 
   ------------------------ 
 
 Descripcion 
 
   Este Servicio que env�a datos de todas las l�neas de prestaciones 
   al financiador; el que calcula cual es el valor de cada prestacion 
   y cuanto le corresponde al beneficiario 
 
 ejemplo de llamada:
declare 
 @extCodError    char(1), 
 @extMensajeError  char(30), 
 @extPlan          char(20),
 @extGlosa1 char(50),
 @extGlosa2 char(50), 
 @extGlosa3 char(50),
 @extGlosa4 char(50),
 @extGlosa5 char(50)


  exec prestacion..INGValorVari 78, '52119-0', '83825','130600', '76016305-8','0076016305-8', '', '0012259049-6','0013486200-9', 'N','XXXXXXXXXX',0,'N',
				'0405001000|  |0405001000     |N|01|000000000000|','','','','','','',1,@extCodError output, @extMensajeError output, @extPlan output,
				@extGlosa1 output, @extGlosa2 output,  @extGlosa3 output, @extGlosa4 output, @extGlosa5 output
 -- ** -----------------------------------------------------------------------------------------*/ 
As 
declare 
         @Hoy                   fecha, 
         @extFecTrx             fecha,
         @ErrorExec             int, 
         @extApellidoPat        char(30), 
         @extApellidoMat        char(30), 
         @extNombres       	char(40), 
         @extSexo               char(1) , 
         @extFechaNacimi        fecha, 
         @extCodEstBen          char(1) , 
         @extDescEstado         char(15), 
         @extRutCotizante       char(12), 
         @extNomCotizante  	char(40), 
         @extDirPaciente        char(40), 
         @extGloseComuna        char(30), 
         @extGloseCiudad        char(30), 
         @extPrevision          char(1), 
         @extGlosa              char(40), 
         @extDescuentoxPlanilla char(1) , 
         @extMontoExcedente     int, 
         @extRutAcompananate    char(12), 
         @extNombreAcompanante  char(40), 
         @ValorUF               numeric(10,2), 
         
	 @CodSucursal           sucursal, 
         @Marca   		marca, 
         @RutCon                rut, 
         @RutTra                rut, 
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
 
         @Cuenta_Lista          tinyint, 
         @Total_Listas          tinyint, 
 
         @extListaAUX           char(255), 
         @extListaX             char(255), 
         @MinValor              numeric(10,5), 
         @MaxValor              numeric(10,5), 
 
         @CodPrestacion         prestacion, 
         @varCadena             char(49), 
         @TipoItem              char(2), 
         @HomologoPrestador     char(20), 
         @AfectoRecargo         char(1), 
         @ValorDesde            numeric(14,4), 
         @ValorHasta            numeric(14,4), 
         @ValorPPV              numeric(14,4), --FR7573 valor informado por el punto de venta
         @Item   		tinyint, 
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
         @Combinatoria          char(50), 
         @Combinatoria2         char(50), 
         @Combinatoria3         char(50), 
         @CodPrest              prestacion, 
         @CodItem               tinyint, 
         @CodHomo               char(20), 
         @ModVal                regla, 
         @TipReg                tinyint, 
         @CopagoFijo 		int, 
         @ValAra                numeric(10,2), 
         @TotalFilas            int, 
         @NominaPaquete         smallint, 
         @out_CodNom            smallint, 
         @out_CodPrest          prestacion, 
         @out_CodItem		tinyint, 
         @out_CodReg            tinyint, 
         @out_CodHomo           char(20), 
         @out_Desde             numeric(14,4), 
         @out_Hasta             numeric(14,4), 
         @out_Modalidad         regla, 
         @out_CoPagoFijo        integer, 
         @out_ErrorCode         int, 
         @out_Metodo            char(2), 
 
         @PorceRecargo          numeric(7,4), 
         @Colectivo             int, 
         @GruCob                char(4), 
         @CodLoc 		localidad, 
         @CobCodPla_id          codpla, 
         @CobModCob_id          Char(4), 
         @CobGruCob_id          Char(4), 
         @CobCodNom_ta          Smallint, 
         @CobPorBon_nn          Numeric(5,2), 
         @CobMonTop_nn          Numeric(11,2), 
         @CobModTop_re          modal, 
         @CobMonTopCon_nn       Numeric(11,2), 
         @CobModTopCon_re       char(4), 
         @CobRanCob_nn          Numeric(11,2), 
         @CobMonCop_nn          Numeric(11,2), 
         @CobModCop_re          char(4), 
         @CobNivPpo_nn          Tinyint, 
         @PlaModRef_re          regla, 
         @PlaCobInt_nn          Numeric(11,2), 
         @PlaTopBac_nn          Numeric(11,2), 
         @PlaBasAcm_nn       	Numeric(11,2), 
         @PlaBonGan_fl          Char(1), 
         @PlaPorFac_nn          Tinyint, 
         @GtaMaxBga_nn          numeric(5,2), 
         @BenEspAplicados       char(250), 
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
         @RutCot                rut, 
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
         @REDGruCob_id          Char(4), 
         @REDCodNom_ta          Smallint, 

         @REDPorBon_nn          Numeric(5,2), 
         @REDMonTop_nn          Numeric(10,2), 
         @REDModTop_re          modal, 
         @REDMonTopCon_nn       Numeric(10,2), 
         @REDModTopCon_re       modal, 
         @REDRanCob_nn          Smallint, 
         @REDMonCop_nn          Numeric(10,2), 
         @REDModCop_re          modal, 
         @REDNivPpo_nn          Tinyint, 
         @REDModRef_re          regla, 
         @REDCobInt_nn          Numeric(11,2), 
         @REDTopBac_nn    	Smallint, 
         @REDBasAcm_nn          Smallint, 
         @REDBonGan_fl          Char(1), 
         @REDPorFac_nn          Tinyint, 
         @REDMaxBga_nn          Smallint, 
 
         @BuscaPorcentaje       bit, --// 0: NO Busque, 1: SI Busq ue 
         @Porc_RecPqte          numeric(7,4), 
         @Cod_Paquete           int, 
         @Cod_PaqueteHijo       int, 
         @Cod_HomoPaquete       char(15), 
         @DigMed_cr             dv, 
         @HoyMasUno             fecha, 
         @Ok                    flag, 
         @Cod_PresPaquete       prestacion, 
         @Cod_ItemPaquete       tinyint, 
         @Can_PretPaquete       tinyint, 
         @svr_name              char(30), 
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
         @MntoTopeCto     numeric(11,2), 
         @MntoTopeEve     numeric(11,2), 
         @MntoTopeInt     numeric(11,2), 
         @EdadCARGA       int, 
         @SexoCARGA       flag, 
         @CuentaPlanes    int, 
         @PreVigMin       int, 
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
         @Folio           int ,
         @MntRefPre       int ,      -- FR 33137, monto referencia prestacion 
         @vlcModCob       char(2),   -- FR 2393 modalidad de cobertura
         @vliAplRes       int,       --resultado de verificar si existe/aplica restriccion (1/0 corresponden a Si/No)
         @vliValPre       int,       --si se debe validar por prestacion (1/0 corresponde a Si/No)
         @vlcForCob       char(2),   --cobertura forzada
         @vliForMvaLE     int,       --modalidad libre eleccion forzada --FR 3018
         @vliRutConReal   rut,        --rut del convenio efectivo
         @vlcAplCop       char(1),    --flag(S/N) si aplica regla de copago fijo
         @vliMtoBon_GCP   int,        --nuevo monto de bonificacion (regla de copago fijo)
         @vliMtoCop_GCP   int         --nuevo monto de copago (regla de copago fijo)


 --para verifiacion de vigencia
 declare @vliStaPre int, @vliStaCon int, @vliStaLat int , @vliStaIme int
 -- para determinacion de modalidad de valorizacion
 declare @vlcTipMod  char(2), @vliFolMva  int, @vliFolMvaDental int, @vliFolMvaAux int, @vlcValSel char(20)
 --fr 1726 manejo de colectivos
 declare @vlcPlanColectivo codpla

 --nuevas variables para uso de GES
 declare @CanastaHom char(20), @CanastaGES char(20), @FolioGES int, @CadenaGES char(15), @CadenaGESControl char(15), @CadenaAux char(15),@CorRenCanasta int,
         @NumPatGES int, @CodEtaGES char(2), @PerUsoGES char(2), @vliFolMvaGes int
 declare @vlnDedGesAplicado numeric(8,2)
 declare @vlnGesAplIsapre numeric(8,2), @vlnGesValorUF numeric(10,2), @vldGesFecCob fecha, @vliCopCanasta int, 
         @vlnGesDedCta numeric(8,2), @vlnGesDedCaso numeric(8,2), @vlnGesCtaCto numeric(8,2), @vlnGesDedCto numeric(8,2)
         
 --FR-5484
 declare @vliExcepcionCF int, @vliTopePlan int, @ModTopeCto char(2), @ModTopeEve char(2), @ModTopeInt char(2), @MntoBonMinFon numeric(11,2)
 --FR-5710 verificacion de cobertura variable 
  declare @vliCobVar int, @vlcCobVar_Prestacion prestacion, @vldCobVar_Fecha fecha, @vliCobVar_Monto int
 ----------        
  declare @vlcAux char(255), @FlagLogError int, @GlosaLogError char(50)
 ----------
  declare @vliEsMaxSalud tinyint
  declare @ValPreIme char(1), @PrestacionPPV Numeric(14,4)
begin 
  Select @svr_name = @@servername
  set @extFecTrx = getdate()
  begin tran 
 
  update prestacion..ContadorFolio 
     set CfoNumFol_nn = CfoNumFol_nn - 1 
  where  CfoCodMar_id = 'IN' And  CfoTipDoc_fl = 'LECT' 
 
  Select @Folio = CfoNumFol_nn 
  From   prestacion..ContadorFolio 
  where  CfoCodMar_id = 'IN' and  CfoTipDoc_fl = 'LECT' 
 
  commit tran 
 
  begin tran uno 
 
   insert Log_EntradasCopTran (ext_NroTrX, ext_FechaHoraTRX, extCodFinanciador, extHomNumeroConvenio, extHomLugarConvenio, extSucVenta, extRutConvenio, extRutTratante, 			      extRutSolicitante, extRutBeneficiario, extTratamiento, extCodigoDiagnostico,extNivelConvenio, extUrgencia, extLista1, extLista2, 
			       extLista3, extLista4, extLista5,  extLista6, extNumPrestaciones) 
   values  (@Folio, @extFecTrx, @extCodFinanciador, @extHomNumeroConvenio, @extHomLugarConvenio, @extSucVenta, @extRutConvenio, @extRutTratante, 
            @extRutSolicitante, @extRutBeneficiario, @extTratamiento, @extCodigoDiagnostico, @extNivelConvenio, @extUrgencia, @extLista1, @extLista2, @extLista3, 
            @extLista4, @extLista5,  @extLista6, @extNumPrestaciones) 
 
   if @@error != 0 
    begin 
     rollback tran uno 
     Select @extCodError = 'N' 
     Select @extMensajeError = 'Error en grabacion de Log' --TRX DENEGADA (EI:400365) 
     --siempre registramos este error
     exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, 0, 0, 0, null, null, null, 400365, 'Error en grabacion de Log', null, null, null
     return 1 
    end 
 
  commit tran uno 
 
 create table #PrestacionValorizada 
 ( 
  Indice                numeric(10,0) identity, 
  CodPrestacion         prestacion    not null, 
  Item                  tinyint       not null, 
  PrestacionPPV         numeric(14,4)     null,
  TipoItem             char(2)           null, 
  AfectoRecargo         char(1)           null, 
  CantAte               tinyint       not null, 
  ModalCobertura        char(4)           null, 
  TipoCalculo           regla             null, 
  GrupoCobertura        char(4)  	null, 
  Especialidad          char(3)           null, 
  ValorDesde            numeric(14,4)     null, 
  ValorHasta            numeric(14,4)     null, 
  Nomina                smallint          null, 
  Modalidad             char(2)           null, 
  TipReg                tinyint           null, 
  Homologo              char(20)          null, 
  CostoCero             char(2)           null, 
  CopagoFijo            int               null, 
  ValorPrestacion       numeric(12,0)     null, 
  AporteFinanciador     numeric(12,0)     null, 
  Copago                numeric(12,0)     null, 
  ValorRendicion        int               null, 
  Error                 int               null, 
  Iterar                int       default null null 
 ) 
 
 Create Table #CanastasGES(
   CanastaHom char(20),
   CanastaGES char(20), 
   FolioGES int, 
   CorRenCanasta int,
   PerUsoGES char(2),
   ValorTotal numeric(11,0) null,
   BonificacionTotal numeric(11,0) null,
   CopagoTotal numeric(11,0) null
 )
 
 --se debe registrar errores/rechazos
 exec prestacion..RME_Sel_RegAdm 'RM', 7, 2, @vlcAux out
 if rtrim(@vlcAux) = 'SI' 
    set @FlagLogError = 1
 else 
    set @FlagLogError = 0
 
 --// Obtencion de la Fecha del Dia. FECHA DEL SERVIDOR SYBASE. 
 Select @Hoy = convert(smalldatetime,convert(char(10),getdate(),101)) 
 --// Obtencion del d�a de Ma�ana 
 Select @HoyMasUno = dateadd(dd,1,@Hoy) 
 
 --// VALOR DE LA U.F. de la fecha de atencion. 
  exec @ErrorExec = convenio..Fecha_UFIPC @Hoy, @ValorUF output 
 if @ErrorExec != 0 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'No se encontro valor de la UF' --TRX DENEGADA (EI:400366)' 
   if @FlagLogError = 1
       exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, 0, 0, 0, null, null, null, 400366, 'No se encontro valor de la UF', null, null, null
   return 1 
  end 
 
 --// Conversion del codigo sucursal ORDEN a formate CD-ING 
 Select @CodSucursal = convert(char(6),ltrim(rtrim(@extSucVenta))) 
 
 --//conversion del 
Rut del Prestador 
 Select @RutCon = convert(int,substring(ltrim(rtrim(@extRutConvenio)),1,charindex('-',ltrim(rtrim(@extRutConvenio)))-1)) 
 --//conversion del RUT del Beneficiario 
 Select @RutBen = convert(int,substring(ltrim(rtrim(@extRutBeneficiario)),1,charindex('-',ltrim(rtrim(@extRutBeneficiario)))-1)) 
 --// folio del convenio y correlativo de renovacion 
 Select @FolCon = convert(int,substring(ltrim(rtrim(@extHomNumeroConvenio)),1,charindex('-',ltrim(rtrim(@extHomNumeroConvenio)))-1)) 
 Select @CorRen = convert(tinyint,substring(@extHomNumeroConvenio,char_length(@extHomNumeroConvenio),1)) 
 --// Correlativo de direccion. 
 Select @CorDir = convert(int,ltrim(rtrim(@extHomLugarConvenio))) 

 Select top 1 @vliRutConReal = CprRutPre_ta from convenio..ConvenioPrestador 
 where CprFolCon_nn = @FolCon
 order by CprIdrCpr_id desc
 
 exec  @ErrorCode = prestacion..INGSelConMar @RutBen, @Hoy, @HoyMasUno,@Marca output, @NroContrato output, @Ok output 
 if @Ok = 'N' or @ErrorCode != 0 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'Fallo re-validacion del benef'--TRX DENEGADA (EI:400367)' 
   Select @FolCon = isNull(@FolCon, 0), @RutCon = isNull(@RutCon, 0), @CorDir = isNull(@CorDir, 0)
   if @FlagLogError = 1
      exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null , 400367, 'Fallo INGSel ConMar: re-validacion del benef', null, null, null
   return 1 
  end 
 
 --// Determinacion de la Marca en funcion del Prestador. 
 if @Marca = 'AS' Select @extCodFinanciador = 74 
 if @Marca = 'CB' Select @extCodFinanciador = 78 
 if @Marca = 'NM' Select @extCodFinanciador = 70
 
  --// Validadcion de la Certificacion del Beneficiario. Importante Rescatar el 
 --// Plan vigente del contrato. 
 exec @ErrorExec = INGBenCertif_out @extCodFinanciador, @extRutBeneficiario, @Hoy, @extApellidoPat output, @extApellidoMat output, @extNombres output, @extSexo output, @extFechaNacimi output, @extCodEstBen output, @extDescEstado output, @extRutCotizante output, @extNomCotizante output, @extDirPaciente output, @extGloseComuna output, @extGloseCiudad output, @extPrevision output, @extGlosa output, @extPlan output, @extDescuentoxPlanilla output, @extMontoExcedente output, @extRutAcompananate output, @extNombreAcompanante  output 
 
 if @ErrorExec != 0 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'Fallo re-validacion del benef' --TRX DENEGADA (EI:400367) 
   if @FlagLogError = 1
      exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null , 400367, 'Fallo INGBenCertif_out: re-validacion del benef', null, null, null
   return 1    
  end 
 
 if @extCodEstBen <> 'C' 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'Error al certificar al benef.' --TRX DENEGADA (EI:400368)' 
   if @FlagLogError = 1
      exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null , 400368, 'Error al certificar al benef.', null, null, null
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
 
 if @@rowcount > 1 
  begin 
   Select @extCodError = 'N' 
  
 Select @extMensajeError = 'Benef. en mas de un Cto.' 
   if @FlagLogError = 1
      exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null , 400368, 'Benef. en mas de un Cto.', null, null, null
   return 1 
  end 
 
 Select @EdadCARGA   = datediff(yy, BenFecNac_fc, @Hoy), 
        @SexoCARGA   = BenSex_fl, 
        @FecNac      = BenFecNac_fc, 
        @IniVig      = BenIniVig_fc 
 from   contrato..Beneficiario 
 where  BenRutCot_id = @RutCte 
   and  BenNumCto_id = @NroContrato 
   and  BenCorCar_id = @cor_car 
   and  BenMarCon_id = @Marca 
 
 if @@error != 0 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'Extraer datos del Benf.' 
   if @FlagLogError = 1
      exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null , 400368, @extMensajeError, null, null, null      
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
               contrato..Plan1 P where  T.TcoNumCol_id   = @Colectivo 
          and  Pt1.PtrNumCol_id = @Colectivo 
          and  Pt1.PtrCorTra_id = T.TcoICorTra_id 
          and  Pt1.PtrCodPla_id = @extPlan 
          and  Pt2.PtrCorTra_id = T.TcoICorTra_id 
       	  and  Pt2.PtrNumCol_id = @Colectivo 
          and  Pt2.PtrCodPla_id = PlaCodPla_id 
          and  Pt2.PtrTipPla_re = 'OP' 
          and  Pt2.PtrBloBen_re = 'SI' 
          
        select @vlcPlanColectivo = PlaCodPla_id
        from #PlanesAlternativos a
            ,convenio..ModalidadValorizacion m
            ,convenio..LugarAtencionValorizacion l
            ,convenio..ModValorizacionPlan p
        where m.MvaFolCon_nn = @FolCon
          and m.MvaVigDes_fc <= @Hoy
          and isNull(m.MvaVigHas_fc, @HoyMasUno) >= @Hoy
          and m.MvaCodMod_ta = 6     --  modalidades preferentes
          and l.LavFolMva_nn = m.MvaFolMva_nn
          and l.LavCorLat_nn = @CorDir
          and l.LavVigDes_fc <= @Hoy
          and isNull(l.LavVigHas_fc, @HoyMasUno) >= @Hoy 
          and p.MvpFolMva_nn = m.MvaFolMva_nn
          and p.MvpCodPla_ta = a.PlaCodPla_id
          and p.MvpVigDes_fc <= @Hoy
          and isNull(p.MvpVigHas_fc, @HoyMasUno) >= @Hoy
          
        set @extPlan = isNull(@vlcPlanColectivo, @extPlan)
 end
 
 exec convenio..CON_CertificaVigenciaConvenio @RutCon, @FolCon, @CorDir, @Hoy, @vliStaPre out, @vliStaCon out, @vliStaLat out , @vliStaIme out
 
 if (@vliStaPre = 0 or @vliStaCon = 0 or @vliStaLat = 0 or @vliStaIme = 0)
 begin 
    Select @extCodError = 'N' 
    if @vliStaPre = 0
       Select @extMensajeError = 'Prestador no vigente' --TRX DENEGADA (EI:400809) 
    else
        if @vliStaCon = 0
           Select @extMensajeError = 'Conv. no vigente o suspendido' 
--TRX DENEGADA (EI:400809) 
        else 
            if @vliStaLat = 0
               Select @extMensajeError = 'Direccion no vigente' --TRX DENEGADA (EI:400809) 
            else
               Select @extMensajeError = 'Venta no vigente/suspendida' --TRX DENEGADA (EI:400809) 
    if @FlagLogError = 1           
       exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null , 400809, @extMensajeError, @RutCte, @cor_car, @extPlan
    return 1 
 end 
 --
 ** -------------------------------------------------------- 
 -- FR-7787 - Control de Vta. IMED para CMF 
 -- Codigo de Modalidad (20) para NO restringir la Vta. IMED 
 -- en CMF a ciertos Convenios Medicos. 
 if (@extPlan <> '')and 
    (exists (Select 1 from   contrato..Plan1 
              where  PlaCodPla_id = @extPlan 
                and  PlaFamPla_ta = 'INMECA' )) and (not exists (select 1 from convenio..ModalConvenioPrestador
                 where McpFolCon_nn = @FolCon and McpCodMod_ta = 20
                   and McpVigDes_fc <= @Hoy
                   and isnull(McpVigHas_fc,@HoyMasUno) >= @Hoy)) 
 begin 
    Select @extCodError = 'N' 
    Select @extMensajeError = 'Vta. Elect. restrin. por Conv.' 
    Set @GlosaLogError = 'Vta. Elect. restringida por Convenio'
    if @FlagLogError = 1
      exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null , 100900, @GlosaLogError, @RutCte, @cor_car, @extPlan
    return 1 
 end 
 -- ** -------------------------------------------------------- 

 set @vlcTipMod = 'PR'
 exec convenio..CON_GetModalValorizacion @FolCon, @CorDir, @Hoy, @extPlan, @vlcTipMod output , @vliFolMva output
 
 exec convenio..ObtenerModValorizacionDental @FolCon, @CorDir, @RutBen, @Hoy, @vliFolMvaDental output

 set @vliEsMaxSalud = 0 
 if exists(Select 1 from contrato..Plan1 
           where PlaCodPla_id = @extPlan and (PlaFamPla_ta = 'CBMFAM' or PlaSubFam_ta = 'MFINTG' or PlaAgrFin_ta = 'PLMFIN') )
 set @vliEsMaxSalud = 1
    
 --// Decodificacion de las listas de prestaciones. 
 --//Descomposicion de las listas pasadas por parametro. 
 create table #Parametro_Listas ( id numeric(2,0) identity, Lista  char(255) ) 
 
 if char_length(rtrim(ltrim(@extLista1))) > 0 insert #Parametro_Listas values (@extLista1) 
 if char_length(rtrim(ltrim(@extLista2))) > 0 insert #Parametro_Listas values (@extLista2) 
 if char_length(rtrim(ltrim(@extLista3))) > 0 insert #Parametro_Listas values (@extLista3) 
 if char_length(rtrim(ltrim(@extLista4))) > 0 insert #Parametro_Listas values (@extLista4) 
 if char_length(rtrim(ltrim(@extLista5))) > 0 insert #Parametro_Listas values (@extLista5) 
 if char_length(rtrim(ltrim(@extLista6))) > 0 insert #Parametro_Listas values (@extLista6) 
 
 Select @Total_Listas = 0 
 
 Select @Total_Listas = count(*) from #Parametro_Listas 
 
 if @Total_Listas <= 0 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'No hay prestaciones a valorizar' --TRX DENEGADA (EO:400368
) 
   set @GlosaLogError = 'No hay prestaciones a valorizar en la TRX'
   if @FlagLogError = 1
      exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null , 400368, @GlosaLogError, @RutCte, @cor_car, @
extPlan
   return 1 
  end 
 
 --//Las listas traen prestaciones de la forma : Prest1|Prest2|Prest3|....|Prestn| 
 --//En esta tabla quedan los strings que corresponden a una unica prestacion. 
 create table #Cadenas 
 ( 
  Cadena    char(56) not null, --- FR-28369
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
       --- FR-28369
       if @MinValor = 6
       begin 
          insert #Cadenas values (@extListaX, NULL) 
          Select @extListaX = '' 
          Select @MinValor = 0 
       end 
       Select @MinValor = @MinValor + 1 
   
 end 
    
    Select @Cuenta_Lista = @Cuenta_Lista + 1 
 end 
 
 if (Select count(*) from #Cadenas) = 0 
 begin 
    --raiserror 900001 'No Se envio lista de prestaciones' 
    Select @extCodError = 'N' 
    Select @extMensajeError = 'No hay prestacionesa valorizar' --TRX DENEGADA (EO:400368) 
    set @GlosaLogError = 'No hay prestaciones a valorizar en la TRX'
    if @FlagLogError = 1
       exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null , 400368, @GlosaLogError, @RutCte, @cor_car, @extPlan
    return 1 
 end 
 
 --// No la voy a usar mas asi que la elimino. 
 drop table #Parametro_Listas 
 
 create table #PrestacionPaquete 
 ( 
  Indice                int           not null, 
  CodPrestacion		prestacion    not null, 
  Item                  tinyint       not null, 
  PrestacionPPV         numeric(14,4)     null,
  TipoItem              char(2)           null, 
  AfectoRecargo         char(1)           null, 
  CantAte               tinyint       not null, 
  ModalCobertura        char(4)           null, 
  TipoCalculo           regla             null, 
  GrupoCobertura        char(4)           null, 
  Especialidad          char(3)           null, 
  ValorDesde            numeric(14,4)     null, 
  ValorHasta            numeric(14,4)     null, 
  Nomina                smallint          null, 
  Modalidad             char(2)           null, 
  TipReg                tinyint           null, 
  Homologo              char(20)          null, 
  CostoCero             char(2)           null, 
  CopagoFijo 		int               null, 
  ValorPrestacion       numeric(12,0)     null, 
  AporteFinanciador     numeric(12,0)     null, 
  Copago                numeric(12,0)     null, 
  ValorRendicion        int               null, 
  Error                 int               null, 
  Iterar                int       default null null 
 ) 
 
 --//Las listas traen prestaciones de la forma : Prest1|Prest2|Prest3|....|Prestn| 
 --//seran decompuesta y dejadas en la tabla #PrestacionValorizada. 
 while exists(Select 1 from #Cadenas where Procesado is null) 
 begin 
 
   Select @CodPrestacion = NULL, @Item    = NULL, @TipoItem      = NULL, 
          @AfectoRecargo = NULL, @CantAte = NULL, @HomologoPrestador = NULL ,
          @GruCob = NULL, @ValorPPV = NULL
   select @CanastaHom = null, @CanastaGES = null, @FolioGES = null, @CadenaGES = null, @CadenaGESControl = null, @CadenaAux = null
   
   set rowcount 1 
 
   Select @varCadena = '' 
   Select @varCadena = Cadena from #Cadenas where Procesado is null 
   
   Select @CodPrestacion = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1) 
   Select @Item          = convert(tinyint,substring(@CodPrestacion,8,3)) 
   Select @CodPrestacion = substring(@CodPrestacion,1,7) 
   Select @varCadena = substring(@varCadena,charindex('|',rtrim(@varCadena))+1,char_length(@varCadena)) 
 
   if char_length(substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1)) = 0 
    Select @TipoItem      = NULL 
   else 
    Select @TipoItem     = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1) 
   Select @varCadena = substring(@varCadena,charindex('|',@varCadena)+1,char_length(@varCadena)) 
 
   Select @HomologoPrestador = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1) 
   Select @varCadena = substring(@varCadena,charindex('|',@varCadena)+1,char_length(@varCadena)) 
 
   if char_length(ltrim(rtrim(@HomologoPrestador))) <= 1 Select @HomologoPrestador = NULL 
  
   --nuevo manejo GES
   if left(@HomologoPrestador, 3) = '*G*'
   begin
      set @GruCob = '104'
      set @CadenaGESControl = @HomologoPrestador
      
      if (@CanastaHom is Null)
      begin
         set @CadenaGES = subString(@HomologoPrestador, 5, char_length(@HomologoPrestador))
         set @CadenaAux = subString(@CadenaGES, 1, charindex('-',ltrim(rtrim(@CadenaGES)))-1)
         --Patologia         
         set @CanastaHom = Ltrim(Rtrim(convert(char(15), convert(int, @CadenaAux))))
         
         set @CadenaGES = subString(@CadenaGES, charindex('-',@CadenaGES)+1, char_length(@CadenaGES))
         --Etapa
         set @CanastaHom = RTRim(RTrim(@CanastaHom)) + CASE left(@CadenaGES, 1)
               when '1' then 'D'
               when '2' then 'T'
               when '3' then 'S'
      else 'x' --no se encontrara
      end
       
  set @CadenaGES = subString(@CadenaGES, charindex('-',@CadenaGES)+1, char_length(@CadenaGES))
         --secuencia canasta
         set @CanastaHom = LTrim(RTrim(@CanastaHom)) + Ltrim(Rtrim(convert(char(15),convert(int,@CadenaGES)) ))

  select @FolioGES = FolioGES, @CanastaGES = CanastaGES, @CorRenCanasta = CorRenCanasta, @PerUsoGES = PerUsoGES
         from #CanastasGES
         where CanastaHom = @CanastaHom
         
         if @@rowcount = 0
         begin
           Select @FolioGES  = EcaNumEve_id ,@CanastaGES = GevCodCar_id
	        from prestacion..Evento_CAEC ,prestacion..ControlEstadoProceso 
                ,prestacion..GES_GrupoEvento
                ,prestacion..GES_GrupoProblema
           where EcaMarCon_ta = @Marca 
              and EcaRutCon_ta = @RutCte
              and EcaNumCto_ta = @NroContrato
              and EcaIteBen_ta = @cor_car --@IteBen 
              and EcaTipCob_re = 'GE'      -- GES 
              and EcaNumEve_id  > 50000
              and isNull(EcaFecAlt_fc, @HoyMasUno) >= @Hoy
              and GevFolEve_id = EcaNumEve_id 
              and GevFecIni_fc <= @Hoy
              and isNull(GevFecTer_fc, @HoyMasUno) >= @Hoy
              and GevCodCar_id = GprCodCar_id
              and GprCodIme_cr = @CanastaHom
            
            if @FolioGES is not Null
               /* obtener correlativo de renovacion de canasta  */
               Select @CorRenCanasta = AgrCorRen_id
               from prestacion..GES_ArancelGrupo
               where AgrCodCar_id = @CanastaGES
                 and AgrVigDes_fc <= @Hoy
                 and isNull(AgrVigHas_fc, @HoyMasUno) >= @Hoy 
            else
            begin
               Select @extCodError = 'N' 
     
          Select @extMensajeError = 'Fallo al determinar Folio GES'
               if @FlagLogError = 1
                  exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @HomologoPrestador 
, 100910, @extMensajeError, @RutCte, @cor_car, @extPlan
               return 1 
            end
            
                     
            if @CorRenCanasta is null
               Select @CorRenCanasta = max(AgrCorRen_id)
               from prestacion..GES_ArancelGrupo
               where AgrCodCar_id = @CanastaGES
            
            Select @NumPatGES = AgrNumPro_id
                  ,@CodEtaGES = AgrCodEta_id
                  ,@PerUsoGES = AgrPerUso_id
            from prestacion..GES_ArancelGrupo
            where AgrCodCar_id = @CanastaGES
              and AgrCorRen_id = @CorRenCanasta
            
            if @@rowcount = 0
            begin
               Select @extCodError = 'N' 
               Select @extMensajeError = 'Fallo al determinar Canasta GES'
               if @FlagLogError = 1
                  exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @HomologoPrestador , 100911, @extMensajeError, @RutCte, @cor_car, @extPlan
               return 1 
            end
                        
            Insert into #CanastasGES(CanastaHom, CanastaGES, FolioGES, CorRenCanasta, PerUsoGES)
            Select @CanastaHom, @CanastaGES, @FolioGES, @CorRenCanasta, @PerUsoGES

         end
      end
      set @HomologoPrestador = @CanastaGES
   end
   
   Select @AfectoRecargo = substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1) 
   Select @varCadena = substring(@varCadena,charindex('|',ltrim(rtrim(@varCadena)))+1,char_length(@varCadena)) 
 
   if @AfectoRecargo is null Select @AfectoRecargo = 'N' 
   
   Select @CantAte       = convert(int,substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1)) 
   Select @varCadena = substring(@varCadena,charindex('|',ltrim(rtrim(@varCadena)))+1,char_length(@varCadena)) 
   
   Select @ValorPPV = convert(int,substring(@varCadena,1,charindex('|',ltrim(rtrim(@varCadena)))-1)) 
   
   Select @ValorDesde = NULL, @ValorHasta = NULL, @ValorNomina = NULL, 
          @CodEsp     = NULL, 
          @Modalidad = NULL,  @ErrorCode = 0 
 
   Select Top 1 @CodEsp = PesEspSer_id 
   from prestacion..PrestacionEspecialidad 
   where PesCodPre_id = @CodPrestacion
    and PesEstVig_re = 'VI'

   if @CodEsp is Null 
      Select @CodEsp = '   '
 
   insert #PrestacionValorizada 
   values (@CodPrestacion, @Item, @ValorPPV, @TipoItem, @AfectoRecargo, 
           @CantAte, NULL, NULL, @GruCob, @CodEsp, 
           @ValorDesde, 
           @ValorHasta, 
           @ValorNomina, @Modalidad, NULL,@HomologoPrestador, 
           NULL,NULL,NULL, NULL,NULL,NULL,@ErrorCode, NULL) 
 
   update #Cadenas 
      set Procesado = 1 
   where  Procesado is null 

   set rowcount 0  
   if @GruCob <> '104'  -- no es GES
   begin
      Select  @PreVigMin    = CapVigMin_nn, 
              @PreVigMax    = CapVigMax_nn, 
              @PreModVig    = CapUniVig_re, 
              @EdadMin      = CapEdaMin_nn, 
              @EdadMax      = CapEdaMax_nn, 
              @ModEda       = CapModEda_re 
    
  from    prestacion..CatalogoPrestacion 
      where   CapCodPre_id = @CodPrestacion 
            
      if @@rowcount = 0
      begin
         Set @extCodError = 'N' 
         Set @extMensajeError = 'Prestac NO existe en Catalogo' 
         if @FlagLogError = 1
            exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @HomologoPrestador , 400810, @extMensajeError, @RutCte, @cor_car, @extPlan
         return 1
      end
      --/// Control de Otorgamiento de Prestaciones por Sexo, Edad, IMED. 
      if not exists (Select 1 
                     from   prestacion..CatalogoPrestacion 
                     where  CapCodPre_id = @CodPrestacion 
                       and  CapResSex_re in ('T',@SexoCARGA)) 
      begin 
         Select @extCodError = 'N' 
         if @SexoCARGA = 'M' 
            Select @extMensajeError = 'Cod. no otorg. sexo masculino' --(EO:400811)'//No Otorgable Masculino 
         else 
            Select @extMensajeError = 'Cod. no otorg. sexo femenino' --(EO:400812) //No Otorgable Femenino 
            if @FlagLogError = 1
               exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @HomologoPrestador ,
 400811, @extMensajeError, @RutCte, @cor_car, @extPlan
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
    
     Select @extMensajeError = 'Cod. no otorg. Benef esta edad' --(EO:400813)' --//No Otorgable Edad 
         set @GlosaLogError = 'Prestacion no otorg. por edad de Beneficiario'
         if @FlagLogError = 1
            exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @HomologoPrestador , 400813, @GlosaLogError, @RutCte, @cor_car, @extPlan
         return 1 
      end 
      
      if exists (Select 1 from   prestacion..CatalogoPrestacion 

                 where  CapCodPre_id = @CodPrestacion 
                   and  CapVtaIme_re = 'NO') 
      begin 
         Select @extCodError = 'N' 
         Select @extMensajeError = 'Cod. no otorg. Benef por I-med' --(EO:400814)' --//No Otorgable IMED
 
         set @GlosaLogError = 'Prestacion no habilatada para venta I-Med. Catalogo'
         if @FlagLogError = 1
            exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @HomologoPres
tador , 400814, @GlosaLogError, @RutCte, @cor_car, @extPlan
         return 1 
      end 
      --///  Vigencia Minima de Otorgamiento 
      Select @TmpoVig = case @PreModVig 
                          when 'YY' then convert(int, datediff(mm,@IniVig,@Hoy) / 12) 
                          when 'QQ' then datediff(qq,@IniVig, @Hoy) 
                          when 'MM' then datediff(mm,@IniVig, @Hoy) 
                          when 'WK' then datediff(wk,@IniVig, @Hoy) 
                          when 'DD' then datediff(dd,@IniVig, @Hoy) 
                        end 
      
      Select @ResVig = 'S' 
      Select @ResVig = 'N' 
      where  @PreVigMin <= @TmpoVig 
        and  @PreVigMax >= @TmpoVig 
      
      if (@ResVig = 'S') 
      begin 
         Select @extCodError = 'N' 
         Select @extMensajeError = 'No otorg por rango de vigencia.'--TRX DENEGADA (EO:400815)' --//No Otorgable Vigencia Valida 
         set @GlosaLogError = 'Prestacion No otorgable por rango de vigencia.'
         if @FlagLogError = 1
            exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @HomologoPrestador , 400815, @GlosaLogError, @RutCte, @cor_car, @extPlan
         return 1 
      end 
   end -- <> 104
 end --// fin del ciclo While para decodificar las prestaciones. 
    
 --// Control de Prestaciones Kin�sicas (06...) e Inmunoterapia (1707036). 
 --// Se requiere el siguiente Control: 
 --// No se pueden dar en un Acto de Venta mas de 3 prestaciones distintas del 
 --// grupo 06 (FNS) acompa�adas de solo una prestacion de evaluacion (0601001) 
 --// y la cantidad para cada una de ellas debe ser '1' 
 --// En el caso de la inmunoterapia la cantidad debe ser '1'. 
 
 Select distinct CodPrestacion, Item, CantAte, cont = count(*) into #ControlKinesEInmunoT 
 From   #PrestacionValorizada ,prestacion..CatalogoPrestacion 
 where  CapCodGru_ta = 6 
   and  CapCodSug_ta = 1 
   and  CapEstVig_re = 'VI' 
   and  CapCodPre_id = CodPrestacion 
 group by CodPrestacion, Item, CantAte 
 
-- Control general de Prest. KINE en cantidad = 1 
 if exists (Select 1 From #ControlKinesEInmunoT where CantAte <> 1) 
 begin 
    Select @extCodError = 'N' 
    Select @extMensajeError = 'Prest. kines en cant. mayor a 1' -- TRX DENEGADA (EO:400803) 
    set @GlosaLogError = 'Prestacion kinesica en cantidad mayor a 1'
    if @FlagLogError = 1
       exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @HomologoPrestador , 400803, @GlosaLogError, @RutCte, @cor_car, @extPlan
    return 1 
 end 

 -- ** ------------------------------------------------------- 
 
 if exists (select 1 from   #ControlKinesEInmunoT where  cont > 1) 
 begin 
     Select @extCodError = 'N' 
     Select @extMensajeError = 'Prest m�s de 1 vez en la venta' --TRX DENEGADA (EO:400806) 
     set @GlosaLogError = 'Prestacion mas de 1 vez en la venta'
     if @FlagLogError = 1
        exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @HomologoPrestador , 400806, @GlosaLogError, @RutCte, @cor_car, @extPlan
     return 1 
 end 

 -- ** --------------------------------------------------------------- 
 -- FR-9155 
 -- La prestacion 0601029 solo se puede emitir con la prestacion 0601001, o por si sola. 
 if (exists (Select 1 From #ControlKinesEInmunoT where CodPrestacion = '0601029'))    	-- validar si existe la prestacion 
 begin 
    if (exists (select 1 from #ControlKinesEInmunoT having count(*)=2))                      -- Validar mas de una prestacion 
       if (not exists (Select 1 From #ControlKinesEInmunoT where CodPrestacion = '0601001')) -- validar si la proxima prestacion debe ser la 0601001 
       begin 
          Select @extCodError = 'N' 
          Select @extMensajeError = 'prest. NO evaluativa.' 
          if @FlagLogError = 1
             exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @HomologoPrestad
or , 100930, @extMensajeError, @RutCte, @cor_car, @extPlan
          return 1 
       end 
    if (exists (select 1 from #ControlKinesEInmunoT  having count(*)>2 ))                   -- Validar mas de una prestacion 
    begin 
       Select @extCodError = 'N' 
       Select @extMensajeError = 'prest. NO evaluativa.' 
       if @FlagLogError = 1
          exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @HomologoPrestador , 100931, @extMensa
jeError, @RutCte, @cor_car, @extPlan
       return 1 
    end 
 end 
 -- ** ---------------------------------------------------------------- 
 -- FR-9155 
 -- Las prestaciones <0601017,0601030> solo se pueden emitir con la prestacion 0601001 con las siguientes convinatorias 
 -- 0601030 		-- por si sola 
 -- 0601017 		-- por si sola 
 -- 0601017 		con 0601001 
 -- 0601030 		con 0601001 
 -- 0601017,0601030 	con 0601001 
 -- 0601030,0601017     -- por si sola 
 if  (exists (Select 1 From #ControlKinesEInmunoT where CodPrestacion = '0601017')) and 
      (exists (Select 1 From #ControlKinesEInmunoT  where CodPrestacion = '0601030'))   -- validar si existe la prestacion 
 begin 
    if (exists (select 1 from #ControlKinesEInmunoT  having count(*)= 3 ))      
        -- Validar mas de una prestacion 
       if not (exists (Select 1 From #ControlKinesEInmunoT  where CodPrestacion = '0601001'))  -- validar si la proxima prestacion debe ser la 0601001 
       begin 
            Select @extCodError = 'N' 
        
    Select @extMensajeError = 'prest. NO evaluativa.' 
            if @FlagLogError = 1
               exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @HomologoPrestador , 100932, @extMensa
jeError, @RutCte, @cor_car, @extPlan
            return 1 
       end 
 end 
 --  ** ----------------------------------------------------------------------- 
 delete #ControlKinesEInmunoT where  CodPrestacion = '0601001' 

 --  ** ----------------------------------------------------------------------- 
 if exists (Select 1 From   #PrestacionValorizada 
            where  CodPrestacion = '1707036' 
              and  CantAte <> 1) 
 begin 
    Select @extCodError = 'N' 
    Select @extMensajeError = '1707036 en cant. mayor a 1' --TRX DENEGADA (EI:400805) 
    set @GlosaLogError = '1707036 en cantidad mayor a 1'
    if @FlagLogError = 1
       exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @HomologoPrestador , 400805, @GlosaLogError, @RutCte, @cor_car, @extPlan
    return 1 
 end 
 --// FIN Control de Prestaciones Kin�sicas (06...) e Inmunoterapia (1707036). 
 
 -- ** ---------------------------------------------------------------- 
 -- FR-9155 
 -- Control sobre prestaciones de Examenes de Laboratorio. 
 Select distinct CodPrestacion, Item, CantAte, cont = count(*) into #ControlExamenesLab 
 From #PrestacionValorizada ,prestacion..CatalogoPrestacion 
 where CapCodGru_ta = 3 and CapEstVig_re = 'VI' 
   and CapCodPre_id = CodPrestacion 
 group by CodPrestacion, Item, CantAte 
  
 -- Excluir la vta. de prestaciones que estan creadas para dar complitud de codigos de prestaciones 
 -- Ejemplo :  Si se esta vendiendo el codigo 0302075, no podemos generar una venta admas de las 
 -- siguientes prestaciones junto con el codigo antes mencionado. 
 -- 0302005,0302012,0302015,0302030,0302040,0302042,0302047,0302057,0302060,0302059,0302076,0302067. 
 
 if (exists (Select 1 From #ControlExamenesLab where CodPrestacion = '0302075'))     -- validar si existe la prestacion - Perfil Bioquimico 
    if (exists (select 1 from #ControlExamenesLab having count(*) > 1 ))             -- Validar mas de una prestacion 
       if (exists (Select 1
 From #ControlExamenesLab 
            where CodPrestacion in ('0302005','0302012','0302015','0302030','0302040','0302042','0302047', '0302057','0302060','0302063','0302067')))							-- validar si las proxima prestaciones NO pueden ser.... 
          begin 
             Select @extCodError = 'N' 
             Select @extMensajeError = 'Prestacion ya incluida en 0302075.' 
             if @FlagLogError = 1
                exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 100934, @extMensajeError, @RutCte, @cor_car, @extPlan
             return 1 
          end 
 if (exists (Select 1 From #ControlExamenesLab where CodPrestacion = '0302076'))      -- validar si existe la prestacion - Perfil hepatico 
    if (exists (select 1 from #ControlExamenesLab having count(*) > 1 ))              -- Validar mas de una prestacion 
       if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion in ('0301059','0302013','0302040','0302045','0302063'))) -- validar si las proxima prestaciones NO pueden ser.... 
          begin 
              Select @extCodError = 'N' 
              Select @extMensajeError = 'Prestacion ya incluida en 0302076' 
              if @FlagLogError = 1
                 exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 100934, @extMensajeError, @RutCte, @cor_car, @extPlan
              return 1 
          end 
 if (exists (Select 1 From #ControlExamenesLab  where CodPrestacion = '0309022'))     -- validar si existe la prestacion - Orina Completa 
    if (exists (select 1 from #ControlExamenesLab  having count(*) > 1 ))    
        -- Validar mas de una prestacion 
       if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion in ('0309024','0309023'))) -- validar si las proxima prestaciones NO pueden ser....  begin 
       
      Select @extCodError = 'N' 
             Select @extMensajeError = 'Prestacion ya incluida en 0309022' 
             if @FlagLogError = 1
                exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 100934, @extMensajeError, @RutCte, @cor_car, @extPlan
             return 1 
          end 
 if (exists (Select 1 From #ControlExamenesLab  where CodPrestacion = '0306011'))      -- validar si existe la prestacion - Oricultivo 
    if (exists
 (select 1 from #ControlExamenesLab  having count(*) > 1 ))              -- Validar mas de una prestacion 
       if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion in ('0307015','0306026') 
          ))							-- validar si las proxima prestaciones NO pueden ser.... 
          begin 
              Select @extCodError = 'N' 
              Select @extMensajeError = 'Prestacion(es) ya incluida(s) en el codigo 0306011, Urocultivo.' 
              Set @GlosaLogError = 'Prestacion(es) ya incluida(s) en el codigo 0306011, Urocultivo.' 
              if @FlagLogError = 1
                 exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 100934, @GlosaLogError, @RutCte, @cor_car
, @extPlan
              return 1 
          end 
 if (exists (Select 1 From #ControlExamenesLab  where CodPrestacion = '0308044'))       -- validar si existe la prestacion - Oricultivo 
    if (exists (select 1 from #ControlExamenesLab  having count(*) > 1 ))               -- Validar mas de una prestacion 
       if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion in ('0306004','0306005','0306008','0306017','0306026') 
          ))							-- validar si las proxima prestaciones NO pueden ser.... 
          begin 
             Select @extCodError = 'N' 
             Select @extMensajeError = 'Prestacion ya incluida en 0308044' 
             if @FlagLogError = 1
                exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 100934, @extMensajeError, @RutCte, @cor_car, @extPlan
             return 1 
          end 
 if (exists (Select 1 From #ControlExamenesLab  where CodPrestacion = '0301045')) -- validar si existe la prestacion - Hemograma 
    if (exists (select 1 from #ControlExamenesLab  having count(*) > 1 ))         -- Validar mas de una prestacion 
       if (exists (Select 1 From #ControlExamenesLab 
            where CodPrestacion in ('0301086','0301036','030103
8','0301065','0301064','0301069') 
          ))							-- validar si las proxima prestaciones NO pueden ser.... 
          begin 
             Select @extCodError = 'N' 
             Select @extMensajeError = 'Prestacion ya incluida en 0301045' 
          
   if @FlagLogError = 1
                exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 100934, @extMensajeError, @RutCte, @cor_car, @extPlan
             return 1 
          end 
 if (exists (Select 1 From #ControlExamenesLab where CodPrestacion = '0302034'))   -- validar si existe la prestacion - Oricultivo 
    if (exists (select 1 from #ControlExamenesLab having count(*) > 1 ))           -- Validar mas de una prestacion 
       if (exists (S
elect 1 From #ControlExamenesLab 
            where CodPrestacion in ('0302067','0302068','0302064') 
          ))							-- validar si las proxima prestaciones NO pueden ser.... 
          begin 
              Select @extCodError = 'N' 
              Sele
ct @extMensajeError = 'Prestacion ya incluida en 0302034' 
              if @FlagLogError = 1
                 exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 100934, @extMensajeError, @RutCte, 
@cor_car, @extPlan
              return 1 
          end 
 -- ** ---------------------------------------------------------------- 
 --// Para que el procedimiento siga el mismo flujo probado y hasta la fecha OK. 
 --// se separaran las prestaciones normales de las de tipo paquete. Estas ultimas 
 --// se trataran en un ciclo aparte. y cercano al final de este codigo. 
 
 insert #PrestacionPaquete 
 Select Indice, CodPrestacion, Item, PrestacionPPV, TipoItem, AfectoRecargo, CantAte, ModalCobertura ,  TipoCalculo,  GrupoCobertura,  Especialidad, 
        ValorDesde, ValorHasta, Nomina, Modalidad, TipReg, Homologo, CostoCero, CopagoFijo, ValorPrestacion, AporteFinanciador, Copago, 
        ValorRendicion, Error, Iterar 
 from   #PrestacionVa lorizada 
 where  substring(Homologo,1,1) = 'P' and char_length(LTrim(RTrim(Homologo))) = 15 
 
 delete #PrestacionValorizada 
 where  substring(Homologo,1,1) = 'P' and char_length(LTrim(RTrim(Homologo))) = 15 
 
 --// NOTAR QUE: #PrestacionValorizada mantiene las prestaciones normales. 
 --//            #PrestacionPaquete    mantiene las prestaciones incluidas en 
 --//            un paquete de prestaciones. 
 
 --// En este punto tengo todas las prestaciones requeridas. 
 --// para valorizarlas debemos recorrer la tabla #PrestacionValorizada 
 --// actualizando los datos faltantes a medida que se van obteniendo. 
 if exists(select 1 from #PrestacionValorizada where GrupoCobertura = '104')
 begin
      set @vlcTipMod = 'GE'
      exec convenio..CON_GetModalValorizacion @FolCon, @CorDir, @Hoy, @extPlan, @vlcTipMod output , @vliFolMvaGes output
      
      if isNull(@vlcTipMod, 'LE') <> 'GE'
      begin
         Select @extCodError = 'N' 
         Select @extMensajeError = 'No hay modalidad GES'
         
         if @FlagLogError = 1
           exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 100912, @extMensajeError, @RutCte, @cor_car, @extPlan
           return 1 
      end
 end
   
 Select @RecalculoRegimen = 'N' 
 
 Select @MinValor = min(Indice) from #PrestacionValorizada 
 Select @MaxValor = max(Indice) from #PrestacionValorizada 
 Select @Indice   = @MinValor 
 Set @vlcModCob = 'XX' --indica que escoja la mejor cobertura
 set @GruCob = Null
 While @MinValor <= @MaxValor 
 begin 
     if exists (select 1 from #PrestacionValorizada where  Indice   = @Indice) 
     begin 
        Select @CodPrestacion = CodPrestacion, 
               @Item          = Item, 
               @TipoItem      = TipoItem, 
               @AfectoRecargo = AfectoRecargo, 
               @Homologo      = ltrim(rtrim(Homologo)), 
               @CantAte       = CantAte, 
               @CodEsp        = Especialidad,
               @GruCob        = GrupoCobertura,
               @PrestacionPPV = PrestacionPPV
        from   #PrestacionValorizada 
        where  Indice = @Indice 
 
        --//VALIDACION DE EXISTENCIA DEL MEDICO TRATANTE O SOLICITANTE. 
        --// 
        --//REGLA DE NEGOCIO: * Si no hay solicitante o tratante no importa. el bono soporta nulos. 
        --//                  * Tratante y Solicitante son mutuamente excluyentes. 
        --//                  * De Venir un tratante �ste debe estar asociado al prestador en convenio 
        --//  			de no ser asi, es causal de rechazo del servicio. 
        --//                  * De venir un Solicitante. �ste debe estar en la base de prestadores. sino lo ingreso 
        --//                    con datos basicos. Si no pudo ser ingresado. rechazo el servicio. 
        exec @ErrorExec = prestacion..INGCtrl_TratSol @Marca, @CodPrestacion, @AccionPresta output 
 
        if @ErrorExec != 0 
        begin 
           Select @extCodError = 'N' 
           Select @extMensajeError = 'Fallo ingreso trat./solicit.' --TRX DENEGADA (EI:400377) 
           set @GlosaLogError = 'Fallo registro de tratante/solicitante'
           if @FlagLogError = 1
              exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, 400377, @GlosaLogError, @RutCte, @cor_car, @extPlan
           return 1 
        end 
        
        if @AccionPresta not in ('PR','AM') 
        begin 
           if @AccionPresta = 'TR' 
           begin --// Tratante es Exigible 
              if not ((@extRutTratante = '0000000000-0')or(@extRutTratante is NULL)or(@extRutTratante = '')) 
              begin 
                 Select @RutTra = convert(int,substring(ltrim(rtrim(@extRutTratante)),1,charindex('-',ltrim(rtrim(@extRutTratante)))-1)) 
                 
                 if not exists (Select 1 from convenio..Staff 
                                where  StaCorLat_nn = @CorDir 
                                  and  StaRutSta_ta = @RutTra 
                          
        /*and  StaVigDes_fc <= @Hoy -- FR 6396 se posterga aplicacion de vigencia and  isNull(StaVigHas_fc, @HoyMasUno) >= @Hoy */  )
                  begin 
                     Select @extCodError = 'N' 
              
       Select @extMensajeError = 'Trat. no relacionado con Prest.' --TRX DENEGADA (EO:400371)
                     set @GlosaLogError = 'Tratante no relacionado con Prestador'
                     if @FlagLogError = 1
                        exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, 400371, @GlosaLogError, @RutCte, @cor_car, @extPlan 
                     return 1 
                  end 
              end 
              else 
                  Select @RutTra = @RutCon 
           end --// Tratante es Exigible 
           
           if @AccionPresta = 'SO' 
           begin  --// Solicitante es Exigible 
              if not ((@extRutSolicitante = '0000000000-0')or(@extRutSolicitante is NULL)or(@extRutSolicitante = '')) 
              begin 
                 Select @RutSol = convert(int,substring(ltrim(rtrim(@extRutSolicitante)),1,charindex('-',ltrim(rtrim(@extRutSolicitante)))-1)) 
                 Select @DigMed_cr = substring(ltrim(rtrim(@extRutSolicitante)),charindex('-',ltrim(rtrim(@extRutSolicitante)))+1,1) 
                 
                 Select @RutTra = @RutSol 
                 
                 --// Control de TRatante distinto al Prestador en convenio 
      
           --// Solicitado Por Contralor de la Isapre. 
                 if @RutTra = @RutCon 
                 begin 
                    Select @extCodError = 'N' 
                    Select @extMensajeError = 'Trat./Solic. no existe.' --TRX DENEGADA (EI:400380) 
                    set @GlosaLogError = 'Tratante/Solicitante no es informado'
                    if @FlagLogError = 1
                       exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, 400380, @GlosaLogError, @RutCte, @cor_car, @extPlan
                    return 1 
                 end --// 
                 /*
                 if not exists(Select 1 from convenio..Prestador where PreRutPre_id = @RutTra) 
     
            begin 
                     exec @ErrorCode = convenio..InsertPrestador @RutSol,@DigMed_cr,'MEDICO ING x CSALUD00', null, 
                                                                 null, 'ME', NULL, NULL, 'NA', 'NA',NULL,NULL,NULL,NULL,NULL,NULL, 
                                                                 @Hoy, @CodSucursal, 'CSALUD00', 'PI' 
                     if @ErrorCode !=  0 
                     begin 
    
                    Select @extCodError = 'N' 
                        Select @extMensajeError = 'Fallo ingreso de Prestador' --TRX DENEGADA (EO:400372) 
                        if @FlagLogError = 1
                           exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, 400372, @extMensajeError, @RutCte, @cor_car, @extPlan
                        return 1 
                     end 
                 end 
                 */
   
           end 
              else 
              begin 
                 if @RutTra is null 
                    Select @RutTra = @RutCon 
              end 
           end --// Solicitante es Exigible 
        end --// if @AccionPresta not in ('PR','AM'
) 
        else 
        begin 
           Select @RutTra = NULL 
           if not ((@extRutTratante = '0000000000-0')or(@extRutTratante is NULL)or(@extRutTratante = '')) 
              Select @RutTra = convert(int,substring(ltrim(rtrim(@extRutTratante)),1,charindex('-',ltrim(rtrim(@extRutTratante)))-1)) 
           
           Select @RutSol = NULL 
           if not ((@extRutSolicitante = '0000000000-0')or(@extRutSolicitante is NULL)or(@extRutSolicitante = '')) 
              Select @RutSol = convert(int,substring(ltrim(rtrim(@extRutSolicitante)),1,charindex('-',ltrim(rtrim(@extRutSolicitante)))-1)) 
           
           if @RutTra is null Select @RutTra = @RutSol 
           if @RutSol is null Select @RutTra = @RutCon 
           if not exists(Select 1 from convenio..Prestador where PreRutPre_id = @RutTra) 
           begin 
              Select @extCodError = 'N' 
              Select @extMensajeError = 'Trat. / Solic. No Registrado' --TRX DENEGADA (EO:400380)
              set @GlosaLogError = 'Tratante/Solicitante No Registrado como Prestador'
              if @FlagLogError = 1
                 exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, 400380, @GlosaLogError, @RutCte, @cor_car, @extPlan 
              return 1 
           end 
        end 
        --FR 2393
        if ((@RutTra <> @RutCon) and @GruCob is Null)
        Begin
            exec convenio..CON_CheckStaffRestModValoriza @CorDir, @RutTra, @vliFolMva, @Hoy,@vliAplRes out, @vliValPre out, @vlcForCob out, @vliForMvaLE out
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
                  

                  Select @extCodError = 'N' 
                  Select @extMensajeError = 'Convenio Restringida a Doc.' -- 'TRX DENEGADA (EI:400373)' 
                  set @GlosaLogError = 'Restriccion de Profesional por Modalidad'
                  if @FlagLogError = 1
                     exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, 400373, @GlosaLogError, @RutCte, @cor_car, @extPlan
                     return 1 
  		  end
            end
         End
        --fin FR 2393
        
        --// SI EL HOMOLOGO RECIBIDO ES IGUAL AL CODIGO PRESTACION, 
        --// se esta indicando que existe un arancel unico para esa prestacion, y por ello 
        --// el homologo recibido no debe ser utilizado en la busqueda del arancel. 
        if rtrim(ltrim(@CodPrestacion)) + convert(char(3),replicate('0',3 - char_length(ltrim(rtrim(convert(char(3),@Item)))))+ ltrim(rtrim(convert(char(3),@Item)))) = rtrim(ltrim(@Homologo)) 
        begin 
           Select @Homologo = NULL 
        end 
        
        Select @ItemReal = @Item 
        Select @Item     = 0 
 
        --// Esquema Rigido de Tipos de Regimen para prestaciones. 
        --// ----------------------------------------------------- 
        --// 
        --// De definen como base los siguientes tipos de regimen. 
        --// Regimen  1 : Regimen basico, siempre debe existir en el Arance l. 
        --// Regimen 51 : Regimen que diferencia un Arancel para Horario Inhabil 
        --// Regimen 52 : Regimen que diferencia un Arancel para Urgencias. 
        --// 
        --// De esta manera se compone el siguiente algoritmo: 
        --// 
        --// Inhabil        Urgencia 
        --// N              N          => Reg =  1 
        --// S              N          => Reg = 51 
        --// N              S          => Reg = 52 
        --// S              S          => Reg = 52 multiplicado por % de Recargo H.Inhabil. Sino 
        --//                              existe Reg = 52 entonces Reg = 1 multiplicado por % de 
        --//                              Recargo H.Inhabil, del convenio de la prestacion. 
        --// 
        --// De agregarse otro tipo de regimen convenios debera informarnoslo y 
        --// se debera analizar el impacto sobre esta rutina. 
        Select @CodReg = 1 
        if @RecalculoRegimen = 'N' 
        begin 
           if @AfectoRecargo = 'N' and @extUrgencia = 'N' Select @CodReg =  1 
           if @AfectoRecargo = 'S' and @extUrgencia = 'N' Select @CodReg = 51 
           if @AfectoRecargo = 'N' and @extUrgencia = 'S' Select @CodReg = 52 
           if @AfectoRecargo = 'S' and @extUrgencia = 'S' Select @CodReg = 52 
        end 
        --inicio FR 2353
        if (@RutTra <> @RutCon and LTrim(RTrim(@CodEsp)) is not null and @GruCob is Null)
        begin
           set @ErrorExec = 0
           exec @ErrorExec = convenio..CON_CheckExcepcionMedicoEspec @CorDir, @RutTra, @CodPrestacion, @CodEsp, @Hoy
           if @ErrorExec <> 0
              set @CodEsp = 'XXX'
        end
        --fin FR2353

        set @ValPreIme = 'N'                 --FR-7573
        if @CodEsp <> 'XXX'                  --FR 2353     (1=1 or (@CodEsp is not null and @CodEsp <> 'XXX' ))
        begin --// INICIO 
           set @vliFolMvaAux = @vliFolMva
           if (@vliFolMvaDental is not null and @GruCob <> '104')
           begin
              if exists(select 1 from prestacion..SubPrestGrupCob, prestacion..CatGruCob 
                        where  SpgCodPre_id = @CodPrestacion and  SpgCodIte_id = @ItemReal
                           and GcoCodGco_id = SpgCodGco_id   and  GcoTipAte_re = 'AM'
                           and GcoCodGco_id = '492')
                 set @vliFolMvaAux = @vliFolMvaDental
           end  
           if @GruCob = '104'
              set @vliFolMvaAux = @vliFolMvaGes
                                    
           exec @ErrorExec = convenio..CON_GetValorVariPrestacion @RutCon, @FolCon, @vliFolMvaAux, @CorDir, @CodEsp, @CodPrestacion, @ItemReal, @Hoy, @Homologo, @CodReg, @ValorNomina output,@CodPrest output, @CodItem output, @CodReg output, @CodHomo output, @ValorDesde  output, @ValorHasta  output, @Modalidad   output, @CopagoFijo  output, @CostoCero output, @PorceRecargo output, @ErrorCode output, @RutTra, @ValPreIme out
           
           if @ErrorCode not in (0, 99999) 
           begin 
               update #PrestacionValorizada 
               set ValorDesde = 0, ValorHasta = 0, 
                   Nomina     = @ValorNomina, 
                   Modalidad  = '' 
               where  Indice = @Indice 
               
               update #PrestacionValorizada 
               set Error      = @ErrorCode 
            
   where  Indice = @Indice 
                 and  Error  = 0 
                 
               set @GlosaLogError = case @ErrorCode
                                         when 101002 then 'Existe mas de un Monto de Arancel a usar'
                      			 when 101003 then 'Monto de Arancel no encontrado'
                                         when 80000  then 'Prestacion no habilitada para la venta'
                                         when 80001  then 'Prestacion no arancelada'
                                       	 when 80003  then 'Prestacion no convenida'
                                         when 80004  then 'Prestacion convenida multiples veces'
                                         when 88001  then 'Pabellon valorizado en UF'
                                      else
                                          'No se pudo valorizar prestacion'
                                      end
               if @FlagLogError = 1                       
                  exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, @ErrorCode, @GlosaLogError, @RutCte, @cor_car, @extPlan  
           end 
           else 
           begin      -- // No se detecto Error. 
                   --// Esto indica que existe un Arancel de urgencia con recargo por % de recargo en el convenio. 
              if @AfectoRecargo = 'S'
                 set @PorceRecargo = isNull(@PorceRecargo,0)
              else
                 set @PorceRecargo = 0
              if @ValPreIme = 'N'                 
                 update #PrestacionValorizada 
                 set CodPrestacion = @CodPrest, 
                     Item          = @CodItem, 
                     ValorDesde    = round(@ValorDesde * case when AfectoRecargo = 'S' then (1 + round((@PorceRecargo / 100),2)) else 1 end, 0), 
                     ValorHasta    = round(@ValorHasta * case when AfectoRecargo = 'S' then (1 + round((@PorceRecargo / 100),2)) else 1 end, 0), 
 		     Nomina        = @ValorNomina, 
                     Modalidad     = @Modalidad, 
                     TipReg        = @CodReg, 
                     Homologo      = @CodHomo, 
                     CopagoFijo    = @CopagoFijo, 
             	     CostoCero     = @CostoCero 
                 where  Indice = @Indice               
              else
              begin
                 update #PrestacionValorizada 
                 set CodPrestacion = @CodPrest, Item = @CodItem, 
                     ValorDesde    = case when isnull(PrestacionPPV, 0) = 0 then 0 else PrestacionPPV end, 
                     ValorHasta    = case when isnull(PrestacionPPV, 0) = 0 then 0 else PrestacionPPV end, 
       		     Nomina        = @ValorNomina, 
                     Modalidad     = @Modalidad, 
                     TipReg        = @CodReg, 
                     Homologo      = @CodHomo, 
                     CopagoFijo    = @CopagoFijo, 
		     CostoCero     = @CostoCero,
                     Error         = case when isnull(PrestacionPPV, 0) = 0 then 101009 else 0 end
                 where  Indice = @Indice    
                 
                 if (IsNull(@PrestacionPPV, 0) = 0)
             
        set @GlosaLogError = 'Precio Prestador No Informado'
                     exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, 101009, @GlosaLogError, @RutCte, @cor_car, @extPlan 
              end   
              if (@ErrorCode = 99999 and @FlagLogError = 1)
              begin
                 set @GlosaLogError = 'Se escalo en la busqueda de Arancel'
                 exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, @ErrorCode, @GlosaLogError, @RutCte, @cor_car, @extPlan 
              end
           end 
        end --// FIN @CodEsp is null or @CodEsp = 'XXX' 
        else 
        begin 
         
   update #PrestacionValorizada 
              set Error  = 400373 
            where  Indice = @Indice 
              and  Error  = 0 
 
           Select @extCodError = 'N' 
           Select @extMensajeError = 'Prestacion Restringida a Doc.' -- 'TRX DENEGADA (EI:400373)' 
           set @GlosaLogError = 'Restriccion de profesional por Especialidad'
           if @FlagLogError = 1
              exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, 400373, @GlosaLogError, @RutCte, @cor_car, @extPlan
           return 1 
        end 
        
        if (((Select Error From #PrestacionValorizada where Indice = @Indice) != 0)and 
            (@RecalculoRegimen = 'N') and (@CodReg <> 1))

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
         --/ / probablemente, en la posicion ausente habia una prestacion, de tipo 
         --// item paquete (PQ). SE OMITE CICLO DE VALORIZACION. 
         Select @MinValor = @MinValor + 1 
         Select @Indice   = @MinValor 
     end 
  end  --// Iterador de valorizacion prestaciones while @MinValor <= @MaxValor 
 
  --// Obtencion de los Valores de una prestacion #PAQUETE. 
 create table #Composicion_Paquete 
 ( 
  Indice                int           not null, 
  CodPrestacion         prestacion    not null, 

  Item                  tinyint       not null, 
  PrestacionPPV         Numeric(14,4)     null,
  TipoItem              char(2)           null, 
  AfectoRecargo         char(1)           null, 
  CantAte               tinyint       not null, 
  ModalCobertura        char(4)           null, 
  TipoCalculo           regla             null, 
  GrupoCobertura        char(4)           null, 
  Especialidad          char(3)           null, 
  ValorDesde            numeric(14,4)     null, 
  ValorHasta         	numeric(14,4)     null, 
  Nomina                smallint          null, 
  Modalidad             char(2)           null, 
  TipReg                tinyint           null, 
  Homologo              char(20)          null, 
  HomologoIMED          char(20)          null, 
  CostoCero             char(2)           null, 
  CopagoFijo 		int               null, 
  ValorPrestacion       numeric(12,0)     null, 
  AporteFinanciador     numeric(12,0)     null, 
  Copago                numeric(12,0)     null, 
  ValorRendicion        int               null, 
  Error                 int               null, 
  Iterar                int       default null null 
 ) 
 
 create table #Valida_Igualaos 
 ( 
  Indice                int           not null, 
  CodPrestacion         prestacion    not null, 
  Item                  tinyint       not null, 
  CantAte               tinyint       not null, 
  Homologo              char(20)          null 
 ) 
 
 while exists (select 1 from #PrestacionPaquete where substring(Homologo,1,1) = 'P' and Iterar is null) 
 begin 
   set rowcount 1 
 
   Select @MinValor = Indice, 
          @Cod_HomoPaquete = convert(char(20),Homologo), 
          @Cod_PresPaquete = CodPrestacion, 
          @Cod_ItemPaquete = Item, 
          @Can_PretPaquete = CantAte 
   From   #PrestacionPaquete 
   where  substring(Homologo,1,1) = 'P' 
     and  Iterar is null 
 
   set rowcount 0 
 
   Insert #Valida_Igualaos 
   Select @MinValor, @Cod_PresPaquete, @Cod_ItemPaquete, @Can_PretPaquete, @Cod_HomoPaquete 
 
   --//Select @MinValor, @Cod_HomoPaquete, convert(int,substring(@Cod_HomoPaquete,2,char_length(@Cod_HomoPaquete))) 
 
   Select @Cod_PaqueteHijo = NULL 
 
   --// Refierase al titulo : 'Esquema Rigido de Tipos de Regimen para prestaciones.' 
   Select @CodReg = 1 
   if @AfectoRecargo = 'S' and @extUrgencia = 'S' Select @CodReg = 52, @BuscaPorcentaje = 1 
   if @AfectoRecargo = 'S' and @extUrgencia = 'N' Select @CodReg = 51, @BuscaPorcentaje = 1 
   if @AfectoRecargo = 'N' and @extUrgencia = 'S' Select @CodReg = 52, @BuscaPorcentaje = 0 
   if @AfectoRecargo = 'N' and @extUrgencia = 'N' Select @CodReg =  1, @BuscaPorcentaje = 0 
 
   Select @Cod_Paquete     = PqaPaqPad_id, 
          @Cod_PaqueteHijo = PqaPaqHij_id,
      	  @NominaPaquete   = PcoCodNom_ta,
          @Porc_RecPqte    = PcoPorRec_nn
   from   convenio..PaqueteConvenido,
          prestacion..PaqueteExterno, 
          prestacion..PaqueteAsociado 
   where  PcoCorLat_nn = @CorDir
     and  PcoFolMva_nn = @vliFolMva
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
       Select @extCodError = 'N' 
       Select @extMensajeError = 'Existe mas de 1 paq. para Dir.Conv.' --TRX DENEGADA (EI:400378) 
       set @GlosaLogError = 'Existe mas de un paquete a usar'
       if @FlagLogError = 1
          exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 400378, @GlosaLogError, @RutCte, @cor_car, @extPlan
       return 1 
   end
 
   if @Cod_PaqueteHijo is NULL 
   begin 
      Select @CodReg = 1 
 
      Select @Cod_Paquete     = PqaPaqPad_id, 
             @Cod_PaqueteHijo = PqaPaqHij_id,
             @NominaPaquete   = PcoCodNom_ta,
             @Porc_RecPqte    = PcoPorRec_nn
      from   convenio..PaqueteConvenido,
             prestacion..PaqueteExterno, 
             prestacion..PaqueteAsociado 
      where  PcoCorLat_nn = @CorDir
        and  PcoFolMva_nn = @vliFolMva
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
         Select @extCodError = 'N' 
         Select @extMensajeError = 'Existe mas de 1 paq. para Dir.Conv.' --TRX DENEGADA (EI:400378) 
         set @GlosaLogError = 'Existe mas de un paquete a usar'
         if @FlagLogError = 1
            exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 400378, @GlosaLogError, @RutCte, @cor_car, @extPlan
         return 1 
      end
      if @TotalFilas = 0 
      begin 
          Select @extCodError = 'N' 
          Select @extMensajeError = 'Pqte en m�s de 1 espec/no conv.' --TRX DENEGADA (EI:400378) 
          if @FlagLogError = 1
             exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 400378, @extMensajeError, @RutCte, @cor_car, @extPlan
          return 1 
      end 
   end 
 
   if @BuscaPorcentaje = 0
      select @Porc_RecPqte = 0 
 
   if @Cod_PaqueteHijo is not NULL 
   begin 
     insert #Composicion_Paquete 
     Select @MinValor, CpeCodPre_id, CpeCodIte_id, null, '  ', 'N', CpeCanCpe_nn, NULL, NULL, NULL, NULL, 
            case @BuscaPorcentaje 
             when 1 then case 
                          when @Porc_RecPqte > 0 then round((CpeValDes_nn * (1 + round((@Porc_RecPqte / 100),2)))/CpeCanCpe_nn,0) 
                          else round(CpeValDes_nn/CpeCanCpe_nn,0) 
                         end 
             when 0 then round(CpeValDes_nn/CpeCanCpe_nn,0) 
            end, 
            case @BuscaPorcentaje 
             when 1 then case 
                          when @Porc_RecPqte > 0 then round((CpeValHas_nn * (1 + round((@Porc_RecPqte / 100),2)))/CpeCanCpe_nn,0) 
                          else round(CpeValHas_nn/CpeCanCpe_nn,0) 
                         end 
             when 0 then round(CpeValHas_nn/CpeCanCpe_nn,0) 
            end, 
            @NominaPaquete, CpeModVal_ta, 1, CpeCodExt_cr, @Cod_HomoPaquete, 'NO',null,null,null, null,null,0,null 
     from   prestacion..ComposicionPaqueteExt 
     where  CpeCodNom_id = @NominaPaquete 
       and  CpeCodPaq_id = @Cod_PaqueteHijo 
       and  CpeCodPre_id = @Cod_PresPaquete 
       and  CpeCodIte_id = @Cod_ItemPaquete 
       and  CpeCanCpe_nn = @Can_PretPaquete 
  
     and  CpeFecIni_fc <= @Hoy 
       and  (CpeFecTer_id >= @HoyMasUno or CpeFecTer_id is null) 
 
     if @@rowcount = 0 
      begin 
       Select @extCodError = 'N' 
       Select @extMensajeError = 'Paquete no disponible en la Base' --TRX DENEGADA (EO:400383) 
       set @GlosaLogError = 'Paquete no disponible en la Base'
       if @FlagLogError = 1
          exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 400383, @GlosaLogError, @RutCte, @cor_car, @extPlan
       return 1 
      end 
 
    end 
   else 
    begin 
     Select @extCodError = 'N' 
     Select @extMensajeError = 'No se encontro un pqte. hijo' --TRX DENEGADA (EO:400369) 
     set @GlosaLogError = 'No se encontro un paquete hijo'
     if @FlagLogError = 1
        exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, 400369, @GlosaLogError, @RutCte, @cor_car, @extPlan
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
 from   #Valida_Igualaos I, 
        #Composicion_Paquete C 
 where  I.Indice = C.Indice 
   and  I.CodPrestacion = C.CodPrestacion 
   and  I.Item = C.Item 
   and  I.CantAte = C.CantAte 
   and  I.Homologo = C.HomologoIMED 
 
 if @TotalPrestPqte != @TotalPrestPqteMatch 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'Validacion en Composicion del paquete.' --TRX DENEGADA (EO:400383) 
   set @GlosaLogError = 'Error de validacion en composicion del paquete'
   if @FlagLogError = 1
      exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 400383, @GlosaLogError, @RutCte, @cor_car, @extPlan
   return 1 
  end 
 
 insert #Composicion_Paquete 
 Select Indice, CodPrestacion, Item, PrestacionPPV, TipoItem, AfectoRecargo, CantAte, ModalCobertura, TipoCalculo, GrupoCobertura, Especialidad, ValorDesde, ValorHasta, Nomina, Modalidad, TipReg, Homologo, NULL, CostoCero, CopagoFijo, ValorPrestacion, AporteFinanciador, Copago, ValorRendicion, Error, Iterar 
 from   #PrestacionValorizada 
 
 delete #PrestacionValorizada 
 
 insert #PrestacionValorizada 
 Select CodPrestacion,Item,PrestacionPPV,TipoItem,AfectoRecargo,CantAte, ModalCobertura, TipoCalculo, GrupoCobertura, Especialidad,ValorDesde,ValorHasta,Nomina, Modalidad,TipReg,Homologo,CostoCero, CopagoFijo,ValorPrestacion, AporteFinanciador, Copago, ValorRendicion, Error,Iterar 
 from  #Composicion_Paquete 
 order by Indice 
 
 select @MinValor = min(Indice) from #PrestacionValorizada 
 select @MaxValor = max(Indice) from #PrestacionValorizada 
  
 While @MinValor <= @MaxValor 
 begin 
   Select @Indice = @MinValor,
          @GruCob = null
   
   select @CodPrestacion = CodPrestacion, 
          @Item          = Item, 
          @TipoItem = TipoItem, 
          @AfectoRecargo = AfectoRecargo, 
          @CantAte       = CantAte, 
          @ValorDesde    = ValorDesde, 
          @Valor Hasta    = ValorHasta, 
          @ValorNomina   = Nomina, 
          @Modalidad     = Modalidad, 
          @TipReg        = TipReg, 
          @Homologo      = Homologo, 
          @CostoCero     = CostoCero, 
          @CopagoFijo    = CopagoFijo,
    	  @GruCob        = GrupoCobertura
   from   #PrestacionValorizada 
   where  Indice = @MinValor and  Error  = 0 
 
   if @CostoCero = 'SI'
      set @CostoCero = 'S'
   else
      set @CostoCero = 'N'
      
   -- FR 33137
   Set @MntRefPre = convert(int, @ValorDesde)
   set @mto_boni = 0
   set @copago = 0
    
    -- prestacion a tratar con GES 
   if @GruCob = '104'
   Begin
       Update #CanastasGES
       Set ValorTotal = isNull(ValorTotal, 0) + (@MntRefPre * @CantAte)
       where CanastaGES = @Homologo
   end    
   else
   begin
      select @GruCob = GcoCodGco_id 
      from   prestacion..SubPrestGrupCob ,prestacion..CatGruCob ,contrato..Cobertura 
      where  SpgCodPre_id = @CodPrestacion 
        and  SpgCo dIte_id = @Item 
        and  GcoCodGco_id = SpgCodGco_id 
        and  CobCodPla_id = @extPlan 
        and  CobGruCob_id = GcoCodGco_id 
        and  GcoTipAte_re = 'AM' 
        and  GcoCodGco_id <> '104'
      
      update #PrestacionValorizada 
    
  set GrupoCobertura   = @GruCob 
      where  Indice = @Indice 
   
      Select @CodLoc = LatCodLoc_ta 
      from convenio..LugarAtencion 
      where LatCorLat_nn = @CorDir 
        and LatVigDes_fc <= @Hoy
        and isNull(LatVigHas_fc, @HoyMasUno) >= @Hoy
      
      if (Select count(*) From #PlanesAlternativos) = 0 --// NO EXISTEN PLANES ALTERNATIVOS. 
      begin 
         if @vliCobVar is null
         begin
            exec prestacion..BON_CheckPlanCobVariable @extPlan, @Hoy, @vliCobVar out
 
        end
         if @vliCobVar = 1
         begin
            set @vlcCobVar_Prestacion = @CodPrestacion
            set @vldCobVar_Fecha      = @Hoy
            set @vliCobVar_Monto      = @MntRefPre
         end
         else
         begin
        
   	 set @vlcCobVar_Prestacion = null
            set @vldCobVar_Fecha      = null
            set @vliCobVar_Monto      = null
         end
         exec @ErrorExec = contrato..N_PL_SerPyT_Cobertura @extPlan, @NroContrato, @Marca, @RutCon, @FolCon, @CorDir, @CodLoc, 'BO', @vlcModCob, @GruCob, @vlcCobVar_Prestacion, @vldCobVar_Fecha, @vliCobVar_Monto, null, @CobCodPla_id Output, @CobModCob_id Output, @CobGruCob_id Output, @CobCodNom_ta Output, @CobPorBon_nn Output, @CobMonTop_nn Output, @Cob ModTop_re Output, @CobMonTopCon_nn Output, @CobModTopCon_re Output, @CobRanCob_nn Output, @CobMonCop_nn Output, @CobModCop_re Output, @CobNivPpo_nn Output, @PlaModRef_re Output, @PlaCobInt_nn Output, @PlaTopBac_nn Output, @PlaBasAcm_nn Output, @PlaBonGan_fl Output, @PlaPorFac_nn Output, @GtaMaxBga_nn Output, @BenEspAplicados Output, @CobPerTop_fl Output, @CobAmpGui_fl Output, @CobPorTop_nn Output, @CobFacEqi_nn Output
                                                               
      end 
      else 
      begin --// Dado que hay un Plan Alternativo, Se Buscar� el primero que
 
            --// Devuelva distinto a 'LE'. 
         Select @CobModCob_id = 'LE' 
         While ((@CobModCob_id = 'LE')and (exists (Select 1 From #PlanesAlternativos where Iterar is null))) 
         begin 
            While exists (Select 1 From #PlanesAlternativos where Iterar is null) 
            begin 
               Select @extPlanAlternativo = PlaCodPla_id 
               From   #PlanesAlternativos 
               where  Iterar is null 
               
               set rowcount 1 
            
               update #PlanesAlternativos 
               set Iterar = 1 
               where PlaCodPla_id = @extPlanAlternativo and Iterar is null 
               
               set rowcount 0 
              
 select @GruCob = GcoCodGco_id 
               from prestacion..SubPrestGrupCob ,prestacion..CatGruCob ,contrato..Cobertura 
               where  SpgCodPre_id = @CodPrestacion 
                 and  SpgCodIte_id = @Item 
                 and  GcoCodGco_id = SpgCodGco_id 
                 and  CobCodPla_id = @extPlanAlternativo 
                 and  CobGruCob_id = GcoCodGco_id 
                 and  GcoTipAte_re = 'AM' 
                 and  GcoCodGco_id <> '104'
 
                
               update #PrestacionValorizada 
               set GrupoCobertura = @GruCob 
               where  Indice = @Indice 
               
               Select @RenExe_fl = ConRenExe_fl 
               From   contrato..Contrato 
               Where  ConNumCto_id = @NroContrato 
                      and  ConMarCon_id = @Marca 
               
               exec @ErrorExec = contrato..N_PL_SerPyT_CoberturaRed @extPlanAlternativo, @GruCob, @RutCon, @FolCon,  @CorRen, @CodLoc, @Marca, 'BO', @RenExe_fl, @NroContrato, null, @CorDir, @REDCodPla_id output, @REDModCob_id output, @REDGruCob_id output, @REDCodNom_ta output, @REDPorBon_nn output, @REDMonTop_nn output, @REDModTop_re output, @REDMonTopCon_nn output, @REDModTopCon_re output, @REDRanCob_nn output, @REDMonCop_nn output, @REDModCop_re output, @REDNivPpo_nn output, @REDModRef_re output, @REDCobInt_nn output, @REDTopBac_nn output, @REDBasAcm_nn output, @REDBonGan_fl output, @REDPorFac_nn output, @REDMaxBga_nn output, @CobPerTop_fl output, @CobAmpGui_fl output, @CobPorTop_nn output, @CobFacEqi_nn output 
		if (@ErrorExec = 0 and @REDModCob_id is not null)
               begin 
                  exec prestacion..BON_CheckPlanCobVariable @extPlanAlternativo, @Hoy, @vliCobVar out
                  if @vliCobVar = 1
                  begin
                     set @vlcCobVar_Prestacion = @CodPrestacion
                     set @vldCobVar_Fecha      = @Hoy
                     set @vliCobVar_Monto      = @MntRefPre
                  end
                  else
                  begin
                     set @vlcCobVar_Prestacion = null
                     set @vldCobVar_Fecha      = null
                     set @vliCobVar_Monto      = null
                  end
                  exec @ErrorExec = contrato..N_PL_SerPyT_Cobertura @extPlanAlternativo, @NroContrato, @Marca, @RutCon, @FolCon, @CorDir, @CodLoc, 'BO', @vlcModCob, @GruCob, @vlcCobVar_Prestacion, @vldCobVar_Fecha, @vliCobVar_Monto, null, @CobCodPla_id Output, @CobModCob_id Output, @CobGruCob_id Output, @CobCodNom_ta Output, @CobPorBon_nn Output, @CobMonTop_nn Output, @CobModTop_re Output, @CobMonTopCon_nn Output, @CobModTopCon_re Output, @CobRanCob_nn Output, @CobMonCop_nn Output, @CobModCop_re Output, @CobNivPpo_nn Output, @PlaModRef_re Output, @PlaCobInt_nn Output, @PlaTopBac_nn Output, @PlaBasAcm_nn Output, @PlaBonGan_fl Output, @PlaPorFac_nn Output, @GtaMaxBga_nn    Output, @BenEspAplicados Output, @CobPerTop_fl    Output, @CobAmpGui_fl    Output, @CobPorTop_nn    Output, @CobFacEqi_nn    Output
                                        
               end 
               
               update #PlanesAlternativos 

               set Iterar = 1 
               where  PlaCodPla_id = @extPlanAlternativo and Iterar       is null 
               
               if @CobModCob_id <> 'LE' 
               begin 
                  set rowcount 0 
        
          update #PlanesAlternativos set Iterar = 1 
               end 
            end 
         end 
         if @CobModCob_id = 'LE' 
         begin 
            select @GruCob = GcoCodGco_id from  prestacion..SubPrestGrupCob ,prestacion..CatGruCob ,contrato..Cobertura 
            where  SpgCodPre_id = @CodPrestacion 
              and  SpgCodIte_id = @Item 
              and  GcoCodGco_id = SpgCodGco_id 
              and  CobCodPla_id = @extPlan 
              and  CobGruCob_id = GcoCodGco_id 
              and  GcoTipAte_re = 'AM' 
              and  GcoCodGco_id <> '104'
              
            update #PrestacionValorizada 
            set GrupoCobertura   = @GruCob where  Indice = @Indice 
            
            exec prestacion..BON_CheckPlanCobVariable @extPlan, @Hoy, @vliCobVar out
            if @vliCobVar = 1
            begin
               set @vlcCobVar_Prestacion = @CodPrestacion
               set @vldCobVar_Fecha     = @Hoy
               set @vliCobVar_Monto      = @MntRefPre
            end
            else
            begin
               set @vlcCobVar_Prestacion = null
               set @vldCobVar_Fecha      = null
               set @vliCobVar_Monto      = null
            end
            exec @ErrorExec = contrato..N_PL_SerPyT_Cobertura @extPlan, @NroContrato, @Marca, @RutCon, @FolCon, @CorDir, @CodLoc, 'BO', @vlcModCob, @GruCob, @vlcCobVar_Prestacio n, @vldCobVar_Fecha, @vliCobVar_Monto, null, @CobCodPla_id    Output, @CobModCob_id    Output, @CobGruCob_id    Output, @CobCodNom_ta    Output, @CobPorBon_nn    Output, @CobMonTop_nn    Output, @CobModTop_re    Output, @CobMonTopCon_nn Output, @CobModTopCon_re Output, @CobRanCob_nn    Output, @CobMonCop_nn    Outpu t, @CobModCop_re    Output, @CobNivPpo_nn    Output, @PlaModRef _re    Output, @PlaCobInt_nn    Output, @PlaTopBac_nn    Output, @PlaBasAcm_nn    Output, @PlaBonGan_fl    Output, @PlaPorFac_nn    Output, @GtaMaxBga_nn    Output, @BenEspAplicados Output, @CobPerTop_fl    Output, @CobAmpGui_fl    Output, @CobPorTop_nn    Output, @CobFacEqi_nn    Output 
         
	end 
      end   --// FIN PLANES ALTERNATIVOS... 
      if @ErrorExec = 0 
      begin --// Obtencion de Linea de Cobertura Exitosa 
         Select @fec_ini_veg = ConIniPla_pe 
         from   contrato..Contrato 
         where  ConMarCon_id = @Marca 
           and  ConNumCto_id = @NroContrato 
           and  ConRutCot_id = @RutCte 
         
         Select @boni_pend = 0 
         
         Select @boni_pend = isnull(sum(AporteFinanciador),0) 
         from   #PrestacionValorizada 
         where  GrupoCobertura is not null 
           and  GrupoCobertura = @GruCob 
           and  Error = 0 
 
         Select @ErrorExec = 0, @cod_error = 0 
         
         Select @ValorDesde = convert(numeric(11,2),@ValorDesde) 
         Select @ValorHasta = convert(numeric(11,2),@ValorHasta) 
         
         --obtener monto de excepcion para copago fijo
         
         exec convenio..CON_GetExcepcionCF @extPlan, @CobGruCob_id, @CodPrestacion, @Hoy, @CorDir, @vliExcepcionCF out
      
   if @vliExcepcionCF is not null
         begin
            if @vliExcepcionCF > isNull(@CopagoFijo, 0)
               set @CopagoFijo = @vliExcepcionCF
         end
         if @tipo_carga = '2'
            set @vliTopePlan = @PlaBasAcm_nn  --tope para carga medica
         else
            set @vliTopePlan = @PlaTopBac_nn  -- tope para carga legal
         
         --forzar error en venta para planes de medicina familiar cuando la cobertura es 0
         if (@CobPorBon_nn = 0 and @CobMonCop_nn is null)
         begin
            if @CobGruCob_id not in ('58', '106', '107', '492', '600', '610')
            begin
               if @vliEsMaxSalud = 1
               begin
                  set @ErrorExec = 21011
               end
            end
        
 end
         
         if @ErrorExec = 0
             exec @ErrorExec = prestacion..BON_Calcular_Bonificacion @RutCte, @NroContrato, @Marca, @cor_car, @Hoy, @extPlan, @vliTopePlan, @CorDir, @CodPrestacion, @Item, @CantAte, @ValorDesde, @ValorHasta, null, null, @Modalidad, @CostoCero, @CopagoFijo, 100, 'N', @CobModCob_id, @CobGruCob_id, @CobCodNom_ta, @CobPorBon_nn,  @CobMonTop_nn, @CobModTop_re, @CobMonTopCon_nn, @CobPerTop_fl, @CobModTopCon_re, @CobMonCop_nn, @CobModCop_re,  @PlaModRef_re, @PlaBonGan_fl, @GtaMaxBga_nn, @BenEspAplicados, @CobAmpGui_fl, @CobPorTop_nn, @CobFacEqi_nn, @boni_pend, null, 'AM', 'NO', @por_boni       output, @mto_boni       output, @copago         output, @mto_presta     output, @operacion      output, @mensaje        output, @Cambia_Linea   output, @guindas        output, @CobPerOUT_fl   output, @CobAmpOUT_fl   output, @CobPorOUT_nn   output, @CobFacOUT_nn   output, @ValAraCal_nn   output, @ModAraCal_cr   output, @MntoTopeCto    output, @ModTopeCto     output, @MntoTopeEve    output, @ModTopeEve     output, @MntoTopeInt    output, @ModTopeInt     output, @MntoBonMinFon  output 
         
	if (@ErrorExec = 0) and ((@cod_error = 0)or(@cod_error is null) ) 
         begin --// Bonificacion Exitosa 
            update #PrestacionValorizada 
            set ModalCobertura    = @CobModCob_id, 
                TipoCalculo       = @operacion, 
          	ValorPrestacion   = @mto_presta, 
                AporteFinanciador = @mto_boni, 
                Copago            = @copago, 
                ValorRendicion    = @mto_presta,
                CopagoFijo        = @CopagoFijo,  --por si cambio por regla de excepcion de CF
                GrupoCobertura    = @GruCob
            where  Indice = @Indice 
         end   --// FIN Bonificacion Exitosa 
         else 
         begin --// Bonificacion Fallida 
            if @cod_error != 0  or @ErrorExec != 0
            begin  
               if @ErrorExec in (21009, 21010, 21011)
                  update #PrestacionValorizada 
                  set Error  = @ErrorExec 
                  where  Indice = @Indice 
               else
                  update #PrestacionValorizada  
                  set Error      =  case when @cod_error  > @ErrorExec then @cod_error else @ErrorExec end
                  where  Indice = @Indice  
            end  
         end 
      end --// FIN Obtencion de Linea de Cobertura Exitosa 
      else 
      begin --// Error en la Linea de Cobertura 
         update #PrestacionValorizada 
         set Error  = @ErrorExec 
         where  Indice = @Indice 
      end 
   end -- prestacion no es GES
   update #PlanesAlternativos 
   set Iterar = NULL 
      
   Select @MinValor = @MinValor + 1 
 end 
 
 --// se calcula y distribuye bonificacion GES
 if exists(select 1 from #PrestacionValorizada where GrupoCobertura = '104')
 begin
    declare @cg_Canasta char(20), @cg_FolioGES int, @cg_CorRen int, @cg_PerUso char(2), @cg_ValorTotal numeric(11,0)
    declare c_Ges cursor for
    Select CanastaGES, FolioGES, ValorTotal From #CanastasGES
    for read only
    open c_Ges
    fetch c_Ges into @cg_Canasta, @cg_FolioGES, @cg_ValorTotal
    
    While @@sqlstatus = 0
    begin
       exec @ErrorExec = prestacion..GES_CalculoCopago @cg_FolioGES,  @cg_ValorTotal, 0, @cg_Canasta, @Hoy, @CodSucursal, 'CSALUD00', @mto_boni out, @copago out, @vlnDedGesAplicado out, @vlnGesAplIsapre out, @vlnGesValorUF out, @vldGesFecCob out,  @cod_error out, @vliCopCanasta out,   @vlnGesDedCta out,  @vlnGesDedCaso out, @vlnGesCtaCto out, @vlnGesDedCto out
       update #CanastasGES
       set  BonificacionTotal = @mto_boni,
            CopagoTotal       = @copago
       where CanastaGES = @cg_Canasta
       
       fetch c_Ges into @cg_Canasta, @cg_FolioGES, @cg_ValorTotal
    end
    close c_Ges deallocate cursor c_Ges
       set @operacion =  'MB'
       set @CobModCob_id = 'GES'
    
    Update #PrestacionValorizada
    set ModalCobertura    = @CobModCob_id,
        TipoCalculo       = @operacion, 
        ValorPrestacion   = ValorDesde * CantAte, 
        AporteFinanciador = floor(round((ValorDesde * CantAte /ValorTotal) * BonificacionTotal,0)), 
        Copago            = floor(round((ValorDesde * CantAte /ValorTotal) * CopagoTotal,0)), 
        ValorRendicion    = ValorDesde * CantAte
     from #CanastasGES 
     where Homologo = CanastaGES
     
    Update #PrestacionValorizada
    set AporteFinanciador = ValorPrestacion, Copago = 0
     from #CanastasGES, #PrestacionValorizada
     where Homologo = CanastaGES
       and PerUsoGES = 'PC'
       and CodPrestacion not in ('0101009', '0101101', '0101108', '0101110', '0101111', '0101112', '0101113', '0903000', '0903001')
    
    Select Homologo, sum(Copago) as TotCop into #ParaControl
    from #PrestacionValorizada
    where GrupoCobertura = '104'
    group by Homologo
    
    Select Homologo, TotCop - CopagoTotal as MntAjuste into #ParaDistribucion
    from #ParaControl, #CanastasGES
    where CanastaGES = Homologo and TotCop <> CopagoTotal
    if @@rowcount > 0
    begin
       declare @cd_Homologo char(20), @cd_mntAjuste int
       declare c_distribucion cursor for
       select Homologo, MntAjuste from #ParaDistribucion
       for read only
       open c_distribucion
       fetch c_distribucion into @cd_Homologo, @cd_mntAjuste
       while @@sqlstatus = 0
       begin
          set rowcount 1
          update #PrestacionValorizada
          set Copago = Copago - @cd_mntAjuste
          where GrupoCobertura = '104'
            and Homologo = @cd_Homologo
            and Copago > 0 
            and AporteFinanciador > @cd_mntAjuste
            
          set rowcount 0
          fetch c_distribucion into @cd_Homologo, @cd_mntAjuste
       end
       close c_distribucion
       deallocate cursor c_distribucion
    end
    Update #PrestacionValorizada
    set AporteFinanciador = ValorPrestacion - Copago
    where GrupoCobertura = '104'
      and ValorPrestacion <> (AporteFinanciador + Copago)
 end

 
 --// Control In necesario en las pruebas de CAPACITACION, pero SI 
 --// en PRODUCCION. 
 if rtrim(ltrim(@svr_name)) = 'PRODUCCION' 
  begin 
   if exists (Select 1 
              From   #PrestacionValorizada 
 
             where  GrupoCobertura in ('24', '300', '301', '302', '303')) 
    begin 
     --// Control de Frecuencia en las consultas.... 
     --// 
     --// Denegar la valorizacion para cualquier carga que en las ultimas cuatro 
     --// semanas tenga mas de 6 bonos de consulta, emitidos en la surcursales 
     --// I-MED. Esto ultimo, para cualquier efecto es la sucursal 130600 
 
     exec @ErrorExec = prestacion..Sel_FrecPrestaciones @RutCte, @NroContrato, @Marca,  @cor_car, 4,       2, @TotalPrest output if @ErrorExec != 0 
      begin 
       Select @extCodError = 'N' 
  
     Select @extMensajeError = 'Consulta Frec. Prest.' 
       set @GlosaLogError = 'Rechazo por Frecuencia de Prestaciones'
       if @FlagLogError = 1
          exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 100950, @GlosaLogError, @RutCte, @cor_car, @extPlan
       return 1 
      end 
 
        -- controlar el total de prestaciones en sesion + la historia -- FR-7787 
        Select @TotalPrest = @TotalPrest + count(*) 
          From #PrestacionValorizada 
         where GrupoCobertura in ('24', '300', '301', '302', '303') 
 
 
     if @TotalPrest > 6  -- Modificado por FR-9155 
      begin 
       Select @extCodError = 'N' 
       --//Select @extMensajeError = 'EXCESO CONSULTA,ASISTIR ISAPRE' 
       Select @extMensajeError = 'EXCEDE CONSUL IMED IR A ISAPRE' 
       set @GlosaLogError = 'Rechazo por exceder numero de consultas'
       if @FlagLogError = 1
          exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 100951, @GlosaLogError, @RutCte, @cor_car, @extPlan
       return 1 
      end 
    end 
  end --// FIN if rtrim(ltrim(@svr_name)) = 'prestacion' 
 
 Select @extCodError = 'S' 
 Select @extMensajeError = '' 
 
 if exists(
Select 1 from #PrestacionValorizada where Error in (21009, 21010, 21011) ) 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'PLAN CERRADO, MEDICINA FAMILIAR'  
   set @GlosaLogError = 'Rechazo por ser plan cerrado, Medicina Familiar'
 
  if @FlagLogError = 1
      exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 100960, @GlosaLogError, @RutCte, @cor_car, @extPlan
   return 1
  end  

 if exists(Select 1 from #PrestacionValorizada where Error = 101009) 
 begin 
   Select @extCodError = 'N' 
 
   --FR-33392
   Select Top 1 @extMensajeError = 'INFORMA PRECIO 0('+ convert(varchar(11),Homologo)+')'  
   from   #PrestacionValorizada  
   where  Error = 101009
   
   if @FlagLogError = 1
      exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, 0, @extMensajeError, @RutCte, @cor_car, @extPlan
   return 1
 end     
 if exists(Select 1 from #PrestacionValorizada where Error > 0) 
  begin 
   Select @extCodError = 'N' 
 
   --FR-33392
   Select Top 1 @extMensajeError = 'PREST NO OTORGAB.('+ convert(varchar(11),Homologo)+')'  
   from   #PrestacionValorizada  
   where  Error <> 0  
   
   if @FlagLogError = 1
      
   exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, 0, @extMensajeError, @RutCte, @cor_car, @extPlan
   return 1
  end 
 -- FR 33137, control de grupos de cobertura
 if exists(Select
 1 from #PrestacionValorizada where Error = 0 and isNull(GrupoCobertura,space(4)) = space(4) ) 
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'PREST. SIN GRUPO COBERTURA'  
   if @FlagLogError = 1
      exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, 100901, @extMensajeError, @RutCte, @cor_car, @extPlan
   return 1
  end  
  
 if exists(Select 1 from #PrestacionValorizada where Error = 0 and isNull(TipoCalculo, space(2)) = space(2) )
  begin 
   Select @extCodError = 'N' 
   Select @extMensajeError = 'PREST. SIN GRUPO COBERTURA TC'  
   if @FlagLogError = 1
      exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, @CodPrestacion, @Item, @Homologo, 100902, @extMensajeError, @RutCte, @cor_car, @extPlan
   return 1
  end  
 --// Generacion de los registros de log de control. 
 --// Esta obtencion de codigo queda obsoleta en el esquema de atributo identity. 
 
 Select @DigCon = substring(ltrim(rtrim(@extRutConvenio)),charindex('-',ltrim(rtrim(@extRutConvenio)))+1,1) 
 
 Select @DigBen = substring(ltrim(rtrim(@extRutBeneficiario)), charindex('-',ltrim(rtrim(@extRutBeneficiario)))+1,1) 
 
 Select @RutCot = convert(int,substring(ltrim(rtrim(@extRutCotizante)),1, charindex('-',ltrim(rtrim(@extRutCotizante)))-1)) 
 
 Select @DigCot = substring(ltrim(rtrim(@extRutCotizante)), charindex('-',ltrim(rtrim(@extRutCotizante)))+1,1) 
 
 Select  extValorPrestacion   = convert(numeric(12,0),ValorPrestacion), 
         extAporteFinanciador = convert(numeric(12,0),AporteFinanciador), 
         extCopago            = convert(numeric(12,0),ValorPrestacion - AporteFinanciador), 
   	extInternoIsa        = convert(char(15), replicate('0',3 - char_length(ltrim(rtrim(GrupoCobertura))))+ ltrim(rtrim(GrupoCobertura))+ ltrim(rtrim(ModalCobertura))+ replicate(' ',4 - char_length(ltrim(rtrim(ModalCobertura))))+ ltrim(rtrim(TipoCalculo))+ replicate(' ',2 - char_length(ltrim(rtrim(TipoCalculo))))+ space(6)),
	extTipoBonoficacion1 = case GrupoCobertura 
                              when '492' then 78
                              when '610' then 78
     
                              else 
                                       case when (@vliEsMaxSalud =  1 and @RutCon in (76398000, 96986050, 87562600, 96879440)) then 79
                                       else 0                                       
    				       end
                               end,
			extCopago1 				= 0, 
			extTipoBonoficacion2 = case when GrupoCobertura = '104' then 77 else 0 end,
			extCopago2 				= 0,
			extTipoBonoficacion3 = 0,
			extCopago3 				= 0,
			extTipoBonoficacion4 = 0,
			extCopago4 				= 0,
			extTipoBonoficacion5 = 0,
			extCopago5 				= 0
 From    #PrestacionValorizada 
 order by Indice 
 
-- select * from #PrestacionValorizada 
 
 if (Select count(*) from #PrestacionValorizada) = 
    (Select count(*) from #PrestacionValorizada where Error = 0) 
 begin 
     Select @extCodError = 'S' 
     Select @extMensajeError = '' 
     return 1 
 end 
 else 
 begin 
    Select @extCodError = 'N' 

    --FR-33392
    Select Top 1 @extMensajeError = 'PREST NO OTORGAB.('+ convert(varchar(11),Homologo)+')'  
    from   #PrestacionValorizada  
    where  Error <> 0  
    
    if @FlagLogError = 1
       exec prestacion..Ins_LogRechazoINGValorVari @Folio, @extFecTrx, @FolCon, @RutCon, @CorDir, null, null, null, 0, @extMensajeError, @RutCte, @cor_car, @extPlan
    return 1 
 end 
end
                                                                                                                                                                    
(515 rows affected)
(return status = 0)
1> 
