locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
25
(1 row affected)
text

Create Procedure dbo.INGGesCana
( 
 @extCodFinanciador     smallint, 
 @extRutBeneficiario    char(12), 
 @extRutConvenio        char(12), 
 @extHomNumeroConvenio  char(15), 
 @extHomLugarConvenio   char(10), 
 @extSucVenta           char(10), 
 @extCodE
rror           char(1)    output, 
 @extMensajeError       char(30)   output

) 
/* 
  -- ** ------------------------------------------------------------------------------------- 
   Creado por  : Marcelo Herrera 
   Creado el   : Mayo de 2011
   Referenc
ia  : FR-3622. Se crea nuevo servicio INGGesCana para indicar lista de canasta habilitadas
                 para un beneficiario (GES), se filtran aquellas disponibles en el prestador.
  -- ** --------------------------------------------------------------
----------------------- 

   Modificado por : Heidi Monterrichard
   Fecha          : Noviembre 2014
   Objetiv        : Debido a que se esta permitido mnodificar la fecha de termino de vigencia de una canasta (Circular 231),Ya no se considerara para eval
uar vigencias el campo GevEstAut_id 
                    La vigencia se controlara evaluando la fecha de termino que no tan solo sea null sino que tambien sea mayor o igual al dia actual.





   Parametros I 
       @extCodFinanciador     : Codigo del Fi
nanciador 
       @extHomNumeroConvenio  : Homologo numero de convenio (11c para Codigo+'-'+ 3c para corr renov) 
       @extHomLugarConvenio   : Homologo Lugar de convenio (Corr. Direccion) 
       @extSucVenta           : Homologo Sucursal de Venta (cod
igo Sucursal) 
       @extRutConvenio        : Rut Convenio, R.u.t. del prestador en convenio 
       @extRutBeneficiario    : RUT del Beneficiario 

 
   Parametros O 
       @extCodError        : Codigo de Error ('S','N') 
                             S
 = estado exitoso de la transaccion 
                             N = fallo o error en transaccion 
       @extMensajeError    : Mensaje de Error. 
       @extPlan            : Plan con el cual se Bonificarﬂ. 
 
   ------------------------ 
   |Servicios 
para C-Salud | 
   ------------------------ 
 
 Descripcion 
 
   Este Servicio envia datos de todas las canastas GES que un beneficiario
   presenta vigente y que el prestador se encuentra habilitado para otorgar. 
 

 -- ** -----------------------------
------------------------------------------------------------ 
*/ 
As 
BEGIN
   declare 
         --para para parametros de entrada
         @CodSucursal           sucursal, 
         @RutCon                rut, 
         @RutBen                rut, 
     
    @FolCon                int, 
         @CorDir                int, 

         @Hoy                   fecha,
         @HoyMasUno             fecha,
         @Marca                 marca, 
         @NroContrato           contrato, 
         @Ok          
          flag, 
         @ErrorExec             int,
         @RutCte                rut, 
         @cor_car               char(2)
         --//@tipo_carga            char(1), 

   set @extMensajeError = ''

   --// Obtencion de la Fecha del Dia. FECHA D
EL SERVIDOR SYBASE. 
   Select @Hoy          = convert(char(10), getdate(), 101)
   --// Obtencion de fecha siguiente
   Select @HoyMasUno    = dateadd(dd, 1, @Hoy) 

   Select @CodSucursal = convert(char(6),ltrim(rtrim(@extSucVenta))) 
   --//conversion 
del Rut del Prestador 
   Select @RutCon = convert(int,substring(ltrim(rtrim(@extRutConvenio)),1,charindex('-',ltrim(rtrim(@extRutConvenio)))-1)) 
   --//conversion del RUT del Beneficiario 
   Select @RutBen = convert(int,substring(ltrim(rtrim(@extRutBen
eficiario)),1,charindex('-',ltrim(rtrim(@extRutBeneficiario)))-1)) 
   --// folio del convenio 
   Select @FolCon = convert(int,substring(ltrim(rtrim(@extHomNumeroConvenio)),1,charindex('-',ltrim(rtrim(@extHomNumeroConvenio)))-1)) 
   --// Correlativo de 
direccion. 
   Select @CorDir = convert(int,ltrim(rtrim(@extHomLugarConvenio))) 

   exec @ErrorExec = prestacion..INGSelConMar @RutBen, @Hoy, @HoyMasUno, @Marca output, @NroContrato output, @Ok output     

   if @Ok = 'N' or @ErrorExec != 0 
   begin 
 
     Set @extCodError = 'N' 
      Set @extMensajeError = 'Fallo re-validacion del benef'--TRX DENEGADA (EI:400367)' 
      return 1 
   end
   
   Select @cor_car     = BenCorCar_id, 
          --//@tipo_carga  = BenTip_fl, 
          @RutCte      = BenR
utCot_id 
   from   contrato..Beneficiario 
   where  BenRutBen_nn = @RutBen 
     and  BenNumCto_id = @NroContrato 
     and  BenMarCon_id = @Marca 
     and  BenIniVig_fc <= @Hoy 
     and  BenTerVig_fc >= @Hoy 
     
   if @@rowcount > 1 
   begin 
   
   Set @extCodError = 'N'
      Set @extMensajeError = 'Benef. en mas de un Cto.' 
      return 1 
   end 
   
   Select distinct GevCodCar_id into #BenCanastasVigentes
   from prestacion..Evento_CAEC 
       ,prestacion..GES_GrupoEvento
   where EcaMarCo
n_ta = @Marca 
     and EcaRutCon_ta = @RutCte
     and EcaNumCto_ta = @NroContrato
     and EcaIteBen_ta = @cor_car --@IteBen 
     and EcaTipCob_re = 'GE'      -- GES 
     and EcaEstEve_re = 'AU'
     and EcaNumEve_id  > 50000
     and isNull(EcaFecAlt
_fc, @HoyMasUno) >= @Hoy
     and isNull(EcaEstAlt_re, '') <> case when isNull(EcaFecAlt_fc, @HoyMasUno) >= @Hoy then '99' else 'AD' end
     and GevFolEve_id = EcaNumEve_id 
   --  and GevEstAut_id = case when isNull(GevFecTer_fc, @HoyMasUno) >= @Hoy the
n GevEstAut_id else 'VI' end
     and GevFecIni_fc <= @Hoy
     and isNull(GevFecTer_fc, @HoyMasUno) >= @Hoy
     
   Select GevCodCar_id into #ConCanastasVigentes  
   From #BenCanastasVigentes a
   Where exists(select 1 from convenio..GesConvenido 
    
            where GecCorLat_nn = @CorDir
                  and GecCodCar_ta = a.GevCodCar_id
                  and GecVigDes_fc <= @Hoy
                  and isNull(GecVigHas_fc, @HoyMasUno) >= @Hoy )
                  
   Set @extCodError = 'S'
   
   se
lect distinct
          extCodPatologia = GprNumPro_id,
          CodIntSanitaria = case GprCodEta_id
                               when 'DI' then 1
                               when 'TR' then 2
                               when 'SE' then 3
         
                   end,
          extCodCanasta   = GprCodIme_cr
   from #ConCanastasVigentes, prestacion..GES_GrupoProblema
   where GprCodCar_id = GevCodCar_id
          
              
END                                                                
(25 rows affected)
(return status = 0)
1> 