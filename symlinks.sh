#!/usr/bin/env bash

# Create symlinks from dotfiles in ~/dotfiles to home directory
# Backs up preexisting dotfiles into ~/dotfiles_old first

dir=~/dotfiles
backup=~/dotfiles_old
files=".aliases .bashrc .config/fish .xinitrc .Xresources \
        .i3 .compton.conf .config/ranger \
        .bpython .ipython_config.py .Rprofile .vimrc"

mkdir -p $backup

for file in $files; do
    mv ~/$file ~/dotfiles_old/ 2>/dev/null
    ln -s $dir/$file ~/$file 2>/dev/null
done

