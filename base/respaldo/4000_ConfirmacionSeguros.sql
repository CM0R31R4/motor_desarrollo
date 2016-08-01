delete from isys_querys_tx where llave='4000';

insert into isys_querys_tx values ('4000',10,1,1,'select proc_confirma_seguros_4000(''$$__XMLCOMPLETO__$$'') as __XML__',0,0,0,1,1,-1,0);

--Parsea el WS para identificar la transacciones entrante
CREATE OR REPLACE FUNCTION proc_confirma_seguros_4000(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        stData          respuestas_soap%ROWTYPE;
        stCia           cias_seguros%ROWTYPE;
        tipo_tx1        varchar;
        input1          varchar;
        cod_motor1      bigint;
        respuesta1      varchar;
        sql1            varchar;
        compania1       varchar;
        i               integer;
        file_wsdl1      varchar;
        tx1             varchar;
        codigo_cia1     varchar;
begin
        xml2:=xml1;
        xml2    :=put_campo(xml2,'__SECUENCIAOK__','0');
        input1  :=decode(get_campo('INPUT',xml2),'hex');

        --Reemplazamos los &lt;/extCodFinanciador&gt;
        input1 :=replace(replace(input1,'&lt;','<'),'&gt;','>');
        xml2:=put_campo(xml2,'INPUT',encode(input1::bytea,'hex'));

        --Codigo de Cia
        xml2:=put_campo(xml2,'CODIGO_CIA',get_xml('extCodSeguro',input1));
        codigo_cia1:=get_campo('CODIGO_CIA',xml2);

        xml2:=put_campo(xml2,'NUM_OPERACION',get_xml('extNumOperacion',input1));
        xml2:=put_campo(xml2,'extRutBeneficiario',get_xml('extRutBeneficiario',input1));
        xml2:=put_campo(xml2,'extFolioAuto',get_xml('extFolioAuto',input1));
        xml2:=put_campo(xml2,'extFolioBono',get_xml('extFolioBono',input1));
        xml2:=put_campo(xml2,'extFechaEmision',get_xml('extFechaEmision',input1));
        xml2:=put_campo(xml2,'ExtMtoBonif',get_xml('ExtMtoBonif',input1));
        tx1:=split_part(get_campo('REQUEST_URI',xml2),'/',2);

        --Verificamos si es un wsdl
        xml2:=logapp(xml2,'Method='||get_campo('REQUEST_METHOD',xml2)||' -- Uri='||get_campo('REQUEST_URI',xml2));
        if (get_campo('REQUEST_METHOD',xml2)='GET' and strpos(get_campo('REQUEST_URI',xml2),'wsdl')>0) then
                compania1:=split_part(split_part(get_campo('REQUEST_URI',xml2),'/cia_seg_',2),'?',1);
                SELECT pg_read_file('wsdl/wsdl_'||lower(tx1)||'_cia_seg.wsdl') into file_wsdl1;
                file_wsdl1:=replace(file_wsdl1,chr(36)||chr(36)||'LOCATION'||chr(36)||chr(36),compania1);
                xml2:=logapp(xml2,'Responde WSDL para '||compania1);
                xml2:=put_campo(xml2,'RESPUESTA','Status: 200 OK'||chr(10)||'Content-type: text/html'||chr(10)||'Content-length: '||length(file_wsdl1)||chr(10)||chr(10)||file_wsdl1);
                return xml2;
        end if;

        --Logeo el Input
        xml2:=logapp(xml2,'Input_Cia['||tx1||'] ='||input1);

        --Identifica la compania de seguro segun el REQUEST_URI
        compania1:=split_part(get_campo('REQUEST_URI',xml2),'/cia_seg_',2);

        --Seteamos valores de respuesta por defecto
        xml2:=put_campo(xml2,'EXTCODERROR','S');
        xml2:=put_campo(xml2,'EXTMENSAJEERROR',' ');
        xml2:=put_campo(xml2,'EXTFOLIOAUTO','0');


        --Lee Datos de la respuesta
        tipo_tx1:=upper(tx1)||'_CIA_SEGURO';
        select * into stData from respuestas_soap where tipo_tx=tipo_tx1;
        if not found then
                xml2:=put_campo(xml2,'STATUS_HTTP','500 Falla Tx1');
                xml2:=logapp(xml2,'No existe respuesta_soap, 500 Falla Tx='||tipo_tx1::varchar);
                --Proceso la respuesta con los datos en el XML
                respuesta1:='Tx no Definida';
                xml2:=put_campo(xml2,'RESPUESTA','Status: 500 NK'||chr(10)||'Content-type: text/html'||chr(10)||'Content-length: '||length(respuesta1)||chr(10)||chr(10)||respuesta1);
                return xml2;
        end if;
        xml2:=put_campo(xml2,'XML_RESPUESTA',stData.respuesta);

        --Verificamos si esta la compania
        xml2:=logapp(xml2,'codigo_cia1 ='||codigo_cia1||' -tx1='||tx1);
        select * into stCia from cias_seguros where codigo=codigo_cia1::integer and tx=tx1;
        --select * into stCia from cias_seguros where nemo=compania1;
        if not found then
                xml2:=logapp(xml2,'[f4000]- 500 '||compania1||' no definida');
                respuesta1:=compania1||' no definida';
                xml2:=put_campo(xml2,'EXTMENSAJEERROR',respuesta1);
                --xml2:=responde_http_conf_cia(xml2);
                EXECUTE 'SELECT responde_http_' || lower(tx1) || '_cia(' || chr(39) || xml2 || chr(39) || ')' into xml2;
                return xml2;
        end if;

        --Si no viene data , error
        if (get_campo('CONTENT_LENGTH',xml2)='0') then
                xml2:=logapp(xml2,'500 sin data');
                respuesta1:='Sin data para procesar';
                xml2:=put_campo(xml2,'EXTMENSAJEERROR',respuesta1);
                --xml2:=responde_http_conf_cia(xml2);
                EXECUTE 'SELECT responde_http_' || lower(tx1) || '_cia(' || chr(39) || xml2 || chr(39) || ')' into xml2;
                return xml2;
        end if;

        cod_motor1:=nextval('correlativo_motor');

        xml2:=put_campo(xml2,'CODIGO_MOTOR',cod_motor1::varchar);

        /*
        --Respuesta en Duro para la confirmacion de Bono 3
        if (tx1 in ('ConfirmacionBono3','AnulacionBono3')) then
                xml2:=put_campo(xml2,'EXTCODERROR','S');
                xml2:=put_campo(xml2,'EXTMENSAJEERROR','OK');
                xml2:=put_campo(xml2,'EXTFOLIOAUTO',cod_motor1::varchar);
                xml2:=logapp(xml2,'Responde Confirmacion Bono3');
                --Me fue bien contesto..
                --xml2:=responde_http_conf_cia(xml2);
                EXECUTE 'SELECT responde_http_' || lower(tx1) || '_cia(' || chr(39) || xml2 || chr(39) || ')' into xml2;
                return xml2;
        end if;

        */
        --Seteamos la TX para que vaya al flujo que envia las confirmaciones
        xml2:=put_campo(xml2,'TX','4001');

        --Log
        xml2:=logapp(xml2,decode(get_campo('INPUT',xml2),'hex')::varchar);

        --Grabo el XML entrante en la tabla que corresponda
        sql1:='insert into confirma_'||stCia.nemo||' (fecha,estado,reintentos,prioridad,xml_in,codigo_cia,tx) values (now(),''INGRESADO'',0,0,'||quote_literal(xml2)||','||quote_literal(get_campo('CODIGO_CIA',xml2))||','||quote_literal(tx1)||')';
        BEGIN
                execute sql1;
                GET DIAGNOSTICS i = ROW_COUNT;
                if i<>1 then
                        xml2:=logapp(xml2,'500 Falla Grabar Tabla (Falla en procesar '||tx1||')');
                        respuesta1:='Falla en procesar '||tx1;
                        xml2:=put_campo(xml2,'EXTMENSAJEERROR',respuesta1);
                        --xml2:=responde_http_conf_cia(xml2);
                        EXECUTE 'SELECT responde_http_' || lower(tx1) || '_cia(' || chr(39) || xml2 || chr(39) || ')' into xml2;
                        return xml2;
                end if;
                xml2:=logapp(xml2,'Se Graba OK Tx='||tx1);
        EXCEPTION WHEN OTHERS THEN
                xml2:=logapp(xml2,'Crea la tabla confirma_'||stCia.nemo);
                execute 'create table confirma_'||stCia.nemo||' (id serial,fecha timestamp,estado varchar,reintentos integer,prioridad integer,xml_in varchar,codigo_cia varchar)';
                execute 'create index confirma_'||stCia.nemo||'_01 on confirma_'||stCia.nemo||' (id)';
                execute 'create index confirma_'||stCia.nemo||'_02 on confirma_'||stCia.nemo||' (fecha)';

                execute sql1;
                GET DIAGNOSTICS i = ROW_COUNT;
                if i<>1 then
                        xml2:=logapp(xml2,'500 Falla Grabar Tabla (Falla en procesar '||tx1||'*)');
                        respuesta1:='*Falla en procesar '||tx1;
                        xml2:=put_campo(xml2,'EXTMENSAJEERROR',respuesta1);
                        --xml2:=responde_http_conf_cia(xml2);
                        EXECUTE 'SELECT responde_http_' || lower(tx1) || '_cia(' || chr(39) || xml2 || chr(39) || ')' into xml2;
                        return xml2;
                end if;
                xml2:=logapp(xml2,'Se Crea y Graba OK* Tx='||tx1);
        END;

        xml2:=put_campo(xml2,'EXTCODERROR','S');
        xml2:=put_campo(xml2,'EXTMENSAJEERROR','OK');
        xml2:=put_campo(xml2,'EXTFOLIOAUTO',cod_motor1::varchar);

        --Me fue bien contesto..
        --xml2:=responde_http_conf_cia(xml2);
        EXECUTE 'SELECT responde_http_' || lower(tx1) || '_cia(' || chr(39) || xml2 || chr(39) || ')' into xml2;
        return xml2;
end;
$$
LANGUAGE plpgsql;
