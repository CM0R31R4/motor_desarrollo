CREATE OR REPLACE FUNCTION traductor_in_coptran_fonasa(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        data1	varchar;
        rqt_xml1	varchar;

	cod_fin1 	varchar;
	num_conv1	varchar;
	lugar_conv1	varchar;
	suc_venta1	varchar;
	rut_conv1	varchar;
	rut_tratante1	varchar;
	rut_solicita1	varchar;
	rut_benef1	varchar;
	tratamiento1	varchar;
	cod_diag1	varchar;
	nivel_conv1	varchar;
	urgencia1	varchar;
	num_presta1	varchar;
	plan1		varchar;
	lista1		varchar;
	i	integer =0;
	j	integer =0;

	cod_homol1      varchar;
        item1           varchar;
        cod_adic1       varchar;
        recargo1        varchar;
        cantidad1       varchar;

begin
        xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        :=get_campo('EXTCODFINANCIADOR',xml2);
        num_conv1       :=coalesce(nullif(get_campo('EXTHOMNUMEROCONVENIO',xml2),''),'0');
        lugar_conv1     :=coalesce(nullif(get_campo('EXTHOMLUGARCONVENIO',xml2),''),'0');
        suc_venta1      :=coalesce(nullif(get_campo('EXTSUCVENTA',xml2),''),'0');        -- char(10),
        rut_conv1       :=get_campo('EXTRUTCONVENIO',xml2);        -- char(12),
        rut_tratante1   :=get_campo('EXTRUTTRATANTE',xml2);        -- char(12),
        rut_solicita1   :=get_campo('EXTRUTSOLICITANTE',xml2);        -- char(12),
        rut_benef1      :=get_campo('EXTRUTBENEFICIARIO',xml2);    -- char(12),
        tratamiento1    :=coalesce(nullif(get_campo('EXTTRATAMIENTO',xml2),''),'0');      -- char(40),
        cod_diag1       :=coalesce(nullif(get_campo('EXTCODIGODIAGNOSTICO',xml2),''),'0'); -- char(10),
        nivel_conv1     :=coalesce(nullif(get_campo('EXTNIVELCONVENIO',xml2),''),'0');   -- tinyint,
        urgencia1       :=coalesce(nullif(get_campo('EXTURGENCIA',xml2),''),'0');                -- char(1),
	num_presta1   	:=coalesce(nullif(get_campo('EXTNUMPRESTACIONES',xml2),''),'0');    -- char(10),
        plan1           :=coalesce(nullif(get_campo('EXTPLAN2',xml2),''),'0');            -- char(15),
	
	--Tengo que abrir la lista
        lista1          :=coalesce(nullif(get_campo('LSTPREST',xml2),''),'0');
	
	--Agrego el tag <wsc: a la lista
	lista1:=replace(replace(lista1,'<','<wsc:'),'<wsc:/','</wsc:'); 
        xml2    :=put_campo(xml2,'LSTPREST',lista1);

	--Por ahora no abro la lista, envio lo que llega
        /*if length(lista1)>0 then
                cod_homol1      :=get_tag_xml_hex('extCodigoHomologo>',lista1);
                item1           :=get_tag_xml_hex('extItem>',lista1);
                cod_adic1       :=get_tag_xml_hex('extCodigoAdicional>',lista1);
                recargo1        :=get_tag_xml_hex('extRecargoFueraHora>',lista1);
                cantidad1       :=get_tag_xml_hex('extCantidad>',lista1);
        end if;*/

	--Valida formato del Rut
        rut_conv1       :=motor_formato_rut(rut_conv1);
        rut_tratante1   :=motor_formato_rut(rut_tratante1);
        rut_solicita1   :=motor_formato_rut(rut_solicita1);
        rut_benef1      :=motor_formato_rut(rut_benef1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_conv1='')       or (rut_tratante1='')	or
           (rut_solicita1='')   or (rut_benef1='')      then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;
        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);
	
	--Armo el Xml Request que va a Fonasa
        rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wsc="http://WSCerFonasaNM/"><soapenv:Header/><soapenv:Body><wsc:CopTran>
	<wsc:extCodFinanciador>'||cod_fin1||'</wsc:extCodFinanciador>
        <wsc:extHomNumeroConvenio>'||num_conv1||'</wsc:extHomNumeroConvenio>
        <wsc:extHomLugarConvenio>'||lugar_conv1||'</wsc:extHomLugarConvenio>
        <wsc:extSucVenta>'||suc_venta1||'</wsc:extSucVenta>
        <wsc:extRutConvenio>'||rut_conv1||'</wsc:extRutConvenio>
        <wsc:extRutTratante>'||rut_tratante1||'</wsc:extRutTratante>
        <wsc:extRutSolicitante>'||rut_solicita1||'</wsc:extRutSolicitante>
        <wsc:extRutBeneficiario>'||rut_benef1||'</wsc:extRutBeneficiario>
	<wsc:extTratamiento>'||tratamiento1||'</wsc:extTratamiento>
        <wsc:extCodigoDiagnostico>'||cod_diag1||'</wsc:extCodigoDiagnostico>
        <wsc:extNivelConvenio>'||nivel_conv1||'</wsc:extNivelConvenio>
        <wsc:extUrgencia>'||urgencia1||'</wsc:extUrgencia>
	<wsc:extNumPrestaciones>'||num_presta1||'</wsc:extNumPrestaciones>
        <wsc:extPlan2>'||plan1||'</wsc:extPlan2>
	<wsc:lstPrest>'||lista1||'</wsc:lstPrest>
        </wsc:CopTran></soapenv:Body></soapenv:Envelope>';


	/*    <wsc:CopTran_ColInp>
               <wsc:extCodigoHomologo>'||cod_homol1||'</wsc:extCodigoHomologo>
               <wsc:extItem>'||item1||'</wsc:extItem>
               <wsc:extCodigoAdicional>'||cod_adic1||'</wsc:extCodigoAdicional>
               <wsc:extRecargoFueraHora>'||recargo1||'</wsc:extRecargoFueraHora>
               <wsc:extCantidad>'||cantidad1||'</wsc:extCantidad>
            </wsc:CopTran_ColInp>
         </wsc:lstPrest>
	</wsc:CopTran></soapenv:Body></soapenv:Envelope>';*/

	/*<extLista1>0000301045|0 |0301045        |N|01|*/

        data1:='POST /WSCerFonasa/WSCerFonasa.asmx HTTP/1.1'||chr(10)||
                'Accept-Encoding: gzip,deflate'||chr(10)||
                'Content-Type: text/xml;charset=UTF-8'||chr(10)||
                'SOAPAction: "http://WSCerFonasaNM/CopTran"'||chr(10)||
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

CREATE OR REPLACE FUNCTION traductor_out_coptran_fonasa(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	rsp_xml1	varchar;

	cod_resp1       varchar;
        mensaje_resp1   varchar;	
        plan1		varchar;
	lista1		varchar;
	valor_prest1	varchar;	--extValorPrestacion
	aporte_fin1	varchar;	--extAporteFinanciador
	copago1		varchar;	--extCopago
	interno_isa1	varchar;	--extInternoIsa

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
        if strpos(rsp_xml1,'323030204f4b')>0 then --200 OK
        	cod_resp1	:=trim(get_tag_xml_hex('extCodError',rsp_xml1));
	        mensaje_resp1	:=trim(get_tag_xml_hex('extMensajeError',rsp_xml1));
        	plan1		:=trim(get_tag_xml_hex('extPlan',rsp_xml1));
        	lista1		:=trim(get_tag_xml_hex('lstValores',rsp_xml1));
        	/*valor_prest1	:=trim(get_tag_xml_hex('extValorPrestacion',rsp_xml1));
        	aporte_fin1	:=trim(get_tag_xml_hex('extAporteFinanciador',rsp_xml1));
        	copago1		:=trim(get_tag_xml_hex('extCopago',rsp_xml1));
        	interno_isa1	:=trim(get_tag_xml_hex('extInternoIsa',rsp_xml1));*/
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

	xml2:=logapp(xml2,'FONASA: RSP_COPTRAN -> extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1||' -extPlan1='||plan1||' -extLista1='||lista1);

	--Para que conteste con Campos en HEX
        xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');

        xml2:=put_campo(xml2,'ERRORCOD','30');
        xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);
        xml2:=put_campo(xml2,'EXTPLAN',plan1);
        xml2:=put_campo(xml2,'LSTVALORES',lista1);
        
	/*xml2:=put_campo(xml2,'EXTVALORPRESTACION',valor_prest1);
        xml2:=put_campo(xml2,'EXTAPORTEFINANCIADOR',aporte_fin1);
        xml2:=put_campo(xml2,'EXTCOPAGO',copago1);
        xml2:=put_campo(xml2,'EXTINTERNOISA',interno_isa1);*/

        return xml2;
end;
$$
LANGUAGE plpgsql;
