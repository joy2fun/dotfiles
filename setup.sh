#!/bin/bash
homedir=${1:-~}
watched_files=".zshrc .gitconfig .gitignore_global"

for tmpf in $watched_files
do
    rm -rf $homedir/$tmpf
    ln -vs $homedir/dotfiles/$tmpf $homedir/$tmpf
done

