CREATE OR REPLACE FUNCTION proc_parser_input_cerexafis(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	
	rut_pre1	varchar;

begin
	xml2:=xml1;
	if length(get_campo('IDXTX',xml2)) = 0 then
                --Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','CME Sin Campo IdxTx');
                return xml2;
        end if;
	
	xml2:=  put_campo(xml2,'ANAMTIPODET',		coalesce(nullif(get_campo('ANAMTIPODET',xml2),''),'0'));
	rut_pre1:=get_campo('ANAMRUTPRESTADOR',xml2);
	xml2:=  put_campo(xml2,'ANAMCODFINANCIADOR',	coalesce(nullif(get_campo('ANAMCODFINANCIADOR',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMNUMCTA',		coalesce(nullif(get_campo('ANAMNUMCTA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMNUMCOBRO ',		coalesce(nullif(get_campo('ANAMNUMCOBRO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMTIPENVIO',		coalesce(nullif(get_campo('ANAMTIPENVIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMHOMNROCONVENIO',	coalesce(nullif(get_campo('ANAMHOMNROCONVENIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMHOMLUGARCONVENIO',	coalesce(nullif(get_campo('ANAMHOMLUGARCONVENIO',xml2),''),'0'));

	xml2:=  put_campo(xml2,'ANAMCODITEMEX',		coalesce(nullif(get_campo('ANAMCODITEMEX',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMITEMEX',		coalesce(nullif(get_campo('ANAMITEMEX',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMRESULEX',		coalesce(nullif(get_campo('ANAMRESULEX',xml2),''),'0'));

	--Valida formato del Rut
        rut_pre1	:=motor_formato_rut(rut_pre1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_pre1='')   	then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
		--Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','Rut Incorrecto');
                return xml2;
        end if;
        --Retorno de datos.
        xml2    :=put_campo(xml2,'ANAMRUTPRESTADOR',rut_pre1);

Return xml2;
end;
$$
LANGUAGE plpgsql;

