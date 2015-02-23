#!/bin/echo Warning: this file should be sourced

alias hist='cat ~/.zsh_history | grep '
# list
alias lh='ls -lhA'
alias lll='ls -lhAt | head -20'

alias v='vim -u ~/.vim/vimrc'
alias gpom='git push origin master'

alias skg='ssh-keygen'

# phptag
alias phptag='ctags --fields=+aimS --languages=php'

# lampp
lampp=/opt/lampp/lampp
alias www='cd /opt/lampp/htdocs'
alias lampp='sudo $lampp start'
alias lamppstop='sudo $lampp stop'
alias relampp='sudo $lampp restart'

#mongodb
mongopath=/opt/mongodb/bin
alias mgo='sudo $mongopath/mongo'
alias mgod='sudo $mongopath/mongod'

#pdt
alias pdt='sudo ~/zend-eclipse-php/zend-eclipse-php'
#}}}

#ssh
alias nssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no '

iscmd apt-get && {
    alias agi='sudo apt-get install '
    alias acs='apt-cache search '
}
