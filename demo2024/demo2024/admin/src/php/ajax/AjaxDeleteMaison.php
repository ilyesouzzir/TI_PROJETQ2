<?php
header('Content-Type: application/json');
require '../db/dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/Maison.class.php';
require '../classes/MaisonDB.class.php';

try {
    $cnx = Connexion::getInstance($dsn, $user, $password);

    // Check if id_maison is set in $_GET
    if(isset($_GET['id_maison'])) {
        $maison = new MaisonDB($cnx);
        // Call the deleteMaisonById method
        $data[] = $maison->deleteMaisonById($_GET['id_maison']);
        print json_encode($data);
    } else {
        throw new Exception("Missing id_maison parameter in the URL.");
    }
} catch (Exception $e) {
    print json_encode($e->getMessage());
}