#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l'
alias lla='ls -la'
alias :q='exit'
alias df='df -h'
# Autocompletion avec sudo
complete -cf sudo

# Shell 'a la vim'
set -o vi

# Exportation de variables
export EDITOR="vim"

PS1='>>$(uname -s -r)<<\n[\u@\h \W]\$ '
