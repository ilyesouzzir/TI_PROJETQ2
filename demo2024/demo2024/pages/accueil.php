<?php
$maisonDB = new MaisonDB($cnx);
$listeMaisons = $maisonDB->getAllMaisons();

// Assurez-vous que $listeMaisons est toujours un tableau
$listeMaisons = is_array($listeMaisons) ? $listeMaisons : [];

$nbrMaisons = count($listeMaisons);
?>

<div class="album py-5 bg-body-tertiary">
    <div class="container">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
            <?php foreach ($listeMaisons as $maison): ?>
                <div class="col">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <p class="card-text"><?= $maison->titre_maison; ?></p>
                            <img src="./admin/image/<?= $maison->image_maison; ?>" alt="Image de la maison">
                            <p class="card-text">Surface : <?= $maison->surface; ?> m²</p>
                            <p class="card-text">Année de construction : <?= $maison->annee_construction; ?></p>
                            <p class="card-text">Adresse : <?= $maison->adresse; ?></p>
                            <p class="card-text">Ville : <?= $maison->ville; ?></p>
                            <p class="card-text">Prix : <?= $maison->prix; ?> €</p>
                            <p class="card-text">Agent : <?= $maison->agent_name; ?></p>
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
</div>
<div class="text-center mt-5">
    <a href="./index_.php?page=description.php" class="btn btn-primary">Descriptions des Maisons</a>
</div>