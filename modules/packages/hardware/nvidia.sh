#!/usr/bin/bash

install_nvidia(){
    if [ "$DISTRO" == "fedora" ]
    then
        sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda nvidia-xconfig nvidia-settings
        sudo akmods --rebuild --force
        sudo dracut --regenerate-all --force
        xdg-open https://rpmfusion.org/Howto/NVIDIA?highlight=%28%5CbCategoryHowto%5Cb%29#Installing_the_drivers
    elif [ "$DISTRO" == "opensuse-tumbleweed" ] || [ "$DISTRO" == "opensuse-slowroll" ]
    then

        xdg-open "$SCRIPTS_FOLDER"/modules/packages/hardware/nvidia.txt
        xdg-open "https://en.opensuse.org/SDB:NVIDIA_drivers#Via_YaST_(for_Leap_and_Tumbleweed)"
    else
        echo "Unkown error has occurred."
    fi
}

install_nvidia