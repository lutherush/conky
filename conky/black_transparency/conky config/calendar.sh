#!/bin/sh
cal | sed -e "1,2d;s/^ *//g;s/  / /g;s/ /\n/g;s/$(date +%e)/\$\{color1\}&\$color/" | tr '\n' ' ' 
# borrowed from some arch linux site
