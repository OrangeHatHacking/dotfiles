#!/usr/bin/env bash

# This prevents errors if certain file types aren't found in the wallpaper_dir
shopt -s nullglob

wallpaper_dir="$HOME/.config/wallpapers"
rofi_theme_dir="$HOME/.config/rofi/themes"

# Get thumbnails of images from wallpaper directory and pipe to rofi to display
killall -9 rofi # if rofi is open already, close it
wallpaper=$(for wal in "$wallpaper_dir"/*.{jpg,jpeg,png,gif}; do echo -en "$wal\0icon\x1f$wal\n"; done | rofi -dmenu -show -theme ${rofi_theme_dir}/wallpaper-select.rasi)

# If an image is selected, set as wallpaper, generate pallette,
# and copy the image to .current_wallpaper for hyprlock
if [ -n "$wallpaper" ]; then
    swww img "$wallpaper" --transition-type any --transition-duration 1 --transition-bezier .36,.91,.58,.98
    wal -n -i "$wallpaper" --backend colorz
    cp "$wallpaper" "$HOME/.current_wallpaper"
fi

kvantum_dir="$HOME/.config/Kvantum/pywal"
cache_dir="$HOME/.cache/wal"

cp "$cache_dir/pywal.kvconfig" "$cache_dir/pywal.svg" "$kvantum_dir/"
