#!/bin/sh
set -eu

configs="$(ls -1d "$HOME"/repos/*/ 2>/dev/null | xargs -n1 basename)"
[ -n "$configs" ] || exit 0
project=$(printf '%s\n' $configs | rofi -dmenu -theme "$HOME/.config/rofi/themes/default.rasi" -p 'Projects')
[ -n "$project" ] || exit 0
dir="$HOME/repos/$project"

# if session exists, attach to it
if tmux has-session -t "$project" 2>/dev/null; then
    cmd="tmux attach-session -t $project"
else
	# else create dev env (nvim window 1, terminal window 2) and attach
    cmd="$HOME/.config/scripts/devmode.sh $project"
fi
echo $cmd
kitty_cmd="kitty -e $cmd"
hyprctl dispatch exec "${kitty_cmd}"
