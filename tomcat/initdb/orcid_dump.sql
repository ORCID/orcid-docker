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
--CREATE ROLE postgres;
--ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
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

-- Dumped from database version 9.5.10
-- Dumped by pg_dump version 9.5.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
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


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: togglz; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE togglz (
    feature_name character varying(100) NOT NULL,
    feature_enabled integer,
    strategy_id character varying(200),
    strategy_params character varying(2000)
);


ALTER TABLE togglz OWNER TO orcid;

--
-- Data for Name: togglz; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY togglz (feature_name, feature_enabled, strategy_id, strategy_params) FROM stdin;
\.


--
-- Name: togglz_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY togglz
    ADD CONSTRAINT togglz_pkey PRIMARY KEY (feature_name);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
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

-- Dumped from database version 9.5.10
-- Dumped by pg_dump version 9.5.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
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
-- Name: public; Type: ACL; Schema: -; Owner: postgres
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

-- Dumped from database version 9.5.10
-- Dumped by pg_dump version 9.5.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
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


SET search_path = public, pg_catalog;

--
-- Name: org_disambiguated_descendent; Type: TYPE; Schema: public; Owner: orcid
--

CREATE TYPE org_disambiguated_descendent AS (
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


ALTER TYPE org_disambiguated_descendent OWNER TO orcid;

--
-- Name: extract_doi(json); Type: FUNCTION; Schema: public; Owner: orcid
--

CREATE FUNCTION extract_doi(json) RETURNS character varying
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

CREATE FUNCTION find_org_disambiguated_descendents(source_id character varying, source_type character varying) RETURNS SETOF org_disambiguated_descendent
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT * FROM find_org_disambiguated_descendents(source_id, source_type, 1)
ORDER BY level, source_parent_id, name;
$$;


ALTER FUNCTION public.find_org_disambiguated_descendents(source_id character varying, source_type character varying) OWNER TO orcid;

--
-- Name: find_org_disambiguated_descendents(character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: orcid
--

CREATE FUNCTION find_org_disambiguated_descendents(required_source_id character varying, required_source_type character varying, current_level integer) RETURNS SETOF org_disambiguated_descendent
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

CREATE FUNCTION insert_scope_for_premium_members(scope_to_add character varying) RETURNS void
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

CREATE FUNCTION json_intext(text) RETURNS json
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT json_in($1::cstring);
$_$;


ALTER FUNCTION public.json_intext(text) OWNER TO orcid;

--
-- Name: set_sequence_starts(); Type: FUNCTION; Schema: public; Owner: orcid
--

CREATE FUNCTION set_sequence_starts() RETURNS void
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

CREATE FUNCTION unix_timestamp(timestamp with time zone) RETURNS double precision
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT EXTRACT(epoch FROM $1) $_$;


ALTER FUNCTION public.unix_timestamp(timestamp with time zone) OWNER TO orcid;

SET search_path = pg_catalog;

--
-- Name: CAST (character varying AS json); Type: CAST; Schema: pg_catalog; Owner: 
--

CREATE CAST (character varying AS json) WITH FUNCTION public.json_intext(text) AS IMPLICIT;


SET search_path = public, pg_catalog;

--
-- Name: access_token_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE access_token_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE access_token_seq OWNER TO orcid;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: address; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE address (
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


ALTER TABLE address OWNER TO orcid;

--
-- Name: address_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE address_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE address_seq OWNER TO orcid;

--
-- Name: affiliation; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE affiliation (
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


ALTER TABLE affiliation OWNER TO orcid;

--
-- Name: org; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE org (
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


ALTER TABLE org OWNER TO orcid;

--
-- Name: org_affiliation_relation; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE org_affiliation_relation (
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


ALTER TABLE org_affiliation_relation OWNER TO orcid;

--
-- Name: ambiguous_org; Type: VIEW; Schema: public; Owner: orcid
--

CREATE VIEW ambiguous_org AS
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
   FROM (org o
     LEFT JOIN org_affiliation_relation oar ON ((oar.org_id = o.id)))
  WHERE (o.org_disambiguated_id IS NULL)
  GROUP BY o.id, o.name, o.city, o.region, o.country, o.url, o.source_id, o.date_created, o.last_modified;


ALTER TABLE ambiguous_org OWNER TO orcid;

--
-- Name: author_other_name_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE author_other_name_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE author_other_name_seq OWNER TO orcid;

--
-- Name: backup_code; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE backup_code (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    orcid character varying(19) NOT NULL,
    used_date timestamp with time zone,
    hashed_code character varying(255)
);


ALTER TABLE backup_code OWNER TO orcid;

--
-- Name: backup_code_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE backup_code_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE backup_code_seq OWNER TO orcid;

--
-- Name: biography; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE biography (
    id bigint NOT NULL,
    orcid character varying(255) NOT NULL,
    biography text,
    visibility character varying(20),
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE biography OWNER TO orcid;

--
-- Name: biography_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE biography_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE biography_seq OWNER TO orcid;

--
-- Name: client_authorised_grant_type; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE client_authorised_grant_type (
    client_details_id character varying(150) NOT NULL,
    grant_type character varying(150) NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE client_authorised_grant_type OWNER TO orcid;

--
-- Name: client_details; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE client_details (
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


ALTER TABLE client_details OWNER TO orcid;

--
-- Name: client_granted_authority; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE client_granted_authority (
    client_details_id character varying(150) NOT NULL,
    granted_authority character varying(150) NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE client_granted_authority OWNER TO orcid;

--
-- Name: client_redirect_uri; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE client_redirect_uri (
    client_details_id character varying(150) NOT NULL,
    redirect_uri text NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    predefined_client_redirect_scope text,
    redirect_uri_type text DEFAULT 'default'::character varying NOT NULL,
    uri_act_type json DEFAULT '{"import-works-wizard" : ["Articles"]}'::json,
    uri_geo_area json DEFAULT '{"import-works-wizard" : ["Global"]}'::json
);


ALTER TABLE client_redirect_uri OWNER TO orcid;

--
-- Name: client_resource_id; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE client_resource_id (
    client_details_id character varying(150) NOT NULL,
    resource_id character varying(175) NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE client_resource_id OWNER TO orcid;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE client_scope (
    client_details_id character varying(150) NOT NULL,
    scope_type character varying(150) NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE client_scope OWNER TO orcid;

--
-- Name: client_secret; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE client_secret (
    client_details_id character varying(255) NOT NULL,
    client_secret character varying(150) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    last_modified timestamp with time zone NOT NULL,
    is_primary boolean DEFAULT true
);


ALTER TABLE client_secret OWNER TO orcid;

--
-- Name: country_reference_data; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE country_reference_data (
    country_iso_code character varying(2) NOT NULL,
    country_name character varying(255),
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE country_reference_data OWNER TO orcid;

--
-- Name: custom_email; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE custom_email (
    client_details_id character varying(255) NOT NULL,
    email_type character varying(255) NOT NULL,
    content text NOT NULL,
    sender text,
    subject text,
    is_html boolean DEFAULT false,
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE custom_email OWNER TO orcid;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE databasechangelog (
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


ALTER TABLE databasechangelog OWNER TO orcid;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE databasechangeloglock OWNER TO orcid;

--
-- Name: email; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE email (
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    email text NOT NULL,
    orcid character varying(255) NOT NULL,
    visibility character varying(20) DEFAULT 'PRIVATE'::character varying NOT NULL,
    is_primary boolean DEFAULT true NOT NULL,
    is_current boolean DEFAULT true NOT NULL,
    is_verified boolean DEFAULT false NOT NULL,
    source_id character varying(255),
    client_source_id character varying(20)
);


ALTER TABLE email OWNER TO orcid;

--
-- Name: email_event; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE email_event (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    email text NOT NULL,
    email_event_type character varying(255) NOT NULL
);


ALTER TABLE email_event OWNER TO orcid;

--
-- Name: email_event_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE email_event_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE email_event_seq OWNER TO orcid;

--
-- Name: external_identifier; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE external_identifier (
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


ALTER TABLE external_identifier OWNER TO orcid;

--
-- Name: external_identifier_id_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE external_identifier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE external_identifier_id_seq OWNER TO orcid;

--
-- Name: external_identifier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: orcid
--

ALTER SEQUENCE external_identifier_id_seq OWNED BY external_identifier.id;


--
-- Name: funding_external_identifier; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE funding_external_identifier (
    funding_external_identifier_id bigint NOT NULL,
    profile_funding_id bigint NOT NULL,
    ext_type character varying(255),
    ext_value character varying(2084),
    ext_url character varying(350),
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE funding_external_identifier OWNER TO orcid;

--
-- Name: funding_external_identifier_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE funding_external_identifier_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE funding_external_identifier_seq OWNER TO orcid;

--
-- Name: funding_subtype_to_index; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE funding_subtype_to_index (
    orcid character varying(255) NOT NULL,
    subtype text NOT NULL
);


ALTER TABLE funding_subtype_to_index OWNER TO orcid;

--
-- Name: given_permission_to; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE given_permission_to (
    receiver_orcid character varying(19) NOT NULL,
    giver_orcid character varying(19) NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    approval_date timestamp with time zone,
    given_permission_to_id bigint NOT NULL
);


ALTER TABLE given_permission_to OWNER TO orcid;

--
-- Name: given_permission_to_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE given_permission_to_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE given_permission_to_seq OWNER TO orcid;

--
-- Name: grant_contributor_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE grant_contributor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE grant_contributor_seq OWNER TO orcid;

--
-- Name: grant_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE grant_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE grant_seq OWNER TO orcid;

--
-- Name: granted_authority; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE granted_authority (
    authority character varying(255) NOT NULL,
    orcid character varying(255) NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE granted_authority OWNER TO orcid;

--
-- Name: group_id_record; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE group_id_record (
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


ALTER TABLE group_id_record OWNER TO orcid;

--
-- Name: group_id_record_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE group_id_record_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE group_id_record_seq OWNER TO orcid;

--
-- Name: identifier_type; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE identifier_type (
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


ALTER TABLE identifier_type OWNER TO orcid;

--
-- Name: identifier_type_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE identifier_type_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE identifier_type_seq OWNER TO orcid;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE identity_provider (
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


ALTER TABLE identity_provider OWNER TO orcid;

--
-- Name: identity_provider_name; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE identity_provider_name (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    identity_provider_id bigint,
    display_name text,
    lang text
);


ALTER TABLE identity_provider_name OWNER TO orcid;

--
-- Name: identity_provider_name_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE identity_provider_name_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE identity_provider_name_seq OWNER TO orcid;

--
-- Name: identity_provider_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE identity_provider_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE identity_provider_seq OWNER TO orcid;

--
-- Name: institution; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE institution (
    id bigint NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    institution_name character varying(350),
    address_id bigint
);


ALTER TABLE institution OWNER TO orcid;

--
-- Name: institution_department_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE institution_department_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE institution_department_seq OWNER TO orcid;

--
-- Name: institution_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE institution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE institution_seq OWNER TO orcid;

--
-- Name: internal_sso; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE internal_sso (
    orcid character varying(19) NOT NULL,
    token character varying(60) NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE internal_sso OWNER TO orcid;

--
-- Name: invalid_record_change_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE invalid_record_change_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE invalid_record_change_seq OWNER TO orcid;

--
-- Name: invalid_record_data_changes; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE invalid_record_data_changes (
    sql_used_to_update text NOT NULL,
    description text NOT NULL,
    num_changed bigint NOT NULL,
    type text NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    id bigint DEFAULT nextval('invalid_record_change_seq'::regclass) NOT NULL
);


ALTER TABLE invalid_record_data_changes OWNER TO orcid;

--
-- Name: keyword_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE keyword_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE keyword_seq OWNER TO orcid;

--
-- Name: notification; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE notification (
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


ALTER TABLE notification OWNER TO orcid;

--
-- Name: notification_item; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE notification_item (
    id bigint NOT NULL,
    notification_id bigint,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    item_type text,
    item_name text,
    external_id_type text,
    external_id_value text
);


ALTER TABLE notification_item OWNER TO orcid;

--
-- Name: notification_item_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE notification_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notification_item_seq OWNER TO orcid;

--
-- Name: notification_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE notification_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notification_seq OWNER TO orcid;

--
-- Name: notification_work; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE notification_work (
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    notification_id bigint NOT NULL,
    work_id bigint NOT NULL
);


ALTER TABLE notification_work OWNER TO orcid;

--
-- Name: oauth2_authoriziation_code_detail; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE oauth2_authoriziation_code_detail (
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


ALTER TABLE oauth2_authoriziation_code_detail OWNER TO orcid;

--
-- Name: oauth2_token_detail; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE oauth2_token_detail (
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
    id bigint DEFAULT nextval('access_token_seq'::regclass) NOT NULL,
    refresh_token_expiration timestamp without time zone,
    refresh_token_value character varying(150),
    token_disabled boolean DEFAULT false,
    persistent boolean DEFAULT false,
    version bigint DEFAULT '0'::bigint,
    authorization_code character varying(255),
    revocation_date timestamp with time zone,
    revoke_reason character varying(30)
);


ALTER TABLE oauth2_token_detail OWNER TO orcid;

--
-- Name: orcid_props; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE orcid_props (
    key character varying(255) NOT NULL,
    prop_value text,
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE orcid_props OWNER TO orcid;

--
-- Name: orcid_social; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE orcid_social (
    orcid character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    encrypted_credentials text NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    last_run timestamp with time zone
);


ALTER TABLE orcid_social OWNER TO orcid;

--
-- Name: orcidoauth2authoriziationcodedetail_authorities; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE orcidoauth2authoriziationcodedetail_authorities (
    orcidoauth2authoriziationcodedetail_authoriziation_code_value character varying(255) NOT NULL,
    authorities character varying(255) NOT NULL
);


ALTER TABLE orcidoauth2authoriziationcodedetail_authorities OWNER TO orcid;

--
-- Name: orcidoauth2authoriziationcodedetail_resourceids; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE orcidoauth2authoriziationcodedetail_resourceids (
    orcidoauth2authoriziationcodedetail_authoriziation_code_value character varying(255) NOT NULL,
    resourceids character varying(255) NOT NULL
);


ALTER TABLE orcidoauth2authoriziationcodedetail_resourceids OWNER TO orcid;

--
-- Name: orcidoauth2authoriziationcodedetail_scopes; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE orcidoauth2authoriziationcodedetail_scopes (
    orcidoauth2authoriziationcodedetail_authoriziation_code_value character varying(255) NOT NULL,
    scopes character varying(255) NOT NULL
);


ALTER TABLE orcidoauth2authoriziationcodedetail_scopes OWNER TO orcid;

--
-- Name: org_affiliation_relation_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE org_affiliation_relation_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE org_affiliation_relation_seq OWNER TO orcid;

--
-- Name: org_disambiguated; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE org_disambiguated (
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


ALTER TABLE org_disambiguated OWNER TO orcid;

--
-- Name: org_disambiguated_external_identifier; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE org_disambiguated_external_identifier (
    id bigint NOT NULL,
    org_disambiguated_id bigint,
    identifier character varying(4000),
    identifier_type character varying(4000),
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    preferred boolean DEFAULT false
);


ALTER TABLE org_disambiguated_external_identifier OWNER TO orcid;

--
-- Name: org_disambiguated_external_identifier_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE org_disambiguated_external_identifier_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE org_disambiguated_external_identifier_seq OWNER TO orcid;

--
-- Name: org_disambiguated_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE org_disambiguated_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE org_disambiguated_seq OWNER TO orcid;

--
-- Name: org_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE org_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE org_seq OWNER TO orcid;

--
-- Name: other_name; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE other_name (
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


ALTER TABLE other_name OWNER TO orcid;

--
-- Name: other_name_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE other_name_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE other_name_seq OWNER TO orcid;

--
-- Name: patent; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE patent (
    patent_id bigint NOT NULL,
    issuing_country character varying(155),
    patent_no character varying(60),
    short_description character varying(550),
    issue_date date,
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE patent OWNER TO orcid;

--
-- Name: patent_contributor; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE patent_contributor (
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


ALTER TABLE patent_contributor OWNER TO orcid;

--
-- Name: patent_contributor_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE patent_contributor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE patent_contributor_seq OWNER TO orcid;

--
-- Name: patent_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE patent_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE patent_seq OWNER TO orcid;

--
-- Name: patent_source; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE patent_source (
    orcid character varying(19) NOT NULL,
    patent_id bigint NOT NULL,
    source_orcid character varying(19) NOT NULL,
    deposited_date date,
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE patent_source OWNER TO orcid;

--
-- Name: peer_review; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE peer_review (
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


ALTER TABLE peer_review OWNER TO orcid;

--
-- Name: peer_review_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE peer_review_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE peer_review_seq OWNER TO orcid;

--
-- Name: peer_review_subject; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE peer_review_subject (
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


ALTER TABLE peer_review_subject OWNER TO orcid;

--
-- Name: peer_review_subject_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE peer_review_subject_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE peer_review_subject_seq OWNER TO orcid;

--
-- Name: profile; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE profile (
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


ALTER TABLE profile OWNER TO orcid;

--
-- Name: profile_event; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE profile_event (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    orcid character varying(19) NOT NULL,
    profile_event_type character varying(255) NOT NULL,
    comment text
);


ALTER TABLE profile_event OWNER TO orcid;

--
-- Name: profile_event_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE profile_event_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE profile_event_seq OWNER TO orcid;

--
-- Name: profile_funding; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE profile_funding (
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


ALTER TABLE profile_funding OWNER TO orcid;

--
-- Name: profile_funding_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE profile_funding_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE profile_funding_seq OWNER TO orcid;

--
-- Name: profile_keyword; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE profile_keyword (
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


ALTER TABLE profile_keyword OWNER TO orcid;

--
-- Name: profile_patent; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE profile_patent (
    orcid character varying(19) NOT NULL,
    patent_id bigint NOT NULL,
    added_to_profile_date date,
    visibility character varying(20),
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE profile_patent OWNER TO orcid;

--
-- Name: profile_subject; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE profile_subject (
    profile_orcid character varying(19) NOT NULL,
    subjects_name character varying(255) NOT NULL
);


ALTER TABLE profile_subject OWNER TO orcid;

--
-- Name: record_name; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE record_name (
    id bigint NOT NULL,
    orcid character varying(255) NOT NULL,
    credit_name text,
    family_name text,
    given_names text,
    visibility character varying(20),
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE record_name OWNER TO orcid;

--
-- Name: record_name_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE record_name_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE record_name_seq OWNER TO orcid;

--
-- Name: reference_data; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE reference_data (
    id bigint NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    ref_data_key character varying(255),
    ref_data_value character varying(255)
);


ALTER TABLE reference_data OWNER TO orcid;

--
-- Name: reference_data_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE reference_data_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reference_data_seq OWNER TO orcid;

--
-- Name: related_url_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE related_url_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE related_url_seq OWNER TO orcid;

--
-- Name: researcher_url_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE researcher_url_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE researcher_url_seq OWNER TO orcid;

--
-- Name: researcher_url; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE researcher_url (
    url text NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    orcid character varying(19) NOT NULL,
    id bigint DEFAULT nextval('researcher_url_seq'::regclass) NOT NULL,
    url_name text,
    visibility character varying(19),
    source_id character varying(19),
    client_source_id character varying(20),
    display_index bigint DEFAULT 0
);


ALTER TABLE researcher_url OWNER TO orcid;

--
-- Name: salesforce_connection; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE salesforce_connection (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    orcid character varying(19) NOT NULL,
    email text NOT NULL,
    salesforce_account_id text NOT NULL,
    is_primary boolean DEFAULT true NOT NULL
);


ALTER TABLE salesforce_connection OWNER TO orcid;

--
-- Name: salesforce_connection_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE salesforce_connection_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE salesforce_connection_seq OWNER TO orcid;

--
-- Name: security_question; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE security_question (
    id integer NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone,
    question character varying(255),
    key character varying(100)
);


ALTER TABLE security_question OWNER TO orcid;

--
-- Name: shibboleth_account; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE shibboleth_account (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    orcid character varying(19) NOT NULL,
    remote_user text NOT NULL,
    shib_identity_provider text NOT NULL
);


ALTER TABLE shibboleth_account OWNER TO orcid;

--
-- Name: shibboleth_account_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE shibboleth_account_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE shibboleth_account_seq OWNER TO orcid;

--
-- Name: subject; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE subject (
    name text NOT NULL,
    date_created timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE subject OWNER TO orcid;

--
-- Name: userconnection; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE userconnection (
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


ALTER TABLE userconnection OWNER TO orcid;

--
-- Name: webhook; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE webhook (
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


ALTER TABLE webhook OWNER TO orcid;

--
-- Name: work; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE work (
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


ALTER TABLE work OWNER TO orcid;

--
-- Name: work_contributor_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE work_contributor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE work_contributor_seq OWNER TO orcid;

--
-- Name: work_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE work_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE work_seq OWNER TO orcid;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY external_identifier ALTER COLUMN id SET DEFAULT nextval('external_identifier_id_seq'::regclass);


--
-- Name: access_token_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('access_token_seq', 1622, true);


--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY address (id, date_created, last_modified, address_line_1, address_line_2, city, postal_code, state_or_province, orcid, is_primary, iso2_country, visibility, source_id, client_source_id, display_index) FROM stdin;
1006	2017-02-17 17:57:14.527	2017-02-17 17:57:14.627	\N	\N	\N	\N	\N	0000-0003-0814-7181	f	US	PRIVATE	\N	APP-9999999999999901	0
1007	2017-02-17 17:57:15.958	2017-02-17 17:57:15.971	\N	\N	\N	\N	\N	0000-0003-0484-9215	f	CR	PRIVATE	\N	APP-9999999999999901	0
1008	2017-02-17 21:16:39.4	2017-02-17 21:16:39.417	\N	\N	\N	\N	\N	0000-0001-9790-3588	f	CR	PRIVATE	\N	\N	0
1009	2017-02-17 21:24:18.994	2017-02-17 21:24:19.082	\N	\N	\N	\N	\N	0000-0001-5754-535X	f	US	PRIVATE	\N	APP-9999999999999901	0
1010	2017-02-17 21:24:21.774	2017-02-17 21:24:21.783	\N	\N	\N	\N	\N	0000-0003-3224-7983	f	CR	PRIVATE	\N	APP-9999999999999901	0
1018	2017-06-13 16:07:51.549	2017-06-13 16:07:51.587	\N	\N	\N	\N	\N	0000-0003-0660-9960	f	CR	PRIVATE	\N	APP-9999999999999901	0
1019	2017-06-13 16:17:10.507	2017-06-13 16:17:10.523	\N	\N	\N	\N	\N	0000-0002-5200-4316	f	CR	PRIVATE	\N	APP-9999999999999901	0
1020	2017-06-13 16:20:04.293	2017-06-13 16:20:04.335	\N	\N	\N	\N	\N	0000-0002-4676-8168	f	US	PRIVATE	\N	APP-9999999999999901	0
1021	2017-06-13 16:20:49.761	2017-06-13 16:20:49.769	\N	\N	\N	\N	\N	0000-0001-7758-4663	f	CR	PRIVATE	\N	APP-9999999999999901	0
\.


--
-- Name: address_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('address_seq', 1029, true);


--
-- Data for Name: affiliation; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY affiliation (institution_id, orcid, date_created, last_modified, role_title, start_date, affiliation_details_visibility, end_date, affiliation_type, department_name, affiliation_address_visibility) FROM stdin;
\.


--
-- Name: author_other_name_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('author_other_name_seq', 1000, true);


--
-- Data for Name: backup_code; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY backup_code (id, date_created, last_modified, orcid, used_date, hashed_code) FROM stdin;
\.


--
-- Name: backup_code_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('backup_code_seq', 1, false);


--
-- Data for Name: biography; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY biography (id, orcid, biography, visibility, date_created, last_modified) FROM stdin;
1003	9999-0000-0000-0001	\N	PUBLIC	2017-01-18 21:10:40.953+00	2017-01-18 21:10:40.953+00
1000	9999-0000-0000-000X	This is my bio	PUBLIC	2017-01-18 21:10:39.576+00	2017-02-17 16:54:02.651129+00
1002	9999-0000-0000-0005	This is the bio for User Two	PUBLIC	2017-01-18 21:10:40.616+00	2017-02-17 16:54:12.709655+00
1009	0000-0003-0814-7181	Lets test some crazy stuff! How about a 1000 chars in japanese 難フドょ三点93隊は比埼回へ美宝投トしレ手採シ領馬公ノネ氏細ケロウヌ係入ヲハヌヱ厚院ひゃお川的ばぴイぎ言提オサ所熱サ自通をぶちス後筆本在親も。仕退ニレト由界フぱし庫越トメキホ来転を半別どば鈴内ト全41秀かゅや果物心マオル討赤モナマフ参月スどこや座念コソ言社ぐ食理ラセ対演ぎの変理かラ広暮クスネテ上進傑ゆくス。16要べ南聖ウチサ認府ネ長悪たやふ能住とぜべ王是にど新断切年セテ不紀つドょ歳県オスニ質38碁れ容57雑スネモ老泉シヘヒ関裕よはラク更記兆ムタワラ投困ゅんぜ治木ぞほ細通ウヤ年覧ト運現ざイたね冊7績よゆ暮誉ソサト投46軽ロ終時イ必迫の触勇囲速ぐイす。特なイりド通結ま鳥寄育ぼべく拶奈拳ナコ回書マク道月スどばせ社的ケ探尽タエホ枝力トル害地べっ治電は際材ヨ別断ツカウ文国ラヒ応治ぴぶ戦75収否禁辞4帝おだあへ平悪由ごと禁者ヒワコタ長強ふて見際まをづ質相抽綱もえ。卓側68点宇どのゆ式長実52染な憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコ憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコ憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコv憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコ憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコ人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだ	PRIVATE	2017-02-17 17:57:14.634+00	2017-02-17 17:57:14.634+00
1010	0000-0003-0484-9215	biography	PRIVATE	2017-02-17 17:57:15.977+00	2017-02-17 17:57:15.977+00
1011	0000-0001-9790-3588	biography	PRIVATE	2017-02-17 21:16:39.422+00	2017-02-17 21:16:39.422+00
1012	0000-0001-5754-535X	Lets test some crazy stuff! How about a 1000 chars in japanese 難フドょ三点93隊は比埼回へ美宝投トしレ手採シ領馬公ノネ氏細ケロウヌ係入ヲハヌヱ厚院ひゃお川的ばぴイぎ言提オサ所熱サ自通をぶちス後筆本在親も。仕退ニレト由界フぱし庫越トメキホ来転を半別どば鈴内ト全41秀かゅや果物心マオル討赤モナマフ参月スどこや座念コソ言社ぐ食理ラセ対演ぎの変理かラ広暮クスネテ上進傑ゆくス。16要べ南聖ウチサ認府ネ長悪たやふ能住とぜべ王是にど新断切年セテ不紀つドょ歳県オスニ質38碁れ容57雑スネモ老泉シヘヒ関裕よはラク更記兆ムタワラ投困ゅんぜ治木ぞほ細通ウヤ年覧ト運現ざイたね冊7績よゆ暮誉ソサト投46軽ロ終時イ必迫の触勇囲速ぐイす。特なイりド通結ま鳥寄育ぼべく拶奈拳ナコ回書マク道月スどばせ社的ケ探尽タエホ枝力トル害地べっ治電は際材ヨ別断ツカウ文国ラヒ応治ぴぶ戦75収否禁辞4帝おだあへ平悪由ごと禁者ヒワコタ長強ふて見際まをづ質相抽綱もえ。卓側68点宇どのゆ式長実52染な憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコ憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコ憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコv憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコ憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコ人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだ	PRIVATE	2017-02-17 21:24:19.087+00	2017-02-17 21:24:19.087+00
1013	0000-0003-3224-7983	biography	PRIVATE	2017-02-17 21:24:21.786+00	2017-02-17 21:24:21.786+00
1014	0000-0003-0660-9960	biography	PRIVATE	2017-06-13 16:07:51.646+00	2017-06-13 16:07:51.646+00
1015	0000-0002-5200-4316	biography	PRIVATE	2017-06-13 16:17:10.527+00	2017-06-13 16:17:10.527+00
1016	0000-0002-4676-8168	Lets test some crazy stuff! How about a 1000 chars in japanese 難フドょ三点93隊は比埼回へ美宝投トしレ手採シ領馬公ノネ氏細ケロウヌ係入ヲハヌヱ厚院ひゃお川的ばぴイぎ言提オサ所熱サ自通をぶちス後筆本在親も。仕退ニレト由界フぱし庫越トメキホ来転を半別どば鈴内ト全41秀かゅや果物心マオル討赤モナマフ参月スどこや座念コソ言社ぐ食理ラセ対演ぎの変理かラ広暮クスネテ上進傑ゆくス。16要べ南聖ウチサ認府ネ長悪たやふ能住とぜべ王是にど新断切年セテ不紀つドょ歳県オスニ質38碁れ容57雑スネモ老泉シヘヒ関裕よはラク更記兆ムタワラ投困ゅんぜ治木ぞほ細通ウヤ年覧ト運現ざイたね冊7績よゆ暮誉ソサト投46軽ロ終時イ必迫の触勇囲速ぐイす。特なイりド通結ま鳥寄育ぼべく拶奈拳ナコ回書マク道月スどばせ社的ケ探尽タエホ枝力トル害地べっ治電は際材ヨ別断ツカウ文国ラヒ応治ぴぶ戦75収否禁辞4帝おだあへ平悪由ごと禁者ヒワコタ長強ふて見際まをづ質相抽綱もえ。卓側68点宇どのゆ式長実52染な憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコ憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコ憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコv憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコ憶オ調浄もゆ高京セハヘミ世曄タニ合東らね約環リ理聞話学ほ心褒ぼどばこ補禁球かを運人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだて野重探がそょ会上ミヘ社69点ルラコ人ねの判言ネツユタ級投とそらぜ辺罪サ放唱セ請月試セツヲリ票監笑怠殊ぼスお。断きだ	PRIVATE	2017-06-13 16:20:04.34+00	2017-06-13 16:20:04.34+00
1017	0000-0001-7758-4663	biography	PRIVATE	2017-06-13 16:20:49.771+00	2017-06-13 16:20:49.771+00
1001	9999-0000-0000-0004	This is the bio for User One	PUBLIC	2017-01-18 21:10:40.252+00	2017-06-13 16:36:19.767673+00
\.


--
-- Name: biography_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('biography_seq', 1017, true);


--
-- Data for Name: client_authorised_grant_type; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY client_authorised_grant_type (client_details_id, grant_type, date_created, last_modified) FROM stdin;
APP-9999999999999903	refresh_token	2017-01-18 21:10:41.027	2017-01-18 21:10:41.027
APP-9999999999999903	client_credentials	2017-01-18 21:10:41.028	2017-01-18 21:10:41.028
APP-9999999999999903	authorization_code	2017-01-18 21:10:41.028	2017-01-18 21:10:41.028
APP-9999999999999901	authorization_code	2017-01-18 21:10:41.072	2017-01-18 21:10:41.072
APP-9999999999999901	client_credentials	2017-01-18 21:10:41.072	2017-01-18 21:10:41.072
APP-9999999999999901	refresh_token	2017-01-18 21:10:41.072	2017-01-18 21:10:41.072
APP-9999999999999902	authorization_code	2017-01-18 21:10:41.141	2017-01-18 21:10:41.141
APP-9999999999999902	refresh_token	2017-01-18 21:10:41.141	2017-01-18 21:10:41.141
APP-9999999999999902	client_credentials	2017-01-18 21:10:41.142	2017-01-18 21:10:41.142
\.


--
-- Data for Name: client_details; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY client_details (client_details_id, client_secret, date_created, last_modified, client_name, webhooks_enabled, client_description, client_website, persistent_tokens_enabled, group_orcid, client_type, authentication_provider_id, email_access_reason, allow_auto_deprecate) FROM stdin;
APP-9999999999999903	\N	2017-01-18 21:10:41.027	2017-01-18 21:10:41.027	Public client - Fastest's Elephant	t	Public Client APP-9999999999999903 Description	http://orcid.org	t	9999-0000-0000-0004	PUBLIC_CLIENT	\N	\N	t
APP-9999999999999901	\N	2017-01-18 21:10:41.071	2017-01-18 21:10:41.071	Client APP-9999999999999901 - Fastest's Elephant	t	Client APP-9999999999999901 Description	http://orcid.org	t	9999-0000-0000-0001	PREMIUM_CREATOR	\N	\N	t
APP-9999999999999902	\N	2017-01-18 21:10:41.139	2017-02-17 16:54:13.776178	Client APP-9999999999999902 	t	Client APP-9999999999999902 Description	http://orcid.org	f	9999-0000-0000-0001	PREMIUM_CREATOR	\N	\N	t
\.


--
-- Data for Name: client_granted_authority; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY client_granted_authority (client_details_id, granted_authority, date_created, last_modified) FROM stdin;
APP-9999999999999903	ROLE_CLIENT	2017-01-18 21:10:41.029	2017-01-18 21:10:41.029
APP-9999999999999901	ROLE_CLIENT	2017-01-18 21:10:41.072	2017-01-18 21:10:41.072
APP-9999999999999902	ROLE_CLIENT	2017-01-18 21:10:41.142	2017-01-18 21:10:41.142
\.


--
-- Data for Name: client_redirect_uri; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY client_redirect_uri (client_details_id, redirect_uri, date_created, last_modified, predefined_client_redirect_scope, redirect_uri_type, uri_act_type, uri_geo_area) FROM stdin;
APP-9999999999999903	https://localhost:8443/orcid-web/oauth/playground	2017-01-18 21:10:41.029	2017-01-18 21:10:41.029	\N	sso-authentication	\N	\N
APP-9999999999999901	https://localhost:8443/orcid-web/oauth/playground	2017-01-18 21:10:41.073	2017-01-18 21:10:41.073	\N	default	\N	\N
APP-9999999999999902	https://localhost:8443/orcid-web/oauth/playground	2017-01-18 21:10:41.142	2017-01-18 21:10:41.142	\N	default	\N	\N
\.


--
-- Data for Name: client_resource_id; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY client_resource_id (client_details_id, resource_id, date_created, last_modified) FROM stdin;
APP-9999999999999903	orcid	2017-01-18 21:10:41.029	2017-01-18 21:10:41.029
APP-9999999999999901	orcid	2017-01-18 21:10:41.074	2017-01-18 21:10:41.074
APP-9999999999999902	orcid	2017-01-18 21:10:41.142	2017-01-18 21:10:41.142
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY client_scope (client_details_id, scope_type, date_created, last_modified) FROM stdin;
APP-9999999999999903	/funding/create	2017-01-18 21:10:41.029	2017-01-18 21:10:41.029
APP-9999999999999903	/affiliations/read-limited	2017-01-18 21:10:41.029	2017-01-18 21:10:41.029
APP-9999999999999903	/activities/update	2017-01-18 21:10:41.031	2017-01-18 21:10:41.031
APP-9999999999999903	/orcid-works/update	2017-01-18 21:10:41.032	2017-01-18 21:10:41.032
APP-9999999999999903	/person/read-limited	2017-01-18 21:10:41.032	2017-01-18 21:10:41.032
APP-9999999999999903	/orcid-profile/create	2017-01-18 21:10:41.032	2017-01-18 21:10:41.032
APP-9999999999999903	/orcid-profile/read-limited	2017-01-18 21:10:41.033	2017-01-18 21:10:41.033
APP-9999999999999903	/affiliations/update	2017-01-18 21:10:41.033	2017-01-18 21:10:41.033
APP-9999999999999903	/webhook	2017-01-18 21:10:41.033	2017-01-18 21:10:41.033
APP-9999999999999903	/group-id-record/update	2017-01-18 21:10:41.033	2017-01-18 21:10:41.033
APP-9999999999999903	/person/update	2017-01-18 21:10:41.033	2017-01-18 21:10:41.033
APP-9999999999999903	/premium-notification	2017-01-18 21:10:41.034	2017-01-18 21:10:41.034
APP-9999999999999903	/group-id-record/read	2017-01-18 21:10:41.034	2017-01-18 21:10:41.034
APP-9999999999999903	/activities/read-limited	2017-01-18 21:10:41.034	2017-01-18 21:10:41.034
APP-9999999999999903	/orcid-patents/read-limited	2017-01-18 21:10:41.034	2017-01-18 21:10:41.034
APP-9999999999999903	/peer-review/create	2017-01-18 21:10:41.034	2017-01-18 21:10:41.034
APP-9999999999999903	/authenticate	2017-01-18 21:10:41.035	2017-01-18 21:10:41.035
APP-9999999999999903	/orcid-bio/update	2017-01-18 21:10:41.035	2017-01-18 21:10:41.035
APP-9999999999999903	/funding/read-limited	2017-01-18 21:10:41.035	2017-01-18 21:10:41.035
APP-9999999999999903	/read-public	2017-01-18 21:10:41.035	2017-01-18 21:10:41.035
APP-9999999999999903	/orcid-patents/create	2017-01-18 21:10:41.035	2017-01-18 21:10:41.035
APP-9999999999999903	/orcid-works/read-limited	2017-01-18 21:10:41.035	2017-01-18 21:10:41.035
APP-9999999999999903	/orcid-bio/read-limited	2017-01-18 21:10:41.035	2017-01-18 21:10:41.035
APP-9999999999999903	/read-limited	2017-01-18 21:10:41.035	2017-01-18 21:10:41.035
APP-9999999999999903	/funding/update	2017-01-18 21:10:41.035	2017-01-18 21:10:41.035
APP-9999999999999903	/orcid-patents/update	2017-01-18 21:10:41.036	2017-01-18 21:10:41.036
APP-9999999999999903	/peer-review/update	2017-01-18 21:10:41.036	2017-01-18 21:10:41.036
APP-9999999999999903	/orcid-works/create	2017-01-18 21:10:41.036	2017-01-18 21:10:41.036
APP-9999999999999903	/affiliations/create	2017-01-18 21:10:41.036	2017-01-18 21:10:41.036
APP-9999999999999903	/peer-review/read-limited	2017-01-18 21:10:41.036	2017-01-18 21:10:41.036
APP-9999999999999903	/orcid-bio/external-identifiers/create	2017-01-18 21:10:41.039	2017-01-18 21:10:41.039
APP-9999999999999901	/orcid-works/update	2017-01-18 21:10:41.074	2017-01-18 21:10:41.074
APP-9999999999999901	/orcid-patents/create	2017-01-18 21:10:41.074	2017-01-18 21:10:41.074
APP-9999999999999901	/orcid-patents/update	2017-01-18 21:10:41.074	2017-01-18 21:10:41.074
APP-9999999999999901	/person/update	2017-01-18 21:10:41.074	2017-01-18 21:10:41.074
APP-9999999999999901	/person/read-limited	2017-01-18 21:10:41.074	2017-01-18 21:10:41.074
APP-9999999999999901	/activities/read-limited	2017-01-18 21:10:41.074	2017-01-18 21:10:41.074
APP-9999999999999901	/orcid-internal/person/last_modified	2017-01-18 21:10:41.075	2017-01-18 21:10:41.075
APP-9999999999999901	/affiliations/update	2017-01-18 21:10:41.075	2017-01-18 21:10:41.075
APP-9999999999999901	/orcid-works/read-limited	2017-01-18 21:10:41.075	2017-01-18 21:10:41.075
APP-9999999999999901	/activities/update	2017-01-18 21:10:41.075	2017-01-18 21:10:41.075
APP-9999999999999901	/peer-review/update	2017-01-18 21:10:41.075	2017-01-18 21:10:41.075
APP-9999999999999901	/group-id-record/read	2017-01-18 21:10:41.075	2017-01-18 21:10:41.075
APP-9999999999999901	/premium-notification	2017-01-18 21:10:41.075	2017-01-18 21:10:41.075
APP-9999999999999901	/peer-review/read-limited	2017-01-18 21:10:41.075	2017-01-18 21:10:41.075
APP-9999999999999901	/orcid-works/create	2017-01-18 21:10:41.075	2017-01-18 21:10:41.075
APP-9999999999999901	/orcid-bio/read-limited	2017-01-18 21:10:41.075	2017-01-18 21:10:41.075
APP-9999999999999901	/webhook	2017-01-18 21:10:41.075	2017-01-18 21:10:41.075
APP-9999999999999901	/funding/update	2017-01-18 21:10:41.076	2017-01-18 21:10:41.076
APP-9999999999999901	/read-limited	2017-01-18 21:10:41.076	2017-01-18 21:10:41.076
APP-9999999999999901	/authenticate	2017-01-18 21:10:41.076	2017-01-18 21:10:41.076
APP-9999999999999901	/read-public	2017-01-18 21:10:41.076	2017-01-18 21:10:41.076
APP-9999999999999901	/peer-review/create	2017-01-18 21:10:41.076	2017-01-18 21:10:41.076
APP-9999999999999901	/funding/create	2017-01-18 21:10:41.076	2017-01-18 21:10:41.076
APP-9999999999999901	/orcid-profile/read-limited	2017-01-18 21:10:41.076	2017-01-18 21:10:41.076
APP-9999999999999901	/orcid-bio/update	2017-01-18 21:10:41.076	2017-01-18 21:10:41.076
APP-9999999999999901	/group-id-record/update	2017-01-18 21:10:41.077	2017-01-18 21:10:41.077
APP-9999999999999901	/affiliations/create	2017-01-18 21:10:41.077	2017-01-18 21:10:41.077
APP-9999999999999901	/orcid-bio/external-identifiers/create	2017-01-18 21:10:41.077	2017-01-18 21:10:41.077
APP-9999999999999901	/orcid-profile/create	2017-01-18 21:10:41.077	2017-01-18 21:10:41.077
APP-9999999999999901	/orcid-patents/read-limited	2017-01-18 21:10:41.077	2017-01-18 21:10:41.077
APP-9999999999999901	/funding/read-limited	2017-01-18 21:10:41.077	2017-01-18 21:10:41.077
APP-9999999999999901	/affiliations/read-limited	2017-01-18 21:10:41.077	2017-01-18 21:10:41.077
APP-9999999999999902	/funding/update	2017-01-18 21:10:41.142	2017-01-18 21:10:41.142
APP-9999999999999902	/affiliations/read-limited	2017-01-18 21:10:41.143	2017-01-18 21:10:41.143
APP-9999999999999902	/affiliations/create	2017-01-18 21:10:41.143	2017-01-18 21:10:41.143
APP-9999999999999902	/peer-review/read-limited	2017-01-18 21:10:41.143	2017-01-18 21:10:41.143
APP-9999999999999902	/orcid-profile/create	2017-01-18 21:10:41.143	2017-01-18 21:10:41.143
APP-9999999999999902	/read-public	2017-01-18 21:10:41.143	2017-01-18 21:10:41.143
APP-9999999999999902	/orcid-works/update	2017-01-18 21:10:41.143	2017-01-18 21:10:41.143
APP-9999999999999902	/activities/update	2017-01-18 21:10:41.144	2017-01-18 21:10:41.144
APP-9999999999999902	/authenticate	2017-01-18 21:10:41.144	2017-01-18 21:10:41.144
APP-9999999999999902	/orcid-bio/read-limited	2017-01-18 21:10:41.144	2017-01-18 21:10:41.144
APP-9999999999999902	/person/read-limited	2017-01-18 21:10:41.144	2017-01-18 21:10:41.144
APP-9999999999999902	/activities/read-limited	2017-01-18 21:10:41.144	2017-01-18 21:10:41.144
APP-9999999999999902	/peer-review/create	2017-01-18 21:10:41.144	2017-01-18 21:10:41.144
APP-9999999999999902	/orcid-bio/update	2017-01-18 21:10:41.145	2017-01-18 21:10:41.145
APP-9999999999999902	/affiliations/update	2017-01-18 21:10:41.145	2017-01-18 21:10:41.145
APP-9999999999999902	/group-id-record/read	2017-01-18 21:10:41.145	2017-01-18 21:10:41.145
APP-9999999999999902	/peer-review/update	2017-01-18 21:10:41.145	2017-01-18 21:10:41.145
APP-9999999999999902	/orcid-patents/create	2017-01-18 21:10:41.145	2017-01-18 21:10:41.145
APP-9999999999999902	/orcid-patents/update	2017-01-18 21:10:41.145	2017-01-18 21:10:41.145
APP-9999999999999902	/funding/read-limited	2017-01-18 21:10:41.145	2017-01-18 21:10:41.145
APP-9999999999999902	/funding/create	2017-01-18 21:10:41.145	2017-01-18 21:10:41.145
APP-9999999999999902	/premium-notification	2017-01-18 21:10:41.146	2017-01-18 21:10:41.146
APP-9999999999999902	/person/update	2017-01-18 21:10:41.146	2017-01-18 21:10:41.146
APP-9999999999999902	/group-id-record/update	2017-01-18 21:10:41.146	2017-01-18 21:10:41.146
APP-9999999999999902	/orcid-bio/external-identifiers/create	2017-01-18 21:10:41.146	2017-01-18 21:10:41.146
APP-9999999999999902	/orcid-profile/read-limited	2017-01-18 21:10:41.146	2017-01-18 21:10:41.146
APP-9999999999999902	/webhook	2017-01-18 21:10:41.146	2017-01-18 21:10:41.146
APP-9999999999999902	/orcid-patents/read-limited	2017-01-18 21:10:41.147	2017-01-18 21:10:41.147
APP-9999999999999902	/read-limited	2017-01-18 21:10:41.147	2017-01-18 21:10:41.147
APP-9999999999999902	/orcid-works/read-limited	2017-01-18 21:10:41.147	2017-01-18 21:10:41.147
APP-9999999999999902	/orcid-works/create	2017-01-18 21:10:41.147	2017-01-18 21:10:41.147
\.


--
-- Data for Name: client_secret; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY client_secret (client_details_id, client_secret, date_created, last_modified, is_primary) FROM stdin;
APP-9999999999999903	+d0SwZ16NN7TEuhs+eCl/3p/2eHs7cWg	2017-01-18 21:10:41.039+00	2017-01-18 21:10:41.039+00	t
APP-9999999999999901	VcuZOB6lHy0kzWMKERzJJj6qVIYxdMQx	2017-01-18 21:10:41.077+00	2017-01-18 21:10:41.077+00	t
APP-9999999999999902	99wUMJsPddSkWmkVXcsfR9oI2JYTvsHk	2017-01-18 21:10:41.147+00	2017-01-18 21:10:41.147+00	t
\.


--
-- Data for Name: country_reference_data; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY country_reference_data (country_iso_code, country_name, date_created, last_modified) FROM stdin;
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

COPY custom_email (client_details_id, email_type, content, sender, subject, is_html, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase) FROM stdin;
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
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: email; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY email (date_created, last_modified, email, orcid, visibility, is_primary, is_current, is_verified, source_id, client_source_id) FROM stdin;
2017-01-18 21:10:39.576+00	2017-01-18 21:10:39.576+00	admin@test.orcid.org	9999-0000-0000-000X	PUBLIC	t	t	t	\N	\N
2017-01-18 21:10:40.616+00	2017-01-18 21:10:40.616+00	user_2@test.orcid.org	9999-0000-0000-0005	PUBLIC	t	t	t	\N	\N
2017-01-18 21:10:40.953+00	2017-01-18 21:10:40.953+00	premium_member_1@test.orcid.org	9999-0000-0000-0001	PUBLIC	t	t	t	\N	\N
2017-02-17 17:57:14.628+00	2017-02-17 17:57:14.628+00	1487354234172_test@test.orcid.org	0000-0003-0814-7181	PRIVATE	t	t	f	\N	APP-9999999999999901
2017-02-17 17:57:15.972+00	2017-02-17 17:57:15.972+00	1487354235909_test@test.orcid.org	0000-0003-0484-9215	PRIVATE	t	t	f	\N	APP-9999999999999901
2017-02-17 21:16:39.419+00	2017-02-17 21:16:39.419+00	1487366198895@api.com	0000-0001-9790-3588	PRIVATE	t	t	f	\N	\N
2017-02-17 21:24:19.083+00	2017-02-17 21:24:19.083+00	1487366658858_test@test.orcid.org	0000-0001-5754-535X	PRIVATE	t	t	f	\N	APP-9999999999999901
2017-02-17 21:24:21.784+00	2017-02-17 21:24:21.784+00	1487366661694_test@test.orcid.org	0000-0003-3224-7983	PRIVATE	t	t	f	\N	APP-9999999999999901
2017-06-13 16:07:51.592+00	2017-06-13 16:07:51.592+00	1497370070956@api.com	0000-0003-0660-9960	PRIVATE	t	t	f	\N	APP-9999999999999901
2017-06-13 16:17:10.524+00	2017-06-13 16:17:10.524+00	1497370630397_test@test.orcid.org	0000-0002-5200-4316	PRIVATE	t	t	f	\N	APP-9999999999999901
2017-06-13 16:20:04.335+00	2017-06-13 16:20:04.335+00	1497370804191_test@test.orcid.org	0000-0002-4676-8168	PRIVATE	t	t	f	\N	APP-9999999999999901
2017-06-13 16:20:49.769+00	2017-06-13 16:20:49.769+00	1497370849715_test@test.orcid.org	0000-0001-7758-4663	PRIVATE	t	t	f	\N	APP-9999999999999901
2017-01-18 21:10:40.251+00	2017-01-18 21:10:40.251+00	user_1@test.orcid.org	9999-0000-0000-0004	PUBLIC	t	t	t	\N	\N
2017-02-17 18:03:10.697827+00	2017-02-17 18:03:10.697827+00	limited@test.orcid.org	9999-0000-0000-0004	LIMITED	f	t	f	9999-0000-0000-0004	\N
2017-02-17 18:25:46.390067+00	2017-02-17 18:25:46.390067+00	added.email.1487355946033@test.com	9999-0000-0000-0004	PRIVATE	f	t	f	9999-0000-0000-0004	\N
2017-02-17 18:26:48.577107+00	2017-02-17 18:26:48.577107+00	added.email.1487356006077@test.com	9999-0000-0000-0004	PRIVATE	f	t	f	9999-0000-0000-0004	\N
\.


--
-- Data for Name: email_event; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY email_event (id, date_created, last_modified, email, email_event_type) FROM stdin;
1003	2017-11-30 23:10:14.291+00	2017-11-30 23:10:14.291+00	limited@test.orcid.org	VERIFY_EMAIL_TOO_OLD
1004	2017-11-30 23:10:16.026+00	2017-11-30 23:10:16.026+00	added.email.1487355946033@test.com	VERIFY_EMAIL_TOO_OLD
1005	2017-11-30 23:10:19.173+00	2017-11-30 23:10:19.173+00	added.email.1487356006077@test.com	VERIFY_EMAIL_TOO_OLD
\.


--
-- Name: email_event_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('email_event_seq', 1005, true);


--
-- Data for Name: external_identifier; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY external_identifier (date_created, last_modified, orcid, external_id_reference, external_id_type, external_id_url, source_id, client_source_id, id, visibility, display_index) FROM stdin;
2017-02-17 17:57:14.628	2017-02-17 17:57:14.628	0000-0003-0814-7181	extId#1	extId#1	http://orcid.org/extId#1	\N	APP-9999999999999901	14	PRIVATE	1
2017-02-17 17:57:14.629	2017-02-17 17:57:14.629	0000-0003-0814-7181	extId#2	extId#2	http://orcid.org/extId#2	\N	APP-9999999999999901	15	PRIVATE	0
2017-02-17 17:57:15.973	2017-02-17 17:57:15.973	0000-0003-0484-9215	extId#1	extId#1	http://orcid.org/extId#1	\N	APP-9999999999999901	16	PRIVATE	0
2017-02-17 21:16:39.419	2017-02-17 21:16:39.419	0000-0001-9790-3588	extId#1	extId#1	http://orcid.org/extId#1	\N	\N	24	PRIVATE	0
2017-02-17 21:24:19.083	2017-02-17 21:24:19.083	0000-0001-5754-535X	extId#1	extId#1	http://orcid.org/extId#1	\N	APP-9999999999999901	26	PRIVATE	1
2017-02-17 21:24:19.083	2017-02-17 21:24:19.083	0000-0001-5754-535X	extId#2	extId#2	http://orcid.org/extId#2	\N	APP-9999999999999901	27	PRIVATE	0
2017-02-17 21:24:21.784	2017-02-17 21:24:21.784	0000-0003-3224-7983	extId#1	extId#1	http://orcid.org/extId#1	\N	APP-9999999999999901	28	PRIVATE	0
2017-06-13 16:07:51.592	2017-06-13 16:07:51.592	0000-0003-0660-9960	extId#1	extId#1	http://orcid.org/extId#1	\N	APP-9999999999999901	38	PRIVATE	0
2017-06-13 16:17:10.524	2017-06-13 16:17:10.524	0000-0002-5200-4316	extId#1	extId#1	http://orcid.org/extId#1	\N	APP-9999999999999901	39	PRIVATE	0
2017-06-13 16:20:04.335	2017-06-13 16:20:04.335	0000-0002-4676-8168	extId#1	extId#1	http://orcid.org/extId#1	\N	APP-9999999999999901	41	PRIVATE	1
2017-06-13 16:20:04.336	2017-06-13 16:20:04.336	0000-0002-4676-8168	extId#2	extId#2	http://orcid.org/extId#2	\N	APP-9999999999999901	42	PRIVATE	0
2017-06-13 16:20:49.769	2017-06-13 16:20:49.769	0000-0001-7758-4663	extId#1	extId#1	http://orcid.org/extId#1	\N	APP-9999999999999901	43	PRIVATE	0
2017-06-13 16:48:11.085	2017-06-13 16:48:35.467	9999-0000-0000-0004	added-ext-id-1497372490928	test	http://test.orcid.org	\N	APP-9999999999999901	53	PUBLIC	1
\.


--
-- Name: external_identifier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('external_identifier_id_seq', 53, true);


--
-- Data for Name: funding_external_identifier; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY funding_external_identifier (funding_external_identifier_id, profile_funding_id, ext_type, ext_value, ext_url, date_created, last_modified) FROM stdin;
\.


--
-- Name: funding_external_identifier_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('funding_external_identifier_seq', 1000, true);


--
-- Data for Name: funding_subtype_to_index; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY funding_subtype_to_index (orcid, subtype) FROM stdin;
\.


--
-- Data for Name: given_permission_to; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY given_permission_to (receiver_orcid, giver_orcid, date_created, last_modified, approval_date, given_permission_to_id) FROM stdin;
\.


--
-- Name: given_permission_to_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('given_permission_to_seq', 1003, true);


--
-- Name: grant_contributor_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('grant_contributor_seq', 1000, true);


--
-- Name: grant_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('grant_seq', 1000, true);


--
-- Data for Name: granted_authority; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY granted_authority (authority, orcid, date_created, last_modified) FROM stdin;
ROLE_ADMIN	9999-0000-0000-000X	2017-01-18 21:10:39.574	2017-01-18 21:10:39.574
ROLE_USER	9999-0000-0000-0004	2017-01-18 21:10:40.251	2017-01-18 21:10:40.251
ROLE_USER	9999-0000-0000-0005	2017-01-18 21:10:40.614	2017-01-18 21:10:40.614
ROLE_PREMIUM_INSTITUTION	9999-0000-0000-0001	2017-01-18 21:10:40.952	2017-01-18 21:10:40.952
ROLE_USER	0000-0003-0814-7181	2017-02-17 17:57:14.628	2017-02-17 17:57:14.628
ROLE_USER	0000-0003-0484-9215	2017-02-17 17:57:15.972	2017-02-17 17:57:15.972
ROLE_USER	0000-0001-9790-3588	2017-02-17 21:16:39.419	2017-02-17 21:16:39.419
ROLE_USER	0000-0001-5754-535X	2017-02-17 21:24:19.082	2017-02-17 21:24:19.082
ROLE_USER	0000-0003-3224-7983	2017-02-17 21:24:21.784	2017-02-17 21:24:21.784
ROLE_USER	0000-0003-0660-9960	2017-06-13 16:07:51.589	2017-06-13 16:07:51.589
ROLE_USER	0000-0002-5200-4316	2017-06-13 16:17:10.523	2017-06-13 16:17:10.523
ROLE_USER	0000-0002-4676-8168	2017-06-13 16:20:04.335	2017-06-13 16:20:04.335
ROLE_USER	0000-0001-7758-4663	2017-06-13 16:20:49.769	2017-06-13 16:20:49.769
\.


--
-- Data for Name: group_id_record; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY group_id_record (id, group_id, group_name, group_description, group_type, source_id, client_source_id, date_created, last_modified) FROM stdin;
1000	orcid-generated:011484876640080	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-01-20 01:44:00.27+00	2017-01-20 01:44:00.27+00
1001	orcid-generated:021484876640080	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-01-20 01:44:00.577+00	2017-01-20 01:44:00.577+00
1002	orcid-generated:011484876744651	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-01-20 01:45:44.693+00	2017-01-20 01:45:44.693+00
1003	orcid-generated:021484876744651	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-01-20 01:45:44.747+00	2017-01-20 01:45:44.747+00
1004	orcid-generated:011484876932380	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-01-20 01:48:52.402+00	2017-01-20 01:48:52.402+00
1005	orcid-generated:021484876932380	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-01-20 01:48:52.418+00	2017-01-20 01:48:52.418+00
1006	orcid-generated:011484876952465	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-01-20 01:49:12.693+00	2017-01-20 01:49:12.693+00
1007	orcid-generated:021484876952465	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-01-20 01:49:12.708+00	2017-01-20 01:49:12.708+00
1008	orcid-generated:011484877070347	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-01-20 01:51:10.453+00	2017-01-20 01:51:10.453+00
1009	orcid-generated:021484877070347	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-01-20 01:51:10.516+00	2017-01-20 01:51:10.516+00
1010	orcid-generated:011484877175622	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-01-20 01:52:55.819+00	2017-01-20 01:52:55.819+00
1011	orcid-generated:021484877175622	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-01-20 01:52:55.833+00	2017-01-20 01:52:55.833+00
1012	orcid-generated:011484877204468	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-01-20 01:53:24.496+00	2017-01-20 01:53:24.496+00
1013	orcid-generated:021484877204468	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-01-20 01:53:24.509+00	2017-01-20 01:53:24.509+00
1091	orcid-generated:011484878506107	Group # 1 - 1484878506107	Description	publisher	\N	APP-9999999999999901	2017-01-20 02:15:06.123+00	2017-01-20 02:15:06.123+00
1092	orcid-generated:011487354314970	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-02-17 17:58:35.129+00	2017-02-17 17:58:35.129+00
1093	orcid-generated:021487354314970	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-02-17 17:58:35.174+00	2017-02-17 17:58:35.174+00
1094	orcid-generated:011487356164545	Group # 1 - 1487356164545	Description	publisher	\N	APP-9999999999999901	2017-02-17 18:29:24.577+00	2017-02-17 18:29:24.577+00
1095	orcid-generated:011487366677278	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:24:37.322+00	2017-02-17 21:24:37.322+00
1096	orcid-generated:021487366677278	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:24:37.347+00	2017-02-17 21:24:37.347+00
1097	orcid-generated:011487366752201	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:25:52.22+00	2017-02-17 21:25:52.22+00
1098	orcid-generated:021487366752201	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:25:52.237+00	2017-02-17 21:25:52.237+00
1099	orcid-generated:011487366877308	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:27:57.36+00	2017-02-17 21:27:57.36+00
1100	orcid-generated:021487366877308	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:27:57.38+00	2017-02-17 21:27:57.38+00
1101	orcid-generated:011487366926498	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:28:46.653+00	2017-02-17 21:28:46.653+00
1102	orcid-generated:021487366926498	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:28:46.667+00	2017-02-17 21:28:46.667+00
1103	orcid-generated:011487367027729	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:30:28.168+00	2017-02-17 21:30:28.168+00
1104	orcid-generated:021487367027729	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:30:28.232+00	2017-02-17 21:30:28.232+00
1105	orcid-generated:011487367128138	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:32:08.309+00	2017-02-17 21:32:08.309+00
1106	orcid-generated:021487367128138	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:32:08.322+00	2017-02-17 21:32:08.322+00
1107	orcid-generated:011487367154020	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:32:34.041+00	2017-02-17 21:32:34.041+00
1108	orcid-generated:021487367154020	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:32:34.054+00	2017-02-17 21:32:34.054+00
1186	orcid-generated:011487368237626	Group # 1 - 1487368237626	Description	publisher	\N	APP-9999999999999901	2017-02-17 21:50:37.643+00	2017-02-17 21:50:37.643+00
1187	orcid-generated:011497370894827	Group # 1	Description	publisher	\N	APP-9999999999999901	2017-06-13 16:21:35.17+00	2017-06-13 16:21:35.17+00
1188	orcid-generated:021497370894827	Group # 2	Description	publisher	\N	APP-9999999999999901	2017-06-13 16:21:35.207+00	2017-06-13 16:21:35.207+00
1246	orcid-generated:test#1497371457254	orcid-generated:test#1497371457254	Description	publisher	\N	APP-9999999999999901	2017-06-13 16:30:57.268+00	2017-06-13 16:30:57.268+00
\.


--
-- Name: group_id_record_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('group_id_record_seq', 1284, true);


--
-- Data for Name: identifier_type; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY identifier_type (id, id_name, id_validation_regex, id_resolution_prefix, id_deprecated, client_source_id, date_created, last_modified, primary_use, case_sensitive) FROM stdin;
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

SELECT pg_catalog.setval('identifier_type_seq', 1000, false);


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY identity_provider (id, date_created, last_modified, providerid, display_name, support_email, admin_email, tech_email, last_failed, failed_count) FROM stdin;
4	2017-02-01 00:05:05.969+00	2017-02-01 00:05:05.969+00	https://idp.testshib.org/idp/shibboleth	TestShib Test IdP	\N	\N	ndk@internet2.edu	\N	0
5	2017-02-01 00:05:06.049+00	2017-02-01 00:05:06.049+00	https://sp.testshib.org/shibboleth-sp	TestShib Two	\N	\N	ndk@internet2.edu	\N	0
6	2017-02-01 00:05:08.481+00	2017-02-01 00:05:08.481+00	https://engine.surfconext.nl/authentication/idp/metadata	SURFconext | SURFnet	help@surfconext.nl	support@surfconext.nl	support@surfconext.nl	\N	0
\.


--
-- Data for Name: identity_provider_name; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY identity_provider_name (id, date_created, last_modified, identity_provider_id, display_name, lang) FROM stdin;
4	2017-02-01 00:05:05.978+00	2017-02-01 00:05:05.978+00	4	TestShib Test IdP	en
5	2017-02-01 00:05:06.051+00	2017-02-01 00:05:06.051+00	5	TestShib Two	en
6	2017-02-01 00:05:08.482+00	2017-02-01 00:05:08.482+00	6	SURFconext | SURFnet	nl
7	2017-02-01 00:05:08.483+00	2017-02-01 00:05:08.483+00	6	SURFconext | SURFnet	en
\.


--
-- Name: identity_provider_name_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('identity_provider_name_seq', 7, true);


--
-- Name: identity_provider_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('identity_provider_seq', 6, true);


--
-- Data for Name: institution; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY institution (id, date_created, last_modified, institution_name, address_id) FROM stdin;
\.


--
-- Name: institution_department_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('institution_department_seq', 1000, true);


--
-- Name: institution_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('institution_seq', 1000, true);


--
-- Data for Name: internal_sso; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY internal_sso (orcid, token, date_created, last_modified) FROM stdin;
\.


--
-- Name: invalid_record_change_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('invalid_record_change_seq', 1000, false);


--
-- Data for Name: invalid_record_data_changes; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY invalid_record_data_changes (sql_used_to_update, description, num_changed, type, date_created, last_modified, id) FROM stdin;
\.


--
-- Name: keyword_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('keyword_seq', 1035, true);


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY notification (id, date_created, last_modified, orcid, notification_type, subject, body_text, body_html, sent_date, read_date, archived_date, sendable, source_id, authorization_url, lang, client_source_id, amended_section, actioned_date, notification_subject, notification_intro, authentication_provider_id) FROM stdin;
1698	2017-02-17 18:29:24.998+00	2017-02-17 18:29:24.998+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1538	2014-01-01 09:17:56+00	2017-02-17 17:02:10.999+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 17:02:10.9+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1539	2014-01-01 09:17:56+00	2017-02-17 17:02:11.648+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1540	2014-01-01 09:17:56+00	2017-02-17 17:02:12.36+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1541	2014-01-01 09:17:56+00	2017-02-17 17:02:13.162+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1699	2017-02-17 21:23:26.796+00	2017-02-17 21:23:26.796+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	BIO	\N	\N	\N	\N
1542	2014-01-01 09:17:56+00	2017-02-17 17:02:14.459+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 17:02:14.451+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1543	2014-01-01 09:17:56+00	2017-02-17 17:02:15.175+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1544	2014-01-01 09:17:56+00	2017-02-17 17:02:15.459+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1545	2014-01-01 09:17:56+00	2017-02-17 17:02:15.773+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1546	2014-01-01 09:17:56+00	2017-02-17 17:02:16.828+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 17:02:16.823+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1547	2014-01-01 09:17:56+00	2017-02-17 17:02:17.218+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1548	2014-01-01 09:17:56+00	2017-02-17 17:02:17.407+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1549	2014-01-01 09:17:56+00	2017-02-17 17:02:17.675+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1550	2014-01-01 09:17:56+00	2017-02-17 17:02:18.675+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 17:02:18.672+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1551	2014-01-01 09:17:56+00	2017-02-17 17:02:19.115+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1552	2014-01-01 09:17:56+00	2017-02-17 17:02:19.407+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1553	2014-01-01 09:17:56+00	2017-02-17 17:02:19.61+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1554	2014-01-01 09:17:56+00	2017-02-17 17:02:20.583+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 17:02:20.58+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1555	2014-01-01 09:17:56+00	2017-02-17 17:02:21.067+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1556	2014-01-01 09:17:56+00	2017-02-17 17:02:21.286+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1557	2014-01-01 09:17:56+00	2017-02-17 17:02:21.493+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1558	2014-01-01 09:17:56+00	2017-02-17 17:18:24.491+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 17:18:24.418+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1559	2014-01-01 09:17:56+00	2017-02-17 17:18:25.065+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1560	2014-01-01 09:17:56+00	2017-02-17 17:18:25.53+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1561	2014-01-01 09:17:56+00	2017-02-17 17:18:26.036+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1562	2014-01-01 09:17:56+00	2017-02-17 17:18:27.7+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 17:18:27.691+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1563	2014-01-01 09:17:56+00	2017-02-17 17:18:28.141+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1564	2014-01-01 09:17:56+00	2017-02-17 17:18:28.501+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1567	2014-01-01 09:17:56+00	2017-02-17 17:18:30.1+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1572	2014-01-01 09:17:56+00	2017-02-17 17:18:32.444+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1576	2014-01-01 09:17:56+00	2017-02-17 17:18:34.354+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1577	2014-01-01 09:17:56+00	2017-02-17 17:18:34.714+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1700	2017-02-17 21:23:28.136+00	2017-02-17 21:23:28.136+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	BIO	\N	\N	\N	\N
1701	2017-02-17 21:23:32.524+00	2017-02-17 21:23:32.524+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1702	2017-02-17 21:23:33.154+00	2017-02-17 21:23:33.154+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1703	2017-02-17 21:24:06.56+00	2017-02-17 21:24:06.56+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	AFFILIATION	\N	\N	\N	\N
1704	2017-02-17 21:24:07.087+00	2017-02-17 21:24:07.087+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1705	2017-02-17 21:24:11.125+00	2017-02-17 21:24:11.125+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1706	2017-02-17 21:24:11.743+00	2017-02-17 21:24:11.743+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1707	2017-02-17 21:24:12.295+00	2017-02-17 21:24:12.295+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EXTERNAL_IDENTIFIERS	\N	\N	\N	\N
1708	2017-02-17 21:24:17.011+00	2017-02-17 21:24:17.011+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1709	2017-02-17 21:24:17.29+00	2017-02-17 21:24:17.29+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1710	2017-02-17 21:24:17.5+00	2017-02-17 21:24:17.5+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	AFFILIATION	\N	\N	\N	\N
1711	2017-02-17 21:24:18.519+00	2017-02-17 21:24:18.519+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1712	2017-02-17 21:24:18.625+00	2017-02-17 21:24:18.625+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1713	2017-02-17 21:24:18.703+00	2017-02-17 21:24:18.703+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1788	2017-02-17 21:25:51.142+00	2017-02-17 21:25:51.142+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1789	2017-02-17 21:25:51.262+00	2017-02-17 21:25:51.262+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1790	2017-02-17 21:25:59.662+00	2017-02-17 21:25:59.662+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1791	2017-02-17 21:26:00.304+00	2017-02-17 21:26:00.304+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1792	2017-02-17 21:26:08.098+00	2017-02-17 21:26:08.098+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1793	2017-02-17 21:26:08.402+00	2017-02-17 21:26:08.402+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1847	2017-02-17 21:27:27.903+00	2017-02-17 21:27:27.903+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1851	2017-02-17 21:27:28.266+00	2017-02-17 21:27:28.266+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1852	2017-02-17 21:27:28.343+00	2017-02-17 21:27:28.343+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1854	2017-02-17 21:27:28.51+00	2017-02-17 21:27:28.51+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1855	2017-02-17 21:27:28.573+00	2017-02-17 21:27:28.573+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1857	2017-02-17 21:27:28.828+00	2017-02-17 21:27:28.828+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1858	2017-02-17 21:27:29.048+00	2017-02-17 21:27:29.048+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1861	2017-02-17 21:27:29.623+00	2017-02-17 21:27:29.623+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1877	2017-02-17 21:27:31.815+00	2017-02-17 21:27:31.815+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1878	2017-02-17 21:27:31.884+00	2017-02-17 21:27:31.884+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1879	2017-02-17 21:27:31.955+00	2017-02-17 21:27:31.955+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1880	2017-02-17 21:27:32.072+00	2017-02-17 21:27:32.072+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1881	2017-02-17 21:27:32.159+00	2017-02-17 21:27:32.159+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1882	2017-02-17 21:27:32.522+00	2017-02-17 21:27:32.522+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1883	2017-02-17 21:27:32.641+00	2017-02-17 21:27:32.641+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1884	2017-02-17 21:27:32.767+00	2017-02-17 21:27:32.767+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1885	2017-02-17 21:27:32.889+00	2017-02-17 21:27:32.889+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1886	2017-02-17 21:27:38.125+00	2017-02-17 21:27:38.125+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1888	2017-02-17 21:27:45.247+00	2017-02-17 21:27:45.247+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1889	2017-02-17 21:27:45.647+00	2017-02-17 21:27:45.647+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1916	2017-02-17 21:28:49.472+00	2017-02-17 21:28:49.472+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1960	2014-01-01 09:17:56+00	2017-02-17 21:30:15.738+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1961	2017-02-17 21:30:25.026+00	2017-02-17 21:30:25.026+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1965	2017-02-17 21:30:25.743+00	2017-02-17 21:30:25.743+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1966	2017-02-17 21:30:25.863+00	2017-02-17 21:30:25.863+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
1967	2017-02-17 21:30:26.348+00	2017-02-17 21:30:26.348+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1968	2017-02-17 21:30:26.457+00	2017-02-17 21:30:26.457+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1969	2017-02-17 21:30:26.618+00	2017-02-17 21:30:26.618+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
1970	2017-02-17 21:30:26.713+00	2017-02-17 21:30:26.713+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1971	2017-02-17 21:30:26.981+00	2017-02-17 21:30:26.981+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1972	2017-02-17 21:30:34.128+00	2017-02-17 21:30:34.128+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1973	2017-02-17 21:30:34.306+00	2017-02-17 21:30:34.306+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1974	2017-02-17 21:30:40.899+00	2017-02-17 21:30:40.899+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1565	2014-01-01 09:17:56+00	2017-02-17 17:18:28.775+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1714	2017-02-17 21:24:26.413+00	2017-02-17 21:24:26.413+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	BIO	\N	\N	\N	\N
1566	2014-01-01 09:17:56+00	2017-02-17 17:18:29.715+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 17:18:29.711+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1568	2014-01-01 09:17:56+00	2017-02-17 17:18:30.327+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1569	2014-01-01 09:17:56+00	2017-02-17 17:18:30.614+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1715	2017-02-17 21:24:33.303+00	2017-02-17 21:24:33.303+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1570	2014-01-01 09:17:56+00	2017-02-17 17:18:31.665+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 17:18:31.663+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1571	2014-01-01 09:17:56+00	2017-02-17 17:18:32.15+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1573	2014-01-01 09:17:56+00	2017-02-17 17:18:32.656+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1716	2017-02-17 21:24:33.6+00	2017-02-17 21:24:33.6+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1574	2014-01-01 09:17:56+00	2017-02-17 17:18:33.774+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 17:18:33.725+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1575	2014-01-01 09:17:56+00	2017-02-17 17:18:34.112+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1578	2017-02-17 17:55:53.298+00	2017-02-17 17:55:53.298+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	BIO	\N	\N	\N	\N
1579	2017-02-17 17:55:53.924+00	2017-02-17 17:55:53.924+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	BIO	\N	\N	\N	\N
1601	2014-01-01 09:17:56+00	2017-02-17 17:58:46.926+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1602	2014-01-01 09:17:56+00	2017-02-17 17:58:47.157+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1580	2017-02-17 17:56:28.723+00	2017-02-17 17:56:28.723+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1581	2017-02-17 17:56:29.094+00	2017-02-17 17:56:29.094+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1582	2017-02-17 17:56:32.851+00	2017-02-17 17:56:32.851+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	AFFILIATION	\N	\N	\N	\N
1583	2017-02-17 17:56:33.732+00	2017-02-17 17:56:33.732+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1584	2017-02-17 17:56:37.398+00	2017-02-17 17:56:37.398+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1585	2017-02-17 17:56:37.991+00	2017-02-17 17:56:37.991+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1586	2017-02-17 17:56:38.241+00	2017-02-17 17:56:38.241+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EXTERNAL_IDENTIFIERS	\N	\N	\N	\N
1608	2014-01-01 09:17:56+00	2017-02-17 17:59:29.876+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 17:59:29.874+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1717	2017-02-17 21:24:33.714+00	2017-02-17 21:24:33.714+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1718	2017-02-17 21:24:33.918+00	2017-02-17 21:24:33.918+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1719	2017-02-17 21:24:34.15+00	2017-02-17 21:24:34.15+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1720	2017-02-17 21:24:34.256+00	2017-02-17 21:24:34.256+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1722	2017-02-17 21:24:34.479+00	2017-02-17 21:24:34.479+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1724	2017-02-17 21:24:35.078+00	2017-02-17 21:24:35.077+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1725	2017-02-17 21:24:35.359+00	2017-02-17 21:24:35.359+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1726	2017-02-17 21:24:35.482+00	2017-02-17 21:24:35.482+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1587	2017-02-17 17:57:11.784+00	2017-02-17 17:57:11.784+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1588	2017-02-17 17:57:12.181+00	2017-02-17 17:57:12.181+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1589	2017-02-17 17:57:12.445+00	2017-02-17 17:57:12.445+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	AFFILIATION	\N	\N	\N	\N
1590	2017-02-17 17:57:13.594+00	2017-02-17 17:57:13.594+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1591	2017-02-17 17:57:13.685+00	2017-02-17 17:57:13.685+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1592	2017-02-17 17:57:13.92+00	2017-02-17 17:57:13.92+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1593	2017-02-17 17:57:50.339+00	2017-02-17 17:57:50.339+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	BIO	\N	\N	\N	\N
1730	2017-02-17 21:24:35.966+00	2017-02-17 21:24:35.966+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1731	2017-02-17 21:24:36.245+00	2017-02-17 21:24:36.245+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1732	2017-02-17 21:24:36.379+00	2017-02-17 21:24:36.379+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1733	2017-02-17 21:24:36.447+00	2017-02-17 21:24:36.447+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1734	2017-02-17 21:24:36.617+00	2017-02-17 21:24:36.617+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1735	2017-02-17 21:24:36.71+00	2017-02-17 21:24:36.71+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1736	2017-02-17 21:24:36.818+00	2017-02-17 21:24:36.818+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1605	2017-02-17 17:59:28.235+00	2017-02-17 17:59:28.235+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1607	2017-02-17 17:59:28.602+00	2017-02-17 17:59:28.602+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1737	2017-02-17 21:24:36.962+00	2017-02-17 21:24:36.962+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1740	2017-02-17 21:24:37.228+00	2017-02-17 21:24:37.228+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1721	2017-02-17 21:24:34.367+00	2017-02-17 21:24:34.367+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1738	2017-02-17 21:24:37.027+00	2017-02-17 21:24:37.027+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1739	2017-02-17 21:24:37.16+00	2017-02-17 21:24:37.16+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1741	2017-02-17 21:24:37.867+00	2017-02-17 21:24:37.867+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1743	2017-02-17 21:24:39.421+00	2017-02-17 21:24:39.421+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1750	2017-02-17 21:24:52.59+00	2017-02-17 21:24:52.59+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1751	2017-02-17 21:24:52.85+00	2017-02-17 21:24:52.85+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1754	2017-02-17 21:24:53.354+00	2017-02-17 21:24:53.354+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1755	2017-02-17 21:24:53.708+00	2017-02-17 21:24:53.708+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1756	2017-02-17 21:24:53.807+00	2017-02-17 21:24:53.807+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
1763	2017-02-17 21:24:55.712+00	2017-02-17 21:24:55.712+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1770	2017-02-17 21:24:56.696+00	2017-02-17 21:24:56.696+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1771	2017-02-17 21:24:57.309+00	2017-02-17 21:24:57.309+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1772	2017-02-17 21:24:57.561+00	2017-02-17 21:24:57.561+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1774	2017-02-17 21:24:59.461+00	2017-02-17 21:24:59.461+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1776	2017-02-17 21:25:01.553+00	2017-02-17 21:25:01.553+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1778	2017-02-17 21:25:01.721+00	2017-02-17 21:25:01.721+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
1783	2017-02-17 21:25:06.525+00	2017-02-17 21:25:06.525+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1784	2017-02-17 21:25:06.687+00	2017-02-17 21:25:06.687+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1794	2017-02-17 21:26:14.59+00	2017-02-17 21:26:14.59+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1795	2017-02-17 21:26:14.91+00	2017-02-17 21:26:14.91+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1799	2017-02-17 21:26:42.304+00	2017-02-17 21:26:42.304+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1800	2017-02-17 21:26:43.277+00	2017-02-17 21:26:43.277+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1805	2017-02-17 21:26:44.11+00	2017-02-17 21:26:44.11+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1806	2017-02-17 21:26:44.219+00	2017-02-17 21:26:44.219+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1807	2017-02-17 21:26:44.319+00	2017-02-17 21:26:44.319+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1808	2017-02-17 21:26:44.465+00	2017-02-17 21:26:44.465+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1811	2017-02-17 21:26:44.853+00	2017-02-17 21:26:44.853+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1812	2017-02-17 21:26:45.065+00	2017-02-17 21:26:45.065+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1820	2017-02-17 21:26:46.741+00	2017-02-17 21:26:46.741+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1827	2017-02-17 21:26:47.388+00	2017-02-17 21:26:47.388+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1830	2017-02-17 21:26:47.65+00	2017-02-17 21:26:47.65+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1834	2017-02-17 21:26:48.053+00	2017-02-17 21:26:48.053+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1835	2017-02-17 21:26:48.144+00	2017-02-17 21:26:48.144+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1837	2017-02-17 21:26:48.561+00	2017-02-17 21:26:48.561+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1838	2017-02-17 21:26:48.644+00	2017-02-17 21:26:48.644+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1842	2017-02-17 21:27:13.291+00	2017-02-17 21:27:13.291+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1843	2017-02-17 21:27:13.584+00	2017-02-17 21:27:13.584+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1887	2017-02-17 21:27:38.515+00	2017-02-17 21:27:38.515+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1890	2017-02-17 21:28:31.449+00	2017-02-17 21:28:31.449+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1891	2017-02-17 21:28:35.643+00	2017-02-17 21:28:35.643+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1897	2014-01-01 09:17:56+00	2017-02-17 21:28:37.837+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1902	2017-02-17 21:28:43.927+00	2017-02-17 21:28:43.927+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1905	2017-02-17 21:28:44.581+00	2017-02-17 21:28:44.581+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1907	2017-02-17 21:28:44.856+00	2017-02-17 21:28:44.856+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
1913	2017-02-17 21:28:45.841+00	2017-02-17 21:28:45.841+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1914	2017-02-17 21:28:46.495+00	2017-02-17 21:28:46.495+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1915	2017-02-17 21:28:48.917+00	2017-02-17 21:28:48.917+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1918	2017-02-17 21:29:07.529+00	2017-02-17 21:29:07.529+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1919	2017-02-17 21:29:07.651+00	2017-02-17 21:29:07.651+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1934	2017-02-17 21:29:32.879+00	2017-02-17 21:29:32.879+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1935	2017-02-17 21:29:33.02+00	2017-02-17 21:29:33.02+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1936	2017-02-17 21:29:33.432+00	2017-02-17 21:29:33.432+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1938	2017-02-17 21:29:33.76+00	2017-02-17 21:29:33.76+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1941	2017-02-17 21:29:34.106+00	2017-02-17 21:29:34.106+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1942	2017-02-17 21:29:34.253+00	2017-02-17 21:29:34.253+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1943	2017-02-17 21:29:34.32+00	2017-02-17 21:29:34.32+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1944	2017-02-17 21:29:34.41+00	2017-02-17 21:29:34.41+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1945	2017-02-17 21:29:42.379+00	2017-02-17 21:29:42.379+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1946	2017-02-17 21:29:42.607+00	2017-02-17 21:29:42.607+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1950	2017-02-17 21:30:01.341+00	2017-02-17 21:30:01.341+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1952	2017-02-17 21:30:05.136+00	2017-02-17 21:30:05.136+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1954	2017-02-17 21:30:14.09+00	2017-02-17 21:30:14.09+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1962	2017-02-17 21:30:25.386+00	2017-02-17 21:30:25.386+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1964	2017-02-17 21:30:25.673+00	2017-02-17 21:30:25.673+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1594	2017-02-17 17:58:40.931+00	2017-02-17 17:58:40.931+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1595	2017-02-17 17:58:43.544+00	2017-02-17 17:58:43.544+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1723	2017-02-17 21:24:34.836+00	2017-02-17 21:24:34.836+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1727	2017-02-17 21:24:35.639+00	2017-02-17 21:24:35.639+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1609	2014-01-01 09:17:56+00	2017-02-17 17:59:30.185+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1728	2017-02-17 21:24:35.753+00	2017-02-17 21:24:35.753+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1729	2017-02-17 21:24:35.874+00	2017-02-17 21:24:35.874+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1619	2014-01-01 09:17:56+00	2017-02-17 18:00:13.177+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1625	2017-02-17 18:00:19.619+00	2017-02-17 18:00:19.619+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1631	2017-02-17 18:00:20.151+00	2017-02-17 18:00:20.151+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1635	2017-02-17 18:00:21.149+00	2017-02-17 18:00:21.149+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1637	2017-02-17 18:00:21.453+00	2017-02-17 18:00:21.453+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1642	2017-02-17 18:00:22.345+00	2017-02-17 18:00:22.345+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1749	2017-02-17 21:24:47.656+00	2017-02-17 21:24:47.656+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1777	2017-02-17 21:25:01.621+00	2017-02-17 21:25:01.621+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1779	2017-02-17 21:25:02.342+00	2017-02-17 21:25:02.342+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1780	2017-02-17 21:25:02.54+00	2017-02-17 21:25:02.54+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1786	2017-02-17 21:25:08.546+00	2017-02-17 21:25:08.546+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1796	2017-02-17 21:26:28.496+00	2017-02-17 21:26:28.496+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1797	2017-02-17 21:26:29.138+00	2017-02-17 21:26:29.138+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1798	2017-02-17 21:26:41.734+00	2017-02-17 21:26:41.734+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1801	2017-02-17 21:26:43.38+00	2017-02-17 21:26:43.38+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1802	2017-02-17 21:26:43.432+00	2017-02-17 21:26:43.432+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1809	2017-02-17 21:26:44.643+00	2017-02-17 21:26:44.643+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1810	2017-02-17 21:26:44.778+00	2017-02-17 21:26:44.778+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1815	2017-02-17 21:26:45.584+00	2017-02-17 21:26:45.584+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1816	2017-02-17 21:26:45.752+00	2017-02-17 21:26:45.752+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1819	2017-02-17 21:26:46.322+00	2017-02-17 21:26:46.322+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1821	2017-02-17 21:26:46.869+00	2017-02-17 21:26:46.869+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1822	2017-02-17 21:26:46.954+00	2017-02-17 21:26:46.954+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1823	2017-02-17 21:26:47.026+00	2017-02-17 21:26:47.026+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1824	2017-02-17 21:26:47.081+00	2017-02-17 21:26:47.081+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1825	2017-02-17 21:26:47.176+00	2017-02-17 21:26:47.176+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1826	2017-02-17 21:26:47.229+00	2017-02-17 21:26:47.229+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1828	2017-02-17 21:26:47.514+00	2017-02-17 21:26:47.514+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1829	2017-02-17 21:26:47.604+00	2017-02-17 21:26:47.604+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1831	2017-02-17 21:26:47.714+00	2017-02-17 21:26:47.714+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1832	2017-02-17 21:26:47.805+00	2017-02-17 21:26:47.805+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1833	2017-02-17 21:26:47.92+00	2017-02-17 21:26:47.92+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1836	2017-02-17 21:26:48.503+00	2017-02-17 21:26:48.503+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1839	2017-02-17 21:26:48.737+00	2017-02-17 21:26:48.737+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1892	2017-02-17 21:28:35.826+00	2017-02-17 21:28:35.826+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1893	2017-02-17 21:28:36.089+00	2017-02-17 21:28:36.089+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1895	2014-01-01 09:17:56+00	2017-02-17 21:28:37.414+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 21:28:37.41+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1896	2014-01-01 09:17:56+00	2017-02-17 21:28:37.621+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1899	2017-02-17 21:28:43.035+00	2017-02-17 21:28:43.035+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1903	2017-02-17 21:28:44.009+00	2017-02-17 21:28:44.009+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1906	2017-02-17 21:28:44.739+00	2017-02-17 21:28:44.739+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1908	2017-02-17 21:28:44.961+00	2017-02-17 21:28:44.961+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1909	2017-02-17 21:28:45.163+00	2017-02-17 21:28:45.163+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1910	2017-02-17 21:28:45.516+00	2017-02-17 21:28:45.516+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1917	2017-02-17 21:29:07.33+00	2017-02-17 21:29:07.33+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1920	2017-02-17 21:29:20.23+00	2017-02-17 21:29:20.23+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1921	2017-02-17 21:29:20.662+00	2017-02-17 21:29:20.662+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1924	2017-02-17 21:29:31.743+00	2017-02-17 21:29:31.743+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1927	2017-02-17 21:29:32.113+00	2017-02-17 21:29:32.113+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
1929	2017-02-17 21:29:32.284+00	2017-02-17 21:29:32.284+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1932	2017-02-17 21:29:32.59+00	2017-02-17 21:29:32.59+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1933	2017-02-17 21:29:32.732+00	2017-02-17 21:29:32.732+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
1939	2017-02-17 21:29:33.857+00	2017-02-17 21:29:33.857+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1940	2017-02-17 21:29:34.054+00	2017-02-17 21:29:34.054+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1596	2017-02-17 17:58:44.18+00	2017-02-17 17:58:44.18+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1597	2017-02-17 17:58:44.831+00	2017-02-17 17:58:44.831+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1598	2017-02-17 17:58:45.422+00	2017-02-17 17:58:45.422+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1742	2017-02-17 21:24:38.458+00	2017-02-17 21:24:38.458+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1599	2014-01-01 09:17:56+00	2017-02-17 17:58:46.44+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 17:58:46.437+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1600	2014-01-01 09:17:56+00	2017-02-17 17:58:46.718+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1603	2017-02-17 17:58:54.577+00	2017-02-17 17:58:54.577+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1744	2017-02-17 21:24:39.658+00	2017-02-17 21:24:39.658+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1644	2014-01-01 09:17:56+00	2017-02-17 18:01:16.212+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 18:01:16.21+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1645	2014-01-01 09:17:56+00	2017-02-17 18:01:16.424+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1646	2014-01-01 09:17:56+00	2017-02-17 18:01:16.606+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1604	2017-02-17 17:59:28.127+00	2017-02-17 17:59:28.127+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1606	2017-02-17 17:59:28.349+00	2017-02-17 17:59:28.349+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
1610	2014-01-01 09:17:56+00	2017-02-17 17:59:30.484+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1611	2014-01-01 09:17:56+00	2017-02-17 17:59:30.879+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1647	2014-01-01 09:17:56+00	2017-02-17 18:01:16.77+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1648	2017-02-17 18:01:26.664+00	2017-02-17 18:01:26.664+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1649	2017-02-17 18:01:27.156+00	2017-02-17 18:01:27.156+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1650	2017-02-17 18:01:27.297+00	2017-02-17 18:01:27.297+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1651	2017-02-17 18:01:27.486+00	2017-02-17 18:01:27.486+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1652	2017-02-17 18:01:27.636+00	2017-02-17 18:01:27.636+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1612	2017-02-17 18:00:10.527+00	2017-02-17 18:00:10.527+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1613	2017-02-17 18:00:10.818+00	2017-02-17 18:00:10.818+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1614	2017-02-17 18:00:11.069+00	2017-02-17 18:00:11.069+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1615	2017-02-17 18:00:11.305+00	2017-02-17 18:00:11.305+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
1616	2017-02-17 18:00:11.51+00	2017-02-17 18:00:11.51+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1745	2017-02-17 21:24:39.845+00	2017-02-17 21:24:39.845+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1617	2014-01-01 09:17:56+00	2017-02-17 18:00:12.788+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 18:00:12.785+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1618	2014-01-01 09:17:56+00	2017-02-17 18:00:13.002+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1620	2014-01-01 09:17:56+00	2017-02-17 18:00:13.401+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1621	2017-02-17 18:00:18.824+00	2017-02-17 18:00:18.824+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1622	2017-02-17 18:00:19.23+00	2017-02-17 18:00:19.23+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1623	2017-02-17 18:00:19.375+00	2017-02-17 18:00:19.375+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1624	2017-02-17 18:00:19.459+00	2017-02-17 18:00:19.459+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1626	2017-02-17 18:00:19.686+00	2017-02-17 18:00:19.686+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1627	2017-02-17 18:00:19.755+00	2017-02-17 18:00:19.755+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1628	2017-02-17 18:00:19.846+00	2017-02-17 18:00:19.846+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1629	2017-02-17 18:00:19.932+00	2017-02-17 18:00:19.932+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1630	2017-02-17 18:00:20.042+00	2017-02-17 18:00:20.042+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1632	2017-02-17 18:00:20.685+00	2017-02-17 18:00:20.685+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1633	2017-02-17 18:00:20.794+00	2017-02-17 18:00:20.794+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1634	2017-02-17 18:00:20.9+00	2017-02-17 18:00:20.9+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
1636	2017-02-17 18:00:21.281+00	2017-02-17 18:00:21.281+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1638	2017-02-17 18:00:21.604+00	2017-02-17 18:00:21.604+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1639	2017-02-17 18:00:21.82+00	2017-02-17 18:00:21.82+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1640	2017-02-17 18:00:21.957+00	2017-02-17 18:00:21.957+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1641	2017-02-17 18:00:22.115+00	2017-02-17 18:00:22.115+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1643	2017-02-17 18:00:22.631+00	2017-02-17 18:00:22.631+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1653	2017-02-17 18:01:27.713+00	2017-02-17 18:01:27.713+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1654	2017-02-17 18:01:27.81+00	2017-02-17 18:01:27.81+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1655	2017-02-17 18:01:27.895+00	2017-02-17 18:01:27.895+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1656	2017-02-17 18:01:28.009+00	2017-02-17 18:01:28.009+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1657	2017-02-17 18:01:28.146+00	2017-02-17 18:01:28.146+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1658	2017-02-17 18:01:28.302+00	2017-02-17 18:01:28.302+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1659	2017-02-17 18:01:28.859+00	2017-02-17 18:01:28.859+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1660	2017-02-17 18:01:28.94+00	2017-02-17 18:01:28.94+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1661	2017-02-17 18:01:29.025+00	2017-02-17 18:01:29.025+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
1662	2017-02-17 18:01:29.222+00	2017-02-17 18:01:29.222+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1663	2017-02-17 18:01:29.324+00	2017-02-17 18:01:29.324+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1664	2017-02-17 18:01:29.38+00	2017-02-17 18:01:29.38+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1665	2017-02-17 18:01:29.435+00	2017-02-17 18:01:29.435+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1666	2017-02-17 18:01:29.488+00	2017-02-17 18:01:29.488+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1667	2017-02-17 18:01:29.591+00	2017-02-17 18:01:29.591+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1668	2017-02-17 18:01:29.693+00	2017-02-17 18:01:29.693+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1669	2017-02-17 18:01:29.881+00	2017-02-17 18:01:29.881+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1746	2017-02-17 21:24:46.199+00	2017-02-17 21:24:46.199+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1671	2014-01-01 09:17:56+00	2017-02-17 18:01:31.567+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 18:01:31.565+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1672	2014-01-01 09:17:56+00	2017-02-17 18:01:31.849+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1673	2014-01-01 09:17:56+00	2017-02-17 18:01:32.053+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1674	2014-01-01 09:17:56+00	2017-02-17 18:01:32.256+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1676	2017-02-17 18:01:42.488+00	2017-02-17 18:01:42.488+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1678	2017-02-17 18:01:42.771+00	2017-02-17 18:01:42.771+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1680	2017-02-17 18:01:42.931+00	2017-02-17 18:01:42.931+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1686	2017-02-17 18:01:44.197+00	2017-02-17 18:01:44.197+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1687	2017-02-17 18:01:44.297+00	2017-02-17 18:01:44.297+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1688	2017-02-17 18:01:44.399+00	2017-02-17 18:01:44.399+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
1689	2017-02-17 18:01:44.662+00	2017-02-17 18:01:44.662+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1690	2017-02-17 18:01:44.875+00	2017-02-17 18:01:44.875+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1693	2017-02-17 18:01:45.249+00	2017-02-17 18:01:45.249+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1695	2017-02-17 18:01:45.412+00	2017-02-17 18:01:45.412+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1697	2017-02-17 18:01:45.908+00	2017-02-17 18:01:45.908+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1747	2017-02-17 21:24:46.494+00	2017-02-17 21:24:46.494+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1748	2017-02-17 21:24:47.232+00	2017-02-17 21:24:47.232+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1752	2017-02-17 21:24:53.04+00	2017-02-17 21:24:53.04+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1753	2017-02-17 21:24:53.185+00	2017-02-17 21:24:53.185+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
1757	2017-02-17 21:24:54.026+00	2017-02-17 21:24:54.026+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1758	2017-02-17 21:24:54.247+00	2017-02-17 21:24:54.247+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1759	2017-02-17 21:24:54.433+00	2017-02-17 21:24:54.433+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
1773	2017-02-17 21:24:57.854+00	2017-02-17 21:24:57.854+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1775	2017-02-17 21:25:00.003+00	2017-02-17 21:25:00.003+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1803	2017-02-17 21:26:43.682+00	2017-02-17 21:26:43.682+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1804	2017-02-17 21:26:43.927+00	2017-02-17 21:26:43.927+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1813	2017-02-17 21:26:45.201+00	2017-02-17 21:26:45.201+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1814	2017-02-17 21:26:45.367+00	2017-02-17 21:26:45.367+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1817	2017-02-17 21:26:45.981+00	2017-02-17 21:26:45.981+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1818	2017-02-17 21:26:46.161+00	2017-02-17 21:26:46.161+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1840	2017-02-17 21:27:01.329+00	2017-02-17 21:27:01.329+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1844	2017-02-17 21:27:21.225+00	2017-02-17 21:27:21.225+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1845	2017-02-17 21:27:21.65+00	2017-02-17 21:27:21.65+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1846	2017-02-17 21:27:27.854+00	2017-02-17 21:27:27.854+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1848	2017-02-17 21:27:27.977+00	2017-02-17 21:27:27.977+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1849	2017-02-17 21:27:28.025+00	2017-02-17 21:27:28.025+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1850	2017-02-17 21:27:28.18+00	2017-02-17 21:27:28.18+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1853	2017-02-17 21:27:28.413+00	2017-02-17 21:27:28.413+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1856	2017-02-17 21:27:28.641+00	2017-02-17 21:27:28.641+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1859	2017-02-17 21:27:29.288+00	2017-02-17 21:27:29.288+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1862	2017-02-17 21:27:29.859+00	2017-02-17 21:27:29.859+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1866	2017-02-17 21:27:30.747+00	2017-02-17 21:27:30.747+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1871	2017-02-17 21:27:31.165+00	2017-02-17 21:27:31.165+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1872	2017-02-17 21:27:31.219+00	2017-02-17 21:27:31.219+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1873	2017-02-17 21:27:31.358+00	2017-02-17 21:27:31.358+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1874	2017-02-17 21:27:31.613+00	2017-02-17 21:27:31.613+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1875	2017-02-17 21:27:31.69+00	2017-02-17 21:27:31.69+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1876	2017-02-17 21:27:31.738+00	2017-02-17 21:27:31.738+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1670	2017-02-17 18:01:30.202+00	2017-02-17 18:01:30.202+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1675	2017-02-17 18:01:42.116+00	2017-02-17 18:01:42.116+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1677	2017-02-17 18:01:42.665+00	2017-02-17 18:01:42.665+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1679	2017-02-17 18:01:42.878+00	2017-02-17 18:01:42.878+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1681	2017-02-17 18:01:43.012+00	2017-02-17 18:01:43.012+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1682	2017-02-17 18:01:43.363+00	2017-02-17 18:01:43.363+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1683	2017-02-17 18:01:43.539+00	2017-02-17 18:01:43.539+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1684	2017-02-17 18:01:43.684+00	2017-02-17 18:01:43.684+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1685	2017-02-17 18:01:43.738+00	2017-02-17 18:01:43.738+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1691	2017-02-17 18:01:45.019+00	2017-02-17 18:01:45.019+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1692	2017-02-17 18:01:45.104+00	2017-02-17 18:01:45.104+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1694	2017-02-17 18:01:45.349+00	2017-02-17 18:01:45.349+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1696	2017-02-17 18:01:45.563+00	2017-02-17 18:01:45.563+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1760	2017-02-17 21:24:54.591+00	2017-02-17 21:24:54.591+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1761	2017-02-17 21:24:54.846+00	2017-02-17 21:24:54.846+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1762	2017-02-17 21:24:55.412+00	2017-02-17 21:24:55.412+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1764	2017-02-17 21:24:55.946+00	2017-02-17 21:24:55.946+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1765	2017-02-17 21:24:56+00	2017-02-17 21:24:56+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1766	2017-02-17 21:24:56.114+00	2017-02-17 21:24:56.114+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1767	2017-02-17 21:24:56.264+00	2017-02-17 21:24:56.264+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1768	2017-02-17 21:24:56.47+00	2017-02-17 21:24:56.47+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1769	2017-02-17 21:24:56.536+00	2017-02-17 21:24:56.536+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1781	2017-02-17 21:25:04.5+00	2017-02-17 21:25:04.5+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1782	2017-02-17 21:25:04.88+00	2017-02-17 21:25:04.88+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1785	2017-02-17 21:25:08.127+00	2017-02-17 21:25:08.127+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1787	2017-02-17 21:25:08.89+00	2017-02-17 21:25:08.89+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1841	2017-02-17 21:27:01.666+00	2017-02-17 21:27:01.666+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1860	2017-02-17 21:27:29.525+00	2017-02-17 21:27:29.525+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1863	2017-02-17 21:27:30.002+00	2017-02-17 21:27:30.002+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1864	2017-02-17 21:27:30.158+00	2017-02-17 21:27:30.158+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1865	2017-02-17 21:27:30.345+00	2017-02-17 21:27:30.345+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1867	2017-02-17 21:27:30.857+00	2017-02-17 21:27:30.857+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1868	2017-02-17 21:27:30.919+00	2017-02-17 21:27:30.919+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1869	2017-02-17 21:27:30.977+00	2017-02-17 21:27:30.977+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1870	2017-02-17 21:27:31.071+00	2017-02-17 21:27:31.071+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1894	2017-02-17 21:28:36.387+00	2017-02-17 21:28:36.387+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1898	2014-01-01 09:17:56+00	2017-02-17 21:28:38.004+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1900	2017-02-17 21:28:43.425+00	2017-02-17 21:28:43.425+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1901	2017-02-17 21:28:43.687+00	2017-02-17 21:28:43.687+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1904	2017-02-17 21:28:44.115+00	2017-02-17 21:28:44.115+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
1911	2017-02-17 21:28:45.571+00	2017-02-17 21:28:45.571+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1912	2017-02-17 21:28:45.783+00	2017-02-17 21:28:45.783+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1922	2017-02-17 21:29:25.963+00	2017-02-17 21:29:25.963+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1923	2017-02-17 21:29:26.194+00	2017-02-17 21:29:26.194+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1925	2017-02-17 21:29:31.831+00	2017-02-17 21:29:31.831+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1926	2017-02-17 21:29:32.05+00	2017-02-17 21:29:32.05+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1928	2017-02-17 21:29:32.2+00	2017-02-17 21:29:32.2+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1930	2017-02-17 21:29:32.341+00	2017-02-17 21:29:32.341+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
1931	2017-02-17 21:29:32.382+00	2017-02-17 21:29:32.382+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1937	2017-02-17 21:29:33.617+00	2017-02-17 21:29:33.617+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1947	2017-02-17 21:29:42.783+00	2017-02-17 21:29:42.783+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1948	2017-02-17 21:29:48.433+00	2017-02-17 21:29:48.433+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1949	2017-02-17 21:29:48.727+00	2017-02-17 21:29:48.727+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1951	2017-02-17 21:30:01.704+00	2017-02-17 21:30:01.704+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1953	2017-02-17 21:30:05.63+00	2017-02-17 21:30:05.63+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1955	2017-02-17 21:30:14.371+00	2017-02-17 21:30:14.371+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1956	2017-02-17 21:30:14.578+00	2017-02-17 21:30:14.578+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1957	2014-01-01 09:17:56+00	2017-02-17 21:30:15.305+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 21:30:15.301+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1958	2014-01-01 09:17:56+00	2017-02-17 21:30:15.49+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1959	2014-01-01 09:17:56+00	2017-02-17 21:30:15.663+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
1963	2017-02-17 21:30:25.516+00	2017-02-17 21:30:25.516+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1975	2017-02-17 21:30:41.065+00	2017-02-17 21:30:41.065+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1976	2017-02-17 21:30:41.171+00	2017-02-17 21:30:41.171+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1977	2017-02-17 21:30:53.146+00	2017-02-17 21:30:53.146+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1999	2017-02-17 21:31:10.049+00	2017-02-17 21:31:10.049+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2000	2017-02-17 21:31:10.182+00	2017-02-17 21:31:10.182+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2002	2017-02-17 21:31:17.59+00	2017-02-17 21:31:17.59+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1978	2017-02-17 21:30:53.848+00	2017-02-17 21:30:53.848+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1982	2017-02-17 21:31:07.047+00	2017-02-17 21:31:07.047+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1984	2017-02-17 21:31:07.241+00	2017-02-17 21:31:07.241+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
1985	2017-02-17 21:31:07.326+00	2017-02-17 21:31:07.326+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1990	2017-02-17 21:31:08.093+00	2017-02-17 21:31:08.093+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
1991	2017-02-17 21:31:08.353+00	2017-02-17 21:31:08.353+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1992	2017-02-17 21:31:08.527+00	2017-02-17 21:31:08.527+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1993	2017-02-17 21:31:08.782+00	2017-02-17 21:31:08.782+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1995	2017-02-17 21:31:09.127+00	2017-02-17 21:31:09.127+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2001	2017-02-17 21:31:10.274+00	2017-02-17 21:31:10.274+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1979	2017-02-17 21:30:59.786+00	2017-02-17 21:30:59.786+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1981	2017-02-17 21:31:06.908+00	2017-02-17 21:31:06.908+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
1983	2017-02-17 21:31:07.141+00	2017-02-17 21:31:07.141+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1994	2017-02-17 21:31:08.961+00	2017-02-17 21:31:08.961+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1996	2017-02-17 21:31:09.316+00	2017-02-17 21:31:09.316+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
1997	2017-02-17 21:31:09.424+00	2017-02-17 21:31:09.424+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2003	2017-02-17 21:31:17.857+00	2017-02-17 21:31:17.857+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1980	2017-02-17 21:31:00.006+00	2017-02-17 21:31:00.006+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
1986	2017-02-17 21:31:07.458+00	2017-02-17 21:31:07.458+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1987	2017-02-17 21:31:07.575+00	2017-02-17 21:31:07.575+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
1988	2017-02-17 21:31:07.682+00	2017-02-17 21:31:07.682+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
1989	2017-02-17 21:31:07.898+00	2017-02-17 21:31:07.898+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
1998	2017-02-17 21:31:09.546+00	2017-02-17 21:31:09.546+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2004	2017-02-17 21:31:18.112+00	2017-02-17 21:31:18.112+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2005	2017-02-17 21:31:24.256+00	2017-02-17 21:31:24.256+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2006	2017-02-17 21:31:24.589+00	2017-02-17 21:31:24.589+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2007	2017-02-17 21:31:37.51+00	2017-02-17 21:31:37.51+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2008	2017-02-17 21:31:37.71+00	2017-02-17 21:31:37.71+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2009	2017-02-17 21:31:44.215+00	2017-02-17 21:31:44.215+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2010	2017-02-17 21:31:44.434+00	2017-02-17 21:31:44.434+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2011	2017-02-17 21:31:50.501+00	2017-02-17 21:31:50.501+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2012	2017-02-17 21:31:50.702+00	2017-02-17 21:31:50.702+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2013	2017-02-17 21:31:50.842+00	2017-02-17 21:31:50.842+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2014	2014-01-01 09:17:56+00	2017-02-17 21:31:51.536+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 21:31:51.534+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2015	2014-01-01 09:17:56+00	2017-02-17 21:31:51.681+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2016	2014-01-01 09:17:56+00	2017-02-17 21:31:51.842+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2017	2014-01-01 09:17:56+00	2017-02-17 21:31:51.928+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2018	2017-02-17 21:31:57.622+00	2017-02-17 21:31:57.622+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2019	2017-02-17 21:31:57.826+00	2017-02-17 21:31:57.826+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2020	2017-02-17 21:31:57.889+00	2017-02-17 21:31:57.889+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2021	2017-02-17 21:31:58.204+00	2017-02-17 21:31:58.204+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2022	2017-02-17 21:31:58.433+00	2017-02-17 21:31:58.433+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2023	2017-02-17 21:31:58.509+00	2017-02-17 21:31:58.509+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2024	2017-02-17 21:31:58.612+00	2017-02-17 21:31:58.612+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2025	2017-02-17 21:31:58.741+00	2017-02-17 21:31:58.741+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2026	2017-02-17 21:31:58.848+00	2017-02-17 21:31:58.848+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2027	2017-02-17 21:31:58.897+00	2017-02-17 21:31:58.897+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2028	2017-02-17 21:31:58.966+00	2017-02-17 21:31:58.966+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2029	2017-02-17 21:31:59.071+00	2017-02-17 21:31:59.071+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2030	2017-02-17 21:31:59.186+00	2017-02-17 21:31:59.186+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2031	2017-02-17 21:31:59.82+00	2017-02-17 21:31:59.82+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2032	2017-02-17 21:31:59.948+00	2017-02-17 21:31:59.948+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2033	2017-02-17 21:32:00.006+00	2017-02-17 21:32:00.006+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2034	2017-02-17 21:32:00.31+00	2017-02-17 21:32:00.31+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2035	2017-02-17 21:32:00.563+00	2017-02-17 21:32:00.563+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2036	2017-02-17 21:32:00.753+00	2017-02-17 21:32:00.753+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2037	2017-02-17 21:32:00.981+00	2017-02-17 21:32:00.981+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2038	2017-02-17 21:32:01.081+00	2017-02-17 21:32:01.081+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2039	2017-02-17 21:32:01.15+00	2017-02-17 21:32:01.15+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2040	2017-02-17 21:32:01.229+00	2017-02-17 21:32:01.229+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2041	2017-02-17 21:32:01.33+00	2017-02-17 21:32:01.33+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2042	2017-02-17 21:32:01.374+00	2017-02-17 21:32:01.374+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2043	2017-02-17 21:32:01.463+00	2017-02-17 21:32:01.463+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2044	2017-02-17 21:32:01.539+00	2017-02-17 21:32:01.539+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2045	2017-02-17 21:32:01.729+00	2017-02-17 21:32:01.729+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2046	2017-02-17 21:32:01.834+00	2017-02-17 21:32:01.834+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2047	2017-02-17 21:32:08.517+00	2017-02-17 21:32:08.517+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2048	2017-02-17 21:32:08.698+00	2017-02-17 21:32:08.698+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2049	2017-02-17 21:32:09.458+00	2017-02-17 21:32:09.458+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2050	2017-02-17 21:32:09.853+00	2017-02-17 21:32:09.853+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2051	2017-02-17 21:32:10.039+00	2017-02-17 21:32:10.039+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2052	2017-02-17 21:32:11.14+00	2017-02-17 21:32:11.14+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2053	2017-02-17 21:32:11.501+00	2017-02-17 21:32:11.501+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2054	2017-02-17 21:32:11.714+00	2017-02-17 21:32:11.714+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2055	2017-02-17 21:32:11.902+00	2017-02-17 21:32:11.902+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2056	2017-02-17 21:32:12.547+00	2017-02-17 21:32:12.547+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2057	2017-02-17 21:32:12.661+00	2017-02-17 21:32:12.661+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2058	2017-02-17 21:32:12.808+00	2017-02-17 21:32:12.808+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2061	2017-02-17 21:32:13.137+00	2017-02-17 21:32:13.137+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2062	2017-02-17 21:32:13.235+00	2017-02-17 21:32:13.235+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2065	2017-02-17 21:32:13.705+00	2017-02-17 21:32:13.705+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2067	2017-02-17 21:32:14.086+00	2017-02-17 21:32:14.086+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2068	2017-02-17 21:32:14.586+00	2017-02-17 21:32:14.586+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2072	2017-02-17 21:32:15.249+00	2017-02-17 21:32:15.249+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2073	2017-02-17 21:32:15.384+00	2017-02-17 21:32:15.384+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2074	2017-02-17 21:32:15.635+00	2017-02-17 21:32:15.635+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2076	2017-02-17 21:32:15.924+00	2017-02-17 21:32:15.924+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2078	2017-02-17 21:32:16.362+00	2017-02-17 21:32:16.362+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2080	2017-02-17 21:32:17.291+00	2017-02-17 21:32:17.291+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2083	2017-02-17 21:32:19.387+00	2017-02-17 21:32:19.387+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2103	2017-02-17 21:32:31.258+00	2017-02-17 21:32:31.258+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2106	2017-02-17 21:32:31.855+00	2017-02-17 21:32:31.855+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2107	2017-02-17 21:32:31.948+00	2017-02-17 21:32:31.948+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2109	2017-02-17 21:32:32.239+00	2017-02-17 21:32:32.239+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2110	2017-02-17 21:32:32.302+00	2017-02-17 21:32:32.302+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2115	2017-02-17 21:32:32.692+00	2017-02-17 21:32:32.692+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2116	2017-02-17 21:32:32.818+00	2017-02-17 21:32:32.818+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2140	2017-02-17 21:33:16.004+00	2017-02-17 21:33:16.004+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2145	2017-02-17 21:33:17.27+00	2017-02-17 21:33:17.27+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2146	2017-02-17 21:33:17.341+00	2017-02-17 21:33:17.341+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2148	2017-02-17 21:33:17.863+00	2017-02-17 21:33:17.863+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2059	2017-02-17 21:32:12.924+00	2017-02-17 21:32:12.924+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2060	2017-02-17 21:32:13.039+00	2017-02-17 21:32:13.039+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2063	2017-02-17 21:32:13.297+00	2017-02-17 21:32:13.297+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2066	2017-02-17 21:32:13.891+00	2017-02-17 21:32:13.891+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2064	2017-02-17 21:32:13.53+00	2017-02-17 21:32:13.53+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2070	2017-02-17 21:32:15.05+00	2017-02-17 21:32:15.05+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2081	2017-02-17 21:32:17.69+00	2017-02-17 21:32:17.69+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2082	2017-02-17 21:32:19.174+00	2017-02-17 21:32:19.174+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2084	2017-02-17 21:32:19.952+00	2017-02-17 21:32:19.952+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2085	2017-02-17 21:32:20.223+00	2017-02-17 21:32:20.223+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2086	2017-02-17 21:32:20.919+00	2017-02-17 21:32:20.919+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2088	2017-02-17 21:32:21.374+00	2017-02-17 21:32:21.374+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2089	2014-01-01 09:17:56+00	2017-02-17 21:32:22.217+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 21:32:22.215+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2090	2014-01-01 09:17:56+00	2017-02-17 21:32:22.369+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2092	2014-01-01 09:17:56+00	2017-02-17 21:32:22.525+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2093	2017-02-17 21:32:30.322+00	2017-02-17 21:32:30.322+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2097	2017-02-17 21:32:30.823+00	2017-02-17 21:32:30.823+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2104	2017-02-17 21:32:31.348+00	2017-02-17 21:32:31.348+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2105	2017-02-17 21:32:31.426+00	2017-02-17 21:32:31.426+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2108	2017-02-17 21:32:32.032+00	2017-02-17 21:32:32.032+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2118	2017-02-17 21:32:33.031+00	2017-02-17 21:32:33.031+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2125	2017-02-17 21:32:49.942+00	2017-02-17 21:32:49.942+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2127	2017-02-17 21:33:04.442+00	2017-02-17 21:33:04.442+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2128	2017-02-17 21:33:04.646+00	2017-02-17 21:33:04.646+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2129	2017-02-17 21:33:13.606+00	2017-02-17 21:33:13.606+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2130	2017-02-17 21:33:13.75+00	2017-02-17 21:33:13.75+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2132	2017-02-17 21:33:14.126+00	2017-02-17 21:33:14.126+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2133	2017-02-17 21:33:14.248+00	2017-02-17 21:33:14.248+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2134	2017-02-17 21:33:14.352+00	2017-02-17 21:33:14.352+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2138	2017-02-17 21:33:15.206+00	2017-02-17 21:33:15.206+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2141	2017-02-17 21:33:16.516+00	2017-02-17 21:33:16.516+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2142	2017-02-17 21:33:16.722+00	2017-02-17 21:33:16.722+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2143	2017-02-17 21:33:16.839+00	2017-02-17 21:33:16.839+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2144	2017-02-17 21:33:17.012+00	2017-02-17 21:33:17.012+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2147	2017-02-17 21:33:17.636+00	2017-02-17 21:33:17.636+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2069	2017-02-17 21:32:14.851+00	2017-02-17 21:32:14.851+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2071	2017-02-17 21:32:15.17+00	2017-02-17 21:32:15.17+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2075	2017-02-17 21:32:15.705+00	2017-02-17 21:32:15.705+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2077	2017-02-17 21:32:16.1+00	2017-02-17 21:32:16.1+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2079	2017-02-17 21:32:16.555+00	2017-02-17 21:32:16.555+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2091	2014-01-01 09:17:56+00	2017-02-17 21:32:22.444+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2094	2017-02-17 21:32:30.49+00	2017-02-17 21:32:30.49+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2095	2017-02-17 21:32:30.594+00	2017-02-17 21:32:30.594+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2096	2017-02-17 21:32:30.757+00	2017-02-17 21:32:30.757+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2098	2017-02-17 21:32:30.927+00	2017-02-17 21:32:30.927+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2099	2017-02-17 21:32:30.977+00	2017-02-17 21:32:30.977+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2100	2017-02-17 21:32:31.04+00	2017-02-17 21:32:31.04+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2101	2017-02-17 21:32:31.116+00	2017-02-17 21:32:31.116+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2102	2017-02-17 21:32:31.182+00	2017-02-17 21:32:31.182+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2111	2017-02-17 21:32:32.373+00	2017-02-17 21:32:32.373+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2112	2017-02-17 21:32:32.504+00	2017-02-17 21:32:32.504+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2113	2017-02-17 21:32:32.596+00	2017-02-17 21:32:32.596+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2114	2017-02-17 21:32:32.644+00	2017-02-17 21:32:32.644+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2117	2017-02-17 21:32:32.91+00	2017-02-17 21:32:32.91+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2119	2017-02-17 21:32:33.125+00	2017-02-17 21:32:33.125+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2120	2017-02-17 21:32:33.306+00	2017-02-17 21:32:33.306+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2121	2017-02-17 21:32:33.414+00	2017-02-17 21:32:33.414+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2122	2017-02-17 21:32:40.804+00	2017-02-17 21:32:40.804+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2123	2017-02-17 21:32:41.039+00	2017-02-17 21:32:41.039+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2139	2017-02-17 21:33:15.642+00	2017-02-17 21:33:15.642+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2149	2017-02-17 21:33:18.032+00	2017-02-17 21:33:18.032+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2087	2017-02-17 21:32:21.177+00	2017-02-17 21:32:21.177+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2124	2017-02-17 21:32:49.778+00	2017-02-17 21:32:49.778+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2126	2017-02-17 21:32:50.031+00	2017-02-17 21:32:50.031+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2131	2017-02-17 21:33:13.945+00	2017-02-17 21:33:13.945+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2135	2017-02-17 21:33:14.445+00	2017-02-17 21:33:14.445+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2136	2017-02-17 21:33:14.545+00	2017-02-17 21:33:14.545+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2137	2017-02-17 21:33:14.796+00	2017-02-17 21:33:14.795+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2150	2017-02-17 21:33:26.323+00	2017-02-17 21:33:26.323+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2151	2017-02-17 21:33:26.58+00	2017-02-17 21:33:26.58+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2152	2017-02-17 21:33:26.667+00	2017-02-17 21:33:26.667+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2153	2017-02-17 21:33:35.253+00	2017-02-17 21:33:35.253+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2154	2017-02-17 21:33:35.516+00	2017-02-17 21:33:35.516+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2155	2017-02-17 21:33:49.74+00	2017-02-17 21:33:49.74+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2156	2017-02-17 21:33:49.999+00	2017-02-17 21:33:49.999+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2157	2017-02-17 21:33:56.99+00	2017-02-17 21:33:56.99+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2158	2017-02-17 21:33:57.145+00	2017-02-17 21:33:57.145+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2159	2017-02-17 21:34:04.255+00	2017-02-17 21:34:04.255+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2160	2017-02-17 21:34:04.404+00	2017-02-17 21:34:04.404+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2161	2017-02-17 21:34:04.534+00	2017-02-17 21:34:04.534+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2162	2014-01-01 09:17:56+00	2017-02-17 21:34:05.324+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-02-17 21:34:05.322+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2163	2014-01-01 09:17:56+00	2017-02-17 21:34:05.478+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2164	2014-01-01 09:17:56+00	2017-02-17 21:34:05.625+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2165	2014-01-01 09:17:56+00	2017-02-17 21:34:05.695+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2166	2017-02-17 21:34:14.66+00	2017-02-17 21:34:14.66+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2167	2017-02-17 21:34:14.765+00	2017-02-17 21:34:14.765+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2168	2017-02-17 21:34:14.862+00	2017-02-17 21:34:14.862+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2169	2017-02-17 21:34:15.002+00	2017-02-17 21:34:15.002+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2170	2017-02-17 21:34:15.071+00	2017-02-17 21:34:15.071+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2171	2017-02-17 21:34:15.114+00	2017-02-17 21:34:15.114+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2172	2017-02-17 21:34:15.227+00	2017-02-17 21:34:15.227+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2173	2017-02-17 21:34:15.309+00	2017-02-17 21:34:15.309+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2174	2017-02-17 21:34:15.397+00	2017-02-17 21:34:15.397+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2175	2017-02-17 21:34:15.478+00	2017-02-17 21:34:15.478+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2176	2017-02-17 21:34:15.556+00	2017-02-17 21:34:15.556+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2177	2017-02-17 21:34:15.656+00	2017-02-17 21:34:15.656+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2178	2017-02-17 21:34:15.781+00	2017-02-17 21:34:15.781+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2179	2017-02-17 21:34:16.163+00	2017-02-17 21:34:16.163+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2180	2017-02-17 21:34:16.278+00	2017-02-17 21:34:16.278+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2181	2017-02-17 21:34:16.34+00	2017-02-17 21:34:16.34+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2182	2017-02-17 21:34:16.479+00	2017-02-17 21:34:16.479+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2183	2017-02-17 21:34:16.526+00	2017-02-17 21:34:16.526+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2184	2017-02-17 21:34:16.566+00	2017-02-17 21:34:16.566+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2185	2017-02-17 21:34:16.708+00	2017-02-17 21:34:16.708+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2186	2017-02-17 21:34:16.791+00	2017-02-17 21:34:16.791+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2187	2017-02-17 21:34:16.899+00	2017-02-17 21:34:16.899+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2188	2017-02-17 21:34:17.091+00	2017-02-17 21:34:17.091+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2189	2017-02-17 21:34:17.198+00	2017-02-17 21:34:17.198+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2190	2017-02-17 21:34:17.295+00	2017-02-17 21:34:17.295+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2191	2017-02-17 21:34:17.385+00	2017-02-17 21:34:17.385+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2192	2017-02-17 21:34:17.491+00	2017-02-17 21:34:17.491+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2193	2017-02-17 21:34:17.697+00	2017-02-17 21:34:17.697+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2194	2017-02-17 21:34:17.841+00	2017-02-17 21:34:17.841+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2195	2017-02-17 21:50:37.795+00	2017-02-17 21:50:37.795+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2196	2017-02-17 21:51:07.114+00	2017-02-17 21:51:07.114+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2197	2017-06-13 16:17:08.089+00	2017-06-13 16:17:08.089+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	BIO	\N	\N	\N	\N
2198	2017-06-13 16:17:09.531+00	2017-06-13 16:17:09.531+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	BIO	\N	\N	\N	\N
2199	2017-06-13 16:17:44.373+00	2017-06-13 16:17:44.373+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2200	2017-06-13 16:18:17.857+00	2017-06-13 16:18:17.857+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	AFFILIATION	\N	\N	\N	\N
2201	2017-06-13 16:18:18.574+00	2017-06-13 16:18:18.574+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2202	2017-06-13 16:18:50.66+00	2017-06-13 16:18:50.66+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2203	2017-06-13 16:18:51.444+00	2017-06-13 16:18:51.444+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2204	2017-06-13 16:18:52.078+00	2017-06-13 16:18:52.078+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EXTERNAL_IDENTIFIERS	\N	\N	\N	\N
2205	2017-06-13 16:20:01.695+00	2017-06-13 16:20:01.695+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2206	2017-06-13 16:20:02.011+00	2017-06-13 16:20:02.011+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2207	2017-06-13 16:20:02.841+00	2017-06-13 16:20:02.841+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2208	2017-06-13 16:20:02.962+00	2017-06-13 16:20:02.962+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2209	2017-06-13 16:20:03.172+00	2017-06-13 16:20:03.172+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2210	2017-06-13 16:20:03.371+00	2017-06-13 16:20:03.371+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2211	2017-06-13 16:20:03.905+00	2017-06-13 16:20:03.905+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2212	2017-06-13 16:20:04.083+00	2017-06-13 16:20:04.083+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2213	2017-06-13 16:20:42.573+00	2017-06-13 16:20:42.573+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2214	2017-06-13 16:20:42.726+00	2017-06-13 16:20:42.726+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2215	2017-06-13 16:20:43.119+00	2017-06-13 16:20:43.119+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	AFFILIATION	\N	\N	\N	\N
2216	2017-06-13 16:20:43.969+00	2017-06-13 16:20:43.969+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2217	2017-06-13 16:20:44.072+00	2017-06-13 16:20:44.072+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2218	2017-06-13 16:20:44.264+00	2017-06-13 16:20:44.264+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2219	2017-06-13 16:20:48.896+00	2017-06-13 16:20:48.896+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	AFFILIATION	\N	\N	\N	\N
2220	2017-06-13 16:20:49.023+00	2017-06-13 16:20:49.023+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	AFFILIATION	\N	\N	\N	\N
2221	2017-06-13 16:20:49.545+00	2017-06-13 16:20:49.545+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2222	2017-06-13 16:20:49.634+00	2017-06-13 16:20:49.634+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	EMPLOYMENT	\N	\N	\N	\N
2223	2017-06-13 16:21:26.865+00	2017-06-13 16:21:26.865+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	BIO	\N	\N	\N	\N
2224	2017-06-13 16:21:38.812+00	2017-06-13 16:21:38.812+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2225	2017-06-13 16:21:40.102+00	2017-06-13 16:21:40.102+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2226	2017-06-13 16:21:40.342+00	2017-06-13 16:21:40.342+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2227	2017-06-13 16:21:40.78+00	2017-06-13 16:21:40.78+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2231	2017-06-13 16:22:15.987+00	2017-06-13 16:22:15.987+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2233	2017-06-13 16:22:16.605+00	2017-06-13 16:22:16.605+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2235	2017-06-13 16:22:16.993+00	2017-06-13 16:22:16.993+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2238	2017-06-13 16:22:17.431+00	2017-06-13 16:22:17.431+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2240	2017-06-13 16:22:17.815+00	2017-06-13 16:22:17.815+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2242	2017-06-13 16:22:18.251+00	2017-06-13 16:22:18.251+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2252	2017-06-13 16:22:20.449+00	2017-06-13 16:22:20.449+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2283	2017-06-13 16:22:25.704+00	2017-06-13 16:22:25.704+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2284	2017-06-13 16:22:25.872+00	2017-06-13 16:22:25.872+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2285	2017-06-13 16:24:02.551+00	2017-06-13 16:24:02.551+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2286	2017-06-13 16:24:02.698+00	2017-06-13 16:24:02.698+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2288	2017-06-13 16:24:09.514+00	2017-06-13 16:24:09.514+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2290	2017-06-13 16:24:11.331+00	2017-06-13 16:24:11.331+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2291	2017-06-13 16:24:11.869+00	2017-06-13 16:24:11.869+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2298	2017-06-13 16:24:19.517+00	2017-06-13 16:24:19.517+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2300	2017-06-13 16:24:20.406+00	2017-06-13 16:24:20.406+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2301	2017-06-13 16:24:21.086+00	2017-06-13 16:24:21.086+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2303	2017-06-13 16:24:24.259+00	2017-06-13 16:24:24.259+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2305	2017-06-13 16:24:25.375+00	2017-06-13 16:24:25.375+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2308	2017-06-13 16:24:25.766+00	2017-06-13 16:24:25.766+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2312	2017-06-13 16:24:26.265+00	2017-06-13 16:24:26.265+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2313	2017-06-13 16:24:26.323+00	2017-06-13 16:24:26.323+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2314	2017-06-13 16:24:26.395+00	2017-06-13 16:24:26.395+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2315	2017-06-13 16:24:26.467+00	2017-06-13 16:24:26.467+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2319	2017-06-13 16:24:26.821+00	2017-06-13 16:24:26.821+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2330	2017-06-13 16:24:28.68+00	2017-06-13 16:24:28.68+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2333	2017-06-13 16:24:29.116+00	2017-06-13 16:24:29.116+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2344	2017-06-13 16:24:29.974+00	2017-06-13 16:24:29.974+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2347	2017-06-13 16:24:32.871+00	2017-06-13 16:24:32.871+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2348	2017-06-13 16:24:35.015+00	2017-06-13 16:24:35.015+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2364	2017-06-13 16:24:36.839+00	2017-06-13 16:24:36.839+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2368	2017-06-13 16:24:37.291+00	2017-06-13 16:24:37.291+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2373	2017-06-13 16:24:38.141+00	2017-06-13 16:24:38.141+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2376	2017-06-13 16:24:38.334+00	2017-06-13 16:24:38.334+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2378	2017-06-13 16:24:38.535+00	2017-06-13 16:24:38.535+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2379	2017-06-13 16:24:38.573+00	2017-06-13 16:24:38.573+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2380	2017-06-13 16:24:38.611+00	2017-06-13 16:24:38.611+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2381	2017-06-13 16:24:38.66+00	2017-06-13 16:24:38.66+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2382	2017-06-13 16:24:38.697+00	2017-06-13 16:24:38.697+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2386	2017-06-13 16:24:38.948+00	2017-06-13 16:24:38.948+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2395	2017-06-13 16:24:45.642+00	2017-06-13 16:24:45.642+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2396	2017-06-13 16:24:45.831+00	2017-06-13 16:24:45.831+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2405	2017-06-13 16:24:48.924+00	2017-06-13 16:24:48.924+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2406	2017-06-13 16:24:48.974+00	2017-06-13 16:24:48.974+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2407	2017-06-13 16:24:49.07+00	2017-06-13 16:24:49.07+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2410	2017-06-13 16:24:49.372+00	2017-06-13 16:24:49.372+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2418	2017-06-13 16:24:50.027+00	2017-06-13 16:24:50.027+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2419	2017-06-13 16:24:50.113+00	2017-06-13 16:24:50.113+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2420	2017-06-13 16:24:50.737+00	2017-06-13 16:24:50.737+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2426	2017-06-13 16:24:51.217+00	2017-06-13 16:24:51.217+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2435	2017-06-13 16:24:51.772+00	2017-06-13 16:24:51.772+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2440	2017-06-13 16:24:54.753+00	2017-06-13 16:24:54.753+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2443	2017-06-13 16:24:55.984+00	2017-06-13 16:24:55.984+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2445	2017-06-13 16:24:58.858+00	2017-06-13 16:24:58.858+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2228	2017-06-13 16:21:41.013+00	2017-06-13 16:21:41.013+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2229	2017-06-13 16:22:15.724+00	2017-06-13 16:22:15.724+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2230	2017-06-13 16:22:15.782+00	2017-06-13 16:22:15.782+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2232	2017-06-13 16:22:16.47+00	2017-06-13 16:22:16.47+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2239	2017-06-13 16:22:17.616+00	2017-06-13 16:22:17.616+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2241	2017-06-13 16:22:17.954+00	2017-06-13 16:22:17.954+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2261	2017-06-13 16:22:21.79+00	2017-06-13 16:22:21.79+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2264	2017-06-13 16:22:22.203+00	2017-06-13 16:22:22.203+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2270	2017-06-13 16:22:23.123+00	2017-06-13 16:22:23.123+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2271	2017-06-13 16:22:23.616+00	2017-06-13 16:22:23.616+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2272	2017-06-13 16:22:23.725+00	2017-06-13 16:22:23.725+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2292	2017-06-13 16:24:12.095+00	2017-06-13 16:24:12.095+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2293	2017-06-13 16:24:12.73+00	2017-06-13 16:24:12.73+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2295	2017-06-13 16:24:16.197+00	2017-06-13 16:24:16.197+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2318	2017-06-13 16:24:26.759+00	2017-06-13 16:24:26.759+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2320	2017-06-13 16:24:26.906+00	2017-06-13 16:24:26.906+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2323	2017-06-13 16:24:27.233+00	2017-06-13 16:24:27.233+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2325	2017-06-13 16:24:27.442+00	2017-06-13 16:24:27.442+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2328	2017-06-13 16:24:28.527+00	2017-06-13 16:24:28.527+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2332	2017-06-13 16:24:28.97+00	2017-06-13 16:24:28.97+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2336	2017-06-13 16:24:29.319+00	2017-06-13 16:24:29.319+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2338	2017-06-13 16:24:29.513+00	2017-06-13 16:24:29.513+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2340	2017-06-13 16:24:29.669+00	2017-06-13 16:24:29.669+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2342	2017-06-13 16:24:29.849+00	2017-06-13 16:24:29.849+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2343	2017-06-13 16:24:29.925+00	2017-06-13 16:24:29.925+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2349	2017-06-13 16:24:35.542+00	2017-06-13 16:24:35.542+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2350	2017-06-13 16:24:35.775+00	2017-06-13 16:24:35.775+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2354	2017-06-13 16:24:36.016+00	2017-06-13 16:24:36.016+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2356	2017-06-13 16:24:36.156+00	2017-06-13 16:24:36.156+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2358	2017-06-13 16:24:36.337+00	2017-06-13 16:24:36.337+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2363	2017-06-13 16:24:36.786+00	2017-06-13 16:24:36.786+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2383	2017-06-13 16:24:38.74+00	2017-06-13 16:24:38.74+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2384	2017-06-13 16:24:38.781+00	2017-06-13 16:24:38.781+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2385	2017-06-13 16:24:38.853+00	2017-06-13 16:24:38.853+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2441	2017-06-13 16:24:55.174+00	2017-06-13 16:24:55.174+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2442	2017-06-13 16:24:55.368+00	2017-06-13 16:24:55.368+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2234	2017-06-13 16:22:16.801+00	2017-06-13 16:22:16.801+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2236	2017-06-13 16:22:17.181+00	2017-06-13 16:22:17.181+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2237	2017-06-13 16:22:17.278+00	2017-06-13 16:22:17.278+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2243	2017-06-13 16:22:18.521+00	2017-06-13 16:22:18.521+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2244	2017-06-13 16:22:18.687+00	2017-06-13 16:22:18.687+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2245	2017-06-13 16:22:19.453+00	2017-06-13 16:22:19.453+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2246	2017-06-13 16:22:19.557+00	2017-06-13 16:22:19.557+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2247	2017-06-13 16:22:19.675+00	2017-06-13 16:22:19.675+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2248	2017-06-13 16:22:19.769+00	2017-06-13 16:22:19.769+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2253	2017-06-13 16:22:20.538+00	2017-06-13 16:22:20.538+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2256	2017-06-13 16:22:21.01+00	2017-06-13 16:22:21.01+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2258	2017-06-13 16:22:21.338+00	2017-06-13 16:22:21.338+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2260	2017-06-13 16:22:21.658+00	2017-06-13 16:22:21.658+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2262	2017-06-13 16:22:21.954+00	2017-06-13 16:22:21.954+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2267	2017-06-13 16:22:22.584+00	2017-06-13 16:22:22.584+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2268	2017-06-13 16:22:22.875+00	2017-06-13 16:22:22.875+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2273	2017-06-13 16:22:23.833+00	2017-06-13 16:22:23.833+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2274	2017-06-13 16:22:23.951+00	2017-06-13 16:22:23.951+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2275	2017-06-13 16:22:24.163+00	2017-06-13 16:22:24.163+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2276	2017-06-13 16:22:24.279+00	2017-06-13 16:22:24.279+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2287	2017-06-13 16:24:07.151+00	2017-06-13 16:24:07.151+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2289	2017-06-13 16:24:10.423+00	2017-06-13 16:24:10.423+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2294	2017-06-13 16:24:15.066+00	2017-06-13 16:24:15.066+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2296	2017-06-13 16:24:18.568+00	2017-06-13 16:24:18.568+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2302	2017-06-13 16:24:23.889+00	2017-06-13 16:24:23.889+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2306	2017-06-13 16:24:25.664+00	2017-06-13 16:24:25.664+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2307	2017-06-13 16:24:25.709+00	2017-06-13 16:24:25.709+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2309	2017-06-13 16:24:25.872+00	2017-06-13 16:24:25.872+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2310	2017-06-13 16:24:25.969+00	2017-06-13 16:24:25.969+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2311	2017-06-13 16:24:26.07+00	2017-06-13 16:24:26.07+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2327	2017-06-13 16:24:28.372+00	2017-06-13 16:24:28.372+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2334	2017-06-13 16:24:29.176+00	2017-06-13 16:24:29.176+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2335	2017-06-13 16:24:29.224+00	2017-06-13 16:24:29.224+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2337	2017-06-13 16:24:29.404+00	2017-06-13 16:24:29.404+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2339	2017-06-13 16:24:29.604+00	2017-06-13 16:24:29.604+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2346	2017-06-13 16:24:32.458+00	2017-06-13 16:24:32.458+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2351	2017-06-13 16:24:35.847+00	2017-06-13 16:24:35.847+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2352	2017-06-13 16:24:35.893+00	2017-06-13 16:24:35.893+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2353	2017-06-13 16:24:35.948+00	2017-06-13 16:24:35.948+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2355	2017-06-13 16:24:36.094+00	2017-06-13 16:24:36.094+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2357	2017-06-13 16:24:36.267+00	2017-06-13 16:24:36.267+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2360	2017-06-13 16:24:36.567+00	2017-06-13 16:24:36.567+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2361	2017-06-13 16:24:36.615+00	2017-06-13 16:24:36.615+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2366	2017-06-13 16:24:37.038+00	2017-06-13 16:24:37.038+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2372	2017-06-13 16:24:38.018+00	2017-06-13 16:24:38.018+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2374	2017-06-13 16:24:38.189+00	2017-06-13 16:24:38.189+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2388	2017-06-13 16:24:39.042+00	2017-06-13 16:24:39.042+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2398	2017-06-13 16:24:47.824+00	2017-06-13 16:24:47.824+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2402	2017-06-13 16:24:48.572+00	2017-06-13 16:24:48.572+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2404	2017-06-13 16:24:48.764+00	2017-06-13 16:24:48.764+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2408	2017-06-13 16:24:49.175+00	2017-06-13 16:24:49.175+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2422	2017-06-13 16:24:50.897+00	2017-06-13 16:24:50.897+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2433	2017-06-13 16:24:51.636+00	2017-06-13 16:24:51.636+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2436	2017-06-13 16:24:51.861+00	2017-06-13 16:24:51.861+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2437	2017-06-13 16:24:51.968+00	2017-06-13 16:24:51.968+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2438	2017-06-13 16:24:52.055+00	2017-06-13 16:24:52.055+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2439	2017-06-13 16:24:52.094+00	2017-06-13 16:24:52.094+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2446	2017-06-13 16:24:59.074+00	2017-06-13 16:24:59.074+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2447	2017-06-13 16:24:59.565+00	2017-06-13 16:24:59.565+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2249	2017-06-13 16:22:19.923+00	2017-06-13 16:22:19.923+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2250	2017-06-13 16:22:20.124+00	2017-06-13 16:22:20.124+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2251	2017-06-13 16:22:20.298+00	2017-06-13 16:22:20.298+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2254	2017-06-13 16:22:20.637+00	2017-06-13 16:22:20.637+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2255	2017-06-13 16:22:20.719+00	2017-06-13 16:22:20.719+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2257	2017-06-13 16:22:21.109+00	2017-06-13 16:22:21.109+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2259	2017-06-13 16:22:21.507+00	2017-06-13 16:22:21.507+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2263	2017-06-13 16:22:22.103+00	2017-06-13 16:22:22.103+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2265	2017-06-13 16:22:22.32+00	2017-06-13 16:22:22.32+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2266	2017-06-13 16:22:22.465+00	2017-06-13 16:22:22.465+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2269	2017-06-13 16:22:22.999+00	2017-06-13 16:22:22.999+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2277	2017-06-13 16:22:24.343+00	2017-06-13 16:22:24.343+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2278	2017-06-13 16:22:24.568+00	2017-06-13 16:22:24.568+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2279	2017-06-13 16:22:24.844+00	2017-06-13 16:22:24.844+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2280	2017-06-13 16:22:25.004+00	2017-06-13 16:22:25.004+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2281	2017-06-13 16:22:25.319+00	2017-06-13 16:22:25.319+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2282	2017-06-13 16:22:25.394+00	2017-06-13 16:22:25.394+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2297	2017-06-13 16:24:19.256+00	2017-06-13 16:24:19.256+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2299	2017-06-13 16:24:20.065+00	2017-06-13 16:24:20.065+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2304	2017-06-13 16:24:24.641+00	2017-06-13 16:24:24.641+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2316	2017-06-13 16:24:26.582+00	2017-06-13 16:24:26.582+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2317	2017-06-13 16:24:26.69+00	2017-06-13 16:24:26.69+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2321	2017-06-13 16:24:26.987+00	2017-06-13 16:24:26.987+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2322	2017-06-13 16:24:27.114+00	2017-06-13 16:24:27.114+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2324	2017-06-13 16:24:27.358+00	2017-06-13 16:24:27.358+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2326	2017-06-13 16:24:28.262+00	2017-06-13 16:24:28.262+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2329	2017-06-13 16:24:28.634+00	2017-06-13 16:24:28.634+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2331	2017-06-13 16:24:28.883+00	2017-06-13 16:24:28.883+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2341	2017-06-13 16:24:29.752+00	2017-06-13 16:24:29.752+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2345	2017-06-13 16:24:30.06+00	2017-06-13 16:24:30.06+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2359	2017-06-13 16:24:36.458+00	2017-06-13 16:24:36.458+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2362	2017-06-13 16:24:36.725+00	2017-06-13 16:24:36.725+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2365	2017-06-13 16:24:36.91+00	2017-06-13 16:24:36.91+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2367	2017-06-13 16:24:37.128+00	2017-06-13 16:24:37.128+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2369	2017-06-13 16:24:37.418+00	2017-06-13 16:24:37.418+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2370	2017-06-13 16:24:37.817+00	2017-06-13 16:24:37.817+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2371	2017-06-13 16:24:37.925+00	2017-06-13 16:24:37.925+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2375	2017-06-13 16:24:38.26+00	2017-06-13 16:24:38.26+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2377	2017-06-13 16:24:38.435+00	2017-06-13 16:24:38.435+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2387	2017-06-13 16:24:38.999+00	2017-06-13 16:24:38.999+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2389	2017-06-13 16:24:39.091+00	2017-06-13 16:24:39.091+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2390	2017-06-13 16:24:39.296+00	2017-06-13 16:24:39.296+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2391	2017-06-13 16:24:40.027+00	2017-06-13 16:24:40.027+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2392	2017-06-13 16:24:42.845+00	2017-06-13 16:24:42.845+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2393	2017-06-13 16:24:43.116+00	2017-06-13 16:24:43.116+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2394	2017-06-13 16:24:45.217+00	2017-06-13 16:24:45.217+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2397	2017-06-13 16:24:46.381+00	2017-06-13 16:24:46.381+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2399	2017-06-13 16:24:48.217+00	2017-06-13 16:24:48.217+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2400	2017-06-13 16:24:48.436+00	2017-06-13 16:24:48.436+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2401	2017-06-13 16:24:48.524+00	2017-06-13 16:24:48.524+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2403	2017-06-13 16:24:48.656+00	2017-06-13 16:24:48.656+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2409	2017-06-13 16:24:49.274+00	2017-06-13 16:24:49.274+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2411	2017-06-13 16:24:49.478+00	2017-06-13 16:24:49.478+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2412	2017-06-13 16:24:49.579+00	2017-06-13 16:24:49.579+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2413	2017-06-13 16:24:49.651+00	2017-06-13 16:24:49.651+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2414	2017-06-13 16:24:49.701+00	2017-06-13 16:24:49.701+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2415	2017-06-13 16:24:49.767+00	2017-06-13 16:24:49.767+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2416	2017-06-13 16:24:49.829+00	2017-06-13 16:24:49.829+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2417	2017-06-13 16:24:49.91+00	2017-06-13 16:24:49.91+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2421	2017-06-13 16:24:50.819+00	2017-06-13 16:24:50.819+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2423	2017-06-13 16:24:50.997+00	2017-06-13 16:24:50.997+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2424	2017-06-13 16:24:51.094+00	2017-06-13 16:24:51.094+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2425	2017-06-13 16:24:51.14+00	2017-06-13 16:24:51.14+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2427	2017-06-13 16:24:51.301+00	2017-06-13 16:24:51.301+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2428	2017-06-13 16:24:51.353+00	2017-06-13 16:24:51.353+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2429	2017-06-13 16:24:51.434+00	2017-06-13 16:24:51.434+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2430	2017-06-13 16:24:51.469+00	2017-06-13 16:24:51.469+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2432	2017-06-13 16:24:51.568+00	2017-06-13 16:24:51.568+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2434	2017-06-13 16:24:51.72+00	2017-06-13 16:24:51.72+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2444	2017-06-13 16:24:58.524+00	2017-06-13 16:24:58.524+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2431	2017-06-13 16:24:51.533+00	2017-06-13 16:24:51.533+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2448	2017-06-13 16:25:31.805+00	2017-06-13 16:25:31.805+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2449	2017-06-13 16:25:34.739+00	2017-06-13 16:25:34.739+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2450	2017-06-13 16:25:34.802+00	2017-06-13 16:25:34.802+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2451	2017-06-13 16:25:35.015+00	2017-06-13 16:25:35.015+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2452	2017-06-13 16:25:35.242+00	2017-06-13 16:25:35.242+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2453	2017-06-13 16:25:35.892+00	2017-06-13 16:25:35.892+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2454	2017-06-13 16:25:36.096+00	2017-06-13 16:25:36.096+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2455	2017-06-13 16:25:36.331+00	2017-06-13 16:25:36.331+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2456	2017-06-13 16:25:36.439+00	2017-06-13 16:25:36.439+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2457	2017-06-13 16:25:36.689+00	2017-06-13 16:25:36.689+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2458	2014-01-01 09:17:56+00	2017-06-13 16:25:37.431+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-06-13 16:25:37.429+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2459	2014-01-01 09:17:56+00	2017-06-13 16:25:37.644+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2460	2014-01-01 09:17:56+00	2017-06-13 16:25:37.955+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2461	2014-01-01 09:17:56+00	2017-06-13 16:25:38.162+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2462	2017-06-13 16:25:42.868+00	2017-06-13 16:25:42.868+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2463	2017-06-13 16:25:43.184+00	2017-06-13 16:25:43.184+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2464	2017-06-13 16:25:43.341+00	2017-06-13 16:25:43.341+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2465	2017-06-13 16:25:43.51+00	2017-06-13 16:25:43.51+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2466	2017-06-13 16:25:43.6+00	2017-06-13 16:25:43.6+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2467	2017-06-13 16:25:43.695+00	2017-06-13 16:25:43.695+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2468	2017-06-13 16:25:43.998+00	2017-06-13 16:25:43.998+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2469	2017-06-13 16:25:44.084+00	2017-06-13 16:25:44.084+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2470	2017-06-13 16:25:44.123+00	2017-06-13 16:25:44.123+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2471	2017-06-13 16:25:44.217+00	2017-06-13 16:25:44.217+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2472	2017-06-13 16:25:44.617+00	2017-06-13 16:25:44.617+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2473	2017-06-13 16:25:51.797+00	2017-06-13 16:25:51.797+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2474	2017-06-13 16:25:52.152+00	2017-06-13 16:25:52.152+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2475	2017-06-13 16:25:52.268+00	2017-06-13 16:25:52.268+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2476	2017-06-13 16:25:52.463+00	2017-06-13 16:25:52.463+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2477	2017-06-13 16:25:52.603+00	2017-06-13 16:25:52.603+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2478	2017-06-13 16:25:53.03+00	2017-06-13 16:25:53.03+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2479	2017-06-13 16:25:53.117+00	2017-06-13 16:25:53.117+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2480	2017-06-13 16:25:53.287+00	2017-06-13 16:25:53.287+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2481	2017-06-13 16:25:53.601+00	2017-06-13 16:25:53.601+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2482	2017-06-13 16:25:53.714+00	2017-06-13 16:25:53.714+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2483	2017-06-13 16:25:53.801+00	2017-06-13 16:25:53.801+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2484	2017-06-13 16:25:53.908+00	2017-06-13 16:25:53.908+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2485	2017-06-13 16:25:54.01+00	2017-06-13 16:25:54.01+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2486	2017-06-13 16:25:54.076+00	2017-06-13 16:25:54.076+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2487	2017-06-13 16:25:54.229+00	2017-06-13 16:25:54.229+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2488	2017-06-13 16:25:54.346+00	2017-06-13 16:25:54.346+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2489	2017-06-13 16:25:54.393+00	2017-06-13 16:25:54.393+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2490	2017-06-13 16:25:54.521+00	2017-06-13 16:25:54.521+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2491	2017-06-13 16:25:54.647+00	2017-06-13 16:25:54.647+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2492	2017-06-13 16:25:54.754+00	2017-06-13 16:25:54.754+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2493	2017-06-13 16:25:54.949+00	2017-06-13 16:25:54.949+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2494	2017-06-13 16:25:55.297+00	2017-06-13 16:25:55.297+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2495	2017-06-13 16:25:55.403+00	2017-06-13 16:25:55.403+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2496	2017-06-13 16:25:55.49+00	2017-06-13 16:25:55.49+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2497	2017-06-13 16:25:55.615+00	2017-06-13 16:25:55.615+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2498	2017-06-13 16:25:55.68+00	2017-06-13 16:25:55.68+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2499	2017-06-13 16:25:55.732+00	2017-06-13 16:25:55.732+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2500	2017-06-13 16:25:55.783+00	2017-06-13 16:25:55.783+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2501	2017-06-13 16:25:55.822+00	2017-06-13 16:25:55.822+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2502	2017-06-13 16:25:55.909+00	2017-06-13 16:25:55.909+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2503	2017-06-13 16:25:55.982+00	2017-06-13 16:25:55.981+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2504	2017-06-13 16:25:56.053+00	2017-06-13 16:25:56.053+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2505	2017-06-13 16:25:56.114+00	2017-06-13 16:25:56.114+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2506	2017-06-13 16:25:56.211+00	2017-06-13 16:25:56.211+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2508	2017-06-13 16:25:56.741+00	2017-06-13 16:25:56.741+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2512	2017-06-13 16:25:57.937+00	2017-06-13 16:25:57.937+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2513	2017-06-13 16:25:58.004+00	2017-06-13 16:25:58.004+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2519	2014-01-01 09:17:56+00	2017-06-13 16:25:59.519+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2535	2017-06-13 16:26:46.515+00	2017-06-13 16:26:46.515+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2536	2017-06-13 16:26:46.703+00	2017-06-13 16:26:46.703+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2538	2017-06-13 16:26:47.113+00	2017-06-13 16:26:47.113+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2541	2017-06-13 16:26:47.568+00	2017-06-13 16:26:47.568+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2543	2017-06-13 16:26:47.739+00	2017-06-13 16:26:47.739+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2544	2017-06-13 16:26:47.808+00	2017-06-13 16:26:47.808+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2545	2017-06-13 16:26:47.902+00	2017-06-13 16:26:47.902+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2546	2017-06-13 16:26:48.009+00	2017-06-13 16:26:48.009+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2548	2017-06-13 16:26:48.177+00	2017-06-13 16:26:48.177+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2550	2017-06-13 16:26:48.268+00	2017-06-13 16:26:48.268+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2554	2017-06-13 16:26:48.802+00	2017-06-13 16:26:48.802+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2555	2017-06-13 16:26:48.906+00	2017-06-13 16:26:48.906+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2507	2017-06-13 16:25:56.53+00	2017-06-13 16:25:56.53+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2510	2017-06-13 16:25:57.319+00	2017-06-13 16:25:57.319+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2511	2017-06-13 16:25:57.564+00	2017-06-13 16:25:57.564+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2518	2014-01-01 09:17:56+00	2017-06-13 16:25:59.285+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-06-13 16:25:59.281+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2520	2014-01-01 09:17:56+00	2017-06-13 16:25:59.656+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2521	2014-01-01 09:17:56+00	2017-06-13 16:25:59.812+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2522	2017-06-13 16:26:37.975+00	2017-06-13 16:26:37.975+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2523	2017-06-13 16:26:38.276+00	2017-06-13 16:26:38.276+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2525	2017-06-13 16:26:38.692+00	2017-06-13 16:26:38.692+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2526	2017-06-13 16:26:38.773+00	2017-06-13 16:26:38.773+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2527	2017-06-13 16:26:38.808+00	2017-06-13 16:26:38.808+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2528	2017-06-13 16:26:38.962+00	2017-06-13 16:26:38.962+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2529	2017-06-13 16:26:39.026+00	2017-06-13 16:26:39.026+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2533	2017-06-13 16:26:46.151+00	2017-06-13 16:26:46.151+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2537	2017-06-13 16:26:46.831+00	2017-06-13 16:26:46.831+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2539	2017-06-13 16:26:47.199+00	2017-06-13 16:26:47.199+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2542	2017-06-13 16:26:47.688+00	2017-06-13 16:26:47.688+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2547	2017-06-13 16:26:48.076+00	2017-06-13 16:26:48.076+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2549	2017-06-13 16:26:48.22+00	2017-06-13 16:26:48.22+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2552	2017-06-13 16:26:48.429+00	2017-06-13 16:26:48.429+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2556	2017-06-13 16:26:49.019+00	2017-06-13 16:26:49.019+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2557	2017-06-13 16:26:49.074+00	2017-06-13 16:26:49.074+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2558	2017-06-13 16:26:49.111+00	2017-06-13 16:26:49.111+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2559	2017-06-13 16:26:49.168+00	2017-06-13 16:26:49.168+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2566	2017-06-13 16:26:49.64+00	2017-06-13 16:26:49.64+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2568	2017-06-13 16:26:50.015+00	2017-06-13 16:26:50.015+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2570	2017-06-13 16:26:50.422+00	2017-06-13 16:26:50.422+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2572	2017-06-13 16:26:50.853+00	2017-06-13 16:26:50.853+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2573	2017-06-13 16:26:50.912+00	2017-06-13 16:26:50.912+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2577	2017-06-13 16:26:51.657+00	2017-06-13 16:26:51.657+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2580	2014-01-01 09:17:56+00	2017-06-13 16:26:52.331+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2596	2017-06-13 16:26:59.24+00	2017-06-13 16:26:59.24+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2597	2017-06-13 16:26:59.333+00	2017-06-13 16:26:59.333+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2603	2017-06-13 16:26:59.857+00	2017-06-13 16:26:59.857+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2605	2017-06-13 16:26:59.967+00	2017-06-13 16:26:59.967+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2613	2017-06-13 16:27:07.605+00	2017-06-13 16:27:07.605+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2509	2017-06-13 16:25:56.913+00	2017-06-13 16:25:56.913+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2514	2017-06-13 16:25:58.265+00	2017-06-13 16:25:58.265+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2515	2017-06-13 16:25:58.35+00	2017-06-13 16:25:58.35+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2517	2017-06-13 16:25:58.791+00	2017-06-13 16:25:58.791+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2524	2017-06-13 16:26:38.56+00	2017-06-13 16:26:38.56+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2530	2017-06-13 16:26:39.202+00	2017-06-13 16:26:39.202+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2531	2017-06-13 16:26:39.306+00	2017-06-13 16:26:39.306+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2532	2017-06-13 16:26:39.539+00	2017-06-13 16:26:39.539+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2534	2017-06-13 16:26:46.405+00	2017-06-13 16:26:46.405+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2540	2017-06-13 16:26:47.28+00	2017-06-13 16:26:47.28+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2551	2017-06-13 16:26:48.334+00	2017-06-13 16:26:48.334+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2562	2017-06-13 16:26:49.384+00	2017-06-13 16:26:49.384+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2563	2017-06-13 16:26:49.446+00	2017-06-13 16:26:49.446+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2567	2017-06-13 16:26:49.849+00	2017-06-13 16:26:49.849+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2571	2017-06-13 16:26:50.603+00	2017-06-13 16:26:50.603+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2583	2017-06-13 16:26:57.757+00	2017-06-13 16:26:57.757+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2586	2017-06-13 16:26:58.325+00	2017-06-13 16:26:58.325+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2588	2017-06-13 16:26:58.456+00	2017-06-13 16:26:58.456+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2589	2017-06-13 16:26:58.495+00	2017-06-13 16:26:58.495+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2599	2017-06-13 16:26:59.533+00	2017-06-13 16:26:59.533+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2600	2017-06-13 16:26:59.6+00	2017-06-13 16:26:59.6+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2604	2017-06-13 16:26:59.931+00	2017-06-13 16:26:59.931+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2606	2017-06-13 16:27:00.011+00	2017-06-13 16:27:00.011+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2615	2017-06-13 16:27:07.963+00	2017-06-13 16:27:07.963+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2616	2017-06-13 16:27:08.164+00	2017-06-13 16:27:08.164+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2618	2017-06-13 16:27:08.279+00	2017-06-13 16:27:08.279+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2628	2017-06-13 16:27:09.151+00	2017-06-13 16:27:09.151+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2516	2017-06-13 16:25:58.572+00	2017-06-13 16:25:58.572+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2553	2017-06-13 16:26:48.513+00	2017-06-13 16:26:48.513+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2560	2017-06-13 16:26:49.231+00	2017-06-13 16:26:49.231+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2561	2017-06-13 16:26:49.299+00	2017-06-13 16:26:49.299+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2564	2017-06-13 16:26:49.511+00	2017-06-13 16:26:49.511+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2565	2017-06-13 16:26:49.553+00	2017-06-13 16:26:49.553+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2569	2017-06-13 16:26:50.085+00	2017-06-13 16:26:50.085+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2574	2017-06-13 16:26:51.19+00	2017-06-13 16:26:51.19+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2575	2017-06-13 16:26:51.301+00	2017-06-13 16:26:51.301+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2576	2017-06-13 16:26:51.544+00	2017-06-13 16:26:51.544+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2578	2014-01-01 09:17:56+00	2017-06-13 16:26:51.969+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-06-13 16:26:51.968+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2579	2014-01-01 09:17:56+00	2017-06-13 16:26:52.188+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2581	2014-01-01 09:17:56+00	2017-06-13 16:26:52.574+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2582	2017-06-13 16:26:57.531+00	2017-06-13 16:26:57.531+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2584	2017-06-13 16:26:57.88+00	2017-06-13 16:26:57.88+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2585	2017-06-13 16:26:58.279+00	2017-06-13 16:26:58.279+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2587	2017-06-13 16:26:58.391+00	2017-06-13 16:26:58.391+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2590	2017-06-13 16:26:58.541+00	2017-06-13 16:26:58.541+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2591	2017-06-13 16:26:58.584+00	2017-06-13 16:26:58.584+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2592	2017-06-13 16:26:58.661+00	2017-06-13 16:26:58.661+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2593	2017-06-13 16:26:58.713+00	2017-06-13 16:26:58.713+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2594	2017-06-13 16:26:58.778+00	2017-06-13 16:26:58.778+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2595	2017-06-13 16:26:59.2+00	2017-06-13 16:26:59.2+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2598	2017-06-13 16:26:59.499+00	2017-06-13 16:26:59.499+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2601	2017-06-13 16:26:59.73+00	2017-06-13 16:26:59.73+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2602	2017-06-13 16:26:59.822+00	2017-06-13 16:26:59.822+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2607	2017-06-13 16:27:00.042+00	2017-06-13 16:27:00.042+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2608	2017-06-13 16:27:00.101+00	2017-06-13 16:27:00.101+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2609	2017-06-13 16:27:00.329+00	2017-06-13 16:27:00.329+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2610	2017-06-13 16:27:00.439+00	2017-06-13 16:27:00.439+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2611	2017-06-13 16:27:07.208+00	2017-06-13 16:27:07.208+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2612	2017-06-13 16:27:07.475+00	2017-06-13 16:27:07.475+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2614	2017-06-13 16:27:07.856+00	2017-06-13 16:27:07.856+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2617	2017-06-13 16:27:08.201+00	2017-06-13 16:27:08.201+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2619	2017-06-13 16:27:08.601+00	2017-06-13 16:27:08.601+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2620	2017-06-13 16:27:08.712+00	2017-06-13 16:27:08.712+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2621	2017-06-13 16:27:08.781+00	2017-06-13 16:27:08.781+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2622	2017-06-13 16:27:08.827+00	2017-06-13 16:27:08.827+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2623	2017-06-13 16:27:08.876+00	2017-06-13 16:27:08.876+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2624	2017-06-13 16:27:08.93+00	2017-06-13 16:27:08.93+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2625	2017-06-13 16:27:08.967+00	2017-06-13 16:27:08.967+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2626	2017-06-13 16:27:09.022+00	2017-06-13 16:27:09.022+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2627	2017-06-13 16:27:09.057+00	2017-06-13 16:27:09.057+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2629	2017-06-13 16:27:09.236+00	2017-06-13 16:27:09.236+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2630	2017-06-13 16:27:09.299+00	2017-06-13 16:27:09.299+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2631	2017-06-13 16:27:09.423+00	2017-06-13 16:27:09.423+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2632	2017-06-13 16:27:09.641+00	2017-06-13 16:27:09.641+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2633	2017-06-13 16:27:09.681+00	2017-06-13 16:27:09.681+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2634	2017-06-13 16:27:09.717+00	2017-06-13 16:27:09.717+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2635	2017-06-13 16:27:09.775+00	2017-06-13 16:27:09.775+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2636	2017-06-13 16:27:09.858+00	2017-06-13 16:27:09.858+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2637	2017-06-13 16:27:09.91+00	2017-06-13 16:27:09.91+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2638	2017-06-13 16:27:10.038+00	2017-06-13 16:27:10.038+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2639	2017-06-13 16:27:10.077+00	2017-06-13 16:27:10.077+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2640	2017-06-13 16:27:10.14+00	2017-06-13 16:27:10.14+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2641	2017-06-13 16:27:10.202+00	2017-06-13 16:27:10.202+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2642	2017-06-13 16:27:10.286+00	2017-06-13 16:27:10.286+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2643	2017-06-13 16:27:10.362+00	2017-06-13 16:27:10.362+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2644	2017-06-13 16:27:10.415+00	2017-06-13 16:27:10.415+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2645	2017-06-13 16:27:10.598+00	2017-06-13 16:27:10.598+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2646	2017-06-13 16:27:10.706+00	2017-06-13 16:27:10.706+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2647	2017-06-13 16:27:10.778+00	2017-06-13 16:27:10.778+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2648	2017-06-13 16:27:11.075+00	2017-06-13 16:27:11.075+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2649	2017-06-13 16:27:11.252+00	2017-06-13 16:27:11.252+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2650	2017-06-13 16:27:11.493+00	2017-06-13 16:27:11.493+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2659	2014-01-01 09:17:56+00	2017-06-13 16:27:13.158+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2660	2017-06-13 16:27:20.119+00	2017-06-13 16:27:20.119+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2712	2017-06-13 16:27:34.645+00	2017-06-13 16:27:34.645+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2713	2017-06-13 16:27:34.686+00	2017-06-13 16:27:34.686+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2714	2017-06-13 16:27:34.74+00	2017-06-13 16:27:34.74+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2716	2017-06-13 16:27:34.842+00	2017-06-13 16:27:34.842+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2651	2017-06-13 16:27:11.567+00	2017-06-13 16:27:11.567+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2656	2014-01-01 09:17:56+00	2017-06-13 16:27:12.654+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-06-13 16:27:12.653+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2657	2014-01-01 09:17:56+00	2017-06-13 16:27:12.864+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2658	2014-01-01 09:17:56+00	2017-06-13 16:27:13.009+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2665	2017-06-13 16:27:20.76+00	2017-06-13 16:27:20.76+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2668	2017-06-13 16:27:20.936+00	2017-06-13 16:27:20.936+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2683	2017-06-13 16:27:22.744+00	2017-06-13 16:27:22.744+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2686	2017-06-13 16:27:22.94+00	2017-06-13 16:27:22.94+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2688	2017-06-13 16:27:23.302+00	2017-06-13 16:27:23.302+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2689	2017-06-13 16:27:29.913+00	2017-06-13 16:27:29.913+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2690	2017-06-13 16:27:31.881+00	2017-06-13 16:27:31.881+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2698	2017-06-13 16:27:33.238+00	2017-06-13 16:27:33.238+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2702	2017-06-13 16:27:33.7+00	2017-06-13 16:27:33.7+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2703	2017-06-13 16:27:33.786+00	2017-06-13 16:27:33.786+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2706	2017-06-13 16:27:33.964+00	2017-06-13 16:27:33.964+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2711	2017-06-13 16:27:34.448+00	2017-06-13 16:27:34.448+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2715	2017-06-13 16:27:34.79+00	2017-06-13 16:27:34.79+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2718	2017-06-13 16:27:34.98+00	2017-06-13 16:27:34.98+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2728	2017-06-13 16:27:36.566+00	2017-06-13 16:27:36.566+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2737	2014-01-01 09:17:56+00	2017-06-13 16:27:38.289+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2739	2017-06-13 16:27:45.31+00	2017-06-13 16:27:45.31+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2740	2017-06-13 16:27:45.434+00	2017-06-13 16:27:45.434+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2741	2017-06-13 16:27:45.672+00	2017-06-13 16:27:45.672+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2756	2017-06-13 16:27:46.829+00	2017-06-13 16:27:46.829+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2763	2017-06-13 16:27:47.258+00	2017-06-13 16:27:47.258+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2767	2017-06-13 16:37:47.776+00	2017-06-13 16:37:47.776+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2776	2017-06-13 16:37:51.566+00	2017-06-13 16:37:51.566+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2781	2017-06-13 16:37:51.874+00	2017-06-13 16:37:51.874+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2783	2017-06-13 16:37:52.009+00	2017-06-13 16:37:52.009+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2785	2017-06-13 16:37:52.171+00	2017-06-13 16:37:52.171+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2787	2017-06-13 16:37:52.331+00	2017-06-13 16:37:52.331+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2795	2017-06-13 16:37:52.959+00	2017-06-13 16:37:52.959+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2796	2017-06-13 16:37:53.037+00	2017-06-13 16:37:53.037+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2815	2014-01-01 09:17:56+00	2017-06-13 16:37:57.978+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2816	2017-06-13 16:38:07.617+00	2017-06-13 16:38:07.617+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2827	2017-06-13 16:38:08.434+00	2017-06-13 16:38:08.434+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2838	2017-06-13 16:38:09.3+00	2017-06-13 16:38:09.3+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2840	2017-06-13 16:38:09.364+00	2017-06-13 16:38:09.364+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2652	2017-06-13 16:27:11.852+00	2017-06-13 16:27:11.852+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2653	2017-06-13 16:27:11.959+00	2017-06-13 16:27:11.959+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2654	2017-06-13 16:27:12.162+00	2017-06-13 16:27:12.162+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2655	2017-06-13 16:27:12.285+00	2017-06-13 16:27:12.285+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2661	2017-06-13 16:27:20.387+00	2017-06-13 16:27:20.387+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2662	2017-06-13 16:27:20.483+00	2017-06-13 16:27:20.483+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2663	2017-06-13 16:27:20.652+00	2017-06-13 16:27:20.652+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2664	2017-06-13 16:27:20.697+00	2017-06-13 16:27:20.697+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2666	2017-06-13 16:27:20.812+00	2017-06-13 16:27:20.812+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2667	2017-06-13 16:27:20.899+00	2017-06-13 16:27:20.899+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2669	2017-06-13 16:27:21.021+00	2017-06-13 16:27:21.021+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2670	2017-06-13 16:27:21.075+00	2017-06-13 16:27:21.075+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2671	2017-06-13 16:27:21.125+00	2017-06-13 16:27:21.125+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2672	2017-06-13 16:27:21.174+00	2017-06-13 16:27:21.174+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2673	2017-06-13 16:27:21.417+00	2017-06-13 16:27:21.417+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2674	2017-06-13 16:27:22.033+00	2017-06-13 16:27:22.033+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2675	2017-06-13 16:27:22.071+00	2017-06-13 16:27:22.071+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2676	2017-06-13 16:27:22.199+00	2017-06-13 16:27:22.199+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2677	2017-06-13 16:27:22.236+00	2017-06-13 16:27:22.236+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2678	2017-06-13 16:27:22.279+00	2017-06-13 16:27:22.279+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2679	2017-06-13 16:27:22.486+00	2017-06-13 16:27:22.486+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2680	2017-06-13 16:27:22.544+00	2017-06-13 16:27:22.544+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2681	2017-06-13 16:27:22.639+00	2017-06-13 16:27:22.639+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2682	2017-06-13 16:27:22.705+00	2017-06-13 16:27:22.705+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2684	2017-06-13 16:27:22.837+00	2017-06-13 16:27:22.837+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2685	2017-06-13 16:27:22.868+00	2017-06-13 16:27:22.868+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2687	2017-06-13 16:27:23.176+00	2017-06-13 16:27:23.176+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2691	2017-06-13 16:27:32.025+00	2017-06-13 16:27:32.025+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2692	2017-06-13 16:27:32.304+00	2017-06-13 16:27:32.304+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2693	2017-06-13 16:27:32.442+00	2017-06-13 16:27:32.442+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2694	2017-06-13 16:27:32.686+00	2017-06-13 16:27:32.686+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2695	2017-06-13 16:27:32.729+00	2017-06-13 16:27:32.729+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2696	2017-06-13 16:27:32.843+00	2017-06-13 16:27:32.843+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2697	2017-06-13 16:27:33.091+00	2017-06-13 16:27:33.091+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2699	2017-06-13 16:27:33.363+00	2017-06-13 16:27:33.363+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2700	2017-06-13 16:27:33.474+00	2017-06-13 16:27:33.474+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2701	2017-06-13 16:27:33.587+00	2017-06-13 16:27:33.587+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2704	2017-06-13 16:27:33.831+00	2017-06-13 16:27:33.831+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2705	2017-06-13 16:27:33.89+00	2017-06-13 16:27:33.89+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2707	2017-06-13 16:27:34.033+00	2017-06-13 16:27:34.033+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2708	2017-06-13 16:27:34.103+00	2017-06-13 16:27:34.103+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2709	2017-06-13 16:27:34.204+00	2017-06-13 16:27:34.204+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2710	2017-06-13 16:27:34.405+00	2017-06-13 16:27:34.405+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2717	2017-06-13 16:27:34.936+00	2017-06-13 16:27:34.936+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2719	2017-06-13 16:27:35.14+00	2017-06-13 16:27:35.14+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2720	2017-06-13 16:27:35.182+00	2017-06-13 16:27:35.182+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2721	2017-06-13 16:27:35.252+00	2017-06-13 16:27:35.252+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2722	2017-06-13 16:27:35.332+00	2017-06-13 16:27:35.332+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2723	2017-06-13 16:27:35.539+00	2017-06-13 16:27:35.539+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2724	2017-06-13 16:27:35.647+00	2017-06-13 16:27:35.647+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2725	2017-06-13 16:27:35.716+00	2017-06-13 16:27:35.716+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2726	2017-06-13 16:27:36.049+00	2017-06-13 16:27:36.049+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2727	2017-06-13 16:27:36.261+00	2017-06-13 16:27:36.261+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2729	2017-06-13 16:27:36.637+00	2017-06-13 16:27:36.637+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2730	2017-06-13 16:27:36.932+00	2017-06-13 16:27:36.932+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2731	2017-06-13 16:27:37.015+00	2017-06-13 16:27:37.015+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2732	2017-06-13 16:27:37.256+00	2017-06-13 16:27:37.256+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2733	2017-06-13 16:27:37.423+00	2017-06-13 16:27:37.423+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2734	2014-01-01 09:17:56+00	2017-06-13 16:27:37.783+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-06-13 16:27:37.781+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2735	2014-01-01 09:17:56+00	2017-06-13 16:27:38.004+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2736	2014-01-01 09:17:56+00	2017-06-13 16:27:38.145+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2738	2017-06-13 16:27:45.138+00	2017-06-13 16:27:45.138+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2742	2017-06-13 16:27:45.752+00	2017-06-13 16:27:45.752+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2743	2017-06-13 16:27:45.822+00	2017-06-13 16:27:45.822+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2747	2017-06-13 16:27:46.064+00	2017-06-13 16:27:46.064+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2749	2017-06-13 16:27:46.177+00	2017-06-13 16:27:46.177+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2750	2017-06-13 16:27:46.218+00	2017-06-13 16:27:46.218+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2757	2017-06-13 16:27:46.987+00	2017-06-13 16:27:46.987+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2760	2017-06-13 16:27:47.125+00	2017-06-13 16:27:47.125+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2762	2017-06-13 16:27:47.212+00	2017-06-13 16:27:47.212+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2764	2017-06-13 16:27:47.328+00	2017-06-13 16:27:47.328+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2765	2017-06-13 16:27:47.559+00	2017-06-13 16:27:47.559+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2744	2017-06-13 16:27:45.872+00	2017-06-13 16:27:45.872+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2746	2017-06-13 16:27:45.978+00	2017-06-13 16:27:45.978+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2751	2017-06-13 16:27:46.401+00	2017-06-13 16:27:46.401+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2752	2017-06-13 16:27:46.497+00	2017-06-13 16:27:46.497+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2753	2017-06-13 16:27:46.588+00	2017-06-13 16:27:46.588+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2754	2017-06-13 16:27:46.746+00	2017-06-13 16:27:46.746+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2755	2017-06-13 16:27:46.794+00	2017-06-13 16:27:46.794+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2745	2017-06-13 16:27:45.905+00	2017-06-13 16:27:45.905+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2748	2017-06-13 16:27:46.1+00	2017-06-13 16:27:46.1+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2758	2017-06-13 16:27:47.022+00	2017-06-13 16:27:47.022+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2759	2017-06-13 16:27:47.088+00	2017-06-13 16:27:47.088+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2761	2017-06-13 16:27:47.164+00	2017-06-13 16:27:47.164+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2766	2017-06-13 16:27:47.652+00	2017-06-13 16:27:47.652+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2768	2017-06-13 16:37:48.066+00	2017-06-13 16:37:48.066+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2769	2017-06-13 16:37:48.173+00	2017-06-13 16:37:48.173+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2770	2017-06-13 16:37:50.688+00	2017-06-13 16:37:50.688+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2771	2017-06-13 16:37:50.854+00	2017-06-13 16:37:50.854+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2772	2017-06-13 16:37:51.105+00	2017-06-13 16:37:51.105+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2773	2017-06-13 16:37:51.145+00	2017-06-13 16:37:51.145+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2774	2017-06-13 16:37:51.223+00	2017-06-13 16:37:51.223+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2775	2017-06-13 16:37:51.465+00	2017-06-13 16:37:51.465+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2777	2017-06-13 16:37:51.614+00	2017-06-13 16:37:51.614+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2778	2017-06-13 16:37:51.667+00	2017-06-13 16:37:51.667+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2779	2017-06-13 16:37:51.721+00	2017-06-13 16:37:51.721+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2780	2017-06-13 16:37:51.824+00	2017-06-13 16:37:51.824+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2782	2017-06-13 16:37:51.931+00	2017-06-13 16:37:51.931+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2784	2017-06-13 16:37:52.058+00	2017-06-13 16:37:52.058+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2786	2017-06-13 16:37:52.266+00	2017-06-13 16:37:52.266+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2788	2017-06-13 16:37:52.553+00	2017-06-13 16:37:52.553+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2789	2017-06-13 16:37:52.599+00	2017-06-13 16:37:52.599+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2790	2017-06-13 16:37:52.702+00	2017-06-13 16:37:52.702+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	FUNDING	\N	\N	\N	\N
2791	2017-06-13 16:37:52.739+00	2017-06-13 16:37:52.739+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2792	2017-06-13 16:37:52.781+00	2017-06-13 16:37:52.781+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2793	2017-06-13 16:37:52.827+00	2017-06-13 16:37:52.827+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2794	2017-06-13 16:37:52.879+00	2017-06-13 16:37:52.879+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2797	2017-06-13 16:37:53.126+00	2017-06-13 16:37:53.126+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2798	2017-06-13 16:37:53.193+00	2017-06-13 16:37:53.193+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	PEER_REVIEW	\N	\N	\N	\N
2799	2017-06-13 16:37:55.269+00	2017-06-13 16:37:55.269+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2800	2017-06-13 16:37:55.359+00	2017-06-13 16:37:55.359+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2801	2017-06-13 16:37:55.571+00	2017-06-13 16:37:55.571+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2802	2017-06-13 16:37:55.682+00	2017-06-13 16:37:55.682+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2803	2017-06-13 16:37:55.75+00	2017-06-13 16:37:55.75+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2804	2017-06-13 16:37:56.041+00	2017-06-13 16:37:56.041+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2805	2017-06-13 16:37:56.191+00	2017-06-13 16:37:56.191+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2806	2017-06-13 16:37:56.42+00	2017-06-13 16:37:56.42+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	FUNDING	\N	\N	\N	\N
2807	2017-06-13 16:37:56.495+00	2017-06-13 16:37:56.495+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EDUCATION	\N	\N	\N	\N
2808	2017-06-13 16:37:56.772+00	2017-06-13 16:37:56.772+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	EMPLOYMENT	\N	\N	\N	\N
2809	2017-06-13 16:37:56.832+00	2017-06-13 16:37:56.832+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2810	2017-06-13 16:37:57.071+00	2017-06-13 16:37:57.071+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2811	2017-06-13 16:37:57.193+00	2017-06-13 16:37:57.193+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2812	2014-01-01 09:17:56+00	2017-06-13 16:37:57.492+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	2017-06-13 16:37:57.491+00	f	\N	https://orcid.org/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2813	2014-01-01 09:17:56+00	2017-06-13 16:37:57.707+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2814	2014-01-01 09:17:56+00	2017-06-13 16:37:57.846+00	9999-0000-0000-0004	PERMISSION	\N	\N	\N	2014-01-01 14:45:32+00	\N	\N	f	\N	https://localhost:8443/orcid-web/oauth/authorize?client_id=APP-U4UKCNSSIM1OCVQY&response_type=code&scope=/orcid-works/create&redirect_uri=http://somethirdparty.com	\N	APP-9999999999999901	\N	\N	Subject	Intro	\N
2817	2017-06-13 16:38:07.776+00	2017-06-13 16:38:07.776+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2818	2017-06-13 16:38:07.875+00	2017-06-13 16:38:07.875+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2819	2017-06-13 16:38:08.036+00	2017-06-13 16:38:08.036+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2820	2017-06-13 16:38:08.066+00	2017-06-13 16:38:08.066+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2821	2017-06-13 16:38:08.142+00	2017-06-13 16:38:08.141+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2822	2017-06-13 16:38:08.224+00	2017-06-13 16:38:08.224+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2823	2017-06-13 16:38:08.257+00	2017-06-13 16:38:08.257+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2824	2017-06-13 16:38:08.289+00	2017-06-13 16:38:08.289+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2825	2017-06-13 16:38:08.349+00	2017-06-13 16:38:08.349+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2826	2017-06-13 16:38:08.382+00	2017-06-13 16:38:08.382+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2828	2017-06-13 16:38:08.467+00	2017-06-13 16:38:08.467+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2829	2017-06-13 16:38:08.648+00	2017-06-13 16:38:08.648+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2830	2017-06-13 16:38:08.69+00	2017-06-13 16:38:08.69+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2831	2017-06-13 16:38:08.773+00	2017-06-13 16:38:08.773+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2832	2017-06-13 16:38:08.908+00	2017-06-13 16:38:08.908+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2833	2017-06-13 16:38:08.948+00	2017-06-13 16:38:08.948+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2834	2017-06-13 16:38:08.978+00	2017-06-13 16:38:08.978+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999902	WORK	\N	\N	\N	\N
2837	2017-06-13 16:38:09.212+00	2017-06-13 16:38:09.212+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2839	2017-06-13 16:38:09.334+00	2017-06-13 16:38:09.334+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2835	2017-06-13 16:38:09.138+00	2017-06-13 16:38:09.138+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2836	2017-06-13 16:38:09.181+00	2017-06-13 16:38:09.181+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2841	2017-06-13 16:38:09.407+00	2017-06-13 16:38:09.407+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2842	2017-06-13 16:38:09.47+00	2017-06-13 16:38:09.47+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2843	2017-06-13 16:38:09.681+00	2017-06-13 16:38:09.681+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2844	2017-06-13 16:38:09.818+00	2017-06-13 16:38:09.818+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	WORK	\N	\N	\N	\N
2845	2017-06-13 16:46:15.686+00	2017-06-13 16:46:15.686+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
2846	2017-06-13 16:46:39.842+00	2017-06-13 16:46:39.842+00	9999-0000-0000-0004	AMENDED	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	APP-9999999999999901	PEER_REVIEW	\N	\N	\N	\N
\.


--
-- Data for Name: notification_item; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY notification_item (id, notification_id, date_created, last_modified, item_type, item_name, external_id_type, external_id_value) FROM stdin;
1081	1538	2017-02-17 17:02:10.295+00	2017-02-17 17:02:10.295+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1082	1538	2017-02-17 17:02:10.296+00	2017-02-17 17:02:10.296+00	WORK	A Really Interesting Research Article	\N	\N
1083	1539	2017-02-17 17:02:11.65+00	2017-02-17 17:02:11.65+00	WORK	A Really Interesting Research Article	\N	\N
1084	1539	2017-02-17 17:02:11.651+00	2017-02-17 17:02:11.651+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1085	1540	2017-02-17 17:02:12.372+00	2017-02-17 17:02:12.372+00	WORK	A Really Interesting Research Article	\N	\N
1086	1540	2017-02-17 17:02:12.373+00	2017-02-17 17:02:12.373+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1087	1541	2017-02-17 17:02:13.163+00	2017-02-17 17:02:13.163+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1088	1541	2017-02-17 17:02:13.164+00	2017-02-17 17:02:13.164+00	WORK	A Really Interesting Research Article	\N	\N
1089	1542	2017-02-17 17:02:14.301+00	2017-02-17 17:02:14.301+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1090	1542	2017-02-17 17:02:14.302+00	2017-02-17 17:02:14.302+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1091	1543	2017-02-17 17:02:15.176+00	2017-02-17 17:02:15.176+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1092	1543	2017-02-17 17:02:15.176+00	2017-02-17 17:02:15.176+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1093	1544	2017-02-17 17:02:15.461+00	2017-02-17 17:02:15.461+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1094	1544	2017-02-17 17:02:15.462+00	2017-02-17 17:02:15.462+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1095	1545	2017-02-17 17:02:15.774+00	2017-02-17 17:02:15.774+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1096	1545	2017-02-17 17:02:15.775+00	2017-02-17 17:02:15.775+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1097	1546	2017-02-17 17:02:16.711+00	2017-02-17 17:02:16.711+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1098	1546	2017-02-17 17:02:16.712+00	2017-02-17 17:02:16.712+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1099	1547	2017-02-17 17:02:17.222+00	2017-02-17 17:02:17.222+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1100	1547	2017-02-17 17:02:17.223+00	2017-02-17 17:02:17.223+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1101	1548	2017-02-17 17:02:17.41+00	2017-02-17 17:02:17.41+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1102	1548	2017-02-17 17:02:17.411+00	2017-02-17 17:02:17.411+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1103	1549	2017-02-17 17:02:17.676+00	2017-02-17 17:02:17.676+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1104	1549	2017-02-17 17:02:17.677+00	2017-02-17 17:02:17.677+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1105	1550	2017-02-17 17:02:18.5+00	2017-02-17 17:02:18.5+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1106	1550	2017-02-17 17:02:18.5+00	2017-02-17 17:02:18.5+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1107	1551	2017-02-17 17:02:19.118+00	2017-02-17 17:02:19.118+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1108	1551	2017-02-17 17:02:19.118+00	2017-02-17 17:02:19.118+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1109	1552	2017-02-17 17:02:19.408+00	2017-02-17 17:02:19.408+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1110	1552	2017-02-17 17:02:19.408+00	2017-02-17 17:02:19.408+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1111	1553	2017-02-17 17:02:19.611+00	2017-02-17 17:02:19.611+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1112	1553	2017-02-17 17:02:19.611+00	2017-02-17 17:02:19.611+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1113	1554	2017-02-17 17:02:20.485+00	2017-02-17 17:02:20.485+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1114	1554	2017-02-17 17:02:20.485+00	2017-02-17 17:02:20.485+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1115	1555	2017-02-17 17:02:21.069+00	2017-02-17 17:02:21.069+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1116	1555	2017-02-17 17:02:21.07+00	2017-02-17 17:02:21.07+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1117	1556	2017-02-17 17:02:21.288+00	2017-02-17 17:02:21.288+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1118	1556	2017-02-17 17:02:21.288+00	2017-02-17 17:02:21.288+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1119	1557	2017-02-17 17:02:21.494+00	2017-02-17 17:02:21.494+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1120	1557	2017-02-17 17:02:21.494+00	2017-02-17 17:02:21.494+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1121	1558	2017-02-17 17:18:23.235+00	2017-02-17 17:18:23.235+00	WORK	A Really Interesting Research Article	\N	\N
1122	1558	2017-02-17 17:18:23.237+00	2017-02-17 17:18:23.237+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1123	1559	2017-02-17 17:18:25.111+00	2017-02-17 17:18:25.111+00	WORK	A Really Interesting Research Article	\N	\N
1124	1559	2017-02-17 17:18:25.112+00	2017-02-17 17:18:25.112+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1125	1560	2017-02-17 17:18:25.532+00	2017-02-17 17:18:25.532+00	WORK	A Really Interesting Research Article	\N	\N
1126	1560	2017-02-17 17:18:25.532+00	2017-02-17 17:18:25.532+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1127	1561	2017-02-17 17:18:26.04+00	2017-02-17 17:18:26.04+00	WORK	A Really Interesting Research Article	\N	\N
1128	1561	2017-02-17 17:18:26.042+00	2017-02-17 17:18:26.042+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1129	1562	2017-02-17 17:18:27.409+00	2017-02-17 17:18:27.409+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1130	1562	2017-02-17 17:18:27.409+00	2017-02-17 17:18:27.409+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1131	1563	2017-02-17 17:18:28.142+00	2017-02-17 17:18:28.142+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1132	1563	2017-02-17 17:18:28.143+00	2017-02-17 17:18:28.143+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1133	1564	2017-02-17 17:18:28.503+00	2017-02-17 17:18:28.503+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1134	1564	2017-02-17 17:18:28.504+00	2017-02-17 17:18:28.504+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1135	1565	2017-02-17 17:18:28.776+00	2017-02-17 17:18:28.776+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1136	1565	2017-02-17 17:18:28.776+00	2017-02-17 17:18:28.776+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1137	1566	2017-02-17 17:18:29.596+00	2017-02-17 17:18:29.596+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1138	1566	2017-02-17 17:18:29.596+00	2017-02-17 17:18:29.596+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1139	1567	2017-02-17 17:18:30.101+00	2017-02-17 17:18:30.101+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1140	1567	2017-02-17 17:18:30.101+00	2017-02-17 17:18:30.101+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1141	1568	2017-02-17 17:18:30.328+00	2017-02-17 17:18:30.328+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1142	1568	2017-02-17 17:18:30.328+00	2017-02-17 17:18:30.328+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1143	1569	2017-02-17 17:18:30.615+00	2017-02-17 17:18:30.615+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1144	1569	2017-02-17 17:18:30.615+00	2017-02-17 17:18:30.615+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1161	1599	2017-02-17 17:58:46.245+00	2017-02-17 17:58:46.245+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1162	1599	2017-02-17 17:58:46.245+00	2017-02-17 17:58:46.245+00	WORK	A Really Interesting Research Article	\N	\N
1145	1570	2017-02-17 17:18:31.565+00	2017-02-17 17:18:31.565+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1146	1570	2017-02-17 17:18:31.565+00	2017-02-17 17:18:31.565+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1147	1571	2017-02-17 17:18:32.152+00	2017-02-17 17:18:32.152+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1148	1571	2017-02-17 17:18:32.152+00	2017-02-17 17:18:32.152+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1163	1600	2017-02-17 17:58:46.719+00	2017-02-17 17:58:46.719+00	WORK	A Really Interesting Research Article	\N	\N
1164	1600	2017-02-17 17:58:46.719+00	2017-02-17 17:58:46.719+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1151	1573	2017-02-17 17:18:32.658+00	2017-02-17 17:18:32.658+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1152	1573	2017-02-17 17:18:32.659+00	2017-02-17 17:18:32.659+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1153	1574	2017-02-17 17:18:33.606+00	2017-02-17 17:18:33.606+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1154	1574	2017-02-17 17:18:33.607+00	2017-02-17 17:18:33.607+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1171	1609	2017-02-17 17:59:30.187+00	2017-02-17 17:59:30.187+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1172	1609	2017-02-17 17:59:30.188+00	2017-02-17 17:59:30.188+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1155	1575	2017-02-17 17:18:34.114+00	2017-02-17 17:18:34.114+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1156	1575	2017-02-17 17:18:34.114+00	2017-02-17 17:18:34.114+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1173	1610	2017-02-17 17:59:30.486+00	2017-02-17 17:59:30.486+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1174	1610	2017-02-17 17:59:30.486+00	2017-02-17 17:59:30.486+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1175	1611	2017-02-17 17:59:30.88+00	2017-02-17 17:59:30.88+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1176	1611	2017-02-17 17:59:30.88+00	2017-02-17 17:59:30.88+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1181	1619	2017-02-17 18:00:13.178+00	2017-02-17 18:00:13.178+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1182	1619	2017-02-17 18:00:13.179+00	2017-02-17 18:00:13.179+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1183	1620	2017-02-17 18:00:13.402+00	2017-02-17 18:00:13.402+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1184	1620	2017-02-17 18:00:13.403+00	2017-02-17 18:00:13.403+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1193	1671	2017-02-17 18:01:31.514+00	2017-02-17 18:01:31.514+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1194	1671	2017-02-17 18:01:31.514+00	2017-02-17 18:01:31.514+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1195	1672	2017-02-17 18:01:31.849+00	2017-02-17 18:01:31.849+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1196	1672	2017-02-17 18:01:31.85+00	2017-02-17 18:01:31.85+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1199	1674	2017-02-17 18:01:32.257+00	2017-02-17 18:01:32.257+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1200	1674	2017-02-17 18:01:32.257+00	2017-02-17 18:01:32.257+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1201	1895	2017-02-17 21:28:37.214+00	2017-02-17 21:28:37.214+00	WORK	A Really Interesting Research Article	\N	\N
1202	1895	2017-02-17 21:28:37.214+00	2017-02-17 21:28:37.214+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1203	1896	2017-02-17 21:28:37.623+00	2017-02-17 21:28:37.623+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1204	1896	2017-02-17 21:28:37.623+00	2017-02-17 21:28:37.623+00	WORK	A Really Interesting Research Article	\N	\N
1207	1898	2017-02-17 21:28:38.006+00	2017-02-17 21:28:38.006+00	WORK	A Really Interesting Research Article	\N	\N
1208	1898	2017-02-17 21:28:38.006+00	2017-02-17 21:28:38.006+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1209	1957	2017-02-17 21:30:15.258+00	2017-02-17 21:30:15.258+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1210	1957	2017-02-17 21:30:15.259+00	2017-02-17 21:30:15.259+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1211	1958	2017-02-17 21:30:15.491+00	2017-02-17 21:30:15.491+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1212	1958	2017-02-17 21:30:15.492+00	2017-02-17 21:30:15.492+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1213	1959	2017-02-17 21:30:15.664+00	2017-02-17 21:30:15.664+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1214	1959	2017-02-17 21:30:15.664+00	2017-02-17 21:30:15.664+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1215	1960	2017-02-17 21:30:15.738+00	2017-02-17 21:30:15.738+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1216	1960	2017-02-17 21:30:15.739+00	2017-02-17 21:30:15.739+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1217	2014	2017-02-17 21:31:51.458+00	2017-02-17 21:31:51.458+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1218	2014	2017-02-17 21:31:51.459+00	2017-02-17 21:31:51.459+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1219	2015	2017-02-17 21:31:51.682+00	2017-02-17 21:31:51.682+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1220	2015	2017-02-17 21:31:51.682+00	2017-02-17 21:31:51.682+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1221	2016	2017-02-17 21:31:51.843+00	2017-02-17 21:31:51.843+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1222	2016	2017-02-17 21:31:51.843+00	2017-02-17 21:31:51.843+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1225	2089	2017-02-17 21:32:22.13+00	2017-02-17 21:32:22.13+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1226	2089	2017-02-17 21:32:22.13+00	2017-02-17 21:32:22.13+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1227	2090	2017-02-17 21:32:22.37+00	2017-02-17 21:32:22.37+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1228	2090	2017-02-17 21:32:22.37+00	2017-02-17 21:32:22.37+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1231	2092	2017-02-17 21:32:22.526+00	2017-02-17 21:32:22.526+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1232	2092	2017-02-17 21:32:22.526+00	2017-02-17 21:32:22.526+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1233	2162	2017-02-17 21:34:05.235+00	2017-02-17 21:34:05.235+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1234	2162	2017-02-17 21:34:05.235+00	2017-02-17 21:34:05.235+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1235	2163	2017-02-17 21:34:05.479+00	2017-02-17 21:34:05.479+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1236	2163	2017-02-17 21:34:05.479+00	2017-02-17 21:34:05.479+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1237	2164	2017-02-17 21:34:05.625+00	2017-02-17 21:34:05.625+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1238	2164	2017-02-17 21:34:05.626+00	2017-02-17 21:34:05.626+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1149	1572	2017-02-17 17:18:32.451+00	2017-02-17 17:18:32.451+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1150	1572	2017-02-17 17:18:32.455+00	2017-02-17 17:18:32.455+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1157	1576	2017-02-17 17:18:34.387+00	2017-02-17 17:18:34.387+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1158	1576	2017-02-17 17:18:34.387+00	2017-02-17 17:18:34.387+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1165	1601	2017-02-17 17:58:46.927+00	2017-02-17 17:58:46.927+00	WORK	A Really Interesting Research Article	\N	\N
1166	1601	2017-02-17 17:58:46.929+00	2017-02-17 17:58:46.929+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1159	1577	2017-02-17 17:18:34.716+00	2017-02-17 17:18:34.716+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1160	1577	2017-02-17 17:18:34.716+00	2017-02-17 17:18:34.716+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1167	1602	2017-02-17 17:58:47.158+00	2017-02-17 17:58:47.158+00	WORK	A Really Interesting Research Article	\N	\N
1168	1602	2017-02-17 17:58:47.158+00	2017-02-17 17:58:47.158+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1169	1608	2017-02-17 17:59:29.767+00	2017-02-17 17:59:29.767+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1170	1608	2017-02-17 17:59:29.768+00	2017-02-17 17:59:29.768+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1177	1617	2017-02-17 18:00:12.716+00	2017-02-17 18:00:12.716+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1178	1617	2017-02-17 18:00:12.716+00	2017-02-17 18:00:12.716+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1179	1618	2017-02-17 18:00:13.003+00	2017-02-17 18:00:13.003+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1180	1618	2017-02-17 18:00:13.003+00	2017-02-17 18:00:13.003+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1185	1644	2017-02-17 18:01:16.101+00	2017-02-17 18:01:16.101+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1186	1644	2017-02-17 18:01:16.102+00	2017-02-17 18:01:16.102+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1187	1645	2017-02-17 18:01:16.426+00	2017-02-17 18:01:16.426+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1188	1645	2017-02-17 18:01:16.426+00	2017-02-17 18:01:16.426+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1189	1646	2017-02-17 18:01:16.607+00	2017-02-17 18:01:16.607+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1190	1646	2017-02-17 18:01:16.607+00	2017-02-17 18:01:16.607+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1191	1647	2017-02-17 18:01:16.771+00	2017-02-17 18:01:16.771+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1192	1647	2017-02-17 18:01:16.772+00	2017-02-17 18:01:16.772+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1197	1673	2017-02-17 18:01:32.054+00	2017-02-17 18:01:32.054+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1198	1673	2017-02-17 18:01:32.055+00	2017-02-17 18:01:32.055+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1205	1897	2017-02-17 21:28:37.839+00	2017-02-17 21:28:37.839+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1206	1897	2017-02-17 21:28:37.839+00	2017-02-17 21:28:37.839+00	WORK	A Really Interesting Research Article	\N	\N
1223	2017	2017-02-17 21:31:51.93+00	2017-02-17 21:31:51.93+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1224	2017	2017-02-17 21:31:51.93+00	2017-02-17 21:31:51.93+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1229	2091	2017-02-17 21:32:22.446+00	2017-02-17 21:32:22.446+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1230	2091	2017-02-17 21:32:22.446+00	2017-02-17 21:32:22.446+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1239	2165	2017-02-17 21:34:05.696+00	2017-02-17 21:34:05.696+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1240	2165	2017-02-17 21:34:05.697+00	2017-02-17 21:34:05.697+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1241	2458	2017-06-13 16:25:37.237+00	2017-06-13 16:25:37.237+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1242	2458	2017-06-13 16:25:37.238+00	2017-06-13 16:25:37.238+00	WORK	A Really Interesting Research Article	\N	\N
1243	2459	2017-06-13 16:25:37.645+00	2017-06-13 16:25:37.645+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1244	2459	2017-06-13 16:25:37.646+00	2017-06-13 16:25:37.646+00	WORK	A Really Interesting Research Article	\N	\N
1245	2460	2017-06-13 16:25:37.955+00	2017-06-13 16:25:37.955+00	WORK	A Really Interesting Research Article	\N	\N
1246	2460	2017-06-13 16:25:37.956+00	2017-06-13 16:25:37.956+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1247	2461	2017-06-13 16:25:38.162+00	2017-06-13 16:25:38.162+00	WORK	A Really Interesting Research Article	\N	\N
1248	2461	2017-06-13 16:25:38.163+00	2017-06-13 16:25:38.163+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1249	2518	2017-06-13 16:25:59.177+00	2017-06-13 16:25:59.177+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1250	2518	2017-06-13 16:25:59.177+00	2017-06-13 16:25:59.177+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1251	2519	2017-06-13 16:25:59.52+00	2017-06-13 16:25:59.52+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1252	2519	2017-06-13 16:25:59.521+00	2017-06-13 16:25:59.521+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1253	2520	2017-06-13 16:25:59.657+00	2017-06-13 16:25:59.657+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1254	2520	2017-06-13 16:25:59.657+00	2017-06-13 16:25:59.657+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1255	2521	2017-06-13 16:25:59.814+00	2017-06-13 16:25:59.814+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1256	2521	2017-06-13 16:25:59.815+00	2017-06-13 16:25:59.815+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1257	2578	2017-06-13 16:26:51.892+00	2017-06-13 16:26:51.892+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1258	2578	2017-06-13 16:26:51.892+00	2017-06-13 16:26:51.892+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1259	2579	2017-06-13 16:26:52.188+00	2017-06-13 16:26:52.188+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1260	2579	2017-06-13 16:26:52.188+00	2017-06-13 16:26:52.188+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1261	2580	2017-06-13 16:26:52.332+00	2017-06-13 16:26:52.332+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1262	2580	2017-06-13 16:26:52.333+00	2017-06-13 16:26:52.333+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1263	2581	2017-06-13 16:26:52.575+00	2017-06-13 16:26:52.575+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1264	2581	2017-06-13 16:26:52.575+00	2017-06-13 16:26:52.575+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1265	2656	2017-06-13 16:27:12.577+00	2017-06-13 16:27:12.577+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1266	2656	2017-06-13 16:27:12.577+00	2017-06-13 16:27:12.577+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1267	2657	2017-06-13 16:27:12.865+00	2017-06-13 16:27:12.865+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1268	2657	2017-06-13 16:27:12.865+00	2017-06-13 16:27:12.865+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1269	2658	2017-06-13 16:27:13.009+00	2017-06-13 16:27:13.009+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1270	2658	2017-06-13 16:27:13.009+00	2017-06-13 16:27:13.009+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1271	2659	2017-06-13 16:27:13.159+00	2017-06-13 16:27:13.159+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1272	2659	2017-06-13 16:27:13.159+00	2017-06-13 16:27:13.159+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1273	2734	2017-06-13 16:27:37.701+00	2017-06-13 16:27:37.701+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1274	2734	2017-06-13 16:27:37.702+00	2017-06-13 16:27:37.702+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1275	2735	2017-06-13 16:27:38.005+00	2017-06-13 16:27:38.005+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1276	2735	2017-06-13 16:27:38.005+00	2017-06-13 16:27:38.005+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1277	2736	2017-06-13 16:27:38.146+00	2017-06-13 16:27:38.146+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1278	2736	2017-06-13 16:27:38.147+00	2017-06-13 16:27:38.147+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1279	2737	2017-06-13 16:27:38.291+00	2017-06-13 16:27:38.291+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1280	2737	2017-06-13 16:27:38.291+00	2017-06-13 16:27:38.291+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1281	2812	2017-06-13 16:37:57.414+00	2017-06-13 16:37:57.414+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1282	2812	2017-06-13 16:37:57.414+00	2017-06-13 16:37:57.414+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1283	2813	2017-06-13 16:37:57.707+00	2017-06-13 16:37:57.707+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1284	2813	2017-06-13 16:37:57.707+00	2017-06-13 16:37:57.707+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1285	2814	2017-06-13 16:37:57.847+00	2017-06-13 16:37:57.847+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1286	2814	2017-06-13 16:37:57.847+00	2017-06-13 16:37:57.847+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
1287	2815	2017-06-13 16:37:57.978+00	2017-06-13 16:37:57.978+00	WORK	A Really Interesting Research Article	DOI	http://10.5555/12345ABCDE
1288	2815	2017-06-13 16:37:57.979+00	2017-06-13 16:37:57.979+00	EMPLOYMENT	Head of Research at NanoBiologica	\N	\N
\.


--
-- Name: notification_item_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('notification_item_seq', 1288, true);


--
-- Name: notification_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('notification_seq', 2846, true);


--
-- Data for Name: notification_work; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY notification_work (date_created, last_modified, notification_id, work_id) FROM stdin;
\.


--
-- Data for Name: oauth2_authoriziation_code_detail; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY oauth2_authoriziation_code_detail (authoriziation_code_value, is_aproved, orcid, redirect_uri, response_type, state, client_details_id, session_id, is_authenticated, date_created, last_modified, persistent, version, nonce) FROM stdin;
2SA43H	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	MyStateParam	APP-9999999999999901	77D3A97D61F6D3429BB87338F9E57991	t	2017-01-20 01:40:05.238+00	2017-01-20 01:40:05.238+00	t	1	\N
P9ZE4r	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	MyStateParam	APP-9999999999999901	FA0162C29EDB3ABDA449E10A6191E3FE	t	2017-01-20 01:40:50.757+00	2017-01-20 01:40:50.757+00	t	1	\N
uCbgy2	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	\N	APP-9999999999999901	BCAA73BC7C3C728E4DDA79C033911ABA	t	2017-01-20 01:40:53.733+00	2017-01-20 01:40:53.733+00	t	1	\N
3Oi2wF	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	MyStateParam	APP-9999999999999901	FA1DB3ABEB455C6B5327DD8D551128D1	t	2017-02-17 21:18:33.275+00	2017-02-17 21:18:33.275+00	t	1	\N
NOphH1	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	MyStateParam	APP-9999999999999901	7CFEFF41BFBE6C6D3607661379E1E595	t	2017-02-17 21:19:53.532+00	2017-02-17 21:19:53.532+00	t	1	\N
n4cFHa	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	\N	APP-9999999999999901	DD9B69E35F28785147AD92212DDA1560	t	2017-02-17 21:19:57.249+00	2017-02-17 21:19:57.249+00	t	1	\N
xFHR00	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	\N	APP-9999999999999901	131145A747D78A86C456BF514343D4AC	t	2017-02-17 21:21:06.754+00	2017-02-17 21:21:06.754+00	t	1	\N
SMBENt	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	\N	APP-9999999999999903	5726BECE374AFAB32034A324755748FC	t	2017-02-17 21:22:48.107+00	2017-02-17 21:22:48.107+00	t	1	\N
TA4l9R	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	\N	APP-9999999999999903	3965F40C857B0A2B0DA0E052C0A2B67D	t	2017-02-17 21:23:21.46+00	2017-02-17 21:23:21.46+00	t	1	\N
Wq734b	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	MyStateParam	APP-9999999999999901	9E19738212EC9D6183AEC64CF5F67901	t	2017-02-17 17:49:25.898+00	2017-02-17 17:49:25.898+00	t	1	\N
CTRrG2	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	MyStateParam	APP-9999999999999901	4BBF8F8C994D4BD5B2B710FBAC82EDA4	t	2017-02-17 17:51:01.17+00	2017-02-17 17:51:01.17+00	t	1	\N
RyaM1o	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	\N	APP-9999999999999901	D228926E7FC407432A5123201DC0D983	t	2017-02-17 17:51:04.381+00	2017-02-17 17:51:04.381+00	t	1	\N
rhR8U1	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	\N	APP-9999999999999903	0DCB92A675C91C12FB9CD677C1F8260B	t	2017-02-17 17:55:45.166+00	2017-02-17 17:55:45.166+00	t	1	\N
G0gSb8	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	\N	APP-9999999999999903	4DAC18C516E8B76A256FCFCD6A054533	t	2017-02-17 22:27:11.971+00	2017-02-17 22:27:11.971+00	t	1	\N
SWwP4l	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	\N	APP-9999999999999903	4DAC18C516E8B76A256FCFCD6A054533	t	2017-02-17 22:28:56.262+00	2017-02-17 22:28:56.262+00	t	1	\N
ZWyJZr	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	\N	APP-9999999999999903	4DAC18C516E8B76A256FCFCD6A054533	t	2017-02-17 22:29:12.909+00	2017-02-17 22:29:12.909+00	t	1	\N
Y0ieqg	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	MyStateParam	APP-9999999999999901	1A459DD94D98DB97361D30D3429BF121	t	2017-06-13 16:09:09.773+00	2017-06-13 16:09:09.773+00	t	1	\N
MBDSdu	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	MyStateParam	APP-9999999999999901	92E2E831AF5140912803BA4BC991C93D	t	2017-06-13 16:11:02.263+00	2017-06-13 16:11:02.263+00	t	1	\N
Bf6wuT	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	\N	APP-9999999999999901	AF6130F60E2F1DA1AE58E8AD4CD4CCF5	t	2017-06-13 16:11:04.781+00	2017-06-13 16:11:04.781+00	t	1	\N
kUTUMW	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	\N	APP-9999999999999901	050FC355160B6365DA6EA814C5932013	t	2017-06-13 16:15:24.815+00	2017-06-13 16:15:24.815+00	t	1	\N
G1aFC7	t	9999-0000-0000-0004	https://localhost:8443/orcid-web/oauth/playground	code	\N	APP-9999999999999903	8CE26D2D5E72485D7741A2FB22266E9F	t	2017-06-13 16:16:28.689+00	2017-06-13 16:16:28.689+00	t	1	\N
\.


--
-- Data for Name: oauth2_token_detail; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY oauth2_token_detail (token_value, token_type, token_expiration, user_orcid, client_details_id, is_approved, redirect_uri, response_type, state, scope_type, resource_id, date_created, last_modified, authentication_key, id, refresh_token_expiration, refresh_token_value, token_disabled, persistent, version, authorization_code, revocation_date, revoke_reason) FROM stdin;
6c051a9d-5a99-4317-8957-5dcd9c27c214	bearer	2017-01-20 02:38:16.364	\N	APP-9999999999999901	t	\N		\N	/orcid-internal/person/last_modified	orcid	2017-01-20 01:38:16.43	2017-01-20 01:38:16.43	e99c542334962efadac46052c7faefff	1001	\N	639f4c64-a69e-4e7a-afa6-ca2f2429e211	\N	f	1	\N	\N	\N
44a8c99d-bd5b-403d-8f4a-3c0076cf2739	bearer	2017-01-20 02:38:16.849	\N	APP-9999999999999901	t	\N		\N	/orcid-internal/person/last_modified	orcid	2017-01-20 01:38:16.853	2017-01-20 01:38:16.853	e99c542334962efadac46052c7faefff	1002	\N	acc5ea58-79bb-4819-b0bc-0a4c60368781	\N	f	1	\N	\N	\N
8771e32e-b64a-46e7-a93e-082b38aa5382	bearer	2037-01-19 21:57:21.561	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:42:02.562	2017-01-20 01:42:02.562	276069c4d3be949258d185c0e1701278	1013	\N	4958dbc3-96f8-4aea-8b2e-82b31797a361	\N	f	1	\N	\N	\N
f6bb4142-a3c2-4ef3-bb34-9b5645e91348	bearer	2037-01-19 21:57:21.711	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:42:02.713	2017-01-20 01:42:02.713	276069c4d3be949258d185c0e1701278	1014	\N	e8286f74-bcb8-4b48-9c67-ded46997e093	\N	f	1	\N	\N	\N
65ec9337-e0a5-41cc-a712-9355940d1499	bearer	2037-01-19 21:57:21.804	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:42:02.805	2017-01-20 01:42:02.805	276069c4d3be949258d185c0e1701278	1015	\N	6336d7ea-59e5-4d6a-a275-22fca2648df7	\N	f	1	\N	\N	\N
8192e65b-466e-4f81-ab0e-3ebad4d8f4a1	bearer	2037-01-19 21:57:21.915	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:42:02.916	2017-01-20 01:42:02.916	276069c4d3be949258d185c0e1701278	1016	\N	5deae03d-70c1-42af-bfa3-01291c01773d	\N	f	1	\N	\N	\N
05b63458-d75d-496d-9e34-83480172d977	bearer	2037-01-19 21:57:22.017	\N	APP-9999999999999901	t	\N		\N	/read-public	orcid	2017-01-20 01:42:03.018	2017-01-20 01:42:03.018	165a3ec304597c3dd5b7880503a1958c	1017	\N	158cfcc4-3621-4408-9e8c-4024bee6ad3a	\N	f	1	\N	\N	\N
3570c576-e3fc-4778-adbf-90f6ae096249	bearer	2037-01-19 21:57:22.057	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:42:03.058	2017-01-20 01:42:03.058	276069c4d3be949258d185c0e1701278	1018	\N	15e5c543-57e2-4980-b4f6-c9846e320e5b	\N	f	1	\N	\N	\N
6629ab24-0fd5-48e4-9aeb-6c82a9dbe743	bearer	2037-01-19 21:57:22.22	\N	APP-9999999999999901	t	\N		\N	/webhook	orcid	2017-01-20 01:42:03.222	2017-01-20 01:42:03.222	92702bb32527e9c0b24b902554b1142e	1019	\N	da22c384-e3ad-457f-915e-c04b3acaee8e	\N	f	1	\N	\N	\N
cbcf4792-d340-4d68-b635-9262bf5aab8a	bearer	2037-01-19 21:57:49.407	\N	APP-9999999999999901	t	\N		\N	/read-public	orcid	2017-01-20 01:42:30.41	2017-01-20 01:42:30.41	165a3ec304597c3dd5b7880503a1958c	1020	\N	005807c9-f61a-47c6-a898-234e2e420ab9	\N	f	1	\N	\N	\N
b7d95e2e-a6e1-4bb6-b8cb-e10b82672520	bearer	2037-01-19 21:57:50.147	\N	APP-9999999999999903	t	\N		\N	/read-public	orcid	2017-01-20 01:42:31.197	2017-01-20 01:42:31.197	76fc187a82824b90baaa2eb7397c8f07	1021	\N	8003cca8-c690-4015-85d1-3aa074628783	\N	f	1	\N	\N	\N
041dddd8-a14d-4ec7-9f16-b414de6c65d6	bearer	2037-01-19 21:57:54.784	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-01-20 01:42:35.845	2017-01-20 01:42:35.845	0bda87e38e59d17fc1cadc1bbccdfd1b	1022	\N	0c2afe37-ae02-4ef3-9242-46682c64b1a6	t	t	1	\N	\N	\N
9c08bc5b-f32d-445d-b15f-17d16e0dc161	bearer	2037-01-19 21:57:58.376	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/update	orcid	2017-01-20 01:42:39.48	2017-01-20 01:42:39.48	257a8a1c2371db71629b27aa8d47f7e1	1024	\N	da9040c8-0a87-4db9-bb8a-1e573de1eac8	t	t	1	\N	\N	\N
921e100f-f4de-46d2-99e6-bb5de56f3884	bearer	2037-01-19 21:57:58.376	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/update	orcid	2017-01-20 01:42:39.601	2017-01-20 01:42:39.601	257a8a1c2371db71629b27aa8d47f7e1	1025	\N	341452c1-3392-4f7a-af57-c3f1a3c954b0	t	t	1	\N	\N	\N
eee76c07-15e6-4dd8-af94-d11de9179b36	bearer	2037-01-19 21:57:54.784	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-01-20 01:42:35.935	2017-01-20 01:42:35.935	0bda87e38e59d17fc1cadc1bbccdfd1b	1023	\N	4df5a307-296a-4ef7-a692-ba521b73d0fc	t	t	1	\N	\N	\N
e001e96a-c686-447d-8116-cf73e4d7057b	bearer	2037-01-19 21:57:20.731	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-01-20 01:42:02.201	2017-01-20 01:42:02.201	0bda87e38e59d17fc1cadc1bbccdfd1b	1012	\N	3029752f-fd94-4246-b518-fc19fe50ed60	t	t	1	\N	\N	\N
217a011e-0f58-4457-a2e2-2da1085562bc	bearer	2037-01-19 21:56:03.029	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/update	orcid	2017-01-20 01:40:44.047	2017-01-20 01:40:44.047	9d26f627b8846ec45287788770373b7e	1009	\N	0443cc7f-d9e8-4eb0-89ac-2c1c5d5b6516	t	t	1	\N	\N	\N
4666de6b-6de5-49ad-915f-50402eaf2e40	bearer	2037-01-19 21:55:57.769	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/update	orcid	2017-01-20 01:40:38.781	2017-01-20 01:40:38.781	9d26f627b8846ec45287788770373b7e	1008	\N	757da56e-6932-4ab9-820c-d88b24e86aa7	t	t	1	\N	\N	\N
8a6a8c0d-7042-435f-9e68-a4712e08055d	bearer	2017-01-20 02:40:09.129	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/external-identifiers/create	orcid	2017-01-20 01:40:09.146	2017-01-20 01:40:09.146	e9277db1e22ce8058f356ef32c679960	1007	\N	6165dbf0-646a-4f2b-abf3-1ea43d6bc535	t	f	1	\N	\N	\N
327c83e9-9951-4b21-a699-2a49c7a71795	bearer	2037-01-19 21:55:18.215	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/create	orcid	2017-01-20 01:39:59.282	2017-01-20 01:39:59.282	b3a39107debe4fa63ea7b671d5a9b94f	1006	\N	ada36d4c-d1b2-41f6-a81b-ff81ddabdd7d	t	t	1	\N	\N	\N
a884c26a-2917-4015-98ec-f66f0c97f143	bearer	2037-01-19 21:55:14.991	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/update	orcid	2017-01-20 01:39:56.004	2017-01-20 01:39:56.004	fad621ce48150605d4475825fd56fc8e	1005	\N	9aa8ce6f-1e5c-4096-b7de-4e0c7da95cfa	t	t	1	\N	\N	\N
bf8bbb94-8273-44e7-aa15-c9a5e5423456	bearer	2037-01-19 21:54:52.655	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/affiliations/create	orcid	2017-01-20 01:39:33.681	2017-01-20 01:39:33.681	8d85c644fbd4e520f1869b9fe3cdc941	1004	\N	f1ac7d2c-85c3-47fb-b5c3-c76c383668f0	t	t	1	\N	\N	\N
06bf82f2-4317-4c5a-89bc-d2df40f43c74	bearer	2037-01-19 21:54:29.652	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/funding/create	orcid	2017-01-20 01:39:10.742	2017-01-20 01:39:10.742	aee8da68d76b954cba9eae9a2276b328	1003	\N	565668ad-10da-4cc9-a9a3-5bdea12fe8b3	t	t	1	\N	\N	\N
fc0bfe98-5772-4e2b-8dda-60e3c2cc5e60	bearer	2037-01-19 21:57:17.351	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-01-20 01:41:58.434	2017-01-20 01:41:58.434	0bda87e38e59d17fc1cadc1bbccdfd1b	1011	\N	e4c1a5c4-25e0-4f8f-b41f-6e4cf9ce05ca	t	t	1	\N	\N	\N
60bc3f57-2474-46d7-9f23-86fc4a1e6730	bearer	2037-01-19 21:56:55.068	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-01-20 01:41:36.081	2017-01-20 01:41:36.081	0bda87e38e59d17fc1cadc1bbccdfd1b	1010	\N	8f9c73d1-4e15-4ade-b81a-979f70316e2b	t	t	1	\N	\N	\N
9afad956-acae-4eae-80f9-a2a6b0fa9211	bearer	2037-01-19 21:59:19.074	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:44:00.075	2017-01-20 01:44:00.075	3903ba3ee40c69281e6a7bce61453a28	1028	\N	093f5eae-0f1d-484c-bd6b-fe3f7ae13828	\N	f	1	\N	\N	\N
34eb3b54-e8fa-495a-8e7f-09450ce17c04	bearer	2037-01-19 21:59:23.514	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:44:04.516	2017-01-20 01:44:04.516	7fb1b415f5231d2280fa57cfb5053d5e	1029	\N	9ec29b2a-a64a-43f4-bd21-1621b6e1ef8c	\N	f	1	\N	\N	\N
a42c4f20-3432-4660-ae19-dc03149931a2	bearer	2037-01-19 21:59:34.578	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:44:15.579	2017-01-20 01:44:15.579	7fb1b415f5231d2280fa57cfb5053d5e	1031	\N	7b720c78-3cb0-4438-a465-518c307c39b5	\N	f	1	\N	\N	\N
a41f11c8-2e02-435e-918b-4e4bb7f12c17	bearer	2037-01-19 22:00:10.61	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:44:51.611	2017-01-20 01:44:51.611	7fb1b415f5231d2280fa57cfb5053d5e	1033	\N	5b6df4a1-5014-476f-9825-6cad1e50ab3a	\N	f	1	\N	\N	\N
055ba3e0-bf2a-49c0-bf12-643a90bdad5a	bearer	2037-01-19 22:00:11.742	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:44:52.743	2017-01-20 01:44:52.743	7fb1b415f5231d2280fa57cfb5053d5e	1034	\N	f63781d0-825f-47bb-88ba-ed920f6199f8	\N	f	1	\N	\N	\N
caf40a40-7140-4a4d-a72b-238edb46409d	bearer	2037-01-19 22:01:03.647	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:45:44.647	2017-01-20 01:45:44.647	3903ba3ee40c69281e6a7bce61453a28	1038	\N	aee99d1f-7d2f-4cb4-9e30-00f577ad9812	\N	f	1	\N	\N	\N
a100eef5-eecd-4fc8-be11-318430a0582a	bearer	2037-01-19 22:01:03.85	\N	APP-9999999999999902	t	\N		\N	/read-public	orcid	2017-01-20 01:45:44.851	2017-01-20 01:45:44.851	5c46a40485e7c772aae0ab814ed7fdd9	1039	\N	87439198-7878-4b4d-a3fb-618f6619c761	\N	f	1	\N	\N	\N
ffda0bb8-035f-479d-8ac9-701e80d212c1	bearer	2037-01-19 22:01:11.734	\N	APP-9999999999999903	t	\N		\N	/read-public	orcid	2017-01-20 01:45:52.735	2017-01-20 01:45:52.735	76fc187a82824b90baaa2eb7397c8f07	1040	\N	6865b0aa-d6de-463b-87e0-4d57cb18ca4d	\N	f	1	\N	\N	\N
cf22474b-b77c-48da-823e-5b635826b83d	bearer	2037-01-19 22:02:24.857	\N	APP-9999999999999901	t	\N		\N	/read-public	orcid	2017-01-20 01:47:05.858	2017-01-20 01:47:05.858	165a3ec304597c3dd5b7880503a1958c	1041	\N	80244ce5-3631-48dd-a207-bbef986f60c8	\N	f	1	\N	\N	\N
a222ec8c-6be8-4f5b-bd0f-287c66f1f4c8	bearer	2037-01-19 22:04:19.425	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:49:00.426	2017-01-20 01:49:00.426	7ae782f285d4d938c43c85528cfaf229	1044	\N	980dc3e3-8c9d-4850-9e77-d5f28f129ad4	\N	f	1	\N	\N	\N
00e9af08-799f-4dec-a5f9-14aa7f5724cc	bearer	2037-01-19 22:04:19.471	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:49:00.471	2017-01-20 01:49:00.471	7ae782f285d4d938c43c85528cfaf229	1045	\N	5e44fa57-493b-4a93-871b-2f835af165a2	\N	f	1	\N	\N	\N
2e9a1c3f-daf4-43a4-a9cf-60fbf7609e12	bearer	2037-01-19 22:04:19.906	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:49:00.907	2017-01-20 01:49:00.907	7ae782f285d4d938c43c85528cfaf229	1046	\N	4d4ac52d-8d80-44dd-bdf8-c46211331a50	\N	f	1	\N	\N	\N
64cc7e50-fc44-4267-9ad6-662118206aa4	bearer	2037-01-19 22:04:20.498	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:49:01.499	2017-01-20 01:49:01.499	7ae782f285d4d938c43c85528cfaf229	1047	\N	acdf18e6-2632-43bd-aaf6-708df5bc09e5	\N	f	1	\N	\N	\N
47669a16-f522-4d25-acee-f8ae192041b3	bearer	2037-01-19 22:04:20.886	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:49:01.887	2017-01-20 01:49:01.887	7ae782f285d4d938c43c85528cfaf229	1048	\N	67e9eaf9-5dc2-4d7e-ba23-7e67f198e634	\N	f	1	\N	\N	\N
aeed646f-bbe6-4033-839e-1f994907ba96	bearer	2037-01-19 22:04:21.301	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:49:02.304	2017-01-20 01:49:02.304	7ae782f285d4d938c43c85528cfaf229	1049	\N	d0267b6a-539a-4cf3-a412-e0e8e2ba35b6	\N	f	1	\N	\N	\N
b8711433-e452-4421-855f-f681fb6a99d5	bearer	2037-01-19 22:04:21.499	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:49:02.499	2017-01-20 01:49:02.499	7ae782f285d4d938c43c85528cfaf229	1050	\N	45f89741-1649-46b6-b075-4864a79e6bbe	\N	f	1	\N	\N	\N
df082c21-988b-468a-9056-dab5b97b5dad	bearer	2037-01-19 22:04:29.516	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:49:10.52	2017-01-20 01:49:10.52	7fb1b415f5231d2280fa57cfb5053d5e	1051	\N	fd1976f6-c2f7-4947-8c6a-ae03a54d358f	\N	f	1	\N	\N	\N
91820f62-3b43-4922-b9f3-fec024c11ffd	bearer	2037-01-19 22:04:34.873	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:49:15.875	2017-01-20 01:49:15.875	7fb1b415f5231d2280fa57cfb5053d5e	1052	\N	7d1110ab-74da-4614-990c-7fd3335a6f9f	\N	f	1	\N	\N	\N
334d16b2-f649-4987-b28d-37e6ea9f8dd5	bearer	2037-01-19 22:05:05.443	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:49:46.444	2017-01-20 01:49:46.444	7fb1b415f5231d2280fa57cfb5053d5e	1053	\N	2f772e74-dfe1-487a-b224-76d06cfd14ac	\N	f	1	\N	\N	\N
00e54baa-f837-4f49-95c2-57d00194ddd5	bearer	2037-01-19 22:05:43.809	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:50:24.81	2017-01-20 01:50:24.81	7fb1b415f5231d2280fa57cfb5053d5e	1054	\N	50ba087b-cf94-4769-ac2e-cca6d0e6f11d	\N	f	1	\N	\N	\N
c448a3ef-b684-4c7f-a225-cdf0f1b1515c	bearer	2037-01-19 22:05:50.328	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:50:31.329	2017-01-20 01:50:31.329	7fb1b415f5231d2280fa57cfb5053d5e	1055	\N	21a62ee5-05ce-4328-ac5b-18aac72a229c	\N	f	1	\N	\N	\N
056f0219-dce3-4b8e-89df-7e4f9beafd3d	bearer	2037-01-19 22:05:57.093	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:50:38.094	2017-01-20 01:50:38.094	7ae782f285d4d938c43c85528cfaf229	1056	\N	3ee1d804-ca37-44e3-8dd6-9aefc1fb2e59	\N	f	1	\N	\N	\N
c254bb76-9f15-475e-bad7-69b44deaf89a	bearer	2037-01-19 22:05:57.133	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:50:38.133	2017-01-20 01:50:38.133	7ae782f285d4d938c43c85528cfaf229	1057	\N	bd4ba183-f14e-415a-a766-d702b619f8f6	\N	f	1	\N	\N	\N
0f1e9ef8-3eb7-4af7-a2e9-c6312bb2a3e5	bearer	2037-01-19 22:05:57.324	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:50:38.326	2017-01-20 01:50:38.326	7ae782f285d4d938c43c85528cfaf229	1058	\N	04b6b679-6b04-47a8-8c49-47ad2902983d	\N	f	1	\N	\N	\N
b0c6c534-a446-491a-b144-c105806c3fb7	bearer	2037-01-19 22:05:57.553	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:50:38.554	2017-01-20 01:50:38.554	7ae782f285d4d938c43c85528cfaf229	1059	\N	10d0ae38-3931-41fc-9a76-bddd04437110	\N	f	1	\N	\N	\N
6ccf8281-35d4-4dda-b4d7-90edf06a5ae8	bearer	2037-01-19 22:05:57.655	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:50:38.656	2017-01-20 01:50:38.656	7ae782f285d4d938c43c85528cfaf229	1060	\N	3b39a2e6-dd92-4da7-b4f3-207d38be0233	\N	f	1	\N	\N	\N
53a01a6b-9383-4614-8e78-65ebdde85ffc	bearer	2037-01-19 22:05:57.778	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:50:38.83	2017-01-20 01:50:38.83	7ae782f285d4d938c43c85528cfaf229	1061	\N	65e2b4f6-5b33-4174-8524-043ddf70c1ad	\N	f	1	\N	\N	\N
28d64c24-f1e8-4e06-bb5e-f1f9b5c9ef2b	bearer	2037-01-19 22:05:57.938	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:50:38.938	2017-01-20 01:50:38.938	7ae782f285d4d938c43c85528cfaf229	1062	\N	78e85f96-507c-4ba7-8650-3038fcfd47d0	\N	f	1	\N	\N	\N
c2d04750-5efa-446e-be42-5bba5adb93be	bearer	2037-01-19 22:05:58.058	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:50:39.059	2017-01-20 01:50:39.059	7ae782f285d4d938c43c85528cfaf229	1063	\N	49f93dcf-2d75-4239-b139-521301d72963	\N	f	1	\N	\N	\N
63a81094-5780-48a8-82a8-381ce064eb1a	bearer	2037-01-19 22:06:28.509	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:51:09.556	2017-01-20 01:51:09.556	7fb1b415f5231d2280fa57cfb5053d5e	1065	\N	fe31db44-2378-478e-8f33-1a76735db08f	\N	f	1	\N	\N	\N
cf0b47d6-88db-42a0-9dd8-648880bcc2a2	bearer	2037-01-19 22:06:35.228	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:51:16.229	2017-01-20 01:51:16.229	7fb1b415f5231d2280fa57cfb5053d5e	1066	\N	99b11b65-3e73-48fd-8dd8-30d017c64ba2	\N	f	1	\N	\N	\N
09a807f5-97be-4ae1-a1bc-6a578e263f49	bearer	2037-01-19 22:06:59.364	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:51:40.365	2017-01-20 01:51:40.365	7fb1b415f5231d2280fa57cfb5053d5e	1067	\N	e8d46d95-9694-4f9e-bf86-06d1ff779975	\N	f	1	\N	\N	\N
7d3a6ec5-2104-432c-bfb6-d010d39c0551	bearer	2037-01-19 22:07:36.469	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:52:17.47	2017-01-20 01:52:17.47	7fb1b415f5231d2280fa57cfb5053d5e	1068	\N	972881ba-b3a3-4016-86f1-8a556b3466df	\N	f	1	\N	\N	\N
2afbd634-d8fe-4904-8954-c3c1d70678af	bearer	2037-01-19 22:07:44.215	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:52:25.216	2017-01-20 01:52:25.216	7fb1b415f5231d2280fa57cfb5053d5e	1069	\N	785fde11-87f0-4193-95e9-b2c2b3aad42f	\N	f	1	\N	\N	\N
48b4c4cd-93e5-407c-b36e-126f2a065bf5	bearer	2037-01-19 22:07:51.943	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:52:32.944	2017-01-20 01:52:32.944	7ae782f285d4d938c43c85528cfaf229	1073	\N	aa0be6f5-fb13-497f-8db3-9aed65bcb223	\N	f	1	\N	\N	\N
bf7f961d-e1f7-49be-b5a2-71376ca1d4e4	bearer	2037-01-19 22:07:51.993	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:52:32.993	2017-01-20 01:52:32.993	7ae782f285d4d938c43c85528cfaf229	1074	\N	56a7c785-0625-4425-980a-8fa9c9e36400	\N	f	1	\N	\N	\N
08e374da-74ce-49a4-86f7-d22b64ffd588	bearer	2037-01-19 22:07:52.084	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:52:33.084	2017-01-20 01:52:33.084	7ae782f285d4d938c43c85528cfaf229	1075	\N	28443fa8-765c-4b1f-a2ca-ae96f30fc88e	\N	f	1	\N	\N	\N
598340d9-8f0e-44f7-aa1e-cf3455ac3b87	bearer	2037-01-19 22:07:52.162	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:52:33.163	2017-01-20 01:52:33.163	7ae782f285d4d938c43c85528cfaf229	1076	\N	edd08a7b-4966-4fee-8903-a0554b717697	\N	f	1	\N	\N	\N
e06a6699-bfb1-429f-9026-c28753094092	bearer	2037-01-19 22:07:52.263	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:52:33.264	2017-01-20 01:52:33.264	7ae782f285d4d938c43c85528cfaf229	1077	\N	ecdfd091-23f2-4538-9986-1d02f0c1774a	\N	f	1	\N	\N	\N
c42f50fa-e31e-4a2f-a4c6-86363aa87bce	bearer	2037-01-19 22:08:02.906	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:52:43.907	2017-01-20 01:52:43.907	7fb1b415f5231d2280fa57cfb5053d5e	1078	\N	8240c1f0-c9d9-4fe8-9e10-eb64a585e8ea	\N	f	1	\N	\N	\N
ea9acb10-39f7-4b81-a44f-d78a0dcba57d	bearer	2037-01-19 22:07:51.638	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:52:32.639	2017-01-20 01:52:32.639	7ae782f285d4d938c43c85528cfaf229	1070	\N	a2950a0d-3027-4ad9-83c2-9c838d5f39f7	\N	f	1	\N	\N	\N
1600cfb7-4a54-40d0-a8a6-0f1af8cf7c2b	bearer	2037-01-19 22:07:51.706	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:52:32.706	2017-01-20 01:52:32.706	7ae782f285d4d938c43c85528cfaf229	1071	\N	90c17391-fab3-48b8-a1ca-92762b142af8	\N	f	1	\N	\N	\N
927f5b32-40e7-412f-916e-9e480117e407	bearer	2037-01-19 22:07:51.808	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:52:32.808	2017-01-20 01:52:32.808	7ae782f285d4d938c43c85528cfaf229	1072	\N	41246c33-6369-4a98-99a9-680ed109f6db	\N	f	1	\N	\N	\N
57ce34f4-2b57-49c1-834f-043330c719bf	bearer	2037-01-19 22:08:15.122	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:52:56.123	2017-01-20 01:52:56.123	7fb1b415f5231d2280fa57cfb5053d5e	1079	\N	8e47cefe-427d-4b4a-a362-cf1ec1e118ef	\N	f	1	\N	\N	\N
d29ae0e6-f0fe-4750-a290-d51c40e8abf9	bearer	2037-01-19 22:08:18.322	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:52:59.323	2017-01-20 01:52:59.323	7fb1b415f5231d2280fa57cfb5053d5e	1080	\N	abc59491-d35b-4881-b537-2d7935e5c970	\N	f	1	\N	\N	\N
921f9044-d0de-4e05-b335-2de109924368	bearer	2037-01-19 22:08:30.447	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:53:11.448	2017-01-20 01:53:11.448	7ae782f285d4d938c43c85528cfaf229	1084	\N	eeac796d-70e3-4641-a28a-f6fd89637c36	\N	f	1	\N	\N	\N
90ca59ac-3aec-40d5-8919-b4c8fae38cee	bearer	2037-01-19 22:08:30.661	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:53:11.662	2017-01-20 01:53:11.662	7ae782f285d4d938c43c85528cfaf229	1086	\N	1501be73-7d59-4eff-8921-a83fd10bebe2	\N	f	1	\N	\N	\N
0da0fb3d-fb91-4ca7-b8a3-2c9b47ab962c	bearer	2037-01-19 22:08:30.716	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:53:11.717	2017-01-20 01:53:11.717	7ae782f285d4d938c43c85528cfaf229	1087	\N	21f7c078-d9cd-4e7f-a6b5-5802d4415ad3	\N	f	1	\N	\N	\N
fa6e925e-6257-47d2-a451-a38f65a302f5	bearer	2037-01-19 22:08:30.795	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:53:11.795	2017-01-20 01:53:11.795	7ae782f285d4d938c43c85528cfaf229	1088	\N	8d7c1c13-6b85-460b-96cc-f72ee46ec330	\N	f	1	\N	\N	\N
3938cfae-3bd9-448f-b12f-2f6877a57d69	bearer	2037-01-19 22:08:30.871	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:53:11.872	2017-01-20 01:53:11.872	7ae782f285d4d938c43c85528cfaf229	1089	\N	4ed26581-3dbe-488b-803c-47fa32dfa931	\N	f	1	\N	\N	\N
65e634e7-f7e8-43ad-b72a-fc27b6b8db46	bearer	2037-01-19 22:08:30.932	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:53:11.933	2017-01-20 01:53:11.933	7ae782f285d4d938c43c85528cfaf229	1090	\N	ad63667b-3603-4078-b77e-ad64209da0d2	\N	f	1	\N	\N	\N
fa4f06aa-d54c-47c2-a547-0f4244d1ec0b	bearer	2037-01-19 22:08:42.646	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:53:23.647	2017-01-20 01:53:23.647	7fb1b415f5231d2280fa57cfb5053d5e	1091	\N	762855e6-5159-4c68-be28-340361f967a3	\N	f	1	\N	\N	\N
5a5a2fea-b0e2-4770-a1e6-71b219f78346	bearer	2037-01-19 22:08:27.321	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:53:08.322	2017-01-20 01:53:08.322	7fb1b415f5231d2280fa57cfb5053d5e	1081	\N	edf759c6-63b7-44ea-8036-775bba3584a5	\N	f	1	\N	\N	\N
28aec831-36b3-4b1b-b206-757b44460b99	bearer	2037-01-19 22:08:28.412	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:53:09.413	2017-01-20 01:53:09.413	7fb1b415f5231d2280fa57cfb5053d5e	1082	\N	3714d881-94e8-4766-9525-e7beea9935d1	\N	f	1	\N	\N	\N
5d88b8ae-a429-4bd0-8591-15bd08d73bd9	bearer	2037-01-19 22:08:30.401	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:53:11.402	2017-01-20 01:53:11.402	7ae782f285d4d938c43c85528cfaf229	1083	\N	553c8b27-294f-4b28-8e51-c3097b42a3d2	\N	f	1	\N	\N	\N
8f50d56d-5a88-463d-a6ad-6bb817398378	bearer	2037-01-19 22:08:30.545	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:53:11.545	2017-01-20 01:53:11.545	7ae782f285d4d938c43c85528cfaf229	1085	\N	bdaee6f9-3336-4ddf-b331-72f8540982ef	\N	f	1	\N	\N	\N
4e9dd891-55e9-4940-8672-b7626f4a8930	bearer	2037-01-19 22:08:51.31	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:53:32.311	2017-01-20 01:53:32.311	7fb1b415f5231d2280fa57cfb5053d5e	1092	\N	a9a5c8db-11aa-4385-96ab-f1d30d448c88	\N	f	1	\N	\N	\N
69cded9f-de78-4613-8031-bd1343695562	bearer	2037-01-19 22:09:14.583	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:53:55.584	2017-01-20 01:53:55.584	7fb1b415f5231d2280fa57cfb5053d5e	1093	\N	9d805ce1-5a73-4e8b-8c55-2c421e2806f6	\N	f	1	\N	\N	\N
62278c3c-f939-4610-9151-a673ecd8cc6a	bearer	2037-01-19 22:09:57.968	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:54:38.969	2017-01-20 01:54:38.969	7fb1b415f5231d2280fa57cfb5053d5e	1094	\N	fa224746-5b34-41e2-a0fd-783774ff4ebd	\N	f	1	\N	\N	\N
6ba491ba-e353-40f6-834e-7b7ca4e4a6f3	bearer	2037-01-19 22:10:05.055	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:54:46.055	2017-01-20 01:54:46.055	7fb1b415f5231d2280fa57cfb5053d5e	1095	\N	8a8a0db7-7c5a-4795-9b01-f8296664e15e	\N	f	1	\N	\N	\N
99313a90-09e0-4db9-94df-49ae3067ea24	bearer	2037-01-19 22:10:14.958	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:54:55.959	2017-01-20 01:54:55.959	7ae782f285d4d938c43c85528cfaf229	1096	\N	f1afbec3-1768-480f-ad98-95be3bf4594e	\N	f	1	\N	\N	\N
72c892f1-0d7b-480e-b8d8-9f9e95622395	bearer	2037-01-19 22:10:14.99	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:54:55.991	2017-01-20 01:54:55.991	7ae782f285d4d938c43c85528cfaf229	1097	\N	136c4331-3895-4fdb-a965-1f2142b482cc	\N	f	1	\N	\N	\N
016edce2-538d-4799-85b9-afffdc8dda11	bearer	2037-01-19 22:10:15.095	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:54:56.096	2017-01-20 01:54:56.096	7ae782f285d4d938c43c85528cfaf229	1098	\N	8cdd8277-4951-49cf-a8d7-5554dac75027	\N	f	1	\N	\N	\N
d6f84c6a-0939-4fde-87a8-7f8addcd5124	bearer	2037-01-19 22:10:15.22	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:54:56.22	2017-01-20 01:54:56.22	7ae782f285d4d938c43c85528cfaf229	1099	\N	9f079ca3-b5a0-4eef-b5d2-c5cc906fb312	\N	f	1	\N	\N	\N
60179013-e3c2-4642-b930-fa0ac84e9fc4	bearer	2037-01-19 22:10:15.294	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:54:56.295	2017-01-20 01:54:56.295	7ae782f285d4d938c43c85528cfaf229	1100	\N	fac37369-6c34-4295-a4be-ac55b5463b93	\N	f	1	\N	\N	\N
0c5b9601-fb9b-4ec2-91aa-e53e85a0ef3f	bearer	2037-01-19 22:10:15.381	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:54:56.382	2017-01-20 01:54:56.382	7ae782f285d4d938c43c85528cfaf229	1101	\N	94f17a68-e04c-43c0-9310-b21c88ce6373	\N	f	1	\N	\N	\N
2f2fa12d-b50f-4172-b9f7-d38dbb5d7296	bearer	2037-01-19 22:10:15.508	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:54:56.509	2017-01-20 01:54:56.509	7ae782f285d4d938c43c85528cfaf229	1102	\N	4a271104-c4f3-4b33-b206-a327858914a5	\N	f	1	\N	\N	\N
a163b271-01cc-46d9-bed3-35b80782cf38	bearer	2037-01-19 22:10:15.61	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-20 01:54:56.61	2017-01-20 01:54:56.61	7ae782f285d4d938c43c85528cfaf229	1103	\N	bb35ba0b-dcd7-4a93-8b17-bd0d0dd9f8c3	\N	f	1	\N	\N	\N
2c3186e6-f1ef-4da7-b07d-468eb2bbfd18	bearer	2037-01-19 22:10:29.043	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-01-20 01:55:10.044	2017-01-20 01:55:10.044	7fb1b415f5231d2280fa57cfb5053d5e	1104	\N	3cd09678-7e66-4fcb-975f-cf0ab47da0ca	\N	f	1	\N	\N	\N
54de0e82-3e28-4030-aca1-79594a01f2e3	bearer	2037-01-19 22:13:44.641	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:25.643	2017-01-20 01:58:25.643	3903ba3ee40c69281e6a7bce61453a28	1106	\N	d9f69f27-c6ad-402b-bf69-1174e4e9c161	\N	f	1	\N	\N	\N
2c6389c4-c8a3-4194-8078-75ccfb283c12	bearer	2037-01-19 22:13:44.697	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:25.698	2017-01-20 01:58:25.698	3903ba3ee40c69281e6a7bce61453a28	1107	\N	bec8945f-2334-472d-8053-bf35a172686a	\N	f	1	\N	\N	\N
7d47bc2b-5b04-40e1-8459-783c2e90984e	bearer	2037-01-19 22:13:47.939	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:28.94	2017-01-20 01:58:28.94	3903ba3ee40c69281e6a7bce61453a28	1108	\N	e81f451d-4d9d-4ce3-bbf4-b824d31e8b6d	\N	f	1	\N	\N	\N
83955e87-57b3-407e-a126-bffbf990cf2f	bearer	2037-01-19 22:13:48.334	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:29.334	2017-01-20 01:58:29.334	3903ba3ee40c69281e6a7bce61453a28	1109	\N	3c42fb81-9198-4ffa-929f-8d1c8ee317fa	\N	f	1	\N	\N	\N
075a38f0-2602-4a5b-907b-f2f8023de575	bearer	2037-01-19 22:13:48.403	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:29.403	2017-01-20 01:58:29.403	3903ba3ee40c69281e6a7bce61453a28	1110	\N	86d1c9c3-a5c1-4c32-b68b-9db216e72487	\N	f	1	\N	\N	\N
c239a5b9-b7e0-4c6f-a964-4f1c0890aa46	bearer	2037-01-19 22:13:51.932	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:32.933	2017-01-20 01:58:32.933	3903ba3ee40c69281e6a7bce61453a28	1111	\N	bc250dff-0e85-472b-9e26-46768687f570	\N	f	1	\N	\N	\N
8b13590e-99ee-418d-99c1-1846000c49da	bearer	2037-01-19 22:13:52.215	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:33.216	2017-01-20 01:58:33.216	3903ba3ee40c69281e6a7bce61453a28	1112	\N	702a024c-0195-4ad5-a6c4-409b10b7c093	\N	f	1	\N	\N	\N
9a31ad05-1a48-44ab-8c4f-e2d7d709d0c5	bearer	2037-01-19 22:13:52.309	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:33.31	2017-01-20 01:58:33.31	3903ba3ee40c69281e6a7bce61453a28	1113	\N	91a2cf45-4759-461b-bf65-819b674f01ac	\N	f	1	\N	\N	\N
4bd5d794-710c-4dab-ac00-f85701130d70	bearer	2037-01-19 22:13:54.764	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:35.764	2017-01-20 01:58:35.764	3903ba3ee40c69281e6a7bce61453a28	1114	\N	233bded9-b41c-4112-8182-28a2f35e91b3	\N	f	1	\N	\N	\N
a3c021f3-a2d9-4417-af4e-788f387793d4	bearer	2037-01-19 22:13:55.16	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:36.161	2017-01-20 01:58:36.161	3903ba3ee40c69281e6a7bce61453a28	1115	\N	e8445b7a-7b3c-4300-8650-fdad92648907	\N	f	1	\N	\N	\N
d660d2c5-b091-4664-babd-cf4459ca95a6	bearer	2037-01-19 22:13:55.249	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:36.25	2017-01-20 01:58:36.25	3903ba3ee40c69281e6a7bce61453a28	1116	\N	63d89dfe-f5c6-4911-aba8-6cffb0f1147b	\N	f	1	\N	\N	\N
ff0855cd-b3b8-44ec-b307-52dc7abd758a	bearer	2037-01-19 22:13:55.372	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:36.373	2017-01-20 01:58:36.373	3903ba3ee40c69281e6a7bce61453a28	1117	\N	b022ff3b-1e1c-4d95-b22d-1bed362e4257	\N	f	1	\N	\N	\N
fe50f7f2-5214-4454-932e-798c6bcc3bb0	bearer	2037-01-19 22:13:55.446	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:36.446	2017-01-20 01:58:36.446	3903ba3ee40c69281e6a7bce61453a28	1118	\N	661ed023-4647-41e1-9a64-2d738fc5601b	\N	f	1	\N	\N	\N
1725d17b-1175-47e3-be3b-2da51a2496b2	bearer	2037-01-19 22:13:55.494	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:36.494	2017-01-20 01:58:36.494	3903ba3ee40c69281e6a7bce61453a28	1119	\N	b6ea5e77-4d66-487c-902a-bcf349e94571	\N	f	1	\N	\N	\N
43331d37-ba55-49ad-9b03-c9eb3fa56ad1	bearer	2037-01-19 22:13:58.582	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 01:58:39.583	2017-01-20 01:58:39.583	3903ba3ee40c69281e6a7bce61453a28	1120	\N	dcb2bcd1-8128-4512-b4cc-ce96093a4902	\N	f	1	\N	\N	\N
4c6bb1a2-237c-41c3-a7e9-872d3fe881f5	bearer	2037-01-19 22:30:25.102	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-01-20 02:15:06.103	2017-01-20 02:15:06.103	3903ba3ee40c69281e6a7bce61453a28	1121	\N	4a019a1b-a48a-42c9-ae5d-e5364695b099	\N	f	1	\N	\N	\N
7ac9188c-8eac-44df-a305-4668821cd8f3	bearer	2017-01-26 20:51:11.047	\N	APP-9999999999999901	t	\N		\N	/orcid-internal/person/last_modified	orcid	2017-01-26 19:51:11.116	2017-01-26 19:51:11.116	e99c542334962efadac46052c7faefff	1123	\N	f228dce0-abed-44bb-a8c3-ae78ade7b99a	\N	f	1	\N	\N	\N
caf92957-2021-47e3-bf9c-4a57976d8e42	bearer	2017-01-26 20:51:11.415	\N	APP-9999999999999901	t	\N		\N	/orcid-internal/person/last_modified	orcid	2017-01-26 19:51:11.417	2017-01-26 19:51:11.417	e99c542334962efadac46052c7faefff	1124	\N	2cf85256-9af2-4137-8466-9fa0c50b4953	\N	f	1	\N	\N	\N
abeb3868-dfae-48df-9a9c-b68ce1d068b4	bearer	2037-01-26 16:06:36.805	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:17.87	2017-01-26 19:51:17.87	7ae782f285d4d938c43c85528cfaf229	1125	\N	8ba25041-e13e-4ca3-af86-49319ef78734	\N	f	1	\N	\N	\N
38079b0f-b5fe-4d2c-8969-f3dd520699cb	bearer	2037-01-26 16:06:37.122	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:18.124	2017-01-26 19:51:18.124	7ae782f285d4d938c43c85528cfaf229	1126	\N	e6c24f9c-98b0-45fe-9115-b0df60486548	\N	f	1	\N	\N	\N
6e96d166-2962-4e7d-a173-457eac5d77fb	bearer	2037-01-26 16:06:38.728	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:19.732	2017-01-26 19:51:19.732	7ae782f285d4d938c43c85528cfaf229	1127	\N	773796b6-9d7d-46c7-a630-59dc3b405dbb	\N	f	1	\N	\N	\N
7abfc133-297f-412a-b284-6b5474bad8ca	bearer	2037-01-26 16:06:39.76	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:20.761	2017-01-26 19:51:20.761	7ae782f285d4d938c43c85528cfaf229	1128	\N	e0375089-29ba-4166-8afa-acc005cf29d8	\N	f	1	\N	\N	\N
004ae0f2-363a-48dc-8cf1-9f4da73ceb86	bearer	2037-01-26 16:06:40.495	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:21.496	2017-01-26 19:51:21.496	7ae782f285d4d938c43c85528cfaf229	1129	\N	5d9c892f-9b07-43eb-bffa-e92a31aa7fe1	\N	f	1	\N	\N	\N
7b661b72-557e-4ab2-81ea-ccdd37e0ea1c	bearer	2037-01-26 16:06:41.05	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:22.057	2017-01-26 19:51:22.057	7ae782f285d4d938c43c85528cfaf229	1130	\N	7e3cd197-197b-4a90-bf75-1bbcfe20944e	\N	f	1	\N	\N	\N
a4d419c1-1b4c-4eff-9e51-0b13ca75b327	bearer	2037-01-26 16:06:41.354	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:22.356	2017-01-26 19:51:22.356	7ae782f285d4d938c43c85528cfaf229	1131	\N	9fcbacee-0546-4a22-a130-a585397583d1	\N	f	1	\N	\N	\N
0cbc96bd-7ebb-4938-a2c8-f60f948ab17c	bearer	2037-01-26 16:06:41.639	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:22.641	2017-01-26 19:51:22.641	7ae782f285d4d938c43c85528cfaf229	1132	\N	361cdecb-21c8-422f-844c-7f8714efb421	\N	f	1	\N	\N	\N
c40f2ca6-c805-48a3-b757-ce875db9570a	bearer	2037-01-26 16:06:41.775	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:22.776	2017-01-26 19:51:22.776	7ae782f285d4d938c43c85528cfaf229	1133	\N	51a58a77-020d-45bc-ab8a-02c98c043457	\N	f	1	\N	\N	\N
5eda780d-085e-4b37-8dd2-53a3ca827c2b	bearer	2037-01-26 16:06:42.334	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:23.335	2017-01-26 19:51:23.335	7ae782f285d4d938c43c85528cfaf229	1134	\N	1ee7469e-ac3e-4f7f-8478-2001ff952e97	\N	f	1	\N	\N	\N
5dd5637e-e890-46c6-897e-c1972adc8e2b	bearer	2037-01-26 16:06:42.823	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:23.85	2017-01-26 19:51:23.85	7ae782f285d4d938c43c85528cfaf229	1135	\N	42ad5ae2-a1bb-4bcc-a4db-11e84a7c2c2e	\N	f	1	\N	\N	\N
69e23fab-8c9f-4c7b-bb78-159db5461eed	bearer	2037-01-26 16:06:43.011	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:24.012	2017-01-26 19:51:24.012	7ae782f285d4d938c43c85528cfaf229	1136	\N	3d4cf785-141d-4ac5-9dfc-2d063eca6e93	\N	f	1	\N	\N	\N
fd4f5cae-2490-48db-9e0f-66acc087091d	bearer	2037-01-26 16:06:43.288	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:24.288	2017-01-26 19:51:24.288	7ae782f285d4d938c43c85528cfaf229	1137	\N	b2b64358-807f-44d9-ba6b-0320224ac2a1	\N	f	1	\N	\N	\N
1dc99196-77ca-46c1-94be-e249f1c8bccb	bearer	2037-01-26 16:06:43.488	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:24.489	2017-01-26 19:51:24.489	7ae782f285d4d938c43c85528cfaf229	1138	\N	d27fee52-bf0e-4e06-b1e6-c34e9fa653d6	\N	f	1	\N	\N	\N
a475a707-fce9-40b8-bd57-81a840083f66	bearer	2037-01-26 16:06:43.677	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:24.678	2017-01-26 19:51:24.678	7ae782f285d4d938c43c85528cfaf229	1139	\N	ee986d00-8024-483d-aced-b34a5ff3a6de	\N	f	1	\N	\N	\N
af2f22ce-5ed4-4d68-8374-9aedf27c6d8e	bearer	2037-01-26 16:06:43.74	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:24.741	2017-01-26 19:51:24.741	7ae782f285d4d938c43c85528cfaf229	1140	\N	3bcf5bed-e2ea-4356-997b-4942d8205d74	\N	f	1	\N	\N	\N
8d5edb89-86c1-4064-9c2e-c8c8442d5e37	bearer	2037-01-26 16:06:43.838	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:24.839	2017-01-26 19:51:24.839	7ae782f285d4d938c43c85528cfaf229	1141	\N	22b5e8d3-c270-45e1-aa4e-1bd0dcb3b74a	\N	f	1	\N	\N	\N
e9f78b47-1f23-465a-83a3-1120b8c59342	bearer	2037-01-26 16:06:44.579	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:25.58	2017-01-26 19:51:25.58	7ae782f285d4d938c43c85528cfaf229	1142	\N	d7c17a26-02a1-426f-b3ca-497de7072725	\N	f	1	\N	\N	\N
97cbb77d-04d5-4d44-af86-f5176d56647f	bearer	2037-01-26 16:06:44.942	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:25.943	2017-01-26 19:51:25.943	7ae782f285d4d938c43c85528cfaf229	1143	\N	0bcc92df-ad6a-4cb6-aef6-63fdbb236a3f	\N	f	1	\N	\N	\N
cdf63199-5f71-4315-be6e-eeaf1c846dcc	bearer	2037-01-26 16:06:45.011	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:26.012	2017-01-26 19:51:26.012	7ae782f285d4d938c43c85528cfaf229	1144	\N	36876c03-710c-4e6d-b637-dc84995f7a29	\N	f	1	\N	\N	\N
df9fb706-c51e-454c-8e2f-fbdb9f95bddb	bearer	2037-01-26 16:06:45.251	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:26.252	2017-01-26 19:51:26.252	7ae782f285d4d938c43c85528cfaf229	1145	\N	df1f94fa-6fe2-41b9-bab8-c9a9b4256b77	\N	f	1	\N	\N	\N
ca18a6d8-cd9e-4e2c-b888-beaf19f3f111	bearer	2037-01-26 16:06:45.431	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:26.432	2017-01-26 19:51:26.432	7ae782f285d4d938c43c85528cfaf229	1146	\N	7fe2b565-6435-49a1-abcf-7dbde4977310	\N	f	1	\N	\N	\N
1cb48dd2-5c39-4fc2-989d-190f27850489	bearer	2037-01-26 16:06:45.567	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:26.568	2017-01-26 19:51:26.568	7ae782f285d4d938c43c85528cfaf229	1147	\N	b13e83f3-6656-4750-b516-95da7bfe72cd	\N	f	1	\N	\N	\N
7a9cc795-97b6-4891-92cc-7d6d3b0ecad1	bearer	2037-01-26 16:06:45.68	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:26.681	2017-01-26 19:51:26.681	7ae782f285d4d938c43c85528cfaf229	1148	\N	7104aa24-5d82-4a34-bb98-3d6cb289b2f5	\N	f	1	\N	\N	\N
46b7bbe5-0ea4-4a3d-a1f4-dab82ee2499a	bearer	2037-01-26 16:06:45.73	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:26.73	2017-01-26 19:51:26.73	7ae782f285d4d938c43c85528cfaf229	1149	\N	db737ae8-3da0-432b-bd44-d1cbf3c45500	\N	f	1	\N	\N	\N
e7d4a644-47f1-40f2-a4d7-68f86b43f952	bearer	2037-01-26 16:06:46.146	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:27.146	2017-01-26 19:51:27.146	7ae782f285d4d938c43c85528cfaf229	1150	\N	49b60abf-bfca-4d46-a7c5-7fa00e981d9c	\N	f	1	\N	\N	\N
aaf69257-324a-4e6d-ba0a-dd35a36bbb03	bearer	2037-01-26 16:06:46.381	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:27.382	2017-01-26 19:51:27.382	7ae782f285d4d938c43c85528cfaf229	1151	\N	35cce4b9-232a-4474-b419-24f8abefbb4f	\N	f	1	\N	\N	\N
0e6809c9-e6da-4922-9601-ebf0bcee2863	bearer	2037-01-26 16:06:46.699	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:27.7	2017-01-26 19:51:27.7	7ae782f285d4d938c43c85528cfaf229	1153	\N	94ec2d18-86ff-4dca-ad8e-395f889fb035	\N	f	1	\N	\N	\N
41e4be9e-07e1-4542-9f6b-dcdb73c87ff6	bearer	2037-01-26 16:06:46.889	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:27.89	2017-01-26 19:51:27.89	7ae782f285d4d938c43c85528cfaf229	1154	\N	4e1021d5-84c6-4378-b816-69f90402daef	\N	f	1	\N	\N	\N
61b6b162-610e-4389-bcc0-0f8ac3c6df3d	bearer	2037-01-26 16:06:47.096	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:28.097	2017-01-26 19:51:28.097	7ae782f285d4d938c43c85528cfaf229	1155	\N	8d398a3b-a009-44d4-b5fc-f0950faf6b64	\N	f	1	\N	\N	\N
6d456143-572a-4ec8-b735-431b155f1750	bearer	2037-01-26 16:06:47.957	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:28.958	2017-01-26 19:51:28.958	7ae782f285d4d938c43c85528cfaf229	1160	\N	ddc1733d-dcec-4727-8278-7378d9baa851	\N	f	1	\N	\N	\N
b84021a0-0263-441f-93b8-ef73f31155e8	bearer	2037-01-26 16:06:48.132	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:29.133	2017-01-26 19:51:29.133	7ae782f285d4d938c43c85528cfaf229	1161	\N	249e7640-8670-4228-b998-de9fce1d2841	\N	f	1	\N	\N	\N
a9723ad3-cc89-496c-acc8-11b3426a251d	bearer	2037-01-26 16:06:48.442	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:29.442	2017-01-26 19:51:29.442	7ae782f285d4d938c43c85528cfaf229	1163	\N	50d9816d-b558-4772-8aea-d83131e83d35	\N	f	1	\N	\N	\N
8f784f74-d438-459e-ad8e-c8280120a85d	bearer	2037-01-26 16:06:46.496	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:27.498	2017-01-26 19:51:27.498	7ae782f285d4d938c43c85528cfaf229	1152	\N	1b79b19f-ab1f-44b8-84c0-35016724c240	\N	f	1	\N	\N	\N
ba62bb27-a0b3-4990-958a-565286eb0412	bearer	2037-01-26 16:06:47.216	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:28.217	2017-01-26 19:51:28.217	7ae782f285d4d938c43c85528cfaf229	1156	\N	7eaead06-d67c-417e-9858-44be289607da	\N	f	1	\N	\N	\N
dc97c184-0f13-42b9-85ee-4ffe1f17334a	bearer	2037-01-26 16:06:47.264	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:28.265	2017-01-26 19:51:28.265	7ae782f285d4d938c43c85528cfaf229	1157	\N	05a1eb4d-cf12-484e-8ddc-96d9ccae3965	\N	f	1	\N	\N	\N
1517d2a0-fe5b-49bb-90ee-5d62c3654c9c	bearer	2037-01-26 16:06:47.571	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:28.571	2017-01-26 19:51:28.571	7ae782f285d4d938c43c85528cfaf229	1158	\N	5afbbb9f-c9ad-49db-b080-c1bfba0a2c44	\N	f	1	\N	\N	\N
220e206b-665d-43eb-9c1e-a15514e4dede	bearer	2037-01-26 16:06:47.863	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:28.863	2017-01-26 19:51:28.863	7ae782f285d4d938c43c85528cfaf229	1159	\N	666720c6-5ab5-449d-9047-a8a66fdd77c0	\N	f	1	\N	\N	\N
188d2108-a3fa-4050-9606-ff204d08f5cd	bearer	2037-01-26 16:06:48.278	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-01-26 19:51:29.278	2017-01-26 19:51:29.278	7ae782f285d4d938c43c85528cfaf229	1162	\N	54a954b0-7be7-4fa0-839e-9a2c158d089b	\N	f	1	\N	\N	\N
57a8065a-ae55-4f22-ac9d-86760e6e1a14	bearer	2017-02-17 18:01:59.35	\N	APP-9999999999999901	t	\N		\N	/orcid-internal/person/last_modified	orcid	2017-02-17 17:01:59.405	2017-02-17 17:01:59.405	e99c542334962efadac46052c7faefff	1164	\N	16d20ceb-59c7-477c-8728-dc79b2779337	\N	f	1	\N	\N	\N
825e41fa-56f0-4c56-9592-74a958d99dc4	bearer	2017-02-17 18:01:59.71	\N	APP-9999999999999901	t	\N		\N	/orcid-internal/person/last_modified	orcid	2017-02-17 17:01:59.713	2017-02-17 17:01:59.713	e99c542334962efadac46052c7faefff	1165	\N	ed641fc8-1761-49b2-94c2-36a365b0823a	\N	f	1	\N	\N	\N
017b8098-046a-4875-977b-2dfcaca77094	bearer	2037-02-17 13:17:27.353	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:08.398	2017-02-17 17:02:08.398	7ae782f285d4d938c43c85528cfaf229	1166	\N	21ca82cb-68f6-448b-9530-98cddb638931	\N	f	1	\N	\N	\N
989ab09f-18a0-4236-9f12-eb719108b86d	bearer	2037-02-17 13:17:27.596	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:08.598	2017-02-17 17:02:08.598	7ae782f285d4d938c43c85528cfaf229	1167	\N	c6aeef97-f767-4fbe-bbcb-61966c120bda	\N	f	1	\N	\N	\N
780a4aed-7cca-4645-909d-e1c6a9010344	bearer	2037-02-17 13:17:29.066	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:10.068	2017-02-17 17:02:10.068	7ae782f285d4d938c43c85528cfaf229	1168	\N	215ce96d-89b4-4c87-ac66-ce6f267f0fe8	\N	f	1	\N	\N	\N
5cc506b1-9541-408e-b4a0-36c6575544a1	bearer	2037-02-17 13:17:30.433	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:11.435	2017-02-17 17:02:11.435	7ae782f285d4d938c43c85528cfaf229	1169	\N	6e466ddf-2322-4978-9bf7-c499ed378683	\N	f	1	\N	\N	\N
e57ac21d-cf96-4211-86db-58751634feeb	bearer	2037-02-17 13:17:31.023	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:12.064	2017-02-17 17:02:12.064	7ae782f285d4d938c43c85528cfaf229	1170	\N	f928d3ed-8e27-4c16-a6b1-aa4600dbdd2a	\N	f	1	\N	\N	\N
2eacc832-9cf8-45f3-addf-a15c174fc08a	bearer	2037-02-17 13:17:31.73	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:12.747	2017-02-17 17:02:12.747	7ae782f285d4d938c43c85528cfaf229	1171	\N	89f04a6d-857c-43cc-988b-9a2445c4a1d5	\N	f	1	\N	\N	\N
1b9bd8cf-fe7d-43ac-ae07-49e2d167281a	bearer	2037-02-17 13:17:32.298	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:13.299	2017-02-17 17:02:13.299	7ae782f285d4d938c43c85528cfaf229	1172	\N	2bae7ddd-c5cb-4d2d-a5a7-cf651219be9f	\N	f	1	\N	\N	\N
d2597f44-b111-4fa2-a37e-dd977adcd5aa	bearer	2037-02-17 13:17:32.496	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:13.498	2017-02-17 17:02:13.498	7ae782f285d4d938c43c85528cfaf229	1173	\N	6941d22b-65a5-4a6a-b6e1-61425ac73a45	\N	f	1	\N	\N	\N
a24be720-5dbf-4652-87c3-6cc5be97ca3b	bearer	2037-02-17 13:17:32.648	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:13.65	2017-02-17 17:02:13.65	7ae782f285d4d938c43c85528cfaf229	1174	\N	671086df-162d-444d-be37-d3891c584206	\N	f	1	\N	\N	\N
92cecfcb-1ba5-4122-81f8-ce2ee0eaf371	bearer	2037-02-17 13:17:33.14	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:14.143	2017-02-17 17:02:14.143	7ae782f285d4d938c43c85528cfaf229	1175	\N	c3d47358-f908-429c-8518-03c47e883d9d	\N	f	1	\N	\N	\N
398aadbe-9ffd-4933-aca2-7d2bacb75714	bearer	2037-02-17 13:17:33.749	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:14.756	2017-02-17 17:02:14.756	7ae782f285d4d938c43c85528cfaf229	1176	\N	c09de8b8-4aea-4a76-9d9d-173315b54e2b	\N	f	1	\N	\N	\N
045b2f5a-91b6-48cd-b0f6-81ed32414474	bearer	2037-02-17 13:17:34.059	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:15.06	2017-02-17 17:02:15.06	7ae782f285d4d938c43c85528cfaf229	1177	\N	0eb7254c-6c62-474f-99a9-92c29b29ee8f	\N	f	1	\N	\N	\N
24398927-802a-4c74-8ae8-a72757932e07	bearer	2037-02-17 13:17:34.362	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:15.363	2017-02-17 17:02:15.363	7ae782f285d4d938c43c85528cfaf229	1178	\N	70086b9f-908c-4374-963b-38b893ca6b7f	\N	f	1	\N	\N	\N
0aa2ef76-c1e0-483b-b089-3cb5960136b5	bearer	2037-02-17 13:17:34.647	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:15.652	2017-02-17 17:02:15.652	7ae782f285d4d938c43c85528cfaf229	1179	\N	c392b814-1e00-4544-b20f-2c51832f586a	\N	f	1	\N	\N	\N
b76dc21f-2910-4999-ad1c-f3e0f971b981	bearer	2037-02-17 13:17:34.856	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:15.857	2017-02-17 17:02:15.857	7ae782f285d4d938c43c85528cfaf229	1180	\N	672eeb00-af5c-4757-952f-2abddaabe813	\N	f	1	\N	\N	\N
d5417efc-1198-43b0-83ff-1571d97760f9	bearer	2037-02-17 13:17:34.965	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:15.967	2017-02-17 17:02:15.967	7ae782f285d4d938c43c85528cfaf229	1181	\N	67c038b0-22b2-4e7f-88ec-cdfa1566c373	\N	f	1	\N	\N	\N
7d9c0367-b531-4d00-b68e-8e6df89a3949	bearer	2037-02-17 13:17:35.026	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:16.027	2017-02-17 17:02:16.027	7ae782f285d4d938c43c85528cfaf229	1182	\N	216adefd-3b9a-43a5-858b-85c94a2d551c	\N	f	1	\N	\N	\N
b1912cca-2051-4465-895b-ec24cd4c6d33	bearer	2037-02-17 13:17:35.609	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:16.61	2017-02-17 17:02:16.61	7ae782f285d4d938c43c85528cfaf229	1183	\N	33712d96-7f25-4325-8f67-78a077e67811	\N	f	1	\N	\N	\N
f3272099-27a0-4129-8e26-0cbf4c920116	bearer	2037-02-17 13:17:36.014	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:17.016	2017-02-17 17:02:17.016	7ae782f285d4d938c43c85528cfaf229	1184	\N	f13be287-cbea-4eac-afb0-fc7a60ad2194	\N	f	1	\N	\N	\N
ebc98463-de76-485e-b5e0-6d5973f94053	bearer	2037-02-17 13:17:36.14	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:17.14	2017-02-17 17:02:17.14	7ae782f285d4d938c43c85528cfaf229	1185	\N	854cc5cf-eb75-474d-9b90-bcacc04cc42d	\N	f	1	\N	\N	\N
b2ec71de-84e2-4879-8912-dbaa90e5f3ac	bearer	2037-02-17 13:17:36.326	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:17.327	2017-02-17 17:02:17.327	7ae782f285d4d938c43c85528cfaf229	1186	\N	31ad8a93-c521-410b-b226-298266b93205	\N	f	1	\N	\N	\N
7f082300-66a9-40d1-97a0-b277d04d0775	bearer	2037-02-17 13:17:36.57	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:17.573	2017-02-17 17:02:17.573	7ae782f285d4d938c43c85528cfaf229	1187	\N	b6f981a7-343d-4b3f-9c27-7ffb1a861000	\N	f	1	\N	\N	\N
c3031551-58b3-4ea5-b19b-d68610d45f7c	bearer	2037-02-17 13:17:36.836	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:17.836	2017-02-17 17:02:17.836	7ae782f285d4d938c43c85528cfaf229	1188	\N	b50d5080-e366-4b33-a922-0c644220baa0	\N	f	1	\N	\N	\N
396c83d1-8c55-4312-995b-b10b8db03716	bearer	2037-02-17 13:17:36.898	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:17.899	2017-02-17 17:02:17.899	7ae782f285d4d938c43c85528cfaf229	1189	\N	6f3da372-5f2e-46fd-9d99-f48744801d7b	\N	f	1	\N	\N	\N
1fc2f637-1090-4700-849f-ce745cc11683	bearer	2037-02-17 13:17:36.987	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:17.989	2017-02-17 17:02:17.989	7ae782f285d4d938c43c85528cfaf229	1190	\N	944602dd-57ce-4f2b-8e56-cbd725afa780	\N	f	1	\N	\N	\N
34614ee8-c215-41dd-b11b-162f6fa5fb98	bearer	2037-02-17 13:17:37.4	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:18.401	2017-02-17 17:02:18.401	7ae782f285d4d938c43c85528cfaf229	1191	\N	0c70c65b-d33f-425c-8a77-1f82b5509903	\N	f	1	\N	\N	\N
2a6c834b-bfd5-43fc-8e6a-46d4bfcddc88	bearer	2037-02-17 13:17:37.813	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:18.814	2017-02-17 17:02:18.814	7ae782f285d4d938c43c85528cfaf229	1192	\N	3c2603a5-17e0-418d-8a5f-0de13a35faa4	\N	f	1	\N	\N	\N
42265391-4cfd-4401-af64-1278c0d83408	bearer	2037-02-17 13:17:39.458	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:20.459	2017-02-17 17:02:20.459	7ae782f285d4d938c43c85528cfaf229	1199	\N	14436230-2bcf-4876-8c01-a280fbcaef59	\N	f	1	\N	\N	\N
00b64e73-0b31-4f03-84b2-cb47d5d1bc9b	bearer	2037-02-17 13:17:37.987	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:18.988	2017-02-17 17:02:18.988	7ae782f285d4d938c43c85528cfaf229	1193	\N	a95ef254-b399-4c2d-911c-9290ff3bea76	\N	f	1	\N	\N	\N
049736ae-2dd9-429a-b137-d272b10a673b	bearer	2037-02-17 13:17:38.298	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:19.3	2017-02-17 17:02:19.3	7ae782f285d4d938c43c85528cfaf229	1194	\N	938a6e6d-58a4-4181-9531-9941da7eba35	\N	f	1	\N	\N	\N
c9cb466c-dd75-45d9-87e6-24c1492a9d47	bearer	2037-02-17 13:17:38.509	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:19.51	2017-02-17 17:02:19.51	7ae782f285d4d938c43c85528cfaf229	1195	\N	277e1b43-7e13-4b24-a168-e5ccf606661d	\N	f	1	\N	\N	\N
7894c9c9-4fd6-467d-a100-9df9ec801bda	bearer	2037-02-17 13:17:38.701	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:19.702	2017-02-17 17:02:19.702	7ae782f285d4d938c43c85528cfaf229	1196	\N	ee59edfa-424e-4100-9a48-71f221ad8155	\N	f	1	\N	\N	\N
9055f21e-61dd-465a-9d4f-1d5c8d426990	bearer	2037-02-17 13:17:38.752	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:19.753	2017-02-17 17:02:19.753	7ae782f285d4d938c43c85528cfaf229	1197	\N	94276404-919e-4e39-aaa2-863dc52e381c	\N	f	1	\N	\N	\N
8eb8a12d-70b4-47d1-88ad-e80a2b1c7421	bearer	2037-02-17 13:17:38.859	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:19.86	2017-02-17 17:02:19.86	7ae782f285d4d938c43c85528cfaf229	1198	\N	634e0630-69b3-48c4-bcf6-b1cf4aad0e66	\N	f	1	\N	\N	\N
d2bcb8f4-fce8-4b56-9522-2152df24db01	bearer	2037-02-17 13:17:39.849	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:20.851	2017-02-17 17:02:20.851	7ae782f285d4d938c43c85528cfaf229	1200	\N	e3e87e01-d01d-4e2f-a010-effc6f48ec00	\N	f	1	\N	\N	\N
504f2e2b-8a13-40e5-bdf4-5c69de0adc04	bearer	2037-02-17 13:17:39.994	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:20.995	2017-02-17 17:02:20.995	7ae782f285d4d938c43c85528cfaf229	1201	\N	da29b609-c240-471f-a577-37198298418a	\N	f	1	\N	\N	\N
d45de440-25fb-4dd2-b758-b0c06c444433	bearer	2037-02-17 13:17:40.201	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:21.202	2017-02-17 17:02:21.202	7ae782f285d4d938c43c85528cfaf229	1202	\N	eefc1987-ea0d-4d7d-967e-f6c4d0f666ea	\N	f	1	\N	\N	\N
09397329-95af-425f-aa3f-a5b0be5b66ea	bearer	2037-02-17 13:17:40.398	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:21.398	2017-02-17 17:02:21.398	7ae782f285d4d938c43c85528cfaf229	1203	\N	64ba5fb7-f711-441f-bacd-555306bb3762	\N	f	1	\N	\N	\N
3664e5d3-1753-41d6-883d-723fd6993bd9	bearer	2037-02-17 13:17:40.598	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:02:21.598	2017-02-17 17:02:21.598	7ae782f285d4d938c43c85528cfaf229	1204	\N	2d689de3-a68d-40a0-acd8-d3b29b2a4f74	\N	f	1	\N	\N	\N
fb4f139f-2069-443c-bae7-3b5ee5d82e76	bearer	2017-02-17 18:18:14.084	\N	APP-9999999999999901	t	\N		\N	/orcid-internal/person/last_modified	orcid	2017-02-17 17:18:14.111	2017-02-17 17:18:14.111	e99c542334962efadac46052c7faefff	1205	\N	b5457afd-4546-42a4-a1ae-43c6f345eeea	\N	f	1	\N	\N	\N
31a9055f-5ef1-497a-8d8c-ca3fd6c0c6be	bearer	2017-02-17 18:18:14.494	\N	APP-9999999999999901	t	\N		\N	/orcid-internal/person/last_modified	orcid	2017-02-17 17:18:14.498	2017-02-17 17:18:14.498	e99c542334962efadac46052c7faefff	1206	\N	9dfb4f8f-5c78-47b4-b0da-2cb34149de70	\N	f	1	\N	\N	\N
3aac8106-608a-4cf0-92b7-1d01178c56fd	bearer	2037-02-17 13:33:40.374	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:21.397	2017-02-17 17:18:21.397	7ae782f285d4d938c43c85528cfaf229	1207	\N	613be1de-af65-4f8e-a789-80499d61a18a	\N	f	1	\N	\N	\N
286293b7-41eb-425d-b358-714623b7262e	bearer	2037-02-17 13:33:40.595	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:21.597	2017-02-17 17:18:21.597	7ae782f285d4d938c43c85528cfaf229	1208	\N	ba67bcf7-b9cd-4b97-ab12-058236be81b8	\N	f	1	\N	\N	\N
f9d4d20f-a2cd-4018-b283-4b34763afe77	bearer	2037-02-17 13:33:41.929	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:22.93	2017-02-17 17:18:22.93	7ae782f285d4d938c43c85528cfaf229	1209	\N	68b73cdc-7e60-4424-aee8-e47dc768d3fb	\N	f	1	\N	\N	\N
d1e5a01e-b1e9-4c9e-a426-e6bafeac942d	bearer	2037-02-17 13:33:43.841	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:24.842	2017-02-17 17:18:24.842	7ae782f285d4d938c43c85528cfaf229	1210	\N	22a6d92c-9992-4ac2-b9cc-3ef6cd223e65	\N	f	1	\N	\N	\N
d850ecad-ad89-4699-b552-59c3de277d6c	bearer	2037-02-17 13:33:44.356	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:25.36	2017-02-17 17:18:25.36	7ae782f285d4d938c43c85528cfaf229	1211	\N	7dd9bb04-6a56-42a9-bbfc-01e1a9f85475	\N	f	1	\N	\N	\N
97023e69-4d0f-4d1a-abba-86e2cad975d0	bearer	2037-02-17 13:33:44.845	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:25.846	2017-02-17 17:18:25.846	7ae782f285d4d938c43c85528cfaf229	1212	\N	f247702d-34f1-4b83-a1b0-6116fa983cbc	\N	f	1	\N	\N	\N
21ab5655-7f3a-41c5-8aa7-b215dc28d75e	bearer	2037-02-17 13:33:45.236	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:26.244	2017-02-17 17:18:26.244	7ae782f285d4d938c43c85528cfaf229	1213	\N	1bfb59a3-2466-4a9f-8ba2-d56233af0ef1	\N	f	1	\N	\N	\N
9fa76c3a-6cf8-4a32-9769-78297e9ca669	bearer	2037-02-17 13:33:45.534	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:26.563	2017-02-17 17:18:26.563	7ae782f285d4d938c43c85528cfaf229	1214	\N	ca8eb73e-63d2-4d5d-bfec-7243612b9181	\N	f	1	\N	\N	\N
e023b6db-7f73-43ff-808e-d7b951366743	bearer	2037-02-17 13:33:45.708	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:26.71	2017-02-17 17:18:26.71	7ae782f285d4d938c43c85528cfaf229	1215	\N	f6d01910-2755-4a65-a6e7-1b1e826933bd	\N	f	1	\N	\N	\N
6bd8f61d-695a-45d3-9898-b284104d6872	bearer	2037-02-17 13:33:46.218	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:27.219	2017-02-17 17:18:27.219	7ae782f285d4d938c43c85528cfaf229	1216	\N	e1859e3c-0e9e-4ec7-851b-4a9c40dd0235	\N	f	1	\N	\N	\N
91b899ff-fff4-4ebe-b313-cf08771f9ac7	bearer	2037-02-17 13:33:46.919	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:27.92	2017-02-17 17:18:27.92	7ae782f285d4d938c43c85528cfaf229	1217	\N	91413fb9-6730-4854-9e73-9334098bae32	\N	f	1	\N	\N	\N
9a817782-fb7f-45ea-ba55-27a30a453727	bearer	2037-02-17 13:33:47.097	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:28.098	2017-02-17 17:18:28.098	7ae782f285d4d938c43c85528cfaf229	1218	\N	5a2a3221-6f2b-4104-a05e-acbd4ebd480d	\N	f	1	\N	\N	\N
8cd22c5a-302a-4265-ba3e-43d889a90776	bearer	2037-02-17 13:33:47.296	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:28.296	2017-02-17 17:18:28.296	7ae782f285d4d938c43c85528cfaf229	1219	\N	9327cf81-f002-4aec-af9b-4a5f5e997629	\N	f	1	\N	\N	\N
7f2bf1f1-6d0b-46a7-8c7f-966a47ccb794	bearer	2037-02-17 13:33:47.66	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:28.661	2017-02-17 17:18:28.661	7ae782f285d4d938c43c85528cfaf229	1220	\N	ddd3b033-9488-445e-9db6-cc10cdee235a	\N	f	1	\N	\N	\N
08fb74e2-31ae-424d-9681-fdc1c9fc4d7f	bearer	2037-02-17 13:33:47.854	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:28.855	2017-02-17 17:18:28.855	7ae782f285d4d938c43c85528cfaf229	1221	\N	6b4e57ea-bd27-41eb-ad0e-40f2ac32e2df	\N	f	1	\N	\N	\N
ad69a143-de35-47b1-a713-166e22b871d2	bearer	2037-02-17 13:33:47.951	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:28.953	2017-02-17 17:18:28.953	7ae782f285d4d938c43c85528cfaf229	1222	\N	283ad8af-d1bd-469b-addb-f5db7a0f38c9	\N	f	1	\N	\N	\N
0a8141ee-da79-4480-8d21-e7839cc2e5c0	bearer	2037-02-17 13:33:48.057	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:29.058	2017-02-17 17:18:29.058	7ae782f285d4d938c43c85528cfaf229	1223	\N	842a62c2-393c-4895-8a40-464a9217da0b	\N	f	1	\N	\N	\N
08068674-b012-4fa9-af6d-a0860479e307	bearer	2037-02-17 13:33:48.554	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:29.554	2017-02-17 17:18:29.554	7ae782f285d4d938c43c85528cfaf229	1224	\N	94fc412e-ce2b-4fcf-8dbc-20b12143f443	\N	f	1	\N	\N	\N
8543e121-218f-4287-976a-24040ccc7f01	bearer	2037-02-17 13:33:48.875	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:29.876	2017-02-17 17:18:29.876	7ae782f285d4d938c43c85528cfaf229	1225	\N	b8dd7a32-f2d4-4afd-b841-d7feb5eb5565	\N	f	1	\N	\N	\N
83dca4e4-5d03-474f-9e10-82b762735e2e	bearer	2037-02-17 13:33:49.28	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:30.281	2017-02-17 17:18:30.281	7ae782f285d4d938c43c85528cfaf229	1227	\N	61eb56a5-dfa5-40c2-922a-58633cd8dbd1	\N	f	1	\N	\N	\N
7b733c79-0af8-4b8a-b7a3-b41caf90fcc6	bearer	2037-02-17 13:33:49.509	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:30.51	2017-02-17 17:18:30.51	7ae782f285d4d938c43c85528cfaf229	1228	\N	d82a9871-ebeb-466e-8e72-910e62ad8155	\N	f	1	\N	\N	\N
0b09db2d-7415-4200-902c-daf17ce3ea81	bearer	2037-02-17 13:33:49.73	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:30.731	2017-02-17 17:18:30.731	7ae782f285d4d938c43c85528cfaf229	1229	\N	d280b546-2444-4f9f-a28f-3caef755bfb8	\N	f	1	\N	\N	\N
c058fef7-13fb-4827-b33c-16e4f9388c81	bearer	2037-02-17 13:33:49.899	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:30.899	2017-02-17 17:18:30.899	7ae782f285d4d938c43c85528cfaf229	1230	\N	3b69ac3c-8fab-4642-bf75-a45ff2c2bb18	\N	f	1	\N	\N	\N
696708d0-3267-4d2a-9840-59ba4144326a	bearer	2037-02-17 13:33:50.517	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:31.518	2017-02-17 17:18:31.518	7ae782f285d4d938c43c85528cfaf229	1232	\N	3513bae2-cb9f-46df-b602-f233f57978ff	\N	f	1	\N	\N	\N
1c0c10cf-78b8-467d-95af-dfad41d51e3a	bearer	2037-02-17 13:33:50.845	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:31.846	2017-02-17 17:18:31.846	7ae782f285d4d938c43c85528cfaf229	1233	\N	01a31573-6d30-4c48-b9c6-816221e20861	\N	f	1	\N	\N	\N
b9d4df38-f59d-4579-9adb-85a5bfa844dd	bearer	2037-02-17 13:33:51.715	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:32.751	2017-02-17 17:18:32.751	7ae782f285d4d938c43c85528cfaf229	1237	\N	dba3266b-2967-4bc8-a80b-7d4ffd540517	\N	f	1	\N	\N	\N
2507c34b-c9ce-4621-a588-2cd291e5844f	bearer	2037-02-17 13:33:52.9	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:33.901	2017-02-17 17:18:33.901	7ae782f285d4d938c43c85528cfaf229	1241	\N	77d4b9a9-8661-41b7-9227-f2e4dac4b5cc	\N	f	1	\N	\N	\N
f1274801-c02f-4ef0-92d1-d6c9d2b252ff	bearer	2037-02-17 13:33:53.03	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:34.031	2017-02-17 17:18:34.031	7ae782f285d4d938c43c85528cfaf229	1242	\N	0c493c52-eb0b-4b6e-92cf-f80043c05bca	\N	f	1	\N	\N	\N
5fbd7380-8a21-4e19-a3db-d789b6380fcd	bearer	2037-02-17 13:33:53.309	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:34.31	2017-02-17 17:18:34.31	7ae782f285d4d938c43c85528cfaf229	1243	\N	06f77538-822b-4573-a064-0b04514729e6	\N	f	1	\N	\N	\N
4824b3a4-a56d-444a-8677-c379b49936a5	bearer	2037-02-17 13:33:49.024	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:30.025	2017-02-17 17:18:30.025	7ae782f285d4d938c43c85528cfaf229	1226	\N	3c95c99e-dc68-491c-8499-1237b9b0004c	\N	f	1	\N	\N	\N
4b88ceac-adef-451a-a361-60fc7b2eb63b	bearer	2037-02-17 13:33:50.034	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:31.035	2017-02-17 17:18:31.035	7ae782f285d4d938c43c85528cfaf229	1231	\N	21818c7e-8751-4781-923e-6684d7d92027	\N	f	1	\N	\N	\N
9f991166-2b9f-427c-a4a3-245c07f59d34	bearer	2037-02-17 13:33:50.975	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:31.976	2017-02-17 17:18:31.976	7ae782f285d4d938c43c85528cfaf229	1234	\N	a24a4e11-e7ff-486f-b29a-ac35d809a2b8	\N	f	1	\N	\N	\N
80ea2632-8654-4bc8-a577-ac26dc2aab5f	bearer	2037-02-17 13:33:51.347	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:32.348	2017-02-17 17:18:32.348	7ae782f285d4d938c43c85528cfaf229	1235	\N	fefdf26e-d2f9-4795-830c-eacccec35440	\N	f	1	\N	\N	\N
f38175f5-2838-4572-9f92-94f0e8410d34	bearer	2037-02-17 13:33:51.573	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:32.574	2017-02-17 17:18:32.574	7ae782f285d4d938c43c85528cfaf229	1236	\N	2bdafce4-2cec-42f6-9417-4cacc59f2a86	\N	f	1	\N	\N	\N
b5e71345-a548-40ba-b567-61e3b34bd886	bearer	2037-02-17 13:33:51.865	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:32.865	2017-02-17 17:18:32.865	7ae782f285d4d938c43c85528cfaf229	1238	\N	9c15256b-9222-4b86-b917-cbf6ebc8d2d6	\N	f	1	\N	\N	\N
754d3e38-b666-4b2e-8b1d-6bcfa8e6086e	bearer	2037-02-17 13:33:51.976	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:32.977	2017-02-17 17:18:32.977	7ae782f285d4d938c43c85528cfaf229	1239	\N	f7c9787f-1390-41c5-8698-dd62f9a45c04	\N	f	1	\N	\N	\N
6e1ba35d-c8e6-4e7b-9deb-87ec02981854	bearer	2037-02-17 13:33:52.498	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:33.505	2017-02-17 17:18:33.505	7ae782f285d4d938c43c85528cfaf229	1240	\N	a318f538-b340-4a48-b643-fb0a0f0448b2	\N	f	1	\N	\N	\N
15d96db4-a161-4216-8a25-8ac8657ea48e	bearer	2037-02-17 13:33:53.538	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:34.539	2017-02-17 17:18:34.539	7ae782f285d4d938c43c85528cfaf229	1244	\N	7fcff615-0efa-45b0-bf4d-8c854f53ecd2	\N	f	1	\N	\N	\N
763b3e35-39d8-4979-a154-1c7606e8fbdf	bearer	2037-02-17 13:33:53.824	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:18:34.825	2017-02-17 17:18:34.825	7ae782f285d4d938c43c85528cfaf229	1245	\N	f81460f4-6b2a-4739-a128-6cbfaf489a3f	\N	f	1	\N	\N	\N
aae6e0fc-ee78-4fd9-8dbe-a9fa5594ce97	bearer	2017-02-17 18:47:57.099	\N	APP-9999999999999901	t	\N		\N	/orcid-internal/person/last_modified	orcid	2017-02-17 17:47:57.1	2017-02-17 17:47:57.1	e99c542334962efadac46052c7faefff	1246	\N	656b39b7-c585-42fc-99dd-153e9d4fc97f	\N	f	1	\N	\N	\N
10660503-3280-4f6d-ad57-64ba4f2a6147	bearer	2017-02-17 18:47:57.435	\N	APP-9999999999999901	t	\N		\N	/orcid-internal/person/last_modified	orcid	2017-02-17 17:47:57.437	2017-02-17 17:47:57.437	e99c542334962efadac46052c7faefff	1247	\N	e1e63457-85fa-46a2-bdfa-b8e89df41de0	\N	f	1	\N	\N	\N
bfd09e36-6932-448f-b54f-467d6f385a7e	bearer	2037-02-17 14:04:40.669	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/create	orcid	2017-02-17 17:49:21.688	2017-02-17 17:49:21.688	b3a39107debe4fa63ea7b671d5a9b94f	1251	\N	fb6d2374-820c-4c1f-a637-aa807f83a26f	t	t	1	\N	\N	\N
82dd7d61-4dc9-473f-953a-35660b0d5b97	bearer	2037-02-17 14:04:21.978	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/update	orcid	2017-02-17 17:49:03.001	2017-02-17 17:49:03.001	fad621ce48150605d4475825fd56fc8e	1250	\N	09190441-a24f-4852-bf2a-e1358ffe67a1	t	t	1	\N	\N	\N
f8756dee-82c1-4ccc-8bfa-31b1f19cc8fb	bearer	2037-02-17 14:03:49.201	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/affiliations/create	orcid	2017-02-17 17:48:30.274	2017-02-17 17:48:30.274	8d85c644fbd4e520f1869b9fe3cdc941	1249	\N	de3ad417-6a41-4e4a-81f3-5cad367b901e	t	t	1	\N	\N	\N
58b47fb9-e088-4e77-8c9c-8dd031c3fc2c	bearer	2037-02-17 14:03:45.89	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/funding/create	orcid	2017-02-17 17:48:26.963	2017-02-17 17:48:26.963	aee8da68d76b954cba9eae9a2276b328	1248	\N	1c9c2cf0-3f3a-4848-bc57-94ec9f3f63b2	t	t	1	\N	\N	\N
8c269c77-b092-4854-b1db-7a91d2e595f4	bearer	2037-02-17 14:08:03.276	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 17:52:44.277	2017-02-17 17:52:44.277	276069c4d3be949258d185c0e1701278	1258	\N	a912f4a7-9d80-42fb-a09a-470bcdece977	\N	f	1	\N	\N	\N
a621a8dc-92f2-4995-8580-cfc2308bb54c	bearer	2037-02-17 14:08:02.933	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-02-17 17:52:44.068	2017-02-17 17:52:44.068	0bda87e38e59d17fc1cadc1bbccdfd1b	1257	\N	0559bfc1-b52f-4361-b0b9-9f3ef1569506	t	t	1	\N	\N	\N
a07b41ba-58f9-4eee-b9ca-5118f5633ef7	bearer	2037-02-17 14:07:58.821	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-02-17 17:52:39.964	2017-02-17 17:52:39.964	0bda87e38e59d17fc1cadc1bbccdfd1b	1256	\N	aece9a8e-e5e2-431d-9e57-ea29bdc26b0b	t	t	1	\N	\N	\N
7b0325d4-8dea-492f-b31a-526d0537471b	bearer	2037-02-17 14:07:26.362	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-02-17 17:52:07.369	2017-02-17 17:52:07.369	0bda87e38e59d17fc1cadc1bbccdfd1b	1255	\N	20c776eb-3135-46b5-95d1-5fa1b384ad86	t	t	1	\N	\N	\N
524dac60-9dfb-4f39-bef3-81663c7e442e	bearer	2037-02-17 14:06:14.524	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/update	orcid	2017-02-17 17:50:55.533	2017-02-17 17:50:55.533	9d26f627b8846ec45287788770373b7e	1254	\N	a834de62-8ecd-4e7f-9fb8-84dacbde84a5	t	t	1	\N	\N	\N
0bef63bd-1886-442c-8ada-3159dbb12dd5	bearer	2037-02-17 14:06:10.02	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/update	orcid	2017-02-17 17:50:51.03	2017-02-17 17:50:51.03	9d26f627b8846ec45287788770373b7e	1253	\N	4cb12700-354f-41d8-9fae-daee4e4ed8f4	t	t	1	\N	\N	\N
2760489e-a46e-41fd-9b0c-087ced200eea	bearer	2017-02-17 18:50:12.078	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/external-identifiers/create	orcid	2017-02-17 17:50:12.087	2017-02-17 17:50:12.087	e9277db1e22ce8058f356ef32c679960	1252	\N	49330768-c99d-44f5-8bdb-6f39af99beb4	t	f	1	\N	\N	\N
ba08c9c5-db39-4b24-b996-9af41a8b2796	bearer	2037-02-17 14:11:08.864	9999-0000-0000-0004	APP-9999999999999903	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/authenticate	orcid	2017-02-17 17:55:49.888	2017-02-17 17:55:49.888	8f8c14436439216e305452a23b785553	1273	\N	6add7a60-0d80-4db8-841a-c0262144087d	\N	t	1	\N	\N	\N
6437a0bc-2f9b-4f61-8478-fa742942b3d5	bearer	2037-02-17 14:15:31.675	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:00:12.676	2017-02-17 18:00:12.676	7ae782f285d4d938c43c85528cfaf229	1305	\N	66d266c1-545e-41b0-a982-e7a4b6aaad61	\N	f	1	\N	\N	\N
00647e90-a5b8-4e7e-b691-382cbedc8e41	bearer	2037-02-17 14:15:31.886	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:00:12.886	2017-02-17 18:00:12.886	7ae782f285d4d938c43c85528cfaf229	1306	\N	c4c4ef6c-d6fc-4992-97fe-79ddda14def0	\N	f	1	\N	\N	\N
0f5f8251-70a9-4307-be08-afeedac5d39d	bearer	2037-02-17 14:08:03.355	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 17:52:44.356	2017-02-17 17:52:44.356	276069c4d3be949258d185c0e1701278	1259	\N	e7da8573-464e-4e61-99ed-0d9c001a152a	\N	f	1	\N	\N	\N
2442fcf1-0a74-46d9-ad7c-60251aba4282	bearer	2037-02-17 14:08:03.385	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 17:52:44.386	2017-02-17 17:52:44.386	276069c4d3be949258d185c0e1701278	1260	\N	963362d1-c0ca-42e8-95a6-0fc08e26c604	\N	f	1	\N	\N	\N
e6431710-dc65-4cce-9b37-28d780db26e3	bearer	2037-02-17 14:08:03.413	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 17:52:44.414	2017-02-17 17:52:44.414	276069c4d3be949258d185c0e1701278	1261	\N	b82dde3c-8a1e-4631-9779-280795a77a61	\N	f	1	\N	\N	\N
b54a805a-c68d-49e7-894b-013de29d5ad1	bearer	2037-02-17 14:08:03.469	\N	APP-9999999999999901	t	\N		\N	/read-public	orcid	2017-02-17 17:52:44.47	2017-02-17 17:52:44.47	165a3ec304597c3dd5b7880503a1958c	1262	\N	4637387b-791a-4fb3-8b9f-9a09a106b5cb	\N	f	1	\N	\N	\N
71c09dcd-1ed8-41bc-9c1c-fb6decc41c40	bearer	2037-02-17 14:08:03.501	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 17:52:44.501	2017-02-17 17:52:44.501	276069c4d3be949258d185c0e1701278	1263	\N	b7db2dc0-d5dd-4ab9-81b2-009f0e4ca9e4	\N	f	1	\N	\N	\N
e4f7214d-44ae-484a-a579-841d888a5049	bearer	2037-02-17 14:08:03.574	\N	APP-9999999999999901	t	\N		\N	/webhook	orcid	2017-02-17 17:52:44.576	2017-02-17 17:52:44.576	92702bb32527e9c0b24b902554b1142e	1264	\N	00df151f-183f-4abf-8ff3-9b306a6be5d4	\N	f	1	\N	\N	\N
0ef3f0d7-8670-43c1-8df7-d8496b210180	bearer	2037-02-17 14:08:24.177	\N	APP-9999999999999901	t	\N		\N	/read-public	orcid	2017-02-17 17:53:05.177	2017-02-17 17:53:05.177	165a3ec304597c3dd5b7880503a1958c	1265	\N	ac122122-dc29-4ffc-b137-d5cf6a38fd23	\N	f	1	\N	\N	\N
f769be88-bd08-462e-a5f6-8941a510b696	bearer	2037-02-17 14:08:25.269	\N	APP-9999999999999903	t	\N		\N	/read-public	orcid	2017-02-17 17:53:06.277	2017-02-17 17:53:06.277	76fc187a82824b90baaa2eb7397c8f07	1266	\N	b76cc8e0-8193-48cd-98ac-ddb407701223	\N	f	1	\N	\N	\N
1591e088-0d5d-4593-a939-a994812f0243	bearer	2037-02-17 14:09:00.019	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-02-17 17:53:41.077	2017-02-17 17:53:41.077	0bda87e38e59d17fc1cadc1bbccdfd1b	1267	\N	73e7e7c0-d104-4e52-9065-bbf7e2cfa477	t	t	1	\N	\N	\N
f09285d9-cabf-4c77-bcc5-fdfdfaac103b	bearer	2037-02-17 14:09:32.635	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/update	orcid	2017-02-17 17:54:13.691	2017-02-17 17:54:13.691	257a8a1c2371db71629b27aa8d47f7e1	1269	\N	77cddf3e-8d74-4580-90aa-8e1539b84c3d	t	t	1	\N	\N	\N
f7164f9e-33a5-4e65-876a-447df436978a	bearer	2037-02-17 14:09:32.635	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/update	orcid	2017-02-17 17:54:13.755	2017-02-17 17:54:13.755	257a8a1c2371db71629b27aa8d47f7e1	1270	\N	b089297e-5512-4cfd-b2f3-d4ebd7bee609	t	t	1	\N	\N	\N
8233f65e-333a-4a93-86f7-d33ad7b4ab96	bearer	2037-02-17 14:09:00.019	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-02-17 17:53:41.111	2017-02-17 17:53:41.112	0bda87e38e59d17fc1cadc1bbccdfd1b	1268	\N	54bb9d57-4ee3-4990-b51b-9b9001b6f872	t	t	1	\N	\N	\N
5f57fdf8-8353-45fb-a133-098c6ad389b0	bearer	2017-02-17 18:54:58.963	9999-0000-0000-0005	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/authenticate /funding/create /orcid-bio/update /orcid-bio/read-limited /affiliations/update /affiliations/create /orcid-bio/external-identifiers/create /peer-review/read-limited /orcid-works/update /orcid-profile/read-limited /funding/update /activities/read-limited /orcid-works/create /orcid-works/read-limited /peer-review/create /activities/update /funding/read-limited /affiliations/read-limited	orcid	2017-02-17 17:54:58.977	2017-02-17 17:54:58.977	816a0fcfc745327b020fc30e26b5ae60	1271	\N	195bef9a-329f-4e98-b883-cae2e5b2aa66	\N	f	1	\N	\N	\N
e4b50738-d9ff-4167-a3f7-ced3af523f26	bearer	2037-02-17 14:11:01.33	9999-0000-0000-0004	APP-9999999999999903	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/authenticate	orcid	2017-02-17 17:55:42.334	2017-02-17 17:55:42.334	8f8c14436439216e305452a23b785553	1272	\N	df808827-392b-4f9f-a8d7-a5d7d846fe72	\N	t	1	\N	\N	\N
c0a66f47-1939-4437-9a89-5a42736dfdea	bearer	2037-02-17 14:12:33.203	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 17:57:14.205	2017-02-17 17:57:14.205	276069c4d3be949258d185c0e1701278	1279	\N	f54cf35c-3b45-4768-8e4a-e6eb0dbfd6d3	\N	f	1	\N	\N	\N
617747a7-f38a-43cc-831d-cc5d308e4424	bearer	2017-02-17 18:57:54.493	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/read-limited /activities/update	orcid	2017-02-17 17:57:54.51	2017-02-17 17:57:54.51	e3714e3172f789b56ced4c9de7630831	1281	\N	2a6a806f-5513-4bad-869d-438e01e79abe	\N	f	1	\N	\N	\N
adb2d9cf-424a-482b-ad05-c8cd295734b3	bearer	2017-02-17 18:57:59.984	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited	orcid	2017-02-17 17:57:59.996	2017-02-17 17:57:59.996	0a0e67a368170de6a22fa6869d56af96	1282	\N	5a55fc9d-54ac-4806-b436-df67cbbf1cdc	\N	f	1	\N	\N	\N
2204ad91-2509-4e6e-96a8-8ba4f31cde0a	bearer	2017-02-17 18:58:32.884	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited	orcid	2017-02-17 17:58:32.893	2017-02-17 17:58:32.893	0a0e67a368170de6a22fa6869d56af96	1283	\N	7bb27c4a-0872-47ba-aa46-17d9f2aba03f	\N	f	1	\N	\N	\N
5fbb93b2-c7f9-4fdd-a3c7-beb3e7ee4c80	bearer	2037-02-17 14:13:53.965	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 17:58:34.965	2017-02-17 17:58:34.965	3903ba3ee40c69281e6a7bce61453a28	1284	\N	4cc2fe35-683d-423e-bfd4-1158def1bcf5	\N	f	1	\N	\N	\N
2a621ba5-3c86-46b6-a0ef-0c848c3d5d8a	bearer	2037-02-17 14:12:30.615	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited /activities/update	orcid	2017-02-17 17:57:11.625	2017-02-17 17:57:11.625	8f4bb4c14da23b3e0e0858736155654f	1278	\N	fff34bdf-f29e-460c-b37d-c669bb665992	t	t	1	\N	\N	\N
457bfbfb-e299-405e-8653-965dde961ee1	bearer	2037-02-17 14:11:55.994	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update /funding/read-limited	orcid	2017-02-17 17:56:37.017	2017-02-17 17:56:37.017	9562e716c33ea1ff51decac39b44a3d8	1277	\N	c03d100d-b676-47c9-999f-f7e293e62501	t	t	1	\N	\N	\N
3a5c5d71-e49c-4e13-9625-9c7c8cee9358	bearer	2037-02-17 14:11:51.588	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update /affiliations/read-limited	orcid	2017-02-17 17:56:32.599	2017-02-17 17:56:32.599	906af268b7598ffd07ff23470c49bcd2	1276	\N	92af29bc-894f-430f-8e91-c9c451dc5bca	t	t	1	\N	\N	\N
51217064-e90d-4f4d-963d-fe3488afc0d2	bearer	2037-02-17 14:11:47.379	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/read-limited /activities/update	orcid	2017-02-17 17:56:28.388	2017-02-17 17:56:28.388	9b60ebaa0c8d0fc73ae084d0a3ce25ec	1275	\N	6d2f4a88-e3a6-4210-b7f1-f1d7ece981ee	t	t	1	\N	\N	\N
d3a5c90c-766c-446b-a21b-6edcd659675c	bearer	2037-02-17 14:11:11.948	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/read-limited /person/update	orcid	2017-02-17 17:55:52.956	2017-02-17 17:55:52.956	25a972c7561ef6e6862c1b11d5f9e513	1274	\N	3148bebe-9c71-4cca-a721-63a5245bded7	t	t	1	\N	\N	\N
30ef8464-9695-4884-8890-303b2872a2b6	bearer	2037-02-17 14:14:49.027	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:59:30.028	2017-02-17 17:59:30.028	7ae782f285d4d938c43c85528cfaf229	1297	\N	a14677fa-8f70-4755-9c6d-527674bd7a6a	\N	f	1	\N	\N	\N
451f2c89-9591-4e95-9167-679f8b701d4d	bearer	2037-02-17 14:14:49.094	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:59:30.096	2017-02-17 17:59:30.096	7ae782f285d4d938c43c85528cfaf229	1298	\N	57e8e10e-09c1-4477-8bca-8253a6bcc0d4	\N	f	1	\N	\N	\N
35f78974-0878-480e-b9cd-e8ebb4cfa7e3	bearer	2037-02-17 14:14:49.316	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:59:30.317	2017-02-17 17:59:30.317	7ae782f285d4d938c43c85528cfaf229	1299	\N	a31895f6-0f3f-4d5b-8a7d-f4b350025465	\N	f	1	\N	\N	\N
8d6cb5cb-09a1-43b2-90df-3fc52d98b4e1	bearer	2017-02-17 18:58:38.994	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-02-17 17:58:39.001	2017-02-17 17:58:39.001	0bda87e38e59d17fc1cadc1bbccdfd1b	1285	\N	2db73ac7-b1d5-450b-a792-01bffff0c06d	t	f	1	\N	\N	\N
53aa25e8-0f42-4b90-9a85-957271151eac	bearer	2037-02-17 14:14:04.939	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:58:45.94	2017-02-17 17:58:45.94	7ae782f285d4d938c43c85528cfaf229	1286	\N	381d6b6a-8e49-4cb5-a766-12f75ccc64f0	\N	f	1	\N	\N	\N
edeaa796-2017-44fc-bb84-df6edf2f49fe	bearer	2037-02-17 14:14:05.039	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:58:46.039	2017-02-17 17:58:46.039	7ae782f285d4d938c43c85528cfaf229	1287	\N	be005df2-9181-4902-9c79-d6932ffd3470	\N	f	1	\N	\N	\N
116e4c0e-31f5-4a86-b4bc-900be98675f5	bearer	2037-02-17 14:14:05.217	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:58:46.218	2017-02-17 17:58:46.218	7ae782f285d4d938c43c85528cfaf229	1288	\N	0674a3df-1091-40f1-b16f-03b0a7700190	\N	f	1	\N	\N	\N
2fedd857-243c-4b0a-9f31-5de207fa6597	bearer	2037-02-17 14:14:05.639	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:58:46.641	2017-02-17 17:58:46.641	7ae782f285d4d938c43c85528cfaf229	1289	\N	73a15aca-b571-4875-a38f-3dcc6b282de1	\N	f	1	\N	\N	\N
a480d803-2d08-4a48-b71e-a5259ce20bc5	bearer	2037-02-17 14:14:06.062	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:58:47.064	2017-02-17 17:58:47.064	7ae782f285d4d938c43c85528cfaf229	1291	\N	2876b90f-3ad3-4aa8-9446-439976f21e7f	\N	f	1	\N	\N	\N
2cdae99f-f9f5-4870-a217-f89a8c54c2d4	bearer	2017-02-17 18:59:27.862	9999-0000-0000-0004	APP-9999999999999902	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/read-limited /activities/update	orcid	2017-02-17 17:59:27.871	2017-02-17 17:59:27.871	7c11d9959699262153197be480ab1e30	1293	\N	074b029e-82cd-49a9-a2fa-b1ccf0585d54	\N	f	1	\N	\N	\N
2434522d-cb53-4350-a879-1bab5b9d3b63	bearer	2037-02-17 14:14:48.62	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:59:29.621	2017-02-17 17:59:29.621	7ae782f285d4d938c43c85528cfaf229	1295	\N	f6e85300-ec54-444c-902a-13f6a9ec602e	\N	f	1	\N	\N	\N
f1b601a8-a44f-4710-92ed-0587d470f70c	bearer	2037-02-17 14:14:49.793	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:59:30.795	2017-02-17 17:59:30.795	7ae782f285d4d938c43c85528cfaf229	1300	\N	ca260d6a-6919-4b1c-a572-3331e4e084c5	\N	f	1	\N	\N	\N
ab98cd22-ae34-40d2-926c-9d7d8b3ed8fa	bearer	2037-02-17 14:14:49.966	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:59:30.967	2017-02-17 17:59:30.967	7ae782f285d4d938c43c85528cfaf229	1301	\N	d1518c78-04c6-4762-9caf-48f066648dcf	\N	f	1	\N	\N	\N
2eb322d3-bdfd-4c79-8155-c272dae2a373	bearer	2017-02-17 19:00:04.54	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited	orcid	2017-02-17 18:00:04.547	2017-02-17 18:00:04.547	0a0e67a368170de6a22fa6869d56af96	1302	\N	c3e018a4-8f5b-41c3-b1f3-081ce59365a9	\N	f	1	\N	\N	\N
f33bced5-315a-40b6-a936-999ecfae4f2c	bearer	2037-02-17 14:15:31.498	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:00:12.499	2017-02-17 18:00:12.499	7ae782f285d4d938c43c85528cfaf229	1303	\N	d638b774-5710-40a1-b4ad-a1f23f231339	\N	f	1	\N	\N	\N
40edda9f-8cb2-4ae6-97c0-9e0391438aae	bearer	2037-02-17 14:15:31.564	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:00:12.564	2017-02-17 18:00:12.564	7ae782f285d4d938c43c85528cfaf229	1304	\N	4e21d70e-1293-48cd-ae56-27a5d550d322	\N	f	1	\N	\N	\N
2e6fc8b1-8863-4b23-9ff1-66e3b8162d0e	bearer	2037-02-17 14:15:31.972	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:00:12.973	2017-02-17 18:00:12.973	7ae782f285d4d938c43c85528cfaf229	1307	\N	609289d3-0353-402d-9863-2d703282423f	\N	f	1	\N	\N	\N
4db235a1-6a83-4f38-b818-0c12ef1c4fbc	bearer	2037-02-17 14:15:32.084	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:00:13.085	2017-02-17 18:00:13.085	7ae782f285d4d938c43c85528cfaf229	1308	\N	57705db9-79ad-4ab4-afdd-d5357fb7f698	\N	f	1	\N	\N	\N
cdfe5184-673c-4d40-8ffa-a7fbf5a79aff	bearer	2037-02-17 14:15:32.308	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:00:13.309	2017-02-17 18:00:13.309	7ae782f285d4d938c43c85528cfaf229	1309	\N	b0dc6aa5-99c3-43bc-a9b8-45a1343a1212	\N	f	1	\N	\N	\N
6c915351-25ad-4a21-8840-35409092670b	bearer	2037-02-17 14:15:32.531	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:00:13.532	2017-02-17 18:00:13.532	7ae782f285d4d938c43c85528cfaf229	1310	\N	4e1331ce-eb74-47f6-955d-4084f7997572	\N	f	1	\N	\N	\N
facdbead-a280-4600-be50-04ef7eb48c97	bearer	2037-02-17 14:14:05.863	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:58:46.864	2017-02-17 17:58:46.864	7ae782f285d4d938c43c85528cfaf229	1290	\N	2b3b2884-b28b-417b-904c-dca18464231e	\N	f	1	\N	\N	\N
b8c2d2e2-9c5a-4cec-9693-42e2facc4d89	bearer	2037-02-17 14:14:06.248	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:58:47.248	2017-02-17 17:58:47.248	7ae782f285d4d938c43c85528cfaf229	1292	\N	3027417f-4944-48ba-afe3-c4d683bc69e9	\N	f	1	\N	\N	\N
8d0545e7-0c22-41c6-acf5-61d031a3b83b	bearer	2037-02-17 14:14:48.56	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:59:29.561	2017-02-17 17:59:29.561	7ae782f285d4d938c43c85528cfaf229	1294	\N	14c2996f-8c41-4c03-ae02-3989dc50404f	\N	f	1	\N	\N	\N
a57cc4ce-e3ba-4ac9-873a-1d942d4a96e8	bearer	2037-02-17 14:14:48.71	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 17:59:29.712	2017-02-17 17:59:29.712	7ae782f285d4d938c43c85528cfaf229	1296	\N	1fd26dd2-8711-49f5-8f2b-06da4c9ff043	\N	f	1	\N	\N	\N
27f6b398-cf13-4fad-a781-ec0807405ecd	bearer	2037-02-17 14:16:34.901	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:15.901	2017-02-17 18:01:15.901	7ae782f285d4d938c43c85528cfaf229	1311	\N	d0257110-b390-49f7-b256-9959b6235812	\N	f	1	\N	\N	\N
154dc662-4991-496b-a0e6-52863b14ae61	bearer	2037-02-17 14:16:34.939	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:15.94	2017-02-17 18:01:15.94	7ae782f285d4d938c43c85528cfaf229	1312	\N	eaf2e579-2d60-4f55-bdc8-2648092faf74	\N	f	1	\N	\N	\N
e4370a0b-4d98-4e52-9cf4-c8374f073bc5	bearer	2037-02-17 14:16:35.026	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:16.074	2017-02-17 18:01:16.074	7ae782f285d4d938c43c85528cfaf229	1313	\N	654d2161-e41d-42a4-a293-fd547c1b0de1	\N	f	1	\N	\N	\N
e09b3973-efe5-4058-8d0e-3bfb3b0d9971	bearer	2037-02-17 14:16:35.31	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:16.311	2017-02-17 18:01:16.311	7ae782f285d4d938c43c85528cfaf229	1314	\N	24bc44cb-a715-4e2e-aa37-906d9e076bbd	\N	f	1	\N	\N	\N
d2369339-3472-41b8-a179-030b85d4dc9e	bearer	2037-02-17 14:16:35.357	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:16.358	2017-02-17 18:01:16.358	7ae782f285d4d938c43c85528cfaf229	1315	\N	f4ce6d79-5eb5-4571-98e1-41f2b2098bcf	\N	f	1	\N	\N	\N
562c1246-948a-4b6f-b198-f851239c9aa1	bearer	2037-02-17 14:16:35.529	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:16.53	2017-02-17 18:01:16.53	7ae782f285d4d938c43c85528cfaf229	1316	\N	0f87a610-6c4b-493f-b3d5-c567e75fd7f3	\N	f	1	\N	\N	\N
cf12bed4-f9cd-4da9-8b71-b186adb516c2	bearer	2037-02-17 14:16:35.734	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:16.735	2017-02-17 18:01:16.735	7ae782f285d4d938c43c85528cfaf229	1317	\N	3a6aceea-4bed-407b-9b93-0a624774d2af	\N	f	1	\N	\N	\N
471b576d-3425-476e-8b0c-7a77dce4111f	bearer	2037-02-17 14:16:35.836	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:16.836	2017-02-17 18:01:16.836	7ae782f285d4d938c43c85528cfaf229	1318	\N	f40378cf-07f2-46c7-9829-7539d4a8dd48	\N	f	1	\N	\N	\N
d255d4ca-ffda-4ff5-ad97-9ca897cafa6c	bearer	2037-02-17 14:16:50.323	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:31.324	2017-02-17 18:01:31.324	7ae782f285d4d938c43c85528cfaf229	1319	\N	e2e79673-e0fb-4ce0-99f4-1bb444de13f6	\N	f	1	\N	\N	\N
09d8b1f0-d7e1-47a6-9462-b2ee77c56825	bearer	2037-02-17 14:16:50.377	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:31.379	2017-02-17 18:01:31.379	7ae782f285d4d938c43c85528cfaf229	1320	\N	d943c916-2d8d-4a5e-a586-6f9f5bbf436e	\N	f	1	\N	\N	\N
9c3e9453-7aca-476d-8a0f-596d68c73808	bearer	2037-02-17 14:16:50.455	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:31.456	2017-02-17 18:01:31.456	7ae782f285d4d938c43c85528cfaf229	1321	\N	baa569ea-fa0f-4d4d-88f6-f9e510896ccc	\N	f	1	\N	\N	\N
4b7561de-0a01-4a8d-a73d-6808c9a62fc7	bearer	2037-02-17 14:16:50.678	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:31.679	2017-02-17 18:01:31.679	7ae782f285d4d938c43c85528cfaf229	1322	\N	fe3fc7a0-aa60-4025-9560-2ef8adee3798	\N	f	1	\N	\N	\N
62bd3c62-e7eb-49fd-ad9a-814650e8c650	bearer	2037-02-17 14:16:50.771	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:31.772	2017-02-17 18:01:31.772	7ae782f285d4d938c43c85528cfaf229	1323	\N	0d86a16b-d892-43d1-8f7a-9da3a0ddc107	\N	f	1	\N	\N	\N
8dd06fa3-ebfb-4e49-afd0-d0c2e5d0a7a0	bearer	2037-02-17 14:16:50.939	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:31.94	2017-02-17 18:01:31.94	7ae782f285d4d938c43c85528cfaf229	1324	\N	035f212c-b205-4c2a-918e-9a6901a5206e	\N	f	1	\N	\N	\N
6a505a57-3924-4ae2-9165-e727ef88005f	bearer	2037-02-17 14:16:51.187	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:32.188	2017-02-17 18:01:32.188	7ae782f285d4d938c43c85528cfaf229	1325	\N	2ab91c0b-09a2-4c48-bbca-bf4c7dfc90ea	\N	f	1	\N	\N	\N
d4ca4f9c-571d-474a-b702-ddc60997a503	bearer	2037-02-17 14:16:51.293	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 18:01:32.295	2017-02-17 18:01:32.295	7ae782f285d4d938c43c85528cfaf229	1326	\N	00a4b93e-1daf-4ae6-8134-bcd50ffb5f29	\N	f	1	\N	\N	\N
61733fe6-52d8-4a72-ad59-c079fa74077e	bearer	2017-02-17 19:08:57.26	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited /person/update	orcid	2017-02-17 18:08:57.274	2017-02-17 18:08:57.274	1de735e9a8b9c85bd130173dc43bea30	1327	\N	00439b97-79e7-4ae3-831f-dee8b5b085fc	\N	f	1	\N	\N	\N
e1e9429c-b55a-4eaa-aa84-c91ffd2e9e99	bearer	2037-02-17 14:24:46.658	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 18:09:27.659	2017-02-17 18:09:27.659	3903ba3ee40c69281e6a7bce61453a28	1328	\N	1d24302b-caf1-4c69-bf3b-1a40b6d1d417	\N	f	1	\N	\N	\N
13c85967-618f-4ac8-a0dd-6f5cca573793	bearer	2037-02-17 14:24:46.706	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 18:09:27.706	2017-02-17 18:09:27.706	3903ba3ee40c69281e6a7bce61453a28	1329	\N	b1ea5bfa-4bd0-4af9-b782-31dfe79e8501	\N	f	1	\N	\N	\N
ef64338e-d91c-4fad-9994-ee68ad323fb2	bearer	2037-02-17 14:24:46.726	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 18:09:27.727	2017-02-17 18:09:27.727	3903ba3ee40c69281e6a7bce61453a28	1330	\N	0c712c23-6517-4c59-93c9-d4c79bc47b2c	\N	f	1	\N	\N	\N
e01a2668-388b-487d-9e5c-6a6eefebd1fe	bearer	2037-02-17 14:24:46.759	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 18:09:27.76	2017-02-17 18:09:27.76	3903ba3ee40c69281e6a7bce61453a28	1331	\N	0992504a-2d2a-4d2a-a54c-bb5b661663c4	\N	f	1	\N	\N	\N
2681d43f-43b7-4f65-8d46-45f043330845	bearer	2037-02-17 14:24:46.777	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 18:09:27.777	2017-02-17 18:09:27.777	3903ba3ee40c69281e6a7bce61453a28	1332	\N	c5a5ca18-25c4-4991-89f0-fc34efdb06ee	\N	f	1	\N	\N	\N
e5657f5b-ac9b-4957-9c9d-27aea54e26d8	bearer	2037-02-17 14:24:46.809	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 18:09:27.81	2017-02-17 18:09:27.81	3903ba3ee40c69281e6a7bce61453a28	1333	\N	a97e9923-05a8-4eb1-88a6-d7c879e325e0	\N	f	1	\N	\N	\N
cfe2665e-e04f-4676-9985-2027e330474b	bearer	2037-02-17 14:24:46.83	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 18:09:27.831	2017-02-17 18:09:27.831	3903ba3ee40c69281e6a7bce61453a28	1334	\N	dc5423eb-8031-4848-9d3b-dd45681b9fe8	\N	f	1	\N	\N	\N
797a0aef-4eef-42b5-9f60-4fd8abd1d9fc	bearer	2037-02-17 14:24:46.891	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 18:09:27.892	2017-02-17 18:09:27.892	3903ba3ee40c69281e6a7bce61453a28	1335	\N	02da0c4e-1f83-4917-853b-1a6de8518106	\N	f	1	\N	\N	\N
481fd115-28f4-4aed-bdc8-df52bcc0ca12	bearer	2037-02-17 14:24:46.91	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 18:09:27.911	2017-02-17 18:09:27.911	3903ba3ee40c69281e6a7bce61453a28	1336	\N	56a5fd7a-fdc5-4460-806a-c8fc37e3a445	\N	f	1	\N	\N	\N
6c8476e4-1136-4c02-b6ea-f3ecc87d9901	bearer	2037-02-17 14:24:46.941	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 18:09:27.942	2017-02-17 18:09:27.942	3903ba3ee40c69281e6a7bce61453a28	1337	\N	a651f55e-840d-4130-ac83-cc38ae31421b	\N	f	1	\N	\N	\N
f36db571-4edf-4fea-8e56-ff71f539eeeb	bearer	2017-02-17 19:24:19.591	9999-0000-0000-0005	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/create	orcid	2017-02-17 18:24:19.597	2017-02-17 18:24:19.597	523e41d1878164a96ebbb0e660ca67d6	1339	\N	68b16c01-3141-426a-8fcd-e3b0110b6b06	\N	f	1	\N	\N	\N
2871ead2-f173-4871-ae8b-8de1f99e8ed2	bearer	2017-02-17 19:29:24.521	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/read-limited /activities/update /person/read-limited /person/update	orcid	2017-02-17 18:29:24.525	2017-02-17 18:29:24.525	1996962dd2ca7e68e5fa85b765f5511c	1340	\N	28ef763a-cb0b-419f-bbd3-69de835f4827	\N	f	1	\N	\N	\N
a8b27371-1161-42b4-8ac0-b718ab35152b	bearer	2037-02-17 14:38:32.459	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/create	orcid	2017-02-17 18:23:13.466	2017-02-17 18:23:13.466	b3a39107debe4fa63ea7b671d5a9b94f	1338	\N	8d4bd3d2-0685-47fa-9886-e8cc7e6c8e10	t	t	1	\N	\N	\N
a41b3286-ec4f-41e7-b05c-4904ca15d3af	bearer	2037-02-17 14:44:43.542	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 18:29:24.542	2017-02-17 18:29:24.542	3903ba3ee40c69281e6a7bce61453a28	1341	\N	b513f326-d305-447d-adb2-197fad97c810	\N	f	1	\N	\N	\N
2d3cd71a-0b74-4222-87f8-e7072ac19cf6	bearer	2037-02-17 17:33:45.258	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/create	orcid	2017-02-17 21:18:26.267	2017-02-17 21:18:26.267	b3a39107debe4fa63ea7b671d5a9b94f	1345	\N	c50ff05f-bb57-49c4-848b-2fab6418928b	t	t	1	\N	\N	\N
b6d66612-fef2-4e76-91b6-075d43482ee6	bearer	2037-02-17 17:33:41.575	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/update	orcid	2017-02-17 21:18:22.582	2017-02-17 21:18:22.582	fad621ce48150605d4475825fd56fc8e	1344	\N	ec89380e-cc65-4fbf-bdb7-fccc277797da	t	t	1	\N	\N	\N
b0f88ed6-dbe9-4fb9-a9ac-817b7ba22a47	bearer	2037-02-17 17:33:08.311	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/affiliations/create	orcid	2017-02-17 21:17:49.362	2017-02-17 21:17:49.362	8d85c644fbd4e520f1869b9fe3cdc941	1343	\N	0836754a-1a02-402e-bb6b-f74e27f17dc9	t	t	1	\N	\N	\N
7fefe56d-cc00-4cc0-9f5a-9fecadd64dec	bearer	2037-02-17 17:32:34.559	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/funding/create	orcid	2017-02-17 21:17:15.586	2017-02-17 21:17:15.586	aee8da68d76b954cba9eae9a2276b328	1342	\N	bb287a43-f9e5-4139-9d18-e2afbd21cadb	t	t	1	\N	\N	\N
126a227e-b26a-4978-aa6d-c687ee5088ad	bearer	2037-02-17 14:13:08.775	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/update	orcid	2017-02-17 17:57:49.791	2017-02-17 17:57:49.791	9d26f627b8846ec45287788770373b7e	1280	\N	82705bf0-2651-4fc8-8f9a-a6343b1f3d17	t	t	1	\N	\N	\N
4f0ee3a4-5f36-46ec-93c6-97080c3d56e0	bearer	2037-02-17 17:36:26.452	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:21:07.453	2017-02-17 21:21:07.453	276069c4d3be949258d185c0e1701278	1351	\N	30bbf090-caa4-46e7-ba88-501c2bf8df45	\N	f	1	\N	\N	\N
a46f9ed4-4ce9-4db5-9307-fa060f87ff66	bearer	2037-02-17 17:36:26.584	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:21:07.585	2017-02-17 21:21:07.585	276069c4d3be949258d185c0e1701278	1352	\N	fa4eadc8-ad1c-43fd-a087-febef2b20ad1	\N	f	1	\N	\N	\N
a94c85ae-0772-42a8-bc18-bec76dc890d0	bearer	2037-02-17 17:36:26.718	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:21:07.719	2017-02-17 21:21:07.719	276069c4d3be949258d185c0e1701278	1353	\N	249d8270-e9a4-4bdb-b889-8cfc92188382	\N	f	1	\N	\N	\N
7089bc4d-688c-420c-b74b-4b7f6547247b	bearer	2037-02-17 17:36:26.967	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:21:07.968	2017-02-17 21:21:07.968	276069c4d3be949258d185c0e1701278	1354	\N	0f75c553-bdce-4141-a937-534b69709558	\N	f	1	\N	\N	\N
e1674428-bbef-48d8-94ab-1c6540da5cad	bearer	2037-02-17 17:36:27.001	\N	APP-9999999999999901	t	\N		\N	/read-public	orcid	2017-02-17 21:21:08.002	2017-02-17 21:21:08.002	165a3ec304597c3dd5b7880503a1958c	1355	\N	43927517-c174-4b45-9835-8c6eec5298c9	\N	f	1	\N	\N	\N
e03b54a1-4998-4581-8f68-d5e9192f7010	bearer	2037-02-17 17:36:27.193	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:21:08.195	2017-02-17 21:21:08.195	276069c4d3be949258d185c0e1701278	1356	\N	110d9c55-f2b5-482c-be9d-7222424a1c86	\N	f	1	\N	\N	\N
41d64fb3-e832-4334-b04d-4d7b92f5655f	bearer	2037-02-17 17:36:27.233	\N	APP-9999999999999901	t	\N		\N	/webhook	orcid	2017-02-17 21:21:08.235	2017-02-17 21:21:08.235	92702bb32527e9c0b24b902554b1142e	1357	\N	d9098536-3592-4962-8dc3-01bc47ac315f	\N	f	1	\N	\N	\N
f6c0571a-b0f2-4807-b954-15aafe4d60db	bearer	2037-02-17 17:36:47.969	\N	APP-9999999999999901	t	\N		\N	/read-public	orcid	2017-02-17 21:21:28.971	2017-02-17 21:21:28.971	165a3ec304597c3dd5b7880503a1958c	1358	\N	bcbe4f09-806c-4a74-8a1e-64ba75d4a2d8	\N	f	1	\N	\N	\N
4ecd343e-8a83-4bfc-8361-15079bf63ba0	bearer	2037-02-17 17:36:52.564	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-02-17 21:21:33.571	2017-02-17 21:21:33.571	0bda87e38e59d17fc1cadc1bbccdfd1b	1359	\N	56c4cef3-874c-4bed-9f3f-8200ab761ba8	t	t	1	\N	\N	\N
8d9be4bd-e4aa-45b9-94aa-beb589e50cec	bearer	2037-02-17 17:37:26.234	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/update	orcid	2017-02-17 21:22:07.248	2017-02-17 21:22:07.248	257a8a1c2371db71629b27aa8d47f7e1	1361	\N	f27e7eb8-dbae-4d6d-ab3f-41aca8df9156	t	t	1	\N	\N	\N
efccd3b3-cc0f-462d-9c98-902a8742a0f2	bearer	2037-02-17 17:36:52.564	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-02-17 21:21:33.646	2017-02-17 21:21:33.646	0bda87e38e59d17fc1cadc1bbccdfd1b	1360	\N	2e127f94-e0ff-4c3a-bf7d-9bcef803343c	t	t	1	\N	\N	\N
ff3f351d-dc72-4f83-a9f6-866068ff6969	bearer	2037-02-17 17:36:22.744	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-02-17 21:21:03.766	2017-02-17 21:21:03.766	0bda87e38e59d17fc1cadc1bbccdfd1b	1350	\N	da8a9dfa-af28-4473-b205-4bb925b89c5a	t	t	1	\N	\N	\N
ca6d4ba5-9b03-4f7a-b647-0c8039f4c971	bearer	2037-02-17 17:36:19.332	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-02-17 21:21:00.34	2017-02-17 21:21:00.34	0bda87e38e59d17fc1cadc1bbccdfd1b	1349	\N	cf25ee6a-bd2d-4cb8-802e-cd8c6c4204a9	t	t	1	\N	\N	\N
1aac20f6-f868-4c7f-b3c0-dc4d48e1db42	bearer	2037-02-17 17:35:05.364	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/update	orcid	2017-02-17 21:19:46.371	2017-02-17 21:19:46.371	9d26f627b8846ec45287788770373b7e	1348	\N	933a7559-c3a6-4313-909e-3dc5f1f5f595	t	t	1	\N	\N	\N
92cad446-bdf7-4b37-8f37-5bb66afec1fe	bearer	2037-02-17 17:34:58.449	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/update	orcid	2017-02-17 21:19:39.457	2017-02-17 21:19:39.457	9d26f627b8846ec45287788770373b7e	1347	\N	8d83c1c5-ec27-4112-bd1a-f7c2d8ae01d6	t	t	1	\N	\N	\N
cf7a0cc8-aa08-435a-9ed8-cca96663dbf7	bearer	2017-02-17 22:19:28.842	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/external-identifiers/create	orcid	2017-02-17 21:19:28.852	2017-02-17 21:19:28.852	e9277db1e22ce8058f356ef32c679960	1346	\N	31fc9422-4cb9-4b46-8a9f-45b07c5138c2	t	f	1	\N	\N	\N
24334503-b0f6-40bd-b5b4-71f97265cee3	bearer	2017-02-17 22:22:25.237	9999-0000-0000-0005	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/authenticate /funding/create /orcid-bio/update /orcid-bio/read-limited /affiliations/update /affiliations/create /orcid-bio/external-identifiers/create /peer-review/read-limited /orcid-works/update /orcid-profile/read-limited /funding/update /activities/read-limited /orcid-works/create /orcid-works/read-limited /peer-review/create /activities/update /funding/read-limited /affiliations/read-limited	orcid	2017-02-17 21:22:25.243	2017-02-17 21:22:25.243	816a0fcfc745327b020fc30e26b5ae60	1362	\N	d7b50cb3-121e-498f-9a8c-0464ca3011f6	\N	f	1	\N	\N	\N
85a567e2-63f1-48e7-8bd0-1d0dbff475d6	bearer	2037-02-17 17:38:03.845	9999-0000-0000-0004	APP-9999999999999903	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/authenticate	orcid	2017-02-17 21:22:44.848	2017-02-17 21:22:44.848	8f8c14436439216e305452a23b785553	1363	\N	b7111472-a0c8-4c3b-be10-4a19f82ed2ea	\N	t	1	\N	\N	\N
c652369b-572e-49a7-8d4f-186a10b2ba28	bearer	2037-02-17 17:39:37.891	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:24:18.895	2017-02-17 21:24:18.895	276069c4d3be949258d185c0e1701278	1369	\N	923fcbf9-c926-47f3-acbb-206f11b3b8e5	\N	f	1	\N	\N	\N
85274e18-5a15-4298-8355-4973415aa992	bearer	2017-02-17 22:24:30.715	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/read-limited /activities/update	orcid	2017-02-17 21:24:30.722	2017-02-17 21:24:30.722	e3714e3172f789b56ced4c9de7630831	1371	\N	ab5dc5b2-3aaa-4b99-93f5-ff1abba9ea22	\N	f	1	\N	\N	\N
7aeedf7d-99b6-4965-b128-c9ce8aa230ab	bearer	2037-02-17 17:39:56.271	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:24:37.272	2017-02-17 21:24:37.272	3903ba3ee40c69281e6a7bce61453a28	1372	\N	3cff503d-df65-4d51-8887-fcced870286b	\N	f	1	\N	\N	\N
5949e0f5-f7aa-4dbe-8c48-3d131ca6f7ba	bearer	2037-02-17 17:39:57.087	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:24:38.088	2017-02-17 21:24:38.088	7fb1b415f5231d2280fa57cfb5053d5e	1373	\N	77108c22-0faa-4a5f-9e25-1ef8482b6d8f	\N	f	1	\N	\N	\N
8a256a2a-2a54-4452-893f-4b83c60b61f0	bearer	2037-02-17 17:40:06.344	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:24:47.345	2017-02-17 21:24:47.345	7fb1b415f5231d2280fa57cfb5053d5e	1375	\N	1594b7bf-6131-40b3-a4a0-c8f1b647a63f	\N	f	1	\N	\N	\N
5473e5e8-2ede-4e07-9634-7cdb1416406f	bearer	2017-02-17 22:24:52.199	9999-0000-0000-0004	APP-9999999999999902	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/read-limited /activities/update	orcid	2017-02-17 21:24:52.206	2017-02-17 21:24:52.206	7c11d9959699262153197be480ab1e30	1376	\N	09c527c6-84ca-4a2d-858e-6cb10166ad3d	\N	f	1	\N	\N	\N
bed6b6a1-7134-4b5c-b2b7-0c974f4b147c	bearer	2037-02-17 17:40:23.618	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:25:04.66	2017-02-17 21:25:04.66	7fb1b415f5231d2280fa57cfb5053d5e	1377	\N	e69eb1b2-e569-422e-9140-22a7d8a74e9a	\N	f	1	\N	\N	\N
9116e114-9cd7-4eb5-9337-2fc767f2e270	bearer	2037-02-17 17:40:25.574	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:25:06.575	2017-02-17 21:25:06.575	7fb1b415f5231d2280fa57cfb5053d5e	1378	\N	bd3f02cd-5475-45c6-947d-11dc271390d6	\N	f	1	\N	\N	\N
ef9a151e-da7f-4d08-b483-7576b80ae007	bearer	2017-02-17 22:25:13.458	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited	orcid	2017-02-17 21:25:13.463	2017-02-17 21:25:13.463	0a0e67a368170de6a22fa6869d56af96	1379	\N	360eeb8a-aef5-46ea-b33a-74fd1bc119ef	\N	f	1	\N	\N	\N
85fee1ec-baea-4ae1-bf7f-698686f5bca9	bearer	2017-02-17 22:25:46.525	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited	orcid	2017-02-17 21:25:46.529	2017-02-17 21:25:46.529	0a0e67a368170de6a22fa6869d56af96	1380	\N	52bf9f43-9e4e-446b-9338-555bc61cc356	\N	f	1	\N	\N	\N
fb63613a-5d60-458e-a781-42c1b5f6e75c	bearer	2037-02-17 17:41:11.195	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:25:52.196	2017-02-17 21:25:52.196	3903ba3ee40c69281e6a7bce61453a28	1382	\N	a278847c-96ff-455a-82ab-e5a11dcb12be	\N	f	1	\N	\N	\N
28b2c230-3979-4bc9-a830-55cecf8058f9	bearer	2017-02-17 22:28:31.298	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-02-17 21:28:31.304	2017-02-17 21:28:31.304	0bda87e38e59d17fc1cadc1bbccdfd1b	1383	\N	88aff14d-b129-43db-b959-7d0320b6ff70	\N	f	1	\N	\N	\N
f4b993f7-fc60-4e15-8fc2-ce3cde6e33aa	bearer	2017-02-17 22:28:35.409	9999-0000-0000-0005	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-02-17 21:28:35.414	2017-02-17 21:28:35.414	6874fe1113b312acd89df942175e92cb	1384	\N	5a82834f-19b6-445e-b98f-c1ed0afe4977	\N	f	1	\N	\N	\N
d881068b-7d79-4467-b88e-187c4eb833ab	bearer	2037-02-17 17:43:55.721	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:28:36.753	2017-02-17 21:28:36.753	7ae782f285d4d938c43c85528cfaf229	1385	\N	eaaa4dbf-aec2-41a8-97a2-ba6c9e72ae20	\N	f	1	\N	\N	\N
f2ae9a25-765b-4577-a39c-e6c97e544309	bearer	2037-02-17 17:43:55.792	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:28:36.793	2017-02-17 21:28:36.793	7ae782f285d4d938c43c85528cfaf229	1386	\N	a04dd8f1-f07a-448c-8037-4eadae821a45	\N	f	1	\N	\N	\N
de952a5c-60a1-41ec-b668-c503b1e81902	bearer	2037-02-17 17:43:56.176	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:28:37.177	2017-02-17 21:28:37.177	7ae782f285d4d938c43c85528cfaf229	1387	\N	3137ebf9-fea2-4607-b615-d23042fb99d9	\N	f	1	\N	\N	\N
0b434f65-8316-4a1d-a1ea-ed8f2d2e223b	bearer	2037-02-17 17:43:56.53	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:28:37.531	2017-02-17 21:28:37.531	7ae782f285d4d938c43c85528cfaf229	1388	\N	55b522a7-5504-4a5a-8bbe-dc6bdbb73d0d	\N	f	1	\N	\N	\N
24ad6069-ce35-4e5d-8d67-4816a1869732	bearer	2037-02-17 17:43:56.742	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:28:37.794	2017-02-17 21:28:37.794	7ae782f285d4d938c43c85528cfaf229	1389	\N	cbdb883c-3699-443e-ae26-6633ea3af87c	\N	f	1	\N	\N	\N
bab81734-46a0-4518-8027-1134e82f3192	bearer	2037-02-17 17:43:56.925	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:28:37.926	2017-02-17 21:28:37.926	7ae782f285d4d938c43c85528cfaf229	1390	\N	bbdc0c18-57eb-4831-937b-d65abe678267	\N	f	1	\N	\N	\N
37a1d0cd-4f11-4505-b4ae-508d61a1751a	bearer	2037-02-17 17:38:51.33	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/read-limited /activities/update	orcid	2017-02-17 21:23:32.338	2017-02-17 21:23:32.338	9b60ebaa0c8d0fc73ae084d0a3ce25ec	1365	\N	a2c10d1d-596d-468d-8a36-7376061c0c7d	t	t	1	\N	\N	\N
beb04162-4fa3-4687-bb56-82fc996e1489	bearer	2037-02-17 17:39:25.237	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update /affiliations/read-limited	orcid	2017-02-17 21:24:06.244	2017-02-17 21:24:06.244	906af268b7598ffd07ff23470c49bcd2	1366	\N	7231341f-b74b-4197-a11c-030d9275ec50	t	t	1	\N	\N	\N
37eaf13c-8148-4fbe-90ac-9621f4957a41	bearer	2037-02-17 17:39:29.804	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update /funding/read-limited	orcid	2017-02-17 21:24:10.868	2017-02-17 21:24:10.868	9562e716c33ea1ff51decac39b44a3d8	1367	\N	82ac5954-4bdb-4541-973a-c0c63cff68fb	t	t	1	\N	\N	\N
5087b752-97f3-46dd-ab55-706400823397	bearer	2037-02-17 17:39:35.826	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited /activities/update	orcid	2017-02-17 21:24:16.836	2017-02-17 21:24:16.836	8f4bb4c14da23b3e0e0858736155654f	1368	\N	26861c4e-a5ca-4c66-8678-86caa7d2914a	t	t	1	\N	\N	\N
6bc1e7a1-30f8-45ec-8d58-bb7b96fafb8f	bearer	2017-02-17 22:25:50.925	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited /activities/update	orcid	2017-02-17 21:25:50.931	2017-02-17 21:25:50.931	8f4bb4c14da23b3e0e0858736155654f	1381	\N	237729f0-633e-428d-9fc8-9ea58756c992	t	f	1	\N	\N	\N
15a5fd89-5aed-40e7-a159-8928d26eed57	bearer	2037-02-17 17:39:44.835	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/update	orcid	2017-02-17 21:24:25.844	2017-02-17 21:24:25.844	9d26f627b8846ec45287788770373b7e	1370	\N	4a646675-5775-4a8f-9ec1-c98b1efc013f	t	t	1	\N	\N	\N
7a08e552-3d54-439e-910b-cd0b0bf88782	bearer	2037-02-17 17:43:57.037	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:28:38.037	2017-02-17 21:28:38.037	7ae782f285d4d938c43c85528cfaf229	1391	\N	1ea9879b-53ce-4cb4-8fd3-2f6fbc01e350	\N	f	1	\N	\N	\N
7d2e50f4-b2f7-4215-98be-6120cfeb154f	bearer	2037-02-17 17:44:04.012	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:28:45.013	2017-02-17 21:28:45.012	7fb1b415f5231d2280fa57cfb5053d5e	1392	\N	63ac3138-1037-4788-8153-2316a35823fa	\N	f	1	\N	\N	\N
29b4a048-2fa9-495b-8f90-e1a4741973a1	bearer	2037-02-17 17:45:24.372	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:30:05.373	2017-02-17 21:30:05.373	7fb1b415f5231d2280fa57cfb5053d5e	1396	\N	4eca0bf6-265e-4a24-b55f-7fba5d12403d	\N	f	1	\N	\N	\N
9e82ba3a-14d6-43d6-b209-ae0fc7aec346	bearer	2037-02-17 17:47:27.585	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:32:08.586	2017-02-17 21:32:08.586	7fb1b415f5231d2280fa57cfb5053d5e	1420	\N	d2b6387b-3809-4075-8e83-9b4c012dbd20	\N	f	1	\N	\N	\N
007c7474-7b9e-49c3-a330-f7d42cda10ae	bearer	2037-02-17 17:47:38.271	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:32:19.272	2017-02-17 21:32:19.272	7fb1b415f5231d2280fa57cfb5053d5e	1422	\N	b655dbe4-f52b-40fc-a14c-cf294b95aad7	\N	f	1	\N	\N	\N
6fe2dfd3-fb1f-409e-bfbd-794810a71772	bearer	2037-02-17 17:47:39.062	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:32:20.062	2017-02-17 21:32:20.062	7fb1b415f5231d2280fa57cfb5053d5e	1423	\N	25dcf759-20b0-4947-9a0f-865db6fe3c5a	\N	f	1	\N	\N	\N
79bbdd4c-40d5-428a-a937-eedc31d90776	bearer	2037-02-17 17:47:41.097	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:32:22.098	2017-02-17 21:32:22.098	7ae782f285d4d938c43c85528cfaf229	1426	\N	2501ca79-5353-4996-a89f-6edd75479649	\N	f	1	\N	\N	\N
dfae73b3-7a18-4264-9f75-d2ee15643f70	bearer	2037-02-17 17:47:41.274	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:32:22.275	2017-02-17 21:32:22.275	7ae782f285d4d938c43c85528cfaf229	1427	\N	41050a7b-ec51-4925-bbe0-ef4d32d2b5e1	\N	f	1	\N	\N	\N
8ac7d11b-49fc-4e30-80a3-0ed653536137	bearer	2037-02-17 17:49:08.828	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:33:49.83	2017-02-17 21:33:49.83	7fb1b415f5231d2280fa57cfb5053d5e	1434	\N	0aa39fc7-c7e6-4688-b918-3ef2b12a9dcb	\N	f	1	\N	\N	\N
05da7628-aedb-4472-b964-edd116e98d82	bearer	2037-02-17 17:49:24.442	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:34:05.443	2017-02-17 21:34:05.443	7ae782f285d4d938c43c85528cfaf229	1440	\N	7832669b-2286-4d5f-a4d2-9f262e582b5f	\N	f	1	\N	\N	\N
a2960c48-61c6-4398-8ab4-f8a3f63eba9b	bearer	2037-02-17 17:49:24.58	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:34:05.58	2017-02-17 21:34:05.58	7ae782f285d4d938c43c85528cfaf229	1441	\N	5a5206a7-0053-441d-8fc1-ac3d6fc479f8	\N	f	1	\N	\N	\N
6c220f4c-2c28-4c4c-9b31-f4d705211033	bearer	2037-02-17 17:49:24.724	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:34:05.725	2017-02-17 21:34:05.725	7ae782f285d4d938c43c85528cfaf229	1443	\N	8e97efb5-94c0-4e7d-b31d-3bc981eef10d	\N	f	1	\N	\N	\N
c0293c1f-77f7-4caa-93a6-214d7d33a0bb	bearer	2037-02-17 17:52:36.82	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:17.821	2017-02-17 21:37:17.821	3903ba3ee40c69281e6a7bce61453a28	1446	\N	263371e0-3b21-4465-aed3-0a607103ed00	\N	f	1	\N	\N	\N
ce45d945-eaa2-40b0-9a51-789587023979	bearer	2037-02-17 17:52:40.057	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:21.057	2017-02-17 21:37:21.057	3903ba3ee40c69281e6a7bce61453a28	1449	\N	a58cc857-437c-4959-a0da-a400ec2f4c96	\N	f	1	\N	\N	\N
83757ff0-aaca-499d-a0b6-1e35e5f95f79	bearer	2037-02-17 17:52:40.139	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:21.139	2017-02-17 21:37:21.139	3903ba3ee40c69281e6a7bce61453a28	1450	\N	33922959-f0e5-4ef3-be5d-0f91f565362f	\N	f	1	\N	\N	\N
da73f2b3-49da-450d-ab01-9f60c3a12fc4	bearer	2037-02-17 17:52:46.009	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:27.01	2017-02-17 21:37:27.01	3903ba3ee40c69281e6a7bce61453a28	1456	\N	607a6d3d-d8f3-4bf6-924a-e9b291122b14	\N	f	1	\N	\N	\N
f1b83fa7-5ed2-49bb-8447-c6886b382e36	bearer	2037-02-17 17:44:08.064	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:28:49.065	2017-02-17 21:28:49.065	7fb1b415f5231d2280fa57cfb5053d5e	1393	\N	76dba266-1ddd-466b-a539-e38b27651fd4	\N	f	1	\N	\N	\N
0943d068-2ecd-4ac4-913a-c916aff0639d	bearer	2037-02-17 17:44:45.064	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:29:26.065	2017-02-17 21:29:26.065	7fb1b415f5231d2280fa57cfb5053d5e	1394	\N	17922765-2f82-4346-9f07-fbf3305555cf	\N	f	1	\N	\N	\N
135c0bd3-71b8-41d3-a6e1-55070e80e742	bearer	2037-02-17 17:45:20.443	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:30:01.444	2017-02-17 21:30:01.444	7fb1b415f5231d2280fa57cfb5053d5e	1395	\N	b14fd59b-d484-4eda-b583-73c47b59bbc9	\N	f	1	\N	\N	\N
6e61670e-e563-4058-aa6a-2694326c1406	bearer	2037-02-17 17:45:34.078	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:30:15.079	2017-02-17 21:30:15.079	7ae782f285d4d938c43c85528cfaf229	1397	\N	6f91559e-0f04-4218-8f7b-9c80ff5a5dd5	\N	f	1	\N	\N	\N
e4068c1b-a419-4c37-b570-62e1462ec422	bearer	2037-02-17 17:45:34.116	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:30:15.116	2017-02-17 21:30:15.116	7ae782f285d4d938c43c85528cfaf229	1398	\N	f57522a8-d68b-4312-af3d-0fb51ccf9c37	\N	f	1	\N	\N	\N
1b6d03a0-2cae-4ba2-98b0-aaa1d7f549f7	bearer	2037-02-17 17:45:34.452	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:30:15.452	2017-02-17 21:30:15.452	7ae782f285d4d938c43c85528cfaf229	1401	\N	929f13c4-580b-4fd4-b15f-26eb9d3f4ce7	\N	f	1	\N	\N	\N
a9de7b19-a607-4f3c-a732-9ac92f76fb15	bearer	2037-02-17 17:45:34.595	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:30:15.596	2017-02-17 21:30:15.596	7ae782f285d4d938c43c85528cfaf229	1402	\N	b907c6bb-04a1-46c3-801a-f07c490de716	\N	f	1	\N	\N	\N
2d83ac34-755e-4e77-a84e-621a2fda756a	bearer	2037-02-17 17:45:34.714	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:30:15.714	2017-02-17 21:30:15.714	7ae782f285d4d938c43c85528cfaf229	1403	\N	7ecbb61a-9eff-47f8-a313-0e9f98549d63	\N	f	1	\N	\N	\N
2a33e762-a0b7-403c-be78-3389c8c2d7a8	bearer	2017-02-17 22:30:19.354	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited	orcid	2017-02-17 21:30:19.359	2017-02-17 21:30:19.359	0a0e67a368170de6a22fa6869d56af96	1405	\N	5f9c0697-6832-4d31-bf2f-8a5bfcb2acc8	\N	f	1	\N	\N	\N
f4d67565-4815-4c7b-9759-64b143e81d3d	bearer	2037-02-17 17:47:03.305	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:31:44.305	2017-02-17 21:31:44.305	7fb1b415f5231d2280fa57cfb5053d5e	1410	\N	4e15063a-7822-4f09-ac32-297c2b36b6ce	\N	f	1	\N	\N	\N
ab52a2ac-fbd5-433b-8a18-681ffbfaeb49	bearer	2037-02-17 17:47:10.31	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:31:51.31	2017-02-17 21:31:51.31	7ae782f285d4d938c43c85528cfaf229	1411	\N	c7f1815a-7fe1-4245-aa6e-f1c0c2ef7532	\N	f	1	\N	\N	\N
7e990b65-c6c1-43e6-b42a-bc3928239d82	bearer	2037-02-17 17:47:10.433	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:31:51.434	2017-02-17 21:31:51.434	7ae782f285d4d938c43c85528cfaf229	1413	\N	281986aa-8764-4147-b2db-01cbe50960f4	\N	f	1	\N	\N	\N
184d61c6-0fc4-4514-9157-1857d5403e0d	bearer	2037-02-17 17:47:10.582	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:31:51.582	2017-02-17 21:31:51.582	7ae782f285d4d938c43c85528cfaf229	1414	\N	e77526c6-5b39-40fb-bbbf-f81a03f161ad	\N	f	1	\N	\N	\N
29a55cc5-83e4-42e5-a8cd-2b75ee0a0b80	bearer	2037-02-17 17:47:10.904	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:31:51.905	2017-02-17 21:31:51.905	7ae782f285d4d938c43c85528cfaf229	1417	\N	42e6c52a-5c52-42f4-8c65-929a568b887f	\N	f	1	\N	\N	\N
0934d916-dd12-479f-92bc-a5fdd9683507	bearer	2037-02-17 17:47:20.577	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:32:01.578	2017-02-17 21:32:01.578	7fb1b415f5231d2280fa57cfb5053d5e	1419	\N	f75cc360-c2cf-4bdd-80b8-a35d689e0dcc	\N	f	1	\N	\N	\N
0e0c4077-0a8b-4b8a-a61b-aae64007916e	bearer	2037-02-17 17:47:40.991	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:32:21.991	2017-02-17 21:32:21.991	7ae782f285d4d938c43c85528cfaf229	1424	\N	ce94e6db-d4a2-442c-aa94-8ed5127ea433	\N	f	1	\N	\N	\N
d43dc704-6a9c-4596-8fb7-98f3a4ed6b38	bearer	2037-02-17 17:47:41.024	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:32:22.024	2017-02-17 21:32:22.024	7ae782f285d4d938c43c85528cfaf229	1425	\N	d5488a7a-86ef-4e46-a6a1-cf38b4dd5e4f	\N	f	1	\N	\N	\N
da176ca3-3ce0-4147-b227-4657c309a3f9	bearer	2037-02-17 17:47:41.329	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:32:22.329	2017-02-17 21:32:22.329	7ae782f285d4d938c43c85528cfaf229	1428	\N	9815b6d7-e28a-49a0-88ae-255d9869525c	\N	f	1	\N	\N	\N
2f72fdce-c5aa-4ff3-9366-b55176ce95c0	bearer	2037-02-17 17:47:41.422	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:32:22.422	2017-02-17 21:32:22.422	7ae782f285d4d938c43c85528cfaf229	1429	\N	ee8cad2f-5efe-4b78-a2d2-4d7135ee9571	\N	f	1	\N	\N	\N
7d264dfe-9ded-4633-944d-3a46fae670e6	bearer	2037-02-17 17:47:41.503	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:32:22.503	2017-02-17 21:32:22.503	7ae782f285d4d938c43c85528cfaf229	1430	\N	b94b3204-1bd6-41fe-9acc-c0b3134162fc	\N	f	1	\N	\N	\N
7076afe2-0cee-4f72-b3cf-b30f67546c4e	bearer	2037-02-17 17:47:41.609	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:32:22.61	2017-02-17 21:32:22.61	7ae782f285d4d938c43c85528cfaf229	1431	\N	88ac3ce4-4bbd-4223-a7ca-660bd986c149	\N	f	1	\N	\N	\N
c12d6ba6-7bf8-479f-8e3b-bd98148b3995	bearer	2037-02-17 17:47:52.21	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:32:33.211	2017-02-17 21:32:33.211	7fb1b415f5231d2280fa57cfb5053d5e	1432	\N	740b7828-292d-4d71-a268-c990738930c2	\N	f	1	\N	\N	\N
3d2a1287-90de-4a4a-8595-779725e1a799	bearer	2037-02-17 17:52:45.853	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:26.853	2017-02-17 21:37:26.853	3903ba3ee40c69281e6a7bce61453a28	1455	\N	4eeddc05-84d5-4f07-b06b-f6b0eff4c5aa	\N	f	1	\N	\N	\N
2f837206-4cf6-4a91-8162-ee4b9cfa8785	bearer	2037-02-17 17:52:46.16	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:27.16	2017-02-17 21:37:27.16	3903ba3ee40c69281e6a7bce61453a28	1457	\N	89f812ca-ff1e-4274-8e41-33317ec78b7d	\N	f	1	\N	\N	\N
ce098cff-41bb-441d-8fa4-49cd19fb1e61	bearer	2037-02-17 17:52:46.23	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:27.231	2017-02-17 21:37:27.231	3903ba3ee40c69281e6a7bce61453a28	1458	\N	c7d83f52-da98-4125-a0c6-24b6c6fcd153	\N	f	1	\N	\N	\N
478ac73b-fc62-4e0b-b1f5-06551cde888a	bearer	2037-02-17 17:52:46.545	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:27.545	2017-02-17 21:37:27.545	3903ba3ee40c69281e6a7bce61453a28	1459	\N	72060522-0378-4073-8a8d-ac6e7aaf677e	\N	f	1	\N	\N	\N
55e495fb-289e-4d0c-8620-47c0017140e6	bearer	2037-02-17 17:45:34.226	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:30:15.228	2017-02-17 21:30:15.228	7ae782f285d4d938c43c85528cfaf229	1399	\N	3921ca98-3ad7-4096-a5a1-2bb324ac72f3	\N	f	1	\N	\N	\N
50c4ba69-0aa7-453d-aadf-52dca61c3a06	bearer	2037-02-17 17:45:34.375	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:30:15.376	2017-02-17 21:30:15.376	7ae782f285d4d938c43c85528cfaf229	1400	\N	c07302b6-9697-4181-aad9-5b6b0816e319	\N	f	1	\N	\N	\N
0461b46f-f6d5-477e-861d-c36ed95affcc	bearer	2037-02-17 17:45:34.772	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:30:15.772	2017-02-17 21:30:15.772	7ae782f285d4d938c43c85528cfaf229	1404	\N	8b6f6209-fe5e-4ed7-a355-15368104f71c	\N	f	1	\N	\N	\N
b910d17a-a109-4f41-b820-9837ac14981b	bearer	2037-02-17 17:45:53.184	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:30:34.185	2017-02-17 21:30:34.185	7fb1b415f5231d2280fa57cfb5053d5e	1407	\N	bf0ab910-a0df-4580-b2b2-8fb391103ea2	\N	f	1	\N	\N	\N
4128d6e0-daab-43ef-8be8-1e4a793eaf85	bearer	2037-02-17 17:46:56.595	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:31:37.596	2017-02-17 21:31:37.596	7fb1b415f5231d2280fa57cfb5053d5e	1409	\N	1a1aa192-56f5-4d13-bff8-15b2691d653a	\N	f	1	\N	\N	\N
561289ce-3253-4d22-8eeb-6a854108da21	bearer	2037-02-17 17:47:10.346	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:31:51.347	2017-02-17 21:31:51.347	7ae782f285d4d938c43c85528cfaf229	1412	\N	b19bb3a1-fe5e-4bc0-8e4f-b79ad91c87d1	\N	f	1	\N	\N	\N
7d7864ad-e71b-471a-97d7-e1d8e013ae44	bearer	2037-02-17 17:47:10.648	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:31:51.649	2017-02-17 21:31:51.649	7ae782f285d4d938c43c85528cfaf229	1415	\N	96c3351e-4101-4e2c-bc21-960cf5b35c51	\N	f	1	\N	\N	\N
363d675e-86ab-436d-8a35-5928a424ee80	bearer	2037-02-17 17:47:10.761	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:31:51.762	2017-02-17 21:31:51.762	7ae782f285d4d938c43c85528cfaf229	1416	\N	4e188aa7-7ea2-4027-aec6-ecad73484e2e	\N	f	1	\N	\N	\N
36eb8c43-d6c1-44fb-8066-b44572761096	bearer	2037-02-17 17:47:10.96	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:31:51.961	2017-02-17 21:31:51.961	7ae782f285d4d938c43c85528cfaf229	1418	\N	2be862be-1a6e-462c-b1c1-8b6256c67072	\N	f	1	\N	\N	\N
87d6f537-a542-4bd2-b524-eb8f591c341e	bearer	2037-02-17 17:52:48.695	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:29.695	2017-02-17 21:37:29.695	3903ba3ee40c69281e6a7bce61453a28	1460	\N	6b75b4b2-cddc-482f-90c9-d199bfd2f786	\N	f	1	\N	\N	\N
9cb0d982-1b6c-4edd-9457-f21034c1921c	bearer	2037-02-17 17:45:45.806	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:30:26.807	2017-02-17 21:30:26.807	7fb1b415f5231d2280fa57cfb5053d5e	1406	\N	4d295800-f09f-4d1a-a740-c4acbadd3ee1	\N	f	1	\N	\N	\N
4dbeb881-d708-4021-b2a3-6ee9858bca56	bearer	2037-02-17 17:46:18.88	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:30:59.88	2017-02-17 21:30:59.88	7fb1b415f5231d2280fa57cfb5053d5e	1408	\N	09912ec9-56cb-49f4-9044-ec62bb79bba0	\N	f	1	\N	\N	\N
1b9736a2-42bd-431c-bb7f-20350fc7e718	bearer	2037-02-17 17:47:30.782	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:32:11.783	2017-02-17 21:32:11.783	7fb1b415f5231d2280fa57cfb5053d5e	1421	\N	65ee93a6-3803-4cf8-b70f-4b4aa35b4c15	\N	f	1	\N	\N	\N
5f4ddedf-0da0-4a8f-9e59-74d4188667b8	bearer	2037-02-17 17:47:59.896	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:32:40.896	2017-02-17 21:32:40.896	7fb1b415f5231d2280fa57cfb5053d5e	1433	\N	94241e26-d82e-4ebb-9bb5-c407e665bbc9	\N	f	1	\N	\N	\N
d02094fd-7636-4045-8f42-2326caf9a399	bearer	2037-02-17 17:49:16.053	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:33:57.053	2017-02-17 21:33:57.053	7fb1b415f5231d2280fa57cfb5053d5e	1435	\N	f2fd64f3-1d08-4626-bc3f-de6d224b6521	\N	f	1	\N	\N	\N
9e1ab6ed-0f5b-49e2-a17c-69cee4d680fb	bearer	2037-02-17 17:49:24.104	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:34:05.104	2017-02-17 21:34:05.104	7ae782f285d4d938c43c85528cfaf229	1436	\N	a25a0cef-d741-433e-800e-b83caf3fd204	\N	f	1	\N	\N	\N
6a893ed1-eb9d-4b91-b50f-e98a0653e9a7	bearer	2037-02-17 17:49:24.134	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:34:05.134	2017-02-17 21:34:05.134	7ae782f285d4d938c43c85528cfaf229	1437	\N	804b686a-62d2-4a36-97bf-1c6248ee6506	\N	f	1	\N	\N	\N
9edd58b5-46bb-494b-bf11-1126bbdf2f6d	bearer	2037-02-17 17:49:24.215	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:34:05.215	2017-02-17 21:34:05.215	7ae782f285d4d938c43c85528cfaf229	1438	\N	ea44ac27-f1c8-4ce5-8bc8-64790194404b	\N	f	1	\N	\N	\N
56ecc545-cbdc-454a-8487-642216e9c683	bearer	2037-02-17 17:49:24.396	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:34:05.397	2017-02-17 21:34:05.397	7ae782f285d4d938c43c85528cfaf229	1439	\N	83c783af-069d-48e5-9386-9df99be072d2	\N	f	1	\N	\N	\N
8088014e-3796-4f61-91a2-618b47aca0e8	bearer	2037-02-17 17:49:24.671	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-02-17 21:34:05.672	2017-02-17 21:34:05.672	7ae782f285d4d938c43c85528cfaf229	1442	\N	4e45edf1-6450-47e3-8839-28de1ec5c9e7	\N	f	1	\N	\N	\N
7db45b16-4512-4b29-89f3-ed435cc0072e	bearer	2037-02-17 17:49:36.533	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-02-17 21:34:17.535	2017-02-17 21:34:17.535	7fb1b415f5231d2280fa57cfb5053d5e	1444	\N	85bbdb92-54ce-4a72-97a0-dd8571fc33e5	\N	f	1	\N	\N	\N
49403a0b-1de7-41de-9698-026a7e0b127b	bearer	2017-02-17 22:34:41.365	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited /person/update	orcid	2017-02-17 21:34:41.369	2017-02-17 21:34:41.369	1de735e9a8b9c85bd130173dc43bea30	1445	\N	36a64a85-5eb6-48a4-896f-2b22fcd7b79b	\N	f	1	\N	\N	\N
093b8f01-c94d-4e9d-94b9-e2d14b6437ee	bearer	2037-02-17 17:52:36.906	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:17.907	2017-02-17 21:37:17.907	3903ba3ee40c69281e6a7bce61453a28	1447	\N	6e37cb77-1bc1-4d79-a985-a9479819b178	\N	f	1	\N	\N	\N
6f950559-73fd-49f9-8cc4-baeaa04fc2dc	bearer	2037-02-17 17:52:39.398	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:20.399	2017-02-17 21:37:20.399	3903ba3ee40c69281e6a7bce61453a28	1448	\N	bd048dd4-3bc8-4e38-bd90-675028fac908	\N	f	1	\N	\N	\N
1a278d11-82c1-4b3f-8847-efe313076cb0	bearer	2037-02-17 17:52:43.132	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:24.132	2017-02-17 21:37:24.132	3903ba3ee40c69281e6a7bce61453a28	1451	\N	1b6d447b-fd6c-4702-9622-9ded0f21fdc1	\N	f	1	\N	\N	\N
beb0d429-53b2-4efa-81b2-410c000e0471	bearer	2037-02-17 17:52:43.365	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:24.366	2017-02-17 21:37:24.366	3903ba3ee40c69281e6a7bce61453a28	1452	\N	f7f5165d-4ccd-4ac7-916f-6b9c3e00edc4	\N	f	1	\N	\N	\N
76666c48-a86a-4c1a-95a4-7be96e6eaf67	bearer	2037-02-17 17:52:43.431	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:24.431	2017-02-17 21:37:24.431	3903ba3ee40c69281e6a7bce61453a28	1453	\N	79a27e97-386e-4788-b013-b52c8ea5ef4e	\N	f	1	\N	\N	\N
9542b002-0c1e-4d8a-b3ed-ac9cddca305f	bearer	2037-02-17 17:52:45.632	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:37:26.632	2017-02-17 21:37:26.632	3903ba3ee40c69281e6a7bce61453a28	1454	\N	e4293c03-af8c-4f2e-a447-7486647a4391	\N	f	1	\N	\N	\N
1139dd18-3e5b-4221-b50b-4490812e5eee	bearer	2017-02-17 22:39:00.293	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/external-identifiers/create	orcid	2017-02-17 21:39:00.299	2017-02-17 21:39:00.299	e9277db1e22ce8058f356ef32c679960	1461	\N	b9f4843b-96b8-4288-9079-ae8f74551158	\N	f	1	\N	\N	\N
ab0f4064-8167-4c20-b29c-66c77b50d5b8	bearer	2017-02-17 22:39:10.663	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/read-limited	orcid	2017-02-17 21:39:10.668	2017-02-17 21:39:10.668	7e790f9d6e2730f661de1883756a4557	1462	\N	daead70b-cadc-468f-a007-f70f9e4a1a6c	\N	f	1	\N	\N	\N
94750b69-94d2-4847-bf1c-361ca6095513	bearer	2017-02-17 22:39:42.859	9999-0000-0000-0004	APP-9999999999999902	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/read-limited /person/update	orcid	2017-02-17 21:39:42.864	2017-02-17 21:39:42.864	86f7d51d31b9407083116e6d717891d1	1463	\N	3bd97400-221d-4e8b-8b46-b6153929db0b	\N	f	1	\N	\N	\N
89bcb837-aa6e-4a70-8dd9-48dbe55a9c6d	bearer	2017-02-17 22:42:21.357	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/read-limited /person/update	orcid	2017-02-17 21:42:21.361	2017-02-17 21:42:21.361	2e5edc799dcbc77dedda8214132e4ee5	1464	\N	6608cf4e-1cca-4b86-a005-efaa3dcee287	\N	f	1	\N	\N	\N
221b1d37-e804-43cb-ae7a-cba00b04eff7	bearer	2017-02-17 22:42:26.456	9999-0000-0000-0004	APP-9999999999999902	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/update	orcid	2017-02-17 21:42:26.46	2017-02-17 21:42:26.46	6e5d0cb3aee93c39242009b980e878ac	1465	\N	c39bf2d5-4f77-4ba8-80f2-adddb0fd7174	\N	f	1	\N	\N	\N
b60c67b0-c9b7-44e5-a3cf-9ef45b31e7d3	bearer	2017-02-17 22:44:26.184	9999-0000-0000-0005	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/create	orcid	2017-02-17 21:44:26.187	2017-02-17 21:44:26.187	523e41d1878164a96ebbb0e660ca67d6	1467	\N	8b9ab045-d4e1-4dc6-9c32-82af9660a016	\N	f	1	\N	\N	\N
d31f85e5-92b2-4c30-be50-feca6b7695b5	bearer	2017-02-17 22:50:37.599	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/read-limited /activities/update /person/read-limited /person/update	orcid	2017-02-17 21:50:37.605	2017-02-17 21:50:37.605	1996962dd2ca7e68e5fa85b765f5511c	1468	\N	f065252b-d65e-4275-9894-5e5cdf2a8449	\N	f	1	\N	\N	\N
28a391b1-71a4-4d90-b66a-2dc94cb8ce57	bearer	2037-02-17 18:05:56.623	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-02-17 21:50:37.623	2017-02-17 21:50:37.623	3903ba3ee40c69281e6a7bce61453a28	1469	\N	67dc9669-5913-4ba6-b55a-430b91c53b64	\N	f	1	\N	\N	\N
5f65d4e2-0ac9-41b4-a791-06c4e6eb639e	bearer	2037-06-13 12:22:14.593	\N	APP-9999999999999901	t	\N		\N	/read-public	orcid	2017-06-13 16:06:55.678	2017-06-13 16:06:55.678	165a3ec304597c3dd5b7880503a1958c	1470	\N	3ac2be8b-4c63-40a4-8c5b-4484e3e6c60f	\N	f	1	\N	\N	\N
ea9d4446-f6d0-42c7-80f8-0022338326c6	bearer	2037-06-13 12:23:09.842	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:07:50.844	2017-06-13 16:07:50.844	276069c4d3be949258d185c0e1701278	1471	\N	56e2ce4c-350b-4333-870b-25290aa4e7e9	\N	f	1	\N	\N	\N
86d5ba97-8257-421b-8f56-a9a6ab51424e	bearer	2037-06-13 12:24:23.088	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/create	orcid	2017-06-13 16:09:04.149	2017-06-13 16:09:04.149	b3a39107debe4fa63ea7b671d5a9b94f	1475	\N	e2c053b8-906f-4a34-894e-3d3fe26a75f0	t	t	1	\N	\N	\N
1867556a-255e-477d-8754-d0fa146d8d77	bearer	2037-02-17 17:58:39.665	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/create	orcid	2017-02-17 21:43:20.669	2017-02-17 21:43:20.669	b3a39107debe4fa63ea7b671d5a9b94f	1466	\N	2153b7a7-9746-4118-bd59-1af7c1cf21dc	t	t	1	\N	\N	\N
5b7b02c4-efe9-495a-b692-7adeefc59aca	bearer	2037-06-13 12:23:51.029	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/update	orcid	2017-06-13 16:08:32.093	2017-06-13 16:08:32.093	fad621ce48150605d4475825fd56fc8e	1474	\N	df4b6369-3763-477d-aea9-f33efc216757	t	t	1	\N	\N	\N
60850088-767b-46c8-9570-2fc2f2b5cf50	bearer	2037-06-13 12:23:18.998	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/affiliations/create	orcid	2017-06-13 16:08:00.01	2017-06-13 16:08:00.01	8d85c644fbd4e520f1869b9fe3cdc941	1473	\N	0e092581-758b-400d-b587-1fdd7af205d5	t	t	1	\N	\N	\N
f9f55fa1-0b19-4222-9565-bd405fc494b9	bearer	2037-06-13 12:23:15.406	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/funding/create	orcid	2017-06-13 16:07:56.419	2017-06-13 16:07:56.419	aee8da68d76b954cba9eae9a2276b328	1472	\N	d408a1c1-3903-46bf-af32-58e2fe7e86cc	t	t	1	\N	\N	\N
5376125d-77b3-43fd-86fd-29ea47ad1b4f	bearer	2017-02-17 22:24:45.202	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/funding/create	orcid	2017-02-17 21:24:45.208	2017-02-17 21:24:45.208	aee8da68d76b954cba9eae9a2276b328	1374	\N	7c33c28a-7996-4097-b755-6a901329c8cd	t	f	1	\N	\N	\N
80d4cbc2-e45f-4021-b77d-a005ac13746f	bearer	2037-02-17 17:38:44.877	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/read-limited /person/update	orcid	2017-02-17 21:23:25.886	2017-02-17 21:23:25.886	25a972c7561ef6e6862c1b11d5f9e513	1364	\N	d16c3564-a787-4905-b84b-07bf08f5a3c4	t	t	1	\N	\N	\N
d011fe1a-eb9b-4ad4-8d76-2934bbaf9db4	bearer	2017-06-13 17:10:13.805	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/external-identifiers/create	orcid	2017-06-13 16:10:13.814	2017-06-13 16:10:13.814	e9277db1e22ce8058f356ef32c679960	1476	\N	6667d8e1-0c0a-4068-a06a-12172f706255	\N	f	1	\N	\N	\N
f20f989e-5663-46f6-8ead-1c4132f42905	bearer	2037-06-13 12:26:10.394	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/update	orcid	2017-06-13 16:10:51.444	2017-06-13 16:10:51.444	9d26f627b8846ec45287788770373b7e	1477	\N	a0e32409-a4ff-4dff-9e74-5c92b7f889b9	\N	t	1	\N	\N	\N
5e5e6946-20d3-4c5a-8055-3632165b2756	bearer	2037-06-13 12:26:15.285	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/update	orcid	2017-06-13 16:10:56.293	2017-06-13 16:10:56.293	9d26f627b8846ec45287788770373b7e	1478	\N	a2db41de-1543-4575-9ac8-805c945546db	\N	t	1	\N	\N	\N
25492d00-5082-4c32-992a-08c82348b833	bearer	2037-06-13 12:28:03.676	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:12:44.677	2017-06-13 16:12:44.677	276069c4d3be949258d185c0e1701278	1485	\N	6df3014f-4bbe-4d81-b394-175d66733e42	\N	f	1	\N	\N	\N
34aa3fc5-611e-4e56-bd0d-c9001e2bc929	bearer	2037-06-13 12:28:03.856	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:12:44.857	2017-06-13 16:12:44.857	276069c4d3be949258d185c0e1701278	1487	\N	aa11d5bd-54bd-417d-8dfc-cb0bffe0a679	\N	f	1	\N	\N	\N
d9547d97-d44b-481c-9f79-36901f51b83c	bearer	2037-06-13 12:28:30.115	\N	APP-9999999999999901	t	\N		\N	/read-public	orcid	2017-06-13 16:13:11.116	2017-06-13 16:13:11.116	165a3ec304597c3dd5b7880503a1958c	1489	\N	97ecd8fc-be96-4c0b-bb43-d20d4cb9dd70	\N	f	1	\N	\N	\N
0501aa52-4855-4d0d-92b7-544c4dd3df11	bearer	2037-06-13 12:29:04.486	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-06-13 16:13:45.563	2017-06-13 16:13:45.563	0bda87e38e59d17fc1cadc1bbccdfd1b	1492	\N	2bb2534f-e9ec-4469-a845-64f8d3ed8869	f	t	1	\N	\N	\N
287985ad-d891-4711-8d38-940272a55b25	bearer	2037-06-13 12:29:04.486	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-06-13 16:13:45.493	2017-06-13 16:13:45.493	0bda87e38e59d17fc1cadc1bbccdfd1b	1491	\N	f482db5f-9c0d-4b27-82a3-1195bf5f5c57	t	t	1	\N	\N	\N
2e50b4c9-9691-4861-99de-f8b0af3fe0a5	bearer	2037-06-13 12:29:36.783	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/update	orcid	2017-06-13 16:14:17.789	2017-06-13 16:14:17.789	257a8a1c2371db71629b27aa8d47f7e1	1493	\N	e232b89f-c53b-4b1b-990b-39f8df8f39c4	t	t	1	\N	\N	\N
2d126ee5-3853-4aa4-a7aa-0849520c8e49	bearer	2017-06-13 17:14:50.317	9999-0000-0000-0005	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/authenticate /funding/create /orcid-bio/update /orcid-bio/read-limited /affiliations/update /affiliations/create /orcid-bio/external-identifiers/create /peer-review/read-limited /orcid-works/update /orcid-profile/read-limited /funding/update /activities/read-limited /orcid-works/create /orcid-works/read-limited /peer-review/create /activities/update /funding/read-limited /affiliations/read-limited	orcid	2017-06-13 16:14:50.326	2017-06-13 16:14:50.326	51ad6d3a42e4cc249c906904d191f048	1495	\N	8a31f120-735e-4191-a1ff-b6ab588e3cc9	\N	f	1	\N	\N	\N
255bd2fd-1b05-459f-96d5-5da05a8e9d1f	bearer	2017-06-13 17:15:22.34	9999-0000-0000-0005	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/authenticate /funding/create /orcid-bio/update /orcid-bio/read-limited /affiliations/update /affiliations/create /orcid-bio/external-identifiers/create /peer-review/read-limited /orcid-works/update /orcid-profile/read-limited /funding/update /activities/read-limited /orcid-works/create /orcid-works/read-limited /peer-review/create /activities/update /funding/read-limited /affiliations/read-limited	orcid	2017-06-13 16:15:22.348	2017-06-13 16:15:22.348	51ad6d3a42e4cc249c906904d191f048	1496	\N	4bae1868-4c15-4112-96af-9d5eef5e3438	\N	f	1	\N	\N	\N
a36a7008-70d3-4836-9bf1-060f24cb1654	bearer	2037-06-13 12:31:45.491	9999-0000-0000-0004	APP-9999999999999903	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/authenticate	orcid	2017-06-13 16:16:26.493	2017-06-13 16:16:26.493	8f8c14436439216e305452a23b785553	1497	\N	1265a9af-4dae-4b67-855b-55b8fbbc9bc3	\N	t	1	\N	\N	\N
5ea7f50f-ee9d-4f2f-a0ed-b9e494039121	bearer	2037-06-13 12:32:26.491	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/read-limited /person/update	orcid	2017-06-13 16:17:07.498	2017-06-13 16:17:07.498	25a972c7561ef6e6862c1b11d5f9e513	1499	\N	1ee3eeba-d428-4b49-b4fa-e295558f56f3	\N	t	1	\N	\N	\N
9ade68ac-ec03-42b5-a349-79d72bae99c0	bearer	2037-06-13 12:34:09.357	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update /funding/read-limited	orcid	2017-06-13 16:18:50.362	2017-06-13 16:18:50.362	9562e716c33ea1ff51decac39b44a3d8	1502	\N	358ff98a-fec4-4264-899d-72b6ebb99bcf	\N	t	1	\N	\N	\N
02a97e7f-2a38-4805-9d0c-b7c5c3fe3286	bearer	2037-06-13 12:34:48.169	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/read-limited /activities/update	orcid	2017-06-13 16:19:29.174	2017-06-13 16:19:29.174	e3714e3172f789b56ced4c9de7630831	1503	\N	2195c0db-dc57-4469-84a8-6f5ccfb2d6e2	\N	t	1	\N	\N	\N
a54ecbeb-e537-4d7c-b919-a26db5eaec9d	bearer	2017-06-13 17:20:01.413	9999-0000-0000-0004	APP-9999999999999902	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/read-limited /activities/update	orcid	2017-06-13 16:20:01.462	2017-06-13 16:20:01.462	7c11d9959699262153197be480ab1e30	1504	\N	ae756dbb-7fe5-4c60-8f1c-592c735aa756	\N	f	1	\N	\N	\N
6b26dae7-e0db-4dbf-a48c-05e1faca0a0c	bearer	2037-06-13 12:36:01.321	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited /activities/update	orcid	2017-06-13 16:20:42.328	2017-06-13 16:20:42.328	390cec4acc694a33651331bf1adfeaaa	1505	\N	b9992996-aedd-44ab-9452-f92b2c22bfcd	\N	t	1	\N	\N	\N
1b8f37df-6208-48a3-875b-d2758021cff2	bearer	2037-06-13 12:36:13.206	\N	APP-9999999999999901	t	\N		\N	/webhook	orcid	2017-06-13 16:20:54.207	2017-06-13 16:20:54.207	92702bb32527e9c0b24b902554b1142e	1506	\N	0b75adc9-2b16-4c6c-a5b3-1a2ba751979e	\N	f	1	\N	\N	\N
6ac05347-e812-4667-b31a-6f7993c6b2dc	bearer	2037-06-13 12:36:45.43	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/update	orcid	2017-06-13 16:21:26.441	2017-06-13 16:21:26.441	9d26f627b8846ec45287788770373b7e	1507	\N	8360dfc7-f876-4d34-9cb5-accdc7e47862	\N	t	1	\N	\N	\N
c1e5e03d-b583-4bc7-bef0-18726ac01ad1	bearer	2037-06-13 12:36:53.779	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:21:34.781	2017-06-13 16:21:34.781	3903ba3ee40c69281e6a7bce61453a28	1508	\N	a093ca05-b602-4dd0-88d1-a4acc6b9f3a7	\N	f	1	\N	\N	\N
dc36358b-e58e-4ec8-8b46-9f7c6a583370	bearer	2037-06-13 12:37:44.135	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:22:25.135	2017-06-13 16:22:25.135	7fb1b415f5231d2280fa57cfb5053d5e	1513	\N	8bd65dc6-8a21-46c1-a6ab-c9e05e9478ce	\N	f	1	\N	\N	\N
1edad6a3-6e44-4850-bf78-e3f19e1bee11	bearer	2037-06-13 12:40:55.815	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:36.816	2017-06-13 16:25:36.816	7ae782f285d4d938c43c85528cfaf229	1522	\N	1fefa483-95e4-463a-979a-9d53d5410844	\N	f	1	\N	\N	\N
116633b7-ff97-43e6-ab49-8cc905222ff8	bearer	2037-06-13 12:40:56.146	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:37.147	2017-06-13 16:25:37.147	7ae782f285d4d938c43c85528cfaf229	1523	\N	37af271a-f021-45f7-aedc-7dd68e9183c3	\N	f	1	\N	\N	\N
5f7659b6-e1de-4e92-84b1-dad3fce817cb	bearer	2037-06-13 12:40:56.847	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:37.847	2017-06-13 16:25:37.847	7ae782f285d4d938c43c85528cfaf229	1525	\N	7fb0d479-1fee-4547-83a5-9898f5b86836	\N	f	1	\N	\N	\N
750e196b-b2ba-46e1-813e-b3e28f6a5f95	bearer	2037-06-13 12:40:57.053	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:38.053	2017-06-13 16:25:38.053	7ae782f285d4d938c43c85528cfaf229	1526	\N	01623412-2204-4115-9a19-d9b1ddc99dca	\N	f	1	\N	\N	\N
56376998-8514-4879-87f4-67e1277219bf	bearer	2037-06-13 12:26:58.683	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-06-13 16:11:39.695	2017-06-13 16:11:39.695	0bda87e38e59d17fc1cadc1bbccdfd1b	1479	\N	d10c103d-f8be-4f43-b8f6-8b6d82e6e1e1	\N	t	1	\N	\N	\N
ce643578-1c00-44d6-a74d-01a41f2a9762	bearer	2037-06-13 12:27:30.615	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-06-13 16:12:11.686	2017-06-13 16:12:11.686	0bda87e38e59d17fc1cadc1bbccdfd1b	1480	\N	3175cbb0-bb19-40ec-a23d-961e1677d2ce	\N	t	1	\N	\N	\N
7a64825b-8a3b-4ed2-9405-2c777085b36d	bearer	2037-06-13 12:28:03.125	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-06-13 16:12:44.234	2017-06-13 16:12:44.234	0bda87e38e59d17fc1cadc1bbccdfd1b	1481	\N	0197cdc5-fa15-4f8a-935b-ae878132bc5e	\N	t	1	\N	\N	\N
044a48df-0a10-4d3f-8d22-9d2eed400385	bearer	2037-06-13 12:28:03.48	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:12:44.481	2017-06-13 16:12:44.481	276069c4d3be949258d185c0e1701278	1482	\N	ce0faa36-b489-478a-b3b4-bfe44931b6c7	\N	f	1	\N	\N	\N
74465c72-39f6-4b5d-afeb-ac24cdc3c6b5	bearer	2037-06-13 12:28:03.545	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:12:44.546	2017-06-13 16:12:44.546	276069c4d3be949258d185c0e1701278	1483	\N	91d78c94-4c90-44f8-ada1-7df8f63696e8	\N	f	1	\N	\N	\N
b33ad6dd-f6fe-4dc1-9b9f-09854179f130	bearer	2037-06-13 12:28:03.61	\N	APP-9999999999999901	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:12:44.611	2017-06-13 16:12:44.611	276069c4d3be949258d185c0e1701278	1484	\N	66905135-61a9-44b4-9a56-48e11158313d	\N	f	1	\N	\N	\N
d585854a-edf2-4e81-a16d-e0e4a16d04e4	bearer	2037-06-13 12:28:03.788	\N	APP-9999999999999901	t	\N		\N	/read-public	orcid	2017-06-13 16:12:44.789	2017-06-13 16:12:44.789	165a3ec304597c3dd5b7880503a1958c	1486	\N	fdc21708-1c4b-4363-ac94-6b0c93da05fa	\N	f	1	\N	\N	\N
bf973079-1432-4c63-bf17-7e095db0dd3c	bearer	2037-06-13 12:28:03.928	\N	APP-9999999999999901	t	\N		\N	/webhook	orcid	2017-06-13 16:12:44.932	2017-06-13 16:12:44.932	92702bb32527e9c0b24b902554b1142e	1488	\N	27663c35-ab4d-4569-a306-efde62fd5fae	\N	f	1	\N	\N	\N
64fbdcc7-a40d-4426-9b94-671181b03d45	bearer	2037-06-13 12:28:31.099	\N	APP-9999999999999903	t	\N		\N	/read-public	orcid	2017-06-13 16:13:12.103	2017-06-13 16:13:12.103	76fc187a82824b90baaa2eb7397c8f07	1490	\N	019660f8-68ed-4c96-a5e8-ee4ee93e3d68	\N	f	1	\N	\N	\N
034eefc5-df5b-452a-bdee-b56b5e95efa9	bearer	2037-06-13 12:29:36.783	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/update	orcid	2017-06-13 16:14:17.864	2017-06-13 16:14:17.864	257a8a1c2371db71629b27aa8d47f7e1	1494	\N	73fbed76-827a-4672-9b1c-5d5476ca1b5c	f	t	1	\N	\N	\N
27d7dc67-54c5-4791-a44f-41511a9df321	bearer	2037-06-13 12:31:51.831	9999-0000-0000-0004	APP-9999999999999903	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/authenticate	orcid	2017-06-13 16:16:32.834	2017-06-13 16:16:32.834	8f8c14436439216e305452a23b785553	1498	\N	da60a42a-52fa-4e85-b260-eb664971c9e4	\N	t	1	\N	\N	\N
3ac05f8a-096e-45a7-be4f-614c867fb20c	bearer	2037-06-13 12:33:03.068	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/read-limited /activities/update	orcid	2017-06-13 16:17:44.075	2017-06-13 16:17:44.075	676197e28a52c33e5c4e13e06d9beb17	1500	\N	c8d6c2e5-1f0a-4923-84aa-75d3666f15e9	\N	t	1	\N	\N	\N
8d2b4f74-9126-4185-8abd-b0f0aac8089b	bearer	2037-06-13 12:33:36.455	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update /affiliations/read-limited	orcid	2017-06-13 16:18:17.47	2017-06-13 16:18:17.47	906af268b7598ffd07ff23470c49bcd2	1501	\N	03f1e174-e2ff-40aa-bd8e-83ec33102e3f	\N	t	1	\N	\N	\N
bed8d1ff-9979-4feb-8f8a-339069cf2462	bearer	2037-06-13 12:36:58.522	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:21:39.523	2017-06-13 16:21:39.523	7fb1b415f5231d2280fa57cfb5053d5e	1509	\N	28dfb108-96ff-4168-bed8-114b369f3ed1	\N	f	1	\N	\N	\N
43eb8129-960e-40e1-8317-2035a4177e15	bearer	2017-06-13 17:22:13.797	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/funding/update /funding/create	orcid	2017-06-13 16:22:13.803	2017-06-13 16:22:13.803	933607a7f5d1d9bbb5d9051821f2d4ce	1510	\N	5e41dc75-a879-43ef-b373-07e170e1dae4	\N	f	1	\N	\N	\N
97284f96-5762-46f7-92b0-d1edb869c25b	bearer	2037-06-13 12:37:35.118	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:22:16.119	2017-06-13 16:22:16.119	7fb1b415f5231d2280fa57cfb5053d5e	1511	\N	d952f483-0621-44d8-bdb5-45ae87eae9e7	\N	f	1	\N	\N	\N
9ee0e61a-6c00-4363-871c-4a3ef7b48aa7	bearer	2037-06-13 12:37:43.658	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:22:24.659	2017-06-13 16:22:24.659	7fb1b415f5231d2280fa57cfb5053d5e	1512	\N	7cc5138b-9557-4de7-8df7-fdfd34f64c65	\N	f	1	\N	\N	\N
c0ad54f0-da17-4a18-acde-98a01570e1b0	bearer	2017-06-13 17:22:57.974	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited	orcid	2017-06-13 16:22:57.98	2017-06-13 16:22:57.98	0a0e67a368170de6a22fa6869d56af96	1514	\N	b220062a-3025-4e45-b1a3-6840aec56a59	\N	f	1	\N	\N	\N
255f576f-b294-455c-8ebc-5f32bc410f2e	bearer	2017-06-13 17:23:29.917	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited	orcid	2017-06-13 16:23:29.921	2017-06-13 16:23:29.921	0a0e67a368170de6a22fa6869d56af96	1515	\N	6c266649-bf50-424a-9ab7-27ef85920ba5	\N	f	1	\N	\N	\N
43a90921-6cc1-4972-aba1-dfafb8b38ebb	bearer	2017-06-13 17:24:02.367	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited /activities/update	orcid	2017-06-13 16:24:02.371	2017-06-13 16:24:02.371	390cec4acc694a33651331bf1adfeaaa	1516	\N	5153f6d3-e959-4014-95f6-1a895757f5ef	\N	f	1	\N	\N	\N
1b9c09d8-267d-4b7e-bc0c-a89718a51221	bearer	2037-06-13 12:39:26.2	\N	APP-9999999999999902	t	\N		\N	/read-public	orcid	2017-06-13 16:24:07.201	2017-06-13 16:24:07.201	5c46a40485e7c772aae0ab814ed7fdd9	1517	\N	94ed14c1-ccc9-40e8-aa1b-ec110605e633	\N	f	1	\N	\N	\N
922e1f74-1c0d-470e-a14d-e2c754425c27	bearer	2037-06-13 12:39:29.669	\N	APP-9999999999999903	t	\N		\N	/read-public	orcid	2017-06-13 16:24:10.672	2017-06-13 16:24:10.672	76fc187a82824b90baaa2eb7397c8f07	1518	\N	f1541cad-4a20-462e-b2cc-e54336f76f0e	\N	f	1	\N	\N	\N
f0020ee3-2589-4a2d-87cd-b6c8bd7d095c	bearer	2017-06-13 17:25:31.704	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-06-13 16:25:31.708	2017-06-13 16:25:31.708	0bda87e38e59d17fc1cadc1bbccdfd1b	1519	\N	a746074a-5b37-4049-b2ed-ac5f34178095	\N	f	1	\N	\N	\N
50e58131-778e-4f53-8282-dc5ef473adef	bearer	2017-06-13 17:25:34.546	9999-0000-0000-0005	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/update	orcid	2017-06-13 16:25:34.551	2017-06-13 16:25:34.551	6874fe1113b312acd89df942175e92cb	1520	\N	8dd0cad8-d740-4b22-b311-188f4fc888f8	\N	f	1	\N	\N	\N
80db7005-9f36-4d1e-b0ba-fb4047132c09	bearer	2037-06-13 12:40:55.715	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:36.715	2017-06-13 16:25:36.715	7ae782f285d4d938c43c85528cfaf229	1521	\N	1fb9e519-0404-402e-aa21-699df9f68a07	\N	f	1	\N	\N	\N
eaa68fdb-bbc0-46a7-aa67-1ad5698a953d	bearer	2037-06-13 12:40:56.534	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:37.535	2017-06-13 16:25:37.535	7ae782f285d4d938c43c85528cfaf229	1524	\N	0a641c23-a039-4ae1-b3bb-8e6828336a08	\N	f	1	\N	\N	\N
4ae7dccc-19e8-4cbd-95cb-b6fc8205472c	bearer	2037-06-13 12:40:57.246	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:38.251	2017-06-13 16:25:38.251	7ae782f285d4d938c43c85528cfaf229	1527	\N	cc17f961-19f1-4972-9352-ad161e3190de	\N	f	1	\N	\N	\N
c6582dfa-fcc5-4f76-81b8-40d7d41cfe2b	bearer	2037-06-13 12:41:03.391	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:25:44.392	2017-06-13 16:25:44.392	7fb1b415f5231d2280fa57cfb5053d5e	1528	\N	f48de905-d591-425a-a278-18fffffddebf	\N	f	1	\N	\N	\N
c6c78e68-818c-40f8-ac5b-bede3e5430ad	bearer	2037-06-13 12:41:12.378	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:25:53.379	2017-06-13 16:25:53.379	7fb1b415f5231d2280fa57cfb5053d5e	1530	\N	6668e2f9-3da6-4a66-8442-4df0b76f7b28	\N	f	1	\N	\N	\N
ca6d4798-c373-48eb-b803-2ae18e38330b	bearer	2037-06-13 12:41:17.1	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:25:58.101	2017-06-13 16:25:58.101	7fb1b415f5231d2280fa57cfb5053d5e	1532	\N	16cd7eee-da44-4cc7-8b95-32dc57e5f6a4	\N	f	1	\N	\N	\N
7da40093-740f-4c2f-9d6e-44377b2d2f19	bearer	2037-06-13 12:41:17.903	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:58.904	2017-06-13 16:25:58.904	7ae782f285d4d938c43c85528cfaf229	1534	\N	ce47d27e-851f-467f-84f9-09ba1a73cbe5	\N	f	1	\N	\N	\N
fe9225d4-b144-4dd0-8d3a-9048d9ea1958	bearer	2037-06-13 12:41:18.374	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:59.375	2017-06-13 16:25:59.375	7ae782f285d4d938c43c85528cfaf229	1536	\N	b2dc92fb-42b3-4942-9a0b-a1f4e466b296	\N	f	1	\N	\N	\N
6774ecaf-0167-420e-aa63-b64f43d1ce56	bearer	2037-06-13 12:41:18.601	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:59.602	2017-06-13 16:25:59.602	7ae782f285d4d938c43c85528cfaf229	1538	\N	69fb2e3d-00aa-482b-91a3-af4eb7d4bb04	\N	f	1	\N	\N	\N
aacba19a-cf12-44b3-9f38-292e71f97219	bearer	2037-06-13 12:41:18.838	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:59.838	2017-06-13 16:25:59.838	7ae782f285d4d938c43c85528cfaf229	1540	\N	cffa7009-b126-4bce-8069-80833a5019a7	\N	f	1	\N	\N	\N
bad71743-e62b-41cf-8256-0dcfb83e1779	bearer	2017-06-13 17:26:31.936	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited	orcid	2017-06-13 16:26:31.94	2017-06-13 16:26:31.94	0a0e67a368170de6a22fa6869d56af96	1541	\N	9378dbf8-aa2d-4d48-ae30-af34a8fe318e	\N	f	1	\N	\N	\N
976c6af4-ea77-47c5-9fef-45876dd56245	bearer	2037-06-13 12:41:58.386	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:26:39.386	2017-06-13 16:26:39.386	7fb1b415f5231d2280fa57cfb5053d5e	1542	\N	cfbafe6d-9138-418e-bf6c-ed323d0e8172	\N	f	1	\N	\N	\N
23027df3-ffa9-44ad-8c3f-4d4ff8ba6541	bearer	2037-06-13 12:42:09.683	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:26:50.683	2017-06-13 16:26:50.683	7fb1b415f5231d2280fa57cfb5053d5e	1545	\N	16ed2592-cebb-4cb0-bbc5-f4709b1e9839	\N	f	1	\N	\N	\N
92c30db6-2aca-4247-af69-49dc07a8940f	bearer	2037-06-13 12:42:10.838	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:26:51.838	2017-06-13 16:26:51.838	7ae782f285d4d938c43c85528cfaf229	1549	\N	82bc5b53-a579-4f0b-b41d-5344ef77b259	\N	f	1	\N	\N	\N
43c2f1df-0548-4957-88f3-c4db011646d8	bearer	2037-06-13 12:41:10.894	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:25:51.894	2017-06-13 16:25:51.894	7fb1b415f5231d2280fa57cfb5053d5e	1529	\N	cfefb70d-31bc-4521-b993-23903e3fce37	\N	f	1	\N	\N	\N
86f73069-4462-4a7a-a3a1-cd9e9f599913	bearer	2037-06-13 12:41:17.812	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:58.812	2017-06-13 16:25:58.812	7ae782f285d4d938c43c85528cfaf229	1533	\N	55bb8032-169b-433b-b257-72bdeffa1ecb	\N	f	1	\N	\N	\N
56f734a1-c50d-4e84-ba55-0b4bbbed186a	bearer	2037-06-13 12:41:18.46	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:59.461	2017-06-13 16:25:59.461	7ae782f285d4d938c43c85528cfaf229	1537	\N	06ae9c1b-6294-48fe-96c1-8d1550449d05	\N	f	1	\N	\N	\N
37615dbc-dc96-4331-ade1-f0728c9a30be	bearer	2037-06-13 12:42:06.401	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:26:47.404	2017-06-13 16:26:47.404	7fb1b415f5231d2280fa57cfb5053d5e	1544	\N	1d989841-8125-4c27-b80f-aac2ab7e3f9a	\N	f	1	\N	\N	\N
c8601307-b726-439f-92c8-fffeb4e12656	bearer	2037-06-13 12:41:16.756	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:25:57.757	2017-06-13 16:25:57.757	7fb1b415f5231d2280fa57cfb5053d5e	1531	\N	a551ea1b-6e18-4670-9159-6c546a851e90	\N	f	1	\N	\N	\N
9879e91e-ad58-4742-8298-26cb1ff57f5d	bearer	2037-06-13 12:41:18.108	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:59.109	2017-06-13 16:25:59.109	7ae782f285d4d938c43c85528cfaf229	1535	\N	70155a8d-b29e-4a79-90d0-ad661f387800	\N	f	1	\N	\N	\N
243245d6-cc5e-4f4d-bb59-64a534370e10	bearer	2037-06-13 12:41:18.752	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:25:59.752	2017-06-13 16:25:59.752	7ae782f285d4d938c43c85528cfaf229	1539	\N	14b53ba2-ad6d-4521-9080-49e445d90a84	\N	f	1	\N	\N	\N
d8166725-ef0a-4abd-9c21-e3388a83fbbc	bearer	2037-06-13 12:42:05.23	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:26:46.23	2017-06-13 16:26:46.23	7fb1b415f5231d2280fa57cfb5053d5e	1543	\N	9dbf45ec-c5b8-4e25-8fd6-43ac4946c654	\N	f	1	\N	\N	\N
5d1eeb00-5592-4eee-8c8f-6bbf4456abdd	bearer	2037-06-13 12:42:09.991	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:26:50.992	2017-06-13 16:26:50.992	7fb1b415f5231d2280fa57cfb5053d5e	1546	\N	7d1d592d-9439-41fa-a76a-a96559c616b3	\N	f	1	\N	\N	\N
25171b00-c180-4ae0-9f1e-0d8b771a2a8f	bearer	2037-06-13 12:42:10.745	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:26:51.746	2017-06-13 16:26:51.746	7ae782f285d4d938c43c85528cfaf229	1548	\N	7bb0d192-251c-43a0-b8e4-3d1d80593d5e	\N	f	1	\N	\N	\N
19142eb4-f81d-444a-977b-4fb95c795d9d	bearer	2037-06-13 12:42:11.049	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:26:52.05	2017-06-13 16:26:52.05	7ae782f285d4d938c43c85528cfaf229	1550	\N	3a28ebab-aebb-467a-b17b-c733737544a8	\N	f	1	\N	\N	\N
23e3d3f1-e62f-459a-8b74-590ba47e690b	bearer	2037-06-13 12:42:11.132	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:26:52.132	2017-06-13 16:26:52.132	7ae782f285d4d938c43c85528cfaf229	1551	\N	b953fdbd-88ae-4efb-ba70-bcb77590a2dd	\N	f	1	\N	\N	\N
aeb7f104-46cd-4a8c-a3d1-eb9810c7d50a	bearer	2037-06-13 12:42:11.275	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:26:52.277	2017-06-13 16:26:52.277	7ae782f285d4d938c43c85528cfaf229	1552	\N	d87353fe-668e-4fce-b28e-9c22548f0e33	\N	f	1	\N	\N	\N
7cdc0c63-401c-4f3b-ba0e-9755d98d6ded	bearer	2037-06-13 12:42:11.468	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:26:52.468	2017-06-13 16:26:52.468	7ae782f285d4d938c43c85528cfaf229	1553	\N	9d8e63c9-6a88-470b-818f-8c7a6bd2f434	\N	f	1	\N	\N	\N
10c3fb72-28d5-41cd-9bc1-5d602723a34d	bearer	2037-06-13 12:42:19.181	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:27:00.182	2017-06-13 16:27:00.182	7fb1b415f5231d2280fa57cfb5053d5e	1555	\N	620dcbb1-21e7-44c6-8211-96f1fb55f30d	\N	f	1	\N	\N	\N
9ad67f07-6b62-42ca-a3d0-e58f376cadc1	bearer	2037-06-13 12:42:26.306	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:27:07.307	2017-06-13 16:27:07.307	7fb1b415f5231d2280fa57cfb5053d5e	1556	\N	d32e3d70-c7e1-42c2-942b-5fbe0725f233	\N	f	1	\N	\N	\N
19ab355c-0c41-486e-8b33-d6352e8d4d0e	bearer	2037-06-13 12:42:27.426	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:27:08.426	2017-06-13 16:27:08.426	7fb1b415f5231d2280fa57cfb5053d5e	1557	\N	7a91c4e5-4d17-41e6-af9e-1a65f203f4fb	\N	f	1	\N	\N	\N
545bbb63-7e2d-40bb-949f-18027eea9a20	bearer	2037-06-13 12:42:10.679	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:26:51.68	2017-06-13 16:26:51.68	7ae782f285d4d938c43c85528cfaf229	1547	\N	b5b4207e-bad7-4b17-9cc0-92bbee58315d	\N	f	1	\N	\N	\N
d339bb48-ed37-4420-94bb-af03c01d7635	bearer	2037-06-13 12:42:11.607	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:26:52.608	2017-06-13 16:26:52.608	7ae782f285d4d938c43c85528cfaf229	1554	\N	9c119768-d3e6-4c61-b127-58e657ad93dd	\N	f	1	\N	\N	\N
ef016617-bd95-4f53-826a-64a14cc1fc0b	bearer	2037-06-13 12:42:30.336	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:27:11.337	2017-06-13 16:27:11.337	7fb1b415f5231d2280fa57cfb5053d5e	1558	\N	1ca59dae-06c9-4af3-ab9c-389a9c9ee8f8	\N	f	1	\N	\N	\N
26db2c2f-16f1-47a9-a67d-b64b6f26b8fc	bearer	2037-06-13 12:42:30.678	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:27:11.679	2017-06-13 16:27:11.679	7fb1b415f5231d2280fa57cfb5053d5e	1559	\N	f96e2a43-358d-4f07-b1d8-26b13d23c001	\N	f	1	\N	\N	\N
3daf2fb4-a8d2-45ed-b762-3e7b02a856ec	bearer	2037-06-13 12:42:31.301	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:12.301	2017-06-13 16:27:12.301	7ae782f285d4d938c43c85528cfaf229	1560	\N	da84ed42-3a6b-4df6-bae3-8db1abf6e660	\N	f	1	\N	\N	\N
b224f51e-84d6-48a9-b95c-ced86b13d3a5	bearer	2037-06-13 12:42:31.367	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:12.368	2017-06-13 16:27:12.368	7ae782f285d4d938c43c85528cfaf229	1561	\N	0d2cf237-31b1-4f48-9c77-7c1ac8ba0df2	\N	f	1	\N	\N	\N
5679fb04-8851-4dd0-845f-ebcc646c595d	bearer	2037-06-13 12:42:31.493	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:12.494	2017-06-13 16:27:12.494	7ae782f285d4d938c43c85528cfaf229	1562	\N	9a8ea02e-2584-409f-87fe-ebcab53a3a96	\N	f	1	\N	\N	\N
883c87dd-78a4-4317-b42f-f4c76ff4cb19	bearer	2037-06-13 12:42:31.733	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:12.734	2017-06-13 16:27:12.734	7ae782f285d4d938c43c85528cfaf229	1563	\N	d3430d9b-0f3b-4c37-947f-a36742d50360	\N	f	1	\N	\N	\N
1dd03496-0e0f-4f64-9028-5125d0a11a6d	bearer	2037-06-13 12:42:31.809	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:12.81	2017-06-13 16:27:12.81	7ae782f285d4d938c43c85528cfaf229	1564	\N	7e642c09-d876-4031-b170-3a8df691828f	\N	f	1	\N	\N	\N
bd472c0d-7ff3-4cb2-bafc-b3662c9cf362	bearer	2037-06-13 12:42:31.946	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:12.946	2017-06-13 16:27:12.946	7ae782f285d4d938c43c85528cfaf229	1565	\N	f60d7f5f-e9b4-49aa-bc54-a05b5ed7b44b	\N	f	1	\N	\N	\N
80e97d2e-9745-4f9a-9927-aae4e9bcec1c	bearer	2037-06-13 12:42:32.1	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:13.101	2017-06-13 16:27:13.101	7ae782f285d4d938c43c85528cfaf229	1566	\N	45bcbb98-b97d-4af5-8e24-affed47a7208	\N	f	1	\N	\N	\N
7fffc03c-fbb8-4680-b07d-f3ec21a46026	bearer	2037-06-13 12:42:32.188	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:13.189	2017-06-13 16:27:13.189	7ae782f285d4d938c43c85528cfaf229	1567	\N	ada1f8a3-0ded-40c6-93b1-7d660802920d	\N	f	1	\N	\N	\N
78f8018b-06a8-48b5-8333-bc87bddd745e	bearer	2037-06-13 12:42:42.017	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:27:23.018	2017-06-13 16:27:23.018	7fb1b415f5231d2280fa57cfb5053d5e	1568	\N	ac1a8a0d-5e96-4335-85d9-10f7a5f4531d	\N	f	1	\N	\N	\N
d8558ced-4f12-47b9-9850-2ecd01bb3a40	bearer	2037-06-13 12:42:50.687	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:27:31.687	2017-06-13 16:27:31.687	7fb1b415f5231d2280fa57cfb5053d5e	1569	\N	6917f7ed-4bd8-4c49-a715-e745b4c32569	\N	f	1	\N	\N	\N
9ebcd51a-e1a5-4c0b-af3f-9bbdebab380b	bearer	2037-06-13 12:42:51.929	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:27:32.93	2017-06-13 16:27:32.93	7fb1b415f5231d2280fa57cfb5053d5e	1570	\N	5393cc88-5dc0-46d1-a999-18fe21f1dbac	\N	f	1	\N	\N	\N
de8589bd-57f3-4707-a27c-a30d0293e5be	bearer	2037-06-13 12:42:55.366	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:27:36.367	2017-06-13 16:27:36.367	7fb1b415f5231d2280fa57cfb5053d5e	1571	\N	72be0e7b-f1c3-496a-8f64-a39de6498a4f	\N	f	1	\N	\N	\N
3e838f68-c18c-4b20-8ad9-c63c5c41ca15	bearer	2037-06-13 12:42:55.762	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:27:36.763	2017-06-13 16:27:36.763	7fb1b415f5231d2280fa57cfb5053d5e	1572	\N	7268a944-a73d-492e-9c08-98a0074e821f	\N	f	1	\N	\N	\N
6871f0bd-d295-4e9d-8a9d-b72687fbd6b1	bearer	2037-06-13 12:42:56.449	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:37.45	2017-06-13 16:27:37.45	7ae782f285d4d938c43c85528cfaf229	1573	\N	c4a13c41-6ee3-427d-9bf2-0bf5d70f7d46	\N	f	1	\N	\N	\N
8c85ec60-1db5-40bd-9a43-7cca3a57b78b	bearer	2037-06-13 12:42:56.517	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:37.517	2017-06-13 16:27:37.517	7ae782f285d4d938c43c85528cfaf229	1574	\N	a590e1c3-3903-41fe-9df1-5a926ed6a246	\N	f	1	\N	\N	\N
e3824b42-f0e1-41aa-a60f-3923761be8aa	bearer	2037-06-13 12:42:56.639	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:37.64	2017-06-13 16:27:37.64	7ae782f285d4d938c43c85528cfaf229	1575	\N	4294603b-9cdf-4894-b2dc-65832ac6f807	\N	f	1	\N	\N	\N
78fe28a5-1ba3-43d7-b350-adbe0897a967	bearer	2037-06-13 12:42:56.869	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:37.87	2017-06-13 16:27:37.87	7ae782f285d4d938c43c85528cfaf229	1576	\N	7b72f3c2-0ab3-4228-8346-5fa63f566a5e	\N	f	1	\N	\N	\N
c51c0a54-2c48-4e7c-a5fe-cddab079ca5e	bearer	2037-06-13 12:42:56.95	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:37.951	2017-06-13 16:27:37.951	7ae782f285d4d938c43c85528cfaf229	1577	\N	3fcbc3c7-d558-4695-b4c5-06903bce36a6	\N	f	1	\N	\N	\N
b25ae34d-96e1-4bb0-a422-6bc888a4faf0	bearer	2037-06-13 12:42:57.087	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:38.088	2017-06-13 16:27:38.088	7ae782f285d4d938c43c85528cfaf229	1578	\N	1ac26e88-b74a-4d1a-9651-37922205da6e	\N	f	1	\N	\N	\N
64a6d2ed-bcbc-4a5f-9161-17ac3d6cc507	bearer	2037-06-13 12:42:57.233	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:38.234	2017-06-13 16:27:38.234	7ae782f285d4d938c43c85528cfaf229	1579	\N	f08907fe-57cc-4ac4-a2d9-45f77bb8328f	\N	f	1	\N	\N	\N
c96e8c31-1353-4a29-8ffd-24f33383b83f	bearer	2037-06-13 12:42:57.326	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:27:38.327	2017-06-13 16:27:38.327	7ae782f285d4d938c43c85528cfaf229	1580	\N	fad54399-6a28-4956-b39d-8b448fe76bdf	\N	f	1	\N	\N	\N
491d448e-ac8a-42ca-8622-65d3b0300eec	bearer	2037-06-13 12:43:06.413	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:27:47.414	2017-06-13 16:27:47.414	7fb1b415f5231d2280fa57cfb5053d5e	1581	\N	082cacb0-2b3d-4450-a69f-dfbd21151b13	\N	f	1	\N	\N	\N
444a41a5-fe4a-45e6-a78c-3d1865633112	bearer	2017-06-13 17:28:32.928	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/read-limited /person/update	orcid	2017-06-13 16:28:32.932	2017-06-13 16:28:32.932	469af49b2e9827ae5585ae89f7e49bed	1582	\N	a5f889e8-073b-4f73-8141-c1efa44d0fa9	\N	f	1	\N	\N	\N
50a90ad4-bcf7-46d7-b0f3-268d6b998646	bearer	2037-06-13 12:46:08.835	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:49.836	2017-06-13 16:30:49.836	3903ba3ee40c69281e6a7bce61453a28	1583	\N	062e7fcc-9eab-410a-845a-86275d2221cb	\N	f	1	\N	\N	\N
8e2f5e75-30bd-45f7-b952-36b8add1f4f5	bearer	2037-06-13 12:46:09.001	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:50.002	2017-06-13 16:30:50.002	3903ba3ee40c69281e6a7bce61453a28	1584	\N	04df58f4-f5e5-4857-8293-477fca7de260	\N	f	1	\N	\N	\N
e03e992f-98b3-4caf-bd8a-77d55dae5131	bearer	2037-06-13 12:46:10.809	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:51.81	2017-06-13 16:30:51.81	3903ba3ee40c69281e6a7bce61453a28	1585	\N	ed893bf2-c0da-44fb-ad09-1a7eae85f4d0	\N	f	1	\N	\N	\N
332b7e63-4a7f-48ba-9038-61b341828e71	bearer	2037-06-13 12:46:11.17	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:52.203	2017-06-13 16:30:52.203	3903ba3ee40c69281e6a7bce61453a28	1586	\N	0f8ef872-e79d-402a-a5a9-1fb009d82d1f	\N	f	1	\N	\N	\N
d55be385-ba63-4e49-88f5-e955b0fc7a20	bearer	2037-06-13 12:46:11.374	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:52.375	2017-06-13 16:30:52.375	3903ba3ee40c69281e6a7bce61453a28	1587	\N	8d062d77-3065-448c-aa2f-4bd71abd30ae	\N	f	1	\N	\N	\N
47cf8cf9-1030-4ed3-a121-7a14dbdc86fd	bearer	2037-06-13 12:46:13.345	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:54.346	2017-06-13 16:30:54.346	3903ba3ee40c69281e6a7bce61453a28	1588	\N	774e9cc5-e7fe-4b33-b5c3-3f1bea03fa39	\N	f	1	\N	\N	\N
fbd4ceb0-3a95-4b5c-bab9-e115a71c4a0d	bearer	2037-06-13 12:46:13.732	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:54.733	2017-06-13 16:30:54.733	3903ba3ee40c69281e6a7bce61453a28	1589	\N	a4314b35-8f27-4d43-a51b-0b949fbd528b	\N	f	1	\N	\N	\N
d636f90d-c6c0-411d-bb0d-d2c3969a83a7	bearer	2037-06-13 12:46:13.927	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:54.928	2017-06-13 16:30:54.928	3903ba3ee40c69281e6a7bce61453a28	1590	\N	c4cfa218-6e76-4ee4-ba96-37eeadba50a4	\N	f	1	\N	\N	\N
a6dabfc2-3883-47fc-bfa8-333944d40ba6	bearer	2037-06-13 12:46:15.662	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:56.668	2017-06-13 16:30:56.668	3903ba3ee40c69281e6a7bce61453a28	1591	\N	eb677fbf-8aaa-4a16-a16b-1225a1b23830	\N	f	1	\N	\N	\N
9b4b8208-106f-4e8a-971c-345645ea70f3	bearer	2037-06-13 12:46:16.028	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:57.045	2017-06-13 16:30:57.045	3903ba3ee40c69281e6a7bce61453a28	1592	\N	ab0c99d9-916a-4982-bc2e-79e92e11eb5d	\N	f	1	\N	\N	\N
33a0cfcc-45fb-4ccf-935c-be691012d9d5	bearer	2037-06-13 12:46:16.208	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:57.209	2017-06-13 16:30:57.209	3903ba3ee40c69281e6a7bce61453a28	1593	\N	cdfff3a6-2357-441d-aca0-0228d02bd719	\N	f	1	\N	\N	\N
eea5be9e-e2a8-494b-8187-1b6817c21561	bearer	2037-06-13 12:46:16.549	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:57.549	2017-06-13 16:30:57.549	3903ba3ee40c69281e6a7bce61453a28	1594	\N	eb4f9978-c554-4522-b61d-9b99e97ac77d	\N	f	1	\N	\N	\N
1aaa02e9-af7c-403f-95ad-c52c5146fdc6	bearer	2037-06-13 12:46:16.6	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:57.601	2017-06-13 16:30:57.601	3903ba3ee40c69281e6a7bce61453a28	1595	\N	461a824b-1cbf-4ab7-8311-b31ef28e8f2c	\N	f	1	\N	\N	\N
cbcb590c-5ca8-4b09-9500-63e2901a9d16	bearer	2037-06-13 12:46:16.762	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:57.762	2017-06-13 16:30:57.762	3903ba3ee40c69281e6a7bce61453a28	1596	\N	99dda01d-c3eb-41af-b3f6-6e7d70c3ec54	\N	f	1	\N	\N	\N
fc99670a-5b05-4f9b-ad05-28369c7edea0	bearer	2037-06-13 12:46:18.217	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:59.218	2017-06-13 16:30:59.218	3903ba3ee40c69281e6a7bce61453a28	1597	\N	5c4cea9b-b6f4-42f8-aa81-0b322667840c	\N	f	1	\N	\N	\N
851864e5-95f8-44c4-9640-20190be14e03	bearer	2037-06-13 12:46:18.499	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:59.5	2017-06-13 16:30:59.5	3903ba3ee40c69281e6a7bce61453a28	1598	\N	e900bfb9-d725-414e-b391-7553531547ab	\N	f	1	\N	\N	\N
f5c8b1bf-1f9c-46a0-8b1b-5d0e4faa84b3	bearer	2037-06-13 12:46:18.665	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:30:59.666	2017-06-13 16:30:59.666	3903ba3ee40c69281e6a7bce61453a28	1599	\N	674455f3-7e10-4d0d-bf8a-97f3a45a156d	\N	f	1	\N	\N	\N
45997e58-0552-42f4-afb9-7f59f950f136	bearer	2037-06-13 12:46:20.838	\N	APP-9999999999999901	t	\N		\N	/group-id-record/update	orcid	2017-06-13 16:31:01.839	2017-06-13 16:31:01.839	3903ba3ee40c69281e6a7bce61453a28	1600	\N	b40818b9-cdc4-4eb1-8f98-ee149055de2f	\N	f	1	\N	\N	\N
debc25d1-b293-49f0-acf3-988d981861b3	bearer	2017-06-13 17:32:45.076	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-bio/external-identifiers/create	orcid	2017-06-13 16:32:45.081	2017-06-13 16:32:45.081	e9277db1e22ce8058f356ef32c679960	1601	\N	e29f6d0e-6c78-480b-8fec-2404eabd5786	\N	f	1	\N	\N	\N
e6e1b9f2-7097-46bf-aec2-7e06f20c1956	bearer	2017-06-13 17:33:21.212	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/read-limited	orcid	2017-06-13 16:33:21.215	2017-06-13 16:33:21.215	7e790f9d6e2730f661de1883756a4557	1602	\N	dc4bd930-1ece-4df3-9715-614f25a1c9f4	\N	f	1	\N	\N	\N
e01cbb82-27fe-4e46-aa40-f8f62917023d	bearer	2017-06-13 17:34:13.992	9999-0000-0000-0004	APP-9999999999999902	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/read-limited /person/update	orcid	2017-06-13 16:34:13.995	2017-06-13 16:34:13.995	86f7d51d31b9407083116e6d717891d1	1603	\N	6c38ed3b-c676-470f-aafa-7ec43ddfd940	\N	f	1	\N	\N	\N
44f88561-9b0f-4571-a17e-b2c37287f71c	bearer	2017-06-13 17:36:37.548	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/read-limited /person/update	orcid	2017-06-13 16:36:37.551	2017-06-13 16:36:37.551	2e5edc799dcbc77dedda8214132e4ee5	1604	\N	6b86a905-cd71-4b6f-8529-ab68aa10741a	\N	f	1	\N	\N	\N
3fee442a-a5ee-4c2a-8b18-c971cbe8e267	bearer	2017-06-13 17:37:13.154	9999-0000-0000-0004	APP-9999999999999902	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/person/update	orcid	2017-06-13 16:37:13.162	2017-06-13 16:37:13.162	6e5d0cb3aee93c39242009b980e878ac	1605	\N	f154cbe3-059a-46a5-abac-16141fdc18ba	\N	f	1	\N	\N	\N
bb87a4ed-d03f-4458-9116-fffe4d4ff687	bearer	2037-06-13 12:53:06.906	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:37:47.906	2017-06-13 16:37:47.906	7fb1b415f5231d2280fa57cfb5053d5e	1606	\N	fde0f937-1bad-4db6-83fa-45ea72698210	\N	f	1	\N	\N	\N
1a011b01-e08c-4a07-bf5e-3c97dbc812d3	bearer	2037-06-13 12:53:10.294	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:37:51.294	2017-06-13 16:37:51.294	7fb1b415f5231d2280fa57cfb5053d5e	1607	\N	63473dee-2830-449b-81e7-ab08ea3c2c17	\N	f	1	\N	\N	\N
0f61ce22-882f-4f17-aa86-64514c3a42e9	bearer	2037-06-13 12:53:15.264	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:37:56.264	2017-06-13 16:37:56.264	7fb1b415f5231d2280fa57cfb5053d5e	1608	\N	19387694-b6e5-4165-b6d7-c6a4255cbd54	\N	f	1	\N	\N	\N
2bd7f73d-8139-4019-b916-5b4c3d458f51	bearer	2037-06-13 12:53:15.619	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:37:56.621	2017-06-13 16:37:56.621	7fb1b415f5231d2280fa57cfb5053d5e	1609	\N	4f8e1004-a78c-463d-8120-3225cfb248d2	\N	f	1	\N	\N	\N
071928aa-48d8-4779-95df-47a55718c0f2	bearer	2037-06-13 12:53:16.207	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:37:57.208	2017-06-13 16:37:57.208	7ae782f285d4d938c43c85528cfaf229	1610	\N	9a21a961-9e00-4c60-be85-a53766248fad	\N	f	1	\N	\N	\N
27a2c844-a35e-4f42-a82b-30741edbd8f2	bearer	2037-06-13 12:53:16.269	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:37:57.27	2017-06-13 16:37:57.27	7ae782f285d4d938c43c85528cfaf229	1611	\N	5b645175-a012-4efc-8c77-62841efffe5f	\N	f	1	\N	\N	\N
a45d719a-1ffd-4a52-9d1f-99f163956ada	bearer	2037-06-13 12:53:16.361	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:37:57.362	2017-06-13 16:37:57.362	7ae782f285d4d938c43c85528cfaf229	1612	\N	1547026b-5e63-49a2-9c34-1e4b1a5283ae	\N	f	1	\N	\N	\N
326ff2d3-6661-4b23-bf87-391c5332b68b	bearer	2037-06-13 12:53:16.575	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:37:57.576	2017-06-13 16:37:57.576	7ae782f285d4d938c43c85528cfaf229	1613	\N	6515922c-2d6e-4163-a934-5c41687cca34	\N	f	1	\N	\N	\N
8a36cd41-8824-478e-b55f-404b5d90713d	bearer	2037-06-13 12:53:16.653	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:37:57.653	2017-06-13 16:37:57.653	7ae782f285d4d938c43c85528cfaf229	1614	\N	82dbf903-a192-4588-86c1-1cd4c537231c	\N	f	1	\N	\N	\N
45763657-54df-4458-bf15-7a6e801dd5e1	bearer	2037-06-13 12:53:16.788	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:37:57.788	2017-06-13 16:37:57.788	7ae782f285d4d938c43c85528cfaf229	1615	\N	34272551-d662-49f9-93f1-8f0510135765	\N	f	1	\N	\N	\N
0de7b5f5-0578-4607-beb0-2f74b5a9c51c	bearer	2037-06-13 12:53:16.923	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:37:57.924	2017-06-13 16:37:57.924	7ae782f285d4d938c43c85528cfaf229	1616	\N	6634145e-633e-4670-a4db-d5b679868001	\N	f	1	\N	\N	\N
ed4f33f2-d765-456e-8708-b5e22f1873bc	bearer	2037-06-13 12:53:17.001	\N	APP-9999999999999901	t	\N		\N	/premium-notification	orcid	2017-06-13 16:37:58.001	2017-06-13 16:37:58.001	7ae782f285d4d938c43c85528cfaf229	1617	\N	4c39579b-d1e2-49b9-b725-e78f9b8b555f	\N	f	1	\N	\N	\N
51936e6f-9b6a-4222-8f04-f99938ebd9b9	bearer	2037-06-13 12:53:28.539	\N	APP-9999999999999902	t	\N		\N	/orcid-profile/create	orcid	2017-06-13 16:38:09.54	2017-06-13 16:38:09.54	7fb1b415f5231d2280fa57cfb5053d5e	1618	\N	eb902e96-8666-45a0-8af7-010dbe27ea2c	\N	f	1	\N	\N	\N
eb1847b2-67c1-4619-8817-ba0177369bbc	bearer	2037-06-13 12:55:03.934	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/authenticate	orcid	2017-06-13 16:39:44.937	2017-06-13 16:39:44.937	4c85cbb994c7b4575ecc8e3ecdd4588c	1619	\N	133c3d89-4575-482c-b5aa-98c9eb20f04d	\N	t	1	\N	\N	\N
4e164636-dce0-41b5-978b-2afd42ec8a5e	bearer	2037-06-13 12:55:36.088	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/create	orcid	2017-06-13 16:40:17.091	2017-06-13 16:40:17.091	b3a39107debe4fa63ea7b671d5a9b94f	1620	\N	52f2d677-d5a1-41d9-89a7-4b51cf3cb196	\N	t	1	\N	\N	\N
2798b441-f107-4382-a1b3-7368900ebd0f	bearer	2017-06-13 17:40:54.164	9999-0000-0000-0005	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/orcid-works/create	orcid	2017-06-13 16:40:54.17	2017-06-13 16:40:54.17	523e41d1878164a96ebbb0e660ca67d6	1621	\N	e178c759-2cbd-4fca-8cd4-0412df848152	\N	f	1	\N	\N	\N
9aaec9fd-ab0b-470c-b2bb-5665819c693b	bearer	2017-06-13 17:46:15.473	9999-0000-0000-0004	APP-9999999999999901	t	https://localhost:8443/orcid-web/oauth/playground	code	\N	/activities/read-limited /activities/update /person/read-limited /person/update	orcid	2017-06-13 16:46:15.481	2017-06-13 16:46:15.481	1996962dd2ca7e68e5fa85b765f5511c	1622	\N	dfb127f8-05e9-4171-8cbf-cf25a0a7b03f	\N	f	1	\N	\N	\N
\.


--
-- Data for Name: orcid_props; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY orcid_props (key, prop_value, date_created, last_modified) FROM stdin;
import-wizard-cache-version	{"version":"1","createdDate":"Wed Jan 18 21:16:18 UTC 2017"}	2017-01-18 21:16:18.611393+00	2017-01-18 21:16:18.611393+00
\.


--
-- Data for Name: orcid_social; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY orcid_social (orcid, type, encrypted_credentials, date_created, last_modified, last_run) FROM stdin;
\.


--
-- Data for Name: orcidoauth2authoriziationcodedetail_authorities; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY orcidoauth2authoriziationcodedetail_authorities (orcidoauth2authoriziationcodedetail_authoriziation_code_value, authorities) FROM stdin;
2SA43H	ROLE_USER
P9ZE4r	ROLE_USER
uCbgy2	ROLE_USER
3Oi2wF	ROLE_USER
NOphH1	ROLE_USER
n4cFHa	ROLE_USER
xFHR00	ROLE_USER
SMBENt	ROLE_USER
TA4l9R	ROLE_USER
Wq734b	ROLE_USER
CTRrG2	ROLE_USER
RyaM1o	ROLE_USER
rhR8U1	ROLE_USER
G0gSb8	ROLE_USER
SWwP4l	ROLE_USER
ZWyJZr	ROLE_USER
Y0ieqg	ROLE_USER
MBDSdu	ROLE_USER
Bf6wuT	ROLE_USER
kUTUMW	ROLE_USER
G1aFC7	ROLE_USER
\.


--
-- Data for Name: orcidoauth2authoriziationcodedetail_resourceids; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY orcidoauth2authoriziationcodedetail_resourceids (orcidoauth2authoriziationcodedetail_authoriziation_code_value, resourceids) FROM stdin;
\.


--
-- Data for Name: orcidoauth2authoriziationcodedetail_scopes; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY orcidoauth2authoriziationcodedetail_scopes (orcidoauth2authoriziationcodedetail_authoriziation_code_value, scopes) FROM stdin;
NOphH1	/funding/update
2SA43H	/activities/update
2SA43H	/read-limited
NOphH1	/orcid-bio/external-identifiers/create
NOphH1	/orcid-works/update
NOphH1	/read-limited
P9ZE4r	/funding/update
P9ZE4r	/orcid-bio/external-identifiers/create
P9ZE4r	/orcid-works/update
P9ZE4r	/read-limited
uCbgy2	/orcid-works/create
n4cFHa	/orcid-works/create
xFHR00	/activities/update
G0gSb8	/authenticate
SWwP4l	/authenticate
ZWyJZr	/authenticate
rhR8U1	/authenticate
SMBENt	/authenticate
TA4l9R	/authenticate
Wq734b	/activities/update
Wq734b	/read-limited
CTRrG2	/funding/update
CTRrG2	/orcid-bio/external-identifiers/create
CTRrG2	/orcid-works/update
CTRrG2	/read-limited
RyaM1o	/orcid-works/create
3Oi2wF	/activities/update
3Oi2wF	/read-limited
Y0ieqg	/activities/update
Y0ieqg	/read-limited
MBDSdu	/funding/update
MBDSdu	/orcid-bio/external-identifiers/create
MBDSdu	/orcid-works/update
MBDSdu	/read-limited
Bf6wuT	/orcid-works/create
kUTUMW	/orcid-works/create
G1aFC7	/authenticate
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY org (id, name, city, region, country, url, source_id, date_created, last_modified, org_disambiguated_id, client_source_id) FROM stdin;
1001	common:name	common:city	common:region	AF	\N	\N	2017-01-20 01:44:02.778+00	2017-01-20 01:44:02.778+00	\N	APP-9999999999999901
1002	My org name 1484878506132	Imagination city	\N	US	\N	\N	2017-01-20 02:15:06.242+00	2017-01-20 02:15:06.242+00	\N	APP-9999999999999901
1003	added-education-1484878537060	Test land	\N	US	\N	9999-0000-0000-0004	2017-01-20 02:15:43.732+00	2017-01-20 02:15:43.732+00	\N	\N
1005	added-employment-1484878599799	Test land	\N	US	\N	9999-0000-0000-0004	2017-01-20 02:33:24.226+00	2017-01-20 02:33:24.226+00	\N	\N
1006	Org_1487354192605	Edinburgh	\N	GB	\N	\N	2017-02-17 17:56:32.771+00	2017-02-17 17:56:32.771+00	\N	APP-9999999999999901
1007	Orcid Integration Test Org	My City	\N	CR	\N	\N	2017-02-17 17:56:37.332+00	2017-02-17 17:56:37.332+00	\N	APP-9999999999999901
1008	Org_1487354198559	Edinburgh	\N	GB	\N	\N	2017-02-17 17:57:12.419+00	2017-02-17 17:57:12.419+00	\N	APP-9999999999999901
1009	name	city	region	US	\N	\N	2017-02-17 17:57:14.542+00	2017-02-17 17:57:14.542+00	\N	APP-9999999999999901
1010	My org name 1487356164591	Imagination city	\N	US	\N	\N	2017-02-17 18:29:24.881+00	2017-02-17 18:29:24.881+00	\N	APP-9999999999999901
1011	added-education-1487356165126	Test land	\N	US	\N	9999-0000-0000-0004	2017-02-17 18:29:31.727+00	2017-02-17 18:29:31.727+00	\N	\N
1012	tetet	tete	\N	AZ	\N	9999-0000-0000-0004	2017-02-17 20:10:54.517+00	2017-02-17 20:10:54.517+00	\N	\N
1013	Org_1487366646291	Edinburgh	\N	GB	\N	\N	2017-02-17 21:24:06.441+00	2017-02-17 21:24:06.441+00	\N	APP-9999999999999901
1014	Org_1487366652887	Edinburgh	\N	GB	\N	\N	2017-02-17 21:24:17.487+00	2017-02-17 21:24:17.487+00	\N	APP-9999999999999901
1015	My org name 1487368237651	Imagination city	\N	US	\N	\N	2017-02-17 21:50:37.767+00	2017-02-17 21:50:37.767+00	\N	APP-9999999999999901
1016	added-education-1487368267118	Test land	\N	US	\N	9999-0000-0000-0004	2017-02-17 21:51:12.217+00	2017-02-17 21:51:12.217+00	\N	\N
1017	added-funding-1487368301680	Test land	\N	US	\N	9999-0000-0000-0004	2017-02-17 21:51:48.515+00	2017-02-17 21:51:48.515+00	\N	\N
1018	added-employment-1487368337671	Test land	\N	US	\N	9999-0000-0000-0004	2017-02-17 21:52:23.195+00	2017-02-17 21:52:23.195+00	\N	\N
1019	sample	san jose	san jose	CR	\N	9999-0000-0000-000X	2017-05-03 15:47:43.36+00	2017-05-03 15:47:43.36+00	\N	\N
1020	Org_1497370697535	Edinburgh	\N	GB	\N	\N	2017-06-13 16:18:17.776+00	2017-06-13 16:18:17.776+00	\N	APP-9999999999999901
1021	Org_1497370810112	Edinburgh	\N	GB	\N	\N	2017-06-13 16:20:43.102+00	2017-06-13 16:20:43.102+00	\N	APP-9999999999999901
1022	Client 1 - Education 1497370848759	Edinburgh	\N	GB	\N	\N	2017-06-13 16:20:48.836+00	2017-06-13 16:20:48.836+00	\N	APP-9999999999999901
1023	Client 2 - Education 1497370848759	Edinburgh	\N	GB	\N	\N	2017-06-13 16:20:49.012+00	2017-06-13 16:20:49.012+00	\N	APP-9999999999999902
1024	My org name 1497372375527	Imagination city	\N	US	\N	\N	2017-06-13 16:46:15.56+00	2017-06-13 16:46:15.56+00	\N	APP-9999999999999901
1025	added-education-1497372399852	Test land	\N	US	\N	9999-0000-0000-0004	2017-06-13 16:46:44.872+00	2017-06-13 16:46:44.872+00	\N	\N
1026	added-funding-1497372429826	Test land	\N	US	\N	9999-0000-0000-0004	2017-06-13 16:47:14.394+00	2017-06-13 16:47:14.394+00	\N	\N
1027	added-employment-1497372461561	Test land	\N	US	\N	9999-0000-0000-0004	2017-06-13 16:47:46.064+00	2017-06-13 16:47:46.064+00	\N	\N
\.


--
-- Data for Name: org_affiliation_relation; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY org_affiliation_relation (id, org_id, orcid, org_affiliation_relation_role, org_affiliation_relation_title, department, start_day, start_month, start_year, end_day, end_month, end_year, visibility, source_id, date_created, last_modified, client_source_id, url, external_ids_json) FROM stdin;
1069	1009	0000-0003-0814-7181	EDUCATION	role-title	department-name	1	1	2017	1	1	2018	PUBLIC	APP-9999999999999901	2017-02-17 17:57:14.63+00	2017-02-17 17:57:14.63+00	\N	\N	\N
1070	1009	0000-0003-0814-7181	EMPLOYMENT	role-title	department-name	1	1	2017	1	1	2018	PUBLIC	APP-9999999999999901	2017-02-17 17:57:14.631+00	2017-02-17 17:57:14.631+00	\N	\N	\N
1073	1011	9999-0000-0000-0004	EDUCATION	\N	\N	\N	\N	\N	\N	\N	\N	PUBLIC	9999-0000-0000-0004	2017-02-17 18:29:31.732+00	2017-02-17 18:29:31.732+00	\N	\N	\N
1074	1012	9999-0000-0000-0004	EDUCATION	\N	\N	\N	\N	\N	\N	\N	\N	PUBLIC	9999-0000-0000-0004	2017-02-17 20:10:54.558+00	2017-02-17 20:10:54.558+00	\N	\N	\N
1077	1009	0000-0001-5754-535X	EDUCATION	role-title	department-name	1	1	2017	1	1	2018	PUBLIC	APP-9999999999999901	2017-02-17 21:24:19.084+00	2017-02-17 21:24:19.084+00	\N	\N	\N
1078	1009	0000-0001-5754-535X	EMPLOYMENT	role-title	department-name	1	1	2017	1	1	2018	PUBLIC	APP-9999999999999901	2017-02-17 21:24:19.085+00	2017-02-17 21:24:19.085+00	\N	\N	\N
1132	1019	9999-0000-0000-000X	EDUCATION	\N	tech	\N	\N	\N	\N	\N	\N	PUBLIC	9999-0000-0000-000X	2017-05-03 15:47:43.677+00	2017-05-03 15:47:43.677+00	\N	\N	\N
1134	1009	0000-0002-4676-8168	EDUCATION	role-title	department-name	1	1	2017	1	1	2018	PUBLIC	APP-9999999999999901	2017-06-13 16:20:04.337+00	2017-06-13 16:20:04.337+00	\N	\N	\N
1135	1009	0000-0002-4676-8168	EMPLOYMENT	role-title	department-name	1	1	2017	1	1	2018	PUBLIC	APP-9999999999999901	2017-06-13 16:20:04.337+00	2017-06-13 16:20:04.337+00	\N	\N	\N
\.


--
-- Name: org_affiliation_relation_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('org_affiliation_relation_seq', 1210, true);


--
-- Data for Name: org_disambiguated; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY org_disambiguated (id, source_id, source_url, source_type, org_type, name, city, region, country, url, status, date_created, last_modified, indexing_status, last_indexed_date, popularity, source_parent_id) FROM stdin;
1007	H	http://orcid.org	TEST	\N	H affiliation	H town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:55.563987+00	0	\N
1008	I	http://orcid.org	TEST	\N	I affiliation	I town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:55.610766+00	0	\N
1009	J	http://orcid.org	TEST	\N	J affiliation	J town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:55.690403+00	0	\N
1010	K	http://orcid.org	TEST	\N	K affiliation	K town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:55.736095+00	0	\N
1011	L	http://orcid.org	TEST	\N	L affiliation	L town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:55.802666+00	0	\N
1012	M	http://orcid.org	TEST	\N	M affiliation	M town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:55.908486+00	0	\N
1013	N	http://orcid.org	TEST	\N	N affiliation	N town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:55.957768+00	0	\N
1000	A	http://orcid.org	TEST	\N	A affiliation	A town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:55.022811+00	0	\N
1001	B	http://orcid.org	TEST	\N	B affiliation	B town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:55.110354+00	0	\N
1002	C	http://orcid.org	TEST	\N	C affiliation	C town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:55.184084+00	0	\N
1003	D	http://orcid.org	TEST	\N	D affiliation	D town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:55.285288+00	0	\N
1004	E	http://orcid.org	TEST	\N	E affiliation	E town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:55.338979+00	0	\N
1005	F	http://orcid.org	TEST	\N	F affiliation	F town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:55.416835+00	0	\N
1006	G	http://orcid.org	TEST	\N	G affiliation	G town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:55.521386+00	0	\N
1014	O	http://orcid.org	TEST	\N	O affiliation	O town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:56.018993+00	0	\N
1015	P	http://orcid.org	TEST	\N	P affiliation	P town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:56.061562+00	0	\N
1016	Q	http://orcid.org	TEST	\N	Q affiliation	Q town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:56.205966+00	0	\N
1017	R	http://orcid.org	TEST	\N	R affiliation	R town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:56.242781+00	0	\N
1018	S	http://orcid.org	TEST	\N	S affiliation	S town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:56.32523+00	0	\N
1019	T	http://orcid.org	TEST	\N	T affiliation	T town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:56.420101+00	0	\N
1020	U	http://orcid.org	TEST	\N	U affiliation	U town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:56.476568+00	0	\N
1021	V	http://orcid.org	TEST	\N	V affiliation	V town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:56.548162+00	0	\N
1022	W	http://orcid.org	TEST	\N	W affiliation	W town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:56.580495+00	0	\N
1023	X	http://orcid.org	TEST	\N	X affiliation	X town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:56.626778+00	0	\N
1024	Y	http://orcid.org	TEST	\N	Y affiliation	Y town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:56.65777+00	0	\N
1025	Z	http://orcid.org	TEST	\N	Z affiliation	Z town	\N	BM	\N	\N	2017-01-17 22:39:52.839604+00	2017-01-17 22:39:52.839604+00	DONE	2017-01-20 00:55:56.722107+00	0	\N
\.


--
-- Data for Name: org_disambiguated_external_identifier; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY org_disambiguated_external_identifier (id, org_disambiguated_id, identifier, identifier_type, date_created, last_modified, preferred) FROM stdin;
\.


--
-- Name: org_disambiguated_external_identifier_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('org_disambiguated_external_identifier_seq', 1000, true);


--
-- Name: org_disambiguated_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('org_disambiguated_seq', 1026, true);


--
-- Name: org_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('org_seq', 1027, true);


--
-- Data for Name: other_name; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY other_name (other_name_id, date_created, last_modified, display_name, orcid, visibility, source_id, client_source_id, display_index) FROM stdin;
1006	2017-02-17 17:57:14.631	2017-02-17 17:57:14.631	Other 1	0000-0003-0814-7181	PRIVATE	\N	APP-9999999999999901	1
1007	2017-02-17 17:57:14.632	2017-02-17 17:57:14.632	Other 2	0000-0003-0814-7181	PRIVATE	\N	APP-9999999999999901	0
1008	2017-02-17 17:57:15.975	2017-02-17 17:57:15.975	other	0000-0003-0484-9215	PRIVATE	\N	APP-9999999999999901	0
1009	2017-02-17 21:16:39.421	2017-02-17 21:16:39.421	other	0000-0001-9790-3588	PRIVATE	\N	\N	0
1010	2017-02-17 21:24:19.085	2017-02-17 21:24:19.085	Other 1	0000-0001-5754-535X	PRIVATE	\N	APP-9999999999999901	1
1011	2017-02-17 21:24:19.085	2017-02-17 21:24:19.085	Other 2	0000-0001-5754-535X	PRIVATE	\N	APP-9999999999999901	0
1012	2017-02-17 21:24:21.785	2017-02-17 21:24:21.785	other	0000-0003-3224-7983	PRIVATE	\N	APP-9999999999999901	0
1024	2017-06-13 16:07:51.635	2017-06-13 16:07:51.635	other	0000-0003-0660-9960	PRIVATE	\N	APP-9999999999999901	0
1025	2017-06-13 16:17:10.526	2017-06-13 16:17:10.526	other	0000-0002-5200-4316	PRIVATE	\N	APP-9999999999999901	0
1026	2017-06-13 16:20:04.338	2017-06-13 16:20:04.338	Other 1	0000-0002-4676-8168	PRIVATE	\N	APP-9999999999999901	1
1027	2017-06-13 16:20:04.338	2017-06-13 16:20:04.338	Other 2	0000-0002-4676-8168	PRIVATE	\N	APP-9999999999999901	0
1028	2017-06-13 16:20:49.77	2017-06-13 16:20:49.77	other	0000-0001-7758-4663	PRIVATE	\N	APP-9999999999999901	0
\.


--
-- Name: other_name_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('other_name_seq', 1040, true);


--
-- Data for Name: patent; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY patent (patent_id, issuing_country, patent_no, short_description, issue_date, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: patent_contributor; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY patent_contributor (patent_contributor_id, orcid, patent_id, credit_name, contributor_role, contributor_sequence, contributor_email, date_created, last_modified) FROM stdin;
\.


--
-- Name: patent_contributor_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('patent_contributor_seq', 1000, true);


--
-- Name: patent_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('patent_seq', 1000, true);


--
-- Data for Name: patent_source; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY patent_source (orcid, patent_id, source_orcid, deposited_date, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: peer_review; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY peer_review (id, orcid, peer_review_subject_id, external_identifiers_json, org_id, peer_review_role, peer_review_type, completion_day, completion_month, completion_year, source_id, url, visibility, client_source_id, date_created, last_modified, display_index, subject_external_identifiers_json, subject_type, subject_container_name, subject_name, subject_translated_name, subject_translated_name_language_code, subject_url, group_id) FROM stdin;
\.


--
-- Name: peer_review_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('peer_review_seq', 1145, true);


--
-- Data for Name: peer_review_subject; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY peer_review_subject (id, external_identifiers_json, title, work_type, sub_title, translated_title, translated_title_language_code, url, journal_title, date_created, last_modified) FROM stdin;
\.


--
-- Name: peer_review_subject_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('peer_review_subject_seq', 1000, false);


--
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY profile (orcid, date_created, last_modified, account_expiry, account_non_locked, completed_date, claimed, creation_method, credentials_expiry, credit_name, enabled, encrypted_password, encrypted_security_answer, encrypted_verification_code, family_name, given_names, is_selectable_sponsor, send_change_notifications, send_orcid_news, biography, vocative_name, security_question_id, source_id, non_locked, biography_visibility, keywords_visibility, external_identifiers_visibility, researcher_urls_visibility, other_names_visibility, orcid_type, group_orcid, submission_date, indexing_status, names_visibility, iso2_country, profile_address_visibility, profile_deactivation_date, activities_visibility_default, last_indexed_date, locale, client_type, group_type, primary_record, deprecated_date, referred_by, enable_developer_tools, send_email_frequency_days, enable_notifications, send_orcid_feature_announcements, send_member_update_requests, salesforce_id, client_source_id, developer_tools_enabled_date, record_locked, used_captcha_on_registration, user_last_ip, reviewed, send_administrative_change_notifications, reason_locked, reason_locked_description, hashed_orcid, last_login, secret_for_2fa, using_2fa) FROM stdin;
0000-0001-9790-3588	2017-02-17 21:16:39.41	2017-02-17 21:16:39.41	\N	t	\N	f	API	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	PRIVATE	PRIVATE	PRIVATE	PRIVATE	PRIVATE	USER	\N	2017-02-17 21:16:39.389+00	PENDING	PRIVATE	\N	PRIVATE	\N	PRIVATE	\N	EN	\N	\N	\N	\N	\N	f	0	t	\N	\N	\N	\N	\N	f	f	\N	f	\N	\N	\N	\N	\N	\N	f
0000-0003-0814-7181	2017-02-17 17:57:14.626	2017-02-17 17:57:14.626	\N	t	\N	f	API	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	PRIVATE	PRIVATE	PRIVATE	PRIVATE	PRIVATE	USER	\N	2017-02-17 17:57:14.523+00	PENDING	PRIVATE	\N	PRIVATE	\N	PRIVATE	\N	EN	\N	\N	\N	\N	\N	f	0	t	\N	\N	\N	APP-9999999999999901	\N	f	f	\N	f	\N	\N	\N	\N	\N	\N	f
0000-0001-5754-535X	2017-02-17 21:24:19.081	2017-02-17 21:24:19.081	\N	t	\N	f	API	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	PRIVATE	PRIVATE	PRIVATE	PRIVATE	PRIVATE	USER	\N	2017-02-17 21:24:18.99+00	PENDING	PRIVATE	\N	PRIVATE	\N	PRIVATE	\N	EN	\N	\N	\N	\N	\N	f	0	t	\N	\N	\N	APP-9999999999999901	\N	f	f	\N	f	\N	\N	\N	\N	\N	\N	f
0000-0003-0484-9215	2017-02-17 17:57:15.97	2017-02-17 17:57:15.97	\N	t	\N	f	API	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	PRIVATE	PRIVATE	PRIVATE	PRIVATE	PRIVATE	USER	\N	2017-02-17 17:57:15.955+00	PENDING	PRIVATE	\N	PRIVATE	\N	PRIVATE	\N	EN	\N	\N	\N	\N	\N	f	0	t	\N	\N	\N	APP-9999999999999901	\N	f	f	\N	f	\N	\N	\N	\N	\N	\N	f
0000-0003-3224-7983	2017-02-17 21:24:21.783	2017-02-17 21:24:21.783	\N	t	\N	f	API	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	PRIVATE	PRIVATE	PRIVATE	PRIVATE	PRIVATE	USER	\N	2017-02-17 21:24:21.771+00	PENDING	PRIVATE	\N	PRIVATE	\N	PRIVATE	\N	EN	\N	\N	\N	\N	\N	f	0	t	\N	\N	\N	APP-9999999999999901	\N	f	f	\N	f	\N	\N	\N	\N	\N	\N	f
9999-0000-0000-000X	2017-01-18 21:10:39.503	2017-06-13 16:41:14.597714	\N	t	\N	t	integration-test	\N	\N	t	rFnd4v6CjLrswMsdpYYgNERDa2InwQALKb0AxAaUT+Cta/UUXeh6Oym6Pk5zR9hTdFHaq4ogtPGuIyhs7w3F022ARahO3bwG9oeMcCjv+q0=	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	t	PRIVATE	PRIVATE	PRIVATE	PRIVATE	PRIVATE	ADMIN	\N	2017-01-18 21:10:38.652+00	PENDING	PRIVATE	\N	PRIVATE	\N	PUBLIC	2017-02-17 16:54:38.447591+00	EN	\N	\N	\N	\N	\N	t	1	t	\N	t	\N	\N	\N	f	f	10.0.2.2	f	t	\N	\N	\N	2017-06-13 16:41:14.596583	\N	f
0000-0003-0660-9960	2017-06-13 16:07:51.584	2017-06-13 16:07:51.584	\N	t	\N	f	API	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	PRIVATE	PRIVATE	PRIVATE	PRIVATE	PRIVATE	USER	\N	2017-06-13 16:07:51.53+00	PENDING	PRIVATE	\N	PRIVATE	\N	PRIVATE	\N	EN	\N	\N	\N	\N	\N	f	0	t	\N	\N	\N	APP-9999999999999901	\N	f	f	\N	f	\N	\N	\N	e18cf6a0f9d620bd7b6ecdd183fb49f76b2c3b298b84a08d9bd86a824652ca96	\N	\N	f
9999-0000-0000-0001	2017-01-18 21:10:40.952	2017-06-13 16:41:17.171538	\N	t	\N	t	integration-test	\N	\N	t	xyikGsZC2YRINeApWJBuQ/dBBhUEGm0mEWD4st8+egDSZnRU1mSQK1bbbd1lIXRJwou24+ZAvXc3KurKW+H5R/ZHYNxbBdHVN+bB3Ccp80M=	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	t	PRIVATE	PRIVATE	PRIVATE	PRIVATE	PRIVATE	GROUP	\N	2017-01-18 21:10:40.672+00	REINDEX	PRIVATE	\N	PRIVATE	\N	PUBLIC	2017-02-17 16:54:38.44652+00	EN	\N	PREMIUM_INSTITUTION	\N	\N	\N	t	1	t	\N	t	\N	\N	\N	f	f	\N	f	t	\N	\N	\N	\N	\N	f
0000-0001-7758-4663	2017-06-13 16:20:49.768	2017-06-13 16:20:49.768	\N	t	\N	f	API	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	PRIVATE	PRIVATE	PRIVATE	PRIVATE	PRIVATE	USER	\N	2017-06-13 16:20:49.758+00	PENDING	PRIVATE	\N	PRIVATE	\N	PRIVATE	\N	EN	\N	\N	\N	\N	\N	f	0	t	\N	\N	\N	APP-9999999999999901	\N	f	f	\N	f	\N	\N	\N	1a5cca51cfc142f1f7a3b48ed95a556e0e38a19e5dbad8d092b3b08bf0f17a7d	\N	\N	f
0000-0002-5200-4316	2017-06-13 16:17:10.521	2017-06-13 16:17:10.521	\N	t	\N	f	API	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	PRIVATE	PRIVATE	PRIVATE	PRIVATE	PRIVATE	USER	\N	2017-06-13 16:17:10.502+00	PENDING	PRIVATE	\N	PRIVATE	\N	PRIVATE	\N	EN	\N	\N	\N	\N	\N	f	0	t	\N	\N	\N	APP-9999999999999901	\N	f	f	\N	f	\N	\N	\N	470fe8fb9b4098a1dede658f6728cacdf84ccd355d809b8e9fed7bc43d16e6a2	\N	\N	f
9999-0000-0000-0005	2017-01-18 21:10:40.613	2017-06-13 16:42:04.231074	\N	t	\N	t	integration-test	\N	\N	t	uYFcy7hUo0u6+4jzZxB6jHFGuLkIh63nBwO+D/fblApwOKAOGc6a+cHK18CeeNl9SNX8GMxZcnMFOPAu2jzMIRNLaEzkljfdCsmEPqacMBo=	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	t	PRIVATE	PRIVATE	PRIVATE	PRIVATE	PRIVATE	USER	\N	2017-01-18 21:10:40.454+00	PENDING	PRIVATE	\N	PRIVATE	\N	PUBLIC	2017-02-17 16:54:38.446237+00	EN	\N	\N	\N	\N	\N	t	1	t	\N	t	\N	\N	\N	f	f	10.0.2.2	f	t	\N	\N	\N	2017-06-13 16:42:04.229963	\N	f
0000-0002-4676-8168	2017-06-13 16:20:04.334	2017-06-13 16:20:04.334	\N	t	\N	f	API	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	PRIVATE	PRIVATE	PRIVATE	PRIVATE	PRIVATE	USER	\N	2017-06-13 16:20:04.29+00	PENDING	PRIVATE	\N	PRIVATE	\N	PRIVATE	\N	EN	\N	\N	\N	\N	\N	f	0	t	\N	\N	\N	APP-9999999999999901	\N	f	f	\N	f	\N	\N	\N	bc560da32a3260c1580f2a7f27fe16714baa61aefbf60182e502648021351c8e	\N	\N	f
9999-0000-0000-0004	2017-01-18 21:10:40.25	2017-12-01 18:04:42.082572	\N	t	\N	t	integration-test	\N	\N	t	S8xRjV+I8u9gYr25tH/PyuCc+xgYujJaGmyhUzwz6cfg7xojF4q+bAgKEnMTL9ISScWmccetA5//aJyTLIqLE3yl8XyVO1EVQqPy8eUI87Q=	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	t	PRIVATE	PRIVATE	PRIVATE	PRIVATE	PRIVATE	USER	\N	2017-01-18 21:10:39.999+00	PENDING	PRIVATE	\N	PRIVATE	\N	PUBLIC	2017-02-17 17:02:39.109925+00	EN	\N	\N	\N	\N	\N	t	1	t	\N	t	\N	\N	2017-01-18 21:10:40.3388+00	f	f	10.0.2.2	f	t	\N	\N	\N	2017-12-01 18:04:42.055228	\N	f
\.


--
-- Data for Name: profile_event; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY profile_event (id, date_created, last_modified, orcid, profile_event_type, comment) FROM stdin;
\.


--
-- Name: profile_event_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('profile_event_seq', 1000, true);


--
-- Data for Name: profile_funding; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY profile_funding (id, org_id, orcid, title, type, currency_code, translated_title, translated_title_language_code, description, start_day, start_month, start_year, end_day, end_month, end_year, url, contributors_json, visibility, source_id, date_created, last_modified, organization_defined_type, numeric_amount, display_index, client_source_id, external_identifiers_json) FROM stdin;
1051	1009	0000-0003-0814-7181	title	GRANT	USD	\N	\N	short-description	1	1	2017	1	1	2018	http://orcid.org	{"contributor":[{"contributorOrcid":null,"creditName":{"content":"credit-name","visibility":"PUBLIC"},"contributorEmail":{"value":"test@test.orcid.org"},"contributorAttributes":{"contributorRole":"LEAD"}}]}	PUBLIC	APP-9999999999999901	2017-02-17 17:57:14.632+00	2017-02-17 17:57:14.632+00	organization-defined-type	1000	0	\N	{"fundingExternalIdentifier":[{"type":"GRANT_NUMBER","value":"funding-external-identifier-value","url":{"value":"http://orcid.org"},"relationship":"SELF"}]}
1055	1009	0000-0001-5754-535X	title	GRANT	USD	\N	\N	short-description	1	1	2017	1	1	2018	http://orcid.org	{"contributor":[{"contributorOrcid":null,"creditName":{"content":"credit-name","visibility":"PUBLIC"},"contributorEmail":{"value":"test@test.orcid.org"},"contributorAttributes":{"contributorRole":"LEAD"}}]}	PUBLIC	APP-9999999999999901	2017-02-17 21:24:19.086+00	2017-02-17 21:24:19.086+00	organization-defined-type	1000	0	\N	{"fundingExternalIdentifier":[{"type":"GRANT_NUMBER","value":"funding-external-identifier-value","url":{"value":"http://orcid.org"},"relationship":"SELF"}]}
1101	1009	0000-0002-4676-8168	title	GRANT	USD	\N	\N	short-description	1	1	2017	1	1	2018	http://orcid.org	{"contributor":[{"contributorOrcid":null,"creditName":{"content":"credit-name","visibility":"PUBLIC"},"contributorEmail":{"value":"test@test.orcid.org"},"contributorAttributes":{"contributorRole":"LEAD"}}]}	PUBLIC	APP-9999999999999901	2017-06-13 16:20:04.339+00	2017-06-13 16:20:04.339+00	organization-defined-type	1000	0	\N	{"fundingExternalIdentifier":[{"type":"GRANT_NUMBER","value":"funding-external-identifier-value","url":{"value":"http://orcid.org"},"relationship":"SELF"}]}
\.


--
-- Name: profile_funding_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('profile_funding_seq', 1156, true);


--
-- Data for Name: profile_keyword; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY profile_keyword (profile_orcid, keywords_name, date_created, last_modified, id, visibility, source_id, client_source_id, display_index) FROM stdin;
0000-0003-0814-7181	Advanced Tea Making	2017-02-17 17:57:14.629	2017-02-17 17:57:14.629	1005	PRIVATE	\N	APP-9999999999999901	0
0000-0003-0814-7181	Pavement Studies	2017-02-17 17:57:14.63	2017-02-17 17:57:14.63	1006	PRIVATE	\N	APP-9999999999999901	1
0000-0003-0484-9215	K1	2017-02-17 17:57:15.974	2017-02-17 17:57:15.974	1007	PRIVATE	\N	APP-9999999999999901	0
0000-0001-9790-3588	K1	2017-02-17 21:16:39.42	2017-02-17 21:16:39.42	1008	PRIVATE	\N	\N	0
0000-0001-5754-535X	Advanced Tea Making	2017-02-17 21:24:19.083	2017-02-17 21:24:19.083	1009	PRIVATE	\N	APP-9999999999999901	0
0000-0001-5754-535X	Pavement Studies	2017-02-17 21:24:19.084	2017-02-17 21:24:19.084	1010	PRIVATE	\N	APP-9999999999999901	1
0000-0003-3224-7983	K1	2017-02-17 21:24:21.784	2017-02-17 21:24:21.784	1011	PRIVATE	\N	APP-9999999999999901	0
0000-0003-0660-9960	K1	2017-06-13 16:07:51.633	2017-06-13 16:07:51.633	1021	PRIVATE	\N	APP-9999999999999901	0
0000-0002-5200-4316	K1	2017-06-13 16:17:10.525	2017-06-13 16:17:10.525	1022	PRIVATE	\N	APP-9999999999999901	0
0000-0002-4676-8168	Advanced Tea Making	2017-06-13 16:20:04.336	2017-06-13 16:20:04.336	1023	PRIVATE	\N	APP-9999999999999901	0
0000-0002-4676-8168	Pavement Studies	2017-06-13 16:20:04.337	2017-06-13 16:20:04.337	1024	PRIVATE	\N	APP-9999999999999901	1
0000-0001-7758-4663	K1	2017-06-13 16:20:49.77	2017-06-13 16:20:49.77	1025	PRIVATE	\N	APP-9999999999999901	0
\.


--
-- Data for Name: profile_patent; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY profile_patent (orcid, patent_id, added_to_profile_date, visibility, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: profile_subject; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY profile_subject (profile_orcid, subjects_name) FROM stdin;
\.


--
-- Data for Name: record_name; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY record_name (id, orcid, credit_name, family_name, given_names, visibility, date_created, last_modified) FROM stdin;
1000	9999-0000-0000-000X	Credit name	Family names	Given name	PUBLIC	2017-01-18 21:10:39.594+00	2017-02-17 16:54:02.538446+00
1002	9999-0000-0000-0005	User Two Credit name	Two	User	PUBLIC	2017-01-18 21:10:40.617+00	2017-02-17 16:54:12.688876+00
1003	9999-0000-0000-0001	Orcid's Test Member	\N	\N	PUBLIC	2017-01-18 21:10:40.953+00	2017-02-17 16:54:13.634833+00
1009	0000-0003-0814-7181	credit name	family name	given names	PUBLIC	2017-02-17 17:57:14.634+00	2017-02-17 17:57:14.634+00
1010	0000-0003-0484-9215	credit	family	given	PUBLIC	2017-02-17 17:57:15.977+00	2017-02-17 17:57:15.977+00
1011	0000-0001-9790-3588	credit	family	given	PUBLIC	2017-02-17 21:16:39.422+00	2017-02-17 21:16:39.422+00
1012	0000-0001-5754-535X	credit name	family name	given names	PUBLIC	2017-02-17 21:24:19.088+00	2017-02-17 21:24:19.088+00
1013	0000-0003-3224-7983	credit	family	given	PUBLIC	2017-02-17 21:24:21.786+00	2017-02-17 21:24:21.786+00
1014	0000-0003-0660-9960	credit	family	given	PUBLIC	2017-06-13 16:07:51.648+00	2017-06-13 16:07:51.648+00
1015	0000-0002-5200-4316	credit	family	given	PUBLIC	2017-06-13 16:17:10.528+00	2017-06-13 16:17:10.528+00
1016	0000-0002-4676-8168	credit name	family name	given names	PUBLIC	2017-06-13 16:20:04.34+00	2017-06-13 16:20:04.34+00
1017	0000-0001-7758-4663	credit	family	given	PUBLIC	2017-06-13 16:20:49.771+00	2017-06-13 16:20:49.771+00
1001	9999-0000-0000-0004	User One Credit name	One	User	PUBLIC	2017-01-18 21:10:40.252+00	2017-06-13 16:36:17.387911+00
\.


--
-- Name: record_name_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('record_name_seq', 1017, true);


--
-- Data for Name: reference_data; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY reference_data (id, date_created, last_modified, ref_data_key, ref_data_value) FROM stdin;
0	2017-01-17 22:39:44.902929	2017-01-17 22:39:44.902929	emailVerificationURL	http://localhost:8080/orcid-frontend-web
\.


--
-- Name: reference_data_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('reference_data_seq', 1000, true);


--
-- Name: related_url_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('related_url_seq', 1000, true);


--
-- Data for Name: researcher_url; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY researcher_url (url, date_created, last_modified, orcid, id, url_name, visibility, source_id, client_source_id, display_index) FROM stdin;
http://www.vvs.com	2017-02-17 17:57:14.633	2017-02-17 17:57:14.633	0000-0003-0814-7181	1006	\N	PRIVATE	\N	APP-9999999999999901	0
http://www.wjrs.co.uk	2017-02-17 17:57:14.633	2017-02-17 17:57:14.633	0000-0003-0814-7181	1007	\N	PRIVATE	\N	APP-9999999999999901	1
http://www.site.com	2017-02-17 17:57:15.976	2017-02-17 17:57:15.976	0000-0003-0484-9215	1008	The site	PRIVATE	\N	APP-9999999999999901	0
http://www.site.com	2017-02-17 21:16:39.421	2017-02-17 21:16:39.421	0000-0001-9790-3588	1009	The site	PRIVATE	\N	\N	0
http://www.vvs.com	2017-02-17 21:24:19.086	2017-02-17 21:24:19.086	0000-0001-5754-535X	1010	\N	PRIVATE	\N	APP-9999999999999901	0
http://www.wjrs.co.uk	2017-02-17 21:24:19.086	2017-02-17 21:24:19.086	0000-0001-5754-535X	1011	\N	PRIVATE	\N	APP-9999999999999901	1
http://www.site.com	2017-02-17 21:24:21.785	2017-02-17 21:24:21.785	0000-0003-3224-7983	1012	The site	PRIVATE	\N	APP-9999999999999901	0
http://www.site.com	2017-06-13 16:07:51.641	2017-06-13 16:07:51.641	0000-0003-0660-9960	1033	The site	PRIVATE	\N	APP-9999999999999901	0
http://www.site.com	2017-06-13 16:17:10.526	2017-06-13 16:17:10.526	0000-0002-5200-4316	1034	The site	PRIVATE	\N	APP-9999999999999901	0
http://www.vvs.com	2017-06-13 16:20:04.339	2017-06-13 16:20:04.339	0000-0002-4676-8168	1035	\N	PRIVATE	\N	APP-9999999999999901	0
http://www.wjrs.co.uk	2017-06-13 16:20:04.339	2017-06-13 16:20:04.339	0000-0002-4676-8168	1036	\N	PRIVATE	\N	APP-9999999999999901	1
http://www.site.com	2017-06-13 16:20:49.771	2017-06-13 16:20:49.771	0000-0001-7758-4663	1037	The site	PRIVATE	\N	APP-9999999999999901	0
http://test.orcid.org/1497372277577	2017-06-13 16:44:43.15	2017-06-13 16:45:04.518	9999-0000-0000-0004	1061	\N	PUBLIC	9999-0000-0000-0004	\N	1
\.


--
-- Name: researcher_url_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('researcher_url_seq', 1061, true);


--
-- Data for Name: salesforce_connection; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY salesforce_connection (id, date_created, last_modified, orcid, email, salesforce_account_id, is_primary) FROM stdin;
\.


--
-- Name: salesforce_connection_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('salesforce_connection_seq', 1, false);


--
-- Data for Name: security_question; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY security_question (id, date_created, last_modified, question, key) FROM stdin;
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

COPY shibboleth_account (id, date_created, last_modified, orcid, remote_user, shib_identity_provider) FROM stdin;
\.


--
-- Name: shibboleth_account_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('shibboleth_account_seq', 1, false);


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY subject (name, date_created, last_modified) FROM stdin;
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

COPY userconnection (userid, email, orcid, providerid, provideruserid, rank, displayname, profileurl, imageurl, accesstoken, secret, refreshtoken, expiretime, is_linked, last_login, date_created, last_modified, id_type, status, headers_json) FROM stdin;
7920331415506877543	\N	9999-0000-0000-0004	https://integrationtest.orcid.org/idp/shibboleth	integration-test-1484879698058@orcid.org	1	integration-test-1484879698058@orcid.org	http://localhost:8080/orcid-web/9999-0000-0000-0004	\N	\N	\N	\N	\N	t	2017-01-20 02:35:11.12+00	2017-01-20 02:35:11.123+00	2017-01-20 02:35:11.123+00	persistent-id	NOTIFIED	{"referer":"https://localhost:8443/orcid-web/shibboleth/signin","content-length":"48","accept-language":"en-US,en;q=0.5","cookie":"JSESSIONID=89AB6A35F8671E4C5B1249AB26E66BA7; __uvt=; uvts=5YSoEih92JGeAN0Q","accept":"application/json, text/javascript, */*; q=0.01","persistent-id":"integration-test-1484879698058@orcid.org","host":"localhost:8443","x-requested-with":"XMLHttpRequest","shib-identity-provider":"https://integrationtest.orcid.org/idp/shibboleth","content-type":"application/x-www-form-urlencoded; charset=UTF-8","x-csrf-token":"88a8f95a-5c33-4ae7-9521-494c49e19ffc","connection":"keep-alive","accept-encoding":"gzip, deflate, br","user-agent":"Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0"}
3086123884965214798	\N	9999-0000-0000-0004	https://integrationtest.orcid.org/idp/shibboleth	integration-test-1487356289657@orcid.org	1	integration-test-1487356289657@orcid.org	http://localhost:8080/orcid-web/9999-0000-0000-0004	\N	\N	\N	\N	\N	t	2017-02-17 18:31:40.21+00	2017-02-17 18:31:40.276+00	2017-02-17 18:31:40.276+00	persistent-id	NOTIFIED	{"referer":"https://localhost:8443/orcid-web/shibboleth/signin","content-length":"48","accept-language":"en-US,en;q=0.5","cookie":"JSESSIONID=911E4FA6F98337E8EA7F4F0E7DC452E5; __uvt=; uvts=5fetOhwBUGoclFnq","accept":"application/json, text/javascript, */*; q=0.01","persistent-id":"integration-test-1487356289657@orcid.org","host":"localhost:8443","x-requested-with":"XMLHttpRequest","shib-identity-provider":"https://integrationtest.orcid.org/idp/shibboleth","content-type":"application/x-www-form-urlencoded; charset=UTF-8","x-csrf-token":"3c1aa917-8caf-4c2d-9762-67a813c8ab0d","connection":"keep-alive","accept-encoding":"gzip, deflate, br","user-agent":"Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0"}
82935813956647713	\N	9999-0000-0000-0004	https://integrationtest.orcid.org/idp/shibboleth	integration-test-1487368446933@orcid.org	1	integration-test-1487368446933@orcid.org	http://localhost:8080/orcid-web/9999-0000-0000-0004	\N	\N	\N	\N	\N	t	2017-02-17 21:54:17.071+00	2017-02-17 21:54:17.074+00	2017-02-17 21:54:17.074+00	persistent-id	NOTIFIED	{"referer":"https://localhost:8443/orcid-web/shibboleth/signin","content-length":"48","accept-language":"en-US,en;q=0.5","cookie":"JSESSIONID=9450C8D57B338B9A754C61CD060C1991; __uvt=; uvts=5fh59rJPSBPw3D72","accept":"application/json, text/javascript, */*; q=0.01","persistent-id":"integration-test-1487368446933@orcid.org","host":"localhost:8443","x-requested-with":"XMLHttpRequest","shib-identity-provider":"https://integrationtest.orcid.org/idp/shibboleth","content-type":"application/x-www-form-urlencoded; charset=UTF-8","x-csrf-token":"57a7c0d5-c206-48ff-9873-294267eaaabf","connection":"keep-alive","accept-encoding":"gzip, deflate, br","user-agent":"Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0"}
4029303602840839821	\N	9999-0000-0000-0004	https://integrationtest.orcid.org/idp/shibboleth	integration-test-1497372553372@orcid.org	1	integration-test-1497372553372@orcid.org	http://localhost:8080/orcid-web/9999-0000-0000-0004	\N	\N	\N	\N	\N	t	2017-06-13 16:49:24.367+00	2017-06-13 16:49:21.672+00	2017-06-13 16:49:24.367+00	persistent-id	NOTIFIED	{"referer":"https://localhost:8443/orcid-web/shibboleth/signin","content-length":"48","accept-language":"en-US,en;q=0.5","cookie":"JSESSIONID=97AABECE4624D00953D522AAB9B69D9F; __uvt=; uvts=68l00C6s36yNTtMR","accept":"application/json, text/javascript, */*; q=0.01","persistent-id":"integration-test-1497372553372@orcid.org","host":"localhost:8443","x-requested-with":"XMLHttpRequest","shib-identity-provider":"https://integrationtest.orcid.org/idp/shibboleth","content-type":"application/x-www-form-urlencoded; charset=UTF-8","x-csrf-token":"072cbfd1-ef37-4a17-a926-0e233788b91d","connection":"keep-alive","accept-encoding":"gzip, deflate, br","user-agent":"Mozilla/5.0 (X11; Linux x86_64; rv:46.0) Gecko/20100101 Firefox/46.0"}
\.


--
-- Data for Name: webhook; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY webhook (orcid, client_details_id, uri, date_created, last_modified, last_failed, failed_attempt_count, enabled, disabled_date, disabled_comments, last_sent, profile_last_modified) FROM stdin;
\.


--
-- Data for Name: work; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY work (work_id, date_created, last_modified, publication_day, publication_month, publication_year, title, subtitle, description, work_url, citation, work_type, citation_type, contributors_json, journal_title, language_code, translated_title, translated_title_language_code, iso2_country, external_ids_json, orcid, added_to_profile_date, visibility, display_index, source_id, client_source_id) FROM stdin;
1121	2017-02-17 17:57:14.633	2017-02-17 17:57:14.633	1	1	2017	title	subtitle	description	http://orcid.org	citation	BOOK	FORMATTED_UNSPECIFIED	{"contributor":[{"contributorOrcid":null,"creditName":{"content":"credit-name","visibility":null},"contributorEmail":{"value":"contributor@test.orcid.org"},"contributorAttributes":{"contributorSequence":"FIRST","contributorRole":"AUTHOR"}}]}	journal title	en	\N	\N	US	{"workExternalIdentifier":[{"relationship":"SELF","url":null,"workExternalIdentifierType":"DOI","workExternalIdentifierId":{"content":"10.5555/12345ABCDE"}}]}	0000-0003-0814-7181	2017-02-17 17:57:14.625	PUBLIC	0	\N	APP-9999999999999901
1208	2017-02-17 21:24:19.087	2017-02-17 21:24:19.087	1	1	2017	title	subtitle	description	http://orcid.org	citation	BOOK	FORMATTED_UNSPECIFIED	{"contributor":[{"contributorOrcid":null,"creditName":{"content":"credit-name","visibility":null},"contributorEmail":{"value":"contributor@test.orcid.org"},"contributorAttributes":{"contributorSequence":"FIRST","contributorRole":"AUTHOR"}}]}	journal title	en	\N	\N	US	{"workExternalIdentifier":[{"relationship":"SELF","url":null,"workExternalIdentifierType":"DOI","workExternalIdentifierId":{"content":"10.5555/12345ABCDE"}}]}	0000-0001-5754-535X	2017-02-17 21:24:19.08	PUBLIC	0	\N	APP-9999999999999901
1328	2017-06-13 16:20:04.34	2017-06-13 16:20:04.34	1	1	2017	title	subtitle	description	http://orcid.org	citation	BOOK	FORMATTED_UNSPECIFIED	{"contributor":[{"contributorOrcid":null,"creditName":{"content":"credit-name","visibility":null},"contributorEmail":{"value":"contributor@test.orcid.org"},"contributorAttributes":{"contributorSequence":"FIRST","contributorRole":"AUTHOR"}}]}	journal title	en	\N	\N	US	{"workExternalIdentifier":[{"relationship":"SELF","url":null,"workExternalIdentifierType":"DOI","workExternalIdentifierId":{"content":"10.5555/12345ABCDE"}}]}	0000-0002-4676-8168	2017-06-13 16:20:04.333	PUBLIC	0	\N	APP-9999999999999901
\.


--
-- Name: work_contributor_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('work_contributor_seq', 1000, true);


--
-- Name: work_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('work_seq', 1477, true);


--
-- Name: address_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: backup_code_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY backup_code
    ADD CONSTRAINT backup_code_pkey PRIMARY KEY (id);


--
-- Name: biography_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY biography
    ADD CONSTRAINT biography_pkey PRIMARY KEY (id);


--
-- Name: client_authorised_grant_type_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY client_authorised_grant_type
    ADD CONSTRAINT client_authorised_grant_type_pkey PRIMARY KEY (client_details_id, grant_type);


--
-- Name: client_details_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY client_details
    ADD CONSTRAINT client_details_pkey PRIMARY KEY (client_details_id);


--
-- Name: client_granted_authority_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY client_granted_authority
    ADD CONSTRAINT client_granted_authority_pkey PRIMARY KEY (client_details_id, granted_authority);


--
-- Name: client_redirect_uri_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY client_redirect_uri
    ADD CONSTRAINT client_redirect_uri_pkey PRIMARY KEY (client_details_id, redirect_uri, redirect_uri_type);


--
-- Name: client_resource_id_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY client_resource_id
    ADD CONSTRAINT client_resource_id_pkey PRIMARY KEY (client_details_id, resource_id);


--
-- Name: client_scope_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY client_scope
    ADD CONSTRAINT client_scope_pkey PRIMARY KEY (client_details_id, scope_type);


--
-- Name: client_secret_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY client_secret
    ADD CONSTRAINT client_secret_pk PRIMARY KEY (client_details_id, client_secret);


--
-- Name: country_id_id_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY country_reference_data
    ADD CONSTRAINT country_id_id_pkey PRIMARY KEY (country_iso_code);


--
-- Name: email_event_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY email_event
    ADD CONSTRAINT email_event_pkey PRIMARY KEY (id);


--
-- Name: email_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY email
    ADD CONSTRAINT email_pk PRIMARY KEY (email);


--
-- Name: external_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY external_identifier
    ADD CONSTRAINT external_identifier_pkey PRIMARY KEY (id);


--
-- Name: funding_external_identifier_constraints; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY funding_external_identifier
    ADD CONSTRAINT funding_external_identifier_constraints UNIQUE (profile_funding_id, ext_type, ext_value, ext_url);


--
-- Name: funding_external_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY funding_external_identifier
    ADD CONSTRAINT funding_external_identifier_pkey PRIMARY KEY (funding_external_identifier_id);


--
-- Name: given_permission_to_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY given_permission_to
    ADD CONSTRAINT given_permission_to_pkey PRIMARY KEY (given_permission_to_id);


--
-- Name: granted_authority_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY granted_authority
    ADD CONSTRAINT granted_authority_pkey PRIMARY KEY (authority, orcid);


--
-- Name: group_id_record_group_id_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY group_id_record
    ADD CONSTRAINT group_id_record_group_id_key UNIQUE (group_id);


--
-- Name: group_id_record_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY group_id_record
    ADD CONSTRAINT group_id_record_pkey PRIMARY KEY (id);


--
-- Name: identifier_type_id_name_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY identifier_type
    ADD CONSTRAINT identifier_type_id_name_key UNIQUE (id_name);


--
-- Name: identifier_type_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY identifier_type
    ADD CONSTRAINT identifier_type_pkey PRIMARY KEY (id);


--
-- Name: identity_provider_name_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY identity_provider_name
    ADD CONSTRAINT identity_provider_name_pkey PRIMARY KEY (id);


--
-- Name: identity_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY identity_provider
    ADD CONSTRAINT identity_provider_pkey PRIMARY KEY (id);


--
-- Name: identity_provider_providerid_unique; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY identity_provider
    ADD CONSTRAINT identity_provider_providerid_unique UNIQUE (providerid);


--
-- Name: institution_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY institution
    ADD CONSTRAINT institution_pkey PRIMARY KEY (id);


--
-- Name: internal_sso_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY internal_sso
    ADD CONSTRAINT internal_sso_pkey PRIMARY KEY (orcid);


--
-- Name: invalid_record_data_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY invalid_record_data_changes
    ADD CONSTRAINT invalid_record_data_changes_pkey PRIMARY KEY (id);


--
-- Name: notification_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY notification_item
    ADD CONSTRAINT notification_activity_pkey PRIMARY KEY (id);


--
-- Name: notification_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: notification_work_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY notification_work
    ADD CONSTRAINT notification_work_pkey PRIMARY KEY (notification_id, work_id);


--
-- Name: oauth2_authoriziation_code_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY oauth2_authoriziation_code_detail
    ADD CONSTRAINT oauth2_authoriziation_code_detail_pkey PRIMARY KEY (authoriziation_code_value);


--
-- Name: oauth2_token_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY oauth2_token_detail
    ADD CONSTRAINT oauth2_token_detail_pkey PRIMARY KEY (id);


--
-- Name: oauth2_token_detail_refresh_token_value_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY oauth2_token_detail
    ADD CONSTRAINT oauth2_token_detail_refresh_token_value_key UNIQUE (refresh_token_value);


--
-- Name: orcidoauth2authoriziationcodedetail_authorities_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY orcidoauth2authoriziationcodedetail_authorities
    ADD CONSTRAINT orcidoauth2authoriziationcodedetail_authorities_pkey PRIMARY KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value, authorities);


--
-- Name: orcidoauth2authoriziationcodedetail_resourceids_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY orcidoauth2authoriziationcodedetail_resourceids
    ADD CONSTRAINT orcidoauth2authoriziationcodedetail_resourceids_pkey PRIMARY KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value, resourceids);


--
-- Name: orcidoauth2authoriziationcodedetail_scopes_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY orcidoauth2authoriziationcodedetail_scopes
    ADD CONSTRAINT orcidoauth2authoriziationcodedetail_scopes_pkey PRIMARY KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value, scopes);


--
-- Name: org_affiliation_relation_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY org_affiliation_relation
    ADD CONSTRAINT org_affiliation_relation_pkey PRIMARY KEY (id);


--
-- Name: org_disambiguated_external_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY org_disambiguated_external_identifier
    ADD CONSTRAINT org_disambiguated_external_identifier_pkey PRIMARY KEY (id);


--
-- Name: org_disambiguated_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY org_disambiguated
    ADD CONSTRAINT org_disambiguated_pkey PRIMARY KEY (id);


--
-- Name: org_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY org
    ADD CONSTRAINT org_pkey PRIMARY KEY (id);


--
-- Name: org_unique_constraints; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY org
    ADD CONSTRAINT org_unique_constraints UNIQUE (name, city, region, country, org_disambiguated_id);


--
-- Name: other_name_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY other_name
    ADD CONSTRAINT other_name_pkey PRIMARY KEY (other_name_id);


--
-- Name: patent_contributor_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY patent_contributor
    ADD CONSTRAINT patent_contributor_pk PRIMARY KEY (patent_contributor_id);


--
-- Name: patent_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY patent
    ADD CONSTRAINT patent_pkey PRIMARY KEY (patent_id);


--
-- Name: patent_source_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY patent_source
    ADD CONSTRAINT patent_source_pk PRIMARY KEY (orcid, patent_id, source_orcid);


--
-- Name: peer_review_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY peer_review
    ADD CONSTRAINT peer_review_pkey PRIMARY KEY (id);


--
-- Name: peer_review_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY peer_review_subject
    ADD CONSTRAINT peer_review_subject_pkey PRIMARY KEY (id);


--
-- Name: pk_custom_email; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY custom_email
    ADD CONSTRAINT pk_custom_email PRIMARY KEY (client_details_id, email_type);


--
-- Name: pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: pk_funding_subtype_to_index; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY funding_subtype_to_index
    ADD CONSTRAINT pk_funding_subtype_to_index PRIMARY KEY (orcid, subtype);


--
-- Name: pk_orcid_social; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY orcid_social
    ADD CONSTRAINT pk_orcid_social PRIMARY KEY (orcid, type);


--
-- Name: primary_profile_institution_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY affiliation
    ADD CONSTRAINT primary_profile_institution_pkey PRIMARY KEY (institution_id, orcid);


--
-- Name: profile_event_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_event
    ADD CONSTRAINT profile_event_pkey PRIMARY KEY (id);


--
-- Name: profile_funding_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_funding
    ADD CONSTRAINT profile_funding_pkey PRIMARY KEY (id);


--
-- Name: profile_keyword_numeric_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_keyword
    ADD CONSTRAINT profile_keyword_numeric_pkey PRIMARY KEY (id);


--
-- Name: profile_patent_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_patent
    ADD CONSTRAINT profile_patent_pk PRIMARY KEY (orcid, patent_id);


--
-- Name: profile_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (orcid);


--
-- Name: profile_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_subject
    ADD CONSTRAINT profile_subject_pkey PRIMARY KEY (profile_orcid, subjects_name);


--
-- Name: record_name_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY record_name
    ADD CONSTRAINT record_name_pkey PRIMARY KEY (id);


--
-- Name: reference_data_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY reference_data
    ADD CONSTRAINT reference_data_pkey PRIMARY KEY (id);


--
-- Name: researcher_url_orcid_client_source_unique_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY researcher_url
    ADD CONSTRAINT researcher_url_orcid_client_source_unique_key UNIQUE (url, orcid, client_source_id);


--
-- Name: researcher_url_orcid_source_unique_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY researcher_url
    ADD CONSTRAINT researcher_url_orcid_source_unique_key UNIQUE (url, orcid, source_id);


--
-- Name: researcher_url_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY researcher_url
    ADD CONSTRAINT researcher_url_pkey PRIMARY KEY (id);


--
-- Name: salesforce_connection_orcid_salesforce_account_id_unique; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY salesforce_connection
    ADD CONSTRAINT salesforce_connection_orcid_salesforce_account_id_unique UNIQUE (orcid, salesforce_account_id);


--
-- Name: salesforce_connection_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY salesforce_connection
    ADD CONSTRAINT salesforce_connection_pkey PRIMARY KEY (id);


--
-- Name: security_question_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY security_question
    ADD CONSTRAINT security_question_pkey PRIMARY KEY (id);


--
-- Name: shibboleth_account_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY shibboleth_account
    ADD CONSTRAINT shibboleth_account_pkey PRIMARY KEY (id);


--
-- Name: shibboleth_account_remote_user_idp_unique; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY shibboleth_account
    ADD CONSTRAINT shibboleth_account_remote_user_idp_unique UNIQUE (remote_user, shib_identity_provider);


--
-- Name: statistic_key_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY orcid_props
    ADD CONSTRAINT statistic_key_pkey PRIMARY KEY (key);


--
-- Name: subject_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (name);


--
-- Name: unique_external_identifiers_allowing_multiple_sources; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY external_identifier
    ADD CONSTRAINT unique_external_identifiers_allowing_multiple_sources UNIQUE (orcid, external_id_reference, external_id_type, source_id, client_source_id);


--
-- Name: unique_token_value; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY oauth2_token_detail
    ADD CONSTRAINT unique_token_value UNIQUE (token_value);


--
-- Name: userconnection_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY userconnection
    ADD CONSTRAINT userconnection_pkey PRIMARY KEY (userid, providerid, provideruserid);


--
-- Name: webhook_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY webhook
    ADD CONSTRAINT webhook_pk PRIMARY KEY (orcid, uri);


--
-- Name: work_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY work
    ADD CONSTRAINT work_pkey PRIMARY KEY (work_id);


--
-- Name: address_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX address_orcid_idx ON address USING btree (orcid);


--
-- Name: authoriziation_code_value_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX authoriziation_code_value_idx ON oauth2_authoriziation_code_detail USING btree (authoriziation_code_value);


--
-- Name: biography_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX biography_orcid_index ON biography USING btree (orcid);


--
-- Name: client_authorised_grant_type_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_authorised_grant_type_id_idx ON client_authorised_grant_type USING btree (client_details_id, grant_type);


--
-- Name: client_details_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_details_id_idx ON client_details USING btree (client_details_id, client_secret);


--
-- Name: client_granted_authority_client_details_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_granted_authority_client_details_id_idx ON client_granted_authority USING btree (client_details_id);


--
-- Name: client_granted_authority_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_granted_authority_id_idx ON client_granted_authority USING btree (client_details_id, granted_authority);


--
-- Name: client_redirect_uri_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_redirect_uri_id_idx ON client_redirect_uri USING btree (client_details_id, redirect_uri);


--
-- Name: client_resource_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_resource_id_idx ON client_resource_id USING btree (client_details_id, resource_id);


--
-- Name: client_scope_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_scope_id_idx ON client_scope USING btree (client_details_id, scope_type);


--
-- Name: email_event_email_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX email_event_email_idx ON email_event USING btree (email);


--
-- Name: external_identifier_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX external_identifier_orcid_idx ON external_identifier USING btree (orcid);


--
-- Name: given_permission_to_giver_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX given_permission_to_giver_orcid_idx ON given_permission_to USING btree (giver_orcid);


--
-- Name: given_permission_to_receiver_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX given_permission_to_receiver_orcid_idx ON given_permission_to USING btree (receiver_orcid);


--
-- Name: granted_authority_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX granted_authority_orcid_idx ON granted_authority USING btree (orcid);


--
-- Name: group_id_lowercase_unique_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE UNIQUE INDEX group_id_lowercase_unique_idx ON group_id_record USING btree (lower(group_id));


--
-- Name: group_id_record_date_created_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX group_id_record_date_created_idx ON group_id_record USING btree (date_created);


--
-- Name: group_id_record_group_type_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX group_id_record_group_type_idx ON group_id_record USING btree (group_type);


--
-- Name: internal_sso_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX internal_sso_orcid_idx ON internal_sso USING btree (orcid);


--
-- Name: invalid_record_data_changes_date_created_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX invalid_record_data_changes_date_created_index ON invalid_record_data_changes USING btree (date_created);


--
-- Name: invalid_record_data_changes_seq_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX invalid_record_data_changes_seq_index ON invalid_record_data_changes USING btree (id);


--
-- Name: lower_case_email_unique; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX lower_case_email_unique ON email USING btree (lower(email));


--
-- Name: notification_archived_date_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_archived_date_index ON notification USING btree (archived_date);


--
-- Name: notification_authentication_provider_id; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_authentication_provider_id ON notification USING btree (authentication_provider_id);


--
-- Name: notification_client_source_id; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_client_source_id ON notification USING btree (client_source_id);


--
-- Name: notification_date_created_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_date_created_index ON notification USING btree (date_created);


--
-- Name: notification_item_notification_id_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_item_notification_id_index ON notification_item USING btree (notification_id);


--
-- Name: notification_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_orcid_index ON notification USING btree (orcid);


--
-- Name: notification_read_date_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_read_date_index ON notification USING btree (read_date);


--
-- Name: notification_sent_date_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_sent_date_index ON notification USING btree (sent_date);


--
-- Name: notification_type_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX notification_type_index ON notification USING btree (notification_type);


--
-- Name: orcidoauth2authoriziationcodedetail_authoriziation_code_value_i; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX orcidoauth2authoriziationcodedetail_authoriziation_code_value_i ON orcidoauth2authoriziationcodedetail_authorities USING btree (orcidoauth2authoriziationcodedetail_authoriziation_code_value);


--
-- Name: orcidoauth2authoriziationcodedetail_resourceids_code_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX orcidoauth2authoriziationcodedetail_resourceids_code_idx ON orcidoauth2authoriziationcodedetail_resourceids USING btree (orcidoauth2authoriziationcodedetail_authoriziation_code_value);


--
-- Name: orcidoauth2authoriziationcodedetail_scopes_code_value_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX orcidoauth2authoriziationcodedetail_scopes_code_value_idx ON orcidoauth2authoriziationcodedetail_scopes USING btree (orcidoauth2authoriziationcodedetail_authoriziation_code_value);


--
-- Name: org_affiliation_relation_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX org_affiliation_relation_orcid_idx ON org_affiliation_relation USING btree (orcid);


--
-- Name: org_disambiguated_source_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX org_disambiguated_source_id_idx ON org_disambiguated USING btree (source_id);


--
-- Name: org_disambiguated_source_parent_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX org_disambiguated_source_parent_id_idx ON org_disambiguated USING btree (source_parent_id);


--
-- Name: org_disambiguated_source_type_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX org_disambiguated_source_type_idx ON org_disambiguated USING btree (source_type);


--
-- Name: other_name_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX other_name_orcid_index ON other_name USING btree (orcid);


--
-- Name: peer_review_display_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX peer_review_display_index ON peer_review USING btree (display_index);


--
-- Name: peer_review_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX peer_review_orcid_index ON peer_review USING btree (orcid);


--
-- Name: primary_profile_institution_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX primary_profile_institution_orcid_idx ON affiliation USING btree (orcid);


--
-- Name: profile_funding_display_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_funding_display_index ON profile_funding USING btree (display_index);


--
-- Name: profile_funding_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_funding_orcid_index ON profile_funding USING btree (orcid);


--
-- Name: profile_funding_org_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_funding_org_id_idx ON profile_funding USING btree (org_id);


--
-- Name: profile_group_orcid; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_group_orcid ON profile USING btree (group_orcid);


--
-- Name: profile_indexing_status_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_indexing_status_idx ON profile USING btree (indexing_status);


--
-- Name: profile_keyword_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_keyword_orcid_idx ON profile_keyword USING btree (profile_orcid);


--
-- Name: profile_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_orcid_idx ON profile USING btree (orcid);


--
-- Name: profile_orcid_type_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_orcid_type_idx ON profile USING btree (orcid_type);


--
-- Name: profile_subject_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX profile_subject_orcid_idx ON profile_subject USING btree (profile_orcid);


--
-- Name: record_name_credit_name_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX record_name_credit_name_idx ON record_name USING btree (credit_name);


--
-- Name: record_name_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX record_name_orcid_index ON record_name USING btree (orcid);


--
-- Name: researcher_url_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX researcher_url_orcid_idx ON researcher_url USING btree (orcid);


--
-- Name: salesforce_connection_account_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX salesforce_connection_account_id_idx ON salesforce_connection USING btree (salesforce_account_id);


--
-- Name: token_authentication_key_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX token_authentication_key_index ON oauth2_token_detail USING btree (authentication_key);


--
-- Name: token_client_details_id_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX token_client_details_id_index ON oauth2_token_detail USING btree (client_details_id);


--
-- Name: token_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX token_orcid_index ON oauth2_token_detail USING btree (user_orcid);


--
-- Name: userconnectionrank; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX userconnectionrank ON userconnection USING btree (userid, providerid, rank);


--
-- Name: work_doi_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX work_doi_idx ON work USING btree (extract_doi(external_ids_json));


--
-- Name: work_language_code_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX work_language_code_idx ON work USING btree (language_code);


--
-- Name: work_orcid_display_index_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX work_orcid_display_index_idx ON work USING btree (orcid, display_index);


--
-- Name: work_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX work_orcid_idx ON work USING btree (orcid);


--
-- Name: work_translated_title_language_code_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX work_translated_title_language_code_idx ON work USING btree (translated_title_language_code);


--
-- Name: address_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY address
    ADD CONSTRAINT address_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES client_details(client_details_id);


--
-- Name: address_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY address
    ADD CONSTRAINT address_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: address_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY address
    ADD CONSTRAINT address_source_id_fk FOREIGN KEY (source_id) REFERENCES profile(orcid);


--
-- Name: biography_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY biography
    ADD CONSTRAINT biography_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: client_details_authorised_grant_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY client_authorised_grant_type
    ADD CONSTRAINT client_details_authorised_grant_type_fk FOREIGN KEY (client_details_id) REFERENCES client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_details_client_granted_authority_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY client_granted_authority
    ADD CONSTRAINT client_details_client_granted_authority_fk FOREIGN KEY (client_details_id) REFERENCES client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_details_group_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY client_details
    ADD CONSTRAINT client_details_group_orcid_fk FOREIGN KEY (group_orcid) REFERENCES profile(orcid);


--
-- Name: client_redirect_uri_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY client_redirect_uri
    ADD CONSTRAINT client_redirect_uri_fk FOREIGN KEY (client_details_id) REFERENCES client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_resource_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY client_resource_id
    ADD CONSTRAINT client_resource_id_fk FOREIGN KEY (client_details_id) REFERENCES client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_scope_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY client_scope
    ADD CONSTRAINT client_scope_fk FOREIGN KEY (client_details_id) REFERENCES client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_secret_client_details_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY client_secret
    ADD CONSTRAINT client_secret_client_details_id_fk FOREIGN KEY (client_details_id) REFERENCES client_details(client_details_id);


--
-- Name: email_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY email
    ADD CONSTRAINT email_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES client_details(client_details_id);


--
-- Name: email_event_email; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY email_event
    ADD CONSTRAINT email_event_email FOREIGN KEY (email) REFERENCES email(email);


--
-- Name: email_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY email
    ADD CONSTRAINT email_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: email_source_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY email
    ADD CONSTRAINT email_source_orcid_fk FOREIGN KEY (source_id) REFERENCES profile(orcid);


--
-- Name: external_identifier_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY external_identifier
    ADD CONSTRAINT external_identifier_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES client_details(client_details_id);


--
-- Name: external_identifier_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY external_identifier
    ADD CONSTRAINT external_identifier_source_id_fk FOREIGN KEY (source_id) REFERENCES profile(orcid);


--
-- Name: fk1d5ccc962d6b1fe4; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_subject
    ADD CONSTRAINT fk1d5ccc962d6b1fe4 FOREIGN KEY (subjects_name) REFERENCES subject(name);


--
-- Name: fk1d5ccc9680ddc983; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_subject
    ADD CONSTRAINT fk1d5ccc9680ddc983 FOREIGN KEY (profile_orcid) REFERENCES profile(orcid);


--
-- Name: fk3529a5b8e84caef; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY institution
    ADD CONSTRAINT fk3529a5b8e84caef FOREIGN KEY (address_id) REFERENCES address(id);


--
-- Name: fk408de65b2007f99; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY affiliation
    ADD CONSTRAINT fk408de65b2007f99 FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: fk408de65cf1a386f; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY affiliation
    ADD CONSTRAINT fk408de65cf1a386f FOREIGN KEY (institution_id) REFERENCES institution(id);


--
-- Name: fk5c27955380ddc983; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_keyword
    ADD CONSTRAINT fk5c27955380ddc983 FOREIGN KEY (profile_orcid) REFERENCES profile(orcid);


--
-- Name: fk641fe19db2007f99; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY external_identifier
    ADD CONSTRAINT fk641fe19db2007f99 FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: fkd433c438b2007f99; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY researcher_url
    ADD CONSTRAINT fkd433c438b2007f99 FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: fked8e89a96b6f57ec; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT fked8e89a96b6f57ec FOREIGN KEY (security_question_id) REFERENCES security_question(id);


--
-- Name: fked8e89a9d6bc0bfe; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT fked8e89a9d6bc0bfe FOREIGN KEY (source_id) REFERENCES profile(orcid);


--
-- Name: fkf5209e5ab2007f99; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY other_name
    ADD CONSTRAINT fkf5209e5ab2007f99 FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: funding_external_identifiers_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY funding_external_identifier
    ADD CONSTRAINT funding_external_identifiers_fk FOREIGN KEY (profile_funding_id) REFERENCES profile_funding(id);


--
-- Name: funding_subtype_to_index_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY funding_subtype_to_index
    ADD CONSTRAINT funding_subtype_to_index_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: giver_orcid_to_profile_orcid; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY given_permission_to
    ADD CONSTRAINT giver_orcid_to_profile_orcid FOREIGN KEY (giver_orcid) REFERENCES profile(orcid);


--
-- Name: identity_provider_name_identity_provider_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY identity_provider_name
    ADD CONSTRAINT identity_provider_name_identity_provider_id_fk FOREIGN KEY (identity_provider_id) REFERENCES identity_provider(id);


--
-- Name: keyword_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_keyword
    ADD CONSTRAINT keyword_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES client_details(client_details_id);


--
-- Name: keyword_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_keyword
    ADD CONSTRAINT keyword_source_id_fk FOREIGN KEY (source_id) REFERENCES profile(orcid);


--
-- Name: member_custom_email_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY custom_email
    ADD CONSTRAINT member_custom_email_fk FOREIGN KEY (client_details_id) REFERENCES client_details(client_details_id);


--
-- Name: notification_activity_notification_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY notification_item
    ADD CONSTRAINT notification_activity_notification_fk FOREIGN KEY (notification_id) REFERENCES notification(id);


--
-- Name: notification_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES client_details(client_details_id);


--
-- Name: notification_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: notification_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_source_id_fk FOREIGN KEY (source_id) REFERENCES profile(orcid);


--
-- Name: notification_work; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY notification_work
    ADD CONSTRAINT notification_work FOREIGN KEY (work_id) REFERENCES work(work_id);


--
-- Name: notification_work_notification_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY notification_work
    ADD CONSTRAINT notification_work_notification_id_fk FOREIGN KEY (notification_id) REFERENCES notification(id);


--
-- Name: oauth2_authoriziation_code_detail_client_details_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY oauth2_authoriziation_code_detail
    ADD CONSTRAINT oauth2_authoriziation_code_detail_client_details_fk FOREIGN KEY (client_details_id) REFERENCES client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: oauth2_authoriziation_code_detail_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY oauth2_authoriziation_code_detail
    ADD CONSTRAINT oauth2_authoriziation_code_detail_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid) ON DELETE CASCADE;


--
-- Name: oauth2_token_detail_client_details_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY oauth2_token_detail
    ADD CONSTRAINT oauth2_token_detail_client_details_fk FOREIGN KEY (client_details_id) REFERENCES client_details(client_details_id);


--
-- Name: oauth2_token_detail_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY oauth2_token_detail
    ADD CONSTRAINT oauth2_token_detail_orcid_fk FOREIGN KEY (user_orcid) REFERENCES profile(orcid);


--
-- Name: oauth2authoriziationcodedetail_authorities_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY orcidoauth2authoriziationcodedetail_authorities
    ADD CONSTRAINT oauth2authoriziationcodedetail_authorities_fk FOREIGN KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value) REFERENCES oauth2_authoriziation_code_detail(authoriziation_code_value) ON DELETE CASCADE;


--
-- Name: oauth2authoriziationcodedetail_resourceids_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY orcidoauth2authoriziationcodedetail_resourceids
    ADD CONSTRAINT oauth2authoriziationcodedetail_resourceids_fk FOREIGN KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value) REFERENCES oauth2_authoriziation_code_detail(authoriziation_code_value) ON DELETE CASCADE;


--
-- Name: oauth2authoriziationcodedetail_scopes_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY orcidoauth2authoriziationcodedetail_scopes
    ADD CONSTRAINT oauth2authoriziationcodedetail_scopes_fk FOREIGN KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value) REFERENCES oauth2_authoriziation_code_detail(authoriziation_code_value) ON DELETE CASCADE;


--
-- Name: orcid_social_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY orcid_social
    ADD CONSTRAINT orcid_social_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: org_affiliation_relation_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY org_affiliation_relation
    ADD CONSTRAINT org_affiliation_relation_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES client_details(client_details_id);


--
-- Name: org_affiliation_relation_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY org_affiliation_relation
    ADD CONSTRAINT org_affiliation_relation_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: org_affiliation_relation_org_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY org_affiliation_relation
    ADD CONSTRAINT org_affiliation_relation_org_id_fk FOREIGN KEY (org_id) REFERENCES org(id);


--
-- Name: org_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY org
    ADD CONSTRAINT org_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES client_details(client_details_id);


--
-- Name: org_disambiguated_external_identifier_org_disambiguated_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY org_disambiguated_external_identifier
    ADD CONSTRAINT org_disambiguated_external_identifier_org_disambiguated_fk FOREIGN KEY (org_disambiguated_id) REFERENCES org_disambiguated(id);


--
-- Name: org_org_disambiguated_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY org
    ADD CONSTRAINT org_org_disambiguated_fk FOREIGN KEY (org_disambiguated_id) REFERENCES org_disambiguated(id);


--
-- Name: other_name_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY other_name
    ADD CONSTRAINT other_name_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES client_details(client_details_id);


--
-- Name: other_name_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY other_name
    ADD CONSTRAINT other_name_source_id_fk FOREIGN KEY (source_id) REFERENCES profile(orcid);


--
-- Name: patent_contributor_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY patent_contributor
    ADD CONSTRAINT patent_contributor_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: patent_contributor_patent_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY patent_contributor
    ADD CONSTRAINT patent_contributor_patent_fk FOREIGN KEY (patent_id) REFERENCES patent(patent_id);


--
-- Name: patent_source_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY patent_source
    ADD CONSTRAINT patent_source_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: patent_source_patent_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY patent_source
    ADD CONSTRAINT patent_source_patent_fk FOREIGN KEY (patent_id) REFERENCES patent(patent_id);


--
-- Name: patent_source_source_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY patent_source
    ADD CONSTRAINT patent_source_source_orcid_fk FOREIGN KEY (source_orcid) REFERENCES profile(orcid);


--
-- Name: peer_review_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY peer_review
    ADD CONSTRAINT peer_review_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: peer_review_org_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY peer_review
    ADD CONSTRAINT peer_review_org_id_fk FOREIGN KEY (org_id) REFERENCES org(id);


--
-- Name: profile_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile
    ADD CONSTRAINT profile_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES client_details(client_details_id);


--
-- Name: profile_event_orcid; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_event
    ADD CONSTRAINT profile_event_orcid FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: profile_funding_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_funding
    ADD CONSTRAINT profile_funding_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES client_details(client_details_id);


--
-- Name: profile_funding_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_funding
    ADD CONSTRAINT profile_funding_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: profile_funding_org_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_funding
    ADD CONSTRAINT profile_funding_org_id_fk FOREIGN KEY (org_id) REFERENCES org(id);


--
-- Name: profile_patent_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_patent
    ADD CONSTRAINT profile_patent_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: profile_patent_patent_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY profile_patent
    ADD CONSTRAINT profile_patent_patent_fk FOREIGN KEY (patent_id) REFERENCES patent(patent_id);


--
-- Name: receiver_orcid_to_profile_orcid; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY given_permission_to
    ADD CONSTRAINT receiver_orcid_to_profile_orcid FOREIGN KEY (receiver_orcid) REFERENCES profile(orcid);


--
-- Name: record_name_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY record_name
    ADD CONSTRAINT record_name_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: researcher_url_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY researcher_url
    ADD CONSTRAINT researcher_url_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES client_details(client_details_id);


--
-- Name: researcher_url_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY researcher_url
    ADD CONSTRAINT researcher_url_source_id_fk FOREIGN KEY (source_id) REFERENCES profile(orcid);


--
-- Name: shibboleth_account_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY shibboleth_account
    ADD CONSTRAINT shibboleth_account_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: webhook_client_details_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY webhook
    ADD CONSTRAINT webhook_client_details_fk FOREIGN KEY (client_details_id) REFERENCES client_details(client_details_id);


--
-- Name: webhook_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY webhook
    ADD CONSTRAINT webhook_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: work_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY work
    ADD CONSTRAINT work_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES client_details(client_details_id);


--
-- Name: work_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY work
    ADD CONSTRAINT work_orcid_fk FOREIGN KEY (orcid) REFERENCES profile(orcid);


--
-- Name: work_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY work
    ADD CONSTRAINT work_source_id_fk FOREIGN KEY (source_id) REFERENCES profile(orcid);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: address; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE address FROM PUBLIC;
REVOKE ALL ON TABLE address FROM orcid;
GRANT ALL ON TABLE address TO orcid;
GRANT SELECT ON TABLE address TO orcidro;


--
-- Name: affiliation; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE affiliation FROM PUBLIC;
REVOKE ALL ON TABLE affiliation FROM orcid;
GRANT ALL ON TABLE affiliation TO orcid;
GRANT SELECT ON TABLE affiliation TO orcidro;


--
-- Name: org; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE org FROM PUBLIC;
REVOKE ALL ON TABLE org FROM orcid;
GRANT ALL ON TABLE org TO orcid;
GRANT SELECT ON TABLE org TO orcidro;


--
-- Name: org_affiliation_relation; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE org_affiliation_relation FROM PUBLIC;
REVOKE ALL ON TABLE org_affiliation_relation FROM orcid;
GRANT ALL ON TABLE org_affiliation_relation TO orcid;
GRANT SELECT ON TABLE org_affiliation_relation TO orcidro;


--
-- Name: ambiguous_org; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE ambiguous_org FROM PUBLIC;
REVOKE ALL ON TABLE ambiguous_org FROM orcid;
GRANT ALL ON TABLE ambiguous_org TO orcid;
GRANT SELECT ON TABLE ambiguous_org TO orcidro;


--
-- Name: biography; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE biography FROM PUBLIC;
REVOKE ALL ON TABLE biography FROM orcid;
GRANT ALL ON TABLE biography TO orcid;
GRANT SELECT ON TABLE biography TO orcidro;


--
-- Name: client_authorised_grant_type; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE client_authorised_grant_type FROM PUBLIC;
REVOKE ALL ON TABLE client_authorised_grant_type FROM orcid;
GRANT ALL ON TABLE client_authorised_grant_type TO orcid;
GRANT SELECT ON TABLE client_authorised_grant_type TO orcidro;


--
-- Name: client_details; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE client_details FROM PUBLIC;
REVOKE ALL ON TABLE client_details FROM orcid;
GRANT ALL ON TABLE client_details TO orcid;
GRANT SELECT ON TABLE client_details TO orcidro;


--
-- Name: client_granted_authority; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE client_granted_authority FROM PUBLIC;
REVOKE ALL ON TABLE client_granted_authority FROM orcid;
GRANT ALL ON TABLE client_granted_authority TO orcid;
GRANT SELECT ON TABLE client_granted_authority TO orcidro;


--
-- Name: client_redirect_uri; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE client_redirect_uri FROM PUBLIC;
REVOKE ALL ON TABLE client_redirect_uri FROM orcid;
GRANT ALL ON TABLE client_redirect_uri TO orcid;
GRANT SELECT ON TABLE client_redirect_uri TO orcidro;


--
-- Name: client_resource_id; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE client_resource_id FROM PUBLIC;
REVOKE ALL ON TABLE client_resource_id FROM orcid;
GRANT ALL ON TABLE client_resource_id TO orcid;
GRANT SELECT ON TABLE client_resource_id TO orcidro;


--
-- Name: client_scope; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE client_scope FROM PUBLIC;
REVOKE ALL ON TABLE client_scope FROM orcid;
GRANT ALL ON TABLE client_scope TO orcid;
GRANT SELECT ON TABLE client_scope TO orcidro;


--
-- Name: client_secret; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE client_secret FROM PUBLIC;
REVOKE ALL ON TABLE client_secret FROM orcid;
GRANT ALL ON TABLE client_secret TO orcid;
GRANT SELECT ON TABLE client_secret TO orcidro;


--
-- Name: country_reference_data; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE country_reference_data FROM PUBLIC;
REVOKE ALL ON TABLE country_reference_data FROM orcid;
GRANT ALL ON TABLE country_reference_data TO orcid;
GRANT SELECT ON TABLE country_reference_data TO orcidro;


--
-- Name: custom_email; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE custom_email FROM PUBLIC;
REVOKE ALL ON TABLE custom_email FROM orcid;
GRANT ALL ON TABLE custom_email TO orcid;
GRANT SELECT ON TABLE custom_email TO orcidro;


--
-- Name: databasechangelog; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE databasechangelog FROM PUBLIC;
REVOKE ALL ON TABLE databasechangelog FROM orcid;
GRANT ALL ON TABLE databasechangelog TO orcid;
GRANT SELECT ON TABLE databasechangelog TO orcidro;


--
-- Name: databasechangeloglock; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE databasechangeloglock FROM PUBLIC;
REVOKE ALL ON TABLE databasechangeloglock FROM orcid;
GRANT ALL ON TABLE databasechangeloglock TO orcid;
GRANT SELECT ON TABLE databasechangeloglock TO orcidro;


--
-- Name: email; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE email FROM PUBLIC;
REVOKE ALL ON TABLE email FROM orcid;
GRANT ALL ON TABLE email TO orcid;
GRANT SELECT ON TABLE email TO orcidro;


--
-- Name: email_event; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE email_event FROM PUBLIC;
REVOKE ALL ON TABLE email_event FROM orcid;
GRANT ALL ON TABLE email_event TO orcid;
GRANT SELECT ON TABLE email_event TO orcidro;


--
-- Name: external_identifier; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE external_identifier FROM PUBLIC;
REVOKE ALL ON TABLE external_identifier FROM orcid;
GRANT ALL ON TABLE external_identifier TO orcid;
GRANT SELECT ON TABLE external_identifier TO orcidro;


--
-- Name: funding_external_identifier; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE funding_external_identifier FROM PUBLIC;
REVOKE ALL ON TABLE funding_external_identifier FROM orcid;
GRANT ALL ON TABLE funding_external_identifier TO orcid;
GRANT SELECT ON TABLE funding_external_identifier TO orcidro;


--
-- Name: funding_subtype_to_index; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE funding_subtype_to_index FROM PUBLIC;
REVOKE ALL ON TABLE funding_subtype_to_index FROM orcid;
GRANT ALL ON TABLE funding_subtype_to_index TO orcid;
GRANT SELECT ON TABLE funding_subtype_to_index TO orcidro;


--
-- Name: given_permission_to; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE given_permission_to FROM PUBLIC;
REVOKE ALL ON TABLE given_permission_to FROM orcid;
GRANT ALL ON TABLE given_permission_to TO orcid;
GRANT SELECT ON TABLE given_permission_to TO orcidro;


--
-- Name: granted_authority; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE granted_authority FROM PUBLIC;
REVOKE ALL ON TABLE granted_authority FROM orcid;
GRANT ALL ON TABLE granted_authority TO orcid;
GRANT SELECT ON TABLE granted_authority TO orcidro;


--
-- Name: group_id_record; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE group_id_record FROM PUBLIC;
REVOKE ALL ON TABLE group_id_record FROM orcid;
GRANT ALL ON TABLE group_id_record TO orcid;
GRANT SELECT ON TABLE group_id_record TO orcidro;


--
-- Name: identifier_type; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE identifier_type FROM PUBLIC;
REVOKE ALL ON TABLE identifier_type FROM orcid;
GRANT ALL ON TABLE identifier_type TO orcid;
GRANT SELECT ON TABLE identifier_type TO orcidro;


--
-- Name: identity_provider; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE identity_provider FROM PUBLIC;
REVOKE ALL ON TABLE identity_provider FROM orcid;
GRANT ALL ON TABLE identity_provider TO orcid;
GRANT SELECT ON TABLE identity_provider TO orcidro;


--
-- Name: identity_provider_name; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE identity_provider_name FROM PUBLIC;
REVOKE ALL ON TABLE identity_provider_name FROM orcid;
GRANT ALL ON TABLE identity_provider_name TO orcid;
GRANT SELECT ON TABLE identity_provider_name TO orcidro;


--
-- Name: institution; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE institution FROM PUBLIC;
REVOKE ALL ON TABLE institution FROM orcid;
GRANT ALL ON TABLE institution TO orcid;
GRANT SELECT ON TABLE institution TO orcidro;


--
-- Name: internal_sso; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE internal_sso FROM PUBLIC;
REVOKE ALL ON TABLE internal_sso FROM orcid;
GRANT ALL ON TABLE internal_sso TO orcid;
GRANT SELECT ON TABLE internal_sso TO orcidro;


--
-- Name: invalid_record_data_changes; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE invalid_record_data_changes FROM PUBLIC;
REVOKE ALL ON TABLE invalid_record_data_changes FROM orcid;
GRANT ALL ON TABLE invalid_record_data_changes TO orcid;
GRANT SELECT ON TABLE invalid_record_data_changes TO orcidro;


--
-- Name: notification; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE notification FROM PUBLIC;
REVOKE ALL ON TABLE notification FROM orcid;
GRANT ALL ON TABLE notification TO orcid;
GRANT SELECT ON TABLE notification TO orcidro;


--
-- Name: notification_item; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE notification_item FROM PUBLIC;
REVOKE ALL ON TABLE notification_item FROM orcid;
GRANT ALL ON TABLE notification_item TO orcid;
GRANT SELECT ON TABLE notification_item TO orcidro;


--
-- Name: notification_work; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE notification_work FROM PUBLIC;
REVOKE ALL ON TABLE notification_work FROM orcid;
GRANT ALL ON TABLE notification_work TO orcid;
GRANT SELECT ON TABLE notification_work TO orcidro;


--
-- Name: oauth2_authoriziation_code_detail; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE oauth2_authoriziation_code_detail FROM PUBLIC;
REVOKE ALL ON TABLE oauth2_authoriziation_code_detail FROM orcid;
GRANT ALL ON TABLE oauth2_authoriziation_code_detail TO orcid;
GRANT SELECT ON TABLE oauth2_authoriziation_code_detail TO orcidro;


--
-- Name: oauth2_token_detail; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE oauth2_token_detail FROM PUBLIC;
REVOKE ALL ON TABLE oauth2_token_detail FROM orcid;
GRANT ALL ON TABLE oauth2_token_detail TO orcid;
GRANT SELECT ON TABLE oauth2_token_detail TO orcidro;


--
-- Name: orcid_props; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE orcid_props FROM PUBLIC;
REVOKE ALL ON TABLE orcid_props FROM orcid;
GRANT ALL ON TABLE orcid_props TO orcid;
GRANT SELECT ON TABLE orcid_props TO orcidro;


--
-- Name: orcid_social; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE orcid_social FROM PUBLIC;
REVOKE ALL ON TABLE orcid_social FROM orcid;
GRANT ALL ON TABLE orcid_social TO orcid;
GRANT SELECT ON TABLE orcid_social TO orcidro;


--
-- Name: orcidoauth2authoriziationcodedetail_authorities; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE orcidoauth2authoriziationcodedetail_authorities FROM PUBLIC;
REVOKE ALL ON TABLE orcidoauth2authoriziationcodedetail_authorities FROM orcid;
GRANT ALL ON TABLE orcidoauth2authoriziationcodedetail_authorities TO orcid;
GRANT SELECT ON TABLE orcidoauth2authoriziationcodedetail_authorities TO orcidro;


--
-- Name: orcidoauth2authoriziationcodedetail_resourceids; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE orcidoauth2authoriziationcodedetail_resourceids FROM PUBLIC;
REVOKE ALL ON TABLE orcidoauth2authoriziationcodedetail_resourceids FROM orcid;
GRANT ALL ON TABLE orcidoauth2authoriziationcodedetail_resourceids TO orcid;
GRANT SELECT ON TABLE orcidoauth2authoriziationcodedetail_resourceids TO orcidro;


--
-- Name: orcidoauth2authoriziationcodedetail_scopes; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE orcidoauth2authoriziationcodedetail_scopes FROM PUBLIC;
REVOKE ALL ON TABLE orcidoauth2authoriziationcodedetail_scopes FROM orcid;
GRANT ALL ON TABLE orcidoauth2authoriziationcodedetail_scopes TO orcid;
GRANT SELECT ON TABLE orcidoauth2authoriziationcodedetail_scopes TO orcidro;


--
-- Name: org_disambiguated; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE org_disambiguated FROM PUBLIC;
REVOKE ALL ON TABLE org_disambiguated FROM orcid;
GRANT ALL ON TABLE org_disambiguated TO orcid;
GRANT SELECT ON TABLE org_disambiguated TO orcidro;


--
-- Name: org_disambiguated_external_identifier; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE org_disambiguated_external_identifier FROM PUBLIC;
REVOKE ALL ON TABLE org_disambiguated_external_identifier FROM orcid;
GRANT ALL ON TABLE org_disambiguated_external_identifier TO orcid;
GRANT SELECT ON TABLE org_disambiguated_external_identifier TO orcidro;


--
-- Name: other_name; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE other_name FROM PUBLIC;
REVOKE ALL ON TABLE other_name FROM orcid;
GRANT ALL ON TABLE other_name TO orcid;
GRANT SELECT ON TABLE other_name TO orcidro;


--
-- Name: patent; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE patent FROM PUBLIC;
REVOKE ALL ON TABLE patent FROM orcid;
GRANT ALL ON TABLE patent TO orcid;
GRANT SELECT ON TABLE patent TO orcidro;


--
-- Name: patent_contributor; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE patent_contributor FROM PUBLIC;
REVOKE ALL ON TABLE patent_contributor FROM orcid;
GRANT ALL ON TABLE patent_contributor TO orcid;
GRANT SELECT ON TABLE patent_contributor TO orcidro;


--
-- Name: patent_source; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE patent_source FROM PUBLIC;
REVOKE ALL ON TABLE patent_source FROM orcid;
GRANT ALL ON TABLE patent_source TO orcid;
GRANT SELECT ON TABLE patent_source TO orcidro;


--
-- Name: peer_review; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE peer_review FROM PUBLIC;
REVOKE ALL ON TABLE peer_review FROM orcid;
GRANT ALL ON TABLE peer_review TO orcid;
GRANT SELECT ON TABLE peer_review TO orcidro;


--
-- Name: peer_review_subject; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE peer_review_subject FROM PUBLIC;
REVOKE ALL ON TABLE peer_review_subject FROM orcid;
GRANT ALL ON TABLE peer_review_subject TO orcid;
GRANT SELECT ON TABLE peer_review_subject TO orcidro;


--
-- Name: profile; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE profile FROM PUBLIC;
REVOKE ALL ON TABLE profile FROM orcid;
GRANT ALL ON TABLE profile TO orcid;
GRANT SELECT ON TABLE profile TO orcidro;


--
-- Name: profile_event; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE profile_event FROM PUBLIC;
REVOKE ALL ON TABLE profile_event FROM orcid;
GRANT ALL ON TABLE profile_event TO orcid;
GRANT SELECT ON TABLE profile_event TO orcidro;


--
-- Name: profile_funding; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE profile_funding FROM PUBLIC;
REVOKE ALL ON TABLE profile_funding FROM orcid;
GRANT ALL ON TABLE profile_funding TO orcid;
GRANT SELECT ON TABLE profile_funding TO orcidro;


--
-- Name: profile_keyword; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE profile_keyword FROM PUBLIC;
REVOKE ALL ON TABLE profile_keyword FROM orcid;
GRANT ALL ON TABLE profile_keyword TO orcid;
GRANT SELECT ON TABLE profile_keyword TO orcidro;


--
-- Name: profile_patent; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE profile_patent FROM PUBLIC;
REVOKE ALL ON TABLE profile_patent FROM orcid;
GRANT ALL ON TABLE profile_patent TO orcid;
GRANT SELECT ON TABLE profile_patent TO orcidro;


--
-- Name: profile_subject; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE profile_subject FROM PUBLIC;
REVOKE ALL ON TABLE profile_subject FROM orcid;
GRANT ALL ON TABLE profile_subject TO orcid;
GRANT SELECT ON TABLE profile_subject TO orcidro;


--
-- Name: record_name; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE record_name FROM PUBLIC;
REVOKE ALL ON TABLE record_name FROM orcid;
GRANT ALL ON TABLE record_name TO orcid;
GRANT SELECT ON TABLE record_name TO orcidro;


--
-- Name: reference_data; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE reference_data FROM PUBLIC;
REVOKE ALL ON TABLE reference_data FROM orcid;
GRANT ALL ON TABLE reference_data TO orcid;
GRANT SELECT ON TABLE reference_data TO orcidro;


--
-- Name: researcher_url; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE researcher_url FROM PUBLIC;
REVOKE ALL ON TABLE researcher_url FROM orcid;
GRANT ALL ON TABLE researcher_url TO orcid;
GRANT SELECT ON TABLE researcher_url TO orcidro;


--
-- Name: salesforce_connection; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE salesforce_connection FROM PUBLIC;
REVOKE ALL ON TABLE salesforce_connection FROM orcid;
GRANT ALL ON TABLE salesforce_connection TO orcid;
GRANT SELECT ON TABLE salesforce_connection TO orcidro;


--
-- Name: security_question; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE security_question FROM PUBLIC;
REVOKE ALL ON TABLE security_question FROM orcid;
GRANT ALL ON TABLE security_question TO orcid;
GRANT SELECT ON TABLE security_question TO orcidro;


--
-- Name: shibboleth_account; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE shibboleth_account FROM PUBLIC;
REVOKE ALL ON TABLE shibboleth_account FROM orcid;
GRANT ALL ON TABLE shibboleth_account TO orcid;
GRANT SELECT ON TABLE shibboleth_account TO orcidro;


--
-- Name: subject; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE subject FROM PUBLIC;
REVOKE ALL ON TABLE subject FROM orcid;
GRANT ALL ON TABLE subject TO orcid;
GRANT SELECT ON TABLE subject TO orcidro;


--
-- Name: userconnection; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE userconnection FROM PUBLIC;
REVOKE ALL ON TABLE userconnection FROM orcid;
GRANT ALL ON TABLE userconnection TO orcid;
GRANT SELECT ON TABLE userconnection TO orcidro;


--
-- Name: webhook; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE webhook FROM PUBLIC;
REVOKE ALL ON TABLE webhook FROM orcid;
GRANT ALL ON TABLE webhook TO orcid;
GRANT SELECT ON TABLE webhook TO orcidro;


--
-- Name: work; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE work FROM PUBLIC;
REVOKE ALL ON TABLE work FROM orcid;
GRANT ALL ON TABLE work TO orcid;
GRANT SELECT ON TABLE work TO orcidro;


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.10
-- Dumped by pg_dump version 9.5.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
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
-- Name: public; Type: ACL; Schema: -; Owner: postgres
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

-- Dumped from database version 9.5.10
-- Dumped by pg_dump version 9.5.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
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


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE databasechangelog (
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


ALTER TABLE databasechangelog OWNER TO orcid;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE databasechangeloglock OWNER TO orcid;

--
-- Name: key_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE key_seq OWNER TO orcid;

--
-- Name: statistic_key; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE statistic_key (
    id bigint NOT NULL,
    generation_date timestamp with time zone
);


ALTER TABLE statistic_key OWNER TO orcid;

--
-- Name: statistic_values; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE statistic_values (
    id bigint NOT NULL,
    key_id bigint NOT NULL,
    statistic_name character varying(255),
    statistic_value bigint
);


ALTER TABLE statistic_values OWNER TO orcid;

--
-- Name: values_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE values_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE values_seq OWNER TO orcid;

--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase) FROM stdin;
BASE-INSTALL	Angel Montenegro	/db/statistics/install.xml	2017-01-17 22:40:59.370026	1	EXECUTED	7:31ed461caac4f0930d966d39e6786fc0	createTable (x2), addForeignKeyConstraint		\N	3.2.0
CREATE-SEQUENCES	Angel Montenegro	/db/statistics/install.xml	2017-01-17 22:40:59.376265	2	EXECUTED	7:a34c3ac825d40c283fef31cc0b7b372a	createSequence (x2)		\N	3.2.0
add_statistic_values_key_id_index	rcpeters	/db/statistics/add_statistic_values_key_id_index.xml	2017-01-17 22:40:59.378624	3	EXECUTED	7:0ab195e5e4b45d245273785117f735de	sql		\N	3.2.0
GRANT-PERMISSIONS	Angel Montenegro	/db/statistics/grant_read_permissions_to_orcidro.xml	2017-03-29 19:03:18.660686	4	EXECUTED	7:7fe2b129853e90b6d97569431cec27bc	sql (x3)		\N	3.2.0
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Name: key_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('key_seq', 1, true);


--
-- Data for Name: statistic_key; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY statistic_key (id, generation_date) FROM stdin;
1	2017-11-30 22:55:01.135+00
\.


--
-- Data for Name: statistic_values; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY statistic_values (id, key_id, statistic_name, statistic_value) FROM stdin;
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

SELECT pg_catalog.setval('values_seq', 19, true);


--
-- Name: pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: statistic_key_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY statistic_key
    ADD CONSTRAINT statistic_key_pkey PRIMARY KEY (id);


--
-- Name: statistic_values_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY statistic_values
    ADD CONSTRAINT statistic_values_pkey PRIMARY KEY (id);


--
-- Name: statistic_values_key_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX statistic_values_key_id_idx ON statistic_values USING btree (key_id);


--
-- Name: fk9bb60ebf14b94af; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY statistic_values
    ADD CONSTRAINT fk9bb60ebf14b94af FOREIGN KEY (key_id) REFERENCES statistic_key(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: statistic_key; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE statistic_key FROM PUBLIC;
REVOKE ALL ON TABLE statistic_key FROM orcid;
GRANT ALL ON TABLE statistic_key TO orcid;
GRANT SELECT ON TABLE statistic_key TO orcidro;


--
-- Name: statistic_values; Type: ACL; Schema: public; Owner: orcid
--

REVOKE ALL ON TABLE statistic_values FROM PUBLIC;
REVOKE ALL ON TABLE statistic_values FROM orcid;
GRANT ALL ON TABLE statistic_values TO orcid;
GRANT SELECT ON TABLE statistic_values TO orcidro;


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.10
-- Dumped by pg_dump version 9.5.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
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
-- Name: public; Type: ACL; Schema: -; Owner: postgres
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

-- Dumped from database version 9.5.10
-- Dumped by pg_dump version 9.5.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
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


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: persons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE persons (
    personid integer,
    lastname character varying(255),
    firstname character varying(255),
    address character varying(255),
    city character varying(255)
);


ALTER TABLE persons OWNER TO postgres;

--
-- Data for Name: persons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY persons (personid, lastname, firstname, address, city) FROM stdin;
\.


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
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

