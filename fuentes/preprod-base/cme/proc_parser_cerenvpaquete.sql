CREATE OR REPLACE FUNCTION proc_parser_input_cerenvpaquete(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	
	rut_con1	varchar;
	rut_fac1	varchar;

begin
	xml2:=xml1;
	if length(get_campo('IDXTX',xml2)) = 0 then
                --Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','CME Sin Campo IdxTx');
                return xml2;
        end if;

	xml2:=  put_campo(xml2,'CTACORRREGISTRO',coalesce(nullif(get_campo('CTACORRREGISTRO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODFINANCIADOR',	coalesce(nullif(get_campo('CTACODFINANCIADOR',xml2),''),'0'));
	rut_con1:=get_campo('CTARUTCONVENIO',xml2);
	xml2:=  put_campo(xml2,'CTANUMCTA',	coalesce(nullif(get_campo('CTANUMCTA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANUMCOBRO',	coalesce(nullif(get_campo('CTANUMCOBRO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTATIPENVIO',	coalesce(nullif(get_campo('CTATIPENVIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODINTERVENPTD',	coalesce(nullif(get_campo('CTACODINTERVENPTD',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTADESCINTERVENPTD',	coalesce(nullif(get_campo('CTADESCINTERVENPTD',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODINTERVENHOM',     coalesce(nullif(get_campo('CTACODINTERVENHOM',xml2),''),'0'));

	xml2:=  put_campo(xml2,'CTANROINTENVEN',coalesce(nullif(get_campo('CTANROINTENVEN',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODPAQUETE',	coalesce(nullif(get_campo('CTACODPAQUETE',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTADESCPAQUETE',coalesce(nullif(get_campo('CTADESCPAQUETE',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODPAQUETEHOM',coalesce(nullif(get_campo('CTACODPAQUETEHOM',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTATIPOGRUPO',coalesce(nullif(get_campo('CTATIPOGRUPO',xml2),''),'0'));
	
	xml2:=  put_campo(xml2,'CTATIPOMOV',	coalesce(nullif(get_campo('CTATIPOMOV',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAMTOTOTAL',	coalesce(nullif(get_campo('CTAMTOTOTAL',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAMTOAFECTO',	coalesce(nullif(get_campo('CTAMTOAFECTO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAMTOEXENTO',	coalesce(nullif(get_campo('CTAMTOEXENTO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAMTOIVA',	coalesce(nullif(get_campo('CTAMTOIVA',xml2),''),'0'));
	rut_fac1:=get_campo('CTARUTFACTURADOR',xml2);
	xml2:=  put_campo(xml2,'CTANOMBREFACTURADOR',	coalesce(nullif(get_campo('CTANOMBREFACTURADOR',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAINDBONIFICABLE',	coalesce(nullif(get_campo('CTAINDBONIFICABLE',xml2),''),'0'));

	--Valida formato del Rut
        rut_con1:=motor_formato_rut(rut_con1);
        rut_fac1:=motor_formato_rut(rut_fac1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_con1='')	or (rut_fac1='')	then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
		--Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','Rut Incorrecto');

                return xml2;
        end if;
        --Retorno de datos.
        xml2    :=put_campo(xml2,'CTARUTCONVENIO',rut_con1);
        xml2    :=put_campo(xml2,'CTARUTFACTURADOR',rut_fac1);

Return xml2;
end;
$$
LANGUAGE plpgsql;

