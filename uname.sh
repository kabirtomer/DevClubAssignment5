#!/bin/bash

if [ ! $# = 2 ]
then
    echo "Two parameters are required"
    exit 1
elif [ ! -r "$1" ]
then
    echo "Unreadable input"
    exit 1
elif [ -d "$1" ]
then
    echo "Enter a file, not a directory"
    exit 1
fi

IFS=$'\n'

for i in $(cat "$1" | grep -P "(.*:){2}([0-9]*:){2}(.*:){2}.*$" ) 
do
    usr_name=$(echo "$i" | cut -d ":" -f 1)   
    full_name=$(echo "$i" | cut -d ":" -f 5)
    if [[ "$2" == "$usr_name" ]]
    then
        echo "$full_name"
        exit 
    fi
done
echo "Invalid Username"
exit 1
