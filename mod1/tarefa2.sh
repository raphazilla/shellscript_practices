#!/usr/bin/env bash
for i in {1..10}; do if [ $(($i % 2)) = 0 ]; then echo "O Numero $i e divisivel por 2"; fi; done