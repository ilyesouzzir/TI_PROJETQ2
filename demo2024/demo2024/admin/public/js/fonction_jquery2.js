$(document).ready(function () {
    $("#seeSpoiler").click(function () {
        $("#spoiler").toggle();
    });

    $('#texte_bouton_submit').click(function (e) {
        e.preventDefault();
        let titre_maison = $('#titre_maison').val();
        let type = $('#type').val();
        let surface = $('#surface').val();
        let prix = $('#prix').val();
        let annee_construction = $('#annee_construction').val();
        let adresse = $('#adresse').val();
        let ville = $('#ville').val();
        let cp = $('#cp').val();
        let id_agent = $('#id_agent').val();
        let image = $('#image').val();
        let param = 'titre_maison=' + titre_maison + '&type=' + type + '&surface=' + surface + '&prix=' + prix + '&annee_construction=' + annee_construction + '&adresse=' + adresse + '&ville=' + ville + '&cp=' + cp + '&id_agent=' + id_agent + '&image=' + image;
        $.ajax({
            url: './src/php/ajax/ajaxAjoutMaison.php',
            type: 'GET',
            dataType: 'json',
            data: param,
            success: function (data) {
                alert("Maison ajouté avec succes.");
            },
            error: function (data) {
                console.log(data);
            }
        });
    });
    // modif
    $('#texte_bouton_modif').click(function (e) {
        e.preventDefault();
        let id_maison = $('#id_maison').val();
        let titre_maison = $('#titre_maison').val();
        let id_agent = $('#id_agent').val();
        let type = $('#type').val();
        let surface = $('#surface').val();
        let prix = $('#prix').val();
        let annee_construction = $('#annee_construction').val();
        let adresse = $('#adresse').val();
        let ville = $('#ville').val();
        let cp = $('#cp').val();

        let param = {
            id_maison: id_maison,
            titre_maison: titre_maison,
            id_agent: id_agent,
            type: type,
            surface: surface,
            prix: prix,
            annee_construction: annee_construction,
            adresse: adresse,
            ville: ville,
            cp: cp
        };

        console.log("param : ", param);

        $.ajax({
            url: './src/php/ajax/AjaxUpdateMaison.php',
            type: 'GET',
            dataType: 'json',
            data: $.param(param),
            success: function (data) {
                if (data && data.error) {
                    console.error('Error dans la modification:', data.error);
                } else {
                    alert("Maison modifié avec succès.");
                }
            },
            error: function (data) {
                console.log(data);
            }
        });
    });

    // delete
    $('#texte_bouton_delete').click(function (e) {
        e.preventDefault();
        let id_maison = $('#id_maison').val();

        let param = {
            id_maison: id_maison
        };

        console.log("param : ", param);

        $.ajax({
            url: './src/php/ajax/AjaxDeleteMaison.php',
            type: 'GET',
            dataType: 'json',
            data: $.param(param),
            success: function (data) {
                if (data && data.error) {
                    console.error('Erreur dans la suppression:', data.error);
                } else {
                    alert("Maison supprime avec succes.");
                }
            },
            error: function (data) {
                console.log(data);
            }
        });
    });

});