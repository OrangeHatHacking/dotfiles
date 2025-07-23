#!/usr/bin/env bash

status=$(playerctl status)
icon=""

[[ "$status" == "Playing" ]] && icon=""
[[ "$status" == "Paused" ]] && icon=""

echo "$icon"
