<?php

// création d'une fonction avec le mot clef function suivi du nom, les () sont obligatoires, même si ici nous n'avons pas de paramètre
function premiere(){
    // ceci est une variable locale dans laquelle on met le temps du serveur au format 'datetime'
    $date= date("Y-m-d H:i:s");
    // pour que ce soit une fonction et pas une procédure, on utilise return pour envoyer un résultat. Le return arrête la fonction
    return 'La variable $date vaut '."Le $date";
}
echo "<hr>";
echo premiere();
echo "<hr>";

// fonction avec un paramètre obligatoire, ici on souhaite un paramètre qui est un temps unix depuis le 1er janvier 1970 (en secondes)
function datesince($arg){
    return date("Y-m-d H:i:s",$arg);
}
echo "<hr>";
// ici on met le temps actuel du serveur avec time() en seconde
echo datesince(time());
echo "<hr>";
// exe logique 1

// ici le temps il y a une heure
echo datesince(time());
echo "<hr>";
// ici le temps il y a un semaine
echo datesince(time());
echo "<hr>";