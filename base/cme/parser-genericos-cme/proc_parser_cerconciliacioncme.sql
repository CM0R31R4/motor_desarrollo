--DROP FUNCTION proc_parser_input_cerenvcta(varchar);
CREATE OR REPLACE FUNCTION proc_parser_input_cerconciliacioncme(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	stCme   tx_ctamed%ROWTYPE;
        id_fin1         integer;
        cod_cme1        integer;
        tot_cme1        integer;	

	rut_con1	varchar;
begin
	xml2:=xml1;
	
	/*if length(get_campo('IDXTX',xml2)) = 0 then
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','Cme Sin Campo IdxTx');
                xml2:=logapp(xml2,'Cme Sin Campo IdxTx');
		return xml2;
	end if;*/

	id_fin1:=get_campo('ID_FIN',xml2)::integer;
        cod_cme1:=get_campo('COD_CME',xml2)::integer;

	--Busca encabezados CME
	SELECT * into stCme from tx_ctamed where cod_fin=id_fin1 and cod_ctamed=cod_cme1 and length(xml_input)>0 and tipo_tx in ('cerenvcta','cerencanam','cerencepi','cerencprot') and codigo_resp='1' order by fecha_in_tx desc limit 1;
        if not found then
                --Falla la conciliacion. Informa a Sonda y Financiador.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','Cme No Registra Encabezado');
                return xml2;
        end if;

        --Lee del xml_input los campos a enviar al SP.
	xml2:=logapp(xml2,'CtaRutConvenio='||get_xml('CtaRutConvenio',stCme.xml_input)||' -num_cta='||stCme.num_cta::varchar||' -CtaNumCobro='||get_xml('CtaNumCobro',stCme.xml_input)||' -CtaTipEnvio='||get_xml('CtaTipEnvio',stCme.xml_input));

        xml2:=put_campo(xml2,'CTARUTCONVENIO',get_xml('CtaRutConvenio',stCme.xml_input));
        --xml2:=put_campo(xml2,'CTANUMCTA',stCme.num_cta::varchar);
        xml2:=put_campo(xml2,'CTANUMCTA',get_xml('CtaNumCta',stCme.xml_input));
        xml2:=put_campo(xml2,'CTANUMCOBRO',get_xml('CtaNumCobro',stCme.xml_input));
        xml2:=put_campo(xml2,'CTATIPENVIO',get_xml('CtaTipEnvio',stCme.xml_input));
        xml2:=put_campo(xml2,'CTACONCILIACION','0');

	
	--Valida formato del Rut
        rut_con1       	:=motor_formato_rut(get_campo('CTARUTCONVENIO',xml2));

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_con1='') then 
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
		--Va directo a la respuesta del 8081.
	        xml2:=put_campo(xml2,'ERR','S');
	        xml2:=put_campo(xml2,'GLOSA','Rut Incorrecto');
                return xml2;
        end if;

Return xml2;
end;
$$
LANGUAGE plpgsql;

