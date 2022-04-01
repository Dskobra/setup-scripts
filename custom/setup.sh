#! /usr/bin/bash

USER=$(whoami)
cd launchers
chown $USER:$USER *.sh
cp *.sh /home/$USER/Apps/launchers
sudo ln -s "/home/$USER/Apps/launchers/raiderio.sh" "/usr/bin/raiderio"
sudo ln -s "/home/$USER/Apps/launchers/wowup.sh" "/usr/bin/wowup"
sudo ln -s "/home/$USER/Apps/launchers/warcraftlogs.sh" "/usr/bin/warcraftlogs"

#cd ../shortcuts
#chown $USER:$USER *.desktop
#xdg-desktop-menu install Raiderio.desktop --mode system --novendor

