#!/bin/bash
rm -r chemin
touch chemin
function chemin
{
        echo -n "Veuillez saisir le nom du dossier à analyser : "
        read path
}
function exploreR
{
    files=$(find $path)

    for element in $files
    do
        if test -f "$element"
        then
            echo $element >> chemin
        elif test -d "$path/$element"
        then
            echo $element >> chemin
        elif test -d "$path/$element"
            then
                exploreR $element
        fi

    done
}

function complet
{
    chemin
    exploreR $path
}

complet

cat chemin
echo -e "\nNous avons trouvé $(cat chemin | wc -l)  fichiers"
