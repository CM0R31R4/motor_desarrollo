locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
23
(1 row affected)
text

create procedure dbo.INGEnrola
(
 @extCodFinanciador     smallint,
 @extRutEnrolar         char(12),
 @extRutBeneficiario    char(12),
 @extValido             char(1)   output,
 @extNombreComp         char(40)  output
)
/*
   procedimiento : INGEnrola
  
 Autor         : Cristian Rivas Rivera.
   Parametros I
      @extCodFinanciador   : Código del Financiador
      @extRutEnrolar       : Rut a enrolar
      @extRutBeneficiario  : Rut del Beneficiario
   Parametros O
      @extValido           : Rut es Valido (S,N)
      @extNombreComp       : Nombre Completo.

   ------------------------
   |Servicios para C-Salud |
   ------------------------

   Descripción

   Obtiene la Lista de Cargas del contrato vigente al día de Hoy.

   Prueba

    extRutAcompanante extNombreAcompanante
    ----------------- --------------------
    0005308213-0      FUENTEALBA ZAFIRA LUISA AMANDA
    0000000000-0      ANDAUR FUENTEALBA ANA CAROLINA
    0000000000-0      ANDAUR FUENTEALBA JAIME ANDRES
    0006456149-9      ANDAUR VIGNOLO JAIME ENRIQUE
    0019600352-5      PEZOA ANDAUR FELIPE IGNACIO

   declare  @extValido             char(1),
            @extNombreComp         char(40)

   exec prestacion..INGEnrola 78, '0006456149-9', '0005308213-0', @extValido output, @extNombreComp output

   declare  @extValido             char(1),
            @extNombreComp         char(40)

   exec prestacion..INGEnrola 78, '0012489590-1', '0005308213-0', @extValido output, @extNombreComp output

*/
As
declare @FechaEntrada      fecha,
       	@Hoy               fecha,
        @Marca             marca,
        @RutBen            rut,
        @NroContrato       contrato,
        @RutCotizante      rut,
        @TipPla            regla,
        @RutCny            rut,
        @ContratoCny 	   contrato,
        @HoyMasUno         fecha,
        @Ok                flag,
        @ErrorCode         int
begin

 Select @Hoy       = convert(smalldatetime,convert(char(10),getdate(),101))
 Select @HoyMasUno = dateadd(dd,1,@Hoy)
 Select @RutBen = convert(int,substring(ltrim(rtrim(@extRutBeneficiario)),1,charindex('-',ltrim(rtrim(@extRutBeneficiario)))-1))

 exec   @ErrorCode = prestacion..INGSelConMar @RutBen, @Hoy, @HoyMasUno,@Marca output,@NroContrato output,@Ok output
 if @Ok = 'N' or @ErrorCode != 0
  begin
   Select @extValido     = 'N',
          @extNombreComp = ''
   return 1
  end

 Select @extValido = 'N', @extNombreComp = ''

 Select  @RutCotizante = BenRutCot_id
 from    contrato..Beneficiario
 where   BenRutBen_nn = @RutBen
   and   BenNumCto_id = @NroContrato
   and   BenMarCon_id = @Marca
   and   BenIniVig_fc <= @Hoy
   and  ((BenTerVig_fc >= @Hoy) or (BenTerVig_fc is null))

 if @@rowcount > 0 --// Beneficiario fue encontrado.
  begin

   create table #Autorizados
   (
    extRutAcompanante     char(12),
    extNombreAcompanante  char(40)
   )

   insert #Autorizados
   Select replicate('0',12-char_length(ltrim(rtrim(convert(char(12),BenRutBen_nn)))+'-'+BenDvBen_cr))+
          ltrim(rtrim(convert(char(12),BenRutBen_nn)))+'-'+BenDvBen_cr,
          ltrim(rtrim(BenApePat_ds))+' '+
          ltrim(rtrim(BenApeMat_ds))+' '+ ltrim(rtrim(BenNom_ds))
   From   contrato..Beneficiario
   where  BenRutCot_id = @RutCotizante
     and  BenNumCto_id = @NroContrato
     and  BenMarCon_id = @Marca
     and  BenIniVig_fc <= @Hoy
     and  ((BenTerVig_fc >= @Hoy) or (BenTerVig_fc is null))

   Select @TipPla = ConTipPla_cr,
          @RutCny = ConRutCny_nn
   From   contrato..Contrato
   where  ConRutCot_id = @RutCotizante
     and  ConNumCto_id = @NroContrato
     and  ConMarCon_id = @Marca

   if ((@TipPla = 'MA')and(@RutCny > 0)and(@RutCny is not null))
    begin

     create table #DatosConyuge
     (
      BenMarCon_id    marca,
      BenNumCto_id    contrato,
      BenRutCot_id    rut,
      BenDvCot_cr     dv        null,
      BenIniVig_fc    fecha,
      BenTerVig_fc    fecha,

     )

     insert  #DatosConyuge
     Select  BenMarCon_id, BenNumCto_id, BenRutCot_id,
             BenDvCot_cr,  BenIniVig_fc, BenTerVig_fc
     from    contrato..Beneficiario
     where   BenRutCot_id = @RutCny

     Select @ContratoCny = BenNumCto_id
     from   #DatosConyuge
     where  BenRutCot_id = @RutCny
       and  BenMarCon_id = @Marca
       and  BenIniVig_fc <= @Hoy
       and  BenTerVig_fc >= @Hoy

     if @@rowcount > 0
      begin
       insert #Autorizados
       Select replicate('0',12-char_length(ltrim(rtrim(convert(char(12),BenRutBen_nn)))+'-'+BenDvBen_cr))+
              ltrim(rtrim(convert(char(12),BenRutBen_nn)))+'-'+BenDvBen_cr,
              ltrim(rtrim(BenApePat_ds))+' '+
              ltrim(rtrim(BenApeMat_ds))+' '+ ltrim(rtrim(BenNom_ds))
       From   contrato..Beneficiario
       where  BenRutCot_id = @RutCny
         and  BenNumCto_id = @ContratoCny
         and  BenMarCon_id = @Marca
         and  BenIniVig_fc <= @Hoy
         and  ((BenTerVig_fc >= @Hoy) or (BenTerVig_fc is null))
      end

     drop table #DatosConyuge
    end --// Si contrato es MAtrimonial

   if exists (Select 1 From #Autorizados where extRutAcompanante = @extRutEnrolar)
    begin

     Select @extValido     = 'S'

     Select @extNombreComp = extNombreAcompanante
     From   #Autorizados
     where  extRutAcompanante = @extRutEnrolar

     return 1
    end
   else
    begin
     Select @extValido     = 'N'
     Select @extNombreComp = ''

     return 1
    end
  end
 else
  begin
   Select @extValido     = 'N'
   Select @extNombreComp = ''

   return 1
  end

 return 1
end                                                                                                                                                                     
(23 rows affected)
(return status = 0)
1> 
