/*


    $('#prix').blur(function(){
        alert('click');
    });
$('#texte_bouton_submit').text("Ajouter une maison");

$('#texte_bouton_submit').click(function(){ //e = formulaire
    e.preventDefault(); //empêcher l'attribut action de form
    console.log ('click');
    let type = $('#type').val();
    let surface = $('#surface').val();
    let prix = $('#prix').val();
    let annee_construction = $('#annee_construction').val();
    let adresse = $('#adresse').val();
    let ville = $('#ville').val();
    let image = $('#image').val();
    let param = 'type='+type+'&surface='+surface+'&prix='+prix+'&annee_construction='+annee_construction+'&adresse='+adresse+'&ville='+ville+'&image='+image;
    let retour = $.ajax({
        type: 'get',
        dataType: 'json',
        data: param,
        url: './src/php/ajax/ajaxAjoutMaison.php',
        success: function(data){//data = retour du # php
            console.log(data);
        }
    })
})
});

 */