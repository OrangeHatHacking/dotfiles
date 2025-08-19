#! /usr/bin/env bash
. ~/.cache/wal/colors.sh

hex_to_ansi() {
    local hex=${1#\#}
    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))
    printf '\[\e[38;2;%s;%s;%sm\]' $r $g $b
}

# Example prompt using pywal colors
CUSER=$(hex_to_ansi $color2)
CAT=$(hex_to_ansi $color1)
CHOST=$(hex_to_ansi $color4)
CDIR=$(hex_to_ansi $color6)
CRESET='\[\e[0m\]'

export PS1="${CUSER}\u${CAT}@${CHOST}\h ${CDIR}[\w] ${CRESET}\\$ "
