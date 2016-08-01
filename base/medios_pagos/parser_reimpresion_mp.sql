CREATE OR REPLACE FUNCTION proc_parser_in_reimpresion_mp(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	xml_req1	varchar;
	
	tipo_tx1	varchar;
	pc_key1		varchar;	
	cod_lugar1	varchar;
	isw_cod1	varchar;
	version1	varchar;

begin
        xml2	:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));

	-- Parsea datos INPUT.
	tipo_tx1	:=get_campo('TX_API',xml2);
        pc_key1		:=get_campo('PC_KEY',xml2);
        cod_lugar1	:=get_campo('COD_LUGAR',xml2);
        isw_cod1	:=get_campo('CODIGO_ISW_REIMPRESION',xml2);

        -- Valor en duro.
        tipo_tx1        :='IMED_REIMPRESION';

        -- Arma el XML Request que va a MC.
        xml_req1	:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imed="http://www.multicaja.cl/imed/">'||
                		'<soapenv:Header/><soapenv:Body>'||
                			'<imed:transaction>'||
                				'<item><name>TIPO_TX</name><value>'||tipo_tx1||'</value></item>'||
                				'<item><name>PC_KEY_REIMPRESION</name><value>'||pc_key1||'</value></item>'||
                				'<item><name>COD_LUGAR_REIMPRESION</name><value>'||cod_lugar1||'</value></item>'||
                				'<item><name>CODIGO_ISW_REIMPRESION</name><value>'||isw_cod1||'</value></item>'||
                			'</imed:transaction>'||
                		'</soapenv:Body>'||
                	'</soapenv:Envelope>';

	-- Variable de requerimiento.
	xml2:= put_campo(xml2,'RQT_XML',xml_req1);

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION proc_parser_out_reimpresion_mp(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;

        tipo_tx1        varchar;
        cod_resp_mc1    varchar;
        msj_resp_mc1    varchar;
        emisor1         varchar;
        codigo_isw1     varchar;
        --vou_vert1       varchar;
        --vou_horiz1      varchar;
	codigo_tx1      varchar;
	
BEGIN
        xml2	:=xml1;
	xml2  	:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2  	:=put_campo(xml2,'CODIGO_RESP','1');
        xml2  	:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));

	--Si no hay respuesta de MultiCaja.
        if length(get_campo('RSP_XML',xml2))=0 then
                xml2:=put_campo(xml2,'ESTADO_WS','-1');
                xml2:=put_campo(xml2,'RSP_CODIGO_RESPUESTA','2');
                xml2:=put_campo(xml2,'RSP_MENSAJE_RESPUESTA','NO HAY RESPUESTA MULTICAJA');

                -- Envia respuesta al log.
                xml2:=logapp(xml2,'MULTICAJA: RSP_REIMPRESION -> -extCodigoRespuesta=2 -extMensajeRespuesta=No hay respuesta de MultiCaja');

                RETURN xml2;
        End if;

	-- Busca lo que tenga este tag <item>DATA</item>. Lo inserta en XML2.
	xml2:=put_tag_xml('item',xml2);

	-- Parsea datos ingresados en XML2.
        tipo_tx1        :=get_campo('RSP_TIPO_TRX',xml2);
        cod_resp_mc1    :=get_campo('RSP_CODIGO_RESPUESTA',xml2);
        msj_resp_mc1    :=get_campo('RSP_MENSAJE_RESPUESTA',xml2);
        emisor1         :=get_campo('RSP_EMISOR',xml2);
        codigo_isw1     :=get_campo('RSP_CODIGO_ISWITCH',xml2);
        --vou_vert1       :=get_campo('RSP_VOUCHER_VERTICAL',xml2);
        --vou_horiz1      :=get_campo('RSP_VOUCHER_HORIZONTAL',xml2);
	codigo_tx1      :=get_campo('CODIGO_MOTOR',xml2);

	-- Envia respuesta al log.
        xml2:=logapp(xml2,'MULTICAJA: RSP_REIMPRESION -> -extCodigoRespuesta='||cod_resp_mc1||' -extMensajeRespuesta='||msj_resp_mc1||' -extTipoTX='||tipo_tx1||' -extEmisor='||emisor1||' -extCodigoIswitch='||codigo_isw1||' -extCodigoMotor='||codigo_tx1);

	-- Prepara campos que componen la respuesta en XML.
        xml2:=put_campo(xml2,'EXTCODIGORESPUESTA',cod_resp_mc1);
        xml2:=put_campo(xml2,'EXTMENSAJERESPUESTA',msj_resp_mc1);
        xml2:=put_campo(xml2,'EXTTIPOTX',tipo_tx1);
        xml2:=put_campo(xml2,'EXTEMISOR',emisor1);
        xml2:=put_campo(xml2,'EXTCODIGOISWITCH',codigo_isw1);

        RETURN xml2;
END;
$$
LANGUAGE plpgsql;
