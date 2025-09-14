#!/usr/bin/env bash
concentration_mode=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$concentration_mode" = 1 ] ; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword animation borderangle,0;\
        keyword decoration:shadow:enabled 0;\
	    keyword decoration:fullscreen_opacity 1;\
        keyword general:gaps_in 0;\
        keyword decoration:blur:size 9;\
        keyword decoration:blur:passes 9;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0;\
		keyword decoration:active_opacity 1.0;\
		keyword decoration:inactive_opacity 1.0"
	notify-send "Concentration Mode [ENABLED]"
	pidof waybar && killall -9 waybar
	hyprctl dispatch exec "waybar -c ~/.config/waybar/concentration_config.jsonc  -s ~/.config/waybar/concentration_style.css"
    exit
else
	notify-send "Concentration Mode [DISABLED]"
    hyprctl reload
	pidof waybar && killall -9 waybar
	hyprctl dispatch exec waybar 
    exit 0
fi
exit 1
