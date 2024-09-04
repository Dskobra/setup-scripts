#!/usr/bin/bash

remove_fmedia_writer(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y mediawriter
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing Fedora media writer as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

remove_fmedia_writer
flatpak install --user -y flathub org.fedoraproject.MediaWriter
