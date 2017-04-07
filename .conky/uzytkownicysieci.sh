#!/bin/bash
if [ -e ~/.list ]; then
nbtscan 192.168.1.0/24 > .list
else 
touch ~/.list 
nbtscan 192.168.1.0/24 > .list
fi

if [ -e ~/.ile ]; then
wc -l ~/.list > ~/.ile
else
touch ~/.ile
wc -l ~/.list > ~/.ile
fi
#wynik="$[$(cat ~/.ile | cut -d' ' -f1)-4]"
#wynik="$[$(cat ~/.ile | cut -c1)]"
cat ~/.list | tail -n10 | cut -d" " -f1-13
