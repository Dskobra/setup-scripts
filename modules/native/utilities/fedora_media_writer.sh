#!/usr/bin/bash

package_fmedia_writer(){
    if [ $PKGMGR == "dnf" ]
    then
        sudo dnf install -y mediawriter
    elif [ $PKGMGR == "rpm-ostree" ]
    then
        sudo rpm-ostree install mediawriter
        sudo rpm-ostree apply-live
        #$SCRIPTS_FOLDER/modules/core/confirm_reboot.sh
    elif [ $PKGMGR == "apt-get" ]
    then
        zenity --info --text="Fedora Mediawriter isn't available in Debian so using flatpak version instead."
        flatpak install --user -y flathub org.fedoraproject.MediaWriter
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y org.fedoraproject.MediaWriter
package_fmedia_writer