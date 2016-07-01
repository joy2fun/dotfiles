#!/bin/sh

#-------- configuration begin --------

csgit="git@git.oschina.net:home5u/code-snippets.git"
csprefix="https://git.oschina.net/home5u/code-snippets/blob/master"
cspath=~/code-snippets/

#-------- configuration end --------

cmd=${1}
path=${2}

cwd=$(pwd)
helpmsg="Usage: $0 {get|add|delete|view} {path}"
gitquiet="--quiet"
gitbin=$(which git)
cpbin=$(which cp)
rmbin=$(which rm)

[ -z "$cmd" ] && {
    echo $helpmsg
    exit 1
}

[ ! -d "$cspath" ] && {
    $gitbin clone $csgit $cspath $gitquiet
}

git_clean(){
    $gitbin clean -n -d -f $gitquiet $gitquiet >/dev/null 2>&1
}

git_update(){
    [ -d "$cspath" ] && {
        cd $cspath
        [ ! -d "$cspath/.git" ] && {
            echo "[$cspath] is not a git dir."
            exit 1
        }
        git_clean
        $gitbin pull origin master $gitquiet >/dev/null
    }
}

case $cmd in
    get )
        [ -z "$path" ] && {
            echo $helpmsg
            exit 1
        }

        git_update

        if [ -f "$cspath/$path" ] ; then
            cat "$cspath/$path"
        elif [ -d "$cspath/$path" ] ; then
            $cpbin -i -r "$cspath/$path" -t "$cwd"
        else
            echo "Remote not Found!"
            exit 1
        fi

    ;;

    add )
        if [ -e "$cwd/$path" ] ; then
            git_update
            $cpbin -rf "$cwd/$path" "$cspath"
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
            git_update
            $rmbin -rf "$cspath/$path"
            $gitbin commit -a -m "ignore" $gitquiet >/dev/null
            $gitbin push origin master $gitquiet
        }
    ;;

    view )
        link="$csprefix/$path"
        echo "Visit: "
        echo $link

        [ $(uname -s) = "Darwin" ] && {
            open $link
            exit 0
        }

        start $link >/dev/null 2>&1
    ;;

    * )
        echo "unkonw cmd."
        echo $helpmsg
        exit 1
esac

