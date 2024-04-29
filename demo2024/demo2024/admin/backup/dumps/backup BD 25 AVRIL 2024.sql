--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

-- Started on 2024-04-25 11:21:39

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 240 (class 1255 OID 17125)
-- Name: ajout_maison3(text, text, integer, integer, integer, text, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ajout_maison3(p_titre text, p_type text, p_surface integer, p_prix integer, p_annee_construction integer, p_adresse text, p_ville text, p_cp text, p_id_agent integer, p_image text) RETURNS integer
    LANGUAGE plpgsql
    AS '
DECLARE
    id INTEGER;
    retour INTEGER;
BEGIN
    SELECT id_maison INTO id FROM Maison WHERE ville = p_ville;
    IF NOT FOUND THEN
        INSERT INTO Maison (titre_maison,type_maison, surface, prix, annee_construction, adresse, ville, cp,id_agent,image_maison)
        VALUES (p_titre,p_type, p_surface, p_prix, p_annee_construction, p_adresse, p_ville, p_cp,p_id_agent,p_image);
        SELECT id_maison INTO id FROM Maison WHERE adresse = p_adresse AND ville = p_ville;
        IF NOT FOUND THEN
            retour := -1;  -- failure
        ELSE
            retour := 1;   -- success
        END IF;
    ELSE
        retour := 0;      -- already exists
    END IF;
    RETURN retour;
END;
';


--
-- TOC entry 228 (class 1255 OID 17126)
-- Name: update_maison(integer, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_maison(integer, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '
	declare p_id alias for $1;
	declare p_champ alias for $2;
	declare p_valeur alias for $3;
BEGIN
    EXECUTE format(''UPDATE maison SET %I = %L WHERE id_maison = %L'', p_champ, p_valeur, p_id);
    -- execute format : used when fields are dynamic
    -- %I : replaces the column field, in a secure way (escape to avoid sql injections)
    -- %L : replaces the value, in a secure way
    RETURN 1;
END;
';


--
-- TOC entry 227 (class 1255 OID 17108)
-- Name: verifier_admin(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.verifier_admin(text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '
	declare p_login alias for $1;
	declare p_password alias for $2;
	declare id integer;
	declare retour integer;
	
begin
	select into id id_admin from admin where login=p_login and password = p_password;
	if not found 
	then
	  retour = 0;
	else
	  retour =1;
	end if;  
	return retour;
end;
';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 17092)
-- Name: achat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.achat (
    id_achat integer NOT NULL,
    montant integer NOT NULL,
    id_client integer NOT NULL,
    id_maison integer
);


--
-- TOC entry 225 (class 1259 OID 17091)
-- Name: achat_id_achat_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.achat_id_achat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 225
-- Name: achat_id_achat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.achat_id_achat_seq OWNED BY public.achat.id_achat;


--
-- TOC entry 218 (class 1259 OID 17048)
-- Name: admin; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin (
    id_admin integer NOT NULL,
    login text NOT NULL,
    password text NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 17047)
-- Name: admin_id_admin_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_id_admin_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 217
-- Name: admin_id_admin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_id_admin_seq OWNED BY public.admin.id_admin;


--
-- TOC entry 220 (class 1259 OID 17057)
-- Name: agent_immobilier; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_immobilier (
    id_agent integer NOT NULL,
    nom text NOT NULL,
    prenom text NOT NULL,
    n_tel integer NOT NULL,
    image_agent text,
    description text
);


--
-- TOC entry 219 (class 1259 OID 17056)
-- Name: agent_immobilier_id_agent_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_immobilier_id_agent_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 219
-- Name: agent_immobilier_id_agent_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_immobilier_id_agent_seq OWNED BY public.agent_immobilier.id_agent;


--
-- TOC entry 216 (class 1259 OID 17039)
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id_client integer NOT NULL,
    nom text NOT NULL,
    prenom text NOT NULL,
    nom_rue text NOT NULL,
    num_rue integer NOT NULL,
    num_tel integer NOT NULL,
    email text NOT NULL,
    cp integer NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 17038)
-- Name: client_id_client_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.client_id_client_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 215
-- Name: client_id_client_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.client_id_client_seq OWNED BY public.client.id_client;


--
-- TOC entry 222 (class 1259 OID 17066)
-- Name: maison; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.maison (
    id_maison integer NOT NULL,
    titre_maison text NOT NULL,
    type_maison text NOT NULL,
    surface integer NOT NULL,
    annee_construction integer NOT NULL,
    adresse text NOT NULL,
    ville text NOT NULL,
    cp text NOT NULL,
    id_agent integer NOT NULL,
    image_maison text,
    prix integer
);


--
-- TOC entry 221 (class 1259 OID 17065)
-- Name: maison_id_maison_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.maison_id_maison_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 221
-- Name: maison_id_maison_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.maison_id_maison_seq OWNED BY public.maison.id_maison;


--
-- TOC entry 224 (class 1259 OID 17080)
-- Name: visite; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.visite (
    id_visite integer NOT NULL,
    date_visite date,
    id_maison integer NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 17079)
-- Name: visite_id_visite_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.visite_id_visite_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 223
-- Name: visite_id_visite_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.visite_id_visite_seq OWNED BY public.visite.id_visite;


--
-- TOC entry 4721 (class 2604 OID 17095)
-- Name: achat id_achat; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achat ALTER COLUMN id_achat SET DEFAULT nextval('public.achat_id_achat_seq'::regclass);


--
-- TOC entry 4717 (class 2604 OID 17051)
-- Name: admin id_admin; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin ALTER COLUMN id_admin SET DEFAULT nextval('public.admin_id_admin_seq'::regclass);


--
-- TOC entry 4718 (class 2604 OID 17060)
-- Name: agent_immobilier id_agent; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_immobilier ALTER COLUMN id_agent SET DEFAULT nextval('public.agent_immobilier_id_agent_seq'::regclass);


--
-- TOC entry 4716 (class 2604 OID 17042)
-- Name: client id_client; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client ALTER COLUMN id_client SET DEFAULT nextval('public.client_id_client_seq'::regclass);


--
-- TOC entry 4719 (class 2604 OID 17069)
-- Name: maison id_maison; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.maison ALTER COLUMN id_maison SET DEFAULT nextval('public.maison_id_maison_seq'::regclass);


--
-- TOC entry 4720 (class 2604 OID 17083)
-- Name: visite id_visite; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visite ALTER COLUMN id_visite SET DEFAULT nextval('public.visite_id_visite_seq'::regclass);


--
-- TOC entry 4892 (class 0 OID 17092)
-- Dependencies: 226
-- Data for Name: achat; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.achat (id_achat, montant, id_client, id_maison) VALUES (2, 250000, 1, 2);
INSERT INTO public.achat (id_achat, montant, id_client, id_maison) VALUES (3, 180000, 2, 3);


--
-- TOC entry 4884 (class 0 OID 17048)
-- Dependencies: 218
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.admin (id_admin, login, password) VALUES (1, 'ilyes', 'ilyes');


--
-- TOC entry 4886 (class 0 OID 17057)
-- Dependencies: 220
-- Data for Name: agent_immobilier; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.agent_immobilier (id_agent, nom, prenom, n_tel, image_agent, description) VALUES (1, 'Martin', 'Luc', 987654321, 'agent1.jpg', 'Je suis un agent immobilier passionné par mon travail. Avec une expérience de 10 ans dans le domaine, je m efforce de trouver le foyer parfait pour chaque client, en mettant en avant mes compétences en négociation et en compréhension des besoins spécifiques de chaque acheteur.');
INSERT INTO public.agent_immobilier (id_agent, nom, prenom, n_tel, image_agent, description) VALUES (2, 'Dubois', 'Sophie', 123456789, 'agent2.jpg', 'En tant qu agent immobilier, mon objectif principal est de rendre le processus d achat ou de vente de votre propriété aussi fluide que possible. Avec une approche personnalisée et une connaissance approfondie du marché, je suis là pour vous guider à chaque étape du chemin.');
INSERT INTO public.agent_immobilier (id_agent, nom, prenom, n_tel, image_agent, description) VALUES (3, 'Dupont', 'Jean', 123456789, 'agent3.jpg', 'Bonjour, je suis un agent immobilier dévoué avec une passion pour le service à la clientèle. Mon approche est axée sur l écoute attentive des besoins de mes clients et la recherche de solutions créatives pour répondre à leurs attentes. Mon objectif est de rendre l expérience immobilière aussi agréable et réussie que possible.');
INSERT INTO public.agent_immobilier (id_agent, nom, prenom, n_tel, image_agent, description) VALUES (4, 'Dubois', 'Pierre', 123456789, 'agent4.jpg', 'En tant qu agent immobilier expérimenté, je m engage à offrir un service exceptionnel à mes clients. Avec une connaissance approfondie du marché local et une éthique de travail solide, je suis déterminé à vous aider à atteindre vos objectifs immobiliers, que ce soit l achat, la vente ou la location d une propriété.');
INSERT INTO public.agent_immobilier (id_agent, nom, prenom, n_tel, image_agent, description) VALUES (5, 'Durand', 'Marie', 123456789, 'agent5.jpg', 'Je suis un agent immobilier passionné par mon métier, dévoué à fournir un service client de première classe. Avec une approche proactive et une attention aux détails, je m efforce de rendre le processus d achat ou de vente de votre maison aussi simple et sans stress que possible. Vous pouvez compter sur moi pour vous guider à chaque étape du chemin.');


--
-- TOC entry 4882 (class 0 OID 17039)
-- Dependencies: 216
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (1, 'Dupont', 'Jean', 'Rue de la Paix', 123, 123456789, 'jean.dupont@email.com', 75001);
INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (2, 'Durand', 'Marie', 'Avenue des Lilas', 456, 987654321, 'marie.durand@email.com', 75002);
INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (3, 'Smith', 'John', 'Main Street', 123, 123456789, 'john@example.com', 12345);
INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (4, 'Doe', 'Jane', 'Oak Avenue', 456, 123468407, 'jane@example.com', 54321);
INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (5, 'Johnson', 'Michael', 'Elm Street', 789, 123468701, 'michael@example.com', 67890);


--
-- TOC entry 4888 (class 0 OID 17066)
-- Dependencies: 222
-- Data for Name: maison; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.maison (id_maison, titre_maison, type_maison, surface, annee_construction, adresse, ville, cp, id_agent, image_maison, prix) VALUES (2, 'Belle maison avec jardin', 'Maison individuelle', 200, 2005, 'Rue de la Liberté', 'Paris', '75003', 1, 'maisonjardin.jpg', 150000);
INSERT INTO public.maison (id_maison, titre_maison, type_maison, surface, annee_construction, adresse, ville, cp, id_agent, image_maison, prix) VALUES (3, 'Appartement lumineux', 'Appartement', 80, 2010, 'Avenue des Roses', 'Paris', '75004', 2, 'appartementlumineux.jpg', 150000);
INSERT INTO public.maison (id_maison, titre_maison, type_maison, surface, annee_construction, adresse, ville, cp, id_agent, image_maison, prix) VALUES (4, 'Villa', 'Maison individuelle', 200, 2010, '123 Rue des Lilas', 'Paris', '75001', 3, 'villa.jpg', 500000);
INSERT INTO public.maison (id_maison, titre_maison, type_maison, surface, annee_construction, adresse, ville, cp, id_agent, image_maison, prix) VALUES (5, 'Appartement', 'Appartement', 120, 2005, '456 Avenue du Soleil', 'Nice', '06000', 4, 'appartement.jpg', 300000);
INSERT INTO public.maison (id_maison, titre_maison, type_maison, surface, annee_construction, adresse, ville, cp, id_agent, image_maison, prix) VALUES (6, 'Maison en banlieue', 'Maison individuelle', 300, 1995, '789 Boulevard de la Mer', 'Marseille', '13001', 5, 'ajout_image.jpg', 700000);
INSERT INTO public.maison (id_maison, titre_maison, type_maison, surface, annee_construction, adresse, ville, cp, id_agent, image_maison, prix) VALUES (22, 'Appartement de luxe', 'Appartement', 150, 2024, 'Rue du Tir', 'MONS', '7130', 1, 'ajout_image.jpg', 200000);
INSERT INTO public.maison (id_maison, titre_maison, type_maison, surface, annee_construction, adresse, ville, cp, id_agent, image_maison, prix) VALUES (24, 'Maison', 'Maison ancestrale', 200, 2023, 'Place des Droits de l''Homme', 'Binche', '7130', 2, 'C:\fakepath\ajout_image.jpg', 200000);
INSERT INTO public.maison (id_maison, titre_maison, type_maison, surface, annee_construction, adresse, ville, cp, id_agent, image_maison, prix) VALUES (25, 'Villa', 'Villa avec piscine', 350, 2023, 'Place des Droits de l''Homme', 'Peronnes', '7131', 3, 'C:\fakepath\ajout_image.jpg', 400000);


--
-- TOC entry 4890 (class 0 OID 17080)
-- Dependencies: 224
-- Data for Name: visite; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.visite (id_visite, date_visite, id_maison) VALUES (2, '2024-04-11', 2);
INSERT INTO public.visite (id_visite, date_visite, id_maison) VALUES (3, '2024-04-12', 3);


--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 225
-- Name: achat_id_achat_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.achat_id_achat_seq', 3, true);


--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 217
-- Name: admin_id_admin_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_id_admin_seq', 1, true);


--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 219
-- Name: agent_immobilier_id_agent_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.agent_immobilier_id_agent_seq', 5, true);


--
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 215
-- Name: client_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.client_id_client_seq', 5, true);


--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 221
-- Name: maison_id_maison_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.maison_id_maison_seq', 25, true);


--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 223
-- Name: visite_id_visite_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.visite_id_visite_seq', 3, true);


--
-- TOC entry 4733 (class 2606 OID 17097)
-- Name: achat achat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achat
    ADD CONSTRAINT achat_pkey PRIMARY KEY (id_achat);


--
-- TOC entry 4725 (class 2606 OID 17055)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);


--
-- TOC entry 4727 (class 2606 OID 17064)
-- Name: agent_immobilier agent_immobilier_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_immobilier
    ADD CONSTRAINT agent_immobilier_pkey PRIMARY KEY (id_agent);


--
-- TOC entry 4723 (class 2606 OID 17046)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);


--
-- TOC entry 4729 (class 2606 OID 17073)
-- Name: maison maison_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.maison
    ADD CONSTRAINT maison_pkey PRIMARY KEY (id_maison);


--
-- TOC entry 4731 (class 2606 OID 17085)
-- Name: visite visite_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visite
    ADD CONSTRAINT visite_pkey PRIMARY KEY (id_visite);


--
-- TOC entry 4736 (class 2606 OID 17098)
-- Name: achat achat_id_client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achat
    ADD CONSTRAINT achat_id_client_fkey FOREIGN KEY (id_client) REFERENCES public.client(id_client);


--
-- TOC entry 4737 (class 2606 OID 17103)
-- Name: achat achat_id_maison_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achat
    ADD CONSTRAINT achat_id_maison_fkey FOREIGN KEY (id_maison) REFERENCES public.maison(id_maison);


--
-- TOC entry 4734 (class 2606 OID 17074)
-- Name: maison maison_id_agent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.maison
    ADD CONSTRAINT maison_id_agent_fkey FOREIGN KEY (id_agent) REFERENCES public.agent_immobilier(id_agent);


--
-- TOC entry 4735 (class 2606 OID 17086)
-- Name: visite visite_id_maison_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visite
    ADD CONSTRAINT visite_id_maison_fkey FOREIGN KEY (id_maison) REFERENCES public.maison(id_maison);


-- Completed on 2024-04-25 11:21:39

--
-- PostgreSQL database dump complete
--

