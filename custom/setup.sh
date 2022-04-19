#! /usr/bin/bash

USER=$(whoami)
cd launchers
sudo chown $USER:$USER *.sh
cp *.sh /home/$USER/Apps/launchers
sudo ln -s "/home/$USER/Apps/launchers/raiderio.sh" "/usr/bin/raiderio"
sudo ln -s "/home/$USER/Apps/launchers/wowup.sh" "/usr/bin/wowup"
sudo ln -s "/home/$USER/Apps/launchers/warcraftlogs.sh" "/usr/bin/warcraftlogs"
sudo ln -s "/home/$USER/Apps/launchers/steamgs.sh" "/usr/bin/steamgs"

#cd ../shortcuts
#chown $USER:$USER *.desktop
#xdg-desktop-menu install Raiderio.desktop --mode user --novendor
#xdg-desktop-menu install WoWUp.desktop --mode user --novendor
#xdg-desktop-menu install WarcraftLogs.desktop --mode user --novendor

