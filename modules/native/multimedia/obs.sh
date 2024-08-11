#!/usr/bin/bash

package_obsstudio(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y obs-studio
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install obs-studio
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        sudo apt-get install -y obs-studio
    else
        echo "Invalid option"
    fi
}

flatpak uninstall --user -y com.obsproject.Studio
package_obsstudio