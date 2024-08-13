#!/usr/bin/bash

install_geany(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y geany geany-plugins-markdown geany-plugins-spellcheck geany-plugins-treebrowser
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y geany geany-plugin-markdown geany-plugin-spellcheck geany-plugin-treebrowser
    else
        echo "Invalid option"
    fi
}

flatpak remove --user -y org.geany.Geany
install_geany