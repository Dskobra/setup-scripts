#!/usr/bin/bash

install_nvidia(){
    if [ "$PKGMGR" == "dnf" ]
    then
        sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda nvidia-xconfig nvidia-settings
        xdg-open https://rpmfusion.org/Howto/NVIDIA?highlight=%28%5CbCategoryHowto%5Cb%29#Installing_the_drivers
    elif [ "$PKGMGR" == "rpm-ostree" ]
    then
        sudo rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia-cuda nvidia-xconfig nvidia-settings
        xdg-open https://rpmfusion.org/Howto/NVIDIA?highlight=%28%5CbCategoryHowto%5Cb%29#Installing_the_drivers
        #sudo rpm-ostree apply-live
        "$SCRIPTS_FOLDER"/modules/core/confirm_reboot.sh
    elif [ "$PKGMGR" == "apt-get" ]
    then
        sudo apt-add-repository -y --component non-free-firmware
        sudo apt-get install -y linux-headers-amd64 dkms
        sudo apt-get install -y nvidia-driver firmware-misc-nonfree
        xdg-open https://wiki.debian.org/NvidiaGraphicsDrivers
    else
        echo "Unkown error has occurred."
    fi
}

install_nvidia
