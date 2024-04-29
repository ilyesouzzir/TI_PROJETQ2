<?php

class AgentImmobilierDB extends AgentImmobilier
{
    private $_bd;

    public function __construct($cnx)
    {
        $this->_bd = $cnx;
    }

    public function getAllAgents()
    {
        $query = "SELECT * FROM agent_immobilier"; // Récupérer tous les agents
        try {
            $this->_bd->beginTransaction();
            $resultset = $this->_bd->prepare($query);
            $resultset->execute();
            $data = $resultset->fetchAll();
            foreach ($data as $d) {
                $_array[] = new AgentImmobilier($d); // Supposer que AgentImmobilier est une classe représentant un agent avec ses attributs correspondants
            }
            $this->_bd->commit();
            return $_array;
        } catch (PDOException $e) {
            $this->_bd->rollback();
            print "Echec de la requête " . $e->getMessage();
        }
    }

    public function getNombreMaisonsAttribuees($id_agent)
    {
        $query = "SELECT COUNT(*) FROM Maison WHERE id_agent = :id_agent";
        $resultset = $this->_bd->prepare($query);
        $resultset->bindParam(":id_agent", $id_agent, PDO::PARAM_INT);
        $resultset->execute();
        return $resultset->fetchColumn();
    }

    public function getListeMaisons($id_agent)
    {
        $query = "SELECT * FROM Maison WHERE id_agent = :id_agent";
        $resultset = $this->_bd->prepare($query);
        $resultset->bindParam(":id_agent", $id_agent, PDO::PARAM_INT);
        $resultset->execute();
        $data = $resultset->fetchAll();
        $maisons = [];
        foreach ($data as $d) {
            $maisons[] = new Maison($d);
        }
        return $maisons;
    }
}

?>