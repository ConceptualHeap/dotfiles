#!/bin/bash

# Options
options=" \n \n \n \n "

chosen="$(echo -e "$options" | rofi -dmenu -i -p "Power Menu" -theme "/home/osaka/.config/rofi/config-powermenu.rasi")"

case "$chosen" in
    " ") 
        hyprlock ;; # loginctl lock-session ;;
    " ") 
        loginctl terminate-user $USER ;;
    " ") 
        systemctl reboot ;;
    " ") 
        systemctl poweroff ;;
    " ") 
        systemctl suspend ;;
    *) exit 1 ;;
esac

