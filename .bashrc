#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias i="yay -S --noconfirm"
alias r="yay -Rns"
alias u="yay -Syu --noconfirm"
alias s="yay -Ss"
alias q="yay -Q"
alias ff="fastfetch"

PS1='[\u@\h \W]\$ '


# import and set pywal colours to terminal
(cat ~/.cache/wal/sequences &)

source ~/.cache/wal/colors-tty.sh

