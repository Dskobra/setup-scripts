#!/usr/bin/bash

native_vim(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y vim-enhanced
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree install vim-enhanced
        #sudo rpm-ostree apply-live
        $SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get install -y vim
    else
        echo "Unkown error has occurred."
    fi
}

native_vim
