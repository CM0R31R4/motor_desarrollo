CREATE OR REPLACE FUNCTION traductor_in_anulabonou_fonasa(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	data1   varchar;
        rqt_xml1 varchar;

	cod_fin1 	varchar;
	folio_bono1	varchar;
	id_tratam1	varchar;
	fecha_tratam1	varchar;
begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        :=trim(get_campo('EXTCODFINANCIADOR',xml2));
        folio_bono1     :=coalesce(nullif(get_campo('EXTFOLIOBONO',xml2),''),'0');
        id_tratam1      :=coalesce(nullif(get_campo('EXTINDTRATAM',xml2),''),'0');
        fecha_tratam1   :=to_char(get_campo('EXTFECTRATAM',xml2)::date, 'YYYY/MM/DD');
	
	--Armo el Xml Request que va a Fonasa
        rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wsc="http://WSCerFonasaNM/"><soapenv:Header/><soapenv:Body><wsc:AnulaBonoU><wsc:extCodFinanciador>'||cod_fin1||'</wsc:extCodFinanciador><wsc:extFolioBono>'||folio_bono1||'</wsc:extFolioBono><wsc:extTratamiento>'||id_tratam1||'</wsc:extTratamiento><wsc:extFechaInicio>'||fecha_tratam1||'</wsc:extFechaInicio></wsc:AnulaBonoU></soapenv:Body></soapenv:Envelope>';

        data1:='POST /WSCerFonasa/WSCerFonasa.asmx HTTP/1.1'||chr(10)||
                'Accept-Encoding: gzip,deflate'||chr(10)||
                'Content-Type: text/xml;charset=UTF-8'||chr(10)||
                'SOAPAction: "http://WSCerFonasaNM/AnulaBonoU"'||chr(10)||
                'User-Agent: Jakarta Commons-HttpClient/3.1'||chr(10)||
                'Host: 10.100.32.129'||chr(10)||
                'Content-Length: '||length(rqt_xml1)||chr(10)||chr(10)||rqt_xml1;

        --Envio la data
        xml2:=put_campo(xml2,'SQLINPUT',data1);
        --xml2:=put_campo(xml2,'RQT_XML',data1);

	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_anulabonou_fonasa(varchar)
returns varchar as
$$
declare
        xml1		alias for $1;
        xml2		varchar;
	rsp_xml1        varchar;

	cod_resp1	varchar;
	mensaje_resp1	varchar;
begin
        xml2:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Paseo la respuesta
        --rsp_xml1:=get_campo('RSP_XML',xml2);
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
	else
		cod_resp1:='S';
		--mensaje_resp1:='Error Call Fonasa_WS';
		mensaje_resp1:=trim(get_tag_xml('faultstring',rsp_xml1));
		xml2:=put_campo(xml2,'API_CODRESPUESTA','2');
                xml2:=put_campo(xml2,'API_ERROR','500');
                xml2:=put_campo(xml2,'API_DESCRIPCION_ERROR','Fonasa responde error');
                xml2:=logapp(xml2,'Fonasa no responde 200 OK');
                return xml2;
	end if;

	xml2:=logapp(xml2,'FONASA: RSP_ANULANONO -> extCodError='||cod_resp1||' -extMensajeError='||mensaje_resp1);

	--Para que conteste con Campos en HEX
        xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');

        xml2:=put_campo(xml2,'ERRORCOD','30'); --En hexadecimal
        xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);

        return xml2;
end;
$$
LANGUAGE plpgsql;

