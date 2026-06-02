#!/bin/bash

echo "Enter a number:"
read num

while [ $num -ge 0 ]
do
    echo "$num"
    num=$((num-1))
done

echo "Done!"