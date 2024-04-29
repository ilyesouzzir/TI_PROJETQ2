<?php
if (isset($_GET['id'])) {
    $maisonDB = new MaisonDB($cnx);
    $maison = $maisonDB->getMaisonById($_GET['id']);
} else {
    exit('Aucun identifiant de maison n\'a été fourni');
}
?>

<h2>Suppression de maison</h2>
<link rel="stylesheet" href="./public/css/custom.css">
<div class="container">
    <form id="form_deletion" method="get" action="./src/php/ajax/AjaxDeleteMaison.php">
        <input type="hidden" name="id_maison" value="<?= $maison[0]->id_maison;?>" id="id_maison">
        <div class="mb-3">
            <label for="titre_maison" class="form-label">Titre Maison</label>
            <input type="text" class="form-control" id="titre_maison" value="<?= $maison[0]->titre_maison ?? ''; ?>" readonly>
        </div>
        <div class="mb-3">
            <label for="type" class="form-label">Type de la maison</label>
            <input type="text" class="form-control" id="type" value="<?= $maison[0]->type_maison ?? ''; ?>" readonly>
        </div>
        <div class="mb-3">
            <label for="surface" class="form-label">Surface de la maison</label>
            <input type="text" class="form-control" id="surface" value="<?= $maison[0]->surface ?? ''; ?>" readonly>
        </div>
        <div class="mb-3">
            <label for="prix" class="form-label">Prix de la maison</label>
            <input type="text" class="form-control" id="prix" value="<?= $maison[0]->prix ?? ''; ?>" readonly>
        </div>
        <div class="mb-3">
            <label for="annee_construction" class="form-label">Année de construction</label>
            <input type="text" class="form-control" id="annee_construction" value="<?= $maison[0]->annee_construction ?? ''; ?>" readonly>
        </div>
        <div class="mb-3">
            <label for="adresse" class="form-label">Adresse</label>
            <input type="text" class="form-control" id="adresse" value="<?= $maison[0]->adresse ?? ''; ?>" readonly>
        </div>
        <div class="mb-3">
            <label for="ville" class="form-label">Ville</label>
            <input type="text" class="form-control" id="ville" value="<?= $maison[0]->ville ?? ''; ?>" readonly>
        </div>
        <div class="mb-3">
            <label for="cp" class="form-label">Code Postal</label>
            <input type="text" class="form-control" id="cp" value="<?= $maison[0]->cp ?? ''; ?>" readonly>
        </div>
        <div class="mb-3">
            <label for="id_agent" class="form-label">ID Agent</label>
            <input type="text" class="form-control" id="id_agent" value="<?= $maison[0]->id_agent ?? ''; ?>" readonly>
        </div>
        <div class="mb-3">
            <label for="image">Image de la maison:</label>
            <img src="<?= $maison[0]->image_maison ?? ''; ?>" alt="Image de la maison">
        </div>
        <button type="submit" id="texte_bouton_delete" class="btn btn-danger">
            Supprimer
        </button>
        <a href="index_.php?page=gestion_maison.php" class="btn btn-primary">Annuler</a>
    </form>
</div>