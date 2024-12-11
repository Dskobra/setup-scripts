#!/usr/bin/bash

native_claws_mail(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y claws-mail
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install claws-mail
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get install -y claws-mail
    else
        echo "Unkown error has occurred."
    fi
}

remove_claws_mail(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y claws-mail
    elif [ "$DISTRO" == "fedora-atomic" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n rm claws-mail
    elif [ "$DISTRO" == "debian" ]
    then
        sudo apt-get remove -y claws-mail
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.claws_mail.Claws-Mail
    remove_claws_mail
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.claws_mail.Claws-Mail
    native_claws_mail
else
    echo "error"
fi
