#
# ~/.bashrc
#
. ~/.cache/wal/colors.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias yi="yay -S --noconfirm"
alias yr="yay -Rns"
alias yrf="yay -Rns --noconfirm"
alias yu="yay -Syu --noconfirm"
alias ys="yay -Ss"
alias yq="yay -Q"

alias i="sudo pacman -S --noconfirm"
alias r="sudo pacman -Rns"
alias rf="sudo pacman -Rns --noconfirm"
alias u="sudo pacman -Syu --noconfirm"
alias s="sudo pacman -Ss"
alias q="sudo pacman -Q"

alias ff="clear && fastfetch"
alias {n,nv}="nvim"
alias h="history | grep "

set_pywal_prompt() {

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
}

PROMPT_COMMAND="source $HOME/.config/scripts/update-bash-prompt.sh"

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace
# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize
# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend

export EDITOR=nvim
export VISUAL=nvim
export PROMPT_DIRTRIM=3


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# git lazy commit and push
gl() { git commit -am "$1" && git push; }
