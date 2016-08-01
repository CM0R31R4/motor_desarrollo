CREATE OR REPLACE FUNCTION control.sp_actualiza_registro(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1   alias for $1;
        xml2   varchar;
        llave11 varchar;
        stMaster        control.master%ROWTYPE;
begin
        xml2:=xml1;
        xml2:=put_campo(xml2,'ERROR_VALIDACION','0');
        llave11:=get_campo('LLAVE_BUSQUEDA',xml2);
        update control.master set valor1=get_campo('VALOR1',xml2),valor2=get_campo('VALOR2',xml2),valor3=get_campo('VA
LOR3',xml2),valor4=get_campo('VALOR4',xml2),valor5=get_campo('VALOR5',xml2),fecha_ultima_act=current_timestamp where l
lave=llave11;
        if found then
                --raise notice 'JCC_control.sp_actualiza_registro Updateado =% ',llave11;
                xml2:=put_campo(xml2,'ERROR_VALIDACION','0');
        else
                --raise notice 'JCC_control.sp_actualiza_registro NO-Updateado =% ',llave11;
                xml2:=put_campo(xml2,'ERROR_VALIDACION','1');
        end if;
        return xml2;
end
$function$

