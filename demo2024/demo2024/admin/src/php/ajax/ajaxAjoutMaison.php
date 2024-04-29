<?php
header('Content-Type: application/json');
require '../db/dbPgConnect.php';
require '../classes/Connexion.class.php';
require '../classes/Maison.class.php';
require '../classes/MaisonDB.class.php';
$cnx = Connexion::getInstance($dsn,$user,$password);

$maison = new MaisonDB($cnx);
$data[] = $maison->ajout_maison( $_GET['titre_maison'],$_GET['type'],$_GET['surface'],$_GET['prix'],$_GET['annee_construction'],$_GET['adresse'],$_GET['ville'], $_GET['cp'], $_GET['id_agent'], $_GET['image']);
print json_encode($data);