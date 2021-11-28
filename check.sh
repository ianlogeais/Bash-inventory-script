#!/bin/bash

function check
{

  ls "$1" | while read element
  do
    if [ -f "$1/$element" ]
    then
      if [ ! -f "$DefaultRep${1:nb}/$element" ]
      then
          echo "DELETED / $DefaultRep${1:nb}/$element" >> listing.txt
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
        echo "CREATED / $1/$element" >> listing.txt
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
