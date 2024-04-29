<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Agents</title>
    <link rel="stylesheet" href="/admin/public/css/style.css">
</head>
<body>
<?php
// Assuming $agentImmobilierDB is an instance of AgentImmobilierDB class
$agentImmobilierDB = new AgentImmobilierDB($cnx);
$listeAgents = $agentImmobilierDB->getAllAgents();

if (!empty($listeAgents)) {
    $nbrAgents = count($listeAgents);
    ?>
    <div class="album py-5 bg-body-tertiary">
        <div class="container">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                <?php
                // Loop through the agents
                foreach ($listeAgents as $agent) {
                    // Fetch the list of houses for the current agent
                    $agent->liste_maisons = $agentImmobilierDB->getListeMaisons($agent->id_agent);
                    $nbrMaisons = is_array($agent->liste_maisons) ? count($agent->liste_maisons) : 0;
                    ?>
                    <div class="col">
                        <div class="card shadow-sm">
                            <!-- Display the image for the agent -->
                            <img src="./admin/image/<?php echo $agent->image_agent; ?>" alt="<?php echo $agent->nom; ?>"
                                 class="card-img-top">
                            <div class="card-body">
                                <h5 class="card-title"><?php echo $agent->nom . " " . $agent->prenom; ?></h5>
                                <p class="card-text">Description : <?php echo $agent->description; ?></p>
                                <p class="card-text">Nombre de maisons attribuées
                                    : <?php echo $nbrMaisons; ?></p>
                                <p class="card-text">Liste des maisons :</p>
                                <ul>
                                    <?php
                                    if ($nbrMaisons > 0) {
                                        foreach ($agent->liste_maisons as $maison) {
                                            echo "<li>" . $maison->titre_maison . "</li>";
                                        }
                                    } else {
                                        echo "<li>Aucune maison attribuée</li>";
                                    }
                                    ?>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <?php
                }
                ?>
            </div>
        </div>
    </div>
    <?php
} else {
    echo "<p>Aucun agent immobilier trouvé.</p>";
}
?>
<div class="text-center mt-5"></div>
</body>
</html>