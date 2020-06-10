#!/bin/echo Warning: this file should be sourced

[ -f ~/dotfiles/libs/alias.sh ] && {
    . ~/dotfiles/libs/alias.sh
}

alias e='explorer'

# winpty output is not a tty
alias p='php'
alias php='php'
unalias php

