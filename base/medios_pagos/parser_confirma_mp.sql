drop FUNCTION proc_parser_in_confirma_mp(varchar);
drop FUNCTION proc_parser_out_confirma_mp(varchar);


/*
CREATE OR REPLACE FUNCTION proc_parser_in_confirma_mp(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
	xml_req1	varchar;
	
	tipo_tx1	varchar;
	rut_tit1	varchar;
	pc_key1		varchar;	
	cod_lugar1	varchar;
	isw_cod1	varchar;
	version1	varchar;

begin
        xml2	:=xml1;
	xml2    :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2    :=put_campo(xml2,'CODIGO_RESP','2');
        xml2    :=put_campo(xml2,'FECHA_IN_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	--Parseo datos Input
	tipo_tx1	:=get_campo('TX_API',xml2);
        rut_tit1	:=get_campo('RUT_TITULAR',xml2);
        pc_key1		:=get_campo('PC_KEY',xml2);
        cod_lugar1	:=get_campo('COD_LUGAR',xml2);
        isw_cod1	:=get_campo('CODIGO_TRX',xml2);

	--Valores en duro
        tipo_tx1        :='IMED_CONFIRMACION';
	
        xml_req1:='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imed="http://www.multicaja.cl/imed/">
                <soapenv:Header/>
                <soapenv:Body>
                        <imed:transaction>
                        <item>
                                <name>TIPO_TR</name>
                                <value>'||tipo_tx1||'</value>
                        </item>
                        <item>
                                <name>PC_KEY</name>
                                <value>'||pc_key1||'</value>
                        </item>
                        <item>
                                <name>COD_LUGAR</name>
                                <value>'||cod_lugar1||'</value>
                        </item>
                        <item>
                                <name>CODIGO_ISWITCH</name>
                                <value>'||isw_cod1||'</value>
                        </item>
                        <item>
                                <name>VERSION</name>
                                <value>'||version1||'</value>
                        </item>
                        </imed:transaction>
                </soapenv:Body>
                </soapenv:Envelope>';


	--Variable de Requerimiento.
	xml2:= put_campo(xml2,'RQT_XML',xml_req1);

	return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION proc_parser_out_confirma_mp(varchar)
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
        codigo_isw1     varchar;

begin
        xml2:=xml1;
	xml2  	:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2  	:=put_campo(xml2,'CODIGO_RESP','1');
        --xml2  	:=put_campo(xml2,'MENSAJE_RESP','Trasaccion_OK');
        xml2  	:=put_campo(xml2,'FECHA_OUT_FIN',to_char(clock_timestamp(),'YYYY-MM-DD HH24MISS'));

	-- Respuesta MC en DURO
	xml2 := put_campo(xml2,'RSP_XML','<></>');
	xml2 := put_campo(xml2,'RSP_TIPO_TRX','');
	xml2 := put_campo(xml2,'RSP_CODIGO_RESPUESTA','01');
	xml2 := put_campo(xml2,'RSP_MENSAJE_RESPUESTA','Aprobado');
	xml2 := put_campo(xml2,'RSP_CODIGO_ISWITCH','242342342');
	----------------------------------------------

	--Si no hay respuesta de Multicaja
        if length(get_campo('RSP_XML',xml2))=0 then
                xml2:=put_campo(xml2,'ESTADO_WS','-1');
                xml2:=put_campo(xml2,'RSP_CODIGO_RESPUESTA','2');
                xml2:=put_campo(xml2,'RSP_MENSAJE_RESPUESTA','NO HAY RESPUESTA MULTICAJA');
            
                -- return xml2;
        end if;

	--Buscara este lo que tenga en este tag <item>DATA</item>. Lo inserta el la bolsa
	xml2:=put_tag_xml('item',xml2);

	--Parseo Datos ingresado a la bolsa
	tipo_tx1        :=get_campo('RSP_TIPO_TRX',xml2);
        cod_resp_mc1    :=get_campo('RSP_CODIGO_RESPUESTA',xml2);
        msj_resp_mc1    :=get_campo('RSP_MENSAJE_RESPUESTA',xml2);
        codigo_isw1     :=get_campo('RSP_CODIGO_ISWITCH',xml2);

	--Arma Respuesta para Autentia
	data_resp1:='<?xml version="1.0" encoding="UTF-8" ?><respuesta><TX_API>ISW_CONFIRMA_BONO</TX_API><CODIGO_RESPUESTA>'||cod_resp_mc1||'</CODIGO_RESPUESTA><MENSAJE_RESPUESTA>'||msj_resp_mc1||'</MENSAJE_RESPUESTA><CODIGO_TRX>'||codigo_isw1||'</CODIGO_TRX></respuesta>';

	--Se va a Autentia
	xml2:=put_campo(xml2,'RESPUESTA',data_resp1);
        return xml2;
end;
$$
LANGUAGE plpgsql; */
