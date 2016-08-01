CREATE OR REPLACE FUNCTION proc_parser_in_venta_mp(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	xml_req1	varchar;
	
	tipo_tx1	varchar;
        num_solic1      varchar;
        pc_key1         varchar;
        cod_lugar1      varchar;
        rut_prest1      varchar;
        rut_benef1      varchar;
        rut_tit1        varchar;
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

begin
        xml2:=xml1;
	--xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        --xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Parseo datos Input
	tipo_tx1	:=get_campo('TX_API',xml2);
        num_solic1	:=get_campo('NUM_SOLICITUD',xml2);
	pc_key1		:=get_campo('PC_KEY',xml2);
	cod_lugar1	:=get_campo('COD_LUGAR',xml2);
	rut_prest1	:=get_campo('RUT_PRESTADOR',xml2);
	rut_benef1	:=get_campo('RUT_BENEFICIARIO',xml2);
	rut_tit1	:=get_campo('RUT_TITULAR',xml2);
	huella1		:=get_campo('HUELLA',xml2);
	tipo_vta1	:=get_campo('TIPO_VENTA_IN',xml2);
	fec_oper11	:=get_campo('FECHA_OPERACION',xml2);
	tipo_produc1	:=get_campo('TIPO_PRODUCTO',xml2);
	monto1		:=get_campo('MONTO',xml2);
	cuotas1		:=get_campo('CUOTAS',xml2);
	fec_pc1		:=get_campo('FECHA_PC',xml2);
	rut_cajero1	:=get_campo('RUT_CAJERO',xml2);
	track21		:=get_campo('TRACK2',xml2);
	track11		:=get_campo('TRACK1',xml2);
	emisor1		:=get_campo('EMISOR',xml2);
	pin1		:=get_campo('PIN',xml2);
        
	--Valores en duro
	tipo_tx1        :='IMED_VENTA';
	num_solic1      :='199030351';
	pc_key1         :='PC_KEY';
	cod_lugar1      :='13001';
	rut_prest1      :='11111111-1';
	rut_benef1      :='7982287-6';
	rut_tit1        :='7982287-6';
	huella1         :='1';
	tipo_vta1     	:='2';
	fec_oper11      :='20140317';
	tipo_produc1    :='0';
	monto1          :='3000';
	cuotas1         :='3';
	fec_pc1         :='20140317';
	rut_cajero1     :='0011848707-9';
	track21         :='';
	track11         :='';
	emisor1         :='028';
	pin1            :='1234';
	
	--Arma el Xml Request que va a MC
	xml_req1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:iswitch_ws"><soapenv:Header/><soapenv:Body><urn:webservice><entrada><tipo-tx>IMED_VENTA</tipo-tx><item><nombrecampo>TIPO_TRX</nombrecampo><valorcampo>'||tipo_tx1||'</valorcampo></item><item><nombrecampo>NUM_SOLICITUD</nombrecampo><valorcampo>'||num_solic1||'</valorcampo></item><item><nombrecampo>PC_KEY</nombrecampo><valorcampo>'||pc_key1||'</valorcampo></item><item><nombrecampo>COD_LUGAR</nombrecampo><valorcampo>'||cod_lugar1||'</valorcampo></item><item><nombrecampo>RUT_PRESTADOR</nombrecampo><valorcampo>'||rut_prest1||'</valorcampo></item><item><nombrecampo>RUT_BENEFICIARIO</nombrecampo><valorcampo>'||rut_benef1||'</valorcampo></item><item><nombrecampo>RUT_TITULAR</nombrecampo><valorcampo>'||rut_tit1||'</valorcampo></item><item><nombrecampo>HUELLA</nombrecampo><valorcampo>'||huella1||'</valorcampo></item><item><nombrecampo>TIPO_VENTA_IN</nombrecampo><valorcampo>'||tipo_vta1||'</valorcampo></item><item><nombrecampo>FECHA_OPERACION</nombrecampo><valorcampo>'||fec_oper11||'</valorcampo></item><item><nombrecampo>TIPO_PRODUCTO</nombrecampo><valorcampo>'||tipo_produc1||'</valorcampo></item><item><nombrecampo>MONTO</nombrecampo><valorcampo>'||monto1||'</valorcampo></item><item><nombrecampo>CUOTAS</nombrecampo><valorcampo>'||cuotas1||'</valorcampo></item><item><nombrecampo>FECHA_PC</nombrecampo><valorcampo>'||fec_pc1||'</valorcampo></item><item><nombrecampo>RUT_CAJERO</nombrecampo><valorcampo>'||rut_cajero1||'</valorcampo></item><item><nombrecampo>TRACK2</nombrecampo><valorcampo>'||track21||'</valorcampo></item><item><nombrecampo>TRACK1</nombrecampo><valorcampo>'||track11||'</valorcampo></item><item><nombrecampo>EMISOR</nombrecampo><valorcampo>'||emisor1||'</valorcampo></item><item><nombrecampo>PIN</nombrecampo><valorcampo>'||pin1||'</valorcampo></item></entrada></urn:webservice></soapenv:Body></soapenv:Envelope>';
	
	--Variable de Requerimiento.
	xml2:= put_campo(xml2,'RQT_XML',xml_req1);
	--xml2	:=put_campo(xml2,'__SECUENCIAOK__','100');

	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION proc_parser_out_venta_mp(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	xml_rsp1	varchar;
	data_resp1	varchar;
	data1		varchar;
	campo1		varchar;
	valor1		varchar;
	cuenta1		integer;
	i		integer=1;

	tipo_tx1        varchar;
	cod_resp_mc1	varchar;
        msj_resp_mc1	varchar;
        emisor1		varchar;
        codigo_isw1	varchar;
        vou_vert1	varchar;
        vou_horiz1	varchar;

begin
        xml2:=xml1;
	xml2  	:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2  	:=put_campo(xml2,'CODIGO_RESP','1');
        --xml2  	:=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2  	:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Si no hay respuesta de Multicaja
        if length(get_campo('RSP_XML',xml2))=0 then
                xml2:=put_campo(xml2,'ESTADO_WS','-1');
                return xml2;
        end if;

	--Buscara este lo que tenga en este tag <item>DATA</item>. Lo inserta el la bolsa
	xml2:=put_tag_xml('item',xml2);

	--Parseo Datos ingresado a la bolsa
	tipo_tx1	:=get_campo('RSP_TIPO_TRX',xml2);
	cod_resp_mc1	:=get_campo('RSP_CODIGO_RESPUESTA',xml2);
        msj_resp_mc1	:=get_campo('RSP_MENSAJE_RESPUESTA',xml2);
        emisor1		:=get_campo('RSP_EMISOR',xml2);
        codigo_isw1	:=get_campo('RSP_CODIGO_ISWITCH',xml2);
        vou_vert1	:=get_campo('RSP_VOUCHER_VERTICAL',xml2);
        vou_horiz1	:=get_campo('RSP_VOUCHER_HORIZONTAL',xml2);

	--Arma Respuesta para Autentia
	data_resp1:='<?xml version="1.0" encoding="UTF-8" ?><respuesta><TX_API>ISW_VENTA</TX_API><CODIGO_RESPUESTA>'||cod_resp_mc1||'</CODIGO_RESPUESTA><MENSAJE_RESPUESTA>'||msj_resp_mc1||'</MENSAJE_RESPUESTA><EMISOR>'||emisor1||'</EMISOR><CODIGO_TRX>'||codigo_isw1||'</CODIGO_TRX><VOUCHER_VERTICAL>'||vou_vert1||'</VOUCHER_VERTICAL><VOUCHER_HORIZONTAL>'||vou_horiz1||'</VOUCHER_HORIZONTAL></respuesta>';

	--Se va a Autentia
	xml2:=put_campo(xml2,'RESPUESTA',data_resp1);
        return xml2;
end;
$$
LANGUAGE plpgsql;
