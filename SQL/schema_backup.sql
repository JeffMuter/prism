--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-07-30 10:49:45

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 40983)
-- Name: schema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA schema;


ALTER SCHEMA schema OWNER TO postgres;

--
-- TOC entry 8 (class 2615 OID 40994)
-- Name: schema_name; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA schema_name;


ALTER SCHEMA schema_name OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 235 (class 1259 OID 57411)
-- Name: location_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.location_types (
    id integer NOT NULL,
    name character varying(50)
);


ALTER TABLE public.location_types OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 57410)
-- Name: location_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.location_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.location_types_id_seq OWNER TO postgres;

--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 234
-- Name: location_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.location_types_id_seq OWNED BY public.location_types.id;


--
-- TOC entry 237 (class 1259 OID 57435)
-- Name: location_types_tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.location_types_tasks (
    id integer NOT NULL,
    task_type_id integer,
    location_type_id integer
);


ALTER TABLE public.location_types_tasks OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 57434)
-- Name: location_types_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.location_types_tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.location_types_tasks_id_seq OWNER TO postgres;

--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 236
-- Name: location_types_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.location_types_tasks_id_seq OWNED BY public.location_types_tasks.id;


--
-- TOC entry 225 (class 1259 OID 25144)
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    default_accessible boolean DEFAULT true,
    location_type character varying(50) NOT NULL,
    longitude double precision NOT NULL,
    latitude double precision NOT NULL,
    name text,
    description text,
    art text
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 25143)
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locations_id_seq OWNER TO postgres;

--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 224
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- TOC entry 239 (class 1259 OID 57474)
-- Name: locations_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations_resources (
    id integer NOT NULL,
    location_id integer,
    resource_id integer
);


ALTER TABLE public.locations_resources OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 57473)
-- Name: locations_resources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locations_resources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locations_resources_id_seq OWNER TO postgres;

--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 238
-- Name: locations_resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locations_resources_id_seq OWNED BY public.locations_resources.id;


--
-- TOC entry 221 (class 1259 OID 25122)
-- Name: resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resources (
    id integer NOT NULL,
    name character varying(50)
);


ALTER TABLE public.resources OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 25121)
-- Name: resources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resources_id_seq OWNER TO postgres;

--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 220
-- Name: resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resources_id_seq OWNED BY public.resources.id;


--
-- TOC entry 231 (class 1259 OID 49188)
-- Name: task_types_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_types_resources (
    id integer NOT NULL,
    task_type_id integer,
    resource_id integer
);


ALTER TABLE public.task_types_resources OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 49187)
-- Name: task_type_resource_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_type_resource_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.task_type_resource_id_seq OWNER TO postgres;

--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 230
-- Name: task_type_resource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_type_resource_id_seq OWNED BY public.task_types_resources.id;


--
-- TOC entry 229 (class 1259 OID 49181)
-- Name: task_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.task_types (
    id integer NOT NULL,
    name character varying(50)
);


ALTER TABLE public.task_types OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 49180)
-- Name: task_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.task_types_id_seq OWNER TO postgres;

--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 228
-- Name: task_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.task_types_id_seq OWNED BY public.task_types.id;


--
-- TOC entry 227 (class 1259 OID 25154)
-- Name: users_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_locations (
    id integer NOT NULL,
    user_id integer NOT NULL,
    location_id integer NOT NULL,
    named character varying(100),
    worker_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.users_locations OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 25153)
-- Name: user_locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_locations_id_seq OWNER TO postgres;

--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 226
-- Name: user_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_locations_id_seq OWNED BY public.users_locations.id;


--
-- TOC entry 219 (class 1259 OID 25112)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 25111)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 218
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 223 (class 1259 OID 25129)
-- Name: workers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workers (
    id integer NOT NULL,
    religion character varying(50),
    age integer NOT NULL,
    name character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    work_status boolean DEFAULT false,
    injured boolean DEFAULT false,
    strength integer NOT NULL,
    intelligence integer NOT NULL,
    faith integer NOT NULL,
    user_locations_id integer NOT NULL,
    travel_speed integer DEFAULT 0 NOT NULL,
    work_speed integer DEFAULT 0 NOT NULL,
    stamina integer DEFAULT 0 NOT NULL,
    max_stamina integer DEFAULT 10 NOT NULL
);


ALTER TABLE public.workers OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 25128)
-- Name: workers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.workers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workers_id_seq OWNER TO postgres;

--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 222
-- Name: workers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.workers_id_seq OWNED BY public.workers.id;


--
-- TOC entry 233 (class 1259 OID 57375)
-- Name: workers_tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workers_tasks (
    id integer NOT NULL,
    task_type_id integer,
    location_id integer,
    worker_id integer,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    start_longitude double precision,
    start_latitude double precision,
    end_longitude double precision,
    end_latitude double precision,
    is_ongoing boolean
);


ALTER TABLE public.workers_tasks OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 57374)
-- Name: workers_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.workers_tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workers_tasks_id_seq OWNER TO postgres;

--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 232
-- Name: workers_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.workers_tasks_id_seq OWNED BY public.workers_tasks.id;


--
-- TOC entry 4705 (class 2604 OID 57414)
-- Name: location_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_types ALTER COLUMN id SET DEFAULT nextval('public.location_types_id_seq'::regclass);


--
-- TOC entry 4706 (class 2604 OID 57438)
-- Name: location_types_tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_types_tasks ALTER COLUMN id SET DEFAULT nextval('public.location_types_tasks_id_seq'::regclass);


--
-- TOC entry 4698 (class 2604 OID 25147)
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- TOC entry 4707 (class 2604 OID 57477)
-- Name: locations_resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations_resources ALTER COLUMN id SET DEFAULT nextval('public.locations_resources_id_seq'::regclass);


--
-- TOC entry 4689 (class 2604 OID 25125)
-- Name: resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources ALTER COLUMN id SET DEFAULT nextval('public.resources_id_seq'::regclass);


--
-- TOC entry 4702 (class 2604 OID 49184)
-- Name: task_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_types ALTER COLUMN id SET DEFAULT nextval('public.task_types_id_seq'::regclass);


--
-- TOC entry 4703 (class 2604 OID 49191)
-- Name: task_types_resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_types_resources ALTER COLUMN id SET DEFAULT nextval('public.task_type_resource_id_seq'::regclass);


--
-- TOC entry 4687 (class 2604 OID 25115)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4700 (class 2604 OID 25157)
-- Name: users_locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_locations ALTER COLUMN id SET DEFAULT nextval('public.user_locations_id_seq'::regclass);


--
-- TOC entry 4690 (class 2604 OID 25132)
-- Name: workers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workers ALTER COLUMN id SET DEFAULT nextval('public.workers_id_seq'::regclass);


--
-- TOC entry 4704 (class 2604 OID 57378)
-- Name: workers_tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workers_tasks ALTER COLUMN id SET DEFAULT nextval('public.workers_tasks_id_seq'::regclass);


--
-- TOC entry 4727 (class 2606 OID 57416)
-- Name: location_types location_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_types
    ADD CONSTRAINT location_types_pkey PRIMARY KEY (id);


--
-- TOC entry 4729 (class 2606 OID 57440)
-- Name: location_types_tasks location_types_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_types_tasks
    ADD CONSTRAINT location_types_tasks_pkey PRIMARY KEY (id);


--
-- TOC entry 4717 (class 2606 OID 25152)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- TOC entry 4731 (class 2606 OID 57479)
-- Name: locations_resources locations_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations_resources
    ADD CONSTRAINT locations_resources_pkey PRIMARY KEY (id);


--
-- TOC entry 4713 (class 2606 OID 25127)
-- Name: resources resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- TOC entry 4723 (class 2606 OID 49193)
-- Name: task_types_resources task_type_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_types_resources
    ADD CONSTRAINT task_type_resource_pkey PRIMARY KEY (id);


--
-- TOC entry 4721 (class 2606 OID 49186)
-- Name: task_types task_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_types
    ADD CONSTRAINT task_types_pkey PRIMARY KEY (id);


--
-- TOC entry 4719 (class 2606 OID 25159)
-- Name: users_locations user_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_locations
    ADD CONSTRAINT user_locations_pkey PRIMARY KEY (id);


--
-- TOC entry 4709 (class 2606 OID 25120)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4711 (class 2606 OID 25118)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4715 (class 2606 OID 25137)
-- Name: workers workers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workers
    ADD CONSTRAINT workers_pkey PRIMARY KEY (id);


--
-- TOC entry 4725 (class 2606 OID 57380)
-- Name: workers_tasks workers_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workers_tasks
    ADD CONSTRAINT workers_tasks_pkey PRIMARY KEY (id);


--
-- TOC entry 4740 (class 2606 OID 57451)
-- Name: location_types_tasks location_types_tasks_location_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_types_tasks
    ADD CONSTRAINT location_types_tasks_location_type_id_fkey FOREIGN KEY (location_type_id) REFERENCES public.location_types(id);


--
-- TOC entry 4741 (class 2606 OID 57441)
-- Name: location_types_tasks location_types_tasks_task_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.location_types_tasks
    ADD CONSTRAINT location_types_tasks_task_type_id_fkey FOREIGN KEY (task_type_id) REFERENCES public.location_types(id);


--
-- TOC entry 4742 (class 2606 OID 57480)
-- Name: locations_resources locations_resources_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations_resources
    ADD CONSTRAINT locations_resources_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- TOC entry 4743 (class 2606 OID 57485)
-- Name: locations_resources locations_resources_resource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations_resources
    ADD CONSTRAINT locations_resources_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- TOC entry 4735 (class 2606 OID 49199)
-- Name: task_types_resources task_type_resource_resource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_types_resources
    ADD CONSTRAINT task_type_resource_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- TOC entry 4736 (class 2606 OID 49194)
-- Name: task_types_resources task_type_resource_task_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.task_types_resources
    ADD CONSTRAINT task_type_resource_task_type_id_fkey FOREIGN KEY (task_type_id) REFERENCES public.task_types(id);


--
-- TOC entry 4733 (class 2606 OID 25165)
-- Name: users_locations user_locations_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_locations
    ADD CONSTRAINT user_locations_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- TOC entry 4734 (class 2606 OID 25160)
-- Name: users_locations user_locations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_locations
    ADD CONSTRAINT user_locations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4737 (class 2606 OID 57386)
-- Name: workers_tasks workers_tasks_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workers_tasks
    ADD CONSTRAINT workers_tasks_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- TOC entry 4738 (class 2606 OID 57381)
-- Name: workers_tasks workers_tasks_task_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workers_tasks
    ADD CONSTRAINT workers_tasks_task_type_id_fkey FOREIGN KEY (task_type_id) REFERENCES public.task_types(id);


--
-- TOC entry 4739 (class 2606 OID 57391)
-- Name: workers_tasks workers_tasks_worker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workers_tasks
    ADD CONSTRAINT workers_tasks_worker_id_fkey FOREIGN KEY (worker_id) REFERENCES public.workers(id);


--
-- TOC entry 4732 (class 2606 OID 40989)
-- Name: workers workers_user_locations_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workers
    ADD CONSTRAINT workers_user_locations_id_fkey FOREIGN KEY (user_locations_id) REFERENCES public.users_locations(id);


-- Completed on 2024-07-30 10:49:45

--
-- PostgreSQL database dump complete
--

