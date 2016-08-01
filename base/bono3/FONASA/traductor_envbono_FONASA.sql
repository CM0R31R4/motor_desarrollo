CREATE OR REPLACE FUNCTION traductor_in_envbono_fonasa(varchar)
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
	rut_asoc1	varchar;
	nom_prest1	varchar;
	rut_tratante1	varchar;
	rut_benef1	varchar;
	rut_cotiza1	varchar;
	rut_acomp1	varchar;
	rut_emisor1	varchar;
	rut_cajero1	varchar;
	cod_diag1	varchar;
	dscto_planilla1	varchar;
	monto_exec1	varchar;
	fecha_emision1	varchar;
	nivel_conv1	varchar;
	folio_financ1	varchar;
	monto_valor1	varchar;
	monto_aporte1	varchar;
	monto_copago1	varchar;
	num_opera1	varchar;
	corr_presta1	varchar;
	tipo_solic1	varchar;
	fecha_inicio1	varchar;
	urgencia1	varchar;
	plan1		varchar;
	lista1		varchar;

        cod_homol1 	varchar;
        item1		varchar;
        cod_adic1 	varchar;
        recargo1 	varchar;
        cantidad1 	varchar;
       	valor_prest1 	varchar;
        aporte_fin1 	varchar;
        copago1 	varchar;
        interno_isa1 	varchar;

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
        rut_asoc1       :=get_campo('EXTRUTASOCIADO',xml2);        -- char(12),
        nom_prest1      :=coalesce(nullif(get_campo('EXTNOMPRESTADOR',xml2),''),'0');      -- char(40),
        rut_tratante1   :=get_campo('EXTRUTTRATANTE',xml2);        -- char(12),
        rut_benef1      :=get_campo('EXTRUTBENEFICIARIO',xml2);    -- char(12),
        rut_cotiza1     :=get_campo('EXTRUTCOTIZANTE',xml2);       -- char(12),
        rut_acomp1      :=get_campo('EXTRUTACOMPANANTE',xml2);     -- char(12),
        rut_emisor1     :=get_campo('EXTRUTEMISOR',xml2);          -- char(12),
        rut_cajero1     :=get_campo('EXTRUTCAJERO',xml2);          -- char(12),
        cod_diag1       :=coalesce(nullif(get_campo('EXTCODIGODIAGNOSTICO',xml2),''),'0'); -- char(10),
        dscto_planilla1 :=coalesce(nullif(get_campo('EXTDESCUENTOXPLANILLA',xml2),''),'0');-- char(1),
        monto_exec1     :=coalesce(nullif(get_campo('EXTMONTOEXCEDENTE',xml2),''),'0');    -- numeric(10),
        fecha_emision1  :=to_char(get_campo('EXTFECHAEMISION',xml2)::date, 'YYYY/MM/DD');
        nivel_conv1     :=coalesce(nullif(get_campo('EXTNIVELCONVENIO',xml2),''),'0');   -- tinyint,
        folio_financ1   :=coalesce(nullif(get_campo('EXTFOLIOFINANCIADOR',xml2),''),'0');  -- numeric(10),
        monto_valor1    :=coalesce(nullif(get_campo('EXTMONTOVALORTOTAL',xml2),''),'0');   -- numeric(10),
        monto_aporte1   :=coalesce(nullif(get_campo('EXTMONTOAPORTETOTAL',xml2),''),'0');  -- numeric(10),
        monto_copago1   :=coalesce(nullif(get_campo('EXTMONTOCOPAGOTOTAL',xml2),''),'0');  -- numeric(10),
        num_opera1      :=coalesce(nullif(get_campo('EXTNUMOPERACION',xml2),''),'0');      -- numeric(10),
        corr_presta1    :=coalesce(nullif(get_campo('EXTCORRPRESTACION',xml2),''),'0');    -- numeric(10),
        tipo_solic1     :=coalesce(nullif(get_campo('EXTTIPOSOLICITUD',xml2),''),'0');     -- numeric(10),
	fecha_inicio1   :=to_char(get_campo('EXTFECHAINICIO',xml2)::date, 'YYYY/MM/DD');
        urgencia1       :=coalesce(nullif(get_campo('EXTURGENCIA',xml2),''),'0');                -- char(1),
        plan1           :=coalesce(nullif(get_campo('EXTPLAN',xml2),''),'0');            -- char(15),
	
	--Tengo que abrir la lista
	lista1		:=coalesce(nullif(get_campo('LSTPREST',xml2),''),'0');
	
	--Agrego el tag <wsc: a la lista
        lista1:=replace(replace(lista1,'<','<wsc:'),'<wsc:/','</wsc:');
        xml2    :=put_campo(xml2,'LSTPREST',lista1);	

	/*if length(lista1)>0 then
        	--cod_homol1 	:=coalesce(nullif(get_campo('EXTCODIGOHOMOLOGO',xml2),''),'0');
        	cod_homol1 	:=get_tag_xml_hex('extCodigoHomologo>',lista1);
	        item1		:=get_tag_xml_hex('extItem>',lista1);
        	cod_adic1 	:=get_tag_xml_hex('extCodigoAdicional>',lista1);
	        recargo1 	:=get_tag_xml_hex('extRecargoFueraHora>',lista1);
        	cantidad1 	:=get_tag_xml_hex('extCantidad>',lista1);
       		valor_prest1 	:=get_tag_xml_hex('extValorPrestacion>',lista1);
	        aporte_fin1 	:=get_tag_xml_hex('extAporteFinanciador>',lista1);
        	copago1 	:=get_tag_xml_hex('extCopago>',lista1);
	        interno_isa1 	:=get_tag_xml_hex('extInternoIsa>',lista1);
	end if;*/

        --lista1          :=coalesce(nullif(get_campo('EXTLISTA1',xml2),''),'0');          -- char(255),

	--Valida formato del Rut
        rut_conv1       :=motor_formato_rut(rut_conv1);
        rut_asoc1       :=motor_formato_rut(rut_asoc1);
        rut_tratante1   :=motor_formato_rut(rut_tratante1);
        rut_benef1      :=motor_formato_rut(rut_benef1);
        rut_cotiza1     :=motor_formato_rut(rut_cotiza1);
        rut_acomp1      :=motor_formato_rut(rut_acomp1);
        rut_emisor1     :=motor_formato_rut(rut_emisor1);
        rut_cajero1     :=motor_formato_rut(rut_cajero1);

        --Cuando retorno de funcion sea ''. Retorna error al flujo y no llama a la Api del financiador
        if (rut_conv1='')       or (rut_asoc1='')       or
           (rut_tratante1='')   or (rut_benef1='')      or
           (rut_cotiza1='')     or (rut_acomp1='')      or
           (rut_emisor1='')     or (rut_cajero1='')      then

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                return xml2;
        end if;
        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

	--Armo el Xml Request que va a Fonasa
        rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wsc="http://WSCerFonasaNM/">
	<soapenv:Header/>
	<soapenv:Body>
	    <wsc:EnvBono>
		<wsc:extCodFinanciador>'||cod_fin1||'</wsc:extCodFinanciador>
        	<wsc:extHomNumeroConvenio>'||num_conv1||'</wsc:extHomNumeroConvenio>
	        <wsc:extHomLugarConvenio>'||lugar_conv1||'</wsc:extHomLugarConvenio>
        	<wsc:extSucVenta>'||suc_venta1||'</wsc:extSucVenta>
	        <wsc:extRutConvenio>'||rut_conv1||'</wsc:extRutConvenio>
        	<wsc:extRutAsociado>'||rut_asoc1||'</wsc:extRutAsociado>
	        <wsc:extNomPrestador>'||nom_prest1||'</wsc:extNomPrestador>
        	<wsc:extRutTratante>'||rut_tratante1||'</wsc:extRutTratante>
	        <wsc:extRutBeneficiario>'||rut_benef1||'</wsc:extRutBeneficiario>
        	<wsc:extRutCotizante>'||rut_cotiza1||'</wsc:extRutCotizante>
	        <wsc:extRutAcompanante>'||rut_acomp1||'</wsc:extRutAcompanante>
        	<wsc:extRutEmisor>'||rut_emisor1||'</wsc:extRutEmisor>
	        <wsc:extRutCajero>'||rut_cajero1||'</wsc:extRutCajero>
        	<wsc:extCodigoDiagnostico>'||cod_diag1||'</wsc:extCodigoDiagnostico>
	        <wsc:extDescuentoxPlanilla>'||dscto_planilla1||'</wsc:extDescuentoxPlanilla>
        	<wsc:extMontoExcedente>'||monto_exec1||'</wsc:extMontoExcedente>
	        <wsc:extFechaEmision>'||fecha_emision1||'</wsc:extFechaEmision>
        	<wsc:extNivelConvenio>'||nivel_conv1||'</wsc:extNivelConvenio>
	        <wsc:extFolioFinanciador>'||folio_financ1||'</wsc:extFolioFinanciador>
        	<wsc:extMontoValorTotal>'||monto_valor1||'</wsc:extMontoValorTotal>
	        <wsc:extMontoAporteTotal>'||monto_aporte1||'</wsc:extMontoAporteTotal>
        	<wsc:extMontoCopagoTotal>'||monto_copago1||'</wsc:extMontoCopagoTotal>
	        <wsc:extNumOperacion>'||num_opera1||'</wsc:extNumOperacion>
        	<wsc:extCorrPrestacion>'||corr_presta1||'</wsc:extCorrPrestacion>
	        <wsc:extTipoSolicitud>'||tipo_solic1||'</wsc:extTipoSolicitud>
        	<wsc:extFechaInicio>'||fecha_inicio1||'</wsc:extFechaInicio>
	        <wsc:extUrgencia>'||urgencia1||'</wsc:extUrgencia>
        	<wsc:extPlan>'||plan1||'</wsc:extPlan>
		<wsc:lstPrest>'||lista1||'</wsc:lstPrest>
            </wsc:EnvBono>
        </soapenv:Body>
        </soapenv:Envelope>';		

	/*	<wsc:lstPrest>
            	    <wsc:EnvBono_ColInp>
               		<wsc:extCodigoHomologo>'||cod_homol1||'</wsc:extCodigoHomologo>
               		<wsc:extItem>'||item1||'</wsc:extItem>
               		<wsc:extCodigoAdicional>'||cod_adic1||'</wsc:extCodigoAdicional>
               		<wsc:extRecargoFueraHora>'||recargo1||'</wsc:extRecargoFueraHora>
               		<wsc:extCantidad>'||cantidad1||'</wsc:extCantidad>
               		<wsc:extValorPrestacion>'||valor_prest1||'</wsc:extValorPrestacion>
               		<wsc:extAporteFinanciador>'||aporte_fin1||'</wsc:extAporteFinanciador>
               		<wsc:extCopago>'||copago1||'</wsc:extCopago>
               		<wsc:extInternoIsa>'||interno_isa1||'</wsc:extInternoIsa>
            	    </wsc:EnvBono_ColInp>
         	</wsc:lstPrest>
	    </wsc:EnvBono>
	</soapenv:Body>
	</soapenv:Envelope>';*/

	--<extLista1>
   --0000301045|0 |0301045        |N|01|0002130|0002130|0000000|0              |0|0000000|0|0000000|0|0000000|0|0000000|0|0000000|

        data1:='POST /WSCerFonasa/WSCerFonasa.asmx HTTP/1.1'||chr(10)||
                'Accept-Encoding: gzip,deflate'||chr(10)||
                'Content-Type: text/xml;charset=UTF-8'||chr(10)||
                'SOAPAction: "http://WSCerFonasaNM/EnvBono"'||chr(10)||
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

CREATE OR REPLACE FUNCTION traductor_out_envbono_fonasa(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	rsp_xml1	varchar;
	cod_resp1       varchar;
        mensaje_resp1   varchar;	

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
        --Si tengo data y hay error HTTP 323030204f4b=200 OK
        if strpos(rsp_xml1,'323030204f4b')>0 then
                --Solo en envobono_real se decodifica a ascii para que se guarde correctamente
                --En la base de datos y en Percona
                cod_resp1       :=decode(trim(get_tag_xml_hex('extCodError',rsp_xml1)),'hex');
                mensaje_resp1   :=decode(trim(get_tag_xml_hex('extMensajeError',rsp_xml1)),'hex');
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

	xml2:=logapp(xml2,'FONASA: RSP_ENVBONO -> extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1);

	--Para que conteste con Campos en HEX
        xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');

        xml2:=put_campo(xml2,'ERRORCOD','30');
        xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        --xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);
	xml2:=put_campo(xml2,'EXTMENSAJEERROR',decode(mensaje_resp1,'HEX')::varchar);

        return xml2;
end;
$$
LANGUAGE plpgsql;
