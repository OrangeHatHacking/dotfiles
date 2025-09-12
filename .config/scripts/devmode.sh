#!/usr/bin/env bash
project=$1
dir="$HOME/repos/$project"
tmux new-session -d -s ${project} -c ${dir} -n neovim 'nvim .'
tmux new-window -t ${project}: -n terminal -c ${dir}
tmux a -t ${project}:neovim
