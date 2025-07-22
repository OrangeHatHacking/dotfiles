#! /usr/bin/env bash

media=$(playerctl metadata -f "{{artist}} - {{title}}")
echo "$media"
