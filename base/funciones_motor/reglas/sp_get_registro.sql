CREATE OR REPLACE FUNCTION control.sp_get_registro(character varying)
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
        select * into stMaster from control.master where llave=llave11;
        if found then
                --raise notice 'JCC_control.sp_get_registro Encontrado =% ',llave11;
                xml2:=put_campo(xml2,'ERROR_VALIDACION','0');
                xml2:=put_campo(xml2,'VALOR1',stMaster.valor1);
                xml2:=put_campo(xml2,'VALOR2',stMaster.valor2);
                xml2:=put_campo(xml2,'VALOR3',stMaster.valor3);
                xml2:=put_campo(xml2,'VALOR4',stMaster.valor4);
                xml2:=put_campo(xml2,'VALOR5',stMaster.valor5);
        else
                xml2:=put_campo(xml2,'ERROR_VALIDACION','1')i;
                --raise notice 'JCC_control.sp_get_registro NO_Encontrado =%',llave11;
        end if;
        return xml2;
end
$function$

