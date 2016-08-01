--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: confirma_generica; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_generica (
    id integer,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
);


ALTER TABLE public.confirma_generica OWNER TO motor;

--
-- Name: confirma_bci; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bci (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_bci OWNER TO motor;

--
-- Name: confirma_bci_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bci_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bci_id_seq OWNER TO motor;

--
-- Name: confirma_bci_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_bci_id_seq OWNED BY confirma_bci.id;


--
-- Name: confirma_bice; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bice (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_bice OWNER TO motor;

--
-- Name: confirma_bice_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bice_id_seq OWNER TO motor;

--
-- Name: confirma_bice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_bice_id_seq OWNED BY confirma_bice.id;


--
-- Name: confirma_bono_; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_ OWNER TO motor;

--
-- Name: confirma_bono_banmedica_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_banmedica_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_banmedica_seq OWNER TO motor;

--
-- Name: confirma_bono_banmedica; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_banmedica (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_banmedica_seq'::regclass) NOT NULL
);


ALTER TABLE public.confirma_bono_banmedica OWNER TO motor;

--
-- Name: confirma_bono_banmedica_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_banmedica_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_banmedica_id_seq OWNER TO motor;

--
-- Name: confirma_bono_banmedica_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_bono_banmedica_id_seq OWNED BY confirma_bono_banmedica.id;


--
-- Name: confirma_bono_chuquicamata_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_chuquicamata_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_chuquicamata_seq OWNER TO motor;

--
-- Name: confirma_bono_chuquicamata; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_chuquicamata (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_chuquicamata_seq'::regclass)
);


ALTER TABLE public.confirma_bono_chuquicamata OWNER TO motor;

--
-- Name: confirma_bono_colmena_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_colmena_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_colmena_seq OWNER TO motor;

--
-- Name: confirma_bono_colmena; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_colmena (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_colmena_seq'::regclass)
);


ALTER TABLE public.confirma_bono_colmena OWNER TO motor;

--
-- Name: confirma_bono_consalud_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_consalud_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_consalud_seq OWNER TO motor;

--
-- Name: confirma_bono_consalud; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_consalud (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_consalud_seq'::regclass)
);


ALTER TABLE public.confirma_bono_consalud OWNER TO motor;

--
-- Name: confirma_bono_cruz_blanca_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_cruz_blanca_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_cruz_blanca_seq OWNER TO motor;

--
-- Name: confirma_bono_cruz_blanca; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_cruz_blanca (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_cruz_blanca_seq'::regclass)
);


ALTER TABLE public.confirma_bono_cruz_blanca OWNER TO motor;

--
-- Name: confirma_bono_cruz_del_norte_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_cruz_del_norte_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_cruz_del_norte_seq OWNER TO motor;

--
-- Name: confirma_bono_cruz_del_norte; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_cruz_del_norte (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_cruz_del_norte_seq'::regclass)
);


ALTER TABLE public.confirma_bono_cruz_del_norte OWNER TO motor;

--
-- Name: confirma_bono_ferrosalud_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_ferrosalud_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_ferrosalud_seq OWNER TO motor;

--
-- Name: confirma_bono_ferrosalud; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_ferrosalud (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_ferrosalud_seq'::regclass)
);


ALTER TABLE public.confirma_bono_ferrosalud OWNER TO motor;

--
-- Name: confirma_bono_fonasa_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_fonasa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_fonasa_seq OWNER TO motor;

--
-- Name: confirma_bono_fonasa; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_fonasa (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_fonasa_seq'::regclass)
);


ALTER TABLE public.confirma_bono_fonasa OWNER TO motor;

--
-- Name: confirma_bono_fundacion_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_fundacion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_fundacion_seq OWNER TO motor;

--
-- Name: confirma_bono_fundacion; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_fundacion (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_fundacion_seq'::regclass)
);


ALTER TABLE public.confirma_bono_fundacion OWNER TO motor;

--
-- Name: confirma_bono_fusat_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_fusat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_fusat_seq OWNER TO motor;

--
-- Name: confirma_bono_fusat; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_fusat (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_fusat_seq'::regclass)
);


ALTER TABLE public.confirma_bono_fusat OWNER TO motor;

--
-- Name: confirma_bono_mas_vida_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_mas_vida_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_mas_vida_seq OWNER TO motor;

--
-- Name: confirma_bono_mas_vida; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_mas_vida (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_mas_vida_seq'::regclass)
);


ALTER TABLE public.confirma_bono_mas_vida OWNER TO motor;

--
-- Name: confirma_bono_rio_blanco_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_rio_blanco_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_rio_blanco_seq OWNER TO motor;

--
-- Name: confirma_bono_rio_blanco; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_rio_blanco (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_rio_blanco_seq'::regclass)
);


ALTER TABLE public.confirma_bono_rio_blanco OWNER TO motor;

--
-- Name: confirma_bono_san_lorenzo_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_san_lorenzo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_san_lorenzo_seq OWNER TO motor;

--
-- Name: confirma_bono_san_lorenzo; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_san_lorenzo (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_san_lorenzo_seq'::regclass)
);


ALTER TABLE public.confirma_bono_san_lorenzo OWNER TO motor;

--
-- Name: confirma_bono_sm_cchc_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_sm_cchc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_sm_cchc_seq OWNER TO motor;

--
-- Name: confirma_bono_sm_cchc; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_sm_cchc (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_sm_cchc_seq'::regclass)
);


ALTER TABLE public.confirma_bono_sm_cchc OWNER TO motor;

--
-- Name: confirma_bono_vida_camara_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_vida_camara_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_vida_camara_seq OWNER TO motor;

--
-- Name: confirma_bono_vida_camara; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_vida_camara (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_vida_camara_seq'::regclass)
);


ALTER TABLE public.confirma_bono_vida_camara OWNER TO motor;

--
-- Name: confirma_bono_vida_tres_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_bono_vida_tres_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_bono_vida_tres_seq OWNER TO motor;

--
-- Name: confirma_bono_vida_tres; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_bono_vida_tres (
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    financiador integer,
    tx character varying,
    id bigint DEFAULT nextval('confirma_bono_vida_tres_seq'::regclass)
);


ALTER TABLE public.confirma_bono_vida_tres OWNER TO motor;

--
-- Name: confirma_camara; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_camara (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_camara OWNER TO motor;

--
-- Name: confirma_camara_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_camara_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_camara_id_seq OWNER TO motor;

--
-- Name: confirma_camara_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_camara_id_seq OWNED BY confirma_camara.id;


--
-- Name: confirma_chicon; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_chicon (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_chicon OWNER TO motor;

--
-- Name: confirma_chicon_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_chicon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_chicon_id_seq OWNER TO motor;

--
-- Name: confirma_chicon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_chicon_id_seq OWNED BY confirma_chicon.id;


--
-- Name: confirma_consorcio; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_consorcio (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_consorcio OWNER TO motor;

--
-- Name: confirma_consorcio_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_consorcio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_consorcio_id_seq OWNER TO motor;

--
-- Name: confirma_consorcio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_consorcio_id_seq OWNED BY confirma_consorcio.id;


--
-- Name: confirma_euroamerica; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_euroamerica (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_euroamerica OWNER TO motor;

--
-- Name: confirma_euroamerica_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_euroamerica_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_euroamerica_id_seq OWNER TO motor;

--
-- Name: confirma_euroamerica_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_euroamerica_id_seq OWNED BY confirma_euroamerica.id;


--
-- Name: confirma_far2; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_far2 (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_far2 OWNER TO motor;

--
-- Name: confirma_far2_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_far2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_far2_id_seq OWNER TO motor;

--
-- Name: confirma_far2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_far2_id_seq OWNED BY confirma_far2.id;


--
-- Name: confirma_imed; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_imed (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_imed OWNER TO motor;

--
-- Name: confirma_imed_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_imed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_imed_id_seq OWNER TO motor;

--
-- Name: confirma_imed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_imed_id_seq OWNED BY confirma_imed.id;


--
-- Name: confirma_ing; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_ing (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_ing OWNER TO motor;

--
-- Name: confirma_ing_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_ing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_ing_id_seq OWNER TO motor;

--
-- Name: confirma_ing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_ing_id_seq OWNED BY confirma_ing.id;


--
-- Name: confirma_integrafar; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_integrafar (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_integrafar OWNER TO motor;

--
-- Name: confirma_integrafar_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_integrafar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_integrafar_id_seq OWNER TO motor;

--
-- Name: confirma_integrafar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_integrafar_id_seq OWNED BY confirma_integrafar.id;


--
-- Name: confirma_inter; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_inter (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_inter OWNER TO motor;

--
-- Name: confirma_inter_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_inter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_inter_id_seq OWNER TO motor;

--
-- Name: confirma_inter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_inter_id_seq OWNED BY confirma_inter.id;


--
-- Name: confirma_metlife; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_metlife (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_metlife OWNER TO motor;

--
-- Name: confirma_metlife_cert; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_metlife_cert (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
);


ALTER TABLE public.confirma_metlife_cert OWNER TO motor;

--
-- Name: confirma_metlife_cert_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_metlife_cert_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_metlife_cert_id_seq OWNER TO motor;

--
-- Name: confirma_metlife_cert_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_metlife_cert_id_seq OWNED BY confirma_metlife_cert.id;


--
-- Name: confirma_metlife_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_metlife_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_metlife_id_seq OWNER TO motor;

--
-- Name: confirma_metlife_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_metlife_id_seq OWNED BY confirma_metlife.id;


--
-- Name: confirma_metlife_mpro; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_metlife_mpro (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
);


ALTER TABLE public.confirma_metlife_mpro OWNER TO motor;

--
-- Name: confirma_metlife_mpro_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_metlife_mpro_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_metlife_mpro_id_seq OWNER TO motor;

--
-- Name: confirma_metlife_mpro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_metlife_mpro_id_seq OWNED BY confirma_metlife_mpro.id;


--
-- Name: confirma_mpro2; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_mpro2 (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_mpro2 OWNER TO motor;

--
-- Name: confirma_mpro_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_mpro_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_mpro_id_seq OWNER TO motor;

--
-- Name: confirma_mpro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_mpro_id_seq OWNED BY confirma_mpro2.id;


--
-- Name: confirma_mprobci; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_mprobci (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_mprobci OWNER TO motor;

--
-- Name: confirma_mprobci_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_mprobci_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_mprobci_id_seq OWNER TO motor;

--
-- Name: confirma_mprobci_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_mprobci_id_seq OWNED BY confirma_mprobci.id;


--
-- Name: confirma_security; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_security (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_security OWNER TO motor;

--
-- Name: confirma_security_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_security_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_security_id_seq OWNER TO motor;

--
-- Name: confirma_security_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_security_id_seq OWNED BY confirma_security.id;


--
-- Name: confirma_sermecoop; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_sermecoop (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_sermecoop OWNER TO motor;

--
-- Name: confirma_sermecoop_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_sermecoop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_sermecoop_id_seq OWNER TO motor;

--
-- Name: confirma_sermecoop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_sermecoop_id_seq OWNED BY confirma_sermecoop.id;


--
-- Name: confirma_servmed; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_servmed (
    id integer,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_servmed OWNER TO motor;

--
-- Name: confirma_trasa; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_trasa (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_trasa OWNER TO motor;

--
-- Name: confirma_trasa2; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE confirma_trasa2 (
    id integer NOT NULL,
    fecha timestamp without time zone,
    estado character varying,
    reintentos integer,
    prioridad integer,
    xml_in character varying,
    codigo_cia character varying,
    tx character varying
)
INHERITS (confirma_generica);


ALTER TABLE public.confirma_trasa2 OWNER TO motor;

--
-- Name: confirma_trasa2_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_trasa2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_trasa2_id_seq OWNER TO motor;

--
-- Name: confirma_trasa2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_trasa2_id_seq OWNED BY confirma_trasa2.id;


--
-- Name: confirma_trasa_id_seq; Type: SEQUENCE; Schema: public; Owner: motor
--

CREATE SEQUENCE confirma_trasa_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirma_trasa_id_seq OWNER TO motor;

--
-- Name: confirma_trasa_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: motor
--

ALTER SEQUENCE confirma_trasa_id_seq OWNED BY confirma_trasa.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_bci ALTER COLUMN id SET DEFAULT nextval('confirma_bci_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_bice ALTER COLUMN id SET DEFAULT nextval('confirma_bice_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_camara ALTER COLUMN id SET DEFAULT nextval('confirma_camara_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_chicon ALTER COLUMN id SET DEFAULT nextval('confirma_chicon_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_consorcio ALTER COLUMN id SET DEFAULT nextval('confirma_consorcio_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_euroamerica ALTER COLUMN id SET DEFAULT nextval('confirma_euroamerica_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_far2 ALTER COLUMN id SET DEFAULT nextval('confirma_far2_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_imed ALTER COLUMN id SET DEFAULT nextval('confirma_imed_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_ing ALTER COLUMN id SET DEFAULT nextval('confirma_ing_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_integrafar ALTER COLUMN id SET DEFAULT nextval('confirma_integrafar_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_inter ALTER COLUMN id SET DEFAULT nextval('confirma_inter_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_metlife ALTER COLUMN id SET DEFAULT nextval('confirma_metlife_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_metlife_cert ALTER COLUMN id SET DEFAULT nextval('confirma_metlife_cert_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_metlife_mpro ALTER COLUMN id SET DEFAULT nextval('confirma_metlife_mpro_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_mpro2 ALTER COLUMN id SET DEFAULT nextval('confirma_mpro_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_mprobci ALTER COLUMN id SET DEFAULT nextval('confirma_mprobci_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_security ALTER COLUMN id SET DEFAULT nextval('confirma_security_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_sermecoop ALTER COLUMN id SET DEFAULT nextval('confirma_sermecoop_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_trasa ALTER COLUMN id SET DEFAULT nextval('confirma_trasa_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: motor
--

ALTER TABLE ONLY confirma_trasa2 ALTER COLUMN id SET DEFAULT nextval('confirma_trasa2_id_seq'::regclass);


--
-- Data for Name: confirma_bci; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bci_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bci_id_seq', 1, true);


--
-- Data for Name: confirma_bice; Type: TABLE DATA; Schema: public; Owner: motor
--

INSERT INTO confirma_bice VALUES (169103, '2014-09-05 17:53:41.165397', 'INGRESADO', 0, 0, 'CODIGO_MOTOR[7]=4780513###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[511]=POST-/Anulacion/cia_seg_bice
175341166*<29> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacion><ns1:XML_INPUT><MsgInput><extCodSeguro>28</extCodSeguro><extRutBeneficiario>0010877016-3</extRutBeneficiario><extFolioAuto>9038287</extFolioAuto><extFolioBono>50961503</extFolioBono></MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvAnulacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[8]=50961503###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0010877016-3###NUM_OPERACION[0]=###CODIGO_CIA[2]=28###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=29###CONTENT_LENGTH[3]=521###REQUEST_METHOD[4]=POST###REQUEST_URI[23]=/Anulacion/cia_seg_bice###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[23]=/Anulacion/cia_seg_bice###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.63###REMOTE_PORT[5]=49973###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=521###INPUT[922]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e32383c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e303031303837373031362d333c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e393033383238373c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e35303936313530333c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '28', 'Anulacion');


--
-- Name: confirma_bice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bice_id_seq', 169103, true);


--
-- Name: confirma_bono_; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_', 1, false);


--
-- Data for Name: confirma_bono_banmedica; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_banmedica_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_banmedica_id_seq', 3408, true);


--
-- Name: confirma_bono_banmedica_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_banmedica_seq', 2, true);


--
-- Data for Name: confirma_bono_chuquicamata; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_chuquicamata_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_chuquicamata_seq', 2, true);


--
-- Data for Name: confirma_bono_colmena; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_colmena_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_colmena_seq', 46, true);


--
-- Data for Name: confirma_bono_consalud; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_consalud_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_consalud_seq', 168, true);


--
-- Data for Name: confirma_bono_cruz_blanca; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_cruz_blanca_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_cruz_blanca_seq', 65, true);


--
-- Data for Name: confirma_bono_cruz_del_norte; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_cruz_del_norte_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_cruz_del_norte_seq', 1, false);


--
-- Data for Name: confirma_bono_ferrosalud; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_ferrosalud_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_ferrosalud_seq', 1, false);


--
-- Data for Name: confirma_bono_fonasa; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_fonasa_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_fonasa_seq', 437, true);


--
-- Data for Name: confirma_bono_fundacion; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_fundacion_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_fundacion_seq', 10, true);


--
-- Data for Name: confirma_bono_fusat; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_fusat_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_fusat_seq', 1, false);


--
-- Data for Name: confirma_bono_mas_vida; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_mas_vida_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_mas_vida_seq', 332, true);


--
-- Data for Name: confirma_bono_rio_blanco; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_rio_blanco_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_rio_blanco_seq', 1, false);


--
-- Data for Name: confirma_bono_san_lorenzo; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_san_lorenzo_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_san_lorenzo_seq', 1, false);


--
-- Data for Name: confirma_bono_sm_cchc; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_sm_cchc_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_sm_cchc_seq', 1, false);


--
-- Data for Name: confirma_bono_vida_camara; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_vida_camara_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_vida_camara_seq', 1, false);


--
-- Data for Name: confirma_bono_vida_tres; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_bono_vida_tres_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_bono_vida_tres_seq', 167, true);


--
-- Data for Name: confirma_camara; Type: TABLE DATA; Schema: public; Owner: motor
--

INSERT INTO confirma_camara VALUES (136982, '2014-08-18 10:45:48.518285', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3641031###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[258]=Falla Confirmacion de Sybase, se reintenta
174002248*<05> ID COLA=136982 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 218843835,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174002248*<05> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=218843835###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[25]=/Anulacion/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[25]=/Anulacion/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.64###REMOTE_PORT[5]=53322###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353837353531323c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3231383834333833353c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=136982###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-18 10:45:49.523383-04###INPUT_CIA[1834]=504f5354202f70726f64756363696f6e6d70726f2f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203730330a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b65787452757442656e65666963696172696f2667743b303030303030303030303030266c743b2f65787452757442656e65666963696172696f2667743b266c743b657874466f6c696f4175746f2667743b35383735353132266c743b2f657874466f6c696f4175746f2667743b266c743b657874466f6c696f426f6e6f2667743b323138383433383335266c743b2f657874466f6c696f426f6e6f2667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[239]=&lt;MsgInput&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extRutBeneficiario&gt;000000000000&lt;/extRutBeneficiario&gt;&lt;extFolioAuto&gt;5875512&lt;/extFolioAuto&gt;&lt;extFolioBono&gt;218843835&lt;/extFolioBono&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[704]=HTTP/1.1 200 OK
Date: Mon, 18 Aug 2014 14:45:15 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 483

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 218843835,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:02.248178-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:02.228064-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-18 10:45:49.566338-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###ERROR[36]=Adaptive Server connection timed out###API_DESCRIPCION_ERROR[36]=Adaptive Server connection timed out###API_ERROR[5]=20003###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '44', 'Anulacion');
INSERT INTO confirma_camara VALUES (141506, '2014-08-19 11:23:49.865834', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3727479###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[258]=Falla Confirmacion de Sybase, se reintenta
174002286*<05> ID COLA=141506 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 617596829,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174002286*<05> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=617596829###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[25]=/Anulacion/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[25]=/Anulacion/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.160###REMOTE_PORT[5]=51658###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353837393439303c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3631373539363832393c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=141506###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-19 11:23:50.516214-04###INPUT_CIA[1834]=504f5354202f70726f64756363696f6e6d70726f2f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203730330a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b65787452757442656e65666963696172696f2667743b303030303030303030303030266c743b2f65787452757442656e65666963696172696f2667743b266c743b657874466f6c696f4175746f2667743b35383739343930266c743b2f657874466f6c696f4175746f2667743b266c743b657874466f6c696f426f6e6f2667743b363137353936383239266c743b2f657874466f6c696f426f6e6f2667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[239]=&lt;MsgInput&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extRutBeneficiario&gt;000000000000&lt;/extRutBeneficiario&gt;&lt;extFolioAuto&gt;5879490&lt;/extFolioAuto&gt;&lt;extFolioBono&gt;617596829&lt;/extFolioBono&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[704]=HTTP/1.1 200 OK
Date: Tue, 19 Aug 2014 15:23:15 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 483

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 617596829,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:02.286195-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:02.261545-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[27]=2014-08-19 11:23:50.5432-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '44', 'Anulacion');
INSERT INTO confirma_camara VALUES (145565, '2014-08-20 11:33:38.054261', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3809521###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[257]=Falla Confirmacion de Sybase, se reintenta
174002342*<05> ID COLA=145565 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 50671369,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174002342*<05> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[8]=50671369###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=521###REQUEST_METHOD[4]=POST###REQUEST_URI[25]=/Anulacion/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[25]=/Anulacion/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.161###REMOTE_PORT[5]=55137###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=521###INPUT[922]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353838323534333c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e35303637313336393c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=145565###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-20 11:33:38.278782-04###INPUT_CIA[1832]=504f5354202f70726f64756363696f6e6d70726f2f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203730320a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b65787452757442656e65666963696172696f2667743b303030303030303030303030266c743b2f65787452757442656e65666963696172696f2667743b266c743b657874466f6c696f4175746f2667743b35383832353433266c743b2f657874466f6c696f4175746f2667743b266c743b657874466f6c696f426f6e6f2667743b3530363731333639266c743b2f657874466f6c696f426f6e6f2667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[238]=&lt;MsgInput&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extRutBeneficiario&gt;000000000000&lt;/extRutBeneficiario&gt;&lt;extFolioAuto&gt;5882543&lt;/extFolioAuto&gt;&lt;extFolioBono&gt;50671369&lt;/extFolioBono&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[704]=HTTP/1.1 200 OK
Date: Wed, 20 Aug 2014 15:33:03 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 483

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[127]=declare	@CodError tinyint execute CSConfirmaAnuU 50671369,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:02.341882-04###TIEMPO_INI_SYBASE[28]=2014-09-05 17:40:02.32208-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-20 11:33:38.339322-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '44', 'Anulacion');
INSERT INTO confirma_camara VALUES (147210, '2014-08-20 17:26:08.839279', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3869291###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[258]=Falla Confirmacion de Sybase, se reintenta
174002372*<05> ID COLA=147210 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 218973325,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174002372*<05> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=218973325###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[25]=/Anulacion/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[25]=/Anulacion/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.160###REMOTE_PORT[5]=58614###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353838343034383c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3231383937333332353c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=147210###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-20 17:26:12.815087-04###INPUT_CIA[1834]=504f5354202f70726f64756363696f6e6d70726f2f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203730330a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b65787452757442656e65666963696172696f2667743b303030303030303030303030266c743b2f65787452757442656e65666963696172696f2667743b266c743b657874466f6c696f4175746f2667743b35383834303438266c743b2f657874466f6c696f4175746f2667743b266c743b657874466f6c696f426f6e6f2667743b323138393733333235266c743b2f657874466f6c696f426f6e6f2667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[239]=&lt;MsgInput&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extRutBeneficiario&gt;000000000000&lt;/extRutBeneficiario&gt;&lt;extFolioAuto&gt;5884048&lt;/extFolioAuto&gt;&lt;extFolioBono&gt;218973325&lt;/extFolioBono&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[17]=FALLA_CONEXION_BD###RESPUESTA_CIA[704]=HTTP/1.1 200 OK
Date: Wed, 20 Aug 2014 21:25:37 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 483

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 218973325,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:02.372688-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:02.359928-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-20 17:26:12.974914-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '44', 'Anulacion');
INSERT INTO confirma_camara VALUES (152668, '2014-08-22 10:09:10.306077', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3965301###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[258]=Falla Confirmacion de Sybase, se reintenta
174002410*<05> ID COLA=152668 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 617800979,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174002410*<05> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=617800979###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[25]=/Anulacion/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[25]=/Anulacion/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.63###REMOTE_PORT[5]=39513###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353838383433333c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3631373830303937393c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=152668###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-22 10:09:13.256485-04###INPUT_CIA[1834]=504f5354202f70726f64756363696f6e6d70726f2f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203730330a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b65787452757442656e65666963696172696f2667743b303030303030303030303030266c743b2f65787452757442656e65666963696172696f2667743b266c743b657874466f6c696f4175746f2667743b35383838343333266c743b2f657874466f6c696f4175746f2667743b266c743b657874466f6c696f426f6e6f2667743b363137383030393739266c743b2f657874466f6c696f426f6e6f2667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[239]=&lt;MsgInput&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extRutBeneficiario&gt;000000000000&lt;/extRutBeneficiario&gt;&lt;extFolioAuto&gt;5888433&lt;/extFolioAuto&gt;&lt;extFolioBono&gt;617800979&lt;/extFolioBono&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[2]=OK###RESPUESTA_CIA[704]=HTTP/1.1 200 OK
Date: Fri, 22 Aug 2014 14:08:37 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 483

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 617800979,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:02.410196-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:02.393725-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-22 10:09:13.344043-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '44', 'Anulacion');
INSERT INTO confirma_camara VALUES (152671, '2014-08-22 10:09:15.662573', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3965311###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[258]=Falla Confirmacion de Sybase, se reintenta
174002425*<05> ID COLA=152671 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 617800980,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174002425*<05> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=617800980###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[25]=/Anulacion/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[25]=/Anulacion/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.63###REMOTE_PORT[5]=39746###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353838383433333c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3631373830303938303c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=152671###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-22 10:09:17.818611-04###INPUT_CIA[1834]=504f5354202f70726f64756363696f6e6d70726f2f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203730330a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b65787452757442656e65666963696172696f2667743b303030303030303030303030266c743b2f65787452757442656e65666963696172696f2667743b266c743b657874466f6c696f4175746f2667743b35383838343333266c743b2f657874466f6c696f4175746f2667743b266c743b657874466f6c696f426f6e6f2667743b363137383030393830266c743b2f657874466f6c696f426f6e6f2667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[239]=&lt;MsgInput&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extRutBeneficiario&gt;000000000000&lt;/extRutBeneficiario&gt;&lt;extFolioAuto&gt;5888433&lt;/extFolioAuto&gt;&lt;extFolioBono&gt;617800980&lt;/extFolioBono&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[2]=OK###RESPUESTA_CIA[704]=HTTP/1.1 200 OK
Date: Fri, 22 Aug 2014 14:08:41 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 483

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 617800980,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:02.425683-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:02.419013-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[28]=2014-08-22 10:09:17.84698-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '44', 'Anulacion');
INSERT INTO confirma_camara VALUES (153198, '2014-08-22 11:29:59.461467', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3973561###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[167]=Falla Confirmacion de Sybase, se reintenta
174002432*<05> ID COLA=153198 SQL=call CSConfirmaSegU(719697005,71,5888392)
174002432*<05> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=719697005###EXTFOLIOAUTO[7]=5888392###EXTRUTBENEFICIARIO[12]=0019175330-5###NUM_OPERACION[8]=39468008###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=945###REQUEST_METHOD[4]=POST###REQUEST_URI[33]=/ConfirmacionBono3/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###DOCUMENT_URI[33]=/ConfirmacionBono3/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[11]=172.16.8.72###REMOTE_PORT[5]=65300###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_ACCEPT_ENCODING[12]=gzip,deflate###HTTP_CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_USER_AGENT[30]=Jakarta Commons-HttpClient/3.1###HTTP_HOST[12]=10.100.32.52###HTTP_CONTENT_LENGTH[3]=945###INPUT[1890]=3c736f61703a456e76656c6f706520786d6c6e733a736f61703d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f70652220786d6c6e733a74656d3d22687474703a2f2f74656d707572692e6f72672f223e0d0a2020203c736f61703a4865616465722f3e0d0a2020203c736f61703a426f64793e0d0a2020202020203c74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020202020202020203c212d2d4f7074696f6e616c3a2d2d3e0d0a2020202020202020203c74656d3a584d4c5f494e5055543e0a3c4d7367496e7075743e0a093c657874436f6446696e616e636961646f723e37313c2f657874436f6446696e616e636961646f723e0a093c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e0a093c657874436f644c756761723e31303030333c2f657874436f644c756761723e0a093c657874466f6c696f426f6e6f3e3731393639373030353c2f657874466f6c696f426f6e6f3e0a093c6578744e756d4f7065726163696f6e3e33393436383030383c2f6578744e756d4f7065726163696f6e3e0a093c4578744d746f546f743e31303036323c2f4578744d746f546f743e0a093c4578744d746f436f7061676f3e323030303c2f4578744d746f436f7061676f3e0a093c4578744d746f426f6e69663e313430303c2f4578744d746f426f6e69663e0a093c6578744665636861456d6973696f6e3e32303134303832323c2f6578744665636861456d6973696f6e3e0a093c65787452757442656e65666963696172696f3e303031393137353333302d353c2f65787452757442656e65666963696172696f3e0a093c65787452757443616a65726f3e303031383238383332372d313c2f65787452757443616a65726f3e0a093c657874527574507265737461646f723e303039363934323430302d323c2f657874527574507265737461646f723e0a093c657874527574456d69736f723e303031383238383332372d313c2f657874527574456d69736f723e0a093c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e0a09203c2f74656d3a584d4c5f494e5055543e0d0a2020202020203c2f74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020203c2f736f61703a426f64793e0d0a3c2f736f61703a456e76656c6f70653e###STATUS[5]=FALLA###TX[4]=4001###__ID_DTE__[6]=153198###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[6]=ERR_NK###TIEMPO_INI_CIA[29]=2014-08-22 11:40:10.602892-04###INPUT_CIA[2942]=504f5354202f70726f64756363696f6e6d70726f2f636f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313235300a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6446696e616e636961646f722667743b3731266c743b2f657874436f6446696e616e636961646f722667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b657874436f644c756761722667743b3130303033266c743b2f657874436f644c756761722667743b266c743b657874466f6c696f426f6e6f2667743b373139363937303035266c743b2f657874466f6c696f426f6e6f2667743b266c743b6578744e756d4f7065726163696f6e2667743b3339343638303038266c743b2f6578744e756d4f7065726163696f6e2667743b266c743b4578744d746f546f742667743b3130303632266c743b2f4578744d746f546f742667743b266c743b4578744d746f436f7061676f2667743b32303030266c743b2f4578744d746f436f7061676f2667743b266c743b4578744d746f426f6e69662667743b31343030266c743b2f4578744d746f426f6e69662667743b266c743b6578744665636861456d6973696f6e2667743b3230313430383232266c743b2f6578744665636861456d6973696f6e2667743b266c743b65787452757442656e65666963696172696f2667743b303031393137353333302d35266c743b2f65787452757442656e65666963696172696f2667743b266c743b65787452757443616a65726f2667743b303031383238383332372d31266c743b2f65787452757443616a65726f2667743b266c743b657874527574507265737461646f722667743b303039363934323430302d32266c743b2f657874527574507265737461646f722667743b266c743b657874527574456d69736f722667743b303031383238383332372d31266c743b2f657874527574456d69736f722667743b266c743b6578744c697350726573742667743b303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c266c743b2f6578744c697350726573742667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[780]=&lt;MsgInput&gt;&lt;extCodFinanciador&gt;71&lt;/extCodFinanciador&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extCodLugar&gt;10003&lt;/extCodLugar&gt;&lt;extFolioBono&gt;719697005&lt;/extFolioBono&gt;&lt;extNumOperacion&gt;39468008&lt;/extNumOperacion&gt;&lt;ExtMtoTot&gt;10062&lt;/ExtMtoTot&gt;&lt;ExtMtoCopago&gt;2000&lt;/ExtMtoCopago&gt;&lt;ExtMtoBonif&gt;1400&lt;/ExtMtoBonif&gt;&lt;extFechaEmision&gt;20140822&lt;/extFechaEmision&gt;&lt;extRutBeneficiario&gt;0019175330-5&lt;/extRutBeneficiario&gt;&lt;extRutCajero&gt;0018288327-1&lt;/extRutCajero&gt;&lt;extRutPrestador&gt;0096942400-2&lt;/extRutPrestador&gt;&lt;extRutEmisor&gt;0018288327-1&lt;/extRutEmisor&gt;&lt;extLisPrest&gt;0101001   |00|01|0000010062|0000002000|0000001400|&lt;/extLisPrest&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[17]=ConfirmacionBono3###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[17]=FALLA_CONEXION_BD###RESPUESTA_CIA[752]=HTTP/1.1 200 OK
Date: Fri, 22 Aug 2014 15:39:34 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 531

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult><MsgOutput xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[41]=call CSConfirmaSegU(719697005,71,5888392)###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:02.432258-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:02.428778-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[213]= xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-22 11:40:10.622979-04###API_CODRESPUESTA[1]=2###API_TIPO[3]=SQL###ERROR[60]=General SQL Server error: Check messages from the SQL Server###API_DESCRIPCION_ERROR[60]=General SQL Server error: Check messages from the SQL Server###API_ERROR[3]=102###API_DESCRIPCION_MSG[35]=Incorrect syntax near <C>719697005<C>.
###__XML__[0]=###', '44', 'ConfirmacionBono3');
INSERT INTO confirma_camara VALUES (153211, '2014-08-22 11:33:05.44327', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3973845###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[167]=Falla Confirmacion de Sybase, se reintenta
174002439*<05> ID COLA=153211 SQL=call CSConfirmaSegU(719697005,71,5888392)
174002439*<05> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=719697005###EXTFOLIOAUTO[7]=5888392###EXTRUTBENEFICIARIO[12]=0019175330-5###NUM_OPERACION[8]=39468008###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=945###REQUEST_METHOD[4]=POST###REQUEST_URI[33]=/ConfirmacionBono3/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###DOCUMENT_URI[33]=/ConfirmacionBono3/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[11]=172.16.8.72###REMOTE_PORT[5]=65306###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_ACCEPT_ENCODING[12]=gzip,deflate###HTTP_CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_USER_AGENT[30]=Jakarta Commons-HttpClient/3.1###HTTP_HOST[12]=10.100.32.52###HTTP_CONTENT_LENGTH[3]=945###INPUT[1890]=3c736f61703a456e76656c6f706520786d6c6e733a736f61703d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f70652220786d6c6e733a74656d3d22687474703a2f2f74656d707572692e6f72672f223e0d0a2020203c736f61703a4865616465722f3e0d0a2020203c736f61703a426f64793e0d0a2020202020203c74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020202020202020203c212d2d4f7074696f6e616c3a2d2d3e0d0a2020202020202020203c74656d3a584d4c5f494e5055543e0a3c4d7367496e7075743e0a093c657874436f6446696e616e636961646f723e37313c2f657874436f6446696e616e636961646f723e0a093c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e0a093c657874436f644c756761723e31303030333c2f657874436f644c756761723e0a093c657874466f6c696f426f6e6f3e3731393639373030353c2f657874466f6c696f426f6e6f3e0a093c6578744e756d4f7065726163696f6e3e33393436383030383c2f6578744e756d4f7065726163696f6e3e0a093c4578744d746f546f743e31303036323c2f4578744d746f546f743e0a093c4578744d746f436f7061676f3e323030303c2f4578744d746f436f7061676f3e0a093c4578744d746f426f6e69663e313430303c2f4578744d746f426f6e69663e0a093c6578744665636861456d6973696f6e3e32303134303832323c2f6578744665636861456d6973696f6e3e0a093c65787452757442656e65666963696172696f3e303031393137353333302d353c2f65787452757442656e65666963696172696f3e0a093c65787452757443616a65726f3e303031383238383332372d313c2f65787452757443616a65726f3e0a093c657874527574507265737461646f723e303039363934323430302d323c2f657874527574507265737461646f723e0a093c657874527574456d69736f723e303031383238383332372d313c2f657874527574456d69736f723e0a093c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e0a09203c2f74656d3a584d4c5f494e5055543e0d0a2020202020203c2f74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020203c2f736f61703a426f64793e0d0a3c2f736f61703a456e76656c6f70653e###STATUS[5]=FALLA###TX[4]=4001###__ID_DTE__[6]=153211###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[6]=ERR_NK###TIEMPO_INI_CIA[29]=2014-08-22 11:33:07.417007-04###INPUT_CIA[2942]=504f5354202f70726f64756363696f6e6d70726f2f636f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313235300a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6446696e616e636961646f722667743b3731266c743b2f657874436f6446696e616e636961646f722667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b657874436f644c756761722667743b3130303033266c743b2f657874436f644c756761722667743b266c743b657874466f6c696f426f6e6f2667743b373139363937303035266c743b2f657874466f6c696f426f6e6f2667743b266c743b6578744e756d4f7065726163696f6e2667743b3339343638303038266c743b2f6578744e756d4f7065726163696f6e2667743b266c743b4578744d746f546f742667743b3130303632266c743b2f4578744d746f546f742667743b266c743b4578744d746f436f7061676f2667743b32303030266c743b2f4578744d746f436f7061676f2667743b266c743b4578744d746f426f6e69662667743b31343030266c743b2f4578744d746f426f6e69662667743b266c743b6578744665636861456d6973696f6e2667743b3230313430383232266c743b2f6578744665636861456d6973696f6e2667743b266c743b65787452757442656e65666963696172696f2667743b303031393137353333302d35266c743b2f65787452757442656e65666963696172696f2667743b266c743b65787452757443616a65726f2667743b303031383238383332372d31266c743b2f65787452757443616a65726f2667743b266c743b657874527574507265737461646f722667743b303039363934323430302d32266c743b2f657874527574507265737461646f722667743b266c743b657874527574456d69736f722667743b303031383238383332372d31266c743b2f657874527574456d69736f722667743b266c743b6578744c697350726573742667743b303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c266c743b2f6578744c697350726573742667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[780]=&lt;MsgInput&gt;&lt;extCodFinanciador&gt;71&lt;/extCodFinanciador&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extCodLugar&gt;10003&lt;/extCodLugar&gt;&lt;extFolioBono&gt;719697005&lt;/extFolioBono&gt;&lt;extNumOperacion&gt;39468008&lt;/extNumOperacion&gt;&lt;ExtMtoTot&gt;10062&lt;/ExtMtoTot&gt;&lt;ExtMtoCopago&gt;2000&lt;/ExtMtoCopago&gt;&lt;ExtMtoBonif&gt;1400&lt;/ExtMtoBonif&gt;&lt;extFechaEmision&gt;20140822&lt;/extFechaEmision&gt;&lt;extRutBeneficiario&gt;0019175330-5&lt;/extRutBeneficiario&gt;&lt;extRutCajero&gt;0018288327-1&lt;/extRutCajero&gt;&lt;extRutPrestador&gt;0096942400-2&lt;/extRutPrestador&gt;&lt;extRutEmisor&gt;0018288327-1&lt;/extRutEmisor&gt;&lt;extLisPrest&gt;0101001   |00|01|0000010062|0000002000|0000001400|&lt;/extLisPrest&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[17]=ConfirmacionBono3###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[2]=OK###RESPUESTA_CIA[752]=HTTP/1.1 200 OK
Date: Fri, 22 Aug 2014 15:32:31 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 531

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult><MsgOutput xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[41]=call CSConfirmaSegU(719697005,71,5888392)###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:02.438948-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:02.435575-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[213]= xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-22 11:33:07.488328-04###API_CODRESPUESTA[1]=2###API_TIPO[3]=SQL###ERROR[60]=General SQL Server error: Check messages from the SQL Server###API_DESCRIPCION_ERROR[60]=General SQL Server error: Check messages from the SQL Server###API_ERROR[3]=102###API_DESCRIPCION_MSG[35]=Incorrect syntax near <C>719697005<C>.
###__XML__[0]=###', '44', 'ConfirmacionBono3');
INSERT INTO confirma_camara VALUES (153239, '2014-08-22 11:38:29.03823', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3974274###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[167]=Falla Confirmacion de Sybase, se reintenta
174002445*<05> ID COLA=153239 SQL=call CSConfirmaSegU(719697005,71,5888392)
174002445*<05> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=719697005###EXTFOLIOAUTO[7]=5888392###EXTRUTBENEFICIARIO[12]=0019175330-5###NUM_OPERACION[8]=39468008###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=945###REQUEST_METHOD[4]=POST###REQUEST_URI[33]=/ConfirmacionBono3/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###DOCUMENT_URI[33]=/ConfirmacionBono3/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[11]=172.16.8.72###REMOTE_PORT[5]=65317###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_ACCEPT_ENCODING[12]=gzip,deflate###HTTP_CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_USER_AGENT[30]=Jakarta Commons-HttpClient/3.1###HTTP_HOST[12]=10.100.32.52###HTTP_CONTENT_LENGTH[3]=945###INPUT[1890]=3c736f61703a456e76656c6f706520786d6c6e733a736f61703d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f70652220786d6c6e733a74656d3d22687474703a2f2f74656d707572692e6f72672f223e0d0a2020203c736f61703a4865616465722f3e0d0a2020203c736f61703a426f64793e0d0a2020202020203c74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020202020202020203c212d2d4f7074696f6e616c3a2d2d3e0d0a2020202020202020203c74656d3a584d4c5f494e5055543e0a3c4d7367496e7075743e0a093c657874436f6446696e616e636961646f723e37313c2f657874436f6446696e616e636961646f723e0a093c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e0a093c657874436f644c756761723e31303030333c2f657874436f644c756761723e0a093c657874466f6c696f426f6e6f3e3731393639373030353c2f657874466f6c696f426f6e6f3e0a093c6578744e756d4f7065726163696f6e3e33393436383030383c2f6578744e756d4f7065726163696f6e3e0a093c4578744d746f546f743e31303036323c2f4578744d746f546f743e0a093c4578744d746f436f7061676f3e323030303c2f4578744d746f436f7061676f3e0a093c4578744d746f426f6e69663e313430303c2f4578744d746f426f6e69663e0a093c6578744665636861456d6973696f6e3e32303134303832323c2f6578744665636861456d6973696f6e3e0a093c65787452757442656e65666963696172696f3e303031393137353333302d353c2f65787452757442656e65666963696172696f3e0a093c65787452757443616a65726f3e303031383238383332372d313c2f65787452757443616a65726f3e0a093c657874527574507265737461646f723e303039363934323430302d323c2f657874527574507265737461646f723e0a093c657874527574456d69736f723e303031383238383332372d313c2f657874527574456d69736f723e0a093c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e0a09203c2f74656d3a584d4c5f494e5055543e0d0a2020202020203c2f74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020203c2f736f61703a426f64793e0d0a3c2f736f61703a456e76656c6f70653e###STATUS[5]=FALLA###TX[4]=4001###__ID_DTE__[6]=153239###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[6]=ERR_NK###TIEMPO_INI_CIA[29]=2014-08-22 11:38:31.504889-04###INPUT_CIA[2942]=504f5354202f70726f64756363696f6e6d70726f2f636f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313235300a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6446696e616e636961646f722667743b3731266c743b2f657874436f6446696e616e636961646f722667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b657874436f644c756761722667743b3130303033266c743b2f657874436f644c756761722667743b266c743b657874466f6c696f426f6e6f2667743b373139363937303035266c743b2f657874466f6c696f426f6e6f2667743b266c743b6578744e756d4f7065726163696f6e2667743b3339343638303038266c743b2f6578744e756d4f7065726163696f6e2667743b266c743b4578744d746f546f742667743b3130303632266c743b2f4578744d746f546f742667743b266c743b4578744d746f436f7061676f2667743b32303030266c743b2f4578744d746f436f7061676f2667743b266c743b4578744d746f426f6e69662667743b31343030266c743b2f4578744d746f426f6e69662667743b266c743b6578744665636861456d6973696f6e2667743b3230313430383232266c743b2f6578744665636861456d6973696f6e2667743b266c743b65787452757442656e65666963696172696f2667743b303031393137353333302d35266c743b2f65787452757442656e65666963696172696f2667743b266c743b65787452757443616a65726f2667743b303031383238383332372d31266c743b2f65787452757443616a65726f2667743b266c743b657874527574507265737461646f722667743b303039363934323430302d32266c743b2f657874527574507265737461646f722667743b266c743b657874527574456d69736f722667743b303031383238383332372d31266c743b2f657874527574456d69736f722667743b266c743b6578744c697350726573742667743b303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c266c743b2f6578744c697350726573742667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[780]=&lt;MsgInput&gt;&lt;extCodFinanciador&gt;71&lt;/extCodFinanciador&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extCodLugar&gt;10003&lt;/extCodLugar&gt;&lt;extFolioBono&gt;719697005&lt;/extFolioBono&gt;&lt;extNumOperacion&gt;39468008&lt;/extNumOperacion&gt;&lt;ExtMtoTot&gt;10062&lt;/ExtMtoTot&gt;&lt;ExtMtoCopago&gt;2000&lt;/ExtMtoCopago&gt;&lt;ExtMtoBonif&gt;1400&lt;/ExtMtoBonif&gt;&lt;extFechaEmision&gt;20140822&lt;/extFechaEmision&gt;&lt;extRutBeneficiario&gt;0019175330-5&lt;/extRutBeneficiario&gt;&lt;extRutCajero&gt;0018288327-1&lt;/extRutCajero&gt;&lt;extRutPrestador&gt;0096942400-2&lt;/extRutPrestador&gt;&lt;extRutEmisor&gt;0018288327-1&lt;/extRutEmisor&gt;&lt;extLisPrest&gt;0101001   |00|01|0000010062|0000002000|0000001400|&lt;/extLisPrest&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[17]=ConfirmacionBono3###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[17]=FALLA_CONEXION_BD###RESPUESTA_CIA[752]=HTTP/1.1 200 OK
Date: Fri, 22 Aug 2014 15:37:55 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 531

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult><MsgOutput xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[41]=call CSConfirmaSegU(719697005,71,5888392)###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:02.444961-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:02.442186-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[213]= xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-22 11:38:31.530562-04###API_CODRESPUESTA[1]=2###API_TIPO[3]=SQL###ERROR[60]=General SQL Server error: Check messages from the SQL Server###API_DESCRIPCION_ERROR[60]=General SQL Server error: Check messages from the SQL Server###API_ERROR[3]=102###API_DESCRIPCION_MSG[35]=Incorrect syntax near <C>719697005<C>.
###__XML__[0]=###', '44', 'ConfirmacionBono3');
INSERT INTO confirma_camara VALUES (153256, '2014-08-22 11:42:42.584343', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3974591###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[167]=Falla Confirmacion de Sybase, se reintenta
174002450*<05> ID COLA=153256 SQL=call CSConfirmaSegU(719697005,71,5888392)
174002451*<05> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=719697005###EXTFOLIOAUTO[7]=5888392###EXTRUTBENEFICIARIO[12]=0019175330-5###NUM_OPERACION[8]=39468008###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=945###REQUEST_METHOD[4]=POST###REQUEST_URI[33]=/ConfirmacionBono3/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###DOCUMENT_URI[33]=/ConfirmacionBono3/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[11]=172.16.8.72###REMOTE_PORT[5]=65324###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_ACCEPT_ENCODING[12]=gzip,deflate###HTTP_CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_USER_AGENT[30]=Jakarta Commons-HttpClient/3.1###HTTP_HOST[12]=10.100.32.52###HTTP_CONTENT_LENGTH[3]=945###INPUT[1890]=3c736f61703a456e76656c6f706520786d6c6e733a736f61703d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f70652220786d6c6e733a74656d3d22687474703a2f2f74656d707572692e6f72672f223e0d0a2020203c736f61703a4865616465722f3e0d0a2020203c736f61703a426f64793e0d0a2020202020203c74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020202020202020203c212d2d4f7074696f6e616c3a2d2d3e0d0a2020202020202020203c74656d3a584d4c5f494e5055543e0a3c4d7367496e7075743e0a093c657874436f6446696e616e636961646f723e37313c2f657874436f6446696e616e636961646f723e0a093c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e0a093c657874436f644c756761723e31303030333c2f657874436f644c756761723e0a093c657874466f6c696f426f6e6f3e3731393639373030353c2f657874466f6c696f426f6e6f3e0a093c6578744e756d4f7065726163696f6e3e33393436383030383c2f6578744e756d4f7065726163696f6e3e0a093c4578744d746f546f743e31303036323c2f4578744d746f546f743e0a093c4578744d746f436f7061676f3e323030303c2f4578744d746f436f7061676f3e0a093c4578744d746f426f6e69663e313430303c2f4578744d746f426f6e69663e0a093c6578744665636861456d6973696f6e3e32303134303832323c2f6578744665636861456d6973696f6e3e0a093c65787452757442656e65666963696172696f3e303031393137353333302d353c2f65787452757442656e65666963696172696f3e0a093c65787452757443616a65726f3e303031383238383332372d313c2f65787452757443616a65726f3e0a093c657874527574507265737461646f723e303039363934323430302d323c2f657874527574507265737461646f723e0a093c657874527574456d69736f723e303031383238383332372d313c2f657874527574456d69736f723e0a093c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e0a09203c2f74656d3a584d4c5f494e5055543e0d0a2020202020203c2f74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020203c2f736f61703a426f64793e0d0a3c2f736f61703a456e76656c6f70653e###STATUS[5]=FALLA###TX[4]=4001###__ID_DTE__[6]=153256###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[6]=ERR_NK###TIEMPO_INI_CIA[29]=2014-08-22 11:42:47.575594-04###INPUT_CIA[2942]=504f5354202f70726f64756363696f6e6d70726f2f636f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313235300a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6446696e616e636961646f722667743b3731266c743b2f657874436f6446696e616e636961646f722667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b657874436f644c756761722667743b3130303033266c743b2f657874436f644c756761722667743b266c743b657874466f6c696f426f6e6f2667743b373139363937303035266c743b2f657874466f6c696f426f6e6f2667743b266c743b6578744e756d4f7065726163696f6e2667743b3339343638303038266c743b2f6578744e756d4f7065726163696f6e2667743b266c743b4578744d746f546f742667743b3130303632266c743b2f4578744d746f546f742667743b266c743b4578744d746f436f7061676f2667743b32303030266c743b2f4578744d746f436f7061676f2667743b266c743b4578744d746f426f6e69662667743b31343030266c743b2f4578744d746f426f6e69662667743b266c743b6578744665636861456d6973696f6e2667743b3230313430383232266c743b2f6578744665636861456d6973696f6e2667743b266c743b65787452757442656e65666963696172696f2667743b303031393137353333302d35266c743b2f65787452757442656e65666963696172696f2667743b266c743b65787452757443616a65726f2667743b303031383238383332372d31266c743b2f65787452757443616a65726f2667743b266c743b657874527574507265737461646f722667743b303039363934323430302d32266c743b2f657874527574507265737461646f722667743b266c743b657874527574456d69736f722667743b303031383238383332372d31266c743b2f657874527574456d69736f722667743b266c743b6578744c697350726573742667743b303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c266c743b2f6578744c697350726573742667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[780]=&lt;MsgInput&gt;&lt;extCodFinanciador&gt;71&lt;/extCodFinanciador&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extCodLugar&gt;10003&lt;/extCodLugar&gt;&lt;extFolioBono&gt;719697005&lt;/extFolioBono&gt;&lt;extNumOperacion&gt;39468008&lt;/extNumOperacion&gt;&lt;ExtMtoTot&gt;10062&lt;/ExtMtoTot&gt;&lt;ExtMtoCopago&gt;2000&lt;/ExtMtoCopago&gt;&lt;ExtMtoBonif&gt;1400&lt;/ExtMtoBonif&gt;&lt;extFechaEmision&gt;20140822&lt;/extFechaEmision&gt;&lt;extRutBeneficiario&gt;0019175330-5&lt;/extRutBeneficiario&gt;&lt;extRutCajero&gt;0018288327-1&lt;/extRutCajero&gt;&lt;extRutPrestador&gt;0096942400-2&lt;/extRutPrestador&gt;&lt;extRutEmisor&gt;0018288327-1&lt;/extRutEmisor&gt;&lt;extLisPrest&gt;0101001   |00|01|0000010062|0000002000|0000001400|&lt;/extLisPrest&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[17]=ConfirmacionBono3###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[17]=FALLA_CONEXION_BD###RESPUESTA_CIA[752]=HTTP/1.1 200 OK
Date: Fri, 22 Aug 2014 15:42:11 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 531

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult><MsgOutput xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[41]=call CSConfirmaSegU(719697005,71,5888392)###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:02.450808-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:02.448311-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[213]= xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-22 11:42:47.596917-04###API_CODRESPUESTA[1]=2###API_TIPO[3]=SQL###ERROR[60]=General SQL Server error: Check messages from the SQL Server###API_DESCRIPCION_ERROR[60]=General SQL Server error: Check messages from the SQL Server###API_ERROR[3]=102###API_DESCRIPCION_MSG[35]=Incorrect syntax near <C>719697005<C>.
###__XML__[0]=###', '44', 'ConfirmacionBono3');
INSERT INTO confirma_camara VALUES (153288, '2014-08-22 11:51:41.888706', 'SOLO_PERCONA', 5, 0, 'ESTADO_PERCONA[12]=SOLO_PERCONA###CODIGO_MOTOR[7]=3975284###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[169]=Falla Confirmacion de Percona, se reintenta
174004549*<05> ID COLA=153288 SQL=call CSConfirmaSegU(719697005,71,5888392)
174004549*<05> Aumenta Reintentos y falla percona###EXTFOLIOBONO[9]=719697005###EXTFOLIOAUTO[7]=5888392###EXTRUTBENEFICIARIO[12]=0019175330-5###NUM_OPERACION[8]=39468008###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=945###REQUEST_METHOD[4]=POST###REQUEST_URI[33]=/ConfirmacionBono3/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###DOCUMENT_URI[33]=/ConfirmacionBono3/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[11]=172.16.8.72###REMOTE_PORT[5]=65338###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_ACCEPT_ENCODING[12]=gzip,deflate###HTTP_CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_USER_AGENT[30]=Jakarta Commons-HttpClient/3.1###HTTP_HOST[12]=10.100.32.52###HTTP_CONTENT_LENGTH[3]=945###INPUT[1890]=3c736f61703a456e76656c6f706520786d6c6e733a736f61703d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f70652220786d6c6e733a74656d3d22687474703a2f2f74656d707572692e6f72672f223e0d0a2020203c736f61703a4865616465722f3e0d0a2020203c736f61703a426f64793e0d0a2020202020203c74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020202020202020203c212d2d4f7074696f6e616c3a2d2d3e0d0a2020202020202020203c74656d3a584d4c5f494e5055543e0a3c4d7367496e7075743e0a093c657874436f6446696e616e636961646f723e37313c2f657874436f6446696e616e636961646f723e0a093c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e0a093c657874436f644c756761723e31303030333c2f657874436f644c756761723e0a093c657874466f6c696f426f6e6f3e3731393639373030353c2f657874466f6c696f426f6e6f3e0a093c6578744e756d4f7065726163696f6e3e33393436383030383c2f6578744e756d4f7065726163696f6e3e0a093c4578744d746f546f743e31303036323c2f4578744d746f546f743e0a093c4578744d746f436f7061676f3e323030303c2f4578744d746f436f7061676f3e0a093c4578744d746f426f6e69663e313430303c2f4578744d746f426f6e69663e0a093c6578744665636861456d6973696f6e3e32303134303832323c2f6578744665636861456d6973696f6e3e0a093c65787452757442656e65666963696172696f3e303031393137353333302d353c2f65787452757442656e65666963696172696f3e0a093c65787452757443616a65726f3e303031383238383332372d313c2f65787452757443616a65726f3e0a093c657874527574507265737461646f723e303039363934323430302d323c2f657874527574507265737461646f723e0a093c657874527574456d69736f723e303031383238383332372d313c2f657874527574456d69736f723e0a093c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e0a09203c2f74656d3a584d4c5f494e5055543e0d0a2020202020203c2f74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020203c2f736f61703a426f64793e0d0a3c2f736f61703a456e76656c6f70653e###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=153288###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-22 11:51:55.977423-04###INPUT_CIA[2942]=504f5354202f70726f64756363696f6e6d70726f2f636f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313235300a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6446696e616e636961646f722667743b3731266c743b2f657874436f6446696e616e636961646f722667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b657874436f644c756761722667743b3130303033266c743b2f657874436f644c756761722667743b266c743b657874466f6c696f426f6e6f2667743b373139363937303035266c743b2f657874466f6c696f426f6e6f2667743b266c743b6578744e756d4f7065726163696f6e2667743b3339343638303038266c743b2f6578744e756d4f7065726163696f6e2667743b266c743b4578744d746f546f742667743b3130303632266c743b2f4578744d746f546f742667743b266c743b4578744d746f436f7061676f2667743b32303030266c743b2f4578744d746f436f7061676f2667743b266c743b4578744d746f426f6e69662667743b31343030266c743b2f4578744d746f426f6e69662667743b266c743b6578744665636861456d6973696f6e2667743b3230313430383232266c743b2f6578744665636861456d6973696f6e2667743b266c743b65787452757442656e65666963696172696f2667743b303031393137353333302d35266c743b2f65787452757442656e65666963696172696f2667743b266c743b65787452757443616a65726f2667743b303031383238383332372d31266c743b2f65787452757443616a65726f2667743b266c743b657874527574507265737461646f722667743b303039363934323430302d32266c743b2f657874527574507265737461646f722667743b266c743b657874527574456d69736f722667743b303031383238383332372d31266c743b2f657874527574456d69736f722667743b266c743b6578744c697350726573742667743b303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c266c743b2f6578744c697350726573742667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[780]=&lt;MsgInput&gt;&lt;extCodFinanciador&gt;71&lt;/extCodFinanciador&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extCodLugar&gt;10003&lt;/extCodLugar&gt;&lt;extFolioBono&gt;719697005&lt;/extFolioBono&gt;&lt;extNumOperacion&gt;39468008&lt;/extNumOperacion&gt;&lt;ExtMtoTot&gt;10062&lt;/ExtMtoTot&gt;&lt;ExtMtoCopago&gt;2000&lt;/ExtMtoCopago&gt;&lt;ExtMtoBonif&gt;1400&lt;/ExtMtoBonif&gt;&lt;extFechaEmision&gt;20140822&lt;/extFechaEmision&gt;&lt;extRutBeneficiario&gt;0019175330-5&lt;/extRutBeneficiario&gt;&lt;extRutCajero&gt;0018288327-1&lt;/extRutCajero&gt;&lt;extRutPrestador&gt;0096942400-2&lt;/extRutPrestador&gt;&lt;extRutEmisor&gt;0018288327-1&lt;/extRutEmisor&gt;&lt;extLisPrest&gt;0101001   |00|01|0000010062|0000002000|0000001400|&lt;/extLisPrest&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[17]=ConfirmacionBono3###STATUS_CIA[12]=SOLO_PERCONA###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[752]=HTTP/1.1 200 OK
Date: Fri, 22 Aug 2014 15:51:19 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 531

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult><MsgOutput xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[41]=call CSConfirmaSegU(719697005,71,5888392)###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:04.549195-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:04.507242-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[213]= xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-22 11:51:56.239022-04###RESPUESTA_PERCONA[1]=1###__XML__[0]=###', '44', 'ConfirmacionBono3');
INSERT INTO confirma_camara VALUES (153296, '2014-08-22 11:52:29.042605', 'SOLO_PERCONA', 5, 0, 'ESTADO_PERCONA[12]=SOLO_PERCONA###CODIGO_MOTOR[7]=3975347###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[169]=Falla Confirmacion de Percona, se reintenta
174004616*<05> ID COLA=153296 SQL=call CSConfirmaSegU(719697005,71,5888392)
174004617*<05> Aumenta Reintentos y falla percona###EXTFOLIOBONO[9]=719697005###EXTFOLIOAUTO[7]=5888392###EXTRUTBENEFICIARIO[12]=0019175330-5###NUM_OPERACION[8]=39468008###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=945###REQUEST_METHOD[4]=POST###REQUEST_URI[33]=/ConfirmacionBono3/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###DOCUMENT_URI[33]=/ConfirmacionBono3/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[11]=172.16.8.72###REMOTE_PORT[5]=65338###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_ACCEPT_ENCODING[12]=gzip,deflate###HTTP_CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_USER_AGENT[30]=Jakarta Commons-HttpClient/3.1###HTTP_HOST[12]=10.100.32.52###HTTP_CONTENT_LENGTH[3]=945###INPUT[1890]=3c736f61703a456e76656c6f706520786d6c6e733a736f61703d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f70652220786d6c6e733a74656d3d22687474703a2f2f74656d707572692e6f72672f223e0d0a2020203c736f61703a4865616465722f3e0d0a2020203c736f61703a426f64793e0d0a2020202020203c74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020202020202020203c212d2d4f7074696f6e616c3a2d2d3e0d0a2020202020202020203c74656d3a584d4c5f494e5055543e0a3c4d7367496e7075743e0a093c657874436f6446696e616e636961646f723e37313c2f657874436f6446696e616e636961646f723e0a093c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e0a093c657874436f644c756761723e31303030333c2f657874436f644c756761723e0a093c657874466f6c696f426f6e6f3e3731393639373030353c2f657874466f6c696f426f6e6f3e0a093c6578744e756d4f7065726163696f6e3e33393436383030383c2f6578744e756d4f7065726163696f6e3e0a093c4578744d746f546f743e31303036323c2f4578744d746f546f743e0a093c4578744d746f436f7061676f3e323030303c2f4578744d746f436f7061676f3e0a093c4578744d746f426f6e69663e313430303c2f4578744d746f426f6e69663e0a093c6578744665636861456d6973696f6e3e32303134303832323c2f6578744665636861456d6973696f6e3e0a093c65787452757442656e65666963696172696f3e303031393137353333302d353c2f65787452757442656e65666963696172696f3e0a093c65787452757443616a65726f3e303031383238383332372d313c2f65787452757443616a65726f3e0a093c657874527574507265737461646f723e303039363934323430302d323c2f657874527574507265737461646f723e0a093c657874527574456d69736f723e303031383238383332372d313c2f657874527574456d69736f723e0a093c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e0a09203c2f74656d3a584d4c5f494e5055543e0d0a2020202020203c2f74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020203c2f736f61703a426f64793e0d0a3c2f736f61703a456e76656c6f70653e###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=153296###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[28]=2014-08-22 11:52:30.48773-04###INPUT_CIA[2942]=504f5354202f70726f64756363696f6e6d70726f2f636f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313235300a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6446696e616e636961646f722667743b3731266c743b2f657874436f6446696e616e636961646f722667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b657874436f644c756761722667743b3130303033266c743b2f657874436f644c756761722667743b266c743b657874466f6c696f426f6e6f2667743b373139363937303035266c743b2f657874466f6c696f426f6e6f2667743b266c743b6578744e756d4f7065726163696f6e2667743b3339343638303038266c743b2f6578744e756d4f7065726163696f6e2667743b266c743b4578744d746f546f742667743b3130303632266c743b2f4578744d746f546f742667743b266c743b4578744d746f436f7061676f2667743b32303030266c743b2f4578744d746f436f7061676f2667743b266c743b4578744d746f426f6e69662667743b31343030266c743b2f4578744d746f426f6e69662667743b266c743b6578744665636861456d6973696f6e2667743b3230313430383232266c743b2f6578744665636861456d6973696f6e2667743b266c743b65787452757442656e65666963696172696f2667743b303031393137353333302d35266c743b2f65787452757442656e65666963696172696f2667743b266c743b65787452757443616a65726f2667743b303031383238383332372d31266c743b2f65787452757443616a65726f2667743b266c743b657874527574507265737461646f722667743b303039363934323430302d32266c743b2f657874527574507265737461646f722667743b266c743b657874527574456d69736f722667743b303031383238383332372d31266c743b2f657874527574456d69736f722667743b266c743b6578744c697350726573742667743b303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c266c743b2f6578744c697350726573742667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[780]=&lt;MsgInput&gt;&lt;extCodFinanciador&gt;71&lt;/extCodFinanciador&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extCodLugar&gt;10003&lt;/extCodLugar&gt;&lt;extFolioBono&gt;719697005&lt;/extFolioBono&gt;&lt;extNumOperacion&gt;39468008&lt;/extNumOperacion&gt;&lt;ExtMtoTot&gt;10062&lt;/ExtMtoTot&gt;&lt;ExtMtoCopago&gt;2000&lt;/ExtMtoCopago&gt;&lt;ExtMtoBonif&gt;1400&lt;/ExtMtoBonif&gt;&lt;extFechaEmision&gt;20140822&lt;/extFechaEmision&gt;&lt;extRutBeneficiario&gt;0019175330-5&lt;/extRutBeneficiario&gt;&lt;extRutCajero&gt;0018288327-1&lt;/extRutCajero&gt;&lt;extRutPrestador&gt;0096942400-2&lt;/extRutPrestador&gt;&lt;extRutEmisor&gt;0018288327-1&lt;/extRutEmisor&gt;&lt;extLisPrest&gt;0101001   |00|01|0000010062|0000002000|0000001400|&lt;/extLisPrest&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[17]=ConfirmacionBono3###STATUS_CIA[12]=SOLO_PERCONA###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[752]=HTTP/1.1 200 OK
Date: Fri, 22 Aug 2014 15:51:54 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 531

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult><MsgOutput xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[41]=call CSConfirmaSegU(719697005,71,5888392)###TIEMPO_FIN_SYBASE[28]=2014-09-05 17:40:04.61682-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:04.594787-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[213]= xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-22 11:52:30.508408-04###RESPUESTA_PERCONA[1]=1###__XML__[0]=###', '44', 'ConfirmacionBono3');
INSERT INTO confirma_camara VALUES (153297, '2014-08-22 11:53:03.621879', 'SOLO_PERCONA', 5, 0, 'ESTADO_PERCONA[12]=SOLO_PERCONA###CODIGO_MOTOR[7]=3975386###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[169]=Falla Confirmacion de Percona, se reintenta
174004653*<05> ID COLA=153297 SQL=call CSConfirmaSegU(719697005,71,5888392)
174004653*<05> Aumenta Reintentos y falla percona###EXTFOLIOBONO[9]=719697005###EXTFOLIOAUTO[7]=5888392###EXTRUTBENEFICIARIO[12]=0019175330-5###NUM_OPERACION[8]=39468008###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=945###REQUEST_METHOD[4]=POST###REQUEST_URI[33]=/ConfirmacionBono3/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###DOCUMENT_URI[33]=/ConfirmacionBono3/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[11]=172.16.8.72###REMOTE_PORT[5]=65338###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_ACCEPT_ENCODING[12]=gzip,deflate###HTTP_CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_USER_AGENT[30]=Jakarta Commons-HttpClient/3.1###HTTP_HOST[12]=10.100.32.52###HTTP_CONTENT_LENGTH[3]=945###INPUT[1890]=3c736f61703a456e76656c6f706520786d6c6e733a736f61703d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f70652220786d6c6e733a74656d3d22687474703a2f2f74656d707572692e6f72672f223e0d0a2020203c736f61703a4865616465722f3e0d0a2020203c736f61703a426f64793e0d0a2020202020203c74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020202020202020203c212d2d4f7074696f6e616c3a2d2d3e0d0a2020202020202020203c74656d3a584d4c5f494e5055543e0a3c4d7367496e7075743e0a093c657874436f6446696e616e636961646f723e37313c2f657874436f6446696e616e636961646f723e0a093c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e0a093c657874436f644c756761723e31303030333c2f657874436f644c756761723e0a093c657874466f6c696f426f6e6f3e3731393639373030353c2f657874466f6c696f426f6e6f3e0a093c6578744e756d4f7065726163696f6e3e33393436383030383c2f6578744e756d4f7065726163696f6e3e0a093c4578744d746f546f743e31303036323c2f4578744d746f546f743e0a093c4578744d746f436f7061676f3e323030303c2f4578744d746f436f7061676f3e0a093c4578744d746f426f6e69663e313430303c2f4578744d746f426f6e69663e0a093c6578744665636861456d6973696f6e3e32303134303832323c2f6578744665636861456d6973696f6e3e0a093c65787452757442656e65666963696172696f3e303031393137353333302d353c2f65787452757442656e65666963696172696f3e0a093c65787452757443616a65726f3e303031383238383332372d313c2f65787452757443616a65726f3e0a093c657874527574507265737461646f723e303039363934323430302d323c2f657874527574507265737461646f723e0a093c657874527574456d69736f723e303031383238383332372d313c2f657874527574456d69736f723e0a093c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e0a09203c2f74656d3a584d4c5f494e5055543e0d0a2020202020203c2f74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020203c2f736f61703a426f64793e0d0a3c2f736f61703a456e76656c6f70653e###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=153297###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-22 11:53:05.560586-04###INPUT_CIA[2942]=504f5354202f70726f64756363696f6e6d70726f2f636f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313235300a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6446696e616e636961646f722667743b3731266c743b2f657874436f6446696e616e636961646f722667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b657874436f644c756761722667743b3130303033266c743b2f657874436f644c756761722667743b266c743b657874466f6c696f426f6e6f2667743b373139363937303035266c743b2f657874466f6c696f426f6e6f2667743b266c743b6578744e756d4f7065726163696f6e2667743b3339343638303038266c743b2f6578744e756d4f7065726163696f6e2667743b266c743b4578744d746f546f742667743b3130303632266c743b2f4578744d746f546f742667743b266c743b4578744d746f436f7061676f2667743b32303030266c743b2f4578744d746f436f7061676f2667743b266c743b4578744d746f426f6e69662667743b31343030266c743b2f4578744d746f426f6e69662667743b266c743b6578744665636861456d6973696f6e2667743b3230313430383232266c743b2f6578744665636861456d6973696f6e2667743b266c743b65787452757442656e65666963696172696f2667743b303031393137353333302d35266c743b2f65787452757442656e65666963696172696f2667743b266c743b65787452757443616a65726f2667743b303031383238383332372d31266c743b2f65787452757443616a65726f2667743b266c743b657874527574507265737461646f722667743b303039363934323430302d32266c743b2f657874527574507265737461646f722667743b266c743b657874527574456d69736f722667743b303031383238383332372d31266c743b2f657874527574456d69736f722667743b266c743b6578744c697350726573742667743b303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c266c743b2f6578744c697350726573742667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[780]=&lt;MsgInput&gt;&lt;extCodFinanciador&gt;71&lt;/extCodFinanciador&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extCodLugar&gt;10003&lt;/extCodLugar&gt;&lt;extFolioBono&gt;719697005&lt;/extFolioBono&gt;&lt;extNumOperacion&gt;39468008&lt;/extNumOperacion&gt;&lt;ExtMtoTot&gt;10062&lt;/ExtMtoTot&gt;&lt;ExtMtoCopago&gt;2000&lt;/ExtMtoCopago&gt;&lt;ExtMtoBonif&gt;1400&lt;/ExtMtoBonif&gt;&lt;extFechaEmision&gt;20140822&lt;/extFechaEmision&gt;&lt;extRutBeneficiario&gt;0019175330-5&lt;/extRutBeneficiario&gt;&lt;extRutCajero&gt;0018288327-1&lt;/extRutCajero&gt;&lt;extRutPrestador&gt;0096942400-2&lt;/extRutPrestador&gt;&lt;extRutEmisor&gt;0018288327-1&lt;/extRutEmisor&gt;&lt;extLisPrest&gt;0101001   |00|01|0000010062|0000002000|0000001400|&lt;/extLisPrest&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[17]=ConfirmacionBono3###STATUS_CIA[12]=SOLO_PERCONA###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[752]=HTTP/1.1 200 OK
Date: Fri, 22 Aug 2014 15:52:29 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 531

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult><MsgOutput xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[41]=call CSConfirmaSegU(719697005,71,5888392)###TIEMPO_FIN_SYBASE[28]=2014-09-05 17:40:04.65295-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:04.634859-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[213]= xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-22 11:53:05.581757-04###RESPUESTA_PERCONA[1]=1###__XML__[0]=###', '44', 'ConfirmacionBono3');
INSERT INTO confirma_camara VALUES (153657, '2014-08-22 13:22:50.338831', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3981845###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[257]=Falla Confirmacion de Sybase, se reintenta
174004787*<05> ID COLA=153657 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 50717914,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174004788*<05> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[8]=50717914###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=521###REQUEST_METHOD[4]=POST###REQUEST_URI[25]=/Anulacion/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[25]=/Anulacion/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.161###REMOTE_PORT[5]=44035###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=521###INPUT[922]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353838393230383c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e35303731373931343c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[5]=FALLA###TX[4]=4001###__ID_DTE__[6]=153657###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[6]=ERR_NK###TIEMPO_INI_CIA[28]=2014-08-22 13:22:54.29858-04###INPUT_CIA[1832]=504f5354202f70726f64756363696f6e6d70726f2f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203730320a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b65787452757442656e65666963696172696f2667743b303030303030303030303030266c743b2f65787452757442656e65666963696172696f2667743b266c743b657874466f6c696f4175746f2667743b35383839323038266c743b2f657874466f6c696f4175746f2667743b266c743b657874466f6c696f426f6e6f2667743b3530373137393134266c743b2f657874466f6c696f426f6e6f2667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[238]=&lt;MsgInput&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extRutBeneficiario&gt;000000000000&lt;/extRutBeneficiario&gt;&lt;extFolioAuto&gt;5889208&lt;/extFolioAuto&gt;&lt;extFolioBono&gt;50717914&lt;/extFolioBono&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[17]=FALLA_CONEXION_BD###RESPUESTA_CIA[704]=HTTP/1.1 200 OK
Date: Fri, 22 Aug 2014 17:22:17 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 483

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[127]=declare	@CodError tinyint execute CSConfirmaAnuU 50717914,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[28]=2014-09-05 17:40:04.78778-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:04.666517-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-22 13:22:54.349515-04###API_CODRESPUESTA[1]=2###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '44', 'Anulacion');
INSERT INTO confirma_camara VALUES (183188, '2014-09-02 12:39:47.08647', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=4533130###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[30]=                              ###EXTCODERROR[1]=S###_LOG_[258]=Falla Confirmacion de Sybase, se reintenta
174004804*<05> ID COLA=183188 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 975194944,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174004804*<05> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=975194944###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=11###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=5###CONTENT_LENGTH[3]=523###REQUEST_METHOD[4]=POST###REQUEST_URI[25]=/Anulacion/cia_seg_camara###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[25]=/Anulacion/cia_seg_camara###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.160###REMOTE_PORT[5]=49798###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=523###INPUT[926]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e31313c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e31333630333533383c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353139343934343c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=183188###__COLA_MOTOR__[6]=camara###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-09-02 12:39:47.339917-04###INPUT_CIA[1734]=504f5354202f492d6d65642f7773416e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e3135302e37332e31323a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203635380a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6453656775726f3e31313c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e31333630333533383c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353139343934343c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[194]=<![CDATA[
<MsgInput><extCodSeguro>11</extCodSeguro><extRutBeneficiario>000000000000</extRutBeneficiario><extFolioAuto>13603538</extFolioAuto><extFolioBono>975194944</extFolioBono></MsgInput> ]]>###RUT_PRESTADOR[0]=###COD_LUGAR[0]=###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=camara###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[2]=OK###RESPUESTA_CIA[1042]=HTTP/1.1 100 Continue
Server: Microsoft-IIS/5.0
Date: Tue, 02 Sep 2014 16:39:45 GMT
X-Powered-By: ASP.NET

HTTP/1.1 200 OK
Server: Microsoft-IIS/5.0
Date: Tue, 02 Sep 2014 16:39:45 GMT
X-Powered-By: ASP.NET
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 742

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult>&lt;?xml version="1.0" encoding="utf-16"?&gt;
&lt;MsgOutput&gt;
  &lt;CodRetorno&gt;1&lt;/CodRetorno&gt;
  &lt;MsgError&gt;0&lt;/MsgError&gt;
  &lt;MsgText&gt;                              &lt;/MsgText&gt;
  &lt;extCodError&gt;S&lt;/extCodError&gt;
  &lt;extMensajeError&gt;                              &lt;/extMensajeError&gt;
&lt;/MsgOutput&gt;</wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 975194944,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:04.804535-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:04.794634-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[30]=                              ###MSGERROR[1]=0###CODRETORNO[1]=1###MSGOUTPUT[311]=>
  <CodRetorno>1</CodRetorno>
  <MsgError>0</MsgError>
  <MsgText>                              </MsgText>
  <extCodError>S</extCodError>
  <extMensajeError>                              </extMensajeError>
</MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-09-02 12:39:47.558371-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '11', 'Anulacion');


--
-- Name: confirma_camara_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_camara_id_seq', 195808, true);


--
-- Data for Name: confirma_chicon; Type: TABLE DATA; Schema: public; Owner: motor
--

INSERT INTO confirma_chicon VALUES (33650, '2014-08-22 11:16:32.038082', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3972523###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[166]=Falla Confirmacion de Sybase, se reintenta
174008082*<21> ID COLA=33650 SQL=call CSConfirmaSegU(719697005,71,5888392)
174008082*<21> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=719697005###EXTFOLIOAUTO[7]=5888392###EXTRUTBENEFICIARIO[12]=0019175330-5###NUM_OPERACION[8]=39468008###CODIGO_CIA[2]=44###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=21###CONTENT_LENGTH[3]=945###REQUEST_METHOD[4]=POST###REQUEST_URI[33]=/ConfirmacionBono3/cia_seg_chicon###QUERY_STRING[0]=###CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###DOCUMENT_URI[33]=/ConfirmacionBono3/cia_seg_chicon###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[11]=172.16.8.72###REMOTE_PORT[5]=65279###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_ACCEPT_ENCODING[12]=gzip,deflate###HTTP_CONTENT_TYPE[85]=application/soap+xml;charset=UTF-8;action="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_USER_AGENT[30]=Jakarta Commons-HttpClient/3.1###HTTP_HOST[12]=10.100.32.52###HTTP_CONTENT_LENGTH[3]=945###INPUT[1890]=3c736f61703a456e76656c6f706520786d6c6e733a736f61703d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f70652220786d6c6e733a74656d3d22687474703a2f2f74656d707572692e6f72672f223e0d0a2020203c736f61703a4865616465722f3e0d0a2020203c736f61703a426f64793e0d0a2020202020203c74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020202020202020203c212d2d4f7074696f6e616c3a2d2d3e0d0a2020202020202020203c74656d3a584d4c5f494e5055543e0a3c4d7367496e7075743e0a093c657874436f6446696e616e636961646f723e37313c2f657874436f6446696e616e636961646f723e0a093c657874436f6453656775726f3e34343c2f657874436f6453656775726f3e0a093c657874436f644c756761723e31303030333c2f657874436f644c756761723e0a093c657874466f6c696f426f6e6f3e3731393639373030353c2f657874466f6c696f426f6e6f3e0a093c6578744e756d4f7065726163696f6e3e33393436383030383c2f6578744e756d4f7065726163696f6e3e0a093c4578744d746f546f743e31303036323c2f4578744d746f546f743e0a093c4578744d746f436f7061676f3e323030303c2f4578744d746f436f7061676f3e0a093c4578744d746f426f6e69663e313430303c2f4578744d746f426f6e69663e0a093c6578744665636861456d6973696f6e3e32303134303832323c2f6578744665636861456d6973696f6e3e0a093c65787452757442656e65666963696172696f3e303031393137353333302d353c2f65787452757442656e65666963696172696f3e0a093c65787452757443616a65726f3e303031383238383332372d313c2f65787452757443616a65726f3e0a093c657874527574507265737461646f723e303039363934323430302d323c2f657874527574507265737461646f723e0a093c657874527574456d69736f723e303031383238383332372d313c2f657874527574456d69736f723e0a093c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e0a09203c2f74656d3a584d4c5f494e5055543e0d0a2020202020203c2f74656d3a776d496d65645f537276436f6e6669726d6163696f6e3e0d0a2020203c2f736f61703a426f64793e0d0a3c2f736f61703a456e76656c6f70653e###STATUS[5]=FALLA###TX[4]=4001###__ID_DTE__[5]=33650###__COLA_MOTOR__[6]=chicon###__STS_ERROR_PXML__[6]=ERR_NK###TIEMPO_INI_CIA[29]=2014-08-22 11:40:29.811994-04###INPUT_CIA[2942]=504f5354202f70726f64756363696f6e6d70726f2f636f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313235300a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6446696e616e636961646f722667743b3731266c743b2f657874436f6446696e616e636961646f722667743b266c743b657874436f6453656775726f2667743b3434266c743b2f657874436f6453656775726f2667743b266c743b657874436f644c756761722667743b3130303033266c743b2f657874436f644c756761722667743b266c743b657874466f6c696f426f6e6f2667743b373139363937303035266c743b2f657874466f6c696f426f6e6f2667743b266c743b6578744e756d4f7065726163696f6e2667743b3339343638303038266c743b2f6578744e756d4f7065726163696f6e2667743b266c743b4578744d746f546f742667743b3130303632266c743b2f4578744d746f546f742667743b266c743b4578744d746f436f7061676f2667743b32303030266c743b2f4578744d746f436f7061676f2667743b266c743b4578744d746f426f6e69662667743b31343030266c743b2f4578744d746f426f6e69662667743b266c743b6578744665636861456d6973696f6e2667743b3230313430383232266c743b2f6578744665636861456d6973696f6e2667743b266c743b65787452757442656e65666963696172696f2667743b303031393137353333302d35266c743b2f65787452757442656e65666963696172696f2667743b266c743b65787452757443616a65726f2667743b303031383238383332372d31266c743b2f65787452757443616a65726f2667743b266c743b657874527574507265737461646f722667743b303039363934323430302d32266c743b2f657874527574507265737461646f722667743b266c743b657874527574456d69736f722667743b303031383238383332372d31266c743b2f657874527574456d69736f722667743b266c743b6578744c697350726573742667743b303130313030312020207c30307c30317c303030303031303036327c303030303030323030307c303030303030313430307c266c743b2f6578744c697350726573742667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[780]=&lt;MsgInput&gt;&lt;extCodFinanciador&gt;71&lt;/extCodFinanciador&gt;&lt;extCodSeguro&gt;44&lt;/extCodSeguro&gt;&lt;extCodLugar&gt;10003&lt;/extCodLugar&gt;&lt;extFolioBono&gt;719697005&lt;/extFolioBono&gt;&lt;extNumOperacion&gt;39468008&lt;/extNumOperacion&gt;&lt;ExtMtoTot&gt;10062&lt;/ExtMtoTot&gt;&lt;ExtMtoCopago&gt;2000&lt;/ExtMtoCopago&gt;&lt;ExtMtoBonif&gt;1400&lt;/ExtMtoBonif&gt;&lt;extFechaEmision&gt;20140822&lt;/extFechaEmision&gt;&lt;extRutBeneficiario&gt;0019175330-5&lt;/extRutBeneficiario&gt;&lt;extRutCajero&gt;0018288327-1&lt;/extRutCajero&gt;&lt;extRutPrestador&gt;0096942400-2&lt;/extRutPrestador&gt;&lt;extRutEmisor&gt;0018288327-1&lt;/extRutEmisor&gt;&lt;extLisPrest&gt;0101001   |00|01|0000010062|0000002000|0000001400|&lt;/extLisPrest&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[6]=chicon###TX_CIA[17]=ConfirmacionBono3###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[17]=FALLA_CONEXION_BD###RESPUESTA_CIA[752]=HTTP/1.1 200 OK
Date: Fri, 22 Aug 2014 15:39:53 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 531

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult><MsgOutput xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[41]=call CSConfirmaSegU(719697005,71,5888392)###TIEMPO_FIN_SYBASE[27]=2014-09-05 17:40:08.0819-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:07.944331-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[213]= xmlns=""><extFolioAuto>5888392</extFolioAuto><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-22 11:40:30.071685-04###API_CODRESPUESTA[1]=2###API_TIPO[3]=SQL###ERROR[60]=General SQL Server error: Check messages from the SQL Server###API_DESCRIPCION_ERROR[60]=General SQL Server error: Check messages from the SQL Server###API_ERROR[3]=102###API_DESCRIPCION_MSG[35]=Incorrect syntax near <C>719697005<C>.
###__XML__[0]=###', '44', 'ConfirmacionBono3');


--
-- Name: confirma_chicon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_chicon_id_seq', 43068, true);


--
-- Data for Name: confirma_consorcio; Type: TABLE DATA; Schema: public; Owner: motor
--

INSERT INTO confirma_consorcio VALUES (21808, '2014-08-27 11:02:42.867022', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=4215900###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[257]=Falla Confirmacion de Sybase, se reintenta
174012036*<16> ID COLA=21808 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 975265641,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174012036*<16> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=975265641###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=19###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=16###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[28]=/Anulacion/cia_seg_consorcio###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[28]=/Anulacion/cia_seg_consorcio###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.161###REMOTE_PORT[5]=35574###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e31393c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e323430343636323c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353236353634313c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[5]=21808###__COLA_MOTOR__[9]=consorcio###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-27 11:02:45.076231-04###INPUT_CIA[1926]=504f5354202f77735f636e735f70726f642f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203735320a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6453656775726f3e31393c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e323430343636323c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353236353634313c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[193]=<![CDATA[
<MsgInput><extCodSeguro>19</extCodSeguro><extRutBeneficiario>000000000000</extRutBeneficiario><extFolioAuto>2404662</extFolioAuto><extFolioBono>975265641</extFolioBono></MsgInput> ]]>###RUT_PRESTADOR[0]=###COD_LUGAR[0]=###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[9]=consorcio###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[714]=HTTP/1.1 200 OK
Date: Wed, 27 Aug 2014 15:02:44 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 481

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 975265641,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:12.036495-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:12.033658-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-27 11:02:45.350788-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '19', 'Anulacion');
INSERT INTO confirma_consorcio VALUES (22964, '2014-09-01 09:15:06.494967', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=4432960###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[257]=Falla Confirmacion de Sybase, se reintenta
174012042*<16> ID COLA=22964 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 219313802,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174012042*<16> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=219313802###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=19###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=16###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[28]=/Anulacion/cia_seg_consorcio###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[28]=/Anulacion/cia_seg_consorcio###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.63###REMOTE_PORT[5]=58054###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e31393c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e323430353739373c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3231393331333830323c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[5]=22964###__COLA_MOTOR__[9]=consorcio###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-09-01 09:15:14.102999-04###INPUT_CIA[1926]=504f5354202f77735f636e735f70726f642f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203735320a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6453656775726f3e31393c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e323430353739373c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3231393331333830323c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[193]=<![CDATA[
<MsgInput><extCodSeguro>19</extCodSeguro><extRutBeneficiario>000000000000</extRutBeneficiario><extFolioAuto>2405797</extFolioAuto><extFolioBono>219313802</extFolioBono></MsgInput> ]]>###RUT_PRESTADOR[0]=###COD_LUGAR[0]=###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[9]=consorcio###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[2]=OK###RESPUESTA_CIA[714]=HTTP/1.1 200 OK
Date: Mon, 01 Sep 2014 13:15:14 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 481

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 219313802,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:12.042012-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:12.039488-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-09-01 09:15:16.321521-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '19', 'Anulacion');
INSERT INTO confirma_consorcio VALUES (23181, '2014-09-01 15:42:17.279304', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4470072###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[1010]=POST-/ConfirmacionBono3/cia_seg_consorcio
154217280*<18> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacion><ns1:XML_INPUT><MsgInput>\012<extCodFinanciador>78</extCodFinanciador>\012<extCodSeguro>19</extCodSeguro>\012<extCodLugar>13929</extCodLugar>\012<extFolioBono>975207804</extFolioBono>\012<extNumOperacion>400000380</extNumOperacion>\012<ExtMtoTot>25618</ExtMtoTot>\012<ExtMtoCopago>7540</ExtMtoCopago>\012<ExtMtoBonif> </ExtMtoBonif>\012<extFechaEmision>20140901</extFechaEmision>\012<extRutBeneficiario>0012728513-6</extRutBeneficiario>\012<extRutCajero>0011473461-6</extRutCajero>\012<extRutPrestador>0099598070-3</extRutPrestador>\012<extRutEmisor>0011473461-6</extRutEmisor>\012<extLisPrest>0101821   |00|01|0000025618|0000007540|0000000000|</extLisPrest>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvConfirmacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=975207804###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0012728513-6###NUM_OPERACION[9]=400000380###CODIGO_CIA[2]=19###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=18###CONTENT_LENGTH[4]=1082###REQUEST_METHOD[4]=POST###REQUEST_URI[36]=/ConfirmacionBono3/cia_seg_consorcio###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[36]=/ConfirmacionBono3/cia_seg_consorcio###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=51466###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1082###INPUT[1804]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e37383c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e31393c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333932393c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e3937353230373830343c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303338303c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e32353631383c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e373534303c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e203c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303930313c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303031323732383531332d363c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303031313437333436312d363c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303039393539383037302d333c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e303031313437333436312d363c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313832312020207c30307c30317c303030303032353631387c303030303030373534307c303030303030303030307c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '19', 'ConfirmacionBono3');
INSERT INTO confirma_consorcio VALUES (23873, '2014-09-03 10:35:09.879097', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4595843###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[1001]=POST-/ConfirmacionBono3/cia_seg_consorcio
103509879*<07> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacion><ns1:XML_INPUT><MsgInput>\012<extCodFinanciador>1</extCodFinanciador>\012<extCodSeguro>19</extCodSeguro>\012<extCodLugar>13625</extCodLugar>\012<extFolioBono>618414768</extFolioBono>\012<extNumOperacion>400000495</extNumOperacion>\012<ExtMtoTot>10350</ExtMtoTot>\012<ExtMtoCopago>5390</ExtMtoCopago>\012<ExtMtoBonif>3726</ExtMtoBonif>\012<extFechaEmision>20140903</extFechaEmision>\012<extRutBeneficiario>0013038387-4</extRutBeneficiario>\012<extRutCajero>0012852818-0</extRutCajero>\012<extRutPrestador>0077131810-K</extRutPrestador>\012<extRutEmisor> </extRutEmisor>\012<extLisPrest>0101001   |00|01|0000010350|0000005390|0000003726|</extLisPrest>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvConfirmacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=618414768###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0013038387-4###NUM_OPERACION[9]=400000495###CODIGO_CIA[2]=19###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=7###CONTENT_LENGTH[4]=1073###REQUEST_METHOD[4]=POST###REQUEST_URI[36]=/ConfirmacionBono3/cia_seg_consorcio###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[36]=/ConfirmacionBono3/cia_seg_consorcio###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=37618###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1073###INPUT[1786]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e31393c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333632353c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e3631383431343736383c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303439353c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e31303335303c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e353339303c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e333732363c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303930333c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303031333033383338372d343c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303031323835323831382d303c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303037373133313831302d4b3c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e203c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303335307c303030303030353339307c303030303030333732367c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '19', 'ConfirmacionBono3');


--
-- Name: confirma_consorcio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_consorcio_id_seq', 24851, true);


--
-- Data for Name: confirma_euroamerica; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_euroamerica_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_euroamerica_id_seq', 176922, true);


--
-- Data for Name: confirma_far2; Type: TABLE DATA; Schema: public; Owner: motor
--

INSERT INTO confirma_far2 VALUES (98332, '2014-08-22 18:05:31.578852', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=4003532###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[10]=Autorizada###EXTCODERROR[1]=S###_LOG_[243]=Falla Confirmacion de Sybase, se reintenta
174007270*<15> ID COLA=98332 SQL=declare	@CodError tinyint execute CSConfirmaSegU 219063216,99,0, @CodError OUTPUT select @CodError as respuesta_sybase
174007271*<15> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=219063216###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0016070530-2###NUM_OPERACION[8]=39496345###CODIGO_CIA[2]=25###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=15###CONTENT_LENGTH[4]=1069###REQUEST_METHOD[4]=POST###REQUEST_URI[26]=/Confirmacion/cia_seg_far2###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[26]=/Confirmacion/cia_seg_far2###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.63###REMOTE_PORT[5]=44000###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1069###INPUT[1778]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e39393c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e32353c2f657874436f6453656775726f3e3c657874436f644c756761723e31333035323c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e3231393036333231363c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393439363334353c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e31323036303c2f4578744d746f546f743e3c4578744d746f436f7061676f3e343435303c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e333131353c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303832323c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303031363037303533302d323c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303031383637333335392d323c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303037363639363230302d393c2f657874527574507265737461646f723e3c657874527574456d69736f723e303031383637333335392d323c2f657874527574456d69736f723e3c6578744c697350726573743e303130313831322020207c30307c30317c303030303031323036307c303030303030343435307c303030303030333131357c3c2f6578744c697350726573743e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[5]=98332###__COLA_MOTOR__[4]=far2###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-22 18:05:39.310174-04###INPUT_CIA[2802]=504f5354202f436f6e6669726d6163696f6e2f436f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e32372e31312e36303a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313138310a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e39393c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e32353c2f657874436f6453656775726f3e3c657874436f644c756761723e31333035323c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e3231393036333231363c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393439363334353c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e31323036303c2f4578744d746f546f743e3c4578744d746f436f7061676f3e343435303c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e333131353c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303832323c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303031363037303533302d323c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303031383637333335392d323c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303037363639363230302d393c2f657874527574507265737461646f723e3c657874527574456d69736f723e303031383637333335392d323c2f657874527574456d69736f723e3c6578744c697350726573743e303130313831322020207c30307c30317c303030303031323036307c303030303030343435307c303030303030333131357c3c2f6578744c697350726573743e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[614]=<![CDATA[
<MsgInput><extCodFinanciador>99</extCodFinanciador><extCodSeguro>25</extCodSeguro><extCodLugar>13052</extCodLugar><extFolioBono>219063216</extFolioBono><extNumOperacion>39496345</extNumOperacion><ExtMtoTot>12060</ExtMtoTot><ExtMtoCopago>4450</ExtMtoCopago><ExtMtoBonif>3115</ExtMtoBonif><extFechaEmision>20140822</extFechaEmision><extRutBeneficiario>0016070530-2</extRutBeneficiario><extRutCajero>0018673359-2</extRutCajero><extRutPrestador>0076696200-9</extRutPrestador><extRutEmisor>0018673359-2</extRutEmisor><extLisPrest>0101812   |00|01|0000012060|0000004450|0000003115|</extLisPrest></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[4]=far2###TX_CIA[12]=Confirmacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[2]=OK###RESPUESTA_CIA[806]=HTTP/1.1 200 OK
Date: Fri, 22 Aug 2014 22:05:39 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 573

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult>&lt;MsgOutput&gt;&lt;extFolioAuto&gt;0&lt;/extFolioAuto&gt; &lt;extCodError&gt;S&lt;/extCodError&gt;&lt;extMensajeError&gt;Autorizada&lt;/extMensajeError&gt;&lt;/MsgOutput&gt;</wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[118]=declare	@CodError tinyint execute CSConfirmaSegU 219063216,99,0, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:07.270769-04###TIEMPO_INI_SYBASE[28]=2014-09-05 17:40:07.18858-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[209]=><extFolioAuto>0</extFolioAuto> <extCodError>S</extCodError><extMensajeError>Autorizada</extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-22 18:05:39.438362-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '25', 'Confirmacion');
INSERT INTO confirma_far2 VALUES (98333, '2014-08-22 18:05:43.260516', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=4003545###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[10]=Autorizada###EXTCODERROR[1]=S###_LOG_[243]=Falla Confirmacion de Sybase, se reintenta
174007276*<15> ID COLA=98333 SQL=declare	@CodError tinyint execute CSConfirmaSegU 719706782,71,0, @CodError OUTPUT select @CodError as respuesta_sybase
174007277*<15> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=719706782###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0012403690-9###NUM_OPERACION[8]=39496361###CODIGO_CIA[2]=25###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=15###CONTENT_LENGTH[4]=1069###REQUEST_METHOD[4]=POST###REQUEST_URI[26]=/Confirmacion/cia_seg_far2###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[26]=/Confirmacion/cia_seg_far2###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.63###REMOTE_PORT[5]=44334###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1069###INPUT[1778]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e37313c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e32353c2f657874436f6453656775726f3e3c657874436f644c756761723e31333533333c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e3731393730363738323c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393439363336313c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e31393839303c2f4578744d746f546f743e3c4578744d746f436f7061676f3e363635363c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e353939313c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303832323c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303031323430333639302d393c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303031303932383333312d323c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303039393535363838302d323c2f657874527574507265737461646f723e3c657874527574456d69736f723e303031303932383333312d323c2f657874527574456d69736f723e3c6578744c697350726573743e303130313030322020207c30307c30317c303030303031393839307c303030303030363635367c303030303030353939317c3c2f6578744c697350726573743e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[5]=98333###__COLA_MOTOR__[4]=far2###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-22 18:05:43.457161-04###INPUT_CIA[2802]=504f5354202f436f6e6669726d6163696f6e2f436f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e32372e31312e36303a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313138310a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e37313c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e32353c2f657874436f6453656775726f3e3c657874436f644c756761723e31333533333c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e3731393730363738323c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393439363336313c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e31393839303c2f4578744d746f546f743e3c4578744d746f436f7061676f3e363635363c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e353939313c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303832323c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303031323430333639302d393c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303031303932383333312d323c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303039393535363838302d323c2f657874527574507265737461646f723e3c657874527574456d69736f723e303031303932383333312d323c2f657874527574456d69736f723e3c6578744c697350726573743e303130313030322020207c30307c30317c303030303031393839307c303030303030363635367c303030303030353939317c3c2f6578744c697350726573743e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[614]=<![CDATA[
<MsgInput><extCodFinanciador>71</extCodFinanciador><extCodSeguro>25</extCodSeguro><extCodLugar>13533</extCodLugar><extFolioBono>719706782</extFolioBono><extNumOperacion>39496361</extNumOperacion><ExtMtoTot>19890</ExtMtoTot><ExtMtoCopago>6656</ExtMtoCopago><ExtMtoBonif>5991</ExtMtoBonif><extFechaEmision>20140822</extFechaEmision><extRutBeneficiario>0012403690-9</extRutBeneficiario><extRutCajero>0010928331-2</extRutCajero><extRutPrestador>0099556880-2</extRutPrestador><extRutEmisor>0010928331-2</extRutEmisor><extLisPrest>0101002   |00|01|0000019890|0000006656|0000005991|</extLisPrest></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[4]=far2###TX_CIA[12]=Confirmacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[2]=OK###RESPUESTA_CIA[806]=HTTP/1.1 200 OK
Date: Fri, 22 Aug 2014 22:05:43 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 573

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult>&lt;MsgOutput&gt;&lt;extFolioAuto&gt;0&lt;/extFolioAuto&gt; &lt;extCodError&gt;S&lt;/extCodError&gt;&lt;extMensajeError&gt;Autorizada&lt;/extMensajeError&gt;&lt;/MsgOutput&gt;</wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[118]=declare	@CodError tinyint execute CSConfirmaSegU 719706782,71,0, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:07.276792-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:07.274248-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[209]=><extFolioAuto>0</extFolioAuto> <extCodError>S</extCodError><extMensajeError>Autorizada</extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-22 18:05:43.463417-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '25', 'Confirmacion');
INSERT INTO confirma_far2 VALUES (119612, '2014-09-05 17:53:40.401247', 'INGRESADO', 0, 0, 'CODIGO_MOTOR[7]=4780512###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[512]=POST-/Anulacion/cia_seg_far2
175340402*<27> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacion><ns1:XML_INPUT><MsgInput><extCodSeguro>34</extCodSeguro><extRutBeneficiario>0016712133-0</extRutBeneficiario><extFolioAuto>2576364</extFolioAuto><extFolioBono>975157730</extFolioBono></MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvAnulacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=975157730###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0016712133-0###NUM_OPERACION[0]=###CODIGO_CIA[2]=34###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=27###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[23]=/Anulacion/cia_seg_far2###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[23]=/Anulacion/cia_seg_far2###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.161###REMOTE_PORT[5]=35977###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e33343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e303031363731323133332d303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e323537363336343c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353135373733303c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '34', 'Anulacion');


--
-- Name: confirma_far2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_far2_id_seq', 119612, true);


--
-- Data for Name: confirma_generica; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Data for Name: confirma_imed; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_imed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_imed_id_seq', 53665, true);


--
-- Data for Name: confirma_ing; Type: TABLE DATA; Schema: public; Owner: motor
--

INSERT INTO confirma_ing VALUES (37086, '2014-08-07 18:03:29.467842', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=2326438###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[257]=Falla Confirmacion de Sybase, se reintenta
174012165*<22> ID COLA=37086 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 719536214,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174012165*<22> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=719536214###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=14###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=22###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[22]=/Anulacion/cia_seg_ing###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[22]=/Anulacion/cia_seg_ing###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.64###REMOTE_PORT[5]=46485###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e31343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353836303039303c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3731393533363231343c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[5]=37086###__COLA_MOTOR__[3]=ing###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-07 18:03:29.695666-04###INPUT_CIA[1926]=504f5354202f77735f696e675f70726f642f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203735320a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6453656775726f3e31343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353836303039303c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3731393533363231343c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[193]=<![CDATA[
<MsgInput><extCodSeguro>14</extCodSeguro><extRutBeneficiario>000000000000</extRutBeneficiario><extFolioAuto>5860090</extFolioAuto><extFolioBono>719536214</extFolioBono></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[3]=ing###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[714]=HTTP/1.1 200 OK
Date: Thu, 07 Aug 2014 22:03:02 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 481

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 719536214,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:12.165018-04###TIEMPO_INI_SYBASE[28]=2014-09-05 17:40:12.16249-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-07 18:03:29.830774-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '14', 'Anulacion');
INSERT INTO confirma_ing VALUES (38643, '2014-08-09 11:22:25.112766', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=2429960###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[257]=Falla Confirmacion de Sybase, se reintenta
174012170*<22> ID COLA=38643 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 975466196,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174012170*<22> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=975466196###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=14###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=22###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[22]=/Anulacion/cia_seg_ing###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[22]=/Anulacion/cia_seg_ing###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.160###REMOTE_PORT[5]=35009###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e31343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353836313932343c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353436363139363c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[5]=38643###__COLA_MOTOR__[3]=ing###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-09 11:22:25.623765-04###INPUT_CIA[1926]=504f5354202f77735f696e675f70726f642f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203735320a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6453656775726f3e31343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353836313932343c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353436363139363c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[193]=<![CDATA[
<MsgInput><extCodSeguro>14</extCodSeguro><extRutBeneficiario>000000000000</extRutBeneficiario><extFolioAuto>5861924</extFolioAuto><extFolioBono>975466196</extFolioBono></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[3]=ing###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[714]=HTTP/1.1 200 OK
Date: Sat, 09 Aug 2014 15:21:57 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 481

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 975466196,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:12.169903-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:12.167647-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[28]=2014-08-09 11:22:25.67031-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '14', 'Anulacion');
INSERT INTO confirma_ing VALUES (44716, '2014-08-18 13:00:55.693124', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3656000###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[257]=Falla Confirmacion de Sybase, se reintenta
174012174*<22> ID COLA=44716 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 218860717,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174012174*<22> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=218860717###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=14###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=22###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[22]=/Anulacion/cia_seg_ing###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[22]=/Anulacion/cia_seg_ing###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.64###REMOTE_PORT[5]=38966###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e31343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353836393035383c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3231383836303731373c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[5]=44716###__COLA_MOTOR__[3]=ing###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-18 13:01:00.656485-04###INPUT_CIA[1926]=504f5354202f77735f696e675f70726f642f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203735320a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6453656775726f3e31343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353836393035383c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3231383836303731373c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[193]=<![CDATA[
<MsgInput><extCodSeguro>14</extCodSeguro><extRutBeneficiario>000000000000</extRutBeneficiario><extFolioAuto>5869058</extFolioAuto><extFolioBono>218860717</extFolioBono></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[3]=ing###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[714]=HTTP/1.1 200 OK
Date: Mon, 18 Aug 2014 17:00:26 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 481

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 218860717,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:12.174379-04###TIEMPO_INI_SYBASE[27]=2014-09-05 17:40:12.1723-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-18 13:01:00.720739-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '14', 'Anulacion');
INSERT INTO confirma_ing VALUES (53925, '2014-08-29 11:52:24.614685', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4352723###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[992]=POST-/ConfirmacionBono3/cia_seg_ing
115224615*<23> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacion><ns1:XML_INPUT><MsgInput>\012<extCodFinanciador>1</extCodFinanciador>\012<extCodSeguro>14</extCodSeguro>\012<extCodLugar>13625</extCodLugar>\012<extFolioBono>618186302</extFolioBono>\012<extNumOperacion>400000264</extNumOperacion>\012<ExtMtoTot>10350</ExtMtoTot>\012<ExtMtoCopago>5390</ExtMtoCopago>\012<ExtMtoBonif> </ExtMtoBonif>\012<extFechaEmision>20140829</extFechaEmision>\012<extRutBeneficiario>0023332158-3</extRutBeneficiario>\012<extRutCajero>0013960290-0</extRutCajero>\012<extRutPrestador>0077131810-K</extRutPrestador>\012<extRutEmisor> </extRutEmisor>\012<extLisPrest>0101001   |00|01|0000010350|0000005390|0000000000|</extLisPrest>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvConfirmacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=618186302###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0023332158-3###NUM_OPERACION[9]=400000264###CODIGO_CIA[2]=14###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=23###CONTENT_LENGTH[4]=1070###REQUEST_METHOD[4]=POST###REQUEST_URI[30]=/ConfirmacionBono3/cia_seg_ing###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[30]=/ConfirmacionBono3/cia_seg_ing###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=49245###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1070###INPUT[1780]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e31343c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333632353c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e3631383138363330323c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303236343c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e31303335303c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e353339303c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e203c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303832393c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303032333333323135382d333c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303031333936303239302d303c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303037373133313831302d4b3c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e203c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303335307c303030303030353339307c303030303030303030307c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '14', 'ConfirmacionBono3');
INSERT INTO confirma_ing VALUES (56752, '2014-09-02 11:36:29.49623', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=4526833###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[257]=Falla Confirmacion de Sybase, se reintenta
174012197*<22> ID COLA=56752 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 975197429,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174012197*<22> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=975197429###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=14###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=22###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[22]=/Anulacion/cia_seg_ing###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[22]=/Anulacion/cia_seg_ing###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.64###REMOTE_PORT[5]=52887###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e31343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353838333435353c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353139373432393c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[5]=56752###__COLA_MOTOR__[3]=ing###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-09-02 11:36:41.649052-04###INPUT_CIA[1926]=504f5354202f77735f696e675f70726f642f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203735320a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6453656775726f3e31343c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e353838333435353c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353139373432393c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[193]=<![CDATA[
<MsgInput><extCodSeguro>14</extCodSeguro><extRutBeneficiario>000000000000</extRutBeneficiario><extFolioAuto>5883455</extFolioAuto><extFolioBono>975197429</extFolioBono></MsgInput> ]]>###RUT_PRESTADOR[0]=###COD_LUGAR[0]=###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[3]=ing###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[2]=OK###RESPUESTA_CIA[714]=HTTP/1.1 200 OK
Date: Tue, 02 Sep 2014 15:36:39 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 481

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 975197429,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:12.197113-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:12.194774-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-09-02 11:36:41.740937-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '14', 'Anulacion');
INSERT INTO confirma_ing VALUES (57394, '2014-09-02 20:12:25.987217', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4573488###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[1004]=POST-/ConfirmacionBono3/cia_seg_ing
201225987*<35> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacion><ns1:XML_INPUT><MsgInput>\012<extCodFinanciador>78</extCodFinanciador>\012<extCodSeguro>14</extCodSeguro>\012<extCodLugar>13625</extCodLugar>\012<extFolioBono>975186846</extFolioBono>\012<extNumOperacion>400000474</extNumOperacion>\012<ExtMtoTot>12486</ExtMtoTot>\012<ExtMtoCopago>1249</ExtMtoCopago>\012<ExtMtoBonif> </ExtMtoBonif>\012<extFechaEmision>20140902</extFechaEmision>\012<extRutBeneficiario>0014277863-7</extRutBeneficiario>\012<extRutCajero>0009152631-K</extRutCajero>\012<extRutPrestador>0077131810-K</extRutPrestador>\012<extRutEmisor>0009152631-K</extRutEmisor>\012<extLisPrest>0101814   |00|01|0000012486|0000001249|0000000000|</extLisPrest>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvConfirmacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=975186846###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0014277863-7###NUM_OPERACION[9]=400000474###CODIGO_CIA[2]=14###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=35###CONTENT_LENGTH[4]=1082###REQUEST_METHOD[4]=POST###REQUEST_URI[30]=/ConfirmacionBono3/cia_seg_ing###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[30]=/ConfirmacionBono3/cia_seg_ing###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=53420###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1082###INPUT[1804]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e37383c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e31343c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333632353c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e3937353138363834363c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303437343c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e31323438363c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e313234393c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e203c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303930323c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303031343237373836332d373c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303030393135323633312d4b3c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303037373133313831302d4b3c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e303030393135323633312d4b3c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313831342020207c30307c30317c303030303031323438367c303030303030313234397c303030303030303030307c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '14', 'ConfirmacionBono3');
INSERT INTO confirma_ing VALUES (57798, '2014-09-03 11:01:12.403763', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4599040###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[995]=POST-/ConfirmacionBono3/cia_seg_ing
110112404*<18> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacion><ns1:XML_INPUT><MsgInput>\012<extCodFinanciador>1</extCodFinanciador>\012<extCodSeguro>14</extCodSeguro>\012<extCodLugar>13625</extCodLugar>\012<extFolioBono>618418300</extFolioBono>\012<extNumOperacion>400000499</extNumOperacion>\012<ExtMtoTot>10350</ExtMtoTot>\012<ExtMtoCopago>5390</ExtMtoCopago>\012<ExtMtoBonif>2695</ExtMtoBonif>\012<extFechaEmision>20140903</extFechaEmision>\012<extRutBeneficiario>0006824054-9</extRutBeneficiario>\012<extRutCajero>0012852818-0</extRutCajero>\012<extRutPrestador>0077131810-K</extRutPrestador>\012<extRutEmisor> </extRutEmisor>\012<extLisPrest>0101001   |00|01|0000010350|0000005390|0000002695|</extLisPrest>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvConfirmacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=618418300###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0006824054-9###NUM_OPERACION[9]=400000499###CODIGO_CIA[2]=14###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=18###CONTENT_LENGTH[4]=1073###REQUEST_METHOD[4]=POST###REQUEST_URI[30]=/ConfirmacionBono3/cia_seg_ing###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[30]=/ConfirmacionBono3/cia_seg_ing###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=38200###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1073###INPUT[1786]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e31343c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333632353c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e3631383431383330303c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303439393c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e31303335303c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e353339303c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e323639353c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303930333c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303030363832343035342d393c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303031323835323831382d303c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303037373133313831302d4b3c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e203c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303335307c303030303030353339307c303030303030323639357c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '14', 'ConfirmacionBono3');
INSERT INTO confirma_ing VALUES (59707, '2014-09-04 20:20:36.339638', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4720910###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[995]=POST-/ConfirmacionBono3/cia_seg_ing
202036340*<16> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacion><ns1:XML_INPUT><MsgInput>\012<extCodFinanciador>1</extCodFinanciador>\012<extCodSeguro>14</extCodSeguro>\012<extCodLugar>13625</extCodLugar>\012<extFolioBono>618532025</extFolioBono>\012<extNumOperacion>400000637</extNumOperacion>\012<ExtMtoTot>10350</ExtMtoTot>\012<ExtMtoCopago>5390</ExtMtoCopago>\012<ExtMtoBonif>3773</ExtMtoBonif>\012<extFechaEmision>20140904</extFechaEmision>\012<extRutBeneficiario>0022776344-2</extRutBeneficiario>\012<extRutCajero>0009152631-K</extRutCajero>\012<extRutPrestador>0077131810-K</extRutPrestador>\012<extRutEmisor> </extRutEmisor>\012<extLisPrest>0101001   |00|01|0000010350|0000005390|0000003773|</extLisPrest>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvConfirmacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=618532025###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0022776344-2###NUM_OPERACION[9]=400000637###CODIGO_CIA[2]=14###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=16###CONTENT_LENGTH[4]=1073###REQUEST_METHOD[4]=POST###REQUEST_URI[30]=/ConfirmacionBono3/cia_seg_ing###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[30]=/ConfirmacionBono3/cia_seg_ing###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=47283###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1073###INPUT[1786]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e31343c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333632353c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e3631383533323032353c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303633373c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e31303335303c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e353339303c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e333737333c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303930343c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303032323737363334342d323c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303030393135323633312d4b3c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303037373133313831302d4b3c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e203c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303335307c303030303030353339307c303030303030333737337c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '14', 'ConfirmacionBono3');


--
-- Name: confirma_ing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_ing_id_seq', 60652, true);


--
-- Data for Name: confirma_integrafar; Type: TABLE DATA; Schema: public; Owner: motor
--

INSERT INTO confirma_integrafar VALUES (15363, '2014-08-11 10:24:24.357104', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=2478782###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[10]=Autorizada###EXTCODERROR[1]=S###_LOG_[242]=Falla Confirmacion de Sybase, se reintenta
174011367*<09> ID COLA=15363 SQL=declare	@CodError tinyint execute CSConfirmaSegU 617198006,1,0, @CodError OUTPUT select @CodError as respuesta_sybase
174011367*<09> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=617198006###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0003546449-2###NUM_OPERACION[8]=39133040###CODIGO_CIA[2]=45###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=9###CONTENT_LENGTH[4]=1065###REQUEST_METHOD[4]=POST###REQUEST_URI[32]=/Confirmacion/cia_seg_integrafar###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[32]=/Confirmacion/cia_seg_integrafar###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.160###REMOTE_PORT[5]=49007###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1065###INPUT[1770]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e34353c2f657874436f6453656775726f3e3c657874436f644c756761723e31333530303c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e3631373139383030363c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393133333034303c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e31323639303c2f4578744d746f546f743e3c4578744d746f436f7061676f3e353038303c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e303c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303831313c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303030333534363434392d323c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303031363931363036392d343c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303037363339383030302d363c2f657874527574507265737461646f723e3c657874527574456d69736f723e303031363931363036392d343c2f657874527574456d69736f723e3c6578744c697350726573743e303130313030332020207c30307c30317c303030303031323639307c303030303030353038307c303030303030303030307c3c2f6578744c697350726573743e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[5]=15363###__COLA_MOTOR__[10]=integrafar###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-11 10:24:29.737616-04###INPUT_CIA[2794]=504f5354202f436f6e6669726d6163696f6e2f436f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e32372e31312e36313a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313137370a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e34353c2f657874436f6453656775726f3e3c657874436f644c756761723e31333530303c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e3631373139383030363c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393133333034303c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e31323639303c2f4578744d746f546f743e3c4578744d746f436f7061676f3e353038303c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e303c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303831313c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303030333534363434392d323c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303031363931363036392d343c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303037363339383030302d363c2f657874527574507265737461646f723e3c657874527574456d69736f723e303031363931363036392d343c2f657874527574456d69736f723e3c6578744c697350726573743e303130313030332020207c30307c30317c303030303031323639307c303030303030353038307c303030303030303030307c3c2f6578744c697350726573743e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[610]=<![CDATA[
<MsgInput><extCodFinanciador>1</extCodFinanciador><extCodSeguro>45</extCodSeguro><extCodLugar>13500</extCodLugar><extFolioBono>617198006</extFolioBono><extNumOperacion>39133040</extNumOperacion><ExtMtoTot>12690</ExtMtoTot><ExtMtoCopago>5080</ExtMtoCopago><ExtMtoBonif>0</ExtMtoBonif><extFechaEmision>20140811</extFechaEmision><extRutBeneficiario>0003546449-2</extRutBeneficiario><extRutCajero>0016916069-4</extRutCajero><extRutPrestador>0076398000-6</extRutPrestador><extRutEmisor>0016916069-4</extRutEmisor><extLisPrest>0101003   |00|01|0000012690|0000005080|0000000000|</extLisPrest></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[10]=integrafar###TX_CIA[12]=Confirmacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[806]=HTTP/1.1 200 OK
Date: Mon, 11 Aug 2014 14:24:00 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 573

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult>&lt;MsgOutput&gt;&lt;extFolioAuto&gt;0&lt;/extFolioAuto&gt; &lt;extCodError&gt;S&lt;/extCodError&gt;&lt;extMensajeError&gt;Autorizada&lt;/extMensajeError&gt;&lt;/MsgOutput&gt;</wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[117]=declare	@CodError tinyint execute CSConfirmaSegU 617198006,1,0, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:11.367482-04###TIEMPO_INI_SYBASE[28]=2014-09-05 17:40:11.36459-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[209]=><extFolioAuto>0</extFolioAuto> <extCodError>S</extCodError><extMensajeError>Autorizada</extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-11 10:24:29.825721-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '45', 'Confirmacion');
INSERT INTO confirma_integrafar VALUES (15364, '2014-08-11 10:24:25.568042', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=2478797###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[10]=Autorizada###EXTCODERROR[1]=S###_LOG_[242]=Falla Confirmacion de Sybase, se reintenta
174011374*<09> ID COLA=15364 SQL=declare	@CodError tinyint execute CSConfirmaSegU 50535561,67,0, @CodError OUTPUT select @CodError as respuesta_sybase
174011374*<09> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[8]=50535561###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0015947210-8###NUM_OPERACION[8]=39133044###CODIGO_CIA[2]=45###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=9###CONTENT_LENGTH[4]=1065###REQUEST_METHOD[4]=POST###REQUEST_URI[32]=/Confirmacion/cia_seg_integrafar###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[32]=/Confirmacion/cia_seg_integrafar###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.64###REMOTE_PORT[5]=34339###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1065###INPUT[1770]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e36373c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e34353c2f657874436f6453656775726f3e3c657874436f644c756761723e31333530363c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e35303533353536313c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393133333034343c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e31363434363c2f4578744d746f546f743e3c4578744d746f436f7061676f3e343933343c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e303c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303831313c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303031353934373231302d383c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303031363531383539302d303c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303037363339383030302d363c2f657874527574507265737461646f723e3c657874527574456d69736f723e303031363531383539302d303c2f657874527574456d69736f723e3c6578744c697350726573743e303130313831362020207c30307c30317c303030303031363434367c303030303030343933347c303030303030303030307c3c2f6578744c697350726573743e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[5]=15364###__COLA_MOTOR__[10]=integrafar###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-11 10:24:29.858568-04###INPUT_CIA[2794]=504f5354202f436f6e6669726d6163696f6e2f436f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e32372e31312e36313a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313137370a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e36373c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e34353c2f657874436f6453656775726f3e3c657874436f644c756761723e31333530363c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e35303533353536313c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393133333034343c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e31363434363c2f4578744d746f546f743e3c4578744d746f436f7061676f3e343933343c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e303c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303831313c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303031353934373231302d383c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303031363531383539302d303c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303037363339383030302d363c2f657874527574507265737461646f723e3c657874527574456d69736f723e303031363531383539302d303c2f657874527574456d69736f723e3c6578744c697350726573743e303130313831362020207c30307c30317c303030303031363434367c303030303030343933347c303030303030303030307c3c2f6578744c697350726573743e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[610]=<![CDATA[
<MsgInput><extCodFinanciador>67</extCodFinanciador><extCodSeguro>45</extCodSeguro><extCodLugar>13506</extCodLugar><extFolioBono>50535561</extFolioBono><extNumOperacion>39133044</extNumOperacion><ExtMtoTot>16446</ExtMtoTot><ExtMtoCopago>4934</ExtMtoCopago><ExtMtoBonif>0</ExtMtoBonif><extFechaEmision>20140811</extFechaEmision><extRutBeneficiario>0015947210-8</extRutBeneficiario><extRutCajero>0016518590-0</extRutCajero><extRutPrestador>0076398000-6</extRutPrestador><extRutEmisor>0016518590-0</extRutEmisor><extLisPrest>0101816   |00|01|0000016446|0000004934|0000000000|</extLisPrest></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[10]=integrafar###TX_CIA[12]=Confirmacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[17]=FALLA_CONEXION_BD###RESPUESTA_CIA[806]=HTTP/1.1 200 OK
Date: Mon, 11 Aug 2014 14:24:00 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 573

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult>&lt;MsgOutput&gt;&lt;extFolioAuto&gt;0&lt;/extFolioAuto&gt; &lt;extCodError&gt;S&lt;/extCodError&gt;&lt;extMensajeError&gt;Autorizada&lt;/extMensajeError&gt;&lt;/MsgOutput&gt;</wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[117]=declare	@CodError tinyint execute CSConfirmaSegU 50535561,67,0, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:11.373978-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:11.371387-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[209]=><extFolioAuto>0</extFolioAuto> <extCodError>S</extCodError><extMensajeError>Autorizada</extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-11 10:24:29.894668-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '45', 'Confirmacion');
INSERT INTO confirma_integrafar VALUES (15365, '2014-08-11 10:26:18.887518', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=2479747###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[10]=Autorizada###EXTCODERROR[1]=S###_LOG_[242]=Falla Confirmacion de Sybase, se reintenta
174011380*<09> ID COLA=15365 SQL=declare	@CodError tinyint execute CSConfirmaSegU 617198294,1,0, @CodError OUTPUT select @CodError as respuesta_sybase
174011380*<09> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=617198294###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0004590209-9###NUM_OPERACION[8]=39133177###CODIGO_CIA[2]=45###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=9###CONTENT_LENGTH[4]=1066###REQUEST_METHOD[4]=POST###REQUEST_URI[32]=/Confirmacion/cia_seg_integrafar###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[32]=/Confirmacion/cia_seg_integrafar###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.63###REMOTE_PORT[5]=34366###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1066###INPUT[1772]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e34353c2f657874436f6453656775726f3e3c657874436f644c756761723e343530303c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e3631373139383239343c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393133333137373c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e3133353838303c2f4578744d746f546f743e3c4578744d746f436f7061676f3e36373934303c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e303c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303831313c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303030343539303230392d393c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303031363837383032302d363c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303037363339383030302d363c2f657874527574507265737461646f723e3c657874527574456d69736f723e303031363837383032302d363c2f657874527574456d69736f723e3c6578744c697350726573743e303430353030332020207c30307c30317c303030303133353838307c303030303036373934307c303030303030303030307c3c2f6578744c697350726573743e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[5]=15365###__COLA_MOTOR__[10]=integrafar###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-11 10:26:22.065424-04###INPUT_CIA[2796]=504f5354202f436f6e6669726d6163696f6e2f436f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e32372e31312e36313a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313137380a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e34353c2f657874436f6453656775726f3e3c657874436f644c756761723e343530303c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e3631373139383239343c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393133333137373c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e3133353838303c2f4578744d746f546f743e3c4578744d746f436f7061676f3e36373934303c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e303c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303831313c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303030343539303230392d393c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303031363837383032302d363c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303037363339383030302d363c2f657874527574507265737461646f723e3c657874527574456d69736f723e303031363837383032302d363c2f657874527574456d69736f723e3c6578744c697350726573743e303430353030332020207c30307c30317c303030303133353838307c303030303036373934307c303030303030303030307c3c2f6578744c697350726573743e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[611]=<![CDATA[
<MsgInput><extCodFinanciador>1</extCodFinanciador><extCodSeguro>45</extCodSeguro><extCodLugar>4500</extCodLugar><extFolioBono>617198294</extFolioBono><extNumOperacion>39133177</extNumOperacion><ExtMtoTot>135880</ExtMtoTot><ExtMtoCopago>67940</ExtMtoCopago><ExtMtoBonif>0</ExtMtoBonif><extFechaEmision>20140811</extFechaEmision><extRutBeneficiario>0004590209-9</extRutBeneficiario><extRutCajero>0016878020-6</extRutCajero><extRutPrestador>0076398000-6</extRutPrestador><extRutEmisor>0016878020-6</extRutEmisor><extLisPrest>0405003   |00|01|0000135880|0000067940|0000000000|</extLisPrest></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[10]=integrafar###TX_CIA[12]=Confirmacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[806]=HTTP/1.1 200 OK
Date: Mon, 11 Aug 2014 14:25:52 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 573

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult>&lt;MsgOutput&gt;&lt;extFolioAuto&gt;0&lt;/extFolioAuto&gt; &lt;extCodError&gt;S&lt;/extCodError&gt;&lt;extMensajeError&gt;Autorizada&lt;/extMensajeError&gt;&lt;/MsgOutput&gt;</wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[117]=declare	@CodError tinyint execute CSConfirmaSegU 617198294,1,0, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:11.380102-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:11.377466-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[209]=><extFolioAuto>0</extFolioAuto> <extCodError>S</extCodError><extMensajeError>Autorizada</extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-11 10:26:22.096397-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '45', 'Confirmacion');
INSERT INTO confirma_integrafar VALUES (15366, '2014-08-11 10:26:22.237422', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=2479775###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[10]=Autorizada###EXTCODERROR[1]=S###_LOG_[242]=Falla Confirmacion de Sybase, se reintenta
174011386*<09> ID COLA=15366 SQL=declare	@CodError tinyint execute CSConfirmaSegU 617198306,1,0, @CodError OUTPUT select @CodError as respuesta_sybase
174011386*<09> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=617198306###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0004364175-1###NUM_OPERACION[8]=39133182###CODIGO_CIA[2]=45###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=9###CONTENT_LENGTH[4]=1065###REQUEST_METHOD[4]=POST###REQUEST_URI[32]=/Confirmacion/cia_seg_integrafar###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[32]=/Confirmacion/cia_seg_integrafar###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.161###REMOTE_PORT[5]=57377###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1065###INPUT[1770]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e34353c2f657874436f6453656775726f3e3c657874436f644c756761723e31333530353c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e3631373139383330363c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393133333138323c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e31323639303c2f4578744d746f546f743e3c4578744d746f436f7061676f3e353038303c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e303c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303831313c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303030343336343137352d313c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303030393039383335302d343c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303037363339383030302d363c2f657874527574507265737461646f723e3c657874527574456d69736f723e303030393039383335302d343c2f657874527574456d69736f723e3c6578744c697350726573743e303130313030332020207c30307c30317c303030303031323639307c303030303030353038307c303030303030303030307c3c2f6578744c697350726573743e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[5]=15366###__COLA_MOTOR__[10]=integrafar###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[27]=2014-08-11 10:26:24.1909-04###INPUT_CIA[2794]=504f5354202f436f6e6669726d6163696f6e2f436f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e32372e31312e36313a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313137370a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e34353c2f657874436f6453656775726f3e3c657874436f644c756761723e31333530353c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e3631373139383330363c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393133333138323c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e31323639303c2f4578744d746f546f743e3c4578744d746f436f7061676f3e353038303c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e303c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303831313c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303030343336343137352d313c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303030393039383335302d343c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303037363339383030302d363c2f657874527574507265737461646f723e3c657874527574456d69736f723e303030393039383335302d343c2f657874527574456d69736f723e3c6578744c697350726573743e303130313030332020207c30307c30317c303030303031323639307c303030303030353038307c303030303030303030307c3c2f6578744c697350726573743e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[610]=<![CDATA[
<MsgInput><extCodFinanciador>1</extCodFinanciador><extCodSeguro>45</extCodSeguro><extCodLugar>13505</extCodLugar><extFolioBono>617198306</extFolioBono><extNumOperacion>39133182</extNumOperacion><ExtMtoTot>12690</ExtMtoTot><ExtMtoCopago>5080</ExtMtoCopago><ExtMtoBonif>0</ExtMtoBonif><extFechaEmision>20140811</extFechaEmision><extRutBeneficiario>0004364175-1</extRutBeneficiario><extRutCajero>0009098350-4</extRutCajero><extRutPrestador>0076398000-6</extRutPrestador><extRutEmisor>0009098350-4</extRutEmisor><extLisPrest>0101003   |00|01|0000012690|0000005080|0000000000|</extLisPrest></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[10]=integrafar###TX_CIA[12]=Confirmacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[17]=FALLA_CONEXION_BD###RESPUESTA_CIA[806]=HTTP/1.1 200 OK
Date: Mon, 11 Aug 2014 14:25:54 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 573

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult>&lt;MsgOutput&gt;&lt;extFolioAuto&gt;0&lt;/extFolioAuto&gt; &lt;extCodError&gt;S&lt;/extCodError&gt;&lt;extMensajeError&gt;Autorizada&lt;/extMensajeError&gt;&lt;/MsgOutput&gt;</wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[117]=declare	@CodError tinyint execute CSConfirmaSegU 617198306,1,0, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:11.386042-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:11.383704-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[209]=><extFolioAuto>0</extFolioAuto> <extCodError>S</extCodError><extMensajeError>Autorizada</extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-11 10:26:24.227069-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '45', 'Confirmacion');
INSERT INTO confirma_integrafar VALUES (18123, '2014-08-19 09:36:00.39608', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3713633###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[10]=Autorizada###EXTCODERROR[1]=S###_LOG_[242]=Falla Confirmacion de Sybase, se reintenta
174011392*<09> ID COLA=18123 SQL=declare	@CodError tinyint execute CSConfirmaSegU 617581780,1,0, @CodError OUTPUT select @CodError as respuesta_sybase
174011392*<09> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=617581780###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0019323480-1###NUM_OPERACION[8]=39347960###CODIGO_CIA[2]=45###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=9###CONTENT_LENGTH[4]=1069###REQUEST_METHOD[4]=POST###REQUEST_URI[32]=/Confirmacion/cia_seg_integrafar###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[32]=/Confirmacion/cia_seg_integrafar###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.64###REMOTE_PORT[5]=38564###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1069###INPUT[1778]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e34353c2f657874436f6453656775726f3e3c657874436f644c756761723e31333430373c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e3631373538313738303c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393334373936303c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e31383139303c2f4578744d746f546f743e3c4578744d746f436f7061676f3e31313337303c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e353638363c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303831393c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303031393332333438302d313c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303031303738313937362d323c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303037363339383030302d363c2f657874527574507265737461646f723e3c657874527574456d69736f723e303031303738313937362d323c2f657874527574456d69736f723e3c6578744c697350726573743e303130313030322020207c30307c30317c303030303031383139307c303030303031313337307c303030303030353638367c3c2f6578744c697350726573743e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[5]=18123###__COLA_MOTOR__[10]=integrafar###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-19 09:38:14.023041-04###INPUT_CIA[2802]=504f5354202f436f6e6669726d6163696f6e2f436f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e32372e31312e36313a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313138310a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e34353c2f657874436f6453656775726f3e3c657874436f644c756761723e31333430373c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e3631373538313738303c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393334373936303c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e31383139303c2f4578744d746f546f743e3c4578744d746f436f7061676f3e31313337303c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e353638363c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303831393c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303031393332333438302d313c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303031303738313937362d323c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303037363339383030302d363c2f657874527574507265737461646f723e3c657874527574456d69736f723e303031303738313937362d323c2f657874527574456d69736f723e3c6578744c697350726573743e303130313030322020207c30307c30317c303030303031383139307c303030303031313337307c303030303030353638367c3c2f6578744c697350726573743e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[614]=<![CDATA[
<MsgInput><extCodFinanciador>1</extCodFinanciador><extCodSeguro>45</extCodSeguro><extCodLugar>13407</extCodLugar><extFolioBono>617581780</extFolioBono><extNumOperacion>39347960</extNumOperacion><ExtMtoTot>18190</ExtMtoTot><ExtMtoCopago>11370</ExtMtoCopago><ExtMtoBonif>5686</ExtMtoBonif><extFechaEmision>20140819</extFechaEmision><extRutBeneficiario>0019323480-1</extRutBeneficiario><extRutCajero>0010781976-2</extRutCajero><extRutPrestador>0076398000-6</extRutPrestador><extRutEmisor>0010781976-2</extRutEmisor><extLisPrest>0101002   |00|01|0000018190|0000011370|0000005686|</extLisPrest></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[10]=integrafar###TX_CIA[12]=Confirmacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[17]=FALLA_CONEXION_BD###RESPUESTA_CIA[806]=HTTP/1.1 200 OK
Date: Tue, 19 Aug 2014 13:38:20 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 573

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult>&lt;MsgOutput&gt;&lt;extFolioAuto&gt;0&lt;/extFolioAuto&gt; &lt;extCodError&gt;S&lt;/extCodError&gt;&lt;extMensajeError&gt;Autorizada&lt;/extMensajeError&gt;&lt;/MsgOutput&gt;</wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[117]=declare	@CodError tinyint execute CSConfirmaSegU 617581780,1,0, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:11.391949-04###TIEMPO_INI_SYBASE[27]=2014-09-05 17:40:11.3896-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[209]=><extFolioAuto>0</extFolioAuto> <extCodError>S</extCodError><extMensajeError>Autorizada</extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[28]=2014-08-19 09:38:55.24771-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '45', 'Confirmacion');
INSERT INTO confirma_integrafar VALUES (18124, '2014-08-19 09:36:04.024604', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3713643###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[10]=Autorizada###EXTCODERROR[1]=S###_LOG_[242]=Falla Confirmacion de Sybase, se reintenta
174011397*<09> ID COLA=18124 SQL=declare	@CodError tinyint execute CSConfirmaSegU 617581790,1,0, @CodError OUTPUT select @CodError as respuesta_sybase
174011397*<09> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=617581790###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0012503125-0###NUM_OPERACION[8]=39347980###CODIGO_CIA[2]=45###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=9###CONTENT_LENGTH[4]=1066###REQUEST_METHOD[4]=POST###REQUEST_URI[32]=/Confirmacion/cia_seg_integrafar###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[32]=/Confirmacion/cia_seg_integrafar###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.161###REMOTE_PORT[5]=46094###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1066###INPUT[1772]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e34353c2f657874436f6453656775726f3e3c657874436f644c756761723e31333530323c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e3631373538313739303c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393334373938303c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e32303438303c2f4578744d746f546f743e3c4578744d746f436f7061676f3e31343038303c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e303c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303831393c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303031323530333132352d303c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303030373730333934322d323c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303037363339383030302d363c2f657874527574507265737461646f723e3c657874527574456d69736f723e303030373730333934322d323c2f657874527574456d69736f723e3c6578744c697350726573743e303430343031322020207c30307c30317c303030303032303438307c303030303031343038307c303030303030303030307c3c2f6578744c697350726573743e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[5]=18124###__COLA_MOTOR__[10]=integrafar###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-19 09:38:55.274704-04###INPUT_CIA[2796]=504f5354202f436f6e6669726d6163696f6e2f436f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e32372e31312e36313a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313137380a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f436f6e6669726d6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e3c657874436f6453656775726f3e34353c2f657874436f6453656775726f3e3c657874436f644c756761723e31333530323c2f657874436f644c756761723e3c657874466f6c696f426f6e6f3e3631373538313739303c2f657874466f6c696f426f6e6f3e3c6578744e756d4f7065726163696f6e3e33393334373938303c2f6578744e756d4f7065726163696f6e3e3c4578744d746f546f743e32303438303c2f4578744d746f546f743e3c4578744d746f436f7061676f3e31343038303c2f4578744d746f436f7061676f3e3c4578744d746f426f6e69663e303c2f4578744d746f426f6e69663e3c6578744665636861456d6973696f6e3e32303134303831393c2f6578744665636861456d6973696f6e3e3c65787452757442656e65666963696172696f3e303031323530333132352d303c2f65787452757442656e65666963696172696f3e3c65787452757443616a65726f3e303030373730333934322d323c2f65787452757443616a65726f3e3c657874527574507265737461646f723e303037363339383030302d363c2f657874527574507265737461646f723e3c657874527574456d69736f723e303030373730333934322d323c2f657874527574456d69736f723e3c6578744c697350726573743e303430343031322020207c30307c30317c303030303032303438307c303030303031343038307c303030303030303030307c3c2f6578744c697350726573743e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[611]=<![CDATA[
<MsgInput><extCodFinanciador>1</extCodFinanciador><extCodSeguro>45</extCodSeguro><extCodLugar>13502</extCodLugar><extFolioBono>617581790</extFolioBono><extNumOperacion>39347980</extNumOperacion><ExtMtoTot>20480</ExtMtoTot><ExtMtoCopago>14080</ExtMtoCopago><ExtMtoBonif>0</ExtMtoBonif><extFechaEmision>20140819</extFechaEmision><extRutBeneficiario>0012503125-0</extRutBeneficiario><extRutCajero>0007703942-2</extRutCajero><extRutPrestador>0076398000-6</extRutPrestador><extRutEmisor>0007703942-2</extRutEmisor><extLisPrest>0404012   |00|01|0000020480|0000014080|0000000000|</extLisPrest></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[10]=integrafar###TX_CIA[12]=Confirmacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[17]=FALLA_CONEXION_BD###RESPUESTA_CIA[806]=HTTP/1.1 200 OK
Date: Tue, 19 Aug 2014 13:38:20 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 573

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult>&lt;MsgOutput&gt;&lt;extFolioAuto&gt;0&lt;/extFolioAuto&gt; &lt;extCodError&gt;S&lt;/extCodError&gt;&lt;extMensajeError&gt;Autorizada&lt;/extMensajeError&gt;&lt;/MsgOutput&gt;</wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[117]=declare	@CodError tinyint execute CSConfirmaSegU 617581790,1,0, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[28]=2014-09-05 17:40:11.39751-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:11.395495-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[209]=><extFolioAuto>0</extFolioAuto> <extCodError>S</extCodError><extMensajeError>Autorizada</extMensajeError></MsgOutput></wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-19 09:38:55.282541-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '45', 'Confirmacion');


--
-- Name: confirma_integrafar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_integrafar_id_seq', 23159, true);


--
-- Data for Name: confirma_inter; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_inter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_inter_id_seq', 2, true);


--
-- Data for Name: confirma_metlife; Type: TABLE DATA; Schema: public; Owner: motor
--

INSERT INTO confirma_metlife VALUES (370017, '2014-08-22 11:40:58.88094', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3974451###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[166]=Falla Confirmacion de Sybase, se reintenta
174004792*<12> ID COLA=370017 SQL=call CSConfirmaSegU(50715176,67,7680739)
174004792*<12> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[8]=50715176###EXTFOLIOAUTO[7]=7680739###EXTRUTBENEFICIARIO[12]=0010033772-K###NUM_OPERACION[9]=400000078###CODIGO_CIA[2]=12###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=12###CONTENT_LENGTH[4]=1086###REQUEST_METHOD[4]=POST###REQUEST_URI[34]=/ConfirmacionBono3/cia_seg_metlife###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[34]=/ConfirmacionBono3/cia_seg_metlife###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=50015###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1086###INPUT[1812]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e36373c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e31323c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333932393c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e35303731353137363c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303037383c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e32333837333c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e31363235393c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e31333030373c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303832323c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303031303033333737322d4b3c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303031313437333436312d363c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303039393539383037302d333c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e303031313437333436312d363c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313830302020207c30307c30317c303030303032333837337c303030303031363235397c303030303031333030377c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[5]=FALLA###TX[4]=4001###__ID_DTE__[6]=370017###__COLA_MOTOR__[7]=metlife###__STS_ERROR_PXML__[6]=ERR_NK###TIEMPO_INI_CIA[29]=2014-08-22 11:40:59.210848-04###INPUT_CIA[2648]=504f5354202f494657494d454477732f57532f7773436f6e6669726d6163696f6e2e61736d7820485454502f312e310a486f73743a203137322e32322e312e33303a3230340a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276436f6e6669726d6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a20313130310a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f220a20786d6c6e733a534f41502d454e433d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e636f64696e672f220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e36373c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e31323c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333932393c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e35303731353137363c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303037383c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e32333837333c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e31363235393c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e31333030373c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303832323c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303031303033333737322d4b3c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303031313437333436312d363c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303039393539383037302d333c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e303031313437333436312d363c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313830302020207c30307c30317c303030303032333837337c303030303031363235397c303030303031333030377c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e###DATA_CIA[676]=<![CDATA[
<MsgInput>\012<extCodFinanciador>67</extCodFinanciador>\012<extCodSeguro>12</extCodSeguro>\012<extCodLugar>13929</extCodLugar>\012<extFolioBono>50715176</extFolioBono>\012<extNumOperacion>400000078</extNumOperacion>\012<ExtMtoTot>23873</ExtMtoTot>\012<ExtMtoCopago>16259</ExtMtoCopago>\012<ExtMtoBonif>13007</ExtMtoBonif>\012<extFechaEmision>20140822</extFechaEmision>\012<extRutBeneficiario>0010033772-K</extRutBeneficiario>\012<extRutCajero>0011473461-6</extRutCajero>\012<extRutPrestador>0099598070-3</extRutPrestador>\012<extRutEmisor>0011473461-6</extRutEmisor>\012<extLisPrest>0101800   |00|01|0000023873|0000016259|0000013007|</extLisPrest>\012</MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[7]=metlife###TX_CIA[17]=ConfirmacionBono3###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[17]=FALLA_CONEXION_BD###RESPUESTA_CIA[903]=HTTP/1.1 100 Continue
Server: Microsoft-IIS/5.0
Date: Fri, 22 Aug 2014 15:40:22 GMT
X-Powered-By: ASP.NET

HTTP/1.1 200 OK
Server: Microsoft-IIS/5.0
Date: Fri, 22 Aug 2014 15:40:22 GMT
X-Powered-By: ASP.NET
X-AspNet-Version: 1.1.4322
Cache-Control: private, max-age=0
Content-Type: text/xml; charset=utf-8
Content-Length: 576

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvConfirmacionResponse xmlns="http://tempuri.org/"><wmImed_SrvConfirmacionResult>
  &lt;MsgOutput&gt;
    &lt;extFolioAuto&gt;7680739&lt;/extFolioAuto&gt;
    &lt;extCodError&gt;S&lt;/extCodError&gt;
    &lt;extMensajeError /&gt;
  &lt;/MsgOutput&gt;
</wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[40]=call CSConfirmaSegU(50715176,67,7680739)###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:04.791973-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:04.777926-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[212]=>
    <extFolioAuto>7680739</extFolioAuto>
    <extCodError>S</extCodError>
    <extMensajeError />
  </MsgOutput>
</wmImed_SrvConfirmacionResult></wmImed_SrvConfirmacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-22 11:40:59.245406-04###API_CODRESPUESTA[1]=2###API_TIPO[3]=SQL###ERROR[60]=General SQL Server error: Check messages from the SQL Server###API_DESCRIPCION_ERROR[60]=General SQL Server error: Check messages from the SQL Server###API_ERROR[3]=102###API_DESCRIPCION_MSG[34]=Incorrect syntax near <C>50715176<C>.
###__XML__[0]=###', '12', 'ConfirmacionBono3');


--
-- Data for Name: confirma_metlife_cert; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_metlife_cert_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_metlife_cert_id_seq', 37, true);


--
-- Name: confirma_metlife_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_metlife_id_seq', 455034, true);


--
-- Data for Name: confirma_metlife_mpro; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_metlife_mpro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_metlife_mpro_id_seq', 1, true);


--
-- Data for Name: confirma_mpro2; Type: TABLE DATA; Schema: public; Owner: motor
--

INSERT INTO confirma_mpro2 VALUES (13869, '2014-08-30 16:26:12.768504', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4417863###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[993]=POST-/ConfirmacionBono3/cia_seg_mpro
162612769*<21> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacion><ns1:XML_INPUT><MsgInput>\012<extCodFinanciador>1</extCodFinanciador>\012<extCodSeguro>43</extCodSeguro>\012<extCodLugar>13625</extCodLugar>\012<extFolioBono>618243216</extFolioBono>\012<extNumOperacion>400000320</extNumOperacion>\012<ExtMtoTot>10350</ExtMtoTot>\012<ExtMtoCopago>5390</ExtMtoCopago>\012<ExtMtoBonif> </ExtMtoBonif>\012<extFechaEmision>20140830</extFechaEmision>\012<extRutBeneficiario>0012174716-2</extRutBeneficiario>\012<extRutCajero>0012852818-0</extRutCajero>\012<extRutPrestador>0077131810-K</extRutPrestador>\012<extRutEmisor> </extRutEmisor>\012<extLisPrest>0101001   |00|01|0000010350|0000005390|0000000000|</extLisPrest>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvConfirmacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=618243216###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0012174716-2###NUM_OPERACION[9]=400000320###CODIGO_CIA[2]=43###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=21###CONTENT_LENGTH[4]=1070###REQUEST_METHOD[4]=POST###REQUEST_URI[31]=/ConfirmacionBono3/cia_seg_mpro###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[31]=/ConfirmacionBono3/cia_seg_mpro###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=46852###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1070###INPUT[1780]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e34333c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333632353c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e3631383234333231363c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303332303c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e31303335303c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e353339303c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e203c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303833303c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303031323137343731362d323c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303031323835323831382d303c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303037373133313831302d4b3c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e203c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303335307c303030303030353339307c303030303030303030307c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '43', 'ConfirmacionBono3');


--
-- Name: confirma_mpro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_mpro_id_seq', 14304, true);


--
-- Data for Name: confirma_mprobci; Type: TABLE DATA; Schema: public; Owner: motor
--

INSERT INTO confirma_mprobci VALUES (128439, '2014-08-18 17:32:44.268688', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3684202###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[258]=Falla Confirmacion de Sybase, se reintenta
174004909*<03> ID COLA=128439 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 975379077,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174004909*<03> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=975379077###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=27###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=3###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[26]=/Anulacion/cia_seg_mprobci###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[26]=/Anulacion/cia_seg_mprobci###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.63###REMOTE_PORT[5]=33775###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e32373c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e373233353832313c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353337393037373c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=128439###__COLA_MOTOR__[7]=mprobci###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-18 17:32:44.535176-04###INPUT_CIA[2018]=504f5354202f77735f6263695f70726f642f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203739380a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6453656775726f2667743b3237266c743b2f657874436f6453656775726f2667743b266c743b65787452757442656e65666963696172696f2667743b303030303030303030303030266c743b2f65787452757442656e65666963696172696f2667743b266c743b657874466f6c696f4175746f2667743b37323335383231266c743b2f657874466f6c696f4175746f2667743b266c743b657874466f6c696f426f6e6f2667743b393735333739303737266c743b2f657874466f6c696f426f6e6f2667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[239]=&lt;MsgInput&gt;&lt;extCodSeguro&gt;27&lt;/extCodSeguro&gt;&lt;extRutBeneficiario&gt;000000000000&lt;/extRutBeneficiario&gt;&lt;extFolioAuto&gt;7235821&lt;/extFolioAuto&gt;&lt;extFolioBono&gt;975379077&lt;/extFolioBono&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[7]=mprobci###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[714]=HTTP/1.1 200 OK
Date: Mon, 18 Aug 2014 21:32:13 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 481

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 975379077,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:04.909334-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:04.895647-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-18 17:32:47.233072-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '27', 'Anulacion');
INSERT INTO confirma_mprobci VALUES (138744, '2014-08-22 09:25:11.075531', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3959632###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[257]=Falla Confirmacion de Sybase, se reintenta
174004929*<03> ID COLA=138744 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 50709940,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174004930*<03> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[8]=50709940###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=27###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=3###CONTENT_LENGTH[3]=521###REQUEST_METHOD[4]=POST###REQUEST_URI[26]=/Anulacion/cia_seg_mprobci###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[26]=/Anulacion/cia_seg_mprobci###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.161###REMOTE_PORT[5]=43409###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=521###INPUT[922]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e32373c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e373234363331393c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e35303730393934303c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=138744###__COLA_MOTOR__[7]=mprobci###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-22 09:25:12.407965-04###INPUT_CIA[2016]=504f5354202f77735f6263695f70726f642f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203739370a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6453656775726f2667743b3237266c743b2f657874436f6453656775726f2667743b266c743b65787452757442656e65666963696172696f2667743b303030303030303030303030266c743b2f65787452757442656e65666963696172696f2667743b266c743b657874466f6c696f4175746f2667743b37323436333139266c743b2f657874466f6c696f4175746f2667743b266c743b657874466f6c696f426f6e6f2667743b3530373039393430266c743b2f657874466f6c696f426f6e6f2667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[238]=&lt;MsgInput&gt;&lt;extCodSeguro&gt;27&lt;/extCodSeguro&gt;&lt;extRutBeneficiario&gt;000000000000&lt;/extRutBeneficiario&gt;&lt;extFolioAuto&gt;7246319&lt;/extFolioAuto&gt;&lt;extFolioBono&gt;50709940&lt;/extFolioBono&gt;&lt;/MsgInput&gt;###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[7]=mprobci###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[714]=HTTP/1.1 200 OK
Date: Fri, 22 Aug 2014 13:24:36 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 481

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[127]=declare	@CodError tinyint execute CSConfirmaAnuU 50709940,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:04.929735-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:04.919981-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-22 09:25:12.601967-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '27', 'Anulacion');
INSERT INTO confirma_mprobci VALUES (139701, '2014-08-22 13:59:22.799322', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=3984029###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[500]=POST-/AnulacionBono3/cia_seg_mprobci
135922800*<07> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacion><ns1:XML_INPUT><MsgInput>\012<extCodSeguro>27</extCodSeguro>\012<extRutBeneficiario>0006069508-3</extRutBeneficiario>\012<extFolioAuto>400000084</extFolioAuto>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvAnulacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[0]=###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0006069508-3###NUM_OPERACION[0]=###CODIGO_CIA[2]=27###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=7###CONTENT_LENGTH[3]=478###REQUEST_METHOD[4]=POST###REQUEST_URI[31]=/AnulacionBono3/cia_seg_mprobci###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[31]=/AnulacionBono3/cia_seg_mprobci###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=52248###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=478###INPUT[860]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6453656775726f3e32373c2f657874436f6453656775726f3e0a3c65787452757442656e65666963696172696f3e303030363036393530382d333c2f65787452757442656e65666963696172696f3e0a3c657874466f6c696f4175746f3e3430303030303038343c2f657874466f6c696f4175746f3e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '27', 'AnulacionBono3');
INSERT INTO confirma_mprobci VALUES (144920, '2014-08-25 18:58:38.478314', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4117005###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[515]=POST-/Anulacion/cia_seg_mprobci
185838479*<24> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacion><ns1:XML_INPUT><MsgInput><extCodSeguro>27</extCodSeguro><extRutBeneficiario>0014118187-4</extRutBeneficiario><extFolioAuto>7252385</extFolioAuto><extFolioBono>219123162</extFolioBono></MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvAnulacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=219123162###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0014118187-4###NUM_OPERACION[0]=###CODIGO_CIA[2]=27###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=24###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[26]=/Anulacion/cia_seg_mprobci###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[26]=/Anulacion/cia_seg_mprobci###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.64###REMOTE_PORT[5]=50528###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e32373c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e303031343131383138372d343c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e373235323338353c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3231393132333136323c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '27', 'Anulacion');
INSERT INTO confirma_mprobci VALUES (151216, '2014-08-28 09:16:36.519135', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4270499###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[1095]=POST-/ConfirmacionBono3/cia_seg_mprobci
091636519*<19> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacion><ns1:XML_INPUT><MsgInput>\012<extCodFinanciador>1</extCodFinanciador>\012<extCodSeguro>27</extCodSeguro>\012<extCodLugar>13625</extCodLugar>\012<extFolioBono>618103706</extFolioBono>\012<extNumOperacion>400000186</extNumOperacion>\012<ExtMtoTot>770</ExtMtoTot>\012<ExtMtoCopago>480</ExtMtoCopago>\012<ExtMtoBonif>288</ExtMtoBonif>\012<extFechaEmision>20140828</extFechaEmision>\012<extRutBeneficiario>0020788178-3</extRutBeneficiario>\012<extRutCajero>0013960290-0</extRutCajero>\012<extRutPrestador>0087975900-5</extRutPrestador>\012<extRutEmisor> </extRutEmisor>\012<extLisPrest>0301045   |00|01|0000002810|0000001730|0000001038|0302047   |00|01|0000001200|0000000740|0000000444|0307012   |00|01|0000000770|0000000480|0000000288|</extLisPrest>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvConfirmacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=618103706###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0020788178-3###NUM_OPERACION[9]=400000186###CODIGO_CIA[2]=27###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=19###CONTENT_LENGTH[4]=1169###REQUEST_METHOD[4]=POST###REQUEST_URI[34]=/ConfirmacionBono3/cia_seg_mprobci###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[34]=/ConfirmacionBono3/cia_seg_mprobci###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=46693###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1169###INPUT[1978]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e32373c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333632353c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e3631383130333730363c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303138363c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e3737303c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e3438303c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e3238383c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303832383c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303032303738383137382d333c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303031333936303239302d303c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303038373937353930302d353c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e203c2f657874527574456d69736f723e0a3c6578744c697350726573743e303330313034352020207c30307c30317c303030303030323831307c303030303030313733307c303030303030313033387c303330323034372020207c30307c30317c303030303030313230307c303030303030303734307c303030303030303434347c303330373031322020207c30307c30317c303030303030303737307c303030303030303438307c303030303030303238387c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '27', 'ConfirmacionBono3');
INSERT INTO confirma_mprobci VALUES (152053, '2014-08-28 12:49:53.398427', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4291355###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[996]=POST-/ConfirmacionBono3/cia_seg_mprobci
124953399*<18> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacion><ns1:XML_INPUT><MsgInput>\012<extCodFinanciador>1</extCodFinanciador>\012<extCodSeguro>27</extCodSeguro>\012<extCodLugar>13625</extCodLugar>\012<extFolioBono>618126603</extFolioBono>\012<extNumOperacion>400000201</extNumOperacion>\012<ExtMtoTot>10350</ExtMtoTot>\012<ExtMtoCopago>5390</ExtMtoCopago>\012<ExtMtoBonif> </ExtMtoBonif>\012<extFechaEmision>20140828</extFechaEmision>\012<extRutBeneficiario>0007369352-7</extRutBeneficiario>\012<extRutCajero>0013960290-0</extRutCajero>\012<extRutPrestador>0077131810-K</extRutPrestador>\012<extRutEmisor> </extRutEmisor>\012<extLisPrest>0101001   |00|01|0000010350|0000005390|0000000000|</extLisPrest>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvConfirmacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=618126603###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0007369352-7###NUM_OPERACION[9]=400000201###CODIGO_CIA[2]=27###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=18###CONTENT_LENGTH[4]=1070###REQUEST_METHOD[4]=POST###REQUEST_URI[34]=/ConfirmacionBono3/cia_seg_mprobci###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[34]=/ConfirmacionBono3/cia_seg_mprobci###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=53117###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1070###INPUT[1780]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e32373c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333632353c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e3631383132363630333c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303230313c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e31303335303c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e353339303c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e203c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303832383c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303030373336393335322d373c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303031333936303239302d303c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303037373133313831302d4b3c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e203c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303335307c303030303030353339307c303030303030303030307c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '27', 'ConfirmacionBono3');
INSERT INTO confirma_mprobci VALUES (157927, '2014-09-01 10:09:46.746847', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4439481###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[999]=POST-/ConfirmacionBono3/cia_seg_mprobci
100946747*<03> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacion><ns1:XML_INPUT><MsgInput>\012<extCodFinanciador>1</extCodFinanciador>\012<extCodSeguro>27</extCodSeguro>\012<extCodLugar>13625</extCodLugar>\012<extFolioBono>618264050</extFolioBono>\012<extNumOperacion>400000356</extNumOperacion>\012<ExtMtoTot>10350</ExtMtoTot>\012<ExtMtoCopago>5390</ExtMtoCopago>\012<ExtMtoBonif>3773</ExtMtoBonif>\012<extFechaEmision>20140901</extFechaEmision>\012<extRutBeneficiario>0006027950-0</extRutBeneficiario>\012<extRutCajero>0012852818-0</extRutCajero>\012<extRutPrestador>0077131810-K</extRutPrestador>\012<extRutEmisor> </extRutEmisor>\012<extLisPrest>0101001   |00|01|0000010350|0000005390|0000003773|</extLisPrest>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvConfirmacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=618264050###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0006027950-0###NUM_OPERACION[9]=400000356###CODIGO_CIA[2]=27###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=3###CONTENT_LENGTH[4]=1073###REQUEST_METHOD[4]=POST###REQUEST_URI[34]=/ConfirmacionBono3/cia_seg_mprobci###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[34]=/ConfirmacionBono3/cia_seg_mprobci###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=52189###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1073###INPUT[1786]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e32373c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333632353c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e3631383236343035303c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303335363c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e31303335303c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e353339303c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e333737333c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303930313c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303030363032373935302d303c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303031323835323831382d303c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303037373133313831302d4b3c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e203c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303335307c303030303030353339307c303030303030333737337c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '27', 'ConfirmacionBono3');
INSERT INTO confirma_mprobci VALUES (159891, '2014-09-01 18:08:10.320105', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4487001###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[999]=POST-/ConfirmacionBono3/cia_seg_mprobci
180810320*<09> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacion><ns1:XML_INPUT><MsgInput>\012<extCodFinanciador>1</extCodFinanciador>\012<extCodSeguro>27</extCodSeguro>\012<extCodLugar>13625</extCodLugar>\012<extFolioBono>618312057</extFolioBono>\012<extNumOperacion>400000396</extNumOperacion>\012<ExtMtoTot>10350</ExtMtoTot>\012<ExtMtoCopago>5390</ExtMtoCopago>\012<ExtMtoBonif>3773</ExtMtoBonif>\012<extFechaEmision>20140901</extFechaEmision>\012<extRutBeneficiario>0024422138-6</extRutBeneficiario>\012<extRutCajero>0009152631-K</extRutCajero>\012<extRutPrestador>0077131810-K</extRutPrestador>\012<extRutEmisor> </extRutEmisor>\012<extLisPrest>0101001   |00|01|0000010350|0000005390|0000003773|</extLisPrest>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvConfirmacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=618312057###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0024422138-6###NUM_OPERACION[9]=400000396###CODIGO_CIA[2]=27###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=9###CONTENT_LENGTH[4]=1073###REQUEST_METHOD[4]=POST###REQUEST_URI[34]=/ConfirmacionBono3/cia_seg_mprobci###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[34]=/ConfirmacionBono3/cia_seg_mprobci###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=54688###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1073###INPUT[1786]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e32373c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333632353c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e3631383331323035373c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303339363c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e31303335303c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e353339303c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e333737333c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303930313c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303032343432323133382d363c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303030393135323633312d4b3c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303037373133313831302d4b3c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e203c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303335307c303030303030353339307c303030303030333737337c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '27', 'ConfirmacionBono3');
INSERT INTO confirma_mprobci VALUES (159922, '2014-09-01 18:11:01.140478', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4487363###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[999]=POST-/ConfirmacionBono3/cia_seg_mprobci
181101141*<24> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacion><ns1:XML_INPUT><MsgInput>\012<extCodFinanciador>1</extCodFinanciador>\012<extCodSeguro>27</extCodSeguro>\012<extCodLugar>13625</extCodLugar>\012<extFolioBono>618312325</extFolioBono>\012<extNumOperacion>400000397</extNumOperacion>\012<ExtMtoTot>10350</ExtMtoTot>\012<ExtMtoCopago>5390</ExtMtoCopago>\012<ExtMtoBonif>3773</ExtMtoBonif>\012<extFechaEmision>20140901</extFechaEmision>\012<extRutBeneficiario>0021096988-8</extRutBeneficiario>\012<extRutCajero>0009152631-K</extRutCajero>\012<extRutPrestador>0077131810-K</extRutPrestador>\012<extRutEmisor> </extRutEmisor>\012<extLisPrest>0101001   |00|01|0000010350|0000005390|0000003773|</extLisPrest>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvConfirmacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=618312325###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0021096988-8###NUM_OPERACION[9]=400000397###CODIGO_CIA[2]=27###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=24###CONTENT_LENGTH[4]=1073###REQUEST_METHOD[4]=POST###REQUEST_URI[34]=/ConfirmacionBono3/cia_seg_mprobci###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[34]=/ConfirmacionBono3/cia_seg_mprobci###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=54810###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1073###INPUT[1786]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e32373c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333632353c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e3631383331323332353c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303339373c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e31303335303c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e353339303c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e333737333c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303930313c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303032313039363938382d383c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303030393135323633312d4b3c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303037373133313831302d4b3c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e203c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303335307c303030303030353339307c303030303030333737337c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '27', 'ConfirmacionBono3');
INSERT INTO confirma_mprobci VALUES (160323, '2014-09-01 20:41:03.416326', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4496832###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[996]=POST-/ConfirmacionBono3/cia_seg_mprobci
204103417*<38> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacion><ns1:XML_INPUT><MsgInput>\012<extCodFinanciador>1</extCodFinanciador>\012<extCodSeguro>27</extCodSeguro>\012<extCodLugar>13625</extCodLugar>\012<extFolioBono>618318772</extFolioBono>\012<extNumOperacion>400000415</extNumOperacion>\012<ExtMtoTot>10350</ExtMtoTot>\012<ExtMtoCopago>5390</ExtMtoCopago>\012<ExtMtoBonif> </ExtMtoBonif>\012<extFechaEmision>20140901</extFechaEmision>\012<extRutBeneficiario>0016804772-K</extRutBeneficiario>\012<extRutCajero>0009152631-K</extRutCajero>\012<extRutPrestador>0077131810-K</extRutPrestador>\012<extRutEmisor> </extRutEmisor>\012<extLisPrest>0101001   |00|01|0000010350|0000005390|0000000000|</extLisPrest>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvConfirmacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=618318772###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0016804772-K###NUM_OPERACION[9]=400000415###CODIGO_CIA[2]=27###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=38###CONTENT_LENGTH[4]=1070###REQUEST_METHOD[4]=POST###REQUEST_URI[34]=/ConfirmacionBono3/cia_seg_mprobci###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[34]=/ConfirmacionBono3/cia_seg_mprobci###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=58097###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1070###INPUT[1780]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e32373c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333632353c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e3631383331383737323c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303431353c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e31303335303c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e353339303c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e203c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303930313c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303031363830343737322d4b3c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303030393135323633312d4b3c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303037373133313831302d4b3c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e203c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303335307c303030303030353339307c303030303030303030307c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '27', 'ConfirmacionBono3');
INSERT INTO confirma_mprobci VALUES (163651, '2014-09-02 20:29:29.678823', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=4573671###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[258]=Falla Confirmacion de Sybase, se reintenta
174007649*<03> ID COLA=163651 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 975190682,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174007649*<03> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=975190682###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=27###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[1]=3###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[26]=/Anulacion/cia_seg_mprobci###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[26]=/Anulacion/cia_seg_mprobci###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.63###REMOTE_PORT[5]=54085###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e32373c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e373237303631323c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353139303638323c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=163651###__COLA_MOTOR__[7]=mprobci###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-09-02 20:29:38.694241-04###INPUT_CIA[2018]=504f5354202f77735f6263695f70726f642f616e756c6163696f6e2e61736d7820485454502f312e310a486f73743a2031302e39302e31302e383a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203739380a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e266c743b4d7367496e7075742667743b266c743b657874436f6453656775726f2667743b3237266c743b2f657874436f6453656775726f2667743b266c743b65787452757442656e65666963696172696f2667743b303030303030303030303030266c743b2f65787452757442656e65666963696172696f2667743b266c743b657874466f6c696f4175746f2667743b37323730363132266c743b2f657874466f6c696f4175746f2667743b266c743b657874466f6c696f426f6e6f2667743b393735313930363832266c743b2f657874466f6c696f426f6e6f2667743b266c743b2f4d7367496e7075742667743b3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[239]=&lt;MsgInput&gt;&lt;extCodSeguro&gt;27&lt;/extCodSeguro&gt;&lt;extRutBeneficiario&gt;000000000000&lt;/extRutBeneficiario&gt;&lt;extFolioAuto&gt;7270612&lt;/extFolioAuto&gt;&lt;extFolioBono&gt;975190682&lt;/extFolioBono&gt;&lt;/MsgInput&gt;###RUT_PRESTADOR[0]=###COD_LUGAR[0]=###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[7]=mprobci###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[2]=OK###RESPUESTA_CIA[714]=HTTP/1.1 200 OK
Date: Wed, 03 Sep 2014 00:29:36 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 481

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult><MsgOutput xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 975190682,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:07.649353-04###TIEMPO_INI_SYBASE[28]=2014-09-05 17:40:07.62731-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[171]= xmlns=""><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-09-02 20:29:38.922827-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '27', 'Anulacion');
INSERT INTO confirma_mprobci VALUES (168937, '2014-09-04 16:57:08.879564', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4705460###XML_RESPUESTA[351]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacionResponse><ns1:wmImed_SrvConfirmacionResult>&-&DATA&-&</ns1:wmImed_SrvConfirmacionResult></ns1:wmImed_SrvConfirmacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[999]=POST-/ConfirmacionBono3/cia_seg_mprobci
165708880*<27> <?xml version="1.0" encoding="UTF-8"?>\012<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvConfirmacion><ns1:XML_INPUT><MsgInput>\012<extCodFinanciador>1</extCodFinanciador>\012<extCodSeguro>27</extCodSeguro>\012<extCodLugar>13625</extCodLugar>\012<extFolioBono>618519663</extFolioBono>\012<extNumOperacion>400000621</extNumOperacion>\012<ExtMtoTot>10350</ExtMtoTot>\012<ExtMtoCopago>5390</ExtMtoCopago>\012<ExtMtoBonif>3773</ExtMtoBonif>\012<extFechaEmision>20140904</extFechaEmision>\012<extRutBeneficiario>0021355096-9</extRutBeneficiario>\012<extRutCajero>0009152631-K</extRutCajero>\012<extRutPrestador>0077131810-K</extRutPrestador>\012<extRutEmisor> </extRutEmisor>\012<extLisPrest>0101001   |00|01|0000010350|0000005390|0000003773|</extLisPrest>\012</MsgInput></ns1:XML_INPUT></ns1:wmImed_SrvConfirmacion></SOAP-ENV:Body></SOAP-ENV:Envelope>\012###EXTFOLIOBONO[9]=618519663###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[12]=0021355096-9###NUM_OPERACION[9]=400000621###CODIGO_CIA[2]=27###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=27###CONTENT_LENGTH[4]=1073###REQUEST_METHOD[4]=POST###REQUEST_URI[34]=/ConfirmacionBono3/cia_seg_mprobci###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[34]=/ConfirmacionBono3/cia_seg_mprobci###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.55###REMOTE_PORT[5]=43284###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[30]=SoapClient PHP 5.4.4-14+deb7u9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[43]="http://tempuri.org/wmImed_SrvConfirmacion"###HTTP_CONTENT_LENGTH[4]=1073###INPUT[1786]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e0a3c657874436f6446696e616e636961646f723e313c2f657874436f6446696e616e636961646f723e0a3c657874436f6453656775726f3e32373c2f657874436f6453656775726f3e0a3c657874436f644c756761723e31333632353c2f657874436f644c756761723e0a3c657874466f6c696f426f6e6f3e3631383531393636333c2f657874466f6c696f426f6e6f3e0a3c6578744e756d4f7065726163696f6e3e3430303030303632313c2f6578744e756d4f7065726163696f6e3e0a3c4578744d746f546f743e31303335303c2f4578744d746f546f743e0a3c4578744d746f436f7061676f3e353339303c2f4578744d746f436f7061676f3e0a3c4578744d746f426f6e69663e333737333c2f4578744d746f426f6e69663e0a3c6578744665636861456d6973696f6e3e32303134303930343c2f6578744665636861456d6973696f6e3e0a3c65787452757442656e65666963696172696f3e303032313335353039362d393c2f65787452757442656e65666963696172696f3e0a3c65787452757443616a65726f3e303030393135323633312d4b3c2f65787452757443616a65726f3e0a3c657874527574507265737461646f723e303037373133313831302d4b3c2f657874527574507265737461646f723e0a3c657874527574456d69736f723e203c2f657874527574456d69736f723e0a3c6578744c697350726573743e303130313030312020207c30307c30317c303030303031303335307c303030303030353339307c303030303030333737337c3c2f6578744c697350726573743e0a3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276436f6e6669726d6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###', '27', 'ConfirmacionBono3');
INSERT INTO confirma_mprobci VALUES (162559, '2014-09-02 15:51:37.497137', 'INGRESADO', 5, 0, 'CODIGO_MOTOR[7]=4550015###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[1]= ###EXTCODERROR[1]=S###_LOG_[611]=POST-/Anulacion/cia_seg_mprobci
155137497*<37> <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">\015\012   <soapenv:Header/>\015\012   <soapenv:Body>\015\012      <tem:wmImed_SrvAnulacion>\015\012         <!--Optional:-->\015\012         <tem:XML_INPUT><MsgInput><extCodSeguro>27</extCodSeguro><extRutBeneficiario>0014118187-4&l\012t;/extRutBeneficiario><extFolioAuto>7252385</extFolioAuto><extFolioBono>219123162</extFolioBon\012o></MsgInput></tem:XML_INPUT>\015\012      </tem:wmImed_SrvAnulacion>\015\012   </soapenv:Body>\015\012</soapenv:Envelope>###EXTFOLIOBONO[148]=219123162</extFolioBon\012o></MsgInput></tem:XML_INPUT>\015\012      </tem:wmImed_SrvAnulacion>\015\012   </soapenv:Body>\015\012</soapenv:Envelope>###EXTFOLIOAUTO[1]=0###EXTRUTBENEFICIARIO[238]=0014118187-4&l\012t;/extRutBeneficiario><extFolioAuto>7252385</extFolioAuto><extFolioBono>219123162</extFolioBon\012o></MsgInput></tem:XML_INPUT>\015\012      </tem:wmImed_SrvAnulacion>\015\012   </soapenv:Body>\015\012</soapenv:Envelope>###NUM_OPERACION[0]=###CODIGO_CIA[2]=27###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=37###CONTENT_LENGTH[3]=567###REQUEST_METHOD[4]=POST###REQUEST_URI[26]=/Anulacion/cia_seg_mprobci###QUERY_STRING[0]=###CONTENT_TYPE[22]=text/xml;charset=UTF-8###DOCUMENT_URI[26]=/Anulacion/cia_seg_mprobci###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=172.16.2.143###REMOTE_PORT[5]=50911###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_ACCEPT_ENCODING[12]=gzip,deflate###HTTP_CONTENT_TYPE[22]=text/xml;charset=UTF-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=567###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[34]=Apache-HttpClient/4.1.1 (java 1.5)###INPUT[1020]=3c736f6170656e763a456e76656c6f706520786d6c6e733a736f6170656e763d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a74656d3d22687474703a2f2f74656d707572692e6f72672f223e0d0a2020203c736f6170656e763a4865616465722f3e0d0a2020203c736f6170656e763a426f64793e0d0a2020202020203c74656d3a776d496d65645f537276416e756c6163696f6e3e0d0a2020202020202020203c212d2d4f7074696f6e616c3a2d2d3e0d0a2020202020202020203c74656d3a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e32373c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e303031343131383138372d34266c0a743b2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e373235323338353c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3231393132333136323c2f657874466f6c696f426f6e0a6f3e3c2f4d7367496e7075743e3c2f74656d3a584d4c5f494e5055543e0d0a2020202020203c2f74656d3a776d496d65645f537276416e756c6163696f6e3e0d0a2020203c2f736f6170656e763a426f64793e0d0a3c2f736f6170656e763a456e76656c6f70653e###STATUS[2]=OK###TX[4]=4001###', '27', 'Anulacion');


--
-- Name: confirma_mprobci_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_mprobci_id_seq', 172073, true);


--
-- Data for Name: confirma_security; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_security_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_security_id_seq', 1, true);


--
-- Data for Name: confirma_sermecoop; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_sermecoop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_sermecoop_id_seq', 47049, true);


--
-- Data for Name: confirma_servmed; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Data for Name: confirma_trasa; Type: TABLE DATA; Schema: public; Owner: motor
--

INSERT INTO confirma_trasa VALUES (176988, '2014-08-07 18:29:04.280743', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=2328945###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[258]=Falla Confirmacion de Sybase, se reintenta
174006111*<17> ID COLA=176988 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 975487021,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174006111*<17> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=975487021###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=29###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=17###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[24]=/Anulacion/cia_seg_trasa###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[24]=/Anulacion/cia_seg_trasa###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.64###REMOTE_PORT[5]=59601###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e32393c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e363131363930313c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353438373032313c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=176988###__COLA_MOTOR__[5]=trasa###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[28]=2014-08-07 18:29:05.64698-04###INPUT_CIA[1932]=504f5354202f736572766963696f732f7773416e756c6163696f6e2e61736d7820485454502f312e310a486f73743a203139322e3136392e35302e31313a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203735320a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6453656775726f3e32393c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e363131363930313c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353438373032313c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[193]=<![CDATA[
<MsgInput><extCodSeguro>29</extCodSeguro><extRutBeneficiario>000000000000</extRutBeneficiario><extFolioAuto>6116901</extFolioAuto><extFolioBono>975487021</extFolioBono></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[5]=trasa###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[17]=FALLA_CONEXION_BD###RESPUESTA_CIA[741]=HTTP/1.1 200 OK
Date: Thu, 07 Aug 2014 22:31:28 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 508

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult>&lt;MsgOutput&gt;&lt;extCodError&gt;S&lt;/extCodError&gt;&lt;extMensajeError&gt;&lt;/extMensajeError&gt;&lt;/MsgOutput&gt;</wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 975487021,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:06.111443-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:06.108692-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[162]=><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-07 18:29:07.264454-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###ERROR[36]=Adaptive Server connection timed out###API_DESCRIPCION_ERROR[36]=Adaptive Server connection timed out###API_ERROR[5]=20003###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '29', 'Anulacion');
INSERT INTO confirma_trasa VALUES (200563, '2014-08-13 11:33:45.138541', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3463930###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[257]=Falla Confirmacion de Sybase, se reintenta
174006117*<17> ID COLA=200563 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 50579198,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174006117*<17> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[8]=50579198###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=21###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=17###CONTENT_LENGTH[3]=521###REQUEST_METHOD[4]=POST###REQUEST_URI[24]=/Anulacion/cia_seg_trasa###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[24]=/Anulacion/cia_seg_trasa###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.160###REMOTE_PORT[5]=47942###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=521###INPUT[922]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e32313c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e363134303039313c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e35303537393139383c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=200563###__COLA_MOTOR__[5]=trasa###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-13 11:33:46.393296-04###INPUT_CIA[1930]=504f5354202f736572766963696f732f7773416e756c6163696f6e2e61736d7820485454502f312e310a486f73743a203139322e3136392e35302e31313a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203735310a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6453656775726f3e32313c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e363134303039313c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e35303537393139383c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[192]=<![CDATA[
<MsgInput><extCodSeguro>21</extCodSeguro><extRutBeneficiario>000000000000</extRutBeneficiario><extFolioAuto>6140091</extFolioAuto><extFolioBono>50579198</extFolioBono></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[5]=trasa###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[741]=HTTP/1.1 200 OK
Date: Wed, 13 Aug 2014 15:36:19 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 508

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult>&lt;MsgOutput&gt;&lt;extCodError&gt;S&lt;/extCodError&gt;&lt;extMensajeError&gt;&lt;/extMensajeError&gt;&lt;/MsgOutput&gt;</wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[127]=declare	@CodError tinyint execute CSConfirmaAnuU 50579198,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:06.117312-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:06.114468-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[162]=><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-13 11:33:51.036448-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '21', 'Anulacion');
INSERT INTO confirma_trasa VALUES (223017, '2014-08-19 15:49:23.975045', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3755620###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[258]=Falla Confirmacion de Sybase, se reintenta
174006123*<17> ID COLA=223017 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 975364410,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174006123*<17> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=975364410###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=21###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=17###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[24]=/Anulacion/cia_seg_trasa###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[24]=/Anulacion/cia_seg_trasa###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[12]=10.100.32.63###REMOTE_PORT[5]=48999###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e32313c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e363136323930373c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353336343431303c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=223017###__COLA_MOTOR__[5]=trasa###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-19 15:49:25.158193-04###INPUT_CIA[1932]=504f5354202f736572766963696f732f7773416e756c6163696f6e2e61736d7820485454502f312e310a486f73743a203139322e3136392e35302e31313a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203735320a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6453656775726f3e32313c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e363136323930373c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353336343431303c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[193]=<![CDATA[
<MsgInput><extCodSeguro>21</extCodSeguro><extRutBeneficiario>000000000000</extRutBeneficiario><extFolioAuto>6162907</extFolioAuto><extFolioBono>975364410</extFolioBono></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[5]=trasa###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[741]=HTTP/1.1 200 OK
Date: Tue, 19 Aug 2014 19:52:07 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 508

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult>&lt;MsgOutput&gt;&lt;extCodError&gt;S&lt;/extCodError&gt;&lt;extMensajeError&gt;&lt;/extMensajeError&gt;&lt;/MsgOutput&gt;</wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 975364410,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:06.123316-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:06.120511-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[162]=><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-19 15:49:29.826968-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '21', 'Anulacion');
INSERT INTO confirma_trasa VALUES (223134, '2014-08-19 16:03:15.594173', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=3757240###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[258]=Falla Confirmacion de Sybase, se reintenta
174006129*<17> ID COLA=223134 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 218907777,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174006129*<17> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=218907777###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=21###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=17###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[24]=/Anulacion/cia_seg_trasa###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[24]=/Anulacion/cia_seg_trasa###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.161###REMOTE_PORT[5]=46923###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e32313c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e363136313633383c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3231383930373737373c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=223134###__COLA_MOTOR__[5]=trasa###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-19 16:03:18.426919-04###INPUT_CIA[1932]=504f5354202f736572766963696f732f7773416e756c6163696f6e2e61736d7820485454502f312e310a486f73743a203139322e3136392e35302e31313a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203735320a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6453656775726f3e32313c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e363136313633383c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3231383930373737373c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[193]=<![CDATA[
<MsgInput><extCodSeguro>21</extCodSeguro><extRutBeneficiario>000000000000</extRutBeneficiario><extFolioAuto>6161638</extFolioAuto><extFolioBono>218907777</extFolioBono></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[5]=trasa###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[21]=SOCKET_NO_RESPONSE_BD###RESPUESTA_CIA[741]=HTTP/1.1 200 OK
Date: Tue, 19 Aug 2014 20:06:01 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 508

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult>&lt;MsgOutput&gt;&lt;extCodError&gt;S&lt;/extCodError&gt;&lt;extMensajeError&gt;&lt;/extMensajeError&gt;&lt;/MsgOutput&gt;</wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 218907777,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:06.128941-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:06.126321-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[162]=><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-19 16:03:23.641499-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '21', 'Anulacion');
INSERT INTO confirma_trasa VALUES (241914, '2014-08-25 10:52:07.791254', 'SOLO_SYBASE', 5, 0, 'ESTADO_SYBASE[11]=SOLO_SYBASE###CODIGO_MOTOR[7]=4067568###XML_RESPUESTA[339]=<?xml version="1.0" encoding="UTF-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://tempuri.org/"><SOAP-ENV:Body><ns1:wmImed_SrvAnulacionResponse><ns1:wmImed_SrvAnulacionResult>&-&DATA&-&</ns1:wmImed_SrvAnulacionResult></ns1:wmImed_SrvAnulacionResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>###EXTMENSAJEERROR[0]=###EXTCODERROR[1]=S###_LOG_[258]=Falla Confirmacion de Sybase, se reintenta
174006134*<17> ID COLA=241914 SQL=declare	@CodError tinyint execute CSConfirmaAnuU 975299983,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase
174006134*<17> Aumenta Reintentos y falla sybase###EXTFOLIOBONO[9]=975299983###EXTFOLIOAUTO[0]=###EXTRUTBENEFICIARIO[12]=000000000000###NUM_OPERACION[0]=###CODIGO_CIA[2]=21###__SECUENCIAOK__[1]=0###__PROCESOXML__[15]=PROCESADOR_SCGI###__IPLOCAL__[0]=###__IDPROC__[2]=17###CONTENT_LENGTH[3]=522###REQUEST_METHOD[4]=POST###REQUEST_URI[24]=/Anulacion/cia_seg_trasa###QUERY_STRING[0]=###CONTENT_TYPE[23]=text/xml; charset=utf-8###DOCUMENT_URI[24]=/Anulacion/cia_seg_trasa###DOCUMENT_ROOT[15]=/etc/nginx/html###SCGI[1]=1###SERVER_PROTOCOL[8]=HTTP/1.1###REMOTE_ADDR[13]=10.100.32.160###REMOTE_PORT[5]=36198###SERVER_PORT[2]=80###SERVER_NAME[0]=###HTTP_HOST[12]=10.100.32.52###HTTP_CONNECTION[10]=Keep-Alive###HTTP_USER_AGENT[20]=SoapClient PHP 5.2.9###HTTP_CONTENT_TYPE[23]=text/xml; charset=utf-8###HTTP_SOAPACTION[40]="http://tempuri.org/wmImed_SrvAnulacion"###HTTP_CONTENT_LENGTH[3]=522###INPUT[924]=3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f706520786d6c6e733a534f41502d454e563d22687474703a2f2f736368656d61732e786d6c736f61702e6f72672f736f61702f656e76656c6f70652f2220786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f223e3c534f41502d454e563a426f64793e3c6e73313a776d496d65645f537276416e756c6163696f6e3e3c6e73313a584d4c5f494e5055543e3c4d7367496e7075743e3c657874436f6453656775726f3e32313c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e363138313833373c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353239393938333c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e3c2f6e73313a584d4c5f494e5055543e3c2f6e73313a776d496d65645f537276416e756c6163696f6e3e3c2f534f41502d454e563a426f64793e3c2f534f41502d454e563a456e76656c6f70653e0a###STATUS[2]=OK###TX[4]=4001###__ID_DTE__[6]=241914###__COLA_MOTOR__[5]=trasa###__STS_ERROR_PXML__[2]=OK###TIEMPO_INI_CIA[29]=2014-08-25 10:52:10.337733-04###INPUT_CIA[1932]=504f5354202f736572766963696f732f7773416e756c6163696f6e2e61736d7820485454502f312e310a486f73743a203139322e3136392e35302e31313a38300a436f6e74656e742d547970653a20746578742f786d6c3b636861727365743d5554462d38200a557365722d4167656e743a204d6f746f72494d6564312e310a534f4150416374696f6e3a2022687474703a2f2f74656d707572692e6f72672f776d496d65645f537276416e756c6163696f6e220a4163636570743a202a2f2a0a436f6e74656e742d4c656e6774683a203735320a0a3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c534f41502d454e563a456e76656c6f70650a20786d6c6e733a534f41502d454e563d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e76656c6f7065220a20786d6c6e733a534f41502d454e433d22687474703a2f2f7777772e77332e6f72672f323030332f30352f736f61702d656e636f64696e67220a20786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e6365220a20786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61220a20786d6c6e733a6e73323d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f6170220a20786d6c6e733a6e73313d22687474703a2f2f74656d707572692e6f72672f220a20786d6c6e733a6e73333d22687474703a2f2f74656d707572692e6f72672f7773416e756c6163696f6e536f61703132223e0a203c534f41502d454e563a426f64793e0a2020203c6e73313a776d496d65645f537276416e756c6163696f6e3e0a202020203c6e73313a584d4c5f494e5055543e3c215b43444154415b0a3c4d7367496e7075743e3c657874436f6453656775726f3e32313c2f657874436f6453656775726f3e3c65787452757442656e65666963696172696f3e3030303030303030303030303c2f65787452757442656e65666963696172696f3e3c657874466f6c696f4175746f3e363138313833373c2f657874466f6c696f4175746f3e3c657874466f6c696f426f6e6f3e3937353239393938333c2f657874466f6c696f426f6e6f3e3c2f4d7367496e7075743e205d5d3e3c2f6e73313a584d4c5f494e5055543e0a2020203c2f6e73313a776d496d65645f537276416e756c6163696f6e3e0a0a203c2f534f41502d454e563a426f64793e0a3c2f534f41502d454e563a456e76656c6f70653e0a###DATA_CIA[193]=<![CDATA[
<MsgInput><extCodSeguro>21</extCodSeguro><extRutBeneficiario>000000000000</extRutBeneficiario><extFolioAuto>6181837</extFolioAuto><extFolioBono>975299983</extFolioBono></MsgInput> ]]>###__IP_PORT_CLIENTE__[0]=###__IP_CONEXION_CLIENTE__[0]=###FUNCION_RESPUESTA[25]=sp_respuesta_cia_generica###NEMO_CIA[5]=trasa###TX_CIA[9]=Anulacion###STATUS_CIA[11]=SOLO_SYBASE###__STS_ERROR_SOCKET__[17]=FALLA_CONEXION_BD###RESPUESTA_CIA[741]=HTTP/1.1 200 OK
Date: Mon, 25 Aug 2014 14:55:35 GMT
Server: Microsoft-IIS/6.0
X-Powered-By: ASP.NET
X-AspNet-Version: 2.0.50727
Cache-Control: private, max-age=0
Content-Type: application/soap+xml; charset=utf-8
Content-Length: 508

<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><wmImed_SrvAnulacionResponse xmlns="http://tempuri.org/"><wmImed_SrvAnulacionResult>&lt;MsgOutput&gt;&lt;extCodError&gt;S&lt;/extCodError&gt;&lt;extMensajeError&gt;&lt;/extMensajeError&gt;&lt;/MsgOutput&gt;</wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###ESTADO_CIA[6]=CIA_OK###SQLINPUT[128]=declare	@CodError tinyint execute CSConfirmaAnuU 975299983,<C>000000000000<C>, @CodError OUTPUT select @CodError as respuesta_sybase###TIEMPO_FIN_SYBASE[29]=2014-09-05 17:40:06.134375-04###TIEMPO_INI_SYBASE[29]=2014-09-05 17:40:06.132037-04###EXTESTABON[0]=###COLUMNS[0]=###EXTCODESTBEN[0]=###MSGTEXT[0]=###MSGERROR[0]=###CODRETORNO[0]=###MSGOUTPUT[162]=><extCodError>S</extCodError><extMensajeError></extMensajeError></MsgOutput></wmImed_SrvAnulacionResult></wmImed_SrvAnulacionResponse></soap:Body></soap:Envelope>###TIEMPO_FIN_CIA[29]=2014-08-25 10:52:13.107706-04###API_CODRESPUESTA[1]=1###API_TIPO[3]=SQL###__XML__[0]=###RESPUESTA_SYBASE_1[1]=1###', '21', 'Anulacion');


--
-- Data for Name: confirma_trasa2; Type: TABLE DATA; Schema: public; Owner: motor
--



--
-- Name: confirma_trasa2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_trasa2_id_seq', 1, true);


--
-- Name: confirma_trasa_id_seq; Type: SEQUENCE SET; Schema: public; Owner: motor
--

SELECT pg_catalog.setval('confirma_trasa_id_seq', 290146, true);


--
-- Name: confirma_bci_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_bci_01 ON confirma_bci USING btree (id);


--
-- Name: confirma_bci_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_bci_02 ON confirma_bci USING btree (fecha);


--
-- Name: confirma_bice_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_bice_01 ON confirma_bice USING btree (id);


--
-- Name: confirma_bice_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_bice_02 ON confirma_bice USING btree (fecha);


--
-- Name: confirma_bono_banmedica_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_bono_banmedica_01 ON confirma_bono_banmedica USING btree (id);


--
-- Name: confirma_camara_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_camara_01 ON confirma_camara USING btree (id);


--
-- Name: confirma_camara_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_camara_02 ON confirma_camara USING btree (fecha);


--
-- Name: confirma_chicon_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_chicon_01 ON confirma_chicon USING btree (id);


--
-- Name: confirma_chicon_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_chicon_02 ON confirma_chicon USING btree (fecha);


--
-- Name: confirma_consorcio_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_consorcio_01 ON confirma_consorcio USING btree (id);


--
-- Name: confirma_consorcio_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_consorcio_02 ON confirma_consorcio USING btree (fecha);


--
-- Name: confirma_euroamerica_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_euroamerica_01 ON confirma_euroamerica USING btree (id);


--
-- Name: confirma_euroamerica_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_euroamerica_02 ON confirma_euroamerica USING btree (fecha);


--
-- Name: confirma_far2_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_far2_01 ON confirma_far2 USING btree (id);


--
-- Name: confirma_far2_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_far2_02 ON confirma_far2 USING btree (fecha);


--
-- Name: confirma_imed_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_imed_01 ON confirma_imed USING btree (id);


--
-- Name: confirma_imed_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_imed_02 ON confirma_imed USING btree (fecha);


--
-- Name: confirma_ing_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_ing_01 ON confirma_ing USING btree (id);


--
-- Name: confirma_ing_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_ing_02 ON confirma_ing USING btree (fecha);


--
-- Name: confirma_integrafar_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_integrafar_01 ON confirma_integrafar USING btree (id);


--
-- Name: confirma_integrafar_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_integrafar_02 ON confirma_integrafar USING btree (fecha);


--
-- Name: confirma_inter_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_inter_01 ON confirma_inter USING btree (id);


--
-- Name: confirma_inter_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_inter_02 ON confirma_inter USING btree (fecha);


--
-- Name: confirma_metlife_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_metlife_01 ON confirma_metlife USING btree (id);


--
-- Name: confirma_metlife_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_metlife_02 ON confirma_metlife USING btree (fecha);


--
-- Name: confirma_metlife_cert_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_metlife_cert_01 ON confirma_metlife_cert USING btree (id);


--
-- Name: confirma_metlife_cert_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_metlife_cert_02 ON confirma_metlife_cert USING btree (fecha);


--
-- Name: confirma_metlife_mpro_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_metlife_mpro_01 ON confirma_metlife_mpro USING btree (id);


--
-- Name: confirma_metlife_mpro_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_metlife_mpro_02 ON confirma_metlife_mpro USING btree (fecha);


--
-- Name: confirma_mpro_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_mpro_01 ON confirma_mpro2 USING btree (id);


--
-- Name: confirma_mpro_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_mpro_02 ON confirma_mpro2 USING btree (fecha);


--
-- Name: confirma_mprobci_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_mprobci_01 ON confirma_mprobci USING btree (id);


--
-- Name: confirma_mprobci_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_mprobci_02 ON confirma_mprobci USING btree (fecha);


--
-- Name: confirma_security_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_security_01 ON confirma_security USING btree (id);


--
-- Name: confirma_security_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_security_02 ON confirma_security USING btree (fecha);


--
-- Name: confirma_sermecoop_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_sermecoop_01 ON confirma_sermecoop USING btree (id);


--
-- Name: confirma_sermecoop_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_sermecoop_02 ON confirma_sermecoop USING btree (fecha);


--
-- Name: confirma_trasa2_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_trasa2_01 ON confirma_trasa2 USING btree (id);


--
-- Name: confirma_trasa2_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_trasa2_02 ON confirma_trasa2 USING btree (fecha);


--
-- Name: confirma_trasa_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_trasa_01 ON confirma_trasa USING btree (id);


--
-- Name: confirma_trasa_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX confirma_trasa_02 ON confirma_trasa USING btree (fecha);


--
-- PostgreSQL database dump complete
--

