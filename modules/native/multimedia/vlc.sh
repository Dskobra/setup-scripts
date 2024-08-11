#!/usr/bin/bash

package_vlc(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y vlc
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install vlc
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y vlc
    else
        echo "Unkown error has occurred."
    fi
}

flatpak uninstall --user -y org.videolan.VLC
package_vlc