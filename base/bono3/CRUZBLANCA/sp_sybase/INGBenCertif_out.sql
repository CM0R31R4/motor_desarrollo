locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
119
(1 row affected)
text

create procedure dbo.INGBenCertif_out 
( 
 @extCodFinanciador     smallint, 
 @extRutBeneficiario    char(12), 
 @extFechaActual        datetime, 
 @extApellidoPat        char(30)      output, 
 @extApellidoMat        char(30)      output, 
 @extNombres 
   char(40)      output, 
 @extSexo               char(1)       output, 
 @extFechaNacimi        datetime      output, 
 @extCodEstBen          char(1)       output, 
 @extDescEstado         char(15)      output, 
 @extRutCotizante       char(12)      out
put, 
 @extNomCotizante       char(40)      output, 
 @extDirPaciente        char(40)      output, 
 @extGlosaComuna        char(30)      output, 
 @extGlosaCiudad        char(30)      output, 
 @extPrevision          char(1)       output, 
 @extGlosa    
          char(40)      output, 
 @extPlan               char(15)      output, 
 @extDescuentoxPlanilla char(1)       output, 
 @extMontoExcedente     numeric(10,0)   output 
) 
/* 
  -- ** -----------------------------------------------------------------
-------------------- 
   procedimiento : INGBenCertif_out 
   Autor         : Cristian Rivas Rivera. 
  -- ** ------------------------------------------------------------------------------------- 
   Modificado    : Mauricio Cosgrove 
   Objetivo      : F
R-9155 
  -- ** ------------------------------------------------------------------------------------- 
   Modificado    : Marcelo Herrera 
   Modificado el : Octubre de 2006 
   Objetivo      : FR-14465, cuando no existe Beneficiario registrado en ING dev
olver estado R 
  -- ** ------------------------------------------------------------------------------------- 
   Modificado    : Marcelo Herrera 
   Modificado el : Febrero de 2007 
   Objetivo      : FR-19057, informar excedente disponible para posible 
uso como copago 
  -- ** ------------------------------------------------------------------------------------- 
   Modificado    : Mauricio Cosgrove 
   Modificado el : 04/06/2007 
   Objetivo      : FR-19057, Controlar el uso de pgo con excedente 
  -- *
* ------------------------------------------------------------------------------------- 
   Modificado    : Marcelo Herrera
   Modificado el : Junio 2008
   Objetivo      : FR-31792, Proyecto Multimarca, valor por defecto de marca cuando financiador
     
              es Normedica debe ser NM.
                   Se controla que financiador y beneficiario presenten el mismo codigo de 
                   asegurador.
  -- ** ------------------------------------------------------------------------------------
- 
   Modificado    : Marcelo Herrera
   Modificado el : Noviembre de 2010
   Objetivo      : FR- 2979, direccion de cotizante debe obtenerse desde tabla DireccionContacto.
  -- ** --------------------------------------------------------------------------
----------- 
   Modificado    : Marcelo Herrera
   Modificado el : Septiembre de 2013
   Objetivo      : FR-9116, se modifica valor guardado de plan en tabla de log para diferenciar
                   log de servicio respecto a consulta directa desde el p
restador.
  -- ** ------------------------------------------------------------------------------------- 


 
 
   Parametros I 
      @extCodFinanciador   : Código del Financiador 
      @extRutBeneficiario  : RUT del Beneficiario 
      @extFechaActual  
    : Fecha de Referencia 
 
   ------------------------ 
   |Servicios para C-Salud | 
   ------------------------ 
 
   Descripción 
 
   Este Servicio se encarga de certificar la existencia del beneficiario, en la base del financiador 
   (CB,AS), y de
 retornar información de este; entre otros la aceptación o bloqueo, vigencias, plan, 
   etc. En caso de menores de edad se debe devolver en caso de ser requeridos la lista de acompañantes 
   validos asociados al beneficiario. 
 
   Prueba 
 
   declare 
 @extCodFinanciador     smallint, 
            @extRutBeneficiario    char(12), 
            @extFechaActual        datetime, 
            @extApellidoPat        char(30), 
            @extApellidoMat        char(30), 
            @extNombres            c
har(40), 
            @extSexo               char(1) , 
            @extFechaNacimi        datetime, 
            @extCodEstBen          char(1) , 
            @extDescEstado         char(15), 
            @extRutCotizante       char(12), 
            @ex
tNomCotizante       char(40), 
            @extDirPaciente    char(40), 
            @extGlosaComuna        char(30), 
            @extGlosaCiudad        char(30), 
            @extPrevision          char(1) , 
            @extGlosa              char(40),
 
            @extPlan               char(15), 
            @extDescuentoxPlanilla char(1), 
            @extMontoExcedente     numeric(10) 
 
   exec prestacion..INGBenCertif_out 78, '5194193-4', '04/16/2001', 
                                @extApellid
oPat output,  @extApellidoMat output, 
                                @extNombres output,      @extSexo output, 
                                @extFechaNacimi output,  @extCodEstBen output, 
                                @extDescEstado output,   @ext
RutCotizante output, 
                                @extNomCotizante output, @extDirPaciente output, 
                                @extGlosaComuna output,  @extGlosaCiudad output, 
                                @extPrevision output,    @extGlosa ou
tput, 
                                @extPlan output,         @extDescuentoxPlanilla output, 
                                @extMontoExcedente output 
 
 Select * from prestacion..Log_Certificaciones 
 
*/ 
As 
declare @FechaEntrada      fecha, 
     
   @Hoy               fecha, 
        @Marca             marca, 
        @RutBen            rut, 
        @NroContrato       contrato, 
        @RutCotizante      rut, 
        @LocaDir           localidad, 
        @TerLic_fc         fecha, 
        @Tip
Ter_re         regla, 
        @BenIniVig_fc      fecha, 
        @BenTerVig_fc      fecha, 
        @Sucripcion        fecha, 
        @IanBen_pe         fecha, 
        @TanBnf_pe         fecha, 
        @ErrorCode         int, 
        @BenDvCot_cr    
   dv, 
        @BenDvBen_cr       dv, 
        @ResCert           regla, 
        @BenCriDer_ta      char(2), 
        @FechaCny          fecha, 
        @TipPla            regla, 
        @RutCny            rut, 
        @ContratoCny       contrato, 
  
      @NroFilas          int, 
        @db_name           char(30), 
        @Folio             int, 
        @Result_Exe        int, 
        @Exc_Contable      int,
        @MarcaFinanciador  marca
 
 
begin 
 delete tempdb02..IBC_Autorizados 
 where sp
id = @@spid 
 
 delete tempdb02..IBC_Beneficiarios 
 where spid = @@spid 
 
 delete tempdb02..IBC_DatosConyuge 
 where spid = @@spid 
 
 Select @db_name = db_name() 
 
 Select @extApellidoPat        = '', 
        @extApellidoMat        = '', 
        @ex
tNombres            = '', 
        @extSexo               = '', 
        @extFechaNacimi        = '19000101', 
        @extCodEstBen          = '', 
        @extDescEstado         = '', 
        @extRutCotizante       = '0000000000-0', 
        @extNomCot
izante       = '', 
        @extDirPaciente        = '', 
        @extGlosaComuna        = '', 
        @extGlosaCiudad        = '', 
        @extPrevision          = '', 
        @extPlan               = '', 
        @extDescuentoxPlanilla = '', 
       
 @extMontoExcedente     = 0 
 
 Select @FechaEntrada = convert(smalldatetime,convert(char(10),@extFechaActual,101)) 
 Select @Hoy      = convert(smalldatetime,convert(char(10),getdate(),101)) 
 
 if @extCodFinanciador = 74 Select @Marca = 'AS' 
 if @extCo
dFinanciador = 78 Select @Marca = 'CB' 
 if @extCodFinanciador = 70 Select @Marca = 'NM' 
 
 Select @MarcaFinanciador = MarEmpIsa_cr
 from parametro..Marca
 where MarCodMar_id = @Marca
 
 Select @RutBen = convert(int,substring(ltrim(rtrim(@extRutBeneficia
rio)),1,charindex('-',ltrim(rtrim(@extRutBeneficiario)))-1)) 
 
 if @FechaEntrada = @Hoy  --//Se ha Solicitado verificacion para la venta de un bono al dÝa 
  begin 
 
   -- ** ¿existe beneficiario? 
   if Not Exists(Select BenRutBen_nn from contrato..Ben
eficiario where BenRutBen_nn  = @RutBen) 
   begin 
      Select 
             @extCodEstBen  = 'R', 
             @extDescEstado = 'NO EXISTE EN BD', 
             @extGlosa      = 'RUT de benef.  no existe', 
             @ResCert       = 'IN' 
      be
gin tran 
 
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
            LceRutCon_ta, LceDveCon_cr, LceNumCon_ta, LceCod
Pla_ta, 
            LceResCer_re) 
      values (@Folio, @Marca, @RutBen, getdate(), '0', 
             0, '0', 0, 'A2', @ResCert) 
      if @@error != 0 
      begin 
         rollback tran 
         return 1 
      end 
 
      commit tran 
      retur
n 1 
   end 
 
 
   insert  tempdb02..IBC_Beneficiarios 
   Select  @@spid, 
           BenRutBen_nn, BenMarCon_id, BenIniVig_fc, BenTerVig_fc, 
           BenApePat_ds, BenApeMat_ds, BenNom_ds,    BenSex_fl, 
           BenFecNac_fc, BenNumCto_id, BenRut
Cot_id, BenDvCot_cr, 
           BenDvBen_cr,  BenCriDer_ta 
   from   contrato..Contrato 
          ,contrato..Beneficiario 
   where  BenRutBen_nn = @RutBen 
     and  BenRutCot_id = ConRutCot_id 
     and  BenMarCon_id = ConMarCon_id 
     and  BenNumC
to_id = ConNumCto_id 
     and  BenIniVig_fc <= @Hoy 
     and  BenTerVig_fc >= @Hoy 
 
   Select @NroFilas = @@rowcount 
 
   if @NroFilas <> 1 
   begin 
      if @NroFilas = 0 
         Select 
              @extCodEstBen  = 'B', 
              @extDes
cEstado = 'BENF. SIN CTO.VIG.', 
              @extGlosa      = 'RUT de benef. sin Cto. Vig.', 
              @ResCert       = 'IN' 
      else  --  @NroFilas > 1 
         Select 
              @extCodEstBen  = 'X', 
              @extDescEstado = 'INCON
SISTENTE', 
              @extGlosa      = 'Benef. vig. en más de un cto.', --'TRANSACCION INCOMPLETA/ASISTIR A ISAPRE' 
              @ResCert       = 'MC' 
 
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
 
      i
nsert Log_Certificaciones 
           (LceCorCer_id, LceMarBen_ta, LceRutBen_ta, LceFecCer_fc, LceDveBen_cr, 
            LceRutCon_ta, LceDveCon_cr, LceNumCon_ta, LceCodPla_ta, 
            LceResCer_re) 
      values (@Folio, @Marca,        @RutBen,    
  getdate(),    '0', 
             0, '0', 0, 'A2', @ResCert) 
 
      if @@error != 0 
      begin 
         rollback tran 
         return 1 
      end 
 
      commit tran 
 
      return 1 
    end 
   else --// Beneficiario fue encontrado. 
    begin
 
 
     Select @extApellidoPat        = ltrim(rtrim(BenApePat_ds)), 
            @extApellidoMat    = ltrim(rtrim(BenApeMat_ds)), 
            @extNombres            = ltrim(rtrim(BenNom_ds)), 
            @extSexo               = case BenSex_fl 
       
                               when 'N' then 'M' 
                                      else  BenSex_fl 
                                end, 
            @extFechaNacimi        = BenFecNac_fc, 
            @NroContrato           = BenNumCto_id, 
        
    @RutCotizante          = BenRutCot_id, 
            @BenIniVig_fc          = BenIniVig_fc, 
            @BenTerVig_fc          = BenTerVig_fc, 
            @BenDvCot_cr           = BenDvCot_cr, 
            @BenDvBen_cr           = BenDvBen_cr, 
     
       @BenCriDer_ta          = NULL, --//BenCriDer_ta, 
            @Marca                 = BenMarCon_id 
     from   tempdb02..IBC_Beneficiarios 
     where  spid         = @@spid 
       and  BenRutBen_nn = @RutBen 
       and  BenIniVig_fc <= @Hoy 
 
      and  BenTerVig_fc >= @Hoy 
 
     -- Control del financiador v/s asegurador de beneficiario
     if Not Exists(Select 1 from parametro..Marca where MarCodMar_id  = @Marca and MarEmpIsa_cr = @MarcaFinanciador) 
     begin 
          Select @extCodEst
Ben   = 'X', 
                 @extDescEstado  = 'NO EXISTE EN BD', 
                 @extGlosa       = 'Codigo Financiador Erroneo', 
                 @ResCert        = 'NV' 

          begin tran 
 
          update ContadorFolio 
          set    CfoNu
mFol_nn = CfoNumFol_nn - 1 
          where  CfoCodMar_id = 'IN' 
          And    CfoTipDoc_fl = 'LOCE' 
 
          select @Folio = CfoNumFol_nn 
          from   ContadorFolio 
          where  CfoCodMar_id = 'IN' 
          and    CfoTipDoc_fl = 'LOCE
' 
 
          commit tran 
          begin tran 
 
          insert Log_Certificaciones 
           (LceCorCer_id, LceMarBen_ta, LceRutBen_ta, LceFecCer_fc, LceDveBen_cr, 
            LceRutCon_ta, LceDveCon_cr, LceNumCon_ta, LceCodPla_ta, 
            L
ceResCer_re) 
          values (@Folio, @Marca, @RutBen, getdate(), '0', 
             0, '0', 0, 'A2', @ResCert) 
          if @@error != 0 
          begin 
               rollback tran 
               return 1 
          end 
 
          commit tran 
 
         return 1 
     end 
 
     Select @extRutCotizante = replicate('0',12 - char_length(ltrim(rtrim(convert(char(10),BenRutCot_id)))+'-'+ltrim(rtrim(BenDvCot_cr))))+ 
                               ltrim(rtrim(convert(char(10),BenRutCot_id)))+'-'+ltr
im(rtrim(BenDvCot_cr)), 
            @extNomCotizante = ltrim(rtrim(BenApePat_ds))+' '+ 
                               ltrim(rtrim(BenApeMat_ds))+' '+ 
                          ltrim(rtrim(BenNom_ds)) 
     from contrato..Beneficiario 
     where  BenRu
tCot_id = @RutCotizante 
       and  BenNumCto_id = @NroContrato 
       and  BenCorCar_id = '00' 
       and  BenMarCon_id = @Marca 
 
     Select @extPrevision = case ConTipTra_fl 
                             when '1' then 'D' 
                        
     when '2' then 'I' 
                             when '3' then 'P' 
                             when '4' then 'V' 
                            end, 
            @extPlan               = case 
                                      when ((ConIniPAn_pe 
<= @Hoy)and(@Hoy < ConIniPla_pe)) then ConPlaAnt_ta 
                                      when ConIniPla_pe <= @Hoy then ConPlaVig_ta 
                                      else 'PLAN NOFOUND' 
                                     end, 
            @extD
escuentoxPlanilla = 'N', 
            -- @extMontoExcedente     =   0,  -- a calcular Fr 13565 
            @Sucripcion            = ConSus_fc, 
            @IanBen_pe             = ConIanBen_pe, 
         @TanBnf_pe             = ConTanBnf_pe, 
         
   @TerLic_fc             = ConTerLic_fc, 
      @TipTer_re             = ConTipTer_re 
     From   contrato..Contrato 
     where  ConRutCot_id = @RutCotizante 
       and  ConNumCto_id = @NroContrato 
       and  ConMarCon_id = @Marca 
 
     -- ** ----
------------ inicio  FR 19057 
     -- ** ---- Incluye Control administrativo para Excedentes 
    declare 
       @ValAtr char(255) 
 
    set @extMontoExcedente = 0 
    exec prestacion..RME_Sel_RegAdm 'RM',7,1,@ValAtr output 
    if rtrim(@ValAtr) = 'S
I'   -- Habilitado para operar con Excedentes 
     begin 
          exec @Result_Exe = ingreso..SelSaldoDispContExcedente 
                                 @RutCotizante 
                                ,'IN' 
                                ,@extMontoEx
cedente output 
                                ,@Exc_Contable      output 
                                ,null 
 
          if (@@Error <> 0 or @Result_Exe < 0 or @extMontoExcedente < 0) 
            set @extMontoExcedente = 0 
          if @extMontoEx
cedente is null 
            set @extMontoExcedente = 0 
      end 
     -- ** ------------------  fin FR 19057 
 
     select  top 1
             @extDirPaciente = ltrim(rtrim(DIR_CALLE_DS)) + case when DIR_NUMERO_DS = '99999     ' then '' else +' #'+ lt
rim(rtrim(DIR_NUMERO_DS)) end +' '+    
                               isNull(ltrim(rtrim(DIR_RESTO_DS)), '')
            ,@LocaDir        = DIR_COD_LOC_TA
     from contrato..DireccionContacto 
     Where DIR_RUT_PER_ID = @RutCotizante
       and DIR_TIP
_DIR_ID = 'PA'
     order by DIR_COR_DIR_ID desc
     
     if @LocaDir is Null
        Select @extDirPaciente = ltrim(rtrim(DirDir_ds))+' '+ltrim(rtrim(DirSecDir_ds)), 
               @LocaDir        = DirLoc_ta 
        from   contrato..Direccion 
     
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
 
     --// Se entiende por autorizados a car
gas de un contrato mßs el cotizante y 
     --// en el caso de los contratos matrimoniales, tambien al conyuge y sus cargas. 
 
     insert tempdb02..IBC_Autorizados 
     Select @@spid, 
            ltrim(rtrim(convert(char(12),BenRutBen_nn)))+'-'+BenDvB
en_cr, 
            ltrim(rtrim(BenApePat_ds))+' '+ 
            ltrim(rtrim(BenApeMat_ds))+' '+ 
            ltrim(rtrim(BenNom_ds)) 
     From   contrato..Beneficiario 
     where BenRutCot_id = @RutCotizante 
       and  BenNumCto_id = @NroContrato 
  
     and  BenMarCon_id = @Marca 
       and  BenIniVig_fc <= @Hoy 
       and  ((BenTerVig_fc >= @Hoy) or (BenTerVig_fc is null)) 
 
     Select @TipPla = ConTipPla_cr, 
            @RutCny = ConRutCny_nn 
     From   contrato..Contrato 
     where  ConRu
tCot_id = @RutCotizante 
       and  ConNumCto_id = @NroContrato 
       and  ConMarCon_id = @Marca 
 
     if ((@TipPla = 'MA')and(@RutCny > 0)and(@RutCny is not null)) 
      begin 
 
       insert  tempdb02..IBC_DatosConyuge 
       Select  @@spid, Ben
MarCon_id, BenNumCto_id, BenRutCot_id, 
               BenDvCot_cr,  BenIniVig_fc, BenTerVig_fc 
       from    contrato..Beneficiario 
       where   BenRutCot_id = @RutCny 
 
       Select @ContratoCny = BenNumCto_id 
       from   tempdb02..IBC_DatosCo
nyuge 
       where  spid         = @@spid 
         and  BenRutCot_id = @RutCny 
         and  BenMarCon_id = @Marca 
         and  BenIniVig_fc <= @Hoy 
         and  BenTerVig_fc >= @Hoy 
 
       if @@rowcount > 0 
        begin 
 
         insert tem
pdb02..IBC_Autorizados 
         Select @@spid, 
                ltrim(rtrim(convert(char(12),BenRutBen_nn)))+'-'+BenDvBen_cr, 
                ltrim(rtrim(BenApePat_ds))+' '+ 
                ltrim(rtrim(BenApeMat_ds))+' '+ 
                ltrim(rtrim(B
enNom_ds)) 
         From   contrato..Beneficiario 
         where  BenRutCot_id = @RutCny 
           and  BenNumCto_id = @ContratoCny 
           and  BenMarCon_id = @Marca 
           and  BenIniVig_fc <= @Hoy 
           and  ((BenTerVig_fc >= @Hoy) o
r (BenTerVig_fc is null)) 
 
        end 
 
      end --// Si contrato es MAtrimonial 
 
     --// VALIDACION DE OTORGAMIENTO DE BENEFICIOS 
 
     if ((@IanBen_pe <= @Hoy)and(@Hoy <= @TanBnf_pe)) 
      begin 
       if ((@BenIniVig_fc <= @Hoy)and(@Hoy  
<= @BenTerVig_fc)) 
        begin 
          Select @extCodEstBen          = 'C', 
                 @extDescEstado         = 'CERTIFICADO', 
                 @extGlosa              = '', 
                 @ResCert               = 'CE' 
        end 
      
 else 
        begin 
          Select @extCodEstBen          = 'X', 
                @extDescEstado         = 'NO VIGENTE', 
                 @extGlosa              = 'Benef. no vigente', 
                 @ResCert               = 'NV' 
        end 
    
  end 
     else 
      begin 
       if((dateadd(mm,2,@Sucripcion) <= @Hoy)and(@Hoy < @IanBen_pe)) 
        begin 
         if ((@BenIniVig_fc <= @Hoy)and(@Hoy  <= @BenTerVig_fc)) 
          begin 
           Select @extCodEstBen  = 'C', 
               
   @extDescEstado         = 'CERTIFICADO', 
                  @extGlosa              = '', 
                  @ResCert            = 'CE' 
          end 
         else 
          begin 
           Select @extCodEstBen          = 'X', 
                  @ex
tDescEstado         = 'NO VIGENTE', 
                 @extGlosa              = 'Benef. no vigente', 
                  @ResCert               = 'NV' 
          end 
        end 
       else 
        begin 
         if @TerLic_fc is not null 
          beg
in 
           Select @extCodEstBen          = 'X', 
                  @extDescEstado         = 'NO VIGENTE', 
                 @extGlosa              = 'Benef. no vigente', 
                  @ResCert               = 'NV' 
          end 
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
                 /
* 
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
                   Select @extC
odEstBen        = 'X', 
                     @extDescEstado       = 'INCONSISTENTE', 
                          @extGlosa            = 'TRANSACCION INCOMPLETA/ASISTIR A ISAPRE', 
                          @ResCert             = 'LI' 
                  end
 
                end 
                -- ** ------------------------------------------------------- 
                */ 
            end 
           else 
            begin 
             Select @extCodEstBen          = 'X', 
                    @extDescE
stado         = 'NO VIGENTE', 
                    @extGlosa              = 'Benef. no vigente', 
                    @ResCert      = 'NV' 
            end 
          end 
        end 
 
      end 
 
     -- ** FR-9155 ------------------------------------
------------------------------ 
     --// VERIFICACION DE SITUACION DE MORA 
     /* 
     declare @EstaEnMora  char(1), @ImpCertificado char(1), @Gestionable char(1), 
             @BloqueoxCob char(1), @ContadorEnt    int 
 
     --//exec @ErrorCode = i
ngreso..Verifica_MoraCot @RutCotizante, @BenDvCot_cr, 
     exec @ErrorCode = ingreso..Verifica_MoraIMED @RutCotizante, @BenDvCot_cr, 
                                                  @Marca, @NroContrato, 
                                               
   'CSALUD00', '130001', 
                                                  @EstaEnMora     output, 
                                                  @ImpCertificado output, 
                                                  @Gestionable    output, 
    
                                              @BloqueoxCob    output, 
                                                  @ContadorEnt    output 
     if @EstaEnMora = 'S' 
      begin 
       Select @extCodEstBen     = 'X', 
              @extDescEstado  
  = 'ERROR CONTRATO', 
            @extGlosa         = 'TRANSACCION INCOMPLETA/ASISTIR A ISAPRE', 
            @ResCert            = 'MO' 
      end 
    */ 
 
 
    end --// Fin de Beneficiario Encontrado 
  end 
 else 
  begin --// (DÝa distinto a Hoy, 
Se ha Solicitado verificacion para la venta de un bono retroactivo 
 
   Select @extApellidoPat        = '', 
          @extApellidoMat        = '', 
          @extNombres            = '', 
          @extSexo               = '', 
          @extFechaNacimi
        = '19000101', 
          @extCodEstBen          = '', 
          @extDescEstado         = '', 
          @extRutCotizante       = '0000000000-0', 
          @extNomCotizante       = '', 
          @extDirPaciente        = '', 
          @extGlosaC
omuna        = '', 
          @extGlosaCiudad        = '', 
          @extPrevision          = '', 
          @extCodEstBen          = 'B', 
          @extDescEstado         = 'FECHA DIA ERRONEA', 
          @extGlosa              = 'Benef. no vigente', -
-'Fecha vta. no corresponde al dia de hoy.' 
          @extPlan               = '', 
          @extDescuentoxPlanilla = '', 
          @extMontoExcedente      = 0, 
          @ResCert               = 'FI' 
  end 
 
-- ** ----------------------------------
---------------------- 
-- FR-7787 - Control de Vta. IMED para CMF 
-- Este control se manejará en el servicio : prestacion..ingcoptran 
 
/* 
 
 if @extPlan <> '' 
  begin 
 
   if exists (Select * 
              from   contrato..Plan1 
              whe
re  PlaCodPla_id = @extPlan 
                and  PlaFamPla_ta = 'INMECA' ) 
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
            @extDirPacie
nte        = '', 
            @extGlosaComuna        = '', 
            @extGlosaCiudad        = '', 
            @extPrevision          = '', 
            @extCodEstBen          = 'B', 
            @extDescEstado         = 'BLOQUEADO', 
            @extG
losa              = 'TRANSACCION INCOMPLETA/ASISTIR A ISAPRE', 
            @extPlan               = '', 
            @extDescuentoxPlanilla = '', 
            @extMontoExcedente     = 0, 
            @ResCert               = 'BC' 
    end 
  end 
-- ** -
------------------------------------------------------- 
 
 
*/ 
 
 
-- ** FR-9155 --------------------------------------------------------- 
-- if @BenCriDer_ta is not null 
/* 
 if exists (Select 1 
            from   parametro..Msj_Auditoria 
         
         ,parametro..Msj_Autorizados 
            where  MsaTipPer_id = 'CO' 
              and  MsaRutPer_id = @RutCotizante 
              and  MauTipPer_id = MsaTipPer_id 
              and  MauRutPer_id = MsaRutPer_id 
              and  MauCorMen_id 
= MsaCorMen_id 
              and  MauNomExe_id = 'ASISTA_FRONT.EXE' 
              and  MauNivCon_re = 'DE') 
 begin 
   Select @extApellidoPat        = '', 
          @extApellidoMat        = '', 
          @extNombres            = '', 
          @extSe
xo               = '', 
          @extFechaNacimi        = '19000101', 
          @extCodEstBen          = '', 
          @extDescEstado         = '', 
          @extRutCotizante       = '0000000000-0', 
          @extNomCotizante       = '', 
          @
extDirPaciente        = '', 
          @extGlosaComuna        = '', 
          @extGlosaCiudad        = '', 
          @extPrevision          = '', 
          @extCodEstBen          = 'B', 
          @extDescEstado         = 'BLOQUEADO', 
          @extGl
osa              = 'TRANSACCION INCOMPLETA/ASISTIR A ISAPRE', 
          @extPlan               = '', 
          @extDescuentoxPlanilla = '', 
          @extMontoExcedente     = 0, 
          @ResCert               = 'BB' 
  end 
 
*/ 
 
 
/* 
 if @Marca 
= 'VP' 
  begin 
    Select @extCodEstBen          = 'B', 
           @extDescEstado         = 'BLOQUEADO', 
           @extGlosa              = 'TRANSACCION INCOMPLETA/ASISTIR A ISAPRE', 
           @ResCert               = 'BB' 
  end 
*/ 
begin tran 
 

     update ContadorFolio 
     set    CfoNumFol_nn = CfoNumFol_nn - 1 
     where  CfoCodMar_id = 'IN' 
     And    CfoTipDoc_fl = 'LOCE' 
 
     select @Folio = CfoNumFol_nn 
     from   ContadorFolio 
     where  CfoCodMar_id = 'IN' 
     and    CfoTi
pDoc_fl = 'LOCE' 
 
   commit tran 
 
 
 begin tran 
 
 if @BenDvBen_cr  is null Select @BenDvBen_cr   = '0' 
 if @BenDvCot_cr  is null Select @BenDvCot_cr   = '0' 
 if @RutCotizante is null Select @RutCotizante  = 0 
 if @NroContrato  is null Select @Nro
Contrato   = 0 
 if @extPlan      is null Select @extPlan       = '' 
 
 insert Log_Certificaciones 
       (LceCorCer_id, LceMarBen_ta, LceRutBen_ta, LceFecCer_fc, LceDveBen_cr, 
        LceRutCon_ta, LceDveCon_cr, LceNumCon_ta, LceCodPla_ta, 
        Lc
eResCer_re) 
 values (@Folio, @Marca,        @RutBen,      getdate(),    @BenDvBen_cr, 
         @RutCotizante, @BenDvCot_cr, @NroContrato, 'A2', 
         @ResCert) 
 
 if @@error != 0 
  begin 
   rollback tran 
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
          @
extCodEstBen          = 'B', 
          @extDescEstado         = 'BLOQUEADO', 
          @extGlosa              = 'Error en grabacion de Log', 
          @extPlan               = '', 
          @extDescuentoxPlanilla = '', 
          @extMontoExcedente   
  = 0 
 
   return 1 
  end 
 
 commit tran 
end
                                                                                                                                                                                                              
(119 rows affected)
(return status = 0)
1> 