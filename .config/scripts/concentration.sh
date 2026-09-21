#!/usr/bin/env bash
concentration_mode=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$concentration_mode" = "true" ] ; then
    hyprctl eval '
        hl.config({
            animations = { enabled = false },
            decoration = {
                shadow = { enabled = false },
                fullscreen_opacity = 1,
                blur = { size = 9, passes = 9 },
                rounding = 0,
                active_opacity = 1.0,
                inactive_opacity = 1.0,
            },
            general = {
                gaps_out = { top = 0, right = 0, bottom = 0, left = 0 },
                gaps_in = 0,
                border_size = 1,
            },
        })
    '
	notify-send "Concentration Mode [ENABLED]"
	pidof waybar && killall -9 waybar
	hyprctl eval 'hl.exec_cmd("waybar -c ~/.config/waybar/concentration_config.jsonc -s ~/.config/waybar/concentration_style.css")'
    exit
else
	notify-send "Concentration Mode [DISABLED]"
    hyprctl reload
	pidof waybar && killall -9 waybar
	hyprctl eval 'hl.exec_cmd("waybar")'
    exit 0
fi
exit 1
