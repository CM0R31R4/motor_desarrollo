--DROP TABLE confirma_cbvida;
--DROP SEQUENCE confirma_cbvida_id_seq;
CREATE SEQUENCE confirma_cbvida_id_seq START 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

CREATE TABLE confirma_cbvida (
    id          integer NOT NULL DEFAULT nextval('confirma_cbvida_id_seq'::regclass),
    fecha       timestamp without time zone,
    estado      character varying,
    reintentos  integer,
    prioridad   integer,
    xml_in      character varying,
    codigo_cia  character varying,
    tx          character varying
);
CREATE INDEX confirma_cbvida_01 ON confirma_cbvida USING btree (id);
CREATE INDEX confirma_cbvida_02 ON confirma_cbvida USING btree (fecha);
ALTER TABLE confirma_cbvida INHERIT confirma_generica;

