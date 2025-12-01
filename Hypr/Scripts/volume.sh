#!/bin/bash

function notify_volume() {
  # Function to show brightness notification
  MAX_VOLUME=100
  CURRENT_VOLUME=$( pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//' ) 

  # VOLUME_PERCENT=$(bc <<< "scale=1; "$CURRENT_VOLUME" / "$MAX_VOLUME" * 100")
  VOLUME_PERCENT=$(bc <<< "$CURRENT_VOLUME * 100 / $MAX_VOLUME" | cut -d. -f1)

  #
  # dunstify -t 3000 -a "  Brightness" -h int:value:"$VOLUME_PERCENT" "%"
  # dunstify -t 3000 -i audio-volume-high -a " Volume" -h int:value:"$VOLUME_PERCENT" "%" -r 9992
  dunstify -t 3000 -i audio-volume-high -a " Volume" -h int:value:"$VOLUME_PERCENT" "$VOLUME_PERCENT%" -r 9992

  # BRIGHTNESS_PERCENT=$(bc <<< "$CURRENT_BRIGHTNESS * 100 / $MAX_BRIGHTNESS" | cut -d. -f1)

  # dunstify -t 3000 -a "  Brightness" -h int:value:"$BRIGHTNESS_PERCENT" "%"
  # dunstify -t 3000 -a " Brightness" -h int:value:"$BRIGHTNESS_PERCENT" "$BRIGHTNESS_PERCENT%" -r 9990
}

# Function to get the current volume
get_current_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//'
}

# Check command line arguments
if [[ "$#" != 1 || ! ("$1" == "inc" || "$1" == "dec" || "$1" == "mute" ) ]]; then
    printf "Usage: $0 [inc|dec|mute]\n"
    exit 1
fi

# Check if pactl is installed
if ! command -v pactl &> /dev/null; then
    echo "Error: pactl is not installed. Please install it and try again."
    exit 1
fi

# Perform volume adjustment
if [[ "$1" == "inc" ]]; then
    [ "$(get_current_volume)" -lt 150 ] && pactl set-sink-volume @DEFAULT_SINK@ +10%
	notify_volume
elif [[ "$1" == "dec" ]]; then
    pactl set-sink-volume @DEFAULT_SINK@ -10%
	notify_volume
elif [[ "$1" == "mute" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
	notify_volume
fi

