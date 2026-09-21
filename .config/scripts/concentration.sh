#!/usr/bin/env bash

STATE_FILE="/tmp/hypr-concentration"

if [ ! -f "$STATE_FILE" ]; then
    touch "$STATE_FILE"
    notify-send "Concentration Mode [ENABLED]"
    hyprctl reload
    pidof waybar && killall -9 waybar
    hyprctl eval 'hl.exec_cmd("waybar -c ~/.config/waybar/concentration_config.jsonc -s ~/.config/waybar/concentration_style.css")'
else
    rm "$STATE_FILE"
    notify-send "Concentration Mode [DISABLED]"
    hyprctl reload
    pidof waybar && killall -9 waybar
    hyprctl eval 'hl.exec_cmd("waybar")'
fi
