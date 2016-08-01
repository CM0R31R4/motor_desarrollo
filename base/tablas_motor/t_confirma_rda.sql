DROP TABLE confirma_rda;
DROP SEQUENCE confirma_rda_id_seq CASCADE;
CREATE SEQUENCE confirma_rda_id_seq START 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

CREATE TABLE confirma_rda (
    id          integer NOT NULL DEFAULT nextval('confirma_rda_id_seq'::regclass),
    fecha 	timestamp without time zone,
    estado 	character varying,
    reintentos 	integer,
    prioridad 	integer,
    xml_in 	character varying,
    codigo_cia 	character varying,
    tx 		character varying
);

DROP INDEX confirma_rda_01;
DROP INDEX confirma_rda_02;

CREATE INDEX confirma_rda_01 ON confirma_rda USING btree (id);
CREATE INDEX confirma_rda_02 ON confirma_rda USING btree (fecha);
ALTER TABLE confirma_rda INHERIT confirma_generica;

