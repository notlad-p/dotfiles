#!/bin/bash

cache_dir=$HOME/.cache/quickshell/updates
cache_file="$cache_dir/updates_cache.json"
cache_max_age=1700

current_time=$(date +%s)

# optional argument disregard cache & force fetching updates
force=$1

if [[ -f "$cache_file" && ! $force == "true" ]]; then
  last_modified_time=$(stat -c %Y "$cache_file")

  if ((current_time - last_modified_time < cache_max_age)); then
    # notify-send "Updated updates from cache"
    # echo "From cache, last updated: $((current_time - last_modified_time)) sec ago"
    # jq '.arch' "$cache_file"
    cat "$cache_file"
    exit 0
  fi
fi

mkdir -p "$cache_dir"
touch -a "$cache_file"

official=$(checkupdates 2>/dev/null | wc -l)
aur=$(paru -Qum 2>/dev/null | wc -l)

# TODO: get last updated date from `/var/log/pacman.log`

jq -n ". | {arch: $official, aur: $aur }" >"$cache_file"
cat "$cache_file"
