CREATE OR REPLACE FUNCTION public.sp_input_cia_chicon_concilia(character varying)
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

	--Codigo de Cia
        xml2:=put_campo(xml2,'CODIGO_CIA',get_xml('extCodSeguro',input1));
	xml2:=put_campo(xml2,'FOLIO_AUTO',get_xml('extFolioAuto',input1));

	--Arma nuevamente de forma ordenada el Mensaje (esta cia no lee bien los xml)
	respuesta1:='<extCodSeguro>'||get_xml('extCodSeguro',input1)||'</extCodSeguro>'||chr(10);
        respuesta1:=respuesta1||'<extFolioAuto>'||get_xml('extFolioAuto',input1)||'</extFolioAuto>';
	
        --Cambio los caracteres < y >
        xml2:=put_campo(xml2,'DATA_CIA',respuesta1);
	return xml2;
end;
$function$

