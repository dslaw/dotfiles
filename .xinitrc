tU:W!/usr/bin/env bash

xrdb -load ~/.Xresources

# Set caps-lock to ctrl when held and escape when tapped
setxkbmap -option caps:ctrl_modifier
xcape -e Caps_Lock=Escape

systemctl --user import-environment DISPLAY

# Initiate windows manager
exec herbstluftwm --locked

