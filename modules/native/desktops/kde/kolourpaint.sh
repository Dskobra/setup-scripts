#!/usr/bin/bash

package_kolourpaint(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y kolourpaint
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install kolourpaint
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y kolourpaint
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y org.kde.kolourpaint
package_kolourpaint