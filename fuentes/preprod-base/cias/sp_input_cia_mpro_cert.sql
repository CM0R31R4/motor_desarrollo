/*
&lt;MsgInput&gt;
&lt;extCodSeguro&gt;41&lt;/extCodSeguro&gt;
&lt;extNumOperacion&gt;5894&lt;/extNumOperacion&gt;
&lt;extRutBeneficiario&gt;0012549775&lt;/extRutBeneficiario&gt;
&lt;extRutPrestador&gt;0088770500&lt;/extRutPrestador&gt;
&lt;extFechaEmision&gt;20140621&lt;/extFechaEmision&gt;
&lt;extRutEmisor&gt;0088770500&lt;/extRutEmisor&gt;
&lt;extRutCajero&gt;0088770500&lt;/extRutCajero&gt;
&lt;extFolioBono&gt;123456&lt;/extFolioBono&gt;
&lt;extCodFinanciador&gt;88&lt;/extCodFinanciador&gt;
&lt;extCodLugar&gt;13202&lt;/extCodLugar&gt;
&lt;extMtoTot&gt;5000&lt;/extMtoTot&gt;
&lt;extMtoCopago&gt;500&lt;/extMtoCopago&gt;
&lt;extMtoBonif&gt;50&lt;/extMtoBonif&gt;
&lt;extLisPrest&gt;0101855|00|01|0000015700|0000003140|1&lt;/extLisPrest&gt;
&lt;/MsgInput&gt;
        
*/
CREATE OR REPLACE FUNCTION public.sp_input_cia_mpro_cert(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1    alias for $1;
        xml2    varchar;
	input1	varchar;
	fecha1	varchar;
begin
        xml2:=xml1;

	input1:=decode(get_campo('INPUT',xml2),'hex');

	input1:=replace(replace(input1,'&lt;','<'),'&gt;','>');

	xml2:=put_campo(xml2,'CODIGO_CIA',get_xml('extCodSeguro',input1));
	xml2:=put_campo(xml2,'NUM_OPERACION',get_xml('extNumOperacion',input1));

	--Cambio los \012
	input1:=replace(input1,'\012',chr(10));

        --Cambio los caracteres < y >
        xml2:=put_campo(xml2,'DATA_CIA',replace(replace('<MsgInput>'||get_xml('MsgInput',input1)||'</MsgInput>','>','&gt;'),'<','&lt;'));
	--xml2:=logapp(xml2,'data_cia='||get_campo('DATA_CIA',xml2));
	--xml2:=put_campo(xml2,'DATA_CIA','');
	return xml2;
end;
$function$

