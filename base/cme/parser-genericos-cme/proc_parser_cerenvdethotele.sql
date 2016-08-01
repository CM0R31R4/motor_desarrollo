CREATE OR REPLACE FUNCTION proc_parser_input_cerenvdethotele(varchar)
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

	xml2:=  put_campo(xml2,'CTACORRREGISTRO',	coalesce(nullif(get_campo('CTACORRREGISTRO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODFINANCIADOR',	coalesce(nullif(get_campo('CTACODFINANCIADOR',xml2),''),'0'));
	rut_con1:=get_campo('CTARUTCONVENIO',xml2);
	xml2:=  put_campo(xml2,'CTANUMCTA',	coalesce(nullif(get_campo('CTANUMCTA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANUMCOBRO',	coalesce(nullif(get_campo('CTANUMCOBRO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTATIPENVIO',	coalesce(nullif(get_campo('CTATIPENVIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODINTERVENPTD',	coalesce(nullif(get_campo('CTACODINTERVENPTD',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTADESCINTERVENPTD',	coalesce(nullif(get_campo('CTADESCINTERVENPTD',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODINTERVENHOM',	coalesce(nullif(get_campo('CTACODINTERVENHOM',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANROINTENVEN',	coalesce(nullif(get_campo('CTANROINTENVEN',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTATIPOVAL',	coalesce(nullif(get_campo('CTATIPOVAL',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAFECATENCION',	substring(replace(get_campo('CTAFECATENCION',xml2),'-',''),1,17));
	xml2:=  put_campo(xml2,'CTAHORAATENCION',	coalesce(nullif(get_campo('CTAHORAATENCION',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAURGENCIA',	coalesce(nullif(get_campo('CTAURGENCIA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTARECARGOHORA',coalesce(nullif(get_campo('CTARECARGOHORA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAORIGENATEN',	coalesce(nullif(get_campo('CTAORIGENATEN',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODPRESTPTD',coalesce(nullif(get_campo('CTACODPRESTPTD',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACOITEMPTD',	coalesce(nullif(get_campo('CTACOITEMPTD',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTADESCPRESTPTD',	coalesce(nullif(get_campo('CTADESCPRESTPTD',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODPRESTHOM',coalesce(nullif(get_campo('CTACODPRESTHOM',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACOITEMHOM',	coalesce(nullif(get_campo('CTACOITEMHOM',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACANTIDADPTD',coalesce(nullif(get_campo('CTACANTIDADPTD',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANRODIASCAMA',coalesce(nullif(get_campo('CTANRODIASCAMA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANROHORASCAMA',	coalesce(nullif(get_campo('CTANROHORASCAMA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTATIPOMOV',	coalesce(nullif(get_campo('CTATIPOMOV',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAMTOTOTAL',	coalesce(nullif(get_campo('CTAMTOTOTAL',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAMTOAFECTO',	coalesce(nullif(get_campo('CTAMTOAFECTO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAMTOEXENTO',	coalesce(nullif(get_campo('CTAMTOEXENTO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAMTOIVA',	coalesce(nullif(get_campo('CTAMTOIVA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAMTORECARGOHORARIO',	coalesce(nullif(get_campo('CTAMTORECARGOHORARIO',xml2),''),'0'));
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

