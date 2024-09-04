#! /usr/bin/bash

install_mate_apps(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y mate-menu mate-sensors-applet mate-utils\
        multimedia-menus compiz-manager fusion-icon simple-ccsm\
        compiz-plugins-experimental compiz-bcop fuse

        sudo dnf install -y caja-beesu caja-share ccsm \
        compizconfig-python emerald emerald-themes simple-ccsm
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y mate-menu mate-sensors-applet mate-utils\
        fusion-icon simple-ccsm compiz-plugins-experimental compiz-bcop\
        emerald emerald-themes caja-open-terminal
    else
        echo "Unkown error has occurred."
    fi
}

install_mate_apps
