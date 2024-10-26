#!/usr/bin/bash

native_firefox(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y firefox
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rm /usr/local/share/applications/org.mozilla.firefox.desktop
        sudo rm /usr/local/share/applications/firefox.desktop
        sudo update-desktop-database /usr/local/share/applications/
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-get remove -y firefox-esr
        sudo install -d -m 0755 /etc/apt/keyrings
        wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

        gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); print "\n"$0"\n"}'

        echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
        echo '
        Package: *
        Pin: origin packages.mozilla.org
        Pin-Priority: 1000
        ' | sudo tee /etc/apt/preferences.d/mozilla
        sudo apt-get update && sudo apt-get install -y firefox
    else
        echo "Unkown error has occurred."
    fi
}

remove_firefox(){
        if [ "$PKGMGR" == "dnf" ]
            then
                sudo dnf remove -y firefox firefox-langpacks
        elif [ "$PKGMGR" == "rpm-ostree" ]
            then
                hide_firefox_on_atomic
        elif [ "$PKGMGR" == "apt-get" ]
            then
                sudo apt-get remove -y firefox
                sudo apt-get remove -y firefox-esr
                sudo rm "/etc/apt/sources.list.d/mozilla.list"
                sudo rm "/etc/apt/keyrings/packages.mozilla.org.asc"
        else
            echo "Unkown error has occurred."
        fi
}

hide_firefox_on_atomic(){
        sudo mkdir -p "/usr/local/share/applications/"
        FEDORA_VERSION=$(source /etc/os-release ; echo $VERSION_ID)
        if [ "$FEDORA_VERSION" == "40" ]
            then
                sudo cp "/usr/share/applications/org.mozilla.firefox.desktop" "/usr/local/share/applications/"
                sudo sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/org.mozilla.firefox.desktop
                sudo update-desktop-database "/usr/local/share/applications/"
        elif [ "$FEDORA_VERSION" == "39" ]
            then
                sudo cp "/usr/share/applications/firefox.desktop" "/usr/local/share/applications/"
                sudo sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/firefox.desktop
                sudo update-desktop-database "/usr/local/share/applications/"
        fi
}


if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.mozilla.firefox
    remove_firefox
elif [ "$1" == "native" ]
then
    flatpak uninstall --user -y org.mozilla.firefox
    native_firefox
else
    echo "error"
fi