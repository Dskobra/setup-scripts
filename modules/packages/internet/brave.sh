#!/usr/bin/bash

package_chooser(){
    echo "                      |-----Package type-----|"
    echo "(1) Native(default)                               (2) Flatpak"
    echo "(h) Help                                          (0) Cancel"
    echo "Enter an option or leave blank for default"
    read -r PACKAGE_TYPE
    if [ "$PACKAGE_TYPE" == "1" ] || [ -z "$PACKAGE_TYPE" ]
    then
        flatpak uninstall --user -y com.brave.Browser
        "$SCRIPTS_FOLDER"/modules/packages/multimedia/codecs.sh
        cd /opt/apps/temp || exit
        curl -fsSLO "https://dl.brave.com/install.sh{,.asc}" && gpg --keyserver hkps://keys.openpgp.org --recv-keys D16166072CACDF2C9429CBF11BF41E37D039F691 && gpg --verify install.sh.asc
        curl -fsS https://dl.brave.com/install.sh | sh
        rm install.sh
        rm install.sh.asc
    elif [ "$PACKAGE_TYPE" == "2" ]
    then
        flatpak install --user -y flathub com.brave.Browser
        sudo dnf remove -y brave-browser
        sudo rm "/etc/yum.repos.d/brave-browser.repo"
        sudo rm "/etc/pki/rpm-gpg/RPM-GPG-KEY-brave-nightly"
        sudo rm "/etc/pki/rpm-gpg/RPM-GPG-KEY-brave-beta"
        sudo rm "/etc/pki/rpm-gpg/RPM-GPG-KEY-brave"
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
