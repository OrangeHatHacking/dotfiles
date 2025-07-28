#! /usr/bin/env bash

pidof waybar && killall -9 waybar ||waybar &
