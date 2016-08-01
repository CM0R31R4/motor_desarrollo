/*
   <![CDATA[
<MsgInput>
<extCodSeguro>12</extCodSeguro>
<extNumOperacion>5894</extNumOperacion>
<extRutBeneficiario>0012549775-6</extRutBeneficiario>
<extRutPrestador>0088770500-3</extRutPrestador>
<extFechaEmision>20140621</extFechaEmision>
<extRutEmisor>0088770500-3</extRutEmisor>
<extRutCajero>0088770500-3</extRutCajero>
<extFolioBono>123456</extFolioBono>
<extCodFinanciador>88</extCodFinanciador>
<extCodLugar>13202</extCodLugar>
<extMtoTot>5000</extMtoTot>
<extMtoCopago>500</extMtoCopago>
<extMtoBonif>50</extMtoBonif>
<extLisPrest>0101855   |00|01|0000015700|0000003140|</extLisPrest>
</MsgInput>
    ]]>
*/
CREATE OR REPLACE FUNCTION public.sp_input_cia_chicon_conf(character varying)
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

	--Cambio los &lt por 
        input1:=replace(replace(input1,'&lt;','<'),'&gt;','>');

	--Arma nuevamente de forma ordenada el Mensaje (esta cia no lee bien los xml)
	respuesta1:='<![CDATA['||chr(10)||'<MsgInput>'||chr(10);
	respuesta1:=respuesta1||'<extCodSeguro>'||get_xml('extCodSeguro',input1)||'</extCodSeguro>'||chr(10);
	respuesta1:=respuesta1||'<extNumOperacion>'||get_xml('extNumOperacion',input1)||'</extNumOperacion>'||chr(10);
	respuesta1:=respuesta1||'<extRutBeneficiario>'||get_xml('extRutBeneficiario',input1)||'</extRutBeneficiario>'||chr(10);
	respuesta1:=respuesta1||'<extRutPrestador>'||get_xml('extRutPrestador',input1)||'</extRutPrestador>'||chr(10);
	respuesta1:=respuesta1||'<extFechaEmision>'||get_xml('extFechaEmision',input1)||'</extFechaEmision>'||chr(10);
	respuesta1:=respuesta1||'<extRutEmisor>'||get_xml('extRutEmisor',input1)||'</extRutEmisor>'||chr(10);
	respuesta1:=respuesta1||'<extRutCajero>'||get_xml('extRutCajero',input1)||'</extRutCajero>'||chr(10);
	respuesta1:=respuesta1||'<extFolioBono>'||get_xml('extFolioBono',input1)||'</extFolioBono>'||chr(10);
	respuesta1:=respuesta1||'<extCodFinanciador>'||get_xml('extCodFinanciador',input1)||'</extCodFinanciador>'||chr(10);
	respuesta1:=respuesta1||'<extCodLugar>'||get_xml('extCodLugar',input1)||'</extCodLugar>'||chr(10);
	respuesta1:=respuesta1||'<ExtMtoTot>'||get_xml('ExtMtoTot',input1)||'</ExtMtoTot>'||chr(10);
	respuesta1:=respuesta1||'<ExtMtoCopago>'||get_xml('ExtMtoCopago',input1)||'</ExtMtoCopago>'||chr(10);
	respuesta1:=respuesta1||'<ExtMtoBonif>'||get_xml('ExtMtoBonif',input1)||'</ExtMtoBonif>'||chr(10);
	respuesta1:=respuesta1||'<extLisPrest>'||get_xml('extLisPrest',input1)||'</extLisPrest>'||chr(10);
	respuesta1:=respuesta1||'</MsgInput>'||chr(10)||']]>';
        --Cambio los caracteres < y >
        xml2:=put_campo(xml2,'DATA_CIA',respuesta1);
	return xml2;
end;
$function$

