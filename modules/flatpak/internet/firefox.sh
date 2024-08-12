#!/usr/bin/bash

remove_firefox(){
        if [ $PKGMGR == "dnf" ]
            then
                sudo dnf remove -y firefox firefox-langpacks
        elif [ $PKGMGR == "rpm-ostree" ]
            then
                hide_firefox_on_atomic
        elif [ $PKGMGR == "apt-get" ]
            then
                sudo apt-get remove -y firefox
                sudo apt-get remove -y firefox-esr
                sudo rm /etc/apt/sources.list.d/mozilla.list
                sudo rm /etc/apt/keyrings/packages.mozilla.org.asc
        else
            echo "Unkown error has occurred."
        fi
}

hide_firefox_on_atomic(){
        sudo mkdir -p /usr/local/share/applications/
        FEDORA_VERSION=$(source /etc/os-release ; echo $VERSION_ID)
        if [ $FEDORA_VERSION == "40" ]
            then
                sudo cp /usr/share/applications/org.mozilla.firefox.desktop /usr/local/share/applications/
                sudo sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/org.mozilla.firefox.desktop
                sudo update-desktop-database /usr/local/share/applications/
        elif [ $FEDORA_VERSION == "39" ]
            then
                sudo cp /usr/share/applications/firefox.desktop /usr/local/share/applications/
                sudo sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/firefox.desktop
                sudo update-desktop-database /usr/local/share/applications/
        fi
}

flatpak install --user -y flathub org.mozilla.firefox
remove_firefox