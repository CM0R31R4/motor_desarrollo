DROP TABLE base_datos;

CREATE TABLE base_datos (
    base        integer,
    ip          character varying(20),
    port        integer,
    descripcion character varying(20),
    proyecto    character varying(20),
    tipo_db     character varying(20)
);

CREATE INDEX base_datos_01 ON base_datos USING btree (base);
