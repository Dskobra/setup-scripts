#!/usr/bin/bash

remove_vscodium(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo rm /etc/yum.repos.d/vscodium.repo
        sudo dnf remove -y codium
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rm /etc/yum.repos.d/vscodium.repo
        sudo rpm-ostree uninstall codium
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
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
