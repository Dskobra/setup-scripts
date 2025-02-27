#!/usr/bin/bash

native_firefox(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y firefox
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install MozillaFirefox MozillaFirefox-branding-openSUSE
    else
        echo "Unkown error has occurred."
    fi
}

remove_firefox(){
        if [ "$DISTRO" == "fedora" ]
            then
                sudo dnf remove -y firefox firefox-langpacks
        elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ] || [ "$DISTRO" == "opensuse-leap" ]
        then
            sudo zypper -n rm MozillaFirefox MozillaFirefox-branding-openSUSE
        elif [ "$DISTRO" == "debian" ]
            then
                sudo apt-get remove -y firefox
                sudo apt-get remove -y firefox-esr
                sudo rm "/etc/apt/sources.list.d/mozilla.list"
                sudo rm "/etc/apt/keyrings/packages.mozilla.org.asc"
        else
            echo "Unkown error has occurred."
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