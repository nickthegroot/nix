#!/bin/bash

# Fetch weather from wttr.in
# format=%t gives temperature e.g. "+47°F"
# tr -d '+' removes the plus sign
WEATHER=$(curl -s "wttr.in/?format=%t" | tr -d '+')

if [ -n "$WEATHER" ]; then
  sketchybar --set $NAME label="$WEATHER"
else
  sketchybar --set $NAME label="?"
fi