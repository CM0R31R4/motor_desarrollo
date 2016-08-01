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
CREATE OR REPLACE FUNCTION public.sp_input_cia_generica_cert(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1    alias for $1;
        xml2    varchar;
	input1	varchar;
begin
        xml2:=xml1;

	input1:=decode(get_campo('INPUT',xml2),'hex');

	--Le sacamos los caracteres /012
	input1:=replace(input1,'\012','');
	input1:=replace(input1,'\015','');
	--Log del input
	xml2:=logapp(xml2,'Input='||input1);
	--Le cambio los valores
	input1:=replace(replace(input1,'&lt;','<'),'&gt;','>');

	--Guardo el CODIGO_CIA
	xml2:=put_campo(xml2,'CODIGO_CIA',get_xml('extCodSeguro',input1));
	xml2:=put_campo(xml2,'NUM_OPERACION',get_xml('extNumOperacion',input1));

        --Cambio los caracteres < y >
        xml2:=put_campo(xml2,'DATA_CIA','<![CDATA['||chr(10)||'<MsgInput>'||get_xml('MsgInput',input1)||'</MsgInput> ]]>');
	return xml2;
end;
$function$

