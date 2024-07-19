--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE test;




--
-- Drop roles
--

DROP ROLE postgres;


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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


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
    item_l numeric NULL,
    item_b numeric NULL,
    item_h numeric NULL
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
-- Data for Name: complaints; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.complaints (comp_id, comp_nos, comp_loc, comp_des, comp_stat, comp_date, fin_datetime, fin_text) FROM stdin;
\.


--
-- Data for Name: inven_used; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inven_used (id, user_id, comp_id, item_id, item_used) FROM stdin;
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory (item_id, item_name, item_qty, item_price, item_desc, item_unit) FROM stdin;
f418f9a3-7438-4ae6-b133-e47ae7f50ba1	Sanitary item	5.000000	2367.770000	Supplying,fitting and fixing UPVC,pipes class III conforming to IS : 4985-2000. (b) 250 mm dia	Mtr.
d96ac27b-90d2-4f6b-b8f2-6046250095ee	Sanitary item	20.000000	88.190000	Supplying, fitting & fixing Aluminium domical grating.\n(i) 150 mm 	Each
380600ab-076c-4102-bae5-bebdc7c9d983	Sanitary item	700.000000	58.400000	Supplying, fitting & fixing Aluminium domical grating.\n(ii) 100 mm	Each
70d38f20-495b-4e3d-b9e0-8eafa2231fd7	Sanitary item	5.000000	220.480000	Supplying, fitting and fixing C.I. square jalli\n(iii) 300 mm	Each
aa5a4794-6b5f-44f9-8d41-64fad25870b8	Sanitary item	220.000000	348.010000	Supply of  UPVC pipes ( B type ) & fittings conforming to IS 13592-1992\n\nSingle socketed 3 meter length\n\nb.110 mm	Mtr.
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

