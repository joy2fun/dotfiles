# bash
alias hist='cat ~/.bash_history | grep '
# list
alias lh='ls -lhA'
alias lll='ls -lhAt | head -20'

# lampp
lampp=/opt/lampp/lampp

alias www='cd /opt/lampp/htdocs'
alias lampp='sudo $lampp start'
alias lamppstop='sudo $lampp stop'
alias relampp='sudo $lampp restart'

alias dotbackup='~/dotfiles/helper -b'

#mongodb
mongopath=/opt/mongodb/bin
alias mgo='sudo $mongopath/mongo';
alias mgod='sudo $mongopath/mongod';
alias pdt='sudo ~/zend-eclipse-php/zend-eclipse-php'
