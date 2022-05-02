#! /usr/bin/bash

setup_steam(){
    cd install/data
    cp steamgs.sh /opt/launchers
    sudo ln -s "/opt/launchers/steamgs.sh" "/usr/bin/steamgs"
    xdg-desktop-menu install Steamgs.desktop --mode user --novendor

}
setup_steam