--DROP FUNCTION proc_parser_in_verder(varchar);
CREATE OR REPLACE FUNCTION proc_parser_in_verder_mp(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	xml_req1	varchar;
	
	tipo_tx1	varchar;
	pc_key1		varchar;
	cod_lugar1	varchar;
	rut_tit1	varchar;
	monto1		varchar;
	version1	varchar;

begin
        xml2:=xml1;
	--xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        --xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Parseo datos Input
	tipo_tx1	:=get_campo('TX_API',xml2);
        pc_key1		:=get_campo('PC_KEY',xml2);
        cod_lugar1	:=get_campo('COD_LUGAR',xml2);
        rut_tit1	:=get_campo('RUT_TITULAR',xml2);
        monto1		:=get_campo('MONTO',xml2);
        version1	:=get_campo('VERSION',xml2);

	--Valores en duro
	tipo_tx1	:='IMED_VERDER';
	pc_key1		:='PC-KEY';
	cod_lugar1	:='13001';
	rut_tit1	:='7982287-6';
	monto1		:='1000';
	version1	:='2.0';
	
	--Arma el Xml Request que va a MC
	xml_req1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:iswitch_ws">
		<soapenv:Header/><soapenv:Body>
		<urn:webservice>
			<entrada>
			<tipo-tx>IMED_VERDER</tipo-tx>
			<item>
				<nombrecampo>TIPO_TRX</nombrecampo>
				<valorcampo>'||tipo_tx1||'</valorcampo>
			</item>
			<item>
				<nombrecampo>PC_KEY</nombrecampo>
				<valorcampo>'||pc_key1||'</valorcampo>
			</item>
			<item>
				<nombrecampo>COD_LUGAR</nombrecampo>
				<valorcampo>'||cod_lugar1||'</valorcampo>
			</item>
			<item>
				<nombrecampo>RUT_TITULAR</nombrecampo>
				<valorcampo>'||rut_tit1||'</valorcampo>
			</item>
			<item>
				<nombrecampo>MONTO</nombrecampo>
				<valorcampo>'||monto1||'</valorcampo>
			</item>
			<item>
				<nombrecampo>VERSION</nombrecampo>
				<valorcampo>'||version1||'</valorcampo>
			</item>
			</entrada>
		</urn:webservice></soapenv:Body></soapenv:Envelope>';
	
	--Variable de Requerimiento.
	xml2:= put_campo(xml2,'RQT_XML',xml_req1);
	--xml2	:=put_campo(xml2,'__SECUENCIAOK__','100');

	return xml2;
end;
$$
LANGUAGE plpgsql;

--DROP FUNCTION proc_parser_out_verder(varchar);
CREATE OR REPLACE FUNCTION proc_parser_out_verder_mp(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	xml_rsp1	varchar;
	data_resp_xml1	varchar;
	data1	varchar;
	campo1	varchar;
	valor1	varchar;
	cuenta1	integer;
	i	integer=1;

	tipo_tx1        varchar;
	cod_resp_mc1	varchar;
        msj_resp_mc1	varchar;
        lista_emisor1	varchar;
        total_emisor1	varchar;

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
	cod_resp_mc1	:=get_campo('RSP_CODIGO_RESPUESTA',xml2);
        msj_resp_mc1	:=get_campo('RSP_MENSAJE_RESPUESTA',xml2);
        lista_emisor1	:=get_campo('RSP_LISTA_EMISORES',xml2);
        total_emisor1	:=get_campo('RSP_TOTAL_EMISORES',xml2);
	tipo_tx1	:=get_campo('RSP_TIPO_TRX',xml2);

	--Arma Respuesta para Autentia
	data_resp_xml1:='<?xml version="1.0" encoding="UTF-8" ?><respuesta><TX_API>ISW_VERIDERECHO</TX_API><TOTAL_EMISORES>'||total_emisor1||'</TOTAL_EMISORES><LISTA_EMISORES>'||lista_emisor1||'</LISTA_EMISORES><CODIGO_RESPUESTA>'||cod_resp_mc1||'</CODIGO_RESPUESTA></respuesta>';
	--<MENSAJE_RESPUESTA>'||msj_resp_mc1||'</MENSAJE_RESPUESTA>

	--Se va a Autentia
	xml2:=put_campo(xml2,'RESPUESTA',data_resp_xml1);
        return xml2;
end;
$$
LANGUAGE plpgsql;
