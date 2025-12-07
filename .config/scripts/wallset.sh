#!/bin/bash

WALL_DIR="$HOME/Pictures/Wallpapers"
CACHE_DIR="$HOME/.config/rofi/thumbs"
mkdir -p "CACHE_DIR"
HASH_FILE="$CACHE_DIR/.wall_hash"

CWD="$(pwd)"

IFS=$'\n'

CURRENT_HASH=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -printf "%P %T@\n" | sha256sum | cut -d' ' -f1)

if [ -f "$HASH_FILE" ]; then
  OLD_HASH=$(cat "$HASH_FILE")
else
  OLD_HASH=""
fi

if [ "$CURRENT_HASH" != "$OLD_HASH" ]; then
  notify-send "Wallpapers changed" "Regenerating cache"

  for thumb in "$CACHE_DIR"/*;do
    [[ "$(basename "$thumb")" == ".wall_hash" ]] && continue
    orig="$WALL_DIR/$(basename "$thumb")"
    [ -f "$orig" ] || rm -f "$thumb"
  done

  for img in "$WALL_DIR"/*.{jpg,png,jpeg,gif}; do 
    [ -e "$img" ] || continue
    thumb="$CACHE_DIR/$(basename "$img")"
    if [ ! -f "$thumb" ]; then
      magick "$img" -resize 512x512^ -gravity center -extent 512x512 "$thumb"
    fi
  done

  echo "$CURRENT_HASH" > "$HASH_FILE"

fi

cd "$CACHE_DIR" || exit 1

SELECTED_WALL=$(for f in *; do
  echo -en "$(basename "$f")\0icon\x1f$f\n";
done | rofi -dmenu -theme "~/.config/rofi/wall.rasi" -p "wall")

if [ -n "$SELECTED_WALL" ]; then
  CACHED="$CACHE_DIR/$SELECTED_WALL"
  ORIGINAL="$WALL_DIR/$SELECTED_WALL"

  notify-send "Changing Wallpaper" "$SELECTED_WALL"

  matugen image "$ORIGINAL"

  magick "$ORIGINAL" -strip -resize 512x512^ -gravity center -extent 512x512 -quality 90 $HOME/.config/rofi/currentWal.thumb 

  rm -rf ~/.cache/fastfetch/
  cp $HOME/.config/rofi/currentWal.thumb $HOME/.config/fastfetch/currWall.thumb

  cp $HOME/.config/rofi/currentWal.thumb $HOME/.config/hypr/currWall.thumb

  # magick "$ORIGINAL" -resize 512x512^ -gravity center -extent 512x512 $HOME/.config/rofi/currentWal.thumb

  killall -9 waybar
  waybar
  swaync-client -rs
fi
