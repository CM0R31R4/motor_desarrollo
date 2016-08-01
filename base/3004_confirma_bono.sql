delete from isys_querys_tx where llave='3004';

insert into isys_querys_tx values ('3004',10,1,1,'SELECT confirma_bono_input_3004(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

insert into isys_querys_tx values ('3004',30,1,1,'SELECT confirma_bono_respuesta_3004(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

/*insert into isys_querys_tx values ('3004',150,1,1,'SELECT valtrans_bono_input_3004(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);
insert into isys_querys_tx values ('3004',200,1,1,'SELECT valtrans_bono_respuesta_3004(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);*/


--Llamada PERCONA
insert into isys_querys_tx values ('3004',10001,10001,1,'$$SQLINPUT$$',0,0,0,1,1,40,40);

--Valida respuesta del percona
insert into isys_querys_tx values ('3004',40,1,1,'SELECT proc_valida_respuesta_percona_3004(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--SERVICIO MEDICO CCHC (Con GET_MULTIPLE)
insert into isys_querys_tx values ('3004',11,11,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
--VIDA CAMARA (Con GET_MULTIPLE)
insert into isys_querys_tx values ('3004',44,44,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
--COLMENA
insert into isys_querys_tx values ('3004',67,67,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
--CRUZ_BLANCA
--JCC:06-06-2013 Nuevo ESPERA_OUTPUT_1. Soporta Array
--Nativo API BAse Datos
--insert into isys_querys_tx values ('3004',78,78,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
insert into isys_querys_tx values ('3004',78,78,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
--FERROSALUD (Con GET_MULTIPLE)
insert into isys_querys_tx values ('3004',81,81,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);
--MASVIDA (Con GET_MULTIPLE)
insert into isys_querys_tx values ('3004',88,88,1,'$$SQLINPUT$$',0,0,0,6,1,30,30);      --GET_MULTIPLE
--insert into isys_querys_tx values ('3004',88,88,1,'$$SQLINPUT$$',0,0,0,1,1,30,30);    --GET_RECORD

--Servicio MultiApis. Isapres con Oracle DB
insert into isys_querys_tx values ('3004',900,1,2,'Oracle MULTIAPI',8100,110,111,1,1,30,30);

--FONASA (Consume WebService)
insert into isys_querys_tx values ('3004',100,1,2,'FONASA_WS',9000,110,112,1,1,30,30);   --Llama un servicio de tabla servicios
--insert into isys_querys_tx values ('3004',100,2,1,'FONASA_WS',9000,200,201,1,1,30,30); --Usa la BaseDatos Nro=2


--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION confirma_bono_input_3004(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        stBono          tx_bono3%ROWTYPE;
        stSec           define_secuencia_ws%ROWTYPE;
        stData          respuestas_soap%ROWTYPE;
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

        --Temporal
        xml2:=logapp(xml2,'F3004: STATUS_BONO='||get_campo('STATUS_BONO',xml2)||' - DATA_INPUT ='||get_campo('INPUT',xml2));

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
        --xml2:=put_campo(xml2,'INPUT_ORI',get_campo('INPUT',xml2));

        --Solo parseamos para los que no son envbonis_real o envbono_real
        xml2:=put_campo(xml2,'INPUT',decode(get_campo('INPUT',xml2),'hex')::varchar);  --???
        --input1        :=get_campo('INPUT',xml2);

        --xml2    :=put_campo(xml2,'__HOST__',get_campo('HTTP_HOST',xml2));

        tipo_tx1:=get_campo('TX_WS',xml2);

        --cod_motor1:=nextval('correlativo_motor')::varchar;

        --Modificacion realizada el 2015-07-06.
        cod_motor1:=genera_codmotor();

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

        --Determina cuantas veces se llama a una api
        xml2:=put_campo(xml2,'LOOP_SECUENCIA','1');
        --Funcion que determina la secuencia
        xml2:=proc_define_secuencia_ok_3003(xml2);

        --Si voy al financiador, guardo el registro en la tabla
        xml2:=b3_registra_tx(xml2);

        --Variables que deben ser limpiadas
        xml2:=put_campo(xml2,'__STS_ERROR_SOCKET__','');
        xml2:=put_campo(xml2,'ESTADO_WS','');
        xml2:=put_campo(xml2,'API_CODRESPUESTA','');
        xml2:=put_campo(xml2,'RESPUESTA_HEX','');

        return xml2;
end;
$$
LANGUAGE plpgsql;

--Valida respuesta del percona
CREATE OR REPLACE FUNCTION proc_valida_respuesta_percona_3004(varchar)
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
