#! /usr/bin/env bash

shopt -s nullglob

previous_wallpaper=$(swww query | awk -F'image: ' '{print$2}')

if [[ ! -e $previous_wallpaper ]]; then
	files=(.config/wallpapers/*)
	previous_wallpaper=$files
fi

swww img "$previous_wallpaper" --transition-duration 0
wal -n -i "$previous_wallpaper" --backend colorz
cp "$previous_wallpaper" "$HOME/.current_wallpaper"

kvantum_dir="$HOME/.config/Kvantum/pywal"
cache_dir="$HOME/.cache/wal"

# if the pywal outputs for kvantum theme exist,
# and the symlink files dont exist,
# then create the symlinks
[[ -f "$cache_dir/pywal.kvconfig" && ! -e  "$kvantum_dir/pywal.kvconfig" ]] && ln -s "$cache_dir/pywal.kvconfig" "$kvantum_dir/pywal.kvconfig"
[[ -f "$cache_dir/pywal.svg" && ! -e "$kvantum_dir/pywal.svg" ]] && ln -s "$cache_dir/pywal.svg" "$kvantum_dir/pywal.svg"
