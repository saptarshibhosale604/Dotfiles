#!/bin/bash

CSS_FILE="$HOME/.config/waybar/style.css"
TOTAL_LINES=$(wc -l < "$CSS_FILE")

# Extract last 3 lines
LAST_LINES=$(tail -n 3 "$CSS_FILE")

if echo "$LAST_LINES" | grep -q "opacity: 0;"; then
    # Replace opacity: 0; with opacity: 1; in last 3 lines only
    sed -i "$((TOTAL_LINES-2)),$ s/opacity: 0;/opacity: 1;/" "$CSS_FILE"
    echo "Modules enabled (opacity set to 1)."
else
    # Replace opacity: 1; with opacity: 0; in last 3 lines only
    sed -i "$((TOTAL_LINES-2)),$ s/opacity: 1;/opacity: 0;/" "$CSS_FILE"
    echo "Modules disabled (opacity set to 0)."
fi

# Restart Waybar to apply changes
pkill waybar
waybar &
