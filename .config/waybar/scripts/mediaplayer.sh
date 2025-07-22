#! /usr/bin/env bash

media=$(playerctl metadata -f "{{artist}} - {{title}}")

zscroll -p " | " --delay 0.2 --length 30 --match-command "playerctl status" --match-text "Playing" "--scroll 1" --match-text "Paused" "--scroll 0" --update-interval 1 --update-check true "echo $media"; wait
