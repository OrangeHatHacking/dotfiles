#!/usr/bin/env bash

player=$(playerctl metadata --format "{{xesam:url}}" | awk -F '/' '{ print $3 }')
next=""
prev=""
if [[ "$player" =~ [Ss]potify ]]; then
    if [[ "$1" == "--next" ]]; then
	echo "$next"
    elif [[ "$1" == "--prev" ]]; then
	echo "$prev"
    else
	echo ""
    fi
else
    echo ""
fi
