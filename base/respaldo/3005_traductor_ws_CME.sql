delete from isys_querys_tx where llave='3005';

insert into isys_querys_tx values ('3005',10,1,1,'SELECT proc_parser_traductor_ws_3005(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Script de llamada directa
insert into isys_querys_tx values ('3005',30,1,10,'$$SCRIPT$$',0,0,0,1,1,550,550);

--MASVIDA (Con GET_MULTIPLE)
--insert into isys_querys_tx values ('3005',88,188,1,'$$SQLINPUT$$',0,0,0,6,1,500,500); --GET_MULTIPLE

--Por 10.100.32.52
insert into isys_querys_tx values ('3005',88,190,1,'$$SQLINPUT$$',0,0,0,6,1,500,500);   --GET_MULTIPLE

--Segunda Api MasVida Cme
insert into isys_querys_tx values ('3005',89,189,1,'$$SQLINPUT$$',0,0,0,6,1,550,550);   --GET_MULTIPLE
--insert into isys_querys_tx values ('3005',88,188,1,'$$SQLINPUT$$',0,0,0,6,1,500,500); --GET_MULTIPLE
--insert into isys_querys_tx values ('3005',88,188,1,'$$SQLINPUT$$',0,0,0,1,1,30,30);   --GET_RECORD

--Reserved Futuro Financiador
--insert into isys_querys_tx values ('3005',71,188,1,'$$SQLINPUT$$',0,0,0,6,1,500,500); --Consalud con GET_MULTIPLE
--insert into isys_querys_tx values ('3005',99,188,1,'$$SQLINPUT$$',0,0,0,6,1,500,500); --Banmedica con GET_MULTIPLE

insert into isys_querys_tx values ('3005',500,1,1,'SELECT proc_parser_respuesta_ws_3005(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Reenvia Cme por 2da Api. Llamda al 89
insert into isys_querys_tx values ('3005',550,1,1,'SELECT proc_parser_respuesta_ws_3005_2(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Reenvia Cme por 2da Api. Llamda al 89
insert into isys_querys_tx values ('3005',600,1,1,'SELECT ejecuta_conciliacion_cme_3005(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--CME (Call SP)
--insert into isys_querys_tx values ('3005',500,1,8,'Flujo CME Contenidas',3006,0,0,1,1,30,30);

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_parser_traductor_ws_3005(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        stCme           tx_ctamed%ROWTYPE;
        stSec           define_secuencia_ws%ROWTYPE;
        stData          respuestas_soap%ROWTYPE;
        tipo_tx1        varchar;
        input1          varchar;
        cod_motor1      varchar;
        id_fin1         integer;
        xml_error1      varchar;
        query1          varchar;
        puerto1         varchar;
        salida1         varchar;
        i               integer;
        data1           varchar;
        tag1            varchar;

begin
        xml2:=xml1;
        xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        --xml2  :=put_campo(xml2,'ESTADO_TX','');
        xml2    :=put_campo(xml2,'CODIGO_RESP','');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_TX',clock_timestamp()::varchar);

        --Preguntamos si viene el wsdl
        if (get_campo('REQUEST_METHOD',xml2)='GET' and
            (strpos(get_campo('REQUEST_URI',xml2),'wsdl')>0 or strpos(get_campo('REQUEST_URI',xml2),'xsd')>0)) then
                xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
                return proc_wsdl_3002(xml2);
        end if;

        --Decode del INPUT
        xml2:=put_campo(xml2,'INPUT',decode(get_campo('INPUT',xml2),'hex')::varchar);
        input1  :=get_campo('INPUT',xml2);

        --Validamos si el XML entrante es un documento xml valido
        xml2    :=valida_documento_xml(xml2);
        if length(get_campo('__XML_STD__',xml2))=0 then
                xml2:=put_campo(xml2,'STATUS_HTTP','400 Xml Invalido');
                xml2:=put_campo(xml2,'ERRORCOD','400');
                xml2:=put_campo(xml2,'ERRORMSG','Xml Invalido');
                xml2:=logapp(xml2,'400 Xml Invalido, no hay respuesta');
                return xml2;
        end if;

        --Busca el tipo_tx en el XML Input. tag1:='<ws:' o tag1:='<ns1:'
        xml2:=busca_tx_data_xml(xml2);

        tipo_tx1:=get_campo('TX_WS',xml2);

        cod_motor1:=nextval('correlativo_motor')::varchar;

        xml2:=put_campo(xml2,'CODIGO_MOTOR',cod_motor1);


        --Lee Datos de la respuesta
        select * into stData from respuestas_soap where tipo_tx=tipo_tx1;
        if not found then
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Tx1');
                xml2:=logapp(xml2,'No existe respuesta_soap, 500 Falla Tx='||tipo_tx1::varchar);
                --En caso de error, igual respondo un con un XML
                xml2:=put_campo(xml2,'RESPUESTA',stData.xml_error);
                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);
                return xml2;
        end if;
        --Saca formatos de respuestas genericas
        xml2:=put_campo(xml2,'XML_ERROR',stData.xml_error);
        xml2:=put_campo(xml2,'XML_OK',stData.respuesta);

        --Parsea los datos del XML entrante, recibe un xml como parametro tag_busqueda='<ws:datosprest>'
        xml2:=parser_xml(xml2,get_campo('TAG_BUSQUEDA',xml2));

        --Input Financiador CtaMed()
        if is_number(get_campo('CTACODFINANCIADOR',xml2)) then
                id_fin1 :=get_campo('CTACODFINANCIADOR',xml2)::integer;
                --JCC: Parche Temporal
                if (get_campo('CTATIPENVIO',xml2)='0') then
                        xml2:=put_campo(xml2,'CTATIPENVIO','1');
                end if;

        --Input Financiador CtaMed (Protocolo Operatorio)
        elsif is_number(get_campo('PROCODFINANCIADOR',xml2)) then
                id_fin1 :=get_campo('PROCODFINANCIADOR',xml2)::integer;
                --JCC: Parche Temporal
                if (get_campo('PROTIPENVIO',xml2)='0') then
                        xml2:=put_campo(xml2,'PROTIPENVIO','1');
                end if;

        --Input Financiador CtasMed (Anamnesis)
        elsif is_number(get_campo('ANAMCODFINANCIADOR',xml2)) then
                id_fin1 :=get_campo('ANAMCODFINANCIADOR',xml2)::integer;
                --JCC: Parche Temporal
                if (get_campo('ANAMTIPENVIO',xml2)='0') then
                        xml2:=put_campo(xml2,'ANAMTIPENVIO','1');
                end if;

        --Input Financiador CtaMed (Epicrisis)
        elsif is_number(get_campo('EPICODFINANCIADOR',xml2)) then
                id_fin1 :=get_campo('EPICODFINANCIADOR',xml2)::integer;
                --JCC: Parche Temporal
                if (get_campo('EPITIPENVIO',xml2)='0') then
                        xml2:=put_campo(xml2,'EPITIPENVIO','1');
                end if;

        else
                xml2:=put_campo(xml2,'STATUS_HTTP','400 Financiador No Encontrado');
                xml2:=put_campo(xml2,'ERRORCOD','400');
                xml2:=put_campo(xml2,'ERRORMSG','Financiador No Encontrado');
                xml2:=logapp(xml2,'Financiador No Encontrado');

                --En caso de error, igual respondo un con un XML
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));

                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);

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
        select * into stSec from define_secuencia_ws where tipo_tx=tipo_tx1 and financiador = id_fin1;
        if not found then
                xml2:=put_campo(xml2,'ERROR_LOG','No existe transaccion = '||tipo_tx1||' financiador = '||id_fin1::varchar);
                xml2:=put_campo(xml2,'STATUS_HTTP','400 Peticion Incorrecta');
                xml2:=put_campo(xml2,'ERRORCOD','400');
                xml2:=put_campo(xml2,'ERRORMSG','Servicio '||tipo_tx1||'No Habilitado');
                xml2:=logapp(xml2,'No existe transaccion = '||tipo_tx1||' financiador = '||id_fin1::varchar);

                --Proceso la respuesta con los datos en el XML
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);

                return xml2;
        end if;


        --Metodo inicioTx y fintx, no tienen funcion_output en tabla define_secuencia_ws.
        --if (tipo_tx1='iniciotx') or (tipo_tx1='fintx') then
        if (tipo_tx1='iniciotx') then
                xml2:=put_campo(xml2,'FUNCION_OUTPUT','');
        else
                --Cualquier otro metodo, procesa funcion_output en respuesta de este flujo
                xml2:=put_campo(xml2,'FUNCION_OUTPUT',stSec.funcion_output);
        end if;
        --xml2:=put_campo(xml2,'FINANCIADOR',stSec.descripcion);

        --Ejecuta Funcion Input
        xml2:=logapp(xml2,'Ejecuta='||stSec.funcion_input);
        if length(stSec.funcion_input)>0 then
                EXECUTE 'SELECT ' || stSec.funcion_input || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
                --xml2:=logapp(xml2,'secuenciaOK='||stSec.secuencia);
        end if;

       --Arreglamos el SQLINPUT
        --SELECT @AnamCodError as AnamCodError, @AnamMensajeError as AnamMensajeError
        salida1:=split_part(get_campo('SQLINPUT',xml2),'SELECT',1);
        salida1:=salida1||' SELECT ';
        data1:=split_part(upper(get_campo('SQLINPUT',xml2)),'SELECT',2);
        i:=2;
        while (length(split_part(data1,'@',i))>0) loop
                tag1:=split_part(split_part(data1,'@',i),' ',1);
                salida1:=salida1||quote_literal('<'||tag1||'>')||'+@'||tag1||'+'||quote_literal('</'||tag1||'>')||'+';
                i:=i+1;
        end loop;
        salida1:=substring(salida1,1,length(salida1)-1);
        xml2:=logapp(xml2,'DATA-SCRIPT='||salida1);
        --Cambio el SQLINPUT
        xml2:=put_campo(xml2,'SCRIPT','/home/motor/CME_MASVIDA/cme_masvida.sh '||encode(salida1::bytea,'hex')::varchar);
        xml2:=put_campo(xml2,'__SECUENCIAOK__','30');

        --Determina cuantas veces se llama a una api.
        --Utiliza cuando se cae en ejecucion o falla la conexion del primer Api. __STS_ERROR_SOCKET__=FALLA_CONEXION
        --xml2:=put_campo(xml2,'LOOP_API','1');

        --Llama al Api, segun Secuencia definida en define_secuencia_ws
        --xml2:=put_campo(xml2,'__SECUENCIAOK__',stSec.secuencia::varchar);

        --Guarda el registro en la tabla tx_ctacte
        xml2:=ctamed_registra_tx(xml2);
        xml2:=put_campo(xml2,'__XML_STD__','LIMPIADO_3005_IN');

        return xml2;
end;
$$
LANGUAGE plpgsql;

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_parser_respuesta_ws_3005(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        stData          respuestas_soap%ROWTYPE;
        xml2            varchar;
        tipo_tx1        varchar;
        func_out1       varchar;
        id_fin1         integer;
        fec_in1         varchar;
        fec_out1        varchar;
        timeout1        varchar;
        seg1            varchar;
begin
        xml2:=xml1;
        xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        --xml2  :=put_campo(xml2,'SQLINPUT','');
        --xml2  :=put_campo(xml2,'RQT_XML','CLEAR');
        --xml2  :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        --xml2  :=put_campo(xml2,'CODIGO_RESP','');
        --xml2  :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_OUT_TX',clock_timestamp()::varchar);

        tipo_tx1:=get_campo('TX_WS',xml2);
        id_fin1:=get_campo('ID_FIN',xml2)::integer;

        func_out1:=get_campo('FUNCION_OUTPUT',xml2);
        xml2:=logapp(xml2,'F3005 Ejecuta_Funcion_Out_CME ='||func_out1);
        if length(func_out1)>0 then
                --xml2 := put_campo(xml2,'__FUNCION__',get_campo('__FUNCION__',xml2) || '-' || func_out1);
                EXECUTE 'SELECT ' || func_out1 || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
        end if;
        xml2:=logapp(xml2,'F3005 Resp_FunOut="'||get_campo('MENSAJE_RESP',xml2)||'" Codigo='||get_campo('CODIGO_RESP',xml2));

        --Con este Tag envia el SpConcilacionCme por 2da Api. Mientras la 1ra se reinicia
        /*if (get_campo('LOOP_API',xml2)='SI') then
                xml2:=logapp(xml2,'F3005_EnviaCme_Api2');
                xml2:=put_campo(xml2,'__SECUENCIAOK__','89');
                return xml2;
        end if;*/

        --Saco el timeout de la trx en ejecutada
        fec_in1 :=get_campo('FECHA_IN_TX',xml2);
        fec_out1:=get_campo('FECHA_OUT_TX',xml2);
        timeout1:= AVG(fec_out1::time - fec_in1::time);
        seg1:=split_part(timeout1,':',3);
        xml2:=put_campo(xml2,'TIMEOUT_SEG',seg1);
        xml2:=logapp(xml2,'F3005_Timeout='||timeout1::varchar);

        -- Error Por Timeout
        if (strpos(get_campo('__STS_ERROR_SOCKET__',xml2),'SOCKET_NO_RESPONSE')>0) then  --SOCKET_NO_RESPONSE_BD
                xml2:=logapp(xml2,'500 Error Conexion Financiador ');
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Error Conexion Financiador ');
                xml2:=put_campo(xml2,'ERR','S');

                --Si el Tiempo (FIN - INICIO) > 16. Es un Error de TIMEOUT.
                if (seg1) > '15' then
                        xml2:=put_campo(xml2,'GLOSA','Error de Timeout con Financiador');
                        xml2:=put_campo(xml2,'MENSAJE_RESP','Financiador_TimeOut');
                        xml2:=logapp(xml2,'Error de Timeout con Financiador');
                else
                        xml2:=put_campo(xml2,'GLOSA','Error de Comunicacion con Financiador');
                        xml2:=put_campo(xml2,'MENSAJE_RESP','Financiador_Offline');
                        xml2:=logapp(xml2,'Error de Comunicacion con Financiador');
                end if;

                --Registro la falla de conexion
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'ESTADO_TX','FALLA_API');

                --Busca el xml de error
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);

                --Guardo este error, para shell control servicios
                xml2:=b3_update_tx(xml2);

                xml2:=logapp(xml2,'Falla:Api_codrespuesta = '||tipo_tx1);
                return xml2;
        end if;


        -- En caso de Error. Todas las Isapres deben tener API_CODRESPUESTA
        if (get_campo('API_CODRESPUESTA',xml2) = '2') then
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Error Service');
                --Responde el Error del Financiador
                xml2:=put_campo(xml2,'ERR',get_campo('API_ERROR',xml2));
                xml2:=put_campo(xml2,'GLOSA',get_campo('API_DESCRIPCION_ERROR',xml2));
                xml2:=logapp(xml2,'Error: '||get_campo('API_DESCRIPCION_ERROR',xml2));

                --Registro la falla de conexion
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'ESTADO_TX','ERROR_API');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error_Service');
                --xml2:=put_campo(xml2,'MENSAJE_RESP',get_campo('API_DESCRIPCION_ERROR',xml2));

                --Busca el xml de error
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);

                --Guardo este error, para shell control servicios
                xml2:=b3_update_tx(xml2);

                xml2:=logapp(xml2,'Falla:Api_codrespuesta = '||tipo_tx1);
                return xml2;
        end if;

        --Si no contesta porque esta caida el API...
        if (strpos(get_campo('__STS_ERROR_SOCKET__',xml2),'FALLA_CONEXION')>0) then
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Error Service');
                --Responde el Error del Financiador
                xml2:=put_campo(xml2,'ERR','2');
                xml2:=put_campo(xml2,'GLOSA','Reintente por Favor');

                --Registro la falla DEDIGO_RESP','2');
                xml2    :=put_campo(xml2,'ESTADO_TX','DOWN_API');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Falla Conexion con el API');

                --Busca el xml de error
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);

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
        xml2:=responde_http_scgi(xml2);
        --xml2:=logapp(xml2,'Respuesta OK 200 ='||get_campo('RESPUESTA',xml2));

        --Si todo fue OK. Updateo el registro
        if (tipo_tx1 = 'iniciotx') /*or (tipo_tx1 = 'fintx') or (tipo_tx1 = 'anulatx')*/ then
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2:=put_campo(xml2,'CODIGO_RESP','1');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Trx_Signal_OK');
                --Para el Update de la CME
                xml2:=put_campo(xml2,'ERR','N');
        end if;

        --Actualiza registro con la respuesta de Isapre
        xml2:=ctamed_update_tx(xml2);

        xml2:=logapp(xml2,'**FinalCME tipo_tx1='||tipo_tx1||' - Err='||get_campo('ERR',xml2)||' - Glosa='||get_campo('GLOSA',xml2)||' - CodMotor='||get_campo('CODIGO_MOTOR',xml2)||' - CodCme='||get_campo('COD_CME',xml2));

        return xml2;
end;
$$
LANGUAGE plpgsql;

--Parsea respuesta de Api2.
CREATE OR REPLACE FUNCTION proc_parser_respuesta_ws_3005_2(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        stData          respuestas_soap%ROWTYPE;
        xml2            varchar;
        tipo_tx1        varchar;
        func_out1       varchar;
        id_fin1         integer;
        fec_in1         varchar;
        fec_out1        varchar;
        timeout1        varchar;
        seg1            varchar;
begin
        xml2:=xml1;
        xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'SQLINPUT','');
        --xml2  :=put_campo(xml2,'RQT_XML','CLEAR');
        --xml2  :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        --xml2  :=put_campo(xml2,'CODIGO_RESP','');
        --xml2  :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_OUT_TX',clock_timestamp()::varchar);

        tipo_tx1:=get_campo('TX_WS',xml2);
        id_fin1:=get_campo('ID_FIN',xml2)::integer;

        --Saco 2 valores de la respuesta
        xml2:=logapp(xml2,'Respuesta System='||get_campo('RESPUESTA_SYSTEM',xml2));
        xml2:=put_campo(xml2,'CTACODERROR_1',get_xml('CTACODERROR',get_campo('RESPUESTA_SYSTEM',xml2)));
        xml2:=put_campo(xml2,'CTAMENSAJEERROR_1',get_xml('CTAMENSAJEERROR',get_campo('RESPUESTA_SYSTEM',xml2)));
        xml2:=logapp(xml2,'CodError='||get_campo('CTACODERROR_1',xml2)||'--'||'CtaMensajeError='||get_campo('CTAMENSAJEERROR_1',xml2));

        func_out1:=get_campo('FUNCION_OUTPUT',xml2);
        xml2:=logapp(xml2,'F3005 Ejecuta_Funcion_Out_CME ='||func_out1);
        if length(func_out1)>0 then
                --xml2 := put_campo(xml2,'__FUNCION__',get_campo('__FUNCION__',xml2) || '-' || func_out1);
                EXECUTE 'SELECT ' || func_out1 || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
        end if;
        xml2:=logapp(xml2,'F3005 Resp_FunOut="'||get_campo('MENSAJE_RESP',xml2)||'" Codigo='||get_campo('CODIGO_RESP',xml2));

        --Saco el timeout de la trx en ejecutada
        fec_in1 :=get_campo('FECHA_IN_TX',xml2);
        fec_out1:=get_campo('FECHA_OUT_TX',xml2);
        timeout1:= AVG(fec_out1::time - fec_in1::time);
        seg1:=split_part(timeout1,':',3);
        xml2:=put_campo(xml2,'TIMEOUT_SEG',seg1);
        xml2:=logapp(xml2,'F3005_Timeout='||timeout1::varchar);

        -- Error Por Timeout
        if (strpos(get_campo('__STS_ERROR_SOCKET__',xml2),'SOCKET_NO_RESPONSE')>0) then  --SOCKET_NO_RESPONSE_BD
                xml2:=logapp(xml2,'500 Error Conexion Financiador ');
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Error Conexion Financiador ');
                xml2:=put_campo(xml2,'ERR','S');

                --Si el Tiempo (FIN - INICIO) > 16. Es un Error de TIMEOUT.
                if (seg1) > '15' then
                        xml2:=put_campo(xml2,'GLOSA','Error de Timeout con Financiador');
                        xml2:=put_campo(xml2,'MENSAJE_RESP','Financiador_TimeOut');
                        xml2:=logapp(xml2,'Error de Timeout con Financiador');
                else
                        xml2:=put_campo(xml2,'GLOSA','Error de Comunicacion con Financiador');
                        xml2:=put_campo(xml2,'MENSAJE_RESP','Financiador_Offline');
                        xml2:=logapp(xml2,'Error de Comunicacion con Financiador');
                end if;

                --Registro la falla de conexion
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'ESTADO_TX','FALLA_API');

                --Busca el xml de error
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);

                --Guardo este error, para shell control servicios
                xml2:=b3_update_tx(xml2);

                xml2:=logapp(xml2,'Falla:Api_codrespuesta = '||tipo_tx1);
                return xml2;
        end if;


        -- En caso de Error. Todas las Isapres deben tener API_CODRESPUESTA
        if (get_campo('API_CODRESPUESTA',xml2) = '2') then
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Error Service');
                --Responde el Error del Financiador
                xml2:=put_campo(xml2,'ERR',get_campo('API_ERROR',xml2));
                xml2:=put_campo(xml2,'GLOSA',get_campo('API_DESCRIPCION_ERROR',xml2));
                xml2:=logapp(xml2,'Error: '||get_campo('API_DESCRIPCION_ERROR',xml2));

                --Registro la falla de conexion
                xml2    :=put_campo(xml2,'CODIGO_RESP','2');
                xml2    :=put_campo(xml2,'ESTADO_TX','ERROR_API');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Error_Service');
                --xml2:=put_campo(xml2,'MENSAJE_RESP',get_campo('API_DESCRIPCION_ERROR',xml2));

                --Busca el xml de error
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);

                --Guardo este error, para shell control servicios
                xml2:=b3_update_tx(xml2);

                xml2:=logapp(xml2,'Falla:Api_codrespuesta = '||tipo_tx1);
                return xml2;
        end if;

        --Si no contesta porque esta caida el API...
        if (strpos(get_campo('__STS_ERROR_SOCKET__',xml2),'FALLA_CONEXION')>0) then
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Error Service');
                --Responde el Error del Financiador
                xml2:=put_campo(xml2,'ERR','2');
                xml2:=put_campo(xml2,'GLOSA','Reintente por Favor');

                --Registro la falla DEDIGO_RESP','2');
                xml2    :=put_campo(xml2,'ESTADO_TX','OFFLINE_API');
                xml2:=put_campo(xml2,'MENSAJE_RESP','Falla Conexion con el API');

                --Busca el xml de error
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);

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
        xml2:=responde_http_scgi(xml2);
        --xml2:=logapp(xml2,'Respuesta OK 200 ='||get_campo('RESPUESTA',xml2));

        --Actualiza registro con la respuesta de Isapre
        xml2:=ctamed_update_tx(xml2);

        xml2:=logapp(xml2,'** FinalCme2 tipo_tx1='||tipo_tx1||' - Err='||get_campo('ERR',xml2)||' - Glosa='||get_campo('GLOSA',xml2)||' - CodMotor='||get_campo('CODIGO_MOTOR',xml2)||' - CodCme='||get_campo('COD_CME',xml2));

        return xml2;
end;
$$
LANGUAGE plpgsql;

/*
CREATE OR REPLACE FUNCTION reenvia_cme_api2_3005(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

begin
        xml2:=xml1;

        --Reintenta envio de la CME el SqlInput
        if length(get_campo('SQLINPUT',xml2)=0) then
                xml2:=logapp(xml2,'Perdimos el SqlInput de Reenvio');
                --SpConciliacion
                xml2:=put_campo(xml2,'__SECUENCIAOK__','600');

                --Error a Sonda
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','Cme Rechaza por Financiador');
                return xml2;

        end if;

        --Envia SqlInput al Api2
        xml2:=logapp(xml2,'Envia SqlInput al Api2');
        xml2:=put_campo(xml2,'__SECUENCIAOK__','89');

        --Cuando va al segundo Api. Cambia el tag para evitar el Loop
        xml2:=put_campo(xml2,'LOOP_API','NO');

        return xml2;
end;
$$
LANGUAGE plpgsql;
*/

CREATE OR REPLACE FUNCTION ejecuta_conciliacion_cme_3005(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;

begin
        xml2:=xml1;

        --Prepara envio del SP de Conciliacion
        xml2:=put_campo(xml2,'CTACONCILIACION','1');
        xml2:=traductor_in_cerconciliacioncme_masvida(xml2);

        --Llamada a 2da Api
        xml2:=put_campo(xml2,'__SECUENCIAOK__','89');
        xml2:=put_campo(xml2,'FUNCION_OUTPUT','traductor_out_cerconciliacioncme_masvida');
        xml2:=logapp(xml2,'SP_CONCILIACIONCME: '||get_campo('TX_WS',xml2));
        return xml2;
end;
$$
LANGUAGE plpgsql;

--drop function fintx_ctamed(varchar);
/*Funcion que ejecutara el SP de Conciliacion en base datos Financiador*/
--drop function fintx_ctamed(varchar);
/*CREATE OR REPLACE FUNCTION fintx_ctamed(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        stCme   tx_ctamed%ROWTYPE;
        id_fin1         integer;
        cod_cme1        integer;
        tot_cme1        integer;

begin
        xml2:=xml1;
        xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

        id_fin1:=get_campo('ID_FIN',xml2)::integer;
        cod_cme1:=get_campo('COD_CME',xml2)::integer;

        --Debe buscar datos de la CME en el campo xml_input
        --Comprobar que esten todas OK.

        --SELECT tipo_tx,cod_fin,get_xml('CtaRutConvenio',xml_input),num_cta,get_xml('CtaNumCobro',xml_input),get_xml('CtaTipEnvio',xml_input) from tx_ctamed where cod_fin=88 and cod_ctamed<>0 and length(xml_input)>0 and tipo_tx in ('cerenvcta','cerencanam','cerencepi','cerencprot') and fecha_in_tx >='2014-10-01'

        SELECT * into stCme from tx_ctamed where cod_fin=id_fin1 and cod_ctamed=cod_cme1 and length(xml_input)>0 and tipo_tx tipo_tx in ('cerenvcta','cerencanam','cerencepi','cerencprot') order by fecha_in_tx desc limit 1;
        if not found then
                --Falla la conciliacion. Informa a Sonda y Financiador.
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','Falla Conciliacion');
                return xml2;
        end if;

        --Lee del xml_input los campos a enviar al SP.
        xml2:=put_campo(xml2,'CTARUTCONVENIO',stCme.get_xml('CtaRutConvenio',xml_input));
        xml2:=put_campo(xml2,'CTANUMCTA',stCme.num_cta);
        xml2:=put_campo(xml2,'CTANUMCOBRO',stCme.get_xml('CtaNumCobro',xml_input));
        xml2:=put_campo(xml2,'CTATIPENVIO',stCme.get_xml('CtaTipEnvio',xml_input));
        xml2:=put_campo(xml2,'CTARUTCONVENIO','0');

        --Va a la Isapre
        xml2:=put_campo(xml2,'__SECUENCIAOK__','0');

        return xml2;
end;
$$
LANGUAGE plpgsql;
*/

/*CREATE OR REPLACE FUNCTION fintx_ctamed1(varchar)
returns varchar as
$$
declare
        xml1    alias for $1;
        xml2    varchar;
        stCme   tx_ctamed%ROWTYPE;
        stSec   define_secuencia_ws%ROWTYPE;
        campo   record;

        id_fin1         varchar;
        cod_cme1        varchar;
        i       integer =1;
        cuenta1 integer =0;

begin
        xml2:=xml1;
        xml2:=put_campo(xml2,'__SECUENCIAOK__','30');
        xml2:=put_campo(xml2,'CTANUMCTA',coalesce(nullif(get_campo('CTANUMCTA',xml2),''),'0'));

        id_fin1:=get_campo('ID_FIN',xml2);
        cod_cme1:=get_campo('COD_CME',xml2);

        --Cuenta el total de CME registadas por cod_cme.
        select count(*) into cuenta1 from tx_ctamed WHERE cod_fin=id_fin1::integer and cod_ctamed=cod_cme1::integer and estado='CONTENIDA' and length(sp_exec)>0;
        --Total registros encontrados
        xml2:=put_campo(xml2,'TOTAL_CME',cuenta1::varchar);
        xml2:=logapp(xml2,'Para trx=finTx('||cod_cme1||'), totalContenidas =%'||cuenta1);

        --Si no hay registros
        if (cuenta1=0) then
                xml2:=put_campo(xml2,'ERR','S');
                xml2:=put_campo(xml2,'GLOSA','CME idxTx='||get_campo('COD_CME',xml2)||'.Sin Registros');
                xml2:=logapp(xml2,'Glosa:CME idxTx='||get_campo('COD_CME',xml2)||'.Sin Registros');
                --Vuelve al 8081 con este error y responde a Sonda
                xml2:=put_campo(xml2,'__SECUENCIAOK__','30');
                return xml2;
        end if;

        --Saco los SP que debo ejecutar. Va de 1en1
        --for campo in SELECT * FROM tx_ctamed WHERE cod_fin=id_fin1::integer and cod_ctamed=cod_cme1::integer and estado='CONTENIDA' and length(sp_exec)>0 order by fecha_in_tx asc limit1;
        SELECT * into stCme from tx_ctamed where cod_fin=id_fin1::integer and cod_ctamed=cod_cme1::integer and estado='CONTENIDA' and length(sp_exec)>0 order by fecha_in_tx asc limit 1;
                --ORDER BY fecha_in_tx ASC LOOP

                xml2:=logapp(xml2,'fintx: Iniciando_EnvioCME tx_cme=% '||stCme.tipo_tx);
                xml2:=put_campo(xml2,'COD_MOTOR_ORIG',stCme.codigo_motor::varchar);
                xml2:=put_campo(xml2,'TX_CME',stCme.tipo_tx);
                xml2:=put_campo(xml2,'SP_REQ',stCme.sp_exec);

                --Ejecuta la funcion parseadora de respuesta por cada servicio enviado a la Isapre
                select * into stSec from define_secuencia_ws where tipo_tx=stCme.tipo_tx and financiador = id_fin1::integer;
                xml2:=put_campo(xml2,'FUNC_SALIDA',stSec.funcion_output);

        --END LOOP;

        --Va al flujo 3006
        xml2:=put_campo(xml2,'__SECUENCIAOK__','500');
        xml2:=put_campo(xml2,'CONTADOR_CME','1');

        return xml2;
end;
$$
LANGUAGE plpgsql;
*/

CREATE OR REPLACE FUNCTION iniciotx_ctamed (varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        cod_cme1        varchar;
begin
        xml2:=xml1;
        --xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2:=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        xml2:=put_campo(xml2,'CODIGO_RESP','2');
        xml2:=put_campo(xml2,'MENSAJE_RESP','');

        --Registramos este campo en tx_ctamed.
        xml2:=put_campo(xml2,'CTANUMCTA',coalesce(nullif(get_campo('CTANUMCTA',xml2),''),'0'));

        --Si viene tag IDXTX, no genera nuevo correlativo
        cod_cme1:=get_campo('COD_CME',xml2);
        xml2:=logapp(xml2,'Dentro de iniciotx: cod_cme1='||cod_cme1);
        if (cod_cme1='0') then
                --Correlativo de CME.
                cod_cme1:=nextval('correlativo_ctamed')::varchar;

                --Necesario para el Update de tx_ctamed
                xml2:=put_campo(xml2,'COD_CME',cod_cme1);

                --Para respuesta del SOAP request
                xml2:=put_campo(xml2,'IDXTX',cod_cme1);
        else
                --Nunca pasa por aca.
                xml2:=put_campo(xml2,'COD_CME','0'::varchar);
                xml2:=logapp(xml2,'Funcion iniciotx: No debe pasar por aca');
        end if;

        return xml2;
end;
$$
LANGUAGE plpgsql;
