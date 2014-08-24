#!/bin/bash

if [ ! -d ~/bin ]; then
    mkdir ~/bin
fi

curl -sS https://getcomposer.org/installer | php
chmod +x composer.phar
mv composer.phar ~/bin/composer
