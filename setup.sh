#!/bin/bash
echo "trying to create symlinks..."
cd $HOME

watched_files=".zshrc .gitconfig .gitignore_global"

for tmpf in $watched_files
do
    rm -rf $HOME/$tmpf
    echo "ln -s ~/dotfiles/$tmpf ~/$tmpf"
    ln -s $HOME/dotfiles/$tmpf $HOME/$tmpf
done
