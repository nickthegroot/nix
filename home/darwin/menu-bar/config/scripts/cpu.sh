#!/bin/bash

CORE_COUNT=$(sysctl -n hw.ncpu)
CPU_INFO=$(ps -A -o %cpu | awk '{s+=$1} END {print s}')
CPU_PERCENT=$(echo "scale=0; $CPU_INFO / $CORE_COUNT" | bc)

sketchybar --set $NAME label="$CPU_PERCENT%"