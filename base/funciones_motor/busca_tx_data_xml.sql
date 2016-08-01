CREATE OR REPLACE FUNCTION busca_tx_data_xml(varchar)
returns varchar as
$$
declare
        xml1            alias for $1;
        xml2            varchar;
        tipo_tx1        varchar;
        input1          varchar;
        tag1            varchar;
begiN
        xml2:=xml1;
        input1  :=get_campo('INPUT',xml2);
        if length(split_part(split_part(input1,'<ns1:',2),'>',1))>0 then
                tag1:='<ns1:';
        elsif length(split_part(split_part($1,'<ws:',2),'>',1))>0 then
                tag1:='<ws:';
        else
                tag1:='';
        end if;

        tipo_tx1:=split_part(split_part(input1,tag1,2),'>',1);
        xml2    :=put_campo(xml2,'TX_WS',lower(tipo_tx1));              --El tx siempre en minusculas. En CME el formato es cerEnvCta

        xml2    :=put_campo(xml2,'TAG_BUSQUEDA',tag1||tipo_tx1||'>');
        return xml2;
end;
$$
LANGUAGE plpgsql;
