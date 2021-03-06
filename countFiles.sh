#!/bin/bash 

if [ $# -gt 2 ]
then
    echo "Too many arguments"
    exit 1
elif [ $# -lt 1 ]
then 
    echo "Directory required"
    exit 1
elif [ ! -d "$1" ]
then
    echo "cannot access '$1': No such directory"
    exit 1
elif [ ! -r "$1" ]
then
    echo "cannot open directory '$1': Permission denied"
    exit 1
fi

var=$(ls -Al "$1") 

if [ ! $? -eq 0 ]
then 
    exit 1
fi

echo "$var" | tail -n+2 | grep -v "^d" | grep "$2$" | wc -l


