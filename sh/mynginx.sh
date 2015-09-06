#! /bin/sh

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
NAME="${2:-nginx}"
NGINX_BIN=/usr/local/nginx/sbin/nginx
CONFIGFILE=/usr/local/nginx/conf/$NAME.conf
PIDFILE=/usr/local/nginx/logs/$NAME.pid

case "$1" in
    start)
        echo -n "Starting $NAME... "

        if [ -f $PIDFILE ] ; then
            echo "$PIDFILE exists. Maybe $NAME is running. :)"
            exit 1
        fi

        $NGINX_BIN -c $CONFIGFILE

        if [ "$?" != 0 ] ; then
            echo " failed"
            exit 1
        else
            echo " done"
        fi
        ;;

    stop)
        echo -n "Stoping $NAME... "

        if ! netstat -tnpl | grep -q $NAME; then
            echo "$NAME is not running."
            exit 1
        fi

        $NGINX_BIN -s stop -c $CONFIGFILE

        if [ "$?" != 0 ] ; then
            echo " failed."
            exit 1
        else
            echo " done"
        fi
        ;;

    status)
        if netstat -tnpl | grep -q $NAME; then
            echo "$NAME is running..."
        else
            echo "$NAME is stopped"
            exit 0
        fi
        ;;

    restart)
        $0 stop $2
        sleep 1
        $0 start $2
        ;;

    reload)
        echo -n "Reload service $NAME... "

        if netstat -tnpl | grep -q $NAME; then
            $NGINX_BIN -s reload -c $CONFIGFILE
            echo " done"
        else
            echo "$NAME is not running, can't reload."
            exit 1
        fi
        ;;

    configtest)
        echo -n "Test $NAME configure files... "

        $NGINX_BIN -t -c $CONFIGFILE
        ;;

    *)
        echo "Usage: $0 {start|stop|restart|reload|status|configtest}"
        exit 1
        ;;

esac
