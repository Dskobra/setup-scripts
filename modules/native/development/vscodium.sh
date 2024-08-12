#!/usr/bin/bash

install_vscodium(){
    if [ $PKGMGR == "dnf" ]
    then
        cd $SCRIPTS_FOLDER/data
        cp vscodium.repo.txt vscodium.repo
        sudo chown root:root vscodium.repo
        sudo mv vscodium.repo /etc/yum.repos.d/vscodium.repo
        sudo dnf install -y codium
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        cd $SCRIPTS_FOLDER/data
        cp vscodium.repo.txt vscodium.repo
        sudo chown root:root vscodium.repo
        sudo mv vscodium.repo /etc/yum.repos.d/vscodium.repo
        sudo rpm-ostree install codium
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -
        sudo apt-add-repository 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main'
        sudo apt-get update && sudo apt-get install -y codium
        
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y com.vscodium.codium
install_vscodium