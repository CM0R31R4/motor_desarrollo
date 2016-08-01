DROP TABLE confirma_cardif;
DROP SEQUENCE confirma_cardif_id_seq;
CREATE SEQUENCE confirma_cardif_id_seq START 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

CREATE TABLE confirma_cardif (
    id          integer NOT NULL DEFAULT nextval('confirma_cardif_id_seq'::regclass),
    fecha 	timestamp without time zone,
    estado 	character varying,
    reintentos 	integer,
    prioridad 	integer,
    xml_in 	character varying,
    codigo_cia 	character varying,
    tx 		character varying
);
CREATE INDEX confirma_cardif_01 ON confirma_cardif USING btree (id);
CREATE INDEX confirma_cardif_02 ON confirma_cardif USING btree (fecha);
ALTER TABLE confirma_cardif INHERIT confirma_generica;

