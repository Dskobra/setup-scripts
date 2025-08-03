#!/usr/bin/bash

install_nvidia(){
    if [ "$DISTRO" == "opensuse-slowroll" ]
    then
        sudo zypper -n  install openSUSE-repos-Slowroll-NVIDIA
    elif [ "$DISTRO" == "opensuse-tumbleweed" ]
    then
        sudo zypper -n install openSUSE-repos-Tumbleweed-NVIDIA
    else
        echo "Error has occured."
    fi
    # Currently opensuse auto installs on fresh installs the nvidia-open-driver-G06-signed-kmp-meta package which
    # is out of date and prevents the rest of nvidia packages from installing. So clear nvidia packages out first.
    sudo zypper -n rm nvidia*
    # note on tumbleweed it likes to add MicroOS repos for nvidia for some reason. Slowroll
    # also had a bug in july where it added leap repos. So just put a lock.
    sudo zypper al openSUSE-repos-MicroOS-NVIDIA openSUSE-repos-Leap-NVIDIA openSUSE-repos-MicroOS
    sudo zypper --gpg-auto-import-keys ref
    sudo zypper -n dup --auto-agree-with-licenses
    sudo zypper -n install --auto-agree-with-licenses nvidia-open-driver-G06-signed-kmp-default \
    nvidia-open-driver-G06-signed-kmp-longterm nvidia-userspace-meta-G06 nvidia-settings
    sudo dracut --regenerate-all --force

}

install_nvidia
