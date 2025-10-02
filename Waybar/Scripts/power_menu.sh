#!/bin/bash
options="Shutdown\nReboot\nLogout\nHibernate"
chosen=$(echo -e $options | wofi -dmenu -p "Power Menu:")

case "$chosen" in
  Shutdown)
    systemctl poweroff
    ;;
  Reboot)
    systemctl reboot
    ;;
  Logout)
    swaymsg exit
    ;;
  # Hibernatee
  #   systemctl hibernate
  #   ;;
esac

