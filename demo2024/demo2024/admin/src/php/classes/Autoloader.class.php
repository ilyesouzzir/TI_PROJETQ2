<?php

class Autoloader
{
    //fonction qui appel la methode de chargement automatique des classes
    static function register()
    {
        spl_autoload_register(array(__CLASS__, 'autoload'));//__CLASS__ contient le nom du fichier courant
    }

    //methode appelée par register()
    static function autoload($classname)
    {
        require $classname . ".class.php";
    }

}