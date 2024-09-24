#!/usr/bin/bash

remove_codeblocks(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y codeblocks codeblocks-contrib-devel
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y codeblocks-dev
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.codeblocks.codeblocks
remove_codeblocks
