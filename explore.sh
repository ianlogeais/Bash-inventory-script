#!/bin/bash

function check
{
  # $(1:nb) = prend la variable 1 et lui enlève nb caractères
  # Exemple : rep=administrator1/templates/hathor/images et nb=14 ---->  $(rep:nb) = /templates/hathor/images
  # Donc si je fais $rep2$(rep:nb) ça donnera rep2 + /templates/hathor/images

  ls "$1" | while read element
  do
    if [ -f "$1/$element" ]
    then
      if [ ! -f "$DefaultRep${1:nb}/$element" ]
      then
          echo "DELETED / $DefaultRep${1:nb}/$element  ::  car $1/$element existe" >> listing.txt
      elif [ ! "$(md5sum "$1/$element" | cut -d " " -f 1)" = "$(md5sum "$DefaultRep${1:nb}/$element" | cut -d " " -f 1)" ]
      then
        echo "CHANGED / $DefaultRep${1:nb}/$element" >> listing.txt
      else
        echo "UNCHANGED / $DefaultRep${1:nb}/$element" >> listing.txt
      fi 
    elif [ -d "$1/$element" ]
    then
      check "$1/$element"
    fi
  done
 }

 function checkCreate
 {
   ls "$1" | while read element
   do
    if [ -f "$1/$element" ]
    then
      if [ ! -f "$2/$element" ]
      then
        echo "CREATED / $1/$element  ::  car $2/$element n'existe pas" >> listing.txt
      fi 
    elif [ -d "$1/$element" ]
    then
      checkCreate "$1/$element" "$2/$element"
    fi
   done
 }

echo -e "Liste des fichiers parcourus\n" > listing.txt

DefaultRep=$2
nb=${#1}

check $1
checkCreate $2 $1
