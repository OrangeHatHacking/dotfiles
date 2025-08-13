#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias i="yay -S --noconfirm"
alias r="yay -Rns"
alias rf="yay -Rns --noconfirm"
alias u="yay -Syu --noconfirm"
alias s="yay -Ss"
alias q="yay -Q"
alias ff="fastfetch"
alias {n,nv}="nvim"
alias h="history | grep "

PS1='[\u@\h \W]\$ '

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace
# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize
# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend

export EDITOR=nvim
export VISUAL=nvim

# import and set pywal colours to terminal
(cat ~/.cache/wal/sequences &)

source ~/.cache/wal/colors-tty.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# git lazy commit and push
gl() { git commit -am "$1" && git push; }
