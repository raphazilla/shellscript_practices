#!/usr/bin/env bash

echo "==== For 1"
for (( i = 0; i < 10; i++ )); do
    echo $i
done

echo "==== For 2 (seq)"
for i in $(seq 10)
do
    echo $i
done

echo "==== For 3 "
for i in {1..10}; do
    echo $i
done

echo "==== For 4 (array)"
frutas=(
    'laranja'
    'ameixa'
    'abacaxi'
    'melao'
    'jaca'
    'fruta do conde'
    )
for i in "${frutas[@]}"; do
    echo $i
done

echo "==== While "
contador=0
while [[ $contador -lt ${#frutas[@]} ]]
do
    echo $contador
    contador=$(($contador+1))   
done