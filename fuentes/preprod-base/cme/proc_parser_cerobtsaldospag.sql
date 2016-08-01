CREATE OR REPLACE FUNCTION proc_parser_input_cerobtsaldospag(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	
	rut_ben1	varchar;
	rut_cot1	varchar;

begin
	xml2:=xml1;
	if length(get_campo('IDXTX',xml2)) = 0 then
                --Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','CME Sin Campo IdxTx');
                return xml2;
        end if;

	xml2:=  put_campo(xml2,'CTACODFINANCIADOR',	coalesce(nullif(get_campo('CTACODFINANCIADOR',xml2),''),'0'));
	rut_ben1:=get_campo('CTARUTBENEFICIARIO',xml2);
	rut_cot1:=get_campo('CTARUTCOTIZANTE',xml2);
	xml2:=  put_campo(xml2,'CTAFOLIOSBONO',	coalesce(nullif(get_campo('CTAFOLIOSBONO',xml2),''),'0'));

	--Valida formato del Rut
        rut_ben1:=motor_formato_rut(rut_ben1);
        rut_cot1:=motor_formato_rut(rut_cot1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_con1='')	then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
		--Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','Rut Incorrecto');
                return xml2;
        end if;
        --Retorno de datos.
        xml2    :=put_campo(xml2,'CTARUTBENEFICIARIO',rut_ben1);
        xml2    :=put_campo(xml2,'CTARUTCOTIZANTE',rut_cot1);

Return xml2;
end;
$$
LANGUAGE plpgsql;

