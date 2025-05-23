#!/usr/bin/bash

install_nvidia(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y akmod-nvidia nvidia-settings\
        xorg-x11-drv-nvidia-cuda
        sudo akmods --rebuild --force
        sudo dracut --regenerate-all --force

    else
        echo "Unkown error has occurred."
    fi
}

install_nvidia_open(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y akmod-nvidia nvidia-settings\
        xorg-x11-drv-nvidia-cuda

        sudo sh -c 'echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod'
        sudo akmods --kernels $(uname -r) --rebuild
        sudo dnf install -y rpmfusion-nonfree-release-tainted
        sudo dnf swap -y akmod-nvidia akmod-nvidia-open
        sudo akmods --rebuild --force
        sudo dracut --regenerate-all --force

    else
        echo "Unkown error has occurred."
    fi
}

help(){
    echo "//Proprietary//"
    echo "Non open source driver. Currently rpmfusion recommends this vs the open source driver."
    echo ""
    echo ""
    echo "//Open//"
    echo "While not recommended by rpmfusion it is largely on par feature wise vs the closed driver."
}

package_chooser(){
    echo "Select the type of package to install."
    echo "Enter an option or leave blank for default"
    echo "(1) Proprietary (default)                         (2) Open"
    echo "(h) Help                                          (0) Cancel"
    read -r PACKAGE_TYPE
    if [ "$PACKAGE_TYPE" == "1" ] || [ -z "$PACKAGE_TYPE" ]
    then
        install_nvidia
    elif [ "$PACKAGE_TYPE" == "2" ]
    then
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
