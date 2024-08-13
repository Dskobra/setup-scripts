#!/usr/bin/bash

install_codeblocks(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y codeblocks codeblocks-contrib-devel
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y codeblocks-dev
    else
        echo "Unkown error has occurred."
    fi
}

 flatpak remove --user -y org.codeblocks.codeblocks
install_codeblocks