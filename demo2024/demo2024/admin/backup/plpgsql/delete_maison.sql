CREATE OR REPLACE FUNCTION delete_maison(p_id integer) RETURNS integer AS
$$
BEGIN
    DELETE FROM maison WHERE id_maison = p_id;
    RETURN 1;
END;
$$ LANGUAGE 'plpgsql';