#!/bin/bash

boot=$(date -d"$(uptime -s)" +%s)
now=$(date +%s)
s=$((now - boot))

d=''
days=$((s / 60 / 60 / 24))
if [ $days -gt 0 ]; then
  d="${days}d "
fi

h=''
hours=$((s / 60 / 60 % 24))
if [ $hours -gt 0 ]; then
  h="${hours}h "
fi

m="$((s / 60 % 60))m"

printf "%s%s%s" "$d" "$h" "$m"
