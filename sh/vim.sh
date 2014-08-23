#!/bin/bash

if [ ! -d ~/temp ];then
    mkdir ~/temp
fi

cd ~/temp

read -p "Do you want to install vim?[y/N]" installvim

case $installvim in
  [Yy]* )
    vimbz="vim-7.4.tar.bz2"

    if [ ! -f "$vimbz" ]; then
        sudo wget http://mirrors.ustc.edu.cn/vim/unix/$vimbz
    fi

    sudo rm -rf vim74
    sudo tar xjvf $vimbz
    cd vim74

    pythonconfig1="/usr/lib/python2.7/config"
    pythonconfig2="/usr/local/lib/python2.7/config"
    pythonconfig=$pythonconfig2
    test -d $pathonconfig1 && pythonconfig=$pythonconfig1;

    if [ ! -d "$pythonconfig" ]; then
        pythongz="Python-2.7.7.tgz"

        if [ ! -f "$pythongz" ]; then
            sudo wget --no-check-certificate https://www.python.org/ftp/python/2.7.7/$pythongz
        fi

        sudo rm -rf Python-2.2.7/
        tar zxvf $pythongz
        cd Python-2.7.7
        sudo ./configure
        sudo make
        sudo make install
        cd ~/temp
    fi

    if [ -d "$pythonconfig" ]; then
        sudo ./configure --prefix=/usr/local --with-features=normal --enable-multibyte --with-tlib=ncurses --enable-pythoninterp -with-python-config-dir=$pythonconfig

        sudo make
        sudo make install
    else
        echo "no python config found."
    fi

    ;;
esac
