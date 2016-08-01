CREATE OR REPLACE FUNCTION proc_parser_in_cons_convenio_mp(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	xml_req1	varchar;
	
	tipo_tx1	varchar;
	pc_key1		varchar;
	cod_lugar1	varchar;
	rut_tit1	varchar;
	monto1		varchar;
	version1	varchar;
	emisor1		varchar;

begin
        xml2	:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));

	-- Parsea datos INPUT.
	tipo_tx1	:=get_campo('TX_API',xml2);  	-- Cliente
        pc_key1		:=get_campo('PC_KEY',xml2);	-- Autentia
        cod_lugar1	:=get_campo('COD_LUGAR',xml2);  -- Autentia
        rut_tit1	:=get_campo('RUT_TITULAR',xml2);-- Cliente
	monto1		:=get_campo('MONTO',xml2);	-- Cliente
	emisor1		:=get_campo('ID_EMISOR',xml2);  -- Cliente

	-- Valor en duro.
	tipo_tx1	:='IMED_CONSULTA_CONVENIOS';
	
	--Arma el XML request que va a MC.
	xml_req1	:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imed="http://www.multicaja.cl/imed/">'||
				'<soapenv:Header/><soapenv:Body>'||
					'<imed:transaction>'||
						'<item><name>TIPO_TX</name><value>'||tipo_tx1||'</value></item>'||
						'<item><name>RUT_TITULAR</name><value>'||rut_tit1||'</value></item>'||
						'<item><name>MONTO</name><value>'||monto1||'</value></item>'||
						'<item><name>EMISOR</name><value>'||emisor1||'</value></item>'||
						'<item><name>PC_KEY</name><value>'||pc_key1||'</value></item>'||
						'<item><name>COD_LUGAR</name><value>'||cod_lugar1||'</value></item>'||
					'</imed:transaction>'||
				'</soapenv:Body>'||
			'</soapenv:Envelope>';
	
	-- Variable de requerimiento.
	xml2:= put_campo(xml2,'RQT_XML',xml_req1);

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION proc_parser_out_cons_convenio_mp(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;

	tipo_tx1        varchar;
	cod_resp_mc1	varchar;
        msj_resp_mc1	varchar;
	codigo_tx1	varchar;
	cuotamin1	varchar;
	cuotamax1	varchar;
	ind_aut1	varchar;

BEGIN
        xml2	:=xml1;
	xml2  	:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2  	:=put_campo(xml2,'CODIGO_RESP','1');
        xml2  	:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));

	-- Si no hay respuesta de MultiCaja.
        IF length(get_campo('RSP_XML',xml2))=0 THEN
       		xml2:=put_campo(xml2,'ESTADO_WS','-1');
                xml2:=put_campo(xml2,'RSP_CODIGO_RESPUESTA','2');
                xml2:=put_campo(xml2,'RSP_MENSAJE_RESPUESTA','NO HAY RESPUESTA MULTICAJA');

                -- Envia respuesta al log.
                xml2:=logapp(xml2,'MULTICAJA: RSP_CONSULTA_CONVENIO -> -extCodigoRespuesta=2 -extMensajeRespuesta=No hay respuesta de MultiCaja');

                RETURN xml2; 
        END IF;

	-- Busca lo que tenga este tag <item>DATA</item>. Lo inserta el XML2.
	xml2:=put_tag_xml('item',xml2);

	-- Parsea datos ingresados en XML2.
	cod_resp_mc1	:=get_campo('RSP_CODIGO_RESPUESTA',xml2);
        msj_resp_mc1	:=get_campo('RSP_MENSAJE_RESPUESTA',xml2);
	tipo_tx1	:=get_campo('RSP_TIPO_TX',xml2);
	cuotamin1       :=get_campo('RSP_CUOTA_MINIMA',xml2);
	cuotamax1	:=get_campo('RSP_CUOTA_MAXIMA',xml2);
	ind_aut1	:=get_campo('RSP_INDICADOR_AUTORIZACION',xml2);
	codigo_tx1	:=get_campo('CODIGO_MOTOR',xml2);

	-- Envia respuesta al log.
        xml2:=logapp(xml2,'MULTICAJA: RSP_CONSULTA_CONVENIO -> -extTipoTX='||tipo_tx1||' -extCodigoRespuesta='||cod_resp_mc1||' -extMensajeRespuesta='||msj_resp_mc1||' -extCuotaMinima='||cuotamin1||' -extCuotaMaxima='||cuotamax1||' -extIndAutorizacion='||ind_aut1||' -extCodigoMotor='||codigo_tx1);
   
	-- Prepara campos que componen la respuesta en XML.
        xml2:=put_campo(xml2,'EXTTIPOTX',tipo_tx1);
        xml2:=put_campo(xml2,'EXTCODIGORESPUESTA',cod_resp_mc1);
        xml2:=put_campo(xml2,'EXTMENSAJERESPUESTA',msj_resp_mc1);
        xml2:=put_campo(xml2,'EXTCUOTAMINIMA',cuotamin1);
        xml2:=put_campo(xml2,'EXTCUOTAMAXIMA',cuotamax1);
        xml2:=put_campo(xml2,'EXTINDAUTORIZACION',ind_aut1);
     
	RETURN xml2;
END;
$$
LANGUAGE plpgsql;
