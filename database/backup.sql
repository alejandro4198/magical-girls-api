--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-02-26 12:53:48

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16601)
-- Name: ciudad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ciudad (
    id integer NOT NULL,
    nombre_ciudad text NOT NULL
);


ALTER TABLE public.ciudad OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16600)
-- Name: ciudad_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ciudad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ciudad_id_seq OWNER TO postgres;

--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 217
-- Name: ciudad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ciudad_id_seq OWNED BY public.ciudad.id;


--
-- TOC entry 224 (class 1259 OID 16642)
-- Name: ciudads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ciudads (
    id bigint NOT NULL,
    nombre_ciudad text
);


ALTER TABLE public.ciudads OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16641)
-- Name: ciudads_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ciudads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ciudads_id_seq OWNER TO postgres;

--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 223
-- Name: ciudads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ciudads_id_seq OWNED BY public.ciudads.id;


--
-- TOC entry 220 (class 1259 OID 16612)
-- Name: estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado (
    id integer NOT NULL,
    nombre_estado text NOT NULL
);


ALTER TABLE public.estado OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16611)
-- Name: estado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estado_id_seq OWNER TO postgres;

--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 219
-- Name: estado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estado_id_seq OWNED BY public.estado.id;


--
-- TOC entry 226 (class 1259 OID 16653)
-- Name: estados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estados (
    id bigint NOT NULL,
    nombre_estado text
);


ALTER TABLE public.estados OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16652)
-- Name: estados_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.estados_id_seq OWNER TO postgres;

--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 225
-- Name: estados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estados_id_seq OWNED BY public.estados.id;


--
-- TOC entry 228 (class 1259 OID 16724)
-- Name: historial_estados; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historial_estados (
    id integer NOT NULL,
    magical_girl_id integer,
    estado_anterior integer,
    estado_nuevo integer,
    fecha_cambio timestamp without time zone DEFAULT now()
);


ALTER TABLE public.historial_estados OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16723)
-- Name: historial_estados_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historial_estados_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historial_estados_id_seq OWNER TO postgres;

--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 227
-- Name: historial_estados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historial_estados_id_seq OWNED BY public.historial_estados.id;


--
-- TOC entry 222 (class 1259 OID 16623)
-- Name: magical_girls; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.magical_girls (
    id integer NOT NULL,
    nombre text NOT NULL,
    apellido text NOT NULL,
    edad bigint,
    ciudad_id bigint,
    estado_id bigint,
    fecha_contrato text
);


ALTER TABLE public.magical_girls OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16622)
-- Name: magical_girls_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.magical_girls_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.magical_girls_id_seq OWNER TO postgres;

--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 221
-- Name: magical_girls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.magical_girls_id_seq OWNED BY public.magical_girls.id;


--
-- TOC entry 4767 (class 2604 OID 16604)
-- Name: ciudad id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudad ALTER COLUMN id SET DEFAULT nextval('public.ciudad_id_seq'::regclass);


--
-- TOC entry 4770 (class 2604 OID 16645)
-- Name: ciudads id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudads ALTER COLUMN id SET DEFAULT nextval('public.ciudads_id_seq'::regclass);


--
-- TOC entry 4768 (class 2604 OID 16615)
-- Name: estado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado ALTER COLUMN id SET DEFAULT nextval('public.estado_id_seq'::regclass);


--
-- TOC entry 4771 (class 2604 OID 16656)
-- Name: estados id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados ALTER COLUMN id SET DEFAULT nextval('public.estados_id_seq'::regclass);


--
-- TOC entry 4772 (class 2604 OID 16727)
-- Name: historial_estados id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_estados ALTER COLUMN id SET DEFAULT nextval('public.historial_estados_id_seq'::regclass);


--
-- TOC entry 4769 (class 2604 OID 16626)
-- Name: magical_girls id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.magical_girls ALTER COLUMN id SET DEFAULT nextval('public.magical_girls_id_seq'::regclass);


--
-- TOC entry 4947 (class 0 OID 16601)
-- Dependencies: 218
-- Data for Name: ciudad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ciudad (id, nombre_ciudad) FROM stdin;
1	Mitakihara
2	Kazamino
\.


--
-- TOC entry 4953 (class 0 OID 16642)
-- Dependencies: 224
-- Data for Name: ciudads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ciudads (id, nombre_ciudad) FROM stdin;
\.


--
-- TOC entry 4949 (class 0 OID 16612)
-- Dependencies: 220
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estado (id, nombre_estado) FROM stdin;
1	Activa
2	Desaparecida
3	Rescatada por la Ley de los Ciclos
\.


--
-- TOC entry 4955 (class 0 OID 16653)
-- Dependencies: 226
-- Data for Name: estados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estados (id, nombre_estado) FROM stdin;
\.


--
-- TOC entry 4957 (class 0 OID 16724)
-- Dependencies: 228
-- Data for Name: historial_estados; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historial_estados (id, magical_girl_id, estado_anterior, estado_nuevo, fecha_cambio) FROM stdin;
\.


--
-- TOC entry 4951 (class 0 OID 16623)
-- Dependencies: 222
-- Data for Name: magical_girls; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.magical_girls (id, nombre, apellido, edad, ciudad_id, estado_id, fecha_contrato) FROM stdin;
3	Madoka	Kaname	14	1	1	2011-03-30
8	Megumi	Tadokoro	14	2	3	2011-03-30
4	Homura	Akemi	14	1	2	2011-03-30
\.


--
-- TOC entry 4969 (class 0 OID 0)
-- Dependencies: 217
-- Name: ciudad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ciudad_id_seq', 2, true);


--
-- TOC entry 4970 (class 0 OID 0)
-- Dependencies: 223
-- Name: ciudads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ciudads_id_seq', 1, false);


--
-- TOC entry 4971 (class 0 OID 0)
-- Dependencies: 219
-- Name: estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estado_id_seq', 3, true);


--
-- TOC entry 4972 (class 0 OID 0)
-- Dependencies: 225
-- Name: estados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.estados_id_seq', 1, false);


--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 227
-- Name: historial_estados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historial_estados_id_seq', 1, false);


--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 221
-- Name: magical_girls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.magical_girls_id_seq', 11, true);


--
-- TOC entry 4775 (class 2606 OID 16610)
-- Name: ciudad ciudad_nombre_ciudad_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudad
    ADD CONSTRAINT ciudad_nombre_ciudad_key UNIQUE (nombre_ciudad);


--
-- TOC entry 4777 (class 2606 OID 16608)
-- Name: ciudad ciudad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudad
    ADD CONSTRAINT ciudad_pkey PRIMARY KEY (id);


--
-- TOC entry 4785 (class 2606 OID 16649)
-- Name: ciudads ciudads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudads
    ADD CONSTRAINT ciudads_pkey PRIMARY KEY (id);


--
-- TOC entry 4779 (class 2606 OID 16621)
-- Name: estado estado_nombre_estado_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_nombre_estado_key UNIQUE (nombre_estado);


--
-- TOC entry 4781 (class 2606 OID 16619)
-- Name: estado estado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id);


--
-- TOC entry 4789 (class 2606 OID 16660)
-- Name: estados estados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados
    ADD CONSTRAINT estados_pkey PRIMARY KEY (id);


--
-- TOC entry 4793 (class 2606 OID 16730)
-- Name: historial_estados historial_estados_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_estados
    ADD CONSTRAINT historial_estados_pkey PRIMARY KEY (id);


--
-- TOC entry 4783 (class 2606 OID 16630)
-- Name: magical_girls magical_girls_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.magical_girls
    ADD CONSTRAINT magical_girls_pkey PRIMARY KEY (id);


--
-- TOC entry 4787 (class 2606 OID 16651)
-- Name: ciudads uni_ciudads_nombre_ciudad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudads
    ADD CONSTRAINT uni_ciudads_nombre_ciudad UNIQUE (nombre_ciudad);


--
-- TOC entry 4791 (class 2606 OID 16662)
-- Name: estados uni_estados_nombre_estado; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estados
    ADD CONSTRAINT uni_estados_nombre_estado UNIQUE (nombre_estado);


--
-- TOC entry 4794 (class 2606 OID 16703)
-- Name: magical_girls fk_magical_girls_ciudad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.magical_girls
    ADD CONSTRAINT fk_magical_girls_ciudad FOREIGN KEY (ciudad_id) REFERENCES public.ciudad(id);


--
-- TOC entry 4795 (class 2606 OID 16718)
-- Name: magical_girls fk_magical_girls_estado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.magical_girls
    ADD CONSTRAINT fk_magical_girls_estado FOREIGN KEY (estado_id) REFERENCES public.estado(id) ON DELETE CASCADE;


--
-- TOC entry 4798 (class 2606 OID 16736)
-- Name: historial_estados historial_estados_estado_anterior_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_estados
    ADD CONSTRAINT historial_estados_estado_anterior_fkey FOREIGN KEY (estado_anterior) REFERENCES public.estado(id);


--
-- TOC entry 4799 (class 2606 OID 16741)
-- Name: historial_estados historial_estados_estado_nuevo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_estados
    ADD CONSTRAINT historial_estados_estado_nuevo_fkey FOREIGN KEY (estado_nuevo) REFERENCES public.estado(id);


--
-- TOC entry 4800 (class 2606 OID 16731)
-- Name: historial_estados historial_estados_magical_girl_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historial_estados
    ADD CONSTRAINT historial_estados_magical_girl_id_fkey FOREIGN KEY (magical_girl_id) REFERENCES public.magical_girls(id);


--
-- TOC entry 4796 (class 2606 OID 16669)
-- Name: magical_girls magical_girls_ciudad_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.magical_girls
    ADD CONSTRAINT magical_girls_ciudad_id_fkey FOREIGN KEY (ciudad_id) REFERENCES public.ciudad(id) ON DELETE CASCADE;


--
-- TOC entry 4797 (class 2606 OID 16680)
-- Name: magical_girls magical_girls_estado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.magical_girls
    ADD CONSTRAINT magical_girls_estado_id_fkey FOREIGN KEY (estado_id) REFERENCES public.estado(id) ON DELETE CASCADE;


-- Completed on 2025-02-26 12:53:48

--
-- PostgreSQL database dump complete
--

