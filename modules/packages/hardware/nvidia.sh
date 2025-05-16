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
        sudo dnf swap akmod-nvidia akmod-nvidia-open
        sudo akmods --rebuild --force
        sudo dracut --regenerate-all --force

    else
        echo "Unkown error has occurred."
    fi
}

if [ "$1" == "standard" ]
then
    install_nvidia
elif [ "$1" == "open" ]
then
    install_nvidia_open
else
    echo "error"
fi
