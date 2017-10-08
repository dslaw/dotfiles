#!/usr/bin/env bash

mkdir -p ~/.vim/autoload ~/.vim/bundle

# Install patched fonts
git clone https://github.com/powerline/fonts ~/fonts
cd ~/fonts && ./install.sh
fc-cache ~/fonts
