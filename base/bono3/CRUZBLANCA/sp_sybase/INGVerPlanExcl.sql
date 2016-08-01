locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
16
(1 row affected)
text

create procedure dbo.INGVerPlanExcl
(
 @ConRutPre_ta rut,
 @ConCodMar_cr marca,
 @PlaCodPla_id codpla,
 @Folio        int     output,
 @CorRen       tinyint output,
 @TotalConv    int     output
)
/*
   procedimiento : INGVerPlanExcl
   Autor         : C
ristian Rivas Rivera.

   Parametros I
       @ConRutPre_ta rut     : Rut Del Prestador
       @ConCodMar_cr marca   : Marca
       @PlaCodPla_id codpla  : Plan vigente.

   Parametros O

   ------------------------
   |Servicios para C-Salud |
   -------
-----------------

   Descripción

   Prueba
     declare  @Folio        int,
              @CorRen       tinyint,
              @TotalConv    int

     exec INGVerPlanExcl 96770100, 'CB', 'FA1E08000',
                         @Folio output, @CorRen outpu
t, @TotalConv output


     declare  @Folio        int,
              @CorRen       tinyint,
              @TotalConv    int

     exec INGVerPlanExcl 96770100, 'CB', 'FFN7708000',
                         @Folio output, @CorRen output, @TotalConv output


     declare  @Folio        int,
              @CorRen       tinyint,
              @TotalConv    int

     exec INGVerPlanExcl 96530470,'CB','CTOPAZ7000' ,
                         @Folio output, @CorRen output, @TotalConv output

Select * from contrato
..Contrato where ConRutCot_id = 12489590
*/
As

declare @Ini char(26),@Fin char(26)
select @Ini=convert(char(26),getdate(),109)


declare @Fecha fecha,
         @TotalInserted int
begin
   Select @TotalInserted = 0

   create table #Conv_Excl
   (
    Fol
io   int,
    CorRen  tinyint
   )

   select   @Fecha = getdate()

   insert   #Conv_Excl
   select   ConFolCon_id,
            ConCorRen_id
   from     convenio..Convenio,
            convenio..PlanExcl
   where    ConRutPre_ta = @ConRutPre_ta
     and 
   ConCodMar_cr in (@ConCodMar_cr, 'IN')
     and    ConFolCon_id = PexFolCon_id
     and    ConCorRen_id = PexCorRen_id
     and    PexCodPla_id = @PlaCodPla_id
     and    ConEstCon_cr = 'IN'
      and   ((ConFecTec_fc is not null)and(@Fecha between Con
FecInc_fc and ConFecTec_fc))

   Select @TotalInserted = @@rowcount

   insert   #Conv_Excl
   select   ConFolCon_id,
            ConCorRen_id
   from     convenio..Convenio,
        convenio..PlanExcl
   where    ConRutPre_ta = @ConRutPre_ta
     and    
ConCodMar_cr in (@ConCodMar_cr, 'IN')
     and    ConFolCon_id = PexFolCon_id
     and    ConCorRen_id = PexCorRen_id
     and    PexCodPla_id = @PlaCodPla_id
     and    ConEstCon_cr = 'IN'
     and  ((ConFecTec_fc is null)and(@Fecha >= ConFecInc_fc))

 
  Select @TotalInserted = @TotalInserted + @@rowcount

   if @TotalInserted = 0
    begin
     Select @TotalInserted = 0

     insert   #Conv_Excl
     select   ConFolCon_id,
              ConCorRen_id
     from     convenio..Convenio,
              conve
nio..PlanExcl
     where    ConRutPre_ta = @ConRutPre_ta
       and    ConCodMar_cr in (@ConCodMar_cr, 'IN')
       and    ConFolCon_id = PexFolCon_id
       and    ConCorRen_id = PexCorRen_id
       and    PexCodPla_id = @PlaCodPla_id
       and    ConEs
tCon_cr = 'AC'
       and   ((ConFecTec_fc is not null)and(@Fecha between ConFecInc_fc and ConFecTec_fc))

     Select @TotalInserted = @@rowcount

     insert   #Conv_Excl
     select   ConFolCon_id,
              ConCorRen_id
     from     convenio..Con
venio,
              convenio..PlanExcl
     where    ConRutPre_ta = @ConRutPre_ta
       and    ConCodMar_cr in (@ConCodMar_cr, 'IN')
       and    ConFolCon_id = PexFolCon_id
       and    ConCorRen_id = PexCorRen_id
       and    PexCodPla_id = @PlaCod
Pla_id
       and    ConEstCon_cr = 'AC'
       and  ((ConFecTec_fc is null)and(@Fecha >= ConFecInc_fc))

       Select @TotalInserted = @TotalInserted + @@rowcount
    end

 Select @TotalConv = @TotalInserted

 Set rowcount 1

 Select @Folio  = Folio,
  
      @CorRen = CorRen
 from   #Conv_Excl

 Set rowcount 0

 select @Fin=convert(char(26),getdate(),109)
 insert Tiempos values("P15",@Ini,@Fin)

end 
                                                                                                        
(16 rows affected)
(return status = 0)
1> 