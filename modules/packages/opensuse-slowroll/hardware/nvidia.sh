#!/usr/bin/bash

install_nvidia(){
    #this is for enabling the official repos and closed drivers from nvidia by installing the patterns
    #package. Packages here require accepting a license agreement.

    sudo zypper -n install openSUSE-repos-Tumbleweed-NVIDIA
    sudo zypper -n install openSUSE-repos-Slowroll-NVIDIA
    sudo zypper --gpg-auto-import-keys ref
    sudo zypper -n install --auto-agree-with-licenses nvidia-video-G06 nvidia-settings nvidia-modprobe
}

install_nvidia_open(){
    # some weird bug MicroOS patterns are selected by default on tumbleweed. To be safe remove/lock them all.
    sudo zypper rm openSUSE-repos-MicroOS-NVIDIA openSUSE-repos-Tumbleweed-NVIDIA openSUSE-repos-Slowroll-NVIDIA
    sudo zypper al openSUSE-repos-MicroOS-NVIDIA openSUSE-repos-Tumbleweed-NVIDIA openSUSE-repos-Slowroll-NVIDIA
    # also install module for lts kernel support for safety.
    sudo zypper -n install nvidia-open-driver-G06-signed-kmp-default nvidia-open-driver-G06-signed-kmp-longterm\
    nvidia-settings nvidia-modprobe
}

help(){
    echo "//Proprietary//"
    echo "Non open source kernel driver. Not compatible with RTX 5000 or higher."
    echo ""
    echo ""
    echo "//Open//"
    echo "Official open source kernel driver. Nvidia recommends this for RTX 2000/3000/4000 and required for RTX 5000."
    echo "Requires Nvidia RTX 2000 or higher. Note: Some gpus may perform worse with this."
}

package_chooser(){
    echo "                      |-----Package type-----|"
    echo "(1) Proprietary                                   (2) Open (default) "
    echo "(h) Help                                          (0) Cancel"
    echo "Enter an option or leave blank for default"
    read -r PACKAGE_TYPE
    if [ "$PACKAGE_TYPE" == "1" ]
    then
        install_nvidia
    elif [ "$PACKAGE_TYPE" == "2" ] || [ -z "$PACKAGE_TYPE" ]
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
