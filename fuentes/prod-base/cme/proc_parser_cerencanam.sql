CREATE OR REPLACE FUNCTION proc_parser_input_cerencanam(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	
	rut_pre1	varchar;
	rut_tra1	varchar;
	rut_inf1	varchar;

begin
	xml2:=xml1;
	if length(get_campo('IDXTX',xml2)) = 0 then
                --Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','CME Sin Campo IdxTx');
                return xml2;
        end if;
	
	xml2:=  put_campo(xml2,'ANAMCODFINANCIADOR',	coalesce(nullif(get_campo('ANAMCODFINANCIADOR',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMNUMCTA',	coalesce(nullif(get_campo('ANAMNUMCTA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMNUMCOBRO',	coalesce(nullif(get_campo('ANAMNUMCOBRO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMTIPENVIO',	coalesce(nullif(get_campo('ANAMTIPENVIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMHOMNROCONVENIO',coalesce(nullif(get_campo('ANAMHOMNROCONVENIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMHOMLUGARCONVENIO',coalesce(nullif(get_campo('ANAMHOMLUGARCONVENIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMFECEMI',	coalesce(nullif(get_campo('ANAMFECEMI',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMPROCE',	coalesce(nullif(get_campo('ANAMPROCE',xml2),''),'0'));
	rut_pre1:=get_campo('ANAMRUTPRESTADOR',xml2);
	rut_tra1:=get_campo('ANAMRUTTRATANTE',xml2);
	xml2:=  put_campo(xml2,'ANAMNOMBRETRATANTE',coalesce(nullif(get_campo('ANAMNOMBRETRATANTE',xml2),''),'0'));
	rut_inf1:=get_campo('ANAMRUTINFORM',xml2);
	xml2:=  put_campo(xml2,'ANAMINFORM',	coalesce(nullif(get_campo('ANAMINFORM',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMSERDEST',	coalesce(nullif(get_campo('ANAMSERDEST',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMFICHA',	coalesce(nullif(get_campo('ANAMFICHA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMCODERROR',	coalesce(nullif(get_campo('ANAMCODERROR',xml2),''),'0'));
	xml2:=  put_campo(xml2,'ANAMMENSAJEERROR',coalesce(nullif(get_campo('ANAMMENSAJEERROR',xml2),''),'0'));


	--Valida formato del Rut
        rut_pre1	:=motor_formato_rut(rut_pre1);
        rut_tra1      	:=motor_formato_rut(rut_tra1);
        rut_inf1       	:=motor_formato_rut(rut_inf1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_pre1='')	or (rut_tra1='')	or
           (rut_inf1='')   	then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
		--Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','Rut Incorrecto');
                return xml2;
        end if;
        --Retorno de datos.
        xml2    :=put_campo(xml2,'ANAMRUTPRESTADOR',rut_pre1);
        xml2    :=put_campo(xml2,'ANAMRUTTRATANTE',rut_tra1);
        xml2    :=put_campo(xml2,'ANAMRUTINFORM',rut_inf1);

Return xml2;
end;
$$
LANGUAGE plpgsql;

