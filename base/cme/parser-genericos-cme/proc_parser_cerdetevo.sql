CREATE OR REPLACE FUNCTION proc_parser_input_cerdetevo(varchar)
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

	xml2:=  put_campo(xml2,'EPITIPODET',		coalesce(nullif(get_campo('EPITIPODET',xml2),''),'0'));
	rut_pre1:=get_campo('EPIRUTPRESTADOR',xml2);
	xml2:=  put_campo(xml2,'EPICODFINANCIADOR',	coalesce(nullif(get_campo('EPICODFINANCIADOR',xml2),''),'0'));
	xml2:=  put_campo(xml2,'EPINUMCTA',		coalesce(nullif(get_campo('EPINUMCTA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'EPINUMCOBRO',		coalesce(nullif(get_campo('EPINUMCOBRO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'EPITIPENVIO ',		coalesce(nullif(get_campo('PITIPENVIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'EPIHOMNROCONVENIO',	coalesce(nullif(get_campo('EPIHOMNROCONVENIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'EPIHOMLUGARCONVENIO',	coalesce(nullif(get_campo('EPIHOMLUGARCONVENIO',xml2),''),'0'));

	xml2:=  put_campo(xml2,'EPINUMCOR',		coalesce(nullif(get_campo('EPINUMCOR',xml2),''),'0'));
	xml2:=  put_campo(xml2,'EPIDESCRIPCION',	coalesce(nullif(get_campo('EPIDESCRIPCION',xml2),''),'0'));

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
        xml2    :=put_campo(xml2,'EPIRUTPRESTADOR',rut_pre1);

Return xml2;
end;
$$
LANGUAGE plpgsql;

