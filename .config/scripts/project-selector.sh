#!/bin/sh
set -eu

configs="$(ls -1d "$HOME"/repos/*/ 2>/dev/null | xargs -n1 basename)"
[ -n "$configs" ] || exit 0
chosen=$(printf '%s\n' $configs | rofi -dmenu -theme "$HOME/.config/rofi/themes/default.rasi" -p 'Projects')
[ -n "$chosen" ] || exit 0
dir="$HOME/repos/$chosen"

# if session exists, attach to it
if tmux has-session -t "$chosen" 2>/dev/null; then
    tmux attach-session -t "$chosen"
else
	# else create dev env (nvim window 1, terminal window 2) and attach
    tmux new-session -d -s "$chosen" -c "$dir" -n neovim "nvim ."
    tmux new-window -t "$chosen:" -n terminal -c "$dir"
    tmux a -t "$chosen:neovim"
fi
