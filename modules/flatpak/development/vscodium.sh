#!/usr/bin/bash

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

flatpak install --user -y flathub com.vscodium.codium
remove_vscodium
