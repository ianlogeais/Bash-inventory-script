#!/bin/bash

rm -r chemin
rm -r chemin2
rm -r diff.txt
touch chemin
touch chemin2
touch diff.txt

function analyse {

        echo -n "Veuillez saisir le nom du premier dossier à analyser : "
        read path
        echo -n "Veuillez saisir le nom du second dossier à analyser : "
        read path2
}

function exploreR {

    files=$(find $path)

    for element in $files
    do
        if [ -f "$element" ]
        then
	    md5sum $element >> chemin
        elif test -d "$path/$element"
        then
            echo $element >> chemin
        elif test -d "$path/$element"
            then
                exploreR $element
        fi

    done
}

function exploreR2 {

    files2=$(find $path2)

    for element2 in $files2
    do
        if [ -f "$element2" ]
        then
	    md5sum $element2 >> chemin2
        elif test -d "$path2/$element2"
        then
            echo $element2 >> chemin2
        elif test -d "$path2/$element2"
            then
                exploreR2 $element2
        fi

    done
}


function complet {

    analyse
    exploreR $path
    exploreR2 $path2
}

complet

echo -e "\nNous avons trouvé $(cat chemin | wc -l)  fichiers dans la première arborescence"
echo -e "\nNous avons trouvé $(cat chemin2 | wc -l)  fichiers dans la seconde arborescence"
diff="$(diff chemin chemin2 -s)"
echo "${diff}" >> diff.txt
echo "Il y a $(cat diff.txt | wc -l) fichiers différents entre les deux arborescence" >> diff.txt
