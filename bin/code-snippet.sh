#!/bin/bash

csurl="git@git.oschina.net:home5u/code-snippets.git"
cspath=~/code-snippets

cmd=${1}
path=${2}

cwd=$(pwd)
helpmsg="Usage: $0 {get|add|delete} {path}"
gitquiet="--quiet"
gitbin=$(which git)

[ -z "$cmd" ] && {
    echo $helpmsg
    exit 1
}

[ ! -d "$cspath" ] && {
    $gitbin clone $csurl $cspath $gitquiet
}

[ -d "$cspath" ] && {
    cd $cspath
    [ ! -d "$cspath/.git" ] && {
        echo "[$cspath] is not a git dir."
        exit 1
    }
    $gitbin clean -n -d -f $gitquiet $gitquiet
    $gitbin pull origin master $gitquiet >/dev/null
}

case $cmd in
    get )
        [ -z "$path" ] && {
            echo $helpmsg
            exit 1
        }

        if [ -f "$cspath/$path" ] ; then
            cat "$cspath/$path"
        elif [ -d "$cspath/$path" ] ; then
            cp -i -r "$cspath/$path" -t "$cwd"
        else
            echo "Remote not Found!"
            exit 1
        fi

    ;;

    add )
        if [ -e "$cwd/$path" ] ; then
            cp -rf "$cwd/$path" "$cspath"
        else
            echo "invalid path."
            exit 1
        fi

        $gitbin add -A > /dev/null
        $gitbin commit -a -m "ignore" $gitquiet >/dev/null
        $gitbin push origin master $gitquiet
    ;;

    delete )
        [ -e "$cspath/$path" ] && {
            rm -rf "$cspath/$path"
            $gitbin commit -a -m "ignore" $gitquiet >/dev/null
            $gitbin push origin master $gitquiet
        }

    ;;

    * )
        echo "unkonw cmd."
        echo $helpmsg
        exit 1
esac
