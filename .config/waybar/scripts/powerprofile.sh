#!/usr/bin/env bash
set -euo pipefail

mode="${1-}"

if [[ "${mode}" == "toggle" ]]; then
  cur="$(powerprofilesctl get || echo unknown)"
  case "$cur" in
    performance) next="balanced" ;;
    balanced)    next="power-saver" ;;
    *)           next="performance" ;;
  esac
  powerprofilesctl set "$next"
fi

cur="$(powerprofilesctl get || echo unknown)"
icon=""   # performance
[[ "$cur" == "balanced"    ]] && icon=""
[[ "$cur" == "power-saver" ]] && icon=""

# Waybar JSON line
printf '{"text":"%s","tooltip":"Power profile: %s","class":["%s"]}\n' "$icon" "$cur" "$cur"

