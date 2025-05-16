#!/usr/bin/bash

install_nvidia(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y akmod-nvidia nvidia-settings\
        xorg-x11-drv-nvidia-cuda
        sudo akmods --rebuild --force
        sudo dracut --regenerate-all --force

        #sudo dnf install rpmfusion-nonfree-release-tainted
        #sudo sh -c 'echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod'
        #sudo dnf swap akmod-nvidia akmod-nvidia-open
        #sudo akmods --rebuild --force
        #sudo dracut --regenerate-all --force

    else
        echo "Unkown error has occurred."
    fi
}

install_nvidia
