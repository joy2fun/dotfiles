#!/bin/bash

cd ~
mkdir temp
cd temp

wget http://ftp.stust.edu.tw/vim/unix/vim-7.4.tar.bz2
tar zjvf vim-*.bz2
cd vim74

sudo ./configure --prefix=/usr/local --with-features=normal --enable-multibyte --with-tlib=ncurses --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config

sudo make
sudo make install

cd ~
mkdir .vim
cd .vim

sudo git clone --recursive https://github.com/joy2fun/vimfiles.git .

sudo chown chiao:chiao -R ~
