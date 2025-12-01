#!/bin/bash

waybar_process_name="waybar"

if pgrep -x $waybar_process_name > /dev/null; then
	echo "Stopping the waybar"
    pkill -x $waybar_process_name
else
	echo "Starting the waybar"
    waybar &
fi

