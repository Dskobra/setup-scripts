#!/usr/bin/bash

package_fmedia_writer(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y mediawriter
    elif [ "$PKGMGR" == "apt-get" ]
    then
        #zenity --info --text="Fedora Mediawriter isn't available in Debian so using flatpak version instead."
        echo "Fedora Mediawriter isn't available in Debian so using flatpak version instead."
        "$SCRIPTS_FOLDER"/modules/flatpak/utilities/fedora_media_writer.sh
    else
        echo "Unkown error has occurred."
    fi
}

flatpak remove --user -y org.fedoraproject.MediaWriter
package_fmedia_writer
