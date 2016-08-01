CREATE OR REPLACE FUNCTION control.sp_inserta_registro(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1            alias for $1;
        xml2            varchar;
        llave11         varchar;
        stMaster        control.master%ROWTYPE;
begin
        xml2:=xml1;
        xml2:=put_campo(xml2,'ERROR_VALIDACION','0');
        llave11:=get_campo('LLAVE_BUSQUEDA',xml2);
        --Si no ecuentro la llave la creo
--raise notice '>>>>>>>>>>>>>>>>>> CREARE LLAVE : %llave11'; --el que puso este raice lo escribio mal... favor fijarse
 en eso ya que esto provoco que no funcionara la acumulacion.



        insert into control.master (llave,llave1,llave2,llave3,llave4,llave5,valor1,valor2,valor3,valor4,valor5,fecha_
ultima_act,nombre_regla) values (llave11,get_campo('LLAVE1',xml2),get_campo('LLAVE2',xml2),get_campo('LLAVE3',xml2),ge
t_campo('LLAVE4',xml2),get_campo('LLAVE5',xml2),get_campo('VALOR1',xml2),get_campo('VALOR2',xml2),get_campo('VALOR3',x
ml2),get_campo('VALOR4',xml2),get_campo('VALOR5',xml2),current_timestamp,get_campo('NOMBRE_REGLA',xml2));
        if found then
                --raise notice 'JCC_control.sp_inserta_registro Insertado =% ',llave11;
                xml2:=put_campo(xml2,'ERROR_VALIDACION','0');
        else
                --raise notice 'JCC_control.sp_inserta_registro NO_Insertado =% ',llave11;
                xml2:=put_campo(xml2,'ERROR_VALIDACION','1');
        end if;
        return xml2;
end
$function$

