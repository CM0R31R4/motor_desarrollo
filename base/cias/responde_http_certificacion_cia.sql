--Respuesta de la certificacion de las cia de seguros
CREATE OR REPLACE FUNCTION responde_http_certificacion_cia(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        respuesta1      varchar;

	monto1		varchar;
	num_prest1	varchar;
	result_prest1	integer=1;
	frase1		varchar;
	query1		varchar;

	i		integer=1;
	aporteSeguro1	varchar='';
BEGIN
        xml2	:=xml1;
	
	-- Original, no borrar. [Nota de CM].
	--respuesta1:=replace(get_campo('XML_RESPUESTA',xml2),'&-&DATA&-&',chr(10)||'<MsgOutput>'||chr(10)||'<extCodEstBen>'||get_campo('extCodEstBen',xml2)||'</extCodEstBen><columns>'||get_campo('columns',xml2)||'</columns>'||chr(10)||'<extCodError>'||get_campo('extCodError',xml2)||'</extCodError>'||chr(10)||'<extMensajeError>'||get_campo('extMensajeError',xml2)||'</extMensajeError>'||chr(10)||'</MsgOutput>');

	xml2:=logapp(xml2,'CODIGO_SEGURO='||get_campo('CODIGO_CIA', xml2));

	IF get_campo('CODIGO_CIA', xml2) = '104' THEN
		-- Cuando el codigo es V significa que es un beneficiario habilitado, por lo que se debe realizar el cambio.
		IF get_campo('extCodEstBen',xml2) = 'V' THEN	
			frase1  :=replace(replace(replace(get_campo('columns',xml2),'</',' '),'>',' '),'<',' ');

			num_prest1:=cuenta_palabras(frase1, 'extAporteSeguro');
			xml2:=logapp(xml2,'RESULTADO='||num_prest1);

			result_prest1:=num_prest1::integer / 2;
			xml2	:=logapp(xml2,'RESULTADO_PRESTACION='||result_prest1);
	
			IF result_prest1 = 0 THEN
				query1:='SELECT trunc(random() * -5000 + 1)';
                		EXECUTE query1 INTO monto1;
                		aporteSeguro1   :='<extAporteSeguro>'||monto1::varchar||'</extAporteSeguro> ';
			ELSE
				FOR i IN 1..result_prest1::integer LOOP
					query1:='SELECT trunc(random() * -5000 + 1)';
					EXECUTE query1 INTO monto1;
					aporteSeguro1   :=aporteSeguro1||'<extAporteSeguro>'||monto1::varchar||'</extAporteSeguro> ';
					i:=i + 1;
				END LOOP;
			END IF;

			respuesta1:=replace(get_campo('XML_RESPUESTA',xml2),'&-&DATA&-&',chr(10)||'<MsgOutput>'||chr(10)||'<extCodEstBen>'||get_campo('extCodEstBen',xml2)||'</extCodEstBen><columns>'||aporteSeguro1||'</columns>'||chr(10)||'<extCodError>S</extCodError>'||chr(10)||'<extMensajeError>'||get_campo('extMensajeError',xml2)||'</extMensajeError>'||chr(10)||'</MsgOutput>');
	
		ELSE
			-- En caso contrario se ocupa la respuesta estandar.
			respuesta1:=replace(get_campo('XML_RESPUESTA',xml2),'&-&DATA&-&',chr(10)||'<MsgOutput>'||chr(10)||'<extCodEstBen>'||get_campo('extCodEstBen',xml2)||'</extCodEstBen><columns>'||get_campo('columns',xml2)||'</columns>'||chr(10)||'<extCodError>'||get_campo('extCodError',xml2)||'</extCodError>'||chr(10)||'<extMensajeError>'||get_campo('extMensajeError',xml2)||'</extMensajeError>'||chr(10)||'</MsgOutput>');	

		END IF;
	ELSE
		respuesta1:=replace(get_campo('XML_RESPUESTA',xml2),'&-&DATA&-&',chr(10)||'<MsgOutput>'||chr(10)||'<extCodEstBen>'||get_campo('extCodEstBen',xml2)||'</extCodEstBen><columns>'||get_campo('columns',xml2)||'</columns>'||chr(10)||'<extCodError>'||get_campo('extCodError',xml2)||'</extCodError>'||chr(10)||'<extMensajeError>'||get_campo('extMensajeError',xml2)||'</extMensajeError>'||chr(10)||'</MsgOutput>');
	END IF;

        xml2:=put_campo(xml2,'RESPUESTA','Status: 200 OK'||chr(10)||'Content-type: text/html'||chr(10)||'Content-length: '||(length(respuesta1))::varchar||chr(10)||chr(10)||respuesta1);

	RETURN xml2;
END;
$$
LANGUAGE plpgsql;
