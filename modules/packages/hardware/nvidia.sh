#!/usr/bin/bash

install_nvidia(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y akmod-nvidia nvidia-settings\
        xorg-x11-drv-nvidia-cuda
    else
        echo "Unkown error has occurred."
    fi
}

install_nvidia_open(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo sh -c 'echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod'
        sudo dnf install -y rpmfusion-nonfree-release-tainted
        sudo dnf install -y akmod-nvidia-open
        sudo akmods --rebuild --force
        sudo dracut --regenerate-all --force

    else
        echo "Unkown error has occurred."
    fi
}

help(){
    echo "//Proprietary//"
    echo "Non open source kernel driver. RRPMFusion recommends this vs the open source"
    echo "driver. Not compatible with RTX 5000 or higher."
    echo ""
    echo ""
    echo "//Open//"
    echo "Official open source kernel driver. While not recommended by RRPMFusion, Nvidia"
    echo "recommends this for RTX 2000/3000/4000 and required for RTX 5000."
    echo "Requires Nvidia RTX 2000 or higher. Note: Some gpus may perform worse with this."
}

package_chooser(){
    echo "                      |-----Package type-----|"
    echo "(1) Proprietary (default)                         (2) Open"
    echo "(h) Help                                          (0) Cancel"
    echo "Enter an option or leave blank for default"
    read -r PACKAGE_TYPE
    if [ "$PACKAGE_TYPE" == "1" ] || [ -z "$PACKAGE_TYPE" ]
    then
        install_nvidia
        sudo akmods --rebuild --force
        sudo dracut --regenerate-all --force
    elif [ "$PACKAGE_TYPE" == "2" ]
    then
        install_nvidia
        install_nvidia_open
    elif [ "$PACKAGE_TYPE" == "h" ]  || [ "$PACKAGE_TYPE" == "H" ]
    then
        help
    elif [ "$PACKAGE_TYPE" == "0" ]
    then
        echo "User canceled"
    else
        echo "Unkown error has occurred."
    fi
}

package_chooser
