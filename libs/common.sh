#!/bin/echo Warning: this file should be sourced

# test if runable
iscmd(){
    type "$1" &> /dev/null;
}

evenodd(){
    LAST_DIGIT=`echo $1 | sed 's/\(.*\)\(.\)$/\2/'`
    case $LAST_DIGIT in
    0|2|4|6|8)
        return 1
    ;;
    *)
        return 0
    ;;
    esac
}

isalive(){
    NODE=$1
    ping -c 3 $NODE >/dev/null 2>&1
    if [ $? -eq 0 ]
    then
        return 1
    else
        return 0
    fi
}
