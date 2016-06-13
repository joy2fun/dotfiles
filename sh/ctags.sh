#!/bin/bash

cd ~/temp

ctagsgz="ctags-5.8_better_php_parser.tar.gz"

if [ ! -f "$ctagsgz" ]; then
    wget --no-check-certificate "https://github.com/shawncplus/phpcomplete.vim/raw/master/misc/ctags-5.8_better_php_parser.tar.gz" -O $ctagsgz
fi

tar xvf $ctagsgz

cd ctags

./configure
make

sudo make install

