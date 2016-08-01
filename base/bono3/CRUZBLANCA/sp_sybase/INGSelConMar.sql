locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
7
(1 row affected)
text
create procedure dbo.INGSelConMar
(
 @RutBen   rut,
 @FechaIni fecha,
 @FechaTer fecha,
 @Marca    marca    output,
 @NumCto   contrato output,
 @Ok       flag     output
)
/*
   procedimiento : INGSelConMar
   Autor         : Cristian Rivas Rivera.

   -
-----------------------
   |Servicios para C-Salud |
   ------------------------

   Descripción
   Obtiene el ultimo contrato vigente, independientemente de su marca de origen.

   Prueba

    declare
       @Marca    marca,
       @NumCto   contrato,
  
     @Ok       flag

      exec prestacion..INGSelConMar 12489590, @Marca output, @NumCto output, @Ok output


*/
As
 declare @NroFilas int
begin

   delete tempdb02..IBC_Beneficiarios
   where  spid = @@spid

   insert  tempdb02..IBC_Beneficiarios
   Sel
ect  @@spid,
           BenRutBen_nn, BenMarCon_id, BenIniVig_fc, BenTerVig_fc,
           BenApePat_ds, BenApeMat_ds, BenNom_ds,    BenSex_fl,
           BenFecNac_fc, BenNumCto_id, BenRutCot_id, BenDvCot_cr,
           BenDvBen_cr,  BenCriDer_ta
   from
   contrato..Contrato
          ,contrato..Beneficiario
   where  BenRutBen_nn = @RutBen
     and  BenRutCot_id = ConRutCot_id
     and  BenMarCon_id = ConMarCon_id
     and  BenNumCto_id = ConNumCto_id
     and  BenIniVig_fc <= @FechaIni
     and  BenTer
Vig_fc >= @FechaIni

   Select @NroFilas = @@rowcount

   if @NroFilas = 1
    begin
     Select @Marca  = BenMarCon_id,
            @NumCto = BenNumCto_id
     From   tempdb02..IBC_Beneficiarios
     where  spid = @@spid
       and  BenRutBen_nn = @RutBe
n

     Select @Ok = 'S'
    end
   else
    Select @Marca = '', @NumCto = 0, @Ok = 'N'

  return @NroFilas - 1
end --// FIN INGSelConMar

 
                                                                                                                  
(7 rows affected)
(return status = 0)
1> 