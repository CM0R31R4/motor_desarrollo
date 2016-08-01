CREATE TABLE respaldo_cia (
    fecha timestamp without time zone,
    xml_in character varying,
    cia character varying
);


CREATE INDEX respaldo_cia_01 ON respaldo_cia USING btree (fecha);
CREATE INDEX respaldo_cia_02 ON respaldo_cia USING btree (cia);

