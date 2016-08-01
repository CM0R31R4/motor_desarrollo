locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
28
(1 row affected)
text
create procedure dbo.INGLeeRutCotiz
(
 @extCodFinanciador     smallint,
 @extRutCotizante       char(12),
 @extNomCotizante       char(40)  output,
 @extCodError           char(1)   output,
 @extMensajeError       char(30)  output
)
/*
   procedimiento : 
INGLeeRutCotiz
   Autor         : Cristian Rivas Rivera.
   Parametros I
      @extCodFinanciador   : Código del Financiador
      @extRutBeneficiario  : RUT del Beneficiario

   ------------------------
   |Servicios para C-Salud |
   -------------------
-----

   Descripción

   Obtiene la Lista de Cargas del contrato vigente al día de Hoy.

   Prueba

   declare
    @extNomCotizante       char(40),
    @extCodError           char(1),
    @extMensajeError       char(30)

    exec prestacion..INGLeeRutCotiz 78, '0005308213-0', @extNomCotizante output, @extCodError output, @extMensajeError output

*/
As
declare @FechaEntrada      fecha,
        @Hoy               fecha,
        @Marca             marca,
        @RutBen            rut,
        @NroContrato 	   contrato,
        @RutCotizante      rut,
        @ErrorCode         int,
        @HoyMasUno         fecha,
        @DigBen            dv,
        @RutCot            rut,
        @DigCot            dv,
        @Folio             int,
        @NroCto
            contrato,
        @Plan              codpla,
        @CodEstBen         regla,
        @Ok                flag
begin

 delete tempdb02..ILR_GrupoContrato
 where  spid = @@spid

 Select @Hoy       = convert(smalldatetime,convert(char(10),getdate(),101))
 Select @HoyMasUno = dateadd(dd,1,@Hoy)

 Select @RutBen = convert(int,substring(ltrim(rtrim(@extRutCotizante)),1,charindex('-',ltrim(rtrim(@extRutCotizante)))-1))

 exec   @ErrorCode = prestacion..INGSelConMar @RutBen, @Hoy, @HoyMasUno, @Marca output, @NroContrato output, @Ok output
 
if @Ok = 'N' or @ErrorCode != 0
  begin
   Select @extCodError = 'N'
   Select @extMensajeError = "TRX DENEGADA (EI:400382)"
   Select @Marca = 'XX'
   return 1
  end

 Select @extCodError     = 'N',
        @extMensajeError = 'COTIZANTE NO EXISTE'

 Select @extNomCotizante = convert(char(40),isnull(ltrim(rtrim(BenNom_ds))+' '+ ltrim(rtrim(BenApePat_ds))+' '+ ltrim(rtrim(BenApeMat_ds)),space(40))), @RutCotizante    = BenRutCot_id
 from   contrato..Beneficiario
 where  BenRutBen_nn = @RutBen
   and  BenNumCto_id = @NroContrato
   and  BenMarCon_id = @Marca
   and  BenIniVig_fc <= @Hoy
   and  BenTerVig_fc >= @Hoy

 if @@rowcount > 0 --// Beneficiario fue encontrado.
  begin

   insert tempdb02..ILR_GrupoContrato
   Select @@spid, convert(smallint,BenCorCar_id), convert(char(12), replicate('0', 12 - char_Length(ltrim(rtrim( convert(char(12),ltrim(rtrim(convert(char(12),BenRutBen_nn))) +'-'+isnull(BenDvBen_cr,'0')))))) +ltrim(rtrim(convert(char(12),ltrim(rtrim(convert(char(12),BenRutBen_nn)))+'-'+BenDvBen_cr)))), convert(char(30),ltrim(rtrim(BenApePat_ds))), convert(char(30),ltrim(rtrim(BenApe Mat_ds))), convert(char(40),ltrim(rtrim(BenNom_ds))),
          case
           when BenIniVig_fc <= @Hoy and BenTerVig_fc >= @Hoy then 'C'
           when BenIniVig_fc <= @Hoy and BenTerVig_fc is null then 'C'
           else 'X'
          end,
          case
           when BenIniVig_fc <= @Hoy and BenTerVig_fc >= @Hoy then 'CERTIFICADO'
           when BenIniVig_fc <= @Hoy and BenTerVig_fc is null then 'CERTIFICADO'
           else 'NO VIGENTE'
          end,
          BenMarCon_id, BenRutBen_nn, BenDvBen_cr,
          BenRutCot_id, BenDvCot_cr,  BenNumCto_id, NULL
   from   contrato..Beneficiario
   where  BenRutCot_id = @RutCotizante
     and  BenNumCto_id = @NroContrato
     and  BenMarCon_id = @Marca
     and  BenIniVig_fc <= @Hoy
     and  BenTerVig_fc >= @Hoy

   update tempdb02..ILR_GrupoContrato
      set extPlan = ConPlaVig_ta
   From   contrato..Contrato
   where  spid         = @@spid
     and  extRutCot    = @RutCotizante
     and  extNroCto    = @NroContrato
     and  extMarca   = @Marca
     and  ConRutCot_id = extRutCot
     and  ConNumCto_id = extNroCto
     and  ConMarCon_id = extMarca

   declare curFolLog cursor for
    Select extMarca, extRutBen,  extDigBen,
           extRutCot, extDigCot, extNroCto, extPlan, case extDescEstado when 'C' then 'RC' else  'RN' end
    From   tempdb02..ILR_GrupoContrato
    where  spid = @@spid
   for read only --// curFolLog

   Open curFolLog
   fetch curFolLog into @Marca, @RutBen, @DigBen, @RutCot, @DigCot, @NroCto, @Plan, @CodEstBen

   if @@sqlstatus = 1
    begin
     close curFolLog
     deallocate cursor curFolLog
     return 123456806
    end

   while @@sqlstatus = 0
    begin
     begin tran

     update ContadorFolio
     set    CfoNumFol_nn = CfoNumFol_nn - 1
     where  CfoCodMar_id = 'IN'
     And    CfoTipDoc_fl = 'LOCE'

     select @Folio = CfoNumFol_nn
     from   ContadorFolio
     where  CfoCodMar_id = 'IN'
     and    CfoTipDoc_fl = 'LOCE'

   insert prestacion..Log_Certificaciones
  
 Select @Folio, @Marca, @RutBen, getdate(), @DigBen, @RutCot, @DigCot, @NroCto, @Plan,
          case @CodEstBen
           when 'C' then 'RC'
           else  'RN'
          end

     if @@error != 0
      begin
       rollback tran
       Select @extCodError     = 'N',
              @extMensajeError = 'TRX DENEGADA (EI:400361)'
       return 1
      end

     commit tran

     fetch curFolLog into @Marca, @RutBen, @DigBen, @RutCot, @DigCot, @NroCto, @Plan, @CodEstBen
    end --// while @@sqlstatus = 0


   close curFolLog
   deallocate cursor curFolLog

 /*
   begin tran

   insert prestacion..Log_Certificaciones
   Select extMarca, extRutBen, getdate(), extDigBen,
          extRutCot, extDigCot, extNroCto, extPlan,
          case extCodEstBen
          
 when 'C' then 'RC'
           else  'RN'
          end
   From   tempdb02..ILR_GrupoContrato
   where  spid = @@spid

   if @@error != 0
   begin
    rollback tran
    Select @extCodError     = 'N',
           @extMensajeError = 'TRX DENEGADA (EI:400361)
'
    return 1
   end

   commit tran

 */

   Select @extCodError     = 'S',
          @extMensajeError = ''

  end
 else
  begin
   Select @extCodError     = 'N',
          @extMensajeError = 'COTIZANTE NO EXISTE'
   return 1
  end

 if @extCodError = 'S'
  begin

   Select  extCorrBenef,
           extRutBeneficiario,
           extApellidoPat,
           extApellidoMat,
           extNombres,
           extCodEstBen,
           extDescEstado
   From    tempdb02..ILR_GrupoContrato
   where   spid = @@spid

  end

 return 1
end

                                                                                                                                                                                                                                    
(28 rows affected)
(return status = 0)
1> 
