#!/usr/bin/env bash
shopt -s nullglob

wallpaper_dir="$HOME/.config/wallpapers"
rofi_theme_dir="$HOME/.config/rofi/themes"

# Fastest file list using find, avoids globbing delays
mapfile -t wallpapers < <(find "$wallpaper_dir" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \))

# Build a rofi menu with image name and thumbnail
entries=""
for wal in "${wallpapers[@]}"; do
    name=$(basename "$wal")  # Show only filename
    entries+="${name}\0icon\x1f${wal}\n"
done

# Launch rofi with thumbnails and filenames
selected=$(echo -en "$entries" | rofi -dmenu -show -theme "${rofi_theme_dir}/wallpaper-select.rasi")

# Find the selected full path
for wal in "${wallpapers[@]}"; do
    if [[ "$(basename "$wal")" == "$selected" ]]; then
        wallpaper="$wal"
        break
    fi
done

# Apply wallpaper and theme
if [ -n "$wallpaper" ]; then
    swww img "$wallpaper" --transition-type any --transition-duration 1 --transition-bezier .36,.91,.58,.98
    wal -n -i "$wallpaper" --backend colorz
    cp "$wallpaper" "$HOME/.current_wallpaper"
fi
