--drop sequence correlativo_motor;
CREATE SEQUENCE correlativo_motor
    START WITH 11313
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--SELECT pg_catalog.setval('correlativo_motor', 11313, true);
