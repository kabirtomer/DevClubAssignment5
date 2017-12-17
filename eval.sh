#!/bin/bash

if [ ! $# = 1 ]
then
    echo "Please provide only one input file"
    exit 1
elif [ -d "$1" ]
then
    echo "Please enter a file, not a directory"
    exit 1
elif [ ! -r "$1" ]
then
    echo "cannot open '$1': Permission denied"
    exit 1
fi

IFS=$'\n'

counter=0
toggle=0

for i in $(grep -P "\d [+\-*/]$" "$1")

do
    toggle=1
    operator=$(echo "$i" | cut -d " " -f 2)
    number=$(echo "$i" | cut -d " " -f 1)
    
    if [[ $operator == '/' ]] && [ $number -eq 0 ]
    then
        echo "Divide by zero"
        exit 1  
    else
        counter=$(($counter $operator $number))
    fi
done

if [ $toggle = 0 ]
then
    echo "No valid commands found"
    exit 1
fi

echo $counter
         
    
