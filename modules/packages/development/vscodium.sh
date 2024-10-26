#!/usr/bin/bash

native_vscodium(){
    if [ "$PKGMGR" == "dnf" ]
    then
        cd "$SCRIPTS_FOLDER"/modules/packages/development
        cp vscodium.repo.txt vscodium.repo
        sudo chown root:root vscodium.repo
        sudo mv vscodium.repo /etc/yum.repos.d/vscodium.repo
        sudo dnf install -y codium
    elif [ "$PKGMGR" == "apt-get" ]
    then
        wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -
        sudo apt-add-repository 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main'
        sudo apt-get update && sudo apt-get install -y codium
        
    else
        echo "Unkown error has occurred."
    fi
}

remove_vscodium(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo rm /etc/yum.repos.d/vscodium.repo
        sudo dnf remove -y codium
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo rm archive_uri-https_paulcarroty_gitlab_io_vscodium-deb-rpm-repo_debs_-bookworm.list
        sudo apt-get remove -y codium
        
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub com.vscodium.codium
    remove_vscodium
elif [ "$1" == "native" ]
then
    flatpak remove --user -y com.vscodium.codium
    native_vscodium
else
    echo "error"
fi