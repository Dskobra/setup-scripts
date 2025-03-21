#!/usr/bin/bash

native_vlc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y rpmfusion-free-release-tainted
        sudo dnf install -y libdvdcss
        sudo dnf install -y vlc
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper ar -cfp 90 'http://opensuse-guide.org/repo/openSUSE_Tumbleweed/' 'libdvdcss repository'
        sudo zypper --gpg-auto-import-keys ref
        sudo zypper -n remove vlc-qt
        sudo zypper -n install --from packman-essentials vlc-qt vlc-codecs
        sudo zypper -n install --from 'libdvdcss repository' libdvdcss2
    else
        echo "Unkown error has occurred."
    fi
}

remove_vlc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf remove -y rpmfusion-free-release-tainted
        sudo dnf remove -y libdvdcss
        sudo dnf remove -y vlc
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n rm vlc-codecs vlc-qt 
    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "flatpak" ]
then
    flatpak install --user -y flathub org.videolan.VLC
    remove_vlc
elif [ "$1" == "native" ]
then
    flatpak uninstall --user -y org.videolan.VLC
    native_vlc
else
    echo "error"
fi