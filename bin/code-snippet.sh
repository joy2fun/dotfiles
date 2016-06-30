#!/bin/bash

gitquiet="--quiet"
gitquiet=""
gitbin=$(which git)

csurl="git@git.oschina.net:home5u/code-snippets.git"
cspath=~/code-snippets

cmd=${1}
path=${2}

[ -z "$cmd" ] {
    echo "Usage: $0 {get|add|edit} {path}"
    exit 1
}

[ ! -d "$cspath" ] && {
    $gitbin clone $csurl $cspath
}

[ -d "$cspath" ] && {
    cd $cspath
    [ ! -d "$cspath/.git" ] && {
        echo "[$cspath] is not a git dir."
        exit 1
    }
    $gitbin clean -n -d -f $gitquiet
    $gitbin pull origin master
}

