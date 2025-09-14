#!/usr/bin/env bash

set -euo pipefail

SCRIPT="$0"
MODE="${1-}"   # projects or sessions 
SELECTED_ENTRY="${2-}"

list_projects() {
	projects="$(ls -1d "$HOME"/repos/*/ 2>/dev/null | xargs -n1 basename)"
	projects_menu="===Create New Project===\n$projects"
	printf '%b' "$projects_menu" 
}

list_sessions() {
  tmux ls 2>/dev/null | cut -d: -f1 || true
}

# no mode passed 
if [ -z "$MODE" ]; then
  rofi \
    -modi "Projects:$SCRIPT projects,Sessions:$SCRIPT sessions" \
    -show Projects \
    -p "Select" \
    -theme "$HOME/.config/rofi/themes/project_sessions.rasi"
fi

case "$MODE" in
  projects)
    if [ -z "$SELECTED_ENTRY" ]; then
      list_projects
    else
		# logic for creating new project in $HOME/repos
		if [ "$SELECTED_ENTRY" = "===Create New Project===" ]; then
			killall -9 rofi
			NEW_PROJECT_NAME=$( rofi -dmenu -theme "$HOME/.config/rofi/themes/project_sessions.rasi" \
						-p 'New Project Name'\
						-theme-str 'window { location: north; y-offset: 300;} listview { enabled: false; } mode-switcher {enabled: false; }')
			mkdir -p "$HOME/repos/$NEW_PROJECT_NAME"
			SELECTED_ENTRY="$NEW_PROJECT_NAME"
		fi

		[ -n "$SELECTED_ENTRY" ] || exit 0

		# if tmux session exists, attach to it
		if tmux has-session -t "$SELECTED_ENTRY" 2>/dev/null; then
			KITTY_CMD="tmux attach-session -t $SELECTED_ENTRY"
		else
			# else create dev env (nvim window 1, terminal window 2) and attach
			KITTY_CMD="$HOME/.config/scripts/devmode.sh $SELECTED_ENTRY $HOME/repos/$SELECTED_ENTRY"
		fi

		pidof kitty && killall -9 kitty
		killall -9 rofi
		hyprctl dispatch exec "kitty -e $KITTY_CMD"
		exit 0
    fi
    ;;
  sessions)
    if [ -z "$SELECTED_ENTRY" ]; then
      list_sessions
    else
		KITTY_CMD="tmux attach-session -t $SELECTED_ENTRY"

		pidof kitty && killall -9 kitty
		killall -9 rofi
		hyprctl dispatch exec "kitty -e $KITTY_CMD"
		exit 0
    fi
    ;;
esac
