#!/usr/bin/env bash

BACKUP_DIR=$HOME/dotfiles-old
DOTFILES_DIR=$HOME/dotfiles

# Create directories for vim plugins. The plugin manager
# will bootstrap itself the first time vim is loaded.
mkdir -p $HOME/.vim/{autoload,bundle}

# Symlink dotfiles to home directory.
sources=(
    .aliases
    .bashrc
    .compton.conf
    .config/fish
    .config/ranger/rc.conf
    .config/kitty/kitty.conf
    .gitconfig
    .tmux.conf
    .vimrc
    # X11.
    .colors
    .xinitrc
    .Xresources
    # Language-specific files.
    .ipython_config.py
    .Rprofile
    # Window managers.
    .i3
    .config/herbstluftwm
)

mkdir -p $BACKUP_DIR
mkdir -p $HOME/.config

for file in ${sources[@]}; do
    src=$DOTFILES_DIR/$file
    dst=$HOME/$file

    echo "$src -> $dst:"

    if [[ -e $dst ]]; then
        if [[ $dst -ef $src ]]; then
            echo "  Exact match already exists, skipping"
            continue
        fi

        # Backup the dest file if it is not a symlink to the
        # source file.
        echo "  Found existing file, backing up"
        mv $dst $BACKUP_DIR/
    fi

    echo "  Symlinking"
    mkdir -p $(dirname ${dst})
    ln -s $src $dst
done
