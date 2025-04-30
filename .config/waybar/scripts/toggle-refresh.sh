#!/bin/bash
CURRENT=$(hyprctl monitors | grep "eDP-1" | grep -oP '\d+Hz' | grep -oP '\d+')
if [ "$CURRENT" = "165" ]; then
    echo '{"text": "🚀 165Hz", "tooltip": "Click to switch to 60Hz"}'
else
    echo '{"text": "🌀 60Hz", "tooltip": "Click to switch to 165Hz"}'
fi
