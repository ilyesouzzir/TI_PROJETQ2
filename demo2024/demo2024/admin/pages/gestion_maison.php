<h2>Gestion des Maisons</h2>
<a href="index_.php?page=ajout_maison.php">Nouvelle Maison</a><br>
<link rel="stylesheet" href="./public/css/custom.css">
<?php
//récupération des clients et affichage dans table bootstrap
$maison = new MaisonDB($cnx);
$liste = $maison->getAllMaisons();
//var_dump($liste);
$nbr = count($liste);

if($nbr == 0){
    print "<br>Aucune Maison encodé<br>";
}
else{
    ?>
    <table class="table table-striped">
        <thead>
        <tr>
            <th scope="col">Type</th>
            <th scope="col">Surface</th>
            <th scope="col">Prix</th>
            <th scope="col">Annee de construction</th>
            <th scope="col">Adresse</th>
            <th scope="col">Ville</th>
            <th scope="col">Image</th>
        </tr>
        </thead>
        <tbody>
        <?php
        for($i=0; $i < $nbr; $i++){
            ?>
            <tr>
                <th><?= $liste[$i]->type_maison;?></th>
                <td contenteditable="true" id="<?= $liste[$i]->id_maison;?>" name="surface"><?= $liste[$i]->surface;?>m2</td>
                <td contenteditable="true" id="<?= $liste[$i]->id_maison;?>" name="prix"><?= $liste[$i]->prix;?>€</td>
                <td contenteditable="true" id="<?= $liste[$i]->id_maison;?>" name="annee_construction"><?= $liste[$i]->annee_construction;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id_maison;?>" name="adresse"><?= $liste[$i]->adresse;?></td>
                <td contenteditable="true" id="<?= $liste[$i]->id_maison;?>" name="ville"><?= $liste[$i]->ville;?></td>
                <td><img src="image/<?= $liste[$i]->image_maison; ?>" alt="Image de la maison"><td>
                <td> <a href="index_.php?page=modifier_maison.php&id=<?= $liste[$i]->id_maison;?>"><img src="image/crayon.jpg" alt="Modifier" ></a></td>
                <td><a href="index_.php?page=delete_maison.php&id=<?= $liste[$i]->id_maison;?>"><img src="image/delete.jpg" alt="Effacer" ></a></td>
            </tr>
            <?php
        }
        ?>
        </tbody>
    </table>
    <?php
}
?>