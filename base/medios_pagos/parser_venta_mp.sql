CREATE OR REPLACE FUNCTION proc_parser_in_venta_mp(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	xml_req1	varchar;
	
	tipo_tx1	varchar;
        num_solic1      varchar;
        pc_key1         varchar;
        cod_lugar1      varchar;
        rut_prest1      varchar;
        rut_benef1      varchar;
        rut_tit1        varchar;
        cod_aud1	varchar;
	huella1         varchar;
        tipo_vta1       varchar;
        fec_oper11      varchar;
        tipo_produc1    varchar;
        monto1          varchar;
        cuotas1         varchar;
        fec_pc1         varchar;
        rut_cajero1     varchar;
        track21         varchar;
        track11         varchar;
        emisor1         varchar;
        pin1            varchar;
	tpo_voucher1	varchar;

BEGIN
        xml2	:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));

	-- Parsea datos INPUT.
	tipo_tx1	:=get_campo('TX_API',xml2);		-- Cliente
	--num_solic1    	:=get_campo('CODIGO_CLIENTE',xml2);	-- Cliente
	num_solic1      :=get_campo('NUM_SOLICITUD',xml2);     	-- Cliente
	pc_key1		:=get_campo('PC_KEY',xml2);		-- Autentia
	cod_lugar1	:=get_campo('COD_LUGAR',xml2);		-- Autentia
	rut_prest1	:=get_campo('RUT_PRESTADOR',xml2);	-- Cliente
	rut_benef1	:=get_campo('RUT_BENEFICIARIO',xml2);	-- Cliente
	rut_tit1	:=get_campo('RUT_TITULAR',xml2);	
	cod_aud1	:=get_campo('CODIGO_AUDITORIA',xml2);	
	tipo_vta1	:=get_campo('TIPO_VENTA_IN',xml2);	-- Cliente
	fec_oper11	:=get_campo('FECHA_OPERACION',xml2);	-- Cliente
	monto1		:=get_campo('MONTO',xml2);		-- Cliente
	cuotas1		:=get_campo('CUOTAS',xml2);		-- Cliente
	fec_pc1		:=get_campo('FECHA_PC',xml2);		-- Cliente 
	rut_cajero1	:=get_campo('RUT_CAJERO',xml2);		
	track21		:=get_campo('TRACK2',xml2);		-- Cliente
	track11		:=get_campo('TRACK1',xml2);		-- Cliente
	emisor1		:=get_campo('EMISOR',xml2);		-- Cliente
	pin1		:=get_campo('PIN',xml2);		-- Cliente
	tpo_voucher1	:=get_campo('TPO_VOUCHER',xml2);        

	--Valores en duro
	tipo_tx1        :='IMED_VENTA';
	huella1		:='1';
	tipo_produc1	:='1';

	
	--Arma el XML request que va a MC.
	 xml_req1	:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imed="http://www.multicaja.cl/imed/">'||
                 		'<soapenv:Header/><soapenv:Body>'||
                			'<imed:transaction>'||
                				'<item><name>TIPO_TX</name><value>'||tipo_tx1||'</value></item>'||
                				'<item><name>PC_KEY</name><value>'||pc_key1||'</value></item>'||
                				'<item><name>COD_LUGAR</name><value>'||cod_lugar1||'</value></item>'||
                				'<item><name>NUM_SOLICITUD</name><value>'||num_solic1||'</value></item>'||
                				'<item><name>RUT_PRESTADOR</name><value>'||rut_prest1||'</value></item>'||
                				'<item><name>RUT_BENEFICIARIO</name><value>'||rut_benef1||'</value></item>'||
                				'<item><name>HUELLA</name><value>'||huella1||'</value></item>'||
                				'<item><name>TIPO_VENTA_IN</name><value>'||tipo_vta1||'</value></item>'||
                				'<item><name>FECHA_OPERACION</name><value>'||fec_oper11||'</value></item>'||
                				'<item><name>TIPO_PRODUCTO</name><value>'||tipo_produc1||'</value></item>'||
                				'<item><name>RUT_TITULAR</name><value>'||rut_tit1||'</value></item>'||
                				'<item><name>MONTO</name><value>'||monto1||'</value></item>'||
						'<item><name>CUOTAS</name><value>'||cuotas1||'</value></item>'||
						'<item><name>FECHA_PC</name><value>'||fec_pc1||'</value></item>'||
						'<item><name>RUT_CAJERO</name><value>'||rut_cajero1||'</value></item>'||
						'<item><name>TRACK2</name><value>'||track21||'</value></item>'||
						'<item><name>TRACK1</name><value>'||track11||'</value></item>'||
						'<item><name>EMISOR</name><value>'||emisor1||'</value></item>'||
						'<item><name>PIN</name><value>'||pin1||'</value></item>'||
                			'</imed:transaction>'||
                		'</soapenv:Body>'||
                	'</soapenv:Envelope>';

	
	-- Variable de requerimiento.
	xml2:= put_campo(xml2,'RQT_XML',xml_req1);

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION proc_parser_out_venta_mp(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;

	tipo_tx1        varchar;
	cod_resp_mc1	varchar;
        msj_resp_mc1	varchar;
        emisor1		varchar;
        codigo_isw1	varchar;
        vou_vert1	varchar;
        vou_horiz1	varchar;
	codigo_tx1	varchar;
	voucher         varchar;
	voucher_tag     varchar;

BEGIN
        xml2	:=xml1;
	xml2  	:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2  	:=put_campo(xml2,'CODIGO_RESP','1');
        xml2  	:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));
	voucher :=get_campo('TPO_VOUCHER',xml2);  -- Cliente

	-- Si no hay respuesta de MultiCaja.
        IF length(get_campo('RSP_XML',xml2))=0 THEN
                xml2:=put_campo(xml2,'ESTADO_WS','-1');
                xml2:=put_campo(xml2,'RSP_CODIGO_RESPUESTA','2');
                xml2:=put_campo(xml2,'RSP_MENSAJE_RESPUESTA','NO HAY RESPUESTA MULTICAJA');
        
		-- Envia respuesta al log.
                xml2:=logapp(xml2,'MULTICAJA: RSP_VENTA -> -extCodigoRespuesta=2 -extMensajeRespuesta=No hay respuesta de MultiCaja');
  
                RETURN xml2;
        END IF;

	-- Busca lo que tenga este tag <item>DATA</item>. Lo inserta el XML2.
	xml2:=put_tag_xml('item',xml2);

	-- Parsea datos ingresados en XML2.
	tipo_tx1	:=get_campo('RSP_TIPO_TX',xml2);
	cod_resp_mc1	:=get_campo('RSP_CODIGO_RESPUESTA',xml2);
        msj_resp_mc1	:=get_campo('RSP_MENSAJE_RESPUESTA',xml2);
        emisor1		:=get_campo('RSP_EMISOR',xml2);
        codigo_isw1	:=get_campo('RSP_CODIGO_ISWITCH',xml2);
        vou_vert1	:=get_campo('RSP_VOUCHER_VERTICAL',xml2);
        vou_horiz1	:=get_campo('RSP_VOUCHER_HORIZONTAL',xml2);
	codigo_tx1      :=get_campo('CODIGO_MOTOR',xml2);

	-- Se comenta porque MC siempre devuelve el campo 'VOUCHER_HORIZONTAL'.
	--IF voucher = 'V' THEN
	--	voucher_tag := vou_vert1;
	--ELSE
		voucher_tag := vou_horiz1;
	--END IF;

	-- Envia respuesta al log.
	xml2:=logapp(xml2,'MULTICAJA: RSP_VENTA -> -extTipoTX='||tipo_tx1||' -extCodigoRespuesta='||cod_resp_mc1||' -extMensajeRespuesta='||msj_resp_mc1||' -extEmisor='||emisor1||' -extCodigoIswith='||codigo_isw1||' -extVoucher='||voucher_tag||' -extCodigoMotor='||codigo_tx1);

	-- Prepara campos que componen la respuesta en XML.
        xml2:=put_campo(xml2,'EXTTIPOTX',tipo_tx1);
        xml2:=put_campo(xml2,'EXTCODIGORESPUESTA',cod_resp_mc1);
        xml2:=put_campo(xml2,'EXTMENSAJERESPUESTA',msj_resp_mc1);
        xml2:=put_campo(xml2,'EXTEMISOR',emisor1);
        xml2:=put_campo(xml2,'EXTCODIGOISWITCH',codigo_isw1);
	xml2:=put_campo(xml2,'EXTVOUCHER',voucher_tag);

        RETURN xml2;
END;
$$
LANGUAGE plpgsql;
