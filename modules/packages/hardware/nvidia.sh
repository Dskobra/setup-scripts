#!/usr/bin/bash

install_nvidia(){
    if [ "$DISTRO" == "fedora" ]
    then
        #sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda nvidia-settings
        #Use open kernel modules
        sudo dnf install -y rpmfusion-nonfree-release-tainted
        sudo dnf install -y akmod-nvidia-open kmod-nvidia-open nvidia-settings
        sudo akmods --rebuild --force
        sudo dracut --regenerate-all --force
        #xdg-open https://rpmfusion.org/Howto/NVIDIA?highlight=%28%5CbCategoryHowto%5Cb%29#Installing_the_drivers
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then
        #this is for enabling the official repos and closed drivers from nvidia by installing the patterns 
        #package. Packages here require accepting a license agreement.

        #sudo zypper -n install openSUSE-repos-Tumbleweed-NVIDIA
        #sudo zypper -n install openSUSE-repos-Slowroll-NVIDIA
        #sudo zypper --gpg-auto-import-keys ref
        #sudo zypper -n install --auto-agree-with-licenses nvidia-video-G06 nvidia-settings nvidia-modprobe


        #xdg-open "$SCRIPTS_FOLDER"/modules/packages/hardware/nvidia.txt
        #xdg-open "https://en.opensuse.org/SDB:NVIDIA_drivers#Via_YaST_(for_Leap_and_Tumbleweed)"

        # some weird bug MicroOS patterns are selected by default on tumbleweed. To be safe remove/lock them all.
        sudo zypper rm openSUSE-repos-MicroOS-NVIDIA openSUSE-repos-Tumbleweed-NVIDIA openSUSE-repos-Slowroll-NVIDIA
        sudo zypper al openSUSE-repos-MicroOS-NVIDIA openSUSE-repos-Tumbleweed-NVIDIA openSUSE-repos-Slowroll-NVIDIA

        # also install module for lts kernel support for safety.
        sudo zypper -n install nvidia-open-driver-G06-signed-kmp-default nvidia-open-driver-G06-signed-kmp-longterm\
        nvidia-settings nvidia-modprobe
    else
        echo "Unkown error has occurred."
    fi
}

install_nvidia