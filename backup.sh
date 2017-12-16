#!/bin/bash

main(){

    IFS=$'\n'

    local list1=$(ls -1 "$1") 
    
    for i in $list1
    do      
        if [ ! -e "$2/$i" ]  && [ ! -d "$1/$i" ]
        then
            cp "$1/$i" "$2"
            echo "$3$i"
        elif [ ! -e "$2/$i" ]
        then
            mkdir "$2/$i"
            main "$1/$i" "$2/$i" "$i/"
        elif [ -d "$2/$i" ]
        then
            main "$1/$i" "$2/$i" "$i/"
        fi
    done
}

echo "Files copied from $1 to $2"
main $1 $2 ""
echo "Files copied from $2 to $1"
main $2 $1 "" 
