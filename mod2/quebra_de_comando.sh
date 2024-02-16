#!/usr/in/env bash

find / -iname "*.so"    \
       -user raphazilla \
       -type f          \
       -size +1M        \
       -exec ls {}      \;