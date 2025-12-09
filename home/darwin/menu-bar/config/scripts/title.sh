#!/bin/bash

TITLE=$(aerospace list-windows --focused --format "%{window-title}")
APP=$(aerospace list-windows --focused --format "%{app-name}")

if [ "$TITLE" = "" ] && [ "$APP" = "" ]; then
  sketchybar --set title_proxy label=""
  sketchybar --animate circ 15 --set title y_offset=70
  sketchybar --set title label=""
else
  LABEL="$TITLE"
  if [ "$LABEL" = "" ]; then
    LABEL="$APP"
  fi

  if [ "$(sketchybar --query title_proxy | jq -r '.label.value')" != "$LABEL" ]; then
    sketchybar --set title_proxy label="$LABEL"
    sketchybar --animate circ 15 --set title y_offset=70 \
      --animate circ 10 --set title y_offset=7 \
      --animate circ 15 --set title y_offset=0

    sketchybar --set title label="$LABEL"
  fi
fi

