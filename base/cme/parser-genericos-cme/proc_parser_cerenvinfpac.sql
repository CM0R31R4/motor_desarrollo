CREATE OR REPLACE FUNCTION proc_parser_input_cerenvinfpac(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	
	rut_con1	varchar;

begin
	xml2:=xml1;
	


	xml2:=  put_campo(xml2,'CTACORRREGISTRO',	coalesce(nullif(get_campo('CTACORRREGISTRO',xml2),''),'0'));	
	xml2:=  put_campo(xml2,'CTACODFINANCIADOR',	coalesce(nullif(get_campo('CTACODFINANCIADOR',xml2),''),'0'));	
	rut_con1:=get_campo('CTARUTCONVENIO',xml2);		
	xml2:=  put_campo(xml2,'CTANUMCTA',	coalesce(nullif(get_campo('CTANUMCTA',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTANUMCOBRO',	coalesce(nullif(get_campo('CTANUMCOBRO',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTATIPENVIO',	coalesce(nullif(get_campo('CTATIPENVIO',xml2),''),'0'));		

	xml2:=  put_campo(xml2,'CTAPACCALLE',	coalesce(nullif(get_campo('CTAPACCALLE',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTAPACNRO',	coalesce(nullif(get_campo('CTAPACNRO',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTAPACDPTO',	coalesce(nullif(get_campo('CTAPACDPTO',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTAPACCOMUNA',	coalesce(nullif(get_campo('CTAPACCOMUNA',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTAPACCIUDAD',	coalesce(nullif(get_campo('CTAPACCIUDAD',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTAPACREGION',	coalesce(nullif(get_campo('CTAPACREGION',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTAPACFONCASA',	coalesce(nullif(get_campo('CTAPACFONCASA',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTAPACFONCEL',	coalesce(nullif(get_campo('CTAPACFONCEL',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTAPACFONOFIC',	coalesce(nullif(get_campo('CTAPACFONOFIC',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTAPACMAIL',	coalesce(nullif(get_campo('CTAPACMAIL',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTAFECALTA',	substring(replace(get_campo('CTAFECALTA',xml2),'-',''),1,17));
	xml2:=  put_campo(xml2,'CTAHORALTA',	coalesce(nullif(get_campo('CTAHORALTA',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTAOBSERV1',	coalesce(nullif(get_campo('CTAOBSERV1',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTAOBSERV2',	coalesce(nullif(get_campo('CTAOBSERV2',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTAOBSERV3',	coalesce(nullif(get_campo('CTAOBSERV3',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTANUMCTAREL',	coalesce(nullif(get_campo('CTANUMCTAREL',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTANUMCOBROREL',coalesce(nullif(get_campo('CTANUMCOBROREL',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTATIPENVIOREL',coalesce(nullif(get_campo('CTATIPENVIOREL',xml2),''),'0'));		
	xml2:=  put_campo(xml2,'CTAFECINICIOCORTE',	substring(replace(get_campo('CTAFECINICIOCORTE',xml2),'-',''),1,17));
	xml2:=  put_campo(xml2,'CTAHORAINICIOCORTE',	coalesce(nullif(get_campo('CTAHORAINICIOCORTE',xml2),''),'0'));	
	xml2:=  put_campo(xml2,'CTAHORATERMINOCORTE',	coalesce(nullif(get_campo('CTAHORATERMINOCORTE',xml2),''),'0'));

	--Valida formato del Rut
        rut_con1:=motor_formato_rut(rut_con1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_con1='')	then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;
        --Retorno de datos.
        xml2    :=put_campo(xml2,'CTARUTCONVENIO',rut_con1);

Return xml2;
end;
$$
LANGUAGE plpgsql;

