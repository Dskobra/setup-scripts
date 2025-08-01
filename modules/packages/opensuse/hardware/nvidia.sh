#!/usr/bin/bash

install_nvidia(){
    if [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n  install openSUSE-repos-Slowroll-NVIDIA
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install openSUSE-repos-Tumbleweed-NVIDIA
    else
        echo "Unfortunately, '$DISTRO $VERSION_ID' is not a supported distro."
    fi
    sudo zypper --gpg-auto-import-keys ref
    sudo zypper -n dup --auto-agree-with-licenses
    sudo zypper -n install --auto-agree-with-licenses nvidia-open-driver-G06-signed-kmp-meta nvidia-open-driver-G06-signed-kmp-default \
    nvidia-open-driver-G06-signed-kmp-longterm nvidia-settings
    sudo dracut --regenerate-all --force

}

install_nvidia
