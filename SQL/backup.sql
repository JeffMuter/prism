--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-07-02 16:51:00

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
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 229 (class 1259 OID 24906)
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id integer NOT NULL,
    event_name character varying(255) NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    eventtime timestamp without time zone NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.events OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24905)
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.events_id_seq OWNER TO postgres;

--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 228
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- TOC entry 227 (class 1259 OID 24893)
-- Name: global_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.global_locations (
    id integer NOT NULL,
    location_id integer NOT NULL,
    available_on_start boolean DEFAULT false
);


ALTER TABLE public.global_locations OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24892)
-- Name: global_locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.global_locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.global_locations_id_seq OWNER TO postgres;

--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 226
-- Name: global_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.global_locations_id_seq OWNED BY public.global_locations.id;


--
-- TOC entry 223 (class 1259 OID 24865)
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    location_type character varying(50) NOT NULL,
    longitude double precision NOT NULL,
    latitude double precision NOT NULL,
    name text,
    description text,
    art text
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24864)
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
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 222
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- TOC entry 235 (class 1259 OID 24954)
-- Name: node_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.node_resources (
    id integer NOT NULL,
    locations_id integer NOT NULL,
    resource_id integer NOT NULL
);


ALTER TABLE public.node_resources OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 24953)
-- Name: node_resources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.node_resources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.node_resources_id_seq OWNER TO postgres;

--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 234
-- Name: node_resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.node_resources_id_seq OWNED BY public.node_resources.id;


--
-- TOC entry 219 (class 1259 OID 24843)
-- Name: resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resources (
    id integer NOT NULL,
    name character varying(50)
);


ALTER TABLE public.resources OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24842)
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
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 218
-- Name: resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resources_id_seq OWNED BY public.resources.id;


--
-- TOC entry 225 (class 1259 OID 24874)
-- Name: user_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_locations (
    id integer NOT NULL,
    user_id integer NOT NULL,
    location_id integer NOT NULL,
    is_global boolean DEFAULT false,
    visible boolean DEFAULT false
);


ALTER TABLE public.user_locations OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24873)
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
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 224
-- Name: user_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_locations_id_seq OWNED BY public.user_locations.id;


--
-- TOC entry 217 (class 1259 OID 24833)
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
-- TOC entry 216 (class 1259 OID 24832)
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
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 233 (class 1259 OID 24932)
-- Name: worker_activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.worker_activities (
    id integer NOT NULL,
    worker_id integer NOT NULL,
    start_location_id integer NOT NULL,
    end_location_id integer NOT NULL,
    type character varying(50) NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    start_latitude double precision NOT NULL,
    start_longitude double precision NOT NULL,
    destination_latitude double precision NOT NULL,
    destination_longitude double precision NOT NULL
);


ALTER TABLE public.worker_activities OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 24931)
-- Name: worker_activities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.worker_activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.worker_activities_id_seq OWNER TO postgres;

--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 232
-- Name: worker_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.worker_activities_id_seq OWNED BY public.worker_activities.id;


--
-- TOC entry 231 (class 1259 OID 24915)
-- Name: worker_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.worker_events (
    id integer NOT NULL,
    worker_id integer NOT NULL,
    event_id integer NOT NULL
);


ALTER TABLE public.worker_events OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 24914)
-- Name: worker_events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.worker_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.worker_events_id_seq OWNER TO postgres;

--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 230
-- Name: worker_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.worker_events_id_seq OWNED BY public.worker_events.id;


--
-- TOC entry 221 (class 1259 OID 24850)
-- Name: workers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workers (
    id integer NOT NULL,
    user_id integer NOT NULL,
    religion character varying(50),
    age integer NOT NULL,
    name character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    work_status boolean DEFAULT false,
    injured boolean DEFAULT false,
    strength integer NOT NULL,
    intelligence integer NOT NULL,
    faith integer NOT NULL
);


ALTER TABLE public.workers OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24849)
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
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 220
-- Name: workers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.workers_id_seq OWNED BY public.workers.id;


--
-- TOC entry 4693 (class 2604 OID 24909)
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- TOC entry 4691 (class 2604 OID 24896)
-- Name: global_locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_locations ALTER COLUMN id SET DEFAULT nextval('public.global_locations_id_seq'::regclass);


--
-- TOC entry 4687 (class 2604 OID 24868)
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- TOC entry 4696 (class 2604 OID 24957)
-- Name: node_resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node_resources ALTER COLUMN id SET DEFAULT nextval('public.node_resources_id_seq'::regclass);


--
-- TOC entry 4682 (class 2604 OID 24846)
-- Name: resources id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources ALTER COLUMN id SET DEFAULT nextval('public.resources_id_seq'::regclass);


--
-- TOC entry 4688 (class 2604 OID 24877)
-- Name: user_locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_locations ALTER COLUMN id SET DEFAULT nextval('public.user_locations_id_seq'::regclass);


--
-- TOC entry 4680 (class 2604 OID 24836)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4695 (class 2604 OID 24935)
-- Name: worker_activities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.worker_activities ALTER COLUMN id SET DEFAULT nextval('public.worker_activities_id_seq'::regclass);


--
-- TOC entry 4694 (class 2604 OID 24918)
-- Name: worker_events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.worker_events ALTER COLUMN id SET DEFAULT nextval('public.worker_events_id_seq'::regclass);


--
-- TOC entry 4683 (class 2604 OID 24853)
-- Name: workers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workers ALTER COLUMN id SET DEFAULT nextval('public.workers_id_seq'::regclass);


--
-- TOC entry 4886 (class 0 OID 24906)
-- Dependencies: 229
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (id, event_name, latitude, longitude, eventtime, description) FROM stdin;
\.


--
-- TOC entry 4884 (class 0 OID 24893)
-- Dependencies: 227
-- Data for Name: global_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.global_locations (id, location_id, available_on_start) FROM stdin;
\.


--
-- TOC entry 4880 (class 0 OID 24865)
-- Dependencies: 223
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locations (id, location_type, longitude, latitude, name, description, art) FROM stdin;
1	city	139.6922	35.6897	Tokyo	a large city in the distance... probably	city_art
2	city	106.8275	-6.175	Jakarta	a large city in the distance... probably	city_art
3	city	77.23	28.61	Delhi	a large city in the distance... probably	city_art
4	city	113.26	23.13	Guangzhou	a large city in the distance... probably	city_art
5	city	72.8775	19.0761	Mumbai	a large city in the distance... probably	city_art
6	city	120.9772	14.5958	Manila	a large city in the distance... probably	city_art
7	city	121.4747	31.2286	Shanghai	a large city in the distance... probably	city_art
8	city	-46.6333	-23.55	Sao Paulo	a large city in the distance... probably	city_art
9	city	126.99	37.56	Seoul	a large city in the distance... probably	city_art
10	city	-99.1333	19.4333	Mexico City	a large city in the distance... probably	city_art
11	city	31.2358	30.0444	Cairo	a large city in the distance... probably	city_art
12	city	-73.9249	40.6943	New York	a large city in the distance... probably	city_art
13	city	90.3889	23.7639	Dhaka	a large city in the distance... probably	city_art
14	city	116.3975	39.9067	Beijing	a large city in the distance... probably	city_art
15	city	88.37	22.5675	Kolkata	a large city in the distance... probably	city_art
16	city	100.4942	13.7525	Bangkok	a large city in the distance... probably	city_art
17	city	114.0596	22.5415	Shenzhen	a large city in the distance... probably	city_art
18	city	37.6172	55.7558	Moscow	a large city in the distance... probably	city_art
19	city	-58.3817	-34.6033	Buenos Aires	a large city in the distance... probably	city_art
20	city	3.3841	6.455	Lagos	a large city in the distance... probably	city_art
21	city	28.955	41.0136	Istanbul	a large city in the distance... probably	city_art
22	city	67.01	24.86	Karachi	a large city in the distance... probably	city_art
23	city	77.5917	12.9789	Bangalore	a large city in the distance... probably	city_art
24	city	106.7019	10.7756	Ho Chi Minh City	a large city in the distance... probably	city_art
25	city	135.5022	34.6939	Osaka	a large city in the distance... probably	city_art
26	city	104.0633	30.66	Chengdu	a large city in the distance... probably	city_art
27	city	51.3889	35.6892	Tehran	a large city in the distance... probably	city_art
28	city	15.3119	-4.3219	Kinshasa	a large city in the distance... probably	city_art
29	city	-43.2056	-22.9111	Rio de Janeiro	a large city in the distance... probably	city_art
30	city	80.275	13.0825	Chennai	a large city in the distance... probably	city_art
31	city	108.9422	34.2611	Xi'an	a large city in the distance... probably	city_art
32	city	74.3436	31.5497	Lahore	a large city in the distance... probably	city_art
33	city	106.5504	29.5637	Chongqing	a large city in the distance... probably	city_art
34	city	-118.4068	34.1141	Los Angeles	a large city in the distance... probably	city_art
35	city	115.464	38.874	Baoding	a large city in the distance... probably	city_art
36	city	-0.1275	51.5072	London	a large city in the distance... probably	city_art
37	city	2.3522	48.8567	Paris	a large city in the distance... probably	city_art
38	city	118.3564	35.1038	Linyi	a large city in the distance... probably	city_art
39	city	113.752	23.021	Dongguan	a large city in the distance... probably	city_art
40	city	78.4747	17.3617	Hyderabad	a large city in the distance... probably	city_art
41	city	117.2054	39.1336	Tianjin	a large city in the distance... probably	city_art
42	city	-77.0375	-12.06	Lima	a large city in the distance... probably	city_art
43	city	114.3046	30.5934	Wuhan	a large city in the distance... probably	city_art
44	city	112.5292	32.9987	Nanyang	a large city in the distance... probably	city_art
45	city	120.153	30.267	Hangzhou	a large city in the distance... probably	city_art
46	city	113.1216	23.0214	Foshan	a large city in the distance... probably	city_art
47	city	136.9	35.1833	Nagoya	a large city in the distance... probably	city_art
48	city	117.284	34.204	Tongshan	a large city in the distance... probably	city_art
49	city	13.2344	-8.8383	Luanda	a large city in the distance... probably	city_art
50	city	114.6418	33.625	Zhoukou	a large city in the distance... probably	city_art
51	city	114.933	25.831	Ganzhou	a large city in the distance... probably	city_art
52	city	101.6953	3.1478	Kuala Lumpur	a large city in the distance... probably	city_art
53	city	115.4796	35.2343	Heze	a large city in the distance... probably	city_art
54	city	118.6757	24.8744	Quanzhou	a large city in the distance... probably	city_art
55	city	28.0456	-26.2044	Johannesburg	a large city in the distance... probably	city_art
56	city	-87.6866	41.8375	Chicago	a large city in the distance... probably	city_art
57	city	118.7789	32.0608	Nanjing	a large city in the distance... probably	city_art
58	city	116.5871	35.4151	Jining	a large city in the distance... probably	city_art
59	city	105.85	21	Hanoi	a large city in the distance... probably	city_art
60	city	73.8567	18.5203	Pune	a large city in the distance... probably	city_art
61	city	115.814	32.89	Fuyang	a large city in the distance... probably	city_art
62	city	72.5714	23.0225	Ahmedabad	a large city in the distance... probably	city_art
63	city	-74.0722	4.7111	Bogota	a large city in the distance... probably	city_art
64	city	123.4281	41.8025	Shenyang	a large city in the distance... probably	city_art
65	city	39.2803	-6.8161	Dar es Salaam	a large city in the distance... probably	city_art
66	city	32.5	15.6	Khartoum	a large city in the distance... probably	city_art
67	city	115.656	34.415	Shangqiu	a large city in the distance... probably	city_art
68	city	114.2	22.3	Hong Kong	a large city in the distance... probably	city_art
69	city	116.8387	38.3047	Cangzhou	a large city in the distance... probably	city_art
70	city	46.7167	24.6333	Riyadh	a large city in the distance... probably	city_art
71	city	-70.6506	-33.4372	Santiago	a large city in the distance... probably	city_art
72	city	114.5048	37.0717	Xingtai	a large city in the distance... probably	city_art
73	city	114.022	33.014	Zhumadian	a large city in the distance... probably	city_art
74	city	91.8325	22.335	Chattogram	a large city in the distance... probably	city_art
75	city	112.7378	-7.2458	Surabaya	a large city in the distance... probably	city_art
76	city	110.3575	21.2701	Zhanjiang	a large city in the distance... probably	city_art
77	city	105.292	27.284	Bijie	a large city in the distance... probably	city_art
78	city	120.1626	33.3482	Yancheng	a large city in the distance... probably	city_art
79	city	112.572	26.894	Hengyang	a large city in the distance... probably	city_art
80	city	107.031	27.722	Zunyi	a large city in the distance... probably	city_art
81	city	111.4679	27.2395	Shaoyang	a large city in the distance... probably	city_art
82	city	72.8311	21.1702	Surat	a large city in the distance... probably	city_art
83	city	117.9431	28.4551	Shangrao	a large city in the distance... probably	city_art
84	city	114.091	32.149	Xinyang	a large city in the distance... probably	city_art
85	city	-3.7033	40.4169	Madrid	a large city in the distance... probably	city_art
86	city	44.3661	33.3153	Baghdad	a large city in the distance... probably	city_art
87	city	110.9255	21.6627	Maoming	a large city in the distance... probably	city_art
88	city	116.3727	23.551	Jieyang	a large city in the distance... probably	city_art
89	city	-80.2101	25.784	Miami	a large city in the distance... probably	city_art
90	city	103.8	1.3	Singapore	a large city in the distance... probably	city_art
91	city	-95.3885	29.786	Houston	a large city in the distance... probably	city_art
92	city	115.9852	36.4559	Liaocheng	a large city in the distance... probably	city_art
93	city	114.8724	30.4537	Huanggang	a large city in the distance... probably	city_art
94	city	121.6	38.9	Dalian	a large city in the distance... probably	city_art
95	city	-96.7667	32.7935	Dallas	a large city in the distance... probably	city_art
96	city	120.3827	36.0669	Qingdao	a large city in the distance... probably	city_art
97	city	110.181	22.654	Yulin	a large city in the distance... probably	city_art
98	city	9.7	4.05	Douala	a large city in the distance... probably	city_art
99	city	103.796	25.491	Qujing	a large city in the distance... probably	city_art
100	city	113.9268	35.3036	Nangandao	a large city in the distance... probably	city_art
101	city	-75.1339	40.0077	Philadelphia	a large city in the distance... probably	city_art
102	city	121.5064	31.2347	Pudong	a large city in the distance... probably	city_art
103	city	-79.3733	43.7417	Toronto	a large city in the distance... probably	city_art
104	city	113.684	34.764	Zhengzhou	a large city in the distance... probably	city_art
105	city	116.359	37.436	Dezhou	a large city in the distance... probably	city_art
106	city	106.1106	30.8372	Nanchong	a large city in the distance... probably	city_art
107	city	117.0207	36.6702	Jinan	a large city in the distance... probably	city_art
108	city	31.2118	29.987	Giza	a large city in the distance... probably	city_art
109	city	36.8172	-1.2864	Nairobi	a large city in the distance... probably	city_art
110	city	-103.3475	20.6767	Guadalajara	a large city in the distance... probably	city_art
111	city	32.85	39.93	Ankara	a large city in the distance... probably	city_art
112	city	117.087	36.202	Tai'an	a large city in the distance... probably	city_art
113	city	116.6835	39.5383	Langfang	a large city in the distance... probably	city_art
114	city	107.4678	31.2093	Dazhou	a large city in the distance... probably	city_art
115	city	30.3086	59.9375	Saint Petersburg	a large city in the distance... probably	city_art
116	city	-100.3	25.6667	Monterrey	a large city in the distance... probably	city_art
117	city	-43.9333	-19.9167	Belo Horizonte	a large city in the distance... probably	city_art
118	city	116.9683	33.6333	Suzhou	a large city in the distance... probably	city_art
119	city	111.613	26.42	Yongzhou	a large city in the distance... probably	city_art
120	city	111.699	29.031	Changde	a large city in the distance... probably	city_art
121	city	112.122	32.01	Xiangyang	a large city in the distance... probably	city_art
122	city	96.16	16.795	Rangoon	a large city in the distance... probably	city_art
123	city	-84.422	33.7628	Atlanta	a large city in the distance... probably	city_art
124	city	-77.0163	38.9047	Washington	a large city in the distance... probably	city_art
125	city	103.717	27.338	Zhaotong	a large city in the distance... probably	city_art
126	city	117.647	24.513	Zhangzhou	a large city in the distance... probably	city_art
127	city	144.9631	-37.8142	Melbourne	a large city in the distance... probably	city_art
128	city	114.417	27.816	Yichun	a large city in the distance... probably	city_art
129	city	115.7742	33.8626	Bozhou	a large city in the distance... probably	city_art
130	city	118.2831	33.9331	Suqian	a large city in the distance... probably	city_art
131	city	-4.0333	5.3167	Abidjan	a large city in the distance... probably	city_art
132	city	114.9668	27.0912	Ji'an	a large city in the distance... probably	city_art
133	city	110.296	25.275	Guilin	a large city in the distance... probably	city_art
134	city	113.2999	33.735	Pingdingshan	a large city in the distance... probably	city_art
135	city	13.405	52.52	Berlin	a large city in the distance... probably	city_art
136	city	29.8925	31.1975	Alexandria	a large city in the distance... probably	city_art
137	city	104.679	31.468	Mianyang	a large city in the distance... probably	city_art
138	city	151.21	-33.8678	Sydney	a large city in the distance... probably	city_art
139	city	114.345	34.795	Huanglongsi	a large city in the distance... probably	city_art
140	city	2.1769	41.3828	Barcelona	a large city in the distance... probably	city_art
141	city	111.007	35.0267	Yuncheng	a large city in the distance... probably	city_art
142	city	18.4239	-33.9253	Cape Town	a large city in the distance... probably	city_art
143	city	112.939	28.228	Changsha	a large city in the distance... probably	city_art
144	city	39.1728	21.5433	Jeddah	a large city in the distance... probably	city_art
145	city	109.471	34.5206	Weinan	a large city in the distance... probably	city_art
146	city	113.016	25.77	Chenzhou	a large city in the distance... probably	city_art
147	city	113.0815	22.5789	Jiangmen	a large city in the distance... probably	city_art
148	city	115.954	29.661	Jiujiang	a large city in the distance... probably	city_art
149	city	119.2214	34.5966	Xinpu	a large city in the distance... probably	city_art
150	city	104.643	28.752	Yibin	a large city in the distance... probably	city_art
151	city	110.0016	27.5698	Huaihua	a large city in the distance... probably	city_art
152	city	119.4363	32.3912	Yangzhou	a large city in the distance... probably	city_art
153	city	119.9229	32.4567	Taizhou	a large city in the distance... probably	city_art
154	city	102.7094	25.0464	Kunming	a large city in the distance... probably	city_art
155	city	112.356	28.5549	Yiyang	a large city in the distance... probably	city_art
156	city	125.326	43.897	Changchun	a large city in the distance... probably	city_art
157	city	116.52	31.736	Lu'an	a large city in the distance... probably	city_art
158	city	113.8201	34.0244	Jiangguanchi	a large city in the distance... probably	city_art
159	city	116.122	24.289	Meizhou	a large city in the distance... probably	city_art
160	city	87.6125	43.8225	Urumqi	a large city in the distance... probably	city_art
161	city	120.6194	31.3	Suzhou	a large city in the distance... probably	city_art
162	city	-71.0852	42.3188	Boston	a large city in the distance... probably	city_art
163	city	27.14	38.42	Izmir	a large city in the distance... probably	city_art
164	city	109.599	23.112	Guigang	a large city in the distance... probably	city_art
165	city	116.682	23.354	Shantou	a large city in the distance... probably	city_art
166	city	69.1783	34.5253	Kabul	a large city in the distance... probably	city_art
167	city	113.957	30.918	Xiaoganzhan	a large city in the distance... probably	city_art
168	city	-8.0028	12.6392	Bamako	a large city in the distance... probably	city_art
169	city	105.442	28.871	Luzhou	a large city in the distance... probably	city_art
170	city	117.2273	31.8206	Hefei	a large city in the distance... probably	city_art
171	city	115.669	37.739	Hengshui	a large city in the distance... probably	city_art
172	city	-38.5275	-3.7275	Fortaleza	a large city in the distance... probably	city_art
173	city	117.1153	30.5318	Anqing	a large city in the distance... probably	city_art
174	city	109.4281	24.3264	Liuzhou	a large city in the distance... probably	city_art
175	city	114.886	40.769	Zhangjiakou	a large city in the distance... probably	city_art
176	city	112.4667	23.05	Zhaoqing	a large city in the distance... probably	city_art
177	city	114.51	38.0425	Shijiazhuang	a large city in the distance... probably	city_art
178	city	121.6245	29.8603	Ningbo	a large city in the distance... probably	city_art
179	city	123.9182	47.3549	Qiqihar	a large city in the distance... probably	city_art
180	city	-112.0892	33.5722	Phoenix	a large city in the distance... probably	city_art
181	city	116.358	27.949	Fuzhou	a large city in the distance... probably	city_art
182	city	118.888	42.257	Chifeng	a large city in the distance... probably	city_art
183	city	111.287	30.692	Xiaoxita	a large city in the distance... probably	city_art
184	city	35.9328	31.9497	Amman	a large city in the distance... probably	city_art
185	city	118.333	32.256	Chuzhou	a large city in the distance... probably	city_art
186	city	111.519	36.088	Linfen	a large city in the distance... probably	city_art
187	city	113.056	23.682	Qingyuan	a large city in the distance... probably	city_art
188	city	108.7088	34.3299	Xianyang	a large city in the distance... probably	city_art
189	city	111.9944	27.6998	Loudi	a large city in the distance... probably	city_art
190	city	117.971	37.383	Binzhou	a large city in the distance... probably	city_art
191	city	113.133	27.829	Zhuzhou	a large city in the distance... probably	city_art
192	city	112.5497	37.8704	Taiyuan	a large city in the distance... probably	city_art
193	city	108.3275	22.8167	Nanning	a large city in the distance... probably	city_art
194	city	126.6409	45.7576	Harbin	a large city in the distance... probably	city_art
195	city	7.4833	9.0667	Abuja	a large city in the distance... probably	city_art
196	city	139.6381	35.4442	Yokohama	a large city in the distance... probably	city_art
197	city	126.969	46.654	Suihua	a large city in the distance... probably	city_art
198	city	117.3238	34.8109	Zaozhuang	a large city in the distance... probably	city_art
199	city	-83.1024	42.3834	Detroit	a large city in the distance... probably	city_art
200	city	118.0889	24.4796	Xiamen	a large city in the distance... probably	city_art
201	city	105.058	29.5802	Neijiang	a large city in the distance... probably	city_art
202	city	-73.5617	45.5089	Montreal	a large city in the distance... probably	city_art
203	city	119.2964	26.0743	Fuzhou	a large city in the distance... probably	city_art
204	city	106.619	23.903	Baicheng	a large city in the distance... probably	city_art
205	city	118.4331	31.3526	Wuhu	a large city in the distance... probably	city_art
206	city	109.7341	38.2858	Yulinshi	a large city in the distance... probably	city_art
207	city	98.6739	3.5894	Medan	a large city in the distance... probably	city_art
208	city	120.6993	27.9938	Wenzhou	a large city in the distance... probably	city_art
209	city	119.974	31.811	Changzhou	a large city in the distance... probably	city_art
210	city	115.0292	35.7627	Puyang	a large city in the distance... probably	city_art
211	city	113.2419	35.2157	Jiaozuo	a large city in the distance... probably	city_art
212	city	115.858	28.683	Nanchang	a large city in the distance... probably	city_art
213	city	-122.3244	47.6211	Seattle	a large city in the distance... probably	city_art
214	city	3.9167	7.3964	Ibadan	a large city in the distance... probably	city_art
215	city	-7.5833	33.5333	Casablanca	a large city in the distance... probably	city_art
216	city	-1.625	6.7	Kumasi	a large city in the distance... probably	city_art
217	city	104.398	31.127	Deyang	a large city in the distance... probably	city_art
218	city	129.075	35.18	Busan	a large city in the distance... probably	city_art
219	city	111.749	40.842	Hohhot	a large city in the distance... probably	city_art
220	city	108.085	24.693	Hechi	a large city in the distance... probably	city_art
221	city	3.0589	36.7539	Algiers	a large city in the distance... probably	city_art
222	city	118.1739	39.6294	Tangshan	a large city in the distance... probably	city_art
223	city	110.7987	32.629	Shiyan	a large city in the distance... probably	city_art
224	city	80.95	26.85	Lucknow	a large city in the distance... probably	city_art
225	city	59.5433	36.3264	Mashhad	a large city in the distance... probably	city_art
226	city	-122.4449	37.7558	San Francisco	a large city in the distance... probably	city_art
227	city	-1.4028	6.6944	Boankra	a large city in the distance... probably	city_art
228	city	55.2972	25.2631	Dubai	a large city in the distance... probably	city_art
229	city	122.994	41.108	Anshan	a large city in the distance... probably	city_art
230	city	107.238	34.363	Baojishi	a large city in the distance... probably	city_art
231	city	108.654	21.981	Qinzhou	a large city in the distance... probably	city_art
232	city	106.63	26.647	Guiyang	a large city in the distance... probably	city_art
233	city	117.389	32.917	Bengbu	a large city in the distance... probably	city_art
234	city	106.748	31.868	Bazhou	a large city in the distance... probably	city_art
235	city	105.593	30.533	Suining	a large city in the distance... probably	city_art
236	city	120.312	31.491	Wuxi	a large city in the distance... probably	city_art
237	city	73.75	32.5833	Kotla Qasim Khan	a large city in the distance... probably	city_art
238	city	107.0232	33.0664	Hanzhong	a large city in the distance... probably	city_art
239	city	119.0078	25.4526	Putian	a large city in the distance... probably	city_art
240	city	119.424	32.188	Zhenjiang	a large city in the distance... probably	city_art
241	city	106.6326	30.4564	Guang'an	a large city in the distance... probably	city_art
242	city	73.0911	31.4167	Faisalabad	a large city in the distance... probably	city_art
243	city	113.117	36.195	Changzhi	a large city in the distance... probably	city_art
244	city	109.1895	27.7316	Tongren	a large city in the distance... probably	city_art
245	city	103.766	29.552	Leshan	a large city in the distance... probably	city_art
246	city	-63.1975	-17.7892	Santa Cruz de la Sierra	a large city in the distance... probably	city_art
247	city	119.5202	39.8882	Qinhuangdao	a large city in the distance... probably	city_art
248	city	75.8	26.9	Jaipur	a large city in the distance... probably	city_art
249	city	112.734	38.416	Xinzhou	a large city in the distance... probably	city_art
250	city	103.8268	36.0606	Lanzhou	a large city in the distance... probably	city_art
251	city	111.279	23.4767	Wuzhou	a large city in the distance... probably	city_art
252	city	23.7281	37.9842	Athens	a large city in the distance... probably	city_art
253	city	-117.1222	32.8313	San Diego	a large city in the distance... probably	city_art
254	city	38.74	9.03	Addis Ababa	a large city in the distance... probably	city_art
255	city	120.6794	24.1439	Taichung	a large city in the distance... probably	city_art
256	city	117.0194	32.6314	Huainan	a large city in the distance... probably	city_art
257	city	-90.5353	14.6133	Guatemala City	a large city in the distance... probably	city_art
258	city	47.9783	29.3697	Kuwait City	a large city in the distance... probably	city_art
259	city	19.0514	47.4925	Budapest	a large city in the distance... probably	city_art
260	city	105.7311	34.5809	Qincheng	a large city in the distance... probably	city_art
261	city	119.527	35.417	Rizhao	a large city in the distance... probably	city_art
262	city	121.0475	14.65	Quezon City	a large city in the distance... probably	city_art
263	city	44.2064	15.3483	Sanaa	a large city in the distance... probably	city_art
264	city	69.2797	41.3111	Tashkent	a large city in the distance... probably	city_art
265	city	30.5233	50.45	Kyiv	a large city in the distance... probably	city_art
266	city	103.8484	30.0771	Meishan	a large city in the distance... probably	city_art
267	city	126.6333	37.4833	Incheon	a large city in the distance... probably	city_art
268	city	-1.9025	52.48	Birmingham	a large city in the distance... probably	city_art
269	city	119.5477	26.6662	Ningde	a large city in the distance... probably	city_art
270	city	113.3925	22.517	Zhongshan	a large city in the distance... probably	city_art
271	city	122.1205	37.5133	Weihai	a large city in the distance... probably	city_art
272	city	29.05	40.1833	Bursa	a large city in the distance... probably	city_art
273	city	-93.2678	44.9635	Minneapolis	a large city in the distance... probably	city_art
274	city	23.6	-6.15	Mbuji-Mayi	a large city in the distance... probably	city_art
275	city	110.3488	20.0186	Haikou	a large city in the distance... probably	city_art
276	city	122.243	43.654	Tongliao	a large city in the distance... probably	city_art
277	city	120.453	41.571	Chaoyang	a large city in the distance... probably	city_art
278	city	-68.1333	-16.4958	La Paz	a large city in the distance... probably	city_art
279	city	125.7475	39.0167	Pyongyang	a large city in the distance... probably	city_art
280	city	-82.4447	27.9945	Tampa	a large city in the distance... probably	city_art
281	city	113.597	24.811	Shaoguan	a large city in the distance... probably	city_art
282	city	114.7002	23.7443	Heyuan	a large city in the distance... probably	city_art
283	city	-47.8828	-15.7939	Brasilia	a large city in the distance... probably	city_art
284	city	32.4833	15.65	Omdurman	a large city in the distance... probably	city_art
285	city	112.62	-7.98	Malang	a large city in the distance... probably	city_art
286	city	9.18	48.7775	Stuttgart	a large city in the distance... probably	city_art
287	city	125.104	46.589	Daqing	a large city in the distance... probably	city_art
288	city	12.4828	41.8933	Rome	a large city in the distance... probably	city_art
289	city	-73.9496	40.6501	Brooklyn	a large city in the distance... probably	city_art
290	city	120.2975	22.615	Kaohsiung	a large city in the distance... probably	city_art
291	city	112.9454	27.8313	Xiangtan	a large city in the distance... probably	city_art
292	city	117.017	25.076	Longyan	a large city in the distance... probably	city_art
293	city	109.9532	40.6213	Baotou	a large city in the distance... probably	city_art
294	city	114.487	36.601	Handan	a large city in the distance... probably	city_art
295	city	121.148	41.129	Jinzhou	a large city in the distance... probably	city_art
296	city	80.3319	26.4499	Kanpur	a large city in the distance... probably	city_art
297	city	-104.8758	39.762	Denver	a large city in the distance... probably	city_art
298	city	118.1774	26.6418	Nanping	a large city in the distance... probably	city_art
299	city	90.375	23.9889	Gazipura	a large city in the distance... probably	city_art
300	city	115.3756	22.7872	Shanwei	a large city in the distance... probably	city_art
301	city	116.622	23.658	Chaozhou	a large city in the distance... probably	city_art
302	city	-79.8875	-2.19	Guayaquil	a large city in the distance... probably	city_art
303	city	119.162	36.708	Weifang	a large city in the distance... probably	city_art
304	city	119.113	33.551	Huai'an	a large city in the distance... probably	city_art
305	city	118.055	36.8138	Zibo	a large city in the distance... probably	city_art
306	city	109.029	32.6854	Ankang	a large city in the distance... probably	city_art
307	city	45.3419	2.0392	Mogadishu	a large city in the distance... probably	city_art
308	city	11.575	48.1375	Munich	a large city in the distance... probably	city_art
309	city	119.298	26.0865	Gulou	a large city in the distance... probably	city_art
310	city	121.5625	25.0375	Taipei	a large city in the distance... probably	city_art
311	city	106.9923	-6.2349	Bekasi	a large city in the distance... probably	city_art
312	city	36.2919	33.5131	Damascus	a large city in the distance... probably	city_art
313	city	117.6389	26.2634	Sanming	a large city in the distance... probably	city_art
314	city	111.983	21.857	Yangjiang	a large city in the distance... probably	city_art
315	city	130.319	46.8	Jiamusi	a large city in the distance... probably	city_art
316	city	114.0109	33.583	Luohe	a large city in the distance... probably	city_art
317	city	-75.5906	6.2308	Medellin	a large city in the distance... probably	city_art
318	city	104.592	35.608	Dingxi	a large city in the distance... probably	city_art
319	city	120.5833	30.0511	Shaoxing	a large city in the distance... probably	city_art
320	city	121.4478	37.4646	Yantai	a large city in the distance... probably	city_art
321	city	114.416	23.112	Huizhou	a large city in the distance... probably	city_art
322	city	119.923	28.468	Lishui	a large city in the distance... probably	city_art
323	city	118.759	30.939	Xuanzhou	a large city in the distance... probably	city_art
324	city	49.6872	36.205	Khowrhesht	a large city in the distance... probably	city_art
325	city	82.569	25.146	Mirzapur	a large city in the distance... probably	city_art
326	city	104.779	29.339	Zigong	a large city in the distance... probably	city_art
327	city	10	53.55	Hamburg	a large city in the distance... probably	city_art
328	city	105.844	32.436	Guangyuan	a large city in the distance... probably	city_art
329	city	-76.5222	3.4206	Cali	a large city in the distance... probably	city_art
330	city	115.039	30.2011	Huangshi	a large city in the distance... probably	city_art
331	city	101.7804	36.6224	Xining	a large city in the distance... probably	city_art
332	city	28.2833	-15.4167	Lusaka	a large city in the distance... probably	city_art
333	city	-1.5275	12.3686	Ouagadougou	a large city in the distance... probably	city_art
334	city	11.5167	3.8667	Yaounde	a large city in the distance... probably	city_art
335	city	113.5769	22.2716	Zhuhai	a large city in the distance... probably	city_art
336	city	120.837	40.711	Huludao	a large city in the distance... probably	city_art
337	city	99.161	25.112	Baoshan	a large city in the distance... probably	city_art
338	city	39.8233	21.4225	Mecca	a large city in the distance... probably	city_art
339	city	-123.1	49.25	Vancouver	a large city in the distance... probably	city_art
340	city	120.828	40.7523	Lianshan	a large city in the distance... probably	city_art
341	city	35.5057	33.8983	Beirut	a large city in the distance... probably	city_art
342	city	-38.4767	-12.9747	Salvador	a large city in the distance... probably	city_art
343	city	26.1039	44.4325	Bucharest	a large city in the distance... probably	city_art
344	city	104.9603	33.3702	Longba	a large city in the distance... probably	city_art
345	city	79.0806	21.1497	Nagpur	a large city in the distance... probably	city_art
346	city	-73.7976	40.7498	Queens	a large city in the distance... probably	city_art
347	city	126.5481	43.8519	Jilin	a large city in the distance... probably	city_art
348	city	123.726	42.2237	Tieling	a large city in the distance... probably	city_art
349	city	-0.2	5.55	Accra	a large city in the distance... probably	city_art
350	city	112.0445	22.9152	Yunfu	a large city in the distance... probably	city_art
351	city	107	-6.2333	Bekasi Kota	a large city in the distance... probably	city_art
352	city	128.6017	35.8717	Daegu	a large city in the distance... probably	city_art
353	city	77.42	28.67	Ghaziabad	a large city in the distance... probably	city_art
354	city	112.4539	34.6197	Luoyang	a large city in the distance... probably	city_art
355	city	153.0281	-27.4678	Brisbane	a large city in the distance... probably	city_art
356	city	105.9476	26.2531	Anshun	a large city in the distance... probably	city_art
357	city	-117.3949	33.9381	Riverside	a large city in the distance... probably	city_art
358	city	122.219	40.625	Yingkou	a large city in the distance... probably	city_art
359	city	79.8428	6.9344	Colombo	a large city in the distance... probably	city_art
360	city	104.627	30.129	Yanjiang	a large city in the distance... probably	city_art
361	city	49.8822	40.3953	Baku	a large city in the distance... probably	city_art
362	city	47.525	-18.91	Antananarivo	a large city in the distance... probably	city_art
363	city	129.6329	44.5514	Mudanjiang	a large city in the distance... probably	city_art
364	city	130.4017	33.59	Fukuoka	a large city in the distance... probably	city_art
365	city	109.494	36.65	Yan'an	a large city in the distance... probably	city_art
366	city	112.852	35.491	Jincheng	a large city in the distance... probably	city_art
367	city	120.894	31.981	Nantong	a large city in the distance... probably	city_art
368	city	100.089	23.884	Lincang	a large city in the distance... probably	city_art
369	city	102.527	24.347	Yuxi	a large city in the distance... probably	city_art
370	city	-115.2654	36.2333	Las Vegas	a large city in the distance... probably	city_art
371	city	-66.9036	10.4806	Caracas	a large city in the distance... probably	city_art
372	city	106.6403	-6.1703	Tangerang	a large city in the distance... probably	city_art
373	city	109.2212	23.7501	Laibin	a large city in the distance... probably	city_art
374	city	32.4833	37.8667	Konya	a large city in the distance... probably	city_art
375	city	86.605	26.126	Supaul	a large city in the distance... probably	city_art
376	city	16.3725	48.2083	Vienna	a large city in the distance... probably	city_art
377	city	51.6675	32.6447	Esfahan	a large city in the distance... probably	city_art
378	city	-76.6144	39.3051	Baltimore	a large city in the distance... probably	city_art
379	city	118.6746	37.434	Shengli	a large city in the distance... probably	city_art
380	city	124.3833	40.1167	Dandong	a large city in the distance... probably	city_art
381	city	107.64	35.7278	Qinbaling	a large city in the distance... probably	city_art
382	city	106.1281	30.7824	Gaoping	a large city in the distance... probably	city_art
383	city	7.0678	6.2069	Awka	a large city in the distance... probably	city_art
384	city	121.4208	28.6557	Taizhou	a large city in the distance... probably	city_art
385	city	118.507	31.669	Ma'anshan	a large city in the distance... probably	city_art
386	city	31.0522	-17.8292	Harare	a large city in the distance... probably	city_art
387	city	115.8606	-31.9559	Perth	a large city in the distance... probably	city_art
388	city	-90.2451	38.6359	St. Louis	a large city in the distance... probably	city_art
389	city	104.9211	11.5694	Phnom Penh	a large city in the distance... probably	city_art
390	city	106.8225	-6.394	Depok	a large city in the distance... probably	city_art
391	city	18.0686	59.3294	Stockholm	a large city in the distance... probably	city_art
392	city	116.166	23.298	Puning	a large city in the distance... probably	city_art
393	city	116.798	33.956	Huaibei	a large city in the distance... probably	city_art
394	city	114.1833	22.3167	Kowloon	a large city in the distance... probably	city_art
395	city	-64.1833	-31.4167	Cordoba	a large city in the distance... probably	city_art
396	city	106.6838	20.8651	Haiphong	a large city in the distance... probably	city_art
397	city	122.0761	6.9042	Zamboanga City	a large city in the distance... probably	city_art
398	city	107.365	22.377	Chongzuo	a large city in the distance... probably	city_art
399	city	73.0333	33.6	Rawalpindi	a large city in the distance... probably	city_art
400	city	-122.65	45.5371	Portland	a large city in the distance... probably	city_art
401	city	8.5167	12	Kano	a large city in the distance... probably	city_art
402	city	120.985	31.322	Yushan	a large city in the distance... probably	city_art
403	city	-82.3589	23.1367	Havana	a large city in the distance... probably	city_art
404	city	111.5672	24.4042	Hezhou	a large city in the distance... probably	city_art
405	city	106.6649	35.5424	Pingliang	a large city in the distance... probably	city_art
406	city	73.2	22.3	Vadodara	a large city in the distance... probably	city_art
407	city	-60.0217	-3.1189	Manaus	a large city in the distance... probably	city_art
408	city	118.5517	24.7816	Qingyang	a large city in the distance... probably	city_art
409	city	-98.5238	29.4632	San Antonio	a large city in the distance... probably	city_art
410	city	70.7833	22.3	Rajkot	a large city in the distance... probably	city_art
411	city	109.9244	33.868	Shangzhou	a large city in the distance... probably	city_art
412	city	83.2978	17.7042	Vishakhapatnam	a large city in the distance... probably	city_art
413	city	111.2004	34.7732	Sanmenxia	a large city in the distance... probably	city_art
414	city	122.838	45.62	Baicheng	a large city in the distance... probably	city_art
415	city	74.19	32.1567	Gujranwala	a large city in the distance... probably	city_art
416	city	37.16	36.2	Aleppo	a large city in the distance... probably	city_art
417	city	-117.0333	32.525	Tijuana	a large city in the distance... probably	city_art
418	city	10.1517	5.9614	Bamenda	a large city in the distance... probably	city_art
419	city	27.5667	53.9	Minsk	a large city in the distance... probably	city_art
420	city	75.8472	22.7167	Indore	a large city in the distance... probably	city_art
421	city	50.9489	35.8272	Karaj	a large city in the distance... probably	city_art
422	city	22.4488	-5.897	Kananga	a large city in the distance... probably	city_art
423	city	71.5675	34.0144	Peshawar	a large city in the distance... probably	city_art
424	city	141.3544	43.0619	Sapporo	a large city in the distance... probably	city_art
425	city	-121.4685	38.5677	Sacramento	a large city in the distance... probably	city_art
426	city	5.0833	51.55	Tilburg	a large city in the distance... probably	city_art
427	city	113.887	27.659	Pingxiang	a large city in the distance... probably	city_art
428	city	-99.06	19.6097	Ecatepec	a large city in the distance... probably	city_art
429	city	76.915	43.24	Almaty	a large city in the distance... probably	city_art
430	city	-97.7522	30.3005	Austin	a large city in the distance... probably	city_art
431	city	106.225	38.485	Yinchuan	a large city in the distance... probably	city_art
432	city	-46.325	-23.9369	Santos	a large city in the distance... probably	city_art
433	city	35.0058	-15.7861	Blantyre	a large city in the distance... probably	city_art
434	city	72.9722	19.1972	Thane	a large city in the distance... probably	city_art
435	city	-81.337	28.4773	Orlando	a large city in the distance... probably	city_art
436	city	120.1833	22.9833	Tainan	a large city in the distance... probably	city_art
437	city	113.2981	40.082	Xiping	a large city in the distance... probably	city_art
438	city	71.4697	30.1978	Multan	a large city in the distance... probably	city_art
439	city	-63.1833	-17.8	Santa Cruz	a large city in the distance... probably	city_art
440	city	7.0336	4.8242	Port Harcourt	a large city in the distance... probably	city_art
441	city	130.969	45.295	Jixi	a large city in the distance... probably	city_art
442	city	123.957	41.881	Fushun	a large city in the distance... probably	city_art
443	city	21.0111	52.23	Warsaw	a large city in the distance... probably	city_art
444	city	109.12	21.481	Beihai	a large city in the distance... probably	city_art
445	city	121.67	42.022	Fuxin	a large city in the distance... probably	city_art
446	city	102.638	37.929	Wuwei	a large city in the distance... probably	city_art
447	city	124.3506	43.1668	Siping	a large city in the distance... probably	city_art
448	city	-66.061	18.3985	San Juan	a large city in the distance... probably	city_art
449	city	34.6333	36.8	Mersin	a large city in the distance... probably	city_art
450	city	77.4126	23.2599	Bhopal	a large city in the distance... probably	city_art
451	city	43.13	36.34	Mosul	a large city in the distance... probably	city_art
452	city	27.4794	-11.6647	Lubumbashi	a large city in the distance... probably	city_art
453	city	125.6	7.07	Davao	a large city in the distance... probably	city_art
454	city	-49.2711	-25.4297	Curitiba	a large city in the distance... probably	city_art
455	city	-121.848	37.3012	San Jose	a large city in the distance... probably	city_art
456	city	118.7734	34.1299	Shuyangzha	a large city in the distance... probably	city_art
457	city	35.3213	37	Adana	a large city in the distance... probably	city_art
458	city	-78.5125	-0.22	Quito	a large city in the distance... probably	city_art
459	city	-79.9763	40.4397	Pittsburgh	a large city in the distance... probably	city_art
460	city	15.2711	-4.2694	Brazzaville	a large city in the distance... probably	city_art
461	city	68.3683	25.3792	Hyderabad City	a large city in the distance... probably	city_art
462	city	40.24	37.91	Diyarbakir	a large city in the distance... probably	city_art
463	city	-86.1458	39.7771	Indianapolis	a large city in the distance... probably	city_art
464	city	73.8037	18.6186	Pimpri-Chinchwad	a large city in the distance... probably	city_art
465	city	58.4083	23.5889	Masqat	a large city in the distance... probably	city_art
466	city	-56.1819	-34.8836	Montevideo	a large city in the distance... probably	city_art
467	city	112.4329	39.3317	Shuozhou	a large city in the distance... probably	city_art
468	city	-73.9662	40.7834	Manhattan	a large city in the distance... probably	city_art
469	city	-84.506	39.1413	Cincinnati	a large city in the distance... probably	city_art
470	city	-94.5541	39.1238	Kansas City	a large city in the distance... probably	city_art
471	city	85.1376	25.594	Patna	a large city in the distance... probably	city_art
472	city	-87.2047	14.1058	Tegucigalpa	a large city in the distance... probably	city_art
473	city	32.5811	0.3136	Kampala	a large city in the distance... probably	city_art
474	city	-81.6805	41.4764	Cleveland	a large city in the distance... probably	city_art
475	city	108.4	30.82	Sanzhou	a large city in the distance... probably	city_art
476	city	120.753	31.656	Changshu	a large city in the distance... probably	city_art
477	city	127.521	50.2401	Heihe	a large city in the distance... probably	city_art
478	city	-13.7122	9.5092	Conakry	a large city in the distance... probably	city_art
479	city	118.3849	24.9612	Ximeicun	a large city in the distance... probably	city_art
480	city	120.97	14.65	Caloocan City	a large city in the distance... probably	city_art
481	city	30.8328	-20.0744	Masvingo	a large city in the distance... probably	city_art
482	city	121.2168	24.965	Zhongli	a large city in the distance... probably	city_art
483	city	82.95	55.05	Novosibirsk	a large city in the distance... probably	city_art
484	city	82.15	22.09	Bilaspur	a large city in the distance... probably	city_art
485	city	110.4225	-6.99	Semarang	a large city in the distance... probably	city_art
486	city	117.1986	29.2917	Jingdezhen	a large city in the distance... probably	city_art
487	city	75.85	30.91	Ludhiana	a large city in the distance... probably	city_art
488	city	123.176	41.279	Liaoyang	a large city in the distance... probably	city_art
489	city	117.15	35.0833	Chengtangcun	a large city in the distance... probably	city_art
490	city	88.6	24.3667	Rajshahi	a large city in the distance... probably	city_art
491	city	-9.5517	13.3558	Balandougou	a large city in the distance... probably	city_art
492	city	120.295	31.839	Jiangyin	a large city in the distance... probably	city_art
493	city	-0.3764	39.47	Valencia	a large city in the distance... probably	city_art
494	city	78.02	27.18	Agra	a large city in the distance... probably	city_art
495	city	-101.6833	21.1167	Leon de los Aldama	a large city in the distance... probably	city_art
496	city	-98.1833	19.0333	Puebla	a large city in the distance... probably	city_art
497	city	-82.9855	39.9862	Columbus	a large city in the distance... probably	city_art
498	city	-4.0667	5.3167	Yopougon	a large city in the distance... probably	city_art
499	city	114.297	35.748	Hebi	a large city in the distance... probably	city_art
500	city	52.5425	29.61	Shiraz	a large city in the distance... probably	city_art
501	city	78.1198	9.9252	Madurai	a large city in the distance... probably	city_art
502	city	120.0875	30.8925	Huzhou	a large city in the distance... probably	city_art
503	city	46.3006	38.0814	Tabriz	a large city in the distance... probably	city_art
504	city	86.1842	22.7925	Jamshedpur	a large city in the distance... probably	city_art
505	city	-71.6333	10.6333	Maracaibo	a large city in the distance... probably	city_art
506	city	23.33	42.7	Sofia	a large city in the distance... probably	city_art
507	city	-84.08	9.9325	San Jose	a large city in the distance... probably	city_art
508	city	81.8464	25.4358	Prayagraj	a large city in the distance... probably	city_art
509	city	104.7556	-2.9861	Palembang	a large city in the distance... probably	city_art
510	city	139.7	35.5167	Kawasaki	a large city in the distance... probably	city_art
511	city	135.1956	34.69	Kobe	a large city in the distance... probably	city_art
512	city	120.756	30.747	Jiaxing	a large city in the distance... probably	city_art
513	city	30.0594	-1.9439	Kigali	a large city in the distance... probably	city_art
514	city	110.479	29.117	Zhangjiajie	a large city in the distance... probably	city_art
515	city	104.1389	36.5451	Baiyin	a large city in the distance... probably	city_art
516	city	110.0833	23.4	Guiping	a large city in the distance... probably	city_art
517	city	110.2833	21.7333	Lianjiang	a large city in the distance... probably	city_art
518	city	115.7833	28.1958	Jianguang	a large city in the distance... probably	city_art
519	city	103.0415	30.01	Yucheng	a large city in the distance... probably	city_art
520	city	121.2333	30.1667	Xushan	a large city in the distance... probably	city_art
521	city	-79.5167	8.9833	Panama City	a large city in the distance... probably	city_art
522	city	6.8333	6.3333	Nneyi-Umuleri	a large city in the distance... probably	city_art
523	city	110.0967	20.9143	Leizhou	a large city in the distance... probably	city_art
524	city	126.8486	35.1653	Gwangju	a large city in the distance... probably	city_art
525	city	24.42	-3.4	Katako-Kombe	a large city in the distance... probably	city_art
526	city	-34.9	-8.05	Recife	a large city in the distance... probably	city_art
527	city	73.7898	19.9975	Nasik	a large city in the distance... probably	city_art
528	city	-68	10.1833	Valencia	a large city in the distance... probably	city_art
529	city	6.7833	6.1667	Onitsha	a large city in the distance... probably	city_art
530	city	54.3667	24.4667	Abu Dhabi	a large city in the distance... probably	city_art
531	city	-103.4	20.7167	Zapopan	a large city in the distance... probably	city_art
532	city	127.385	36.35	Daejeon	a large city in the distance... probably	city_art
533	city	-73.8662	40.8501	Bronx	a large city in the distance... probably	city_art
534	city	60.6128	56.8356	Yekaterinburg	a large city in the distance... probably	city_art
535	city	112.087	32.688	Huazhou	a large city in the distance... probably	city_art
536	city	119.647	29.079	Jinhua	a large city in the distance... probably	city_art
537	city	135.7683	35.0117	Kyoto	a large city in the distance... probably	city_art
538	city	4.8936	52.3728	Amsterdam	a large city in the distance... probably	city_art
539	city	117.89	34.398	Pizhou	a large city in the distance... probably	city_art
540	city	42.5453	-0.3581	Kismaayo	a large city in the distance... probably	city_art
541	city	120.556	31.8767	Yangshe	a large city in the distance... probably	city_art
542	city	-76.0435	36.7335	Virginia Beach	a large city in the distance... probably	city_art
543	city	-17.4467	14.6928	Dakar	a large city in the distance... probably	city_art
544	city	-49.25	-16.6667	Goiania	a large city in the distance... probably	city_art
545	city	-80.8303	35.2083	Charlotte	a large city in the distance... probably	city_art
546	city	120.625	27.7833	Rui'an	a large city in the distance... probably	city_art
547	city	58.5922	23.6139	Muscat	a large city in the distance... probably	city_art
548	city	36.2311	49.9925	Kharkiv	a large city in the distance... probably	city_art
549	city	121.3667	28.3667	Wenling	a large city in the distance... probably	city_art
550	city	110.8422	21.9244	Gaozhou	a large city in the distance... probably	city_art
551	city	77.3078	28.4211	Faridabad	a large city in the distance... probably	city_art
552	city	39.61	24.47	Medina	a large city in the distance... probably	city_art
553	city	89.55	22.8167	Khulna	a large city in the distance... probably	city_art
554	city	106.9172	47.9203	Ulaanbaatar	a large city in the distance... probably	city_art
555	city	119.3833	25.7167	Fuqing	a large city in the distance... probably	city_art
556	city	35.4875	38.7225	Kayseri	a large city in the distance... probably	city_art
557	city	34.78	32.08	Tel Aviv-Yafo	a large city in the distance... probably	city_art
558	city	106.1986	37.9978	Wuzhong	a large city in the distance... probably	city_art
559	city	119.9884	36.7769	Pingdu	a large city in the distance... probably	city_art
560	city	106.7181	-6.2889	Sangereng	a large city in the distance... probably	city_art
561	city	113.5804	37.8571	Yangquan	a large city in the distance... probably	city_art
562	city	36.3336	41.2903	Samsun	a large city in the distance... probably	city_art
563	city	112.552	28.278	Yutan	a large city in the distance... probably	city_art
564	city	12.5683	55.6761	Copenhagen	a large city in the distance... probably	city_art
565	city	24.9375	60.1708	Helsinki	a large city in the distance... probably	city_art
566	city	14.4214	50.0875	Prague	a large city in the distance... probably	city_art
567	city	9.19	45.4669	Milan	a large city in the distance... probably	city_art
568	city	174.74	-36.8406	Auckland	a large city in the distance... probably	city_art
569	city	-70.6889	19.4572	Santiago	a large city in the distance... probably	city_art
570	city	117.4916	30.6654	Chizhou	a large city in the distance... probably	city_art
571	city	119.4362	-5.1619	Makassar	a large city in the distance... probably	city_art
572	city	111.7442	27.26	Liangshi	a large city in the distance... probably	city_art
573	city	-51.23	-30.0331	Porto Alegre	a large city in the distance... probably	city_art
574	city	118.3376	29.7149	Huangshan	a large city in the distance... probably	city_art
575	city	-74.8019	10.9833	Barranquilla	a large city in the distance... probably	city_art
576	city	47.81	30.515	Al Basrah	a large city in the distance... probably	city_art
577	city	123.685	41.4868	Benxi	a large city in the distance... probably	city_art
578	city	139.6456	35.8614	Saitama	a large city in the distance... probably	city_art
579	city	-46.5328	-23.4628	Guarulhos	a large city in the distance... probably	city_art
580	city	-106.485	31.745	Juarez	a large city in the distance... probably	city_art
581	city	96.0844	21.9831	Mandalay	a large city in the distance... probably	city_art
582	city	117.768	35.909	Xintai	a large city in the distance... probably	city_art
583	city	117.7667	30.9333	Wusong	a large city in the distance... probably	city_art
584	city	-114.0667	51.05	Calgary	a large city in the distance... probably	city_art
585	city	77.71	28.98	Meerut	a large city in the distance... probably	city_art
586	city	126.55	44.826	Yushu	a large city in the distance... probably	city_art
587	city	-48.5039	-1.4558	Belem	a large city in the distance... probably	city_art
588	city	125.9397	41.7283	Kuaidamao	a large city in the distance... probably	city_art
589	city	110.6396	21.664	Huazhou	a large city in the distance... probably	city_art
590	city	126.4147	41.944	Baishan	a large city in the distance... probably	city_art
591	city	138.6	-34.9275	Adelaide	a large city in the distance... probably	city_art
592	city	122.6852	40.8824	Haicheng	a large city in the distance... probably	city_art
593	city	-87.9675	43.0642	Milwaukee	a large city in the distance... probably	city_art
594	city	-71.4187	41.823	Providence	a large city in the distance... probably	city_art
595	city	-81.6749	30.3322	Jacksonville	a large city in the distance... probably	city_art
596	city	119.815	31.36	Yicheng	a large city in the distance... probably	city_art
597	city	13.2444	-8.8053	Cacuaco	a large city in the distance... probably	city_art
598	city	-8.622	41.1621	Porto	a large city in the distance... probably	city_art
599	city	-60.6394	-32.9575	Rosario	a large city in the distance... probably	city_art
600	city	121.8	18	Canagatan	a large city in the distance... probably	city_art
601	city	27.8585	-26.2678	Soweto	a large city in the distance... probably	city_art
602	city	104.0531	1.13	Bagam	a large city in the distance... probably	city_art
603	city	79.9333	23.1667	Jabalpur	a large city in the distance... probably	city_art
604	city	120.591	32.246	Rucheng	a large city in the distance... probably	city_art
605	city	119.028	33.5819	Huaiyin	a large city in the distance... probably	city_art
606	city	-6.2603	53.35	Dublin	a large city in the distance... probably	city_art
607	city	49.1089	55.7964	Kazan	a large city in the distance... probably	city_art
608	city	100.2259	26.8552	Dayan	a large city in the distance... probably	city_art
609	city	119.8526	32.912	Shaoyang	a large city in the distance... probably	city_art
610	city	27.8833	39.6333	Balikesir	a large city in the distance... probably	city_art
611	city	-87.21	14.098	Comayaguela	a large city in the distance... probably	city_art
612	city	117.6667	36.1833	Laiwu	a large city in the distance... probably	city_art
613	city	55.3908	25.3575	Sharjah	a large city in the distance... probably	city_art
614	city	113.167	30.664	Jingling	a large city in the distance... probably	city_art
615	city	73.1602	19.2502	Kalyan	a large city in the distance... probably	city_art
616	city	44.0075	56.3269	Nizhniy Novgorod	a large city in the distance... probably	city_art
617	city	116.45	33.9299	Yongcheng	a large city in the distance... probably	city_art
618	city	107.9208	-6.84	Sumedang	a large city in the distance... probably	city_art
619	city	105.7833	10.0333	Can Tho	a large city in the distance... probably	city_art
620	city	4.3525	50.8467	Brussels	a large city in the distance... probably	city_art
621	city	127.0167	37.2667	Suwon	a large city in the distance... probably	city_art
622	city	120.0753	29.3069	Yiwu	a large city in the distance... probably	city_art
623	city	105.918	34.602	Beidao	a large city in the distance... probably	city_art
624	city	72.7956	19.3607	Vasai-Virar	a large city in the distance... probably	city_art
625	city	104.8314	26.5964	Xiangshui	a large city in the distance... probably	city_art
626	city	101.7184	26.5824	Dadukou	a large city in the distance... probably	city_art
627	city	-47.0608	-22.9058	Campinas	a large city in the distance... probably	city_art
628	city	110.35	22.7	Lingcheng	a large city in the distance... probably	city_art
629	city	131.1416	46.6762	Shuangyashan	a large city in the distance... probably	city_art
630	city	39.6667	-4.05	Mombasa	a large city in the distance... probably	city_art
631	city	76.9798	28.6092	Najafgarh	a large city in the distance... probably	city_art
632	city	114.9167	27.8186	Xinyu	a large city in the distance... probably	city_art
633	city	50.8764	34.64	Qom	a large city in the distance... probably	city_art
634	city	44.0675	9.5631	Hargeysa	a large city in the distance... probably	city_art
635	city	43.65	3.1167	Baidoa	a large city in the distance... probably	city_art
636	city	100.4499	38.9248	Zhangye	a large city in the distance... probably	city_art
637	city	83.0128	25.3189	Varanasi	a large city in the distance... probably	city_art
638	city	132.4519	34.3914	Hiroshima	a large city in the distance... probably	city_art
639	city	98.9986	18.7953	Chiang Mai	a large city in the distance... probably	city_art
640	city	20.46	44.82	Belgrade	a large city in the distance... probably	city_art
641	city	13.15	11.8333	Maiduguri	a large city in the distance... probably	city_art
642	city	61.3758	55.1547	Chelyabinsk	a large city in the distance... probably	city_art
643	city	104.0531	1.13	Batam Centre	a large city in the distance... probably	city_art
644	city	104.103	26.218	Rongcheng	a large city in the distance... probably	city_art
645	city	18.2558	0.0478	Mbandaka	a large city in the distance... probably	city_art
646	city	51.5333	25.2867	Doha	a large city in the distance... probably	city_art
647	city	48.6783	31.3047	Ahvaz	a large city in the distance... probably	city_art
648	city	69.5958	42.3167	Shymkent	a large city in the distance... probably	city_art
649	city	13.1914	32.8872	Tripoli	a large city in the distance... probably	city_art
650	city	74.79	34.09	Srinagar	a large city in the distance... probably	city_art
651	city	-86.7842	36.1715	Nashville	a large city in the distance... probably	city_art
652	city	125.1447	42.888	Liaoyuan	a large city in the distance... probably	city_art
653	city	75.32	19.88	Aurangabad	a large city in the distance... probably	city_art
654	city	109.017	-7.7167	Cilacap	a large city in the distance... probably	city_art
655	city	-111.9311	40.7776	Salt Lake City	a large city in the distance... probably	city_art
656	city	73.3667	54.9833	Omsk	a large city in the distance... probably	city_art
657	city	-17.4	14.75	Pikine	a large city in the distance... probably	city_art
658	city	50.1408	53.2028	Samara	a large city in the distance... probably	city_art
659	city	113.6433	28.1637	Guankou	a large city in the distance... probably	city_art
660	city	105.2667	-5.45	Bandar Lampung	a large city in the distance... probably	city_art
661	city	-78.6429	35.8324	Raleigh	a large city in the distance... probably	city_art
662	city	111.664	27.692	Lianyuan	a large city in the distance... probably	city_art
663	city	112.9048	29.8402	Rongcheng	a large city in the distance... probably	city_art
664	city	86.4305	23.7998	Dhanbad	a large city in the distance... probably	city_art
665	city	96.115	19.7475	Nay Pyi Taw	a large city in the distance... probably	city_art
666	city	7.3667	5.1167	Aba	a large city in the distance... probably	city_art
667	city	113.86	36.0193	Kaiyuan	a large city in the distance... probably	city_art
668	city	120.2333	29.7167	Zhuji	a large city in the distance... probably	city_art
669	city	117.0395	28.2721	Yingtan	a large city in the distance... probably	city_art
670	city	-113.4903	53.5344	Edmonton	a large city in the distance... probably	city_art
671	city	112.8598	26.4223	Leiyang	a large city in the distance... probably	city_art
672	city	129.3167	35.55	Ulsan	a large city in the distance... probably	city_art
673	city	128.841	47.728	Yichun	a large city in the distance... probably	city_art
674	city	5.6222	6.3333	Benin City	a large city in the distance... probably	city_art
675	city	29.3667	-3.3833	Bujumbura	a large city in the distance... probably	city_art
676	city	106.257	36.01	Guyuan	a large city in the distance... probably	city_art
677	city	113.443	30.328	Xiantao	a large city in the distance... probably	city_art
678	city	39.71	47.2225	Rostov	a large city in the distance... probably	city_art
679	city	32.5833	-25.9667	Maputo	a large city in the distance... probably	city_art
680	city	28.8667	-2.5	Bukavu	a large city in the distance... probably	city_art
681	city	74.86	31.64	Amritsar	a large city in the distance... probably	city_art
682	city	3.65	6.8333	Shagamu	a large city in the distance... probably	city_art
683	city	113.4733	34.1511	Yingchuan	a large city in the distance... probably	city_art
684	city	78.08	27.88	Aligarh	a large city in the distance... probably	city_art
685	city	-69.95	18.4667	Santo Domingo	a large city in the distance... probably	city_art
686	city	106.7972	-6.5966	Bogor	a large city in the distance... probably	city_art
687	city	74.6122	42.8747	Bishkek	a large city in the distance... probably	city_art
688	city	44.7925	41.7225	Tbilisi	a large city in the distance... probably	city_art
689	city	91.7458	26.1722	Guwahati	a large city in the distance... probably	city_art
690	city	55.9475	54.7261	Ufa	a large city in the distance... probably	city_art
691	city	-5.0033	34.0433	Fes	a large city in the distance... probably	city_art
692	city	32.9	-2.5167	Mwanza	a large city in the distance... probably	city_art
693	city	106.8167	10.95	Bien Hoa	a large city in the distance... probably	city_art
694	city	-115.4678	32.6633	Mexicali	a large city in the distance... probably	city_art
695	city	-5.99	37.39	Sevilla	a large city in the distance... probably	city_art
696	city	5.75	7.5167	Ikare	a large city in the distance... probably	city_art
697	city	120.519	32.795	Dongtai	a large city in the distance... probably	city_art
698	city	114.99	38.516	Dingzhou	a large city in the distance... probably	city_art
699	city	98.4943	39.7334	Xibeijie	a large city in the distance... probably	city_art
700	city	-0.8533	9.4075	Tamale	a large city in the distance... probably	city_art
701	city	121.15	30.05	Yuyao	a large city in the distance... probably	city_art
702	city	113.8274	30.652	Hanchuan	a large city in the distance... probably	city_art
703	city	124.8224	43.5053	Gongzhuling	a large city in the distance... probably	city_art
704	city	15.05	12.11	N'Djamena	a large city in the distance... probably	city_art
705	city	39.2056	-6.7889	Ubungo	a large city in the distance... probably	city_art
706	city	6.9528	50.9364	Cologne	a large city in the distance... probably	city_art
707	city	92.8719	56.0089	Krasnoyarsk	a large city in the distance... probably	city_art
708	city	119.4167	36	Zhufeng	a large city in the distance... probably	city_art
709	city	114.8949	30.3914	Ezhou	a large city in the distance... probably	city_art
710	city	71.4222	51.1472	Astana	a large city in the distance... probably	city_art
711	city	-99.0186	19.4081	Nezahualcoyotl	a large city in the distance... probably	city_art
712	city	-15.9785	18.0858	Nouakchott	a large city in the distance... probably	city_art
713	city	88.3294	22.58	Haora	a large city in the distance... probably	city_art
714	city	127.2	37.2333	Tongjin	a large city in the distance... probably	city_art
715	city	120.6833	30.5333	Xiashi	a large city in the distance... probably	city_art
716	city	44.5144	40.1814	Yerevan	a large city in the distance... probably	city_art
717	city	85.33	23.36	Ranchi	a large city in the distance... probably	city_art
718	city	-77.4756	37.5295	Richmond	a large city in the distance... probably	city_art
719	city	-99.0148	19.4006	Ciudad Nezahualcoyotl	a large city in the distance... probably	city_art
720	city	78.1772	26.2124	Gwalior	a large city in the distance... probably	city_art
721	city	-75.695	45.4247	Ottawa	a large city in the distance... probably	city_art
722	city	105.1968	37.5002	Zhongwei	a large city in the distance... probably	city_art
723	city	10.7389	59.9133	Oslo	a large city in the distance... probably	city_art
724	city	126.8	37.65	Goyang	a large city in the distance... probably	city_art
725	city	140.8694	38.2682	Sendai	a large city in the distance... probably	city_art
726	city	119.3801	35.99	Mizhou	a large city in the distance... probably	city_art
727	city	113.497	27.6461	Xishan	a large city in the distance... probably	city_art
728	city	-69.3347	10.0636	Barquisimeto	a large city in the distance... probably	city_art
729	city	130.298	47.3501	Hegang	a large city in the distance... probably	city_art
730	city	76.78	30.75	Chandigarh	a large city in the distance... probably	city_art
731	city	39.2106	51.6717	Voronezh	a large city in the distance... probably	city_art
732	city	-86.2514	12.1364	Managua	a large city in the distance... probably	city_art
733	city	79.52	29.22	Haldwani	a large city in the distance... probably	city_art
734	city	80.6305	16.5193	Vijayawada	a large city in the distance... probably	city_art
735	city	56.3167	58	Perm	a large city in the distance... probably	city_art
736	city	108.3547	21.6867	Fangchenggang	a large city in the distance... probably	city_art
737	city	104.5465	30.3931	Jiancheng	a large city in the distance... probably	city_art
738	city	13.2911	-8.8214	Cazenga	a large city in the distance... probably	city_art
739	city	25.2	0.5167	Kisangani	a large city in the distance... probably	city_art
740	city	118.791	36.857	Shouguang	a large city in the distance... probably	city_art
741	city	-89.9663	35.1087	Memphis	a large city in the distance... probably	city_art
742	city	-44.3044	-2.5283	Sao Luis	a large city in the distance... probably	city_art
743	city	73.02	26.28	Jodhpur	a large city in the distance... probably	city_art
744	city	32.4667	-25.9667	Matola	a large city in the distance... probably	city_art
745	city	4.25	8.1333	Ogbomoso	a large city in the distance... probably	city_art
746	city	109.5036	18.2533	Sanya	a large city in the distance... probably	city_art
747	city	89.25	25.56	Rangapukur	a large city in the distance... probably	city_art
748	city	58.38	37.9375	Ashgabat	a large city in the distance... probably	city_art
749	city	120.5333	30.6333	Wutong	a large city in the distance... probably	city_art
750	city	121.1167	28.85	Linhai	a large city in the distance... probably	city_art
751	city	29.0964	37.7833	Denizli	a large city in the distance... probably	city_art
752	city	2.1175	13.515	Niamey	a large city in the distance... probably	city_art
753	city	31.2422	30.1286	Shubra al Khaymah	a large city in the distance... probably	city_art
754	city	121.9796	39.6271	Wafangdian	a large city in the distance... probably	city_art
755	city	112.5853	31.169	Zhongxiang	a large city in the distance... probably	city_art
756	city	-10.8014	6.3133	Monrovia	a large city in the distance... probably	city_art
757	city	-72.2333	7.7667	San Cristobal	a large city in the distance... probably	city_art
758	city	73.0639	33.6931	Islamabad	a large city in the distance... probably	city_art
759	city	110.9468	22.3549	Xinyi	a large city in the distance... probably	city_art
760	city	106.7609	10.8266	Thu Duc	a large city in the distance... probably	city_art
761	city	-101.1894	19.7683	Morelia	a large city in the distance... probably	city_art
762	city	30.7326	46.4775	Odesa	a large city in the distance... probably	city_art
763	city	81.6306	21.2444	Raipur	a large city in the distance... probably	city_art
764	city	128.6631	35.2708	Changwon	a large city in the distance... probably	city_art
765	city	-71.5333	-16.4	Arequipa	a large city in the distance... probably	city_art
766	city	44.5147	48.7086	Volgograd	a large city in the distance... probably	city_art
767	city	112.772	32.129	Zaoyang	a large city in the distance... probably	city_art
768	city	104.8955	25.092	Xingyi	a large city in the distance... probably	city_art
769	city	114.8994	33.4433	Shuizhai	a large city in the distance... probably	city_art
770	city	75.83	25.18	Kota	a large city in the distance... probably	city_art
771	city	67	30.1833	Quetta	a large city in the distance... probably	city_art
772	city	108.2667	15.9333	Quang Ha	a large city in the distance... probably	city_art
773	city	-2.8833	7.2833	Domaa-Ahenkro	a large city in the distance... probably	city_art
774	city	79.415	28.364	Bareilly	a large city in the distance... probably	city_art
775	city	-97.5136	35.4676	Oklahoma City	a large city in the distance... probably	city_art
776	city	-0.58	44.84	Bordeaux	a large city in the distance... probably	city_art
777	city	115.73	24.1347	Xingcheng	a large city in the distance... probably	city_art
778	city	120.029	32.159	Taixing	a large city in the distance... probably	city_art
779	city	113.7402	34.3964	Xinhualu	a large city in the distance... probably	city_art
780	city	33.7833	-13.9833	Lilongwe	a large city in the distance... probably	city_art
781	city	-72.3333	18.5333	Port-au-Prince	a large city in the distance... probably	city_art
782	city	113.401	24.21	Yingcheng	a large city in the distance... probably	city_art
783	city	27.74	11.0339	Al Mijlad	a large city in the distance... probably	city_art
784	city	111.5697	22.7689	Luocheng	a large city in the distance... probably	city_art
785	city	101.4453	0.5092	Pekanbaru	a large city in the distance... probably	city_art
786	city	-60.2699	-6.9838	Natal	a large city in the distance... probably	city_art
787	city	140.1064	35.6073	Chiba	a large city in the distance... probably	city_art
788	city	44.3167	35.4667	Kirkuk	a large city in the distance... probably	city_art
789	city	-72.6834	41.7661	Hartford	a large city in the distance... probably	city_art
790	city	121.703	31.87	Huilong	a large city in the distance... probably	city_art
791	city	110.779	21.441	Wuchuan	a large city in the distance... probably	city_art
792	city	35.04	48.4675	Dnipro	a large city in the distance... probably	city_art
793	city	90.5	23.62	Narayanganj	a large city in the distance... probably	city_art
794	city	25.6	-33.9581	Gqeberha	a large city in the distance... probably	city_art
795	city	-4.42	36.7194	Malaga	a large city in the distance... probably	city_art
796	city	-8.0089	31.63	Marrakech	a large city in the distance... probably	city_art
797	city	123.75	10.32	Cebu City	a large city in the distance... probably	city_art
798	city	-85.6485	38.1663	Louisville	a large city in the distance... probably	city_art
799	city	38.925	15.3228	Asmara	a large city in the distance... probably	city_art
800	city	76.9556	11.0167	Coimbatore	a large city in the distance... probably	city_art
801	city	-35.735	-9.6658	Maceio	a large city in the distance... probably	city_art
802	city	109.5808	19.5209	Nada	a large city in the distance... probably	city_art
803	city	112.785	22.2486	Taishan	a large city in the distance... probably	city_art
804	city	-42.8042	-5.0949	Teresina	a large city in the distance... probably	city_art
805	city	75.92	17.68	Solapur	a large city in the distance... probably	city_art
806	city	-13.2344	8.4844	Freetown	a large city in the distance... probably	city_art
807	city	-69.8734	18.4855	Santo Domingo Este	a large city in the distance... probably	city_art
808	city	38.9667	45.0333	Krasnodar	a large city in the distance... probably	city_art
809	city	102.63	17.98	Vientiane	a large city in the distance... probably	city_art
810	city	-5.8039	35.7767	Tangier	a large city in the distance... probably	city_art
811	city	119.219	36.478	Anqiu	a large city in the distance... probably	city_art
812	city	47.0933	34.3325	Kermanshah	a large city in the distance... probably	city_art
813	city	116.7719	36.1861	Feicheng	a large city in the distance... probably	city_art
814	city	15.395	-4.4419	Kibanseke Premiere	a large city in the distance... probably	city_art
815	city	100.3695	5.4083	Seberang Jaya	a large city in the distance... probably	city_art
816	city	-78.8487	42.9018	Buffalo	a large city in the distance... probably	city_art
817	city	75.1376	15.3502	Hubli	a large city in the distance... probably	city_art
818	city	-68.1633	-16.5047	El Alto	a large city in the distance... probably	city_art
819	city	32.8856	39.9244	Cankaya	a large city in the distance... probably	city_art
820	city	126.8314	37.1997	Hwasu-dong	a large city in the distance... probably	city_art
821	city	139.6532	35.6466	Setagaya	a large city in the distance... probably	city_art
822	city	32.8667	40	Kecioren	a large city in the distance... probably	city_art
823	city	35.2256	31.7789	Jerusalem	a large city in the distance... probably	city_art
824	city	32.6333	15.6333	Khartoum North	a large city in the distance... probably	city_art
825	city	112.839	34.1736	Meishan	a large city in the distance... probably	city_art
826	city	3.35	6.5333	Mushin	a large city in the distance... probably	city_art
827	city	-79.0288	-8.112	Trujillo	a large city in the distance... probably	city_art
828	city	130.8833	33.8833	Kitakyushu	a large city in the distance... probably	city_art
829	city	-102.296	21.876	Aguascalientes	a large city in the distance... probably	city_art
830	city	-89.9288	30.0687	New Orleans	a large city in the distance... probably	city_art
831	city	-97.3474	32.7817	Fort Worth	a large city in the distance... probably	city_art
832	city	105.3784	30.8706	Taihe	a large city in the distance... probably	city_art
833	city	24.1064	56.9489	Riga	a large city in the distance... probably	city_art
834	city	118.355	34.286	Xin'an	a large city in the distance... probably	city_art
835	city	131.003	45.771	Taihecun	a large city in the distance... probably	city_art
836	city	75.9938	39.4681	Kashgar	a large city in the distance... probably	city_art
837	city	127.15	37.4333	Songnam	a large city in the distance... probably	city_art
838	city	78.7047	10.7903	Trichinopoly	a large city in the distance... probably	city_art
839	city	-75.5	10.4	Cartagena	a large city in the distance... probably	city_art
840	city	118.4796	36.6853	Qingzhou	a large city in the distance... probably	city_art
841	city	14.25	40.8333	Naples	a large city in the distance... probably	city_art
842	city	-64.2667	-27.7833	Santiago del Estero	a large city in the distance... probably	city_art
843	city	-99.2378	19.4753	Naucalpan de Juarez	a large city in the distance... probably	city_art
844	city	114.9804	30.0961	Daye	a large city in the distance... probably	city_art
845	city	109.2614	22.6799	Hengzhou	a large city in the distance... probably	city_art
846	city	100.3531	-0.95	Padang	a large city in the distance... probably	city_art
847	city	-73.1954	41.1918	Bridgeport	a large city in the distance... probably	city_art
848	city	7.035	5.485	Owerri	a large city in the distance... probably	city_art
849	city	122.967	39.681	Zhuanghe	a large city in the distance... probably	city_art
850	city	-4.2833	11.1833	Bobo-Dioulasso	a large city in the distance... probably	city_art
851	city	50.1	26.4333	Ad Dammam	a large city in the distance... probably	city_art
852	city	118.8593	28.9702	Quzhou	a large city in the distance... probably	city_art
853	city	37.8053	48.0028	Donetsk	a large city in the distance... probably	city_art
854	city	31.0342	30.2941	Ashmun	a large city in the distance... probably	city_art
855	city	30.25	1.5667	Bunia	a large city in the distance... probably	city_art
856	city	120.0334	36.2647	Jiaozhou	a large city in the distance... probably	city_art
857	city	-54.615	-20.4839	Campo Grande	a large city in the distance... probably	city_art
858	city	127.158	44.924	Wuchang	a large city in the distance... probably	city_art
859	city	-43.0539	-22.8269	Sao Goncalo	a large city in the distance... probably	city_art
860	city	-73	7.1333	Bucaramanga	a large city in the distance... probably	city_art
861	city	-89.62	20.97	Merida	a large city in the distance... probably	city_art
862	city	111.7916	22.1704	Yangchun	a large city in the distance... probably	city_art
863	city	29.06	40.1983	Osmangazi	a large city in the distance... probably	city_art
864	city	28.68	41.0342	Esenyurt	a large city in the distance... probably	city_art
865	city	78.7764	28.8319	Moradabad	a large city in the distance... probably	city_art
866	city	18.5628	4.3733	Bangui	a large city in the distance... probably	city_art
867	city	3.3483	7.1608	Abeokuta	a large city in the distance... probably	city_art
868	city	-86.8475	21.1606	Cancun	a large city in the distance... probably	city_art
869	city	121.1763	14.5842	Antipolo	a large city in the distance... probably	city_art
870	city	114.1066	36.1386	Dengtalu	a large city in the distance... probably	city_art
871	city	121.05	14.52	Taguig City	a large city in the distance... probably	city_art
872	city	36.5789	28.3972	Tabuk	a large city in the distance... probably	city_art
873	city	122.2074	29.9856	Zhoushan	a large city in the distance... probably	city_art
874	city	-110.8787	32.1541	Tucson	a large city in the distance... probably	city_art
875	city	45.4356	35.5572	As Sulaymaniyah	a large city in the distance... probably	city_art
876	city	-106.0769	28.6369	Chihuahua	a large city in the distance... probably	city_art
877	city	101.45	3.0333	Klang	a large city in the distance... probably	city_art
878	city	77.3411	11.1085	Tiruppur	a large city in the distance... probably	city_art
879	city	77.029	28.456	Gurgaon	a large city in the distance... probably	city_art
880	city	43.2992	33.4258	Ar Ramadi	a large city in the distance... probably	city_art
881	city	120.563	32.535	Hai'an	a large city in the distance... probably	city_art
882	city	120.7136	36.9758	Laiyang	a large city in the distance... probably	city_art
883	city	-70.2	8.6333	Barinas	a large city in the distance... probably	city_art
884	city	75.4432	31.2569	Jalandhar	a large city in the distance... probably	city_art
885	city	5.37	43.2964	Marseille	a large city in the distance... probably	city_art
886	city	114.3481	34.8519	Kaifeng Chengguanzhen	a large city in the distance... probably	city_art
887	city	30.5206	39.7767	Eskisehir	a large city in the distance... probably	city_art
888	city	119.75	36.3833	Gaomi	a large city in the distance... probably	city_art
889	city	91.1719	29.6534	Lhasa	a large city in the distance... probably	city_art
890	city	101.075	4.5972	Ipoh	a large city in the distance... probably	city_art
891	city	-106.43	31.8476	El Paso	a large city in the distance... probably	city_art
892	city	-100.9919	25.4231	Saltillo	a large city in the distance... probably	city_art
893	city	68.78	38.5367	Dushanbe	a large city in the distance... probably	city_art
894	city	3.35	6.6	Ikeja	a large city in the distance... probably	city_art
895	city	-107.397	24.808	El Dorado	a large city in the distance... probably	city_art
896	city	-66.1597	-17.3883	Cochabamba	a large city in the distance... probably	city_art
897	city	-1.0872	50.8058	Portsmouth	a large city in the distance... probably	city_art
898	city	65.5333	57.15	Tyumen	a large city in the distance... probably	city_art
899	city	-1.4042	50.9025	Southampton	a large city in the distance... probably	city_art
900	city	-110.9542	29.0989	Hermosillo	a large city in the distance... probably	city_art
901	city	111.841	26.58	Wuxi	a large city in the distance... probably	city_art
902	city	117.152	28.978	Leping	a large city in the distance... probably	city_art
903	city	127.4833	36.6333	Cheongju	a large city in the distance... probably	city_art
904	city	77.25	38.4261	Shache	a large city in the distance... probably	city_art
905	city	-6.8	34.0333	Sale	a large city in the distance... probably	city_art
906	city	126.9667	47.4667	Hailun	a large city in the distance... probably	city_art
907	city	115.008	31.173	Macheng	a large city in the distance... probably	city_art
908	city	5.195	7.25	Akure	a large city in the distance... probably	city_art
909	city	4.55	8.5	Ilorin	a large city in the distance... probably	city_art
910	city	44.0092	36.1912	Erbil	a large city in the distance... probably	city_art
911	city	85.32	27.71	Kathmandu	a large city in the distance... probably	city_art
912	city	46.0167	51.5333	Saratov	a large city in the distance... probably	city_art
913	city	-43.47	-22.74	Iguacu	a large city in the distance... probably	city_art
914	city	112.9667	34.7667	Zijinglu	a large city in the distance... probably	city_art
915	city	7.6761	45.0792	Turin	a large city in the distance... probably	city_art
916	city	112.7281	37.6823	Yuci	a large city in the distance... probably	city_art
917	city	125.703	44.535	Dehui	a large city in the distance... probably	city_art
918	city	30.3833	-29.6167	Pietermaritzburg	a large city in the distance... probably	city_art
919	city	31.05	-29.8833	Durban	a large city in the distance... probably	city_art
920	city	85.8281	20.2644	Bhubaneshwar	a large city in the distance... probably	city_art
921	city	115.2167	-8.65	Denpasar	a large city in the distance... probably	city_art
922	city	108.945	34.897	Tongchuan	a large city in the distance... probably	city_art
923	city	-34.88	-7.12	Joao Pessoa	a large city in the distance... probably	city_art
924	city	117.1378	-0.5	Samarinda	a large city in the distance... probably	city_art
925	city	121.174	31.564	Chengxiang	a large city in the distance... probably	city_art
926	city	113.1087	29.1409	Rongjiawan	a large city in the distance... probably	city_art
927	city	119.9333	37.1792	Weichanglu	a large city in the distance... probably	city_art
928	city	135.4831	34.5733	Sakai	a large city in the distance... probably	city_art
929	city	116.084	38.686	Renqiu	a large city in the distance... probably	city_art
930	city	-96.0529	41.2627	Omaha	a large city in the distance... probably	city_art
931	city	113.476	29.827	Xindi	a large city in the distance... probably	city_art
932	city	114.204	36.697	Wu'an	a large city in the distance... probably	city_art
933	city	113.391	34.539	Qingping	a large city in the distance... probably	city_art
934	city	119.4432	32.7847	Gaoyou	a large city in the distance... probably	city_art
935	city	-46.55	-23.7	Sao Bernardo do Campo	a large city in the distance... probably	city_art
936	city	112.3999	26.4221	Yiyang	a large city in the distance... probably	city_art
937	city	116.0995	38.4466	Hejian	a large city in the distance... probably	city_art
938	city	114.735	35.2125	Puxi	a large city in the distance... probably	city_art
939	city	72.85	19.29	Bhayandar	a large city in the distance... probably	city_art
940	city	46.3	-24.1	Androtsy	a large city in the distance... probably	city_art
941	city	-107.3939	24.8069	Culiacan	a large city in the distance... probably	city_art
942	city	-72.5039	7.8942	Cucuta	a large city in the distance... probably	city_art
943	city	119.586	32	Danyang	a large city in the distance... probably	city_art
944	city	120.2167	29.2667	Dongyang	a large city in the distance... probably	city_art
945	city	19.9372	50.0614	Krakow	a large city in the distance... probably	city_art
946	city	121.0765	14.5605	Pasig City	a large city in the distance... probably	city_art
947	city	22.9347	40.6403	Thessaloniki	a large city in the distance... probably	city_art
948	city	-100.3928	20.5875	Queretaro	a large city in the distance... probably	city_art
949	city	-75.4375	2.8917	Palermo	a large city in the distance... probably	city_art
950	city	88.8833	29.25	Xigaze	a large city in the distance... probably	city_art
951	city	97.17	31.143	Qamdo	a large city in the distance... probably	city_art
952	city	-98.2467	26.2252	McAllen	a large city in the distance... probably	city_art
953	city	9.4542	0.3903	Libreville	a large city in the distance... probably	city_art
954	city	35.3328	36.9831	Seyhan	a large city in the distance... probably	city_art
955	city	-88.0333	15.5	San Pedro Sula	a large city in the distance... probably	city_art
956	city	139.0364	37.9161	Niigata	a large city in the distance... probably	city_art
957	city	-73.6089	40.6629	Hempstead	a large city in the distance... probably	city_art
958	city	-1.5436	53.7975	Leeds	a large city in the distance... probably	city_art
959	city	137.7275	34.7108	Hamamatsu	a large city in the distance... probably	city_art
960	city	11.8503	-4.7975	Pointe-Noire	a large city in the distance... probably	city_art
961	city	112.5502	27.7186	Xiangxiang	a large city in the distance... probably	city_art
962	city	-86.7971	33.5279	Birmingham	a large city in the distance... probably	city_art
963	city	117.8902	31.6244	Chaohucun	a large city in the distance... probably	city_art
964	city	126.7833	37.5	Bucheon	a large city in the distance... probably	city_art
965	city	13.5	-14.9167	Lubango	a large city in the distance... probably	city_art
966	city	36.7094	34.7308	Homs	a large city in the distance... probably	city_art
967	city	-2.9236	43.2569	Bilbao	a large city in the distance... probably	city_art
968	city	117.743	36.863	Zouping	a large city in the distance... probably	city_art
969	city	8.6822	50.1106	Frankfurt	a large city in the distance... probably	city_art
970	city	-100.9761	22.1511	San Luis Potosi	a large city in the distance... probably	city_art
971	city	100.2676	25.6065	Dali	a large city in the distance... probably	city_art
972	city	119.95	30.0553	Fuyang	a large city in the distance... probably	city_art
973	city	69.6333	40.2833	Khujand	a large city in the distance... probably	city_art
974	city	86.1746	41.7259	Korla	a large city in the distance... probably	city_art
975	city	-106.6465	35.1054	Albuquerque	a large city in the distance... probably	city_art
976	city	127.5333	39.9167	Hamhung	a large city in the distance... probably	city_art
977	city	41.2769	39.9086	Erzurum	a large city in the distance... probably	city_art
978	city	15.9775	45.8131	Zagreb	a large city in the distance... probably	city_art
979	city	55.7447	24.2075	Al `Ayn	a large city in the distance... probably	city_art
980	city	111.757	30.174	Songzi	a large city in the distance... probably	city_art
981	city	76.38	30.34	Patiala	a large city in the distance... probably	city_art
982	city	120.5333	36.8667	Laixi	a large city in the distance... probably	city_art
983	city	104.755	31.771	Zhongba	a large city in the distance... probably	city_art
984	city	71.6836	29.3956	Bahawalpur	a large city in the distance... probably	city_art
985	city	115.7061	36.8494	Qingnian	a large city in the distance... probably	city_art
986	city	7.4333	10.5167	Kaduna	a large city in the distance... probably	city_art
987	city	-97.1464	49.8844	Winnipeg	a large city in the distance... probably	city_art
988	city	39.7225	41.005	Trabzon	a large city in the distance... probably	city_art
989	city	113.826	31.617	Guangshui	a large city in the distance... probably	city_art
990	city	42.2833	2.3333	Baardheere	a large city in the distance... probably	city_art
991	city	79.32	28.72	Shishgarh	a large city in the distance... probably	city_art
992	city	139.6517	35.7356	Nerima	a large city in the distance... probably	city_art
993	city	106.3828	38.9846	Sizhan	a large city in the distance... probably	city_art
994	city	-62.65	8.3667	Ciudad Guayana	a large city in the distance... probably	city_art
995	city	-35.2	-5.7833	Natal	a large city in the distance... probably	city_art
996	city	108.9364	30.291	Lichuan	a large city in the distance... probably	city_art
997	city	119.4788	31.4306	Licheng	a large city in the distance... probably	city_art
998	city	-46.5333	-23.6572	Santo Andre	a large city in the distance... probably	city_art
999	city	139.7161	35.5614	Ota-ku	a large city in the distance... probably	city_art
1000	city	47.4308	6.7697	Gaalkacyo	a large city in the distance... probably	city_art
1001	city	76.9366	8.5241	Thiruvananthapuram	a large city in the distance... probably	city_art
1002	city	-46.7919	-23.5328	Osasco	a large city in the distance... probably	city_art
1003	city	39.2667	-15.1167	Nampula	a large city in the distance... probably	city_art
1004	city	28.1881	-25.7461	Pretoria	a large city in the distance... probably	city_art
1005	city	96.1303	21.6131	Kyaukse	a large city in the distance... probably	city_art
1006	city	113.8054	35.4623	Chengguan	a large city in the distance... probably	city_art
1007	city	124.8833	48.4833	Nehe	a large city in the distance... probably	city_art
1008	city	12.19	-5.56	Cabinda	a large city in the distance... probably	city_art
1009	city	130.7078	32.8031	Kumamoto	a large city in the distance... probably	city_art
1010	city	57.0678	30.2911	Kerman	a large city in the distance... probably	city_art
1011	city	117.966	40.189	Zunhua	a large city in the distance... probably	city_art
1012	city	45.0647	37.5439	Orumiyeh	a large city in the distance... probably	city_art
1013	city	110.6319	26.7266	Wugang	a large city in the distance... probably	city_art
1014	city	28.8564	41.0344	Bagcilar	a large city in the distance... probably	city_art
1015	city	-71.2081	46.8139	Quebec City	a large city in the distance... probably	city_art
1016	city	112.602	35.067	Shuangqiao	a large city in the distance... probably	city_art
1017	city	29.1081	41.0311	Umraniye	a large city in the distance... probably	city_art
1018	city	127.2167	37.6333	Yanggok	a large city in the distance... probably	city_art
1019	city	20.8	-6.4167	Tshikapa	a large city in the distance... probably	city_art
1020	city	-95.9042	36.1283	Tulsa	a large city in the distance... probably	city_art
1021	city	4.5667	7.7667	Osogbo	a large city in the distance... probably	city_art
1022	city	-67.4808	-45.8647	Comodoro Rivadavia	a large city in the distance... probably	city_art
1023	city	-1.1512	52.9561	Nottingham	a large city in the distance... probably	city_art
1024	city	-79.8692	43.2567	Hamilton	a large city in the distance... probably	city_art
1025	city	106.005	31.558	Langzhong	a large city in the distance... probably	city_art
1026	city	124.65	8.48	Cagayan de Oro	a large city in the distance... probably	city_art
1027	city	118.701	39.999	Qian'an	a large city in the distance... probably	city_art
1028	city	-119.7939	36.783	Fresno	a large city in the distance... probably	city_art
1029	city	44.33	32	An Najaf	a large city in the distance... probably	city_art
1030	city	111	22.9167	Cencheng	a large city in the distance... probably	city_art
1031	city	-47.4581	-23.5017	Sorocaba	a large city in the distance... probably	city_art
1032	city	120.0333	28.9	Guli	a large city in the distance... probably	city_art
1033	city	139.3667	35.5667	Sagamihara	a large city in the distance... probably	city_art
1034	city	59.9789	33.3886	Pishbar	a large city in the distance... probably	city_art
1035	city	133.9167	34.65	Okayama	a large city in the distance... probably	city_art
1036	city	113.6667	31.2667	Anlu	a large city in the distance... probably	city_art
1037	city	-73.0514	-36.8282	Concepcion	a large city in the distance... probably	city_art
1038	city	-79.65	43.6	Mississauga	a large city in the distance... probably	city_art
1039	city	112.6982	22.3773	Changsha	a large city in the distance... probably	city_art
1040	city	113.0253	34.4553	Songyang	a large city in the distance... probably	city_art
1041	city	24.0322	49.8425	Lviv	a large city in the distance... probably	city_art
1042	city	86.0804	44.3054	Shihezi	a large city in the distance... probably	city_art
1043	city	25.28	54.6872	Vilnius	a large city in the distance... probably	city_art
1044	city	44.7656	1.7133	Marka	a large city in the distance... probably	city_art
1045	city	7.5111	6.4528	Enugu	a large city in the distance... probably	city_art
1046	city	120.98	14.7	Valenzuela	a large city in the distance... probably	city_art
1047	city	122.4867	37.1653	Yatou	a large city in the distance... probably	city_art
1048	city	-48.2886	-18.9231	Uberlandia	a large city in the distance... probably	city_art
1049	city	102.2644	27.8944	Xichang	a large city in the distance... probably	city_art
1050	city	35.1175	47.85	Zaporizhzhia	a large city in the distance... probably	city_art
1051	city	73.0631	19.2967	Bhiwandi	a large city in the distance... probably	city_art
1052	city	100.3292	5.4144	George Town	a large city in the distance... probably	city_art
1053	city	-2.5975	51.4536	Bristol	a large city in the distance... probably	city_art
1054	city	-79.9687	32.8168	Charleston	a large city in the distance... probably	city_art
1055	city	77.546	29.964	Saharanpur	a large city in the distance... probably	city_art
1056	city	122.5167	40.6167	Dashiqiao	a large city in the distance... probably	city_art
1057	city	32.8119	39.9719	Yenimahalle	a large city in the distance... probably	city_art
1058	city	79.5941	17.9689	Warangal	a large city in the distance... probably	city_art
1059	city	125.4	38.7333	Nampo	a large city in the distance... probably	city_art
1060	city	120.94	14.33	Dasmarinas	a large city in the distance... probably	city_art
1061	city	-35.0014	-8.1803	Jaboatao	a large city in the distance... probably	city_art
1062	city	28.8353	47.0228	Chisinau	a large city in the distance... probably	city_art
1063	city	88.43	26.71	Shiliguri	a large city in the distance... probably	city_art
1064	city	49.1819	11.2886	Boosaaso	a large city in the distance... probably	city_art
1065	city	147.1494	-9.4789	Port Moresby	a large city in the distance... probably	city_art
1066	city	35.7833	35.5167	Latakia	a large city in the distance... probably	city_art
1067	city	-77.6162	43.168	Rochester	a large city in the distance... probably	city_art
1068	city	-47.8067	-21.1783	Ribeirao Preto	a large city in the distance... probably	city_art
1069	city	139.8833	35.7	Edogawa	a large city in the distance... probably	city_art
1070	city	-45.8869	-23.1789	Sao Jose dos Campos	a large city in the distance... probably	city_art
1071	city	125.17	6.12	General Santos	a large city in the distance... probably	city_art
1072	city	36.75	35.1333	Hamah	a large city in the distance... probably	city_art
1073	city	106.0323	27.0087	Qianxi	a large city in the distance... probably	city_art
1074	city	9.8442	10.3158	Bauchi	a large city in the distance... probably	city_art
1075	city	29.235	40.8747	Pendik	a large city in the distance... probably	city_art
1076	city	78.15	11.65	Salem	a large city in the distance... probably	city_art
1077	city	118.7	24.7167	Shishi	a large city in the distance... probably	city_art
1078	city	30.8667	29.4072	Sinnuris	a large city in the distance... probably	city_art
1079	city	-3.9667	5.35	Cocody	a large city in the distance... probably	city_art
1080	city	113.16	28.761	Miluo Chengguanzhen	a large city in the distance... probably	city_art
1081	city	6.7442	7.8019	Lokoja	a large city in the distance... probably	city_art
1082	city	-100.2597	25.6775	Guadalupe	a large city in the distance... probably	city_art
1083	city	122.35	40.4	Gaizhou	a large city in the distance... probably	city_art
1084	city	44.0333	32.6167	Karbala'	a large city in the distance... probably	city_art
1085	city	48.6147	31.6283	Borvayeh-ye Al Bu `Aziz	a large city in the distance... probably	city_art
1086	city	120.9915	14.5008	City of Paranaque	a large city in the distance... probably	city_art
1087	city	117.232	37.73	Leling	a large city in the distance... probably	city_art
1088	city	32.9231	39.9422	Mamak	a large city in the distance... probably	city_art
1089	city	113.7629	34.2137	Jianshe	a large city in the distance... probably	city_art
1090	city	49.4222	53.5089	Tolyatti	a large city in the distance... probably	city_art
1091	city	138.3828	34.9756	Shizuoka	a large city in the distance... probably	city_art
1092	city	120.263	32.009	Jingcheng	a large city in the distance... probably	city_art
1093	city	3.3258	6.6219	Agege	a large city in the distance... probably	city_art
1094	city	-57.55	-38	Mar del Plata	a large city in the distance... probably	city_art
1095	city	-0.8833	41.65	Zaragoza	a large city in the distance... probably	city_art
1096	city	139.8	35.7833	Adachi	a large city in the distance... probably	city_art
1097	city	122.823	41.997	Xinmin	a large city in the distance... probably	city_art
1098	city	49.5889	37.2744	Rasht	a large city in the distance... probably	city_art
1099	city	120.8167	29.6	Shanhu	a large city in the distance... probably	city_art
1100	city	106.4013	27.7919	Zhongshu	a large city in the distance... probably	city_art
1101	city	2.4333	6.3667	Cotonou	a large city in the distance... probably	city_art
1102	city	108.1975	-7.3161	Tasikmalaya	a large city in the distance... probably	city_art
1103	city	76.2673	9.9312	Kochi	a large city in the distance... probably	city_art
1104	city	-74.75	10.9167	Soledad	a large city in the distance... probably	city_art
1105	city	74.7697	20.8997	Dhulia	a large city in the distance... probably	city_art
1106	city	-99.8825	16.8636	Acapulco de Juarez	a large city in the distance... probably	city_art
1107	city	83.4039	26.7637	Gorakhpur	a large city in the distance... probably	city_art
1108	city	48.4425	34.9028	Bahar	a large city in the distance... probably	city_art
1109	city	93.5151	42.8193	Kumul	a large city in the distance... probably	city_art
1110	city	17.0325	51.11	Wroclaw	a large city in the distance... probably	city_art
1111	city	-1.1303	37.9861	Murcia	a large city in the distance... probably	city_art
1112	city	121.0104	30.7005	Pinghu	a large city in the distance... probably	city_art
1113	city	103.647	30.988	Guankou	a large city in the distance... probably	city_art
1114	city	19.4547	51.7769	Lodz	a large city in the distance... probably	city_art
1115	city	80.4428	16.3008	Guntur	a large city in the distance... probably	city_art
1116	city	88.42	22.58	Bhangar	a large city in the distance... probably	city_art
1117	city	-84.2003	39.7805	Dayton	a large city in the distance... probably	city_art
1118	city	129.7667	41.7833	Ch'ongjin	a large city in the distance... probably	city_art
1119	city	112.598	28.945	Qionghu	a large city in the distance... probably	city_art
1120	city	125.962	46.051	Zhaodong	a large city in the distance... probably	city_art
1121	city	114.98	35.7004	Puyang Chengguanzhen	a large city in the distance... probably	city_art
1122	city	28.58	-20.17	Bulawayo	a large city in the distance... probably	city_art
1123	city	15.7347	-12.7767	Huambo	a large city in the distance... probably	city_art
1124	city	-37.05	-10.9167	Aracaju	a large city in the distance... probably	city_art
1125	city	120.9645	14.4624	Bacoor	a large city in the distance... probably	city_art
1126	city	116.9507	31.054	Wenchang	a large city in the distance... probably	city_art
1127	city	4.48	51.92	Rotterdam	a large city in the distance... probably	city_art
1128	city	-103.3167	20.6167	Tlaquepaque	a large city in the distance... probably	city_art
1129	city	-73.6333	4.15	Villavicencio	a large city in the distance... probably	city_art
1130	city	126.9655	44.4059	Shulan	a large city in the distance... probably	city_art
1131	city	47.4833	42.9667	Makhachkala	a large city in the distance... probably	city_art
1132	city	114.5925	-3.32	Banjarmasin	a large city in the distance... probably	city_art
1133	city	77.0929	28.8527	Narela	a large city in the distance... probably	city_art
1134	city	-67.0333	10.6	Catia La Mar	a large city in the distance... probably	city_art
1135	city	49.5833	25.3833	Al Hufuf	a large city in the distance... probably	city_art
1136	city	11.3667	8.9	Jalingo	a large city in the distance... probably	city_art
1137	city	72.6711	32.0836	Sargodha	a large city in the distance... probably	city_art
1138	city	92.6143	24.8309	Karaikandi	a large city in the distance... probably	city_art
1139	city	-5.0167	7.6833	Bouake	a large city in the distance... probably	city_art
1140	city	110.8942	34.5176	Lingbao Chengguanzhen	a large city in the distance... probably	city_art
1141	city	-79.7667	43.6833	Brampton	a large city in the distance... probably	city_art
1142	city	2.3556	6.4486	Abomey-Calavi	a large city in the distance... probably	city_art
1143	city	-104.6675	24.025	Durango	a large city in the distance... probably	city_art
1144	city	-81.9957	26.6443	Cape Coral	a large city in the distance... probably	city_art
1145	city	120.967	14.617	Tondo	a large city in the distance... probably	city_art
1146	city	30.8167	27.5667	Dayrut	a large city in the distance... probably	city_art
1147	city	-99.1947	19.5367	Tlalnepantla	a large city in the distance... probably	city_art
1148	city	126.8333	37.3167	Ansan	a large city in the distance... probably	city_art
1149	city	103.8166	25.6005	Xiping	a large city in the distance... probably	city_art
1150	city	107.5792	16.4667	Hue	a large city in the distance... probably	city_art
1151	city	117.0833	40.0167	Sanhe	a large city in the distance... probably	city_art
1152	city	121.0453	14.8139	San Jose del Monte	a large city in the distance... probably	city_art
1153	city	127.1475	36.81	Ch'onan	a large city in the distance... probably	city_art
1154	city	-56.0969	-15.5958	Cuiaba	a large city in the distance... probably	city_art
1155	city	115.3746	33.257	Jieshou	a large city in the distance... probably	city_art
1156	city	41.3833	9.5667	Erer Sata	a large city in the distance... probably	city_art
1157	city	32.4922	37.8814	Selcuklu	a large city in the distance... probably	city_art
1158	city	113.35	34.7833	Suohe	a large city in the distance... probably	city_art
1159	city	117.2454	28.2925	Guixi	a large city in the distance... probably	city_art
1160	city	53.1833	56.8333	Izhevsk	a large city in the distance... probably	city_art
1161	city	139.9826	35.6946	Honcho	a large city in the distance... probably	city_art
1162	city	115.561	29.844	Wuxue	a large city in the distance... probably	city_art
1163	city	-35.0156	-8.1122	Jaboatao dos Guararapes	a large city in the distance... probably	city_art
1164	city	29.0821	40.11	Yildirim	a large city in the distance... probably	city_art
1165	city	72.15	21.76	Bhavnagar	a large city in the distance... probably	city_art
1166	city	100.797	22.009	Jinghong	a large city in the distance... probably	city_art
1167	city	98.4833	25.0167	Tengyue	a large city in the distance... probably	city_art
1168	city	-117.6551	33.6096	Mission Viejo	a large city in the distance... probably	city_art
1169	city	116.027	25.886	Ruiming	a large city in the distance... probably	city_art
1170	city	116.9862	35.5819	Qufu	a large city in the distance... probably	city_art
1171	city	114.1898	22.3802	Sha Tin	a large city in the distance... probably	city_art
1172	city	101.6444	3.0972	Petaling Jaya	a large city in the distance... probably	city_art
1173	city	-104.7605	38.8674	Colorado Springs	a large city in the distance... probably	city_art
1174	city	77.32	28.57	Noida	a large city in the distance... probably	city_art
1175	city	113.1167	31.1333	Xinshi	a large city in the distance... probably	city_art
1176	city	-91.1311	30.442	Baton Rouge	a large city in the distance... probably	city_art
1177	city	50.5775	26.225	Manama	a large city in the distance... probably	city_art
1178	city	-15.4353	28.1258	Las Palmas	a large city in the distance... probably	city_art
1179	city	73.85	31.0167	Chak Forty-one	a large city in the distance... probably	city_art
1180	city	105.2875	29.3394	Jin'e	a large city in the distance... probably	city_art
1181	city	20.0667	32.1167	Benghazi	a large city in the distance... probably	city_art
1182	city	101.5459	25.033	Chuxiong	a large city in the distance... probably	city_art
1183	city	83.7764	53.3486	Barnaul	a large city in the distance... probably	city_art
1184	city	13.3517	38.1111	Palermo	a large city in the distance... probably	city_art
1185	city	121.0214	14.5567	Makati City	a large city in the distance... probably	city_art
1186	city	6.7833	51.2333	Dusseldorf	a large city in the distance... probably	city_art
1187	city	-75.4756	40.5961	Allentown	a large city in the distance... probably	city_art
1188	city	124.15	39.8667	Xinxing	a large city in the distance... probably	city_art
1189	city	31.2007	30.3539	Tukh	a large city in the distance... probably	city_art
1190	city	-4.25	55.8611	Glasgow	a large city in the distance... probably	city_art
1191	city	71.6683	41.0011	Namangan	a large city in the distance... probably	city_art
1192	city	26.16	50.6765	Bazal'tove	a large city in the distance... probably	city_art
1193	city	49.996	26.556	Al Qatif	a large city in the distance... probably	city_art
1194	city	81.38	21.21	Bhilai	a large city in the distance... probably	city_art
1195	city	48.3667	54.3167	Ulyanovsk	a large city in the distance... probably	city_art
1196	city	74.8425	12.8681	Mangalore	a large city in the distance... probably	city_art
1197	city	104.233	23.387	Kaihua	a large city in the distance... probably	city_art
1198	city	104.2833	52.2833	Irkutsk	a large city in the distance... probably	city_art
1199	city	110.403	19.999	Meilan	a large city in the distance... probably	city_art
1200	city	116.3833	39.1333	Bazhou	a large city in the distance... probably	city_art
1201	city	-111.9682	41.2279	Ogden	a large city in the distance... probably	city_art
1202	city	89.1895	42.9512	Turpan	a large city in the distance... probably	city_art
1203	city	8.8903	9.9167	Jos	a large city in the distance... probably	city_art
1204	city	31.3833	31.05	Al Mansurah	a large city in the distance... probably	city_art
1205	city	-44.0539	-19.9319	Contagem	a large city in the distance... probably	city_art
1206	city	103.61	-1.59	Jambi	a large city in the distance... probably	city_art
1207	city	31.3333	29.8453	Halwan	a large city in the distance... probably	city_art
1208	city	-111.6457	40.2457	Provo	a large city in the distance... probably	city_art
1209	city	106.6994	10.905	Tan An	a large city in the distance... probably	city_art
1210	city	-3.9	5.2667	Port-Bouet	a large city in the distance... probably	city_art
1211	city	109.3414	-0.0206	Pontianak	a large city in the distance... probably	city_art
1212	city	125.7107	42.5407	Meihekou	a large city in the distance... probably	city_art
1213	city	119.164	31.946	Jurong	a large city in the distance... probably	city_art
1214	city	84.87	25.5619	Bihta	a large city in the distance... probably	city_art
1215	city	121.2288	28.1277	Yuhuan	a large city in the distance... probably	city_art
1216	city	-48.8437	-26.3204	Joinvile	a large city in the distance... probably	city_art
1217	city	-38.95	-12.25	Feira de Santana	a large city in the distance... probably	city_art
1218	city	135.0833	48.4833	Khabarovsk	a large city in the distance... probably	city_art
1219	city	12.375	51.34	Leipzig	a large city in the distance... probably	city_art
1220	city	115.218	37.943	Xinji	a large city in the distance... probably	city_art
1221	city	-83.9496	35.9692	Knoxville	a large city in the distance... probably	city_art
1222	city	44.0219	13.5789	Ta`izz	a large city in the distance... probably	city_art
1223	city	32.6694	39.9458	Etimesgut	a large city in the distance... probably	city_art
1224	city	116.1944	40.2248	Changping	a large city in the distance... probably	city_art
1225	city	24.7453	59.4372	Tallinn	a large city in the distance... probably	city_art
1226	city	-98.9	19.4167	Chimalhuacan	a large city in the distance... probably	city_art
1227	city	65.7158	31.62	Kandahar	a large city in the distance... probably	city_art
1228	city	106.1503	-6.12	Serang	a large city in the distance... probably	city_art
1229	city	115.5462	28.0546	Zhangshu	a large city in the distance... probably	city_art
1230	city	-85.6562	42.9619	Grand Rapids	a large city in the distance... probably	city_art
1231	city	30.6833	36.9167	Yukarikaraman	a large city in the distance... probably	city_art
1232	city	11.9675	57.7075	Gothenburg	a large city in the distance... probably	city_art
1233	city	103.3333	3.8167	Kuantan	a large city in the distance... probably	city_art
1234	city	153.4	-28.0167	Gold Coast	a large city in the distance... probably	city_art
1235	city	139.7241	35.8077	Kawaguchi	a large city in the distance... probably	city_art
1236	city	120.98	14.45	Las Pinas City	a large city in the distance... probably	city_art
1237	city	85.7881	20.5236	Cuttack	a large city in the distance... probably	city_art
1238	city	-65.2167	-26.8167	San Miguel de Tucuman	a large city in the distance... probably	city_art
1239	city	51.4	25.25	Ar Rayyan	a large city in the distance... probably	city_art
1240	city	83.9167	26.3	Salimpur	a large city in the distance... probably	city_art
1241	city	16.35	-9.5333	Malanje	a large city in the distance... probably	city_art
1242	city	-80.9036	34.0378	Columbia	a large city in the distance... probably	city_art
1243	city	33.39	47.91	Kryvyi Rih	a large city in the distance... probably	city_art
1244	city	43.145	11.5883	Djibouti	a large city in the distance... probably	city_art
1245	city	115.974	39.485	Zhuozhou	a large city in the distance... probably	city_art
1246	city	119.0137	32.6811	Tianchang	a large city in the distance... probably	city_art
1247	city	10.1817	36.8064	Tunis	a large city in the distance... probably	city_art
1248	city	39.85	57.6167	Yaroslavl	a large city in the distance... probably	city_art
1249	city	122.9509	10.6765	Bacolod	a large city in the distance... probably	city_art
1250	city	13.4	9.3	Garoua	a large city in the distance... probably	city_art
1251	city	10.4167	5.4667	Bafoussam	a large city in the distance... probably	city_art
1252	city	34.9992	32.8192	Haifa	a large city in the distance... probably	city_art
1253	city	84.8828	22.2492	Raurkela	a large city in the distance... probably	city_art
1254	city	77.1	13.34	Tumkur	a large city in the distance... probably	city_art
1255	city	116.8277	-1.2768	Balikpapan	a large city in the distance... probably	city_art
1256	city	3.3872	6.5408	Somolu	a large city in the distance... probably	city_art
1257	city	131.9	43.1333	Vladivostok	a large city in the distance... probably	city_art
1258	city	46.7564	23.4895	Al Hillah	a large city in the distance... probably	city_art
1259	city	35.5	38.7167	Melikgazi	a large city in the distance... probably	city_art
1260	city	130.55	31.6	Kagoshima	a large city in the distance... probably	city_art
1261	city	112.7338	23.3265	Sihui	a large city in the distance... probably	city_art
1262	city	7.4653	51.5139	Dortmund	a large city in the distance... probably	city_art
1263	city	-101.35	20.6667	Irapuato	a large city in the distance... probably	city_art
1264	city	31.1636	30.9686	Al Mahallah al Kubra	a large city in the distance... probably	city_art
1265	city	74.5311	32.4925	Sialkot City	a large city in the distance... probably	city_art
1266	city	104.25	30.99	Luocheng	a large city in the distance... probably	city_art
1267	city	-73.7987	42.6664	Albany	a large city in the distance... probably	city_art
1268	city	-75.6946	4.8143	Pereira	a large city in the distance... probably	city_art
1269	city	34.456	31.5069	Gaza	a large city in the distance... probably	city_art
1270	city	29.15	-3.4	Uvira	a large city in the distance... probably	city_art
1271	city	-98.2778	26.0922	Reynosa	a large city in the distance... probably	city_art
1272	city	60.8558	29.5025	Zahedan	a large city in the distance... probably	city_art
1273	city	107.5548	-6.8712	Cimahi	a large city in the distance... probably	city_art
1274	city	34.175	1.0806	Mbale	a large city in the distance... probably	city_art
1275	city	103.3649	23.3961	Wenlan	a large city in the distance... probably	city_art
1276	city	127.962	45.2116	Shangzhi	a large city in the distance... probably	city_art
1277	city	7.0131	51.4508	Essen	a large city in the distance... probably	city_art
1278	city	139.6833	35.7667	Itabashi	a large city in the distance... probably	city_art
1279	city	101.5167	3.0722	Shah Alam	a large city in the distance... probably	city_art
1280	city	116.5833	38.0833	Botou	a large city in the distance... probably	city_art
1281	city	139.6364	35.6994	Suginami-ku	a large city in the distance... probably	city_art
1282	city	77.3152	8.9564	Tenkasi	a large city in the distance... probably	city_art
1283	city	-76.7931	17.9714	Kingston	a large city in the distance... probably	city_art
1284	city	36.2052	32.3399	Al Mafraq	a large city in the distance... probably	city_art
1285	city	40.4062	21.2751	At Ta'if	a large city in the distance... probably	city_art
1286	city	37.2167	19.6167	Port Sudan	a large city in the distance... probably	city_art
1287	city	-93.1167	16.7528	Tuxtla	a large city in the distance... probably	city_art
1288	city	78.029	30.345	Dehra Dun	a large city in the distance... probably	city_art
1289	city	112.4254	29.7209	Xiulin	a large city in the distance... probably	city_art
1290	city	119.6333	27.1	Fu'an	a large city in the distance... probably	city_art
1291	city	90.4031	24.7539	Mymensingh	a large city in the distance... probably	city_art
1292	city	139.316	35.6664	Hachioji	a large city in the distance... probably	city_art
1293	city	122.57	10.72	Iloilo	a large city in the distance... probably	city_art
1294	city	-70.5667	-33.6167	Puente Alto	a large city in the distance... probably	city_art
1295	city	84.9667	56.5	Tomsk	a large city in the distance... probably	city_art
1296	city	-6.8416	34.0209	Rabat	a large city in the distance... probably	city_art
1297	city	32.5767	39.9594	Sincan	a large city in the distance... probably	city_art
1298	city	-119.0359	35.3529	Bakersfield	a large city in the distance... probably	city_art
1299	city	76.5222	9.5916	Kottayam	a large city in the distance... probably	city_art
1300	city	120.396	37.359	Luofeng	a large city in the distance... probably	city_art
1301	city	31.3214	30.3133	Shibin al Qanatir	a large city in the distance... probably	city_art
1302	city	36.0667	-0.3	Nakuru	a large city in the distance... probably	city_art
1303	city	119.4	41.25	Lingyuan	a large city in the distance... probably	city_art
1304	city	-103.2333	20.6167	Tonala	a large city in the distance... probably	city_art
1305	city	8.8072	53.0758	Bremen	a large city in the distance... probably	city_art
1306	city	30.3128	31.1006	Abu Hummus	a large city in the distance... probably	city_art
1307	city	35.85	32.55	Irbid	a large city in the distance... probably	city_art
1308	city	113.5461	22.2006	Macau	a large city in the distance... probably	city_art
1309	city	-122.8489	49.19	Surrey	a large city in the distance... probably	city_art
1310	city	-63.55	8.1219	Ciudad Bolivar	a large city in the distance... probably	city_art
1311	city	87.32	23.55	Durgapur	a large city in the distance... probably	city_art
1312	city	115.56	38.002	Shenzhou	a large city in the distance... probably	city_art
1313	city	-72.9246	41.3113	New Haven	a large city in the distance... probably	city_art
1314	city	55.1	51.7833	Orenburg	a large city in the distance... probably	city_art
1315	city	119.4	36.8667	Kuiju	a large city in the distance... probably	city_art
1316	city	119.1848	32.2723	Zhenzhou	a large city in the distance... probably	city_art
1317	city	86.99	23.68	Asansol	a large city in the distance... probably	city_art
1318	city	86.15	23.67	Bokaro Steel City	a large city in the distance... probably	city_art
1319	city	13.74	51.05	Dresden	a large city in the distance... probably	city_art
1320	city	-75.5667	6.3333	Bello	a large city in the distance... probably	city_art
1321	city	74.2333	16.6917	Kolhapur	a large city in the distance... probably	city_art
1322	city	110.7551	19.617	Wencheng	a large city in the distance... probably	city_art
1323	city	119.458	29.208	Lanxi	a large city in the distance... probably	city_art
1324	city	111.789	30.821	Dangyang	a large city in the distance... probably	city_art
1325	city	81.787	21.161	Nava Raipur	a large city in the distance... probably	city_art
1326	city	86.0667	55.3667	Kemerovo	a large city in the distance... probably	city_art
1327	city	8.9328	44.4111	Genoa	a large city in the distance... probably	city_art
1328	city	62.2031	34.3419	Herat	a large city in the distance... probably	city_art
1329	city	-51.1628	-23.31	Londrina	a large city in the distance... probably	city_art
1330	city	-99.25	19.65	Cuautitlan Izcalli	a large city in the distance... probably	city_art
1331	city	7.9275	5.0333	Uyo	a large city in the distance... probably	city_art
1332	city	48.5161	34.8064	Hamadan	a large city in the distance... probably	city_art
1333	city	118.704	39.741	Luanzhou	a large city in the distance... probably	city_art
1334	city	-79.8366	-6.763	Chiclayo	a large city in the distance... probably	city_art
1335	city	110.8167	-7.5667	Surakarta	a large city in the distance... probably	city_art
1336	city	87.1333	53.7667	Novokuznetsk	a large city in the distance... probably	city_art
1337	city	74.6399	26.4499	Ajmer	a large city in the distance... probably	city_art
1338	city	128.8811	35.2342	Kimhae	a large city in the distance... probably	city_art
1339	city	77.3	19.15	Nanded	a large city in the distance... probably	city_art
1340	city	106.794	39.655	Wuhai	a large city in the distance... probably	city_art
1341	city	2.65	39.5667	Palma	a large city in the distance... probably	city_art
1342	city	27.2428	-25.6667	Rustenburg	a large city in the distance... probably	city_art
1343	city	77.7647	20.9258	Amravati	a large city in the distance... probably	city_art
1344	city	-93.6105	41.5725	Des Moines	a large city in the distance... probably	city_art
1345	city	-9.15	38.7253	Lisbon	a large city in the distance... probably	city_art
1346	city	129.5	42.9	Yanji	a large city in the distance... probably	city_art
1347	city	117.33	38.372	Huanghua	a large city in the distance... probably	city_art
1348	city	42.9511	14.8022	Al Hudaydah	a large city in the distance... probably	city_art
1349	city	126.9333	37.3833	Anyang	a large city in the distance... probably	city_art
1350	city	4.31	52.08	The Hague	a large city in the distance... probably	city_art
1351	city	72.3333	40.7833	Andijon	a large city in the distance... probably	city_art
1352	city	-2.2452	53.479	Manchester	a large city in the distance... probably	city_art
1353	city	79.99	14.45	Nellore	a large city in the distance... probably	city_art
1354	city	16.9336	52.4083	Poznan	a large city in the distance... probably	city_art
1355	city	66.9758	39.6547	Samarkand	a large city in the distance... probably	city_art
1356	city	120.7333	40.6167	Xingcheng	a large city in the distance... probably	city_art
1357	city	110.4	18.8	Wancheng	a large city in the distance... probably	city_art
1358	city	124.038	42.546	Kaiyuan	a large city in the distance... probably	city_art
1359	city	9.7167	52.3667	Hannover	a large city in the distance... probably	city_art
1360	city	100.5	5.65	Sungai Petani	a large city in the distance... probably	city_art
1361	city	-73.25	10.4833	Valledupar	a large city in the distance... probably	city_art
1362	city	124.0667	40.45	Fengcheng	a large city in the distance... probably	city_art
1363	city	121.05	14.38	Muntinlupa City	a large city in the distance... probably	city_art
1364	city	81.35	43.9	Ghulja	a large city in the distance... probably	city_art
1365	city	-98.8822	19.3186	Ixtapaluca	a large city in the distance... probably	city_art
1366	city	120.2	27.2	Fuding	a large city in the distance... probably	city_art
1367	city	-97.5042	25.8797	Heroica Matamoros	a large city in the distance... probably	city_art
1368	city	-81.5219	41.0798	Akron	a large city in the distance... probably	city_art
1369	city	33.45	-8.9	Mbeya	a large city in the distance... probably	city_art
1370	city	46.2575	31.0439	An Nasiriyah	a large city in the distance... probably	city_art
1371	city	108.4905	34.2995	Xiangyang	a large city in the distance... probably	city_art
1372	city	-75.2333	4.4333	Ibague	a large city in the distance... probably	city_art
1373	city	44.4314	32.4775	Al Hillah	a large city in the distance... probably	city_art
1374	city	-43.3494	-21.7619	Juiz de Fora	a large city in the distance... probably	city_art
1375	city	121.17	14.22	City of Calamba	a large city in the distance... probably	city_art
1376	city	22.45	13.45	El Geneina	a large city in the distance... probably	city_art
1377	city	-16.25	28.4667	Santa Cruz	a large city in the distance... probably	city_art
1378	city	39.7425	54.63	Ryazan	a large city in the distance... probably	city_art
1379	city	113.4504	29.4768	Chang'an	a large city in the distance... probably	city_art
1380	city	-48.4853	-27.6122	Florianopolis	a large city in the distance... probably	city_art
1381	city	28.95	40.2833	Nilufer	a large city in the distance... probably	city_art
1382	city	4.4003	51.2178	Antwerp	a large city in the distance... probably	city_art
1383	city	36.4	15.45	Kassala	a large city in the distance... probably	city_art
1384	city	80.2904	41.185	Aksu	a large city in the distance... probably	city_art
1385	city	-65.4167	-24.7833	Salta	a large city in the distance... probably	city_art
1386	city	91.7925	26.1397	Dispur	a large city in the distance... probably	city_art
1387	city	-80.6593	27.9631	Palm Bay	a large city in the distance... probably	city_art
1388	city	52.3167	55.6833	Naberezhnyye Chelny	a large city in the distance... probably	city_art
1389	city	76.825	17.329	Gulbarga	a large city in the distance... probably	city_art
1390	city	32.5286	0.3639	Nansana	a large city in the distance... probably	city_art
1391	city	117.9667	32.7833	Mingguang	a large city in the distance... probably	city_art
1392	city	-122.0016	37.9722	Concord	a large city in the distance... probably	city_art
1393	city	34.85	-19.8333	Beira	a large city in the distance... probably	city_art
1394	city	54.3397	31.8822	Yazd	a large city in the distance... probably	city_art
1395	city	48.29	38.2425	Ardabil	a large city in the distance... probably	city_art
1396	city	-15.8833	14.8667	Touba	a large city in the distance... probably	city_art
1397	city	73.3169	28.0181	Bikaner	a large city in the distance... probably	city_art
1398	city	115.874	39.327	Gaobeidian	a large city in the distance... probably	city_art
1399	city	28.6325	-12.9689	Ndola	a large city in the distance... probably	city_art
1400	city	134.6833	34.8167	Himeji	a large city in the distance... probably	city_art
1401	city	81.2777	43.908	Ailan Mubage	a large city in the distance... probably	city_art
1402	city	56.2878	27.1961	Bandar `Abbas	a large city in the distance... probably	city_art
1403	city	21.4317	41.9961	Skopje	a large city in the distance... probably	city_art
1404	city	-66.6639	10.2333	Santa Teresa del Tuy	a large city in the distance... probably	city_art
1405	city	32.3061	31.2625	Port Said	a large city in the distance... probably	city_art
1406	city	48.035	46.35	Astrakhan	a large city in the distance... probably	city_art
1407	city	139.8167	35.6667	Koto-ku	a large city in the distance... probably	city_art
1408	city	-100.1886	25.7817	Ciudad Apodaca	a large city in the distance... probably	city_art
1409	city	-75.8833	8.75	Monteria	a large city in the distance... probably	city_art
1410	city	11.0775	49.4539	Nuremberg	a large city in the distance... probably	city_art
1411	city	-80.4728	43.4186	Kitchener	a large city in the distance... probably	city_art
1412	city	116.638	36.934	Yucheng	a large city in the distance... probably	city_art
1413	city	77.4306	8.175	Nagercoil	a large city in the distance... probably	city_art
1414	city	91.2869	23.8314	Agartala	a large city in the distance... probably	city_art
1415	city	-74.2214	4.5872	Soacha	a large city in the distance... probably	city_art
1416	city	27.1667	38.35	Buca	a large city in the distance... probably	city_art
1417	city	4.84	45.76	Lyon	a large city in the distance... probably	city_art
1418	city	-70.7667	-33.5167	Maipu	a large city in the distance... probably	city_art
1419	city	49.6933	34.0914	Arak	a large city in the distance... probably	city_art
1420	city	-40.3078	-20.1289	Serra	a large city in the distance... probably	city_art
1421	city	-99.1694	19.645	Tultitlan de Mariano Escobedo	a large city in the distance... probably	city_art
1422	city	-5.5547	33.895	Meknes	a large city in the distance... probably	city_art
1423	city	106.05	21.1833	Bac Ninh	a large city in the distance... probably	city_art
1424	city	125.352	46.424	Anda	a large city in the distance... probably	city_art
1425	city	112.23	30.32	Longzhou	a large city in the distance... probably	city_art
1426	city	30.8441	29.3084	Al Fayyum	a large city in the distance... probably	city_art
1427	city	139.8826	36.5551	Utsunomiya	a large city in the distance... probably	city_art
1428	city	-1.4703	53.3808	Sheffield	a large city in the distance... probably	city_art
1429	city	-90.6064	14.6331	Mixco	a large city in the distance... probably	city_art
1430	city	32.55	29.9667	Suez	a large city in the distance... probably	city_art
1431	city	112.95	22.7667	Heshan	a large city in the distance... probably	city_art
1432	city	45	53.2	Penza	a large city in the distance... probably	city_art
1433	city	77.28	28.75	Loni	a large city in the distance... probably	city_art
1434	city	110.4642	19.2431	Jiaji	a large city in the distance... probably	city_art
1435	city	-74.2053	11.2419	Santa Marta	a large city in the distance... probably	city_art
1436	city	75.79	23.17	Ujjain	a large city in the distance... probably	city_art
1437	city	121.8	41.6	Beining	a large city in the distance... probably	city_art
1438	city	32.0953	26.1183	Abu Tisht	a large city in the distance... probably	city_art
1439	city	-63.183	9.75	Maturin	a large city in the distance... probably	city_art
1440	city	-2.9785	53.4094	Liverpool	a large city in the distance... probably	city_art
1441	city	-51.05	0.033	Macapa	a large city in the distance... probably	city_art
1442	city	13.4167	-12.55	Benguela	a large city in the distance... probably	city_art
1443	city	112.257	31.721	Yicheng	a large city in the distance... probably	city_art
1444	city	30.8992	28.8227	Al Fashn	a large city in the distance... probably	city_art
1445	city	47.15	31.8333	Al `Amarah	a large city in the distance... probably	city_art
1446	city	-72.4094	18.5344	Carrefour	a large city in the distance... probably	city_art
1447	city	-41.3239	-21.7539	Campos	a large city in the distance... probably	city_art
1448	city	46.6256	6.1403	Cadaado	a large city in the distance... probably	city_art
1449	city	112.3	22.1833	Encheng	a large city in the distance... probably	city_art
1450	city	74.63	25.35	Bhilwara	a large city in the distance... probably	city_art
1451	city	30.9844	28.9218	Biba	a large city in the distance... probably	city_art
1452	city	-97.3443	37.6895	Wichita	a large city in the distance... probably	city_art
1453	city	-1.1319	52.6344	Leicester	a large city in the distance... probably	city_art
1454	city	29.9328	-27.7464	Newcastle	a large city in the distance... probably	city_art
1455	city	106.3306	20.9397	Hai Duong	a large city in the distance... probably	city_art
1456	city	45.0333	12.8	Aden	a large city in the distance... probably	city_art
1457	city	78.5696	25.4486	Jhansi	a large city in the distance... probably	city_art
1458	city	132.7667	33.8333	Matsuyama	a large city in the distance... probably	city_art
1459	city	73.15	19.22	Ulhasnagar	a large city in the distance... probably	city_art
1460	city	92.051	31.476	Nagqu	a large city in the distance... probably	city_art
1461	city	28.2	-12.8167	Kitwe	a large city in the distance... probably	city_art
1462	city	79.1325	12.9165	Vellore	a large city in the distance... probably	city_art
1463	city	1.444	43.6045	Toulouse	a large city in the distance... probably	city_art
1464	city	129.365	36.0322	Pohang	a large city in the distance... probably	city_art
1465	city	-111.7178	33.4015	Mesa	a large city in the distance... probably	city_art
1466	city	39.6	52.6167	Lipetsk	a large city in the distance... probably	city_art
1467	city	6.7625	51.4347	Duisburg	a large city in the distance... probably	city_art
1468	city	74.87	32.73	Jammu	a large city in the distance... probably	city_art
1469	city	4.5667	7.4667	Ile-Ife	a large city in the distance... probably	city_art
1470	city	30.9842	52.4453	Homyel'	a large city in the distance... probably	city_art
1471	city	49.6833	58.6	Kirov	a large city in the distance... probably	city_art
1472	city	-106.4167	23.2167	Mazatlan	a large city in the distance... probably	city_art
1473	city	116.581	30.631	Meicheng	a large city in the distance... probably	city_art
1474	city	25.35	13.6306	El Fasher	a large city in the distance... probably	city_art
1475	city	62.1194	32.3436	Farah	a large city in the distance... probably	city_art
1476	city	13.265	-8.9983	Belas	a large city in the distance... probably	city_art
1477	city	13.1833	-8.9167	Talatona	a large city in the distance... probably	city_art
1478	city	125.13	49.11	Nenjiang	a large city in the distance... probably	city_art
1479	city	68.8483	27.7061	Sukkur	a large city in the distance... probably	city_art
1480	city	120.9833	24.8167	Hsinchu	a large city in the distance... probably	city_art
1481	city	-76.8843	40.2752	Harrisburg	a large city in the distance... probably	city_art
1482	city	20.4531	54.7003	Kaliningrad	a large city in the distance... probably	city_art
1483	city	109.819	27.191	Hongjiang	a large city in the distance... probably	city_art
1484	city	73.1056	49.8028	Qaraghandy	a large city in the distance... probably	city_art
1485	city	123.9488	10.3127	Lapu-Lapu City	a large city in the distance... probably	city_art
1486	city	139.9032	35.7876	Matsudo	a large city in the distance... probably	city_art
1487	city	103.7611	1.4556	Johor Bahru	a large city in the distance... probably	city_art
1488	city	87.476	25.778	Purnea	a large city in the distance... probably	city_art
1489	city	120.9367	14.4297	Imus	a large city in the distance... probably	city_art
1490	city	-43.1036	-22.8833	Niteroi	a large city in the distance... probably	city_art
1491	city	120.771	41.801	Beipiao	a large city in the distance... probably	city_art
1492	city	123.3333	41.4333	Dengtacun	a large city in the distance... probably	city_art
1493	city	111.761	30.426	Zhijiang	a large city in the distance... probably	city_art
1494	city	124.8432	45.2279	Suoluntun	a large city in the distance... probably	city_art
1495	city	-74.1496	40.5834	Staten Island	a large city in the distance... probably	city_art
1496	city	114.0649	35.3984	Chengjiao	a large city in the distance... probably	city_art
1497	city	116.351	-8.565	Lembok	a large city in the distance... probably	city_art
1498	city	26.7333	-10.9833	Likasi	a large city in the distance... probably	city_art
1499	city	-1.9114	34.6867	Oujda-Angad	a large city in the distance... probably	city_art
1500	city	107.5186	26.2594	Duyun	a large city in the distance... probably	city_art
1501	city	-83.5827	41.6638	Toledo	a large city in the distance... probably	city_art
1502	city	73.2761	31.8958	Pindi Bhattian	a large city in the distance... probably	city_art
1503	city	24.8833	12.05	Nyala	a large city in the distance... probably	city_art
1504	city	-15.5667	11.85	Bissau	a large city in the distance... probably	city_art
1505	city	139.9311	35.7219	Ichikawa	a large city in the distance... probably	city_art
1506	city	102.25	6.1333	Kota Bharu	a large city in the distance... probably	city_art
1507	city	112.711	38.731	Yuanping	a large city in the distance... probably	city_art
1508	city	135.6008	34.6794	Higashi-osaka	a large city in the distance... probably	city_art
1509	city	68.2111	27.5583	Larkana	a large city in the distance... probably	city_art
1510	city	55.4456	25.4136	`Ajman	a large city in the distance... probably	city_art
1511	city	105.6667	18.6667	Vinh	a large city in the distance... probably	city_art
1512	city	-99.2833	19.55	Ciudad Lopez Mateos	a large city in the distance... probably	city_art
1513	city	47.2333	56.15	Cheboksary	a large city in the distance... probably	city_art
1514	city	120.96	28.12	Yueqing	a large city in the distance... probably	city_art
1515	city	74.5	15.85	Belgaum	a large city in the distance... probably	city_art
1516	city	-3.1833	51.4833	Caerdydd	a large city in the distance... probably	city_art
1517	city	-3.1892	55.9533	Edinburgh	a large city in the distance... probably	city_art
1518	city	-72.9517	40.832	Brookhaven	a large city in the distance... probably	city_art
1519	city	135.3416	34.7376	Nishinomiya-hama	a large city in the distance... probably	city_art
1520	city	84.8892	45.5799	Karamay	a large city in the distance... probably	city_art
1521	city	-71.8079	42.2705	Worcester	a large city in the distance... probably	city_art
1522	city	135.6008	34.6794	Kawachicho	a large city in the distance... probably	city_art
1523	city	114.5033	36.8549	Shahe	a large city in the distance... probably	city_art
1524	city	18.6453	54.3475	Gdansk	a large city in the distance... probably	city_art
1525	city	33.5225	44.605	Sevastopol	a large city in the distance... probably	city_art
1526	city	48.4667	8.4	Garoowe	a large city in the distance... probably	city_art
1527	city	112.924	35.798	Gaoping	a large city in the distance... probably	city_art
1528	city	-90.5875	14.5269	Villa Nueva	a large city in the distance... probably	city_art
1529	city	128.2333	43.3667	Dunhua	a large city in the distance... probably	city_art
1530	city	102.478	24.919	Lianran	a large city in the distance... probably	city_art
1531	city	31.75	26.5667	Akhmim	a large city in the distance... probably	city_art
1532	city	38.7917	37.1583	Sanliurfa	a large city in the distance... probably	city_art
1533	city	36.1	32.0833	Az Zarqa'	a large city in the distance... probably	city_art
1534	city	74.55	20.55	Malegaon	a large city in the distance... probably	city_art
1535	city	-49.3811	-20.8081	Sao Jose do Rio Preto	a large city in the distance... probably	city_art
1536	city	14.5125	35.8983	Valletta	a large city in the distance... probably	city_art
1537	city	25.4667	-10.7167	Kolwezi	a large city in the distance... probably	city_art
1538	city	70.07	22.47	Jamnagar	a large city in the distance... probably	city_art
1539	city	91.8667	24.9	Sylhet	a large city in the distance... probably	city_art
1540	city	-48.3719	-1.3658	Ananindeua	a large city in the distance... probably	city_art
1541	city	27.9047	-33.0175	East London	a large city in the distance... probably	city_art
1542	city	45.0164	10.4356	Berbera	a large city in the distance... probably	city_art
1543	city	104.2	31.3333	Jiannan	a large city in the distance... probably	city_art
1544	city	72.9842	31.7194	Chiniot	a large city in the distance... probably	city_art
1545	city	-57.6333	-25.3	Asuncion	a large city in the distance... probably	city_art
1546	city	131.6067	33.2333	Oita	a large city in the distance... probably	city_art
1547	city	115.409	37.359	Nangong	a large city in the distance... probably	city_art
1548	city	73.12	21.12	Bardoli	a large city in the distance... probably	city_art
1549	city	35.2833	0.5167	Eldoret	a large city in the distance... probably	city_art
1550	city	17.1097	48.1439	Bratislava	a large city in the distance... probably	city_art
1551	city	133.7722	34.585	Kurashiki	a large city in the distance... probably	city_art
1552	city	49.6544	27	Al Jubayl	a large city in the distance... probably	city_art
1553	city	-0.3714	50.8147	Worthing	a large city in the distance... probably	city_art
1554	city	85.01	24.75	Gaya	a large city in the distance... probably	city_art
1555	city	73.9878	31.7111	Shekhupura	a large city in the distance... probably	city_art
1556	city	-80.6333	-5.2	Piura	a large city in the distance... probably	city_art
1557	city	-40.2936	-20.3364	Vila Velha	a large city in the distance... probably	city_art
1558	city	36.0464	32.0178	Ar Rusayfah	a large city in the distance... probably	city_art
1559	city	121.45	28.6804	Jiaojiangcun	a large city in the distance... probably	city_art
1560	city	111.684	32.359	Laohekou	a large city in the distance... probably	city_art
1561	city	-68.5261	-31.5342	San Juan	a large city in the distance... probably	city_art
1562	city	31.995	46.975	Mykolaiv	a large city in the distance... probably	city_art
1563	city	126.5167	48.25	Beian	a large city in the distance... probably	city_art
1564	city	132.0333	47.25	Fujin	a large city in the distance... probably	city_art
1565	city	28.8	41	Kucukcekmece	a large city in the distance... probably	city_art
1566	city	67.1167	36.7	Mazar-e Sharif	a large city in the distance... probably	city_art
1567	city	111.5167	36.0833	Xiaoyi	a large city in the distance... probably	city_art
1568	city	37.9667	55.8167	Balashikha	a large city in the distance... probably	city_art
1569	city	106.4687	26.5704	Qingzhen	a large city in the distance... probably	city_art
1570	city	37.6167	54.2	Tula	a large city in the distance... probably	city_art
1571	city	44.6333	33.75	Ba`qubah	a large city in the distance... probably	city_art
1572	city	28.15	-26.3333	Katlehong	a large city in the distance... probably	city_art
1573	city	118.625	28.7361	Jiangshan	a large city in the distance... probably	city_art
1574	city	43.9667	26.3333	Buraydah	a large city in the distance... probably	city_art
1575	city	66.2597	28.4925	Surab	a large city in the distance... probably	city_art
1576	city	123.6077	-10.1702	Kupang	a large city in the distance... probably	city_art
1577	city	80.1548	13.1143	Ambattur	a large city in the distance... probably	city_art
1578	city	102.1	14.975	Nakhon Ratchasima	a large city in the distance... probably	city_art
1579	city	106.7636	11.0508	Tan Uyen	a large city in the distance... probably	city_art
1580	city	6.6	36.35	Constantine	a large city in the distance... probably	city_art
1581	city	120.5489	27.5819	Longjiang	a large city in the distance... probably	city_art
1582	city	-51.1833	-29.1667	Caxias do Sul	a large city in the distance... probably	city_art
1583	city	120.5847	15.1472	Angeles City	a large city in the distance... probably	city_art
1584	city	82.9322	41.7156	Kuqa	a large city in the distance... probably	city_art
1585	city	136.6564	36.5611	Kanazawa	a large city in the distance... probably	city_art
1586	city	-118.167	33.7977	Long Beach	a large city in the distance... probably	city_art
1587	city	-80.3884	27.2796	Port St. Lucie	a large city in the distance... probably	city_art
1588	city	124.8413	1.4931	Manado Light	a large city in the distance... probably	city_art
1589	city	29.19	40.8872	Kartal	a large city in the distance... probably	city_art
1590	city	145.2834	-38.0996	Cranbourne	a large city in the distance... probably	city_art
1591	city	75.568	21.004	Jalgaon	a large city in the distance... probably	city_art
1592	city	-63.9039	-8.7619	Porto Velho	a large city in the distance... probably	city_art
1593	city	79.3527	24.55	Chhatarpur	a large city in the distance... probably	city_art
1594	city	133.3622	34.4858	Fukuyama	a large city in the distance... probably	city_art
1595	city	-92.3577	34.7256	Little Rock	a large city in the distance... probably	city_art
1596	city	31.6	4.85	Juba	a large city in the distance... probably	city_art
1597	city	-58.4	-34.7	Lanus	a large city in the distance... probably	city_art
1598	city	135.4	34.7333	Amagasaki	a large city in the distance... probably	city_art
1599	city	18.8181	-5.0386	Kikwit	a large city in the distance... probably	city_art
1600	city	127.1128	36.9922	Pyeongtaek	a large city in the distance... probably	city_art
1601	city	-119.8483	39.5497	Reno	a large city in the distance... probably	city_art
1602	city	78.05	15.83	Kurnool	a large city in the distance... probably	city_art
1603	city	-117.433	47.6671	Spokane	a large city in the distance... probably	city_art
1604	city	121.1	14.65	Marikina City	a large city in the distance... probably	city_art
1605	city	118.3167	27.0333	Jian'ou	a large city in the distance... probably	city_art
1606	city	126.746	42.972	Huadian	a large city in the distance... probably	city_art
1607	city	102.2486	2.1944	Melaka	a large city in the distance... probably	city_art
1608	city	124.8413	1.4931	Manado	a large city in the distance... probably	city_art
1609	city	-75.55	5.1	Manizales	a large city in the distance... probably	city_art
1610	city	27.2211	38.4697	Bornova	a large city in the distance... probably	city_art
1611	city	127.3448	43.7238	Minzhu	a large city in the distance... probably	city_art
1612	city	41.132	37.887	Demiryol	a large city in the distance... probably	city_art
1613	city	41.132	37.887	Erkoklu	a large city in the distance... probably	city_art
1614	city	116.0725	5.975	Kota Kinabalu	a large city in the distance... probably	city_art
1615	city	139.85	35.7333	Katsushika-ku	a large city in the distance... probably	city_art
1616	city	-89.393	43.0822	Madison	a large city in the distance... probably	city_art
1617	city	-75.8294	20.0217	Santiago de Cuba	a large city in the distance... probably	city_art
1618	city	73.68	24.58	Udaipur	a large city in the distance... probably	city_art
1619	city	36.1833	51.7167	Kursk	a large city in the distance... probably	city_art
1620	city	-46.1878	-23.5228	Mogi das Cruzes	a large city in the distance... probably	city_art
1621	city	41.9833	45.05	Stavropol	a large city in the distance... probably	city_art
1622	city	120.88	14.38	General Trias	a large city in the distance... probably	city_art
1623	city	89.75	24.45	Sirajganj	a large city in the distance... probably	city_art
1624	city	-116.2308	43.6005	Boise	a large city in the distance... probably	city_art
1625	city	-81.7859	26.3558	Bonita Springs	a large city in the distance... probably	city_art
1626	city	37.5494	47.0958	Mariupol	a large city in the distance... probably	city_art
1627	city	51.2247	35.5317	Eslamshahr	a large city in the distance... probably	city_art
1628	city	23.6469	37.943	Piraeus	a large city in the distance... probably	city_art
1629	city	-64.6833	10.1403	Barcelona	a large city in the distance... probably	city_art
1630	city	112.951	35.088	Tanbei	a large city in the distance... probably	city_art
1631	city	8.5411	47.3744	Zurich	a large city in the distance... probably	city_art
1632	city	118.6848	41.0042	Pingquan	a large city in the distance... probably	city_art
1633	city	5.2214	7.6211	Ado-Ekiti	a large city in the distance... probably	city_art
1634	city	119.337	29.4896	Baisha	a large city in the distance... probably	city_art
1635	city	41.132	37.887	Batman	a large city in the distance... probably	city_art
1636	city	110.448	34.867	Yongji	a large city in the distance... probably	city_art
1637	city	28.8903	41.0339	Esenler	a large city in the distance... probably	city_art
1638	city	121.12	14.72	Rodriguez	a large city in the distance... probably	city_art
1639	city	-116.6058	31.8578	Ensenada	a large city in the distance... probably	city_art
1640	city	111.5131	32.5401	Danjiangkou	a large city in the distance... probably	city_art
1641	city	91.3133	23.2283	Chauddagram	a large city in the distance... probably	city_art
1642	city	36.9333	37.5833	Kahramanmaras	a large city in the distance... probably	city_art
1643	city	-100.2833	25.75	San Nicolas de los Garza	a large city in the distance... probably	city_art
1644	city	121.3143	24.9913	Taoyuan District	a large city in the distance... probably	city_art
1645	city	15.3775	-4.4089	Ndjili	a large city in the distance... probably	city_art
1646	city	77.6737	27.4924	Mathura	a large city in the distance... probably	city_art
1647	city	121	14.55	Pasay City	a large city in the distance... probably	city_art
1648	city	129.483	44.341	Ning'an	a large city in the distance... probably	city_art
1649	city	-63.5906	44.6475	Halifax	a large city in the distance... probably	city_art
1650	city	139.4667	35.35	Fujisawa	a large city in the distance... probably	city_art
1651	city	107.6	51.8333	Ulan-Ude	a large city in the distance... probably	city_art
1652	city	-97.1418	33.2175	Denton	a large city in the distance... probably	city_art
1653	city	-73.75	45.5833	Laval	a large city in the distance... probably	city_art
1654	city	102.188	38.5214	Jinchang	a large city in the distance... probably	city_art
1655	city	-122.2166	37.7904	Oakland	a large city in the distance... probably	city_art
1656	city	-72.5395	42.1155	Springfield	a large city in the distance... probably	city_art
1657	city	122.7765	45.3357	Guangming	a large city in the distance... probably	city_art
1658	city	-82.0708	33.3645	Augusta	a large city in the distance... probably	city_art
1659	city	28.9664	41.0719	Kagithane	a large city in the distance... probably	city_art
1660	city	125.9333	39.4167	Sunch'on	a large city in the distance... probably	city_art
1661	city	74.583	16.853	Sangli	a large city in the distance... probably	city_art
1662	city	28.7214	40.9792	Avcilar	a large city in the distance... probably	city_art
1663	city	126.523	33.513	Jeju	a large city in the distance... probably	city_art
1664	city	120.829	37.3056	Zhuangyuan	a large city in the distance... probably	city_art
1665	city	75.9242	14.4666	Davangere	a large city in the distance... probably	city_art
1666	city	139.4431	35.5542	Machida	a large city in the distance... probably	city_art
1667	city	68.9536	26.0442	Sanghar	a large city in the distance... probably	city_art
1668	city	31.6	26.7	Al Maraghah	a large city in the distance... probably	city_art
1669	city	107.6097	-6.912	Bandung	a large city in the distance... probably	city_art
1670	city	-81.4169	28.3041	Kissimmee	a large city in the distance... probably	city_art
1671	city	75.7804	11.2588	Calicut	a large city in the distance... probably	city_art
1672	city	-6.5833	34.25	Kenitra	a large city in the distance... probably	city_art
1673	city	17.0836	-22.57	Windhoek	a large city in the distance... probably	city_art
1674	city	102.25	26.6333	Huili Chengguanzhen	a large city in the distance... probably	city_art
1675	city	9.4858	35.0381	Sidi Bouzid	a large city in the distance... probably	city_art
1676	city	74.58	18.15	Baramati	a large city in the distance... probably	city_art
1677	city	31	30.7833	Tanta	a large city in the distance... probably	city_art
1678	city	32.2667	30.5833	Ismailia	a large city in the distance... probably	city_art
1679	city	-71.9722	-13.525	Cusco	a large city in the distance... probably	city_art
1680	city	-96.1533	19.1903	Veracruz	a large city in the distance... probably	city_art
1681	city	5.2339	13.0622	Sokoto	a large city in the distance... probably	city_art
1682	city	-80.261	36.1029	Winston-Salem	a large city in the distance... probably	city_art
1683	city	139.9758	35.8676	Kashiwa	a large city in the distance... probably	city_art
1684	city	31.0569	30.4333	Al Bajur	a large city in the distance... probably	city_art
1685	city	109.3653	32.8341	Xunyang	a large city in the distance... probably	city_art
1686	city	38.3194	38.3486	Malatya	a large city in the distance... probably	city_art
1687	city	87.2674	44.0144	Yan'an Beilu	a large city in the distance... probably	city_art
1688	city	84.9167	26.65	Mothihari	a large city in the distance... probably	city_art
1689	city	140.7469	40.8228	Aomori	a large city in the distance... probably	city_art
1690	city	77	20.7	Akola	a large city in the distance... probably	city_art
1691	city	121.03	14.58	Mandaluyong City	a large city in the distance... probably	city_art
1692	city	-8.3	41.44	Aves	a large city in the distance... probably	city_art
1693	city	126.8029	37.3799	Sihung	a large city in the distance... probably	city_art
1694	city	45.5345	9.5279	Burco	a large city in the distance... probably	city_art
1695	city	35.9242	56.8625	Tver	a large city in the distance... probably	city_art
1696	city	-96.9275	19.54	Xalapa	a large city in the distance... probably	city_art
1697	city	-77.0267	3.8772	Buenaventura	a large city in the distance... probably	city_art
1698	city	-81.2497	42.9836	London	a large city in the distance... probably	city_art
1699	city	-47.6492	-22.7253	Piracicaba	a large city in the distance... probably	city_art
1700	city	110.3644	-7.8014	Yogyakarta	a large city in the distance... probably	city_art
1701	city	137.1563	35.0824	Toyota	a large city in the distance... probably	city_art
1702	city	-6.45	6.8833	Daloa	a large city in the distance... probably	city_art
1703	city	-9.6	30.4333	Agadir	a large city in the distance... probably	city_art
1704	city	39.2228	38.6744	Elazig	a large city in the distance... probably	city_art
1705	city	127.0389	37.7486	Uijeongbu	a large city in the distance... probably	city_art
1706	city	97.6333	16.8906	Hpa-An	a large city in the distance... probably	city_art
1707	city	70.3	28.42	Rahimyar Khan	a large city in the distance... probably	city_art
1708	city	8.0833	5.8	Ugep	a large city in the distance... probably	city_art
1709	city	129.38	44.594	Hailin	a large city in the distance... probably	city_art
1710	city	131.8466	45.5298	Mishan	a large city in the distance... probably	city_art
1711	city	18.4131	43.8564	Sarajevo	a large city in the distance... probably	city_art
1712	city	101.9417	2.7222	Seremban	a large city in the distance... probably	city_art
1713	city	123.5027	43.5183	Zhengjiatun	a large city in the distance... probably	city_art
1714	city	113.3333	25.1333	Lecheng	a large city in the distance... probably	city_art
1715	city	-35.8811	-7.2306	Campina Grande	a large city in the distance... probably	city_art
1716	city	103.15	23.3667	Xicheng	a large city in the distance... probably	city_art
1717	city	115.681	29.676	Pencheng	a large city in the distance... probably	city_art
1718	city	114.1916	22.3282	Kowloon City	a large city in the distance... probably	city_art
1719	city	19.8178	41.3289	Tirana	a large city in the distance... probably	city_art
1720	city	89.1231	23.9101	Kushtia	a large city in the distance... probably	city_art
1721	city	30.2167	13.1833	El Obeid	a large city in the distance... probably	city_art
1722	city	-46.4608	-23.6678	Maua	a large city in the distance... probably	city_art
1723	city	59.0333	53.3833	Magnitogorsk	a large city in the distance... probably	city_art
1724	city	124.2833	45.5	Da'an	a large city in the distance... probably	city_art
1725	city	39.3031	48.5678	Luhansk	a large city in the distance... probably	city_art
1726	city	105.1862	25.435	Xingren	a large city in the distance... probably	city_art
1727	city	134.05	34.35	Takamatsu	a large city in the distance... probably	city_art
1728	city	36.6833	-3.3667	Arusha	a large city in the distance... probably	city_art
1729	city	111.7699	37.2616	Fenyang	a large city in the distance... probably	city_art
1730	city	20.2253	30.7556	Ajdabiya	a large city in the distance... probably	city_art
1731	city	-77.1392	-12.0522	Callao	a large city in the distance... probably	city_art
1732	city	31.1333	30.1167	Awsim	a large city in the distance... probably	city_art
1733	city	139.7333	35.6	Shinagawa-ku	a large city in the distance... probably	city_art
1734	city	126.8	37.8667	Paju	a large city in the distance... probably	city_art
1735	city	121.12	14.32	Santa Rosa	a large city in the distance... probably	city_art
1736	city	84.5028	26.8014	Bettiah	a large city in the distance... probably	city_art
1737	city	72.3161	31.2694	Jhang City	a large city in the distance... probably	city_art
1738	city	32.9033	39.9636	Altindag	a large city in the distance... probably	city_art
1739	city	30.9438	30.6801	Tala	a large city in the distance... probably	city_art
1740	city	-121.3109	37.9765	Stockton	a large city in the distance... probably	city_art
1741	city	31.3756	31.0547	Talkha	a large city in the distance... probably	city_art
1742	city	-60.6714	2.8194	Boa Vista	a large city in the distance... probably	city_art
1743	city	-16.5775	13.4531	Banjul	a large city in the distance... probably	city_art
1744	city	140.717	-2.533	Jayapura	a large city in the distance... probably	city_art
1745	city	137.2137	36.6959	Toyama	a large city in the distance... probably	city_art
1746	city	46.9961	35.3114	Sanandaj	a large city in the distance... probably	city_art
1747	city	102.8333	16.4333	Khon Kaen	a large city in the distance... probably	city_art
1748	city	104.167	31.127	Fangting	a large city in the distance... probably	city_art
1749	city	121.35	41.1667	Linghai	a large city in the distance... probably	city_art
1750	city	76.76	16.52	Shorapur	a large city in the distance... probably	city_art
1751	city	-3.95	5.3	Koumassi	a large city in the distance... probably	city_art
1752	city	-44.1978	-19.9678	Betim	a large city in the distance... probably	city_art
1753	city	39.7203	43.5853	Sochi	a large city in the distance... probably	city_art
1754	city	77.7567	8.7136	Tinnevelly	a large city in the distance... probably	city_art
1755	city	-77.2772	1.2078	Pasto	a large city in the distance... probably	city_art
1756	city	-76.1437	43.0407	Syracuse	a large city in the distance... probably	city_art
1757	city	76.9167	15.1	Bellary	a large city in the distance... probably	city_art
1758	city	87	25.25	Bhagalpur	a large city in the distance... probably	city_art
1759	city	34.7667	-0.0833	Kisumu	a large city in the distance... probably	city_art
1760	city	115.0243	40.5944	Zhangjiakou Shi Xuanhua Qu	a large city in the distance... probably	city_art
1761	city	-51.9167	-23.4	Maringa	a large city in the distance... probably	city_art
1762	city	35.4833	38.7333	Kocasinan	a large city in the distance... probably	city_art
1763	city	116.1167	-8.5833	Mataram	a large city in the distance... probably	city_art
1764	city	38.6	7.2	Shashemene	a large city in the distance... probably	city_art
1765	city	7.7	11.0667	Zaria	a large city in the distance... probably	city_art
1766	city	128.3444	36.1195	Kumi	a large city in the distance... probably	city_art
1767	city	107.9667	31.9833	Wanyuan	a large city in the distance... probably	city_art
1768	city	121.08	14.33	Binan	a large city in the distance... probably	city_art
1769	city	-85.2481	35.066	Chattanooga	a large city in the distance... probably	city_art
1770	city	111.917	37.027	Jiexiu	a large city in the distance... probably	city_art
1771	city	40.1833	37.9167	Baglar	a large city in the distance... probably	city_art
1772	city	76.593	30.802	Padiala	a large city in the distance... probably	city_art
1773	city	108.4383	11.9417	Da Lat	a large city in the distance... probably	city_art
1774	city	114.1622	22.3307	Sham Shui Po	a large city in the distance... probably	city_art
1775	city	-60.7	-31.6333	Santa Fe	a large city in the distance... probably	city_art
1776	city	77.1333	28.6	Delhi Cantonment	a large city in the distance... probably	city_art
1777	city	-64.1675	10.4564	Cumana	a large city in the distance... probably	city_art
1778	city	91.0583	23.375	Barura	a large city in the distance... probably	city_art
1779	city	35.3439	36.9981	Yuregir	a large city in the distance... probably	city_art
1780	city	129.8736	32.7447	Nagasaki	a large city in the distance... probably	city_art
1781	city	72.0258	34.2012	Mardan	a large city in the distance... probably	city_art
1782	city	100.4667	7.0167	Hat Yai	a large city in the distance... probably	city_art
1783	city	88.4	22.61	Salt Lake City	a large city in the distance... probably	city_art
1784	city	50.0086	36.2894	Qazvin	a large city in the distance... probably	city_art
1785	city	78.2	24.18	Etawa	a large city in the distance... probably	city_art
1786	city	-76.3012	40.042	Lancaster	a large city in the distance... probably	city_art
1787	city	77.022	28.99	Sonipat	a large city in the distance... probably	city_art
1788	city	-46.8839	-23.1858	Jundiai	a large city in the distance... probably	city_art
1789	city	40.9819	56.9967	Ivanovo	a large city in the distance... probably	city_art
1790	city	-82.3646	34.8354	Greenville	a large city in the distance... probably	city_art
1791	city	135.4667	34.7833	Toyonaka	a large city in the distance... probably	city_art
1792	city	89.3667	24.85	Bogra	a large city in the distance... probably	city_art
1793	city	82.6167	49.9833	Oskemen	a large city in the distance... probably	city_art
1794	city	136.7608	35.4232	Gifu	a large city in the distance... probably	city_art
1795	city	92.3667	20.8167	Maungdaw	a large city in the distance... probably	city_art
1796	city	111.9709	31.0238	Jiangjiafan	a large city in the distance... probably	city_art
1797	city	-78.9022	35.9792	Durham	a large city in the distance... probably	city_art
1798	city	34.3667	53.2333	Bryansk	a large city in the distance... probably	city_art
1799	city	70.64	30.0331	Dera Ghazi Khan	a large city in the distance... probably	city_art
1800	city	-48.9519	-16.3339	Anapolis	a large city in the distance... probably	city_art
1801	city	-87.1911	30.4413	Pensacola	a large city in the distance... probably	city_art
1802	city	131.4203	31.9078	Miyazaki	a large city in the distance... probably	city_art
1803	city	76.6141	8.8932	Quilon	a large city in the distance... probably	city_art
1804	city	76.6167	9	Mulangodi	a large city in the distance... probably	city_art
1805	city	76.6167	9	Munro Turuttu	a large city in the distance... probably	city_art
1806	city	135.65	34.8167	Hirakata	a large city in the distance... probably	city_art
1807	city	118.1167	5.8333	Sandakan	a large city in the distance... probably	city_art
1808	city	14.5481	53.4325	Szczecin	a large city in the distance... probably	city_art
1809	city	16.6083	49.1925	Brno	a large city in the distance... probably	city_art
1810	city	73.4333	61.25	Surgut	a large city in the distance... probably	city_art
1811	city	110.712	35.596	Hejin	a large city in the distance... probably	city_art
1812	city	-94.1661	36.0714	Fayetteville	a large city in the distance... probably	city_art
1813	city	46.83	-16.95	Betsiboka	a large city in the distance... probably	city_art
1814	city	-16.9167	14.7833	Thies	a large city in the distance... probably	city_art
1815	city	-97.125	32.6998	Arlington	a large city in the distance... probably	city_art
1816	city	47.6833	29.35	Al Jahra'	a large city in the distance... probably	city_art
1817	city	23.8861	54.8972	Kaunas	a large city in the distance... probably	city_art
1818	city	105.7764	19.8075	Thanh Hoa	a large city in the distance... probably	city_art
1819	city	-46.6106	-23.6861	Diadema	a large city in the distance... probably	city_art
1820	city	13.5333	-12.3667	Lobito	a large city in the distance... probably	city_art
1821	city	20.4	-9.65	Saurimo	a large city in the distance... probably	city_art
1822	city	12.46	9.23	Yola	a large city in the distance... probably	city_art
1823	city	121.2264	28.1358	Zhugang	a large city in the distance... probably	city_art
1824	city	89.9181	24.2644	Tangail	a large city in the distance... probably	city_art
1825	city	109.1917	12.245	Nha Trang	a large city in the distance... probably	city_art
1826	city	18.6778	-34.0403	Khayelitsha	a large city in the distance... probably	city_art
1827	city	44.9247	31.9892	Ad Diwaniyah	a large city in the distance... probably	city_art
1828	city	6.9167	6.0167	Nnewi	a large city in the distance... probably	city_art
1829	city	110.4333	35.4667	Hancheng	a large city in the distance... probably	city_art
1830	city	-6.6333	4.75	San-Pedro	a large city in the distance... probably	city_art
1831	city	74.0789	32.5739	Gujrat	a large city in the distance... probably	city_art
1832	city	139.6721	35.2813	Yokosuka	a large city in the distance... probably	city_art
1833	city	128.05	46.95	Tieli	a large city in the distance... probably	city_art
1834	city	31.1667	27.1833	Asyut	a large city in the distance... probably	city_art
1835	city	13.6914	11.0861	Gwoza	a large city in the distance... probably	city_art
1836	city	121.0022	14.6031	Sampaloc	a large city in the distance... probably	city_art
1837	city	3.4	8.6667	Saki	a large city in the distance... probably	city_art
1838	city	11.3428	44.4939	Bologna	a large city in the distance... probably	city_art
1839	city	57.2297	50.2836	Aqtobe	a large city in the distance... probably	city_art
1840	city	106.0112	-6.0027	Cilegon	a large city in the distance... probably	city_art
1841	city	30.3839	-5.1069	Uvinza	a large city in the distance... probably	city_art
1842	city	-104.7237	39.7083	Aurora	a large city in the distance... probably	city_art
1843	city	-46.8358	-23.5192	Carapicuiba	a large city in the distance... probably	city_art
1844	city	45.9636	28.4342	Hafr al Batin	a large city in the distance... probably	city_art
1845	city	48.5056	36.6789	Zanjan	a large city in the distance... probably	city_art
1846	city	-40.5022	-9.3825	Petrolina	a large city in the distance... probably	city_art
1847	city	84.1489	25.7583	Bairia	a large city in the distance... probably	city_art
1848	city	3.933	7.85	Oyo	a large city in the distance... probably	city_art
1849	city	121.1325	14.5692	Taytay	a large city in the distance... probably	city_art
1850	city	15.3425	-4.4094	Kisenzi	a large city in the distance... probably	city_art
1851	city	88.41	22.87	Bhatpara	a large city in the distance... probably	city_art
1852	city	78.4138	17.4849	Kukatpalli	a large city in the distance... probably	city_art
1853	city	27.4292	38.6144	Manisa	a large city in the distance... probably	city_art
1854	city	74.38	18.83	Sirur	a large city in the distance... probably	city_art
1855	city	120.59	15.4869	Tarlac City	a large city in the distance... probably	city_art
1856	city	137.1744	34.9543	Okazaki	a large city in the distance... probably	city_art
1857	city	112.377	24.781	Lianzhou	a large city in the distance... probably	city_art
1858	city	45.7587	3.2073	Ceel Baraf	a large city in the distance... probably	city_art
1859	city	111.45	30.378	Yidu	a large city in the distance... probably	city_art
1860	city	120.3975	27.5036	Lingxi	a large city in the distance... probably	city_art
1861	city	4.7167	7.6167	Ilesa	a large city in the distance... probably	city_art
1862	city	82.255	16.9661	Kakinada	a large city in the distance... probably	city_art
1863	city	90.26	23.85	Savar	a large city in the distance... probably	city_art
1864	city	-99.5069	27.4861	Nuevo Laredo	a large city in the distance... probably	city_art
1865	city	58.3833	23.5333	Bawshar	a large city in the distance... probably	city_art
1866	city	172.6365	-43.531	Christchurch	a large city in the distance... probably	city_art
1867	city	6.6667	12.15	Gusau	a large city in the distance... probably	city_art
1868	city	91.771	29.238	Zetang	a large city in the distance... probably	city_art
1869	city	119.8594	-0.895	Palu	a large city in the distance... probably	city_art
1870	city	149.1269	-35.2931	Canberra	a large city in the distance... probably	city_art
1871	city	135.5169	34.7594	Minamisuita	a large city in the distance... probably	city_art
1872	city	-5.3667	35.5667	Tetouan	a large city in the distance... probably	city_art
1873	city	120.96	14.66	Malabon	a large city in the distance... probably	city_art
1874	city	-75.2809	2.9345	Neiva	a large city in the distance... probably	city_art
1875	city	19.8425	45.2542	Novi Sad	a large city in the distance... probably	city_art
1876	city	-75.2167	-12.0667	Huancayo	a large city in the distance... probably	city_art
1877	city	-100.8122	20.5222	Celaya	a large city in the distance... probably	city_art
1878	city	136.8031	35.3039	Ichinomiya	a large city in the distance... probably	city_art
1879	city	-35.9758	-8.2828	Caruaru	a large city in the distance... probably	city_art
1880	city	-9.3883	38.7992	Sintra	a large city in the distance... probably	city_art
1881	city	36.1606	36.2025	Hatay	a large city in the distance... probably	city_art
1882	city	-73.25	-3.75	Iquitos	a large city in the distance... probably	city_art
1883	city	88.37	22.69	Panihati	a large city in the distance... probably	city_art
1884	city	121.12	14.57	Cainta	a large city in the distance... probably	city_art
1885	city	118.9861	30.6267	Helixi	a large city in the distance... probably	city_art
1886	city	-12.0833	10.3833	Mamou	a large city in the distance... probably	city_art
1887	city	174.885	-37	Manukau City	a large city in the distance... probably	city_art
1888	city	-46.3486	-23.4864	Itaquaquecetuba	a large city in the distance... probably	city_art
1889	city	74.3833	31.5167	Cantonment	a large city in the distance... probably	city_art
1890	city	76.5796	28.8909	Rohtak	a large city in the distance... probably	city_art
1891	city	37.3792	37.0628	Gaziantep	a large city in the distance... probably	city_art
1892	city	75.8833	30.5167	Maler Kotla	a large city in the distance... probably	city_art
1893	city	72.6461	31.5661	Bhawana	a large city in the distance... probably	city_art
1894	city	48.3561	33.4875	Khorramabad	a large city in the distance... probably	city_art
1895	city	121.1622	13.9411	Lipa City	a large city in the distance... probably	city_art
1896	city	125.543	8.948	Butuan	a large city in the distance... probably	city_art
1897	city	31.5969	31.0883	Dikirnis	a large city in the distance... probably	city_art
1898	city	-2.1833	53	Stoke-on-Trent	a large city in the distance... probably	city_art
1899	city	139.0033	36.3219	Takasaki	a large city in the distance... probably	city_art
1900	city	73.2067	32.5531	Malakwal	a large city in the distance... probably	city_art
1901	city	137.3915	34.7692	Toyohashi	a large city in the distance... probably	city_art
1902	city	31.0481	-17.9939	Chitungwiza	a large city in the distance... probably	city_art
1903	city	29.4333	40.8	Gebze	a large city in the distance... probably	city_art
1904	city	106.842	-6.485	Cibinong	a large city in the distance... probably	city_art
1905	city	111.436	27.686	Lengshuijiang	a large city in the distance... probably	city_art
1906	city	126.0667	42.95	Panshi	a large city in the distance... probably	city_art
1907	city	47.7	30.3833	Az Zubayr	a large city in the distance... probably	city_art
1908	city	-119.1815	34.1964	Oxnard	a large city in the distance... probably	city_art
1909	city	28.4833	49.2333	Vinnytsia	a large city in the distance... probably	city_art
1910	city	-116.2346	33.7346	Indio	a large city in the distance... probably	city_art
1911	city	84.4333	27.6833	Bharatpur	a large city in the distance... probably	city_art
1912	city	-66.8167	10.4833	Petare	a large city in the distance... probably	city_art
1913	city	138.1947	36.6486	Nagano	a large city in the distance... probably	city_art
1914	city	112.7914	34.9073	Huichang	a large city in the distance... probably	city_art
1915	city	121.7333	25.1333	Keelung	a large city in the distance... probably	city_art
1916	city	-49.0608	-22.315	Bauru	a large city in the distance... probably	city_art
1917	city	-70.5833	-33.5333	La Florida	a large city in the distance... probably	city_art
1918	city	-99.3667	19.5833	Nicolas Romero	a large city in the distance... probably	city_art
1919	city	102.0723	25.1462	Jinshan	a large city in the distance... probably	city_art
1920	city	120.5933	16.4119	Baguio City	a large city in the distance... probably	city_art
1921	city	-75.6649	41.4044	Scranton	a large city in the distance... probably	city_art
1922	city	7.2158	51.4819	Bochum	a large city in the distance... probably	city_art
1923	city	37.0167	39.75	Sivas	a large city in the distance... probably	city_art
1924	city	82.68	22.35	Kolga	a large city in the distance... probably	city_art
1925	city	82.6963	22.3458	Korba	a large city in the distance... probably	city_art
1926	city	49.0833	9.5	Qardho	a large city in the distance... probably	city_art
1927	city	-67.81	-9.9747	Rio Branco	a large city in the distance... probably	city_art
1928	city	-98.9683	19.7131	Tecamac	a large city in the distance... probably	city_art
1929	city	32	36.55	Alanya	a large city in the distance... probably	city_art
1930	city	123.93	10.33	Mandaue City	a large city in the distance... probably	city_art
1931	city	-117.3536	34.5277	Victorville	a large city in the distance... probably	city_art
1932	city	29.9175	40.7625	Kocaeli	a large city in the distance... probably	city_art
1933	city	5.75	5.5167	Warri	a large city in the distance... probably	city_art
1934	city	-123.3647	48.4283	Victoria	a large city in the distance... probably	city_art
1935	city	127.4461	39.1475	Wonsan	a large city in the distance... probably	city_art
1936	city	124.25	8.23	Iligan	a large city in the distance... probably	city_art
1937	city	115.327	38.418	Anguo	a large city in the distance... probably	city_art
1938	city	44.2667	6.7333	K'ebri Dehar	a large city in the distance... probably	city_art
1939	city	-1.5106	52.4081	Coventry	a large city in the distance... probably	city_art
1940	city	40.1667	37.95	Kayapinar	a large city in the distance... probably	city_art
1941	city	-74.7641	40.2237	Trenton	a large city in the distance... probably	city_art
1942	city	-79.0045	-2.8974	Cuenca	a large city in the distance... probably	city_art
1943	city	-49.05	-26.9333	Blumenau	a large city in the distance... probably	city_art
1944	city	121.4547	30.9167	Nanqiao	a large city in the distance... probably	city_art
1945	city	11.2542	43.7714	Florence	a large city in the distance... probably	city_art
1946	city	44.0833	2.7833	Buurhakaba	a large city in the distance... probably	city_art
1947	city	102.2592	-3.7956	Bengkulu	a large city in the distance... probably	city_art
1948	city	13.0358	55.6058	Malmo	a large city in the distance... probably	city_art
1949	city	126.1667	48.75	Wudalianchi	a large city in the distance... probably	city_art
1950	city	106.7903	30.3746	Shuanghe	a large city in the distance... probably	city_art
1951	city	-72.2864	18.5128	Petion-Ville	a large city in the distance... probably	city_art
1952	city	5.1217	52.0908	Utrecht	a large city in the distance... probably	city_art
1953	city	75.15	27.62	Sikar	a large city in the distance... probably	city_art
1954	city	7.4833	5.5333	Umuahia	a large city in the distance... probably	city_art
1955	city	30.2056	55.1917	Vitsyebsk	a large city in the distance... probably	city_art
1956	city	-76.25	3.5833	Palmira	a large city in the distance... probably	city_art
1957	city	7.1833	51.2667	Wuppertal	a large city in the distance... probably	city_art
1958	city	23.8333	53.6667	Hrodna	a large city in the distance... probably	city_art
1959	city	30.9021	30.6039	Ash Shuhada'	a large city in the distance... probably	city_art
1960	city	78.0766	10.9601	Karur	a large city in the distance... probably	city_art
1961	city	-50.1583	-25.0994	Ponta Grossa	a large city in the distance... probably	city_art
1962	city	84.03	24.95	Sasaram	a large city in the distance... probably	city_art
1963	city	71.3667	42.9	Taraz	a large city in the distance... probably	city_art
1964	city	14.25	-13.0333	Cubal	a large city in the distance... probably	city_art
1965	city	19.9062	-11.7918	Luena	a large city in the distance... probably	city_art
1966	city	76.989	29.686	Karnal	a large city in the distance... probably	city_art
1967	city	117.365	25.942	Yong'an	a large city in the distance... probably	city_art
1968	city	27.1285	38.4189	Konak	a large city in the distance... probably	city_art
1969	city	-94.55	17.9833	Minatitlan	a large city in the distance... probably	city_art
1970	city	103.2422	35.6047	Linxia Chengguanzhen	a large city in the distance... probably	city_art
1971	city	84.7941	19.315	Brahmapur	a large city in the distance... probably	city_art
1972	city	79.3	19.95	Chanda	a large city in the distance... probably	city_art
1973	city	-38.65	-3.7167	Caucaia	a large city in the distance... probably	city_art
1974	city	16.9333	-12.3833	Cuito	a large city in the distance... probably	city_art
1975	city	121.125	14.275	Cabuyao	a large city in the distance... probably	city_art
1976	city	104.5446	34.9857	Hongzhai	a large city in the distance... probably	city_art
1977	city	35.3833	14.0333	Gedaref	a large city in the distance... probably	city_art
1978	city	120.68	15.03	San Fernando	a large city in the distance... probably	city_art
1979	city	139.4858	35.9251	Kawagoe	a large city in the distance... probably	city_art
1980	city	-121.0028	37.6375	Modesto	a large city in the distance... probably	city_art
1981	city	59.9667	57.9167	Nizhniy Tagil	a large city in the distance... probably	city_art
1982	city	83.9889	28.2083	Pokhara	a large city in the distance... probably	city_art
1983	city	-92.9281	17.9892	Villahermosa	a large city in the distance... probably	city_art
1984	city	43.38	38.4942	Van	a large city in the distance... probably	city_art
1985	city	30.35	53.9167	Mahilyow	a large city in the distance... probably	city_art
1986	city	135.1667	34.2333	Wakayama	a large city in the distance... probably	city_art
1987	city	72.8	40.53	Osh	a large city in the distance... probably	city_art
1988	city	139.7333	35.75	Kita-ku	a large city in the distance... probably	city_art
1989	city	126.6	37.7	Gimpo	a large city in the distance... probably	city_art
1990	city	-58.8167	-27.4833	Corrientes	a large city in the distance... probably	city_art
1991	city	-47.4008	-20.5389	Franca	a large city in the distance... probably	city_art
1992	city	68.6023	27.0683	Thari Mir Wah	a large city in the distance... probably	city_art
1993	city	135.805	34.6844	Nara	a large city in the distance... probably	city_art
1994	city	40.4058	56.1286	Vladimir	a large city in the distance... probably	city_art
1995	city	120.712	49.286	Yakeshi	a large city in the distance... probably	city_art
1996	city	106.1683	20.42	Nam Dinh	a large city in the distance... probably	city_art
1997	city	124.4	40.1	Sinuiju	a large city in the distance... probably	city_art
1998	city	-67.1167	-17.9667	Oruro	a large city in the distance... probably	city_art
1999	city	-71.45	10.4	Cabimas	a large city in the distance... probably	city_art
2000	city	40.5333	64.5333	Arkhangelsk	a large city in the distance... probably	city_art
2001	city	121	13.83	Batangas	a large city in the distance... probably	city_art
2002	city	44.1667	13.9667	Ibb	a large city in the distance... probably	city_art
2003	city	74.73	19.08	Ahmadnagar	a large city in the distance... probably	city_art
2004	city	73.75	32.9	Sarai Alamgir	a large city in the distance... probably	city_art
2005	city	80.2667	50.4333	Semey	a large city in the distance... probably	city_art
2006	city	-76.2592	20.8869	Holguin	a large city in the distance... probably	city_art
2007	city	90.41	23.9	Tungi	a large city in the distance... probably	city_art
2008	city	97.4395	39.9487	Yingmen	a large city in the distance... probably	city_art
2009	city	44.5508	36.6606	Sawran	a large city in the distance... probably	city_art
2010	city	113.4667	52.05	Chita	a large city in the distance... probably	city_art
2011	city	-34.8833	-8	Olinda	a large city in the distance... probably	city_art
2012	city	-46.4028	-24.0061	Praia Grande	a large city in the distance... probably	city_art
2013	city	77.513	13.0465	Dasarhalli	a large city in the distance... probably	city_art
2014	city	-86.6412	34.6981	Huntsville	a large city in the distance... probably	city_art
2015	city	139.7097	35.7014	Shinjuku	a large city in the distance... probably	city_art
2016	city	-0.4831	38.3453	Alicante	a large city in the distance... probably	city_art
2017	city	-40.42	-20.2639	Cariacica	a large city in the distance... probably	city_art
2018	city	27.9167	43.2167	Varna	a large city in the distance... probably	city_art
2019	city	-157.846	21.3294	Honolulu	a large city in the distance... probably	city_art
2020	city	-70.4	-23.65	Antofagasta	a large city in the distance... probably	city_art
2021	city	128.1667	-3.7	Ambon	a large city in the distance... probably	city_art
2022	city	7.2663	43.7034	Nice	a large city in the distance... probably	city_art
2023	city	-53.4553	-24.9556	Cascavel	a large city in the distance... probably	city_art
2024	city	29.1167	37.9167	Pamukkale	a large city in the distance... probably	city_art
2025	city	-51.18	-29.92	Canoas	a large city in the distance... probably	city_art
2026	city	135.6175	34.8461	Takatsuki	a large city in the distance... probably	city_art
2027	city	39.9167	-16.2333	Antonio Enes	a large city in the distance... probably	city_art
2028	city	-79.8271	36.0956	Greensboro	a large city in the distance... probably	city_art
2029	city	-117.8574	33.839	Anaheim	a large city in the distance... probably	city_art
2030	city	24.75	42.15	Plovdiv	a large city in the distance... probably	city_art
2031	city	151.2	-33.3	Central Coast	a large city in the distance... probably	city_art
2032	city	27.1153	38.4594	Karsiyaka	a large city in the distance... probably	city_art
2033	city	79.91	27.88	Shahjanpur	a large city in the distance... probably	city_art
2034	city	7.0758	8.9392	Gwagwalada	a large city in the distance... probably	city_art
2035	city	80.0972	13.1097	Alamadi	a large city in the distance... probably	city_art
2036	city	80.1098	13.1147	Avadi	a large city in the distance... probably	city_art
2037	city	128.911	40.458	Tanch'on	a large city in the distance... probably	city_art
2038	city	74.5083	15.6394	Khanapur	a large city in the distance... probably	city_art
2039	city	33.5167	14.4	Wad Medani	a large city in the distance... probably	city_art
2040	city	32.6667	13.1667	Kusti	a large city in the distance... probably	city_art
2041	city	-5.93	54.5964	Belfast	a large city in the distance... probably	city_art
2042	city	77.8253	12.7409	Hosur	a large city in the distance... probably	city_art
2043	city	78.82	14.47	Cuddapah	a large city in the distance... probably	city_art
2044	city	139.6638	35.7074	Nakano	a large city in the distance... probably	city_art
2045	city	135.85	35.0167	Otsu	a large city in the distance... probably	city_art
2046	city	27.48	-29.31	Maseru	a large city in the distance... probably	city_art
2047	city	37.9611	48.0556	Makiivka	a large city in the distance... probably	city_art
2048	city	76.95	52.3	Pavlodar	a large city in the distance... probably	city_art
2049	city	100.985	13.3611	Chon Buri	a large city in the distance... probably	city_art
2050	city	123.1864	13.6244	Naga City	a large city in the distance... probably	city_art
2051	city	29.0572	41.1669	Sariyer	a large city in the distance... probably	city_art
2052	city	23.6569	52.1347	Brest	a large city in the distance... probably	city_art
2053	city	32.4383	37.8364	Meram	a large city in the distance... probably	city_art
2054	city	-103.4983	25.5611	Gomez Palacio	a large city in the distance... probably	city_art
2055	city	-34.8728	-7.9408	Paulista	a large city in the distance... probably	city_art
2056	city	81.78	16.98	Rajahmundry	a large city in the distance... probably	city_art
2057	city	139.7909	35.8911	Koshigaya	a large city in the distance... probably	city_art
2058	city	107.1167	10.3833	Vung Tau	a large city in the distance... probably	city_art
2059	city	127.15	35.8167	Jeonju	a large city in the distance... probably	city_art
2060	city	76.6355	27.5498	Alwar	a large city in the distance... probably	city_art
2061	city	139.4686	35.7996	Tokorozawa	a large city in the distance... probably	city_art
2062	city	49.6686	40.5897	Sumqayit	a large city in the distance... probably	city_art
2063	city	-40.8389	-14.8658	Vitoria da Conquista	a large city in the distance... probably	city_art
2064	city	34.1022	44.9519	Simferopol	a large city in the distance... probably	city_art
2065	city	108.05	12.6667	Buon Ma Thuot	a large city in the distance... probably	city_art
2066	city	-16.6667	13.4333	Serekunda	a large city in the distance... probably	city_art
2067	city	-73.1888	40.7385	Islip	a large city in the distance... probably	city_art
2068	city	-99.2342	18.9186	Cuernavaca	a large city in the distance... probably	city_art
2069	city	-79.2633	43.8767	Markham	a large city in the distance... probably	city_art
2070	city	8.5347	52.0211	Bielefeld	a large city in the distance... probably	city_art
2071	city	-47.9319	-19.7478	Uberaba	a large city in the distance... probably	city_art
2072	city	85.3333	27.6666	Jitpur	a large city in the distance... probably	city_art
2073	city	18.0003	53.1219	Bydgoszcz	a large city in the distance... probably	city_art
2074	city	113.231	25.973	Tangdong	a large city in the distance... probably	city_art
2075	city	128.0833	35.2	Chinju	a large city in the distance... probably	city_art
2076	city	-97.3767	27.7254	Corpus Christi	a large city in the distance... probably	city_art
2077	city	-85.1436	41.0888	Fort Wayne	a large city in the distance... probably	city_art
2078	city	-0.9731	51.4542	Reading	a large city in the distance... probably	city_art
2079	city	28.0064	-26.0936	Randburg	a large city in the distance... probably	city_art
2080	city	13.4833	-5.8167	Matadi	a large city in the distance... probably	city_art
2081	city	7.1	50.7333	Bonn	a large city in the distance... probably	city_art
2082	city	140.8877	37.0505	Iwaki	a large city in the distance... probably	city_art
2083	city	-78.85	43.9	Oshawa	a large city in the distance... probably	city_art
2084	city	67.1625	24.8806	Shah Latif Town	a large city in the distance... probably	city_art
2085	city	83.97	21.47	Sambalpur	a large city in the distance... probably	city_art
2086	city	-105.0656	40.5477	Fort Collins	a large city in the distance... probably	city_art
2087	city	-90.2125	32.3157	Jackson	a large city in the distance... probably	city_art
2088	city	119.815	32.237	Yingzhong	a large city in the distance... probably	city_art
2089	city	-79.1719	-0.2542	Santo Domingo de los Colorados	a large city in the distance... probably	city_art
2090	city	-102.0628	19.4208	Uruapan	a large city in the distance... probably	city_art
2091	city	22.5667	51.25	Lublin	a large city in the distance... probably	city_art
2092	city	110.4	24.5	Licheng	a large city in the distance... probably	city_art
2093	city	23.76	61.4981	Tampere	a large city in the distance... probably	city_art
2094	city	36.6	50.6	Belgorod	a large city in the distance... probably	city_art
2095	city	85.3906	26.1225	Muzaffarpur	a large city in the distance... probably	city_art
2096	city	-71.5517	-33.0244	Vina del Mar	a large city in the distance... probably	city_art
2097	city	-104.8931	21.5083	Tepic	a large city in the distance... probably	city_art
2098	city	69.377	25.823	Khipro	a large city in the distance... probably	city_art
2099	city	117.777	39.232	Hangu	a large city in the distance... probably	city_art
2100	city	126.9833	36.7833	Asan	a large city in the distance... probably	city_art
2101	city	73.1833	31.5667	Chak Jhumra	a large city in the distance... probably	city_art
2102	city	-78.8844	33.7094	Myrtle Beach	a large city in the distance... probably	city_art
2103	city	-100.9333	22.1833	Soledad de Graciano Sanchez	a large city in the distance... probably	city_art
2104	city	54.0897	17.0197	Salalah	a large city in the distance... probably	city_art
2105	city	-54.72	-2.43	Santarem	a large city in the distance... probably	city_art
2106	city	38.0582	24.0883	Yanbu	a large city in the distance... probably	city_art
2107	city	139.0634	36.3895	Maebashi	a large city in the distance... probably	city_art
2108	city	36.2833	54.55	Kaluga	a large city in the distance... probably	city_art
2109	city	101.45	1.6667	Dumai	a large city in the distance... probably	city_art
2110	city	28.6419	41.0011	Beylikduzu	a large city in the distance... probably	city_art
2111	city	46.3606	40.6828	Ganca	a large city in the distance... probably	city_art
2112	city	142.3667	43.7667	Asahikawa	a large city in the distance... probably	city_art
2113	city	122.5086	-3.9907	Kendari	a large city in the distance... probably	city_art
2114	city	127.9208	37.3417	Wonju	a large city in the distance... probably	city_art
2115	city	31.0848	30.6338	Birkat as Sab`	a large city in the distance... probably	city_art
2116	city	8.5167	8.4917	Lafia	a large city in the distance... probably	city_art
2117	city	43	36.8667	Dahuk	a large city in the distance... probably	city_art
2118	city	-6.2181	53.4597	Finglas	a large city in the distance... probably	city_art
2119	city	88.3704	22.6686	Kamarhati	a large city in the distance... probably	city_art
2120	city	105.85	21.6	Thai Nguyen	a large city in the distance... probably	city_art
2121	city	130.5167	44.9167	Bamiantong	a large city in the distance... probably	city_art
2122	city	33.365	35.1725	Nicosia	a large city in the distance... probably	city_art
2123	city	-46.3922	-23.9633	Sao Vicente	a large city in the distance... probably	city_art
2124	city	-44.0869	-19.7669	Ribeirao das Neves	a large city in the distance... probably	city_art
2125	city	-17.4	14.7833	Guediawaye	a large city in the distance... probably	city_art
2126	city	-109.9389	27.4939	Ciudad Obregon	a large city in the distance... probably	city_art
2127	city	-49.2058	-25.535	Sao Jose dos Pinhais	a large city in the distance... probably	city_art
2128	city	83.2668	27.029	Campiernagar	a large city in the distance... probably	city_art
2129	city	100.889	12.9357	Phatthaya	a large city in the distance... probably	city_art
2130	city	-78.9772	35.085	Fayetteville	a large city in the distance... probably	city_art
2131	city	21.6392	47.53	Debrecen	a large city in the distance... probably	city_art
2132	city	69.5333	28.0167	Mirpur Mathelo	a large city in the distance... probably	city_art
2133	city	29.2617	40.9683	Sultanbeyli	a large city in the distance... probably	city_art
2134	city	75.71	16.83	Bijapur	a large city in the distance... probably	city_art
2135	city	120.9678	15.4908	Cabanatuan City	a large city in the distance... probably	city_art
2136	city	71.6248	24.3926	Tharad	a large city in the distance... probably	city_art
2137	city	-121.796	37.9787	Antioch	a large city in the distance... probably	city_art
2138	city	100.93	13.174	Si Racha	a large city in the distance... probably	city_art
2139	city	-101.1972	20.5703	Salamanca	a large city in the distance... probably	city_art
2140	city	73.3	16.9944	Ratnagiri	a large city in the distance... probably	city_art
2141	city	122.0933	46.0722	Ulanhot	a large city in the distance... probably	city_art
2142	city	140.3597	37.4004	Koriyama	a large city in the distance... probably	city_art
2143	city	113.1	39.8279	Yunzhong	a large city in the distance... probably	city_art
2144	city	27.8725	-26.1625	Roodepoort	a large city in the distance... probably	city_art
2145	city	44.7417	48.8056	Volzhskiy	a large city in the distance... probably	city_art
2146	city	-74.55	-8.3833	Pucallpa	a large city in the distance... probably	city_art
2147	city	121.0583	14.3583	San Pedro	a large city in the distance... probably	city_art
2148	city	-52.3425	-31.7719	Pelotas	a large city in the distance... probably	city_art
2149	city	133.5314	33.5589	Kochi	a large city in the distance... probably	city_art
2150	city	79	28.8	Rampur	a large city in the distance... probably	city_art
2151	city	110.3439	1.5575	Kuching	a large city in the distance... probably	city_art
2152	city	124.25	7.22	Cotabato	a large city in the distance... probably	city_art
2153	city	106.8591	-6.3645	Cimanggis	a large city in the distance... probably	city_art
2154	city	-72.6883	19.4456	Gonaives	a large city in the distance... probably	city_art
2155	city	39.2689	8.5414	Nazret	a large city in the distance... probably	city_art
2156	city	36.6667	-1.25	Kikuyu	a large city in the distance... probably	city_art
2157	city	-4.7796	37.8845	Cordoba	a large city in the distance... probably	city_art
2158	city	103.3194	2.0336	Kluang	a large city in the distance... probably	city_art
2159	city	39.4769	13.4969	Mekele	a large city in the distance... probably	city_art
2160	city	108.0814	35.0542	Binxian	a large city in the distance... probably	city_art
2161	city	-1.5528	47.2181	Nantes	a large city in the distance... probably	city_art
2162	city	-79.5	43.8333	Vaughan	a large city in the distance... probably	city_art
2163	city	103.2461	23.7111	Kaiyuan	a large city in the distance... probably	city_art
2164	city	-40.3083	-20.2889	Vitoria	a large city in the distance... probably	city_art
2165	city	75.5667	13.9333	Shimoga	a large city in the distance... probably	city_art
2166	city	-84.5601	42.7142	Lansing	a large city in the distance... probably	city_art
2167	city	15.05	-7.6167	Uige	a large city in the distance... probably	city_art
2168	city	79.9167	37.1167	Hotan	a large city in the distance... probably	city_art
2169	city	-77.9075	21.3839	Camaguey	a large city in the distance... probably	city_art
2170	city	-2.885	34.4169	Taourirt	a large city in the distance... probably	city_art
2171	city	-65.3	-24.1833	San Salvador de Jujuy	a large city in the distance... probably	city_art
2172	city	78.95	29.22	Kashipur	a large city in the distance... probably	city_art
2173	city	106.65	10.9667	Thu Dau Mot	a large city in the distance... probably	city_art
2174	city	45.8304	32.4907	Al Kut	a large city in the distance... probably	city_art
2175	city	-84.4587	38.0423	Lexington	a large city in the distance... probably	city_art
2176	city	106.9315	-6.9181	Sukabumi	a large city in the distance... probably	city_art
2177	city	7.6256	51.9625	Munster	a large city in the distance... probably	city_art
2178	city	17.6842	-14.6556	Menongue	a large city in the distance... probably	city_art
2179	city	-88.1162	30.6782	Mobile	a large city in the distance... probably	city_art
2180	city	43.5516	5.9527	Gode	a large city in the distance... probably	city_art
2181	city	6.2333	7.55	Okene	a large city in the distance... probably	city_art
2182	city	70.4579	21.5222	Junagadh	a large city in the distance... probably	city_art
2183	city	32.0453	54.7828	Smolensk	a large city in the distance... probably	city_art
2184	city	-108.4706	25.5744	Guasavito	a large city in the distance... probably	city_art
2185	city	126.9167	36.35	Asan	a large city in the distance... probably	city_art
2186	city	59.6	42.4667	Nukus	a large city in the distance... probably	city_art
2187	city	125.9061	39.6986	Kaech'on	a large city in the distance... probably	city_art
2188	city	-97.3928	18.4617	Tehuacan	a large city in the distance... probably	city_art
2189	city	-94.4333	18.15	Coatzacoalcos	a large city in the distance... probably	city_art
2190	city	29.7527	-2.0845	Muhanga	a large city in the distance... probably	city_art
2191	city	-80.6463	41.0993	Youngstown	a large city in the distance... probably	city_art
2192	city	122.708	48.027	Zalantun	a large city in the distance... probably	city_art
2193	city	45.1833	54.1833	Saransk	a large city in the distance... probably	city_art
2194	city	7.6008	12.9889	Katsina	a large city in the distance... probably	city_art
2195	city	-70.6833	19.8	Puerto Plata	a large city in the distance... probably	city_art
2196	city	-115.0381	36.0133	Henderson	a large city in the distance... probably	city_art
2197	city	126.866	37.476	Gwangmyeongni	a large city in the distance... probably	city_art
2198	city	32.2294	-2.8714	Geita	a large city in the distance... probably	city_art
2199	city	37.9	59.1167	Cherepovets	a large city in the distance... probably	city_art
2200	city	-45.5556	-23.025	Taubate	a large city in the distance... probably	city_art
2201	city	109.083	13.917	An Nhon	a large city in the distance... probably	city_art
2202	city	-74.1411	4.6786	Fontibon	a large city in the distance... probably	city_art
2203	city	77.7757	28.7309	Hapur	a large city in the distance... probably	city_art
2204	city	74.0997	31.1725	Kot Radha Kishan	a large city in the distance... probably	city_art
2205	city	-46.8764	-23.5111	Barueri	a large city in the distance... probably	city_art
2206	city	-89.1914	13.6989	San Salvador	a large city in the distance... probably	city_art
2207	city	-81.1821	32.0286	Savannah	a large city in the distance... probably	city_art
2208	city	127.6792	26.2122	Naha	a large city in the distance... probably	city_art
2209	city	16.8667	41.1253	Bari	a large city in the distance... probably	city_art
2210	city	113.2509	22.6721	Xiaoli	a large city in the distance... probably	city_art
2211	city	76.2144	10.5276	Trichur	a large city in the distance... probably	city_art
2212	city	8.4661	49.4878	Mannheim	a large city in the distance... probably	city_art
2213	city	31.5608	6.2125	Bor	a large city in the distance... probably	city_art
2214	city	105.15	9.1833	Ca Mau	a large city in the distance... probably	city_art
2215	city	55.4481	-20.8789	Saint-Denis	a large city in the distance... probably	city_art
2216	city	-79.5	9.033	San Miguelito	a large city in the distance... probably	city_art
2217	city	102.5667	2.05	Muar	a large city in the distance... probably	city_art
2218	city	74.45	31.1167	Kasur	a large city in the distance... probably	city_art
2219	city	-74.1522	4.4464	Usme	a large city in the distance... probably	city_art
2220	city	87.8667	23.2333	Barddhaman	a large city in the distance... probably	city_art
2221	city	-73.9211	41.695	Poughkeepsie	a large city in the distance... probably	city_art
2222	city	-0.3325	53.7444	Kingston upon Hull	a large city in the distance... probably	city_art
2223	city	121.1919	14.4514	Binangonan	a large city in the distance... probably	city_art
2224	city	-6.9122	33.9267	Temara	a large city in the distance... probably	city_art
2225	city	-4.0333	5.3333	Attiecoube	a large city in the distance... probably	city_art
2226	city	98.2882	39.7732	Jiayuguan	a large city in the distance... probably	city_art
2227	city	103.9356	1.5028	Pasir Gudang	a large city in the distance... probably	city_art
2228	city	39.9	59.2167	Vologda	a large city in the distance... probably	city_art
2229	city	54.4414	36.8378	Gorgan	a large city in the distance... probably	city_art
2230	city	120.8531	14.3944	Tanza	a large city in the distance... probably	city_art
2231	city	129.73	62.03	Yakutsk	a large city in the distance... probably	city_art
2232	city	73.1139	18.9944	Panvel	a large city in the distance... probably	city_art
2233	city	-117.8819	33.7367	Santa Ana	a large city in the distance... probably	city_art
2234	city	-46.2564	-23.9936	Guaruja	a large city in the distance... probably	city_art
2235	city	78.094	18.672	Nizamabad	a large city in the distance... probably	city_art
2236	city	109.2333	13.7667	Quy Nhon	a large city in the distance... probably	city_art
2237	city	41.6833	27.5167	Ha'il	a large city in the distance... probably	city_art
2238	city	113.9436	22.9406	Datang	a large city in the distance... probably	city_art
2239	city	114.786	25.9106	Longquan	a large city in the distance... probably	city_art
2240	city	18.6181	-34.0506	Mitchells Plain	a large city in the distance... probably	city_art
2241	city	127.2833	37.3667	Gwangju	a large city in the distance... probably	city_art
2242	city	136.6244	34.965	Yokkaichi	a large city in the distance... probably	city_art
2243	city	-98.8975	19.2647	Chalco	a large city in the distance... probably	city_art
2244	city	51.0236	35.6722	Shahriar	a large city in the distance... probably	city_art
2245	city	51.1119	35.7097	Shahr-e Qods	a large city in the distance... probably	city_art
2246	city	65.35	55.4667	Kurgan	a large city in the distance... probably	city_art
2247	city	-54.6167	-25.5167	Ciudad del Este	a large city in the distance... probably	city_art
2248	city	-83.731	42.2759	Ann Arbor	a large city in the distance... probably	city_art
2249	city	-93.1039	44.9478	St. Paul	a large city in the distance... probably	city_art
2250	city	8.404	49.0092	Karlsruhe	a large city in the distance... probably	city_art
2251	city	-9.2333	32.2833	Safi	a large city in the distance... probably	city_art
2252	city	-100.0833	25.65	Ciudad Benito Juarez	a large city in the distance... probably	city_art
2253	city	107.295	-6.3125	Karawang	a large city in the distance... probably	city_art
2254	city	125.7597	38.5064	Sariwon	a large city in the distance... probably	city_art
2255	city	-46.3108	-23.5428	Suzano	a large city in the distance... probably	city_art
2256	city	-74.1725	40.7245	Newark	a large city in the distance... probably	city_art
2257	city	105.75	19.417	Nghi Son	a large city in the distance... probably	city_art
2258	city	76.78	19.27	Parbhani	a large city in the distance... probably	city_art
2259	city	118.75	9.75	Puerto Princesa	a large city in the distance... probably	city_art
2260	city	75.7	29.15	Hisar	a large city in the distance... probably	city_art
2261	city	44.6775	43.04	Vladikavkaz	a large city in the distance... probably	city_art
2262	city	-83	42.2833	Windsor	a large city in the distance... probably	city_art
2263	city	136.9722	35.2475	Kasugai	a large city in the distance... probably	city_art
2264	city	-100.45	25.6833	Ciudad Santa Catarina	a large city in the distance... probably	city_art
2265	city	-64.6333	10.2	Puerto La Cruz	a large city in the distance... probably	city_art
2266	city	74.95	27.98	Fatehpur	a large city in the distance... probably	city_art
2267	city	-99.1431	23.7389	Ciudad Victoria	a large city in the distance... probably	city_art
2268	city	-87.0755	20.6281	Playa del Carmen	a large city in the distance... probably	city_art
2269	city	38.2489	38.2961	Yesilyurt	a large city in the distance... probably	city_art
2270	city	116.6458	39.9131	Yonghetun	a large city in the distance... probably	city_art
2271	city	-117.7738	33.6772	Irvine	a large city in the distance... probably	city_art
2272	city	51.4325	33.9825	Kashan	a large city in the distance... probably	city_art
2273	city	6.5569	9.6139	Minna	a large city in the distance... probably	city_art
2274	city	31.6167	-7.9667	Sumbawanga	a large city in the distance... probably	city_art
2275	city	36.0694	52.9686	Orel	a large city in the distance... probably	city_art
2276	city	140.1026	39.72	Akita	a large city in the distance... probably	city_art
2277	city	130.5083	33.3192	Kurume	a large city in the distance... probably	city_art
2278	city	31.5	30.5667	Az Zaqaziq	a large city in the distance... probably	city_art
2279	city	37.5456	55.4311	Podolsk	a large city in the distance... probably	city_art
2280	city	-48.3336	-10.1844	Palmas	a large city in the distance... probably	city_art
2281	city	3.8772	43.6119	Montpellier	a large city in the distance... probably	city_art
2282	city	-8.6167	41.1333	Vila Nova de Gaia	a large city in the distance... probably	city_art
2283	city	-62.2667	-38.7167	Bahia Blanca	a large city in the distance... probably	city_art
2284	city	32.4245	26.0808	Al Waqf	a large city in the distance... probably	city_art
2285	city	-70.7	-33.5833	San Bernardo	a large city in the distance... probably	city_art
2286	city	-99.9833	20.3833	San Juan del Rio	a large city in the distance... probably	city_art
2287	city	-75.68	4.53	Armenia	a large city in the distance... probably	city_art
2288	city	10.8978	48.3689	Augsburg	a large city in the distance... probably	city_art
2289	city	109.712	28.276	Qianzhou	a large city in the distance... probably	city_art
2290	city	-76.6092	2.4542	Popayan	a large city in the distance... probably	city_art
2291	city	41.0789	19.1264	Al Qunfudhah	a large city in the distance... probably	city_art
2292	city	113.5269	33.295	Yakou	a large city in the distance... probably	city_art
2293	city	-1.6102	54.978	Newcastle	a large city in the distance... probably	city_art
2294	city	79.7737	11.957	Oulgaret	a large city in the distance... probably	city_art
2295	city	38.4667	7.05	Awasa	a large city in the distance... probably	city_art
2296	city	88.1433	25.0119	Ingraj Bazar	a large city in the distance... probably	city_art
2297	city	-96.7253	17.0606	Oaxaca	a large city in the distance... probably	city_art
2298	city	98.4803	3.5986	Binjai	a large city in the distance... probably	city_art
2299	city	35.9	33.775	Barr Elias	a large city in the distance... probably	city_art
2300	city	72.2328	29.58	Khairpur Tamewah	a large city in the distance... probably	city_art
2301	city	-65.26	-19.0475	Sucre	a large city in the distance... probably	city_art
2302	city	29.7604	31.0959	Al `Ajami	a large city in the distance... probably	city_art
2303	city	32.0333	31.1833	Al Matariyah	a large city in the distance... probably	city_art
2304	city	85.4	22.12	Bada Barabil	a large city in the distance... probably	city_art
2305	city	44.5989	31.9636	Ash Shamiyah	a large city in the distance... probably	city_art
2306	city	-73.514	40.7846	Oyster Bay	a large city in the distance... probably	city_art
2307	city	39.01	35.95	Ar Raqqah	a large city in the distance... probably	city_art
2308	city	72.8556	32.9303	Chakwal	a large city in the distance... probably	city_art
2309	city	135	34.65	Oakashicho	a large city in the distance... probably	city_art
2310	city	30.5386	38.7578	Afyonkarahisar	a large city in the distance... probably	city_art
2311	city	77.543	13.292	Dod Ballapur	a large city in the distance... probably	city_art
2312	city	-38.3239	-12.6978	Camacari	a large city in the distance... probably	city_art
2313	city	-100.1583	25.7933	Ciudad General Escobedo	a large city in the distance... probably	city_art
2314	city	15.0903	37.5	Catania	a large city in the distance... probably	city_art
2315	city	113.6873	-8.1727	Jember	a large city in the distance... probably	city_art
2316	city	49.6	25.3833	Al Mubarraz	a large city in the distance... probably	city_art
2317	city	109.6667	-6.8833	Pekalongan	a large city in the distance... probably	city_art
2318	city	-108.9937	25.7835	Los Mochis	a large city in the distance... probably	city_art
2319	city	139.7167	35.7333	Toshima	a large city in the distance... probably	city_art
2320	city	-98.75	20.1	Pachuca	a large city in the distance... probably	city_art
2321	city	129.0333	35.3333	Yangsan	a large city in the distance... probably	city_art
2322	city	-4.7236	41.6528	Valladolid	a large city in the distance... probably	city_art
2323	city	-97.8686	22.2553	Tampico	a large city in the distance... probably	city_art
2324	city	85.518	25.197	Bihar	a large city in the distance... probably	city_art
2325	city	24.6556	60.2056	Espoo	a large city in the distance... probably	city_art
2326	city	8.7744	3.7456	Malabo	a large city in the distance... probably	city_art
2327	city	-58.9167	-34.45	Pilar	a large city in the distance... probably	city_art
2328	city	-71.6197	-33.0461	Valparaiso	a large city in the distance... probably	city_art
2329	city	108.5574	-6.7071	Cirebon	a large city in the distance... probably	city_art
2330	city	125.8078	7.4478	Tagum	a large city in the distance... probably	city_art
2331	city	-122.7067	38.4458	Santa Rosa	a large city in the distance... probably	city_art
2332	city	85.9	26.17	Darbhanga	a large city in the distance... probably	city_art
2333	city	91.2	23.45	Comilla	a large city in the distance... probably	city_art
2334	city	38.3656	38.4228	Battalgazi	a large city in the distance... probably	city_art
2335	city	131.25	-0.8667	Sorong	a large city in the distance... probably	city_art
2336	city	30.7128	31.0275	Shubrakhit	a large city in the distance... probably	city_art
2337	city	-73.0667	7.2167	Floridablanca	a large city in the distance... probably	city_art
2338	city	120.975	14.2306	Silang	a large city in the distance... probably	city_art
2339	city	-79.8311	-2.1733	Eloy Alfaro	a large city in the distance... probably	city_art
2340	city	106.7019	-6.2811	Pondokaren	a large city in the distance... probably	city_art
2341	city	77.6955	28.4512	Sikandarabad	a large city in the distance... probably	city_art
2342	city	31.6261	30.7964	Kafr Saqr	a large city in the distance... probably	city_art
2343	city	15.8556	-12.1958	Vila Teixeira da Silva	a large city in the distance... probably	city_art
2344	city	76.97	29.3875	Panipat	a large city in the distance... probably	city_art
2345	city	89.2444	25.75	Rangpur	a large city in the distance... probably	city_art
2346	city	23.1456	53.1353	Bialystok	a large city in the distance... probably	city_art
2347	city	-81.3676	40.8078	Canton	a large city in the distance... probably	city_art
2348	city	-82.5537	35.5707	Asheville	a large city in the distance... probably	city_art
2349	city	-83.6921	43.0236	Flint	a large city in the distance... probably	city_art
2350	city	-8.7124	42.2314	Vigo	a large city in the distance... probably	city_art
2351	city	-99.0931	19.6333	Coacalco	a large city in the distance... probably	city_art
2352	city	92.7178	23.7272	Aizawl	a large city in the distance... probably	city_art
2353	city	88.34	22.65	Bali	a large city in the distance... probably	city_art
2354	city	-1.75	53.8	Bradford	a large city in the distance... probably	city_art
2355	city	120.58	15.22	Mabalacat	a large city in the distance... probably	city_art
2356	city	117.5947	28.9306	Dexing	a large city in the distance... probably	city_art
2357	city	-81.7014	28.0118	Winter Haven	a large city in the distance... probably	city_art
2358	city	15.4386	47.0708	Graz	a large city in the distance... probably	city_art
2359	city	77.5161	10.45	Palni	a large city in the distance... probably	city_art
2360	city	-58.9867	-27.4514	Resistencia	a large city in the distance... probably	city_art
2361	city	45.6986	43.3125	Groznyy	a large city in the distance... probably	city_art
2362	city	-78.5936	-9.0745	Chimbote	a large city in the distance... probably	city_art
2363	city	7.7458	48.5833	Strasbourg	a large city in the distance... probably	city_art
2364	city	5.33	60.3894	Bergen	a large city in the distance... probably	city_art
2365	city	-75.65	45.4833	Gatineau	a large city in the distance... probably	city_art
2366	city	86.23	25.25	Surajgarha	a large city in the distance... probably	city_art
2367	city	109.1375	-6.8675	Tegal	a large city in the distance... probably	city_art
2368	city	-149.1091	61.1508	Anchorage	a large city in the distance... probably	city_art
2369	city	6.1667	35.55	Batna	a large city in the distance... probably	city_art
2370	city	10.2107	56.1572	Aarhus	a large city in the distance... probably	city_art
2371	city	141.1545	39.7021	Morioka	a large city in the distance... probably	city_art
2372	city	-96.6784	40.8099	Lincoln	a large city in the distance... probably	city_art
2373	city	132.9333	45.7667	Hulin	a large city in the distance... probably	city_art
2374	city	123.61	47.21	Hong'an	a large city in the distance... probably	city_art
2375	city	79.1288	18.4386	Karimnagar	a large city in the distance... probably	city_art
2376	city	120.96	14.82	Santa Maria	a large city in the distance... probably	city_art
2377	city	41.4539	52.7231	Tambov	a large city in the distance... probably	city_art
2378	city	76.06	22.96	Dewas	a large city in the distance... probably	city_art
2379	city	28.8717	41.0225	Gungoren	a large city in the distance... probably	city_art
2380	city	94.95	20.15	Magway	a large city in the distance... probably	city_art
2381	city	71.7864	40.3864	Farg`ona	a large city in the distance... probably	city_art
2382	city	-80.6369	35.3933	Concord	a large city in the distance... probably	city_art
2383	city	88.39	22.9	Hugli	a large city in the distance... probably	city_art
2384	city	88.39	22.9	Chunchura	a large city in the distance... probably	city_art
2385	city	5.41	36.19	Setif	a large city in the distance... probably	city_art
2386	city	85.18	25.7	Sonpur	a large city in the distance... probably	city_art
2387	city	139.6833	35.6333	Meguro	a large city in the distance... probably	city_art
2388	city	-79.9667	-3.2667	Machala	a large city in the distance... probably	city_art
2389	city	-57.52	-25.34	San Lorenzo	a large city in the distance... probably	city_art
2390	city	-74.0686	40.7184	Jersey City	a large city in the distance... probably	city_art
2391	city	74.47	16.7	Ichalkaranji	a large city in the distance... probably	city_art
2392	city	-70.1833	11.7167	Punto Fijo	a large city in the distance... probably	city_art
2393	city	-56.1333	-15.65	Varzea Grande	a large city in the distance... probably	city_art
2394	city	79.42	13.65	Tirupati	a large city in the distance... probably	city_art
2395	city	94.7333	16.7842	Pathein	a large city in the distance... probably	city_art
2396	city	31.2947	51.4939	Chernihiv	a large city in the distance... probably	city_art
2397	city	-75.3961	9.295	Sincelejo	a large city in the distance... probably	city_art
2398	city	23.5833	46.7667	Cluj-Napoca	a large city in the distance... probably	city_art
2399	city	-93.2916	37.1943	Springfield	a large city in the distance... probably	city_art
2400	city	-1.704	4.9433	Sekondi	a large city in the distance... probably	city_art
2401	city	-70.2489	-18.0147	Tacna	a large city in the distance... probably	city_art
2402	city	114.002	22.46	Tin Shui Wai	a large city in the distance... probably	city_art
2403	city	-39.3333	-7.2	Juazeiro do Norte	a large city in the distance... probably	city_art
2404	city	47.4306	31.0158	Al Qurnah	a large city in the distance... probably	city_art
2405	city	-5.6167	9.4167	Korhogo	a large city in the distance... probably	city_art
2406	city	74.9519	30.23	Bhatinda	a large city in the distance... probably	city_art
2407	city	19.0217	50.2625	Katowice	a large city in the distance... probably	city_art
2408	city	75.8833	19.8333	Jalna	a large city in the distance... probably	city_art
2409	city	-54.5875	-25.54	Foz do Iguacu	a large city in the distance... probably	city_art
2410	city	-2.429	53.578	Bolton	a large city in the distance... probably	city_art
2411	city	121.325	14.07	San Pablo	a large city in the distance... probably	city_art
2412	city	-99.3508	19.3611	Huixquilucan	a large city in the distance... probably	city_art
2413	city	-96.7486	33.0502	Plano	a large city in the distance... probably	city_art
2414	city	30.8546	31.0464	Qillin	a large city in the distance... probably	city_art
2415	city	-72.2269	18.5761	Croix-des-Bouquets	a large city in the distance... probably	city_art
2416	city	-90.6442	14.7189	San Juan Sacatepequez	a large city in the distance... probably	city_art
2417	city	14.5061	46.0514	Ljubljana	a large city in the distance... probably	city_art
2418	city	140.4747	37.7608	Fukushima	a large city in the distance... probably	city_art
2419	city	96.4833	17.3333	Bago	a large city in the distance... probably	city_art
2420	city	-72.3	18.55	Delmas	a large city in the distance... probably	city_art
2421	city	107.5204	26.6863	Fuquan	a large city in the distance... probably	city_art
2422	city	135.5686	34.8164	Ibaraki	a large city in the distance... probably	city_art
2423	city	-93.7955	32.4653	Shreveport	a large city in the distance... probably	city_art
2424	city	18.2925	49.8356	Ostrava	a large city in the distance... probably	city_art
2425	city	34.5514	49.5894	Poltava	a large city in the distance... probably	city_art
2426	city	8.24	50.0825	Wiesbaden	a large city in the distance... probably	city_art
2427	city	80.8322	24.6005	Satna	a large city in the distance... probably	city_art
2428	city	80.751	24.1582	Sannai	a large city in the distance... probably	city_art
2429	city	111.7551	36.569	Huozhou	a large city in the distance... probably	city_art
2430	city	-72.6667	-38.7333	Temuco	a large city in the distance... probably	city_art
2431	city	-75.7333	-14.0667	Ica	a large city in the distance... probably	city_art
2432	city	109.03	35.08	Tongchuanshi	a large city in the distance... probably	city_art
2433	city	113.08	41.03	Jining	a large city in the distance... probably	city_art
2434	city	127.7333	37.8667	Chuncheon	a large city in the distance... probably	city_art
2435	city	30.4	40.7833	Sakarya	a large city in the distance... probably	city_art
2436	city	29.5097	40.0806	Inegol	a large city in the distance... probably	city_art
2437	city	6.5897	12.6	Kaura Namoda	a large city in the distance... probably	city_art
2438	city	-90.6053	41.5565	Davenport	a large city in the distance... probably	city_art
2439	city	50.9783	35.6806	Malard	a large city in the distance... probably	city_art
2440	city	-101.8879	33.5657	Lubbock	a large city in the distance... probably	city_art
2441	city	-81.9545	28.0557	Lakeland	a large city in the distance... probably	city_art
2442	city	55.95	53.6333	Sterlitamak	a large city in the distance... probably	city_art
2443	city	64.4231	39.7667	Bukhara	a large city in the distance... probably	city_art
2444	city	-89.5561	13.995	Santa Ana	a large city in the distance... probably	city_art
2445	city	13.8417	-11.2053	Sumbe	a large city in the distance... probably	city_art
2446	city	72.36	34.7717	Mingaora	a large city in the distance... probably	city_art
2447	city	27.8	41.15	Corlu	a large city in the distance... probably	city_art
2448	city	32.625	46.6425	Kherson	a large city in the distance... probably	city_art
2449	city	121.62	13.93	Lucena	a large city in the distance... probably	city_art
2450	city	-43.1789	-22.505	Petropolis	a large city in the distance... probably	city_art
2451	city	118.9	-2.6833	Mamuju	a large city in the distance... probably	city_art
2452	city	83.5611	25.9417	Mau	a large city in the distance... probably	city_art
2453	city	76.6	60.95	Nizhnevartovsk	a large city in the distance... probably	city_art
2454	city	105.4458	10.3736	Long Xuyen	a large city in the distance... probably	city_art
2455	city	34.3333	61.7833	Petrozavodsk	a large city in the distance... probably	city_art
2456	city	128.7333	35.8167	Gyeongsan	a large city in the distance... probably	city_art
2457	city	88.48	22.72	Barasat	a large city in the distance... probably	city_art
2458	city	-86.2696	41.6767	South Bend	a large city in the distance... probably	city_art
2459	city	99.06	2.96	Pematangsiantar	a large city in the distance... probably	city_art
2460	city	5.6833	50.85	Maastricht	a large city in the distance... probably	city_art
2461	city	105.4333	21.3	Viet Tri	a large city in the distance... probably	city_art
2462	city	-1.381	54.906	Sunderland	a large city in the distance... probably	city_art
2463	city	40.9269	57.7681	Kostroma	a large city in the distance... probably	city_art
2464	city	-5.9333	6.1333	Gagnoa	a large city in the distance... probably	city_art
2465	city	113.1234	28.2573	Xingsha	a large city in the distance... probably	city_art
2466	city	41.8667	9.6	Dire Dawa	a large city in the distance... probably	city_art
2467	city	64.3692	31.5831	Lashkar Gah	a large city in the distance... probably	city_art
2468	city	-75.6167	6.1667	Itagui	a large city in the distance... probably	city_art
2469	city	-70.1333	-15.4833	Juliaca	a large city in the distance... probably	city_art
2470	city	-117.0144	32.6281	Chula Vista	a large city in the distance... probably	city_art
2471	city	-55.9	-27.3667	Posadas	a large city in the distance... probably	city_art
2472	city	79.581	27.39	Farrukhabad	a large city in the distance... probably	city_art
2473	city	-111.8514	33.2825	Chandler	a large city in the distance... probably	city_art
2474	city	126.7167	35.9833	Kunsan	a large city in the distance... probably	city_art
2475	city	127.7333	34.7333	Yeosu	a large city in the distance... probably	city_art
2476	city	65.8	38.8667	Qarshi	a large city in the distance... probably	city_art
2477	city	78.71	23.83	Saugor	a large city in the distance... probably	city_art
2478	city	27	49.4167	Khmelnytskyi	a large city in the distance... probably	city_art
2479	city	-77.3386	25.0781	Nassau	a large city in the distance... probably	city_art
2480	city	75.037	23.334	Ratlam	a large city in the distance... probably	city_art
2481	city	-63.04	-7.4639	Crato	a large city in the distance... probably	city_art
2482	city	127.6622	34.7607	Yeosu	a large city in the distance... probably	city_art
2483	city	117.4925	27.3403	Shaowu	a large city in the distance... probably	city_art
2484	city	106.53	-6.1703	Pasarkemis	a large city in the distance... probably	city_art
2485	city	-46.9194	-23.6042	Cotia	a large city in the distance... probably	city_art
2486	city	-46.7994	-23.5328	Taboao da Serra	a large city in the distance... probably	city_art
2487	city	121.1219	14.6969	San Mateo	a large city in the distance... probably	city_art
2488	city	37.7833	44.7167	Novorossiysk	a large city in the distance... probably	city_art
2489	city	136.5057	34.7184	Tsu	a large city in the distance... probably	city_art
2490	city	-89.064	42.2596	Rockford	a large city in the distance... probably	city_art
2491	city	-47.4833	-5.5333	Imperatriz	a large city in the distance... probably	city_art
2492	city	-70.0167	18.5167	Los Alcarrizos	a large city in the distance... probably	city_art
2493	city	-6.6	5.7833	Soubre	a large city in the distance... probably	city_art
2494	city	-75.9267	40.34	Reading	a large city in the distance... probably	city_art
2495	city	18.4089	47.1956	Szekesfehervar	a large city in the distance... probably	city_art
2496	city	118.9707	-3.5403	Majene	a large city in the distance... probably	city_art
2497	city	139.8167	35.7	Sumida	a large city in the distance... probably	city_art
2498	city	75.3	21.25	Chopda	a large city in the distance... probably	city_art
2499	city	14.3667	-10.85	Gabela	a large city in the distance... probably	city_art
2500	city	40.15	35.3333	Dayr az Zawr	a large city in the distance... probably	city_art
2501	city	27.5889	47.1622	Iasi	a large city in the distance... probably	city_art
2502	city	-53.8	-29.6833	Santa Maria	a large city in the distance... probably	city_art
2503	city	53.3234	36.4491	Sarta	a large city in the distance... probably	city_art
2504	city	-123.1174	44.0564	Eugene	a large city in the distance... probably	city_art
2505	city	126.9544	35.9439	Iksan	a large city in the distance... probably	city_art
2506	city	106.35	10.35	My Tho	a large city in the distance... probably	city_art
2507	city	10.4525	12.8792	Nguru	a large city in the distance... probably	city_art
2508	city	28.7406	41.1856	Arnavutkoy	a large city in the distance... probably	city_art
2509	city	-1.478	52.9247	Derby	a large city in the distance... probably	city_art
2510	city	140.4712	36.3658	Mito	a large city in the distance... probably	city_art
2511	city	126.95	37.35	Kunp'o	a large city in the distance... probably	city_art
2512	city	11.17	10.2904	Gombe	a large city in the distance... probably	city_art
2513	city	113.2067	22.9253	Bijiao	a large city in the distance... probably	city_art
2514	city	32.0597	49.4444	Cherkasy	a large city in the distance... probably	city_art
2515	city	34.957	40.5455	Bayat	a large city in the distance... probably	city_art
2516	city	74.2817	34.3997	Handwara	a large city in the distance... probably	city_art
2517	city	68.8681	36.7286	Kunduz	a large city in the distance... probably	city_art
2518	city	81.28	21.19	Drug	a large city in the distance... probably	city_art
2519	city	-77.8866	34.2099	Wilmington	a large city in the distance... probably	city_art
2520	city	6.4333	51.2	Monchengladbach	a large city in the distance... probably	city_art
2521	city	-5.7	43.5333	Gijon	a large city in the distance... probably	city_art
2522	city	91.108	23.9656	Brahmanbaria	a large city in the distance... probably	city_art
2523	city	-118.4964	34.4175	Santa Clarita	a large city in the distance... probably	city_art
2524	city	106.3422	20.4461	Thai Binh	a large city in the distance... probably	city_art
2525	city	140.1154	35.4981	Ichihara	a large city in the distance... probably	city_art
2526	city	-64.7333	-21.5333	Tarija	a large city in the distance... probably	city_art
2527	city	31.01	30.5586	Shibin al Kawm	a large city in the distance... probably	city_art
2528	city	-4.1422	50.3714	Plymouth	a large city in the distance... probably	city_art
2529	city	32.8997	24.0889	Aswan	a large city in the distance... probably	city_art
2530	city	18.3065	4.3137	Bimo	a large city in the distance... probably	city_art
2531	city	33.075	68.9706	Murmansk	a large city in the distance... probably	city_art
2532	city	-111.7463	33.31	Gilbert	a large city in the distance... probably	city_art
2533	city	7.1	13.4833	Maradi	a large city in the distance... probably	city_art
2534	city	103.5	19.4167	Xiangkhoang	a large city in the distance... probably	city_art
2535	city	77.599	14.68	Anantapur	a large city in the distance... probably	city_art
2536	city	38.2778	37.7639	Adiyaman	a large city in the distance... probably	city_art
2537	city	29.9833	39.4167	Kutahya	a large city in the distance... probably	city_art
2538	city	47.8833	56.65	Yoshkar-Ola	a large city in the distance... probably	city_art
2539	city	-49.1167	-5.35	Maraba	a large city in the distance... probably	city_art
2540	city	-123.0244	44.9233	Salem	a large city in the distance... probably	city_art
2541	city	-106.6833	52.1333	Saskatoon	a large city in the distance... probably	city_art
2542	city	-47.2669	-22.8219	Sumare	a large city in the distance... probably	city_art
2543	city	-97.7297	31.0753	Killeen	a large city in the distance... probably	city_art
2544	city	138.8512	37.4462	Nagaoka	a large city in the distance... probably	city_art
2545	city	3.25	34.6667	Djelfa	a large city in the distance... probably	city_art
2546	city	34.8028	50.9119	Sumy	a large city in the distance... probably	city_art
2547	city	72.4667	34.9333	Khwazakhela	a large city in the distance... probably	city_art
2548	city	25.9333	48.3	Chernivtsi	a large city in the distance... probably	city_art
2549	city	127.4875	34.9506	Suncheon	a large city in the distance... probably	city_art
2550	city	38.9167	-6.7667	Kibaha	a large city in the distance... probably	city_art
2551	city	43.6167	43.4833	Nalchik	a large city in the distance... probably	city_art
2552	city	10.76	34.74	Sfax	a large city in the distance... probably	city_art
2553	city	3.7253	51.0536	Gent	a large city in the distance... probably	city_art
2554	city	-50.9833	-29.9333	Gravatai	a large city in the distance... probably	city_art
2555	city	47.0333	-19.8667	Antsirabe	a large city in the distance... probably	city_art
2556	city	91.41	23.0183	Feni	a large city in the distance... probably	city_art
2557	city	46.1222	51.5017	Engels	a large city in the distance... probably	city_art
2558	city	93.9384	24.8074	Imphal	a large city in the distance... probably	city_art
2559	city	97.0354	20.7836	Taunggyi	a large city in the distance... probably	city_art
2560	city	-110.9333	31.3	Nogales	a large city in the distance... probably	city_art
2561	city	26.1283	11.4608	Ed Daein	a large city in the distance... probably	city_art
2562	city	48.4144	32.3786	Dezful	a large city in the distance... probably	city_art
2563	city	-37.3439	-5.1878	Mossoro	a large city in the distance... probably	city_art
2564	city	-88.0811	42.3791	Round Lake Beach	a large city in the distance... probably	city_art
2565	city	-65.7533	-19.5892	Potosi	a large city in the distance... probably	city_art
2566	city	36.25	37.075	Osmaniye	a large city in the distance... probably	city_art
2567	city	-84.8771	32.51	Columbus	a large city in the distance... probably	city_art
2568	city	-48.6667	-26.9	Itajai	a large city in the distance... probably	city_art
2569	city	-115.0888	36.2883	North Las Vegas	a large city in the distance... probably	city_art
2570	city	69.5167	36.7167	Taluqan	a large city in the distance... probably	city_art
2571	city	28.6333	44.1667	Constanta	a large city in the distance... probably	city_art
2572	city	-57.4872	-25.27	Luque	a large city in the distance... probably	city_art
2573	city	135.601	34.6269	Yao	a large city in the distance... probably	city_art
2574	city	70.4478	34.4342	Jalalabad	a large city in the distance... probably	city_art
2575	city	68.41	26.2442	Nawabshah	a large city in the distance... probably	city_art
2576	city	123.83	10.25	Talisay	a large city in the distance... probably	city_art
2577	city	7.1	51.5167	Gelsenkirchen	a large city in the distance... probably	city_art
2578	city	81.92	19.18	Jagdalpur	a large city in the distance... probably	city_art
2579	city	11.3731	-4.1794	Tchibota	a large city in the distance... probably	city_art
2580	city	30.13	31.1311	Kafr ad Dawwar	a large city in the distance... probably	city_art
2581	city	-58.2667	-34.7167	Quilmes	a large city in the distance... probably	city_art
2582	city	150.8831	-34.4331	Wollongong	a large city in the distance... probably	city_art
2583	city	28.6667	50.25	Zhytomyr	a large city in the distance... probably	city_art
2584	city	-44.1039	-22.5228	Volta Redonda	a large city in the distance... probably	city_art
2585	city	136.2196	36.0641	Fukui	a large city in the distance... probably	city_art
2586	city	84.6603	25.5514	Arrah	a large city in the distance... probably	city_art
2587	city	120.8114	14.8433	Malolos	a large city in the distance... probably	city_art
2588	city	-110.9458	31.3186	Heroica Nogales	a large city in the distance... probably	city_art
2589	city	33.9894	-2.7919	Bariadi	a large city in the distance... probably	city_art
2590	city	12.9303	10.2317	Hong	a large city in the distance... probably	city_art
2591	city	-5.4167	6.3833	Oume	a large city in the distance... probably	city_art
2592	city	139.4776	35.6689	Fuchu	a large city in the distance... probably	city_art
2593	city	139.7514	35.6581	Minato	a large city in the distance... probably	city_art
2594	city	28.2625	-26.2125	Boksburg	a large city in the distance... probably	city_art
2595	city	120.28	14.83	Olongapo	a large city in the distance... probably	city_art
2596	city	108.8	15.1167	Quang Ngai	a large city in the distance... probably	city_art
2597	city	45.0086	31.7339	Al Hamzah	a large city in the distance... probably	city_art
2598	city	-119.1732	46.1978	Kennewick	a large city in the distance... probably	city_art
2599	city	70.9425	40.5286	Qo`qon	a large city in the distance... probably	city_art
2600	city	68.3013	25.374	Kotri	a large city in the distance... probably	city_art
2601	city	-82.6652	27.7931	St. Petersburg	a large city in the distance... probably	city_art
2602	city	15.092	32.3775	Misratah	a large city in the distance... probably	city_art
2603	city	27.8453	37.8481	Aydin	a large city in the distance... probably	city_art
2604	city	33.9333	13.15	Singa	a large city in the distance... probably	city_art
2605	city	-80.7162	-0.95	Manta	a large city in the distance... probably	city_art
2606	city	-84.2527	30.4551	Tallahassee	a large city in the distance... probably	city_art
2607	city	134.8333	34.75	Kakogawacho-honmachi	a large city in the distance... probably	city_art
2608	city	30.5567	37.7647	Isparta	a large city in the distance... probably	city_art
2609	city	39.3167	37.75	Siverek	a large city in the distance... probably	city_art
2610	city	15.8333	-11.4833	Ndulo	a large city in the distance... probably	city_art
2611	city	30.7075	36.8874	Antalya	a large city in the distance... probably	city_art
2612	city	110.1	34.5833	Huayin	a large city in the distance... probably	city_art
2613	city	139.35	35.3167	Hiratsuka	a large city in the distance... probably	city_art
2614	city	44.8836	36.255	Raniyah	a large city in the distance... probably	city_art
2615	city	7.7667	36.9	Annaba	a large city in the distance... probably	city_art
2616	city	-41.9333	-18.85	Governador Valadares	a large city in the distance... probably	city_art
2617	city	37.445	55.8892	Khimki	a large city in the distance... probably	city_art
2618	city	4.8333	7.0833	Ondo	a large city in the distance... probably	city_art
2619	city	79.03	26.77	Etawah	a large city in the distance... probably	city_art
2620	city	90.5167	23.6833	Siddhirganj	a large city in the distance... probably	city_art
2621	city	38.05	48.3	Horlivka	a large city in the distance... probably	city_art
2622	city	-47.2181	-23.0903	Indaiatuba	a large city in the distance... probably	city_art
2623	city	26.2167	-29.1167	Bloemfontein	a large city in the distance... probably	city_art
2624	city	108.4667	11.9333	Ap Da Loi	a large city in the distance... probably	city_art
2625	city	63.5667	39.0833	Turkmenabat	a large city in the distance... probably	city_art
2626	city	78.5362	17.4519	Malkajgiri	a large city in the distance... probably	city_art
2627	city	-2.6833	42.85	Vitoria-Gasteiz	a large city in the distance... probably	city_art
2628	city	28.1672	-26.2178	Germiston	a large city in the distance... probably	city_art
2629	city	100.5167	13.8667	Nonthaburi	a large city in the distance... probably	city_art
2630	city	10.9928	45.4386	Verona	a large city in the distance... probably	city_art
2631	city	29.3006	40.8161	Tuzla	a large city in the distance... probably	city_art
2632	city	-0.1353	51.4947	Westminster	a large city in the distance... probably	city_art
2633	city	-99.4874	27.5625	Laredo	a large city in the distance... probably	city_art
2634	city	103.1361	5.3292	Kuala Terengganu	a large city in the distance... probably	city_art
2635	city	-90.3	15.4667	San Pedro Carcha	a large city in the distance... probably	city_art
2636	city	12.1508	-15.1953	Mocamedes	a large city in the distance... probably	city_art
2637	city	-96.9702	32.8583	Irving	a large city in the distance... probably	city_art
2638	city	-67.4725	10.2283	Turmero	a large city in the distance... probably	city_art
2639	city	134.55	34.0667	Tokushima	a large city in the distance... probably	city_art
2640	city	-47.8908	-22	Sao Carlos	a large city in the distance... probably	city_art
2641	city	-73.5167	45.5333	Longueuil	a large city in the distance... probably	city_art
2642	city	120.9481	14.7581	Marilao	a large city in the distance... probably	city_art
2643	city	82.55	17.35	Tuni	a large city in the distance... probably	city_art
2644	city	46.1717	31.4097	Ash Shatrah	a large city in the distance... probably	city_art
2645	city	44.1536	33.4644	Sab` al Bur	a large city in the distance... probably	city_art
2646	city	-61.0667	14.6	Fort-de-France	a large city in the distance... probably	city_art
2647	city	97.6258	16.4847	Mawlamyine	a large city in the distance... probably	city_art
2648	city	-89.6154	40.752	Peoria	a large city in the distance... probably	city_art
2649	city	2.35	6.3667	Godome	a large city in the distance... probably	city_art
2650	city	70.63	23.57	Rapar	a large city in the distance... probably	city_art
2651	city	85.7811	25.8629	Samastipur	a large city in the distance... probably	city_art
2652	city	34.0289	38.3742	Aksaray	a large city in the distance... probably	city_art
2653	city	130.9414	33.9578	Shinozaki	a large city in the distance... probably	city_art
2654	city	-35.25	-5.9167	Parnamirim	a large city in the distance... probably	city_art
2655	city	40.5861	37.1939	Kiziltepe	a large city in the distance... probably	city_art
2656	city	89.1833	23.5417	Jhenida	a large city in the distance... probably	city_art
2657	city	22.2667	60.45	Turku	a large city in the distance... probably	city_art
2658	city	77.48	27.22	Bharatpur	a large city in the distance... probably	city_art
2659	city	6.0836	50.7756	Aachen	a large city in the distance... probably	city_art
2660	city	86.13	25.42	Begusarai	a large city in the distance... probably	city_art
2661	city	112.0047	-7.8111	Kediri	a large city in the distance... probably	city_art
2662	city	126.6	40.9667	Kanggye	a large city in the distance... probably	city_art
2663	city	120.4497	23.48	Chiayi	a large city in the distance... probably	city_art
2664	city	29.1786	41.0369	Cekme	a large city in the distance... probably	city_art
2665	city	140.7289	41.7686	Hakodate	a large city in the distance... probably	city_art
2666	city	125	11.24	Tacloban	a large city in the distance... probably	city_art
2667	city	82.9338	19.8599	Junagarh	a large city in the distance... probably	city_art
2668	city	10.5167	52.2667	Braunschweig	a large city in the distance... probably	city_art
2669	city	36.165	36.5817	Iskenderun	a large city in the distance... probably	city_art
2670	city	18.2331	46.0711	Pecs	a large city in the distance... probably	city_art
2671	city	139.8053	35.8254	Soka	a large city in the distance... probably	city_art
2672	city	76.6889	8.9139	Nedumana	a large city in the distance... probably	city_art
2673	city	-68.7	18.6167	Higuey	a large city in the distance... probably	city_art
2674	city	-67.0417	10.3333	Los Teques	a large city in the distance... probably	city_art
2675	city	-86.2668	32.3482	Montgomery	a large city in the distance... probably	city_art
2676	city	111.908	29.5	Jinshi	a large city in the distance... probably	city_art
2677	city	-2.1333	52.5833	Wolverhampton	a large city in the distance... probably	city_art
2678	city	-61.5331	16.2411	Pointe-a-Pitre	a large city in the distance... probably	city_art
2679	city	43.7833	33.35	Al Fallujah	a large city in the distance... probably	city_art
2680	city	21.23	45.7597	Timisoara	a large city in the distance... probably	city_art
2681	city	9.77	1.865	Bata	a large city in the distance... probably	city_art
2682	city	105.0833	10.0167	Rach Gia	a large city in the distance... probably	city_art
2683	city	91.2833	22.875	Companiganj	a large city in the distance... probably	city_art
2684	city	12.3358	45.4375	Venice	a large city in the distance... probably	city_art
2685	city	38.9167	47.2167	Taganrog	a large city in the distance... probably	city_art
2686	city	52.6783	36.5475	Babol	a large city in the distance... probably	city_art
2687	city	-48.6167	-27.6	Sao Jose	a large city in the distance... probably	city_art
2688	city	-110.3108	24.1422	La Paz	a large city in the distance... probably	city_art
2689	city	21.7417	32.7664	Al Bayda'	a large city in the distance... probably	city_art
2690	city	95.65	21.4167	Natogyi	a large city in the distance... probably	city_art
2691	city	34.2833	10.55	Kurmuk	a large city in the distance... probably	city_art
2692	city	31.8256	31.5125	Ras el-Barr	a large city in the distance... probably	city_art
2693	city	45.3222	34.6292	Kalar	a large city in the distance... probably	city_art
2694	city	57.3289	37.4722	Bojnurd	a large city in the distance... probably	city_art
2695	city	68.2692	43.3019	Turkistan	a large city in the distance... probably	city_art
2696	city	77.2089	28.6139	New Delhi	a large city in the distance... probably	city_art
2697	city	-70.55	-33.4117	Las Condes	a large city in the distance... probably	city_art
2698	city	29.2336	-1.6794	Goma	a large city in the distance... probably	city_art
2699	city	34.8	31.95	Rishon LeZiyyon	a large city in the distance... probably	city_art
2700	city	137	50.5667	Komsomol'sk-na-Amure	a large city in the distance... probably	city_art
2701	city	-90.5306	19.85	Campeche	a large city in the distance... probably	city_art
2702	city	117.379	49.598	Manzhouli	a large city in the distance... probably	city_art
2703	city	80.3	13.16	Tiruvottiyur	a large city in the distance... probably	city_art
2704	city	113.92	-2.21	Palangkaraya	a large city in the distance... probably	city_art
2705	city	-76.3023	36.6778	Chesapeake	a large city in the distance... probably	city_art
2706	city	-122.9667	49.2667	Burnaby	a large city in the distance... probably	city_art
2707	city	84.32	27.17	Ramnagar	a large city in the distance... probably	city_art
2708	city	-47.4019	-22.565	Limeira	a large city in the distance... probably	city_art
2709	city	-91.8306	18.6431	Carmen	a large city in the distance... probably	city_art
2710	city	70.13	23.08	Gandhidham	a large city in the distance... probably	city_art
2711	city	2.4333	11.3	Banikoara	a large city in the distance... probably	city_art
2712	city	12.9167	50.8333	Chemnitz	a large city in the distance... probably	city_art
2713	city	74.02	24.08	Salumbar	a large city in the distance... probably	city_art
2714	city	129.2167	35.85	Kyongju	a large city in the distance... probably	city_art
2715	city	-71.19	8.48	Merida	a large city in the distance... probably	city_art
2716	city	-112.2311	33.5791	Glendale	a large city in the distance... probably	city_art
2717	city	111.8308	2.2878	Sibu	a large city in the distance... probably	city_art
2718	city	52.8581	36.4636	Qa'em Shahr	a large city in the distance... probably	city_art
2719	city	-60.5297	-31.7331	Parana	a large city in the distance... probably	city_art
2720	city	28.5775	41.02	Buyukcekmece	a large city in the distance... probably	city_art
2721	city	10.1394	54.3233	Kiel	a large city in the distance... probably	city_art
2722	city	73.1083	30.6611	Sahiwal	a large city in the distance... probably	city_art
2723	city	-8.41	43.365	A Coruna	a large city in the distance... probably	city_art
2724	city	120.9417	14.6667	Navotas	a large city in the distance... probably	city_art
2725	city	-79.9649	22.4069	Santa Clara	a large city in the distance... probably	city_art
2726	city	68.4208	27.0994	Mehrabpur	a large city in the distance... probably	city_art
2727	city	140.3396	38.2554	Yamagata	a large city in the distance... probably	city_art
2728	city	-76.7315	39.9651	York	a large city in the distance... probably	city_art
2729	city	51.5361	32.6803	Khomeyni Shahr	a large city in the distance... probably	city_art
2730	city	29.0922	41.1342	Beykoz	a large city in the distance... probably	city_art
2731	city	140.0764	36.0835	Tsukuba-kenkyugakuen-toshi	a large city in the distance... probably	city_art
2732	city	-67.15	-17.9833	Oruro	a large city in the distance... probably	city_art
2733	city	-41.7869	-22.3708	Macae	a large city in the distance... probably	city_art
2734	city	17.6344	47.6842	Gyor	a large city in the distance... probably	city_art
2735	city	31.7415	30.3065	Al `Ashir min Ramadan	a large city in the distance... probably	city_art
2736	city	46.3167	-15.7167	Mahajanga	a large city in the distance... probably	city_art
2737	city	79.8758	6.8731	Mount Lavinia	a large city in the distance... probably	city_art
2738	city	-0.8938	52.2304	Northampton	a large city in the distance... probably	city_art
2739	city	77.6951	13.012	Krishnarajpur	a large city in the distance... probably	city_art
2740	city	73.6878	32.0714	Hafizabad	a large city in the distance... probably	city_art
2741	city	77.374	13.102	Nelamangala	a large city in the distance... probably	city_art
2742	city	113.11	40.437	Beichengqu	a large city in the distance... probably	city_art
2743	city	-3.95	51.6167	Abertawe	a large city in the distance... probably	city_art
2744	city	50.8167	61.6667	Syktyvkar	a large city in the distance... probably	city_art
2745	city	26.2519	50.6192	Rivne	a large city in the distance... probably	city_art
2746	city	18.54	54.5175	Gdynia	a large city in the distance... probably	city_art
2747	city	-71.491	42.7491	Nashua	a large city in the distance... probably	city_art
2748	city	-1.4791	53.5547	Barnsley	a large city in the distance... probably	city_art
2749	city	100.7333	4.85	Taiping	a large city in the distance... probably	city_art
2750	city	-54.6333	-16.4667	Rondonopolis	a large city in the distance... probably	city_art
2751	city	-44.05	-2.55	Sao Jose de Ribamar	a large city in the distance... probably	city_art
2752	city	79.8167	11.9167	Puducherry	a large city in the distance... probably	city_art
2753	city	-58.7275	-34.6653	Merlo	a large city in the distance... probably	city_art
2754	city	-80.4553	-1.0561	Portoviejo	a large city in the distance... probably	city_art
2755	city	30.4694	31.0361	Damanhur	a large city in the distance... probably	city_art
2756	city	-96.6304	32.91	Garland	a large city in the distance... probably	city_art
2757	city	24.48	-6.13	Kabinda	a large city in the distance... probably	city_art
2758	city	89.2	23.1704	Jessore	a large city in the distance... probably	city_art
2759	city	79.9386	6.7953	Kesbewa	a large city in the distance... probably	city_art
2760	city	35.8344	34.4367	Tripoli	a large city in the distance... probably	city_art
2761	city	138.6763	35.1613	Fuji	a large city in the distance... probably	city_art
2762	city	5.4833	51.4333	Eindhoven	a large city in the distance... probably	city_art
2763	city	57.6764	36.2125	Sabzevar	a large city in the distance... probably	city_art
2764	city	-54.8058	-22.2208	Dourados	a large city in the distance... probably	city_art
2765	city	37.3833	11.6	Bahir Dar	a large city in the distance... probably	city_art
2766	city	129.715	33.18	Yoshiicho-shimobaru	a large city in the distance... probably	city_art
2767	city	97.4	25.3833	Myitkyina	a large city in the distance... probably	city_art
2768	city	79.475	18.7639	Ramgundam	a large city in the distance... probably	city_art
2769	city	72.4333	24.1722	Palanpur	a large city in the distance... probably	city_art
2770	city	109.295	13.0819	Tuy Hoa	a large city in the distance... probably	city_art
2771	city	129.715	33.18	Sasebo	a large city in the distance... probably	city_art
2772	city	5.6667	5.9	Sapele	a large city in the distance... probably	city_art
2773	city	87.2797	26.4542	Biratnagar	a large city in the distance... probably	city_art
2774	city	75.3278	17.6778	Pandharpur	a large city in the distance... probably	city_art
2775	city	65.5167	44.85	Qyzylorda	a large city in the distance... probably	city_art
2776	city	-79.2333	43.1833	St. Catharines	a large city in the distance... probably	city_art
2777	city	139.4	35.3333	Chigasaki	a large city in the distance... probably	city_art
2778	city	-48.1758	-21.7939	Araraquara	a large city in the distance... probably	city_art
2779	city	32.6	-3.8375	Kahama	a large city in the distance... probably	city_art
2780	city	11.9697	51.4828	Halle	a large city in the distance... probably	city_art
2781	city	-47.3311	-22.7386	Americana	a large city in the distance... probably	city_art
2782	city	117.42	25.2902	Zhangping	a large city in the distance... probably	city_art
2783	city	-7.55	7.4	Man	a large city in the distance... probably	city_art
2784	city	-44.2469	-19.4658	Sete Lagoas	a large city in the distance... probably	city_art
2785	city	90.8	23.2	Banchpar	a large city in the distance... probably	city_art
2786	city	125.7167	38.0333	Haeju	a large city in the distance... probably	city_art
2787	city	-89.15	13.7333	Soyapango	a large city in the distance... probably	city_art
2788	city	85.02	25.35	Masaurhi Buzurg	a large city in the distance... probably	city_art
2789	city	-66.8739	10.4322	Baruta	a large city in the distance... probably	city_art
2790	city	31.1583	40.8417	Duzce	a large city in the distance... probably	city_art
2791	city	-49.9458	-22.2139	Marilia	a large city in the distance... probably	city_art
2792	city	87.58	25.53	Katihar	a large city in the distance... probably	city_art
2793	city	-111.8651	33.6872	Scottsdale	a large city in the distance... probably	city_art
2794	city	-76.3667	-6.4833	Tarapoto	a large city in the distance... probably	city_art
2795	city	76.1684	39.7162	Atushi	a large city in the distance... probably	city_art
2796	city	47.9725	30.4411	Abi al Khasib	a large city in the distance... probably	city_art
2797	city	-45.9658	-23.3053	Jacarei	a large city in the distance... probably	city_art
2798	city	125.66	39.62	Anju	a large city in the distance... probably	city_art
2799	city	139.75	35.7167	Bunkyo-ku	a large city in the distance... probably	city_art
2800	city	77.5922	13.0659	Byatarayanpur	a large city in the distance... probably	city_art
2801	city	72.783	25.367	Ahor	a large city in the distance... probably	city_art
2802	city	123.5667	42.4667	Diaobingshancun	a large city in the distance... probably	city_art
2803	city	11.6392	52.1317	Magdeburg	a large city in the distance... probably	city_art
2804	city	139.45	35.4833	Yato	a large city in the distance... probably	city_art
2805	city	137.972	36.238	Matsumoto	a large city in the distance... probably	city_art
2806	city	20.145	46.255	Szeged	a large city in the distance... probably	city_art
2807	city	33.45	-19.1167	Chimoio	a large city in the distance... probably	city_art
2808	city	30.1	-4.58	Kasulu	a large city in the distance... probably	city_art
2809	city	-0.6983	38.2669	Elche	a large city in the distance... probably	city_art
2810	city	34.8951	36.9165	Tarsus	a large city in the distance... probably	city_art
2811	city	24.7106	48.9228	Ivano-Frankivsk	a large city in the distance... probably	city_art
2812	city	139.5407	35.6506	Chofugaoka	a large city in the distance... probably	city_art
2813	city	-58.6167	-34.7667	Gonzalez Catan	a large city in the distance... probably	city_art
2814	city	21.7271	47.9531	Nyiregyhaza	a large city in the distance... probably	city_art
2815	city	118.0353	27.7564	Wuyishan	a large city in the distance... probably	city_art
2816	city	110.499	38.827	Shenmu	a large city in the distance... probably	city_art
2817	city	78.1348	8.7642	Tuticorin	a large city in the distance... probably	city_art
2818	city	58.1891	23.6703	As Sib	a large city in the distance... probably	city_art
2819	city	73.88	29.92	Ganganagar	a large city in the distance... probably	city_art
2820	city	25.6167	45.6667	Brasov	a large city in the distance... probably	city_art
2821	city	-92.0325	30.2082	Lafayette	a large city in the distance... probably	city_art
2822	city	52.3467	36.4703	Amol	a large city in the distance... probably	city_art
2823	city	5.7314	58.97	Stavanger	a large city in the distance... probably	city_art
2824	city	5.7361	58.8517	Sandnes	a large city in the distance... probably	city_art
2825	city	51.8167	55.6333	Nizhnekamsk	a large city in the distance... probably	city_art
2826	city	-101.4222	26.9103	Monclova	a large city in the distance... probably	city_art
2827	city	105.6975	28.5904	Chishui	a large city in the distance... probably	city_art
2828	city	1.6667	9.7	Djougou	a large city in the distance... probably	city_art
2829	city	-76.259	36.8945	Norfolk	a large city in the distance... probably	city_art
2830	city	69.0158	25.525	Mirpur Khas	a large city in the distance... probably	city_art
2831	city	3.0583	50.6278	Lille	a large city in the distance... probably	city_art
2832	city	125.8618	39.2605	P'yongsong-si	a large city in the distance... probably	city_art
2833	city	125.8178	39.1919	P'yong-dong	a large city in the distance... probably	city_art
2834	city	28.1894	-25.8603	Centurion	a large city in the distance... probably	city_art
2835	city	-73.6688	40.7912	North Hempstead	a large city in the distance... probably	city_art
2836	city	95.17	27.23	Tinkhang	a large city in the distance... probably	city_art
2837	city	81.3	24.53	Rewa	a large city in the distance... probably	city_art
2838	city	51.6794	35.485	Pakdasht	a large city in the distance... probably	city_art
2839	city	101.7889	2.9931	Kajang	a large city in the distance... probably	city_art
2840	city	34.8864	32.0889	Petah Tiqwa	a large city in the distance... probably	city_art
2841	city	42.5053	18.2169	Abha	a large city in the distance... probably	city_art
2842	city	7.85	47.995	Freiburg im Breisgau	a large city in the distance... probably	city_art
2843	city	30.7444	28.1194	Al Minya	a large city in the distance... probably	city_art
2844	city	3.6	7.9667	Iseyin	a large city in the distance... probably	city_art
2845	city	114.155	22.2867	Central District	a large city in the distance... probably	city_art
2846	city	25.9122	-24.6581	Gaborone	a large city in the distance... probably	city_art
2847	city	-77.1011	38.8786	Arlington	a large city in the distance... probably	city_art
2848	city	-40.5028	-9.4306	Juazeiro	a large city in the distance... probably	city_art
2849	city	8.9883	13.8053	Zinder	a large city in the distance... probably	city_art
2850	city	82.0514	44.8539	Bole	a large city in the distance... probably	city_art
2851	city	40.2333	47.7	Shakhty	a large city in the distance... probably	city_art
2852	city	14.6333	-13.0167	Ganda	a large city in the distance... probably	city_art
2853	city	88.11	22.47	Uluberiya	a large city in the distance... probably	city_art
2854	city	77.8497	28.4069	Bulandshahr	a large city in the distance... probably	city_art
2855	city	95.3175	5.55	Banda Aceh	a large city in the distance... probably	city_art
2856	city	51.3603	32.6447	Najafabad	a large city in the distance... probably	city_art
2857	city	139.7006	35.6594	Shibuya-ku	a large city in the distance... probably	city_art
2858	city	-76.6428	20.3817	Bayamo	a large city in the distance... probably	city_art
2859	city	33.0442	34.6747	Limassol	a large city in the distance... probably	city_art
2860	city	48.7522	33.9111	Borujerd	a large city in the distance... probably	city_art
2861	city	44.1709	13.9759	Ibb	a large city in the distance... probably	city_art
2862	city	-100.5833	25.8167	Garcia	a large city in the distance... probably	city_art
2863	city	-36.6608	-9.7519	Arapiraca	a large city in the distance... probably	city_art
2864	city	119.1333	28.0667	Longquan	a large city in the distance... probably	city_art
2865	city	113.9861	4.3925	Miri	a large city in the distance... probably	city_art
2866	city	-38.6333	-3.8667	Maracanau	a large city in the distance... probably	city_art
2867	city	51.3725	51.2225	Oral	a large city in the distance... probably	city_art
2868	city	23.8167	44.3333	Craiova	a large city in the distance... probably	city_art
2869	city	-58.1833	-26.1833	Formosa	a large city in the distance... probably	city_art
2870	city	-88.3892	44.278	Appleton	a large city in the distance... probably	city_art
2871	city	82.6	25.15	Chauhanpatti	a large city in the distance... probably	city_art
2872	city	-11.74	7.9564	Bo	a large city in the distance... probably	city_art
2873	city	15.5	5.5	Mambere	a large city in the distance... probably	city_art
2874	city	12.75	11.15	Damboa	a large city in the distance... probably	city_art
2875	city	6.5675	53.2189	Groningen	a large city in the distance... probably	city_art
2876	city	152.7608	-27.6144	Ipswich	a large city in the distance... probably	city_art
2877	city	101.0167	4.0333	Teluk Intan	a large city in the distance... probably	city_art
2878	city	-70.1056	18.4167	San Cristobal	a large city in the distance... probably	city_art
2879	city	75.3704	11.8745	Cannanore	a large city in the distance... probably	city_art
2880	city	77.37	16.2	Raichur	a large city in the distance... probably	city_art
2881	city	73.4536	30.8092	Okara	a large city in the distance... probably	city_art
2882	city	130.3	33.2667	Saga	a large city in the distance... probably	city_art
2883	city	89	25.8004	Saidpur	a large city in the distance... probably	city_art
2884	city	102.8014	23.6279	Lin'an	a large city in the distance... probably	city_art
2885	city	-49.2239	-25.2919	Colombo	a large city in the distance... probably	city_art
2886	city	81.13	16.17	Machilipatnam	a large city in the distance... probably	city_art
2887	city	29.4667	0.5	Beni	a large city in the distance... probably	city_art
2888	city	88.7605	25.0415	Nazipur	a large city in the distance... probably	city_art
2889	city	109.2417	-7.4278	Purwokerto	a large city in the distance... probably	city_art
2890	city	101.6	56.1167	Bratsk	a large city in the distance... probably	city_art
2891	city	31.2204	31.1747	Biyala	a large city in the distance... probably	city_art
2892	city	48.2825	30.3469	Madan	a large city in the distance... probably	city_art
2893	city	-70.75	-34.1667	Rancagua	a large city in the distance... probably	city_art
2894	city	105.8739	21.4156	Phu Yen	a large city in the distance... probably	city_art
2895	city	-68.0642	-38.9525	Neuquen	a large city in the distance... probably	city_art
2896	city	-44.8839	-20.1389	Divinopolis	a large city in the distance... probably	city_art
2897	city	51.5842	35.4267	Qarchak	a large city in the distance... probably	city_art
2898	city	124.6075	11.0106	Ormoc	a large city in the distance... probably	city_art
2899	city	-102.8675	23.175	Fresnillo	a large city in the distance... probably	city_art
2900	city	43.45	56.2333	Dzerzhinsk	a large city in the distance... probably	city_art
2901	city	-3.6008	37.1781	Granada	a large city in the distance... probably	city_art
2902	city	105.5	21.1333	Son Tay	a large city in the distance... probably	city_art
2903	city	108.9833	0.9	Singkawang	a large city in the distance... probably	city_art
2904	city	-5.6536	10.4875	Zegoua	a large city in the distance... probably	city_art
2905	city	103.6	1.6667	Kulai	a large city in the distance... probably	city_art
2906	city	90.3667	22.7	Barishal	a large city in the distance... probably	city_art
2907	city	73.33	25.77	Pali	a large city in the distance... probably	city_art
2908	city	73.564	21.167	Songadh	a large city in the distance... probably	city_art
2909	city	91.2333	64.4833	Noginsk	a large city in the distance... probably	city_art
2910	city	79.5133	18.7519	Gadda Madiral	a large city in the distance... probably	city_art
2911	city	58.5667	51.2	Orsk	a large city in the distance... probably	city_art
2912	city	37.8833	40.9833	Ordu	a large city in the distance... probably	city_art
2913	city	21.25	48.7167	Kosice	a large city in the distance... probably	city_art
2914	city	139.7523	35.9753	Kasukabe	a large city in the distance... probably	city_art
2915	city	79.5833	16.8667	Mirialguda	a large city in the distance... probably	city_art
2916	city	-67.1537	18.4382	Aguadilla	a large city in the distance... probably	city_art
2917	city	-75.5667	6.1667	Envigado	a large city in the distance... probably	city_art
2918	city	78.163	29.945	Haridwar	a large city in the distance... probably	city_art
2919	city	-81.0241	34.9415	Rock Hill	a large city in the distance... probably	city_art
2920	city	-121.9843	37.5265	Fremont	a large city in the distance... probably	city_art
2921	city	83.406	18.1159	Vizianagaram	a large city in the distance... probably	city_art
2922	city	-90.3667	15.4833	Coban	a large city in the distance... probably	city_art
2923	city	-5.6675	32.9394	Khenifra	a large city in the distance... probably	city_art
2924	city	-75.2139	20.1367	Guantanamo	a large city in the distance... probably	city_art
2925	city	6.5667	51.3333	Krefeld	a large city in the distance... probably	city_art
2926	city	42.6258	17.1489	Sabya	a large city in the distance... probably	city_art
2927	city	-96.8292	46.8651	Fargo	a large city in the distance... probably	city_art
2928	city	73.4477	29.5342	Raisinghnagar	a large city in the distance... probably	city_art
2929	city	29.4042	38.6778	Usak	a large city in the distance... probably	city_art
2930	city	75.18	19.17	Pathardi	a large city in the distance... probably	city_art
2931	city	-43.0408	-22.6528	Mage	a large city in the distance... probably	city_art
2932	city	-89.0704	30.4274	Gulfport	a large city in the distance... probably	city_art
2933	city	135.6333	34.7667	Neya	a large city in the distance... probably	city_art
2934	city	77.7069	8.7	Mel Palaiyam	a large city in the distance... probably	city_art
2935	city	-51.1308	-29.6778	Novo Hamburgo	a large city in the distance... probably	city_art
2936	city	-42.5333	-19.5	Ipatinga	a large city in the distance... probably	city_art
2937	city	31.6667	26.65	Saqultah	a large city in the distance... probably	city_art
2938	city	-88	15.6333	Choloma	a large city in the distance... probably	city_art
2939	city	32.2667	48.5	Kropyvnytskyi	a large city in the distance... probably	city_art
2940	city	79.97	28.92	Khatima	a large city in the distance... probably	city_art
2941	city	59.9667	41.8333	Dasoguz	a large city in the distance... probably	city_art
2942	city	71.9333	30.3	Khanewal	a large city in the distance... probably	city_art
2943	city	72.8	22.47	Petlad	a large city in the distance... probably	city_art
2944	city	34.6167	48.5167	Kamianske	a large city in the distance... probably	city_art
2945	city	-122.7121	47.5436	Bremerton	a large city in the distance... probably	city_art
2946	city	139.5932	35.9774	Ageoshimo	a large city in the distance... probably	city_art
2947	city	120.5333	24.0667	Changhua	a large city in the distance... probably	city_art
2948	city	-104.6067	50.4547	Regina	a large city in the distance... probably	city_art
2949	city	2.2461	41.4489	Badalona	a large city in the distance... probably	city_art
2950	city	117.4608	31.8883	Dianbu	a large city in the distance... probably	city_art
2951	city	30.6	59.7333	Kolpino	a large city in the distance... probably	city_art
2952	city	-50.9167	-17.745	Rio Verde	a large city in the distance... probably	city_art
2953	city	120.95	14.73	Meycauayan	a large city in the distance... probably	city_art
2954	city	-51.3889	-22.1256	Presidente Prudente	a large city in the distance... probably	city_art
2955	city	-87.9895	44.5148	Green Bay	a large city in the distance... probably	city_art
2956	city	51.6358	35.3508	Varamin	a large city in the distance... probably	city_art
2957	city	99.2722	1.3786	Padangsidempuan	a large city in the distance... probably	city_art
2958	city	15.1194	-11.3583	Uacu Cungo	a large city in the distance... probably	city_art
2959	city	-115.2278	36.0091	Enterprise	a large city in the distance... probably	city_art
2960	city	130.366	42.863	Hunchun	a large city in the distance... probably	city_art
2961	city	2.013	41.57	Tarrasa	a large city in the distance... probably	city_art
2962	city	25.6	49.5667	Ternopil	a large city in the distance... probably	city_art
2963	city	24.7639	-28.7383	Kimberley	a large city in the distance... probably	city_art
2964	city	72.86	22.69	Nadiad	a large city in the distance... probably	city_art
2965	city	49.41	-18.155	Toamasina	a large city in the distance... probably	city_art
2966	city	-1.6794	48.1147	Rennes	a large city in the distance... probably	city_art
2967	city	32.6333	-18.9667	Mutare	a large city in the distance... probably	city_art
2968	city	106.6511	-6.4947	Cikupa	a large city in the distance... probably	city_art
2969	city	68.2833	27.8	Ratodero	a large city in the distance... probably	city_art
2970	city	88.8556	23.644	Chuadanga	a large city in the distance... probably	city_art
2971	city	-78.2775	21.5767	Carlos Manuel de Cespedes	a large city in the distance... probably	city_art
2972	city	127.5333	50.25	Blagoveshchensk	a large city in the distance... probably	city_art
2973	city	125.175	44.4347	Nong'an	a large city in the distance... probably	city_art
2974	city	139.3754	36.2911	Ota	a large city in the distance... probably	city_art
2975	city	-42.8589	-22.7439	Itaborai	a large city in the distance... probably	city_art
2976	city	-105.2222	20.6458	Puerto Vallarta	a large city in the distance... probably	city_art
2977	city	-57.42	-25.35	Capiata	a large city in the distance... probably	city_art
2978	city	-51.0228	-30.0808	Viamao	a large city in the distance... probably	city_art
2979	city	135.3406	34.8114	Takarazuka	a large city in the distance... probably	city_art
2980	city	-52.6178	-27.0958	Chapeco	a large city in the distance... probably	city_art
2981	city	-58.3833	-34.75	Banfield	a large city in the distance... probably	city_art
2982	city	-99.6569	19.2925	Toluca	a large city in the distance... probably	city_art
2983	city	139.3667	35.4333	Atsugicho	a large city in the distance... probably	city_art
2984	city	-55.2039	5.8522	Paramaribo	a large city in the distance... probably	city_art
2985	city	92.005	21.4272	Cox's Bazar	a large city in the distance... probably	city_art
2986	city	50.8514	28.9264	Bandar-e Bushehr	a large city in the distance... probably	city_art
2987	city	-46.9342	-23.5489	Itapevi	a large city in the distance... probably	city_art
2988	city	37.8333	51.3	Staryy Oskol	a large city in the distance... probably	city_art
2989	city	113.2167	-7.75	Probolinggo	a large city in the distance... probably	city_art
2990	city	-80.3045	25.8696	Hialeah	a large city in the distance... probably	city_art
2991	city	79.1378	10.787	Tanjore	a large city in the distance... probably	city_art
2992	city	126.194	41.1253	Ji'an Shi	a large city in the distance... probably	city_art
2993	city	103.9	52.55	Angarsk	a large city in the distance... probably	city_art
2994	city	141.4884	40.5123	Hachinohe	a large city in the distance... probably	city_art
2995	city	3.9208	6.8208	Ijebu-Ode	a large city in the distance... probably	city_art
2996	city	31.2667	58.55	Velikiy Novgorod	a large city in the distance... probably	city_art
2997	city	13.3731	-8.4728	Barra do Dande	a large city in the distance... probably	city_art
2998	city	34.5333	36.75	Mezitli	a large city in the distance... probably	city_art
2999	city	28.0517	-26.107	Sandton	a large city in the distance... probably	city_art
3000	city	106.8176	-6.3704	Beji	a large city in the distance... probably	city_art
3001	city	-8.47	51.8972	Cork	a large city in the distance... probably	city_art
3002	city	125.5783	-8.5536	Dili	a large city in the distance... probably	city_art
3003	city	5.5864	7.1961	Owo	a large city in the distance... probably	city_art
3004	city	-1.78	51.56	Swindon	a large city in the distance... probably	city_art
3005	city	98.6	12.4333	Myeik	a large city in the distance... probably	city_art
3006	city	-42.0189	-22.8789	Cabo Frio	a large city in the distance... probably	city_art
3007	city	79.5	28.92	Kichha	a large city in the distance... probably	city_art
3008	city	113.0684	22.8711	Longjiang	a large city in the distance... probably	city_art
3009	city	80.4	23.48	Katri	a large city in the distance... probably	city_art
3010	city	37.8167	55.9167	Korolev	a large city in the distance... probably	city_art
3011	city	35.4167	37.0333	Saricam	a large city in the distance... probably	city_art
3012	city	-10.1333	8.5667	Gueckedou	a large city in the distance... probably	city_art
3013	city	58.82	36.22	Neyshabur	a large city in the distance... probably	city_art
3014	city	10.6333	35.8333	Sousse	a large city in the distance... probably	city_art
3015	city	32.8	-5.0167	Tabora	a large city in the distance... probably	city_art
3016	city	105.9736	9.6028	Soc Trang	a large city in the distance... probably	city_art
3017	city	87.64	25.8	Dagarua	a large city in the distance... probably	city_art
3018	city	-81.2137	28.905	Deltona	a large city in the distance... probably	city_art
3019	city	2.6	8.8833	Tchaourou	a large city in the distance... probably	city_art
3020	city	-17.2667	14.7167	Rufisque	a large city in the distance... probably	city_art
3021	city	-117.2943	34.1416	San Bernardino	a large city in the distance... probably	city_art
3022	city	-7.35	6.7333	Duekoue	a large city in the distance... probably	city_art
3023	city	-82.3459	29.6804	Gainesville	a large city in the distance... probably	city_art
3024	city	78.55	28.58	Sambhal	a large city in the distance... probably	city_art
3025	city	-68.7369	10.3406	San Felipe	a large city in the distance... probably	city_art
3026	city	50.3611	35.0278	Saveh	a large city in the distance... probably	city_art
3027	city	8.2736	49.9994	Mainz	a large city in the distance... probably	city_art
3028	city	-43.8506	-19.77	Santa Luzia	a large city in the distance... probably	city_art
3029	city	106.383	21.133	Chi Linh	a large city in the distance... probably	city_art
3030	city	-70.53	19.22	La Vega	a large city in the distance... probably	city_art
3031	city	82.666	24.202	Singrauliya	a large city in the distance... probably	city_art
3032	city	-8.5	33.2333	El Jadid	a large city in the distance... probably	city_art
3033	city	33.4039	49.0631	Kremenchuk	a large city in the distance... probably	city_art
3034	city	34.65	31.8	Ashdod	a large city in the distance... probably	city_art
3035	city	20.7392	42.2128	Prizren	a large city in the distance... probably	city_art
3036	city	-115.2636	36.0952	Spring Valley	a large city in the distance... probably	city_art
3037	city	67.9244	24.7461	Thatta	a large city in the distance... probably	city_art
3038	city	40.2333	37.9333	Yenisehir	a large city in the distance... probably	city_art
3039	city	50.2	26.2833	Al Khubar	a large city in the distance... probably	city_art
3040	city	7.3303	5.1497	Osisioma	a large city in the distance... probably	city_art
3041	city	-122.4531	47.2431	Tacoma	a large city in the distance... probably	city_art
3042	city	-76.2	4.0833	Tulua	a large city in the distance... probably	city_art
3043	city	39.199	-6.165	Zanzibar	a large city in the distance... probably	city_art
3044	city	28.1833	-15.7667	Kafue	a large city in the distance... probably	city_art
3045	city	70.4167	40.2833	Konibodom	a large city in the distance... probably	city_art
3046	city	-0.7967	38.4789	Petrel	a large city in the distance... probably	city_art
3047	city	15.5542	38.1936	Messina	a large city in the distance... probably	city_art
3048	city	106.1167	-2.1333	Pangkalpinang	a large city in the distance... probably	city_art
3049	city	-79.9581	37.2785	Roanoke	a large city in the distance... probably	city_art
3050	city	125.1978	1.4472	Bitung	a large city in the distance... probably	city_art
3051	city	121.18	14.08	Santo Tomas	a large city in the distance... probably	city_art
3052	city	-88.1775	13.4814	San Miguel	a large city in the distance... probably	city_art
3053	city	2.1075	41.5486	Sabadell	a large city in the distance... probably	city_art
3054	city	10.6864	53.8697	Lubeck	a large city in the distance... probably	city_art
3055	city	-0.9833	37.6	Cartagena	a large city in the distance... probably	city_art
3056	city	88.42	22.89	Naihati	a large city in the distance... probably	city_art
3057	city	139.7833	35.7333	Arakawa	a large city in the distance... probably	city_art
3058	city	28.0425	45.4233	Galati	a large city in the distance... probably	city_art
3059	city	-73.3586	40.6925	Babylon	a large city in the distance... probably	city_art
3060	city	-13.2033	27.1536	Laayoune	a large city in the distance... probably	city_art
3061	city	29.2833	0.15	Butembo	a large city in the distance... probably	city_art
3062	city	-5.845	43.36	Oviedo	a large city in the distance... probably	city_art
3063	city	-92.2667	14.9	Tapachula	a large city in the distance... probably	city_art
3064	city	69.6293	21.6417	Porbandar	a large city in the distance... probably	city_art
3065	city	-51.1469	-29.76	Sao Leopoldo	a large city in the distance... probably	city_art
3066	city	3.3667	6.45	Apapa	a large city in the distance... probably	city_art
3067	city	34.8567	32.3286	Netanya	a large city in the distance... probably	city_art
3068	city	63.62	53.2	Qostanay	a large city in the distance... probably	city_art
3069	city	100.3694	6.1183	Alor Setar	a large city in the distance... probably	city_art
3070	city	109.6752	37.1427	Wayaobu	a large city in the distance... probably	city_art
3071	city	15.5	51.9333	Zielona Gora	a large city in the distance... probably	city_art
3072	city	112.525	-7.872	Batu	a large city in the distance... probably	city_art
3073	city	112.176	37.907	Gujiao	a large city in the distance... probably	city_art
3074	city	-58.7667	-34.5167	Jose C. Paz	a large city in the distance... probably	city_art
3075	city	77.288	30.133	Yamunanagar	a large city in the distance... probably	city_art
3076	city	114.8325	-3.4425	Banjarbaru	a large city in the distance... probably	city_art
3077	city	125.0928	7.9042	Valencia	a large city in the distance... probably	city_art
3078	city	-74.2244	-13.1631	Ayacucho	a large city in the distance... probably	city_art
3079	city	174.7772	-41.2889	Wellington	a large city in the distance... probably	city_art
3080	city	-70.55	-33.4833	Penalolen	a large city in the distance... probably	city_art
3081	city	107.9717	21.5478	Dongxing	a large city in the distance... probably	city_art
3082	city	25.3358	50.75	Lutsk	a large city in the distance... probably	city_art
3083	city	-86.7931	15.7792	La Ceiba	a large city in the distance... probably	city_art
3084	city	34.3833	11.85	Ar Ruseris	a large city in the distance... probably	city_art
3085	city	-47.22	-22.8583	Hortolandia	a large city in the distance... probably	city_art
3086	city	80.1491	12.9675	Pallavaram	a large city in the distance... probably	city_art
3087	city	71.7247	40.4711	Marg`ilon	a large city in the distance... probably	city_art
3088	city	-99.1667	18.8833	Jiutepec	a large city in the distance... probably	city_art
3089	city	-97.458	25.9975	Brownsville	a large city in the distance... probably	city_art
3090	city	106.4167	10.5333	Tan An	a large city in the distance... probably	city_art
3091	city	94.9283	36.4072	Golmud	a large city in the distance... probably	city_art
3092	city	-68.3333	-34.6	San Rafael	a large city in the distance... probably	city_art
3093	city	4.2978	36.5	Sidi Aissa	a large city in the distance... probably	city_art
3094	city	75.6187	21.82	Khargone	a large city in the distance... probably	city_art
3095	city	45.2833	31.3167	As Samawah	a large city in the distance... probably	city_art
3096	city	58.5667	23.6167	Matrah	a large city in the distance... probably	city_art
3097	city	-93.2018	18.2801	Comalcalco	a large city in the distance... probably	city_art
3098	city	-66.8833	10.1667	Cua	a large city in the distance... probably	city_art
3099	city	5.2167	52.3667	Almere	a large city in the distance... probably	city_art
3100	city	25.0403	60.2944	Vantaa	a large city in the distance... probably	city_art
3101	city	126.38	34.7589	Mokpo	a large city in the distance... probably	city_art
3102	city	-67.3336	10.2278	La Victoria	a large city in the distance... probably	city_art
3103	city	-63.1667	-17.5167	Warnes	a large city in the distance... probably	city_art
3104	city	-9.4167	38.7	Cascais	a large city in the distance... probably	city_art
3105	city	27.05	38.4833	Cigli	a large city in the distance... probably	city_art
3106	city	-3.9833	5.3	Marcory	a large city in the distance... probably	city_art
3107	city	74.0944	35.4194	Chilas	a large city in the distance... probably	city_art
3108	city	-5.6667	11.3167	Sikasso	a large city in the distance... probably	city_art
3109	city	127.0771	37.1498	Osan	a large city in the distance... probably	city_art
3110	city	-79.6833	43.45	Oakville	a large city in the distance... probably	city_art
3111	city	78.4983	17.4399	Secunderabad	a large city in the distance... probably	city_art
3112	city	105.7667	10.3	Sa Dec	a large city in the distance... probably	city_art
3113	city	63.0606	26.0042	Turbat	a large city in the distance... probably	city_art
3114	city	-64.2611	8.8861	El Tigre	a large city in the distance... probably	city_art
3115	city	69.67	23.25	Bhuj	a large city in the distance... probably	city_art
3116	city	37.7808	6.855	Sodo	a large city in the distance... probably	city_art
3117	city	139.1968	36.3114	Isesaki	a large city in the distance... probably	city_art
3118	city	-6.1378	36.6817	Jerez de la Frontera	a large city in the distance... probably	city_art
3119	city	-96.2959	30.5852	College Station	a large city in the distance... probably	city_art
3120	city	1.2928	52.6286	Norwich	a large city in the distance... probably	city_art
3121	city	19.1167	50.8	Czestochowa	a large city in the distance... probably	city_art
3122	city	86.465	25.381	Monghyr	a large city in the distance... probably	city_art
3123	city	-0.4147	51.8783	Luton	a large city in the distance... probably	city_art
3124	city	84.7274	25.7848	Chapra	a large city in the distance... probably	city_art
3125	city	-0.6414	35.1939	Sidi Bel Abbes	a large city in the distance... probably	city_art
3126	city	121.0119	24.8333	Zhubei	a large city in the distance... probably	city_art
3127	city	-78.7647	1.8067	Tumaco	a large city in the distance... probably	city_art
3128	city	10.3933	63.4297	Trondheim	a large city in the distance... probably	city_art
3129	city	30.8333	27.7333	Mallawi	a large city in the distance... probably	city_art
3130	city	132.5658	34.2492	Kure	a large city in the distance... probably	city_art
3131	city	7.2203	8.8822	Kuje	a large city in the distance... probably	city_art
3132	city	75.705	13.8485	Bhadravati	a large city in the distance... probably	city_art
3133	city	139.78	35.7125	Taito	a large city in the distance... probably	city_art
3134	city	43.8933	36.7414	`Aqrah	a large city in the distance... probably	city_art
3135	city	105.6303	10.4672	Cao Lanh	a large city in the distance... probably	city_art
3136	city	-102.5078	22.7528	Guadalupe	a large city in the distance... probably	city_art
3137	city	37.7667	55.9167	Mytishchi	a large city in the distance... probably	city_art
3138	city	121.2723	31.1731	Xigujing	a large city in the distance... probably	city_art
3139	city	25.1344	35.3403	Irakleio	a large city in the distance... probably	city_art
3140	city	-49.3697	-28.6775	Criciuma	a large city in the distance... probably	city_art
3141	city	76.8	30.74	Panchkula	a large city in the distance... probably	city_art
3142	city	68.25	24.73	Mirpur Bhtoro	a large city in the distance... probably	city_art
3143	city	76.2289	21.3114	Burhanpur	a large city in the distance... probably	city_art
3144	city	-122.8959	47.0417	Olympia	a large city in the distance... probably	city_art
3145	city	6.8706	51.4967	Oberhausen	a large city in the distance... probably	city_art
3146	city	27.4702	42.503	Burgas	a large city in the distance... probably	city_art
3147	city	-40.2389	-3.6739	Sobral	a large city in the distance... probably	city_art
3148	city	-87.3413	36.5692	Clarksville	a large city in the distance... probably	city_art
3149	city	120.87	14.28	Trece Martires City	a large city in the distance... probably	city_art
3150	city	128.9	37.75	Gangneung	a large city in the distance... probably	city_art
3151	city	123.4364	7.8272	Pagadian	a large city in the distance... probably	city_art
3152	city	-70.7333	-33.3667	Quilicura	a large city in the distance... probably	city_art
3153	city	76.2296	32.8376	Kiratot	a large city in the distance... probably	city_art
3154	city	14.2864	48.3058	Linz	a large city in the distance... probably	city_art
3155	city	-82.3328	23.0436	Arroyo Naranjo	a large city in the distance... probably	city_art
3156	city	100.4607	5.3655	Bukit Mertajam	a large city in the distance... probably	city_art
3157	city	130.8167	44.1167	Dongning	a large city in the distance... probably	city_art
3158	city	-123.1333	49.1667	Richmond	a large city in the distance... probably	city_art
3159	city	12.1333	54.0833	Rostock	a large city in the distance... probably	city_art
3160	city	78.5651	17.4859	Kapra	a large city in the distance... probably	city_art
3161	city	28.3333	57.8167	Pskov	a large city in the distance... probably	city_art
3162	city	-73.8673	40.9466	Yonkers	a large city in the distance... probably	city_art
3163	city	5.5167	5.35	Burutu	a large city in the distance... probably	city_art
3164	city	-3.8667	40.3333	Mostoles	a large city in the distance... probably	city_art
3165	city	-117.2045	33.9244	Moreno Valley	a large city in the distance... probably	city_art
3166	city	-118.8756	34.1914	Thousand Oaks	a large city in the distance... probably	city_art
3167	city	123.73	13.13	Legazpi City	a large city in the distance... probably	city_art
3168	city	-70.2715	43.6773	Portland	a large city in the distance... probably	city_art
3169	city	-117.4599	34.0968	Fontana	a large city in the distance... probably	city_art
3170	city	125.68	7.3	Panabo	a large city in the distance... probably	city_art
3171	city	-68.0167	10.4667	Puerto Cabello	a large city in the distance... probably	city_art
3172	city	127.4333	37.2667	Ich'on	a large city in the distance... probably	city_art
3173	city	34.7997	31.2589	Beersheba	a large city in the distance... probably	city_art
3174	city	30.1153	49.7989	Bila Tserkva	a large city in the distance... probably	city_art
3175	city	-35.03	-8.2897	Santo Agostinho	a large city in the distance... probably	city_art
3176	city	25.4719	65.0142	Oulu	a large city in the distance... probably	city_art
3177	city	-47.95	-16.2528	Luziania	a large city in the distance... probably	city_art
3178	city	106.7619	-6.3111	Ciputat	a large city in the distance... probably	city_art
3179	city	-66.6167	10.4667	Guarenas	a large city in the distance... probably	city_art
3180	city	-7.3833	33.6833	Mohammedia	a large city in the distance... probably	city_art
3181	city	29.2333	53.15	Babruysk	a large city in the distance... probably	city_art
3182	city	113.3531	23.2939	Taisheng	a large city in the distance... probably	city_art
3183	city	-2.3333	7.3333	Sunyani	a large city in the distance... probably	city_art
3184	city	102.8617	-3.2967	Lubuklinggau	a large city in the distance... probably	city_art
3185	city	-0.0333	5.7	Ashaiman	a large city in the distance... probably	city_art
3186	city	76.78	30.38	Ambala	a large city in the distance... probably	city_art
3187	city	-102.2833	19.9833	Zamora	a large city in the distance... probably	city_art
3188	city	127.95	36.9667	Chungju	a large city in the distance... probably	city_art
3189	city	32.6025	0.4378	Kasangati	a large city in the distance... probably	city_art
3190	city	87.3237	22.3302	Kharagpur	a large city in the distance... probably	city_art
3191	city	32.1639	26.055	Farshut	a large city in the distance... probably	city_art
3192	city	95.1417	22.1083	Monywa	a large city in the distance... probably	city_art
3193	city	139.5383	35.7256	Nishitokyo	a large city in the distance... probably	city_art
3194	city	78.2754	12.9563	Robertsonpet	a large city in the distance... probably	city_art
3195	city	37.8944	55.6783	Lyubertsy	a large city in the distance... probably	city_art
3196	city	77.95	10.35	Dindigul	a large city in the distance... probably	city_art
3197	city	123.65	10.38	Toledo	a large city in the distance... probably	city_art
3198	city	-0.76	52.04	Milton Keynes	a large city in the distance... probably	city_art
3199	city	124.285	8.0031	Marawi City	a large city in the distance... probably	city_art
3200	city	37.6633	-6.8242	Morogoro	a large city in the distance... probably	city_art
3201	city	72.2167	24.75	Raniwara Kalan	a large city in the distance... probably	city_art
3202	city	-1.778	52.413	Solihull	a large city in the distance... probably	city_art
3203	city	2.6167	9.35	Parakou	a large city in the distance... probably	city_art
3204	city	31.8214	31.4167	Damietta	a large city in the distance... probably	city_art
3205	city	77.1722	31.1033	Shimla	a large city in the distance... probably	city_art
3206	city	11.8667	45.4167	Padova	a large city in the distance... probably	city_art
3207	city	108.5414	-7.3695	Banjar	a large city in the distance... probably	city_art
3208	city	40.6728	-14.5428	Cidade de Nacala	a large city in the distance... probably	city_art
3209	city	-52.4	-28.25	Passo Fundo	a large city in the distance... probably	city_art
3210	city	88.65	25.6167	Dinajpur	a large city in the distance... probably	city_art
3211	city	76.3909	15.2689	Hospet	a large city in the distance... probably	city_art
3212	city	-0.1027	51.544	Islington	a large city in the distance... probably	city_art
3213	city	-71.6656	-35.4269	Talca	a large city in the distance... probably	city_art
3214	city	-81.3223	35.741	Hickory	a large city in the distance... probably	city_art
3215	city	-101.8316	35.1984	Amarillo	a large city in the distance... probably	city_art
3216	city	36.6833	-8.1	Ifakara	a large city in the distance... probably	city_art
3217	city	-1.65	42.8167	Pamplona	a large city in the distance... probably	city_art
3218	city	174.7494	-36.8019	Northcote	a large city in the distance... probably	city_art
3219	city	88.1458	25.0044	Maldah	a large city in the distance... probably	city_art
3220	city	120.3489	15.9281	San Carlos City	a large city in the distance... probably	city_art
3221	city	125.8443	44.1447	Jiutai	a large city in the distance... probably	city_art
3222	city	108.1	10.9333	Phan Thiet	a large city in the distance... probably	city_art
3223	city	113.88	29.7204	Puqi	a large city in the distance... probably	city_art
3224	city	34.3031	31.3444	Khan Yunis	a large city in the distance... probably	city_art
3225	city	80.049	15.506	Ongole	a large city in the distance... probably	city_art
3226	city	-96.9347	18.8942	Cordoba	a large city in the distance... probably	city_art
3227	city	91.1083	23.6167	Brahmanpara	a large city in the distance... probably	city_art
3228	city	5.7333	34.85	Biskra	a large city in the distance... probably	city_art
3229	city	-3.9	5.35	Bingerville	a large city in the distance... probably	city_art
3230	city	75.6442	15.443	Betigeri	a large city in the distance... probably	city_art
3231	city	-96.7311	43.5396	Sioux Falls	a large city in the distance... probably	city_art
3232	city	31.0667	-6.35	Mpanda	a large city in the distance... probably	city_art
3233	city	127.3819	0.78	Ternate	a large city in the distance... probably	city_art
3234	city	9.4979	51.3158	Kassel	a large city in the distance... probably	city_art
3235	city	40.2	29.9697	Sakaka	a large city in the distance... probably	city_art
3236	city	127.2822	36.487	Sejong	a large city in the distance... probably	city_art
3237	city	-91.5167	14.8333	Quetzaltenango	a large city in the distance... probably	city_art
3238	city	-71.3433	-29.9531	Coquimbo	a large city in the distance... probably	city_art
3239	city	27.5153	40.9778	Tekirdag	a large city in the distance... probably	city_art
3240	city	98.8577	25.8226	Luzhang	a large city in the distance... probably	city_art
3241	city	77.7833	15.6833	Kodumur	a large city in the distance... probably	city_art
3242	city	13.5667	12.9167	Kukawa	a large city in the distance... probably	city_art
3243	city	6.1469	46.2017	Geneva	a large city in the distance... probably	city_art
3244	city	-73.3823	40.8521	Huntington	a large city in the distance... probably	city_art
3245	city	81.1031	16.7117	Ellore	a large city in the distance... probably	city_art
3246	city	-87.5341	37.9881	Evansville	a large city in the distance... probably	city_art
3247	city	106.5	21.033	Kinh Mon	a large city in the distance... probably	city_art
3248	city	59.2161	32.8744	Birjand	a large city in the distance... probably	city_art
3249	city	121.012	14.58	Santa Ana	a large city in the distance... probably	city_art
3250	city	-73.85	7.0667	Barrancabermeja	a large city in the distance... probably	city_art
3251	city	-66.9331	10.6	La Guaira	a large city in the distance... probably	city_art
3252	city	-79.2	-3.9833	Loja	a large city in the distance... probably	city_art
3253	city	72.6817	30.1592	Mandi Burewala	a large city in the distance... probably	city_art
3254	city	-38.3269	-12.8939	Lauro de Freitas	a large city in the distance... probably	city_art
3255	city	27.7475	-15.8467	Mazabuka	a large city in the distance... probably	city_art
3256	city	86.7	24.48	Deoghar	a large city in the distance... probably	city_art
3257	city	104.4554	0.9188	Tanjungpinang	a large city in the distance... probably	city_art
3258	city	105.9611	21.1189	Phu Tu Son	a large city in the distance... probably	city_art
3259	city	-82.4345	38.4109	Huntington	a large city in the distance... probably	city_art
3260	city	78.9396	22.057	Chhindwara	a large city in the distance... probably	city_art
3261	city	35.69	-7.77	Iringa	a large city in the distance... probably	city_art
3262	city	78.317	17.4865	Lingampalli	a large city in the distance... probably	city_art
3263	city	-73.0361	41.5582	Waterbury	a large city in the distance... probably	city_art
3264	city	85.9191	25.3898	Mokameh	a large city in the distance... probably	city_art
3265	city	32.6444	25.6967	Luxor	a large city in the distance... probably	city_art
3266	city	-70.3181	-18.4778	Arica	a large city in the distance... probably	city_art
3267	city	-76.9544	20.9597	Las Tunas	a large city in the distance... probably	city_art
3268	city	42.6	20	Qal`at Bishah	a large city in the distance... probably	city_art
3269	city	-96.8216	33.156	Frisco	a large city in the distance... probably	city_art
3270	city	105.9	18.3333	Ha Tinh	a large city in the distance... probably	city_art
3271	city	-79.4333	43.8667	Richmond Hill	a large city in the distance... probably	city_art
3272	city	31.5293	30.9438	Timayy al Imdid	a large city in the distance... probably	city_art
3273	city	14.2644	32.6497	Al Khums	a large city in the distance... probably	city_art
3274	city	4.4333	50.4	Charleroi	a large city in the distance... probably	city_art
3275	city	-82.184	41.4409	Lorain	a large city in the distance... probably	city_art
3276	city	133.0486	35.4681	Matsue	a large city in the distance... probably	city_art
3277	city	117.6333	3.3	Tarakan	a large city in the distance... probably	city_art
3278	city	-9.1667	38.8333	Loures	a large city in the distance... probably	city_art
3279	city	121.2161	24.9439	Pingzhen	a large city in the distance... probably	city_art
3280	city	21.1567	51.4036	Radom	a large city in the distance... probably	city_art
3281	city	69.1667	54.8833	Petropavl	a large city in the distance... probably	city_art
3282	city	-47.5608	-22.4108	Rio Claro	a large city in the distance... probably	city_art
3283	city	14.3157	10.5971	Maroua	a large city in the distance... probably	city_art
3284	city	-78.5167	-7.1667	Cajamarca	a large city in the distance... probably	city_art
3285	city	32.7167	26.1667	Qina	a large city in the distance... probably	city_art
3286	city	8.2117	13.1906	Mai'Adua	a large city in the distance... probably	city_art
3287	city	35.0969	31.5286	Hebron	a large city in the distance... probably	city_art
3288	city	85.8167	19.8	Puri	a large city in the distance... probably	city_art
3289	city	31.3808	26.9653	Sidfa	a large city in the distance... probably	city_art
3290	city	12.3667	-6.1333	Soio	a large city in the distance... probably	city_art
3291	city	27.0667	38.6	Menemen	a large city in the distance... probably	city_art
3292	city	-85.5882	42.2749	Kalamazoo	a large city in the distance... probably	city_art
3293	city	88.0698	22.0667	Haldia	a large city in the distance... probably	city_art
3294	city	68.4514	28.2769	Jacobabad	a large city in the distance... probably	city_art
3295	city	76.35	21.82	Khandwa	a large city in the distance... probably	city_art
3296	city	-2.11	57.15	Aberdeen	a large city in the distance... probably	city_art
3297	city	85.2167	52.5333	Biysk	a large city in the distance... probably	city_art
3298	city	-77.605	-11.1067	Huacho	a large city in the distance... probably	city_art
3299	city	-2.4681	36.8403	Almeria	a large city in the distance... probably	city_art
3300	city	140.0999	35.7224	Yachiyo	a large city in the distance... probably	city_art
3301	city	78.48	15.48	Nandyal	a large city in the distance... probably	city_art
3302	city	78.4613	15.5386	Pulimaddi	a large city in the distance... probably	city_art
3303	city	-58.1508	6.8058	Georgetown	a large city in the distance... probably	city_art
3304	city	78	26.5	Morena	a large city in the distance... probably	city_art
3305	city	-94.8913	29.2484	Galveston	a large city in the distance... probably	city_art
3306	city	51.1617	35.5617	Nasim Shahr	a large city in the distance... probably	city_art
3307	city	16.25	39.3	Cosenza	a large city in the distance... probably	city_art
3308	city	-67.9	10.2536	Guacara	a large city in the distance... probably	city_art
3309	city	122.82	9.98	Kabankalan	a large city in the distance... probably	city_art
3310	city	139.9029	35.8563	Nagareyama	a large city in the distance... probably	city_art
3311	city	-50.4328	-21.2089	Aracatuba	a large city in the distance... probably	city_art
3312	city	105.9667	10.25	Vinh Long	a large city in the distance... probably	city_art
3313	city	106.7578	21.8478	Lang Son	a large city in the distance... probably	city_art
3314	city	12.7278	32.7522	Az Zawiyah	a large city in the distance... probably	city_art
3315	city	5.8	8.1667	Isanlu	a large city in the distance... probably	city_art
3316	city	-64.35	-33.1333	Rio Cuarto	a large city in the distance... probably	city_art
3317	city	9.75	47.5167	Lochau	a large city in the distance... probably	city_art
3318	city	75	18.55	Karjat	a large city in the distance... probably	city_art
3319	city	44.2342	33.5092	At Taji	a large city in the distance... probably	city_art
3320	city	-81.9251	34.9442	Spartanburg	a large city in the distance... probably	city_art
\.


--
-- TOC entry 4892 (class 0 OID 24954)
-- Dependencies: 235
-- Data for Name: node_resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.node_resources (id, locations_id, resource_id) FROM stdin;
\.


--
-- TOC entry 4876 (class 0 OID 24843)
-- Dependencies: 219
-- Data for Name: resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resources (id, name) FROM stdin;
\.


--
-- TOC entry 4882 (class 0 OID 24874)
-- Dependencies: 225
-- Data for Name: user_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_locations (id, user_id, location_id, is_global, visible) FROM stdin;
\.


--
-- TOC entry 4874 (class 0 OID 24833)
-- Dependencies: 217
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password, created_at) FROM stdin;
\.


--
-- TOC entry 4890 (class 0 OID 24932)
-- Dependencies: 233
-- Data for Name: worker_activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.worker_activities (id, worker_id, start_location_id, end_location_id, type, start_time, end_time, start_latitude, start_longitude, destination_latitude, destination_longitude) FROM stdin;
\.


--
-- TOC entry 4888 (class 0 OID 24915)
-- Dependencies: 231
-- Data for Name: worker_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.worker_events (id, worker_id, event_id) FROM stdin;
\.


--
-- TOC entry 4878 (class 0 OID 24850)
-- Dependencies: 221
-- Data for Name: workers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workers (id, user_id, religion, age, name, created_at, work_status, injured, strength, intelligence, faith) FROM stdin;
\.


--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 228
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_id_seq', 1, false);


--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 226
-- Name: global_locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.global_locations_id_seq', 1, false);


--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 222
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locations_id_seq', 3320, true);


--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 234
-- Name: node_resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.node_resources_id_seq', 1, false);


--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 218
-- Name: resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resources_id_seq', 1, false);


--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 224
-- Name: user_locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_locations_id_seq', 1, false);


--
-- TOC entry 4915 (class 0 OID 0)
-- Dependencies: 216
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 232
-- Name: worker_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.worker_activities_id_seq', 1, false);


--
-- TOC entry 4917 (class 0 OID 0)
-- Dependencies: 230
-- Name: worker_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.worker_events_id_seq', 1, false);


--
-- TOC entry 4918 (class 0 OID 0)
-- Dependencies: 220
-- Name: workers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.workers_id_seq', 1, false);


--
-- TOC entry 4712 (class 2606 OID 24913)
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- TOC entry 4710 (class 2606 OID 24899)
-- Name: global_locations global_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_locations
    ADD CONSTRAINT global_locations_pkey PRIMARY KEY (id);


--
-- TOC entry 4706 (class 2606 OID 24872)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- TOC entry 4718 (class 2606 OID 24959)
-- Name: node_resources node_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node_resources
    ADD CONSTRAINT node_resources_pkey PRIMARY KEY (id);


--
-- TOC entry 4702 (class 2606 OID 24848)
-- Name: resources resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- TOC entry 4708 (class 2606 OID 24881)
-- Name: user_locations user_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_locations
    ADD CONSTRAINT user_locations_pkey PRIMARY KEY (id);


--
-- TOC entry 4698 (class 2606 OID 24841)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4700 (class 2606 OID 24839)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4716 (class 2606 OID 24937)
-- Name: worker_activities worker_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.worker_activities
    ADD CONSTRAINT worker_activities_pkey PRIMARY KEY (id);


--
-- TOC entry 4714 (class 2606 OID 24920)
-- Name: worker_events worker_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.worker_events
    ADD CONSTRAINT worker_events_pkey PRIMARY KEY (id);


--
-- TOC entry 4704 (class 2606 OID 24858)
-- Name: workers workers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workers
    ADD CONSTRAINT workers_pkey PRIMARY KEY (id);


--
-- TOC entry 4722 (class 2606 OID 24900)
-- Name: global_locations global_locations_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_locations
    ADD CONSTRAINT global_locations_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- TOC entry 4728 (class 2606 OID 24960)
-- Name: node_resources node_resources_locations_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node_resources
    ADD CONSTRAINT node_resources_locations_id_fkey FOREIGN KEY (locations_id) REFERENCES public.locations(id);


--
-- TOC entry 4729 (class 2606 OID 24965)
-- Name: node_resources node_resources_resource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.node_resources
    ADD CONSTRAINT node_resources_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.resources(id);


--
-- TOC entry 4720 (class 2606 OID 24887)
-- Name: user_locations user_locations_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_locations
    ADD CONSTRAINT user_locations_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- TOC entry 4721 (class 2606 OID 24882)
-- Name: user_locations user_locations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_locations
    ADD CONSTRAINT user_locations_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 4725 (class 2606 OID 24948)
-- Name: worker_activities worker_activities_end_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.worker_activities
    ADD CONSTRAINT worker_activities_end_location_id_fkey FOREIGN KEY (end_location_id) REFERENCES public.locations(id);


--
-- TOC entry 4726 (class 2606 OID 24943)
-- Name: worker_activities worker_activities_start_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.worker_activities
    ADD CONSTRAINT worker_activities_start_location_id_fkey FOREIGN KEY (start_location_id) REFERENCES public.locations(id);


--
-- TOC entry 4727 (class 2606 OID 24938)
-- Name: worker_activities worker_activities_worker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.worker_activities
    ADD CONSTRAINT worker_activities_worker_id_fkey FOREIGN KEY (worker_id) REFERENCES public.workers(id);


--
-- TOC entry 4723 (class 2606 OID 24926)
-- Name: worker_events worker_events_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.worker_events
    ADD CONSTRAINT worker_events_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(id);


--
-- TOC entry 4724 (class 2606 OID 24921)
-- Name: worker_events worker_events_worker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.worker_events
    ADD CONSTRAINT worker_events_worker_id_fkey FOREIGN KEY (worker_id) REFERENCES public.workers(id);


--
-- TOC entry 4719 (class 2606 OID 24859)
-- Name: workers workers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workers
    ADD CONSTRAINT workers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


-- Completed on 2024-07-02 16:51:00

--
-- PostgreSQL database dump complete
--

