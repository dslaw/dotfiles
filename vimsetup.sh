#!/usr/bin/env bash

# Install vim-plug
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install patched fonts
git clone https://github.com/powerline/fonts ~/fonts
cd ~/fonts && ./install.sh
fc-cache ~/fonts

