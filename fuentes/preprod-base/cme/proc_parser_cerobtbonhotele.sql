CREATE OR REPLACE FUNCTION proc_parser_input_cerobtbonhotele(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	
	rut_con1	varchar;

begin
	xml2:=xml1;
	if length(get_campo('IDXTX',xml2)) = 0 then
                --Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','CME Sin Campo IdxTx');
                return xml2;
        end if;	

	xml2:=  put_campo(xml2,'CTACODFINANCIADOR',	coalesce(nullif(get_campo('CTACODFINANCIADOR',xml2),''),'0'));
	rut_con1:=get_campo('CTARUTCONVENIO',xml2);
	xml2:=  put_campo(xml2,'CTANUMCTA',	coalesce(nullif(get_campo('CTANUMCTA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANUMCOBRO',	coalesce(nullif(get_campo('CTANUMCOBRO',xml2),''),'0'));

	--Valida formato del Rut
        rut_con1:=motor_formato_rut(rut_con1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_con1='')	then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
		--Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','Rut Incorrecto');
                return xml2;
        end if;
        --Retorno de datos.
        xml2    :=put_campo(xml2,'CTARUTCONVENIO',rut_con1);

Return xml2;
end;
$$
LANGUAGE plpgsql;

