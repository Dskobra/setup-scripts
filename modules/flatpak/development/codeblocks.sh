#!/usr/bin/bash

remove_codeblocks(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf remove -y codeblocks codeblocks-contrib-devel
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree uninstall codeblocks codeblocks-contrib-devel
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get remove -y codeblocks-dev
    else
        echo "Unkown error has occurred."
    fi
}

flatpak install --user -y flathub org.codeblocks.codeblocks
remove_codeblocks