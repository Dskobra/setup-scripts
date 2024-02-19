#! /usr/bin/bash

## This launches an application with nohup
## then separates the process. That way
## i dont have to edit the shortcut with the
## new appimage name everytime it's updated

cd /home/$USER/.AppInstalls/
# run weakauras companion app while supressing input/output to avoid a logfile being made
nohup ./WeakAuras-Companion*.AppImage 0</dev/null 1>/dev/null 2>/dev/null &
