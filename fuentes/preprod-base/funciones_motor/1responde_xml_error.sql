/*NO DESARROLLADA:*/
CREATE OR REPLACE FUNCTION responde_xml_error(varchar)
returns varchar as $$
declare
        xml1 		alias for $1;
	stData		respuestas_soap%ROWTYPE;
	xml2 		varchar;
	tipo_tx1	varchar;	
	sp_resp1	varchar;
begin
	xml2:=xml1;
	tipo_tx1:=get_campo('TX_WS',xml2);
	sp_resp1:=get_campo('SQLOUTPUT',xml2);


	--No responde el financiador. Genera un TimeOut?
	if length(get_campo('SQLOUTPUT',xml2)=0 or get_campo('ESTADO_WS',xml2)='-1') then
		xml2:=put_campo('API_ERROR','500');
		xml2:=put_campo(xml2,'MENSAJE_RESP','Financiador_TimeOut'); --TimeOut

	else 
		--Si viene este mensaje, se usa en la respuesta del request del bono3.
	        if (get_campo('API_DESCRIPCION_MSG')>0) then
			xml2:=put_campo(xml2,'ERRORMSG',get_campo('API_DESCRIPCION_MSG'));
		else 
			xml2:=put_campo(xml2,'ERRORMSG',get_campo('API_DESCRIPCION_ERROR');
		end if;
        	--Variables para tx_bono3
	        xml2:=put_campo(xml2,'CODIGO_RESP','2');
        	xml2:=put_campo(xml2,'ESTADO_TX','FALLA_API');	--FALLA_SP
	        xml2:=put_campo(xml2,'MENSAJE_RESP','Error_Motor');	--Financiador_TimeOut
	end if;	

	--Variables de Respuesta del servicio
	xml2:=put_campo(xml2,'ERRORCOD',get_campo('API_ERROR'));

	--Para el header
	xml2:=put_campo(xml2,'STATUS_HTTP',get_campo('ERRORCOD')||' '||get_campo('ERRORMSG'));

        --Busca el XML de Error
        select * into stData from bono3.respuestas_soap where tipo_tx=tipo_tx1;
        if not found then
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Tx');
        end if;

        xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);
        --Proceso la respuesta con los datos en el XML
        xml2:=respuesta_xml(xml2);
        xml2:=responde_http_8081(xml2);

        --Guardo este error, para shell control servicios
        --Si viene el tag_ctamed
        if (tag_cme1 = 'SI') then
                xml2:=ctamed_update_tx(xml2);
        else
                xml2:=b3_update_tx(xml2);
        end if;

        xml2:=put_campo(xml2,'ERROR_LOG','Falla:Conexion_API = '||tipo_tx1);
				
	return xml2;
end;
$$ language 'plpgsql';
