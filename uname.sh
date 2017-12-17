#!/bin/bash

if [ ! $# = 2 ]
then
    echo "Two parameters are required"
    exit 1
elif [ ! -r "$1" ]
then
    echo "cannot open '$1': Permission denied"
    exit 1
elif [ -d "$1" ]
then
    echo "Enter a text file, not a directory"
    exit 1
elif [[ ! "$1" =~ .*\.txt$ ]]
then
    echo "Please enter a valid txt file"
    exit 1
fi

IFS=$'\n'
toggle=0

for i in $(cat "$1" | grep -P "(.*:){2}([0-9]*:){2}(.*:){2}.*$" ) 
do
    toggle=1
    usr_name=$(echo "$i" | cut -d ":" -f 1)   
    full_name=$(echo "$i" | cut -d ":" -f 5)
    if [[ "$2" == "$usr_name" ]]
    then
        echo "$full_name"
        exit 
    fi
done

if [ $toggle = 0 ]
then 
    echo "File contained no valid information"
    exit 1
fi

echo "Invalid Username"
exit 1
