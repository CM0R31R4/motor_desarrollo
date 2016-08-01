delete from isys_querys_tx where llave='3003';

insert into isys_querys_tx values ('3003',10,1,1,'SELECT proc_parser_traductor_ws_3003(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--insert into isys_querys_tx values ('3003',20,1,1,'SELECT sp_call_cme_3003(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

insert into isys_querys_tx values ('3003',30,1,1,'SELECT proc_parser_respuesta_ws_3003(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Valida respuesta del percona
insert into isys_querys_tx values ('3003',40,1,1,'SELECT proc_valida_respuesta_percona_3003(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--SERVICIO MEDICO CCHC (Con GET_MULTIPLE)
insert into isys_querys_tx values ('3003',11,11,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
--VIDA CAMARA (Con GET_MULTIPLE)
insert into isys_querys_tx values ('3003',44,44,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);

--Llamada Percona
insert into isys_querys_tx values ('3003',10001,10001,1,'$$SQLINPUT$$',0,0,0,1,1,40,40);

--SAN LORENZO (Port=8062)
--insert into isys_querys_tx values ('3003',62,1,2,'Oracle SANLORENZO',8063,110,111,1,1,30,30);
--FUSAT (Port=8063)
--insert into isys_querys_tx values ('3003',63,1,2,'Oracle FUSAT',8063,110,111,1,1,30,30);
--CHUQUICAMATA (Port=8065)
--insert into isys_querys_tx values ('3003',65,1,2,'Oracle CHUQUICAMATA',8063,110,111,1,1,30,30);
--RIO BLANCO (Port=8068)
--insert into isys_querys_tx values ('3003',68,1,2,'Oracle RIOBLANCO',8063,110,111,1,1,30,30);

--COLMENA
insert into isys_querys_tx values ('3003',67,67,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
--CONSALUD
--insert into isys_querys_tx values ('3003',71,1,2,'Oracle CONSALUD',8071,110,111,1,1,30,30);
--insert into isys_querys_tx values ('3003',71,2,1,'Oracle CONSALUD',8071,100,101,1,1,30,30);
--FUNDACION
--insert into isys_querys_tx values ('3003',76,1,2,'Oracle FUNDACION',8076,110,111,1,1,30,30);
--CRUZ_BLANCA
--JCC:06-06-2013 Nuevo ESPERA_OUTPUT_1. Soporta Array
--Nativo API BAse Datos
--insert into isys_querys_tx values ('3003',78,78,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
insert into isys_querys_tx values ('3003',78,78,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
--FERROSALUD (Con GET_MULTIPLE)
insert into isys_querys_tx values ('3003',81,81,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
--MASVIDA (Con GET_MULTIPLE)
insert into isys_querys_tx values ('3003',88,88,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);      --GET_MULTIPLE
--insert into isys_querys_tx values ('3003',88,88,1,'$$SQLINPUT$$',0,0,0,1,1,30,30);    --GET_RECORD

--VIDA TRES (Port=8077)
--insert into isys_querys_tx values ('3003',80,1,2,'Oracle VIDATRES',8099,110,111,1,1,30,30);   --Por la Api de Banmedica
--BANMEDICA (Port=8099)
--insert into isys_querys_tx values ('3003',99,1,2,'Oracle BANMEDICA',8099,110,111,1,1,30,30);

--Servicio MultiApis Oracle
insert into isys_querys_tx values ('3003',900,1,2,'Oracle MULTIAPI',8100,110,111,1,1,30,30);

--FONASA(Consume WebService)
insert into isys_querys_tx values ('3003',100,1,2,'FONASA_WS',9000,110,112,1,1,30,30);   --Llama un servicio de tabla servicios
--insert into isys_querys_tx values ('3003',100,1,2,'FONASA_WS',9000,200,201,1,1,30,30);   --Llama un servicio de tabla servicios
--insert into isys_querys_tx values ('3003',100,2,1,'FONASA_WS',9000,200,201,1,1,30,30); --Usa la BaseDatos Nro=2

--DEC(Consume WebService)
insert into isys_querys_tx values ('3003',500,1,2,'DEC_WS',1000,110,112,1,1,30,30);   --Llama un servicio de tabla servicios

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_parser_traductor_ws_3003(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        stSec           define_secuencia_ws%ROWTYPE;
        stData          respuestas_soap%ROWTYPE;
        stBono          tx_bono3%ROWTYPE;
        tipo_tx1        varchar;
        input1          varchar;
        cod_motor1      varchar;
        id_fin1         integer;
        xml_error1      varchar;
        query1          varchar;
        puerto1         varchar;
        financiador1    varchar;
        folio_anular1   varchar;

        cont1           integer='1';
        aux1            varchar;
        folios1         varchar='';
        tabla1          varchar;
begin
        xml2:=xml1;

        xml2:=logapp(xml2,'__COLA_MOTOR__='||get_campo('__COLA_MOTOR__',xml2));
        xml2:=logapp(xml2,'__ID_DTE__='||get_campo('__ID_DTE__',xml2));
        --Preguntamos si viene el wsdl
        if (get_campo('REQUEST_METHOD',xml2)='GET' and
            (strpos(get_campo('REQUEST_URI',xml2),'wsdl')>0 or strpos(get_campo('REQUEST_URI',xml2),'xsd')>0)) then
                xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
                return proc_wsdl_3002(xml2);
        end if;

        --Temporal
        --xml2:=logapp(xml2,'F3003: STATUS_BONO='||get_campo('STATUS_BONO',xml2)||' - DATA_INPUT ='||get_campo('INPUT',xml2));
        xml2:=logapp(xml2,'F3003: STATUS_BONO='||get_campo('STATUS_BONO',xml2));

        --Si solo falta el Percona
        if (get_campo('STATUS_BONO',xml2)='SOLO_PERCONA') then
                xml2:=logapp(xml2,'Solo confirma Percona');
                xml2:=put_campo(xml2,'SQLINPUT',replace(get_campo('SQLINPUT',xml2),'<C>',chr(39)));
                xml2:=logapp(xml2,get_campo('SQLINPUT',xml2));
                xml2:=put_campo(xml2,'__SECUENCIAOK__','10001');
                return xml2;
        end if;

        --xml2  :=put_campo(xml2,'ESTADO_TX','');

        xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        xml2    :=put_campo(xml2,'CODIGO_RESP','');
        xml2    :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_IN_TX',clock_timestamp()::varchar);

        --Guardamos el input Original
        xml2:=put_campo(xml2,'INPUT_ORI',get_campo('INPUT',xml2));

        --Solo parseamos para los que no son envbonis_real o envbono_real
        xml2:=put_campo(xml2,'INPUT',decode(get_campo('INPUT',xml2),'hex')::varchar);
        --input1        :=get_campo('INPUT',xml2);
        xml2    :=put_campo(xml2,'__HOST__',get_campo('HTTP_HOST',xml2));

        --Si es una confirmacion real, no valido algunas cosas
        if (get_campo('TX_WS',xml2) not in ('envbonis_real','envbono_real')) then
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
                xml2    :=busca_tx_data_xml(xml2);

        else
                --Si es un envonis_real o envbono_real.
                --Para guardar el XmlInput del Request en tx_bono3
                xml2:=put_campo(xml2,'__XML_STD__',replace(replace(get_campo('INPUT',xml2),'\012',''),'\011',''));
        end if;

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

        financiador1:=get_campo('EXTCODFINANCIADOR',xml2);
        --Input Financiador Bono3
        if is_number(financiador1) then
                id_fin1 := financiador1::integer;
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

        /*TODO: Ya no valida
        --Antes de dejar pasar la anulacion verificamos que el bono este confirmado
        if (get_campo('TX_WS',xml2) in ('anulabonou')) then
                folio_anular1:=get_campo('EXTFOLIOBONO',xml2);
                --Si no es numerico. Rechaza
                if (is_number(folio_anular1) is false) then
                        xml2:=put_campo(xml2,'ERRORCOD','0');
                        xml2:=put_campo(xml2,'ERRORMSG','');
                        xml2:=put_campo(xml2,'EXTCODERROR','N');
                        xml2:=put_campo(xml2,'EXTMENSAJEERROR','Folio no numerico para la anulacion');
                        xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                        xml2:=logapp(xml2,'Folio no numerico para la anulacion');
                        xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));
                        xml2:=respuesta_xml(xml2);
                        xml2:=responde_http_scgi(xml2);
                        return xml2;
                end if;
                --Busca el bono con llave folio+id_fin1
                SELECT * INTO stBono FROM tx_bono3 WHERE folio=folio_anular1 and cod_fin=id_fin1 and tipo_tx in ('envbonis_real','envbono_real');
                if not found then
                        xml2:=put_campo(xml2,'ERRORCOD','0');
                        xml2:=put_campo(xml2,'ERRORMSG','');
                        xml2:=put_campo(xml2,'EXTCODERROR','N');
                        xml2:=put_campo(xml2,'EXTMENSAJEERROR','Anulacion Rechazada, Bono no confirmado');
                        xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                        xml2:=logapp(xml2,'Anulacion Rechazada, Bono no confirmado');
                        xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));
                        xml2:=respuesta_xml(xml2);
                        xml2:=responde_http_scgi(xml2);
                        return xml2;
                end if;

                --Si no esta TERMINADO_OK, RECHAZO
                if (stBono.estado<>'TERMINADO_OK') then
                        xml2:=put_campo(xml2,'ERRORCOD','0');
                        xml2:=put_campo(xml2,'ERRORMSG','');
                        xml2:=put_campo(xml2,'EXTCODERROR','N');
                        xml2:=put_campo(xml2,'EXTMENSAJEERROR','Confirmacion de Bono Pendiente');
                        xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                        xml2:=logapp(xml2,'Confirmacion de Bono Pendiente');
                        xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));
                        xml2:=respuesta_xml(xml2);
                        xml2:=responde_http_scgi(xml2);
                        return xml2;
                end if;
        end if;
        */
        --Para guardar el Id del Financiador en la Base
        xml2:=put_campo(xml2,'ID_FIN',id_fin1::varchar);

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

        xml2:=put_campo(xml2,'FUNCION_OUTPUT',stSec.funcion_output);
        xml2:=put_campo(xml2,'FINANCIADOR',stSec.descripcion);

        --EJECUTA FUNCION INPUT
        xml2:=logapp(xml2,'Ejecuta='||stSec.funcion_input);
        if length(stSec.funcion_input)>0 then
                --xml2 := put_campo(xml2,'__FUNCION__',get_campo('__FUNCION__',xml2) || '-' || stSec.funcion_input);
                EXECUTE 'SELECT ' || stSec.funcion_input || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
        end if;

        --Agrega los datos de lectura de la IP Generica
        xml2:=put_campo(xml2,'DEFINE_SEC_WS_IP',stSec.ip_generica);
        xml2:=put_campo(xml2,'DEFINE_SEC_WS_PORT',stSec.correlativo_port_generica);
        xml2:=put_campo(xml2,'DEFINE_SEC_WS_SECUENCIAOK',stSec.secuencia::varchar);

/*
        --Si trae IP_GENERICA la usamos
        if (stSec.ip_generica is not null) then
                xml2:=put_campo(xml2,'__IP_CONEXION_CLIENTE__',stSec.ip_generica);
                query1:='SELECT NEXTVAL('||quote_literal(stSec.correlativo_port_generica)||')';
                EXECUTE query1 into puerto1;
                xml2:=put_campo(xml2,'__IP_PORT_CLIENTE__',coalesce(puerto1,'0'));
                xml2:=logapp(xml2,'Conexion a '||stSec.ip_generica::varchar||' Port='||coalesce(puerto1,'0')::varchar);
        end if;

        --Usa la secuenciaOK, seteada en tabla t_define_secuencia
        xml2:=put_campo(xml2,'__SECUENCIAOK__',stSec.secuencia::varchar);
*/

        --En caso de error en el formato del Rut
        if get_campo('ERROR_RUT',xml2) = 'SI' then
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Error Rut');
                xml2:=put_campo(xml2,'ERRORCOD','500');
                xml2:=put_campo(xml2,'ERRORMSG','Rut Invalido');
                xml2:=logapp(xml2,'Rut Invalido');

                --Proceso la respuesta con los datos en el XML
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);
                --No va al Financiador en caso de error
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
                return xml2;
        end if;


        --TODO: Servicio Dummies. Nunca va al Financiador para este servicio en PROD.
        if (tipo_tx1='envbonis' or tipo_tx1='envbono')  then
                xml2:=logapp(xml2,'Envbonis: Confirmacion Bono OK');

                xml2:=put_campo(xml2,'ERRORCOD','0');
                xml2:=put_campo(xml2,'ERRORMSG','');
                xml2:=put_campo(xml2,'EXTCODERROR','S');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','APROBADA MOTOR');


                --Genera Respuesta SOAP OK.
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));
                --Para Registro en Tabla tx_bono3
                xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                xml2    :=put_campo(xml2,'CODIGO_RESP','1');
                xml2    :=put_campo(xml2,'MENSAJE_RESP','Servicio Conf OK');

                --Para guardar la fecha_emision en el envbonis/envbono_real
                xml2:=put_campo(xml2,'extfechaemision',get_campo('EXTFECHAEMISION',xml2));

                --Para guardar el Monto Aporte Total en envbonis/envbono_real
                xml2:=put_campo(xml2,'extMontoAporteTotal', get_campo('EXTMONTOAPORTETOTAL',xml2));

                xml2:=b3_registra_tx(xml2);
                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

                --Registramos en la cola correspondiente
                --Solo para Fonasa, se generan 4 Colas
                if get_campo('FINANCIADOR',xml2) = 'FONASA' then
                        --id_cola:=
                        tabla1:='confirma_bono_'||get_campo('FINANCIADOR',xml2)||'_'||nextval('cola_fonasa_id_seq');
                else
                        tabla1:='confirma_bono_'||get_campo('FINANCIADOR',xml2);
                end if;

                xml2:=put_campo(xml2,'TX_WS',tipo_tx1||'_real');
                xml2:=put_campo(xml2,'INPUT',get_campo('INPUT_ORI',xml2));
                xml2:=put_campo(xml2,'INPUT_ORI','');
                BEGIN
                        EXECUTE 'INSERT INTO '||tabla1||' (fecha,estado,reintentos,prioridad,xml_in,financiador,tx) VALUES (now(),''INGRESADO'',0,0,'||quote_literal(xml2)||','||get_campo('ID_FIN',xml2)||','||quote_literal(tipo_tx1)||')';
                EXCEPTION WHEN OTHERS THEN
                        --si la tabla no existe la crea
                        EXECUTE 'CREATE TABLE '||tabla1||' (fecha timestamp,estado varchar,reintentos integer,prioridad integer, xml_in varchar,financiador integer,tx varchar,id serial);';
                        EXECUTE 'CREATE INDEX '||tabla1||'_01 ON '||tabla1||' (id)';
                        EXECUTE 'INSERT INTO '||tabla1||' (fecha,estado,reintentos,prioridad,xml_in,financiador,tx) values (now(),''INGRESADO'',0,0,'||quote_literal(xml2)||','||get_campo('ID_FIN',xml2)||','||quote_literal(tipo_tx1)||')';
                END;

                --No va al Financiador
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
                return xml2;
        end if;

        --TODO: Servicio Dummies. Nunca va al Financiador para este servicio en PROD.
        /*
define_secuencia_ok_3003
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
                --Proceso la respuesta con los datos en el XML
                xml2:=respuesta_xml(xml2);
                xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
                xml2:=responde_http_scgi(xml2);

                --No va al Financiador
                xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
                return xml2;
        end if;
        */

        --Determina cuantas veces se llama a una api
        xml2:=put_campo(xml2,'LOOP_SECUENCIA','1');
        --Funcion que determina la secuencia
        xml2:=proc_define_secuencia_ok_3003(xml2);

        --Si voy al financiador, guardo el registro en la tabla
        xml2:=b3_registra_tx(xml2);
        xml2:=logapp(xml2,'CodMotor['||cod_motor1||'] - '||get_campo('FINANCIADOR',xml2)||': REQ_'||upper(tipo_tx1)||' -> '||replace(get_campo('SQLINPUT',xml2),chr(10),'    '));
        --xml2:=logapp(xml2,'CodMotor='||cod_motor1);
        --xml2:=logapp(xml2,'Request_Financiador='||get_campo('SQLINPUT',xml2));

        --Variables que deben ser limpiadas
        xml2:=put_campo(xml2,'__STS_ERROR_SOCKET__','');
        xml2:=put_campo(xml2,'ESTADO_WS','');
        xml2:=put_campo(xml2,'API_CODRESPUESTA','');

        --En analisis
        --xml2:=put_campo(xml2,'RESPUESTA_HEX','');

        return xml2;
end;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION proc_define_secuencia_ok_3003(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        puerto1         varchar;
        query1          varchar;
BEGIN
        xml2:=xml1;

        --Limpia Variable
        --xml2:=put_campo(xml2,'__STS_ERROR_SOCKET__','');

        --Si trae IP_GENERICA la usamos
        if (get_campo('DEFINE_SEC_WS_IP',xml2)<>'') then
                xml2:=put_campo(xml2,'__IP_CONEXION_CLIENTE__',get_campo('DEFINE_SEC_WS_IP',xml2));
                query1:='SELECT NEXTVAL('||quote_literal(get_campo('DEFINE_SEC_WS_PORT',xml2))||')';
                EXECUTE query1 into puerto1;
                xml2:=put_campo(xml2,'__IP_PORT_CLIENTE__',coalesce(puerto1,'0'));
                xml2:=logapp(xml2,'Conexion a '||get_campo('DEFINE_SEC_WS_IP',xml2)||' Port='||coalesce(puerto1,'0')::varchar);
        end if;

        --Usa la secuenciaOK, seteada en tabla t_define_secuencia
        xml2:=put_campo(xml2,'__SECUENCIAOK__',get_campo('DEFINE_SEC_WS_SECUENCIAOK',xml2));
        return xml2;
end;
$$
LANGUAGE plpgsql;


--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_parser_respuesta_ws_3003(varchar)
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
        --timeout1:=0;
        xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        --xml2  :=put_campo(xml2,'SQLINPUT','');
        --xml2  :=put_campo(xml2,'ESTADO_TX','EN_PROCESO');
        --xml2  :=put_campo(xml2,'CODIGO_RESP','');
        --xml2  :=put_campo(xml2,'MENSAJE_RESP','');
        xml2    :=put_campo(xml2,'FECHA_OUT_TX',clock_timestamp()::varchar);

        tipo_tx1:=get_campo('TX_WS',xml2); --Bencertif
        id_fin1:=get_campo('ID_FIN',xml2)::integer;

        func_out1:=get_campo('FUNCION_OUTPUT',xml2);
        xml2:=logapp(xml2,'Ejecuta Funcion ='||func_out1);
        --Antes de ejecutar la funcion_out,
        --Si fue a la API del Financiador, debe pasar por traductor_out_solicfolios_isapre y luego entra a esta funcion
        if length(func_out1)>0 then
                --xml2 := put_campo(xml2,'__FUNCION__',get_campo('__FUNCION__',xml2) || '-' || func_out1);
                EXECUTE 'SELECT ' || func_out1 || '(' || chr(39) || xml2 || chr(39) || ')' into xml2;
                xml2:=logapp(xml2,'Respuesta="'||get_campo('MENSAJE_RESP',xml2)||'" Codigo='||get_campo('CODIGO_RESP',xml2));
        end if;

        --Calculo del Tiempo de Procesamiento. TimeOut
        /*fec_in1       :=to_timestamp(get_campo('FECHA_IN_TX',xml2),'YYYY-MM-DD HH24:MI:SS');
        fec_out1:=to_timestamp(get_campo('FECHA_OUT_TX',xml2),'YYYY-MM-DD HH24:MI:SS');*/
        fec_in1 :=get_campo('FECHA_IN_TX',xml2);
        fec_out1:=get_campo('FECHA_OUT_TX',xml2);

        timeout1:= AVG(fec_out1::time - fec_in1::time);
        seg1:=split_part(timeout1,':',3);
        xml2:=logapp(xml2,'Timeout='||timeout1::varchar);

        --Extrae solamente los segundos
        --timeout1:= EXTRACT(SECOND FROM TIME 'fec_out1' - 'fec_in1');
        --timeout1:= EXTRACT(SECOND FROM TIME 'timeout1');

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
                xml2:=responde_http_scgi(xml2);

                --Guardo este error, para shell control servicios
                xml2:=b3_update_tx(xml2);


                if (tipo_tx1 in ('envbonis_real','envbono_real')) then
                        xml2:=put_campo(xml2,'STATUS_BONO','NK');
                        xml2:=sp_procesa_respuesta_cola_bonos(xml2);
                end if;
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
                xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_ERROR',xml2));
                xml2:=respuesta_xml(xml2);
                xml2:=responde_http_scgi(xml2);

                --Guardo este error, para shell control servicios
                xml2:=b3_update_tx(xml2);

                --xml2:=put_campo(xml2,'ERROR_LOG','Falla:Conexion_API = '||tipo_tx1);
                xml2:=logapp(xml2,'Falla:Conexion_API = '||tipo_tx1);
                if (tipo_tx1 in ('envbonis_real','envbono_real')) then
                        xml2:=put_campo(xml2,'STATUS_BONO','NK');
                        xml2:=sp_procesa_respuesta_cola_bonos(xml2);

                        --Si hay rechazo, se informa a Percona
                        --Vamos al percona
                        /*xml2:=put_campo(xml2,'SQLINPUT','call IsaRechazoConfU('||get_campo('EXTCODFINANCIADOR',xml2)||','||get_campo('EXTFOLIOFINANCIADOR',xml2)||','||get_campo('ERRORMSG',xml2)||')');
                        xml2:=put_campo(xml2,'__SECUENCIAOK__','10001');
                        xml2:=logapp(xml2,'Percona='||get_campo('SQLINPUT',xml2));*/

                end if;
                return xml2;
        end if;

        --Si no contesta porque esta caida el API...
        if (strpos(get_campo('__STS_ERROR_SOCKET__',xml2),'FALLA_CONEXION')>0) then

                --Si es la primera vez que falla, reintenta en otro puerto
                if (get_campo('LOOP_SECUENCIA',xml2)='1') then
                        xml2:=put_campo(xml2,'LOOP_SECUENCIA','2');
                        xml2:=logapp(xml2,'Reintenta Otro Puerto ('||get_campo('__IP_PORT_CLIENTE__',xml2)||')');
                        xml2:=proc_define_secuencia_ok_3003(xml2);
                        return xml2;
                end if;
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
                xml2:=responde_http_scgi(xml2);

                --Guardo este error, para shell control servicios
                xml2:=b3_update_tx(xml2);

                xml2:=logapp(xml2,'Falla:Conexion con el Api Tx='||tipo_tx1);
                if (tipo_tx1 in ('envbonis_real','envbono_real')) then
                        xml2:=put_campo(xml2,'STATUS_BONO','NK');
                        xml2:=sp_procesa_respuesta_cola_bonos(xml2);
                end if;
                return xml2;
        end if;

        --Si no hay falla, marco el estado como OK
        xml2    :=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        xml2    :=put_campo(xml2,'ESTADO_TX_ORI','TERMINADO_OK');

        --Si es una confirmacion de Bono enbonis_real o enbono_real vamos a confirmar al percona
        if (tipo_tx1='envbonis_real' or tipo_tx1='envbono_real')  then
                --Si le fue bien
                if (get_campo('EXTCODERROR',xml2)='S') then
                        xml2:=logapp(xml2,'Confirmando Bono a Percona');
                        xml2:=put_campo(xml2,'SQLINPUT','call IsaSegBonoU('||get_campo('EXTCODFINANCIADOR',xml2)||','||get_campo('EXTFOLIOFINANCIADOR',xml2)||')');
                        --Vamos al percona
                        xml2    :=put_campo(xml2,'__SECUENCIAOK__','10001');
                        xml2:=logapp(xml2,'Percona='||get_campo('SQLINPUT',xml2));
                        return xml2;
                else
                        --Si rechaza el Financiador, lo sacamos de la cola
                        --Esto es mientras se activa la funcion IsaRechazoConfU !!! OJO JAIME
                        /*xml2:=logapp(xml2,'Confirmacion Rechazada');
                        xml2:=put_campo(xml2,'STATUS_BONO','OK');
                        xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
                        xml2:=b3_update_tx(xml2);
                        xml2:=sp_procesa_respuesta_cola_bonos(xml2);*/

                        --Informa rechazo en Percona
                        xml2:=put_campo(xml2,'SQLINPUT','call IsaRechazoConfU('||get_campo('EXTCODFINANCIADOR',xml2)||','||get_campo('EXTFOLIOFINANCIADOR',xml2)||','||quote_literal(substring(get_campo('EXTMENSAJEERROR',xml2),1,30))||',1)');
                        xml2    :=put_campo(xml2,'__SECUENCIAOK__','10001');
                        xml2:=logapp(xml2,'Percona.Rechazo='||get_campo('SQLINPUT',xml2));
                        return xml2;
                end if;
        end if;


        --Si API_CODRESPUESTA=1
        --Genera Respuesta SOAP OK.
        xml2:=put_campo(xml2,'RESPUESTA',get_campo('XML_OK',xml2));
        --Proceso la respuesta con los datos en el XML
        xml2:=respuesta_xml(xml2);
        xml2:=put_campo(xml2,'STATUS_HTTP','200 OK');
        --xml2:=logapp(xml2,'Respuesta OK 200 -RESPUESTA='||get_campo('RESPUESTA_HEX',xml2));
        xml2:=responde_http_scgi(xml2);

        --xml2:=logapp(xml2,'RESPUESTA_HEX ='||get_campo('RESPUESTA_HEX',xml2));

        --Si todo fue OK. Updateo el registro
        xml2:=b3_update_tx(xml2);
        return xml2;
end;
$$
LANGUAGE plpgsql;


--Valida respuesta del percona
CREATE OR REPLACE FUNCTION proc_valida_respuesta_percona_3003(varchar)
returns varchar as
$$
declare
        xml2    varchar;
begin
        xml2:=$1;
        xml2:=logapp(xml2,'Valida Respuesta Percona');

        xml2:=logapp(xml2,'Respuesta Percona='||get_campo('RESPUESTA_PERCONA',xml2));
        xml2:=logapp(xml2,'Socket No Response='||get_campo('__STS_ERROR_SOCKET__',xml2));

        --Verifica el restorno
        --if (get_campo('RESPUESTA_PERCONA',xml2)='1' or get_campo('__STS_ERROR_SOCKET__',xml2)='SOCKET_NO_RESPONSE_BD') then
        if (get_campo('RESPUESTA_PERCONA',xml2)='1') then
                --Error
                xml2:=logapp(xml2,'Falla Update Percona');
                xml2:=put_campo(xml2,'STATUS_BONO','SOLO_PERCONA');
                --xml2:=put_campo(xml2,'ESTADO_TX_ORI',get_campo('ESTADO_TX',xml2));
                xml2:=put_campo(xml2,'ESTADO_TX','SOLO_PERCONA');

        elsif (get_campo('RESPUESTA_PERCONA',xml2)='0') then
                xml2:=logapp(xml2,'Graba OK Percona');
                xml2:=put_campo(xml2,'STATUS_BONO','OK');
                xml2:=put_campo(xml2,'ESTADO_TX','TERMINADO_OK');
        else
                xml2:=logapp(xml2,'Error en estado de Percona');
                xml2:=put_campo(xml2,'STATUS_BONO','SOLO_PERCONA');
                xml2:=put_campo(xml2,'ESTADO_TX','SOLO_PERCONA');
        end if;
        xml2:=b3_update_tx(xml2);
        xml2:=sp_procesa_respuesta_cola_bonos(xml2);
        xml2:=put_campo(xml2,'__SECUENCIAOK__','0');
        return xml2;
end;
$$
LANGUAGE plpgsql;
