#!/usr/bin/bash

native_vlc(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y rpmfusion-free-release-tainted
        sudo dnf install -y libdvdcss
        sudo dnf install -y vlc
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        opensuse_warning
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

opensuse_warning(){
    echo "##################################WARNING##############################################"
    echo "# To avoid switching the entire mesa stack these scripts will NOT do a vendor change. #"
    echo "# Because of this you will need to CAREFULLY choose between up to 4 solutions. Please #"
    echo "# carefully pick a solution that installs [packagename] from vendor                   #" 
    echo "# http://packman.links2linux.de                                                       #"
    echo "#######################################################################################"
    echo "Please enter y/N"
    printf "Option: "
    read -r input
    if [ "$input" == "y" ] || [ "$input" == "Y" ]
    then
        sudo zypper ar -cfp 90 'http://opensuse-guide.org/repo/openSUSE_Tumbleweed/' 'libdvdcss repository'
        sudo zypper --gpg-auto-import-keys ref
        sudo zypper -n remove vlc-qt
        sudo zypper -n install --from packman-essentials vlc-qt vlc-codecs
        sudo zypper -n install --from 'libdvdcss repository' libdvdcss2
    elif [ "$input" == "n" ] || [ "$input" == "N" ]
    then
        echo "Returning to multimedia menu"
    else
        echo "error"
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