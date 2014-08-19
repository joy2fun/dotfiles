#!/bin/bash

cd ~
mkdir ~/bin

sudo yum install -y ncurses-devel

sudo yum install -y fontconfig

sudo chown chiao:chiao -R ~
