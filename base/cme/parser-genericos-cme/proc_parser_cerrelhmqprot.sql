CREATE OR REPLACE FUNCTION proc_parser_input_cerrelhmqprot(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	
	rut_con1	varchar;
	rut_ptd1	varchar;

begin
	xml2:=xml1;
	

	xml2:=  put_campo(xml2,'CTACORRREGISTRO',coalesce(nullif(get_campo('CTACORRREGISTRO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODFINANCIADOR',	coalesce(nullif(get_campo('CTACODFINANCIADOR',xml2),''),'0'));
	rut_con1:=get_campo('CTARUTCONVENIO',xml2);
	xml2:=  put_campo(xml2,'CTANUMCTA',	coalesce(nullif(get_campo('CTANUMCTA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANUMCOBRO',	coalesce(nullif(get_campo('CTANUMCOBRO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTATIPENVIO',	coalesce(nullif(get_campo('CTATIPENVIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODINTERVENPTD',   coalesce(nullif(get_campo('CTACODINTERVENPTD',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODPRESTPTD',	coalesce(nullif(get_campo('CTACODPRESTPTD',xml2),''),'0'));
        xml2:=  put_campo(xml2,'CTAITEMPRESTPTD',    coalesce(nullif(get_campo('CTAITEMPRESTPTD',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANROINTERV',coalesce(nullif(get_campo('CTANROINTERV',xml2),''),'0'));
        xml2:=  put_campo(xml2,'CTAFECATENCION',      substring(replace(get_campo('CTAFECATENCION',xml2),'-',''),1,17));
        xml2:=  put_campo(xml2,'CTAHORAATENCION',    coalesce(nullif(get_campo('CTAHORAATENCION',xml2),''),'0'));
      	rut_ptd1:=get_campo('CTARUTPROFESIONAL',xml2);
        xml2:=  put_campo(xml2,'CTATIPOPROFESIONAL',	coalesce(nullif(get_campo('CTATIPOPROFESIONAL',xml2),''),'0'));
        xml2:=  put_campo(xml2,'CTAMTOTOTAL',   coalesce(nullif(get_campo('CTAMTOTOTAL',xml2),''),'0'));
        xml2:=  put_campo(xml2,'CTAPROCORRELATIVO',     coalesce(nullif(get_campo('CTAPROCORRELATIVO',xml2),''),'0'));
        xml2:=  put_campo(xml2,'CTACODPROTO',   coalesce(nullif(get_campo('CTACODPROTO',xml2),''),'0'));


	--Valida formato del Rut
        rut_con1:=motor_formato_rut(rut_con1);
        rut_ptd1:=motor_formato_rut(rut_ptd1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_con1='')	or (rut_ptd1='')	then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
		--Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','Rut Incorrecto');
                return xml2;
        end if;
        --Retorno de datos.
        xml2    :=put_campo(xml2,'CTARUTCONVENIO',rut_con1);
        xml2    :=put_campo(xml2,'CTAHORAATENCION',rut_ptd1);

Return xml2;
end;
$$
LANGUAGE plpgsql;

