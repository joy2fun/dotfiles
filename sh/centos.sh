#!/bin/bash

cd ~
mkdir ~/bin

sudo yum install -y ncurses-devel

sudo yum install -y fontconfig

sudo useradd -d/home/chiao -s/bin/bash chiao

sudo passwd chiao
