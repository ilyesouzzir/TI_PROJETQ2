<?php
if (isset($_GET['id'])) {
    $maisonDB = new MaisonDB($cnx);
    $maison = $maisonDB->getMaisonById($_GET['id']);
} else {
    exit('Aucun identifiant de maison n\'a été fourni');
}



?>

<h2>Modification des maisons</h2>
<div class="container">
    <form id="form_modification" method="get">
        <input type="hidden" name="id_maison">
        <div class="mb-3">
            <label for="titre_maison" class="form-label">Titre Maison</label>
            <input type="text" class="form-control" id="titre_maison" name="titre_maison" value="<?= $maison[0]->titre_maison ?? ''; ?>">
        </div>
        <div class="mb-3">
            <label for="type" class="form-label">Type de la maison</label>
            <input type="text" class="form-control" id="type" name="type"  value="<?= $maison[0]->type_maison ?? ''; ?>">
        </div>
        <div class="mb-3">
            <label for="surface" class="form-label">Surface de la maison</label>
            <input type="text" class="form-control" id="surface" name="surface"  value="<?= $maison[0]->surface ?? ''; ?>">
        </div>
        <div class="mb-3">
            <label for="prix" class="form-label">Prix de la maison</label>
            <input type="text" class="form-control" id="prix" name="prix"  value="<?= $maison[0]->prix ?? ''; ?>">
        </div>
        <div class="mb-3">
            <label for="annee_construction" class="form-label">Année de construction</label>
            <input type="text" class="form-control" id="annee_construction" name="annee_construction"  value="<?= $maison[0]->annee_construction ?? ''; ?>">
        </div>
        <div class="mb-3">
            <label for="adresse" class="form-label">Adresse</label>
            <input type="text" class="form-control" id="adresse" name="adresse"  value="<?= $maison[0]->adresse ?? ''; ?>">
        </div>
        <div class="mb-3">
            <label for="ville" class="form-label">Ville</label>
            <input type="text" class="form-control" id="ville" name="ville"  value="<?= $maison[0]->ville ?? ''; ?>">
        </div>
        <div class="mb-3">
            <label for="cp" class="form-label">Code Postal</label>
            <input type="text" class="form-control" id="cp" name="cp" value="<?= $maison[0]->cp ?? ''; ?>">
        </div>
        <div class="mb-3">
            <label for="id_agent" class="form-label">ID Agent</label>
            <input type="text" class="form-control" id="id_agent" name="id_agent" value="<?= $maison[0]->id_agent ?? ''; ?>">
        </div>
        <div class="mb-3">
            <label for="image">Image de la maison:</label>
            <input type="file" id="image" name="image" value="<?= $maison[0]->image_maison ?? ''; ?>">
        </div>
        <input type="hidden" name="id_maison" value="<?= $maison[0]->id_maison;?>" id="id_maison">
        <button type="submit" id="texte_bouton_modif" class="btn btn-primary">
            Modifier
        </button>
        <button class="btn btn-primary" type="reset" id="reset">Annuler</button>
    </form>
</div>
