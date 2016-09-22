--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: location_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE location_data (
    id integer NOT NULL,
    latitude numeric(30,4) NOT NULL,
    longitude numeric(30,10) NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    timezone character varying DEFAULT 'Etc/UTC'::character varying
);


--
-- Name: location_data_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE location_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: location_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE location_data_id_seq OWNED BY location_data.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: time_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE time_data (
    id integer NOT NULL,
    value timestamp without time zone NOT NULL
);


--
-- Name: time_data_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE time_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: time_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE time_data_id_seq OWNED BY time_data.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY location_data ALTER COLUMN id SET DEFAULT nextval('location_data_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY time_data ALTER COLUMN id SET DEFAULT nextval('time_data_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: location_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY location_data
    ADD CONSTRAINT location_data_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: time_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY time_data
    ADD CONSTRAINT time_data_pkey PRIMARY KEY (id);


--
-- Name: index_location_data_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_location_data_on_name ON location_data USING btree (name);


--
-- Name: index_time_data_on_value; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_time_data_on_value ON time_data USING btree (value);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20160921191155'), ('20160921191157');


