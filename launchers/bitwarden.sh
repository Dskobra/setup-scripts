#! /usr/bin/bash

### Bitwarden Launcher
### launch Bitwarden and separate the process 
### keeping it open without this script
### this allows creating a wowup shortcut
### without updating the file name
### every update

cd /home/$USER/.AppInstalls/
# run Bitwarden while supressing input/output to avoid a logfile being made
nohup ./Bitwarden*.AppImage 0</dev/null 1>/dev/null 2>/dev/null &
