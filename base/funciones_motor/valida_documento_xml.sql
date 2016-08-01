CREATE OR REPLACE FUNCTION valida_documento_xml(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        input1          varchar;
        xml_std1        varchar;
begiN
        xml2:=xml1;
        input1  :=replace(get_campo('INPUT',xml2),chr(13),'');
        input1  :=replace(input1,'\012','');
        --Validamos si el XML entrante es un documento xml valido
        if (strpos(input1,chr(10)||chr(10))>0) then
                --Me salto las 2 lineas
                xml_std1:=substring(input1,strpos(input1,chr(10)||chr(10))+2,length(input1)+1024);
        else
                xml_std1:=input1;
        end if;
        begin
        if xml_std1::xml is not document then
                --Si no es un xml valido rechazo
                xml2:=put_campo(xml2,'MENSAJE_RESPUESTA','Xml Is Not Document');
                return xml2;
        end if;
        exception when others then
                xml2:=put_campo(xml2,'MENSAJE_RESPUESTA','Xml no valido');
                return xml2;
        end;
        --Guardo el xml validado para uso posterior mediante xpath
        xml2:=put_campo(xml2,'__XML_STD__',xml_std1);

        return xml2;
end;
$$
LANGUAGE plpgsql;
