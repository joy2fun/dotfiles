#!/bin/echo Warning: this file should be sourced

[ -f ~/dotfiles/libs/alias.sh ] && {
    . ~/dotfiles/libs/alias.sh
}

alias e='explorer'

# winpty output is not a tty
alias p='php'
alias php='php'
unalias php

# github
alias mygh='start http://github.com/joy2fun'

# search
alias b='start http://cn.bing.com/search?q='
alias ghs='start https://github.com/search?q='
alias phppkg='start https://packagist.org/search/?q='
