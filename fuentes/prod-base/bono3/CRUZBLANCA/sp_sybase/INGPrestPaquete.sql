locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
26
(1 row affected)
text
create procedure dbo.INGPrestPaquete
(
 @extCodFinanciador     smallint,
 @extHomNumeroConvenio  char(15),
 @extHomLugarConvenio   char(10),
 @extCodPaquete         char(15),
 @extCodError           char(1)  output,
 @extMensajeError       char(30) output

)
/*
   procedimiento : INGPrestPaquete
   Autor         : Cristian Rivas Rivera.
   Parametros I
     @extCodFinanciador     : Codigo del Financiador
     @extHomNumeroConvenio  : Folio del convenio
     @extHomLugarConvenio   : Correlativo de Direccion

     @extCodPaquete         : Codigo de paquete (Homologo)
     @extCodError           : Existencia de Error -> N, Termina OK -> S
     @extMensajeError       : the Reason why. Si no se calló, -> ''

   ------------------------
   |Servicios para C-Salud
 |
   ------------------------

   Descripción

   El servicio retorna la composición del paquete que ha sido indicado como
   parametro.

   Se levanta la siguiente regla de negocio: Los paquetes de un prestador,
   cuelgan de la nomina básica del conven
io de ese prestador.

   Prueba
     @extCodFinanciador     smallint,
           @extHomNumeroConvenio  char(15),
          @extHomLugarConvenio   char(10),
           @extCodPaquete         char(15),
           @extCodError           char(1),
           
@extMensajeError       char(30)



   declare @extCodError           char(1),
           @extMensajeError       char(30)

78,"00000042095-000","0070681","P00000000000027"
   exec prestacion..INGPrestPaquete 078, '00000042095-000', '0070681', '819308', @extCodError output, @extMensajeError output 

Select  @extCodFinanciador     = 78,
        @extHomNumeroConvenio  = '00000042095-000',
        @extHomLugarConvenio   = '0070681',
      
  @extCodPaquete         = '819308'

*/
As
 declare
   @FolCon          int,
   @CorRen          tinyint,
   @CorDir          int,
   @Cod_Paquete     int,
   @Nomina_Convenio smallint,
   @Hoy             fecha,
   @Folio             int

begin
begin tran

     update ContadorFolio
     set    CfoNumFol_nn = CfoNumFol_nn - 1
     where  CfoCodMar_id = 'IN'
     And    CfoTipDoc_fl = 'LEPP'

     select @Folio = CfoNumFol_nn
     from   ContadorFolio
     where  CfoCodMar_id = 'IN'
     and    CfoTipDoc_fl = 'LEPP'

   commit tran

 begin tran

 insert Log_EntradasPrestPaquete (Log_NroTrx, LogFechaTRX,      CodFinanciador, HomNumeroConvenio, HomLugarConvenio, CodPaquete)
 values (@Folio, getdate(), @extCodFinanciador,  @extHomNumeroConvenio, @extHomLugarConvenio,  @extCodPaquete)

 if @@error != 0
  begin
   Select extCodHomologo  = convert(char(12),''),
          extItemHomologo = convert(char(2),''),
          extCantidad     = convert(int,0)  --convert(char(2),0)

   Select @extCodError     = 'S'

   Select @extMensajeError = 'ERROR EN LOG INTERNO'
   return 1
  end

 commit tran

 Select @Hoy = convert(smalldatetime,convert(char(10),getdate(),101))

 --// Decodificación de los parametros de entrada.
 --if @extCodFinanciador = 74 Select @Marca = '
AS'
 --if @extCodFinanciador = 78 Select @Marca = 'CB'

 Select @FolCon = convert(int,substring(ltrim(rtrim(@extHomNumeroConvenio)),1,charindex('-',ltrim(rtrim(@extHomNumeroConvenio)))-1))
 Select @CorRen = convert(tinyint,substring(@extHomNumeroConvenio,
char_length(@extHomNumeroConvenio),1))
 Select @CorDir = convert(int,ltrim(rtrim(@extHomLugarConvenio)))
 select @Cod_Paquete = convert(int,ltrim(rtrim(substring(@extCodPaquete,2,char_length(@extCodPaquete)))))

 Select @Nomina_Convenio = ConCodNom_ta From   convenio..Convenio where  ConFolCon_id = @FolCon and  ConCorRen_id = @CorRen 
 if @@rowcount > 0
  begin

   Select extCodHomologo  = convert(char(12),
                            rtrim(ltrim(convert(char(10),CpeCodPre_id)))+ replicate('0', 3 - char_length(rtrim(ltrim(convert(char(3),CpeCodIte_id))))) + rtrim(ltrim(convert(char(3),CpeCodIte_id)))), extItemHomologo = case CpeCodIte_id
                             when   0 then '00'
			 	when 101 then '01'
                             when 113 then '02'
                             when 107 then '09'
                             else '08'
                            end,
          extCantidad     = convert(int
,CpeCanCpe_nn)
  from   prestacion..PaqueteExterno,
          prestacion..PaqueteAsociado,
          prestacion..ComposicionPaqueteExt
   where  PqeCodNom_id = @Nomina_Convenio
     and  PqeCodPaq_id =  @Cod_Paquete
     and  PqeCodNom_id = PqaCodNom_id
 
    and  PqeCodPaq_id = PqaPaqPad_id
     and  PqaCodReg_id = 1
     and  PqeTipPaq_re <> 'HI'
     and  CpeCodNom_id = PqeCodNom_id
     and  CpeCodPaq_id = PqeCodPaq_id
     and  CpeFecIni_fc <= @Hoy
     and  CpeFecTer_id >= @Hoy
  union
   Select extCodHomologo  = convert(char(12),
                            rtrim(ltrim(convert(char(10),CpeCodPre_id)))+
                            replicate('0', 3 - char_length(rtrim(ltrim(convert(char(3),CpeCodIte_id))))) +
                            rtrim(ltrim(convert(char(3),CpeCodIte_id)))), extItemHomologo = case CpeCodIte_id
                             when   0 then '00'
                             when 101 then '01'
                             when 113 then '02'
                             when 107 then '09'
                             else '08'
                            end, extCantidad     = convert(int,CpeCanCpe_nn)
  from   prestacion..PaqueteExterno,
          prestacion..PaqueteAsociado,
          prestacion..ComposicionPaqueteExt
   where  PqeCodNom_id = @Nomina_Convenio
     and  PqeCodPaq_id =  @Cod_Paquete
     and  PqeCodNom_id = PqaCodNom_id
     and  PqeCodPaq_id = PqaPaqPad_id
     and  PqaCodReg_id = 1
     and  PqeTipPaq_re <> 'HI'
     and  CpeCodNom_id = PqeCodNom_id
     and  CpeCodPaq_id = PqeCodPaq_id
     and  CpeFecIni_fc <= @Hoy
     and  CpeFecTer_id is null


   if @@rowcount > 0
    begin
     Select @extCodError     = 'S'
     Select @extMensajeError = ''
     return 1
    end
   else
    begin
      Select extCodHomologo  = convert(char(12),''),
             extItemHomologo = convert(char(2),''),
             extCantidad     = convert(int,0)  --convert(char(2),0)

     Select @extCodError     = 'N'
     Select @extMensajeError = 'NO EXISTE PAQUETE'
    
 return 1

    end

  end
 else
  begin
   Select @extCodError     = 'N'
   Select @extMensajeError = 'FOLIO CONVENIO NO VALIDO'
   return 1
  end

 return 1

end

                                                                                           
(26 rows affected)
(return status = 0)
1> 
