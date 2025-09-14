#! /usr/bin/env bash

concentration_mode=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')

if [ "$concentration_mode" = 0 ]; then
	pidof waybar && killall -9 waybar || hyprctl dispatch exec "waybar -c ~/.config/waybar/concentration_config.jsonc  -s ~/.config/waybar/concentration_style.css"
else
	pidof waybar && killall -9 waybar || hyprctl dispatch exec waybar 
fi
