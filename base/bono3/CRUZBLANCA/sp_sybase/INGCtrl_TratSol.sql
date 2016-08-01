locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
9
(1 row affected)
text
create procedure dbo.INGCtrl_TratSol
(
 @CodMarca       marca,
 @CodPrestacion  prestacion,
 @Accion         char(2)    output
)
/*
declare  @Accion  char(2)
-- exec prestacion..INGCtrl_TratSol 'CB', '0101816',  @Accion output
-- exec prestacion..INGCtrl_
TratSol 'CB', '0301045',  @Accion output
-- exec prestacion..INGCtrl_TratSol 'CB', '0404001',  @Accion output
 exec prestacion..INGCtrl_TratSol 'CB', '2004001',  @Accion output

Select Grupo_int = CapCodGru_ta ,
       SubGr_int = CapCodSug_ta
  from   pr
estacion..CatalogoPrestacion
  where  CapCodPre_id = '0301045'

 drop table prestacion..CtrlOblg_SolTra

 select * from prestacion..CtrlOblg_SolTra wher e

 REGLA DE NEGOCIO
 ----------------

 En caso de Exigibilidad de Tratante oprestador se actuara seg
un el
 siguiente cuadro.

 Tratante | Solicitante | Tratamiento | GRabar en BONO
 SI         SI            AM            Tratante
 SI         NO            TR            Tratante
 NO         SI            SO            Solicitante
 NO         NO          
  PR            Prestador

*/
As
declare
  @ReqTra char(1),
  @ReqSol char(1),
  @Grupo_int tinyint,
  @SubGr_int tinyint
begin

  Select @Accion = 'PR'

  Select @Grupo_int = 0
  Select @SubGr_int = 0

  Select @Grupo_int = CapCodGru_ta ,
         @SubGr
_int = CapCodSug_ta
  from   prestacion..CatalogoPrestacion
  where  CapCodPre_id = @CodPrestacion

  if @Grupo_int > 0 and @SubGr_int > 0
   begin

    Select @ReqTra = ''
    Select @ReqSol = ''

    Select @ReqTra = CosReqTra_fl,
           @ReqSol = C
osReqSol_fl
    from   prestacion..CtrlOblg_SolTra
    where  CosCodMar_re = @CodMarca
     and   CosGruPre_cr = @Grupo_int
     and   CosSgrPre_cr = @SubGr_int

    if @@rowcount = 0
     begin
      Select @ReqTra = CosReqTra_fl,
             @ReqSol = 
CosReqSol_fl
      from   prestacion..CtrlOblg_SolTra
      where  CosCodMar_re = 'IN'
       and   CosGruPre_cr = @Grupo_int
       and   CosSgrPre_cr = @SubGr_int
     end

    if @ReqTra = 'S' and @ReqSol = 'S' Select @Accion = 'AM'
    else
     if @R
eqTra = 'S' and @ReqSol = 'N' Select @Accion = 'TR'
     else
      if @ReqTra = 'N' and @ReqSol = 'S' Select @Accion = 'SO'
      else
       if @ReqTra = 'N' and @ReqSol = 'N' Select @Accion = 'PR'
       else Select @Accion = 'PR'

  end

end 
        
(9 rows affected)
(return status = 0)
1> 