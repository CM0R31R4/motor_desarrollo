CREATE TABLE respaldo_envbonis_test (
    fecha 	timestamp without time zone,
    xml_in 	character varying
);

CREATE INDEX respaldo_envbonis_test_01 ON respaldo_envbonis_test USING btree (fecha);
