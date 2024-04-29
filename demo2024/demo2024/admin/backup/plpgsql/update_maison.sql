DROP FUNCTION IF EXISTS update_maison(integer,text,integer,text,text,text,text,text,text,text);

CREATE OR REPLACE FUNCTION update_maison(p_id_maison integer, p_titre_maison text, p_id_agent integer, p_type_maison text, p_surface text, p_prix text, p_annee_construction text, p_adresse text, p_ville text, p_cp text)
RETURNS integer AS $$
BEGIN
    EXECUTE format('UPDATE maison SET titre_maison = %L, id_agent = %L, type_maison = %L, surface = %L, prix = %L, annee_construction = %L, adresse = %L, ville = %L, cp = %L WHERE id_maison = %L', p_titre_maison, p_id_agent, p_type_maison, p_surface, p_prix, p_annee_construction, p_adresse, p_ville, p_cp, p_id_maison);
    RETURN 1;
END;
$$ LANGUAGE plpgsql;