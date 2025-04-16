#!/bin/bash
# Simplified version of original by koeqaife
# https://github.com/koeqaife/hyprland-material-you/blob/5f7efccaf5c5745466734824c20f25dca73fd4c7/ags/scripts/weather.sh

# cache_dir=$HOME/.config/ags/cache
# cache_file="$cache_dir/weather_cache.json"
cache_dir=$HOME/.cache/ags/weather
cache_file="$cache_dir/weather_cache.json"
cache_max_age=550

lat=$1
lon=$2
api_key=$3

mkdir -p $cache_dir
touch -a $cache_file

current_time=$(date +%s)

if [[ -f "$cache_file" ]]; then
  last_modified_time=$(stat -c %Y "$cache_file")

  # if [[ $((current_time - last_modified_time)) -lt $cache_max_age ]]; then
  if ((current_time - last_modified_time < cache_max_age)); then
      cat "$cache_file"
      # notify-send "Updated weather from cache"
      # echo "From cache: $((current_time - last_modified)) sec"
      exit 0
  fi
fi
weather=$(
curl --request POST \
     --url "https://api.tomorrow.io/v4/timelines?apikey=$api_key" \
     --compressed \
     --header 'Accept-Encoding: deflate, gzip, br' \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --data "
{
  \"location\": \"$lat, $lon\",
  \"fields\": [
    \"temperature\",
    \"humidity\",
    \"temperatureApparent\",
    \"windDirection\",
    \"windSpeed\",
    \"weatherCode\",
    \"weatherCodeFullDay\",
    \"weatherCodeDay\",
    \"weatherCodeNight\",
    \"temperatureMax\",
    \"temperatureMin\",
    \"temperatureApparentMax\",
    \"temperatureApparentMin\",
    \"precipitationProbability\",
    \"precipitationIntensity\",
    \"precipitationType\"
  ],
  \"units\": \"imperial\",
  \"timesteps\": [
    \"1h\",
    \"1d\",
    \"current\"
  ],
  \"startTime\": \"now\",
  \"endTime\": \"nowPlus3d\",
  \"dailyStartHour\": 6
}
"
)
# weather=$(echo '{"type":"Bar","id":"1","title":"Foo"}')


echo "$weather" >"$cache_file"
cat "$cache_file"
# notify-send "Updated weather from API"
# echo "From API"
