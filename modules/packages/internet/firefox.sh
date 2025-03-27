#!/usr/bin/bash

native_firefox(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y firefox
    elif [ "$DISTRO" == "opensuse-slowroll" ]
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
        elif [ "$DISTRO" == "opensuse-slowroll" ]
        then
            sudo zypper -n rm MozillaFirefox MozillaFirefox-branding-openSUSE
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