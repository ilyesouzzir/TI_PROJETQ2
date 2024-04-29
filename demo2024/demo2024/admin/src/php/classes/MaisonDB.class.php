<?phpclass MaisonDB{    private $_bd;    private $_array = array();    public function __construct($cnx)    {        $this->_bd = $cnx;    }    // Méthode pour récupérer toutes les maisons (utilisée dans la page d'accueil)    public function getAllMaisons()    {        try {            $query = "SELECT Maison.*, agent_immobilier.nom AS agent_name FROM Maison LEFT JOIN agent_immobilier ON Maison.id_agent = agent_immobilier.id_agent";            $res = $this->_bd->prepare($query);            $res->execute();            return $res->fetchAll(PDO::FETCH_OBJ);        } catch (PDOException $e) {            print "Echec " . $e->getMessage();        }    }    // Méthode pour ajouter une maison    public function ajout_maison($titre, $type, $surface, $prix, $annee_construction, $adresse, $ville, $cp, $id_agent, $image)    {        try {            $query = "select ajout_maison3(:titre, :type, :surface, :prix, :annee_construction, :adresse, :ville, :cp, :id_agent, :image)";            $res = $this->_bd->prepare($query);            $res->bindValue(':titre', $titre);            $res->bindValue(':type', $type);            $res->bindValue(':surface', $surface);            $res->bindValue(':prix', $prix);            $res->bindValue(':annee_construction', $annee_construction);            $res->bindValue(':adresse', $adresse);            $res->bindValue(':ville', $ville);            $res->bindValue(':cp', $cp);            $res->bindValue(':id_agent', $id_agent);            $res->bindValue(':image', $image);            $res->execute();            $data = $res->fetch(PDO::FETCH_ASSOC);            return $data;        } catch (PDOException $e) {            print "Echec " . $e->getMessage();        }    }    public function getMaisonById($id)    {        try {            $query = "SELECT * FROM maison WHERE id_maison = :id";            $res = $this->_bd->prepare($query);            $res->bindValue(':id', $id);            $res->execute();            return $res->fetchAll(PDO::FETCH_OBJ);        } catch (PDOException $e) {            print "Echec " . $e->getMessage();        }    }    public function updateMaisonFormulaire($id_maison, $titre_maison, $id_agent, $type_maison, $surface, $prix, $annee_construction, $adresse, $ville, $cp){        try {            // Prepare the SQL query            $query = "UPDATE maison SET titre_maison = :titre_maison, id_agent = :id_agent, type_maison = :type_maison, surface = :surface, prix = :prix, annee_construction = :annee_construction, adresse = :adresse, ville = :ville, cp = :cp WHERE id_maison = :id_maison";            $res = $this->_bd->prepare($query);            $res->bindValue(':titre_maison', $titre_maison);            $res->bindValue(':id_agent', $id_agent);            $res->bindValue(':type_maison', $type_maison);            $res->bindValue(':surface', $surface);            $res->bindValue(':prix', $prix);            $res->bindValue(':annee_construction', $annee_construction);            $res->bindValue(':adresse', $adresse);            $res->bindValue(':ville', $ville);            $res->bindValue(':cp', $cp);            $res->bindValue(':id_maison', $id_maison);            $res->execute();            echo "Maison modifiée avec succès.";        } catch (PDOException $e) {            print "Echec " . $e->getMessage();            echo "Erreur lors de la modification de la maison.";        }    }    public function deleteMaisonById($id_maison)    {        try {            $query = "DELETE FROM maison WHERE id_maison = :id";            $res = $this->_bd->prepare($query);            $res->bindValue(':id', $id_maison);            $res->execute();            return array('status' => 'success', 'message' => 'Maison supprimée avec succès.');        } catch (PDOException $e) {            return array('status' => 'error', 'message' => 'Erreur lors de la suppression de la maison.');        }    }}?>