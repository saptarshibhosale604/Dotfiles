#!/bin/sh

# Send a notification when the laptop is plugged in/unplugged
# Add the following to /etc/udev/rules.d/60-power.rules (replace USERNAME with your user)

# ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", \
# ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/ssbArch/.Xauthority" \
# RUN+="/usr/bin/su ssbArch -c '/home/ssbArch/.config/dunst/Scripts/battery-charging-alert.sh discharging'"
# ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", \
# ENV{DISPLAY}=":0", ENV{XAUTHORITY}="/home/ssbArch/.Xauthority" \
# RUN+="/usr/bin/su ssbArch -c '/home/ssbArch/.config/dunst/Scripts/battery-charging-alert.sh charging'"

export XAUTHORITY=~/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

BATTERY_STATE=$1
BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')
# My battery takes a couple of seconds to recognize as charging, so this is a hacky way to deal with it
# case "$BATTERY_STATE" in
# 	"charging") BATTERY_CHARGING="Charging" ; BATTERY_ICON="charging" ;;
# 	"discharging") BATTERY_CHARGING="Disharging" ; BATTERY_ICON="discharging" ;;
# esac
#
# # Send notification
# notify-send "${BATTERY_CHARGING}" "${BATTERY_LEVEL}% of battery charged." -u normal -i "battery-${BATTERY_ICON}" -t 5000 -r 9991
if [ "$BATTERY_STATE" = "charging" ]; then 
    notify-send "Power cable is plugged in. &#xf244; ${BATTERY_LEVEL}%" -u normal -i "battery-${BATTERY_ICON}" -t 5000 -r 9991
elif [ "$BATTERY_STATE" = "discharging" ]; then
    notify-send "Power cable is unplugged. &#xf240; ${BATTERY_LEVEL}%" -u normal -i "battery-${BATTERY_ICON}" -t 5000 -r 9991
fi

