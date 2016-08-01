CREATE OR REPLACE FUNCTION traductorWL_in_coptran_fonasa(varchar)
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
	i		integer =0;

	extrae_lista1	varchar;
	prepara_lista1  varchar='';
	lstValores1	varchar;

	cod_homol1      varchar;
        item1           varchar;
        cod_adic1       varchar;
        recargo1        varchar;
        cantidad1       varchar;
BEGIN
        xml2	:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	cod_fin1        :=get_campo('EXTCODFINANCIADOR',xml2);
        num_conv1       :=coalesce(nullif(get_campo('EXTHOMNUMEROCONVENIO',xml2),''),'0');
        lugar_conv1     :=coalesce(nullif(get_campo('EXTHOMLUGARCONVENIO',xml2),''),'0');
        suc_venta1      :=coalesce(nullif(get_campo('EXTSUCVENTA',xml2),''),'0');        	-- char(10)
        rut_conv1       :=get_campo('EXTRUTCONVENIO',xml2);        				-- char(12)
        rut_tratante1   :=get_campo('EXTRUTTRATANTE',xml2);        				-- char(12)
        rut_solicita1   :=get_campo('EXTRUTSOLICITANTE',xml2);        				-- char(12)
        rut_benef1      :=get_campo('EXTRUTBENEFICIARIO',xml2);    				-- char(12)
        tratamiento1    :=coalesce(nullif(get_campo('EXTTRATAMIENTO',xml2),''),'0');      	-- char(40)
        cod_diag1       :=coalesce(nullif(get_campo('EXTCODIGODIAGNOSTICO',xml2),''),'0'); 	-- char(10)
        nivel_conv1     :=coalesce(nullif(get_campo('EXTNIVELCONVENIO',xml2),''),'0');   	-- tinyint
        urgencia1       :=coalesce(nullif(get_campo('EXTURGENCIA',xml2),''),'0');               -- char(1)
	num_presta1   	:=coalesce(nullif(get_campo('EXTNUMPRESTACIONES',xml2),''),'0');    	-- char(10)
        plan1           :=coalesce(nullif(get_campo('EXTPLAN2',xml2),''),'0');            	-- char(15)
	
	-- Abre la lista.
        lista1          :=coalesce(nullif(get_campo('LSTPREST',xml2),''),'0');
	lista1		:=replace(replace(replace(lista1,'\012',''),'\011',''),' ','');

	xml2:=logapp(xml2,'LISTA1_INPUT ='||lista1);

	IF length(lista1) > 0 THEN
		FOR i IN 1..num_presta1::integer LOOP
			extrae_lista1  	:=xml_to_json(lista1,i,'<CopTran_ColInp>','</CopTran_ColInp>');

			cod_homol1      :=get_tag_xml('<extCodigoHomologo>',extrae_lista1);
                	item1           :=get_tag_xml('<extItem>',extrae_lista1);
                	cod_adic1       :=get_tag_xml('<extCodigoAdicional>',extrae_lista1);
                	recargo1        :=get_tag_xml('<extRecargoFueraHora>',extrae_lista1);
                	cantidad1       :=get_tag_xml('<extCantidad>',extrae_lista1);

			prepara_lista1:=prepara_lista1||'{"extCodHomologo":"'||cod_homol1||'","extItem":"'||item1||'","extRecargoHora":"'||recargo1||'","extCantidad":"'||cantidad1||'"},';

			i:=i + 1;
		END LOOP;
	END IF;

	-- Quita la ultima coma.
        prepara_lista1:=substring(prepara_lista1, 1, (length(prepara_lista1) - 1));                   

	-- Entrega lista preparada a variable de salida.
	lstValores1:=prepara_lista1;

	-- Agrega campo LSTPREST a xml2.	
        xml2    	:=put_campo(xml2,'LSTPREST',lstValores1);

	-- Valida formato del RUT.
        rut_conv1       :=motor_formato_rut(rut_conv1);
        rut_tratante1   :=motor_formato_rut(rut_tratante1);
        rut_solicita1   :=motor_formato_rut(rut_solicita1);
        rut_benef1      :=motor_formato_rut(rut_benef1);

        -- Cuando retorno de funcion sea '' retorna error al flujo y no llama a la API del financiador.
        IF (rut_conv1='')       OR (rut_tratante1='')	OR
           (rut_solicita1='')   OR (rut_benef1='')      THEN

                xml2:=put_campo(xml2,'ERROR_RUT','SI');
                
		RETURN xml2;
        END IF;

        -- Envia y almacena lo que viene.
        xml2    :=put_campo(xml2,'RUT_BASE',rut_benef1);
	
	-- Arma el XML Request que va a FONASA.
	rqt_xml1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/"><soapenv:Header/><soapenv:Body><tem:wmImed_SrvCERCopTran><tem:JSON_INPUT>{"extCodFinanciador":"'||cod_fin1||'","extHomNumeroConvenio":"'||num_conv1||'","extHomLugarConvenio":"'||lugar_conv1||'","extSucVenta":"'||suc_venta1||'","extRutConvenio":"'||rut_conv1||'","extRutBeneficiario":"'||rut_benef1||'","extTratamiento":"'||tratamiento1||'","extCodigoDiagnostico":"'||cod_diag1||'","extNivelConvenio":"'||nivel_conv1||'","extPlan2":"'||plan1||'","lista":['||lstValores1||']}</tem:JSON_INPUT></tem:wmImed_SrvCERCopTran></soapenv:Body></soapenv:Envelope>';

        data1:='POST http://10.152.126.17:7001/ebonows/services/wsCERCopTranSoap HTTP/1.1'||chr(10)||
                'Accept-Encoding: gzip,deflate'||chr(10)||
                'Content-Type: text/xml;charset=UTF-8'||chr(10)||
                'SOAPAction: "http://tempuri.org/wmImed_SrvCERCopTran"'||chr(10)||
                'User-Agent: Apache-HttpClient/4.1.1 (java 1.5)'||chr(10)||
                'Host: 10.152.126.17:7001'||chr(10)||
                'Content-Length: '||length(rqt_xml1)||chr(10)||chr(10)||rqt_xml1;	

        -- Envia la data.
        xml2:=put_campo(xml2,'SQLINPUT',data1);

        RETURN xml2;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION traductorWL_out_coptran_fonasa(varchar)
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
	num_prestacion	integer=0;

	wmImed_SrvCERCopTranResult	varchar;
	i				integer=0;

	lstValores1	varchar;
	extrae_lista1	varchar;
	prepara_lista1	varchar='';
	lista_out1	varchar;
BEGIN
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
		xml2:=put_campo(xml2,'SQLOUTPUT',limpia_quot(get_campo('SQLOUTPUT',xml2)));

                -- Parsea la respuesta.
                rsp_xml1:=get_campo('SQLOUTPUT',xml2);

                -- Analiza respuesta de FONASA.
                IF length(rsp_xml1)=0 THEN
                        xml2:=put_campo(xml2,'ESTADO_WS','-1');
                        xml2:=logapp(xml2,'FONASA no responde');

                        RETURN xml2;
                END IF;

		--Extrae todo lo que esta en el tag.
                wmImed_SrvCERCopTranResult:=trim(get_tag_xml('<wmImed_SrvCERCopTranResult>',rsp_xml1));

                xml2:=logapp(xml2,'TAG ='||wmImed_SrvCERCopTranResult);

		cod_resp1       :=encode(replace(json_field(wmImed_SrvCERCopTranResult,'extCodError'),'"','')::bytea,'HEX');
                mensaje_resp1   :=encode(replace(json_field(wmImed_SrvCERCopTranResult,'extMensajeError'),'"','')::bytea,'HEX');		

		plan1       	:=encode(replace(json_field(wmImed_SrvCERCopTranResult,'extPlan'),'"','')::bytea,'HEX');
                lista1   	:=replace(replace(replace(json_field(wmImed_SrvCERCopTranResult,'lista'),'[',''),']',''),' ','');
		lista_out1	:=replace(replace(replace(lista1,'{','['),'}',']'),'"','');

        	xml2:=logapp(xml2,'LISTA1_OUTPUT='||lista1);

		num_prestacion	:=cuenta_palabras(wmImed_SrvCERCopTranResult, 'extValorPrestacion');		

		IF length(lista1) > 0 AND lista1 <> '0' THEN		
                        FOR i IN 1..num_prestacion LOOP
				extrae_lista1:=json_to_xml(lista1,i);
				
				extrae_lista1:=replace(extrae_lista1,'},','}');

				prepara_lista1:=prepara_lista1||'<CopTran_ColOut>
                                                        <extValorPrestacion>'||replace(json_field(extrae_lista1,'extValorPrestacion'),'"','')||'</extValorPrestacion>
                                                        <extAporteFinanciador>'||replace(json_field(extrae_lista1,'extAporteFinanciador'),'"','')||'</extAporteFinanciador>
                                                        <extCopago>'||replace(json_field(extrae_lista1,'extCopago'),'"','')||'</extCopago>
                                                        <extInternoIsa> </extInternoIsa>
                                                </CopTran_ColOut>';

                        END LOOP;
		ELSIF lista1 = '0' THEN
			
			prepara_lista1:='';
		ELSE
			cod_resp1       :='S';           
                	mensaje_resp1   :='FONASA responde error en lista';
                	xml2            :=put_campo(xml2,'API_CODRESPUESTA','2');
                	xml2            :=put_campo(xml2,'API_ERROR','500');
                	xml2            :=put_campo(xml2,'API_DESCRIPCION_ERROR','FONASA responde error en lista');
                	xml2            :=logapp(xml2,'FONASA no responde 200 OK');

			RETURN xml2;
                END IF;
		
		lstValores1:=encode(prepara_lista1::bytea,'HEX');
        ELSE
                cod_resp1	:='S';           
		mensaje_resp1	:=trim(get_tag_xml_hex('faultstring',rsp_xml1));
                xml2		:=put_campo(xml2,'API_CODRESPUESTA','2');
                xml2		:=put_campo(xml2,'API_ERROR','500');
                xml2		:=put_campo(xml2,'API_DESCRIPCION_ERROR','FONASA responde error');
                xml2		:=logapp(xml2,'FONASA no responde 200 OK');
            
		RETURN xml2;
        END IF;
	
	xml2:=logapp(xml2,'FONASA: RSP_COPTRAN -> extCodResp1='||cod_resp1||' -extMensajeResp1='||mensaje_resp1||' -extPlan1='||plan1||' -extLista1='||encode(lista_out1::bytea,'HEX'));

	-- Para que conteste con campos en HEX
        xml2:=put_campo(xml2,'TAG_RESPUESTA_HEX','SI');
        xml2:=put_campo(xml2,'ERRORCOD','30');
        xml2:=put_campo(xml2,'ERRORMSG',mensaje_resp1);
	
	--Si viene "S", no pone mensaje. App Bono3 entiende que es un error
        IF cod_resp1='S' THEN
                xml2:=put_campo(xml2,'ERRORMSG','');
        END IF;

	xml2:=put_campo(xml2,'EXTCODERROR',cod_resp1);
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',mensaje_resp1);
        xml2:=put_campo(xml2,'EXTPLAN',plan1);
        xml2:=put_campo(xml2,'LSTVALORES',lstValores1);
        
        RETURN xml2;
END;
$$
LANGUAGE plpgsql;
