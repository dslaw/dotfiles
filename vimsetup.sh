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
git clone https://github.com/powerline/fonts ~/fonts
cd fonts && ./install.sh
fc-cache fonts

# Install jellybeans colorscheme
git clone https://github.com/nanotech/jellybeans.vim ~/.vim/bundle/jellybeans.vim

