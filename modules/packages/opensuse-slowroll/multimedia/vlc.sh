#!/usr/bin/bash

package_chooser(){
    echo "                      |-----Package type-----|"
    echo "(1) Native(default)                               (2) Flatpak"
    echo "(h) Help                                          (0) Cancel"
    echo "Enter an option or leave blank for default"
    read -r PACKAGE_TYPE
    if [ "$PACKAGE_TYPE" == "1" ] || [ -z "$PACKAGE_TYPE" ]
    then
        flatpak uninstall --user -y org.videolan.VLC
        "$SCRIPTS_FOLDER"/modules/packages/opensuse-slowroll/multimedia/codecs.sh
        sudo zypper ar -cfp 90 'http://opensuse-guide.org/repo/openSUSE_Tumbleweed/' 'libdvdcss repository'
        sudo zypper --gpg-auto-import-keys ref
        sudo zypper -n install --from packman-essentials vlc vlc-qt libvlc5 libvlccore9 vlc-codecs
        sudo zypper -n dup --from packman-essentials --allow-vendor-change
        sudo zypper -n install --from 'libdvdcss repository' libdvdcss2
    elif [ "$PACKAGE_TYPE" == "2" ]
    then
        flatpak install --user -y flathub org.videolan.VLC
         sudo zypper -n rm vlc-codecs vlc-qt libdvdcss2
    elif [ "$PACKAGE_TYPE" == "h" ]  || [ "$PACKAGE_TYPE" == "H" ]
    then
        "$SCRIPTS_FOLDER"/modules/core/help.sh
    elif [ "$PACKAGE_TYPE" == "0" ]
    then
        echo "User canceled"
    else
        echo "Unkown error has occurred."
    fi
}

package_chooser
