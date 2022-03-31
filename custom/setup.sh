#! /usr/bin/bash

USER=$(whoami)
cd launchers
chown $USER:$USER *.sh
sudo cp *.sh /usr/bin/

#cd ../shortcuts
#chown $USER:$USER *.desktop
#xdg-desktop-menu install Raiderio.desktop --mode system --novendor

