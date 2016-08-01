/*
   <![CDATA[
<ns1:extCodSeguro>12</ns1:extCodSeguro>
<ns1:extNumOperacion>5894</ns1:extNumOperacion>
<ns1:extRutBeneficiario>0012549775-6</ns1:extRutBeneficiario>
<ns1:extRutPrestador>0088770500-3</ns1:extRutPrestador>
<ns1:extFechaEmision>20140621</ns1:extFechaEmision>
<ns1:extRutEmisor>0088770500-3</ns1:extRutEmisor>
<ns1:extRutCajero>0088770500-3</ns1:extRutCajero>
<ns1:extFolioBono>123456</ns1:extFolioBono>
<ns1:extCodFinanciador>88</ns1:extCodFinanciador>
<ns1:extCodLugar>13202</ns1:extCodLugar>
<ns1:extMtoTot>5000</ns1:extMtoTot>
<ns1:extMtoCopago>500</ns1:extMtoCopago>
<ns1:extMtoBonif>50</ns1:extMtoBonif>
<ns1:extLisPrest>0101855   |00|01|0000015700|0000003140|</ns1:extLisPrest>
    ]]>
*/
CREATE OR REPLACE FUNCTION sp_input_cia_cbvida_cert(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1    alias for $1;
        xml2    varchar;
	input1	varchar;
	respuesta1	varchar;
begin
        xml2:=xml1;

	input1:=decode(get_campo('INPUT',xml2),'hex');

	--Le sacamos los caracteres /012
	input1:=replace(input1,'\012','');
	input1:=replace(input1,'\015','');
	--Log del input
	xml2:=logapp(xml2,'Input.cbvida.Cert='||input1);
	--Le cambio los valores
	input1:=replace(replace(input1,'&lt;','<'),'&gt;','>');

	--Guardo el CODIGO_CIA
	xml2:=put_campo(xml2,'CODIGO_CIA',get_xml('extCodSeguro',input1));
	xml2:=put_campo(xml2,'NUM_OPERACION',get_xml('extNumOperacion',input1));

        --Cambio los caracteres < y >
        --xml2:=put_campo(xml2,'DATA_CIA','<![CDATA['||chr(10)||'<MsgInput>'||get_xml('MsgInput',input1)||'</MsgInput> ]]>');
	
	--Arma nuevamente de forma ordenada el Mensaje (esta cia no lee bien los xml)
        --respuesta1:='<![CDATA['||chr(10)||'<MsgInput>'||chr(10);
        --respuesta1:='<![CDATA['||chr(10)||'<ns1:extCodSeguro>'||get_xml('extCodSeguro',input1)||'</ns1:extCodSeguro>'||chr(10);
        respuesta1:='<ns1:extCodSeguro>'||get_xml('extCodSeguro',input1)||'</ns1:extCodSeguro>'||chr(10);
        respuesta1:=respuesta1||'<ns1:extRutBeneficiario>'||get_xml('extRutBeneficiario',input1)||'</ns1:extRutBeneficiario>'||chr(10);
        respuesta1:=respuesta1||'<ns1:extRutPrestador>'||get_xml('extRutPrestador',input1)||'</ns1:extRutPrestador>'||chr(10);
        respuesta1:=respuesta1||'<ns1:extCodFinanciador>'||get_xml('extCodFinanciador',input1)||'</ns1:extCodFinanciador>'||chr(10);
        respuesta1:=respuesta1||'<ns1:extCodLugar>'||get_xml('extCodLugar',input1)||'</ns1:extCodLugar>'||chr(10);
        respuesta1:=respuesta1||'<ns1:extNumOperacion>'||get_xml('extNumOperacion',input1)||'</ns1:extNumOperacion>'||chr(10);
        respuesta1:=respuesta1||'<ns1:ExtLisPrest1>'||get_xml('extLisPrest1',input1)||'</ns1:ExtLisPrest1>'||chr(10);
        respuesta1:=respuesta1||'<ns1:ExtLisPrest2>'||get_xml('extLisPrest2',input1)||'</ns1:ExtLisPrest2>'||chr(10);
        respuesta1:=respuesta1||'<ns1:ExtLisPrest3>'||get_xml('extLisPrest3',input1)||'</ns1:ExtLisPrest3>'||chr(10);
        respuesta1:=respuesta1||'<ns1:ExtLisPrest4>'||get_xml('extLisPrest4',input1)||'</ns1:ExtLisPrest4>'||chr(10);
        respuesta1:=respuesta1||'<ns1:ExtLisPrest5>'||get_xml('extLisPrest5',input1)||'</ns1:ExtLisPrest5>'||chr(10);
        respuesta1:=respuesta1||'<ns1:ExtLisPrest6>'||get_xml('extLisPrest6',input1)||'</ns1:ExtLisPrest6>';
        --respuesta1:=respuesta1||'<ns1:ExtLisPrest6>'||get_xml('extLisPrest6',input1)||'</ns1:ExtLisPrest6>'||chr(10)||']]>';
        --respuesta1:=respuesta1||'</MsgInput>'||chr(10)||']]>';
        --Cambio los caracteres < y >
        xml2:=put_campo(xml2,'DATA_CIA',respuesta1);

        xml2:=put_campo(xml2,'CIA_SOAPACTION','http://Seguros.CruzBlanca.cl/WsIntegracionLGM/Certificacion'); 
        --xml2:=put_campo(xml2,'CIA_SOAPACTION','http://Seguros.CruzBlanca.cl/WsIntegracionLGM/'); 
	return xml2;
end;
$function$

