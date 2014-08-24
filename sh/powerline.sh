#!/bin/sh

if [ ! -d ~/.fonts ]; then
    mkdir ~/.fonts
fi
cd ~/.fonts

wget --no-check-certificate https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
wget --no-check-certificate https://gist.github.com/qrush/1595572/raw/51bdd743cc1cc551c49457fe1503061b9404183f/Inconsolata-dz-Powerline.otf
wget --no-check-certificate https://gist.github.com/qrush/1595572/raw/417a3fa36e35ca91d6d23ac961071094c26e5fad/Menlo-Powerline.otf
wget --no-check-certificate https://gist.github.com/qrush/1595572/raw/2eb22321d590265799aac5b166cd19f8358b0db1/mensch-Powerline.otf
wget --no-check-certificate https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf

fc-cache -vf ~/.fonts/

mkdir -p ~/.config/fontconfig/conf.d/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d
