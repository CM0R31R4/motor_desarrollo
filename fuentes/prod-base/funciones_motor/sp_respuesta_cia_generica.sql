/*HTTP/1.1 200 OK
Date: Sun, 22 Jun 2014 15:05:27 GMT
Server: Apache
X-Powered-By: PHP/5.4.4-14+deb7u2
Content-Length: 696
Vary: Accept-Encoding
Content-Type: text/html; charset=UTF-8

<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-EN
V:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&lt;?xml version="1.0" encoding="UTF-8"?&
gt;
&lt;MsgOutput&gt;&lt;CodRetorno&gt;1&lt;/CodRetorno&gt;&lt;MsgError&gt;0&lt;/MsgError&gt;&lt;MsgText&gt;
                &lt;/MsgText&gt;&lt;extFolioAuto&gt;0000087861&lt;/extFolioAuto&gt;&lt;extCodError&gt;S&lt;/extCodErro
r&gt;&lt;extMensajeError&gt; &lt;/extMensajeError&gt;&lt;/MsgOutput&gt;
</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>
*/



CREATE OR REPLACE FUNCTION public.sp_respuesta_cia_generica(character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
        xml1    alias for $1;
        xml2    varchar;
	respuesta1	varchar;
begin
        xml2:=xml1;
	--Viene en este formato con &gt;&lt
	respuesta1:=replace(replace(get_campo('RESPUESTA_CIA',xml2),'&gt;','>'),'&lt;','<');
	xml2:=logapp(xml2,'Respuesta='||respuesta1);
	xml2:=put_campo(xml2,'MsgOutput',split_part(respuesta1,'<MsgOutput',2));
	xml2:=put_campo(xml2,'extFolioAuto',get_xml('extFolioAuto',respuesta1));
	xml2:=put_campo(xml2,'extCodError',get_xml('extCodError',respuesta1));
	xml2:=put_campo(xml2,'extMensajeError',get_xml('extMensajeError',respuesta1));
	xml2:=put_campo(xml2,'CodRetorno',get_xml('CodRetorno',respuesta1));
	xml2:=put_campo(xml2,'MsgError',get_xml('MsgError',respuesta1));
	xml2:=put_campo(xml2,'MsgText',get_xml('MsgText',respuesta1));
	xml2:=put_campo(xml2,'extCodEstBen',get_xml('extCodEstBen',respuesta1));
	xml2:=put_campo(xml2,'columns',get_xml('columns',respuesta1));
	xml2:=put_campo(xml2,'extEstaBon',get_xml('extEstaBon',respuesta1));
	return xml2;
end;
$function$

