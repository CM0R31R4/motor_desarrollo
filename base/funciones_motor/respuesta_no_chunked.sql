CREATE or replace FUNCTION respuesta_no_chunked(varchar) RETURNS varchar
LANGUAGE plpgsql
AS
$function$
DECLARE
    xml1        alias for $1;
    xml2    varchar;
        resp1   varchar;
        header1 varchar;
        data1   varchar;
        len_chunked1    varchar;
        largo1  bigint;
        pos1    integer;
        respuesta1      varchar;
BEGIN
        xml2:=xml1;
        --Viene en respuesta_hex la respuesta chunked y la cambiamos por Content Length
        resp1:=get_campo('SQLOUTPUT',xml2);
        --Si no viene chunked, salimos inmediatamente
        if (strpos(resp1,encode('Transfer-Encoding: chunked','hex'))=0) then
                xml2:=logapp(xml2,'Respuesta no chunked');
                return xml2;
        end if;

        --Borro la parte chunked
        resp1:=replace(resp1,encode('Transfer-Encoding: chunked','hex'),encode('Content Length: XXX_REEMPLAZAR_LARGO_XXX','hex'));
        resp1:=replace(resp1,encode('Content-Type: application/xml;charset=ISO-8859-1','hex'),encode('Content-Type: text/html;charset=UTF-8','hex'));
        --Busco donde empieza el separador 10,10
        header1:=split_part(resp1,'0a0a',1);

        --raise notice 'header %',decode(header1,'hex');
        pos1:=strpos(resp1,'0a0a');
        data1:=substring(resp1,pos1+4);
        --raise notice 'data1 %',decode(data1,'hex');

        respuesta1:='';

        --Leo largo chunked
        len_chunked1:=split_part(data1,'0a',1);
        pos1:=strpos(data1,'0a'); ---
        --Mientras no llegue el largo 0
        while(len_chunked1<>'30') loop
                largo1:=hex2long(decode(len_chunked1,'hex')::varchar);
                --raise notice 'len_chunked = % %',decode(len_chunked1,'hex'),largo1;

                respuesta1:=respuesta1||substring(data1,pos1+2,(largo1*2)::integer);
                --raise notice 'data_sin_chunked %',decode(respuesta1,'hex');
                --Avanzo 1 mas porque viene un CR-LF al final de la data chuncked
                data1:=substring(data1,pos1+2+(largo1*2)::integer+4,length(data1));
                raise notice 'data1 %',decode(data1,'hex');
                if length(data1)=0 then
                        xml2=logapp(xml2,'Falla Largo chunked');
                        return xml2;
                end if;
                len_chunked1:=split_part(data1,'0a',1);
                pos1:=strpos(data1,'0a'); ---
                --raise notice 'len_chunked = %',len_chunked1;
        end loop;
        --Debo reemplazar el largo de la respuesta
        header1:='HTTP/1.1 200 OK'||chr(10)||
                 'Content-type: text/html'||chr(10)||
                 'Content-length: '||(length(respuesta1)/2)::varchar||chr(10);
        resp1:=encode(header1::bytea,'hex')||'0a'||respuesta1;
        xml2:=put_campo(xml2,'SQLOUTPUT',resp1);
        return xml2;

END;
$function$

