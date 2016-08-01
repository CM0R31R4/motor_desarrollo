delete from isys_querys_tx where llave='3000';

insert into isys_querys_tx values ('3000',10,1,1,'SELECT proc_parser_traductor_ws_3000(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--insert into isys_querys_tx values ('3000',20,1,1,'SELECT sp_call_cme_3000(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

insert into isys_querys_tx values ('3000',30,1,1,'SELECT proc_parser_respuesta_ws_3000(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);
--Limpia Variables
--insert into isys_querys_tx values ('3000',35,1,1,'SELECT ''CLEAR_JCC'' as SQLINPUT',0,0,0,1,1,30,30);

--SERVICIO MEDICO CCHC (Con GET_MULTIPLE)
insert into isys_querys_tx values ('3000',11,11,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
--VIDA CAMARA (Con GET_MULTIPLE)
insert into isys_querys_tx values ('3000',44,44,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);

--SAN LORENZO (Port=8062)
--insert into isys_querys_tx values ('3000',62,1,2,'Oracle SANLORENZO',8063,110,111,1,1,30,30);
--FUSAT (Port=8063)
--insert into isys_querys_tx values ('3000',63,1,2,'Oracle FUSAT',8063,110,111,1,1,30,30);
--CHUQUICAMATA (Port=8065)
--insert into isys_querys_tx values ('3000',65,1,2,'Oracle CHUQUICAMATA',8063,110,111,1,1,30,30);
--RIO BLANCO (Port=8068)
--insert into isys_querys_tx values ('3000',68,1,2,'Oracle RIOBLANCO',8063,110,111,1,1,30,30);

--COLMENA
insert into isys_querys_tx values ('3000',67,67,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
--CONSALUD
--insert into isys_querys_tx values ('3000',71,1,2,'Oracle CONSALUD',8071,110,111,1,1,30,30);
--insert into isys_querys_tx values ('3000',71,2,1,'Oracle CONSALUD',8071,100,101,1,1,30,30);
--FUNDACION
--insert into isys_querys_tx values ('3000',76,1,2,'Oracle FUNDACION',8076,110,111,1,1,30,30);
--CRUZ_BLANCA
--JCC:06-06-2013 Nuevo ESPERA_OUTPUT_1. Soporta Array
--Nativo API BAse Datos
--insert into isys_querys_tx values ('3000',78,78,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
insert into isys_querys_tx values ('3000',78,78,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
--FERROSALUD (Con GET_MULTIPLE)
insert into isys_querys_tx values ('3000',81,81,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
--MASVIDA (Con GET_MULTIPLE)
insert into isys_querys_tx values ('3000',88,88,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);	--GET_MULTIPLE
--insert into isys_querys_tx values ('3000',88,88,1,'$$SQLINPUT$$',0,0,0,1,1,30,30);	--GET_RECORD

--VIDA TRES (Port=8077)
--insert into isys_querys_tx values ('3000',80,1,2,'Oracle VIDATRES',8099,110,111,1,1,30,30);	--Por la Api de Banmedica
--BANMEDICA (Port=8099)
--insert into isys_querys_tx values ('3000',99,1,2,'Oracle BANMEDICA',8099,110,111,1,1,30,30);

--Servicio MultiApis Oracle
insert into isys_querys_tx values ('3000',900,1,2,'Oracle MULTIAPI',8100,110,111,1,1,30,30);

--FONASA(Consume WebService)
insert into isys_querys_tx values ('3000',100,1,2,'FONASA_WS',9000,110,111,1,1,30,30);   --Llama un servicio de tabla servicios
--insert into isys_querys_tx values ('3000',100,1,2,'FONASA_WS',9000,200,201,1,1,30,30);   --Llama un servicio de tabla servicios
--insert into isys_querys_tx values ('3000',100,2,1,'FONASA_WS',9000,200,201,1,1,30,30); --Usa la BaseDatos Nro=2


--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_parser_traductor_ws_3000(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
        xml2    	varchar;
	stSec		bono3.define_secuencia_ws%ROWTYPE;
	stData		bono3.respuestas_soap%ROWTYPE;
	tipo_tx1	varchar;
	input1	 	varchar;
	cod_motor1	varchar;
        id_fin1 	integer;
	xml_error1	varchar;
	query1		varchar;
	puerto1		varchar;
	
	cont1		integer='1';
	aux1		varchar;
	folios1		varchar='';
begin
	xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	--xml2	:=put_campo(xml2,'ESTADO_TX','');
	xml2	:=put_campo(xml2,'CODIGO_RESP','');
	xml2	:=put_campo(xml2,'MENSAJE_RESP','');
	xml2	:=put_campo(xml2,'FECHA_IN_TX',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));
	
	input1	:=get_campo('INPUT',xml2);
	xml2    :=put_campo(xml2,'__HOST__',split_part(split_part(input1,'Host: ',2),chr(10),1));
                
	
	--Validamos si el XML entrante es un documento xml valido
	xml2 	:=valida_documento_xml(xml2);
	if length(get_campo('__XML_STD__',xml2))=0 then
		xml2:=put_campo(xml2,'STATUS_HTTP','400 Xml Invalido');
		xml2:=put_campo(xml2,'ERRORCOD','400');
                xml2:=put_campo(xml2,'ERRORMSG','Xml Invalido');
		xml2:=logapp(xml2,'400 Xml Invalido, no hay respuesta');
		return xml2;
	end if;
	
	--Busca el tipo_tx en el XML Input. tag1:='<ws:' o tag1:='<ns1:'
	xml2 	:=busca_tx_data_xml(xml2);
	
	tipo_tx1:=get_campo('TX_WS',xml2);	
	cod_motor1:=nextval('correlativo_motor')::varchar;
        xml2:=put_campo(xml2,'CODIGO_MOTOR',cod_motor1);
	
	--Lee Datos de la respuesta
        select * into stData from bono3.respuestas_soap where tipo_tx=tipo_tx1;
        if not found then
        	xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Tx1');
		xml2:=logapp(xml2,'No existe respuesta_soap, 500 Falla Tx='||tipo_tx1::varchar);
		--En caso de error, igual respondo un con un XML
                xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);
                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http(xml2);
                return xml2;
        end if;
	xml2:=put_campo(xml2,'XML_ERROR',stData.xml_error);
	xml2:=put_campo(xml2,'XML_OK',stData.respuesta);

	--Parsea los datos del XML entrante, recibe un xml como parametro tag_busqueda='<ws:datosprest>'
	xml2:=parser_xml(xml2,get_campo('TAG_BUSQUEDA',xml2));
	--xml2:=parser_xml2(xml2,get_campo('TAG_BUSQUEDA',xml2));

	--Input Financiador Bono3
	if is_number(get_campo('EXTCODFINANCIADOR',xml2)) then
		id_fin1	:=get_campo('EXTCODFINANCIADOR',xml2)::integer;
	
	else
		xml2:=put_campo(xml2,'STATUS_HTTP','400 Financiador No Encontrado');
		xml2:=put_campo(xml2,'ERRORCOD','400');
                xml2:=put_campo(xml2,'ERRORMSG','Financiador No Encontrado');
		xml2:=logapp(xml2,'Financiador No Encontrado');

                --En caso de error, igual respondo un con un XML
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));

                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http(xml2);

                return xml2;
	end if;
	
	--Para guardar el Id del Financiador en la Base	
	xml2:=put_campo(xml2,'ID_FIN',id_fin1::varchar);

	--Obtengo el secuenciaOK y la funcion Input del financiador. Por tipo de trx. 
	select * into stSec from bono3.define_secuencia_ws where tipo_tx=tipo_tx1 and financiador = id_fin1;
	if not found then
		xml2:=put_campo(xml2,'ERROR_LOG','No existe transaccion = '||tipo_tx1||' financiador = '||id_fin1::varchar);
		xml2:=put_campo(xml2,'STATUS_HTTP','400 Peticion Incorrecta');
		xml2:=put_campo(xml2,'ERRORCOD','400');
		xml2:=put_campo(xml2,'ERRORMSG','Servicio No Habilitado');
		xml2:=logapp(xml2,'No existe transaccion = '||tipo_tx1||' financiador = '||id_fin1::varchar);
	
		--Proceso la respuesta con los datos en el XML
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
	        xml2:=respuesta_xml(xml2);
        	xml2:=responde_http(xml2);
	
		return xml2;
	end if;

	xml2:=put_campo(xml2,'FUNCION_OUTPUT',stSec.funcion_output);
	xml2:=put_campo(xml2,'FINANCIADOR',stSec.descripcion);

	--EJECUTA FUNCION INPUT
	--raise notice 'JCC_3000_INPUT_EXEC=%',stSec.funcion_input;
	xml2:=logapp(xml2,'Ejecuta='||stSec.funcion_input);
	if length(stSec.funcion_input)>0 then 
		--xml2 := put_campo(xml2,'__FUNCION__',get_campo('__FUNCION__',xml2) || '-' || stSec.funcion_input);
		EXECUTE 'SELECT ' || stSec.funcion_input || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
	end if;
	
	--raise notice 'JCC_stSec.ip_generica =%',coalesce(stSec.ip_generic,'');

	--Si trae IP_GENERICA la usamos
	if (stSec.ip_generica is not null) then
		xml2:=put_campo(xml2,'__IP_CONEXION_CLIENTE__',stSec.ip_generica);
		query1:='SELECT NEXTVAL('||quote_literal(stSec.correlativo_port_generica)||')';
                EXECUTE query1 into puerto1;
		xml2:=put_campo(xml2,'__IP_PORT_CLIENTE__',coalesce(puerto1,'0'));
		--raise notice 'JCC_stSec.correlativo_port_generic =%',stSec.correlativo_port_generica;
		xml2:=logapp(xml2,'Conexion a '||stSec.ip_generica::varchar||' Port='||coalesce(puerto1,'0')::varchar);
	end if;
	
	--Usa la secuenciaOK, seteada en tabla t_define_secuencia
	xml2:=put_campo(xml2,'__SECUENCIAOK__',stSec.secuencia::varchar);
	
	--En caso de error en el formato del Rut 
	if get_campo('ERROR_RUT',xml2) = 'SI' then
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Error Rut');
                xml2:=put_campo(xml2,'ERRORCOD','500');
                xml2:=put_campo(xml2,'ERRORMSG','Rut Invalido');
		xml2:=logapp(xml2,'Rut Invalido');

                --Proceso la respuesta con los datos en el XML
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http(xml);
		--No va al Financiador en caso de error
		xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
                return xml2;
        end if;
	
	--TODO: Servicio Dummies. Nunca va al Financiador para este servicio en PROD.
        if (tipo_tx1='envbonis' or tipo_tx1='envbono')  then
        	xml2:=logapp(xml2,'Envbonis: Respuesta.Dummy');

                xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','');
                xml2:=put_campo(xml2,'EXTCODERROR','S');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','APROBADA MOTOR');

		--Genera Respuesta SOAP OK.
	        xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));
		--Para Registro en Tabla tx_bono3
		xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
        	xml2    :=put_campo(xml2,'CODIGO_RESP','1');
        	xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummies');
			xml2:=b3_registra_tx(xml2);
			--xml2:=logapp(xml2,'RUT='||get_campo('RUT_BASE',xml2));
		--Proceso la respuesta con los datos en el XML
	        xml2:=respuesta_xml(xml2);
        	xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
	        xml2:=responde_http(xml2);
		
		--No va al Financiador
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
		
		return xml2;
        end if;	

	--TODO: Servicio Dummies. Nunca va al Financiador para este servicio en PROD.
        if (tipo_tx1='solicfolios')  then
        	xml2:=logapp(xml2,'SolicFolios: Respuesta.Dummy');
		while (cont1 <= get_campo('EXTNUMFOLIOS',xml2)::integer) 
		loop
			aux1:=nextval('seq_folios');
			folios1:=folios1||aux1||',';
			cont1:=cont1+1;
		end loop;
		xml2:=logapp(xml2,'FOLIOS: '||folios1);
		--Quito la ultima coma (ya que no volvera al ciclo) y se sale
                if length(folios1)>0 then
                	folios1:=substring(folios1,1,length(folios1)-1);
                end if;
		
		--Variables de Respuesta
		xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','');
		xml2:=put_campo(xml2,'EXTCODERROR','S');
	        xml2:=put_campo(xml2,'EXTMENSAJEERROR','APROBADO MOTOR');
        	xml2:=put_campo(xml2,'EXFOLIOSDEVUELTOS','['||folios1||']');

		--Genera Respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));
                --Para Registro en Tabla tx_bono3
                xml2    :=put_campo(xml2,'ESTADO_TX','EN_DURO');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Dummies');
			xml2:=b3_registra_tx(xml2);
			--xml2:=logapp(xml2,'RUT='||get_campo('RUT_BASE',xml2));
                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http(xml2);

                --No va al Financiador
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

		return xml2;	
	end if;

	--Si voy al financiador, guardo el registro en la tabla
	xml2:=b3_registra_tx(xml2);
	xml2:=logapp(xml2,'RUT='||get_campo('RUT_BASE',xml2));
	
	return xml2;	
end;
$$
LANGUAGE plpgsql;

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_parser_respuesta_ws_3000(varchar)
returns varchar as
$$
declare
        xml1    	alias for $1;
	stData		bono3.respuestas_soap%ROWTYPE;
        xml2   		varchar;
	tipo_tx1	varchar;
	func_out1	varchar;
        id_fin1 	integer;
	fec_in1		varchar;
	fec_out1	varchar;
        timeout1	varchar;
	seg1		varchar;

begin
	xml2:=xml1;
	--timeout1:=0;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2	:=put_campo(xml2,'SQLINPUT','');
	xml2	:=put_campo(xml2,'RQT_XML','CLEAR');
	--xml2	:=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
	--xml2	:=put_campo(xml2,'CODIGO_RESP','');
	--xml2	:=put_campo(xml2,'MENSAJE_RESP','');
	xml2	:=put_campo(xml2,'FECHA_OUT_TX',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));
	
	tipo_tx1:=get_campo('TX_WS',xml2); --Bencertif
        id_fin1:=get_campo('ID_FIN',xml2)::integer;
	
	func_out1:=get_campo('FUNCION_OUTPUT',xml2);
	--raise notice 'JCC_3000_OUT_EXEC=%',func_out1;
	xml2:=logapp(xml2,'Ejecuta Funcion ='||func_out1);
	--Antes de ejecutar la funcion_out, 
	--Si fue a la API del Financiador, debe pasar por traductor_out_solicfolios_isapre y luego entra a esta funcion
       	if length(func_out1)>0 then
       		--xml2 := put_campo(xml2,'__FUNCION__',get_campo('__FUNCION__',xml2) || '-' || func_out1);
               	EXECUTE 'SELECT ' || func_out1 || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
		--raise notice 'JCC_3000_RESP_1 Mens=% - Cod_Resp=%',get_campo('MENSAJE_RESP',xml2),get_campo('CODIGO_RESP',xml2);
		xml2:=logapp(xml2,'Respuesta="'||get_campo('MENSAJE_RESP',xml2)||'" Codigo='||get_campo('CODIGO_RESP',xml2));
       	end if;

	--Calculo del Tiempo de Procesamiento. TimeOut
	/*fec_in1	:=to_timestamp(get_campo('FECHA_IN_TX',xml2),'YYYY-MM-DD HH24:MI:SS');
	fec_out1:=to_timestamp(get_campo('FECHA_OUT_TX',xml2),'YYYY-MM-DD HH24:MI:SS');*/
	fec_in1	:=get_campo('FECHA_IN_TX',xml2);
	fec_out1:=get_campo('FECHA_OUT_TX',xml2);
	
	timeout1:= AVG(fec_out1::time - fec_in1::time);
	seg1:=split_part(timeout1,':',3);
	--raise notice 'JCC_TIMEOUT timeout =% - fec_in1 =% - fec_out1 =% - segundos =%',timeout1,fec_in1,fec_out1,seg1; 
	xml2:=logapp(xml2,'Timeout='||timeout1::varchar);

	--Extrae solamente los segundos
	--timeout1:= EXTRACT(SECOND FROM TIME 'fec_out1' - 'fec_in1');
	--timeout1:= EXTRACT(SECOND FROM TIME 'timeout1');
	--raise notice 'JCC_TIMEOUT_SEG =%',timeout1; 
	
	xml2:=put_campo(xml2,'TIMEOUT_SEG',seg1);

	-- Error por Timeout.
        if (strpos(get_campo('__STS_ERROR_SOCKET__',xml2),'SOCKET_NO_RESPONSE')>0 or     --SOCKET_NO_RESPONSE_BD         --TIMEOUT
           --FONASA viene desde un WebService
           get_campo('ESTADO_WS',xml2)='-1') then

		xml2:=logapp(xml2,'500 Error Conexion Financiador ');
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Error Conexion Financiador ');
                xml2:=put_campo(xml2,'ERRORCOD','500');
                --xml2:=put_campo(xml2,'ERRORMSG','Financiador TimeOut');

		--Si el Tiempo (FIN - INICIO) > 16. Es un Error de TIMEOUT.
		if (seg1) > '15' then
			xml2:=put_campo(xml2,'ERRORMSG','Error de Timeout con Financiador');
			xml2:=put_campo(xml2,'MENSAJE_RESP','Financiador_TimeOut');
			xml2:=logapp(xml2,'Error de Timeout con Financiador');
		else
                	xml2:=put_campo(xml2,'ERRORMSG','Error de Comunicacion con Financiador');
			xml2:=put_campo(xml2,'MENSAJE_RESP','Financiador_Offline');	
			xml2:=logapp(xml2,'Error de Comunicacion con Financiador');
		end if;

		--Registro la falla de conexion
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'ESTADO_TX','FALLA_API');

                --Busca el xml de error
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http(xml2);

                --Guardo este error, para shell control servicios
                xml2:=b3_update_tx(xml2);

                --xml2:=put_campo(xml2,'ERROR_LOG','Falla:TimeOut_Financiador = '||tipo_tx1);
		--xml2:=logapp(xml2,'Falla:TimeOut_Financiador = '||tipo_tx1::varchar);
                return xml2;
        end if;


	-- En caso de Error. Todas las API de Isapres deben retornar campos: API_CODRESPUESTA - API_ERROR - API_DESCRIPCION_ERROR
	if (get_campo('API_CODRESPUESTA',xml2) = '2') then
                		
		xml2:=put_campo(xml2,'STATUS_HTTP','500 Error Service');
		--Responde el Error del Financiador
		xml2:=put_campo(xml2,'ERRORCOD',get_campo('API_ERROR',xml2));
                xml2:=put_campo(xml2,'ERRORMSG',get_campo('API_DESCRIPCION_ERROR',xml2));
		xml2:=logapp(xml2,'Error: '||get_campo('API_DESCRIPCION_ERROR',xml2));
                
                --Registro la falla de conexion
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'ESTADO_TX','FALLA_API');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error_Service');
		--xml2:=put_campo(xml2,'MENSAJE_RESP',get_campo('API_DESCRIPCION_ERROR',xml2));

                --Busca el xml de error
		xml2:=logapp(xml2,'JCC_API_ERROR='||get_campo('API_ERROR',xml2)||'** API_CODRESPUESTA='||get_campo('API_CODRESPUESTA',xml2));
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http(xml2);

                --Guardo este error, para shell control servicios
                xml2:=b3_update_tx(xml2);

                --xml2:=put_campo(xml2,'ERROR_LOG','Falla:Conexion_API = '||tipo_tx1);
		xml2:=logapp(xml2,'Falla:Conexion_API = '||tipo_tx1);
                return xml2;
        end if;

	--Si no contesta porque esta caida el API...
	if (strpos(get_campo('__STS_ERROR_SOCKET__',xml2),'FALLA_CONEXION')>0) then
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Error Service');
                --Responde el Error del Financiador
                xml2:=put_campo(xml2,'ERRORCOD','2');
                xml2:=put_campo(xml2,'ERRORMSG','Reintente por Favor');

                --Registro la falla de conexion
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'ESTADO_TX','FALLA_CONEXION_API');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Falla Conexion con el API');

                --Busca el xml de error
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http(xml2);

                --Guardo este error, para shell control servicios
                xml2:=b3_update_tx(xml2);

                xml2:=logapp(xml2,'Falla:Conexion con el Api Tx='||tipo_tx1);
                return xml2;
        end if;


	--Si API_CODRESPUESTA=1
	--Genera Respuesta SOAP OK.
	xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));
	--Proceso la respuesta con los datos en el XML
	xml2:=respuesta_xml(xml2);
	xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
        xml2:=logapp(xml2,'Respuesta OK 200');
	xml2:=responde_http(xml2);

	--Si todo fue OK. Updateo el registro
       	xml2:=b3_update_tx(xml2);

	return xml2;
end;
$$
LANGUAGE plpgsql;
