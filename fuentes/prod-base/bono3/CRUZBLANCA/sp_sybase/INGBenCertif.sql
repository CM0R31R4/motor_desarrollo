locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
137
(1 row affected)
text

create procedure dbo.INGBenCertif 
( 
 @extCodFinanciador     smallint, 
 @extRutBeneficiario    char(12), 
 @extFechaActual        datetime, 
 @extApellidoPat        char(30)      output, 
 @extApellidoMat        char(30)      output, 
 @extNombres     	char(40)      output, 
 @extSexo               char(1)       output, 
 @extFechaNacimi        datetime      output, 
 @extCodEstBen          char(1)       output, 
 @extDescEstado         char(15)      output, 
 @extRutCotizante       char(12)      output, 
 @extNomCotizante       char(40)      output, 
 @extDirPaciente        char(40)      output, 
 @extGlosaComuna        char(30)      output, 
 @extGlosaCiudad        char(30)      output, 
 @extPrevision          char(1)       output, 
 @extGlosa 		char(40)      output, 
 @extPlan               char(15)      output, 
 @extDescuentoxPlanilla char(1)       output, 
 @extMontoExcedente     numeric(10,0) output 
) 
/* 
    -- ** -------------------------------------------------------------
------------------------ 
   procedimiento : INGBenCertif_out 
   Autor         : Cristian Rivas Rivera. 
  -- ** ------------------------------------------------------------------------------------- 
   Modificado    : Mauricio Cosgrove 
   Objetivo     
 : FR-9155 
  -- ** ------------------------------------------------------------------------------------- 
   Modificado    : Marcelo Herrera 
   Modificado el : Octubre de 2006 
   Objetivo      : FR-14465, cuando no existe Beneficiario registrado en ING
 devolver estado R 
  -- ** ------------------------------------------------------------------------------------- 
   Modificado    : Marcelo Herrera 
   Modificado el : Febrero de 2007 
   Objetivo      : FR-19057, informar excedente disponible para posi
ble uso como copago 
  -- ** ------------------------------------------------------------------------------------- 
   Modificado    : Mauricio Cosgrove 
   Modificado el : 04/06/2007 
   Objetivo      : FR-19057, Controlar el uso de pgo con excedente 
  
-- ** ------------------------------------------------------------------------------------- 
   Modificado    : Marcelo Herrera
   Modificado el : Junio 2008
   Objetivo      : FR-31792, Proyecto Multimarca, valor por defecto de marca cuando financiador
 
                  es Normedica debe ser NM.
                   Se controla que financiador y beneficiario presenten el mismo codigo de 
                   asegurador.
  -- ** --------------------------------------------------------------------------------
----- 
   Modificado    : Marcelo Herrera
   Modificado el : Noviembre de 2010
   Objetivo      : FR- 2979, direccion de cotizante debe obtenerse desde tabla DireccionContacto.
  -- ** ----------------------------------------------------------------------
--------------- 
   Modificado    : Marcelo Herrera
   Modificado el : Mayo de 2011
   Objetivo      : FR - 3622, Si beneficiario se certifica exitosamente se verifica si presenta
                   GES activo, informando valor G en atributo de estado.
  
                 Este cambio solo lo aplicamos en el servicio directo de IMED, el servicio 
                   paralelo de uso interno (Certif_out) no se modifica.
  -- ** -----------------------------------------------------------------------------------
-- 
   Modificado    : Marcelo Herrera
   Modificado el : Septiembre de 2011
   Objetivo      : FR - 4591, deshabilitar verificacion GES  hasta Septiembre 27.
  -- ** ------------------------------------------------------------------------------------- 
 
  Modificado    : Marcelo Herrera
   Modificado el : Enero de 2012
   Objetivo      : FR - 5264, Informar cuando sea plan de medicina familiar, uso de atributo 
                   @extPrevision. Se informara con valor M.
  -- ** --------------------------
----------------------------------------------------------- 
   Modificado    : Marcelo Herrera
   Modificado el : Enero de 2013
   Objetivo      : FR - 7110, Se elimina informar plan de medicina familiar en atributo
                   @extPrevision.
  --
 ** ------------------------------------------------------------------------------------- 
   Modificado    : Marcelo Herrera
   Modificado el : Febrero de 2013
   Objetivo      : FR - 7573, Control para informar monto de Excedente se restringe cuando
   
                beneficiario informado es el cotizante.
  -- ** ------------------------------------------------------------------------------------- 
 
 
 
 Parametros I 
 @extCodFinanciador   : Cædigo del Financiador 
 @extRutBeneficiario  : RUT del Beneficiario 
 @extFechaActual      : Fecha de Referencia 
 
   ------------------------ 
   |Servicios para C-Salud | 
   ------------------------ 
 
   Descripciæn 
 
   Este Servicio se encarga de certificar la existencia del beneficiario, en la
 base del financiador 
   (CB,AS), y de retornar informaciæn de este; entre otros la aceptaciæn o bloqueo, vigencias, plan, 
   etc. En caso de menores de edad se debe devolver en caso de ser requeridos la lista de acompa±antes 
   validos asociados al be
neficiario. 
 
   Prueba 
 
   declare  @extCodFinanciador     smallint, 
            @extRutBeneficiario    char(12), 
            @extFechaActual        datetime, 
            @extApellidoPat    char(30), 
            @extApellidoMat        char(30), 
 
           @extNombres            char(40), 
            @extSexo               char(1) , 
            @extFechaNacimi        datetime, 
            @extCodEstBen          char(1) , 
            @extDescEstado        char(15), 
            @extRutCotizant
e       char(12), 
            @extNomCotizante       char(40), 
            @extDirPaciente        char(40), 
            @extGlosaComuna       char(30), 
            @extGlosaCiudad        char(30), 
            @extPrevision          char(1) , 
       
     @extGlosa              char(40), 
            @extPlan               char(15), 
            @extDescuentoxPlanilla char(1), 
            @extMontoExcedente     numeric(10) 
 
   exec prestacion..INGBenCertif 078, '001227910-8', '20101124', @extApellidoPat output, @extApellidoMat output, @extNombres output, @extSexo output, @extFechaNacimi output, @extCodEstBen output, @extDescEstado output, @extRutCotizante output, @extNomCotizante output, @extDirPaciente output, @extGlosaComuna output, @extGlosaCiudad output, @extPrevision output, @extGlosa output, @extPlan output, @extDescuentoxPlanilla output, @extMontoExcedente output 

 
 Select @extApellidoPat        = 'FUENTEALBA', 
        @extApellidoMat        = 'ZAFIRA', 
        @extNombres            = 'LUISA AMANDA', 
        @extSexo               = 'F', 
        @extFechaNacimi        = 'Jul  1 1946 12:00AM', 
        @extCodEstBen          = 'C', 
        @extDescEstado       	= 'CERTIFICADO', 
        @extRutCotizante       = '0005308213-0', 
        @extNomCotizante       = 'FUENTEALBA ZAFIRA LUISA AMANDA', 
        @extDirPaciente        = 'PARCELA SAN LUIS CASILLA 442', 
        @extGlosaComuna 	= 'LOS ANGELES', 
        @extGlosaCiudad 	= 'LOS ANGELES', 
        @extPrevision          = 'D', 
        @extGlosa              = '', 
        @extPlan               = 'DFN3A08000', 
        @extDescuentoxPlanilla = 'N', 
        @extMontoExcedente  = 0 
 
 Select  extRutAcompanante = convert(char(12),replicate('0',12 - char_length(extRutAcompanante))+extRutAcompanante), extNombreAcompanante From #Autorizados 

*/ 
As 
declare @FechaEntrada      fecha, 
        @Hoy               fecha, 
        @Marca             mar
ca, 
        @RutBen            rut, 
        @NroContrato       contrato, 
        @RutCotizante      rut, 
        @LocaDir           localidad, 
        @TerLic_fc         fecha, 
        @TipTer_re         regla, 
        @BenIniVig_fc      fecha, 
  
      @BenTerVig_fc      fecha, 
        @Sucripcion        fecha, 
        @IanBen_pe         fecha, 
        @TanBnf_pe         fecha, 
        @ErrorCode         int, 
        @BenDvCot_cr       dv, 
        @BenDvBen_cr       dv, 
        @ResCert    
       regla, 
        @BenCriDer_ta      char(2), 
        @FechaCny          fecha, 
        @TipPla            regla, 
        @RutCny            rut, 
        @ContratoCny       contrato, 
        @NroFilas          int, 
        @db_name           ch
ar(30), 
        @Folio             int, 
        @Result_Exe        int, 
        @Exc_Contable      int,
        @MarcaFinanciador  marca,
        @HoyMasUno         fecha,
        @vldBenCodCar      char(2)
 
begin 
 delete tempdb02..IBC_Autorizados 
 
where spid = @@spid 
 
 delete tempdb02..IBC_Beneficiarios 
 where spid = @@spid 
 
 delete tempdb02..IBC_DatosConyuge 
 where spid = @@spid 
 
 Select @db_name = db_name() 
 
 Select @extApellidoPat        = '', 
        @extApellidoMat        = '', 
   
     @extNombres            = '', 
        @extSexo               = '', 
        @extFechaNacimi        = '19000101', 
        @extCodEstBen          = '', 
        @extDescEstado         = '', 
        @extRutCotizante       = '0000000000-0', 
        @e
xtNomCotizante       = '', 
        @extDirPaciente        = '', 
        @extGlosaComuna        = '', 
        @extGlosaCiudad        = '', 
        @extPrevision          = '', 
        @extPlan               = '', 
        @extDescuentoxPlanilla = '', 

        @extMontoExcedente     = 0 
 
 Select @FechaEntrada = convert(smalldatetime,convert(char(10),@extFechaActual,101)) 
 Select @Hoy          = convert(smalldatetime,convert(char(10),getdate(),101)) 
 Select @HoyMasUno    = dateadd(dd, 1, @Hoy) 
 
 if @extCodFinanciador = 74 Select @Marca = 'AS' 
 if @extCodFinanciador = 78 Select @Marca = 'CB' 
 if @extCodFinanciador = 70 Select @Marca = 'NM' 
 
 Select @MarcaFinanciador = MarEmpIsa_cr
 from parametro..Marca
 where MarCodMar_id = @Marca
 
 Select @RutBen = convert(int,substring(ltrim(rtrim(@extRutBeneficiario)),1,charindex('-',ltrim(rtrim(@extRutBeneficiario)))-1)) 
 
 if @FechaEntrada = @Hoy  --//Se ha Solicitado verificacion para la venta de un bono al d›a 
  begin 
   -- ** øexiste beneficiario? 

   if Not Exists(Select BenRutBen_nn from contrato..Beneficiario where BenRutBen_nn  = @RutBen) 
   begin 
      Select 
             @extCodEstBen  = 'R', 
             @extDescEstado = 'NO EXISTE EN BD', 
             @extGlosa      = 'RUT de benef.  n
o existe', 
             @ResCert       = 'IN' 
      begin tran 
 
      update ContadorFolio 
      set    CfoNumFol_nn = CfoNumFol_nn - 1 
      where  CfoCodMar_id = 'IN' 
      And    CfoTipDoc_fl = 'LOCE' 
 
      select @Folio = CfoNumFol_nn 
     
 from   ContadorFolio 
      where  CfoCodMar_id = 'IN' 
      and    CfoTipDoc_fl = 'LOCE' 
 
      commit tran 
      begin tran 
 
      insert Log_Certificaciones 
           (LceCorCer_id, LceMarBen_ta, LceRutBen_ta, LceFecCer_fc, LceDveBen_cr, 
    
        LceRutCon_ta, LceDveCon_cr, LceNumCon_ta, LceCodPla_ta, 
            LceResCer_re) 
      values (@Folio, @Marca, @RutBen, getdate(), '0', 
             0, '0', 0, '', @ResCert) 
      if @@error != 0 
      begin 
         rollback tran 
        
 return 1 
      end 
 
      commit tran 
      return 1 
   end 
 
   insert  tempdb02..IBC_Beneficiarios 
   Select  @@spid, 
           BenRutBen_nn, BenMarCon_id, BenIniVig_fc, BenTerVig_fc, 
           BenApePat_ds, BenApeMat_ds, BenNom_ds,    BenSe
x_fl, 
           BenFecNac_fc, BenNumCto_id, BenRutCot_id, BenDvCot_cr, 
           BenDvBen_cr,  BenCriDer_ta 
   from   contrato..Contrato 
          ,contrato..Beneficiario 
   where  BenRutBen_nn = @RutBen 
     and  BenRutCot_id = ConRutCot_id 
    
 and  BenMarCon_id = ConMarCon_id 
     and  BenNumCto_id = ConNumCto_id 
     and  BenIniVig_fc <= @Hoy 
     and  BenTerVig_fc >= @Hoy 
 
   Select @NroFilas = @@rowcount 
 
   if @NroFilas <> 1 
   begin 
      if @NroFilas = 0 
         Select 
      
      @extCodEstBen  = 'B', 
            @extDescEstado = 'BENF. SIN CTO.VIG.', 
            @extGlosa      = 'RUT de benef. sin Cto. Vig.', 
            @ResCert       = 'IN' 
      else -- @NroFilas > 1 
         Select 
            @extCodEstBen  = 'X'
, 
            @extDescEstado = 'INCONSISTENTE', 
            @extGlosa      = 'Benef. vig. en m·s de un cto.', --'TRANSACCION INCOMPLETA/ASISTIR A ISAPRE', 
            @ResCert       = 'MC' 
 
     begin tran 
 
     update ContadorFolio 
     set    Cf
oNumFol_nn = CfoNumFol_nn - 1 
     where  CfoCodMar_id = 'IN' 
     And    CfoTipDoc_fl = 'LOCE' 
 
     select @Folio = CfoNumFol_nn 
     from   ContadorFolio 
     where  CfoCodMar_id = 'IN' 
     and    CfoTipDoc_fl = 'LOCE' 
 
     commit tran 
 
  
   begin tran 
 
     insert Log_Certificaciones 
           (LceCorCer_id, LceMarBen_ta, LceRutBen_ta, LceFecCer_fc, LceDveBen_cr, 
            LceRutCon_ta, LceDveCon_cr, LceNumCon_ta, LceCodPla_ta, 
            LceResCer_re) 
     values (@Folio, @Marc
a,        @RutBen,      getdate(),    '0', 
             0, '0', 0, 'A1', @ResCert) 
 
     if @@error != 0 
      begin 
       rollback tran 
       return 1 
      end 
 
     commit tran 
 
     return 1 
    end 
   else --// Beneficiario fue encontr
ado. 
    begin 
 
     Select @extApellidoPat        = ltrim(rtrim(BenApePat_ds)), 
            @extApellidoMat    = ltrim(rtrim(BenApeMat_ds)), 
            @extNombres            = ltrim(rtrim(BenNom_ds)), 
            @extSexo               = case Ben
Sex_fl 
                                      when 'N' then 'M' 
                                      else  BenSex_fl 
                                end, 
            @extFechaNacimi        = BenFecNac_fc, 
            @NroContrato           = BenNumCt
o_id, 
            @RutCotizante          = BenRutCot_id, 
            @BenIniVig_fc          = BenIniVig_fc, 
            @BenTerVig_fc          = BenTerVig_fc, 
            @BenDvCot_cr           = BenDvCot_cr, 
            @BenDvBen_cr           = BenD
vBen_cr, 
            @BenCriDer_ta          = NULL, --//BenCriDer_ta, 
            @Marca                 = BenMarCon_id 
     from   tempdb02..IBC_Beneficiarios 
     where  spid         = @@spid 
       and  BenRutBen_nn = @RutBen 
       and  BenIniVi
g_fc <= @Hoy 
       and  BenTerVig_fc >= @Hoy 
 
     if Not Exists(Select 1 from parametro..Marca where MarCodMar_id  = @Marca and MarEmpIsa_cr = @MarcaFinanciador) 
     begin 
          Select @extCodEstBen   = 'X', 
                 @extDescEstado  =
 'NO EXISTE EN BD', 
                 @extGlosa       = 'Codigo Financiador Erroneo', 
                 @ResCert        = 'NV' 

          begin tran 
 
          update ContadorFolio 
          set    CfoNumFol_nn = CfoNumFol_nn - 1 
          where  Cfo
CodMar_id = 'IN' 
          And    CfoTipDoc_fl = 'LOCE' 
 
          select @Folio = CfoNumFol_nn 
          from   ContadorFolio 
          where  CfoCodMar_id = 'IN' 
          and    CfoTipDoc_fl = 'LOCE' 
 
          commit tran 
          begin tran
 
 
          insert Log_Certificaciones 
           (LceCorCer_id, LceMarBen_ta, LceRutBen_ta, LceFecCer_fc, LceDveBen_cr, 
            LceRutCon_ta, LceDveCon_cr, LceNumCon_ta, LceCodPla_ta, 
            LceResCer_re) 
          values (@Folio, @Marca, 
@RutBen, getdate(), '0', 
             0, '0', 0, '', @ResCert) 
          if @@error != 0 
          begin 
               rollback tran 
               return 1 
          end 
 
          commit tran 
          return 1 
     end 
 
     Select @extRut
Cotizante = replicate('0',12 - char_length(ltrim(rtrim(convert(char(10),BenRutCot_id)))+'-'+ltrim(rtrim(BenDvCot_cr))))+ 
                               ltrim(rtrim(convert(char(10),BenRutCot_id)))+'-'+ltrim(rtrim(BenDvCot_cr)), 
            @extNomCotiza
nte = ltrim(rtrim(BenApePat_ds))+' '+ 
                               ltrim(rtrim(BenApeMat_ds))+' '+ 
                          ltrim(rtrim(BenNom_ds)) 
     from contrato..Beneficiario 
     where  BenRutCot_id = @RutCotizante 
       and  BenNumCto_id 
= @NroContrato 
       and  BenCorCar_id = '00' 
       and  BenMarCon_id = @Marca 
 
     Select @extPrevision = case ConTipTra_fl 
                             when '1' then 'D' 
                             when '2' then 'I' 
                          
   when '3' then 'P' 
                             when '4' then 'V' 
                            end, 
            @extPlan               = case 
                                      when ((ConIniPAn_pe <= @Hoy)and(@Hoy < ConIniPla_pe)) then ConPlaAnt_t
a 
                                      when ConIniPla_pe <= @Hoy then ConPlaVig_ta 
                                      else 'PLAN NOFOUND' 
                                     end, 
            @extDescuentoxPlanilla = 'N', 
            -- @extMonto
Excedente     =   0,  a partir de FR 13565 se calculara 
            @Sucripcion            = ConSus_fc, 
            @IanBen_pe             = ConIanBen_pe, 
            @TanBnf_pe             = ConTanBnf_pe, 
            @TerLic_fc             = ConTerLi
c_fc, 
            @TipTer_re             = ConTipTer_re 
     From   contrato..Contrato 
     where  ConRutCot_id = @RutCotizante 
       and  ConNumCto_id = @NroContrato 
       and  ConMarCon_id = @Marca 
 
     --identificacion de plan referido a Medi
cina Familiar
    /* if exists(select 1 from contrato..Plan1 where PlaCodPla_id = @extPlan 
               and (PlaFamPla_ta = 'CBMFAM' or PlaSubFam_ta = 'MFINTG' or PlaAgrFin_ta = 'PLMFIN'))
        set @extPrevision = 'M'
    */
     -- ** -------------
--- inicio  FR 19057 
     -- ** ---- Incluye Control administrativo para Excedentes 
    declare 
       @ValAtr char(255) 
 
    set @extMontoExcedente = 0 
    exec prestacion..RME_Sel_RegAdm 'RM',7,1,@ValAtr output     
    if (rtrim(@ValAtr) = 'SI' a
nd @RutBen = @RutCotizante)  -- Habilitado para operar con Excedentes 
     begin 
          exec @Result_Exe = ingreso..SelSaldoDispContExcedente 
                                 @RutCotizante 
                                ,'IN' 
                    
            ,@extMontoExcedente output 
                                ,@Exc_Contable      output 
                                ,null 
 
          if (@@Error <> 0 or @Result_Exe < 0 or @extMontoExcedente < 0) 
            set @extMontoExcedente = 0 

          if @extMontoExcedente is null 
            set @extMontoExcedente = 0 
      end 
     -- ** ------------------  fin FR 19057 
 
     select  top 1
             @extDirPaciente = ltrim(rtrim(DIR_CALLE_DS)) + (case when DIR_NUMERO_DS = '99999    
 ' then '' else +' #'+ ltrim(rtrim(DIR_NUMERO_DS)) end) +' '+    
                               isNull(ltrim(rtrim(DIR_RESTO_DS)), '')
            ,@LocaDir        = DIR_COD_LOC_TA
     from contrato..DireccionContacto 
     Where DIR_RUT_PER_ID = @RutCo
tizante
       and DIR_TIP_DIR_ID = 'PA'
     order by DIR_COR_DIR_ID desc
     
     if @LocaDir is Null
        Select @extDirPaciente = ltrim(rtrim(DirDir_ds))+' '+ltrim(rtrim(DirSecDir_ds)), 
               @LocaDir        = DirLoc_ta 
        from   
contrato..Direccion 
        where  DirSucEmp_id = '000' 
          and  DirRut_id  = @RutCotizante 
          and  DirIndCob_fl = 'P' 
          and  DirTipDir_id = 'C' 
          and ((DirTer_fc is null)or(DirTer_fc >= getdate())) 
 
 
     Select @extGlosaComuna = LocDesLoc_ds 
     from   parametro..Localidad 
     where  LocCodLoc_id = @LocaDir 
 
     Select @extGlosaCiudad = LocDesLoc_ds 
     from   parametro..Localidad 
     where  LocCodLoc_id = substring(@LocaDir,1,5)+'000' 
 
     --// Se entiende por autorizados a cargas de un contrato mﬂs el cotizante y 
     --// en el caso de los contratos matrimoniales, tambien al conyuge y sus cargas. 
 
     insert tempdb02..IBC_Autorizados 
     Select @@spid, 
            ltrim(rtrim(convert(char(12), BenRutBen_nn)))+'-'+BenDvBen_cr, 
            ltrim(rtrim(BenApePat_ds))+' '+ 
            ltrim(rtrim(BenApeMat_ds))+' '+ 
            ltrim(rtrim(BenNom_ds)) 
     From   contrato..Beneficiario 
     where BenRutCot_id = @RutCotizante 
       and  BenNu mCto_id = @NroContrato 
       and  BenMarCon_id = @Marca 
       and  BenIniVig_fc <= @Hoy 
       and  ((BenTerVig_fc >= @Hoy) or (BenTerVig_fc is null)) 
 
     Select @TipPla = ConTipPla_cr, 
            @RutCny = ConRutCny_nn 
     From   contrato..C ontrato 
     where  ConRutCot_id = @RutCotizante 
       and  ConNumCto_id = @NroContrato 
       and  ConMarCon_id = @Marca 
 
     if ((@TipPla = 'MA')and(@RutCny > 0)and(@RutCny is not null)) 
      begin 
 
       insert  tempdb02..IBC_DatosConyuge 

       Select  @@spid, BenMarCon_id, BenNumCto_id, BenRutCot_id, 
               BenDvCot_cr,  BenIniVig_fc, BenTerVig_fc 
       from    contrato..Beneficiario 
       where   BenRutCot_id = @RutCny 
 
       Select @ContratoCny = BenNumCto_id 
       fr
om   tempdb02..IBC_DatosConyuge 
       where  spid         = @@spid 
         and  BenRutCot_id = @RutCny 
         and  BenMarCon_id = @Marca 
         and  BenIniVig_fc <= @Hoy 
         and  BenTerVig_fc >= @Hoy 
 
       if @@rowcount > 0 
        be
gin 
 
         insert tempdb02..IBC_Autorizados 
         Select @@spid, 
                ltrim(rtrim(convert(char(12),BenRutBen_nn)))+'-'+BenDvBen_cr, 
                ltrim(rtrim(BenApePat_ds))+' '+ 
                ltrim(rtrim(BenApeMat_ds))+' '+ 
   
             ltrim(rtrim(BenNom_ds)) 
         From   contrato..Beneficiario 
         where  BenRutCot_id = @RutCny 
           and  BenNumCto_id = @ContratoCny 
           and  BenMarCon_id = @Marca 
           and  BenIniVig_fc <= @Hoy 
           and 
 ((BenTerVig_fc >= @Hoy) or (BenTerVig_fc is null)) 
 
        end 
 
      end --// Si contrato es MAtrimonial 
 
     --// VALIDACION DE OTORGAMIENTO DE BENEFICIOS 
 
     if ((@IanBen_pe <= @Hoy)and(@Hoy <= @TanBnf_pe)) 
      begin 
       if ((@BenIn
iVig_fc <= @Hoy)and(@Hoy  <= @BenTerVig_fc)) 
        begin 
          Select @extCodEstBen          = 'C', 
                 @extDescEstado         = 'CERTIFICADO', 
                 @extGlosa              = '', 
                 @ResCert               =
 'CE' 
        end 
       else 
        begin 
          Select @extCodEstBen          = 'X', 
                @extDescEstado         = 'NO VIGENTE', 
                 @extGlosa              = 'Benef. no vigente', 
                 @ResCert              
 = 'NV' 
        end 
      end 
     else 
      begin 
       if((dateadd(mm,2,@Sucripcion) <= @Hoy)and(@Hoy < @IanBen_pe)) 
        begin 
         if ((@BenIniVig_fc <= @Hoy)and(@Hoy  <= @BenTerVig_fc)) 
          begin 
           Select @extCodEstBe
n  = 'C', 
                  @extDescEstado         = 'CERTIFICADO', 
                  @extGlosa              = '', 
                  @ResCert            = 'CE' 
          end 
         else 
          begin 
           Select @extCodEstBen          = '
X', 
                  @extDescEstado         = 'NO VIGENTE', 
                  @extGlosa   		= 'Benef. no vigente', 
                  @ResCert               = 'NV' 
          end 
        end 
       else 
        begin 
         if @TerLic_fc is not n
ull 
          begin 
           Select @extCodEstBen          = 'X', 
                  @extDescEstado         = 'NO VIGENTE', 
                  @extGlosa              = 'Benef. no vigente', 
                  @ResCert               = 'NV' 
          en
d 
         else 
          begin 
           if @TanBnf_pe = @BenTerVig_fc 
             begin 
              if @Hoy <= @TerLic_fc 
               if  @TipTer_re = 'BC' 
                begin 
                 Select @extCodEstBen          = 'C', 
     
                   @extDescEstado         = 'CERTIFICADO', 
                        @extGlosa              = '', 
                        @ResCert  = 'CE' 
                 end 
                 -- ** FR-9155 --------------------------------------------- 

                 /* 
               else 
                begin 
                 if  @TipTer_re = 'BM' 
                  begin 
                   Select @extCodEstBen        = 'X', 
                          @extDescEstado       = 'VIGENTE', 
        
                  @extGlosa            = 'Benef. debe concurrir a Isapre' --'BENEFICIOS MINIMOS/ASISTIR A ISAPRE', 
                          @ResCert             = 'BM' 
                  end 
                 else 
                  begin 
             
      Select @extCodEstBen        = 'X', 
                     @extDescEstado       = 'INCONSISTENTE', 
                          @extGlosa            = 'TRANSACCION INCOMPLETA/ASISTIR A ISAPRE', 
                          @ResCert             = 'LI' 
   
               end 
                end 
                -- ** ----------------------------------------------------------- 
                */ 
            end 
           else 
            begin 
             Select @extCodEstBen          = 'X', 
       
             @extDescEstado         = 'NO VIGENTE', 
                    @extGlosa              = 'Benef. no vigente', 
                    @ResCert      = 'NV' 
            end 
          end 
        end 
 
      end 
 
     -- ** FR-9155 --------------
---------------------------------------------------- 
     --// VERIFICACION DE SITUACION DE MORA 
     /* 
     declare @EstaEnMora  char(1), @ImpCertificado char(1), @Gestionable char(1), 
             @BloqueoxCob char(1), @ContadorEnt    int 
 
     -
-//exec @ErrorCode = ingreso..Verifica_MoraCot @RutCotizante, @BenDvCot_cr, 
     exec @ErrorCode = ingreso..Verifica_MoraIMED @RutCotizante, @BenDvCot_cr, 
                                                  @Marca, @NroContrato, 
                         
                         'CSALUD00', '130001', 
                                                  @EstaEnMora     output, 
                                                  @ImpCertificado output, 
                                                  @Gestio
nable    output, 
                                                  @BloqueoxCob    output, 
                                                  @ContadorEnt    output 
     if @EstaEnMora = 'S' 
      begin 
       Select @extCodEstBen     = 'X', 
        
      @extDescEstado    = 'ERROR CONTRATO', 
            @extGlosa         = 'TRANSACCION INCOMPLETA/ASISTIR A ISAPRE', 
            @ResCert            = 'MO' 
      end 
     */ 
 
    end --// Fin de Beneficiario Encontrado 
  end 
 else 
  begin --// 
(D›a distinto a Hoy, Se ha Solicitado verificacion para la venta de un bono retroactivo 
 
   Select @extApellidoPat        = '', 
          @extApellidoMat        = '', 
          @extNombres            = '', 
          @extSexo               = '', 
    
      @extFechaNacimi        = '19000101', 
          @extCodEstBen          = '', 
          @extDescEstado         = '', 
          @extRutCotizante       = '0000000000-0', 
          @extNomCotizante       = '', 
          @extDirPaciente        = '', 

          @extGlosaComuna        = '', 
          @extGlosaCiudad        = '', 
          @extPrevision          = '', 
          @extCodEstBen          = 'B', 
          @extDescEstado         = 'FECHA DIA ERRONEA', 
          @extGlosa              = '
Benef. no vigente', --'Fecha vta. no corresponde al dia de hoy.', 
          @extPlan               = '', 
          @extDescuentoxPlanilla = '', 
          @extMontoExcedente     = 0, 
          @ResCert               = 'FI' 
  end 
 
-- ** -------------
------------------------------------------- 
-- FR-7787 - Control de Vta. IMED para CMF 
-- Este control se manejar· en el servicio : prestacion..ingcoptran 
 
/* 
 
 if @extPlan <> '' 
  begin 
 
   if exists (Select * 
              from   contrato..Pla
n1 
              where  PlaCodPla_id = @extPlan 
                and  PlaFamPla_ta = 'INMECA' ) 
    begin 
     Select @extApellidoPat        = '', 
            @extApellidoMat        = '', 
            @extNombres            = '', 
            @extSexo
               = '', 
            @extFechaNacimi        = '19000101', 
            @extCodEstBen          = '', 
            @extDescEstado         = '', 
            @extRutCotizante       = '0000000000-0', 
            @extNomCotizante       = '', 
   
         @extDirPaciente        = '', 
            @extGlosaComuna        = '', 
            @extGlosaCiudad        = '', 
            @extPrevision          = '', 
            @extCodEstBen          = 'B', 
            @extDescEstado         = 'BLOQUEADO
', 
            @extGlosa              = 'TRANSACCION INCOMPLETA/ASISTIR A ISAPRE', 
            @extPlan               = '', 
            @extDescuentoxPlanilla = '', 
            @extMontoExcedente     = 0, 
            @ResCert               = 'BC' 
  
  end 
  end 
-- ** -------------------------------------------------------- 
 
 
*/ 
 
-- ** FR-9155 ------------------------------------------------- 
-- if @BenCriDer_ta is not null 
/* 
 
 if exists (Select 1 
            from   parametro..Msj_Auditor
ia 
                  ,parametro..Msj_Autorizados 
            where  MsaTipPer_id = 'CO' 
              and  MsaRutPer_id = @RutCotizante 
              and  MauTipPer_id = MsaTipPer_id 
              and  MauRutPer_id = MsaRutPer_id 
              and  
MauCorMen_id = MsaCorMen_id 
              and  MauNomExe_id = 'ASISTA_FRONT.EXE' 
              and  MauNivCon_re = 'DE') 
 begin 
   Select @extApellidoPat        = '', 
          @extApellidoMat        = '', 
          @extNombres            = '', 
   
       @extSexo               = '', 
          @extFechaNacimi        = '19000101', 
          @extCodEstBen          = '', 
          @extDescEstado         = '', 
          @extRutCotizante       = '0000000000-0', 
          @extNomCotizante       = '',
 
          @extDirPaciente        = '', 
          @extGlosaComuna        = '', 
          @extGlosaCiudad        = '', 
          @extPrevision          = '', 
          @extCodEstBen          = 'B', 
          @extDescEstado         = 'BLOQUEADO', 
   
       @extGlosa              = 'TRANSACCION INCOMPLETA/ASISTIR A ISAPRE', 
          @extPlan               = '', 
          @extDescuentoxPlanilla = '', 
          @extMontoExcedente     = 0, 
          @ResCert               = 'BB' 
  end 
 
*/ 
 
/* 

 if @Marca = 'VP' 
  begin 
    Select @extCodEstBen          = 'B', 
           @extDescEstado         = 'BLOQUEADO', 
           @extGlosa              = 'TRANSACCION INCOMPLETA/ASISTIR A ISAPRE', 
           @ResCert               = 'BB' 
  end 
*/ 
be
gin tran 
 
     update ContadorFolio 
     set    CfoNumFol_nn = CfoNumFol_nn - 1 
     where  CfoCodMar_id = 'IN' 
     And    CfoTipDoc_fl = 'LOCE' 
 
     select @Folio = CfoNumFol_nn 
     from   ContadorFolio 
     where  CfoCodMar_id = 'IN' 
     a
nd    CfoTipDoc_fl = 'LOCE' 
 
   commit tran 
 
 
 begin tran 
 
 if @BenDvBen_cr  is null Select @BenDvBen_cr   = '0' 
 if @BenDvCot_cr  is null Select @BenDvCot_cr   = '0' 
 if @RutCotizante is null Select @RutCotizante  = 0 
 if @NroContrato  is null 
Select @NroContrato   = 0 
 if @extPlan      is null Select @extPlan       = '' 
 
 insert Log_Certificaciones 
       (LceCorCer_id, LceMarBen_ta, LceRutBen_ta, LceFecCer_fc, LceDveBen_cr, 
        LceRutCon_ta, LceDveCon_cr, LceNumCon_ta, LceCodPla_ta, 

        LceResCer_re) 
 values (@Folio, @Marca,        @RutBen,      getdate(),    @BenDvBen_cr, 
         @RutCotizante, @BenDvCot_cr, @NroContrato, @extPlan, 
         @ResCert) 
 
 if @@error != 0 
  begin 
   rollback tran 
   Select @extApellidoPat 
       = '', 
          @extApellidoMat        = '', 
          @extNombres            = '', 
          @extSexo               = '', 
          @extFechaNacimi        = '19000101', 
          @extCodEstBen          = '', 
          @extDescEstado         
= '', 
          @extRutCotizante       = '0000000000-0', 
          @extNomCotizante       = '', 
          @extDirPaciente        = '', 
          @extGlosaComuna        = '', 
          @extGlosaCiudad        = '', 
          @extPrevision          = '
', 
          @extCodEstBen          = 'B', 
          @extDescEstado         = 'BLOQUEADO', 
          @extGlosa              = 'Error en grabacion de Log', --'Error: grabar <Log> de certif. Benef.', 
          @extPlan               = '', 
          @ex
tDescuentoxPlanilla = '', 
          @extMontoExcedente     = 0 
 
   return 1 
  end 
 
 commit tran 
 
 if (Select count(*) 
     From tempdb02..IBC_Autorizados 
     where spid = @@spid) <= 0 
  begin 
   Select  extRutAcompanante    = '0000000000-0', 

           extNombreAcompanante = '' 
  end 
 else 
  begin 
   Select  extRutAcompanante    = replicate('0',12 - char_length(ltrim(rtrim(extRutAcompanante))))+ 
                                  ltrim(rtrim(extRutAcompanante)), 
           extNombreAcom
panante 
   From    tempdb02..IBC_Autorizados 
   where   spid = @@spid 
  end 
 
 --// si esta certificado se verifica existencia de casos GES
 if @extCodEstBen = 'C' 
 begin
    --// obtener codigo de carga que identifica al beneficiario
    Select  @vl
dBenCodCar = BenCorCar_id
    from   contrato..Beneficiario 
    where  BenRutBen_nn = @RutBen 
      and  BenRutCot_id = @RutCotizante
      and  BenMarCon_id = @Marca 
      and  BenNumCto_id = @NroContrato
      and  BenIniVig_fc <= @Hoy 
      and  Be
nTerVig_fc >= @Hoy 
     
    /* de uso temporal debido a IMED */
    if (getdate() < '10/03/2011')
       return 1


    if exists(Select 1
              from prestacion..Evento_CAEC 
                  ,prestacion..ControlEstadoProceso 
                 
 ,prestacion..GES_GrupoEvento
              where EcaMarCon_ta = @Marca 
                and EcaRutCon_ta = @RutCotizante
                and EcaNumCto_ta = @NroContrato
                and EcaIteBen_ta = @vldBenCodCar
                and EcaTipCob_re = '
GE'      -- GES 
                and EcaNumEve_id  > 50000
                and isNull(EcaFecAlt_fc, @HoyMasUno) >= @Hoy
                and isNull(EcaEstAlt_re, '') <> 'AD'
                and CepIdePro_id = 'BC' 
                and CepIdeDoc_id = EcaNum
Eve_id 
                and CepEstAct_re = 'PE'
                and CepCodEst_id = 'AU'
                and GevFolEve_id = EcaNumEve_id 
                and GevEstAut_id = 'VI'
                and GevFecIni_fc <= @Hoy
                and isNull(GevFecTer_
fc, @HoyMasUno) >= @Hoy)
       Set @extCodEstBen = 'G'
 end
 
 return 1 
 
end

                                                                                                                                                                              
(137 rows affected)
(return status = 0)
1> 
