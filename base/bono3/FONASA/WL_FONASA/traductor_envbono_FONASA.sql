CREATE OR REPLACE FUNCTION traductorWL_in_envbono_fonasa(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
        data1		varchar;
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

	num_vueltas	integer=0;
	extrae_lista1   varchar;
	prepara_lista1  varchar='';
	i      		integer=0;
begin
        xml2	:=xml1;
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
        fecha_emision1  :=to_char(get_campo('EXTFECHAEMISION',xml2)::date, 'YYYYMMDD');
        --fecha_emision1  :=get_campo('EXTFECHAEMISION',xml2);
	nivel_conv1     :=coalesce(nullif(get_campo('EXTNIVELCONVENIO',xml2),''),'0');   -- tinyint,
        folio_financ1   :=coalesce(nullif(get_campo('EXTFOLIOFINANCIADOR',xml2),''),'0');  -- numeric(10),
        monto_valor1    :=coalesce(nullif(get_campo('EXTMONTOVALORTOTAL',xml2),''),'0');   -- numeric(10),
        monto_aporte1   :=coalesce(nullif(get_campo('EXTMONTOAPORTETOTAL',xml2),''),'0');  -- numeric(10),
        monto_copago1   :=coalesce(nullif(get_campo('EXTMONTOCOPAGOTOTAL',xml2),''),'0');  -- numeric(10),
        num_opera1      :=coalesce(nullif(get_campo('EXTNUMOPERACION',xml2),''),'0');      -- numeric(10),
        corr_presta1    :=coalesce(nullif(get_campo('EXTCORRPRESTACION',xml2),''),'0');    -- numeric(10),
        tipo_solic1     :=coalesce(nullif(get_campo('EXTTIPOSOLICITUD',xml2),''),'0');     -- numeric(10),
	fecha_inicio1   :=to_char(get_campo('EXTFECHAINICIO',xml2)::date, 'YYYYMMDD');
        --fecha_inicio1   :=get_campo('EXTFECHAINICIO',xml2);
	urgencia1       :=coalesce(nullif(get_campo('EXTURGENCIA',xml2),''),'0');        -- char(1),
        plan1           :=coalesce(nullif(get_campo('EXTPLAN',xml2),''),'0');            -- char(15),
	
	-- Abre la lista.
	lista1		:=coalesce(nullif(get_campo('LSTPREST',xml2),''),'0');
	lista1          :=replace(replace(replace(lista1,'\012',''),'\011',''),' ','');

	xml2:=logapp(xml2,'LISTA1_INPUT ='||lista1);

	IF length(lista1)>0 THEN
		num_vueltas     :=cuenta_palabras(lista1, '/extCodigoHomologo');

		xml2:=logapp(xml2,'CUENTA_PALABRAS='||num_vueltas);
		
		FOR i IN 1..num_vueltas LOOP
			extrae_lista1   :=xml_to_json(lista1,i,'<EnvBono_ColInp>','</EnvBono_ColInp>');

        		cod_homol1 	:=get_tag_xml('<extCodigoHomologo>',extrae_lista1);
	       	 	item1		:=get_tag_xml('<extItem>',extrae_lista1);
        		--cod_adic1 	:=get_tag_xml('<extCodigoAdicional>',extrae_lista1);
	        	recargo1 	:=get_tag_xml('<extRecargoFueraHora>',extrae_lista1);
        		cantidad1 	:=get_tag_xml('<extCantidad>',extrae_lista1);
       			valor_prest1 	:=get_tag_xml('<extValorPrestacion>',extrae_lista1);
	        	aporte_fin1 	:=get_tag_xml('<extAporteFinanciador>',extrae_lista1);
        		copago1 	:=get_tag_xml('<extCopago>',extrae_lista1);
	        	--interno_isa1 	:=get_tag_xml('<extInternoIsa>',extrae_lista1);

			prepara_lista1	:=prepara_lista1||'{"extCodHomologo":"'||cod_homol1||'","extItem":"'||item1||'","extRecargoHora":"'||recargo1||'","extCantidad":"'||cantidad1||'","extValorPrestac":"'||valor_prest1||'","extAporteFin":"'||aporte_fin1||'","extCopago":"'||copago1||'"},';
		
		END LOOP;
	END IF;

	-- Quita la ultima coma.
        lista1	:=substring(prepara_lista1, 1, (length(prepara_lista1) - 1));

	xml2    :=put_campo(xml2,'LSTPREST',lista1);

	-- Valida formato del RUT.
        rut_conv1       :=motor_formato_rut(rut_conv1);
        rut_asoc1       :=motor_formato_rut(rut_asoc1);
        rut_tratante1   :=motor_formato_rut(rut_tratante1);
        rut_benef1      :=motor_formato_rut(rut_benef1);
        rut_cotiza1     :=motor_formato_rut(rut_cotiza1);
        rut_acomp1      :=motor_formato_rut(rut_acomp1);
        rut_emisor1     :=motor_formato_rut(rut_emisor1);
        rut_cajero1     :=motor_formato_rut(rut_cajero1);

        --Cuando retorno de funcion sea '' retorna error al flujo y no llama a la API del financiador.
        IF (rut_conv1='')       OR (rut_asoc1='')       OR
           (rut_tratante1='')   OR (rut_benef1='')      OR
           (rut_cotiza1='')     OR (rut_acomp1='')      OR
           (rut_emisor1='')     OR (rut_cajero1='')     THEN

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                
		RETURN xml2;
        END IF;

        --Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);

	--Arma el XML request que va a FONASA.
        --rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
	--<soapenv:Header/>
	--<soapenv:Body>
	    --<tem:wmImed_SrvCEREnvBono><tem:JSON_INPUT>{"extCodFinanciador":"'||cod_fin1||'","extHomNumeroConvenio":"'||num_conv1||'", "extHomLugarConvenio":"'||lugar_conv1||'","extSucVenta":"'||suc_venta1||'","extRutConvenio":"'||rut_conv1||'","extRutAsociado":"'||rut_asoc1||'","extNomPrestador":"'||nom_prest1||'","extRutTratante":"'||rut_tratante1||'","extRutBeneficiario":"'||rut_benef1||'","extRutCotizante":"'||rut_cotiza1||'","extRutAcompanante":"'||rut_acomp1||'","extRutEmisor":"'||rut_emisor1||'","extRutCajero":"'||rut_cajero1||'","extCodigoDiagnostico":"'||cod_diag1||'","extDescuentoxPlanilla":"'||dscto_planilla1||'","extMontoExcedente":"'||monto_exec1||'","extFechaEmision":"'||fecha_emision1||'","extNivelConvenio":"'||nivel_conv1||'","extFolioFinanciador":"'||folio_financ1||'","extMontoValorTotal":"'||monto_valor1||'","extMontoAporteTotal":"'||monto_aporte1||'","extMontoCopagoTotal":"'||monto_copago1||'","extNumOperacion":"'||num_opera1||'","extCorrPrestacion":"'||corr_presta1||'","extTipoSolicitud":"'||tipo_solic1||'","extFechaInicio":"'||fecha_inicio1||'","extUrgencia":"'||urgencia1||'","extPlan":"'||plan1||'","lstPrest":'||lista1||'}</tem:JSON_INPUT></tem:wmImed_SrvCEREnvBono></soapenv:Body></soapenv:Envelope>';		
	
	rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
        <soapenv:Header/>
        <soapenv:Body>
            <tem:wmImed_SrvCEREnvBono><tem:JSON_INPUT>{"extCodFinanciador":"'||cod_fin1||'","extHomNumeroConvenio":"'||num_conv1||'", "extHomLugarConvenio":"'||lugar_conv1||'","extSucVenta":"'||suc_venta1||'","extRutConvenio":"'||rut_conv1||'","extRutAsociado":"'||rut_asoc1||'","extNomPrestador":"'||nom_prest1||'","extRutTratante":"'||rut_tratante1||'","extRutBeneficiario":"'||rut_benef1||'","extRutCotizante":"'||rut_cotiza1||'","extRutAcompanante":"'||rut_acomp1||'","extRutEmisor":"'||rut_emisor1||'","extRutCajero":"'||rut_cajero1||'","extCodigoDiagnostico":"'||cod_diag1||'","extDescuentoxPlanilla":"'||dscto_planilla1||'","extMontoExcedente":"'||monto_exec1||'","extFechaEmision":"'||fecha_emision1||'","extNivelConvenio":"'||nivel_conv1||'","extFolioFinanciador":"'||folio_financ1||'","extMontoValorTotal":"'||monto_valor1||'","extMontoAporteTotal":"'||monto_aporte1||'","extMontoCopagoTotal":"'||monto_copago1||'","extNumOperacion":"'||num_opera1||'","extCorrPrestacion":"'||corr_presta1||'","extTipoSolicitud":"'||tipo_solic1||'","extFechaInicio":"'||fecha_inicio1||'","lista":['||lista1||']}</tem:JSON_INPUT></tem:wmImed_SrvCEREnvBono></soapenv:Body></soapenv:Envelope>';
	


	data1:='POST http://10.152.126.17:7001/ebonows/services/wsCEREnvBonoSoap HTTP/1.1'||chr(10)||
                'Accept-Encoding: gzip,deflate'||chr(10)||
                'Content-Type: text/xml;charset=UTF-8'||chr(10)||
                'SOAPAction: "http://tempuri.org/wmImed_SrvCEREnvBono"'||chr(10)||
                'User-Agent: Apache-HttpClient/4.1.1 (java 1.5)'||chr(10)||
                'Host: 10.152.126.17:7001'||chr(10)||
                'Content-Length: '||length(rqt_xml1)||chr(10)||chr(10)||rqt_xml1;

        -- Envia la data.
        xml2:=put_campo(xml2,'SQLINPUT',data1);

        RETURN xml2;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductorWL_out_envbono_fonasa(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	rsp_xml1	varchar;
	cod_resp1       varchar;
        mensaje_resp1   varchar;	

	wmImed_SrvCEREnvBonoResult	varchar;
begin
        xml2	:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','Transaccion_OK');
        xml2    :=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	IF strpos(get_campo('SQLOUTPUT',xml2),'323030204f4b')>0 THEN
		-- Decodifica SQLOUTPUT.
                xml2:=put_campo(xml2,'SQLOUTPUT',decode(get_campo('SQLOUTPUT',xml2),'HEX')::varchar);

                xml2:=logapp(xml2,'SQLOUTPUT DECODIFICADO = '||get_campo('SQLOUTPUT',xml2));

                -- Limpia el SQLOUTPUT
                xml2:=put_campo(xml2,'SQLOUTPUT',replace(get_campo('SQLOUTPUT',xml2),'&quot;','"'));

		-- Parsea la respuesta.
		rsp_xml1:=get_campo('SQLOUTPUT',xml2);
		
		-- Analiza respuesta de FONASA.
                IF length(rsp_xml1)=0 THEN
                        xml2:=put_campo(xml2,'ESTADO_WS','-1');
                        xml2:=logapp(xml2,'FONASA no responde');

                        RETURN xml2;
                END IF;

		--Extrae todo lo que esta en el tag.
                wmImed_SrvCEREnvBonoResult:=trim(get_tag_xml('<wmImed_SrvCEREnvBonoResult>',rsp_xml1));

		xml2:=logapp(xml2,'TAG ='||wmImed_SrvCEREnvBonoResult);

                -- Solo en ENVBONO_REAL se decodifica a ascii para que se guarde correctamente
                -- en la base de datos y en Percona (MySQL).
		cod_resp1       :=encode(replace(json_field(wmImed_SrvCEREnvBonoResult,'extCodError'),'"','')::bytea,'HEX');
                mensaje_resp1   :=encode(replace(json_field(wmImed_SrvCEREnvBonoResult,'extMensajeError'),'"','')::bytea,'HEX');
	else
                cod_resp1:='S';
                mensaje_resp1:=trim(get_tag_xml_hex('faultstring',rsp_xml1));
		xml2:=put_campo(xml2,'API_CODRESPUESTA','2');
                xml2:=put_campo(xml2,'API_ERROR','500');
                xml2:=put_campo(xml2,'API_DESCRIPCION_ERROR','FONASA responde error');
                xml2:=logapp(xml2,'FONASA no responde 200 OK');
		return xml2;
        end if;

	xml2:=logapp(xml2,'FONASA: RSP_ENVBONO -> extCodResp1='||decode(cod_resp1,'HEX')::varchar||' -extMensajeResp1='||decode(mensaje_resp1,'HEX')::varchar);

	--Para que conteste con campos en HEX.
        xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');

        xml2:=put_campo(xml2,'ERRORCOD','30');
        xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);
	
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        if cod_resp1='S' then
                xml2:=put_campo(xml2,'ERRORMSG','');
        end if;
	
	xml2:=put_campo(xml2,'EXTCODERROR',decode(cod_resp1,'HEX')::varchar);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',decode(mensaje_resp1,'HEX')::varchar);

        return xml2;
end;
$$
LANGUAGE plpgsql;
