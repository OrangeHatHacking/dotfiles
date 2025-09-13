#!/bin/sh
set -eu

base_dir="$HOME/repos/"

projects="$(ls -1d "$HOME"/repos/*/ 2>/dev/null | xargs -n1 basename)"
menu="===Create New Project===\n$projects"

project=$(printf '%b' "$menu" | rofi -dmenu -theme "$HOME/.config/rofi/themes/default.rasi" -p 'Projects')

if [ "$project" = "===Create New Project===" ]; then
	new_project_name=$(echo | rofi -dmenu -theme "$HOME/.config/rofi/themes/default.rasi" -p 'New Project Name' -theme-str 'window { background-color: @background; } listview { enabled: false; }')
	mkdir -p "$base_dir""$new_project_name"
	project="$new_project_name"
fi

[ -n "$project" ] || exit 0

dir="$HOME/repos/$project"

# if session exists, attach to it
if tmux has-session -t "$project" 2>/dev/null; then
    tmux attach-session -t $project
else
	# else create dev env (nvim window 1, terminal window 2) and attach
    $HOME/.config/scripts/devmode.sh $project
fi

