#!/usr/bin/env bash

## Create symlinks from dotfiles in ~/dotfiles to home directory
## Backs up preexisting dotfiles into ~/dotfiles_old first

dir=~/dotfiles
backup=~/dotfiles_old
files=".bashrc .vimrc .Xresources .xinitrc .Rprofile .i3 .compton.conf"

mkdir -p $backup

cd $dir

for file in $files; do
    mv ~/$file ~/dotfiles_old/
    ln -s $dir/$file ~/$file
done

