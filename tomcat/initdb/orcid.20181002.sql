--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE daemon;
ALTER ROLE daemon WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION NOBYPASSRLS;
CREATE ROLE mikeadm;
ALTER ROLE mikeadm WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION NOBYPASSRLS;
CREATE ROLE orcid;
ALTER ROLE orcid WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md56f4c19ae1996a4a6c61512aacac92445';
CREATE ROLE orcidro;
ALTER ROLE orcidro WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md54d77a927daa94e9b5ce745bf157268b1';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
CREATE ROLE replicator;
ALTER ROLE replicator WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION NOBYPASSRLS PASSWORD 'md54fd040673c64c8c80deb0536d479390a';
CREATE ROLE repluser;
ALTER ROLE repluser WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION NOBYPASSRLS PASSWORD 'md574e4583b74d747adda811e08332632e8';
CREATE ROLE root;
ALTER ROLE root WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION NOBYPASSRLS PASSWORD 'md5ba85b348ca9d4544bdc0117de54a2a45';
CREATE ROLE statistics;
ALTER ROLE statistics WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md50bb9ced98effdb433e3e2fafd98932fd';






--
-- Database creation
--

CREATE DATABASE features WITH TEMPLATE = template0 OWNER = postgres;
REVOKE ALL ON DATABASE features FROM PUBLIC;
REVOKE ALL ON DATABASE features FROM postgres;
GRANT ALL ON DATABASE features TO postgres;
GRANT CONNECT,TEMPORARY ON DATABASE features TO PUBLIC;
GRANT ALL ON DATABASE features TO orcid;
CREATE DATABASE message_listener WITH TEMPLATE = template0 OWNER = postgres;
REVOKE ALL ON DATABASE message_listener FROM PUBLIC;
REVOKE ALL ON DATABASE message_listener FROM postgres;
GRANT ALL ON DATABASE message_listener TO postgres;
GRANT CONNECT,TEMPORARY ON DATABASE message_listener TO PUBLIC;
GRANT ALL ON DATABASE message_listener TO orcid;
CREATE DATABASE orcid WITH TEMPLATE = template0 OWNER = postgres;
REVOKE ALL ON DATABASE orcid FROM PUBLIC;
REVOKE ALL ON DATABASE orcid FROM postgres;
GRANT ALL ON DATABASE orcid TO postgres;
GRANT CONNECT,TEMPORARY ON DATABASE orcid TO PUBLIC;
GRANT ALL ON DATABASE orcid TO orcid;
GRANT CONNECT ON DATABASE orcid TO orcidro;
CREATE DATABASE statistics WITH TEMPLATE = template0 OWNER = postgres;
REVOKE ALL ON DATABASE statistics FROM PUBLIC;
REVOKE ALL ON DATABASE statistics FROM postgres;
GRANT ALL ON DATABASE statistics TO postgres;
GRANT CONNECT,TEMPORARY ON DATABASE statistics TO PUBLIC;
GRANT ALL ON DATABASE statistics TO statistics;
REVOKE ALL ON DATABASE template1 FROM PUBLIC;
REVOKE ALL ON DATABASE template1 FROM postgres;
GRANT ALL ON DATABASE template1 TO postgres;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;
CREATE DATABASE test1 WITH TEMPLATE = template0 OWNER = postgres;


\connect features

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.13
-- Dumped by pg_dump version 9.5.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: togglz; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.togglz (
    feature_name character varying(100) NOT NULL,
    feature_enabled integer,
    strategy_id character varying(200),
    strategy_params character varying(2000)
);


ALTER TABLE public.togglz OWNER TO orcid;

--
-- Data for Name: togglz; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.togglz (feature_name, feature_enabled, strategy_id, strategy_params) FROM stdin;
\.


--
-- Name: togglz_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.togglz
    ADD CONSTRAINT togglz_pkey PRIMARY KEY (feature_name);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect message_listener

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.13
-- Dumped by pg_dump version 9.5.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect orcid

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.13
-- Dumped by pg_dump version 9.5.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: org_disambiguated_descendent; Type: TYPE; Schema: public; Owner: orcid
--

CREATE TYPE public.org_disambiguated_descendent AS (
	id bigint,
	source_id character varying,
	source_parent_id character varying,
	org_type character varying,
	name character varying,
	city character varying,
	region character varying,
	country character varying,
	level integer
);


ALTER TYPE public.org_disambiguated_descendent OWNER TO orcid;

--
-- Name: extract_doi(json); Type: FUNCTION; Schema: public; Owner: orcid
--

CREATE FUNCTION public.extract_doi(json) RETURNS character varying
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT j->'workExternalIdentifierId'->>'content'
FROM (SELECT json_array_elements(json_extract_path($1, 'workExternalIdentifier')) AS j) AS a
WHERE j->>'workExternalIdentifierType' = 'DOI'
ORDER BY length(j->'workExternalIdentifierId'->>'content') DESC
LIMIT 1;
$_$;


ALTER FUNCTION public.extract_doi(json) OWNER TO orcid;

--
-- Name: find_org_disambiguated_descendents(character varying, character varying); Type: FUNCTION; Schema: public; Owner: orcid
--

CREATE FUNCTION public.find_org_disambiguated_descendents(source_id character varying, source_type character varying) RETURNS SETOF public.org_disambiguated_descendent
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT * FROM find_org_disambiguated_descendents(source_id, source_type, 1)
ORDER BY level, source_parent_id, name;
$$;


ALTER FUNCTION public.find_org_disambiguated_descendents(source_id character varying, source_type character varying) OWNER TO orcid;

--
-- Name: find_org_disambiguated_descendents(character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: orcid
--

CREATE FUNCTION public.find_org_disambiguated_descendents(required_source_id character varying, required_source_type character varying, current_level integer) RETURNS SETOF public.org_disambiguated_descendent
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    current_result org_disambiguated_descendent;
BEGIN
FOR current_result IN SELECT p1.id, p1.source_id, p1.source_parent_id, p1.org_type, p1.name, p1.city, p1.region, p1.country, current_level AS level FROM org_disambiguated p1 WHERE p1.source_parent_id = required_source_id AND p1.source_type = required_source_type LOOP
    RETURN NEXT current_result;
    RETURN QUERY SELECT * FROM find_org_disambiguated_descendents(current_result.source_id, required_source_type, current_level + 1);    
END LOOP;
END
$$;


ALTER FUNCTION public.find_org_disambiguated_descendents(required_source_id character varying, required_source_type character varying, current_level integer) OWNER TO orcid;

--
-- Name: insert_scope_for_premium_members(character varying); Type: FUNCTION; Schema: public; Owner: orcid
--

CREATE FUNCTION public.insert_scope_for_premium_members(scope_to_add character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
    client_id VARCHAR;
BEGIN
    RAISE NOTICE 'Inserting scope...';

    FOR client_id IN SELECT * FROM client_details cd LEFT JOIN client_scope cs ON cs.client_details_id = cd.client_details_id AND cs.scope_type = scope_to_add WHERE cd.client_type IN ('PREMIUM_CREATOR', 'PREMIUM_UPDATER') AND cs.client_details_id IS NULL
    LOOP
        RAISE NOTICE 'Found member % without % scope', client_id, scope_to_add;
        EXECUTE 'INSERT INTO client_scope (client_details_id, scope_type, date_created, last_modified) VALUES ($1, $2, now(), now())' USING client_id, scope_to_add;
    END LOOP;

    RAISE NOTICE 'Finished inserting scope';
    RETURN;
END;
$_$;


ALTER FUNCTION public.insert_scope_for_premium_members(scope_to_add character varying) OWNER TO orcid;

--
-- Name: json_intext(text); Type: FUNCTION; Schema: public; Owner: orcid
--

CREATE FUNCTION public.json_intext(text) RETURNS json
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT json_in($1::cstring);
$_$;


ALTER FUNCTION public.json_intext(text) OWNER TO orcid;

--
-- Name: set_sequence_starts(); Type: FUNCTION; Schema: public; Owner: orcid
--

CREATE FUNCTION public.set_sequence_starts() RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
    seq VARCHAR;
    next_val BIGINT;
    min_val BIGINT := 1000;
BEGIN
    RAISE NOTICE 'Setting values of sequences to minimum value...';

    FOR seq IN SELECT c.relname FROM pg_class c WHERE c.relkind = 'S' LOOP
        next_val := nextval(seq);
        RAISE NOTICE 'Found sequence % with next value = %', seq, next_val;
        IF next_val < min_val THEN
            RAISE NOTICE 'Increasing value of sequence % to %', seq, min_val;
            EXECUTE 'SELECT setval($1, $2)' USING seq, min_val;
        END IF;
    END LOOP;

    RAISE NOTICE 'Finished setting values of sequences to minimum value';
    RETURN;
END;
$_$;


ALTER FUNCTION public.set_sequence_starts() OWNER TO orcid;

--
-- Name: unix_timestamp(timestamp with time zone); Type: FUNCTION; Schema: public; Owner: orcid
--

CREATE FUNCTION public.unix_timestamp(timestamp with time zone) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT EXTRACT(epoch FROM $1) $_$;


ALTER FUNCTION public.unix_timestamp(timestamp with time zone) OWNER TO orcid;

--
-- Name: CAST (character varying AS json); Type: CAST; Schema: -; Owner: 
--

CREATE CAST (character varying AS json) WITH FUNCTION public.json_intext(text) AS IMPLICIT;


--
-- Name: access_token_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.access_token_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.access_token_seq OWNER TO orcid;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: address; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.address (
    id bigint NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    address_line_1 character varying(350),
    address_line_2 character varying(350),
    city character varying(150),
    postal_code character varying(15),
    state_or_province character varying(150),
    orcid character varying(19),
    is_primary boolean DEFAULT false NOT NULL,
    iso2_country character varying(2),
    visibility character varying(19),
    source_id character varying(19),
    client_source_id character varying(20),
    display_index bigint DEFAULT 0
);


ALTER TABLE public.address OWNER TO orcid;

--
-- Name: address_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.address_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_seq OWNER TO orcid;

--
-- Name: affiliation; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.affiliation (
    institution_id bigint NOT NULL,
    orcid character varying(255) NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    role_title character varying(255),
    start_date timestamp without time zone,
    affiliation_details_visibility character varying(20),
    end_date date,
    affiliation_type character varying(100),
    department_name character varying(400),
    affiliation_address_visibility character varying(20)
);


ALTER TABLE public.affiliation OWNER TO orcid;

--
-- Name: org; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.org (
    id bigint NOT NULL,
    name character varying(4000),
    city character varying(4000),
    region character varying(4000),
    country character varying(2),
    url character varying(2000),
    source_id character varying(255),
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    org_disambiguated_id bigint,
    client_source_id character varying(20)
);


ALTER TABLE public.org OWNER TO orcid;

--
-- Name: org_affiliation_relation; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.org_affiliation_relation (
    id bigint NOT NULL,
    org_id bigint NOT NULL,
    orcid character varying(255) NOT NULL,
    org_affiliation_relation_role text,
    org_affiliation_relation_title text,
    department text,
    start_day integer,
    start_month integer,
    start_year integer,
    end_day integer,
    end_month integer,
    end_year integer,
    visibility character varying(20),
    source_id character varying(255),
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    client_source_id character varying(20),
    url character varying(350),
    external_ids_json json
);


ALTER TABLE public.org_affiliation_relation OWNER TO orcid;

--
-- Name: ambiguous_org; Type: VIEW; Schema: public; Owner: orcid
--

CREATE VIEW public.ambiguous_org AS
 SELECT o.id,
    o.name,
    o.city,
    o.region,
    o.country,
    o.url,
    o.source_id,
    o.date_created,
    o.last_modified,
    count(*) AS used_count
   FROM (public.org o
     LEFT JOIN public.org_affiliation_relation oar ON ((oar.org_id = o.id)))
  WHERE (o.org_disambiguated_id IS NULL)
  GROUP BY o.id, o.name, o.city, o.region, o.country, o.url, o.source_id, o.date_created, o.last_modified;


ALTER TABLE public.ambiguous_org OWNER TO orcid;

--
-- Name: author_other_name_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.author_other_name_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.author_other_name_seq OWNER TO orcid;

--
-- Name: backup_code; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.backup_code (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    orcid character varying(19) NOT NULL,
    used_date timestamp with time zone,
    hashed_code character varying(255)
);


ALTER TABLE public.backup_code OWNER TO orcid;

--
-- Name: backup_code_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.backup_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.backup_code_seq OWNER TO orcid;

--
-- Name: biography; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.biography (
    id bigint NOT NULL,
    orcid character varying(255) NOT NULL,
    biography text,
    visibility character varying(20),
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE public.biography OWNER TO orcid;

--
-- Name: biography_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.biography_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.biography_seq OWNER TO orcid;

--
-- Name: client_authorised_grant_type; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.client_authorised_grant_type (
    client_details_id character varying(150) NOT NULL,
    grant_type character varying(150) NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE public.client_authorised_grant_type OWNER TO orcid;

--
-- Name: client_details; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.client_details (
    client_details_id character varying(150) NOT NULL,
    client_secret character varying(150),
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    client_name character varying(255),
    webhooks_enabled boolean DEFAULT true NOT NULL,
    client_description text,
    client_website character varying(350),
    persistent_tokens_enabled boolean DEFAULT false,
    group_orcid character varying(19),
    client_type character varying(25),
    authentication_provider_id character varying(1000),
    email_access_reason character varying(500),
    allow_auto_deprecate boolean DEFAULT false
);


ALTER TABLE public.client_details OWNER TO orcid;

--
-- Name: client_granted_authority; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.client_granted_authority (
    client_details_id character varying(150) NOT NULL,
    granted_authority character varying(150) NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE public.client_granted_authority OWNER TO orcid;

--
-- Name: client_redirect_uri; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.client_redirect_uri (
    client_details_id character varying(150) NOT NULL,
    redirect_uri text NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    predefined_client_redirect_scope text,
    redirect_uri_type text DEFAULT 'default'::character varying NOT NULL,
    uri_act_type json DEFAULT '{"import-works-wizard" : ["Articles"]}'::json,
    uri_geo_area json DEFAULT '{"import-works-wizard" : ["Global"]}'::json
);


ALTER TABLE public.client_redirect_uri OWNER TO orcid;

--
-- Name: client_resource_id; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.client_resource_id (
    client_details_id character varying(150) NOT NULL,
    resource_id character varying(175) NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE public.client_resource_id OWNER TO orcid;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.client_scope (
    client_details_id character varying(150) NOT NULL,
    scope_type character varying(150) NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE public.client_scope OWNER TO orcid;

--
-- Name: client_secret; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.client_secret (
    client_details_id character varying(255) NOT NULL,
    client_secret character varying(150) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    last_modified timestamp with time zone NOT NULL,
    is_primary boolean DEFAULT true
);


ALTER TABLE public.client_secret OWNER TO orcid;

--
-- Name: country_reference_data; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.country_reference_data (
    country_iso_code character varying(2) NOT NULL,
    country_name character varying(255),
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE public.country_reference_data OWNER TO orcid;

--
-- Name: custom_email; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.custom_email (
    client_details_id character varying(255) NOT NULL,
    email_type character varying(255) NOT NULL,
    content text NOT NULL,
    sender text,
    subject text,
    is_html boolean DEFAULT false,
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE public.custom_email OWNER TO orcid;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20)
);


ALTER TABLE public.databasechangelog OWNER TO orcid;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO orcid;

--
-- Name: email; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.email (
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    email text NOT NULL,
    orcid character varying(255) NOT NULL,
    visibility character varying(20) DEFAULT 'PRIVATE'::character varying NOT NULL,
    is_primary boolean DEFAULT true NOT NULL,
    is_current boolean DEFAULT true NOT NULL,
    is_verified boolean DEFAULT false NOT NULL,
    source_id character varying(255),
    client_source_id character varying(20),
    email_hash character varying(256) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.email OWNER TO orcid;

--
-- Name: email_event; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.email_event (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    email text NOT NULL,
    email_event_type character varying(255) NOT NULL
);


ALTER TABLE public.email_event OWNER TO orcid;

--
-- Name: email_event_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.email_event_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.email_event_seq OWNER TO orcid;

--
-- Name: external_identifier; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.external_identifier (
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    orcid character varying(19) NOT NULL,
    external_id_reference text NOT NULL,
    external_id_type text,
    external_id_url text,
    source_id character varying(19),
    client_source_id character varying(20),
    id bigint NOT NULL,
    visibility character varying(19),
    display_index bigint DEFAULT 0
);


ALTER TABLE public.external_identifier OWNER TO orcid;

--
-- Name: external_identifier_id_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.external_identifier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.external_identifier_id_seq OWNER TO orcid;

--
-- Name: external_identifier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orcid
--

ALTER SEQUENCE public.external_identifier_id_seq OWNED BY public.external_identifier.id;


--
-- Name: funding_external_identifier; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.funding_external_identifier (
    funding_external_identifier_id bigint NOT NULL,
    profile_funding_id bigint NOT NULL,
    ext_type character varying(255),
    ext_value character varying(2084),
    ext_url character varying(350),
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE public.funding_external_identifier OWNER TO orcid;

--
-- Name: funding_external_identifier_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.funding_external_identifier_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.funding_external_identifier_seq OWNER TO orcid;

--
-- Name: funding_subtype_to_index; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.funding_subtype_to_index (
    orcid character varying(255) NOT NULL,
    subtype text NOT NULL
);


ALTER TABLE public.funding_subtype_to_index OWNER TO orcid;

--
-- Name: given_permission_to; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.given_permission_to (
    receiver_orcid character varying(19) NOT NULL,
    giver_orcid character varying(19) NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    approval_date timestamp with time zone,
    given_permission_to_id bigint NOT NULL
);


ALTER TABLE public.given_permission_to OWNER TO orcid;

--
-- Name: given_permission_to_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.given_permission_to_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.given_permission_to_seq OWNER TO orcid;

--
-- Name: grant_contributor_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.grant_contributor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grant_contributor_seq OWNER TO orcid;

--
-- Name: grant_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.grant_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grant_seq OWNER TO orcid;

--
-- Name: granted_authority; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.granted_authority (
    authority character varying(255) NOT NULL,
    orcid character varying(255) NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE public.granted_authority OWNER TO orcid;

--
-- Name: group_id_record; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.group_id_record (
    id bigint NOT NULL,
    group_id text NOT NULL,
    group_name text NOT NULL,
    group_description text,
    group_type text NOT NULL,
    source_id character varying(255),
    client_source_id character varying(20),
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE public.group_id_record OWNER TO orcid;

--
-- Name: group_id_record_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.group_id_record_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group_id_record_seq OWNER TO orcid;

--
-- Name: identifier_type; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.identifier_type (
    id bigint NOT NULL,
    id_name text NOT NULL,
    id_validation_regex text,
    id_resolution_prefix text,
    id_deprecated boolean DEFAULT false NOT NULL,
    client_source_id character varying(20),
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    primary_use text DEFAULT 'work'::character varying NOT NULL,
    case_sensitive boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identifier_type OWNER TO orcid;

--
-- Name: identifier_type_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.identifier_type_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.identifier_type_seq OWNER TO orcid;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.identity_provider (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    providerid text NOT NULL,
    display_name text,
    support_email text,
    admin_email text,
    tech_email text,
    last_failed timestamp with time zone,
    failed_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO orcid;

--
-- Name: identity_provider_name; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.identity_provider_name (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    identity_provider_id bigint,
    display_name text,
    lang text
);


ALTER TABLE public.identity_provider_name OWNER TO orcid;

--
-- Name: identity_provider_name_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.identity_provider_name_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.identity_provider_name_seq OWNER TO orcid;

--
-- Name: identity_provider_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.identity_provider_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.identity_provider_seq OWNER TO orcid;

--
-- Name: institution; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.institution (
    id bigint NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    institution_name character varying(350),
    address_id bigint
);


ALTER TABLE public.institution OWNER TO orcid;

--
-- Name: institution_department_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.institution_department_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.institution_department_seq OWNER TO orcid;

--
-- Name: institution_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.institution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.institution_seq OWNER TO orcid;

--
-- Name: internal_sso; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.internal_sso (
    orcid character varying(19) NOT NULL,
    token character varying(60) NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE public.internal_sso OWNER TO orcid;

--
-- Name: invalid_record_change_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.invalid_record_change_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invalid_record_change_seq OWNER TO orcid;

--
-- Name: invalid_record_data_changes; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.invalid_record_data_changes (
    sql_used_to_update text NOT NULL,
    description text NOT NULL,
    num_changed bigint NOT NULL,
    type text NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    id bigint DEFAULT nextval('public.invalid_record_change_seq'::regclass) NOT NULL
);


ALTER TABLE public.invalid_record_data_changes OWNER TO orcid;

--
-- Name: keyword_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.keyword_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.keyword_seq OWNER TO orcid;

--
-- Name: notification; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.notification (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    orcid character varying(19) NOT NULL,
    notification_type text NOT NULL,
    subject text,
    body_text text,
    body_html text,
    sent_date timestamp with time zone,
    read_date timestamp with time zone,
    archived_date timestamp with time zone,
    sendable boolean DEFAULT true NOT NULL,
    source_id character varying(19),
    authorization_url text,
    lang text,
    client_source_id character varying(20),
    amended_section text,
    actioned_date timestamp with time zone,
    notification_subject text,
    notification_intro text,
    authentication_provider_id text
);


ALTER TABLE public.notification OWNER TO orcid;

--
-- Name: notification_item; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.notification_item (
    id bigint NOT NULL,
    notification_id bigint,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    item_type text,
    item_name text,
    external_id_type text,
    external_id_value text
);


ALTER TABLE public.notification_item OWNER TO orcid;

--
-- Name: notification_item_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.notification_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_item_seq OWNER TO orcid;

--
-- Name: notification_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.notification_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_seq OWNER TO orcid;

--
-- Name: notification_work; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.notification_work (
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    notification_id bigint NOT NULL,
    work_id bigint NOT NULL
);


ALTER TABLE public.notification_work OWNER TO orcid;

--
-- Name: oauth2_authoriziation_code_detail; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.oauth2_authoriziation_code_detail (
    authoriziation_code_value character varying(255) NOT NULL,
    is_aproved boolean,
    orcid character varying(19),
    redirect_uri character varying(355),
    response_type character varying(55),
    state character varying(2000),
    client_details_id character varying(150),
    session_id character varying(100),
    is_authenticated boolean,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    persistent boolean DEFAULT false,
    version bigint DEFAULT '0'::bigint,
    nonce character varying(2000)
);


ALTER TABLE public.oauth2_authoriziation_code_detail OWNER TO orcid;

--
-- Name: oauth2_token_detail; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.oauth2_token_detail (
    token_value character varying(155),
    token_type character varying(50),
    token_expiration timestamp without time zone,
    user_orcid character varying(19),
    client_details_id character varying(20),
    is_approved boolean,
    redirect_uri character varying(350),
    response_type character varying(100),
    state character varying(40),
    scope_type character varying(500),
    resource_id character varying(50),
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    authentication_key character varying(150),
    id bigint DEFAULT nextval('public.access_token_seq'::regclass) NOT NULL,
    refresh_token_expiration timestamp without time zone,
    refresh_token_value character varying(150),
    token_disabled boolean DEFAULT false,
    persistent boolean DEFAULT false,
    version bigint DEFAULT '0'::bigint,
    authorization_code character varying(255),
    revocation_date timestamp with time zone,
    revoke_reason character varying(30)
);


ALTER TABLE public.oauth2_token_detail OWNER TO orcid;

--
-- Name: orcid_props; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.orcid_props (
    key character varying(255) NOT NULL,
    prop_value text,
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE public.orcid_props OWNER TO orcid;

--
-- Name: orcid_social; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.orcid_social (
    orcid character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    encrypted_credentials text NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    last_run timestamp with time zone
);


ALTER TABLE public.orcid_social OWNER TO orcid;

--
-- Name: orcidoauth2authoriziationcodedetail_authorities; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.orcidoauth2authoriziationcodedetail_authorities (
    orcidoauth2authoriziationcodedetail_authoriziation_code_value character varying(255) NOT NULL,
    authorities character varying(255) NOT NULL
);


ALTER TABLE public.orcidoauth2authoriziationcodedetail_authorities OWNER TO orcid;

--
-- Name: orcidoauth2authoriziationcodedetail_resourceids; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.orcidoauth2authoriziationcodedetail_resourceids (
    orcidoauth2authoriziationcodedetail_authoriziation_code_value character varying(255) NOT NULL,
    resourceids character varying(255) NOT NULL
);


ALTER TABLE public.orcidoauth2authoriziationcodedetail_resourceids OWNER TO orcid;

--
-- Name: orcidoauth2authoriziationcodedetail_scopes; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.orcidoauth2authoriziationcodedetail_scopes (
    orcidoauth2authoriziationcodedetail_authoriziation_code_value character varying(255) NOT NULL,
    scopes character varying(255) NOT NULL
);


ALTER TABLE public.orcidoauth2authoriziationcodedetail_scopes OWNER TO orcid;

--
-- Name: org_affiliation_relation_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.org_affiliation_relation_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.org_affiliation_relation_seq OWNER TO orcid;

--
-- Name: org_disambiguated; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.org_disambiguated (
    id bigint NOT NULL,
    source_id character varying(255),
    source_url character varying(2000),
    source_type character varying(255),
    org_type character varying(4000),
    name character varying(4000),
    city character varying(4000),
    region character varying(4000),
    country character varying(2),
    url character varying(2000),
    status character varying(255),
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    indexing_status character varying(20) DEFAULT 'PENDING'::character varying NOT NULL,
    last_indexed_date timestamp with time zone,
    popularity integer DEFAULT 0 NOT NULL,
    source_parent_id character varying(255)
);


ALTER TABLE public.org_disambiguated OWNER TO orcid;

--
-- Name: org_disambiguated_external_identifier; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.org_disambiguated_external_identifier (
    id bigint NOT NULL,
    org_disambiguated_id bigint,
    identifier character varying(4000),
    identifier_type character varying(4000),
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    preferred boolean DEFAULT false
);


ALTER TABLE public.org_disambiguated_external_identifier OWNER TO orcid;

--
-- Name: org_disambiguated_external_identifier_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.org_disambiguated_external_identifier_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.org_disambiguated_external_identifier_seq OWNER TO orcid;

--
-- Name: org_disambiguated_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.org_disambiguated_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.org_disambiguated_seq OWNER TO orcid;

--
-- Name: org_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.org_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.org_seq OWNER TO orcid;

--
-- Name: other_name; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.other_name (
    other_name_id bigint NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    display_name text,
    orcid character varying(19) NOT NULL,
    visibility character varying(19),
    source_id character varying(19),
    client_source_id character varying(20),
    display_index bigint DEFAULT 0
);


ALTER TABLE public.other_name OWNER TO orcid;

--
-- Name: other_name_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.other_name_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.other_name_seq OWNER TO orcid;

--
-- Name: patent; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.patent (
    patent_id bigint NOT NULL,
    issuing_country character varying(155),
    patent_no character varying(60),
    short_description character varying(550),
    issue_date date,
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE public.patent OWNER TO orcid;

--
-- Name: patent_contributor; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.patent_contributor (
    patent_contributor_id bigint NOT NULL,
    orcid character varying(19),
    patent_id bigint,
    credit_name character varying(450),
    contributor_role character varying(90),
    contributor_sequence character varying(90),
    contributor_email character varying(300),
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE public.patent_contributor OWNER TO orcid;

--
-- Name: patent_contributor_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.patent_contributor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patent_contributor_seq OWNER TO orcid;

--
-- Name: patent_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.patent_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patent_seq OWNER TO orcid;

--
-- Name: patent_source; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.patent_source (
    orcid character varying(19) NOT NULL,
    patent_id bigint NOT NULL,
    source_orcid character varying(19) NOT NULL,
    deposited_date date,
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE public.patent_source OWNER TO orcid;

--
-- Name: peer_review; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.peer_review (
    id bigint NOT NULL,
    orcid character varying(255) NOT NULL,
    peer_review_subject_id bigint,
    external_identifiers_json json NOT NULL,
    org_id bigint NOT NULL,
    peer_review_role text NOT NULL,
    peer_review_type text NOT NULL,
    completion_day integer,
    completion_month integer,
    completion_year integer,
    source_id character varying(255),
    url text,
    visibility character varying(20),
    client_source_id character varying(20),
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    display_index bigint DEFAULT 0,
    subject_external_identifiers_json text,
    subject_type text,
    subject_container_name text,
    subject_name text,
    subject_translated_name text,
    subject_translated_name_language_code text,
    subject_url text,
    group_id text
);


ALTER TABLE public.peer_review OWNER TO orcid;

--
-- Name: peer_review_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.peer_review_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.peer_review_seq OWNER TO orcid;

--
-- Name: peer_review_subject; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.peer_review_subject (
    id bigint NOT NULL,
    external_identifiers_json json NOT NULL,
    title text NOT NULL,
    work_type text NOT NULL,
    sub_title text,
    translated_title text,
    translated_title_language_code text,
    url text,
    journal_title text,
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE public.peer_review_subject OWNER TO orcid;

--
-- Name: peer_review_subject_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.peer_review_subject_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.peer_review_subject_seq OWNER TO orcid;

--
-- Name: profile; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.profile (
    orcid character varying(19) NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    account_expiry timestamp without time zone,
    account_non_locked boolean DEFAULT true,
    completed_date timestamp without time zone,
    claimed boolean DEFAULT false,
    creation_method character varying(20),
    credentials_expiry timestamp without time zone,
    credit_name character varying(150),
    enabled boolean DEFAULT true,
    encrypted_password character varying(255),
    encrypted_security_answer character varying(255),
    encrypted_verification_code character varying(255),
    family_name character varying(150),
    given_names character varying(150),
    is_selectable_sponsor boolean,
    send_change_notifications boolean,
    send_orcid_news boolean,
    biography text,
    vocative_name character varying(450),
    security_question_id integer,
    source_id character varying(19),
    non_locked boolean DEFAULT true,
    biography_visibility character varying(20) DEFAULT 'PRIVATE'::character varying,
    keywords_visibility character varying(20) DEFAULT 'PRIVATE'::character varying,
    external_identifiers_visibility character varying(20) DEFAULT 'PRIVATE'::character varying,
    researcher_urls_visibility character varying(20) DEFAULT 'PRIVATE'::character varying,
    other_names_visibility character varying(20) DEFAULT 'PRIVATE'::character varying,
    orcid_type character varying(20),
    group_orcid character varying(255),
    submission_date timestamp with time zone DEFAULT now() NOT NULL,
    indexing_status character varying(20) DEFAULT 'PENDING'::character varying NOT NULL,
    names_visibility character varying(20) DEFAULT 'PRIVATE'::character varying,
    iso2_country character varying(2),
    profile_address_visibility character varying(20) DEFAULT 'PRIVATE'::character varying,
    profile_deactivation_date timestamp without time zone,
    activities_visibility_default character varying(20) DEFAULT 'PRIVATE'::character varying NOT NULL,
    last_indexed_date timestamp with time zone,
    locale character varying(12) DEFAULT 'EN'::character varying NOT NULL,
    client_type character varying(25),
    group_type character varying(25),
    primary_record character varying(19),
    deprecated_date timestamp with time zone,
    referred_by character varying(20),
    enable_developer_tools boolean DEFAULT false,
    send_email_frequency_days real DEFAULT 7.0 NOT NULL,
    enable_notifications boolean DEFAULT false NOT NULL,
    send_orcid_feature_announcements boolean,
    send_member_update_requests boolean,
    salesforce_id character varying(15),
    client_source_id character varying(20),
    developer_tools_enabled_date timestamp with time zone,
    record_locked boolean DEFAULT false NOT NULL,
    used_captcha_on_registration boolean,
    user_last_ip character varying(50),
    reviewed boolean DEFAULT false NOT NULL,
    send_administrative_change_notifications boolean,
    reason_locked text,
    reason_locked_description text,
    hashed_orcid character varying(256),
    last_login timestamp without time zone,
    secret_for_2fa character varying(255),
    using_2fa boolean DEFAULT false
);


ALTER TABLE public.profile OWNER TO orcid;

--
-- Name: profile_event; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.profile_event (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    orcid character varying(19) NOT NULL,
    profile_event_type character varying(255) NOT NULL,
    comment text
);


ALTER TABLE public.profile_event OWNER TO orcid;

--
-- Name: profile_event_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.profile_event_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_event_seq OWNER TO orcid;

--
-- Name: profile_funding; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.profile_funding (
    id bigint NOT NULL,
    org_id bigint NOT NULL,
    orcid character varying(255) NOT NULL,
    title text NOT NULL,
    type text NOT NULL,
    currency_code character varying(3),
    translated_title text,
    translated_title_language_code text,
    description text,
    start_day integer,
    start_month integer,
    start_year integer,
    end_day integer,
    end_month integer,
    end_year integer,
    url text,
    contributors_json json,
    visibility character varying(20),
    source_id character varying(255),
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    organization_defined_type text DEFAULT 'default'::character varying,
    numeric_amount numeric,
    display_index bigint DEFAULT '0'::bigint,
    client_source_id character varying(20),
    external_identifiers_json json
);


ALTER TABLE public.profile_funding OWNER TO orcid;

--
-- Name: profile_funding_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.profile_funding_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_funding_seq OWNER TO orcid;

--
-- Name: profile_keyword; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.profile_keyword (
    profile_orcid character varying(19) NOT NULL,
    keywords_name text NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    id bigint NOT NULL,
    visibility character varying(19),
    source_id character varying(19),
    client_source_id character varying(20),
    display_index bigint DEFAULT 0
);


ALTER TABLE public.profile_keyword OWNER TO orcid;

--
-- Name: profile_patent; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.profile_patent (
    orcid character varying(19) NOT NULL,
    patent_id bigint NOT NULL,
    added_to_profile_date date,
    visibility character varying(20),
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE public.profile_patent OWNER TO orcid;

--
-- Name: profile_subject; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.profile_subject (
    profile_orcid character varying(19) NOT NULL,
    subjects_name character varying(255) NOT NULL
);


ALTER TABLE public.profile_subject OWNER TO orcid;

--
-- Name: record_name; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.record_name (
    id bigint NOT NULL,
    orcid character varying(255) NOT NULL,
    credit_name text,
    family_name text,
    given_names text,
    visibility character varying(20),
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE public.record_name OWNER TO orcid;

--
-- Name: record_name_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.record_name_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.record_name_seq OWNER TO orcid;

--
-- Name: reference_data; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.reference_data (
    id bigint NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    ref_data_key character varying(255),
    ref_data_value character varying(255)
);


ALTER TABLE public.reference_data OWNER TO orcid;

--
-- Name: reference_data_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.reference_data_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reference_data_seq OWNER TO orcid;

--
-- Name: related_url_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.related_url_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.related_url_seq OWNER TO orcid;

--
-- Name: researcher_url_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.researcher_url_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.researcher_url_seq OWNER TO orcid;

--
-- Name: researcher_url; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.researcher_url (
    url text NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    orcid character varying(19) NOT NULL,
    id bigint DEFAULT nextval('public.researcher_url_seq'::regclass) NOT NULL,
    url_name text,
    visibility character varying(19),
    source_id character varying(19),
    client_source_id character varying(20),
    display_index bigint DEFAULT 0
);


ALTER TABLE public.researcher_url OWNER TO orcid;

--
-- Name: salesforce_connection; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.salesforce_connection (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    orcid character varying(19) NOT NULL,
    email text NOT NULL,
    salesforce_account_id text NOT NULL,
    is_primary boolean DEFAULT true NOT NULL
);


ALTER TABLE public.salesforce_connection OWNER TO orcid;

--
-- Name: salesforce_connection_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.salesforce_connection_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.salesforce_connection_seq OWNER TO orcid;

--
-- Name: security_question; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.security_question (
    id integer NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    question character varying(255),
    key character varying(100)
);


ALTER TABLE public.security_question OWNER TO orcid;

--
-- Name: shibboleth_account; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.shibboleth_account (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    orcid character varying(19) NOT NULL,
    remote_user text NOT NULL,
    shib_identity_provider text NOT NULL
);


ALTER TABLE public.shibboleth_account OWNER TO orcid;

--
-- Name: shibboleth_account_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.shibboleth_account_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shibboleth_account_seq OWNER TO orcid;

--
-- Name: subject; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.subject (
    name text NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE public.subject OWNER TO orcid;

--
-- Name: userconnection; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.userconnection (
    userid text NOT NULL,
    email text,
    orcid character varying(19),
    providerid text NOT NULL,
    provideruserid text NOT NULL,
    rank integer NOT NULL,
    displayname text,
    profileurl text,
    imageurl text,
    accesstoken text,
    secret text,
    refreshtoken text,
    expiretime bigint,
    is_linked boolean DEFAULT false,
    last_login timestamp with time zone,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    id_type text,
    status text DEFAULT 'STARTED'::character varying,
    headers_json json
);


ALTER TABLE public.userconnection OWNER TO orcid;

--
-- Name: webhook; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.webhook (
    orcid character varying(255) NOT NULL,
    client_details_id character varying(255) NOT NULL,
    uri text NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    last_failed timestamp with time zone,
    failed_attempt_count integer DEFAULT 0 NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    disabled_date timestamp with time zone,
    disabled_comments text,
    last_sent timestamp with time zone,
    profile_last_modified timestamp without time zone
);


ALTER TABLE public.webhook OWNER TO orcid;

--
-- Name: work; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.work (
    work_id bigint NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    publication_day integer,
    publication_month integer,
    publication_year integer,
    title text,
    subtitle text,
    description text,
    work_url text,
    citation text,
    work_type text,
    citation_type text,
    contributors_json json,
    journal_title text,
    language_code text,
    translated_title text,
    translated_title_language_code text,
    iso2_country text,
    external_ids_json json,
    orcid character varying(19),
    added_to_profile_date timestamp without time zone,
    visibility character varying(19),
    display_index bigint DEFAULT '0'::bigint,
    source_id character varying(19),
    client_source_id character varying(20)
);


ALTER TABLE public.work OWNER TO orcid;

--
-- Name: work_contributor_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.work_contributor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_contributor_seq OWNER TO orcid;

--
-- Name: work_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.work_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.work_seq OWNER TO orcid;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.external_identifier ALTER COLUMN id SET DEFAULT nextval('public.external_identifier_id_seq'::regclass);


--
-- Name: access_token_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.access_token_seq', 1622, true);


--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.address (id, date_created, last_modified, address_line_1, address_line_2, city, postal_code, state_or_province, orcid, is_primary, iso2_country, visibility, source_id, client_source_id, display_index) FROM stdin;
\.


--
-- Name: address_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.address_seq', 1029, true);


--
-- Data for Name: affiliation; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.affiliation (institution_id, orcid, date_created, last_modified, role_title, start_date, affiliation_details_visibility, end_date, affiliation_type, department_name, affiliation_address_visibility) FROM stdin;
\.


--
-- Name: author_other_name_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.author_other_name_seq', 1000, true);


--
-- Data for Name: backup_code; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.backup_code (id, date_created, last_modified, orcid, used_date, hashed_code) FROM stdin;
\.


--
-- Name: backup_code_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.backup_code_seq', 1, false);


--
-- Data for Name: biography; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.biography (id, orcid, biography, visibility, date_created, last_modified) FROM stdin;
\.


--
-- Name: biography_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.biography_seq', 1017, true);


--
-- Data for Name: client_authorised_grant_type; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.client_authorised_grant_type (client_details_id, grant_type, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: client_details; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.client_details (client_details_id, client_secret, date_created, last_modified, client_name, webhooks_enabled, client_description, client_website, persistent_tokens_enabled, group_orcid, client_type, authentication_provider_id, email_access_reason, allow_auto_deprecate) FROM stdin;
\.


--
-- Data for Name: client_granted_authority; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.client_granted_authority (client_details_id, granted_authority, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: client_redirect_uri; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.client_redirect_uri (client_details_id, redirect_uri, date_created, last_modified, predefined_client_redirect_scope, redirect_uri_type, uri_act_type, uri_geo_area) FROM stdin;
\.


--
-- Data for Name: client_resource_id; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.client_resource_id (client_details_id, resource_id, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.client_scope (client_details_id, scope_type, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: client_secret; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.client_secret (client_details_id, client_secret, date_created, last_modified, is_primary) FROM stdin;
\.


--
-- Data for Name: country_reference_data; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.country_reference_data (country_iso_code, country_name, date_created, last_modified) FROM stdin;
AF	AFGHANISTAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AX	ÅLAND ISLANDS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AL	ALBANIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
DZ	ALGERIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AS	AMERICAN SAMOA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AD	ANDORRA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AO	ANGOLA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AI	ANGUILLA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AQ	ANTARCTICA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AG	ANTIGUA AND BARBUDA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AR	ARGENTINA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AM	ARMENIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AW	ARUBA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AU	AUSTRALIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AT	AUSTRIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AZ	AZERBAIJAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BS	BAHAMAS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BH	BAHRAIN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BD	BANGLADESH	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BB	BARBADOS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BY	BELARUS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BE	BELGIUM	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BZ	BELIZE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BJ	BENIN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BM	BERMUDA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BT	BHUTAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BO	BOLIVIA, PLURINATIONAL STATE OF	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BQ	BONAIRE, SINT EUSTATIUS AND SABA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BA	BOSNIA AND HERZEGOVINA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BW	BOTSWANA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BV	BOUVET ISLAND	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BR	BRAZIL	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
IO	BRITISH INDIAN OCEAN TERRITORY	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BN	BRUNEI DARUSSALAM	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BG	BULGARIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BF	BURKINA FASO	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BI	BURUNDI	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
KH	CAMBODIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CM	CAMEROON	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CA	CANADA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CV	CAPE VERDE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
KY	CAYMAN ISLANDS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CF	CENTRAL AFRICAN REPUBLIC	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TD	CHAD	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CL	CHILE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CN	CHINA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CX	CHRISTMAS ISLAND	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CC	COCOS (KEELING) ISLANDS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CO	COLOMBIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
KM	COMOROS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CG	CONGO	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CD	CONGO, THE DEMOCRATIC REPUBLIC OF THE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CK	COOK ISLANDS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CR	COSTA RICA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CI	CÔTE D'IVOIRE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
HR	CROATIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CU	CUBA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CW	CURAÇAO	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CY	CYPRUS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CZ	CZECH REPUBLIC	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
DK	DENMARK	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
DJ	DJIBOUTI	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
DM	DOMINICA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
DO	DOMINICAN REPUBLIC	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
EC	ECUADOR	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
EG	EGYPT	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SV	EL SALVADOR	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GQ	EQUATORIAL GUINEA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
ER	ERITREA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
EE	ESTONIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
ET	ETHIOPIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
FK	FALKLAND ISLANDS (MALVINAS)	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
FO	FAROE ISLANDS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
FJ	FIJI	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
FI	FINLAND	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
FR	FRANCE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GF	FRENCH GUIANA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
PF	FRENCH POLYNESIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TF	FRENCH SOUTHERN TERRITORIES	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GA	GABON	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GM	GAMBIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GE	GEORGIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
DE	GERMANY	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GH	GHANA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GI	GIBRALTAR	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GR	GREECE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GL	GREENLAND	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GD	GRENADA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GP	GUADELOUPE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GU	GUAM	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GT	GUATEMALA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GG	GUERNSEY	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GN	GUINEA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GW	GUINEA-BISSAU	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GY	GUYANA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
HT	HAITI	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
HM	HEARD ISLAND AND MCDONALD ISLANDS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
VA	HOLY SEE (VATICAN CITY STATE)	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
HN	HONDURAS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
HK	HONG KONG	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
HU	HUNGARY	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
IS	ICELAND	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
IN	INDIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
ID	INDONESIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
IR	IRAN, ISLAMIC REPUBLIC OF	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
IQ	IRAQ	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
IE	IRELAND	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
IM	ISLE OF MAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
IL	ISRAEL	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
IT	ITALY	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
JM	JAMAICA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
JP	JAPAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
JE	JERSEY	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
JO	JORDAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
KZ	KAZAKHSTAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
KE	KENYA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
KI	KIRIBATI	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
KP	KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
KR	KOREA, REPUBLIC OF	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
KW	KUWAIT	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
KG	KYRGYZSTAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
LA	LAO PEOPLE'S DEMOCRATIC REPUBLIC	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
LV	LATVIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
LB	LEBANON	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
LS	LESOTHO	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
LR	LIBERIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
LY	LIBYA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
LI	LIECHTENSTEIN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
LT	LITHUANIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
LU	LUXEMBOURG	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MO	MACAO	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MK	MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MG	MADAGASCAR	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MW	MALAWI	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MY	MALAYSIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MV	MALDIVES	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
ML	MALI	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MT	MALTA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MH	MARSHALL ISLANDS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MQ	MARTINIQUE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MR	MAURITANIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MU	MAURITIUS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
YT	MAYOTTE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MX	MEXICO	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
FM	MICRONESIA, FEDERATED STATES OF	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MD	MOLDOVA, REPUBLIC OF	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MC	MONACO	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MN	MONGOLIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
ME	MONTENEGRO	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MS	MONTSERRAT	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MA	MOROCCO	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MZ	MOZAMBIQUE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MM	MYANMAR	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
NA	NAMIBIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
NR	NAURU	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
NP	NEPAL	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
NL	NETHERLANDS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
NC	NEW CALEDONIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
NZ	NEW ZEALAND	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
NI	NICARAGUA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
NE	NIGER	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
NG	NIGERIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
NU	NIUE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
NF	NORFOLK ISLAND	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MP	NORTHERN MARIANA ISLANDS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
NO	NORWAY	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
OM	OMAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
PK	PAKISTAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
PW	PALAU	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
PS	PALESTINIAN TERRITORY, OCCUPIED	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
PA	PANAMA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
PG	PAPUA NEW GUINEA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
PY	PARAGUAY	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
PE	PERU	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
PH	PHILIPPINES	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
PN	PITCAIRN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
PL	POLAND	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
PT	PORTUGAL	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
PR	PUERTO RICO	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
QA	QATAR	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
RE	RÉUNION	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
RO	ROMANIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
RU	RUSSIAN FEDERATION	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
RW	RWANDA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
BL	SAINT BARTHÉLEMY	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SH	SAINT HELENA, ASCENSION AND TRISTAN DA CUNHA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
KN	SAINT KITTS AND NEVIS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
LC	SAINT LUCIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
MF	SAINT MARTIN (FRENCH PART)	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
PM	SAINT PIERRE AND MIQUELON	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
VC	SAINT VINCENT AND THE GRENADINES	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
WS	SAMOA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SM	SAN MARINO	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
ST	SAO TOME AND PRINCIPE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SA	SAUDI ARABIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SN	SENEGAL	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
RS	SERBIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SC	SEYCHELLES	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SL	SIERRA LEONE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SG	SINGAPORE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SX	SINT MAARTEN (DUTCH PART)	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SK	SLOVAKIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SI	SLOVENIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SB	SOLOMON ISLANDS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SO	SOMALIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
ZA	SOUTH AFRICA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GS	SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SS	SOUTH SUDAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
ES	SPAIN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
LK	SRI LANKA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SD	SUDAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SR	SURINAME	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SJ	SVALBARD AND JAN MAYEN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SZ	SWAZILAND	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SE	SWEDEN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
CH	SWITZERLAND	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
SY	SYRIAN ARAB REPUBLIC	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TJ	TAJIKISTAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TZ	TANZANIA, UNITED REPUBLIC OF	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TH	THAILAND	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TL	TIMOR-LESTE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TG	TOGO	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TK	TOKELAU	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TO	TONGA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TT	TRINIDAD AND TOBAGO	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TN	TUNISIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TR	TURKEY	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TM	TURKMENISTAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TC	TURKS AND CAICOS ISLANDS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TV	TUVALU	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
UG	UGANDA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
UA	UKRAINE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
AE	UNITED ARAB EMIRATES	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
GB	UNITED KINGDOM	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
US	UNITED STATES	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
UM	UNITED STATES MINOR OUTLYING ISLANDS	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
UY	URUGUAY	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
UZ	UZBEKISTAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
VU	VANUATU	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
VE	VENEZUELA, BOLIVARIAN REPUBLIC OF	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
VN	VIET NAM	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
VG	VIRGIN ISLANDS, BRITISH	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
VI	VIRGIN ISLANDS, U.S.	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
WF	WALLIS AND FUTUNA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
EH	WESTERN SAHARA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
YE	YEMEN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
ZM	ZAMBIA	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
ZW	ZIMBABWE	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
TW	TAIWAN	2017-01-17 22:39:52.12621+00	2017-01-17 22:39:52.12621+00
\.


--
-- Data for Name: custom_email; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.custom_email (client_details_id, email_type, content, sender, subject, is_html, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase) FROM stdin;
BASE-INSTALL	Declan Newman	/db/install.xml	2017-01-17 22:39:44.792375	1	EXECUTED	7:e3ff6b349022c50db4746a9dba19a21b	createTable (x29), addPrimaryKey (x11), addUniqueConstraint, addForeignKeyConstraint (x29)		\N	3.2.0
CREATE-SEQUENCES	Declan Newman	/db/install.xml	2017-01-17 22:39:44.89894	2	EXECUTED	7:fe0c16076881b71c52af9b1c2c950711	createSequence (x10)		\N	3.2.0
INIT-BASE-URL	Declan Newman	/db/data.xml	2017-01-17 22:39:44.905288	3	EXECUTED	7:42fdc88d808711833fca1da381148e51	insert		\N	3.2.0
INIT-HEAR_ABOUTS	Declan Newman	/db/data.xml	2017-01-17 22:39:44.970848	4	EXECUTED	7:ff0241b2d24d5fb9d380fbc680256cce	insert (x11)		\N	3.2.0
INIT-REGISTRATION-ROLE	Declan Newman	/db/data.xml	2017-01-17 22:39:44.989114	5	EXECUTED	7:86b47b717cb906700fd8bd6dab500685	insert (x10)		\N	3.2.0
INIT-SECURITY-QUESTIONS	Declan Newman	/db/data.xml	2017-01-17 22:39:45.015492	6	EXECUTED	7:a01ed6127361fd7d00679d4a737fc83f	insert (x19)		\N	3.2.0
INIT-SUBJECTS	Declan Newman	/db/data.xml	2017-01-17 22:39:45.215853	7	EXECUTED	7:16a3c94c5b6a1bd524049d838f24987a	insert (x149)		\N	3.2.0
ADD-TABLE-FOR-DELEGATION-OF-PERMISSIONS	will	/db/updates/0.2.xml	2017-01-17 22:39:45.291094	8	EXECUTED	7:7f5770c25eacf551c41216fdf08fc572	createTable, addPrimaryKey, addForeignKeyConstraint (x2)		\N	3.2.0
ADD-DATES-AND-ID-TO-DELEGATION-OF-PERMISSIONS	will	/db/updates/0.2.xml	2017-01-17 22:39:45.301913	9	EXECUTED	7:a63cb6b22727819f2ca523494dfab515	addColumn, dropPrimaryKey, addPrimaryKey		\N	3.2.0
ADD-SEQUENCE-FOR-DELEGATION-OF-PERMISSIONS	will	/db/updates/0.2.xml	2017-01-17 22:39:45.373314	10	EXECUTED	7:53ba9c19d87340918de6fb6028551def	createSequence		\N	3.2.0
ADD-VISIBILITY-ENUMS	Declan Newman	/db/updates/0.2.xml	2017-01-17 22:39:45.488385	11	EXECUTED	7:ac82b4e702654826daa7eec1158f8e42	addColumn (x3)		\N	3.2.0
DROP-KEYWORD-VISIBILITY	Declan Newman	/db/updates/0.2.xml	2017-01-17 22:39:45.606929	12	EXECUTED	7:882d6536719760806feaebd5a6c904d2	dropColumn		\N	3.2.0
ADD-OTHER_NAMES_VISIBILITY	Declan Newman	/db/updates/0.2.xml	2017-01-17 22:39:45.71038	13	EXECUTED	7:5546db3ba56954df8d64ca912556d718	addColumn		\N	3.2.0
CREATE-OAUTH-TABLES	Declan Newman	/db/updates/0.2.xml	2017-01-17 22:39:45.82466	14	EXECUTED	7:22741fb877a0a75b81a30eddfa295c68	createTable (x6), addPrimaryKey (x6), addForeignKeyConstraint (x5), createIndex (x6)		\N	3.2.0
ADD-VISIBILITY-FOR-WORKS-TO-PROFILE	james	/db/updates/0.2.xml	2017-01-17 22:39:45.916618	15	EXECUTED	7:c8c20b3752f7a719709e39df9576eef5	addColumn		\N	3.2.0
CHANGE_PAGE_NUMBERS_FROM_INTEGER_TO_STRING	will	/db/updates/0.2.xml	2017-01-17 22:39:45.930782	16	EXECUTED	7:5a6c1cffc387908a3c62b349ed6643ec	modifyDataType (x2)		\N	3.2.0
ADD-CLIENT_DETAILS_PROFILE_RELATIONSHIP	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:46.025715	17	EXECUTED	7:479a986e8aa9b8efd28bbd9ed655f203	addColumn, addForeignKeyConstraint		\N	3.2.0
ADD-GROUPS-AND-CLIENTS	Will Simpson	/db/updates/1.0.xml	2017-01-17 22:39:46.030641	18	EXECUTED	7:f701244fd917473d6a95f7d01672be39	addColumn		\N	3.2.0
REMOVE_ORCID_FROM_CLIENT_DETAILS	Will Simpson	/db/updates/1.0.xml	2017-01-17 22:39:46.03731	19	EXECUTED	7:149bbe7942652909d457840731cf96c4	dropForeignKeyConstraint, dropColumn		\N	3.2.0
CREATE-APPROVED-CLIENT-PROFILE-TABLE	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:46.053469	20	EXECUTED	7:60a008ecebcd230270637b2905ec8c2c	createTable, addForeignKeyConstraint (x2)		\N	3.2.0
ADD-PROFILE-DETAILS-PRIMARY-KEY	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:46.237346	21	EXECUTED	7:576a0133b34deeaae2abe174e2d4ff7f	addPrimaryKey		\N	3.2.0
CREATE-OAUTH2-REFRESH-TOKEN-DETAIL	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:46.263441	22	EXECUTED	7:13277cf968d4c0c9a8d9e03a47278b44	createTable, addUniqueConstraint, addForeignKeyConstraint (x2), createIndex (x4)		\N	3.2.0
CREATE-OAUTH2-TOKEN-DETAIL	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:46.305876	23	EXECUTED	7:e227e269224e184ae83a4a83311d4765	createTable, addUniqueConstraint (x2), addForeignKeyConstraint (x3), createIndex (x4)		\N	3.2.0
ADD-CLIENT-DETAILS-NAME-COLUMN	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:46.336928	24	EXECUTED	7:17611c5282ca0150e9aabfdf0cb9e1fa	addColumn		\N	3.2.0
CHANGE-CLIENT-DETAILS-CONSTRAINTS	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:46.728196	25	EXECUTED	7:9be2496773ebfdabd90b83c4de38868a	dropForeignKeyConstraint (x5), addForeignKeyConstraint (x5)		\N	3.2.0
CREATE-AUTHORIZATION-CODE_TABLES	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:46.751689	26	EXECUTED	7:bef3e7914d4bed01e88696404df856f9	createTable (x4), addPrimaryKey (x3), addForeignKeyConstraint (x5)		\N	3.2.0
ADD-OAUTH-AUTHORIZATION-CODE-INDEXES	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:48.177971	27	EXECUTED	7:c2b9ee18150ab89c96702370f2d8f683	createIndex (x5)		\N	3.2.0
ADD-PROFILE-INDEXES	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:49.612149	28	EXECUTED	7:f39e56f2c9b107db2510d7540d970671	createIndex (x2)		\N	3.2.0
DELETE-PROFILE-CLIENT-DETAILS-TABLE	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:49.668579	29	EXECUTED	7:832842bffe4d3d7abd37036668362069	dropTable		\N	3.2.0
CHANGE-TOKEN-PROFILE-COLUMN-NAME	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:49.675881	30	EXECUTED	7:6f6908a6dafb3c4fc49c94a1b9c46442	renameColumn		\N	3.2.0
CHANGE-REFRESH-TOKEN-PROFILE-COLUMN-NAME	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:49.682248	31	EXECUTED	7:7fa757ae9744e7b401772eb3e4025b9b	renameColumn		\N	3.2.0
UPDATE-TOKEN-CONSTRAINTS	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:50.834304	32	MARK_RAN	7:12e0f7f7b87011fabb322ec87de1fdc1	dropForeignKeyConstraint (x2), addForeignKeyConstraint (x2)		\N	3.2.0
PREPARE-TO-ADD-GENERATED-PK-TO-RESEARCHER-URL	Will Simpson	/db/updates/1.0.xml	2017-01-17 22:39:50.839809	33	EXECUTED	7:92b344b08549e4a24e5922c05e8e9a60	dropPrimaryKey, renameColumn, addUniqueConstraint		\N	3.2.0
ADD-SEQUENCE-FOR-RESEARCHER-URL-ID	Will Simpson	/db/updates/1.0.xml	2017-01-17 22:39:50.896904	34	EXECUTED	7:2fe5c9271183f64b0d12d6429a480182	createSequence, addColumn		\N	3.2.0
FINISH-ADDING-GENERATED-PK-TO-RESEARCHER-URL	Will Simpson	/db/updates/1.0.xml	2017-01-17 22:39:50.900685	35	EXECUTED	7:1ef1b584ca315aec466b6cba12b4a6ef	addPrimaryKey		\N	3.2.0
ADD-TIMESTAMPS-TO-PROFILE-KEYWORD-TABLE	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:50.941457	36	EXECUTED	7:0bf74bc3c1b6019ad5c57535b77e71fd	addColumn		\N	3.2.0
DROP-KEYWORD-TABLE	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:50.951793	37	EXECUTED	7:6bc5cf1fecb17e2fe3315738ea1f712f	dropForeignKeyConstraint, dropTable		\N	3.2.0
CREATE-KEYWORD-VIEW	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:50.962021	38	EXECUTED	7:88f4645da4f5eb7aaf455e525cd312c5	createView		\N	3.2.0
UPDATE-EXTERNAL-IDENTIFIER-PK	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:51.068025	39	MARK_RAN	7:a8324b26542129da74c7ddf98e5ff29d	dropPrimaryKey, addPrimaryKey		\N	3.2.0
DROP-REFRESH-TOKEN-TABLE	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:51.07307	40	EXECUTED	7:6c8fc766d808cc5658cfd4aac52225e2	dropForeignKeyConstraint, dropTable		\N	3.2.0
ADD-WEBHOOK-SCOPE-TO-ALL-CLIENTS	Will Simpson	/db/updates/webhooks.xml	2017-01-17 22:39:52.622529	123	EXECUTED	7:76cb33da4545705b1e0eda022f6af5e4	sql		\N	3.2.0
PREPARE-TO-ADD-REFRESH-DETAILS-TO-TOKEN-TABLE	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:51.080626	41	EXECUTED	7:c3a551b89ee54b790479b87dbaf4d171	dropPrimaryKey, dropNotNullConstraint, dropColumn		\N	3.2.0
ADD-REFRESH-DETAILS-TO-TOKEN-TABLE	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:51.176444	42	EXECUTED	7:b815feb1a9fc9f133b1027d5cd87f390	createSequence, addColumn (x3)		\N	3.2.0
ADD-TOKEN-DISABLED-COLUMN	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:51.207017	43	EXECUTED	7:a89b4b9595a388f05c38d526187c25e9	addColumn		\N	3.2.0
CHANGE-REFRESH-TOKEN-SCOPE-LENGTH	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:51.265385	44	EXECUTED	7:363680f6509969479d1d266339f64466	modifyDataType		\N	3.2.0
UPDATE-ACCESSION-NUM-PK	Declan Newman	/db/updates/1.0.xml	2017-01-17 22:39:51.273992	45	EXECUTED	7:c028dea5154a67c47a958a7bebd230dc	dropPrimaryKey, renameColumn, addPrimaryKey		\N	3.2.0
MAKE-SUBMISSION-DATE-NOT-NULL	Will Simpson	/db/updates/1.0.xml	2017-01-17 22:39:51.282081	46	EXECUTED	7:f2b88ce61f963476ebd1105627d93305	dropColumn, addColumn		\N	3.2.0
ADD-INDEXING-STATUS	Will Simpson	/db/updates/1.0.6.xml	2017-01-17 22:39:51.290963	47	EXECUTED	7:b05ab4857c67e88c86a42f4fb4903529	addColumn, createIndex		\N	3.2.0
MAKE-OAUTH2-STATE-COLUMN-BIGGER	Will Simpson	/db/updates/1.0.6.xml	2017-01-17 22:39:51.293395	48	EXECUTED	7:6ae9f582b63ed27a92c458b1aa35a507	modifyDataType		\N	3.2.0
ADD-WORK-ID-TO-AUTHORS	Will Simpson	/db/updates/1.0.8.xml	2017-01-17 22:39:51.303751	49	EXECUTED	7:33278f1449fe8db06ad3e1ed19854849	addColumn, createIndex, addForeignKeyConstraint, sql, dropTable (x2)		\N	3.2.0
ADD-WORK-ID-INDEXES	Will Simpson	/db/updates/1.0.8.xml	2017-01-17 22:39:51.308902	50	EXECUTED	7:81e27f6557bae65b8c0b8ba65ff26c23	createIndex (x2)		\N	3.2.0
ADD-ORCID-INDEXES	Will Simpson	/db/updates/1.0.8.xml	2017-01-17 22:39:51.370672	51	EXECUTED	7:ae0b584076d511032ca0a9e86355fe35	createIndex (x7)		\N	3.2.0
PER-WORK-VISIBILITY	Will Simpson	/db/updates/1.0.9.xml	2017-01-17 22:39:51.374303	52	EXECUTED	7:e3514a27394687de7b48a9b7c21e147a	addColumn, dropColumn		\N	3.2.0
POSTGRES-RENAME-ROLE-COLUMN	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.384599	53	EXECUTED	7:d7b531a404a42c4aa542f3f27bd81b54	renameColumn		\N	3.2.0
UPDATE-AND-RENAME-PRIMARY-PROFILE-INSTITUTION-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.393839	54	EXECUTED	7:8caf60fc41498f99acd81c140df730c3	addColumn, update, renameColumn, dropColumn, renameTable		\N	3.2.0
COPY-AND-DROP-PAST-PROFILE-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.400045	55	EXECUTED	7:a7e7185a751ece1b1e0d75c1631fbbb1	sql, dropTable, dropColumn		\N	3.2.0
COPY-AND-DROP-AFFILIATE-PROFILE-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.405403	56	EXECUTED	7:80321769c810894b34c0988b5fc1ef15	sql, dropTable		\N	3.2.0
CHANGE-WORK-PRIMARY-KEY-NAME	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.411905	57	EXECUTED	7:7ffafd88e38740aa194c0de63ba6a1e4	renameColumn		\N	3.2.0
ADD-WORK-EXTERNAL-URL	Declan Neaman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.470489	58	EXECUTED	7:1bc496e3d4b21f1451bccd2204f4d9d6	addColumn		\N	3.2.0
DROP-COLUMNS-OF-WORK-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.48125	59	EXECUTED	7:0522afa7f33395cf0ce4c15b03c1dd4e	dropColumn (x11)		\N	3.2.0
ADD-COLUMNS-TO-WORK-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.504763	60	EXECUTED	7:ba5b22c96876e4cd9db0219a07a5513d	addColumn		\N	3.2.0
CREATE-GRANT-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.567166	61	EXECUTED	7:fc63a012aeac73860f0857c6c47bbcef	createTable, addForeignKeyConstraint		\N	3.2.0
CREATE-FUNDING-GRANT-SEQUENCE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.578918	62	EXECUTED	7:0e55838ebceac72e000fd06062326c51	createSequence		\N	3.2.0
CREATE-PROFILE-GRANT-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.589811	63	EXECUTED	7:7e4169a76b6cb3071fe25d1ff542bc41	createTable, addForeignKeyConstraint (x2), addPrimaryKey		\N	3.2.0
CREATE-PATENT-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.599297	64	EXECUTED	7:c69c60da879b67253145efdcfff07f71	createTable		\N	3.2.0
CREATE-PATENT-SEQUENCE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.609446	65	EXECUTED	7:3ca217b0258aa2e4f22c6086448d239f	createSequence		\N	3.2.0
CREATE-PROFILE-PATENT-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.671487	66	EXECUTED	7:09f5ca3d378ff986becdbde506db43f2	createTable, addForeignKeyConstraint (x2), addPrimaryKey		\N	3.2.0
CREATE-WORK-SOURCE-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.683166	67	EXECUTED	7:64b637fdeb21dd8ad173ffe60e5b0034	createTable, addPrimaryKey, addForeignKeyConstraint (x3)		\N	3.2.0
CREATE-GRANT-SOURCE-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.694047	68	EXECUTED	7:a17055d356e0d9cb976ba44e577691be	createTable, addPrimaryKey, addForeignKeyConstraint (x3)		\N	3.2.0
CREATE-PATENT-SOURCE-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.705213	69	EXECUTED	7:d08299d9817ce47e587842bbb70e0a08	createTable, addPrimaryKey, addForeignKeyConstraint (x3)		\N	3.2.0
DROP-AUTHOR-OTHER-NAME-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.709004	70	EXECUTED	7:981ae57de1cf37ca4544e6312429772f	dropTable		\N	3.2.0
RENAME-AUTHOR-TABLE-TO-WORK-CONTRUBUTOR	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.717733	71	EXECUTED	7:fb3303a208c0addc441999716f67fba4	renameTable, renameColumn, addColumn, dropColumn (x4)		\N	3.2.0
CREATE-GRANT-CONTRIBUTOR	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.776253	72	EXECUTED	7:cca2da7629a29a63ab9f77c0a12523ec	createTable, addForeignKeyConstraint (x2)		\N	3.2.0
CREATE-PATENT-CONTRIBUTOR	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.786535	73	EXECUTED	7:abbf100f2910d790adbdd3bdabf15e86	createTable, addForeignKeyConstraint (x2)		\N	3.2.0
CREATE-WORK-EXTERNAL-IDENTIFIER-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.796486	74	EXECUTED	7:80a43a4f188533bc7dde33e7d2ea7581	createTable, addPrimaryKey, addForeignKeyConstraint		\N	3.2.0
CREATE-CONTRIBUTOR-SEQUENCES	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.811094	75	EXECUTED	7:9217f15a7e7c95a48ea8327980d56940	renameTable, createSequence (x2)		\N	3.2.0
DROP-ACCESSION-NUM-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.815005	76	EXECUTED	7:5b8ad07f6ba85c05c4e19a087ad6c31e	dropTable		\N	3.2.0
DROP-ELECTRONIC-RESOURCE-NUM-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.818506	77	EXECUTED	7:71de64c5660c7c7713856df52938d6c3	dropTable		\N	3.2.0
DROP-RELATED-URL-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.873221	78	EXECUTED	7:84a9c0315c8ba59ea0929aa67d2c682a	dropTable		\N	3.2.0
DROP-INSTITUTION-DEPARTMENT-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.876782	79	EXECUTED	7:8fcda4a7bdd9a9f74f14467828d2099a	dropTable		\N	3.2.0
ADD-VISIBILITY-TO-RESEARCHER-URL-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.907873	80	EXECUTED	7:183d41af4145562687625c807d0a839f	addColumn		\N	3.2.0
ALTER-PROFILE-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.919913	81	EXECUTED	7:ba5629f957cc0115e64043ce956cce8c	renameColumn (x7), update, addColumn, dropColumn		\N	3.2.0
ALTER-EXTERNAL-IDENTIFIER-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.933054	82	EXECUTED	7:10ae00e58cf67f3b05687a179eef7f11	delete, dropPrimaryKey, dropColumn (x2), addColumn, addPrimaryKey, addForeignKeyConstraint		\N	3.2.0
ADD-ALTERNATE-EMAIL-TABLE	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.98017	83	EXECUTED	7:f9dd71458c677bd9e0e49d2717fe0be1	createTable, addPrimaryKey, addForeignKeyConstraint		\N	3.2.0
UPDATE-PROTECTED-VISIBILITY-VALUES	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.98297	84	MARK_RAN	7:9bc87554bb89e6b69eff486e57c05d0f	update (x10)		\N	3.2.0
UPDATE-PROTECTED-SCOPE-TO-LIMITED	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.99326	85	EXECUTED	7:a7d042a1c00fd0aa900d390c8df14756	delete, update (x5)		\N	3.2.0
UPDATE-SCOPES-OAUTH-TOKEN-DETAIL	Declan Newman	/db/updates/1.0.9.xml	2017-01-17 22:39:51.997082	86	EXECUTED	7:34e8a40b9e3e3f2a4a3476126b04b8fc	update (x5)		\N	3.2.0
FIX-WORKS-READ-LIMITED-SCOPE	Will Simpson	/db/updates/1.0.11.xml	2017-01-17 22:39:51.999236	87	EXECUTED	7:8b87c5301fd03f602a9fa3b1e6685226	sql		\N	3.2.0
ADD-CONTRIBUTOR-ATTRIBUTE-CONSTRAINTS	Will Simpson	/db/updates/1.0.11.xml	2017-01-17 22:39:52.00521	88	EXECUTED	7:832d7bfd78449af8d73f26c27e008822	addNotNullConstraint (x6)		\N	3.2.0
ADD-PROFILE-ADDRESS-VISIBILITY	James Bowen	/db/updates/1.0.14.xml	2017-01-17 22:39:52.00902	89	EXECUTED	7:c6ca877537e558c97819fbafb1aa3b7f	addColumn		\N	3.2.0
ADD-AFFILATION_ADDRESS-VISIBILITY	James Bowen	/db/updates/1.0.14.xml	2017-01-17 22:39:52.011341	90	EXECUTED	7:5395dd662d6d492facc0c9b1423068b2	addColumn		\N	3.2.0
ADD-EMAIL-VERIFIED	Will Simpson	/db/updates/1.0.15.xml	2017-01-17 22:39:52.023082	91	EXECUTED	7:efa5be79137fe92fa83366dd20df0901	addColumn		\N	3.2.0
RENAME-EMAIL-PREFERENCES	Will Simpson	/db/updates/1.0.15.xml	2017-01-17 22:39:52.026553	92	EXECUTED	7:7aa9a37c80f92255614d4b71a00dc082	renameColumn (x2), dropColumn		\N	3.2.0
ADD_PREDEFINED_REDIRECT_SCOPE_FOR_CLIENT	James Bowen	/db/updates/1.0.16.xml	2017-01-17 22:39:52.028763	93	EXECUTED	7:df0a1dae575ccf11f758193edcf41719	addColumn		\N	3.2.0
ALTER_PREDEFINED_REDIRECT_SCOPE_LENGTH	James Bowen	/db/updates/1.0.17.xml	2017-01-17 22:39:52.030977	94	EXECUTED	7:5844d23b23f165b03449c396cd58b771	modifyDataType		\N	3.2.0
ALTER_DEFAULT_SECURITY_QUESTION_VALUE	James Bowen	/db/updates/1.0.18.xml	2017-01-17 22:39:52.032728	95	EXECUTED	7:f9bbd03b0fc8892406e41c49e531d2ee	sql		\N	3.2.0
ADD_DEACTIVATION_DATE_TO_PROFILE	James Bowen	/db/updates/1.0.18.xml	2017-01-17 22:39:52.034725	96	EXECUTED	7:422cb17a27f3c349c63bd21497494787	addColumn		\N	3.2.0
ADD-CITATION-TYPE-COLUMN-TO-WORK-TABLE	Declan Newman	/db/updates/1.0.18.xml	2017-01-17 22:39:52.082982	97	EXECUTED	7:91ebed30f144b239aba119e1c3ca9699	addColumn		\N	3.2.0
ALTER-CITATION-COLUMN-LENGTH	Declan Newman	/db/updates/1.0.18.xml	2017-01-17 22:39:52.089463	98	EXECUTED	7:a443c225a1362b2311e5d2f259c05637	modifyDataType		\N	3.2.0
REMOVE_REGISTRATION_ENTITY	James Bowen	/db/updates/1.0.19.xml	2017-01-17 22:39:52.101196	99	EXECUTED	7:0ec51d68c90197669314e546f7e84a6b	dropTable		\N	3.2.0
ADD_EXTERNAL_IDENTIFIER_REFERENCE_DATA	James Bowen	/db/updates/1.0.19.xml	2017-01-17 22:39:52.105218	100	EXECUTED	7:e52919bc80bb67498a38a203ffba57e8	createTable		\N	3.2.0
INIT_EXTERNAL_IDENTIFIER_REFERENCE_DATA	James Bowen	/db/updates/1.0.19.xml	2017-01-17 22:39:52.117202	101	EXECUTED	7:6552ebf8376e06b62ef3e0c1030104db	insert (x21)		\N	3.2.0
ADD_COUNTRY_REFERENCE_DATA	James Bowen	/db/updates/1.0.19.xml	2017-01-17 22:39:52.122845	102	EXECUTED	7:f3a7731d514f45c57f660209ee6f4ebb	createTable		\N	3.2.0
INIT_COUNTRY_REFERENCE_DATA	James Bowen	/db/updates/1.0.19.xml	2017-01-17 22:39:52.388353	103	EXECUTED	7:6d3459fe2a38d61776aa6e5a32ddae5a	insert (x249)		\N	3.2.0
DROP-NOT-NULL-CONSTRAINTS-FROM-CONTRIBUTOR-TYPES	Declan Newman	/db/updates/1.0.19.xml	2017-01-17 22:39:52.412297	104	EXECUTED	7:30c5d64520a1eed71ae47576d58a0094	dropNotNullConstraint (x6)		\N	3.2.0
DROP-EXTERNAL-ID-REF-DATA-TABLE	Declan Newman	/db/updates/1.0.19.xml	2017-01-17 22:39:52.415568	105	EXECUTED	7:6c7d147392d5d46f47241d4a4606ef90	dropTable		\N	3.2.0
MIGRATE_BIBLE_TO_RELIGIOUS_TEXT	James Bowen	/db/updates/1.0.22.xml	2017-01-17 22:39:52.417844	106	EXECUTED	7:043a755bf2294ce86ea259865dfff87b	update		\N	3.2.0
MIGRATE_TAIWAN	James Bowen	/db/updates/1.1.13.xml	2017-01-17 22:39:52.421379	107	EXECUTED	7:4cabfd5b6b574e1c9b2b11781e8cf336	update		\N	3.2.0
INCREASE_BIOGRAPHY_LENGTH	James Bowen	/db/updates/1.1.3.4.xml	2017-01-17 22:39:52.424202	108	EXECUTED	7:e963539dde49e2a3044dc1d9c13c31a8	modifyDataType		\N	3.2.0
ADD-SOURCE-TO-PROFILE-WORKS	Angel Montenegro	/db/updates/add-source-to-profile-works.xml	2017-01-17 22:39:52.430219	109	EXECUTED	7:23d560d9a77f333ac158643b13716d9f	addColumn, dropForeignKeyConstraint, addForeignKeyConstraint		\N	3.2.0
ADD-WORK-VISIBILITY-DEFAULT	Will Simpson	/db/updates/works-global-priv-setting.xml	2017-01-17 22:39:52.498793	110	EXECUTED	7:20f9c025f646feb5b224cb0489b02e1d	addColumn		\N	3.2.0
MAKE-WORK-VISIBILITY-NOT-NULL	Will Simpson	/db/updates/works-global-priv-setting.xml	2017-01-17 22:39:52.501767	111	EXECUTED	7:44a9ed88998477dc97ba1e61d6ca93ee	addNotNullConstraint		\N	3.2.0
CREATE-NEW-EMAIL-TABLE	Will Simpson	/db/updates/multiple-emails.xml	2017-01-17 22:39:52.515692	112	EXECUTED	7:a3365946bc35cdcd1a1276b8ea8e18d9	createTable, addPrimaryKey, addForeignKeyConstraint		\N	3.2.0
ADD-LAST-INDEXED-DATE-TO-PROFILE	Will Simpson	/db/updates/claim-wait-period.xml	2017-01-17 22:39:52.518753	113	EXECUTED	7:0c4891dc583fd3d0f6513b36d3a704b6	addColumn		\N	3.2.0
CREATE-PROFILE-EVENT-TABLE	Will Simpson	/db/updates/claim-wait-period.xml	2017-01-17 22:39:52.525656	114	EXECUTED	7:875552543f36cc987efca660a05e0517	createTable, addForeignKeyConstraint		\N	3.2.0
CREATE-PROFILE-EVENT-SEQUENCE	Will Simpson	/db/updates/claim-wait-period.xml	2017-01-17 22:39:52.531858	115	EXECUTED	7:85fffe53c55afb98ef6cf0b3da636018	createSequence		\N	3.2.0
CREATE-NEW-EMAIL-TABLE	Will Simpson	/db/updates/increase-citation-size-limit.xml	2017-01-17 22:39:52.534503	116	EXECUTED	7:85d40e52b2181171907affe15d54ed35	modifyDataType		\N	3.2.0
ADD-CASE-INSENSITIVE-UNIQUE-CONSTRAINT-TO-EMAIL	Will Simpson	/db/updates/fix-email-case-sensitivity.xml	2017-01-17 22:39:52.54181	117	EXECUTED	7:9a666c6a88e8d5057c914c5612495bab	createIndex		\N	3.2.0
ADD-EMAIL-SOURCE	Will Simpson	/db/updates/email-source.xml	2017-01-17 22:39:52.548276	118	EXECUTED	7:2daa3b8049ee5bfe7e2d07f587de8bcc	addColumn, addForeignKeyConstraint		\N	3.2.0
CREATE-WEBHOOK-TABLE	Will Simpson	/db/updates/webhooks.xml	2017-01-17 22:39:52.607404	119	EXECUTED	7:3c01d2b94fad11a4b2583dfbebcb7b27	createTable, addPrimaryKey, addForeignKeyConstraint (x2)		\N	3.2.0
ADD-WEBHOOKS-ENABLED-TO-CLIENT-DETAILS	Will Simpson	/db/updates/webhooks.xml	2017-01-17 22:39:52.61482	120	EXECUTED	7:5b30e60a66369f4481252c95991642a3	addColumn		\N	3.2.0
CREATE-UNIX-TIMESTAMP-FUCTION	Will Simpson	/db/updates/webhooks.xml	2017-01-17 22:39:52.618155	121	EXECUTED	7:55f0e764852738129fa995f3b93e351d	createProcedure		\N	3.2.0
ADD-LAST-SENT-DATE-TO-WEBHOOK	Will Simpson	/db/updates/webhooks.xml	2017-01-17 22:39:52.62042	122	EXECUTED	7:755b97fc95f79797d81a27dfe495952f	addColumn		\N	3.2.0
INCREASE-IDENTIFIER-LENGTH	Angel Montenegro	/db/updates/increase-work-external-identifier-length.xml	2017-01-17 22:39:52.627724	124	EXECUTED	7:bc9f0e762fcc5c07de84167a1666d657	modifyDataType		\N	3.2.0
ADD-REDIRECT-TYPE-COLUMN	rcpeters	/db/updates/add_client_redir_type.xml	2017-01-17 22:39:52.633869	125	EXECUTED	7:702073f4f36efe4832ee11c571e84595	addColumn		\N	3.2.0
DEFINE-IMPORT-WORKS-WIZARD	RCPETERS	/db/updates/define-import-works-wizard.xml	2017-01-17 22:39:52.636235	126	EXECUTED	7:69130f73c26db5032aa7dfcda413efb1	sql		\N	3.2.0
REMOVE-OLD-WAY-OF-DOING-EMAILS	Will Simpson	/db/updates/remove-old-way-of-doing-emails.xml	2017-01-17 22:39:52.642591	127	EXECUTED	7:a8256b98d4f812359b4d5c00ca559d9c	dropColumn (x4), dropTable		\N	3.2.0
ADD-LOCALE	rcpeters	/db/updates/locale-setting.xml	2017-01-17 22:39:52.651897	128	EXECUTED	7:a80dcb0b59edcfad0d2aecfabe50894d	addColumn		\N	3.2.0
REFACTOR_LOCALE_DROP_DEFAULT	RCPETERS	/db/updates/locale-refactor-setting.xml	2017-01-17 22:39:52.701521	129	EXECUTED	7:41dae5a279738ec048ce711dd509b1e6	dropDefaultValue		\N	3.2.0
REFACTOR_LOCALE_ADD_DEFAULT	RCPETERS	/db/updates/locale-refactor-setting.xml	2017-01-17 22:39:52.704217	130	EXECUTED	7:54ef9a463c39fe79c56d0fabb25b0b36	addDefaultValue		\N	3.2.0
REFACTOR_LOCALE_EN	RCPETERS	/db/updates/locale-refactor-setting.xml	2017-01-17 22:39:52.706311	131	EXECUTED	7:3a8a942bf38fb0b6419264297958f102	sql		\N	3.2.0
REFACTOR_LOCALE_FR	RCPETERS	/db/updates/locale-refactor-setting.xml	2017-01-17 22:39:52.708525	132	EXECUTED	7:348a7e90884569ed9bc0ee4031d40b5c	sql		\N	3.2.0
REFACTOR_LOCALE_ES	RCPETERS	/db/updates/locale-refactor-setting.xml	2017-01-17 22:39:52.710416	133	EXECUTED	7:346a2a76ac8a8d9acd175f00be04beab	sql		\N	3.2.0
REFACTOR_LOCAL_ZH_CN	RCPETERS	/db/updates/locale-refactor-setting.xml	2017-01-17 22:39:52.712442	134	EXECUTED	7:7605b93cbe621e49097715ca91901f92	sql		\N	3.2.0
REFACTOR_LOCAL_ZH_TW	RCPETERS	/db/updates/locale-refactor-setting.xml	2017-01-17 22:39:52.714704	135	EXECUTED	7:7843959edb3717e887ca6540cf657cb1	sql		\N	3.2.0
ADD-KEY-TO-SECURITY-QUESTION	Angel Montenegro	/db/updates/add-key-to-security-questions.xml	2017-01-17 22:39:52.725724	136	EXECUTED	7:ac2cb723d2463bec57cd23facd24723b	addColumn, update (x19)		\N	3.2.0
CREATE-NEW-EMAIL-TABLE	RCPETERS	/db/updates/increase-bio-text-size-limit.xml	2017-01-17 22:39:52.729424	137	EXECUTED	7:55b75b4de558379be37468db1e0a0176	modifyDataType		\N	3.2.0
CREATE-ORG-TABLES	Will Simpson	/db/updates/disambiguated_affiliations.xml	2017-01-17 22:39:52.750235	138	EXECUTED	7:c47d8e7e8db5da2afed5132c60a53f1b	createTable (x2), addUniqueConstraint, addForeignKeyConstraint (x2)		\N	3.2.0
CREATE-ORG-SEQUENCES	Will Simpson	/db/updates/disambiguated_affiliations.xml	2017-01-17 22:39:52.806472	139	EXECUTED	7:e9695acb68c3b064099ea9f089d896a5	createSequence (x2)		\N	3.2.0
MAKE-SURE-COUNTRY-IS-NULL-NOT-EMPTY-STRING	Will Simpson	/db/updates/disambiguated_affiliations.xml	2017-01-17 22:39:52.808628	140	EXECUTED	7:b011a44397e8895b50c9a8052baa4ab2	sql		\N	3.2.0
CREATE-DISAMBIGUATED-ORG-TABLES	Will Simpson	/db/updates/disambiguated_affiliations.xml	2017-01-17 22:39:52.82774	141	EXECUTED	7:0cb778c9d3a429c8006964d51e61dae6	createTable, addUniqueConstraint, createTable, addForeignKeyConstraint, addColumn, addForeignKeyConstraint		\N	3.2.0
CREATE-ORG-DISAMBIGUATED-SEQUENCES	Will Simpson	/db/updates/disambiguated_affiliations.xml	2017-01-17 22:39:52.832854	142	EXECUTED	7:62516dd1d89b16ceb13ac4deeb9cbc98	createSequence (x2)		\N	3.2.0
ADD-AFFILIATION-SCOPES-TO-EXISTING-CLIENTS	Will Simpson	/db/updates/disambiguated_affiliations.xml	2017-01-17 22:39:52.835612	143	EXECUTED	7:474bb1051a50c880acc60acbdd7c42e0	sql (x2)		\N	3.2.0
ADD-AFFILIATION-READ-LIMITED-SCOPE-TO-EXISTING-CLIENTS	Will Simpson	/db/updates/disambiguated_affiliations.xml	2017-01-17 22:39:52.837967	144	EXECUTED	7:d1bc7b9b7b2f653fdbcf2fc5e9a1ad66	sql		\N	3.2.0
INSERT-DUMMY-DISAMBIGUATED-VALUES-FOR-TESTING	Will Simpson	/db/updates/disambiguated_affiliations.xml	2017-01-17 22:39:52.849408	145	EXECUTED	7:217e2a189f45aade0c40e17e62ca6334	sql		\N	3.2.0
ADD-INDEXING-AND-POPULARTIY-COLUMNS-TO-ORG-DISAMBIGUATED	Will Simpson	/db/updates/disambiguated_affiliations.xml	2017-01-17 22:39:52.915709	146	EXECUTED	7:14dd9374db34da983c116036c76eb01f	addColumn (x3)		\N	3.2.0
ADD-VIEW-OF-AMBIGUOUS-ORGS	Will Simpson	/db/updates/disambiguated_affiliations.xml	2017-01-17 22:39:52.921049	147	EXECUTED	7:4f57818b467ba9dea75fb34f4c4afac8	createView		\N	3.2.0
ADD-CLIENT-TYPE-AND-GROUP-TYPE-COLUMNS	Angel Montenegro	/db/updates/add-client-type-and-group-type-to-profile-table.xml	2017-01-17 22:39:53.339274	148	EXECUTED	7:4da014c73e25456edf5b0cfb977e5527	addColumn, sql (x419)		\N	3.2.0
MERGE-CrossRef-GROUPS	Angel Montenegro	/db/updates/add-client-type-and-group-type-to-profile-table.xml	2017-01-17 22:39:53.346095	149	EXECUTED	7:301ed44e6df8edfa76517214bf8e81d7	sql		\N	3.2.0
MERGE-Elsevier-GROUPS	Angel Montenegro	/db/updates/add-client-type-and-group-type-to-profile-table.xml	2017-01-17 22:39:53.358046	150	EXECUTED	7:454819d4ef7b0bf565fc6704c31e4322	sql		\N	3.2.0
ADD-CONTRIBUTORS-JSON-COLUMN	Will Simpson	/db/updates/work-contributors-as-json.xml	2017-01-17 22:39:53.360358	151	EXECUTED	7:1022c9252072eecead191b9a888734f5	addColumn		\N	3.2.0
ADD-DEPRECATION-FIELDS-TO-PROFILE	Angel Montenegro	/db/updates/profile_deprecation_project.xml	2017-01-17 22:39:53.36282	152	EXECUTED	7:1df04ff19c2dadd79bf632bd4ba74965	addColumn		\N	3.2.0
ADD-COMMENT-COLUMN-TO-PROFILE-EVENT	Angel Montenegro	/db/updates/profile_deprecation_project.xml	2017-01-17 22:39:53.365475	153	EXECUTED	7:2445e7d0aef730bfc257ed35869adbd4	addColumn		\N	3.2.0
CREATE-EMAIL-EVENT-TABLE	RCPETERS	/db/updates/email_event.xml	2017-01-17 22:39:53.37065	154	EXECUTED	7:3d032c10d468016c8d75cd089b68a2da	createTable, addForeignKeyConstraint		\N	3.2.0
CREATE-EMAIL-EVENT-SEQUENCE	RCPETERS	/db/updates/email_event.xml	2017-01-17 22:39:53.372881	155	EXECUTED	7:8488848d72dce90487d35d86b2be6a2f	createSequence		\N	3.2.0
MARK_EMAILS_TO_SKIP	RCPETERS	/db/updates/email_event.xml	2017-01-17 22:39:53.374374	156	EXECUTED	7:8aa8f0652529170d34b8ebc0d50546d6	sql		\N	3.2.0
WEBHOOKS_PROFILE_MODIFIED	rcpeters	/db/updates/profile_hook_date.xml	2017-01-17 22:39:53.377333	157	EXECUTED	7:9cc42d7d6be8b6e3133b3247862b9c82	sql		\N	3.2.0
ADD-JOURNAL-TITLE-COLUMN-TO-WORK-TABLE	Angel Montenegro	/db/updates/add_journal_title_to_works.xml	2017-01-17 22:39:53.379404	158	EXECUTED	7:a93fef0dc0595e935a2d1bbef40d1c50	addColumn		\N	3.2.0
ADD-FIELDS-TO-WORK-TABLE	Angel Montenegro	/db/updates/add_fields_to_work.xml	2017-01-17 22:39:53.382446	159	EXECUTED	7:4ab5b6be8e61f1df362523a6543a17f2	addColumn		\N	3.2.0
AFF_MIGRATE_RELATIONSHIP	RCPETERS	/db/updates/disambiguated_affiliations_migrate_types.xml	2017-01-17 22:39:53.384295	160	EXECUTED	7:7806de63e997f57209dac481b3a76aa0	sql		\N	3.2.0
UPDATE_WORK_TYPES	Angel Montenegro	/db/updates/update_work_types.xml	2017-01-17 22:39:53.390209	161	EXECUTED	7:90e252bb08cd1ef0839abcc0c89b0018	sql (x15)		\N	3.2.0
CREATE-FUNDING-TABLES	Angel Montenegro	/db/updates/disambiguated_fundings.xml	2017-01-17 22:39:53.407231	162	EXECUTED	7:071195e54cb46ff1d2fc26990cb525eb	createTable (x2), addUniqueConstraint, addForeignKeyConstraint (x3)		\N	3.2.0
CREATE-FUNDING-SEQUENCES	Angel Montenegro	/db/updates/disambiguated_fundings.xml	2017-01-17 22:39:53.491207	163	EXECUTED	7:68fb2026af95a6d079b0b49550d59aff	createSequence (x2)		\N	3.2.0
ADD-FUNDING-UPDATE-SCOPE-TO-EXISTING-CLIENTS	Angel Montenegro	/db/updates/disambiguated_fundings.xml	2017-01-17 22:39:53.493488	164	EXECUTED	7:9e738fbf8e92cb07aa86f2cddffdd27b	sql (x2)		\N	3.2.0
ADD-FUNDING-CREATE-SCOPE-TO-EXISTING-CLIENTS	Angel Montenegro	/db/updates/disambiguated_fundings.xml	2017-01-17 22:39:53.495563	165	EXECUTED	7:8cb7426d89060676be10c472c27dd6af	sql (x2)		\N	3.2.0
ADD-FUNDING-READ-LIMITED-SCOPE-TO-EXISTING-CLIENTS	Angel Montenegro	/db/updates/disambiguated_fundings.xml	2017-01-17 22:39:53.497769	166	EXECUTED	7:3eb6392850b74109c7f8720c53284412	sql (x2)		\N	3.2.0
UPDATE-OAUTH2-SCOPES	Angel Montenegro	/db/updates/disambiguated_fundings.xml	2017-01-17 22:39:53.500044	167	EXECUTED	7:e19c40f0104fe24c941a2048f783469c	sql (x3)		\N	3.2.0
change_creation_method_size	RCPETERS	/db/updates/change_creation_method_size.xml	2017-01-17 22:39:53.502139	168	EXECUTED	7:a47a20f1b1520029a9f62216b2bcb2d7	modifyDataType		\N	3.2.0
change_redirect_uri_type	RCPETERS	/db/updates/fundingImportWizard.xml	2017-01-17 22:39:53.504319	169	EXECUTED	7:9ed2de6b86f8064cfda1d05e55bc7c4f	modifyDataType		\N	3.2.0
change_client_redirect_uri_pkey	rcpeters	/db/updates/fundingImportWizard.xml	2017-01-17 22:39:53.507526	170	EXECUTED	7:b1fe378a44ac49192149513cd7cc13ce	sql		\N	3.2.0
DROP-EXISTING-CONSTRAINT	Angel Montenegro	/db/updates/fundings_modify_external_identifier_constraint.xml	2017-01-17 22:39:53.768802	171	EXECUTED	7:35dbde50dffbde23038854512ef7afcc	dropUniqueConstraint		\N	3.2.0
ADD-CONSTRAINT	Angel Montenegro	/db/updates/fundings_modify_external_identifier_constraint.xml	2017-01-17 22:39:55.155177	172	EXECUTED	7:b8fccfa4305518a2be6d945f2c0d5255	addUniqueConstraint		\N	3.2.0
SET_INDEXING_STATUS_TO_FALSE_ON_ORGS	Angel Montenegro	/db/updates/reindex_orgs_to_add_funding_information.xml	2017-01-17 22:39:55.158078	173	EXECUTED	7:e27e2385019ac84a59b694f0c368f626	sql		\N	3.2.0
REMOVE-NOT-NULL-RESTRICTION-ON-AMOUNT	Angel Montenegro	/db/updates/amount_is_not_required_on_fundings.xml	2017-01-17 22:39:55.161045	174	EXECUTED	7:09fcf4d148e64238bd5589d7ace56dad	dropNotNullConstraint (x2)		\N	3.2.0
reset_funding_contributors	rcpeters	/db/updates/resetFundingContributors.xml	2017-01-17 22:39:55.2153	175	EXECUTED	7:afb800e770aa21e87a5b4bc73c7a2655	sql		\N	3.2.0
CLAIM-ALL-GROUPS	Angel Montenegro	/db/updates/claim_all_groups.xml	2017-01-17 22:39:55.217214	176	EXECUTED	7:0bab412fcf8525ecf258defcdbd57dfb	sql		\N	3.2.0
REFERRED-BY	rcpeters	/db/updates/referred-by.xml	2017-01-17 22:39:55.219735	177	EXECUTED	7:01237a16aec570c0860a4eabdf29d1ce	addColumn		\N	3.2.0
REMOVE-UNUSED-COLUMNS-FROM-AUTHORIZATION-CODE-TABLE	Will Simpson	/db/updates/tidy-authorization-code-table.xml	2017-01-17 22:39:55.222443	178	EXECUTED	7:25d313012304b24e08f9928e225e73fa	dropColumn (x2)		\N	3.2.0
RENAME-TO-ACTIVIES-DEFAULT	rcpeters	/db/updates/activities_default.xml	2017-01-17 22:39:55.224807	179	EXECUTED	7:29e554f08265e45b4d49debee4e25ad7	renameColumn		\N	3.2.0
ADD-ENABLE-DEVELOPER-TOOLS	Angel Montenegro	/db/updates/add_developer_tools_to_profile.xml	2017-01-17 22:39:55.26259	180	EXECUTED	7:905ca4fd870e490291660722c2475902	addColumn		\N	3.2.0
SET-ALL-TO-FALSE	Angel Montenegro	/db/updates/add_developer_tools_to_profile.xml	2017-01-17 22:39:55.264988	181	EXECUTED	7:5663c01f9ba57282f1526c711bffd500	sql		\N	3.2.0
CREATE-ORCID-PROPS-TABLE	Angel Montenegro	/db/updates/orcid_props_table.xml	2017-01-17 22:39:55.32134	182	EXECUTED	7:53220cbd9f9c8abb75a7150e50c45943	createTable		\N	3.2.0
CLAIM-ALL-CLIENTS	Angel Montenegro	/db/updates/claim_all_clients.xml	2017-01-17 22:39:55.323328	183	EXECUTED	7:fcb0a35f3f1493483124e15b091f0a8c	sql		\N	3.2.0
ADD-DESCRIPTION-AND-WEBSITE-TO-CLIENT-DETAILS	Angel Montenegro	/db/updates/db_changes_for_sso.xml	2017-01-17 22:39:55.326039	184	EXECUTED	7:1f363deb96ab9647c942be17f75b3a39	addColumn		\N	3.2.0
COPY-CREDIT-NAME-AND-DESCRIPTION-FROM-PROFILE-TABLE	Angel Montenegro	/db/updates/db_changes_for_sso.xml	2017-01-17 22:39:55.328248	185	EXECUTED	7:3e9b55651e5dc7669eacf156ecf6d287	sql		\N	3.2.0
COPY-RESEARCHER-URL-TO-CLIENT-DETAILS-TABLE	Angel Montenegro	/db/updates/db_changes_for_sso.xml	2017-01-17 22:39:55.33015	186	EXECUTED	7:a56515edbd9e35d3414d4c71ce45f7cf	sql		\N	3.2.0
SET-EMPTY-CLIENT-NAME-AND-DESCRIPTION-TO-UNDEFINED	Angel Montenegro	/db/updates/db_changes_for_sso.xml	2017-01-17 22:39:55.332018	187	EXECUTED	7:65cb0beea4c9c6b0aa3e3aaa735bfb00	sql		\N	3.2.0
SET-EMPTY-WEBSITE-TO-UNDEFINED	Angel Montenegro	/db/updates/db_changes_for_sso.xml	2017-01-17 22:39:55.333805	188	EXECUTED	7:58260b010d59bc359972d391d3a31c8c	sql		\N	3.2.0
MULTI-CLIENT-SECRET	Will Simpson	/db/updates/multi_client_secret.xml	2017-01-17 22:39:55.338634	189	EXECUTED	7:9e49df69f54d91e6b607e1e43602048c	createTable, sql, addForeignKeyConstraint		\N	3.2.0
SET-ALL-GROUP-EMAILS-TO-VERIFIED	Angel Montenegro	/db/updates/verify_all_group_emails.xml	2017-01-17 22:39:55.340414	190	EXECUTED	7:b4f07b820227b8079862d3afe4a23753	sql		\N	3.2.0
DROP_WORK_CONTRIBUTOR_2	RCPeters	/db/updates/drop_work_contributors_2.xml	2017-01-17 22:39:55.349157	191	MARK_RAN	7:9dcb4358dbc0e09a6965753f18f22b8c	dropTable, dropSequence		\N	3.2.0
CREATE-FUNDING-SUBTYPES-TO-INDEX-TABLE	Angel Montenegro	/db/updates/funding_sub_type_to_index_table.xml	2017-01-17 22:39:55.359428	192	EXECUTED	7:90499e627a23c0abf494273b5c0e22e7	createTable, addForeignKeyConstraint		\N	3.2.0
ADD-ORGANIZATION-DEFINED-TYPE-COLUMN	Angel Montenegro	/db/updates/add_organization_defined_type_to_funding.xml	2017-01-17 22:39:55.364791	193	EXECUTED	7:3907a0a006b66918dbf44843ec775e31	addColumn		\N	3.2.0
CREATE-CUSTOM-EMAILS-TABLE	Angel Montenegro	/db/updates/create_custom_emails_table.xml	2017-01-17 22:39:55.375789	194	EXECUTED	7:74cb05e108711808c4a344ad0a22351f	createTable, addForeignKeyConstraint		\N	3.2.0
ADD-NUMERIC-AMOUNT-TO-FUNDING	Angel Montenegro	/db/updates/add_numeric_amount_to_funding.xml	2017-01-17 22:39:55.378021	195	EXECUTED	7:1cfdc3eaf6f83ccdfad73fd30163ea2e	addColumn		\N	3.2.0
ADD-WORK-EXTERNAL-IDS-JSON-COLUMN	Will Simpson	/db/updates/work-external-ids-as-json.xml	2017-01-17 22:39:55.461873	196	EXECUTED	7:e1cba068309ff6ae561ad4a46f9209dc	addColumn		\N	3.2.0
CONVERT-TEXT-TO-JSON	Will Simpson	/db/updates/work-external-ids-as-json.xml	2017-01-17 22:39:57.191246	197	EXECUTED	7:59d7f7aeb42e754db84a5c2dd7044cdb	sql (x2), createProcedure (x2), createIndex		\N	3.2.0
ADD-PRIMARY-INDICATOR-TO-CLIENT-SECRET	Angel Montenegro	/db/updates/add_primary_indicator_to_client_secret.xml	2017-01-17 22:39:57.228059	198	EXECUTED	7:01707b2de872ab51f379cf3b2bbe6e87	addColumn		\N	3.2.0
WORK-ADD-DISPLAY-INDEX	rcpeters	/db/updates/work_display_index.xml	2017-01-17 22:39:57.237237	199	EXECUTED	7:6e9a2d900e39c0225d57adb3a6fc0237	addColumn		\N	3.2.0
CREATE-NOTIFICATIONS-TABLE	Will Simpson	/db/updates/notifications.xml	2017-01-17 22:39:57.307678	200	EXECUTED	7:deea322c197fc4a030f90fdaa29e7b9c	createTable, addForeignKeyConstraint (x2)		\N	3.2.0
ADD-SEQUENCE-FOR-NOTIFICATIONS	Will Simpson	/db/updates/notifications.xml	2017-01-17 22:39:57.327186	201	EXECUTED	7:04cf8a5c18ee3b437a813e9f1e1bbdcd	createSequence		\N	3.2.0
ADD-NOTIFICATION-FREQUENCY-TO-PROFILE-TABLE	Will Simpson	/db/updates/notifications.xml	2017-01-17 22:39:57.415706	202	EXECUTED	7:29b4ccf66810cfff696f15a08b6f812c	addColumn		\N	3.2.0
ADD-OPTION-TO-ENABLE-NOTIFICATIONS-PER-USER	Will Simpson	/db/updates/notifications.xml	2017-01-17 22:39:57.424229	203	EXECUTED	7:699219f46a19f2a9a3fb963887e714d8	addColumn		\N	3.2.0
ADD-OPTION-FOR-ORCID-FEATURE-ANNOUNCEMENTS	Will Simpson	/db/updates/notifications.xml	2017-01-17 22:39:57.42655	204	EXECUTED	7:cb3a5ab3405714be5845f994d408562e	addColumn		\N	3.2.0
ADD-ACTIVITIES-NOTIFICATION	Will Simpson	/db/updates/notifications.xml	2017-01-17 22:39:57.433495	205	EXECUTED	7:ba6dfb6f8e8dc4fb43a189d25b9084eb	createTable, addForeignKeyConstraint, addColumn, dropNotNullConstraint (x3)		\N	3.2.0
REMOVE-NOT-NULL-FROM-NOTIFICATION-ID-IN-NOTIFICATION-ACTIVITIES	Will Simpson	/db/updates/notifications.xml	2017-01-17 22:39:57.435643	206	EXECUTED	7:264b63e2538c24550ba305d41d388176	dropNotNullConstraint		\N	3.2.0
ADD-SEQUENCE-FOR-NOTIFICATION-ACTIVITIES	Will Simpson	/db/updates/notifications.xml	2017-01-17 22:39:57.45521	207	EXECUTED	7:0638ee5b4f60ddc47c636d6a80351b67	createSequence		\N	3.2.0
ADD-PREFERENCE-FOR-MEMBER-UPDATE-REQUESTS	Will Simpson	/db/updates/notifications.xml	2017-01-17 22:39:57.457364	208	EXECUTED	7:583219967e46c167cbe633dafc9057a6	addColumn		\N	3.2.0
UPDATE-NOTIFICATION-ACTIVITY-TYPE	Will Simpson	/db/updates/notifications.xml	2017-01-17 22:39:57.458915	209	EXECUTED	7:afbd558b3d91bbb68d11bec498aa9c0d	sql		\N	3.2.0
ADD-LANG-TO-NOTIFICATION	Will Simpson	/db/updates/notifications.xml	2017-01-17 22:39:57.511945	210	EXECUTED	7:520f2874cbf925faedc95b28ce1c4b96	addColumn		\N	3.2.0
SET-SEQUENCES-START	Will Simpson	/db/updates/set_sequences_start.xml	2017-01-17 22:39:57.518475	211	EXECUTED	7:30f947be35bed7d168e3b7308673e4e4	createProcedure, sql		\N	3.2.0
CREATE-ORCID-SOCIAL-TABLE	Angel Montenegro	/db/updates/create_orcid_social_table.xml	2017-01-17 22:39:57.528712	212	EXECUTED	7:054c055c25ad8b7775aacfe371207a96	createTable, addForeignKeyConstraint		\N	3.2.0
WORK-CONTRIBUTORS-TIDY-UP	Will Simpson	/db/updates/work-contributors-tidy-up.xml	2017-01-17 22:39:57.642049	213	EXECUTED	7:990287f26a4574630bc119bdbf5c3f08	dropForeignKeyConstraint		\N	3.2.0
ADD-ORCID-INDEX-FOR-AFFILIATIONS	Will Simpson	/db/updates/add-orcid-index-for-affiliations.xml	2017-01-17 22:39:59.170004	214	EXECUTED	7:337c1bbae22e98d121abe7dafd4199ac	createIndex		\N	3.2.0
ADD-SALESFORCE-ID-TO-PROFILE-TABLE	Angel Montenegro	/db/updates/add-salesforce-id-to-profile.xml	2017-01-17 22:39:59.204593	215	EXECUTED	7:71a99f2482b2a021365644e7c9751312	addColumn		\N	3.2.0
EXTERNAL-IDENTIFIERS_SOURCE	Will Simpson	/db/updates/external-identifiers-source.xml	2017-01-17 22:39:59.208232	216	EXECUTED	7:d58ee27ae23d3f42a09f78b02f03874d	dropForeignKeyConstraint, renameColumn, addForeignKeyConstraint		\N	3.2.0
FUNDING-ADD-DISPLAY-INDEX	rcpeters	/db/updates/funding_display_index.xml	2017-01-17 22:39:59.26715	217	EXECUTED	7:4d7b79bb98e8ffe7e320b5807bf5f52e	addColumn		\N	3.2.0
FUNDING-ADD-DISPLAY-INDEX-PATCH	rcpeters	/db/updates/funding_display_index_patch.xml	2017-01-17 22:39:59.269137	218	EXECUTED	7:ed0d747239710a6eb510decdbdbecaec	sql		\N	3.2.0
ADD-PERSISTENT-FLAG-TO-OAUTH2-AUTHORIZATION-CODE-DETAIL-TABLE	Angel Montenegro	/db/updates/persistent_tokens.xml	2017-01-17 22:39:59.305642	219	EXECUTED	7:32b73d643f06dd3b74d1808e2b501143	addColumn		\N	3.2.0
ADD-VERSION-FLAG-TO-OAUTH2-AUTHORIZATION-CODE-DETAIL-TABLE	Angel Montenegro	/db/updates/persistent_tokens.xml	2017-01-17 22:39:59.372896	220	EXECUTED	7:e66148a7828e3499f8104bf54933b82a	addColumn		\N	3.2.0
ADD-PERSISTENT-FLAG-TO-OAUTH2-TOKEN-DETAIL-TABLE	Angel Montenegro	/db/updates/persistent_tokens.xml	2017-01-17 22:39:59.414736	221	EXECUTED	7:37f7257d9240c5adf05c2d8c1b5786a5	addColumn		\N	3.2.0
ADD-VERSION-FLAG-TO-OAUTH2-TOKEN-DETAIL-TABLE	Angel Montenegro	/db/updates/persistent_tokens.xml	2017-01-17 22:39:59.483266	222	EXECUTED	7:35ee373bed6439566464f264765f9e1f	addColumn		\N	3.2.0
ADD-PERSISTENT-TOKEN-ENABLE-FLAG-TO-CLIENT-DETAILS-TABLE	Angel Montenegro	/db/updates/persistent_tokens.xml	2017-01-17 22:39:59.520587	223	EXECUTED	7:bc55ce0569035162293e16a756ed84a1	addColumn		\N	3.2.0
ADD-GROUP-ORCID-COLUMN-TO-CLIENT-DETAILS	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2017-01-17 22:39:59.571857	224	EXECUTED	7:3d82c821a6d8d6052b3611f6606b13fe	addColumn, sql, addForeignKeyConstraint		\N	3.2.0
ADD-CLIENT-TYPE-TO-CLIENT-DETAILS	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2017-01-17 22:39:59.575429	225	EXECUTED	7:36ca1cfe2c93eb1d32b96e986d0f408e	addColumn, sql		\N	3.2.0
MAKE-CLIENT-ID-COLUMN-BIGGER-IN-TOKEN-TABLE	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2017-01-17 22:39:59.579122	226	EXECUTED	7:d408f5400d82d6d3164854fbf7f8c15a	modifyDataType		\N	3.2.0
ADD-CLIENT-SOURCE-ID	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2017-01-17 22:39:59.586528	227	EXECUTED	7:d4bcd8453dd27f5af6c872222cb58d78	addColumn (x8)		\N	3.2.0
POPULATE-CLIENT-SOURCE-ID	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2017-01-17 22:39:59.59523	228	EXECUTED	7:f35a0780efa903c1ac33b69e7a0f8972	sql (x8)		\N	3.2.0
CORRECT-SOURCE-ID-FOR-PUBLIC-CLIENT-OWNERS-AGAIN	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2017-01-17 22:39:59.601249	229	EXECUTED	7:e728a98b054c6e2960308263c5690213	sql (x8)		\N	3.2.0
ADD-FOREIGN-KEYS-FOR-CLIENT-SOURCE-ID	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2017-01-17 22:39:59.61132	230	EXECUTED	7:d5bfa3aebf641fae4f4e35296973a185	addForeignKeyConstraint (x8)		\N	3.2.0
INCREASE-SIZE-OF-REFERRED-BY	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2017-01-17 22:39:59.61395	231	EXECUTED	7:9209290446f36a15892d1780e08683c5	modifyDataType		\N	3.2.0
REMOVE-OLD-NOTIFICATION-SCOPE	Will Simpson	/db/updates/notifications_part2.xml	2017-01-17 22:39:59.616219	232	EXECUTED	7:13b1b019fe668f0deb7b707b148aa74f	sql		\N	3.2.0
UPDATE-TOKENS-WITH-OLD-NOTIFICATION-SCOPE	Will Simpson	/db/updates/notifications_part2.xml	2017-01-17 22:39:59.6182	233	EXECUTED	7:ee58f6fb7322aba6818f3e8076ea8d8e	sql		\N	3.2.0
INSERT-NOTIFICATION-SCOPE-2	Will Simpson	/db/updates/notifications_part2.xml	2017-01-17 22:39:59.671752	234	EXECUTED	7:852d4a5ae0b9304faf3f64b2465d3117	createProcedure, sql		\N	3.2.0
UPDATE-NOTIFICATION-TYPE	Will Simpson	/db/updates/notifications_part2.xml	2017-01-17 22:39:59.673875	235	EXECUTED	7:0fdc3e4a48feef0d0e053b12da3d430a	sql		\N	3.2.0
ADD-AMENDED-SECTION-TO-NOTIFICATION	Will Simpson	/db/updates/notifications_part2.xml	2017-01-17 22:39:59.676425	236	EXECUTED	7:5cfe19eb4f684f618ad7ff4125d93692	addColumn		\N	3.2.0
RENAME-COLUMN-ON-ORCID-PROPS	Angel Montenegro	/db/updates/change_column_name_on_orcid_props_table.xml	2017-01-17 22:39:59.713726	237	EXECUTED	7:aa0fd25d4faac9256671439b2ca2a3b4	renameColumn		\N	3.2.0
MODIFY-ENABLE-DEVELOPER-TOOLS-DATA-TYPE	Angel Montenegro	/db/updates/modify_enable_developer_tools_data_type.xml	2017-01-17 22:39:59.802542	238	EXECUTED	7:cafdbcd6ee96a230231e38a81c698414	addColumn		\N	3.2.0
SET-ENABLED-DATE-FOR-USERS-WITH-DEVELOPER-TOOLS	Angel Montenegro	/db/updates/modify_enable_developer_tools_data_type.xml	2017-01-17 22:39:59.805513	239	EXECUTED	7:1c9ace2e59d01e075e3e27b1a027e2a1	sql		\N	3.2.0
EXTERNAL-IDENTIFIERS-JSON-COLUMN	Angel Montenegro	/db/updates/funding-external-identifiers-as-json.xml	2017-01-17 22:39:59.808445	240	EXECUTED	7:a996c9c6041dc061684f144a252d75b6	addColumn		\N	3.2.0
CHANGE-EXTERNAL-IDENTIFIER-PRIMARY-KEY	Angel Montenegro	/db/updates/change_external_identifier_primary_key.xml	2017-01-17 22:39:59.827897	241	EXECUTED	7:6d0dc34d43d302e793da5c5c5d71a578	dropPrimaryKey, addColumn, addUniqueConstraint		\N	3.2.0
resize_external_id_url	Angel Montenegro	/db/updates/resize_external_id_url.xml	2017-01-17 22:39:59.881799	242	EXECUTED	7:bc5039ccdde5c2b904156c923932c5be	modifyDataType		\N	3.2.0
MIGRATE-WOSUID	Will Simpson	/db/updates/migrate-wosuid.xml	2017-01-17 22:39:59.883883	243	EXECUTED	7:276858d7eafe094ad3512eb576f88b1b	sql		\N	3.2.0
ADD-TYPE-TO-PUBLIC-CLIENT	Angel Montenegro	/db/updates/add_type_to_public_client.xml	2017-01-17 22:39:59.885569	244	EXECUTED	7:96c36c578d7f975785919b4916c3753a	sql		\N	3.2.0
RECORD-LOCKED	Angel Montenegro	/db/updates/record-locked.xml	2017-01-17 22:39:59.927434	245	EXECUTED	7:1be4d53d54d00d012ef1e9c8641dd2d5	addColumn		\N	3.2.0
SET-DISPLAY-INDEX-TO-0	Angel Montenegro	/db/updates/fix_profile_work_display_index.xml	2017-01-17 22:39:59.930585	246	EXECUTED	7:4de3c5403e277528c0d4e88f015fd23e	sql (x2)		\N	3.2.0
CREATE-PEER-REVIEW-TABLE	Angel Montenegro	/db/updates/peer-review.xml	2017-01-17 22:39:59.999169	247	EXECUTED	7:09ba7e2765f264c8012575239a89a952	createTable (x2), addForeignKeyConstraint (x3)		\N	3.2.0
CREATE-PEER-REVIEW-SEQUENCES	Angel Montenegro	/db/updates/peer-review.xml	2017-01-17 22:40:00.037588	248	EXECUTED	7:31ce26383181e84b5153cca54449af21	createSequence (x2)		\N	3.2.0
REMOVE-AMOUNT-FIELD-FROM-PROFILE-FUNDING-TABLE	Angel Montenegro	/db/updates/remove_amount_field.xml	2017-01-17 22:40:00.044301	249	EXECUTED	7:06e13b5b2064bfa3fc90c949a83f7bbc	dropColumn		\N	3.2.0
DEL-BLANK-OTHER-NAMES	rcpeters	/db/updates/fix_blank_other_names.xml	2017-01-17 22:40:00.046014	250	EXECUTED	7:aad571d3ab9d8c575c19868e665653cb	sql		\N	3.2.0
CREATE-SHIBBOLETH-ACCOUNT-TABLE	Will Simpson	/db/updates/shibboleth.xml	2017-01-17 22:40:00.097618	251	EXECUTED	7:87e2af6e6c82774ec6594b116d25e883	createTable, addForeignKeyConstraint, addUniqueConstraint		\N	3.2.0
ADD-SEQUENCE-FOR-SHIBBOLETH-ACCOUNT	Will Simpson	/db/updates/shibboleth.xml	2017-01-17 22:40:00.119382	252	EXECUTED	7:52bbfb0e6a655f729ad6eac38163b657	createSequence		\N	3.2.0
SET-DEFAULT-VALUE-ON-VISIBILITY-FIELDS	amontenegro	/db/updates/set_empty_visibility_fields_to_private.xml	2017-01-17 22:40:00.124959	253	EXECUTED	7:2244f3b40bc7c67855a5e7574e2318a4	addDefaultValue (x7)		\N	3.2.0
SET-NULL-TO-PRIVATE	amontenegro	/db/updates/set_empty_visibility_fields_to_private.xml	2017-01-17 22:40:00.130157	254	EXECUTED	7:aabf1fb6acdcbf462aeb02eb7d9a91a5	sql (x7)		\N	3.2.0
DROP-AUTHENTICATION-KEY-UNIQUE-CONSTRAINT	Angel Montenegro	/db/updates/drop_oauth2_authentication_key_unique_constraint.xml	2017-01-17 22:40:00.132475	255	EXECUTED	7:cc8ba78e0bc7fb6869627642975e2b71	dropUniqueConstraint		\N	3.2.0
ADD-FIELDS-TO-WORK	Angel Montenegro	/db/updates/move-work-data-to-work-table.xml	2017-01-17 22:40:00.202476	256	EXECUTED	7:3fc2179af2362f9733bbaffa0fbb58f4	addColumn, addForeignKeyConstraint (x3)		\N	3.2.0
ADD-UTILITY-FIELD-TO-PROFILE-WORK	Angel Montenegro	/db/updates/move-work-data-to-work-table.xml	2017-01-17 22:40:00.236848	257	EXECUTED	7:2dd29a2be25117952f400008e25f2d31	addColumn		\N	3.2.0
ORCID-IDX-ON-WORK	Angel Montenegro	/db/updates/move-work-data-to-work-table.xml	2017-01-17 22:40:01.797933	258	EXECUTED	7:117243dae31de975a716be08889f51aa	createIndex		\N	3.2.0
ORG-DISAMBIGUATED-SOURCE-ID-IDX	Angel Montenegro	/db/updates/new-index-for-org-disambiguated-table.xml	2017-01-17 22:40:03.351272	259	EXECUTED	7:60b1401bf8d392423329f58e95c360fa	createIndex		\N	3.2.0
ORG-DISAMBIGUATED-SOURCE-TYPE-IDX	Angel Montenegro	/db/updates/new-index-for-org-disambiguated-table.xml	2017-01-17 22:40:04.874887	260	EXECUTED	7:32b5355973907c0b6be5b1a0bcb95436	createIndex		\N	3.2.0
FUNDING-CONVERT-TEXT-TO-JSON	Angel Montenegro	/db/updates/external-ids-as-json.xml	2017-01-17 22:40:04.938811	261	EXECUTED	7:4c399f9d9b5bcaf7c6628cfdd7657a79	sql (x2)		\N	3.2.0
PEER-REVIEW-CONVERT-TEXT-TO-JSON	Angel Montenegro	/db/updates/external-ids-as-json.xml	2017-01-17 22:40:04.947376	262	EXECUTED	7:51d81bd5a73e01e2338d3634f08c8313	sql (x2)		\N	3.2.0
REMOVE-WORK-ID-FK-FROM-PROFILE-WORK	Angel Montenegro	/db/updates/remove-work-id-fk-on-profile-work.xml	2017-01-17 22:40:05.065725	263	EXECUTED	7:b8b51e81098341011548b118fd61b44c	dropForeignKeyConstraint		\N	3.2.0
CREATE-GROUP-ID-RECORD-TABLE	Shobhit Tyagi	/db/updates/group-id-record.xml	2017-01-17 22:40:05.07483	264	EXECUTED	7:2b99e56f6631a518dfcb67ceefe90a31	createTable		\N	3.2.0
CREATE-GROUP-ID-RECORD-SEQUENCES	Shobhit Tyagi	/db/updates/group-id-record.xml	2017-01-17 22:40:05.148653	265	EXECUTED	7:e64b50c341e0cfa57d7157316c09211c	createSequence		\N	3.2.0
UPDATE-FIELDS-SIZE	Shobhit Tyagi	/db/updates/group-id-record.xml	2017-01-17 22:40:05.151393	266	EXECUTED	7:0cd48589adb4f35a326f46a0c2bdf97a	sql (x3)		\N	3.2.0
MOVE-ALL-PEER-REVIEW-INFO-TO-PEER-REVIEW-TABLE	Angel Montenegro	/db/updates/move-all-peer-review-info-to-peer-review-table.xml	2017-01-17 22:40:05.189897	267	EXECUTED	7:fcaacf0cf38e9fa64447d54dd77ea935	addColumn		\N	3.2.0
REMOVE-PEER-REVIEW-SUBJECT-FK	Angel Montenegro	/db/updates/move-all-peer-review-info-to-peer-review-table.xml	2017-01-17 22:40:05.344613	268	EXECUTED	7:1debe3d95288b0a5c4c50e3b71752270	dropForeignKeyConstraint, dropNotNullConstraint		\N	3.2.0
SUBJECT-EXTERNAL-IDS-AS-JSON	Angel Montenegro	/db/updates/move-all-peer-review-info-to-peer-review-table.xml	2017-01-17 22:40:06.623917	269	MARK_RAN	7:54579d3abea4cbaa3763e8f037bcfcaf	sql		\N	3.2.0
ADD-ACTTYPE-GEOAREA-COLUMN	Shobhit Tyagi	/db/updates/add_redir_acttype_geoarea.xml	2017-01-17 22:40:06.735475	270	EXECUTED	7:36bbbe9bf8ad501f6441326e04e14b62	addColumn		\N	3.2.0
REDIRECT-URI-CONVERT-TEXT-TO-JSON	Shobhit Tyagi	/db/updates/add_redir_acttype_geoarea.xml	2017-01-17 22:40:06.743312	271	EXECUTED	7:6edc7b00cd6fb3f7ed26d44183d6609a	sql (x2)		\N	3.2.0
REDIRECT-URI-DEFAULT-VALUE	Shobhit Tyagi	/db/updates/add_redir_acttype_geoarea.xml	2017-01-17 22:40:06.745474	272	EXECUTED	7:6dbe6fec823112bf85941b41fe193472	sql (x2)		\N	3.2.0
REDIRECT-URI-DEFAULT-VALUE-TO-EXISTING	Shobhit Tyagi	/db/updates/add_redir_acttype_geoarea.xml	2017-01-17 22:40:06.74708	273	EXECUTED	7:31cd37f058d3d446cae9b91ef7e28676	sql (x2)		\N	3.2.0
ADD-CAPTCHA-FIELD-TO-PROFILE-TABLE	Angel Montenegro	/db/updates/add_captcha_field_to_profile.xml	2017-01-17 22:40:06.783031	274	EXECUTED	7:a097c0004a59aa53b1ad11ddef45a0e8	addColumn		\N	3.2.0
SET-ALL-EXISTING-TO-FALSE	Angel Montenegro	/db/updates/add_captcha_field_to_profile.xml	2017-01-17 22:40:06.785763	275	EXECUTED	7:0276442c3bdbba2cec47019a9dab39ad	sql		\N	3.2.0
REMOVE-PROFILE-WORK-TABLE	Angel Montenegro	/db/updates/remove_profile_work_table.xml	2017-01-17 22:40:06.791461	276	EXECUTED	7:4b8311df886d4d5bd47eede3dd77cf62	dropTable		\N	3.2.0
ADD-INDEX-ON-TRANSLATED-TITLE-LANGUAGE-CODE	Angel Montenegro	/db/updates/add_index_on_language_codes_in_activities.xml	2017-01-17 22:40:08.421595	277	EXECUTED	7:237037700280d1be2fd8d39e013c0f3c	createIndex		\N	3.2.0
ADD-INDEX-ON-LANGUAGE-CODE	Angel Montenegro	/db/updates/add_index_on_language_codes_in_activities.xml	2017-01-17 22:40:10.104349	278	EXECUTED	7:8afc2ad256d0170673cc65df6fda9c16	createIndex		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_1	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2017-01-17 22:40:10.107079	279	EXECUTED	7:0bbc5fec92c0b2eeede930c4f494abf7	sql (x3)		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_2	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2017-01-17 22:40:10.10963	280	EXECUTED	7:fcc8453b97bcba88fe1e05f65887064c	sql (x4)		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_3	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2017-01-17 22:40:10.111516	281	EXECUTED	7:1770f3e81eed6da29659de556abd85a0	sql (x3)		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_4	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2017-01-17 22:40:10.113514	282	EXECUTED	7:dd8c3d42c9a6e191d9e3f8e432c9cd6e	sql (x3)		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_5	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2017-01-17 22:40:10.115486	283	EXECUTED	7:8da3e728ed93ba1543704444e6e52eb7	sql (x3)		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_6	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2017-01-17 22:40:10.117353	284	EXECUTED	7:0f85b430da3fbc5610f04438dbfceb02	sql (x3)		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_7	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2017-01-17 22:40:10.119139	285	EXECUTED	7:4fc78a63d0d55029d8e0a680c156c6bf	sql (x3)		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_8	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2017-01-17 22:40:10.172031	286	EXECUTED	7:ac616e67f9b475b53d29959e02e2d4ed	sql		\N	3.2.0
CREATE-USERCONNECTION-TABLE	Shobhit Tyagi	/db/updates/user_connection.xml	2017-01-17 22:40:10.183559	287	EXECUTED	7:c74878fabd1588b236db811738717ee4	createTable, addPrimaryKey, createIndex		\N	3.2.0
REMOVE-TABLE-NOTIFICATION-ACTIVITY-TO-NOTIFICATION-ITEM	Angel Montenegro	/db/updates/rename_activities_tables_and_fields.xml	2017-01-17 22:40:10.187301	288	EXECUTED	7:5d07cc989ef39c57b8ba5f18e0e8757e	renameTable		\N	3.2.0
RENAME-TYPE-FIELD-ON-NOTIFICATION-ITEM-TABLE	Angel Montenegro	/db/updates/rename_activities_tables_and_fields.xml	2017-01-17 22:40:10.192907	289	EXECUTED	7:b5e2cb1db0291ef95354a79b3a865914	renameColumn		\N	3.2.0
RENAME-NAME-FIELD-ON-NOTIFICATION-ITEM-TABLE	Angel Montenegro	/db/updates/rename_activities_tables_and_fields.xml	2017-01-17 22:40:10.198695	290	EXECUTED	7:c88efb9a557825a35a9c26ca3baca1ed	renameColumn		\N	3.2.0
RENAME-SEQUENCE	Angel Montenegro	/db/updates/rename_activities_tables_and_fields.xml	2017-01-17 22:40:10.270875	291	EXECUTED	7:1d2861432300909fda64f0fbe6b43d8b	createSequence		\N	3.2.0
ADD-ACTIONED-DATE	Angel Montenegro	/db/updates/add_fields_on_notifications_item_table.xml	2017-01-17 22:40:10.307932	292	EXECUTED	7:d6a83ad7862590f33a5c9b3ef409c8fc	addColumn		\N	3.2.0
ADD-NOTIFICATION-SUBJECT	Angel Montenegro	/db/updates/add_fields_on_notifications_item_table.xml	2017-01-17 22:40:10.34047	293	EXECUTED	7:764ddf5ffab869810a82e72fa3550e7c	addColumn		\N	3.2.0
ADD-NOTIFICATION-INTRO	Angel Montenegro	/db/updates/add_fields_on_notifications_item_table.xml	2017-01-17 22:40:10.391082	294	EXECUTED	7:a28a6801d3fc771d2007215c26fbe975	addColumn		\N	3.2.0
ADD-NOTIFICATION-WORK	Will Simposn	/db/updates/notifications_part3.xml	2017-01-17 22:40:10.396202	295	EXECUTED	7:21724639f5286a554614175abeb113fb	createTable, addPrimaryKey, addForeignKeyConstraint (x2)		\N	3.2.0
UPDATE-NOTIFICATION-TYPE	Will Simpson	/db/updates/notifications_part3.xml	2017-01-17 22:40:10.397864	296	EXECUTED	7:60e8dc1bc3a34c11562eed4dfb69a9f0	sql		\N	3.2.0
CREATE-INTERNAL-SSO-TABLE	Angel Montenegro	/db/updates/orcid_internal_sso.xml	2017-01-17 22:40:10.405922	297	EXECUTED	7:20d2bdc2a7768aab5ca4dd08850cebb9	createTable		\N	3.2.0
ADD-INDEX-TO-SSO-TABLE	Angel Montenegro	/db/updates/orcid_internal_sso.xml	2017-01-17 22:40:12.140381	298	EXECUTED	7:d3f0e115200d723bf8b47853005eebb9	createIndex		\N	3.2.0
ADD-USER_LAST_IP-COL-TO-PROFILE	Shobhit Tyagi	/db/updates/add_column_ip_to_profile.xml	2017-01-17 22:40:12.171788	299	EXECUTED	7:60d72dd457020df5c3f5e52958bcad2d	addColumn		\N	3.2.0
UPDATE-IP-COLUMN-LENGTH	Shobhit Tyagi	/db/updates/alter_column_last_ip.xml	2017-01-17 22:40:12.173768	300	EXECUTED	7:e87fdc989c87292e790349e415dc19f8	sql		\N	3.2.0
ADD-REVIEWED-COL-TO-PROFILE	Shobhit Tyagi	/db/updates/add_column_reviewed_to_profile.xml	2017-01-17 22:40:12.260767	301	EXECUTED	7:55e1ad8472108b03b93e43db101afd94	addColumn		\N	3.2.0
FIX-NOTIFICATION-ITEM-SEQUENCE	Will Simpson	/db/updates/fix-notification-item-sequence.xml	2017-01-17 22:40:12.283546	302	EXECUTED	7:39ee8b74ed118a301349c6e4c8de98d3	dropSequence, sql		\N	3.2.0
ADD-FIELDS-TO-RESEARCHER-URL	Angel Montenegro	/db/updates/add_source_to_researcher_url.xml	2017-01-17 22:40:12.339513	303	EXECUTED	7:2e2ca264d58ce9d4170cb7928686ca40	addColumn, addForeignKeyConstraint (x2)		\N	3.2.0
CHANGE-UNIQUE-CONSTRAINTS-ON-RESEARCHER-URL	Angel Montenegro	/db/updates/change_unique_constraints_on_researcher_url.xml	2017-01-17 22:40:12.34536	304	EXECUTED	7:5c98f53e596f01df903511780103ac8b	sql (x3)		\N	3.2.0
DROP-LEGACY-WORK-EXTERNAL-IDENTIFIERS-TABLE	Will Simpson	/db/updates/drop_legacy_work_external_identifiers_table.xml	2017-01-17 22:40:12.351228	305	MARK_RAN	7:92b4d49478749f91d8b7f17f7af131d6	dropTable		\N	3.2.0
DELETE-NOTIFICATION-WORK-ENTRIES	Angel Montenegro	/db/updates/delete_notification_work_entries.xml	2017-01-17 22:40:12.352604	306	EXECUTED	7:fd5ff812139584eef3c22b4ffaa9e4c4	sql		\N	3.2.0
ADD-ADMINISTRATIVE-CHANGES-OPTION-COLUMN	Will Simpson	/db/updates/add_administrative_changes_option.xml	2017-01-17 22:40:12.384577	307	EXECUTED	7:ee8b84eb13f9564f19f07af088e57fb2	addColumn		\N	3.2.0
CUSTOM-POPULATE-ADMINISTRATIVE-CHANGES-OPTION-COLUMN	Will Simposn	/db/updates/add_administrative_changes_option.xml	2017-01-17 22:40:12.444447	308	EXECUTED	7:e380540a2934a68d4fb6fd1f791622fe	customChange		\N	3.2.0
NULLIFY-EMPTY-TRANSLATED-TITLES	Angel Montenegro	/db/updates/nullify_empty_translated_titles.xml	2017-01-17 22:40:12.449529	309	EXECUTED	7:682b62797bcee28f563ee081fb494226	sql (x5)		\N	3.2.0
ADD-FIELDS-TO-OTHER-NAMES	Shobhit Tyagi	/db/updates/add_source_to_other_names.xml	2017-01-17 22:40:12.455404	310	EXECUTED	7:b7bcc98f4b0ea6b2e3993f9f0420f9af	sql (x5)		\N	3.2.0
UPDATE_EXISTING-DATA-OTHER-NAMES	Shobhit Tyagi	/db/updates/add_source_to_other_names.xml	2017-01-17 22:40:12.458591	311	EXECUTED	7:12e9748937fe09158a50bb24c9b46a39	sql (x2)		\N	3.2.0
RENAME-CREDIT-NAME-VISIBILITY-FIELD-ON-PROFILE-TABLE_PSQL	Angel Montenegro	/db/updates/rename_credit_name_visibility_to_names_visibility.xml	2017-01-17 22:40:12.557177	312	EXECUTED	7:e2287d7cf3c6fc4ba6292dc5b124421b	sql		\N	3.2.0
ADD-READ-LIMITED	rcpeters	/db/updates/add_read_limited.xml	2017-01-17 22:40:12.558516	313	EXECUTED	7:a1e8bb7f88672e782fcc53cc485a56b9	sql		\N	3.2.0
ADD-PARENT-SOURCE-ID-TO-ORG-DISAMBIGUATED	Will Simpson	/db/updates/add_parent_id_to_org_disambiguated.xml	2017-01-17 22:40:12.589687	314	EXECUTED	7:eb741c07d9814c8f79e9f7d4a1b03aa1	addColumn		\N	3.2.0
ORG-DISAMBIGUATED-SOURCE-PARENT-ID-IDX	Will Simpson	/db/updates/add_parent_id_to_org_disambiguated.xml	2017-01-17 22:40:14.234134	315	EXECUTED	7:07e5c18d07c43f86fb847d9300e1660b	createIndex		\N	3.2.0
ORG-DISAMBIGUATED-DESCENDENT-TYPE	Will Simpson	/db/updates/add_parent_id_to_org_disambiguated.xml	2017-01-17 22:40:14.239281	316	EXECUTED	7:b900ab4c49ae933c1dd2b7c591799475	sql		\N	3.2.0
ORG-DISAMBIGUATED-DESCENDENT-FUNCTIONS	Will Simpson	/db/updates/add_parent_id_to_org_disambiguated.xml	2017-01-17 22:40:14.242037	317	EXECUTED	7:fd4a3f541efe04e68546af6365819b60	createProcedure		\N	3.2.0
ADD-VISIBILITY-TO-EXTERNAL-IDENTIFIERS	Angel Montenegro	/db/updates/add_visibility_to_external_identifiers.xml	2017-01-17 22:40:14.276454	318	EXECUTED	7:6463b019da7483601d44b01ea8b2de17	sql		\N	3.2.0
SET-EXTERNAL-IDENTIFIERS-VISIBILITY	Angel Montenegro	/db/updates/add_visibility_to_external_identifiers.xml	2017-01-17 22:40:14.279146	319	EXECUTED	7:0399fc7f93183f277e3af6349178ba0c	sql		\N	3.2.0
SET-NAMES-VISIBILITY-TO-PUBLIC-WHEN-CREDIT-NAME-IS-EMPTY	Angel Montenegro	/db/updates/set_names_visibility_to_public_on_empty_credit_names.xml	2017-01-17 22:40:14.280801	320	EXECUTED	7:0e2a02d842ea9e7f21c877964c204d75	sql		\N	3.2.0
ENABLE-PERSISTENT-TOKENS-ON-PUBLIC-CLIENT	Angel Montenegro	/db/updates/enable_persistent_tokens_on_public_clients.xml	2017-01-17 22:40:14.282316	321	EXECUTED	7:5503e6931b90cfe4c9065998ccdbb699	sql		\N	3.2.0
ADD-FIELDS-TO-KEYWORDS	Angel Montenegro	/db/updates/add_id_visibility_and_source_to_keywords.xml	2017-01-17 22:40:14.316753	322	EXECUTED	7:4156af11df84e3496fda3d8626f3cff5	sql (x6)		\N	3.2.0
ADD-KEYWORD-SEQUENCES	Angel Montenegro	/db/updates/add_id_visibility_and_source_to_keywords.xml	2017-01-17 22:40:14.352445	323	EXECUTED	7:f92e07a5e688b0607bf1f12700e48038	createSequence		\N	3.2.0
SET-ID-TO-KEYWORDS	Angel Montenegro	/db/updates/add_id_visibility_and_source_to_keywords.xml	2017-01-17 22:40:14.353774	324	EXECUTED	7:0ca4953d088f344fcb12d9b26a4d54cd	sql		\N	3.2.0
SET-KEYWORDS-VISIBILITY	Angel Montenegro	/db/updates/add_id_visibility_and_source_to_keywords.xml	2017-01-17 22:40:14.355065	325	EXECUTED	7:453932ce03a535af3869ea93549b9987	sql		\N	3.2.0
SET-SOURCE-TO-KEYWORDS	Angel Montenegro	/db/updates/add_id_visibility_and_source_to_keywords.xml	2017-01-17 22:40:14.356281	326	EXECUTED	7:7a1ce03b8d9904f1fc265322b65ce589	sql		\N	3.2.0
SET-ID-AS-PRIMARY-KEY-ON-KEYWORDS	Angel Montenegro	/db/updates/add_id_visibility_and_source_to_keywords.xml	2017-01-17 22:40:14.369973	327	EXECUTED	7:ed941ba8c76cef5d7aa67b6f77188a56	dropPrimaryKey, addPrimaryKey		\N	3.2.0
UPDATE-ADDRESS-TO-HAVE-MULTIPLE-PER-USER	Angel Montenegro	/db/updates/update_address_table.xml	2017-01-17 22:40:14.455141	328	EXECUTED	7:6efb4dc0fd152ea935dc69d821f0e04f	sql (x10)		\N	3.2.0
ADD-DISPLAY-INDEX-TO-KEYWORDS	Angel Montenegro	/db/updates/add_display_index_to_keywords.xml	2017-01-17 22:40:14.492907	329	EXECUTED	7:36aeea33d1ab4e57dc4acdc1b4c45fe7	sql		\N	3.2.0
ADD-DISPLAY-INDEX-TO-ADDRESS	Angel Montenegro	/db/updates/add_display_index_to_address.xml	2017-01-17 22:40:14.55661	330	EXECUTED	7:674033f749f7636c99fbcf09493045c3	sql		\N	3.2.0
ADD-DISPLAY-INDEX-TO-OTHER-NAME	Angel Montenegro	/db/updates/add_display_index_to_other_name.xml	2017-01-17 22:40:14.671292	331	EXECUTED	7:cb4f06a94cc903a0390967600ca5b7ee	sql		\N	3.2.0
ADD-DISPLAY-INDEX-TO-RESEARCHER-URL	Angel Montenegro	/db/updates/add_display_index_to_researcher_url.xml	2017-01-17 22:40:14.717758	332	EXECUTED	7:bade8ecebf9edd81be3ac0f89b9652dd	sql		\N	3.2.0
ADD-DISPLAY-INDEX-TO-EXTERNAL-IDENTIFIER	Angel Montenegro	/db/updates/add_display_index_to_external_identifier.xml	2017-01-17 22:40:14.757723	333	EXECUTED	7:6cb70996ce2b621a5f1da26cbd23fc0a	sql		\N	3.2.0
SET-DEFAULT-VISIBILITY-TO-EXTERNAL-IDENTIFIERS	Angel Montenegro	/db/updates/set_default_visibility_to_person_elements.xml	2017-01-17 22:40:14.770199	334	EXECUTED	7:a84cd42734c5b066491e5e19fe2806aa	sql		\N	3.2.0
SET-DEFAULT-VISIBILITY-TO-KEYWORDS	Angel Montenegro	/db/updates/set_default_visibility_to_person_elements.xml	2017-01-17 22:40:14.773951	335	EXECUTED	7:fdf3b8beea946a76897b854db3987abf	sql		\N	3.2.0
SET-DEFAULT-VISIBILITY-TO-RESEARCHER-URL	Angel Montenegro	/db/updates/set_default_visibility_to_person_elements.xml	2017-01-17 22:40:14.776725	336	EXECUTED	7:6cf4f1c90dd777e45ae4c93675fcf249	sql		\N	3.2.0
SET-DEFAULT-VISIBILITY-TO-ADDRESS	Angel Montenegro	/db/updates/set_default_visibility_to_person_elements.xml	2017-01-17 22:40:14.779812	337	EXECUTED	7:06e28ee931e607838892a893ee1d8004	sql (x2)		\N	3.2.0
SET-DEFAULT-VISIBILITY-TO-OTHER-NAMES	Angel Montenegro	/db/updates/set_default_visibility_to_person_elements.xml	2017-01-17 22:40:14.782195	338	EXECUTED	7:3ad1e674ac2e5e918602a023fa4906d8	sql		\N	3.2.0
ORCID-IDX-ON-ADDRESS	Angel Montenegro	/db/updates/add_orcid_index_on_address_researcher_url_and_external_identifiers.xml	2017-01-17 22:40:16.428681	339	EXECUTED	7:94206940b4277c50abcd03eaa902631d	sql		\N	3.2.0
ORCID-IDX-ON-RESEARCHER-URL	Angel Montenegro	/db/updates/add_orcid_index_on_address_researcher_url_and_external_identifiers.xml	2017-01-17 22:40:18.11642	340	EXECUTED	7:68f191b58daa4daa3ee7352afe48626e	sql		\N	3.2.0
ORCID-IDX-ON-EXTERNAL-IDENTIFIER	Angel Montenegro	/db/updates/add_orcid_index_on_address_researcher_url_and_external_identifiers.xml	2017-01-17 22:40:19.829749	341	EXECUTED	7:27fd3a98a58f6cc6ba2c444e659a2053	sql		\N	3.2.0
ADD-ORCID-DISPLAY-INDEX-IDX-ON-WORK-TABLE	Angel Montenegro	/db/updates/add_work_orcid_display_index_index_on_work_table.xml	2017-01-17 22:40:21.577931	342	EXECUTED	7:391278337bbf3b1d64b26d5f7a355616	sql		\N	3.2.0
ADD-ORCID-INDEX-ON-OTHER-NAMES	Angel Montenegro	/db/updates/add_orcid_index_other_names.xml	2017-01-17 22:40:23.329682	343	EXECUTED	7:e3b2a8cd47684037878511c441ae368f	sql		\N	3.2.0
CLEAN-DUPLICATE-ADDRESSES	Shobhit Tyagi	/db/updates/clean-address-table.xml	2017-01-17 22:40:23.33184	344	EXECUTED	7:b5aeb337111d0257d9bd1961207e6cc6	sql		\N	3.2.0
REMOVE-USER-CONNECTIONS-FOR-DEACTIVATED	Will Simpson	/db/updates/remove-user-connections-for-deactivated.xml	2017-01-17 22:40:23.333799	345	EXECUTED	7:622b5bf13341ba10205e2d2adabc1a40	sql		\N	3.2.0
REMOVE-HEAR-ABOUT	rcpeters	/db/updates/remove-hear-about.xml	2017-01-17 22:40:23.336895	346	EXECUTED	7:8d6cf7b384a08755a9f0692e5dcda28f	sql		\N	3.2.0
REMOVE-REG-ROLE	rcpeters	/db/updates/remove-hear-about.xml	2017-01-17 22:40:23.345833	347	EXECUTED	7:2690a7ac8d8b460acd2b9adba28e197b	sql (x2)		\N	3.2.0
ADD-ID-TYPE-USERCONNECTION-TABLE	Will Simpson	/db/updates/user_connection_id_type.xml	2017-01-17 22:40:23.34859	348	EXECUTED	7:edb5018fa462928ec61674e31ab40fbd	addColumn		\N	3.2.0
POPULATE-USERCONNECTION-ID-TYPE	Will Simpson	/db/updates/user_connection_id_type.xml	2017-01-17 22:40:23.350827	349	EXECUTED	7:da1ed75f8c0ae65ee24d34606adf58d8	sql		\N	3.2.0
CREATE-IDP-TABLE	Will Simpson	/db/updates/federated-idp-info.xml	2017-01-17 22:40:23.365009	350	EXECUTED	7:41e24f940e02be92ece9f3892500be01	createTable		\N	3.2.0
ADD-SEQUENCE-FOR-NOTIFICATIONS	Will Simpson	/db/updates/federated-idp-info.xml	2017-01-17 22:40:23.449524	351	EXECUTED	7:f7390ec769919c3220165788112a6204	createSequence		\N	3.2.0
ADD-EMAILS-TO-IDP	Will Simpson	/db/updates/federated-idp-info.xml	2017-01-17 22:40:23.451805	352	EXECUTED	7:ba76da9ef167c06833372aa6224f620f	addColumn		\N	3.2.0
ADD-FAILED-INFO-TO-IDP	Will Simpson	/db/updates/federated-idp-info.xml	2017-01-17 22:40:23.458906	353	EXECUTED	7:c9dc7d81c2ccef645a6468fb2eb41d30	addColumn		\N	3.2.0
ADD-ITEM-NOTIFICATION-INDEX-ON-NOTIFICATION-ITEM	rcpeters	/db/updates/add_notification_id_index.xml	2017-01-17 22:40:25.288639	354	EXECUTED	7:c5b5672244461cf686439caa066eb6d4	sql		\N	3.2.0
ADD-DATE-CREATED-ON-NOTIFICATION	rcpeters	/db/updates/add_notification_id_index.xml	2017-01-17 22:40:27.026983	355	EXECUTED	7:c689191078efe8d922c56f4a21fdf416	sql		\N	3.2.0
ADD-ARCHIVED-DATE-ON-NOTIFICATION	rcpeters	/db/updates/add_notification_id_index.xml	2017-01-17 22:40:28.591061	356	EXECUTED	7:0fd18621ec54f74fc636c177c768bc13	sql		\N	3.2.0
ADD-ORCID-NOTIFICATION	rcpeters	/db/updates/add_notification_id_index.xml	2017-01-17 22:40:30.17699	357	EXECUTED	7:19bc60678b93611305790b78cb86ce82	sql		\N	3.2.0
peer_review_orcid_index	rcpeters	/db/updates/add_indexes_2016_03_31.xml	2017-01-17 22:40:31.893703	358	EXECUTED	7:7441da8c65e20211f78b3c444423615e	sql		\N	3.2.0
peer_review_display_index	rcpeters	/db/updates/add_indexes_2016_03_31.xml	2017-01-17 22:40:33.553156	359	EXECUTED	7:c8c865207362d860f0f960a7a9251304	sql		\N	3.2.0
profile_funding_orcid_index	rcpeters	/db/updates/add_indexes_2016_03_31.xml	2017-01-17 22:40:35.187934	360	EXECUTED	7:9c6ada2c434f42d79eb4bf0520796871	sql		\N	3.2.0
profile_funding_display_index	rcpeters	/db/updates/add_indexes_2016_03_31.xml	2017-01-17 22:40:36.812962	361	EXECUTED	7:6ae0e1b147a2e7d16f02e633e744330f	sql		\N	3.2.0
group_id_lowercase_unique_idx	Angel Montenegro	/db/updates/add_indexes_2016_04_06.xml	2017-01-17 22:40:38.510492	362	EXECUTED	7:c0e85d31ecf24f3c54281dc09dd3b6be	sql		\N	3.2.0
CREATE-RECORD-NAME-TABLE	Angel Montenegro	/db/updates/create_record_name_table.xml	2017-01-17 22:40:38.522029	363	EXECUTED	7:5a175203ad6ddef426808709610b58d4	createTable, addForeignKeyConstraint		\N	3.2.0
CREATE-RECORD-NAME-SEQUENCES	Angel Montenegro	/db/updates/create_record_name_table.xml	2017-01-17 22:40:38.54717	364	EXECUTED	7:7e6b60b012d550b79cb1fe82fb65082a	createSequence		\N	3.2.0
RECORD-NAME-ORCID-INDEX	Angel Montenegro	/db/updates/create_record_name_table.xml	2017-01-17 22:40:40.193223	365	EXECUTED	7:d154ef3c852a46a3d00ef3b509629b09	sql		\N	3.2.0
GRANT-READ-PERMISSIONS-TO-ORCIDRO-ON-RECORD-NAME	Angel Montenegro	/db/updates/create_record_name_table.xml	2017-01-17 22:40:40.195714	366	EXECUTED	7:286bf2baca5fb286119ac23bdbc58a20	sql		\N	3.2.0
CREATE-BIOGRAPHY-TABLE	Angel Montenegro	/db/updates/create_biography_table.xml	2017-01-17 22:40:40.205347	367	EXECUTED	7:8c78b2c296520401abe60f992e090a08	createTable, addForeignKeyConstraint		\N	3.2.0
CREATE-BIOGRAPHY-SEQUENCES	Angel Montenegro	/db/updates/create_biography_table.xml	2017-01-17 22:40:40.281594	368	EXECUTED	7:58cd2640d1f22f7ef3c1019e08ba8762	createSequence		\N	3.2.0
BIOGRAPHY-ORCID-INDEX	Angel Montenegro	/db/updates/create_biography_table.xml	2017-01-17 22:40:41.949184	369	EXECUTED	7:f8d88fbb15ce8f393e5b204e38cf457f	sql		\N	3.2.0
GRANT-READ-PERMISSIONS-TO-ORCIDRO-ON-BIOGRAPHY	Angel Montenegro	/db/updates/create_biography_table.xml	2017-01-17 22:40:41.951365	370	EXECUTED	7:2328eef1fb82addbddb7b955165ea605	sql		\N	3.2.0
REMOVE-WORK-EXTERNAL-IDENTIFIER	Angel Montenegro	/db/updates/remove_old_works_related_tables.xml	2017-01-17 22:40:41.953611	371	EXECUTED	7:5e69008f534e877ce0dd46642aee24e2	sql		\N	3.2.0
REMOVE-WORK-CONTRIBUTOR	Angel Montenegro	/db/updates/remove_old_works_related_tables.xml	2017-01-17 22:40:41.956504	372	EXECUTED	7:93ad4ff5b9be122f1b43e44e08715841	sql		\N	3.2.0
REMOVE-WORK-SOURCE	Angel Montenegro	/db/updates/remove_old_works_related_tables.xml	2017-01-17 22:40:41.959491	373	EXECUTED	7:097a630fdcfaf1779907630e209d889c	sql		\N	3.2.0
CREATE-IDENTIFIER-TYPE-TABLE	Tom D	/db/updates/identifier-type.xml	2017-01-17 22:40:41.97116	374	EXECUTED	7:a907bf1f4086a4ca986ec3df81f53801	createTable		\N	3.2.0
ADD-SEQUENCE-FOR-IDENTIFIER-TYPE	Tom D	/db/updates/identifier-type.xml	2017-01-17 22:40:42.042046	375	EXECUTED	7:a4bd36aab94a8d159398585b60ca147b	createSequence		\N	3.2.0
INSERT-DEFAULT-IDENTIFIER-TYPES	Tom D	/db/updates/identifier-type.xml	2017-01-17 22:40:42.059045	376	EXECUTED	7:d2faf80f9045509ea9836bb91b185317	insert (x34)		\N	3.2.0
set_default_names_visibility_where_it_is_null	Angel Montenegro	/db/updates/set_default_visibility_on_names.xml	2017-01-17 22:40:42.065882	377	EXECUTED	7:1502afccdfdcfd0fe42a43ebb82c46c7	sql (x4)		\N	3.2.0
SET-SOURCE-TO-ADDRESS	Angel Montenegro	/db/updates/fix_source_on_bio_elements.xml	2017-01-17 22:40:42.070036	378	EXECUTED	7:d302a6eabebc5fb5951ff05840c55e8e	sql (x5)		\N	3.2.0
SET-SOURCE-TO-KEYWORDS	Angel Montenegro	/db/updates/fix_source_on_bio_elements.xml	2017-01-17 22:40:42.073978	379	EXECUTED	7:dff6ac78d6016938ad8a0fdaaa34eac7	sql (x5)		\N	3.2.0
SET-SOURCE-TO-OTHER-NAMES	Angel Montenegro	/db/updates/fix_source_on_bio_elements.xml	2017-01-17 22:40:42.078387	380	EXECUTED	7:ddd64e9307af57e327fe151fc7c95064	sql (x5)		\N	3.2.0
SET-SOURCE-TO-RESEARCHER-URLS	Angel Montenegro	/db/updates/fix_source_on_bio_elements.xml	2017-01-17 22:40:42.082828	381	EXECUTED	7:805f51a1bf81de4c31874f9bd7832e38	sql (x5)		\N	3.2.0
given_permission_to_giver_orcid_idx	rcpeters	/db/updates/add_indexes_2016_05_23.xml	2017-01-17 22:40:43.766239	382	EXECUTED	7:4e968b3cea08220ff526534d30b9c0bc	sql		\N	3.2.0
given_permission_to_receiver_orcid_idx	rcpeters	/db/updates/add_indexes_2016_05_23.xml	2017-01-17 22:40:45.44139	383	EXECUTED	7:ba71f4f2b07856da2fd76b46f0bf105b	sql		\N	3.2.0
email_event_email_idx	rcpeters	/db/updates/add_indexes_2016_05_23.xml	2017-01-17 22:40:47.096879	384	EXECUTED	7:99c617e1666e713595e4242f51c4e889	sql		\N	3.2.0
group_id_record_date_created_idx	rcpeters	/db/updates/add_indexes_2016_05_25.xml	2017-01-17 22:40:48.773983	385	EXECUTED	7:87ce8ac060a9a0d794ff769ce1be5aa7	sql		\N	3.2.0
group_id_record_group_type_idx	rcpeters	/db/updates/add_indexes_2016_05_25.xml	2017-01-17 22:40:50.529557	386	EXECUTED	7:a3d3daaa3c195ecd30651e078506df85	sql		\N	3.2.0
record_name_credit_name_idx	rcpeters	/db/updates/add_indexes_2016_05_25.xml	2017-01-17 22:40:52.255193	387	EXECUTED	7:2d0dfde343c9b943b3005cb4aef1da0a	sql		\N	3.2.0
profile_funding_org_id_idx	rcpeters	/db/updates/add_indexes_2016_05_25.xml	2017-01-17 22:40:54.043907	388	EXECUTED	7:e76daf43dcf20d53ed21da3e24543bca	sql		\N	3.2.0
FIX-NULL-VISIBILITY-ON-OTHER-NAME	Angel Montenegro	/db/updates/fix_null_visibility_on_bio_elements.xml	2017-01-17 22:40:54.097327	389	EXECUTED	7:e7c5bd3b51a6a7622bcccc5d1dc42661	sql		\N	3.2.0
FIX-NULL-VISIBILITY-ON-PROFILE-KEYWORD	Angel Montenegro	/db/updates/fix_null_visibility_on_bio_elements.xml	2017-01-17 22:40:54.098874	390	EXECUTED	7:9ddbf34b6b0649f98719e622d2cba2c7	sql		\N	3.2.0
FIX-NULL-VISIBILITY-ON-RESEARCHER-URL	Angel Montenegro	/db/updates/fix_null_visibility_on_bio_elements.xml	2017-01-17 22:40:54.10028	391	EXECUTED	7:934acdf8a58e291c1c2431072f8d897e	sql		\N	3.2.0
REMOVE-SEQUENCE-FOR-IDENTIFIER-TYPE	Tom D	/db/updates/identifier-type-fixed.xml	2017-01-17 22:40:54.1251	392	EXECUTED	7:118add09a7be2d9738a9e171253e02db	dropSequence		\N	3.2.0
ADD-SEQUENCE-FOR-IDENTIFIER-TYPE_REDO	Tom D	/db/updates/identifier-type-fixed.xml	2017-01-17 22:40:54.201839	393	EXECUTED	7:5686b8f4a0971823fe1fea7ee82d1f1f	createSequence		\N	3.2.0
CLEAN-DUPLICATED-DELEGATES	Angel Montenegro	/db/updates/clean-duplicated-delegates.xml	2017-01-17 22:40:54.204363	394	EXECUTED	7:47f69452d531ebc043f3e1e6735cc70c	sql		\N	3.2.0
UPDATE_EXTERNAL_IDENTIFIER_UNIQUE_CONSTRAINT	Angel Montenegro	/db/updates/update-external-identifiers-unique-constraint.xml	2017-01-17 22:40:54.208865	395	EXECUTED	7:1d464ae03fd4a5987c71b7eea1a69980	sql (x2)		\N	3.2.0
TIDY_ORG_EXT_IDS	Will Simpson	/db/updates/tidy_org_ext_ids.xml	2017-01-17 22:40:54.21232	396	EXECUTED	7:4952dd0e60953342a57b2a8f8ece407f	sql (x4)		\N	3.2.0
FIX-NULL-VISIBILITY-ON-BIOGRAPHY	Angel Montenegro	/db/updates/fix_bios_without_visibility.xml	2017-01-17 22:40:54.215571	397	EXECUTED	7:25eee21513016c31905542f6ac010b2c	sql (x4)		\N	3.2.0
FIX_DISPLAY_INDEXS_FOR_BIO	rcpeters	/db/updates/fix_display_indexs_for_bio.xml	2017-01-17 22:40:54.219631	398	EXECUTED	7:442819e9f84d1b781050c18c6a3f51cb	sql		\N	3.2.0
FIX_DISPLAY_INDEXS_FOR_BIO_V2	rcpeters	/db/updates/fix_display_indexs_for_bio.xml	2017-01-17 22:40:54.223048	399	EXECUTED	7:ad4f6bf634570830564d10441237b44e	sql		\N	3.2.0
FIX_NULL_DISPLAY_INDEXS_FOR_BIO_V2	Angel Montenegro	/db/updates/fix_display_indexs_for_bio.xml	2017-01-17 22:40:54.225048	400	EXECUTED	7:53d2812647bb46fb439745bf5de9a4fa	sql		\N	3.2.0
FIX-ZBL-WORK_EXT_ID	Will Simpson	/db/updates/fix_zbl.xml	2017-01-17 22:40:54.226621	401	EXECUTED	7:1b1272f3aeaefb2fe10122130f871517	sql		\N	3.2.0
ADD-STATUS-USERCONNECTION-TABLE	Angel Montenegro	/db/updates/insitutional_sign_in_round_trip.xml	2017-01-17 22:40:54.310099	402	EXECUTED	7:70c29e95526eb26817259bb9b2136d94	addColumn		\N	3.2.0
ADD-AUTHENTICATION-PROVIDER-ID-TO-THE-CLIENT-DETAILS-TABLE	Angel Montenegro	/db/updates/insitutional_sign_in_round_trip.xml	2017-01-17 22:40:54.340697	403	EXECUTED	7:bd8a3e5c282d0d3b0ca578972b26b240	addColumn		\N	3.2.0
SET-ALL-EXISTING-USERCONNECTION-TO-STARTED	Angel Montenegro	/db/updates/insitutional_sign_in_round_trip.xml	2017-01-17 22:40:54.346248	404	EXECUTED	7:b89ea6d1a089cdc2601956620fcd2559	sql		\N	3.2.0
ADD-AUTHENTICATION-PROVIDER-ID-TO-THE-NOTIFICATION-TABLE	Will Simpson	/db/updates/insitutional_sign_in_round_trip.xml	2017-01-17 22:40:54.434903	405	EXECUTED	7:92cce8b978d45208b82f7edf0d3fe070	addColumn		\N	3.2.0
SET-PROVIDER-ID-ON-EXISTING-NOTIFICATIONS	Will Simpson	/db/updates/insitutional_sign_in_round_trip.xml	2017-01-17 22:40:54.436717	406	EXECUTED	7:6cce97f3b89a4d5b67ccf3861d0ad896	sql		\N	3.2.0
CREATE-IDP-NAME-TABLE	Will Simpson	/db/updates/federated-idp-name.xml	2017-01-17 22:40:54.448375	407	EXECUTED	7:50cdf676505585508612f78b86d89d27	createTable, addForeignKeyConstraint		\N	3.2.0
ADD-SEQUENCE-FOR-IDP-NAME	Will Simpson	/db/updates/federated-idp-name.xml	2017-01-17 22:40:54.508768	408	EXECUTED	7:761f911a0cceb950468a5db131507d44	createSequence		\N	3.2.0
CREATE-SALESFORCE-CONNECTION-TABLE	Will Simpson	/db/updates/consortia-self-service.xml	2017-01-17 22:40:54.5189	409	EXECUTED	7:e83d8bb4110e2d71f2474e2d9e9e3a75	createTable, createIndex		\N	3.2.0
ADD-SEQUENCE-FOR-SALESFORCE-CONNECTION	Will Simpson	/db/updates/consortia-self-service.xml	2017-01-17 22:40:54.544761	410	EXECUTED	7:941b8b167749a738374ba1c07b074d61	createSequence		\N	3.2.0
fix_null_relationship_on_funding_ext_ids	Angel Montenegro	/db/updates/fix-null-relationship-on-funding-ext-ids.xml	2017-01-17 22:40:54.549492	411	EXECUTED	7:49dfa3de6548946da3e43375e6eb226c	sql (x8)		\N	3.2.0
CREATE-PDB-IDENTIFIER	Tom D	/db/updates/identifier-types/identifier-type-pdb.xml	2017-01-17 22:40:54.552457	412	EXECUTED	7:3ea9066e1acecea0f4b80f94cabf9d94	insert		\N	3.2.0
CREATE-KUID-IDENTIFIER	Tom D	/db/updates/identifier-types/identifier-type-kuid.xml	2017-01-17 22:40:54.555801	413	EXECUTED	7:ce81320b113275d68775c030e0c94d60	insert		\N	3.2.0
CREATE-LENSID-IDENTIFIER	Tom D	/db/updates/identifier-types/identifier-type-36-lensid.xml	2017-01-17 22:40:54.611284	414	EXECUTED	7:4b264f5d54197270fc88c1484da82338	insert		\N	3.2.0
ADD-EMAIL-ACCESS-REASON	George Nash	/db/updates/add_email_access_reason.xml	2017-01-17 22:40:54.613233	415	EXECUTED	7:a15ee9e528f375a41234f8e885f0d983	addColumn		\N	3.2.0
ADD-HEADERS-TO-USERCONNECTION	Will Simpson	/db/updates/institutional_sign_in_heuristics.xml	2017-01-17 22:40:54.64613	416	EXECUTED	7:c0b45f443dc0d7458d170d2e9a0b1b92	addColumn		\N	3.2.0
CONVERT-TEXT-TO-JSON	Will Simpson	/db/updates/institutional_sign_in_heuristics.xml	2017-01-17 22:40:54.654197	417	EXECUTED	7:9d90b1458ee9dafcbd3cc3744c10720a	sql		\N	3.2.0
ADD-AUTO-DEPRECATE-TO-CLIENT-DETAILS	Angel Montenegro	/db/updates/add_auto_deprecate_to_client_details.xml	2017-01-17 22:40:54.692024	418	EXECUTED	7:b0878abfc4c99e22baa53fb95ced4dac	sql (x3)		\N	3.2.0
ID-TYPE-ADD-PRIMARY-USE	Tom Demeranville	/db/updates/identifier-types/add-primary-use-and-urls.xml	2017-01-17 22:40:54.741103	419	EXECUTED	7:69b0d82c749fd12f3fa960fe18075a9b	sql (x2)		\N	3.2.0
ADD-TYPE-URL-PREFIXES	Tom Demeranville	/db/updates/identifier-types/add-primary-use-and-urls.xml	2017-01-17 22:40:54.74841	420	EXECUTED	7:0ee8465bf82f6c345a57ba1e23d132c2	sql (x21)		\N	3.2.0
ADD-TYPE-URL-PREFIXES	Tom Demeranville	/db/updates/identifier-types/update-kuid-url.xml	2017-01-17 22:40:54.750432	421	EXECUTED	7:4241e36cd9a9afba3054e28c8595e7e8	sql		\N	3.2.0
ADD-WORK-EXTERNAL-IDS-JSON-COLUMN	Will Simpson	/db/updates/work-external-ids-as-json.xml	2017-01-17 22:44:24.070129	1	EXECUTED	7:e1cba068309ff6ae561ad4a46f9209dc	addColumn		\N	3.2.0
CONVERT-TEXT-TO-JSON	Will Simpson	/db/updates/work-external-ids-as-json.xml	2017-01-17 22:44:24.077707	2	EXECUTED	7:59d7f7aeb42e754db84a5c2dd7044cdb	sql (x2), createProcedure (x2), createIndex		\N	3.2.0
ADD-JSON-CAST	Will Simpson	/db/updates/work-external-ids-as-json.xml	2017-01-17 22:44:24.078255	3	EXECUTED	7:ca804e7ec59fac915f72fc02b2f4fb57	sql		\N	3.2.0
ADD-WORK-EXTERNAL-IDS-JSON-COLUMN	Will Simpson	/db/updates/work-external-ids-as-json.xml	2017-01-17 22:44:31.772296	1	EXECUTED	7:e1cba068309ff6ae561ad4a46f9209dc	addColumn		\N	3.2.0
CONVERT-TEXT-TO-JSON	Will Simpson	/db/updates/work-external-ids-as-json.xml	2017-01-17 22:44:31.778557	2	EXECUTED	7:59d7f7aeb42e754db84a5c2dd7044cdb	sql (x2), createProcedure (x2), createIndex		\N	3.2.0
ADD-JSON-CAST	Will Simpson	/db/updates/work-external-ids-as-json.xml	2017-01-17 22:44:31.779374	3	EXECUTED	7:ca804e7ec59fac915f72fc02b2f4fb57	sql		\N	3.2.0
CREATE-CVID-IDENTIFIER	Tom D	/db/updates/identifier-types/identifier-type-37-38.xml	2017-01-26 19:16:08.764541	422	EXECUTED	7:7c3398041b35af0ce557abb53f0e5bdc	insert		\N	3.2.0
CREATE-CIENCIAIUL-IDENTIFIER	Tom D	/db/updates/identifier-types/identifier-type-37-38.xml	2017-01-26 19:16:08.773325	423	EXECUTED	7:57178a1464866dbb922e81837ead7ae6	insert		\N	3.2.0
UPDATE-DOI-HTTPS	Tom Demeranville	/db/updates/identifier-types/update-doi-https.xml	2017-02-17 16:53:23.793975	424	EXECUTED	7:e80d6e44dc5f73ac2b8820ef8d7ee6b0	sql		\N	3.2.0
REMOVE-CVID-IDENTIFIER	Tom D	/db/updates/identifier-types/remove-cv-id.xml	2017-02-17 16:53:23.818867	425	EXECUTED	7:a324fe34b2904cebf6f2e78ef2f3bb06	delete		\N	3.2.0
ADD-REASON-LOCKED-COLUMN-TO-PROFILE-TABLE	George Nash	/db/updates/add_column_reason_locked.xml	2017-02-17 16:53:23.934161	426	EXECUTED	7:feef6fbf7e06b201a49c74636c49be43	addColumn		\N	3.2.0
ADD-REASON-LOCKED-COLUMN-TO-PROFILE-TABLE	George Nash	/db/updates/add_column_reason_locked_description.xml	2017-02-17 16:53:23.939278	427	EXECUTED	7:eccb66a039d5643d1b0eba051013c802	addColumn		\N	3.2.0
ID-TYPE-ADD-CASE-SENSITIVE	Tom Demeranville	/db/updates/identifier-types/add-case-to-id-types.xml	2017-02-17 16:53:24.393079	428	EXECUTED	7:0313f171baca2bc3b7295269f1300c4b	sql		\N	3.2.0
UPDATE-KUID2	Tom Demeranville	/db/updates/identifier-types/update-kuid-url2.xml	2017-02-17 16:53:24.397807	429	EXECUTED	7:80b9d8fa97222ca2c06e7c454dcf0f5d	sql		\N	3.2.0
CREATE-INVALID-RECORD-DATA-CHANGES-TABLE	Angel Montenegro	/db/updates/create_invalid_record_data_changes_table.xml	2017-02-23 20:04:23.293692	430	EXECUTED	7:c42fdea071d136ae8eb6b74386534c99	createTable		\N	3.2.0
GRANT-READ-PERMISSIONS-TO-ORCIDRO-ON-GROUP-ID-RECORD	Tom Demeranville	/db/updates/grant-id-ro-permission.xml	2017-03-29 19:03:08.42645	431	EXECUTED	7:dcf8c1e472ad145e6a43ca0bde3b9d9c	sql		\N	3.2.0
ADD-ID	Angel Montenegro	/db/updates/add_id_and_indexes_to_invalid_record_data_changes.xml	2017-03-29 19:03:08.824464	432	EXECUTED	7:5f6a06c45aab1c1176854c06bcd613ce	sql		\N	3.2.0
CREATE-ID-SEQUENCE	Angel Montenegro	/db/updates/add_id_and_indexes_to_invalid_record_data_changes.xml	2017-03-29 19:03:08.935941	433	EXECUTED	7:1833313a7ff566772fbee242d20bf7d7	createSequence		\N	3.2.0
SET-ID-TO-EXISTING-CHANGES	Angel Montenegro	/db/updates/add_id_and_indexes_to_invalid_record_data_changes.xml	2017-03-29 19:03:08.94097	434	EXECUTED	7:91550abadf84e0f3b65092bb9a1a0062	sql		\N	3.2.0
SET-DEFAULT-VALUE-TO-ID	Angel Montenegro	/db/updates/add_id_and_indexes_to_invalid_record_data_changes.xml	2017-03-29 19:03:08.958286	435	EXECUTED	7:1dcce963960e688cf468688bcf262492	sql		\N	3.2.0
SET-ID-NOT-NULL-RESTRICTION	Angel Montenegro	/db/updates/add_id_and_indexes_to_invalid_record_data_changes.xml	2017-03-29 19:03:09.012559	436	EXECUTED	7:bbc6840289fe99a7974d2a7b6b1ab33f	sql		\N	3.2.0
CREATE-ID-INDEX	Angel Montenegro	/db/updates/add_id_and_indexes_to_invalid_record_data_changes.xml	2017-03-29 19:03:10.882845	437	EXECUTED	7:44f9554b826f397cae6554dc0af26739	sql		\N	3.2.0
DATE-CREATED-INDEX	Angel Montenegro	/db/updates/add_id_and_indexes_to_invalid_record_data_changes.xml	2017-03-29 19:03:12.66615	438	EXECUTED	7:cc78431fb47d415d6c8ad6bc7202de8a	sql		\N	3.2.0
GRANT-PERMISSIONS	Angel Montenegro	/db/updates/grant_permissions_to_invalid_record_data_changes.xml	2017-03-29 19:03:12.668109	439	EXECUTED	7:ec50754c5821f972e69f594d3e765683	sql		\N	3.2.0
ADD-HASHED-ORCID-TO-PROFILE-ENTITY	George Nash	/db/updates/add_hashed_orcid_to_profile_entity.xml	2017-06-08 13:14:30.149415	440	EXECUTED	7:fefe53a7c58155012cce981ba60d3572	addColumn		\N	3.2.0
DROP-KEYWORD-VIEW	Angel Montenegro	/db/updates/remove_keyword_view.xml	2017-06-08 13:14:30.288096	441	EXECUTED	7:dd34e5c95a8e9cdbfcd8e6d2d566b64d	sql		\N	3.2.0
UPDATE-CLIENT-REDIRECT-URI	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.361038	442	EXECUTED	7:c150ecbd2eb8c1769a292764dc88bfcd	sql (x3)		\N	3.2.0
UPDATE-CUSTOM-EMAIL	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.366392	443	EXECUTED	7:732146b6582631250f13c78e4c386fc1	sql (x2)		\N	3.2.0
UPDATE-EMAIL	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.395238	444	EXECUTED	7:b225a21b268183ffafd6fc8c7ca65c1a	sql		\N	3.2.0
UPDATE-EMAIL-EVENT	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.399477	445	EXECUTED	7:46aaca8d2c8e0fc962b312d2dcf7b5bf	sql		\N	3.2.0
UPDATE-EXTERNAL-IDENTIFIER	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.409029	446	EXECUTED	7:55aea428dabf8467a743d74ce6eac2a4	sql (x3)		\N	3.2.0
UPDATE-FUNDING-SUBTYPE-TO-INDEX	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.414351	447	EXECUTED	7:2470aa6bb62b7d1697f56164f74a6187	sql		\N	3.2.0
UPDATE-GROUP-ID-RECORD	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.436626	448	EXECUTED	7:ab1b088a0f742ccc880d255277ee6ade	sql (x4)		\N	3.2.0
UPDATE-IDENTIFIER-TYPE	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.447429	449	EXECUTED	7:e546adcf3ae77f4ba4c6bea3d78e6612	sql (x4)		\N	3.2.0
UPDATE-IDENTITY-PROVIDER	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.49256	450	EXECUTED	7:63a67d999ead18e85f32b5bcf668a9c2	sql (x5)		\N	3.2.0
UPDATE-IDENITY-PROVIDER-NAME	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.497024	451	EXECUTED	7:cee8f2e2b6c3416592786b5498c491db	sql (x2)		\N	3.2.0
UPDATE-NOTIFICATION	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.516129	452	EXECUTED	7:271b1a2e02ed1f8e9eea71cb65512905	sql (x7)		\N	3.2.0
UPDATE-NOTIFICATION-ITEM	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.524514	453	EXECUTED	7:cfd7098b3d350918a6facac270b16385	sql (x4)		\N	3.2.0
UPDATE-ORG-AFFILIATION-RELATION	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.538143	454	EXECUTED	7:dadd236bf53f3ae784b3f990c0b32ef9	sql (x3)		\N	3.2.0
UPDATE-OTHER-NAME	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.549357	455	EXECUTED	7:54ae54d8fbfae0d261135485fd0acd34	sql		\N	3.2.0
UPDATE-PEER-REVIEW	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.597258	456	EXECUTED	7:3138c0e3d0a2a3f6c7e7e7b6088da5c5	sql (x10)		\N	3.2.0
UPDATE-PEER-REVIEW-SUBJECT	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.603059	457	EXECUTED	7:6142abc1b688507c9548d0d49705d5bd	sql (x7)		\N	3.2.0
UPDATE-PROFILE	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.605701	458	EXECUTED	7:f8cb0a1231b739c35ea707e64afcdb81	sql		\N	3.2.0
UPDATE-PROFILE-EVENT	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.609805	459	EXECUTED	7:929fd02d54308f42907d80b843b8b6f5	sql		\N	3.2.0
UPDATE-PROFILE-FUNDING	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.617378	460	EXECUTED	7:f3e5df48265c4a78a8695efda9683ba4	sql (x7)		\N	3.2.0
UPDATE-PROFILE-KEYWORD	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.637849	461	EXECUTED	7:0e584bd4ce0fc44a6cfdce2a01ee3a88	sql		\N	3.2.0
UPDATE-RECORD-NAME	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.64237	462	EXECUTED	7:259a9682b6b52883293cdb0ca6e2d685	sql (x3)		\N	3.2.0
UPDATE-RESEARCHER-URL	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.648327	463	EXECUTED	7:eab1340d7df1e9af99ccefbbb35deb99	sql (x2)		\N	3.2.0
UPDATE-SALESFORCE-CONNECTION	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.652453	464	EXECUTED	7:2b0872f5ec56cc5b40d15576bab79230	sql (x2)		\N	3.2.0
UPDATE-SHIBBOLETH-ACCOUNT	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.65656	465	EXECUTED	7:f493079b069481a135e5c0b05bc720e2	sql (x2)		\N	3.2.0
UPDATE-SUBJECT	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.661274	466	EXECUTED	7:be18e09c6716e052c4839b72d6efaa67	sql		\N	3.2.0
UPDATE-USERCONNECTION	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.709074	467	EXECUTED	7:bdb351afac85270d1c479abd30b5c555	sql (x12)		\N	3.2.0
UPDATE-WEBHOOK	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.712261	468	EXECUTED	7:3ec36298732c1b93d18fa05acb8fba04	sql		\N	3.2.0
UPDATE-WORK	Angel Montenegro	/db/updates/varchar_to_text.xml	2017-06-08 13:14:30.720762	469	EXECUTED	7:ba60ece3c626f7b929c97a9291b061bb	sql (x11)		\N	3.2.0
ADD-NOTIFICATION-READ-DATE-INDEX	Will Simpson	/db/updates/notifications_indexes.xml	2017-06-08 13:14:31.999768	470	EXECUTED	7:d2fbdb9a63167b1e5cdd2bb4703e3e5b	createIndex		\N	3.2.0
ADD-NOTIFICATION-TYPE-INDEX	Will Simpson	/db/updates/notifications_indexes.xml	2017-06-08 13:14:33.136273	471	EXECUTED	7:f66b59b276590437335bdeb9cb66a0bf	createIndex		\N	3.2.0
ADD-NOTIFICATION-CLIENT-SOURCE-ID-INDEX	Will Simpson	/db/updates/notifications_indexes.xml	2017-06-08 13:14:34.70687	472	EXECUTED	7:6093469759ec7c1d5b7b70a3a8b800fd	createIndex		\N	3.2.0
ADD-NOTIFICATION-AUTHENTICATION-PROVIDER-ID-INDEX	Will Simpson	/db/updates/notifications_indexes.xml	2017-06-08 13:14:36.010498	473	EXECUTED	7:50cfa9d0a3e1614d3b12420e6479edb2	createIndex		\N	3.2.0
CREATE-RRID-IDENTIFIER	Tom D	/db/updates/identifier-types/identifier-type-39-rrid.xml	2017-06-08 13:14:36.032686	474	EXECUTED	7:cb7daa70ac989059100a60efdb5f0f38	insert		\N	3.2.0
ADD-LAST-LOGIN-COL-TO-PROFILE	Tom D	/db/updates/add_column_last_login_to_profile.xml	2017-06-08 13:14:36.198437	475	EXECUTED	7:2e1be836a1be82fa7caed211b4a591cf	addColumn		\N	3.2.0
ADD-NONCE-TO-OAUTH-DETAIL	Tom D	/db/updates/add_column_nonce_to_oauth_detail.xml	2017-06-08 13:14:36.301956	476	EXECUTED	7:53d601353a8e99702615ec18f56c35b3	addColumn		\N	3.2.0
FIX-ORGS-MISSING-DISAMBIGUATED-ORG	Angel Montenegro	/db/updates/fix_orgs_missing_disambiguated_org.xml	2017-06-08 13:14:36.394781	477	EXECUTED	7:18deebc1c307062aee54e362b2a1385e	sql (x6)	#1: Identify disambiguated orgs and put them in a temp table\n\t\t\t#2: Update the orgs based on the info in temp_org_disambiguation_table\n\t\t\t#3: Identify records that should be reindexed\n\t\t\t#4: Reindex records	\N	3.2.0
ADD-2FA-COLUMNS-TO-PROFILE-TABLE	George Nash	/db/updates/add_2fa_columns_to_profile.xml	2017-11-30 22:50:55.720981	478	EXECUTED	7:6cb60ffade2e4a828ee4d3186a6783bc	addColumn		\N	3.2.0
INSTALL-BACKUP-CODES-TABLE	George Nash	/db/updates/backup_codes.xml	2017-11-30 22:50:55.734761	479	EXECUTED	7:80231ba59ae45c6a59378bf8b2fa8dca	createTable, createSequence		\N	3.2.0
ADD-CODE-TO-TOKEN-DETAIL	Tom D	/db/updates/add_column_authorization_code_to_oauth2_token_detail.xml	2017-11-30 22:50:55.929744	480	EXECUTED	7:2401ff048383e0e091a7847c42e25b05	addColumn		\N	3.2.0
CLEAN-DEACTIVATED-RECORDS	Angel Montenegro	/db/updates/clean_deactivated_records.xml	2017-11-30 22:50:56.018104	481	EXECUTED	7:4fe57015a827cef19bfa3028a6bfc084	sql (x15)		\N	3.2.0
ADD-INDEX-TO-NOTIFICATION-SENT-DATE	George Nash	/db/updates/notification_sent_date_index.xml	2017-11-30 22:50:56.02545	482	EXECUTED	7:2c99595a2217d9559a56fb0890952d53	sql		\N	3.2.0
ADD-URL-COLUMN-TO-ORG-AFFILIATION-RELATION-TABLE	George Nash	/db/updates/add_url_column_to_org_affiliation_relation.xml	2017-11-30 22:50:56.028764	483	EXECUTED	7:ef7dd49949e86827ded48f2c35850ca3	addColumn		\N	3.2.0
DELETE-GRANT-CONTRIBUTOR	Angel Montenegro	/db/updates/delete_grants_tables.xml	2017-11-30 22:50:56.036202	484	EXECUTED	7:5ad2e19ffeb9e4e1bb5a689489c7a29b	dropTable		\N	3.2.0
DELETE-PROFILE-GRANT	Angel Montenegro	/db/updates/delete_grants_tables.xml	2017-11-30 22:50:56.042407	485	EXECUTED	7:84e6ac0c60354f37ad96e2ca952be1aa	dropTable		\N	3.2.0
DELETE-GRANT-SOURCE	Angel Montenegro	/db/updates/delete_grants_tables.xml	2017-11-30 22:50:56.046577	486	EXECUTED	7:e59960cddf4e1bf5d1b2cf147fd048dc	dropTable		\N	3.2.0
DELETE-FUNDING-GRANT	Angel Montenegro	/db/updates/delete_grants_tables.xml	2017-11-30 22:50:56.054076	487	EXECUTED	7:8804a0234725b2fd7f641d19a6dea283	dropTable		\N	3.2.0
DISABLE-TOKENS-ON-DEACTIVATED-RECORDS	Angel Montenegro	/db/updates/disable_tokens_on_deactivated_records.xml	2017-11-30 22:50:56.108837	488	EXECUTED	7:d05c285fe3b9c9f0fc6fc92217769e07	sql (x3)		\N	3.2.0
change_org_unique_constraint	George Nash	/db/updates/org_unique_constraints_add_disambiguated_org.xml	2017-11-30 22:50:56.114622	489	EXECUTED	7:45361780d0b8aa12a7ce4775d8ba0067	sql (x2)		\N	3.2.0
ADD-EXTERNAL_IDS_TO_ORG_AFFILIATION_RELATION	George Nash	/db/updates/add_external_identifiers_to_org_affiliation_relation.xml	2017-11-30 22:50:56.118827	490	EXECUTED	7:3c04d68c7a3c6675b77950602f57e23d	addColumn		\N	3.2.0
CHANGE-ORG-AFFILIATION-RELATION-EXTERNAL-IDS-TYPE-TO-JSON	George Nash	/db/updates/add_external_identifiers_to_org_affiliation_relation.xml	2017-11-30 22:50:56.126041	491	EXECUTED	7:3409bd1c5e1fe2180fe6e1065f7307d3	sql		\N	3.2.0
REINDEX-LOCKED-DEPRECATED-AND-DEACTIVATED-RECORDS	Angel Montenegro	/db/updates/reindex_locked_deprecated_and_deactivated_records.xml	2017-11-30 22:50:56.128813	492	EXECUTED	7:e1fce48393473b95eccbd8756ee5ebd6	sql		\N	3.2.0
CREATE-AUTHENTICUSID-IDENTIFIER	Tom D	/db/updates/identifier-types/identifier-type-40-authenticusid.xml	2017-11-30 22:50:56.13443	493	EXECUTED	7:90bfeedee9e61125927b2839a14be103	insert		\N	3.2.0
REMOVE-UNIQUE-CONSTRAINTS-ON-ORG-DISAMBIGUATED	Angel Montenegro	/db/updates/remove_unique_constraints_on_org_disambiguated.xml	2017-11-30 22:50:56.137667	494	EXECUTED	7:1ec4338863cd9c33c77add49464c94b8	sql		\N	3.2.0
REMOVE-INVALID-FUNDREF-ORG-DISAMBIGUATED-EXTERNAL-IDENTIFIER	Angel Montenegro	/db/updates/remove_invalid_fundref_org_disambiguated_external_identifiers.xml	2017-11-30 22:50:56.140597	495	EXECUTED	7:8a70e94da5b0ed1f4d116ed37797f08f	sql		\N	3.2.0
ADD-PREFERRED-INDICATOR	Angel Montenegro	/db/updates/add_preferred_indicator_to_org_disambiguated_external_identifier.xml	2017-11-30 22:50:56.239557	496	EXECUTED	7:a9f864aabcba4397e25169f16f7267a7	sql (x3)		\N	3.2.0
REINDEX-RECORDS-WITH-GRID-IDENTIFIERS	Angel Montenegro	/db/updates/reindex-records-with-grid-identifiers.xml	2017-11-30 22:50:56.243463	497	EXECUTED	7:12d1fd44b6611d2f14145a4d3eefed5b	sql		\N	3.2.0
BIBCODE-CASE-SENSITIVE	Tom Demeranville	/db/updates/identifier-types/make-bibcode-case-sensitive.xml	2017-11-30 22:50:56.246524	498	EXECUTED	7:1a43dc8a9b71dba9e1488abde643ec2f	sql		\N	3.2.0
ALLOW-MULTIPLE-SF-CONNECTIONS	Will Simpson	/db/updates/allow_multiple_sf_connections.xml	2017-11-30 22:50:56.347846	499	EXECUTED	7:da02f5d317181f5d3d98550724e52d27	addColumn, dropUniqueConstraint, addUniqueConstraint		\N	3.2.0
ADD-REVOCATION-DATE-TO-TOKEN	Angel Montenegro	/db/updates/add_revocation_date_to_token.xml	2017-11-30 22:50:56.423883	500	EXECUTED	7:ae594a1af1c211c81f9f7a870a08e282	addColumn		\N	3.2.0
ADD-REVOKE-REASON-TO-TOKEN	Angel Montenegro	/db/updates/add_revoke_reason_to_token.xml	2017-11-30 22:50:56.478052	501	EXECUTED	7:d9d7785f8dd3bc6ed1ad28a5f477e070	addColumn		\N	3.2.0
ADD-UNIQUE-INDEX-ON-TOKEN	Angel Montenegro	/db/updates/add_unique_index_on_token_value.xml	2017-11-30 22:50:58.401295	502	EXECUTED	7:07e01e709b62b70010c75782107a6d64	sql (x3)		\N	3.2.0
DROP-EMAIL-EVENT-CONSTRAINT	Angel Montenegro	src/main/resources/db/updates/use_email_hash_as_email_primary_key.xml	2018-10-03 22:29:29.156698	542	EXECUTED	7:ee2c6320ffc9ae64002a97e404ce7804	sql		\N	3.2.0
USE-EMAIL-HASH-AS-PRIMARY-KEY	Angel Montenegro	src/main/resources/db/updates/use_email_hash_as_email_primary_key.xml	2018-10-03 22:30:00.758247	543	EXECUTED	7:7177d81c619c65748ac732e3e5dfbbda	sql (x2)		\N	3.2.0
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: email; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.email (date_created, last_modified, email, orcid, visibility, is_primary, is_current, is_verified, source_id, client_source_id, email_hash) FROM stdin;
\.


--
-- Data for Name: email_event; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.email_event (id, date_created, last_modified, email, email_event_type) FROM stdin;
\.


--
-- Name: email_event_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.email_event_seq', 1005, true);


--
-- Data for Name: external_identifier; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.external_identifier (date_created, last_modified, orcid, external_id_reference, external_id_type, external_id_url, source_id, client_source_id, id, visibility, display_index) FROM stdin;
\.


--
-- Name: external_identifier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.external_identifier_id_seq', 53, true);


--
-- Data for Name: funding_external_identifier; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.funding_external_identifier (funding_external_identifier_id, profile_funding_id, ext_type, ext_value, ext_url, date_created, last_modified) FROM stdin;
\.


--
-- Name: funding_external_identifier_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.funding_external_identifier_seq', 1000, true);


--
-- Data for Name: funding_subtype_to_index; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.funding_subtype_to_index (orcid, subtype) FROM stdin;
\.


--
-- Data for Name: given_permission_to; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.given_permission_to (receiver_orcid, giver_orcid, date_created, last_modified, approval_date, given_permission_to_id) FROM stdin;
\.


--
-- Name: given_permission_to_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.given_permission_to_seq', 1003, true);


--
-- Name: grant_contributor_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.grant_contributor_seq', 1000, true);


--
-- Name: grant_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.grant_seq', 1000, true);


--
-- Data for Name: granted_authority; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.granted_authority (authority, orcid, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: group_id_record; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.group_id_record (id, group_id, group_name, group_description, group_type, source_id, client_source_id, date_created, last_modified) FROM stdin;
\.


--
-- Name: group_id_record_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.group_id_record_seq', 1284, true);


--
-- Data for Name: identifier_type; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.identifier_type (id, id_name, id_validation_regex, id_resolution_prefix, id_deprecated, client_source_id, date_created, last_modified, primary_use, case_sensitive) FROM stdin;
0	OTHER_ID	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
2	ASIN_TLD	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
6	EID	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
8	ISSN	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
21	AGR	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
22	CBA	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
23	CIT	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
24	CTX	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
26	HANDLE	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
27	HIR	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
28	PAT	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
29	SOURCE_WORK_ID	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
30	URI	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
31	URN	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
32	WOSUID	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
33	GRANT_NUMBER	\N	\N	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	funding	f
3	ARXIV	\N	http://arxiv.org/abs/	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
1	ASIN	\N	http://www.amazon.com/dp/	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
25	ETHOS	\N	http://ethos.bl.uk/OrderDetails.do?uin=	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
7	ISBN	\N	http://www.worldcat.org/isbn/	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
9	JFM	\N	http://zbmath.org/?format=complete&q=an%3A	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
10	JSTOR	\N	http://www.jstor.org/stable/	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
11	LCCN	\N	http://lccn.loc.gov/	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
12	MR	\N	http://www.ams.org/mathscinet-getitem?mr=	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
13	OCLC	\N	http://www.worldcat.org/oclc/	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
14	OL	\N	http://openlibrary.org/b/	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
15	OSTI	\N	http://www.osti.gov/energycitations/product.biblio.jsp?osti_id=	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
16	PMC	\N	http://europepmc.org/articles/	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
17	PMID	\N	http://www.ncbi.nlm.nih.gov/pubmed/	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
18	RFC	\N	http://www.rfc-editor.org/rfc/	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
19	SSRN	\N	http://papers.ssrn.com/abstract_id=	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
20	ZBL	\N	http://zbmath.org/?format=complete&q=	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
36	LENSID	\N	https://www.lens.org/	f	\N	2017-01-17 22:40:54.609971+00	2017-01-17 22:40:54.609971+00	work	f
34	PDB	\N	http://identifiers.org/pdb/	f	\N	2017-01-17 22:40:54.551491+00	2017-01-17 22:40:54.551491+00	work	f
38	CIENCIAIUL	\N	https://ciencia.iscte-iul.pt/id/	f	\N	2017-01-26 19:16:08.771409+00	2017-01-26 19:16:08.771409+00	work	f
5	DOI	\N	https://doi.org/	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	f
35	KUID	\N	https://koreamed.org/article/	f	\N	2017-01-17 22:40:54.554427+00	2017-01-17 22:40:54.554427+00	work	f
39	RRID	\N	http://identifiers.org/rrid/	f	\N	2017-06-08 13:14:36.030492+00	2017-06-08 13:14:36.030492+00	work	f
40	AUTHENTICUSID	\N	https://www.authenticus.pt/	f	\N	2017-11-30 22:50:56.132722+00	2017-11-30 22:50:56.132722+00	work	f
4	BIBCODE	\N	http://adsabs.harvard.edu/abs/	f	\N	2017-01-17 22:40:42.044189+00	2017-01-17 22:40:42.044189+00	work	t
\.


--
-- Name: identifier_type_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.identifier_type_seq', 1000, false);


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.identity_provider (id, date_created, last_modified, providerid, display_name, support_email, admin_email, tech_email, last_failed, failed_count) FROM stdin;
4	2017-02-01 00:05:05.969+00	2017-02-01 00:05:05.969+00	https://idp.testshib.org/idp/shibboleth	TestShib Test IdP	\N	\N	ndk@internet2.edu	\N	0
5	2017-02-01 00:05:06.049+00	2017-02-01 00:05:06.049+00	https://sp.testshib.org/shibboleth-sp	TestShib Two	\N	\N	ndk@internet2.edu	\N	0
6	2017-02-01 00:05:08.481+00	2017-02-01 00:05:08.481+00	https://engine.surfconext.nl/authentication/idp/metadata	SURFconext | SURFnet	help@surfconext.nl	support@surfconext.nl	support@surfconext.nl	\N	0
\.


--
-- Data for Name: identity_provider_name; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.identity_provider_name (id, date_created, last_modified, identity_provider_id, display_name, lang) FROM stdin;
4	2017-02-01 00:05:05.978+00	2017-02-01 00:05:05.978+00	4	TestShib Test IdP	en
5	2017-02-01 00:05:06.051+00	2017-02-01 00:05:06.051+00	5	TestShib Two	en
6	2017-02-01 00:05:08.482+00	2017-02-01 00:05:08.482+00	6	SURFconext | SURFnet	nl
7	2017-02-01 00:05:08.483+00	2017-02-01 00:05:08.483+00	6	SURFconext | SURFnet	en
\.


--
-- Name: identity_provider_name_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.identity_provider_name_seq', 7, true);


--
-- Name: identity_provider_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.identity_provider_seq', 6, true);


--
-- Data for Name: institution; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.institution (id, date_created, last_modified, institution_name, address_id) FROM stdin;
\.


--
-- Name: institution_department_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.institution_department_seq', 1000, true);


--
-- Name: institution_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.institution_seq', 1000, true);


--
-- Data for Name: internal_sso; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.internal_sso (orcid, token, date_created, last_modified) FROM stdin;
\.


--
-- Name: invalid_record_change_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.invalid_record_change_seq', 1000, false);


--
-- Data for Name: invalid_record_data_changes; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.invalid_record_data_changes (sql_used_to_update, description, num_changed, type, date_created, last_modified, id) FROM stdin;
\.


--
-- Name: keyword_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.keyword_seq', 1035, true);


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.notification (id, date_created, last_modified, orcid, notification_type, subject, body_text, body_html, sent_date, read_date, archived_date, sendable, source_id, authorization_url, lang, client_source_id, amended_section, actioned_date, notification_subject, notification_intro, authentication_provider_id) FROM stdin;
\.


--
-- Data for Name: notification_item; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.notification_item (id, notification_id, date_created, last_modified, item_type, item_name, external_id_type, external_id_value) FROM stdin;
\.


--
-- Name: notification_item_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.notification_item_seq', 1288, true);


--
-- Name: notification_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.notification_seq', 2846, true);


--
-- Data for Name: notification_work; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.notification_work (date_created, last_modified, notification_id, work_id) FROM stdin;
\.


--
-- Data for Name: oauth2_authoriziation_code_detail; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.oauth2_authoriziation_code_detail (authoriziation_code_value, is_aproved, orcid, redirect_uri, response_type, state, client_details_id, session_id, is_authenticated, date_created, last_modified, persistent, version, nonce) FROM stdin;
\.


--
-- Data for Name: oauth2_token_detail; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.oauth2_token_detail (token_value, token_type, token_expiration, user_orcid, client_details_id, is_approved, redirect_uri, response_type, state, scope_type, resource_id, date_created, last_modified, authentication_key, id, refresh_token_expiration, refresh_token_value, token_disabled, persistent, version, authorization_code, revocation_date, revoke_reason) FROM stdin;
\.


--
-- Data for Name: orcid_props; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.orcid_props (key, prop_value, date_created, last_modified) FROM stdin;
import-wizard-cache-version	{"version":"1","createdDate":"Wed Jan 18 21:16:18 UTC 2017"}	2017-01-18 21:16:18.611393+00	2017-01-18 21:16:18.611393+00
\.


--
-- Data for Name: orcid_social; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.orcid_social (orcid, type, encrypted_credentials, date_created, last_modified, last_run) FROM stdin;
\.


--
-- Data for Name: orcidoauth2authoriziationcodedetail_authorities; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.orcidoauth2authoriziationcodedetail_authorities (orcidoauth2authoriziationcodedetail_authoriziation_code_value, authorities) FROM stdin;
\.


--
-- Data for Name: orcidoauth2authoriziationcodedetail_resourceids; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.orcidoauth2authoriziationcodedetail_resourceids (orcidoauth2authoriziationcodedetail_authoriziation_code_value, resourceids) FROM stdin;
\.


--
-- Data for Name: orcidoauth2authoriziationcodedetail_scopes; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.orcidoauth2authoriziationcodedetail_scopes (orcidoauth2authoriziationcodedetail_authoriziation_code_value, scopes) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.org (id, name, city, region, country, url, source_id, date_created, last_modified, org_disambiguated_id, client_source_id) FROM stdin;
\.


--
-- Data for Name: org_affiliation_relation; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.org_affiliation_relation (id, org_id, orcid, org_affiliation_relation_role, org_affiliation_relation_title, department, start_day, start_month, start_year, end_day, end_month, end_year, visibility, source_id, date_created, last_modified, client_source_id, url, external_ids_json) FROM stdin;
\.


--
-- Name: org_affiliation_relation_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.org_affiliation_relation_seq', 1210, true);


--
-- Data for Name: org_disambiguated; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.org_disambiguated (id, source_id, source_url, source_type, org_type, name, city, region, country, url, status, date_created, last_modified, indexing_status, last_indexed_date, popularity, source_parent_id) FROM stdin;
\.


--
-- Data for Name: org_disambiguated_external_identifier; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.org_disambiguated_external_identifier (id, org_disambiguated_id, identifier, identifier_type, date_created, last_modified, preferred) FROM stdin;
\.


--
-- Name: org_disambiguated_external_identifier_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.org_disambiguated_external_identifier_seq', 1000, true);


--
-- Name: org_disambiguated_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.org_disambiguated_seq', 1026, true);


--
-- Name: org_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.org_seq', 1027, true);


--
-- Data for Name: other_name; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.other_name (other_name_id, date_created, last_modified, display_name, orcid, visibility, source_id, client_source_id, display_index) FROM stdin;
\.


--
-- Name: other_name_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.other_name_seq', 1040, true);


--
-- Data for Name: patent; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.patent (patent_id, issuing_country, patent_no, short_description, issue_date, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: patent_contributor; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.patent_contributor (patent_contributor_id, orcid, patent_id, credit_name, contributor_role, contributor_sequence, contributor_email, date_created, last_modified) FROM stdin;
\.


--
-- Name: patent_contributor_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.patent_contributor_seq', 1000, true);


--
-- Name: patent_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.patent_seq', 1000, true);


--
-- Data for Name: patent_source; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.patent_source (orcid, patent_id, source_orcid, deposited_date, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: peer_review; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.peer_review (id, orcid, peer_review_subject_id, external_identifiers_json, org_id, peer_review_role, peer_review_type, completion_day, completion_month, completion_year, source_id, url, visibility, client_source_id, date_created, last_modified, display_index, subject_external_identifiers_json, subject_type, subject_container_name, subject_name, subject_translated_name, subject_translated_name_language_code, subject_url, group_id) FROM stdin;
\.


--
-- Name: peer_review_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.peer_review_seq', 1145, true);


--
-- Data for Name: peer_review_subject; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.peer_review_subject (id, external_identifiers_json, title, work_type, sub_title, translated_title, translated_title_language_code, url, journal_title, date_created, last_modified) FROM stdin;
\.


--
-- Name: peer_review_subject_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.peer_review_subject_seq', 1000, false);


--
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.profile (orcid, date_created, last_modified, account_expiry, account_non_locked, completed_date, claimed, creation_method, credentials_expiry, credit_name, enabled, encrypted_password, encrypted_security_answer, encrypted_verification_code, family_name, given_names, is_selectable_sponsor, send_change_notifications, send_orcid_news, biography, vocative_name, security_question_id, source_id, non_locked, biography_visibility, keywords_visibility, external_identifiers_visibility, researcher_urls_visibility, other_names_visibility, orcid_type, group_orcid, submission_date, indexing_status, names_visibility, iso2_country, profile_address_visibility, profile_deactivation_date, activities_visibility_default, last_indexed_date, locale, client_type, group_type, primary_record, deprecated_date, referred_by, enable_developer_tools, send_email_frequency_days, enable_notifications, send_orcid_feature_announcements, send_member_update_requests, salesforce_id, client_source_id, developer_tools_enabled_date, record_locked, used_captcha_on_registration, user_last_ip, reviewed, send_administrative_change_notifications, reason_locked, reason_locked_description, hashed_orcid, last_login, secret_for_2fa, using_2fa) FROM stdin;
\.


--
-- Data for Name: profile_event; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.profile_event (id, date_created, last_modified, orcid, profile_event_type, comment) FROM stdin;
\.


--
-- Name: profile_event_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.profile_event_seq', 1000, true);


--
-- Data for Name: profile_funding; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.profile_funding (id, org_id, orcid, title, type, currency_code, translated_title, translated_title_language_code, description, start_day, start_month, start_year, end_day, end_month, end_year, url, contributors_json, visibility, source_id, date_created, last_modified, organization_defined_type, numeric_amount, display_index, client_source_id, external_identifiers_json) FROM stdin;
\.


--
-- Name: profile_funding_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.profile_funding_seq', 1156, true);


--
-- Data for Name: profile_keyword; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.profile_keyword (profile_orcid, keywords_name, date_created, last_modified, id, visibility, source_id, client_source_id, display_index) FROM stdin;
\.


--
-- Data for Name: profile_patent; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.profile_patent (orcid, patent_id, added_to_profile_date, visibility, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: profile_subject; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.profile_subject (profile_orcid, subjects_name) FROM stdin;
\.


--
-- Data for Name: record_name; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.record_name (id, orcid, credit_name, family_name, given_names, visibility, date_created, last_modified) FROM stdin;
\.


--
-- Name: record_name_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.record_name_seq', 1017, true);


--
-- Data for Name: reference_data; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.reference_data (id, date_created, last_modified, ref_data_key, ref_data_value) FROM stdin;
0	2017-01-17 22:39:44.902929	2017-01-17 22:39:44.902929	emailVerificationURL	http://localhost:8080/orcid-frontend-web
\.


--
-- Name: reference_data_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.reference_data_seq', 1000, true);


--
-- Name: related_url_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.related_url_seq', 1000, true);


--
-- Data for Name: researcher_url; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.researcher_url (url, date_created, last_modified, orcid, id, url_name, visibility, source_id, client_source_id, display_index) FROM stdin;
\.


--
-- Name: researcher_url_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.researcher_url_seq', 1061, true);


--
-- Data for Name: salesforce_connection; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.salesforce_connection (id, date_created, last_modified, orcid, email, salesforce_account_id, is_primary) FROM stdin;
\.


--
-- Name: salesforce_connection_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.salesforce_connection_seq', 1, false);


--
-- Data for Name: security_question; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.security_question (id, date_created, last_modified, question, key) FROM stdin;
0	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	None Selected	manage.security_question.id.0
1	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	What was the name of your first school?	manage.security_question.id.1
2	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	What is your favorite pastime?	manage.security_question.id.2
3	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	What is your all-time favorite sports team?	manage.security_question.id.3
4	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	What make was your first car or bike?	manage.security_question.id.4
5	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	Where did you first meet your spouse?	manage.security_question.id.5
6	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	What is your pet's name?	manage.security_question.id.6
7	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	What year were you born?	manage.security_question.id.7
8	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	In what city were you born?	manage.security_question.id.8
9	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	How many siblings do you have?	manage.security_question.id.9
10	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	What is your favorite sport or hobby?	manage.security_question.id.10
11	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	In what city was your mother born?	manage.security_question.id.11
12	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	In what city was your father born?	manage.security_question.id.12
13	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	What is the name of your high school?	manage.security_question.id.13
14	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	What year did you graduate from high school?	manage.security_question.id.14
15	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	What is your father's middle name?	manage.security_question.id.15
16	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	What is your mother's middle name?	manage.security_question.id.16
17	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	What is your favorite color?	manage.security_question.id.17
18	2017-01-17 22:39:44.99562	2017-01-17 22:39:44.99562	What is your mother's maiden name?	manage.security_question.id.18
\.


--
-- Data for Name: shibboleth_account; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.shibboleth_account (id, date_created, last_modified, orcid, remote_user, shib_identity_provider) FROM stdin;
\.


--
-- Name: shibboleth_account_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.shibboleth_account_seq', 1, false);


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.subject (name, date_created, last_modified) FROM stdin;
Acoustics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Agriculture	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Allergy	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Anatomy & Morphology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Anesthesiology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Anthropology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Archaeology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Architecture	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Area Studies	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Art	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Arts & Humanities - Other	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Asian Studies	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Astronomy & Astrophysics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Automation & Control Systems	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Behavioral Sciences	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Biochemistry & Molecular Biology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Biodiversity & Conservation	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Biomedical Social Sciences	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Biophysics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Biotechnology & Applied Microbiology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Business & Economics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Cardiovascular System & Cardiology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Cell Biology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Chemistry	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Classics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Communication	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Computer Science	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Construction & Building Technology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Criminology & Penology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Critical Care Medicine	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Crystallography	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Dance	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Demography	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Dentistry, Oral Surgery & Medicine	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Dermatology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Developmental Biology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Education & Educational Research	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Electrochemistry	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Emergency Medicine	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Endocrinology & Metabolism	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Energy & Fuels	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Engineering	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Entomology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Environmental Sciences & Ecology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Ethnic Studies	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Evolutionary Biology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Family Studies	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Film, Radio & Television	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Fisheries	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Food Science & Technology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Forestry	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Gastroenterology & Hepatology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
General & Internal Medicine	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Genetics & Heredity	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Geochemistry & Geophysics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Geography	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Geology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Geriatrics & Gerontology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Government & Law	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Health Care Sciences & Services	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Hematology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
History	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
History & Philosophy of Science	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Imaging Science & Photographic Technology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Immunology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Infectious Diseases	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Information Science & Library Science	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Instruments & Instrumentation	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Integrative & Complementary Medicine	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
International Relations	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Legal Medicine	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Life Sciences & Biomedicine - Other 	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Linguistics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Literature	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Marine & Freshwater Biology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Materials Science	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Mathematical & Computational Biology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Mathematical Methods In Social Sciences	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Mathematics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Mechanics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Medical Ethics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Medical Informatics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Medical Laboratory Technology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Metallurgy & Metallurgical Engineering	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Meteorology & Atmospheric Sciences	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Microbiology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Microscopy	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Mineralogy	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Mining & Mineral Processing	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Music	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Mycology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Neurosciences & Neurology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Nuclear Science & Technology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Nursing	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Nutrition & Dietetics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Obstetrics & Gynecology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Oceanography	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Oncology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Operations Research & Management Science	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Ophthalmology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Optics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Orthopedics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Otorhinolaryngology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Paleontology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Parasitology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Pathology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Pediatrics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Pharmacology & Pharmacy	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Philosophy	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Physical Geography	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Physics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Physiology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Plant Sciences	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Polymer Science	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Psychiatry	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Psychology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Public Administration	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Public, Environmental & Occupational Health	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Radiology, Nuclear Medicine & Medical Imaging	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Rehabilitation	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Religion	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Remote Sensing	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Reproductive Biology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Research & Experimental Medicine	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Respiratory System	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Rheumatology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Robotics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Science & Technology - Other 	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Social Issues	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Social Sciences - Other	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Social Work	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Sociology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Spectroscopy	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Sport Sciences	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Substance Abuse	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Surgery	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Telecommunications	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Theater	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Thermodynamics	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Toxicology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Transplantation	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Transportation	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Tropical Medicine	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Urban Studies	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Urology & Nephrology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Veterinary Sciences	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Virology	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Water Resources	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
Women's Studies	2017-01-17 22:39:45.070821	2017-01-17 22:39:45.070821
\.


--
-- Data for Name: userconnection; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.userconnection (userid, email, orcid, providerid, provideruserid, rank, displayname, profileurl, imageurl, accesstoken, secret, refreshtoken, expiretime, is_linked, last_login, date_created, last_modified, id_type, status, headers_json) FROM stdin;
7920331415506877543	\N	9999-0000-0000-0004	https://integrationtest.orcid.org/idp/shibboleth	integration-test-1484879698058@orcid.org	1	integration-test-1484879698058@orcid.org	http://localhost:8080/orcid-web/9999-0000-0000-0004	\N	\N	\N	\N	\N	t	2017-01-20 02:35:11.12+00	2017-01-20 02:35:11.123+00	2017-01-20 02:35:11.123+00	persistent-id	NOTIFIED	{"referer":"https://localhost:8443/orcid-web/shibboleth/signin","content-length":"48","accept-language":"en-US,en;q=0.5","cookie":"JSESSIONID=89AB6A35F8671E4C5B1249AB26E66BA7; __uvt=; uvts=5YSoEih92JGeAN0Q","accept":"application/json, text/javascript, */*; q=0.01","persistent-id":"integration-test-1484879698058@orcid.org","host":"localhost:8443","x-requested-with":"XMLHttpRequest","shib-identity-provider":"https://integrationtest.orcid.org/idp/shibboleth","content-type":"application/x-www-form-urlencoded; charset=UTF-8","x-csrf-token":"88a8f95a-5c33-4ae7-9521-494c49e19ffc","connection":"keep-alive","accept-encoding":"gzip, deflate, br","user-agent":"Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0"}
3086123884965214798	\N	9999-0000-0000-0004	https://integrationtest.orcid.org/idp/shibboleth	integration-test-1487356289657@orcid.org	1	integration-test-1487356289657@orcid.org	http://localhost:8080/orcid-web/9999-0000-0000-0004	\N	\N	\N	\N	\N	t	2017-02-17 18:31:40.21+00	2017-02-17 18:31:40.276+00	2017-02-17 18:31:40.276+00	persistent-id	NOTIFIED	{"referer":"https://localhost:8443/orcid-web/shibboleth/signin","content-length":"48","accept-language":"en-US,en;q=0.5","cookie":"JSESSIONID=911E4FA6F98337E8EA7F4F0E7DC452E5; __uvt=; uvts=5fetOhwBUGoclFnq","accept":"application/json, text/javascript, */*; q=0.01","persistent-id":"integration-test-1487356289657@orcid.org","host":"localhost:8443","x-requested-with":"XMLHttpRequest","shib-identity-provider":"https://integrationtest.orcid.org/idp/shibboleth","content-type":"application/x-www-form-urlencoded; charset=UTF-8","x-csrf-token":"3c1aa917-8caf-4c2d-9762-67a813c8ab0d","connection":"keep-alive","accept-encoding":"gzip, deflate, br","user-agent":"Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0"}
82935813956647713	\N	9999-0000-0000-0004	https://integrationtest.orcid.org/idp/shibboleth	integration-test-1487368446933@orcid.org	1	integration-test-1487368446933@orcid.org	http://localhost:8080/orcid-web/9999-0000-0000-0004	\N	\N	\N	\N	\N	t	2017-02-17 21:54:17.071+00	2017-02-17 21:54:17.074+00	2017-02-17 21:54:17.074+00	persistent-id	NOTIFIED	{"referer":"https://localhost:8443/orcid-web/shibboleth/signin","content-length":"48","accept-language":"en-US,en;q=0.5","cookie":"JSESSIONID=9450C8D57B338B9A754C61CD060C1991; __uvt=; uvts=5fh59rJPSBPw3D72","accept":"application/json, text/javascript, */*; q=0.01","persistent-id":"integration-test-1487368446933@orcid.org","host":"localhost:8443","x-requested-with":"XMLHttpRequest","shib-identity-provider":"https://integrationtest.orcid.org/idp/shibboleth","content-type":"application/x-www-form-urlencoded; charset=UTF-8","x-csrf-token":"57a7c0d5-c206-48ff-9873-294267eaaabf","connection":"keep-alive","accept-encoding":"gzip, deflate, br","user-agent":"Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0"}
4029303602840839821	\N	9999-0000-0000-0004	https://integrationtest.orcid.org/idp/shibboleth	integration-test-1497372553372@orcid.org	1	integration-test-1497372553372@orcid.org	http://localhost:8080/orcid-web/9999-0000-0000-0004	\N	\N	\N	\N	\N	t	2017-06-13 16:49:24.367+00	2017-06-13 16:49:21.672+00	2017-06-13 16:49:24.367+00	persistent-id	NOTIFIED	{"referer":"https://localhost:8443/orcid-web/shibboleth/signin","content-length":"48","accept-language":"en-US,en;q=0.5","cookie":"JSESSIONID=97AABECE4624D00953D522AAB9B69D9F; __uvt=; uvts=68l00C6s36yNTtMR","accept":"application/json, text/javascript, */*; q=0.01","persistent-id":"integration-test-1497372553372@orcid.org","host":"localhost:8443","x-requested-with":"XMLHttpRequest","shib-identity-provider":"https://integrationtest.orcid.org/idp/shibboleth","content-type":"application/x-www-form-urlencoded; charset=UTF-8","x-csrf-token":"072cbfd1-ef37-4a17-a926-0e233788b91d","connection":"keep-alive","accept-encoding":"gzip, deflate, br","user-agent":"Mozilla/5.0 (X11; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0"}
\.


--
-- Data for Name: webhook; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.webhook (orcid, client_details_id, uri, date_created, last_modified, last_failed, failed_attempt_count, enabled, disabled_date, disabled_comments, last_sent, profile_last_modified) FROM stdin;
\.


--
-- Data for Name: work; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.work (work_id, date_created, last_modified, publication_day, publication_month, publication_year, title, subtitle, description, work_url, citation, work_type, citation_type, contributors_json, journal_title, language_code, translated_title, translated_title_language_code, iso2_country, external_ids_json, orcid, added_to_profile_date, visibility, display_index, source_id, client_source_id) FROM stdin;
\.


--
-- Name: work_contributor_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.work_contributor_seq', 1000, true);


--
-- Name: work_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.work_seq', 1477, true);


--
-- Name: address_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: backup_code_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.backup_code
    ADD CONSTRAINT backup_code_pkey PRIMARY KEY (id);


--
-- Name: biography_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.biography
    ADD CONSTRAINT biography_pkey PRIMARY KEY (id);


--
-- Name: client_authorised_grant_type_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_authorised_grant_type
    ADD CONSTRAINT client_authorised_grant_type_pkey PRIMARY KEY (client_details_id, grant_type);


--
-- Name: client_details_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_details
    ADD CONSTRAINT client_details_pkey PRIMARY KEY (client_details_id);


--
-- Name: client_granted_authority_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_granted_authority
    ADD CONSTRAINT client_granted_authority_pkey PRIMARY KEY (client_details_id, granted_authority);


--
-- Name: client_redirect_uri_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_redirect_uri
    ADD CONSTRAINT client_redirect_uri_pkey PRIMARY KEY (client_details_id, redirect_uri, redirect_uri_type);


--
-- Name: client_resource_id_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_resource_id
    ADD CONSTRAINT client_resource_id_pkey PRIMARY KEY (client_details_id, resource_id);


--
-- Name: client_scope_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT client_scope_pkey PRIMARY KEY (client_details_id, scope_type);


--
-- Name: client_secret_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_secret
    ADD CONSTRAINT client_secret_pk PRIMARY KEY (client_details_id, client_secret);


--
-- Name: country_id_id_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.country_reference_data
    ADD CONSTRAINT country_id_id_pkey PRIMARY KEY (country_iso_code);


--
-- Name: email_event_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.email_event
    ADD CONSTRAINT email_event_pkey PRIMARY KEY (id);


--
-- Name: email_primary_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT email_primary_key PRIMARY KEY (email_hash);


--
-- Name: external_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.external_identifier
    ADD CONSTRAINT external_identifier_pkey PRIMARY KEY (id);


--
-- Name: funding_external_identifier_constraints; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.funding_external_identifier
    ADD CONSTRAINT funding_external_identifier_constraints UNIQUE (profile_funding_id, ext_type, ext_value, ext_url);


--
-- Name: funding_external_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.funding_external_identifier
    ADD CONSTRAINT funding_external_identifier_pkey PRIMARY KEY (funding_external_identifier_id);


--
-- Name: given_permission_to_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.given_permission_to
    ADD CONSTRAINT given_permission_to_pkey PRIMARY KEY (given_permission_to_id);


--
-- Name: granted_authority_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.granted_authority
    ADD CONSTRAINT granted_authority_pkey PRIMARY KEY (authority, orcid);


--
-- Name: group_id_record_group_id_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.group_id_record
    ADD CONSTRAINT group_id_record_group_id_key UNIQUE (group_id);


--
-- Name: group_id_record_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.group_id_record
    ADD CONSTRAINT group_id_record_pkey PRIMARY KEY (id);


--
-- Name: identifier_type_id_name_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.identifier_type
    ADD CONSTRAINT identifier_type_id_name_key UNIQUE (id_name);


--
-- Name: identifier_type_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.identifier_type
    ADD CONSTRAINT identifier_type_pkey PRIMARY KEY (id);


--
-- Name: identity_provider_name_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.identity_provider_name
    ADD CONSTRAINT identity_provider_name_pkey PRIMARY KEY (id);


--
-- Name: identity_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT identity_provider_pkey PRIMARY KEY (id);


--
-- Name: identity_provider_providerid_unique; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT identity_provider_providerid_unique UNIQUE (providerid);


--
-- Name: institution_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.institution
    ADD CONSTRAINT institution_pkey PRIMARY KEY (id);


--
-- Name: internal_sso_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.internal_sso
    ADD CONSTRAINT internal_sso_pkey PRIMARY KEY (orcid);


--
-- Name: invalid_record_data_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.invalid_record_data_changes
    ADD CONSTRAINT invalid_record_data_changes_pkey PRIMARY KEY (id);


--
-- Name: notification_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification_item
    ADD CONSTRAINT notification_activity_pkey PRIMARY KEY (id);


--
-- Name: notification_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: notification_work_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification_work
    ADD CONSTRAINT notification_work_pkey PRIMARY KEY (notification_id, work_id);


--
-- Name: oauth2_authoriziation_code_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_authoriziation_code_detail
    ADD CONSTRAINT oauth2_authoriziation_code_detail_pkey PRIMARY KEY (authoriziation_code_value);


--
-- Name: oauth2_token_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_token_detail
    ADD CONSTRAINT oauth2_token_detail_pkey PRIMARY KEY (id);


--
-- Name: oauth2_token_detail_refresh_token_value_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_token_detail
    ADD CONSTRAINT oauth2_token_detail_refresh_token_value_key UNIQUE (refresh_token_value);


--
-- Name: orcidoauth2authoriziationcodedetail_authorities_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcidoauth2authoriziationcodedetail_authorities
    ADD CONSTRAINT orcidoauth2authoriziationcodedetail_authorities_pkey PRIMARY KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value, authorities);


--
-- Name: orcidoauth2authoriziationcodedetail_resourceids_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcidoauth2authoriziationcodedetail_resourceids
    ADD CONSTRAINT orcidoauth2authoriziationcodedetail_resourceids_pkey PRIMARY KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value, resourceids);


--
-- Name: orcidoauth2authoriziationcodedetail_scopes_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcidoauth2authoriziationcodedetail_scopes
    ADD CONSTRAINT orcidoauth2authoriziationcodedetail_scopes_pkey PRIMARY KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value, scopes);


--
-- Name: org_affiliation_relation_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org_affiliation_relation
    ADD CONSTRAINT org_affiliation_relation_pkey PRIMARY KEY (id);


--
-- Name: org_disambiguated_external_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org_disambiguated_external_identifier
    ADD CONSTRAINT org_disambiguated_external_identifier_pkey PRIMARY KEY (id);


--
-- Name: org_disambiguated_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org_disambiguated
    ADD CONSTRAINT org_disambiguated_pkey PRIMARY KEY (id);


--
-- Name: org_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT org_pkey PRIMARY KEY (id);


--
-- Name: org_unique_constraints; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT org_unique_constraints UNIQUE (name, city, region, country, org_disambiguated_id);


--
-- Name: other_name_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.other_name
    ADD CONSTRAINT other_name_pkey PRIMARY KEY (other_name_id);


--
-- Name: patent_contributor_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent_contributor
    ADD CONSTRAINT patent_contributor_pk PRIMARY KEY (patent_contributor_id);


--
-- Name: patent_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent
    ADD CONSTRAINT patent_pkey PRIMARY KEY (patent_id);


--
-- Name: patent_source_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent_source
    ADD CONSTRAINT patent_source_pk PRIMARY KEY (orcid, patent_id, source_orcid);


--
-- Name: peer_review_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.peer_review
    ADD CONSTRAINT peer_review_pkey PRIMARY KEY (id);


--
-- Name: peer_review_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.peer_review_subject
    ADD CONSTRAINT peer_review_subject_pkey PRIMARY KEY (id);


--
-- Name: pk_custom_email; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.custom_email
    ADD CONSTRAINT pk_custom_email PRIMARY KEY (client_details_id, email_type);


--
-- Name: pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: pk_funding_subtype_to_index; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.funding_subtype_to_index
    ADD CONSTRAINT pk_funding_subtype_to_index PRIMARY KEY (orcid, subtype);


--
-- Name: pk_orcid_social; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcid_social
    ADD CONSTRAINT pk_orcid_social PRIMARY KEY (orcid, type);


--
-- Name: primary_profile_institution_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.affiliation
    ADD CONSTRAINT primary_profile_institution_pkey PRIMARY KEY (institution_id, orcid);


--
-- Name: profile_event_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_event
    ADD CONSTRAINT profile_event_pkey PRIMARY KEY (id);


--
-- Name: profile_funding_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_funding
    ADD CONSTRAINT profile_funding_pkey PRIMARY KEY (id);


--
-- Name: profile_keyword_numeric_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_keyword
    ADD CONSTRAINT profile_keyword_numeric_pkey PRIMARY KEY (id);


--
-- Name: profile_patent_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_patent
    ADD CONSTRAINT profile_patent_pk PRIMARY KEY (orcid, patent_id);


--
-- Name: profile_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (orcid);


--
-- Name: profile_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_subject
    ADD CONSTRAINT profile_subject_pkey PRIMARY KEY (profile_orcid, subjects_name);


--
-- Name: record_name_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.record_name
    ADD CONSTRAINT record_name_pkey PRIMARY KEY (id);


--
-- Name: reference_data_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.reference_data
    ADD CONSTRAINT reference_data_pkey PRIMARY KEY (id);


--
-- Name: researcher_url_orcid_client_source_unique_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.researcher_url
    ADD CONSTRAINT researcher_url_orcid_client_source_unique_key UNIQUE (url, orcid, client_source_id);


--
-- Name: researcher_url_orcid_source_unique_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.researcher_url
    ADD CONSTRAINT researcher_url_orcid_source_unique_key UNIQUE (url, orcid, source_id);


--
-- Name: researcher_url_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.researcher_url
    ADD CONSTRAINT researcher_url_pkey PRIMARY KEY (id);


--
-- Name: salesforce_connection_orcid_salesforce_account_id_unique; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.salesforce_connection
    ADD CONSTRAINT salesforce_connection_orcid_salesforce_account_id_unique UNIQUE (orcid, salesforce_account_id);


--
-- Name: salesforce_connection_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.salesforce_connection
    ADD CONSTRAINT salesforce_connection_pkey PRIMARY KEY (id);


--
-- Name: security_question_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.security_question
    ADD CONSTRAINT security_question_pkey PRIMARY KEY (id);


--
-- Name: shibboleth_account_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.shibboleth_account
    ADD CONSTRAINT shibboleth_account_pkey PRIMARY KEY (id);


--
-- Name: shibboleth_account_remote_user_idp_unique; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.shibboleth_account
    ADD CONSTRAINT shibboleth_account_remote_user_idp_unique UNIQUE (remote_user, shib_identity_provider);


--
-- Name: statistic_key_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcid_props
    ADD CONSTRAINT statistic_key_pkey PRIMARY KEY (key);


--
-- Name: subject_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (name);


--
-- Name: unique_external_identifiers_allowing_multiple_sources; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.external_identifier
    ADD CONSTRAINT unique_external_identifiers_allowing_multiple_sources UNIQUE (orcid, external_id_reference, external_id_type, source_id, client_source_id);


--
-- Name: unique_token_value; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_token_detail
    ADD CONSTRAINT unique_token_value UNIQUE (token_value);


--
-- Name: userconnection_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.userconnection
    ADD CONSTRAINT userconnection_pkey PRIMARY KEY (userid, providerid, provideruserid);


--
-- Name: webhook_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.webhook
    ADD CONSTRAINT webhook_pk PRIMARY KEY (orcid, uri);


--
-- Name: work_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.work
    ADD CONSTRAINT work_pkey PRIMARY KEY (work_id);


--
-- Name: address_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX address_orcid_idx ON public.address USING btree (orcid);


--
-- Name: authoriziation_code_value_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX authoriziation_code_value_idx ON public.oauth2_authoriziation_code_detail USING btree (authoriziation_code_value);


--
-- Name: biography_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX biography_orcid_index ON public.biography USING btree (orcid);


--
-- Name: client_authorised_grant_type_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_authorised_grant_type_id_idx ON public.client_authorised_grant_type USING btree (client_details_id, grant_type);


--
-- Name: client_details_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_details_id_idx ON public.client_details USING btree (client_details_id, client_secret);


--
-- Name: client_granted_authority_client_details_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_granted_authority_client_details_id_idx ON public.client_granted_authority USING btree (client_details_id);


--
-- Name: client_granted_authority_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_granted_authority_id_idx ON public.client_granted_authority USING btree (client_details_id, granted_authority);


--
-- Name: client_redirect_uri_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_redirect_uri_id_idx ON public.client_redirect_uri USING btree (client_details_id, redirect_uri);


--
-- Name: client_resource_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_resource_id_idx ON public.client_resource_id USING btree (client_details_id, resource_id);


--
-- Name: client_scope_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_scope_id_idx ON public.client_scope USING btree (client_details_id, scope_type);


--
-- Name: email_event_email_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX email_event_email_idx ON public.email_event USING btree (email);


--
-- Name: external_identifier_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX external_identifier_orcid_idx ON public.external_identifier USING btree (orcid);


--
-- Name: given_permission_to_giver_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX given_permission_to_giver_orcid_idx ON public.given_permission_to USING btree (giver_orcid);


--
-- Name: given_permission_to_receiver_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX given_permission_to_receiver_orcid_idx ON public.given_permission_to USING btree (receiver_orcid);


--
-- Name: granted_authority_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX granted_authority_orcid_idx ON public.granted_authority USING btree (orcid);


--
-- Name: group_id_lowercase_unique_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE UNIQUE INDEX group_id_lowercase_unique_idx ON public.group_id_record USING btree (lower(group_id));


--
-- Name: group_id_record_date_created_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX group_id_record_date_created_idx ON public.group_id_record USING btree (date_created);


--
-- Name: group_id_record_group_type_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX group_id_record_group_type_idx ON public.group_id_record USING btree (group_type);


--
-- Name: internal_sso_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX internal_sso_orcid_idx ON public.internal_sso USING btree (orcid);


--
-- Name: invalid_record_data_changes_date_created_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX invalid_record_data_changes_date_created_index ON public.invalid_record_data_changes USING btree (date_created);


--
-- Name: invalid_record_data_changes_seq_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX invalid_record_data_changes_seq_index ON public.invalid_record_data_changes USING btree (id);


--
-- Name: lower_case_email_unique; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX lower_case_email_unique ON public.email USING btree (lower(email));


--
-- Name: notification_archived_date_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_archived_date_index ON public.notification USING btree (archived_date);


--
-- Name: notification_authentication_provider_id; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_authentication_provider_id ON public.notification USING btree (authentication_provider_id);


--
-- Name: notification_client_source_id; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_client_source_id ON public.notification USING btree (client_source_id);


--
-- Name: notification_date_created_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_date_created_index ON public.notification USING btree (date_created);


--
-- Name: notification_item_notification_id_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_item_notification_id_index ON public.notification_item USING btree (notification_id);


--
-- Name: notification_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_orcid_index ON public.notification USING btree (orcid);


--
-- Name: notification_read_date_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_read_date_index ON public.notification USING btree (read_date);


--
-- Name: notification_sent_date_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_sent_date_index ON public.notification USING btree (sent_date);


--
-- Name: notification_type_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_type_index ON public.notification USING btree (notification_type);


--
-- Name: orcidoauth2authoriziationcodedetail_authoriziation_code_value_i; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX orcidoauth2authoriziationcodedetail_authoriziation_code_value_i ON public.orcidoauth2authoriziationcodedetail_authorities USING btree (orcidoauth2authoriziationcodedetail_authoriziation_code_value);


--
-- Name: orcidoauth2authoriziationcodedetail_resourceids_code_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX orcidoauth2authoriziationcodedetail_resourceids_code_idx ON public.orcidoauth2authoriziationcodedetail_resourceids USING btree (orcidoauth2authoriziationcodedetail_authoriziation_code_value);


--
-- Name: orcidoauth2authoriziationcodedetail_scopes_code_value_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX orcidoauth2authoriziationcodedetail_scopes_code_value_idx ON public.orcidoauth2authoriziationcodedetail_scopes USING btree (orcidoauth2authoriziationcodedetail_authoriziation_code_value);


--
-- Name: org_affiliation_relation_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX org_affiliation_relation_orcid_idx ON public.org_affiliation_relation USING btree (orcid);


--
-- Name: org_disambiguated_source_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX org_disambiguated_source_id_idx ON public.org_disambiguated USING btree (source_id);


--
-- Name: org_disambiguated_source_parent_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX org_disambiguated_source_parent_id_idx ON public.org_disambiguated USING btree (source_parent_id);


--
-- Name: org_disambiguated_source_type_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX org_disambiguated_source_type_idx ON public.org_disambiguated USING btree (source_type);


--
-- Name: other_name_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX other_name_orcid_index ON public.other_name USING btree (orcid);


--
-- Name: peer_review_display_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX peer_review_display_index ON public.peer_review USING btree (display_index);


--
-- Name: peer_review_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX peer_review_orcid_index ON public.peer_review USING btree (orcid);


--
-- Name: primary_profile_institution_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX primary_profile_institution_orcid_idx ON public.affiliation USING btree (orcid);


--
-- Name: profile_funding_display_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_funding_display_index ON public.profile_funding USING btree (display_index);


--
-- Name: profile_funding_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_funding_orcid_index ON public.profile_funding USING btree (orcid);


--
-- Name: profile_funding_org_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_funding_org_id_idx ON public.profile_funding USING btree (org_id);


--
-- Name: profile_group_orcid; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_group_orcid ON public.profile USING btree (group_orcid);


--
-- Name: profile_indexing_status_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_indexing_status_idx ON public.profile USING btree (indexing_status);


--
-- Name: profile_keyword_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_keyword_orcid_idx ON public.profile_keyword USING btree (profile_orcid);


--
-- Name: profile_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_orcid_idx ON public.profile USING btree (orcid);


--
-- Name: profile_orcid_type_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_orcid_type_idx ON public.profile USING btree (orcid_type);


--
-- Name: profile_subject_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_subject_orcid_idx ON public.profile_subject USING btree (profile_orcid);


--
-- Name: record_name_credit_name_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX record_name_credit_name_idx ON public.record_name USING btree (credit_name);


--
-- Name: record_name_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX record_name_orcid_index ON public.record_name USING btree (orcid);


--
-- Name: researcher_url_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX researcher_url_orcid_idx ON public.researcher_url USING btree (orcid);


--
-- Name: salesforce_connection_account_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX salesforce_connection_account_id_idx ON public.salesforce_connection USING btree (salesforce_account_id);


--
-- Name: token_authentication_key_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX token_authentication_key_index ON public.oauth2_token_detail USING btree (authentication_key);


--
-- Name: token_client_details_id_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX token_client_details_id_index ON public.oauth2_token_detail USING btree (client_details_id);


--
-- Name: token_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX token_orcid_index ON public.oauth2_token_detail USING btree (user_orcid);


--
-- Name: userconnectionrank; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX userconnectionrank ON public.userconnection USING btree (userid, providerid, rank);


--
-- Name: work_doi_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX work_doi_idx ON public.work USING btree (public.extract_doi(external_ids_json));


--
-- Name: work_language_code_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX work_language_code_idx ON public.work USING btree (language_code);


--
-- Name: work_orcid_display_index_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX work_orcid_display_index_idx ON public.work USING btree (orcid, display_index);


--
-- Name: work_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX work_orcid_idx ON public.work USING btree (orcid);


--
-- Name: work_translated_title_language_code_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX work_translated_title_language_code_idx ON public.work USING btree (translated_title_language_code);


--
-- Name: address_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: address_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: address_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_source_id_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: biography_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.biography
    ADD CONSTRAINT biography_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: client_details_authorised_grant_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_authorised_grant_type
    ADD CONSTRAINT client_details_authorised_grant_type_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_details_client_granted_authority_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_granted_authority
    ADD CONSTRAINT client_details_client_granted_authority_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_details_group_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_details
    ADD CONSTRAINT client_details_group_orcid_fk FOREIGN KEY (group_orcid) REFERENCES public.profile(orcid);


--
-- Name: client_redirect_uri_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_redirect_uri
    ADD CONSTRAINT client_redirect_uri_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_resource_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_resource_id
    ADD CONSTRAINT client_resource_id_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_scope_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT client_scope_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_secret_client_details_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_secret
    ADD CONSTRAINT client_secret_client_details_id_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id);


--
-- Name: email_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT email_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: email_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT email_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: email_source_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT email_source_orcid_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: external_identifier_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.external_identifier
    ADD CONSTRAINT external_identifier_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: external_identifier_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.external_identifier
    ADD CONSTRAINT external_identifier_source_id_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: fk1d5ccc962d6b1fe4; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_subject
    ADD CONSTRAINT fk1d5ccc962d6b1fe4 FOREIGN KEY (subjects_name) REFERENCES public.subject(name);


--
-- Name: fk1d5ccc9680ddc983; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_subject
    ADD CONSTRAINT fk1d5ccc9680ddc983 FOREIGN KEY (profile_orcid) REFERENCES public.profile(orcid);


--
-- Name: fk3529a5b8e84caef; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.institution
    ADD CONSTRAINT fk3529a5b8e84caef FOREIGN KEY (address_id) REFERENCES public.address(id);


--
-- Name: fk408de65b2007f99; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.affiliation
    ADD CONSTRAINT fk408de65b2007f99 FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: fk408de65cf1a386f; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.affiliation
    ADD CONSTRAINT fk408de65cf1a386f FOREIGN KEY (institution_id) REFERENCES public.institution(id);


--
-- Name: fk5c27955380ddc983; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_keyword
    ADD CONSTRAINT fk5c27955380ddc983 FOREIGN KEY (profile_orcid) REFERENCES public.profile(orcid);


--
-- Name: fk641fe19db2007f99; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.external_identifier
    ADD CONSTRAINT fk641fe19db2007f99 FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: fkd433c438b2007f99; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.researcher_url
    ADD CONSTRAINT fkd433c438b2007f99 FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: fked8e89a96b6f57ec; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT fked8e89a96b6f57ec FOREIGN KEY (security_question_id) REFERENCES public.security_question(id);


--
-- Name: fked8e89a9d6bc0bfe; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT fked8e89a9d6bc0bfe FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: fkf5209e5ab2007f99; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.other_name
    ADD CONSTRAINT fkf5209e5ab2007f99 FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: funding_external_identifiers_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.funding_external_identifier
    ADD CONSTRAINT funding_external_identifiers_fk FOREIGN KEY (profile_funding_id) REFERENCES public.profile_funding(id);


--
-- Name: funding_subtype_to_index_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.funding_subtype_to_index
    ADD CONSTRAINT funding_subtype_to_index_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: giver_orcid_to_profile_orcid; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.given_permission_to
    ADD CONSTRAINT giver_orcid_to_profile_orcid FOREIGN KEY (giver_orcid) REFERENCES public.profile(orcid);


--
-- Name: identity_provider_name_identity_provider_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.identity_provider_name
    ADD CONSTRAINT identity_provider_name_identity_provider_id_fk FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(id);


--
-- Name: keyword_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_keyword
    ADD CONSTRAINT keyword_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: keyword_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_keyword
    ADD CONSTRAINT keyword_source_id_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: member_custom_email_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.custom_email
    ADD CONSTRAINT member_custom_email_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id);


--
-- Name: notification_activity_notification_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification_item
    ADD CONSTRAINT notification_activity_notification_fk FOREIGN KEY (notification_id) REFERENCES public.notification(id);


--
-- Name: notification_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: notification_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: notification_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_source_id_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: notification_work; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification_work
    ADD CONSTRAINT notification_work FOREIGN KEY (work_id) REFERENCES public.work(work_id);


--
-- Name: notification_work_notification_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification_work
    ADD CONSTRAINT notification_work_notification_id_fk FOREIGN KEY (notification_id) REFERENCES public.notification(id);


--
-- Name: oauth2_authoriziation_code_detail_client_details_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_authoriziation_code_detail
    ADD CONSTRAINT oauth2_authoriziation_code_detail_client_details_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: oauth2_authoriziation_code_detail_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_authoriziation_code_detail
    ADD CONSTRAINT oauth2_authoriziation_code_detail_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid) ON DELETE CASCADE;


--
-- Name: oauth2_token_detail_client_details_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_token_detail
    ADD CONSTRAINT oauth2_token_detail_client_details_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id);


--
-- Name: oauth2_token_detail_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_token_detail
    ADD CONSTRAINT oauth2_token_detail_orcid_fk FOREIGN KEY (user_orcid) REFERENCES public.profile(orcid);


--
-- Name: oauth2authoriziationcodedetail_authorities_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcidoauth2authoriziationcodedetail_authorities
    ADD CONSTRAINT oauth2authoriziationcodedetail_authorities_fk FOREIGN KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value) REFERENCES public.oauth2_authoriziation_code_detail(authoriziation_code_value) ON DELETE CASCADE;


--
-- Name: oauth2authoriziationcodedetail_resourceids_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcidoauth2authoriziationcodedetail_resourceids
    ADD CONSTRAINT oauth2authoriziationcodedetail_resourceids_fk FOREIGN KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value) REFERENCES public.oauth2_authoriziation_code_detail(authoriziation_code_value) ON DELETE CASCADE;


--
-- Name: oauth2authoriziationcodedetail_scopes_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcidoauth2authoriziationcodedetail_scopes
    ADD CONSTRAINT oauth2authoriziationcodedetail_scopes_fk FOREIGN KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value) REFERENCES public.oauth2_authoriziation_code_detail(authoriziation_code_value) ON DELETE CASCADE;


--
-- Name: orcid_social_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcid_social
    ADD CONSTRAINT orcid_social_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: org_affiliation_relation_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org_affiliation_relation
    ADD CONSTRAINT org_affiliation_relation_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: org_affiliation_relation_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org_affiliation_relation
    ADD CONSTRAINT org_affiliation_relation_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: org_affiliation_relation_org_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org_affiliation_relation
    ADD CONSTRAINT org_affiliation_relation_org_id_fk FOREIGN KEY (org_id) REFERENCES public.org(id);


--
-- Name: org_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT org_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: org_disambiguated_external_identifier_org_disambiguated_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org_disambiguated_external_identifier
    ADD CONSTRAINT org_disambiguated_external_identifier_org_disambiguated_fk FOREIGN KEY (org_disambiguated_id) REFERENCES public.org_disambiguated(id);


--
-- Name: org_org_disambiguated_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT org_org_disambiguated_fk FOREIGN KEY (org_disambiguated_id) REFERENCES public.org_disambiguated(id);


--
-- Name: other_name_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.other_name
    ADD CONSTRAINT other_name_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: other_name_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.other_name
    ADD CONSTRAINT other_name_source_id_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: patent_contributor_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent_contributor
    ADD CONSTRAINT patent_contributor_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: patent_contributor_patent_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent_contributor
    ADD CONSTRAINT patent_contributor_patent_fk FOREIGN KEY (patent_id) REFERENCES public.patent(patent_id);


--
-- Name: patent_source_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent_source
    ADD CONSTRAINT patent_source_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: patent_source_patent_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent_source
    ADD CONSTRAINT patent_source_patent_fk FOREIGN KEY (patent_id) REFERENCES public.patent(patent_id);


--
-- Name: patent_source_source_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent_source
    ADD CONSTRAINT patent_source_source_orcid_fk FOREIGN KEY (source_orcid) REFERENCES public.profile(orcid);


--
-- Name: peer_review_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.peer_review
    ADD CONSTRAINT peer_review_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: peer_review_org_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.peer_review
    ADD CONSTRAINT peer_review_org_id_fk FOREIGN KEY (org_id) REFERENCES public.org(id);


--
-- Name: profile_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: profile_event_orcid; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_event
    ADD CONSTRAINT profile_event_orcid FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: profile_funding_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_funding
    ADD CONSTRAINT profile_funding_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: profile_funding_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_funding
    ADD CONSTRAINT profile_funding_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: profile_funding_org_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_funding
    ADD CONSTRAINT profile_funding_org_id_fk FOREIGN KEY (org_id) REFERENCES public.org(id);


--
-- Name: profile_patent_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_patent
    ADD CONSTRAINT profile_patent_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: profile_patent_patent_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_patent
    ADD CONSTRAINT profile_patent_patent_fk FOREIGN KEY (patent_id) REFERENCES public.patent(patent_id);


--
-- Name: receiver_orcid_to_profile_orcid; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.given_permission_to
    ADD CONSTRAINT receiver_orcid_to_profile_orcid FOREIGN KEY (receiver_orcid) REFERENCES public.profile(orcid);


--
-- Name: record_name_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.record_name
    ADD CONSTRAINT record_name_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: researcher_url_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.researcher_url
    ADD CONSTRAINT researcher_url_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: researcher_url_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.researcher_url
    ADD CONSTRAINT researcher_url_source_id_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: shibboleth_account_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.shibboleth_account
    ADD CONSTRAINT shibboleth_account_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: webhook_client_details_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.webhook
    ADD CONSTRAINT webhook_client_details_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id);


--
-- Name: webhook_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.webhook
    ADD CONSTRAINT webhook_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: work_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.work
    ADD CONSTRAINT work_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: work_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.work
    ADD CONSTRAINT work_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: work_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.work
    ADD CONSTRAINT work_source_id_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: TABLE address; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.address FROM PUBLIC;
REVOKE ALL ON TABLE public.address FROM orcid;
GRANT ALL ON TABLE public.address TO orcid;
GRANT SELECT ON TABLE public.address TO orcidro;


--
-- Name: TABLE affiliation; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.affiliation FROM PUBLIC;
REVOKE ALL ON TABLE public.affiliation FROM orcid;
GRANT ALL ON TABLE public.affiliation TO orcid;
GRANT SELECT ON TABLE public.affiliation TO orcidro;


--
-- Name: TABLE org; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.org FROM PUBLIC;
REVOKE ALL ON TABLE public.org FROM orcid;
GRANT ALL ON TABLE public.org TO orcid;
GRANT SELECT ON TABLE public.org TO orcidro;


--
-- Name: TABLE org_affiliation_relation; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.org_affiliation_relation FROM PUBLIC;
REVOKE ALL ON TABLE public.org_affiliation_relation FROM orcid;
GRANT ALL ON TABLE public.org_affiliation_relation TO orcid;
GRANT SELECT ON TABLE public.org_affiliation_relation TO orcidro;


--
-- Name: TABLE ambiguous_org; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.ambiguous_org FROM PUBLIC;
REVOKE ALL ON TABLE public.ambiguous_org FROM orcid;
GRANT ALL ON TABLE public.ambiguous_org TO orcid;
GRANT SELECT ON TABLE public.ambiguous_org TO orcidro;


--
-- Name: TABLE biography; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.biography FROM PUBLIC;
REVOKE ALL ON TABLE public.biography FROM orcid;
GRANT ALL ON TABLE public.biography TO orcid;
GRANT SELECT ON TABLE public.biography TO orcidro;


--
-- Name: TABLE client_authorised_grant_type; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.client_authorised_grant_type FROM PUBLIC;
REVOKE ALL ON TABLE public.client_authorised_grant_type FROM orcid;
GRANT ALL ON TABLE public.client_authorised_grant_type TO orcid;
GRANT SELECT ON TABLE public.client_authorised_grant_type TO orcidro;


--
-- Name: TABLE client_details; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.client_details FROM PUBLIC;
REVOKE ALL ON TABLE public.client_details FROM orcid;
GRANT ALL ON TABLE public.client_details TO orcid;
GRANT SELECT ON TABLE public.client_details TO orcidro;


--
-- Name: TABLE client_granted_authority; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.client_granted_authority FROM PUBLIC;
REVOKE ALL ON TABLE public.client_granted_authority FROM orcid;
GRANT ALL ON TABLE public.client_granted_authority TO orcid;
GRANT SELECT ON TABLE public.client_granted_authority TO orcidro;


--
-- Name: TABLE client_redirect_uri; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.client_redirect_uri FROM PUBLIC;
REVOKE ALL ON TABLE public.client_redirect_uri FROM orcid;
GRANT ALL ON TABLE public.client_redirect_uri TO orcid;
GRANT SELECT ON TABLE public.client_redirect_uri TO orcidro;


--
-- Name: TABLE client_resource_id; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.client_resource_id FROM PUBLIC;
REVOKE ALL ON TABLE public.client_resource_id FROM orcid;
GRANT ALL ON TABLE public.client_resource_id TO orcid;
GRANT SELECT ON TABLE public.client_resource_id TO orcidro;


--
-- Name: TABLE client_scope; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.client_scope FROM PUBLIC;
REVOKE ALL ON TABLE public.client_scope FROM orcid;
GRANT ALL ON TABLE public.client_scope TO orcid;
GRANT SELECT ON TABLE public.client_scope TO orcidro;


--
-- Name: TABLE client_secret; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.client_secret FROM PUBLIC;
REVOKE ALL ON TABLE public.client_secret FROM orcid;
GRANT ALL ON TABLE public.client_secret TO orcid;
GRANT SELECT ON TABLE public.client_secret TO orcidro;


--
-- Name: TABLE country_reference_data; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.country_reference_data FROM PUBLIC;
REVOKE ALL ON TABLE public.country_reference_data FROM orcid;
GRANT ALL ON TABLE public.country_reference_data TO orcid;
GRANT SELECT ON TABLE public.country_reference_data TO orcidro;


--
-- Name: TABLE custom_email; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.custom_email FROM PUBLIC;
REVOKE ALL ON TABLE public.custom_email FROM orcid;
GRANT ALL ON TABLE public.custom_email TO orcid;
GRANT SELECT ON TABLE public.custom_email TO orcidro;


--
-- Name: TABLE databasechangelog; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.databasechangelog FROM PUBLIC;
REVOKE ALL ON TABLE public.databasechangelog FROM orcid;
GRANT ALL ON TABLE public.databasechangelog TO orcid;
GRANT SELECT ON TABLE public.databasechangelog TO orcidro;


--
-- Name: TABLE databasechangeloglock; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.databasechangeloglock FROM PUBLIC;
REVOKE ALL ON TABLE public.databasechangeloglock FROM orcid;
GRANT ALL ON TABLE public.databasechangeloglock TO orcid;
GRANT SELECT ON TABLE public.databasechangeloglock TO orcidro;


--
-- Name: TABLE email; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.email FROM PUBLIC;
REVOKE ALL ON TABLE public.email FROM orcid;
GRANT ALL ON TABLE public.email TO orcid;
GRANT SELECT ON TABLE public.email TO orcidro;


--
-- Name: TABLE email_event; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.email_event FROM PUBLIC;
REVOKE ALL ON TABLE public.email_event FROM orcid;
GRANT ALL ON TABLE public.email_event TO orcid;
GRANT SELECT ON TABLE public.email_event TO orcidro;


--
-- Name: TABLE external_identifier; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.external_identifier FROM PUBLIC;
REVOKE ALL ON TABLE public.external_identifier FROM orcid;
GRANT ALL ON TABLE public.external_identifier TO orcid;
GRANT SELECT ON TABLE public.external_identifier TO orcidro;


--
-- Name: TABLE funding_external_identifier; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.funding_external_identifier FROM PUBLIC;
REVOKE ALL ON TABLE public.funding_external_identifier FROM orcid;
GRANT ALL ON TABLE public.funding_external_identifier TO orcid;
GRANT SELECT ON TABLE public.funding_external_identifier TO orcidro;


--
-- Name: TABLE funding_subtype_to_index; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.funding_subtype_to_index FROM PUBLIC;
REVOKE ALL ON TABLE public.funding_subtype_to_index FROM orcid;
GRANT ALL ON TABLE public.funding_subtype_to_index TO orcid;
GRANT SELECT ON TABLE public.funding_subtype_to_index TO orcidro;


--
-- Name: TABLE given_permission_to; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.given_permission_to FROM PUBLIC;
REVOKE ALL ON TABLE public.given_permission_to FROM orcid;
GRANT ALL ON TABLE public.given_permission_to TO orcid;
GRANT SELECT ON TABLE public.given_permission_to TO orcidro;


--
-- Name: TABLE granted_authority; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.granted_authority FROM PUBLIC;
REVOKE ALL ON TABLE public.granted_authority FROM orcid;
GRANT ALL ON TABLE public.granted_authority TO orcid;
GRANT SELECT ON TABLE public.granted_authority TO orcidro;


--
-- Name: TABLE group_id_record; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.group_id_record FROM PUBLIC;
REVOKE ALL ON TABLE public.group_id_record FROM orcid;
GRANT ALL ON TABLE public.group_id_record TO orcid;
GRANT SELECT ON TABLE public.group_id_record TO orcidro;


--
-- Name: TABLE identifier_type; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.identifier_type FROM PUBLIC;
REVOKE ALL ON TABLE public.identifier_type FROM orcid;
GRANT ALL ON TABLE public.identifier_type TO orcid;
GRANT SELECT ON TABLE public.identifier_type TO orcidro;


--
-- Name: TABLE identity_provider; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.identity_provider FROM PUBLIC;
REVOKE ALL ON TABLE public.identity_provider FROM orcid;
GRANT ALL ON TABLE public.identity_provider TO orcid;
GRANT SELECT ON TABLE public.identity_provider TO orcidro;


--
-- Name: TABLE identity_provider_name; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.identity_provider_name FROM PUBLIC;
REVOKE ALL ON TABLE public.identity_provider_name FROM orcid;
GRANT ALL ON TABLE public.identity_provider_name TO orcid;
GRANT SELECT ON TABLE public.identity_provider_name TO orcidro;


--
-- Name: TABLE institution; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.institution FROM PUBLIC;
REVOKE ALL ON TABLE public.institution FROM orcid;
GRANT ALL ON TABLE public.institution TO orcid;
GRANT SELECT ON TABLE public.institution TO orcidro;


--
-- Name: TABLE internal_sso; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.internal_sso FROM PUBLIC;
REVOKE ALL ON TABLE public.internal_sso FROM orcid;
GRANT ALL ON TABLE public.internal_sso TO orcid;
GRANT SELECT ON TABLE public.internal_sso TO orcidro;


--
-- Name: TABLE invalid_record_data_changes; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.invalid_record_data_changes FROM PUBLIC;
REVOKE ALL ON TABLE public.invalid_record_data_changes FROM orcid;
GRANT ALL ON TABLE public.invalid_record_data_changes TO orcid;
GRANT SELECT ON TABLE public.invalid_record_data_changes TO orcidro;


--
-- Name: TABLE notification; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.notification FROM PUBLIC;
REVOKE ALL ON TABLE public.notification FROM orcid;
GRANT ALL ON TABLE public.notification TO orcid;
GRANT SELECT ON TABLE public.notification TO orcidro;


--
-- Name: TABLE notification_item; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.notification_item FROM PUBLIC;
REVOKE ALL ON TABLE public.notification_item FROM orcid;
GRANT ALL ON TABLE public.notification_item TO orcid;
GRANT SELECT ON TABLE public.notification_item TO orcidro;


--
-- Name: TABLE notification_work; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.notification_work FROM PUBLIC;
REVOKE ALL ON TABLE public.notification_work FROM orcid;
GRANT ALL ON TABLE public.notification_work TO orcid;
GRANT SELECT ON TABLE public.notification_work TO orcidro;


--
-- Name: TABLE oauth2_authoriziation_code_detail; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.oauth2_authoriziation_code_detail FROM PUBLIC;
REVOKE ALL ON TABLE public.oauth2_authoriziation_code_detail FROM orcid;
GRANT ALL ON TABLE public.oauth2_authoriziation_code_detail TO orcid;
GRANT SELECT ON TABLE public.oauth2_authoriziation_code_detail TO orcidro;


--
-- Name: TABLE oauth2_token_detail; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.oauth2_token_detail FROM PUBLIC;
REVOKE ALL ON TABLE public.oauth2_token_detail FROM orcid;
GRANT ALL ON TABLE public.oauth2_token_detail TO orcid;
GRANT SELECT ON TABLE public.oauth2_token_detail TO orcidro;


--
-- Name: TABLE orcid_props; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.orcid_props FROM PUBLIC;
REVOKE ALL ON TABLE public.orcid_props FROM orcid;
GRANT ALL ON TABLE public.orcid_props TO orcid;
GRANT SELECT ON TABLE public.orcid_props TO orcidro;


--
-- Name: TABLE orcid_social; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.orcid_social FROM PUBLIC;
REVOKE ALL ON TABLE public.orcid_social FROM orcid;
GRANT ALL ON TABLE public.orcid_social TO orcid;
GRANT SELECT ON TABLE public.orcid_social TO orcidro;


--
-- Name: TABLE orcidoauth2authoriziationcodedetail_authorities; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.orcidoauth2authoriziationcodedetail_authorities FROM PUBLIC;
REVOKE ALL ON TABLE public.orcidoauth2authoriziationcodedetail_authorities FROM orcid;
GRANT ALL ON TABLE public.orcidoauth2authoriziationcodedetail_authorities TO orcid;
GRANT SELECT ON TABLE public.orcidoauth2authoriziationcodedetail_authorities TO orcidro;


--
-- Name: TABLE orcidoauth2authoriziationcodedetail_resourceids; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.orcidoauth2authoriziationcodedetail_resourceids FROM PUBLIC;
REVOKE ALL ON TABLE public.orcidoauth2authoriziationcodedetail_resourceids FROM orcid;
GRANT ALL ON TABLE public.orcidoauth2authoriziationcodedetail_resourceids TO orcid;
GRANT SELECT ON TABLE public.orcidoauth2authoriziationcodedetail_resourceids TO orcidro;


--
-- Name: TABLE orcidoauth2authoriziationcodedetail_scopes; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.orcidoauth2authoriziationcodedetail_scopes FROM PUBLIC;
REVOKE ALL ON TABLE public.orcidoauth2authoriziationcodedetail_scopes FROM orcid;
GRANT ALL ON TABLE public.orcidoauth2authoriziationcodedetail_scopes TO orcid;
GRANT SELECT ON TABLE public.orcidoauth2authoriziationcodedetail_scopes TO orcidro;


--
-- Name: TABLE org_disambiguated; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.org_disambiguated FROM PUBLIC;
REVOKE ALL ON TABLE public.org_disambiguated FROM orcid;
GRANT ALL ON TABLE public.org_disambiguated TO orcid;
GRANT SELECT ON TABLE public.org_disambiguated TO orcidro;


--
-- Name: TABLE org_disambiguated_external_identifier; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.org_disambiguated_external_identifier FROM PUBLIC;
REVOKE ALL ON TABLE public.org_disambiguated_external_identifier FROM orcid;
GRANT ALL ON TABLE public.org_disambiguated_external_identifier TO orcid;
GRANT SELECT ON TABLE public.org_disambiguated_external_identifier TO orcidro;


--
-- Name: TABLE other_name; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.other_name FROM PUBLIC;
REVOKE ALL ON TABLE public.other_name FROM orcid;
GRANT ALL ON TABLE public.other_name TO orcid;
GRANT SELECT ON TABLE public.other_name TO orcidro;


--
-- Name: TABLE patent; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.patent FROM PUBLIC;
REVOKE ALL ON TABLE public.patent FROM orcid;
GRANT ALL ON TABLE public.patent TO orcid;
GRANT SELECT ON TABLE public.patent TO orcidro;


--
-- Name: TABLE patent_contributor; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.patent_contributor FROM PUBLIC;
REVOKE ALL ON TABLE public.patent_contributor FROM orcid;
GRANT ALL ON TABLE public.patent_contributor TO orcid;
GRANT SELECT ON TABLE public.patent_contributor TO orcidro;


--
-- Name: TABLE patent_source; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.patent_source FROM PUBLIC;
REVOKE ALL ON TABLE public.patent_source FROM orcid;
GRANT ALL ON TABLE public.patent_source TO orcid;
GRANT SELECT ON TABLE public.patent_source TO orcidro;


--
-- Name: TABLE peer_review; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.peer_review FROM PUBLIC;
REVOKE ALL ON TABLE public.peer_review FROM orcid;
GRANT ALL ON TABLE public.peer_review TO orcid;
GRANT SELECT ON TABLE public.peer_review TO orcidro;


--
-- Name: TABLE peer_review_subject; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.peer_review_subject FROM PUBLIC;
REVOKE ALL ON TABLE public.peer_review_subject FROM orcid;
GRANT ALL ON TABLE public.peer_review_subject TO orcid;
GRANT SELECT ON TABLE public.peer_review_subject TO orcidro;


--
-- Name: TABLE profile; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.profile FROM PUBLIC;
REVOKE ALL ON TABLE public.profile FROM orcid;
GRANT ALL ON TABLE public.profile TO orcid;
GRANT SELECT ON TABLE public.profile TO orcidro;


--
-- Name: TABLE profile_event; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.profile_event FROM PUBLIC;
REVOKE ALL ON TABLE public.profile_event FROM orcid;
GRANT ALL ON TABLE public.profile_event TO orcid;
GRANT SELECT ON TABLE public.profile_event TO orcidro;


--
-- Name: TABLE profile_funding; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.profile_funding FROM PUBLIC;
REVOKE ALL ON TABLE public.profile_funding FROM orcid;
GRANT ALL ON TABLE public.profile_funding TO orcid;
GRANT SELECT ON TABLE public.profile_funding TO orcidro;


--
-- Name: TABLE profile_keyword; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.profile_keyword FROM PUBLIC;
REVOKE ALL ON TABLE public.profile_keyword FROM orcid;
GRANT ALL ON TABLE public.profile_keyword TO orcid;
GRANT SELECT ON TABLE public.profile_keyword TO orcidro;


--
-- Name: TABLE profile_patent; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.profile_patent FROM PUBLIC;
REVOKE ALL ON TABLE public.profile_patent FROM orcid;
GRANT ALL ON TABLE public.profile_patent TO orcid;
GRANT SELECT ON TABLE public.profile_patent TO orcidro;


--
-- Name: TABLE profile_subject; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.profile_subject FROM PUBLIC;
REVOKE ALL ON TABLE public.profile_subject FROM orcid;
GRANT ALL ON TABLE public.profile_subject TO orcid;
GRANT SELECT ON TABLE public.profile_subject TO orcidro;


--
-- Name: TABLE record_name; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.record_name FROM PUBLIC;
REVOKE ALL ON TABLE public.record_name FROM orcid;
GRANT ALL ON TABLE public.record_name TO orcid;
GRANT SELECT ON TABLE public.record_name TO orcidro;


--
-- Name: TABLE reference_data; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.reference_data FROM PUBLIC;
REVOKE ALL ON TABLE public.reference_data FROM orcid;
GRANT ALL ON TABLE public.reference_data TO orcid;
GRANT SELECT ON TABLE public.reference_data TO orcidro;


--
-- Name: TABLE researcher_url; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.researcher_url FROM PUBLIC;
REVOKE ALL ON TABLE public.researcher_url FROM orcid;
GRANT ALL ON TABLE public.researcher_url TO orcid;
GRANT SELECT ON TABLE public.researcher_url TO orcidro;


--
-- Name: TABLE salesforce_connection; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.salesforce_connection FROM PUBLIC;
REVOKE ALL ON TABLE public.salesforce_connection FROM orcid;
GRANT ALL ON TABLE public.salesforce_connection TO orcid;
GRANT SELECT ON TABLE public.salesforce_connection TO orcidro;


--
-- Name: TABLE security_question; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.security_question FROM PUBLIC;
REVOKE ALL ON TABLE public.security_question FROM orcid;
GRANT ALL ON TABLE public.security_question TO orcid;
GRANT SELECT ON TABLE public.security_question TO orcidro;


--
-- Name: TABLE shibboleth_account; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.shibboleth_account FROM PUBLIC;
REVOKE ALL ON TABLE public.shibboleth_account FROM orcid;
GRANT ALL ON TABLE public.shibboleth_account TO orcid;
GRANT SELECT ON TABLE public.shibboleth_account TO orcidro;


--
-- Name: TABLE subject; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.subject FROM PUBLIC;
REVOKE ALL ON TABLE public.subject FROM orcid;
GRANT ALL ON TABLE public.subject TO orcid;
GRANT SELECT ON TABLE public.subject TO orcidro;


--
-- Name: TABLE userconnection; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.userconnection FROM PUBLIC;
REVOKE ALL ON TABLE public.userconnection FROM orcid;
GRANT ALL ON TABLE public.userconnection TO orcid;
GRANT SELECT ON TABLE public.userconnection TO orcidro;


--
-- Name: TABLE webhook; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.webhook FROM PUBLIC;
REVOKE ALL ON TABLE public.webhook FROM orcid;
GRANT ALL ON TABLE public.webhook TO orcid;
GRANT SELECT ON TABLE public.webhook TO orcidro;


--
-- Name: TABLE work; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.work FROM PUBLIC;
REVOKE ALL ON TABLE public.work FROM orcid;
GRANT ALL ON TABLE public.work TO orcid;
GRANT SELECT ON TABLE public.work TO orcidro;


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.13
-- Dumped by pg_dump version 9.5.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect statistics

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.13
-- Dumped by pg_dump version 9.5.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20)
);


ALTER TABLE public.databasechangelog OWNER TO orcid;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO orcid;

--
-- Name: key_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.key_seq OWNER TO orcid;

--
-- Name: statistic_key; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.statistic_key (
    id bigint NOT NULL,
    generation_date timestamp with time zone
);


ALTER TABLE public.statistic_key OWNER TO orcid;

--
-- Name: statistic_values; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.statistic_values (
    id bigint NOT NULL,
    key_id bigint NOT NULL,
    statistic_name character varying(255),
    statistic_value bigint
);


ALTER TABLE public.statistic_values OWNER TO orcid;

--
-- Name: values_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.values_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.values_seq OWNER TO orcid;

--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase) FROM stdin;
BASE-INSTALL	Angel Montenegro	/db/statistics/install.xml	2017-01-17 22:40:59.370026	1	EXECUTED	7:31ed461caac4f0930d966d39e6786fc0	createTable (x2), addForeignKeyConstraint		\N	3.2.0
CREATE-SEQUENCES	Angel Montenegro	/db/statistics/install.xml	2017-01-17 22:40:59.376265	2	EXECUTED	7:a34c3ac825d40c283fef31cc0b7b372a	createSequence (x2)		\N	3.2.0
add_statistic_values_key_id_index	rcpeters	/db/statistics/add_statistic_values_key_id_index.xml	2017-01-17 22:40:59.378624	3	EXECUTED	7:0ab195e5e4b45d245273785117f735de	sql		\N	3.2.0
GRANT-PERMISSIONS	Angel Montenegro	/db/statistics/grant_read_permissions_to_orcidro.xml	2017-03-29 19:03:18.660686	4	EXECUTED	7:7fe2b129853e90b6d97569431cec27bc	sql (x3)		\N	3.2.0
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Name: key_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.key_seq', 1, true);


--
-- Data for Name: statistic_key; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.statistic_key (id, generation_date) FROM stdin;
1	2017-11-30 22:55:01.135+00
\.


--
-- Data for Name: statistic_values; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.statistic_values (id, key_id, statistic_name, statistic_value) FROM stdin;
1	1	idsWithVerifiedEmail	4
2	1	funding	3
3	1	works	3
4	1	education	6
5	1	employmentUniqueOrg	1
6	1	peerReview	0
7	1	idsWithEducation	5
8	1	employment	3
9	1	idsWithPersonId	10
10	1	uniqueDois	1
11	1	educationUniqueOrg	4
12	1	idsWithWorks	3
13	1	liveIds	13
14	1	idsWithPeerReview	0
15	1	idsWithExternalId	10
16	1	personId	13
17	1	fundingUniqueOrg	1
18	1	idsWithEmployment	3
19	1	idsWithFunding	3
\.


--
-- Name: values_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.values_seq', 19, true);


--
-- Name: pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: statistic_key_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.statistic_key
    ADD CONSTRAINT statistic_key_pkey PRIMARY KEY (id);


--
-- Name: statistic_values_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.statistic_values
    ADD CONSTRAINT statistic_values_pkey PRIMARY KEY (id);


--
-- Name: statistic_values_key_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX statistic_values_key_id_idx ON public.statistic_values USING btree (key_id);


--
-- Name: fk9bb60ebf14b94af; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.statistic_values
    ADD CONSTRAINT fk9bb60ebf14b94af FOREIGN KEY (key_id) REFERENCES public.statistic_key(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: TABLE statistic_key; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.statistic_key FROM PUBLIC;
REVOKE ALL ON TABLE public.statistic_key FROM orcid;
GRANT ALL ON TABLE public.statistic_key TO orcid;
GRANT SELECT ON TABLE public.statistic_key TO orcidro;


--
-- Name: TABLE statistic_values; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE public.statistic_values FROM PUBLIC;
REVOKE ALL ON TABLE public.statistic_values FROM orcid;
GRANT ALL ON TABLE public.statistic_values TO orcid;
GRANT SELECT ON TABLE public.statistic_values TO orcidro;


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.13
-- Dumped by pg_dump version 9.5.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\connect test1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.13
-- Dumped by pg_dump version 9.5.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: persons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persons (
    personid integer,
    lastname character varying(255),
    firstname character varying(255),
    address character varying(255),
    city character varying(255)
);


ALTER TABLE public.persons OWNER TO postgres;

--
-- Data for Name: persons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.persons (personid, lastname, firstname, address, city) FROM stdin;
\.


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

