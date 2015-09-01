#!/usr/bin/env bash

# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install packages
cd ~/.vim/bundle
grep "git clone" ~/.vimrc | sed 's/\" //' | while read -r line; do
    $line
done
cd

# Install patched fonts
git clone https://github.com/powerline/fonts
cd fonts && ./install.sh
fc-cache fonts

# Install jellybeans colorscheme
mkdir -p ~/.vim/colors && cd ~/.vim/colors
git clone https://github.com/nanotech/jellybeans.vim
mv jellybeans.vim jellybeans
cp jellybeans/colors/jellybeans.vim ~/.vim/colors/jellybeans.vim

