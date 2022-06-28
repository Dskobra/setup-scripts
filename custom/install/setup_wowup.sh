#! /usr/bin/bash

setup_wow_apps(){
    cd install/data
    cp wowup.sh /opt/launchers
    xdg-desktop-menu install WoWUp.desktop --mode user --novendor
}
setup_wow_apps