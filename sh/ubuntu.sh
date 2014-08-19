#!/bin/bash

cd ~
mkdir ~/bin

sudo apt-get install -y libncurses5-dev

sudo apt-get install -y openssh-server

sudo chown chiao:chiao -R ~
