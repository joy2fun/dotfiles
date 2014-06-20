#!/bin/bash

cd ~
curl -sS https://getcomposer.org/installer | php
chmod +x composer.phar
mv composer.phar ~/bin/composer
