#!/bin/bash

echo "$1 = $FOCUSED_WORKSPACE" >/tmp/space-"$1".log
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME icon.highlight=on
else
  sketchybar --set $NAME icon.highlight=off
fi
