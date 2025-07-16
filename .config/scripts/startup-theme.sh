previous_wallpaper=$(swww query | awk -F'image: ' '{print$2}')
wal -n -i "$previous_wallpaper" --backend colorz
cp "$previous_wallpaper" "$HOME/.current_wallpaper"

kvantum_dir="$HOME/.config/Kvantum/pywal"
cache_dir="$HOME/.cache/wal"

[[ -f "$cache_dir/pywal.kvconfig" && ! -e  "$kvantum_dir/pywal.kvconfig" ]] && ln -s "$cache_dir/pywal.kvconfig" "$kvantum_dir/pywal.kvconfig"
[[ -f "$cache_dir/pywal.svg" && ! -e "$kvantum_dir/pywal.svg" ]] && ln -s "$cache_dir/pywal.svg" "$kvantum_dir/pywal.svg"
