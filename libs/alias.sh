#!/bin/echo Warning: this file should be sourced

alias df='df -h'
alias reboot='sudo reboot'
alias poweroff='sudo poweroff'
alias lnmp='sudo lnmp'
alias tcpdump='sudo tcpdump'

alias tarxz='tar Jxf'
alias tarbz='tar jxf'
alias targz='tar zxf'

alias psg='ps aux|grep '
alias hist='cat ~/.zsh_history | grep '
# list
alias lh='ls -lhA'

alias v='vim -u ~/.vim/vimrc'
alias vv='sudo vim -u ~/.vim/vimrc'
alias gpo='git push origin'

alias mc='valgrind --tool=memcheck'

# phptag
alias phptag='ctags --fields=+aimS --languages=php'

alias php56='~/php56/bin/php'
alias php70='~/php70/bin/php'
alias phps='php -S 0.0.0.0:9080'
alias c='php -n ~/bin/composer'
alias composer='php -n ~/bin/composer'

#ssh
alias nssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no '

if [ $(uname -s) = "Darwin" ] ; then
    alias b='open http://cn.bing.com/'
    alias gh='open https://github.com/'
    alias java='/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/java'
else
    iscmd apt-get && {
        alias agi='sudo apt-get install '
        alias acs='apt-cache search '
    }
fi
