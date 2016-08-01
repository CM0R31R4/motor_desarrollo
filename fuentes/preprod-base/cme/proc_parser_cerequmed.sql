CREATE OR REPLACE FUNCTION proc_parser_input_cerequmed(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	
	rut_pre1	varchar;
	rut_pro1	varchar;

begin
	xml2:=xml1;
	if length(get_campo('IDXTX',xml2)) = 0 then
                --Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','CME Sin Campo IdxTx');
                return xml2;
        end if;
	
	xml2:=  put_campo(xml2,'PROTIPODET',       coalesce(nullif(get_campo('PROTIPODET',xml2),''),'0'));
	rut_pre1:=get_campo('PRORUTPRESTADOR',xml2);
	xml2:=  put_campo(xml2,'PROCODFINANCIADOR',coalesce(nullif(get_campo('PROCODFINANCIADOR',xml2),''),'0'));
	xml2:=  put_campo(xml2,'PRONUMCTA',        coalesce(nullif(get_campo('PRONUMCTA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'PRONUMCOBRO',      coalesce(nullif(get_campo('PRONUMCOBRO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'PROTIPENVIO',      coalesce(nullif(get_campo('PROTIPENVIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'PROHOMNROCONVENIO',coalesce(nullif(get_campo('PROHOMNROCONVENIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'PROHOMLUGARCONVENIO', coalesce(nullif(get_campo('PROHOMLUGARCONVENIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'PROCORRELATIVO',   coalesce(nullif(get_campo('PROCORRELATIVO',xml2),''),'0'));
	
	xml2:=  put_campo(xml2,'PROTIPOPROFESIONAL',    coalesce(nullif(get_campo('PROTIPOPROFESIONAL',xml2),''),'0'));
	rut_pro1:=get_campo('PRORUTPROFESIONAL',xml2);
	xml2:=  put_campo(xml2,'PRONOMBREPROFESIONAL',    coalesce(nullif(get_campo('PRONOMBREPROFESIONAL',xml2),''),'0'));
	xml2:=  put_campo(xml2,'PROCODINTERVENPTD',    coalesce(nullif(get_campo('PROCODINTERVENPTD',xml2),''),'0'));
	xml2:=  put_campo(xml2,'PRONROINTENVEN',    coalesce(nullif(get_campo('PRONROINTENVEN',xml2),''),'0'));
	
	--Valida formato del Rut
        rut_pre1	:=motor_formato_rut(rut_pre1);
        rut_pro1	:=motor_formato_rut(rut_pro1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_pre1='')	or (rut_pro1='') then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
		--Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','Rut Incorrecto');
                return xml2;
        end if;
        --Retorno de datos.
        xml2    :=put_campo(xml2,'PRORUTPRESTADOR',rut_pre1);
        xml2    :=put_campo(xml2,'PRORUTPROFESIONAL',rut_pro1);


Return xml2;
end;
$$
LANGUAGE plpgsql;

