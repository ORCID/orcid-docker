--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE orcid;
ALTER ROLE orcid WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md56f4c19ae1996a4a6c61512aacac92445';
CREATE ROLE orcidro;
ALTER ROLE orcidro WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md54d77a927daa94e9b5ce745bf157268b1';
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
CREATE ROLE statistics;
ALTER ROLE statistics WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md50bb9ced98effdb433e3e2fafd98932fd';






--
-- Database creation
--

CREATE DATABASE features WITH TEMPLATE = template0 OWNER = postgres;
GRANT ALL ON DATABASE features TO orcid;
CREATE DATABASE message_listener WITH TEMPLATE = template0 OWNER = postgres;
GRANT ALL ON DATABASE message_listener TO orcid;
CREATE DATABASE orcid WITH TEMPLATE = template0 OWNER = postgres;
GRANT ALL ON DATABASE orcid TO orcid;
GRANT CONNECT ON DATABASE orcid TO orcidro;
CREATE DATABASE statistics WITH TEMPLATE = template0 OWNER = postgres;
GRANT ALL ON DATABASE statistics TO statistics;
REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect features

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Debian 10.4-2.pgdg90+1)
-- Dumped by pg_dump version 10.4 (Debian 10.4-2.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- PostgreSQL database dump complete
--

\connect message_listener

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Debian 10.4-2.pgdg90+1)
-- Dumped by pg_dump version 10.4 (Debian 10.4-2.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- PostgreSQL database dump complete
--

\connect orcid

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Debian 10.4-2.pgdg90+1)
-- Dumped by pg_dump version 10.4 (Debian 10.4-2.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
    display_index bigint DEFAULT 0,
    assertion_origin_source_id character varying(19),
    assertion_origin_client_source_id character varying(20)
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
    url text,
    external_ids_json json,
    display_index bigint DEFAULT 0,
    assertion_origin_source_id character varying(19),
    assertion_origin_client_source_id character varying(20)
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
    client_name text,
    webhooks_enabled boolean DEFAULT true NOT NULL,
    client_description text,
    client_website text,
    persistent_tokens_enabled boolean DEFAULT false,
    group_orcid character varying(19),
    client_type character varying(25),
    authentication_provider_id character varying(1000),
    email_access_reason text,
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
    email text,
    orcid character varying(255) NOT NULL,
    visibility character varying(20) DEFAULT 'PRIVATE'::character varying NOT NULL,
    is_primary boolean DEFAULT true NOT NULL,
    is_current boolean DEFAULT true NOT NULL,
    is_verified boolean DEFAULT false NOT NULL,
    source_id character varying(255),
    client_source_id character varying(20),
    email_hash character varying(256) NOT NULL,
    assertion_origin_source_id character varying(19),
    assertion_origin_client_source_id character varying(20)
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
-- Name: email_frequency; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.email_frequency (
    id character varying(255) NOT NULL,
    orcid character varying(255) NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    send_administrative_change_notifications double precision DEFAULT 7.0 NOT NULL,
    send_change_notifications double precision DEFAULT 7.0 NOT NULL,
    send_member_update_requests double precision DEFAULT 7.0 NOT NULL,
    send_quarterly_tips boolean DEFAULT true NOT NULL
);


ALTER TABLE public.email_frequency OWNER TO orcid;

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
    display_index bigint DEFAULT 0,
    assertion_origin_source_id character varying(19),
    assertion_origin_client_source_id character varying(20)
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
-- Name: find_my_stuff_history; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.find_my_stuff_history (
    orcid character varying(255) NOT NULL,
    finder_name character varying(255) NOT NULL,
    last_count integer,
    opt_out boolean,
    actioned boolean,
    date_created timestamp with time zone,
    last_modified timestamp with time zone
);


ALTER TABLE public.find_my_stuff_history OWNER TO orcid;

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
    last_modified timestamp with time zone,
    assertion_origin_source_id character varying(19),
    assertion_origin_client_source_id character varying(20)
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
-- Name: member_chosen_org_disambiguated; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.member_chosen_org_disambiguated (
    org_disambiguated_id bigint NOT NULL
);


ALTER TABLE public.member_chosen_org_disambiguated OWNER TO orcid;

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
    authentication_provider_id text,
    retry_count integer,
    notification_family character varying(50),
    assertion_origin_source_id character varying(19),
    assertion_origin_client_source_id character varying(20)
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
    revoke_reason character varying(30),
    obo_client_details_id character varying(20)
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
    display_index bigint DEFAULT 0,
    assertion_origin_source_id character varying(19),
    assertion_origin_client_source_id character varying(20)
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
    group_id text,
    assertion_origin_source_id character varying(19),
    assertion_origin_client_source_id character varying(20)
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
    secret_for_2fa character varying(255),
    using_2fa boolean DEFAULT false,
    last_login timestamp without time zone,
    deprecating_admin character varying(19),
    deprecated_method character varying(20)
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
    external_identifiers_json json,
    assertion_origin_source_id character varying(19),
    assertion_origin_client_source_id character varying(20)
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
-- Name: profile_history_event; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.profile_history_event (
    id bigint NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    orcid character varying(19) NOT NULL,
    event_type character varying(50),
    comment text
);


ALTER TABLE public.profile_history_event OWNER TO orcid;

--
-- Name: profile_history_event_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.profile_history_event_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profile_history_event_seq OWNER TO orcid;

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
    display_index bigint DEFAULT 0,
    assertion_origin_source_id character varying(19),
    assertion_origin_client_source_id character varying(20)
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
-- Name: rejected_grouping_suggestion; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.rejected_grouping_suggestion (
    put_codes character varying(255) NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    orcid character varying(19) NOT NULL
);


ALTER TABLE public.rejected_grouping_suggestion OWNER TO orcid;

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
-- Name: research_resource; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.research_resource (
    id bigint NOT NULL,
    orcid character varying(255) NOT NULL,
    source_id character varying(255),
    client_source_id character varying(20),
    proposal_type character varying(150) NOT NULL,
    external_identifiers_json text NOT NULL,
    title character varying(1000) NOT NULL,
    translated_title character varying(1000),
    translated_title_language_code character varying(10),
    url character varying(350),
    display_index integer,
    start_day integer,
    start_month integer,
    start_year integer,
    end_day integer,
    end_month integer,
    end_year integer,
    visibility character varying(20),
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    assertion_origin_source_id character varying(19),
    assertion_origin_client_source_id character varying(20)
);


ALTER TABLE public.research_resource OWNER TO orcid;

--
-- Name: research_resource_item; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.research_resource_item (
    id bigint NOT NULL,
    research_resource_id bigint NOT NULL,
    resource_name character varying(1000) NOT NULL,
    resource_type character varying(150) NOT NULL,
    external_identifiers_json text NOT NULL,
    url character varying(350),
    item_index bigint NOT NULL
);


ALTER TABLE public.research_resource_item OWNER TO orcid;

--
-- Name: research_resource_item_org; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.research_resource_item_org (
    research_resource_item_id bigint NOT NULL,
    org_id bigint NOT NULL,
    org_index bigint NOT NULL
);


ALTER TABLE public.research_resource_item_org OWNER TO orcid;

--
-- Name: research_resource_item_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.research_resource_item_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.research_resource_item_seq OWNER TO orcid;

--
-- Name: research_resource_org; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.research_resource_org (
    research_resource_id bigint NOT NULL,
    org_id bigint NOT NULL,
    org_index bigint NOT NULL
);


ALTER TABLE public.research_resource_org OWNER TO orcid;

--
-- Name: research_resource_seq; Type: SEQUENCE; Schema: public; Owner: orcid
--

CREATE SEQUENCE public.research_resource_seq
    START WITH 1000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.research_resource_seq OWNER TO orcid;

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
    display_index bigint DEFAULT 0,
    assertion_origin_source_id character varying(19),
    assertion_origin_client_source_id character varying(20)
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
-- Name: validated_public_profile; Type: TABLE; Schema: public; Owner: orcid
--

CREATE TABLE public.validated_public_profile (
    orcid character varying(19) NOT NULL,
    date_created timestamp with time zone,
    last_modified timestamp with time zone,
    error text,
    valid boolean
);


ALTER TABLE public.validated_public_profile OWNER TO orcid;

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
    client_source_id character varying(20),
    assertion_origin_source_id character varying(19),
    assertion_origin_client_source_id character varying(20)
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
-- Name: external_identifier id; Type: DEFAULT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.external_identifier ALTER COLUMN id SET DEFAULT nextval('public.external_identifier_id_seq'::regclass);


--
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.address (id, date_created, last_modified, address_line_1, address_line_2, city, postal_code, state_or_province, orcid, is_primary, iso2_country, visibility, source_id, client_source_id, display_index, assertion_origin_source_id, assertion_origin_client_source_id) FROM stdin;
\.


--
-- Data for Name: affiliation; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.affiliation (institution_id, orcid, date_created, last_modified, role_title, start_date, affiliation_details_visibility, end_date, affiliation_type, department_name, affiliation_address_visibility) FROM stdin;
\.


--
-- Data for Name: backup_code; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.backup_code (id, date_created, last_modified, orcid, used_date, hashed_code) FROM stdin;
\.


--
-- Data for Name: biography; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.biography (id, orcid, biography, visibility, date_created, last_modified) FROM stdin;
\.


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
AF	AFGHANISTAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AX	ÅLAND ISLANDS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AL	ALBANIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
DZ	ALGERIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AS	AMERICAN SAMOA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AD	ANDORRA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AO	ANGOLA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AI	ANGUILLA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AQ	ANTARCTICA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AG	ANTIGUA AND BARBUDA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AR	ARGENTINA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AM	ARMENIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AW	ARUBA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AU	AUSTRALIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AT	AUSTRIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AZ	AZERBAIJAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BS	BAHAMAS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BH	BAHRAIN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BD	BANGLADESH	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BB	BARBADOS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BY	BELARUS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BE	BELGIUM	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BZ	BELIZE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BJ	BENIN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BM	BERMUDA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BT	BHUTAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BO	BOLIVIA, PLURINATIONAL STATE OF	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BQ	BONAIRE, SINT EUSTATIUS AND SABA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BA	BOSNIA AND HERZEGOVINA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BW	BOTSWANA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BV	BOUVET ISLAND	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BR	BRAZIL	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
IO	BRITISH INDIAN OCEAN TERRITORY	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BN	BRUNEI DARUSSALAM	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BG	BULGARIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BF	BURKINA FASO	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BI	BURUNDI	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
KH	CAMBODIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CM	CAMEROON	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CA	CANADA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CV	CAPE VERDE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
KY	CAYMAN ISLANDS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CF	CENTRAL AFRICAN REPUBLIC	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TD	CHAD	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CL	CHILE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CN	CHINA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CX	CHRISTMAS ISLAND	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CC	COCOS (KEELING) ISLANDS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CO	COLOMBIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
KM	COMOROS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CG	CONGO	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CD	CONGO, THE DEMOCRATIC REPUBLIC OF THE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CK	COOK ISLANDS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CR	COSTA RICA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CI	CÔTE D'IVOIRE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
HR	CROATIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CU	CUBA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CW	CURAÇAO	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CY	CYPRUS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CZ	CZECH REPUBLIC	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
DK	DENMARK	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
DJ	DJIBOUTI	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
DM	DOMINICA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
DO	DOMINICAN REPUBLIC	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
EC	ECUADOR	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
EG	EGYPT	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SV	EL SALVADOR	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GQ	EQUATORIAL GUINEA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
ER	ERITREA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
EE	ESTONIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
ET	ETHIOPIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
FK	FALKLAND ISLANDS (MALVINAS)	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
FO	FAROE ISLANDS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
FJ	FIJI	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
FI	FINLAND	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
FR	FRANCE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GF	FRENCH GUIANA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
PF	FRENCH POLYNESIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TF	FRENCH SOUTHERN TERRITORIES	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GA	GABON	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GM	GAMBIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GE	GEORGIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
DE	GERMANY	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GH	GHANA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GI	GIBRALTAR	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GR	GREECE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GL	GREENLAND	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GD	GRENADA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GP	GUADELOUPE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GU	GUAM	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GT	GUATEMALA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GG	GUERNSEY	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GN	GUINEA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GW	GUINEA-BISSAU	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GY	GUYANA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
HT	HAITI	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
HM	HEARD ISLAND AND MCDONALD ISLANDS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
VA	HOLY SEE (VATICAN CITY STATE)	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
HN	HONDURAS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
HK	HONG KONG	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
HU	HUNGARY	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
IS	ICELAND	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
IN	INDIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
ID	INDONESIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
IR	IRAN, ISLAMIC REPUBLIC OF	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
IQ	IRAQ	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
IE	IRELAND	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
IM	ISLE OF MAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
IL	ISRAEL	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
IT	ITALY	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
JM	JAMAICA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
JP	JAPAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
JE	JERSEY	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
JO	JORDAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
KZ	KAZAKHSTAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
KE	KENYA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
KI	KIRIBATI	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
KP	KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
KR	KOREA, REPUBLIC OF	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
KW	KUWAIT	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
KG	KYRGYZSTAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
LA	LAO PEOPLE'S DEMOCRATIC REPUBLIC	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
LV	LATVIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
LB	LEBANON	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
LS	LESOTHO	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
LR	LIBERIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
LY	LIBYA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
LI	LIECHTENSTEIN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
LT	LITHUANIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
LU	LUXEMBOURG	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MO	MACAO	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MK	MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MG	MADAGASCAR	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MW	MALAWI	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MY	MALAYSIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MV	MALDIVES	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
ML	MALI	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MT	MALTA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MH	MARSHALL ISLANDS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MQ	MARTINIQUE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MR	MAURITANIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MU	MAURITIUS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
YT	MAYOTTE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MX	MEXICO	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
FM	MICRONESIA, FEDERATED STATES OF	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MD	MOLDOVA, REPUBLIC OF	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MC	MONACO	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MN	MONGOLIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
ME	MONTENEGRO	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MS	MONTSERRAT	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MA	MOROCCO	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MZ	MOZAMBIQUE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MM	MYANMAR	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
NA	NAMIBIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
NR	NAURU	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
NP	NEPAL	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
NL	NETHERLANDS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
NC	NEW CALEDONIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
NZ	NEW ZEALAND	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
NI	NICARAGUA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
NE	NIGER	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
NG	NIGERIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
NU	NIUE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
NF	NORFOLK ISLAND	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MP	NORTHERN MARIANA ISLANDS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
NO	NORWAY	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
OM	OMAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
PK	PAKISTAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
PW	PALAU	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
PS	PALESTINIAN TERRITORY, OCCUPIED	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
PA	PANAMA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
PG	PAPUA NEW GUINEA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
PY	PARAGUAY	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
PE	PERU	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
PH	PHILIPPINES	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
PN	PITCAIRN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
PL	POLAND	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
PT	PORTUGAL	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
PR	PUERTO RICO	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
QA	QATAR	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
RE	RÉUNION	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
RO	ROMANIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
RU	RUSSIAN FEDERATION	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
RW	RWANDA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
BL	SAINT BARTHÉLEMY	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SH	SAINT HELENA, ASCENSION AND TRISTAN DA CUNHA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
KN	SAINT KITTS AND NEVIS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
LC	SAINT LUCIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
MF	SAINT MARTIN (FRENCH PART)	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
PM	SAINT PIERRE AND MIQUELON	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
VC	SAINT VINCENT AND THE GRENADINES	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
WS	SAMOA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SM	SAN MARINO	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
ST	SAO TOME AND PRINCIPE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SA	SAUDI ARABIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SN	SENEGAL	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
RS	SERBIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SC	SEYCHELLES	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SL	SIERRA LEONE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SG	SINGAPORE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SX	SINT MAARTEN (DUTCH PART)	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SK	SLOVAKIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SI	SLOVENIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SB	SOLOMON ISLANDS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SO	SOMALIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
ZA	SOUTH AFRICA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GS	SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SS	SOUTH SUDAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
ES	SPAIN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
LK	SRI LANKA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SD	SUDAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SR	SURINAME	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SJ	SVALBARD AND JAN MAYEN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SZ	SWAZILAND	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SE	SWEDEN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
CH	SWITZERLAND	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
SY	SYRIAN ARAB REPUBLIC	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TJ	TAJIKISTAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TZ	TANZANIA, UNITED REPUBLIC OF	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TH	THAILAND	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TL	TIMOR-LESTE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TG	TOGO	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TK	TOKELAU	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TO	TONGA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TT	TRINIDAD AND TOBAGO	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TN	TUNISIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TR	TURKEY	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TM	TURKMENISTAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TC	TURKS AND CAICOS ISLANDS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TV	TUVALU	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
UG	UGANDA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
UA	UKRAINE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
AE	UNITED ARAB EMIRATES	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
GB	UNITED KINGDOM	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
US	UNITED STATES	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
UM	UNITED STATES MINOR OUTLYING ISLANDS	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
UY	URUGUAY	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
UZ	UZBEKISTAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
VU	VANUATU	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
VE	VENEZUELA, BOLIVARIAN REPUBLIC OF	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
VN	VIET NAM	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
VG	VIRGIN ISLANDS, BRITISH	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
VI	VIRGIN ISLANDS, U.S.	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
WF	WALLIS AND FUTUNA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
EH	WESTERN SAHARA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
YE	YEMEN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
ZM	ZAMBIA	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
ZW	ZIMBABWE	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
TW	TAIWAN	2019-01-24 16:44:01.822709+00	2019-01-24 16:44:01.822709+00
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
BASE-INSTALL	Declan Newman	/db/install.xml	2019-01-24 10:43:57.447714	1	EXECUTED	7:e3ff6b349022c50db4746a9dba19a21b	createTable (x29), addPrimaryKey (x11), addUniqueConstraint, addForeignKeyConstraint (x29)		\N	3.2.0
CREATE-SEQUENCES	Declan Newman	/db/install.xml	2019-01-24 10:43:57.514887	2	EXECUTED	7:fe0c16076881b71c52af9b1c2c950711	createSequence (x10)		\N	3.2.0
INIT-BASE-URL	Declan Newman	/db/data.xml	2019-01-24 10:43:57.525756	3	EXECUTED	7:42fdc88d808711833fca1da381148e51	insert		\N	3.2.0
INIT-HEAR_ABOUTS	Declan Newman	/db/data.xml	2019-01-24 10:43:57.550426	4	EXECUTED	7:ff0241b2d24d5fb9d380fbc680256cce	insert (x11)		\N	3.2.0
INIT-REGISTRATION-ROLE	Declan Newman	/db/data.xml	2019-01-24 10:43:57.573228	5	EXECUTED	7:86b47b717cb906700fd8bd6dab500685	insert (x10)		\N	3.2.0
INIT-SECURITY-QUESTIONS	Declan Newman	/db/data.xml	2019-01-24 10:43:57.601579	6	EXECUTED	7:a01ed6127361fd7d00679d4a737fc83f	insert (x19)		\N	3.2.0
INIT-SUBJECTS	Declan Newman	/db/data.xml	2019-01-24 10:43:57.785966	7	EXECUTED	7:16a3c94c5b6a1bd524049d838f24987a	insert (x149)		\N	3.2.0
ADD-TABLE-FOR-DELEGATION-OF-PERMISSIONS	will	/db/updates/0.2.xml	2019-01-24 10:43:57.810251	8	EXECUTED	7:7f5770c25eacf551c41216fdf08fc572	createTable, addPrimaryKey, addForeignKeyConstraint (x2)		\N	3.2.0
ADD-DATES-AND-ID-TO-DELEGATION-OF-PERMISSIONS	will	/db/updates/0.2.xml	2019-01-24 10:43:57.833387	9	EXECUTED	7:a63cb6b22727819f2ca523494dfab515	addColumn, dropPrimaryKey, addPrimaryKey		\N	3.2.0
ADD-SEQUENCE-FOR-DELEGATION-OF-PERMISSIONS	will	/db/updates/0.2.xml	2019-01-24 10:43:57.850862	10	EXECUTED	7:53ba9c19d87340918de6fb6028551def	createSequence		\N	3.2.0
ADD-VISIBILITY-ENUMS	Declan Newman	/db/updates/0.2.xml	2019-01-24 10:43:57.918687	11	EXECUTED	7:ac82b4e702654826daa7eec1158f8e42	addColumn (x3)		\N	3.2.0
DROP-KEYWORD-VISIBILITY	Declan Newman	/db/updates/0.2.xml	2019-01-24 10:43:57.935772	12	EXECUTED	7:882d6536719760806feaebd5a6c904d2	dropColumn		\N	3.2.0
ADD-OTHER_NAMES_VISIBILITY	Declan Newman	/db/updates/0.2.xml	2019-01-24 10:43:57.973103	13	EXECUTED	7:5546db3ba56954df8d64ca912556d718	addColumn		\N	3.2.0
CREATE-OAUTH-TABLES	Declan Newman	/db/updates/0.2.xml	2019-01-24 10:43:58.105214	14	EXECUTED	7:22741fb877a0a75b81a30eddfa295c68	createTable (x6), addPrimaryKey (x6), addForeignKeyConstraint (x5), createIndex (x6)		\N	3.2.0
ADD-VISIBILITY-FOR-WORKS-TO-PROFILE	james	/db/updates/0.2.xml	2019-01-24 10:43:58.144001	15	EXECUTED	7:c8c20b3752f7a719709e39df9576eef5	addColumn		\N	3.2.0
CHANGE_PAGE_NUMBERS_FROM_INTEGER_TO_STRING	will	/db/updates/0.2.xml	2019-01-24 10:43:58.183707	16	EXECUTED	7:5a6c1cffc387908a3c62b349ed6643ec	modifyDataType (x2)		\N	3.2.0
ADD-CLIENT_DETAILS_PROFILE_RELATIONSHIP	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:43:58.215385	17	EXECUTED	7:479a986e8aa9b8efd28bbd9ed655f203	addColumn, addForeignKeyConstraint		\N	3.2.0
ADD-GROUPS-AND-CLIENTS	Will Simpson	/db/updates/1.0.xml	2019-01-24 10:43:58.220869	18	EXECUTED	7:f701244fd917473d6a95f7d01672be39	addColumn		\N	3.2.0
REMOVE_ORCID_FROM_CLIENT_DETAILS	Will Simpson	/db/updates/1.0.xml	2019-01-24 10:43:58.227357	19	EXECUTED	7:149bbe7942652909d457840731cf96c4	dropForeignKeyConstraint, dropColumn		\N	3.2.0
CREATE-APPROVED-CLIENT-PROFILE-TABLE	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:43:58.243645	20	EXECUTED	7:60a008ecebcd230270637b2905ec8c2c	createTable, addForeignKeyConstraint (x2)		\N	3.2.0
ADD-PROFILE-DETAILS-PRIMARY-KEY	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:43:58.329368	21	EXECUTED	7:576a0133b34deeaae2abe174e2d4ff7f	addPrimaryKey		\N	3.2.0
CREATE-OAUTH2-REFRESH-TOKEN-DETAIL	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:43:58.393209	22	EXECUTED	7:13277cf968d4c0c9a8d9e03a47278b44	createTable, addUniqueConstraint, addForeignKeyConstraint (x2), createIndex (x4)		\N	3.2.0
CREATE-OAUTH2-TOKEN-DETAIL	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:43:58.474018	23	EXECUTED	7:e227e269224e184ae83a4a83311d4765	createTable, addUniqueConstraint (x2), addForeignKeyConstraint (x3), createIndex (x4)		\N	3.2.0
ADD-CLIENT-DETAILS-NAME-COLUMN	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:43:58.524807	24	EXECUTED	7:17611c5282ca0150e9aabfdf0cb9e1fa	addColumn		\N	3.2.0
CHANGE-CLIENT-DETAILS-CONSTRAINTS	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:43:58.678602	25	EXECUTED	7:9be2496773ebfdabd90b83c4de38868a	dropForeignKeyConstraint (x5), addForeignKeyConstraint (x5)		\N	3.2.0
CREATE-AUTHORIZATION-CODE_TABLES	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:43:58.761885	26	EXECUTED	7:bef3e7914d4bed01e88696404df856f9	createTable (x4), addPrimaryKey (x3), addForeignKeyConstraint (x5)		\N	3.2.0
ADD-OAUTH-AUTHORIZATION-CODE-INDEXES	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:43:59.408794	27	EXECUTED	7:c2b9ee18150ab89c96702370f2d8f683	createIndex (x5)		\N	3.2.0
ADD-PROFILE-INDEXES	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.002711	28	EXECUTED	7:f39e56f2c9b107db2510d7540d970671	createIndex (x2)		\N	3.2.0
DELETE-PROFILE-CLIENT-DETAILS-TABLE	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.009159	29	EXECUTED	7:832842bffe4d3d7abd37036668362069	dropTable		\N	3.2.0
CHANGE-TOKEN-PROFILE-COLUMN-NAME	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.021216	30	EXECUTED	7:6f6908a6dafb3c4fc49c94a1b9c46442	renameColumn		\N	3.2.0
CHANGE-REFRESH-TOKEN-PROFILE-COLUMN-NAME	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.030035	31	EXECUTED	7:7fa757ae9744e7b401772eb3e4025b9b	renameColumn		\N	3.2.0
UPDATE-TOKEN-CONSTRAINTS	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.427991	32	MARK_RAN	7:12e0f7f7b87011fabb322ec87de1fdc1	dropForeignKeyConstraint (x2), addForeignKeyConstraint (x2)		\N	3.2.0
PREPARE-TO-ADD-GENERATED-PK-TO-RESEARCHER-URL	Will Simpson	/db/updates/1.0.xml	2019-01-24 10:44:00.443067	33	EXECUTED	7:92b344b08549e4a24e5922c05e8e9a60	dropPrimaryKey, renameColumn, addUniqueConstraint		\N	3.2.0
ADD-SEQUENCE-FOR-RESEARCHER-URL-ID	Will Simpson	/db/updates/1.0.xml	2019-01-24 10:44:00.45677	34	EXECUTED	7:2fe5c9271183f64b0d12d6429a480182	createSequence, addColumn		\N	3.2.0
FINISH-ADDING-GENERATED-PK-TO-RESEARCHER-URL	Will Simpson	/db/updates/1.0.xml	2019-01-24 10:44:00.468682	35	EXECUTED	7:1ef1b584ca315aec466b6cba12b4a6ef	addPrimaryKey		\N	3.2.0
ADD-TIMESTAMPS-TO-PROFILE-KEYWORD-TABLE	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.490729	36	EXECUTED	7:0bf74bc3c1b6019ad5c57535b77e71fd	addColumn		\N	3.2.0
DROP-KEYWORD-TABLE	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.49725	37	EXECUTED	7:6bc5cf1fecb17e2fe3315738ea1f712f	dropForeignKeyConstraint, dropTable		\N	3.2.0
CREATE-KEYWORD-VIEW	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.507943	38	EXECUTED	7:88f4645da4f5eb7aaf455e525cd312c5	createView		\N	3.2.0
UPDATE-EXTERNAL-IDENTIFIER-PK	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.586929	39	MARK_RAN	7:a8324b26542129da74c7ddf98e5ff29d	dropPrimaryKey, addPrimaryKey		\N	3.2.0
DROP-REFRESH-TOKEN-TABLE	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.595016	40	EXECUTED	7:6c8fc766d808cc5658cfd4aac52225e2	dropForeignKeyConstraint, dropTable		\N	3.2.0
ADD-WEBHOOK-SCOPE-TO-ALL-CLIENTS	Will Simpson	/db/updates/webhooks.xml	2019-01-24 10:44:02.30035	123	EXECUTED	7:76cb33da4545705b1e0eda022f6af5e4	sql		\N	3.2.0
PREPARE-TO-ADD-REFRESH-DETAILS-TO-TOKEN-TABLE	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.604871	41	EXECUTED	7:c3a551b89ee54b790479b87dbaf4d171	dropPrimaryKey, dropNotNullConstraint, dropColumn		\N	3.2.0
ADD-REFRESH-DETAILS-TO-TOKEN-TABLE	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.718633	42	EXECUTED	7:b815feb1a9fc9f133b1027d5cd87f390	createSequence, addColumn (x3)		\N	3.2.0
ADD-TOKEN-DISABLED-COLUMN	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.813176	43	EXECUTED	7:a89b4b9595a388f05c38d526187c25e9	addColumn		\N	3.2.0
CHANGE-REFRESH-TOKEN-SCOPE-LENGTH	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.821751	44	EXECUTED	7:363680f6509969479d1d266339f64466	modifyDataType		\N	3.2.0
UPDATE-ACCESSION-NUM-PK	Declan Newman	/db/updates/1.0.xml	2019-01-24 10:44:00.840045	45	EXECUTED	7:c028dea5154a67c47a958a7bebd230dc	dropPrimaryKey, renameColumn, addPrimaryKey		\N	3.2.0
MAKE-SUBMISSION-DATE-NOT-NULL	Will Simpson	/db/updates/1.0.xml	2019-01-24 10:44:00.887812	46	EXECUTED	7:f2b88ce61f963476ebd1105627d93305	dropColumn, addColumn		\N	3.2.0
ADD-INDEXING-STATUS	Will Simpson	/db/updates/1.0.6.xml	2019-01-24 10:44:00.943566	47	EXECUTED	7:b05ab4857c67e88c86a42f4fb4903529	addColumn, createIndex		\N	3.2.0
MAKE-OAUTH2-STATE-COLUMN-BIGGER	Will Simpson	/db/updates/1.0.6.xml	2019-01-24 10:44:00.9485	48	EXECUTED	7:6ae9f582b63ed27a92c458b1aa35a507	modifyDataType		\N	3.2.0
ADD-WORK-ID-TO-AUTHORS	Will Simpson	/db/updates/1.0.8.xml	2019-01-24 10:44:00.982849	49	EXECUTED	7:33278f1449fe8db06ad3e1ed19854849	addColumn, createIndex, addForeignKeyConstraint, sql, dropTable (x2)		\N	3.2.0
ADD-WORK-ID-INDEXES	Will Simpson	/db/updates/1.0.8.xml	2019-01-24 10:44:01.004804	50	EXECUTED	7:81e27f6557bae65b8c0b8ba65ff26c23	createIndex (x2)		\N	3.2.0
ADD-ORCID-INDEXES	Will Simpson	/db/updates/1.0.8.xml	2019-01-24 10:44:01.068637	51	EXECUTED	7:ae0b584076d511032ca0a9e86355fe35	createIndex (x7)		\N	3.2.0
PER-WORK-VISIBILITY	Will Simpson	/db/updates/1.0.9.xml	2019-01-24 10:44:01.074756	52	EXECUTED	7:e3514a27394687de7b48a9b7c21e147a	addColumn, dropColumn		\N	3.2.0
POSTGRES-RENAME-ROLE-COLUMN	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.087493	53	EXECUTED	7:d7b531a404a42c4aa542f3f27bd81b54	renameColumn		\N	3.2.0
UPDATE-AND-RENAME-PRIMARY-PROFILE-INSTITUTION-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.096845	54	EXECUTED	7:8caf60fc41498f99acd81c140df730c3	addColumn, update, renameColumn, dropColumn, renameTable		\N	3.2.0
COPY-AND-DROP-PAST-PROFILE-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.106562	55	EXECUTED	7:a7e7185a751ece1b1e0d75c1631fbbb1	sql, dropTable, dropColumn		\N	3.2.0
COPY-AND-DROP-AFFILIATE-PROFILE-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.113478	56	EXECUTED	7:80321769c810894b34c0988b5fc1ef15	sql, dropTable		\N	3.2.0
CHANGE-WORK-PRIMARY-KEY-NAME	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.122086	57	EXECUTED	7:7ffafd88e38740aa194c0de63ba6a1e4	renameColumn		\N	3.2.0
ADD-WORK-EXTERNAL-URL	Declan Neaman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.144887	58	EXECUTED	7:1bc496e3d4b21f1451bccd2204f4d9d6	addColumn		\N	3.2.0
DROP-COLUMNS-OF-WORK-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.16093	59	EXECUTED	7:0522afa7f33395cf0ce4c15b03c1dd4e	dropColumn (x11)		\N	3.2.0
ADD-COLUMNS-TO-WORK-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.188764	60	EXECUTED	7:ba5b22c96876e4cd9db0219a07a5513d	addColumn		\N	3.2.0
CREATE-GRANT-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.219639	61	EXECUTED	7:fc63a012aeac73860f0857c6c47bbcef	createTable, addForeignKeyConstraint		\N	3.2.0
CREATE-FUNDING-GRANT-SEQUENCE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.23471	62	EXECUTED	7:0e55838ebceac72e000fd06062326c51	createSequence		\N	3.2.0
CREATE-PROFILE-GRANT-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.257218	63	EXECUTED	7:7e4169a76b6cb3071fe25d1ff542bc41	createTable, addForeignKeyConstraint (x2), addPrimaryKey		\N	3.2.0
CREATE-PATENT-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.28439	64	EXECUTED	7:c69c60da879b67253145efdcfff07f71	createTable		\N	3.2.0
CREATE-PATENT-SEQUENCE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.30106	65	EXECUTED	7:3ca217b0258aa2e4f22c6086448d239f	createSequence		\N	3.2.0
CREATE-PROFILE-PATENT-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.326577	66	EXECUTED	7:09f5ca3d378ff986becdbde506db43f2	createTable, addForeignKeyConstraint (x2), addPrimaryKey		\N	3.2.0
CREATE-WORK-SOURCE-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.350525	67	EXECUTED	7:64b637fdeb21dd8ad173ffe60e5b0034	createTable, addPrimaryKey, addForeignKeyConstraint (x3)		\N	3.2.0
CREATE-GRANT-SOURCE-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.374277	68	EXECUTED	7:a17055d356e0d9cb976ba44e577691be	createTable, addPrimaryKey, addForeignKeyConstraint (x3)		\N	3.2.0
CREATE-PATENT-SOURCE-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.394663	69	EXECUTED	7:d08299d9817ce47e587842bbb70e0a08	createTable, addPrimaryKey, addForeignKeyConstraint (x3)		\N	3.2.0
DROP-AUTHOR-OTHER-NAME-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.401731	70	EXECUTED	7:981ae57de1cf37ca4544e6312429772f	dropTable		\N	3.2.0
RENAME-AUTHOR-TABLE-TO-WORK-CONTRUBUTOR	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.412578	71	EXECUTED	7:fb3303a208c0addc441999716f67fba4	renameTable, renameColumn, addColumn, dropColumn (x4)		\N	3.2.0
CREATE-GRANT-CONTRIBUTOR	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.441432	72	EXECUTED	7:cca2da7629a29a63ab9f77c0a12523ec	createTable, addForeignKeyConstraint (x2)		\N	3.2.0
CREATE-PATENT-CONTRIBUTOR	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.469135	73	EXECUTED	7:abbf100f2910d790adbdd3bdabf15e86	createTable, addForeignKeyConstraint (x2)		\N	3.2.0
CREATE-WORK-EXTERNAL-IDENTIFIER-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.487554	74	EXECUTED	7:80a43a4f188533bc7dde33e7d2ea7581	createTable, addPrimaryKey, addForeignKeyConstraint		\N	3.2.0
CREATE-CONTRIBUTOR-SEQUENCES	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.503009	75	EXECUTED	7:9217f15a7e7c95a48ea8327980d56940	renameTable, createSequence (x2)		\N	3.2.0
DROP-ACCESSION-NUM-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.511772	76	EXECUTED	7:5b8ad07f6ba85c05c4e19a087ad6c31e	dropTable		\N	3.2.0
DROP-ELECTRONIC-RESOURCE-NUM-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.517288	77	EXECUTED	7:71de64c5660c7c7713856df52938d6c3	dropTable		\N	3.2.0
DROP-RELATED-URL-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.52264	78	EXECUTED	7:84a9c0315c8ba59ea0929aa67d2c682a	dropTable		\N	3.2.0
DROP-INSTITUTION-DEPARTMENT-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.527913	79	EXECUTED	7:8fcda4a7bdd9a9f74f14467828d2099a	dropTable		\N	3.2.0
ADD-VISIBILITY-TO-RESEARCHER-URL-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.557983	80	EXECUTED	7:183d41af4145562687625c807d0a839f	addColumn		\N	3.2.0
ALTER-PROFILE-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.576171	81	EXECUTED	7:ba5629f957cc0115e64043ce956cce8c	renameColumn (x7), update, addColumn, dropColumn		\N	3.2.0
ALTER-EXTERNAL-IDENTIFIER-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.606291	82	EXECUTED	7:10ae00e58cf67f3b05687a179eef7f11	delete, dropPrimaryKey, dropColumn (x2), addColumn, addPrimaryKey, addForeignKeyConstraint		\N	3.2.0
ADD-ALTERNATE-EMAIL-TABLE	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.630011	83	EXECUTED	7:f9dd71458c677bd9e0e49d2717fe0be1	createTable, addPrimaryKey, addForeignKeyConstraint		\N	3.2.0
UPDATE-PROTECTED-VISIBILITY-VALUES	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.634795	84	MARK_RAN	7:9bc87554bb89e6b69eff486e57c05d0f	update (x10)		\N	3.2.0
UPDATE-PROTECTED-SCOPE-TO-LIMITED	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.642518	85	EXECUTED	7:a7d042a1c00fd0aa900d390c8df14756	delete, update (x5)		\N	3.2.0
UPDATE-SCOPES-OAUTH-TOKEN-DETAIL	Declan Newman	/db/updates/1.0.9.xml	2019-01-24 10:44:01.64874	86	EXECUTED	7:34e8a40b9e3e3f2a4a3476126b04b8fc	update (x5)		\N	3.2.0
FIX-WORKS-READ-LIMITED-SCOPE	Will Simpson	/db/updates/1.0.11.xml	2019-01-24 10:44:01.651851	87	EXECUTED	7:8b87c5301fd03f602a9fa3b1e6685226	sql		\N	3.2.0
ADD-CONTRIBUTOR-ATTRIBUTE-CONSTRAINTS	Will Simpson	/db/updates/1.0.11.xml	2019-01-24 10:44:01.660503	88	EXECUTED	7:832d7bfd78449af8d73f26c27e008822	addNotNullConstraint (x6)		\N	3.2.0
ADD-PROFILE-ADDRESS-VISIBILITY	James Bowen	/db/updates/1.0.14.xml	2019-01-24 10:44:01.665512	89	EXECUTED	7:c6ca877537e558c97819fbafb1aa3b7f	addColumn		\N	3.2.0
ADD-AFFILATION_ADDRESS-VISIBILITY	James Bowen	/db/updates/1.0.14.xml	2019-01-24 10:44:01.669553	90	EXECUTED	7:5395dd662d6d492facc0c9b1423068b2	addColumn		\N	3.2.0
ADD-EMAIL-VERIFIED	Will Simpson	/db/updates/1.0.15.xml	2019-01-24 10:44:01.732571	91	EXECUTED	7:efa5be79137fe92fa83366dd20df0901	addColumn		\N	3.2.0
RENAME-EMAIL-PREFERENCES	Will Simpson	/db/updates/1.0.15.xml	2019-01-24 10:44:01.737519	92	EXECUTED	7:7aa9a37c80f92255614d4b71a00dc082	renameColumn (x2), dropColumn		\N	3.2.0
ADD_PREDEFINED_REDIRECT_SCOPE_FOR_CLIENT	James Bowen	/db/updates/1.0.16.xml	2019-01-24 10:44:01.741914	93	EXECUTED	7:df0a1dae575ccf11f758193edcf41719	addColumn		\N	3.2.0
ALTER_PREDEFINED_REDIRECT_SCOPE_LENGTH	James Bowen	/db/updates/1.0.17.xml	2019-01-24 10:44:01.745766	94	EXECUTED	7:5844d23b23f165b03449c396cd58b771	modifyDataType		\N	3.2.0
ALTER_DEFAULT_SECURITY_QUESTION_VALUE	James Bowen	/db/updates/1.0.18.xml	2019-01-24 10:44:01.749465	95	EXECUTED	7:f9bbd03b0fc8892406e41c49e531d2ee	sql		\N	3.2.0
ADD_DEACTIVATION_DATE_TO_PROFILE	James Bowen	/db/updates/1.0.18.xml	2019-01-24 10:44:01.753336	96	EXECUTED	7:422cb17a27f3c349c63bd21497494787	addColumn		\N	3.2.0
ADD-CITATION-TYPE-COLUMN-TO-WORK-TABLE	Declan Newman	/db/updates/1.0.18.xml	2019-01-24 10:44:01.757066	97	EXECUTED	7:91ebed30f144b239aba119e1c3ca9699	addColumn		\N	3.2.0
ALTER-CITATION-COLUMN-LENGTH	Declan Newman	/db/updates/1.0.18.xml	2019-01-24 10:44:01.760985	98	EXECUTED	7:a443c225a1362b2311e5d2f259c05637	modifyDataType		\N	3.2.0
REMOVE_REGISTRATION_ENTITY	James Bowen	/db/updates/1.0.19.xml	2019-01-24 10:44:01.765521	99	EXECUTED	7:0ec51d68c90197669314e546f7e84a6b	dropTable		\N	3.2.0
ADD_EXTERNAL_IDENTIFIER_REFERENCE_DATA	James Bowen	/db/updates/1.0.19.xml	2019-01-24 10:44:01.786361	100	EXECUTED	7:e52919bc80bb67498a38a203ffba57e8	createTable		\N	3.2.0
INIT_EXTERNAL_IDENTIFIER_REFERENCE_DATA	James Bowen	/db/updates/1.0.19.xml	2019-01-24 10:44:01.803637	101	EXECUTED	7:6552ebf8376e06b62ef3e0c1030104db	insert (x21)		\N	3.2.0
ADD_COUNTRY_REFERENCE_DATA	James Bowen	/db/updates/1.0.19.xml	2019-01-24 10:44:01.818605	102	EXECUTED	7:f3a7731d514f45c57f660209ee6f4ebb	createTable		\N	3.2.0
INIT_COUNTRY_REFERENCE_DATA	James Bowen	/db/updates/1.0.19.xml	2019-01-24 10:44:01.998562	103	EXECUTED	7:6d3459fe2a38d61776aa6e5a32ddae5a	insert (x249)		\N	3.2.0
DROP-NOT-NULL-CONSTRAINTS-FROM-CONTRIBUTOR-TYPES	Declan Newman	/db/updates/1.0.19.xml	2019-01-24 10:44:02.051541	104	EXECUTED	7:30c5d64520a1eed71ae47576d58a0094	dropNotNullConstraint (x6)		\N	3.2.0
DROP-EXTERNAL-ID-REF-DATA-TABLE	Declan Newman	/db/updates/1.0.19.xml	2019-01-24 10:44:02.059685	105	EXECUTED	7:6c7d147392d5d46f47241d4a4606ef90	dropTable		\N	3.2.0
MIGRATE_BIBLE_TO_RELIGIOUS_TEXT	James Bowen	/db/updates/1.0.22.xml	2019-01-24 10:44:02.065316	106	EXECUTED	7:043a755bf2294ce86ea259865dfff87b	update		\N	3.2.0
MIGRATE_TAIWAN	James Bowen	/db/updates/1.1.13.xml	2019-01-24 10:44:02.07139	107	EXECUTED	7:4cabfd5b6b574e1c9b2b11781e8cf336	update		\N	3.2.0
INCREASE_BIOGRAPHY_LENGTH	James Bowen	/db/updates/1.1.3.4.xml	2019-01-24 10:44:02.077429	108	EXECUTED	7:e963539dde49e2a3044dc1d9c13c31a8	modifyDataType		\N	3.2.0
ADD-SOURCE-TO-PROFILE-WORKS	Angel Montenegro	/db/updates/add-source-to-profile-works.xml	2019-01-24 10:44:02.085038	109	EXECUTED	7:23d560d9a77f333ac158643b13716d9f	addColumn, dropForeignKeyConstraint, addForeignKeyConstraint		\N	3.2.0
ADD-WORK-VISIBILITY-DEFAULT	Will Simpson	/db/updates/works-global-priv-setting.xml	2019-01-24 10:44:02.148879	110	EXECUTED	7:20f9c025f646feb5b224cb0489b02e1d	addColumn		\N	3.2.0
MAKE-WORK-VISIBILITY-NOT-NULL	Will Simpson	/db/updates/works-global-priv-setting.xml	2019-01-24 10:44:02.153425	111	EXECUTED	7:44a9ed88998477dc97ba1e61d6ca93ee	addNotNullConstraint		\N	3.2.0
CREATE-NEW-EMAIL-TABLE	Will Simpson	/db/updates/multiple-emails.xml	2019-01-24 10:44:02.180497	112	EXECUTED	7:a3365946bc35cdcd1a1276b8ea8e18d9	createTable, addPrimaryKey, addForeignKeyConstraint		\N	3.2.0
ADD-LAST-INDEXED-DATE-TO-PROFILE	Will Simpson	/db/updates/claim-wait-period.xml	2019-01-24 10:44:02.185296	113	EXECUTED	7:0c4891dc583fd3d0f6513b36d3a704b6	addColumn		\N	3.2.0
CREATE-PROFILE-EVENT-TABLE	Will Simpson	/db/updates/claim-wait-period.xml	2019-01-24 10:44:02.199042	114	EXECUTED	7:875552543f36cc987efca660a05e0517	createTable, addForeignKeyConstraint		\N	3.2.0
CREATE-PROFILE-EVENT-SEQUENCE	Will Simpson	/db/updates/claim-wait-period.xml	2019-01-24 10:44:02.205022	115	EXECUTED	7:85fffe53c55afb98ef6cf0b3da636018	createSequence		\N	3.2.0
CREATE-NEW-EMAIL-TABLE	Will Simpson	/db/updates/increase-citation-size-limit.xml	2019-01-24 10:44:02.209841	116	EXECUTED	7:85d40e52b2181171907affe15d54ed35	modifyDataType		\N	3.2.0
ADD-CASE-INSENSITIVE-UNIQUE-CONSTRAINT-TO-EMAIL	Will Simpson	/db/updates/fix-email-case-sensitivity.xml	2019-01-24 10:44:02.222865	117	EXECUTED	7:9a666c6a88e8d5057c914c5612495bab	createIndex		\N	3.2.0
ADD-EMAIL-SOURCE	Will Simpson	/db/updates/email-source.xml	2019-01-24 10:44:02.230042	118	EXECUTED	7:2daa3b8049ee5bfe7e2d07f587de8bcc	addColumn, addForeignKeyConstraint		\N	3.2.0
CREATE-WEBHOOK-TABLE	Will Simpson	/db/updates/webhooks.xml	2019-01-24 10:44:02.258318	119	EXECUTED	7:3c01d2b94fad11a4b2583dfbebcb7b27	createTable, addPrimaryKey, addForeignKeyConstraint (x2)		\N	3.2.0
ADD-WEBHOOKS-ENABLED-TO-CLIENT-DETAILS	Will Simpson	/db/updates/webhooks.xml	2019-01-24 10:44:02.288167	120	EXECUTED	7:5b30e60a66369f4481252c95991642a3	addColumn		\N	3.2.0
CREATE-UNIX-TIMESTAMP-FUCTION	Will Simpson	/db/updates/webhooks.xml	2019-01-24 10:44:02.293142	121	EXECUTED	7:55f0e764852738129fa995f3b93e351d	createProcedure		\N	3.2.0
ADD-LAST-SENT-DATE-TO-WEBHOOK	Will Simpson	/db/updates/webhooks.xml	2019-01-24 10:44:02.297369	122	EXECUTED	7:755b97fc95f79797d81a27dfe495952f	addColumn		\N	3.2.0
INCREASE-IDENTIFIER-LENGTH	Angel Montenegro	/db/updates/increase-work-external-identifier-length.xml	2019-01-24 10:44:02.314354	124	EXECUTED	7:bc9f0e762fcc5c07de84167a1666d657	modifyDataType		\N	3.2.0
ADD-REDIRECT-TYPE-COLUMN	rcpeters	/db/updates/add_client_redir_type.xml	2019-01-24 10:44:02.344234	125	EXECUTED	7:702073f4f36efe4832ee11c571e84595	addColumn		\N	3.2.0
DEFINE-IMPORT-WORKS-WIZARD	RCPETERS	/db/updates/define-import-works-wizard.xml	2019-01-24 10:44:02.347468	126	EXECUTED	7:69130f73c26db5032aa7dfcda413efb1	sql		\N	3.2.0
REMOVE-OLD-WAY-OF-DOING-EMAILS	Will Simpson	/db/updates/remove-old-way-of-doing-emails.xml	2019-01-24 10:44:02.354955	127	EXECUTED	7:a8256b98d4f812359b4d5c00ca559d9c	dropColumn (x4), dropTable		\N	3.2.0
ADD-LOCALE	rcpeters	/db/updates/locale-setting.xml	2019-01-24 10:44:02.410401	128	EXECUTED	7:a80dcb0b59edcfad0d2aecfabe50894d	addColumn		\N	3.2.0
REFACTOR_LOCALE_DROP_DEFAULT	RCPETERS	/db/updates/locale-refactor-setting.xml	2019-01-24 10:44:02.415179	129	EXECUTED	7:41dae5a279738ec048ce711dd509b1e6	dropDefaultValue		\N	3.2.0
REFACTOR_LOCALE_ADD_DEFAULT	RCPETERS	/db/updates/locale-refactor-setting.xml	2019-01-24 10:44:02.419681	130	EXECUTED	7:54ef9a463c39fe79c56d0fabb25b0b36	addDefaultValue		\N	3.2.0
REFACTOR_LOCALE_EN	RCPETERS	/db/updates/locale-refactor-setting.xml	2019-01-24 10:44:02.422453	131	EXECUTED	7:3a8a942bf38fb0b6419264297958f102	sql		\N	3.2.0
REFACTOR_LOCALE_FR	RCPETERS	/db/updates/locale-refactor-setting.xml	2019-01-24 10:44:02.42511	132	EXECUTED	7:348a7e90884569ed9bc0ee4031d40b5c	sql		\N	3.2.0
REFACTOR_LOCALE_ES	RCPETERS	/db/updates/locale-refactor-setting.xml	2019-01-24 10:44:02.427667	133	EXECUTED	7:346a2a76ac8a8d9acd175f00be04beab	sql		\N	3.2.0
REFACTOR_LOCAL_ZH_CN	RCPETERS	/db/updates/locale-refactor-setting.xml	2019-01-24 10:44:02.430243	134	EXECUTED	7:7605b93cbe621e49097715ca91901f92	sql		\N	3.2.0
REFACTOR_LOCAL_ZH_TW	RCPETERS	/db/updates/locale-refactor-setting.xml	2019-01-24 10:44:02.432813	135	EXECUTED	7:7843959edb3717e887ca6540cf657cb1	sql		\N	3.2.0
ADD-KEY-TO-SECURITY-QUESTION	Angel Montenegro	/db/updates/add-key-to-security-questions.xml	2019-01-24 10:44:02.44494	136	EXECUTED	7:ac2cb723d2463bec57cd23facd24723b	addColumn, update (x19)		\N	3.2.0
CREATE-NEW-EMAIL-TABLE	RCPETERS	/db/updates/increase-bio-text-size-limit.xml	2019-01-24 10:44:02.452108	137	EXECUTED	7:55b75b4de558379be37468db1e0a0176	modifyDataType		\N	3.2.0
CREATE-ORG-TABLES	Will Simpson	/db/updates/disambiguated_affiliations.xml	2019-01-24 10:44:02.506009	138	EXECUTED	7:c47d8e7e8db5da2afed5132c60a53f1b	createTable (x2), addUniqueConstraint, addForeignKeyConstraint (x2)		\N	3.2.0
CREATE-ORG-SEQUENCES	Will Simpson	/db/updates/disambiguated_affiliations.xml	2019-01-24 10:44:02.511028	139	EXECUTED	7:e9695acb68c3b064099ea9f089d896a5	createSequence (x2)		\N	3.2.0
MAKE-SURE-COUNTRY-IS-NULL-NOT-EMPTY-STRING	Will Simpson	/db/updates/disambiguated_affiliations.xml	2019-01-24 10:44:02.514155	140	EXECUTED	7:b011a44397e8895b50c9a8052baa4ab2	sql		\N	3.2.0
CREATE-DISAMBIGUATED-ORG-TABLES	Will Simpson	/db/updates/disambiguated_affiliations.xml	2019-01-24 10:44:02.56573	141	EXECUTED	7:0cb778c9d3a429c8006964d51e61dae6	createTable, addUniqueConstraint, createTable, addForeignKeyConstraint, addColumn, addForeignKeyConstraint		\N	3.2.0
CREATE-ORG-DISAMBIGUATED-SEQUENCES	Will Simpson	/db/updates/disambiguated_affiliations.xml	2019-01-24 10:44:02.570915	142	EXECUTED	7:62516dd1d89b16ceb13ac4deeb9cbc98	createSequence (x2)		\N	3.2.0
ADD-AFFILIATION-SCOPES-TO-EXISTING-CLIENTS	Will Simpson	/db/updates/disambiguated_affiliations.xml	2019-01-24 10:44:02.574846	143	EXECUTED	7:474bb1051a50c880acc60acbdd7c42e0	sql (x2)		\N	3.2.0
ADD-AFFILIATION-READ-LIMITED-SCOPE-TO-EXISTING-CLIENTS	Will Simpson	/db/updates/disambiguated_affiliations.xml	2019-01-24 10:44:02.57787	144	EXECUTED	7:d1bc7b9b7b2f653fdbcf2fc5e9a1ad66	sql		\N	3.2.0
INSERT-DUMMY-DISAMBIGUATED-VALUES-FOR-TESTING	Will Simpson	/db/updates/disambiguated_affiliations.xml	2019-01-24 10:44:02.588033	145	EXECUTED	7:217e2a189f45aade0c40e17e62ca6334	sql		\N	3.2.0
ADD-INDEXING-AND-POPULARTIY-COLUMNS-TO-ORG-DISAMBIGUATED	Will Simpson	/db/updates/disambiguated_affiliations.xml	2019-01-24 10:44:02.644158	146	EXECUTED	7:14dd9374db34da983c116036c76eb01f	addColumn (x3)		\N	3.2.0
ADD-VIEW-OF-AMBIGUOUS-ORGS	Will Simpson	/db/updates/disambiguated_affiliations.xml	2019-01-24 10:44:02.650068	147	EXECUTED	7:4f57818b467ba9dea75fb34f4c4afac8	createView		\N	3.2.0
ADD-CLIENT-TYPE-AND-GROUP-TYPE-COLUMNS	Angel Montenegro	/db/updates/add-client-type-and-group-type-to-profile-table.xml	2019-01-24 10:44:03.038379	148	EXECUTED	7:4da014c73e25456edf5b0cfb977e5527	addColumn, sql (x419)		\N	3.2.0
MERGE-CrossRef-GROUPS	Angel Montenegro	/db/updates/add-client-type-and-group-type-to-profile-table.xml	2019-01-24 10:44:03.05866	149	EXECUTED	7:301ed44e6df8edfa76517214bf8e81d7	sql		\N	3.2.0
MERGE-Elsevier-GROUPS	Angel Montenegro	/db/updates/add-client-type-and-group-type-to-profile-table.xml	2019-01-24 10:44:03.065172	150	EXECUTED	7:454819d4ef7b0bf565fc6704c31e4322	sql		\N	3.2.0
ADD-CONTRIBUTORS-JSON-COLUMN	Will Simpson	/db/updates/work-contributors-as-json.xml	2019-01-24 10:44:03.071884	151	EXECUTED	7:1022c9252072eecead191b9a888734f5	addColumn		\N	3.2.0
ADD-DEPRECATION-FIELDS-TO-PROFILE	Angel Montenegro	/db/updates/profile_deprecation_project.xml	2019-01-24 10:44:03.077168	152	EXECUTED	7:1df04ff19c2dadd79bf632bd4ba74965	addColumn		\N	3.2.0
ADD-COMMENT-COLUMN-TO-PROFILE-EVENT	Angel Montenegro	/db/updates/profile_deprecation_project.xml	2019-01-24 10:44:03.084263	153	EXECUTED	7:2445e7d0aef730bfc257ed35869adbd4	addColumn		\N	3.2.0
CREATE-EMAIL-EVENT-TABLE	RCPETERS	/db/updates/email_event.xml	2019-01-24 10:44:03.105506	154	EXECUTED	7:3d032c10d468016c8d75cd089b68a2da	createTable, addForeignKeyConstraint		\N	3.2.0
CREATE-EMAIL-EVENT-SEQUENCE	RCPETERS	/db/updates/email_event.xml	2019-01-24 10:44:03.110408	155	EXECUTED	7:8488848d72dce90487d35d86b2be6a2f	createSequence		\N	3.2.0
MARK_EMAILS_TO_SKIP	RCPETERS	/db/updates/email_event.xml	2019-01-24 10:44:03.113482	156	EXECUTED	7:8aa8f0652529170d34b8ebc0d50546d6	sql		\N	3.2.0
WEBHOOKS_PROFILE_MODIFIED	rcpeters	/db/updates/profile_hook_date.xml	2019-01-24 10:44:03.118035	157	EXECUTED	7:9cc42d7d6be8b6e3133b3247862b9c82	sql		\N	3.2.0
ADD-JOURNAL-TITLE-COLUMN-TO-WORK-TABLE	Angel Montenegro	/db/updates/add_journal_title_to_works.xml	2019-01-24 10:44:03.122334	158	EXECUTED	7:a93fef0dc0595e935a2d1bbef40d1c50	addColumn		\N	3.2.0
ADD-FIELDS-TO-WORK-TABLE	Angel Montenegro	/db/updates/add_fields_to_work.xml	2019-01-24 10:44:03.12763	159	EXECUTED	7:4ab5b6be8e61f1df362523a6543a17f2	addColumn		\N	3.2.0
AFF_MIGRATE_RELATIONSHIP	RCPETERS	/db/updates/disambiguated_affiliations_migrate_types.xml	2019-01-24 10:44:03.130376	160	EXECUTED	7:7806de63e997f57209dac481b3a76aa0	sql		\N	3.2.0
UPDATE_WORK_TYPES	Angel Montenegro	/db/updates/update_work_types.xml	2019-01-24 10:44:03.141696	161	EXECUTED	7:90e252bb08cd1ef0839abcc0c89b0018	sql (x15)		\N	3.2.0
CREATE-FUNDING-TABLES	Angel Montenegro	/db/updates/disambiguated_fundings.xml	2019-01-24 10:44:03.198722	162	EXECUTED	7:071195e54cb46ff1d2fc26990cb525eb	createTable (x2), addUniqueConstraint, addForeignKeyConstraint (x3)		\N	3.2.0
CREATE-FUNDING-SEQUENCES	Angel Montenegro	/db/updates/disambiguated_fundings.xml	2019-01-24 10:44:03.239288	163	EXECUTED	7:68fb2026af95a6d079b0b49550d59aff	createSequence (x2)		\N	3.2.0
ADD-FUNDING-UPDATE-SCOPE-TO-EXISTING-CLIENTS	Angel Montenegro	/db/updates/disambiguated_fundings.xml	2019-01-24 10:44:03.243466	164	EXECUTED	7:9e738fbf8e92cb07aa86f2cddffdd27b	sql (x2)		\N	3.2.0
ADD-FUNDING-CREATE-SCOPE-TO-EXISTING-CLIENTS	Angel Montenegro	/db/updates/disambiguated_fundings.xml	2019-01-24 10:44:03.24796	165	EXECUTED	7:8cb7426d89060676be10c472c27dd6af	sql (x2)		\N	3.2.0
ADD-FUNDING-READ-LIMITED-SCOPE-TO-EXISTING-CLIENTS	Angel Montenegro	/db/updates/disambiguated_fundings.xml	2019-01-24 10:44:03.252574	166	EXECUTED	7:3eb6392850b74109c7f8720c53284412	sql (x2)		\N	3.2.0
UPDATE-OAUTH2-SCOPES	Angel Montenegro	/db/updates/disambiguated_fundings.xml	2019-01-24 10:44:03.257092	167	EXECUTED	7:e19c40f0104fe24c941a2048f783469c	sql (x3)		\N	3.2.0
change_creation_method_size	RCPETERS	/db/updates/change_creation_method_size.xml	2019-01-24 10:44:03.261544	168	EXECUTED	7:a47a20f1b1520029a9f62216b2bcb2d7	modifyDataType		\N	3.2.0
change_redirect_uri_type	RCPETERS	/db/updates/fundingImportWizard.xml	2019-01-24 10:44:03.265842	169	EXECUTED	7:9ed2de6b86f8064cfda1d05e55bc7c4f	modifyDataType		\N	3.2.0
change_client_redirect_uri_pkey	rcpeters	/db/updates/fundingImportWizard.xml	2019-01-24 10:44:03.278193	170	EXECUTED	7:b1fe378a44ac49192149513cd7cc13ce	sql		\N	3.2.0
DROP-EXISTING-CONSTRAINT	Angel Montenegro	/db/updates/fundings_modify_external_identifier_constraint.xml	2019-01-24 10:44:03.364673	171	EXECUTED	7:35dbde50dffbde23038854512ef7afcc	dropUniqueConstraint		\N	3.2.0
ADD-CONSTRAINT	Angel Montenegro	/db/updates/fundings_modify_external_identifier_constraint.xml	2019-01-24 10:44:03.927974	172	EXECUTED	7:b8fccfa4305518a2be6d945f2c0d5255	addUniqueConstraint		\N	3.2.0
SET_INDEXING_STATUS_TO_FALSE_ON_ORGS	Angel Montenegro	/db/updates/reindex_orgs_to_add_funding_information.xml	2019-01-24 10:44:03.931735	173	EXECUTED	7:e27e2385019ac84a59b694f0c368f626	sql		\N	3.2.0
REMOVE-NOT-NULL-RESTRICTION-ON-AMOUNT	Angel Montenegro	/db/updates/amount_is_not_required_on_fundings.xml	2019-01-24 10:44:03.936559	174	EXECUTED	7:09fcf4d148e64238bd5589d7ace56dad	dropNotNullConstraint (x2)		\N	3.2.0
reset_funding_contributors	rcpeters	/db/updates/resetFundingContributors.xml	2019-01-24 10:44:03.939381	175	EXECUTED	7:afb800e770aa21e87a5b4bc73c7a2655	sql		\N	3.2.0
CLAIM-ALL-GROUPS	Angel Montenegro	/db/updates/claim_all_groups.xml	2019-01-24 10:44:03.94217	176	EXECUTED	7:0bab412fcf8525ecf258defcdbd57dfb	sql		\N	3.2.0
REFERRED-BY	rcpeters	/db/updates/referred-by.xml	2019-01-24 10:44:03.946034	177	EXECUTED	7:01237a16aec570c0860a4eabdf29d1ce	addColumn		\N	3.2.0
REMOVE-UNUSED-COLUMNS-FROM-AUTHORIZATION-CODE-TABLE	Will Simpson	/db/updates/tidy-authorization-code-table.xml	2019-01-24 10:44:03.950196	178	EXECUTED	7:25d313012304b24e08f9928e225e73fa	dropColumn (x2)		\N	3.2.0
RENAME-TO-ACTIVIES-DEFAULT	rcpeters	/db/updates/activities_default.xml	2019-01-24 10:44:03.95361	179	EXECUTED	7:29e554f08265e45b4d49debee4e25ad7	renameColumn		\N	3.2.0
ADD-ENABLE-DEVELOPER-TOOLS	Angel Montenegro	/db/updates/add_developer_tools_to_profile.xml	2019-01-24 10:44:04.035696	180	EXECUTED	7:905ca4fd870e490291660722c2475902	addColumn		\N	3.2.0
SET-ALL-TO-FALSE	Angel Montenegro	/db/updates/add_developer_tools_to_profile.xml	2019-01-24 10:44:04.03875	181	EXECUTED	7:5663c01f9ba57282f1526c711bffd500	sql		\N	3.2.0
CREATE-ORCID-PROPS-TABLE	Angel Montenegro	/db/updates/orcid_props_table.xml	2019-01-24 10:44:04.066836	182	EXECUTED	7:53220cbd9f9c8abb75a7150e50c45943	createTable		\N	3.2.0
CLAIM-ALL-CLIENTS	Angel Montenegro	/db/updates/claim_all_clients.xml	2019-01-24 10:44:04.069582	183	EXECUTED	7:fcb0a35f3f1493483124e15b091f0a8c	sql		\N	3.2.0
ADD-DESCRIPTION-AND-WEBSITE-TO-CLIENT-DETAILS	Angel Montenegro	/db/updates/db_changes_for_sso.xml	2019-01-24 10:44:04.074025	184	EXECUTED	7:1f363deb96ab9647c942be17f75b3a39	addColumn		\N	3.2.0
COPY-CREDIT-NAME-AND-DESCRIPTION-FROM-PROFILE-TABLE	Angel Montenegro	/db/updates/db_changes_for_sso.xml	2019-01-24 10:44:04.077214	185	EXECUTED	7:3e9b55651e5dc7669eacf156ecf6d287	sql		\N	3.2.0
COPY-RESEARCHER-URL-TO-CLIENT-DETAILS-TABLE	Angel Montenegro	/db/updates/db_changes_for_sso.xml	2019-01-24 10:44:04.079844	186	EXECUTED	7:a56515edbd9e35d3414d4c71ce45f7cf	sql		\N	3.2.0
SET-EMPTY-CLIENT-NAME-AND-DESCRIPTION-TO-UNDEFINED	Angel Montenegro	/db/updates/db_changes_for_sso.xml	2019-01-24 10:44:04.082562	187	EXECUTED	7:65cb0beea4c9c6b0aa3e3aaa735bfb00	sql		\N	3.2.0
SET-EMPTY-WEBSITE-TO-UNDEFINED	Angel Montenegro	/db/updates/db_changes_for_sso.xml	2019-01-24 10:44:04.085119	188	EXECUTED	7:58260b010d59bc359972d391d3a31c8c	sql		\N	3.2.0
MULTI-CLIENT-SECRET	Will Simpson	/db/updates/multi_client_secret.xml	2019-01-24 10:44:04.09769	189	EXECUTED	7:9e49df69f54d91e6b607e1e43602048c	createTable, sql, addForeignKeyConstraint		\N	3.2.0
SET-ALL-GROUP-EMAILS-TO-VERIFIED	Angel Montenegro	/db/updates/verify_all_group_emails.xml	2019-01-24 10:44:04.100656	190	EXECUTED	7:b4f07b820227b8079862d3afe4a23753	sql		\N	3.2.0
DROP_WORK_CONTRIBUTOR_2	RCPeters	/db/updates/drop_work_contributors_2.xml	2019-01-24 10:44:04.10947	191	MARK_RAN	7:9dcb4358dbc0e09a6965753f18f22b8c	dropTable, dropSequence		\N	3.2.0
CREATE-FUNDING-SUBTYPES-TO-INDEX-TABLE	Angel Montenegro	/db/updates/funding_sub_type_to_index_table.xml	2019-01-24 10:44:04.135697	192	EXECUTED	7:90499e627a23c0abf494273b5c0e22e7	createTable, addForeignKeyConstraint		\N	3.2.0
ADD-ORGANIZATION-DEFINED-TYPE-COLUMN	Angel Montenegro	/db/updates/add_organization_defined_type_to_funding.xml	2019-01-24 10:44:04.156939	193	EXECUTED	7:3907a0a006b66918dbf44843ec775e31	addColumn		\N	3.2.0
CREATE-CUSTOM-EMAILS-TABLE	Angel Montenegro	/db/updates/create_custom_emails_table.xml	2019-01-24 10:44:04.184702	194	EXECUTED	7:74cb05e108711808c4a344ad0a22351f	createTable, addForeignKeyConstraint		\N	3.2.0
ADD-NUMERIC-AMOUNT-TO-FUNDING	Angel Montenegro	/db/updates/add_numeric_amount_to_funding.xml	2019-01-24 10:44:04.189206	195	EXECUTED	7:1cfdc3eaf6f83ccdfad73fd30163ea2e	addColumn		\N	3.2.0
ADD-WORK-EXTERNAL-IDS-JSON-COLUMN	Will Simpson	/db/updates/work-external-ids-as-json.xml	2019-01-24 10:44:04.21847	196	EXECUTED	7:e1cba068309ff6ae561ad4a46f9209dc	addColumn		\N	3.2.0
CONVERT-TEXT-TO-JSON	Will Simpson	/db/updates/work-external-ids-as-json.xml	2019-01-24 10:44:05.010928	197	EXECUTED	7:59d7f7aeb42e754db84a5c2dd7044cdb	sql (x2), createProcedure (x2), createIndex		\N	3.2.0
ADD-PRIMARY-INDICATOR-TO-CLIENT-SECRET	Angel Montenegro	/db/updates/add_primary_indicator_to_client_secret.xml	2019-01-24 10:44:05.055548	198	EXECUTED	7:01707b2de872ab51f379cf3b2bbe6e87	addColumn		\N	3.2.0
WORK-ADD-DISPLAY-INDEX	rcpeters	/db/updates/work_display_index.xml	2019-01-24 10:44:05.068731	199	EXECUTED	7:6e9a2d900e39c0225d57adb3a6fc0237	addColumn		\N	3.2.0
CREATE-NOTIFICATIONS-TABLE	Will Simpson	/db/updates/notifications.xml	2019-01-24 10:44:05.09653	200	EXECUTED	7:deea322c197fc4a030f90fdaa29e7b9c	createTable, addForeignKeyConstraint (x2)		\N	3.2.0
ADD-SEQUENCE-FOR-NOTIFICATIONS	Will Simpson	/db/updates/notifications.xml	2019-01-24 10:44:05.118359	201	EXECUTED	7:04cf8a5c18ee3b437a813e9f1e1bbdcd	createSequence		\N	3.2.0
ADD-NOTIFICATION-FREQUENCY-TO-PROFILE-TABLE	Will Simpson	/db/updates/notifications.xml	2019-01-24 10:44:05.196176	202	EXECUTED	7:29b4ccf66810cfff696f15a08b6f812c	addColumn		\N	3.2.0
ADD-OPTION-TO-ENABLE-NOTIFICATIONS-PER-USER	Will Simpson	/db/updates/notifications.xml	2019-01-24 10:44:05.252101	203	EXECUTED	7:699219f46a19f2a9a3fb963887e714d8	addColumn		\N	3.2.0
ADD-OPTION-FOR-ORCID-FEATURE-ANNOUNCEMENTS	Will Simpson	/db/updates/notifications.xml	2019-01-24 10:44:05.256016	204	EXECUTED	7:cb3a5ab3405714be5845f994d408562e	addColumn		\N	3.2.0
ADD-ACTIVITIES-NOTIFICATION	Will Simpson	/db/updates/notifications.xml	2019-01-24 10:44:05.277392	205	EXECUTED	7:ba6dfb6f8e8dc4fb43a189d25b9084eb	createTable, addForeignKeyConstraint, addColumn, dropNotNullConstraint (x3)		\N	3.2.0
REMOVE-NOT-NULL-FROM-NOTIFICATION-ID-IN-NOTIFICATION-ACTIVITIES	Will Simpson	/db/updates/notifications.xml	2019-01-24 10:44:05.281493	206	EXECUTED	7:264b63e2538c24550ba305d41d388176	dropNotNullConstraint		\N	3.2.0
ADD-SEQUENCE-FOR-NOTIFICATION-ACTIVITIES	Will Simpson	/db/updates/notifications.xml	2019-01-24 10:44:05.303523	207	EXECUTED	7:0638ee5b4f60ddc47c636d6a80351b67	createSequence		\N	3.2.0
ADD-PREFERENCE-FOR-MEMBER-UPDATE-REQUESTS	Will Simpson	/db/updates/notifications.xml	2019-01-24 10:44:05.307847	208	EXECUTED	7:583219967e46c167cbe633dafc9057a6	addColumn		\N	3.2.0
UPDATE-NOTIFICATION-ACTIVITY-TYPE	Will Simpson	/db/updates/notifications.xml	2019-01-24 10:44:05.310771	209	EXECUTED	7:afbd558b3d91bbb68d11bec498aa9c0d	sql		\N	3.2.0
ADD-LANG-TO-NOTIFICATION	Will Simpson	/db/updates/notifications.xml	2019-01-24 10:44:05.315528	210	EXECUTED	7:520f2874cbf925faedc95b28ce1c4b96	addColumn		\N	3.2.0
SET-SEQUENCES-START	Will Simpson	/db/updates/set_sequences_start.xml	2019-01-24 10:44:05.324006	211	EXECUTED	7:30f947be35bed7d168e3b7308673e4e4	createProcedure, sql		\N	3.2.0
CREATE-ORCID-SOCIAL-TABLE	Angel Montenegro	/db/updates/create_orcid_social_table.xml	2019-01-24 10:44:05.351025	212	EXECUTED	7:054c055c25ad8b7775aacfe371207a96	createTable, addForeignKeyConstraint		\N	3.2.0
WORK-CONTRIBUTORS-TIDY-UP	Will Simpson	/db/updates/work-contributors-tidy-up.xml	2019-01-24 10:44:05.405044	213	EXECUTED	7:990287f26a4574630bc119bdbf5c3f08	dropForeignKeyConstraint		\N	3.2.0
ADD-ORCID-INDEX-FOR-AFFILIATIONS	Will Simpson	/db/updates/add-orcid-index-for-affiliations.xml	2019-01-24 10:44:06.041785	214	EXECUTED	7:337c1bbae22e98d121abe7dafd4199ac	createIndex		\N	3.2.0
ADD-SALESFORCE-ID-TO-PROFILE-TABLE	Angel Montenegro	/db/updates/add-salesforce-id-to-profile.xml	2019-01-24 10:44:06.071898	215	EXECUTED	7:71a99f2482b2a021365644e7c9751312	addColumn		\N	3.2.0
EXTERNAL-IDENTIFIERS_SOURCE	Will Simpson	/db/updates/external-identifiers-source.xml	2019-01-24 10:44:06.07722	216	EXECUTED	7:d58ee27ae23d3f42a09f78b02f03874d	dropForeignKeyConstraint, renameColumn, addForeignKeyConstraint		\N	3.2.0
FUNDING-ADD-DISPLAY-INDEX	rcpeters	/db/updates/funding_display_index.xml	2019-01-24 10:44:06.098764	217	EXECUTED	7:4d7b79bb98e8ffe7e320b5807bf5f52e	addColumn		\N	3.2.0
FUNDING-ADD-DISPLAY-INDEX-PATCH	rcpeters	/db/updates/funding_display_index_patch.xml	2019-01-24 10:44:06.101426	218	EXECUTED	7:ed0d747239710a6eb510decdbdbecaec	sql		\N	3.2.0
ADD-PERSISTENT-FLAG-TO-OAUTH2-AUTHORIZATION-CODE-DETAIL-TABLE	Angel Montenegro	/db/updates/persistent_tokens.xml	2019-01-24 10:44:06.160449	219	EXECUTED	7:32b73d643f06dd3b74d1808e2b501143	addColumn		\N	3.2.0
ADD-VERSION-FLAG-TO-OAUTH2-AUTHORIZATION-CODE-DETAIL-TABLE	Angel Montenegro	/db/updates/persistent_tokens.xml	2019-01-24 10:44:06.223112	220	EXECUTED	7:e66148a7828e3499f8104bf54933b82a	addColumn		\N	3.2.0
ADD-PERSISTENT-FLAG-TO-OAUTH2-TOKEN-DETAIL-TABLE	Angel Montenegro	/db/updates/persistent_tokens.xml	2019-01-24 10:44:06.32917	221	EXECUTED	7:37f7257d9240c5adf05c2d8c1b5786a5	addColumn		\N	3.2.0
ADD-VERSION-FLAG-TO-OAUTH2-TOKEN-DETAIL-TABLE	Angel Montenegro	/db/updates/persistent_tokens.xml	2019-01-24 10:44:06.425761	222	EXECUTED	7:35ee373bed6439566464f264765f9e1f	addColumn		\N	3.2.0
ADD-PERSISTENT-TOKEN-ENABLE-FLAG-TO-CLIENT-DETAILS-TABLE	Angel Montenegro	/db/updates/persistent_tokens.xml	2019-01-24 10:44:06.480193	223	EXECUTED	7:bc55ce0569035162293e16a756ed84a1	addColumn		\N	3.2.0
ADD-GROUP-ORCID-COLUMN-TO-CLIENT-DETAILS	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2019-01-24 10:44:06.487405	224	EXECUTED	7:3d82c821a6d8d6052b3611f6606b13fe	addColumn, sql, addForeignKeyConstraint		\N	3.2.0
ADD-CLIENT-TYPE-TO-CLIENT-DETAILS	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2019-01-24 10:44:06.492313	225	EXECUTED	7:36ca1cfe2c93eb1d32b96e986d0f408e	addColumn, sql		\N	3.2.0
MAKE-CLIENT-ID-COLUMN-BIGGER-IN-TOKEN-TABLE	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2019-01-24 10:44:06.497079	226	EXECUTED	7:d408f5400d82d6d3164854fbf7f8c15a	modifyDataType		\N	3.2.0
ADD-CLIENT-SOURCE-ID	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2019-01-24 10:44:06.505596	227	EXECUTED	7:d4bcd8453dd27f5af6c872222cb58d78	addColumn (x8)		\N	3.2.0
POPULATE-CLIENT-SOURCE-ID	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2019-01-24 10:44:06.515503	228	EXECUTED	7:f35a0780efa903c1ac33b69e7a0f8972	sql (x8)		\N	3.2.0
CORRECT-SOURCE-ID-FOR-PUBLIC-CLIENT-OWNERS-AGAIN	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2019-01-24 10:44:06.523785	229	EXECUTED	7:e728a98b054c6e2960308263c5690213	sql (x8)		\N	3.2.0
ADD-FOREIGN-KEYS-FOR-CLIENT-SOURCE-ID	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2019-01-24 10:44:06.542123	230	EXECUTED	7:d5bfa3aebf641fae4f4e35296973a185	addForeignKeyConstraint (x8)		\N	3.2.0
INCREASE-SIZE-OF-REFERRED-BY	Will Simpson	/db/updates/new_way_of_doing_client_ids.xml	2019-01-24 10:44:06.547407	231	EXECUTED	7:9209290446f36a15892d1780e08683c5	modifyDataType		\N	3.2.0
REMOVE-OLD-NOTIFICATION-SCOPE	Will Simpson	/db/updates/notifications_part2.xml	2019-01-24 10:44:06.549957	232	EXECUTED	7:13b1b019fe668f0deb7b707b148aa74f	sql		\N	3.2.0
UPDATE-TOKENS-WITH-OLD-NOTIFICATION-SCOPE	Will Simpson	/db/updates/notifications_part2.xml	2019-01-24 10:44:06.553124	233	EXECUTED	7:ee58f6fb7322aba6818f3e8076ea8d8e	sql		\N	3.2.0
INSERT-NOTIFICATION-SCOPE-2	Will Simpson	/db/updates/notifications_part2.xml	2019-01-24 10:44:06.559154	234	EXECUTED	7:852d4a5ae0b9304faf3f64b2465d3117	createProcedure, sql		\N	3.2.0
UPDATE-NOTIFICATION-TYPE	Will Simpson	/db/updates/notifications_part2.xml	2019-01-24 10:44:06.562216	235	EXECUTED	7:0fdc3e4a48feef0d0e053b12da3d430a	sql		\N	3.2.0
ADD-AMENDED-SECTION-TO-NOTIFICATION	Will Simpson	/db/updates/notifications_part2.xml	2019-01-24 10:44:06.567095	236	EXECUTED	7:5cfe19eb4f684f618ad7ff4125d93692	addColumn		\N	3.2.0
RENAME-COLUMN-ON-ORCID-PROPS	Angel Montenegro	/db/updates/change_column_name_on_orcid_props_table.xml	2019-01-24 10:44:06.596713	237	EXECUTED	7:aa0fd25d4faac9256671439b2ca2a3b4	renameColumn		\N	3.2.0
MODIFY-ENABLE-DEVELOPER-TOOLS-DATA-TYPE	Angel Montenegro	/db/updates/modify_enable_developer_tools_data_type.xml	2019-01-24 10:44:06.626861	238	EXECUTED	7:cafdbcd6ee96a230231e38a81c698414	addColumn		\N	3.2.0
SET-ENABLED-DATE-FOR-USERS-WITH-DEVELOPER-TOOLS	Angel Montenegro	/db/updates/modify_enable_developer_tools_data_type.xml	2019-01-24 10:44:06.6301	239	EXECUTED	7:1c9ace2e59d01e075e3e27b1a027e2a1	sql		\N	3.2.0
EXTERNAL-IDENTIFIERS-JSON-COLUMN	Angel Montenegro	/db/updates/funding-external-identifiers-as-json.xml	2019-01-24 10:44:06.634646	240	EXECUTED	7:a996c9c6041dc061684f144a252d75b6	addColumn		\N	3.2.0
CHANGE-EXTERNAL-IDENTIFIER-PRIMARY-KEY	Angel Montenegro	/db/updates/change_external_identifier_primary_key.xml	2019-01-24 10:44:06.672389	241	EXECUTED	7:6d0dc34d43d302e793da5c5c5d71a578	dropPrimaryKey, addColumn, addUniqueConstraint		\N	3.2.0
resize_external_id_url	Angel Montenegro	/db/updates/resize_external_id_url.xml	2019-01-24 10:44:06.67612	242	EXECUTED	7:bc5039ccdde5c2b904156c923932c5be	modifyDataType		\N	3.2.0
MIGRATE-WOSUID	Will Simpson	/db/updates/migrate-wosuid.xml	2019-01-24 10:44:06.678928	243	EXECUTED	7:276858d7eafe094ad3512eb576f88b1b	sql		\N	3.2.0
ADD-TYPE-TO-PUBLIC-CLIENT	Angel Montenegro	/db/updates/add_type_to_public_client.xml	2019-01-24 10:44:06.68142	244	EXECUTED	7:96c36c578d7f975785919b4916c3753a	sql		\N	3.2.0
RECORD-LOCKED	Angel Montenegro	/db/updates/record-locked.xml	2019-01-24 10:44:06.759074	245	EXECUTED	7:1be4d53d54d00d012ef1e9c8641dd2d5	addColumn		\N	3.2.0
SET-DISPLAY-INDEX-TO-0	Angel Montenegro	/db/updates/fix_profile_work_display_index.xml	2019-01-24 10:44:06.762125	246	EXECUTED	7:4de3c5403e277528c0d4e88f015fd23e	sql (x2)		\N	3.2.0
CREATE-PEER-REVIEW-TABLE	Angel Montenegro	/db/updates/peer-review.xml	2019-01-24 10:44:06.809476	247	EXECUTED	7:09ba7e2765f264c8012575239a89a952	createTable (x2), addForeignKeyConstraint (x3)		\N	3.2.0
CREATE-PEER-REVIEW-SEQUENCES	Angel Montenegro	/db/updates/peer-review.xml	2019-01-24 10:44:06.858291	248	EXECUTED	7:31ce26383181e84b5153cca54449af21	createSequence (x2)		\N	3.2.0
REMOVE-AMOUNT-FIELD-FROM-PROFILE-FUNDING-TABLE	Angel Montenegro	/db/updates/remove_amount_field.xml	2019-01-24 10:44:06.868135	249	EXECUTED	7:06e13b5b2064bfa3fc90c949a83f7bbc	dropColumn		\N	3.2.0
DEL-BLANK-OTHER-NAMES	rcpeters	/db/updates/fix_blank_other_names.xml	2019-01-24 10:44:06.871508	250	EXECUTED	7:aad571d3ab9d8c575c19868e665653cb	sql		\N	3.2.0
CREATE-SHIBBOLETH-ACCOUNT-TABLE	Will Simpson	/db/updates/shibboleth.xml	2019-01-24 10:44:06.908918	251	EXECUTED	7:87e2af6e6c82774ec6594b116d25e883	createTable, addForeignKeyConstraint, addUniqueConstraint		\N	3.2.0
ADD-SEQUENCE-FOR-SHIBBOLETH-ACCOUNT	Will Simpson	/db/updates/shibboleth.xml	2019-01-24 10:44:06.936251	252	EXECUTED	7:52bbfb0e6a655f729ad6eac38163b657	createSequence		\N	3.2.0
SET-DEFAULT-VALUE-ON-VISIBILITY-FIELDS	amontenegro	/db/updates/set_empty_visibility_fields_to_private.xml	2019-01-24 10:44:06.944393	253	EXECUTED	7:2244f3b40bc7c67855a5e7574e2318a4	addDefaultValue (x7)		\N	3.2.0
SET-NULL-TO-PRIVATE	amontenegro	/db/updates/set_empty_visibility_fields_to_private.xml	2019-01-24 10:44:06.952481	254	EXECUTED	7:aabf1fb6acdcbf462aeb02eb7d9a91a5	sql (x7)		\N	3.2.0
DROP-AUTHENTICATION-KEY-UNIQUE-CONSTRAINT	Angel Montenegro	/db/updates/drop_oauth2_authentication_key_unique_constraint.xml	2019-01-24 10:44:06.957525	255	EXECUTED	7:cc8ba78e0bc7fb6869627642975e2b71	dropUniqueConstraint		\N	3.2.0
ADD-FIELDS-TO-WORK	Angel Montenegro	/db/updates/move-work-data-to-work-table.xml	2019-01-24 10:44:07.01349	256	EXECUTED	7:3fc2179af2362f9733bbaffa0fbb58f4	addColumn, addForeignKeyConstraint (x3)		\N	3.2.0
ADD-UTILITY-FIELD-TO-PROFILE-WORK	Angel Montenegro	/db/updates/move-work-data-to-work-table.xml	2019-01-24 10:44:07.050564	257	EXECUTED	7:2dd29a2be25117952f400008e25f2d31	addColumn		\N	3.2.0
ORCID-IDX-ON-WORK	Angel Montenegro	/db/updates/move-work-data-to-work-table.xml	2019-01-24 10:44:07.735906	258	EXECUTED	7:117243dae31de975a716be08889f51aa	createIndex		\N	3.2.0
ORG-DISAMBIGUATED-SOURCE-ID-IDX	Angel Montenegro	/db/updates/new-index-for-org-disambiguated-table.xml	2019-01-24 10:44:08.417553	259	EXECUTED	7:60b1401bf8d392423329f58e95c360fa	createIndex		\N	3.2.0
ORG-DISAMBIGUATED-SOURCE-TYPE-IDX	Angel Montenegro	/db/updates/new-index-for-org-disambiguated-table.xml	2019-01-24 10:44:09.093826	260	EXECUTED	7:32b5355973907c0b6be5b1a0bcb95436	createIndex		\N	3.2.0
FUNDING-CONVERT-TEXT-TO-JSON	Angel Montenegro	/db/updates/external-ids-as-json.xml	2019-01-24 10:44:09.132425	261	EXECUTED	7:4c399f9d9b5bcaf7c6628cfdd7657a79	sql (x2)		\N	3.2.0
PEER-REVIEW-CONVERT-TEXT-TO-JSON	Angel Montenegro	/db/updates/external-ids-as-json.xml	2019-01-24 10:44:09.170903	262	EXECUTED	7:51d81bd5a73e01e2338d3634f08c8313	sql (x2)		\N	3.2.0
REMOVE-WORK-ID-FK-FROM-PROFILE-WORK	Angel Montenegro	/db/updates/remove-work-id-fk-on-profile-work.xml	2019-01-24 10:44:09.232353	263	EXECUTED	7:b8b51e81098341011548b118fd61b44c	dropForeignKeyConstraint		\N	3.2.0
CREATE-GROUP-ID-RECORD-TABLE	Shobhit Tyagi	/db/updates/group-id-record.xml	2019-01-24 10:44:09.267726	264	EXECUTED	7:2b99e56f6631a518dfcb67ceefe90a31	createTable		\N	3.2.0
CREATE-GROUP-ID-RECORD-SEQUENCES	Shobhit Tyagi	/db/updates/group-id-record.xml	2019-01-24 10:44:09.294231	265	EXECUTED	7:e64b50c341e0cfa57d7157316c09211c	createSequence		\N	3.2.0
UPDATE-FIELDS-SIZE	Shobhit Tyagi	/db/updates/group-id-record.xml	2019-01-24 10:44:09.299724	266	EXECUTED	7:0cd48589adb4f35a326f46a0c2bdf97a	sql (x3)		\N	3.2.0
MOVE-ALL-PEER-REVIEW-INFO-TO-PEER-REVIEW-TABLE	Angel Montenegro	/db/updates/move-all-peer-review-info-to-peer-review-table.xml	2019-01-24 10:44:09.332902	267	EXECUTED	7:fcaacf0cf38e9fa64447d54dd77ea935	addColumn		\N	3.2.0
REMOVE-PEER-REVIEW-SUBJECT-FK	Angel Montenegro	/db/updates/move-all-peer-review-info-to-peer-review-table.xml	2019-01-24 10:44:09.413161	268	EXECUTED	7:1debe3d95288b0a5c4c50e3b71752270	dropForeignKeyConstraint, dropNotNullConstraint		\N	3.2.0
SUBJECT-EXTERNAL-IDS-AS-JSON	Angel Montenegro	/db/updates/move-all-peer-review-info-to-peer-review-table.xml	2019-01-24 10:44:09.920498	269	MARK_RAN	7:54579d3abea4cbaa3763e8f037bcfcaf	sql		\N	3.2.0
ADD-ACTTYPE-GEOAREA-COLUMN	Shobhit Tyagi	/db/updates/add_redir_acttype_geoarea.xml	2019-01-24 10:44:09.974248	270	EXECUTED	7:36bbbe9bf8ad501f6441326e04e14b62	addColumn		\N	3.2.0
REDIRECT-URI-CONVERT-TEXT-TO-JSON	Shobhit Tyagi	/db/updates/add_redir_acttype_geoarea.xml	2019-01-24 10:44:10.028959	271	EXECUTED	7:6edc7b00cd6fb3f7ed26d44183d6609a	sql (x2)		\N	3.2.0
REDIRECT-URI-DEFAULT-VALUE	Shobhit Tyagi	/db/updates/add_redir_acttype_geoarea.xml	2019-01-24 10:44:10.032677	272	EXECUTED	7:6dbe6fec823112bf85941b41fe193472	sql (x2)		\N	3.2.0
REDIRECT-URI-DEFAULT-VALUE-TO-EXISTING	Shobhit Tyagi	/db/updates/add_redir_acttype_geoarea.xml	2019-01-24 10:44:10.035297	273	EXECUTED	7:31cd37f058d3d446cae9b91ef7e28676	sql (x2)		\N	3.2.0
ADD-CAPTCHA-FIELD-TO-PROFILE-TABLE	Angel Montenegro	/db/updates/add_captcha_field_to_profile.xml	2019-01-24 10:44:10.064833	274	EXECUTED	7:a097c0004a59aa53b1ad11ddef45a0e8	addColumn		\N	3.2.0
SET-ALL-EXISTING-TO-FALSE	Angel Montenegro	/db/updates/add_captcha_field_to_profile.xml	2019-01-24 10:44:10.068225	275	EXECUTED	7:0276442c3bdbba2cec47019a9dab39ad	sql		\N	3.2.0
REMOVE-PROFILE-WORK-TABLE	Angel Montenegro	/db/updates/remove_profile_work_table.xml	2019-01-24 10:44:10.078464	276	EXECUTED	7:4b8311df886d4d5bd47eede3dd77cf62	dropTable		\N	3.2.0
ADD-INDEX-ON-TRANSLATED-TITLE-LANGUAGE-CODE	Angel Montenegro	/db/updates/add_index_on_language_codes_in_activities.xml	2019-01-24 10:44:10.754528	277	EXECUTED	7:237037700280d1be2fd8d39e013c0f3c	createIndex		\N	3.2.0
ADD-INDEX-ON-LANGUAGE-CODE	Angel Montenegro	/db/updates/add_index_on_language_codes_in_activities.xml	2019-01-24 10:44:11.430822	278	EXECUTED	7:8afc2ad256d0170673cc65df6fda9c16	createIndex		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_1	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2019-01-24 10:44:11.434466	279	EXECUTED	7:0bbc5fec92c0b2eeede930c4f494abf7	sql (x3)		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_2	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2019-01-24 10:44:11.438089	280	EXECUTED	7:fcc8453b97bcba88fe1e05f65887064c	sql (x4)		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_3	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2019-01-24 10:44:11.442085	281	EXECUTED	7:1770f3e81eed6da29659de556abd85a0	sql (x3)		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_4	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2019-01-24 10:44:11.445882	282	EXECUTED	7:dd8c3d42c9a6e191d9e3f8e432c9cd6e	sql (x3)		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_5	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2019-01-24 10:44:11.449318	283	EXECUTED	7:8da3e728ed93ba1543704444e6e52eb7	sql (x3)		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_6	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2019-01-24 10:44:11.452433	284	EXECUTED	7:0f85b430da3fbc5610f04438dbfceb02	sql (x3)		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_7	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2019-01-24 10:44:11.455915	285	EXECUTED	7:4fc78a63d0d55029d8e0a680c156c6bf	sql (x3)		\N	3.2.0
FIX_LANGUAGE_CODES_IN_ACTIVITIES_WORKS_8	Angel Montenegro	/db/updates/fix_language_codes_in_activities.xml	2019-01-24 10:44:11.458573	286	EXECUTED	7:ac616e67f9b475b53d29959e02e2d4ed	sql		\N	3.2.0
CREATE-USERCONNECTION-TABLE	Shobhit Tyagi	/db/updates/user_connection.xml	2019-01-24 10:44:11.495315	287	EXECUTED	7:c74878fabd1588b236db811738717ee4	createTable, addPrimaryKey, createIndex		\N	3.2.0
REMOVE-TABLE-NOTIFICATION-ACTIVITY-TO-NOTIFICATION-ITEM	Angel Montenegro	/db/updates/rename_activities_tables_and_fields.xml	2019-01-24 10:44:11.501028	288	EXECUTED	7:5d07cc989ef39c57b8ba5f18e0e8757e	renameTable		\N	3.2.0
RENAME-TYPE-FIELD-ON-NOTIFICATION-ITEM-TABLE	Angel Montenegro	/db/updates/rename_activities_tables_and_fields.xml	2019-01-24 10:44:11.50898	289	EXECUTED	7:b5e2cb1db0291ef95354a79b3a865914	renameColumn		\N	3.2.0
RENAME-NAME-FIELD-ON-NOTIFICATION-ITEM-TABLE	Angel Montenegro	/db/updates/rename_activities_tables_and_fields.xml	2019-01-24 10:44:11.517066	290	EXECUTED	7:c88efb9a557825a35a9c26ca3baca1ed	renameColumn		\N	3.2.0
RENAME-SEQUENCE	Angel Montenegro	/db/updates/rename_activities_tables_and_fields.xml	2019-01-24 10:44:11.542473	291	EXECUTED	7:1d2861432300909fda64f0fbe6b43d8b	createSequence		\N	3.2.0
ADD-ACTIONED-DATE	Angel Montenegro	/db/updates/add_fields_on_notifications_item_table.xml	2019-01-24 10:44:11.572742	292	EXECUTED	7:d6a83ad7862590f33a5c9b3ef409c8fc	addColumn		\N	3.2.0
ADD-NOTIFICATION-SUBJECT	Angel Montenegro	/db/updates/add_fields_on_notifications_item_table.xml	2019-01-24 10:44:11.599163	293	EXECUTED	7:764ddf5ffab869810a82e72fa3550e7c	addColumn		\N	3.2.0
ADD-NOTIFICATION-INTRO	Angel Montenegro	/db/updates/add_fields_on_notifications_item_table.xml	2019-01-24 10:44:11.626323	294	EXECUTED	7:a28a6801d3fc771d2007215c26fbe975	addColumn		\N	3.2.0
ADD-NOTIFICATION-WORK	Will Simposn	/db/updates/notifications_part3.xml	2019-01-24 10:44:11.639445	295	EXECUTED	7:21724639f5286a554614175abeb113fb	createTable, addPrimaryKey, addForeignKeyConstraint (x2)		\N	3.2.0
UPDATE-NOTIFICATION-TYPE	Will Simpson	/db/updates/notifications_part3.xml	2019-01-24 10:44:11.642581	296	EXECUTED	7:60e8dc1bc3a34c11562eed4dfb69a9f0	sql		\N	3.2.0
CREATE-INTERNAL-SSO-TABLE	Angel Montenegro	/db/updates/orcid_internal_sso.xml	2019-01-24 10:44:11.66126	297	EXECUTED	7:20d2bdc2a7768aab5ca4dd08850cebb9	createTable		\N	3.2.0
ADD-INDEX-TO-SSO-TABLE	Angel Montenegro	/db/updates/orcid_internal_sso.xml	2019-01-24 10:44:12.324096	298	EXECUTED	7:d3f0e115200d723bf8b47853005eebb9	createIndex		\N	3.2.0
ADD-USER_LAST_IP-COL-TO-PROFILE	Shobhit Tyagi	/db/updates/add_column_ip_to_profile.xml	2019-01-24 10:44:12.351182	299	EXECUTED	7:60d72dd457020df5c3f5e52958bcad2d	addColumn		\N	3.2.0
UPDATE-IP-COLUMN-LENGTH	Shobhit Tyagi	/db/updates/alter_column_last_ip.xml	2019-01-24 10:44:12.355054	300	EXECUTED	7:e87fdc989c87292e790349e415dc19f8	sql		\N	3.2.0
ADD-REVIEWED-COL-TO-PROFILE	Shobhit Tyagi	/db/updates/add_column_reviewed_to_profile.xml	2019-01-24 10:44:12.436267	301	EXECUTED	7:55e1ad8472108b03b93e43db101afd94	addColumn		\N	3.2.0
FIX-NOTIFICATION-ITEM-SEQUENCE	Will Simpson	/db/updates/fix-notification-item-sequence.xml	2019-01-24 10:44:12.464857	302	EXECUTED	7:39ee8b74ed118a301349c6e4c8de98d3	dropSequence, sql		\N	3.2.0
ADD-FIELDS-TO-RESEARCHER-URL	Angel Montenegro	/db/updates/add_source_to_researcher_url.xml	2019-01-24 10:44:12.472814	303	EXECUTED	7:2e2ca264d58ce9d4170cb7928686ca40	addColumn, addForeignKeyConstraint (x2)		\N	3.2.0
CHANGE-UNIQUE-CONSTRAINTS-ON-RESEARCHER-URL	Angel Montenegro	/db/updates/change_unique_constraints_on_researcher_url.xml	2019-01-24 10:44:12.494636	304	EXECUTED	7:5c98f53e596f01df903511780103ac8b	sql (x3)		\N	3.2.0
DROP-LEGACY-WORK-EXTERNAL-IDENTIFIERS-TABLE	Will Simpson	/db/updates/drop_legacy_work_external_identifiers_table.xml	2019-01-24 10:44:12.502838	305	MARK_RAN	7:92b4d49478749f91d8b7f17f7af131d6	dropTable		\N	3.2.0
DELETE-NOTIFICATION-WORK-ENTRIES	Angel Montenegro	/db/updates/delete_notification_work_entries.xml	2019-01-24 10:44:12.505533	306	EXECUTED	7:fd5ff812139584eef3c22b4ffaa9e4c4	sql		\N	3.2.0
ADD-ADMINISTRATIVE-CHANGES-OPTION-COLUMN	Will Simpson	/db/updates/add_administrative_changes_option.xml	2019-01-24 10:44:12.533315	307	EXECUTED	7:ee8b84eb13f9564f19f07af088e57fb2	addColumn		\N	3.2.0
CUSTOM-POPULATE-ADMINISTRATIVE-CHANGES-OPTION-COLUMN	Will Simposn	/db/updates/add_administrative_changes_option.xml	2019-01-24 10:44:12.552287	308	EXECUTED	7:e380540a2934a68d4fb6fd1f791622fe	customChange		\N	3.2.0
NULLIFY-EMPTY-TRANSLATED-TITLES	Angel Montenegro	/db/updates/nullify_empty_translated_titles.xml	2019-01-24 10:44:12.56033	309	EXECUTED	7:682b62797bcee28f563ee081fb494226	sql (x5)		\N	3.2.0
ADD-FIELDS-TO-OTHER-NAMES	Shobhit Tyagi	/db/updates/add_source_to_other_names.xml	2019-01-24 10:44:12.567288	310	EXECUTED	7:b7bcc98f4b0ea6b2e3993f9f0420f9af	sql (x5)		\N	3.2.0
UPDATE_EXISTING-DATA-OTHER-NAMES	Shobhit Tyagi	/db/updates/add_source_to_other_names.xml	2019-01-24 10:44:12.570688	311	EXECUTED	7:12e9748937fe09158a50bb24c9b46a39	sql (x2)		\N	3.2.0
RENAME-CREDIT-NAME-VISIBILITY-FIELD-ON-PROFILE-TABLE_PSQL	Angel Montenegro	/db/updates/rename_credit_name_visibility_to_names_visibility.xml	2019-01-24 10:44:12.599422	312	EXECUTED	7:e2287d7cf3c6fc4ba6292dc5b124421b	sql		\N	3.2.0
ADD-READ-LIMITED	rcpeters	/db/updates/add_read_limited.xml	2019-01-24 10:44:12.602232	313	EXECUTED	7:a1e8bb7f88672e782fcc53cc485a56b9	sql		\N	3.2.0
ADD-PARENT-SOURCE-ID-TO-ORG-DISAMBIGUATED	Will Simpson	/db/updates/add_parent_id_to_org_disambiguated.xml	2019-01-24 10:44:12.640347	314	EXECUTED	7:eb741c07d9814c8f79e9f7d4a1b03aa1	addColumn		\N	3.2.0
ORG-DISAMBIGUATED-SOURCE-PARENT-ID-IDX	Will Simpson	/db/updates/add_parent_id_to_org_disambiguated.xml	2019-01-24 10:44:13.325178	315	EXECUTED	7:07e5c18d07c43f86fb847d9300e1660b	createIndex		\N	3.2.0
ORG-DISAMBIGUATED-DESCENDENT-TYPE	Will Simpson	/db/updates/add_parent_id_to_org_disambiguated.xml	2019-01-24 10:44:13.3315	316	EXECUTED	7:b900ab4c49ae933c1dd2b7c591799475	sql		\N	3.2.0
ORG-DISAMBIGUATED-DESCENDENT-FUNCTIONS	Will Simpson	/db/updates/add_parent_id_to_org_disambiguated.xml	2019-01-24 10:44:13.336191	317	EXECUTED	7:fd4a3f541efe04e68546af6365819b60	createProcedure		\N	3.2.0
ADD-VISIBILITY-TO-EXTERNAL-IDENTIFIERS	Angel Montenegro	/db/updates/add_visibility_to_external_identifiers.xml	2019-01-24 10:44:13.369924	318	EXECUTED	7:6463b019da7483601d44b01ea8b2de17	sql		\N	3.2.0
SET-EXTERNAL-IDENTIFIERS-VISIBILITY	Angel Montenegro	/db/updates/add_visibility_to_external_identifiers.xml	2019-01-24 10:44:13.373189	319	EXECUTED	7:0399fc7f93183f277e3af6349178ba0c	sql		\N	3.2.0
SET-NAMES-VISIBILITY-TO-PUBLIC-WHEN-CREDIT-NAME-IS-EMPTY	Angel Montenegro	/db/updates/set_names_visibility_to_public_on_empty_credit_names.xml	2019-01-24 10:44:13.376384	320	EXECUTED	7:0e2a02d842ea9e7f21c877964c204d75	sql		\N	3.2.0
ENABLE-PERSISTENT-TOKENS-ON-PUBLIC-CLIENT	Angel Montenegro	/db/updates/enable_persistent_tokens_on_public_clients.xml	2019-01-24 10:44:13.379466	321	EXECUTED	7:5503e6931b90cfe4c9065998ccdbb699	sql		\N	3.2.0
ADD-FIELDS-TO-KEYWORDS	Angel Montenegro	/db/updates/add_id_visibility_and_source_to_keywords.xml	2019-01-24 10:44:13.412566	322	EXECUTED	7:4156af11df84e3496fda3d8626f3cff5	sql (x6)		\N	3.2.0
ADD-KEYWORD-SEQUENCES	Angel Montenegro	/db/updates/add_id_visibility_and_source_to_keywords.xml	2019-01-24 10:44:13.440253	323	EXECUTED	7:f92e07a5e688b0607bf1f12700e48038	createSequence		\N	3.2.0
SET-ID-TO-KEYWORDS	Angel Montenegro	/db/updates/add_id_visibility_and_source_to_keywords.xml	2019-01-24 10:44:13.44285	324	EXECUTED	7:0ca4953d088f344fcb12d9b26a4d54cd	sql		\N	3.2.0
SET-KEYWORDS-VISIBILITY	Angel Montenegro	/db/updates/add_id_visibility_and_source_to_keywords.xml	2019-01-24 10:44:13.446135	325	EXECUTED	7:453932ce03a535af3869ea93549b9987	sql		\N	3.2.0
SET-SOURCE-TO-KEYWORDS	Angel Montenegro	/db/updates/add_id_visibility_and_source_to_keywords.xml	2019-01-24 10:44:13.449098	326	EXECUTED	7:7a1ce03b8d9904f1fc265322b65ce589	sql		\N	3.2.0
SET-ID-AS-PRIMARY-KEY-ON-KEYWORDS	Angel Montenegro	/db/updates/add_id_visibility_and_source_to_keywords.xml	2019-01-24 10:44:13.46789	327	EXECUTED	7:ed941ba8c76cef5d7aa67b6f77188a56	dropPrimaryKey, addPrimaryKey		\N	3.2.0
UPDATE-ADDRESS-TO-HAVE-MULTIPLE-PER-USER	Angel Montenegro	/db/updates/update_address_table.xml	2019-01-24 10:44:13.525339	328	EXECUTED	7:6efb4dc0fd152ea935dc69d821f0e04f	sql (x10)		\N	3.2.0
ADD-DISPLAY-INDEX-TO-KEYWORDS	Angel Montenegro	/db/updates/add_display_index_to_keywords.xml	2019-01-24 10:44:13.575835	329	EXECUTED	7:36aeea33d1ab4e57dc4acdc1b4c45fe7	sql		\N	3.2.0
ADD-DISPLAY-INDEX-TO-ADDRESS	Angel Montenegro	/db/updates/add_display_index_to_address.xml	2019-01-24 10:44:13.624313	330	EXECUTED	7:674033f749f7636c99fbcf09493045c3	sql		\N	3.2.0
ADD-DISPLAY-INDEX-TO-OTHER-NAME	Angel Montenegro	/db/updates/add_display_index_to_other_name.xml	2019-01-24 10:44:13.66063	331	EXECUTED	7:cb4f06a94cc903a0390967600ca5b7ee	sql		\N	3.2.0
ADD-DISPLAY-INDEX-TO-RESEARCHER-URL	Angel Montenegro	/db/updates/add_display_index_to_researcher_url.xml	2019-01-24 10:44:13.722354	332	EXECUTED	7:bade8ecebf9edd81be3ac0f89b9652dd	sql		\N	3.2.0
ADD-DISPLAY-INDEX-TO-EXTERNAL-IDENTIFIER	Angel Montenegro	/db/updates/add_display_index_to_external_identifier.xml	2019-01-24 10:44:13.777921	333	EXECUTED	7:6cb70996ce2b621a5f1da26cbd23fc0a	sql		\N	3.2.0
SET-DEFAULT-VISIBILITY-TO-EXTERNAL-IDENTIFIERS	Angel Montenegro	/db/updates/set_default_visibility_to_person_elements.xml	2019-01-24 10:44:13.781169	334	EXECUTED	7:a84cd42734c5b066491e5e19fe2806aa	sql		\N	3.2.0
SET-DEFAULT-VISIBILITY-TO-KEYWORDS	Angel Montenegro	/db/updates/set_default_visibility_to_person_elements.xml	2019-01-24 10:44:13.784414	335	EXECUTED	7:fdf3b8beea946a76897b854db3987abf	sql		\N	3.2.0
SET-DEFAULT-VISIBILITY-TO-RESEARCHER-URL	Angel Montenegro	/db/updates/set_default_visibility_to_person_elements.xml	2019-01-24 10:44:13.787657	336	EXECUTED	7:6cf4f1c90dd777e45ae4c93675fcf249	sql		\N	3.2.0
SET-DEFAULT-VISIBILITY-TO-ADDRESS	Angel Montenegro	/db/updates/set_default_visibility_to_person_elements.xml	2019-01-24 10:44:13.791259	337	EXECUTED	7:06e28ee931e607838892a893ee1d8004	sql (x2)		\N	3.2.0
SET-DEFAULT-VISIBILITY-TO-OTHER-NAMES	Angel Montenegro	/db/updates/set_default_visibility_to_person_elements.xml	2019-01-24 10:44:13.793998	338	EXECUTED	7:3ad1e674ac2e5e918602a023fa4906d8	sql		\N	3.2.0
ORCID-IDX-ON-ADDRESS	Angel Montenegro	/db/updates/add_orcid_index_on_address_researcher_url_and_external_identifiers.xml	2019-01-24 10:44:14.460558	339	EXECUTED	7:94206940b4277c50abcd03eaa902631d	sql		\N	3.2.0
ORCID-IDX-ON-RESEARCHER-URL	Angel Montenegro	/db/updates/add_orcid_index_on_address_researcher_url_and_external_identifiers.xml	2019-01-24 10:44:15.144261	340	EXECUTED	7:68f191b58daa4daa3ee7352afe48626e	sql		\N	3.2.0
ORCID-IDX-ON-EXTERNAL-IDENTIFIER	Angel Montenegro	/db/updates/add_orcid_index_on_address_researcher_url_and_external_identifiers.xml	2019-01-24 10:44:15.805547	341	EXECUTED	7:27fd3a98a58f6cc6ba2c444e659a2053	sql		\N	3.2.0
ADD-ORCID-DISPLAY-INDEX-IDX-ON-WORK-TABLE	Angel Montenegro	/db/updates/add_work_orcid_display_index_index_on_work_table.xml	2019-01-24 10:44:16.464754	342	EXECUTED	7:391278337bbf3b1d64b26d5f7a355616	sql		\N	3.2.0
ADD-ORCID-INDEX-ON-OTHER-NAMES	Angel Montenegro	/db/updates/add_orcid_index_other_names.xml	2019-01-24 10:44:17.134318	343	EXECUTED	7:e3b2a8cd47684037878511c441ae368f	sql		\N	3.2.0
CLEAN-DUPLICATE-ADDRESSES	Shobhit Tyagi	/db/updates/clean-address-table.xml	2019-01-24 10:44:17.137263	344	EXECUTED	7:b5aeb337111d0257d9bd1961207e6cc6	sql		\N	3.2.0
REMOVE-USER-CONNECTIONS-FOR-DEACTIVATED	Will Simpson	/db/updates/remove-user-connections-for-deactivated.xml	2019-01-24 10:44:17.140103	345	EXECUTED	7:622b5bf13341ba10205e2d2adabc1a40	sql		\N	3.2.0
REMOVE-HEAR-ABOUT	rcpeters	/db/updates/remove-hear-about.xml	2019-01-24 10:44:17.1445	346	EXECUTED	7:8d6cf7b384a08755a9f0692e5dcda28f	sql		\N	3.2.0
REMOVE-REG-ROLE	rcpeters	/db/updates/remove-hear-about.xml	2019-01-24 10:44:17.149212	347	EXECUTED	7:2690a7ac8d8b460acd2b9adba28e197b	sql (x2)		\N	3.2.0
ADD-ID-TYPE-USERCONNECTION-TABLE	Will Simpson	/db/updates/user_connection_id_type.xml	2019-01-24 10:44:17.153372	348	EXECUTED	7:edb5018fa462928ec61674e31ab40fbd	addColumn		\N	3.2.0
POPULATE-USERCONNECTION-ID-TYPE	Will Simpson	/db/updates/user_connection_id_type.xml	2019-01-24 10:44:17.156232	349	EXECUTED	7:da1ed75f8c0ae65ee24d34606adf58d8	sql		\N	3.2.0
CREATE-IDP-TABLE	Will Simpson	/db/updates/federated-idp-info.xml	2019-01-24 10:44:17.193006	350	EXECUTED	7:41e24f940e02be92ece9f3892500be01	createTable		\N	3.2.0
ADD-SEQUENCE-FOR-NOTIFICATIONS	Will Simpson	/db/updates/federated-idp-info.xml	2019-01-24 10:44:17.219506	351	EXECUTED	7:f7390ec769919c3220165788112a6204	createSequence		\N	3.2.0
ADD-EMAILS-TO-IDP	Will Simpson	/db/updates/federated-idp-info.xml	2019-01-24 10:44:17.223368	352	EXECUTED	7:ba76da9ef167c06833372aa6224f620f	addColumn		\N	3.2.0
ADD-FAILED-INFO-TO-IDP	Will Simpson	/db/updates/federated-idp-info.xml	2019-01-24 10:44:17.25367	353	EXECUTED	7:c9dc7d81c2ccef645a6468fb2eb41d30	addColumn		\N	3.2.0
ADD-ITEM-NOTIFICATION-INDEX-ON-NOTIFICATION-ITEM	rcpeters	/db/updates/add_notification_id_index.xml	2019-01-24 10:44:17.920939	354	EXECUTED	7:c5b5672244461cf686439caa066eb6d4	sql		\N	3.2.0
ADD-DATE-CREATED-ON-NOTIFICATION	rcpeters	/db/updates/add_notification_id_index.xml	2019-01-24 10:44:18.579668	355	EXECUTED	7:c689191078efe8d922c56f4a21fdf416	sql		\N	3.2.0
ADD-ARCHIVED-DATE-ON-NOTIFICATION	rcpeters	/db/updates/add_notification_id_index.xml	2019-01-24 10:44:19.232862	356	EXECUTED	7:0fd18621ec54f74fc636c177c768bc13	sql		\N	3.2.0
ADD-ORCID-NOTIFICATION	rcpeters	/db/updates/add_notification_id_index.xml	2019-01-24 10:44:19.900995	357	EXECUTED	7:19bc60678b93611305790b78cb86ce82	sql		\N	3.2.0
peer_review_orcid_index	rcpeters	/db/updates/add_indexes_2016_03_31.xml	2019-01-24 10:44:20.559368	358	EXECUTED	7:7441da8c65e20211f78b3c444423615e	sql		\N	3.2.0
peer_review_display_index	rcpeters	/db/updates/add_indexes_2016_03_31.xml	2019-01-24 10:44:21.234301	359	EXECUTED	7:c8c865207362d860f0f960a7a9251304	sql		\N	3.2.0
profile_funding_orcid_index	rcpeters	/db/updates/add_indexes_2016_03_31.xml	2019-01-24 10:44:21.901625	360	EXECUTED	7:9c6ada2c434f42d79eb4bf0520796871	sql		\N	3.2.0
profile_funding_display_index	rcpeters	/db/updates/add_indexes_2016_03_31.xml	2019-01-24 10:44:22.5636	361	EXECUTED	7:6ae0e1b147a2e7d16f02e633e744330f	sql		\N	3.2.0
group_id_lowercase_unique_idx	Angel Montenegro	/db/updates/add_indexes_2016_04_06.xml	2019-01-24 10:44:23.2276	362	EXECUTED	7:c0e85d31ecf24f3c54281dc09dd3b6be	sql		\N	3.2.0
CREATE-RECORD-NAME-TABLE	Angel Montenegro	/db/updates/create_record_name_table.xml	2019-01-24 10:44:23.254445	363	EXECUTED	7:5a175203ad6ddef426808709610b58d4	createTable, addForeignKeyConstraint		\N	3.2.0
CREATE-RECORD-NAME-SEQUENCES	Angel Montenegro	/db/updates/create_record_name_table.xml	2019-01-24 10:44:23.281143	364	EXECUTED	7:7e6b60b012d550b79cb1fe82fb65082a	createSequence		\N	3.2.0
RECORD-NAME-ORCID-INDEX	Angel Montenegro	/db/updates/create_record_name_table.xml	2019-01-24 10:44:23.950155	365	EXECUTED	7:d154ef3c852a46a3d00ef3b509629b09	sql		\N	3.2.0
GRANT-READ-PERMISSIONS-TO-ORCIDRO-ON-RECORD-NAME	Angel Montenegro	/db/updates/create_record_name_table.xml	2019-01-24 10:44:23.954038	366	EXECUTED	7:286bf2baca5fb286119ac23bdbc58a20	sql		\N	3.2.0
CREATE-BIOGRAPHY-TABLE	Angel Montenegro	/db/updates/create_biography_table.xml	2019-01-24 10:44:23.980428	367	EXECUTED	7:8c78b2c296520401abe60f992e090a08	createTable, addForeignKeyConstraint		\N	3.2.0
CREATE-BIOGRAPHY-SEQUENCES	Angel Montenegro	/db/updates/create_biography_table.xml	2019-01-24 10:44:24.007683	368	EXECUTED	7:58cd2640d1f22f7ef3c1019e08ba8762	createSequence		\N	3.2.0
BIOGRAPHY-ORCID-INDEX	Angel Montenegro	/db/updates/create_biography_table.xml	2019-01-24 10:44:24.687231	369	EXECUTED	7:f8d88fbb15ce8f393e5b204e38cf457f	sql		\N	3.2.0
GRANT-READ-PERMISSIONS-TO-ORCIDRO-ON-BIOGRAPHY	Angel Montenegro	/db/updates/create_biography_table.xml	2019-01-24 10:44:24.691027	370	EXECUTED	7:2328eef1fb82addbddb7b955165ea605	sql		\N	3.2.0
REMOVE-WORK-EXTERNAL-IDENTIFIER	Angel Montenegro	/db/updates/remove_old_works_related_tables.xml	2019-01-24 10:44:24.695465	371	EXECUTED	7:5e69008f534e877ce0dd46642aee24e2	sql		\N	3.2.0
REMOVE-WORK-CONTRIBUTOR	Angel Montenegro	/db/updates/remove_old_works_related_tables.xml	2019-01-24 10:44:24.70031	372	EXECUTED	7:93ad4ff5b9be122f1b43e44e08715841	sql		\N	3.2.0
REMOVE-WORK-SOURCE	Angel Montenegro	/db/updates/remove_old_works_related_tables.xml	2019-01-24 10:44:24.705135	373	EXECUTED	7:097a630fdcfaf1779907630e209d889c	sql		\N	3.2.0
CREATE-IDENTIFIER-TYPE-TABLE	Tom D	/db/updates/identifier-type.xml	2019-01-24 10:44:24.740531	374	EXECUTED	7:a907bf1f4086a4ca986ec3df81f53801	createTable		\N	3.2.0
ADD-SEQUENCE-FOR-IDENTIFIER-TYPE	Tom D	/db/updates/identifier-type.xml	2019-01-24 10:44:24.771674	375	EXECUTED	7:a4bd36aab94a8d159398585b60ca147b	createSequence		\N	3.2.0
INSERT-DEFAULT-IDENTIFIER-TYPES	Tom D	/db/updates/identifier-type.xml	2019-01-24 10:44:24.790094	376	EXECUTED	7:d2faf80f9045509ea9836bb91b185317	insert (x34)		\N	3.2.0
set_default_names_visibility_where_it_is_null	Angel Montenegro	/db/updates/set_default_visibility_on_names.xml	2019-01-24 10:44:24.801732	377	EXECUTED	7:1502afccdfdcfd0fe42a43ebb82c46c7	sql (x4)		\N	3.2.0
SET-SOURCE-TO-ADDRESS	Angel Montenegro	/db/updates/fix_source_on_bio_elements.xml	2019-01-24 10:44:24.809436	378	EXECUTED	7:d302a6eabebc5fb5951ff05840c55e8e	sql (x5)		\N	3.2.0
SET-SOURCE-TO-KEYWORDS	Angel Montenegro	/db/updates/fix_source_on_bio_elements.xml	2019-01-24 10:44:24.817305	379	EXECUTED	7:dff6ac78d6016938ad8a0fdaaa34eac7	sql (x5)		\N	3.2.0
SET-SOURCE-TO-OTHER-NAMES	Angel Montenegro	/db/updates/fix_source_on_bio_elements.xml	2019-01-24 10:44:24.825347	380	EXECUTED	7:ddd64e9307af57e327fe151fc7c95064	sql (x5)		\N	3.2.0
SET-SOURCE-TO-RESEARCHER-URLS	Angel Montenegro	/db/updates/fix_source_on_bio_elements.xml	2019-01-24 10:44:24.833724	381	EXECUTED	7:805f51a1bf81de4c31874f9bd7832e38	sql (x5)		\N	3.2.0
given_permission_to_giver_orcid_idx	rcpeters	/db/updates/add_indexes_2016_05_23.xml	2019-01-24 10:44:25.537487	382	EXECUTED	7:4e968b3cea08220ff526534d30b9c0bc	sql		\N	3.2.0
given_permission_to_receiver_orcid_idx	rcpeters	/db/updates/add_indexes_2016_05_23.xml	2019-01-24 10:44:26.212105	383	EXECUTED	7:ba71f4f2b07856da2fd76b46f0bf105b	sql		\N	3.2.0
email_event_email_idx	rcpeters	/db/updates/add_indexes_2016_05_23.xml	2019-01-24 10:44:26.883647	384	EXECUTED	7:99c617e1666e713595e4242f51c4e889	sql		\N	3.2.0
group_id_record_date_created_idx	rcpeters	/db/updates/add_indexes_2016_05_25.xml	2019-01-24 10:44:27.559403	385	EXECUTED	7:87ce8ac060a9a0d794ff769ce1be5aa7	sql		\N	3.2.0
group_id_record_group_type_idx	rcpeters	/db/updates/add_indexes_2016_05_25.xml	2019-01-24 10:44:28.25966	386	EXECUTED	7:a3d3daaa3c195ecd30651e078506df85	sql		\N	3.2.0
record_name_credit_name_idx	rcpeters	/db/updates/add_indexes_2016_05_25.xml	2019-01-24 10:44:28.930707	387	EXECUTED	7:2d0dfde343c9b943b3005cb4aef1da0a	sql		\N	3.2.0
profile_funding_org_id_idx	rcpeters	/db/updates/add_indexes_2016_05_25.xml	2019-01-24 10:44:29.60893	388	EXECUTED	7:e76daf43dcf20d53ed21da3e24543bca	sql		\N	3.2.0
FIX-NULL-VISIBILITY-ON-OTHER-NAME	Angel Montenegro	/db/updates/fix_null_visibility_on_bio_elements.xml	2019-01-24 10:44:29.611657	389	EXECUTED	7:e7c5bd3b51a6a7622bcccc5d1dc42661	sql		\N	3.2.0
FIX-NULL-VISIBILITY-ON-PROFILE-KEYWORD	Angel Montenegro	/db/updates/fix_null_visibility_on_bio_elements.xml	2019-01-24 10:44:29.614284	390	EXECUTED	7:9ddbf34b6b0649f98719e622d2cba2c7	sql		\N	3.2.0
FIX-NULL-VISIBILITY-ON-RESEARCHER-URL	Angel Montenegro	/db/updates/fix_null_visibility_on_bio_elements.xml	2019-01-24 10:44:29.617418	391	EXECUTED	7:934acdf8a58e291c1c2431072f8d897e	sql		\N	3.2.0
REMOVE-SEQUENCE-FOR-IDENTIFIER-TYPE	Tom D	/db/updates/identifier-type-fixed.xml	2019-01-24 10:44:29.648954	392	EXECUTED	7:118add09a7be2d9738a9e171253e02db	dropSequence		\N	3.2.0
ADD-SEQUENCE-FOR-IDENTIFIER-TYPE_REDO	Tom D	/db/updates/identifier-type-fixed.xml	2019-01-24 10:44:29.677984	393	EXECUTED	7:5686b8f4a0971823fe1fea7ee82d1f1f	createSequence		\N	3.2.0
CLEAN-DUPLICATED-DELEGATES	Angel Montenegro	/db/updates/clean-duplicated-delegates.xml	2019-01-24 10:44:29.680822	394	EXECUTED	7:47f69452d531ebc043f3e1e6735cc70c	sql		\N	3.2.0
UPDATE_EXTERNAL_IDENTIFIER_UNIQUE_CONSTRAINT	Angel Montenegro	/db/updates/update-external-identifiers-unique-constraint.xml	2019-01-24 10:44:29.693173	395	EXECUTED	7:1d464ae03fd4a5987c71b7eea1a69980	sql (x2)		\N	3.2.0
TIDY_ORG_EXT_IDS	Will Simpson	/db/updates/tidy_org_ext_ids.xml	2019-01-24 10:44:29.698462	396	EXECUTED	7:4952dd0e60953342a57b2a8f8ece407f	sql (x4)		\N	3.2.0
FIX-NULL-VISIBILITY-ON-BIOGRAPHY	Angel Montenegro	/db/updates/fix_bios_without_visibility.xml	2019-01-24 10:44:29.703572	397	EXECUTED	7:25eee21513016c31905542f6ac010b2c	sql (x4)		\N	3.2.0
FIX_DISPLAY_INDEXS_FOR_BIO	rcpeters	/db/updates/fix_display_indexs_for_bio.xml	2019-01-24 10:44:29.709675	398	EXECUTED	7:442819e9f84d1b781050c18c6a3f51cb	sql		\N	3.2.0
FIX_DISPLAY_INDEXS_FOR_BIO_V2	rcpeters	/db/updates/fix_display_indexs_for_bio.xml	2019-01-24 10:44:29.712744	399	EXECUTED	7:ad4f6bf634570830564d10441237b44e	sql		\N	3.2.0
FIX_NULL_DISPLAY_INDEXS_FOR_BIO_V2	Angel Montenegro	/db/updates/fix_display_indexs_for_bio.xml	2019-01-24 10:44:29.715412	400	EXECUTED	7:53d2812647bb46fb439745bf5de9a4fa	sql		\N	3.2.0
FIX-ZBL-WORK_EXT_ID	Will Simpson	/db/updates/fix_zbl.xml	2019-01-24 10:44:29.71761	401	EXECUTED	7:1b1272f3aeaefb2fe10122130f871517	sql		\N	3.2.0
ADD-STATUS-USERCONNECTION-TABLE	Angel Montenegro	/db/updates/insitutional_sign_in_round_trip.xml	2019-01-24 10:44:29.76906	402	EXECUTED	7:70c29e95526eb26817259bb9b2136d94	addColumn		\N	3.2.0
ADD-AUTHENTICATION-PROVIDER-ID-TO-THE-CLIENT-DETAILS-TABLE	Angel Montenegro	/db/updates/insitutional_sign_in_round_trip.xml	2019-01-24 10:44:29.79595	403	EXECUTED	7:bd8a3e5c282d0d3b0ca578972b26b240	addColumn		\N	3.2.0
SET-ALL-EXISTING-USERCONNECTION-TO-STARTED	Angel Montenegro	/db/updates/insitutional_sign_in_round_trip.xml	2019-01-24 10:44:29.803518	404	EXECUTED	7:b89ea6d1a089cdc2601956620fcd2559	sql		\N	3.2.0
ADD-AUTHENTICATION-PROVIDER-ID-TO-THE-NOTIFICATION-TABLE	Will Simpson	/db/updates/insitutional_sign_in_round_trip.xml	2019-01-24 10:44:29.83008	405	EXECUTED	7:92cce8b978d45208b82f7edf0d3fe070	addColumn		\N	3.2.0
SET-PROVIDER-ID-ON-EXISTING-NOTIFICATIONS	Will Simpson	/db/updates/insitutional_sign_in_round_trip.xml	2019-01-24 10:44:29.832946	406	EXECUTED	7:6cce97f3b89a4d5b67ccf3861d0ad896	sql		\N	3.2.0
CREATE-IDP-NAME-TABLE	Will Simpson	/db/updates/federated-idp-name.xml	2019-01-24 10:44:29.859607	407	EXECUTED	7:50cdf676505585508612f78b86d89d27	createTable, addForeignKeyConstraint		\N	3.2.0
ADD-SEQUENCE-FOR-IDP-NAME	Will Simpson	/db/updates/federated-idp-name.xml	2019-01-24 10:44:29.889214	408	EXECUTED	7:761f911a0cceb950468a5db131507d44	createSequence		\N	3.2.0
CREATE-SALESFORCE-CONNECTION-TABLE	Will Simpson	/db/updates/consortia-self-service.xml	2019-01-24 10:44:29.932927	409	EXECUTED	7:e83d8bb4110e2d71f2474e2d9e9e3a75	createTable, createIndex		\N	3.2.0
ADD-SEQUENCE-FOR-SALESFORCE-CONNECTION	Will Simpson	/db/updates/consortia-self-service.xml	2019-01-24 10:44:29.962896	410	EXECUTED	7:941b8b167749a738374ba1c07b074d61	createSequence		\N	3.2.0
fix_null_relationship_on_funding_ext_ids	Angel Montenegro	/db/updates/fix-null-relationship-on-funding-ext-ids.xml	2019-01-24 10:44:29.971308	411	EXECUTED	7:49dfa3de6548946da3e43375e6eb226c	sql (x8)		\N	3.2.0
CREATE-PDB-IDENTIFIER	Tom D	/db/updates/identifier-types/identifier-type-pdb.xml	2019-01-24 10:44:29.976341	412	EXECUTED	7:3ea9066e1acecea0f4b80f94cabf9d94	insert		\N	3.2.0
CREATE-KUID-IDENTIFIER	Tom D	/db/updates/identifier-types/identifier-type-kuid.xml	2019-01-24 10:44:29.981359	413	EXECUTED	7:ce81320b113275d68775c030e0c94d60	insert		\N	3.2.0
CREATE-LENSID-IDENTIFIER	Tom D	/db/updates/identifier-types/identifier-type-36-lensid.xml	2019-01-24 10:44:29.986425	414	EXECUTED	7:4b264f5d54197270fc88c1484da82338	insert		\N	3.2.0
ADD-EMAIL-ACCESS-REASON	George Nash	/db/updates/add_email_access_reason.xml	2019-01-24 10:44:29.993009	415	EXECUTED	7:a15ee9e528f375a41234f8e885f0d983	addColumn		\N	3.2.0
ADD-HEADERS-TO-USERCONNECTION	Will Simpson	/db/updates/institutional_sign_in_heuristics.xml	2019-01-24 10:44:30.019882	416	EXECUTED	7:c0b45f443dc0d7458d170d2e9a0b1b92	addColumn		\N	3.2.0
CONVERT-TEXT-TO-JSON	Will Simpson	/db/updates/institutional_sign_in_heuristics.xml	2019-01-24 10:44:30.049156	417	EXECUTED	7:9d90b1458ee9dafcbd3cc3744c10720a	sql		\N	3.2.0
ADD-AUTO-DEPRECATE-TO-CLIENT-DETAILS	Angel Montenegro	/db/updates/add_auto_deprecate_to_client_details.xml	2019-01-24 10:44:30.077041	418	EXECUTED	7:b0878abfc4c99e22baa53fb95ced4dac	sql (x3)		\N	3.2.0
ID-TYPE-ADD-PRIMARY-USE	Tom Demeranville	/db/updates/identifier-types/add-primary-use-and-urls.xml	2019-01-24 10:44:30.129347	419	EXECUTED	7:69b0d82c749fd12f3fa960fe18075a9b	sql (x2)		\N	3.2.0
ADD-TYPE-URL-PREFIXES	Tom Demeranville	/db/updates/identifier-types/add-primary-use-and-urls.xml	2019-01-24 10:44:30.13933	420	EXECUTED	7:0ee8465bf82f6c345a57ba1e23d132c2	sql (x21)		\N	3.2.0
ADD-TYPE-URL-PREFIXES	Tom Demeranville	/db/updates/identifier-types/update-kuid-url.xml	2019-01-24 10:44:30.145001	421	EXECUTED	7:4241e36cd9a9afba3054e28c8595e7e8	sql		\N	3.2.0
CREATE-CVID-IDENTIFIER	Tom D	/db/updates/identifier-types/identifier-type-37-38.xml	2019-01-24 10:44:30.151294	422	EXECUTED	7:7c3398041b35af0ce557abb53f0e5bdc	insert		\N	3.2.0
CREATE-CIENCIAIUL-IDENTIFIER	Tom D	/db/updates/identifier-types/identifier-type-37-38.xml	2019-01-24 10:44:30.157192	423	EXECUTED	7:57178a1464866dbb922e81837ead7ae6	insert		\N	3.2.0
UPDATE-DOI-HTTPS	Tom Demeranville	/db/updates/identifier-types/update-doi-https.xml	2019-01-24 10:44:30.161053	424	EXECUTED	7:e80d6e44dc5f73ac2b8820ef8d7ee6b0	sql		\N	3.2.0
REMOVE-CVID-IDENTIFIER	Tom D	/db/updates/identifier-types/remove-cv-id.xml	2019-01-24 10:44:30.166136	425	EXECUTED	7:a324fe34b2904cebf6f2e78ef2f3bb06	delete		\N	3.2.0
ADD-REASON-LOCKED-COLUMN-TO-PROFILE-TABLE	George Nash	/db/updates/add_column_reason_locked.xml	2019-01-24 10:44:30.169797	426	EXECUTED	7:feef6fbf7e06b201a49c74636c49be43	addColumn		\N	3.2.0
ADD-REASON-LOCKED-COLUMN-TO-PROFILE-TABLE	George Nash	/db/updates/add_column_reason_locked_description.xml	2019-01-24 10:44:30.173606	427	EXECUTED	7:eccb66a039d5643d1b0eba051013c802	addColumn		\N	3.2.0
ID-TYPE-ADD-CASE-SENSITIVE	Tom Demeranville	/db/updates/identifier-types/add-case-to-id-types.xml	2019-01-24 10:44:30.228154	428	EXECUTED	7:0313f171baca2bc3b7295269f1300c4b	sql		\N	3.2.0
UPDATE-KUID2	Tom Demeranville	/db/updates/identifier-types/update-kuid-url2.xml	2019-01-24 10:44:30.232424	429	EXECUTED	7:80b9d8fa97222ca2c06e7c454dcf0f5d	sql		\N	3.2.0
CREATE-INVALID-RECORD-DATA-CHANGES-TABLE	Angel Montenegro	/db/updates/create_invalid_record_data_changes_table.xml	2019-01-24 10:44:30.251279	430	EXECUTED	7:c42fdea071d136ae8eb6b74386534c99	createTable		\N	3.2.0
GRANT-READ-PERMISSIONS-TO-ORCIDRO-ON-GROUP-ID-RECORD	Tom Demeranville	/db/updates/grant-id-ro-permission.xml	2019-01-24 10:44:30.255656	431	EXECUTED	7:dcf8c1e472ad145e6a43ca0bde3b9d9c	sql		\N	3.2.0
ADD-ID	Angel Montenegro	/db/updates/add_id_and_indexes_to_invalid_record_data_changes.xml	2019-01-24 10:44:30.282537	432	EXECUTED	7:5f6a06c45aab1c1176854c06bcd613ce	sql		\N	3.2.0
CREATE-ID-SEQUENCE	Angel Montenegro	/db/updates/add_id_and_indexes_to_invalid_record_data_changes.xml	2019-01-24 10:44:30.31374	433	EXECUTED	7:1833313a7ff566772fbee242d20bf7d7	createSequence		\N	3.2.0
SET-ID-TO-EXISTING-CHANGES	Angel Montenegro	/db/updates/add_id_and_indexes_to_invalid_record_data_changes.xml	2019-01-24 10:44:30.3163	434	EXECUTED	7:91550abadf84e0f3b65092bb9a1a0062	sql		\N	3.2.0
SET-DEFAULT-VALUE-TO-ID	Angel Montenegro	/db/updates/add_id_and_indexes_to_invalid_record_data_changes.xml	2019-01-24 10:44:30.319566	435	EXECUTED	7:1dcce963960e688cf468688bcf262492	sql		\N	3.2.0
SET-ID-NOT-NULL-RESTRICTION	Angel Montenegro	/db/updates/add_id_and_indexes_to_invalid_record_data_changes.xml	2019-01-24 10:44:30.331294	436	EXECUTED	7:bbc6840289fe99a7974d2a7b6b1ab33f	sql		\N	3.2.0
CREATE-ID-INDEX	Angel Montenegro	/db/updates/add_id_and_indexes_to_invalid_record_data_changes.xml	2019-01-24 10:44:31.045419	437	EXECUTED	7:44f9554b826f397cae6554dc0af26739	sql		\N	3.2.0
DATE-CREATED-INDEX	Angel Montenegro	/db/updates/add_id_and_indexes_to_invalid_record_data_changes.xml	2019-01-24 10:44:31.751124	438	EXECUTED	7:cc78431fb47d415d6c8ad6bc7202de8a	sql		\N	3.2.0
GRANT-PERMISSIONS	Angel Montenegro	/db/updates/grant_permissions_to_invalid_record_data_changes.xml	2019-01-24 10:44:31.754424	439	EXECUTED	7:ec50754c5821f972e69f594d3e765683	sql		\N	3.2.0
ADD-HASHED-ORCID-TO-PROFILE-ENTITY	George Nash	/db/updates/add_hashed_orcid_to_profile_entity.xml	2019-01-24 10:44:31.758312	440	EXECUTED	7:fefe53a7c58155012cce981ba60d3572	addColumn		\N	3.2.0
DROP-KEYWORD-VIEW	Angel Montenegro	/db/updates/remove_keyword_view.xml	2019-01-24 10:44:31.764011	441	EXECUTED	7:dd34e5c95a8e9cdbfcd8e6d2d566b64d	sql		\N	3.2.0
UPDATE-CLIENT-REDIRECT-URI	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.769886	442	EXECUTED	7:c150ecbd2eb8c1769a292764dc88bfcd	sql (x3)		\N	3.2.0
UPDATE-CUSTOM-EMAIL	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.773589	443	EXECUTED	7:732146b6582631250f13c78e4c386fc1	sql (x2)		\N	3.2.0
UPDATE-EMAIL	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.786154	444	EXECUTED	7:b225a21b268183ffafd6fc8c7ca65c1a	sql		\N	3.2.0
UPDATE-EMAIL-EVENT	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.790563	445	EXECUTED	7:46aaca8d2c8e0fc962b312d2dcf7b5bf	sql		\N	3.2.0
UPDATE-EXTERNAL-IDENTIFIER	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.796157	446	EXECUTED	7:55aea428dabf8467a743d74ce6eac2a4	sql (x3)		\N	3.2.0
UPDATE-FUNDING-SUBTYPE-TO-INDEX	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.799946	447	EXECUTED	7:2470aa6bb62b7d1697f56164f74a6187	sql		\N	3.2.0
UPDATE-GROUP-ID-RECORD	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.812417	448	EXECUTED	7:ab1b088a0f742ccc880d255277ee6ade	sql (x4)		\N	3.2.0
UPDATE-IDENTIFIER-TYPE	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.81686	449	EXECUTED	7:e546adcf3ae77f4ba4c6bea3d78e6612	sql (x4)		\N	3.2.0
UPDATE-IDENTITY-PROVIDER	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.821656	450	EXECUTED	7:63a67d999ead18e85f32b5bcf668a9c2	sql (x5)		\N	3.2.0
UPDATE-IDENITY-PROVIDER-NAME	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.825207	451	EXECUTED	7:cee8f2e2b6c3416592786b5498c491db	sql (x2)		\N	3.2.0
UPDATE-NOTIFICATION	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.829822	452	EXECUTED	7:271b1a2e02ed1f8e9eea71cb65512905	sql (x7)		\N	3.2.0
UPDATE-NOTIFICATION-ITEM	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.833814	453	EXECUTED	7:cfd7098b3d350918a6facac270b16385	sql (x4)		\N	3.2.0
UPDATE-ORG-AFFILIATION-RELATION	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.837303	454	EXECUTED	7:dadd236bf53f3ae784b3f990c0b32ef9	sql (x3)		\N	3.2.0
UPDATE-OTHER-NAME	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.849084	455	EXECUTED	7:54ae54d8fbfae0d261135485fd0acd34	sql		\N	3.2.0
UPDATE-PEER-REVIEW	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.855483	456	EXECUTED	7:3138c0e3d0a2a3f6c7e7e7b6088da5c5	sql (x10)		\N	3.2.0
UPDATE-PEER-REVIEW-SUBJECT	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.860701	457	EXECUTED	7:6142abc1b688507c9548d0d49705d5bd	sql (x7)		\N	3.2.0
UPDATE-PROFILE	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.864277	458	EXECUTED	7:f8cb0a1231b739c35ea707e64afcdb81	sql		\N	3.2.0
UPDATE-PROFILE-EVENT	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.876951	459	EXECUTED	7:929fd02d54308f42907d80b843b8b6f5	sql		\N	3.2.0
UPDATE-PROFILE-FUNDING	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.88413	460	EXECUTED	7:f3e5df48265c4a78a8695efda9683ba4	sql (x7)		\N	3.2.0
UPDATE-PROFILE-KEYWORD	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.896672	461	EXECUTED	7:0e584bd4ce0fc44a6cfdce2a01ee3a88	sql		\N	3.2.0
UPDATE-RECORD-NAME	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.901094	462	EXECUTED	7:259a9682b6b52883293cdb0ca6e2d685	sql (x3)		\N	3.2.0
UPDATE-RESEARCHER-URL	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.906337	463	EXECUTED	7:eab1340d7df1e9af99ccefbbb35deb99	sql (x2)		\N	3.2.0
UPDATE-SALESFORCE-CONNECTION	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.910677	464	EXECUTED	7:2b0872f5ec56cc5b40d15576bab79230	sql (x2)		\N	3.2.0
UPDATE-SHIBBOLETH-ACCOUNT	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.915571	465	EXECUTED	7:f493079b069481a135e5c0b05bc720e2	sql (x2)		\N	3.2.0
UPDATE-SUBJECT	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.928055	466	EXECUTED	7:be18e09c6716e052c4839b72d6efaa67	sql		\N	3.2.0
UPDATE-USERCONNECTION	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.938749	467	EXECUTED	7:bdb351afac85270d1c479abd30b5c555	sql (x12)		\N	3.2.0
UPDATE-WEBHOOK	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.943121	468	EXECUTED	7:3ec36298732c1b93d18fa05acb8fba04	sql		\N	3.2.0
UPDATE-WORK	Angel Montenegro	/db/updates/varchar_to_text.xml	2019-01-24 10:44:31.951522	469	EXECUTED	7:ba60ece3c626f7b929c97a9291b061bb	sql (x11)		\N	3.2.0
ADD-NOTIFICATION-READ-DATE-INDEX	Will Simpson	/db/updates/notifications_indexes.xml	2019-01-24 10:44:32.658264	470	EXECUTED	7:d2fbdb9a63167b1e5cdd2bb4703e3e5b	createIndex		\N	3.2.0
ADD-NOTIFICATION-TYPE-INDEX	Will Simpson	/db/updates/notifications_indexes.xml	2019-01-24 10:44:33.37663	471	EXECUTED	7:f66b59b276590437335bdeb9cb66a0bf	createIndex		\N	3.2.0
ADD-NOTIFICATION-CLIENT-SOURCE-ID-INDEX	Will Simpson	/db/updates/notifications_indexes.xml	2019-01-24 10:44:34.08704	472	EXECUTED	7:6093469759ec7c1d5b7b70a3a8b800fd	createIndex		\N	3.2.0
ADD-NOTIFICATION-AUTHENTICATION-PROVIDER-ID-INDEX	Will Simpson	/db/updates/notifications_indexes.xml	2019-01-24 10:44:34.800448	473	EXECUTED	7:50cfa9d0a3e1614d3b12420e6479edb2	createIndex		\N	3.2.0
ADD-2FA-COLUMNS-TO-PROFILE-TABLE	George Nash	/db/updates/add_2fa_columns_to_profile.xml	2019-01-24 10:44:34.857006	474	EXECUTED	7:6cb60ffade2e4a828ee4d3186a6783bc	addColumn		\N	3.2.0
CREATE-RRID-IDENTIFIER	Tom D	/db/updates/identifier-types/identifier-type-39-rrid.xml	2019-01-24 10:44:34.862682	475	EXECUTED	7:cb7daa70ac989059100a60efdb5f0f38	insert		\N	3.2.0
ADD-LAST-LOGIN-COL-TO-PROFILE	Tom D	/db/updates/add_column_last_login_to_profile.xml	2019-01-24 10:44:34.893134	476	EXECUTED	7:2e1be836a1be82fa7caed211b4a591cf	addColumn		\N	3.2.0
ADD-NONCE-TO-OAUTH-DETAIL	Tom D	/db/updates/add_column_nonce_to_oauth_detail.xml	2019-01-24 10:44:34.921394	477	EXECUTED	7:53d601353a8e99702615ec18f56c35b3	addColumn		\N	3.2.0
FIX-ORGS-MISSING-DISAMBIGUATED-ORG	Angel Montenegro	/db/updates/fix_orgs_missing_disambiguated_org.xml	2019-01-24 10:44:34.930954	478	EXECUTED	7:18deebc1c307062aee54e362b2a1385e	sql (x6)	#1: Identify disambiguated orgs and put them in a temp table\n\t\t\t#2: Update the orgs based on the info in temp_org_disambiguation_table\n\t\t\t#3: Identify records that should be reindexed\n\t\t\t#4: Reindex records	\N	3.2.0
INSTALL-BACKUP-CODES-TABLE	George Nash	/db/updates/backup_codes.xml	2019-01-24 10:44:34.944317	479	EXECUTED	7:80231ba59ae45c6a59378bf8b2fa8dca	createTable, createSequence		\N	3.2.0
ADD-CODE-TO-TOKEN-DETAIL	Tom D	/db/updates/add_column_authorization_code_to_oauth2_token_detail.xml	2019-01-24 10:44:34.97225	480	EXECUTED	7:2401ff048383e0e091a7847c42e25b05	addColumn		\N	3.2.0
CLEAN-DEACTIVATED-RECORDS	Angel Montenegro	/db/updates/clean_deactivated_records.xml	2019-01-24 10:44:34.985474	481	EXECUTED	7:4fe57015a827cef19bfa3028a6bfc084	sql (x15)		\N	3.2.0
ADD-INDEX-TO-NOTIFICATION-SENT-DATE	George Nash	/db/updates/notification_sent_date_index.xml	2019-01-24 10:44:34.992129	482	EXECUTED	7:2c99595a2217d9559a56fb0890952d53	sql		\N	3.2.0
ADD-URL-COLUMN-TO-ORG-AFFILIATION-RELATION-TABLE	George Nash	/db/updates/add_url_column_to_org_affiliation_relation.xml	2019-01-24 10:44:35.001308	483	EXECUTED	7:ef7dd49949e86827ded48f2c35850ca3	addColumn		\N	3.2.0
DELETE-GRANT-CONTRIBUTOR	Angel Montenegro	/db/updates/delete_grants_tables.xml	2019-01-24 10:44:35.008202	484	EXECUTED	7:5ad2e19ffeb9e4e1bb5a689489c7a29b	dropTable		\N	3.2.0
DELETE-PROFILE-GRANT	Angel Montenegro	/db/updates/delete_grants_tables.xml	2019-01-24 10:44:35.014268	485	EXECUTED	7:84e6ac0c60354f37ad96e2ca952be1aa	dropTable		\N	3.2.0
DELETE-GRANT-SOURCE	Angel Montenegro	/db/updates/delete_grants_tables.xml	2019-01-24 10:44:35.020368	486	EXECUTED	7:e59960cddf4e1bf5d1b2cf147fd048dc	dropTable		\N	3.2.0
DELETE-FUNDING-GRANT	Angel Montenegro	/db/updates/delete_grants_tables.xml	2019-01-24 10:44:35.026166	487	EXECUTED	7:8804a0234725b2fd7f641d19a6dea283	dropTable		\N	3.2.0
DISABLE-TOKENS-ON-DEACTIVATED-RECORDS	Angel Montenegro	/db/updates/disable_tokens_on_deactivated_records.xml	2019-01-24 10:44:35.032129	488	EXECUTED	7:d05c285fe3b9c9f0fc6fc92217769e07	sql (x3)		\N	3.2.0
change_org_unique_constraint	George Nash	/db/updates/org_unique_constraints_add_disambiguated_org.xml	2019-01-24 10:44:35.045034	489	EXECUTED	7:45361780d0b8aa12a7ce4775d8ba0067	sql (x2)		\N	3.2.0
ADD-EXTERNAL_IDS_TO_ORG_AFFILIATION_RELATION	George Nash	/db/updates/add_external_identifiers_to_org_affiliation_relation.xml	2019-01-24 10:44:35.049592	490	EXECUTED	7:3c04d68c7a3c6675b77950602f57e23d	addColumn		\N	3.2.0
CHANGE-ORG-AFFILIATION-RELATION-EXTERNAL-IDS-TYPE-TO-JSON	George Nash	/db/updates/add_external_identifiers_to_org_affiliation_relation.xml	2019-01-24 10:44:35.079332	491	EXECUTED	7:3409bd1c5e1fe2180fe6e1065f7307d3	sql		\N	3.2.0
REINDEX-LOCKED-DEPRECATED-AND-DEACTIVATED-RECORDS	Angel Montenegro	/db/updates/reindex_locked_deprecated_and_deactivated_records.xml	2019-01-24 10:44:35.082618	492	EXECUTED	7:e1fce48393473b95eccbd8756ee5ebd6	sql		\N	3.2.0
CREATE-AUTHENTICUSID-IDENTIFIER	Tom D	/db/updates/identifier-types/identifier-type-40-authenticusid.xml	2019-01-24 10:44:35.090024	493	EXECUTED	7:90bfeedee9e61125927b2839a14be103	insert		\N	3.2.0
REMOVE-UNIQUE-CONSTRAINTS-ON-ORG-DISAMBIGUATED	Angel Montenegro	/db/updates/remove_unique_constraints_on_org_disambiguated.xml	2019-01-24 10:44:35.094924	494	EXECUTED	7:1ec4338863cd9c33c77add49464c94b8	sql		\N	3.2.0
REMOVE-INVALID-FUNDREF-ORG-DISAMBIGUATED-EXTERNAL-IDENTIFIER	Angel Montenegro	/db/updates/remove_invalid_fundref_org_disambiguated_external_identifiers.xml	2019-01-24 10:44:35.098186	495	EXECUTED	7:8a70e94da5b0ed1f4d116ed37797f08f	sql		\N	3.2.0
ADD-PREFERRED-INDICATOR	Angel Montenegro	/db/updates/add_preferred_indicator_to_org_disambiguated_external_identifier.xml	2019-01-24 10:44:35.139451	496	EXECUTED	7:a9f864aabcba4397e25169f16f7267a7	sql (x3)		\N	3.2.0
REINDEX-RECORDS-WITH-GRID-IDENTIFIERS	Angel Montenegro	/db/updates/reindex-records-with-grid-identifiers.xml	2019-01-24 10:44:35.143053	497	EXECUTED	7:12d1fd44b6611d2f14145a4d3eefed5b	sql		\N	3.2.0
BIBCODE-CASE-SENSITIVE	Tom Demeranville	/db/updates/identifier-types/make-bibcode-case-sensitive.xml	2019-01-24 10:44:35.148288	498	EXECUTED	7:1a43dc8a9b71dba9e1488abde643ec2f	sql		\N	3.2.0
ALLOW-MULTIPLE-SF-CONNECTIONS	Will Simpson	/db/updates/allow_multiple_sf_connections.xml	2019-01-24 10:44:35.227044	499	EXECUTED	7:da02f5d317181f5d3d98550724e52d27	addColumn, dropUniqueConstraint, addUniqueConstraint		\N	3.2.0
ADD-REVOCATION-DATE-TO-TOKEN	Angel Montenegro	/db/updates/add_revocation_date_to_token.xml	2019-01-24 10:44:35.262799	500	EXECUTED	7:ae594a1af1c211c81f9f7a870a08e282	addColumn		\N	3.2.0
ADD-REVOKE-REASON-TO-TOKEN	Angel Montenegro	/db/updates/add_revoke_reason_to_token.xml	2019-01-24 10:44:35.297898	501	EXECUTED	7:d9d7785f8dd3bc6ed1ad28a5f477e070	addColumn		\N	3.2.0
ADD-UNIQUE-INDEX-ON-TOKEN	Angel Montenegro	/db/updates/add_unique_index_on_token_value.xml	2019-01-24 10:44:36.182098	502	EXECUTED	7:07e01e709b62b70010c75782107a6d64	sql (x3)		\N	3.2.0
UPDATE-AFFILIATIONS	Angel Montenegro	/db/updates/varchar_to_text_v2.xml	2019-01-24 10:44:36.185587	503	EXECUTED	7:bc4358c86ec9cd9d8f6a98e7d9525e73	sql		\N	3.2.0
UPDATE-CLIENT-DETAILS	Angel Montenegro	/db/updates/varchar_to_text_v2.xml	2019-01-24 10:44:36.189626	504	EXECUTED	7:ba9d1db856f0cb062005a56192a14ea5	sql (x3)		\N	3.2.0
ADD-ID-FROM-SOURCE-TO-ORGS-INDEX	Will Simpson	/db/updates/add_id_from_source_to_orgs_index.xml	2019-01-24 10:44:36.193158	505	EXECUTED	7:44820e048560890755bb35687bddd87c	sql		\N	3.2.0
CREATE-ARK-IDENTIFIER	Tom Demeranville	/db/updates/identifier-types/identifier-type-41-ark.xml	2019-01-24 10:44:36.199039	506	EXECUTED	7:aa243aec1423bd870fd1653e6b52372a	insert		\N	3.2.0
ARK-CASE-SENSITIVE	Tom Demeranville	/db/updates/identifier-types/identifier-type-41-ark.xml	2019-01-24 10:44:36.203081	507	EXECUTED	7:3219cb88282c45abdbb9da6a33d2c2df	sql		\N	3.2.0
ADD-DEPRECATING-ADMIN-COLUMN-TO-PROFILE-TABLE	George Nash	/db/updates/add_deprecation_method_fields.xml	2019-01-24 10:44:36.229846	508	EXECUTED	7:b0b106c192c84c94827300750f6eff6c	addColumn		\N	3.2.0
ADD-DEPRECATING-ADMIN-FK-CONSTRAINT	George Nash	/db/updates/add_deprecation_method_fields.xml	2019-01-24 10:44:36.696005	509	EXECUTED	7:76aefb93a659ed7a83154718efc7ead0	addForeignKeyConstraint		\N	3.2.0
ADD-DEPRECATED-METHOD-COLUMN-TO-PROFILE-TABLE	George Nash	/db/updates/add_deprecation_method_fields.xml	2019-01-24 10:44:36.723154	510	EXECUTED	7:e8b6498f72a83e8fce1146f5a78ef244	addColumn		\N	3.2.0
UPDATE-TO-HTTPS	Tom Demeranville	/db/updates/identifier-types/update-to-https.xml	2019-01-24 10:44:36.728254	511	EXECUTED	7:884f83d97212d132811a2d8d496a6274	sql		\N	3.2.0
RRID-CASE-SENSITIVE	Tom Demeranville	/db/updates/identifier-types/update-to-https.xml	2019-01-24 10:44:36.731844	512	EXECUTED	7:6eadb7d2c4be9e4e205589e30619e4e1	sql		\N	3.2.0
INSTALL-PROFILE-HISTORY-EVENT-TABLE	George Nash	/db/updates/profile_history_event.xml	2019-01-24 10:44:36.753458	513	EXECUTED	7:5cffe52dbb49f38155ada1770a4d4842	createTable, createSequence		\N	3.2.0
ADD-PROFILE-HISTORY-EVENT-INDEX	George Nash	/db/updates/profile_history_event.xml	2019-01-24 10:44:36.774286	514	MARK_RAN	7:35c7f5667ac63bcc49ca4a5eccd84c82	sql		\N	3.2.0
UPDATE-RFC	Tom Demeranville	/db/updates/identifier-types/update-rfc-url.xml	2019-01-24 10:44:36.781151	515	EXECUTED	7:95bc6b393a062ba44755b3161e456644	sql		\N	3.2.0
CREATE-EMAIL-FREQUENCY-TABLE	Angel Montenegro	/db/updates/email_frequency_table.xml	2019-01-24 10:44:36.81606	516	EXECUTED	7:bb1a00e7d06ec60a35d7e765083784ef	createTable, addForeignKeyConstraint		\N	3.2.0
ADD-ORCID-INDEX-ON-EMAIL-FREQUENCY	Angel Montenegro	/db/updates/email_frequency_table.xml	2019-01-24 10:44:37.515957	517	EXECUTED	7:4fc973e074dbe43faa855afc063414bb	sql		\N	3.2.0
GRANT-READ-PERMISSIONS-TO-ORCIDRO-ON-EMAIL-FREQUENCY	Angel Montenegro	/db/updates/email_frequency_table.xml	2019-01-24 10:44:37.519931	518	EXECUTED	7:5ebf1502407fc67db85210383bc07a28	sql		\N	3.2.0
ADD-RETRY-COUNT-AND-NOTIFICATION-FAMILY-TO-NOTIFICATION	Angel Montenegro	/db/updates/notifications_retry_count_and_notification_family_to_notification_table.xml	2019-01-24 10:44:37.55101	519	EXECUTED	7:a78e62a88936b31d553de4e669c5d80f	sql (x2)		\N	3.2.0
ADD-INDEX-CLIENT-DETAILS-GROUP_ORCID	rcpeters	/db/updates/indexes_2018_05_14.xml	2019-01-24 10:44:38.252761	520	EXECUTED	7:b34f628e433c1f47c2ebc7d6f585cad2	sql		\N	3.2.0
ADD-ORG-DISA-ORG-DIS-ID	rcpeters	/db/updates/indexes_2018_05_14.xml	2019-01-24 10:44:38.957115	521	EXECUTED	7:71768737deccf4fbddf1a980739f6fe5	sql		\N	3.2.0
ADD-DISPLAY-INDEX-TO-AFFILIATION	George Nash	/db/updates/add-display-index-to-org-affiliation-relation.xml	2019-01-24 10:44:38.996895	522	EXECUTED	7:94f04c350bcc23dfe331749e69fce523	sql		\N	3.2.0
ADD-DEFAULT-TO-AFFILIATION-DISPLAY-INDEX	George Nash	/db/updates/add-display-index-to-org-affiliation-relation.xml	2019-01-24 10:44:39.0011	523	EXECUTED	7:18835ab87c8e799227dd42857bfe6c1e	sql		\N	3.2.0
UPDATE-NULL-AFFILIATION-DISPLAY-INDEX	George Nash	/db/updates/add-display-index-to-org-affiliation-relation.xml	2019-01-24 10:44:39.003994	524	EXECUTED	7:7b94b08e0beb385c27149ca2aeb7db4f	sql		\N	3.2.0
ADD-INDEX-ON-AUTH2-TOKEN-DETAIL-AUTH-CODE	rcpeters	/db/updates/add_index_oauth2_token_detail_code.xml	2019-01-24 10:44:39.71751	525	EXECUTED	7:70d5018c46a77e60b897da04f69719fc	sql		\N	3.2.0
INSTALL-GROUPING-SUGGESTION-TABLE	George Nash	/db/updates/grouping_suggestion.xml	2019-01-24 10:44:39.743911	526	EXECUTED	7:a4049775d2ffff29227608b07383cbcf	createTable, createSequence		\N	3.2.0
ADD-GROUPING-SUGGESTION-INDEX	George Nash	/db/updates/grouping_suggestion.xml	2019-01-24 10:44:40.458163	527	EXECUTED	7:b4365ba86434ada8985f1b5f343facf1	sql		\N	3.2.0
CHANGE-GROUPING-SUGGESTION-WORK-PUT-CODES-JSON-TYPE-TO-JSON	George Nash	/db/updates/grouping_suggestion.xml	2019-01-24 10:44:40.4873	528	EXECUTED	7:b7b5bf506b0ded18d29c9bb287647453	sql		\N	3.2.0
CREATE-RESEARCH-RESOURCE-TABLE	Tom Demeranville	/db/updates/create_research_resource_tables.xml	2019-01-24 10:44:40.548111	529	EXECUTED	7:8f7aeec3f336cdfae1e2db8366fd5950	createTable (x2), addForeignKeyConstraint (x2), createTable, addPrimaryKey, addForeignKeyConstraint (x2), createTable, addPrimaryKey, addForeignKeyConstraint (x2)		\N	3.2.0
CREATE-RESEARCH-RESOURCE-SEQUENCES	Tom Demeranville	/db/updates/create_research_resource_tables.xml	2019-01-24 10:44:40.608635	530	EXECUTED	7:d423cab9c727758414208fe4c727201d	createSequence (x2)		\N	3.2.0
RESEARCH-RESOURCE-ORCID-INDEX	Tom Demeranville	/db/updates/create_research_resource_tables.xml	2019-01-24 10:44:41.344302	531	EXECUTED	7:09a67ab3b210b7b526eaaeb035088cb7	sql		\N	3.2.0
RESEARCH-RESOURCE-ITEM-INDEX	Tom Demeranville	/db/updates/create_research_resource_tables.xml	2019-01-24 10:44:42.100714	532	EXECUTED	7:c9ab7f36f0bd0394812866fbeb300fe5	sql		\N	3.2.0
GRANT-READ-PERMISSIONS-TO-ORCIDRO-ON-RESEARCH-RESOURCE	Tom Demeranville	/db/updates/create_research_resource_tables.xml	2019-01-24 10:44:42.105683	533	EXECUTED	7:efac842b9244a7871a208dedb8ba6a81	sql (x4)		\N	3.2.0
CREATE-DNB-IDENTIFIER	Tom Demeranville	/db/updates/identifier-types/identifier-type-42-dnb.xml	2019-01-24 10:44:42.111499	534	EXECUTED	7:283e2e746ebb3b465d6cbba766bfab79	insert		\N	3.2.0
REMOVE-ENABLE-NOTIFICATIONS-COLUMN	George Nash	/db/updates/remove_enable_notifications_column.xml	2019-01-24 10:44:42.123221	535	EXECUTED	7:7b0a3c6fec01065caa210cc4e7d96b09	sql		\N	3.2.0
ADD-EMAIL-HASH-COLUMN-TO-EMAIL-TABLE	Angel Montenegro	/db/updates/add_email_hash_column_to_email_table.xml	2019-01-24 10:44:42.152922	536	EXECUTED	7:ded788c171074249fc01b536be1e921c	addColumn		\N	3.2.0
INIT-DISPLAY-INDEX	Angel Montenegro	/db/updates/init_display_index_on_affiliations.xml	2019-01-24 10:44:42.155825	537	EXECUTED	7:8d3f458ae03eaa0e853b4861514e71df	sql		\N	3.2.0
DISPLAY-INDEX-DEFAULT-VALUE	Angel Montenegro	/db/updates/init_display_index_on_affiliations.xml	2019-01-24 10:44:42.159668	538	EXECUTED	7:8628fd58adf944f74fa9d4d39813b51f	sql		\N	3.2.0
DROP-EMAIL-EVENT-CONSTRAINT	Angel Montenegro	/db/updates/use_email_hash_as_email_primary_key.xml	2019-01-24 10:44:42.163469	539	EXECUTED	7:ee2c6320ffc9ae64002a97e404ce7804	sql		\N	3.2.0
USE-EMAIL-HASH-AS-PRIMARY-KEY	Angel Montenegro	/db/updates/use_email_hash_as_email_primary_key.xml	2019-01-24 10:44:42.176685	540	EXECUTED	7:7177d81c619c65748ac732e3e5dfbbda	sql (x2)		\N	3.2.0
DROP-NOT-NULL-CONSTRAINT-ON-EMAIL	Angel Montenegro	/db/updates/drop_not_null_constraint_on_email.xml	2019-01-24 10:44:42.180853	541	EXECUTED	7:95dfb789700ce135c954462a72e8fe5a	sql		\N	3.2.0
PUBLIC-CLIENT-REDIRECT-URI-TYPE-SHOULD-BE-SSO	Angel Montenegro	/db/updates/fix-public-client-redirect-uri-type.xml	2019-01-24 10:44:42.184085	542	EXECUTED	7:f2c508bf85ab8450fadeeb1a3ca54517	sql		\N	3.2.0
CREATE-FIND-MY-STUFF-HISTORY-TABLE	TomDemeranville	/db/updates/find-my-stuff-history.xml	2019-01-24 10:44:42.213008	543	EXECUTED	7:0f83247d52a9aa87b4ab811736594247	createTable, addForeignKeyConstraint, addPrimaryKey		\N	3.2.0
GRANT-READ-PERMISSIONS-TO-ORCIDRO-ON-FMSH	Tom Demeranville	/db/updates/find-my-stuff-history.xml	2019-01-24 10:44:42.217294	544	EXECUTED	7:a98c64a916422d2be1992f0588e5f5cc	sql		\N	3.2.0
GRANT-READ-PERMISSIONS-TO-ORCIDRO-ON-GROUPING_SUGGESTION	George Nash	/db/updates/grant_select_grouping_suggestion.xml	2019-01-24 10:44:42.221787	545	EXECUTED	7:16f2cdee1c8d3168deea6a07c70ecba5	sql		\N	3.2.0
DROP-GROUPING-SUGGESTION-TABLE	George Nash	/db/updates/recreate_grouping_suggestion_table.xml	2019-01-24 10:44:42.226696	546	EXECUTED	7:807166c833b3561c6ccf7db5229508c2	sql (x2)		\N	3.2.0
INSTALL-REJECTED-GROUPING-SUGGESTION-TABLE	George Nash	/db/updates/recreate_grouping_suggestion_table.xml	2019-01-24 10:44:42.239387	547	EXECUTED	7:9bd3c64c6036ebe2053dc3d6baae7a74	createTable		\N	3.2.0
ADD-REJECTED-GROUPING-SUGGESTION-INDEX	George Nash	/db/updates/recreate_grouping_suggestion_table.xml	2019-01-24 10:44:42.996984	548	EXECUTED	7:16bb8265ca6f61d4e0ae62b2c45799cc	sql		\N	3.2.0
ORCIDRO-GRANT-REJECTED-SUGGESTION	George Nash	/db/updates/recreate_grouping_suggestion_table.xml	2019-01-24 10:44:43.001242	549	EXECUTED	7:72cc499878722816489a1329e9b361da	sql		\N	3.2.0
INSTALL-MEMBER-CHOSEN-ORG-DISAMBIGUATED-TABLE	George Nash	/db/updates/member_chosen_org_disambiguated_table.xml	2019-01-24 10:44:43.013358	550	EXECUTED	7:b61570860a7051b0320f11a1178d5ab5	createTable		\N	3.2.0
GRANT-READ-PERMISSIONS-TO-ORCIDRO-ON-MEMBER-CHOSEN-ORGS	George Nash	/db/updates/grant_select_member_chosen_org_disambiguated.xml	2019-01-24 10:44:43.017227	551	EXECUTED	7:858f4ffec92234a663c51ef1b89b14ac	sql		\N	3.2.0
ADD-OBO-CLIENT-DETAILS-ID-TO-TOKEN	Tom Demeranville	/db/updates/add_obo_client_details_id_to_token.xml	2019-01-24 10:44:43.048226	552	EXECUTED	7:cf795c1ad9a89df3e72b3ae8bda93493	addColumn, addForeignKeyConstraint		\N	3.2.0
ADD-OBO-CLIENT-DETAILS-ID-INDEX-TO-TOKEN	Tom Demeranville	/db/updates/add_obo_client_details_id_to_token.xml	2019-01-24 10:44:43.830608	553	EXECUTED	7:a3893252218cf5366fb07528de525639	sql		\N	3.2.0
ADD-ASSERTION-ORIGIN-TO-TABLES	Tom Demeranville	/db/updates/add_assertion_origin_columns.xml	2019-01-24 10:44:43.882691	554	EXECUTED	7:7ff064c05bfc8fb5a0832f3505d47080	addColumn (x13)		\N	3.2.0
UPDATE-ASSERTION-ORIGIN-CONSTRAINTS	Tom Demeranville	/db/updates/update_assertion_origin_constraints.xml	2019-01-24 10:44:43.888395	555	MARK_RAN	7:6ddc053b488d62901d368859aa720193	dropUniqueConstraint (x2), addUniqueConstraint, dropUniqueConstraint, addUniqueConstraint		\N	3.2.0
INSTALL-VALIDATED-PUBLIC-PROFILE-TABLE	George Nash	/db/updates/validated_public_profile_table.xml	2019-01-24 10:44:43.910413	556	EXECUTED	7:c986a5999262ab1ac3cb20ec7ac80670	createTable		\N	3.2.0
ORCIDRO-GRANT-VALIDATED-PUBLIC-PROFILE	George Nash	/db/updates/validated_public_profile_table.xml	2019-01-24 10:44:43.914965	557	EXECUTED	7:9ce1979b99b5d4b63bc63a99947c46d4	sql		\N	3.2.0
DISSERTATION-TO-DISSERTATION-THESIS	Angel Montenegro	/db/updates/dissertation_to_dissertation-thesis.xml	2019-01-24 10:44:43.917738	558	EXECUTED	7:d30f716b1f82c79865130aa53ba1ea85	sql		\N	3.2.0
DISSERTATION-TO-DISSERTATION-THESIS	George Nash	/db/updates/peer_review_dissertation_to_dissertation-thesis.xml	2019-01-24 10:44:43.920603	559	EXECUTED	7:b3e16f538e6729759a49eee50a3f4fdb	sql		\N	3.2.0
CREATE-PROPOSAL-IDENTIFIER	Tom Demeranville	/db/updates/identifier-types/identifier-type-43-proposal-id.xml	2019-01-24 10:44:43.925831	560	EXECUTED	7:0284095d86d1964107974121184d951c	insert		\N	3.2.0
ADD-WORK-EXTERNAL-IDS-JSON-COLUMN	Will Simpson	/db/updates/work-external-ids-as-json.xml	2019-01-24 16:56:34.257718	1	EXECUTED	7:e1cba068309ff6ae561ad4a46f9209dc	addColumn		\N	3.2.0
CONVERT-TEXT-TO-JSON	Will Simpson	/db/updates/work-external-ids-as-json.xml	2019-01-24 16:56:34.275434	2	EXECUTED	7:59d7f7aeb42e754db84a5c2dd7044cdb	sql (x2), createProcedure (x2), createIndex		\N	3.2.0
ADD-JSON-CAST	Will Simpson	/db/updates/work-external-ids-as-json.xml	2019-01-24 16:56:34.278604	3	EXECUTED	7:ca804e7ec59fac915f72fc02b2f4fb57	sql		\N	3.2.0
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

COPY public.email (date_created, last_modified, email, orcid, visibility, is_primary, is_current, is_verified, source_id, client_source_id, email_hash, assertion_origin_source_id, assertion_origin_client_source_id) FROM stdin;
\.


--
-- Data for Name: email_event; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.email_event (id, date_created, last_modified, email, email_event_type) FROM stdin;
\.


--
-- Data for Name: email_frequency; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.email_frequency (id, orcid, date_created, last_modified, send_administrative_change_notifications, send_change_notifications, send_member_update_requests, send_quarterly_tips) FROM stdin;
\.


--
-- Data for Name: external_identifier; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.external_identifier (date_created, last_modified, orcid, external_id_reference, external_id_type, external_id_url, source_id, client_source_id, id, visibility, display_index, assertion_origin_source_id, assertion_origin_client_source_id) FROM stdin;
\.


--
-- Data for Name: find_my_stuff_history; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.find_my_stuff_history (orcid, finder_name, last_count, opt_out, actioned, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: funding_external_identifier; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.funding_external_identifier (funding_external_identifier_id, profile_funding_id, ext_type, ext_value, ext_url, date_created, last_modified) FROM stdin;
\.


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
-- Data for Name: granted_authority; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.granted_authority (authority, orcid, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: group_id_record; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.group_id_record (id, group_id, group_name, group_description, group_type, source_id, client_source_id, date_created, last_modified, assertion_origin_source_id, assertion_origin_client_source_id) FROM stdin;
\.


--
-- Data for Name: identifier_type; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.identifier_type (id, id_name, id_validation_regex, id_resolution_prefix, id_deprecated, client_source_id, date_created, last_modified, primary_use, case_sensitive) FROM stdin;
0	OTHER_ID	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
2	ASIN_TLD	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
6	EID	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
8	ISSN	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
21	AGR	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
22	CBA	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
23	CIT	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
24	CTX	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
26	HANDLE	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
27	HIR	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
28	PAT	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
29	SOURCE_WORK_ID	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
30	URI	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
31	URN	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
32	WOSUID	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
33	GRANT_NUMBER	\N	\N	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	funding	f
1	ASIN	\N	http://www.amazon.com/dp/	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
25	ETHOS	\N	http://ethos.bl.uk/OrderDetails.do?uin=	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
9	JFM	\N	http://zbmath.org/?format=complete&q=an%3A	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
10	JSTOR	\N	http://www.jstor.org/stable/	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
11	LCCN	\N	http://lccn.loc.gov/	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
12	MR	\N	http://www.ams.org/mathscinet-getitem?mr=	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
13	OCLC	\N	http://www.worldcat.org/oclc/	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
14	OL	\N	http://openlibrary.org/b/	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
15	OSTI	\N	http://www.osti.gov/energycitations/product.biblio.jsp?osti_id=	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
19	SSRN	\N	http://papers.ssrn.com/abstract_id=	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
20	ZBL	\N	http://zbmath.org/?format=complete&q=	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
36	LENSID	\N	https://www.lens.org/	f	\N	2019-01-24 16:44:29.984689+00	2019-01-24 16:44:29.984689+00	work	f
34	PDB	\N	http://identifiers.org/pdb/	f	\N	2019-01-24 16:44:29.974562+00	2019-01-24 16:44:29.974562+00	work	f
38	CIENCIAIUL	\N	https://ciencia.iscte-iul.pt/id/	f	\N	2019-01-24 16:44:30.155078+00	2019-01-24 16:44:30.155078+00	work	f
5	DOI	\N	https://doi.org/	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
35	KUID	\N	https://koreamed.org/article/	f	\N	2019-01-24 16:44:29.97954+00	2019-01-24 16:44:29.97954+00	work	f
40	AUTHENTICUSID	\N	https://www.authenticus.pt/	f	\N	2019-01-24 16:44:35.087645+00	2019-01-24 16:44:35.087645+00	work	f
4	BIBCODE	\N	http://adsabs.harvard.edu/abs/	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	t
41	ARK	\N	\N	f	\N	2019-01-24 16:44:36.197027+00	2019-01-24 16:44:36.197027+00	work	t
7	ISBN	\N	https://www.worldcat.org/isbn/	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
3	ARXIV	\N	https://arxiv.org/abs/	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
16	PMC	\N	https://europepmc.org/articles/	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
17	PMID	\N	https://www.ncbi.nlm.nih.gov/pubmed/	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
39	RRID	\N	https://identifiers.org/rrid/	f	\N	2019-01-24 16:44:34.860762+00	2019-01-24 16:44:34.860762+00	work	t
18	RFC	\N	https://tools.ietf.org/html/	f	\N	2019-01-24 16:44:24.77545+00	2019-01-24 16:44:24.77545+00	work	f
42	DNB	\N	https://d-nb.info/	f	\N	2019-01-24 16:44:42.109459+00	2019-01-24 16:44:42.109459+00	work	f
43	PROPOSAL_ID	\N	\N	f	\N	2019-01-24 16:44:43.923948+00	2019-01-24 16:44:43.923948+00	funding	f
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.identity_provider (id, date_created, last_modified, providerid, display_name, support_email, admin_email, tech_email, last_failed, failed_count) FROM stdin;
\.


--
-- Data for Name: identity_provider_name; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.identity_provider_name (id, date_created, last_modified, identity_provider_id, display_name, lang) FROM stdin;
\.


--
-- Data for Name: institution; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.institution (id, date_created, last_modified, institution_name, address_id) FROM stdin;
\.


--
-- Data for Name: internal_sso; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.internal_sso (orcid, token, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: invalid_record_data_changes; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.invalid_record_data_changes (sql_used_to_update, description, num_changed, type, date_created, last_modified, id) FROM stdin;
\.


--
-- Data for Name: member_chosen_org_disambiguated; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.member_chosen_org_disambiguated (org_disambiguated_id) FROM stdin;
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.notification (id, date_created, last_modified, orcid, notification_type, subject, body_text, body_html, sent_date, read_date, archived_date, sendable, source_id, authorization_url, lang, client_source_id, amended_section, actioned_date, notification_subject, notification_intro, authentication_provider_id, retry_count, notification_family, assertion_origin_source_id, assertion_origin_client_source_id) FROM stdin;
\.


--
-- Data for Name: notification_item; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.notification_item (id, notification_id, date_created, last_modified, item_type, item_name, external_id_type, external_id_value) FROM stdin;
\.


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

COPY public.oauth2_token_detail (token_value, token_type, token_expiration, user_orcid, client_details_id, is_approved, redirect_uri, response_type, state, scope_type, resource_id, date_created, last_modified, authentication_key, id, refresh_token_expiration, refresh_token_value, token_disabled, persistent, version, authorization_code, revocation_date, revoke_reason, obo_client_details_id) FROM stdin;
\.


--
-- Data for Name: orcid_props; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.orcid_props (key, prop_value, date_created, last_modified) FROM stdin;
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

COPY public.org_affiliation_relation (id, org_id, orcid, org_affiliation_relation_role, org_affiliation_relation_title, department, start_day, start_month, start_year, end_day, end_month, end_year, visibility, source_id, date_created, last_modified, client_source_id, url, external_ids_json, display_index, assertion_origin_source_id, assertion_origin_client_source_id) FROM stdin;
\.


--
-- Data for Name: org_disambiguated; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.org_disambiguated (id, source_id, source_url, source_type, org_type, name, city, region, country, url, status, date_created, last_modified, indexing_status, last_indexed_date, popularity, source_parent_id) FROM stdin;
1000	A	http://orcid.org	TEST	\N	A affiliation	A town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1001	B	http://orcid.org	TEST	\N	B affiliation	B town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1002	C	http://orcid.org	TEST	\N	C affiliation	C town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1003	D	http://orcid.org	TEST	\N	D affiliation	D town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1004	E	http://orcid.org	TEST	\N	E affiliation	E town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1005	F	http://orcid.org	TEST	\N	F affiliation	F town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1006	G	http://orcid.org	TEST	\N	G affiliation	G town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1007	H	http://orcid.org	TEST	\N	H affiliation	H town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1008	I	http://orcid.org	TEST	\N	I affiliation	I town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1009	J	http://orcid.org	TEST	\N	J affiliation	J town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1010	K	http://orcid.org	TEST	\N	K affiliation	K town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1011	L	http://orcid.org	TEST	\N	L affiliation	L town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1012	M	http://orcid.org	TEST	\N	M affiliation	M town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1013	N	http://orcid.org	TEST	\N	N affiliation	N town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1014	O	http://orcid.org	TEST	\N	O affiliation	O town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1015	P	http://orcid.org	TEST	\N	P affiliation	P town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1016	Q	http://orcid.org	TEST	\N	Q affiliation	Q town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1017	R	http://orcid.org	TEST	\N	R affiliation	R town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1018	S	http://orcid.org	TEST	\N	S affiliation	S town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1019	T	http://orcid.org	TEST	\N	T affiliation	T town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1020	U	http://orcid.org	TEST	\N	U affiliation	U town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1021	V	http://orcid.org	TEST	\N	V affiliation	V town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1022	W	http://orcid.org	TEST	\N	W affiliation	W town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1023	X	http://orcid.org	TEST	\N	X affiliation	X town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1024	Y	http://orcid.org	TEST	\N	Y affiliation	Y town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
1025	Z	http://orcid.org	TEST	\N	Z affiliation	Z town	\N	BM	\N	\N	2019-01-24 16:44:02.580014+00	2019-01-24 16:44:02.580014+00	PENDING	\N	0	\N
\.


--
-- Data for Name: org_disambiguated_external_identifier; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.org_disambiguated_external_identifier (id, org_disambiguated_id, identifier, identifier_type, date_created, last_modified, preferred) FROM stdin;
\.


--
-- Data for Name: other_name; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.other_name (other_name_id, date_created, last_modified, display_name, orcid, visibility, source_id, client_source_id, display_index, assertion_origin_source_id, assertion_origin_client_source_id) FROM stdin;
\.


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
-- Data for Name: patent_source; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.patent_source (orcid, patent_id, source_orcid, deposited_date, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: peer_review; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.peer_review (id, orcid, peer_review_subject_id, external_identifiers_json, org_id, peer_review_role, peer_review_type, completion_day, completion_month, completion_year, source_id, url, visibility, client_source_id, date_created, last_modified, display_index, subject_external_identifiers_json, subject_type, subject_container_name, subject_name, subject_translated_name, subject_translated_name_language_code, subject_url, group_id, assertion_origin_source_id, assertion_origin_client_source_id) FROM stdin;
\.


--
-- Data for Name: peer_review_subject; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.peer_review_subject (id, external_identifiers_json, title, work_type, sub_title, translated_title, translated_title_language_code, url, journal_title, date_created, last_modified) FROM stdin;
\.


--
-- Data for Name: profile; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.profile (orcid, date_created, last_modified, account_expiry, account_non_locked, completed_date, claimed, creation_method, credentials_expiry, credit_name, enabled, encrypted_password, encrypted_security_answer, encrypted_verification_code, family_name, given_names, is_selectable_sponsor, send_change_notifications, send_orcid_news, biography, vocative_name, security_question_id, source_id, non_locked, biography_visibility, keywords_visibility, external_identifiers_visibility, researcher_urls_visibility, other_names_visibility, orcid_type, group_orcid, submission_date, indexing_status, names_visibility, iso2_country, profile_address_visibility, profile_deactivation_date, activities_visibility_default, last_indexed_date, locale, client_type, group_type, primary_record, deprecated_date, referred_by, enable_developer_tools, send_email_frequency_days, send_orcid_feature_announcements, send_member_update_requests, salesforce_id, client_source_id, developer_tools_enabled_date, record_locked, used_captcha_on_registration, user_last_ip, reviewed, send_administrative_change_notifications, reason_locked, reason_locked_description, hashed_orcid, secret_for_2fa, using_2fa, last_login, deprecating_admin, deprecated_method) FROM stdin;
\.


--
-- Data for Name: profile_event; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.profile_event (id, date_created, last_modified, orcid, profile_event_type, comment) FROM stdin;
\.


--
-- Data for Name: profile_funding; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.profile_funding (id, org_id, orcid, title, type, currency_code, translated_title, translated_title_language_code, description, start_day, start_month, start_year, end_day, end_month, end_year, url, contributors_json, visibility, source_id, date_created, last_modified, organization_defined_type, numeric_amount, display_index, client_source_id, external_identifiers_json, assertion_origin_source_id, assertion_origin_client_source_id) FROM stdin;
\.


--
-- Data for Name: profile_history_event; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.profile_history_event (id, date_created, last_modified, orcid, event_type, comment) FROM stdin;
\.


--
-- Data for Name: profile_keyword; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.profile_keyword (profile_orcid, keywords_name, date_created, last_modified, id, visibility, source_id, client_source_id, display_index, assertion_origin_source_id, assertion_origin_client_source_id) FROM stdin;
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
-- Data for Name: reference_data; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.reference_data (id, date_created, last_modified, ref_data_key, ref_data_value) FROM stdin;
0	2019-01-24 10:43:57.521402	2019-01-24 10:43:57.521402	emailVerificationURL	http://localhost:8080/orcid-frontend-web
\.


--
-- Data for Name: rejected_grouping_suggestion; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.rejected_grouping_suggestion (put_codes, date_created, last_modified, orcid) FROM stdin;
\.


--
-- Data for Name: research_resource; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.research_resource (id, orcid, source_id, client_source_id, proposal_type, external_identifiers_json, title, translated_title, translated_title_language_code, url, display_index, start_day, start_month, start_year, end_day, end_month, end_year, visibility, date_created, last_modified, assertion_origin_source_id, assertion_origin_client_source_id) FROM stdin;
\.


--
-- Data for Name: research_resource_item; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.research_resource_item (id, research_resource_id, resource_name, resource_type, external_identifiers_json, url, item_index) FROM stdin;
\.


--
-- Data for Name: research_resource_item_org; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.research_resource_item_org (research_resource_item_id, org_id, org_index) FROM stdin;
\.


--
-- Data for Name: research_resource_org; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.research_resource_org (research_resource_id, org_id, org_index) FROM stdin;
\.


--
-- Data for Name: researcher_url; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.researcher_url (url, date_created, last_modified, orcid, id, url_name, visibility, source_id, client_source_id, display_index, assertion_origin_source_id, assertion_origin_client_source_id) FROM stdin;
\.


--
-- Data for Name: salesforce_connection; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.salesforce_connection (id, date_created, last_modified, orcid, email, salesforce_account_id, is_primary) FROM stdin;
\.


--
-- Data for Name: security_question; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.security_question (id, date_created, last_modified, question, key) FROM stdin;
0	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	None Selected	manage.security_question.id.0
1	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	What was the name of your first school?	manage.security_question.id.1
2	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	What is your favorite pastime?	manage.security_question.id.2
3	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	What is your all-time favorite sports team?	manage.security_question.id.3
4	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	What make was your first car or bike?	manage.security_question.id.4
5	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	Where did you first meet your spouse?	manage.security_question.id.5
6	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	What is your pet's name?	manage.security_question.id.6
7	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	What year were you born?	manage.security_question.id.7
8	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	In what city were you born?	manage.security_question.id.8
9	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	How many siblings do you have?	manage.security_question.id.9
10	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	What is your favorite sport or hobby?	manage.security_question.id.10
11	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	In what city was your mother born?	manage.security_question.id.11
12	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	In what city was your father born?	manage.security_question.id.12
13	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	What is the name of your high school?	manage.security_question.id.13
14	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	What year did you graduate from high school?	manage.security_question.id.14
15	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	What is your father's middle name?	manage.security_question.id.15
16	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	What is your mother's middle name?	manage.security_question.id.16
17	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	What is your favorite color?	manage.security_question.id.17
18	2019-01-24 10:43:57.578541	2019-01-24 10:43:57.578541	What is your mother's maiden name?	manage.security_question.id.18
\.


--
-- Data for Name: shibboleth_account; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.shibboleth_account (id, date_created, last_modified, orcid, remote_user, shib_identity_provider) FROM stdin;
\.


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.subject (name, date_created, last_modified) FROM stdin;
Acoustics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Agriculture	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Allergy	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Anatomy & Morphology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Anesthesiology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Anthropology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Archaeology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Architecture	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Area Studies	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Art	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Arts & Humanities - Other	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Asian Studies	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Astronomy & Astrophysics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Automation & Control Systems	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Behavioral Sciences	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Biochemistry & Molecular Biology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Biodiversity & Conservation	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Biomedical Social Sciences	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Biophysics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Biotechnology & Applied Microbiology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Business & Economics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Cardiovascular System & Cardiology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Cell Biology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Chemistry	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Classics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Communication	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Computer Science	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Construction & Building Technology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Criminology & Penology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Critical Care Medicine	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Crystallography	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Dance	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Demography	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Dentistry, Oral Surgery & Medicine	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Dermatology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Developmental Biology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Education & Educational Research	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Electrochemistry	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Emergency Medicine	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Endocrinology & Metabolism	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Energy & Fuels	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Engineering	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Entomology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Environmental Sciences & Ecology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Ethnic Studies	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Evolutionary Biology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Family Studies	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Film, Radio & Television	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Fisheries	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Food Science & Technology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Forestry	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Gastroenterology & Hepatology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
General & Internal Medicine	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Genetics & Heredity	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Geochemistry & Geophysics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Geography	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Geology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Geriatrics & Gerontology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Government & Law	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Health Care Sciences & Services	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Hematology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
History	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
History & Philosophy of Science	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Imaging Science & Photographic Technology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Immunology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Infectious Diseases	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Information Science & Library Science	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Instruments & Instrumentation	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Integrative & Complementary Medicine	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
International Relations	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Legal Medicine	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Life Sciences & Biomedicine - Other 	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Linguistics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Literature	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Marine & Freshwater Biology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Materials Science	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Mathematical & Computational Biology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Mathematical Methods In Social Sciences	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Mathematics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Mechanics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Medical Ethics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Medical Informatics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Medical Laboratory Technology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Metallurgy & Metallurgical Engineering	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Meteorology & Atmospheric Sciences	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Microbiology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Microscopy	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Mineralogy	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Mining & Mineral Processing	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Music	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Mycology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Neurosciences & Neurology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Nuclear Science & Technology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Nursing	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Nutrition & Dietetics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Obstetrics & Gynecology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Oceanography	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Oncology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Operations Research & Management Science	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Ophthalmology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Optics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Orthopedics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Otorhinolaryngology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Paleontology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Parasitology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Pathology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Pediatrics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Pharmacology & Pharmacy	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Philosophy	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Physical Geography	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Physics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Physiology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Plant Sciences	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Polymer Science	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Psychiatry	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Psychology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Public Administration	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Public, Environmental & Occupational Health	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Radiology, Nuclear Medicine & Medical Imaging	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Rehabilitation	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Religion	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Remote Sensing	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Reproductive Biology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Research & Experimental Medicine	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Respiratory System	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Rheumatology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Robotics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Science & Technology - Other 	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Social Issues	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Social Sciences - Other	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Social Work	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Sociology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Spectroscopy	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Sport Sciences	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Substance Abuse	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Surgery	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Telecommunications	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Theater	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Thermodynamics	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Toxicology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Transplantation	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Transportation	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Tropical Medicine	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Urban Studies	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Urology & Nephrology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Veterinary Sciences	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Virology	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Water Resources	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
Women's Studies	2019-01-24 10:43:57.609962	2019-01-24 10:43:57.609962
\.


--
-- Data for Name: userconnection; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.userconnection (userid, email, orcid, providerid, provideruserid, rank, displayname, profileurl, imageurl, accesstoken, secret, refreshtoken, expiretime, is_linked, last_login, date_created, last_modified, id_type, status, headers_json) FROM stdin;
\.


--
-- Data for Name: validated_public_profile; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.validated_public_profile (orcid, date_created, last_modified, error, valid) FROM stdin;
\.


--
-- Data for Name: webhook; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.webhook (orcid, client_details_id, uri, date_created, last_modified, last_failed, failed_attempt_count, enabled, disabled_date, disabled_comments, last_sent, profile_last_modified) FROM stdin;
\.


--
-- Data for Name: work; Type: TABLE DATA; Schema: public; Owner: orcid
--

COPY public.work (work_id, date_created, last_modified, publication_day, publication_month, publication_year, title, subtitle, description, work_url, citation, work_type, citation_type, contributors_json, journal_title, language_code, translated_title, translated_title_language_code, iso2_country, external_ids_json, orcid, added_to_profile_date, visibility, display_index, source_id, client_source_id, assertion_origin_source_id, assertion_origin_client_source_id) FROM stdin;
\.


--
-- Name: access_token_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.access_token_seq', 1000, true);


--
-- Name: address_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.address_seq', 1000, true);


--
-- Name: author_other_name_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.author_other_name_seq', 1000, true);


--
-- Name: backup_code_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.backup_code_seq', 1, false);


--
-- Name: biography_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.biography_seq', 1000, false);


--
-- Name: email_event_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.email_event_seq', 1000, true);


--
-- Name: external_identifier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.external_identifier_id_seq', 1, false);


--
-- Name: funding_external_identifier_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.funding_external_identifier_seq', 1000, true);


--
-- Name: given_permission_to_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.given_permission_to_seq', 1000, true);


--
-- Name: grant_contributor_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.grant_contributor_seq', 1000, true);


--
-- Name: grant_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.grant_seq', 1000, true);


--
-- Name: group_id_record_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.group_id_record_seq', 1000, false);


--
-- Name: identifier_type_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.identifier_type_seq', 1000, false);


--
-- Name: identity_provider_name_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.identity_provider_name_seq', 1, false);


--
-- Name: identity_provider_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.identity_provider_seq', 1, false);


--
-- Name: institution_department_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.institution_department_seq', 1000, true);


--
-- Name: institution_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.institution_seq', 1000, true);


--
-- Name: invalid_record_change_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.invalid_record_change_seq', 1000, false);


--
-- Name: keyword_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.keyword_seq', 1000, false);


--
-- Name: notification_item_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.notification_item_seq', 1000, true);


--
-- Name: notification_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.notification_seq', 1000, true);


--
-- Name: org_affiliation_relation_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.org_affiliation_relation_seq', 1000, true);


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

SELECT pg_catalog.setval('public.org_seq', 1000, true);


--
-- Name: other_name_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.other_name_seq', 1000, true);


--
-- Name: patent_contributor_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.patent_contributor_seq', 1000, true);


--
-- Name: patent_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.patent_seq', 1000, true);


--
-- Name: peer_review_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.peer_review_seq', 1000, false);


--
-- Name: peer_review_subject_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.peer_review_subject_seq', 1000, false);


--
-- Name: profile_event_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.profile_event_seq', 1000, true);


--
-- Name: profile_funding_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.profile_funding_seq', 1000, true);


--
-- Name: profile_history_event_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.profile_history_event_seq', 1, false);


--
-- Name: record_name_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.record_name_seq', 1000, false);


--
-- Name: reference_data_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.reference_data_seq', 1000, true);


--
-- Name: related_url_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.related_url_seq', 1000, true);


--
-- Name: research_resource_item_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.research_resource_item_seq', 1000, false);


--
-- Name: research_resource_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.research_resource_seq', 1000, false);


--
-- Name: researcher_url_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.researcher_url_seq', 1000, true);


--
-- Name: salesforce_connection_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.salesforce_connection_seq', 1, false);


--
-- Name: shibboleth_account_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.shibboleth_account_seq', 1, false);


--
-- Name: work_contributor_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.work_contributor_seq', 1000, true);


--
-- Name: work_seq; Type: SEQUENCE SET; Schema: public; Owner: orcid
--

SELECT pg_catalog.setval('public.work_seq', 1000, true);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: backup_code backup_code_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.backup_code
    ADD CONSTRAINT backup_code_pkey PRIMARY KEY (id);


--
-- Name: biography biography_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.biography
    ADD CONSTRAINT biography_pkey PRIMARY KEY (id);


--
-- Name: client_authorised_grant_type client_authorised_grant_type_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_authorised_grant_type
    ADD CONSTRAINT client_authorised_grant_type_pkey PRIMARY KEY (client_details_id, grant_type);


--
-- Name: client_details client_details_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_details
    ADD CONSTRAINT client_details_pkey PRIMARY KEY (client_details_id);


--
-- Name: client_granted_authority client_granted_authority_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_granted_authority
    ADD CONSTRAINT client_granted_authority_pkey PRIMARY KEY (client_details_id, granted_authority);


--
-- Name: client_redirect_uri client_redirect_uri_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_redirect_uri
    ADD CONSTRAINT client_redirect_uri_pkey PRIMARY KEY (client_details_id, redirect_uri, redirect_uri_type);


--
-- Name: client_resource_id client_resource_id_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_resource_id
    ADD CONSTRAINT client_resource_id_pkey PRIMARY KEY (client_details_id, resource_id);


--
-- Name: client_scope client_scope_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT client_scope_pkey PRIMARY KEY (client_details_id, scope_type);


--
-- Name: client_secret client_secret_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_secret
    ADD CONSTRAINT client_secret_pk PRIMARY KEY (client_details_id, client_secret);


--
-- Name: country_reference_data country_id_id_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.country_reference_data
    ADD CONSTRAINT country_id_id_pkey PRIMARY KEY (country_iso_code);


--
-- Name: email_event email_event_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.email_event
    ADD CONSTRAINT email_event_pkey PRIMARY KEY (id);


--
-- Name: email_frequency email_frequency_orcid_unique; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.email_frequency
    ADD CONSTRAINT email_frequency_orcid_unique UNIQUE (orcid);


--
-- Name: email_frequency email_frequency_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.email_frequency
    ADD CONSTRAINT email_frequency_pkey PRIMARY KEY (id);


--
-- Name: email email_primary_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT email_primary_key PRIMARY KEY (email_hash);


--
-- Name: external_identifier external_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.external_identifier
    ADD CONSTRAINT external_identifier_pkey PRIMARY KEY (id);


--
-- Name: find_my_stuff_history find_my_stuff_history_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.find_my_stuff_history
    ADD CONSTRAINT find_my_stuff_history_pkey PRIMARY KEY (orcid, finder_name);


--
-- Name: funding_external_identifier funding_external_identifier_constraints; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.funding_external_identifier
    ADD CONSTRAINT funding_external_identifier_constraints UNIQUE (profile_funding_id, ext_type, ext_value, ext_url);


--
-- Name: funding_external_identifier funding_external_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.funding_external_identifier
    ADD CONSTRAINT funding_external_identifier_pkey PRIMARY KEY (funding_external_identifier_id);


--
-- Name: given_permission_to given_permission_to_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.given_permission_to
    ADD CONSTRAINT given_permission_to_pkey PRIMARY KEY (given_permission_to_id);


--
-- Name: granted_authority granted_authority_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.granted_authority
    ADD CONSTRAINT granted_authority_pkey PRIMARY KEY (authority, orcid);


--
-- Name: group_id_record group_id_record_group_id_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.group_id_record
    ADD CONSTRAINT group_id_record_group_id_key UNIQUE (group_id);


--
-- Name: group_id_record group_id_record_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.group_id_record
    ADD CONSTRAINT group_id_record_pkey PRIMARY KEY (id);


--
-- Name: identifier_type identifier_type_id_name_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.identifier_type
    ADD CONSTRAINT identifier_type_id_name_key UNIQUE (id_name);


--
-- Name: identifier_type identifier_type_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.identifier_type
    ADD CONSTRAINT identifier_type_pkey PRIMARY KEY (id);


--
-- Name: identity_provider_name identity_provider_name_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.identity_provider_name
    ADD CONSTRAINT identity_provider_name_pkey PRIMARY KEY (id);


--
-- Name: identity_provider identity_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT identity_provider_pkey PRIMARY KEY (id);


--
-- Name: identity_provider identity_provider_providerid_unique; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT identity_provider_providerid_unique UNIQUE (providerid);


--
-- Name: institution institution_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.institution
    ADD CONSTRAINT institution_pkey PRIMARY KEY (id);


--
-- Name: internal_sso internal_sso_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.internal_sso
    ADD CONSTRAINT internal_sso_pkey PRIMARY KEY (orcid);


--
-- Name: invalid_record_data_changes invalid_record_data_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.invalid_record_data_changes
    ADD CONSTRAINT invalid_record_data_changes_pkey PRIMARY KEY (id);


--
-- Name: member_chosen_org_disambiguated member_chosen_org_disambiguated_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.member_chosen_org_disambiguated
    ADD CONSTRAINT member_chosen_org_disambiguated_pkey PRIMARY KEY (org_disambiguated_id);


--
-- Name: notification_item notification_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification_item
    ADD CONSTRAINT notification_activity_pkey PRIMARY KEY (id);


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: notification_work notification_work_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification_work
    ADD CONSTRAINT notification_work_pkey PRIMARY KEY (notification_id, work_id);


--
-- Name: oauth2_authoriziation_code_detail oauth2_authoriziation_code_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_authoriziation_code_detail
    ADD CONSTRAINT oauth2_authoriziation_code_detail_pkey PRIMARY KEY (authoriziation_code_value);


--
-- Name: oauth2_token_detail oauth2_token_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_token_detail
    ADD CONSTRAINT oauth2_token_detail_pkey PRIMARY KEY (id);


--
-- Name: oauth2_token_detail oauth2_token_detail_refresh_token_value_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_token_detail
    ADD CONSTRAINT oauth2_token_detail_refresh_token_value_key UNIQUE (refresh_token_value);


--
-- Name: orcidoauth2authoriziationcodedetail_authorities orcidoauth2authoriziationcodedetail_authorities_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcidoauth2authoriziationcodedetail_authorities
    ADD CONSTRAINT orcidoauth2authoriziationcodedetail_authorities_pkey PRIMARY KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value, authorities);


--
-- Name: orcidoauth2authoriziationcodedetail_resourceids orcidoauth2authoriziationcodedetail_resourceids_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcidoauth2authoriziationcodedetail_resourceids
    ADD CONSTRAINT orcidoauth2authoriziationcodedetail_resourceids_pkey PRIMARY KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value, resourceids);


--
-- Name: orcidoauth2authoriziationcodedetail_scopes orcidoauth2authoriziationcodedetail_scopes_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcidoauth2authoriziationcodedetail_scopes
    ADD CONSTRAINT orcidoauth2authoriziationcodedetail_scopes_pkey PRIMARY KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value, scopes);


--
-- Name: org_affiliation_relation org_affiliation_relation_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org_affiliation_relation
    ADD CONSTRAINT org_affiliation_relation_pkey PRIMARY KEY (id);


--
-- Name: org_disambiguated_external_identifier org_disambiguated_external_identifier_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org_disambiguated_external_identifier
    ADD CONSTRAINT org_disambiguated_external_identifier_pkey PRIMARY KEY (id);


--
-- Name: org_disambiguated org_disambiguated_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org_disambiguated
    ADD CONSTRAINT org_disambiguated_pkey PRIMARY KEY (id);


--
-- Name: org org_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT org_pkey PRIMARY KEY (id);


--
-- Name: org org_unique_constraints; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT org_unique_constraints UNIQUE (name, city, region, country, org_disambiguated_id);


--
-- Name: other_name other_name_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.other_name
    ADD CONSTRAINT other_name_pkey PRIMARY KEY (other_name_id);


--
-- Name: patent_contributor patent_contributor_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent_contributor
    ADD CONSTRAINT patent_contributor_pk PRIMARY KEY (patent_contributor_id);


--
-- Name: patent patent_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent
    ADD CONSTRAINT patent_pkey PRIMARY KEY (patent_id);


--
-- Name: patent_source patent_source_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent_source
    ADD CONSTRAINT patent_source_pk PRIMARY KEY (orcid, patent_id, source_orcid);


--
-- Name: peer_review peer_review_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.peer_review
    ADD CONSTRAINT peer_review_pkey PRIMARY KEY (id);


--
-- Name: peer_review_subject peer_review_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.peer_review_subject
    ADD CONSTRAINT peer_review_subject_pkey PRIMARY KEY (id);


--
-- Name: custom_email pk_custom_email; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.custom_email
    ADD CONSTRAINT pk_custom_email PRIMARY KEY (client_details_id, email_type);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: funding_subtype_to_index pk_funding_subtype_to_index; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.funding_subtype_to_index
    ADD CONSTRAINT pk_funding_subtype_to_index PRIMARY KEY (orcid, subtype);


--
-- Name: orcid_social pk_orcid_social; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcid_social
    ADD CONSTRAINT pk_orcid_social PRIMARY KEY (orcid, type);


--
-- Name: affiliation primary_profile_institution_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.affiliation
    ADD CONSTRAINT primary_profile_institution_pkey PRIMARY KEY (institution_id, orcid);


--
-- Name: profile_event profile_event_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_event
    ADD CONSTRAINT profile_event_pkey PRIMARY KEY (id);


--
-- Name: profile_funding profile_funding_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_funding
    ADD CONSTRAINT profile_funding_pkey PRIMARY KEY (id);


--
-- Name: profile_history_event profile_history_event_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_history_event
    ADD CONSTRAINT profile_history_event_pkey PRIMARY KEY (id);


--
-- Name: profile_keyword profile_keyword_numeric_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_keyword
    ADD CONSTRAINT profile_keyword_numeric_pkey PRIMARY KEY (id);


--
-- Name: profile_patent profile_patent_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_patent
    ADD CONSTRAINT profile_patent_pk PRIMARY KEY (orcid, patent_id);


--
-- Name: profile profile_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_pkey PRIMARY KEY (orcid);


--
-- Name: profile_subject profile_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_subject
    ADD CONSTRAINT profile_subject_pkey PRIMARY KEY (profile_orcid, subjects_name);


--
-- Name: record_name record_name_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.record_name
    ADD CONSTRAINT record_name_pkey PRIMARY KEY (id);


--
-- Name: reference_data reference_data_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.reference_data
    ADD CONSTRAINT reference_data_pkey PRIMARY KEY (id);


--
-- Name: rejected_grouping_suggestion rejected_grouping_suggestion_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.rejected_grouping_suggestion
    ADD CONSTRAINT rejected_grouping_suggestion_pkey PRIMARY KEY (put_codes);


--
-- Name: research_resource_item_org research_resource_item_org_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.research_resource_item_org
    ADD CONSTRAINT research_resource_item_org_pkey PRIMARY KEY (research_resource_item_id, org_id);


--
-- Name: research_resource_item research_resource_item_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.research_resource_item
    ADD CONSTRAINT research_resource_item_pkey PRIMARY KEY (id);


--
-- Name: research_resource_org research_resource_org_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.research_resource_org
    ADD CONSTRAINT research_resource_org_pkey PRIMARY KEY (research_resource_id, org_id);


--
-- Name: research_resource research_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.research_resource
    ADD CONSTRAINT research_resource_pkey PRIMARY KEY (id);


--
-- Name: researcher_url researcher_url_orcid_client_source_unique_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.researcher_url
    ADD CONSTRAINT researcher_url_orcid_client_source_unique_key UNIQUE (url, orcid, client_source_id);


--
-- Name: researcher_url researcher_url_orcid_source_unique_key; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.researcher_url
    ADD CONSTRAINT researcher_url_orcid_source_unique_key UNIQUE (url, orcid, source_id);


--
-- Name: researcher_url researcher_url_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.researcher_url
    ADD CONSTRAINT researcher_url_pkey PRIMARY KEY (id);


--
-- Name: salesforce_connection salesforce_connection_orcid_salesforce_account_id_unique; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.salesforce_connection
    ADD CONSTRAINT salesforce_connection_orcid_salesforce_account_id_unique UNIQUE (orcid, salesforce_account_id);


--
-- Name: salesforce_connection salesforce_connection_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.salesforce_connection
    ADD CONSTRAINT salesforce_connection_pkey PRIMARY KEY (id);


--
-- Name: security_question security_question_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.security_question
    ADD CONSTRAINT security_question_pkey PRIMARY KEY (id);


--
-- Name: shibboleth_account shibboleth_account_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.shibboleth_account
    ADD CONSTRAINT shibboleth_account_pkey PRIMARY KEY (id);


--
-- Name: shibboleth_account shibboleth_account_remote_user_idp_unique; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.shibboleth_account
    ADD CONSTRAINT shibboleth_account_remote_user_idp_unique UNIQUE (remote_user, shib_identity_provider);


--
-- Name: orcid_props statistic_key_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcid_props
    ADD CONSTRAINT statistic_key_pkey PRIMARY KEY (key);


--
-- Name: subject subject_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (name);


--
-- Name: external_identifier unique_external_identifiers_allowing_multiple_sources; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.external_identifier
    ADD CONSTRAINT unique_external_identifiers_allowing_multiple_sources UNIQUE (orcid, external_id_reference, external_id_type, source_id, client_source_id);


--
-- Name: oauth2_token_detail unique_token_value; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_token_detail
    ADD CONSTRAINT unique_token_value UNIQUE (token_value);


--
-- Name: userconnection userconnection_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.userconnection
    ADD CONSTRAINT userconnection_pkey PRIMARY KEY (userid, providerid, provideruserid);


--
-- Name: validated_public_profile validated_public_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.validated_public_profile
    ADD CONSTRAINT validated_public_profile_pkey PRIMARY KEY (orcid);


--
-- Name: webhook webhook_pk; Type: CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.webhook
    ADD CONSTRAINT webhook_pk PRIMARY KEY (orcid, uri);


--
-- Name: work work_pkey; Type: CONSTRAINT; Schema: public; Owner: orcid
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
-- Name: client_details_group_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX client_details_group_orcid_idx ON public.client_details USING btree (group_orcid);


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
-- Name: email_frequency_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX email_frequency_orcid_index ON public.email_frequency USING btree (orcid);


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
-- Name: oauth2_token_detail_authorization_code_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX oauth2_token_detail_authorization_code_idx ON public.oauth2_token_detail USING btree (authorization_code);


--
-- Name: oauth2_token_detail_obo_client_details_id_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX oauth2_token_detail_obo_client_details_id_index ON public.oauth2_token_detail USING btree (obo_client_details_id);


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
-- Name: org_disambiguated_external_identifier_org_disambiguated_id_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX org_disambiguated_external_identifier_org_disambiguated_id_idx ON public.org_disambiguated_external_identifier USING btree (org_disambiguated_id);


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
-- Name: rejected_grouping_suggestion_orcid_idx; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX rejected_grouping_suggestion_orcid_idx ON public.rejected_grouping_suggestion USING btree (orcid);


--
-- Name: research_resource_item_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX research_resource_item_index ON public.research_resource_item USING btree (research_resource_id);


--
-- Name: research_resource_orcid_index; Type: INDEX; Schema: public; Owner: orcid
--

CREATE INDEX research_resource_orcid_index ON public.research_resource USING btree (orcid);


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
-- Name: address address_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: address address_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: address address_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_source_id_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: biography biography_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.biography
    ADD CONSTRAINT biography_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: client_authorised_grant_type client_details_authorised_grant_type_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_authorised_grant_type
    ADD CONSTRAINT client_details_authorised_grant_type_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_granted_authority client_details_client_granted_authority_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_granted_authority
    ADD CONSTRAINT client_details_client_granted_authority_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_details client_details_group_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_details
    ADD CONSTRAINT client_details_group_orcid_fk FOREIGN KEY (group_orcid) REFERENCES public.profile(orcid);


--
-- Name: client_redirect_uri client_redirect_uri_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_redirect_uri
    ADD CONSTRAINT client_redirect_uri_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_resource_id client_resource_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_resource_id
    ADD CONSTRAINT client_resource_id_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_scope client_scope_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT client_scope_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: client_secret client_secret_client_details_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.client_secret
    ADD CONSTRAINT client_secret_client_details_id_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id);


--
-- Name: email email_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT email_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: email_frequency email_frequency_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.email_frequency
    ADD CONSTRAINT email_frequency_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: email email_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT email_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: email email_source_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT email_source_orcid_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: external_identifier external_identifier_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.external_identifier
    ADD CONSTRAINT external_identifier_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: external_identifier external_identifier_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.external_identifier
    ADD CONSTRAINT external_identifier_source_id_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: find_my_stuff_history find_my_stuff_history_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.find_my_stuff_history
    ADD CONSTRAINT find_my_stuff_history_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: profile_subject fk1d5ccc962d6b1fe4; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_subject
    ADD CONSTRAINT fk1d5ccc962d6b1fe4 FOREIGN KEY (subjects_name) REFERENCES public.subject(name);


--
-- Name: profile_subject fk1d5ccc9680ddc983; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_subject
    ADD CONSTRAINT fk1d5ccc9680ddc983 FOREIGN KEY (profile_orcid) REFERENCES public.profile(orcid);


--
-- Name: institution fk3529a5b8e84caef; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.institution
    ADD CONSTRAINT fk3529a5b8e84caef FOREIGN KEY (address_id) REFERENCES public.address(id);


--
-- Name: affiliation fk408de65b2007f99; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.affiliation
    ADD CONSTRAINT fk408de65b2007f99 FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: affiliation fk408de65cf1a386f; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.affiliation
    ADD CONSTRAINT fk408de65cf1a386f FOREIGN KEY (institution_id) REFERENCES public.institution(id);


--
-- Name: profile_keyword fk5c27955380ddc983; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_keyword
    ADD CONSTRAINT fk5c27955380ddc983 FOREIGN KEY (profile_orcid) REFERENCES public.profile(orcid);


--
-- Name: external_identifier fk641fe19db2007f99; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.external_identifier
    ADD CONSTRAINT fk641fe19db2007f99 FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: researcher_url fkd433c438b2007f99; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.researcher_url
    ADD CONSTRAINT fkd433c438b2007f99 FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: profile fked8e89a96b6f57ec; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT fked8e89a96b6f57ec FOREIGN KEY (security_question_id) REFERENCES public.security_question(id);


--
-- Name: profile fked8e89a9d6bc0bfe; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT fked8e89a9d6bc0bfe FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: other_name fkf5209e5ab2007f99; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.other_name
    ADD CONSTRAINT fkf5209e5ab2007f99 FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: funding_external_identifier funding_external_identifiers_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.funding_external_identifier
    ADD CONSTRAINT funding_external_identifiers_fk FOREIGN KEY (profile_funding_id) REFERENCES public.profile_funding(id);


--
-- Name: funding_subtype_to_index funding_subtype_to_index_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.funding_subtype_to_index
    ADD CONSTRAINT funding_subtype_to_index_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: given_permission_to giver_orcid_to_profile_orcid; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.given_permission_to
    ADD CONSTRAINT giver_orcid_to_profile_orcid FOREIGN KEY (giver_orcid) REFERENCES public.profile(orcid);


--
-- Name: identity_provider_name identity_provider_name_identity_provider_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.identity_provider_name
    ADD CONSTRAINT identity_provider_name_identity_provider_id_fk FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(id);


--
-- Name: profile_keyword keyword_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_keyword
    ADD CONSTRAINT keyword_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: profile_keyword keyword_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_keyword
    ADD CONSTRAINT keyword_source_id_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: custom_email member_custom_email_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.custom_email
    ADD CONSTRAINT member_custom_email_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id);


--
-- Name: notification_item notification_activity_notification_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification_item
    ADD CONSTRAINT notification_activity_notification_fk FOREIGN KEY (notification_id) REFERENCES public.notification(id);


--
-- Name: notification notification_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: notification notification_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: notification notification_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_source_id_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: notification_work notification_work; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification_work
    ADD CONSTRAINT notification_work FOREIGN KEY (work_id) REFERENCES public.work(work_id);


--
-- Name: notification_work notification_work_notification_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.notification_work
    ADD CONSTRAINT notification_work_notification_id_fk FOREIGN KEY (notification_id) REFERENCES public.notification(id);


--
-- Name: oauth2_authoriziation_code_detail oauth2_authoriziation_code_detail_client_details_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_authoriziation_code_detail
    ADD CONSTRAINT oauth2_authoriziation_code_detail_client_details_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id) ON DELETE CASCADE;


--
-- Name: oauth2_authoriziation_code_detail oauth2_authoriziation_code_detail_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_authoriziation_code_detail
    ADD CONSTRAINT oauth2_authoriziation_code_detail_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid) ON DELETE CASCADE;


--
-- Name: oauth2_token_detail oauth2_token_detail_client_details_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_token_detail
    ADD CONSTRAINT oauth2_token_detail_client_details_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id);


--
-- Name: oauth2_token_detail oauth2_token_detail_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_token_detail
    ADD CONSTRAINT oauth2_token_detail_orcid_fk FOREIGN KEY (user_orcid) REFERENCES public.profile(orcid);


--
-- Name: orcidoauth2authoriziationcodedetail_authorities oauth2authoriziationcodedetail_authorities_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcidoauth2authoriziationcodedetail_authorities
    ADD CONSTRAINT oauth2authoriziationcodedetail_authorities_fk FOREIGN KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value) REFERENCES public.oauth2_authoriziation_code_detail(authoriziation_code_value) ON DELETE CASCADE;


--
-- Name: orcidoauth2authoriziationcodedetail_resourceids oauth2authoriziationcodedetail_resourceids_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcidoauth2authoriziationcodedetail_resourceids
    ADD CONSTRAINT oauth2authoriziationcodedetail_resourceids_fk FOREIGN KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value) REFERENCES public.oauth2_authoriziation_code_detail(authoriziation_code_value) ON DELETE CASCADE;


--
-- Name: orcidoauth2authoriziationcodedetail_scopes oauth2authoriziationcodedetail_scopes_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcidoauth2authoriziationcodedetail_scopes
    ADD CONSTRAINT oauth2authoriziationcodedetail_scopes_fk FOREIGN KEY (orcidoauth2authoriziationcodedetail_authoriziation_code_value) REFERENCES public.oauth2_authoriziation_code_detail(authoriziation_code_value) ON DELETE CASCADE;


--
-- Name: oauth2_token_detail obo_client_details_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.oauth2_token_detail
    ADD CONSTRAINT obo_client_details_id_fk FOREIGN KEY (obo_client_details_id) REFERENCES public.client_details(client_details_id);


--
-- Name: orcid_social orcid_social_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.orcid_social
    ADD CONSTRAINT orcid_social_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: org_affiliation_relation org_affiliation_relation_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org_affiliation_relation
    ADD CONSTRAINT org_affiliation_relation_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: org_affiliation_relation org_affiliation_relation_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org_affiliation_relation
    ADD CONSTRAINT org_affiliation_relation_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: org_affiliation_relation org_affiliation_relation_org_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org_affiliation_relation
    ADD CONSTRAINT org_affiliation_relation_org_id_fk FOREIGN KEY (org_id) REFERENCES public.org(id);


--
-- Name: org org_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT org_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: org_disambiguated_external_identifier org_disambiguated_external_identifier_org_disambiguated_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org_disambiguated_external_identifier
    ADD CONSTRAINT org_disambiguated_external_identifier_org_disambiguated_fk FOREIGN KEY (org_disambiguated_id) REFERENCES public.org_disambiguated(id);


--
-- Name: org org_org_disambiguated_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT org_org_disambiguated_fk FOREIGN KEY (org_disambiguated_id) REFERENCES public.org_disambiguated(id);


--
-- Name: other_name other_name_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.other_name
    ADD CONSTRAINT other_name_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: other_name other_name_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.other_name
    ADD CONSTRAINT other_name_source_id_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: patent_contributor patent_contributor_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent_contributor
    ADD CONSTRAINT patent_contributor_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: patent_contributor patent_contributor_patent_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent_contributor
    ADD CONSTRAINT patent_contributor_patent_fk FOREIGN KEY (patent_id) REFERENCES public.patent(patent_id);


--
-- Name: patent_source patent_source_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent_source
    ADD CONSTRAINT patent_source_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: patent_source patent_source_patent_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent_source
    ADD CONSTRAINT patent_source_patent_fk FOREIGN KEY (patent_id) REFERENCES public.patent(patent_id);


--
-- Name: patent_source patent_source_source_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.patent_source
    ADD CONSTRAINT patent_source_source_orcid_fk FOREIGN KEY (source_orcid) REFERENCES public.profile(orcid);


--
-- Name: peer_review peer_review_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.peer_review
    ADD CONSTRAINT peer_review_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: peer_review peer_review_org_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.peer_review
    ADD CONSTRAINT peer_review_org_id_fk FOREIGN KEY (org_id) REFERENCES public.org(id);


--
-- Name: profile profile_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: profile profile_deprecating_admin_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile
    ADD CONSTRAINT profile_deprecating_admin_fk FOREIGN KEY (deprecating_admin) REFERENCES public.profile(orcid);


--
-- Name: profile_event profile_event_orcid; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_event
    ADD CONSTRAINT profile_event_orcid FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: profile_funding profile_funding_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_funding
    ADD CONSTRAINT profile_funding_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: profile_funding profile_funding_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_funding
    ADD CONSTRAINT profile_funding_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: profile_funding profile_funding_org_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_funding
    ADD CONSTRAINT profile_funding_org_id_fk FOREIGN KEY (org_id) REFERENCES public.org(id);


--
-- Name: profile_patent profile_patent_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_patent
    ADD CONSTRAINT profile_patent_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: profile_patent profile_patent_patent_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.profile_patent
    ADD CONSTRAINT profile_patent_patent_fk FOREIGN KEY (patent_id) REFERENCES public.patent(patent_id);


--
-- Name: given_permission_to receiver_orcid_to_profile_orcid; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.given_permission_to
    ADD CONSTRAINT receiver_orcid_to_profile_orcid FOREIGN KEY (receiver_orcid) REFERENCES public.profile(orcid);


--
-- Name: record_name record_name_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.record_name
    ADD CONSTRAINT record_name_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: research_resource_item research_resource_item_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.research_resource_item
    ADD CONSTRAINT research_resource_item_fk FOREIGN KEY (research_resource_id) REFERENCES public.research_resource(id);


--
-- Name: research_resource_item_org research_resource_item_org_fk1; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.research_resource_item_org
    ADD CONSTRAINT research_resource_item_org_fk1 FOREIGN KEY (research_resource_item_id) REFERENCES public.research_resource_item(id);


--
-- Name: research_resource_item_org research_resource_item_org_fk2; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.research_resource_item_org
    ADD CONSTRAINT research_resource_item_org_fk2 FOREIGN KEY (org_id) REFERENCES public.org(id);


--
-- Name: research_resource research_resource_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.research_resource
    ADD CONSTRAINT research_resource_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: research_resource_org research_resource_org_fk1; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.research_resource_org
    ADD CONSTRAINT research_resource_org_fk1 FOREIGN KEY (research_resource_id) REFERENCES public.research_resource(id);


--
-- Name: research_resource_org research_resource_org_fk2; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.research_resource_org
    ADD CONSTRAINT research_resource_org_fk2 FOREIGN KEY (org_id) REFERENCES public.org(id);


--
-- Name: researcher_url researcher_url_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.researcher_url
    ADD CONSTRAINT researcher_url_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: researcher_url researcher_url_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.researcher_url
    ADD CONSTRAINT researcher_url_source_id_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: shibboleth_account shibboleth_account_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.shibboleth_account
    ADD CONSTRAINT shibboleth_account_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: webhook webhook_client_details_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.webhook
    ADD CONSTRAINT webhook_client_details_fk FOREIGN KEY (client_details_id) REFERENCES public.client_details(client_details_id);


--
-- Name: webhook webhook_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.webhook
    ADD CONSTRAINT webhook_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: work work_client_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.work
    ADD CONSTRAINT work_client_source_id_fk FOREIGN KEY (client_source_id) REFERENCES public.client_details(client_details_id);


--
-- Name: work work_orcid_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.work
    ADD CONSTRAINT work_orcid_fk FOREIGN KEY (orcid) REFERENCES public.profile(orcid);


--
-- Name: work work_source_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: orcid
--

ALTER TABLE ONLY public.work
    ADD CONSTRAINT work_source_id_fk FOREIGN KEY (source_id) REFERENCES public.profile(orcid);


--
-- Name: TABLE biography; Type: ACL; Schema: public; Owner: orcid
--

GRANT SELECT ON TABLE public.biography TO orcidro;


--
-- Name: TABLE email_frequency; Type: ACL; Schema: public; Owner: orcid
--

GRANT SELECT ON TABLE public.email_frequency TO orcidro;


--
-- Name: TABLE find_my_stuff_history; Type: ACL; Schema: public; Owner: orcid
--

GRANT SELECT ON TABLE public.find_my_stuff_history TO orcidro;


--
-- Name: TABLE group_id_record; Type: ACL; Schema: public; Owner: orcid
--

GRANT SELECT ON TABLE public.group_id_record TO orcidro;


--
-- Name: TABLE invalid_record_data_changes; Type: ACL; Schema: public; Owner: orcid
--

GRANT SELECT ON TABLE public.invalid_record_data_changes TO orcidro;


--
-- Name: TABLE member_chosen_org_disambiguated; Type: ACL; Schema: public; Owner: orcid
--

GRANT SELECT ON TABLE public.member_chosen_org_disambiguated TO orcidro;


--
-- Name: TABLE record_name; Type: ACL; Schema: public; Owner: orcid
--

GRANT SELECT ON TABLE public.record_name TO orcidro;


--
-- Name: TABLE rejected_grouping_suggestion; Type: ACL; Schema: public; Owner: orcid
--

GRANT SELECT ON TABLE public.rejected_grouping_suggestion TO orcidro;


--
-- Name: TABLE research_resource; Type: ACL; Schema: public; Owner: orcid
--

GRANT SELECT ON TABLE public.research_resource TO orcidro;


--
-- Name: TABLE research_resource_item; Type: ACL; Schema: public; Owner: orcid
--

GRANT SELECT ON TABLE public.research_resource_item TO orcidro;


--
-- Name: TABLE research_resource_item_org; Type: ACL; Schema: public; Owner: orcid
--

GRANT SELECT ON TABLE public.research_resource_item_org TO orcidro;


--
-- Name: TABLE research_resource_org; Type: ACL; Schema: public; Owner: orcid
--

GRANT SELECT ON TABLE public.research_resource_org TO orcidro;


--
-- Name: TABLE validated_public_profile; Type: ACL; Schema: public; Owner: orcid
--

GRANT SELECT ON TABLE public.validated_public_profile TO orcidro;


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Debian 10.4-2.pgdg90+1)
-- Dumped by pg_dump version 10.4 (Debian 10.4-2.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- PostgreSQL database dump complete
--

\connect statistics

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Debian 10.4-2.pgdg90+1)
-- Dumped by pg_dump version 10.4 (Debian 10.4-2.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4 (Debian 10.4-2.pgdg90+1)
-- Dumped by pg_dump version 10.4 (Debian 10.4-2.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

