locale is "es_ES.UTF-8"
locale charset is "UTF-8"
locale is "es_ES.UTF-8"
locale charset is "UTF-8"
1> 2> # Lines of Text
3
(1 row affected)
text
create procedure dbo.INGSwitch_FechaEmision
(
 @Controlar bit output
)
/*
   procedimiento : INGSwitch_FechaEmision
   Autor         : Cristian Rivas Rivera.

   Parametros O
       @Controlar  : Indica si se debe o no controlar que un bono este siendo em
itido
                     en el dia actual.

                     1 = Controlar que un bono sea emitido solo en el dia en curso.
                     0 = No Controlar Fecha. (Posible Actualizacion de Bonos no grabados)

   ------------------------
   |Se
rvicios para C-Salud |
   ------------------------

   Descripción
    Habilita o deshabilita el control de fechas en la rutina INGCopTran.

   Prueba
    declare @Sw bit
    exec INGSwitch_FechaEmision @Sw output
*/
As
begin
 Select @Controlar = 0
end 
 
(3 rows affected)
(return status = 0)
1> 