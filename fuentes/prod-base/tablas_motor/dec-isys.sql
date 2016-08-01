--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: dec; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "dec";


ALTER SCHEMA "dec" OWNER TO postgres;

SET search_path = "dec", pg_catalog;

--
-- Name: traductor_input_abulabonou(character varying); Type: FUNCTION; Schema: dec; Owner: isys
--

CREATE FUNCTION traductor_input_abulabonou(character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare
        xml1    alias for $1;
        xml2    varchar;
begin
	xml2 := xml1;

	xml2 := put_campo(xml2,'__COD_RESP__','OK');
	xml2 := put_campo(xml2,'PASE','TEST');

	xml2 := put_campo(xml2,'ERRORCOD','0001');

        return xml2;
end;
$_$;


ALTER FUNCTION "dec".traductor_input_abulabonou(character varying) OWNER TO isys;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: access_log; Type: TABLE; Schema: dec; Owner: postgres; Tablespace: 
--

CREATE TABLE access_log (
    fecha timestamp without time zone,
    codigo character varying(20),
    mensaje character varying(100),
    tipo_tx character varying(50),
    input character varying
);


ALTER TABLE "dec".access_log OWNER TO postgres;

--
-- Name: correlativo_dec; Type: SEQUENCE; Schema: dec; Owner: isys
--

CREATE SEQUENCE correlativo_dec
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "dec".correlativo_dec OWNER TO isys;

--
-- Name: define_secuencia_ws; Type: TABLE; Schema: dec; Owner: postgres; Tablespace: 
--

CREATE TABLE define_secuencia_ws (
    tipo_tx character varying(30),
    secuencia character varying(10),
    funcion_input character varying(50)
);


ALTER TABLE "dec".define_secuencia_ws OWNER TO postgres;

--
-- Name: error_log; Type: TABLE; Schema: dec; Owner: postgres; Tablespace: 
--

CREATE TABLE error_log (
    fecha timestamp without time zone,
    codigo character varying(20),
    mensaje character varying(100),
    tipo_tx character varying(50),
    input character varying
);


ALTER TABLE "dec".error_log OWNER TO postgres;

--
-- Name: respuestas_soap; Type: TABLE; Schema: dec; Owner: postgres; Tablespace: 
--

CREATE TABLE respuestas_soap (
    tipo_tx character varying(20),
    respuesta character varying
);


ALTER TABLE "dec".respuestas_soap OWNER TO postgres;

--
-- Name: access_log_fecha_tipo_tx_idx; Type: INDEX; Schema: dec; Owner: postgres; Tablespace: 
--

CREATE INDEX access_log_fecha_tipo_tx_idx ON access_log USING btree (fecha, tipo_tx);


--
-- Name: define_secuencia_ws_01; Type: INDEX; Schema: dec; Owner: postgres; Tablespace: 
--

CREATE INDEX define_secuencia_ws_01 ON define_secuencia_ws USING btree (tipo_tx);


--
-- Name: error_log_fecha_tipo_tx_idx; Type: INDEX; Schema: dec; Owner: postgres; Tablespace: 
--

CREATE INDEX error_log_fecha_tipo_tx_idx ON error_log USING btree (fecha, tipo_tx);


--
-- Name: respuestas_soap_01; Type: INDEX; Schema: dec; Owner: postgres; Tablespace: 
--

CREATE INDEX respuestas_soap_01 ON respuestas_soap USING btree (tipo_tx);


--
-- Name: dec; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA "dec" FROM PUBLIC;
REVOKE ALL ON SCHEMA "dec" FROM postgres;
GRANT ALL ON SCHEMA "dec" TO postgres;
GRANT ALL ON SCHEMA "dec" TO isys;
GRANT ALL ON SCHEMA "dec" TO "dec";


--
-- Name: access_log; Type: ACL; Schema: dec; Owner: postgres
--

REVOKE ALL ON TABLE access_log FROM PUBLIC;
REVOKE ALL ON TABLE access_log FROM postgres;
GRANT ALL ON TABLE access_log TO postgres;
GRANT ALL ON TABLE access_log TO isys;
GRANT ALL ON TABLE access_log TO "dec";


--
-- Name: define_secuencia_ws; Type: ACL; Schema: dec; Owner: postgres
--

REVOKE ALL ON TABLE define_secuencia_ws FROM PUBLIC;
REVOKE ALL ON TABLE define_secuencia_ws FROM postgres;
GRANT ALL ON TABLE define_secuencia_ws TO postgres;
GRANT ALL ON TABLE define_secuencia_ws TO isys;


--
-- Name: error_log; Type: ACL; Schema: dec; Owner: postgres
--

REVOKE ALL ON TABLE error_log FROM PUBLIC;
REVOKE ALL ON TABLE error_log FROM postgres;
GRANT ALL ON TABLE error_log TO postgres;
GRANT ALL ON TABLE error_log TO isys;
GRANT ALL ON TABLE error_log TO "dec";


--
-- Name: respuestas_soap; Type: ACL; Schema: dec; Owner: postgres
--

REVOKE ALL ON TABLE respuestas_soap FROM PUBLIC;
REVOKE ALL ON TABLE respuestas_soap FROM postgres;
GRANT ALL ON TABLE respuestas_soap TO postgres;
GRANT ALL ON TABLE respuestas_soap TO isys;


--
-- PostgreSQL database dump complete
--

