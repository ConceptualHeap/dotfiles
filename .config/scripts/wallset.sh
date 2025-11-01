#!/bin/bash

WALL_DIR="$HOME/Pictures/Wallpapers"

CWD="$(pwd)"

cd "$WALL_DIR" || exit 1

IFS=$'\n'

SELECTED_WALL=$(for a in *.jpg *.png *.gif; do echo -en "$a\0icon\x1f$a\n"; done | rofi -dmenu -theme "/home/osaka/.config/rofi/wall.rasi" -p "wall")

if [ -n "$SELECTED_WALL" ]; then
  notify-send "Changing Wallpaper" "$SELECTED_WALL"
  matugen image "$SELECTED_WALL"
  killall -9 waybar
  waybar
  swaync-client -rs
  killall -9 swayosd-server
  swayosd-server -s ~/.config/swayosd/style.css
fi

echo "$CWD" || exit
