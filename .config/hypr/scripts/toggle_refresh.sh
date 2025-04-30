#!/bin/bash

CURRENT_REFRESH=$(hyprctl monitors -j | jq -r '.[0].refreshRate')

if (( $(echo "$CURRENT_REFRESH > 100" | bc -l) )); then
    hyprctl keyword monitor "eDP-1,2560x1600@60,0x0,1"
    notify-send "Display" "Refresh rate set to 60Hz" -i display
else
    hyprctl keyword monitor "eDP-1,2560x1600@165,0x0,1"
    notify-send "Display" "Refresh rate set to 165Hz" -i display
fi

# Update the waybar module
pkill -SIGRTMIN+10 waybar