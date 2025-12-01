#!/bin/bash

# Checking and installing dependencies
dependencies=("slurp" "grim" "convert" "swappy")
for dep in "${dependencies[@]}"; do
    command -v "$dep" &> /dev/null || { echo "$dep not found, please install it."; exit 1; }
done
# echo "Step01"


# Capture screenshot
screenshot="$(slurp)"
# echo "Step02"

# Capture screenshot and save to specified directory
timestamp=$(date +"%Y%m%d_%H%M%S")
save_path=~/Pictures/Screenshots/
mkdir -p "$save_path"  # Ensure directory exists
screenshot_file="${save_path}screenshot_${timestamp}.png"

echo "Saved screenshot to $screenshot_file"

# Process the screenshot and copy to clipboard
grim -g "$screenshot" - | convert - -shave 4x2 PNG:- | wl-copy
# grim -g "$screenshot" -o "$screenshot_file" - | convert - -shave 4x2 PNG:- | wl-copy
# grim -g "$screenshot" "$screenshot_file" | convert - -shave 4x2 PNG:- | wl-copy
# grim -g "$screenshot" - | convert - -shave 4x2 PNG:- | wl-copy
# echo "Step03"

# # Notify screenshot has copied to clipboard
dunstify -t 3004 -u low -a screenshot "Screenshot copied to clipboard"
# # echo "Step04"
#
# # Paste to clipboard and use swappy for further processing
wl-paste | swappy -f -
# # echo "Step05"
