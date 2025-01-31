#!/usr/bin/bash

install_nvidia(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda nvidia-xconfig nvidia-settings
        sudo akmods --rebuild --force
        sudo dracut --regenerate-all --force
        xdg-open https://rpmfusion.org/Howto/NVIDIA?highlight=%28%5CbCategoryHowto%5Cb%29#Installing_the_drivers
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install openSUSE-repos-Tumbleweed-NVIDIA
        sudo zypper install-new-recommends --repo NVIDIA
        xdg-open https://en.opensuse.org/SDB:NVIDIA_drivers
    elif [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n install openSUSE-repos-Slowroll-NVIDIA
        sudo zypper ref
        sudo zypper install-new-recommends --repo NVIDIA
        xdg-open https://en.opensuse.org/SDB:NVIDIA_drivers
    else
        echo "Unkown error has occurred."
    fi
}

install_nvidia