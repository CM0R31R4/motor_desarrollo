CREATE OR REPLACE FUNCTION registra_tx_dec(varchar)
returns varchar as $$
declare
        xml1            alias for $1;
        xml2            varchar;

        fecha_in_tx1    timestamp;
        estado          varchar;
        codigo_resp     varchar;
        mensaje_resp    varchar;
        xml_std1        varchar;

begin
        xml2 := xml1;

        fecha_in_tx1    := get_campo('FECHA_IN_TX',xml2)::timestamp;
        codigo_resp     := get_campo('CODIGO_RESP',xml2);
        mensaje_resp    := get_campo('MENSAJE_RESP',xml2);
        xml_std1        := get_campo('__XML_STD__',xml2);
	

        INSERT INTO tx_dec(     codigo_motor,
				num_actoventa,
                                fecha_emision,
				cod_fin,
				xml_actoventa,
                                estado
                    )values(
                                get_campo('CODIGO_MOTOR',xml2)::bigint,
                                get_campo('EXTNUMACTOVENTA',xml2)::bigint,
				get_campo('EXTFECEMISION',xml2),
				get_campo('EXTCODFINANCIADOR',xml2)::integer,
				get_campo('EXTXMLACTOVENTA',xml2),
                                get_campo('ESTADO_TX',xml2)
                           );
        return xml2;
end;
$$ language 'plpgsql';
