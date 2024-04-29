CREATE OR REPLACE FUNCTION ajout_maison3(
	p_titre TEXT,
    p_type TEXT,
    p_surface INTEGER,
    p_prix INTEGER, -- change this from TEXT to INTEGER
    p_annee_construction INTEGER,
    p_adresse TEXT,
    p_ville TEXT,
	p_cp TEXT,
	p_id_agent INTEGER,
    p_image TEXT
) RETURNS INTEGER AS $$
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
$$ LANGUAGE plpgsql;