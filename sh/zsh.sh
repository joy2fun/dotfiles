#!/bin/sh

cd ~
mkdir temp
cd temp

wget http://www.zsh.org/pub/zsh.tar.gz

tar zxvf zsh.tar.gz

cd zsh-*

sudo ./configure
sudo make
sudo make install

# install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

sudo usermod -s /usr/local/bin/zsh chiao
