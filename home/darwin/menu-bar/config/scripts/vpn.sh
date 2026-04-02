#!/bin/bash

RED=0xFFF38BA8
GREEN=0xFFA6E3A1
INTERFACE=$(ifconfig utun4 2>/dev/null)

if [ -n "$INTERFACE" ]; then
  sketchybar --set $NAME icon=󰦝 icon.color=$GREEN label="VPN"
else
  sketchybar --set $NAME icon=󰦞 icon.color=$RED label="VPN"
fi
