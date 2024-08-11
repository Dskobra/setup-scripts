#!/usr/bin/bash

package_steam(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y steam
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install steam
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo dpkg --add-architecture i386
        sudo apt-get update
        sudo apt-get install -y steam
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y flathub com.valvesoftware.Steam
package_steam
$SCRIPTS_FOLDER/modules/native/gaming/steam-devices.sh