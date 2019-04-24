#!/usr/bin/env bash

xrdb -load $HOME/.Xresources

# Set caps-lock to ctrl when held and escape when tapped.
setxkbmap -option caps:ctrl_modifier
xcape -e Caps_Lock=Escape

# Make sure the display is discoverable.
systemctl --user import-environment DISPLAY
