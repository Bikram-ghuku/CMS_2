--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:u+O1tgxurmcWB9fUpbqr6w==$JoBoP5CblX8zhU/43j67thG00yynEEeoBEgQfTGNQ5A=:bC6oBIxp9HrSenZVsZNJLlJYZ/Hn7PJbBZnRA11Ou54=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

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
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

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
-- PostgreSQL database dump complete
--

--
-- Database "test" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

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
-- Name: test; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE test WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE test OWNER TO postgres;

\connect test

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
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: comp_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.comp_status AS ENUM (
    'open',
    'closed'
);


ALTER TYPE public.comp_status OWNER TO postgres;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_role AS ENUM (
    'admin',
    'inven_manage',
    'worker'
);


ALTER TYPE public.user_role OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bills (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    datetime timestamp(6) with time zone NOT NULL,
    workname text NOT NULL
);


ALTER TABLE public.bills OWNER TO postgres;

--
-- Name: complaints; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.complaints (
    comp_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    comp_nos text NOT NULL,
    comp_loc text NOT NULL,
    comp_des text NOT NULL,
    comp_stat public.comp_status NOT NULL,
    comp_date timestamp(6) with time zone NOT NULL,
    fin_datetime timestamp(6) with time zone,
    fin_text text
);


ALTER TABLE public.complaints OWNER TO postgres;

--
-- Name: inven_used; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inven_used (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    comp_id uuid NOT NULL,
    item_id uuid NOT NULL,
    item_used numeric NOT NULL,
    item_l numeric,
    item_b numeric,
    item_h numeric,
    bill_id uuid
);


ALTER TABLE public.inven_used OWNER TO postgres;

--
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
    item_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    item_name text NOT NULL,
    item_qty numeric NOT NULL,
    item_price numeric NOT NULL,
    item_desc text NOT NULL,
    item_unit text NOT NULL
);


ALTER TABLE public.inventory OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    username text NOT NULL,
    pswd text NOT NULL,
    role public.user_role DEFAULT 'worker'::public.user_role NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: bills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bills (id, datetime, workname) FROM stdin;
d8744471-19ef-4252-a8c0-326d4638514f	2024-07-27 06:43:32.52314+00	ABSTRACT1
8922d8ec-6f29-4578-bf3a-d19b454139c3	2024-07-27 06:47:46.12844+00	abstract2
418d7dc3-0901-46e7-ad80-7939073e3502	2024-07-29 12:32:50.293208+00	new
\.


--
-- Data for Name: complaints; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.complaints (comp_id, comp_nos, comp_loc, comp_des, comp_stat, comp_date, fin_datetime, fin_text) FROM stdin;
ceb17417-bec2-47db-bfb1-42a7a87f139e	1	1	1	open	2024-07-27 06:43:04.399+00	\N	\N
14059525-1e67-4d94-aa69-6f40dc224229	2	2	2	open	2024-07-27 06:43:07.998+00	\N	\N
24572c90-9f7f-4d55-82a4-39675d94eefb	58167	RP Hall, B- block 2nd floor east bathroom	Urinal pot chocked (urgent)	closed	2024-08-05 05:00:41.273+00	2024-08-05 05:01:45.529+00	work done
4a8ab158-920e-49b6-911e-78c0a947183b	Mail	RP HALL	BATHROOM JAM	open	2024-08-05 05:05:32.509+00	\N	\N
49a64828-95d3-4f09-b126-7c7f7c7bb8a3	58168	\tH1-95,near dol park	Water leakage from commode pan and flash did not work properly.	open	2024-08-05 05:09:21.645+00	\N	\N
2f8132e1-04ca-4aeb-b6bb-f995007a7f52	58169	Kalidas auditorium ladies toilet vikramshila	one commode waiste leakage replace/ repair	open	2024-08-05 05:10:50.498+00	\N	\N
a158ce0c-469f-440a-8975-c79e0ff82834	58174	BRAmbedker Hall-LAV-C-11	urinal main drain pipe is LICKED AND face to very problem .please treat as very urgenttre	closed	2024-08-05 05:13:32.136+00	2024-08-05 05:14:30.067+00	work done
c49ee06d-e433-40e3-88e8-edb95ca2a0c1	58172	SAM HALL #113	commode cover to replace.	closed	2024-08-05 05:12:17.996+00	2024-08-05 05:15:19.802+00	work done
09b636e4-0142-4116-a6bd-9e9994ceccaa	57922	1BR-64	WC PIPE CHOKED	open	2024-08-05 05:22:02.206+00	\N	\N
cdece6dd-fd54-4628-8b45-d1fc511725df	58175	A69 Kajubagan area	water is not passing in the balcony	closed	2024-08-05 05:16:02.034+00	2024-08-05 05:24:30.583+00	work done
e4146af2-9ab9-46e8-96f8-232aaed55cf9	58176	RKHALL E-412 NEAREST WASHROOM	2-URINALE PIPE NEED TO BE CHANGED	closed	2024-08-05 05:17:00.578+00	2024-08-05 05:24:49.742+00	work done
00ec5118-efa1-4f26-b68b-a2a74377107c	58181	1BR-49	\tbasin water stagnant at kitchen . S.Steel cover plate may be cut to pass the water	closed	2024-08-05 05:17:53.4+00	2024-08-05 05:25:11.495+00	work done
634fe73f-4f8f-417d-b69f-77595e233005	58183	A-02	gratting	closed	2024-08-05 05:18:52.92+00	2024-08-05 05:25:31.222+00	work done
51f95ac5-59a0-4242-8364-3229cd65c152	58185	BRAmbedker Hall-LAV-D-31/D-41/D-42/D-53/C-41	commodes are damage .treat as very urgent.	closed	2024-08-05 05:20:26.088+00	2024-08-05 05:25:46.229+00	work done
727e517a-c749-449c-9c74-938ba615466c	LETTER	A-34	COMMODE CHANGE	open	2024-08-05 05:34:59.082+00	\N	\N
10091deb-c48c-4b90-a623-3d50ce0b5aef	57817	CRDIST ( RDC)	New commode (EWC) required & two sprinkler not working.	open	2024-08-05 05:35:42.882+00	\N	\N
b8292865-7275-42f5-9d37-75c9c70ffa89	letter	C1-28	PAN CHANGE	open	2024-08-05 05:36:48.578+00	\N	\N
9b1ac789-14cb-4477-aece-ae33a3a420db	58190	IGH Hall room no A-303	Water blocked in washroom	closed	2024-08-05 05:37:38.184+00	2024-08-05 05:38:06.04+00	work done
9ca07ccc-bbb9-454f-a94b-8ebaeb64417b	58196	Architecture and Regional Planning Department_mezzanine floor_gents toilet	\tUrine outlet pipe is damaged. Need to be changed immediately.	closed	2024-08-05 05:38:40.825+00	2024-08-05 05:38:54.729+00	WORK DONE
67f3d331-4e7c-44bd-8866-0d1929fd6632	58213	Tea Research lab , AGFE, IIT KGP	Urinal and basin output pipe is damaged. water input pipe jammed. full maintenance needed	closed	2024-08-05 05:39:39.624+00	2024-08-05 05:39:53.888+00	WORK DONE
3dccadaf-30fe-408c-b8c9-343e47107fa0	58214	SN/IG Hall C block Top Floor Bathroom URGENT	Drain chocked badly.please treat as urgent	closed	2024-08-05 05:40:43.208+00	2024-08-05 05:41:00.056+00	WORK DONE
1f7c8680-cfff-42e0-96f4-13f301a61eec	58216	Zakir Hussain hall	1/201: the kitchen sink drainage pipe is got chocked	closed	2024-08-05 05:41:30.103+00	2024-08-05 05:42:32.471+00	Work done
b333d79b-560e-49c8-8c0b-71c639aad7fe	58218	423 tarrace and 011 lab at life science building	tarrace drain pipe installation and 011 lab basin drain repair	closed	2024-08-05 05:43:46.11+00	2024-08-05 05:44:07.437+00	work done
ff7f9a05-e175-4c1d-a926-30a7c50bfedc	58219	JCB HALL F BLOCK SECOND FLOOR TOILET	ONE OF THE URINAL PIPE IS BROKEN NEED TO BE FIXED AT THE EARLIEST	closed	2024-08-05 05:44:53.645+00	2024-08-05 05:45:12.798+00	Work done
72b5fca3-0d4f-4429-bf31-17a9f4dbf3d4	58224	SAM HALL 229,106	\tBATHROOM PIPE LINE BLOCK	open	2024-08-05 06:01:50.11+00	\N	\N
d09c2969-e3e7-439d-8eb1-e096d884d511	58227	B 256, opposite Tech market SBI ATM	Kitchen drain jam and water overflowingin whole kitchen. URGENT.	closed	2024-08-05 06:05:24.293+00	2024-08-05 06:06:16.052+00	work done
070558e0-fac6-4340-89e7-d2f095017d3e	58226	B-218	Commode seat is broken	closed	2024-08-05 06:04:29.453+00	2024-08-05 06:06:32.485+00	work done
403fda65-3db2-430d-b5fc-025583074835	58231	RLB hall, B&C block ground floor bathroom(4th toilet).	Commode cover is broken and need to be replaced.	closed	2024-08-05 06:07:46.635+00	2024-08-05 06:08:00.917+00	work done
bfc68ab8-8da8-40f4-ac99-0f795469bdc3	58232	gokhale hall	\ta.004.toilet.commode.broken.emergency.	closed	2024-08-05 06:08:32.923+00	2024-08-05 06:08:47.563+00	work done
e80e09e6-337d-41ce-9de7-14416f80dc76	58233	RLB Hall, B-Block 1st floor bathroom 4th toilet.	Commode cover (4No.) are broken need to be replaced, one commode is damage need to be replaced	closed	2024-08-05 06:09:27.299+00	2024-08-05 06:09:47.29+00	work done
7bbd7cc8-cd88-45a8-86c5-4a14493fa819	58234	PDF Block Room No-303	Bathroom drain chocked urgently	closed	2024-08-05 06:10:18.435+00	2024-08-05 06:10:32.747+00	work done
b26837e4-16bd-4590-9f64-05230dcdaa22	58237	Sister Nivedita Hall. OA BACK SIDE 1 ST FLOOR	sanitary line broken, dirty water leaking,Urgent	closed	2024-08-05 06:11:07.403+00	2024-08-05 06:11:23.234+00	work done
0f248e42-73b4-4715-b397-920a6ae9e69c	58239	Sister Nivedita Hall. C 4th floor	SANITARY LINE CHOCKED, URGENT	closed	2024-08-05 06:13:02.817+00	2024-08-05 06:13:34.778+00	\twork done
e8f06522-61d0-4622-b0b2-4ea71b7df403	58242	LBS/LAV/C/32	\tCOMMODE SEAT BROKEN	closed	2024-08-05 06:14:58.048+00	2024-08-05 06:15:21.329+00	\twork done
c6ce4803-a924-4365-a6a4-d5f7e10b1c47	58243	Patel Hall C top mid bathroom.	oilet seat broken. Pl. do the needful	closed	2024-08-05 06:17:04.559+00	2024-08-05 06:17:15.625+00	work done
6760a95c-03d2-41d3-b9df-a9512f883fc8	58280	snvh hall	block first floor syncardia outine pipe jaaam	closed	2024-08-05 06:18:09.912+00	2024-08-05 06:18:24.352+00	work done
f10d50a8-4582-478a-9fd5-75bf0f37e404	58281	D-4	Sanitary water of bathroom chocked. Water is not passing	closed	2024-08-05 06:18:56.358+00	2024-08-05 06:19:07.808+00	work done
d31a8857-0829-47bb-ac57-0d877a06a0b9	58282	RR-333	\tbathroom choked do the needful. URGENT.	closed	2024-08-05 06:19:40.535+00	2024-08-05 06:19:52.223+00	work done
9c6b825d-ec52-4219-87a5-db87ac41a0eb	58284	BRAmbedker Hall-LAV-C-22	INDIAN PANS 01 NOS IS CHOKED	closed	2024-08-05 06:20:24.167+00	2024-08-05 06:20:42.598+00	work done
5adf729e-bf69-48f1-a803-40cf47270bfb	58245	B252, opp to Tech Market SBI ATM	Grating of outlet drain of kitchen to be fixed. Rats are entering.	closed	2024-08-05 06:19:24.47+00	2024-08-05 06:21:20.865+00	work done
4c24e9a7-828d-4bd3-83d8-39b01a8b0436	58288	LBS/LAV/B/11 Previous complain no- 58047	Urinal jam	closed	2024-08-05 06:21:14.951+00	2024-08-05 06:21:23.887+00	work done
4b5a8237-7bd5-4e19-a789-8ad033764771	58289	LBS/LAV/B/13	Urinal jam, surface pvc pipe chocked	closed	2024-08-05 06:21:55.262+00	2024-08-05 06:22:12.663+00	work done
b664cd9a-160c-48c9-a146-6c8807c01c0b	58292	Lavatory near C-123 in RLB Hall	one commode cover needs to be fixed.	closed	2024-08-05 06:22:57.373+00	2024-08-05 06:23:20.438+00	work done
3749142d-85bf-4dc4-89d8-897777a9ce8f	58290	lavatory near B-201 in RLB Hall	one commode cover is broken.	closed	2024-08-05 06:23:50.581+00	2024-08-05 06:24:04.524+00	work done
fd1bfc63-a1dc-4121-9eda-9f0c4133d611	58291	B-311 in RLB Hall	two commode covers are broken.	closed	2024-08-05 06:24:54.861+00	2024-08-05 06:25:11.476+00	work done
4957ac6e-40f3-419e-8c3e-97d17925b616	58246	B-317	\tThere is a jam in the bathroom. Water is not flowing outside. Please fix it.	open	2024-08-05 06:26:43.5+00	\N	\N
d07f4b33-1844-4f18-95a0-78c204f23a89	58294	B 256 (beside staff club)	WC Cover broken. May be replaced.	closed	2024-08-05 06:27:14.045+00	2024-08-05 06:28:25.788+00	\twork done
9dadb5ce-c2be-48dc-b28d-3161db731664	58295	Stable Isotope Laboratory, Dept.-GG, 1st Floor, Prof. Anindya Sarkar.	Water Overflow from Laboratory Basin	closed	2024-08-05 06:29:27.699+00	2024-08-05 06:29:56.698+00	\twork done
43bf4d56-836b-4817-b816-a8f5ebe74a47	58300	2BR-96, Near Gas Godown gate	1. Washbasins drain leak and block	closed	2024-08-05 06:30:43.163+00	2024-08-05 06:31:05.986+00	work done
e426d8be-ea07-49fa-a334-5ed0960706bd	58303	B 219 Oriental flats Near Rabi shop	Commode covers became too dirty. Need replacement.	closed	2024-08-05 06:31:40.058+00	2024-08-05 06:31:52.538+00	\twork done
54f7688a-cb48-4742-93e2-dcf0c51dedf2	57643	CRR Building (Near RDC)	4th Floor Gents toilet - urinal pipe blocked - URGENT	closed	2024-08-05 06:32:25.681+00	2024-08-05 06:32:36.395+00	\twork done
a6d37b9f-6bde-4686-a919-8ad435b44a20	58248	BRAmbedker Hall-LAV-D-41	urinal main drain pipe is damage	closed	2024-08-05 07:19:21.902+00	2024-08-05 07:20:05.942+00	\twork done
fefedd4e-0937-490f-b7e5-bd12e6c794d2	58247	BRAmbedker Hall-LAV-C-12	02 nos commodore covers are damage. treat as very urgent	closed	2024-08-05 07:20:57.244+00	2024-08-05 07:21:21.893+00	work done
f9cd5ac0-2ffa-4e17-b59f-9ed1cb84d7c3	58249	\tBRAmbedker Hall-LAV-D-41 and D-42	\t02 nos Indian Pan Choked need to be Clear treat as very Urgent.	closed	2024-08-05 07:21:53.492+00	2024-08-05 07:22:08.845+00	\twork done
389c5f47-963c-495f-8979-dbe97213843c	58251	RP Hall, D-extension 1st floor bathroom	Urinal is jammed in the 1st floor bathroom	closed	2024-08-05 07:23:01.507+00	2024-08-05 07:23:13.669+00	\twork done
38f1e220-336f-47c1-80ca-f083cdaee1ea	58254	HK-W-321	COMMODE SEAT BROKEN. URGENT.	closed	2024-08-05 07:24:02.291+00	2024-08-05 07:24:12.1+00	\twork done
75539625-1ad6-41e4-965c-2e2a336bf368	58265	A-49 - Oriental bldgs	\tClogged drain-please help ASAP	closed	2024-08-05 07:26:23.915+00	2024-08-05 07:26:41.458+00	\twork done
12773127-6057-4dc8-84b8-3e8f2a9a4fa6	58256	B281 (behind DAV school)	\tslow flow of tap water in bathrooms	closed	2024-08-05 07:24:52.331+00	2024-08-05 07:25:04.674+00	\twork done
d9b4e2fe-346c-4941-9eb9-4f5a74d1ac29	58264	B-81	Toilet Seat cover needs a fixing.	closed	2024-08-05 07:25:34.451+00	2024-08-05 07:25:46.379+00	\twork done
c5480d5f-5546-4d05-a339-60e1fc9b5ca0	58272	M.T. Hall block-E Lav- 4	\tOutlet choked	closed	2024-08-05 07:27:19.595+00	2024-08-05 07:27:34.514+00	\twork done
b8ade620-fe17-44c3-9912-ea3864f594e4	58271	M.T. Hall BLOCK -B LAV-1 1st floo	Outlet choked	closed	2024-08-05 07:27:58.217+00	2024-08-05 07:28:11.619+00	\twork done
7b8e0231-13cb-4e7e-bc44-98536cf425ad	58274	B-258 First Floor Apartment (near DAV school)	Kitchen wash area water drain blockage	closed	2024-08-05 09:41:09.066+00	2024-08-05 09:41:20.754+00	\twork done
c5a8ab24-a783-4c3a-af6b-1b15c589cd93	58276	RP Hall, C-block 2nd floor East bathroom	Two urinal pot and urinal outlet pipe chocked	closed	2024-08-05 09:42:00.619+00	2024-08-05 09:42:18.802+00	\twork done
f9fa8e15-23d2-48e9-a107-3c6b5d52d3ce	58277	RP Hall, 1st floor west bathroom	\tOne number of urinal pot and outlet pipe chocked	closed	2024-08-05 09:42:47.168+00	2024-08-05 09:43:06.914+00	\twork done
2753f9cc-93cf-4805-a688-5e590acec079	58279	RP Hall, E-block 1st floor west bathroom	One urinal pot and outlet pipe are chocked	closed	2024-08-05 09:43:51.624+00	2024-08-05 09:44:09.946+00	\twork done
ac1d7db8-2553-4d7a-b323-ef9e60cbe40a	58306	VSRC-2- Girls Block -3rd floor bathroom	Basin Drain Chocked need to be clean	closed	2024-08-05 09:45:24.792+00	2024-08-05 09:45:37.584+00	\twork done
59f0141a-1bee-4fa2-b663-075b9fdbaa7e	58308	BRAmbedker Hall-LAV-C-32	02 nos Urinal pot Out-Lets are Choked.need to be Clear treat as very Urgen	closed	2024-08-05 09:46:14.353+00	2024-08-05 09:46:27.776+00	\twork done
afdaffd4-b40a-4b0f-87e9-c8ea230b0cd7	58317	MESS 1st floor bathroom.	\tUrinal pot down pipe leakage	closed	2024-08-05 09:48:17.183+00	2024-08-05 09:48:34.751+00	work done
c8254f16-05aa-43a5-a9c5-ecc121ba6706	58310	Mess 1st floor washing area	vertical drain pipe chocked and water leakage ,urgent	closed	2024-08-05 09:49:15.151+00	2024-08-05 09:49:25.103+00	work done
1ca007bd-73de-47a8-93b4-15d107595693	58311	SAM HALL #201	\tbathroom jam	closed	2024-08-05 09:50:05.439+00	2024-08-05 09:50:16.743+00	work done
e96e64ec-5f02-43df-92b0-c541c1b3b891	58316	Nalanda complex north side 3rd floor brieer toilet	one coomde creak repair /replace	open	2024-08-05 09:50:56.517+00	\N	\N
e5ef5286-87aa-4202-bd0c-a778b5c883b0	58318	Patel Hall D Bl. Top fl. bathroom.	Urinal pot outlet pipe are damaged. Pl. do the needful.	closed	2024-08-05 09:51:52.069+00	2024-08-05 09:52:06.934+00	Work done
2bdb060c-5aa9-40b1-bdcc-dcc9d54e8986	58321	RKHALL B-BLOCK WEST SIDE TOP FLOOR	\tCOMMOD COVER BROKEN	closed	2024-08-05 09:52:41.597+00	2024-08-05 09:52:59.932+00	work done
603072f8-4d42-4247-996d-2bf4f0308463	58327	R100 (Microelectronics & MEMS Lab), E & ECE Dept.	Water leakage from the drainage line of DI Water Plant. Pl repair it urgently.	closed	2024-08-05 09:54:00.451+00	2024-08-05 09:54:22.981+00	work done
f467d016-3153-4983-a7e6-79d5185dfd73	58329	B-46	\tseat cover	closed	2024-08-05 09:55:05.917+00	2024-08-05 09:55:22.948+00	work done
6bf25cc1-43bd-4dfd-b953-a3060a7073e1	58332	HJB Hall(HLV/14)	\tBathroom chocked.	closed	2024-08-05 09:56:38.859+00	2024-08-05 09:57:56.258+00	work done
069462af-76d7-4808-b00f-b490e21fee98	58334	RR-331	\tbathroom choked do the needful . URGENT.	closed	2024-08-05 09:58:48.234+00	2024-08-05 09:59:01.058+00	\twork done
e4b537f9-db3d-4ea5-91af-e647308681f4	LETTER	B-127	COMMODE CHANGE	open	2024-08-05 10:00:37.339+00	\N	\N
0c1eaa2f-7c90-4ada-b498-6b487551515f	LETTER	A-159	COMMODE CHANGE	open	2024-08-05 10:00:56.697+00	\N	\N
e6358b6a-c402-42ba-8d36-fcf08303aea9	58337	Sister Nivedita Hall. C-3rd floor	SANITARY LINE CHOCKED, URGENT	closed	2024-08-05 10:08:38.967+00	2024-08-05 10:08:53.614+00	\twork done
3f35f362-0ea0-48eb-a300-a7e6abac1968	58336	RP Hall, D-extension 1st floor bathroom	\tOne number of urinal pot and outlet pipe chocked	closed	2024-08-05 10:09:36.07+00	2024-08-05 10:09:55.822+00	WORK DONE
b851fced-bb21-47b5-91c7-7307e9951125	58340	Gymkhana	\tIst Floor of Gymnasium Mens Toilet out block,,take urgent action	closed	2024-08-05 10:10:38.03+00	2024-08-05 10:10:49.885+00	\twork done
33dc3416-d9a7-46a6-8c96-943dbdff90ab	58339	LBS HALL LAV/B/41	Urinal PVC Pipe Chocked	closed	2024-08-05 10:11:21.34+00	2024-08-05 10:11:40.022+00	WORK DONE
f5844e52-9f5d-4de7-b736-b2bb83fcd786	58343	IGH Hall room no A-102	Water blocked in washroom	closed	2024-08-05 10:13:25.396+00	2024-08-05 10:13:39.435+00	\twork done
22fdb9f5-b877-4e78-9490-f09c379eb244	58346	Room No- 302, NC Block, VSRC Old	Water sinking through kitchen sink	closed	2024-08-05 10:14:17.019+00	2024-08-05 10:14:31.811+00	\twork done
b3b4026d-5f55-4931-b652-8b5c87dcac22	58349	B169	Broken Pipe at back of house and sewage water falling on the ground	closed	2024-08-05 10:15:10.172+00	2024-08-05 10:15:28.915+00	work done
4574509c-0041-4fe8-91b2-fadcf80e677f	58350	1BR-82, Near Tech market.	\tblockage in bathroom drain pipe. please repair it urgently.	closed	2024-08-05 10:16:10.939+00	2024-08-05 10:16:25.843+00	\twork done
043a2c4f-bb39-4a06-b4d3-cd148a7e8c2c	58357	j c bose Building Toilet no T 11	\turinal waste line leakage urgent repair	closed	2024-08-05 10:17:19.291+00	2024-08-05 10:17:36.571+00	work done
4a8de5c9-1728-4849-806f-5fd0c13e46cc	58360	\tLBS/LAV/D/51	\tBath room jam (one)	closed	2024-08-05 10:18:45.778+00	2024-08-05 10:19:04.763+00	\twork done
88357c8c-7adc-4a19-bc3a-cf88a41bad99	58361	LBS/LAV/D/52	\tUrinal jam	closed	2024-08-05 10:19:44.777+00	2024-08-05 10:20:01.491+00	WORK DONE
deefdac6-bb52-4f62-a501-287b81f9c053	58365	snvh hall	d block first floor toilet outline pipe jaam	closed	2024-08-05 10:20:36.105+00	2024-08-05 10:21:00.674+00	\twork done
4db15e46-cbdd-4095-9de9-256563b36cef	58368	Sister Nivedita Hall. d-1 st floor toilet	SANITARY LINE CHOCKED, URGENT	closed	2024-08-05 10:22:01.161+00	2024-08-05 10:22:27.304+00	work done
efcdd217-db3d-4d87-abb5-8254e3329562	58366	2BR 45	Bathroom outlet jam. 1st floor.	closed	2024-08-05 10:23:09.985+00	2024-08-05 10:23:31.136+00	\twork done
bbfbc52d-0a7a-4836-9102-70e0f7b27f06	58370	DEPARTMENT OF OCEAN ENGINEERING AND NAVAL ARCHITECTURE Ground Floor Wash Room inside Head Room	Steel Net with hole is needed for the used water outgoing pipe in the floor	closed	2024-08-05 10:24:11.801+00	2024-08-05 10:24:44.135+00	work done
99efefb8-e25c-4c87-8e79-802d661d0b24	58371	Sister Nivedita Hall. na 3rd floor	BACK SIDE SANITARY LINE CHOCKED, urgent	closed	2024-08-05 10:25:20.703+00	2024-08-05 10:25:28.935+00	\twork done
22bd9257-8023-4e1d-8fce-892e1fe0be3a	58372	FTA 10, landline: 60475	Water is leaking from a drainage pipe on the first floor of the building	closed	2024-08-05 10:26:04.776+00	2024-08-05 10:26:12.32+00	\twork done
969e8120-1e05-40c9-8171-65d7fd92616c	58374	BCRTH	NEW LINE FIXING VERTICAL.	closed	2024-08-05 10:26:45.878+00	2024-08-05 10:27:01.358+00	\twork done
02ba69cb-77f6-4911-88d0-06d7d6dfb2b3	58375	B-314	BATHROOMS AND KITCHEN TRAP JAM.	closed	2024-08-05 10:28:19.543+00	2024-08-05 10:28:31.622+00	\twork done
19195763-3d5b-4ed9-a6b7-87f6bb61e51e	58377	Patel Hall C Gr. fl. west bathroom	Commode lid broken. Pl. do the needful.	closed	2024-08-05 10:29:36.663+00	2024-08-05 10:29:55.877+00	\twork done
48fa335d-4303-4b02-92e0-a9fafe52fba8	58378	Patel Hall C bl. Top fl. Bathroom. both side	\tUrinal outlet pipe damaged and drain chocked. Pl. do the needful.	closed	2024-08-05 10:30:27.75+00	2024-08-05 10:30:42.549+00	work done
89fcdd90-84b5-4204-98e3-eef2997e8a8d	58385	MS hall-MW-1ST fl bathroom	\tURINE PIPE TO BE REPLACED	closed	2024-08-05 10:39:12.018+00	2024-08-05 10:39:26.05+00	\twork done
30be121d-6c58-45da-b9cc-5e2f81146f9a	58386	MSA 3/2	problems with seating pad on commode, water flush leakage, second time	closed	2024-08-05 10:40:01.88+00	2024-08-05 10:40:21.586+00	\twork done
44917658-0948-4ea5-9823-321372c04f42	58387	LBS/LAV/DD/32	\tUrinal pan soft pipe disconnected	closed	2024-08-05 10:40:50.584+00	2024-08-05 10:41:32.625+00	WORK DONE
95a06537-a5bb-4d90-9ace-f7e4570cd94f	58389	B-316	Sewage water pipeline is choked, need to be cleaned.	closed	2024-08-05 10:42:07.847+00	2024-08-05 10:42:40.736+00	work done
0e2ad9c5-f870-4c33-8e97-2b6fbbac0524	58398	BRAmbedker Hall-LAV-A-23	\t01 nos urinal outlet is chocked .treat as very urgent	closed	2024-08-05 10:43:20.945+00	2024-08-05 10:43:36.208+00	\twork done
0d61ffd1-cf1d-444d-86fb-62720c9701d3	58399	JCB HALL C-EAST BLOCK GROUND AND FIRST FLOOR	URINAL OUTLET PIPES ARE IN 4 NOS. ARE BROKEN NEED TO BE REPLACED WITH NEW ONES	closed	2024-08-05 10:44:45.023+00	2024-08-05 10:45:17.366+00	\twork done
2c5288a7-07c5-4ce1-835c-e4ca355fc510	58404	VSRC-1 NA-Block Room No-206	Commode cover need to be changed	closed	2024-08-05 10:46:33.471+00	2024-08-05 10:46:54.158+00	\twork done
57acbb79-d690-40c6-becb-52220651908e	58405	SDS-218	bathroom choked. URGENT.	closed	2024-08-05 10:47:19.286+00	2024-08-05 10:48:22.303+00	\twork done
d5983af3-a836-4c17-be60-a2406cd8ba7b	58409	snvh hall	\tsnvh hall first floor toiletoutline pipe jam	closed	2024-08-05 10:49:06.557+00	2024-08-05 10:49:24.846+00	WORK DONE
219205e1-ff7b-48e8-a009-ee6a4d3f3b05	58410	snvh hall	first floor common room toilet outline pipe jam	closed	2024-08-05 11:05:05.078+00	2024-08-05 11:05:37.312+00	work done
65db8cc2-b2cc-45a7-819b-5c2140b81ccd	58413	MT HALL A-207, LAV 32- A Block	Water is blocking due to washbasin	closed	2024-08-05 11:06:10.889+00	2024-08-05 11:06:23.173+00	\twork done
92a8a384-7d3a-4603-86b3-1e9b9e8ce59d	58414	Qtr. B313	Kitchen outlet jammed. Dirty water from outside entering kitchen. Needs very urgent attention.	closed	2024-08-05 11:06:50.077+00	2024-08-05 11:07:00.053+00	\twork done
2b61d4e2-1b36-41ba-8c55-46cd50cbbb38	58415	B 46	Replaced Toilet Cover Plastic broken again at the base, cheap quality, replacement requested	closed	2024-08-05 11:07:43.164+00	2024-08-05 11:07:55.668+00	work done
f36f2117-df7e-4d03-a33e-ae6bcce256af	58417	B 302	\tUpper floor toilet pipe leaking near common bathroom.	closed	2024-08-05 11:09:31.31+00	2024-08-05 11:09:42.454+00	work done
0f3b4782-8cef-4b7f-88d3-df7f3a220d8b	58421	RR 333	drain chocked,urgent	closed	2024-08-05 11:10:07.182+00	2024-08-05 11:10:16.765+00	\twork done
4d0fdb30-8ee4-4c03-915f-764f40e1f65f	letter	B-231	C.I PIPE LEAKING	open	2024-08-05 11:11:07.03+00	\N	\N
5bf634a4-8722-4b7f-80ce-f012d6d3decb	58423	VS HALL B-101	Bathroom urinal pipe chocked	closed	2024-08-05 11:11:44.235+00	2024-08-05 11:11:55.955+00	work done
b10b812e-cdf4-4629-8d4e-b13346ae9f23	58424	MS hall-E1-2ND FL	\tCOMMODE COVER BROKEN	closed	2024-08-05 11:12:19.003+00	2024-08-05 11:21:15.373+00	work done
d3c5c41b-db62-436f-a706-4b3d530c7ca8	58428	RLB Hall, B-Block 1st floor laundry room.	\tBasin outlet pipe is broken, its urgent.	closed	2024-08-05 11:21:53.425+00	2024-08-05 11:22:06.406+00	\twork done
969ea513-5102-4308-8c73-8ee9b3a8203b	58436	IGH Hall room no A-107	Washroom dring blocked	closed	2024-08-05 11:22:48.198+00	2024-08-05 11:23:06.983+00	\twork done
90196de3-9b55-4d9e-b0df-7ae8299b0904	58470	RLB Hall, A&B Block junction 1st floor bathroom.	Wash basin pipe is leakage, kindly repair the leakage and do the needful.	closed	2024-08-06 06:32:51.576+00	2024-08-06 06:33:04.728+00	work done
e092cc5b-3a61-4b58-952a-c762880ecb85	58438	Gymkhana	\tIst Floor of Gymnasium Mens Toilet blocked,,take urgent action	closed	2024-08-05 11:23:53.329+00	2024-08-05 11:31:33.398+00	\twork done
317a3d1c-00b1-4280-b03c-eeef3709f3fc	58439	\tRR-537 	\tCOMMODE SEAT BROKEN. URGENT.	closed	2024-08-05 11:32:21.53+00	2024-08-05 11:32:52.279+00	\twork done
21a80bfb-40e1-4655-8faf-3b41a60f4acb	58440	RR-333	\tbathroom choked. URGENT.	closed	2024-08-05 11:33:38.529+00	2024-08-05 11:33:52.766+00	\twork done
40b5aec3-720c-4af8-9399-1b7c036449f1	58444	BRAmbedker Hall-LAV-D-33	02 nos commode and indian pans are chocked. treat as very urgent	closed	2024-08-05 11:34:37.529+00	2024-08-05 11:35:07.903+00	\twork done
08e4e9fa-5256-469b-a3ee-3f0149e706b8	58443	\tBRAmbedker Hall-LAV-C-32	re-complain 04 NOS urinal ports outlet leaked and damage.need to be process	closed	2024-08-05 11:35:38.351+00	2024-08-05 11:35:49.711+00	\twork done
7a2001d6-2dc5-42ed-97fb-d25c35bbe034	58447	LBS/LAV/AA/41	\tUrinal pan socket broken	closed	2024-08-05 11:36:23.955+00	2024-08-05 11:36:33.043+00	\twork done
aafebcc6-2249-4ffd-97c1-9ddd56562fcb	58445	LBS/LAV/B/41,42	Commode sit broken (black plastic one, white plastic one))	closed	2024-08-05 11:37:06.222+00	2024-08-05 11:37:37.991+00	\twork done
a0dbc1de-e250-402e-8bf3-b93df59449b9	58448	MT HALL A Block 1st Floor	Washroom Chocked	closed	2024-08-05 11:38:11.554+00	2024-08-05 11:38:26.31+00	\twork done
ae992cfb-0bba-4f89-a1bd-a6e86253ee9f	58449	LBS/LAV/DD/21	\tUrinal Pot jam	closed	2024-08-05 11:38:54.079+00	2024-08-05 11:39:14.463+00	\twork done
05f25111-8f1d-48f7-9d0b-4615519663c9	58456	B-273 (3rd Floor)	\tOutlet pipe blockage in the Kitchen. Water over flows outside the Kitchen.	closed	2024-08-05 11:40:12.595+00	2024-08-05 11:40:26.328+00	\twork done
60dadd65-00fb-4f5b-af22-e40585194fa3	58457	Sister Nivedita Hall. C-4th floor	\tBACK SIDE SANITARY LINE CHOCKED, urgent	closed	2024-08-05 11:40:48.767+00	2024-08-05 11:41:03.872+00	\twork done
e3332759-a273-4f19-9ab0-b737ece33a22	letter	K.V-16	COMMODE CHANGE	open	2024-08-06 06:12:59.746+00	\N	\N
f262a69c-95fc-42b1-b9d6-2305ea87b687	LETTER	V.S.HALL	URINAL PIPE LEAKING	open	2024-08-06 06:15:22.104+00	\N	\N
8bd68904-b94f-40b8-b6da-1035d4834bc1	58462	2 BR - 43	Door seal broken. Water flowing out.	closed	2024-08-06 06:29:38.881+00	2024-08-06 06:29:54.937+00	work done
d3b9d723-1008-4ef6-8648-16bda7c35c3c	58469	RP Hall, B Block beside library between A block corridor dak room	\twater is leakage from dak room	closed	2024-08-06 06:31:45.129+00	2024-08-06 06:32:09.208+00	\twork done
fbf5661c-2e8e-49ef-bb18-d7a848dcd13d	58472	HJB Hall(HLV/14)	\tOne bathroom chocked.	closed	2024-08-06 06:35:00.463+00	2024-08-06 06:35:14.463+00	\twork done
0289d89f-e907-49cd-8905-c44ffcadf582	58471	HJB Hall(HLV/7)	One urinal pipe broken.	closed	2024-08-06 06:35:48.574+00	2024-08-06 06:36:56.142+00	work done
bbfd041b-98f0-4a67-aff5-09b3925801a1	58473	Qrt no : 1BR -5	1. commode cover broken 2. Kitchen outlet pipe line chocked	closed	2024-08-06 06:37:35.213+00	2024-08-06 06:37:42.069+00	\twork done
33ee15a4-5288-4920-b10e-4a5320153a95	58475	VSRC-1 NA 206	\tCUMMOT COVER BROKEN	closed	2024-08-06 06:38:16.454+00	2024-08-06 06:38:29.446+00	work done
1114d8dc-9a7e-4b6d-9bc2-e4ac1c2c8740	58476	1BR-64 KGP	\tKITCHEN DRAIN PIPE & W.C. SOIL PIPE CHOACKED	open	2024-08-06 06:38:59.926+00	\N	\N
a1ce1235-01ca-480c-a56c-29f5335d4fb3	58477	VSRC-1 ND 101,301,303 NE 102,203	CHANGE CUMMOT COVER URGENT	closed	2024-08-06 06:39:43.621+00	2024-08-06 06:40:37.884+00	work done
653a107f-9efc-479e-989f-1933b55dca40	58478	Architecture and Regional Planning_Mezzanine Floor_gents toilet	urinal pipe is damaged. plz do immediate action.	closed	2024-08-06 06:41:12.78+00	2024-08-06 06:41:30.108+00	work done
b5a67175-02f3-4eeb-8beb-6cd39bd9dfc3	58480	Toilets of Old Building 1st Floor	Connecting pipe not working	closed	2024-08-06 06:42:03.429+00	2024-08-06 06:42:13.989+00	\twork done
ae32cd8f-cffc-425e-bdf2-b316a7001766	58482	Nehru Hall, C/block (New) top floor East & West sides bathroom.	Bathroom outlet drain chocked, please do the needful (Very Urgent).	closed	2024-08-06 06:43:03.964+00	2024-08-06 06:43:16.516+00	\twork done
d411932e-13b5-43c5-a4dd-d2cc518ee8e6	58481	Nehru Hall, B/block 2nd floor bathroom.	Bathroom outlet drain chocked, please do the needful (Very Urgent).	closed	2024-08-06 06:44:02.812+00	2024-08-06 06:44:16.587+00	\twork done
dd3f9237-4514-47f6-8e1f-662e5fac465e	58482	Nehru Hall, C/block (New) top floor East & West sides bathroom.	Bathroom outlet drain chocked, please do the needful (Very Urgent).	closed	2024-08-06 09:35:32.004+00	2024-08-06 09:36:04.892+00	\twork done
a8cc8203-323c-481e-91e1-f7f9175fdf9e	58485	BRAmbedker Hall-LAV-D-11	01 nos urinal outlet pipe is damage.	closed	2024-08-06 09:36:37.603+00	2024-08-06 09:38:17.955+00	work done
4b8f36b7-41ab-41b2-940b-5636c24e95f4	58484	BRAmbedker Hall-LAV-D-12	\t02 nos Urinal pot Out-Lets are Choked.need to be Clear treat as very Urgent.	closed	2024-08-06 09:38:59.738+00	2024-08-06 09:39:13.291+00	\twork done
a96c96f2-c83e-4fce-8d9c-12e088b79606	58487	C1-159	\tWATER IS SPILLING FROM BALCONY	closed	2024-08-06 09:39:49.73+00	2024-08-06 09:40:05.539+00	work done
5cac93c4-685d-4a97-b466-aa874f4427a1	58488	RR-540	bathroom choked. URGENT	closed	2024-08-06 09:41:39.153+00	2024-08-06 09:42:04.49+00	work done
610c872c-10e3-4aa3-839d-5f4b9e98db65	58489	C1-108	Outside Sewer cap is missing	closed	2024-08-06 09:43:04.297+00	2024-08-06 09:43:19.24+00	work done
84b6aa3c-79c8-4bab-a56e-3eba7cd60709	58491	Deptt.of Biotechnology (DJ Building) 7th floor toilet	Urinal outlet pipe choke	closed	2024-08-06 09:45:04.728+00	2024-08-06 09:45:19.432+00	work done
80133549-5cec-46c9-980d-5f3601a44e5e	58493	I&SE Department	Ground Floor ladies toilet is chocked and 2nd floor ladies toilet is chocked	open	2024-08-06 09:45:50.959+00	\N	\N
b3d08a61-4c65-4a9a-bfa7-7b4898b71de5	58494	SNVH - GROUND TO TOP FLOOR C BLOCK 	OUT LET PIPE JAM CLEAN THE PIPE PIZ . URGENT .	closed	2024-08-06 09:46:25.431+00	2024-08-06 09:46:42.999+00	work done
53dcc2c7-1c42-49e3-b19c-1591f3fbe2df	58498	MS hall-ME-204	BACKSIDE OF BATHROOM CHOCKED	closed	2024-08-06 10:04:10.896+00	2024-08-06 10:04:22.672+00	work done
55fdcab1-7448-4d35-9b66-090517f573a4	58497	Nehru Hall, C/block (New) top floor East & West sides bathroom.	Commode seat cover needed in 3 toilets, please do the needful.	closed	2024-08-06 09:47:29.431+00	2024-08-06 10:02:53.584+00	\twork done
9021cc71-7614-4768-b4b2-b9703f8c89ba	62029	MS hall-w4	\tbathroom toilet chocked	open	2024-08-09 11:26:39.172+00	\N	\N
fc86debf-ccc3-4895-a00c-dc2909fcdaae	62030	MS hall-nw-gr fl bathroom	\tDOOR BROKEN,	open	2024-08-09 11:27:11.123+00	\N	\N
9a71b312-11b1-4058-a28a-3aac03404829	62033	HK W 509	\tCOMMODE LID NOT WORKING	open	2024-08-09 11:27:38.371+00	\N	\N
cfc82b5e-365a-45e2-a411-12472c90b6ed	58507	SN/IG S 1st floor toilet	Chocked badly.Please treat as urgent	closed	2024-08-06 10:04:57.455+00	2024-08-06 10:06:21.767+00	work done
7c00f9e9-5b73-4305-9f5e-137c50a4182d	58512	LLR HALL A BLOCK 1ST FLOOR AND 2ND FLOOR	BATHROOM/ OUTLET PIPE IS CHOCKED . URGENT	closed	2024-08-06 10:07:12.223+00	2024-08-06 10:07:25.655+00	\twork done
bf646118-b7e9-440b-aad0-86d15c5bd5a1	58513	B-140	\tin kitchen water is coming back from water outlet pipe..kindly see..	closed	2024-08-06 10:08:01.278+00	2024-08-06 10:08:12.615+00	work done
2f3491ea-5870-43b4-a0ce-d497a1e2f063	58515	LBS/LAV/B/24	urinal out let pipe damage change (3)nos	closed	2024-08-06 10:08:44.35+00	2024-08-06 10:09:00.685+00	\twork done
2dda3977-d8ad-4bb1-a61f-988d1908c86e	58520	H 118	FITTING OF COMMODE AND MAKING NEW LINE	closed	2024-08-06 10:09:56.925+00	2024-08-06 10:10:14.646+00	work done
ac4254d2-f99b-4e5b-aca4-6c5a3a9934f0	58578	1BR-133	Bathroom outlet blockage water is lodging in the bathroom repair it urgently	closed	2024-08-06 11:03:36.455+00	2024-08-06 11:03:55.55+00	work done
3577ba06-31c4-4d54-9d2c-a6c9155d059c	58527	Sister Nivedita Hall. B-1ST FLOOR BACK SIDE	SANITARY LINE CHOCKED, URGENT	closed	2024-08-06 10:13:02.003+00	2024-08-06 10:32:07.836+00	\twork done
f5df785d-61ac-4102-8fad-4346220e5c33	58530	Cryogenic Engineering Centre	Six pipes of waste water of 1st floor (back side of dept.) are broken. Please take necessary action.	closed	2024-08-06 10:32:51.075+00	2024-08-06 10:33:23.26+00	work done
18246716-3dca-4fe0-9b67-8d88405b821e	58533	1BR -91	\tBroken the Commode	open	2024-08-06 10:35:17.346+00	\N	\N
d5c37ae5-7082-495e-b08a-9b3d81289b23	LETTER	NFA-100	C.I PIPE LEAKING	open	2024-08-06 10:38:25.497+00	\N	\N
75f38078-5360-49fb-a8d0-681a03bd3311	58130	BF2/16	My quarter has got a severe damp from a leaking pipe outside	closed	2024-08-06 10:39:32.745+00	2024-08-06 10:39:47.297+00	work done
ab20eb9d-0e29-47dd-aefa-c5143603353b	58540	B46VV	replaced toilet commod plastic broken, very poor quality, replacement requested	closed	2024-08-06 10:40:31.088+00	2024-08-06 10:40:53.856+00	\twork done
386a10db-5a16-4df4-a76d-58d0bf0209ce	58542	PDF Block Room No-303	\tBathroom drain chocked urgently	closed	2024-08-06 10:41:26.543+00	2024-08-06 10:41:38.656+00	\twork done
680bdfbd-55ce-4453-adf9-ffdfda8f6ae8	58544	RP Hall, E- Block ground floor east and west bathroom	urinal outlet PVC pipe inside the bathroom to be change, to much old and urine are chocked, leakage	closed	2024-08-06 10:42:12.111+00	2024-08-06 10:42:24.079+00	work done
99e17922-b910-466b-93de-7a9a24f33028	58545	B-314	\tBoth Bathroom Commode Covers should be replaced	closed	2024-08-06 10:42:54.808+00	2024-08-06 10:43:07.24+00	\twork done
c4303b03-d6d7-4d07-9a49-f54899a9bd22	58546	HJB Hall(HLV/6)	Urinal pipe broken.	closed	2024-08-06 10:43:33.888+00	2024-08-06 10:43:56.439+00	\twork done
d34db59f-cf1f-4065-92b6-ab677ac3a24d	58547	Rubber Technology Centre	Leakage from the urinal basin. pl. do the needful.	closed	2024-08-06 10:44:48.655+00	2024-08-06 10:45:00.551+00	\twork done
e6f12a1c-c387-4d11-aa52-0a48de3f75f2	58548	RK HALL OF RESIDESNCE A BLOCK GR. FLOOR	WC PAN CHOKED FIX NEW ONE.	open	2024-08-06 10:45:59.462+00	\N	\N
6b218cc2-39cc-45d1-9fc4-496f385f6608	58557	B-267, Near DAV Model School, IIT campus	Drainage water flooding in Kitchen	closed	2024-08-06 10:46:41.358+00	2024-08-06 10:46:56.534+00	\twork done
1da0fe78-09f6-4a0c-88d9-815537b5f956	58560	Sister Nivedita Hall. na top foor	\tSANITARY LINE CHOCKED, URGENT	closed	2024-08-06 10:47:42.398+00	2024-08-06 10:49:21.861+00	\twork done
d4708db4-ed0a-4575-8340-1b13124bbee5	58562	SDS-234	\tbathroom choked. URGENT.	closed	2024-08-06 10:49:52.917+00	2024-08-06 10:50:12.156+00	\twork done
487bc137-fee0-4f93-b6e8-d9860cc37cd0	58561	\tDSK-E-424	\tbathroom choked. URGENT.	closed	2024-08-06 10:50:47.237+00	2024-08-06 10:50:58.925+00	\twork done
a7f05e17-5002-4c50-97e2-22d9928ea48a	58563	SDS-219 	bathroom choked. URGENT.	closed	2024-08-06 10:51:36.691+00	2024-08-06 10:52:26.939+00	\twork done
6d249ebe-9372-4f4f-a75a-f3220cacb5b6	58584	RR-345	\tbathroom choked. URGENT.	closed	2024-08-06 11:05:03.294+00	2024-08-06 11:05:24.966+00	work done
9a0294b9-2893-4047-ae91-da78aa33b6c4	58564	\tSDS-217	\tbathroom choked. URGENT.	closed	2024-08-06 10:54:38.922+00	2024-08-06 10:56:19.979+00	WORK DONE
cc98dfcb-f575-4c33-894e-0b80820865d9	58567	Deptt. of ARP	urinals leaking in mezzanine floor toilet	closed	2024-08-06 10:56:57.817+00	2024-08-06 10:57:57.234+00	WORK DONE
d558644a-6217-4d10-8c95-99c0085e848f	58573	RR-333	bathroom choked. 	closed	2024-08-06 10:59:52.481+00	2024-08-06 11:00:10.576+00	work done
5ef21ebf-5a3a-4926-ae42-d2653c45f170	58575	SDS-537	Water stagnated in bathroom.	closed	2024-08-06 11:00:47.159+00	2024-08-06 11:01:04.727+00	\twork done
28a3cb0e-5e24-45e5-8c7b-ddc09056f245	58576	2BR-92	Bathroom waste water not passing.	closed	2024-08-06 11:01:59.384+00	2024-08-06 11:02:12.695+00	work done
e2bbb590-b5d8-42c6-a333-4b123011c415	LETTER	V.S HALL A-35	Urianl pipe leaking	open	2024-08-06 11:03:03.718+00	\N	\N
aade0e49-ec09-4ee3-858c-8891026146fa	58589	\tBRAmbedker Hall-LAV-A-23	01 nos urinal outlet pipe is damage.	closed	2024-08-06 11:11:52.899+00	2024-08-06 11:12:11.219+00	work done
951705db-0e28-4ef2-9beb-b232c6639b9d	58588	Azad Hall C-Block back side wall	\t05 nos. toilet out let pipe damage. need to replace URGENT.	closed	2024-08-06 11:13:18.699+00	2024-08-06 11:13:33.426+00	\twork done
00146381-c9af-4ad3-a463-8dd2176d5fd1	58595	C1-159	Water is not passing through the bathroom	closed	2024-08-06 11:14:26.074+00	2024-08-06 11:14:42.594+00	\twork done
8872aeb2-cd15-4d2b-a3a0-af1dc2a39b70	58594	LBS/LAV/C/21	Urinal pan jam	closed	2024-08-06 11:15:10.786+00	2024-08-06 11:18:13.144+00	work done
960dbe92-8084-4aa0-8d2e-7483a219d723	58602	Qtr No. 1BR 04	bathroom drain Jam	closed	2024-08-06 11:20:21.104+00	2024-08-06 11:21:50.893+00	\twork done
8ca39dc6-5458-4ba1-af72-39900ed0cf92	58607	HJB Hall(HLV/6) 1st floor	\tOne urinal pipe broken and main pipe blockage.	closed	2024-08-06 11:22:20.216+00	2024-08-06 11:22:35.663+00	\twork done
6e85d2f2-f4fa-4ea7-8597-2c6d32a2cf2d	58614	Nalanda complex Admin block gr floor & 3rd floor toilet NO T 18.16	\turinal pan leakage	closed	2024-08-06 11:31:44.564+00	2024-08-06 11:33:07.898+00	WORK DONE
09031673-1b49-4079-8bbf-5885763635e0	58608	1br 74	\tBathroom drain pipe blockage	closed	2024-08-06 11:23:05.423+00	2024-08-06 11:24:28.198+00	\twork done
e2a4e4fb-fd4a-4b48-805e-c9fd7922e226	58612	MT HALL A-206 ( A- Block 1st Floor)	water leakage in drain chocked	closed	2024-08-06 11:25:06.677+00	2024-08-06 11:25:22.574+00	\twork done
361208a6-9c71-4191-9259-cd0f0fdbe3ad	58611	MT HALL A-306 ( A-Block 2nd floor)	\t2nd floor bathroom drainage is blocked	closed	2024-08-06 11:25:57.013+00	2024-08-06 11:26:12.397+00	work done
c55a56fc-49ce-4ea6-9b63-b6b84b3d1df5	57927	Annex Building CSE Department	\t06 Urinal Pot exit pipes need to be changed in all 3 floors Gents toilet.	open	2024-08-06 11:29:05.26+00	\N	\N
f146a89d-14ed-4f3b-a98a-c2f06e5990e6	58617	Azad Hall D-Block 1st floor backside	\tToilet out let pipe blockage and leaking, do the needful urgent besis.	closed	2024-08-07 04:52:58.876+00	2024-08-07 04:53:54.277+00	work done
e78ee0d4-0492-4eab-b19a-42872c0bad38	58618	A 73	Kitchen drain got choked.	closed	2024-08-07 04:54:46.052+00	2024-08-07 04:55:14.94+00	work done
946a1921-f4cb-4b99-a84a-a189b5204973	58621	LBS/LAV/DD/32	\turinal pvc pipe jam	closed	2024-08-07 04:56:07.709+00	2024-08-07 04:56:30.508+00	\twork done
789b7250-d745-4ee2-bb39-fdf827f7b81a	58620	\tLBS/LAV/DD/12	urinal outlet ring pipe chocked	closed	2024-08-07 04:57:02.484+00	2024-08-07 04:57:16.659+00	\twork done
4c58aacc-54a8-49de-a9b0-bd1070faac1a	58627	Nalanda complex north side admin block toilet NO13	one pan cover replace	closed	2024-08-07 04:57:55.435+00	2024-08-07 04:58:10.619+00	work done
e2b411c3-e7d2-4d8c-bc05-7146fc084d15	58630	LBS/LAV/DD/32	URINAL OUTLET PIPE DAMAGE	closed	2024-08-07 05:00:06.946+00	2024-08-07 05:00:45.824+00	\twork done
d5f9d7d8-32a1-4973-980a-4c991066c7c1	58638	NFA QUARTER NO 129, OPPOSITE TECH MARKET	WATER FROM COMODE LEAKING OUT EVERYTIME FLUSH IS BEING USED	open	2024-08-07 05:01:33.538+00	\N	\N
cf31bceb-211a-4bb8-9d4b-08b047dbf75a	58639	\tGSSST Takshashila Building, First Floor	Gents Toilet drain chocked	closed	2024-08-07 05:02:06.073+00	2024-08-07 05:02:27.809+00	\twork done
306baa62-fbeb-43b5-82e9-c90d3bfefffd	58643	\tMS hall-NW-GR FL	\tTOILET SHEET COVER BROKEN	closed	2024-08-07 05:03:42.151+00	2024-08-07 05:04:12.368+00	\twork done
cbe0bc5d-ca8f-4484-bdca-7b6424e6338a	58629	H-110, Behind vsrc building	\tPan should be replaced . Indian to Commode.	open	2024-08-07 05:05:04.056+00	\N	\N
abbf125c-eaf1-4f73-91ec-14979ef7783f	58656	LBS/LAV/D/24	urinal pvc pipe jam	closed	2024-08-07 05:05:45.511+00	2024-08-07 05:06:05.752+00	\twork done
4f167c45-391a-4a53-9de1-7405123cbbc7	58657	\tLBS/LAV/DD/22	\tbathroom drain jam	closed	2024-08-07 05:06:48.351+00	2024-08-07 05:07:09.295+00	\twork done
8c8c6013-9aed-412c-aa7b-212110f56702	62319	M S Hall-NW-312	\tWATER NOT GOING OUT	open	2024-08-10 06:01:44.548+00	\N	\N
af21069d-d0a2-4f5c-92ba-b6bc842e73a2	62404	DSK-N-527 8218939612.	\tCOMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 06:35:15.368+00	\N	\N
e6dfec00-b9e2-4e4c-bf79-c0d4c8bd1c79	58658	RKHALL E-BLOCK 2ND FLOOR WEST SIDE	2-COMMOD COVER /SHEET BROKEN	closed	2024-08-07 05:07:43.398+00	2024-08-07 05:08:00.326+00	\twork done
03fdaa5f-629c-4c0b-b512-6bd9b14caa22	58659	VSRC-1 NA-Block Room No-206	\tCommode cover need to be changed	closed	2024-08-07 05:08:56.541+00	2024-08-07 05:09:12.631+00	\twork done
c1d376ec-b550-44ac-a2c2-5fb6bbd8dcef	58660	\tRKHALL E- BLOCK top east side wash room	1-COMMOD COVER BROKEN	closed	2024-08-07 05:09:58.973+00	2024-08-07 05:10:21.902+00	work done
71299c00-681e-428e-a6c9-c2aed1200371	58661	HK W -301	BALCONY WATER NOT GOING ,URGENT	closed	2024-08-07 05:10:51.885+00	2024-08-07 05:11:09.869+00	\twork done
cf1055c6-a638-4f6d-b076-0a7ad562af8d	58663	B281 (behind DAV school)	\tre-installation of drainage blocker in bathrooms	closed	2024-08-07 05:11:59.828+00	2024-08-07 05:13:28.892+00	work done
1e75ff0d-7a37-4164-ad54-d2bc74a2a363	58664	BF-1/11 ( Girls Hostel)	\twater logging	closed	2024-08-07 05:15:08.98+00	2024-08-07 05:16:16.707+00	\twork done
d23c5bc7-7fd3-43e4-a803-ae344761973b	58665	Qtrs. No. A-65	Water outlets are choked	closed	2024-08-07 05:17:38.603+00	2024-08-07 05:17:57.634+00	work done
96caa069-25e8-41a8-bada-4faa6d251bed	58666	\tSAM HALL #142	Commode broken	open	2024-08-07 05:18:50.569+00	\N	\N
8afaaf02-051d-449a-9d9f-b2ea382dae81	58667	Nalanda complex north side admin block gr floor T 18	\tLadies urinal pan waiste replace/ repair	closed	2024-08-07 05:19:29.858+00	2024-08-07 05:19:51.041+00	\twork done
dcbd1272-2551-47bf-8b4d-5d4ec5ec8304	58669	\tMS hall-W3 TOP FL BATHROOM	BATHROOM CHOCKED- FLOOR IS GETTING FLOOD- URGENT	closed	2024-08-07 05:20:30.145+00	2024-08-07 05:20:44.761+00	\twork done
83837142-611a-4a23-9e67-34b0d2eb8336	58673	Sam Guest	\tRoom no 343 commod out late pipe leckege	closed	2024-08-07 05:21:22.305+00	2024-08-07 05:21:35.449+00	\twork done
ad412716-8085-462e-9169-b11d22ae71ba	58677	IGH Hall room no B-209	washroom outlet gets choked	closed	2024-08-07 05:22:24.625+00	2024-08-07 05:22:46.96+00	work done
154e9fcf-5767-4089-a143-82e834c57af8	58679	VSRC-2 Gents Block	urinal pipe jam at 3rd floor east wing bathroom	closed	2024-08-07 05:23:59.599+00	2024-08-07 05:24:26.544+00	\twork done
efbab91f-fc88-438c-9f40-9718bcc91d82	58681	\tLLR HALL A1 EAST TOP LAV	\tCOMMOD LID IS BROKEN/ DAMAGED, URGENT	closed	2024-08-07 05:25:29.679+00	2024-08-07 05:25:44.391+00	\twork done
c379bb70-a424-42f7-a306-3b6b82b1718d	58682	LLR HALL C 1ST FLOOR EAST LAV	\tWASTE PIPE IS DAMAGED. URGENT	closed	2024-08-07 05:27:46.485+00	2024-08-07 05:28:01.846+00	\twork done
d4d4a7bf-5b17-457b-82e9-66c7fa551da7	58683	SDS-537	bathroom choked	closed	2024-08-07 05:29:34.534+00	2024-08-07 05:29:47.693+00	\twork done
a454230d-25d0-4b75-b225-dfa25e211c78	58697	Sister Nivedita Hall. NA TOP FLOOR WASHROOM	WATER BLOCKED,URGENT	closed	2024-08-07 05:30:34.213+00	2024-08-07 05:30:51.06+00	\twork done
40b15a56-b726-4351-a856-7962ba9cb0f7	58701	HJB Hall(HLV/8)	One pan seat cover broken.	closed	2024-08-07 05:31:42.597+00	2024-08-07 05:31:57.284+00	\twork done
9894ba61-926c-43f3-bf86-4895fe0400ec	58699	\tHJB Hall(HLV/6)	\tUrinal pipe broken.	closed	2024-08-07 05:33:07.492+00	2024-08-07 05:33:21.196+00	\twork done
7419679b-0cf3-47cd-adcf-1323d86df8c7	58700	A 93	washroom outlet is blocked	closed	2024-08-07 05:35:44.683+00	2024-08-07 05:37:25.306+00	work done
a490deba-fe9f-4bc9-a6e9-bfbe75996e07	58703	RP Hall, D-extension 1st floor Bathroom	4th, 5th, 6th number toilet pan seat are damaged, it to be change	closed	2024-08-07 05:38:24.626+00	2024-08-07 05:38:42.777+00	work done
584d6499-91ed-4b2d-af6c-5074084dd2c0	58724	SDS block back side of room no SDS-538	vertical drain pipe chocked 	closed	2024-08-07 06:00:00.904+00	2024-08-07 06:00:13.025+00	\twork done
f69334f3-1a41-48ff-ba06-e5e75faefbce	58705	1BR90	Toilet seat cover damage	open	2024-08-07 05:41:03.528+00	\N	\N
14de46fd-31f1-4a41-950f-2efd1011947a	58705	1BR90	\tToilet seat cover damage	closed	2024-08-07 05:39:35.785+00	2024-08-07 05:41:15.801+00	\twork done
1cd26658-4cd3-44a4-8254-a136fcfb62df	58707	Qt. No. D-23,	\tcistern for commode nonfunctional, Previous complain has no action. Request to do the needful	closed	2024-08-07 05:42:05.64+00	2024-08-07 05:42:15.737+00	work done
6bab61fe-ecb7-459a-b461-b8a8130b8745	58709	ARP dept	\tbathroom chock	closed	2024-08-07 05:42:42.496+00	2024-08-07 05:42:56.008+00	\twork done
9b3afdce-a178-4b01-8543-eb8783453d6e	58711	\tLBS/LAV/DD/22	One bathroom jam, urinal outlet pip`e jam	closed	2024-08-07 05:43:53.015+00	2024-08-07 05:44:09.183+00	work done
8c2b4e8a-3ebb-43de-9175-12cf5e9583a5	58715	SDS-537	bathroom choked.	closed	2024-08-07 05:45:05.959+00	2024-08-07 05:45:24.07+00	\twork done
ed9a67ab-d70c-4865-8d6b-c2062f7a796f	58718	DEPARTMENT OF OCEAN ENGINEERING AND NAVAL ARCHITECTURE	\tSteel Net with hole is needed for the used water outgoing pipe in the floor	closed	2024-08-07 05:55:17.859+00	2024-08-07 05:55:48.409+00	\twork done
1e4c95d2-d495-47cc-9bfb-c6a0531eb90e	58719	406, 4TH FLOOR JC GHOSH BUILDING CHEMISTRY DEPARTMENT	Drainpipe is leaking and the lab is full of water.	closed	2024-08-07 05:56:57.857+00	2024-08-07 05:57:09.866+00	\twork done
ff8300bc-546a-4c0d-a783-7287236d302e	58720	B-291	\tKitchen outlet blocked.	closed	2024-08-07 05:57:57.977+00	2024-08-07 05:58:10.714+00	\twork done
e824c1f1-bd34-408c-894e-4b5f325334d3	58721	MS hall-W2- 1st fl bathroom	\tFLUSH NOT WORKING, commode leakage	closed	2024-08-07 05:58:48.609+00	2024-08-07 05:59:04.081+00	work done
0c124302-3d77-4f71-ad15-0526c5ae5bc0	58726	MS hall-E2-GR, 1ST AND 2ND FL	FLUSH NOT WORKING, TOILET POT CHOCKED	closed	2024-08-07 06:26:26.508+00	2024-08-07 06:26:49.628+00	\twork done
3493d9fe-05f8-45ec-9702-50177b259f25	LETTER	1BR-64	KITCHEN OUTLET	open	2024-08-07 06:29:18.447+00	\N	\N
80ab1eeb-6355-4bc2-ad88-8055ca2d46ea	58629	H-110, Behind vsrc building	Pan should be replaced . Indian to Commode.	open	2024-08-07 06:30:18.282+00	\N	\N
2efb8f15-77a9-4a4a-95ef-f85af20273f1	Letter	LLR HALL ,A-157	COMMODE CHANGE	open	2024-08-07 06:31:33.863+00	\N	\N
4e8e75c3-3956-4f41-856a-7d86c80995ef	58728	B 285	need to clear all outpou	closed	2024-08-07 06:33:29.348+00	2024-08-07 06:33:45.068+00	WORK DONE
7c1ec787-1c88-4c2e-9878-38b2deed0a5e	58729	B 285	need clear and change all pipes	closed	2024-08-07 06:34:31.846+00	2024-08-07 06:34:43.888+00	work done
db6423b8-d3cc-408b-a188-0e83b786b609	58735	C1-155	Plaster broken over drain tank. Pls do the needful	closed	2024-08-07 06:35:14.211+00	2024-08-07 06:35:32.979+00	work done
16120774-67c7-4ee4-847f-66480f2e809c	58736	Architecture and Regional Planning Department	Please change the toilet sits of 2 Gents Toilets of the department urgently	closed	2024-08-07 06:36:24.812+00	2024-08-07 06:36:48.81+00	work done
c6cc3c09-f4e3-45d2-98f2-323ea944613b	58739	\tDSK-N-519	\tCOMMODE SEAT BROKEN	closed	2024-08-07 06:37:50.97+00	2024-08-07 06:38:04.603+00	\twork done
52e69e55-de3f-49e4-a3ce-0fa89b4b926c	58740	Azad Hall D-1st floor bathroom	01 toilet seat cover broken.	closed	2024-08-07 06:38:47.669+00	2024-08-07 06:39:04.83+00	work done
53a68cd1-bae4-48aa-ace7-3d9b495ee88d	58746	B-319,	Water logging in bathrooms	closed	2024-08-07 06:39:54.118+00	2024-08-07 06:40:06.437+00	\twork done
3f17938f-05c5-4e9d-adad-244748610a28	58752	A-087, Gurukul Complex	Water logging issue in washroom area.	closed	2024-08-07 06:40:36.173+00	2024-08-07 06:40:47.234+00	\twork done
454febfb-be82-4729-a174-b4db8a36edfc	58754	C1-144	Bathroom outlet was blocked and repaired. Now the bathroom outlet pipe is opened. Should be sealed.	closed	2024-08-07 06:41:31.579+00	2024-08-07 06:41:58.597+00	work done
55b5a6b6-f036-4840-b3b5-286c5fe15e12	58758	H 118	INDIAN PAN TO COMMODE REPLACEMENT	closed	2024-08-07 06:43:18.821+00	2024-08-07 06:43:32.389+00	work done
bba85227-8e20-4b8b-9903-ba1ba41ffba1	58760	Technology Guest House (TGH - 18)	Drain choked	closed	2024-08-07 06:45:55.709+00	2024-08-07 06:46:14.445+00	work done
db5babbc-b03e-46a4-b705-be98601ab3b0	58762	MS hall-W3- 2nd fl bathroom	\tBATHROOM CHOCKED	closed	2024-08-07 06:47:00.116+00	2024-08-07 06:47:26.548+00	Work Done
63163783-f6e4-4dde-b1f3-1fd6fcc22ca2	58765	RKHALL-WASHROOM NEAR C-311	\tTWO NO OF INDIAN LATRIN BROKEN NEED URGENT REPAIR.	open	2024-08-07 06:53:53.411+00	\N	\N
ac78c54a-4698-40b7-9e1c-103d8aca7be5	58767	1BR 57,	\tcommode cover brocken	closed	2024-08-07 06:54:29.777+00	2024-08-07 06:55:06.889+00	\twork done
256f18ed-9422-42db-adee-f00636a8da43	58769	HK-W-306	\tvertical drain pipe chocked	closed	2024-08-07 06:55:45.186+00	2024-08-07 06:56:00.884+00	\twork done
fbb5c9e2-492f-4095-93fe-f4d1217033ae	58768	\tHK-W-421	\tvertical drain pipe chocked	closed	2024-08-07 06:56:31.016+00	2024-08-07 06:56:55.948+00	\twork done
c3fdc677-54e6-41e2-a3c3-1d04b07ec5e0	58770	\tHK-W-125	\tvertical drain pipe chocked	closed	2024-08-07 10:11:51.154+00	2024-08-07 10:12:16.037+00	\twork done
2c24c4f6-3bb8-400b-b817-ccf82778e83e	58771	snvh hall	b block 1 floor bathroom 2 wash room- jaam	closed	2024-08-07 10:13:12.738+00	2024-08-07 10:13:50.413+00	WORK DONE
3f81759c-c905-4177-b356-c998d2f4eb4c	58781	\tC1-183, Near KV and gas godown gate	Kitchen sink is leaking water due to blockage.	closed	2024-08-07 10:14:55.394+00	2024-08-07 10:15:06.514+00	\twork done
4aca19b0-3dc9-4605-9b37-58264810053a	58780	HK-W-422 	\tBathroom sanitary pipe choke	closed	2024-08-07 10:15:35.5+00	2024-08-07 10:16:01.977+00	\twork done
4b006d18-a2aa-4c73-b543-2456d24250f6	Letter	G-124	PAN TO COMMODE CHANGE	open	2024-08-07 10:17:03.901+00	\N	\N
9a4fd576-1f55-427e-8ded-d8cbd8b81886	Letter	RAF-1`	kitchen drain jam	open	2024-08-07 10:17:50.473+00	\N	\N
990f4e18-efd4-41be-ad40-b95343cee2f8	Letter	A-166	commode change	open	2024-08-07 10:20:15.716+00	\N	\N
154f8381-046f-4c98-894e-9e47cb13756c	58783	Azad Hall C-Ext. floor west bathroom	Urinal outlet pipe broken.	closed	2024-08-07 10:31:28.17+00	2024-08-07 10:31:41.002+00	\twork done
d78d0827-65d2-41cb-814d-b89418bc8c81	58787	BRAmbedker Hall-LAV-D-33\t	\t01 nos indian pans is chocked .treat as very urgent	closed	2024-08-07 10:32:21.095+00	2024-08-07 10:32:36.546+00	\twork done
5d529b53-f3c3-467d-b975-44f28d57bc13	58786	PG INORGANIC LAB , ROOM NO-205, CHEMISTRY DEPARTMENT, J C GHOSH P C RAY SCIENCE BULDING	Most Urgent-water overflow from balcony. Exhaust pipe did not work properly	closed	2024-08-07 10:33:09.947+00	2024-08-07 10:33:34.151+00	\twork done
6388f56d-9836-460c-86d1-a774c25b1c2f	58799	Back side of HK-S-106	SANITARY PIPE BEND COVER BROKEN	closed	2024-08-07 10:34:12.99+00	2024-08-07 10:34:32.911+00	\twork done
85b75441-f441-4d99-9d55-e027f532ab7e	58798	\tsnvh hall	d block 3 floor three number toilet outline pipe jaam	closed	2024-08-07 10:36:01.907+00	2024-08-07 10:36:15.456+00	\twork done
2b8738b3-598b-41f0-ba6e-9abaae2a1d8b	58803	VSRC-2- Girls Block -1st floor bathroom	Bathroom drain chocked 	closed	2024-08-07 10:36:56.647+00	2024-08-07 10:37:06.711+00	\twork done
9ca9efaa-368a-4262-b8a5-3a158670b612	58802	SN/IG E block 2nd floor bathroom and S block ground floor bathroom	Chocked badly.Please treat as urgent	closed	2024-08-07 10:37:48.186+00	2024-08-07 10:38:02.681+00	\twork done
e5b4f99d-b487-4b9a-81b8-f8a959121086	58808	IGH HALL A - 106	SINK IN THE KITCHEN IS CLOGGED	closed	2024-08-07 10:38:57.063+00	2024-08-07 10:39:12.018+00	\twork done
d0c7f83e-1950-41ad-887f-ca3e10e4f4af	58807	\tSecurity Office near Puri Gate	Toilet Urine Pan Pipes to be replaced urgently. Please attend.	closed	2024-08-07 10:40:06.17+00	2024-08-07 10:40:23.394+00	work done
d0eceeb0-8304-4472-8a0b-81e8f0dd0007	58843	R P HALL	D ext. Grd. Floor bathroom - urinal outlet pipe damaged	closed	2024-08-07 19:16:48.926+00	2024-08-09 04:38:31.667+00	work done
83dd8b09-3a98-48ad-827d-df1b63b21b51	58814	\tB 139	bathroom drainage water logged	closed	2024-08-07 10:40:55.842+00	2024-08-07 10:41:35.486+00	work done
d0bf91b0-71dc-46fc-846b-5e92132c60e3	58817	h1 109	\tcommode broken needs to change	open	2024-08-07 10:42:12.33+00	\N	\N
0c17feff-e2a8-4a05-b78a-7369fe37f5e7	58824	LBS TOP FLOOR A BLOCK	\tCOMMODE CHANGE WITH P TRAP.	closed	2024-08-07 10:43:01.687+00	2024-08-07 10:43:16.863+00	\twork done
71eca4d6-8266-433a-bac6-50f176cde1c4	58827	VSRC-1 NA-Block near Room No NA-102	\tSanitary pipe is broken	closed	2024-08-07 10:43:55.865+00	2024-08-07 10:46:21.747+00	work done
db70973a-3573-4a90-b4b2-96f171c13b68	58834	SAM HALL 134	FLUSH IS NOT WORKING AND KOMET BROKEN	closed	2024-08-07 19:06:38.788+00	2024-08-07 19:07:33.336+00	work done
4decc6d1-693b-4c5b-9b65-2b3017cd6839	58828	\tVSRC-1 NA-Block near room no-105	Sanitary pipe is broken	closed	2024-08-07 10:47:12.937+00	2024-08-07 19:09:38.33+00	work done
cc319010-2c80-4bdc-93b6-ce91f46baa13	58836	B-207	bathroom outlet blockage	closed	2024-08-07 19:11:40.288+00	2024-08-07 19:14:48.078+00	workdone
50b49ceb-bd3d-493b-90ae-771184ce6351	58840	cbose Annexe building toilet no T 11	two urinal waiste pipe leakage	closed	2024-08-07 19:14:23.855+00	2024-08-07 19:15:18.534+00	work done
c4a70aee-40c9-437e-8071-1997fbaad2d2	58844	JCB HAILL F- BLOCK GR 1ST AND 2ND FLOOR	ALL THE URINAL PIPES ARE DAMAGED ARE REQUIRED TO BE REPLACED WITH NEW ONES ASAP .	open	2024-08-07 19:15:56.766+00	\N	\N
867f8f4d-4779-447c-81ef-45d51844c270	60894	A 92	Kitchen drain choked	open	2024-08-08 05:45:08.932+00	\N	\N
a947d420-293d-4a50-aac4-e9d797104e27	58837	B150	Sink outlet requires clearing	closed	2024-08-08 05:47:48.622+00	2024-08-07 19:12:10.704+00	work done
fe49308f-4063-4ad2-814b-174f45a2a717	60895	Zakir Hussain hall	4/206: the commode cover is got damaged	open	2024-08-08 05:49:32.349+00	\N	\N
04bf3e05-48a0-4b5e-b2bf-04c094df2115	60896	warden office	urine pipe broken ,urgent	open	2024-08-08 05:51:05.164+00	\N	\N
8818aeb5-b241-42e8-9f29-0df42e8c8482	60900	VSRC-2 Gents Block	\tCommode upper side cover was damaged at 3rd floor East wing bathroom - 1nos	open	2024-08-08 05:52:40.367+00	\N	\N
b43cac3e-683a-4cbf-b593-948be3b1ab81	60901	VSRC-2 Gents Block	Commodes and Basins are moving at Floor- Ground,3,4,5	open	2024-08-08 05:53:45.604+00	\N	\N
0b85837a-5e6a-4838-8413-a8c5d7ddba79	60902	w511 mob-9327020945	no toilet seat cover	open	2024-08-08 05:54:42.811+00	\N	\N
739a4658-4019-438c-9848-531b8f8e863a	60903	s502 mob-9650143688	no toilet seat cover	open	2024-08-08 05:57:32.899+00	\N	\N
202fa1b1-23ca-4bde-829f-19ab2cd1c1ae	60904	s510 mob-8327963396	commode cover is loose not working properly	open	2024-08-08 05:58:25.291+00	\N	\N
e4056257-881d-4b18-9d33-b3ef1712925e	60905	s108 mob-98321718893	toilet seat is broken	open	2024-08-08 05:59:45.227+00	\N	\N
7bbca89c-97df-4d05-b793-7e488de874cc	60906	rr513g mob-7902848603	toilet seat broken	open	2024-08-08 06:00:37.323+00	\N	\N
9c34b8ee-40dc-4161-99ab-8bdf2c55e4ef	60909	toilet seat broken	The basin outlet is jam and leaking. The pipe needs to be replaced.	open	2024-08-08 06:01:34.947+00	\N	\N
a76b0779-bcff-4ed7-87a9-1b29dde805f0	60916	A-48	bathroom chock	open	2024-08-08 06:02:51.658+00	\N	\N
2cab2b51-c15f-4ef3-819c-58d13330f028	60919	A 48	Choking of wastepipe line in the kitchen	open	2024-08-08 06:04:14.202+00	\N	\N
9a2ecbdd-9949-4c10-9163-aa415db1df72	60921	JCB HALL C WEST 1ST FLOOR BATHROOMS	The water in the bathroom is not going out, it is getting jammed in the drain	open	2024-08-08 06:05:34.842+00	\N	\N
c45d3d17-1641-46f9-9beb-16ddb48174b0	60925	Zakir Hussain hall	2/101 and 2/106: both the bathrooms commode covers are got damaged	open	2024-08-08 06:06:26.946+00	\N	\N
79adecd5-509f-4f5b-92a0-734dff930734	60928	snvh hall d block ground top	outline pipe jaam urgent	open	2024-08-08 06:08:49.309+00	\N	\N
03516514-e7af-4df2-8006-8b23291855e2	60930	B-78, near dreamland hotel	Changing of outlet pipe for bathroom sink	open	2024-08-08 06:09:56.99+00	\N	\N
5e52673f-b080-4170-a15b-12524991f9a6	60934	Nalanda complex north side 1st floor ladies barrier toilet	Commode waiste line blocked	open	2024-08-08 06:11:01.143+00	\N	\N
dba9df2f-31e4-4225-9869-2c6957675512	60935	Gents toilet , New CRF Ground floor	Commode was loose from the ground lebel	open	2024-08-08 06:11:53.913+00	\N	\N
7e5353bb-1bd7-4d82-ab81-9895e71990db	60939	B-221	Blockage in the kitchen sink pipe. Need immediate cleaning.	open	2024-08-08 06:12:37.754+00	\N	\N
d945cfc7-40a9-4cdb-a27f-c57938de7e10	60941	2BRF-04	Water overflowing on bathroom floor due to drain or pipe blockage.	open	2024-08-08 06:13:44.008+00	\N	\N
32c09d56-e037-4acc-87a9-60bc9b29e494	60952	Civil Engg. Department	Toilet pipe line chocked in gents toilet (1st floor). Pl repair it urgently.	open	2024-08-08 06:15:54.793+00	\N	\N
50e51c17-8363-456b-b3f0-680d2fb607af	60956	snvh hall c block 3 floor	sink outine pipe jaam	open	2024-08-08 06:16:32.266+00	\N	\N
677028b1-e2e0-4b8e-a01c-9dfdb9d4866e	60962	STEP, IIT Kharagpur (Old Building) Ladies Toilet	1. Replacing two broken urinals. 2. Replacing 1 broken commode	open	2024-08-08 06:17:23.888+00	\N	\N
f9b2a45f-2f36-4513-969f-da9199e076ff	60956	snvh hall c block 3 floor	sink outine pipe jaam	open	2024-08-08 06:19:16.025+00	\N	\N
3f763cbf-6be9-4622-ae5b-d1dd133882a3	60962	STEP, IIT Kharagpur (Old Building) Ladies Toilet	STEP, IIT Kharagpur (Old Building) Ladies Toilet	open	2024-08-08 06:20:05.561+00	\N	\N
a8d1fc28-7a86-4360-8eed-3dcf56677614	60959	STEP, IIT Kharagpur (Old Building) Gents Toilet A	1. Replacing three broken urinal2. Replacing one commode	open	2024-08-08 06:21:02.408+00	\N	\N
bf03e1ba-0fa8-4874-9f54-7e4be7f25adc	60960	STEP, IIT Kharagpur (Old Building) Gents Toilet B	. Replacing of 1 Commode. 2. Replacing of 1 wash basin	open	2024-08-08 06:21:48.296+00	\N	\N
0a42970f-cd8a-4fb8-9bd6-a88765f495b7	60966	B-316	Sweage water pipeline is choked flooding toilet. Please clean the pipeline.	open	2024-08-08 06:23:15.343+00	\N	\N
249cc5bb-a812-4fb4-86f5-37d1d2ca7226	60968	1 BR - 83	Urgent: Huge water leakage from bathroom, seepage outside area	open	2024-08-08 06:23:57.416+00	\N	\N
5d91201a-ba61-41a2-a457-64713c392547	60974	b c roy hall W-11	urenel demarage	open	2024-08-08 06:24:49.648+00	\N	\N
124b405b-c0c0-443c-ae54-7c79f0778e24	60975	1st floor gents bathroom, E & ECE Departmen	commode cover is damaged and water is leaking	open	2024-08-08 06:25:42.504+00	\N	\N
3ae74a58-7601-44da-90e8-de0fd50c7cfe	60977	Nalanda complex north toilet no T 2 T 9	urinal waiste line leakage repair/replace	open	2024-08-08 06:26:42.224+00	\N	\N
575c71b3-0c40-4f48-b3a3-662e17ac8bc5	60980	WARDEN OFFICE	bathroom seat cover need replacement- urgent	open	2024-08-08 06:27:40.919+00	\N	\N
d0573898-2430-49f2-9ac2-af9d603be3a5	60985	BF-4/12	Water is flowing back from kitchen drainage. Repair ASAP	open	2024-08-08 06:28:36.063+00	\N	\N
41ecff3f-5d92-45fc-a0d8-3f8ed022a990	60988	C ROY TECH HOSPITAL FF [PATHOLOGY TOILET]	2 Commode seat to be replaced	open	2024-08-08 06:30:12.071+00	\N	\N
ed37c635-cdba-4757-b2f5-9165cc371b38	60994	Security Control Room, (near Puri Gate)	Toilet Urinal Pan leading massively. Please attend.	open	2024-08-08 06:33:37.51+00	\N	\N
f0139e41-6829-48f7-b94f-91f9e823727c	60996	Zakir Hussain hall	1/305: the sink drainage is got chocked	open	2024-08-08 06:35:55.086+00	\N	\N
b455647e-eaa7-4192-9a1b-f2147261d75d	60999	MT Hall C Block	Ground Floor- LAV-2 commode (pan) broken	open	2024-08-08 06:37:14.815+00	\N	\N
f0dca33d-54f9-4809-a5b6-43bf8d0f72c4	60997	MT Hall A Block	Ground floor - LAV1- commode (Pan) broken and LAV -6 Commode top broken	open	2024-08-08 06:38:07.335+00	\N	\N
41921b61-609b-4c84-b73f-9a6a33fd5932	60998	MT Hall B Block 2nd Floor	\tdrain chocked	open	2024-08-08 06:39:14.006+00	\N	\N
24c8cf9f-4e21-4444-ba5d-8a453c8e8905	61000	MT Hall D Block	\t2nd Floor - Commode lead top broken	open	2024-08-08 06:40:30.014+00	\N	\N
723748c5-314e-4fb6-8180-4a1dbf5eb75b	61004	QTR.NO-2BR.092; NEAR BY GAS GODOWN GATE	COMMON KITCHEN OUTLET WATER PASSING NOT PROPERLY FROM OUR BUILDING. PLEASE CHECK.	open	2024-08-08 06:41:32.302+00	\N	\N
7029db24-e66a-4a35-acdb-f7e4a8a72765	61009	Toilet No: T-17(Gents toilet), Elect. Engg. Deptt.	Wash basin waste line chocked	open	2024-08-08 06:42:13.125+00	\N	\N
74a977ea-cd92-4edc-b1bf-1f4c04f68c9b	61012	1BR 71	Kitchen drainage block ,cleaning require	open	2024-08-08 06:43:05.966+00	\N	\N
5a6adaa2-fb77-4839-8983-8646843c8f61	61013	SN/IG S block ground Bathroom URGENT	\tS block ground floor ceiling leaking due to sanitary Trap leaking.Please treat as urgent	open	2024-08-08 06:43:53.921+00	\N	\N
a17651dc-2ef0-414d-bb91-ebb5317259fb	61014	SN/IG F top floor bathroom URGENT	Drain Chocked.Please treat as very urgent as the water not passing out.	open	2024-08-08 06:44:37.182+00	\N	\N
0af3f4ba-e222-4a00-80d8-9fffc01f9888	61015	Central Library 	Annex Building 1st floor ladies bathroom wast water outlet pipe jam	open	2024-08-08 06:46:06.63+00	\N	\N
335558d7-8cc7-4408-9884-045f9c406764	61017	MS hall-E2-gr fl,1st fl	BATHROOM CHOCKED	open	2024-08-08 06:46:46.566+00	\N	\N
4efd9fbe-b7ff-4aa9-85a3-4b18bd092d9f	61018	B-301	Water not passing through bathroom pipe and kitchen pipe	open	2024-08-08 06:47:25.998+00	\N	\N
e29786c2-a637-4d9d-be7c-ca478f47cc9c	61024	B 285	\tchange all pipes of kitchen and toilet urgent	open	2024-08-08 06:48:22.669+00	\N	\N
0e71397a-5423-4d4a-a1c3-08bf5f5adc69	61026	gokhale hall	\ta.006.b.105.c.207.comode.sit.cover.broken.	open	2024-08-08 06:49:21.262+00	\N	\N
8fb4395d-3401-4c2f-95e2-04e686678e12	61029	 \tLBS/LAV/BC/32	Urinal pots outlets are jam	open	2024-08-08 06:51:00.974+00	\N	\N
230b11b3-1991-4394-a2de-862cde19db6d	61030	\tMSA 3/2	kitchen water basin is not working, emergency problem	open	2024-08-08 06:51:57.853+00	\N	\N
f7b3fcba-b7c3-4e72-abc9-dcbea857b28a	61032	VSRC-2 GIRLS BLOCK -3rd FLOOR BATHROOM	DRAIN CHOCKED NEED TO BE CLEAN	open	2024-08-08 06:52:50.421+00	\N	\N
3a9f029c-0e7b-4e03-82cd-3b6ef51a2ed4	61039	2BR-16	\tcommode pipe leaking inside	open	2024-08-08 06:53:36.877+00	\N	\N
328f6146-979b-487d-bd6c-e3c2b8d78ce6	61041	MSA 3-11	\tWater not draining from kitchen sink	open	2024-08-08 06:54:27.396+00	\N	\N
644e41cf-d240-4fa9-8dae-ba8852cc1e96	61043	1BR-138. (M): 9775225240	\tOut 🕳hole of the birth room is little bit jam, water move slowly, plz do the need full	open	2024-08-08 06:55:25.844+00	\N	\N
09b3a2ea-64c7-446d-9c86-65f9f96460db	61050	2BRF-04	\tComplaint 60941 not resolved yet. Water is overflowing on the bathroom floor.	open	2024-08-08 06:56:07.485+00	\N	\N
f3fbe27b-485f-4991-a4ab-5e52e13198b1	61053	bathroom on the second floor, mechanical engg dept	problem in urine pipe	open	2024-08-08 06:58:30.809+00	\N	\N
df205c26-6d76-42d0-a63d-5a5cc148e06e	61055	VSRC-2 GIRLS BLOCK -3rd floor near Aquagard	outlate pipe chocked	open	2024-08-08 06:59:43.588+00	\N	\N
9fbcd74b-c9a5-43df-a208-bdcc2376fbcb	61056	VSRC-2 GIRLS BLOCK -Ground and 4th floor bathroom	Getting is required in the bathroom hole urgently	open	2024-08-08 07:00:19.323+00	\N	\N
7cccdc18-c207-4921-89ec-3e8ad4ebe4cc	61068	snvh hall - NA- 1st , 3rd floor .	basin jam out let pipe clean .	open	2024-08-08 07:00:56.748+00	\N	\N
92fda11a-31a9-40e7-8218-79d8c1a842d7	61069	Jcbose Annexe building toilet no T 14	commode leakage	open	2024-08-08 07:01:33.252+00	\N	\N
79929401-bc77-4132-bfc2-a968c2879e24	61071	XPS Laboratory(Physics Deptt.) Near room of Prof. T K Nath , G/Floor	Wash basin waste water outlet line required.	open	2024-08-08 07:02:13.108+00	\N	\N
3035c876-0688-4814-8458-6dd8a3bb9f2a	61068	snvh hall - NA- 1st , 3rd floor .	basin jam out let pipe clean .	open	2024-08-08 07:03:39.576+00	\N	\N
f3dd5cc6-d262-40d8-89ad-94bc22f9706b	61084	H1-59 (DOL PARK)	Bathroom drain jam not clear waste/used water. Kindly do the needful. Thanks	open	2024-08-08 07:05:16.556+00	\N	\N
eec1c719-461d-41fa-a5d1-b6e5a937a5c6	61091	B 256, beside Staff Club.	WC seat broken again and again	open	2024-08-08 07:06:07.907+00	\N	\N
6a6c05f5-bc14-4db6-97a2-e142b0b243f7	61092	B 256, beside Staff Club.	WC seat broken. To be replaced by new seat of Parryware or equivalent strength.	open	2024-08-08 07:06:42.868+00	\N	\N
87dbf3d8-2536-45ad-8abc-0ea4b0bbba5a	61093	Qtr.No C-69(Mob-9681227829)	Water leakage during flushing commode, drain water blocked.	open	2024-08-08 07:07:22.02+00	\N	\N
47191d16-a0c0-44f8-a3f8-e71847373530	61095	Dept. of HSS (2nd Floor, Gents Washroom)	Latrine is broken and leaking.	open	2024-08-08 07:07:55.155+00	\N	\N
a7795f45-1305-4913-847e-3095770a1153	61096	B-112	Replacement/repair of damaged drainage pipe from kitchen and toilet Missing cover/cap of drain pipe.	open	2024-08-08 07:08:31.803+00	\N	\N
dbd7a37b-5077-4bd3-bb88-47ca8b904d1a	61100	B239 (near Tech market)	Drain jam	open	2024-08-08 07:09:16.655+00	\N	\N
41502d2a-9a01-42a9-b031-0dc02ad2a823	61104	STORE & PURCHASE	LADIES BATHROOM DOOR CLOSURE ISSUE	open	2024-08-08 10:36:28.147+00	\N	\N
678c64c8-e4ad-45ac-858c-9c827229e1cb	61108	B.R AMBEDKAR HALL-Lav C-52	Toilet is broken, replace on urgent basis.	open	2024-08-08 10:37:08.314+00	\N	\N
0e4683c0-a6d5-4de7-beb9-48b5fec9b905	61114	2BR-63	Water drainage pipe of the balcony is blocked. M-9232378235	open	2024-08-08 10:38:14.138+00	\N	\N
f2e24122-a2c9-4f0c-a2d0-7a7ba4226f72	61116	B-174, opposite to Tata sports ground	Toilet seat is broken. Please replace it by a white colour seat.	open	2024-08-08 10:39:06.755+00	\N	\N
ff60b6f1-394f-4a10-b71f-e7ec683d563b	61118	H1-64	The pan of the toilet has gone down.	open	2024-08-08 10:39:52.555+00	\N	\N
9a1dec3c-9189-448c-b244-b06a5ff6452b	61122	B R Ambedker Hall-LAV-C-22 & LAV-D-23	12 nos Urinal Out-Let pipes are Damage need to be Change.treat as very Urgent.	open	2024-08-08 10:40:54.074+00	\N	\N
5960aaec-1081-4835-8939-0f73c9331a8c	61123	New Food Court	Flash in the ground floor not working; Commode leakage of the shop Number 8 & 10 (1st & 2nd floor)	open	2024-08-08 10:41:40.778+00	\N	\N
d57ea73f-16a6-4525-9f5f-09180f8ee9c4	61124	Sister Nivedita Hall. D 3rd floor	outlet chocked fully. urgent	open	2024-08-08 10:42:47.8+00	\N	\N
e12fd893-063e-4e99-9638-50f5d27b0d52	61127	e516	seat cover is broken	open	2024-08-08 10:43:55.776+00	\N	\N
54bc9339-24f8-41dd-8c0e-e37adda1dfec	61128	n525	SEAT COVER BROKEN ,URGENT	open	2024-08-08 10:51:02.969+00	\N	\N
6c6ead68-505c-4d1f-8bba-1d2d9692596e	61129	b c roy hall , Lav NE 12	urinal drain is choked	open	2024-08-08 10:51:53.433+00	\N	\N
b54cfa5b-be6c-455d-90e6-585419c986c8	61132	SNVH - C- 1st floor	wash basin blocked .	open	2024-08-08 10:52:40.033+00	\N	\N
300c89db-be62-4cb1-8410-a5d07e227cb0	61144	Qtr B59	Toilet seat broken again. Kindly replace	open	2024-08-08 10:54:24.366+00	\N	\N
4c72e8f0-a5b6-4ddb-aeaa-ef219152287e	61150	289, Phone 85974 71365	Drainage of water from kitchen sink is too slow	open	2024-08-08 10:55:27.193+00	\N	\N
853a432e-e339-4327-b878-f5f7e9ab64e5	61151	RDC	ONE COMMODE CHANGE AND 6 URINAL PIPE CHANGE WITH COUPLING	open	2024-08-08 10:56:19.44+00	\N	\N
a95095f1-28c0-46fe-a919-dd90529490fd	61154	RK HALL B--211	S TRAP COMMODE -1, P TRAP COMMODE-2 INDIAN PAN -1 REQUIRED.	open	2024-08-08 10:57:18.512+00	\N	\N
d9ac00b2-1104-469d-a5db-1131169e0c74	61155	RP HALL E BLOCK 3RD FLOOR	ONE URINAL POT REQUIRED.	open	2024-08-08 10:59:20.104+00	\N	\N
987043f2-4b1b-49bd-9197-6bf78acc5958	61156	Computer & Informatics Centre, GENTS toilet	Toilet drain Jam	open	2024-08-08 11:01:53.246+00	\N	\N
cfa758a9-bd64-402e-9883-b5d46995224a	61161	B 264	kitchen drain blocked. immediately repair	open	2024-08-08 11:03:10.967+00	\N	\N
1280f77f-b331-440c-9900-ce5761c952bd	61165	MSA 3/1, Please call MOB- 8277200968	1) Jam in bathroom floor drain 2) Toilet seat is broken 3)Water leak from back of toilet seat	open	2024-08-08 11:04:21.359+00	\N	\N
2eb4fd60-225b-4292-8613-355c7185af56	61166	HK W 324	vertical pipe leakage ,urgent	open	2024-08-08 11:05:07.696+00	\N	\N
0dad3fa0-cac4-4ed0-a5ee-5ec631cac903	61167	A-125, Gurukul Complex	Toilet flush outlet need to be repaired. Water works people advised to complain to Sanitary section	open	2024-08-08 11:06:15.815+00	\N	\N
e099bad1-5be4-47d7-b0f4-06fdefbb88a6	61168	B-301	Water not passing through bathroom pipe.	open	2024-08-08 11:06:51.007+00	\N	\N
7fd62d65-6fc5-4d42-9d62-e94678685308	61186	VSRC-2 Gents Block	Water is not passing properly at 1 st floor east wing bathroom - 1 nos	open	2024-08-08 11:07:39.102+00	\N	\N
931fc5a2-680e-4e0a-9b63-9109d7446186	61188	A 7	Please change the toilet seat cover and put a sieve in the outlet of outhouse toilet	open	2024-08-08 11:08:53.023+00	\N	\N
9f5d7cdc-d233-44ca-9005-53d5bcf45811	61137	B-108	Drainage pipe lid broken. Replacement required	open	2024-08-08 11:11:02.27+00	\N	\N
dc332005-4ef6-407e-978d-99a8c53e8ea6	61189	R.K.Hall A ground 01 indian pan changes, a-block 1st fl-panchangrd	02 nos indian pan changes	open	2024-08-08 11:11:48.286+00	\N	\N
8cf1e50c-7b8b-430f-ab6d-d664002382a3	61190	RK.Hall A block 1st floor	01 S Trap commode changed	open	2024-08-08 11:12:51.583+00	\N	\N
e38f0b65-3ffc-4e13-92b4-ac61e898fc8e	61191	NFA- 100 (NFA block 14 near tech market)	Water leaking back to washroom after flushing please call before visit urgent	open	2024-08-08 11:13:46.79+00	\N	\N
c76c5820-bc81-421b-b3d9-7a06a3915b33	61192	RK. Hall B-211	S-Trape commode EWC-1 piece, P-trap EWC-commode-02 nos	open	2024-08-08 11:14:37.694+00	\N	\N
233edaaa-f4e1-40f2-b122-8d14fdd7af96	61193	RK Hall-B-211	01 Indian pan changed.	open	2024-08-08 11:15:24.686+00	\N	\N
b6fd99dc-7529-4b81-ab0f-73b3389d0922	61201	2BRF-15	Waterlogging in the bathroom.	open	2024-08-08 11:16:10.494+00	\N	\N
d6da1b06-2bf0-42b4-b407-8e9c8a862d5d	61203	HK-S-510 MOB NO 8327463346.	COMMODE SEAT IS BROKEN.	open	2024-08-08 11:16:47.046+00	\N	\N
723863f3-1554-48a5-bba5-c4449dec8694	61204	BRAmbedker Hall-LAV -B-51	06 nos Urinal pot Out-Lets are damage .need to be Clear treat as very Urgent.	open	2024-08-08 11:17:35.742+00	\N	\N
696e9fcc-eddf-417e-92ab-ab63b74da191	61205	DSK-N-308 MOB NO 7340267750.	BATHROOM CHOKED.	open	2024-08-08 11:18:14.405+00	\N	\N
25278f40-ba8c-45a3-9fbe-e51310356fd9	61206	B-310	External sanitary pipe from toilet broken.	open	2024-08-08 11:18:47.5+00	\N	\N
de64aac5-055e-4c7b-bc87-c7ccef1f13d4	61213	B271, NEAR DAV SCHOOL	kitchen/ Bathroom is clogged, water is not going	open	2024-08-08 11:19:47.893+00	\N	\N
23d93e93-c427-40e5-b101-91d4beacb9e0	61214	H1-153	Comode required	open	2024-08-08 11:20:29.35+00	\N	\N
398ab280-c943-477d-99ab-d3b36d25734c	61216	Qtr. no. B296, back side of DAV school	bathroom outlets blocked	open	2024-08-08 11:25:20.221+00	\N	\N
e29443c5-284b-400f-9928-9b09ef2f388d	61218	Qtr. No.: A-136; Block No.: 7; GURUKUL COMPLEX	Please check the leakage in the outlet pipe of the bathroom.	open	2024-08-08 11:26:36.581+00	\N	\N
ebe148da-01ee-4561-92ee-d4f80845ede2	61227	CRDIST OFFICE ( RDC)	Commod broken need new commod (EWC) & Four no of urinal cap &pipe change	open	2024-08-08 11:27:23.685+00	\N	\N
7e4c42fb-882d-4de2-b544-1819d98f1d29	61229	1BR-95	\tWaste water of kitchen overflowing due to choked drain	open	2024-08-08 11:28:12.141+00	\N	\N
187e2dd5-bc68-4b71-ba58-87477c5abf19	61232	Near DVC Gate IIT Kharagpur, G-112 Quarter	Toilet pan is broken. My contact number is 9641837897.	open	2024-08-08 11:29:06.867+00	\N	\N
15bb4cfd-daef-4444-9bcd-a6653447827a	61233	Toilet No: T-13, (G/floor)J C Bose Lab Complex	\tUrinal pan to be fixed properly(1no)	open	2024-08-08 11:29:46.892+00	\N	\N
ea5edf60-81c1-44c7-b888-7008ec189d9d	61236	Toilet No: T-17,2nd/Floor J C Bose Lab Complex	Due to stagnation of waste water from urinal pan, proper alignment required for waste pipe line.	open	2024-08-08 11:30:59.181+00	\N	\N
7a0f844f-cda2-46ae-88e6-046f271a38f3	61240	BRAmbedker Hall-LAV-D-41	urinal external outlet pipe is damage .treat as very urgent	open	2024-08-08 11:31:38.957+00	\N	\N
f605e6ca-4fac-4b31-bc8d-042f4a19cc11	61242	1BR33 	eakege of water from my bath room commode conector sistern	open	2024-08-08 11:32:45.228+00	\N	\N
64c6eccb-8e1a-4cb0-9cc6-bd882c0f946c	61243	New building ground floor rock mechanics lab, Mining Engineering	Urinal system of toilet leakage right side	open	2024-08-08 11:33:26.676+00	\N	\N
29ebc04a-5e87-4354-a694-c38afe7de49a	61248B-231, 	B-231, Kaju Bagan, Chitrakoot Parisar, IIT Kgp	Drainage outlet pipes in bathroom, kitchen and dining area need replacement. Pl call and come.	open	2024-08-08 11:34:35.849+00	\N	\N
aa98dbb5-1a37-428d-b572-83d060a70070	61257	Civil Engg. Department	Latrine chocked in Gents toilet (1st Floor). Pl. visit and repair it urgently.	open	2024-08-08 11:35:19.508+00	\N	\N
d5df8ebc-a507-4c7d-a707-c91edb302809	61259	Centre for Theoretical Studies	Water jam in draining pipe of the basin	open	2024-08-08 11:36:20.244+00	\N	\N
9980b772-0b6b-4c21-bba4-25d6656d5fff	61261	1F-02, Female Wash Room, VGSoM	upper part of the comot is broken	open	2024-08-08 11:36:58.3+00	\N	\N
0fe792ac-7297-4873-b17f-d1e782c34416	61264	HK-W-322 MOB NO 8800637202	vertical pipe leakage ,urgent.	open	2024-08-08 11:37:35.371+00	\N	\N
e9a98f96-a16f-444e-82d3-493ff054dbcc	61265	A3 bungalow	\tto replace commode	open	2024-08-08 11:38:16.211+00	\N	\N
c11b6ee5-7b7b-490d-9ed3-e2d125e1e913	61266	A 159	\tSink Drainage pipe is blocked	open	2024-08-08 11:38:57.796+00	\N	\N
37d25bc3-f819-4102-b53a-eaceb59b68f2	61267	A 106, Gurukul Complex	\tKitchen sink outlet is choked	open	2024-08-08 11:39:30.691+00	\N	\N
581f5113-d15c-4507-ba50-a119e79b341a	61268	B-310	\tExternal sanitary pipe from toilet broken. URGENT. Meet security.	open	2024-08-08 11:40:05.155+00	\N	\N
f044773e-b642-4107-b2a4-53bf6b3a83fb	61273	VSRC FAMILY QUARTER NC-303	LEAKAGE OF COMMODE PIPE,AFTER COMING BACK FROM WEEKEND HOLIDAYS THEN WATER FROM BASIN IS FUSTY	open	2024-08-08 11:41:09.339+00	\N	\N
6924d55e-fe42-46b9-97f1-b7ce76b6475b	61277	A-76	\tCorridor bathroom outlet drain net coming out, using putty is not working. Pls repair asap.	open	2024-08-08 11:41:43.363+00	\N	\N
bb9a23ac-caf3-4cf1-aa08-2438669554b5	61281	2BRF-7, near prembazae gate	Water is leaking through commode pipe	open	2024-08-08 11:42:27.051+00	\N	\N
c7ca3ea1-91c3-44ef-b6c5-b744418f0494	61282	C-165, G+5 building, 5th floor, near tech market	The drain of one bathroom is totally jam suddenly.Water is not passing at all.Pl take immediate step	open	2024-08-08 11:43:40.514+00	\N	\N
73f65c1b-37a1-48c6-960d-c7d681b43899	61283	RLB Hall, C- Block 1st floor bathroom toilet.	Commode seat cover is broken.	open	2024-08-08 11:44:25.723+00	\N	\N
e370f6ff-e998-4844-a0a5-0723216449b3	61284	I C ENGINE LAB MECHANICAL ENGINEERING DEPARTMENT	Replacement of damaged and old toilet pans.	open	2024-08-08 11:45:01.323+00	\N	\N
30934b73-ac4b-415e-8d42-b6faed4029a6	61286	High pressure building	\tIn High pressure building, both toilets in ground floor and first floor are leaking needs cleaning	open	2024-08-08 11:45:48.826+00	\N	\N
395dbba7-24fb-4c52-8cab-2505dfe89b02	61288	BRAmbedker Hall-MESS 1st floor bathroom	urinal external outlet pipe is damage .treat as very urgent	open	2024-08-08 11:46:35.938+00	\N	\N
5649ab0c-fdfd-4fc9-954d-9060194e98a3	61296	B 195 Near Dreamland	2 kitchen waist pipes and 2 bathroom pipes requires cleaning. There are water blockage	open	2024-08-08 11:47:11.051+00	\N	\N
b205b772-1755-4137-8b49-4b9e18c7a6cc	61300	H1-21	Drain Clogging Again. Please put net/mesh at the enrty points H1-21	open	2024-08-08 11:47:51.65+00	\N	\N
de21e3cd-7263-4c41-a576-c2cd47c7774f	61302	C1-110	Ref compl. no. 61074 on 10.06. Status: job allotted to contractor, nobody came. Call 8420489453	open	2024-08-08 11:48:33.09+00	\N	\N
e0b0838b-2c63-409b-9372-83776b8e8314	61305	A-66, Kaju Bagan, Chitrakoot Parisar	Please clear all the outlet drains of toilets and kitchen which are getting chocked frequently.	open	2024-08-08 11:49:25.979+00	\N	\N
90b987f0-244d-41e0-89bf-424fdea3f059	61311	A 165 (G+7)	\tDrain pipe in kitchen has to be replaced	open	2024-08-08 11:50:02.003+00	\N	\N
8fd39afc-dc25-4852-9ecf-4e913ee08b5c	61317	Nalanda complex north side 2nd floor ladies barrier	waiste line blocked	open	2024-08-08 11:50:38.586+00	\N	\N
e851fe4e-ba99-420f-bf30-d6328af3903b	61319	Patel Hall B Bl. 1st fl. Backside.	\tUrinal door bend Pipe broken. Pl. do the needful.	open	2024-08-08 11:51:28.45+00	\N	\N
b4cc07e0-5286-4e22-b4d0-aa32421d25ad	61320	PDF Block, 7th Floor, Room no:-808 (Mobile - 8768248200)	Water leakage from the Kitchen and Bathroom basin waste pipe	open	2024-08-08 11:52:27.034+00	\N	\N
9a393c8f-a7fc-40e7-96ea-77b091e0515f	61329	\tLBS/LAV/A/42	\t3 nos of Urinal outlet pipe need to change (urgent)	open	2024-08-08 11:53:25.482+00	\N	\N
d731a2cd-3292-4954-a390-131cfb6ad623	61335	MS hall-sw-1st fl bathroom	\tURINAL PIPE TO BE REPLACED,BATHROOM CHOCKED,	open	2024-08-08 11:54:18.85+00	\N	\N
ee37ec29-cd7b-4d3e-80a9-53d7e991f985	61336	MS hall-E1-2ND FL	urinal pot chocked	open	2024-08-08 11:54:54.522+00	\N	\N
f979cd62-bd55-448c-9ecc-6a24eb14c3e1	61302	C1-110	Ref compl. no. 61074 on 10.06. Status: job allotted to contractor, nobody came. Call 8420489453	open	2024-08-08 11:56:02.242+00	\N	\N
d37e34a8-9fb5-4fbd-9bee-c72b3de3a12d	LATTER	V.S.Hall A,B,C block	urinal pipe change	open	2024-08-08 11:58:11.218+00	\N	\N
996be4b5-6256-4dd1-b985-b5ac32a9d485	Latter	2BR-74	Gratting	open	2024-08-08 11:59:02.921+00	\N	\N
416588d5-9512-44b4-abbb-9228af918cd7	61333	NFA 53	\tcentipedes are coming daily through wash room drain hole. It needs through cleaning.	open	2024-08-08 12:00:04.593+00	\N	\N
7e1615ab-96d0-424d-82ee-02ff2fb705f6	61346	HJB HALL BLOCK 1,2,3	\tINSTALLATIONOF 4 NOS S TRAP ANGLO INDIAN COMMODE	open	2024-08-08 12:00:50.889+00	\N	\N
a8cf5865-b8c5-4fdf-b017-7a6da510e47f	61350	1BR33	\tBlockage of bathroom &kitchen outlet-pipe waste water is overflowing	open	2024-08-08 12:01:26.281+00	\N	\N
4bbf81dc-1454-4eb8-b687-81878eb7daa3	61349	VSRC-2 Gents Block	Commodes and Basins are moving at Floor- Ground & 7th floor	open	2024-08-08 12:01:57.449+00	\N	\N
5acd0a38-3b21-45a6-80ab-6017f94ac1c9	61351	B 285	URGENT: Cistern leaking. Please replace immediately.	open	2024-08-08 12:02:31.393+00	\N	\N
e1856692-30da-427b-9b26-d55462c9ba97	Latter	H1-156	Commode change	open	2024-08-08 12:04:08.233+00	\N	\N
64741c45-b777-4d86-9bec-0b267164754e	Latter	2BR-90	C.I. pipe leaking	open	2024-08-08 12:06:35.217+00	\N	\N
284e1985-0b60-461f-9ffe-d8f71f620312	Latter	EMG-14	Pan to commode change	open	2024-08-08 12:07:47.297+00	\N	\N
d0f7a4f1-648e-4c9f-beb2-ce8d21f1df70	61374	B-131	\tWater coming from bathroom to dinning area	open	2024-08-08 12:08:30.04+00	\N	\N
c2c580c5-09e2-41b3-9a5c-b7ac5ac1e219	61382	2BR-07	\tDrain guard net is damage please fix properly new one	open	2024-08-08 12:09:14.16+00	\N	\N
10cb713f-2a68-4542-98e3-88cb2863a37b	61380	C1-110	\tRef to complaint no. 61302. Shift the outlet to the corner of bathroom.	open	2024-08-08 12:10:01.327+00	\N	\N
63b0aa56-2f2c-47d4-8881-9650adda64c4	61378	HMC Officce	Leakage of water from toilet commode in HMC Office	open	2024-08-08 12:10:42.264+00	\N	\N
dc76cfb5-9ccd-4c1d-b0e7-f4d5f74b159f	61395	Sister Nivedita Hall.d-top bathroom	\tout let pipe chocked,urgent	open	2024-08-08 12:11:24.64+00	\N	\N
ee65c4f1-6660-499a-a5af-ea9d25f5677f	61400	\tSNVH - C- 2nd floor	\tblocked in wash basin in kitchen area .	open	2024-08-08 12:12:02.992+00	\N	\N
5dbeee4e-fd8f-4ad0-8069-8012dd0d428b	61396	MSA2-1	There is a water leakage in the toilet commode.	open	2024-08-08 12:12:35.904+00	\N	\N
8b9d202c-a46b-4881-b087-c1b84687fa10	61402	RP Hall, E-block 1st floor east bathroom	1 pan cover broken	open	2024-08-08 12:13:12.124+00	\N	\N
45d6b4ee-3194-46dd-bc3a-506f88ef818c	61403	RP Hall, E-block 1st floor west bathroom	2 pan cover are broken	open	2024-08-08 12:14:50.424+00	\N	\N
7a3858a1-86ac-47ce-9174-f63920f87cae	61404	RP Hall, E- Block top floor east bathroom	all urinal outlet leakage	open	2024-08-08 12:15:20.96+00	\N	\N
fbd2bf99-e130-49c0-a2b5-4b738a1aed43	61405	RP Hall, E- Block top floor west bathroom	\tall urinal outlet leakage	open	2024-08-08 12:15:49.623+00	\N	\N
2322973c-2e14-45e2-9d82-cbf0c3f1ac68	61406	RR 101 NEAR LIFT	INDIAN PAN BROKEN ,URGENT	open	2024-08-08 12:17:12.215+00	\N	\N
a484a433-65ba-47ff-b8eb-ea9e1719c3c9	Latter	V.S.Hall  A,B,C block	Urinal pipe leaking	open	2024-08-08 12:19:32.679+00	\N	\N
9843e1aa-a203-4647-9d61-ac701b3ec83b	Latter	STEP Office	Commode change	open	2024-08-08 12:20:28.071+00	\N	\N
78b7722b-96c4-4d05-b97e-49e7b7af6f86	61408	\tBF2/16	My quarter BF2/16 has got a severe damp from a leaking pipe outside. My no. is 974889918	open	2024-08-09 04:21:13.84+00	\N	\N
e18fba82-74b0-4659-aa41-407c1cf7ebb2	61409	VSRC-2 Gents Block	Bathooms outlet getting was damaged at 2nd floor west wing bathroom - 4 nos	open	2024-08-09 04:21:48.094+00	\N	\N
6ffe06ab-f3cb-4288-b3b8-e8e494cc751d	61411	B 237	\tKitchen sink pipe blocked	open	2024-08-09 04:22:21.902+00	\N	\N
3852bb38-e286-4d6e-94e9-f15909cbd69f	61414	Ladies Toilet, Math. Dept.	Water has accumulated in chathal.	open	2024-08-09 04:23:13.272+00	\N	\N
ba44074a-7cf9-4659-8763-00a966105550	61420	B298 opposite DAV school IIT Kharagpur	Kitchen outlet pipe overflowing	open	2024-08-09 04:23:59.023+00	\N	\N
bd5d7602-f6e5-4e13-b32b-21989f223632	61421	C1-174	Arttached bathroom waste water pipe chocked, please take necessary action from external pipe line.	open	2024-08-09 04:24:45.919+00	\N	\N
ea49f609-f0f1-4d73-950d-a3dfc2e6b8cf	61425	Alumni Guest House (A-12)	Seat cover broken (Urgent)	open	2024-08-09 04:25:17.647+00	\N	\N
a80978ac-5c30-4b5e-9c0b-080f62f7e460	61428	2BR-99, near gas godown.9779623856	\tkitchen sink blocking	open	2024-08-09 04:25:48.927+00	\N	\N
30f2623a-3cb9-4fd4-aa0a-2c32a4266466	61432	C1-145	Install lid over drainage hole. It is broken. Leaves choking drain water.	open	2024-08-09 04:26:55.871+00	\N	\N
bdc111ee-8679-4c37-84dd-aed2c4e81d39	61433	MS hall-E3- 1st fl bathroom	Bathroom outlet chocked- urgent please	open	2024-08-09 04:27:28.583+00	\N	\N
dca99d89-de5f-4b5e-940b-780948e9eb34	Latter	B-174	Seat cover	open	2024-08-09 04:28:02.199+00	\N	\N
3cc11289-dafc-4e17-a7e3-76aac585d37e	Latter	2BR-90	pipe leaking	open	2024-08-09 04:28:49.871+00	\N	\N
651d55ab-5368-453a-82a6-a4008f954bf3	61435	B-131	Water leakage from the walls	open	2024-08-09 04:30:13.614+00	\N	\N
d91b330e-c2b4-424b-8e8b-563196507771	61436	B 279	Kitchen wash basin drainage choked.	open	2024-08-09 04:30:44.167+00	\N	\N
84d18909-b78d-45c9-b968-00c7849bcf02	61437	LBS/LAV/B/12	BATHROOM CHOCKED	open	2024-08-09 04:31:12.199+00	\N	\N
fca02199-4e7d-4908-a99b-1b0df81855d7	61441	Washbasin near C-102	Drain chocked plz attend urgent	open	2024-08-09 04:32:06.231+00	\N	\N
998ed901-2cbe-4534-98ff-d3377352404e	61442	Nalanda complex north side T 19	urinal waiste leakage	open	2024-08-09 04:32:37.67+00	\N	\N
35ff0623-793c-49da-99dc-050e0ca25226	61442	Nalanda complex north side T 19	urinal waiste leakage	open	2024-08-09 04:34:30.399+00	\N	\N
b4778f07-85e8-4718-a760-49b6561994a5	61445	H1-56	commode change	open	2024-08-09 04:35:01.15+00	\N	\N
d5ea7e88-7246-42ba-9549-a9b8816b982c	61446	HJB hall 1 and 4	commode change	open	2024-08-09 04:35:28.558+00	\N	\N
bd6eeb15-0c11-47d5-9599-beca737d055d	61449	A 7	\tChange the toilet seat cover, put a sieve in outhouse toilet. Last they changed in another toilet.	open	2024-08-09 04:35:57.58+00	\N	\N
aba69ce5-ad58-496c-aab3-54443d473157	61450	Qrts. No. 2BR-1, IIT Campus	\tOutlet pipe cover is to be fixed.	open	2024-08-09 04:36:30.542+00	\N	\N
c7117690-a0c8-4b95-bca9-081985abd4ce	58848	SAM HALL #136	commode water leaking	closed	2024-08-09 04:36:05.898+00	2024-08-09 04:37:12.666+00	work done
ffaf7d24-45ff-40e8-82ea-453bbf127b81	61451	NFA-24, Near Tata Sports Complex	\tKitchen basin chocked.	open	2024-08-09 04:37:34.317+00	\N	\N
4b0c6f75-64ae-43c1-ba32-f1240496fe95	61454	55G-G53	\tJALI TO BE FIXED INSIDE OUTLET DRAIN	open	2024-08-09 04:39:24.013+00	\N	\N
47dbf82a-4c60-4e1c-83ff-81464da9ea80	61455	\tLBS/LAV/B/12	Indian latrine pan ovefloing	open	2024-08-09 04:39:55.997+00	\N	\N
e8f21d48-4f2d-41c7-9525-26443ba1c20c	58847	IGH Hall 3rd floor back side	Drine pipe choked	closed	2024-08-09 04:40:14.721+00	2024-08-09 04:40:30.528+00	\twork done
5141418d-271d-48e2-936a-0dee8aa06833	61456	H1-48	\tNet needed in drainage	open	2024-08-09 04:40:45.853+00	\N	\N
41571818-1fb7-48a9-8da1-4354a18eeadb	61457	SDS-508 MOB NO 8734824889.	\tCOMMODE SEAT IS BROKEN.	open	2024-08-09 04:41:13.141+00	\N	\N
d2fb609a-a52b-44d9-8534-eab3ef18a59b	58846	IGH Hall 3rd floor back side	Drine choked	closed	2024-08-09 04:41:01.442+00	2024-08-09 04:41:30.273+00	\twork done
e7c39c86-2aa3-4640-8659-d471a6f73966	61458	2BR 73	\tWater not draining out of the wash basin	open	2024-08-09 04:41:42.094+00	\N	\N
52652e09-5954-46c1-91d0-9f04c0ca8f16	58850	Patel Hall B bl. backside of Bathroom.	\tOutlet pipe broken and water leaking from it	closed	2024-08-09 04:42:09.802+00	2024-08-09 04:42:23.017+00	\twork done
24d58a57-ef2e-4f1b-9a2e-efa9b0a7d254	61459	2BR - 88 Near Gas Godown	\tWash basin in the main bathroom is broken and WC is not fitted properly, need replacement	open	2024-08-09 04:42:44.733+00	\N	\N
733b7725-c0bd-4e9b-91a3-07b6d7deba43	58849	SAM HALL #142	\tcommode water leaking	closed	2024-08-09 04:42:52.825+00	2024-08-09 04:43:06.313+00	\twork done
79ffc51f-07f0-418d-9687-b1fed271da62	61463	RR Ground floor common bathroom.near room no RR 103	pan broken.	open	2024-08-09 04:43:22.197+00	\N	\N
17c8a9e7-3679-4adb-864d-960d55f611a2	58854	Alumni Guest House (A-2,3,7,8)	\tDrain choked	closed	2024-08-09 04:44:01.177+00	2024-08-09 04:44:20.016+00	work done
f2c2a04d-da23-4b89-9e1b-11c50717bddc	58852	C1-142	commode pipe leakage	closed	2024-08-09 04:45:10.201+00	2024-08-09 04:45:28.952+00	\twork done
e5772cc1-7557-4d2a-aaed-2a720fb8d4c8	61464	B-294	\tdrain block	open	2024-08-09 04:46:07.574+00	\N	\N
def97931-6f90-448e-a5d6-126af14a0ad4	58889	A81	\tBathroom pipeline choked.	closed	2024-08-09 05:03:30.463+00	2024-08-09 05:05:12.303+00	\twork done
4751e3f7-7df4-41ad-900b-9b6bc9958326	61481	ARP HOD Office Washroom	Water leakage in HOD chambers washroom.	open	2024-08-09 05:05:23.835+00	\N	\N
cce7c3c7-a9f1-4025-bdda-44fe8cdc3048	61430	MSA-2/2	\tBasin and toilet of my bathroom is in bad condition please replace it with new one. 8793206026	open	2024-08-09 04:47:22.845+00	\N	\N
3ec64b92-28d1-4445-b712-26e4651e519e	58858	A-49 - Oriental bldgs	Leak in sink in main bathroom	closed	2024-08-09 04:45:56.783+00	2024-08-09 04:47:38.102+00	\twork done
88639187-eb73-4992-b716-235965e11ad3	61467	A 115 Block 5	\tBathroom outlet drain clogged. Please check urgently.	open	2024-08-09 04:47:55.325+00	\N	\N
c1779a45-8357-4cd8-8852-c4d53c2933c2	61469	Qtr. No. C1-189	Seat Cover broken Anglo Indian WC, to be replaced.	open	2024-08-09 04:48:22.044+00	\N	\N
1a0902c3-cc3a-4d45-a890-d099924ea974	58863	HK-S-410	\tbathroom choked	closed	2024-08-09 04:46:48.719+00	2024-08-09 04:48:26.799+00	work done
2c269dff-175a-4180-ad54-66c3f5e76a14	61472	Sister Nivedita Hall. c-top	out let pipe chocked,urgent	open	2024-08-09 04:48:51.108+00	\N	\N
07b5ed16-692f-4efb-8cb0-642491dbc011	61475	IGH Hall room no B-305	\tComode choked Urgent	open	2024-08-09 04:49:18.613+00	\N	\N
61b8d0b4-487c-4d0d-a83a-8d0718efd211	58865	MS hall-W2- gr fl bathroom to 2nd fl	BATHROOM CHOCKED	closed	2024-08-09 04:49:08.206+00	2024-08-09 04:49:21.903+00	work done
d1818641-4908-4980-9ebf-5504f1547831	61479	B 279	Kitchen sink drainage backflowing more after repairing	open	2024-08-09 04:49:58.972+00	\N	\N
8cdaabd5-2905-474e-b058-2104238b8397	58869	MS hall-	2nd fl urinal pot waste pipe replace it	closed	2024-08-09 04:50:29.038+00	2024-08-09 04:50:40.485+00	work done
63c36f70-6ae4-444c-96be-dd98740eac4e	58866	MS hall-E3-1st fl bathroom	\turinal pipe and bathroom chocked	closed	2024-08-09 04:51:14.774+00	2024-08-09 04:51:27.733+00	\twork done
725ec053-a115-42b3-8208-0d05510d9261	58868	MS hall-E1-GR 	urinal pot chocked	closed	2024-08-09 04:52:22.149+00	2024-08-09 04:52:44.277+00	\twork done
99b66d5d-22ce-4eee-a61e-de46eb4a782b	58867	\tMS hall-E3-2nd fl	\tcommode sheet cover to be replaced	closed	2024-08-09 04:54:17.349+00	2024-08-09 04:54:30.74+00	work done
4702eb3a-1921-48a9-b736-7380bd7b302c	58871	MS hall-AW- 1st and 2nd fl	\tURINE PIPE TO BE REPLACED	closed	2024-08-09 04:57:48.883+00	2024-08-09 04:58:03.603+00	work done
152e3780-d1f5-4d3e-94b2-fd331cc1bf93	58870	MS hall-SW gr fl bathroom	\tURINAL PIPE TO BE REPLACED	closed	2024-08-09 04:58:45.267+00	2024-08-09 04:58:58.154+00	\twork done
6fb8e7cf-27e4-4db9-bd35-3400cb70138d	58874	LBS/LAV/DD/22	URINAL PVC PIPE, SOCKET BROKEN. MAIN HOLE JAM.	closed	2024-08-09 04:59:29.345+00	2024-08-09 04:59:40.521+00	\twork done
a6daf11e-4c18-4afb-a5b5-5fb4c45ed8ff	58885	\tSN/IG E block Top floor bathroom	\tDrain Chocked Badly.Please treat as urgent.This complaint was lodged earlier	closed	2024-08-09 05:00:34.296+00	2024-08-09 05:00:48.234+00	\twork done
ddb5d257-492a-4563-9fec-b425515d4c6d	58886	C1-183, Near KV and gas godown gate	\tKitchen sink is leaking water due to blockage.	closed	2024-08-09 05:01:20.553+00	2024-08-09 05:01:35.153+00	\twork done
f6b2f8f2-3b62-46b2-83ff-084e03dde797	61477	\tQTR. NO: 2BR-02	Waste water from waste pipe of top floor is falling on my kitchen window.	open	2024-08-09 05:02:26.451+00	\N	\N
818629a4-4202-4ef0-8389-a3ead5f29377	58888	LLR HALL B-1ST FLOOR AND 2ND FLOOR MID LAV	COMMOD IS CHOCKED	closed	2024-08-09 05:02:26.528+00	2024-08-09 05:02:37.536+00	\twork done
13ec8f4f-4aa7-4b94-9db9-a90ebb63d67e	61482	Toilet No: T-32 (G) F/Floor, Geology & Geophysics Deptt.	Waste water not passing from Urinal Pan (1no)	open	2024-08-09 05:03:00.963+00	\N	\N
da918804-417f-488d-91b7-bc193a834bc2	61485	B 256, beside Staff Club.	\tWC seat broken. To be replaced by new seat of appropriate size.	open	2024-08-09 05:03:32.467+00	\N	\N
8dc386d2-38f1-475d-b08f-558949044dc1	61490	2BR - 88 Near Gas Godown	Water choke in kitchen, bathroom and balcony. All drainage pipes are blocked. Need Urgent attentio	open	2024-08-09 05:04:29.362+00	\N	\N
c242642e-fb79-42fd-a155-1072f0c779c4	61443	Nalanda complex north side 1st floor ladies barrier	one commode blocked repair/replace	open	2024-08-09 05:06:45.675+00	\N	\N
e10c3626-5a21-4549-a791-7173fd31300f	58911	Thermodynamics combustion lab,,mechanical engg. dept	\tUrine vase has broken,,,urgent	closed	2024-08-09 05:06:34.109+00	2024-08-09 05:06:46.925+00	\twork done
1a8ee3da-cac3-45a3-a24b-d78b9377e860	61463	RR Ground floor common bathroom.near room no RR 103	\tpan broken.	open	2024-08-09 05:07:35.314+00	\N	\N
7292d038-4372-437d-8d2b-59316103b847	61491	VSRC FAMILY QUARTER NC-303	\tBATHROOM FLOOR WATER NOT DRAINING AS TIME	open	2024-08-09 05:08:21.843+00	\N	\N
cf789e31-e815-414b-9953-11e468920fa8	58893	1 BR-52 NEAR SAHARA RESTRURANT	BASIN DRAINAGE PIPE BLOCKAGE AND BROKEN	closed	2024-08-09 05:08:07.495+00	2024-08-09 05:08:21.71+00	\twork done
dfd64e5b-34e0-40aa-bcbd-c66d0fb0bea7	58908	\tLBS/LAV/B/13	Urinal outlet PVC pipe jam, serious problem.	closed	2024-08-09 05:07:31.662+00	2024-08-09 05:08:27.47+00	\twork done
90ebc6cd-225f-44b2-ba32-af308d93951b	61494	2BR - 88 Near Gas Godown	\tWestern Comode in one bathroom needs to be changed as it is in very old and unhygienic condition	open	2024-08-09 05:08:49.365+00	\N	\N
fef7519b-4e25-4819-819c-36eab27fe2b6	58895	\tSAM HALL #113	Commode to replace.	open	2024-08-09 05:09:01.103+00	\N	\N
b8e228d6-fd73-4a80-b622-5348e4d7142b	61495	ISRO guest house F-06	\tpipe leaking	open	2024-08-09 05:10:04.777+00	\N	\N
8a6ae0a0-3b56-4b3a-9fa7-3eb72ecad56e	58897	\tLBS/LAV/D/11	\tLATRINE PAN JAM	closed	2024-08-09 05:09:30.541+00	2024-08-09 05:10:09.046+00	work done
1ea72ee0-ba0a-418c-83ae-084b80d96e2c	Latter	L.B.S.Hall All block	urinal pipe and seat cover fixing	open	2024-08-09 05:11:48.147+00	\N	\N
b124d738-23ca-46ab-974b-2767d6e83097	Latter	V.S.R.C - old -E-301	Kitchen drain jam	open	2024-08-09 05:13:01.986+00	\N	\N
41c544ef-7a3c-451f-9f72-b0290bd2cf30	61501	A -166	Choked drain in the bathrooms	open	2024-08-09 05:13:56.664+00	\N	\N
3d4377de-1193-4886-82cb-3aaaba629b91	61502	VSRC-1 NC-205	\tBATHROOM WATER NOT RELESDE PLS URGENT	open	2024-08-09 05:14:27.176+00	\N	\N
24cb274b-c832-432a-be3f-c631d9a2f68f	58899	\tSDS-217	bathroom choked	closed	2024-08-09 05:14:05.652+00	2024-08-09 05:14:29.835+00	work done
d2cb7629-e369-4511-873f-0a1a27c801dc	58914	Old guest house R-18	\tBathroom & Latrine chocked.Kindly do the needfull.	closed	2024-08-09 05:15:10.347+00	2024-08-09 05:15:45.553+00	work done
cf143646-6688-42fd-9d40-9a505d19c116	58919	B-257 Near DAV School	bathrooms and kitchen drain outlets overflow. Cleaning of drain too.	open	2024-08-09 05:16:20.571+00	\N	\N
912b9e37-dac6-4c5a-898e-933f3d034d16	61717	Transpotation Engg. Lab(Civil engg.dept) behind old building(Bref-Biotek lab)	Damaged urinal and basin outlet pipe need to be repaired/replaced	open	2024-08-09 06:17:46.008+00	\N	\N
e033f7a0-7d6c-4e8c-b025-9541ac36eb93	58920	B-257 Near DAV School	\tBalcony drain outlet choked.	closed	2024-08-09 05:16:51.601+00	2024-08-09 05:17:23.186+00	work done
876660b2-a2be-46bc-89c2-9ffb07f98517	58921	\tA-167, 7th Floor, G+7	\tUrgent replacement of Toilet Seat. Last one was of very poor quality, got cracked..	closed	2024-08-09 05:17:52.393+00	2024-08-09 05:18:07.058+00	\twork done
237ce1f1-0fad-4de3-8ff0-4c5b722819b6	61506	CoEAI(5th, 6th & 7th Floor, CRR builiding)	\tToilets(Gents & Ladies) are so dirty because it was not used for a long time. Kindly clean it.	open	2024-08-09 05:20:10.049+00	\N	\N
18d6c9a1-ba55-44b4-b486-4a1577c6ae93	61507	Azad Hall D-Ext. floor bathroom	\t01 commode need to be change and 01 urinal pot need to be fixe.	open	2024-08-09 05:20:35.104+00	\N	\N
b38a2628-8ff3-464d-940e-cd4aee9881f9	61508	Toilet No: T-08 & 09 (G/F & F/F), beside Raman Auditorium	Urinal Pan to be fixed properly(Total -3nos)	open	2024-08-09 05:21:12.624+00	\N	\N
aa6d0b89-7d28-407b-bb15-2798936e8031	61510	Ladies Toilet No.N-328 Math Dept	\tComodo and Hand flash both are not working. Please attend.	open	2024-08-09 05:22:08.793+00	\N	\N
371c5be1-b74e-437c-8e4e-e8f7f2841bf4	61513	Geology and Geophysics Department 1st Floor ladies toilet	Water leaking also water getting clogged please do the needful on urgent basis	open	2024-08-09 05:22:40.176+00	\N	\N
7dada5ce-46eb-4b1b-a1b7-e56af294b149	61517	DSK-N-528 MOB NO 7660989838.	COMMODE SEAT IS BROKEN.	open	2024-08-09 05:23:24.961+00	\N	\N
7de64332-1f10-44fe-8d0b-1b2a17bc4a50	61518	\t2BR-39	Water clogging in the kitchen (water exit pipe)	open	2024-08-09 05:23:57.952+00	\N	\N
bf945db8-c30d-49b1-a35b-532b68cacaff	61527	ECE TOILET BESIDE SENATE HALL	ONE SEAT COVER FOR EWC.	open	2024-08-09 05:24:53.753+00	\N	\N
e151ba8e-e681-4724-8d74-1f9e8417671c	61528	MECHANICAL ENGG DEPT	2 NOS URINAL WASTE PIPE CHANGE.	open	2024-08-09 05:25:33.241+00	\N	\N
d5994e5c-fbef-40bc-a8c1-3e19a91567fc	61529	RP HALL OF RESIDENCE	ONE URINAL POT AND ONE INDIAN PAN REQUIRED.	open	2024-08-09 05:26:22.824+00	\N	\N
f319eed4-6954-4436-870b-dbc234814200	61532	\tB 223, Oriental Complex, near Rabi Rakhal shop	Kitchen sink outlet chocked with water	open	2024-08-09 05:26:54.176+00	\N	\N
66ef526f-c098-4b9c-a3f3-3c16319881e3	Latter	R.K. Hall A-212	3 nos Commode change	open	2024-08-09 05:28:28.424+00	\N	\N
5110e3e0-ea02-4106-bbc5-42c1ea1daced	Latter	L,L,R  Hall A,A,B,C block	Bathroom outlet jam	open	2024-08-09 05:29:59.76+00	\N	\N
a02fbfcb-05bc-4e62-8c02-5523ad6c118b	61533	Main gate (Puri gate)	Urinal Plastic Pipe connected to urinal broken. To be replacedUrinal Plastic Pipe connected to urinal broken. To be replaced	open	2024-08-09 05:30:57.296+00	\N	\N
d34f1d20-b23d-416f-93f3-bd273c0d2401	61536	gokhale hall	c.001.003.comode.pipe.leakage.	open	2024-08-09 05:32:27.92+00	\N	\N
1c60a66f-6d20-48c1-b53b-53d5c8391365	61539	Nalanda complex toilet NO T 2	\turinal waiste line blocked	open	2024-08-09 05:35:37.151+00	\N	\N
f9f33db3-5fec-4540-aa51-14a156f8f746	61540	2BR - 88 Near Gas Godown	Water blockage in bathroom. Still not resolved inspite of multiple complaints.	open	2024-08-09 05:36:17.207+00	\N	\N
d04cbc09-0246-4b45-9e7a-3576b0ae5c33	61541	BRAmbedker Hall-LAV-A-41	06 nos urinals outlet pipe are damage .need to be process	open	2024-08-09 05:36:44.087+00	\N	\N
b11d6bc1-9694-4d80-9426-bc83b4afaf54	61545	VGSoM Office , Room No. E-B2	1. 02 Nos Urinal Pan pipe 2. 01 No Hand Dryer 3. 01 No. Hand Flush Pipe	open	2024-08-09 05:37:11.815+00	\N	\N
3f627294-603c-4e18-b6c0-4f27f48cb240	61548	LBS/LAV/C/11	MAIN OUT LET PIPE BROKEN	open	2024-08-09 05:37:36.495+00	\N	\N
5a47adef-e9ef-4100-9162-f04f04112a59	61549	LBS/LAV/C/34	\tURINAL MAIN OUTLET PIPE NEED TO CHANGE.	open	2024-08-09 05:38:18.303+00	\N	\N
777dd788-36fa-4531-93ba-930594a26ed2	61550	LBS/LAV/DD/11	Urinal outlet pipes are need to change	open	2024-08-09 05:38:46.047+00	\N	\N
a3187f49-3be5-4cbc-a2a5-59bb3b7c6131	61551	\tLBS/LAV/DD/12	\tUrinal outlet pipe need to change (urgent)	open	2024-08-09 05:39:24.99+00	\N	\N
e30eef71-a4b2-4515-884a-fcb5f4c513a4	61555	LBS/LAV/DD/32	URINAL OUTLET PIPE CHANGE	open	2024-08-09 05:40:07.134+00	\N	\N
49e71245-2494-4a26-92aa-d2921ed5e0dc	61553	LBS/LAV/DD/21	Urinal outlet pipe need to change (urgent)	open	2024-08-09 05:40:38.351+00	\N	\N
88996542-9ad1-4170-9805-841142f286d6	61554	LBS/LAV/DD/22	\tUrinal outlet pipe need to change (urgent)	open	2024-08-09 05:41:06.487+00	\N	\N
45c0d75e-be33-4090-935d-ead29fcee034	61557	j c bose ANNEXE Building TNO 17	one urinal waiste pipe replace	open	2024-08-09 05:41:42.799+00	\N	\N
323d9933-6c20-465c-b519-e06bbee96126	61451	NFA-24, Near Tata Sports Complex	Kitchen basin chocked.	open	2024-08-09 05:42:28.495+00	\N	\N
665acfb4-7bf0-4eb9-b692-2d22abafebaa	61492	VSRC FAMILY QUARTER NC-303	\tBATHROOM FLOOR WATER NOT DRAINING AS TIME,PLEASE CALL ME ON 9002909624 BEFORE COME FOR MAINTENANCE	open	2024-08-09 05:43:04.879+00	\N	\N
b2811be9-6a11-4818-86b5-6549e219f9bf	61376	NFA 53	\tinsects/centipedes issues from drain hole of washroom is still not resolved even after cleaning.	open	2024-08-09 05:43:56.143+00	\N	\N
fcdc9eea-d926-4430-bf5f-24f429e509f5	Latter	2BR-74	Gratting fixing	open	2024-08-09 05:44:44.382+00	\N	\N
5a3a046c-1201-4a9f-b408-041cd758ebf8	Latter	PDF-207	Gratting fixing	open	2024-08-09 05:45:25.982+00	\N	\N
bdd3bcd2-58e5-4ead-b84e-44f5ec07a382	Latter	VSRC-old-E-301,304	Kitchen line jam	open	2024-08-09 05:46:33.039+00	\N	\N
4a56ae84-e3b1-4da3-99bc-614effde1c6a	61535	VGSoM office Ground floor	\t02 Nos Commode are broken and leakage of basin pipe	open	2024-08-09 05:47:21.742+00	\N	\N
47b3b7c6-ff94-46d3-bff8-8367320a9dcd	61534	VGSoM Office 1st floor, 1F-2, Commode is broken	1F-2, Commode is broken	open	2024-08-09 05:47:57.757+00	\N	\N
3d4ee4c5-2009-4c73-98b4-a3da39c67cb0	61575	HI-125	Indian pan need to be change and commode fix needed.	open	2024-08-09 05:48:41.622+00	\N	\N
80d7bb11-acc7-453d-aac2-3e4c070fdc37	61577	B310	Urgent: External pipie leak in building, toilet water rushing probably from B304	open	2024-08-09 05:49:45.965+00	\N	\N
d273d610-ef59-4e33-97b9-35539dbe2dd8	61584	B298 opposite DAV school IIT Kharagpu	Kitchen outlet pipe overflowing	open	2024-08-09 05:50:22.078+00	\N	\N
5f669d45-66c3-4fc1-bf4c-58aa0fc0f846	61590	1 br 32	Water leakage from commode. need to repair.	open	2024-08-09 05:51:06.545+00	\N	\N
cb6ce501-1141-413f-8b4c-2ab2023eeeae	61591	A-71(kajubagan)	\tWater outlet of Bathroom is chocked.	open	2024-08-09 05:51:33.993+00	\N	\N
82b9bf96-0b0e-4dfd-b8e6-66c93ab6788f	61593	SN/IG Hall F Top Bathroom	Basin Drain Chocked.Please treat as urgent	open	2024-08-09 05:51:58.662+00	\N	\N
5e220b92-4e43-4c05-9138-65bec2f74830	61595	\tMETALLURGICAL & MATERIALS ENGINEERING DEPARTMENT	Bathroom Water Leakage from 2nd floor bathroom, Annex building	open	2024-08-09 05:52:27.998+00	\N	\N
b324976c-1324-446c-b770-fa601286cad5	61597	Dept. of HSS (2nd Floor, Gents Washroom)	\tLatrine is broken and leaking. After repairing the issue is not resolved.	open	2024-08-09 05:52:53.065+00	\N	\N
bd60def0-c70a-4286-8244-3289c9230e5b	61599	B - 131	\tWater leakage from bathroom to dinning hall. Second complain	open	2024-08-09 05:53:17.478+00	\N	\N
79a03f1b-093b-4dbd-8bb2-67fea35bb6db	61600	\tRR-203,RR-227,RR-421.	\tBATHROOM CHOKED.	open	2024-08-09 05:53:47.31+00	\N	\N
b99a026d-4701-49ac-a90e-1d672711275b	61603	1BR 90	\tBathroom sewer has been choked and water starts harvesting all over the bathroom. mob no. 896849787	open	2024-08-09 05:55:23.781+00	\N	\N
f15fd5ed-5ccf-4514-9cb6-ad4526702a6b	61624	Gate No. 2 Security Booth	\tToilet flash to commode pan is leaking heavily. Please attend.	open	2024-08-09 05:56:11.605+00	\N	\N
f8c4db8d-3cff-4a95-8436-56cd02c454db	61625	Nalanda complex north side 3rd floor gents barrier	\tone commode leakage repair/replace	open	2024-08-09 05:57:01.157+00	\N	\N
e25e9c63-638c-406e-a627-d2514b631514	61626	BRAmbedker Hall-LAV-A-51	urinal main drain pipe is chocked.treat as very urgent	open	2024-08-09 05:57:28.515+00	\N	\N
6532f00a-aa38-454f-ac98-b03694bafba3	61628	VSRC-2 Gents Block	\tDirty water leakage at our hall outside west wing corner.	open	2024-08-09 05:57:59.691+00	\N	\N
fb245a77-2f6e-4186-8340-af08f5d3e3da	61629	VSRC-2 Gents Block	Commode was damaged at 6th floor east wing bathroom 1 nos	open	2024-08-09 05:58:27.133+00	\N	\N
ceea3395-6c4d-4b33-8146-a4cabfb0c864	61632	HK-W-508 MOB NO 6295512074.	\tCOMMODE SEAT IS BROKEN.	open	2024-08-09 05:59:11.093+00	\N	\N
038ce8ff-72be-4dd0-9743-57387e130f36	61718	Technology Telecom Centre	Water leakage from Urinary.. Kindly attend	open	2024-08-09 06:18:25.203+00	\N	\N
2446ae5f-a7e7-4156-b947-679a9854c486	61719	LBS/LAV/A/21	urinal main outlet pipe jam	open	2024-08-09 06:18:51.69+00	\N	\N
fe2ac39c-5a30-4325-9952-41bfeb023f1b	61634	B - 70 quater	\t1st floor toilet seat broken	open	2024-08-09 05:59:46.997+00	\N	\N
026641ed-d7e3-4fb5-905b-590cda74ff46	61639	B-291, near DAV model school	Kitchen and toilet outlet blocked. Immediately clean it from outside	open	2024-08-09 06:00:18.197+00	\N	\N
19309a4a-5c69-40eb-a08d-8beb168da8ef	61652	Sister Nivedita Hall. toilet near OA-210	\tCommode outlet joint area leaking ,urgent	open	2024-08-09 06:00:49.956+00	\N	\N
3f6df321-0eb7-4393-89e3-1ceca9b2fb07	61653	Sister Nivedita Hall. D TOP FLOOR BATHROOM	\toutlet chocked,urgent	open	2024-08-09 06:01:18.06+00	\N	\N
b87041f6-cefd-4eb2-a7ec-297653b0128a	61658	Gents Toilet, First Floor, Dept of Civil Engineering	\tWater logging	open	2024-08-09 06:01:48.364+00	\N	\N
8d294a3c-737a-49a0-ba89-35001e7b3943	61669	BF-2/9 IIT Campus	\tWater leaking from commode exit pipe.	open	2024-08-09 06:02:16.156+00	\N	\N
9a31327b-2487-4048-8ae0-345016787b30	61673	B 202	\tKitchen drain pipe clogged, balcony pipe clogged	open	2024-08-09 06:02:49.909+00	\N	\N
f00e1ba8-07a0-4602-824e-3200c74dc5dc	61674	LBS hall Mess 1st floor	\t4 inch and 6 inch new pipe line	open	2024-08-09 06:03:16.325+00	\N	\N
5ae9ef3a-606f-4e14-a586-223d9a9b7d36	61657	Faculty Quarter A-153	\tSpray Nozzle of Commode leaking large water volume, to be replaced with new nozzle	open	2024-08-09 06:03:42.484+00	\N	\N
08abe8ed-7f89-49cd-87c0-0fcc8ebdac73	61679	Patel Hall C bl. backside.	\tDoor bend broken. Pl. do the needful.	open	2024-08-09 06:04:30.852+00	\N	\N
1c40d572-e64e-40ed-9b46-6c28963a33f7	61681	Alumni Guest House (A-1,5,6,12,14,15)	\tcommode seat cover Broken (URGENT)	open	2024-08-09 06:05:14.572+00	\N	\N
5725df76-ea93-4bc0-a425-cb847e31b2db	61683	\tGents Toilet of Mining Workshop, Mining Engg Deptt	\tNew connection of leakage outlet pipe line with Commode pan (1no) . Previous complain no - 60197	open	2024-08-09 06:05:40.604+00	\N	\N
5a588733-3343-4f03-b9e5-dff6d7bbafa4	61684	RK HALL B-BLOCK FIRST FLOOR WASH ROOM EAST SIDE	URINEL PIPE BROKEN & CHOCKED -NEED URGENT HELP.	open	2024-08-09 06:09:55.419+00	\N	\N
cd71a990-a0c2-49d3-ae91-c5310d4bc901	61685	gokhale hall	c.106.comode.sit.cover.broken.	open	2024-08-09 06:10:32.331+00	\N	\N
67e9b3e1-34b8-4065-bbc6-41e357c3fb52	61695	NQ-2	Water leakage from outside horizontal bathroom drainage pipe (due to this inside wall/paint damage	open	2024-08-09 06:11:19.339+00	\N	\N
5bf6e283-29b1-4454-b89b-65ff8cb0c744	61698	LBS/A/Ground floor in front of staircase	Sanitary pipe coming from 1st floor leaking.	open	2024-08-09 06:11:50.778+00	\N	\N
ed544930-72e2-472d-ae75-b8c97af78efa	61701	RR-547 KEY IN OFFICE.	COMMODE SEAT IS BROKEN.	open	2024-08-09 06:12:30.697+00	\N	\N
07da39b1-0298-424d-90a0-9d5a2b6c7867	61702	RR-551 KEY IN OFFICE.	COMMODE SEAT IS BROKEN.URGENT.	open	2024-08-09 06:13:02.651+00	\N	\N
9b06bb52-22e9-443b-a0a9-a9133c4064f3	61704	SNVH - C - 4th floor washing machine area	out let blocked .	open	2024-08-09 06:13:39.804+00	\N	\N
d0e8c501-8750-4118-8b4d-c4c6431d81d1	61706	FTA-09. Ph: 8285957243	Drainage issue in bathroom	open	2024-08-09 06:14:19.627+00	\N	\N
dff5cf5c-94f1-4594-b7a5-c49fcc1fb497	61708	CSE Deptt, Takshashila Building, 2nd Floor	6 Urinal exit pipes need to be changed in all 3 Gents toilet.	open	2024-08-09 06:15:00.226+00	\N	\N
ed198d9e-89b7-4833-ae3b-d021fe5d27f8	61709	mess backside in RLB Hall	outlet drain pipe need to be connected	open	2024-08-09 06:15:31.659+00	\N	\N
e45e1067-522b-4e9c-b450-9eedf42b096d	61711	b c roy hall , Lav S-32	Bathroom is choked	open	2024-08-09 06:16:09.435+00	\N	\N
749193ec-3d2c-47fb-a99e-0be60bd06e3e	61712	b c roy hall , Lav E 12	Bathroom is choked	open	2024-08-09 06:16:36.843+00	\N	\N
abbf7845-9fde-4f12-aa41-3db22a5b7618	61715	Computer & Informatics Centre, GENTS toilet	Toilet drain Jam	open	2024-08-09 06:17:10.488+00	\N	\N
e00133f3-f47c-494c-acd0-a8f1e479732b	61724	Azad Hall D-2nd floor toilet	01 commode cover required.	open	2024-08-09 06:19:29.195+00	\N	\N
92cac198-2ba7-4ea0-9eef-21faaa6da1e3	61725	gokhale hall	c.block.grd.floor.common.bathroom.comode.sit.cover.broken.	open	2024-08-09 06:20:03.691+00	\N	\N
768cc664-3c21-45c3-9e21-c32891f1c7b1	61726	LBS/LAV/C/53	urinal pot crack	open	2024-08-09 06:20:38.018+00	\N	\N
3a8e0221-a8c2-4d90-bbb2-c4299dc7a007	61727	LBS/LAV/CD/54	INDIAN PAN CRACK	open	2024-08-09 06:21:06.627+00	\N	\N
585c2b81-0bb6-416a-b3a6-eb34616fbbd1	61730	Azad Hall C-1st floor EAST bathroom	Urinal inlet pipe need to be change and 01 urinal tap needed.	open	2024-08-09 06:21:37.355+00	\N	\N
305dcca2-efc9-4a86-9382-dc7e356b519a	61731	MS hall-W1-	ALL LATRINE SHEET COVERS BROKEN	open	2024-08-09 06:22:09.65+00	\N	\N
7d5b7652-1ae1-4cfb-b78e-7929b9b294c3	61732	2BR-65	Drain need to clean	open	2024-08-09 06:22:39.554+00	\N	\N
4ef80046-02d5-4883-9eb6-7e29669278ee	61733	MS hall-E3-GR FL,1ST ,2ND FL	ALL BATHROOM CHOCKED AND COMMODE SHEET COVER TO BE REPLACED	open	2024-08-09 06:23:58.762+00	\N	\N
2e133337-17aa-4380-a007-ad68a1006b7c	61737	C block 107 Gokhale Hall	Water leakage from duck in 107 Gokhale hall	open	2024-08-09 06:24:45.626+00	\N	\N
a4702e61-87f8-4f0b-b8be-09bda943a1eb	61738	Qtr A-137, Block 7, Gurukul Complex, IIT Campus	Kindly clean the drain of the first bathroom as there is water logging.	open	2024-08-09 06:26:07.378+00	\N	\N
d7aae89c-f3bf-4874-9722-85a25fe37ec4	61742	B 248One drain sink , connected to garage toilet is leaking and making foul smell in the premises.	One drain sink , connected to garage toilet is leaking and making foul smell in the premises.	open	2024-08-09 06:27:43.369+00	\N	\N
ce7349b0-51e5-44cb-8aba-a66ee64f73e8	61744	B-264	kitchen drain pipe jam problem. Please check.	open	2024-08-09 06:28:29.625+00	\N	\N
e723a8a5-436a-41fa-8b2e-a65b88a70772	61745	Nehru hall, D/block top floor west, 1st floor and 2nd floor bathrooms.	Bathroom out-let drain chocked, please do the needful.	open	2024-08-09 06:29:25.066+00	\N	\N
0853cb9b-0b65-41f1-96c9-d50adc6cc0a0	61759	CoEAI(5th, 6th & 7th Floor, CRR builiding)	Toilet commodes(6 no.) are in dirty condition & not working properly. Kindly solve it ASAP.	open	2024-08-09 06:30:31.835+00	\N	\N
97e42e4e-284d-463c-84ab-058f83424656	61760	Gate no-02 (05)	commode pipe leaking	open	2024-08-09 06:31:20.338+00	\N	\N
40030132-eebf-4e1f-a5b4-d35319418a4f	61761	QUARTER NO. G-172, DANDKARNYA AREA, MOB NO. 9905918540, ALTERNATE NO. 03222282273 , please call on	Clean the riped jackfruit which have fallen near back door of the quarter.It is giving very off odor	open	2024-08-09 06:32:49.882+00	\N	\N
4df6f2cb-fd70-408a-a096-b3af5ded351b	61766	SNVH - D - TOP FLOOR BATHROOM	OUT LET PIPE JAM WATER NOT PASSING NOT USED THE 3 BATHROOM PLEASE URGENT .	open	2024-08-09 06:33:18.913+00	\N	\N
103d8f15-ea81-45a8-92c9-bc844be0e054	61767	MSA -2/11	commode change	open	2024-08-09 06:33:45.577+00	\N	\N
fe1c8301-b4bb-42bb-8a2e-1ead3540f17f	61768	VSRC-1-Room No-NA-206	Commode cover is broken need to be changed	open	2024-08-09 06:34:17.585+00	\N	\N
b5f6d30e-ded9-4f2e-843a-7d7fe6cc7e2a	61772	1BR-95	Waste water of kitchen overflowing due to choked drain	open	2024-08-09 06:35:05.849+00	\N	\N
fd425d59-c227-40ca-b6be-f4036bc75549	61774	Azad Hall E-3rd floor east side bathroom	01 commode seat needed	open	2024-08-09 06:36:22.257+00	\N	\N
0b25fb4f-cecb-4df8-bf2d-f74b35758f2c	61775	Azad Hall C-1st floor west bathroom	\tToilet seat cover needed	open	2024-08-09 06:36:46.76+00	\N	\N
1badc839-3db9-4d43-8f43-e0c280d2ddca	61784	gokhale hall	\tb.001.commeid.pipe.water.lickage.	open	2024-08-09 06:37:11.353+00	\N	\N
cba089e4-e89e-4c74-b251-bc98c9c64e6e	61785	MSA- 2/02	\tPlease replace the commode with new one. The closing flap is not proper.	open	2024-08-09 06:37:48.4+00	\N	\N
db6072a3-f086-404c-b41d-38924522c863	61786	SDS 314	\tCOMMODE PIP BROKEN.	open	2024-08-09 06:38:11.744+00	\N	\N
6679e0eb-9546-4526-b2a2-b3a55f9bb739	61788	A 48	\tChoking of wastepipe line in the kitchen	open	2024-08-09 06:38:41.6+00	\N	\N
554a7232-9b34-47ba-a2b8-deb448de7c4c	61789	WASH BASIN OUTLET PIPE.	\tSWERAGE PIPE CHOKED.	open	2024-08-09 06:39:21.44+00	\N	\N
a6301ae0-1649-4fbe-bef7-255520a3125d	61792	Oriental Complex, B/ 223	\tWater chocked in outside balcony	open	2024-08-09 06:39:51.952+00	\N	\N
5707e84a-be0c-4626-b891-ff0020757f79	61799	Qtr. No.: A-136; Block No.: 7; GURUKUL COMPLEX	URGENT - There is water looging & backflow in the first bathroom since Monday. Plz clean the drain.	open	2024-08-09 06:40:22.496+00	\N	\N
430499ab-754d-4aaa-8a2e-ed58336fd81b	61800	A-88 Gurukul complex 2nd block ground floor	Indian type common outside bathroom getting choked	open	2024-08-09 06:40:58.921+00	\N	\N
ea191e97-23d0-4f88-966d-9396ff71ed76				open	2024-08-09 06:41:01.848+00	\N	\N
2fd3e144-a9ff-4439-9cd2-693d4a41b435	61800	A-88 Gurukul complex 2nd block ground floor	\tIndian type common outside bathroom getting choked	open	2024-08-09 06:41:45.08+00	\N	\N
3a839416-7309-4bab-af71-95e145c46df1	61802	SN/IG Hall A-block ground floor and 1st floor bathroom	Badly chocked need to be clear the drain. (URGENT)	open	2024-08-09 06:42:30.456+00	\N	\N
5ff85784-925b-4be7-bb32-321d0bb6e0f4	61803	Azad Hall C-Gr. floor east and west bathroom	All urinal out let pipe need to be change.	open	2024-08-09 06:42:59.824+00	\N	\N
441bf642-5f6e-46fe-8507-822b7c0e2013	61808	A-97 (please call 8170834821 before coming)	bathroom drains need cleaning. Kindly attend.	open	2024-08-09 06:43:51.928+00	\N	\N
6b403932-eb8d-4b9b-b900-e87743b1e3d0	61810	LBS/LAV/C/33	commode seat broken	open	2024-08-09 06:44:25.519+00	\N	\N
575e5dda-4252-402a-bd8c-e444228bba0a	61811	1BR-75 back side of takemarket backside	bathroom is block	open	2024-08-09 06:45:00.535+00	\N	\N
25e019fe-1d27-481e-92d4-d04b3bc325f1	61801	JCB HALL A-BLOCK GROUND FLOOR LATRINE	TWO OF THE INDIAN PANS ARE BROKEN	open	2024-08-09 06:45:37.224+00	\N	\N
d7bc0f95-0639-4ec2-8ff3-ab8744241dbb	61802	SN/IG Hall A-block ground floor and 1st floor bathroom	Badly chocked need to be clear the drain. (URGENT)	open	2024-08-09 06:49:35.967+00	\N	\N
5c807977-d46c-434b-a69f-577ff7df9f61	61803	Azad Hall C-Gr. floor east and west bathroom	All urinal out let pipe need to be change.	open	2024-08-09 06:53:10.223+00	\N	\N
c4e6fd8f-5340-426b-a448-cfd08b331525	61810	LBS/LAV/C/33	commode seat broken	open	2024-08-09 06:54:06.551+00	\N	\N
e01eec0a-0835-4b4b-8ba7-5d9d04197803	61811	1BR-75 back side of takemarket backside	bathroom is block	open	2024-08-09 06:54:42.367+00	\N	\N
1bc931a3-5ebc-4bf2-b879-11bf8b25675c	61819	VSRC-2 GIRLS BLOCK -5th FLOOR BATHROOM	Drain chocked in the bathroom	open	2024-08-09 06:55:16.767+00	\N	\N
b69659a6-3253-4816-9cb8-631622b679fc	61826	C1-154	Toilet Seat Broken. Please do the needfull.	open	2024-08-09 06:55:43.894+00	\N	\N
de9887ec-a5b5-45f6-81e8-c2d9f1fc9c9c	61827	Visveswaraya Guest House	Commode lid and flush box to be replaced of warden bathroom	open	2024-08-09 06:56:11.046+00	\N	\N
71434478-2ee2-4396-ada1-53c04061e9d1	61828	Zakir Hussain hall	2/101 and 2/202: both the rooms commode cover are got damaged	open	2024-08-09 06:56:38.141+00	\N	\N
dc5d91b6-f7f4-4880-b76f-4aa06f8b4702	61829	B-131	Water coming from bathroom to dinning area	open	2024-08-09 06:57:09.486+00	\N	\N
718fba6d-773c-48f3-a666-feae75f31ea9	61830	B190	Comode seat is giving repeated problem, need urgent attention	open	2024-08-09 06:57:42.783+00	\N	\N
edd43bda-9db9-425a-a5c4-21127a099b19	61838	JCG-PCR 4th floor, A block	urinals in the washroom is leaking/drain chocked, repair/clean	open	2024-08-09 06:58:20.286+00	\N	\N
74f9cc60-9ca7-484b-aafd-67209cb95c99	58901	MS hall-MW-1ST FL	TWO PIPE BROKEN	closed	2024-08-09 06:58:07.016+00	2024-08-09 06:58:38.504+00	work done
14ca9859-1ca1-443b-beea-b26842ed3f40	58902	MS hall-MW 1ST AND 2ND FL-BATHROOM	URINAL PIPE TO BE REPLACED	closed	2024-08-09 06:59:12.144+00	2024-08-09 06:59:29.023+00	\twork done
984870cc-52ff-4df3-88e7-3d19c41d4336	61847	C1-153, Near CABLE lines, Dandakaranya	pipe is open outside and any insect/snakes can enter in our washroom. please close/repair	open	2024-08-09 06:59:42.773+00	\N	\N
83d79d40-05c4-43b8-9c91-cc2a314e3b35	LETTER	R.K .HALL . E,D,B	Bathroom chocked	open	2024-08-09 07:00:40.167+00	\N	\N
091f9a12-20d5-4e1a-8f11-cca518e5ffa8	61862	RR 427	COMMODE SEAT IS BROKEN.	open	2024-08-09 07:00:53.508+00	\N	\N
d7daea85-7070-4577-90e5-cceced441eff	61863	A 45 Oriental complex near Rabi Rakhal shop	The pipe fitted to washing machine outlet pipe is clogged	open	2024-08-09 07:01:27.484+00	\N	\N
0da71160-c214-44bf-b4c6-571572ba8ca3	61865	RR442	COMMODE SEAT IS BROKEN.	open	2024-08-09 07:01:56.15+00	\N	\N
d23875c8-f7ab-4b78-b324-ed8eee24bd4d	61866	JC Ghosh PC Roy building B block Toilet T 22	Commode choked	open	2024-08-09 07:02:55.878+00	\N	\N
601df690-2f94-44af-b767-74c5ea7343db	letter	A-166	COMMODE CHANGE	open	2024-08-09 07:07:23.282+00	\N	\N
1c1a5369-fbe0-4ef0-8937-aecb7cefdc1b	58950	VGSoM	Unisex 2 nos. toilet cover broken, basin outlet pine broken-ground floor	open	2024-08-09 07:08:06.284+00	\N	\N
2b6464c8-d2df-4494-8eef-9fe9bf93cfdd	58932	Patel Hall B bl. 2nd fl. Bathroom.	Outlet pipe near backside of bathroom is hanging, need to refix. Pl. do the needful	closed	2024-08-09 07:01:24.23+00	2024-08-09 07:01:55.989+00	work done
7c7236d6-5db3-422e-a911-8e74b91d0586	61864	RR 440	COMMODE SEAT IS BROKEN.	open	2024-08-09 07:02:31.518+00	\N	\N
b6130dbb-5118-4c5b-bd0b-d77ede307bb8	58931	B-261 (Near DAV School)	Toilet Seat Cover damaged and needs Change. (Parry vitreous make) job still unattended	closed	2024-08-09 07:02:30.036+00	2024-08-09 07:02:50.174+00	work done
ccd9bf48-178f-49f9-9ff9-20596e4fadea	61867	B-131	Water coming from bathroom to dinning area. Previous Compl No. 61599	open	2024-08-09 07:03:30.301+00	\N	\N
9a143ea3-0740-475e-b9d7-8ae936913a27	58936	PDF Building, Room No 211	\tWater lodging in sink and bathroom, toilet waste pipe may be broken from outside	closed	2024-08-09 07:03:15.989+00	2024-08-09 07:03:31.804+00	work done
67a970aa-495c-49b2-95ae-9be886bad669	61872	RR 126	COMMODE WATER LEAKAG .	open	2024-08-09 07:04:07.813+00	\N	\N
e1c6ff16-baf9-4a64-bc28-0dcbb29ce36f	58937	B -314	ONE GRATING REQUIRED. AND KITCHEN JAM.	closed	2024-08-09 07:04:01.22+00	2024-08-09 07:04:27.059+00	work done
9cc67719-de14-48de-a412-9f37bce6956e	61876	B179	Bathroom drainage blocked, perhaps from outside. Please fix.	open	2024-08-09 07:04:31.015+00	\N	\N
dd24388e-1936-4ecd-bd2e-43117aefb673	61878	RLB Hall, B-Block top floor bathroom toilet.	commode jam.	open	2024-08-09 07:05:08.222+00	\N	\N
ff813648-f364-44bd-81d3-1ea68ba87c82	58940	BF 3/13	4 inch net below the sink needs to be fixed as there are a lot of Rat related issues.	closed	2024-08-09 07:05:47.372+00	2024-08-09 07:06:01.357+00	\twork done
e0190c2a-4aa1-413b-b3e0-b0dc30dc09e2	58944	HK-S-120 	COMMODE CHOKED .URGENT.	closed	2024-08-09 07:06:35.459+00	2024-08-09 07:06:53.3+00	\twork done
951f2e13-2ed3-4e0b-b4b9-bf262a28820c	Latter	SPMS Hospital	commode changes	open	2024-08-09 10:27:14.015+00	\N	\N
ccad54b8-fcf8-4b31-a263-657e8b2d6249	Letter	G -112	Pan change	open	2024-08-09 10:27:59.973+00	\N	\N
4bb2e1f9-08c2-425e-bb00-e0f08fbf5fd1	61879	FTA-015, Near Ravi Rathal Shop	Vertical straight drainage system in washroom	open	2024-08-09 10:29:06.738+00	\N	\N
d241f2fa-6c59-444a-ae82-b0126da456da	61880	RLB hall, B&C block junction ground floor bathroom toilet.	Commode cover is broken.	open	2024-08-09 10:29:50.737+00	\N	\N
a53a1e54-3a85-4856-8428-48a6822d6a56	61882	Visveswaraya Guest House	VGH Counter bath room commode lid replace Urgent bessis	open	2024-08-09 10:30:25.049+00	\N	\N
5b51d2fe-bf00-421d-a31f-3431f7de48c4	61883	B-317	There is a jam in the bathroom. Water is not flowing outside. Please fix it.	open	2024-08-09 10:30:54.144+00	\N	\N
4a6eb48a-8b7d-4a09-872b-84e875954c5e	61884	B-288 (Near St Agnes/DAV Model School)	Kitchen outlet is blocked. Kindly fix it.	open	2024-08-09 10:31:47.384+00	\N	\N
2cf44dc1-a72a-46e2-a57f-aca4117d6255	61885	VS HALL A-201	BATHROOM CHOCKED	open	2024-08-09 10:32:21.705+00	\N	\N
2b6706ac-b8d1-4890-a8ec-ea7f8b62e67d	61886	snvh hall c block 3 floor	sink pipe jam	open	2024-08-09 10:32:51.401+00	\N	\N
f851dc38-4229-4c7a-a77b-a5eeb89063a1	61887	RR-454 STUDENT IN ROOM.	COMMODE SEAT IS BROKEN.URGENT.	open	2024-08-09 10:33:53.121+00	\N	\N
f82537fc-3ed1-4558-8926-f8ffdbc6396e	61888	2BR-092; NEAR BY GAS GODOWN GATE	Bathroom outlet pipe not working/ used water not passing. check.	open	2024-08-09 10:34:34.089+00	\N	\N
af5fb143-44ab-4b63-b63a-d14f415cf87a	61889	2BR-092; NEAR BY GAS GODOWN GATE	At kitchen room, replace outlet drain pipe mesh cover	open	2024-08-09 10:35:11.833+00	\N	\N
05b4f3f9-b747-4db6-9d55-96e8b7c952ee	61895	B 116	Grouting / fixing of drainage net (on the floor) in GF washroom and Kitchen to prevent snakes	open	2024-08-09 10:37:48.321+00	\N	\N
aa8e4764-55ae-442e-89c8-5e047a57d76d	61904	G +7 Qtrs, A 192, IIT campus	Change kitchen pipe, drain blocked	open	2024-08-09 10:39:01.551+00	\N	\N
99637279-b34b-4db1-81ea-23d2d9b5532e	58953	VGSoM	E101, E201 toilet cover broken, lab toilet urine pot pipe loose	open	2024-08-09 10:39:53.825+00	\N	\N
e6bc1312-422d-4ca0-8a50-9837cf007a88	61830	B190	Comode seat is giving repeated problem, need urgent attention	open	2024-08-09 10:40:03.663+00	\N	\N
bfee9afc-e73b-41ee-a351-d25cbf9d1e62	58960	VSRC-2- Girls Block -Mess	Gritting is required in the washing area hole	closed	2024-08-09 10:40:44.459+00	2024-08-09 10:41:10.73+00	\twork done
ae2b5a3d-f78e-486a-829c-ae284e74f902	58951	VGSoM	1st floor toilet outlet pipe issue, no flush stand	closed	2024-08-09 07:08:33.643+00	2024-08-09 07:08:51.498+00	WORK DONE
8995dc57-3d2e-4173-a605-15244bf5c7ff	61507	Azad Hall D-Ext. floor bathroom	01 commode need to be change and 01 urinal pot need to be fixe.	open	2024-08-09 10:41:08.48+00	\N	\N
54c91d59-9118-4a1f-8b5d-c86d35e1116a	61730	Azad Hall C-1st floor EAST bathroom	Urinal inlet pipe need to be change and 01 urinal tap needed.	open	2024-08-09 10:41:49.848+00	\N	\N
ad0f67ca-0ea4-40de-b1d9-0fe8c4e8715a	61803	Azad Hall C-Gr. floor east and west bathroom	All urinal out let pipe need to be change.	open	2024-08-09 10:42:40.656+00	\N	\N
ed24156b-7dfc-4f85-946b-5720c7e3eb3b	61905	C1-180	kitchen drain jam	open	2024-08-09 10:44:19.263+00	\N	\N
137dff6f-7f1c-418b-bfe3-4b57b4b7e448	61905	C1-180	kitchen drain jam	open	2024-08-09 10:45:43.255+00	\N	\N
4e4e2de3-af49-4a67-86cc-fb1bf22dfb98	61907	A-158 (Car shed, ground floor)	Drainage pipe is leaking and car shed is flooding with water.	open	2024-08-09 10:46:26.431+00	\N	\N
44265878-b1c3-4608-92e3-55d8923a9039	61911	Zakir Hussain hall	2/201, 2/202 and 2/302: these rooms latrine pan covers are got damaged	open	2024-08-09 10:46:58.103+00	\N	\N
9d1090bb-f443-43a3-8f6b-c733f07d3950	61912	Mining Department GSR LAB ANX III ground Floor and 1st Floor	Drain pipe clogged	open	2024-08-09 10:47:37.799+00	\N	\N
1ab2193e-b313-4ef4-9313-192379ef6575	61914	2BR 87 Near Gas Godown	Change of Camod Cover lid (OVAL shape)	open	2024-08-09 10:50:52.294+00	\N	\N
aa586a35-7e5f-4e12-bae0-f63c6b787e7b	61921	HK-W-508 MOB NO 6295512074.	COMMODE SEAT IS BROKEN.URGENT.	open	2024-08-09 10:51:29.005+00	\N	\N
22376e28-c70e-45d9-b5ae-456588c3e519	61920	DSK-E-204 9627426069.	COMMODE SEAT IS BROKEN.URGENT.	open	2024-08-09 10:51:59.247+00	\N	\N
fcad5d24-3a85-415e-b027-32371b340cad	61923	HK-W-526 8197878268.	COMMODE SEAT IS BROKEN.URGENT.	open	2024-08-09 10:52:29.398+00	\N	\N
74ac28e1-7bdc-4203-95a6-31d5a226df49	61924	RR-430 8828628004.	COMMODE CHOKED .URGENT.	open	2024-08-09 10:53:00.511+00	\N	\N
fca52c03-7a06-4b37-a6f3-4a7daf3ca425	61926	DSK-N-116 8003316694.	COMMODE SEAT IS BROKEN.URGENT.	open	2024-08-09 10:53:58.479+00	\N	\N
e0512895-4dcd-47d5-b368-7bf6ae21f42f	61928	MS hall-NE- GR, 1ST ANF 2ND FL URINAL POT	WASTE PIPE TO BE REPLACED	open	2024-08-09 10:54:43.606+00	\N	\N
44802af9-a494-4c24-a6d4-3a88b5db09f4	61931	MS hall-NW GR FL	URINAL WASTE PIPE TO BE REPLACED	open	2024-08-09 10:56:48.327+00	\N	\N
5bffdd5e-678f-4b37-8962-38d227921b8d	61932	MS hall-W1- GR AND 1ST FL	URINAL PIPE TO BE REPLACED	open	2024-08-09 10:57:19.839+00	\N	\N
89f59454-e356-495a-9e2d-ebfc11bd233e	61933	MS hall-W1- GR FL	commode sheet cover to be replaced	open	2024-08-09 10:57:52.974+00	\N	\N
c7061957-5fe7-4161-ba5c-3d99646f0942	61934	MS hall-SW-2ND FL	COMMODE SEAT COVER BROKEN	open	2024-08-09 10:58:25.183+00	\N	\N
d29dbd02-57ae-46fb-811b-16333e6369fd	MS hall-E4- GR FL TO 2ND FL	MS hall-E4- GR FL TO 2ND FL	URINAL PIPE TO BE REPLACED	open	2024-08-09 10:59:41.333+00	\N	\N
e9ffe0df-88b4-406c-9083-56feb5ca39bf	61936	MATERIALS SCIENCE CENTRE	Water logged near Toilet Seat of Gents Toilet Ground Floor. Please resolve it asap	open	2024-08-09 11:00:21.822+00	\N	\N
a56b170b-3de5-4610-9e1d-e54d14fae9f2	61941	RR-454 8017218971.	COMMODE CHOKED. URGENT.	open	2024-08-09 11:00:55.262+00	\N	\N
badb22c4-8830-4ce8-8c53-e30fc92f4c8f	61954	A-45 Oriental Flat Complex	Person sent to clear washing machine outlet broke the outlet iron plate. Rats getting in.	open	2024-08-09 11:01:53.534+00	\N	\N
fb07c298-62a3-409e-acfb-e819a3bda328	61955	NFA-101 (9611399564)	Leaking comode and drain pipes. Ground and first floor. Bad smell in the house. Please attend soon.	open	2024-08-09 11:02:25.006+00	\N	\N
870574e7-0062-4882-9806-adc6c670c186	61958	JCG_PCR Building B-block 1st floor Gents Toilet (T-30)	water is spilling from the commode	open	2024-08-09 11:02:58.15+00	\N	\N
d8ddb650-fe76-4730-a20b-076ba09fd24b	61959	B -280 NEAR dav school	water leak in kitchen pipe outside	open	2024-08-09 11:03:33.982+00	\N	\N
dcf7dbf9-b4a2-4d14-9e20-6b16890af6c0	61962	Nalanda complex north side admin block toilet no T 13T 19	One pancover broken two urinal waiste pipe leakage	open	2024-08-09 11:04:06.886+00	\N	\N
0ffc635a-fb18-4c73-b14e-88bbde134d55	61967	VSRC-1 HALL NB-206	COMMODE SHEET COVER BROKEN	open	2024-08-09 11:04:42.27+00	\N	\N
a6edfa5f-ac9b-47be-a890-0cc81765ac9e	61969	LLR HALL C- BLOCK 1ST FLOOR WEST	BATHROOM SHEET COVER IS DAMAGE. URGENT	open	2024-08-09 11:06:06.629+00	\N	\N
164363e1-b8cf-422d-aede-4351c1af54dc	61970	2BR-99, near gas godown.9779623856	blocked kitchen sink, leaking pipe	open	2024-08-09 11:06:44.598+00	\N	\N
e13128da-85a2-4d39-80d6-054f3845d565	61971	RP Hall #E Gr. East side	urinal pipe broken, commode seat broken (3)	open	2024-08-09 11:07:17.062+00	\N	\N
4bb39874-31a5-4c59-9cda-1a27649cec57	61971	RP Hall #E Gr. East side	urinal pipe broken, commode seat broken (3)	open	2024-08-09 11:08:12.413+00	\N	\N
fb1ce85e-183d-44ee-8e5f-51587edf3250	61973	VSRC-2 GIRLS BLOCK -5th FLOOR BATHROOM	Bathroom drain chocked	open	2024-08-09 11:08:52.924+00	\N	\N
6181d8b9-0016-41be-a29b-abbfb1f47224	Letter 	PDF- 211	Commode seet chang	open	2024-08-09 11:10:09.158+00	\N	\N
a48abae2-4e23-4615-b4f5-6ce1594e7655	61978	Qtr. B 276 (Near DAV school) 1st floor (above garage)	Bathroom (non-attached to bedroom) outlet choked. draining to outside wall heavily. URGENT. call me	open	2024-08-09 11:10:39.501+00	\N	\N
b3f62a4e-4c65-4690-a729-8844fd0be4c4	61979	VS Hall- Toilet near office room	kindly repair the commode leakage and a pipe leakage	open	2024-08-09 11:11:14.893+00	\N	\N
d1e97678-bb2a-42fc-bf82-11dfb3610b2f	61981	Q. No. C1-96	Water is leaking in the commode of western toilet	open	2024-08-09 11:12:15.74+00	\N	\N
8aaac7ff-c36f-4998-ae53-509dff32e35d	61986	MS hall-NW-1ST FL	URINAL PIPE TO BE REPLACED	open	2024-08-09 11:12:49.877+00	\N	\N
b6ae38c1-14ee-4865-bd5a-0263f37b711f	61987	MS hall-E3-GR FL	COMMODE SEAT COVER BROKEN	open	2024-08-09 11:13:19.493+00	\N	\N
fae38cf9-dccc-4228-b176-4594c6b35a27	61988	JCB Hall A Block 1st Floor Bathroom	Urine outlet pipe Chocked.	open	2024-08-09 11:13:54.284+00	\N	\N
79604d8b-55ee-46f5-a369-e5a34302f300	61992	RK HALL A & B BLOCK	4-COMMOD COVER BROKEN	open	2024-08-09 11:14:36.716+00	\N	\N
fbfa2d32-ae47-45bf-9429-88ba7bb435b7	61995	SN/IG A and B block 1st floor bathroom	\tDrain Chocked.	open	2024-08-09 11:16:57.541+00	\N	\N
78153267-cd95-4185-851c-b8882219e2f6	61998	RP Hall, B-block 1st floor bathroom near Room No. B-218	1 latrine pan seat cover is broken	open	2024-08-09 11:17:37.628+00	\N	\N
7da4bf0f-b2c9-44e9-9518-90c95934fdff	61999	A-157	kitchen and washroom drain choked, please cleaning	open	2024-08-09 11:18:05.668+00	\N	\N
44c77e3a-972a-4d3d-85b0-538cac6a3054	62000	C1-118	\tCommode sit is broken. Needs replacement.	open	2024-08-09 11:18:47.853+00	\N	\N
5c20c4fd-f239-4af9-95f5-bad518fac6f2	62002	C1-172, Near KV School	\tbathroom floor drain overflow	open	2024-08-09 11:19:13.06+00	\N	\N
dfe0445a-b21e-43f4-ac8d-6e251441a067	62004	RK HALL D-BLOCK WEST WASH ROOM	TOILET SHEET BROKEN NEED URGENT REPAIR	open	2024-08-09 11:19:49.725+00	\N	\N
1cb11b6e-2bbc-4a70-a6ae-681f8f62a935	62005	SN/IG A block and B block 1st floor bathroom	\tDrain Chocked.Please treat as very urgent	open	2024-08-09 11:20:23.404+00	\N	\N
cf5c0ab5-8d2c-4625-b5e4-c90277e4b84e	62012	406 JCG-PCR 4th floor, A block CRRAJ Lab	\trefer to the comp 61838, the work is yet to be done, the complaint was lodged on 15th July.	open	2024-08-09 11:21:17.348+00	\N	\N
044c24ff-53c4-406e-a5f9-977ed39230dc	62014	RP Hall, D-228, 7479394363	\tRoom of the ceiling is leaking, their is bathroom beside room	open	2024-08-09 11:21:44.227+00	\N	\N
bd95b76e-1265-4d95-944e-2fc8f6968a35	62015	VSRC-2 GIRLS BLOCK -3rd FLOOR BATHROOM	Getting (net) is required in the bathroom hole urgently	open	2024-08-09 11:22:11.283+00	\N	\N
cfe08a52-d72f-490b-8c5c-41c26696cc7d	62017	HJB Hall(D/top)	\tToilet seat broken.	open	2024-08-09 11:22:42.451+00	\N	\N
e02a5de2-103f-4fff-9ccc-18581ff28386	62020	5th FLOOR LATRINE CORAL	\tWATER NOT PASSING[CHOCKED]	open	2024-08-09 11:23:13.412+00	\N	\N
08594014-52f2-49ff-9976-dee2f5f62e0d	62021	Nalanda complex south side gr floor toilet NO T 25	\tone urinal waiste leakage repair/replace	open	2024-08-09 11:23:57.172+00	\N	\N
f13730d8-c647-43d6-8a6c-85a07fe35392	62024	A116	\tjamming of the pipeline of kitchen sink	open	2024-08-09 11:24:33.388+00	\N	\N
c4349f0c-91d3-49b5-b374-d141f8a6ea54	62026	snvh hall - OA- 1st bathroom near 227	\tCOOMODE OUT LET PIPE BROKEN . BATHROOM IS VERY DERTY URGENT .	open	2024-08-09 11:25:11.939+00	\N	\N
1e43196c-6966-469c-9c36-6750c95280b4	62027	RR BLOCK GROUND INDEAN BATHROOM.	INDIAN PAN BROKEN ,URGENT	open	2024-08-09 11:25:44.403+00	\N	\N
13a94518-65e8-4a5b-8dee-8dae917b31d5	62028	MS hall-E3- top fl , 2nd fl	URINAL PIPE TO BE REPLACED	open	2024-08-09 11:26:12.188+00	\N	\N
0cc5bdf0-d8e3-4a92-a5c6-2e0a276f1ed2	62035	H-112	Western pan need to be changed. It is damaged since last 2month.	open	2024-08-09 11:28:08.812+00	\N	\N
09b47937-65f4-44c4-a883-ff719035e4d0	62039	snvh hall c block 3 floor	\tsink main line jam urgent	open	2024-08-09 11:28:38.976+00	\N	\N
4b10b0c0-0425-4f41-8a4d-15fd176e20d2	62043	HK-W-1208919718795.	COMMODE CHOKED. URGENT.	open	2024-08-09 11:29:11.012+00	\N	\N
34a4686c-bd42-4392-a1a9-032214524df3	62044	DSK-E-212	\tBATHROOM CHOKED.	open	2024-08-09 11:29:34.155+00	\N	\N
6ccd1c76-120f-4048-af3b-cbaceeef761b	62045	HK-S-515	\tCOMMODE SEAT IS BROKEN.	open	2024-08-09 11:30:38.827+00	\N	\N
f0890d8d-ab46-49c9-9a29-fa16db258332	62046	DSK-N-507	\tTOILET SEAT BROKEN.	open	2024-08-09 11:31:10.283+00	\N	\N
3406790b-59d2-4693-8ffa-9abfc0ca4f6f	62050	\tQuarter B 77	\tDrain pipe mesh required	open	2024-08-09 11:31:53.488+00	\N	\N
ae94eb3c-6581-4a58-9769-66703f6963b8	62048	RR-303	\tBATHROOM CHOKED.	open	2024-08-09 11:32:32.313+00	\N	\N
f95e9e18-0570-4078-ba77-bc128e12730c	62051	\tPDF 202	Water logging below wash basin in bathroom due to faulty outlet. Entry of mouse needs to be blocked	open	2024-08-09 11:33:12.385+00	\N	\N
4a05b2a4-f6ae-405e-93cb-296a165b8eb9	62053	W 213	TOILET SEAT BROKEN ,URGENT	open	2024-08-09 11:33:53.539+00	\N	\N
fbbee682-1368-41da-9c06-851783937ddc	62054	SDS 507	\tTOILET SEAT LOOSE ,URGENT	open	2024-08-09 11:34:19.683+00	\N	\N
db8e8e3f-25b7-4019-9e30-12aa4c058f1c	62055	RR502	\tTOILET SEAT BROKEN ,URGENT	open	2024-08-09 11:35:23.122+00	\N	\N
a7bef70e-6071-4cac-9677-ec34b78705a4	62049	SDS-207 7807425728	\tCOMMODE IS BROKEN. URGENT.	open	2024-08-09 11:35:53.115+00	\N	\N
59a2836a-7d6b-46dd-ad3a-da911ae30c57	62041	DSK E 314	COMMODE BROKEN .URGENT	open	2024-08-09 11:36:23.21+00	\N	\N
cac53971-3c5a-477c-afc1-13d7473bc46c	62061	RP Hall, D-213	\tWater leakage from walls/ roof	open	2024-08-09 11:36:58.866+00	\N	\N
a86a7494-4c81-4f0f-8497-0d7cc526899b	62062	\tJCB HALL E BLOCK FIRST FLOOR GUEST BATHROOM	LATRINE WALL OUTLET PIPE IS CHOCKED NEEDS TO BE CLEANED ASAP	open	2024-08-09 11:37:38.738+00	\N	\N
03da8d11-9eaf-4ec8-91bb-a5130cd833be	62063	NEAR RR101 OPEN BATHROOM GROUND FLOOR NEAR LIFT	INDIAN PAN BROKEN ,URGENT	open	2024-08-09 11:38:08.138+00	\N	\N
a549df4d-34ec-4709-87e6-a8cf513edb43	Latter	G-112	Pan change	open	2024-08-09 11:39:25.114+00	\N	\N
9c31a4a3-e284-45d5-be84-664f6c4a4571	Latter	PDF-211	Commode change	open	2024-08-09 11:40:33.194+00	\N	\N
8dbe5509-4b4c-4575-81c9-5eb5acc9d575	62067	DSK-E-206 6394552736.	COMMODE SEAT IS BROKEN.	open	2024-08-09 11:41:15.25+00	\N	\N
2f480fc2-80f4-42b5-a42b-33b54ff72fd6	62070	Gymnasium 1st Floor Jains Toilet	Jains Toilet Urine pipe , Basin Pipe, Flush Jammed.	open	2024-08-09 11:41:45.226+00	\N	\N
051463df-a6bc-4944-a642-43f9750150c9	62074	B & C junction block ground floor lavatory in RLB Hall	Commode cover is broken.	open	2024-08-09 11:42:14.602+00	\N	\N
8af17499-4523-4ea8-942c-1188d157fcd6	62075	MS hall-E4-1ST AND 2ND FL	urinal pot chocked	open	2024-08-09 11:42:39.233+00	\N	\N
ff083477-7cda-4677-a341-28fcb0d2e4c0	62077	Geology and Geophysics Department ground floor Ladies toilet	\twater pipe line leakage. urgent	open	2024-08-09 11:43:37.514+00	\N	\N
f7e9880d-b3db-4ab0-9b94-2719dfd9a87b	62083	55-G-06	\tgratting fixing	open	2024-08-09 11:44:26.713+00	\N	\N
d1522fd1-1fa6-43b9-bfb2-b3f5c295f123	62084	Patel Hall D Gr. fl. Bathroom	All the urinal outlet pipe damaged. Pl. do the needful.	open	2024-08-09 11:44:53.697+00	\N	\N
c6fb4db9-9b56-4a2c-8b31-97af21e87c00	62064	BF 1/13	2nd floor sanitary pip choked	open	2024-08-09 11:45:23.577+00	\N	\N
e054bc82-84da-45c8-8193-9be3a66f91a6	62085	Patel Hall C bl. 2nd fl. Bathroom.	Urinal outlet drain chocked. Pl. do the needful.	open	2024-08-09 11:45:49.935+00	\N	\N
518c62f2-d416-49db-84c0-a67945313d74	62088	sds 524	\ttoilet seat broken ,urgent	open	2024-08-09 11:46:21.246+00	\N	\N
86a3def5-0fcc-4cb8-a6d6-3e3c0b503168	62091	C1-147	\tWater is leaking from bathroom commode.	open	2024-08-09 11:46:51.417+00	\N	\N
b543593c-86bf-4a91-93e6-854785f24cb7	61575	HI-125	\tIndian pan need to be change and commode fix needed.	open	2024-08-09 11:48:23.471+00	\N	\N
ab7e0c36-a393-432a-94c9-243a3e5aa6c4	62069	Qr. No. A-10	\tReplace commode and sink in bathroom, new anti-skid tiles being put by contractor	open	2024-08-09 11:49:05.951+00	\N	\N
b0594722-ba0d-4a71-98af-debb06d14e78	62097	\tQtr. No. - H1 - 47, Near Durga Mandir Gate, IIT Campus Kharagpu	Gather required in our outlet water drain.	open	2024-08-09 11:49:41.432+00	\N	\N
e25a7af5-d738-4d27-b5ea-9a43dcd3af5f	62102	SDS-538	\tBATHROOM CHOKED.	open	2024-08-09 11:50:17.793+00	\N	\N
7dd955ea-2a1a-42a9-bec0-9f32bfc53f4a	62100	DSK-N-218	\tBATHROOM CHOKED.	open	2024-08-09 11:50:49.793+00	\N	\N
dd18023a-1085-4e0c-b82a-261598f92795	62104	SDS-232 8354893943.	\tCOMMODE SEAT IS BROKEN.URGENT.	open	2024-08-09 11:51:13.473+00	\N	\N
a833ff21-c809-491a-bcb3-d06e1ebe9ecd	62106	HK-S-301 7093436044.	\tBATHROOM CHOKED.	open	2024-08-09 11:51:41.889+00	\N	\N
d08257de-effa-476e-b826-548ec6a54b14	62107	JCB HALL A BLOCK FIRST FLOOR BATHROOM	ONE OF THE BASIN OUTEL PIPE IS CHOCKED, PLEASE ATTEND THE COMPLAINT ASAP	open	2024-08-09 11:52:06.041+00	\N	\N
9ee10b77-4e5c-4e46-bd4c-36d0034f75e2	62110	BRAmbedker Hall-LAV-B-52	\t06 nos urinals outlet pipe are damage .need to be process	open	2024-08-09 11:52:41.946+00	\N	\N
e88b7716-aafc-4c7c-a374-57f95cc81168	62111	\tA-47 IIT Campus	\tOutlet of kitchen sink is clogged please take immediate action	open	2024-08-09 11:54:15.929+00	\N	\N
9b77ce32-2722-4ab4-8f4c-19b57e1600a5	62112	SDS-303	\tBATHROOM CHOKED.	open	2024-08-09 11:54:48.88+00	\N	\N
023b1325-4a25-495e-a098-d9277cb3b030	62115	NFA-62	\t2nd floor water not passing	open	2024-08-09 11:55:16.415+00	\N	\N
eeb52f87-5d54-40b1-94ca-a96b16d03aad	62117	BF-1/9	BATHROOM LEAKAGE WHILE FLUSHING. AND WATER COLLECTED IN ONE SIDE	open	2024-08-09 11:55:44.271+00	\N	\N
546a4a79-a62a-44dc-9162-c7e12b23b192	62119	Azad Hall ,C Block 2nd floor East	\tBathroom chocked, waste pipe broken , flush is not working	open	2024-08-09 11:56:26.272+00	\N	\N
8c00d1c9-eb0a-439d-ac12-1cfe5260b865	62121	Zakir Hussain hall	\t2/103: the drain cover in the kitchen and bathroom drain cover is missing	open	2024-08-09 11:57:11.968+00	\N	\N
a71d9b87-5b71-4e6c-ad05-feb6190dda97	62123	2BR-65	\tCleaning of Drain	open	2024-08-09 11:58:09.312+00	\N	\N
79284cf1-c334-4510-9d85-4ccfd4d83222	62124	DSK-N-527 8218939612.	\tCOMMODE SEAT IS BROKEN.URGENT.	open	2024-08-09 11:59:00.336+00	\N	\N
0e0596bc-5135-4b62-a19a-3f8d53a9913e	62130	Transportation Engg Lab(behind old building, old bref biotek lab	Gratings required in ladies toilet	open	2024-08-09 12:00:09.384+00	\N	\N
2eba2d85-25f7-4468-ba1c-37afc9a5f137	62131	VS HALL c-316 , C-329	\tBATHROOM CHOCKED	open	2024-08-09 12:00:35.304+00	\N	\N
c9d1adee-3c8a-431a-a654-1a3876c217d6	62132	VS HALL B-216	\tBATHROOM CHOCKED	open	2024-08-09 12:01:03.584+00	\N	\N
0945dd04-3292-4e8d-a9d3-b1006bc954a3	62134	\tLLR Hall, C- Top Middle block near C-328	\tBathroom chocked (urgent)	open	2024-08-09 12:01:43.456+00	\N	\N
c5d9f63f-eba1-404a-89db-9be7ef200636	62138	SDS-217	\tBATHROOM CHOKED.URGENT.	open	2024-08-09 12:02:08.64+00	\N	\N
18f75d23-29c8-4ab9-9e08-863d9b8aabb0	62135	HK BLOCK BACK SIDE OF ROOM NO-HK-S-106	MAIN DRAIN CHOKED . URGENT	open	2024-08-09 12:02:37.223+00	\N	\N
47633d49-5a44-475a-9a29-bae2f09d42df	62143	DSK-N-302	\tBATHROOM CHOKED.URGENT.	open	2024-08-09 12:03:08.311+00	\N	\N
f69dfc84-3f09-4314-acca-d43fbbd182d2	62144	HK-W-526 8197878268.	\tCOMMODE SEAT IS BROKEN.URGENT.	open	2024-08-09 12:03:36.287+00	\N	\N
1085432e-0f3c-4e80-a12d-da3612dbe71c	62145	Zakir Hussain hall	\t3/105: Inside the flat the bathrooms drainage pipe is leaking continously	open	2024-08-09 12:04:02.159+00	\N	\N
e3724a80-d134-47f6-ba85-a15acfb61b6c	Latter	KV School girls 2nd	Seat cover	open	2024-08-09 12:05:01.967+00	\N	\N
215070e0-80b1-4645-9906-6c9c8ce8fbdc	62147	MS hall-NW-1ST FL	\tBATHROOM CHOCKED, URINAL POT IS CHOCKED	open	2024-08-09 12:05:55.887+00	\N	\N
c4baac43-bc3c-4051-b6a5-a415bc992b97	62150	MS hall-W3-TOP FL	\tBATHROOM CHOCKED	open	2024-08-09 12:06:27.719+00	\N	\N
e09f040f-cc64-4fe0-a554-afc8da65a29d	62148	MS hall-NW-105 BATHROOM	\tURINAL PIPE TO BE REPLACED,BATHROOM CHOCKED,	open	2024-08-09 12:07:11.848+00	\N	\N
894c6c7b-181d-40bf-8e42-439e3942ebe8	62149	MS hall-E3-GR FL	\tWASTE PIPE BROKEN	open	2024-08-09 12:07:41.959+00	\N	\N
44187f96-3ca0-4483-971f-6561452ea48e	62151	MS hall-AE-2ND FL URINAL POT	\tURINAL PIPE TO BE REPLACED	open	2024-08-09 12:08:22.807+00	\N	\N
aa3ccfba-1bdd-4a21-b62d-ea7eeb1b855b	62152	MS hall-ME-1ST FL	BATHROOM CHOCKED	open	2024-08-10 05:03:23.058+00	\N	\N
7076d152-6743-45fe-9fb2-6e7ba01b8d52	62155	MS hall-MW- 1ST, 2ND FL	\tURINAL PIPE TO BE REPLACED	open	2024-08-10 05:04:01.53+00	\N	\N
2c9bcd0c-55c8-47aa-aeb8-743a51379672	62154	MS hall-W3-TOP FL	\tBATHROOM CHOCKED AND JET SPRAY NOT WORKING	open	2024-08-10 05:05:03.282+00	\N	\N
4d75fd5e-bd11-4e1d-94b6-efde272610c8	62157	MS hall-AW- 1ST FL, 2ND FL	\tBATHROOM CHOCKED	open	2024-08-10 05:05:44.106+00	\N	\N
1f92969a-389e-4d42-b7bb-faf58e060088	62160	RK HALL D-BLOCK EAST SIDE WASH ROOM	SANITARY PIPE LICKAGE	open	2024-08-10 05:06:23.081+00	\N	\N
53512b82-dbb4-4a0a-9fcc-ef94342971fb	62161	HK-W-119 9906992404.	\tCOMMODE CHOKED. URGENT.	open	2024-08-10 05:08:01.073+00	\N	\N
0ecb191c-6cdd-4049-b1b6-3fa2daa9458d	62162	HK-S-515 895423725.	\tCOMMODE SEAT IS BROKEN.	open	2024-08-10 05:08:31.514+00	\N	\N
96e6026e-e19b-4a12-a140-59a7a577178c	62163	RR-227 9564014836.	\tCOMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 05:08:59.626+00	\N	\N
d0307515-2c75-4928-9a74-3236af0e11d0	62164	HK-W-503 8335897856	\tCOMMODE SEAT IS BROKEN.	open	2024-08-10 05:09:52.073+00	\N	\N
fb5727bc-42c6-4ecf-9463-f41784f337d6	62165	RR-205 8335897856.	BATHROOM CHOKED.	open	2024-08-10 05:11:42.343+00	\N	\N
ccc54610-05cc-4597-8156-ef1100da29a5	62166	I&SE Department 2nd floor toilet	\tBasin outlet pipe is chocked	open	2024-08-10 05:12:12.119+00	\N	\N
52a8deac-77b4-4062-813c-890561741f68	62170	Nalanda complex north side T 6 Toilet	\turinal waiste line blocked	open	2024-08-10 05:13:08.368+00	\N	\N
170d750b-0990-4f38-aaa2-eba52069d9d0	Latter	VSRC-1-NC-205	Bathroom chock	open	2024-08-10 05:15:09.889+00	\N	\N
42a77b01-e08a-4577-86b7-738a75e1cd6d	62041	DSK E 314	COMMODE BROKEN .URGENT	open	2024-08-10 05:16:22.888+00	\N	\N
763b6b58-6ff7-40f4-892e-8172eefbee75	62171	H -122	\tnew trep with line	open	2024-08-10 05:17:16.44+00	\N	\N
0ed28501-1219-4520-9f80-8d6ab9744a98	62172	MMM hall RR -103	\tpan changs	open	2024-08-10 05:18:45.352+00	\N	\N
8d593bce-5218-495b-85d1-e0a7400a0aa5	62173	Zakir Hussain hall	\t2/303: Commode cover is got damaged	open	2024-08-10 05:19:17.2+00	\N	\N
3f054b39-016f-48bb-9d4a-dacc31cc6671	62174	\tZakir Hussain hall	\t2/303: leakage in the commode drainage pipe	open	2024-08-10 05:19:40.6+00	\N	\N
4fdfb38a-77d1-486a-8658-a75603d87139	62186	Mens washroom, Ist floor, E&ECE Dept.	\tdrian jammed and waste water leakage from the pipes - very urgent pls	open	2024-08-10 05:20:13.12+00	\N	\N
f87175ac-78c4-4b44-ae52-5934eed66b63	62187	B 139	\ttwo bathroom water clogged.pl. come immediately	open	2024-08-10 05:20:41.592+00	\N	\N
ce5b3858-71f6-4b77-88fe-de28dd1f9688	62188	HJB Hall(D/top floor bathroom)	\tOut let pipe jam.	open	2024-08-10 05:21:09.271+00	\N	\N
fb4010b4-d1bb-46fe-8c64-5264be066a43	62190	HJB Hall(d/top)	\tOne toilet seat broken.	open	2024-08-10 05:21:45.263+00	\N	\N
054a3c11-d3d2-4862-91f7-418e0b2028c5	62192	1BR95	KITCHEN DRAIN LINE GETTING CHOKED FREQUENTLY RESULTING TO OVERFLOW	open	2024-08-10 05:22:17.567+00	\N	\N
3d3c9eaf-a835-4cf2-b1d9-4a8f0f61f72b	62195	HJB Hall(HLV/4)	Commode seat open. Please refix.	open	2024-08-10 05:23:20.376+00	\N	\N
a59fb91f-84a9-488f-bd73-8296e6dd8b94	62196	\tHJB Hall(HLV/4)	\tUrinal pot open from the wall.	open	2024-08-10 05:23:45.703+00	\N	\N
b3106b9e-9db7-493d-bbda-2bb7b81b66fd	62195	HJB Hall(HLV/4	\tCommode seat open. Please refix.	open	2024-08-10 05:24:19.303+00	\N	\N
e4f0cfba-48dd-4fb2-a6f7-920e812a58fe	62198	Life Sc Building room 302	\tLab basin water leaking.Fix it ASAP	open	2024-08-10 05:24:47.44+00	\N	\N
f1e80b2e-7243-43d7-abb6-1f83f7bc7312	62199	BRAmbedker Hall-LAV-A-53 new block	\t06 nos Urinal pot Out-Lets are damage .need to be Clear treat as very Urgent.	open	2024-08-10 05:25:15.399+00	\N	\N
9ecbbb17-5db6-4d39-8135-ac41a7d4cb39	62201	Patel Hall A bl. 1st and Gr. fl. bathroom.	Pan lid damaged. Pl. do the needful.	open	2024-08-10 05:26:49.487+00	\N	\N
63fc97f5-f955-4250-a551-449aa9b7a419	62202	C1-125	\tPlease change the bathroom Jali	open	2024-08-10 05:27:15.303+00	\N	\N
430da34d-beed-4c9d-9550-2afac48090d0	62203	Radar flats	\tRF-04: Commode cover is got damaged	open	2024-08-10 05:27:48.319+00	\N	\N
74e9a527-107a-446c-b3a6-0e6cea0c5c0e	62204	B-112 1st floor	1st floor bathroom pipe leaking	open	2024-08-10 05:28:16.671+00	\N	\N
0d857945-235e-4cc7-8d55-259830a632f7	62205	Zakir Hussain hall	\t1/304: the waste water is logging in the bathrooms	open	2024-08-10 05:30:34.404+00	\N	\N
4e53312d-0655-43fa-a6bc-bee324fa78c2	62206	SDS-351	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 05:31:01.18+00	\N	\N
1747a97d-9781-4dcb-8545-494541dbf9d6	62214	Zakir Hussain hall	\t2/303: the commode cover is got damaged	open	2024-08-10 05:31:40.055+00	\N	\N
1bbba1df-ca7e-44f1-95ec-2d874c932401	62218	DSK--E-212 8249301649.	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 05:32:10.375+00	\N	\N
eae3f646-4fee-46f6-a880-2d6cfb802dcf	62219	RR-207 9121243444.	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 05:32:41.471+00	\N	\N
2ad31760-54cf-42ad-87d0-04266d4322e1	62221	RR-207 9121243444.	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 05:33:25.078+00	\N	\N
3dc4d76f-1749-40db-9eef-86e3fed3f89f	62222	DSK-N-308 8010421891.	\tCOMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 05:33:56.454+00	\N	\N
6c8ec116-f973-4477-bf58-05e65ad57e9d	62223	DSK-N-528 76660989838.	\tCOMMODE SEAT IS BROKEN.URGENT	open	2024-08-10 05:34:21.622+00	\N	\N
1310edcf-d791-4d4b-b79e-3d70bb9dd3dd	62225	DSK-N-413	\tCOMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 05:34:47.822+00	\N	\N
aab6d153-ea37-4b0b-98b7-8de2731542b4	62226	HK-W-525	\tCOMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 05:35:15.502+00	\N	\N
1514f80c-4249-446b-8551-d60a3a53dae6	62227	DSK-E-212 8299301649.	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 05:35:40.558+00	\N	\N
083d0db3-56a4-4bf6-ab14-ddc8931dbe54	62228	Azad Hall C-2nd west floor bathroom	\tBathroom chocked.	open	2024-08-10 05:37:58.23+00	\N	\N
ee33d027-dc2e-4bcd-89c7-08998baa7ed5	62229	Azad Hall C-1st floor west bathroom	commode broken, need to be change URGENT	open	2024-08-10 05:38:39.462+00	\N	\N
7ede3b88-6944-4b7a-9902-426d1286b984	Latter	E&ECE dept	Bathroom chock	open	2024-08-10 05:43:37.782+00	\N	\N
7e78c969-bfa5-423a-9124-50ce6da791bd	62239	b c roy hall , Lav E 12	\tlatrine is choked . very urgent	open	2024-08-10 05:44:18.782+00	\N	\N
69c1bb29-9176-46e4-8613-1f3fc441c96a	62244	LLR, C-block 1st floor west bathroom	\tLatrine seat cover needed	open	2024-08-10 05:44:43.413+00	\N	\N
fb77f0ec-cbdc-48e5-8610-f4eabcd2ec03	62245	1 BR - 83	\tBathroom drainage protector need to change	open	2024-08-10 05:45:09.125+00	\N	\N
11202284-6660-4f68-98fd-e1ddd87ad8f9	62269	SDS-351	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 05:45:49.266+00	\N	\N
cd958292-f846-4e2a-b6ec-8fde8eaed8ca	62268	SDS-510	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 05:46:16.386+00	\N	\N
9c4f697c-be38-438f-b623-c3be1dc0493e	62271	DSK-E-211 9893394637	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 05:46:47.38+00	\N	\N
2e19b18f-172e-40d0-a03b-1ceccd9437e9	62273	M S Hall-W1-1ST FL	\tLATRINE CHOCKED	open	2024-08-10 05:47:14.021+00	\N	\N
587be5f2-2c46-496a-b263-aa7821da742e	62274	M S Hall-NW- GR FL AND 1ST FL	\tURINAL PIPE AND FLUSH TO BE REPLACED	open	2024-08-10 05:47:49.142+00	\N	\N
985e4037-cd19-4d3f-86d6-ba7940afcee2	62277	HK-W-421 95925290517.	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 05:48:21.973+00	\N	\N
87f9f227-420f-44fa-923d-a91c5f312fba	62279	NFA-101 (9611399564)	Leaking comode and drain pipes. Ground and first floor. Bad smell in the house. Please attend soon	open	2024-08-10 05:48:47.709+00	\N	\N
bad1d3a2-d1eb-49b8-8ba7-c6a31fd445f2	62280	2 BR 90	\tReplacement of Grating in kitchen	open	2024-08-10 05:49:15.053+00	\N	\N
81260a98-1b49-401d-8cc0-8a321f94e5b3	62283	Radar flats	RF-04: Commode cover is got damaged	open	2024-08-10 05:49:42.165+00	\N	\N
38ea2ee5-1dc3-4227-86f2-691cd342a75a	62284	\tFlat#: B-129 (near Dandyakaranya area)	[URGENT] Waste water outlet pipe (B-135) has broken down and water is free falling on our verandah.	open	2024-08-10 05:50:16.829+00	\N	\N
ebc769f4-b006-4062-9959-27e4d8d4d554	62290	LLR Hall, B -Top West Bathroom near Room B-314 315	\tSeepage in the wall in the bathroom (urgent) their are electrical line outside (Urgent)	open	2024-08-10 05:50:48.637+00	\N	\N
5d60bf1d-e786-40a8-ad3d-1684e0b9d67a	62293	HK-S-515 8954237251.	COMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 05:51:17.973+00	\N	\N
381d8fb5-fed4-4422-961d-e196ccaff37b	62294	\tBRAmbedker Hall-LAV-d-52	02 nos Urinal pot Out-Lets are Choked.need to be Clear treat as very Urgent.	open	2024-08-10 05:52:47.58+00	\N	\N
040c725a-24b3-4783-9e6b-561d5385bbda	62294	BRAmbedker Hall-LAV-d-52	\t02 nos Urinal pot Out-Lets are Choked.need to be Clear treat as very Urgent.	open	2024-08-10 05:55:06.228+00	\N	\N
18db5856-1f9f-4ca2-a3fe-83b0e110d9bf	62295	MT Hall B Block	outisde durtpipe buss open, waste water fallingdown	open	2024-08-10 05:55:35.076+00	\N	\N
8019a040-ccac-418c-aa73-3a2bea4128ac	62296	MT Hall B-Block LAV -5 & LAV-6	\tdrain chocked	open	2024-08-10 05:55:59.956+00	\N	\N
c1adc7e9-16b6-4284-903c-0eb8c487fd71	62299	SDS-232 8354893943	\tCOMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 05:58:16.26+00	\N	\N
13ba7c0c-b91d-4f16-b59a-7a24336e4408	62300	DSK-N-223	\tCOMMODE CHOKED. URGENT.	open	2024-08-10 05:59:01.108+00	\N	\N
0bc95a7c-e565-4e8f-a4a0-a9e230921b5d	62301	RR-201 9493127349.	\tBATHROOM CHOKED.URGENT	open	2024-08-10 05:59:29.852+00	\N	\N
a89c7267-8f37-43f5-b5dc-00c1ccdb92c8	62282	JCB Hall F - Block Ground floor Latrine I, II & III	Commodes has been broken	open	2024-08-10 06:00:00.404+00	\N	\N
7c640f64-df40-4d07-8272-99b792b45ae8	62312	HJB Hall(D/top floor)	Commode seat broken.	open	2024-08-10 06:00:53.191+00	\N	\N
c7b76c6a-367d-4153-a947-e1a975d58d37	62313	JCB HALL E 1ST FLOOR GUEST BATHROOM	\tGuest Bathroom outlet pipe jam	open	2024-08-10 06:01:18.428+00	\N	\N
a093c117-1650-4ab9-ad2a-de11b0e621fa	62317	RLB Hall, C-Block 1st floor bathroom toilet.	\tCommode cover is broken and need to be replaced.	open	2024-08-10 06:02:10.883+00	\N	\N
a9e75d21-4cbf-4d49-aca9-b6298b1e8fc1	62320	\tM S Hall-NW GR FL	URINAL PIPE TO BE REPLACED AND BATHROOM CHOCKED	open	2024-08-10 06:02:39.859+00	\N	\N
6011b64c-976d-4104-9232-5d815df074d6	62322	SDS-113	\tCOMMODE BROKEN. URGENT.	open	2024-08-10 06:03:05.916+00	\N	\N
0016c80c-8b01-4b3a-b70a-d7e95b485f93	62324	RR-203	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 06:03:40.348+00	\N	\N
ecf76ec0-2dac-436b-95d7-5b4334d473f1	62323	SDS-525	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 06:04:08.323+00	\N	\N
4b0690b3-34a9-426a-8b8c-eaedd0fed08d	58962	Patel Hall C bl.1st east and west fl. Bathroom	Four commode cover damaged. Pl. do the needful.	open	2024-08-10 06:04:32.417+00	\N	\N
6899ab19-c68d-4780-af5c-9f246bf23c1d	62325	RR-303	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 06:04:36.187+00	\N	\N
36f9e0a7-9eec-4daf-9164-a674fcd81a0f	62326	RP Hall #E BLOCK GROUND FLOOR, 1ST , 2ND,3 RD FLOO	DRAIN AND OUTLET PIPE IS TOTALLY CHOCKED. BATHROOM WATER IS OVERFLOWING IN BATHROOM FLOOR . URGENT	open	2024-08-10 06:05:02.283+00	\N	\N
058af08f-559d-4fcd-bd45-bff4b893a14d	62327	B-310	URGENT: Kitchen external exhaust leaking.	open	2024-08-10 06:05:28.371+00	\N	\N
9893ebc8-44e8-4bc7-bc0d-2e00389470e8	62328	LBS HALL LAV/C/44	\tUrinal PVC Pipe broken	open	2024-08-10 06:06:11.395+00	\N	\N
6ac33c0d-1c1d-42fd-a9a0-c37661120588	62329	ground floor and 1st floor gents bathroom, E & ECE Department	drainage is clogged in the above washroom	open	2024-08-10 06:06:45.187+00	\N	\N
31752374-bfbb-4426-b8d9-0c9196b5abed	58965	BRAmbedker Hall-LAV-C-22	06 nos urinals outlet pipe are damage .need to be process	open	2024-08-10 06:07:49.719+00	\N	\N
72a0449b-fcad-4f5b-b999-e6bad97d1872	62330	BRAmbedker Hall-LAV-D-11	\t01 nos urinal outlet pipe is damage.	open	2024-08-10 06:08:17.615+00	\N	\N
dc26d5b1-63ae-48bf-be03-eee55b0b9f21	62331	BRAmbedker Hall-LAV-31	\t01 nos urinal pot is damage.treat as very urgent	open	2024-08-10 06:08:42.775+00	\N	\N
53ffccfa-95d9-4f3c-90b2-a0491f717c76	58966	Qt. No: 1BR-89	The plastic toilet sit cover is cracked, needs immediate replacement	open	2024-08-10 06:08:49.638+00	\N	\N
fe2e470e-8d23-401f-91fb-45174360ddc3	62341	SN/IG B 1st Floor bathroom	\tDrain chocked badly.Please treat as urgent	open	2024-08-10 06:09:12.866+00	\N	\N
d871b4fe-6e07-412a-91b1-15b081f7c65b	58967	RKHALL B-BLOCK 1st FLOOR WEST SIDE WASHROOM	URINEL OUTLET PIPE CHOCKED	open	2024-08-10 06:09:24.358+00	\N	\N
415f6ad0-1a2c-420b-bd76-b8c5d3806798	62343	HK-S-505 9614816720.	\tCOMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 06:09:38.114+00	\N	\N
c4978ef4-aa38-49fa-94bb-4c59ebe9a4b6	58969	METALLURGICAL & MATERIALS ENGINEERING DEPARTMENT	1st floor urinal pot not working	open	2024-08-10 06:13:19.123+00	\N	\N
4ebcc9c3-dccd-4fc6-afea-04f51ab89a64	62344	HK-S-510 MOB NO 8327463346.	COMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 06:15:53.554+00	\N	\N
8332a97c-1bc7-4d54-9c92-518adee024de	62346	HK-S-520	\tCOMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 06:16:18.262+00	\N	\N
487efe36-9076-4ebe-b039-04b042439585	62347	B-283	\tleakage from the outflow pipe of kitchen sink	open	2024-08-10 06:16:40.209+00	\N	\N
d37c55d2-19d6-4eb7-81fc-655a898dfb2f	62349	4th floor JCG-PCR building	refer to the complaints 61838 and 62012, the work is not yet done, it is more than 2 weeks	open	2024-08-10 06:17:03.071+00	\N	\N
f1deac0f-23dd-4615-bbf3-23b8336c86aa	62345	SDS-426 9091521025.	\tCOMMODE BROKEN. URGENT.	open	2024-08-10 06:18:02.738+00	\N	\N
9a4c29cc-249e-4607-9754-7f471365a880	62357	BRAmbedker Hall-(LAV-C-11-LAV C-51)	\tBATROOM OUTLET PIPE IS LEAKING CONTINUOUSLY,TREAT AS VERY URGENT.	open	2024-08-10 06:18:31.609+00	\N	\N
4f633269-3f3c-4de5-afe8-cacc04bfb6d5	58977	A 76	Recurrent water leakage from commode outlet manifold. Please repair asap.	open	2024-08-10 06:18:46.519+00	\N	\N
fb6b8883-651e-4de3-be04-533a51a41bbf	62358	IGH ROOM NO B-202	\ttoilet seat cover is broking	open	2024-08-10 06:18:57.697+00	\N	\N
19c45590-8e9b-4711-8af2-9372df740d5a	58980	gokhale hall	a.004.new comod line.emergancy.	open	2024-08-10 06:19:14.712+00	\N	\N
a1f8e3f3-e021-47a3-aeca-00aed11e08af	62360	JCB HALL B BLOCK 1ST FLOOR BATHROOMS	The outlet pipe of the toilet is clogged	open	2024-08-10 06:19:40.266+00	\N	\N
3eef80f2-bd3c-471b-be20-3636db95bbfe	58982	BRAmbedker Hall-LAV-D-12	urinal external outlet pipe is damage .treat as very urgent	open	2024-08-10 06:19:39.343+00	\N	\N
8840c0ee-9837-480f-a801-e10a42242b6a	58984	HK-W-321 7305221689.	COMMODE SEAT BROKEN. URGENT.	open	2024-08-10 06:20:02.838+00	\N	\N
e33284dc-6b85-4fa2-9c81-bb90504c04be	62359	IGH ROOM NO A-302	\tbathroom outlet pipe blocked	open	2024-08-10 06:20:05.897+00	\N	\N
dc017c05-e7b0-4670-b450-cae65499ca6d	62361	Gokhale Hall	a 105 talote serct.broken	open	2024-08-10 06:20:57.809+00	\N	\N
eba1a033-3a80-42fe-92d3-f0b6e4e65344	62363	BRAmbedker Hall-LAV-C-32	06 nos urinals outlet pipe are damage .need to be process	open	2024-08-10 06:21:30.913+00	\N	\N
437b1b9e-5cbb-4a5c-bddc-fb9ce1e32620	62362	BRAmbedker Hall-LAV-C-42	\t06 nos urinals outlet pipe are damage .need to be process	open	2024-08-10 06:21:59.897+00	\N	\N
f06e2a2a-1d00-4a97-8584-1ab00fe6e579	62365	Zakir Hussain hall	\t2/301: the commode cover is got damaged	open	2024-08-10 06:22:26.306+00	\N	\N
3608c220-c63d-4338-b440-76dcc206c879	62368	RK HALL E-BLOCK EAST SIDE WASHROOM	\tALL THE URINEL PIPE NEED TO BE CHANGED .	open	2024-08-10 06:22:53.074+00	\N	\N
6939633b-79d4-45b7-b74c-7dacda2b0cdb	62370	\tJCB HALL F BLOCK GROUND, FIRST FLOOR AND SECOND FLOOR LAVATORY	FIVE URINAL OUTLET PIPES ARE DAMAGED, NEED TO BE INSTALLED WITH NEW ONES ASAP	open	2024-08-10 06:23:32.129+00	\N	\N
51995f23-419f-47ed-94f1-fad7305d0dd5	62373	JCB HALL F BLOCK GROUND, FIRST FLOOR AND SECOND FLOOR LAVATORY	5 NOS. OF URINAL OUTLET PIPES ARE BROKEN OUT NEED TO BE INSTALLED WITH NEW ONES ASA	open	2024-08-10 06:24:08.689+00	\N	\N
fbf3c118-777b-4891-a603-66f5ffa4c642	62371	Azad Hall ,c-Block west first floor	\tcommode seats broken. please change the all seats	open	2024-08-10 06:24:39.145+00	\N	\N
382b9ae0-b6cc-419b-bfbb-c8ac54010c92	62374	RP Hall #C BLOCK 1ST FLOOR WEST/ MID AND NEAR OLD COMMON ROOM	URINAL MAIN DRAIN CHOCKED/ OUT LET CHOCKED. URGENT	open	2024-08-10 06:25:58.896+00	\N	\N
64b19266-ad35-418d-8274-66dbae502f07	62377	Azad Hall ,E-Block first floor west side	\twash room out let drain choked	open	2024-08-10 06:26:42.265+00	\N	\N
68f31c0d-ea1a-454a-b9ca-101d7f12084b	62379	LBS HALL LAV/A/12	One commode sheet broken.	open	2024-08-10 06:27:20.321+00	\N	\N
88da1148-0ddc-4575-9962-50b9ec8f91f7	62382	Rubber Technology Centre	\tLeakage from the urinal basin. pl. do the needful.	open	2024-08-10 06:28:03.713+00	\N	\N
94555a2d-cb88-4fdb-9503-d2b66392457d	62384	BF-1/11	\tcommod cover broken	open	2024-08-10 06:28:39.777+00	\N	\N
956d908c-e2b0-43b5-b4b8-1e5b832c03ce	62386	BRAmbedker Hall-LAV-B-41	\t06 nos urinals outlet pipe are damage .need to be process	open	2024-08-10 06:29:32.592+00	\N	\N
08ce5aba-41e5-4b7f-ac4d-664e639e5d9d	62387	Azad Hall C-1st floor west bathroom	\tcommode not useable unhygienic, new commode required.	open	2024-08-10 06:30:04.841+00	\N	\N
a2601ac0-c38b-416e-b0b0-2687f77819f6	62394	Patel Hall D Bl. 2nd fl. bathroom backside	\tOutlet pipe broken and water leaking from it. Pl. do the needful.	open	2024-08-10 06:30:54.879+00	\N	\N
155ecdbb-45cd-4162-a63f-a5cbd2e16018	58984	HK-W-321 7305221689.	COMMODE SEAT BROKEN. URGENT.	open	2024-08-10 06:30:58.775+00	\N	\N
d51d28e2-d098-413a-b375-c313e8b17569	62397	BF-1/14	\t1st floor out side sanitary pipe broken	open	2024-08-10 06:31:21.487+00	\N	\N
4b94dd34-62b2-4f99-b4a1-0ec4c82d364b	58982	BRAmbedker Hall-LAV-D-12	urinal external outlet pipe is damage .treat as very urgent	open	2024-08-10 06:31:29.526+00	\N	\N
391839cb-484c-4046-a03a-017a48aa2908	62399	RR-416 9650018204.	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 06:31:48.576+00	\N	\N
db3ea250-cc0c-48cd-b08a-bdec8b301014	62398	DSK-E-423	BATHROOM CHOKED.URGENT.SANITARY PIPE CHOKED AND BROKEN. URGENT.	open	2024-08-10 06:32:17.456+00	\N	\N
1c4d596a-715b-4e97-b7a1-0bd90cb529b8	58996	SDS-219 8928567293.	bathroom choked URGENT.	open	2024-08-10 06:32:26.478+00	\N	\N
73154953-14ef-4395-ad50-f463be0f4678	58997	Azad Hall C and D Block back side.	Some toilet out let pipe leaking, need to be change URGENT.	open	2024-08-10 06:32:48.005+00	\N	\N
856b3fce-9e4e-4894-94fe-10d63e9afaac	58998	RR-215 Mob no 8388058231.	COMMODE SEAT BROKEN. URGENT.	open	2024-08-10 06:33:12.533+00	\N	\N
6f805c8c-5af2-4a98-909a-998c4b561d5f	59000	Nalanda complex north side 1st floor gents toilet	urinal waiste pipe leakage	open	2024-08-10 06:33:37.805+00	\N	\N
87eec933-f080-4675-a108-91f87793131f	62400	SN/IG B 1st floor bathroom	\tDrain chocked and water logged in the bathroom.Please treat as very urgent	open	2024-08-10 06:34:24.384+00	\N	\N
f0783d1a-6191-4f82-9bf4-34b614c2769d	62401	RR-229	COMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 06:34:50.559+00	\N	\N
48fa561f-cfe6-4056-8f33-d487f1e5c756	62405	DSK-E-206 8127066837.	\tCOMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 06:35:46.744+00	\N	\N
7a23d79b-0588-478a-9a58-e5ee6d7c95e3	62406	HK-W-515	\tCOMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 06:36:12.231+00	\N	\N
fbf7518d-859c-44c5-ac32-04864979b40f	62407	B-310	\tEmergency: kitchen External pipe broken	open	2024-08-10 06:36:42.007+00	\N	\N
7b26cc31-3d61-49ca-bcd3-4cd44df8ffbd	62410	\t2 BR 90	New fitted gratin is not set to functioning. request to fit at athe earliest please	open	2024-08-10 06:37:52.504+00	\N	\N
5a851d5f-1802-4480-8830-c78c41581a8c	59000	Nalanda complex north side 1st floor gents toilet	urinal waiste pipe leakage	open	2024-08-10 06:38:32.786+00	\N	\N
9a9477b1-ef1c-48c7-9992-7d8b17017a1c	Latter	VSRC-E-304	Kitchen drain chock	open	2024-08-10 06:38:49.727+00	\N	\N
4e2cbc6c-2d0d-4f62-a692-95250b886457	58649	BC ROY TECH HOSPITAL GF	Vendind Machine[For disposal sanitary pads] is not working	open	2024-08-10 06:39:22.458+00	\N	\N
b221f740-d827-4b70-85e9-0c5c5e0e2b12	58806	RCC bulding, E & ECE Dept	Dirty water is not passing through the drain, need to join a pipe	open	2024-08-10 06:39:52.561+00	\N	\N
48a8a3a4-cb15-4692-bcd7-a85304c65888	Latter	VSRC-1-NC-205	Bathroom chock	open	2024-08-10 06:40:30.407+00	\N	\N
253a1aee-47f6-43d2-a223-a3800ea41396	59003	LBS/LAV/B/44	Urinal outlet main hole jam	open	2024-08-10 06:40:30.896+00	\N	\N
1a8e1347-67b2-4e5d-9c78-8d119cfa6eaf	59007	B-305	BATHROOM CHOKED.	open	2024-08-10 06:40:52.729+00	\N	\N
d1e663a3-7a52-4b1a-ab82-6a049959e1cd	Latter	Ambedkar Hall A-51	Bathroom chock	open	2024-08-10 06:41:16.072+00	\N	\N
058bba3e-aa54-459e-819a-68c5cf1c3dff	59006	2 BR-93	NEW COMMODE INSTALLATION.	open	2024-08-10 06:41:27.992+00	\N	\N
c463a6b9-114d-4d75-97fa-a9e2fbba1411	59011	j.c bos Annexe bilding 2nd fioor	commode leaking	open	2024-08-10 06:41:52.656+00	\N	\N
af7c1cb5-8d73-46a3-8e6a-cf6cc4ebda32	Latter	VSRC-E-301	Bathroom chock	open	2024-08-10 06:42:07.591+00	\N	\N
41599feb-7057-450c-94d1-15a763b00ce6	62415	2BR-38, BEHIND TECH MARKET TO DOL PARK U TURN	\twater leakage from Commode	open	2024-08-10 06:42:44.794+00	\N	\N
ce744fcf-3a2a-4384-9493-115be231fe2b	62417	B 139	\tagain regarding the same complaint they didnt finished yet. pl. send them immediately.	open	2024-08-10 06:43:12.063+00	\N	\N
86364f10-3f16-4882-a4ec-47032c939947	62422	SDS-351	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 06:43:42.672+00	\N	\N
ba47fa04-f168-4634-9d17-4189b60635f5	62420	SDS-454	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 06:44:24.783+00	\N	\N
ebc31ec7-b155-4476-a3c2-e61286e07b20	62421	SDS-451	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 06:44:57.423+00	\N	\N
da7b18d0-1feb-4dd1-a9d6-8956a33b9380	62423	B block 2nd floor lavatory in RLB Hall	\tCommode is broken	open	2024-08-10 06:45:26.276+00	\N	\N
eab17e6a-621f-48da-a7b9-eae4257513a3	62424	\tIGH Hall room no B-305	Comode pipe choked Urgent	open	2024-08-10 06:45:57.164+00	\N	\N
70df292c-9e13-46b2-a2f5-15536fd11fe0	62427	LBS HALL LAV/DD/11	\tWestern commode dismantle from floor.	open	2024-08-10 06:46:29.551+00	\N	\N
785263f9-2468-4e61-b04e-c3567a2b1eda	62428	LBS HALL LAV/BC/22	\tUrinal out let socket and pipe broken.	open	2024-08-10 06:46:56.351+00	\N	\N
030e702c-c75b-4ec5-ae3a-12cc58da55dc	62429	LBS HALL LAV/D/24	\tToilet drainage blocked.	open	2024-08-10 06:47:22.15+00	\N	\N
6b17309a-c515-4c04-9b34-5b4ffcc549ce	62432	LBS HALL LAV/D/44	\tUrinal outlet pipe blocked.	open	2024-08-10 06:47:49.47+00	\N	\N
efe237fb-a868-47d0-9df9-2b79d1471522	62433	LBS HALL LAV/D/11	\tIndian pan blocked and water not passing.	open	2024-08-10 06:48:27.183+00	\N	\N
440a9882-5789-4ee3-80df-2845cd166f96	62438	SN/IG Hall B-block ground and 1st floor bathroom and foyer bathroom	Bathroom drain chocked. water is not passing.	open	2024-08-10 06:49:00.782+00	\N	\N
8751cd58-6db8-4ca8-aa3e-847f542559b4	59011	j.c bos Annexe bilding 2nd fioor	commode leaking	open	2024-08-10 06:49:10.083+00	\N	\N
c0b26c21-8219-40f2-b73d-2f413b66f55b	59013	IGH Hall room no B-209	Washroom outlet choked	open	2024-08-10 06:49:44.371+00	\N	\N
0ade738c-f93d-4c70-aeaf-de2edf687fa0	62443	JCB HALL F BLOCK GROUND FLOOR, FIRST FLOOR AND SECOND FLOOR	URINAL OUTLET PIPES ARE BROKEN NEED TO BE REINSTALL WITH NEW ONES	open	2024-08-10 06:50:00.407+00	\N	\N
6d84105b-cc51-4ddf-894b-6d9d21888287	59014	Alumni Guest House	AGH 1,3,8 rooms duck jan, blocked, need to be clear the blockage as early as possible.	open	2024-08-10 06:50:05.146+00	\N	\N
7459fc77-3f8d-4774-b7ff-75ed4007b932	62444	JCB HALL E BLOCK GUEST BATHROOM	OUTLET WALL PIPE IS CHOCKED NEED TO BE CLEANED ASAP	open	2024-08-10 06:50:35.231+00	\N	\N
5e818915-b83b-4f49-84cb-283f8039baf8	62445	LBS HALL LAV/B/54	\tToilet outlet broken.	open	2024-08-10 06:51:23.766+00	\N	\N
7e06a1ee-5d21-4d11-bdc2-2612cca80599	62451	DSK-E-512 9304115258.	COMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 06:51:56.486+00	\N	\N
390f784d-343f-4889-a3d9-50bca412b59f	62449	VS HALL B-201,202,203, 205	\tBATHROOM CHOCKED	open	2024-08-10 06:52:24.414+00	\N	\N
34f0b47d-fa29-4ebf-aef4-baa7d865fcbf	62456	VSRC-2 Gents Block	\tUrinal pipe jam at 6th floor west wing bathroom	open	2024-08-10 06:52:51.894+00	\N	\N
cd4379e6-52a7-461d-9b72-a83e8743463e	62460	\tLBS HALL LAV/D/21	\tLatrine pan over flowing.	open	2024-08-10 06:53:22.094+00	\N	\N
2e4b986a-c906-46e3-92d7-c7223ccf6e60	62461	LBS HALL LAV/DD/52 and LAV/DD/42	\tUrinal out let socket and pipe broken.	open	2024-08-10 06:53:50.478+00	\N	\N
1e3c9d84-8b2b-409d-b804-c5f5cbf22930	62462	Gokhale Hall	\tc.block.back side room.102 pipe.choke.cover.broken emergency	open	2024-08-10 06:54:25.83+00	\N	\N
3ab06d49-869a-4af2-accb-a675fbb4da21	62468	LLR Hall, B-Block Top Floor 3 nos of bathroom	All urinal pipe is damaged, please changed the pipe	open	2024-08-10 06:54:52.974+00	\N	\N
3980a608-2b76-4a90-a24c-1e9a230690c8	62470	Azad Hall ,C-first floor toilet west	\tcommode pan need to be change	open	2024-08-10 06:56:01.789+00	\N	\N
ae97aef3-1c73-4f6e-84b2-05b97fd06446	62471	Azad Hall ,C-second floor west bathroom	\tBathroom out let chocked. need cleaned asap.	open	2024-08-10 06:56:25.909+00	\N	\N
4120a5f9-1b19-4889-adea-c9e4edbaa2d4	59014	Alumni Guest House	AGH 1,3,8 rooms duck jan, blocked, need to be clear the blockage as early as possible.	open	2024-08-10 06:56:31.83+00	\N	\N
162bbaa1-8f7c-4189-a863-97681685f533	62474	Azad Hall ,C- Block ground floor	toilet tank leaking need to be repair very urgent	open	2024-08-10 06:56:49.637+00	\N	\N
12adf8aa-e1ab-40fe-b06e-1252b13f827a	59023	RR-227 9051434503	bathroom choked URGENT.	open	2024-08-10 06:56:59.742+00	\N	\N
43a406aa-560b-412a-8fb1-5fc442d4e283	62487	Computer & Informatics Centre, GENTS toilet	\tToilet urinal broken with side wall	open	2024-08-10 06:57:21.925+00	\N	\N
9a14aa10-4ed7-4c1a-a80f-691d22d68b73	59024	2BRF/5, IIT Campus	The water from latrine is draining into house and wash basin at the bathroom is blocked.	open	2024-08-10 06:57:27.838+00	\N	\N
4db7fe0f-2a6f-4d21-9c53-d199b9f921ab	62492	M S Hall-E3- 1ST FL BATHROOM	\tBathroom chocked and getting overflow. bad smell is spreading fast	open	2024-08-10 06:57:49.366+00	\N	\N
9c84936f-4dfc-4567-8dbf-f7e2d4c80951	59025	2BRF/5, IIT Campus	The commode is swinging. This needs to be fixed.	open	2024-08-10 06:58:00.869+00	\N	\N
49222983-33fe-4feb-b367-7b8a1a39f205	62493	RK HALL C-TOP WEST WASHROOM	\tDRAIN AND BATHROOM JAM NOT CLEAN	open	2024-08-10 06:58:20.51+00	\N	\N
3c999f4b-234f-4d5d-9260-99630ba1c007	59034	B 294	drain block	open	2024-08-10 06:58:22.237+00	\N	\N
094e0bff-d8b7-4d3b-9f09-52c3d2e0ef5c	62494	SDS 537	\tBATHROOM SEAT BROKEN ,URGENT	open	2024-08-10 06:58:47.014+00	\N	\N
70ac79c7-e626-424d-be89-899afdfd89bd	59032	DSK-E-219 Mob no 8225877645	Commode pipe leaking	open	2024-08-10 06:58:46.556+00	\N	\N
dde7200a-24d0-44fe-9135-9c96136a4e27	59034	B 294	drain block	open	2024-08-10 06:59:13.124+00	\N	\N
3cfd6bb8-b2c0-4e50-a1de-f68fdd9803d1	62495	SDS 538	\tSeptic tank is overflowing since march 2024. Earlier Complaint no.: 59436. Kindly repai	open	2024-08-10 06:59:33.821+00	\N	\N
94e9c5f2-1476-484c-8077-0c0b3ce21438	59036	JCB HALL F BLOCK GROUND ,1ST ,2ND, FLOOR	ALL THE URINAL PIPES ARER DEMAGED NEED TO BE REPLACED WITH NEW ONES ASAP	open	2024-08-10 06:59:41.508+00	\N	\N
851130c9-88a9-4f55-a9f0-043e5db61ad2	62497	\tM S Hall-E2-1ST FL- WASH BASIN AND TOILET WASTE PIPE	WASTE PIPE TO BE REPLACED URGENTLY.	open	2024-08-10 06:59:58.982+00	\N	\N
1c557335-46ba-4bad-9a74-b65136a06538	59038	Jcbose Annexe building toilet no T 13	one urinal pot hang urgent fixed	open	2024-08-10 07:00:05.957+00	\N	\N
0af63db3-ee36-491a-a9bd-027fc4b69ae8	59039	Sister Nivedita Hall. B BLOCK 2 ND FLOOR	UTENSIL AREA CLOGGED,URGENT	open	2024-08-10 07:00:30.716+00	\N	\N
26d49788-6340-41b0-b540-2f6314521785	62498	AB-201, Old annex building,1st floor, Chemical Engineering Dept	Sink drainage pipe broken. please take necessary action	open	2024-08-10 07:00:36.109+00	\N	\N
ad43dd53-7249-45b0-a280-a92a262e2bf2	59041	RKHALL D-TOP WEST WASH ROOM	WASH ROOM IS CHOCKED NEED YOUR HELP.	open	2024-08-10 07:00:55.378+00	\N	\N
96daf29c-b623-4c58-b8ca-202d1b6d562c	62500	\tM S Hall-mess washing area outlet	pipes are to be replaced	open	2024-08-10 07:01:06.181+00	\N	\N
76645a7e-5c5e-4965-9e2b-d860f596de26	59044	RKHALL D-BLOCK TOP FLOOR WEST SIDE	BATROOM OUTLET CHOCKED (CLOGED)	open	2024-08-10 07:01:18.866+00	\N	\N
86c20061-c946-4d09-8173-e79d5075ab48	62502	SDS-351 9593296107.	\tBATHROOM CHOKED.URGENT.	open	2024-08-10 07:01:30.221+00	\N	\N
1be4a56c-d20f-4819-8c29-c677523acaf9	59052	snvh hall	b block 2 floor shin career drean jeam	open	2024-08-10 07:01:48.651+00	\N	\N
aed9e758-a8fa-4758-91ef-c044e4decd8b	62503	SDS-232 8354893943.	\tCOMMODE SEAT IS BROKEN.URGENT.	open	2024-08-10 07:01:58.037+00	\N	\N
b560ee14-f579-4dc8-8146-6bbcd0a58c88	59059	NFA-22	Drainage net is broken and rats are coming, please rectify.	open	2024-08-10 07:02:13.227+00	\N	\N
10cd4538-1717-4603-95c8-eb6a06623a92	59061	Mess 1st floor washing area.	vertical drain pipe broken ,urgent.	open	2024-08-10 07:02:39.218+00	\N	\N
89c9f5e4-43b3-4183-b785-ad31963bec72	59062	SN/IG Hall backside of W-block	Bathroom outlet pipe is leaking .	open	2024-08-10 07:03:06.185+00	\N	\N
ca24f11c-db32-49c5-8e38-1ee4ceea3307	59065	A-134 (Block - 7), Gurukul Complex	Bathroom outlet choked.	open	2024-08-10 07:03:30.201+00	\N	\N
77b05c7e-d153-4e27-9e40-c6ff274f61e5	59040	BF 3/13	Rats entering the house. need to fix the holes. please treat as urgent	open	2024-08-10 07:03:50.993+00	\N	\N
15f6ec9f-b252-4863-828f-b8f5f1b47094	59070	Patel Hall C 2nd fl. Bathroom.	Bathroom door broken. Pl. do the needful.	open	2024-08-10 07:04:29.377+00	\N	\N
dde2cfe8-1bfd-44fa-bbb9-19b76c57e16e	59071	Patel Hall C 2nd fl. bathroom.	Pan sheet broken. Pl. do the needful.	open	2024-08-10 07:04:51.832+00	\N	\N
0c0197d8-50b0-49ee-985b-f410b4deb56b	59075	BRAmbedker Hall-LAV-D-51	02 nos Urinal pot Out-Lets are Choked.need to be Clear treat as very Urgent.	open	2024-08-10 07:05:16.504+00	\N	\N
f546d3c2-7e34-4759-abaf-94918455af7e	59077	1st Floor PTI room Jains toilet	Damage Urine Pipe Urgent take necessary action	open	2024-08-10 07:05:40.577+00	\N	\N
925ef1eb-661c-4d7e-b974-59ff08169595	59078	Alumni Guest House (A-2,A 3, and A 7)	Drain choked(URGENT)	open	2024-08-10 07:06:05.527+00	\N	\N
0142aef5-3f0e-4c84-9b05-6bc63f53fa71	59080	RKHALL D- BLOCK TOP FLOOR WEST BATHROOM	BATHROOM CHOCKED (URGENT)	open	2024-08-10 07:06:41.135+00	\N	\N
446243bb-ea01-4f06-9aac-ba17b6f27a48	59081	RKHALL E-TOP FLOOR WASHROOM	URINEL OUTLET PIPE CHOCKED	open	2024-08-10 07:07:18.59+00	\N	\N
7ca2ee64-2f40-4a65-9319-1e8b787bc219	59084	VSRC-1 A 105 & A 106	VSRC HALL OFFICE & WARDEN OFFICE PLS CHANGE BATHROOM COMMUT & COVER	open	2024-08-10 07:07:47.79+00	\N	\N
450eda5e-9b20-4a71-ad85-a558b0e37026	59098	A-103	seat cover	open	2024-08-10 07:08:35.59+00	\N	\N
85d7e9b8-be16-4189-8757-ee76657affd1	59106	LLR HALL BAND C BLOCK GROUND , 1ST FLOOR , 2 ND FLOOR	GROUND DRAIN AND OUT LET IS TOTALLY CHOCKED. URGENT	open	2024-08-10 07:09:14.381+00	\N	\N
ef9521cf-aee1-4301-8940-d86892ec33d4	59107	C1 - 117	Seat cover of one Western commode broken. Replace it.	open	2024-08-10 07:10:39.564+00	\N	\N
6adbe039-884e-4bbe-96a7-5cda8e50a577	59110	snvh hall	na block top floor washbasin out ligst pipe jam	open	2024-08-10 07:11:04.492+00	\N	\N
0aab1e9e-5fd4-4bd2-99f7-03b2bb27ee53	59113	BRAmbedker Hall-LAV-C-31	urinal PORT is damage.treat as very urgent	open	2024-08-10 07:11:33.412+00	\N	\N
2ee32160-fdf6-4b5b-bc17-80d6664a01fe	59119	vikramshila complex 1st floor gents toilet	urinal waiste line blocked	open	2024-08-10 07:12:02.22+00	\N	\N
22ab1490-f50e-44cb-a689-49819186cbac	59120	B 139	bathroom water clogged	open	2024-08-10 07:12:25.859+00	\N	\N
46b06b7b-ed4b-4ed7-8389-00f1628531cf	59121	Quarter B 77	Broken Toilet Seat	open	2024-08-10 07:13:03.147+00	\N	\N
e66455d9-184a-43c3-af18-e98bc361ccf2	59129	CSE Deptt, Annex Building	Old Complaint 57927. Six Urinal Pot exit pipes need to be changed in all 3 floors Gents toilet.	open	2024-08-10 07:13:31.939+00	\N	\N
3284eef9-d951-416c-900e-1a44efdc0ab0	59132	NFA-85	change of commode seat	open	2024-08-10 07:13:59.259+00	\N	\N
7640da93-5673-4f15-a449-1029bd43368a	59137	IGH room no B-304	Water blocked in bathroom	open	2024-08-10 07:14:30.762+00	\N	\N
3e48cd0d-0d2e-4358-8b68-9b2c999f9a29	59139	SN/IG B block Top Floor Bathroom	Drain chocked and student fallendown.Please treat as urgent	open	2024-08-10 07:15:02.29+00	\N	\N
914a5800-03ed-4e19-9e03-d0b04dec469e	59141	Ntgh kitchen staff toilet 1st floor	Indian pan jam	open	2024-08-10 07:15:31.898+00	\N	\N
367a620a-f002-4921-a6ff-cca9988e1bf3	59142	Jcbose Annexe building toilet no T 8	one commode waiste leakage	open	2024-08-10 07:15:58.09+00	\N	\N
e659039f-0aed-4fe2-8a50-1308cae457e7	59143	Sister Nivedita Hall. OA GROUND FLOOR NEW	02 seat cover broken	open	2024-08-10 07:20:03.262+00	\N	\N
bbf4f65b-dfae-4533-b392-477ab823ac61	59148	D-11 near Tech market	Commode is leaking	open	2024-08-10 07:20:37.445+00	\N	\N
6f4a7704-23b1-4f67-b54d-a05634a78935	59149	PDF Building Near VSRC	Water clogging issue in bathroom Room No 705	open	2024-08-10 07:21:04.261+00	\N	\N
607b9885-853c-45df-8010-3d9f97aac777	59152	SN/IG Hall B-block 1st floor bathroom	Bathroom drain chocked badly please treat as urgent.	open	2024-08-10 07:21:32.269+00	\N	\N
045fde1b-8ffc-4685-b094-189cfa6cfd8e	59156	H1-135	Toilet outlet pipe damaged.	open	2024-08-10 07:23:01.436+00	\N	\N
c28a4418-cd0d-498b-808c-79c4f9749f3d	59159	VSRC-2 GIRLS BLOCK -1ST FLOOR BATHROOM	DRAIN CHOCKED NEED TO BE CLEAN	open	2024-08-10 07:23:23.356+00	\N	\N
746ae310-2295-4b38-8be2-bc2a52855bc8	59164	PDF Building, 7th Floor, Room No 810, Behind of VSRC Hall, Contact No:7063593001	Basin outside pipe jam. The water not passing. Take action immediately..	open	2024-08-10 07:23:52.14+00	\N	\N
f3c38d03-a9fa-480b-9bd8-3725fce05519	59165	VSRC-1 ND 206	KITCHEN OUT PUT CHOKE	open	2024-08-10 07:24:15.475+00	\N	\N
\.


--
-- Data for Name: inven_used; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inven_used (id, user_id, comp_id, item_id, item_used, item_l, item_b, item_h, bill_id) FROM stdin;
c33b61b9-ecf2-4962-a411-af453cb8d2b9	2e229789-7943-47ec-949e-ef3a7c0174bb	ceb17417-bec2-47db-bfb1-42a7a87f139e	d96ac27b-90d2-4f6b-b8f2-6046250095ee	2.000000	2.000000	0.000000	0.000000	d8744471-19ef-4252-a8c0-326d4638514f
0f843091-0d35-45e4-b1ee-a1c8086bcf04	2e229789-7943-47ec-949e-ef3a7c0174bb	14059525-1e67-4d94-aa69-6f40dc224229	d96ac27b-90d2-4f6b-b8f2-6046250095ee	2.000000	0.000000	0.000000	0.000000	8922d8ec-6f29-4578-bf3a-d19b454139c3
3bbfe531-0363-46d8-bdf9-08cc26c90fae	2e229789-7943-47ec-949e-ef3a7c0174bb	14059525-1e67-4d94-aa69-6f40dc224229	aa5a4794-6b5f-44f9-8d41-64fad25870b8	5.600000	5.600000	0.000000	0.000000	418d7dc3-0901-46e7-ad80-7939073e3502
47884c46-1b37-4429-bcf4-5ae4e49e9955	2e229789-7943-47ec-949e-ef3a7c0174bb	a947d420-293d-4a50-aac4-e9d797104e27	380600ab-076c-4102-bae5-bebdc7c9d983	3.000000	0.000000	0.000000	0.000000	\N
ba4ad7d1-8bd3-40aa-87a7-13a5186becad	2e229789-7943-47ec-949e-ef3a7c0174bb	a947d420-293d-4a50-aac4-e9d797104e27	380600ab-076c-4102-bae5-bebdc7c9d983	3.000000	0.000000	0.000000	0.000000	\N
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory (item_id, item_name, item_qty, item_price, item_desc, item_unit) FROM stdin;
f418f9a3-7438-4ae6-b133-e47ae7f50ba1	Sanitary item	5.000000	2367.770000	Supplying,fitting and fixing UPVC,pipes class III conforming to IS : 4985-2000. (b) 250 mm dia	Mtr.
70d38f20-495b-4e3d-b9e0-8eafa2231fd7	Sanitary item	5.000000	220.480000	Supplying, fitting and fixing C.I. square jalli\n(iii) 300 mm	Each
6e9728be-fd55-443f-9fb4-bf2098062c2f	Sanitary item	30.000000	650.720000	Supply of  UPVC pipes ( B type ) & fittings conforming to IS 13592-1992\n\n\nSingle socketed 3 meter length\n\nc.160 mm	Mtr.
c3c5830e-3c01-47b6-9705-266ca728484d	Sanitary item	35.000000	375.420000	Supply of  UPVC pipes ( B type ) & fittings conforming to IS 13592-1992\nDouble socketed 3 meter length\nb.110 mm	Mtr.
3a13c9b3-40a9-4639-8a22-a46008247d96	Sanitary item	10.000000	243.130000	Supply of  UPVC pipes ( B type ) & fittings conforming to IS 13592-1992\nSingle socketed 1.8 meter length\na. 75mm	Mtr.
051a92cb-57c7-4d74-9bcb-ecf3f70c7c28	Sanitary item	10.000000	349.200000	Supply of UPVC pipes ( B type ) & fittings conforming to IS 13592-1992.\n\nSingle socketed 1.8 meter length\n\nb.110 mm	Mtr.
4a677aab-486b-4fc7-bd45-542b1fcb43e4	Sanitary item	10.000000	377.800000	\nSupply of UPVC pipes ( B type ) & fittings conforming to IS 13592-1992.\n\nDouble socketed 1.8 meter length\nb.110 mm	Mtr.
2a83eaf7-0dfa-4e36-876d-6093cc5d028b	Sanitary item	75.000000	53.630000	Labour for fitting and fixing U.P.V.C. pipes for above ground work including cost of jointing materials etc. fitting and fixing all necessary specials, cutting pipes, cutting holes in walls or R.C. floor where necessary and mending good all damages excluding the cost of masonry or concrete work, if necessary, but including the cost and fitting and fixing holder bat clamps (any floor) or for underground work including cutting trenches upto 1.5 metre and refilling the same complete as per direction of the Engineerin-charge. (Payment will be made on centre line measurement of the total pipeline including specials \nAbove ground\n\na. 75mm dia	Mtr.
fb1a9455-0b4f-44ad-92ca-15b816e06cc6	Sanitary item	255.000000	67.930000	\nLabour for fitting and fixing U.P.V.C. pipes for above ground work including cost of jointing materials etc. fitting and fixing all necessary specials, cutting pipes, cutting holes in walls or R.C. floor where necessary and mending good all damages excluding the cost of masonry or concrete work, if necessary, but including the cost and fitting and fixing holder bat clamps (any floor) or for underground work including cutting trenches upto 1.5 metre and refilling the same complete as per direction of the Engineerin-charge. (Payment will be made on centre line measurement of the total pipeline including specials \nAbove ground 110 mm dia	Mtr.
9de36f25-9122-4294-b8dc-1d2629869c7c	Sanitary item	15.000000	78.660000	Labour for fitting and fixing U.P.V.C. pipes for above ground work including cost of jointing materials etc. fitting and fixing all necessary specials, cutting pipes, cutting holes in walls or R.C. floor where necessary and mending good all damages excluding the cost of masonry or concrete work, if necessary, but including the cost and fitting and fixing holder bat clamps (any floor) or for underground work including cutting trenches upto 1.5 metre and refilling the same complete as per direction of the Engineerin-charge. (Payment will be made on centre line measurement of the total pipeline including specials \nAbove ground\n\n\nc. 160 mm dia	Mtr.
9f417612-355d-41bf-95ba-3c4cbcfce7ea	Sanitary item	15.000000	87.000000	Labour for fitting and fixing U.P.V.C. pipes for above ground work including cost of jointing materials etc. fitting and fixing all necessary specials, cutting pipes, cutting holes in walls or R.C. floor where necessary and mending good all damages excluding the cost of masonry or concrete work, if necessary, but including the cost and fitting and fixing holder bat clamps (any floor) or for underground work including cutting trenches upto 1.5 metre and refilling the same complete as per direction of the Engineerin-charge. (Payment will be made on centre line measurement of the total pipeline including specials \n\nUnder ground\n\na. 75mm dia	Mtr.
2c8ce19a-3ff5-4ead-b9e0-81d0a0cb8892	Sanitary item	20.000000	100.110000	Labour for fitting and fixing U.P.V.C. pipes for above ground work including cost of jointing materials etc. fitting and fixing all necessary specials, cutting pipes, cutting holes in walls or R.C. floor where necessary and mending good all damages excluding the cost of masonry or concrete work, if necessary, but including the cost and fitting and fixing holder bat clamps (any floor) or for underground work including cutting trenches upto 1.5 metre and refilling the same complete as per direction of the Engineerin-charge. (Payment will be made on centre line measurement of the total pipeline including specials \n\nUnder ground\n\nb. 110 mm dia	Mtr.
389f53ad-2300-495b-8d70-63bec21db3e4	Sanitary item	25.000000	110.840000	Labour for fitting and fixing U.P.V.C. pipes for above ground work including cost of jointing materials etc. fitting and fixing all necessary specials, cutting pipes, cutting holes in walls or R.C. floor where necessary and mending good all damages excluding the cost of masonry or concrete work, if necessary, but including the cost and fitting and fixing holder bat clamps (any floor) or for underground work including cutting trenches upto 1.5 metre and refilling the same complete as per direction of the Engineerin-charge. (Payment will be made on centre line measurement of the total pipeline including specials \n\nUnder ground\n\nc. 160 mm dia	Mtr.
74df5509-0d87-4d10-af7b-3129b26e9913	Sanitary item	5.000000	7.150000	Door gasket 75 mm	Each
e828a904-9212-46f5-b122-fbe90368631f	Sanitary item	20.000000	39.330000	Supply of UPVC fittings (B Type) conforming to IS – 13592-1992 e) 110mm Vent Cowl	Each
c83158de-8009-4eaf-9e3b-4bb794b4ff82	Sanitary item	5.000000	19.070000	Supply of UPVC fittings (B Type) conforming to IS – 13592-1992 75 mm pipe clip	Each
7edd7ac5-2855-41d5-a54b-63cc7d8886d4	Sanitary item	20.000000	485.060000	Supply of UPVC fittings (B Type) conforming to IS – 13592-1992 g) Passover 110 mm	Each
becfd610-1ba2-4573-a718-91184776d9f5	Sanitary item	5.000000	411.170000	Double Y with Door 110 mm	Each
8e2e366e-2895-4777-89a3-2b1b5ef7071c	Sanitary item	5.000000	284.840000	Cross Tee with door 110 mm	Each
f44da409-3b53-4194-b2c6-95e2230e56cf	Sanitary Item	15.000000	1693.550000	Supplying, fitting and fixing E.W.C. in white glazed vitreous chinaware of\napproved make complete in position with necessary bolts, nuts etc.\n\n(a) With P trap	Each
006573b4-91e1-416a-b66f-096353d35a47	Sanitary Item	15.000000	1802.000000	Supplying, fitting and fixing E.W.C. in white glazed vitreous chinaware of approved make complete in position with necessary bolts, nuts etc. \n\n(b) With S trap	Each
3a2e4504-e97c-4cc6-9e3b-6251bd4d973d	Sanitary Item	25.000000	3699.350000	Supplying, fitting and fixing Anglo-Indian W.C. in white glazed vitreous china ware of approved make complete in position with necessary bolts,\nnuts etc.\n\n(a) With P trap (with vent)	Each
e8be73d4-5c53-4b66-ad48-72d9b4ffc0f4	Sanitary Item	35.000000	3917.450000	Supplying, fitting and fixing Anglo-Indian W.C. in white glazed vitreous china ware of approved make complete in position with necessary bolts, nuts etc. (a) With S trap (with vent)	Each
d96ac27b-90d2-4f6b-b8f2-6046250095ee	Sanitary item	16.000000	88.190000	Supplying, fitting & fixing Aluminium domical grating.\n(i) 150 mm 	Each
aa5a4794-6b5f-44f9-8d41-64fad25870b8	Sanitary item	214.400000	348.010000	Supply of  UPVC pipes ( B type ) & fittings conforming to IS 13592-1992\n\nSingle socketed 3 meter length\n\nb.110 mm	Mtr.
380600ab-076c-4102-bae5-bebdc7c9d983	Sanitary item	694.000000	58.400000	Supplying, fitting & fixing Aluminium domical grating.\n(ii) 100 mm	Each
0b32c1d9-eb19-4141-a8ba-a1173adbfdf3	Sanitary Item	8.000000	1129.830000	Supplying,fitting and fixing cast iron P or S trap conformimg to I.S.3989/ 2009 and 1729/ 2002 including lead caulked joints and painting two coats to the exposed surface. (Painting to be paid seperately). \n\ni) P Trap 100 mm	Each
0e537ba9-219e-4bb5-85f4-d6f63ae349ef	Sanitary Item	8.000000	957.020000	Supplying,fitting and fixing cast iron P or S trap conformimg to I.S.3989/ 2009 and 1729/ 2002 including lead caulked joints and painting two coats to the exposed surface. (Painting to be paid seperately). i) S Trap 100 mm	Each
60a7fc26-2156-40c6-8724-7c9aeb70f36f	Sanitary Item	10.000000	103.690000	Scraping the hard scum of S trap carefully to render the flushing flow easy after soaking with strong acid through W.C. pan on floor and also cleaning through flanged junction door underneath the ceiling including necessary scafolding and resetting the flanged door watertight by putty joints by methor labour.\n\n	Each
83f8aac2-f846-477f-92b0-589524d831d6	Sanitary item	150.000000	571.000000	Providing and fixing solid plastic seat with lid for pedestal type W.C.pan complete :White solid plastic seat with lid	Each
2c206b4e-5de6-475a-9f5e-8c7a950c4d0a	Sanitary item	5.000000	44.100000	Door Cap: 75mm	Each
c9cbc0a8-db73-4402-ab81-9904e3b410a6	Sanitary item	10.000000	60.780000	Door Cap: 110 mm	Each
fbedd364-b269-4e45-b5ee-b097c77822b9	Sanitary item	1.000000	450.600000	Black solid plastic seat with lid	Each
9014a307-b9b8-4f49-9019-d88cc2b41e8e	Sanitary item	1.000000	557.650000	Coloured (other than black & white) solid plastic seat with lid	Each
a5fca51e-c073-40ff-817a-7f574cb6fa47	Sanitary item	10.000000	395.100000	Dismantling C.I Pipes including excavation and refilling trenches after taking out the pipes, manually /by mechanical means breaking lead caulked joints, melting of lead, and making into blocks including stacking of pipes & lead, at site within 50 metre lead as per direction of Engineer In Charge. Above 150mm dia upto 300 mm dia	Mtr.
e1761a68-98be-4fd3-997d-03c105e329fd	Sanitary item	20.000000	96.000000	Dismantling W.C. Pan of all sizes including disposal of dismantled materials i/c malba all complete as per directions of Engineer-in- Charge.	Each
ffad95b3-ad3e-4666-b467-4df13790fdfc	Sanitary item	80.000000	53.630000	Dismantling E.P. or Anglo-Indian W.C. 	Each
0df66189-a69b-4531-be63-b2184fa1eb9f	Sanitary item	10.000000	53.630000	Dismantling Orissa pattern W.C. including taking out of base concrete, if necessary, complete.\n	Each
e2739676-14e4-417c-9768-b75663183c5d	Sanitary item	80.000000	39.330000	Dismantling urinal. 	Each
87014b21-ea71-407a-9931-59ca9e85b0d0	Sanitary item	399.000000	20.260000	Dismantling flush pipe of water closet	Each
99e2b86b-4476-43da-8625-ca1f11671641	Sanitary item	40.000000	26.220000	Refixing flush pipe of water closet	Each
492ab803-6a8b-43bb-95f1-08dd1ec6f035	Sanitary item	11.000000	21.450000	.Dismantling Foot rest for Indian pattern water closet	No
cefc8f27-be53-4ca1-926c-a741ce77dd81	Sanitary item	11.000000	23.840000	Refixing Foot rest for Indian pattern water closet	No
51bc4123-a6d0-4a31-947c-f4e99562b2e5	Sanitary item	70.000000	104.880000	Refixing E.P. or Anglo-Indian W.C.	Each
14a41f9e-e91a-4aa1-8642-ad0ed6217eaf	Sanitary item	10.000000	104.880000	Refixing Orissa pattern W.C. Including cost of base concrete, if necessary,\ncomplete. Payment of concrete to be paid seperatly.	Each
0946172e-34ab-41c3-bfae-4069fa1c6ebe	Sanitary item	70.000000	41.710000	Refixing urinal.	Each
081cab7a-d746-4b3a-b304-74ec7e0c8350	Sanitary item	20.000000	53.630000	Dismantling Indian W.C. including taking out base concrete as necessary.	Each
5c509add-dc76-48c0-8f65-09eec25c64e2	Sanitary item	10.000000	83.430000	Refixing Indian W.C. excluding cost of base concrete if necessary complete.	Each
538af031-82ee-48f5-af30-6ab859814fb3	Sanitary item	2.000000	1469.900000	Demolishing brickwork manually/ mechanical means including stacking of serviceable material and disposal of unserviceable materials within 50 metres lead as per direction of Engineer -In-Charge. 	Cum
ea1e42b3-821a-4306-874e-f77f20bbbbfc	Sanitary item	2.000000	1737.450000	Nominal concrete 1:3:6 or richer mix ( i/c equivalent design  mix )	Cum
12a7e966-4bb9-4fe8-b6da-9b2016b8c795	Sanitary item	1.000000	1072.800000	Nominal concrete 1:4:8 or leaner mix ( i/c equivalent design  mix )	Cum
f385cbdf-37b6-41a6-bbee-0462824b0d1f	Sanitary item	10.000000	299.050000	Dismantling C.I Pipes including excavation and refilling trenches after taking out the pipes, manually /by mechanical means breaking lead caulked joints, melting of lead, and making into blocks including stacking of pipes & lead, at site within 50 metre lead as per direction of Engineer In Charge. (upto 150 mm)	Mtr.
a53e3198-b743-4181-94a2-a8eac73b0329	Sanitary item	5.000000	515.450000	Above 300 mm dia	Mtr.
b342ec91-0c4f-4f79-934d-6015d02790f4	Sanitary item	50.000000	83.500000	Steel reinforcement for R.C.C. work including straightening, cutting,bending, placing in position and binding all complete upto plinth level Thermo-Mechanically Treated bars of grade Fe-500D or more.	Kg
acc64143-9932-4b81-8c59-bd063727ad7d	Sanitary item	20.000000	22.640000	Cleaning I.P.W.C. with acid	Each
698c771e-0ce4-4c41-ae5f-a8fc1ae491f3	Sanitary item	20.000000	32.180000	Cleaning E.P . or Anglo-Indian W.C. with acid	Each
081cd9fb-044c-4c7c-bc79-07c9abfefcc9	Sanitary item	25.000000	23.840000	Cleaning urinal with channel with acid	Each Set
9c7bd692-67b9-4b8f-aef9-960eb75de55a	Sanitary item	11.000000	11.920000	Cleaning glazed tiles with acid.	Sqm
b2b52f89-310d-4e9f-ad61-e1763b3f0dac	Sanitary item	5.000000	214.600000	Providing and fixing a pair of white vitreous china foot rests of standard pattern for squatting pan water closet :250x130x30 mm	Pair
1ac7f238-967a-4fc3-8da2-9e9fa0dcfd0c	Sanitary item	5.000000	214.600000	Providing and fixing a pair of white vitreous china foot rests of standard pattern for squatting pan water closet :250x125x25 mm	Pair
7a6d6e9f-fa7e-4524-a7bd-e27e63a5cc77	Sanitary item	5.000000	2544.500000	Providing and fixing white vitreous china water closet squatting pan\n(Indian type)\nOrissa pattern W.C. pan of size 580x440 mm	Each
177662be-c85b-417d-a2cf-d737c7221dbc	Sanitary item	1.000000	842.900000	Extra for using coloured W.C. pan instead of white W.C. pan\nOrissa pattern W.C. pan of size 580x440 mm\n	Each
d852a000-363e-4d6d-8028-6d3eac34af33	Sanitary item	50.000000	2276.950000	Providing and fixing white vitreous china pedestal type (European type/ wash down type) water closet pan.	Each
b916fb3b-a85b-454f-8d37-681a498ca280	Sanitary item	1.000000	260.900000	Extra for using coloured pedestal type W.C pan (European type)\nwith low level cistern of same colour instead of white vitreous china\nW.C pan and cistern. 	Each
4ca8aef2-086d-45f1-9de6-34cee0536520	Sanitary item	35.000000	3537.800000	Providing & fixing White vitreous china water closet squatting pan (Indian type) along with "S" or "P" trap including dismantling of old WC seat and "S" or "P" trap at site complete with all operations including all necessary materials, labour and disposal of dismantled material i/c malba, all complete as per the direction of Engineer-in charge Orissa pattern W.C Pan of size 580x440 mm.	Each
77c58533-0121-4592-9e5a-c51ac02cd223	Sanitary item	35.000000	1299.750000	Providing and fixing white vitreous china flat back or wall corner type lipped front urinal basin of 430x260x350 mm or 340x410x265 mm sizes respectively.	Each
45a2b502-fc89-45d7-ad14-45bc3e1850d7	Sanitary item	25.000000	3419.270000	Supplying, fitting and fixing Flat back urinal (half stall urinal) in white vitreous chinaware of approved make in position with brass screws on 75mm X 75 mm X 75 mm wooden blocks complete.(i) 635 mm X 395 mm X 420 mm 	Each
c29978a8-8e40-4615-91e2-2bbf59ec7384	Sanitary item	590.000000	452.880000	Supplying, fitting and fixing Closet seat of approved make with lid and C.P. hinges, rubber buffer and brass screws complete E.W.C Plastic (hallow type) white	Each
a8a0c609-ab86-4fa0-b7fd-48d0151e4548	Sanitary item	550.000000	184.730000	Supplying,fitting and fixing 32 mm dia. Flush Pipe of approved make with necessary fixing materials and clamps complete.\ni) Polythene Flush Pipe	Each
0c4e6691-7022-449b-bd29-eb05027f5897	Sanitary item	1800.000000	101.100000	Providing and fixing P.V.C. waste pipe for sink or wash basin including P.V.C. waste fittings complete Flexible pipe 32 mm dia	Each
eb31ce0d-a66f-4a47-ae4a-42df616b8a66	Sanitary item	10.000000	101.100000	Providing and fixing P.V.C. waste pipe for sink or wash basin including P.V.C. waste fittings complete Flexible pipe 40 mm dia	Each
f872e96a-86e8-408b-a0a3-e66e4f75f5d5	Sanitary item	10.000000	1008.200000	Providing and fixing soil, waste and vent pipes 100 mm dia Sand cast iron S&S pipe as per IS: 1729\n	Metre
f51fac24-3c04-4aa1-bb91-a540c2747764	Sanitary item	85.000000	148.450000	Providing and filling the joints with spun yarn, cement slurry and cement mortar 1:2 ( 1 cement : 2 fine sand) in S.C.I./ C.I. Pipes :100 mm dia pipe.\n	Each
db0b1423-d54c-4851-b8a8-1020e5e53734	Sanitary item	8.000000	287.450000	Providing and fixing M.S. holder-bat clamps of approved design to Sand Cast iron/cast iron (spun) pipe embedded in and including cement concrete blocks 10x10x10 cm of 1:2:4 mix (1 cement : 2 coarse sand : 4 graded stone aggregate 20 mm nominal size), including cost of cutting holes and making good the walls etc. :For 100 mm dia pipe.	Each
75376bc4-5bf1-4723-926a-e389f66964bb	Sanitary item	10.000000	461.650000	Providing and fixing bend of required degree with access door, insertion rubber washer 3 mm thick, bolts and nuts complete.100 mm dia. Sand cast iron S&S as per IS - 1729 \n	Each
5608d12e-57a9-4bd4-b0b8-84756b82c8b3	Sanitary item	10.000000	381.350000	Providing and fixing plain bend of required degree. 100 mm dia,Sand cast iron S&S as per IS - 1729.	Each
0466690d-9dcb-4077-ab10-8d0e94b18e56	Sanitary item	8.000000	500.450000	Providing and fixing heel rest sanitary bend,100 mm dia,Sand cast iron S&S as per IS - 1729\n	Each
d7870c68-eab9-4ca7-b2e7-fd54ffba18bc	Sanitary item	8.000000	1016.550000	Providing and fixing double equal junction of required degree with access door, insertion rubber washer 3 mm thick, bolts and nuts complete :100x100x100x100 mm,Sand cast iron S&S as per IS - 1729\n	Each
f9249785-c004-474c-a80d-6c3696efd081	Sanitary item	8.000000	825.550000	Providing and fixing double equal plain junction of required degree.100x100x100x100 mm, Sand cast iron S&S as per IS - 1729.\n	Each
6f466688-4005-4a1a-a651-702b74eff9bd	Sanitary item	8.000000	602.150000	Providing and fixing single equal plain junction of required degree with access door, insertion rubber washer 3 mm thick, bolts and nuts complete.100x100x100 mm,Sand cast iron S&S as per IS - 1729\n	Each
9f04b565-6271-497c-be56-0dc940c488a7	Sanitary item	8.000000	517.850000	Providing and fixing single equal plain junction of required degree :100x100x100 mm,Sand cast iron S&S as per IS - 1729 .\n	Each
a06eeb05-57c0-4c55-91fa-2d950fc57afe	Sanitary item	8.000000	695.800000	(i) Providing and fixing door piece, insertion rubber washer 3mm thick, bolts & nuts complete :100 mm, Sand cast iron S&S as per IS - 1729.\n	Each
183b54a8-7724-466d-b59d-ce895bf9ab34	Sanitary item	8.000000	428.900000	(ii) Providing and fixing door piece, insertion rubber washer 3mm thick, bolts & nuts complete :75 mm, Sand cast iron S&S as per IS - 1729.\n	Each
6639e76b-0523-4edf-ad80-bf832a88a2fa	Sanitary item	20.000000	481.450000	Providing lead caulked joints to sand cast iron/centrifugally cast (spun) iron pipes and fittings of diameter :100 mm.\n	Each
e87fdd8f-cfdc-478f-ae73-c2204a94a3ec	Sanitary item	8.000000	126.500000	Providing and fixing M.S. stays and clamps for sand cast iron/ centrifugally cast (spun) iron pipes of diameter :100 mm.\n	Each
9e214a10-a045-478a-a56c-fa9c489c950d	Sanitary item	2.000000	555.300000	Cutting chases in brick masonry walls for following diameter sand cast iron/ centrifugally cast (spun) iron pipes and making good the same with cement concrete 1:3:6 ( 1 cement : 3 coarse sand :6 graded stone aggregate 12.5 mm nominal size), including necessary plaster and pointing in cement mortar 1:4 (1 cement : 4 coarse sand) :100 mm dia.\n	Metre
0d31a454-c297-479e-9a5e-0c5891954568	Sanitary item	5.000000	69.550000	Painting sand cast iron/ centrifugally cast (spun) iron soil, waste vent pipes and fittings with two coats of synthetic enamel paint of any colour such as chocolate grey, or buff etc. over a coat of primer (of approved quality) for new work :100 mm diameter pipe\n	Metre
de8b7fc1-809c-4b06-a720-94c586f4bc6a	Sanitary item	5.000000	30.950000	Repainting sand cast iron/ centrifugally cast iron (spun) iron, soil, waste, vent pipes and fittings with one coat of synthetic enamel paint of any colour such as chocolate, grey or buff etc :100 mm diameter pipe.\n	Metre
0cab69cb-7555-4a95-bb9e-f378b2118d4e	Sanitary item	1100.000000	99.750000	Providing and fixing PTMT Waste Coupling for wash basin and sink, of approved quality and colour Waste coupling 31 mm dia of 79 mm length and 62mm breadth weighing not less than 45 gms.	Each
3e428a96-1b5e-4dd7-a735-e4b8cc7ab7da	Sanitary item	5.000000	335.250000	Providing and fixing PTMT Bottle Trap for Wash basin and sink\nBottle trap 31mm single piece moulded with height of 270 mm, effective length of tail pipe 260 mm from the centre of the waste coupling, 77 mm breadth with 25 mm minimum water seal, weighing not less than 260 gms	Each
d0878c0c-d5d5-4930-8b01-b624df14d363	Sanitary item	5.000000	287.450000	Providing and fixing M.S. holder-bat clamps of approved design to Sand Cast iron/cast iron (spun) pipe embedded in and including cement concrete blocks 10x10x10 cm of 1:2:4 mix (1 cement : 2 coarse sand : 4 graded stone aggregate 20 mm nominal size), including cost of cutting holes and making good the walls etc. :\nFor 100 mm dia pipe	Each
491b4f7b-df59-4e7e-8d7c-514b7e45d02b	Sanitary item	1.000000	5421.500000	 White Vitreous china Orissa pattern W.C. pan of size 580x440 mm with integral type foot rests	Each
628e84ae-0bc9-4936-b33d-a63f350412a3	Sanitary item	1.000000	5260.950000	W.C. pan with ISI marked white solid plastic seat and lid	Each
254f652e-963e-4886-a3e4-181179f6a392	Sanitary item	30.000000	895.040000	Supplying, fitting & fixing Cast iron soil pipe only conforming to I.S. 3989/2009 and I.S. 1729/2002 with bobbins, nails etc. including making holes in\nthe wall, floor etc. and cutting trenches etc. in any floor through masonry concrete, if necessary, and mending good damages with necessary jointing materials and painting two coats to the exposed surface with approved paint complete. (Measurement will be made along the center line of the total pipe line in fitted condition including specials,payment for specials & Painting will however be paid seperately)  With lead caulked joints100 mm dia. (internal)	Metre
beeb32bf-5b4d-4f43-9924-f8e710d1ba2a	Sanitary item	10.000000	1078.580000	Supplying, fitting & fixing Cast iron single branch equal with door conforming to I.S.1729/2002 including joining and painting two coats to\nthe exposed surface with approved paint complete. (Payment of Painting\nwill however be paid seperately)  With lead caulked joints 100 mm dia	Each
e3ff81bf-97c5-46f1-ad83-eeeeacc1c3ca	Sanitary item	5.000000	769.900000	Supplying, fitting & fixing H.C.I. bend with door conforming to I.S.S. including jointing complete and painting two coats to the exposed surface with approved paint complete. (Payment of Painting will however be paid\nseperately) With lead caulked joints 100 mm dia	Each
e8473a19-7a01-4330-8974-8615abc059a1	Sanitary item	5.000000	715.080000	Supplying, fitting & fixing H.C.I. bend without door conforming to I.S.S. including jointing complete and painting two coats to the exposed surface\nwith approved paint complete. (Payment of Painting will however be paid seperately)  With lead caulked joints  100 mm dia. 	Each
81fc9a05-e3cc-4fcf-950b-2b0809d3a297	Sanitary item	5.000000	437.390000	Supplying, fitting & fixing approved patent vent cowl I.C.I. conforming to I.S.S and painting two coats to the exposed surface with approved paint\ncomplete. (Payment of Painting will however be paid seperately) 100 mm dia. 	Each
c49d326e-3e89-4cc1-a0a5-f2d21746e19a	Sanitary item	10.000000	44.600000	Providing and fixing 100 mm sand cast Iron grating for gully trap.	Each
0c9f9aca-2c18-4495-b47d-71d35be2732b	Sanitary item	10.000000	101.300000	Supplying, fitting and fixing C.I. round grating 150 mm	Each
b0950f37-abb5-4326-adca-f3da5864bae7	Sanitary item	25.000000	457.650000	Supplying, fitting and fixing PVC pipes of approved make of Schedule 80 (medium duty) conforming to ASTMD - 1785 and threaded to match with GI Pipes as per IS : 1239 (Part - I). with all necessary accessories, specials viz. socket, bend, tee……………….No separate payment will be made for accesories, specials. Payment for painting will be made seperately)\na. For exposed work \nPVC Pipes 50 mm dia	Mtr.
15298983-7893-4f10-8b7f-cec9dd305372	Sanitary item	10.000000	480.300000	Supplying, fitting and fixing PVC pipes for underground work of\napproved make of Schedule 80 (medium duty) conforming to ASTMD -1785 and threaded to match with GI Pipes as per IS : 1239 (Part - I). with all necessary accessories………………...No separate payment will be made for accessories,\nspecials.)\nPVC Pipes 50 mm dia 	Mtr.
92bb647a-bc00-47d2-8c59-a98ed6e7f2d9	Sanitary item	100.000000	257.950000	Providing and fixing double scaffolding system (cup lock type) on the exterior side, up to seven story height made with 40 mm dia M.S. tube 1.5 m centre to centre, horizontal & vertical tubes joining with cup & lock system with M.S. tubes, M.S. tube challies, M.S. clamps and M.S. staircase system in the scaffolding for working platform etc. and maintaining it in a serviceable condition for the required duration as approved and removing it there after .The scaffolding system shall be stiffened with bracings, runners, connection with the building etc wherever required for inspection of work at required locations with essential safety features for the workmen etc. complete as per directions and approval of Engineerin-charge .The elevational area of the scaffolding shall be measured for payment purpose .The payment will be made once irrespective of duration of scaffolding.Note: - This item to be used for maintenance work judicially, necessary deduction for scaffolding in the existing item to be done.	SqMtr.
9d00df69-b203-479c-a693-fafe85130ac3	Sanitary item	40.000000	334.900000	h) 110 X 110 P Trap\n75 mm 	Each
ba722296-ec36-4088-b19d-312fdb9295a8	Sanitary item	5.000000	95.340000	Reducer 110 X 75 mm\n75 mm	Each
a4e0a9aa-d913-4a2d-b9ea-d6b32a251dca	Sanitary item	5.000000	169.240000	Reducing Tee (110 X 75 mm)\n75 mm	Each
e1cb7dc9-96d6-41f0-b909-bf776d469594	Sanitary item	5.000000	471.950000	Reducing Door Tee 160 X 110 mm\n75 mm	Each
85560b63-4d60-4795-9840-efbec5ff445a	Sanitary item	20.000000	411.170000	110/110 Q Trap\n75 mm	Each
3715e7ca-3ea6-4cad-8fbb-fea7eef7961f	Sanitary item	40.000000	517.240000	i)110/110 S Trap\n75 mm	Each
4ef5bc95-5a32-4f0c-9c86-110fc080bff0	Sanitary item	5.000000	28.600000	Round Jali\n75 mm	Each
95615b5a-c8d7-48f0-b55c-f8cb041ca927	Sanitary item	5.000000	87.000000	Supplying, fitting and fixing C.I. square jalli\n(i) 100 mm	Each
94e03e73-a1e2-4e47-8a2f-bfb0672e7af6	Sanitary item	5.000000	121.560000	Supplying, fitting and fixing C.I. square jalli\n(ii) 150 mm	Each
2e8df504-4510-4ecd-9c56-fa0d1401a6de	Sanitary item	50.000000	233.590000	Supply of  UPVC pipes ( B type ) & fittings conforming to IS 13592-1992\n\nSingle socketed 3 meter length\na. 75mm	Mtr.
42cfcc35-3c09-4c98-9cad-229054344b35	Sanitary item	20.000000	251.470000	Supply of  UPVC pipes ( B type ) & fittings conforming to IS 13592-1992\n\nDouble socketed 3 meter length\n\na. 75mm	Mtr.
ac0de29e-468a-49b4-bb60-a788277dbb41	Sanitary item	10.000000	712.700000	Supply of  UPVC pipes ( B type ) & fittings conforming to IS 13592-1992\n\nDouble socketed 3 meter length\n\nc.160 mm	Mtr.
7f16603f-1c41-4612-97af-48430b73958d	Sanitary item	10.000000	250.280000	Supply of UPVC pipes ( B type ) & fittings conforming to IS 13592-1992.\n\nDouble socketed 1.8 meter length\na. 75mm	Mtr.
ebe21407-a7c3-4c6a-a7b7-b1ab5be42799	Sanitary item	5.000000	1566.160000	Supplying,fitting and fixing UPVC,pipes class III conforming to IS : 4985-2000.\n\n(a) 200 mm dia	Mtr.
6fa13b93-7e91-40a0-aa84-fe5626fa4ad2	Sanitary item	70.000000	101.300000	Supply of UPVC fittings (B Type) conforming to IS – 13592-1992 110mm plain Tee	Each
f094acce-4481-4647-a76a-cc0c367ff9a5	Sanitary item	5.000000	54.820000	Supply of UPVC fittings (B Type) conforming to IS – 13592-1992 75mm plain Tee	Each
20778458-8b8c-4c9a-af84-8ef204c5a636	Sanitary item	70.000000	232.400000	Supply of UPVC fittings (B Type) conforming to IS – 13592-1992 110 mm door Tee	Each
b56a10ba-f2b1-4607-b9bd-cb8eafb014da	Sanitary item	5.000000	120.370000	Supply of UPVC fittings (B Type) conforming to IS – 13592-1992 75mm door Tee	Each
63a77c42-0e91-4549-a881-96d41ce5b2ab	Sanitary item	40.000000	143.020000	Supply of UPVC fittings (B Type) conforming to IS – 13592-1992 c)110 mm Bend 87.5	Each
03e1f790-29b9-450a-bf7d-8f285ecdd83d	Sanitary item	70.000000	175.190000	Supply of UPVC fittings (B Type) conforming to IS – 13592-1992 d) 110 mm Door bend (T.S)	Each
e5f471ea-d196-4b22-b562-d70aac83339c	Sanitary item	5.000000	72.700000	Supply of UPVC fittings (B Type) conforming to IS – 13592-1992 75 mm bend 87.5	Each
3ff6a4cc-d36f-4160-a66f-491eaf64a7c4	Sanitary item	5.000000	98.920000	Supply of UPVC fittings (B Type) conforming to IS – 13592-1992 75 mm Door bend	Each
506cd006-c194-4c8b-9656-fc7788266946	Sanitary item	5.000000	29.800000	Supply of UPVC fittings (B Type) conforming to IS – 13592-1992 75 mm Vent cowl	Each
8f910c94-8ee0-47a4-a464-cc7cce720c6f	Sanitary item	70.000000	25.030000	Supply of UPVC fittings (B Type) conforming to IS – 13592-1992 f) 110mm Pipe Clip	Each
6c707ca7-52a6-42c6-a275-159cd88e4339	Sanitary item	5.000000	339.660000	Supply of UPVC fittings (B Type) conforming to IS – 13592-1992 Passover 75mm	Each
d5abe556-8343-446f-8b07-22425644246a	Sanitary item	5.000000	121.560000	Plain Y 75mm 	Each
792cca9b-a21a-484d-96d0-71932b52e29f	Sanitary item	5.000000	245.510000	Plain Y 110 mm	Each
a8d02bc7-908d-4ccd-af1e-2d4630ff0c04	Sanitary item	5.000000	166.850000	Door Y LH & RH 75mm 	Each
3a76a3ce-14fe-4b1e-a10c-258f4938fefe	Sanitary item	5.000000	328.940000	Door Y LH & RH 110 mm	Each
67fcbf00-1282-4d67-a178-9545fc63f07f	Sanitary item	5.000000	178.770000	Double Y 75mm 	Each
38d59d1b-4c51-4116-8feb-2d6f547417b6	Sanitary item	5.000000	326.550000	Double Y 110 mm	Each
b93810c1-81f8-4389-8c1e-c39b28532d65	Sanitary item	5.000000	256.240000	Double Y with Door 75mm 	Each
9ea2b2de-7591-46fd-a236-33ea39c2e2dd	Sanitary item	5.000000	64.360000	Bend 45 \n75mm 	Each
83621ab4-7451-4dc6-a18f-1ac90e7850fa	Sanitary item	5.000000	172.810000	Cross Tee 75 mm	Each
9f7208e3-fee1-46b6-a62f-f5f3bfff4bd0	Sanitary item	5.000000	106.070000	Bend 45 110 mm	Each
0b5bbf50-e4a2-48f1-9476-aa274401a50d	Sanitary item	5.000000	221.670000	Cross Tee 110 mm	Each
e10dfd21-fad7-4fd7-ba85-5e2843bf0d0f	Sanitary item	5.000000	257.430000	Cross Tee with door 75 mm	Each
60532557-52e8-40e6-a722-891e98cc9c8f	Sanitary item	5.000000	222.870000	Rubber lubricant	500 ml
366c4c4d-8493-46af-81ca-713527265d82	Sanitary item	5.000000	122.760000	Solvent Cement	250 ml
5c266c83-5709-4e36-8c36-a99315247c63	Sanitary item	10.000000	171.620000	Plain Floor Trap with Top tile & Strainer\n75 mm	Each
c4886568-e603-4781-84e1-b745117b54f2	Sanitary item	10.000000	203.800000	Multi Floor Trap with Top tile & Strainer\n75 mm	Each
0576942d-88b4-4273-a1f4-d79058dafc40	Sanitary item	10.000000	117.800000	a. Coupler 110 mm	Each
3974b7f2-3a98-4936-92da-c9a2cd5de717	Sanitary item	10.000000	110.600000	b. Single pushfit coupler	Each
d6b6fdd0-f4e2-4b1c-a067-a0f9d08a16f2	Sanitary item	15.000000	203.300000	c. Single tee with door 110 x 110 x 110 mm	Each
64861b37-aa52-4890-adb3-14ab7ae84a4d	Sanitary item	15.000000	188.550000	d. Single tee without door 110 x 110 x 110 mm	Each
a211ae38-7930-4f6e-b937-029653a11fc6	Sanitary item	50.000000	129.850000	e. Bend 87.5°- 110 mm bend	Each
2264c85c-99ed-40cf-9bd6-e96467addf14	Sanitary item	25.000000	113.800000	f. Shoe plain 110 mm shoe	Each
da7e4f7e-b49f-4571-8785-3760efccda24	Sanitary item	300.000000	30.990000	Removing chokage of Water closet	Nos
41dec4f4-f421-42f2-b651-5e0b05f7a0c4	Sanitary item	2200.000000	30.990000	Removing chokage of urinal and waste trap.	Nos
ce36d5bd-5295-4283-8832-07b4f60ba385	Sanitary item	5.000000	97.730000	Repairing C.P. hinges of W.C. seat.	Each
a3a102d5-2d56-496e-945e-147fb3b793ec	Sanitary item	5.000000	97.730000	Repairing W.C. seat with brass plate and screws.	Set
626bfbbe-eea2-4245-a048-74ab1554a18e	Sanitary item	15.000000	46.480000	Polishing W.C. seat.	Set
3eb48d84-bd6d-472f-a3c7-6b2c3f377ec0	Sanitary item	20.000000	46.480000	Rectifying leakage of W.C. by new joints by methor mistry.	Each
685b032e-fc00-492e-87a1-1ffe4e7ef045	Sanitary item	10.000000	21.450000	Renewing rubber buffer with brass screws.	Each
e4d3dcbb-d036-4649-80fa-77a1a4175c2d	Sanitary item	600.000000	100.110000	Renewing door of H.C.I. bend or junction with new bolts and nuts including taking out.`	Set
0dd99d98-6121-43ae-95cd-3fbc424a32de	Sanitary item	100.000000	76.280000	Dismantling H.C.I. pipe with fittings including melting lead caulked joints. 100 mm dia	Mtr.
f7411354-ed14-4284-98ac-505960ed0490	Sanitary item	80.000000	84.620000	Refixing H.C.I. pipe with fittings including lead caulked joints (with the old molten lead ) 100mm dia	Mtr.
a51e62aa-5695-4210-bb42-226327b60d30	Sanitary item	10.000000	123.950000	(i) In brick work [Cement-4.0 Kg/Mtr] 	Each
ae50e156-872c-4afa-b1f7-49cff6fb992d	Sanitary item	5.000000	156.130000	(ii)  In concrete work (plain or R.C.) [Cement- 3.0 Kg/Mtr].	Each
09b64589-0cab-42f6-98cb-edf374b4f8c1	Sanitary item	70.000000	327.250000	Cutting holes up to 30x30 cm in walls including making good the same:\nWith common burnt clay F.P.S. (non modular) bricks	Each
b7735ecf-5fa2-400d-83b1-e5267227f14d	Sanitary item	5.000000	344.600000	Cutting holes up to 15x15 cm in R.C.C. floors and roofs for passing drain pipe etc. and repairing the hole after insertion of drain pipe etc. with cement concrete 1:2:4 (1 cement : 2 coarse sand : 4 graded stone aggregate 20 mm nominal size), including finishing complete so as to make it leak proof.	Each
01a700b8-98d0-4289-85a5-6a3ae1d3a084	Sanitary item	28.000000	252.300000	Earth work in excavation by mechanical means (Hydraulic excavator) / manual means in foundation trenches or drains (not exceeding 1.5 m in width or 10 sqm on plan), including dressing of sides and ramming of bottoms, lift upto 1.5 m, including getting out the excavated soil and\ndisposal of surplus excavated soil as directed, within a lead of 50 m. All kinds of soil.	Cu.M
1f7b7b51-1d3b-4bdf-a5ef-98c1202c8e1a	Sanitary item	5.000000	364.200000	Excavating trenches of required width for pipes, cables, etc including excavation for sockets, and dressing of sides, ramming of bottoms, depth upto 1.5 m, including getting out the excavated soil, and then returning the soil as required, in layers not exceeding 20 cm in depth, including consolidating each deposited layer by ramming, watering, etc. and\ndisposing of surplus excavated soil as directed, within a lead of 50 m :All kinds of soilPipes, cables etc. exceeding 80 mm dia. but not exceeding 300 mm dia	Mtr.
b77ec129-823b-42bc-93e4-98c7f78387be	Sanitary item	5.000000	352.450000	Earthwork in excavation by mechanical means ( Hydraulic excavator/ manual means ) over areas exceeding 30 cm in depth ,1.5 m in width as well as 10 sqm on plan ) including getting out and disposal of excavated earth lead upto 50m and lift upto 1.50m as directed by Engineer In Charge.\nOrdinary rock.	Cu.M
1a198ac7-8907-4e7d-bcfb-408f36483abf	Sanitary item	5.000000	1953.050000	Supplying and filling in plinth with sand under floors, including watering,ramming, consolidating and dressing complete.	Cu.M
24961c29-e2f6-4822-996e-bc93fd4f0ac1	Sanitary item	1.000000	3677.150000	Cutting road and making good the same including supply of extra quantities of materials i.e aggregate, moorum screening, red bajri and labour required.\nBituminous portion	Cum
9dcc4763-7d87-4a86-84f4-c253632955c2	Sanitary item	3.000000	6259.100000	Providing and laying in position cement concrete of specified grade excluding the cost of centering and shuttering - All work up to plinth level :1:3:6 (1 Cement : 3 coarse sand (zone-III) : 6 graded stone aggregate 20 mm nominal size).	Cu.M
87ab2710-5ec6-40a9-98ea-80e1642f4475	Sanitary item	1.000000	6788.600000	Providing and laying in position cement concrete of specified grade excluding the cost of centering and shuttering - All work up to plinth level :"1:2:4 (1 cement : 2 coarse sand (zone-III) : 4 graded stone aggregate 20 mm nominal size).	Cu.M
827bb0b6-c5b6-49c0-b346-35a43a777030	Sanitary item	1.000000	7210.550000	Providing and laying in position cement concrete of specified grade excluding the cost of centering and shuttering 1:1½:3 (1 Cement: 1½ coarse sand (zone-III) : 3 graded stone aggregate 20 mm nominal size).	Cu.M
463daeee-5655-46b5-8914-2ba0d17ddc8c	Sanitary item	27.000000	219.650000	Filling available excavated earth (excluding rock) in trenches, plinth, sides of foundations etc. in layers not exceeding 20cm in depth, consolidating each deposited layer by ramming and watering, lead up to 50 m and lift upto 1.5 m.	Cu.M
731034fb-9c8b-47da-a83b-9118507d3fde	Sanitary item	25.000000	39.000000	Dismantling old plaster or skirting raking out joints and cleaning the surface for plaster including disposal of rubbish to the dumping ground within 50 metres lead.	Sq.M
0e71a4de-4f68-46e4-b393-7dd302d68d08	Sanitary item	5.000000	284.850000	Centering and shuttering including strutting, propping etc. and removal of form for all heights :Foundations, footings, bases of columns, etc. for mass concrete	Sq.M
a625a715-8f8e-40f7-b25d-4407cb84f081	Sanitary item	2.000000	6407.350000	Brick work with modular extruded brunt fly ash clay sewer bricks (Conforming to IS: 4885 ) in cement mortar 1:4 (1 cement : 4 coarse sand) in foundation and plinth :\nCement Mortar 1:4 ( 1 cement : 4 coarse sand)	Cu.M
6d4259a4-a5de-4b4c-a74d-149f8f754bf5	Sanitary item	2.000000	917.000000	Half brick masonry with common burnt clay F.P.S. (non modular) bricks\nof class designation 7.5 in foundations and plinth in :	Cu.M
6ab9d58a-cc5f-4fbf-9662-9d924980307f	Sanitary item	20.000000	59.590000	(a) Small plant of girth of exposed stem upto 75 mm. lift upto 6 mtr.	Each
a932fc9a-aebd-4654-9ce3-98cdfb34407c	Sanitary item	5.000000	147.780000	WC Ring: 110 mm	Each
3134acf7-51a7-4272-85c1-6267b0d7a745	Sanitary item	5.000000	9.530000	Door gasket 110 mm	Each
2003c63e-6fdb-4e7b-9a98-10a4b2838095	Sanitary item	5.000000	16.690000	Rubber Ring 75mm	Each
bb7526fa-5d5c-44c0-b315-31adb35bc66a	Sanitary item	5.000000	20.260000	Rubber Ring 110 mm	Each
7c640aed-89b8-4667-bf87-083312885c94	Sanitary item	20.000000	125.140000	Nahani Trap 90 mm	Each
c9233f60-1d87-4565-8bd1-5a61973cb0e5	Sanitary item	15.000000	71.510000	b) Medium size plant of girth of exposed stem above 75 mm. but not exceeding 150 mm. lift upto 6 mtr.	Each
20f9d669-7b66-444a-89e3-b09daaea7a26	Sanitary item	5.000000	222.870000	(c) Large plant of girth of exposed stem above 150 mm. but not exceeding 225 mm. lift upto 6 mtr.	Each
dd99db06-17ef-45d8-9a83-2516bd67f4a5	Sanitary item	10.000000	318.950000	i)15 mm cement plaster on rough side of single or half brick wall of mix  1:4            (1 cement: 4 coarse sand)	Sq.M
dbacdcd2-d0b3-4d1f-85e8-612928d8bf4a	Sanitary item	10.000000	379.700000	 ii)20 mm cement plaster of mix  1:4         (1 cement: 4 coarse sand)	Sq.M
f16ee213-b987-4ea2-b2c9-45d485296d69	Sanitary item	20.000000	62.750000	Neat cement punning.\n	Sq.M
2bc8767e-fb49-4deb-8e31-3251de73a417	Sanitary item	6.000000	390.910000	Artificial stone in floor, dado, staircase etc with cement concrete (1:2:4) with stone chips, laid in panels as directed with topping made with ordinary or white cement (as necessary) and marble dust in proportion (1:2) including smooth finishing and rounding off corners including raking out joints or roughening of concrete surface and application of cement slurry before flooring works using cement @ 1.75 kg/Sq.M all complete including all materials and labour. In ground floor, 3 mm. thick topping (High polishing grinding on this item is not permitted with ordinary cement). Using grey cement. 35 mm thick.	Sq.M
9a8f9d39-1c17-45fa-a5dc-b65af2ce6cd0	Sanitary item	3.000000	3207.500000	Providing and fixing white vitreous china squatting plate urinal with integral rim longitudinal flush pipe.	Each
19cd3669-7957-4556-9d12-cc6d045bda77	Sanitary item	65.000000	448.120000	Mazdoor (Male) / Labour (Male) for necessary day to day work at necessary places as per direction of engineer in charge  in any floor complete in all respect. 	Nos
502368a1-a5d8-4b78-a98c-f3e626f3e5f9	Sanitary item	500.000000	10.730000	Removing chokage of H.C.I. or S.W. pipe with split bamboo.  Over ground\n	Metre
a31f0e84-20ce-49bd-be4f-756a0de33261	Sanitary item	5.000000	54.850000	Dismantling tile work in floors and roofs laid in cement mortar including stacking material within 50 metres lead.For thickness of tiles 10 mm to 25 mm	Sq.m
4e9d56e9-6999-4cd3-b7ba-5f02b4bacc52	Sanitary item	5.000000	926.900000	Providing and laying Ceramic glazed floor tiles of size 300x300 mm (thickness to be specified by the manufacturer) of 1st quality conforming to IS : 15622 of approved make in colours such as White, Ivory, Grey, Fume Red Brown, laid on 20 mm thick cement mortar 1:4 (1 Cement : 4 Coarse sand), Jointing with grey cement slurry @ 3.3 kg/sqm including pointing the joints with white cement and matching pigment etc., complete.	Sq.m
356c2905-d6a8-4379-837f-20a4970cc7dd	Sanitary item	5.000000	927.900000	Providing and fixing 1st quality ceramic glazed floor tiles conforming to IS : 15622 (thickness to be specified by the manufacturer ) of approved make in all colours, shades except burgundy, bottle green, black of any size as approved by Engineer-in-Charge in skirting, risers of steps and dados over 12 mm thick bed of cement Mortar 1:3 (1 cement: 3 coarse sand) and jointing with grey cement slurry @ 3.3kg per sqm including pointing in white cement mixed with pigment of matching shade complete.	Sq.m
d92f07c5-b8e9-4799-98d1-03a0a664131b	Sanitary item	5.000000	996.700000	Providing and laying Ceramic glazed floor tiles of size 300x300 mm (thickness to be specified by the manufacturer), of 1st quality conforming to IS : 15622, of approved make, in all colours, shades, except White, Ivory, Grey, Fume Red Brown, laid on 20 mm thick bed of cement mortar 1:4 (1 Cement : 4 Coarse sand), jointing with grey cement slurry @ 3.3 kg/ sq.m including pointing the joints with white cement and matching\npigments etc., complete.	Sq.m
859848da-3d6d-4ed4-aca6-abb03336d13a	Sanitary item	3.000000	13852.450000	Providing and fixing white vitreous china extended wall mounting water closet of size 780x370x690 mm of approved shape including providing & fixing white vitreous china cistern with dual flush fitting, of flushing capacity 3 litre/ 6 litre (adjustable to 4 litre/ 8 litres), including seat cover, and cistern fittings, nuts, bolts and gasket etc complete.	Each
af3f18d1-57d7-4f69-89ef-64668ae61eaf	Sanitary item	1.000000	16868.150000	Providing & fixing white vitreous china water less urinal of size 600 x330 x 315 mm having antibacterial /germs free ceramic surface,fixed with cartridge having debris catcher and hygiene seal.	Each
f58bf5a9-5d70-4954-a501-26129635ae47	Sanitary item	1.000000	6913.900000	Providing and fixing white vitreous china battery based infrared sensor operated urinal of approx. size 610 x 390 x 370 mm having pre & post flushing with water (250 ml & 500 ml consumption), having water inlet from back side, including fixing to wall with suitable brackets all as per manufacturers specification and direction of Engineer-in-charge.	Each
19480998-4283-4425-abe7-b516801609e8	Sanitary item	1.000000	15457.950000	Providing and fixing floor mounted, white vitreous china single piece, double traps syphonic water closet of approved brand/make, shape, size and pattern including integrated white vitreous china cistern of capacity 10 litres with dual flushing system, including all fittings and fixtures with seat cover, cistern fittings, nuts, bolts and gasket etc including making connection with the existing P/S trap, complete in all respect as per directions of Engineer-in-Charge.	Each
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, username, pswd, role) FROM stdin;
437b6f7c-0e18-44c1-b3af-caf7958926c2	admin123	$2a$14$py/pcq1k.Cgb8dlJTreJ8OeXCEz2yP8YY.u3wnpz/UK2BI3UZXR6K	admin
8fd7cb3a-0416-46ee-ba52-c18ebd5899bd	worker	$2a$14$wNtLGwKm0q.xVPfKdqMkxO/YBoDLh7.mUvf19qAf3EbAXC2X21dSe	worker
2e229789-7943-47ec-949e-ef3a7c0174bb	00054	$2a$14$k/AURpH3O0ogT0LqsOf2FOiHb0CWrQDKJuqdjQCj7WiJV5JPnRTxe	admin
\.


--
-- Name: bills pk_bills; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bills
    ADD CONSTRAINT pk_bills PRIMARY KEY (id);


--
-- Name: complaints pk_complaints; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.complaints
    ADD CONSTRAINT pk_complaints PRIMARY KEY (comp_id);


--
-- Name: inven_used pk_inven_used; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inven_used
    ADD CONSTRAINT pk_inven_used PRIMARY KEY (id);


--
-- Name: inventory pk_inventory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT pk_inventory PRIMARY KEY (item_id);


--
-- Name: users pk_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT pk_user PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: idx_comp_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_comp_id ON public.inven_used USING btree (comp_id);


--
-- Name: idx_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_item_id ON public.inven_used USING btree (item_id);


--
-- Name: idx_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_id ON public.inven_used USING btree (user_id);


--
-- Name: inven_used fk_bills; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inven_used
    ADD CONSTRAINT fk_bills FOREIGN KEY (bill_id) REFERENCES public.bills(id);


--
-- Name: inven_used fk_complaints; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inven_used
    ADD CONSTRAINT fk_complaints FOREIGN KEY (comp_id) REFERENCES public.complaints(comp_id);


--
-- Name: inven_used fk_inventory; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inven_used
    ADD CONSTRAINT fk_inventory FOREIGN KEY (item_id) REFERENCES public.inventory(item_id);


--
-- Name: inven_used fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inven_used
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

