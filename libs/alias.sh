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

if [ -d ~/vimfiles ]; then
    alias v='vim -u ~/vimfiles/vimrc'
    alias vv='vim -u ~/vimfiles/vimrc'
else
    alias v='vim -u ~/.vim/vimrc'
    alias vv='sudo vim -u ~/.vim/vimrc'
fi

#alias mc='valgrind --tool=memcheck'

# phptag
alias phptag='ctags --fields=+aimS --languages=php'

#ssh
alias nssh='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no '

if [ $(uname -s) = "Darwin" ] ; then
    alias b='open http://cn.bing.com/'
    alias gh='open https://github.com/'
    alias java='/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/java'
else
    alias agi='sudo apt-get install '
    alias acs='apt-cache search '
fi

alias cpmakefile='cp ~/dotfiles/Makefile ./'
alias cs='~/dotfiles/bin/code-snippet.sh'

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

# vagrant
alias vg='vagrant'
alias vgs='vagrant global-status'
alias vgsus="vagrant global-status|grep 'running'|awk '{print \$1}'|xargs vagrant suspend"

# node
alias cnpm="npm --registry=https://registry.npm.taobao.org \
    --cache=$HOME/.npm/.cache/cnpm \
    --disturl=https://npm.taobao.org/dist \
    --userconfig=$HOME/.cnpmrc"

