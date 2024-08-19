#!/usr/bin/bash

remove_brave_browser(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y brave-browser
        sudo rm "/etc/yum.repos.d/brave-browser.repo"
        sudo rm "/etc/pki/rpm-gpg/brave-core.asc"
        sudo dnf update -y
        
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y brave-browser
        sudo rm "/etc/apt/sources.list.d/brave-browser-release.list"
        sudo apt-get update
        
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub com.brave.Browser
remove_brave_browser
