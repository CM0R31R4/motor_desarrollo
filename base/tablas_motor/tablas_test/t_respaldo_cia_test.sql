CREATE TABLE respaldo_cia_test (
    fecha 	timestamp without time zone,
    xml_in 	character varying,
    cia 	character varying
);

CREATE INDEX respaldo_cia_test_01 ON respaldo_cia_test USING btree (fecha);
CREATE INDEX respaldo_cia_test_02 ON respaldo_cia_test USING btree (cia);

