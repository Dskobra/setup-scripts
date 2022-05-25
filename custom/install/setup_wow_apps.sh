#! /usr/bin/bash

setup_wow_apps(){
    # Not really needed anymore as I'm putting /opt/launchers in path
    #sudo ln -s "/opt/launchers/raiderio.sh" "/usr/bin/raiderio"
    #sudo ln -s "/opt/launchers/wowup.sh" "/usr/bin/wowup"
    #sudo ln -s "/opt/launchers/warcraftlogs.sh" "/usr/bin/warcraftlogs"

    cd install/data
    cp raiderio.sh /opt/launchers
    cp warcraftlogs.sh /opt/launchers
    cp wowup.sh /opt/launchers
    xdg-desktop-menu install Lutris.desktop --mode user --novendor
    xdg-desktop-menu install Raiderio.desktop --mode user --novendor
    xdg-desktop-menu install WoWUp.desktop --mode user --novendor
    xdg-desktop-menu install WarcraftLogs.desktop --mode user --novendor
}
setup_wow_apps