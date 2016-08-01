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
-- Name: tx_cias; Type: TABLE; Schema: public; Owner: motor; Tablespace: 
--

CREATE TABLE tx_cias (
    fecha_ingreso timestamp without time zone,
    dia integer DEFAULT (to_char(now(), 'YYYYMMDD'::text))::integer,
    tiempo_ini_cia timestamp without time zone,
    tiempo_fin_cia timestamp without time zone,
    tiempo_ini_sybase timestamp without time zone,
    tiempo_fin_sybase timestamp without time zone,
    codigo_cia character varying,
    codigo_motor bigint,
    extfolioauto character varying,
    extcoderror character varying,
    extmensajeerror character varying,
    msgoutput character varying,
    estado character varying,
    reintentos integer,
    tx character varying,
    nemo character varying,
    ip_cliente character varying,
    fecha_ult_modificacion timestamp without time zone,
    num_operacion character varying,
    extfoliobono character varying,
    cod_lugar character varying,
    rut_prestador character varying,
    rut_beneficiario character varying,
    msginput character varying
);


ALTER TABLE public.tx_cias OWNER TO motor;

--
-- Name: tx_cias_01; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX tx_cias_01 ON tx_cias USING btree (fecha_ingreso);


--
-- Name: tx_cias_02; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX tx_cias_02 ON tx_cias USING btree (dia);


--
-- Name: tx_cias_03; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX tx_cias_03 ON tx_cias USING btree (codigo_motor);


--
-- Name: tx_cias_04; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX tx_cias_04 ON tx_cias USING btree (extfoliobono);


--
-- Name: tx_cias_05; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX tx_cias_05 ON tx_cias USING btree (extfolioauto);


--
-- Name: tx_cias_06; Type: INDEX; Schema: public; Owner: motor; Tablespace: 
--

CREATE INDEX tx_cias_06 ON tx_cias USING btree (num_operacion);


--
-- PostgreSQL database dump complete
--

