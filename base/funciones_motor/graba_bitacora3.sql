/*
        Funcion que inserta un DTE en la tabla correspondiente, dependiendo del canal que venga
        CANAL = RECIBIDOS, se inserta en dte_recibidos
        CANAL = EMITIDOS, se inserta en dte_emitidos
*/
CREATE OR REPLACE FUNCTION public.graba_bitacora(character varying,varchar)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
DECLARE
    xml1        alias for $1;
    evento1     alias for $2;
    xml2        varchar;
    rut_emisor1 integer;
    rut_receptor1       integer;
    stEvento  traza.traza%ROWTYPE;
    tabla_traza1        varchar;
    uri1        varchar;
    fecha_emision1      integer;
    codtx1      bigint;
    fecha1      timestamp;
    url1        varchar;
    aux1        varchar;
    dominio1    varchar;
    fecha_uri1  varchar;
        index1  varchar;
        index2  varchar;
        i integer;
BEGIN
    xml2:=xml1;
    if get_campo('BORRADOR',xml2) = 'SI' then
        return xml2;
    end if;

    --Verifico si el evento tiene una fecha invalida
    aux1:=get_campo('FECHA_EVENTO',xml2);
    if (aux1='1901-01-01') then
        xml2 := logapp(xml2,'Fecha Evento Invalida');
        return xml2;
    end if;

    --Si el evento es EMI (Emision) Traza toma la fecha en que llega el evento y no la fecha del evento
    if (length(aux1)>0 and evento1<>'EMI') then
        --Control de errores para la fecha en traza
        begin
                fecha1:=aux1::timestamp;
         EXCEPTION WHEN OTHERS THEN
                fecha1:=now();
                xml2:=logapp(xml2,'Fecha Evento Traza Invalida '||aux1);
         END;
    else
        fecha1:=now();
    end if;

    if (is_number(get_campo('CODIGO_TXEL',xml2)) is false) then
        codtx1:=0;
    else
        codtx1:=get_campo('CODIGO_TXEL',xml2)::bigint;
    end if;
    if (is_number(replace(get_campo('FECHA_EMISION',xml2),'-',''))) then
        fecha_emision1:=replace(get_campo('FECHA_EMISION',xml2),'-','')::integer;
    else
        fecha_emision1:=19000101;
    end if;
    if (length(get_campo('URL_GET',xml2))= 0) then
        url1 := null;
    else
        url1 := get_campo('URL_GET',xml2);
    end if;

    rut_emisor1:=set_to_null(get_campo('RUT_EMISOR',xml2))::integer;
    rut_receptor1:=set_to_null(get_campo('RUT_RECEPTOR',xml2))::integer;
    uri1:=get_campo('URI_IN',xml2);

    --Si no viene URI no grabe
    if (length(uri1)=0) then
        xml2:=logapp(xml2,'URI Invalida no graba Evento '||evento1);
        return xml2;
    end if;

    --Obtengo el mes de la URI, ultimos 4 caracteres de
    tabla_traza1:=get_tabla_traza(uri1);

    BEGIN
        --Si ya existe el evento, solo actualiza la fecha de actualizacion
        execute 'select * from '||tabla_traza1||' where uri=$1 and evento=$2' into stEvento using uri1,evento1;
        --select * into stEvento from traza.traza where uri=uri1 and evento=evento1 ;
        if stEvento.uri is not null then
                xml2:=logapp(xml2,'Evento Repetido URI='||uri1||' Evento='||evento1);
                --Si es un libro, actualize el folio y la fecha de emision
                if (get_campo('TIPO_OPERACION',xml2) in ('COMPRA','VENTA') and evento1='ESI') then
                        execute 'update '||tabla_traza1||' set folio=$1,fecha_emision=$2,fecha_actualizacion=now(),veces=veces+1 where uri=$3 and evento=$4' using get_campo('FOLIO',xml2),get_campo('FECHA_EMISION',xml2)::integer,uri1,evento1;
                else
                        execute 'update '||tabla_traza1||' set fecha_actualizacion=now(),veces=veces+1,comentario1='||quote_literal(get_campo('COMENTARIO_TRAZA',xml2))||',comentario2='||quote_literal(get_campo('COMENTARIO2',xml2))||' where uri=$1 and evento=$2' using uri1,evento1;
                end if;
                --Si el evento ya se envio a traza, no lo volvemos a enviar
                xml2:=put_campo(xml2,'EVENTO_REPETIDO','SI');
                return xml2;
        end if;
    EXCEPTION WHEN OTHERS THEN
        --Nunca crea nada para traza.traza solo si no existe la tabla
        if (tabla_traza1<>'traza.traza') then
                fecha_uri1:=get_fecha_uri(uri1);
                index1:='traza_'||fecha_uri1||'_01';
                index2:='traza_'||fecha_uri1||'_02';
                --Si falla, creo la tabla que no existe
                execute 'create table '||tabla_traza1||' (fecha timestamp,folio varchar(20),tipo_dte varchar(15),rut_emisor integer,rut_receptor integer,canal varchar(1),evento varchar(100),uri varchar(255),comentario1 varchar,comentario2 varchar,url_get varchar(255),codigo_txel bigint,veces integer,fecha_actualizacion timestamp,fecha_emision integer,fecha_ingreso timestamp,fecha_despacho_erp timestamp)';
                execute 'create index '||index1||' on '||tabla_traza1||' (uri)';
                execute 'create index '||index2||' on '||tabla_traza1||' (fecha_ingreso)';
        end if;
        --Preguntamos nuevamente
        execute 'select * from '||tabla_traza1||' where uri=$1 and evento=$2' into stEvento using uri1,evento1;
        --select * into stEvento from traza.traza where uri=uri1 and evento=evento1 ;
        if stEvento.uri is not null then
                xml2:=logapp(xml2,'Evento Repetido URI='||uri1||' Evento='||evento1);
                --execute 'update '||tabla_traza1||' set fecha_actualizacion=now(),veces=veces+1 where uri=$1 and evento=$2' using uri1,evento1;
                execute 'update '||tabla_traza1||' set fecha_actualizacion=now(),veces=veces+1,comentario1='||quote_literal(get_campo('COMENTARIO_TRAZA',xml2))||',comentario2='||quote_literal(get_campo('COMENTARIO2',xml2))||' where uri=$1 and evento=$2' using uri1,evento1;
                --Si el evento ya se envio a traza, no lo volvemos a enviar
                xml2:=put_campo(xml2,'EVENTO_REPETIDO','SI');
                return xml2;
        end if;
    end;

    --Si no es un evento repetido, grabo las estadisticas correspondientes.
    xml2:=put_campo(xml2,'EVENTO',evento1);

    --Solo vamos a actualizar las estadisticas si el canal el EMITIDO
    if (get_campo('CANAL',xml2)='EMITIDOS') then
        xml2:=indexer_estados(xml2);
    end if;

    xml2:=logapp(xml2,'Graba Evento URI='||uri1||' Evento='||evento1);
    execute 'insert into '||tabla_traza1||' (fecha,folio,tipo_dte,rut_emisor,rut_receptor,canal,evento,uri,comentario1,comentario2,url_get,codigo_txel,veces,fecha_actualizacion,fecha_emision,fecha_ingreso) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16)' using fecha1,get_campo('FOLIO',xml2),get_campo('TIPO_DTE',xml2),rut_emisor1,rut_receptor1,null,evento1,uri1,get_campo('COMENTARIO_TRAZA',xml2),get_campo('COMENTARIO2',xml2),url1,codtx1,0,now(),fecha_emision1,now();
    GET DIAGNOSTICS i = ROW_COUNT;
    if i=1 then
        xml2 := put_campo(xml2,'__COD_RESPUESTA__','00');
    else
        xml2 := put_campo(xml2,'__COD_RESPUESTA__','99');
        xml2:=logapp(xml2,'FALLA GRABADO TRAZA!!! URI='||uri1||' Evento='||evento1);
    end if;

    --Para todo evento, se verifica si es necesario escribir en formato ERP
    --Para envio posterior
    xml2:=graba_evento_erp(xml2);

    RETURN xml2;
END;
$function$

