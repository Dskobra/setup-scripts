#!/usr/bin/bash

install_nvidia(){
    #this is for enabling the official repos and closed drivers from nvidia by installing the patterns
    #package. Packages here require accepting a license agreement.

    # run zypper dup first as it should auto install the nvidia open kernel driver
    sudo zypper -n  install openSUSE-repos-Slowroll-NVIDIA
    sudo zypper -n dup
    sudo zypper --gpg-auto-import-keys ref
    # also install lts kernel driver as backup
    sudo zypper -n install --auto-agree-with-licenses nvidia-video-G06 nvidia-settings nvidia-modprobe \
    nvidia-userspace-meta-G06 nvidia-open-driver-G06-signed-kmp-longterm libnvidia-egl-x111-32bit \
    libnvidia-egl-wayland1-32bit libnvidia-egl-gbm1-32bit
    sudo zypper install-new-recommends --repo repo-non-free
}

install_nvidia


