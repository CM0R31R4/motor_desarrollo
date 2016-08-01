/*
   <![CDATA[
<MsgInput>
extCodSeguro
extCodFinanciador
extFolioBono
extRutBeneficiario
extFolAutSeguro
extCodZonalPag
extRutConvenio
extNomConvenio
extFecCobro
</MsgInput>
    ]]>
*/
--drop function sp_input_cia_bonopago (character varying);
CREATE OR REPLACE FUNCTION sp_input_cia_bonoext(character varying)
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
	xml2:=logapp(xml2,'Input-Orig='||input1);
	--Le cambio los valores
	input1:=replace(replace(input1,'&lt;','<'),'&gt;','>');

	--Guardo el CODIGO_CIA
	xml2:=put_campo(xml2,'CODIGO_CIA',get_xml('extCodSeguro',input1));
	--xml2:=put_campo(xml2,'NUM_OPERACION',get_xml('extNumOperacion',input1));

        --Cambio los caracteres < y >
        xml2:=put_campo(xml2,'DATA_CIA','<![CDATA['||chr(10)||'<MsgInput>'||get_xml('MsgInput',input1)||'</MsgInput> ]]>');
	return xml2;
end;
$function$

