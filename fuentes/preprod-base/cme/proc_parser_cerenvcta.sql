--DROP FUNCTION proc_parser_input_cerenvcta(varchar);
CREATE OR REPLACE FUNCTION proc_parser_cerenvcta(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	
	rut_cot1	varchar;
	rut_ben1	varchar;
	rut_con1	varchar;
	rut_tra1	varchar;

begin
	xml2:=xml1;
	if length(get_campo('IDXTX',xml2)) = 0 then
	        --Va directo a la respuesta del 8081.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','CME Sin Campo IdxTx');
		return xml2;
	end if;
	
	xml2:=	put_campo(xml2,'CTACODFINANCIADOR',	coalesce(nullif(get_campo('CODFINANCIADOR',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANUMCTA',		coalesce(nullif(get_campo('CTANUMCTA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANUMCOBRO',		coalesce(nullif(get_campo('CTANUMCOBRO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTATIPENVIO',		coalesce(nullif(get_campo('CTATIPENVIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAHOMNROCONVENIO',	coalesce(nullif(get_campo('CTAHOMNROCONVENIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAHOMLUGARCONVENIO',	coalesce(nullif(get_campo('CTAHOMLUGARCONVENIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTATIPCTA',		coalesce(nullif(get_campo('CTATIPCTA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAFECEMISION',		coalesce(nullif(get_campo('CTAFECEMISION',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAFECINGRESO',		coalesce(nullif(get_campo('CTAFECINGRESO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAHORAINGRESO',	coalesce(nullif(get_campo('CTAHORAINGRESO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAFECCORTE',		coalesce(nullif(get_campo('CTAFECCORTE',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAFECALTA',		coalesce(nullif(get_campo('CTAFECALTA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAHORAALTA',		coalesce(nullif(get_campo('CTAHORAALTA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAFECFUR',		coalesce(nullif(get_campo('CTAFECFUR',xml2),''),'0'));
	rut_cot1:=get_campo('CTARUTCOTIZANTE',xml2);
	xml2:=  put_campo(xml2,'CTANOMBRECOTIZANTE',	coalesce(nullif(get_campo('CTANOMBRECOTIZANTE',xml2),''),'0'));
	rut_ben1:=get_campo('CTARUTBENEFICIARIO',xml2);
	xml2:=  put_campo(xml2,'CTAAPELLIDOPAT',	coalesce(nullif(get_campo('CTAAPELLIDOPAT',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAAPELLIDOMAT',	coalesce(nullif(get_campo('CTAAPELLIDOMAT',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANOMBRES',		coalesce(nullif(get_campo('CTANOMBRES',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODDIAGPRI',		coalesce(nullif(get_campo('CTACODDIAGPRI',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAGLODIAGPRIN',	coalesce(nullif(get_campo('CTAGLODIAGPRIN',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACODDIAGSEC',		coalesce(nullif(get_campo('CTACODDIAGSEC',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAGLODIAGSEC',		coalesce(nullif(get_campo('CTAGLODIAGSEC',xml2),''),'0'));
	rut_con1:=get_campo('CTARUTCONVENIO',xml2);
	rut_tra1:=get_campo('CTARUTTRATANTE',xml2);
	xml2:=  put_campo(xml2,'CTANOMBRETRATANTE',	coalesce(nullif(get_campo('CTANOMBRETRATANTE',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTATIPCOBRO',		coalesce(nullif(get_campo('CTATIPCOBRO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTATIPSALA',		coalesce(nullif(get_campo('CTATIPSALA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTACARTARESGUARDO',	coalesce(nullif(get_campo('CTACARTARESGUARDO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTALEYURGENCIA',	coalesce(nullif(get_campo('CTALEYURGENCIA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAINDCAEC',		coalesce(nullif(get_campo('CTAINDCAEC',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAINDAUGE',		coalesce(nullif(get_campo('CTAINDAUGE',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANROCIRUGIAS',	coalesce(nullif(get_campo('CTANROCIRUGIAS',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANROEQUIPMED',	coalesce(nullif(get_campo('CTANROEQUIPMED',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAINDENVIO',		coalesce(nullif(get_campo('CTAINDENVIO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAMTOTOTAL',		coalesce(nullif(get_campo('CTAMTOTOTAL',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANUMDETEQUIPO',	coalesce(nullif(get_campo('CTANUMDETEQUIPO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAMTODETEQUIPO',	coalesce(nullif(get_campo('CTAMTODETEQUIPO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANUMDETHOTELERIA',	coalesce(nullif(get_campo('CTANUMDETHOTELERIA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAMTODETHOTELERIA',	coalesce(nullif(get_campo('CTAMTODETHOTELERIA',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANUMDETINSUMO',	coalesce(nullif(get_campo('CTANUMDETINSUMO',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAMTODETINSUMOS',	coalesce(nullif(get_campo('CTAMTODETINSUMOS',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTANUMDETPAQUETES',	coalesce(nullif(get_campo('CTANUMDETPAQUETES',xml2),''),'0'));
	xml2:=  put_campo(xml2,'CTAMTODETPAQUETES',	coalesce(nullif(get_campo('CTAMTODETPAQUETES',xml2),''),'0'));

	--Valida formato del Rut
        rut_cot1	:=motor_formato_rut(rut_cot1);
        rut_ben1      	:=motor_formato_rut(rut_ben1);
        rut_con1       	:=motor_formato_rut(rut_con1);
        rut_tra1   	:=motor_formato_rut(rut_tra1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_cot1='')	or (rut_ben1='')	or
           (rut_con1='')   	or (rut_tra1='')      	then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
		
		--Va directo a la respuesta del 8081.
	        xml2:=put_campo(xml2,'ERR','S');
	        xml2:=put_campo(xml2,'GLOSA','Rut Incorrecto');
	
                return xml2;
        end if;
        --Retorno de datos.
        xml2    :=put_campo(xml2,'CTARUTCOTIZANTE',rut_cot1);
        xml2    :=put_campo(xml2,'CTARUTBENEFICIARIO',rut_ben1);
        xml2    :=put_campo(xml2,'CTARUTCONVENIO',rut_con1);
        xml2    :=put_campo(xml2,'CTARUTTRATANTE',rut_tra1);

Return xml2;
end;
$$
LANGUAGE plpgsql;

