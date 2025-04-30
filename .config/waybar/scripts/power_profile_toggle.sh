#!/bin/bash

# This script toggles between power profiles using power-profiles-daemon
# Make sure it's installed: sudo apt install power-profiles-daemon

if command -v powerprofilesctl &> /dev/null; then
    current_profile=$(powerprofilesctl get)
    
    case "$current_profile" in
        "power-saver")
            powerprofilesctl set balanced
            notify-send "Power Profile" "Switched to Balanced Mode" -i battery
            ;;
        "balanced")
            powerprofilesctl set performance
            notify-send "Power Profile" "Switched to Performance Mode" -i battery
            ;;
        "performance")
            powerprofilesctl set power-saver
            notify-send "Power Profile" "Switched to Power Saver Mode" -i battery
            ;;
    esac
else
    notify-send "Error" "power-profiles-daemon is not installed" -i error
fi