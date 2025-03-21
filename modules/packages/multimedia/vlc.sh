#!/usr/bin/bash

native_vlc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y rpmfusion-free-release-tainted
        sudo dnf install -y libdvdcss
        sudo dnf install -y vlc
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n remove vlc-qt
        sudo zypper  install --from packman-essentials vlc-qt vlc-codecs
        # sudo zypper ar -cfp 90 'http://opensuse-guide.org/repo/openSUSE_Tumbleweed/' 'libdvdcss repository'
        # sudo zypper --gpg-auto-import-keys ref
        # sudo zypper install --from 'libdvdcss repository' libdvdcss2
        echo "#####################Dvd playback instructions#####################"
        echo "1. Please open the KDE menu and search for YaST and enter your password when requested."
        echo "2. Click Software Repositories near the top."
        echo "3. Click Add in the bottom left and select Community Repositories near the top of the list."
        echo "4. Select libdvcss and accept the GnuPG Key."
        echo "5. Once done close Software Repositories and open Software Management in YaST."
        echo "6. Search and install libdvdcss2."
        echo "7. Simply reopen VLC or reboot."
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