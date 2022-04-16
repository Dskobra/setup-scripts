#! /usr/bin/bash

setup_wow_apps(){
    sudo ln -s "/home/$USER/Apps/launchers/raiderio.sh" "/usr/bin/raiderio"
    sudo ln -s "/home/$USER/Apps/launchers/wowup.sh" "/usr/bin/wowup"
    sudo ln -s "/home/$USER/Apps/launchers/warcraftlogs.sh" "/usr/bin/warcraftlogs"

    cd ../shortcuts
    xdg-desktop-menu install Raiderio.desktop --mode user --novendor
    xdg-desktop-menu install WoWUp.desktop --mode user --novendor
    xdg-desktop-menu install WarcraftLogs.desktop --mode user --novendor
}