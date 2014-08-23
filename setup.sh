#!/bin/bash
currenthome=$(dirname $0)
currenthome=${currenthome%/*}
cd $currenthome

watched_files=".zshrc .gitconfig .gitignore_global"

for tmpf in $watched_files
do
    rm -rf $currenthome/$tmpf
    ln -s $currenthome/dotfiles/$tmpf $currenthome/$tmpf
done
