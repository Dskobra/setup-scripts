#!/usr/bin/bash

package_lutris(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y lutris
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install lutris
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y lutris
    else
        echo "Unkown error has occurred."
    fi
}

mkdir $HOME/Games
flatpak remove --user -y net.lutris.Lutris
package_lutris