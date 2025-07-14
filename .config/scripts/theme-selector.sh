#!/usr/bin/env bash

wallpaper_dir="$HOME/.config/wallpapers"
rofi_theme_dir="$HOME/.config/rofi/themes"

# Get thumbnails of images from wallpaper directory and pipe to rofi to display
wallpapers=($(find -L "${wallpaper_dir}" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png -o -iname \*.gif \) | sort))
killall -9 rofi # if rofi is open already, close it
wallpaper=$(for wal in "$wallpaper_dir"/*.jpg; do echo -en "$wal\0icon\x1f$wal\n"; done | rofi -dmenu -show -theme ${rofi_theme_dir}/wallpaper-select.rasi)

# if wallpaper selected, pass to theme setting script
if [ -n "$wallpaper" ]; then
    swww img "$wallpaper" --transition-type any --transition-duration 1 --transition-bezier .36,.91,.58,.98
    wal -n -i "$wallpaper" --backend colorz
    cp "$wallpaper" "$HOME/.current_wallpaper"
fi

