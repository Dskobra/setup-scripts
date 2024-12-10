#!/usr/bin/bash

native_fmedia_writer(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y mediawriter
    elif [ "$PKGMGR" == "zypper" ]
    then
        echo "============================================="
        echo "Fedora Mediawriter isn't available in openSUSE."
        echo "This will install the flatpak version."
        echo "============================================="
        flatpak install --user -y flathub org.fedoraproject.MediaWriter
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "============================================="
        echo "Fedora Mediawriter isn't available in Debian."
        echo "This will install the flatpak version."
        echo "============================================="
        flatpak install --user -y flathub org.fedoraproject.MediaWriter
    else
        echo "Unkown error has occurred."
    fi
}

remove_fmedia_writer(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf remove -y mediawriter
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        echo "Not removing package on atomic editions."
    elif [ "$PKGMGR" == "apt-get" ]
    then
        echo "Not removing Fedora media writer as it's not present in Debian repos."
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.fedoraproject.MediaWriter
    remove_fmedia_writer
elif [ "$1" == "native" ]
then
    flatpak remove --user -y org.fedoraproject.MediaWriter
    native_fmedia_writer
else
    echo "error"
fi