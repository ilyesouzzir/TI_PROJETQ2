<h2>Gestion des maisons</h2>
<link rel="stylesheet" href="./public/css/custom.css">
<div class="container">
    <form id="form_ajout" method="get" action="">
        <div class="mb-3">
            <label for="titre_maison" class="form-label">Titre Maison</label>
            <input type="text" class="form-control" id="titre_maison" name="titre_maison">
        </div>
        <div class="mb-3">
            <label for="type" class="form-label">Type de la maison</label>
            <input type="text" class="form-control" id="type" name="type">
        </div>
        <div class="mb-3">
            <label for="surface" class="form-label">Surface de la maison</label>
            <input type="text" class="form-control" id="surface" name="surface">
        </div>
        <div class="mb-3">
            <label for="prix" class="form-label">Prix de la maison</label>
            <input type="text" class="form-control" id="prix" name="prix">
        </div>
        <div class="mb-3">
            <label for="annee_construction" class="form-label">Année de construction</label>
            <input type="text" class="form-control" id="annee_construction" name="annee_construction">
        </div>
        <div class="mb-3">
            <label for="adresse" class="form-label">Adresse</label>
            <input type="text" class="form-control" id="adresse" name="adresse">
        </div>
        <div class="mb-3">
            <label for="ville" class="form-label">Ville</label>
            <input type="text" class="form-control" id="ville" name="ville">
        </div>
        <div class="mb-3">
            <label for="cp" class="form-label">Code Postal</label>
            <input type="text" class="form-control" id="cp" name="cp">
        </div>
        <div class="mb-3">
            <label for="id_agent" class="form-label">ID Agent</label>
            <input type="text" class="form-control" id="id_agent" name="id_agent">
        </div>
        <div class="mb-3">
            <label for="image">Image de la maison:</label>
            <input type="file" id="image" name="image">
        </div>
        <button type="submit" id="texte_bouton_submit" class="btn btn-primary">
            Ajouter
        </button>
        <button class="btn btn-primary" type="reset" id="reset">Annuler</button>
    </form>
</div>
<script>