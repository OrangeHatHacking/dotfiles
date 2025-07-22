#! /usr/bin/env bash

media=$(playerctl metadata -f "{{artist}} - {{title}}")

player=$(playerctl metadata --format "{{xesam:url}}" | awk -F '/' '{ print $3 }')

declare -A icons
icons[spotify]=""
icons[youtube]=""
icons[default]="🎜"

icon=${icons[default]}

[[ "$player" =~ [Ss]potify ]] && icon=${icons[spotify]} 
[[ "$player" =~ [Yy]outube ]] && icon=${icons[youtube]} 

zscroll -p " | " \
    --before-text "$icon " \
    --delay 0.2 \
    --length 30 \
    --match-command "playerctl status" \
    --match-text "Playing" "--scroll 1" \
    --match-text "Paused" "--scroll 0" \
    --update-interval 1 \
    --update-check true \
    "echo $media"
wait
