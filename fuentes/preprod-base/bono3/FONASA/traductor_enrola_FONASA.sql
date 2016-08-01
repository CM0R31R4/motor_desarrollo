CREATE OR REPLACE FUNCTION traductor_in_enrola_fonasa(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	data1	varchar;
	rqt_xml1	varchar;

	cod_fin1 	varchar;
        rut_enrola1	varchar;
        rut_benef1	varchar;

begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));
	
	cod_fin1        :=get_campo('EXTCODFINANCIADOR',xml2);
        rut_enrola1     :=get_campo('EXTRUTENROLAR',xml2);
        rut_benef1      :=get_campo('EXTRUTBENEFICIARIO',xml2);

	--Valida formato del Rut
        /*rut_enrola1:=motor_formato_rut(rut_enrola1);
        rut_benef1:=motor_formato_rut(rut_benef1);
        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_enrola1='') or (rut_benef1='')  then
                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;*/
        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

        --Armo el Xml Request que va a Fonasa
        rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wsc="http://WSCerFonasaNM/"><soapenv:Header/><soapenv:Body><wsc:Enrola><wsc:extCodFinanciador>'||cod_fin1||'</wsc:extCodFinanciador><wsc:extRutEnrolar>'||rut_enrola1||'</wsc:extRutEnrolar><wsc:extRutBeneficiario>'||rut_benef1||'</wsc:extRutBeneficiario></wsc:Enrola></soapenv:Body></soapenv:Envelope>';

        data1:='POST /WSCerFonasa/WSCerFonasa.asmx HTTP/1.1'||chr(10)||
                'Accept-Encoding: gzip,deflate'||chr(10)||
                'Content-Type: text/xml;charset=UTF-8'||chr(10)||
                'SOAPAction: "http://WSCerFonasaNM/Enrola"'||chr(10)||
                'User-Agent: Jakarta Commons-HttpClient/3.1'||chr(10)||
                'Host: 10.100.32.129'||chr(10)||
                'Content-Length: '||length(rqt_xml1)||chr(10)||chr(10)||rqt_xml1;

        --Envio la data
        xml2:=put_campo(xml2,'SQLINPUT',data1);
        --xml2:=put_campo(xml2,'INPUT',data1);

	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_enrola_fonasa(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	rsp_xml1        varchar;

	cod_resp1	varchar;
	mensaje_resp1	varchar;
	valido1		varchar;
	nombre1		varchar;
	
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Parseo la Respuesta
	rsp_xml1:=get_campo('SQLOUTPUT',xml2);

        --Si no hay respuesta Fonasa.
        if length(rsp_xml1)=0 then
                xml2:=put_campo(xml2,'ESTADO_WS','-1');
		xml2:=logapp(xml2,'Fonasa no Responde');
                return xml2;
        end if;

	--Si tengo data y hay error HTTP
        if strpos(rsp_xml1,'323030204f4b')>0 then
		cod_resp1	:=trim(get_tag_xml_hex('extCodError',rsp_xml1));
		mensaje_resp1	:=trim(get_tag_xml_hex('extMensajeError',rsp_xml1));
		valido1		:=trim(get_tag_xml_hex('extValido',rsp_xml1));
		nombre1		:=trim(get_tag_xml_hex('extNombreComp',rsp_xml1));
        else
                cod_resp1:='S';
                --mensaje_resp1:='Error Call Fonasa_WS';
                mensaje_resp1:=trim(get_tag_xml_hex('faultstring',rsp_xml1));
		xml2:=put_campo(xml2,'API_CODRESPUESTA','2');
                xml2:=put_campo(xml2,'API_ERROR','500');
                xml2:=put_campo(xml2,'API_DESCRIPCION_ERROR','Fonasa responde error');
                xml2:=logapp(xml2,'Fonasa no responde 200 OK');
                return xml2;
        end if;

	xml2:=logapp(xml2,'FONASA: RSP_ENROLA -> extValido='||valido1||' -extNombreComp='||nombre1);
	--Para que conteste con Campos en HEX
        xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');
	
        xml2:=put_campo(xml2,'ERRORCOD','30');
        xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'EXTVALIDO',valido1);
        xml2:=put_campo(xml2,'EXTNOMBRECOMP',nombre1);

        return xml2;
end;
$$
LANGUAGE plpgsql;
