#!/bin/echo Warning: this file should be sourced

alias df='df -h'

alias tarxz='tar Jxf'
alias tarbz='tar jxf'
alias targz='tar zxf'

alias psg='ps aux|grep '
alias hist='cat ~/.zsh_history | grep '

if [ -d ~/vimfiles ]; then
    alias v='vim -u ~/vimfiles/vimrc'
    alias vv='vim -u ~/vimfiles/vimrc'
else
    alias v='vim -u ~/.vim/vimrc'
    alias vv='sudo vim -u ~/.vim/vimrc'
fi


#ssh
alias nssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no '

if [ $(uname -s) = "Darwin" ] ; then
    alias gh='open https://github.com/'
else
    alias agi='sudo apt-get install '
    alias acs='apt-cache search '
fi

# common
alias t='tail -f'

alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lh='ls -lhA'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# git
alias g='git'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'
alias gpo='git push origin'
alias gst='git status'
alias gcp='git cherry-pick'
alias gcam='git commit -a -m'
alias glol="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias k="kubectl --insecure-skip-tls-verify=true "
alias kr="kubectl --insecure-skip-tls-verify=true get ingressroute -o custom-columns='NAME:.metadata.name, ROUTE:.spec.routes[*].match' "
alias h=helm

alias curljson='curl -H "Content-Type: application/json"'

