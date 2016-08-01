locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
31
(1 row affected)
text

create procedure dbo.INGBenRec
(
 @extCodFinanciador     smallint,
 @extRutCotizante       char(12),
 @extCorrBenef          smallint,
 @extRutBeneficiario    char(12),
 @extCodResBen          char(1)   output,
 @extMensajeError       char(30)  output
)

/*
   procedimiento : INGBenRec
   Autor         : Cristian Rivas Rivera.
   Parametros I
      @extCodFinanciador   : Código del Financiador
      @extRutBeneficiario  : RUT del Beneficiario
      @extCorrBenef        : Correlativo de Carga del Beneficia
rio
      @extRutBeneficiario  : Nuevo RUT del Beneficiario
   Parametros O
      @extCodResBen        : Codigo Estado Actualización
      @extMensajeError     : Mensaje de Error

   ------------------------
   |Servicios para C-Salud |
   ---------------
---------

   Descripción

   Actualiza el rut de un Beneficiario

   Prueba

    declare
       @extCodResBen     char(1),
       @extMensajeError  char(30)

    exec prestacion..INGBenRec 78, '0005308213-0', 2, '0000000001-9', @extCodResBen output, @extMensajeError output

    Select  *,BenRutBen_nn, BenMarCon_id, BenIniVig_fc, BenTerVig_fc,
            BenApePat_ds, BenApeMat_ds, BenNom_ds,    BenSex_fl,
            BenFecNac_fc, BenNumCto_id, BenRutCot_id, BenDvCot_cr,
            BenDvBen_cr,  BenCri
Der_ta
    from    contrato..Beneficiario
    where   BenRutCot_id = 5308213
      and   BenCorCar_id = '02'

    update contrato..Beneficiario
       set BenRutBen_nn = 0,
           BenDvBen_cr = '0'
    where   BenRutCot_id = 5308213
      and   BenCor
Car_id = '02'
     and  ((BenRutBen_nn = 0) or (BenRutBen_nn is null))
*/
As
declare @FechaEntrada      fecha,
        @Hoy               fecha,
        @Marca             marca,
        @RutBen            rut,
        @RutBen_upd        rut,
        @dv_
Ben_Upd        dv,
        @NroContrato       contrato,
        @RutCotizante      rut,
        @CorrCarga         regla,
        @Ok                flag,
        @ErrorCode         int

begin

 create table #GrupoContrato
 (
  extCorrBenef        smallint,
  extRutBeneficiario  char(12),
  extApellidoPat      char(30),
  extApellidoMat      char(30) NULL,
  extNombres          char(40),
  extCodEstBen        char(1),
  extDescEstado       char(15),
  extCorrCarga        regla,
  extRutCot_id        rut,

  extNumCto_id        contrato,
  extMarCon_id        marca
 )

 Select @Hoy          = convert(smalldatetime,convert(char(10),getdate(),101))
 Select @FechaEntrada = dateadd(dd,1,@Hoy)

 Select @RutBen = convert(int,substring(ltrim(rtrim(@extRutCotizante)),1,charindex('-',ltrim(rtrim(@extRutCotizante)))-1))
 Select @CorrCarga = replicate('0',2 - char_length(ltrim(rtrim((convert(char(2),@extCorrBenef)))))) + ltrim(rtrim((convert(char(2),@extCorrBenef))))

 create table #Beneficiarios
 (
  BenRutBen_nn    rut,
  BenMarCon_id    marca,
  BenIniVig_fc    fecha,
  BenTerVig_fc    fecha,
  BenApePat_ds    apellido,
  BenApeMat_ds    apellido  null,
  BenNom_ds       nombre,
  BenSex_fl       flag,
  BenFecNac_fc    fecha,
  BenNumCto_id    contrato,
  BenRutCot_id    rut,
  BenDvCot_cr     dv        null,
  BenDvBen_cr     dv        null,
  BenCriDer_ta    char(2)   null
 )

 exec   @ErrorCode = prestacion..INGSelConMar @RutBen, @Hoy, @FechaEntrada, @Marca output, @NroContrato output, @Ok output
 if @Ok = 'S' and @ErrorCode = 0
  begin
   Select @extCodResBen     = 'N',
          @extMensajeError = 'COTIZANTE NO EXISTE'

   
Select @RutCotizante    = BenRutCot_id,
          @NroContrato     = BenNumCto_id,
          @Marca           = BenMarCon_id
   from   contrato..Beneficiario
   where  BenRutCot_id = @RutBen
     and  BenMarCon_id = @Marca
     and  BenIniVig_fc <= @Hoy
 
    and  BenTerVig_fc >= @Hoy

   insert  #Beneficiarios
   Select  BenRutBen_nn, BenMarCon_id, BenIniVig_fc, BenTerVig_fc,
           BenApePat_ds, BenApeMat_ds, BenNom_ds,    BenSex_fl,
           BenFecNac_fc, BenNumCto_id, BenRutCot_id, BenDvCot_cr,
 
          BenDvBen_cr,  BenCriDer_ta
   from    contrato..Beneficiario
   where   BenRutCot_id = @RutBen
     and  ((BenRutBen_nn = 0) or (BenRutBen_nn is null))

   if @@rowcount > 0 --// Beneficiario fue encontrado.
    begin

     insert #GrupoContrato

     Select convert(smallint,BenCorCar_id),
            convert(char(12), replicate('0', 12 -
                              char_Length(ltrim(rtrim(
                              convert(char(12),ltrim(rtrim(convert(char(12),BenRutBen_nn)))
             
                 +'-'+isnull(BenDvBen_cr,'0'))))))
            +ltrim(rtrim(convert(char(12),ltrim(rtrim(convert(char(12),BenRutBen_nn)))+'-'+BenDvBen_cr)))),
            convert(char(30),ltrim(rtrim(BenApePat_ds))),
            convert(char(30),ltrim(rtr
im(BenApeMat_ds))),
            convert(char(40),ltrim(rtrim(BenNom_ds))),
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
           B
enCorCar_id,
           BenRutCot_id,
           BenNumCto_id,
           BenMarCon_id
     from   contrato..Beneficiario
     where  BenRutCot_id = @RutCotizante
       and  BenNumCto_id = @NroContrato
       and  BenMarCon_id = @Marca

     Select @RutB
en_upd = convert(int,substring(ltrim(rtrim(@extRutBeneficiario)),1,
                          charindex('-',ltrim(rtrim(@extRutBeneficiario)))-1))

     Select @dv_Ben_Upd = substring(ltrim(rtrim(@extRutBeneficiario)),
                          charindex(
'-',ltrim(rtrim(@extRutBeneficiario)))+1,1)

     if @RutBen_upd is not null
      begin
       begin tran

        if not exists (Select 1 From #Beneficiarios
                       where  BenRutCot_id = @RutCotizante
                         and  BenNum
Cto_id = @NroContrato
                         and  BenMarCon_id = @Marca
                         and  BenRutBen_nn = @RutBen_upd)
         begin

          update  contrato..Beneficiario
             set  BenRutBen_nn = @RutBen_upd,
                  Be
nDvBen_cr  = @dv_Ben_Upd
          From    #GrupoContrato
          where   extRutCot_id = @RutCotizante
            and   extNumCto_id = @NroContrato
            and   extMarCon_id = @Marca
            and   extCorrBenef = @extCorrBenef
            and  
 BenRutCot_id = extRutCot_id
            and   BenNumCto_id = extNumCto_id
            and   BenMarCon_id = extMarCon_id
            and   BenCorCar_id = extCorrCarga

          if @@Error != 0
           begin
            rollback tran
            Select
 @extCodResBen     = 'P',
                   @extMensajeError = 'ERROR EN TRANSACCION'

            return 1
           end

          commit tran

          Select @extCodResBen     = 'G',
                 @extMensajeError = ''

          return 1

     
    end
        else
         begin
          Select @extCodResBen     = 'P',
                 @extMensajeError = 'YA EXISTE CARGA CON ESE RUT'

          return 1
         end
      end
     else
      begin
        Select @extCodResBen     = 'P',
      
         @extMensajeError = 'RUT NO VALIDO'

        return 1
      end
    end
   else
    begin
     Select @extCodResBen    = 'P',
            @extMensajeError = 'SIN CARGAS CON RUT MODIFICABLE'
     return 1
    end
  end
 else
  begin
   Select @extC
odResBen    = 'P',
          @extMensajeError = 'NO EXISTE CONTRATO VIGENTE'
  end
end                                                                                                                                                                         
(31 rows affected)
(return status = 0)
1> 
