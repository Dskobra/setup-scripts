#!/usr/bin/bash

package_keepassxc(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y keepassxc
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install keepassxc
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y keepassxc
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y org.keepassxc.KeePassXC
package_keepassxc