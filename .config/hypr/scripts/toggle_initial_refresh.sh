#!/bin/bash

# Check if on battery or AC
on_battery=$(cat /sys/class/power_supply/AC/online)

if [ "$on_battery" -eq "0" ]; then
    # On battery, use 60Hz for power saving
    hyprctl keyword monitor "eDP-1,2560x1600@60,0x0,1"
else
    # On AC, use 165Hz for smooth experience
    hyprctl keyword monitor "eDP-1,2560x1600@165,0x0,1"
fi

# Update the waybar module
pkill -SIGRTMIN+10 waybar