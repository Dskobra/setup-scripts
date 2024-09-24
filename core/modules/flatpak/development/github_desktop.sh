#!/usr/bin/bash

remove_github_desktop(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo rm /etc/yum.repos.d/shiftkey-packages.repo
        sudo rm /etc/pki/rpm-gpg/shiftkey-gpg.key
        sudo dnf remove -y github-desktop
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo rm /etc/apt/sources.list.d/shiftkey-packages.list
        sudo apt-get remove -y github-desktop
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub io.github.shiftey.Desktop
remove_github_desktop
