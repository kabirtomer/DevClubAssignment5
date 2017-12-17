#!/bin/bash

nest_test(){
    
    local curr_dir=$(pwd)

    cd "$1"
    local dir1=$(pwd)

    cd "$curr_dir"
    cd "$2"
    local dir2=$(pwd)

    if [[ "$dir1" =~ "$dir2".+ ]] || [[ "$dir2" =~ "$dir1".+ ]]
    then
        echo "Nested directories cannot be backed up to each other"
        exit 1
    fi
    cd "$curr_dir"
}


main(){
    
    IFS=$'\n' 
    
    local list1=$(ls -1 "$1") 
    
    for i in $list1
    do      
        if [ ! -e "$2"/"$i" ]  && [ ! -d "$1"/"$i" ]
        then
            cp "$1"/"$i" "$2"
            echo "$3$i"
        elif [ ! -e "$2"/"$i" ]
        then
            mkdir "$2"/"$i"
            main "$1"/"$i" "$2"/"$i" "$i"/
        elif [ -d "$2"/"$i" ]
        then
            main "$1"/"$i" "$2"/"$i" "$i"/
        fi
    done
}

if [ ! $# = 2 ]
then
    echo "Please enter only two parameters"
    exit 1
elif [ ! -d "$1" ]
then
    echo "cannot access '$1': No such directory"
    exit 1
elif [ ! -d "$2" ]
then
    echo "cannot access '$2': No such directory"
    exit 1
elif [ ! -r "$1" ]
then
    echo "cannot open directory '$1': Permission denied"
    exit 1
elif [ ! -r "$2" ]
then
    echo "cannot open directory '$2': Permission denied"
    exit 1
fi

nest_test "$1" "$2"

echo "Files copied from $1 to $2: "
main "$1" "$2" ""
echo "Files copied from $2 to $1: "
main "$2" "$1" "" 
