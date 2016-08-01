CREATE TABLE respaldo_envbonis (
    fecha timestamp without time zone,
    xml_in character varying
);

CREATE INDEX respaldo_envbonis_01 ON respaldo_envbonis USING btree (fecha);

