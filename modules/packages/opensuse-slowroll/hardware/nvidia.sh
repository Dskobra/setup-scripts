#!/usr/bin/bash

install_nvidia(){
    sudo zypper -n  install openSUSE-repos-Slowroll-NVIDIA
    sudo zypper --gpg-auto-import-keys ref
    sudo zypper -n dup --auto-agree-with-licenses
    sudo zypper -n install --auto-agree-with-licenses nvidia-open-driver-G06-signed-kmp-longterm nvidia-video-G06 \
    nvidia-userspace-meta-G06 nvidia-persistenced nvidia-modprobe nvidia-gl-G06 nvidia-compute-utils-G06 \
    nvidia-compute-G06 nvidia-common-G06 libnvidia-egl-x111 libnvidia-egl-wayland1 libnvidia-egl-gbm1 libOpenCL1 \
    clinfo nvidia-settings
    sudo dracut --regenerate-all --force
}

install_nvidia


