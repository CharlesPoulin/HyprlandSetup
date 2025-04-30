#!/bin/bash

CURRENT_REFRESH=$(hyprctl monitors -j | jq -r '.[0].refreshRate')

if (( $(echo "$CURRENT_REFRESH > 100" | bc -l) )); then
    echo '{"text": "󰟾 165Hz", "tooltip": "Current refresh rate: 165Hz", "class": "high"}'
else
    echo '{"text": "󰽡 60Hz", "tooltip": "Current refresh rate: 60Hz", "class": "eco"}'
fi