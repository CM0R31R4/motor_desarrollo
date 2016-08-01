CREATE OR REPLACE FUNCTION traductor_in_grabaxmldec(varchar)
returns varchar as
$$
declare

        xml1    	alias for $1;
        xml2    	varchar;
        data1   	varchar;
        rqt_xml1 	varchar;

        num_acto_venta1 varchar;
        cod_fin1        varchar;
        xml_acto_venta1 varchar;
	fecha_emi1	varchar;
	codigo_motor1   varchar;
	sql_input1	varchar;

begin
        xml2:=xml1;
        xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	num_acto_venta1	:=get_campo('EXTNUMACTOVENTA',xml2);
        cod_fin1        :=trim(get_campo('EXTCODFINANCIADOR',xml2));
        --xml_acto_venta1 :=encode(get_campo('EXTXMLACTOVENTA',xml2),'base64');
        xml_acto_venta1 :=get_campo('EXTXMLACTOVENTA',xml2);
	codigo_motor1   :=get_campo('CODIGO_MOTOR',xml2);

	--Insert tabla tx_dec, campo xml_input
	xml2:=registra_tx_dec(xml2);

	-- Genera Actoventa DEC

	sql_input1	:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:wsdocs4">'||
			'<soapenv:Header/>'||
			'<soapenv:Body>'||
			'<urn:wsAddDoc soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'||
			'<ReqAdd xsi:type="urn:CAddDocsReq">'||
			'<wsUsuario xsi:type="xsd:string">Autentia</wsUsuario>'||
			'<wsClave xsi:type="xsd:string">@ut3nti4.</wsClave>'||
			'<Doc xsi:type="urn:CDocBas">'||
			'<CodPais xsi:type="xsd:string">CL</CodPais>'||
			'<Institucion xsi:type="xsd:string">BONO</Institucion>'||
			'<CodTipo xsi:type="xsd:string">ACTOVENTA</CodTipo>'||
			'<NomArchivo xsi:type="xsd:string">ActoVenta '||num_acto_venta1||'</NomArchivo>'||
			'<CodPaisCreador xsi:type="xsd:string">CL</CodPaisCreador>'||
			'<RutCreador xsi:type="xsd:string">1-9</RutCreador>'||
			'</Doc>'||
			--'<Info xsi:type="urn:CDocInfo">'||
			--'<CodigoDoc xsi:type="xsd:string"/>'||
			'<Descrip xsi:type="xsd:string">ActoVenta '||num_acto_venta1||'</Descrip>'||
			--'<Metadata xsi:type="xsd:string"/>'||
			--'<MetaTag xsi:type="xsd:string"/>'||
			--'<MimeType xsi:type="xsd:string">application/xml</MimeType>'||
			'<CodLugar xsi:type="xsd:string">CL</CodLugar>'||
			'<Estado>0</Estado>'||
               		--'<Tamano xsi:type="xsd:long"/>'||
			'<Archivo xsi:type="xsd:base64Binary">'||xml_acto_venta1||'</Archivo>'||
			--'<md5 xsi:type="xsd:string"/>'||
			--'<FecModific xsi:type="xsd:string"/>'||
			--'<NomEmpresa xsi:type="xsd:string"/>'||
			--'<RutHolding xsi:type="xsd:string"/>'||
			--'<RutEmpresa xsi:type="xsd:string"/>'||
			--'<UrlVerif xsi:type="xsd:string">1</UrlVerif>'||
			--'<xslVista xsi:type="xsd:base64Binary"/>'||
			'<Reserved>0</Reserved>'||
			'<LastY>0</LastY>'||
			'<nFirmados>0</nFirmados>'||
		/*               <Firmas xsi:type="urn:CFirmante">
                  <Rol xsi:type="xsd:string">0016513720-5</Rol>
                  <CodPaisRut xsi:type="xsd:string">CL</CodPaisRut>
                  <Rut xsi:type="xsd:string"/>
                  <NroAudit xsi:type="xsd:string"/>
                  <FecFirma xsi:type="xsd:string"/>
                  <email xsi:type="xsd:string">prueba@prueba.com</email>
                  <Descrip xsi:type="xsd:string"/>
                  <FlagsMail>0</FlagsMail>
                  <EstadoFirma>0</EstadoFirma>
                  <TipoFirma>0</TipoFirma>
                  <Institucion xsi:type="xsd:string">(personal)</Institucion>
                  <CodLugar xsi:type="xsd:string">CL</CodLugar>
                  <Orden>1</Orden>
                  <PatronFirma>0</PatronFirma>
                  <outHabilitado>0</outHabilitado>
               </Firmas>*/
		/*               <Coments xsi:type="urn:CComent">
                  <Rol xsi:type="xsd:string"></Rol>
                  <Rut xsi:type="xsd:string"></Rut>
                  <CodPais xsi:type="xsd:string"></CodPais>
                  <Fecha xsi:type="xsd:string"></Fecha>
                  <Texto xsi:type="xsd:string"></Texto>
               </Coments>*/
			--'<Relacion xsi:type="urn:CRelacion">'||
			--'<CodigoRel xsi:type="xsd:string"></CodigoRel>'||
			--'<Fecha xsi:type="xsd:string"></Fecha>'||
               		--'</Relacion>'||
			'</Info>'||
			'<bCodUrl>false</bCodUrl>'||
			'</ReqAdd>'||
			'</urn:wsAddDoc>'||
			'</soapenv:Body>'||
			'</soapenv:Envelope>';


	sql_input1	:='POST http://172.16.10.111/cgi-bin/autentia-docs4.cgi HTTP/1.1'||
			'Accept-Encoding: gzip,deflate'||
			'Content-Type: text/xml;charset=UTF-8'||
			'SOAPAction: "wsAddDoc"'||
			'User-Agent: Jakarta Commons-HttpClient/3.1'||
			'Host: 172.16.10.111'||
			'Content-Length: '||length(sql_input1)||
			sql_input1;

        xml2    :=put_campo(xml2,'SQLINPUT',sql_input1);
        xml2    :=put_campo(xml2,'__SECUENCIAOK__','500');
        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductor_out_grabaxmldec(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2   	 	varchar;
        rsp_xml1        varchar;

        cod_resp1       varchar;
        mensaje_resp1   varchar;
        codigo_dec1    	varchar;
        
begin
        
	xml2:=xml1;
        xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));
	xml2    :=put_campo(xml2,'INPUT','CLEAN');
	xml2    :=put_campo(xml2,'INPUT_ORI','CLEAN');

        --Paseo la respuesta
        rsp_xml1:=get_campo('SQLOUTPUT',xml2);
	xml2:=logapp(xml2,'SalidaDEC='||rsp_xml1);

        --Si no hay respuesta DEC
        /*if length(rsp_xml1)=0 then
                xml2:=put_campo(xml2,'ESTADO_WS','-1');
                xml2:=logapp(xml2,'Fonasa no Responde');
                return xml2;
        end if;*/

        --Si tengo data y hay error HTTP 200 OK=323030204f4b
        /*if strpos(rsp_xml1,'323030204f4b')>0 then
                cod_resp1       :=trim(get_tag_xml_hex('extCodError',rsp_xml1));
                mensaje_resp1   :=trim(get_tag_xml_hex('extMensajeError',rsp_xml1));
                codigo_dec1     :=trim(get_tag_xml_hex('extCodigoDec',rsp_xml1));

        else
                cod_resp1:='S';
                mensaje_resp1:=trim(get_tag_xml_hex('faultstring',rsp_xml1));
                xml2:=put_campo(xml2,'API_CODRESPUESTA','2');
                xml2:=put_campo(xml2,'API_ERROR','500');
                xml2:=put_campo(xml2,'API_DESCRIPCION_ERROR','Fonasa responde error');
                xml2:=logapp(xml2,'Fonasa no responde 200 OK');
                return xml2;
        end if;*/

	cod_resp1       :='00';
        mensaje_resp1   :='OK';
        --codigo_dec1     :='AAAA-1111-2222';
        codigo_dec1     :='AAAA11112222';

        xml2:=logapp(xml2,'DEC: RSP_GRABAXMLDEC -> extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1||' -extCodigoDec1='||codigo_dec1);

        --Para que conteste con Campos en HEX
	--xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');

	-- xml2:=put_campo(xml2,'ERRORCOD','30');
        -- xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);

        --Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        /*if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;*/

        xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);
        xml2:=put_campo(xml2,'EXTCODIGODEC',codigo_dec1);

        return xml2;
end;
$$
LANGUAGE plpgsql;

