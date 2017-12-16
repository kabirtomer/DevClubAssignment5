#!/bin/bash
var=$(grep -P "\d* [+-/*]" $1)

IFS=$'\n'

counter=0

for i in $(grep -P "\d [+\-*/]" $1)
do
    operator=$(echo "$i" | cut -d " " -f 2)
    number=$(echo "$i" | cut -d " " -f 1)
    
    if [[ $operator == '/' ]]
    then 
        if [ $number -eq 0 ]
        then
            echo "Divide by zero"
            exit 1
        fi
        counter=$(($counter / $number))
    else
        counter=$(($counter $operator $number))
    fi
done
echo $counter
         
    
