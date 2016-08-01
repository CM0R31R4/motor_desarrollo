delete from isys_querys_tx where llave='3005';

insert into isys_querys_tx values ('3005',10,1,1,'SELECT proc_parser_traductor_ws_3005_old(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

insert into isys_querys_tx values ('3005',30,1,1,'SELECT proc_parser_respuesta_ws_3005_old(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--MASVIDA (Con GET_MULTIPLE)
--insert into isys_querys_tx values ('3005',88,88,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);	--GET_MULTIPLE
--insert into isys_querys_tx values ('3005',88,88,1,'$$SQLINPUT$$',0,0,0,1,1,30,30);	--GET_RECORD

--CME (Call SP)
insert into isys_querys_tx values ('3005',500,1,8,'Flujo CME Contenidas',3006,0,0,1,1,30,30);

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_parser_traductor_ws_3005_old(varchar)
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
	
begin
	xml2:=xml1;
        xml2:=xml1;
        xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        --xml2  :=put_campo(xml2,'ESTADO_TX','');
        xml2    :=put_campo(xml2,'CODIGO_RESP','');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_TX',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));

        input1  :=get_campo('INPUT',xml2);

        --Validamos si el XML entrante es un documento xml valido
        xml2    :=valida_documento_xml(xml2);
        if length(get_campo('__XML_STD__',xml2))=0 then
                xml2:=put_campo(xml2,'STATUS_HTTP','400 Xml Invalido');
                xml2:=put_campo(xml2,'ERRORCOD','400');
                xml2:=put_campo(xml2,'ERRORMSG','Xml Invalido');

                --Busca el xml de error
                select * into stData from bono3.respuestas_soap where tipo_tx=tipo_tx1;
                if not found then
                        xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Tx1');
                        --xml2:=responde_http(xml2);
                        --return xml2;
                end if;
                --En caso de error, igual respondo un con un XML
                xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);

                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http(xml2);

                return xml2;
        end if;

        --Busca el tipo_tx en el XML Input. tag1:='<ws:' o tag1:='<ns1:'
        xml2    :=busca_tx_data_xml(xml2);

        tipo_tx1:=get_campo('TX_WS',xml2);
        cod_motor1:=nextval('correlativo_motor')::varchar;
        xml2:=put_campo(xml2,'CODIGO_MOTOR',cod_motor1);

        --Parsea los datos del XML entrante, recibe un xml como parametro tag_busqueda='<ws:datosprest>'
        xml2:=parser_xml(xml2,get_campo('TAG_BUSQUEDA',xml2));
        --xml2:=parser_xml2(xml2,get_campo('TAG_BUSQUEDA',xml2));

        --Input Financiador CtaMed()
        if is_number(get_campo('CTACODFINANCIADOR',xml2)) then
                id_fin1 :=get_campo('CTACODFINANCIADOR',xml2)::integer;

        --Input Financiador CtaMed (Protocolo Operatorio)
        elsif is_number(get_campo('PROCODFINANCIADOR',xml2)) then
                id_fin1 :=get_campo('PROCODFINANCIADOR',xml2)::integer;

        --Input Financiador CtasMed (Anamnesis)
        elsif is_number(get_campo('ANAMCODFINANCIADOR',xml2)) then
                id_fin1 :=get_campo('ANAMCODFINANCIADOR',xml2)::integer;

        --Input Financiador CtaMed (Epicrisis)
        elsif is_number(get_campo('EPICODFINANCIADOR',xml2)) then
                id_fin1 :=get_campo('EPICODFINANCIADOR',xml2)::integer;

        else
                xml2:=put_campo(xml2,'STATUS_HTTP','400 Financiador No Encontrado');
                xml2:=put_campo(xml2,'ERRORCOD','400');
                xml2:=put_campo(xml2,'ERRORMSG','Financiador No Encontrado');

                --Busca el xml de error
                select * into stData from bono3.respuestas_soap where tipo_tx=tipo_tx1;
                if not found then
                        xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Tx');
                        --xml2:=responde_http(xml2);
                        --return xml2;
                end if;
                --En caso de error, igual respondo un con un XML
                xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);

                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http(xml2);

                return xml2;
        end if;

        --Para guardar el Id del Financiador en la Base
        xml2:=put_campo(xml2,'ID_FIN',id_fin1::varchar);

        --Si viene el idxTx. Usa ese valor como codigo de la ctamedica
        if (length(get_campo('IDXTX',xml2))::integer > 0) then
                xml2:=put_campo(xml2,'COD_CME',get_campo('IDXTX',xml2));
        else
                xml2:=put_campo(xml2,'COD_CME','0'::varchar);
        end if;

        --Obtengo el secuenciaOK y la funcion Input del financiador. Por tipo de trx.
        select * into stSec from bono3.define_secuencia_ws where tipo_tx=tipo_tx1 and financiador = id_fin1;
        if not found then
                xml2:=put_campo(xml2,'ERROR_LOG','No existe transaccion = '||tipo_tx1||' financiador = '||id_fin1::varchar);
                xml2:=put_campo(xml2,'STATUS_HTTP','400 Peticion Incorrecta');
                xml2:=put_campo(xml2,'ERRORCOD','400');
                xml2:=put_campo(xml2,'ERRORMSG','Servicio No Habilitado');

                --Busca el xml de error
                select * into stData from bono3.respuestas_soap where tipo_tx=tipo_tx1;
                if not found then
                        xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Tx');
                end if;
                --En caso de error, igual respondo un con un XML
                xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);

                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http(xml2);

                return xml2;
        end if;

        --Tengo la Funcion Respuesta
        --xml2:=put_campo(xml2,'FUNCION_OUTPUT',stSec.funcion_output);
        xml2:=put_campo(xml2,'FINANCIADOR',stSec.descripcion);

        --EJECUTA FUNCION INPUT
        --raise notice 'JCC_3005_INPUT_EXEC=%',stSec.funcion_input;
        if length(stSec.funcion_input)>0 then
                --xml2 := put_campo(xml2,'__FUNCION__',get_campo('__FUNCION__',xml2) || '-' || stSec.funcion_input);
                EXECUTE 'SELECT ' || stSec.funcion_input || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
        end if;

        --Si es CTAMED, setea la secuencia en la funcion fintx_ctamed
        if (stSec.tipo_tx<>'fintx') then
                --Llama a la Api, segun Secuencia definida en bono3.define_secuencia_ws
                xml2:=put_campo(xml2,'__SECUENCIAOK__',stSec.secuencia::varchar);
        end if;

        --Guarda el registro en la tabla tx_ctacte
        xml2:=ctamed_registra_tx(xml2);

        --Como ejecuta Contencion, con TRX = fintx se procesan las CME.
        --No levante funcion de respuesta.
        --xml2:=put_campo(xml2,'FUNCION_OUTPUT','');
        xml2:=put_campo(xml2,'__XML_STD__','LIMPIADO_3005_IN');
	

	return xml2;	
end;
$$
LANGUAGE plpgsql;

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_parser_respuesta_ws_3005_old(varchar)

returns varchar as
$$
declare
        xml1    	alias for $1;
	stData		bono3.respuestas_soap%ROWTYPE;
        xml2   		varchar;
	tipo_tx1	varchar;
	func_out1	varchar;
        id_fin1 	integer;

begin
	xml2:=xml1;
	xml2	:=put_campo(xml2,'__SECUENCIAOK__','0');
	xml2	:=put_campo(xml2,'SQLINPUT','');
	xml2	:=put_campo(xml2,'RQT_XML','CLEAR');
	--xml2	:=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
	--xml2	:=put_campo(xml2,'CODIGO_RESP','');
	--xml2	:=put_campo(xml2,'MENSAJE_RESP','');
	xml2	:=put_campo(xml2,'FECHA_OUT_TX',to_char(clock_timestamp(),'YYYY-MM-DD HH24:MI:SS'));
	
	tipo_tx1:=get_campo('TX_WS',xml2); --Bencertif
        id_fin1:=get_campo('ID_FIN',xml2)::integer;
	
	--func_out1:=get_campo('FUNCION_OUTPUT',xml2);
	--raise notice 'JCC_3005_OUT_EXEC=%',func_out1;
	
	--Antes de ejecutar la funcion_out, 
	--Si fue al Financiador, ejecutar funcion parser de respuesta 
	--Ej:traductor_out_solicfolios_isapre.
       	if length(func_out1)>0 then
       		--xml2 := put_campo(xml2,'__FUNCION__',get_campo('__FUNCION__',xml2) || '-' || func_out1);
               	EXECUTE 'SELECT ' || func_out1 || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
		--raise notice 'JCC_3005_RESP_1 Mens=% - Cod_Resp=%',get_campo('MENSAJE_RESP',xml2),get_campo('CODIGO_RESP',xml2);
		xml2:=logapp(xml2,'F(3005)-Resp: '||func_out1||'  Cod_Resp= '||get_campo('CODIGO_RESP',xml2)||'  Msje_Resp= '||get_campo('MENSAJE_RESP',xml2));
       	end if;

	-- TIMEOUT
        if (strpos(get_campo('__STS_ERROR_SOCKET__',xml2),'SOCKET_NO_RESPONSE')>0) then  --SOCKET_NO_RESPONSE_BD  

                xml2:=put_campo(xml2,'STATUS_HTTP','500 Financiador TimeOut');
                xml2:=put_campo(xml2,'ERRORCOD','500');
                --xml2:=put_campo(xml2,'ERRORMSG','Financiador TimeOut');
                xml2:=put_campo(xml2,'ERRORMSG','Financiador TimeOut');
                --Registro la falla de conexion
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'ESTADO_TX','FALLA_API');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Financiador_TimeOut');

                --Busca el xml de error
                select * into stData from bono3.respuestas_soap where tipo_tx=tipo_tx1;
                if not found then
                        xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Tx');
                        --xml2:=responde_http(xml2);
                        --return xml2;
                end if;
                xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);
                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http(xml2);

                --Guardo este error, para shell control servicios
                xml2:=ctamed_update_tx(xml2);

                xml2:=put_campo(xml2,'ERROR_LOG','Falla:TimeOut_Financiador = '||tipo_tx1);
                return xml2;
        end if;


	-- En caso de Error. Todas las Isapres deben tener API_CODRESPUESTA
	if (get_campo('API_CODRESPUESTA',xml2) = '2') then
	        --if strpos(get_campo('__STS_ERROR_SOCKET__',xml2),'FALLA_CONEXION')>0 then 
           	--strpos(get_campo('__STS_ERROR_SOCKET__',xml2),'FALLA_CONEXION_BD')>0 or	--FALLA_CONEXION_BD 
        	
		xml2:=put_campo(xml2,'STATUS_HTTP','500 Error Motor');
                xml2:=put_campo(xml2,'ERRORCOD','500');
                xml2:=put_campo(xml2,'ERRORMSG','Falla Conectividad Financiador');
                --Registro la falla de conexion
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'ESTADO_TX','FALLA_API');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error_Motor');

                --Busca el xml de error
                select * into stData from bono3.respuestas_soap where tipo_tx=tipo_tx1;
                if not found then
                        xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Tx');
                end if;
                xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);
                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http(xml2);

                --Guardo este error, para shell control servicios
                xml2:=ctamed_update_tx(xml2);

                xml2:=put_campo(xml2,'ERROR_LOG','Falla:Conexion_API = '||tipo_tx1);
                return xml2;
        end if;

	--Si falla la ejecucion del SP Remoto.
	if get_campo('__STS_ERROR_PXML__',xml2)<>'OK' 		or
	   get_campo('ERRORCOD',xml2)='99' 			or	--Oracle
	   get_campo('STATUS',xml2)='FALLA' 			then	--Msql/Sybase  ..Viene del /fuentes/BaseDatosMSSQL
	   --get_campo('CODRESPUESTA',xml2)='2' 			then	--Msql/Sybase  ..Viene del /fuentes/BaseDatosMSSQL

		--En caso de Error. Pega el mismo ErrorMsg del Financiador en el Xml Response. 
		--Si es Sybase/MySql
		if get_campo('ERRORCOD',xml2)<>'99' then
                	xml2:=put_campo(xml2,'ERRORMSG',get_campo('ERROR',xml2)); --Msql/Sybase(Viene del /fuentes/BaseDatosMSSQL)
		end if;
		
		--Cambiar este mensaje
		xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Ejecucion');
                xml2:=put_campo(xml2,'ERRORCOD','500');
		
		--Registro la falla de conexion
		xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'ESTADO_TX','FALLA_SP');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Falla_Ejecucion');

		--Busca el xml de error
                select * into stData from bono3.respuestas_soap where tipo_tx=tipo_tx1;
                if not found then
                        xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Tx');
                end if;
                xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);
                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
		xml2:=responde_http(xml2);

		--Guardo este error, para shell control servicios
                xml2:=ctamed_update_tx(xml2);
		
		xml2:=put_campo(xml2,'ERROR_LOG','Falla:Execute_SPCall = '||tipo_tx1);
		return xml2;	
	end if;

	--Si no hay un Xml Respuesta en la tabla respuestas_soap, de tipo_tx
	select * into stData from bono3.respuestas_soap where tipo_tx=tipo_tx1;
	if not found then
		xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Tx');
		xml2:=put_campo(xml2,'ERRORCOD','500');
                xml2:=put_campo(xml2,'ERRORMSG','Falla Servicio Respuesta');
                
		--Registro la falla de conexion
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'ESTADO_TX','RECHAZADO');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Falla_SOAP');
		
		xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);
                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http(xml2);

                --Guardo este error, para shell control servicios
                xml2:=ctamed_update_tx(xml2);

                xml2:=put_campo(xml2,'ERROR_LOG','Falla:Respuesta_SOAP = '||tipo_tx1);
                return xml2;
	end if;

	--Si API_CODRESPUESTA=1
	--Genera Respuesta SOAP OK.
	xml2:=put_campo(xml2,'RESPUESTA',stData.respuesta);
	
	--Proceso la respuesta con los datos en el XML
	xml2:=respuesta_xml(xml2);
	xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
	xml2:=responde_http(xml2);

	--Si todo fue OK. Updateo el registro
	if (tipo_tx1 = 'iniciotx') or (tipo_tx1 = 'fintx') or (tipo_tx1 = 'anulatx') then
		--and financiador = 'CTAMED') then
		xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        	xml2:=put_campo(xml2,'CODIGO_RESP','1');
        	xml2:=put_campo(xml2,'MENSAJE_RESP','Trx_Signal_OK');
		--Para el Update de la CME
		xml2:=put_campo(xml2,'ERR','N');
	end if;
	--Guarda el registro
        xml2:=ctamed_update_tx(xml2);
	xml2:=logapp(xml2,'F(3005)-Outp: Tipo_Tx= '||tipo_tx1||' * *  CodMotor= '||get_campo('CODIGO_MOTOR',xml2)||' * * CodCme= '||get_campo('COD_CME',xml2));
	xml2:=logapp(xml2,'F(3005)-Outp: Cod_Resp= '||get_campo('CODIGO_RESP',xml2)||' * * Msje_Resp= '||get_campo('MENSAJE_RESP',xml2));

	return xml2;
end;
$$
LANGUAGE plpgsql;

