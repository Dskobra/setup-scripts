#! /usr/bin/bash

setup_steam(){
    cd data
    cp steamgs.sh /home/$USER/Apps/launchers
    sudo ln -s "/home/$USER/Apps/launchers/steamgs.sh" "/usr/bin/steamgs"
    xdg-desktop-menu install Steamgs.desktop --mode user --novendor

}
setup_steam