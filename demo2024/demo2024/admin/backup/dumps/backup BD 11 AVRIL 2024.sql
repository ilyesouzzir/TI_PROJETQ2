--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

-- Started on 2024-04-11 11:11:50

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
-- TOC entry 4879 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 226 (class 1255 OID 16848)
-- Name: ajout_maison(text, integer, text, integer, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ajout_maison(p_type text, p_surface integer, p_prix text, p_annee_construction integer, p_adresse text, p_ville text, p_image text) RETURNS integer
    LANGUAGE plpgsql
    AS '
DECLARE
    id INTEGER;
    retour INTEGER;
BEGIN
    SELECT id_maison INTO id FROM Maison WHERE ville = p_ville;
    IF NOT FOUND THEN
        INSERT INTO Maison (type_maison, surface, prix, annee_construction, adresse, ville, image)
        VALUES (p_type, p_surface, p_prix, p_annee_construction, p_adresse, p_ville, p_image);
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
-- TOC entry 221 (class 1255 OID 16830)
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
-- TOC entry 220 (class 1259 OID 16804)
-- Name: achat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.achat (
    id_achat integer NOT NULL,
    montant integer NOT NULL,
    id_client integer NOT NULL,
    id_maison integer
);


--
-- TOC entry 216 (class 1259 OID 16774)
-- Name: admin; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin (
    id_admin integer NOT NULL,
    login character varying(50) NOT NULL,
    password character varying(50) NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 16779)
-- Name: agent_immobilier; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_immobilier (
    id_agent integer NOT NULL,
    nom character varying(50) NOT NULL,
    prenom character varying(50) NOT NULL,
    n_tel integer NOT NULL,
    image_agent text,
    description text
);


--
-- TOC entry 215 (class 1259 OID 16769)
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id_client integer NOT NULL,
    nom character varying(50) NOT NULL,
    prenom character varying(50) NOT NULL,
    nom_rue character varying(50) NOT NULL,
    num_rue integer NOT NULL,
    num_tel integer NOT NULL,
    email character varying(60) NOT NULL,
    cp integer NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 16784)
-- Name: maison; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.maison (
    id_maison integer NOT NULL,
    titre_maison character varying(50) NOT NULL,
    type_maison character varying(50) NOT NULL,
    surface integer NOT NULL,
    "année_construction" integer NOT NULL,
    adresse character varying(50) NOT NULL,
    ville character varying(50) NOT NULL,
    cp character varying(50) NOT NULL,
    id_agent integer NOT NULL,
    image_maison text,
    prix numeric(10,2)
);


--
-- TOC entry 219 (class 1259 OID 16794)
-- Name: visite; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.visite (
    id_visite integer NOT NULL,
    date_visite date,
    id_maison integer NOT NULL
);


--
-- TOC entry 4873 (class 0 OID 16804)
-- Dependencies: 220
-- Data for Name: achat; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.achat (id_achat, montant, id_client, id_maison) VALUES (1, 300000, 1, 1);
INSERT INTO public.achat (id_achat, montant, id_client, id_maison) VALUES (2, 200000, 2, 2);
INSERT INTO public.achat (id_achat, montant, id_client, id_maison) VALUES (3, 500000, 3, 3);
INSERT INTO public.achat (id_achat, montant, id_client, id_maison) VALUES (4, 350000, 4, 4);
INSERT INTO public.achat (id_achat, montant, id_client, id_maison) VALUES (5, 400000, 5, 5);


--
-- TOC entry 4869 (class 0 OID 16774)
-- Dependencies: 216
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.admin (id_admin, login, password) VALUES (1, 'Ilyes', 'Ilyes');


--
-- TOC entry 4870 (class 0 OID 16779)
-- Dependencies: 217
-- Data for Name: agent_immobilier; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.agent_immobilier (id_agent, nom, prenom, n_tel, image_agent, description) VALUES (1, 'Dupont', 'Jean', 123456789, 'agent1.jpg', 'Jean Dupont est un agent immobilier expérimenté, passionné par son métier. Avec plus de 10 ans d''expérience dans le domaine de l''immobilier, il possède une connaissance approfondie du marché local et des compétences avérées en matière de négociation. Sa priorité est de fournir un service client exceptionnel en aidant ses clients à trouver la maison de leurs rêves. Jean est déterminé à rendre le processus d''achat ou de vente aussi fluide et sans stress que possible, et il travaille sans relâche pour atteindre cet objectif.');
INSERT INTO public.agent_immobilier (id_agent, nom, prenom, n_tel, image_agent, description) VALUES (2, 'Martin', 'Sophie', 987654321, 'agent2.jpg', 'Marie Sophie est une agent immobilier dynamique et dévouée. Forte de son expérience de cinq ans dans le secteur immobilier, elle met tout en œuvre pour répondre aux besoins de ses clients. Marie est réputée pour son approche personnelle, sa transparence et sa capacité à trouver des solutions créatives pour chaque situation. Elle s''engage à offrir un service de qualité et à accompagner ses clients à chaque étape de leur projet immobilier.');
INSERT INTO public.agent_immobilier (id_agent, nom, prenom, n_tel, image_agent, description) VALUES (3, 'Garcia', 'Pierre', 555123456, 'agent3.jpg', 'Garcia Pierre est un jeune agent immobilier passionné par son métier. Avec son énergie débordante et sa volonté d''apprendre, il s''efforce de fournir un service client exceptionnel à chaque client. Pierre a une approche personnalisée pour chaque projet immobilier et met tout en œuvre pour garantir une expérience positive à ses clients. Il est déterminé à faire de chaque transaction immobilière une réussite.');
INSERT INTO public.agent_immobilier (id_agent, nom, prenom, n_tel, image_agent, description) VALUES (4, 'Lefèvre', 'Marie', 333987654, 'agent4.jpg', 'Lefèvre Marie est une agent immobilier expérimentée et fiable. Avec plus de 15 ans d''expérience dans le domaine de l''immobilier, elle possède une connaissance approfondie du marché local et des compétences avérées en matière de négociation. Marie est reconnue pour son professionnalisme, son intégrité et son engagement envers ses clients. Elle s''efforce toujours de dépasser les attentes de ses clients et de garantir une expérience sans stress.');
INSERT INTO public.agent_immobilier (id_agent, nom, prenom, n_tel, image_agent, description) VALUES (5, 'Dubois', 'Julie', 777888999, 'agent5.jpg', 'Dubois Julie est une agent immobilier passionnée par son métier. Dotée d''une approche personnalisée et d''un grand sens du service client, elle s''efforce de comprendre les besoins uniques de chaque client et de leur fournir des solutions sur mesure. Sophie est déterminée à rendre le processus d''achat ou de vente aussi fluide et sans stress que possible. Elle est toujours disponible pour ses clients et les accompagne à chaque étape de leur projet immobilier.');


--
-- TOC entry 4868 (class 0 OID 16769)
-- Dependencies: 215
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (1, 'Dupont', 'Jean', 'Rue de la Paix', 10, 494123456, 'jean.dupont@example.com', 75001);
INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (2, 'Martin', 'Sophie', 'Avenue des Champs-Élysées', 25, 494789010, 'sophie.martin@example.com', 75008);
INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (3, 'Garcia', 'Pierre', 'Boulevard Saint-Germain', 45, 495856932, 'pierre.garcia@example.com', 75006);
INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (4, 'Lefèvre', 'Marie', 'Rue de Rivoli', 30, 496125489, 'marie.lefevre@example.com', 75004);
INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (5, 'Dubois', 'Julie', 'Avenue Foch', 12, 496321456, 'julie.dubois@example.com', 75116);
INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (6, 'Moreau', 'Luc', 'Rue de la Liberté', 8, 495142536, 'luc.moreau@example.com', 69001);
INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (7, 'Leroy', 'Céline', 'Avenue de la République', 20, 495475869, 'celine.leroy@example.com', 75011);
INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (8, 'Roux', 'Thomas', 'Rue du Faubourg Saint-Honoré', 35, 494203459, 'thomas.roux@example.com', 75008);
INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (9, 'Petit', 'Emma', 'Boulevard Haussmann', 50, 494879561, 'emma.petit@example.com', 75009);
INSERT INTO public.client (id_client, nom, prenom, nom_rue, num_rue, num_tel, email, cp) VALUES (10, 'Fernandez', 'Antoine', 'Place Vendôme', 1, 494666666, 'antoine.fernandez@example.com', 75001);


--
-- TOC entry 4871 (class 0 OID 16784)
-- Dependencies: 218
-- Data for Name: maison; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.maison (id_maison, titre_maison, type_maison, surface, "année_construction", adresse, ville, cp, id_agent, image_maison, prix) VALUES (1, 'Belle maison en banlieue', 'Maison individuelle', 200, 2005, '10 Rue de la Paix', 'Lyon', '69001', 1, 'banlieue.jpg', 150000.00);
INSERT INTO public.maison (id_maison, titre_maison, type_maison, surface, "année_construction", adresse, ville, cp, id_agent, image_maison, prix) VALUES (2, 'Appartement lumineux', 'Appartement', 80, 2010, '25 Avenue des Champs-Élysées', 'Marseille', '13001', 2, 'appartementlumineux.jpg', 160000.00);
INSERT INTO public.maison (id_maison, titre_maison, type_maison, surface, "année_construction", adresse, ville, cp, id_agent, image_maison, prix) VALUES (3, 'Villa avec piscine', 'Villa', 300, 1998, '45 Boulevard Saint-Germain', 'Nice', '06000', 3, 'villa.jpg', 170000.00);
INSERT INTO public.maison (id_maison, titre_maison, type_maison, surface, "année_construction", adresse, ville, cp, id_agent, image_maison, prix) VALUES (4, 'Petite maison avec jardin', 'Maison individuelle', 120, 1980, '30 Rue de Rivoli', 'Toulouse', '31000', 4, 'maisonjardin.jpg', 180000.00);
INSERT INTO public.maison (id_maison, titre_maison, type_maison, surface, "année_construction", adresse, ville, cp, id_agent, image_maison, prix) VALUES (5, 'Appartement moderne', 'Appartement', 100, 2015, '12 Avenue Foch', 'Bordeaux', '33000', 5, 'appartement.jpg', 190000.00);


--
-- TOC entry 4872 (class 0 OID 16794)
-- Dependencies: 219
-- Data for Name: visite; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.visite (id_visite, date_visite, id_maison) VALUES (1, '2024-03-25', 1);
INSERT INTO public.visite (id_visite, date_visite, id_maison) VALUES (2, '2024-10-28', 2);
INSERT INTO public.visite (id_visite, date_visite, id_maison) VALUES (3, '2024-08-31', 3);
INSERT INTO public.visite (id_visite, date_visite, id_maison) VALUES (4, '2024-06-03', 4);
INSERT INTO public.visite (id_visite, date_visite, id_maison) VALUES (5, '2024-04-06', 5);


--
-- TOC entry 4720 (class 2606 OID 16808)
-- Name: achat achat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achat
    ADD CONSTRAINT achat_pkey PRIMARY KEY (id_achat);


--
-- TOC entry 4712 (class 2606 OID 16778)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);


--
-- TOC entry 4714 (class 2606 OID 16783)
-- Name: agent_immobilier agent_immobilier_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_immobilier
    ADD CONSTRAINT agent_immobilier_pkey PRIMARY KEY (id_agent);


--
-- TOC entry 4710 (class 2606 OID 16773)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);


--
-- TOC entry 4716 (class 2606 OID 16788)
-- Name: maison maison_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.maison
    ADD CONSTRAINT maison_pkey PRIMARY KEY (id_maison);


--
-- TOC entry 4718 (class 2606 OID 16798)
-- Name: visite visite_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visite
    ADD CONSTRAINT visite_pkey PRIMARY KEY (id_visite);


--
-- TOC entry 4723 (class 2606 OID 16809)
-- Name: achat achat_id_client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achat
    ADD CONSTRAINT achat_id_client_fkey FOREIGN KEY (id_client) REFERENCES public.client(id_client);


--
-- TOC entry 4724 (class 2606 OID 16814)
-- Name: achat achat_id_maison_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achat
    ADD CONSTRAINT achat_id_maison_fkey FOREIGN KEY (id_maison) REFERENCES public.maison(id_maison);


--
-- TOC entry 4721 (class 2606 OID 16789)
-- Name: maison maison_id_agent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.maison
    ADD CONSTRAINT maison_id_agent_fkey FOREIGN KEY (id_agent) REFERENCES public.agent_immobilier(id_agent);


--
-- TOC entry 4722 (class 2606 OID 16799)
-- Name: visite visite_id_maison_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visite
    ADD CONSTRAINT visite_id_maison_fkey FOREIGN KEY (id_maison) REFERENCES public.maison(id_maison);


-- Completed on 2024-04-11 11:11:50

--
-- PostgreSQL database dump complete
--

