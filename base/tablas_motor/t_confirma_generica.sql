DROP TABLE confirma_generica;
DROP SEQUENCE confirma_generica;
CREATE SEQUENCE confirma_generica_id_seq START 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

CREATE TABLE public.confirma_generica (
        id              integer NOT NULL DEFAULT nextval('confirma_generica_id_seq'::regclass),
        fecha           timestamp without time zone,
        estado          character varying,
        reintentos      integer,
        prioridad       integer,
        xml_in          character varying,
        codigo_cia      character varying,
        tx              character varying
)
WITH (OIDS=FALSE)
;

ALTER TABLE public.confirma_generica OWNER TO motor;
