#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


# import and set pywal colours to terminal
(cat ~/.cache/wal/sequences &)

source ~/.cache/wal/colors-tty.sh

