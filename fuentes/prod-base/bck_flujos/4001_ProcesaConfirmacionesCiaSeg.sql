delete from isys_querys_tx where llave='4001';

insert into isys_querys_tx values ('4001',10,1,1,'select proc_procesa_input_4001(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Confirmacion
insert into isys_querys_tx values ('4001',20,1,2,'Llamada a la Cia',4010,4000,4001,0,0,30,30);
--Certificacion y Anulacion
insert into isys_querys_tx values ('4001',22,1,2,'Llamada a la Cia',4011,4000,4001,0,0,30,30);

insert into isys_querys_tx values ('4001',30,1,1,'select proc_procesa_respuesta_4001(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Llama al Sybase de Certificacion para confirmar 
insert into isys_querys_tx values ('4001',45,5000,1,'$$SQLINPUT$$',0,0,0,6,1,50,50);
--Llama al Sybase para confirmar 
insert into isys_querys_tx values ('4001',40,4100,1,'$$SQLINPUT$$',0,0,0,6,1,50,50);

insert into isys_querys_tx values ('4001',50,1,1,'select proc_verifica_sybase_4001(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_procesa_input_4001(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	tipo_tx1	varchar;
	cod_motor1	bigint;	
	respuesta1	varchar;
	sql1		varchar;
	compania1	varchar;
	stCia	cias_seguros%ROWTYPE;
	i	integer;
	file_wsdl1	varchar;
	host1	varchar;
	url1	varchar;
	codigo_cia1	varchar;
	header1	varchar;
	port1	varchar;
	input1	varchar;
	stReq	requerimientos_cia%ROWTYPE;
	msg1	varchar;
	tx1	varchar;
	soapaction1	varchar;
begin
	xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2:=put_campo(xml2,'STATUS_CIA','');

	--Verificamos si es un wsdl
        xml2:=logapp(xml2,get_campo('REQUEST_METHOD',xml2)||'-'||get_campo('REQUEST_URI',xml2));
        if (get_campo('REQUEST_METHOD',xml2)='GET' and strpos(get_campo('REQUEST_URI',xml2),'wsdl')>0) then
                tx1:=split_part(get_campo('REQUEST_URI',xml2),'/',2);
                compania1:=split_part(split_part(get_campo('REQUEST_URI',xml2),'/cia_seg_',2),'?',1);
                SELECT pg_read_file('wsdl/wsdl_'||lower(tx1)||'_cia_seg.wsdl') into file_wsdl1;
                file_wsdl1:=replace(file_wsdl1,chr(36)||chr(36)||'LOCATION'||chr(36)||chr(36),compania1);
                xml2:=logapp(xml2,'Responde WSDL para '||compania1);
                xml2:=put_campo(xml2,'RESPUESTA','Status: 200 OK'||chr(10)||'Content-type: text/html'||chr(10)||'Conte
nt-length: '||length(file_wsdl1)||chr(10)||chr(10)||file_wsdl1);
                return xml2;
        end if;


	--Si el estado sybase indica que fallo el sybase y solo falta eso...
	if ((get_campo('ESTADO_SYBASE',xml2)='SOLO_SYBASE') and (length(get_campo('SQLINPUT',xml2))>0)) then
		xml2:=logapp(xml2,'Codigo Cia SOLO_SYBASE '||get_campo('CODIGO_CIA',xml2));
		--Reemplaza <C> por '
		xml2:=put_campo(xml2,'SQLINPUT',replace(get_campo('SQLINPUT',xml2),'<C>',chr(39)));
		
		--Parche para Vida Camara
		if (get_campo('CODIGO_CIA',xml2) in ('45')) then
			input1	:=decode(get_campo('INPUT',xml2),'hex');
			xml2:=sp_respuesta_cia_generica(xml2);
			xml2:=logapp(xml2,'extFolioBono='||get_xml('extFolioBono',input1)||' extRutBeneficiario='||get_xml('extRutBeneficiario',input1)||'extFolioAuto='||get_campo('extFolioAuto',xml2));
					
			if (get_campo('TX_CIA',xml2)='Anulacion') then
				xml2:=put_campo(xml2,'SQLINPUT','declare	@CodError tinyint execute CSConfirmaAnuU '||get_xml('extFolioBono',input1)||','||quote_literal(get_xml('extRutBeneficiario',input1))||', @CodError OUTPUT select @CodError as respuesta_sybase');
			else
				xml2:=put_campo(xml2,'SQLINPUT','declare	@CodError tinyint execute CSConfirmaSegU '||get_xml('extFolioBono',input1)||','||get_xml('extCodFinanciador',input1)||','||get_campo('extFolioAuto',xml2)||', @CodError OUTPUT select @CodError as respuesta_sybase');
			end if;
		end if;	
		
		xml2	:=logapp(xml2,'Reprocesa Estado SOLO_SYBASE');
		xml2    :=put_campo(xml2,'TIEMPO_INI_SYBASE',clock_timestamp()::varchar);
		xml2	:=put_campo(xml2,'__SECUENCIAOK__','40');
		return xml2;
	end if;
	
	--Identifica la compania de seguro segun el REQUEST_URI
	--Debe venir en este formato /Tx/cia_seg_<Nemo del la compania>
	tx1:=split_part(get_campo('REQUEST_URI',xml2),'/',2);
	xml2:=put_campo(xml2,'TX_CIA',tx1);
	compania1:=split_part(get_campo('REQUEST_URI',xml2),'/cia_seg_',2);
	xml2:=put_campo(xml2,'NEMO_CIA',compania1);
	xml2	:=logapp(xml2,'Procesa Compania '||compania1);

	--Parche para la camara
	--OBtengo el codigo de cia
	--&gt;&lt;extCodSeguro&gt;17&lt;/extCodSeguro&gt;
	input1:=decode(get_campo('INPUT',xml2),'hex');
	codigo_cia1:=get_xml2('extCodSeguro',input1);
	xml2:=logapp(xml2,'Codigo Cia='||codigo_cia1);
	--Verifico que sea numerico
	if (is_number(codigo_cia1) is false) then
                xml2:=logapp(xml2,'500 Codigo de Cia '||codigo_cia1||' no numerico');
		respuesta1:='Codigo de Cia '||codigo_cia1||' no numerico';
		xml2:=sp_procesa_respuesta_cola_cia(xml2);
                return xml2;
	end if;
	
	--Verificamos si esta la compania
	--select * into stCia from cias_seguros where nemo=compania1 and tx=tx1;
	select * into stCia from cias_seguros where codigo=codigo_cia1::integer and tx=tx1;
	if not found then
                xml2:=logapp(xml2,'500 '||compania1||' no definida');
		respuesta1:=compania1||' no definida';
		xml2:=sp_procesa_respuesta_cola_cia(xml2);
                return xml2;
	end if;
	compania1:=stCia.nemo;

	xml2:=put_campo(xml2,'FUNCION_RESPUESTA',stCia.funcion_respuesta);


	--Si es una Anulacionm, debo validar que exista una confirmacion y esta este Aprobada
	


	host1:=split_part(split_part(stCia.url,'http://',2),'/',1);
	url1:=split_part(stCia.url,host1,2);
	port1:=split_part(split_part(host1,':',2),'/',1);
	host1:=split_part(host1,':',1);
	xml2:=put_campo(xml2,'__IP_CONEXION_CLIENTE__',host1);
	if (port1='') then
		port1:='80';
	end if;
	xml2:=put_campo(xml2,'__IP_PORT_CLIENTE__',port1);
	
	xml2:=logapp(xml2,'Host='||host1||' Port='||port1||' Url='||url1);

	--Obtenemos el requerimiento obtenido para esta tx desde el wsdl
	select * into stReq from requerimientos_cia where nemo=stCia.nemo and tx=stCia.tx;
	if not found then
		--Leo una respuesta por defecto
		select * into stReq from requerimientos_cia where nemo='defecto' and tx=stCia.tx;
		if not found then
                	xml2:=logapp(xml2,'500 no existe registro en requerimientos_cia');
			xml2:=sp_procesa_respuesta_cola_cia(xml2);
        	        return xml2;
		end if;
	end if;

	if length(stCia.funcion_input)>0 then
		 xml2:=logapp(xml2,'Ejecuta '||stCia.funcion_input);
		 EXECUTE 'SELECT ' || stCia.funcion_input || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
	end if;

	--Armamos el requerimiento
	--En el input hay que reemplazar los < > por &lt; y &gt;
	--Solo saco el campo MsgInput 
	
	--input1:=decode(get_campo('INPUT',xml2),'hex');
	
	--Cambio los caracteres < y >
	--msg1:=replace(replace('<?xml version="1.0" encoding="UTF-8"?>'||chr(10)||'<MsgInput>'||get_xml('MsgInput',input1)||'</MsgInput>','<','&lt;'),'>','&gt;');
	--msg1:='<MsgInput>'||get_xml('MsgInput',input1)||'</MsgInput>';
	
	--Reemplazo el TAG por el mensaje
	input1:=encode(replace(stReq.data,'&-&DATA&-&',get_campo('DATA_CIA',xml2))::bytea,'hex');
	xml2:=logapp(xml2,'Hacia la Cia ='||replace(stReq.data,'&-&DATA&-&',get_campo('DATA_CIA',xml2)));



	soapaction1:='http://tempuri.org/wmImed_Srv'||tx1;
	--Cambiamos el SoapAction segun el tipo de tx entrante
	if (tx1 in ('Confirmacion','Anulacion')) then 
        	xml2:=put_campo(xml2,'__SECUENCIAOK__','20');
	else
		--Todo el resto va al 22 con un timeout mas bajo
        	xml2:=put_campo(xml2,'__SECUENCIAOK__','22');
	end if;

	header1:='POST '||url1||' HTTP/1.1'||chr(10)||'Host: '||host1||':'||port1||chr(10)||'Content-Type: text/xml;charset=UTF-8 '||chr(10)||'User-Agent: MotorIMed1.1'||chr(10)||'SOAPAction: "'||soapaction1||'"'||chr(10)||'Accept: */*'||chr(10)||'Content-Length: '||(length(input1)/2)::varchar||chr(10)||chr(10);
    	xml2:=put_campo(xml2,'INPUT_CIA',encode(header1::bytea,'hex')::varchar||input1);


	--Seteamos TIEMPO_INI
	xml2:=put_campo(xml2,'TIEMPO_INI_CIA',clock_timestamp()::varchar);
	return xml2;	
end;
$$
LANGUAGE plpgsql;

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_procesa_respuesta_4001(varchar)
returns varchar as
$$
declare
	xml1	alias for $1;
	xml2	varchar;
	f1	varchar;
	input1	varchar;
	stData respuestas_soap%ROWTYPE;
	stSeg	tx_cias%ROWTYPE;
	tipo_tx1	varchar;
	respuesta1	varchar;
	tipo1	varchar;
	folioauto1	varchar;
	codigo_cia1	varchar;
begin
	xml2:=xml1;
	xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2	:=put_campo(xml2,'TIEMPO_FIN_CIA',clock_timestamp()::varchar);
	input1	:=decode(get_campo('INPUT',xml2),'hex');
	tipo_tx1:=get_campo('TX_CIA',xml2);
	xml2:=logapp(xml2,'Tx='||tipo_tx1);

	f1:=get_campo('FUNCION_RESPUESTA',xml2);
	if length(f1)>0 then
		 xml2:=logapp(xml2,'Ejecuta '||f1);
		 EXECUTE 'SELECT ' || f1 || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
	end if;
			
	--Se graba por defecto
	xml2:=put_campo(xml2,'TIEMPO_INI_SYBASE',clock_timestamp()::varchar);
	xml2:=put_campo(xml2,'TIEMPO_FIN_SYBASE',clock_timestamp()::varchar);
	
	--Si nos fue bien y es una confirmacion vamos al sybase
	--if (get_campo('extCodError',xml2)='N') then
	if (tipo_tx1 in ('Confirmacion','Anulacion')) then
		xml2:=logapp(xml2,'Respuesta Cia='||get_campo('extMensajeError',xml2)||' Status='||get_campo('extCodError',xml2));
		--Siu contesta bien la cia y el extFolioAuto es <> -1
		if (get_campo('extCodError',xml2)='S' and get_campo('extFolioAuto',xml2)<>'-1') then
			--Vamos a confirmar al sybase
			if (tipo_tx1='Confirmacion') then
				xml2:=logapp(xml2,'Se Confirma en Sybase');
				xml2:=put_campo(xml2,'SQLINPUT','declare	@CodError tinyint execute CSConfirmaSegU '||get_xml('extFolioBono',input1)||','||get_xml('extCodFinanciador',input1)||','||get_campo('extFolioAuto',xml2)||', @CodError OUTPUT select @CodError as respuesta_sybase');
				xml2    :=put_campo(xml2,'__SECUENCIAOK__','40');
			elsif (tipo_tx1='Anulacion') then
				/*--Tengo que saber el extFolioBono que esta en 
				folioauto1:=get_xml('extFolioAuto',input1);
				codigo_cia1:=get_campo('CODIGO_CIA',xml2);

				select * into stSeg from tx_cias where extfolioauto=foliobono1 and codigo_cia=codigo_cia1 and tx='Confirmacion';
				if not found then
					xml2:=logapp(xml2,'No se encuentra extfolioauto='||foliobono1||' en tx_cias');
					xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
					return xml2;
				end if;
				*/
				xml2:=logapp(xml2,'Se Anula en Sybase');
				xml2:=put_campo(xml2,'SQLINPUT','declare	@CodError tinyint execute CSConfirmaAnuU '||get_xml('extFolioBono',input1)||','||quote_literal(get_xml('extRutBeneficiario',input1))||', @CodError OUTPUT select @CodError as respuesta_sybase');
				xml2    :=put_campo(xml2,'__SECUENCIAOK__','40');
			else
				xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
			end if;
			xml2 	:=logapp(xml2,get_campo('SQLINPUT',xml2));
			xml2	:=put_campo(xml2,'ESTADO_CIA','CIA_OK');
			xml2:=graba_tx_cia(xml2);
			return xml2;
		--Si la cia me rechaza la confirmacion
		elsif (get_campo('extCodError',xml2)='N') then
			xml2:=logapp(xml2,'Cia Rechaza la '||tipo_tx1);
			xml2:=put_campo(xml2,'STATUS_CIA','CIA_RECHAZO');
			xml2:=sp_procesa_respuesta_cola_cia(xml2);
			xml2:=put_campo(xml2,'ESTADO_CIA','CIA_RECHAZO');
			xml2:=graba_tx_cia(xml2);
			return xml2;
		else
			--Si fallo,
			xml2:=logapp(xml2,'Falla '||tipo_tx1||' Cia');
			xml2:=logapp(xml2,'Respuesta Cia='||get_campo('RESPUESTA_CIA',xml2));
			xml2:=put_campo(xml2,'ESTADO_CIA','CIA_ERROR');
			xml2:=sp_procesa_respuesta_cola_cia(xml2);
			xml2:=graba_tx_cia(xml2);
			return xml2;
		end if;
	--Para todas las otras tx...
	elsif (tipo_tx1 in ('Certificacion','Conciliacion')) then
			
		xml2:=logapp(xml2,'Respuesta Cia='||get_campo('extMensajeError',xml2)||' Status='||get_campo('extCodError',xml2));
		--Sacamos la data de respuesta
        	tipo1:=upper(tipo_tx1)||'_CIA_SEGURO'; --Es la misma de la Confirmacion
	        select * into stData from respuestas_soap where tipo_tx=tipo1;
        	if not found then
                	xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Tx1');
	                xml2:=logapp(xml2,'No existe respuesta_soap, 500 Falla Tx='||tipo_tx1);
        	        --Proceso la respuesta con los datos en el XML
                	respuesta1:='Tx no Definida';
	                xml2:=put_campo(xml2,'RESPUESTA','Status: 500 NK'||chr(10)||'Content-type: text/html'||chr(10)||'Content-length: '||length(respuesta1)||chr(10)||chr(10)||respuesta1);
        	        return xml2;
	        end if;
        	xml2:=put_campo(xml2,'XML_RESPUESTA',stData.respuesta);
		if (get_campo('extCodError',xml2)='S') then
			xml2:=logapp(xml2,'Cia Aprueba la '||tipo_tx1);
			xml2:=put_campo(xml2,'ESTADO_CIA','CIA_OK');
		elsif (get_campo('extCodError',xml2)='N') then
			xml2:=put_campo(xml2,'ESTADO_CIA','CIA_RECHAZO');
			xml2:=logapp(xml2,'Cia Rechaza la '||tipo_tx1);
			xml2:=logapp(xml2,'Respuesta Cia='||get_campo('RESPUESTA_CIA',xml2));
		else
			xml2:=put_campo(xml2,'ESTADO_CIA','CIA_ERROR');
			xml2:=logapp(xml2,'Cia No contesta la '||tipo_tx1);
			xml2:=put_campo(xml2,'extCodError','X');
			xml2:=put_campo(xml2,'extMensajeError','Cia No contesta la '||tipo_tx1);
			xml2:=logapp(xml2,'Respuesta Cia='||get_campo('RESPUESTA_CIA',xml2));
		end if;
		--xml2:=responde_http_cert_cia(xml2);
		EXECUTE 'SELECT responde_http_' || lower(tipo_tx1) || '_cia(' || chr(39) || xml2 || chr(39) || ')' into xml2;
		xml2:=graba_tx_cia(xml2);
	
	else
		--Contesto respuessta OK
		return xml2;
	end if;
	return xml2;
end;
$$
LANGUAGE plpgsql;

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_verifica_sybase_4001(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        f1      varchar;
begin
	xml2:=xml1;
		
	xml2	:=put_campo(xml2,'TIEMPO_FIN_SYBASE',clock_timestamp()::varchar);
	--Verifico primero la grabacion en sybase
	if (get_campo('RESPUESTA_SYBASE_1',xml2)<>'0') then
		xml2:=logapp(xml2,'Falla Confirmacion de Sybase, se reintenta');
		xml2:=logapp(xml2,'ID COLA='||get_campo('__ID_DTE__',xml2)||' SQL='||get_campo('SQLINPUT',xml2));
		xml2:=put_campo(xml2,'STATUS_CIA','SOLO_SYBASE');
		xml2:=sp_procesa_respuesta_cola_cia(xml2);
			
		xml2:=put_campo(xml2,'ESTADO_CIA','ERROR_SYBASE');
		xml2:=graba_tx_cia(xml2);
		return xml2;	
	end if;  

	--Nos fue bien...borramos
	xml2:=logapp(xml2,'Exito, se graba y se borra de la cola');
	xml2:=put_campo(xml2,'STATUS_CIA','OK');
	xml2:=put_campo(xml2,'ESTADO_CIA','OK');
	xml2:=graba_tx_cia(xml2);
	xml2:=sp_procesa_respuesta_cola_cia(xml2);
	return xml2;
end;
$$
LANGUAGE plpgsql;

