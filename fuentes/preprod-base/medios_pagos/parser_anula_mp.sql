--
-- PostgreSQL database dump
--

/*SET statement_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: proc_parser_in_anula_mp(character varying); Type: FUNCTION; Schema: public; Owner: isys
--*/

CREATE OR REPLACE FUNCTION proc_parser_in_anula_mp(character varying) 
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	xml_req1	varchar;
	
	tipo_tx1	varchar;
	num_solic1	varchar;
	isw_orig1	varchar;
	pc_key1		varchar;
	cod_lugar1	varchar;
	rut_prest1	varchar;
	tipo_vta1	varchar;
	mto_orig1	varchar;
	mto_anula1	varchar;
	fec_anula1	varchar;
	rut_cajero1	varchar;

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
        isw_orig1	:=get_campo('CODAUT_TRX_ANULAR',xml2);
        pc_key1		:=get_campo('PC_KEY',xml2);
        cod_lugar1	:=get_campo('COD_LUGAR',xml2);
        rut_prest1	:=get_campo('RUT_PRESTADOR',xml2);
        tipo_vta1	:=get_campo('TIPO_VENTA_IN',xml2);
        mto_orig1	:=get_campo('MONTO_ORIGINAL',xml2);
        mto_anula1	:=get_campo('MONTO_ANULAR',xml2);
        fec_anula1	:=get_campo('FECHA_ANULACION',xml2);
        rut_cajero1	:=get_campo('RUT_CAJERO',xml2);

	--Valores en duro
        tipo_tx1        :='IMED_ANULA';
        num_solic1      :='199030352';
        isw_orig1       :='5767781';
        pc_key1         :='PC-KEY';
        cod_lugar1      :='13001';
        rut_prest1      :='';
        tipo_vta1       :='2';
        mto_orig1       :='3000';
        mto_anula1      :='3000';
        fec_anula1      :='20140318';
        rut_cajero1     :='0011848707-9';
	
	--Arma el Xml Request que va a MC
	xml_req1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:iswitch_ws"><soapenv:Header/><soapenv:Body><urn:webservice><entrada><tipo-tx>IMED_ANULA</tipo-tx><item><nombrecampo>TIPO_TRX</nombrecampo><valorcampo>'||tipo_tx1||'</valorcampo></item><item><nombrecampo>NUM_SOLICITUD</nombrecampo><valorcampo>'||num_solic1||'</valorcampo></item><item><nombrecampo>CODAUT_ISW_ANULAR</nombrecampo><valorcampo>'||isw_orig1||'</valorcampo></item><item><nombrecampo>PC_KEY</nombrecampo><valorcampo>'||pc_key1||'</valorcampo></item><item><nombrecampo>COD_LUGAR</nombrecampo><valorcampo>'||cod_lugar1||'</valorcampo></item><item><nombrecampo>TIPO_VENTA_IN</nombrecampo><valorcampo>'||tipo_vta1||'</valorcampo></item><item><nombrecampo>MONTO_ORIGINAL</nombrecampo><valorcampo>'||mto_orig1||'</valorcampo></item><item><nombrecampo>MONTO_ANULAR</nombrecampo><valorcampo>'||mto_anula1||'</valorcampo></item><item><nombrecampo>FECHA_ANULACION</nombrecampo><valorcampo>'||fec_anula1||'</valorcampo></item><item><nombrecampo>RUT_CAJERO</nombrecampo><valorcampo>'||rut_cajero1||'</valorcampo></item></entrada></urn:webservice></soapenv:Body></soapenv:Envelope>';
	
	--Variable de Requerimiento.
	xml2:= put_campo(xml2,'RQT_XML',xml_req1);
	--xml2	:=put_campo(xml2,'__SECUENCIAOK__','100');

	return xml2;
end;
$$
LANGUAGE plpgsql;

--ALTER FUNCTION public.proc_parser_in_anula_mp(character varying) OWNER TO isys;

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

/*SET statement_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: proc_parser_out_anula_mp(character varying); Type: FUNCTION; Schema: public; Owner: isys
--*/

CREATE OR REPLACE FUNCTION proc_parser_out_anula_mp(character varying) 
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
        cod_resp_mc1    varchar;
        msj_resp_mc1    varchar;
        emisor1         varchar;
        codigo_isw1     varchar;
        vou_vert1       varchar;
        vou_horiz1      varchar;

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
	tipo_tx1        :=get_campo('RSP_TIPO_TRX',xml2);
        cod_resp_mc1    :=get_campo('RSP_CODIGO_RESPUESTA',xml2);
        msj_resp_mc1    :=get_campo('RSP_MENSAJE_RESPUESTA',xml2);
        emisor1         :=get_campo('RSP_EMISOR',xml2);
        codigo_isw1     :=get_campo('RSP_CODIGO_ISWITCH',xml2);
        vou_vert1       :=get_campo('RSP_VOUCHER_VERTICAL',xml2);
        vou_horiz1      :=get_campo('RSP_VOUCHER_HORIZONTAL',xml2);
	

	--Arma Respuesta para Autentia
	data_resp1:='<?xml version="1.0" encoding="UTF-8" ?><respuesta><TX_API>ISW_VENTA</TX_API><CODIGO_RESPUESTA>'||cod_resp_mc1||'</CODIGO_RESPUESTA><MENSAJE_RESPUESTA>'||msj_resp_mc1||'</MENSAJE_RESPUESTA><EMISOR>'||emisor1||'</EMISOR><CODIGO_TRX>'||codigo_isw1||'</CODIGO_TRX><VOUCHER_VERTICAL>'||vou_vert1||'</VOUCHER_VERTICAL><VOUCHER_HORIZONTAL>'||vou_horiz1||'</VOUCHER_HORIZONTAL></respuesta>';

	--Se va a Autentia
	xml2:=put_campo(xml2,'RESPUESTA',resp_xml1);
        return xml2;
end;
$$
LANGUAGE plpgsql;

--ALTER FUNCTION public.proc_parser_out_anula_mp(character varying) OWNER TO isys;

--
-- PostgreSQL database dump complete
--

